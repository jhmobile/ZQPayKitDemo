buildNumber=$1

#git checkout master
#git checkout -- .
#git pull origin master

/usr/local/bin/pod install

workspacePath="$(pwd)"
infoPlistPath="${workspacePath}/ZQPayKitDemo/Info.plist"
archivePath="${workspacePath}/archives"
ipaPath="${workspacePath}/ipas"

/usr/libexec/PlistBuddy -c "set CFBundleShortVersionString 1.0.0" ${infoPlistPath}
version=$(/usr/libexec/PlistBuddy -c "print CFBundleShortVersionString" ${infoPlistPath})
outputPackageSuffix="${version}.${buildNumber}"
outputPackage="yunmatong-inHouse-${outputPackageSuffix}"

teamID="8YNFJPM5V2"

bundleID="com.jinhui365.inHouse-yunmatong"

codeSignIdentity="iPhone Distribution: jinhui financial Co,.ltd"
provisionName="Profile_In_House_yunmatong"
provisionUUID="9fc65d07-08fa-4941-9f0a-1bdf3f3e71e2"

/usr/libexec/PlistBuddy -c "set CFBundleIdentifier ${bundleID}" ${infoPlistPath}
/usr/libexec/PlistBuddy -c "set CFBundleVersion ${outputPackageSuffix}" ${infoPlistPath}
/usr/libexec/PlistBuddy -c "set CFBundleDisplayName 证联支付SDK" ${infoPlistPath}

rm -r ${archivePath}
rm -r ${ipaPath}

mkdir ${archivePath}
mkdir ${ipaPath}

# 命令行解锁keychain好像不管用，hudson的slave上，login.keychain不能锁定，否则ipa无法签名，上传失败
security unlock-keychain -p "123456" ~/Library/Keychains/login.keychain
sed -i '' 's/ProvisioningStyle = Automatic;/ProvisioningStyle = Manual;/' ZQPayKitDemo.xcodeproj/project.pbxproj
sed -i "" "s/PROVISIONING_PROFILE = \".\";/PROVISIONING_PROFILE = \"${provisionUUID}\";/g" ZQPayKitDemo.xcodeproj/project.pbxproj
sed -i "" "s/PROVISIONING_PROFILE_SPECIFIER = .;/PROVISIONING_PROFILE_SPECIFIER = \"${provisionUUID}\";/g" ZQPayKitDemo.xcodeproj/project.pbxproj
sed -i "" "s/CODE_SIGN_IDENTITY = \".\";/CODE_SIGN_IDENTITY = \"${codeSignIdentity}\";/g" ZQPayKitDemo.xcodeproj/project.pbxproj
sed -i "" "s/\"CODE_SIGN_IDENTITY[sdk=iphoneos*]\" = \".\";/\"CODE_SIGN_IDENTITY[sdk=iphoneos*]\" = \"${codeSignIdentity}\";/g" ZQPayKitDemo.xcodeproj/project.pbxproj
sed -i "" "s/PRODUCT_BUNDLE_IDENTIFIER = \".\";/PRODUCT_BUNDLE_IDENTIFIER = \"${bundleID}\";/g" ZQPayKitDemo.xcodeproj/project.pbxproj
# clean
xcodebuild -workspace "ZQPayKitDemo.xcworkspace" -scheme "ZQPayKitDemo" clean

# archive
xcodebuild archive -workspace "ZQPayKitDemo.xcworkspace" -scheme "ZQPayKitDemo" -configuration Release -sdk iphoneos APP_BUNDLEID="${bundleID}" APP_PROFILE="${provisionUUID}" -archivePath "${archivePath}/${outputPackage}.xcarchive" DEVELOPMENT_TEAM="${teamID}"
# APP_BUNDLEID 作为环境变量传递给命令行，xcode的build settings里的product bundle identifier项使用了这一变量

# export
xcodebuild -exportArchive -archivePath "${archivePath}/${outputPackage}.xcarchive" -exportPath "${ipaPath}" -exportOptionsPlist "${workspacePath}/EnterpriseExportOptions-ymt.plist"

# 重命名ipa
cd /"${ipaPath}"
mv "ZQPayKitDemo.ipa" "${outputPackage}.ipa"
cd /"${workspacePath}"

echo "***************upload ipa***************"
echo "uploadFilePath     : ${ipaPath}/${outputPackage}.ipa"

fir publish "${ipaPath}/${outputPackage}.ipa"

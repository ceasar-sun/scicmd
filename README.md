# scicmd
NCHC scidm command tools

## 說明
scicmd 為提供 Debian-liked Linux 環境下之 Scidm 資料平台使用者，整合多項功能之命令列工具包。主要提供：
  * 整合 TWCC s3fs ：無需申請，及即可快速使用由 TWCC s3 服務所提供之 Scidm 開放唯讀空間，並設定自動掛載，提供使用者重複使用之便利性
    * 此功能僅限於 TWCC VM/container 網域下
  * 批次下載指定資料集：提供平台上之「完全開放」類型之資料集批次下載功能；若為以下三種資料類性，則需確認完成相關審核或同意程序，並配合使用者之 api key 
    * 需簽署同意授權
    * 需審核通過
    * 需扣點
  * 自主程式更新
  * 其他：開發中

目前支援 Linux 版本有：
  * Ubuntu 20.04 , 18.04
  * Debian 10

## Install
 ```
 $ wget http://scidm.nchc.org.tw/scicmd-installer -O scicmd-installer
 $ chmod +x scicmd-installer
 $ ./scicmd-installer
 ```
## Usage
 ```
 scicmd <function> [opt]

 S3fs function:
   s3fs-pub <bucket>    : Setup public read-only s3fs with automount
   s3fs-priv <bucket>   : ! Not imppiment yet; Setup writable s3fs with automount
   s3fs-purge           : ! Not imppiment yet; Please use 'sudo umount' manually
 ** <bucket> name or with path in bk, such as: 'bk-name' or 'nk-name:/path/more'

 Dump function:
   dump <dataset> [opts]: Dump datasets
     -a api-key         : user's api key in CKAN site
     -r ckan-site       : use NCHC Scidm(https://scidm.nchc.org.tw) as default
     -d dump-folder     : use '~/my-scidata.rep' as default

 Others:
   initenv      : Install and initialize for environment for scicmd tool
   update       : Update Scicmd packeage
   help         : Print this help menu
 ```

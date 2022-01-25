# Covid19-Japan

## 概要
累計の感染者数と累計のPCR数、重症者数などをホーム画面に表示。健康チェックと都道府県別の感染者数、PCR数、死者数を調べることができるアプリです。

![](https://user-images.githubusercontent.com/70003919/150976860-043ba3c3-97dd-4922-83b7-e0574ff78906.png)
![](https://user-images.githubusercontent.com/70003919/150977029-7dc01de6-b16e-4932-81f0-1b31b5dc37d5.png)
![](https://user-images.githubusercontent.com/70003919/150977112-cd702137-a55b-41a0-abe2-571978dc18ea.png)

## 使用した技術
- Swift5
- CocoaPod
  - CalculateCalendarLogic
  - Charts
  - FSCalendar
  - PKHUD
- [COVID-19 Japan Web API](https://documenter.getpostman.com/view/9215231/SzYaWe6h)

## 目指した課題解決
新型コロナウイルスの情報は、今日の感染者数だけ毎日のように報道されるが、累計死者数や重症者数に関してはあまり触れられていないと日々の生活で感じ、簡単にその情報が取得できるようになればいいなと考え開発を始めました。

## AppStoreからのリジェクトとその理由
アプリが完成し、AppStoreに提出しようとしたらリジェクトされました。そのリジェクト内容は,「Per section 5.1.1 (ix) of the App Store Review Guidelines」。このリジェクトからAppStoreに提出することができず、iOSでは本アプリはリリースできない結果となりました。

リジェクトの詳細な内容に関しては、Qiitaで記事にしました。

https://qiita.com/KaitoMuraoka/items/fbd79f65b1e25dfc17d4

### この経験から得たもの
この開発から、APIの使いかた。FSCalendarとCharts、PKHUDの使い方を学びました。

また、リリースができなくても、開発中で何か得られたものはないかを考え、見つけ出すことの大切さを学びました。

## 今後の予定
Qiitaのコメントから「AndroidやPWAアプリでリリースしてはどうか？」という助言をいただきました。

調べたところ、Androidでは[新型コロナウイルス感染症 2019(COVID-19)アプリの要件](https://support.google.com/googleplay/android-developer/answer/9889712?hl=ja)から、iOSと同様にアプリのリリースが難しいことがわかります。よって、iOS、Android共にリリースは不可能です。

なので、PWAアプリならリリースすることが可能なので、今後、PWAアプリとしての開発を視野に入れています。具体的には、Flutterを使ったPWAアプリを作ることができるようなので、それを利用して開発を今後してみたいと考えています。


## プライバシーポリシー
プライバシーポリシーは[こちらより](https://kaitomuraoka.github.io/Covid19-Japan/)参照してください

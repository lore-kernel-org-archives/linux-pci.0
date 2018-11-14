Return-Path: <SRS0=Q3Ib=NZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A7F7C43441
	for <linux-pci@archiver.kernel.org>; Wed, 14 Nov 2018 19:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCA3F22419
	for <linux-pci@archiver.kernel.org>; Wed, 14 Nov 2018 19:44:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=impinj.com header.i=@impinj.com header.b="QLTV+S+Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCA3F22419
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=impinj.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725791AbeKOFsv (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 15 Nov 2018 00:48:51 -0500
Received: from mail-eopbgr770134.outbound.protection.outlook.com ([40.107.77.134]:61305
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725766AbeKOFsv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Nov 2018 00:48:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=impinj.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=05FZDwbsLFlwcQ3AeP4jhbqcdeosBdGKRZsheZeAnbI=;
 b=QLTV+S+QAnAiFXduTAdmYXRsmzSdQiISqeBwNLkikGMSmB1b1dHVDFovDSrlA3QQauXLyBiT8d0NUZShMAv7rAqaFWkeOl5Rv7zyeiPfF2HbkypYubxjOHpgQQG9zuiztBShcmWJRjkQegfoxpxAaUJZ93+OO4/mB/q8zUlczow=
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com (10.167.236.38) by
 MWHPR0601MB3675.namprd06.prod.outlook.com (10.167.236.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.27; Wed, 14 Nov 2018 19:44:02 +0000
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::f51a:d8dd:1aad:3bf9]) by MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::f51a:d8dd:1aad:3bf9%3]) with mapi id 15.20.1294.045; Wed, 14 Nov 2018
 19:44:01 +0000
From:   Trent Piepho <tpiepho@impinj.com>
To:     "stefan@agner.ch" <stefan@agner.ch>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>
Subject: Re: [PATCH] PCI: dwc: Limit config space size for i.MX6
Thread-Topic: [PATCH] PCI: dwc: Limit config space size for i.MX6
Thread-Index: AQHUfDGaNaKS20SjpkOT2QrUGo/m36VPrGWA
Date:   Wed, 14 Nov 2018 19:44:01 +0000
Message-ID: <1542224641.30311.478.camel@impinj.com>
References: <20181019111350.6170-1-stefan@agner.ch>
         <40d0c27d612534033d146497029b1922@agner.ch>
In-Reply-To: <40d0c27d612534033d146497029b1922@agner.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [216.207.205.253]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR0601MB3675;6:XMnsDf26tNo7DsOYoPtjPS9O5AKrfuK9VQz0j0mHulStCUWHiR9Fnj5vZF2HfVgDfNp4XkgXRKcKbWz6sjyDqiACRakgh1oNUBldMoRhxxmE38NoUw2hQ0T3sxjmlN9x6B/vNxxtxjgMMiGUGO2Y9GpUPUSE52PBPpRgsHLt+CHr8B+IfKrxlD0d2z93xPiCdTTjvMeaQUeCmFNiw8fhTkPFK21bsAuVu+XVJQc22R71X0qOZFpA3JbV34t9DGNd/34kvu5aM9B8JRv7+IlMIwiriENnljwerTvadSyoGpXqOo/XeAJx1yDoEDfZaa5mjBeOZEN2KYBcpGtsZTZWI4u8myHPR8+ytjKDzD2t5WiT2lxjl9cuaO7IiWOy8/1lPV3DbI7We8K9thwrFjMQAaEwsBNdrxf+v/eEQZbg8tG0SNtO1yyiXY/WZhKGk3l3teTUUX7xpNCp+abbLdt0aw==;5:riWtrnZqa4THM5bQwtq9nArcqZ8cUpOCF2GKIxe9ip9JAtUPSsIIOJ1tWIUq0+/gz+0A0slt2Y9IISTh9mJSaIDGpbCA4sVQ0e/aZpwo6GTeQyRtyeuXTiz05o7ErDzAJswvY3D00wgSuXd75HAenXTxvDdLWtermMrwi28TpFw=;7:8MlqGyRFyV0AxFmJ2Ke8Tc5hwWt/OkZpfhwoSNjSXuk+IphMwuvl98lB7YmmqYc6i05UoFAtmVQ1ObuvVTBE1sZnjyCfj+UAmHLV1CLnesJdhYmBIGLvnzK5NVaMj+qZ0RlVu+g4CRWl436DAg3BzA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 8e81e434-3525-4ec7-1fe5-08d64a698724
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR0601MB3675;
x-ms-traffictypediagnostic: MWHPR0601MB3675:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tpiepho@impinj.com; 
x-microsoft-antispam-prvs: <MWHPR0601MB36754B020B8A3442ADDF7649D3C30@MWHPR0601MB3675.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231415)(944501410)(52105112)(10201501046)(93006095)(93001095)(3002001)(148016)(149066)(150057)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:MWHPR0601MB3675;BCL:0;PCL:0;RULEID:;SRVR:MWHPR0601MB3675;
x-forefront-prvs: 085634EFF4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(376002)(136003)(366004)(39850400004)(396003)(346002)(199004)(189003)(14454004)(66066001)(229853002)(2900100001)(476003)(2906002)(446003)(11346002)(14444005)(2616005)(478600001)(6486002)(99286004)(2201001)(7736002)(76176011)(86362001)(575784001)(5660300001)(8936002)(486006)(2501003)(3846002)(39060400002)(6116002)(316002)(25786009)(106356001)(4326008)(186003)(6512007)(103116003)(102836004)(53936002)(68736007)(36756003)(8676002)(110136005)(305945005)(81166006)(256004)(97736004)(81156014)(105586002)(54906003)(6246003)(6436002)(71190400001)(53546011)(71200400001)(4001150100001)(26005)(6506007)(505234006)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR0601MB3675;H:MWHPR0601MB3708.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: impinj.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ZFvrx6ige4MyX3K6+oViVZAW4uTHLPrjrz6BID7Z69F5CgbgpK+00GosaEQhtFNQ3t14xUwbRd1IHR3ZCvbyboM0f1pPMYQvugc+/H5DYU0UXoGQEDcQTYdEicMSe96MOIV7Wjoxf7UhE0tfOZBLcFoWmKV+UA7OJSHE/fLGJS+gDVUJzryV3RlAXVHoGXVB2n5Ho2tgjx+fQwHnL1bCyTwZhkJGhwLPBKjXApJGJVPxaUZxDCA3+gstlj8cT50WnjN2lkHZ86Kje7IRqCfhozJYKRSIX1szIzEHDyq5dYyYTkZdgcHKR7TJbx+TJ1qk9FMme+SWlwBwfo9esrGrHZRB8abnYiZwiC79eqfQ494=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <2F02AF5CB99EE049A3412996D35EAF30@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: impinj.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e81e434-3525-4ec7-1fe5-08d64a698724
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2018 19:44:01.7646
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6de70f0f-7357-4529-a415-d8cbb7e93e5e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0601MB3675
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gV2VkLCAyMDE4LTExLTE0IGF0IDE2OjQ5ICswMTAwLCBTdGVmYW4gQWduZXIgd3JvdGU6DQo+
IE9uIDE5LjEwLjIwMTggMTM6MTMsIFN0ZWZhbiBBZ25lciB3cm90ZToNCj4gPiBSZWFkaW5nIHRo
ZSBmdWxsIDRrIGNvbmZpZyBzcGFjZSB0aHJvdWdoIHN5c2ZzIGxlYWRzIHRvIGFuDQo+ID4gZXh0
ZXJuYWwgYWJvcnQuIFRlc3Rpbmcgb24gYSBwbGF0Zm9ybSBzaG93ZWQgdGhhdCB0aGUgdXBwZXIN
Cj4gPiBsaW1pdCBpcyA1MTIuIExpbWl0IGNvbmZpZyBzcGFjZSB0byA1MTIuDQo+IA0KPiBBbnkg
Y29tbWVudCBvbiB0aGlzIHBhdGNoPw0KPiANCj4gU2luY2Ugb3RoZXIgZGV2aWNlcyB1c2Ugc2lt
aWxhciBxdWlya3MsIEkgZ3Vlc3MgdGhlIGZpeCBjYW4ndCBiZSBmYXINCj4gb2ZmPw0KPiANCj4g
TWF5YmUgcmVzdHJpY3RpbmcgdG8gdGhlIFBDSSBkZXZpY2UgSUQgdXNlZCBpbiBpLk1YIDYgb25s
eSBpcyB0b28NCj4gcmVzdHJpY3RpdmUsIGJ1dCBJIGd1ZXNzIGJldHRlciByZXN0cmljdGl2ZSBm
b3Igbm93Pw0KDQpUbyB0cmlnZ2VyIHRoaXMgYnVnIEkgc2hvdWxkIHJlYWQgdGhlIHN5c2ZzICJj
b25maWciIGZpbGUgZm9yIHRoZSBQQ0kNCmJyaWRnZSBkZXZpY2U/DQoNClRlc3RlZCBvbiBpbXg3
LCBubyBwcm9ibGVtcy4NCg0KIyBoZXhkdW1wIC1DIC9zeXMvZGV2aWNlcy9wbGF0Zm9ybS9zb2Mv
MzA4MDAwMDAuYWlwcy1idXMvMzM4MDAwMDAucGNpZS9wY2kwMDAwOjAwLzAwMDA6MDA6MDAuMC9j
b25maWcgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIA0KW3N0dWZmXQ0KMDAwMDAxMzAgIDAwIDAwIDAwIDAw
IDAwIDAwIDAwIDAwICAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAgfC4uLi4uLi4uLi4uLi4uLi58
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIA0KKiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIA0KMDAwMDA0MDAgIGZmIGZmIGZmIGZmIGZmIGZmIGZmIGZm
ICBmZiBmZiBmZiBmZiBmZiBmZiBmZiBmZiAgfC4uLi4uLi4uLi4uLi4uLi58ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIA0KKiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIA0KMDAwMDA3MDAgIDc2IDAwIDYzIDAxIGZmIGZmIGZmIGZmICAwNCAwMCAwMCAw
NyAwMCBmMCBmMCAxYiAgfHYuYy4uLi4uLi4uLi4uLi58ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgDQpbbW9yZSBzdHVmZl0NCg0KVGhlIGJyaWRnZSBvbiBpbXg3ZCBpcyAxNmMzOmFiY2QsIHNh
bWUgYXMgcGF0Y2ggSSBiZWxpZXZlLiAgSSBkbyBoYXZlIGENCnBjaS1lIGRldmljZSBjb25uZWN0
ZWQsIHVubGlrZSB0aGUgb3JpZ2luYWwgYnVnLiAgTWF5YmUgdGhhdCBpcw0KcmVsYXRlZD8gIE9y
IG1heWJlIHRoaXMgcHJvYmxlbSBpcyBmaXhlZCBpbiBpbXg3ZD8NCg0KPiA+ICANCj4gPiAgI2Rl
ZmluZSBQQ0lfVkVORE9SX0lEX1NZTk9QU1lTCQkweDE2YzMNCj4gPiArI2RlZmluZSBQQ0lfREVW
SUNFX0lEX1NZTk9QU1lTX0lNWDYJMHhhYmNkDQo+ID4gIA0KPiA+ICAjZGVmaW5lIFBDSV9WRU5E
T1JfSURfVklURVNTRQkJMHgxNzI1DQo+ID4gICNkZWZpbmUgUENJX0RFVklDRV9JRF9WSVRFU1NF
X1ZTQzcxNzQJMHg3MTc0

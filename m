Return-Path: <SRS0=4GJS=N7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 988DCC43441
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 01:33:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5233A20870
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 01:33:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=impinj.com header.i=@impinj.com header.b="bxZJdZWO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5233A20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=impinj.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732525AbeKTMAR (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 20 Nov 2018 07:00:17 -0500
Received: from mail-eopbgr780109.outbound.protection.outlook.com ([40.107.78.109]:41376
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726119AbeKTMAR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Nov 2018 07:00:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=impinj.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tZtcE1DUJh0hLFiUZCEjAMx4RsBHscpfLE/bEx5KdZY=;
 b=bxZJdZWOSKl5A1GUSpo1pzrBu7UV6Wq8UYEQYqiDsoH+JQm+6laoJSIYGgJihB/7kBiDrD4WwvUd9+IeYpjTtoKkn84P4iLOONtHPeJMIC1onPwq/LdES6G92kRmtPfYG0+3EbDgPk8AtQVxklu19a4G4UUN7YyBa6eyGLFefFA=
Received: from CY4PR0601MB3697.namprd06.prod.outlook.com (52.132.101.36) by
 CY4PR0601MB3585.namprd06.prod.outlook.com (52.132.100.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.29; Tue, 20 Nov 2018 01:33:41 +0000
Received: from CY4PR0601MB3697.namprd06.prod.outlook.com
 ([fe80::c090:3ad2:d81c:8407]) by CY4PR0601MB3697.namprd06.prod.outlook.com
 ([fe80::c090:3ad2:d81c:8407%5]) with mapi id 15.20.1294.048; Tue, 20 Nov 2018
 01:33:41 +0000
From:   Trent Piepho <tpiepho@impinj.com>
To:     "stefan@agner.ch" <stefan@agner.ch>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>
Subject: Re: [PATCH 2/2] PCI: imx6: limit DBI register length
Thread-Topic: [PATCH 2/2] PCI: imx6: limit DBI register length
Thread-Index: AQHUf+wekJAOTeBt1UC5el66NNl6l6VX4kkA
Date:   Tue, 20 Nov 2018 01:33:41 +0000
Message-ID: <1542677620.30311.589.camel@impinj.com>
References: <20181119094144.4127-1-stefan@agner.ch>
         <20181119094144.4127-2-stefan@agner.ch>
In-Reply-To: <20181119094144.4127-2-stefan@agner.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tpiepho@impinj.com; 
x-originating-ip: [216.207.205.253]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR0601MB3585;6:aPVDds+MESSMwG9E0+326pkdAyXdvTEWkHIU8lwqtWuanPHxvMiXpfK69iSPukd4mRD/BriEFdu7XB2wv5A1UGTkwyWwi5QiWhggd0vyOFpPnkymqgM8mY6fbseEtYZI37Xnj+ag4/9kMwEOYE5+sp0RaTeT0lN39HpM9syFIf268y0pfTELl0rmKTGHfcEk8FpVroycH8nsSoYVpeLy6q9qh8w4QCjMpbsdReo58FO6yv+uhGvqt4MqssJm6iTXi8mfutCSGlEmooTvdXyDmckpC0WAlwLGtufMEGT/qfIeh53bJLuqAPqcnAkssEBtjhB3mK/fLjPobb6Pe4tuRFx+hCmX/irn8VK/PnkgzmWC6Yl/aSR/FdgXOCxg9+4VsZbliMmFPfU+5lCSaEvObe2MuxYEiQO/WF+nxrapDKfFXlCXlGln/eS0mXTgRNvja+hKg3c+k4uasn4LJr9++w==;5:spl1TQRStXb8yctCCqnuglgB26X4P88koGo5eNjD9fYzUOJpzGeO0qV/DeeMXBkQJPH9+UaENHICCb3fpoIgzJdgbSsm7BJO/NMLaepGy5IFhZz0upfZr4XLNpXngDY/enFRGg2FwVvfggb8TvrQAdDBKnz25Mei2qLGJ+98rqw=;7:SMtqEoPdzX3XPxaLf/t0SVrE9iqw+plnrL55AgCkI0E64A5Qk0Fyn60RhiSw7DgrSSaVcee6SSXi0rCy1s+azSt6EjoR26Q3HhhEQtvWETfo5/gIM0YAk6JvRVP+afbXB4QPzmTwPwSvA7U1pXQ/Pw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: f979fcf8-8f76-40ab-38f8-08d64e8833d5
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:CY4PR0601MB3585;
x-ms-traffictypediagnostic: CY4PR0601MB3585:
x-microsoft-antispam-prvs: <CY4PR0601MB3585541486EF41D63D37436CD3D90@CY4PR0601MB3585.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231442)(944501410)(52105112)(10201501046)(3002001)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:CY4PR0601MB3585;BCL:0;PCL:0;RULEID:;SRVR:CY4PR0601MB3585;
x-forefront-prvs: 08626BE3A5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39850400004)(366004)(136003)(376002)(346002)(199004)(189003)(8676002)(478600001)(81166006)(229853002)(8936002)(5660300001)(97736004)(4001150100001)(256004)(2501003)(36756003)(6436002)(446003)(7736002)(305945005)(39060400002)(11346002)(486006)(81156014)(25786009)(476003)(2616005)(4326008)(53936002)(6246003)(3846002)(6116002)(2906002)(6486002)(68736007)(6512007)(316002)(71200400001)(110136005)(86362001)(26005)(99286004)(6506007)(71190400001)(105586002)(2900100001)(102836004)(54906003)(106356001)(186003)(66066001)(14454004)(103116003)(2201001)(76176011);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR0601MB3585;H:CY4PR0601MB3697.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: impinj.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: EPWelmOjaHDiTKZ8HxEvSN062f4Wd541TiO2cmru0A4tmYJ8uR22RRYMXqV1FH1Ot8kiBxmPhrEU5bqXUag8vF/uLlGOlbpe1OSJS1qkPKtQsGDeyngx5bztoX3mG8w/yFnY86KoQ9twxkgaNXxsvQlcb+hpqaXVRQ1s9A0qJ6zNELDVzEkxt962I+S6Uu9vorLeuRG4xlw/8nJfU54mJa4s4krZziZ5F0XGBwJgsv4Dfz4SBM6e0s6UAnF6He7cwQ0j3YsSIB1ZrU4mx8VtagnYuFCpVmO/jxH+MXY5ZGqKzSbO+aLgGFzAVkCCSL57FTcF8v07vcifsPetC/XV1nFSQbEVw2XxL9+SH/ML6TE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <397B3FDFC7CCB44D9F7ADC0353EA0472@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: impinj.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f979fcf8-8f76-40ab-38f8-08d64e8833d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2018 01:33:41.0384
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6de70f0f-7357-4529-a415-d8cbb7e93e5e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0601MB3585
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gTW9uLCAyMDE4LTExLTE5IGF0IDEwOjQxICswMTAwLCBTdGVmYW4gQWduZXIgd3JvdGU6DQo+
IA0KPiAgDQo+ICtzdGF0aWMgY29uc3Qgc3RydWN0IGlteDZfcGNpZV9kcnZkYXRhIGlteDZxX3Bj
aWVfZHJ2ZGF0YSA9IHsNCj4gKwkudmFyaWFudCA9IElNWDZRLA0KPiArCS5kYmlfbGVuZ3RoID0g
MHgxNWMsDQo+ICt9Ow0KPiArDQo+ICtzdGF0aWMgY29uc3Qgc3RydWN0IGlteDZfcGNpZV9kcnZk
YXRhIGlteDZzeF9wY2llX2RydmRhdGEgPSB7DQo+ICsJLnZhcmlhbnQgPSBJTVg2U1gsDQo+ICt9
Ow0KPiArDQo+ICtzdGF0aWMgY29uc3Qgc3RydWN0IGlteDZfcGNpZV9kcnZkYXRhIGlteDZxcF9w
Y2llX2RydmRhdGEgPSB7DQo+ICsJLnZhcmlhbnQgPSBJTVg2UVAsDQo+ICt9Ow0KPiArDQo+ICtz
dGF0aWMgY29uc3Qgc3RydWN0IGlteDZfcGNpZV9kcnZkYXRhIGlteDdkX3BjaWVfZHJ2ZGF0YSA9
IHsNCj4gKwkudmFyaWFudCA9IElNWDdELA0KPiArfTsNCj4gKw0KPiAgc3RhdGljIGNvbnN0IHN0
cnVjdCBvZl9kZXZpY2VfaWQgaW14Nl9wY2llX29mX21hdGNoW10gPSB7DQo+IC0JeyAuY29tcGF0
aWJsZSA9ICJmc2wsaW14NnEtcGNpZSIsICAuZGF0YSA9ICh2b2lkICopSU1YNlEsICB9LA0KPiAt
CXsgLmNvbXBhdGlibGUgPSAiZnNsLGlteDZzeC1wY2llIiwgLmRhdGEgPSAodm9pZCAqKUlNWDZT
WCwgfSwNCj4gLQl7IC5jb21wYXRpYmxlID0gImZzbCxpbXg2cXAtcGNpZSIsIC5kYXRhID0gKHZv
aWQgKilJTVg2UVAsIH0sDQo+IC0JeyAuY29tcGF0aWJsZSA9ICJmc2wsaW14N2QtcGNpZSIsICAu
ZGF0YSA9ICh2b2lkICopSU1YN0QsICB9LA0KPiArCXsgLmNvbXBhdGlibGUgPSAiZnNsLGlteDZx
LXBjaWUiLCAgLmRhdGEgPSAmaW14NnFfcGNpZV9kcnZkYXRhLCAgfSwNCj4gKwl7IC5jb21wYXRp
YmxlID0gImZzbCxpbXg2c3gtcGNpZSIsIC5kYXRhID0gJmlteDZzeF9wY2llX2RydmRhdGEsIH0s
DQo+ICsJeyAuY29tcGF0aWJsZSA9ICJmc2wsaW14NnFwLXBjaWUiLCAuZGF0YSA9ICZpbXg2cXBf
cGNpZV9kcnZkYXRhLCB9LA0KPiArCXsgLmNvbXBhdGlibGUgPSAiZnNsLGlteDdkLXBjaWUiLCAg
LmRhdGEgPSAmaW14N2RfcGNpZV9kcnZkYXRhLCAgfSwNCj4gIAl7fSwNCj4gIH07DQoNCkluc3Rl
YWQgb2YgbWFraW5nIGEgc2luZ2xlIGRydmRhdGEgc3RydWN0IGZvciBlYWNoIHR5cGUsIHRoaXMg
Y291bGQgdXNlDQphbiBhcnJheToNCg0Kc3RhdGljIGNvbnN0IHN0cnVjdCBpbXg2X3BjaWVfZHJ2
ZGF0YSBkcnZkYXRhW10gPSB7DQoJW0lNWDZRXSAgPSB7IC52YXJpYW50ID0gSU1YNlEsIC5kYmlf
bGVuZ3RoID0gMHgxNWMgfSwNCglbSU1YNlNYXSA9IHsgLnZhcmlhbnQgPSBJTVg2U1ggfSwNCglb
Li4uXQ0KfTsNCg0Kc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgaW14Nl9wY2llX29m
X21hdGNoW10gPSB7DQoJeyAuY29tcGF0aWJsZSA9ICJmc2wsaW14NnEtcGNpZSIsICAuZGF0YSA9
ICZkcnZkYXRhW0lNWDZRXSwgfSwNCgl7IC5jb21wYXRpYmxlID0gImZzbCxpbXg2c3gtcGNpZSIs
IC5kYXRhID0gJmRydmRhdGFbSU1YNlNYXSwgfSwNCgkuLi4NCn07DQo=

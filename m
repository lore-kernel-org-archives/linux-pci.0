Return-Path: <SRS0=Nkm2=NM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42990C6786F
	for <linux-pci@archiver.kernel.org>; Thu,  1 Nov 2018 21:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD2F6204FD
	for <linux-pci@archiver.kernel.org>; Thu,  1 Nov 2018 21:35:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=impinj.com header.i=@impinj.com header.b="GVwzS2CI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD2F6204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=impinj.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbeKBGkS (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 2 Nov 2018 02:40:18 -0400
Received: from mail-eopbgr690133.outbound.protection.outlook.com ([40.107.69.133]:6077
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726701AbeKBGkR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 2 Nov 2018 02:40:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=impinj.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UscI8yYdS4RWIFBvIZfR/8JOWERilZzkbIq+vR31Nto=;
 b=GVwzS2CI0Nhsb2GU1/Vk5fbfiw9F/eam7vYbhAKnQsWIz+MOzooigocu4IQCn+moIGKiZlYFq6OmH03G1OSIlcza2dSnw/et1WHqTf4/9wlq1sJqvNf4pfdk+VVurrJLGbPIBJmHfbsyY6xp8dgdPSlNxfp7uTyp1ZFGDNYyKSE=
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com (10.167.236.38) by
 MWHPR0601MB3771.namprd06.prod.outlook.com (10.167.236.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.21; Thu, 1 Nov 2018 21:35:32 +0000
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::f51a:d8dd:1aad:3bf9]) by MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::f51a:d8dd:1aad:3bf9%3]) with mapi id 15.20.1294.024; Thu, 1 Nov 2018
 21:35:32 +0000
From:   Trent Piepho <tpiepho@impinj.com>
To:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "thesven73@gmail.com" <thesven73@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: No interrupt was generated using MSI
Thread-Topic: No interrupt was generated using MSI
Thread-Index: AQHUciorCF62BleFDkSqupekCTk/fqU7cUyA
Date:   Thu, 1 Nov 2018 21:35:31 +0000
Message-ID: <1541108131.30311.181.camel@impinj.com>
References: <20181101213044.27844-1-TheSven73@googlemail.com>
In-Reply-To: <20181101213044.27844-1-TheSven73@googlemail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tpiepho@impinj.com; 
x-originating-ip: [216.207.205.253]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR0601MB3771;6:s0CJNXZUSPwNFOAqAS2w2AL5xH91Ir48AO1L/MrgbmLe0Eodhp4LpEbw/Vd4mumDHQcvKKd2S9deaNqmvR8uTc0bfITMAFza+Laj7LEH2eHda4Eg6MWZ6NUsPdOrx6ecExvNdNgzZUuRDhmepfPn/WwVSMpZDu08GzEL57c2hgOsPjmmATc6ynv3aycZdZrPYuwfoTpT1vNBtTGPLNYSaBPI4j/iMdwT+l58P5NFwfYlGOlEyCj9qgiJ8J3k46wxF6KRU3ula3pAWZUe1qVUPpvOE84ECB6Oe7bzG5mBZNrpM29AXLnE7QcgNwwPNofzFk4zZfSzlCs4ZEeLv1l46L7cFJsAEzRqFHhA0BWajOYtsIz9zeqF1chmQeZkC26iRO4WviCkgtW4OfbTA1suhjrLJh2+juejOu6tJNhwG6SlH9bvVJfKjgFRnOIo4DxZmW8LpEdkkVp1UZfWC0C+Fg==;5:5dmEzbR43XYcfQ0S1QX+V1f6A+LQf8w8R2I7BelK9B0UzrLy85MtfwH7m8V73nJINh6QKtXsIpPA86n4xwEjep1FL38V5C4MH6PnKaZx4ytj9D2X80qSvvLTCqtqgU+bA0Et5jotTGVYgZ2y43G0ugHkVnaGCqYpsRv3xXQ3BgE=;7:whl2Uj5IstGHeyEQgR3zdOk994G5KC6r5x0N2mmixTjy/uMs1y6ep5P7CHwPZaa0o3TcZ41/eeNfeIX8cBk5O6Gi2Sw3D+vHCPbgtwlZAis9s269EENacnxJNltp7Pw/vXRDtwQUGFaJ1WZDxq84RA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 1a5c81eb-3d9a-435b-14c3-08d64041f369
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR0601MB3771;
x-ms-traffictypediagnostic: MWHPR0601MB3771:
x-microsoft-antispam-prvs: <MWHPR0601MB3771665B46E616D9933DF852D3CE0@MWHPR0601MB3771.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231382)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:MWHPR0601MB3771;BCL:0;PCL:0;RULEID:;SRVR:MWHPR0601MB3771;
x-forefront-prvs: 0843C17679
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(376002)(366004)(39850400004)(346002)(136003)(396003)(189003)(199004)(81156014)(6512007)(71190400001)(14444005)(81166006)(71200400001)(256004)(36756003)(76176011)(66066001)(478600001)(53936002)(316002)(2900100001)(105586002)(106356001)(39060400002)(6306002)(8936002)(6246003)(110136005)(476003)(6486002)(14454004)(486006)(186003)(6116002)(2616005)(6436002)(446003)(4326008)(3846002)(11346002)(305945005)(8676002)(68736007)(25786009)(7736002)(2906002)(6506007)(102836004)(229853002)(86362001)(5660300001)(103116003)(2501003)(97736004)(966005)(26005)(99286004)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR0601MB3771;H:MWHPR0601MB3708.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: impinj.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: RAsm7rXnjzGPjwia9FYQHbvlLbzS7nSR+CYYg3uZoWrm44gwfNJFIgtWZQrsYyXeDuuqrwoPcd0WxoESdPkp3CHj/PeSOd27MG6NyACtulJlcwG/ZhcZT2kiPvnApsN5lMbbBH+yjcESlHq8q0Et4Lfu2+PZnw5Fc37QpGJrbRlih7LDT63iMWBfYtYGw6xlajHJFn8v5rn8m1URh3Rhax+Yg7LLAmnLbmsmWkSpuYcaruGpQKJoCHXPy9TnQqyvT8bwd5iziK0dErNppQylwZGUBz/FUOIYDbTIkO5dC+g+tw0sRDqA1KcZttaFsE6oG70rSeMceRgbVNlf20gU5gsaj55ViOayEtyNpMWOXdc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <228E71C8EAF77A459293F3956628603E@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: impinj.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a5c81eb-3d9a-435b-14c3-08d64041f369
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2018 21:35:31.9405
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6de70f0f-7357-4529-a415-d8cbb7e93e5e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0601MB3771
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVGh1LCAyMDE4LTExLTAxIGF0IDE3OjMwIC0wNDAwLCB0aGVzdmVuNzNAZ21haWwuY29tIHdy
b3RlOg0KPiBJIGFtIHNlZWluZyB0aGlzIGluIG15IGtlcm5lbCBsb2c6DQo+IA0KPiBbICAgMTAu
MjM1NjI1XSB0ZzMgMDAwMDowMzowMC4wIGV0aDIwOiBObyBpbnRlcnJ1cHQgd2FzIGdlbmVyYXRl
ZA0KPiB1c2luZyBNU0kuDQo+IAlTd2l0Y2hpbmcgdG8gSU5UeCBtb2RlLiBQbGVhc2UgcmVwb3J0
IHRoaXMgZmFpbHVyZSB0byB0aGUgUENJDQo+IAltYWludGFpbmVyIGFuZCBpbmNsdWRlIHN5c3Rl
bSBjaGlwc2V0IGluZm9ybWF0aW9uDQo+IA0KPiBJIGxvb2tlZCB0aHJvdWdoIE1BSU5UQUlORVJT
LCBidXQgSSBjYW4ndCBmaW5kIHRoZSBQQ0kgbWFpbnRhaW5lci4NCj4gQ2FuIGFueW9uZSBoZWxw
Pw0KPiANCj4gQ2hpcHNldCBpbmZvOiB0aGlzIGhhcHBlbnMgb24gYSBGcmVlc2NhbGUgaS5NWDZR
LiBNYWlubGluZSA0LjE5DQo+IGtlcm5lbC4NCj4gVGhlIGRldmljZXRyZWUgZW50cnkgZm9yIHRo
ZSBwY2llIGNoaXBzZXQgaXMgaGVyZToNCj4gDQo+IGFyY2gvYXJtL2Jvb3QvZHRzL2lteDZxZGwu
ZHRzaToNCj4gDQo+IHBjaWU6IHBjaWVAMWZmYzAwMCB7DQo+IAljb21wYXRpYmxlID0gImZzbCxp
bXg2cS1wY2llIiwgInNucHMsZHctcGNpZSI7DQo+IAk8c25pcD4NCj4gfTsNCg0KSXQgc291bmRz
IGxpa2UgeW91IG1pZ2h0IGJlIGhpdHRpbmcgdGhlIGJ1ZyBJIHBvc3RlZCBhIGZpeCBmb3INCnJl
Y2VudGx5Lg0KDQpodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3BhdGNoLzEwNjU3OTg3Lw0K
DQo=

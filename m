Return-Path: <SRS0=4GJS=N7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D411FC46462
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 20:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71ACF2147A
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 20:12:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=impinj.com header.i=@impinj.com header.b="mzrLz7Yy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71ACF2147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=impinj.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725903AbeKUGnZ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 21 Nov 2018 01:43:25 -0500
Received: from mail-eopbgr710100.outbound.protection.outlook.com ([40.107.71.100]:6759
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725887AbeKUGnY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 21 Nov 2018 01:43:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=impinj.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XM8x+9fYitxHtBSL4g+cZztvWfUbfRtQ7fiHgRh/0r4=;
 b=mzrLz7YyCC5pVxAt1nIWuVZUwFpoZ9mMhf9l4KJvchFyudAyd/2ksHAU/4e1oeqbh7gy9EeRiLzYQQGP9nNiG1XYY00MSGxv19aQ7Tf+lsqDGUX3EiY6x20KV2lHm6AOW/9c9JmZLnYkBW9qI9c8nLF51XLfTDQ9MSOZDv+1baU=
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com (10.167.236.38) by
 MWHPR0601MB3786.namprd06.prod.outlook.com (10.167.236.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.23; Tue, 20 Nov 2018 20:12:27 +0000
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::c0f3:ea8f:48ba:a5d7]) by MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::c0f3:ea8f:48ba:a5d7%4]) with mapi id 15.20.1361.013; Tue, 20 Nov 2018
 20:12:26 +0000
From:   Trent Piepho <tpiepho@impinj.com>
To:     "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>,
        "vidyas@nvidia.com" <vidyas@nvidia.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "mmaddireddy@nvidia.com" <mmaddireddy@nvidia.com>,
        "swarren@nvidia.com" <swarren@nvidia.com>
Subject: Re: [PATCH] PCI: dwc ep: cache config until DBI regs available
Thread-Topic: [PATCH] PCI: dwc ep: cache config until DBI regs available
Thread-Index: AQHUgFb9PVOQzMjPyU+Atke+BX6uHaVY6g8QgAAFsACAACpIAA==
Date:   Tue, 20 Nov 2018 20:12:26 +0000
Message-ID: <1542744746.30311.618.camel@impinj.com>
References: <20181119222602.28001-1-swarren@wwwdotorg.org>
         <BN6PR12MB11714E3FED1EF50D7F3CA3C9B8D90@BN6PR12MB1171.namprd12.prod.outlook.com>
         <921c50a5-35b7-33e7-398b-3c4cacef8529@wwwdotorg.org>
In-Reply-To: <921c50a5-35b7-33e7-398b-3c4cacef8529@wwwdotorg.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [216.207.205.253]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR0601MB3786;6:Ok5KOZIcSktRLOClCMlQldAFB7b9x1KnIPNpFH1GkE2xZboxpTh7UuxJ2uAYiUkxpTc8lVZiyRHyxQLzZAIB+8GyPxgPgF9YSA3QPZoX5VmTUwq9u6WjwdpJnZ70AMy6rMfI8VKzBZcw9oMGZ3JUo2kHX+x+6r//v+Dmgqklgh2b1wqkI6pwRlM1T6reBY97rWNodscthhPOFeuWSf87LqkcptJC/ME15Gts9p9pTK0hinMNdf9sJSqQNc7Cgb10i3o06TunqeOIv88PdhJJlY5naDUHCuMjzu3DjYX4Ryd3JGgvLOmipsie7IEvoaSUv/cgPrFAYNc+bwxGN4y11KB8/wirBak1QE0sXpceUxEASvx4dtI9g1oT4mrF0idOqBJ0ATN4uy/PnYn5ADO+1tnA9KLbcbRteRLbIhNk/6srQweI2uz8VJTHUVCTx0E9C3hF++cGJ3rc6j9B0lnfEQ==;5:HnUwfmpwStpRWVS3gfaIE8ASnsR1NXjOn4AXCT92VYoMFOHkffcxYnxNtkJlaAnzQHI2lLHgc96GJyXW3WcMMXaluAUdKnlRxK1UHyuk/w8yln90uwMASavfkPUjqlNOU0y8pnIJrV2g2+rz1r3VXUzATeRcDyDlcyngvompo2I=;7:H71rELDlArUtSIQqudohrjdeztk8Bl0b1hXrlvlFxMZ9ejXZK7c40IFG+GjUJRit/uApXY1DHm3RgxrdyUX1kg8p/t7i5/a4ODw7u06IFUES20j9GjxxvVrv4Usy9NMMJ1qkcTgBsWTnJaTn/aQvOQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 30a56e22-8038-4c0b-b270-08d64f247de5
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR0601MB3786;
x-ms-traffictypediagnostic: MWHPR0601MB3786:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tpiepho@impinj.com; 
x-microsoft-antispam-prvs: <MWHPR0601MB3786CC22CAD7627598201B27D3D90@MWHPR0601MB3786.namprd06.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231442)(944501410)(52105112)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:MWHPR0601MB3786;BCL:0;PCL:0;RULEID:;SRVR:MWHPR0601MB3786;
x-forefront-prvs: 08626BE3A5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39850400004)(376002)(346002)(366004)(396003)(189003)(199004)(86362001)(4001150100001)(2616005)(446003)(478600001)(4326008)(25786009)(97736004)(476003)(2201001)(11346002)(3846002)(6116002)(110136005)(14454004)(2501003)(305945005)(229853002)(2900100001)(71190400001)(2906002)(71200400001)(7736002)(36756003)(53936002)(256004)(486006)(5024004)(14444005)(103116003)(6436002)(66066001)(54906003)(6512007)(8676002)(81166006)(81156014)(8936002)(6246003)(5660300001)(39060400002)(316002)(6506007)(68736007)(105586002)(106356001)(76176011)(53546011)(6486002)(186003)(102836004)(26005)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR0601MB3786;H:MWHPR0601MB3708.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: impinj.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ysUX8nuZ6j9wDxbX9e0ilh00QKGhivxrK7gcMBdIv8mF3e+ZovNVHZG1gQGs38uUj9VUXHs0yfoGdP0aysxQJeelCFGxAlzjxgVqaXQpDEtFPatQZiJ45Vlmwpjzf5SMIdzh5sRHXWh4DXd2QiHbEdvfYKkzj0Pzd3887u9Lrh4Mc/GioeqC/lvTLQUMXMluCAfHkrldJVA51qVRmm+GO9NSLHvrjcWNgLXyhfSYR/yFUzF0EHylaMd29bv5X1IeDha+SKMwJ4lPnT7NF/cMk3bPvMD9QYjR7fCQbRt6bPO2zyOlqEtQgbSH1RoWAiEZaC9cmsQE4HYNMnjG5ITjdvip4HOzoasUND7216K69sU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <CD81AEE82E97354DA481BCC0C46A5F35@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: impinj.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30a56e22-8038-4c0b-b270-08d64f247de5
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2018 20:12:26.7407
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6de70f0f-7357-4529-a415-d8cbb7e93e5e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0601MB3786
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVHVlLCAyMDE4LTExLTIwIGF0IDEwOjQxIC0wNzAwLCBTdGVwaGVuIFdhcnJlbiB3cm90ZToN
Cj4gT24gMTEvMjAvMTggMTA6MzAgQU0sIFZpZHlhIFNhZ2FyIHdyb3RlOg0KPiA+ID4gDQo+ID4g
PiBTb21lIGltcGxlbWVudGF0aW9ucyBvZiB0aGUgRFdDIFBDSWUgZW5kcG9pbnQgY29udHJvbGxl
ciBkbyBub3QgYWxsb3cgYWNjZXNzDQo+ID4gPiB0byBEQkkgcmVnaXN0ZXJzIHVudGlsIHRoZSBh
dHRhY2hlZCBob3N0IGhhcyBzdGFydGVkIFJFRkNMSywgcmVsZWFzZWQgUEVSU1QsIGFuZA0KPiA+
ID4gdGhlIGVuZHBvaW50IGRyaXZlciBoYXMgaW5pdGlhbGl6ZWQgY2xvY2tpbmcgb2YgdGhlIERC
SSByZWdpc3RlcnMgYmFzZWQgb24gdGhhdC4NCj4gPiA+IA0KDQo+IGEpIFVwZGF0ZSBldmVyeSBl
eGlzdGluZyBEV0MgRVAgZHJpdmVyIHRvIHNldCBlcC0+aHdfcmVnc19hdmFpbGFibGUgDQo+IGR1
cmluZyBwcm9iZS9pbml0aWFsaXphdGlvbi4NCg0KSSBiZWxpZXZlIG9uIElNWDdkLCBpdCBpcyBh
bHNvIHRoZSBjYXNlIHRoYXQgYWNjZXNzIHRvIERXQyBQQ0llDQpjb250cm9sbGVyIHdpdGhvdXQg
UENJIFJFRkNMSyBjYXVzZXMgYSBzeXN0ZW0gaGFuZy4NCg0KV2UgaGFkIGEgZGVzaWduIHdpdGgg
YSBtaXN0YWtlIHRoYXQgZGlkbid0IHByb3ZpZGUgYSBSRUZDTEssIGFuZCBhIGhhbmcNCiBzdGFy
dGluZyB0aGUgZHdjIGNvbnRyb2xsZXIgaXMgd2hhdCBoYXBwZW5lZC4gIEl0IHdhcyBmaXhlZCB3
aXRoIGFuDQpleHRlcm5hbCBQQ0llIGNsb2NrIGNoaXAgdG8gcHJvdmlkZSB0aGUgUkVGQ0xLIGlu
cHV0IChhcyBpbXg3ZCBpcw0KZGVzaWduZWQgdG8gZXhwZWN0KSwgd2hpY2gsIGZvciB0aGUgY2xv
Y2sgY2hpcCB3ZSB1c2VkIGFuZCB0aGUgcmVzdCBvZg0KdGhlIGV4dGVybmFsIGNsb2NrIHRyZWUs
IG1lYW5zIHRoZSBSRUZDTEsgaXMgdGhlcmUgYmVmb3JlIExpbnV4IGJvb3RzLg0KDQpCdXQgdGhl
cmUncyBubyByZWFzb24gdGhhdCBtdXN0IGJlIHRoZSBjYXNlLiAgTWF5YmUgdGhlIGV4dGVybmFs
IGNsb2NrDQpjaGlwIGlzIEkyQyBjb250cm9sbGVkIGFuZCBuZWVkcyB0byBiZSBlbmFibGVkPyAg
QW5kIG1heWJlIEkgb25seSB3YW50DQp0byBkbyB0aGF0IGlmIFBDSS1lIGlzIHRvIGJlIHVzZWQ/
DQoNClNvIEkgZG9uJ3QgdGhpbmsgaWYgdGhpcyBpcyBhIHNwZWNpZmljIHByb2JsZW0gZm9yIG52
aWRpYS4NCg0KQnV0IEkgd29uZGVyLCB3aHkgY2FuJ3QgeW91IGFkZCBSRUZDTEsgdG8gdGhlIExp
bnV4IGNsb2NrIHRyZWUgYW5kIHRoZQ0KZHdjIGJpbmRpbmdzLCBhbmQgaGF2ZSB0aGUgZHdjIGRy
aXZlciBFUFJPQkVfREVGRVIgaWYgaXQgY2FuJ3QNCmNsa19wcmVwYXJlX2VuYWJsZSgpIHRoZSBy
ZWZjbGs/DQo=

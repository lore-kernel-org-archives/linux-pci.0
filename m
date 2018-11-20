Return-Path: <SRS0=4GJS=N7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 336D4C4161D
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 19:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A5102145D
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 19:13:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=impinj.com header.i=@impinj.com header.b="hG2trV7o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A5102145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=impinj.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbeKUFoE (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 21 Nov 2018 00:44:04 -0500
Received: from mail-eopbgr780134.outbound.protection.outlook.com ([40.107.78.134]:6127
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726460AbeKUFoE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 21 Nov 2018 00:44:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=impinj.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nHqiaPwbOHU/xR7Lw7EuqTxF7nJepExjydPubo1+Y0M=;
 b=hG2trV7oqJN7GaRMgo3C7Ms9X3YhqUfK8soeqqDltwXDvUIJjVblwGYW8WdyueZ3AzMF+nGNab98VvAKHnLfbSHLHjFxRPivzFadf5cGKDl9iVvcTrUs+vrcglENoDtLJ7sM6qrmdAHiO0KErY6YjXjteUM2Ei00gt3rg1npHXI=
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com (10.167.236.38) by
 MWHPR0601MB3769.namprd06.prod.outlook.com (10.167.236.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.20; Tue, 20 Nov 2018 19:13:19 +0000
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::c0f3:ea8f:48ba:a5d7]) by MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::c0f3:ea8f:48ba:a5d7%4]) with mapi id 15.20.1361.013; Tue, 20 Nov 2018
 19:13:19 +0000
From:   Trent Piepho <tpiepho@impinj.com>
To:     "stefan@agner.ch" <stefan@agner.ch>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "leonard.crestez@nxp.com" <leonard.crestez@nxp.com>
CC:     "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "hongxing.zhu@nxp.com" <hongxing.zhu@nxp.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>
Subject: Re: [PATCH v3 2/2] PCI: imx6: limit DBI register length
Thread-Topic: [PATCH v3 2/2] PCI: imx6: limit DBI register length
Thread-Index: AQHUgPH+9f73kyfh4Ey6Y3qhQ/Hi4qVY+SkAgAAPIwA=
Date:   Tue, 20 Nov 2018 19:13:19 +0000
Message-ID: <1542741198.30311.608.camel@impinj.com>
References: <20181120165626.26424-1-stefan@agner.ch>
         <20181120165626.26424-2-stefan@agner.ch>
         <581b9548043d5276f6685f534386180fd0673a9a.camel@nxp.com>
In-Reply-To: <581b9548043d5276f6685f534386180fd0673a9a.camel@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tpiepho@impinj.com; 
x-originating-ip: [216.207.205.253]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR0601MB3769;6:ZbMgrT7GS9R/ad5ehR3C0Dho3ljBgILIZe38S3+O3nB9h7/7Pg3SPBRfPXnlFX6p0fzmLTcOjK7McUJXORPEPMJ36OVmqNCaqTkHkPCJVByz7lPhwqBOG3+XkasO+F5LYMEIIHke3wsB5n8UL1QIv64Xxjy3fg6GwlfVIWrbDpEXFKNxL36WY50GW8DffPTg748uVU9tkdnZHz+kx8MyCJ2HZsVoEL6FmRRIs5vSOngjTCejBRH8Q4rPrUAlqwAsOtufQ8WP+ZQkG9eXQWBGdwI0C4IdYqubQxLvpBjkB1w0lKg/pirwploAZFT1g4h/V50z6t9hWm5T7/w9Wp1gUjS5DJv3hInRXA40pY0qd1OW3EyXUyk4wpa6G+PzaL8H69XnQIKZbmerN4EC7H0P4xKuaVlQ+xuuRNx0UdocZ3DDGLjMC8A+SIuzaGKQ8T1OhfvEd2x6z3UnMo3hJHbxAA==;5:cIW+I0IYPBFIKttVKoxMAzB4oDXPp+5lxRmiXoLQ+v7QiBbDVrCY8Enei4wdHT6Mm0bpGI4ZIFH7XEHg+heJXCdIGY6FysTh5JHmem1tAbzK+i5F4b90BuUohMX/s3xi6UACuvPYpG2QGZ06eTU37IPSzA+YhuqH5e5hWYHFQdM=;7:1X+45nmBA8PwijFjMUWAIdU/1REF0ytb6GTUqgCO8gLghxtWZCFG2ZoiIuQtTXTDwvFLbP1BoMiTawZlZp3YMwmbpupCRRx71QPPcG8aw5HFGIi3cOQ3B1dd4yCCsne6UiZ7Hyl7TMDTHSLoI5VuGQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 7add7613-20cd-4a11-941a-08d64f1c3b51
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR0601MB3769;
x-ms-traffictypediagnostic: MWHPR0601MB3769:
x-microsoft-antispam-prvs: <MWHPR0601MB3769942F36B738F8538536E4D3D90@MWHPR0601MB3769.namprd06.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231442)(944501410)(52105112)(3002001)(10201501046)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:MWHPR0601MB3769;BCL:0;PCL:0;RULEID:;SRVR:MWHPR0601MB3769;
x-forefront-prvs: 08626BE3A5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(39850400004)(376002)(346002)(396003)(199004)(189003)(105586002)(2501003)(14444005)(66066001)(486006)(39060400002)(11346002)(256004)(2201001)(4001150100001)(71190400001)(76176011)(99286004)(71200400001)(6506007)(4326008)(102836004)(81166006)(68736007)(8936002)(26005)(8676002)(81156014)(25786009)(86362001)(229853002)(97736004)(186003)(110136005)(6512007)(54906003)(305945005)(7416002)(2616005)(478600001)(53936002)(5660300001)(476003)(7736002)(2906002)(446003)(14454004)(6246003)(2900100001)(6436002)(103116003)(316002)(3846002)(36756003)(6486002)(6116002)(106356001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR0601MB3769;H:MWHPR0601MB3708.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: impinj.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: aE2kQbwPoq57znhKSEhlYVu9QEL76RbsHT63XsUwGeZ0kfVj6qSA0cQ7w8Dq4rzOooU1patekqF+Dv9u7MN8nXtMKU634D8DGVNwEjSQ0VOeOtw4drpv+e4zuOgKL8UkEO7pX5wqDQjtGBD1SKZxHIyp5wM9bqpLKpyH5HDPYjzeeD+GXm8uJxYCLqPYq1bFJuuiOlbrwTsQ4S1LhkvVpbAcm2fiHOwgGf/CD1uhTZbpP2Z0AyEdc3nKGHOpLZoTW222PRQr/8O7qyaWORF2hhQ38MMReLc8rO2GAGxG4Ogr87ADWrQAwBf9dY6iyB1YBOoSgCIhi0k/vlbQjDVv9XSl5zO8XV58kqXeFtiwlc0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <7B265E1D2BCC32469775FAF50363D52C@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: impinj.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7add7613-20cd-4a11-941a-08d64f1c3b51
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2018 19:13:19.1447
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6de70f0f-7357-4529-a415-d8cbb7e93e5e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0601MB3769
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVHVlLCAyMDE4LTExLTIwIGF0IDE4OjE5ICswMDAwLCBMZW9uYXJkIENyZXN0ZXogd3JvdGU6
DQo+IE9uIFR1ZSwgMjAxOC0xMS0yMCBhdCAxNzo1NiArMDEwMCwgU3RlZmFuIEFnbmVyIHdyb3Rl
Og0KPiA+IERlZmluZSB0aGUgbGVuZ3RoIG9mIHRoZSBEQkkgcmVnaXN0ZXJzLiBUaGlzIG1ha2Vz
IHN1cmUgdGhhdA0KPiA+IHRoZSBrZXJuZWwgZG9lcyBub3QgYWNjZXNzIHJlZ2lzdGVycyBiZXlv
bmQgdGhhdCBwb2ludCwgYXZvaWRpbmcNCj4gPiB0aGUgZm9sbG93aW5nIGFib3J0IG9uIGEgaS5N
WCA2UXVhZDoNCj4gPiAgICMgY2F0DQo+ID4gL3N5cy9kZXZpY2VzL3NvYzAvc29jLzFmZmMwMDAu
cGNpZS9wY2kwMDAwXDowMC8wMDAwXDowMFw6MDAuMC9jb25maWcNCj4gPiAgIFsgIDEwMC4wMjE0
MzNdIFVuaGFuZGxlZCBmYXVsdDogaW1wcmVjaXNlIGV4dGVybmFsIGFib3J0ICgweDE0MDYpDQo+
ID4gYXQgMHhiNmVhNzAwMA0KPiA+ICAgLi4uDQo+ID4gICBbICAxMDAuMDU2NDIzXSBQQyBpcyBh
dCBkd19wY2llX3JlYWQrMHg1MC8weDg0DQo+ID4gICBbICAxMDAuMDYwNzkwXSBMUiBpcyBhdCBk
d19wY2llX3JkX293bl9jb25mKzB4NDQvMHg0OA0KPiANCj4gSSBkb24ndCBrbm93IGV4YWN0bHkg
d2hlcmUgdGhpcyBsaW1pdGF0aW9uIGNvbWVzIGZyb20sIEkgY2FuIGluZGVlZA0KPiByZXByb2R1
Y2UgYSBzdGFjayBkdW1wIHdoZW4gZHVtcGluZyBwY2kgY29uZmlnIGZyb20gL3N5cy8NCj4gDQo+
IFVuZm9ydHVuYXRlbHkgdGhpcyBzZWVtcyB0byBibG9jayBhY2Nlc3MgdG8gcmVnaXN0ZXJzIHVz
ZWQgZm9yDQo+IGZ1bmN0aW9uYWxpdHkgbGlrZSBpbnRlcnJ1cHRzLiBGb3IgZXhhbXBsZSBkd19o
YW5kbGVfbXNpX2lycSBkb2VzOg0KPiANCj4gCWR3X3BjaWVfcmRfb3duX2NvbmYocHAsIFBDSUVf
TVNJX0lOVFIwX1NUQVRVUyArDQo+IAkJCSAgICAoaSAqIE1TSV9SRUdfQ1RSTF9CTE9DS19TSVpF
KSwNCj4gCQkJICAgIDQsICZ2YWwpOw0KPiANCj4gd2hlcmUgUENJX01TSV9JTlRSMF9TVEFUVVMg
aXMgMHg4MzAuIFRoZXJlIGFyZSBtb3JlIGFjY2Vzc2VzIGxpa2UgdGhpcy4NCj4gDQo+IFRlc3Rp
bmcgb24gNmRsLXNhYnJlYXV0byAoZHRzIGNoYW5nZSByZXF1aXJlZCkgd2l0aCBhbiBhdGg5ayBw
Y2llIGNhcmQNCj4gd2l0aCB5b3VyIHNlcmllcyBJIHNvbWV0aW1lcyBnZXQgImlycSAyOTU6IG5v
Ym9keSBjYXJlZCIgb24gYm9vdC4gTWF5YmUNCj4gSSdtIG1pc3Npbmcgc29tZXRoaW5nPw0KDQpP
biBJTVg3ZCwgdGhlcmUgYXJlIHNpZ25pZmljYW50IGJsb2NrcyBvZiAwMHMgaW4gdGhlIGNvbmZp
ZyBzcGFjZSwgYW5kDQphbGwgMHhmZiBhdCAweGI1MCBvbiB1cC4NCg0KSS5lLiwgc2lnbmlmaWNh
bnQgcG9ydGlvbnMgYXJlIGVtcHR5LCBpbiB0aGUgbWlkZGxlIG9mIHRoZSBjb25maWcNCnNwYWNl
LCBub3QganVzdCBhdCB0aGUgZW5kLg0KDQpCdXQgdGhleSBjYW4gYmUgcmVhZCB3aXRob3V0IHBy
b2JsZW0uDQoNClBlcmhhcHMgaW14NnEgYWJvcnRzIG9uIGEgcmVhZCBvZiBhbiB1bmltcGxlbWVu
dGVkIGFkZHJlc3MgaW5zdGVhZCBvZg0KcmV0dXJuaW5nIHplcm9zIGxpa2UgaW14N2QuICBJbiB0
aGF0IGNhc2UgaXQgcmVhbGx5IG5lZWRzIHNvbWV0aGluZw0KbW9yZSBjb21wbGV4IHRvIHByZXZl
bnQgYWJvcnQgdGhhbiBqdXN0IGEgbGVuZ3RoLg0KDQpJdCBhbHNvIHNlZW1zIHRvIG1lIHRoYXQg
dGhpcyBkb2Vzbid0IG5lZWQgdG8gYmUgaW4gdGhlIGludGVybmFsIHBjaQ0KY29uZmlnIGFjY2Vz
cyBmdW5jdGlvbnMuICBUaGUgZHJpdmVyIHNob3VsZG4ndCBiZSByZWFkaW5nIHJlZ2lzdGVycw0K
dGhhdCBkb24ndCBleGlzdCBhbnl3YXkuICBJdCdzIHJlYWxseSBhYm91dCB0cnlpbmcgdG8gZml4
IHN5c2ZzIGFjY2Vzcw0KdG8gcmVnaXN0ZXJzIHRoYXQgZG9uJ3QgZXhpc3QuICBTbyBtYXliZSBp
dCBzaG91bGQgYmUgZG9uZSB0aGVyZS4=

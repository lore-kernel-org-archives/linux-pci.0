Return-Path: <SRS0=PFnE=OC=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AE4AC43441
	for <linux-pci@archiver.kernel.org>; Fri, 23 Nov 2018 06:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48B0620672
	for <linux-pci@archiver.kernel.org>; Fri, 23 Nov 2018 06:02:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="xDbQRFPW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48B0620672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2501989AbeKWQom (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 23 Nov 2018 11:44:42 -0500
Received: from mail-eopbgr50050.outbound.protection.outlook.com ([40.107.5.50]:52759
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729305AbeKWQol (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 23 Nov 2018 11:44:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GMV8JQKFeNb2YGLYHPoa5BQfbP8cJ2Hq/EA0OGWlwGM=;
 b=xDbQRFPWqUh1UcdvZfE5gld6f1hJC/Dq+qw+giY8Xm38+z0w4UWFFA99B0G+GFDW2wCOzzwFNcKPn3Bx5K72G6y8mE0f0B2u+VXZ0B0uA38tLU8eKsK0ufaYCWlhzeJ2KKSQojPblwYe0s8EHe9+fxRgabN/MtGGFJzaxVzdPog=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.2.80) by
 AM6PR04MB5943.eurprd04.prod.outlook.com (20.178.94.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.20; Fri, 23 Nov 2018 06:01:14 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::29b5:b3ed:3854:cf1c]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::29b5:b3ed:3854:cf1c%5]) with mapi id 15.20.1361.017; Fri, 23 Nov 2018
 06:01:14 +0000
From:   "Z.q. Hou" <zhiqiang.hou@nxp.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        Roy Zang <roy.zang@nxp.com>, Mingkai Hu <mingkai.hu@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>
Subject: RE: [PATCHv2 3/4] PCI: layerscape: initialize the number of viewport
Thread-Topic: [PATCHv2 3/4] PCI: layerscape: initialize the number of viewport
Thread-Index: AQHUdoHwwQtALiNKOkSV/HKwxAJl5qVbvLCAgAE4XhA=
Date:   Fri, 23 Nov 2018 06:01:14 +0000
Message-ID: <AM6PR04MB57816428AA6DA569AC680B8884D40@AM6PR04MB5781.eurprd04.prod.outlook.com>
References: <20181107100854.28389-1-Zhiqiang.Hou@nxp.com>
 <20181107100854.28389-4-Zhiqiang.Hou@nxp.com>
 <20181122111645.GA11447@e107981-ln.cambridge.arm.com>
In-Reply-To: <20181122111645.GA11447@e107981-ln.cambridge.arm.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR04MB5943;6:XIjZuTt/msiqCh3HjlMjUQlDwbQw7zkfP4NQCuIkidtB8SLeYSQMpNkXr/tibQGoh/lSxj7Q1e11Q9bvX54NuuepYrFcDCFmDItms3NGMpmdcKUJgRg2Iz57q0xSmObnV+POCYSkAbkpfcjpER9DJUtUoZYm7KnmwhYkGVlbVyB7spkicNizf5ehVP0SYdvDbcpmmkBHlGOjlVEgF35Bn+n2zABim44iHAUNLFljiwW5k0Uz868nj5AS3Ya/Ra6aedJE+2QgDeh92hhVV593Q69bVLmASe/3nCSYn+kMzvFrC9kBFSV/te250Q1u3m4nqGeYPxQR/wU1Ij5pUyXhz0lbalu2vEEZziSPHTPBcBNeCtunRG/6NgKg/gYZB2IyiaNACaH7z1H84mA34qflQ4X/5CmfJE5fU9NEsrloDpJtuvcC3Z7/v0Kxs2SSI7M6BtWg3jNG+cf4lLD0zoBHUw==;5:mYZUfNEQQllKGWwGCINaLjHXUaJ871rs/dR0E3DPzWpvVW7UGkuH8LEeqa4Wm6YDB77ikzxsc7cI878wgXDpwlFE8y/xLpxXoy3XHdJ6ZcLCqeJyalZP+7vkSCW9+pY2N0ooyVwMv5myRa1B/YPsc/o4pGXXOHbyjdMMUQYUa2s=;7:FjHeIJOWYHklJn7vrExDI553Pwknx+ep5GXxxvZcnSGK+0pYpSww/CuuBjzPoJRfQmQYQmG7zfwAKPoVWRg0OTEBvC9UtOyD/oOssPhLE3HCjiHVNoV36dsaD+6P4G1EEoF8W9y812mgDx2FKCdXxQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 3a356d62-bccc-4901-c1ae-08d651091381
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB5943;
x-ms-traffictypediagnostic: AM6PR04MB5943:
x-microsoft-antispam-prvs: <AM6PR04MB5943D5F1EFD1B4928433165B84D40@AM6PR04MB5943.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(211936372134217)(85827821059158)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231442)(944501410)(52105112)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:AM6PR04MB5943;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB5943;
x-forefront-prvs: 086597191B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(136003)(376002)(366004)(39860400002)(189003)(199004)(13464003)(2906002)(446003)(11346002)(486006)(476003)(316002)(6916009)(186003)(66066001)(14454004)(6436002)(55016002)(5660300001)(6116002)(229853002)(54906003)(86362001)(3846002)(105586002)(7696005)(53936002)(76176011)(8676002)(97736004)(106356001)(9686003)(478600001)(2900100001)(68736007)(26005)(39060400002)(7736002)(81166006)(33656002)(6506007)(53546011)(305945005)(25786009)(71190400001)(99286004)(71200400001)(81156014)(256004)(4326008)(74316002)(8936002)(102836004)(6246003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5943;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: VWfznwt/xdoNl+rgXMtdVn+WN9pX460FScKkRtSe+p+KGw7qwVGvY7OtKKAyr5dHJJRx5py9O/QcFqbaQgogh+I+o9HJDZd1Nmm8sixKjapiEcC+MMy/0bP3tflCAl+PkWW3wxHyh9WL6r5oKVYGKRU6IK1F9s9bmsiQTIQjH4dYGx4S238m/1HF3lohpSQCM0HM+oicx7PcrTEqipmGXsMsZ24BYjFmERYzwUZES/LLYV2jnYCogMfkxfd0/LWAPnxr9AaFrz9Gp0keKVxv0THrwzZMShHHHvEOuoMt0BFddcyayp5BQZRhG/qbFsuVa6DRaPn0jS7ke3J5imBfLbnhtqh57Ly6zPQeCh19K5A=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a356d62-bccc-4901-c1ae-08d651091381
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2018 06:01:14.2229
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5943
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgTG9yZW56bywNCg0KVGhhbmtzIGEgbG90IGZvciB5b3VyIGNvbW1lbnRzIQ0KDQo+IC0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IExvcmVuem8gUGllcmFsaXNpIFttYWlsdG86
bG9yZW56by5waWVyYWxpc2lAYXJtLmNvbV0NCj4gU2VudDogMjAxOMTqMTHUwjIyyNUgMTk6MTcN
Cj4gVG86IFoucS4gSG91IDx6aGlxaWFuZy5ob3VAbnhwLmNvbT4NCj4gQ2M6IGxpbnV4LXBjaUB2
Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IGJoZWxnYWFz
QGdvb2dsZS5jb207IGppbmdvb2hhbjFAZ21haWwuY29tOw0KPiBndXN0YXZvLnBpbWVudGVsQHN5
bm9wc3lzLmNvbTsgUm95IFphbmcgPHJveS56YW5nQG54cC5jb20+OyBNaW5na2FpIEh1DQo+IDxt
aW5na2FpLmh1QG54cC5jb20+OyBNLmguIExpYW4gPG1pbmdodWFuLmxpYW5AbnhwLmNvbT4NCj4g
U3ViamVjdDogUmU6IFtQQVRDSHYyIDMvNF0gUENJOiBsYXllcnNjYXBlOiBpbml0aWFsaXplIHRo
ZSBudW1iZXIgb2Ygdmlld3BvcnQNCj4gDQo+IE9uIFdlZCwgTm92IDA3LCAyMDE4IGF0IDEwOjA5
OjE2QU0gKzAwMDAsIFoucS4gSG91IHdyb3RlOg0KPiA+IEZyb206IEhvdSBaaGlxaWFuZyA8Wmhp
cWlhbmcuSG91QG54cC5jb20+DQo+ID4NCj4gPiBGU0wgaW1wbGVtZW50cyA2IHZpZXdwb3J0cyBv
biBMYXllcnNjYXBlIHNlcmllcyBTb0NzIFBDSWUgY29udHJvbGxlcnMuDQo+ID4NCj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBIb3UgWmhpcWlhbmcgPFpoaXFpYW5nLkhvdUBueHAuY29tPg0KPiA+IC0tLQ0K
PiA+IFYyOg0KPiA+ICAtIFJld29yZGVkIHRoZSBzdWJqZWN0IGFuZCBjb21taXQgZGVzY3JpcHRp
b24uDQo+ID4NCj4gPiAgZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWxheWVyc2NhcGUu
YyB8IDMgKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykNCj4gPg0KPiA+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktbGF5ZXJzY2FwZS5j
DQo+ID4gYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktbGF5ZXJzY2FwZS5jDQo+ID4g
aW5kZXggMzcyNGQzZWY3MDA4Li42OWYzZjFhNWE3ODIgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVy
cy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWxheWVyc2NhcGUuYw0KPiA+ICsrKyBiL2RyaXZlcnMv
cGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1sYXllcnNjYXBlLmMNCj4gPiBAQCAtMjgwLDYgKzI4MCw5
IEBAIHN0YXRpYyBpbnQgX19pbml0IGxzX2FkZF9wY2llX3BvcnQoc3RydWN0IGxzX3BjaWUNCj4g
PiAqcGNpZSkNCj4gPg0KPiA+ICAJcHAtPm9wcyA9IHBjaWUtPmRydmRhdGEtPm9wczsNCj4gPg0K
PiA+ICsJLyogRlNMIGltcGxlbWVudHMgNiB3aW5kb3dzICovDQo+ID4gKwlwY2ktPm51bV92aWV3
cG9ydCA9IDY7DQo+IA0KPiBUaGVyZSBpcyBhIERUIHByb3BlcnR5IHRvIGNvbmZpZ3VyZSB0aGlz
IHZhbHVlLCBJIGFtIG5vdCBzdXJlIGl0IHdhcyB0aGUgcmlnaHQNCj4gdGhpbmcgdG8gZG8gdG8g
YWRkIGl0IGJ1dCBzaW5jZSBpdCBpcyB0aGVyZSB1c2UgaXQuDQo+IA0KPiBJIHdpbGwgbm90IGNv
bnNpZGVyIHRoaXMgcGF0Y2ggZm9yIG1lcmdpbmcuDQoNCkkgd2lsbCBzdWJtaXQgYSBzZXBhcmF0
ZSBwYXRjaCB0byBhZGQgdGhlIG51bV92aWV3cG9ydCB0byBMYXllcnNjYXBlIFBDSWUncyBEVCBu
b2RlcywgYW5kIHBsZWFzZSBhbHNvIG1lcmdlIHRoaXMgcGF0Y2gsIHNvIHRoZSBuZXcga2VybmVs
IGNhbiBjb21wYXRpYmxlIHdpdGggb2xkIERUQi4NCg0KPiANCj4gTG9yZW56bw0KPiANCj4gPiAg
CXJldCA9IGR3X3BjaWVfaG9zdF9pbml0KHBwKTsNCj4gPiAgCWlmIChyZXQpIHsNCj4gPiAgCQlk
ZXZfZXJyKGRldiwgImZhaWxlZCB0byBpbml0aWFsaXplIGhvc3RcbiIpOw0KPiA+IC0tDQo+ID4g
Mi4xNy4xDQo+ID4NCg0KVGhhbmtzLA0KWmhpcWlhbmcNCg==

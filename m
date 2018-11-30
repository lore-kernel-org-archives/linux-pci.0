Return-Path: <SRS0=gDpg=OJ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D28A8C04EB8
	for <linux-pci@archiver.kernel.org>; Fri, 30 Nov 2018 05:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51BBD2145D
	for <linux-pci@archiver.kernel.org>; Fri, 30 Nov 2018 05:30:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="atjuFAJT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51BBD2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbeK3Qii (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 30 Nov 2018 11:38:38 -0500
Received: from mail-eopbgr00048.outbound.protection.outlook.com ([40.107.0.48]:25725
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726386AbeK3Qih (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 30 Nov 2018 11:38:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S38rqo3KsT9aGYkjuKnlWNJWGuRMo2p9cCDx8k4XU6k=;
 b=atjuFAJTkGmjmyS1LegkUPHFpV2A/trpSXIcpVI/SH5zyR/sgzqmcx1ob1hfQnMzhc6KTnaobX7o/5TgscrBwFUQlsBUtklWFQn1bVqK3uQ2IvLZ1iu8qyPSwKS9mkuW5gZYD2NEaYmD7vsJrvD6qJfSQx9l8UQ+oElfXw7G7fY=
Received: from VI1PR04MB4845.eurprd04.prod.outlook.com (20.177.49.14) by
 VI1PR04MB4128.eurprd04.prod.outlook.com (52.133.14.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.19; Fri, 30 Nov 2018 05:29:47 +0000
Received: from VI1PR04MB4845.eurprd04.prod.outlook.com
 ([fe80::21f7:a45b:3d8f:d16a]) by VI1PR04MB4845.eurprd04.prod.outlook.com
 ([fe80::21f7:a45b:3d8f:d16a%2]) with mapi id 15.20.1339.032; Fri, 30 Nov 2018
 05:29:47 +0000
From:   Bharat Bhushan <bharat.bhushan@nxp.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
CC:     "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "bharatb.yadav@gmail.com" <bharatb.yadav@gmail.com>,
        David Daney <david.daney@cavium.com>,
        "jglauber@cavium.com" <jglauber@cavium.com>,
        "mbroemme@libmpq.org" <mbroemme@libmpq.org>,
        "chrisrblake93@gmail.com" <chrisrblake93@gmail.com>
Subject: RE: [PATCH] PCI: Mark NXP LS1088 to avoid bus reset bus
Thread-Topic: [PATCH] PCI: Mark NXP LS1088 to avoid bus reset bus
Thread-Index: AQHUhi2yh4+Qm28J50ixacdSn4eZIqVjwNwAgAAJqACAALvmYIABG3kAgACEALA=
Date:   Fri, 30 Nov 2018 05:29:47 +0000
Message-ID: <VI1PR04MB4845D4ED02E38246E71DD1A49AD30@VI1PR04MB4845.eurprd04.prod.outlook.com>
References: <20181127083454.26560-1-Bharat.Bhushan@nxp.com>
 <20181127153356.GA112381@google.com> <20181127090830.084fedf1@x1.home>
 <VI1PR04MB48457E23AA3354316C7782D69AD10@VI1PR04MB4845.eurprd04.prod.outlook.com>
 <CAErSpo7By1t5X=M=x_+Fs8TeROACBnS3f5ujsi=Ewiogh=-wRg@mail.gmail.com>
In-Reply-To: <CAErSpo7By1t5X=M=x_+Fs8TeROACBnS3f5ujsi=Ewiogh=-wRg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=bharat.bhushan@nxp.com; 
x-originating-ip: [14.142.187.166]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB4128;6:gDJtOw/ANRnuAX/StZCg4kKWN5oCK1g+Tg8x70392k4zCKz11HGzboW8PP3eP+DFjvCfz0zQBk5XO1bwKXpjq3Mni80pza5oGbEqnLTFbFYean783vxatCT/WS+FSZ2D6zLKfsu6ku1NZ5tEyCRQp28R1zmfDbZiH5WUefuuwdHXFEahcIcEtUsu2q7OJH94eEvVVK8MPh1YFk/k11LpOFxTjZlLHgWxL/Udh2KXw1a/KRbcoRNpfUkkdC8gGGWLtt37UWAzzi78SfIal6Wc5R+86QMDnldGznpImpVTHwx9nnxVBOkcFrlMvLejulf+XQ6Crbv39ZIb5K07fn7rhdgGYV3+4/N4sGk5Tckh0+crxe1EEeCRMyNlRK5anaetxcAhHNRecyms6Od1cHQbXYRH5Vs0afdp1qJ8BtAN5oUlM6/GNrD8H1UedK3YH8C9mUwG6lS46SRajge6PoI4Og==;5:uNCe5G123ztrf7CY0fbjrsvmQbIq9kBWd+KuW6blLqxZxRJgAq5/WYUqKb3T8d/A7vUiVpCtYp23aKvJPUFJKWB8//PeZZWyAh2OHSO0Vf9/SFErvN++Pu7MbBgeEyZdgp0qFT9TinzaI6kvZX5B/ncy9wmRwkrCQgFllUrpg/w=;7:iQLDSRsUe4xlJxMA3aykjYRSAjAxyJkC4XE2k97qP78pIqf5IMkYAH4Ai+lnbX80rg2TMppHYm8dj46PxlXzklVMjN8//sPj/ToRvefVgkXqByHYc9jWLn5PzVeKX4dbee/HgXgeBFcJX5B4zEs/3w==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: c08cca2a-834a-4630-f304-08d65684d7a3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4128;
x-ms-traffictypediagnostic: VI1PR04MB4128:
x-microsoft-antispam-prvs: <VI1PR04MB412832F052E33AFB8F5597B29AD30@VI1PR04MB4128.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231453)(999002)(944501410)(52105112)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB4128;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4128;
x-forefront-prvs: 087223B4DA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(39860400002)(396003)(346002)(376002)(189003)(199004)(13464003)(9686003)(11346002)(6246003)(6916009)(71190400001)(71200400001)(97736004)(3846002)(6116002)(93886005)(54906003)(229853002)(39060400002)(6436002)(14454004)(25786009)(8676002)(256004)(14444005)(53936002)(81166006)(81156014)(8936002)(2906002)(478600001)(78486014)(33656002)(74316002)(105586002)(5660300001)(7696005)(106356001)(102836004)(55236004)(86362001)(68736007)(53546011)(99286004)(186003)(6506007)(446003)(66066001)(7736002)(4326008)(316002)(44832011)(476003)(26005)(7416002)(305945005)(486006)(76176011)(55016002)(505234006);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4128;H:VI1PR04MB4845.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: c9Uf15fJjqDG2VLMuGZYjwCnbtorpYAq92TIzWfyaqPqzzb8SDiilzZCII8BegptVezmEOg6u5/zATX0RsM5/0W7QFK0QfX0OBnDVFGFCd804LZD5oWFdRWMc5Zvo8zX1sJAycHnqMkQL0CJcF5iVD76gEp2GDwQmcklAvCHQBKbKumMQzfMWb8hPoS11mWR1weONpmMa6dcRorq8fNud5DIAvXwyu7Xm/fV0L6puPHSCUNP1/3S3So+ZSMC7ojhv+r9SZJrpcVL+Nr25E93r0F8oBElzBdmgUAigRk14Ur23SxxXUSPbAph/IwhNRnxySJRwbBOyTTB/LgZHrYHLlaALsLPBklKnO+lkBKFTQQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c08cca2a-834a-4630-f304-08d65684d7a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2018 05:29:47.1927
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4128
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQmpvcm4gSGVsZ2Fh
cyA8YmhlbGdhYXNAZ29vZ2xlLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIE5vdmVtYmVyIDI5LCAy
MDE4IDE6NDYgQU0NCj4gVG86IEJoYXJhdCBCaHVzaGFuIDxiaGFyYXQuYmh1c2hhbkBueHAuY29t
Pg0KPiBDYzogYWxleC53aWxsaWFtc29uQHJlZGhhdC5jb207IEJqb3JuIEhlbGdhYXMgPGhlbGdh
YXNAa2VybmVsLm9yZz47IGxpbnV4LQ0KPiBwY2lAdmdlci5rZXJuZWwub3JnOyBMaW51eCBLZXJu
ZWwgTWFpbGluZyBMaXN0IDxsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZz47IGJoYXJh
dGIueWFkYXZAZ21haWwuY29tOyBEYXZpZCBEYW5leQ0KPiA8ZGF2aWQuZGFuZXlAY2F2aXVtLmNv
bT47IGpnbGF1YmVyQGNhdml1bS5jb207DQo+IG1icm9lbW1lQGxpYm1wcS5vcmc7IGNocmlzcmJs
YWtlOTNAZ21haWwuY29tDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIFBDSTogTWFyayBOWFAgTFMx
MDg4IHRvIGF2b2lkIGJ1cyByZXNldCBidXMNCj4gDQo+IE9uIFR1ZSwgTm92IDI3LCAyMDE4IGF0
IDEwOjMyIFBNIEJoYXJhdCBCaHVzaGFuDQo+IDxiaGFyYXQuYmh1c2hhbkBueHAuY29tPiB3cm90
ZToNCj4gDQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTogQWxl
eCBXaWxsaWFtc29uIDxhbGV4LndpbGxpYW1zb25AcmVkaGF0LmNvbT4NCj4gPiA+IFNlbnQ6IFR1
ZXNkYXksIE5vdmVtYmVyIDI3LCAyMDE4IDk6MzkgUE0NCj4gPiA+IFRvOiBCam9ybiBIZWxnYWFz
IDxoZWxnYWFzQGtlcm5lbC5vcmc+DQo+ID4gPiBDYzogQmhhcmF0IEJodXNoYW4gPGJoYXJhdC5i
aHVzaGFuQG54cC5jb20+Ow0KPiA+ID4gbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsgbGludXgt
a2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gPiA+IGJoYXJhdGIueWFkYXZAZ21haWwuY29tOyBE
YXZpZCBEYW5leSA8ZGF2aWQuZGFuZXlAY2F2aXVtLmNvbT47DQo+IEphbg0KPiA+ID4gR2xhdWJl
ciA8amdsYXViZXJAY2F2aXVtLmNvbT47IE1haWsgQnJvZW1tZQ0KPiA8bWJyb2VtbWVAbGlibXBx
Lm9yZz47DQo+ID4gPiBDaHJpcyBCbGFrZSA8Y2hyaXNyYmxha2U5M0BnbWFpbC5jb20+DQo+ID4g
PiBTdWJqZWN0OiBSZTogW1BBVENIXSBQQ0k6IE1hcmsgTlhQIExTMTA4OCB0byBhdm9pZCBidXMg
cmVzZXQgYnVzDQo+ID4gPg0KPiA+ID4gT24gVHVlLCAyNyBOb3YgMjAxOCAwOTozMzo1NiAtMDYw
MA0KPiA+ID4gQmpvcm4gSGVsZ2FhcyA8aGVsZ2Fhc0BrZXJuZWwub3JnPiB3cm90ZToNCj4gDQo+
ID4gPiA+IDQpIElzIHRoZXJlIGEgaGFyZHdhcmUgZXJyYXR1bSBmb3IgdGhpcz8gIElmIHNvLCBw
bGVhc2UgaW5jbHVkZQ0KPiA+ID4gPiB0aGUgVVJMIGhlcmUuDQo+ID4NCj4gPiBObyBoL3cgZXJy
YXRhIGFzIG9mIG5vdy4NCj4gDQo+IERvZXMgdGhhdCBtZWFuIChhKSB0aGUgSFcgZm9sa3MgYWdy
ZWUgdGhpcyBpcyBhIGhhcmR3YXJlIHByb2JsZW0gYnV0IHRoZXkNCj4gaGF2ZW4ndCB3cml0dGVu
IGFuIGVycmF0dW0sIChiKSB0aGVyZSBpcyBhbiBlcnJhdHVtIGJ1dCBpdCBpc24ndCBwdWJsaWMs
IChjKSB3ZQ0KPiBkb24ndCBoYXZlIGFueSBjb25jcmV0ZSBldmlkZW5jZSBvZiBhIGhhcmR3YXJl
IHByb2JsZW0sIGJ1dCB0aGluZ3MganVzdA0KPiBkb24ndCB3b3JrIGlmIHdlIGRvIGEgYnVzIHJl
c2V0LCAoZCkgc29tZXRoaW5nIGVsc2U/DQoNCkkgd2lsbCBzYXkgaXQgaXMgKGMpIC0gbm90IGNv
bmNsdWRlZCB0byBiZSBoYXJkd2FyZSBoL3cgaXNzdWUuIA0KDQo+IA0KPiA+IEluIHBjaV9yZXNl
dF9zZWNvbmRhcnlfYnVzKCkgSSBoYXZlIHRyaWVkIHRvIGluY3JlYXNlIHRoZSBkZWxheSBhZnRl
ciByZXNldA0KPiBidXQgbm90IGhlbHBlZC4NCj4gPiBEbyBJIG5lZWQgdG8gYWRkIGRlbGF5IGF0
IHNvbWUgb3RoZXIgcGxhY2UgYXMgd2VsbD8NCj4gDQo+IE5vLCBJIHRoaW5rIHRoZSBwbGFjZSB5
b3UgdHJpZWQgc2hvdWxkIGJlIGVub3VnaC4NCj4gDQo+IFlvdSBzaG91bGQgYWxzbyBiZSBhYmxl
IHRvIGV4ZXJjaXNlIHRoaXMgZnJvbSB1c2VyLXNwYWNlIGJ5IHVzaW5nICJzZXRwY2kiIHRvDQo+
IHNldCBhbmQgY2xlYXIgdGhlIFNlY29uZGFyeSBCdXMgUmVzZXQgYml0IGluIHRoZSBCcmlkZ2Ug
Q29udHJvbCByZWdpc3Rlci4gIFRoZW4NCj4geW91IGNhbiBhbHNvIHVzZSBzZXRwY2kgdG8gcmVh
ZC93cml0ZSBjb25maWcgc3BhY2Ugb2YgdGhlIE5JQy4gIFRoZSBrZXJuZWwNCj4gd291bGQgbm9y
bWFsbHkgcmVhZCB0aGUgVmVuZG9yIGFuZCBEZXZpY2UgSURzIGFzIHRoZSBmaXJzdCBhY2Nlc3Mg
dG8gdGhlDQo+IGRldmljZSBkdXJpbmcgZW51bWVyYXRpb24uICBZb3UgYWxzbyBtaWdodCBiZSBh
YmxlIHRvIGxlYXJuIHNvbWV0aGluZyBieQ0KPiB1c2luZyAibHNwY2kgLXZ2IiBvbiB0aGUgYnJp
ZGdlIGJlZm9yZSBhbmQgYWZ0ZXIgdGhlIHJlc2V0IHRvIHNlZSBpZiBpdCBsb2dzIGFueQ0KPiBB
RVIgYml0cyAoaWYgaXQgc3VwcG9ydHMgQUVSKSBvciB0aGUgb3RoZXIgc3RhbmRhcmQgZXJyb3Ig
bG9nZ2luZyBiaXRzLg0KDQpJIHRyaWVkIGJlbG93IHNlcXVlbmNlIGZvciBTZWNvbmRhcnkgYnVz
IHJlc2V0IGFuZCBkZXZpY2UgY29uZmlnIHNwYWNlIHNob3cgMHhmZg0KDQpyb290QGxvY2FsaG9z
dDp+IyBsc3BjaSAteA0KMDAwMjowMDowMC4wIFBDSSBicmlkZ2U6IEZyZWVzY2FsZSBTZW1pY29u
ZHVjdG9yIEluYyBEZXZpY2UgODBjMCAocmV2IDEwKQ0KMDA6IDU3IDE5IGMwIDgwIDA3IDAxIDEw
IDAwIDEwIDAwIDA0IDA2IDA4IDAwIDAxIDAwDQoxMDogMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAg
MDAgMDEgZmYgMDAgMDEgMDEgMDAgMDANCjIwOiAwMCA0MCAwMCA0MCBmMSBmZiAwMSAwMCAwMCAw
MCAwMCAwMCAwMCAwMCAwMCAwMA0KMzA6IDAwIDAwIDAwIDAwIDQwIDAwIDAwIDAwIDAwIDAwIDAw
IDQwIDYzIDAxIDAwIDAwDQoNCjAwMDI6MDE6MDAuMCBFdGhlcm5ldCBjb250cm9sbGVyOiBJbnRl
bCBDb3Jwb3JhdGlvbiA4MjU3NEwgR2lnYWJpdCBOZXR3b3JrIENvbm5lY3Rpb24NCjAwOiA4NiA4
MCBkMyAxMCAwNiAwNCAxMCAwMCAwMCAwMCAwMCAwMiAxMCAwMCAwMCAwMA0KMTA6IDAwIDAwIDBj
IDQwIDAwIDAwIDAwIDQwIDAxIDAwIDAwIDAwIDAwIDAwIDBlIDQwDQoyMDogMDAgMDAgMDAgMDAg
MDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgODYgODAgMWYgYTANCjMwOiAwMCAwMCAyNCA0MCBjOCAw
MCAwMCAwMCAwMCAwMCAwMCAwMCA2MyAwMSAwMCAwMA0KDQpyb290QGxvY2FsaG9zdDp+IyAgc2V0
cGNpIC1zIDAwMDI6MDA6MDAuMCAweDNlLmI9MHg0MA0Kcm9vdEBsb2NhbGhvc3Q6fiMgIHNldHBj
aSAtcyAwMDAyOjAwOjAwLjAgMHgzZS5iPTB4MDANCg0Kcm9vdEBsb2NhbGhvc3Q6fiMgbHNwY2kg
LXgNCjAwMDI6MDA6MDAuMCBQQ0kgYnJpZGdlOiBGcmVlc2NhbGUgU2VtaWNvbmR1Y3RvciBJbmMg
RGV2aWNlIDgwYzAgKHJldiAxMCkNCjAwOiA1NyAxOSBjMCA4MCAwNyAwMSAxMCAwMCAxMCAwMCAw
NCAwNiAwOCAwMCAwMSAwMA0KMTA6IDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAxIGZmIDAw
IDAxIDAxIDAwIDAwDQoyMDogMDAgNDAgMDAgNDAgZjEgZmYgMDEgMDAgMDAgMDAgMDAgMDAgMDAg
MDAgMDAgMDANCjMwOiAwMCAwMCAwMCAwMCA0MCAwMCAwMCAwMCAwMCAwMCAwMCA0MCA2MyAwMSAw
MCAwMA0KDQowMDAyOjAxOjAwLjAgRXRoZXJuZXQgY29udHJvbGxlcjogSW50ZWwgQ29ycG9yYXRp
b24gODI1NzRMIEdpZ2FiaXQgTmV0d29yayBDb25uZWN0aW9uIChyZXYgZmYpDQowMDogZmYgZmYg
ZmYgZmYgZmYgZmYgZmYgZmYgZmYgZmYgZmYgZmYgZmYgZmYgZmYgZmYNCjEwOiBmZiBmZiBmZiBm
ZiBmZiBmZiBmZiBmZiBmZiBmZiBmZiBmZiBmZiBmZiBmZiBmZg0KMjA6IGZmIGZmIGZmIGZmIGZm
IGZmIGZmIGZmIGZmIGZmIGZmIGZmIGZmIGZmIGZmIGZmDQozMDogZmYgZmYgZmYgZmYgZmYgZmYg
ZmYgZmYgZmYgZmYgZmYgZmYgZmYgZmYgZmYgZmYNCg0KVGhhbmtzDQotQmhhcmF0DQoNCg0K

Return-Path: <SRS0=lIFx=RP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74263C43381
	for <linux-pci@archiver.kernel.org>; Tue, 12 Mar 2019 04:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F9F62084F
	for <linux-pci@archiver.kernel.org>; Tue, 12 Mar 2019 04:18:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="nEmJQ32S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725887AbfCLESa (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 12 Mar 2019 00:18:30 -0400
Received: from mail-eopbgr10054.outbound.protection.outlook.com ([40.107.1.54]:29455
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725811AbfCLESa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 12 Mar 2019 00:18:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xItrn69nnSysvDLpNi1IMXrel5xXF+/TzwsDCQzYY1A=;
 b=nEmJQ32SJrEKYBmc3CGtR6vSIYgQ/1Wkhjin+uWwXQW8YwV1WVnKdXBrt4K4TECQdq+rPYDJ9kY3CRQylZ/9NKnTyvQXMz3ldX1oI/aLyT+3jNVcrEz9xlCBFYEfK/Bv5ePofBzegD+7HhiVXbW2sI05NYAs7I7GZpjVbjJvtRk=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.3.19) by
 AM6PR04MB4296.eurprd04.prod.outlook.com (52.135.169.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.13; Tue, 12 Mar 2019 04:18:24 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::30cc:e034:1f7a:2cc7]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::30cc:e034:1f7a:2cc7%2]) with mapi id 15.20.1686.021; Tue, 12 Mar 2019
 04:18:24 +0000
From:   "Z.q. Hou" <zhiqiang.hou@nxp.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "l.subrahmanya@mobiveil.co.in" <l.subrahmanya@mobiveil.co.in>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>
Subject: RE: [PATCHv4 00/28] PCI: refactor Mobiveil driver and add PCIe Gen4
 driver for NXP Layerscape SoCs
Thread-Topic: [PATCHv4 00/28] PCI: refactor Mobiveil driver and add PCIe Gen4
 driver for NXP Layerscape SoCs
Thread-Index: AQHU1+z8oUtBku7HKUGEtP8v8oioHaYGbhUAgAD2a3A=
Date:   Tue, 12 Mar 2019 04:18:24 +0000
Message-ID: <AM6PR04MB57813B6051962E12B629331E84490@AM6PR04MB5781.eurprd04.prod.outlook.com>
References: <20190311093130.7209-1-Zhiqiang.Hou@nxp.com>
 <20190311133310.GE214730@google.com>
In-Reply-To: <20190311133310.GE214730@google.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-originating-ip: [192.88.170.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 297cd7bf-4d23-4459-541c-08d6a6a1c4ea
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4296;
x-ms-traffictypediagnostic: AM6PR04MB4296:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <AM6PR04MB4296B2D4DEA94889D8316DB884490@AM6PR04MB4296.eurprd04.prod.outlook.com>
x-forefront-prvs: 09749A275C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(6029001)(366004)(39860400002)(136003)(396003)(346002)(376002)(54534003)(13464003)(199004)(189003)(305945005)(966005)(7736002)(3846002)(5660300002)(6116002)(229853002)(74316002)(6246003)(14454004)(486006)(25786009)(11346002)(7696005)(76176011)(446003)(106356001)(26005)(186003)(476003)(4326008)(478600001)(86362001)(7416002)(8936002)(66066001)(71200400001)(102836004)(256004)(71190400001)(45080400002)(33656002)(6436002)(68736007)(105586002)(81166006)(2906002)(99286004)(54906003)(6916009)(52536013)(6506007)(53546011)(9686003)(53936002)(14444005)(97736004)(81156014)(316002)(6306002)(55016002)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4296;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: CXFwe4METWJebximgJ/2qJz7iqboRiIyXnprurLbbwrCdjVuS2YXBtdnDhiE6llE5oPkawvYQC8HStX1D37yqW6kzkeGNSMAXO628AovUr1TTTTWNMGMI4zy/ySskjt/WvJhI/ACpiimzg0/I3wmM4fA3/jxug6avyEav0rgetx5wbmxTwdpkF/zHbePsAP2lbT4ag3EJW93Ypbbe0mRePVEcsbqtHlhnzvvWohoBfBvO/IGCM3Z5qknlZeGn671m5vJIgYgnG8HwXdJRuRvrIFfdZDAbtny7sylRR3boTApLP3EobE5XDQc6Q6H79krJi593nnk/gPN79SZJdP5AyNRVejwLnvpOYQVz4KzDnSYKVYP9D674InDrRR31i9OZWgWhCXvC0ZMgbLvxiafnKSNySbUrfvNVePvQxDKeZk=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 297cd7bf-4d23-4459-541c-08d6a6a1c4ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2019 04:18:24.2420
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4296
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgQmpvcm4sDQoNClRoYW5rcyBhIGxvdCBmb3IgeW91ciBjb21tZW50cyENCg0KPiAtLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCam9ybiBIZWxnYWFzIFttYWlsdG86aGVsZ2Fh
c0BrZXJuZWwub3JnXQ0KPiBTZW50OiAyMDE5xOoz1MIxMcjVIDIxOjMzDQo+IFRvOiBaLnEuIEhv
dSA8emhpcWlhbmcuaG91QG54cC5jb20+DQo+IENjOiBsaW51eC1wY2lAdmdlci5rZXJuZWwub3Jn
OyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+IGRldmljZXRyZWVAdmdl
ci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiByb2JoK2R0QGtl
cm5lbC5vcmc7IG1hcmsucnV0bGFuZEBhcm0uY29tOyBsLnN1YnJhaG1hbnlhQG1vYml2ZWlsLmNv
LmluOw0KPiBzaGF3bmd1b0BrZXJuZWwub3JnOyBMZW8gTGkgPGxlb3lhbmcubGlAbnhwLmNvbT47
DQo+IGxvcmVuem8ucGllcmFsaXNpQGFybS5jb207IGNhdGFsaW4ubWFyaW5hc0Bhcm0uY29tOw0K
PiB3aWxsLmRlYWNvbkBhcm0uY29tOyBNLmguIExpYW4gPG1pbmdodWFuLmxpYW5AbnhwLmNvbT47
IFhpYW93ZWkgQmFvDQo+IDx4aWFvd2VpLmJhb0BueHAuY29tPjsgTWluZ2thaSBIdSA8bWluZ2th
aS5odUBueHAuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIdjQgMDAvMjhdIFBDSTogcmVmYWN0
b3IgTW9iaXZlaWwgZHJpdmVyIGFuZCBhZGQgUENJZSBHZW40DQo+IGRyaXZlciBmb3IgTlhQIExh
eWVyc2NhcGUgU29Dcw0KPiANCj4gSGksDQo+IA0KPiBPbiBNb24sIE1hciAxMSwgMjAxOSBhdCAw
OToyOTo1NEFNICswMDAwLCBaLnEuIEhvdSB3cm90ZToNCj4gPiBGcm9tOiBIb3UgWmhpcWlhbmcg
PFpoaXFpYW5nLkhvdUBueHAuY29tPg0KPiA+DQo+ID4gVGhpcyBwYXRjaCBzZXQgaXMgYWltIHRv
IHJlZmFjdG9yIHRoZSBNb2JpdmVpbCBkcml2ZXIgYW5kIGFkZCBQQ0llDQo+ID4gc3VwcG9ydCBm
b3IgTlhQIExheWVyc2NhcGUgc2VyaWVzIFNvQ3MgaW50ZWdyYXRlZCBNb2JpdmVpbCdzIFBDSWUg
R2VuNA0KPiA+IGNvbnRyb2xsZXIuDQo+ID4NCj4gPiBIb3UgWmhpcWlhbmcgKDI4KToNCj4gPiAg
IFBDSTogbW9iaXZlaWw6IHVuaWZvcm0gdGhlIHJlZ2lzdGVyIGFjY2Vzc29ycw0KPiANCj4gInVu
aWZvcm0iIGlzIG5vdCBhIHZlcmIuICBNYXliZSAiVW5pZnkgcmVnaXN0ZXIgYWNjZXNzb3JzIj8N
Cj4gDQo+ID4gICBQQ0k6IG1vYml2ZWlsOiBmb3JtYXQgdGhlIGNvZGUgd2l0aG91dCBmdW5jdGlv
biBjaGFuZ2UNCj4gPiAgIFBDSTogbW9iaXZlaWw6IGNvcnJlY3QgdGhlIHJldHVybmVkIGVycm9y
IG51bWJlcg0KPiA+ICAgUENJOiBtb2JpdmVpbDogcmVtb3ZlIGZsYWcgTVNJX0ZMQUdfTVVMVElf
UENJX01TSQ0KPiA+ICAgUENJOiBtb2JpdmVpbDogY29ycmVjdCBQQ0kgYmFzZSBhZGRyZXNzIGlu
IE1FTS9JTyBvdXRib3VuZCB3aW5kb3dzDQo+ID4gICBQQ0k6IG1vYml2ZWlsOiByZXBsYWNlIHRo
ZSByZXNvdXJjZSBsaXN0IGl0ZXJhdGlvbiBmdW5jdGlvbg0KPiA+ICAgUENJOiBtb2JpdmVpbDog
dXNlIFdJTl9OVU1fMCBleHBsaWNpdGx5IGZvciBDRkcgb3V0Ym91bmQgd2luZG93DQo+ID4gICBQ
Q0k6IG1vYml2ZWlsOiB1c2UgdGhlIDFzdCBpbmJvdW5kIHdpbmRvdyBmb3IgTUVNIGluYm91bmQN
Cj4gdHJhbnNhY3Rpb25zDQo+ID4gICBQQ0k6IG1vYml2ZWlsOiBjb3JyZWN0IGluYm91bmQvb3V0
Ym91bmQgd2luZG93IHNldHVwIHJvdXRpbmVzDQo+ID4gICBQQ0k6IG1vYml2ZWlsOiBmaXggdGhl
IElOVHggcHJvY2VzcyBlcnJvcg0KPiA+ICAgUENJOiBtb2JpdmVpbDogb25seSBmaXggdXAgdGhl
IENsYXNzIENvZGUgZmllbGQNCj4gPiAgIFBDSTogbW9iaXZlaWw6IG1vdmUgb3V0IHRoZSBsaW5r
IHVwIHdhaXRpbmcgZnJvbSBtb2JpdmVpbF9ob3N0X2luaXQNCj4gDQo+IEFkZCBwYXJlbnMgZm9y
IGZ1bmN0aW9uIG5hbWVzLCBlLmcuLCAibW9iaXZlaWxfaG9zdF9pbml0KCkiLiAgVGhpcyBvY2N1
cnMNCj4gc2V2ZXJhbCBtb3JlIHRpbWVzLCBpbmNsdWRpbmcgYm90aCBzdWJqZWN0IGxpbmVzIGFu
ZCBjaGFuZ2Vsb2dzLg0KPiANCj4gPiAgIFBDSTogbW9iaXZlaWw6IG1vdmUgaXJxIGNoYWluZWQg
aGFuZGxlciBzZXR1cCBvdXQgb2YgRFQgcGFyc2UNCj4gDQo+IENhcGl0YWxpemUgYWNyb255bXMg
aW4gRW5nbGlzaCB0ZXh0IChzdWJqZWN0IGxpbmVzLCBjaGFuZ2Vsb2dzLCBjb21tZW50cyksIGUu
Zy4sDQo+IHMvaXJxL0lSUS8NCj4gDQo+ID4gICBQQ0k6IG1vYml2ZWlsOiBpbml0aWFsaXplIFBy
aW1hcnkvU2Vjb25kYXJ5L1N1Ym9yZGluYXRlIGJ1cyBudW1iZXINCj4gPiAgIGR0LWJpbmRpbmdz
OiBwY2k6IG1vYml2ZWlsOiBjaGFuZ2UgZ3Bpb19zbGF2ZSBhbmQgYXBiX2NzciB0byBvcHRpb25h
bA0KPiA+ICAgUENJOiBtb2JpdmVpbDogcmVmYWN0b3IgTW9iaXZlaWwgUENJZSBIb3N0IEJyaWRn
ZSBJUCBkcml2ZXINCj4gDQo+IFRoaXMgc2hvdWxkIGdpdmUgYSBoaW50IGFib3V0IHRoZSBwdXJw
b3NlIG9mIHJlZmFjdG9yaW5nLiAgU291bmRzIGxpa2UgaXQncyB0bw0KPiBtYWtlIGl0IGVhc2ll
ciB0byBzdXBwb3J0IGJvdGggaG9zdCBhbmQgZW5kcG9pbnQgbW9kZT8NCj4gDQo+ID4gICBQQ0k6
IG1vYml2ZWlsOiBmaXggdGhlIGNoZWNraW5nIG9mIHZhbGlkIGRldmljZQ0KPiA+ICAgUENJOiBt
b2JpdmVpbDogYWRkIGxpbmsgdXAgY29uZGl0aW9uIGNoZWNrDQo+ID4gICBQQ0k6IG1vYml2ZWls
OiBjb250aW51ZSB0byBpbml0aWFsaXplIHRoZSBob3N0IHVwb24gbm8gUENJZSBsaW5rDQo+ID4g
ICBQQ0k6IG1vYml2ZWlsOiBkaXNhYmxlZCBJQiBhbmQgT0Igd2luZG93cyBzZXQgYnkgYm9vdGxv
YWRlcg0KPiA+ICAgUENJOiBtb2JpdmVpbDogYWRkIEJ5dGUgYW5kIEhhbGYtV29yZCB3aWR0aCBy
ZWdpc3RlciBhY2Nlc3NvcnMNCj4gDQo+ICJCeXRlIiBhbmQgIkhhbGYtV29yZCIgZG8gbm90IG5l
ZWQgdG8gYmUgY2FwaXRhbGl6ZWQuICBBbHNvLCB0aGUgY2hhbmdlbG9nDQo+IGhhcyBhIHR5cG86
ICJIYWxmLVdvcmsiIGZvciAiaGFsZi13b3JkIi4NCj4gDQo+ID4gICBQQ0k6IG1vYml2ZWlsOiBt
YWtlIG1vYml2ZWlsX2hvc3RfaW5pdCBjYW4gYmUgdXNlZCB0byByZS1pbml0IGhvc3QNCj4gDQo+
IEhlcmUncyBhbm90aGVyIG9mIHRoZSBwbGFjZXMgdGhhdCBuZWVkIHBhcmVucyBhZnRlciB0aGUg
ZnVuY3Rpb24gbmFtZS4NCj4gDQo+ID4gICBkdC1iaW5kaW5nczogcGNpOiBBZGQgTlhQIExheWVy
c2NhcGUgU29DcyBQQ0llIEdlbjQgY29udHJvbGxlcg0KPiA+ICAgUENJOiBtb2JpdmVpbDogYWRk
IFBDSWUgR2VuNCBSQyBkcml2ZXIgZm9yIE5YUCBMYXllcnNjYXBlIFNvQ3MNCj4gPiAgIFBDSTog
bW9iaXZlaWw6IGxzX3BjaWVfZzQ6IGFkZCBXb3JrYXJvdW5kIGZvciBBLTAxMTU3Nw0KPiA+ICAg
UENJOiBtb2JpdmVpbDogbHNfcGNpZV9nNDogYWRkIFdvcmthcm91bmQgZm9yIEEtMDExNDUxDQo+
IA0KPiBUaGUgcmVhZGVyIG9mIHRoZXNlIGNoYW5nZWxvZ3MgbGlrZWx5IGRvZXNuJ3Qga25vdyB3
aGF0IGludGVybmFsIGlkZW50aWZpZXJzDQo+IGxpa2UgIkEtMDExNTc3IiBtZWFuLCBidXQgKmRv
ZXMqIHdhbnQgYSBoaW50IGFib3V0IHdoYXQgcHJvYmxlbSBpcyBiZWluZw0KPiBmaXhlZCBhbmQg
d2hhdCBwbGF0Zm9ybXMgYXJlIGFmZmVjdGVkLiAgU28gaW5zdGVhZCBvZiB0aGUgImxzX3BjaWVf
ZzQ6IiBwcmVmaXgsDQo+IHVzZSBzb21ldGhpbmcgbGlrZToNCj4gDQo+ICAgUENJOiBtb2JpdmVp
bDogV29yayBhcm91bmQgTFgyMTYwQSByMS4wIGNvbmZpZyBhY2Nlc3MgZXJyYXR1bQ0KPiAgIFBD
STogbW9iaXZlaWw6IFdvcmsgYXJvdW5kIExYMjE2MEEgcjEuMCBzcGxpdCBjb21wbGV0aW9uIGVy
cmF0dW0NCj4gDQo+IGFuZCBtZW50aW9uIHRoZSBlcnJhdHVtIElEIChBLTAxMTU3NykgaW4gdGhl
IGNoYW5nZWxvZy4gIElmIHlvdSBjYW4gaW5jbHVkZQ0KPiB0aGUgYWN0dWFsIGVycmF0dW0gdGV4
dCBpbiB0aGUgY2hhbmdlbG9nLCB0aGF0IHdvdWxkIGJlIGV2ZW4gYmV0dGVyLg0KPiANCj4gcy9F
UlJBVEEvZXJyYXRhLyBpbiB0aGUgY2hhbmdlbG9ncy4NCj4gDQo+ID4gICBhcm02NDogZHRzOiBm
cmVlc2NhbGU6IGx4MjE2MGE6IGFkZCBwY2llIERUIG5vZGVzDQo+IA0KPiAiUENJZSINCj4gDQo+
ID4gICBhcm02NDogZGVmY29uZmlnOiBFbmFibGUgQ09ORklHX1BDSV9MQVlFUlNDQVBFX0dFTjQN
Cj4gDQo+IEkgYWxyZWFkeSBhc2tlZCB5b3Ugb25jZSBbMV0gdG86DQo+IA0KPiAgIHBsZWFzZSBw
YXkgYXR0ZW50aW9uIHRvIHRoZSBjaGFuZ2Vsb2cgY29udmVudGlvbnMsIGUuZy4sIGNhcGl0YWxp
emUgdGhlDQo+ICAgZmlyc3Qgd29yZCBvZiB0aGUgc2VudGVuY2UgKCJSZW1vdmUgZmxhZyAuLi4i
LCAiQ29ycmVjdCBQQ0kgYmFzZSBhZGRyZXNzDQo+ICAgLi4uIiwgZXRjKSwgY2FwaXRhbGl6ZSBh
Y3JvbnltcyBsaWtlICJQQ0kiIGFuZCAiSVJRIiwgdXNlIHBhcmVudGhlc2VzDQo+ICAgYWZ0ZXIg
ZnVuY3Rpb24gbmFtZXMsIGV0Yy4gIFlvdSBjYW4gc2VlIHRoZSBjb252ZW50aW9ucyBieSBydW5u
aW5nICJnaXQNCj4gICBsb2cgLS1vbmVsaW5lIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIiLg0KPiAN
Cj4gRm9yIGV4YW1wbGUsIGluc3RlYWQgb2YgdGhpczoNCj4gDQo+ICAgUENJOiBtb2JpdmVpbDog
YWRkIGxpbmsgdXAgY29uZGl0aW9uIGNoZWNrDQo+IA0KPiBpdCBzaG91bGQgYmUgdGhpczoNCj4g
DQo+ICAgUENJOiBtb2JpdmVpbDogQWRkIGxpbmsgdXAgY29uZGl0aW9uIGNoZWNrDQo+IA0KPiBQ
bGVhc2Ugd2FpdCBhdCBsZWFzdCBhIGZldyBkYXlzIGJlZm9yZSBwb3N0aW5nIGEgdjUgaW4gY2Fz
ZSB0aGVyZSBhcmUgb3RoZXINCj4gY29tbWVudHMuDQoNClRoYW5rcyBmb3IgeW91ciBwYXRpZW5j
ZSBhbmQgd2lsbCBmaXggdGhlbSBpbiB2NS4NCg0KPiANCj4gQmpvcm4NCj4gDQo+IFsxXQ0KPiBo
dHRwczovL2VtZWEwMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBz
JTNBJTJGJTJGbG9yZS4NCj4ga2VybmVsLm9yZyUyRmxpbnV4LXBjaSUyRjIwMTkwMTMwMTUzNDQ3
LkdCMjI5NzczJTQwZ29vZ2xlLmNvbSZhbXA7DQo+IGRhdGE9MDIlN0MwMSU3Q3poaXFpYW5nLmhv
dSU0MG54cC5jb20lN0M1OTFiN2MxMjlmMGQ0MmNhZjNiOTA4ZDYNCj4gYTYyNjFkMzklN0M2ODZl
YTFkM2JjMmI0YzZmYTkyY2Q5OWM1YzMwMTYzNSU3QzAlN0MwJTdDNjM2ODc5MA0KPiA3OTk2ODg4
MTcyOSZhbXA7c2RhdGE9MW53eWNwbVQ5cDFWaGRyWjFmZFFYazBVUTRpaUtWSUVmRGUzSUdZZ1gN
Cj4gbkklM0QmYW1wO3Jlc2VydmVkPTANCg0KVGhhbmtzLA0KWmhpcWlhbmcNCg==

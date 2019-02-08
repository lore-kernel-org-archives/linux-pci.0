Return-Path: <SRS0=vzDi=QP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9202FC169C4
	for <linux-pci@archiver.kernel.org>; Fri,  8 Feb 2019 18:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 579FF2081B
	for <linux-pci@archiver.kernel.org>; Fri,  8 Feb 2019 18:19:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=impinj.com header.i=@impinj.com header.b="KBfZMY9n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727623AbfBHSTy (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 8 Feb 2019 13:19:54 -0500
Received: from mail-eopbgr770112.outbound.protection.outlook.com ([40.107.77.112]:19282
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727121AbfBHSTy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 8 Feb 2019 13:19:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=impinj.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1xUwBka5aoxFfXJdsqr3asEklvZXJqAZrsstupmg8hk=;
 b=KBfZMY9nvdPh18d4eTZDBP8+CjS1Z/fRY07aQxrBxuY3H1HW3bilnZESIiJNMK0S+bq6lb7DNvAa1kWYVhJUARpg26Jp4NOv9r3hyeYXA2TLI2a510RLUUxcaBFOmLHYauP26nHx9MdFgG1A5vH2nd5RsD/MCSVgBy+qxJquTic=
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com (10.167.236.38) by
 MWHPR0601MB3690.namprd06.prod.outlook.com (10.167.236.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.21; Fri, 8 Feb 2019 18:19:10 +0000
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::ac0c:a03e:77c7:fa85]) by MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::ac0c:a03e:77c7:fa85%5]) with mapi id 15.20.1601.016; Fri, 8 Feb 2019
 18:19:10 +0000
From:   Trent Piepho <tpiepho@impinj.com>
To:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "hongxing.zhu@nxp.com" <hongxing.zhu@nxp.com>
Subject: Re: [PATCH v2 3/3] PCI: imx: Add workaround for e10728, IMX7d PCIe
 PLL failure
Thread-Topic: [PATCH v2 3/3] PCI: imx: Add workaround for e10728, IMX7d PCIe
 PLL failure
Thread-Index: AQHUvOg1I9SIwv2NIEC65G+x/YIYY6XUSEwAgABgM4CAAQzVAIAAhmyA
Date:   Fri, 8 Feb 2019 18:19:10 +0000
Message-ID: <1549649949.3075.79.camel@impinj.com>
References: <20190205001721.18639-1-tpiepho@impinj.com>
         <20190205001721.18639-4-tpiepho@impinj.com>
         <20190207123132.GA21111@e107981-ln.cambridge.arm.com>
         <1549563351.3075.49.camel@impinj.com>
         <20190208101802.GA13009@e107981-ln.cambridge.arm.com>
In-Reply-To: <20190208101802.GA13009@e107981-ln.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tpiepho@impinj.com; 
x-originating-ip: [216.207.205.253]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2818d3f9-dd59-4345-0552-08d68df1ec07
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR0601MB3690;
x-ms-traffictypediagnostic: MWHPR0601MB3690:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtNV0hQUjA2MDFNQjM2OTA7MjM6RWpVeEovZGJGNEhrOGU2bFBLY1g2dEFL?=
 =?utf-8?B?dGFWUGFqdjU2ZVNQUy9TckNmemdJaXZEb01vMTRoN2RtZnc3U01GVHdRQmxP?=
 =?utf-8?B?Y1UvMy9QR05JWTZjWDFLay9ZNU9DUEZ1Q0VIVlBhdC9hVThjNW15dWhIeEZt?=
 =?utf-8?B?akRYQ0cyazhSZDlkd2pMVGRteDF4Y1MwZDc4Q3VobXFoRFRObGRnRjhTQmVH?=
 =?utf-8?B?WWJQNmhNV2NzU1cyWVV0UzZ6SmtnOHRrUlRmaENCU1F2T1hxYXZrNCtkNHA1?=
 =?utf-8?B?byswWU1kckkyd1JvOWdFenE3Rld6SjhFUlQ5bU9oNTUzK3NRVWtMVXd4UmxQ?=
 =?utf-8?B?bDNrakZ0WlVXbi9YYXRHUFozaEQzN3dYbUQ5ZWE0TTVjSUZMQ1lmTmM0NnZj?=
 =?utf-8?B?anhWWktxcFdFeUxvbmJNVlo3dnpWWHRsSXJmczhNVWdER2hwcFp0Y0JQeDBQ?=
 =?utf-8?B?cDc5dmxINlcybVBNREVUYWlYVStXNmlrNjR1MURKWmcvWE5WUXhZa2QydjJk?=
 =?utf-8?B?MHBVaTJCeTZtZkg3RXlkQy9lQi9JZUo5UCsvakwrNE96dzBDZFVRSmJKYVdl?=
 =?utf-8?B?SzVORDA5MnJWR1pNamk4WDdBZmRVQVI4WERPWmNvR0VqMk9GU0FNZ2NTenNz?=
 =?utf-8?B?QThzSWVIallEcHRhZ043clk4TW9jZjR4UjljR09JeHNEdVJGU0VHTTlVNHJp?=
 =?utf-8?B?aWU5ZXE1QUs1S2NUQzlxSk1tNVljaDNNN20yNHFzcVpxRUoxK2x5Tk5HWFha?=
 =?utf-8?B?aEZRdkMwWEtUMThWZHJNY0JwQ2p3dUM4NDdPMlZLWXpobzhiNCsxNFFNUUlt?=
 =?utf-8?B?VkZwRFBhZ25QTndKSUZzZWE1Yi9yK1RYVEFqQlNVdDZrMVFRWlJpOGh0R04y?=
 =?utf-8?B?UUMrN0h5VHBqeUhVVC82cmt6SSthUDVyaE5sMWVnd3JQaEpsNEdmbVVHRnV5?=
 =?utf-8?B?TDUyZjBjYW1VOUpZK094YmFtOXN1cVArUmtia2gyL2QwMW82MkV5ek1Qa1BK?=
 =?utf-8?B?TFhQUHZ6RjB5YXRYSkFTSnNBUElNQnRUV05WSWVldUNhZFB0dlBRbjZ2OHV0?=
 =?utf-8?B?V29XUldleDYzYlZIZjE2d0hsWlpwSk8zQ2ljb2NOVDloeWF2dTNBcWhZM3FV?=
 =?utf-8?B?RGM0VnBiQ083NDZ0QTBrcEFUV0JMejhmbmd4NUN2RDZ3UVh0eXQwRWFTeVd5?=
 =?utf-8?B?K25OcFNSaTR4YnpjK1J6WFlQL1U4QkgzNFhtMFRMbkZBMER1ZDI4clFWZnJt?=
 =?utf-8?B?Qmk3S29TYUhnUWFDS0ZaKzFsK0NOcFRuZ1l0ZDBpS0laUmozUytnRDZiUUJS?=
 =?utf-8?B?T3NWNFFIaEpNQ2h4alBEdS9YNmkzOEFNQUJ3T2JMblVZNXVRckl0QTFIMzhU?=
 =?utf-8?B?UjNJWFJlaHdCb3BKcXJvWW44MCtMeC9HUllQaC9HbWs2STJhbmplMm1TZ2wv?=
 =?utf-8?B?eDRxMjZPNGlvSlRJaC92SW9ncEpSNWRsK2hrang3aEJ5eU5FaHhWSWliZ1JJ?=
 =?utf-8?B?cHpVTEh0WnpkVEovcWgwMnBYc3NZWEQrN21IZ1h2RERRTGI5RHZvNW40TW1N?=
 =?utf-8?B?WUJTdXRBam85WFM2UXJsZlZLVjgyN0Z4b0JoYlo4WXVWeEtXNkhWVVo0b0JV?=
 =?utf-8?B?aTRBdUdFZ0JQbkhmUVFONkxSRE1Ga1l0WWNPMWw4aVlOL1MvSGxtcWxFY0Iz?=
 =?utf-8?Q?VIbNNGfhVyr3b60YAmS4NR30BVkWiUzj+F9cnj148?=
x-microsoft-antispam-prvs: <MWHPR0601MB36902F5FE8A7C3536B5CED32D3690@MWHPR0601MB3690.namprd06.prod.outlook.com>
x-forefront-prvs: 094213BFEA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39850400004)(396003)(136003)(376002)(346002)(189003)(199004)(4326008)(14454004)(476003)(6916009)(229853002)(2616005)(446003)(71190400001)(71200400001)(14444005)(256004)(99286004)(11346002)(478600001)(316002)(76176011)(54906003)(53936002)(86362001)(6116002)(3846002)(305945005)(6512007)(106356001)(6246003)(68736007)(6486002)(7736002)(486006)(105586002)(2351001)(66066001)(81166006)(81156014)(8676002)(103116003)(8936002)(2501003)(102836004)(2906002)(6506007)(6436002)(186003)(36756003)(97736004)(5640700003)(25786009)(93886005)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR0601MB3690;H:MWHPR0601MB3708.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: impinj.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: VsjXEY+9gYKov4nJAMFoko9KomAJbXQQ7PlOK+JJPpIoqVy7sD6gbGdXYiHrdr9CgHYTUmi93ofmQsaWTQq4WpPNNe5e9zJC1vYpzEfZQeSXc8aJu8mGpp1VFH4m50v8tzXbOT0zYwK95SnjQDPUwYRhB4FTgtepT7SBtMgzEURRAUcJfc0+ZPMsHk/KSuMr+qnbHfUkR6SIZw1yHVmJZlnzbGICQw66NQRsWtC565GOSAHCTtVgHKoexH1zrG+yNPYKKvjEZ5/7vKXPwvMvoUfYzB6p3DGysJKvpYYR7pNnQ+OmvMQULzD4+Ar3vnN9BNJeNiE6rZEIBlaHHw54nnfKsBOywGCiSLABlEEQMimG+cAy+wjhzlyzhVQP5o2yxXfv3EXCjM3lWjUkZaLzP0zL3j3XOAvx5CJLrDqdBmA=
Content-Type: text/plain; charset="utf-8"
Content-ID: <669587A004D0E341ACDFDB49D1119D85@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: impinj.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2818d3f9-dd59-4345-0552-08d68df1ec07
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2019 18:19:10.4130
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6de70f0f-7357-4529-a415-d8cbb7e93e5e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0601MB3690
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gRnJpLCAyMDE5LTAyLTA4IGF0IDEwOjE4ICswMDAwLCBMb3JlbnpvIFBpZXJhbGlzaSB3cm90
ZToNCj4gT24gVGh1LCBGZWIgMDcsIDIwMTkgYXQgMDY6MTU6NTJQTSArMDAwMCwgVHJlbnQgUGll
cGhvIHdyb3RlOg0KPiA+IE9uIFRodSwgMjAxOS0wMi0wNyBhdCAxMjozMSArMDAwMCwgTG9yZW56
byBQaWVyYWxpc2kgd3JvdGU6DQo+ID4gPiArCQkJLyogRGUtYXNzZXJ0IERDQ19GQl9FTiAqLw0K
PiA+ID4gPiArCQkJd3JpdGVsKFBDSUVfUEhZX0NNTl9SRUc0X0RDQ19GQl9FTiwNCj4gPiA+ID4g
KwkJCSAgICAgICBpbXg2X3BjaWUtPnBoeV9iYXNlICsgUENJRV9QSFlfQ01OX1JFRzQpOw0KPiA+
ID4gPiArCQkJLyogQXNzZXJ0IFJYX0VRUyBhbmQgUlhfRVFTX1NFTCAqLw0KPiA+ID4gPiArCQkJ
d3JpdGVsKFBDSUVfUEhZX0NNTl9SRUcyNF9SWF9FUV9TRUwNCj4gPiA+ID4gKwkJCQl8IFBDSUVf
UEhZX0NNTl9SRUcyNF9SWF9FUSwNCj4gPiA+ID4gKwkJCSAgICAgICBpbXg2X3BjaWUtPnBoeV9i
YXNlICsgUENJRV9QSFlfQ01OX1JFRzI0KTsNCj4gPiA+ID4gKwkJCS8qIEFzc2VydCBBVFRfTU9E
RSAqLw0KPiA+ID4gPiArCQkJd3JpdGVsKFBDSUVfUEhZX0NNTl9SRUcyNl9BVFRfTU9ERSwNCj4g
PiA+ID4gKwkJCSAgICAgICBpbXg2X3BjaWUtPnBoeV9iYXNlICsgUENJRV9QSFlfQ01OX1JFRzI2
KTsNCj4gPiA+ID4gKwkJfSBlbHNlIHsNCj4gPiA+ID4gKwkJCWRldl93YXJuKGRldiwgIkRUIGxh
Y2tzIGlteDdkLXBjaWUtcGh5LCB1bmFibGUgdG8gYXBwbHkgRVJSMDEwNzI4IHdvcmthcm91bmRc
biIpOw0KPiA+ID4gDQo+ID4gPiBJdCBpcyBhIG5pdCBidXQgdGhlIHdhcm5pbmcgbG9nIGlzIG5v
dCBuZWNlc3NhcmlseSB0cnVlIGllIHlvdSBtYXkgbm90DQo+ID4gPiBoYXZlIGEgbWFwcGVkIGFk
ZHJlc3MgZm9yIG90aGVyIHJlYXNvbnMgYXMgd2VsbC4gSXQgaXMgdXAgdG8geW91IGJ1dCBJDQo+
ID4gPiB3b3VsZCBjaGFuZ2UgdGhlIGxvZyBtZXNzYWdlLg0KPiA+IA0KPiA+IFRydWUsIGJ1dCBJ
IGhhcmRseSB3YW50IHRvIGVudW1lcmF0ZSBldmVyeSBwb3NzaWJsZSBmYWlsdXJlIHBvaW50IGlu
IGENCj4gPiBsb2cgbWVzc2FnZS4gIEhvdyBhYm91dDoNCj4gPiANCj4gPiBVbmFibGUgdG8gYXBw
bHkgRVJSMDEwNzI4IHdvcmthcm91bmQuICBEVCBsYWNrcyBpbXg3ZC1wY2llLXBoeT8NCj4gDQo+
IEkgd291bGQganVzdCBsb2cgIlVuYWJsZSB0byBhcHBseSBFUlIwMTA3Mjggd29ya2Fyb3VuZCIg
YnV0IGl0IGlzIHVwDQo+IHRvIHlvdS4gSSBjYW4gbWFrZSB0aGUgY2hhbmdlIG15c2VsZiB3aXRo
IG5vIG5lZWQgZm9yIHJlcG9zdGluZy4NCg0KSSB3YXMgZm9sbG93aW5nIEx1Y2FzJ3MgY29tbWVu
dCBvbiB0aGUgdjEgdmVyc2lvbjoNCg0KICAgdGhlIHVzZXIuIEl0IHdvdWxkIGJlIGJldHRlciB0
byBoYXZlIHNvbWV0aGluZyBsaWtlICJObyBhY2Nlc3MgdG8NCiAgIFBIWSByZWdpc3RlcnMsIGNh
bid0IGFwcGx5IHdvcmthcm91bmQgZm9yIEVSUjAxMDcyOC4iIE1heWJlIGV2ZW4NCiAgIHdpdGgg
YSBoaW50IHRvIHVwZGF0ZSB0aGUgRFQuDQoNCkkgdGhpbmsgdGhlIHByZXR0eSBtdWNoIHRoZSBv
bmx5IHdheSBhbnkgb2YgdGhlIGVycm9ycyBjb25kaXRpb25zIHdpbGwNCmdldCBoaXQsIGlzIHdo
ZW4gc29tZW9uZSB3aXRoIGFuIG9sZCBEVCBydW5zIGEgbmV3IGtlcm5lbC4gIFNvIHRoZSBoaW50
DQphYm91dCB0aGUgRFQgY2hhbmdlIG1pZ2h0IGJlIGFjdHVhbGx5IHVzZWZ1bCB0byBzb21lIHVz
ZXJzLg0KDQpCdXQgaXQncyBub3QgYSBiaWcgZGVhbCBzbyBqdXN0IGNoYW5nZSBpdCB0byB3aGF0
ZXZlciB3aGVuIGFwcGx5aW5nIHRoZQ0KcGF0Y2gu

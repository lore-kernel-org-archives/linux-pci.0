Return-Path: <SRS0=Xdj1=O6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E2E4C43387
	for <linux-pci@archiver.kernel.org>; Fri, 21 Dec 2018 00:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D46DF218E2
	for <linux-pci@archiver.kernel.org>; Fri, 21 Dec 2018 00:42:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kpDdRWNK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731072AbeLUAmb (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 20 Dec 2018 19:42:31 -0500
Received: from mail-eopbgr40083.outbound.protection.outlook.com ([40.107.4.83]:36480
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727993AbeLUAmb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 20 Dec 2018 19:42:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XCc+cAHcGNnkmD/I1Phdzco9jvi8CVLOHY06qlZDfsc=;
 b=kpDdRWNKQAO5yF0hcxwiJKOPWk8Ec14SVQrefebSy+osSetRWt/lpe7YIY6vPDxObDkPomVluENVv1EH+UL7Yy9tSW7gJw5LYBkk4lLT324p3TVCQb2Diqlp/Yxk8cPJ9ZcmpWAzqQV+RmRA+m5z+tLIzOZL+M2wjh3yATJPFqU=
Received: from AM6PR0402MB3573.eurprd04.prod.outlook.com (52.133.20.10) by
 AM6PR0402MB3381.eurprd04.prod.outlook.com (52.133.19.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.17; Fri, 21 Dec 2018 00:42:26 +0000
Received: from AM6PR0402MB3573.eurprd04.prod.outlook.com
 ([fe80::7862:1b29:2780:1864]) by AM6PR0402MB3573.eurprd04.prod.outlook.com
 ([fe80::7862:1b29:2780:1864%2]) with mapi id 15.20.1446.020; Fri, 21 Dec 2018
 00:42:26 +0000
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [v5] PCI: imx: make msi work without CONFIG_PCIEPORTBUS=y
Thread-Topic: [v5] PCI: imx: make msi work without CONFIG_PCIEPORTBUS=y
Thread-Index: AQHUl1WbXQWlL+2nZEakdL9950YJ4KWHt+AAgAClH6A=
Date:   Fri, 21 Dec 2018 00:42:26 +0000
Message-ID: <AM6PR0402MB35733F13FC24CFB68D07179F8CB80@AM6PR0402MB3573.eurprd04.prod.outlook.com>
References: <1545193599-11604-1-git-send-email-hongxing.zhu@nxp.com>
 <20181220144956.GA7041@e107981-ln.cambridge.arm.com>
In-Reply-To: <20181220144956.GA7041@e107981-ln.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=hongxing.zhu@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR0402MB3381;6:hDE+umk/nf3WQ4BhDW8sGSTw1eg7lfcnnPZMDhmJyYy9RbUV+bV6+1UoxYRetFSfSSdrTyud6MHq71LnNqKYMEzW2548BE4e4eBPyuIFB2VFjxOXtwenoj6K+WeRFd09v4RUdna7RAsyOOUkvZ48OanVwOvsE6rqCNmi7dosyALIMMuBStrLHGus8nRJKx2rA9R1FHzPfG919cZZEtPpheAt78CEYOUAWrxauxBOoxKF4dFr/fmNKQnTZkC/cPfairOXC3HmWgfP1TZ6ihKlhA5vwn53GKHPw0t4jl3eMHyMRLqu8NUwcfSRoDR54RDlmdO5cpOpP0PccA15CZlPPVBt+10jAF6tY1bLed00NHvvZt0szXygkcrLzDgi5V3BYCpeMHI/u1632HS50YSkPM4YLKbliK4WxYcXneXcX0THE8ZzVErPYYnSr73zRdHjlhkJZEwFuPcxRs3NAH3q7w==;5:KA+bT+cj5JrCnj4Oxfi+QvbJ+umM1cx/jg/kgHMZNFFz7wXRgCQoyLDKGU2U2ohnhoieOGLyXn5zwrCoZ/wD1LWihvkueOYq7buUNnXupTl7ItbAcyuvybaq95xzOSyl0WYAzSciIvU+caECgIVkOPPgx5aREeELMW3OTYnLynA=;7:lT2fAXXPi1h9d8bymQ9YT/nuc0P49/U1mS2ycfnT4mydjMC9KVpXqBVkHEe0qBvWDoQiCBB0g12dJTSEMgKp+3jVUxVCn0s9jffJQcmF+9uCf6T079VhoT31B9vL8qUohS1JVycnVStl/aPELQer8Q==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 87f2c626-479a-432e-053e-08d666dd2e0e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR0402MB3381;
x-ms-traffictypediagnostic: AM6PR0402MB3381:
x-microsoft-antispam-prvs: <AM6PR0402MB3381B6D1D5BE8E8314DFAFB08CB80@AM6PR0402MB3381.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(5005026)(6040522)(2401047)(8121501046)(3231475)(944501520)(52105112)(93006095)(93001095)(10201501046)(3002001)(6055026)(149066)(150057)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:AM6PR0402MB3381;BCL:0;PCL:0;RULEID:;SRVR:AM6PR0402MB3381;
x-forefront-prvs: 0893636978
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(396003)(136003)(39860400002)(376002)(13464003)(199004)(189003)(6246003)(66066001)(6116002)(3846002)(97736004)(305945005)(7696005)(54906003)(6436002)(26005)(86362001)(186003)(102836004)(256004)(2906002)(14444005)(5660300001)(575784001)(316002)(74316002)(966005)(486006)(45080400002)(478600001)(476003)(11346002)(99286004)(14454004)(229853002)(53546011)(6506007)(25786009)(76176011)(6916009)(105586002)(53936002)(33656002)(71190400001)(71200400001)(55016002)(446003)(39060400002)(8936002)(8676002)(81156014)(81166006)(7736002)(4326008)(9686003)(6306002)(68736007)(106356001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3381;H:AM6PR0402MB3573.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Y74+w5+qv0c90zejaq6dYOihNJwI6cBSBwM2xU3IIqOis0CBCNlkHQECrMB7RvOwgFLhpVwu/CoE515MXRxXKK011RtVsJJlSuQBNxvk/FDd1T/xgUs/hvftRlOS6ZhSnZ37sSgq+IdMM4N59GGbEDcdyvHelbHI0DT0U25IUPNgNjrHqi+yDb2FekRq4TisW9u53GFKYjbGJvHaTh5KlfPMMjropp9Csyrpq63ECNDKuracDVzKmH9Ru86nJaepIYsOEB8GC9GNW+foYnxfZp71pSG9n33XuHfGGFqTxYGdsERb3r/snLDApJTz0FZ4
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87f2c626-479a-432e-053e-08d666dd2e0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2018 00:42:26.5355
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3381
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgTG9yZW56bzoNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMb3Jl
bnpvIFBpZXJhbGlzaSBbbWFpbHRvOmxvcmVuem8ucGllcmFsaXNpQGFybS5jb21dDQo+IFNlbnQ6
IDIwMTjE6jEy1MIyMMjVIDIyOjUwDQo+IFRvOiBSaWNoYXJkIFpodSA8aG9uZ3hpbmcuemh1QG54
cC5jb20+DQo+IENjOiBiaGVsZ2Fhc0Bnb29nbGUuY29tOyBsLnN0YWNoQHBlbmd1dHJvbml4LmRl
Ow0KPiBhbmRyZXcuc21pcm5vdkBnbWFpbC5jb207IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7
DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZn
ZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW3Y1XSBQQ0k6IGlteDogbWFrZSBtc2kgd29y
ayB3aXRob3V0IENPTkZJR19QQ0lFUE9SVEJVUz15DQo+IA0KPiBPbiBXZWQsIERlYyAxOSwgMjAx
OCBhdCAwNDo0NTowNEFNICswMDAwLCBSaWNoYXJkIFpodSB3cm90ZToNCj4gPiBBc3NlcnRpb24g
b2YgdGhlIE1TSSBFbmFibGUgYml0IG9mIFJDJ3MgTVNJIENBUCBpcyBtYW5kYXRvcnkgcmVxdWly
ZWQNCj4gPiB0byB0cmlnZ2VyIE1TSSBvbiBpLk1YNiBQQ0llLg0KPiA+IFRoaXMgYml0IHdvdWxk
IGJlIGFzc2VydGVkIHdoZW4gQ09ORklHX1BDSUVQT1JUQlVTPXkuDQo+ID4gVGh1cywgdGhlIE1T
SSB3b3JrcyBmaW5lIG9uIGkuTVg2IFBDSWUgYmVmb3JlIHRoZSBjb21taXQgImYzZmRmYzQiLg0K
PiA+DQo+ID4gQXNzZXJ0IGl0IHVuY29uZGl0aW9uYWxseSB3aGVuIE1TSSBpcyBlbmFibGVkLg0K
PiA+IE90aGVyd2lzZSwgdGhlIE1TSSB3b3VsZG4ndCBiZSB0cmlnZ2VyZWQgYWx0aG91Z2ggdGhl
IEVQIGlzIHByZXNlbnQNCj4gPiBhbmQgdGhlIE1TSXMgYXJlIGFzc2lnbmVkLg0KPiA+DQo+ID4g
U2lnbmVkLW9mZi1ieTogUmljaGFyZCBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0KPiA+IFJl
dmlld2VkLWJ5OiBMdWNhcyBTdGFjaCA8bC5zdGFjaEBwZW5ndXRyb25peC5kZT4NCj4gPiAtLS0N
Cj4gPiBDaGFuZ2VzIHYxIC0+IHYyOg0KPiA+ICogQXNzZXJ0IHRoZSBNU0lfRU4gdW5jb25kaXRp
b25hbGx5IHdoZW4gTVNJIGlzIHN1cHBvcnRlZC4NCj4gPiBDaGFuZ2VzIHYyIC0+IHYzOg0KPiA+
ICogUmVtb3ZlIHRoZSBJU19FTkFCTEVEKENPTkZJR19QQ0lfTVNJKSBzaW5jZSB0aGUgZHJpdmVy
IGRlcGVuZHMgb24NCj4gPiBQQ0lfTVNJX0lSUV9ET01BSU4NCj4gPiAqIEV4dGVuZGVkIHdpdGgg
YSBjaGVjayBmb3IgcGNpX21zaV9lbmFibGVkKCkgdG8gc2VlIGlmIHRoZSB1c2VyDQo+ID4gZXhw
bGljaXRseSB3YW50IGxlZ2FjeSBJUlFzIENoYW5nZXMgdjMgLT4gdjQ6DQo+ID4gKiBSZWZlciB0
byBCam9ybidzIGNvbW1lbnRzLCByZWZpbmUgdGhlIHN1YmplY3QgYW5kIGNvbW1pdCBsb2cgYW5k
DQo+ID4gY2hhbmdlIHRoZSBQQ0lfTVNJX0NBUCB0byBQQ0lFX1JDX0lNWDZfTVNJX0NBUC4NCj4g
PiBDaGFuZ2VzIHY0IC0+IHY1Og0KPiA+ICogQ29ycmVjdCBvbmUgc3BlbGwgbWlzdGFrZSBmcm9t
IFBDSUVfUkNfTVNJX0lNWDZfQ0FQIHRvDQo+ID4gUENJRV9SQ19JTVg2X01TSV9DQVAuDQo+ID4g
LS0tDQo+ID4gIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMgfCAxMCArKysr
KysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYuYw0KPiA+IGIv
ZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYuYw0KPiA+IGluZGV4IGU1NjNjYTku
LjczNTQyZGQgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNp
LWlteDYuYw0KPiA+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMN
Cj4gPiBAQCAtODIsNiArODIsNyBAQCBzdHJ1Y3QgaW14Nl9wY2llIHsNCj4gPiAgI2RlZmluZSBQ
SFlfUExMX0xPQ0tfV0FJVF9VU0xFRVBfTUFYCTIwMA0KPiA+DQo+ID4gIC8qIFBDSWUgUm9vdCBD
b21wbGV4IHJlZ2lzdGVycyAobWVtb3J5LW1hcHBlZCkgKi8NCj4gPiArI2RlZmluZSBQQ0lFX1JD
X0lNWDZfTVNJX0NBUAkJCTB4NTANCj4gPiAgI2RlZmluZSBQQ0lFX1JDX0xDUgkJCQkweDdjDQo+
ID4gICNkZWZpbmUgUENJRV9SQ19MQ1JfTUFYX0xJTktfU1BFRURTX0dFTjEJMHgxDQo+ID4gICNk
ZWZpbmUgUENJRV9SQ19MQ1JfTUFYX0xJTktfU1BFRURTX0dFTjIJMHgyDQo+ID4gQEAgLTk5OSw2
ICsxMDAwLDcgQEAgc3RhdGljIGludCBpbXg2X3BjaWVfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2Rl
dmljZQ0KPiAqcGRldikNCj4gPiAgCXN0cnVjdCByZXNvdXJjZSAqZGJpX2Jhc2U7DQo+ID4gIAlz
dHJ1Y3QgZGV2aWNlX25vZGUgKm5vZGUgPSBkZXYtPm9mX25vZGU7DQo+ID4gIAlpbnQgcmV0Ow0K
PiA+ICsJdTE2IHZhbDsNCj4gPg0KPiA+ICAJaW14Nl9wY2llID0gZGV2bV9remFsbG9jKGRldiwg
c2l6ZW9mKCppbXg2X3BjaWUpLCBHRlBfS0VSTkVMKTsNCj4gPiAgCWlmICghaW14Nl9wY2llKQ0K
PiA+IEBAIC0xMTQ5LDYgKzExNTEsMTQgQEAgc3RhdGljIGludCBpbXg2X3BjaWVfcHJvYmUoc3Ry
dWN0DQo+IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gPiAgCWlmIChyZXQgPCAwKQ0KPiA+ICAJ
CXJldHVybiByZXQ7DQo+ID4NCj4gPiArCWlmIChwY2lfbXNpX2VuYWJsZWQoKSkgew0KPiA+ICsJ
CXZhbCA9IGR3X3BjaWVfcmVhZHdfZGJpKHBjaSwgUENJRV9SQ19JTVg2X01TSV9DQVAgKw0KPiA+
ICsJCQkJUENJX01TSV9GTEFHUyk7DQo+ID4gKwkJdmFsIHw9IFBDSV9NU0lfRkxBR1NfRU5BQkxF
Ow0KPiA+ICsJCWR3X3BjaWVfd3JpdGV3X2RiaShwY2ksIFBDSUVfUkNfSU1YNl9NU0lfQ0FQICsN
Cj4gPiArCQkJCVBDSV9NU0lfRkxBR1MsIHZhbCk7DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICAJcmV0
dXJuIDA7DQo+ID4gIH0NCj4gDQo+IEhpIFJpY2hhcmQsDQo+IA0KPiB0aGUgcGF0Y2ggaXMgT0sg
d2l0aCBtZSAoZXZlbiB0aG91Z2ggSSBoYXZlIHRvIHRha2UgZm9yIGdyYW50ZWQgaG93IHRoZSBJ
TVgNCj4gTVNJIGxvZ2ljIHdvcmtzKSwgdGhlIGNvbW1pdCBsb2cgaXNuJ3QuIFNvIHBsZWFzZSB1
cGRhdGUgaXQgd2l0aCBCam9ybidzIHZlcnNpb246DQo+IA0KPiBodHRwczovL2VtZWEwMS5zYWZl
bGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGbG9yZS4NCj4g
a2VybmVsLm9yZyUyRmxpbnV4LXBjaSUyRjIwMTgxMjE5MTQxMjQxLkdCMTI3NjMlNDBnb29nbGUu
Y29tJTJGJmENCj4gbXA7ZGF0YT0wMiU3QzAxJTdDaG9uZ3hpbmcuemh1JTQwbnhwLmNvbSU3Qzhk
NGMzMTI3MmU5ZjQxMjk4ZWENCj4gOTA4ZDY2NjhhNmY0NyU3QzY4NmVhMWQzYmMyYjRjNmZhOTJj
ZDk5YzVjMzAxNjM1JTdDMCU3QzAlN0M2Mw0KPiA2ODA5MTQyMDkzNDU5NDM3JmFtcDtzZGF0YT1m
S3BTQzJMOFRwQzIxN2VmNHVYTFglMkZ5bHZuckN3cDM4VWcNCj4gbjhiTVd2ak84JTNEJmFtcDty
ZXNlcnZlZD0wDQo+IA0KPiAqaW5jbHVzaXZlKiBvZiB0aGUgRml4ZXM6IHRhZy4NCj4gDQo+IFdp
dGggdGhlIGNvbW1pdCBsb2cgdXBkYXRlZCBhcyBwZXIgdGhlIGxpbmsgYWJvdmU6DQo+IA0KPiBB
Y2tlZC1ieTogTG9yZW56byBQaWVyYWxpc2kgPGxvcmVuem8ucGllcmFsaXNpQGFybS5jb20+DQpb
UmljaGFyZCBaaHVdIFRoYW5rcy4gSSB3b3VsZCBzZW5kIG91dCBuZXh0IHZlcnNpb24gd2l0aCBC
am9ybidzIGNvbW1pdHMgbGF0ZXIuDQo=

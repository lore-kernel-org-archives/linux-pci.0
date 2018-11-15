Return-Path: <SRS0=ulVR=N2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD42DC43441
	for <linux-pci@archiver.kernel.org>; Thu, 15 Nov 2018 02:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 859BE22360
	for <linux-pci@archiver.kernel.org>; Thu, 15 Nov 2018 02:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="vgtgURhz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 859BE22360
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725895AbeKOM4l (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 15 Nov 2018 07:56:41 -0500
Received: from mail-eopbgr130087.outbound.protection.outlook.com ([40.107.13.87]:6374
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726379AbeKOM4l (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Nov 2018 07:56:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4grjuHVZEKGo7CWXPKiUlbmOKDyAPlf7EY+1+GNRGpw=;
 b=vgtgURhzL5gZt6OqhZW3PD6o0ydd0m4A8rS8EwqTAHmqGk5IUHtlk4shZ8V1Aa1hKK2RmooaFOTx1bVWgMyc6jZYyWlJ0Tjhpf4C9cir815ggHcCwQ4shU5yBnGc+q1nJSTQ975gKRboXSufROvh7uZ1jfEed4ZjKE3EE/QcOdg=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.2.80) by
 AM6PR04MB4006.eurprd04.prod.outlook.com (52.135.160.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Thu, 15 Nov 2018 02:47:43 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::7d93:8053:57fd:1a00]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::7d93:8053:57fd:1a00%3]) with mapi id 15.20.1294.045; Thu, 15 Nov 2018
 02:47:43 +0000
From:   "Z.q. Hou" <zhiqiang.hou@nxp.com>
To:     Leo Li <leoyang.li@nxp.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "l.subrahmanya@mobiveil.co.in" <l.subrahmanya@mobiveil.co.in>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
CC:     Mingkai Hu <mingkai.hu@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>
Subject: RE: [PATCH 21/23] dt-bindings: pci: Add NXP LX SoCs PCIe controller
Thread-Topic: [PATCH 21/23] dt-bindings: pci: Add NXP LX SoCs PCIe controller
Thread-Index: AQHUddOaH+hnWiOCjEOD1szvFZnE86VGaH0AgAT7B8CABEcAgIAAgbEg
Date:   Thu, 15 Nov 2018 02:47:43 +0000
Message-ID: <AM6PR04MB57813AB3D57856CDD7F5376084DC0@AM6PR04MB5781.eurprd04.prod.outlook.com>
References: <20181106131807.29951-1-Zhiqiang.Hou@nxp.com>
 <20181106131807.29951-22-Zhiqiang.Hou@nxp.com>
 <AM6PR04MB58639AF03E732FCF491113728FC50@AM6PR04MB5863.eurprd04.prod.outlook.com>
 <AM6PR04MB57816EE50C61E064E6DC73A684C10@AM6PR04MB5781.eurprd04.prod.outlook.com>
 <AM6PR04MB5863192E246F3ED6F5812E4F8FC30@AM6PR04MB5863.eurprd04.prod.outlook.com>
In-Reply-To: <AM6PR04MB5863192E246F3ED6F5812E4F8FC30@AM6PR04MB5863.eurprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR04MB4006;6:mYVrLvhJwb3Yv4lP7BA52y5ibravypoLaUbnLVazdxvpUZ8hhjw3H3UQBReFRorM4SaSu1K6G763VKc3494Y1Pv9NyveBokiopW+aP04cNJVQi5cn/FGiClCYTAIIcLsEZ4R6B+AimIsdshaqUVnMr1imCu3VfbSk781vMCaWQ9ABAATIWvnMARRUOFRe4mg9hX0UuMAgT2cKGC2WQeq+0fqu0Grk/bxLPvl1vveiYn6swtpup1Xux5HCmSrIUf8HtZuDMo+UT19fVJ8WXSe99J40kzANLUVtf9bFpMeC2JA3csr1EieBqxYVrdpl+l7ykw0aVPKvz4CzGnC1mH3kwANBL3WXazaHOZiyMCMQ2ojIj0YYeRj4xjI9+is/zLcZB2C//DHcHTZypnmdNCpF36Wh384sOoZBXBC0ddmMVbdL5oR5gxfULGXh+dsVPaykdf/3N/dgfa646Z21zewmg==;5:vUCYCoq6umD/DnXo4niLsSoKHjqSrcde9+QGd/Ku65BY0F6Co6rmHkycZy8E95WfzdGVjAjJLj7/bMXGmAJE44kADXYlS9p44x8fqMi9aFoGCtoG+nVSqNXO6RRIGSDKFLiapP7uoxhEyxzJfxvDnLkL8IfCa8fAmCN7Y3s2QyQ=;7:s4u1j7qL8MGor/TV9qcOjjsAaciSHEXeWAIQBByxehoZuVua1wX265J27IqZhMzSjsICpNyB5ncM7w2ZE8zUZQlOzEIVIbdHh1eMCwDYh9+0oma3g14HCtYRLcPUavJdZ5kl8c+rSiSTKkZAyO865g==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 62a6f93c-443e-4f30-521f-08d64aa4b7c9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4006;
x-ms-traffictypediagnostic: AM6PR04MB4006:
x-microsoft-antispam-prvs: <AM6PR04MB4006110C65A26180D9736D0284DC0@AM6PR04MB4006.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(258649278758335)(211936372134217)(180628864354917)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231415)(944501410)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:AM6PR04MB4006;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB4006;
x-forefront-prvs: 08572BD77F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(6029001)(346002)(136003)(376002)(39860400002)(366004)(396003)(199004)(189003)(13464003)(93886005)(7736002)(33656002)(102836004)(6246003)(97736004)(14454004)(186003)(229853002)(316002)(305945005)(76176011)(5660300001)(6506007)(2900100001)(7416002)(53546011)(256004)(74316002)(105586002)(106356001)(26005)(478600001)(68736007)(25786009)(110136005)(99286004)(7696005)(81166006)(8676002)(2501003)(81156014)(53936002)(55016002)(54906003)(6116002)(8936002)(446003)(71190400001)(6436002)(71200400001)(4326008)(476003)(2906002)(66066001)(86362001)(2201001)(486006)(11346002)(9686003)(3846002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4006;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: QiFdf11DUVMDsMGRtG2cG0sZ8ehAyPYY9vX/zE8O8NFvadPkKDBhkD/ZznGin186s4h3eVqJrLtXBXL7B5Jvnpv6J2VeZblAA2t5frvMUVOdd7vfjJRlAFQK600Kw4DV/vCzovAIRLei3rd2kltPYnWVY56V5fjLQEmEFgouQ0ilrW2TVq5/VMbMUOW9WOMc3jPvvUYn8Mo5Gg+4uLPlU774rQMsdQB1zlwoAyR2mGs2CbIrU9iESu8o/vG0VdiYuNAK9Qv+rgH2zos8snuP7koK6vp4EnabTNHzWRwPQ4NCoD0UociIcEvdrxEocAeszhD9IKoS3jtCwTS94tygF7XofTcWFOx/4ibMII+J4bo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62a6f93c-443e-4f30-521f-08d64aa4b7c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2018 02:47:43.7369
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4006
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgTGVvLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IExlbyBMaQ0K
PiBTZW50OiAyMDE4xOoxMdTCMTXI1SAyOjUyDQo+IFRvOiBaLnEuIEhvdSA8emhpcWlhbmcuaG91
QG54cC5jb20+OyBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1hcm0ta2VybmVs
QGxpc3RzLmluZnJhZGVhZC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBiaGVsZ2Fhc0Bnb29nbGUuY29tOyByb2JoK2R0QGtl
cm5lbC5vcmc7DQo+IG1hcmsucnV0bGFuZEBhcm0uY29tOyBsLnN1YnJhaG1hbnlhQG1vYml2ZWls
LmNvLmluOw0KPiBzaGF3bmd1b0BrZXJuZWwub3JnOyBsb3JlbnpvLnBpZXJhbGlzaUBhcm0uY29t
DQo+IENjOiBNaW5na2FpIEh1IDxtaW5na2FpLmh1QG54cC5jb20+OyBNLmguIExpYW4NCj4gPG1p
bmdodWFuLmxpYW5AbnhwLmNvbT47IFhpYW93ZWkgQmFvIDx4aWFvd2VpLmJhb0BueHAuY29tPg0K
PiBTdWJqZWN0OiBSRTogW1BBVENIIDIxLzIzXSBkdC1iaW5kaW5nczogcGNpOiBBZGQgTlhQIExY
IFNvQ3MgUENJZSBjb250cm9sbGVyDQo+IA0KPiANCj4gDQo+ID4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gPiBGcm9tOiBaLnEuIEhvdQ0KPiA+IFNlbnQ6IFN1bmRheSwgTm92ZW1iZXIg
MTEsIDIwMTggNTo0OCBQTQ0KPiA+IFRvOiBMZW8gTGkgPGxlb3lhbmcubGlAbnhwLmNvbT47IGxp
bnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS0NCj4gPiBrZXJuZWxAbGlzdHMuaW5m
cmFkZWFkLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiA+IGtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmc7IGJoZWxnYWFzQGdvb2dsZS5jb207IHJvYmgrZHRAa2VybmVsLm9y
ZzsNCj4gPiBtYXJrLnJ1dGxhbmRAYXJtLmNvbTsgbC5zdWJyYWhtYW55YUBtb2JpdmVpbC5jby5p
bjsNCj4gPiBzaGF3bmd1b0BrZXJuZWwub3JnOyBsb3JlbnpvLnBpZXJhbGlzaUBhcm0uY29tDQo+
ID4gQ2M6IE1pbmdrYWkgSHUgPG1pbmdrYWkuaHVAbnhwLmNvbT47IE0uaC4gTGlhbg0KPiA+IDxt
aW5naHVhbi5saWFuQG54cC5jb20+OyBYaWFvd2VpIEJhbyA8eGlhb3dlaS5iYW9AbnhwLmNvbT4N
Cj4gPiBTdWJqZWN0OiBSRTogW1BBVENIIDIxLzIzXSBkdC1iaW5kaW5nczogcGNpOiBBZGQgTlhQ
IExYIFNvQ3MgUENJZQ0KPiA+IGNvbnRyb2xsZXINCj4gPg0KPiA+IEhpIExlbywNCj4gPg0KPiA+
IFRoYW5rcyBhIGxvdCBmb3IgeW91ciBjb21tZW50cyENCj4gPg0KPiA+ID4gLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206IExlbyBMaQ0KPiA+ID4gU2VudDogMjAxOMTqMTHU
wjnI1SA1OjI5DQo+ID4gPiBUbzogWi5xLiBIb3UgPHpoaXFpYW5nLmhvdUBueHAuY29tPjsgbGlu
dXgtcGNpQHZnZXIua2VybmVsLm9yZzsNCj4gPiA+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5m
cmFkZWFkLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7DQo+ID4gPiBsaW51eC1rZXJu
ZWxAdmdlci5rZXJuZWwub3JnOyBiaGVsZ2Fhc0Bnb29nbGUuY29tOw0KPiA+ID4gcm9iaCtkdEBr
ZXJuZWwub3JnOyBtYXJrLnJ1dGxhbmRAYXJtLmNvbTsNCj4gPiA+IGwuc3VicmFobWFueWFAbW9i
aXZlaWwuY28uaW47IHNoYXduZ3VvQGtlcm5lbC5vcmc7DQo+ID4gPiBsb3JlbnpvLnBpZXJhbGlz
aUBhcm0uY29tDQo+ID4gPiBDYzogTWluZ2thaSBIdSA8bWluZ2thaS5odUBueHAuY29tPjsgTS5o
LiBMaWFuDQo+ID4gPiA8bWluZ2h1YW4ubGlhbkBueHAuY29tPjsgWGlhb3dlaSBCYW8gPHhpYW93
ZWkuYmFvQG54cC5jb20+DQo+ID4gPiBTdWJqZWN0OiBSRTogW1BBVENIIDIxLzIzXSBkdC1iaW5k
aW5nczogcGNpOiBBZGQgTlhQIExYIFNvQ3MgUENJZQ0KPiA+ID4gY29udHJvbGxlcg0KPiA+ID4N
Cj4gPiA+DQo+ID4gPg0KPiA+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4g
PiBGcm9tOiBaLnEuIEhvdQ0KPiA+ID4gPiBTZW50OiBUdWVzZGF5LCBOb3ZlbWJlciA2LCAyMDE4
IDc6MjEgQU0NCj4gPiA+ID4gVG86IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7DQo+ID4gPiA+
IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4gPiA+ID4gZGV2aWNldHJl
ZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+ID4gPiA+
IGJoZWxnYWFzQGdvb2dsZS5jb207IHJvYmgrZHRAa2VybmVsLm9yZzsgbWFyay5ydXRsYW5kQGFy
bS5jb207DQo+ID4gPiA+IGwuc3VicmFobWFueWFAbW9iaXZlaWwuY28uaW47IHNoYXduZ3VvQGtl
cm5lbC5vcmc7IExlbyBMaQ0KPiA+ID4gPiA8bGVveWFuZy5saUBueHAuY29tPjsgbG9yZW56by5w
aWVyYWxpc2lAYXJtLmNvbQ0KPiA+ID4gPiBDYzogTWluZ2thaSBIdSA8bWluZ2thaS5odUBueHAu
Y29tPjsgTS5oLiBMaWFuDQo+ID4gPiA+IDxtaW5naHVhbi5saWFuQG54cC5jb20+OyBYaWFvd2Vp
IEJhbyA8eGlhb3dlaS5iYW9AbnhwLmNvbT47IFoucS4NCj4gPiA+IEhvdQ0KPiA+ID4gPiA8emhp
cWlhbmcuaG91QG54cC5jb20+DQo+ID4gPiA+IFN1YmplY3Q6IFtQQVRDSCAyMS8yM10gZHQtYmlu
ZGluZ3M6IHBjaTogQWRkIE5YUCBMWCBTb0NzIFBDSWUNCj4gPiA+ID4gY29udHJvbGxlcg0KPiA+
ID4gPg0KPiA+ID4gPiBGcm9tOiBIb3UgWmhpcWlhbmcgPFpoaXFpYW5nLkhvdUBueHAuY29tPg0K
PiA+ID4gPg0KPiA+ID4gPiBBZGQgUENJZSBjb250cm9sbGVyIERUIGJpbmRpbmdzIG9mIE5YUCBM
WCBzZXJpZXMgU29Dcy4NCj4gPiA+DQo+ID4gPiBJJ20gbm90IHN1cmUgaWYgdGhpcyBpcyBhIGdv
b2QgaWRlYSB0byBuYW1lIHRoaXMgY29udHJvbGxlciBMWCBQQ0llIGNvbnRyb2xsZXIuDQo+ID4g
PiBSaWdodCBub3csIGl0IGNvdWxkIGJlIHRydWUgdGhhdCBpdCBpcyBvbmx5IHVzZWQgb24gTFgg
c2VyaWVzIFNvQ3MuDQo+ID4gPiBCdXQgSSdtIG5vdCBzdXJlIGlmIHRoZSBMUyBzZXJpZXMgd2ls
bCBub3QgdXNlIHRoaXMgY29udHJvbGxlciBvciBMWA0KPiA+ID4gc2VyaWVzIHdpbGwgb25seSB1
c2UgdGhpcyBjb250cm9sbGVyIGluIHRoZSBmdXR1cmUuDQo+ID4gPg0KPiA+ID4gU2luY2UgdGhl
IExYIHNlcmllcyBpcyBzdGlsbCB1c2luZyB0aGUgbGF5ZXJzY2FwZSBicmFuZGluZywgc28NCj4g
PiA+IHByb2JhYmx5IHdlIHNob3VsZCBrZWVwIHVzaW5nIHRoZSBsYXllcnNjYXBlLXBjaS50eHQg
YW5kIGRlZmluZSB0aGUNCj4gPiA+IFBDSWUNCj4gPiBHZW40IHZhcmlhbnQ/DQo+ID4NCj4gPiBZ
ZXMsIHdpbGwgYWRkIHRoZSBuZXcgUENJZSBJUCBiaW5kaW5ncyB0byBMYXllcnNjYXBlLXBjaS50
eHQuDQo+ID4NCj4gPiA+DQo+ID4gPiBTYW1lIGNvbW1lbnQgZm9yIG90aGVyIHBsYWNlcyB1c2lu
ZyB0aGUgTFggbmFtaW5nIGluIHRoaXMgZHJpdmVyLg0KPiA+DQo+ID4gRG8geW91IGhhdmUgYW55
IHN1Z2dlc3Rpb24gYWJvdXQgaG93IHRvIG5hbWUgdGhlIGRyaXZlciBhbmQgcHJlZml4IG9mDQo+
ID4gc3RydWN0dXJlcyBpbiB0aGUgZHJpdmVyPw0KPiANCj4gUHJvYmFibHkgc29tZXRoaW5nIGxp
a2UgcGNpZS1sYXllcnNjYXBlLWdlbjQ/DQoNClRoYW5rcyBmb3IgeW91ciBzdWdnZXN0aW9uIQ0K
IA0KVGhhbmtzLA0KWmhpcWlhbmcNCg==

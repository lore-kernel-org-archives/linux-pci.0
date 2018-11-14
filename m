Return-Path: <SRS0=Q3Ib=NZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC44DC04EBC
	for <linux-pci@archiver.kernel.org>; Wed, 14 Nov 2018 22:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68AB620868
	for <linux-pci@archiver.kernel.org>; Wed, 14 Nov 2018 22:32:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=impinj.com header.i=@impinj.com header.b="KJpsZMdh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68AB620868
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=impinj.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388954AbeKOIaq (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 15 Nov 2018 03:30:46 -0500
Received: from mail-eopbgr770121.outbound.protection.outlook.com ([40.107.77.121]:22206
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731448AbeKOIap (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Nov 2018 03:30:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=impinj.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E1Jm+3GCE7wie/B/u5h6aQQqMOlmadh8aXoIDmNqKXU=;
 b=KJpsZMdh2Bwjn0AOxJOODyikrSDKhztAvDMgVT2SMpdl5HPK8l3Zqvh8CNSnyuPJlMIgBfRhmsD+ovOfhKqSdN2ZU4hYKwW06hUJYhR24L1hPm4d/zDmpVTzNH0H4Uc4EvbALCt5EbmwHQcRYTIdOeDz2EU7yFT2P00M2sCMlY4=
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com (10.167.236.38) by
 MWHPR0601MB3643.namprd06.prod.outlook.com (10.167.236.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Wed, 14 Nov 2018 22:25:37 +0000
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::f51a:d8dd:1aad:3bf9]) by MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::f51a:d8dd:1aad:3bf9%3]) with mapi id 15.20.1294.045; Wed, 14 Nov 2018
 22:25:37 +0000
From:   Trent Piepho <tpiepho@impinj.com>
To:     "marc.zyngier@arm.com" <marc.zyngier@arm.com>
CC:     "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "faiz_abbas@ti.com" <faiz_abbas@ti.com>,
        "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "helgaas@google.com" <helgaas@google.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>
Subject: Re: [PATCH 0/3] PCI: designware: Fixing MSI handling flow
Thread-Topic: [PATCH 0/3] PCI: designware: Fixing MSI handling flow
Thread-Index: AQHUe6RNjvB+uYCyEUiVT8YH/lgHCqVOVoyAgACySICAAJ3NAIAALV6AgAAGpgA=
Date:   Wed, 14 Nov 2018 22:25:37 +0000
Message-ID: <1542234336.30311.494.camel@impinj.com>
References: <20181113225734.8026-1-marc.zyngier@arm.com>
         <e73891a5-d798-ee9c-607c-9648d07f6505@synopsys.com>
         <86a7mcdlwg.wl-marc.zyngier@arm.com>
         <1542223166.30311.471.camel@impinj.com>
         <86sh0348tu.wl-marc.zyngier@arm.com>
In-Reply-To: <86sh0348tu.wl-marc.zyngier@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tpiepho@impinj.com; 
x-originating-ip: [216.207.205.253]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR0601MB3643;6:SIpweRioXvx7BfKXUuj/yPsTz05eVppUw5dx4oT6xEJLnAHS+E58nWjJf7iwbv1nE40QKFXqKNLmOq7MVAa5R8cv3fqDTQzRfySqT6nS63NyerjbvpkyFuaMlstMV9oMQyPPrNyNggAp8mdBDpFADGSeFWRMVAqE8Tiduy/zKirmEIIfrr5QhYv5RIpCJjc/7gujJJtOH0pEXg6yDeZXA4/Eb/6uhySaw8ukMhuEO8XUNG9luYeFEaISQTaImrm92SFMGgGzU9BTCl+pKVWenZlA0i0DTgq5JK+hxYXeOK1Aw2XjKKHU5ae50OC1tjOoIcR7vsebbkFCJepA2a/FwtDNJnjV0PF7WmL0c82VpHNZcJEESEjMAQD5N5d/wUVKYA4RJGwPxHEB8eCM6d5GQv11Fm9bjptX4zOZ+HG34kAJc5vg40dxhzdJNntOik1kQQjqgK1DcXE2SPrLtKMC5A==;5:Yztborkx14e6nkiiM8oBFMkin17IlvHmCemst4/SCvl74huml/hx6aH9+1CdwZMg4KRy6/Dr5fyWWvK8DSQkFTW0866xdNwgOViNbQ4KWCtyUpKaPJhE3M1/RNPKWE5io9gSAXCDR65bJiZrvFzwByrapbg7KoxdjVeiE3hdSTU=;7:o1HC2nymhDlOeZxT7vU2Fk38UFPH7xxBDAGYaCKIsfGi88UJNk8VVunWsqxDm2SvZMHuQaiZVn5302SqJ0R/ysgKhQvcpkk9Thu6rfgrLoychb8vIUEeEPyYNh7vxmTjOhoFhfJabWJtEOzKFJ1uGg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: b206b8d7-9514-468b-bc1d-08d64a801a38
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR0601MB3643;
x-ms-traffictypediagnostic: MWHPR0601MB3643:
x-microsoft-antispam-prvs: <MWHPR0601MB3643035D65F8629178CD32B5D3C30@MWHPR0601MB3643.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231415)(944501410)(52105112)(10201501046)(3002001)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:MWHPR0601MB3643;BCL:0;PCL:0;RULEID:;SRVR:MWHPR0601MB3643;
x-forefront-prvs: 085634EFF4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(346002)(396003)(136003)(39850400004)(189003)(199004)(8676002)(6512007)(6246003)(6916009)(81166006)(81156014)(2906002)(486006)(7736002)(6506007)(53546011)(93886005)(186003)(2616005)(476003)(446003)(11346002)(305945005)(25786009)(39060400002)(66066001)(5640700003)(8936002)(4326008)(53936002)(86362001)(14454004)(478600001)(2900100001)(102836004)(6486002)(6436002)(14444005)(256004)(5660300001)(36756003)(103116003)(4001150100001)(54906003)(316002)(99286004)(26005)(76176011)(97736004)(229853002)(6116002)(3846002)(2351001)(68736007)(2501003)(71200400001)(71190400001)(106356001)(105586002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR0601MB3643;H:MWHPR0601MB3708.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: impinj.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: UF/9wMb5JKPPKf90vjhisvQauHIcSJbABO6pwYkXe4jLWbigAja1V34xb59vEP8l/bJ4fj3tLtR41Xr76tosiT+3XwmBBtdmiff+Kz24sp4hwhZNegavzh2/TW7wsL02QN9eqONCECrhBTVHNFZNcrRfe3SUpfIzE89oSLpMoxrJnR05iwQUhmhCLFDuNYkzks+zniZRVvaH2edAlbdDu+7fRklQlFNJ0kSS1njMsQKKoPtPdKAGDne752/MGnawALhZiQ3W/UAtA462kerod+G5fofq++F4pDZwBmoIQcIwly8UU1tm3PVlOEUpHZ+6U7fVqRon+lfKZNubZ/JhkVqnSpAcebvfUvNJR1w3jxg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <6D38981281FD4547ACB8DBCAFD4DF475@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: impinj.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b206b8d7-9514-468b-bc1d-08d64a801a38
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2018 22:25:37.3647
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6de70f0f-7357-4529-a415-d8cbb7e93e5e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0601MB3643
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gV2VkLCAyMDE4LTExLTE0IGF0IDIyOjAxICswMDAwLCBNYXJjIFp5bmdpZXIgd3JvdGU6DQo+
IE9uIFdlZCwgMTQgTm92IDIwMTggMTk6MTk6MjcgKzAwMDAsDQo+IFRyZW50IFBpZXBobyA8dHBp
ZXBob0BpbXBpbmouY29tPiB3cm90ZToNCj4gPiANCj4gPiBPbiBXZWQsIDIwMTgtMTEtMTQgYXQg
MDk6NTQgKzAwMDAsIE1hcmMgWnluZ2llciB3cm90ZToNCj4gPiA+ICAgICAgICAgLyogSW5pdGlh
bGl6ZSBJUlEgU3RhdHVzIGFycmF5ICovDQo+ID4gPiAtICAgICAgIGZvciAoY3RybCA9IDA7IGN0
cmwgPCBudW1fY3RybHM7IGN0cmwrKykNCj4gPiA+IC0gICAgICAgICAgICAgICBkd19wY2llX3Jk
X293bl9jb25mKHBwLCBQQ0lFX01TSV9JTlRSMF9FTkFCTEUgKw0KPiA+ID4gKyAgICAgICBmb3Ig
KGN0cmwgPSAwOyBjdHJsIDwgbnVtX2N0cmxzOyBjdHJsKyspIHsNCj4gPiA+ICsgICAgICAgICAg
ICAgICBkd19wY2llX3dyX293bl9jb25mKHBwLCBQQ0lFX01TSV9JTlRSMF9NQVNLICsNCj4gPiA+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAoY3RybCAqIE1TSV9SRUdf
Q1RSTF9CTE9DS19TSVpFKSwNCj4gPiA+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIDQsICZwcC0+aXJxX3N0YXR1c1tjdHJsXSk7DQo+ID4gPiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICA0LCB+MCk7DQo+ID4gPiArICAgICAgICAgICAgICAgZHdfcGNpZV93
cl9vd25fY29uZihwcCwgUENJRV9NU0lfSU5UUjBfRU5BQkxFICsNCj4gPiA+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAoY3RybCAqIE1TSV9SRUdfQ1RSTF9CTE9DS19T
SVpFKSwNCj4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDQsIH4wKTsN
Cj4gPiA+ICsgICAgICAgICAgICAgICBwcC0+aXJxX3N0YXR1c1tjdHJsXSA9IDA7DQo+ID4gPiAr
ICAgICAgIH0NCj4gPiA+ICANCj4gPiANCj4gPiBJIHRlc3RlZCB5ZXN0ZXJkYXkgYmVmb3JlIHRo
aXMgcGF0Y2ggd2FzIHNlbnQgYW5kIGZpeGVkIHRoaXMgaXNzdWUNCj4gPiBhbm90aGVyIHdheS4g
IEkgcHJldHR5IHN1cmUgdGhpcyB3b3VsZCB3b3JrIGFzIHdlbGwsIHRob3VnaCBpdCdzIG5vdA0K
PiA+IGNsZWFyIHRvIG1lIGl0J3MgbW9yZSBjb3JyZWN0Lg0KPiANCj4gR2l2ZW4gdGhhdCB3ZSBk
b24ndCBoYXZlIGEgc3BlYyBvciBhbnkgZm9ybSBvZiB1c2VmdWwgZG9jdW1lbnRhdGlvbg0KPiAo
ZXhjZXB0IGZvciB0aGUgaW5mb3JtYXRpb24gdGhhdCBHdXN0YXZvIGdhdmUgdXMpLCBJIGRvbid0
IHRoaW5rDQo+ICphbnl0aGluZyogd2UnbGwgd3JpdGUgaGVyZSBoYXMgYSByZW1vdGUgY2hhbmNl
IG9mIGJlaW5nDQo+IGNvcnJlY3QuIFdlJ3JlIHNpbXBseSBwb2tpbmcgaW4gdGhlIGRhcmsuDQoN
ClNob3VsZCBhbGwgTVNJcyBzdGFydCBlbmFibGVkLCBvciBzaG91bGQgdGhleSBzdGFydCBkaXNh
YmxlZCBhbmQgYmUNCmVuYWJsZWQgdmlhIHRoZSBpcnFfZW5hYmxlIG1ldGhvZCBvZiB0aGUgaXJx
X2NoaXAsIHNlZW1zIGxpa2UgYSBMaW51eA0KZGVzaWduIGRlY2lzaW9uIHRvIG1lLiAgRGVjaWRl
IHRoYXQsIHRoZW4gdHJ5IHRvIGZpZ3VyZSBvdXQgaG93IHRvIG1ha2UNCnRoZSBoYXJkd2FyZSBk
byB3aGF0IExpbnV4IGV4cGVjdHMgaXQgdG8gZG8uDQoNClN0YXJ0aW5nIGRpc2FibGVkIHNlZW1z
IGxpa2UgdGhlIHJpZ2h0IGRlc2lnbiB0byBtZS4gIFNvIGhlcmUncyBteQ0KYXR0ZW1wdCB0byBt
YWtlIHRoZSBkcml2ZXIgZG8gdGhpcy4gIFdvcmtzIGluIG15IHRlc3RzLiAgSSd2ZSBub3QNCnRy
YWNrZWQgZG93biBhbGwgdXNlcyBvZiBpcnFfc3RhdHVzIG91dHNpZGUgdGhlIGRyaXZlciB0byBk
ZXRlcm1pbmUgaG93DQppdCdzIHN1cHBvc2VkIHRvIHdvcmsuDQoNCkZyb20gZGZjMDE1Zjk4MjFm
NTEwNWNiY2Y5Njg2ZDM2MDEwNWZmYmFjNGZmYiBNb24gU2VwIDE3IDAwOjAwOjAwIDIwMDENCkZy
b206IFRyZW50IFBpZXBobyA8dHBpZXBob0BpbXBpbmouY29tPg0KRGF0ZTogV2VkLCAxNCBOb3Yg
MjAxOCAxNDoxMjo0NyAtMDgwMA0KU3ViamVjdDogW1BBVENIXSBQQ0k6IGR3YzogQWxsb3cgZW5h
YmxpbmcgTVNJcyBhbmQgc3RhcnQgd2l0aCBkaXNhYmxlZA0KDQpBZGQgaXJxX2VuYWJsZSBjYWxs
YmFja3MgdG8gbGV0IE1TSXMgYmUgZW5hYmxlZC4NCg0KUHJldmlvdXNseSB0aGUgZHJpdmVyIHdv
dWxkIGxlYXZlIGFueSBNU0lzIGVuYWJsZWQgd2hlbiBpdCBpbml0aWFsaXplZA0KdGhhdCB3YXku
ICBSYXRoZXIgdGhhbiB0aGF0LCBkaXNhYmxlIHRoZW0gYWxsLg0KDQpTaWduZWQtb2ZmLWJ5OiBU
cmVudCBQaWVwaG8gPHRwaWVwaG9AaW1waW5qLmNvbT4NCi0tLQ0KIGRyaXZlcnMvcGNpL2NvbnRy
b2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS1ob3N0LmMgfCAzNw0KKysrKysrKysrKysrKysrKysr
KystLS0NCiAxIGZpbGUgY2hhbmdlZCwgMzMgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkN
Cg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2Fy
ZS1ob3N0LmMNCmIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLWhv
c3QuYw0KaW5kZXggZjA2ZTY3YzYwNTkzLi5lNzc3MGZiMWNlZDggMTAwNjQ0DQotLS0gYS9kcml2
ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUtaG9zdC5jDQorKysgYi9kcml2
ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUtaG9zdC5jDQpAQCAtNjEsMTEg
KzYxLDE3IEBAIHN0YXRpYyB2b2lkIGR3X21zaV91bm1hc2tfaXJxKHN0cnVjdCBpcnFfZGF0YSAq
ZCkNCiAJaXJxX2NoaXBfdW5tYXNrX3BhcmVudChkKTsNCiB9DQogDQorc3RhdGljIHZvaWQgZHdf
bXNpX2VuYWJsZV9pcnEoc3RydWN0IGlycV9kYXRhICpkKQ0KK3sNCisJaXJxX2NoaXBfZW5hYmxl
X3BhcmVudChkKTsNCit9DQorDQogc3RhdGljIHN0cnVjdCBpcnFfY2hpcCBkd19wY2llX21zaV9p
cnFfY2hpcCA9IHsNCiAJLm5hbWUgPSAiUENJLU1TSSIsDQogCS5pcnFfYWNrID0gZHdfbXNpX2Fj
a19pcnEsDQogCS5pcnFfbWFzayA9IGR3X21zaV9tYXNrX2lycSwNCiAJLmlycV91bm1hc2sgPSBk
d19tc2lfdW5tYXNrX2lycSwNCisJLmlycV9lbmFibGUgPSBkd19tc2lfZW5hYmxlX2lycSwNCiB9
Ow0KIA0KIHN0YXRpYyBzdHJ1Y3QgbXNpX2RvbWFpbl9pbmZvIGR3X3BjaWVfbXNpX2RvbWFpbl9p
bmZvID0gew0KQEAgLTIxNSw2ICsyMjEsMjYgQEAgc3RhdGljIHZvaWQgZHdfcGNpX2JvdHRvbV9h
Y2soc3RydWN0IGlycV9kYXRhICpkKQ0KIAlyYXdfc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmcHAt
PmxvY2ssIGZsYWdzKTsNCiB9DQogDQorc3RhdGljIHZvaWQgZHdfcGNpX2JvdHRvbV9lbmFibGUo
c3RydWN0IGlycV9kYXRhICpkYXRhKQ0KK3sNCisJc3RydWN0IHBjaWVfcG9ydCAqcHAgPSBpcnFf
ZGF0YV9nZXRfaXJxX2NoaXBfZGF0YShkYXRhKTsNCisJdW5zaWduZWQgaW50IHJlcywgYml0LCBj
dHJsOw0KKwl1bnNpZ25lZCBsb25nIGZsYWdzOw0KKwl1MzIgZW5hYmxlOw0KKw0KKwljdHJsID0g
ZGF0YS0+aHdpcnEgLyBNQVhfTVNJX0lSUVNfUEVSX0NUUkw7DQorCXJlcyA9IGN0cmwgKiBNU0lf
UkVHX0NUUkxfQkxPQ0tfU0laRTsNCisJYml0ID0gZGF0YS0+aHdpcnEgJSBNQVhfTVNJX0lSUVNf
UEVSX0NUUkw7DQorDQorCXJhd19zcGluX2xvY2tfaXJxc2F2ZSgmcHAtPmxvY2ssIGZsYWdzKTsN
CisNCisJZHdfcGNpZV9yZF9vd25fY29uZihwcCwgUENJRV9NU0lfSU5UUjBfRU5BQkxFICsgcmVz
LCA0LA0KJmVuYWJsZSk7DQorCWVuYWJsZSB8PSBCSVQoYml0KTsNCisJZHdfcGNpZV93cl9vd25f
Y29uZihwcCwgUENJRV9NU0lfSU5UUjBfRU5BQkxFICsgcmVzLCA0LA0KZW5hYmxlKTsNCisNCisJ
cmF3X3NwaW5fdW5sb2NrX2lycXJlc3RvcmUoJnBwLT5sb2NrLCBmbGFncyk7DQorfQ0KKw0KIHN0
YXRpYyBzdHJ1Y3QgaXJxX2NoaXAgZHdfcGNpX21zaV9ib3R0b21faXJxX2NoaXAgPSB7DQogCS5u
YW1lID0gIkRXUENJLU1TSSIsDQogCS5pcnFfYWNrID0gZHdfcGNpX2JvdHRvbV9hY2ssDQpAQCAt
MjIyLDYgKzI0OCw3IEBAIHN0YXRpYyBzdHJ1Y3QgaXJxX2NoaXAgZHdfcGNpX21zaV9ib3R0b21f
aXJxX2NoaXAgPQ0Kew0KIAkuaXJxX3NldF9hZmZpbml0eSA9IGR3X3BjaV9tc2lfc2V0X2FmZmlu
aXR5LA0KIAkuaXJxX21hc2sgPSBkd19wY2lfYm90dG9tX21hc2ssDQogCS5pcnFfdW5tYXNrID0g
ZHdfcGNpX2JvdHRvbV91bm1hc2ssDQorCS5pcnFfZW5hYmxlID0gZHdfcGNpX2JvdHRvbV9lbmFi
bGUsDQogfTsNCiANCiBzdGF0aWMgaW50IGR3X3BjaWVfaXJxX2RvbWFpbl9hbGxvYyhzdHJ1Y3Qg
aXJxX2RvbWFpbiAqZG9tYWluLA0KQEAgLTY2MywxMSArNjkwLDEzIEBAIHZvaWQgZHdfcGNpZV9z
ZXR1cF9yYyhzdHJ1Y3QgcGNpZV9wb3J0ICpwcCkNCiANCiAJbnVtX2N0cmxzID0gcHAtPm51bV92
ZWN0b3JzIC8gTUFYX01TSV9JUlFTX1BFUl9DVFJMOw0KIA0KLQkvKiBJbml0aWFsaXplIElSUSBT
dGF0dXMgYXJyYXkgKi8NCi0JZm9yIChjdHJsID0gMDsgY3RybCA8IG51bV9jdHJsczsgY3RybCsr
KQ0KLQkJZHdfcGNpZV9yZF9vd25fY29uZihwcCwgUENJRV9NU0lfSU5UUjBfRU5BQkxFICsNCisJ
LyogRGlzYWJsZSBhbGwgTVNJcyBhbmQgaW5pdGlhbGl6ZSBJUlEgU3RhdHVzIGFycmF5ICovDQor
CWZvciAoY3RybCA9IDA7IGN0cmwgPCBudW1fY3RybHM7IGN0cmwrKykgew0KKwkJZHdfcGNpZV93
cl9vd25fY29uZihwcCwgUENJRV9NU0lfSU5UUjBfRU5BQkxFICsNCiAJCQkJCShjdHJsICoNCk1T
SV9SRUdfQ1RSTF9CTE9DS19TSVpFKSwNCi0JCQkJICAgIDQsICZwcC0+aXJxX3N0YXR1c1tjdHJs
XSk7DQorCQkJCSAgICA0LCAwKTsNCisJCXBwLT5pcnFfc3RhdHVzW2N0cmxdID0gMDsNCisJfQ0K
IA0KIAkvKiBTZXR1cCBSQyBCQVJzICovDQogCWR3X3BjaWVfd3JpdGVsX2RiaShwY2ksIFBDSV9C
QVNFX0FERFJFU1NfMCwgMHgwMDAwMDAwNCk7DQotLSANCjIuMTQuNA0KDQoNCj4gPiBJIHNwZWN1
bGF0ZWQgdGhhdCB0aGUgcHJldmlvdXMgYmVoYXZpb3Igd2FzIHRyeWluZyB0byB3b3JrIHdpdGgg
YW4gTVNJDQo+ID4gZW5hYmxlZCBieSB0aGUgYm9vdGxvYWRlciwgQUNQSSBmaXJtd2FyZSwgZXRj
LiB0aGF0IHNob3VsZCBiZSBsZWZ0DQo+ID4gYWxvbmUuICBPciBwZXJoYXBzIHRoZXJlIHdhcyBu
byBnb29kIHJlYXNvbiBub3QgdG8gZGlzYWJsZSBldmVyeXRoaW5nDQo+ID4gb24gaW5pdGlhbGl6
YXRpb24gYW5kIHRoYXQgY29kZSBqdXN0IGdvdCBjb3BpZWQgZnJvbSBzb21ld2hlcmUgZWxzZSBh
bmQNCj4gPiBubyBvbmUgdGhvdWdodCBhYm91dCBpdC4gIFRoZXJlJ3MgY2VydGFpbmx5IGV2aWRl
bmNlIG9mIHRoYXQgaW4gdGhpcw0KPiA+IGRyaXZlci4NCj4gDQo+IEFzIHlvdSBzYWlkLCB5b3Un
cmUgc3BlY3VsYXRpbmcuIE5vbmV0aGVsZXNzLCB0aGVyZSBpcyBubyByZWFzb24gdG8NCj4gc3Rh
cnQgd2l0aCBhbnl0aGluZyBlbmFibGVkIHRoZSBmaXJzdCBwbGFjZS4NCg0KTm9ybWFsbHkgSSB3
b3VsZCBoYXZlIGRpdmVkIGludG8gdGhlIGdpdCBoaXN0b3J5IGJlZm9yZSBzZW5kaW5nIGENCnBh
dGNoLCB0byBzZWUgaWYgSSBjb3VsZCBmaW5kIHRoZSBzb3VyY2Ugb2YgdGhhdCBiZWhhdmlvcjoN
CmludGVudGlvbmFsbHkgZG9uZSwgY29waWVkIGZyb20gZWxzZXdoZXJlIGFuZCBkb2VzIG5vdCBt
YWtlIHNlbnNlIGhlcmUsDQpvciBhbiBvcmlnaW5hbCBjb25jZXB0IHdob3NlIHB1cnBvc2UgcmVt
YWlucyBhIG15c3RlcnkuDQo=

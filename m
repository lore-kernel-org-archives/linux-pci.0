Return-Path: <SRS0=GqAx=SG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC5D7C4360F
	for <linux-pci@archiver.kernel.org>; Thu,  4 Apr 2019 11:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7386A206DF
	for <linux-pci@archiver.kernel.org>; Thu,  4 Apr 2019 11:51:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="sWrmSE+W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728937AbfDDLvu (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 4 Apr 2019 07:51:50 -0400
Received: from mail-eopbgr710063.outbound.protection.outlook.com ([40.107.71.63]:47663
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726618AbfDDLvt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 4 Apr 2019 07:51:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PrWl2wV5AcJU/tCjtdaBvuW1QUSD7S5tIXa+N6f9/SY=;
 b=sWrmSE+WF+Ht7isWucmlYsytLNvyjoCBZSW03xvbUHh0D1JLd/xHORoy8q/+q/xKGctfFU5cF4O5agUFDCpBqiPQFXdPYX/fL+uoT7iwXfKsxfKIys/qDEB7FFB8Y53CY6hoWxxIW3OjO0fK8modQBpcVsIBsJyI/M8SqYaWEJQ=
Received: from BN6PR02MB2772.namprd02.prod.outlook.com (10.175.96.7) by
 BN6PR02MB2179.namprd02.prod.outlook.com (10.173.21.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.20; Thu, 4 Apr 2019 11:51:45 +0000
Received: from BN6PR02MB2772.namprd02.prod.outlook.com
 ([fe80::6cf5:d9:3347:151a]) by BN6PR02MB2772.namprd02.prod.outlook.com
 ([fe80::6cf5:d9:3347:151a%11]) with mapi id 15.20.1750.014; Thu, 4 Apr 2019
 11:51:45 +0000
From:   Bharat Kumar Gogada <bharatku@xilinx.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
CC:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v2] PCI: xilinx-nwl: Fix Multi MSI data programming
Thread-Topic: [PATCH v2] PCI: xilinx-nwl: Fix Multi MSI data programming
Thread-Index: AQHU2AAQCHDXCwr68kiV0ZLjhatkq6YpMNMAgALXyrA=
Date:   Thu, 4 Apr 2019 11:51:45 +0000
Message-ID: <BN6PR02MB277280583699183BC0791848A5500@BN6PR02MB2772.namprd02.prod.outlook.com>
References: <1552304759-5394-1-git-send-email-bharat.kumar.gogada@xilinx.com>
 <CAKv+Gu-tFpvKm4PSyxNkXHFSStfVCqOzdWCZjFTXiosZhoVKXg@mail.gmail.com>
In-Reply-To: <CAKv+Gu-tFpvKm4PSyxNkXHFSStfVCqOzdWCZjFTXiosZhoVKXg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=bharatku@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4769b62c-75a5-49dc-09e1-08d6b8f3e9bb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BN6PR02MB2179;
x-ms-traffictypediagnostic: BN6PR02MB2179:
x-ms-exchange-purlcount: 1
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <BN6PR02MB2179992E6C7AD31D3D6F52E2A5500@BN6PR02MB2179.namprd02.prod.outlook.com>
x-forefront-prvs: 0997523C40
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(346002)(39850400004)(396003)(366004)(189003)(199004)(76176011)(3846002)(53936002)(5660300002)(256004)(26005)(6116002)(97736004)(14444005)(316002)(7696005)(106356001)(105586002)(102836004)(4326008)(6246003)(68736007)(66066001)(6506007)(25786009)(476003)(14454004)(486006)(11346002)(6916009)(86362001)(446003)(71200400001)(71190400001)(8936002)(33656002)(7736002)(229853002)(2906002)(9686003)(52536014)(81156014)(81166006)(966005)(8676002)(6436002)(478600001)(6306002)(55016002)(186003)(305945005)(74316002)(54906003)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR02MB2179;H:BN6PR02MB2772.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0NWzcSmEP9PP/+Dr1YrkPnHx81j1h9RiBEtSvuiBYisdp3ESCdr1NwVEeQkMO8KWPzFT6yy2hM4xQHCtnnMG5gZbo8efbRpcxKBYmBBTDrxzP/8Q14DJoTNyOfL/Qq/IjnXzN273BQN1Oo3YjhcxNf35a4aBHlg/ZEZhtk4JylSbw7gZDCIRK9flB5hW3ZKdcGdluzM8TbcuS94WIEDe2pd73GBBV9VGfEeM1KL3Qh1vJvn4tiYrRzoTqB3yvtyOoXDZXirSu9w139RRb+l4kvr6fRyVp1FHOEg3R/xM5o5Sle5OGWa8D+QwhG9CiQq7Mgj7lSMX60BVbbMZLUz+OyN/9U7diJmvoSMp/Zs2f4MaGiKMrSGZSmigtkObYO1R8dM//dl7t67t+cbZMoM23/LB5+mnUxkWTQlHQCnNPlk=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4769b62c-75a5-49dc-09e1-08d6b8f3e9bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2019 11:51:45.5985
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB2179
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIIHYyXSBQQ0k6IHhpbGlueC1ud2w6IEZpeCBNdWx0aSBNU0kg
ZGF0YSBwcm9ncmFtbWluZw0KPiANCj4gT24gTW9uLCAxMSBNYXIgMjAxOSBhdCAxMjo0NiwgQmhh
cmF0IEt1bWFyIEdvZ2FkYQ0KPiA8YmhhcmF0Lmt1bWFyLmdvZ2FkYUB4aWxpbnguY29tPiB3cm90
ZToNCj4gPg0KPiA+IFRoZSBjdXJyZW50IE11bHRpIE1TSSBkYXRhIHByb2dyYW1taW5nIGZhaWxz
IGlmIG11bHRpcGxlIGVuZCBwb2ludHMNCj4gPiByZXF1ZXN0aW5nIE1TSSBhbmQgbXVsdGkgTVNJ
IGFyZSBjb25uZWN0ZWQgd2l0aCBzd2l0Y2gsIGkuZSB0aGUNCj4gPiBjdXJyZW50IG11bHRpIE1T
SSBkYXRhIGJlaW5nIGdpdmVuIGlzIG5vdCBjb25zaWRlcmluZyB0aGUgbnVtYmVyIG9mDQo+ID4g
dmVjdG9ycyBiZWluZyByZXF1ZXN0ZWQgaW4gY2FzZSBvZiBtdWx0aSBNU0kuDQo+ID4gRHVlIHRv
IHRoaXMgaWYgbXVsdGlwbGUgZW5kIHBvaW50cyBhcmUgY29ubmVjdGVkIGFuZCByZXF1ZXN0aW5n
IE1TSQ0KPiA+IGFuZCBtdWx0aSBNU0kgY29tYmluYXRpb24sIHRoZSBtdWx0aSBNU0kgZGF0YSBp
cyBlbmRpbmcgdXAgdXNpbmcgd3JvbmcNCj4gPiBNU0kgZGF0YSwgd2hpY2ggbWlnaHQgYmUgdXNl
ZCBieSBkaWZmZXJlbnQgZGV2aWNlLg0KPiA+DQo+ID4gRml4IE11bHRpIE1TSSBkYXRhIHByb2dy
YW1taW5nIHdpdGggcmVxdWlyZWQgYWxpZ25tZW50IGJ5IHVzaW5nIG51bWJlcg0KPiA+IG9mIHZl
Y3RvcnMgYmVpbmcgcmVxdWVzdGVkLg0KPiA+DQo+ID4gRml4ZXM6IGFiNTk3ZDM1ZWYxMSAoIlBD
STogeGlsaW54LW53bDogQWRkIHN1cHBvcnQgZm9yIFhpbGlueCBOV0wgUENJZQ0KPiA+IEhvc3Qg
Q29udHJvbGxlciIpDQo+ID4gU2lnbmVkLW9mZi1ieTogQmhhcmF0IEt1bWFyIEdvZ2FkYSA8Ymhh
cmF0Lmt1bWFyLmdvZ2FkYUB4aWxpbnguY29tPg0KPiA+IC0tLQ0KPiA+IFYyOg0KPiA+ICAtIEFk
ZGVkIG1vcmUgZGVzY3JpcHRpb24gb2YgZml4DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvcGNpL2Nv
bnRyb2xsZXIvcGNpZS14aWxpbngtbndsLmMgfCAyICstDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAx
IGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvcGNpL2NvbnRyb2xsZXIvcGNpZS14aWxpbngtbndsLmMNCj4gPiBiL2RyaXZlcnMvcGNpL2Nv
bnRyb2xsZXIvcGNpZS14aWxpbngtbndsLmMNCj4gPiBpbmRleCA4MTUzOGQ3Li4zNjY2OWM1IDEw
MDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS14aWxpbngtbndsLmMN
Cj4gPiArKysgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUteGlsaW54LW53bC5jDQo+ID4g
QEAgLTQ4NCw3ICs0ODQsNyBAQCBzdGF0aWMgaW50IG53bF9pcnFfZG9tYWluX2FsbG9jKHN0cnVj
dCBpcnFfZG9tYWluDQo+ID4gKmRvbWFpbiwgdW5zaWduZWQgaW50IHZpcnEsDQo+ID4NCj4gPiAg
ICAgICAgIG11dGV4X2xvY2soJm1zaS0+bG9jayk7DQo+ID4gICAgICAgICBiaXQgPSBiaXRtYXBf
ZmluZF9uZXh0X3plcm9fYXJlYShtc2ktPmJpdG1hcCwgSU5UX1BDSV9NU0lfTlIsIDAsDQo+ID4g
LSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBucl9pcnFzLCAwKTsNCj4g
PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG5yX2lycXMsIG5yX2ly
cXMgLSAxKTsNCj4gDQo+IEFyZSB5b3Ugc3VyZSBucl9pcnFzIGlzIGd1YXJhbnRlZWQgdG8gYmUg
YSBwb3dlciBvZiAyPw0KSGkgQXJkLCBUaGFua3MgZm9yIHlvdXIgdGltZS4NCkFmdGVyIGNoZWNr
aW5nIG90aGVyIHNvdXJjZSBjb2RlcyBpdHMgbm90IGd1YXJhbnRlZWQsIHdpbGwgYWRkIGV4dHJh
IGNoZWNrIGFuZCByZXNlbmQgcGF0Y2guDQoNClJlZ2FyZHMsDQpCaGFyYXQNCj4gDQo+ID4gICAg
ICAgICBpZiAoYml0ID49IElOVF9QQ0lfTVNJX05SKSB7DQo+ID4gICAgICAgICAgICAgICAgIG11
dGV4X3VubG9jaygmbXNpLT5sb2NrKTsNCj4gPiAgICAgICAgICAgICAgICAgcmV0dXJuIC1FTk9T
UEM7DQo+ID4gLS0NCj4gPiAyLjcuNA0KPiA+DQo+ID4NCj4gPiBfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KPiA+IGxpbnV4LWFybS1rZXJuZWwgbWFpbGlu
ZyBsaXN0DQo+ID4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnDQo+ID4gaHR0
cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVs
DQo=

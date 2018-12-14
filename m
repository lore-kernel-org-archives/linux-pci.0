Return-Path: <SRS0=mLR+=OX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6519C65BAE
	for <linux-pci@archiver.kernel.org>; Fri, 14 Dec 2018 03:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E7992080F
	for <linux-pci@archiver.kernel.org>; Fri, 14 Dec 2018 03:02:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hnQoPbir"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E7992080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbeLNDCJ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 13 Dec 2018 22:02:09 -0500
Received: from mail-eopbgr70053.outbound.protection.outlook.com ([40.107.7.53]:46240
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726355AbeLNDCJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 13 Dec 2018 22:02:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kQsWfGg1VrLSObv4wfZjOU5i7g9XMg9BPAb1zvze3y8=;
 b=hnQoPbirJ3vBxkdL/RZ9DbiPhc7kmpcI80gz6XyuaFakGF/lpC5E5HC/Ol5pzHZPjjpew6zsy/XdyOVh0ElqswhWlibFIcsfI1JDvPBb+RZx/V13JUtb2IguPbMLB4ReElZ9ES4rHuwpzQtbVSFoiZCvceFyzPphcBGqJO6dcpU=
Received: from AM0PR0402MB3570.eurprd04.prod.outlook.com (52.133.46.11) by
 AM0PR0402MB3443.eurprd04.prod.outlook.com (52.133.45.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19; Fri, 14 Dec 2018 02:59:07 +0000
Received: from AM0PR0402MB3570.eurprd04.prod.outlook.com
 ([fe80::94f8:5fdd:f384:8af8]) by AM0PR0402MB3570.eurprd04.prod.outlook.com
 ([fe80::94f8:5fdd:f384:8af8%8]) with mapi id 15.20.1425.021; Fri, 14 Dec 2018
 02:59:07 +0000
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [v2] PCI: imx: make msi work without pcieportbus
Thread-Topic: [v2] PCI: imx: make msi work without pcieportbus
Thread-Index: AQHUkron3jfJ309qkk6cQky/juy8waV8vliAgACyqyA=
Date:   Fri, 14 Dec 2018 02:59:07 +0000
Message-ID: <AM0PR0402MB3570C895BAAFF21AE201B4658CA10@AM0PR0402MB3570.eurprd04.prod.outlook.com>
References: <1544687042-16595-1-git-send-email-hongxing.zhu@nxp.com>
 <20181213144115.GA4701@google.com>
In-Reply-To: <20181213144115.GA4701@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=hongxing.zhu@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR0402MB3443;6:k8/J6oboLGEnWC4lEOoORFqUgb+/8eyKEtPwu0gu1dqqYSY9U1cVy3FIBgE0uEOkV8/2NSasU7yPTOX0dDOniZ84DbOQbpOP8rSmnti4f7TrSTZlX9zlhcmJpql8wt5TkD03RWbSzKI8ynd3f2wtBzJFYIOBSLtLkVWrSf5pIxUpZ2KUz91modANtfzfEV1mk9PFnLllBcl3aIf5OXZe5K2Vktk0K3E0n/0qIAVbJnkr/LTDTie6CuJ9j9o8rGpyFCRuds5AUgx3YAaniV9a8hTD+sikoHeinb354wFT9ECzqXBkkBHin8GJa6nbpqbi/wnwgFQ7ihzpq5Pb46nyqAahoS6zt5prv5fzlVH+7i+utWZQ22OUo9Oh15oN21H9DYxhJw1Gu+yiBS1pXTyEyomHBnFPFKh77iDBvNYgYRU2WZjZDx+B9vOA11R7luOEozCdv1EHjZXWfyVmTPbkvQ==;5:65sryT6ENQfxBPzwor9k2VI3Xf/0O2xq+TCo98KOwhXlyQmdYiK3v34r6Em8yBAxgaOOIhtBojqYfjh/UIacO63hPFJxq3/mWokEL9RSqEm68qKwcovL2cDgLEalzxEEc3Hvf7dfcT+iX+lTyK9Ye4jXm9WaRKgVPxgttpUqc3o=;7:xrs77Db8ZRPYT6AErPJZOo//6W6jPhYhPJh4P5uRzG61U1NM0d8a/kWPQO9IA4Jf78CB4LMsOBX+HQG3AzmqUGkDIsrMqZenMPSbS93eRWJj+e5jKnIMYMc3gbsXirtDCUFSWwgOJSi6QkzKvc1ndQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 42366c9b-d3d2-421d-8c5f-08d661701d2f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(4534185)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR0402MB3443;
x-ms-traffictypediagnostic: AM0PR0402MB3443:
x-microsoft-antispam-prvs: <AM0PR0402MB3443E850696BCEFCE7C9204B8CA10@AM0PR0402MB3443.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231475)(944501520)(4982022)(52105112)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:AM0PR0402MB3443;BCL:0;PCL:0;RULEID:;SRVR:AM0PR0402MB3443;
x-forefront-prvs: 08864C38AC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(396003)(366004)(346002)(136003)(189003)(199004)(13464003)(54534003)(4326008)(53936002)(486006)(25786009)(478600001)(68736007)(81156014)(45080400002)(8676002)(81166006)(305945005)(74316002)(6506007)(53546011)(3846002)(99286004)(6116002)(102836004)(54906003)(33656002)(39060400002)(26005)(186003)(5660300001)(106356001)(76176011)(2906002)(446003)(7736002)(11346002)(7696005)(476003)(105586002)(6246003)(316002)(86362001)(55016002)(9686003)(14454004)(6306002)(6916009)(575784001)(256004)(229853002)(14444005)(97736004)(66066001)(966005)(8936002)(6436002)(71190400001)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR0402MB3443;H:AM0PR0402MB3570.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: uWyciBmjV22rFE6b0ijWU9HSS+MpggPhlio3AYsVLas0sKoH7SyZGiXW5omtJuFqKAEMluUUHNgeUlzm1vDojGfuKCi7yx1x9Bjz0eGLCxYlHPbMMfhXye2+u8BAyRycTpD9DgWF/sEW13IAVoacD19AIOpPYE+HkSuDrcj2Cgi5maCFhndDapWKyXyqx4HwTBKA29zKkP9bsqZlDmA6Pn2eJOBSPlExjILT/rD628dHBioIB6agoRtQdy+iN4vyvR+wfxFBsI1rMrfTrMcfXl7VtDXms2g1T4W6RAmcLpY6cv0DiMTeIXzYbAo87Gih
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42366c9b-d3d2-421d-8c5f-08d661701d2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2018 02:59:07.1749
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3443
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgQmpvcm46DQpUaGFua3MgZm9yIHlvdXIga2luZGx5IHJldmlldy4NCg0KPiAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCam9ybiBIZWxnYWFzIFttYWlsdG86aGVsZ2Fhc0Br
ZXJuZWwub3JnXQ0KPiBTZW50OiAyMDE4xOoxMtTCMTPI1SAyMjo0MQ0KPiBUbzogUmljaGFyZCBa
aHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0KPiBDYzogbG9yZW56by5waWVyYWxpc2lAYXJtLmNv
bTsgbC5zdGFjaEBwZW5ndXRyb25peC5kZTsNCj4gYW5kcmV3LnNtaXJub3ZAZ21haWwuY29tOyBs
aW51eC1wY2lAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3Jn
OyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcNCj4gU3ViamVjdDogUmU6IFt2
Ml0gUENJOiBpbXg6IG1ha2UgbXNpIHdvcmsgd2l0aG91dCBwY2llcG9ydGJ1cw0KPiANCj4gT24g
VGh1LCBEZWMgMTMsIDIwMTggYXQgMDg6MDI6MTFBTSArMDAwMCwgUmljaGFyZCBaaHUgd3JvdGU6
DQo+ID4gTVNJX0VOIG9mIGlNWCBQQ0llIFJDIHdvdWxkIGJlIGFzc2VydGVkIHdoZW4gUENJRVBP
UlRCVVMgZHJpdmVyIGlzDQo+ID4gc2VsZWN0ZWQuDQo+ID4gVGh1cywgdGhlIE1TSSB3b3JrcyBm
aW5lIG9uIGlNWCBQQ0llIGJlZm9yZS4NCj4gPiBBc3NlcnQgaXQgdW5jb25kaXRpb25hbGx5IHdo
ZW4gTVNJIGlzIHN1cHBvcnRlZC4NCj4gPiBPdGhlcndpc2UsIHRoZSBNU0kgd291bGRuJ3QgYmUg
dHJpZ2dlcmVkIGFsdGhvdWdoIHRoZSBFUCBpcyBwcmVzZW50DQo+ID4gYW5kIHRoZSBNU0lzIGFy
ZSBhc3NpZ25lZC4NCj4gDQo+IFRoaXMgc3ViamVjdCBsaW5lIGFuZCBjaGFuZ2Vsb2cgbmVlZCBz
b21lIHJld29yay4gIEkgY2FuJ3QgdW5kZXJzdGFuZA0KPiB3aGF0J3MgZ29pbmcgb24gYXQgYWxs
LiAgTG9yZW56byBvciBJIGNhbiBoZWxwIGNyYWZ0IHNvbWV0aGluZywgYnV0IEkgZG9uJ3QNCj4g
dW5kZXJzdGFuZCBlbm91Z2ggdG8gcHJvcG9zZSBhbnl0aGluZyB5ZXQuDQo+IA0KPiAiTVNJX0VO
IiBkb2Vzbid0IGFwcGVhciBpbiB0aGUgZHJpdmVyOyBJIGFzc3VtZSBpdCdzIHNvbWUgZGV2aWNl
LXNwZWNpZmljDQo+IHNpZ25hbC4NCltSaWNoYXJkIFpodV0gTVNJX0VOIGlzIHRoZSBNU0kgRW5h
YmxlIGJpdChCSVQoMCkpIG9mIHRoZSBNZXNzYWdlIENvbnRyb2wgUmVnaXN0ZXIgZm9yIE1TSS4N
Ckkgd291bGQgY2hhbmdlIGl0IHRvIE1TSSBFbmFibGUgYml0IGxhdGVyLg0KDQo+IA0KPiAiaU1Y
IiBkb2VzIG5vdCBsb29rIGxpa2UgdGhlIHR5cGljYWwgc3BlbGxpbmcuICBZb3UgY291bGQgdXNl
ICJpbXg2Ig0KPiB0byByZWZlciB0byB0aGUgZHJpdmVyLCBidXQgaW4gdGhpcyBjYXNlIHlvdSdy
ZSB0YWxraW5nIGFib3V0IHRoZSBoYXJkd2FyZSBpdHNlbGYsDQo+IG5vdCB0aGUgZHJpdmVyLiAg
U28geW91IHNob3VsZCB1c2UgImkuTVg2IiBvciB3aGF0ZXZlciB0aGUgYXBwcm9wcmlhdGUgYnJh
bmQNCj4gaXMuDQpbUmljaGFyZCBaaHVdIE9rYXksIGkuTVg2IHdvdWxkIGJlIHVzZWQuDQo+IA0K
PiBJZiAiUENJRVBPUlRCVVMgZHJpdmVyIGlzIHNlbGVjdGVkIiBtZWFucyAiQ09ORklHX1BDSUVQ
T1JUQlVTPXkiLCBzYXkNCj4gdGhhdC4gIFRoZSBjb25uZWN0aW9uIG9mIHBvcnRkcnYgKHdoaWNo
IGlzIGdlbmVyaWMgUENJZSBzdXBwb3J0KSB0byBNU0lfRU4NCj4gKHdoaWNoIGlzIGFwcGFyZW50
bHkgZGV2aWNlLXNwZWNpZmljKSBpcyB1bmNsZWFyLiAgSXQgd291bGQgYmUgaGVscGZ1bCBpZiB5
b3UNCj4gY291bGQgY29ubmVjdCB0aG9zZSBkb3RzIGEgbGl0dGxlIG1vcmUuDQpbUmljaGFyZCBa
aHVdIFRoYXQncyByaWdodCwgdGhhbmtzLg0KPiANCj4gIk1TSSB3b3JrcyBmaW5lIG9uIGlNWCBQ
Q0llIGJlZm9yZS4iICBCZWZvcmUgd2hhdD8gIElzIHRoaXMgYSByZWdyZXNzaW9uLA0KPiB3aGVy
ZSBNU0kgd29ya2VkIGJlZm9yZSBzb21lIGNvbW1pdCBhbmQgdGhpcyBwYXRjaCBmaXhlcyBpdD8N
CltSaWNoYXJkIFpodV0gTVNJIHdvcmtzIGZpbmUgb24gaU1YNiBQQ0llIGJlZm9yZSBjb21taXQg
ImYzZmRmYzRhYzMiLg0KSXQncyBhIGxpbWl0YXRpb24gb2YgdGhlIGlNWDYgUENJZSwgb3RoZXJ3
aXNlIGEgcmVncmVzc2lvbi4gTVNJIHNob3VsZCBub3QNCiBoYXZlIGRlcGVuZGVuY3kgb24gdGhl
IHNlbGVjdGlvbiBvZiB0aGUgUENJRVBPUlRCVVMNCj4gDQo+IFBsZWFzZSByZXdyYXAgdGhlIGNo
YW5nZWxvZyBzbyBpdCB1c2VzIHRoZSBlbnRpcmUgODAtY29sdW1uIHdpZHRoLg0KPiBXcmFwIHRv
IDc1IHNvIGl0IHN0aWxsIGZpdHMgd2hlbiAiZ2l0IGxvZyIgYWRkcyB0aGUgNCBjaGFyIGluZGVu
dC4NCj4gDQpbUmljaGFyZCBaaHVdIE9rYXkuDQoNCj4gPiBTaWduZWQtb2ZmLWJ5OiBSaWNoYXJk
IFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvcGNpL2Nv
bnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMgfCA3ICsrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQs
IDcgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRy
b2xsZXIvZHdjL3BjaS1pbXg2LmMNCj4gPiBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3Bj
aS1pbXg2LmMNCj4gPiBpbmRleCAyNjA4N2IzLi5kM2U0Mjk2IDEwMDY0NA0KPiA+IC0tLSBhL2Ry
aXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMNCj4gPiArKysgYi9kcml2ZXJzL3Bj
aS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jDQo+ID4gQEAgLTc0LDYgKzc0LDcgQEAgc3RydWN0
IGlteDZfcGNpZSB7DQo+ID4gICNkZWZpbmUgUEhZX1BMTF9MT0NLX1dBSVRfVVNMRUVQX01BWAky
MDANCj4gPg0KPiA+ICAvKiBQQ0llIFJvb3QgQ29tcGxleCByZWdpc3RlcnMgKG1lbW9yeS1tYXBw
ZWQpICovDQo+ID4gKyNkZWZpbmUgUENJX01TSV9DQVAJCQkJMHg1MA0KPiANCj4gSSB3aXNoIHRo
aXMgZGlkbid0IGxvb2sgcXVpdGUgc28gbXVjaCBsaWtlIGEgUENJIGNvcmUgbmFtZSwgYmVjYXVz
ZSB0aGlzIGlzDQo+IHJlYWxseSBhbiBpLk1YLXNwZWNpZmljIG9mZnNldC4gIEl0IGxvb2tzIGxp
a2UgdGhlIFBDSUVfUkNfKiBuYW1lcyBhcmUgYWxsDQo+IHNpbWlsYXIgaS5NWC1zcGVjaWZpYyB0
aGluZ3MuICBTaG91bGRuJ3QgdGhpcyBtYXRjaCB0aG9zZT8NCj4gDQpbUmljaGFyZCBaaHVdIEhv
dyBhYm91dCB0byByZXBsYWNlIGl0IGJ5IFBDSUVfUkNfSU1YNl9NU0lfQ0FQPw0KDQpCZXN0IFJl
Z2FyZHMNClJpY2hhcmQgWmh1DQoNCj4gPiAgI2RlZmluZSBQQ0lFX1JDX0xDUgkJCQkweDdjDQo+
ID4gICNkZWZpbmUgUENJRV9SQ19MQ1JfTUFYX0xJTktfU1BFRURTX0dFTjEJMHgxDQo+ID4gICNk
ZWZpbmUgUENJRV9SQ19MQ1JfTUFYX0xJTktfU1BFRURTX0dFTjIJMHgyDQo+ID4gQEAgLTkyNiw2
ICs5MjcsNyBAQCBzdGF0aWMgaW50IGlteDZfcGNpZV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2
aWNlDQo+ICpwZGV2KQ0KPiA+ICAJc3RydWN0IHJlc291cmNlICpkYmlfYmFzZTsNCj4gPiAgCXN0
cnVjdCBkZXZpY2Vfbm9kZSAqbm9kZSA9IGRldi0+b2Zfbm9kZTsNCj4gPiAgCWludCByZXQ7DQo+
ID4gKwl1MTYgdmFsOw0KPiA+DQo+ID4gIAlpbXg2X3BjaWUgPSBkZXZtX2t6YWxsb2MoZGV2LCBz
aXplb2YoKmlteDZfcGNpZSksIEdGUF9LRVJORUwpOw0KPiA+ICAJaWYgKCFpbXg2X3BjaWUpDQo+
ID4gQEAgLTEwNzAsNiArMTA3MiwxMSBAQCBzdGF0aWMgaW50IGlteDZfcGNpZV9wcm9iZShzdHJ1
Y3QNCj4gcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+ICAJcmV0ID0gaW14Nl9hZGRfcGNpZV9w
b3J0KGlteDZfcGNpZSwgcGRldik7DQo+ID4gIAlpZiAocmV0IDwgMCkNCj4gPiAgCQlyZXR1cm4g
cmV0Ow0KPiA+ICsJaWYgKElTX0VOQUJMRUQoQ09ORklHX1BDSV9NU0kpKSB7DQo+ID4gKwkJdmFs
ID0gZHdfcGNpZV9yZWFkd19kYmkocGNpLCBQQ0lfTVNJX0NBUCArIFBDSV9NU0lfRkxBR1MpOw0K
PiA+ICsJCXZhbCB8PSBQQ0lfTVNJX0ZMQUdTX0VOQUJMRTsNCj4gPiArCQlkd19wY2llX3dyaXRl
d19kYmkocGNpLCBQQ0lfTVNJX0NBUCArIFBDSV9NU0lfRkxBR1MsIHZhbCk7DQo+ID4gKwl9DQo+
ID4NCj4gPiAgCXJldHVybiAwOw0KPiA+ICB9DQo+ID4gLS0NCj4gPiAyLjcuNA0KPiA+DQo+ID4N
Cj4gPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KPiA+
IGxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0DQo+ID4gbGludXgtYXJtLWtlcm5lbEBsaXN0
cy5pbmZyYWRlYWQub3JnDQo+ID4gaHR0cHM6Ly9lbWVhMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24u
b3V0bG9vay5jb20vP3VybD1odHRwJTNBJTJGJTJGbGlzdA0KPiA+DQo+IHMuaW5mcmFkZWFkLm9y
ZyUyRm1haWxtYW4lMkZsaXN0aW5mbyUyRmxpbnV4LWFybS1rZXJuZWwmYW1wO2RhdGE9MDIlNw0K
PiBDDQo+ID4NCj4gMDElN0Nob25neGluZy56aHUlNDBueHAuY29tJTdDNThhOTJjN2ExYzNlNGEx
ZmE0MzkwOGQ2NjEwOTBiNGYlDQo+IDdDNjg2ZWENCj4gPg0KPiAxZDNiYzJiNGM2ZmE5MmNkOTlj
NWMzMDE2MzUlN0MwJTdDMCU3QzYzNjgwMzA4ODgwOTU0MzgxOSZhbXA7DQo+IHNkYXRhPXF5Ng0K
PiA+IHExdGF3SXolMkZVNzU3RDVQTjV2RTNPcU5PZjcwZk1ITEZCVlpQSTlBSSUzRCZhbXA7cmVz
ZXJ2ZWQ9MA0K

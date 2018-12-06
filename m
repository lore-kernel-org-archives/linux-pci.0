Return-Path: <SRS0=KO/x=OP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32646C65BB0
	for <linux-pci@archiver.kernel.org>; Thu,  6 Dec 2018 01:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3B11214DB
	for <linux-pci@archiver.kernel.org>; Thu,  6 Dec 2018 01:09:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="L4oaLG9+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3B11214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbeLFBJB (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 5 Dec 2018 20:09:01 -0500
Received: from mail-eopbgr50048.outbound.protection.outlook.com ([40.107.5.48]:53328
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727514AbeLFBJB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 5 Dec 2018 20:09:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0+suC2lfjfvNXlHblg5TiChehCWthQx26gtIdDGHrkA=;
 b=L4oaLG9+/5i06xZBBlFJ5wvxpvLv7eBjwWz4j4USHBnjrViEqWeYNQkkWmxk7Y/i3Mj1Ve5LAh8+I+Ba0kpAm69bULV7uR7D7tNZsx4QuK8mrfsqVdsTbTNPnfgEWKsmrk36og5NxeYK9BzAZSqGMiIZUbw8zscQDYO1qYDXiSY=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.2.80) by
 AM6SPR01MB01.eurprd04.prod.outlook.com (52.133.25.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.19; Thu, 6 Dec 2018 01:08:15 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::29b5:b3ed:3854:cf1c]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::29b5:b3ed:3854:cf1c%5]) with mapi id 15.20.1382.023; Thu, 6 Dec 2018
 01:08:15 +0000
From:   "Z.q. Hou" <zhiqiang.hou@nxp.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        Roy Zang <roy.zang@nxp.com>, Mingkai Hu <mingkai.hu@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>
Subject: RE: [PATCHv2 1/4] PCI: dwc: fix potential memory leak
Thread-Topic: [PATCHv2 1/4] PCI: dwc: fix potential memory leak
Thread-Index: AQHUdoHpGzf55QFgZUifBzAS9plOMaVwdJuAgACdxLA=
Date:   Thu, 6 Dec 2018 01:08:14 +0000
Message-ID: <AM6PR04MB5781A44014DD60973E393A6B84A90@AM6PR04MB5781.eurprd04.prod.outlook.com>
References: <20181107100854.28389-1-Zhiqiang.Hou@nxp.com>
 <20181107100854.28389-2-Zhiqiang.Hou@nxp.com>
 <20181205154013.GA18294@e107981-ln.cambridge.arm.com>
In-Reply-To: <20181205154013.GA18294@e107981-ln.cambridge.arm.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6SPR01MB01;6:YPChSQTm6OYaoVmaYWhh1EeSMEwjY34/w0011/dxlWtRZjuO5IKjtkOu/BpCm4MdYSj5JNTGWnfvZJpa1o7Td8tTDuJkmoH01sIyIg3TcOoWJFQEpsDtlObFkZrm7OELfsg7qcBUNrSWBqhOZZxdM4/0cZfLQ5cjq2nUYGNtJZCfmGQ8BZaA8fyP4JdYL/fH3/og3Xa0Ayuen9oJ+69z0SRNeeZ2wG1pOIwxo83mlWKx8mQ7EvlsMEtLx03SWKWVKbIwk5YDqKbw9/k0mLaGBr6rmCifdtePJXTptmtaAapnZI0YS5MRK3hVKV58Wj3em1Ojhr6fJuyaAjMS5nGSrrdajDH02kmpUrkOCLVRMSVj8wCKbOipUjYSgj8AyZzyUwVgWPhh3hyxe3Qa8mfU8hXSi//B/ipdXBZBK0yiMvKwqN1zAyjzjkF1VLQfcVDkNJe7uSdCUU8thMXbP3DNEA==;5:+B5wARRf9OSf9T9sQ5En8wgfKIiZjUKzBHBUDO9TsNFmlLds6O7rU+L7nrBgkdhxiut2YhKZrDf4++4LT/DCtpe53NrFvJZu0/fIE8vSrGDhQdQL3iJg+b6SrMM7AgtQ5h/Sx2ql7xn4+5gVRq0p6ajWXgEDAZ7esgxYF6JD7e8=;7:KKgBsyjVvdQcfw6261wqPmf0G10k+jG+hvhOHqfq8bu6m0qz+TZznTFjUsNnc90HVZfNuJuWbX1WZ6M2c9lCWkauaIr73jdh2jatGDEgybwf3dqy/qzavywArExFIup0Ze1IpoNaA7MwMLH6FNwLow==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 6c99bc84-1a68-47f6-254d-08d65b174cd6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6SPR01MB01;
x-ms-traffictypediagnostic: AM6SPR01MB01:
x-microsoft-antispam-prvs: <AM6SPR01MB0110B23E4D715C6571FC2F84A90@AM6SPR01MB01.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231455)(999002)(944501520)(52105112)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:AM6SPR01MB01;BCL:0;PCL:0;RULEID:;SRVR:AM6SPR01MB01;
x-forefront-prvs: 087894CD3C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(366004)(136003)(39860400002)(199004)(189003)(13464003)(186003)(7696005)(6246003)(39060400002)(76176011)(54906003)(53936002)(14444005)(102836004)(256004)(9686003)(6506007)(8676002)(55016002)(8936002)(81166006)(81156014)(53546011)(7736002)(74316002)(316002)(305945005)(476003)(68736007)(99286004)(486006)(11346002)(4326008)(105586002)(5660300001)(106356001)(26005)(446003)(6116002)(2906002)(3846002)(71200400001)(97736004)(86362001)(33656002)(71190400001)(6916009)(25786009)(478600001)(66066001)(229853002)(14454004)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6SPR01MB01;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: dB+i3k2u4DTw8jM2sevaHbJHPRgy3zt2vI/u/FMlSFq+wyu2opQ8o8CCcXScUcbHQv4705KjVb8js1AnODOiggsuHKtZvCF4c0KH8bh1WKfAQfDkXWuwPWJlyI8nVPjMOpJrVBFjIOleTUgzSjuud/qTs77vJSUcjuS/Etc69DkPwynAb/KxaKAdN0PFnzZUBwdybhWbB4j4aj17iMuyCCruz+iwHxWb7mHS44prF8NtsNnjq/S2hpQnpFnKPROn8BsQmnruyCCPZBPTeTg+I9r3ksYuLWfS53KkhU6IdLlkfxAaYe9EFpG5D2J7iieTO2/b6PVjHrUkEGZIN16iE1Xhyj6nXckDLq0mL0NHH8w=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c99bc84-1a68-47f6-254d-08d65b174cd6
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2018 01:08:14.9510
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6SPR01MB01
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgTG9yZW56bywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMb3Jl
bnpvIFBpZXJhbGlzaSA8bG9yZW56by5waWVyYWxpc2lAYXJtLmNvbT4NCj4gU2VudDogMjAxOMTq
MTLUwjXI1SAyMzo0MA0KPiBUbzogWi5xLiBIb3UgPHpoaXFpYW5nLmhvdUBueHAuY29tPg0KPiBD
YzogbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9y
ZzsNCj4gYmhlbGdhYXNAZ29vZ2xlLmNvbTsgamluZ29vaGFuMUBnbWFpbC5jb207DQo+IGd1c3Rh
dm8ucGltZW50ZWxAc3lub3BzeXMuY29tOyBSb3kgWmFuZyA8cm95LnphbmdAbnhwLmNvbT47IE1p
bmdrYWkgSHUNCj4gPG1pbmdrYWkuaHVAbnhwLmNvbT47IE0uaC4gTGlhbiA8bWluZ2h1YW4ubGlh
bkBueHAuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIdjIgMS80XSBQQ0k6IGR3YzogZml4IHBv
dGVudGlhbCBtZW1vcnkgbGVhaw0KPiANCj4gT24gV2VkLCBOb3YgMDcsIDIwMTggYXQgMTA6MDk6
MDRBTSArMDAwMCwgWi5xLiBIb3Ugd3JvdGU6DQo+ID4gRnJvbTogSG91IFpoaXFpYW5nIDxaaGlx
aWFuZy5Ib3VAbnhwLmNvbT4NCj4gPg0KPiA+IEZyZWUgdGhlIGFsbG9jYXRlZCBwY2lfaG9zdF9i
cmlkZ2Ugc3RydWN0IHdoZW4gZmFpbGVkIHRvIGdldCBob3N0DQo+ID4gYnJpZGdlIHJlc291cmNl
cywgYW5kIGZyZWUgdGhlIHJlc291cmNlIHdpbmRvd3MgYmVmb3JlIGZyZWUgdGhlDQo+ID4gYnJp
ZGdlLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogSG91IFpoaXFpYW5nIDxaaGlxaWFuZy5Ib3VA
bnhwLmNvbT4NCj4gPiBBY2tlZC1ieTogR3VzdGF2byBQaW1lbnRlbCA8Z3VzdGF2by5waW1lbnRl
bEBzeW5vcHN5cy5jb20+DQo+ID4gLS0tDQo+ID4gVjI6DQo+ID4gIC0gUmV3b3JkZWQgdGhlIHN1
YmplY3QuDQo+ID4NCj4gPiAgZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253
YXJlLWhvc3QuYyB8IDMgKystDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyks
IDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9s
bGVyL2R3Yy9wY2llLWRlc2lnbndhcmUtaG9zdC5jDQo+ID4gYi9kcml2ZXJzL3BjaS9jb250cm9s
bGVyL2R3Yy9wY2llLWRlc2lnbndhcmUtaG9zdC5jDQo+ID4gaW5kZXggMjlhMDU3NTlhMjk0Li5l
Y2FjY2UwMTY0ODkgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2Mv
cGNpZS1kZXNpZ253YXJlLWhvc3QuYw0KPiA+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIv
ZHdjL3BjaWUtZGVzaWdud2FyZS1ob3N0LmMNCj4gPiBAQCAtMzUzLDcgKzM1Myw3IEBAIGludCBk
d19wY2llX2hvc3RfaW5pdChzdHJ1Y3QgcGNpZV9wb3J0ICpwcCkNCj4gPiAgCXJldCA9IGRldm1f
b2ZfcGNpX2dldF9ob3N0X2JyaWRnZV9yZXNvdXJjZXMoZGV2LCAwLCAweGZmLA0KPiA+ICAJCQkJ
CSZicmlkZ2UtPndpbmRvd3MsICZwcC0+aW9fYmFzZSk7DQo+ID4gIAlpZiAocmV0KQ0KPiA+IC0J
CXJldHVybiByZXQ7DQo+ID4gKwkJZ290byBlcnJvcjsNCj4gPg0KPiA+ICAJcmV0ID0gZGV2bV9y
ZXF1ZXN0X3BjaV9idXNfcmVzb3VyY2VzKGRldiwgJmJyaWRnZS0+d2luZG93cyk7DQo+ID4gIAlp
ZiAocmV0KQ0KPiA+IEBAIC01MDIsNiArNTAyLDcgQEAgaW50IGR3X3BjaWVfaG9zdF9pbml0KHN0
cnVjdCBwY2llX3BvcnQgKnBwKQ0KPiA+ICAJcmV0dXJuIDA7DQo+ID4NCj4gPiAgZXJyb3I6DQo+
ID4gKwlwY2lfZnJlZV9yZXNvdXJjZV9saXN0KCZicmlkZ2UtPndpbmRvd3MpOw0KPiANCj4gVGhp
cyB3b3VsZCBjYXVzZSBhIGRvdWJsZS1mcmVlLCBkZXZtX3JlcXVlc3RfcGNpX2J1c19yZXNvdXJj
ZSBhbHJlYWR5DQo+IHRha2VzIGNhcmUgb2YgZnJlZWluZyByZXNvdXJjZXMsIHBhdGNoIGRyb3Bw
ZWQuDQoNClllcywgSSBqdXN0IHVuZGVyc3Rvb2QuDQoNCj4gTG9yZW56bw0KPiANCj4gPiAgCXBj
aV9mcmVlX2hvc3RfYnJpZGdlKGJyaWRnZSk7DQo+ID4gIAlyZXR1cm4gcmV0Ow0KPiA+ICB9DQo+
ID4gLS0NCj4gPiAyLjE3LjENCj4gPg0KVGhhbmtzLA0KWmhpcWlhbmcNCg==

Return-Path: <SRS0=PFnE=OC=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEE9BC43441
	for <linux-pci@archiver.kernel.org>; Fri, 23 Nov 2018 06:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6903720865
	for <linux-pci@archiver.kernel.org>; Fri, 23 Nov 2018 06:22:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="xCFvGlzV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6903720865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502055AbeKWRFB (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 23 Nov 2018 12:05:01 -0500
Received: from mail-eopbgr40085.outbound.protection.outlook.com ([40.107.4.85]:5872
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729253AbeKWRFA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 23 Nov 2018 12:05:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kSg3CYJQHLRw0PToh8Np94JkDKBhiV3jbjs555N7PyE=;
 b=xCFvGlzVL+wytq87s+lKEfEbmSiY6o3E4QHO8fkU4PjzzaXhiG9GlniXetPsOxkQVvn3ffldgQDgZEXnqFQ+Bt04Qcz0t8ojZYCV1Sy6MnOCUebCILUiESvUCQZBE/MbipD0a3QovH2c14icQ9xa2BcX3sETOfrL+lsaB3DuOG8=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.2.80) by
 AM6PR04MB4439.eurprd04.prod.outlook.com (20.177.39.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.14; Fri, 23 Nov 2018 06:22:06 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::29b5:b3ed:3854:cf1c]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::29b5:b3ed:3854:cf1c%5]) with mapi id 15.20.1361.017; Fri, 23 Nov 2018
 06:22:06 +0000
From:   "Z.q. Hou" <zhiqiang.hou@nxp.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        Mingkai Hu <mingkai.hu@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>
Subject: RE: [PATCH 2/4] doc/layerscape-pci: removed unsuitable compatible
 string
Thread-Topic: [PATCH 2/4] doc/layerscape-pci: removed unsuitable compatible
 string
Thread-Index: AQHUXrUsqUPt1f5/7Umz+kJz90iNNaVb73mAgAE46HA=
Date:   Fri, 23 Nov 2018 06:22:06 +0000
Message-ID: <AM6PR04MB5781C1086B4EFF1BF73F72B284D40@AM6PR04MB5781.eurprd04.prod.outlook.com>
References: <20181008031428.25293-1-Zhiqiang.Hou@nxp.com>
 <20181008031428.25293-3-Zhiqiang.Hou@nxp.com>
 <20181122112809.GA11952@e107981-ln.cambridge.arm.com>
In-Reply-To: <20181122112809.GA11952@e107981-ln.cambridge.arm.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR04MB4439;6:HtnDEu+tiPrKqMhePOkPBs57D5SoGPQEWRVVrgkuq+FSta0zZ5xaQ261FZofqd/rWnDSunO9BUZFv2zB4KSEA7ezRV5aN2rpbCwoYzGngAQjDFuUzrgcSh/DcAIk6i+necxKc1GFvMQAOagH1v8rkrUO3NNkNGccsq2hMUGuncisKLxJz26arkuFSLXaNtvXXcfeZrkTBib/Ln41VMJMOFSi/RYXXLLrwxOnvrPtJb/UgcKI6+7nudtZSHm9fvcV4jHTDkPIc/uUPUijD1kGDdCxmX78JdiOjfqQn914cj4CmfNlfkOoyZEDrLT9hkh3h+qzuaVYu+evGWw+NjzApax5vF9GKMWwYf7MPgWoSNVN7qzf17m40O179OODmm6u97GyfFNUZHfmDflIBL/fzvMLQgJb4qMFJ1fwp61HgJ+S8csX6MbPQCE1p9aKYBXokW/C99oDJm6Mg/LOGavitg==;5:yYK1Vc7MnD5GKLdIvRG/5A2ly+lBjlzjO928Wiw7W4+F7W313CajZ8eyl+UypIyImGJDWie+YsSVzIF1vxNJgXk+mXka/2zcGF/TnkstPnS3yLrMWPueubksyuiI/sgQMcN8JSaWBoL0kZGi1twruG8SaFBsR8VkuRqYqwZRy3Y=;7:Gj9/hL4izl02+3Wta+NZJjXvEs62Su4UotC/CQL+YoJgL+XCIFveKFbK6lu2LWWyfXRzFyMC7u0hZbSOWk3cKdTX0oNB902R2ZY/QCt+oRnJZqIqIqjNtnzqRyLRqEJ/tfDvOEjmTngWMH1yrLGosA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 33fbd015-e876-4eb4-251b-08d6510bfdfb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4439;
x-ms-traffictypediagnostic: AM6PR04MB4439:
x-microsoft-antispam-prvs: <AM6PR04MB443944D101E322EFE86F540684D40@AM6PR04MB4439.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231442)(944501410)(52105112)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:AM6PR04MB4439;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB4439;
x-forefront-prvs: 086597191B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(366004)(136003)(376002)(346002)(199004)(189003)(13464003)(478600001)(14444005)(7736002)(2906002)(229853002)(33656002)(186003)(86362001)(305945005)(97736004)(53936002)(105586002)(106356001)(2900100001)(55016002)(25786009)(9686003)(316002)(5660300001)(6246003)(74316002)(26005)(6436002)(68736007)(476003)(486006)(66066001)(99286004)(71190400001)(71200400001)(7696005)(446003)(53546011)(11346002)(3846002)(8936002)(54906003)(8676002)(81156014)(6116002)(102836004)(81166006)(6916009)(14454004)(76176011)(256004)(4326008)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4439;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: PElSCR0BMUGDQSIvOZLHmrTXjsTn0JISOPOGCNl6+zVdqtZ+hC3BdyBMXhKS5ZAidHffSalgxBZeQzvb8H74PJEmlw/2YoszlRHpBUXgVHQsZa0WEnaH4RTOUzf9v3uhp7xrebX3Jus29/X64z9Ow983gLczRVjDJg0eSMNAAKCRXjGi0U5TbtrFptmB4uaX6CIyGkDGiQezDdHKCHPY6+Mx1BXdaIZtJ0tp9odIHpjmB++PXKF/8zEEA7RkyU7hGKSLapjvJs7rWY71lo7uR1aiwxseoiCY5XToUknuNnPh2BHUg4W/v2pnCCp4gZknFxt30+d6gBNtpqTwXv08o8luUaPkS2CaU7SNXCAFXvc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33fbd015-e876-4eb4-251b-08d6510bfdfb
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2018 06:22:06.4066
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4439
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgTG9yZW56bywNCg0KVGhhbmtzIGEgbG90IGZvciB5b3VyIGNvbW1lbnRzIQ0KDQo+IC0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IExvcmVuem8gUGllcmFsaXNpIFttYWlsdG86
bG9yZW56by5waWVyYWxpc2lAYXJtLmNvbV0NCj4gU2VudDogMjAxOMTqMTHUwjIyyNUgMTk6MjgN
Cj4gVG86IFoucS4gSG91IDx6aGlxaWFuZy5ob3VAbnhwLmNvbT4NCj4gQ2M6IGxpbnV4LWFybS1r
ZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsN
Cj4gbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7
IHJvYmgrZHRAa2VybmVsLm9yZzsNCj4gTGVvIExpIDxsZW95YW5nLmxpQG54cC5jb20+OyBzaGF3
bmd1b0BrZXJuZWwub3JnOw0KPiBtYXJrLnJ1dGxhbmRAYXJtLmNvbTsgYmhlbGdhYXNAZ29vZ2xl
LmNvbTsgTWluZ2thaSBIdQ0KPiA8bWluZ2thaS5odUBueHAuY29tPjsgTS5oLiBMaWFuIDxtaW5n
aHVhbi5saWFuQG54cC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMi80XSBkb2MvbGF5ZXJz
Y2FwZS1wY2k6IHJlbW92ZWQgdW5zdWl0YWJsZSBjb21wYXRpYmxlDQo+IHN0cmluZw0KPiANCj4g
T24gTW9uLCBPY3QgMDgsIDIwMTggYXQgMTE6MTQ6MjZBTSArMDgwMCwgWmhpcWlhbmcgSG91IHdy
b3RlOg0KPiA+IEZyb206IEhvdSBaaGlxaWFuZyA8WmhpcWlhbmcuSG91QG54cC5jb20+DQo+ID4N
Cj4gPiBSZW1vdmVkIHRoZSBjb21wYXRpYmxlIHN0cmluZyAic25wcyxkdy1wY2llIiwgaXQgaXMg
Zm9yIHRoZSByZWZlcmVuY2UNCj4gPiBwbGF0Zm9ybSBkcml2ZXIgZm9yIFBDSSBSQyBJUCBQcm90
b3lwaW5nIEtpdHMgYmFzZWQgb24gdGhlIEFSQyBTRFAsIHNvDQo+ID4gaXQgaXMgbm90IHN1aXRh
YmxlIGZvciBhbGwgcGxhdGZvcm0gd2l0aCBkZXNpZ253YXJlIFBDSWUgY29udHJvbGxlciwNCj4g
PiBhbmQgcGxhdGZvcm0gdmVuZG9ycyBoYXZlIHRoZW1zZWx2ZXMnIGRyaXZlcnMuDQo+ID4NCj4g
PiBUaGUgY29tcGF0aWJsZSBzdHJpbmcgInNuc3AsZHctcGNpZSIgd2FzIGFkZGVkIGJ5IG1pc3Rh
a2UgYW5kIGl0J3Mgbm90DQo+ID4gbWF0Y2hlZCB0aGF0IHRpbWUsIGJ1dCBpdCBpcyBtYXRjaGVk
IGJlY2F1c2UgcGNpZSBkcml2ZXJzIGhhcyBiZWVuDQo+ID4gY29sbGVjdGVkIHJlY2VudGx5Lg0K
PiANCj4gSSBkbyBub3QgdW5kZXJzdGFuZCB3aGF0IHlvdSBtZWFuLCBwbGVhc2UgZXhwbGFpbiBp
dCB0byBtZSBhbmQgSSB3aWxsIHVwZGF0ZQ0KPiB0aGUgY29tbWl0IGxvZyBhY2NvcmRpbmdseSBi
ZWZvcmUgbWVyZ2luZyBpdC4NCg0KQmVmb3JlIG1vdmluZyBQQ0llIGNvbnRyb2xsZXIgZHJpdmVy
cyB0byBkaXJlY3RvcnkgZHJpdmVycy9wY2kvY29udHJvbGxlcnMvLCBwY2ktbGF5ZXJzY2FwZS5j
IGNhbiBiZSBtYXRjaGVkIGNvcnJlY3RseSwgYnV0IGFmdGVyIHRoYXQgdGhlIHBjaWUtZGVzaWdu
d2FyZS1wbGF0LmMgaXMgbWF0Y2hlZCBpbnN0ZWFkIG9mIHRoZSBwY2ktbGF5ZXJzY2FwZS5jLiBT
byB0aGlzIHBhdGNoIGlzIHRvIGF2b2lkIG1hdGNoaW5nIHBjaWUtZGVzaWdud2FyZS1wbGF0LmMg
YnkgcmVtb3ZpbmcgdGhlICJzbnBzLGR3LXBjaWUiLg0KDQpUaGFua3MsDQpaaGlxaWFuZw0KDQo+
IExvcmVuem8NCj4gDQo+ID4gU2lnbmVkLW9mZi1ieTogSG91IFpoaXFpYW5nIDxaaGlxaWFuZy5I
b3VAbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL3BjaS9sYXllcnNjYXBlLXBjaS50eHQgfCA2ICsrKy0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdl
ZCwgMyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBh
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kvbGF5ZXJzY2FwZS1wY2kudHh0
DQo+ID4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGNpL2xheWVyc2NhcGUt
cGNpLnR4dA0KPiA+IGluZGV4IDVlYjFjMjAyOTMyZi4uOWIyYjhkNjZkMWY0IDEwMDY0NA0KPiA+
IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kvbGF5ZXJzY2FwZS1w
Y2kudHh0DQo+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9s
YXllcnNjYXBlLXBjaS50eHQNCj4gPiBAQCAtMTMsOCArMTMsOCBAQCBpbmZvcm1hdGlvbi4NCj4g
Pg0KPiA+ICBSZXF1aXJlZCBwcm9wZXJ0aWVzOg0KPiA+ICAtIGNvbXBhdGlibGU6IHNob3VsZCBj
b250YWluIHRoZSBwbGF0Zm9ybSBpZGVudGlmaWVyIHN1Y2ggYXM6DQo+ID4gLSAgICAgICAgImZz
bCxsczEwMjFhLXBjaWUiLCAic25wcyxkdy1wY2llIg0KPiA+IC0gICAgICAgICJmc2wsbHMyMDgw
YS1wY2llIiwgImZzbCxsczIwODVhLXBjaWUiLCAic25wcyxkdy1wY2llIg0KPiA+ICsgICAgICAg
ICJmc2wsbHMxMDIxYS1wY2llIg0KPiA+ICsgICAgICAgICJmc2wsbHMyMDgwYS1wY2llIiwgImZz
bCxsczIwODVhLXBjaWUiDQo+ID4gICAgICAgICAgImZzbCxsczIwODhhLXBjaWUiDQo+ID4gICAg
ICAgICAgImZzbCxsczEwODhhLXBjaWUiDQo+ID4gICAgICAgICAgImZzbCxsczEwNDZhLXBjaWUi
DQo+ID4gQEAgLTM2LDcgKzM2LDcgQEAgUmVxdWlyZWQgcHJvcGVydGllczoNCj4gPiAgRXhhbXBs
ZToNCj4gPg0KPiA+ICAJcGNpZUAzNDAwMDAwIHsNCj4gPiAtCQljb21wYXRpYmxlID0gImZzbCxs
czEwMjFhLXBjaWUiLCAic25wcyxkdy1wY2llIjsNCj4gPiArCQljb21wYXRpYmxlID0gImZzbCxs
czEwMjFhLXBjaWUiOw0KPiA+ICAJCXJlZyA9IDwweDAwIDB4MDM0MDAwMDAgMHgwIDB4MDAwMTAw
MDAgICAvKiBjb250cm9sbGVyIHJlZ2lzdGVycw0KPiAqLw0KPiA+ICAJCSAgICAgICAweDQwIDB4
MDAwMDAwMDAgMHgwIDB4MDAwMDIwMDA+OyAvKiBjb25maWd1cmF0aW9uIHNwYWNlDQo+ICovDQo+
ID4gIAkJcmVnLW5hbWVzID0gInJlZ3MiLCAiY29uZmlnIjsNCj4gPiAtLQ0KPiA+IDIuMTcuMQ0K
PiA+DQo=

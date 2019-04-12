Return-Path: <SRS0=vi1x=SO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83E38C10F0E
	for <linux-pci@archiver.kernel.org>; Fri, 12 Apr 2019 08:36:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49B262184B
	for <linux-pci@archiver.kernel.org>; Fri, 12 Apr 2019 08:36:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="i5Xv75wP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbfDLIgl (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 12 Apr 2019 04:36:41 -0400
Received: from mail-eopbgr130087.outbound.protection.outlook.com ([40.107.13.87]:12671
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727464AbfDLIgk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 12 Apr 2019 04:36:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SSrF5iDn4FvnnFklvT/y+wUEJ/Gwcs/6NCDqpK0hIJs=;
 b=i5Xv75wPWTTvOdYYgWG0YXzbxu5ulOKv0lIVsYEJSJvSDaR4NmtZg0Zz7PrIetgY6FtG3m9TltHlOofwQ888zJO7dl3kGf7rtQCAR6lT3BU07azV5iStUVmCoD0hhIPw8RrAoEx/AxqMp05N6F+eiSvt6ATAmSgCafur1TFH9Tg=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.3.19) by
 AM6PR04MB4183.eurprd04.prod.outlook.com (52.135.162.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.14; Fri, 12 Apr 2019 08:36:36 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::f9db:ed86:614e:460]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::f9db:ed86:614e:460%4]) with mapi id 15.20.1792.009; Fri, 12 Apr 2019
 08:36:36 +0000
From:   "Z.q. Hou" <zhiqiang.hou@nxp.com>
To:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "l.subrahmanya@mobiveil.co.in" <l.subrahmanya@mobiveil.co.in>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>
CC:     Mingkai Hu <mingkai.hu@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>,
        "Z.q. Hou" <zhiqiang.hou@nxp.com>
Subject: [PATCHv5 14/20] PCI: mobiveil: Initialize
 Primary/Secondary/Subordinate bus numbers
Thread-Topic: [PATCHv5 14/20] PCI: mobiveil: Initialize
 Primary/Secondary/Subordinate bus numbers
Thread-Index: AQHU8QrXdZ6l0xN2V0aK4vRG1WavQQ==
Date:   Fri, 12 Apr 2019 08:36:36 +0000
Message-ID: <20190412083635.33626-15-Zhiqiang.Hou@nxp.com>
References: <20190412083635.33626-1-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20190412083635.33626-1-Zhiqiang.Hou@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK2PR06CA0011.apcprd06.prod.outlook.com
 (2603:1096:202:2e::23) To AM6PR04MB5781.eurprd04.prod.outlook.com
 (2603:10a6:20b:ad::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1c537e1b-bd99-4a1c-f3e7-08d6bf21f964
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM6PR04MB4183;
x-ms-traffictypediagnostic: AM6PR04MB4183:
x-microsoft-antispam-prvs: <AM6PR04MB4183E9E6A440655A6282228684280@AM6PR04MB4183.eurprd04.prod.outlook.com>
x-forefront-prvs: 0005B05917
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(346002)(136003)(366004)(376002)(189003)(199004)(54534003)(7416002)(102836004)(446003)(52116002)(53936002)(50226002)(186003)(81166006)(8936002)(81156014)(26005)(106356001)(6506007)(6436002)(8676002)(7736002)(110136005)(6486002)(6512007)(54906003)(66066001)(2906002)(386003)(316002)(105586002)(99286004)(305945005)(5660300002)(86362001)(1076003)(71190400001)(97736004)(2201001)(71200400001)(4744005)(68736007)(36756003)(76176011)(14454004)(256004)(2501003)(486006)(476003)(11346002)(2616005)(478600001)(3846002)(6116002)(4326008)(25786009)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4183;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: p2/CilEBIvL1fp5Q9DWm/7OlRmuh22kbes59f6pi0/IDZbqJsGbW1PZnz/20nd6JONHYECkOlDGbYduUy67XI1ZOagGvO/F8A8KePf4/u7SU8YwxvOuFgll1UrI9G3vYCXyaDx8XB1a0dJGeYbXAj40gv5QLYUjCXvZ/ToSMMLU3wDRl+hw/PEoi9xBPeuHG6xNbFkTVztviNU9V3ZpFdbdeS+s9b8CFg3zD1hDmG6DoiIdQbIJDT3N0ukPkOh9wCzCEH084EUf7XS2/UhnpqGSmlZpuLrmFO92BhfH1B0PhDKzT5ZUncwuZ10o013e5NF8yv7pBUC1nxqYpaAckeEdhBk3osyispTzx73T3PyVXY0VYQ7IEBbsQyxO25RP1PBh/AsKfFmHBs6SogVojqhmFyZ8vWbw4Mk2rLlQkBBY=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c537e1b-bd99-4a1c-f3e7-08d6bf21f964
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2019 08:36:36.4637
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4183
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

RnJvbTogSG91IFpoaXFpYW5nIDxaaGlxaWFuZy5Ib3VAbnhwLmNvbT4NCg0KVGhlIHJlc2V0IHZh
bHVlIG9mIFByaW1hcnksIFNlY29uZGFyeSBhbmQgU3Vib3JkaW5hdGUgYnVzIG51bWJlcnMgaXMN
Cnplcm8sIHNvIHNldCBhIHdvcmthYmxlIHZhbHVlIGZvciB0aGVzZSAzIGJ1cyBudW1iZXJzLg0K
DQpTaWduZWQtb2ZmLWJ5OiBIb3UgWmhpcWlhbmcgPFpoaXFpYW5nLkhvdUBueHAuY29tPg0KUmV2
aWV3ZWQtYnk6IE1pbmdodWFuIExpYW4gPE1pbmdodWFuLkxpYW5AbnhwLmNvbT4NClJldmlld2Vk
LWJ5OiBTdWJyYWhtYW55YSBMaW5nYXBwYSA8bC5zdWJyYWhtYW55YUBtb2JpdmVpbC5jby5pbj4N
Ci0tLQ0KVjU6DQogLSBDb3JyZWN0ZWQgYW5kIHJldG91Y2hlZCB0aGUgc3ViamVjdCBhbmQgY2hh
bmdlbG9nLg0KDQogZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLW1vYml2ZWlsLmMgfCA2ICsr
KysrKw0KIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1tb2JpdmVpbC5jIGIvZHJpdmVycy9wY2kvY29udHJv
bGxlci9wY2llLW1vYml2ZWlsLmMNCmluZGV4IGRiN2VjYjAyMWM2My4uOTIxMDE2NWZlOGMwIDEw
MDY0NA0KLS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLW1vYml2ZWlsLmMNCisrKyBi
L2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1tb2JpdmVpbC5jDQpAQCAtNTgyLDYgKzU4Miwx
MiBAQCBzdGF0aWMgaW50IG1vYml2ZWlsX2hvc3RfaW5pdChzdHJ1Y3QgbW9iaXZlaWxfcGNpZSAq
cGNpZSkNCiAJdTMyIHZhbHVlLCBwYWJfY3RybCwgdHlwZTsNCiAJc3RydWN0IHJlc291cmNlX2Vu
dHJ5ICp3aW47DQogDQorCS8qIHNldHVwIGJ1cyBudW1iZXJzICovDQorCXZhbHVlID0gY3NyX3Jl
YWRsKHBjaWUsIFBDSV9QUklNQVJZX0JVUyk7DQorCXZhbHVlICY9IDB4ZmYwMDAwMDA7DQorCXZh
bHVlIHw9IDB4MDBmZjAxMDA7DQorCWNzcl93cml0ZWwocGNpZSwgdmFsdWUsIFBDSV9QUklNQVJZ
X0JVUyk7DQorDQogCS8qDQogCSAqIHByb2dyYW0gQnVzIE1hc3RlciBFbmFibGUgQml0IGluIENv
bW1hbmQgUmVnaXN0ZXIgaW4gUEFCIENvbmZpZw0KIAkgKiBTcGFjZQ0KLS0gDQoyLjE3LjENCg0K

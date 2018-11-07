Return-Path: <SRS0=4zPb=NS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 584E9C0044C
	for <linux-pci@archiver.kernel.org>; Wed,  7 Nov 2018 05:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1604F2086B
	for <linux-pci@archiver.kernel.org>; Wed,  7 Nov 2018 05:35:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Voyi+RJh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1604F2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387668AbeKGPEU (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 7 Nov 2018 10:04:20 -0500
Received: from mail-db5eur01on0054.outbound.protection.outlook.com ([104.47.2.54]:35677
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387568AbeKGPET (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 7 Nov 2018 10:04:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZR/Ng4gTG8lFYdUg2tKH5wltuCuTdP0ookBnWnzG+Sw=;
 b=Voyi+RJhCja7CBkJeB293PyqO19sKQaZXJn/3CCOAec3+5YZB5mmuf6/mVhmtxDNNJxkF36iJAXyj6PqRxbWlYBsLS4TVNy1chsLdDEc+OdOEzcLL5BgE7zSEl36tEZAnTf+MybulJFuNHHPd3wRNDkjoymt6A9fMkfhdTWVEsE=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.2.80) by
 AM6PR04MB4152.eurprd04.prod.outlook.com (52.135.168.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Wed, 7 Nov 2018 05:35:27 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::7d93:8053:57fd:1a00]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::7d93:8053:57fd:1a00%3]) with mapi id 15.20.1273.035; Wed, 7 Nov 2018
 05:35:27 +0000
From:   "Z.q. Hou" <zhiqiang.hou@nxp.com>
To:     "linux-arm-kernel@lists.infradead.org" 
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
CC:     "Z.q. Hou" <zhiqiang.hou@nxp.com>
Subject: [PATCHv3 3/4] ARM: dts: ls1021a: removed compatible string
 "snps,dw-pcie"
Thread-Topic: [PATCHv3 3/4] ARM: dts: ls1021a: removed compatible string
 "snps,dw-pcie"
Thread-Index: AQHUdluwp/s3SC3n0kaUxtqrvNNwTQ==
Date:   Wed, 7 Nov 2018 05:35:27 +0000
Message-ID: <20181107053500.13575-4-Zhiqiang.Hou@nxp.com>
References: <20181107053500.13575-1-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20181107053500.13575-1-Zhiqiang.Hou@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0PR03CA0034.apcprd03.prod.outlook.com
 (2603:1096:203:2f::22) To AM6PR04MB5781.eurprd04.prod.outlook.com
 (2603:10a6:20b:aa::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR04MB4152;6:JUBLJZ3XNZfXMxiSN9xB6+mMx+80SpM2NO6VfPErDOJRQOvhk4MeeKlPVWiX9wJo5wHVXsLCETzv7rNUTvgF5oeS9Mt/M6cUUkVKeLIruIoTx0l9eXMRFDbjP8TfLFrGlWYUP0IBuC+QYA7em0EDW+mcViW4/lVuj0L3GhZXAY0TZKY64SsC0FV5q5KOHUQvYuL0+R1SjMiNyB4eO5FM4qtjSnDPSKYoT9qd8ITxqCCyt4TNGrvhTVy65RBFcvy9ze9eQAeX+iyAGzB+X4/vjyxaPK5qtN5o3CAWE6slP1Jcc44vbRA/NxMREuD5ldaesW8o+hlT06ClL08JkmJPJ7L5gVrxfQr4d1gUUmJ6LwNrsBbP6cwey/yuXIx1+ZnckbzhgzPOp7S6S4eoQCUpNvQ1Lro1+mmqggU5KYwtoJ4v48TbD6b/aK6qRH9upfSPn31I0Xb72hDji3JzA/uu2g==;5:NpOxnroqb1mRyrAfeQ4MGAiEGsduQK52sJln5aYD9RaR8dsGKC8BqEq1sYj97xqwJ3eOka7nmCtzzacHIecRd0DYa32Wn45LafhOYBcamqWyZp6iP2xZwuBSZUKgH1VGeVaVrtODAaBuxagbDSGija2doR643hXLo7Dj7P2GwY4=;7:O7HfhUUpOkUKqGQ5O0boTJh7IjLWU4/3719R5t+36wRYQiwzPCXc+hTSnv6qAOvtIU8wbPUqSAM29Sgo8GJQclFv+C94q50icO4OWAgJemaZYmhaRn0pz/mik0reaSpLZwoOgPREoUsLL6UTcgBVkg==
x-ms-office365-filtering-correlation-id: 5aebd977-0c37-4997-34dc-08d64472d274
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4152;
x-ms-traffictypediagnostic: AM6PR04MB4152:
x-microsoft-antispam-prvs: <AM6PR04MB4152D6226D6FBC42C30C27AF84C40@AM6PR04MB4152.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231382)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:AM6PR04MB4152;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB4152;
x-forefront-prvs: 08497C3D99
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(39860400002)(366004)(136003)(189003)(199004)(81166006)(106356001)(81156014)(2616005)(76176011)(6636002)(6486002)(105586002)(14454004)(2501003)(476003)(68736007)(8676002)(6512007)(8936002)(478600001)(53936002)(6436002)(52116002)(256004)(97736004)(4326008)(71200400001)(71190400001)(66066001)(99286004)(486006)(86362001)(6506007)(386003)(446003)(186003)(102836004)(5660300001)(26005)(2201001)(11346002)(305945005)(316002)(3846002)(110136005)(36756003)(1076002)(2906002)(7736002)(6116002)(2900100001)(25786009)(921003)(142933001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4152;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 8KMZ7hDMmqHZ3Ye9eNjxng6679Ki3JeK5Xa7cZGm8bbk+uGWwzHrvqfESJSHZTc0OFxBM2eH9Y7vYOsf52LHAqybF8lLRwK4JNenvu4t/FzebbXUIlgRrFKDc5tOIcPzVIl7wWvzDQFx8i0BVoolFc3FZzLKqn6dfa80MsK7TWpT+Er9yVm7TN1zmpSswntPeGoWIlz+jrzQ/St9MU5eHSNipmva9EhNae4wOpMWkJB++q5WYBF9Sinqm4GS7tZyoT0oc7Xp0sFr7avmSWAkaU2roqsul6or0IA9ZrkyqrXUb2jveYSEP5wC3o33ytyB1+2OZX95s72dc4ANZEV6p/04K2bsrcV4dR01+SSS+rY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aebd977-0c37-4997-34dc-08d64472d274
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2018 05:35:27.7252
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4152
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Removed the wrong compatible string "snps,dw-pcie", in case
match incorrect driver.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
V3:
 - Reworded the subject.

 arch/arm/boot/dts/ls1021a.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dts=
i
index bdd6e66a79ad..1aaa3288a450 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -716,7 +716,7 @@
 		};
=20
 		pcie@3400000 {
-			compatible =3D "fsl,ls1021a-pcie", "snps,dw-pcie";
+			compatible =3D "fsl,ls1021a-pcie";
 			reg =3D <0x00 0x03400000 0x0 0x00010000   /* controller registers */
 			       0x40 0x00000000 0x0 0x00002000>; /* configuration space */
 			reg-names =3D "regs", "config";
@@ -739,7 +739,7 @@
 		};
=20
 		pcie@3500000 {
-			compatible =3D "fsl,ls1021a-pcie", "snps,dw-pcie";
+			compatible =3D "fsl,ls1021a-pcie";
 			reg =3D <0x00 0x03500000 0x0 0x00010000   /* controller registers */
 			       0x48 0x00000000 0x0 0x00002000>; /* configuration space */
 			reg-names =3D "regs", "config";
--=20
2.17.1


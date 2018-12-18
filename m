Return-Path: <SRS0=EJXn=O3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B28C43387
	for <linux-pci@archiver.kernel.org>; Tue, 18 Dec 2018 04:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E47821849
	for <linux-pci@archiver.kernel.org>; Tue, 18 Dec 2018 04:20:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="pzqJ8QiR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbeLREUR (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 17 Dec 2018 23:20:17 -0500
Received: from mail-eopbgr60046.outbound.protection.outlook.com ([40.107.6.46]:52304
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726305AbeLREUQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 17 Dec 2018 23:20:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VKRZFZ5xklRUsDW/ETgpbKc1ANi3Rst1a2gdEAK2MjM=;
 b=pzqJ8QiRKmeO0JdiLCpaQV5OjdnNfX7HBIYqhuUuEUaYjcRTSH+0e7fAh2wHkb5LHN8idFHwlvHH6wAcxJ5JfNAEPbCySrXoOSKjveTJVxAvb2wBGgdyeY1005ZHOCb5edD3qgv0wrJsYjLAResji33MZC65SWua8+SkSVVkCFY=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.2.80) by
 AM6PR04MB4102.eurprd04.prod.outlook.com (52.135.167.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.20; Tue, 18 Dec 2018 04:19:32 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::4d2e:cf15:fcf7:56b2]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::4d2e:cf15:fcf7:56b2%5]) with mapi id 15.20.1446.015; Tue, 18 Dec 2018
 04:19:32 +0000
From:   "Z.q. Hou" <zhiqiang.hou@nxp.com>
To:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        Leo Li <leoyang.li@nxp.com>
CC:     Roy Zang <roy.zang@nxp.com>, Mingkai Hu <mingkai.hu@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        "Z.q. Hou" <zhiqiang.hou@nxp.com>
Subject: [PATCHv3 2/5] arm64: dts: layerscape: add num-viewport property for
 PCIe DT nodes
Thread-Topic: [PATCHv3 2/5] arm64: dts: layerscape: add num-viewport property
 for PCIe DT nodes
Thread-Index: AQHUlojgKIgvtm9vJk+CrhOvDCDM7A==
Date:   Tue, 18 Dec 2018 04:19:32 +0000
Message-ID: <20181218041956.41809-3-Zhiqiang.Hou@nxp.com>
References: <20181218041956.41809-1-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20181218041956.41809-1-Zhiqiang.Hou@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0PR03CA0075.apcprd03.prod.outlook.com
 (2603:1096:203:72::15) To AM6PR04MB5781.eurprd04.prod.outlook.com
 (2603:10a6:20b:aa::16)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR04MB4102;6:kEZXJ6w1RiHwSxWsgi14qQcgk6+61b6ClhkdvkMdNLuu0DkdciY2dGKs1OLpyXswWNUtaAne6RLsi8GVKK00GptNU2mlOUubY3ELoneenb1wPBtWCUkcrqjdr3EI4UekbmmUNEK0gjYXlypIlqPVLJ9/wcpzIuVHfqf23I2E7Skv1ekkHPQfzDe2HnjryonX1HCgml2uohjomuSf3hhQrbF8IB2Vh/W4fk607LCG5xmX7imzlFKGqkEkQDqdCge6OJbeO1eZsGA4NW1QeKC8WlckfvImEAIu57VTBmDm/p/HTmbQFnPm0+fVlvfrJUq+0OFq03niv+QNQjodLwP8VblT99QXASSVcGLBIans5b/le+kmzbmkuL/8F2KPJhaSXSKz8+FiOSbC3QziZPkmXF7meoaWudn2JeI6W34YtOaGxuIOkDPxzmJtcJEf8KyCk8HhIDXvrM5xYn7dgyHVKw==;5:sN+D8+iByAJyji6efT53cuWFjFc+MMXsYu/YS99auRZMhhgCUsiGuNcVmM7v1ajlSOBEmSbTzw9aQ8kOuIoZzmQ/r0lmbd1YmvQTuQteXguzFLwyaFei1TLL1/qCqhtzEd0N/hwIn9/Aab8+XEsHm8UewOBcFR6rKWWj1ak49+E=;7:3kujN/iJqllK8i9g3XvZSAx4Di76XYE4cimyVSFbWytoth8D1XZT2TpEyUQhsbGQJDZiTgOStUqKDqQq+E3uxs7fX78+dXF622q144kopaSlql9ghV+zaxlGGa08FZfsiL4AIqWtiGunLQT3caD7Wg==
x-ms-office365-filtering-correlation-id: 1a838ac3-28db-4fdc-d37d-08d664a00283
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4102;
x-ms-traffictypediagnostic: AM6PR04MB4102:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-microsoft-antispam-prvs: <AM6PR04MB4102DDD1CB78A8F2CBE1D13C84BD0@AM6PR04MB4102.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(5005020)(6040522)(2401047)(8121501046)(93006095)(93001095)(3231475)(944501520)(52105112)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:AM6PR04MB4102;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB4102;
x-forefront-prvs: 08902E536D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(396003)(136003)(346002)(376002)(199004)(189003)(52116002)(7736002)(97736004)(7416002)(68736007)(25786009)(4326008)(36756003)(316002)(106356001)(102836004)(6636002)(105586002)(99286004)(2616005)(71200400001)(486006)(305945005)(11346002)(186003)(6506007)(386003)(110136005)(54906003)(76176011)(6486002)(1076003)(5660300001)(71190400001)(446003)(476003)(26005)(2501003)(2906002)(2201001)(86362001)(575784001)(6436002)(256004)(3846002)(6116002)(39060400002)(81166006)(66066001)(8936002)(81156014)(8676002)(478600001)(6512007)(53936002)(14454004)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4102;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 0wvlBQKhhTrDZrWgiNPkK9PAAqRljIvb2HRChTF0D0vS5UdgNNt3u1UnG4YOnAoe2ewDgdOeFYDm94Bf74G8mF0TxRVbA1uoa8s/jyQWVtQb1x65viujA2ZIURcBC5cZ+SyRLD1mAyGwQKsZaSLDevxdy0SNcXfVDrLatmRvVMI5DhWJbqqmDqbk30UmTYHweaNNirZhBwnbUvWZkKUZrRF94jmIhtEmppZJeX2S9LdgJAxdfAnByqj5BsmRt9l3erKRDBZrB8zZIvh6RYLGOB4VxxaT8nyy+QGQ6zZIcCNK0OMG+9UevEYXiLuxaDiD
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a838ac3-28db-4fdc-d37d-08d664a00283
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2018 04:19:32.1894
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4102
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Add num-viewport property for PCIe DT nodes to specify how many
viewports are implemented.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
V3:
 - New patch=20

 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi | 1 +
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 3 +++
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 3 +++
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi | 3 +++
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi | 4 ++++
 5 files changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi b/arch/arm64/bo=
ot/dts/freescale/fsl-ls1012a.dtsi
index 21f2b3ba6b58..7ce0aa52292c 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
@@ -486,6 +486,7 @@
 			#size-cells =3D <2>;
 			device_type =3D "pci";
 			num-lanes =3D <4>;
+			num-viewport =3D <2>;
 			bus-range =3D <0x0 0xff>;
 			ranges =3D <0x81000000 0x0 0x00000000 0x40 0x00010000 0x0 0x00010000   =
/* downstream I/O */
 				  0x82000000 0x0 0x40000000 0x40 0x40000000 0x0 0x40000000>; /* non-pr=
efetchable memory */
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/bo=
ot/dts/freescale/fsl-ls1043a.dtsi
index 760d510d78de..f42368afeea9 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -673,6 +673,7 @@
 			device_type =3D "pci";
 			dma-coherent;
 			num-lanes =3D <4>;
+			num-viewport =3D <6>;
 			bus-range =3D <0x0 0xff>;
 			ranges =3D <0x81000000 0x0 0x00000000 0x40 0x00010000 0x0 0x00010000   =
/* downstream I/O */
 				  0x82000000 0x0 0x40000000 0x40 0x40000000 0x0 0x40000000>; /* non-pr=
efetchable memory */
@@ -699,6 +700,7 @@
 			device_type =3D "pci";
 			dma-coherent;
 			num-lanes =3D <2>;
+			num-viewport =3D <6>;
 			bus-range =3D <0x0 0xff>;
 			ranges =3D <0x81000000 0x0 0x00000000 0x48 0x00010000 0x0 0x00010000   =
/* downstream I/O */
 				  0x82000000 0x0 0x40000000 0x48 0x40000000 0x0 0x40000000>; /* non-pr=
efetchable memory */
@@ -725,6 +727,7 @@
 			device_type =3D "pci";
 			dma-coherent;
 			num-lanes =3D <2>;
+			num-viewport =3D <6>;
 			bus-range =3D <0x0 0xff>;
 			ranges =3D <0x81000000 0x0 0x00000000 0x50 0x00010000 0x0 0x00010000   =
/* downstream I/O */
 				  0x82000000 0x0 0x40000000 0x50 0x40000000 0x0 0x40000000>; /* non-pr=
efetchable memory */
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/bo=
ot/dts/freescale/fsl-ls1046a.dtsi
index 64d334c6b0b4..10be89168793 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -642,6 +642,7 @@
 			device_type =3D "pci";
 			dma-coherent;
 			num-lanes =3D <4>;
+			num-viewport =3D <8>;
 			bus-range =3D <0x0 0xff>;
 			ranges =3D <0x81000000 0x0 0x00000000 0x40 0x00010000 0x0 0x00010000   =
/* downstream I/O */
 				  0x82000000 0x0 0x40000000 0x40 0x40000000 0x0 0x40000000>; /* non-pr=
efetchable memory */
@@ -668,6 +669,7 @@
 			device_type =3D "pci";
 			dma-coherent;
 			num-lanes =3D <2>;
+			num-viewport =3D <8>;
 			bus-range =3D <0x0 0xff>;
 			ranges =3D <0x81000000 0x0 0x00000000 0x48 0x00010000 0x0 0x00010000   =
/* downstream I/O */
 				  0x82000000 0x0 0x40000000 0x48 0x40000000 0x0 0x40000000>; /* non-pr=
efetchable memory */
@@ -694,6 +696,7 @@
 			device_type =3D "pci";
 			dma-coherent;
 			num-lanes =3D <2>;
+			num-viewport =3D <8>;
 			bus-range =3D <0x0 0xff>;
 			ranges =3D <0x81000000 0x0 0x00000000 0x50 0x00010000 0x0 0x00010000   =
/* downstream I/O */
 				  0x82000000 0x0 0x40000000 0x50 0x40000000 0x0 0x40000000>; /* non-pr=
efetchable memory */
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/bo=
ot/dts/freescale/fsl-ls1088a.dtsi
index 9deb9cb83046..7d303bd40047 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
@@ -523,6 +523,7 @@
 			device_type =3D "pci";
 			dma-coherent;
 			num-lanes =3D <4>;
+			num-viewport =3D <256>;
 			bus-range =3D <0x0 0xff>;
 			ranges =3D <0x81000000 0x0 0x00000000 0x20 0x00010000 0x0 0x00010000   =
/* downstream I/O */
 				  0x82000000 0x0 0x40000000 0x20 0x40000000 0x0 0x40000000>; /* non-pr=
efetchable memory */
@@ -548,6 +549,7 @@
 			device_type =3D "pci";
 			dma-coherent;
 			num-lanes =3D <4>;
+			num-viewport =3D <6>;
 			bus-range =3D <0x0 0xff>;
 			ranges =3D <0x81000000 0x0 0x00000000 0x28 0x00010000 0x0 0x00010000   =
/* downstream I/O */
 				  0x82000000 0x0 0x40000000 0x28 0x40000000 0x0 0x40000000>; /* non-pr=
efetchable memory */
@@ -573,6 +575,7 @@
 			device_type =3D "pci";
 			dma-coherent;
 			num-lanes =3D <8>;
+			num-viewport =3D <6>;
 			bus-range =3D <0x0 0xff>;
 			ranges =3D <0x81000000 0x0 0x00000000 0x30 0x00010000 0x0 0x00010000   =
/* downstream I/O */
 				  0x82000000 0x0 0x40000000 0x30 0x40000000 0x0 0x40000000>; /* non-pr=
efetchable memory */
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi b/arch/arm64/bo=
ot/dts/freescale/fsl-ls208xa.dtsi
index 5732e3b48be7..4bb9aa2dd8b2 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
@@ -640,6 +640,7 @@
 			device_type =3D "pci";
 			dma-coherent;
 			num-lanes =3D <4>;
+			num-viewport =3D <6>;
 			bus-range =3D <0x0 0xff>;
 			msi-parent =3D <&its>;
 			#interrupt-cells =3D <1>;
@@ -662,6 +663,7 @@
 			device_type =3D "pci";
 			dma-coherent;
 			num-lanes =3D <4>;
+			num-viewport =3D <6>;
 			bus-range =3D <0x0 0xff>;
 			msi-parent =3D <&its>;
 			#interrupt-cells =3D <1>;
@@ -684,6 +686,7 @@
 			device_type =3D "pci";
 			dma-coherent;
 			num-lanes =3D <8>;
+			num-viewport =3D <256>;
 			bus-range =3D <0x0 0xff>;
 			msi-parent =3D <&its>;
 			#interrupt-cells =3D <1>;
@@ -706,6 +709,7 @@
 			device_type =3D "pci";
 			dma-coherent;
 			num-lanes =3D <4>;
+			num-viewport =3D <6>;
 			bus-range =3D <0x0 0xff>;
 			msi-parent =3D <&its>;
 			#interrupt-cells =3D <1>;
--=20
2.17.1


Return-Path: <SRS0=j7M/=MU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B011AC677D4
	for <linux-pci@archiver.kernel.org>; Mon,  8 Oct 2018 18:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D89E2085B
	for <linux-pci@archiver.kernel.org>; Mon,  8 Oct 2018 18:06:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Nlkk7pW8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D89E2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbeJIBTn (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:19:43 -0400
Received: from mail-he1eur01on0075.outbound.protection.outlook.com ([104.47.0.75]:22699
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726291AbeJIBTm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 8 Oct 2018 21:19:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jU4sh9p0QI3JnHWKdhC4KTppA+o50FhN3OVg8t8iO44=;
 b=Nlkk7pW8wgUxlnl92IcBX4zeFf9K1D9pzUUY8SAtjBbUU6HIc3BGKeM63/F0VFZ5IHtDeIy5kPo/e+SQ9a4O5nEnpKpMqR+twlBvjCm9xwgwL0B0K63aw2kSScmUa2MUZkti6R8yeH4JmEPVtWGQ6kydKfhgSnbCuJm3J94kfDM=
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com (52.134.126.145) by
 AM0PR04MB5172.eurprd04.prod.outlook.com (20.177.42.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.22; Mon, 8 Oct 2018 18:06:23 +0000
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::3836:6416:4ebd:34ef]) by AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::3836:6416:4ebd:34ef%3]) with mapi id 15.20.1207.024; Mon, 8 Oct 2018
 18:06:23 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Richard Zhu <hongxing.zhu@nxp.com>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Stefan Agner <stefan@agner.ch>, Marek Vasut <marex@denx.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 4/4] ARM: dts: imx6sx: Add DISPLAY power domain support
Thread-Topic: [PATCH v2 4/4] ARM: dts: imx6sx: Add DISPLAY power domain
 support
Thread-Index: AQHUXzGf8guh/Nb5iEavRi81Wh8wzA==
Date:   Mon, 8 Oct 2018 18:06:23 +0000
Message-ID: <a3265a84052a7c11ae96e61e39adc988ca980d66.1539020938.git.leonard.crestez@nxp.com>
References: <cover.1539020938.git.leonard.crestez@nxp.com>
In-Reply-To: <cover.1539020938.git.leonard.crestez@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [95.76.156.53]
x-mailer: git-send-email 2.17.1
x-clientproxiedby: AM6PR0102CA0011.eurprd01.prod.exchangelabs.com
 (2603:10a6:209:14::24) To AM0PR04MB4290.eurprd04.prod.outlook.com
 (2603:10a6:208:67::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB5172;6:JqlnMqd77xCXajVbZs6yPxo1Q03ExFCze/xJunOxYE3tHf4gXPhwV6k/HFIMjW2erHuGAhKZdSA1HoK8RKaLldLmdCsFxFAZoZdETyFTmpctkd5KRcU7DD0onqj5pD5/Dlj45J6Sp2REbyAxDgjtt/HTWOScZcNoUs2Zi8Xq2SH2VOH1L4vg1zlRA5gcBvu5Mv5ou27PGn/qHb8d6dVby2Ld8k+U2oYCdcwfs5S3gST/afa2xUmQ3r/VMKyBuEvJqbPyyUf2KuSteaP36zGRYmK++MRsB4v5zePgueGPK+YdtKi5iZvt9Oid4qKBZwUnD1k4QT95vrbR70Vf+b/r8hS271Z1IrxxdrXObizaE0dTe+d6m/6MH/B8EWmPDAnRlGMLL/dk5qK5wPNV/pSTG54Ytzfh0rt9MKz1nfkuW3ntmjM4W5466YkSnE/oTLvGtTh8qNlrjNB6mAGSaqA1uw==;5:q9zlt/rqly/L7m20KpzdbwjaWv4luMhy31CDGOunH0+kcs/c1oO+pg1Z2nLLHRH6PPba1vEmmwoIfTlzZv7heumgrZxoLMthm1OAONW+SR4u8M3Yrfgr1453dtdmVoSyZ/piMN9N16iDWHS+xHGFgVJpIFhnf8PytQCoTM9qXkU=;7:2Y1aKL4rik5xTckcUHTde/qX0suGl/dVZ7JrM8WiJmS1bMlPzgy4AgqihaTLDKKFwMO5Dn/9WO7hAd4mxCbPZeLBBoDtYLvxcfEpf/Q1JBtvwwYHlPhzUl+MAhhtvGc6zAY9P10Q3SHDj2L9xBtDSEHNJCA9uNOm3x7loeLlEP582RbO3qb2VZAE4QBNjNaM5q/RdR9JOI3ivfNI0SaOtko6xiHRjs9sUwf+eDibS+UHtnUsXblJylSAwcsqBS+4
x-ms-office365-filtering-correlation-id: 497742ac-5de6-41cd-e134-08d62d48c17f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5172;
x-ms-traffictypediagnostic: AM0PR04MB5172:
x-microsoft-antispam-prvs: <AM0PR04MB5172EDF5247DE8FB938F70B6EEE60@AM0PR04MB5172.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(269456686620040)(17755550239193)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699051);SRVR:AM0PR04MB5172;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB5172;
x-forefront-prvs: 081904387B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(346002)(136003)(376002)(366004)(199004)(189003)(2906002)(54906003)(25786009)(2900100001)(186003)(14454004)(66066001)(110136005)(53936002)(6512007)(6436002)(36756003)(97736004)(71190400001)(26005)(102836004)(76176011)(6116002)(6486002)(3846002)(4326008)(86362001)(256004)(14444005)(71200400001)(5250100002)(316002)(7736002)(446003)(105586002)(68736007)(7416002)(8936002)(118296001)(8676002)(81156014)(106356001)(478600001)(6636002)(5660300001)(44832011)(2616005)(476003)(486006)(305945005)(52116002)(6506007)(386003)(11346002)(81166006)(50226002)(99286004)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5172;H:AM0PR04MB4290.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: VJvKZjje/mZwsBkhxpZzEr0E5RHN8tQUID5PEIYHHMDwRABxEImnqCpr+nVAEw3+OQtGH9MzD84oCjwv5jRTO/WDkymlTVyV5hUYRfyIJqak8Wz/OCNIuCCHfftEvPDsxq4tBSsknK1FOxBo8cjoxaZCXhXG2Vho9OeRNnzTWticOzryCsW2N+M1xdqSUlpVHKZ0Xqx3gnKrddpvDLiLJxUc0KlAfxMcIkYj0TjMPbsIvEoSLtNFrQIHjQUf2DDc2chNp2Pl10pJ7tqT2mWvJZRA/FG4adVKwVKo8A1o+dLz5oqOqsDLyW4T9Kgw7tl3NJLA+1Af0TwWauaaufdTOQG9gtLuy+vTs/MkxBcP1QY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 497742ac-5de6-41cd-e134-08d62d48c17f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2018 18:06:23.0184
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5172
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This was implemented in the driver but not actually defined and
referenced in dts. This makes it always on.

From reference manual in section "10.4.1.4.1 Power Distribution":

"Display domain - The DISPLAY domain contains GIS, CSI, PXP, LCDIF,
PCIe, DCIC, and LDB. It is supplied by internal regulator."

The current pd_pcie is actually only for PCIE_PHY, the PCIE ip block is
actually inside the DISPLAY domain. Handle this by adding the pcie node
in both power domains.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 arch/arm/boot/dts/imx6sx.dtsi | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index 95a3c1cb877d..b7f815d82d1b 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -778,10 +778,22 @@
 						#power-domain-cells =3D <0>;
 						power-supply =3D <&reg_soc>;
 						clocks =3D <&clks IMX6SX_CLK_GPU>;
 					};
=20
+					pd_disp: power-domain@2 {
+						reg =3D <2>;
+						#power-domain-cells =3D <0>;
+						clocks =3D <&clks IMX6SX_CLK_PXP_AXI>,
+							 <&clks IMX6SX_CLK_DISPLAY_AXI>,
+							 <&clks IMX6SX_CLK_LCDIF1_PIX>,
+							 <&clks IMX6SX_CLK_LCDIF_APB>,
+							 <&clks IMX6SX_CLK_LCDIF2_PIX>,
+							 <&clks IMX6SX_CLK_CSI>,
+							 <&clks IMX6SX_CLK_VADC>;
+					};
+
 					pd_pci: power-domain@3 {
 						reg =3D <3>;
 						#power-domain-cells =3D <0>;
 						power-supply =3D <&reg_pcie>;
 					};
@@ -1196,10 +1208,11 @@
 					reg =3D <0x02218000 0x4000>;
 					interrupts =3D <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
 					clocks =3D <&clks IMX6SX_CLK_PXP_AXI>,
 						 <&clks IMX6SX_CLK_DISPLAY_AXI>;
 					clock-names =3D "pxp-axi", "disp-axi";
+					power-domains =3D <&pd_disp>;
 					status =3D "disabled";
 				};
=20
 				csi2: csi@221c000 {
 					reg =3D <0x0221c000 0x4000>;
@@ -1217,10 +1230,11 @@
 					interrupts =3D <GIC_SPI 5 IRQ_TYPE_EDGE_RISING>;
 					clocks =3D <&clks IMX6SX_CLK_LCDIF1_PIX>,
 						 <&clks IMX6SX_CLK_LCDIF_APB>,
 						 <&clks IMX6SX_CLK_DISPLAY_AXI>;
 					clock-names =3D "pix", "axi", "disp_axi";
+					power-domains =3D <&pd_disp>;
 					status =3D "disabled";
 				};
=20
 				lcdif2: lcdif@2224000 {
 					compatible =3D "fsl,imx6sx-lcdif", "fsl,imx28-lcdif";
@@ -1228,19 +1242,21 @@
 					interrupts =3D <GIC_SPI 6 IRQ_TYPE_EDGE_RISING>;
 					clocks =3D <&clks IMX6SX_CLK_LCDIF2_PIX>,
 						 <&clks IMX6SX_CLK_LCDIF_APB>,
 						 <&clks IMX6SX_CLK_DISPLAY_AXI>;
 					clock-names =3D "pix", "axi", "disp_axi";
+					power-domains =3D <&pd_disp>;
 					status =3D "disabled";
 				};
=20
 				vadc: vadc@2228000 {
 					reg =3D <0x02228000 0x4000>, <0x0222c000 0x4000>;
 					reg-names =3D "vadc-vafe", "vadc-vdec";
 					clocks =3D <&clks IMX6SX_CLK_VADC>,
 						 <&clks IMX6SX_CLK_CSI>;
 					clock-names =3D "vadc", "csi";
+					power-domains =3D <&pd_disp>;
 					status =3D "disabled";
 				};
 			};
=20
 			adc1: adc@2280000 {
@@ -1361,10 +1377,11 @@
 			clocks =3D <&clks IMX6SX_CLK_PCIE_AXI>,
 				 <&clks IMX6SX_CLK_LVDS1_OUT>,
 				 <&clks IMX6SX_CLK_PCIE_REF_125M>,
 				 <&clks IMX6SX_CLK_DISPLAY_AXI>;
 			clock-names =3D "pcie", "pcie_bus", "pcie_phy", "pcie_inbound_axi";
-			power-domains =3D <&pd_pci>;
+			power-domains =3D <&pd_disp>, <&pd_pci>;
+			power-domain-names =3D "pcie", "pcie_phy";
 			status =3D "disabled";
 		};
 	};
 };
--=20
2.17.1


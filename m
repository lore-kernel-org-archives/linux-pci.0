Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013016.outbound.protection.outlook.com [40.107.162.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D53A3B2FFA;
	Thu, 12 Mar 2026 09:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773307624; cv=fail; b=BskYVAQJzsn5gA5sVOtj9KZzHkVM2Um7GuBcjCkyX1TUJeBqttbr1H21REYp6Kwe/BAdh3uKqv7iJgIlMMEDynczUtXWNdUYDxEQQMgmrhleertgPeLmc1eHeZSYxKUI+u/EbOFJMcCmkP9gYOdtjY7fMLDWRI1exnlPOAgFOZ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773307624; c=relaxed/simple;
	bh=pab6LjgpqnWAsNvJSny4XoepuB4Ej0xFXBcypkm2LuU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YumQTSeVusUO6nNVH+DeuFW2QQS5z+zA8TIUPb+ODAdoTHzL6t2hPmPhvkdGchXQhFkqAy1NI5Yil4wUie8TuHzA/iyMx6EEEMdBw37/jhPUlYWqSC7GoeZ01Vrb1Z8sKJbL+l7Pzhmtcmj0a9NNPhzGiqiszR7KFPoHo6Te/m0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TXlAuXRX; arc=fail smtp.client-ip=40.107.162.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TXlAuXRX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a+NJnuelxWrLXGHU0zZOTfox8FfM2idsXFWJ4kuVp1o7qJihSX/iAo4gNEPDt/7dYjS5ePLmu1+zk14esdDwN6pv/zgzdMZd3ORwW0svh2e3dPoMYVXKfzJoHI66MUaeNCdj4yFpdOVxsID14N2ftEGRwSLAufNs6GHOfLU8ZKoVY9UuPn36qfi0cRJS3TCjqfRNR0ZfyE+eeAc6Z+z3Lv6j29owDt8pw4yYwdCpECzdubu24/w3SpC6Ke3sk3QGHgGL67uvcFGW5DBxShzeAyWHE8dicUpIbL5/ZN9eoJXstHe9EnOMQmIzn02rY52UQxZtogoUQ/LwpxAUQhHe3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tydq+r37F9Bi5Zn0X2hbw4knQ/vP+42P0y1gcAd4XwA=;
 b=HrtsmPxwhhuFDBedKJHUoJJFBeZ49CHqzSfwt2DKtaVdZO5Vf94nSX5lnToXLp/nt5wA91xOSyKSiHxolGIKYyF1j2uwPgg+UQwq2DbFlH8XlF7AhYyRxKdw3HRQ5v0FvEgCGksfmvTlgIDQwUd956UUAVlx0Zm1bIH7f86NWURcGk/uagk8EJJyroKpRWsDHh1mqXCDQONT7CKJtXME7Yr+21nsvOBFSm4KjPvGmejDYrH1u6/Qtz4HS1aIMWq8YdrwsM3jC3Pu5RemfOtfJl58j5orWwlNhtTMhS4ELgeFjpuLacUuqfKtMYFbLNqgxpOJepBvsg7sTGWyv7gVEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tydq+r37F9Bi5Zn0X2hbw4knQ/vP+42P0y1gcAd4XwA=;
 b=TXlAuXRX8RuEugRdTJ/LtCH7WDghlF+xjjGc7Qs+DyX4uns5if2hYC1wXrah6OPNu6bNV9g2ITzo0PVSN2RVuxeCcDhSosGOtKvk9ub/CFTta4XSP57hktfjrfoshm0NetfsSRuj/u9KeDd5mhniWIbZdv/zmWAh3XrRZbxHy51DenyhQjBXz1KzG266BMh8aun3JquQFY8torKUYNzrHhZXjjR8zQjkHwo6BDeIyLtTIt+9FAo09R+RnOufW4rmxww1ezwe8IyN6zC0TnxnUHl+Vgq6UIJ/z3O4YzGj/XLr4ssHyzOCo5QaZm30hFA5pCOlduvGaBL0VotpRJOgbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by GV2PR04MB12318.eurprd04.prod.outlook.com (2603:10a6:150:32b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.15; Thu, 12 Mar
 2026 09:26:57 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%3]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 09:26:55 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	bhelgaas@google.com,
	frank.li@nxp.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v5 5/5] arm64: dts: imx943-evk: Add pcie[0,1] and pcie-ep[0,1] support
Date: Thu, 12 Mar 2026 17:27:45 +0800
Message-Id: <20260312092745.295578-6-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260312092745.295578-1-hongxing.zhu@nxp.com>
References: <20260312092745.295578-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0240.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b1::6) To AS8PR04MB8833.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8833:EE_|GV2PR04MB12318:EE_
X-MS-Office365-Filtering-Correlation-Id: 477b4601-abe8-4e96-58b6-08de8019806a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|376014|7416014|366016|1800799024|56012099003|22082099003|18002099003|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	oQdLAZB6Qy7PsLlkXslpxU2hfcpG2x+AQLzQ5TIMzrFX5IyA95Vj/7OJ1DMZ5foKnS6g8sX3SWyWXkJh1rL02OC+xwwEta5nwNgB86H939dTGBRr5ES1OBKCFFqEQTyg9X7KUMwg4KJn4b6NvZxfjPyXSQ4fvuQbN/xq1ixdMbCOwlnQZFvmeq7kagL92dqCoBcUm3IGkHqg96JYERY2DcWBJ57fIYB0Q0dEJlO0nXFTaLWUCvo6VnlPjoo/2OkhgmQ/TgnrXnDPOtbiUvhAqXPwH4PhqcJvmVm7bhw6YdRpC8qcB0Q0nP375G8pp82rRYv9Yhaoo3cyZkYZFrzpDoDEZo1VTQZJzYBXYcnwbb0tvp0N7nSbWh5UeR0AjF4WHraBlPgamZrvQRtSXQ5D88KAjc3StLE0PkSy0RCEvgkanJsIv+w3/IyK1m7abSDZqjfjCVPt8A2dBO5CM78rZsvw0qLnH0VIEQjjqy+TIEUw9tOGc/pbzqeOTG6yECVpCTvnOPObSJFkgWcvdit0uojc7oli1RHa7HYKAtdR8jOM9rauOCcBxqu8J1+wf7jD4a4OOdJaQmsfiqJdHDJzO0/KrXNbE02PPLqKMy4m0JHFKVjc2kfYJCy+KM1KOQ3vmqm//LouwEmSxrI4EYTKTSi1O4VZhA/Z2Qvjp7dC7bivWLBFGBXCLqpcre8tcO0burS0EoQxiH7HKk9Fc1wOgwbzPhpvBNXg1arWkN8PfVYcwK3F7L5kAC6yXfc6Ri4LCUeE9dGeqVJv+nlYT+Qi11PUNMNnSRyfRXq32tQ+2bUgrNxuteTkayTqXiss7M7K
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(376014)(7416014)(366016)(1800799024)(56012099003)(22082099003)(18002099003)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KhcUCzXpPOh7JBOajhqwQPl1QwNM4zZ/Dky9/SuU4sdzxu6a0WCbzx5ggf2+?=
 =?us-ascii?Q?mT09W8N4ja72lXkMdK1IwYBGCn5zzKG50t108+WHwiFie8z6Tc0vWYPdJnkC?=
 =?us-ascii?Q?U64sOcgF24dY3vwErw0y99h206mH30b4xcNMkRvDrEbhNP1y/Bmom4xia68F?=
 =?us-ascii?Q?YDiXJbISIYcCNPVpgDnwFTiKd6T9NAADxK9awbWkiJBhxJGmURMi1Y5Gazio?=
 =?us-ascii?Q?z0aPytkxF5ityT0RqU/rhMFv5MSIK+KUDQlS7nUnhT2QYIhMK2jJKXeD8Ec5?=
 =?us-ascii?Q?Xd5Zu6K4b1L+jwzNzWXP/TqaNbD4B+jFpnlXMCIcTuFXgg55ocdfJQDwIpvo?=
 =?us-ascii?Q?7NRkEB2Cecw0gNlGUJGI7AUD//w4o8mBr+QVrfBKUoiSGOzhMyEhUmNkYNhJ?=
 =?us-ascii?Q?AybTXt9VZuXWS7wHqPU6wzhMvAtdVFfHpwwvIYWi4OjBmsFK6oMd6JXmSiax?=
 =?us-ascii?Q?pCeCtGNidkbbnnSyy17oMDejoI2HYiyY9n99c5+1ijyVuBxhHN0weRTnjRlh?=
 =?us-ascii?Q?4njGhuXYAdXCX3hgqtSMyDhp0pkwyM06v2pGTf3AHIlMorB8PpDtjT8nZ9Eh?=
 =?us-ascii?Q?YjofLlWdZUYKEFHny4taW4E3c9Ws+A8GZsBcJBslZ8DgMG/m+1fmgXiynwoF?=
 =?us-ascii?Q?V2ZF/tLNnbVN6CKcdbx1KkbYAOQJ4L6XPAyYtVm3alEc0NJN7osqe2rq6CW4?=
 =?us-ascii?Q?kSRehiT2d3e6z//eFaij+a1c9TuwSTc/BzF6bG3D7mJos9zJXQ6nGsePfvu2?=
 =?us-ascii?Q?yudWfcxrq714rumTlcfo96rHkpV0Rvg3i6asnqeOS7CTjF5vLE6FqopCo4HY?=
 =?us-ascii?Q?XFg0e4+XO6YOr2ow+JSzZed6H5OHtpnCap1mcNZtADLaZAs9YVr7kREtwlX9?=
 =?us-ascii?Q?L1zehHpMndAunr6G3CD2S7TYnbPiR/b0zd5U7FNnxainOozYOV10uL+ioiX8?=
 =?us-ascii?Q?rIz5MD3iMBU5ywF0uCxk04+oVj4C04NpysdDxMha2bfYgZMwPjCRlXdpamHa?=
 =?us-ascii?Q?VTeeD8mHeXjrHR4g2PWz1xYDpbCk6Cx2CT8rvikbc3DqZ2UkGe/3Gp2ClWtn?=
 =?us-ascii?Q?Zqe5HCXmf8mW56Zfa0Tdx62Nl93TaTjnYX50kqw5Pz9a+mGiR5uduP3foht3?=
 =?us-ascii?Q?ryKA7UgNWfD6PlV9DombI32RxfoKPbD0UOGj73VB18+M5RGr7LutIhajJJt1?=
 =?us-ascii?Q?6WYRyHRKF6UWFPRlVqtifj5K9I9JMuRuoa4VwkBJhXv3zBur5fSYmiN4+ycI?=
 =?us-ascii?Q?Mh0XCffhgkuOUNT3UGvYcrk4SJ3yZoV1VkVtMtj8S6IiJONAernd5dOYym0M?=
 =?us-ascii?Q?qyIls3gE7UN3fyiPNDt/K+ohXpf9flUXwzf+bk7l+84IGjcBuKyMdaua5Vhb?=
 =?us-ascii?Q?Mr9vxDieckrStMl1d1n1Kf65fP/K69N9uXs3IJw9f2Ug3dNtq3rHLwa+EeU9?=
 =?us-ascii?Q?N4siIjBdBqe5S4H/nJyyuZi2Gjy29PHMhpbMRb4dMsDNlWP4+vpaN/gSrMHG?=
 =?us-ascii?Q?VXZ9AM3Xl9CP94sfH5i06eTjXjlk1hQCnNCmvyKBkYHXWvW4JQy/5Kp22gFp?=
 =?us-ascii?Q?j/S37tR0rolUvS32APB/DKv6ROjj437zz5My9KRKtHudsA1GM76POGuuyIkY?=
 =?us-ascii?Q?THMwQPCkvZwRCxxG+XSGIivDT52D+/YZWx+gKpM/dSfQvhYGWPfYtixj8rpW?=
 =?us-ascii?Q?shl2URppKvzkLF7BFaOoDY7YdN4k38e2SFTdrK65vMED1eGT6ttFeN3BT1YM?=
 =?us-ascii?Q?7Z/Z3iCUGw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 477b4601-abe8-4e96-58b6-08de8019806a
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 09:26:55.3163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZfhJdg0uorP1yVfog2na784pjo5a+7FGifr+9HoDhiwGlkRxyKqk31/tW9dQ4D/Kw7GDhJew7kphxBpaj4HsbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB12318

Add pcie[0,1] and pcie-ep[0,1] support.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 arch/arm64/boot/dts/freescale/Makefile       |  4 +
 arch/arm64/boot/dts/freescale/imx943-evk.dts | 82 ++++++++++++++++++++
 2 files changed, 86 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 25793aa7c0ab..0885e67e0cfa 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -451,6 +451,10 @@ dtb-$(CONFIG_ARCH_MXC) += imx95-19x19-evk-sof.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx95-toradex-smarc-dev.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx95-tqma9596sa-mb-smarc-2.dtb
 
+imx943-evk-pcie0-ep-dtbs += imx943-evk.dtb imx-pcie0-ep.dtbo
+imx943-evk-pcie1-ep-dtbs += imx943-evk.dtb imx-pcie1-ep.dtbo
+dtb-$(CONFIG_ARCH_MXC) += imx943-evk-pcie0-ep.dtb imx943-evk-pcie1-ep.dtb
+
 imx95-15x15-evk-pcie0-ep-dtbs = imx95-15x15-evk.dtb imx-pcie0-ep.dtbo
 dtb-$(CONFIG_ARCH_MXC) += imx95-15x15-evk-pcie0-ep.dtb
 imx95-19x19-evk-pcie0-ep-dtbs += imx95-19x19-evk.dtb imx-pcie0-ep.dtbo
diff --git a/arch/arm64/boot/dts/freescale/imx943-evk.dts b/arch/arm64/boot/dts/freescale/imx943-evk.dts
index c8ceabe3d923..adcb3fa3c9de 100644
--- a/arch/arm64/boot/dts/freescale/imx943-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx943-evk.dts
@@ -50,6 +50,20 @@ chosen {
 		stdout-path = &lpuart1;
 	};
 
+	pcie_ref_clk: clock-pcie-ref {
+		compatible = "gpio-gate-clock";
+		clocks = <&xtal25m>;
+		#clock-cells = <0>;
+		enable-gpios = <&pca9670_i2c3 7 GPIO_ACTIVE_LOW>;
+	};
+
+	xtal25m: clock-xtal25m {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <25000000>;
+		clock-output-names = "xtal_25MHz";
+	};
+
 	dmic: dmic {
 		compatible = "dmic-codec";
 		#sound-dai-cells = <0>;
@@ -71,6 +85,15 @@ reg_m2_pwr: regulator-m2-pwr {
 		startup-delay-us = <5000>;
 	};
 
+	reg_slot_pwr: regulator-slot-pwr {
+		compatible = "regulator-fixed";
+		regulator-name = "PCIe slot-power";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&pcal6416_i2c3_u46 0 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
 	reg_m2_wlan: regulator-wlan {
 		compatible = "regulator-fixed";
 		regulator-name = "WLAN_EN";
@@ -653,6 +676,18 @@ IMX94_PAD_GPIO_IO28__LPI2C6_SCL		0x40000b9e
 		>;
 	};
 
+	pinctrl_pcie0: pcie0grp {
+		fsl,pins = <
+			IMX94_PAD_GPIO_IO20__PCIE1_CLKREQ_B	0x4000031e
+		>;
+	};
+
+	pinctrl_pcie1: pcie1grp {
+		fsl,pins = <
+			IMX94_PAD_GPIO_IO23__PCIE2_CLKREQ_B	0x4000031e
+		>;
+	};
+
 	pinctrl_pdm: pdmgrp {
 		fsl,pins = <
 			IMX94_PAD_PDM_CLK__PDM_CLK			0x31e
@@ -821,6 +856,53 @@ IMX94_PAD_XSPI1_DQS__XSPI1_A_DQS	0x3fe
 	};
 };
 
+&pcie0 {
+	pinctrl-0 = <&pinctrl_pcie0>;
+	pinctrl-names = "default";
+	clocks = <&scmi_clk IMX94_CLK_HSIO>,
+		 <&scmi_clk IMX94_CLK_HSIOPLL>,
+		 <&scmi_clk IMX94_CLK_HSIOPLL_VCO>,
+		 <&scmi_clk IMX94_CLK_HSIOPCIEAUX>,
+		 <&hsio_blk_ctl 0>,
+		 <&pcie_ref_clk>;
+	clock-names = "pcie", "pcie_bus", "pcie_phy", "pcie_aux",
+		      "ref", "extref";
+	reset-gpio = <&pcal6416_i2c3_u46 3 GPIO_ACTIVE_LOW>;
+	vpcie3v3aux-supply = <&reg_m2_wlan>;
+	supports-clkreq;
+	status = "okay";
+};
+
+&pcie0_ep {
+	pinctrl-0 = <&pinctrl_pcie0>;
+	pinctrl-names = "default";
+	vpcie3v3aux-supply = <&reg_m2_wlan>;
+	status = "disabled";
+};
+
+&pcie1 {
+	pinctrl-0 = <&pinctrl_pcie1>;
+	pinctrl-names = "default";
+	clocks = <&scmi_clk IMX94_CLK_HSIO>,
+		 <&scmi_clk IMX94_CLK_HSIOPLL>,
+		 <&scmi_clk IMX94_CLK_HSIOPLL_VCO>,
+		 <&scmi_clk IMX94_CLK_HSIOPCIEAUX>,
+		 <&hsio_blk_ctl 0>,
+		 <&pcie_ref_clk>;
+	clock-names = "pcie", "pcie_bus", "pcie_phy", "pcie_aux",
+		      "ref", "extref";
+	reset-gpio = <&pcal6416_i2c3_u46 1 GPIO_ACTIVE_LOW>;
+	vpcie3v3aux-supply = <&reg_slot_pwr>;
+	status = "okay";
+};
+
+&pcie1_ep {
+	pinctrl-0 = <&pinctrl_pcie1>;
+	pinctrl-names = "default";
+	vpcie3v3aux-supply = <&reg_slot_pwr>;
+	status = "disabled";
+};
+
 &usdhc1 {
 	pinctrl-0 = <&pinctrl_usdhc1>;
 	pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
-- 
2.37.1


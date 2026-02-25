Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013030.outbound.protection.outlook.com [40.107.159.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528963939D6;
	Wed, 25 Feb 2026 10:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772016913; cv=fail; b=IX0mWUqpObtj7U9KUQkaawi/Xa5oHSRbotfAXidh+LYSbiMSR0afCmLy2tkLpnYv+5PuCCp0CKuVV8a0FblOWVF1EwpTUcWTCxQSRBSeCGZVBJ6g8xHQuk8UT5nk6+zWTFBC3DtmP3FwghjSPvi3vxjldGBZCthxPBw0KM9CpgA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772016913; c=relaxed/simple;
	bh=ZDruEd/MKZ4VVvHfQrkn+K+6dovwVnUlvXolnMqigG4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jdRxCmJvGK+Vpxt2s+XvzjG5edvlUIvfZTrvHuv6rERtbxtLpug9U/tmR/TTacZL6UllYDPnbbjKpTmCruPs4+BDBPADicnFVpDJ9WgubvaljXSWqnAaKMf/8xQIHIs+pNqY4LIQLBniL2zLRdSv8JR04fXPOZ2U5I01PD2cX3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gXbBP5dV; arc=fail smtp.client-ip=40.107.159.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gXbBP5dV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UBa1NprGidwBwHVLaK7Z2PIwRbE5zvJzee2cNLlBdGVSZG3q343YoZHnltbT/ZGTvYPSBdXuMI4IYScfVJvIKFeldV6M1y4gFj6qVEVbT5r0iBhT+BjeU/FsTASIUj0sMcYKnFScRTagoDM9YX5sF6UKvhME/9urEvEU3lIzNEuJIqIwUrJ3CFpQpWOh3Fltq8lmWefNa6QuL7liS7HPvI3gMrsbXBQBwifdDc86q86+Qv2DPLhbroGCjBYp9oizf8MTokBvPHck+gFgiySAYLw3qIT+z+odGwhtJavjMeQTF6FJX+wueuGj8UefVFqtKASpsjz+TtJVB3r8QoF8+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VJJphNjDzUi7vgwXnLNPRLGuf0LA4pJcgBbhDE8nsPQ=;
 b=ueYg+6pxIJ85hBcwsOsD/MjqM7yzr5/vggbADKmSI+CYOFXruZPCKlV2a4ycAFT8rRf7MdjJ/7Hvor6FUwS+Yp4eywJB+6EZ1SK3fAnA6EGSy9d867ZfqovycjvQr7MpZ0uQyTK4/RVGb5cVbUN+1ZLhwnnZN0S7FNn+XHEGNBs96evP//fDf2BAK3Kw1PnD/Ytl7gLKNoD1cYl65WTXrgnHHMZ3bt0X4BA9UZZN/BCzqI5E5e+KFFutI3zg95U+H/rcvBUI205dSFPpeLs2thBld8tbUSH/kMf2Ajg4U5hF04EHbB2YhoAJR4NrUD2X+yRXtmJn7YPHf/QKZ3aF4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VJJphNjDzUi7vgwXnLNPRLGuf0LA4pJcgBbhDE8nsPQ=;
 b=gXbBP5dVK2xnai8eHS8NCA78OFL2IQcy+pmEDyA1d/DKlSvYuEFR1QL28eGBrjByGtPfIuGz3M64/hiGO71rB4JB33UBosKpnxAQKKyk9S/6NCmw+eJCuCK4kxWlinDs2oE/wy5GckaqTxoqa1sOypjmNXrPLGpajcuKkkotWTIH+7fW21184RP0xHkxQ9AEQGJ6UIRcAY/pRc9gB7SHYdWGa2e9QFvhZ1LLFImiuaSBUghMQJadTlJQ4YDQX6MrMXOaNWr6FolhpaUaa+Fn3YtGoupF5YOXrIkgYuWEH/08Rp+A8aoJyRkhyToCL72y7qpzk4v1e9GFYHq4yezZ7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by PA1PR04MB12224.eurprd04.prod.outlook.com
 (2603:10a6:102:561::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Wed, 25 Feb
 2026 10:55:09 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%5]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 10:55:09 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: hongxing.zhu@nxp.com,
	l.stach@pengutronix.de,
	Frank.Li@nxp.com,
	bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	s.hauer@pengutronix.de,
	festevam@gmail.com
Cc: imx@lists.linux.dev,
	kernel@pengutronix.de,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V6 09/12] arm64: dts: imx8mp: Add Root Port node and PERST property
Date: Wed, 25 Feb 2026 18:55:20 +0800
Message-Id: <20260225105523.748775-10-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260225105523.748775-1-sherry.sun@nxp.com>
References: <20260225105523.748775-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0104.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b5::12) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|PA1PR04MB12224:EE_
X-MS-Office365-Filtering-Correlation-Id: 605bd2f6-fc95-486c-afb6-08de745c57d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|376014|7416014|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	9FPdS/++FMzIAP9EVvkcXTFPY21chqnc/7QPBwnaOK0RlaQQ5k9NezXeKOwfCfiMWBp8Za6h5fm3GViIPel/IiFdohHVqJ/VqRKQynOsJbmyXPRbGaFvbCJ726Sn0iNSUJmIYRSBb7LNfDO5XCAg1qci3FKvFlSUk9CNm5E56VQY2cQo8V6De4pDygXcMG9iNU9lqhvTCYUYUm6kS1HvMBogcYPnevQqhuxRWryt7A62lnK8VD5nGtxRkxG3p3HQFqrcpf8hbrntZ0bP3dwwlqaEsCYu/2hvrDYmobHkr32ikgozEKElY8kBGmhSr6s+66YsvPZNIIXCan808uH87XEuA64hmPUR9wodPTwY3mbEQCm5tJYasraYLih2EPrZKhVqrGSqehGsdMBRFNIP2pXfMPJVcWlECQ33gFmpUiisvYGDl7BZ1mbKRkKkWfwhGMLgPxFuxwdqoBlExpvAw1mAD4HATFCMbqgESRjvoDs98qrasANH0ZjcSJUYuDxoGMXVMy1s8UUrBf4w7xMc3FYXkmQG1XQZ0d1L/FPrfokZ7SgK00nEK3jngMON061h0KH64ROLSNoRASTrkFaO1zhLnlc7+7L4HhnaqglkJ82lpYftd/swjURpDRwr4v04QWoZrEfY6/p8ECpyQNH0wTgz/Czr/I7g86E7SRXBxyWqTE8ytYrqY41QMFZDWsFZD7YVFG3VODQjAPxWD2oVkEPDZzmenNpV6G/vXMVlx2nuYf+PQY8ygseUUag7/yClL18cqs0UkRwtWjg/hImqjIXnZGMAAgUCAn6Bzb6sXgMhlBbHPyxDHvMvkAFPpWUv
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(376014)(7416014)(52116014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/czrrahxJVeO1LBovQEOQwM9m+48uQZ6kUauISjUEDt6Y0IBNZQV4wtO+lO7?=
 =?us-ascii?Q?f3Tc1LUdEudctYj/fxmlLoyixsprZ8XoMgDTei+yD+Utu1mWRkNIv/YgiWa7?=
 =?us-ascii?Q?JlC55bHOvrJIZ9zov2JCHhU7LQn/mlYPmFpFev9BKEHC8SlToOHV9q9Q1uZp?=
 =?us-ascii?Q?gbQV6dqCoDQTmyL83g4g0JIpiqnufG5Y4mfwHjipUpMmIfXk8cz2Rb+UaA0u?=
 =?us-ascii?Q?gAtLWpJCahsVRXYxPan7RQazjcWGWlxV5Zcj2Q+hvsqbgQ3sDKuWHGMFsRCN?=
 =?us-ascii?Q?y8umBAuoiF2AopOV8ssABlO/s0GfSQ1Y5rGVC2BSzsV4tL9NBIZHqZJIik77?=
 =?us-ascii?Q?/emvj7vY8h1PHz1yc/AxxPPpd8ihlwrAz8ZQJAxUrWayzp0dMCkP79hrPeiB?=
 =?us-ascii?Q?htIMoX7RK4MmwBdUBxoDIxUpa69vJ6ETKI+T/rcYzH8U2SiOkwAYeP2ey0OR?=
 =?us-ascii?Q?9Q05J1NzH3m2v0EiH9FO9HCsEzLitfYBIS9kKVMJAQuI8m/rJJ+qBhZEk02o?=
 =?us-ascii?Q?VVKfiDs4AtnFdAliB0Oa7EZnF0NohQRiiQvyPdx7QMdHyN8wRZSpAvTNIgKg?=
 =?us-ascii?Q?RZE1B20giojcoZsL42kGjuBvxz66AIH0PHj0ZlZXoRHWLTuQd4dM2pqe+OJc?=
 =?us-ascii?Q?2A7LZVe7u3QALXawlRWuZPYxLDfhsT1WZ1K3xcs0iDnYyWIloWED+cnYGg7t?=
 =?us-ascii?Q?XZKuG+md9TKoYDBH6/AHR0+aKg7ekO5iSqwq1shQwP8l10mzQPndYFzU+MQh?=
 =?us-ascii?Q?y/NZmbZe+j31/7edkrIgZXAhVLve6ZrodtoVs9n1Gu7lRllkVLQXiNbsRreU?=
 =?us-ascii?Q?d57Wjcv/UhKPA44XqPiy5BUXTlubDI8iEu83KwaBv2z3ti75GCCNqLuTFfB6?=
 =?us-ascii?Q?7DGSPM+OG+SB/G9xoRZ+oRlqafX5BK8u4NnZcj2HteUH9IOsyA0ev23GvYw5?=
 =?us-ascii?Q?tmOa8r2msaNHOe+GXvCTEWChTxldgKmFrU+RRYLcjfVeq14bZ+/kCkZCEMUX?=
 =?us-ascii?Q?TiYyiBqAdvtsEZXSuf3qoyqtygO/cfvditcRBte5jU6YF53xJbEFNLmEGPBC?=
 =?us-ascii?Q?3lK1OxtbH1hnD1tE52husByZxfz63KBkWx12AYFfdmwP5ltoQfXUhxP31Mkb?=
 =?us-ascii?Q?CGm4uDi5T1Pf/hc9Z8Ct4gKc5fAee+/PeZDfE+rUKMXQq/f35H+NmSW5/rNo?=
 =?us-ascii?Q?LdDMB7Wv6lYEU3DeqYjER8ERhJyQo5lES/dXi40b5KnGM3o55a9r8D0rKzoL?=
 =?us-ascii?Q?YHqASSjA8SN1i6ech6a/TrT4oGusNFxU9APaoOT/hgPSOyebjqiDWjnYTSPu?=
 =?us-ascii?Q?H2c/VqEgeKCt4TsMUuXXF+9OPsaJ8IhS016pV9ne7VCNKV+zyKW++4eCCN9j?=
 =?us-ascii?Q?NvyZZNkrsrtLIImRtRzAk780q31bXpRaqL6UKmuzCYdK/yhpN4HlC7ayfxc8?=
 =?us-ascii?Q?6WEYJFltQbFfd7Z3lCkwj3RMwsDkjmD78b7Bw6Hkh2s119GqVLg2oV2A6vrf?=
 =?us-ascii?Q?HB0T1PU/17XJB8IpBSlLpdFzREWt0cCfeHCzb8red/Rne3XwXr8gyw2W7gDP?=
 =?us-ascii?Q?avPwCxI3ZHdUO95PUjv+iKz3uoSw/8vBhLYGxldbJ1LU8DQ9BBT1F68NGE7E?=
 =?us-ascii?Q?mJ5LuxQ5G5uZMLlaA16Pz3LYzANEqHjdwONTVYc25EkfESwP6GRW/Y0QioNl?=
 =?us-ascii?Q?F6iL3gmCZc33mthd8lggtMxwkMUpzvDN/UCWOItzHDh05VvDXrng+2Z6QOJW?=
 =?us-ascii?Q?J6w0etFMfQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 605bd2f6-fc95-486c-afb6-08de745c57d0
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 10:55:09.4669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ex7iY0o1d9v4c/qdCSjymkYn+0rzvr3HII8bIAhAjOpAbVkNmz0aq+jcqMxt7B+7mRr5lMTCfQQ5xHV0qzAGxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB12224

Since describing the PCIe PERST# property under Host Bridge node is now
deprecated, it is recommended to add it to the Root Port node, so
creating the Root Port node and add the reset-gpios property in Root
Port.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts |  5 +++++
 arch/arm64/boot/dts/freescale/imx8mp.dtsi    | 11 +++++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
index 50850cb6d287..dfcdcc739ec6 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
@@ -769,6 +769,7 @@ &pcie_phy {
 &pcie0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pcie0>;
+	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpio = <&gpio2 7 GPIO_ACTIVE_LOW>;
 	vpcie-supply = <&reg_pcie0>;
 	vpcie3v3aux-supply = <&reg_pcie0>;
@@ -782,6 +783,10 @@ &pcie0_ep {
 	status = "disabled";
 };
 
+&pcie0_port0 {
+	reset-gpios = <&gpio2 7 GPIO_ACTIVE_LOW>;
+};
+
 &pwm1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm1>;
diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index 9b2b3a9bf9e8..f66667735a02 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -2266,6 +2266,17 @@ pcie0: pcie: pcie@33800000 {
 			phys = <&pcie_phy>;
 			phy-names = "pcie-phy";
 			status = "disabled";
+
+			pcie0_port0: pcie@0 {
+				compatible = "pciclass,0604";
+				device_type = "pci";
+				reg = <0x0 0x0 0x0 0x0 0x0>;
+				bus-range = <0x01 0xff>;
+
+				#address-cells = <3>;
+				#size-cells = <2>;
+				ranges;
+			};
 		};
 
 		pcie0_ep: pcie_ep: pcie-ep@33800000 {
-- 
2.37.1


Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010001.outbound.protection.outlook.com [52.101.84.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41AD725DB0D;
	Fri, 13 Feb 2026 04:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770955703; cv=fail; b=PdbieymH7Fr1bU0FsyjHiR7wurv5QrewcPScuA81rqdaz89ShFtJ8XEaTCXH5119K/mB8jVjvcAPgGI7OlwoJzkp8+tvAetQuxQuJ4nZKCtSHTkY2EHn2pyrNgfEyYnd6DepApFYb60iERV10wGbnIzRi6iQJg/1CHX73nejsQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770955703; c=relaxed/simple;
	bh=bsCqGmkv2u1Exe8rVk/RPtpssCoCE9tOWWvSplVk7Co=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=imzJ9Qfj9LUnj6SPFQrxzb35nulhRHc3YgAuiPwohal+mkHkiSEUl9Z48D3D4YGUyAaCVEqqhMUyA5T9q6RgWfafp3qr/i7EJQlVgpWxcXDoVeRwrk/V65fwRtjRHiotD7BOH/tRtP6yWMqCYyBY7myT2ALLvHs4nrtHVD1EI7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=c8wQrZXz; arc=fail smtp.client-ip=52.101.84.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="c8wQrZXz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lNT49GbFpNtCEAjD9tTyxdrP+b/QJfXkQDBR3sU+NUVVB99WcEtGkydKGeYf1XKxBvxYIQ5u4BRJz0X8my8f7TM+76uNDyef233rIInC12nkgqLFZlu94vFafR3EUDgsoF4aObOfGY6h1EQjRJY7TmsG8wRaD5t44/OQ0Xz0nS6DbXkoP7RxNWMOITHLQAj39sMIcH7MmNZD7XeURAQbo38GwWkl7RZSX9lolyJzvkjX8ovmh7CAdLypquMpoODj9Fs5jnh7bKCluRAdF6Jy95n9YIBcJ3UeHTakAGA8NAjapU814ijIV44xlo7EhSzbavJDDFyT3y9EAuAVpH0flA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e87oTYFo6x0wcbv2G/DM3RlOz3RZ3sk7332K9QNWF+A=;
 b=i1QSdyH9UL1nKN15/7SzPwMkZwaDcBEBecGgVozq7uJjoadJo8VfPnxPTNua87wOu2rafmKDcNcq9pxaGJWDHLfeZYv1S7mLxFOPTSCT0LxLSuOPjO+5qvkaDSQl/pLD4kXQ4FZ6Ol+pIJ0FompIB/yJymCXbuzdKqlCDYxyb08rdSNMjU4sXXHc43PuXoZNrA4xDXBjRgpSW0VI9LEkfbZksamyKozFBDL6ei42me/qYzY73EIYnS0fF72BM7ApwzTAEzQAqTnQwyLgywugM9VCo+INxIniX/QHRp0/DFVt4vGNFMDtAtzR7fLneqTcs83A37ZCNCJKdw0jtKC2Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e87oTYFo6x0wcbv2G/DM3RlOz3RZ3sk7332K9QNWF+A=;
 b=c8wQrZXzNYlpkSSQHa9C1JUWCwWo3dTN/K+Cde5xAl32wYhOZrxoxVDVpsFHTuNf5KsS+AHRhXYh1BZ9YYkdCsQ1H6fsMx4rJOzZa19GzvdoPGn3pyv1jPiR+MyT+NddAxpvW2gCZJu6NUAR3avcAQQysxxptAM1f8R/bth4TMzSWR3sSmA4I6JcmmeRlln6ZPG1eXvoAkYeMX+hGB4M0+92mH1fk/ODWGFX66fPve4GcZ4H2P0emkVxiO12z3S2WUU28LOJTPuMqIgD4/kIEszksuIPtqxh1bBJSjJ4v3mtnxGnpQ2xhQeDhY/ZROpVjRroq2eYofS578h4TG6Tdg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by DU4PR04MB11900.eurprd04.prod.outlook.com
 (2603:10a6:10:61a::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Fri, 13 Feb
 2026 04:08:19 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%5]) with mapi id 15.20.9611.008; Fri, 13 Feb 2026
 04:08:19 +0000
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
Subject: [PATCH V5 05/12] arm: dts: imx6qdl: Add Root Port node and PERST property
Date: Fri, 13 Feb 2026 12:08:45 +0800
Message-Id: <20260213040852.3340547-6-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260213040852.3340547-1-sherry.sun@nxp.com>
References: <20260213040852.3340547-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0206.apcprd06.prod.outlook.com
 (2603:1096:4:68::14) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|DU4PR04MB11900:EE_
X-MS-Office365-Filtering-Correlation-Id: 642cf79c-cd42-4c8f-7080-08de6ab58590
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|376014|52116014|7416014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gI1WcXh9CZL/3JKIKMwT1C9RatISeXQ934QQqda6hyEdH+IjAsck74vhS4OI?=
 =?us-ascii?Q?uuwxdrk6MCpEVQ+8+OaY0uOdO1efvjkSJLocmkpM30EI/9X0KJ0YJ4w2yNV/?=
 =?us-ascii?Q?bxsS7fXaeg7/HYLIPrblTH1y1p34FdPCKjQMZzt+0+54tZgpOSPSEigAX+B7?=
 =?us-ascii?Q?JVJ2CYypjzPKS9GZHzNOhV6YFeI08qpogLQtn1UviW+ZSLy/61GbImTe9oyj?=
 =?us-ascii?Q?wQvoyHR7VoRYftreEQFwzn48fVckJ7Gs71Fhxi1jEH0822WILl8Gka9up3Gr?=
 =?us-ascii?Q?uYrWq/AKVIdM2YPG3lSCywIlBb38unz7lyQjvdq8zA/XxEeFZ3l+eZJwaU9B?=
 =?us-ascii?Q?NGNrxuNk7U0io1O4utboMbJ6YgHy7mdeBNuzTuorAoABLncTmosi2eof+HF+?=
 =?us-ascii?Q?D5wuuVqKQriL933kbDiF/kvIyAyhpTDd5fHZpngNDs8Ql4T/cORpb83Ka3lF?=
 =?us-ascii?Q?4tPu41o5k727CKgT5k5CDT4yiBjg70Lq2DSZmdVxgRnzfReVnEqzItEFegSs?=
 =?us-ascii?Q?Hr2m7MjUmTjURGYEqSdBOWuhjKevxqNnoWdECb/CuqZbmchTMmvv0afwonGE?=
 =?us-ascii?Q?3i1qvy3+PunPZVDa+gnijXOc90MRbjVpeYulhY9z8Dm6emVKyXI8Y88Yzvsr?=
 =?us-ascii?Q?RebyLrFmTnVeSundZ55CU0JbgFDPMham1/QaiVCq9u1iPn+PR0xWE4eRkA1d?=
 =?us-ascii?Q?ktwq9+aRHBnNG2j9C7IbsVgA40up1lWyScrvmkMzpxhjbHjlwfOi18ihU5xM?=
 =?us-ascii?Q?GiWRRceIJG4iqlloAVXV52tsC0njoqCAyPw87ctMzG48elZhgWGUC4ZwXcgH?=
 =?us-ascii?Q?txW8lIROK/MQzBhF9pelyxSfdajL76g1X2TphtZU/GHYjpgi15U40gFaMYNn?=
 =?us-ascii?Q?hc7IBpxexsrIp35bb37z2msZzFDAX+hYBAgPedE86KeYaHnS4koJx1Ijoyuf?=
 =?us-ascii?Q?fifWbZdIx1sTh8kCgP+75ZdT85divp19Vk6pOzQ5+LFOG23V278KmZCIeoG/?=
 =?us-ascii?Q?MDeBEqlijtjdPg4lEJKW/vvp+iIMor2a5wsW8nWRJKNTTHWqGOVggg9BJwGG?=
 =?us-ascii?Q?gkee0nfEcdAMZPf2yl3h4qWdQ8hhFkXJ+sFri+Oq9zECyiccEtJSbkLUNFXM?=
 =?us-ascii?Q?6clEenHQsnHBOYjosIw/XJAl80JTelT95jhGvtz+ko1Iy4JnagOPLBXiwxwv?=
 =?us-ascii?Q?658MTtFs5KSaeY0my0M/AFztEv3ai5ie9oSOSjLCGBpTp92KC0xOyI2frFQ6?=
 =?us-ascii?Q?hNa88zDDWsj3ELHhNERWj3lLXNUw6h7iAdhNu969lJQgxrfyY7pDWJDJFtnK?=
 =?us-ascii?Q?fnPiq1vtvvuWGlX7TZhpsn7PO7aI1jLJBGeTZGO3m5e5uOdKj1b6EYPRoX3k?=
 =?us-ascii?Q?mC1TnLuKbyKS5VPQp/7GNgyqEIq+8XChdAUsSPk69dqi3x4t+1XadZz21Dnp?=
 =?us-ascii?Q?zC10aQJcG0w0C8S/qlBBNvCiLXObbpDuIqkBIPI8RwiuS12VqaYn4wUOtJCJ?=
 =?us-ascii?Q?10orYQcwr3TcR6OaDFy2XA3/u+Udgg9ZGuLCN2xyI1VosC1HyFjmFWtxlV2Z?=
 =?us-ascii?Q?GWUOPmJuYR3U2/K3sw4URvTTctLmF+JI65n0vIg3uz4oRb4X91uibXeV5aJu?=
 =?us-ascii?Q?s50LOXz3n83PftRGhxfJX9rCIHc0HXitso7OPv7WhjEb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(376014)(52116014)(7416014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QoqUpoWfdsPP8Cj2z1IRMaQ/EEP3HJLCyv2F156hke68WIIksKE2DYlFpkJ4?=
 =?us-ascii?Q?dLOWKMkUzWsco3yYZV5KoBSw9GFONIVMxRM386W93IS/mBZwS617yXaTy5/n?=
 =?us-ascii?Q?Mxzcy8V4x1AAt7sbRYFCN9cjo3N8yTE8lVlBziRMPoE8Iy7lF3dR/LKRjCqM?=
 =?us-ascii?Q?G5I/GAJ0khBKS7Ty5KFeyzk1aRMPNlRRZIvKYv0klVjoHXuXfm2x1TaOpZPL?=
 =?us-ascii?Q?Vy8snI3Sh44crYuf3puLqd4awL4XDmUlr0OFHAtQdZQEzw3iQA+6uRErUDnI?=
 =?us-ascii?Q?vdS09hUr9sVBVtRQCXF88fvuMQiMzgyAB3BslYmAPqekfHn7yKIKjx59GHpG?=
 =?us-ascii?Q?ZPJlRmMCOUO1uy+dIeJG0XNg6U9EhlYtKT7CgPPUscBC37FymCdNzoKsT3y9?=
 =?us-ascii?Q?U5BeBlH20jp35A1wo4LjPjhb9w5rr59BZlfdKbMZyO3LWZ7Mhy4nMUlXTabE?=
 =?us-ascii?Q?fxtgRCvScSzsoz2cbVbbYWjwHJrddxNc3sSIFe8ZZo8rqSCgmHLkzjFSEsiv?=
 =?us-ascii?Q?nlugYo6HduyDb2Q8YYAlqAKE8iJhpaQ5bX7z2WAIefDDkuUnMujFkGfmNnoa?=
 =?us-ascii?Q?afeYbMOPqeF6WN/e7oDQKuUvoE5Cmgg1wHT8OPgLuvaDliVIS7I3ILwO9eDz?=
 =?us-ascii?Q?iNmmy1kXqQHMkF3DY8OUJ4sLBGxwVw+XhDkJhA8TXrVLdWkwaTAiMMwhzWj4?=
 =?us-ascii?Q?x1wshW6G2h9htu5xUiFlBVsQR72jzHMH9OnG8wN69GdYAjJP39sornQKJnS8?=
 =?us-ascii?Q?Hly0LsB+u6BLf2n9q0CoQgEjlFeOvCXNxcgy4C0rKOgjoRR5kTorF4unIfpL?=
 =?us-ascii?Q?rkvnIGAbVFTgzH8f0tF/8kNdME2tYlRc0XonDqE3eHJ/wGsa61dYSvgZ6qhd?=
 =?us-ascii?Q?/wF1/NqKBR2mQTgYLwn2uEiF5b55ri3GhT8m39dx1gk9iQ8gYmzaruLKTFvX?=
 =?us-ascii?Q?bReq3tD1UlxxF6Kd1275hURoE4z8/Mo95vL6hKQko3MfE/k2+0SY2BoyMlui?=
 =?us-ascii?Q?cX6lekkYZajdmZBtEdeP8lhtLJxGKoIGIZ03rlgS8/Z1A8xH/kf7U4h3kDZZ?=
 =?us-ascii?Q?ecjeX/yI8NxdjxQi8V2lL3t7+dJZgRhjwtH5ZWMWoqiwlBdH26+SaROT1wpJ?=
 =?us-ascii?Q?bIvsmYP3ktsPZgc10GBcis6Ra1qrTHoUYhoAVZqGIHxlfKl2Zy3gWA6yAXEC?=
 =?us-ascii?Q?BAQyJX8IiIDebbr9cXwPbQ778e/YO8Or9CzL8CxglXTofFBKxZ9cwZXMnj+X?=
 =?us-ascii?Q?v5LzLH2pAbHr6u+07/lxskv8BjlECgSFYXn1tEI/ENiNqj6KLnGmmlLkJx/Z?=
 =?us-ascii?Q?dFJTbNE8kJoU6hrRtLxwQfiG/BBKsHCgOlmgUm4v3p5QAh1HaCT4jScIhHn7?=
 =?us-ascii?Q?OMQi1qm39C6zmDBdDoAEp46DBwlcmo0XsgQ7TYDcDHCZjQh8zgoE50Me530F?=
 =?us-ascii?Q?IN67PAxiSXxurSWVtmPw1J1BVDddru/7SlDn2FHnkCqXH3tUk4nI40+TT5Ln?=
 =?us-ascii?Q?RJzHZ9ENuXkWaySVo5C1AaJYrG7hJmmUo0Hbg8w+v0PYhEX1rkCJ/I+/+LEo?=
 =?us-ascii?Q?WxWidbwEPgrCHkX/MlErGq4GTlCiWDtWzA0EWtSkEDaekwNwNDOSWgUFP6IQ?=
 =?us-ascii?Q?0iD6YogzKL0I3DJvk7W/y6grb233J89EPimeDwIH/Th9dpJnBjNAsSqq0hmF?=
 =?us-ascii?Q?JWOcKAYWz0ypWul7xtRgzUzlG7mbsDKfTBR1cwXyZcdeR+TGNMmjeChUmg/M?=
 =?us-ascii?Q?qFcglEjh+g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 642cf79c-cd42-4c8f-7080-08de6ab58590
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 04:08:19.6382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CXpDTOsU9ikbyeByJzFnlK2HXbJWRXw4DlobjY+zAW9Q6frup+swAGWBkRKcxwO3oJxVEfhn6TK8UKUSaRtjww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11900

Since describing the PCIe PERST# property under Host Bridge node is now
deprecated, it is recommended to add it to the Root Port node, so
creating the Root Port node and add the reset-gpios property in Root
Port.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi |  5 +++++
 arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi         | 11 +++++++++++
 arch/arm/boot/dts/nxp/imx/imx6qp-sabreauto.dts |  5 +++++
 3 files changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi
index ba29720e3f72..fe9046c03ddd 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi
@@ -754,11 +754,16 @@ lvds0_out: endpoint {
 &pcie {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pcie>;
+	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpio = <&gpio7 12 GPIO_ACTIVE_LOW>;
 	vpcie-supply = <&reg_pcie>;
 	status = "okay";
 };
 
+&pcie_port0 {
+	reset-gpios = <&gpio7 12 GPIO_ACTIVE_LOW>;
+};
+
 &pwm1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm1>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi
index 76e6043e1f91..eeb376193398 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi
@@ -289,6 +289,17 @@ pcie: pcie@1ffc000 {
 				 <&clks IMX6QDL_CLK_PCIE_REF_125M>;
 			clock-names = "pcie", "pcie_bus", "pcie_phy";
 			status = "disabled";
+
+			pcie_port0: pcie@0 {
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
 
 		aips1: bus@2000000 { /* AIPS1 */
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qp-sabreauto.dts b/arch/arm/boot/dts/nxp/imx/imx6qp-sabreauto.dts
index c5b220aeaefd..6b12cab7175f 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qp-sabreauto.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6qp-sabreauto.dts
@@ -45,10 +45,15 @@ MX6QDL_PAD_GPIO_6__ENET_IRQ		0x000b1
 };
 
 &pcie {
+	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpio = <&max7310_c 5 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
 
+&pcie_port0 {
+	reset-gpios = <&max7310_c 5 GPIO_ACTIVE_LOW>;
+};
+
 &sata {
 	status = "okay";
 };
-- 
2.37.1


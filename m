Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013006.outbound.protection.outlook.com [40.107.162.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387882ED87C;
	Tue,  3 Feb 2026 01:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770083774; cv=fail; b=DDT0eb3y1xay3YoTpk3gWZKfCj/fi3qyu9YRz3R67jBm6x/Stb3lmhBLeMmttKcgIiDcfoU8p6ljrSquvcZcnWUN8qRB+v8gGkH1wtYk2xxhAlt97uYd1VYXW8RsDrtASGH6+ok6kslGmMU22AeuV6eDliRhBzfr3VXRmb1PsI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770083774; c=relaxed/simple;
	bh=JzAh4R/6Uc+iZaymM5PvLQQ9CaVnvghTAw3BGlqR0xw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FMOMx/ews5RDg9AyyYnd5I7l5/RMkF86cPUbm4JhKLlDEUbYUTlWcjQnEdNXxIQKZUFLLresyU6uYCndecxNYNrn26efxmydel3tI5TzRGl9d4koWksyBXIex27Gmmt/7WfpzQsFguwoULQcsTk23Azx1lUd4Zv8bCj/4qIfox8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OBfiFD/d; arc=fail smtp.client-ip=40.107.162.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OBfiFD/d"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zMxVDSQCdONDAl45vlwJruGGCNi1sETKAXF/S9w/w7gTuswEqXMRruHNEDp5SZSHUVVSNEouRLFzwtV6eN7CsjftRjFNgobms/IIgelbTqhYrrEDLVMqKORpSfUEgkDj47/5JpOLyXF3i6rLIR+Fsm3B7+DVTdltO3ojAcvxfke6x6ykyAOTGz6nd2TXbKZmtUaXoItmtV31ooBy3ej2Yf6YXfljkfVQsmTFXFEk4QG9/Yg5tnSKdpWKCS72eNEaEfub1J5WpXw0jrMUmkWSoCwqztfsfqHO+IHlU6zj1h2IKf5odg+DDnxrWrcO6WsY6VXUbfKLSd6M6NiLhpAVLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f27SUcPc/7GNnkQnoPRzUdp6Y0/1ifunguGbldvZAMc=;
 b=XxgPqhQ2f4HdMcYg0Ym3LIvURpFl6gRy+MbE/m4dGkFYMfmwUWngg8AUDQALYYPXsPH6elzTRPKH998dGY14hORTBUFAnt717ZR1KzlolGKaegVWMcH/EstuGQovSgby70h4V58Gui/qEwrAEe5+IK8Gx/XVjTVdaxC03ZwniixgmlOqDxi0yypYmc0XG8ki+MNUVw7GVm+n9LlQ3k7Qtj5sOIG4lUiBJMArG24wTA8QPaqWbHxoYAswD2zfdt9AASbc0psWQXqlNa8gvs6uDluZ6bsbdgW7WGHh5RiAlKJt0busUA4/yzBTKTEkgcwTxjyuosdGZrqLouztqOSdkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f27SUcPc/7GNnkQnoPRzUdp6Y0/1ifunguGbldvZAMc=;
 b=OBfiFD/dixsjLuJ5MPMPnfiAkNrdHUTt8Egwy7Ot9TrpQrCCTG054ahu4hUi/7DJVMwrgi+SlRHtSFlsqYPfopk3VzqhVmYBMbcJ8rpi2jJQxVXVEIVbz7SSWvVj4smBgh6t9T6Ad6Vuai1ojjOgPXSK5RZNnn0mb3r9ytWvl/p5reOdL4fBfrJW9/ho8vxoU+ZGaeFxjF8XS0rHZCj2h7WsHve0DcnkflZr3LT9Q5YnaC4xL58e1URtBlJ4F/w67wavXOd1drO2aLEjdSmeiOdNp/Uz8RvCN/bomJR/8aaH2SfIh1v5mNBv+XrhXcIA2kzbPsQ2FCNgc+6QhN9ZFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by GVXPR04MB10301.eurprd04.prod.outlook.com
 (2603:10a6:150:1dd::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 01:56:10 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::2943:c36f:6a8c:81f7]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::2943:c36f:6a8c:81f7%5]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 01:56:10 +0000
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
Subject: [PATCH V3 09/10] arm64: dts: imx8dxl/qm/qxp: Add Root Port node and PERST property
Date: Tue,  3 Feb 2026 09:56:13 +0800
Message-Id: <20260203015614.2957479-10-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260203015614.2957479-1-sherry.sun@nxp.com>
References: <20260203015614.2957479-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0125.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::29) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|GVXPR04MB10301:EE_
X-MS-Office365-Filtering-Correlation-Id: 87250cd1-364b-4027-75a2-08de62c76727
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|7416014|52116014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8NaaQtLUvrXFqvsESiYiE9A2ZWM4+JCGH7ptmE1FSzs5dsKfS8liyElatSkd?=
 =?us-ascii?Q?+W35cklL8kIxf56W8E9BVCqBZK4ycEdoRK+MQpaD0tvrlUE5EcOUpOI+6+cH?=
 =?us-ascii?Q?l/3WMLjH61Ybaq+Fv63Zb6DUtkbHW+5/TydW9Lnl1XstBcEpeOBUVe55NJNC?=
 =?us-ascii?Q?6neF+K+HRiIf0Z2e68vy5AOwDD3OX2PV2I4DpRrzjwxBAeuTydSkNntxGupi?=
 =?us-ascii?Q?ghizOHh1OjOFMPIItoy8l/NnPcN1amurqgwy+gqgkG78TGrHzQroy0bbecEE?=
 =?us-ascii?Q?j4WkJsVaUOlAEJzZBA9cHIjEbKykX0aUlfDnFUQRL2L6evxmStsXAap+r4fw?=
 =?us-ascii?Q?9chXSsEzh6Tfsdqhddky+LJ37sjhtdDExJveFw0/W/JwhrdqBl8hVE4osKk2?=
 =?us-ascii?Q?eUDBvmr6vz5kyoOmG6tqP63G/bue8EEOzeocHYa8treZUPLSwLOmH+Bw5HgF?=
 =?us-ascii?Q?8BGMW7jD0Qz9w2rFUkGR1d/PSpDGRafDNEHlf8EZIs13N+nI53NlmQpZMBDd?=
 =?us-ascii?Q?mpC2Hs5JIS00S6loanmUljGp0CA8Wa2FQvrk+Qfg8JiVp0W/eDRlxdx/M+Zl?=
 =?us-ascii?Q?srPREx2UZZNfmK167kU3cArphidb0ck0YJ1Mc5EAt6Ksx0+UWmd5oGUlK/RH?=
 =?us-ascii?Q?0mDnH5tILJyzq37fhlxv4S1W0QDQ9VvcAPzXFAHaM40DZcczhUG2xgkpxtKL?=
 =?us-ascii?Q?NTpBnA9ycUupM8LkO+C5opFsblPo/q+rnggqyTLuavelaTWNEJRn5txkAO4Z?=
 =?us-ascii?Q?WtesUO2z5sHwMrS/k5gLLX+6EixCPzBAhvxKp8lcGyPTJrVMOT5a2B90dYcG?=
 =?us-ascii?Q?0pdmemeK4r1FOYBf9E6XtUj9AJDpV/Af6vPbytit9FLVX+wP8GC57sv7fHON?=
 =?us-ascii?Q?p6iv8zoYSzK35hIS42JwK2geFOFQnZ8aoeTnK/le2zWJb+92a86yt/Rlzx0H?=
 =?us-ascii?Q?xnwCK5EOqD+COdyxOlYEou2KM/czJSOhkoqkW4OypqFvasBqBfSXuZzAPpdL?=
 =?us-ascii?Q?9Sust+6BEDhvrsM9uXkUQFpia5e1J6WKLuVosFdUWCXGuBWQe5TOoTw/1HOB?=
 =?us-ascii?Q?X6uBuAr4ZsnQDBlYanfgLmMa9faOnmAdyVVdF1Wfz41E1Umya0ETSrBO7uwb?=
 =?us-ascii?Q?V9/U+A1HI7WoEixTd8EvXg6KsS+jIh1czJrUNMTGJQPiIKpbNH5mgcI7lOAu?=
 =?us-ascii?Q?DakJb6HszPliLWOoOPfI7On+vuCdKUc5wB6Kzolbxa0wQTwmPfxRhhkPnxAt?=
 =?us-ascii?Q?3VxoqjJhE+uqhMDP7EttBqXES9l/U0SCCTt4p2M4u/AYJKTrXNV1Tkqi8CGz?=
 =?us-ascii?Q?MQKxoz5Fr+kDcgSs+2Sa1solGJwWDmj7p1fjM+bqnn6ye4xncpAGaW66bZkV?=
 =?us-ascii?Q?pdYCiCxsj/yktlGZxJVtt/j2K19sr0Hf42N5798fIXZ6uIavwdlKPub3xmxn?=
 =?us-ascii?Q?ern2IfZhGpNLfyjLhl1AuVpy6Qq50v0y5rTXfWShyX8LPY3dYUDcszLyCQhc?=
 =?us-ascii?Q?RrMVpWSGU2OYDy0C6j+GjTuH+1cUN+P4sbqisYPq7L7f65x+xi6M25sZS28x?=
 =?us-ascii?Q?qN11Xc9+eW4+95aJY2BPtPHwz0/JpnxOGHvtqs/j98RAgc6Nq7FXPoHkVdw8?=
 =?us-ascii?Q?MFETio1thpz7Hmv7ZQTdUCUbaDBdwKnP42vg2amlwsen?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6gXWgE2oMf3+vSfd+2E7blU7OCKvJ0fbFhXGCa5IDAzGKJlNW5DJ4MsvGraA?=
 =?us-ascii?Q?8WY6TXDwPbvuVW6fjkPv1qVK8sS1nwSlanjDhqJUu8YANYbxip3JU9Oury/e?=
 =?us-ascii?Q?aD+sv/I+Mass/6Wmf7st4so4hjpCcPxCpoD7/UBbX11USW3dwQ8WSLkua+sQ?=
 =?us-ascii?Q?4uzu2epPooC8gQ4XymelLvno04VgJ1l/hzwwvbLAbA0NGgLJXSf8tK4F2Js6?=
 =?us-ascii?Q?pWmfy17oCsDkxH9uJW75JT6gMVmaTtzDYaRXZU0C/32moARy5N5ig7aC+zSV?=
 =?us-ascii?Q?2srWXD8BXKd2Rrqd0yAeJDGXgMWzhahpjQry/cGFgF0+64GbP7lZUcUxFbMu?=
 =?us-ascii?Q?JkNBhJyiK0wxz1WAF8si+XrGYirIFw1mg/AxVDpgE5IsnpCsZfqnTiUcaBVV?=
 =?us-ascii?Q?HN3x5THkDtbgs/fNRgHWz+zv+luyOjvgMhFrhBrqitpU90PAhAH+U0JGDRN9?=
 =?us-ascii?Q?hYBnA4ofNqKf03ngsePnsyeCyQSQTj5muh/nhXQ4j9OHDHS5LHkD8IYbgZ5D?=
 =?us-ascii?Q?j8VNfmM5YnO8NA/E7JWk1A/EQEIFp+zcuPhLlJHbwIHkvC/1H9XYvOywOqzO?=
 =?us-ascii?Q?d71Pd0DN4eMwVWBjSYBEdm5FdlZmNgDVWmP1vO3HfgM6vq8EykRd6g4L7Y/j?=
 =?us-ascii?Q?IBXGDMctr17pnDg3eSrZLYundk7BQhjL0c0rokx/qCm3MRaLvIralatnUSw4?=
 =?us-ascii?Q?/K49Sy2fqVR7mA0H6iMkV7fR0LZ+dUCzMuyPQ+MKjjb8gXfv6BJXDDv/VRnx?=
 =?us-ascii?Q?N3tCA7+LgR6u8yA6fKh3GvfhYcFY1eQYrFvmBkx4+rVUtLIs3O+oWUjbH9Fb?=
 =?us-ascii?Q?nSrP4air1jLNg/RQHkJKDooT3A/kPW2C8iiSQAJQcB/OZZ4LqrJ9nYxhBEDU?=
 =?us-ascii?Q?6Iu1VhwJMCsQdXiF9ZXuvGdXLuW7ghWCpVT6Sq1P6ktQVS9Q/jZJxJ1rCUT4?=
 =?us-ascii?Q?Uy8q5IFc4NWXCp9LdiWasA/sUkHTndAPGz3YSSIsrzFiAIf1cntYK2AqWNHq?=
 =?us-ascii?Q?8U9GgmZRtFY2kuTYbmbPrRZzX+bvO7wmyaRZruFg3K2GSvnCbaV79ivZS+nI?=
 =?us-ascii?Q?hZbpizxyHtaCc6zfhs0j1kS8lIAy3m1felv1s18n0o0fm/zvgNT4szUvDdR9?=
 =?us-ascii?Q?VLRN4Pzc3pZB7w8OwxAj7bgQdx7QwMBeRKa1pSPpEqbeZ4DQoaWdMbtwBpN8?=
 =?us-ascii?Q?nhU9e6p0PFb6l19IkxLHS/JDM9ltP6yew2DSSGVsVPXSqTHNfFfbvbIugd0k?=
 =?us-ascii?Q?XKWsjjNUmYc8295QbNRvPhK3/XFH4+0qkOzT35S/50wa6OH6m6aupv/fHutO?=
 =?us-ascii?Q?c8wMJNgbSNpBH21lYcJvJjh/sxVAvtEF0cogYgsjtcgCSwn0ftdZtKewss99?=
 =?us-ascii?Q?iWXkAWGnqI83KF1vbyZ+9ec2pbR026/MKB56QdL3RqhTZgxrjUf2da8jVdYb?=
 =?us-ascii?Q?zcfaPKdlC4+Jd0VYg9Biin/HrqFGerFia+doengZswmzJRKDDWZa73jV1PLT?=
 =?us-ascii?Q?aawPQ+9b2Uhh2qUAebj9ElXhsuQtIvRV5rOAzjdMUnhM0pKGFXlLO6kEvtyT?=
 =?us-ascii?Q?Kcl4d6LxPvRzkVDKzkG8foSU2tOZeGZA0R3ZbOKQbK5DctesDmJFzRZzwb5Y?=
 =?us-ascii?Q?TnhJLw7upTRWh73/+TisqX9gInp4z6zvX9NJ8ikVnIC65fn3o/WcsOHdb0wt?=
 =?us-ascii?Q?PYm6kDCVeFZDsuWtrvPsJPdcnNjkXvowNRL5vcbykRxPolKUjkypq1tek2sx?=
 =?us-ascii?Q?x7RNfsk1kA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87250cd1-364b-4027-75a2-08de62c76727
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 01:56:10.2597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1aMcMFxEs9lw3RmBPvA9lh3FZIPe3KAWZMn7zXk3XGqYKAoQAuaKejc3Has9FNpUpXTKhLB4pO9TGhIVpXLRGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10301

Since describing the PCIe PERST# property under Host Bridge node is now
deprecated, it is recommended to add it to the Root Port node, so
creating the Root Port node and add the reset-gpios property in Root
Port.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 .../boot/dts/freescale/imx8-ss-hsio.dtsi      | 11 ++++++++++
 arch/arm64/boot/dts/freescale/imx8dxl-evk.dts |  5 +++++
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts  | 10 +++++++++
 .../boot/dts/freescale/imx8qm-ss-hsio.dtsi    | 22 +++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts |  5 +++++
 5 files changed, 53 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-hsio.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-hsio.dtsi
index 469de8b536b5..009990b2e559 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-hsio.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-hsio.dtsi
@@ -78,6 +78,17 @@ pcieb: pcie@5f010000 {
 		power-domains = <&pd IMX_SC_R_PCIE_B>;
 		fsl,max-link-speed = <3>;
 		status = "disabled";
+
+		pcieb_port0: pcie@0 {
+			compatible = "pciclass,0604";
+			device_type = "pci";
+			reg = <0x0 0x0 0x0 0x0 0x0>;
+			bus-range = <0x01 0xff>;
+
+			#address-cells = <3>;
+			#size-cells = <2>;
+			ranges;
+		};
 	};
 
 	pcieb_ep: pcie-ep@5f010000 {
diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
index 5c68d33e19f2..8f2c2bd00cde 100644
--- a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
@@ -651,6 +651,7 @@ &pcie0 {
 	phy-names = "pcie-phy";
 	pinctrl-0 = <&pinctrl_pcieb>;
 	pinctrl-names = "default";
+	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpio = <&lsio_gpio4 0 GPIO_ACTIVE_LOW>;
 	vpcie-supply = <&reg_pcieb>;
 	vpcie3v3aux-supply = <&reg_pcieb>;
@@ -667,6 +668,10 @@ &pcie0_ep {
 	status = "disabled";
 };
 
+&pcieb_port0 {
+	reset-gpios = <&lsio_gpio4 0 GPIO_ACTIVE_LOW>;
+};
+
 &sai0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_sai0>;
diff --git a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
index dadc136aec6e..02f7589bd860 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
@@ -802,6 +802,7 @@ &pciea {
 	phy-names = "pcie-phy";
 	pinctrl-0 = <&pinctrl_pciea>;
 	pinctrl-names = "default";
+	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpio = <&lsio_gpio4 29 GPIO_ACTIVE_LOW>;
 	vpcie-supply = <&reg_pciea>;
 	vpcie3v3aux-supply = <&reg_pciea>;
@@ -809,15 +810,24 @@ &pciea {
 	status = "okay";
 };
 
+&pciea_port0 {
+	reset-gpios = <&lsio_gpio4 29 GPIO_ACTIVE_LOW>;
+};
+
 &pcieb {
 	phys = <&hsio_phy 1 PHY_TYPE_PCIE 1>;
 	phy-names = "pcie-phy";
 	pinctrl-0 = <&pinctrl_pcieb>;
 	pinctrl-names = "default";
+	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpio = <&lsio_gpio5 0 GPIO_ACTIVE_LOW>;
 	status = "disabled";
 };
 
+&pcieb_port0 {
+	reset-gpios = <&lsio_gpio5 0 GPIO_ACTIVE_LOW>;
+};
+
 &qm_pwm_lvds0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm_lvds0>;
diff --git a/arch/arm64/boot/dts/freescale/imx8qm-ss-hsio.dtsi b/arch/arm64/boot/dts/freescale/imx8qm-ss-hsio.dtsi
index bd6e0aa27efe..48c29c2cfe8b 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-ss-hsio.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qm-ss-hsio.dtsi
@@ -40,6 +40,17 @@ pcie0: pciea: pcie@5f000000 {
 		power-domains = <&pd IMX_SC_R_PCIE_A>;
 		fsl,max-link-speed = <3>;
 		status = "disabled";
+
+		pciea_port0: pcie@0 {
+			compatible = "pciclass,0604";
+			device_type = "pci";
+			reg = <0x0 0x0 0x0 0x0 0x0>;
+			bus-range = <0x01 0xff>;
+
+			#address-cells = <3>;
+			#size-cells = <2>;
+			ranges;
+		};
 	};
 
 	pcie0_ep: pciea_ep: pcie-ep@5f000000 {
@@ -90,6 +101,17 @@ pcie1: pcieb: pcie@5f010000 {
 		power-domains = <&pd IMX_SC_R_PCIE_B>;
 		fsl,max-link-speed = <3>;
 		status = "disabled";
+
+		pcieb_port0: pcie@0 {
+			compatible = "pciclass,0604";
+			device_type = "pci";
+			reg = <0x0 0x0 0x0 0x0 0x0>;
+			bus-range = <0x01 0xff>;
+
+			#address-cells = <3>;
+			#size-cells = <2>;
+			ranges;
+		};
 	};
 
 	sata: sata@5f020000 {
diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
index 40a0bc9f4e84..cd127d0a0a75 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
@@ -722,6 +722,7 @@ &pcie0 {
 	phy-names = "pcie-phy";
 	pinctrl-0 = <&pinctrl_pcieb>;
 	pinctrl-names = "default";
+	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpios = <&lsio_gpio4 0 GPIO_ACTIVE_LOW>;
 	vpcie-supply = <&reg_pcieb>;
 	vpcie3v3aux-supply = <&reg_pcieb>;
@@ -738,6 +739,10 @@ &pcie0_ep {
 	status = "disabled";
 };
 
+&pcieb_port0 {
+	reset-gpios = <&lsio_gpio4 0 GPIO_ACTIVE_LOW>;
+};
+
 &scu_key {
 	status = "okay";
 };
-- 
2.37.1


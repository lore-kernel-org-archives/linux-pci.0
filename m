Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011070.outbound.protection.outlook.com [52.101.70.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCC53DDDC2;
	Thu,  2 Apr 2026 10:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775124599; cv=fail; b=qplFX3ua+1qdZ7+IgsVK4cuNG23LS0xBe+ISGJvPQ15TRftZ3hjSwCf4xncANrbEAt3sbps96ZPydIIK8IaphMPUONH3eUEiBF7iwN3OPpV0MFR7rQ1A5miPA6AWDr2KRbtcg6JRph01siOv298tZnojQVXhZD80M2bd3jHd69Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775124599; c=relaxed/simple;
	bh=tJAZnqb1iMX9FH7eFTU8zDtAQmJc8w6CJsz1WOBux+Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oJ3d/j44bsR7gKKV5WmT3f8KXjTnls719DvVzf//sUhaVT3clYriR/FJmYury03HWKdNMfzKMxRD4fXlw1boIe+x5hqKESyMJXLaVrzCUMCMs0bP7PRCG48jaeJ6FnrLqKnVylhFLWdkuQtj3RCSVWFc4UXaDfQrLaHnnR2/9Xs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WFBRSPu7; arc=fail smtp.client-ip=52.101.70.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WFBRSPu7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hdcjPuSj5BfawAb3+ssHMQuoHuNd3Rp8y6msxY0lhhSlkkCKthY3vbgfF67+cdT8bMDDFTDudFoHuj3+9jrekKOw3wLuUDMp4dkObTLWGW+Zsj8VzMJc9pGyKG1wuM5Ik5XLZRBGFldePNOlxf3oSzwkw3rpyq6uHsjZ0NmI5m8cI6oxBh4QznlfqKTpUqEy35UtrJzCP0ADPCfJaIQ5qDvO4JfICYHY+x/biS1taimkE4evyKlhgZcPkT0ycS2l8lW+AmhmwzAXT5ZjIE/1MFasdYy1i9F2O6qftvaYV8omXlaDaTd44g0Ws/57sVS4sYdKBMIhMJT3U8cfnyp1pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OIYxK79Gz9Yw7+AcA+dTTO6SOYoEIIynXvlZnkrZOCw=;
 b=t+8W7CMBxgoNxAEnkS3mOQrfJLBjKXouci8HZjebVFZEsssPPZFj7OSML+cC2Uho0G35fQA5aHUZEZ85O5vqaXNaJHCrahPMm7zJS99kz1+kFRd1mrMbI7exjlhVv4E5nQpkzsQitR58+zNCkv0n+M0tTTU90JSEJ1WSctZS55Ry/a60uPe5GOw2KEmHUAbnlNGtJ3rc3mrNfqjuqziuts92zA68q7ahVvPuNLhIhASOmrrMp7L1cQOmWZbng37+nHd1dsgGeu1Uj7A+3uZZTddldxywwTowgxGMf85XyTrKBSU715hBjRVJiXTkGM/H4aoXFgJ2SYfxQx9Hjix2bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OIYxK79Gz9Yw7+AcA+dTTO6SOYoEIIynXvlZnkrZOCw=;
 b=WFBRSPu7496iVcB4CUBQyySBuQJkUwxETst+mMQmPNFhXb9yuIMXFz3RAcL0vpC20E01tYiriOEsyouXof3oKhS5MxOcBviLYA55osZx3MSsxUCjgvHY6Df6YO/J7+YMYxgViTPOQCoEqNzYLnpiOfn9hKx8PTdKIujr6ceuvEJcpyC+ISIpZDbyIgKxPWclkke8WsGzeG6VYOWsRZ5NY1I46cGsfiFlvgZ6l3ICbpp9Erpv3D4RBECscndoARfuwsUQ8yIBMNE6/nfeMPHmvQ+Zm6LVnRFvf5Bc9wUWOtVjHslHGp0ZStvF4hZtoKwCMAce2Bbg4LFn//Vi7ZYD/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by AS8PR04MB8706.eurprd04.prod.outlook.com
 (2603:10a6:20b:429::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 2 Apr
 2026 10:09:55 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%6]) with mapi id 15.20.9769.018; Thu, 2 Apr 2026
 10:09:55 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Frank.Li@nxp.com,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	bhelgaas@google.com,
	hongxing.zhu@nxp.com,
	l.stach@pengutronix.de
Cc: imx@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V2 6/8] arm64: dts: imx8mq-evk: Move power supply properties to Root Port node
Date: Thu,  2 Apr 2026 18:10:05 +0800
Message-Id: <20260402101007.208419-7-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260402101007.208419-1-sherry.sun@nxp.com>
References: <20260402101007.208419-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0114.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::18) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|AS8PR04MB8706:EE_
X-MS-Office365-Filtering-Correlation-Id: 5518e394-055e-40f4-40c0-08de909ffc9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|366016|1800799024|19092799006|38350700014|22082099003|921020|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	HQyFcygidiD3fs69cYD2zskkWZVcnv6r+xty370ERYaV37f4eEK1tbVOWW83dapDFHFccLxB9CKLhPuwOy7Cv9EJqOMnsHHgFCE5QOEhgCnxbbTJYZL+tQlnp5S74V2Eljto6Zx+GyHK1be3tTBZjDvoaaPJoWgKfApZR4Joc3XMRKvmE7joJCsgKeLl7HnnBo+MmLC2Mt9/c6pcph8WkgdvfyAEI3Hs490M8XW74TTrkDF5zHKhdBIH+cXyETCdAkzppRMfOgYIoB7eJBFgzql5gDbeeFX3o8EF/MtO+/UVOEmVgl7DDjCU3EDWfbb2v54LryKl+0VAcwIaEXeWyMZyNXdsTckzbY8N0v2ct+F5f8gj7QONcDM9W48zcT5esv8mEIJUtCUPDDkonj1AuVEvGlUjy2RHIaWfoUu1zRcWOf3OIy+u/EU/NqTOn80GijlS8v3usWdzRIobkvehqTparq9UmZ6/8zsQHGQfT8op1M6w1dpKPnQiev6gPH2UXWFoLZP0BBxl/SYAN2TThixND991Gj6ph1J6qnYU8maEn+HwkNg9KKb6tTplGu/Q/hrbZZ7/adHToI+JXret22XeY1gbwiCXDCDK2KONKYnWuRKsQovn9UOLZMHQ6YFzE8Lch35VecRTjev2mfec57uAS7ZKAafwArHpbdcvVIjzGMyR/y6oqc1ig70n2H27p+BrVDvzxS63NDDwGYWnLJYJO+sIN255sL6ycS4dWHVq3iihWVlScznmkEl03QWPfPL9Dz/CTzx50Qj78BWP56a/8/D6ZEY+UZaAnTXqmfewSPTUu2H0Eq0tuMuM4ukh
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(366016)(1800799024)(19092799006)(38350700014)(22082099003)(921020)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Dxmm0HXam1TG+xToBXxtOiY5SC5jdls7Ix8t0P+iur0MYGuHtwA97HSIRj6o?=
 =?us-ascii?Q?tLH43NdvPaAfrfzTv5QkPhxZzJMQIud8YgPaCIqtYgbqcxqbSpQEVUzj/skO?=
 =?us-ascii?Q?kRG1labUMdfhJtpozcB+OEjAjRo7Tpny4sfkXxlARm3eLTY2JsYMq5uVFQZ/?=
 =?us-ascii?Q?vny3ysosKoh6Y4u4Z7eZBqEsaJ4Cqkbf00brX3UbpoduY4nVjEe4CdcbH9cX?=
 =?us-ascii?Q?40pyACBOrCqxv1LEimmwIG2WALVsVgyYw9STTqOgd4BPWzDEzBHFc3QHFYvu?=
 =?us-ascii?Q?RB+9bB7nOt2KPwHeAT8onWm73SweYLlBGWyqvOe7D9LhdyioweAFVW5igrl+?=
 =?us-ascii?Q?CsUNzm5y6inW/SdJ55I/uiJQ/K/ftUDzW5RgTZk/3K60dCdrrH5zejKkzmLv?=
 =?us-ascii?Q?PSe2gTdH1sUnl9hwXo019e8UyFXbItrK/Ci5LCYU9UXdfC93YYTR10lkHRYL?=
 =?us-ascii?Q?kcYNjqTF4khKoTO4gRZaphkWaUZpmNpLDlBlf8dciEK6nMdy+rHkXpKiP9MN?=
 =?us-ascii?Q?pOwecZ8/6VV9CvP01LGDaeZYSrH8Tf3vpoaqMJhpDVzkxBNWNfD25+FYJgpn?=
 =?us-ascii?Q?L2nd1oa8ipXCOqo5QCz+tty2GEDU4Zssfrb1T3v+1vOBKyjuIChiFTSo2NZz?=
 =?us-ascii?Q?By3zyBta/IbB6n5zXDZJQ0wn4F6wP4Lq4hDxTKP/q3Z19vTy9JIc4MNu7Tgh?=
 =?us-ascii?Q?sIwjJBRxK3aJHVvwiCwfWLl/8axlUy4otk4PGPktYBswtdv4GsRZgC2qko3C?=
 =?us-ascii?Q?4VF4HfD70Ic7sMWtX1X42cPEZABxNbwwtCFZ928gjJZBUIG+6tKqXNwph3w9?=
 =?us-ascii?Q?znAFWpee1YcumAV2jQrWud+ZAB+HLKUwh22N+lMeAkBKeGZpiUW8tz/Bdrmz?=
 =?us-ascii?Q?iiULy2ovJjNCTNp1MMdehxJedaYXhKBbcM8mcZtCo73Gju8yTtkLcq7WxcRe?=
 =?us-ascii?Q?YL+Ygde05wvfdh9r78HpUKL+dFAlmf2QjJ54GLOAktxqOqOV+BAgKMrBusN4?=
 =?us-ascii?Q?asVkB6eTVRh/OWunEy63M7ZWDIX7l31FECK+/2eHk9FBaH3hr90fsod5krDx?=
 =?us-ascii?Q?y+L/bcpvLrtl/m5OQmvJOniHpHKzJg15xdXM26Ur5XMm0krBNPd3wEfg+I8/?=
 =?us-ascii?Q?QYWiiohEjLTBsvQfwg4d3XUaHqzZT/7juB48VffWP3VcjLmUNIinA8GxxU8K?=
 =?us-ascii?Q?1P76oUjA/lhK0o+MnhfFXlPp99L0MfQoTNKCUcaSuoqjdCJJVH6Y2dBsvZuS?=
 =?us-ascii?Q?LjopwTCc24fboOymG+Z6cQwkH4U+vfWnbPlg4xeBOCfpNb9GgBMBCACHrZ31?=
 =?us-ascii?Q?OYd0rG1QAatU7pwu9X9qWp3aNsnSwfS6qtx871ftuznocVag/KHAtWMphLkY?=
 =?us-ascii?Q?+Ay38NP1WhiFf/pGRqnqf1JPDxBODKZ8tO8cUFl++PlxkwMhlOZaNIsJXbHR?=
 =?us-ascii?Q?2qrcfLB+uG7m+qZ7uYCesEBcDxyS0UboszsjPcGvr+VZQJE7TygKV+UJ7FAT?=
 =?us-ascii?Q?kAzVmqV2AymSBJfvyf5bLpdL7/7VsXl8+/kja1tSV0hQgr87MZBkQMrpflE5?=
 =?us-ascii?Q?O82YG9AX8EyBcmIXxGti+43Q7i3F6TY6WmF8wAxD9q284YPAjR3YyWhIC+YJ?=
 =?us-ascii?Q?+UQMylM1zEyBwP4UbO1viZgLhHPqJwMlRSmiePwRQKs01CpyBt6dQJPFnOpP?=
 =?us-ascii?Q?zSkXhW5PPDSAhphH0i8cPaxIrbl6wx/VY2fVPduiJc2QES3vKjWj2RxxfXXy?=
 =?us-ascii?Q?VTswBG81BQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5518e394-055e-40f4-40c0-08de909ffc9f
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 10:09:54.8972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lGrXalPpBpfYmAHQw4qkY57XleuGpXqppM52wnMVKceZlA119/VcVoWTpSwq850ipPlVjjkHAZ7+OTB/LGIX1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8706

Move the vpcie-supply and vpcie3v3aux-supply properties from the PCIe
controller node to the Root Port child node to support the new PCI
pwrctrl framework.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
index e7d87ea81b69..75d9b25d1f0e 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
@@ -403,8 +403,6 @@ &pcie1 {
 		 <&pcie0_refclk>,
 		 <&clk IMX8MQ_CLK_PCIE2_PHY>,
 		 <&clk IMX8MQ_CLK_PCIE2_AUX>;
-	vpcie-supply = <&reg_pcie1>;
-	vpcie3v3aux-supply = <&reg_pcie1>;
 	vph-supply = <&vgen5_reg>;
 	supports-clkreq;
 	status = "okay";
@@ -422,6 +420,8 @@ &pcie1_ep {
 
 &pcie1_port0 {
 	reset-gpios = <&gpio5 12 GPIO_ACTIVE_LOW>;
+	vpcie-supply = <&reg_pcie1>;
+	vpcie3v3aux-supply = <&reg_pcie1>;
 };
 
 &pgc_gpu {
-- 
2.37.1


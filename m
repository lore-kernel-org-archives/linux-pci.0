Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011022.outbound.protection.outlook.com [52.101.70.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007503932C0;
	Wed, 20 May 2026 08:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779266877; cv=fail; b=qWxcVMwssV6j1c7ywfNUIbuN5ItfcAr6qR4Ij0+BV4wLYJ92E4RYrJ1s69v+3SekrIjQNzBYlTKSy5Vx4Mcj+ihdLodMX3xLvFqVpQ/VLJiG4juJHmQ4jLLeA+PKKrzeis5LV+j0987ent7G0QIcLTzDZEFlaIfUtg2Z9A6E7Pk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779266877; c=relaxed/simple;
	bh=m0D4KVuWeBSoU/qapXpJd4Ik7U7Lfhv0kxNdHjc496g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VgYKCw7Vcmhf8SyeKENNb67Gh4/eTI/CmzV8z/Q5yd9aPnOoAqE7933Yan4aSl4nlIx1gvPpgp2NpqFFUQGA1e8anPcoOvTlPAKYKd2HBN2BxC8vrkBtRGFUn8CHqlzwbIRdw4fHozF+vpeHy9oGN/pUwL03RzY8C4+gtd45xsA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=ZhKjahXZ; arc=fail smtp.client-ip=52.101.70.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ZhKjahXZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=stwAM1r5X/vB8IGMiKN5CP081XyjRKocmb+wFOPjermGaNWjtzt1nZhQyBP04rNaPzvLsRAVzfO6qFPFqmj0ypa0U9GHnY8qy/azRFpq/ZBJCuu9WGK/S8WRPQ43dWGFELn96k7QjjHVvanvuXsp0HVrYRCCLKXy4cR54awINAClAtMcjwhE3Wsp0VfFd0YdNFykRSNV1+KDSdmXvKIZSBAI66KhzekEAinNCalHx6f4RiEE33MwOUzOtDB2T6RJxJBwnZzcpe21+g2HXMnHZRaJdMl9oYFBtyOevp5/Vg76g/cYSclJTwhsrV5MrBylZDxy3zShIy+5iDUBZa+9Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0UmyF/Jyv9Pi1C8de6wcxYE3l+1/ehl4CHynACfKuds=;
 b=Ug44R3QYkkclZqMCzDLnMvs0UE4dmXwqxyiQhF92qcNPNRF+Qnnqw2JZtC31czn805zWyY89bJzIwzN+LTWJNGkPl73xRXWdXbq5WDKzjWgYFXlvYj87eRT3P4jjSFsRsqLGleMtpABHYVTHrH7U8Y6NOuxY9yjF9ShT2edq+LVu46FoohxVG6vvP2ENAkMgYuFy5A10Alkf7j4mgeQzrkoaIfbRQqNC4NaPC/mBfVlf/qDj6CHx9eVLyGj0f44uYRqomt7Q+U0eZUfeJqrVh42eXCo8I8/iJIHdzx0ZQop7Bf4ZodlcA+v2Oi6M2O1NzLmlx+Ns/relVyq2FaLcrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0UmyF/Jyv9Pi1C8de6wcxYE3l+1/ehl4CHynACfKuds=;
 b=ZhKjahXZtDyiqzNnf4HZ+WT4oIQhY+gXi070kH75X4cWOTkJZVwQ82M0vq93WMjSJipnC94d7BIINFYglsfok5mVqBDnVga9gqtVafSxDNAJBe9EhmZ0n4x1PtOLTCt53uiIjt+blpY24vsFYmJHZ5RRqtUSZKEoglONGLIbNH+Bbo4y8Rq2lXGxc/tZIdwlJksLsSs+IhS8gSZs3MI4MsBNSPieYWo8X7l3M9Oz3y1jdk8S3y6uGW/UDFcwMl0Ud/Byiak5puKvOnJNFhf4/Pp8qG1DqH5aIQkP261BwJ10es4XDtNsaPysdhP94g9N8gHH8ukaCtrxdkkhMGkN6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com (2603:10a6:800:296::7)
 by AM8PR04MB7442.eurprd04.prod.outlook.com (2603:10a6:20b:1d8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Wed, 20 May
 2026 08:47:51 +0000
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be]) by VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be%2]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 08:47:51 +0000
From: "Sherry Sun (OSS)" <sherry.sun@oss.nxp.com>
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
	linux-kernel@vger.kernel.org,
	sherry.sun@nxp.com
Subject: [PATCH V3 5/8] arm64: dts: imx8mp-evk: Move power supply properties to Root Port node
Date: Wed, 20 May 2026 16:49:01 +0800
Message-Id: <20260520084904.2424253-6-sherry.sun@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260520084904.2424253-1-sherry.sun@oss.nxp.com>
References: <20260520084904.2424253-1-sherry.sun@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0097.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:af::14) To VI2PR04MB11276.eurprd04.prod.outlook.com
 (2603:10a6:800:296::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI2PR04MB11276:EE_|AM8PR04MB7442:EE_
X-MS-Office365-Filtering-Correlation-Id: 8335821e-1382-48f6-2d88-08deb64c79ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|376014|7416014|366016|921020|56012099003|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	3FlsnPRgkOGkYncvIL9FvK44xl+xiJ7OFRTxrpII8jcAY9sYEqpu311TwxUetjw4EYWcwdZnqzmVaPaNSoG3w+TezNp7o+GIRvsGXmMaJGfWboPgJCAusKhtX5J9B6aFev5sqYeAaHiI61XS+AXIB6Lw0kzheC/TLIVgKGu61Dz2K4DbM3xeco1MF5KmkB7V6Qj533WaZswAnZvt7qC2L9hGtUGFo4PNMQIwUifN+/kGlXm8WKUX8yizZ+C442DQVoTl0Jem9uNEKqjz0jWpgq4jEinRbbpnbjMTcLVERKWGJ86LTAh7mOBMlwpR26FDJCxcj2s+81JOXtLDMWhHubLcXVPyFoVs7DnaOPPizmyHeRYRmM3SCd0SRP2a6YnRX5wpkEImbLn1Kj+qy+r1AkxRCcVnbWrGTgyLkZM0GcWa+MaR9wd79ioiT5mii074jgIe58PkL0dSykmrFxqeuHPjrl8AtN3bpOtBU+k675+fj+keTSO1ogu6cWgZSPdU9qBl2YRmJqBqzemwqt/r3ebCg0UpcQxuJ5CA7rwcCBJDVLY5xt2/iI9lrLaUu0VGbhi6Wu5vqzh7vHvWDVbndD4ysucNFv6sN80tEHymGOMMmgvR719+jA5yhOJUzuwRxwMuEuYMBV9a10wDrRqDgf1wrfyVYVRofyERGl5EHKDhghTbi7ce2tL7klVAAULSbitA1XH9kMwZWEyHt09nNnLRnGlc6K8WvpE3iIjkl8Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11276.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(376014)(7416014)(366016)(921020)(56012099003)(18002099003)(22082099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?x4A3S+x8BvznWcr4k4voZjsNLWAt3Fxzq66c03tjPU1OCA2vEPal23hlAY5e?=
 =?us-ascii?Q?p5cIo5k6sWd5aVeylCn4fsA30hr0yW7RmhYPwD4JUzQOM5EdzDt50mn6HFiz?=
 =?us-ascii?Q?8eAEMwAlUB4XzYrKqF27g7xZiUEvLyPoZtSj5//AgItszElpGhYxO5Kz0BAb?=
 =?us-ascii?Q?EfQKkNOuuI9OOa0NlHK1WWn+LLR+MzCvrkTuNaT15T03Mtvv8zuzRfAskIYF?=
 =?us-ascii?Q?UlTzJLYKGSBBMC0bGaGhtyLRCdzOabTIssE561z/XM6bdToTrtdYkQAbiZ5+?=
 =?us-ascii?Q?RjlC1QTbJ30CDN/K002e/DKJvAucXmN4R+tOGmktR/DLM+EDP/7hgBOGDFys?=
 =?us-ascii?Q?HaDORl0jUJkR/N0zl6xpco8Iv8Y8V62pILUVyoulf0hubGyGVfbutzv+/Bqu?=
 =?us-ascii?Q?ddDCS8yUIZFTkVNhbODB9KagvwbXIsMwQcGFQE0kQZ5Z2oKXsMrlws5xzbvP?=
 =?us-ascii?Q?LRpjUMMQT3mNA/O8i3kZRBmL+otHG5euYIFSPIm4OdLN7NNG/TL/8ow1OIlp?=
 =?us-ascii?Q?Ah9QxK5V5U561t+Zs38F/lT06+LJk3t99TAAxSyCZY7m36L1uM7uu2CsEQbA?=
 =?us-ascii?Q?IUR/Z0ZOmE//ueuOHOGO2kOJ/Jxc/BZRMGg3lSvGXa/seWhgsct4EUONdkBo?=
 =?us-ascii?Q?zPBAHHk6YHitaAIpeDiAZmkQBDtbDsakl9Xmw4fN7qdchRH/dwXqBy4t+2dW?=
 =?us-ascii?Q?snno4FAnEjixx0YL0EBuG9If+Xz4q3WtF06FSObtyc7TawdZKzZNITmTJEAL?=
 =?us-ascii?Q?d13cSTaBWFcDCNnRfXkbpNygxMw+WrcxcQIWS7gecq1J9sV8v4aq4bl/G9Ab?=
 =?us-ascii?Q?WeWEMkO7e2b/JbWn0VvvD3mnpo0/v7oFv+NLK/1vZXAfI95XtV3ZUDP1kmRL?=
 =?us-ascii?Q?4auzd1S+tJim4MmyX77b5hUzlwvKFqEbVZRZ8at5jqAOvrBHgYtnA7CO9N22?=
 =?us-ascii?Q?nDQVUKcM8GsGZgShoUHifrxMpWZRPXjnQAF6z+hUEy8OT1B1B/zUzdfyso0F?=
 =?us-ascii?Q?AslX5TQCFqOXaOXCtY1rQcks7cmNRTF2rgLIUCsWRmWEI/1o9S8FgcCXJw+a?=
 =?us-ascii?Q?aYtA/XwTUUhyIQi+EI+RgQ1rQ+NEqLqmqrN/nt9VRB89Mbo37Bm9PkLZuxQW?=
 =?us-ascii?Q?NwBfn4SgtYX+FmALJsSg2yjkof1b428yiyaTfOx+mn0htY+U79h9s15FTvdb?=
 =?us-ascii?Q?5vmfukfk/iKZSGHec6VQeF+Fgg4OMxUhPuluFbw5gdcnlU347SYLvJvT5ONv?=
 =?us-ascii?Q?3RS0PqJVP7FLs1fBPE34h7a0v5SedyighTu0X/WJJ4m1fXmnhmF20WRKCOT1?=
 =?us-ascii?Q?OLtWIiCqBxXU+1wruClHvEzXnDl/CbFEQ+GwvcSiclzEDD8wrwu9HKreugGD?=
 =?us-ascii?Q?I/S9vRgqBWt1X/6l3LJglqUkI74Wyq1Ri5yspBVs9GPeYKQqtY8M/MerMBNL?=
 =?us-ascii?Q?x6rqZ8bpn/RX73e9UcQeXlwXmbweeDdhCTNXbgtEGxlT20PNgSZSBeXgL5r3?=
 =?us-ascii?Q?vStOBgK+K980Quup9sEqKDcGiQYWvZlWjbQhXOX4+bBV23VhscQwyXpn8M3i?=
 =?us-ascii?Q?rN7nqWfbdHlV/7VHm2IIUAW00/q5d20ae1P34fIuUYDkD4noFJM5FH79OOhd?=
 =?us-ascii?Q?qVPabF/+iBUUHNROfyVsiyfEGP5d+fbQ3JqxYqgomHbR+CNn0B/YYfcYqH58?=
 =?us-ascii?Q?V69ouSgFiyUGDTSMBu5pmpqb+f6P1llefR+UG/JrlW5C0fW6LbPr1do5eKsL?=
 =?us-ascii?Q?IOnwkf1/TShSUYV4z9XSAheFF019lHD4p3jXVDb+BiBCrl/pIade?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8335821e-1382-48f6-2d88-08deb64c79ee
X-MS-Exchange-CrossTenant-AuthSource: VI2PR04MB11276.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 08:47:51.6214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zCm7cYLR9FKmzuIcAvDbuFyJonsmAZNSpIS6F5nFziWV58F0gb5rk8WsadIvO0XuYw0vxcuc6ta8C6G3l5APMLDU291BCqFZONUwBS99UTrS/0Ri5auVa8SJBtiOgWbU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7442

From: Sherry Sun <sherry.sun@nxp.com>

Move the vpcie-supply and vpcie3v3aux-supply properties from the PCIe
controller node to the Root Port child node to support the new PCI
pwrctrl framework.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
index a7f3acdc36d1..cb2b820cf3bc 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
@@ -772,8 +772,6 @@ &pcie0 {
 	pinctrl-0 = <&pinctrl_pcie0>;
 	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpio = <&gpio2 7 GPIO_ACTIVE_LOW>;
-	vpcie-supply = <&reg_pcie0>;
-	vpcie3v3aux-supply = <&reg_pcie0>;
 	supports-clkreq;
 	status = "disabled";
 };
@@ -786,6 +784,8 @@ &pcie0_ep {
 
 &pcie0_port0 {
 	reset-gpios = <&gpio2 7 GPIO_ACTIVE_LOW>;
+	vpcie-supply = <&reg_pcie0>;
+	vpcie3v3aux-supply = <&reg_pcie0>;
 };
 
 &pwm1 {
-- 
2.37.1


Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012003.outbound.protection.outlook.com [52.101.66.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414673C454C;
	Wed, 25 Mar 2026 11:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774436501; cv=fail; b=GqSHA4E2bRqYd0Ov6xugqnZj93ADNOQejscqsaYeukwbAGcVTftV57Bp8A9lubFd6EW4DwVyg2CBD6Zv5Vauh4g4RK2dkIeQPmXQVZ9jptUqO53w9/C/4tgSHZryxE5HWuFXHkS8HdN1tl06EnzXUfHNLqN9PXUasdDgeTUrFME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774436501; c=relaxed/simple;
	bh=l1+lF7phMLsmuXb6+thzu+v1gKazkuTTF/INQMYoqVA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OYdGLyqW3LZOhVVFgXDL2hFHTm4nJJBBmQQTpP4dNsfiyaMtbkYKX75H/zvGrTmhNvzZkKDPVZb5K6y4xmJmA5A6UixWIe44Q/2JUzW8DbTVu3fDYJ2JbN34rXqZ86Whg+KOAg4sPijWKDSQnzAjoFJfbK5z2gGO8+dP4LFTNPg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=AdSlLJes; arc=fail smtp.client-ip=52.101.66.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="AdSlLJes"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F4VFsYwVZmWrPymSWxdrn7oUIJVLGnheGDXNJDOt6c2dFMoBcYCc4f/B/oGwatmLArPyqjgPa/5ebC45dR65pY7Wfn5x+jZu4G2cz2AQl06TnkTLVWCg89XQSbujU7RweY7TCs5rvrpr7LuYwr5PEuJFm9b3D2kPPTEbu9cZnBOFB4MdqECmjCtt+8p9gEKoY7tvqH+f25ga09bnRB0DfgYJJ4DDDxUt25/UilehZjFEST6uiAtNfF1iQhPW1z9mAdMDCXHz/oAwgubyjx4aQvYZ7zrY4GGko9+VZvrWsmGsJfiUTF+cyhOC7OSsZehHFQ404qQPDLpH3FC4xgvY3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XjYY3j5+JrZZ8ryZAy2n7rdlCqQ5n1qooJxAKTwjLgA=;
 b=mVOk2RtOZCDMOEVq1+8gYij1cCoEG0WVVOkJxgdS5ynsu+09hjjVREd3RuRmsg/Jovhy0Yx03bruslQa45SCone6pIseVuIjlrcNZT8ULToccmEbEeJUU6/1ZS4Rxl0dAXnTiFWP4TxNGsCIEsBzSaHJVUwhKYjSr9ej1JwIDLzeMbULOvixqBDnimaVrEku+2DnpFyh6vtyw7kVl8GABxTXSac5z/j5VNTiLdgQejL1pHN/RUl2/JAmLhIRWr+N2xquijWI2AfOCY0rRz6gmXW3FV2wfTr5dYzT9UMDkLEcgLGS39r6UZd35nCFph8/VAPUmuKzF1R8V3CGU6xJmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XjYY3j5+JrZZ8ryZAy2n7rdlCqQ5n1qooJxAKTwjLgA=;
 b=AdSlLJesDHrj+3XeuxnjEr5hVjKPeXb1RfFmSJ74Dv6M+R5y8iv3YF7SJkSKqjarDTNiX/raAiFKrw1KsI4cFaFKSVzHCxRlN0g8wbI4Mj5VuE2XjWLFlBNQKe4qtJEkyTRyYhY+ZsAAfhoRItVLp22rBUSAj+1MnPFAhjQsmPYTvvJbG5lPtTuvPLbiZy35UPxT356to8befKK6j3RUU0N1pb83CXVz9bP2GqvLOyjiX9DceA1V1+jOwM4FaRS8dDqmjrOnZEbLZ8EVk51ItTSVpVXAtcg3Xk8ygpgXJyOth4S78Z1oEgheIogvYGPq5Fw9SAJ7P0eZcN8VY9vIsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by GVXPR04MB12268.eurprd04.prod.outlook.com
 (2603:10a6:150:2c7::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Wed, 25 Mar
 2026 11:01:38 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%5]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 11:01:37 +0000
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
Subject: [PATCH 4/8] arm64: dts: imx8mm-evk: Move power supply property to Root Port node
Date: Wed, 25 Mar 2026 19:00:54 +0800
Message-Id: <20260325110058.2854742-5-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260325110058.2854742-1-sherry.sun@nxp.com>
References: <20260325110058.2854742-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA1PR01CA0174.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::12) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|GVXPR04MB12268:EE_
X-MS-Office365-Filtering-Correlation-Id: 348827f9-4100-413e-836d-08de8a5de288
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|376014|1800799024|7416014|366016|921020|38350700014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	BTOKiTTXLo6e/D6JL+RShRil6kwgd9OsYWf43/aLN65sWcFpry7FpBqj7wmELnmJ5GjN79W4GpiA5kD7AA2yEkhtFfe57RT4vTK6YSaMW2epjSw+NTHX61iU6LGZ/hXemQKV3hVeTqPyBE0tdpBwYD7fhuEah/g7yXRxLfOlMw29VthF8oZpgBY3bhkzuUtI+Ftec4F81mUlCKiEcok+lu9Pbel7hzQIEIHJR+NyIEqpFTs7juV67x9FtqosJ/SckqW5bT7PIn6tJI8IYZCVf36lGvwwIfDSpdaTMiItTHKKUejAwzvKLz0gA+VauC/13IqM8REYYH4oNN30BznZHQd63SGpdUlR1Fx7RwOLBlu5la0fVP6+KN4yVlQNjbUTkAnLugH3Tmpji+UbUehL5ajNT0m53DYF+3gaLr1KhKxEiyjsS/8qz+bjSv6eEoYmV0zny4GdmTiEXwVo+OHjBZLKR+XIa5t09OAF1fpItLuXRAJZdqknB1jbdg9CocgKV1TyunKSRMOhlMCuMqt8NhJ51ipB/p+DypUNhoWEznHFU7Zf+tuy8id9C4/em+J02x6j+Q+0VeT1qmu7kifex4H9sdZ9U9NMe0IHxEiN23G5OYI1d8Ct/6viNOWE7blZO4Xu7mRcQFLs9w8wv8ZmYC2Z+1RdYbpR5V3FrKqMEr72UNeGcxpkWiAGVOS3vWvcdcvf5jyqXXaOrxGrxmjmD6UkA613Iqskr6NSCnd3nCYbta+EEPXDnYASSchcYKkM00RvlRqDmnFcbclX50ZkyitEhDB6xEV8bNaewgCR8r//ZZvdU38NXDegcvPKigaX
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(376014)(1800799024)(7416014)(366016)(921020)(38350700014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zJ18PrcKqeq/lfkt0+JmGwRTgfmi/LHVz4+ZzMHet5XOtn8IC8Vu4CKbG5nU?=
 =?us-ascii?Q?SRl9C2nQXFbWPmVOlOLT+VjiRX35PTrs2mkLs79Qutz8dINQgoyVUDZ4Y/qE?=
 =?us-ascii?Q?BDZgk/CwW2ryNxRJoQp30a8Qil2Qjcm+Eo2CXGhzodgT9t4ywbiFmXhsJOZq?=
 =?us-ascii?Q?GGbWzTISzVvSfREPuTMItvGKdHXVZ1rsdTa5UQf6M2dD8mJlp6QSqei25Qso?=
 =?us-ascii?Q?MttkZVzZrPNXLJiRbm4Iu32OGDfDc6ULx6a33NqFliClL5UCWq82WmWOwiMR?=
 =?us-ascii?Q?WA1XdtYu+ZEvmXnsZe24MlftCSbfBGbHeNFA/DYdOVOrldaSzXNEnrXBm4Mn?=
 =?us-ascii?Q?SM90EDI41XQpeASatHi8sAgihEAbQhD9++5Is8RSuarOLavF1xub0Dn4NV6+?=
 =?us-ascii?Q?sn/e1WmzN7Qi2mo7Hjott0xyxtoQgTM+O062xcnpZ+4Dyfqx2PFuEYile27X?=
 =?us-ascii?Q?PMN39bTfB34NsCnxTicQdcVdeGS/csH/QhyAPEBHZlAGlRoyYmzGAphC4qq1?=
 =?us-ascii?Q?8PX3LlYCIqPvyo2FcOD6wmN6JEoWf6GLUGUOXYxyprlZ/rRqdAhCwuIkOViJ?=
 =?us-ascii?Q?oiakYF1bDwlP8lEkf7/WNoavAi4XWg/sgjnVc2/Yp1S5RwYLaqS2IU+gWm2b?=
 =?us-ascii?Q?zZ6TMHj57LYlfIPuLdFrSarb5TlE2e3EbPpKjE++5b3Dn3DlrgRKQXJOPDJx?=
 =?us-ascii?Q?BsTFjzyxbtlJLaRZ3kmZ3O/eFplaF4HiijZGT8Bm+Zw+Jog7S5AIuz6cnTYq?=
 =?us-ascii?Q?JmO5Lwkzd8TAwx3W7iX7P0WMYpaAfO8AsSf6qxYVWNr16dTuT3fFrrP3oTpp?=
 =?us-ascii?Q?y0f6YIVxwfXydzCrsWOB0aY3fL7nlStmCxta9qsIuoG7qOS7NFMDlERBfiJi?=
 =?us-ascii?Q?svdWcuObcvqrdrurRdZfhsEf6hsZ7WAQfTkCuLkesHCOmm+TB8lSx0EqYj+P?=
 =?us-ascii?Q?phY77+JkWU3n+CxiiDajeLQ7WMmEWASP76M4WTMLIdVdR2C8g3RaXI34RXd0?=
 =?us-ascii?Q?1gonEikVjscpgppPguFHnbge9X6SOQMXgNBbQteQnfXyjQgn/I8CgY8Ufzjn?=
 =?us-ascii?Q?vyWI3XzJmJ4/BUdZckbWQO0CFGaZYp86YpKNDZ9QJe86hY2ldIv6GCvQ2RMc?=
 =?us-ascii?Q?5yNZ2IIGUQ7xBQwjS3yhD481hUGSf5CxnapwcB8afMye/U98m4cQY27M44Y5?=
 =?us-ascii?Q?/jGUMQbWhgErm+RKNqRUtd/kK/pjDBkUXBBZFssGyTuhLuKnZcotV+KTiuf9?=
 =?us-ascii?Q?iUvXRZM4T2eniJ5JmNp0CvAMJ2PRko9fk2e3jhaG7Y/pz+iK7+awA1ntNhuR?=
 =?us-ascii?Q?ehTDGZxTQ9BMKNOHntw2/Sa+l8OYZ0HytqOGT3sNlXDhESedDOrQflGPEnFA?=
 =?us-ascii?Q?jadXAs11lqqb7uiKNO5FPkqLxhY1EltM2UB7r0Gyz+NqW/9GjI0YSv4AvQqv?=
 =?us-ascii?Q?2j+vqyLdsciy15MC8auGCqWalXX/Zt97kLYX08W/yxdLpQ4C/61wT/bxOv8D?=
 =?us-ascii?Q?i0WCri18gLOVr4GYylm5Cdeb/xyv4xgJ7eNHr1b4mZrAfhizdjVOppYFA58V?=
 =?us-ascii?Q?Y901zGisw68ydMMtD2A/zyOiAfwk8SIqBXR/7T1tmQsp+iz/XE+SXpNii+kI?=
 =?us-ascii?Q?ajj37BgJHOeaSiC72Ykj1O46bR98UAKWhwaIgASEqYKPIF8R1yZMsLy/rMfU?=
 =?us-ascii?Q?i2ca6x3kMdh7UbPkjS/SJiDyv3TnVgWfBX6UR3J0qP0Th9HW3jNUXFzPnQLl?=
 =?us-ascii?Q?Pix0o28Yyg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 348827f9-4100-413e-836d-08de8a5de288
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 11:01:37.1263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l53RbkAK5gNajfH0vqk9ijJN2S8Vi1IPELOOtrImQgmfh0r+Q4kHXqyPd05dsgjg0O7SFse+ZeEcKPt4jhojoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB12268

Move the vpcie-supply property from the PCIe controller node to the Root
Port child node to support the new PCI pwrctrl framework.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
index e03aba825c18..ba7fa0815d13 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
@@ -542,7 +542,6 @@ &pcie0 {
 	assigned-clock-rates = <10000000>, <250000000>;
 	assigned-clock-parents = <&clk IMX8MM_SYS_PLL2_50M>,
 				 <&clk IMX8MM_SYS_PLL2_250M>;
-	vpcie-supply = <&reg_pcie0>;
 	supports-clkreq;
 	status = "okay";
 };
@@ -562,6 +561,7 @@ &pcie0_ep {
 
 &pcie0_port0 {
 	reset-gpios = <&gpio4 21 GPIO_ACTIVE_LOW>;
+	vpcie-supply = <&reg_pcie0>;
 };
 
 &sai2 {
-- 
2.37.1


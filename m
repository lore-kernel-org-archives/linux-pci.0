Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010040.outbound.protection.outlook.com [52.101.84.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE54A36492D;
	Wed, 20 May 2026 08:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779266869; cv=fail; b=FVa5nXxfE9sPdpGGzxB1gkec7BCJcf4WAAlY0EiisdjWpqgf4e25CSweQWj4nR9bTqgkjJ2AlPSnFBYBg31zjeidXP7jZEeUVuy4EVl/y0LWgnB01JXLqmwJlgTlQR4kR7LWcfejfS7+K+PktMlBL5od+KcsJJdqeTVKy6p6WX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779266869; c=relaxed/simple;
	bh=9uAMB/ogV0OcwR5jYOkELg14NsdvCNmPVQNTq4Yg+9E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bRZ8jhZ8zYqRKLXmvS7dWNrZhQXW8lbW6Kqpi0xFdstORaMNwaC33dQJ7D+WU8rIrblfOIpaD29fC5XxgopN6mAznbYlAkU9nKrFWfgSt3yB7ePvvm2aZTYbNDTonJxaLd1uLEZPpTBYLr5FkhMaVd5TKSfWwmoO8sQ5MMKrFoI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Hf+Exymz; arc=fail smtp.client-ip=52.101.84.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Hf+Exymz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q4QEc8bl+u27wr6ubqZsy+W2Vx1iDtcaR3m1Y6dMbGiJyy+JEx5ltI1B2CExI58LlItHVRsSkvsjOS6rGZnS4Y/AU5uo0ceKCvqhYG+dR7E05a6XeQsOwVJdf+80dvYRaK20kqqN/gl/ahF4bHRwFdHMLVI3uDHU9jykse9o79jAyHsWn6p744OWb0Zr66cGEb3AI7kMwXr6aZBw9g6jPkN8rnfAuVLUZwHv696k2gXSmsEjPkys9KiQHekBWFJNE2ma3ImqoWGOj83G3hlXCQqaZvE2KIJey2jZRoPkFWjoczBO8ywH2iPBHIqHOkes9y9JdYua74d9O5QfHvAXPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xtVI4ELe1wm0FzTkP87LI5l+CRp7QNykVseRSmBdZYE=;
 b=q/P+mFfXFGm+YIG2DqAXuoY5cU0txmVkADhZ8NB2gMi9A2bjDBBCEUyYVECTr9zv6ixc5DBPzQiqORQDT7T2fOirjaNX+mcdTrENP4LTE06g/TByvf1Mf3fglDSAej1o+7gV9hVUi1Nww6iY9QR65JbvifshuI9XhTgqo3PtXMPd/ixWsYUjjuvOgrvgBlTAXDMlRFn9NarN2BP/WGh5clLVC8hZeopM/d7uw+KFNMOVGdicV99cziWpIclqlchbujCW5JiP6xbCUOAwXVUEDE2WsV5D8xx0Cpe1PplKrjlRks7pNZS25+D02SxsckjPLFKNKOI+ucESDOhz6hXm/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xtVI4ELe1wm0FzTkP87LI5l+CRp7QNykVseRSmBdZYE=;
 b=Hf+ExymzKKux6bctqygvxGv10qazxhPivY56ykwl1kjsZRz/QYW/7DM5tz4ft+FBNzjJ5kAT2Y4vRqyYU6gy0BhP1XTewMEcbwMfPgZDeeKTlTmEawT4Ame4Y7erKAnAGNvvG9kpU4y3jc158HTocZKM5dB4Ozl2xtrky9ItIwsDlZigMhYQwBJaQJaio3ns6edNhcnrG/olc9SsZlHu9YIIeW7ppoADyjWI8m0tqrASOPfji3tWbGkfrGgHCAMF5B22qLEGfZnCUA2xCkBaIfKB6/FA6ZAmrz7rWaCQA5kV3rmwHZnY7ytdoWUvb9PLjeAR2xKbCAs7KqJh2dH0iQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com (2603:10a6:800:296::7)
 by AM8PR04MB7442.eurprd04.prod.outlook.com (2603:10a6:20b:1d8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Wed, 20 May
 2026 08:47:44 +0000
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be]) by VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be%2]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 08:47:44 +0000
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
Subject: [PATCH V3 4/8] arm64: dts: imx8mm-evk: Move power supply property to Root Port node
Date: Wed, 20 May 2026 16:49:00 +0800
Message-Id: <20260520084904.2424253-5-sherry.sun@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260520084904.2424253-1-sherry.sun@oss.nxp.com>
References: <20260520084904.2424253-1-sherry.sun@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0127.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d0::12) To VI2PR04MB11276.eurprd04.prod.outlook.com
 (2603:10a6:800:296::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI2PR04MB11276:EE_|AM8PR04MB7442:EE_
X-MS-Office365-Filtering-Correlation-Id: a1000148-d14f-4c15-e1f1-08deb64c75e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|376014|7416014|366016|921020|56012099003|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	d3+8J72/P6qhgmKJn1qtf2D803iu3w+EhOo7bMeSap3CLftIChk1bSHq5LYFwrv15cQDVlXs8Obis5h3ezoJ1v7nnvu/cGyqyMMGoITDhJkCLYc29XT2PEJCZGxOszUWOoE4peE7yn0FCgVt/LJP0MobG3iOnDtST8k0n8jUFixHK/FzGstMeMSw44jPcW18t1ySazcKkRMsBMspJTic6xcb9E1/9kuzPtq25VmW3iV+F8MBJ+lpbyD4zUAB+bVoxKz9OUJV4LQFdDNshqhla5SCcT7wOCa4w5wsisHwP3ERY3L4eKzf2sTMsflg91Xf9Sbk+MKWjkGNiUlsXOJ5yiLm5PNWGibhI61IryONDEbenwauS5/D/CkO3lwH48gFN+BOqrk9winjj5k6Nmev+MnYJqbAwoWOX7tVsLp6Z7u9Nkvb6TAXI+ACK6EWoZuTfP+4YNorctumS/9rS1zrimdopmb+lCRT2jdXiqRchCf/I4lcgaSPYxfSetWJa3Lya37z3F+ayvQB7VEnMaZVEKlRjaL60pdGbcDLHGlzI0sS8HqWgCBqioMtbN8xKVBK/D+px6rkd4QNqyIBDkU5WcGbSHgVwIiuJqmP1a5aEvu11rA/5Q7fM4IT9F4YrXGBoTp+FSCL/3BPfQ4WL/fLC40elon/+XKavKINPG6nGVsQFdcLOUW7cm0R/WB3KvWQkAznAnQcR57o78PyCQmQsSzD1S7bzfIxnG0k5DDr34Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11276.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(376014)(7416014)(366016)(921020)(56012099003)(18002099003)(22082099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?X/UDhVI7A/3iy197100Mos1OznYRawHE/zjMEYNdAlODA+jsoWcf0vHHzsdN?=
 =?us-ascii?Q?ZUgXJBE8hZkHmK9UjL5J0y/Ag3HrE0QSeS93XOW24hMfxdIsS2bgL2XxEHTF?=
 =?us-ascii?Q?9C1slQ/9kBFI2OgRn7HcbzjvrUbFWPh0y90vRGknfPUZiCvwHX2mBlyCgZmh?=
 =?us-ascii?Q?Q5FTfLJBr9jhBwFEpBPj2E52jDzm0jrhaiexvY5GkUS+B1KugBUZ4nPEcE5C?=
 =?us-ascii?Q?rnJtDJyTa30GEFeK1pTxS+XUVhYtWwNCwCyXQzgtMfBXFCD6b0lOIP9pFxxw?=
 =?us-ascii?Q?NDyM2aCic1yfz8pbnhyNQZoIdFvriwNhBd0UMB2NIpGCQr7QOY5VbOeL3oDu?=
 =?us-ascii?Q?M7WHVpJoIQsGc4qJ5V/DrmcqBEmOK+7VJElAFPlir0efdD8X4CNK2GxlImLX?=
 =?us-ascii?Q?SAGvCpDGMpwrasy4SVnRwf8wJIXeOOwF0OtAe10T8fgi/07JtOKYOwDzrjla?=
 =?us-ascii?Q?GzkU3arno/1VrFs+QGdZPJn59K936d3S3OUGp4716JNSvNxCErY6mzuUF+3W?=
 =?us-ascii?Q?YfREVNwFItySUC3qzwN7UKGM/JbRlp3UPkrFCvmJ/c9eSabCPd3fbru/xRBB?=
 =?us-ascii?Q?QUf4A9f1ZMj0WCQWjem7bC/JGk1AYZo2wYALx3s3bE6EDKut8ZMbln4StPYx?=
 =?us-ascii?Q?lgbGzSNYPd5T3gGXM4jzG6sFBHuH/PpqnUCOnQmDLcLXmefalnlOhKONtNc4?=
 =?us-ascii?Q?oankKVe28OiAkMRCV26MGfioRMzvUJc/WyCGD4OpKmGpvd9Qp5E5GVaJNTW0?=
 =?us-ascii?Q?yt+5mzsvtl/miY/rhaL73SjNsfkXbwyC/1Of0MRhs8WJwUnaPfNIhu9y40/b?=
 =?us-ascii?Q?ZMe7T29D1ZOzRgdqWVamOG0x2f4lEMOeN3MhZs8Bgq4akQguEmhEldPu7nh0?=
 =?us-ascii?Q?QpgEAyWyXR0YnpjQhsLsFVBedAxQCcLmktz15vDoxx4YLprYp6t35L0H/cBa?=
 =?us-ascii?Q?eOY5RbwYilghrTyr+7XCUfZvaT6nA4aQ72VZeKtvagWY/8gXTKfulnQ7/+ld?=
 =?us-ascii?Q?2I6dlICzpWpJXvMl3sJjjTrTvRgHxhxM66poBUdY+4Max92Z0Oh+vjmtrpMM?=
 =?us-ascii?Q?M9t899Ro6bwV4BnWGKAvTe0qK/peFmtC+wI9wpIHuEw6jm9qXpwpR1KXh4x2?=
 =?us-ascii?Q?Gt7RtDz9x/NmjKgJjso9TMocYPuxIXn09P7iKZ1lyKmc0pEIam6voGYH+4ho?=
 =?us-ascii?Q?7rnaavBuUTK0M1ASLM9E2CXgGNopi/hmxh/BA6iXlm5vH7GJWrw8RPlXROG4?=
 =?us-ascii?Q?jgNiIYGHDgR5WI781oBN9LaczSXr5wMCWaBMDgomMsF0Q0vYdOd+z3fnXNbc?=
 =?us-ascii?Q?JBoL4gpn5JpdT7raXWfi78bzs2BGrWKlr4p1or5ul3cCssg5QeT9tbFDQR7W?=
 =?us-ascii?Q?ZYCluYTfJnsSvdao5iQ+473Rg6O9NGrgTRtgOTeqxPNv3OluZm4cBXv1k+GG?=
 =?us-ascii?Q?FUpHAewaKEO04dvcNajfb2513D86h8Uf7A+mVIXtcxrfuR/6VAaImc5qf9Of?=
 =?us-ascii?Q?OHWhqY1Z7UL1C11TDOoP+KwAnA/WOeQtLNEFv866ADOK1m/FypKrAfo/mCYm?=
 =?us-ascii?Q?RBrUaLaN++vYvitM4WzjIKS3W90FUnA83R+59Wb86LlVXgXB0ASQArR+SvzX?=
 =?us-ascii?Q?3XiLXcuV/Qf0d3KkLrdelgyI8k1dWY07M9KOxuMfNOR9+cs7ug92nXAj4i2O?=
 =?us-ascii?Q?yoD/fKpKEssgax5JW7Vs2szjPMSXCaM7e1kHyMO+XnhHVZLQ+5Ux3mn8elNP?=
 =?us-ascii?Q?jrd4aiL4QVax6cmcw0gHXnPsNs1V1W4UMnddZYxxKzHOqHTIXqhx?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1000148-d14f-4c15-e1f1-08deb64c75e3
X-MS-Exchange-CrossTenant-AuthSource: VI2PR04MB11276.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 08:47:44.6904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iXK61iiuclFuH8D6VVUVI7dm++rwTq4IUSwlea/3RyBphQ2AzTx3fzwOru34B1qKsntZMtuWpV42ffg1ZIsFTChyyZa4rJmX7CxQXuoLzixanGAd9nL+bGu/ZJu0vlyM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7442

From: Sherry Sun <sherry.sun@nxp.com>

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


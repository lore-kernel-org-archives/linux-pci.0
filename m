Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013039.outbound.protection.outlook.com [40.107.162.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AAA63DD53F;
	Thu,  2 Apr 2026 10:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775124613; cv=fail; b=bn2uvSp8OMvj5CKBzFdMpbKpjdAU/7/SzBe435po8epqt2WQkUH+4zmIVY3xFCFuyonQqtLO0Umuyo+CJ5FAAgbSTmZ9V31o0SNSAsxt+4354jCdkGnrI6xCuZUSenh5yRIoaC/8gyT4nllkZDqVmgqik/QwBCRcYKB7ULrRZgA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775124613; c=relaxed/simple;
	bh=vEZPjcT6pIToiMIHifIprpaCRTmQNIzLtv3IGJviNgI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qGElWspFGfi58VpwgXJ4AhS/kxSI7ZY1Bx/IfkPhrFHXATrZKqfKQ3m25R/DguBR97oJ5vInbeodUPC1k7s6dm/AREdlPA5tSfaZwrn2UfhVRQt8CULSMTvJbc5U14zhefzY/KvQqFvDCF5XJVZbASuTu1aH9pS6FbPsHgm+bxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MmMGQki6; arc=fail smtp.client-ip=40.107.162.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MmMGQki6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ySLzSTBc+kGiygDCas9EaU75IwqlprqxNmngUdLR1Csf0qH6vQ8kNG5IHbh/60ShNU81AUdflFPClpllgGRv1nhld383Nz6StzThTBBcl+n8O+Joy76zXxcrsKNyeODwBis655+j5/cNUb8/WBK9LYgxXc9qCX432gr8yfOOJE4svsefFVRrcwUrNS0P2CNoPUX3yfaVaKPbALpRsoJ053PhwJXPz5NX3Xt1vTGGdFejZs2Y7b6MFy17mt7CgXLQz6Soxm+KFmEqdtCa/akKT06b/iPfNHnyytL4kjE5EJzXiMbF5K7EPOHSljOQLxILK7Hp8RElpbI0hYfusNDyBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vxTWuUbiz3HjMwyD2pkoFeUpebgO7CXzXTE/LOIBP9M=;
 b=kU7cBV5CQFsMvb/cWKaiiURciEQNYzLkX1a1qbsmVlVgOKJLhS7BmmpX4yTSyv0TuBJqMi45opb+QI/A5tsIuCNGDYS1PWNezVJcYxeq5Tt/wzha3He8IPY0g+qdCV4awPEkuPFZt8LnOCw0VClZcFkul+aexsD7xJpNHhdJkcx9ccWGwyLkOwfj9mTCZyLueYzHybqCfKzpHO0Myw2DPKiCsfJQIByPpe17uba1hCppHjrhGgTxmeImu4OoGdAUPo1WO0ER8WigovYG5Xp4LDtxetcM/BwiTuTs3/EYTf02ruImFmRRyXcqhlmVYPZUgLrz0WEqer1aaDKt0Q/n0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vxTWuUbiz3HjMwyD2pkoFeUpebgO7CXzXTE/LOIBP9M=;
 b=MmMGQki6GBO0ieKq2sFCf8dZJU5cYRcQGVg+jrv+FaRaDM0spRWEfj/uglzcfdJ/Xcuh0Cb2RGHqZHDCWMRdc+QC7fR9mhAKUsDyx5q4mQLLGaBaxA7qDsHFp9jIs4HBbardsibF4a2XvJTTY9yTUcpQzT9AiXSicoWa69/hLlyeDo2QX6kMjdQUnATiRW9a6aPyLifudGODR2ndJrylylE8Q5gVAVeRxmitIgJfGeayR4IpULYLyrX9qwFa3GayaA+ztqAlj0JqtW1NewQn41AgT7AIretKCjpJWArrXmZbmxqBSgLMVG8brHOJ0tlccNdcTZWZPIAb7tfblfjDIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by GV4PR04MB11944.eurprd04.prod.outlook.com
 (2603:10a6:150:2ec::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 2 Apr
 2026 10:10:08 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%6]) with mapi id 15.20.9769.018; Thu, 2 Apr 2026
 10:10:07 +0000
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
Subject: [PATCH V2 8/8] arm64: dts: imx95: Move power supply properties to Root Port node
Date: Thu,  2 Apr 2026 18:10:07 +0800
Message-Id: <20260402101007.208419-9-sherry.sun@nxp.com>
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
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|GV4PR04MB11944:EE_
X-MS-Office365-Filtering-Correlation-Id: f5ec2e29-d2a7-419d-9ba6-08de90a00451
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|52116014|7416014|376014|366016|921020|38350700014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	V+PZBfwNUS62VOgc6uqWq1vNrbHfqb8LaLw6gIqSJrOuTn9LlARpBYFxBodfvyVrXzB8etAcXi53XAm0bn0UaxIbdM+Lg5J096YK3Lzr1lJJq9G6erAtkiME0lVfGIXbKxbnCM+1fglM1q4auehEM5YyZPQdGDW3xN6Uqm/UchnuUcpNOayzv5+vvifdgIeibmwVZjzkvdAzpMinCLStmfRaqxN1kiu3+tejc/lTjFBcBB5/772di2TstIgNiqDXnWDECGnodFuWysTcQMx71/A0tJqb58Vgi388MKgqm6Vs5+LDZKagMKefXqcb45SV29dEwKQIlWQbua0ostzMdufnSS/x5Wi+rH1W9PftHqBA9wiQOiop3mD2byZPPj884Sv1NpbbyJYDzB8ud/k+63feLgoVIa/DPVte8lCDjl7UUDXO6aeOG1BY4R0gCEURHXdgjHS8bNH+DYpE/69E2gADkVEEh8OskaqFoLYqGJGhrV3WpokYlV6bvRCerGWF50M4yLBHJkv54Y57BTZrXW9mufIllxxRYsuRVdUcVJC5IFrZ5AHKC3/X3yt+95QlDX/IxK2L4zOvCG5uLxyzlFKEmAGpi/wtHzll2Q9ilSaZeHhEoOM3rIvC5FXgATQwFg0k9XlXyVvaarQR+xSkOARjNxmiwZf0d7D2ug01wQV/lwLtwFj4YuRM6wucjwVdgjQZUwAbGzg1+f6ZI/1r0mTc1vvhszy5CNEuED1794ujVmOP9C/WLw6DxxPwIjdf/j5szZR2y9y8zuMF8bm4ww3Ny5N4OsrzqXoiIUO4LrE9ywU4aDCRcFpwK4GffTmk
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(52116014)(7416014)(376014)(366016)(921020)(38350700014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KH7ZEpMlfvzgSln2nrJ1dorA/slA5vpPXGfGCqnWpNgZLDWCEMTtzfzV0wOD?=
 =?us-ascii?Q?O6NoK9ffn3DdZgdGB+XopLwtxxHkTUAK/DxAwI/GRRv0rsbn8Mbx/hKjTTOp?=
 =?us-ascii?Q?g0dwp7iikQ8HQn3ysP53WXL4rMImEyl1hcs6nhjjXDxJmgFtSph8TuzCHHH8?=
 =?us-ascii?Q?DKiWwCDwVvjvFyxx2PjDE7rY0U9IeqKdQ9TPASuM8InNCA56NTQYuifbyKAr?=
 =?us-ascii?Q?pOdxJqYtw3A/kEg7948lj4nuZr7uYOO58OSB4feZwFSCpCwd66p88eoPMAf7?=
 =?us-ascii?Q?mR2p+NzH8cSKYwXi+isIu0FI30p78D7JXrpP8sLCq0fSxcBLjibz8l0o5oUH?=
 =?us-ascii?Q?FcK4NXnSqDsj72Coq9v0USpO7R3RE53COCyA6R9Ves2yFMXJJVKSH8gt/jWi?=
 =?us-ascii?Q?+E5sfY7Tp4D+OXB7PMeQxnFUibXlYWrsGE357ihdWF3KNL7BeqpiyFwD2jlv?=
 =?us-ascii?Q?V30GgEfflbs/dEYbFnUgxp8fbG5zAaC/EvQjCn7AxcNwlXRGXrinhY0D5yz5?=
 =?us-ascii?Q?l0bNHb2Ne4USHC40uhwHEtGY/X/UdfJg5f2pCzwxyoIE0y9g/siZuMRPkV9a?=
 =?us-ascii?Q?agCFYmTx7ec0Mnuw5jJB3+BWaTZ6C6m2cVEJgxfrxW15eNVtpmEyMM3UdK2L?=
 =?us-ascii?Q?EKyUHHpeDATfYK+l0IbMsu0OO9Be51zTmKsGBwouJz6cMOhxbYfsGNOl3MR1?=
 =?us-ascii?Q?fBbag2ffg1drWd65p4lAmPmYkdTGuFicCQiyPKE3euqwxdZNd6OVZkf/8fy4?=
 =?us-ascii?Q?Xft8Fb0yGDxpI2RKVvfB9YnDLKDaE5PxF6zFOkN7K+yzp9upOdzrnut2+qfw?=
 =?us-ascii?Q?X3/1zPtrPXgGTCotumBh5JuBsNTFTAfXWA0yNU33260p6flQdTPwS+L2Zrlp?=
 =?us-ascii?Q?Ondn1b+odD3W3I6ZLfFJCrLyBeKJvJoMangh61vHdxyfys13dK/w4atex4N6?=
 =?us-ascii?Q?6F5j4cvCO0iaUSjt2XQ7W2JK7QJfg15gJMgBBnO8Y7BwbnwQASJKDbRHAMLk?=
 =?us-ascii?Q?U+UAUZksxyf0O/iVPYIkt6wQbkQFBaZBRTU0LDEeP8UQ6IzlTVvCYNOJ/VIU?=
 =?us-ascii?Q?jFriYKmTF+2fLvM6Z3irkAvFSGB5U30V1KBc+c7whBdgTDk2E4RHwhfe7fs8?=
 =?us-ascii?Q?29+LVBmcrM41ajq/CaIt95q0Z5Vfeh3ZjG1MzrMCnD90RnC7L8MSq4lUQsap?=
 =?us-ascii?Q?1Xh8rFL6rgNU/yOqVQ2Wj8yff5DskxpG+FK+lIteBoGbv4ZqywBru+PCpFR8?=
 =?us-ascii?Q?dn8GZQBaGmIGnZAw6WtJX1CvpfHom9/FFFJ9TQ9EgjwsIUXYRSNm8uNsnfNo?=
 =?us-ascii?Q?m/Ux2PQRQ3Lg/znpLWUjMyGRqnNNCLxCdJjgbgrbf+r8PuTLomgC5rUE+MKK?=
 =?us-ascii?Q?/h9y5eWtpQ9Fg60K3+g7/9GBQtm+aHmPZX+JNdMOt/XWyDDHeauzbClxwX0g?=
 =?us-ascii?Q?2YYjhdIKJ2OH3ygzFVg6Sgaq4IgfNbh1cQz+CPPGhld0gEIxQWYkHGuqstpA?=
 =?us-ascii?Q?q4lxSojwz+9Lgqwzu4IJlMSUrgL6qZllUy166jo4GYbcNo/Gx/Yi+X6epyTX?=
 =?us-ascii?Q?wDa73m3S5VctAVqLNVMsA1O8+y1HZAXVQXURwZGtAgAZWVJ+YiaoqtI96Mk5?=
 =?us-ascii?Q?30I23vUh7ukBhCq/lSxkld5Xj0IXBQn/CogbrxiKZ0kgwhwwYkpk9fJxAIzB?=
 =?us-ascii?Q?7Srjr6qOnMzu8UYo7Oj8ifXCOrHJ08MkEZLXa7rU06Grxutw2+V4k81BPxRi?=
 =?us-ascii?Q?EfAh8OPdCA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5ec2e29-d2a7-419d-9ba6-08de90a00451
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 10:10:07.5568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B475eztOhF/TeCNPNzjYalKOIWp36QttmXOnpFfC3EBa7TWbV2b9NWt3mDOthDrjRHUKd35sXlMSmUBYcw8RNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11944

Move the vpcie-supply and vpcie3v3aux-supply properties from the PCIe
controller nodes to the Root Port child nodes to support the new PCI
pwrctrl framework.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts | 4 ++--
 arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts b/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts
index 7d820a0f80b2..0d1cdfd54cce 100644
--- a/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts
@@ -555,8 +555,6 @@ &pcie0 {
 	pinctrl-names = "default";
 	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpio = <&gpio5 13 GPIO_ACTIVE_LOW>;
-	vpcie-supply = <&reg_m2_pwr>;
-	vpcie3v3aux-supply = <&reg_m2_pwr>;
 	supports-clkreq;
 	status = "disabled";
 };
@@ -570,6 +568,8 @@ &pcie0_ep {
 
 &pcie0_port0 {
 	reset-gpios = <&gpio5 13 GPIO_ACTIVE_LOW>;
+	vpcie-supply = <&reg_m2_pwr>;
+	vpcie3v3aux-supply = <&reg_m2_pwr>;
 };
 
 &sai1 {
diff --git a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
index 6f193cf04119..77c3a87d9065 100644
--- a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
@@ -542,8 +542,6 @@ &pcie0 {
 	pinctrl-names = "default";
 	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpio = <&i2c7_pcal6524 5 GPIO_ACTIVE_LOW>;
-	vpcie-supply = <&reg_pcie0>;
-	vpcie3v3aux-supply = <&reg_pcie0>;
 	supports-clkreq;
 	status = "okay";
 };
@@ -557,6 +555,8 @@ &pcie0_ep {
 
 &pcie0_port0 {
 	reset-gpios = <&i2c7_pcal6524 5 GPIO_ACTIVE_LOW>;
+	vpcie-supply = <&reg_pcie0>;
+	vpcie3v3aux-supply = <&reg_pcie0>;
 };
 
 &pcie1 {
@@ -564,8 +564,6 @@ &pcie1 {
 	pinctrl-names = "default";
 	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpio = <&i2c7_pcal6524 16 GPIO_ACTIVE_LOW>;
-	vpcie-supply = <&reg_slot_pwr>;
-	vpcie3v3aux-supply = <&reg_slot_pwr>;
 	status = "okay";
 };
 
@@ -578,6 +576,8 @@ &pcie1_ep {
 
 &pcie1_port0 {
 	reset-gpios = <&i2c7_pcal6524 16 GPIO_ACTIVE_LOW>;
+	vpcie-supply = <&reg_slot_pwr>;
+	vpcie3v3aux-supply = <&reg_slot_pwr>;
 };
 
 &sai1 {
-- 
2.37.1


Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013002.outbound.protection.outlook.com [52.101.83.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBDD3C456A;
	Wed, 25 Mar 2026 11:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774436599; cv=fail; b=JJ1sIvKp59btkX1V+GzGMUkMwYHBO7N4cdvj2J52/VhPspgJ/Bkww0qnVcvaxD4KI+7UviP6YdPpqBzX1C2yU3r8ikxAOPGDPc5ievpUnlEV7MgYFZWXQNXkMCKizXnh3N14S/dWLc7Y4F6yiruePqrhAgL8ZIAHhI/uFswOCrs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774436599; c=relaxed/simple;
	bh=vEZPjcT6pIToiMIHifIprpaCRTmQNIzLtv3IGJviNgI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jCzwDVubmMLTkYm2HSPor6Rscl18DB7UvaBmOO7FfwxQSylSPho4L5bHQiVyU1b4xlyRmdYECOt6GekH3rO63UdaPcERU4y/S6xuMOPmDDMnL6BGr8nXUabnZqTST1nP1oTPJ2NxInb4sirU1ggntU6MKgeq5BDB+P5NjS8edhU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YvxmOhtm; arc=fail smtp.client-ip=52.101.83.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YvxmOhtm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k4bRY6T6gu8BULu/k21/rZkl0uWNTMlI5jf8FTBHqqe9i9R2BSV8ZFJEUYgspqdAjLo9Vm5agj2lgsoe9/maYfpqB7b0O/MW4do1mEPngEs2O5CGEU6nXaIMRkCEpgVkCIN+lbLoDsS/Hw7yL19BJKV8yxjuDBFXS7FugyxH/acNtcgrdX332gvHVDDqAdh/k1CBJ/K12HIaXlLcWjvz6QSPSwClMq4Xa5BjjGJNy5K0f7uVkRjynyx6FqxUktF4SY+Tf7vg6ilX8pf4WBgFKy0fxSuywSSytfCVh6Kzi5RZdFFjUjvaeNAsguAFcMauUJy+c8GmofL4LojnLxrXiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vxTWuUbiz3HjMwyD2pkoFeUpebgO7CXzXTE/LOIBP9M=;
 b=EccySJ12JNErrFz/TIxxyrIJoO8ecCQFOga3wB6gOoE4/xGvEkZCTf1IWGKarIMgZhucvELnFiwTgNSWIWv8bIi5GvbZSiFTxFZi1rm1hDRjzVgXvVeRvJigUKFkjy3tk8SgavCcCpleVsChK4ScyqmX4bMYLg+Oqd4w/MmfhhGvGeM/LXBl1nplyz2i9njjUxS7CDJwHP108ZZLiIwUNhattIcGcIo+BFrir7FvDpnViM10UOq/Cm/trrP6a7MNBqGkAhh1fVEXMOfDI+6iJSBMn7clWTXk/SerQYC8aojgYtg5tJB+xpTp9qjEp92EEeYCxesi2B5EIuPtlieS5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vxTWuUbiz3HjMwyD2pkoFeUpebgO7CXzXTE/LOIBP9M=;
 b=YvxmOhtmTL0CJz0U89KCJFtsSqLTDoFDmmmkXH6yFXcwHM3i6kFG6sZu2wuPMBzAwSei+QAHsmkBYDrI4BZ05wB5IomL9WRYzLkF0oPDztTtLMogOlEYgJN52P8MdT1sIM0isGBi8zQkIFNFyJkhNiOoYmz4/4poTaZcJmcdizuOJaci9pYjACbP+WnniXWFfcN05suaEhOqQp46vGyPU/XIj7Rs/xxOMDxGqRMcMxeWAnzVuBd8C5T1qI5wTIKGUyfTI7SXLiEREKyrq+QRVt6WtTwhO3G2O+s/Xkl2LsX1F7It1bXxdj7/q3YJTbwhLJEdxq/BJ41yi9X9ac9VGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by PA1PR04MB10398.eurprd04.prod.outlook.com
 (2603:10a6:102:44d::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 11:03:15 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%5]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 11:03:15 +0000
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
Subject: [PATCH 8/8] arm64: dts: imx95: Move power supply properties to Root Port node
Date: Wed, 25 Mar 2026 19:00:58 +0800
Message-Id: <20260325110058.2854742-9-sherry.sun@nxp.com>
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
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|PA1PR04MB10398:EE_
X-MS-Office365-Filtering-Correlation-Id: 8532f476-0f76-43fe-4da4-08de8a5e1cf1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|1800799024|19092799006|376014|7416014|921020|38350700014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	Oni2DNOVi6s1fABGoNMOu1RCy2JrN1heDUi1QbCVmX0fCUdQFmCpyZQOinntcQkSu+rz/PQW+93XoNYbxtPa1ykDi81qdKfzbOvhuQwoKwS+v5Sme3GgQTnHeQwqHmUNY11J02/A9/cML2gwHGe6a8XLYHlIHCN56oE28JWbPBleEIS5B7N/pO6DIGeIO4NBp8q56uSRjnKslnzJZJOXHAemz4KirwxCJ3Zx9nDTnT9frFqpQjsQUVRizS2UjGW2ebjmC+ou1+gr1JThaJOiNfFeVvxXAgqqp9hSDji2JsWA8rNk0QHGKVVVOJPliituQpWNCeX8g0CWhXRnse/4Z9uVMeFF51zEp2i/vdnJnakZ8/2/6OW4P2FNk/an3Dllv8iCFS3myksNRg1F5+kCpc6ZGCiErUYFGwFcP035/6L42GBcqCXVV47/kIfSDq/llYUgREO8dLwI1g5cU7Xjcxi+fu5gha9Op96X/r6XoK+ms8mhjnbqGmT0jNIwrf9W/t7rcpc/B4+ilu/BbjufOMpMu21ccqKe+mmE3zLguuHF9kpNOcaKnyDGYqZj+tHrRHq1pp+zJBS9/1djzpq0uxDnkNx+QyStxUqG14bYrbTNwJgoKC1Oa7ewFQepa6aR0uR5e8lD888M3P2JNFzd/Ln7ryhSxr+B9mdD5b+7dweTc8MyLoAuUU9WUsJEyX9cChUPudQvOiSw3rDcMAyPoncLSl1jV40S3ywiL3EM5iL3SyjlfGEf7G6+jVuJHxLhtNIVWEJr8uBVnO5/zz122syzPWxW9CTvS5DX5g9APvWnmdGId2jQZGZnFZuCnFPp
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(1800799024)(19092799006)(376014)(7416014)(921020)(38350700014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lc3VAaQzFKR/JwNpnM9eK8PuzvUY9dWDgnsi40GIkw6u2Zhpuz/JaOPsoLQ/?=
 =?us-ascii?Q?+jjbUOCH9/4FN7MyqskzuVy3Wzp3fRfau1Rfn8op57mbiR2Rq8Plq6F2DNlI?=
 =?us-ascii?Q?nQCDY99UE7Lfj4IMUEzD5V8J8cnK19ih1CPFUo1MH+HjVygnRzuDPdJbP/tc?=
 =?us-ascii?Q?kXtB/+lRp+M7fx9uM5Gi0/Q/20BrjyFJsXyhca352k41I1iwyPPc4KdMZv5L?=
 =?us-ascii?Q?o96oL9UBrPpmL2gLA+OaGyoF14iJZLXGSnGhLL5MfE3rtWU+VTv7ttkh8nXJ?=
 =?us-ascii?Q?kOpCyRcakSpLD+LkrlnHpzxePRJZtYc9EdfVrUcUJ3qBQzR4qEv5RJqhPoRy?=
 =?us-ascii?Q?w/bcHwHqgS2HvUyJMw8pwrUJ0P8x8l7B8CV8LgoUsLCrSu4Nv5j66eONc7Jt?=
 =?us-ascii?Q?84Q8K5P9681sMHRh56BNuUChBoXGZAm0YMdBNYRiDdlNHpaI+5vMhMXglu43?=
 =?us-ascii?Q?qOya7RCCVwwlWBtmyx4lgky0HlYsQZHRKraODx2ZXVgTYV35fMK1PWP2EISf?=
 =?us-ascii?Q?wfOuHL2/XTTa6uCeR1JkzeHQB6zdAo+k34vZ4epubukwiDRk5IapklJMHm4b?=
 =?us-ascii?Q?kMfgqa72Kk94isefsl+Fgtknrhbpj00pdOZeBYpnYdYbRhkC4BeLaHz4IIdl?=
 =?us-ascii?Q?A6mujfQP51Yku+jStXBGPWusQ8Y5U8rdwea6b/FDfZVU7bbhJdEfcHldDrJ6?=
 =?us-ascii?Q?z0XhoCkn7Jb2fus9JElPvlQo+lFaUwM5XGlQMMC9qGuiWGMZDXunVDH/AWUI?=
 =?us-ascii?Q?UxJhzcnZvpIvQ22oTPxNaepvBKLKSlnKdxVTaFJkKfYOzVqK9J90E3H0gS38?=
 =?us-ascii?Q?gcygs1T98cqqVFJEt9PPXdf7fez+9x0oLR/37ftHrUmOY5ywnK8xD7EhX/nI?=
 =?us-ascii?Q?HiAVs7g7GPAmdxhtayJS4DCIdJCyPPqwV7WuHHmUN7CbjhgCazLb0WV7WRHh?=
 =?us-ascii?Q?tCDOTTs73wDpzEhijM/1fWb8AJK807YqGiziquIJTy2VabxuSuiWRmeLMPdV?=
 =?us-ascii?Q?oYxqqcqaFi1V/fCkXxhtHfeWs+Y2KbcGo1pgyik9jmW6rVwptr/1YjaPjwZD?=
 =?us-ascii?Q?ui0ENTycK0sfeg1CORqRcoJvNb9fLPnGIG94vICwq5YtlfvbeWxIZ0tLgAxi?=
 =?us-ascii?Q?FXBgrs3etLthg4vkO1lQkUuVc6OoUga5ffyrZ9dan5TIQWgXWIrU4SJdpcvz?=
 =?us-ascii?Q?TpdAso1jacpsNlxTTIbIDnOClYkb7HEGZnVYpfv3x3xuO0E66mOxiV4qs40I?=
 =?us-ascii?Q?q7TudFvd8R27ixiDCo6kQuB6F/E1tlF9FgW2giEisIT0Bn2wiai5fmN5WRzB?=
 =?us-ascii?Q?xAZHR+b5xCgSA0aneCv+RvPHV/bbGMWygDVBj1ebKwnKTGFvwIONpJoOG2nQ?=
 =?us-ascii?Q?OYhPGrIcWVxdo+Djr2pkDO6Xhc4Yg/601wHHWrR9W0zq8q38nxKn/kPrszSE?=
 =?us-ascii?Q?xYQlevrY36JmSXAKUGmqBpFdbBcUcIP2yq34lb0UkhXx73Vgfsj0XPQmMe/O?=
 =?us-ascii?Q?Rofxu2/aGsm6WjbMT7iE0JFO07/jJGwB2UycZlUf71WCVA0Jwo4hrsaM+nNU?=
 =?us-ascii?Q?kazkH1B6mGJl8yrsXu/gvKkjo1opqIKjsrdAnnIlAf6DEKB6uaJ9xkuvBjvn?=
 =?us-ascii?Q?JBj67wuAvY9PXq5MH0ybLDF//OVl/JBSd5l+45YkVlaZUV9HefnmcJS7In7d?=
 =?us-ascii?Q?5PYmeqq7hR5GOrFQuu72WGOXDNBbGHxqSjrL6ovyb/WvTDr+InIKc6qwa6Fp?=
 =?us-ascii?Q?TYT5C6H4TQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8532f476-0f76-43fe-4da4-08de8a5e1cf1
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 11:03:15.1194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CmWXleXsGdt80UVa3zTrU8EizPeDcebZDBhCvOcBe660mlpLw9F8JNb59MJP3qT2A1ESj19Nr2pNjDLWuB2C4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10398

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


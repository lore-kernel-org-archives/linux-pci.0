Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011004.outbound.protection.outlook.com [40.107.130.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9F83EFD37;
	Wed,  1 Jul 2026 10:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782903061; cv=fail; b=DJ4tj9xYfjJUZVBNSzpjoB//sLY3d6GhPiR17FIX2NbIy1seI58Jaym/esn9xd5zVw0VKdDO6NUywXJxkUjPl0jps3ywETjCgsbQRrCxyOEgsHSUQ0EDA+hPcP0HJxkDoB0A8ERMwajMeCvKln81U0QWKEf+zQerR6KeTrMc0cY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782903061; c=relaxed/simple;
	bh=taBtW47m4iWEm8svK65qhzW9LU3sHSdkEVZ38eKCZXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V/ywHmFwOLTDpzMmPvTTFEXftmQxzIsxj+wbzaQunj2fg6hUHc/gBsp3NMa4gEzl/FgOqXPqsaMiZ3VlRouAGmUvuXhZ7goJwyoNL2cXcegwLh2iUW8hjGZ6CHRMJoywRo5yvoU42LNYvP4Y+2Bt8n+pjFUXavYRvKEzs95A4AU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=PWxbReER; arc=fail smtp.client-ip=40.107.130.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="PWxbReER"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JEvkBjyviDXPcJYPunP7B848WDcXo0WTFe395zkvtVxtKybNbdlK/PZHfRE4opccxwEmJ2UMvb0+wEv7xjgt37ME3vVfI35gQZOtMRLznSgx98cDXivDtDptlvyj2ijxGBCrq4uxUp1rMG03iV6zReCrIP60AiW8LU9/9lUtEIiGy0f5m9hARdqAwq/RubjFQiK8tAaeq+UeBeQDjLsoicxrlta/ZkWO1h+K0D54waQlZB/UVVp8uV6kz8l79FpDmdSohGwX/dXXfrtv8Lnt3Gf7nNgUaIHQKVTary/4weIGx3bS+rOhowqAxwZnmyD+F+wQhWyoUo9wbC4bPT/W/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CJqD4jYQSuf7eHPRADE947ccBt7tQyNghDeuCp7Bo5Y=;
 b=FXuTu12l5o0qTGV2odvT8OBiGHioFq3DT4L5pn+EPKUxTmPVW+vDmAzMC9zIjH8pxHbXoh68KikH4LDSDKyQQdu53lJXqlMeTCmpQOVKevYKeCDrjas9WKcD5py16gSMMBgBf+otZfb12J3XP6RW9TbfXVTHtO4pL1DchpUpb/xvqIXxEBybMTJqL5jlnOsc0NGeuFRzss9jqvHefVkBdll7isWLF8vaVVGPfnXNkDLLDjHg8u1O3WkJhiGke1a6lPV7bkBtVZ/f9tIzLux1EyxXEtzCjEtJydxefKsMrTarNqPGe/xqiOHB1Jk7B7wNWJC/7vsdOusWN+qSwXhkNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CJqD4jYQSuf7eHPRADE947ccBt7tQyNghDeuCp7Bo5Y=;
 b=PWxbReERCBXRSVfwpbLvkAXgIVP228vUHjqTZfvSxn0onde577IoqF0gU/WEJeqg/OhAX2PBCyL2h1tTvVATY9sk3YxHh9tAgXP4VYScQeWpP/PXBxgSUaamj+WQD2XHirZ8zkL94iMcFpt6VFJvHMEP3LtriBQXrjslJCzha+71vAZC8+wrBEyjN64WZoYOsE+Deh8rYce45NjoObFbZmaS1MX+s6uOawlwq5OkqWrsCk2B9eUnuIvz/l1eVHk32YPmEaL2RQTl9sr/s6gHWmM0Mf4NEIQK6SkmXbBaXQjaUsz3FDdFUMzzmy9APqP0XAxDrTpyAWkHK4xyun4B+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com (2603:10a6:800:296::7)
 by DU6PR04MB11229.eurprd04.prod.outlook.com (2603:10a6:10:5c4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 10:50:56 +0000
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be]) by VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be%5]) with mapi id 15.21.0181.008; Wed, 1 Jul 2026
 10:50:56 +0000
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
Subject: [PATCH V5 3/7] arm64: dts: imx8mm-evk: Add power supply property to Root Port node
Date: Wed,  1 Jul 2026 18:52:30 +0800
Message-ID: <20260701105234.198987-4-sherry.sun@oss.nxp.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260701105234.198987-1-sherry.sun@oss.nxp.com>
References: <20260701105234.198987-1-sherry.sun@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0047.apcprd02.prod.outlook.com
 (2603:1096:4:196::14) To VI2PR04MB11276.eurprd04.prod.outlook.com
 (2603:10a6:800:296::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI2PR04MB11276:EE_|DU6PR04MB11229:EE_
X-MS-Office365-Filtering-Correlation-Id: b62959bc-a52d-4a74-ef8f-08ded75ea117
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|19092799006|376014|7416014|1800799024|921020|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	UhlfE15nJ6e90eeJFHeuy5t4ESKp7yxIW8dWpLodqf09PUbaU+1QZjEF/o9y5HDnco8Cur5xVDGhltpqIFXRe1+CSPhr2Z4J6wKL3X0RIrH6I/1+nyrRWt1PSef/nIGubPwnip9aiRTuG9HC3zVxCQV1c5ugUE6Emz19xzpZXDfU9lxMX6h+z3B5dCkyqmXG3bl/iPUchVQ2zVJMcubtLFY4/WUsKvQEV5Jj/ezVfeXBoNrRtlKRNTRh6qFMXHI0TAqIaKi/p3p48jEG6QjS5X6YjSazuFF5h/iqiXMTbRsaeo55DT7DzEXrrskPMNctjb8Y8DHeqOdi7/bjaBCIpTVcqIBtfHn6EkwkpKb0e27t7Y3Wu0R/sykXDaFDPolXZdIvxNBMqG+GGRulrs1VzvfoHabD+zuUXcA2GCPUCJBow7wHxOIkNjvO2p8MruJPMagPdtih8/GlnQrdSWaJBVnifvg9JjrbTC/q1ic7t89xML8AqJEybXuric8sK1VMcQvuqDg2MRLf3kW/969L9qb79iTPjGDLjZhA2qWAoY2pi0qJCqrWX1YJmEnyaUA3/4I31hmPUpW02PgHMh2VxHHxST//UFX+OFFqPJ/ea0WJnqE6wITCugzm+Lhqy6s9I7nYfpHIvVGlbFDqsTO/zFak/Om+D/9fFLCxwPawQFDzv/f5LgCx0FbNX8R2XRO/73dxSKeEeU6hH5353ZQoTg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11276.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(19092799006)(376014)(7416014)(1800799024)(921020)(11063799006)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5nkF/2pI3RitzjNpcF8jmxasrOZWqS9a0kBbNfq6wNBpw/cWOv65zkibB5NQ?=
 =?us-ascii?Q?/YU7jMBvDoQvsjgpHMi/6Za4KNxkfJ0CXPiIpL5TPGcJjLJk6d4hppUFhyIY?=
 =?us-ascii?Q?SrkXzinjUY9lfAKiFsZIG9F3d+mwEOmy6C2EdQ9Ni2wMEu2OgSk6UGE5Xn5r?=
 =?us-ascii?Q?7cJWxABcbowcgIu05/klQFj3jKJcyLd1ISxYoExElCh84vi65lUpZb1AXzHt?=
 =?us-ascii?Q?dWyMnfYUVkUsO5Nirh52pV62nD8Ewf4n1BdoIQhKoekN1nTaHCFo9AvKHS+7?=
 =?us-ascii?Q?Hp0o6bcPWBdOq2Cwm3Kmqfz+Q2BoXivTs8p1NE9zINjXp02MBFUNCSSHLWxG?=
 =?us-ascii?Q?s8z02PwU1WgMqx2m0wHZjzprSsbyErOgbWvxQq2ZVdWRZ0VJ+xccMACIfigg?=
 =?us-ascii?Q?KYuxTp6O+4eVmnFd3abkcpFkHnNcRgJKRfvx3NurWJ9ZW5BXvRaUNtrnPvqV?=
 =?us-ascii?Q?sKZlQZ7jEnhEhUjPOa0tsGvmOwtqrQV4GzeyzV3h7SQH9uqO+fKSPJQeI5Pi?=
 =?us-ascii?Q?v8sC+gRZr6leSlx8HcYf+0jMrIMztdLJT8QK8ZlV2VxeGG1TPMepB/IJTavP?=
 =?us-ascii?Q?rfXm8aGYrP6pl7CchYY4hrzkNzdjx9pCcy+TLfyhtZBP2/HbXpg6oYlZE4XU?=
 =?us-ascii?Q?WV8TAgV7aMFb/XBNsjPV3exWlPY4BK0HZN3LROVMDsaDiYIGp8+U2q+hrBPh?=
 =?us-ascii?Q?dy1p4HkTyc1zDIYmLD+7tq6L03xDFnLdxz15BkNDkrWE36DhIqn0nzxfJbo7?=
 =?us-ascii?Q?X02p93LNJVsGvpZS9bSu/WmQjN201i++sSeDvGVOlg8bpOc3gSjfFwwKk+du?=
 =?us-ascii?Q?x7d4AUhWwqKfB+HEzY2fH3opbaFoL6DcZJWiQhu8S+UaRxhtodeQpOWfdXl/?=
 =?us-ascii?Q?mQZYOXdhaUX75Wsvr/jZGqfKDC7m+QEpb4E2flwWznugo6QWprgoP/llXwys?=
 =?us-ascii?Q?xK2goXTdHKRu9PL2iArTR+4jhxmL2wR5esLnA31bQI/RY52CumpSJvOva+to?=
 =?us-ascii?Q?DmSwDc/NSiBr+tjS8FTaSwQZENWHB49Nqib825GgkglP4SshuQz2DfY71Eeb?=
 =?us-ascii?Q?29jU9H+HVzRdWa9L3rT/SqQT/oQ1oWA0j+9kMvytDI8Wam3EGCiycRwtx/1g?=
 =?us-ascii?Q?lLRq4q38WUoXxO2jSDDQkFcsVKJWVUXgpzv3FYaSJLmX077mxj+kmxUx6gYB?=
 =?us-ascii?Q?/EuqUdXVrdWPDj9+Ig6V+iUBDF52hbRepLTyl5rayEfwxCMkZWHTZOdCuEsj?=
 =?us-ascii?Q?Q8h0FZtp4eWP4weTgTCOm3jCyoEslMGAcbk8NBhnHzcTregXS+MCXbo1HXS5?=
 =?us-ascii?Q?rBUALUPdy1ZbJr8m4sJarcnslPrg9gG5snP1LDDlu/MhBXCmhuvNnhqTidHk?=
 =?us-ascii?Q?jbcd6YibU9/YIghpTP3yAGznDsaHI+abKKDoGMWhnuTAkctAXJdma+zRCtl/?=
 =?us-ascii?Q?UqaHvYxDxRkFc/bvRJ5iJocNS8Ph/ZDdFSEHFriMeKnz81PD86+Y3UIiUYsU?=
 =?us-ascii?Q?1RDWjrsA4rsmsg8PbHEkRBb4/rHMNfWX6nP9mkat8g0BJgrjRgLjO2f1uTXn?=
 =?us-ascii?Q?nRC3PlFVvjpfWDzgr6qPwd01+vkWbu4tnQ7e956kDcI6lAnn7TaLlWJK76fF?=
 =?us-ascii?Q?9673U64Fv1t5G7TY+LTajmmW34Uj4rh7YT8ROquY2H+rxj/8kIQ6t9sbb/t8?=
 =?us-ascii?Q?/9HAqjwMSCU0UuaPsfF51zFJbpnSE9X0UyX0pqC2Axrfn0yFxY65sPpWtoEe?=
 =?us-ascii?Q?oMsJbj2GlAxrE+ODWh+YwdXFL0XVccsHa6Me+Xp8q2Ur5ik1vzcx?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b62959bc-a52d-4a74-ef8f-08ded75ea117
X-MS-Exchange-CrossTenant-AuthSource: VI2PR04MB11276.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 10:50:56.6155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hYPyRHv8nN9XAzCQvqUgjGfDZdi38AUkO1drWUJyTO21/SS7dWSxquQZ6b9ABbJ2dbA5YQxHVN9HrHipe5O3OvcK7hQRwMco4/32KdbD/ZIc1We3GwivnnbMYn/TY+eu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU6PR04MB11229

From: Sherry Sun <sherry.sun@nxp.com>

Add the power supply property to the Root Port child node to support the
new PCI pwrctrl framework.

Legacy power supply property is retained for backward compatibility with
existing kernels. New device trees should specify power supply at the
Root Port level to utilize the pwrctrl framework.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
index e03aba825c18..ec49cbbfd9ce 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
@@ -542,6 +542,7 @@ &pcie0 {
 	assigned-clock-rates = <10000000>, <250000000>;
 	assigned-clock-parents = <&clk IMX8MM_SYS_PLL2_50M>,
 				 <&clk IMX8MM_SYS_PLL2_250M>;
+	/* This property is deprecated, use power supply from the Root Port node. */
 	vpcie-supply = <&reg_pcie0>;
 	supports-clkreq;
 	status = "okay";
@@ -562,6 +563,7 @@ &pcie0_ep {
 
 &pcie0_port0 {
 	reset-gpios = <&gpio4 21 GPIO_ACTIVE_LOW>;
+	vpcie3v3-supply = <&reg_pcie0>;
 };
 
 &sai2 {
-- 
2.50.1


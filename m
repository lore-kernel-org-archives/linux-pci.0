Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011038.outbound.protection.outlook.com [52.101.65.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79BF387375;
	Tue,  7 Apr 2026 10:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775558545; cv=fail; b=hEQLw9PXCk6cY81zm5MpiOYpAcrZw0pm6Uq/FZH3vyngFCu9Lg4h13WocZkGpmYg2qu2jV6lBWTATX8w+bxbGrolr4s7nPagSc0vyyXttma6GkyV4fGD9xP9BjadJ0ouX+Nx1Myd61djyuYoGtg5TcP5wkZzDsW//YJijx0ZpkQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775558545; c=relaxed/simple;
	bh=A6iRAkqRTnQwRrqLsS8rJAbdrZY3jnB8fB01H7L3KCQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fsQNOJag5Gb8j/yHrhEAQk9XgOMywj3rIBGVCQuMhR3YuRtysr8/4cXx3xdTce3SUmZPMPhg9AMO3h/kR8iIQcjIJQ6sv22s5woNkLgRDrCzJJzfzuBkb49wDtV4X2H0LtFPEPiqALmkAOx2gcugtdBLBHqlXo3C5MlFhldlKk8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=aLS7wSeP; arc=fail smtp.client-ip=52.101.65.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="aLS7wSeP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RJ0iQ+txZQlkwW3U2QEePxouZtTzY1xLnHXX+LMWBQ8sQ1hkg2FZZE0mpjI4WrpZSMcPuYdESMEXksog7h+fUAuY4pfLLu/iRnWWQQta7kGKWWpPMOA9F9sLKQN8Vj98dX8Mb15eF1ESURG5Txjp/t6LyMNDc/tHVGqVl55R2Nu2RDke4Ba3XO8mj+i/U/kCje7EPWFJ1AEh2Pu5vV6WeuecG3Zf265apEUHyYLl85OkFec5EOE3L0LSSOOFFnOVmZ6GloyxoxVTwmyqtyVz7BjPZCcD9Qv76OVxG+QldvldzDiBofwV+ceP06z0YbiG7QNG7YsrR6rCmrD6xv9kIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d5tYCDpWv6EjTF2fSdSpZ4GDpJKWb1qXmwlQ8MhQsyc=;
 b=zLq66a7qyoliroKvQANzkw7DQDA/J3LEUBTS5RCpd4ZfDahs0N7UYS+Sk+cYFD3oZmONa6yly4BkvFis7mqQGQzownFCjYjhbU/L4MmauBDLyEXS6jtqG6UiSid39qdvadX+0/7lQK4/6jDI8Uo+l3/+hLgzfYf6Tna7SBYYCJ//Osb+6DNe8ms82FY7Vz7opJiLh3HRDXTCJs890of/hlOw/MMcL5Ma33RRUIrtM4ldVNeOmEwa2pEkoUmw8ukICTxHIz315NHRStmQfEGiTqhe5C0+0aouVxNdB2y1m1qcPldqimj3nDYt6K/agHMovFPsRv1XuWjoLkDkW3JjGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d5tYCDpWv6EjTF2fSdSpZ4GDpJKWb1qXmwlQ8MhQsyc=;
 b=aLS7wSePEtfCPk2Zv875+VjebzpWjehe0gpQCju0X3D3otyHoVgte9I9aCPze6by2IuF3WQJo1yFEyJ8DWV4n9fe9UzI4L6h16qIRLFJRrm3w0UBfFFCiwyeDU1Bnh7QJPqUaFqYCwQcwFsbDrb71aLKgukcmWTsgyBvSegdDqxKtXN36EQPhnUO/jzYnvueE7FsAeU7U2tQzK6hnSUXdz4N4INkKUxKkvGXas/aj6HrRv1QPRjBjfHlezzJzavjxIXXQZdVeanexC2/m2C0vw5BjclksMuDjB8QTKhSKqg0NexbDl8dnSgHgn/WlGvif9X/+Fjg3V6hIAaHgCeE0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by DB9PR04MB8281.eurprd04.prod.outlook.com
 (2603:10a6:10:25f::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Tue, 7 Apr
 2026 10:42:21 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%6]) with mapi id 15.20.9769.018; Tue, 7 Apr 2026
 10:42:21 +0000
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
Subject: [PATCH V11 06/12] arm: dts: imx6sx: Add Root Port node and PERST property
Date: Tue,  7 Apr 2026 18:41:48 +0800
Message-Id: <20260407104154.2842132-7-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260407104154.2842132-1-sherry.sun@nxp.com>
References: <20260407104154.2842132-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0060.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d3::9) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|DB9PR04MB8281:EE_
X-MS-Office365-Filtering-Correlation-Id: 3609690c-f007-4d97-d5d5-08de9492591d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|376014|7416014|366016|1800799024|38350700014|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	QLwv/JRGvNcwcfZMnXocSa0M+4MyI/eKDXtHjVQNTVsLCArbRqOfgB/OXDQ//mHZRhyb002AF5U7z8KvlDvwObnnDYostNHo++vom+2ZQpoMmlSoF+hXzkHzZfZjgeCbG1oqEAapTZcsj6TfDNaiEMjUO+JZb+RAZW8FyPzzfbf0Wkvq8rXRrOCbu9kE5tOB4ZFAsdnoGRAnplo74DjIZv388Iq9tgG9wdes4KW5FOZdYHcxHM5F3/CwLg8RD+JuEMm5rnKy/59IsY3lbJcackn+KOcg8Zf7hPH9uQz+xaoe5fIP4FKK+pKnRx/dFkg+cs4A6VjTy8BoiQFdTm2pX0AjrFs2GrmuWMfr2M1IluwkFviL6SMNmcwgKcEZGvWy3vrftRP/vPp1sQScsQvKp6IuXmurHwtK6/7bbNv25KeiCMbzxbBaUXncO038ZKWEZ6kyB7fk/XNS7xi0SyJf4F7y8Tmu23zQnvtS0f6BBc0lEItf0zIzdDAo/QX4TdUKad5eBvm34Cuy5uOnMTMkZ7m+Mx2AYJG2x8FNxGu77Q1X9zFdAE7nX1c93PWfRvB3LfhUGF9KQQpWe9flqM4MJkPGBfJnUtFmL9w4ViwxV6+IlykA4G4JPxxSqZXx/pwKfm+dyalvCnJYCkET0L9FFw+0Ch8AymejTrUYx46jkGY48uAD8jPHBk2wTpaHAQNvLEeOW/OG0hxeudrwo1adx76lu2auPX3QGXcbQgB/wvK5NvNLhe5AFf/gjQn+c/i0is2v0ovHmh1vpCoo0IhWgmY9W63rQ9kDEE6K8Ypg+sk8ps+d/tvYrps9dzf7v86g
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(376014)(7416014)(366016)(1800799024)(38350700014)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?L2JvirSGIiR2abMj0DLXqAO5UEP3YgtLlc2kNmE1cE3OUXpvv8T2jfzOxJWN?=
 =?us-ascii?Q?1YqUzYosMOSH9WetJAzqTIetFNnpflX5/rjLswoR5+1bQHXzCKUfYYcsECvp?=
 =?us-ascii?Q?xGZPj8Q/0MJpUu/JNs7IYkYgjiGcpCyiK3gJJCpTqjGIdTUGW2I6NDe/L65h?=
 =?us-ascii?Q?nxaBlEXzW+0fe8xvZW6KuqBWBb4q2EBVUKdVDK3dqurpmNj6VYih+11HFw6m?=
 =?us-ascii?Q?zzh6pftS1NXAR5FVk/XYu/cpVPPUHqPw8r1SzJkn4GABNc5ZS6NW0s2SBoRM?=
 =?us-ascii?Q?oqQsL706fOIVyPCo7oGaD7k9CF36QgHz4yjtp5b+i/dPzM0FN+ryoWjc7c6M?=
 =?us-ascii?Q?b1r6ZKD2VlGTkGM1QnCIava3roHDk70LJ1EcrHVIsmyyuccAZ8lwDw7w/mmG?=
 =?us-ascii?Q?gwll9RIrtMhqcWPYxMGzbNZvhO7JXV7g5WgYwX3e484qIwsTdJPh4BwDOI0t?=
 =?us-ascii?Q?zmKceG+6CxIfNY1KCG6sBvN79EUWUJXIDMpHFTOyhMOD0fp82jOKMQSLwgM2?=
 =?us-ascii?Q?xxaSM/7aITJxTQW6GnBfWJJThkYXNuqey42CkLg9lzIt+FY0MiwtC6mZvkFv?=
 =?us-ascii?Q?BorNDRQyT7S5oWRo7JMZYSnoCPVI1lMgbR/+ESpZCHfYbOgdK/IimLS6L7kY?=
 =?us-ascii?Q?Y9H2zf4rfqCFJdRyCX0Mu53BMoEUsC7BAmSTudv47uUi7lS4If8vx57JHdOr?=
 =?us-ascii?Q?Dm2YG6tLzDJuzGqB0pI4/AhRHJL4CGqQa/7LrgwaKgKAMugcdZoSOaR+AqEh?=
 =?us-ascii?Q?JkxifVQ3O9IEtbx0+KnhoxipdJYZEqeReBOvoMuBy2ehCK1ZKp3Y830yrpKg?=
 =?us-ascii?Q?Rm7V3Soxmj+H/rUXuIdWDfEZWKGELtDDree7m011X6KC050UiKLEti6eK4Vp?=
 =?us-ascii?Q?Q7kNSC4DQfAFUXglZgC1ynljuaB5PmdDem2LEqiWlA6dxxpZPMfmV1xzC9H7?=
 =?us-ascii?Q?45wC989F87WqTEVZaP6p5gnUpu5rWsWt/zIjgME6iMzoYuDqDwy35gwHiIrB?=
 =?us-ascii?Q?k9XBtLMT+G8k6WbRCHI74JhMbGegSFa38fuXLdToAmI5fsNEJISBmvR1Jb51?=
 =?us-ascii?Q?zRyVA8AMGzU13NuibvbLkJlJI4Pzm6VkJODZ5ap244rf0OOeZb2yPQKfK4al?=
 =?us-ascii?Q?QvhN1zjqFybwo1/pfoaDaka1MVywS0PhcwceLQTXgtEUljVe4WeIeaUqVI0H?=
 =?us-ascii?Q?llYa+4esaqvRJNwNXtA82eAdiMsPgDpGEmybin6SuiGFstRjRsy7ItUOUIar?=
 =?us-ascii?Q?XGWI6T6+Q3jPGft66u7lei1a/xU+qwh7+4+fNzs3ohW5GK8BRpAJ46B89M9g?=
 =?us-ascii?Q?EWg4YOZ72cFFO1cbNaLNsNqJOggk6wUos+MJD7H7zrrQC/7+p5P7jE2D4Yo3?=
 =?us-ascii?Q?6RF6tN90dDA51ma32hB///DSZYamhqxEgBa/mVqqTPEYJ9Uk7+y6WtsuFJWo?=
 =?us-ascii?Q?I8iPWNu882Yzf+RquZqcaiv9AEmw3E1gCAChF9z9m6PBx2cQjdfIadeQol/6?=
 =?us-ascii?Q?S5x6cc/QzrHuz5zTIxNSJEgo0FWyXLiGSLHV01s/GMwgu7bxFHq2/c1V5K0n?=
 =?us-ascii?Q?Vi2Za4WbIuAao69So9/Y4evwTQ0Ug9Kilh5GB3HxzwwLjvM+nDqpvUXX1xVl?=
 =?us-ascii?Q?vNtBY9mdyXJUwBYJW9vcVTqwsCg+7Nvy/aCB2WqK8aDRoO36WbtWTch1QXW3?=
 =?us-ascii?Q?UuOfEbTgEGs63KOJyoBTBn5cpU8uTy4XgKnvrC4xoAP8fRIT0Z3ZB4C5aM4H?=
 =?us-ascii?Q?I+3kzPCY+A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3609690c-f007-4d97-d5d5-08de9492591d
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 10:42:21.6853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lSXy0FfXQNM6OEQl5+COdaMe6jkQ9rZi6Xc5RWFkiVZ8Z7MpwXzQjQLm1ZgsynvdAfZ9zURt2It/FAC/41C/GQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8281

Since describing the PCIe PERST# property under Host Bridge node is now
deprecated, it is recommended to add it to the Root Port node, so
creating the Root Port node and add the reset-gpios property in Root
Port.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 arch/arm/boot/dts/nxp/imx/imx6sx-sdb.dtsi |  5 +++++
 arch/arm/boot/dts/nxp/imx/imx6sx.dtsi     | 11 +++++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6sx-sdb.dtsi b/arch/arm/boot/dts/nxp/imx/imx6sx-sdb.dtsi
index 3e238d8118fa..338de4d144b2 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6sx-sdb.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6sx-sdb.dtsi
@@ -282,11 +282,16 @@ codec: wm8962@1a {
 &pcie {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pcie>;
+	/* This property is deprecated, use reset-gpios from the Root Port node. */
 	reset-gpio = <&gpio2 0 GPIO_ACTIVE_LOW>;
 	vpcie-supply = <&reg_pcie_gpio>;
 	status = "okay";
 };
 
+&pcie_port0 {
+	reset-gpios = <&gpio2 0 GPIO_ACTIVE_LOW>;
+};
+
 &lcdif1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_lcd>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx6sx.dtsi b/arch/arm/boot/dts/nxp/imx/imx6sx.dtsi
index aefae5a3a6be..5484c398aa37 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6sx.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6sx.dtsi
@@ -1470,6 +1470,17 @@ pcie: pcie@8ffc000 {
 			power-domains = <&pd_disp>, <&pd_pci>;
 			power-domain-names = "pcie", "pcie_phy";
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
 	};
 };
-- 
2.37.1


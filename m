Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011017.outbound.protection.outlook.com [52.101.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E220839061A;
	Wed, 13 May 2026 02:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778640553; cv=fail; b=iac0LKuCE06UEX23w1ugoGO0siWKAYQQQUFsxQg/nV2P9QB6HV6pFoa0L08Tg45UIWFIPg2cfp5ceLz0DQVEk+wB19tYYXgmbTGjwHn4ZiaonnidMWsSbkWzBxvmANNuYkocBtnAZexVdYn/6kH00bjpK3kigdIogOQj7fDM4GE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778640553; c=relaxed/simple;
	bh=TiWOzau0DnXGtg1pC4F4XF2OrEEDihQ9hEE54aAC47M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lv1CvckagDNVezEArhom8Hq4ljDn7ehaMay4n4BdR0kN29WotAgyTVolp51thI6FGB/YAdtnUwPdLTVgNLxDxKXxK6lKxo1M++AkQMVZGzKyCregroL8idE0DbafdMehqBKylA2AKeRb+y/shRalKbLtq7I54/uPB/uXvmTrNxs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nRX3lwAR; arc=fail smtp.client-ip=52.101.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nRX3lwAR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h4sc7G4w0ve3juTTo2e0O0Y1M2E3svhIM6zcQKRLSEOGs9qfQZ+h+pJXpqiJmuZzCHHtrvC9duZn107eV2h0ECe5Gw/4H3f1i1m9DNFzq43D0+0qpKFWnlvIAJEb6Fj49joJgbFHHpWz/Yx3rx14cPm9Mq+VOwZuU3vpb/hmjOji9TUC1UL/zzZkNY0OfQz+TmKKSZqlyaMKvj+jYKXKirfUR0wwIvISB8Y/AKl/8ArlQTv8MsiWna+3Gtt5XaA/Nde9Ps33iCSML9e0Kq0RU+7Gd+0kOvpUCCR1Dm6IqI2DD43yMM3nDWsb2FRkCgow0yvILHiJ2yCE1/Ebk8zd4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g1ZqdlIWCZepXS8hLXYQBXQFxDzvtu1BP2gYZh7vmiw=;
 b=Tzu8OHN0BdQeI1k7W5oJ9rf2HQBmfjKmme0kSUnS/JMPqQ7eX85BziJuGoh4uDkAUtLrorEQurF52+q73xv9Ds1vQGAiust24nuTU+HU9TumUIibhtkHEjHqe2x7N3ZXKlVybS5XipsSOVcNQo9i4iwOBR2dFrAaGbT+yOhwbZFHNNZtSQ4Cl6FFeiv4/e9lgsrbt0bMmq4vlZ+JK785vU+k2QXjvDcUMy2s9DVztOutdH8GTQhG1N5fgjXNPQAr/npHcqWi3FcsA6lpIbgLj+7gUuYSsdV08l64tsL+RUelok2OpKxWD88IIv6S89e/ecvWA17JJG8rXgas1f3cqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g1ZqdlIWCZepXS8hLXYQBXQFxDzvtu1BP2gYZh7vmiw=;
 b=nRX3lwARRmJ3Bg9bCbC+W3c2ObQErlHnB3uIsRR0wXRZkWu3o5IeprH4kjScPKb0428SkJQ3tL8iLE/yA450DCUKEjarhZe6K1s6c32oVYv53rBjTwpdKeeQ2sKjIE8AsQgjIjzgawDXYIFGso4eDlmXuSeZsbsQPZkiHMWt7NtFdCkVLpIkYCeveJqvDQEj6DVSjdS7SxrDX3FvAjpIoxurlYmwXhsbTIvuHnjS7G7VOo3012ZtK8s5uJJ86yLt2Aqaa+0asqr8sscv5hKpRWqndE9Z8aH87DDOwz6XiCYUpDX4CmxeRvkZv+sXD1zk6Pb86xQ0I9BYYL3VoMm1gg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12008.eurprd04.prod.outlook.com
 (2603:10a6:800:317::15) by DB9PR04MB9867.eurprd04.prod.outlook.com
 (2603:10a6:10:4c0::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 02:49:09 +0000
Received: from VI0PR04MB12008.eurprd04.prod.outlook.com
 ([fe80::3e42:1e5:5955:d68a]) by VI0PR04MB12008.eurprd04.prod.outlook.com
 ([fe80::3e42:1e5:5955:d68a%5]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 02:49:09 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	bhelgaas@google.com,
	frank.li@nxp.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v4 2/3] arm64: dts: imx95: Add dma, intr, aer and pme interrupts for PCIe
Date: Wed, 13 May 2026 10:51:00 +0800
Message-Id: <20260513025101.1498104-3-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260513025101.1498104-1-hongxing.zhu@nxp.com>
References: <20260513025101.1498104-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0009.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::18) To VI0PR04MB12008.eurprd04.prod.outlook.com
 (2603:10a6:800:317::15)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12008:EE_|DB9PR04MB9867:EE_
X-MS-Office365-Filtering-Correlation-Id: 2344ee17-b36e-4968-28eb-08deb09a34c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|7416014|376014|19092799006|921020|38350700014|11063799003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	BtlRx1Mk0+qH9xu/Sj6Jexhd8wse1h56/XI6CsKTHL80nrV/vA7e+Tyq8hy7+LCXsGl6/B8US+cQsATCwQDtlcBTB1bu02YLDowrCJ2WqcsBWGo8XPkmOIDkiZEjgTg+YXIzcUTTMEZMo8gWuS18RRcEKHhGBSNldzOETDDHwP6D7/bYjNry3S7s8dld3plbIhM9+X1aTCpAa4QnGp9picHeLqSPQCZaEGCV47Gun6H/+c0nOy79A0wc2G8Kusw2Nwb0QzuXdHY54OOcxvSP3V0lIL98ticEue6i2h39x7VxgaLis/cbmNON++XFmog+GZ0kJfwfDkgYNU47iq7Q2FQGZKkddDldrrvNgU/tbfmpma/rSGpYjN+xYQ9Zu+48YBw5Gy7FeUERzPDieJqNEGGE2gi+7NhF1VN18JR/ZRcpzYKgDorAxainX5fk/7YZXpsM4siUHdFfDpqxr9BfE9Pxwi12NXC74XKihAPDWBI+rHB8S/sgq1bRcJL0LNpfEttYwobFYycpELYwHk6AZU7NLRmGwh6Gl5TKUMcZeleJSgQo4Q4v+yCJtjUSoS9uNx4g/hYFoXgbfKjBfFoogk5dp+F7SZpC9Bz8ZEdmuPJm++rpwetJ1vGBMF5UNnFb6m/H09XFj3dsyxl0IguXObE8vcifB6dJhFT3p35qLYuEisJ8cMhYCzMqGLK09uUjNlvU7IkL5x/j9CO4NZG13YfGK5HfnL7b4zvuRux7pUdl53WRsNIauPlurW2d5shfKDmBp9Cai4I8pG9O2eQOKw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12008.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(19092799006)(921020)(38350700014)(11063799003)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?l9tAQK1Bsdfd26Jaegc+S/nojYybDRFbBEszy3oHQsUXxjzHG3Y/ZmLhc8jt?=
 =?us-ascii?Q?dyiH7hKZI8TWIgiTAIpKz2K52jRKxKScRnZcSwvGEzAzmZFGZnIWFgbzioR2?=
 =?us-ascii?Q?IJIxBuxK8dlp5XTKUNvscEQjXGrn2J8kKpHifVUOKy62bjM7/xKUYKVTlIUl?=
 =?us-ascii?Q?c3zZ6XOWKg5c4Tur4dLT5dpGwHfg4AmCfMH5cnxJ76ziRoatlp1kC5WnnT+a?=
 =?us-ascii?Q?9gt75JuW/dhRm1LdJWDFy6iovAnBV/uexTxivS2bsaDQ9Hmzjrb05wYXsn+V?=
 =?us-ascii?Q?RQG3BDHW6S0A1LjDeYGlQtl08toAtcSapDSyqpOSINbZ1FqgMdFbjhYcmMld?=
 =?us-ascii?Q?bd/eV+3tgvzkCCe3mZ08hdTyYQr+f3M02cXbbEHEOuML4etelgmt6Rqj3pC9?=
 =?us-ascii?Q?17AOBUTSepkJRWdgMggLYlh3hBMn9FYimUM6LTZoQphVnSzQTAcZUkgsu5Nq?=
 =?us-ascii?Q?2BgBrm1/Q3RBf0ajE4pN8wx+uNMbuR3hLBK/VplPikwYwvLExulOIyIzLEP0?=
 =?us-ascii?Q?3ZanjQKIJ0b1UNzOrJmGdewSzFVeZSc3F4vfhtzI6LqvQm9JgallMuKF+CZE?=
 =?us-ascii?Q?Z1YRpqN/7csXWWgukbpTh5wRufgb4ygoksT0v+CtqbAvp4qVm0ezEzdmqaOJ?=
 =?us-ascii?Q?9dt9J1FBKvVFTn1BLbMbBCDM5/alKvjGFhXyNdk/uNWR9u0w+7SoBfnq2JQA?=
 =?us-ascii?Q?yqlhi/OntsGaUnOUk0x2MiuFfUeh8WeeIloXhERo+mXjRo433Jq9mvMzn6wd?=
 =?us-ascii?Q?6ucrHFv8zekPzaXXK8U2OoXXlK8FBFSZMxuInVZp3ai34YhWlQIfQPMrtnPn?=
 =?us-ascii?Q?jKVgen1gatlKubciaB0f6mce3YBCuCqqorvu5yg2J3wNyP+KI57Xdig3wDws?=
 =?us-ascii?Q?H1UdOoHY9bOX5VD5j9AHfIqKroO6d6MySK2TlAdpwF9wlkFHMOV4SxAWN2Nn?=
 =?us-ascii?Q?HKTZESHp2beF+zCFQlpyyBMhNedVwYMuTo5gmoKVRfn9mFwtyKW39v+LoB27?=
 =?us-ascii?Q?MkEgp4AIWrDv8wbp2vqsstBaMMDs1IYyyd9JF4lFlt3EvPmf7C2lhdMw56su?=
 =?us-ascii?Q?xSrgzj1EMGyRRWwb95lK0ZZc0VbZeDpJcz05GFItghq0eFA89GL3OpY3FGyO?=
 =?us-ascii?Q?4mT1xPrgvgfciluEGNVr6mUmYV7/V+PTgH/2h6HFceVRMUFnTOfbaJ5LMn3t?=
 =?us-ascii?Q?Dt7szm4YA2QvS4JTW1fwwFjjTSxG60AOIDgNTcNFB0XauYxl33NsGcDBwlAg?=
 =?us-ascii?Q?IW6z1eRPhmy5208neb2P74XpgxqOGMMSsRtAQw40HsrhPF0QBKwFVMNrr06x?=
 =?us-ascii?Q?MQ+LsKEhFUmIZll8f+jSBP15nsFJMbjmtNLuZafb+vdxxJAGKcuaqPiM+BwD?=
 =?us-ascii?Q?R0riR+V/60Lame49Ukm4YB7w2iS/3UCCTxfRWx34MKwo2+wBpa4vuEBYmQQq?=
 =?us-ascii?Q?RmJ49DLkNEw5tYHCGk6Yf7iieJcDjNWUhFZ5KUqbd5J7sOyESPR8BVisbcUS?=
 =?us-ascii?Q?Cc3rpOwBf6sGZEi8o5yYgcGUYXofX3pFdqeOtTJzgdDcTLmhosoycrbu4+B0?=
 =?us-ascii?Q?HtfLZ77Ri0pxtn3K3YpmMzEnmZ/8DrNmQlrNf3VbeP/NqELqhwvcfrWjV2pm?=
 =?us-ascii?Q?BpXwxqjDBjHY0J88RR0LKMXsc5BK8IGKCXhEMaERB3rOwNd+3A6XRuEmWQHh?=
 =?us-ascii?Q?b2v+h6ZOD/6rXUmeLm3ip2QmSY/P1hrfd84iibPQPrG+Lqvc9FhAQYAWtLAT?=
 =?us-ascii?Q?uDFn5bJCbQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2344ee17-b36e-4968-28eb-08deb09a34c9
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12008.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 02:49:09.2394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eCnejUZUqlbpdexAEBMW9zeHPwhszmIdIbpQbwL1Y4Q0q1JUKrUEgJiBBfzMTEvBZnSLPHj0rEvg3I5dj3M+Yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9867

The current PCIe device tree configuration only defines the MSI
interrupt, which is sufficient for basic PCIe operation but limits
advanced functionality.

Add the following interrupt lines to pcie0 and pcie1 nodes:
- dma: DMA interrupt for PCIe DMA operations
- intr: General controller events and link state changes
- aer: Advanced Error Reporting interrupt
- pme: Power Management Event interrupt

This enables enhanced PCIe features and capabilities that were
previously unavailable due to missing interrupt definitions.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx95.dtsi | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/dts/freescale/imx95.dtsi
index adcc0e1d3696..f40388958717 100644
--- a/arch/arm64/boot/dts/freescale/imx95.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
@@ -1948,8 +1948,12 @@ pcie0: pcie@4c300000 {
 			bus-range = <0x00 0xff>;
 			num-lanes = <1>;
 			num-viewport = <8>;
-			interrupts = <GIC_SPI 310 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "msi";
+			interrupts = <GIC_SPI 310 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 311 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 310 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 310 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 310 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "msi", "dma", "intr", "aer", "pme";
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 0x7>;
 			interrupt-map = <0 0 0 1 &gic 0 0 GIC_SPI 306 IRQ_TYPE_LEVEL_HIGH>,
@@ -2023,8 +2027,12 @@ pcie1: pcie@4c380000 {
 			bus-range = <0x00 0xff>;
 			num-lanes = <1>;
 			num-viewport = <8>;
-			interrupts = <GIC_SPI 316 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "msi";
+			interrupts = <GIC_SPI 316 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 317 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 316 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 316 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 316 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "msi", "dma", "intr", "aer", "pme";
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 0x7>;
 			interrupt-map = <0 0 0 1 &gic 0 0 GIC_SPI 312 IRQ_TYPE_LEVEL_HIGH>,
-- 
2.37.1


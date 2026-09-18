Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020111.outbound.protection.outlook.com [52.101.229.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C968D439F90;
	Fri, 18 Sep 2026 03:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789701661; cv=fail; b=mKBk99S5IJUwA5eSgcAqraTda2B03EBA4oKvnLTwDVTdjH8iXQvWynTr3SJAPPQefNTON21kqVmoWEtTWlr45FuIYRxzQFl6cnJ6z4JIEUNKQWhiKyUkfWXADcU+K88pYrDIuq2SBudI2ku9EwkDVZlITNGuRkH6vIcTYgh9LMA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789701661; c=relaxed/simple;
	bh=4lS6yEUvmVVcv8U5TP1hkyjmYouahYXbIDY1aypQj8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dUKjoPRzMGHFnu9ApUl/XEJUfyLkTviCmKz9m0NzoFuv5WfOWZKCZO2O0sEhooEen3VMPnKVyvbodVI4JGIAj/am2Zynmv7W6HPHdmlpqGCWZuZsUURjSwPOp3xOtzGsPe1PBU/RnChDQ50kVS46Aj9yceKXyDxTiSQqpiXTN3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=VEinyie2; arc=fail smtp.client-ip=52.101.229.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="VEinyie2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uR0Fn6GW4f/vuE1J1SBue6ZVRR8V18pswIb4i4rrt3HgxMop71xEn+lO0IW2hVHFoEUq9D60GxH28F+vUCCjTRDcv+6dt6RmdUUNfrcRASmGmL0ME6U9GlkICUj0kkoaW2w/Z7K0KZavx7Spsu7BT76IDAyqb8apLVXyJNNo0RZfoEeREnA90ouVoPYR6FrP2wcik+q86oTGwO8OvCelaajI4z91RuVZVGHRwj4LY5/W/mu7xarUawQenb+/xIwMWUq+v8SssJ7JQboNsMefxUgDhaSyZ7Rv3XzICjJR1fCPotUmUPBb41AtB4XKdNOBOo/iK1DYuU9gJQItmF5pvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ak7miQobWB05ic/UhznfrsF2J4rkBc3kpB8DrRxBx1s=;
 b=RRFOnjW0RbxUrP/PkJAgtMjeUKMN6DrHMkGRHXhUlIOVNXNHy3hRNZ7DK2es2tbTs4RR6KdcKO/C0/bHBhxHtJHXtkaWt0kfE43K1BaJ49cYCWoz67jL7V+iTbM52PaNtgo7xhIBGTWwk5vU5w1abwzJCEqjD3WOuPVOJXm8MwCOGDKwI70U7RU8BYy+G1hP6aaR2g6lu84Plvm/dVNKlCDHdM0v67nbDvbq5GeMOvayLx0LzjQqk5FdQEVkM79pfu9PT2NQxF1tPlWATIjDAbhtLlZgB6fh1cXwhp+Iagqfa/vsOOUz/DF3JJI27blK9MZ0t1gVMySttgBjEaTwsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ak7miQobWB05ic/UhznfrsF2J4rkBc3kpB8DrRxBx1s=;
 b=VEinyie2q3Sqq8772viqQWx+B4mNqkBAsnxNfic56YZaCt6p//E2GuWEWVjpqZ8GaJjFsjdFG6DeZTOx+Rh8jcYb1S+2l0Wm2Zkm47bnt6fg16UdG/7ikrZqcA+ieLQ7954IvmdmSOBHDkZmBOoH37oJj1EtURsgZrtqenXOFO0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OSCP286MB5141.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:350::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 03:20:53 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 03:20:53 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Jingoo Han <jingoohan1@gmail.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>,
	Frank Li <Frank.Li@nxp.com>,
	Niklas Cassel <cassel@kernel.org>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 11/11] arm64: dts: renesas: r8a779f0: Describe the PCIe AER interrupts
Date: Fri, 18 Sep 2026 12:20:38 +0900
Message-ID: <20260918032038.2216471-12-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260918032038.2216471-1-den@valinux.co.jp>
References: <20260918032038.2216471-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0115.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29c::19) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OSCP286MB5141:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b12f778-ccfd-4e2b-f0e2-08df1533d870
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|376014|1800799024|7416014|366016|56012099006|10067099003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	TX5iVDMFl7xEm3+LLAcuGHl3XVTLBoNB7mM5zjfHTDz9+lnOa4xV2gGM7LHumD/dyc7/v6W0ax8HZbr06mhkFyuuPACUQIQ0XEW1FWOl0DfdVzbUTRQsPI81U5mlgKNZUVUaJubn3BmYDPT1X141Pc9d3zUXftrZhD1wH6Rzg1wHgR0wwqJ+nIhjOjt5Vw9vjjH952Jwu/Fcta/g4DXgOIRSR/Es2X+JnNzAy02FY6hS9RPK7bRQfrp17Qop5RaJDEF4IoxsVW0TlqQPfDx7xrew3NFdAAYAByO4tSwcFpPHmxrteZ+LMcJFmA8/nV9orn7qPUaGEKgXsyb1lggVyy2aIv/Pfg7dowwdRfMhdqaVI2urip1hxdkanKu9j4KTjEpDKLZ19aUQSo/eP4UyI7EasPY5vFgMx4JvpLmR7FtAAgYSRmH+iQsY88bXwcb9ncEprTSmBwS4kl15UDTlgq4Zb47s7abhcd4jOR/vQ3dGXnD/F+uoVl4jHOuVEuoe496ySpgjI1QAJcA4ujz/Obit6K8CcjSK86XUStk19saLPlHtTouBYfCbu7n/A7Q+nRFxcncUO7zsMacdMdcyZWp/LPxBqNaXrDRHnmLpauvSajIODzAasrWPfqRcXDsm8xQ/QndeewxeQPMKG0x32NwIL42Gogq9AjtHIeYcc5jAH9aeQat85JKJBDlbtrO5XgzJvj1t3BuMm2p7YOReSg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(376014)(1800799024)(7416014)(366016)(56012099006)(10067099003)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YGKTFAXMHskWC4oAwhRaFfBdUzAdtVCLA2niNymUG9Idr3eytgdAiaLYbxrR?=
 =?us-ascii?Q?Ip8ZN1bj75DBza7dObnbRqWRM4y8ktKNHTqCLlz46mzvw6L1sX6IfUtxiKuE?=
 =?us-ascii?Q?qRB5FhxFjt9dt6OU/sLT5dDhvrXHWmWmuT1zfOSFA7yZYetZj5Id3YhS6CvE?=
 =?us-ascii?Q?2Q4lU90ukM0RfmRvjYx2kyiuRB/2XiSC5b3c60143bkmAPk/S/ebWXSQ2fdJ?=
 =?us-ascii?Q?AFzRS3rY44MpsT0yM11iHi8n22Xj2Jhw+bPkCzKgCnY0UPwnZbafwNhrTEtY?=
 =?us-ascii?Q?y45McCY4HACfxXWdc7r+AE2p9gYynPD8BFPnKRe1FhmcbER9oi5ngvpFXvz6?=
 =?us-ascii?Q?sduDgBGgUm7W+tShLX+TMVbYQqRQv//FSFX5y7+0e9Y15efIW6Rp8IoTmPFc?=
 =?us-ascii?Q?nOSgKHJgu/USdqSlf2A2Oc//ndUHdOubxSgF4E0Uc2IUMPIIgKbwRd/CFgiV?=
 =?us-ascii?Q?NgmlW/q8+NBOzBp79YMSCMC+Lx3sfieluY7SyxD1euk5ry158Wd/zxdd7fUI?=
 =?us-ascii?Q?TN7LK0ulaQhm9jvbyutublH+eWfbnto9Ayqd5UKVJM4UAJUXkCuQ3tTdHIJt?=
 =?us-ascii?Q?EbtwOJGvWN8+fIjQDPeXKZp4OfrhUF1jRtE/uToYit5wY3FvxxeklEZuWW55?=
 =?us-ascii?Q?4UCEvF8y2vyF46a0Eyh06RwJC048vHX8ZE9/YeqPRHs4k8JewIkRdcbuCEyu?=
 =?us-ascii?Q?ZV7noaF2IxguqQDd3pyKRD1pv3wCMnOH1TR16aIauJYJ4nNt+meCsgqFLtap?=
 =?us-ascii?Q?vx/cApxUQXRj80TqE1MaOWHZ3HVJ8ElfPCKDCQQSqQUcxuaJDVLDaYpO0u6W?=
 =?us-ascii?Q?BSTI4pwaV0uE2KjCyn2HUZo4pv5ZkdyXQYECrwAV20FJYLXQEKfieHAq8mJ1?=
 =?us-ascii?Q?BFkG2EzDmIaipaKceK+WQUYPX4ENzhQ+g/pdVTRZ+qnlVsKB/ko/Ugdp/9Ea?=
 =?us-ascii?Q?+uO5DCULrWoXRELMTFbsyKZbZAdio55ZRA/uXhf9Fpk9r7jrc+duqpsFaxMo?=
 =?us-ascii?Q?eGY6j1yP9prA5qZCQ5r9RzRKRI2pMZQ2Tj1JtrKZpRQEcOgHg3QzO6GLLezW?=
 =?us-ascii?Q?Fg5VlZEpW67RgJkTKp0tQjxkHV8fjme7lYuQBcVNEhXzUZcIoEzWtlYGIkFR?=
 =?us-ascii?Q?v4/MUWUPzM5FkhlkAeca3uVlgPlNBbB6xj8H/iDW/xVF6LWycmFIEXEUp5dS?=
 =?us-ascii?Q?F7rNK7yqw1P9+fh/PS8dFVJX3DSgv2k7DNmbM1dmbBTDkQU4PBlCzLNfN6cU?=
 =?us-ascii?Q?ihhrcLM7/wMCcrIfArKY2SYYWzIiZH+MnJr5ZERbxKKc/zXNwNLAxSCRhF+k?=
 =?us-ascii?Q?EQuPHFZX8nps2f5RS2lV751wfRF/yAOEXR8JsSMBJuSE8OsqMP3pt88A5+iK?=
 =?us-ascii?Q?vKc2HYSulYgzAtQSpEm24HVw73NegK/5nwemSKhjWYzAbErSuM4rnAeSHHoM?=
 =?us-ascii?Q?wfnnHURVMfZwBxT1KMcxnGPj6opNC2Nru3QAht87FgrfJgqaFwkxanZ1iHFu?=
 =?us-ascii?Q?nV0nzE19duh9JgHVKC+S8nkVtCk2XJdEpAQkbLe2f4vxHH0Qk58JvoyG3pSE?=
 =?us-ascii?Q?k136TQurPgtdIqaJ6kJjncCp3KSxL1Chk3urOPxnW7+CcQHodwsVuFxu0fZo?=
 =?us-ascii?Q?yprrLE/dDPjsF0Rb/rV2uISIHet1pQQA3KYEzMPfyPmbJHKgt7R6992yeaAA?=
 =?us-ascii?Q?Sji0gcdpB53rBaMRQRtn3tVJljMVQoWR7lvFBuwQilSzRU0T6plxZqTGlOgQ?=
 =?us-ascii?Q?XzYBxWlD6hhAZDpiGrVDNFiRvZUA7n7WrEXPNd+JyU8cJDEuo8P5?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b12f778-ccfd-4e2b-f0e2-08df1533d870
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 03:20:52.9904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u+FN2gz2KkXnFAmTg3j2+I8W/AC7H+IDrwz3pK4bq6xIBAITWKYW0zob02dN9ho+yS8eLknQ7gTLEKO3t/z6Jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCP286MB5141

The PCIe controllers report Root Port AER notifications through
intreq_pci0_lperr (SPI 421) and intreq_pci1_lperr (SPI 428),
respectively, separately from the integrated MSI receiver interrupts.
Describe these interrupts with the "aer" name so the controller driver
can use them for Root Port error reporting.

Append the new interrupts to preserve the existing interrupt indices.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 arch/arm64/boot/dts/renesas/r8a779f0.dtsi | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a779f0.dtsi b/arch/arm64/boot/dts/renesas/r8a779f0.dtsi
index 16a83b1749b4..b9de7c795e7c 100644
--- a/arch/arm64/boot/dts/renesas/r8a779f0.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a779f0.dtsi
@@ -785,8 +785,9 @@ pciec0: pcie@e65d0000 {
 			interrupts = <GIC_SPI 416 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 417 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 418 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 422 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "msi", "dma", "sft_ce", "app";
+				     <GIC_SPI 422 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 421 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "msi", "dma", "sft_ce", "app", "aer";
 			clocks = <&cpg CPG_MOD 624>, <&pcie0_clkref>;
 			clock-names = "core", "ref";
 			power-domains = <&sysc R8A779F0_PD_ALWAYS_ON>;
@@ -824,8 +825,9 @@ pciec1: pcie@e65d8000 {
 			interrupts = <GIC_SPI 423 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 424 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 425 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 429 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "msi", "dma", "sft_ce", "app";
+				     <GIC_SPI 429 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 428 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "msi", "dma", "sft_ce", "app", "aer";
 			clocks = <&cpg CPG_MOD 625>, <&pcie1_clkref>;
 			clock-names = "core", "ref";
 			power-domains = <&sysc R8A779F0_PD_ALWAYS_ON>;
-- 
2.51.0


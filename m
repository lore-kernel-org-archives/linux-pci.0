Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020121.outbound.protection.outlook.com [52.101.228.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B633F4DD0;
	Tue,  6 Oct 2026 08:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791276433; cv=fail; b=d2xDzQpjHN4NJJB+ozub8J8twv1pTRF6Kcm4Adb1yfWcsVYFCCZwz98UKH1I5D4FalAqGcDVr//GklkDTpQt4YSq5dPXf6JS8fTYNBIcG6tuJqssAQxlSz9Rk1StC86d19CJtn4tdXDhaTF9uQwTzPJzFWLHbvWKupilGorsbSw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791276433; c=relaxed/simple;
	bh=ytRr97lqbWaoz9NMYehUtsqi/KDwGVF0MW69WBq/jKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OBV8eKZkqgpHBg+Khglif+jKw6YBbV+96aS2TpClY3O8OUf+MrpuQ7GaMkICfifpjNvabiRlNCvj7I71FwUEly+xIBhM5tz1E/ADNifF2J+PdY7Hj6tYa69l8LS2si097ZK5qG8QbBmgn57p8llW5BYin2r03ew2n1d8JzMNfls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=kTGrtS5j; arc=fail smtp.client-ip=52.101.228.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="kTGrtS5j"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=koX96bn6f2tr6TUIV6Ssjvu5N8w4JFvtN8XVlOnw8Nb/8FlTT1egtWAAKb4vvYKTVlxGCIj8Z3n3cs7393TekrObQPLhKlJbdLpYQykp9z1zOgahYCuEnyNtmoHV0tsoZB9zbmCKq22crc7KoQnc5YaXhsG510GkRsn0Ee6uICmT7cHRPlavPigw3bMhHD9uo+g+U3ziRr+E+ED7ll6Mo7Nk36oUKynFp7aGbirWAf7FwE3dLut0cFgao90PX4UxNoFgY2GQmxUPnAtLA+JZGQpbEhoPsz1R4H/yCkU8oWIKNt+EdQLwLD0VlWtS+9PWvVpBmarypuZSm5TNzukKng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IxP96ne9PNGrl/jTNuhiOsyg/FzngkMrzTbQwTxtdWI=;
 b=dhyiRWPO+EqqmR7ckZbwOR9oxOZwVuJ/8UZz9r3N1RsXIV2DmvEraB+0z3OSVOR7/Ci3vKagOyVdz2KdFW2jprdKduntzjS86ePKnLLZ2UAdlh2bNCP7t3A4ZRydm7+Pm/bRAuVIK26OGyRmYlGZrEJxL1rSnomV3l0Unc7naca/4MrkPL4a+JuKZWoaL4AdZ+6o0rin8Pd+QQkR0WfAdhEEdjO04O28oWMQo8Pf5bDwYRekfa0QaMgfy42MH7Ky+vFlMoSMye+Hdctz9WhK1kjGb3+zjHSI/U+aNTmmPGHdIwJ1pa8+CSrFO/VRHMa/jCgc7a1M9OXKr1bRpwT+Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IxP96ne9PNGrl/jTNuhiOsyg/FzngkMrzTbQwTxtdWI=;
 b=kTGrtS5j3kPtVkgqV3h9k5jBSoQgmljW/V/zHTLy7Gi73nJ8fjdD5xBKHaMQma4oHDEG8OkEYXJ3GkGHUsnz9eOTbHN+g6oUJombRS/NLJP8mRyzhfY315gkYiUicZdvelxNMUA6r0KX+v3q4m8933nV0o/wobJNDKs07nYairg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OSCP286MB4983.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:341::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 08:47:01 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 08:47:01 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
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
Subject: [PATCH v3 16/18] arm64: dts: renesas: r8a779f0: Describe the PCIe AER interrupts
Date: Tue,  6 Oct 2026 17:46:36 +0900
Message-ID: <20261006084638.3821710-17-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20261006084638.3821710-1-den@valinux.co.jp>
References: <20261006084638.3821710-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0108.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:380::14) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OSCP286MB4983:EE_
X-MS-Office365-Filtering-Correlation-Id: 61a9c495-71a0-4a81-69ac-08df23866363
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|10070799003|23010399003|1800799024|10067099003|56012099006|921020|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	n6UqTm6i8tMPhPa2EjVQGCHSUgMSot1SGW0LjMFURrJWI8+qQLqFNWjFVQBEmnq5BAMKRYFYohjYwn4Vy1HHKlp1Z9QcuRtujhjWmq4dI49m0/YEymtxPcCpnvtwJx8ko8f1tfExjDJCv/mPIrM/rzZenvLymNlRW6YwGQBxTl+quUMr2U2M5nsTBqNyCaEeBUG5aPmMx+KFqY4UIHqjbQKZu44WcATfRaKR/FcMV/5UlUJT0i7bsrFkjxoa7vE8QeSTfbNYukpe3iw0GA+I6d+OVG4HfIr5xBrqIz14bNlrGwLTHjSq4wVpi43SNV6yC2Nuii23rllq7j8R3fGXIs9iVgmFVclrqR3FVzRNrlYwSlSSmvbeEWbrxbPrYnPC6nU/9XJQQtRvW/pesAc4dt3XE2ofMknuUW6dkKFSbhz/pr3FX95V8ERZw6hdtlE5aC68BJARphVyC+Isplcuo0MBjKTV/kIrRWzbLmKfgOF5wJbg/LUaH9Dd4ycIFi6HM6NLUQf3zHbf+tt8bBhOeSBfwbufLjOiORtN1hFrJzOS9e+kotqwgng+z+XWUgCiw9smOM3rscQgbw5HIOdQMzMwzQaPSKJv/8nAJ7SRCTQjXOdUN6HAKrwM3Xg2e/2vcG1KMLyQtFwQsgE8ISP9XHpXU4CAprhmNYk8zCCwm2e/ZZbzMvEsIyhOMQg97IgLL2UURf4i5PRNhWexpy0M8g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(10070799003)(23010399003)(1800799024)(10067099003)(56012099006)(921020)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0pvQwWjEiSkqqmKkkuFo8ABTTxtqELorqBtgqN5pdp4CyvFbysNxWBzGGlFy?=
 =?us-ascii?Q?gGJFnt9VYD1zQ009uvoRwydGQRVYniDnKQV2x8sA+H52GcqN7WHlku622fHw?=
 =?us-ascii?Q?LxNvx6jeWFMkk7qp3h+Z7Auo0Or7tH21bDkxvpuANz1j8HXwIwnmCe/0hR9j?=
 =?us-ascii?Q?0hhPuWO6MuiYx52qBck2Ap+3euGFPX24AfKO8XRqVDkqJPRc+gMEHTVzL+08?=
 =?us-ascii?Q?s6DZQDt7hZojXuAsbl1Upy9pjZp9om9J0ISILjrcxnXl9u+Cu+VBphIB9sC3?=
 =?us-ascii?Q?T2GfZaRwgPFaE3Gfc6lC/NPpcD2H7SgxXVgIrefUhxIKr9K0yCG0Ag9C4cth?=
 =?us-ascii?Q?0hswHSyeHDjeK1B5AHIy09M5MJlMdii8UQ4B6tHlZSVIfTT99ORaBlq8tcHH?=
 =?us-ascii?Q?WYty86UD+WLs69jYT4a3gOQAf0pt4d78w1M66p+tTYvJ0pRc262wO4KB04Wq?=
 =?us-ascii?Q?ULs6QD4Vk84jmWELFW8GvTdMsYls00W3F2lPSVP9dGABVbSyjIpYO2DNBYtQ?=
 =?us-ascii?Q?HRRsGKCSxnECnynXMlTJG3wZ5xpINPHZVm2zFfeeVzs2SzblgywSU9q6Op6h?=
 =?us-ascii?Q?hWwCQGAYaO2eKWQu01uiJpkpgL5a+F+WzZTNikZcEJ5Gz+C7Ow9CErQVh722?=
 =?us-ascii?Q?4KsiZsDz5MKRxE9L4Q4/dHIFKK9Tes/IvJkPPZbmjk1rYoW4+svQMz0e7lel?=
 =?us-ascii?Q?n/GfbN68/n4HnuDWxXQvGODe+QW7qYAY+m1bj2vNRSvce6FD0bs+PZ8aZ4hy?=
 =?us-ascii?Q?16nKjIhOr7LJZQGS2gOkE6ozheLvGse8XXFREjs4c0qu7aqtri3RmbwUa9kW?=
 =?us-ascii?Q?vkiJGukzEnlt494BdKokbDac/VwJhPxcRp+5I+MPvFegYbmguL5yDRFCg+FN?=
 =?us-ascii?Q?ATmF0ucMJcCErsRELuWjLkmDFHOS8WBQqv9hFvvKvejMmHYSt8KvmyzXEWjb?=
 =?us-ascii?Q?A6speNK8T/1iEkkXVCbUE6fQOnWLK+7pP3gfNtJsJu6s3lzgSmGFx2ehnB7p?=
 =?us-ascii?Q?RwX/1Y1TkGpqzVVyY+U6WsZlx4J7sQ7lL/wJsWy8yuAdoOPbbObvC36p29zO?=
 =?us-ascii?Q?vBENrTAFBfU+7/5b7vu5WpyKCuKF7BaItzrlj97eA3zgQqyXulS1bIvuaFmh?=
 =?us-ascii?Q?fVHyPWEA43hJqtQRfUCOTlY8rsqtECRBBgone81XeemQV4l5J/dvM7/jQL6p?=
 =?us-ascii?Q?DEJZC6i19IbeVKxPiMYLyliNLlz07LEcTgfj0901e5Mtb9t49ZkZ+y5L4d4d?=
 =?us-ascii?Q?f/w4F6VEtRgSdw7wZo6PAI0FrF1krhlSur2ucNDMUt4JieMPP4NYeFAjt5Wg?=
 =?us-ascii?Q?rW7ecJ+O4MgXgvP9FHekRph2nOm2aESg+nlcFTNXfFacAY9uJMogpolhVjht?=
 =?us-ascii?Q?4VnF1VjcYvNO+L4XrJmGfMOhLFqyZa1t3UFdIGYbql7C+yfSK1gp1cwwcveV?=
 =?us-ascii?Q?rOmC/O8p0l+KUCeMAxCTKJez0vfTHqwUh9s2O7NzYUr/tT3GKIIk0V+Z3PxH?=
 =?us-ascii?Q?mmmvgvYtb9Z1OnNlO+ERqDOcZilUmQG3nwDm18qOh+NsFHQtmWEElobCM+sD?=
 =?us-ascii?Q?p+6cmxJorzQBVHeQnFDGX2bJ/r0krHlHxlB9VuAZR5rp435bnOpau67ryeOy?=
 =?us-ascii?Q?FHPomZSJ4WkS+Y3tlLuhdnUuadd03MbKLkk2Mxoc34aG06fWVcempdL2kKJg?=
 =?us-ascii?Q?SzC2c3S9Lxh9GVOT7ZiM6MVeX0Nn7LWLnCq0HlWiX4aU5sxvh+f65Q6dWfjY?=
 =?us-ascii?Q?Teuk0OF1NO+OAh8xk/INdlRbCvMi20JWdR2MuISWni3k+3CQXc/Z?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 61a9c495-71a0-4a81-69ac-08df23866363
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 08:47:01.0945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ubkox+aeK1HRyTw3WJIG085IoLxI72gmcpzFBupQOOb0GyYANZFtG+iSh1E6kd6awZp96pkxjgZj/W/5mrPsjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCP286MB4983

The PCIe controllers report Root Port AER notifications through
intreq_pci0_lperr (SPI 421) and intreq_pci1_lperr (SPI 428),
respectively, separately from the integrated MSI receiver interrupts.
Describe these interrupts with the "aer" name so the controller driver
can use them for Root Port error reporting.

Append the new interrupts to preserve the existing interrupt indices.

Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v2:
  - Add Marek's R-b tag. No changes other than that.

 arch/arm64/boot/dts/renesas/r8a779f0.dtsi | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a779f0.dtsi b/arch/arm64/boot/dts/renesas/r8a779f0.dtsi
index 17a632770e65..8c818eb93119 100644
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


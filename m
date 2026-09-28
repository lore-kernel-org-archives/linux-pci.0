Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021136.outbound.protection.outlook.com [40.107.74.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53B64F646D;
	Mon, 28 Sep 2026 16:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790614406; cv=fail; b=rZ8S1+9B2c34szr9OU/K+l3XZqtx6vBDELfq9PXUyA3jueSpZsczWJ1mckQJjMx1q25BhhGKvXBnJkZtda+uby6lBfdEYmD+nPtL0PuMW1HBXYQevEdMBPKoHF+N20eu64q+kKMq2Rj1l172tEnnqGk30ytF2wrzTQ1uw0c7sy0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790614406; c=relaxed/simple;
	bh=XIlJuTAGeoODgP0jFbcXZPuescDX/WjBBpcqb+4FNNw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HCJX8pmW1eM5jOL50JMGNdm1tvtv3JWsfm6PkmJkcdhti5fLZHbcFhTbhookfzmsojs6cUXAGn6bcJhYvkNdSRyzMYBKUGjm24YpLu+Bc7dGyomL4pbshftVb4JaD32HxywFY8YNx0zUEgkRAfLyxxlvG9z1MCI8P0THMr82dN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=FKulc7vI; arc=fail smtp.client-ip=40.107.74.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="FKulc7vI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=he+0zxcBu7qvQGyQodpJ7CosoDtQr7FHiOfIOocxHZ9kdV2LKOH+wRP4fyMrhFx4amr7ALyLyVLrpUEC7sriX2gFzxcqZPo4yvCwbsrQQCIRqlXDm/00MP88HubArYpkVTur8o8puqUAXVsr/8xMSVVyl4B03pHyaUraRk38A2eoP3C20NvoptwJIXBoY9sMsrC7X6tn+g9LV8cc88leSlvquYKi1opWKXpMOrtLdUqBv4jPKY7NKog3vwIzNGqkYOKKXvWRRvqGo08BhboL/i8ll/i3DpvhCSn2Yrw5anuLoHfaO7W5Hzt9TOvuIJdUjjVO619onyxJCOSUSws8ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J85bu5DfMJJ4maZ9Tf+hU8YY7ZwiQr2DkPJLk1J6kHc=;
 b=KmkXevxLJJdrzCNjutvbqWCHYrO+v2itTTsP3WDRds7tsNVw0DgyapXIV4rPqgkD0nDt/a2A95PBtzBvkQ/koyC5txjvORBVuO6qQCTU27XqVCC1bMyirQloV1y8PTWc/22CkC3kWOf5MMKJMXLUNEy59eld9TyGaL/GH7+CK/UmGQWDnSp00bb2aezGh0x6OuZx6X5EFfJTx4PoUEoCiASo5aaFDHpjXukgelJ88n63yxjp0ayabP9YtD1CrG+18qXaXLuDLLKg8f1uQ60ewK+HskiobSWZd4r7n+eUPgQUMqxAbRTWapqnhvjHNFImpkxnrG2FPSfRV0BxZrxE4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J85bu5DfMJJ4maZ9Tf+hU8YY7ZwiQr2DkPJLk1J6kHc=;
 b=FKulc7vIwuauclqXpqRZLV0IlKAcMQ5woKP92fke8vvjmZ+/4ZVdoDbQW4NBghG2yB0ljJPvi06ENF+IpTRYEx/jR22DH5eQuJ5mMuPjzSEUrLYoT6WmobCKy92hgCnJdk6a/oju06wLgkwbXFI9akpeJkrcmXj2JFkFzVpfMmg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TYCP286MB3638.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:3c0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 16:53:12 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 16:53:12 +0000
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
Subject: [PATCH v2 15/15] arm64: dts: renesas: r8a779f0: Describe the PCIe AER interrupts
Date: Tue, 29 Sep 2026 01:52:30 +0900
Message-ID: <20260928165230.3397664-16-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260928165230.3397664-1-den@valinux.co.jp>
References: <20260928165230.3397664-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0055.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:384::6) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TYCP286MB3638:EE_
X-MS-Office365-Filtering-Correlation-Id: 9994b0e2-e408-4a1d-e94e-08df1d80fbac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|10070799003|56012099006|10067099003|921020|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	NOs5HaW+WmLzgnQYxCpCRr5FYwqc3LQbdfgzOBOFue2wOP+iIUIi2UgSRpFOgU7y1ud/xv6eHS0A8QHPt05vKfZN3bJwU/M21Bdq/fi4MxLjKPqq3X5LxSulLRQ3OdLDlh5StULm2o+BdVXERJdJih9ZwP5RUnErllKNleorkpWjJ9Esk70x3F47dlAa25sEo4VmpBlk1rP6Rn7oCoyQy1TgCn2jBePkFB+pAg4JdjqHx24A4ZOmcqpI8Q8RBHqdLCkSE+O6kW7rQv/VS5bMa6caxXIoqjkGf0vh15IuWZEY8mQa8/8jVPco96I4Id8sx6LXHqhVhDZvV/MojP74zeOgwAQrvApWzhYDbaj5hGRuA0LUft5+WsKetOClOg/bm4mbsGMh/+Wct2YKPV9gJaLc57c6SCoiDWVlahbsd3rKRVKtIMnGtReNSdU5qcC1Q3kVDXuoVcKlCzG2HxebRwtC/o0i6pICeUqwWkiNGMZqzkoTVfxlXtYQ58HlzETRw7jBsuM7wIuMJ66sF+aER3K5iECEF0ZcUPunn4plgAn9xncSty/X+4QaKG48hKwfCVPu8APZ/OpvoOeCiU1Ro9zPO0asxj+zOwqM9P7ulqolfE9o1297pftQjtgaxiQ5f4m3NA8U/P6CarvSa22Eh9ay5FBy1YNNtiwS4opdASU0DQoV2654fsf3C2B/NI05PNXCHfnQ56SQYVvbY7R3Cg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(10070799003)(56012099006)(10067099003)(921020)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HZoR9vpet+U04mXqwSpWkN+EGE3ccg+qPNwL6Y3P+lLaVUknBm1tdrz7kyx2?=
 =?us-ascii?Q?BJB4QEsj/6E1b+orb13qDBSHxIRzb6Ke62f3WogC/2s4C3p69e7CEp6jt1MF?=
 =?us-ascii?Q?zM/yPW+Z+bTXryBJR2nwiedJKBfATdRhnBgo5EFwsnC5e1v6Iv+UflTWZJ5i?=
 =?us-ascii?Q?bnbVEs33OGYhW8tspr6wm3OsEvcMUfKwIcNajA194/lT/87tzwpczzSufxSI?=
 =?us-ascii?Q?Rp7MYR5+tCWw7LQkeCzEG5XOgcxuLgoXACxeHFGZf2em2jru9YG+bruAXfGk?=
 =?us-ascii?Q?dJPlHWV07zLtLOQgKCiz67of7jB/tRiixtZkLqkIFJ0xBNG3r+8QU8xj5X4E?=
 =?us-ascii?Q?vSx4BFDD3BBMgQBZF/bCGnWK4hSjlZW7WW0uwbsaF4a0fCgYoS8FOGnSTZId?=
 =?us-ascii?Q?gnIjEiRz2prz204+3nf69WxcxcGL+01XJekp7Y+kEE8iu1QRL3Ou6jjiTASd?=
 =?us-ascii?Q?mZZ4EcyNTOO7EFwM+lzEeLwv6NXoCagkdBr9CFM7I4IkLibeumuUri41Y7Cy?=
 =?us-ascii?Q?shP1SEh0N2vmm2JW/7Wck7SJR8OrwHetfCzWJpXBA3E+ef7H2BoyPoTSNAda?=
 =?us-ascii?Q?xNHtE6Ktrmb2dwHPlIa7cvlSxhZ+9PIeory4aioGmVJROEIHI9CVp4jLh0gq?=
 =?us-ascii?Q?e8ZtrBCvOYyxXGQUNgGQKLZMX5JplPsRDruuLqtu7e1bSIfD6dSo82nmdY20?=
 =?us-ascii?Q?lNkrDEQa6lxw13f9/C6j4UGw7OwjDgNZS6EOqDOkrh/NLxJ8vGb4GAJxxL5h?=
 =?us-ascii?Q?BegS/oJoX/TfzLZgr55xCr17qTF1gx98vMtCFqV12MYGGnLafFuAzEaaNb8I?=
 =?us-ascii?Q?T0OcAHzq1YkJ34mKkF7ra8H3aeZSF+cvTvonmuL8+wcD7ax1oG8K5IFoGlXU?=
 =?us-ascii?Q?2BHGUbmwIoahwNoRI2qhokhjHs7oWo6FWMgChOJ5XYQDVBqgGKxraRhjm/s0?=
 =?us-ascii?Q?HICA1SbPpeEUjEaqQ7mmMBaFdvv2sKsh+WPgXtZPOdYq7Dy8gQ4G/FBws6gM?=
 =?us-ascii?Q?3KJZ6VEEIM38q9Kd2UL4YGIel4qq8IkfZi7Pyq2DZYd0Evow7JPdIWuJYToq?=
 =?us-ascii?Q?ADd8/uzfatTub7ZGVH3gZZS+eSMtsuf/LmtpqYIkkaD8j7RR7c2ZFJsz8Glx?=
 =?us-ascii?Q?2Gz+SLGhCs7E1SBMAAM++YMPWDQ3P29dEYPM2f1DCYzlPQqSN0iy49Ndclit?=
 =?us-ascii?Q?PaXm9qzi6rcy4m2/9yHCBKNX8aUxPT5UVMvF1JIjenUY18Rc3UQttuA31tF8?=
 =?us-ascii?Q?cnmSooVwtIJvCvY6oIC1IhVTAliSfsJa+O6gqyBvwU3HHSD0/eCbk2iz5H1D?=
 =?us-ascii?Q?zuDreFD9YaqPCUWPoBeqRZ9N/vRsd8RfuR9WbM0qvNWGe/6vT/QPsHK32eLK?=
 =?us-ascii?Q?WXsUDhLO+npneoR6ivczScZTTd+K5u+QJdHOiOeetfVi270QYvZKudB+M7pI?=
 =?us-ascii?Q?v5/C1jdkJmlZZr03zaLtCNInvERt8oTYX87Wtoc03g4qHyJbSH7syqaHBxFz?=
 =?us-ascii?Q?tFSQjpE+fjw6ry9cBC9BgCVshU6QmSxvwTW2gMg90HyU8tt+7V7hOPwFGQ1F?=
 =?us-ascii?Q?luqQ9ZZe/eVbnIEpzVcLZR8u79ixNJuul6xcCND+RgVB10iLNfv3YBLdMXja?=
 =?us-ascii?Q?eU2rZye4zpGKYHRRcUGSRq5wDItTIS9UjkEknUUFufpkSIASq2Nr1G4my0lw?=
 =?us-ascii?Q?uSBazymC9il6n75Gk7dK+lbNCU1YKdxAmAwMAYnpfCBaB1/08FO0ufcnIhp9?=
 =?us-ascii?Q?ODlciWDEiNfAFjNvgOtDjKVV8CLA5PBoYU3I9JwZTlp3aHBwmYXp?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 9994b0e2-e408-4a1d-e94e-08df1d80fbac
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 16:53:12.6383
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6aXwiqYU6dr/aAoHxNDx+ZBITLqIYGbTUKOQgE4KYUbzkK2JkaOxOwLfyH50y6ran+iGvS/7ZIAQadJuzb+JDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB3638

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
  - Add Marek's Reviewed-by tag. No code changes.

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


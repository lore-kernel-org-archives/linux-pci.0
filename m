Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021118.outbound.protection.outlook.com [40.107.74.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FAC3DC85B;
	Thu, 15 Oct 2026 03:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792035109; cv=fail; b=AhwjBnjGdXMLio7D/EQmu4xkm1NwtH2sWR+W0nDrcCbFVxwNPhkzVetaJpXPNz5YwFLpRIJfQCGAfM6qbYeyhqc/YcnOf4RaElAyPddfTZHNUl7Xxp2RoUycMjBENGpRcCB3RTWn3aDS8Wyze+f52IXdr9P5j3O5qLsaNRTjIMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792035109; c=relaxed/simple;
	bh=SMgy+at9k0cMv5wgUibDdR+70YTfltdEqRpU34i7uZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SE1Nl+ltDmX4/cX5qEwq/D1K4mDZBJjPgxWdBZ8+ggnRieP1IzmFGkDpallSufbVXxrG5yQ4LuYElNxVcDKj28pp+syjQCjTubTajJL1IvKThQv3yJKOfM0MjOkVIQJ2WHLSgyTj4+9r/yP5fnk0wjgx/fwo3EGShLFLZm7ZEWU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=O0i2+Tmq; arc=fail smtp.client-ip=40.107.74.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="O0i2+Tmq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X6hIsE3P6Po2JBgA5IK/232VUiuZjchQsPOBJcp7k8TPc1j7jUGsMCWhcVCQQ8+QlyQ1Bzs/BX2rl4n5BM9wfGD1vIBDgfcCpGUfTEyVo3xet9jjQmv3V2tmMU0MOPG7enZTrGzgN+2ZfKyh6RPsLFM6LN1jD245wdtFXqa4DAl58ODzDIvC/iF3lik4DYI3npW+mENaADbnmPKVyF4ShZJENIoqQ7defl8RAg1iv/Afr1xKtBXKkYhu8aPR4dWBOvL0mOeYFuDs4T5KiRc/WGV9e7+2hPkypzJQEYF/M8ccuTxABRrclu8fOkSXHREhu/vIViLada7ZuvYeTJTPsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dWNFXbU8mTXsoSbV23mV662E9hF8TCT3dlpMuGwvWp0=;
 b=DQWXS0KalZYJAHFge1vICrk1ivPWZT3f8bmJRzDSrxC6mDKIWedf0OlWtRVMaYTaxWvuITgSwkVBX3q0G7nZuVUgOtuTQe9Aw0sjXl8sQJs0xhXdsCXzlArkvXwZJIcLd42BRUm6vwMLtGYmJQyPmMUZAfC8ovmb79xMQX58YJ5PBipHb6JjI6fbscfvDarixxfltte4CIm8ghzqJymeZIC4/Qdg/cJ08/L7FG9SrQSfJ2/3SrBSk/Ad5CT7N1VOIYsIhlNTiaKSGPv1uZrZIv77H26yw4Uajh7dwulGYBD2HyNTHawXrRBcENwnm89IOSGCYpAPf78Yb0xMwF4Wqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dWNFXbU8mTXsoSbV23mV662E9hF8TCT3dlpMuGwvWp0=;
 b=O0i2+TmqVyZqdfDLOKkEiHrIW6nF6TLwnr7Bg1MxD6t9qySsz2cYrcrbkPKV3FtNc4fbc5nVjTwfXJ6VY9WOfvX+NXjFDyI5rtkIaAI5M48fAhQKRJ0U3/GYzPDSYRIuEEEOl3fEE+RhE2dBTPuGHG4xkKE9RjcoXhrrcXA+odk=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TYWP286MB2699.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 03:31:26 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 03:31:26 +0000
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
Subject: [PATCH v4 18/18] arm64: dts: renesas: r8a779h0: Describe the PCIe AER interrupt
Date: Thu, 15 Oct 2026 12:31:03 +0900
Message-ID: <20261015033103.3076869-19-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261015033103.3076869-1-den@valinux.co.jp>
References: <20261015033103.3076869-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0116.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29c::8) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TYWP286MB2699:EE_
X-MS-Office365-Filtering-Correlation-Id: 12523084-4673-45d8-faaf-08df2a6ccaaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|1800799024|7416014|366016|376014|10067099003|22082099003|18002099003|921020|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	yl8T0jTh/3KD/XLiSuwvRlPamDwDKvY5hHLRf5zzurGCKpxM6eZftPrNK/PDyfuaMDqgZWkwG8o6X1yPIwo55u7u1LxRbHW5wunjkXywnJRjfCXPJM/8sqXn3Kao7u0FBPQPhpFYF2NXJDmwB1OkUiley9UKsNLPSpInbeNYSIES24Azwxw10WzAzfTb8uirpegtAxXwNKvLBjSjT4MuhNq++F9AIaXEVYw0fuZxfE1Kre2qlCccWtRdDmEFzG4rJngg8kCP4mf82nkKnWe0UUr+P+tNaDxXl69oVQuKy2Mf9ZixD3F14Zf3LgZ/AO8Xpzap/J+XInv5Zpz61dE//H4vn93g1PypMMRlylfiaFRDxg6aZaq4KKu1xn44SOyXX6SwMJEDCQ8B60BskfbrNSdDBrUzmt19c+sh8538VX2lnqM1CyGZ3k6g3HfYGDnkOt/qf0BCxrfrukRQVSBGgoh44IgiVJVyhm7e2Dy/1tKGSbEt7JqASxpsJRvBiqlIRBEkR9X5TJI7cBYNjpQ64NyFqmzUoyNyRryFeBn0MuzQ9eSFPekZrvyZFmUn5JAZk2Zt8ChvvNRNUSSj61P3o+cP8CwpsupQVKViXPCkncMADn5QgYQrbsofVe2Op4Tq7vYMu6H7snf1fJvPRVmIxmljBY13SKIt1RCiiLgvmwTu+4ls0t1ejfTb/eZZnNDVp+fW9TRtkvue5tFgUnZ1ow==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(1800799024)(7416014)(366016)(376014)(10067099003)(22082099003)(18002099003)(921020)(261009223027099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hHGyxIrUpsFCrwICauBrKnWxzXurxc3Wg6jAg4TsOJ1O+OMksFJwBzq5eiBL?=
 =?us-ascii?Q?4ZHteRSQRRevQUgNlRb5j07+d+Kdj5MLR7wrpotpGPeRBNAqtXkRvQtFv5RR?=
 =?us-ascii?Q?R5WKFK21dCAsMRm8kt1rq0lisTfhKq3uqvSQ0LJC9Y8MPUIJcbegM89ite5L?=
 =?us-ascii?Q?u6A7u+VlnTxUumL4vTj0+QHHpIdum7weaIamcX7SCQSlTy4OR7EfWfo5z5bw?=
 =?us-ascii?Q?u/gRVjCrHbzftyMaxUCwYxtlbwohQgk3u2ncv6z6FuE/K47ECcgjMN0MVq04?=
 =?us-ascii?Q?9wQ3Lt7RKtCOZTP0i2HZXQ3R7gbR0CxAHZSzJKpXdw3tNrJoYNAUzMO8YHDx?=
 =?us-ascii?Q?nraPOtbeiJNy9yL27P+2T9iXDRp3SjCvP5prcU59KJ3tU0+eaXk8/1i8SHy9?=
 =?us-ascii?Q?rK3MTk5oQUPbSSFuyKOgQnZUWR/PLWf7X0f+u8d2EWm9erL+SnsSXWRtVL+w?=
 =?us-ascii?Q?+QLNbBgbKZ9n8gnwkdfSfE5eEyWpGCT1r9P0yBFuYMlAxZjQW7oYskWbtDDM?=
 =?us-ascii?Q?qYlF3yGFHtYi71nr793iofFY+2PG2fMlLdta2j7wO0Zup36uzVmfEn1K5LQt?=
 =?us-ascii?Q?+4Zzx/Ew5iFhHYtYQW8hZYSp+9TonfUQ2Wof0x9O/a8O4KDHf6W06TZO4KBu?=
 =?us-ascii?Q?p9hJItb29eds7gtzcPP0mYCVRa0kPBPgNvzTnFH8+BHX6sqAogjeiVPtDXYe?=
 =?us-ascii?Q?FhPqWNBH7dXJvU/JDCcbTtQAK67oGQ0eewAHtZ/XY8BsQ6rKIgWxgiuWe3zb?=
 =?us-ascii?Q?gnlCqbpf8OZUWjUI7FPj9eV8AeKLjYWOFuFQkIBrbYxPAO1UNtdb6J15+JMt?=
 =?us-ascii?Q?l4YRrYO6jUkwh0eeEnThp67Nr7F0DxkP8oXlniDqHjGaLknSNAyxEqKTT2g8?=
 =?us-ascii?Q?Ll3sCCt4YAQRep7+H/M4jhV4F/7rEgIqPFYGbWjqN+IWCyhQ4lZEGoof6unN?=
 =?us-ascii?Q?S0WbR+vTfNu/CFqiOwxX3O1BwSCY414emjzsHJ8Hy/9AD0u/CNUFdU2C2Rho?=
 =?us-ascii?Q?l0zvSDHITe6MdF28Iyph5Ws6vV3I7ZJeb2m10W7CTJ3LkLnnChpre0Yh+xCb?=
 =?us-ascii?Q?8mvWsSno0bDtejNVfeLhouX86ca9D4ORjBHqfTya0I3j1z383Wq1R5DbnfEV?=
 =?us-ascii?Q?UXoMcnsoPSzpAqTU2FeKi8lZ/lU8DhyTOusU+gkJ1nyzP3Oos2Wpb3ABllJ9?=
 =?us-ascii?Q?qh+O5AGqIoiLTo/ANL10h2g5T8IxnxHfEtFnvGl2iifBgaGKh6ILo1u2K+fN?=
 =?us-ascii?Q?y0TViJZyvD/gJoewUKph01YDAD64vzG5O7NCEDY2RkvvQDwpy17QJ7Q5Hk3H?=
 =?us-ascii?Q?467dCKIwK6jfe0A4ufqyDNvbAD3YeFs8JGEPnEbYJm3JOdyzWhRtDKd/+gtk?=
 =?us-ascii?Q?k87e8QXPZg9xCGK2oHIeFFX/Kt/5M2SHZu0V/whUD1Vz8rOmHKyx4NGkdxjo?=
 =?us-ascii?Q?hwEQr3qCvG7BxhzxLw9zDvC/1iQ5tQShXY35NTGTfzdLjUD21dlnZ6MIqX8S?=
 =?us-ascii?Q?ao6zZp85R82hWCK2g6uLLxHvG2nOQbFuf05EYUgVoAQGqCBrZbjPQySDjOgu?=
 =?us-ascii?Q?jMiFVLzqRO0H90KOhRqJwWtshPUf+tQU6qw5D9u+ClPJuGt3S1zjb3rAr4Ri?=
 =?us-ascii?Q?4OKjkII/5CByWnx7Deuy/M6D9WxIAlFzYNz1wtApIL+T85If48eUxOy8G34T?=
 =?us-ascii?Q?szWeB1wCLhuITTeKTy9sXWd3VhX+HL4B3SSoNuivhYS0GKDDsi2qzrND/n8s?=
 =?us-ascii?Q?9USDv5/RJg55AX1fAkyqzUX+PFoZPuWDZtbglVxjmrU9uOF/VYeS?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 12523084-4673-45d8-faaf-08df2a6ccaaa
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 03:31:25.5692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: epQTPVnWd9F8bWmTVNukUFLW427G2FD7/EpW/kXRXfE6Y70Fln0vaqmEE6Fu8L/9pS/o2rx4bzvi9obhsgkemQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2699

The PCIe controller reports Root Port AER notifications through SPI 454,
separately from the integrated MSI receiver interrupt. Describe this
interrupt with the "aer" name so the controller driver can use it for
Root Port error reporting.

Append the new interrupt to preserve the existing interrupt indices.

Suggested-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes since v3:
  - No changes.

 arch/arm64/boot/dts/renesas/r8a779h0.dtsi | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a779h0.dtsi b/arch/arm64/boot/dts/renesas/r8a779h0.dtsi
index 5f9223a0f446..a377aab3c8be 100644
--- a/arch/arm64/boot/dts/renesas/r8a779h0.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a779h0.dtsi
@@ -683,8 +683,9 @@ pciec0: pcie@e65d0000 {
 			interrupts = <GIC_SPI 449 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 450 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 451 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 455 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "msi", "dma", "sft_ce", "app";
+				     <GIC_SPI 455 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 454 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "msi", "dma", "sft_ce", "app", "aer";
 			clocks = <&cpg CPG_MOD 624>, <&pcie0_clkref>;
 			clock-names = "core", "ref";
 			power-domains = <&sysc R8A779H0_PD_A2PCIPHY>;
-- 
2.54.0


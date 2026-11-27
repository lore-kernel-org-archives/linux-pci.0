Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.110
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795749150;
	b=zyg5r45TO8bN91vkdCGDthYiGjzZuwq8exIO3Azjr9NgBqKlfjmM0y05wSe9k+sNKB5x
	 3FhK5nG3QogscXqO3q5A/kvX2sXhSYGlpaSwaYv/31EgmcVOz8vhwnivhZdAHLjPWwO58
	 ObEjEiPD2wO6OkD7s6kzeSsNzu0fMeHuFQiIxTTIJphblsyFtntChdSqBofC86nctDlb+
	 t4pk2aO/az1JHESOKaPYePEnh4ThjT6dqsvGHa8U3pn887SRKZJHjWnoM9DAsmQWcPBN5
	 UQ4/+lMJYynMV+ZRgHoriDjDRdaQNnt0nGu/jWI9wO+RB6/izWjMoGHiKiDzbQNhXAg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795749150;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=iwFmxQLDxgLE3ukpOoqHUvFKGw/VF4dJVRifbTwwW5o=;
	b=ASVI0Ve+zQR1TcPoM5QgbFX0IvQuzVrfALaToZiMUDz7mjHxYhllG0pOl+XKvvvxUI5q
	 Z1RmNH0Ym0p6hyQq4RRkWtK6ezZpc5qSwNHg/tjU6XWBgyHpZLhG6UxkEjQTlglZnyRK9
	 dfDHO9nlbiGLFnB7k0spuhfYqu6uB5yxnci2FvLZZ4QrnTu848NeD7kQT7d0rotdH20iB
	 SH7tXF8PI9DCEIPDVGtDBSCG88kdPtFVucO3CAVjBEv8cyx8a8PJIZHbMXgzZZkhTZyFH
	 hvXgKDRwQ5SKNV0jB3CfECj3pRJW7Hpk7m0knLzLkqzzw93e+bTPVJjctAchb9XjbBA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=XJIO9A+l;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.110
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021110.outbound.protection.outlook.com [52.101.125.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B916760A262E;
	Fri, 27 Nov 2026 03:12:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B916760A262E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=XJIO9A+l
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tH4UnmUq5IXBimTzOL+QtfZVGaos/+oTy4roDkx9U+JBGS42Yhc+h2/xnmX/xGhcHnKFQiedwuLGMoVEPkX4GQQyAB/G2tdLWFpaxE/vzVwpo3pd0akMlV8rl0Q0KY98m1zFO1IHzfUdzkZ/OxZ3a2lA36UnT81S8pw4qIMwCwWfnhqNY+Pk4lK9LunnqYoYi7zfdo5a558MtCWhFM4W6Gp+2ZRFASxEf02kDN3IqKcSHB7WJCKHjbobM7MTh4Rh35xB++kj2HLf1Fpee//LhwHRtXR1IkJF9yM3Jp+1g3KI7BpLbpduv7vw7wCQlD/TnWCxQ0XouRLjc2dAw6ZlZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iwFmxQLDxgLE3ukpOoqHUvFKGw/VF4dJVRifbTwwW5o=;
 b=JhmQZqfcGr3ltPylCffHu+NqsMZ4G8KkssmNS6hQAIyzLKlrQOmTMZgcb6S/lvFDORveiPCam6a1cNfKpAYxdaicWJeXOVwO9Eng5exjh1UF3IOqXtOzR6OtVLj152LcSDLU/MYUOmQsi2rdR7s82fXbavkDg1YIqDkCd2wYwJcGRDHv9pEW+Cdi+j/F9tzRT2Bw6Xx93Bn72OBXlbYl/u7bKsXmxwoTpdJnCmsUhMHJ7plN4+dSi6yEvtQj13+oEvFH9OYqyOrh5Gcevx37wdrhGH1SqeSJEpmWMN5SuJxrQmUZnbQmzXh1L9jIPbhioXLyJJ3Nx7nUSSISI3uaBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iwFmxQLDxgLE3ukpOoqHUvFKGw/VF4dJVRifbTwwW5o=;
 b=XJIO9A+lzizxZvJky0EyAMDrDg/IU5QxDnQQ8dbPzABb50r+erXHj2IaiyKwEsb0DmSabxA4jZZJIMGAqplU+poLBz0EArp+3Me5V8/LYdLH37bLCCPxJxf9U5R5kJGF7UJir0/52aZr+QRp74sgE3VTyeBiiE/LbvcVLAM6rmg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TYYP286MB4873.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:143::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.9; Fri, 27 Nov
 2026 03:12:25 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0662.007; Fri, 27 Nov 2026
 03:12:25 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Shawn Lin <Shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Jingoo Han <jingoohan1@gmail.com>
Cc: Qiang Yu <qiang.yu@oss.qualcomm.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Frank Li <Frank.Li@nxp.com>,
	Niklas Cassel <cassel@kernel.org>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 17/17] arm64: dts: renesas: r8a779h0: Describe the PCIe AER interrupt
Date: Fri, 27 Nov 2026 12:11:45 +0900
Message-ID: <20261127031145.2521228-18-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261127031145.2521228-1-den@valinux.co.jp>
References: <20261127031145.2521228-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0282.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c9::9) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TYYP286MB4873:EE_
X-MS-Office365-Filtering-Correlation-Id: ea0aa495-c9a7-4eff-3d3c-08df4c344303
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|1800799024|366016|376014|7416014|261009223027099003|18002099003|22082099003|921020|10067099003|56012099006|261102123227099003|261028144727099003|261026140227099003|261026121527099003|261021121427099003|261021123027099003|261022105027099003;
X-Microsoft-Antispam-Message-Info:
	hFOd+Q9aKIl46HXZ8kSxOHoHCnXeEhrI95IXaEDy1NFPNhsT7iGMo2EBGGEYp+tO8XnSmZHGk3OGttCaSOarZFNvOZtX/yWrtCUPmWJywECSijlHP9JxdmLvyVUyitRDaQg5Twym+Ca8sW1OGW4DCHAHmjqlNndlhGB9xhhGnMO/p6gJrq7bHFgwbtWNt4GYJibjcUdQMq82qIe68DPGwSUjbN8yQd7k1X6xj4po2UWF60XHXMjCfv5kHgzEdM0/magIKFEtcv2EpN4bihuiv5In/ceP4IxCCTKsuIwBmu7tQXwFhxmjxiO8qEOgYeNtsBApOzb0xNsKU9JA3ub8FQU2l2HK6dKOyUu8Xm60asbVh/YgJveqMAAsgNKjlVlb8MHSCmJmoKTshm6bE13xdbCL3uaGsk8PuJLwStPYIH8zWjLKRClqeL5YdpMXJsItg2s02YcE/Vo8i5PFwhzEdF2BawtA89fQfYwAdOf6/mWVAVh0X1Xgdee+ElGZ/WVg5g0WNocn1kRTDtLnz/zNx6KwZ+As2WFegP9rP7tXLUiL9s5bhnqKdbvEQ4VmtCDqj6XE2xI3lIysfzdviJn/Vb6mPooK6MEG30jYC+dK7jayFki2wfV3SULwjNoUCoZTidhtfZog+zwwCB+4vKs39+pDRNyIjuPs85/Nwpl76xDfjn3E+qXLuYYDIqPbxOXYlofxQpISkacZHEoevHvMxg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(1800799024)(366016)(376014)(7416014)(261009223027099003)(18002099003)(22082099003)(921020)(10067099003)(56012099006)(261102123227099003)(261028144727099003)(261026140227099003)(261026121527099003)(261021121427099003)(261021123027099003)(261022105027099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?w0qpLiNQuKNNZnJd+GuHlPOWA8XkSylYfYfLOBnEQ5JgECPRKCBaY6D2D/sn?=
 =?us-ascii?Q?WVM3qp5x0bPu4p1I6JRgaP866thFe0Zbmw3CZn25BrcsNwv5ZqgrrrWQ4jA3?=
 =?us-ascii?Q?BfDnyVrzBXpMQJ8dMyBWiOHRgPKxEW2kWslG9ecA/xV9JOXFxk0JCy4xYypO?=
 =?us-ascii?Q?cqtwAR+EdhsY6AtU5Z3ulUc6WInNcwbd1r7wfhFG2Ws3FxV5JOq6BYPCdwqn?=
 =?us-ascii?Q?txDY5oEi7KoNIke+PC3BAFgk5g1JoSi9qBhnr8OufifMZ1twQR2ULHGGuRXr?=
 =?us-ascii?Q?jzXLBeerQXl4hC2UFjVy+XHKa/z2jyqmQrFVzOAOSheqmueU1Y38fjVa4dzO?=
 =?us-ascii?Q?/iaD+dns++9CFj0pqNG149GJgOsstF7EQBjRaXkiJqq5ohM2ah57DQ1b4BYx?=
 =?us-ascii?Q?aYOjVloKtGmVCmbK7yTgE5bI+VVX9g9pBYTuXDYRtZAY8h87D7VSxfq6bXug?=
 =?us-ascii?Q?LntvjhSxL2bqKusQVWMKV/LxmI8Tqy3OMX5UZMeypISrAId9vnN4hfhE1fFm?=
 =?us-ascii?Q?Sk18KPhAnSJyscHu55CGR0f0NE/E5W5za8K3cs4O9kNuogTm70V2d4qQ14Kl?=
 =?us-ascii?Q?IFmuiWyvK/VJbjfY2NhLiBML3QXI/WCrLWRzzq6vrZrDjfJz8E6vFC6KM96f?=
 =?us-ascii?Q?++E7sJELZydRmSmx3SgCZyfkL3l+QgPlpT4OcpjR1u9kX1+Z3uqjNwLLx/Hm?=
 =?us-ascii?Q?LHhvEqx3tEFjbguk8hhsyGmtjgAS55s/dLjhFNHtVEx+1cIXufbTT9MrJ+cV?=
 =?us-ascii?Q?O/8NX6cdXKyqWC8h/pJ4TvsnXc9bDCE4Iz/VQOT1DJAsjF6vkAxQZLyI2U0D?=
 =?us-ascii?Q?duIZJ9sublBw4WHjIjUBKTNDuAcbyOEyYPxpMI8dBjjA1/qjcuqtKh1HuQXp?=
 =?us-ascii?Q?m+wnLtHWGwLXdXStGpWFvN8N5ayQSqfKiG1ex5NRFW5wdq68t7vUgowV14V8?=
 =?us-ascii?Q?hEYPxxO91tuUVZQ5kPy670bbZWVKEpycZHjlPnbLzEr3Sp6HY3wp8WONoCMh?=
 =?us-ascii?Q?IpQtGC1yeljUKy7jTbdITKYJDghpDfftSdCr8eGAiHYX7Q7lnLNiVl45/msW?=
 =?us-ascii?Q?53V2act/N1H5JQ+ThaH2XoW/HJD4cBOkB6AtMNeZOIUyyBBVqTiNhRKRnvTm?=
 =?us-ascii?Q?mOYESiK8Q2BS4bG9/dZDbmwJxNTrMiqDwpvY7OJsydLDAS8vj0/8TRAFMP+T?=
 =?us-ascii?Q?5yaRJ8no6Hj6F9d9q5+bJuE/Mq4DoAh21gU6CWXT7iVVhTqcbGDqTeOipojW?=
 =?us-ascii?Q?Okkev6LpMmDH+0N+n6+ESZDcDb5dU9826xGsTEUzENCZqQX10oCkbMI3mqlw?=
 =?us-ascii?Q?u4othlK9IOaLrtFIricvBFvdKfu7RvYl9BmT9Zpkg7ICBKmRt5bjxgKy3C7X?=
 =?us-ascii?Q?iIWzNPsh5U8Q2Q6vNA3v8GMkiffR1xTa/gYtiT3zxSlFZ7+pr3MT7PsSL1Or?=
 =?us-ascii?Q?i3hY8IQQqiWUQx7Ofr3W8dM+pCCIL8fNlA/Ss8VuVUXpd8PzgR7jZ7Pvm7Q2?=
 =?us-ascii?Q?uajQrmq0mAasGo9HbfmoLG98XtHbPMJitc9rTy86RB7mVHLXCgZcbm1HdwoH?=
 =?us-ascii?Q?XOiBPmjQ5CAZiW6UJfOuLPgjgE3oWh1jabVQdq6O7Xe3FNhNdj5ZhAtEoyiN?=
 =?us-ascii?Q?3uLZl//hYFcg6Arash+gQkNUirJda/6Be1dLhWmZ6WQHU8RhutIsrI8g99Kk?=
 =?us-ascii?Q?QTgod77UU+yT071H79dw+e4ubbYTC4kwtUsQ7sJqm+MJlROmKcH7JP1giIeB?=
 =?us-ascii?Q?AQ5WfIqvXPzlwj4cVAR9783v4nyLAlnwxK1pI1ItKs7pV8+6cFPu?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: ea0aa495-c9a7-4eff-3d3c-08df4c344303
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 03:12:25.7236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 51UOGckpriNlcUkELPeUNDjPHzr8zLBPERL4qynh3AiDr4oIFmwz1ZBbUfE7Y/OOnqFU55pP8VxPiHKQR1lauw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB4873

The PCIe controller reports Root Port AER notifications through SPI 454,
separately from the integrated MSI receiver interrupt. Describe this
interrupt with the "aer" name so the controller driver can use it for
Root Port error reporting.

Append the new interrupt to preserve the existing interrupt indices.

Suggested-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes since v5:
  - Add Geert's Reviewed-by tag. No code changes.

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


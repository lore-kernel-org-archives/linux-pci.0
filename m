Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.113
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792465885;
	b=Wqx40IAnJEnEIdK8T4YcdG2rkkuKYour644HqRw/XHYLVoSWXDppDUHHqm4Mr336WXXf
	 jr40Md2s1p/qVtzCggTMFN/TFb0N+PRG2Qv724iZVFjt3IDfP5OMjyB240KwwD1acJxw4
	 mepjZi14xnvN4ZolN9kInITVl5FNS6+fkacvKUjOo0/LzHF0R7KnzvzB1SZYSETwqWizN
	 P/uP6Qgl2sKwkktYnRfSReKRtZ6dUrapZlvyIE5NX+pjXdd0jQK+QXDiM84dbiEUDinAb
	 KerToBCH3VEkuQHYp1lSHjZyo+C+GrS7tHv9Cgf0/ISQMYVx+coeqHOeqN/lFDKLTaw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792465885;
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
	bh=NJ5CjN16CTTyd2nOijAB/nxNuLBPRcjrN/l1S4rXZm0=;
	b=XxJOTY1WGD3VG9VGG2wgkqXJBZEJvOAhBnLEVgD87BeLHoi9GLo6MKrCdazjeXcCEE0F
	 m/RQyLfmhuIxYURo6HncoH8w6YoA8TsdHJWpFStrw3k2RjhjcmLy2cHPgwnvftyS5ogND
	 aEDe7bgB6ch+2pm1vxkgt5d8ykDGBL4l39OGBObscMV8cjzZZ/T/mJapX9rBjX/G9kL0E
	 IKN81XRSKtTVbhAxt0XiYfup2VgaZKc0eFNcDglSFfx6PrXRuXH8pggKMt9zJLzrEzM8+
	 bSbY+lwdTVhm0f8J7KAsRoJ0scozhAk2JUHHDWbS/XwfEjP3Un4iFjIHH5GOJyramQQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=DE50QGH6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.113
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020113.outbound.protection.outlook.com [52.101.229.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA40B60A2602;
	Tue, 20 Oct 2026 03:11:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA40B60A2602
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=DE50QGH6
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fDjdQsGXjGg6PmuKlByOAYgTHRAza8SbErUc3arpmbHFRdBdQ2mMsJPVgJNGdm6Dd5wzX27YnxqURDUhCXq3lvHVUI8HZe7HTqZ+nV9A1VtCukX18tEM6y9+7Rq5Z8YI3RZcI2bLv80J9LIgP515Z3VqItMn8K+JA8D3Y6JYB5jigS32FyzyhcjTTPpOS5WU78VKPAs9YZgm1iAJKISRomGQ3+kFiPCPU0iVj0AVGMp9fb0QIkJq40YLYbagim2UqBQJrFB6EEoioeCGR1Yniv8GAa3xA6hM+1oIBT3f/Gv93E6Y84lmYHwqAwHqcnZ8ltMc2Km+kA/5PwZjFMkV6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NJ5CjN16CTTyd2nOijAB/nxNuLBPRcjrN/l1S4rXZm0=;
 b=oTt6bTvPQmx4VLNm/8lr+lGmremDq6LZrTI+uphswjheA8NcC6OjMm/TmhVuBv3bFbH/0Ymi34HOLWNfmyOpAIwDLuG+bBS1IclL79JZtAJBcxRPCqtvi2zKRnxjpwkiL2vK8wYvz4rjKws6AcBLQYbzdxDhXBZNMpMqRP7nmv+DYlbuvg/a7JSDZdn2E/g5ta6YKSIDpp7PObX7lUvY7m0pbb1ULq+C+nI5M5757XG1nez6nnEIHZc5itr5UwHPds8GvD6U/b478iQc2eM3uGGP5O7762BZwM4+hvIknK+abZHsLOYNxrLmEm9fm75vxFd6f6qd7zPCZ3iXW9wxuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NJ5CjN16CTTyd2nOijAB/nxNuLBPRcjrN/l1S4rXZm0=;
 b=DE50QGH6Jj0mICWq1o2HQle8p2NDG9Bs6ZK31WrIldEvJnp6xPvcUwutXkSLV0S7l/d5bHPBXK1VhhsMYVak/4C3Z5wgHtZ4ZGCgGea8WFd3KWe/uW3bsodzl2UsRmRsK0EKnhJ01YLNH0qPBA3yhfAHOW7ElqxUcYvpfA7JI3w=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OS9P286MB7503.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:44f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 03:11:14 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 03:11:14 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Shawn Lin <Shawn.lin@rock-chips.com>,
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
Subject: [PATCH v5 17/17] arm64: dts: renesas: r8a779h0: Describe the PCIe AER interrupt
Date: Tue, 20 Oct 2026 12:10:49 +0900
Message-ID: <20261020031049.969895-18-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261020031049.969895-1-den@valinux.co.jp>
References: <20261020031049.969895-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0193.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:382::6) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OS9P286MB7503:EE_
X-MS-Office365-Filtering-Correlation-Id: f2f31015-09e6-43a0-2602-08df2e57cc91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|7416014|1800799024|376014|10070799003|22082099003|18002099003|921020|10067099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	GbEV/gnieRU/DdelM90Ga1m/xxb5ihhFlExISNODuGrP3uB6IdeDUHaBUx6i/DYU9r0RSdK1P5L4aH+0dnQ5QTfU8/WBENcvLt3ZrACrBAiQ2C//dg7TyTJKGF2SOlD1fUivLa1FYoTBoEjALobleUGoJQ72T+GiVv0pvLkOVqlUrTAISCKW0G5M8KULilcJOVhee6Fqw4xF8/MFzgqNoekvcixNWek0Cdb7JaunCukj01iyQIf04+1k7RSRY3i/xFBjm7Mt9jn8CGkUDOxn1w/oQ39hTkY3iPh2blW20Emdl2TUiKJRAvRkh9X6IanHxv+RQmWVsn4dcYPediV80nC8WNeicmh7eehQeRImPs2RwN4sSgQ+xgdXNY7XL68CgQxIE56KsEFU7mMvaFcdPWXTj5FY4rSuVIs8kIK5K9OffataZtg95a9kNhjnx1faQyv6SjYY60pZ1RTqCKzkc01hA3C4YhrGLm7qXrPz3reLZZxOwO2XTgGK+tnaX+ujyimvrokyO2ge/15868QyDqW/ME9MvArm+hxcqK8Ke4Vtq+Zy5klVeJ778FUtZXPBQRkBh3NPk1ObMK9f3qgQrikGO9M1sbKu51aF/ERvdNq90mnJHQGR9qDJtLWIN3iQGT9maLBQlKHIhmLgvrj9CdJOMQ3NegM2pqBGBPdkARJ9dhIAxzjCmPoyUy+0h1jaNSXUSAJZIPax4fnucUFWgA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(1800799024)(376014)(10070799003)(22082099003)(18002099003)(921020)(10067099003)(261009223027099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6pRukXpQ+V/1pZap1IAFzupD8Qn4bw3M01WuAo7Y52/G8Ui5oq3zQCgaXPz1?=
 =?us-ascii?Q?TK5hjX7MlpLzc4kH/IqzFfX/nJlpIlRFeGpgx3FbOaew2VF8D6hHOUmNLXeO?=
 =?us-ascii?Q?IR59U6lv2K3KvB5+B/HhzYvQ7sPwaD6ItwWRAsO9cSy+WgGtugvbQuk/nyXW?=
 =?us-ascii?Q?20FYm1uw4m3purwK90oQnQOjiX8rmcAlQEf7e7yv62ZhOTQH3s7N49EHrQ9m?=
 =?us-ascii?Q?DQmapccmY9GwZjNjDlTNuVCNSz3OFQPaRykA9IQFXSNMm6F9oDvvrPDtduYf?=
 =?us-ascii?Q?id1hE2JUn4hY/4pMg8ukhmfeIgq057/KnfBvuhjlOhlRmQX5h3ThgMW2D5Uo?=
 =?us-ascii?Q?NFmFOQAMB8ihJMB1quPwPcwVf9h4vuqh+V4CXWH5oMA6tjOiC5B8SayhEViH?=
 =?us-ascii?Q?optQhIg8NW0y4dwwOOSm/BFkZIa0OQ4AK8o4+/uteVmBn0tuzOOEujKJH5YV?=
 =?us-ascii?Q?cLFVrIoZDfhyVQWyC8y3vMiieDYC9/lftiJX+uEBAFEKWrV+mIRIi8Wru+fH?=
 =?us-ascii?Q?DFbWl7Lq+f5FKK+cbGRgEqoubMyLtChbE5FgC99tPChNv+YCtVXVN+yaJPxI?=
 =?us-ascii?Q?vHRQ2vZT2J3TmuL27ShN6lEXRiu3nkE3QVAjxqRmuraeK3ITQnCKtzJxVyMy?=
 =?us-ascii?Q?Du9OLPeteSgtWBbTAXPuJC4ts1biPZJO+TF44MzPs2efeqsiNz5FFk62IZ7V?=
 =?us-ascii?Q?c2J6LB/i17HQFtUWBV+XR2fh1Zey6DBzEPJmoL2rIGFhopfsNMRc1fXY8omV?=
 =?us-ascii?Q?vgeZvfE9SizR7gPlH5S5BYhRf5WDJw0zbpOB8ZNXXXW8WPBp3GgnPt3M2amY?=
 =?us-ascii?Q?AYnbCijJ09GfsHx3NynJzE2AiwpkdlUSBYJKbRh0sPg/muQPx/XYfVYgu0Sp?=
 =?us-ascii?Q?Y+4heYOd0rrRAQdwG3lh6cxeXNfhQ2y6aqqpZuP2lKrjH0DNMZD5Cm3vbRVs?=
 =?us-ascii?Q?5tTs0oFwBM4xEitlUyJqQJuGeK9bEkE3jANlRH2VMK05rHkaPrYEVJtlaNJi?=
 =?us-ascii?Q?d741R54dCRZj3pbfCUEIk4OZwAnoNB42RZEwDJ2/MTUE7Ze/NwQzWWO7YSXw?=
 =?us-ascii?Q?YQaKvoq5m8gwefOZ5wQpzYpxisPgR/ed40N3ZDXqvYoh5vTDJkfSVnUwARDs?=
 =?us-ascii?Q?AdhoMG2MOknx02b8fgPqwhMqdPnWmDownApuyf22sGKlWhNdzUgVB0J1ONPC?=
 =?us-ascii?Q?qW/d3lb/M8lUT2QXilbvSd+tn54JPdT6tHw7EyHTSx5WCHcf0UYS9sj6wX4g?=
 =?us-ascii?Q?6M/S+8/tbXQXZmCt89i5TScynSIEfg9XkQKYX1JRiqTSUaXGKr+LKgkf7C68?=
 =?us-ascii?Q?LsGct2zqtjE6rjen644zSv2wU33fEjYJm6dJ58aU7Ip9APYL+G2TddSAtz+u?=
 =?us-ascii?Q?Kho2HmDJKgA+rHQmlnXkgbLPko1HBSZMq1fWSww4fUnxlQnmCKDzrbgZj9kq?=
 =?us-ascii?Q?fDYOdhURcUlIa4YaeDdWYxUzQL2j+biAih1rZsdDmfJedD8bRU5qCSKf7yTt?=
 =?us-ascii?Q?B7ZdT9DO2AOz0iXg3Zx7cqlw92XechAp5ukGaQSJK+v0M6IxOx76T5D2La8i?=
 =?us-ascii?Q?In4bMbj7FsNPl+jzk5E7Xl2JfKNX7PRN+ArG5Rxs492BODRSBbkIy4re7QW7?=
 =?us-ascii?Q?Hd2yMnwccMfEV0XwLVo1bil66Hg2S38U6n3R08WVKt+y4Ose248bVboXhvpm?=
 =?us-ascii?Q?KeW9tpvYM7spINlw6izVvbrVPwW8gipa59dRLZOdsJSLf1jNSGBr1e5QslyJ?=
 =?us-ascii?Q?5GlzqpcMkXWF5jvgf9kmBkUTWz2FE/c030VpVmTvMOSj7mJrbLkd?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: f2f31015-09e6-43a0-2602-08df2e57cc91
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 03:11:13.9749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ouw7PDFEbpcezmKiP3NKuInCBYYUS/Rs8435OTghSMCRew5CGitYDECcRsCKSgZUKygwPb+P+SJ1ik6r2Tagbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB7503

The PCIe controller reports Root Port AER notifications through SPI 454,
separately from the integrated MSI receiver interrupt. Describe this
interrupt with the "aer" name so the controller driver can use it for
Root Port error reporting.

Append the new interrupt to preserve the existing interrupt indices.

Suggested-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes since v4:
  - Add Marek's Reviewed-by tag. No code changes.

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


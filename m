Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.113
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792465864;
	b=Z/Mtf8aSBmGVkGGJzF3MUkgGhFLml0fRjRCprdk6w6iLoNNsewW1nYYNuGGwiuteQ3ZK
	 A+Nw2Ha/XCtplqKxkNwApaNn1qqOYkHTxooc/SY9a+W6qrHal9N1q1o/YoIbnIO/u28by
	 troovxfuSNlFDbOZMchmL53r4Tbd/ooUcaWesa+tUhh8ZbxJq6UYQjkF4SlXiZ/dEQc8h
	 vKvWSSyOiZuGTV7r4lxGB8Xi4VTw431ECZPU7WRrAYoJC3eWwHxaSKPIgiq1khpyflFez
	 g2oo0Wt/6ltLXyJLbeuc4xWHHOUjWfl0fzdIJOx+a3hjhAHdz0j/r7yRy73T6L5F1wQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792465864;
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
	bh=F0FnfoLyC6q32wPX4RHar2ZODCuQa5aUQRHaUT/TBOQ=;
	b=42uoyn0lXqLZ+VlmZM2rbJa7Gin11miR6PFN1DjPdVrBgR/8PDmgHa/2QGsEiELItndW
	 B4eqAzN+B8cBp9PpHR1d3rfOfEa+uIIj1RoNt52wG+8GaQWJ/f1cQDT0hV/8DBV1Mzhuj
	 E4t3OVHxeedwT7HZGXJnMO6XtbaD7JvRR3lVZk2K4ESTQEQRmrI36IMqbUGMYJ7FNphvS
	 V0vygK1gEHJgxzTpPe+2WNHnBr8s+lzPb3FxXuBMQQvlPBaUPKDCLih01Hc9MjyU7YuR5
	 ORIuBx61KhnRhpO6SdzUoWW1jJ6gI2i7Ru130ObtBycfi+1lfNMXAAGiIomHgzp14mg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=B73wXFzp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.113
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020113.outbound.protection.outlook.com [52.101.229.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0342C606AF48;
	Tue, 20 Oct 2026 03:11:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0342C606AF48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=B73wXFzp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E1iwi94bsB3LSFaYZP234FzS6Rw0lcjlO47zvYorhcz1yMHIdugbe9mXij5asPc4aJarW1wCL7y6nbj7X78B0I8awluztHafp6+w0nsMtcvftvtrcd8q0M6CS9H0hXr39JDRAac81lmCYV24G2XLJVw47wmXCUvaGqEfTkWmmUzxRAOCdiBJ2AMXUO8ysy+TYrs38Ggj8NfVek0+vxxp+itfunafSpoJkd3WMaDcoBmWtcPYrqevsnwrP6vZzjinFli8tAHKgm/fBe+bG/tGsKGFAmnMS0H1Ue6YYuVHr6wwjA0Ev+ID8mGLmlVxy6mgDXyRbFNDvkRxE7qELSikIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F0FnfoLyC6q32wPX4RHar2ZODCuQa5aUQRHaUT/TBOQ=;
 b=U1bQARUkzI8uyzVHmhQGhPal15K68cBc/2On0z+wCIbpRszkUzYeFPUVSNR2gtFZl/7KSV6i2JXgVG0DstDVBzRaWgTv3hej4uJ61OskV0ALP9KbwfNXjm8VirwhIv+E+Mcp07xIyjfJ/f3LL72rDInK4IKV5/SodxjtYbHfHzzTGowJaCUb1l0qSVNNu9VDtjX+YUzjRe3UqFP7pD1Y+Sxy57BV9yIW71zD9JZrFgyjNPFk1jToem0DyqjQmlHUHFSQQKIJEQwiTUuSLMXHVv3OxbPW0ILfCZROeX5wbGoF+cKJ0yZtVEe+cIBryZ9oL9pv9f5eSxEOLb2H82X4TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F0FnfoLyC6q32wPX4RHar2ZODCuQa5aUQRHaUT/TBOQ=;
 b=B73wXFzpurTRYFO9VNh8S+xHFGQkE/AH79JSKeIf3wb6YooKnB4qF6Tt00swltp5Ue7ilpO63gh8TPWBa1E78F19yWo3FKguiSlqsNo2oXXZ6ny+8aM8unN8qRDnAABUxdpWJJtZW/nkSz1ta91cuhxzfqbMU2v1b/rtBTAE+Ng=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OS9P286MB7503.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:44f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 03:11:00 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 03:10:59 +0000
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
Subject: [PATCH v5 02/17] PCI: dwc: Factor out the PORT_LINK_DEBUG1 link-up check
Date: Tue, 20 Oct 2026 12:10:34 +0900
Message-ID: <20261020031049.969895-3-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261020031049.969895-1-den@valinux.co.jp>
References: <20261020031049.969895-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0036.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29d::20) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
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
X-MS-Office365-Filtering-Correlation-Id: 59ba7abd-d144-4e69-8926-08df2e57c433
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|7416014|1800799024|376014|10070799003|22082099003|18002099003|921020|10067099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	Tp5u/R4ZtviWKCI9663hJk0X3ktGmJ8lGi3EHxzs+IBJypIUxppP5Zw8QWzVghNPeQ3hwf2tGQV7hToLylogCXGROG93/jAgDklVvjzgZGRILieTLnu1Lu0chdUWiRAMKNdm6L0upcmPgVqd5mqqMXMG3aP/qLoqRhBJvUjm7rucN9ZtPNdN9OVH319UZ62rZ1yEVej3r8WYzcaV5WmCJ7p57KZifl9BfOcO0KYRdTNGGj5q77X0NaIsnN9G/LQGd4PfXuPWwc2p5yneSSeoPDyACprBFkA+m66tabszo3XVsgvtTAgIEgmZ1XrlYvXIc7qovzeND7FkHsOVaG8Bz6vxzABSoU0waPTRPS7cg3T3mtglWEUMQJiNiRb8Y9n3oqhFT7EQb6RLsMC0RfoyXs714D+bAyBx/ApnjaJoJkM4LGmX5805eCKaKvw+xDDMFTJyT7vZmBPa5HFrqir5fHY2WhwcN0mMA/rzAZK4nujXp1B7LSSX+/QQAxKypDU+SUinN61S6hO8lSaVb2jgnQIl5hdRiotvysrTlUrBP/ApALlXSP2Dn2G3WeDbElSJ0y4usfUQP51P2jQBCPukm3mYcNQXuY8tLh2uI6r7VMATLuWE2IOKx7vP4kkXEofnMTIrpFdADsKwOV3UmzRvK+Vy8N6/6FXMiQJfUXpBxHP1tTYsOzhGq3Tg+w/ygQSCvK0zgIIEoQrIVWSxsw2OBQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(1800799024)(376014)(10070799003)(22082099003)(18002099003)(921020)(10067099003)(261009223027099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?64tKP1c51fC54Sh4ME+MmhRsASM0PBwmIiX1+iMfHgv7LV9MwAjAsMufZGCB?=
 =?us-ascii?Q?/YeVYogPFOf53scyyf8SgF+O7ez/o0DzCV25FjhkZngIYmlYS0qxdFy+dOlt?=
 =?us-ascii?Q?d8FKe8Udx7mC67gm1gN4gkA09pj2tZ/ILY8LZO/DrY1YyYAOXoC6s5kyQaTF?=
 =?us-ascii?Q?45hkLckxZix+zVpdlVSpTiRr2vUnUz25dHtuqMs9sI0NtEu4DJfV5m/RToDX?=
 =?us-ascii?Q?sFPDB2GC5LfgIpH+apDowdXPHSTR4Kl/96akSstXJdJgwlUgqKToiwX4JQNS?=
 =?us-ascii?Q?pAfCJJL0c02DGmJpE4McVNkponpzpbdlOdxY0uEnCCqIphYK8kSm4rFYcmu4?=
 =?us-ascii?Q?0aQarJgMC2mxuJy+EL+eSTO78ap1YTXJWz8+HUeWL9LCITtVxRgZGAcsgkNI?=
 =?us-ascii?Q?ChkFs1+ShyTmd944qgYVu+wbjz6F+dflV4kftfrC1yC74umqJht3gkJD8RY/?=
 =?us-ascii?Q?KgjCNlO0Di+J+Qn7ovQmCyRcGOr+XPEtVlTz7qyrsO+opcoBW3d/nSNTiTzv?=
 =?us-ascii?Q?g86RfbOJsUTXZdZHBhC02dnHIKWTplc7f9P9CynTbqIX0H1VYpcbUwiIqSGD?=
 =?us-ascii?Q?WjyzhSoIcnLvGeHkzuUCy8+8PB9YymDb1yjltWj5HnanAVsB57D8ywy+pFd2?=
 =?us-ascii?Q?snwmpEHAXnkyH0nSQhmPXVBkAZEDunF6IFokCwOvHW9ktgRuesHQUyB1TdYP?=
 =?us-ascii?Q?s13JR7WCiQhQmCYKq5ODotaVvRtZEQkjHRknwTaCCNmA4TeYrnCc0xzQmCwD?=
 =?us-ascii?Q?45A5pjDN712aeiYNLh3uqB16FTmLpcF1sVTiIZk57Q1qmBabh6j6DXbE/cjz?=
 =?us-ascii?Q?h7JJHzv89IwdoQnVj5WehThG5G2FfZ5jqn6/umkZREN1rLuStCy1VYHfM2sR?=
 =?us-ascii?Q?KSIou1NY565YDv8rk2tN8qeY69XMt1Z49lawNqhHL/8fMTghrOlrAkHv0gCU?=
 =?us-ascii?Q?iwzY6DZ//wM0yrXEDfqjjfFHvFuwK9cSoKeaqaGVnrRP+EOSyTvqrk2rV15v?=
 =?us-ascii?Q?hd+YT4hztlFWIpdq88Pf1s8ABBqw1JOmfLucEQt7DKRqOTWSjZq7KDdsrJPh?=
 =?us-ascii?Q?nkRAsJXv8PB0R20UxtbPfbdwYUmS8XhLN/6wjSZ2XJopq+617cDzpBUrwKI6?=
 =?us-ascii?Q?lNw3juY/BiC41ALvl5F12zGPCkyQBfsbDIF6ctQ2xKnToVTPACM0wxoA+7K7?=
 =?us-ascii?Q?+7R6RIH6Mj6+R9+iFVVBUfI+RIoPaMyZs5zyO/6XB3Si/8copjM80C0DQ7f9?=
 =?us-ascii?Q?37wV580MRUZ1K5j0GrE2tOHx9OTRK8t12aW2XfVNXEVU8D8GUdgBD+NZcJ0L?=
 =?us-ascii?Q?cIEyMX+Lpd2zKAyxvwX0/oSt1b+xMTRc0I0U/jwd/DL1aMFg2MUKPCmrxx98?=
 =?us-ascii?Q?DD4vo4SdGz1zWKL6363XTtwgpXGM9asGaC96z/nAqUbDJV5ZB9hhDaiI4KTY?=
 =?us-ascii?Q?SqxhNrHpZ/vEWBDv/o3ZtbfHiK8pVzxfeQxzefdBoTnlxmYxMKRKtfagg0uR?=
 =?us-ascii?Q?mjh4BHwt8xG8P0n45sflVF/ixThOM3Np6abP3pMUv3A7RRieRYcSCuRmkfcc?=
 =?us-ascii?Q?CpTXhsiUaPAo+hjBVA+aSDulCEXGYyajtJRUzl8xDeVBdoOm2LEwKCvUIMPS?=
 =?us-ascii?Q?gHW25exbZ82sFF1EGgvFPh8dk6Hq5m+zuLvPq0qr0kT9iVmmaW9bk6S5bXQs?=
 =?us-ascii?Q?IsK32Cb7uGsWo6ZpeSzWJBiJmpAZjgSmhHvoIryL/cgIxgk+nUWIc8gT2iO/?=
 =?us-ascii?Q?8tl2sknVc+ZCVCvoKlD1aXsgxq5Q9mJrx92l7bvjII/QLpfAS2fj?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 59ba7abd-d144-4e69-8926-08df2e57c433
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 03:10:59.9406
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qNbzUXUGt0qxq8bGdy3pVFciKk7ye9tjvRVdoJscJqgBDTUqLsu41asEJ135D+QrllOSJQvk4/haRYHaB8BDbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB7503

dw_pcie_link_up() reads PORT_LINK_DEBUG1 when the glue driver provides
no .link_up() callback. A callback that needs a platform-specific check
on top of that register would have to duplicate the register read.

Factor the check out into dw_pcie_link_up_debug_check() and export it
for modular glue drivers. pcie-rcar-gen4 will be the first user: its APP
link-up events remain latched after the link goes down, so it has to
combine them with the live PORT_LINK_DEBUG1 state.

No functional change.

Suggested-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Reviewed-by: Shawn Lin <Shawn.lin@rock-chips.com>
Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes since v4:
  - Add Reviewed-by tags from Shawn and Marek. No code changes.

 drivers/pci/controller/dwc/pcie-designware.c | 15 +++++++++++----
 drivers/pci/controller/dwc/pcie-designware.h |  1 +
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index c726aa71c830..49a9ba910ba8 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -817,17 +817,24 @@ int dw_pcie_wait_for_link(struct dw_pcie *pci)
 }
 EXPORT_SYMBOL_GPL(dw_pcie_wait_for_link);
 
-bool dw_pcie_link_up(struct dw_pcie *pci)
+/* Link state from PORT_LINK_DEBUG1: up and not in training */
+bool dw_pcie_link_up_debug_check(struct dw_pcie *pci)
 {
 	u32 val;
 
-	if (pci->ops && pci->ops->link_up)
-		return pci->ops->link_up(pci);
-
 	val = dw_pcie_readl_dbi(pci, PORT_LINK_DEBUG1);
 	return ((val & PORT_LINK_DEBUG1_LINK_UP) &&
 		(!(val & PORT_LINK_DEBUG1_LINK_IN_TRAINING)));
 }
+EXPORT_SYMBOL_GPL(dw_pcie_link_up_debug_check);
+
+bool dw_pcie_link_up(struct dw_pcie *pci)
+{
+	if (pci->ops && pci->ops->link_up)
+		return pci->ops->link_up(pci);
+
+	return dw_pcie_link_up_debug_check(pci);
+}
 EXPORT_SYMBOL_GPL(dw_pcie_link_up);
 
 void dw_pcie_upconfig_setup(struct dw_pcie *pci)
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 419932488280..2ce61709b58c 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -618,6 +618,7 @@ int dw_pcie_write(void __iomem *addr, int size, u32 val);
 u32 dw_pcie_read_dbi(struct dw_pcie *pci, u32 reg, size_t size);
 void dw_pcie_write_dbi(struct dw_pcie *pci, u32 reg, size_t size, u32 val);
 void dw_pcie_write_dbi2(struct dw_pcie *pci, u32 reg, size_t size, u32 val);
+bool dw_pcie_link_up_debug_check(struct dw_pcie *pci);
 bool dw_pcie_link_up(struct dw_pcie *pci);
 void dw_pcie_upconfig_setup(struct dw_pcie *pci);
 int dw_pcie_wait_for_link(struct dw_pcie *pci);
-- 
2.54.0


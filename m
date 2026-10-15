Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021109.outbound.protection.outlook.com [40.107.74.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB6F3ACF14;
	Thu, 15 Oct 2026 03:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792035086; cv=fail; b=fyxK0HOyOsJnHCARqh7lkemRad8ilCVokIQMz+hHFrvSIs4w1OKWIxce5rgsSjRKtgjYnL3oHNCFGK+trFa9KAARGZa5uS2KZLXBFCMoTdVVazp6Xgfqm7Sz02MttrmpMfaTpdhrBhFwR2KYS4JW8mOeux+EZeRypFQOwztg+T8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792035086; c=relaxed/simple;
	bh=pT+Ob9+b3v6UVP8OuT5NVS4pToccpkDXarB+FpVCpVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F4lDLr+ZY8KHhXZJpervHhxHsvSppsJwDn6ieNrOctU9xHeXoT/A/fUvHy5DQOp48M+gOe+2uat9boqBSY/csYJSNGKz6RZQl6A2Rz8p7aRzcpRJaqpuqX0YN0LLQ5rqwTK8cXm1agFQ7/ZeIHr+EWkSIdC63wGfQgVfCfnEGxY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=Tdjog07Q; arc=fail smtp.client-ip=40.107.74.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="Tdjog07Q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=liH9fSRkkAqlX02ZEjk6qFLzbJLsnURTayQU1vB5dLyw7PHwXcj1Ve2Mf1TxYZI4Mdk9eQOYl+0+Ct11wmCdf7S4JcxUVhbAHJzWzO4siYhvafOEwLzXAwHs6jRpJdhOlXChBxkeu83dXLpEFLVVWvDqOiRMsBxB+LVmkcmy2tZPNelAogfKQagHMzdkqDKI/4xmTP4AaYAYyu2DxP/Nrvy6eVJ+qsLRuX2JqsxhSWe+jJIRE0xcFjOn50XH/oyF9sdT0lgjCBuRPeW8qIpM0xjOYMZeQUlZ1O/rG8jiG8N2pjDj1HbafqmGWuQz8P5QLmwSOvG7LEjCeZ4klu0PrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dA9b6kd9HkZTqu+vCUSLxY5oQCF7Q+jA3nDwuTkyBT8=;
 b=BQvZC59eAWfbdeRloc6jmlC80ZGcRGeI5cOqedmmMp5q+XBrfZWQgtFar+csVAIvvDXRowCk4CcY/EAKL+4mVBDpgIxuwl+C5BmOE1VmYT6Jep7YP13u2V4f679vW12z6R2LVCjhF22v1ccT/xUkeuRKz17n2Jj3uWHo+hS2SlQTjcPgqt+9bIHcT8y6Y8XORPbsf+KmJi0LMVwrE0hD1WbcVgFykQCWar6K8EoZ0/ou8bEuU5OPv9rYyEZfgjcr1uuxQR/HO+V/DPHfAohlWn11g89SQiJvmRjowjjQG7q4wsF6x3ge6iPY42b1WV4gZW7883PEvULsYZDKrsQIgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dA9b6kd9HkZTqu+vCUSLxY5oQCF7Q+jA3nDwuTkyBT8=;
 b=Tdjog07Qx72LIgFjvftgeshWZauyiMet0RiKYBkq/+w75FPkVsegXrx5JLPZ+swiOVrcVA0qw+duHxzzppcSTRV1BEddDI+QnjR+b/gM+xFtl3BrSX1DUZioR3LjZ83652SMQjVtF5kOYT9rheJzAaQYor8q8xISGySFcIL27Kc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TYWP286MB2699.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 03:31:16 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 03:31:16 +0000
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
Subject: [PATCH v4 07/18] PCI: rcar-gen4: Assert resets when Gen5 SoC PHY initialization fails
Date: Thu, 15 Oct 2026 12:30:52 +0900
Message-ID: <20261015033103.3076869-8-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261015033103.3076869-1-den@valinux.co.jp>
References: <20261015033103.3076869-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0075.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:36d::18) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TYWP286MB2699:EE_
X-MS-Office365-Filtering-Correlation-Id: e14d4b49-f8a5-463f-6bd9-08df2a6cc4cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|1800799024|7416014|366016|376014|6133799003|10067099003|22082099003|18002099003|921020|5023799004|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	hOwfbES5yAtEMWrFsEI74ZQUEBIj5iDHhJvlBrzzT9LzAZ17wm1GdgB/v0jNAujBfKzXtdH0vL7I09uhyG/+9R3PNtycvGIx8M4js5m5oIi78r6FmVc0cJvYWHJlB3Y0weWrT1+W+mma+6ke7YlmQOvvnmamsLABJ2or5beJj6bmGqx8lHdUS5ZIOYYWLqvlVA5bDmFwh36ZKwALcYKd06n7QqFTeu5GVv3K5lq2mGmuYGJyqWCZ8oJf0z6S9mCBTwaOQwXR95xOJBC15RkTORmcJrrN+kFKX/VBpku/8JpwHJZ6XWFaHq47c0miEvH/3g0JcmRhyqjWrl8qbOETgE9VvkJGGai7aF1GfzDuAdD6wZa2os4a94sT+1BxxfwYsKI4ASMm5HchAVnobvJbPI6HSlKr25h4Y6fmlZJ92Aeez2M8Yf8qn2ZBiES2bus8L1wiOdqpqNdZeXH13l64i0bljZy9L1e06sSdtFSdzQiYv6zR1KZF7Mc6gYH9mH3uFvTS0otFYDMqtfmI/9yOKohLP/xsdq+Uf+o4DbauzzeVOrItsJHq/9jJYZxBs2NpXjoptuZlZgvYjzduxYTb8GRk5GHkNAFWETamX6p0VKGWI7X2E5NvJjfcpc6lAsQN2guVrpj3CNpdTl63d95S590IVQM+N9xWs5Jh3HiopKjU9g/gN4xopc3pgJTndVmPJ1TR8t6oeEMGdLsEK+yVtA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(1800799024)(7416014)(366016)(376014)(6133799003)(10067099003)(22082099003)(18002099003)(921020)(5023799004)(261009223027099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ysb2GlBH1j7qSz8HfQVp3DdkstdYPIChr1fX8euvDTG240nVREG3lcwGI0js?=
 =?us-ascii?Q?2UdFXXvJGaIPz5trrCHAxxQX6BkDb6GXCJyT6xonA87fq9VGuTitD3SvUQEG?=
 =?us-ascii?Q?WhqZNSc1da2lRUBpY9tIVIKBtK+1EJZ20mQDgCo3ql3VbVSHpH0zi3Qv8KXW?=
 =?us-ascii?Q?QK3Nz+cBRFrlw4vLAvJhb8xJQj1wYswbYXgd6sqZw2FVJuFhOpHKGxxuQGdo?=
 =?us-ascii?Q?CMrej7kfdPx+kmMwPTn9+DzRfHWJxGBgUehvcQ3vKECcXcQn9SMjGt0yMlMg?=
 =?us-ascii?Q?LRIMEIiHqKuQogTIR48Qja5DzWVUvp8glsKXVU31ZCgV8RZjxkpJAljafPte?=
 =?us-ascii?Q?Q8TNyzVUs4irsC8sItEgBsIozHaQH/I/CWY6Ky2j61p8dbhnOscbKnVRAB25?=
 =?us-ascii?Q?CSkD3jgaFzDi+NoP7w5YuUWCkIHfSrd//g7VA318ix9p6bf5IzqWdLRpx7Yn?=
 =?us-ascii?Q?B+n48Kn1oYA9kCunZMqO2iTD3toM4HAB4mvVD6d2C47NHJb/TViFkFj+T+o6?=
 =?us-ascii?Q?ABwvG74zmhbXc1wMkxA65ZGnrKEzOdRX7bZvz3hINzJwPr1CJ0+ZK12papnM?=
 =?us-ascii?Q?dkQMl3p3KubylLjMsLpFqXFvVLAmH75tHJJCNU/8VXduFsRWcKev3s5de9Oq?=
 =?us-ascii?Q?1DY9BsjnRX/fikz6D2ELgV311Pq3lCTgB/NIuwfjUzArbupufazqRml3rCL7?=
 =?us-ascii?Q?RUGuGCFDt/W06rwul9bnW7GgHyEo5qRgnKX1PkMCykNVMCYW+FGpW8Z2QcFY?=
 =?us-ascii?Q?TNSB93NDTEeeVsGjnvCcvtYGYwu5znMiXrJDp7vw5fHTHpA2JrHwYQ5d9Gvz?=
 =?us-ascii?Q?FSHqJjlcyMQw7zPFqTNQCeYcOHiPIJZajNkb8InvHGgL2SOVLju9EtyiG/D2?=
 =?us-ascii?Q?CWB/G6DZLYZcfYg6pbfQEV/Xs0azNJDy+XWUh0kXfwb4D7lZzNl66pH1ZsSF?=
 =?us-ascii?Q?ukjzO7xQxpEAy/aGh2/V46OIltWdjMnJhpQ7wUcF325T6slwPLMf0PdpErd1?=
 =?us-ascii?Q?l8Y8KX5NmZ4Ghfa1d20QAAoDHloirY2ymxm61jJhHDyxo6lb3d8klVXxJk56?=
 =?us-ascii?Q?W3wrC2a55bWFivD/ih9yLlnlBPQ3QiN6LjMbs7p4ObssQduq5xj5JjJfbtmF?=
 =?us-ascii?Q?2HMrncB20XT6inxns4aEVGXlL1jN0QD2rWs/f/8MB25WXNiX8FQvVRVJw7AI?=
 =?us-ascii?Q?dWU8Agme8KFS9xEOL9TkwvRLDhGhAf8/NuOVIh38FRULyjVi92w1ZYvee6JO?=
 =?us-ascii?Q?sKVri0pDLhBRBUG4s/RBZU31pM+NYwR/N+N4Pdarzxpfm0YiwCecD2hbcqNz?=
 =?us-ascii?Q?GpXLeq3xD3ipJ8Y8481V7z7GOjnLXefolv3Yl5xf+pPhL+BUki52raIDJobu?=
 =?us-ascii?Q?BqduCJzTYjmqqR6waD2UvePgJYTvxQtcAGLhCfhcs6TJIWJr9QwlIRbzVFx2?=
 =?us-ascii?Q?C2namuZRuSTEm9cZjcYwHyRDv/cv+Jde2Sh6zJfGhvJNPsnfARye+3YFL0aL?=
 =?us-ascii?Q?XQ0JCydA1IgufFwo8YDt7C3dzvMTY2VHWtkBuPSrH5Nt/MmoHj+KV8YRzRhY?=
 =?us-ascii?Q?epBOAmR4PpQ/HKkVfited9zLbi7YQLVc5yn58UvKv4Va/ZmJAXe9QMyusj10?=
 =?us-ascii?Q?9kndEAJ1vUA8jQKougd1CfSyV8bvnNr1NIcoCnCGJFofnVebBBbJjyRARbwE?=
 =?us-ascii?Q?Ov/P9x3Ge89xF6LyClSa1xDZaA36SFkpyAwYGXLDawUa2J1Ym8TT8wQk/Hhl?=
 =?us-ascii?Q?XfWOfQybMbFZpPtqTyI29aOuvF7yMhgtc3kNfzuVFKY8Juf3qAQM?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: e14d4b49-f8a5-463f-6bd9-08df2a6cc4cc
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 03:31:15.7606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vcosx8tI0miM4Zsu/8bcwHn2IMV7V74hfJ1/+cTrwbu+U2dyEMDSouG3Eu8Msv8yD7RhrCt+1Wze72/vmHgkDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2699

common_init() enables the clocks and deasserts the power and
Application/Local resets before phy_init(). If phy_init() fails, the
error path only disables the clocks, leaving those resets deasserted.

Assert both resets before disabling the clocks to unwind the completed
common initialization.

Fixes: 3283c4db6009 ("PCI: rcar-gen4: Add support for R-Car X5H PCIe4")
Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes since v3:
  - No changes.

 drivers/pci/controller/dwc/pcie-rcar-gen4.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
index 0a845b67f6c1..e1b748a9d58b 100644
--- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
+++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
@@ -379,7 +379,7 @@ static int rcar_gen5_pcie_init(struct rcar_gen4_pcie *rcar)
 	return 0;
 
 err_unprepare:
-	clk_bulk_disable_unprepare(DW_PCIE_NUM_CORE_CLKS, dw->core_clks);
+	rcar_gen4_pcie_common_deinit(rcar);
 
 	return ret;
 }
-- 
2.54.0


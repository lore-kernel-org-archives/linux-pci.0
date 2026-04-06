Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020114.outbound.protection.outlook.com [52.101.228.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195C3337699;
	Mon,  6 Apr 2026 15:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775491058; cv=fail; b=gg7zD0+ZqMT6n3I3ZyqVrDLmHs26bHJTqoN/4Q9zuG1HChUcEigWa1UaOp7IxOQJAGDahZOLlnxRgFVgQhD3p2md3PwLJ5pEz+0HsVao2aPkbbUOoCXal5r6OfdPsUneYvIN7Tv8QU/pzd65G6sJxga7L5OorXSD6BJ+8qrE5zs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775491058; c=relaxed/simple;
	bh=7W7EAIrRY8jLga8ADH/lj9w0euD505H+9+XgdpG2QbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h/XQlTuu2FIUtVYkhq3kEAJOqq0euN4UL2eYDBu2tP/Uev1us2H8fpEr4fStV44Ecy7RM3tgPCpGgBFJtzyxF6FKtWzU0mFBjkOivZHcT0aN0UJpt/k9z7sDoEaLdS0utYMsynK77vaEVMU6hPM4O3NKqH3asg/9JKY/4zH9Bhs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=oOksn9fb; arc=fail smtp.client-ip=52.101.228.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="oOksn9fb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oTyLPk5zxEuOirvGNAGk+gjSuY3DUgQOpLU6qdOUqEArK/JDrKF7Nzbq5V5tfJpo6UlYWcfc1GN/bZbmQtWBAwfXbsAlnYQmkedGvzSyXFYOW0Kn78PA2y/VUMQjn2xZOb07CbX6+EfueiGQunic459zht5D/u5ogz24G/nqnYg1AdmOEfz1eMzP/p66Ojxb+s3W34tGKXTLuc59XW1flvg/Ip0YWXXeTAjJZqnn4s2/nIR4ieCr8xnNdwk0HA8LLc4gXyjGERfm72bJEJtmmp7k9mLvMamHcK56FZoWWeTgZlGOlLnRl6NcXoMjufeIqoCHYuuJyZcwfa6pE86WZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EfCIC7CzZdwcLUlJhEa1n8/0yHBVwev+g2VgjAz+QQ8=;
 b=viIQiJEwLMvifnylOUdeGRZz+abWdsLYVEzx2X78NBhHpXuTxoye4FFlAb6VuIA6QOUiatRlchzDI8zSebgUeb8nBRbmbMUX2JPtNeuUI1pjYu31eKdAifORSxzjocOiIw5t7Vik2gxvQJDCHIj/cmE2OMf3o9ZsCMA0XeRy8DrlCLq5BnirMqi9eUaZLLTOMiNqOhga10rVNfWr4a9cX93GE1X1w21tEkLhd+qFpbJlSUHt+SsW6NkKLTybETXzP87X2Kf6Gc/OlSyHSXqjkUiMfeBxsMjE0IUqQvB0SjLBzmnmq1rMJSprtOTaEWoZq13SurqIdS+fVnlPY2BH1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EfCIC7CzZdwcLUlJhEa1n8/0yHBVwev+g2VgjAz+QQ8=;
 b=oOksn9fbkyNAT1E4NfkG77kV3pefHf3JaMTfcA+nov5RzTPiHQKZqkhHaGe+wNuRag33/rw0RedsPRTjgm5NOBQAdlhQrOw4hPCC1lYea2o3jmrYgOWvwCR1wGYNNYt0M4XdvNYwr6TRkO49KALva2YpP0f11dMqRqYSzd/CuNM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYYP286MB4187.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:10b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Mon, 6 Apr
 2026 15:57:23 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9769.017; Mon, 6 Apr 2026
 15:57:23 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Niklas Cassel <cassel@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ntb@lists.linux.dev
Subject: [PATCH v13 2/7] PCI: dwc: Record integrated eDMA register window
Date: Tue,  7 Apr 2026 00:57:12 +0900
Message-ID: <20260406155717.880246-3-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260406155717.880246-1-den@valinux.co.jp>
References: <20260406155717.880246-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0066.jpnprd01.prod.outlook.com
 (2603:1096:405:370::7) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYYP286MB4187:EE_
X-MS-Office365-Filtering-Correlation-Id: e79747f6-7ea8-48de-aa12-08de93f530fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|10070799003|1800799024|7416014|56012099003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	rSuFpR5WIGE4IGQeUC+pdtKRoyXNxZNFNPfLpZnB2PxhaKjVGO1n6j2klnkmY3Ng8ErbznhdL0gB9BlYbZN6UtO2OtKM7+QhHqPC0NMioJ5MX4FLr17Zx+4XDtUn2uclBU6t/L/4Bf0EBu7H/yJ2Xq+aDb/TmgBgiAEzjHxzvziPn3EaUCH1nHpL/ThxsPHauf/1gp8R6oKjN62YYB/yZsS7mIsp5cG5vOfRjxdoBtohdUv3xSXAZGWeC8c3r1zKyDBfhVesegD+oqlueOo9brcsZbxQjBdTFpDYWkU9r16g954rJOdu7PP11hHR9oG6KJ6+i7CTxYPPb2CeHNYioGVJoFXNWhRIUcNtNIQ31FDdkFhoUswg9iW+Je9kNSaOJMBuVYSJ0zrOZvYiVmS3b6iqN1rfHWnpJpDyfmAJxTKwc/lNZaxG85RMzdqpd82a8Y5k9TnfYXJvJU/an7s9oqlC/y4c09uyxPbZs6g+y6ef5iRlQeA8qKQHo4CR1uGDsUY9z37LHFId8tz6/9xNR/2Ioie/FUnBK9izNEGkdbY9EojqSQiUhm6Ss7hS91aMA9AruPaqoEeb2fG9rZwauJ3sDdQmR9iLy50nM0f2EzrBinnmXtfskvYooCHRRp/gyTrKHxF7FgBLigyId3wYETH7SbngARZcvRfYSA13YFG/AUp2fO6HGLIngEz5DmX5CLJ8bpMmG1HcG1/1UD7GzDmPIwsrRE+MzHSt0lQfQZvFUd1bT6xIiXbcOsbLOJdSIKbbPvWQsXa4Z6nDO8kVFA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(10070799003)(1800799024)(7416014)(56012099003)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UtbSxTT+3wGc1xjE6q9IiRO4JHf864E4yEDwaSltAypmqceRXpgbdIoW5ete?=
 =?us-ascii?Q?45JNdTUS8vDsHZw7SEIpsZ+kwdPaS4L9CDZv7dfL4Xa6A50Njv3Ej7+M+Pnt?=
 =?us-ascii?Q?+9ht/zbzO5zYpZV3D9qiJhrNtTaD6/u5L4qgOCSep5UvwkCDNnYUafquBQ7C?=
 =?us-ascii?Q?5tXSYauwivBVbQ63NuYL8fABA+LnniXF3qSDUMKrzSIxBfWgth5NNAr9ru8h?=
 =?us-ascii?Q?MiPOa+K0nOiZBgoqqdm8YCAFkFKKWsq+OcNUjgu09skixYYqhlPk6D0n+oRm?=
 =?us-ascii?Q?knDCTo9k4gUMgKbn0XloL9sRTtDSx/uRE4ja8Un/TcdaWvFMbdShuIvX5O6p?=
 =?us-ascii?Q?9GicjHpAH2U7F/4IvfYaTTXYsDWoXipmC17u342Svq52hg5kyMC8hoxkG0X7?=
 =?us-ascii?Q?WlzEYNscO74cgS7JaGw0pvuz/ibJP4mxq5ixscZJfASpYXBEepmYNILSEu9Q?=
 =?us-ascii?Q?c1eITodSFzC24E14JbZkRhdJn2rRP4ObAlMAMEqsuccq7stC7DPq095zEoKn?=
 =?us-ascii?Q?Iqel/Nk6PuPpLZPR9UloI81UgonwZQoUnrM5h7eJcV7ut4lYpfbCjIKGU/vH?=
 =?us-ascii?Q?Yfl4p5kCmiZfqcJZAucp19LRWjnrQMx3ncb1LFFhy99XkOXXAUBqPvWZsclO?=
 =?us-ascii?Q?NyAj0t5ffnWJ3hjGPIMCgRIOhdpFOQqj+RzagzVa9n4VGAFoIabC33T191qs?=
 =?us-ascii?Q?m30Sc4Ec1PSrjD6TyDDjQqP7cZOG3N56+qB+q1khIX7pfqXiIBo+FJHvvP65?=
 =?us-ascii?Q?H2S0EKeLaHE9gSiSS5ZXQPFCNAuBuAAK015dcCPd5n0jlFbo54jxlI74yJJD?=
 =?us-ascii?Q?V88MwrX5GsXuHXH47UHQ3JuzEhzweG94dkjXmqn0zH+eHsJqLiGpW+t0eN1y?=
 =?us-ascii?Q?hWvaMpf6ktIc9DUhEjBsrTZPmXxamW4RcLftIly2dO5evPrIMH7+8vwbT1Mi?=
 =?us-ascii?Q?7kjpjXD58DV5ClxsuQlNps177zg0MIkHT8ZJQBU0SG/cyYMWzfZHBpGXNp/T?=
 =?us-ascii?Q?dBXiXAovqekVmTatPDwRsDmbmPoPwib5ef0qfxtQ+SjNi5WHiymzLmWs+JY1?=
 =?us-ascii?Q?hoGsouf7iF6iyBHctNsYairnHxvzgJsEkJClRtNilcgVnur2b737qs4Er8Lz?=
 =?us-ascii?Q?Y9FW2NmViUBeE9WKEHipKuSbiWgFRKzkkvc9ITPeL1MgUMA7HBLQqKSqUXul?=
 =?us-ascii?Q?k3UpU/a3iF0RRZchplOt69MZerpffZEmbI5ase7unrb+Os4LdvX2wtUFWHDg?=
 =?us-ascii?Q?Ej2TuanujC0XBsYJbc1ZfIYB4UfWh3DGUUDB7HpIkTeawyQX75Gc2x0ethXo?=
 =?us-ascii?Q?oqTe24RrozrrjsKUpUbOm8hWpdAIgiGbN3EYtUacE0uo9+fJe75vcMPxgOzF?=
 =?us-ascii?Q?C+bFVoiAoVw9wJuoEMVzguW08B/pie1bJ7rgMMt68Rlay+RKubxsNyhsq8zn?=
 =?us-ascii?Q?kOC8F/BdoiMzqiM+WGsdEeBAtXPfu9Rr/wrkOlPJ6zCr5lM1C9Rx846lKKN4?=
 =?us-ascii?Q?8nkvHFUGANn1RegwbKFCPOILJc/KUpb22o2dNOOF1ihV/6SNYUHFDwPienal?=
 =?us-ascii?Q?HveYnwrTrbfRBLWxLHaajRjWQb5qzpqS9om46xRaMARtBtNuAUbt/3Xai6dt?=
 =?us-ascii?Q?bBaYax5R1k5dBylmkPF0br8yAJF5ZcdGj92Wwg7Yin2IW3FKaObPVxT39hQa?=
 =?us-ascii?Q?RAAhfRSOc5EtMQXaHXay0PWG/ZZjC/dcyn9od3dc8triLCEy6hTtbSWd/aJC?=
 =?us-ascii?Q?y0y+QFWcfXkDbpoSeNqpPE0oEQud5RCxyf6h3n+UvIyP5eS8Yhun?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: e79747f6-7ea8-48de-aa12-08de93f530fd
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 15:57:23.1903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w3MMNO62itxNgpoWeLJXLQ4xzlbHzTM6Bv7X77XxxLp87LvZ5iEpmcHAN1hof/N0O0A71fqyahEPa3t0q7l6QQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB4187

Some DesignWare PCIe controllers integrate an eDMA block whose registers
are located in a dedicated register window.

The EP-side aux-resource code exposes an interrupt-emulation doorbell
register (DOORBELL_MMIO) from that window. Its location is derived from
the start of the eDMA register window plus the doorbell offset already
provided by dw-edma, and the window size is used to validate the
computed register location.

Record the physical base and size of the integrated eDMA register window
in struct dw_pcie so the EP-side DesignWare aux-resource provider can
construct that doorbell resource.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Tested-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/controller/dwc/pcie-designware.c | 4 ++++
 drivers/pci/controller/dwc/pcie-designware.h | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 5741c09dde7f..f82ed189f6ae 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -162,8 +162,12 @@ int dw_pcie_get_resources(struct dw_pcie *pci)
 			pci->edma.reg_base = devm_ioremap_resource(pci->dev, res);
 			if (IS_ERR(pci->edma.reg_base))
 				return PTR_ERR(pci->edma.reg_base);
+			pci->edma_reg_phys = res->start;
+			pci->edma_reg_size = resource_size(res);
 		} else if (pci->atu_size >= 2 * DEFAULT_DBI_DMA_OFFSET) {
 			pci->edma.reg_base = pci->atu_base + DEFAULT_DBI_DMA_OFFSET;
+			pci->edma_reg_phys = pci->atu_phys_addr + DEFAULT_DBI_DMA_OFFSET;
+			pci->edma_reg_size = pci->atu_size - DEFAULT_DBI_DMA_OFFSET;
 		}
 	}
 
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index ae6389dd9caa..52f26663e8b1 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -541,6 +541,8 @@ struct dw_pcie {
 	int			max_link_speed;
 	u8			n_fts[2];
 	struct dw_edma_chip	edma;
+	phys_addr_t		edma_reg_phys;
+	resource_size_t		edma_reg_size;
 	bool			l1ss_support;	/* L1 PM Substates support */
 	struct clk_bulk_data	app_clks[DW_PCIE_NUM_APP_CLKS];
 	struct clk_bulk_data	core_clks[DW_PCIE_NUM_CORE_CLKS];
-- 
2.51.0


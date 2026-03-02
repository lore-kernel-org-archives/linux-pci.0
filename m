Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020102.outbound.protection.outlook.com [52.101.229.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F97383C64;
	Mon,  2 Mar 2026 07:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772435710; cv=fail; b=CZesgs2zyzSuRFc50Qa+BAY51KS1Xeih4FdMK4uqZ9vhJFUfJz3eLPvEAiQ2kv+eJJEA6g+deJHXIRRSNLrw8YOuqcvP5ExODjmnkMeX75gS7mVexDs9RcHYeQVfR5DwCQh7BloIRMWTO4CeO9hjwe9bHbiecDY61zhNMLL5DtA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772435710; c=relaxed/simple;
	bh=JWkkLxftT80qD3UgkgE3/EqZpxeJZgQabieopo48Jm0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=leauYw6lgEN3HKuX1c94c+fGoOhKiKxLYf3TyXDb5TLhlvIwwZ0rT/+TEROY42eJXOqab9zEG9fbj2OSlCwY9ItZb8K3iW6Nm+ItHSuKo737ddcKtoSUFVFsuwGsKRkfjhGdUgyyZd8iHs7hz5tS/ghg00thU0ilOvGkdJ0xtxE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=AIopMKKZ; arc=fail smtp.client-ip=52.101.229.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="AIopMKKZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lQI1pxl9DhKH56utIQSBofzSC04Vs8PqnqkRdaeSqQWc6zGayD4z8/0gVx8wvla3xHI2IhqbrJWDcwdeen6rVZyjDWM9RwJ1482Sk4H4DreIy6bktwgvfmIM0uKFguWuNBn+tkSF0xty30rX49Qxo28dOj962mAgECwxwrgF4YyAOsjy2tDfcU+BnP6Z8Cysj5RvNMpr0sU7GsqvmY5p3lcCcgMG+k+eUvKQvEprc9DijC0qZgOsnp/EYs+f1Hcci6XKiKex67adY+dB0gbIwpOx8ACCAjbw/1+JaLQNADAWEtHF/wSboETRgWYnlRr2eLcSG34h8Fmh8p2OTj4dPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qdRPjkWWmSd6gSimlDedfci2e+eu+Ou95wS4Z6vKzRg=;
 b=U3fZgS9wbhrRdXCxxQdUJnYmKfgC40m9mVmubZuB5mY5q1VrGGOgqv1/skwpPh6pG9Zz1uo+DTGvidKhV/S48g/b1pTMbGZ7dbQC8OL3FIsxlJwofo2N64jyKtQb01vDXvHF0rTe/UT0YGOvq7sfibd5sokZbEduaFZueepHFibPTT2rz9yJpuYdL1+V+nVjYTEf/tZqR9WSLwjFuJl9yR9DopnYudFvm0/c0ZUKHzaOcDuvm4snwesoUSplKJEI2OB6mzHtWtLD82pQ8FZ5IsnpU1xSirdFqJXqrDSl3gitoIC7dYj9wX1scwL/pPYM++QlyTR/8R9sYit5pe76sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qdRPjkWWmSd6gSimlDedfci2e+eu+Ou95wS4Z6vKzRg=;
 b=AIopMKKZ1dKUmAyzPamA5Fk/oElHJukwYG9iM0XF1gG6GsSsGlSfvuEECpTa/E76O2NETs21KKenB6znd1iCYq+DXKHMylsf/T242Ei1cGGY4W0Ovtt/bq1YEOMgQom2SB+dzy6MA4tYtljPc7F03jth4HLknDayZXQJ6QWQllE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY3P286MB3705.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:3d4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.20; Mon, 2 Mar
 2026 07:15:03 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9654.015; Mon, 2 Mar 2026
 07:15:03 +0000
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
Subject: [PATCH v10 2/7] PCI: dwc: Record integrated eDMA register window
Date: Mon,  2 Mar 2026 16:14:22 +0900
Message-ID: <20260302071427.534158-3-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260302071427.534158-1-den@valinux.co.jp>
References: <20260302071427.534158-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0081.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7b::18) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY3P286MB3705:EE_
X-MS-Office365-Filtering-Correlation-Id: e3ff5e0c-9bd9-47ec-c8a4-08de782b6c7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|10070799003|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	7xTiE2hWyy3yUBwMCU5gOJPR/C2SMyvxLBmIre32RftmsXgxFAmZX5GUqht6C7SNCrTw2fujwCa6nfQh2YBzSS5id3/E4ZogmkHMfmlwnkrp/d1Dl2cB7F8uVDPc2b/mujOuqvdphL5WaPbecn7K8tH0Bxra+Ud1/Ty0fTfjz1cvQ8lBX+UGeYrCGmLY/mC+QwerqNjgVOT52BxjO6xgr4ki3LfE00JvvB2Mq1JjuIJfQ6uHiZ4vXF72qPUrlCcVv1MWPz+o/c6nFQ1bkI5NVeACX4nSt0cX5yxTlbr2w8J1jbmbZMBtljWl4DY40f/j1z6exManzsmO1pD0TTb0NXq6Lgia6g2dxh3Et7UpEH75dJ+ifMpHVnxLIdkrP6hf8LkHEMkKoDzfjWNhULUtgVWPEAzx+Z9EyBL895yNC+TDjBfO0WBK+T3L9w1S7bTXVezDAz4OEUNyPdlzUb5bDPBV6YDa3asJ1cut1eNADwBfTZ6i917LhSfIDeP5lsz7VxqHat9pXOkgTO6Y2eSuJrT6oUJXehURSIysYemoDaJICrYQg0XxZsDo8Gfv0bj5cJIDoSlBJDlINyakwqoZ9Z7uqrboI3Ru5ZFor2BoA6ztT1ijEuWHEVPtpNmeDV3cWhPp6nVdfkv2ZOSdH0x1G7cX2ilOlJRClgbacstQl6zzer/DJ4YBUvBL/MzlFad2ox108brXuMkYjn3UZ+MNMONREqSBcrNFIYhvjYdc0r76QEHqCD7FKNxcXYJC2lTJ+ihCvUZMcHlK1w1pOt/jig==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(10070799003)(1800799024)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IxZY0DbpAKPbQalcKeyod3ZiCG01RsvCYC+z59QNW0PCoDhp5wb+zgdLLEFZ?=
 =?us-ascii?Q?HyCYE9PT/Q48sRw3JaaVAbE9Hd6iKvOS5h1FVYiqoC5/f2yiPyYGIGWvg7qQ?=
 =?us-ascii?Q?EaaZkfT7ZKNgzoarvk4Yb6ha8UVF4K9x9I3jyQe60DMIDeMc/spXGyq5Vkpb?=
 =?us-ascii?Q?g3ZxfyfeXXxT9FbR8WrjfCQnt1NPA0blyKhjT1CF0+niLdMrD3GG17Vc/1gC?=
 =?us-ascii?Q?5cpd3S75C3MdgJNFcBd56eiFiEz/Eew03YH+BzseYoUk47Y8QnC88jqN0pCk?=
 =?us-ascii?Q?f4c/50dQRksb1Pi+5RXkeefqPZG5hqUlCL0S2qRQsypaDUYlVPwEnfINxfF+?=
 =?us-ascii?Q?HP2kkpJnQCu2uLR/1I4OLo2OgxjXKDf9WURtk9dLbwxMi7ZDcdQKq0cQmrx5?=
 =?us-ascii?Q?DE4wyZQOEjsvbmCECPBoby2PmXwgIFRMCsh9She7h/kAE2mTjZNXiJtb0vz1?=
 =?us-ascii?Q?yRjrF2HMGM8wRJzLLLs4AnO13UMjF3ciGe+C+gKp0IBtOj5xFMJaljRLKf8r?=
 =?us-ascii?Q?f+pDwqYepEmEFIcZi3Xwy8J7W0B/K3nuZuxQUx7b2rG7aYlgvXYCprFp7oTB?=
 =?us-ascii?Q?0Cswg8mmrKt9gxs8zG3Dtxwg7+diChPIUQfeF4PpVIcZIFeB1S9TV3USTeZG?=
 =?us-ascii?Q?uT8+EfJr2jVpdQjATfoohCC1Wxqrv3nKpdIxAq+22HYjBnCPk1P3hP6MjhWE?=
 =?us-ascii?Q?98sW2moE+XjGzy5UB4jgvQNulY1m8crH5GgNvyCay9/pbfHl5Dr+/qTeCHbE?=
 =?us-ascii?Q?G9kX7IoaY14MIxpPws6cM0pqIEs07ULIMaEVFVDFMflJtwhckNjK4EU3jr37?=
 =?us-ascii?Q?yFPmORRawwvm1V2YVscmA41uRELbEG1fF76Im2B1VdhbUwcijBboZliuzlMN?=
 =?us-ascii?Q?Y5CunO06tExdfrcyjFggOX6FFnxTgBcy/ukcWEZMJlmzLXwwMZCJbEz47+at?=
 =?us-ascii?Q?TvyqeETdRRiJ3uUALFb9wSZe7mxh2wzqtWz9b3NYfEnws8tG70pDBFRjg6re?=
 =?us-ascii?Q?8lxGZXVMkdbCu39e86SNooh4uw44zaqzNQ/xA1P7rtO6NqirwSbZBlcLItoA?=
 =?us-ascii?Q?sniht2NnchY9+m7qu/4xIgD6XPUZPWlbZitBKGbBjF7bJAVuDfKaz44Qwrau?=
 =?us-ascii?Q?uKNzhFFsaRNEWjvQL+Z+KUMNb1TgkGxUXt3Nz6WP51swGL+kWcdUNNWNPeOV?=
 =?us-ascii?Q?WmseF5dj/Bo+ItbQLK2s4U8cjNAJ6jdkIxUr17aAVjWP15/iywm+qDB0+lU8?=
 =?us-ascii?Q?T/9wwWzjyqnHnTkl7hhJ6UU5oLiotHvxC+D4bUInyAYQlvHEkNuCx0GoOYGK?=
 =?us-ascii?Q?BEWNukDsLzXWs15rRBygCPISuc2W/T/nDuBAH6rhWzGIdvgNr6IGICOumwNA?=
 =?us-ascii?Q?C84pppMb//n1ZJJiLwfD4FUJsbmX9HWDEnjGcYuX2Zbekak/y5t5aa1aRKJR?=
 =?us-ascii?Q?euD+53Vc/vrh/zn+4cqkJVC7tETLM/1DygU/QQ+ow4y0D+3NXWh2nS33PJcX?=
 =?us-ascii?Q?t+bmz7jWultgR+0KiSfD/eroWrEA+7irp2ANFSVbo88tqk4dgFJzlAIj7oMc?=
 =?us-ascii?Q?jiWuOEg6aM3xq6OHk3tb92SexF3kUjG/zv7qk3s8mJbthNYLcCBq+g7549Rd?=
 =?us-ascii?Q?Z52RidNQQs2IMVRIhhBkl9K+NDL+XrcPktBOg6ROVuMUhfoF7u/GD9EFsrLR?=
 =?us-ascii?Q?37qWWJN9QNqu83R6anb1ydg2NzUrznb22n6a+QgkZYhATbaJvzsN5QyQW9hL?=
 =?us-ascii?Q?x91zV3wTng7qJhyri4PkB5+JXCCEGlJ4oqedDo8efoVRU26751MY?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: e3ff5e0c-9bd9-47ec-c8a4-08de782b6c7e
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 07:15:03.3020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qfqy6D706gSyNVo/rKcV3soDs2VU0e+gc/qx5Nm+ymkfRtslbOuAEKQHfLvvZnubtcauLhtm9vMhY8vZq3ysiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB3705

Some DesignWare PCIe controllers integrate an eDMA block whose registers
are located in a dedicated register window. Endpoint function drivers
may need the physical base and size of this window to map/expose it to a
peer.

Record the physical base and size of the integrated eDMA register window
in struct dw_pcie.

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


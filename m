Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020112.outbound.protection.outlook.com [52.101.228.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A00839281F;
	Fri, 28 Aug 2026 17:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787936987; cv=fail; b=Tn3lVHK+6bkOWZrcU2GtT0v9RhaEjocKvev4abel//iKfZJ9CMtudDojTS5j3IpInhl7jjFGct4BDcPWdA8yUGwrlxkOgTA9dQJgVJ9TJk2hycurEPX25Sa21N3QH0s2PEwrPglz/9MhNzbCdYfoHELhrlbrWc2LH04OzMJ6L40=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787936987; c=relaxed/simple;
	bh=0ZyxmywCtDqrCXZ9QCFxgdYSsnbuR0W0aGRDXH+cJl4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BkV4KGHA7UvZ+GexmPFxVHdPQlS2+33Mzfii3okKPuSqd02OVmYHs2NrxvBirbgNaHsRPlMG+PAIfS5YVChwq2HsBO4tAYVYai3WUgausB/FuKgoCRuQsM6NimsK8AmS1ZJiG85WQbDwoNuZvtGTZpXUH+HP1Q3pYwkxhuxU4Nc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=Ji2+FIuw; arc=fail smtp.client-ip=52.101.228.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="Ji2+FIuw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=McL1+e5DT0rshdJPthkdDmNQacXBychtG248ml7cloBUGOiQ9wZpWrBRoCHu2zQQ6xTNCbhROtBrbjvGYdeGaL65MKwTFLTJA9UILKLy1IJ+3q33dYjXGSzHESqLev4OMwVKIsOLdQ/cbFdqsIURhQmkv0BHrmOQJNrbwjQNEAeyStu57j6bMgf0aXHaS/VHytphP0UlJhS74pckeh7bYug5pKLND4YsEfmaIo593Qk6GXACrjJERU78e/idoMCP1zPByyDic9MZZKN6K6IzMNsBDIg7xFPJfyot/i3lzs8vCYFG0lIrlcI3tAsHj564E6MnpOZzogFjSSLkyOz6nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RyZbxu+fkBhILSlU5R3ccrRgBXpsIF2nHhzNJyZpN7U=;
 b=YXznATVbLPt407W181f37sgFULd57O5ExyeKctDJqmI9Px9fMPfKszgR8K6a34taCcrPVxiu7Y8jkrb6GhDHv92DWrWeXqrYT7Md3bsSiqkC2bnvplmTPUmOKQfG2U83L+tgE+cw4OzuQMc9sFv9ZMcjL3mzT4NokWWPx6Xj+RjvDd3XrYD83tjoIn4CREv3xwXOu9g6KSCybb+9Lj/2GpXJZ+zV0AhHl7rjsTf5wPYIIH8v3P+S9JV4/WENyUtILm45nV+iZDL4Ca1+2BlXAdlRagw7TbGawZPJ5NPF6lQObVoRXDbXM42bGu5P2PmsE73JQBfaT4XWwHaNMnknMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RyZbxu+fkBhILSlU5R3ccrRgBXpsIF2nHhzNJyZpN7U=;
 b=Ji2+FIuwlK6JlBqEVxigD6RCPtLolfWBJxa6k0Jj+VP6ffY0s+LylM495MC7EeO7IDpNT/CnwQ4TZNAiRDMPPrLBQCUzRntTgwiuzMerD/d9vk4k21p8ROupRYfN5QkQd99sVyfaM1VELg5tx4rWx9L2OrbbdUNp45RpTj04Pfg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY6P286MB7951.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:3a6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Fri, 28 Aug
 2026 17:09:39 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%4]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 17:09:39 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Jerome Brunet <jbrunet@baylibre.com>,
	linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ntb@lists.linux.dev
Subject: [PATCH v2 1/5] PCI: endpoint: Add DMA auxiliary resource metadata
Date: Sat, 29 Aug 2026 02:09:28 +0900
Message-ID: <20260828170932.2735807-2-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260828170932.2735807-1-den@valinux.co.jp>
References: <20260828170932.2735807-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0089.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7b::11) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY6P286MB7951:EE_
X-MS-Office365-Filtering-Correlation-Id: b3fc10d8-0219-4db1-d8e6-08df05272552
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|23010399003|376014|7416014|1800799024|10067099003|6133799003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	A6gZYjkxf7aQJCq0bL32yaOLfna3li5Cmy0OUi1lUx2on/oE3hKE08wPb4i2hftizdGRSwYpecPnEKdV1rIN7VLjxjcN9sKmgm2C2iIAQqvfvlhXzcEg++WX5XmudsqFMC6CVCNGyiO/oK/FWS3e7sfzcA56yIeiBWzCvhEWOR6qDr4bj8Y9TjsQbCLmsoxOd0SYO50vhEHgnGJG44EdRNAQRWvLrXO6mZ1mOHRoDO3JWYxlWE0UNUH+roAS9ZTyFhAbYVLy730iwizkKJw1ovDP1FGfBuKWyShVLOH22CfKS4xLdLeFWVNwOHDTEcnTqzk7cQfe6v30Xl7DsyTJygHyapd4xZ6DCEwVtfTE7WJIf0324L5e4yy2wVBWmSt1kTmwk45S4ql44xY0YpI7n0hMOj4fBCa4LBcFQZ4GGbIMTLxqUaEYgrYaDXpgc59/dNM+IJcPUyUchrzD9ZCXaaodhpMmaZ1l3Z9Rbkn4k/Z6SJHlb1HWsB5fGpNJOrxwULefTMu11lWXgIUOPPc0NUEJWMkXOf1qvMh8fbzvKc4+Srm8rJdc4aeMhcsUGIZHgjpCR0n4XOD1XnL4JC9H/5wCH6bhmooAjLHJAKqzxbzK27u483pSJNjcbll+/Vwl
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(23010399003)(376014)(7416014)(1800799024)(10067099003)(6133799003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3spQ0ngASWUezzsSoVwVml6lwVHcXURVgOKtG+oUf9u5zcbabxMAAUrP/KUI?=
 =?us-ascii?Q?yHajB9fQmQLQvLgH5lk4RldTMo+iZBgfhiuEYWf4Z2wNVxUydkmCgzpHhz8P?=
 =?us-ascii?Q?23nF4pnkKqRSLSxtiWzdiGh7Wr3P2ZXshqnh8ZoJcB+MHNfCPG04FMNVnrgK?=
 =?us-ascii?Q?bWVKozuRl5/nGQSNhPsYq+wQw9mN5K74ft9jI7utOyN28hi9VrMe2H2D39bo?=
 =?us-ascii?Q?MF8xpcc7+/qBPczJNwNAQ6xROQu6d8hqOm+qklXXfwM57Knw7Xws7rum2wYH?=
 =?us-ascii?Q?CK5YQTlE6v+GyMDqsDCT7RoeDZpuz6mwB+WMazzYRQVbXyJqcoBhw7zHnKGY?=
 =?us-ascii?Q?a7BYpSrq+AD9Oi7fcj6OGE2pQWQATuDtaJwdwzwTq+6FBsT53ODXsu0g7UQB?=
 =?us-ascii?Q?K3J58/+vQH3iG6O3ZZbBxz0VK+Hc5VwUpRnlo+eMQD1kNknQU5EBbLfnbvNd?=
 =?us-ascii?Q?A6IdW8XTW3Z5OHlMdCQuJZRz/SPtvaMBknp1qBSJPqA4uTwU9pu4HEm8n3p3?=
 =?us-ascii?Q?AEOXIX+Cs4WSTY/cklORA3lAnknk045M512JYcrAXcneeVrytmip0kgR1yvg?=
 =?us-ascii?Q?VQhKKWSiDjI2mI/6v/oyajTjOARsKSdpZktXrh1FvZ8+wDcQ96MwGjDES10I?=
 =?us-ascii?Q?VCb6RbkkWvaZ84li4380oZVQ9/XVkVi4hSlNBFjNLcNF6eT62q9RY4NiyCF2?=
 =?us-ascii?Q?O2ArXh2jbuPXyNaB23Y+yc/ofB4WHd1l2TyY4HqEjnFTJfzvFZqmpt/nI6CZ?=
 =?us-ascii?Q?0o8OzsApt2TOlIkgADhh4cOR87rmJ1U+GIvjaje/6eEOxg4qsVLny5YbGeqe?=
 =?us-ascii?Q?flenw5lKxMWkbhb/OmPsVoiOwBy5ftS0J6ipv/jbhEfcGIk2TjHr6Yp/2X/x?=
 =?us-ascii?Q?O6QQXDgXlXHUHhH/3mrOS1UB5BgS12QwUA5Zoa6qcY9LJoViteJrgfXZt5vf?=
 =?us-ascii?Q?jvgXbMyABU8bQXoZlGXyfQTqJ2FK/in4kWGGO9zZGvbSgKM2cKp6+GnPJF6b?=
 =?us-ascii?Q?J65+NSuYfJaex+goOunjTkC+PJ1H3HJFK9ikY8TzAJToKOkOUlLxpyXQl4V8?=
 =?us-ascii?Q?8S7BAHnPKmNmgx71B7c7gtk5HMwbeAGyw/rI6LH0qS6W5oZ/u+ROmNrXbCj2?=
 =?us-ascii?Q?jjMF6EtXpR+Z8CvgGFH/20qnVfaPJyQNE8EqnOneqSDgpEsusY3Pmg4G84FD?=
 =?us-ascii?Q?5nry1zNRcY+ZZUN7aQ6UX8Y7eBIuUkYhoZuYBPa7gjhdOzHFu5YgT+45nz2I?=
 =?us-ascii?Q?883IdllL9XJsZ1ckiFjc/8IpXPXpjYiG5Yi5MRmox5fvBYD906g0ljGSnJyj?=
 =?us-ascii?Q?F6HR7gKP+dur3cJGpR8Y8kJJZRK1JQ/rxL4rcYM78VwAV35SCMUgajAnHs64?=
 =?us-ascii?Q?5OOngf9ux+1DjqlMZN8yvi4BVTcqFxU5gs33kGqdADsaBif7NXLqAbIIOdyp?=
 =?us-ascii?Q?Iu+QFH4Bo8bG51XnRNq39614+C7YJKG48VmT7dgvZ67u9gUKs/PzPtnWG5qX?=
 =?us-ascii?Q?IhsKOztXzwKOhD4J36foaGxZXv+jnr0yaO9VhGZyUto+2NMllemgHffPjmZB?=
 =?us-ascii?Q?oFxjc4soJf0xW6w16F74IoT2RjiGJAW+6p1MVWx8f52IZZ5wOEy/4FIMeVNv?=
 =?us-ascii?Q?rwgb7OBxuoDUFjQnsoVo1JQYSkhPukwnVRSkZNV8js1Blib2pt/D2T46G/nA?=
 =?us-ascii?Q?N59O2/D8VUDD2Dg5UigeGKqSDdn6maC7edlFmZIyiLe4q44AqdJuE/IxBAQY?=
 =?us-ascii?Q?XoYulvRQi/KI+Ozr+DiyMiZt/IWwqd6PYjaO8Q/IXBtHFsPM/JZX?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: b3fc10d8-0219-4db1-d8e6-08df05272552
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 17:09:39.8645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gbHmnijzUdUnXzlXbiY5VEAUwqyoDoqcVjevWxl9GrKRBXc5xzUnFb4ki469FXtXHPXBpPIa6G1Wz9IiPl9YpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY6P286MB7951

Endpoint functions that export controller-local DMA channels need the
controller register and descriptor-memory layout.

Add DMA control and descriptor-memory resource types. The control resource
carries the register layout and channel counts. Each descriptor region is
associated with the static channel ID assigned by the local DMA driver.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v2:
  - Rework PCI DMA EPF v7 patch 3 with only the metadata needed by vNTB.
    https://lore.kernel.org/r/20260813063757.3131865-4-den@valinux.co.jp/
  - Keep descriptor metadata keyed only by static channel IDs. (Frank)
    https://lore.kernel.org/r/lm7tadnxsyrypu4mypptlkx5qkytex4qxsijdr5ydud2n3anvf@yakjfjg5ng4u/

 include/linux/pci-epc.h | 34 +++++++++++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)

diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index f247cf9bcf1a..e0348e7bc534 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -65,6 +65,8 @@ struct pci_epc_map {
  * enum pci_epc_aux_resource_type - auxiliary resource type identifiers
  * @PCI_EPC_AUX_DOORBELL_MMIO: Doorbell MMIO, that might be outside the DMA
  *                             controller register window
+ * @PCI_EPC_AUX_DMA_CTRL_MMIO: DMA controller MMIO register window
+ * @PCI_EPC_AUX_DMA_DESC_MEM: DMA descriptor memory
  *
  * EPC backends may expose auxiliary blocks (e.g. DMA engines) by mapping their
  * register windows and descriptor memories into BAR space. This enum
@@ -72,13 +74,25 @@ struct pci_epc_map {
  */
 enum pci_epc_aux_resource_type {
 	PCI_EPC_AUX_DOORBELL_MMIO,
+	PCI_EPC_AUX_DMA_CTRL_MMIO,
+	PCI_EPC_AUX_DMA_DESC_MEM,
 };
 
 /**
- * struct pci_epc_aux_resource - a physical auxiliary resource that may be
- *                               exposed for peer use
+ * enum pci_epc_aux_dma_reg_layout - DMA controller register layout
+ * @PCI_EPC_AUX_DMA_REG_LAYOUT_UNKNOWN: unknown or uninitialized layout
+ * @PCI_EPC_AUX_DMA_REG_LAYOUT_DW_EDMA: Synopsys DesignWare eDMA/HDMA layout
+ */
+enum pci_epc_aux_dma_reg_layout {
+	PCI_EPC_AUX_DMA_REG_LAYOUT_UNKNOWN = 0,
+	PCI_EPC_AUX_DMA_REG_LAYOUT_DW_EDMA,
+};
+
+/**
+ * struct pci_epc_aux_resource - an auxiliary resource that may be exposed for
+ *                               peer use
  * @type:       resource type, see enum pci_epc_aux_resource_type
- * @phys_addr:  physical base address of the resource
+ * @phys_addr:  CPU physical base address of an MMIO resource
  * @size:       size of the resource in bytes
  * @bar:        BAR number where this resource is already exposed to the RC
  *              (NO_BAR if not)
@@ -99,6 +113,20 @@ struct pci_epc_aux_resource {
 			int irq; /* IRQ number for the doorbell handler */
 			u32 data; /* write value to ring the doorbell */
 		} db_mmio;
+
+		/* PCI_EPC_AUX_DMA_CTRL_MMIO */
+		struct {
+			enum pci_epc_aux_dma_reg_layout reg_layout;
+			u32 reg_layout_data;
+			u16 ep_to_rc_ch_cnt;
+			u16 rc_to_ep_ch_cnt;
+		} dma_ctrl;
+
+		/* PCI_EPC_AUX_DMA_DESC_MEM */
+		struct {
+			dma_addr_t dma_addr; /* Endpoint-local DMA address */
+			u16 chan_id;
+		} dma_desc;
 	} u;
 };
 
-- 
2.51.0


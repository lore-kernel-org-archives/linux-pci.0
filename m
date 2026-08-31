Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020088.outbound.protection.outlook.com [52.101.229.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570B93DCD90;
	Mon, 31 Aug 2026 18:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788200829; cv=fail; b=lNuUGDQLsx3jjW5DqlYwl4/T6GApCaZwCi2lc908ykT/WM7RkCXhj3NgVBNS/Cu8Y+De82gdEBEudc1hLyI0q/tZTtgOjDc8KPT1aAsrotPdlbUhNWaOQVS29xoAvSj571LxCqX3ktlk942YU9fs93lrI2sfkm/Khz0/o9CJsnI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788200829; c=relaxed/simple;
	bh=/hLIJjq7yL4lbulW2q4hAJZYhAO6HlAV2Be8Cq4rw/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IOAxvWAmf2cVbTDyPpE62sVfThBEztCFjOsErjeXNm53/b4jbQMEyXrqPjhuK6trVpnkyFKPFajEoiQ+19LnC4VQNYaZmyBySWDcFAEID3CzFAepz4uuwQRD89HOGz1jS5dWKEi96er1oNbEPg7Qpom9PRCNBhRJSZKRf183jlU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=tpS+aHJ+; arc=fail smtp.client-ip=52.101.229.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="tpS+aHJ+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JHXJOpeDxxwFnbIGVj4AraYGqQoBu4xRjkx/63q/rJH+w1a9D2t3TEtY01Nc2XyS9/a000ncDmz/87yxEi+nLD6/D+lUWyxB9hqWq1GCThqXbhj/cZHmtICqu0S4NPwiZhnQ7GA/lDaoKnOmOgeFFOH3p5sMIIu1JaJGHH1Y1NL/CghpH0NLpUQQvfXcmLH2hDwShQWt+n+e1N2nqvRUKC4vAoYD/EIau1d7Qi24HTvic+SwITUMMwoxog5/SmztYN4xxPRuyxgNohcUz5BhvfGd4H+3RkOFhaRjgf48WhIeOXlWA4NLpnfaW9yn8YdW9n5tiVWXVA+amdMxQwjNKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hqU/e8pp2yKrqtJZUySJCu3mQPOwatx9l+0hCgQfUoc=;
 b=ZRLFHfY5c4Em4HaFVr7kygpCWBAwEWBBoHvQGUdYfTjxzRZrZR8gCrKqUipigRo/cZ0zzQ+L+dnGAW8mR6k/ZQ1Xb3L6BbHyvvLf6RrlFCnFZpRhqJshKwZCPmm2rzmG0kC8kqB0zxL4uZt5DXqrKaRp/Fx0JFDABjxdyQ4m6HnsMf9dSZ9u+9ZDkJSsu+agq/11+WeBlrhzDMDy9eYlvRHzsB1SgiPScVVFBnSGDh2bZErQ3XxXnxXx55DXEXvb9hY6GWZ5kJBeO4Goa6q5/N/SCg7nYpm7q7hJcayb5A7LdvyXP67nQx4cQwzPXjBPjGfxT2Q4sZ80oUhOiUH0MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hqU/e8pp2yKrqtJZUySJCu3mQPOwatx9l+0hCgQfUoc=;
 b=tpS+aHJ+Wq0L1dE/QWZ49Qe2I+RXM20oiI9puQmnpNZY+rxR16Hlsl8ipWAK3NsBaSPMHWO+J96xGK9ckbd2L5ZUckhs9lFapnXQWnCkuK37PH6Cmh3k1ruPx4Y5BwyXrv1DkPWKkO25IsZtpH5waB3jDpdFlLfYz+mxv45XqEw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYCP286MB1802.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:11c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 18:27:01 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%4]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 18:27:01 +0000
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
Subject: [PATCH v3 1/7] PCI: endpoint: Add DMA auxiliary resource metadata
Date: Tue,  1 Sep 2026 03:26:51 +0900
Message-ID: <20260831182657.329614-2-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260831182657.329614-1-den@valinux.co.jp>
References: <20260831182657.329614-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY6P286CA0005.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:3b8::13) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYCP286MB1802:EE_
X-MS-Office365-Filtering-Correlation-Id: 625a2207-8d29-4d9e-7992-08df078d731f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|1800799024|10070799003|366016|376014|22082099003|18002099003|56012099006|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	OFmVcHoUldXArb0i60PLk5rKVsdprLgiusBOki/Cye2V9TRAxxRyJdPer/6CL3gcY6UOPLiewgklZ050Zaj2zJOx4YBYo3YfKG3KzDkxWadZM+rtVLweej7oTlXYFled1JZNlMakppMv9jT/TrM3XgxzIm/je4gvNDgbK4EkJC+A7UIFDfHvQy70MNPSS1gq5YGG0gcvrxI7fmar5YR1hYm5dvAs9Hc8dD8xUHYXbL7igtuE9KDYGt+Fj+Tbzs5w9HRKhetHfNaL8p5CrTec8+9q4cGR7hNgpwGKeoizmKZUvx0OB0CAk6+ZHLUp1J3cG8ovODFwJYlmweDkt/6KymoL/wrr/EiTW/hSFjLeuPNJOU05ppCe0XIaDCIphhpYuGsvSTrHeg17VANV12MkU2D84GXpo65oIE6IcCHw7AGbrC84VaCPQT41etSHKRgXcWdk11EEveteLB3VxRI/9wlZ/i4dKKbXwIeOWsk+Ozqq7cG4nkjNhxUW8VWlON5sDAHjROo9bvMizT3fmL19541Re6i1ZCIcHYpUAmLXBHhCA/tsy3ajbtonlXOvEQ4JN7GBRxEyccGpttyhmMBbccREBCkxr9xXl1xxPL0c1/3paAbOje6DF2FQyGEXqPPutiBdcM9rSqyQxsO5sXB19MuSMlPlTs0uGbXhhOUMfZc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(1800799024)(10070799003)(366016)(376014)(22082099003)(18002099003)(56012099006)(6133799003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5IP70V/76Ked0EljzDwqICdBwA541k63QvwT0AUlsL9BiPa/dB3UA5xUqAgY?=
 =?us-ascii?Q?8EBiA0u5nFbQcS6AJRBy2w4NTwVCMTBcYmKYPKS6frVoKm4H5edHK/uxkazw?=
 =?us-ascii?Q?yUuL6e1noFX49NoZz1cNfEP3JbK0WtHbN8rhlFhFgEb5+Xw8hhz+CNqQPa+F?=
 =?us-ascii?Q?gOXQqw3NM3WtXsX6m1g37b0iumtSNv4DtwFO5n871tSA7q1VxsZa+kyxupIl?=
 =?us-ascii?Q?jElOswTknj3dzjsgc3ACdLj0u7XzTOJ4mf06c4ER63dwkDq3QviFdsirXvDl?=
 =?us-ascii?Q?MfQLsfcZZX/ciAz4Fn9cxnca60mCieM3lXv4d6+KACyG91ZfRbR7rmMHNZI5?=
 =?us-ascii?Q?Mle2aDYalZDVKZqnLJF6V5OBhXmrSUx6r7Xbl6IcXiaRx0yrqltQh61fbuP3?=
 =?us-ascii?Q?XtbEzxznXJU+sM7/1D5k0mkHzbczBJXMHQog6GxiqVaD78aG20xOhh4uQjoJ?=
 =?us-ascii?Q?MXSjKJck9sQN0JwJpA18pwu5+NP5gJuU3oZ0MhKyzRfpZC+D5IYF3zIfRKtr?=
 =?us-ascii?Q?VIVV5v7rQcLZFmEkQlvWuKgXGAqgJFSV7L0DR9mgmqc0rSLfZVCT/9nplLfh?=
 =?us-ascii?Q?nRkwYx42Uf+6o2kK69yG1VBLaNVb3w7yEKQOWQNIuHOmXXXvBUEPKJCSQVvl?=
 =?us-ascii?Q?mUYQeLPw9NHxmQxbknObDLt/1U4TwIQAgxAxQH4guX1CLT0+rpirbMeMmXPJ?=
 =?us-ascii?Q?4t+IU96DcFdJZqDCEZSU5dz618oN1HL4ra6kUwEJY64tXLIxHxP0+tHpY7ql?=
 =?us-ascii?Q?GVT3a7A1I0bHhopVh8GsOtE+jKmypkOa1mD/a1i0he97Mm9pZKgPb8Sw8pbr?=
 =?us-ascii?Q?+1dTilnylT0DPu9w8+0sI6CP29+/EvnGpxWhhQPMEr6tPvcCTNJFv9ralDox?=
 =?us-ascii?Q?Uh6Dl5idLE2+ld3TB+YiWWeVN0NJONruCFzg0KTSAH2wcynwo+Uie+S3c0E9?=
 =?us-ascii?Q?tonELP06rxJmSInwVpqBYotr4r8+d/Dv5X9wOUBF5m61Sl5LF43eydX7Xlhk?=
 =?us-ascii?Q?BmCcE/cgeXxI21qsA2N9UcKJh0ggruXDdl3SwLKwEaFYzWFK/RDkBq2vqeH9?=
 =?us-ascii?Q?b4GwvNQ07pwNXoT3bOFj5KL1c39lAgus+TAcu4Yh4gavnHZoLpuuivINLkdu?=
 =?us-ascii?Q?JWt1b8Abm3G/rN3MLgJS4/jYx8Lh27kYV4Fr+F99RRPjHyh3nd/xxXZHB1Wv?=
 =?us-ascii?Q?zJSmviNQ3xM2+L3UcO/w3TXQUnZIAbZ8jPfbACKwxlMe2t9X+VQ8ZmsRDFLK?=
 =?us-ascii?Q?Esyc2vEwVQaZVLnVcVwl/j9UmM6Fc4gYKYgIu5SyWy1bA2n27IDFOQwV/eZj?=
 =?us-ascii?Q?Php7lbjUBjIENdZINe45NeJI7Je0eg+pdXBkBxqnlpSpS+yUhLuwI8so+Pku?=
 =?us-ascii?Q?nGp2PUfgd6IROahuVXBCZVHaNg4cIATbKpmPwEx+R2MJm/IbvXt4fGl+oGwM?=
 =?us-ascii?Q?G28x5bG75JYBv0Vb4a9/GhoxgGem+WTk4cO49+VyPmgo7Wr23RWXEywDtk55?=
 =?us-ascii?Q?k1H9BLVj+wE39qTqHPDITDb4S5HuEKh3HcnZEEy6YGDTr8PRLlHRGE2GzjNC?=
 =?us-ascii?Q?qufcW3hqmH/kuy30jFabwVvNDwH3AHLA3avejY+ErwQq2FPcb09rD9fYwgLn?=
 =?us-ascii?Q?clwMY4b/jqyguE1B/wIkY5JNxHUXXwvJo3hHDooQuHCWA8z9hc/IxudEmlIy?=
 =?us-ascii?Q?sqe8meKDvlYjAoIGax2uz3GHjczTEbaFF91v8z/6634i66Atm/l5xfTl5pwF?=
 =?us-ascii?Q?wnpgcQEUqK0DzCOqqNjOqlqJoWluc+lOToCaYphFN77guEPnuVuq?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 625a2207-8d29-4d9e-7992-08df078d731f
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 18:27:01.3630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QlDCsB8CmlwgIQYqS518ZC/lWEwg2XxArrCgSIn6FxM6xpxwJWSiBJve0YIPvl0FwPBP+Cw2qFTg2fn/+Kpimg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB1802

Endpoint functions that export controller-local DMA channels need the
controller register and descriptor-memory layout.

Add DMA control and descriptor-memory resource types. The control resource
carries the register layout and channel counts. Each descriptor region is
associated with the static channel ID assigned by the local DMA driver.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v3:
  - No changes.

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


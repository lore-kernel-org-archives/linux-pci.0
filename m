Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020102.outbound.protection.outlook.com [52.101.229.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235BA3806AC;
	Mon,  2 Mar 2026 07:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772435708; cv=fail; b=MpVd/JAw5rd/+d7ApZOfBA+UyOPOhUth40pfTPN86tugerjcnZ9aN7vKrbvsRkfEsQoFD1rQQh60tMYD69OljIkGljRiDWBiyl5wZf5iCX2R+ScpXSy62qpk5/G1Xg2c2uSset79oKc75OhuUnTB7+AQ3sZfEuTy2WuxyQbtul4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772435708; c=relaxed/simple;
	bh=GbV8ad1cfEeTeulSvP/P3IAtBHRT8IqU8jKtcJaIjKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n3urm++5jYOkyozS5a5XhEPlygvzKeb4d8J63oD31M2BMAIRPsRqoWz0t5sg85i/DyjjGG/TrCARYiedNVUF2eCLC/0RxLkuHwdjaPMGKwgPiHKtV+l4vmw9X39lHxcLB6YNiyGwwnnE32Er7phOoFoC7oGwwbsWhShTBPsPT6Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=Nhu5tJr+; arc=fail smtp.client-ip=52.101.229.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="Nhu5tJr+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kHx1jmzJTp6+00YHvnJqLw58hHNJnLSzP9jlzM8h2hLD5ipxBgdcCyTth5CEdoIIBxFM0BshwY3vAa456IW7OhXAUFXzZAjpXQnzDqFmVHAKKVubUTHFeukM9sxQBhSozqGalZC2c3m11Dsk9RhotAZLCvxFuBaiu1/QYBy+hInYWsq+98qgTMrJjIrY0I0wnZEYoKEi8Hi8uyKGWR0mHCAaHR6/3Yau+o+euy9sFuO6Dfs41a41Qlwuc8B6YWN+RaQyCniZUR/IQDGKDe5ZVluki8UnxmYB3HsXHVXNwuEtumh09hCF1z2ifhqljjyIz7fupn59lSeFju1SZKJauw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X0Fkw4oF2bUSFPTUrbNsIVj4jeoqIuYXJeYJpeTOHw0=;
 b=r7PuPGOZsCGd/4Sb40KUvEhp5itAj3j4GopKotym8YtX8l7JZtdNPJIzOiNBwAwM1tOg8XIJK38R/aVkarKXl1L7vJjJg68MXrlK7CswzD5uSMpYg9r44UReTDtMGYEmmsD29q1E0mQZRNRZrLF892H/iH86U9NGAkCCBa44mP06X4GeXh1w20+rLBsHOZ3WzI7+UQSVhEYwTbLvpfe3PS2cicr6CdViT2k1k9y0yc96dN2H3fkcgbjddNjwGV6q6YWoMbUr9jHrqn0O864Zn+XLGnzzLT4rsHfpDDioNMXHPkt5hlvv7Oc5yQnmIq5PfXYrStzmEatBvAHaAsgorg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X0Fkw4oF2bUSFPTUrbNsIVj4jeoqIuYXJeYJpeTOHw0=;
 b=Nhu5tJr+nErcEyLwDhHI1my77F9ONr/iIzIEWvx7WguT+bZHMscs2x8iFxZAY5RiIq5t2Xw48KylaJV9MvRaGROmyK6vCU8dXgNNUQzMu1dogxZBzgeVVjxRaValYqOGyniFUtoHi0yVYS8YwD1fGu7ADPN6R46liByvcw9pARc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY3P286MB3705.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:3d4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.20; Mon, 2 Mar
 2026 07:15:02 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9654.015; Mon, 2 Mar 2026
 07:15:02 +0000
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
Subject: [PATCH v10 1/7] PCI: endpoint: Add auxiliary resource query API
Date: Mon,  2 Mar 2026 16:14:21 +0900
Message-ID: <20260302071427.534158-2-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260302071427.534158-1-den@valinux.co.jp>
References: <20260302071427.534158-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0218.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c5::17) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY3P286MB3705:EE_
X-MS-Office365-Filtering-Correlation-Id: c5984a18-5210-46c8-4f65-08de782b6bba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|10070799003|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	J7vYVg3n+QU4QaI4cLQmtiw0w2mG2mIcef7eaw9n+KPdCJ/tjc0AuHg0YRxPeGra9o5zhjSIdk83UU7Fakb5GrL1Rz2fRZFmxcHl0CRHgPPHSuBbeqbGdXwbNKBLGqDfgbRmNx3hpIWfgUypziETihYzrRsvmIjKWw90NchsFPqXZhIoo5RxubaRaVuDSWPnsElnHe9RBG0AOUTdiaJu4Q7csShvR3Kg4PdfMhKQ4yV7Z3v5Xw3n6TCevFis6TJHVTNxDKpglKhxUZsdFtTG+jiqEXAa0sMg+eiO89tdACxW/HyMKiW4pTuyr7z03uQIowhxwQj9B6Lf5xC5eNjWmxuUW7VSC3QFp74jI1l4B1gPzc+UM2hp7bIdBVaQxzMw7p46QJIsveh/4wtouJSTvKSfRMJxkpe3sTSH9hAsiwlCZshO3bwzyIVQSsFVkbWwD6cBkDFuU6+8vjCOgAQedrjXSVWw2+iAQ9BneoNE8h1X8Ykw+EgP5fbbsVAy+qbvjmuWO96AvK1S45HEuFn+DLmkhxTZCm2SRIUekTMn9zHS3QuoUxsMBZ6YsAsGS9iLM3PssOKUvJZgvCPzmiRfM+W4KyigmcLPCf2FXtAqm0ZnRurrwQ40Harue+hRy8Ks9gf+BkMwIhWwX8CkgUaf82DCLYDUIS9v7tp2C3n13W+/0aoCg2v+bhQ9C3kyv7E4edvQu/9BMdvvvh7DJuWIx5/yaVvzWMoV7QvEH0PDu4hOkOtTnjQMcv6iKr+Qkyfq5sLYG99PncWzCyazSXhVvg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(10070799003)(1800799024)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5sli9gi92y0cB7fHvV/sKWGNb7ufHNYOeNwl2GjC9NtU2QCKHGVW9BoWsU5r?=
 =?us-ascii?Q?uD0ayp2eotJN0YuVtvgp5eI6KQxOmhHHMCGTcXT8AuwPKgetmwHH61/xImIs?=
 =?us-ascii?Q?MIrl8sRcJspZZ8A/jYQIqzBeBRLQVXFdOhNvlCLf3trWcAIE/mnkjuSB/XbL?=
 =?us-ascii?Q?fc0VE3oDJ404asi/kryo00WIRSepJcdsm1bmDZ8lUalFmdaJGIDPpvZ5NDBN?=
 =?us-ascii?Q?Lbg4hPJ6Z7OexQRLz1UbqofeaXWaggI2OXUc9WTWGpxJDCp5FGnYNjDj+QJZ?=
 =?us-ascii?Q?AP2UMRDmytg/uACbPg7P1HPX9K1KaopFYXlpYvsb/ubG6mPFJCwgrnHfKbVM?=
 =?us-ascii?Q?90WrcQV+qLR3hdjHzQuq6xq99xfvl2K5oP17PadT1RdqqbPJYwOZtJk5f7H/?=
 =?us-ascii?Q?6BdSD9tXazHMtzHE2Ld0jzZRJscBDgQ6gdJ9u2ipInBwlE161tT8Ml3H7wy1?=
 =?us-ascii?Q?VzBzyLlmqbg6DdNHyzHjVsFxy1xyq68gOS7+IdWt5KE8H2geLPoEyvQjYVVP?=
 =?us-ascii?Q?IQ/WkM44JHfCEuZc6/7HDAuBv2Bs/jBuRL0GeAuVFTUDgKGxYwOUgC3/5FF+?=
 =?us-ascii?Q?Zn7rx75H+rOYamWDbo1FB5mR4m/PdetuJOx/RmHlK6khiPCr42W/0jFOksKE?=
 =?us-ascii?Q?/wlUHyujaqt0c3nNrUF7TwXYQumNN0yxAQLnjkGP/R0paI3W+Uo4IW9esHeH?=
 =?us-ascii?Q?q1tWncqCC0OKXxNVpcp0aM5NCDhS8Hu/FXcfDaTBdjACzIEf2c6HeFRGg+yO?=
 =?us-ascii?Q?cjZGVBdVpdk+u0HAKO/buADwNHnnVnHo/++lSr2+UIQNgZQspQ5eYyqmPn7V?=
 =?us-ascii?Q?1rlcu3qFWjiFqKfkCTtI0/S836RT1f+STBCXmf5dDfHhJxMcaONZUv8RVcGp?=
 =?us-ascii?Q?Db+OebFHVnL1rIfvaUFr8eFUZjmGBlikos9cKiEn1bjscg3r1DnF7Quyn5tx?=
 =?us-ascii?Q?wMDR0YciBWhtHuwl3+VZKt4snp73JHGoGkJJvnvp+Kozgpn2g32L1X1dcLtk?=
 =?us-ascii?Q?I5217jVOcW5dcbr1cvn+2rKZogHxeoFbbdZYPsc0y3rX0ywfcDuJJIMFVoCn?=
 =?us-ascii?Q?Jc3TxBt8gRE5ikCbB478eAwveViZCTHnPEGabc9/XwcCiuaCVK0pdR5VMr8M?=
 =?us-ascii?Q?roxKJagsDP3KG+t+F+a7QYnMnescy/4STrA6Z3iFEIgQs8QBCzpSCeo7dCRT?=
 =?us-ascii?Q?jK0npwCO+ObKcNQIq4TEv4EKCxCQHCOZV9DGYQ978RSzQD9ZAhtWsY7B9TXE?=
 =?us-ascii?Q?a1tf0UClMHrGnRVumrlWAQyv6Wdr72sPX6Prqx4ndCQzDKB9MDycn9LQ79ih?=
 =?us-ascii?Q?YE/GVUkx3Ef0tmVQ5M27gBGRhfQYJc5nvuEfUJMPAy7qrQKuRjAQUTnL8s9s?=
 =?us-ascii?Q?bmJgxCaBKQc9UU2xT+CfWBRNMFgiVdfwdxa5AlUqDVMKynWml9tUjRiVM6Eh?=
 =?us-ascii?Q?rIr78XIiFTKV/yrGlidWQCYyvXqJeCz4z5f2BepgMFPkcHe4sxwbSARb5VCn?=
 =?us-ascii?Q?D450pAFC0ZG9OqnJidyBrBHJUMHc5MG/S17pL3l+nZqlk76EUY0jxentl90N?=
 =?us-ascii?Q?jEp64vKk6miMlqve5H9Ax/5XXlJZQPwbBVRg50WuKzwTAm3l12stiBlyU7hn?=
 =?us-ascii?Q?DdSb0EC28dTJ985I36y+ik+Uq7S2eITjCG7lWlB41Xm3nOuwPu/1mgdWOjDR?=
 =?us-ascii?Q?pYWwcB7QaLRIBMH8SKX5tJeRPE7CMWE2EGhd6tA57A1kQz4wnQSkWVo93LgI?=
 =?us-ascii?Q?G918RgCaZTZ8oaaQBwvcd1qsAGjVjq82k6AEWzRuVQv8GZwxuxQO?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: c5984a18-5210-46c8-4f65-08de782b6bba
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 07:15:02.0197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1HJ8x2bO7pjSKUMNphDpkzXqwzYwaUTQYlEUAkerHb2LCoNCSpLCCxbzLQ2qPjlcp5nL5cDEm4uptKkn0MWElA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB3705

Endpoint controller drivers may integrate auxiliary blocks (e.g. DMA
engines) whose register windows and descriptor memories metadata need to
be exposed to a remote peer. Endpoint function drivers need a generic
way to discover such resources without hard-coding controller-specific
helpers.

Add pci_epc_get_aux_resources() and the corresponding pci_epc_ops
get_aux_resources() callback. The API returns a list of resources
described by type, physical address and size, plus type-specific
metadata.

Passing resources == NULL (or num_resources == 0) returns the required
number of entries.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Tested-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/endpoint/pci-epc-core.c | 41 +++++++++++++++++++++++
 include/linux/pci-epc.h             | 52 +++++++++++++++++++++++++++++
 2 files changed, 93 insertions(+)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 32cf9a9bc365..d63967622505 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -157,6 +157,47 @@ const struct pci_epc_features *pci_epc_get_features(struct pci_epc *epc,
 }
 EXPORT_SYMBOL_GPL(pci_epc_get_features);
 
+/**
+ * pci_epc_get_aux_resources() - query EPC-provided auxiliary resources
+ * @epc: EPC device
+ * @func_no: function number
+ * @vfunc_no: virtual function number
+ * @resources: output array (may be NULL to query required count)
+ * @num_resources: size of @resources array in entries (0 when querying count)
+ *
+ * Some EPC backends integrate auxiliary blocks (e.g. DMA engines) whose control
+ * registers and/or descriptor memories can be exposed to the host by mapping
+ * them into BAR space. This helper queries the backend for such resources.
+ *
+ * Return:
+ *   * >= 0: number of resources returned (or required, if @resources is NULL)
+ *   * -EOPNOTSUPP: backend does not support auxiliary resource queries
+ *   * other -errno on failure
+ */
+int pci_epc_get_aux_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+			      struct pci_epc_aux_resource *resources,
+			      int num_resources)
+{
+	int ret;
+
+	if (!epc || !epc->ops)
+		return -EINVAL;
+
+	if (func_no >= epc->max_functions)
+		return -EINVAL;
+
+	if (!epc->ops->get_aux_resources)
+		return -EOPNOTSUPP;
+
+	mutex_lock(&epc->lock);
+	ret = epc->ops->get_aux_resources(epc, func_no, vfunc_no, resources,
+					  num_resources);
+	mutex_unlock(&epc->lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pci_epc_get_aux_resources);
+
 /**
  * pci_epc_stop() - stop the PCI link
  * @epc: the link of the EPC device that has to be stopped
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index 63a24ebf144c..0827650acf93 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -61,6 +61,51 @@ struct pci_epc_map {
 	void __iomem	*virt_addr;
 };
 
+/**
+ * enum pci_epc_aux_resource_type - auxiliary resource type identifiers
+ * @PCI_EPC_AUX_DMA_CTRL_MMIO: Integrated DMA controller register window (MMIO)
+ * @PCI_EPC_AUX_DMA_CHAN_DESC: Per-channel DMA descriptor
+ * @PCI_EPC_AUX_DOORBELL_MMIO: Doorbell MMIO, that might be outside the DMA
+ *                             controller register window
+ *
+ * EPC backends may expose auxiliary blocks (e.g. DMA engines) by mapping their
+ * register windows and descriptor memories into BAR space. This enum
+ * identifies the type of each exposable resource.
+ */
+enum pci_epc_aux_resource_type {
+	PCI_EPC_AUX_DMA_CTRL_MMIO,
+	PCI_EPC_AUX_DMA_CHAN_DESC,
+	PCI_EPC_AUX_DOORBELL_MMIO,
+};
+
+/**
+ * struct pci_epc_aux_resource - a physical auxiliary resource that may be
+ *                               exposed for peer use
+ * @type:       resource type, see enum pci_epc_aux_resource_type
+ * @phys_addr:  physical base address of the resource
+ * @size:       size of the resource in bytes
+ * @bar:        BAR number where this resource is already exposed to the RC
+ *              (NO_BAR if not)
+ * @bar_offset: offset within @bar where the resource starts (valid iff
+ *              @bar != NO_BAR)
+ * @u:          type-specific metadata
+ */
+struct pci_epc_aux_resource {
+	enum pci_epc_aux_resource_type type;
+	phys_addr_t phys_addr;
+	resource_size_t size;
+	enum pci_barno bar;
+	resource_size_t bar_offset;
+
+	union {
+		/* PCI_EPC_AUX_DOORBELL_MMIO */
+		struct {
+			int irq; /* IRQ number for the doorbell handler */
+			u32 data; /* write value to ring the doorbell */
+		} db_mmio;
+	} u;
+};
+
 /**
  * struct pci_epc_ops - set of function pointers for performing EPC operations
  * @write_header: ops to populate configuration space header
@@ -84,6 +129,7 @@ struct pci_epc_map {
  * @start: ops to start the PCI link
  * @stop: ops to stop the PCI link
  * @get_features: ops to get the features supported by the EPC
+ * @get_aux_resources: ops to retrieve controller-owned auxiliary resources
  * @owner: the module owner containing the ops
  */
 struct pci_epc_ops {
@@ -115,6 +161,9 @@ struct pci_epc_ops {
 	void	(*stop)(struct pci_epc *epc);
 	const struct pci_epc_features* (*get_features)(struct pci_epc *epc,
 						       u8 func_no, u8 vfunc_no);
+	int	(*get_aux_resources)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+				     struct pci_epc_aux_resource *resources,
+				     int num_resources);
 	struct module *owner;
 };
 
@@ -348,6 +397,9 @@ int pci_epc_start(struct pci_epc *epc);
 void pci_epc_stop(struct pci_epc *epc);
 const struct pci_epc_features *pci_epc_get_features(struct pci_epc *epc,
 						    u8 func_no, u8 vfunc_no);
+int pci_epc_get_aux_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+			      struct pci_epc_aux_resource *resources,
+			      int num_resources);
 enum pci_barno
 pci_epc_get_first_free_bar(const struct pci_epc_features *epc_features);
 enum pci_barno pci_epc_get_next_free_bar(const struct pci_epc_features
-- 
2.51.0


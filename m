Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021123.outbound.protection.outlook.com [40.107.74.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112063B9942;
	Fri,  9 Oct 2026 05:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791522013; cv=fail; b=qyA8+lMcMaorLkpfYu3ivBEWTwUBN1pGhzSv3cqe8/Hx4hzE9Ngw2OWvHUT8m2kLuxm/EkhHhwIYWtGuOg4VrSMgQ12Xq24AKa8hBnlWxuNoipP6s4ORbNi0+rr62o5quqHs7ubb65nlLKMnmLBiz/IlZqCEuj659fx7xObirM0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791522013; c=relaxed/simple;
	bh=9gQzotz6EjHmiITAuEXZxirjusUO7+8r4XwmRMyravY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lc76PbScLSHBdtGnMTf+n7eOZV2bx8MXTjJWyqKTntxfH1g6PjTZgnON8ksmSV9xzxwE6aSLTctl0fQ9d/A+Tb4YaW0rcJXL72hK0hr/O3v1hbhY2A2dvbjcKvsitiAkiBjAa5c75nDmwy2fUJquhQQWs+U7CwuAfRBWo6bv1Dg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=InlZFbxz; arc=fail smtp.client-ip=40.107.74.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="InlZFbxz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qhWbtOXrDvsAkMOaSzBEutdN32SuO9Uv/2KobYW+vztWV1xCXG3m1TSvyAxGC52qju5FBVP0mA2ydCSvBk+eX1Wobk3N96EDvsiNNfsYpzULbNaDUwTC8uaFBIiPrb/3Wb9Oyxhy6qHu6NAK2lv1ZzDXP/eYtTtPn2lYTldgfVhnrynZ5hpGFZzivPdE4N9KUAxQXjsn6bayh9aJJ29Amwa1k8QTE+WUBfTrI5G1IMxPW+omnRkYC+kf2wtdPB6dvE/lYRLzjWvzlNvZQMUIYiqGnU032zdCQvDArxnJ0vzVmsKZcp/yTLlKpWMWJh+W2TPlhklOGJ1EcFizZrNMXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LduMIdPXoDUX55MFm8qd3KtDT20qdIodJ5df9LnV35k=;
 b=SJyjiQtJqaEmcpASB1FXW8UMfI033MnDkMHfvYx+sD61DR9loyBbTYfdK6nlygvIlpGrHKewZkoxzRRb6UCo/+8s3w8OLawJAU0BsbX4FGZ9D1oasBiP46km5gNxZe++l+1Lh13tXpZxQcNLKH7RZwuELPzFEGjtIewzVyyjw7NYFs4M3Vyt5pxLQLUzx/ki6l3x4b0dZBAdwpqdIr/X2TW1x1mBPmbhJDph1X5CkLhRZXfFHxTAczbJZ90qVwabacwTi7pJwe9ZcRWQKIGZcjW1plchFzwJ6P48UsSxt2Ovunn4bT3Y9spnJ/yI7SImFNb7ahj803/OB84cqKg0+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LduMIdPXoDUX55MFm8qd3KtDT20qdIodJ5df9LnV35k=;
 b=InlZFbxzZDyu+wK+4CEL30WtucJAbE6rS+z3ghcLUPX0IaGoyaBzvfKbVLd9+cUnrrrozyIYJHy0aD5wxNwhje0g66TZiQ2LH8KzHW0MCR6Zsy3E+epFP9K2Yx27qlY7Pj7x/lqusEYJ6EoUVaWrSZGPnM17xoOwUVn2g6P7V8A=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OSOP286MB4369.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:309::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 05:00:06 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 05:00:06 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.Li@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
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
Subject: [PATCH v5 1/7] PCI: endpoint: Add DMA auxiliary resource metadata
Date: Fri,  9 Oct 2026 13:59:43 +0900
Message-ID: <20261009045949.1109871-2-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20261009045949.1109871-1-den@valinux.co.jp>
References: <20261009045949.1109871-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0286.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c8::18) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OSOP286MB4369:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cad0e13-4e02-4785-154a-08df25c22f34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|23010399003|7416014|376014|1800799024|56012099006|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	xHkXVwqE243H2/4n0S6A6yXKat38P+tCyNMj+7RpXUMTZdx+mzwPJUnXDy9v8sXjBg01Vy02sqkoVuCbSq+QHlqQT6SjQ+0JgE4b3xjA95bPQGmA0FXfNKz3Cu9730sHRKbLW3k9cSUHhPVk1DeTaMgPjjk/rhaXEqk17QJqTdw2Z35QG6sZU+rY1qSSOurkvhTkt3nAXLUzgHO99tE31eY+tWfxYIni66AkBoipsvoDd9He6J5AJOeCLcYahQVKqLf9lBaV1O5SFMCwCq8DuyFvvxrlDBDwcu+rggG+rpPNKys9cE/RZiKu/KZ9n22fGY/Vkm6sb5jsdTAJ05yQFV/jOoPqC16jjSF7FENo3AY2ntjit+ZkVzmp0Ycaqz5xaDyxPBmV4Qz/m1QJXYWPvnd1h5HOeZwVok7pjkdTBe0nlnDAXPm2uS8fIalQdDqinE8WVCArsLVrxbE2o9D4tVxTbD0JESWGOvkjbCkml3oyERvVDBYE4XI0GglZlY64+CyPD+T5Asvfn8AJEqXdzmLVovyL5ILIbZnnRix/nprVpr6Iv9pc+uHVW0aLe8fQZTzmJPodtkwzPWnckUrA/PGGwWB8G8nuCwGwD1wbPc+jxgA0/yELzH3uex256APfSs2z+bgqchf8EhRr48lDNVcKALZPy42vUay5VHD49J8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(23010399003)(7416014)(376014)(1800799024)(56012099006)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4JnY4VOKePoy5fOmmYCZUbLjx6UjK53IRDcTpFoRLmEt/CWCQ32DmIYE/DK/?=
 =?us-ascii?Q?dWQjr0BZ/Oy5gPyGrOrU1hO/3Ne3J/bN4+We8COPBn5AMgWS7OkF+7N9nxmJ?=
 =?us-ascii?Q?qJM70/BoIW4oT55mq6WCcwOdTagtWtydk4hl/dI38AiQ33TdJJQL2+EpxdPu?=
 =?us-ascii?Q?H0Pw2q7qZ6rQ1BnrFIspWU3hixrII0cWcyzxAJnO++Ak+DUcDzIt1m4W3RzC?=
 =?us-ascii?Q?fWEHtc7EB0l5iqf3IEDzFZbKZ7BIGyZitSw3ttn6IFVkEwyO53mzW2KFAEwb?=
 =?us-ascii?Q?N0+A8XMrer5GpCC0E3p4lsaBRGjZV41a9PDcAeCdEJ0DsPC5BOAd/w1i13CN?=
 =?us-ascii?Q?ctqA2o7qfp0mddMyx+6agCvLKAD13HCDoD0GD0YOoWZtB9n1GWnWVhxCL/Ix?=
 =?us-ascii?Q?lLCRU2fbHN4YATmkdjtXVIf21gW0OLdKORTKyQxDiL8Pu80ERDo93Hv6y15t?=
 =?us-ascii?Q?YGtq1n+RSzs+7JVTeR+7MTOEz9v3U0Sy1v1mx80+lWz025e+Lk0DjeTZOGBA?=
 =?us-ascii?Q?jXxQWRqHAfw22LEvuFRDNUBC9I0MSXstc2x1TvQ33IhWZFBaBlL5RoDYh17r?=
 =?us-ascii?Q?EDqaGIU3cyt8xAf79fbOohSEF3qZrbI/g5rK+kZ2a3UAkDA/8DbbcpyGkAKU?=
 =?us-ascii?Q?OAuv5zQQlT3+1MYFikPCPEdldUMU3R6cOjTe0EmiTNa2vsHxRHbJFJLoGguV?=
 =?us-ascii?Q?/csSJ0e+sSTd7ydmAa67S+d2PBs9zv3c6r12X6pOcWy+QWJc7wbSAvafe4B5?=
 =?us-ascii?Q?TR3R20Dm7745BDZViWAni0cDvcxutTBMTMjZo/Lh+AIKw68/Xy2ALxcDqCDY?=
 =?us-ascii?Q?93JXvzWTVrc5o870T4QxbWk8C07MK2TLyAwNbC5lhpyprUhodYgJW/EBGDCV?=
 =?us-ascii?Q?GWEKNQ/kRVZ5pXjejw7fvbYBtiWZV2YqUUwqETG1lS5HStHcYt0e+2Pho/uF?=
 =?us-ascii?Q?k3HHQMhAwoHzmd9YfoPyLjIgi2BZQT4wSySPQDlc/JWZqe3EAGdW8Tc68k3M?=
 =?us-ascii?Q?Wchh3sPYVIopruCmIQQM8rz6MGHNEwhS2ktYf+oakRH5VumD/smlg3qAvMEj?=
 =?us-ascii?Q?/8rxBY/kKodM3QEuBqn63VyTZpGHQOijgQ9/VGRAT/PZ14Kun1Q2dMVH8ZBD?=
 =?us-ascii?Q?MF/wKOPd5s/ZeNGlElrY8nYeN6s8MWkEMQx+8gV8hbYTJoe7N8eBnzFcRgoB?=
 =?us-ascii?Q?mIQqc9oj7F6q1ok3n/Lis7/y04riDZc0RM3h0NlV4MHpnMW+B3ssffyrAVVf?=
 =?us-ascii?Q?iQmeCzJ6R0oOWZgc9NkPo58y+ZI4Nq+l8PMkcEWIHV2AjVQBn1rR1dMfmwcH?=
 =?us-ascii?Q?ZwDHtW23OE+gnspWjzMP7JiVT395KUXpaoOtc003ebzb4fwpmmG8QvEklTAU?=
 =?us-ascii?Q?R1LjXNMifPRIGBcrX7S1AwlZxMOLxz0bppT3QXC2EZuxA0MLrMsHlWUQ8YvZ?=
 =?us-ascii?Q?53kX+H/3pD2brVpUoy3iS6yi7F7SER1RBY+BaiA2dcuTacrbP7zddkVGGjY5?=
 =?us-ascii?Q?myMjUl96HY0lX/Qqaoh0qySoTQHNNXVQ7YiptE7eZJeCPmUTcSyBIZm4RIIk?=
 =?us-ascii?Q?Mk0EkJA7+VIyuA7uUfMRILRHE9EUZl48V5X3uOIu72Ck/5NDyhhX28yHog7r?=
 =?us-ascii?Q?SCMc/PK/quFytLcIGjlpSdW0l3/qoY886SKbhlPZdNjljFMfx0EaWofhAwAd?=
 =?us-ascii?Q?E9OlOd5oOYmq/U/bdpQdAklmE436mpFxk/RnWtJW+xT7aA6QgY5OVHGP315m?=
 =?us-ascii?Q?h8Oe/VhSiO6pk5bN2suUw06Qc62u9KYv+9OR8yHDeeV7NtVnbioS?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cad0e13-4e02-4785-154a-08df25c22f34
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 05:00:05.6863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uBlmiJGt6+e7xB61KRcYwcVj3KQQwSQLOHBWipvsVyEJ5Mn8SXPZ8sGI2xdcq7ulwW8K2ylmhKlYFIbjYQA6IA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSOP286MB4369

Endpoint functions that export controller-local DMA channels need the
controller register and descriptor-memory layout.

Add DMA control and descriptor-memory resource types. The control resource
carries the register layout and channel counts. Each descriptor region is
associated with the static channel ID assigned by the local DMA driver.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v5:
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


Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021087.outbound.protection.outlook.com [52.101.125.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C954627FB18;
	Sat, 20 Jun 2026 17:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781975102; cv=fail; b=M2XXCnp3mQ6YpIHEYTOYgNodKhIPtIIrv1oIGVm8z4YDUGk07LOLRJ1r0pQH1Ujj+7x9ra7lzF3ACaIcE9OdsJ2hVIY3GUUqiclb5tGp5KE/7xlyOoUs0F/4ZjU2kD+oUby05pL28jK88C1nnumEZKG/+SrXsL+DXYLAthdZyTM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781975102; c=relaxed/simple;
	bh=c5eAOuWnLFQcQyDkgyr83aDkooIsVbH2ojw5+qAVuXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dq/P8NU0TipRXvnueyi1+MXdtBKzTKgn6yd3vaVr2J2UNB28JEoWV3Apgve28ipUaVHxgaCXLEZORlaEr3g2RuGRgDAdJMpmFDslDvsPODfUqdyCOxl222FALA+k/OjasQTp04jeJRM8jpdz6hc046lsziRrWASaEFPogC5mVQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=wqXvCI8l; arc=fail smtp.client-ip=52.101.125.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="wqXvCI8l"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hd6eBPhcKKp3yv0w3eXSu1tTdnhy9K9QdY/ryrFACyH+PBMeD22Fqog+Pbfn6mzxChEzNQWPQjb70tEvjPJN25L4QmzNZcBoG4qTTYtv6APQhHHrZh9drZuAsgWEKwbNETCkHxqcOZYUnxboRHTVJ2cwbHf05/1LrVrjV9TnTAt6qh45K/flG8c+OGk9rehYPUGyY/SI3mUITHmlbOEHSABrvzYnZmOLOi+zCfOjU9U9C4R/4DReZ+G4QTuLAlCzBCefgbweBsxuqbDQU1/LJVmawHGTsxKEBs80vFmcciHrTd15tnw7DSDxubWLT80eUYlb/uweeDDbHl573gW5AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZwgcrIj+0jsGHo6zlw1W0uZZSV0JgZNk26Qh03dpA80=;
 b=BMK+59q9wdRwoQV0ZmfToJ9bQvzny+JM1O9pYrIPG3VApK0ik9epnalCvJ43FDHGZ3zXpN3H+IZ3G2KSJhcO50QQu/HSegb1+KWS9uSvVGS5swXBhJzNqQw9TP+ZFkTzF6BLJmojwS5+nm3LukiARUWAF8ky5M/Ujm2UjWOEFFVzbn4zuU8ExCdjjGpqAsqEHfRTtui48aK+OG+XDxCusoZ3KtMrp+coJRhhAdYt8+wrWj7M1FgUHQk1kq7QR/6QPmlGPLA4Lr2nWAPRkKt2AafHX+AF9RidKQsve45Jd2CFZ1nVpAUlaRdNHaTMvEqa4BS9Rxvp5yietu5okhC06Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZwgcrIj+0jsGHo6zlw1W0uZZSV0JgZNk26Qh03dpA80=;
 b=wqXvCI8lFoJjJgyLYpyMopap8mQ7SwCfVsBtEP6CfvGKr6brCgop/DiVo5NhMvslPniKZlrvMtTJFUQmvJOBlVE9/xr20dS7VLzGcB1xJAVAKFN2AjRTEwXhfl/5X5Um6Bo2kRQKTgD9juaHiq9rDtySduE5/C52e1bRAqEj2rk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY3P286MB2673.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:254::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.13; Sat, 20 Jun
 2026 17:04:57 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0139.009; Sat, 20 Jun 2026
 17:04:57 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v3 2/5] PCI: endpoint: Add DMA auxiliary resource metadata
Date: Sun, 21 Jun 2026 02:04:35 +0900
Message-ID: <20260620170438.3756593-3-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260620170438.3756593-1-den@valinux.co.jp>
References: <20260620170438.3756593-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0069.jpnprd01.prod.outlook.com
 (2603:1096:405:370::12) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY3P286MB2673:EE_
X-MS-Office365-Filtering-Correlation-Id: 64f7a125-fd36-422a-8787-08deceee0e63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|10070799003|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	sIwQbriV2HKry3D7OuBnHLQWRj9MNA5PaV6xc0m4B6nu7sJB2J0OKgF4G9z6J7qR82TTLJa5137rabkgcjDAHbkviDeOw7i7V3d+z7f37P0GJNxp02hau9Rzjybs2TJkLhMAq1RNuXaGOU4Ht4+Z+eYuyCDbK8frfwYyA89yxpTpV45MDxkFNMP9LJsA5bqymwXzCNGYTFOhKHwZLHzPxhqAlH0tJELhwqHmK+YhK5JOKU3tX8fhlYSg01FMaJPWGr/+Xk1H7k4Q+JHsnQqsTnIilBqst2x30jAp1/a2EWGxIbfO2dbcuCPSE4W5dSYqmy2U5OvHuDa4CCdVqr5fAw4kd5j8eS21pIaxsI3rPGeC69PWIsnttQSj176+eY/lT2ra2MVvRnHBCkQbk1t2wC8cHg3rCeE/buwHm2aPreGicPnAVrrhJSQg0ddKtQuThBOihXD6Au2+2ECzGd9feK4QEZzwl2YG5crSEgDXCZawIlu2I77l9SlWXaSq3IIh8B7c9LSxN9CTeArG7Kx/+nqKSwIuziKJkLBTMBQCTooYLqhuf8/iSXo7LHh5tSBsOCMDQhuLV9HqyMT8/bMLn3lLVkYo+W2Y3RqffVwRkzeR74e7J87/LCzNFqrwszo0q95+yb+HNZFE0apo2QE2nFly+/J2g48Pm2xVT8iJ85I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(10070799003)(56012099006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FcFFrmzmNEYagoXWIPp+doJ4R8M/6Ism0l5lK70Xcsgndkt9lhb5zw7SOMzp?=
 =?us-ascii?Q?xMo/aa2nK3ko9zGTBSnmn1lQczskxQwGhCyfkOh3oizh5leS7vEGkVqChYvO?=
 =?us-ascii?Q?CslAki8AIdEVc9H/UVjN5eziuiwh9Wl1+15yKmQusD0vrmNljHvv5WiVwC3O?=
 =?us-ascii?Q?hrkXbQVgNBeZPZvZglL4bJKmNz0iBheMEMnO5m0ZSctySX6uEMTB/0uhsB1y?=
 =?us-ascii?Q?j0nxJ+oRNTTtmPrNm+3wsj8s5KfyboplgBV7dSMg1LyEylYZKw90wOEJONdf?=
 =?us-ascii?Q?fU+7uXxHHwumtPTTJyLBe1S9uakkbjV2IlirHAdCElcCX/SCl+p19oNkWJUX?=
 =?us-ascii?Q?xXEl4WigZkb5WGO32N5IwFoRrS+eiDUszSqU7WuvOgn5JmiLxSKvurAfjfMv?=
 =?us-ascii?Q?rtq9fn7nV8ZFUzdnrvDSTHj1ilJE8lz2uFxi0aX8PSSJZ/oxnKPLVcXOMZom?=
 =?us-ascii?Q?xIZAzrsW1MxKmU+VWYavyuacN6YJKd4/wCR3hUiIYXxoviLqKVmd4CPOsEJe?=
 =?us-ascii?Q?tJ6r+0eTL8HPBYACtBV/WERjSuIX//BL0wrYUM2XtaflfuKVj5kaKLdkvnLk?=
 =?us-ascii?Q?YdMijj57vjiSm+cu1mfoPQKxfuzs7yBjfCae0iJifmr4kh0UFOZyI6RzMfv5?=
 =?us-ascii?Q?/Um4JeZaqAGVRNYWRf1eJ8uUwSl7BthHz9Q5OIqwuRojaetiMz3f+t39+GGM?=
 =?us-ascii?Q?Ma03xwS2oBv8sFhG1onnJWARGLC4Tq5qXdn+UBbLEv0snVzzoMFjcBx37yvI?=
 =?us-ascii?Q?fFF54HU1EdlAYfn3sKKJnUwyHCjIF0CagN7iXQJm7d1Kvtok3ISgRGhSU1Ts?=
 =?us-ascii?Q?rI1vQXVhZaJdjjXxruH4dKnhZhSoBQ1glz85jBS74+jS07L6w+1yHajTi/5a?=
 =?us-ascii?Q?hfm+PDWmwCkCp88oIJu3WEkGafyB9wxTLIG6PwBbkBgbzIOID70YcMzhDUYh?=
 =?us-ascii?Q?ahIyKf1JQqGfanG/2ImnbH36SE8gaXgM636HLESCdSaoNADqPdNcSKb/aoxZ?=
 =?us-ascii?Q?cTCCQfhhFNJVWuytNq9jXSCBRSsXhLnwS07EMKVqgWOx7lMvglkHh/QfzHn/?=
 =?us-ascii?Q?6TNY+f3YcgnDU0Nn3DlN8pAJT07bvV81wkW1BBgB4xzcWWTl+qsrdwZeTvwz?=
 =?us-ascii?Q?dW3Y/5ofWOATRKyNpNTduUAUAgetCjgM1ZUSiUSDHfNLMcXFNaj4kGPZKYNQ?=
 =?us-ascii?Q?3iIQF7FUMxT5EUqqnEUe/H6po56CLClht1PVqru8dzoEK9mhCZIOtUjc5+gG?=
 =?us-ascii?Q?gcM7PgJ7M1eOGkne7GjG83sjewlmL6qkuPFg+h6hanAE3kdmj0vx1fo5E+Cu?=
 =?us-ascii?Q?SITInHdOS02tg8/iIMKbtBSb6Sijjq/ghIasOKyUMQbmSI5h9WEKMACyIA8+?=
 =?us-ascii?Q?YGVWAGR9ijTe5XzoWrCMpCXv+TuxlEucfT7F7JTOmXBVNFQhRJ+f7pkVD9RW?=
 =?us-ascii?Q?EzqNG6vY/fal+wsv/abuVRdKbMCHMAto1pX/s+8N5YxnAEzdFMt5P0g/xU3k?=
 =?us-ascii?Q?IvYKA/uN1t3Qn7+1i+TLJuMIJe4GyU4HiLRF6quFj004iEG30yo9Q7FwsTQV?=
 =?us-ascii?Q?oSbfdMvg0neRmOmK3LwlQJnuIbr7ZEmlwzNU7Zfk8uKvkAVOtYsKVYsNu9TW?=
 =?us-ascii?Q?9BR0TjB6+9ykWuko37zA0W1mHrUel7Fi6j73E5nNBQ1EEf0uWOBu0BbZD8Gg?=
 =?us-ascii?Q?WN4hkjowuSxtZ7v0grvLqVVFiUjP+5gSHkX2ruSxOKirkfGTQvkuv8byNLsa?=
 =?us-ascii?Q?94jCW8Ocp8oUYSafefkoXe2uNpZGZR3St7kfatSucqbEn154ipID?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 64f7a125-fd36-422a-8787-08deceee0e63
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2026 17:04:57.2706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: baPptTwcGyeJnxyzSiWp8WovLzTpIBeBSqttngouFSLxRRsiPSDT6C2WC2n4lxQQI++6i8rQsWkDtaErinF9+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB2673

Extend EPC auxiliary resource metadata so endpoint functions can
discover controller-owned DMA registers, logical DMA channels, and
descriptor memory.

The DMA metadata is intentionally generic at the EPC layer. A backend
reports the register layout, channel counts, logical channel resources,
and descriptor memory resources. Logical channels carry hardware channel
numbers and refer to descriptor memory by ID; reserving or delegating
those channels is handled by separate EPC operations so resource metadata
stays independent of any backend-specific DMA provider. Descriptor memory
is identified separately so one memory resource can be shared by multiple
channels.

For DesignWare controllers, reg_layout_data carries the eDMA/HDMA map
format so a consumer can distinguish legacy, unroll, HDMA compatible,
and HDMA native register layouts without making the EPC API itself
DesignWare-specific.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v3:
  - Decouple logical DMA channels from descriptor memory resources (Sashiko).
  - Add an explicit unknown DMA register layout value (Sashiko).
  - Drop DMAengine filter callbacks from the generic EPC DMA channel
    metadata.
  - Keep DMA channel metadata provider-independent; channel delegation is
    handled by a separate EPC API.

 include/linux/pci-epc.h | 47 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index f247cf9bcf1a..b86d46411065 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -11,6 +11,7 @@
 
 #include <linux/pci-epf.h>
 
+struct device;
 struct pci_epc;
 
 enum pci_epc_interface_type {
@@ -65,6 +66,9 @@ struct pci_epc_map {
  * enum pci_epc_aux_resource_type - auxiliary resource type identifiers
  * @PCI_EPC_AUX_DOORBELL_MMIO: Doorbell MMIO, that might be outside the DMA
  *                             controller register window
+ * @PCI_EPC_AUX_DMA_CTRL_MMIO: DMA controller MMIO register window
+ * @PCI_EPC_AUX_DMA_CHAN: Logical DMA channel
+ * @PCI_EPC_AUX_DMA_DESC_MEM: DMA descriptor memory
  *
  * EPC backends may expose auxiliary blocks (e.g. DMA engines) by mapping their
  * register windows and descriptor memories into BAR space. This enum
@@ -72,6 +76,29 @@ struct pci_epc_map {
  */
 enum pci_epc_aux_resource_type {
 	PCI_EPC_AUX_DOORBELL_MMIO,
+	PCI_EPC_AUX_DMA_CTRL_MMIO,
+	PCI_EPC_AUX_DMA_CHAN,
+	PCI_EPC_AUX_DMA_DESC_MEM,
+};
+
+/**
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
+ * enum pci_epc_aux_dma_dir - DMA channel direction relative to the endpoint
+ * @PCI_EPC_AUX_DMA_EP_TO_RC: channel moves data from endpoint to root complex
+ * @PCI_EPC_AUX_DMA_RC_TO_EP: channel moves data from root complex to endpoint
+ */
+enum pci_epc_aux_dma_dir {
+	PCI_EPC_AUX_DMA_EP_TO_RC,
+	PCI_EPC_AUX_DMA_RC_TO_EP,
 };
 
 /**
@@ -99,6 +126,26 @@ struct pci_epc_aux_resource {
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
+		/* PCI_EPC_AUX_DMA_CHAN */
+		struct {
+			enum pci_epc_aux_dma_dir dir;
+			u16 hw_ch;
+			u16 desc_mem_id;
+		} dma_chan;
+
+		/* PCI_EPC_AUX_DMA_DESC_MEM */
+		struct {
+			u16 id;
+		} dma_desc;
 	} u;
 };
 
-- 
2.51.0


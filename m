Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020124.outbound.protection.outlook.com [52.101.229.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861EC3750C9;
	Fri, 17 Jul 2026 05:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784264806; cv=fail; b=oUj2AjtiIct4U2/7e1M6OTywp9sh/bM2nlIY4+xI80t6+q3L5aw3M3TuJXpfCGP0bH6vhTkX8rb2dDqt0MIhENqmsK+E12A2BmnMp+K9FcJAzFxq5fMxLGTzZWmE/gwCYbZLxED51pV1yczWeEsws40uGV/DpSj7NorzoDcfd7E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784264806; c=relaxed/simple;
	bh=UvCYXAaG4P1/rTdsoo6gwOjGpSlhWpQJ8AW9F5Qubv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ky1eh4gAWFubErrMqyHUbXBQn3hQRDRLpRsUawBqR/63hzScCvkoEzBpbpXIzXIOSlo9dhQaGs5xlKxKInBWgvN6+f6kg9piqqsHtwrXRA6VuFImLF80anM0ayhr7d0kzHCzJzfxUkQpJs/4wB8jx6SVQFno3EpH9vWwQdKyGdw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=e033Rz5F; arc=fail smtp.client-ip=52.101.229.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="e033Rz5F"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DwMgF4NZ6mde1Ny+697hqb89LzO9MtH7qPJ1VTumTqUGxmP/BRqCkvfi9uKqZXv7l6ahys9+YXhbCjFVSEQix4AeSlC7m0ZAsBNqDfJfkAbi8R5KC0ytvxY7YuC/4Uoym1EmOfPuyvYaXA1TPmLjmju/1IvJhGiKey/dzb1FfHQ9a4vWwkfL1bZz3/HOJtckO0dqNd4wZ6t3aCSXphRH2ahtDx3jhGuZYA7godZXw+opJk2sMKlKAifk7c6xbqssP6obHAmOAAX2DNbT97Ou1vL03B0bLMJijfP9sk2vvTDeqs2RRvIcYmPSe1cS2ZiXdyBX4ml5xHn2Fp6R5ne7jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E40XHgyoFoN90i83IBPDYgigGvXJ2PlA5xuIM5Y059w=;
 b=E7cy41Yo8qyyX2G986K9KAukSzqLyXmQxkCwhUktv9EWVIrKH89ZdQxokwWG35ySHASv3EKViO2OgmdslqpaIa+/ApcIgD0976f7CtgSaw1L4PHSyQJ7xRp/e90zY9P7f6HNRIA3FADJDfnAC+fO+LPiQKbJp2qAknOU15w9VxMhcEMhFe9HN9YJ6aa3GizzdgRLbAR5l8HU9rlQ6dDWYqDAuu2FO1sGy2nG/s9LFKX8Qns1lCRqD9SnB9qjijUA4PAnY2foCHCLwPX7WDRMMpInTUvDlyDHLO4pTrSyHgZWQuKUIjwRn/uY6wtC1wQwFIzPjcsGt4R/JvuEQQsMsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E40XHgyoFoN90i83IBPDYgigGvXJ2PlA5xuIM5Y059w=;
 b=e033Rz5F07cqC+bBJMytdzve2DNBqlTZ7b3BlovMD7i9ZUhhXLM/1KsHnOloDfvlh2XRzMXJuaGYD99OryjlwRtERLVPyrfpKgpyigka7ulqdrxII/Enbk7Ev5XE9iKiBwharUYTlfkOUqsrYvd5Dg2xG59cgajZY3Vpkf3Wr+Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY4P286MB6910.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:33c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 05:06:40 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%3]) with mapi id 15.21.0223.008; Fri, 17 Jul 2026
 05:06:40 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Frank Li <Frank.Li@kernel.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v5 2/6] PCI: endpoint: Add DMA auxiliary resource metadata
Date: Fri, 17 Jul 2026 14:06:31 +0900
Message-ID: <20260717050635.2145014-3-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260717050635.2145014-1-den@valinux.co.jp>
References: <20260717050635.2145014-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0087.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7b::6) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY4P286MB6910:EE_
X-MS-Office365-Filtering-Correlation-Id: ac2ecdec-ebcf-4b70-7b0c-08dee3c12fa2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|7416014|1800799024|366016|10070799003|56012099006|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	tzbJDBiNJlfxkyeo7OMSOIT9L2j1Endk5mLnP+ExZBKwe2uW20Zd+XDm1KXwq5HxxF2lG/nm1C29pwCTQ2XWjOobLVNdwbtsiIJJaUXHiHzH/MMMX8wnmJz5qdFn/ckQCGN42Bduwc0vpLJcYD18Ucl5JR8cOylN+QeHPX7YV9MPPSlXf1LPmtnGvQItwwvdqQASWOIOYBeg8fcupHGGSmIjnwZS9P3IvqHvMChYKkYKf8MQKEx0XWmyB7Kbd2798LA8RjI/zIanJTuj7xQh/wIaT6oyvA7m8QvwH3DTyIzUp3BnOkmieSPh8VW0Ijej+rcSIye6ViXyKREuoiUdhws93Ku6z1jRMizUQ1UsXCjQLTSPU/fGFU9bpLcp2gkEmsj8pYuOb9kvoymyv7e45/3TVd0b/YVP6reWbmbssDgMcKvqfJV3Jxkngy36P9JbNo885Zqi2HrFCT/I5qCUUcj+SEoyFOk2OP2s+F3tP3kgwI+u1/garE7tbPtITU6XbRzJPAcBy5CmjIgi/gosWc5prUiotCi5dRkybXfeHnGjeMTg9JI+BFkF59CXT42t9teSZDTRZ8ZJ6nm7XVoFPhB5UO0PoTEv9i+x1aAkVnzmYesK/hCOIBBq0/O+A02n9vXrGUPWYdxgM0h2F8DEl9gZ46kbgs/y+vBGJ7E3kJ8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(1800799024)(366016)(10070799003)(56012099006)(10067099003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8ef2C6H7a5UvUuK9tWlYkMN7qkpmIJvKNgtc0gzqCCb3/vx1O40+yxdg3SJZ?=
 =?us-ascii?Q?B8eIwaHvG6gkyC9gjChWzhFu+tNlNXi2xYI1wBLMSJrCH0pj3D95dUOi3Gaq?=
 =?us-ascii?Q?RjJ8LZ/Hi+1ZjqIvo7Js19/qvtjc748DpE7PyU9KhnO/AkyR+NixxqH/kaQs?=
 =?us-ascii?Q?frtlwnYBjESP2TIlIYX0P23p98rNio7QiQIxsC9vymjGC7p217hld+zF5y7q?=
 =?us-ascii?Q?dkvYMOY6W9IAdwynwXv605MKqZdit3ufpBD8obEr40aICDFfVT78jmypAlht?=
 =?us-ascii?Q?FWa0WUExm4aaBd3NmkQvvLueFtjeCfyzfFSjpXY0ZSarBEDEyGv6j7MOpHbH?=
 =?us-ascii?Q?zbY5ydav+ImzawKGBJCeihR836Sozu/OczcOWgnAZNFuB8wlNOuaOwZo8pbf?=
 =?us-ascii?Q?Pp7hm1SdQ3OdaNGVdTfBmCrvrEQHAh06uocmATv/24sBgWG3/eDcOMbmXXkl?=
 =?us-ascii?Q?7GmHeK3I4tIVnhzXNJK7Lzu8ShCY/l8+GwJTYxvhS7v1J6HTx6g+eJbG7xAE?=
 =?us-ascii?Q?YLL0XZSV0HmNmKjYwiK1H8WgW0L/l+B+lL9yyeNQrXonmMOcw/+uq5dFeOOo?=
 =?us-ascii?Q?AOAwO4EdhT1iCCZjIu9Na2r4MQnn8iV945no/WQCLDvmfvYAVBEyldU3tzjN?=
 =?us-ascii?Q?Ou2GBvP04w4SB1MQ9+/LIgBkFb6QBRSRLl25STanXNy8JN0LDunrl4XQ+bH/?=
 =?us-ascii?Q?FbfbjYV+uUioQ4paKErGbR6RSBIfyCAM+/keNKZV1R9ZOT1BYBMqLFSAyiSE?=
 =?us-ascii?Q?5QzXV8l3TIuOrXf4gnYzBsHyfPa6a1VaUDdX/KC6QwCuzyB5k2h2F3xeelXB?=
 =?us-ascii?Q?VEc+gLuvg2tvEvRjaYeAN7dYaDTno1shS1VbhcOC39dw8viQyAeVP39X/dts?=
 =?us-ascii?Q?al2NUm8ySLp1NULr4f4VfcPA7MrIgPA+5gKK64KKTKem0CNq6jkwCTiO3VjP?=
 =?us-ascii?Q?pTjNVmj8kyXHqXZhTsBtjTDr1a+pVDXYxloYprezeDXBLxaKX5kGPYVzROWu?=
 =?us-ascii?Q?sK4H8hQGTpaXtGGVErhFcPHf8upE94BJO4ZaTp64ohOFUMdZHTk3fVEqk586?=
 =?us-ascii?Q?nI77IMs6Gu8KhsPdZOU/hLng7TneWXIcNjn3fS+36ihnHjLHbKycivcCqTkB?=
 =?us-ascii?Q?tDTukwXvbKWlA2QTtxNtv2RQXF8D9TaDd+AcawA6yb5aMXb9uTh0Lq3OmiBs?=
 =?us-ascii?Q?B4ibrj1cIJIUP9p/2QzeU0CD+QvLk2kWYf+rT7P1kvCLvOxtwsVb7J8eUudR?=
 =?us-ascii?Q?i92iMpC7zAZlJHK3CX3EA1iCig016r2UZaWBZJsJmLUviPd3DqL+hAfQak9m?=
 =?us-ascii?Q?genyZn3kLxXpr555JHbq8ISuYRc/n52O7G/02TiIpOgiEuBGNcmFst1Pb5XA?=
 =?us-ascii?Q?koS6I7g3PBYiiyxb91WO6PmHVk53vy8hybfb/jlU9QofpOrcRM0BZNJ27ulK?=
 =?us-ascii?Q?ycRcRVO5proZseU/ngUbr6kMvCLMY5JLABzF8bmHohsAu+dpKzYlrxYFW9/4?=
 =?us-ascii?Q?fQhG8bfACN8L5XvN5AARX1KVksDc9KWHq2p6SNwN3c5I0yBqEpv6/0t8HsgY?=
 =?us-ascii?Q?pGamrVjMfZ2ipsDF4oKN0w+MoCrPPvdfQJp2DvbGgT2SUhDTE/WMn46SL+a6?=
 =?us-ascii?Q?AXXi1xeOdQuOVDzBf2CoRFN8YNe3nf46gxAbBhKDPvzVYvV8ho+JC/2dvQhE?=
 =?us-ascii?Q?AuBIMKWdQ4kW0zX0UKttXtpxRdoGEf5HF4bQSOoB3mCQgl12RcIgYA21+HQe?=
 =?us-ascii?Q?kw7iyRmCFLrizFDT/UhQyB3vswGi0fafyWFGs5uqF11SyiAjWsjy?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: ac2ecdec-ebcf-4b70-7b0c-08dee3c12fa2
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 05:06:40.1560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eM0nPssKfr40TuTqN4qOO8g3A0cS710mO9YJoYX2+OlHxILt/e0HyrHtixP4SSgNW5j8jmWGUTxHGNT5ZV8F1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4P286MB6910

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
Changes in v5:
  - No changes.

 include/linux/pci-epc.h | 46 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index f247cf9bcf1a..8c89cb6d6733 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -65,6 +65,9 @@ struct pci_epc_map {
  * enum pci_epc_aux_resource_type - auxiliary resource type identifiers
  * @PCI_EPC_AUX_DOORBELL_MMIO: Doorbell MMIO, that might be outside the DMA
  *                             controller register window
+ * @PCI_EPC_AUX_DMA_CTRL_MMIO: DMA controller MMIO register window
+ * @PCI_EPC_AUX_DMA_CHAN: Logical DMA channel
+ * @PCI_EPC_AUX_DMA_DESC_MEM: DMA descriptor memory
  *
  * EPC backends may expose auxiliary blocks (e.g. DMA engines) by mapping their
  * register windows and descriptor memories into BAR space. This enum
@@ -72,6 +75,29 @@ struct pci_epc_map {
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
@@ -99,6 +125,26 @@ struct pci_epc_aux_resource {
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


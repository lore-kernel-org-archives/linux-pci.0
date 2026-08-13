Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021111.outbound.protection.outlook.com [52.101.125.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2C741D225;
	Thu, 13 Aug 2026 06:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786603095; cv=fail; b=fVxgW5Cy/4zQzlsjU4Xxg7Y3p1aSC+GEpLCGM7HELQEaXOIlh6GagwIC9R0VYahoFoGAcoYki+SgQoxp6QhhQp1miVq6avCTzzSSEP4HGiqNlGqbNiq0G/Fb+M/q9Zpv+YY0N8P+7qIjBzc7/WVwt6MMY7CDaUpvHboI9GJWrPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786603095; c=relaxed/simple;
	bh=p5OSG/p//RHuQ4CSPjXLatMawl4T+no4dzRdQKb4MaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=smEwKBrq3RYnNkCp5P7AisodgadZN5UkshRabpWxzvG62TODHsFVXxyguGJJorPQbH+w+58NvWSChnCDsTbHr2XEtPSQmFN0yYHnAjteYcAuUM5dlJeRcdpdnjaZrZYQcuAupAMCWcMVMguKuzFLZA8PcFOUzQTmmVZaYxMNGbk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=r+7IjZCI; arc=fail smtp.client-ip=52.101.125.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="r+7IjZCI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cSTM/ZMI4j8xL9mrUp5kraOoOSiIgoxPfDlZzVjkffQMs/YByjC//L9N5/Z+P7ErOqAO3/6bgq8mfnzCpqGf3HXr5Hs4LjI5OVCJzcWYGonK7NHrahIzKhiAXgYCCJV7vikzxmlX01NO1Ll4Cf77W+6s+lZPQuRpO2FszJMr81bcQRa1TZnTgyTXr92uSVPgS36qzfJLR8gfSkf5T3B0q/+F/pgOdhBI8pn+0t1vK5d3VBPiaLIZiOCuZG3i4BH/TXy/3OYXqK19RHNAmNpYcITvpbcxDJ9eRBxa0LLBWfOsiYiv2D2lDWBHXn4JB8ukwvsxsHBWv7sM2zicGHLHTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uw2W595Xc2BgMmEND7Fjf6qCtVBelR0Bdm9CXj1zf50=;
 b=mDxBZgFhIDLnMpSKuW0fZ0KBeIBNn+es1QR7+9vt5oraU7LPbTrlCrR0BYCUgwFWF876sve/CaJVEVoMywsuJG7VzV6mEgCeC25ezmeGHmyzDEzRkD7BjZ86UJPIIcm0XvuGJGfO8sLajtv5BNXsCOckqaGLA6Bcw5Yd5X+Wu53QYGssfvMz8wZRkf9Rq+5iBrYDph/oNUuicxvL1yYW95pBLRr8FUfRxE9YGeDvOJDdYItQNv4ZFR9X7DBYTnrqXAwPScGkcrtcETMh1x6h6QXHmf8BU0ZsC1CV9/Yz/4pqNGFoRFKgDQwPh7TjAuFMDhk6WVSIruwg4pqJtDWYzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uw2W595Xc2BgMmEND7Fjf6qCtVBelR0Bdm9CXj1zf50=;
 b=r+7IjZCIoIoHXpM59r2qC/DpluihyY1m2Ea1cPuIxX0axCCHkuHawZBgJ3gYhEE9HpzTRCj1FfskWFQLbh13w5G7wzAV0EuRRW/aiiT/0rQkPWqVQotLtGhqXs7wYW4mZLYf6Ib+6adKpMcOUufFgfGRxYU5IY5if4jOX/UqaMg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:468::22)
 by TYWP286MB2252.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:13f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 13 Aug
 2026 06:38:06 +0000
Received: from OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
 ([fe80::b7ab:6af2:d18e:4a71]) by OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
 ([fe80::b7ab:6af2:d18e:4a71%6]) with mapi id 15.21.0315.008; Thu, 13 Aug 2026
 06:38:05 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Vinod Koul <vkoul@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org
Subject: [PATCH v7 03/10] PCI: endpoint: Add DMA auxiliary resource metadata
Date: Thu, 13 Aug 2026 15:37:50 +0900
Message-ID: <20260813063757.3131865-4-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260813063757.3131865-1-den@valinux.co.jp>
References: <20260813063757.3131865-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY6P286CA0041.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:3b7::18) To OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:468::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSOP286MB7730:EE_|TYWP286MB2252:EE_
X-MS-Office365-Filtering-Correlation-Id: df4a6962-c982-4030-e71e-08def9056e96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|23010399003|10070799003|18002099003|22082099003|56012099006|6133799003|10067099003|921020;
X-Microsoft-Antispam-Message-Info:
	uJJSsL+Ug68rSbjzPC4fWfiZBnhFO/TWa6JsMUEuEj6TT2cW4LJVPpTh7crzNpSVkZ3RTmwlwS3NKKGVfpv5F4zznlFB94dmg+XyCgFf8zcShej6P9ymTiJC59KZsieq/RHVbUm7sNkeWh0Rl/NCDmNq78czrvtu2L77KdRnbAfs2+kjl/QK0xPzmTK6VtrZs4oWCn9z/LD9TxVjbaGcVGf1fksZimba/zFxOt69j3sTCd1Wj23p1Rt1htjPv2sjMHSkDKey4Ty060R/f1TY0Siyta9QzSRSEGWDs7yUNKS8PhnmgHO7HhRzz6DGsT02I4sSNl8fNXVvcieH1daXC711H5W8xYcZ27kZgX8QS5J3yXeQR13wuwi+PUyUgRDiNN3Pl83OOsIHyTqwIuRBlSLVdl/bflSK3CVCgeLwT6ie2w8cj3Wqqt40E3nwOGnBft9plfR2ni449VrbrjNWyvdd7T655H5qCvReVKR8wSCMV8t4kwSyJYSemJQw/zhTCVffRSlM1BxPbpQCys8HAUHuOLX6zTsVDPDReilgpXPFezaZ0f9wiSPNgCrKcerAg4vvnWejAIIhaQXi7wuEwFqdfkJSj/ginJkBvLIAbnO7OTBS9SaQUa883hrv1cyC1w3N2GHYypHAZQnS6YfxKez2233LIQw4LpVw8lEyF7M2lxNmG5nncqfRuLLamnt4xHDTe+1qMIG4/wT8gkWWag==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(10070799003)(18002099003)(22082099003)(56012099006)(6133799003)(10067099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KI6GMCRQA/UeeCXBYY/Tk2cnu+wck/qs7lndzTMdMbohe+Cg6QD1O3KRM27N?=
 =?us-ascii?Q?VAzz3kdfY0nkgOdk3mMlSvCRojafF7x9xJJO1i1VZg4PE9RVl8vD17dD97G1?=
 =?us-ascii?Q?ze2tERpkaGBn6AZU/IBlbYaXPN1dDAlQGFR5oz5Jtxk1zvvDfldTgvUyrCL0?=
 =?us-ascii?Q?iy03AFi/H7a7IZp4DAwqj5KIF1AKiVEAH8XrICNJgp//HBPrLig5cxLpoacw?=
 =?us-ascii?Q?KUsxpqlrKcGfsdJqUp9U/DwsoaoNqcaUKRqToq5sexiXRMJCSyBMznQHMkRp?=
 =?us-ascii?Q?GSQ25+2ctpIDZfhzh/1R279/PpDMsEW7y5zfnQUxqcimaAmrCn6p7AijSR4x?=
 =?us-ascii?Q?1Mry0B4nexYJbpf9iDta2Yb1jLl5d5tsgHyUhy5xCG9iOaVvhK5h22nJ6EDZ?=
 =?us-ascii?Q?mGQGXprI5dcIrmwF3UPY0U+cxVdtg5jTkkwQipUOh+uD7tQdy6VhyFzpABob?=
 =?us-ascii?Q?B6n6NV2ikW0ndWDdCL92l6FF/0aUYBXgeJ7c/FCR6e8c1tgUI2XsVMdOjEgI?=
 =?us-ascii?Q?SYLh80cfo+TNteTqrqk2RBw0XonOp3GlF8KCLbtOhwCRZBZFLR5Ya/RqZz6M?=
 =?us-ascii?Q?OEiEqHDCRbLJ+2kgmBTU/pKYTg/SIHwdk1pZcH1N0QgcMYfLePAd8mDgZf11?=
 =?us-ascii?Q?h3RgFS1atUPu5/PuhgCOhT5GTghSU+uSn8QzdjGEjWmFK1VkHfK43RITa1HW?=
 =?us-ascii?Q?NKUj8wxX54DPImecpP7oEFYg3nXEVX+RwSUuDPfJC/c7WE0Rx/vX1ioJ34eq?=
 =?us-ascii?Q?avl4SzMPe4TduJxt0r18Z60ETVZK0nD3Ale9xIKUa/8B6ewP/n2UJ45Oa2iU?=
 =?us-ascii?Q?QAVMVCSF0bTC1nVtyODdZj5lYeFhsTs7RQFNgATiXxrH0FvpC1Fo72Gusg71?=
 =?us-ascii?Q?ZpKZebLRpmF2EQMNwZecYnnH65RbQwN9FwlhYrYY4Xd1Yz5CLfYOqc7qRuQQ?=
 =?us-ascii?Q?G/s23s7l8hZNABVp03gnmcjlVSExDtY5DfVdB2zv/PjZ6f2yGnRfhxxDDGlX?=
 =?us-ascii?Q?4Tch4izV/jROPUSQFxxOkNCchxGLyOFC6ew+Sim5MdPfKrh/iGPd9NBuLa4y?=
 =?us-ascii?Q?Ed4yGFT4SmAxVQ4IOCoagc1SC03IevzD9W7tdsWipDfZO+XHxWIK7hRgwX5s?=
 =?us-ascii?Q?Nl6qOIqZtd7ANIAgG1TEBfXT/7mEHZviTbE29M+bar1omOlV4ZyDH5DR+AUO?=
 =?us-ascii?Q?unl2PAK38wYq+0Uhl888k7Ut3t2kp/oNPP9qI3iBMVVVQhr4HEWt21Tvpuzn?=
 =?us-ascii?Q?oJmtgl6ilxnQV3N+QE86gacL/5rPFieMTuEM41bE45vcLtE70la6ABXOzngD?=
 =?us-ascii?Q?BN9hpTlfhRw7Qx6Zl/JG4QhxAJcogxNIv0NQHe1YyDcZRTC1lfWlnR8fLzKe?=
 =?us-ascii?Q?6uX9S/nxSMV00NR1yxBIRWQYZet4K/iKU42vpbMyajpokgFVPyxjYvo7wyHZ?=
 =?us-ascii?Q?58pHwfBNMe966JYCE9tOK6zviE7KlGjzu4Am/yJsBN3qpFXj57mm3LgcrsMQ?=
 =?us-ascii?Q?s9/VXJq0WqdOp377+9/4h1cUwANwZDE5V7ygm5yA4UorRCoZdn+bgKLThCuX?=
 =?us-ascii?Q?87EA9+EMfs0usFWAxqlPMzYeQUaMNEVFYZuyEM+Ug+0if0eEPPUP/AJeCXCf?=
 =?us-ascii?Q?qbFI6Ig8uZDXJq1Pw4tmi4cLz+0ClaYTXkxmpnLdHat0ttS7l4O693o9F+4y?=
 =?us-ascii?Q?gSYQTjMqE+959WmL5IzPmfUqqdGz1chql+LO5HmWaZ8jAf2lcMw5n1IzXpMr?=
 =?us-ascii?Q?fK9HXyCWz0dJKWLTTBsir0lbVP1PKjCmr2INybwHVyJtnOMeqZ4U?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: df4a6962-c982-4030-e71e-08def9056e96
X-MS-Exchange-CrossTenant-AuthSource: OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 06:38:05.9410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mQAkAA73C40O+JWmCcp/vaNYdogdLAMeMAjzz8Vm3P+jvbcZ/iJ+CoMSoPo+pIRWOuhq8BFr+EPwk+SUjl6Pxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2252

Extend EPC auxiliary resource metadata so endpoint functions can
discover controller-owned DMA registers, logical DMA channels, and
descriptor memory.

The DMA metadata is intentionally generic at the EPC layer. A backend
reports the register layout, channel counts, logical channel resources,
and descriptor memory resources. Logical channels carry hardware channel
numbers, identify their corresponding local DMA engine device and static
channel ID, and refer to descriptor memory by ID. Descriptor memory is
identified separately so one memory resource can be shared by multiple
channels.

For DesignWare controllers, reg_layout_data carries the eDMA/HDMA map
format so a consumer can distinguish legacy, unroll, HDMA compatible,
and HDMA native register layouts without making the EPC API itself
DesignWare-specific.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v7:
  - Identify each local DMA engine channel by device and static channel ID,
    per discussion with Frank on v6 patch 4.

@Frank, I haven't picked up your R-b tag because this patch has changed.
Please take another look, thanks.

 include/linux/pci-epc.h | 48 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index f247cf9bcf1a..3b60cf6628e2 100644
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
@@ -99,6 +125,28 @@ struct pci_epc_aux_resource {
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
+			struct device *dma_dev;
+			int chan_id; /* Local dmaengine ID, unique within dma_dev */
+			enum pci_epc_aux_dma_dir dir;
+			u16 hw_ch; /* Direction-local hardware channel exposed to the host */
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


Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021118.outbound.protection.outlook.com [40.107.74.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE803D6CA3;
	Tue,  4 Aug 2026 03:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785814751; cv=fail; b=BWTZ6tj0i3O68r1E+pebTPXZ+yacongqkBHnzK6d9qYr54JqSrGEihWY+21UJqlBnv/6YXZeQ4mAhDyVBlGukNSyXu1KJrK8Bq9eQISQW74++UNy/GpRugewk3PTFcWpqCHZ8fDvjqRA5d6eiJCDihThb1tV04UlsfeXFPfvKZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785814751; c=relaxed/simple;
	bh=4eFJpg8lbh/SUpsXAGJKURp/KuwQcbzGBrWw3m+CMOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z9LyPUOb261wwE57sYc4zpWmlI4+4+oNaEmKxk59RD3v3jSiilaSW5+nPOW96eQmqSkljLvk80DwXNvPUXtpS+5yUXGLHaDc8KKBBx5r/NDRxETMdWAnJmKCxBlmseDmfhAs7ppTbLarZAqi0JSSRvdsIPdBSm6deLezINRLd6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=MtHplQCK; arc=fail smtp.client-ip=40.107.74.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="MtHplQCK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tSPnIh2f18+/JvRvqIxCFu/pWXpOT8d3SQhJ9NRsnffRvAr0z/uSQcBT7eeBVnUXh/VRlv4EMZDOpJJXptBHsPNDSvbWYXj3RuMGwc7r6SCSxbn+xSohU2y7Ts2XZzTsVmj1k1m8+0UsQzioDi1+oniSwL0SE7cBPrIn2QN8Z4h3VGrJsSYufS8kCXCBebKRzorQ9F2iXVBFqBBSSA244ZxgMCecXYiM/uevwBXF1P+6K7kf6lGz1diUO6g2+KnnfV4okzGuxVjpTqafl1HkHRBOaUqkp10HEITKqxeF2h/ex5UGrtuLaJDRy2iaJYRVh4QtYmqR+vQ3VcD+bqWpww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SlBOxN8VDHGjOzp0mnxlPvVl8EGlWMrz+4eZtZUUMWo=;
 b=c1BeUuRvycYIM8P7AzV6LOoUpvNFhpN2n7BEtFL0El8W+Rxiglg4wP+uHkDswcLluAO3bYIbZ2yjMm1QSMClOW0bwXIWh5rzRMbPVp5XZG5crThzkGADsRkimtvR0989QmJG7ZXT3nEBazWe85wPcePw/FOomE9dtHu+qoblGHk65bUiwPfGmaOImyI61yXd1WSlq2mpXAM8GUZdiQPPooWnj4DylRQh0YspiiHJoFScOvM5dgTiI+oNzetWDCvHRo15NEAzQmJ8kmfD7cKkFEZ5gja2t5EvjmCu6twMBfCJWsbAAv/wPgBGAW7+V66RMM22c6Fls1Wv4ZNrOFv5yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SlBOxN8VDHGjOzp0mnxlPvVl8EGlWMrz+4eZtZUUMWo=;
 b=MtHplQCKanHX/rNEB2RgMSgaOjPLZ/zQbuBWj0kX2qn3IaeGg8jDCmoN0BKiQGviFxGAqbLKOGr0oJimgMxiu8hkkNtMtkZJWahjw+rsJVmOIzSi8AmUDuw029Kw+IUrWsNBQasXrxF4PxzgvYI2XqxCgNSsAvaqChdw4Y9L670=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY6P286MB7598.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:347::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 03:39:02 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%3]) with mapi id 15.21.0270.017; Tue, 4 Aug 2026
 03:39:02 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Frank Li <Frank.Li@kernel.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 2/6] PCI: endpoint: Add DMA auxiliary resource metadata
Date: Tue,  4 Aug 2026 12:38:51 +0900
Message-ID: <20260804033855.2115817-3-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260804033855.2115817-1-den@valinux.co.jp>
References: <20260804033855.2115817-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0006.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:26d::7) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY6P286MB7598:EE_
X-MS-Office365-Filtering-Correlation-Id: 8481b0ce-8eb8-4f8e-a404-08def1d9ed0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|376014|1800799024|7416014|366016|56012099006|6133799003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	9I6pWCtO/QjBHRLLGGSQB42o4f9DOh1mg4MT+84M0sBpfP+WKdPORM3U64dbE3CBbda1g0+NdDcKEhQpIG/1iL2vfCvk6HAfkYl7DkGPZWy24OQqHVeeBcdCBmANVu8+hUirHrzj09XyJ0PIW8I452t8Yyew0mXe3UOsb52lEeV3jEpr4YMIvSDt94WymzHZ+kvhkZUCD4bMeu7bpeFKBMN8WJqUAVsKlKBLyF1+lmdnuDw/mXURNmRM3pKQpmFL4qr69R/wS8lomVhr7GItYNbkCKF37E6lFZTiQIoLKPTnPsJFSnOm1Gkw3rjtzMT/57ioCA9lItrESqSVFICZxBh1wSo078CUSHw9QsZLoBPLWlv9K1o8b5L5tL3iyvs3Awp7doM0ACLbVmb3Z3rnI5KPOEF0sMgefA2FSs/Bs067EpO6RPhi62kt8w99EPa2uF+R6cff9zdiNckZdn+Zi6QMdLl70nWm1uWznLJQYRd6SjNug5EQnBAj9X24S7bqK/5VUtpVDoW8Zan+ZA0axuTVlN9LVTJYIX2DCCmVkspNoX9ZykXhSkfpV50kWdrBCLyGnk6DYz3W3FUBKFQ3uD6e1oxj/MNzIHhcbS86VB5bO8+dAZBOhdwDRyUpQ+8D9EnxC7kt04IfN4OvTPqX3DRohz+xTK6OY0vf/QsgUUQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(376014)(1800799024)(7416014)(366016)(56012099006)(6133799003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Xg8A5iqyClpbronZhGhSp5aIZG7NtenU/Gb/bgxkkbRIjah0X3aTsBrTswcN?=
 =?us-ascii?Q?PW2JJmwKJ/0YYKFtIUyaDQVxVay4Owja3FWMp00sbUIi/Un7d7vdiD1pRS3t?=
 =?us-ascii?Q?WZdBgQXkyEkQk45hjXnN3lttO4acqrX2tdyJQF1hp6sgd4DKE2sW10A4r+rF?=
 =?us-ascii?Q?OwFBaXNE6B046DGoL12t5rltNlZhRuxJN52Mx3vgsS8elfrLxZPQYVBmdQYa?=
 =?us-ascii?Q?om0szYwCuOw+UzgW94MMKeMc/8BrVT+5eBGZczUpqH8jxjY/efkB0GvY38VL?=
 =?us-ascii?Q?NvsYGeY+6Xzi5rVFQC3DcKbJ1eaVehxLaOgSrl6x+6xhrUJ31XNkkaUOYXyl?=
 =?us-ascii?Q?yeI4zKry/pwRinmt3fYBwJ8CLs5e3Rb5DS6RVQ1+c1OUPYjVpOVKaroWhi+7?=
 =?us-ascii?Q?Akb1kn4EmpNzG+a1ePqKkknYYixkNg+YW2rsCEH0GFj8yQXSHNQgMp6s8NRJ?=
 =?us-ascii?Q?7lFdv5Y9feCAYRGHwQPzTVOV9lSy0Rs5xGgLVTVAwQcMevDmd9kpFerxetvW?=
 =?us-ascii?Q?gxerw2aOoBbVkwbK03dESpR/UdRNSRfUMwyqaxdYTa15/AZjKFsZz0yNhf1U?=
 =?us-ascii?Q?JWfkh06rN7cG69jS8toNTRWbsEW9vbtgkQkTlMaaaa0qR+liIHLC2v43eyf8?=
 =?us-ascii?Q?g9mcN1m817OojMcmbuAd6NjkPPCKWoAlhtGIr/lueVPl6h4Tm74a9VpH7NRM?=
 =?us-ascii?Q?JiBIZk0RB4s8tvN1iyHUA5PRUwvEwdkWY1mdoFlUDTPhnz61fTehIJ98S++p?=
 =?us-ascii?Q?DF3vx6cDEJS210cXAlHnEg+Gj2Tb5B/vLylgLpihJTdI4qfpM4u+xRxetXDn?=
 =?us-ascii?Q?AYRPmtUh/r9YpQhDyJYLzjAkFfQKV53HlENaLiBjEwa/q9Ca7La7gQLO2S5G?=
 =?us-ascii?Q?/gwV/+wZ/lDaOuzNOEJ8Pi9aePd4/cAqGoa7x9OxX25J8jHqB6ltn3rI636Y?=
 =?us-ascii?Q?5g6HK6FoRg7kvQ9HiDa6BxMEl/F1NqG5cWAmJ/V3fCBngh/3ugr4KtUDHApu?=
 =?us-ascii?Q?iNShTZ1cx/srTvJUblf90LNeKGTEepu8QMEj/TaZ8iBf9aYLgpUuxEYRXGPQ?=
 =?us-ascii?Q?6+cG52FR4d7YdpjiYJI1I8tQLhL9BTMm06Yrpk1DvTkVI4pGlsdSzblL1DPd?=
 =?us-ascii?Q?KlnZUKeXozyFcbzFT15eZ/ZUyRtmEeR2lCIWKPn3I/K+hXKo6tOYqW2cs00K?=
 =?us-ascii?Q?pf8g+mdVbFHONgdbymyjrX08ZznSLlnVdb48kY9e2vO7Dyx3I4dwNVKDtTT1?=
 =?us-ascii?Q?lOmhGWpqm81cosTHZvXK3RE4rqWVnmOhu7v+XmNrv+vxKL37Kf9dcEJeyIkV?=
 =?us-ascii?Q?gQPFPuFJxP7n5S126eKzCbBBF3FCzsXFSQndpWYfFhwuYjiRKHiKfX5c9e7Y?=
 =?us-ascii?Q?nHi6+71Co1KvfV3/ZRUQvMmtMlcKNZZY+iCtIj6+04I7tTm9uMz3qPZXPjwU?=
 =?us-ascii?Q?TxcgPuRFFUGguBV/7fKrlufjFl8/QA7Ef5kIrVOb+vFMnL2I42+NdadFE2ky?=
 =?us-ascii?Q?Nd6LAoB5w1TH8DCKhlE9pPOKAOhoApsBiGMpKdsV7T0pwB/0jbalvO3FgQhB?=
 =?us-ascii?Q?KSydbmPfOx8kQnzYuy6F/CyRvZfDRG2sOV0cI0+8s2Z475I6MJByJNEQSt49?=
 =?us-ascii?Q?054geg88Yf1uhLaDVtKHxKN6U+105lpAKtZ7enmx4GL6tQunnKTwpxFWV33l?=
 =?us-ascii?Q?H0KeZkdnjcwmHqi/jlM+uwhCT7H3MyapO8NQdjQq9LP6bE6IIAI35OA+qwFE?=
 =?us-ascii?Q?7Df9/UqNvZ5aj/VZgVc5XHQnKluX9hOkpUIQc9b+ag6mZ+ylgEJb?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 8481b0ce-8eb8-4f8e-a404-08def1d9ed0e
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 03:39:02.1825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZSpItSG4qLd3XnSt0nI46DZjD48XAQZO4IgAAsKcmp86HImaNaxYAOV8cavdwkuNIVO2TME7MTIjdyQGeIuaSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY6P286MB7598

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
Changes in v6:
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


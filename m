Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021111.outbound.protection.outlook.com [52.101.125.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E747E41F5CC;
	Thu, 13 Aug 2026 06:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786603100; cv=fail; b=je+7mFe3058iOX5txHAnA7D6fWzf2jZR/zrRH6UEbOY/MYbS1nd643mhtoaYEuo28t9Y6oP60csRB4feAU2K89w2Mqk8AGgiVLexOJGLjElypfTayPElJdfCOnIKGwmgdh4aWn/1OXTiRn0Bm4F6PXkNiN26bj664mhX2IxkTiI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786603100; c=relaxed/simple;
	bh=Uvxydgo5CHqLISDgmsubv6eWdjBqj+otqOF5WH/s/0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kgbR2exKp8oATsokQtob70gMVoRAlaxekdGJsfmQHolw/oTpUNWbednpe8XIzs4nDTinWJwSjXnsPJtT2mWM8NzZ48aJMmdXpX0OWzIRLM0LKig/WYtcVAF1MtOj8tR9N51tnYEMLCJYlVkrys2kFPPf4XPL5ZXXfvNyzBA0K7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=OZwiF2i3; arc=fail smtp.client-ip=52.101.125.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="OZwiF2i3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZmFaJaORdSeZJAvsU1JwFoVwYEhRs47zkYZs77jH+Aa/RzAwY7jn37wwnTxZZBrpaWumrSRIYA7stJg5hhEDkjif1VjF9Bc+FDiJxY2dvyapvDkQHMuqH7hT3oNjdv4rOTKh4Ax80Jv5txidJCj9BuubaibmO81Zjstj1DK7zY9rzSRMBBnSClmh5aj0yzykvIDAPu9Td8CgAP1h2DIXkdvRsO2QYutEOm6qJRIo5AcxAHZ4ip8YbMRvLgPbXkttIlzagJYQJD3bBbGGcVm3Fv/JC3pcSTb7MAQFqPt0IzTs5ZD4bm0iXyqVcgviwFwl6rv/VDGAyc4BSuWjQ5gnGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l593TffCqnFSKBHx6vIz+RXSRFYEQ6JZtW3JuTUA3WE=;
 b=XI1vBOSWBuNu1Ucu8wlnl5ewacTWWadgk1v13GSXaOkOcfPKTZkphzNO8Pri1mxJLDWrtcwbNxye/kyfrzJoQ0DYCd/cFp5+l4MfYkzNehl/Am2Gh8lWz472IJC5Zmnr8hDDvMFjTpxZD9iVt00HYQ/moOivH3oB42GD6cae7zOdSW5Xcj5KucuKHhvG1sVBVKkZiW9EyjlE6vjJEuTaRhxa1qZtifPOouKUFbVLCNFyEscn5/pAUFh5LZEOFga+8tpq/Nwb425TXsz/+U3rqpydV8ex62TQs8h5QrNKYWFSnlHMyg9H79msNYOI6UXEFir5wRU6MXU+93qPCtH+zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l593TffCqnFSKBHx6vIz+RXSRFYEQ6JZtW3JuTUA3WE=;
 b=OZwiF2i3VyFEWhmvdhQhGNGCV949KtHo9iUZENUouTj8Bzjfm+eMr2mpQSTTF7QlUjlDF5GmVNl7Xjmt7kf+09N7AW0NJ7w/RPB4k6Dgtj0q4tNPncuxNNrBXw/Gz7Uvfh7InkwKspd0eAuJbbfynmO7h7wW43dK3/K5Dt6Ydk4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:468::22)
 by TYWP286MB2252.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:13f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 13 Aug
 2026 06:38:10 +0000
Received: from OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
 ([fe80::b7ab:6af2:d18e:4a71]) by OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
 ([fe80::b7ab:6af2:d18e:4a71%6]) with mapi id 15.21.0315.008; Thu, 13 Aug 2026
 06:38:10 +0000
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
Subject: [PATCH v7 08/10] dmaengine: dw-edma-pcie: Discover endpoint DMA metadata
Date: Thu, 13 Aug 2026 15:37:55 +0900
Message-ID: <20260813063757.3131865-9-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260813063757.3131865-1-den@valinux.co.jp>
References: <20260813063757.3131865-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY6P286CA0042.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:3b7::13) To OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:468::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSOP286MB7730:EE_|TYWP286MB2252:EE_
X-MS-Office365-Filtering-Correlation-Id: 6992c62f-9933-4315-a562-08def9057186
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|23010399003|10070799003|18002099003|22082099003|56012099006|3023799007|10067099003|921020;
X-Microsoft-Antispam-Message-Info:
	ajAlRCG4kASsLS2Q2rPy1xdsHEFwGtBlXRg7pJTNAuHu2O12tignnEVb5JahvQq54SQoRC0WbU45BOd50/vCYhghnFXZ1p3MC+JxTTa47CU97JP8KPbrnWgGimP1jKvqEqh6YRgaLnxXUDzFJ97M/ShCmFAUPURXoWwbwG3xf6VdPP4W3XlOOJPvmKz56wFv9EI5JE7SkwdLROg+lAuDvoEuRRWeQfKpBS1uVTXCQZ4ApaVWZGwO1xxNEVD9HqhZVbt8q4VF2+elmyccBHVG603E4K4H/WbQKWbGpG6uWc2Nc4KJoIQPibLtTAfwiapsQ+k3ySxfccIQNxBTxAX0Ve02KMjCv7R916bYd2h/ksfzmWN3Wc93oq0gEJjxROatz5lGdGbNDM9yzyPpSwCbS1PBuysvxoYoVFjSDExG02pCebhJuqzg6z1tchfqt7KfFALkvHLryXywf3AA9+P8OG347mRWFhaLMTUWs/RlD4w/f4+18rdGz/JmzEUFgUHneElbmNZNitkvXpITiquYBu/o9+MZtsn3lsq3INJLTOgo834b9TRuNIY5hFvfjJO7YmDNcJSOKd8cmSdbrPIFAbtCparHMijWaB1UekEflGV05NiSpGEcba9jjUhzur2y0JK4Nz1fhvRYNeu4P01nas8GExAjChvXgnGpNgopfnGbq1Wp8Uu6HLLJsgabv8Cu5jUlb8yOz3dS6mNNcGQANg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(10070799003)(18002099003)(22082099003)(56012099006)(3023799007)(10067099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Fyt0zZrY8uOE31tpeeLCdhBTdb2epQo2nZ7HU5qAHT2ga4hLXE8PU9+Qr/7l?=
 =?us-ascii?Q?m8Cz8JUJQar4hUz7pqVbZSPZ3fwN3Vjd1mWKpVZYQdavmK6isQ5bPfiKOJJK?=
 =?us-ascii?Q?QiWJc2KzVskuX86jQMyLlRUTo9xoO+X9XeHlKFo52TWv6gDAX418timEQKRm?=
 =?us-ascii?Q?0vye6RrlZzqU8qs62jFn4rdns2l1SXCufB/bcMAdPPRHTSmWoBwYrkQm/P4d?=
 =?us-ascii?Q?PjsclJ9RVGucM0EfpE5yO+ESVUjAYFFkqBPZX02ZV4OvwAfS/llDbcL+NuWV?=
 =?us-ascii?Q?kdM5nAqDMnghjGYSO0MAH9qDqqFXbiy9ctRy2PtBvGlpsuLuu4L3QeukhVpE?=
 =?us-ascii?Q?aNJ5Tv7v+1wPqWe245K7eXpZwuU788HjxxJuUeY6IpFI2e2Z8rk9gUiVyMOt?=
 =?us-ascii?Q?dcmjXXAUaTZ8CUGmhFV0S1GcbmTYq1KNgMFQD+9F4vHqi+ppd5Ck//5BZLD4?=
 =?us-ascii?Q?os+WVsv4QBkBcCgdcIb+RUo5HJQoYEQ3gsbqqn+kEg3IFcbsF2pbOtH32Ykp?=
 =?us-ascii?Q?ROO+4V093TkMVLYjkda1YHEQlu7UE3uiTaepQv4zBAOga3IFqMUHkDYYgvpW?=
 =?us-ascii?Q?Ry9qiAjO9DeUUVETHbKJ4l6IWqm+5OIKfFXtplhkQot5XpyE1N3UOAwGKpVf?=
 =?us-ascii?Q?GLp4O3LPjPEN1MtS0U40xYYzX3F0g6VxDJJuNPgC/JkpaEIxRZK9yyjV+OlF?=
 =?us-ascii?Q?d0LpXAgDfCPjcT5ZvQYfsQwLhPQfbC1gGwW6BS6eAJj96QEXy9y5rUzyHCPM?=
 =?us-ascii?Q?rAf3BeFg95ERFkWBDIXcF53/EiLUi5CqwNQm89t/TWKLHW10NzreOf46+nGv?=
 =?us-ascii?Q?US88wkbifB7yb1K2Cx3EGeh+tgV/v+SMZBMF0yPTxEO+OYH+wuqrfK1cOxPO?=
 =?us-ascii?Q?4IuTvobNdds+AtuTAOvCIfbPi0zIbDrYXJXFaU2riN8g5sCj9FcifuVS41am?=
 =?us-ascii?Q?3JEdSTdg1XJrDHEwzYlH51TsIEyYOxr1JkjFyYqqq95wBlOt4bcmj+U4c5Ej?=
 =?us-ascii?Q?7bZZGlRHz7vDikWISqv60CgfEPLOuXG1oEHnCEGntyS0F+20gNq7OlGnY/Da?=
 =?us-ascii?Q?5moS6zkfJuBr6rYi5y2e7HhiOM/LM1aPkP7FOckvfu0eXKnkVMmymtpBShPS?=
 =?us-ascii?Q?0IxwTEEZWmjUZABGs/LLrhzGef/0TjZ3Na5oY1rYT+7YBfWDYLU36wuKgXkV?=
 =?us-ascii?Q?CyrgJCyRA2tWxGN4rHqilhKsVYeVKac6KUZ8QSR/R0/rdPwObStgMykYI2QA?=
 =?us-ascii?Q?/jIl8q8Tcap+M2M3/aRrPsgjm5H0MKcAiMppU8K0u/rfw+Xjz39FMS+RZijP?=
 =?us-ascii?Q?q9Ah80O8jzy7RPRzmxCpxR5svQM3vqEsxNdF9CiIyzdcEEZJeDKFYZ2XyQUb?=
 =?us-ascii?Q?vNNIbdA4ixOIInAEux8HHMBLbl25iDuZRYlVcJQdx8rO0GbTKKlW0fhriI4i?=
 =?us-ascii?Q?/quwDwJcgWbGcAFxL5lfr0LSwAIWxDk7OrM0TAC4ZrCXK5+yYiETOwZEbaMA?=
 =?us-ascii?Q?IAD42sjlNo4IwBx9HsHlDtqyLPPu2MAIBUuEh5pdaXq/5/dSQNgEOroaV7Wn?=
 =?us-ascii?Q?P8gKzC6HaxsZY1/Xn34WgKMtSF4GE9xK5TNRapRf6wkC7phGdJ1Ka7hP5N39?=
 =?us-ascii?Q?Q3+BTOVgbcysEzaQifeyYC0Tu21M4iqDy41d5NlatRHFnVeotdQktILkzp6H?=
 =?us-ascii?Q?ddaYpSisV4EtaybAOaYTLbs7BFiOURbTYfNc1S7/W7SBN/SxvmOoIVzNaODW?=
 =?us-ascii?Q?wAbVH5p7DG+XgrU8e1ufqJUrDxCtRzOndtdzutokq3o9RNvmKbZ3?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 6992c62f-9933-4315-a562-08def9057186
X-MS-Exchange-CrossTenant-AuthSource: OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 06:38:10.8681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IBuJAIdw/sRvkTotK4S+cjzayUsyhII1D+43I1Msnx3pceeWd6mmhaLakcqqCqaJJMMeW90nLXfRiFDGPCCyQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2252

Teach dw-edma-pcie to discover a PCI endpoint DMA function from
BAR-resident metadata. The metadata supplies the DMA register window,
channel counts, descriptor windows, optional auxiliary windows, and
endpoint-local descriptor and auxiliary addresses. Accept DesignWare
eDMA unroll, HDMA compatible, and HDMA native linked-list layouts.

Endpoint-provided DMA channels use raw slave addresses because the host
programs transfers against endpoint physical addresses, not PCI BAR
addresses. The host-side dw-edma-pcie instance is remote-routed by
default, so delegated channels report completions through IMWr/MSI.

Endpoint DMA metadata currently has no static PCI ID. Let an explicit
driver_override bind use the generic endpoint DMA metadata parser, but
do not treat arbitrary dynamic IDs without driver data as endpoint DMA
devices.

The endpoint polls HOST_REQ at a low idle rate before programming DMA
window submaps and setting READY. Let the host wait for several endpoint
poll periods before treating the READY handshake as timed out.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v7:
  - Write HOST_REQ through the dedicated host-request word introduced in
    patch 2.

Note: This patch was previously posted as part of the separate part 3
series. No v6 of that series was sent.

 drivers/dma/dw-edma/dw-edma-pcie.c | 394 ++++++++++++++++++++++++++++-
 1 file changed, 392 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index 9f237ba916de..bd5ed543fe98 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -11,9 +11,13 @@
 #include <linux/pci.h>
 #include <linux/device.h>
 #include <linux/dma/edma.h>
+#include <linux/iopoll.h>
 #include <linux/pci-epf.h>
 #include <linux/msi.h>
 #include <linux/bitfield.h>
+#include <linux/io.h>
+#include <linux/overflow.h>
+#include <linux/pci-ep-dma.h>
 #include <linux/sizes.h>
 
 #include "dw-edma-core.h"
@@ -45,6 +49,9 @@
 #define DW_PCIE_XILINX_MDB_DT_OFF_GAP		0x100000
 #define DW_PCIE_XILINX_MDB_DT_SIZE		0x800
 
+#define DW_PCIE_EP_DMA_READY_POLL_US		1000
+#define DW_PCIE_EP_DMA_READY_TIMEOUT_US		2000000
+
 #define DW_BLOCK(a, b, c) \
 	{ \
 		.bar = a, \
@@ -94,6 +101,12 @@ struct dw_edma_pcie_match_data {
 #define DW_EDMA_PCIE_F_DEVMEM_PHYS_OFF	BIT(0)
 #define DW_EDMA_PCIE_F_REG_OFFSET	BIT(1)
 
+struct dw_edma_pcie_ep_dma_view {
+	struct pci_dev *pdev;
+	void __iomem *base;
+	resource_size_t limit;
+};
+
 static const struct dw_edma_pcie_data snps_edda_data = {
 	/* eDMA registers location */
 	.rg.bar				= BAR_0,
@@ -158,6 +171,13 @@ static const struct dw_edma_pcie_data xilinx_cpm6_dma_data = {
 	.rd_ch_cnt			= 8,
 };
 
+static const struct dw_edma_pcie_data ep_dma_data = {
+	.mf				= EDMA_MF_EDMA_UNROLL,
+	.irqs				= EDMA_MAX_WR_CH + EDMA_MAX_RD_CH,
+	.wr_ch_cnt			= EDMA_MAX_WR_CH,
+	.rd_ch_cnt			= EDMA_MAX_RD_CH,
+};
+
 static void dw_edma_set_chan_region_offset(struct dw_edma_pcie_data *pdata,
 					   enum pci_barno bar, off_t start_off,
 					   off_t ll_off_gap, size_t ll_size,
@@ -227,6 +247,92 @@ static const struct dw_edma_plat_ops dw_edma_pcie_plat_ops = {
 	.pci_address = dw_edma_pcie_address,
 };
 
+static const struct dw_edma_plat_ops dw_edma_pcie_raw_addr_plat_ops = {
+	.irq_vector = dw_edma_pcie_irq_vector,
+};
+
+static bool dw_edma_pcie_valid_bar(enum pci_barno bar)
+{
+	return bar >= BAR_0 && bar <= BAR_5;
+}
+
+static bool dw_edma_pcie_valid_bar_range(struct pci_dev *pdev,
+					 enum pci_barno bar, u64 off,
+					 size_t sz)
+{
+	resource_size_t bar_len;
+
+	if (!dw_edma_pcie_valid_bar(bar) || !sz)
+		return false;
+
+	bar_len = pci_resource_len(pdev, bar);
+
+	return off <= bar_len && sz <= bar_len - off;
+}
+
+static bool dw_edma_pcie_valid_block(struct pci_dev *pdev,
+				     const struct dw_edma_block *block)
+{
+	return dw_edma_pcie_valid_bar_range(pdev, block->bar, block->off,
+					    block->sz);
+}
+
+static bool dw_edma_pcie_ep_dma_bar_scannable(struct pci_dev *pdev,
+					      enum pci_barno bar)
+{
+	unsigned long flags = pci_resource_flags(pdev, bar);
+
+	if (!(flags & IORESOURCE_MEM))
+		return false;
+
+	if (flags & (IORESOURCE_UNSET | IORESOURCE_DISABLED))
+		return false;
+
+	return pci_resource_len(pdev, bar) >= PCI_EP_DMA_METADATA_HDR_LEN;
+}
+
+static u32 dw_edma_pcie_ep_dma_readl(struct dw_edma_pcie_ep_dma_view *view,
+				     u16 off)
+{
+	return readl(view->base + off);
+}
+
+static void dw_edma_pcie_ep_dma_writel(struct dw_edma_pcie_ep_dma_view *view,
+				       u16 off, u32 val)
+{
+	writel(val, view->base + off);
+}
+
+static void
+dw_edma_pcie_ep_dma_clear_host_req(struct dw_edma_pcie_ep_dma_view *view)
+{
+	dw_edma_pcie_ep_dma_writel(view, PCI_EP_DMA_METADATA_HOST_CTRL, 0);
+}
+
+static u64 dw_edma_pcie_ep_dma_read64(struct dw_edma_pcie_ep_dma_view *view,
+				      u16 lo, u16 hi)
+{
+	u64 val;
+
+	val = dw_edma_pcie_ep_dma_readl(view, hi);
+
+	return (val << 32) | dw_edma_pcie_ep_dma_readl(view, lo);
+}
+
+static int dw_edma_pcie_ep_dma_read_off(struct dw_edma_pcie_ep_dma_view *view,
+					u16 lo, u16 hi, off_t *off)
+{
+	u64 val;
+
+	val = dw_edma_pcie_ep_dma_read64(view, lo, hi);
+	if (val > type_max(*off))
+		return -EINVAL;
+
+	*off = val;
+
+	return 0;
+}
+
 static void dw_edma_pcie_get_synopsys_dma_data(struct pci_dev *pdev,
 					       struct dw_edma_pcie_data *pdata)
 {
@@ -328,6 +434,270 @@ static void dw_edma_pcie_get_xilinx_dma_data(struct pci_dev *pdev,
 	pdata->devmem_phys_off = off;
 }
 
+static int
+dw_edma_pcie_parse_ep_dma_ch_table(struct dw_edma_pcie_ep_dma_view *view,
+				   struct dw_edma_pcie_data *pdata,
+				   u16 table_off, u16 entry_size, u16 ch_cnt,
+				   bool write)
+{
+	struct dw_edma_block *desc_blocks = write ? pdata->ll_wr : pdata->ll_rd;
+	struct dw_edma_block *data_blocks = write ? pdata->dt_wr : pdata->dt_rd;
+	u32 ctrl;
+	u16 i;
+	int ret;
+
+	for (i = 0; i < ch_cnt; i++) {
+		struct dw_edma_block *desc_block = &desc_blocks[i];
+		struct dw_edma_block *data_block = &data_blocks[i];
+		u16 off = table_off + i * entry_size;
+		u16 field, lo, hi;
+
+		field = off + PCI_EP_DMA_METADATA_CH_CTRL;
+		ctrl = dw_edma_pcie_ep_dma_readl(view, field);
+		if (FIELD_GET(PCI_EP_DMA_METADATA_CH_CTRL_HW_CH, ctrl) != i)
+			return -EOPNOTSUPP;
+
+		desc_block->bar =
+			FIELD_GET(PCI_EP_DMA_METADATA_CH_CTRL_DESC_BAR, ctrl);
+		lo = off + PCI_EP_DMA_METADATA_CH_DESC_OFF_LO;
+		hi = off + PCI_EP_DMA_METADATA_CH_DESC_OFF_HI;
+		ret = dw_edma_pcie_ep_dma_read_off(view, lo, hi,
+						   &desc_block->off);
+		if (ret)
+			return ret;
+		field = off + PCI_EP_DMA_METADATA_CH_DESC_SIZE;
+		desc_block->sz = dw_edma_pcie_ep_dma_readl(view, field);
+		lo = off + PCI_EP_DMA_METADATA_CH_DESC_ADDR_LO;
+		hi = off + PCI_EP_DMA_METADATA_CH_DESC_ADDR_HI;
+		desc_block->paddr =
+			dw_edma_pcie_ep_dma_read64(view, lo, hi);
+		desc_block->paddr_valid = true;
+		if (!dw_edma_pcie_valid_block(view->pdev, desc_block))
+			return -EINVAL;
+
+		*data_block = (struct dw_edma_block) { .bar = NO_BAR };
+		if (!(ctrl & PCI_EP_DMA_METADATA_CH_CTRL_AUX_VALID))
+			continue;
+
+		data_block->bar =
+			FIELD_GET(PCI_EP_DMA_METADATA_CH_CTRL_AUX_BAR, ctrl);
+		lo = off + PCI_EP_DMA_METADATA_CH_AUX_OFF_LO;
+		hi = off + PCI_EP_DMA_METADATA_CH_AUX_OFF_HI;
+		ret = dw_edma_pcie_ep_dma_read_off(view, lo, hi,
+						   &data_block->off);
+		if (ret)
+			return ret;
+		field = off + PCI_EP_DMA_METADATA_CH_AUX_SIZE;
+		data_block->sz = dw_edma_pcie_ep_dma_readl(view, field);
+		lo = off + PCI_EP_DMA_METADATA_CH_AUX_ADDR_LO;
+		hi = off + PCI_EP_DMA_METADATA_CH_AUX_ADDR_HI;
+		data_block->paddr =
+			dw_edma_pcie_ep_dma_read64(view, lo, hi);
+		data_block->paddr_valid = true;
+		if (!dw_edma_pcie_valid_block(view->pdev, data_block))
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int
+dw_edma_pcie_ep_dma_wait_ready(struct dw_edma_pcie_ep_dma_view *view)
+{
+	u32 val;
+
+	/*
+	 * The host cannot build a usable eDMA instance until the endpoint has
+	 * pinned and published the channel submaps, so keep the handshake
+	 * synchronous and bounded during probe.
+	 */
+	return read_poll_timeout(dw_edma_pcie_ep_dma_readl, val,
+				 val & PCI_EP_DMA_METADATA_CTRL_READY,
+				 DW_PCIE_EP_DMA_READY_POLL_US,
+				 DW_PCIE_EP_DMA_READY_TIMEOUT_US, false,
+				 view, PCI_EP_DMA_METADATA_CTRL);
+}
+
+static int
+dw_edma_pcie_validate_ep_dma_metadata(struct dw_edma_pcie_ep_dma_view *view,
+				      u32 *metadata_ctrl, u8 *reg_layout_data)
+{
+	size_t table_size, table_end;
+	enum pci_barno reg_bar;
+	u16 len, entry_size;
+	u16 wr_ch_cnt, rd_ch_cnt;
+	u8 layout, layout_data;
+	u32 val;
+
+	val = dw_edma_pcie_ep_dma_readl(view, 0);
+	if (val != PCI_EP_DMA_METADATA_MAGIC)
+		return -ENODEV;
+
+	val = dw_edma_pcie_ep_dma_readl(view, PCI_EP_DMA_METADATA_HDR);
+	if (FIELD_GET(PCI_EP_DMA_METADATA_HDR_REV, val) !=
+	    PCI_EP_DMA_METADATA_REV)
+		return -EINVAL;
+
+	len = FIELD_GET(PCI_EP_DMA_METADATA_HDR_LEN_FIELD, val);
+	if (len < PCI_EP_DMA_METADATA_HDR_LEN)
+		return -EINVAL;
+	if (len > view->limit)
+		return -EINVAL;
+
+	val = dw_edma_pcie_ep_dma_readl(view, PCI_EP_DMA_METADATA_REG_LAYOUT);
+	layout = FIELD_GET(PCI_EP_DMA_METADATA_REG_LAYOUT_ID, val);
+	if (layout != PCI_EP_DMA_METADATA_REG_LAYOUT_DW_EDMA)
+		return -EOPNOTSUPP;
+
+	layout_data = FIELD_GET(PCI_EP_DMA_METADATA_REG_LAYOUT_DATA, val);
+	if (layout_data == EDMA_MF_EDMA_LEGACY)
+		return -EOPNOTSUPP;
+	if (layout_data != EDMA_MF_EDMA_UNROLL &&
+	    layout_data != EDMA_MF_HDMA_COMPAT &&
+	    layout_data != EDMA_MF_HDMA_NATIVE)
+		return -EINVAL;
+
+	val = dw_edma_pcie_ep_dma_readl(view, PCI_EP_DMA_METADATA_CTRL);
+	reg_bar = FIELD_GET(PCI_EP_DMA_METADATA_CTRL_REG_BAR, val);
+	if (!dw_edma_pcie_valid_bar(reg_bar))
+		return -EINVAL;
+
+	wr_ch_cnt = FIELD_GET(PCI_EP_DMA_METADATA_CTRL_WR_CH_COUNT, val);
+	rd_ch_cnt = FIELD_GET(PCI_EP_DMA_METADATA_CTRL_RD_CH_COUNT, val);
+	if (!wr_ch_cnt && !rd_ch_cnt)
+		return -EINVAL;
+	if (wr_ch_cnt > EDMA_MAX_WR_CH || rd_ch_cnt > EDMA_MAX_RD_CH)
+		return -EINVAL;
+
+	entry_size = FIELD_GET(PCI_EP_DMA_METADATA_CTRL_CH_ENTRY_SIZE, val);
+	if (entry_size < PCI_EP_DMA_METADATA_CH_ENTRY_SIZE ||
+	    entry_size % sizeof(u32))
+		return -EINVAL;
+
+	if (check_mul_overflow((size_t)(wr_ch_cnt + rd_ch_cnt),
+			       (size_t)entry_size, &table_size) ||
+	    check_add_overflow((size_t)PCI_EP_DMA_METADATA_HDR_LEN,
+			       table_size, &table_end) ||
+	    table_end > len)
+		return -EINVAL;
+
+	if (metadata_ctrl)
+		*metadata_ctrl = val;
+	if (reg_layout_data)
+		*reg_layout_data = layout_data;
+
+	return 0;
+}
+
+static int
+dw_edma_pcie_parse_ep_dma_data(struct dw_edma_pcie_ep_dma_view *view,
+			       struct dw_edma_pcie_data *pdata)
+{
+	u32 ctrl, reg_sz;
+	u8 reg_layout_data;
+	u64 reg_off;
+	u16 wr_table, rd_table, entry_size;
+	u16 wr_ch_cnt, rd_ch_cnt;
+	int ret;
+
+	ret = dw_edma_pcie_validate_ep_dma_metadata(view, &ctrl,
+						    &reg_layout_data);
+	if (ret)
+		return ret;
+
+	pci_dbg(view->pdev, "Detected PCI endpoint DMA BAR metadata\n");
+
+	pdata->mf = reg_layout_data;
+	pdata->rg.bar = FIELD_GET(PCI_EP_DMA_METADATA_CTRL_REG_BAR, ctrl);
+
+	wr_ch_cnt = FIELD_GET(PCI_EP_DMA_METADATA_CTRL_WR_CH_COUNT, ctrl);
+	rd_ch_cnt = FIELD_GET(PCI_EP_DMA_METADATA_CTRL_RD_CH_COUNT, ctrl);
+	pdata->wr_ch_cnt = min_t(u16, pdata->wr_ch_cnt, wr_ch_cnt);
+	pdata->rd_ch_cnt = min_t(u16, pdata->rd_ch_cnt, rd_ch_cnt);
+	pdata->irqs = pdata->wr_ch_cnt + pdata->rd_ch_cnt;
+	reg_off = dw_edma_pcie_ep_dma_read64(view,
+					     PCI_EP_DMA_METADATA_REG_OFF_LO,
+					     PCI_EP_DMA_METADATA_REG_OFF_HI);
+	reg_sz = dw_edma_pcie_ep_dma_readl(view, PCI_EP_DMA_METADATA_REG_SIZE);
+	if (reg_off > type_max(pdata->rg.off) ||
+	    !dw_edma_pcie_valid_bar_range(view->pdev, pdata->rg.bar,
+					  reg_off, reg_sz))
+		return -EINVAL;
+	pdata->rg.off = reg_off;
+	pdata->rg.sz = reg_sz;
+
+	entry_size = FIELD_GET(PCI_EP_DMA_METADATA_CTRL_CH_ENTRY_SIZE, ctrl);
+	wr_table = PCI_EP_DMA_METADATA_HDR_LEN;
+	rd_table = PCI_EP_DMA_METADATA_HDR_LEN + wr_ch_cnt * entry_size;
+
+	ret = dw_edma_pcie_parse_ep_dma_ch_table(view, pdata, wr_table,
+						 entry_size, pdata->wr_ch_cnt,
+						 true);
+	if (ret)
+		return ret;
+
+	return dw_edma_pcie_parse_ep_dma_ch_table(view, pdata, rd_table,
+						  entry_size,
+						  pdata->rd_ch_cnt, false);
+}
+
+static int
+dw_edma_pcie_parse_ep_dma_caps(struct pci_dev *pdev,
+			       struct dw_edma_pcie_data *pdata)
+{
+	struct dw_edma_pcie_ep_dma_view metadata_view;
+	void __iomem *base;
+	resource_size_t bar_len;
+	enum pci_barno bar;
+	int ret;
+
+	for (bar = BAR_0; bar < PCI_STD_NUM_BARS; bar++) {
+		if (!dw_edma_pcie_ep_dma_bar_scannable(pdev, bar))
+			continue;
+
+		bar_len = pci_resource_len(pdev, bar);
+		base = pci_iomap_range(pdev, bar, 0, 0);
+		if (!base)
+			continue;
+
+		metadata_view = (struct dw_edma_pcie_ep_dma_view) {
+			.pdev = pdev,
+			.base = base,
+			.limit = bar_len,
+		};
+		ret = dw_edma_pcie_validate_ep_dma_metadata(&metadata_view,
+							    NULL, NULL);
+		if (ret == -ENODEV) {
+			pci_iounmap(metadata_view.pdev, base);
+			continue;
+		}
+		if (ret) {
+			pci_iounmap(metadata_view.pdev, base);
+			return ret;
+		}
+
+		dw_edma_pcie_ep_dma_writel(&metadata_view,
+					   PCI_EP_DMA_METADATA_HOST_CTRL,
+					   PCI_EP_DMA_METADATA_HOST_CTRL_REQ);
+
+		ret = dw_edma_pcie_ep_dma_wait_ready(&metadata_view);
+		if (ret) {
+			dw_edma_pcie_ep_dma_clear_host_req(&metadata_view);
+			pci_iounmap(metadata_view.pdev, base);
+			return ret;
+		}
+
+		ret = dw_edma_pcie_parse_ep_dma_data(&metadata_view, pdata);
+		if (ret)
+			dw_edma_pcie_ep_dma_clear_host_req(&metadata_view);
+		pci_iounmap(metadata_view.pdev, base);
+
+		return ret;
+	}
+
+	return -ENODEV;
+}
+
 static int
 dw_edma_pcie_parse_synopsys_caps(struct pci_dev *pdev,
 				 struct dw_edma_pcie_data *pdata)
@@ -367,6 +737,14 @@ dw_edma_pcie_parse_xilinx_caps(struct pci_dev *pdev,
 	return 0;
 }
 
+static const struct dw_edma_pcie_match_data ep_dma_match_data = {
+	.data = &ep_dma_data,
+	.plat_ops = &dw_edma_pcie_raw_addr_plat_ops,
+	.parse_caps = dw_edma_pcie_parse_ep_dma_caps,
+	.flags = DW_EDMA_PCIE_F_REG_OFFSET,
+	.chip_flags = DW_EDMA_CHIP_PARTIAL,
+};
+
 static u64 dw_edma_get_phys_addr(struct pci_dev *pdev,
 				 const struct dw_edma_pcie_match_data *match,
 				 struct dw_edma_pcie_data *pdata,
@@ -400,8 +778,17 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	int err, nr_irqs;
 	int i, mask;
 
-	if (!match)
-		return -ENODEV;
+	if (!match) {
+		/*
+		 * The endpoint DMA metadata path has no static PCI ID yet.
+		 * Accept it only for an explicit driver_override bind, not for
+		 * arbitrary dynamic IDs without driver data.
+		 */
+		if (!device_has_driver_override(&pdev->dev))
+			return -ENODEV;
+
+		match = &ep_dma_match_data;
+	}
 	pdata = match->data;
 
 	if (!pdata)
@@ -659,6 +1046,9 @@ static struct pci_driver dw_edma_pcie_driver = {
 	.id_table	= dw_edma_pcie_id_table,
 	.probe		= dw_edma_pcie_probe,
 	.remove		= dw_edma_pcie_remove,
+	.driver		= {
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+	},
 };
 
 module_pci_driver(dw_edma_pcie_driver);
-- 
2.51.0


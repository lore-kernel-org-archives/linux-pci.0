Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020110.outbound.protection.outlook.com [52.101.229.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0644C9009;
	Thu, 27 Aug 2026 18:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787854689; cv=fail; b=Sd4sz+MKybSw+dXv2OkYwGC9Adf53wFIqby3scaWmWa6ApsrKZwtbkxJQIzHxQOs5IyARHXHgrByN+f+Tf8PZu7JhMqpYhofhEq/qS0JCQzQlASmRRXuNQrO3ji4/MT3BescMcApJQfmi16GsCIhF5w177UHY8vBGf3jfmB0Fqg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787854689; c=relaxed/simple;
	bh=ZVAWJbeS1cMRNOZdUquNA6kzX4Fpy57RThqp3H2xa60=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=dXGcR9BuLQVvMlUvZgJ12Y4IIDxfmbTjjQEzi/HRlEepuWuWfbCMu6DbCCeYVTDImpwyUAGn6UY0YMoVO2kTbaVdkBFUKlWtJN0ic2YU/I6DMAvAw2lhhGUirCPfTSrs02Xo8v1TxNrqHY01mL5Vr6BIIX4S6kcUYEeGoGSZd+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=ZY/BN/p3; arc=fail smtp.client-ip=52.101.229.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="ZY/BN/p3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KKOlSXsC1It2wugOCsZkicmEFXzy7Wxk12HcEC8/WqiYyFr00QhpMla0dHkCt2NhL+Nxhfl0q48mvKs9pxPc5koh80pmDcCFH0+WIBDKjp1QWp8T102Ylg+lUlBNVqi/5QZ4Xn096eV9cyKm7iAtR03PJznR3ViF3/OwuZJghmwWN28xM9VB+EZG+dk4KXQvUALwcjumlOrMk+hMRP2PF2oPCSxXRJL4mH7PaOmBiMLmDriAqTUVsJ5rScb3rXwR82toSvwHYQKLAv2bnj2OPDIncXyAcphZiBc3hVaGjiktH4Igj9RYOi0m5qOLju/KbjTxTfxwgBzv65RsBFMuig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZfX3tGMQTaOVTQ4HXUaiGmhCuxVkQGv6GxMRHaDmPIM=;
 b=oAVyAtCQYRx4dgOR9wZTxbq1wkJF9jDTnI3kZkJ2RD+n908KQPJ+f9rET8S16x9rYkQQ74JHUvdDTQ6uKPJuWfhwj7SdQawTNO7lhv0Rs3DhBjGykYhh6x0+korxA1fsVx9WA5Z01rg8jnk+49jwvQUKJR217Hl8KC32NDWnNosL9UZYePVqGS89bgDB0+mlDffoR3QFeH+ZdBqjX8GRU0jQ/hGjv/uc48TQ0LmRIz1t5xDInRiBvcTgk89jihVrNXWY9D5bkUGI479RrutyD0y2UOsU9JJa5tb7i3eYd3qf1FlLUMIrje8SS8vOrtH5h2D7xQm1Du0AS17oTOR6rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZfX3tGMQTaOVTQ4HXUaiGmhCuxVkQGv6GxMRHaDmPIM=;
 b=ZY/BN/p3HiqDZ9O+/mube+ZQD06LxkwFibMCu5xA2orlTPtOt4Obgw7OwY8H8gvD6g2Hg8vlbIpvTGDY75LxsY72LmG8Zfr4msr0Gmw/KghUuWGlMDd8IwZur5aqWfPE+k68voNZNrsBz6TeXAT7n/1K/1hU8yeKPVchdLyAk90=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY7P286MB7058.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:31d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 18:18:02 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%4]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 18:18:02 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Joao Pinto <jpinto@synopsys.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: endpoint: Fix BAR backing DMA address alignment
Date: Fri, 28 Aug 2026 03:17:57 +0900
Message-ID: <20260827181757.1984374-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0186.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:382::14) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY7P286MB7058:EE_
X-MS-Office365-Filtering-Correlation-Id: 828a1b54-5721-4e15-c73e-08df04678857
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|10070799003|366016|6133799003|10067099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	HbJaH7t8jYxY46uU4gR6VpimQL/XRo1eUgPhZTZlMqBl7a19WOvE9AulIP9WcgNPV3AQstISJOkIaKODF1JY5yTgjUDEULjP4MfH4KvnlGIIfLj7XDwXsWxN/Oz46AJDxD0BqDpcrJs91H0lEwM6WCITIhDgHqJLlNOGnexzFl3KfOgOGkbyE3FB9WBt1Pz8PDNvyvfHdAI4V1JsS1GEqoSbX9CslBb6VJuWytugWxg3RpcZIzO8gKyZphApN3zlzoV0WKA6UdPSMi/ZR73VL19F5+RggbL3hsrv7Q9/xtiktvn0HaDEkf2bRSHY6e/tIFkXVwax8p+wGuonBylQ5IRcA0qhQz7ez/3Qc3qcSwW6tvCP3z4bpbF9pGoJRl8X4h9Zk/3PCck/UIIKTs7IqR7s1CsYJcZvruc1mmYUeXCLFOnIDfjjkIvPDfXaeCTciuLUtW6ckjq0MiRc9agnpOWXTWhlPGlzwZJv8yzETjp+AHPjxj8XWEwlRAfPe7iZTI7FgtGeKYIZqucLyrN1SPCglPVYxR0eH0f3ERvwJWQWCjaYi2hCu4TGG0oyZ+WZqWtyTqRqPj5NETmQdzs96JVvBA2RMCPKzuxa0O5/moIzWprFH7sr/IS26VjEWnwZF2h9z8Nwpwi4SfvOfOBzH14L47CZnVSvalsJTTN+u4Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(10070799003)(366016)(6133799003)(10067099003)(56012099006)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QrD6Eom/zGwlK7eeJs6G3HYMuSpkOI1/oMybHAQvqV3q7Nb7YADqlLA9qLoP?=
 =?us-ascii?Q?fmtETY9fG4C/YIYnuUkDbVCFVP4k/SHlPL97OLd0AbNt2fgsTaSSgdg10skd?=
 =?us-ascii?Q?mOzSDoAuw4q4z5CEEFFYXwKXkTCbDwjmMTBGrISSbIkOjOsy09BblnLxPwvP?=
 =?us-ascii?Q?TcvPATcVRE8Ct/zrkKj6Al8otnvfdTdTTuIPxMF/e8bhqHyiF8q8iWz1LY2i?=
 =?us-ascii?Q?vwjtENPOU2muTNPIco33NpMUsuYk/y13DnZFTidh2n/lNFGRagFIGADHJU8C?=
 =?us-ascii?Q?/4prRUvtqTE60zAxxCWyVU/5M+frmtejmkwUln3sp3l56dxv2GsE0PVuErA1?=
 =?us-ascii?Q?UZY18SK6Et2YpJKh44XLcUWfm209X4wxO6pfWqfzEdtjG8gWonYHktCk8rQD?=
 =?us-ascii?Q?y6fFEbDBt0OWxgCcrRQ80PBBbsMcZfr93argu1udAgRlJITRJBn6BrRZhzO2?=
 =?us-ascii?Q?r75AAT89a6auWqk0m4l3n/wKK+/jfI1lMN4m0XCS4HhZYQJHPDkH14pP8W5p?=
 =?us-ascii?Q?O2QErW/F9xROt6TZX8HTwXt/+iKgokIEiBXTU+hQ4if9jeXCUCK1dz4i8bC5?=
 =?us-ascii?Q?9l3cSouLdS/q1ni4Ly6504ak0mnk7KSETTsTFyfQc4QVuzYNHSG6eW4Hk57x?=
 =?us-ascii?Q?6FKeKts2AzcU3UNctTlRMX4ZgN2MYq43NP1xyuJIx8DVZfUaew9LilIo9c3u?=
 =?us-ascii?Q?axYk76CpEIIXWGkxOr0pLkJ6VJZTwwO20Si7rVh9K4PyYb5ZploejZcz5RXV?=
 =?us-ascii?Q?hWiTtVsYKBC9Z6Ope05toVcpaRTpM+4Mof+4fOORzvcqY3j2EuUon89Gx2UP?=
 =?us-ascii?Q?v07/4kjQlaJTZTNbQw3W9UhjSIr6ZW+ZbeihoHg5hr8SHLbwTCks7HfLfGy/?=
 =?us-ascii?Q?nyVYjP1sPFyP6iSuidzYO75YUhx52Ty7s17HxvUqMUxPsmYnu7Gl863XvxoI?=
 =?us-ascii?Q?QMKISHxRJys1H4DCkXjw6bGOlt9uSPTzPeCWMNN8r9mb/XPhd4wWgntnp7WC?=
 =?us-ascii?Q?44EOZ1ZJpMt+pnactVsjnfQuzvS6Pr3/e8iB/ujUWxE0Xke0BIyY5n3q/IkV?=
 =?us-ascii?Q?8ZzB8kUnGaAR5Ppw0z1ZSyIMrz8jPFfEuVYPHZ9CF1vlOxHtLDaCSg5wCyA2?=
 =?us-ascii?Q?HCB08G9Isxaj62Ta29uma1F+/ymelqwra9SlDAvWX/eSzYRHKQmlPtY9piPl?=
 =?us-ascii?Q?w/pvIyIIK83NZRY2sQKHodKUtTbiCsBY/HoxwfZ0XY27QGgUDMOjM/dllxDc?=
 =?us-ascii?Q?+oySZfF/P7bBI3Iv7segtOqrlaZoUwLsyjVqvT5L6ddhzHr1jU4CIBvSeCWR?=
 =?us-ascii?Q?/ltvCGvi+P1kassuDHt5fNDBGqeoXbZ133ydmr4Jv6m5zFoANYunCWpZt57W?=
 =?us-ascii?Q?vUSvg8GXSLYtoUqN2Hw8jxGpIxXkUoVsaM16RMYCQn9CZtOUrZM8fODBTICi?=
 =?us-ascii?Q?p6Pv49ZO+GDK44heRcMyFdwmB8nMrCckUMVRr7tXbxP10/cakeMM56bwR2qL?=
 =?us-ascii?Q?cld5GYje8gR8Q016bZV9lCkUzl+mdXum0KshTZhJ7SqaCF6NvafWTzjGPv3U?=
 =?us-ascii?Q?qXbvZGI1c5IBZCb75+59t71ia7G1Hp0t0OWKgaaPTrs6K1y+mAZh4YCJpk6d?=
 =?us-ascii?Q?GWQIIgkcN9cjb1A5/szQdwL8SiP7JJsHgl/MzZWSI3Fzto0w/0vnkm9HaXMb?=
 =?us-ascii?Q?3ZaSBh8JY6hXdUrXIjJTnRABdfN711kWiP5q08XNt1E4W5eYgVXAQ29+KiLG?=
 =?us-ascii?Q?yZxF+L/3PutvNedRu92Myp3tJ1UNFuLRQ9JHnNLY20zWUDlpCysg?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 828a1b54-5721-4e15-c73e-08df04678857
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 18:18:02.6606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hHmm8LxSQtQRVbuGOfKDAREjpYvP0DY8chwZZeRVBhWx8Noij90AagXEPw4HxlXfccJfwUQyhse5Yg6GJyY9mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7P286MB7058

DWC BAR Match Mode requires the target address to be aligned to the BAR
size. pci_epf_alloc_space() relies on dma_alloc_coherent() to provide
that alignment. For CMA-backed allocations, the guaranteed physical
alignment is capped at PAGE_SIZE << CONFIG_CMA_ALIGNMENT. With a direct
DMA mapping, 4 KiB pages, and CONFIG_CMA_ALIGNMENT=8, a 2 MiB BAR may
therefore receive a DMA address aligned to only 1 MiB.
dw_pcie_prog_ep_inbound_atu() rejects such a mapping with -EINVAL.

If the initial allocation is misaligned, free it and retry with
mem_size - 1 bytes of padding. Select an aligned subrange and record its
offset so pci_epf_free_space() can pass the original CPU address, DMA
handle, and size to dma_free_coherent().

Fixes: 5e8cb4033807 ("PCI: endpoint: Add EP core layer to enable EP controller and EP functions")
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/endpoint/pci-epf-core.c | 39 +++++++++++++++++++++++------
 include/linux/pci-epf.h             |  7 ++++--
 2 files changed, 37 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index 6987343c9e61..e8c3709d85c4 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -8,6 +8,7 @@
 
 #include <linux/device.h>
 #include <linux/dma-mapping.h>
+#include <linux/overflow.h>
 #include <linux/slab.h>
 #include <linux/module.h>
 
@@ -278,13 +279,15 @@ void pci_epf_free_space(struct pci_epf *epf, void *addr, enum pci_barno bar,
 	}
 
 	dev = epc->dev.parent;
-	dma_free_coherent(dev, epf_bar[bar].mem_size, addr,
-			  epf_bar[bar].phys_addr);
+	dma_free_coherent(dev, epf_bar[bar].mem_size,
+			  (u8 *)addr - epf_bar[bar].alloc_offset,
+			  epf_bar[bar].phys_addr - epf_bar[bar].alloc_offset);
 
 	epf_bar[bar].phys_addr = 0;
 	epf_bar[bar].addr = NULL;
 	epf_bar[bar].size = 0;
 	epf_bar[bar].mem_size = 0;
+	epf_bar[bar].alloc_offset = 0;
 	epf_bar[bar].barno = 0;
 	epf_bar[bar].flags = 0;
 }
@@ -308,8 +311,10 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
 {
 	struct pci_epf_bar *epf_bar;
 	dma_addr_t phys_addr;
+	size_t alloc_offset = 0;
 	struct pci_epc *epc;
 	struct device *dev;
+	size_t alloc_size;
 	size_t mem_size;
 	void *space;
 
@@ -326,16 +331,31 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
 	}
 
 	dev = epc->dev.parent;
-	space = dma_alloc_coherent(dev, mem_size, &phys_addr, GFP_KERNEL);
-	if (!space) {
-		dev_err(dev, "failed to allocate mem space\n");
-		return NULL;
+	alloc_size = mem_size;
+	space = dma_alloc_coherent(dev, alloc_size, &phys_addr, GFP_KERNEL);
+	if (!space)
+		goto err_alloc;
+	if (!IS_ALIGNED(phys_addr, mem_size)) {
+		dma_free_coherent(dev, alloc_size, space, phys_addr);
+
+		if (check_add_overflow(mem_size, mem_size - 1, &alloc_size))
+			return NULL;
+
+		space = dma_alloc_coherent(dev, alloc_size, &phys_addr,
+					   GFP_KERNEL);
+		if (!space)
+			goto err_alloc;
+
+		alloc_offset = ALIGN(phys_addr, mem_size) - phys_addr;
+		space = (u8 *)space + alloc_offset;
+		phys_addr += alloc_offset;
 	}
 
 	epf_bar[bar].phys_addr = phys_addr;
 	epf_bar[bar].addr = space;
 	epf_bar[bar].size = size;
-	epf_bar[bar].mem_size = mem_size;
+	epf_bar[bar].mem_size = alloc_size;
+	epf_bar[bar].alloc_offset = alloc_offset;
 	epf_bar[bar].barno = bar;
 	if (upper_32_bits(size) || epc_features->bar[bar].only_64bit)
 		epf_bar[bar].flags |= PCI_BASE_ADDRESS_MEM_TYPE_64;
@@ -343,6 +363,10 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
 		epf_bar[bar].flags |= PCI_BASE_ADDRESS_MEM_TYPE_32;
 
 	return space;
+
+err_alloc:
+	dev_err(dev, "failed to allocate mem space\n");
+	return NULL;
 }
 EXPORT_SYMBOL_GPL(pci_epf_alloc_space);
 
@@ -413,6 +437,7 @@ int pci_epf_assign_bar_space(struct pci_epf *epf, size_t size,
 	epf_bar[bar].addr = NULL;
 	epf_bar[bar].size = bar_size;
 	epf_bar[bar].mem_size = aligned_mem_size;
+	epf_bar[bar].alloc_offset = 0;
 	epf_bar[bar].barno = bar;
 	if (upper_32_bits(size) || epc_features->bar[bar].only_64bit)
 		epf_bar[bar].flags |= PCI_BASE_ADDRESS_MEM_TYPE_64;
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index 8a6c64a35890..749c6611d7b9 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -131,8 +131,10 @@ struct pci_epf_bar_submap {
  * @phys_addr: physical address that should be mapped to the BAR
  * @addr: virtual address corresponding to the @phys_addr
  * @size: the size of the address space present in BAR
- * @mem_size: the size actually allocated to accommodate the iATU alignment
- *            requirement
+ * @mem_size: size of the coherent allocation, including alignment padding, or
+ *            the required aligned backing size for assigned BAR space
+ * @alloc_offset: offset from the coherent allocation's CPU and DMA base
+ *                addresses to @addr and @phys_addr
  * @barno: BAR number
  * @flags: flags that are set for the BAR
  * @num_submap: number of entries in @submap
@@ -144,6 +146,7 @@ struct pci_epf_bar {
 	void		*addr;
 	size_t		size;
 	size_t		mem_size;
+	size_t		alloc_offset;
 	enum pci_barno	barno;
 	int		flags;
 

base-commit: 0a6f72eda328c773324555491e1ad7f0b0153155
-- 
2.51.0


Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020118.outbound.protection.outlook.com [52.101.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3355304972;
	Mon, 25 May 2026 06:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779690698; cv=fail; b=HP9hSGn8UHsYelWH+3+TsDA6tqNiJdWtKhVpPm0Cy5IChLW9yyXRvmEOPd3RgfrKt51kZT96EWWB33mk2JQm27oL4UB1kPu5wpttF5c8SmKKXXMvOhMnpLpz6y6PwqICrw6Us4sr/E0e31qG+CejnEwh0P4xOMO3A35TLnytM3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779690698; c=relaxed/simple;
	bh=1Em+v7A2cqwJhuhbGgZ/9MQNeTNCZT/+BfZeytcSCvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=njyzyfSlVL6x+kUEmJj65K9U+/FL3Akv3zplgazFVUsgN181HLpkIsp/p0z83up1lM8YcyAlwlHmU7ABzG6D8ZR2sK1x5cSEGgbGpTyZnySG99SMbc+/EFk2Joo8FuRtlvp7P0sqa0asb9w/R+og+L9YvnWVaPwYxhWG6+QM+aE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=Y3w6dLvM; arc=fail smtp.client-ip=52.101.229.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="Y3w6dLvM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NNYTbXv8bmkgjh4dtBYoJq8v244C1RiBWKFzVfubSH/2f0ci3fOkYvDT4efaXqa0fqB++6fwm2kKPKmJVTKVFc7XnUIaSZRnlRBfXah8+/S0BgGvYDyUWY2aD/ZNlATFP4jy2168kSu7rkXTOMbnKWfkQani7OKSWwMq0V0IxoihsVS+kX+DpfTR6R7OuntxFXNVlZMDxRHLmPzBB3S+CKUD4YjrOF5yqOoMS6WiOO0NE3atii+zQoelAeyTGAnS1oXqy3524KdbhLLe5SVENEISEQV4auoied5hpJhKV2Vzt6BduW/vmYxQnhfZCXnPPfmOHZwD/bMmB/wR5p3Zmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q12hSfH3mna6QUA51Jv1Gmu6OuFyvhLGHx5Zc5qg0Lw=;
 b=lfEDw2D/vbkwjiK5VW2qMXK6kpoB4E3585rNPBcW7iThNT9WdYCr9vdaATQkwsUwzn+zrchXAy/wt5yI0312uHJrfxgW7REqMu7nOei3d3/h2seZxSSXWaOF+DKUAT0h+NKbVcUt1CJ5Sm2dWvHVCJ9tbQs/PdfLZwNOD97eNUb663GCbpwJuApGsh1TeTIDJ+uCaoEGbuDzW4IWmhp+Ukj0jWp+RR8h5byp66oixODp56mfzjzIK/UHcZvNN2k9YOQSi6oERcIywzbT0u8YkhW7CllzAOy0WErwYVNxggmSix5cN8UixDRhw45n/g/ioUATsm4nenpe40JuWaemMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q12hSfH3mna6QUA51Jv1Gmu6OuFyvhLGHx5Zc5qg0Lw=;
 b=Y3w6dLvMehWGdy/tBiPmkM0OnlOYCosprax6StgLD3zgCah3OUXFwLYXo851RmftUQad5FxhDTMdHMGXdWtuEsLaLYMvyHPI1dk2FT89kDp8/XuLUcq9udm64HtKYynQNeMm9O3wgGQIKs4fbxU5EvcOrotP6RjW93NvdWTPlJQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYYP286MB4607.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:197::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 06:31:34 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 06:31:34 +0000
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
Subject: [PATCH v2 1/3] PCI: endpoint: Define endpoint DMA BAR metadata format
Date: Mon, 25 May 2026 15:31:27 +0900
Message-ID: <20260525063129.3316894-2-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260525063129.3316894-1-den@valinux.co.jp>
References: <20260525063129.3316894-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0011.jpnprd01.prod.outlook.com
 (2603:1096:405:26e::7) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYYP286MB4607:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b24b9fc-160c-4637-c629-08deba274419
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|1800799024|7416014|376014|6133799003|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	JxCNUnI6UDugGcgksdq8MiqxomLDddR2PvMbfms8qrfxJFi0lZ2IXEoPyFX33xmcENCEoo0setfTCR/nooEtic9TTmgsj8N50O5GfatJj6jt5r9Vjzy6eDLcjZttS8KeuHFJBvBmXw9HbI6rb2MNs462U7gvVhxa2JLNz/HhOY+60sDOA+aD1Ev/5VJCez+1Kx4p0qSr6B/eAgGGuVqhqgr7wPqVcm/lwlX1B0bOs6hp3gw/eUZ77c9Zw49CtD/EHJBGeDSF0lXqjB5rnRFnte0acvJtlMYiWpx6oA4fauIJZEUZFdMZXr+Si1Y29TP1bcoHh8VI0anuR+JDPyP5Lo2zL2HBBf9LNPij0WsJDL4TjdQqwQHgSdLU5PUDPUARDxxn6vhiAJeC3TqwetMe6ZtWcjxMtAEkOVIxzpNSjVmU2ZfvFTK8MToYW0vqSYlcpnPLQzPwntk/i1xKARRDvqiLdhCO6TUEd1ByaZNYbODXhczTMgEVVF5+iCZeKmjClo9T+DKjphZDXSVUGFeJFijhEbJ/Xy1sr4D7pvkK6F50snxc3EbeCHgcPXZBDzBp4gn+1YnM5ezEEtrpT7NZsBX/UYXMVKRRWkXNVheF8YJlyd8x2UOr6WREngy1sLFKu48X/JRZKXbCJKIdpD61s7sszg9Ddl/B1D66zPiwDdxgy5zC6w0Ae9/i4oKAnvrA
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(7416014)(376014)(6133799003)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RUZfnwt92CA8g310muRuLNCZaHJoTFxScPSVJSbkixkfEKS/tr0+PS9sTyV2?=
 =?us-ascii?Q?YlIhASZZjCwha1Oabqx2hk8NIlcfA3Ug0V58jHQn84gaIqRLAnQAs8UjcTm5?=
 =?us-ascii?Q?QHHc/J+63In+1lkqIj+Zt7fw64oW0Ls9YQBJpXOhP3GPGL7VCk0GyecND/Fx?=
 =?us-ascii?Q?Ca2fWk6+kjnOSEQcNFLdTh69hTUG6qZlxbsd6xuLaRms5ToEPky22cbzOVKw?=
 =?us-ascii?Q?IIdrkTufN+hSopgGM2Cz0/1U6rLr+Q6KadefY3auXtsuIqmcqOKw9LBUIjR1?=
 =?us-ascii?Q?nLU6OYCsxYu10rg6TvuPXwgdcvwMuzJCAHC6oZNGkpG7xU+pP2rhIxx0eBCx?=
 =?us-ascii?Q?3Fc1dFsmzI9xrmRcNtcAAcZrCE2hMf50XY3wjBUrqZZzJJbzQfHTrIUDSRIO?=
 =?us-ascii?Q?TB/NDBaHbynqNxdyyBr/jORa9dzZCw/ChnbIbE0KSLCPLAtxIKmRCZYzBf13?=
 =?us-ascii?Q?VwW57XR1X2kfCR7z/tzZd2Um0D3f5X6HVYAZnBzwd7NxsFhQKqoHSCL9qHmK?=
 =?us-ascii?Q?BxukGPnJZw3h7N6yFMkNkP0Wi7VjK54JeLw2w9txnDBmnxclkHsG4nQQdYNO?=
 =?us-ascii?Q?TmFU7cbvR2c94OuHhzEdHnvw//tgG17dvJQ6IfsmYFoP0vteGZCY9+31izVy?=
 =?us-ascii?Q?0wGZDKTQJfcVXqOheLIVc9bO78jxfCSHrGEUsI1O2jFRCSzPcp6F/zpkr9+e?=
 =?us-ascii?Q?Ue67cDMQXu+lKOA8EoBbAYde4grAvlQK1PWviRxEKUyOD4zO2tG17C2R7nt7?=
 =?us-ascii?Q?l6M6MC/aw9uaG6PuwZkHUUsFQKdWWuSY2LPGdl1wf04s7ZtmNJHd2EyocK88?=
 =?us-ascii?Q?vpvgXt4fZHKt/J2HdMM1MwT/0zsQK/g+XddPYYfIJDOaBr3vQwxmypntwU1z?=
 =?us-ascii?Q?nXTb2AWVzP+NcStGHDKfI1vsaiMSGfOvQv/pFwLpsPZdwXPAdDf4eB8zbMyg?=
 =?us-ascii?Q?KMiOh8Nox8AZo3M570+MfSRy1PnL/+enEyyIVQDbrvdt2gSgF/BGxZ/hBCS2?=
 =?us-ascii?Q?ULXyOfKR0pQBQZ/P1OvenymCGZSpVZVSAwUaL1jGaFFxpLWkYE7Op0TwpH/u?=
 =?us-ascii?Q?OiXEfxDVnlxlRflQxd3WT2Kp6v+Ecb1sXqQbbeEJso3e5dBeuEmpL2BI6wig?=
 =?us-ascii?Q?287NyYx3BV4femTRX7TSTri9MvM1dLBv9mFqX1+xiP9ZlvYRHEEKZ4z2aKHa?=
 =?us-ascii?Q?yaQ9PPWUEcK4isdwR5F9yRnDe+gJAwIWU2dUcNpu6Wq2ow7RrYueCe9GREto?=
 =?us-ascii?Q?SqiJB+dGRAHupurJL8a6oyVp7pb/XkTKDFzf/K2H3/7Mlw8AtqTPl75WiPSP?=
 =?us-ascii?Q?LVGYyvNsYu9MtctIEEZ7tS7jqHfDCikOwWiS3Eh11XblQfOwEuHzosi+pXRM?=
 =?us-ascii?Q?xQEhi9tNuegaPyfV7WboN09H2zAlzniVIyup+kTZ6eEtPzLThCE9VpfYMZU4?=
 =?us-ascii?Q?kM2x0zcvppK8GB27f9ceCnfkI7tnD8//cX8aVS+/a73M1ajqEX2TitKsqVUQ?=
 =?us-ascii?Q?T2+53kS7pt0ed5ktqFGo97ubec6rJgsqtIeCzEZ7LjArxhQkSQojx/sI4tn7?=
 =?us-ascii?Q?ZArNL27HvtImKiGcmFuTsk99QkiHue5G55HrWFGXbWuFIOd7iWxYW6uibLoi?=
 =?us-ascii?Q?gklucEmc4zmuycz8bZIqWYYKGT9FJDosRyux2E3e5dtpR7z/+FFDwDW0ftl5?=
 =?us-ascii?Q?76VMmmDuBx0xt6BKbY1uuJ59PMZ1XBdyxboN2M8kb//xb6E/qELkgtC26C0+?=
 =?us-ascii?Q?RyDfCcDwigmG4mqBMm/nramH7YAc84nCXJ5L2agWs2yrGYiP2liT?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b24b9fc-160c-4637-c629-08deba274419
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 06:31:34.2889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZssTts8ROToGAjMVZwnO/weSHXl5FlJ53QGs0Evi0+GJ2dKtX4W+4MEejisJI/VZAvHsPOIGEDn7vuKAr6yfcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB4607

Define the BAR-resident metadata format used by endpoint functions that
expose an endpoint-integrated DMA controller to the host.

A VSEC-based discovery scheme would be a natural fit, and existing
dw-edma-pcie providers such as Synopsys EDDA and AMD/Xilinx MDB already
use VSECs for DMA discovery. However, some endpoint controllers cannot
provide enough writable configuration-space storage for a complete,
controller-defined payload. Keep the extensible metadata in a BAR
instead, where the endpoint function controls the layout and size.

The format describes the DMA register window, exported channel counts,
descriptor windows, optional auxiliary windows, endpoint-local descriptor
and auxiliary DMA addresses, and a ready bit that tells the host when the
described BAR windows are usable. Channel entries keep the auxiliary
window optional so layouts that need a separate data or auxiliary aperture
can describe it without a format bump.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 MAINTAINERS                |   1 +
 include/linux/pci-ep-dma.h | 163 +++++++++++++++++++++++++++++++++++++
 2 files changed, 164 insertions(+)
 create mode 100644 include/linux/pci-ep-dma.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 2fb1c75afd16..416c8c063113 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20508,6 +20508,7 @@ F:	Documentation/PCI/endpoint/*
 F:	Documentation/misc-devices/pci-endpoint-test.rst
 F:	drivers/misc/pci_endpoint_test.c
 F:	drivers/pci/endpoint/
+F:	include/linux/pci-ep-dma.h
 F:	tools/testing/selftests/pci_endpoint/
 
 PCI ENHANCED ERROR HANDLING (EEH) FOR POWERPC
diff --git a/include/linux/pci-ep-dma.h b/include/linux/pci-ep-dma.h
new file mode 100644
index 000000000000..c5fd7aab2101
--- /dev/null
+++ b/include/linux/pci-ep-dma.h
@@ -0,0 +1,163 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LINUX_PCI_EP_DMA_H
+#define __LINUX_PCI_EP_DMA_H
+
+#include <linux/bits.h>
+
+/*
+ * BAR metadata format used by PCI endpoint functions that expose an
+ * endpoint-integrated DMA controller to a PCI host.
+ *
+ * Offsets are relative to the beginning of the metadata blob. Multi-byte
+ * fields are little-endian. The blob is normally placed at offset 0 of a
+ * function BAR selected by the endpoint function and discovered by the host
+ * driver using device-specific policy. Other data in the same BAR, such as a
+ * standard MSI-X table or PBA, is outside this metadata format.
+ *
+ *          31                                                              0
+ *          +---------------------------------------------------------------+
+ * +0x000   | metadata magic                                                |
+ *          +---------------------------------------------------------------+
+ *          31                            16 15            8 7              0
+ *          +-------------------------------+---------------+---------------+
+ * +0x004   | metadata length               | reserved      | revision      |
+ *          +-------------------------------+---------------+---------------+
+ *          31 30 29     27 26          19 18          11 10           3 2  0
+ *          +--+--+--------+--------------+--------------+--------------+---+
+ * +0x008   |R |H |reserved| ch entry size| RD count     | WR count     |BAR|
+ *          +--+--+--------+--------------+--------------+--------------+---+
+ * +0x00c   | register window offset[31:0]                                  |
+ *          +---------------------------------------------------------------+
+ * +0x010   | register window offset[63:32]                                 |
+ *          +---------------------------------------------------------------+
+ *          31                            16 15            8 7              0
+ *          +-------------------------------+---------------+---------------+
+ * +0x014   | reserved                      | layout data   | layout        |
+ *          +-------------------------------+---------------+---------------+
+ * +0x018   | register window size                                          |
+ *          +---------------------------------------------------------------+
+ * +0x01c   | write table                                                   |
+ *          | ( channel table entries #0 ~ #N )                             |
+ *          +---------------------------------------------------------------+
+ *          | read table                                                    |
+ *          | ( channel table entries #0 ~ #N )                             |
+ *          +---------------------------------------------------------------+
+ *
+ *          metadata magic: PCI_EP_DMA_METADATA_MAGIC.
+ *          metadata length: byte size of the whole metadata blob.
+ *          revision: metadata format revision.
+ *          R: ready bit. Set when all BAR windows described by this metadata
+ *             have been programmed and can be used by the host.
+ *          H: host-request bit. Set by the host driver after it has found this
+ *             metadata. The endpoint may use this as the trigger to program
+ *             DMA window BAR subrange mappings.
+ *          ch entry size: byte stride between consecutive channel table
+ *                         entries. Revision 1 requires at least
+ *                         PCI_EP_DMA_METADATA_CH_ENTRY_SIZE bytes.
+ *          RD count: number of exposed RC-to-endpoint DMA read channels and
+ *                    read channel-table entries.
+ *          WR count: number of exposed endpoint-to-RC DMA write channels and
+ *                    write channel-table entries.
+ *          BAR: BAR that contains the DMA controller register window.
+ *          register window offset: BAR-local byte offset of the DMA controller
+ *                                  register window in BAR.
+ *          register window size: DMA controller register window size in bytes.
+ *          layout: DMA controller register layout identifier.
+ *          layout data: layout-specific data. For
+ *                       PCI_EP_DMA_METADATA_REG_LAYOUT_DW_EDMA this is the
+ *                       DesignWare eDMA/HDMA map format.
+ *          write table: starts at PCI_EP_DMA_METADATA_HDR_LEN if write channel
+ *                       count is non-zero.
+ *          read table: starts at PCI_EP_DMA_METADATA_HDR_LEN plus the write
+ *                      table size if read channel count is non-zero.
+ *
+ *
+ * Channel table entry:
+ *
+ *          31                 17 16 15 14   12 11 10     8 7                0
+ *          +--------------------+--+--+-------+--+--------+----------------+
+ * +0x000   | reserved           |A |rs|aux BAR|rs|desc BAR|hardware channel|
+ *          +--------------------+--+--+-------+--+--------+----------------+
+ * +0x004   | descriptor window BAR offset[31:0]                            |
+ *          +---------------------------------------------------------------+
+ * +0x008   | descriptor window BAR offset[63:32]                           |
+ *          +---------------------------------------------------------------+
+ * +0x00c   | descriptor window size                                        |
+ *          +---------------------------------------------------------------+
+ * +0x010   | descriptor DMA address[31:0]                                  |
+ *          +---------------------------------------------------------------+
+ * +0x014   | descriptor DMA address[63:32]                                 |
+ *          +---------------------------------------------------------------+
+ * +0x018   | auxiliary window BAR offset[31:0]                             |
+ *          +---------------------------------------------------------------+
+ * +0x01c   | auxiliary window BAR offset[63:32]                            |
+ *          +---------------------------------------------------------------+
+ * +0x020   | auxiliary window size                                         |
+ *          +---------------------------------------------------------------+
+ * +0x024   | auxiliary DMA address[31:0]                                   |
+ *          +---------------------------------------------------------------+
+ * +0x028   | auxiliary DMA address[63:32]                                  |
+ *          +---------------------------------------------------------------+
+ *
+ *          A: auxiliary-window-valid bit. If clear, aux BAR and auxiliary
+ *             window fields are ignored.
+ *          aux BAR: BAR that contains the optional auxiliary window.
+ *          desc BAR: BAR that contains the descriptor window.
+ *          hardware channel: DMA controller's hardware channel number.
+ *                            Revision 1 entries are currently consumed in dense
+ *                            0-based order.
+ *          descriptor window BAR offset: BAR-local byte offset of the
+ *                                        descriptor window in desc BAR.
+ *          descriptor window size: descriptor window size in bytes.
+ *          descriptor DMA address: endpoint-local address used by the DMA
+ *                                  controller to fetch descriptors.
+ *          auxiliary window BAR offset: BAR-local byte offset of the auxiliary
+ *                                       window in aux BAR.
+ *          auxiliary window size: auxiliary window size in bytes.
+ *          auxiliary DMA address: endpoint-local address corresponding to the
+ *                                 auxiliary window.
+ */
+#define PCI_EP_DMA_METADATA_MAGIC		0x4d444550 /* "PEDM" */
+#define PCI_EP_DMA_METADATA_REV			0x1
+
+#define PCI_EP_DMA_METADATA_HDR_LEN		0x1c
+
+#define PCI_EP_DMA_METADATA_HDR			0x04
+#define  PCI_EP_DMA_METADATA_HDR_REV		GENMASK(7, 0)
+#define  PCI_EP_DMA_METADATA_HDR_LEN_FIELD	GENMASK(31, 16)
+
+#define PCI_EP_DMA_METADATA_CTRL		0x08
+#define  PCI_EP_DMA_METADATA_CTRL_REG_BAR	GENMASK(2, 0)
+#define  PCI_EP_DMA_METADATA_CTRL_WR_CH_COUNT	GENMASK(10, 3)
+#define  PCI_EP_DMA_METADATA_CTRL_RD_CH_COUNT	GENMASK(18, 11)
+#define  PCI_EP_DMA_METADATA_CTRL_CH_ENTRY_SIZE	GENMASK(26, 19)
+#define  PCI_EP_DMA_METADATA_CTRL_HOST_REQ	BIT(30)
+#define  PCI_EP_DMA_METADATA_CTRL_READY		BIT(31)
+
+#define PCI_EP_DMA_METADATA_REG_OFF_LO		0x0c
+#define PCI_EP_DMA_METADATA_REG_OFF_HI		0x10
+#define PCI_EP_DMA_METADATA_REG_LAYOUT		0x14
+#define  PCI_EP_DMA_METADATA_REG_LAYOUT_ID	GENMASK(7, 0)
+#define  PCI_EP_DMA_METADATA_REG_LAYOUT_DATA	GENMASK(15, 8)
+#define PCI_EP_DMA_METADATA_REG_SIZE		0x18
+
+#define PCI_EP_DMA_METADATA_REG_LAYOUT_DW_EDMA	0x1
+
+#define PCI_EP_DMA_METADATA_CH_ENTRY_SIZE	0x2c
+#define PCI_EP_DMA_METADATA_CH_CTRL		0x00
+#define  PCI_EP_DMA_METADATA_CH_CTRL_HW_CH	GENMASK(7, 0)
+#define  PCI_EP_DMA_METADATA_CH_CTRL_DESC_BAR	GENMASK(10, 8)
+#define  PCI_EP_DMA_METADATA_CH_CTRL_AUX_BAR	GENMASK(14, 12)
+#define  PCI_EP_DMA_METADATA_CH_CTRL_AUX_VALID	BIT(16)
+#define PCI_EP_DMA_METADATA_CH_DESC_OFF_LO	0x04
+#define PCI_EP_DMA_METADATA_CH_DESC_OFF_HI	0x08
+#define PCI_EP_DMA_METADATA_CH_DESC_SIZE		0x0c
+#define PCI_EP_DMA_METADATA_CH_DESC_ADDR_LO	0x10
+#define PCI_EP_DMA_METADATA_CH_DESC_ADDR_HI	0x14
+#define PCI_EP_DMA_METADATA_CH_AUX_OFF_LO	0x18
+#define PCI_EP_DMA_METADATA_CH_AUX_OFF_HI	0x1c
+#define PCI_EP_DMA_METADATA_CH_AUX_SIZE		0x20
+#define PCI_EP_DMA_METADATA_CH_AUX_ADDR_LO	0x24
+#define PCI_EP_DMA_METADATA_CH_AUX_ADDR_HI	0x28
+
+#endif /* __LINUX_PCI_EP_DMA_H */
-- 
2.51.0


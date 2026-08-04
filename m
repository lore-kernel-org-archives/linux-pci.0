Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021118.outbound.protection.outlook.com [40.107.74.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F57C30ACF6;
	Tue,  4 Aug 2026 03:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785814749; cv=fail; b=Me2YBlWubp6JtVrFBSLrfLyRfh87nLOxNdCh56baW9Ei/m0uZMelEDgPen9P4Z4Xhz8M2hLqZdWtZFupl8suZMBFU9MUCasDPv5MJqWUb26cGcpXn27YVFOk+MEP2CM+B603hUkYVmKG9VqQd+sdyd2knHnfJ/z+pyEIVKEyPDo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785814749; c=relaxed/simple;
	bh=aIkypIJRxq2jSRdY53Bof1FUxjVEQpbjlx6MHqi4j8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Xa3xsObXyeIbPayOnnEM4XDzq084s4PUENum7aNoCxyzR9sgkYQJM7JnCeCcldCmbMKdbcQfII+lhs3PI172RLiXtvHl8ug2ceJ9c5NISv+3H28ruuAk952OQmELeMhO3/XJlPxFsLamYM2CrRFqpyS9RHAdUD0tnvyUiD71bD4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=D6X9HVua; arc=fail smtp.client-ip=40.107.74.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="D6X9HVua"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nemykdSZEeJGhtlHSLvhcZrSFjmUyJOHfVCNFYKWbtKkbue7vlNxnTSo23rTC5xEc47UiqQGGAuVz2l0Dtx/9UuDEqsa9YPM72b993wsjg9deifK0Q1Skz8R/CmuDzG/f3p01qYsva9u0fHNugerH0C1ToXGQAT/TiaTZYX2xnTF1pAtOcaP8tkGSpTo3lGkz8s9ENA2blFM/ePDNHKHRSkta84zxJYiQ9lV8iU36LbuunF0OXAwpk9KmBFeWmMdCMT6mOuOjdBBPM8dPs9QZTLYELqutg/W5WdTm3/HF+ZNDAS4p3dNFoHX22DdHpHoc1XqdtGLoWDzEDucvP+TpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EkkEgByK4R0y01/tCflvu9/VmkYsdDI3TKG5w3Byun0=;
 b=MZylxPeLLKNIr80dxh13dNSzsjalQOElKau2MtCKi/XwgQ7WTaIcuVVbSoPw2Tk3j7WF/qecbgppl7br771dzP7gR0YBheDffh4v8aDPdA3K7mlcUig8pZH9kLPcMXlcVYQ7ECE/Mze8zMJcArZfsSYCstfMIau0iRR74C0kmgWgZEmIGQDLy5l+SND91khaabzv8si56ZYFIlIE6FL2p8AFVMMyd7S3Xdku8tqFAASNS56xlG5rjI9tgidy1iPuDEk+jhoQthE705T/dOUOisCt96JotsUY/plunWZi6GKxWvAA9dGmFHwLTpkXXcU0KCzjZ2sudajizEtNCD81LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EkkEgByK4R0y01/tCflvu9/VmkYsdDI3TKG5w3Byun0=;
 b=D6X9HVuaC2IXs8ykvRd5n4UGGPjcFd1JshwYskw8IOwFs647HqdwViXvtvMvbaqq81mdPqGFfL2bJ5/szcz90FzZDecj8zabVvThijsY640ZjDZHKYqGUsq102vDxKAWQxrju4j52YQGU/79H+9unNNV0yFw3qugP3016PLo3T4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY6P286MB7598.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:347::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 03:39:01 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%3]) with mapi id 15.21.0270.017; Tue, 4 Aug 2026
 03:39:01 +0000
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
Subject: [PATCH v6 1/6] PCI: endpoint: Define endpoint DMA BAR metadata format
Date: Tue,  4 Aug 2026 12:38:50 +0900
Message-ID: <20260804033855.2115817-2-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260804033855.2115817-1-den@valinux.co.jp>
References: <20260804033855.2115817-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0031.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2be::17) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY6P286MB7598:EE_
X-MS-Office365-Filtering-Correlation-Id: 8deaab7e-0c53-4cc4-3a0f-08def1d9ec84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|376014|1800799024|7416014|366016|56012099006|6133799003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	7mm6uWOi9Ez9PLutJAAPXlOfgGFsaUe4kYTtYWyynIcjltj2u6ouNbiZtClTfuuu5iqD5C+ueiP69wZtdsvUywlCg9Rwqle/ejyM+azwMUDEDDvt3EfjH5aUUQXCzFNchQESBY5ag0WkOJRSI8PpdEo2+b2rDspuDhfXrosE4Jwozio7KbUGGlfvabW7+bqhpiQ7nYCVcS5bK2GVz8fC12zT1TGtAZlXf/wV+hfr1/0MYm+qC1dJby9zdGrjNLEvKiNrFbqsbFGF6odop9EXEPgJjz7E/ypUvLKKb50Ycf71rWgx2H7GnLufvS5H9kujWXKj6p/ZNXo/ZZPT2MM262dVswCRbEYMsFBNQaNS20VL5Z9553xyORh4FPAS01uQ43j/2ANeP/CNzcY9Ou0cUja+yVCaN/qalVr9AHfu+NPYLW+iPBnPs/3PHww3Akqt7f4YsUi21CrLVSz8Ran5ynFYvzw7XHewjp95P6tK5cmd/j4VgsKOtjb0rcPffAvoTjXFWzk4BRJAyw1TtR/DUlwcRXjnXdTo2apurjzlHcC0OuemL7X+5Qt7U2l0yaYtAPNM/IUpfnkZcYTKtJ8LTLYzs+n5zd9BhMMJ29yk+x+pNrGokeIKiXvO3k2mKzWaTi3VaC7vp+QEle75eKokdG7YT/ioqXTnerp6ezuzdeE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(376014)(1800799024)(7416014)(366016)(56012099006)(6133799003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?46IAEt2yYAZoOEIV7cnIN8hWj+IlMufix1ClFT5wRm5C6NwS1feyr/xl/aLG?=
 =?us-ascii?Q?6n1nT16QQHKp7rAmeTs5VZkRFQl+XOBa8hoUO9Q8CPtmhUQE/2yxJmGdCq1i?=
 =?us-ascii?Q?N6hxE9nEW3kNmDQRwkQluuT6W7QKRWiNpZWB6diOHMkRFLx89d2Q3sbb8F9g?=
 =?us-ascii?Q?0n8GRqjm20h86/7uFg/y69M2y3+aJOkTNolZLJMuIBJzpxUgsi29a6GCtpKt?=
 =?us-ascii?Q?1h/GjCx6UB2LQbq8adMNaQuYrBa/g4T2CYKlLO8E6141Wrnxs24L5cJPIn1Z?=
 =?us-ascii?Q?rHQvUziDRMF76HjjJWQ7TrfU8mOVaL5FB/xcbC+xNdcwb9A48n18nm+wS5dk?=
 =?us-ascii?Q?Zyimt+ZgDwhdFvBE+eEXdxgq4xIzop7uJoOirsrHy24sKmnDAM41G7jZigu9?=
 =?us-ascii?Q?hYsfnXXwFMExo+NaaYB5hSmu3i1I2N3DQ3C9nFXmnpP2luUe5QYKW90jSGiX?=
 =?us-ascii?Q?8dMboaO5zbHL5Mesx8s8QmN/8clkBQhaclVnYjxjqcXZ4ey4bGH7mlmhrKJ2?=
 =?us-ascii?Q?IdJ12ef8bvlS6OrbNGRc6Qkmgl3JtXYDGhGZNl2Ex/tCP4uVQ0EATb+vlRWs?=
 =?us-ascii?Q?fgPm7h9OzGsbZReXfeBvoVza2JfIv1cMas5F5RT43THdjU6re+g45+GFCAIF?=
 =?us-ascii?Q?kEWFHV+w2aTy/EtyaeRGjGa6ZgeyU1GPp5YGOHHNevb2AFEnwS24sN2YGtgX?=
 =?us-ascii?Q?0fNWfgR3S6lI5AmvqYIaVF0//4f1eWNdPlGtN1qzrShwSjLz46w3Bts3mLs/?=
 =?us-ascii?Q?47A17Tx4YGGftmTOMRDDLfw/2ClHct3ZpcIbztKOIoVAsH58yoWkCQoZyrqY?=
 =?us-ascii?Q?fqncKj+ZLES4a/+2KO7j+0eQCtrCx7UpYjnDt5fWMiTu4t5Ece8B2uWaGZjF?=
 =?us-ascii?Q?Wz6Dbt3AUfWfvjT1NBbvMwbaWYWe2y/foHj66X8GsvWTxbaWVa4xqZWNKE4Z?=
 =?us-ascii?Q?3J8hW9NIqnndtZnwUvqyNFAHnTiV4UuutOOueHZ7nTZyZFxGakmczHn+MLAy?=
 =?us-ascii?Q?40rDm6iEGgzbwOL7/OOD/oPE+0doI0BwPKs+dX+b3B8aDN975P3yH7VPKYmn?=
 =?us-ascii?Q?V9I/DVRiiUbYbBNKI3nBZNk4w5zZVhNrK+XLUj9D7OPo5FDl1hOKVmJ4A25t?=
 =?us-ascii?Q?/RgX51LsqMhk8z7g1nbmcfsM0EwdMbggA93JFCXZo11tk+VPXlu9bidxMM0I?=
 =?us-ascii?Q?SWnkSiI05ZqTmOVmKSFmnUY96AY1OWWTZcuemOgsO3a4+nSugeeBAznAliPf?=
 =?us-ascii?Q?ys3uz/YYuEuV4TOU7+wZhrRQtXg9NIowALle4Y37uk6UXVEcbz1sQF0zAECe?=
 =?us-ascii?Q?DXuFuKKgNVY+/uzK24rlB+8TlrjDVzhsg2IE4QzqHYl7eS3byRvpAWc3zNQZ?=
 =?us-ascii?Q?LKAaVfqWLqMugRAYLa6MgvrhHtSjBal/OiJdA4tJOMvJVxdHenwvz3d6jgft?=
 =?us-ascii?Q?8PA/dRxQ4I0udBlW46K3eDSRb7183br55hZBSUVAr6ebGmkagV0QenVkE1lx?=
 =?us-ascii?Q?0/9xN5B52ZwoiLK5TOvKptyxywt2H681eYHRHUi99Thp/Z+uaSvTzGenWt5K?=
 =?us-ascii?Q?CV6gUiJ8/yTYS2igJ5cYj1YlJgtVocRGX3ZuPYgt8Cbb+zh1rgDyLxT0VNCR?=
 =?us-ascii?Q?YbmPNFh9/ZGt+o2IcuCAR22+IxjwU4ESHrcUujA09iMd86eBLarfUwpiCsfV?=
 =?us-ascii?Q?rFMwjFAOesYKsC96k/Z57AzhhIdIM9F049Rx9B9CRmly6B3ilWxqdGKr+7x+?=
 =?us-ascii?Q?ui1JlkzwPG4LUz40zf9IA/zta1vQX16OkVGgjpak8EJRAZDGcKeP?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 8deaab7e-0c53-4cc4-3a0f-08def1d9ec84
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 03:39:01.2591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ovG++Z/KzOJrXVrkwe35tJTsyDl9bcmiziuGC1P4VM8wUcpO8fCnpu7NSJry/wNisbvSJgGbfiqb12YaPD0bmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY6P286MB7598

Define the BAR-resident metadata format used by endpoint functions that
expose an endpoint-integrated DMA controller to the host.

A VSEC-based discovery scheme would be a natural fit, and existing
dw-edma-pcie providers such as Synopsys EDDA and AMD (Xilinx) MDB/CPM6
already use VSECs for DMA discovery. However, some endpoint controllers
cannot provide enough writable configuration-space storage for a
complete, controller-defined payload. Keep the extensible metadata in a
BAR instead, where the endpoint function controls the layout and size.

The format describes the DMA register window, exported channel counts,
descriptor windows, optional auxiliary windows, endpoint-local descriptor
and auxiliary DMA addresses, and a ready bit that tells the host when the
described BAR windows are usable. Channel entries keep the auxiliary
window optional so layouts that need a separate data or auxiliary aperture
can describe it without a format bump.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v6:
  - No changes.

 MAINTAINERS                |   1 +
 include/linux/pci-ep-dma.h | 170 +++++++++++++++++++++++++++++++++++++
 2 files changed, 171 insertions(+)
 create mode 100644 include/linux/pci-ep-dma.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 03febbc91a06..c503cf11b5a2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20933,6 +20933,7 @@ F:	Documentation/PCI/endpoint/*
 F:	Documentation/misc-devices/pci-endpoint-test.rst
 F:	drivers/misc/pci_endpoint_test.c
 F:	drivers/pci/endpoint/
+F:	include/linux/pci-ep-dma.h
 F:	tools/testing/selftests/pci_endpoint/
 
 PCI ENHANCED ERROR HANDLING (EEH) FOR POWERPC
diff --git a/include/linux/pci-ep-dma.h b/include/linux/pci-ep-dma.h
new file mode 100644
index 000000000000..73f72455843c
--- /dev/null
+++ b/include/linux/pci-ep-dma.h
@@ -0,0 +1,170 @@
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
+ *          metadata length: byte size of the whole metadata blob. The value
+ *                           must fit in PCI_EP_DMA_METADATA_HDR_LEN_FIELD and
+ *                           in the BAR allocation that contains the metadata.
+ *          revision: metadata format revision.
+ *          R: ready bit. Set only by the endpoint after all fields and BAR
+ *             windows described by this metadata have been programmed and can
+ *             be used by the host. The host must not consume the windows
+ *             before observing this bit.
+ *          H: host-request bit. Set only by the host driver after it has found
+ *             this metadata. The endpoint may use this as the trigger to
+ *             program DMA window BAR subrange mappings, and may clear it while
+ *             revoking R during teardown or reinitialization.
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
+ *          reserved fields and bits: write zero and ignore on read.
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
+ *          reserved fields and bits: write zero and ignore on read.
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
+#define PCI_EP_DMA_METADATA_CH_DESC_SIZE	0x0c
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


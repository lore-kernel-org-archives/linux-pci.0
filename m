Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020124.outbound.protection.outlook.com [52.101.229.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D5831E83A;
	Fri, 17 Jul 2026 05:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784264804; cv=fail; b=jDsJMo29SNcDfJyX3f36q8oCo0p4lTOSTc67b50f1+xz2mxfFpHFgs+EuMt2TXvQIQv4h8uTBqMuyl4vfvk2TyK3tSG5X/yPI/gWCTTHSneEdHtEMzpkE/o6D4Qw/RNThI9JfL+PL6ZRnVqdpMPgUOcen0H9sCkS9CZOeIFi8KM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784264804; c=relaxed/simple;
	bh=3Zc25+qZaSou+b+dB3YN+C3KF5PNO4K/ULgnBh7Qndg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VnslgATZ6qoffk5eFHjQpuO1zzmFZijNpNvLZxfP9pvYvsX2KiKxO3LM1JYXtbi9YlPh5kiTj9CAtq9EUvi2vGahTimlYKzYkDhhXMVlndNB1jK3OvI1PapLGF91sfqqWNZO+DNzbx0jdrE4pMjnRw6+DHt+gOnTE56MG/d1Ykc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=MyAc4r7q; arc=fail smtp.client-ip=52.101.229.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="MyAc4r7q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G9hBt/QOoZXdAmzkIkCbw1UCvN9lG1hYy06q1Ty9QsW4sPG09ehKV09nuN1kmkKUcoxgttEOakfoE7AqPrVuuZ25VHi3xFPPvXSdvVxSm9iYq8XXlapaxm2fpYuyqh7aVroz3Rcrvvpkbte8sCfmZ+4e/a+I7tLGydbcMwdFZDJL7BkMJlpxBGyaVd4D/VvUkAarhjwKa/Aalm6b1jrIl9HmaX4gmmTG1NiNepsS8sbReSzz642rfPtGjCSZJO+EhY2zLy7Swhxz84mdb24hmSDRfh03kcmaB6hnPYOwvDJ6Gs/6PjUNJRwxqeXhhKCKeHh3JhGqnsUQaC+bDWpDXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3rkShf1tU9ta1AEEBXpALu01P+3Bmtj3pY9vZQqCv9M=;
 b=D+XOZZTHTLcbIz2E2D6vh4i1VAmrsY9Sw6IPGgRrajp+fB3210yE69K/xjO+mrFikpZgZaYeM6BXEvk/gSXB4cTZ3Nbcq9nTDWTO64TOsK3Vewy07NNNQDoBrFv7s3NBhMEr8MrnP41CB+ejTdF62eGqzdChxu2Youz9QFsWxHAXoiyhKygriY4DnYc4riFADaaia0+PNt3i1e+u/5Q6pFOpVeea+6JALTvt/yyc+M2eOPH1D06hdP3/1bLsvacC/VqEDWHhSjlyHfnyPVhEfxKzPO5KqPBnlD95ge2fgMUFrBzzmF0+PIAS6PqZiKBxs4av4jb9jgEf27dPJVmofA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3rkShf1tU9ta1AEEBXpALu01P+3Bmtj3pY9vZQqCv9M=;
 b=MyAc4r7qBA9wXERZrRtxyxG+KU3o7O7JuyKpY1KxtYcxk1ej11dPUkec6c/l45g/8zW1DuoNhH6vakGzmjJRHGqEa+torCKm2EexFSuthbBQAVtCGpn9GD5dWpb2u5fv58sga83vfrhk35v8Zt2woqTOIbBQO+63w78xeSrmUHU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY4P286MB6910.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:33c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 05:06:39 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%3]) with mapi id 15.21.0223.008; Fri, 17 Jul 2026
 05:06:39 +0000
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
Subject: [PATCH v5 1/6] PCI: endpoint: Define endpoint DMA BAR metadata format
Date: Fri, 17 Jul 2026 14:06:30 +0900
Message-ID: <20260717050635.2145014-2-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260717050635.2145014-1-den@valinux.co.jp>
References: <20260717050635.2145014-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0131.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:37f::9) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY4P286MB6910:EE_
X-MS-Office365-Filtering-Correlation-Id: a833127a-8046-4996-3d7f-08dee3c12f2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|7416014|1800799024|366016|10070799003|56012099006|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	geBW+LqSVf3GUwiAcwCoptVHfwyMgv7MX4umb0LC6+VBH0uLVam/VPO2mlgJZcXub4ZH538Iosy88f5pKziy3eF2tRcK4VLqwq+/sRO4L8YdeaafvldQjig0IB/4DPVyX4kId3vVMkNrCsXVjtDNZ/cbpV13gTwrpk8wPvdtwmzOGvNyvedX9FlUD+YVEus3i971U/9QYGqPtjpMj3XUsU7NTz8uTj+Ae9rf+W/tj3Y8azfWwrC2dTFK8iee0tT/021qMZA2KfufjhBxeqbc6RIp1VdTrX23BBXcwahULs04H5+cyEtvHT37L/ehHFeGMcPNyvGQiG4/ypvPZN7iC7R0nVlKRhEcs7Bb2S+pq1kORGSHBgPiUDIlPcpKwpymMtG1gAQEUgfpKVSmX97Bl2c+WxcvwliRmOblbhVLAHowPpl2zTPslBqIMKxblI9dTciSeIXBviRLxu1ORYqXe4kKlluUedQ3shi6dG3qwDvBgpmGEI1s8ojGxPtrnEcDJerv33/OUcQ7EBEc8Y3Nvpt+lgAEuw0pwhTLE4zvazzToJ/TwOIH9S76Rh85yWcorFJ8ESt/GcIgQfAmxFhACMwGhN3ryzoW3oir8nBZDKsREYKVB4WzfRph3wMFo+uXB/BPLpSjqGeCC9sdJfW2B2snVJ91uoDWrBx/9DbJd9s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(1800799024)(366016)(10070799003)(56012099006)(10067099003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bQJ4YAgmQIZvqbd86BFMYrhui0wx0dUNu7KaqlCjjHL3N5bf0mcag0zdkttZ?=
 =?us-ascii?Q?lZJE/X6IkEygh/ZfUP9jXZQh0rqazkTx75WZwsbWesqvW/zTo6nHzAUxUI/y?=
 =?us-ascii?Q?Rog3nVfJ9HNEhjezm1MNfsA9Uc3M43qZfBq9sdQVvZSBhVOBHAfeDejYMjby?=
 =?us-ascii?Q?91Rr6UOpkLHtR6Bgl1x+BeR8H8hBXcw7O63MF/xhjYgOooizyE/tSIl8lf8r?=
 =?us-ascii?Q?Ic1AFAe1CYRoqj9/umjoQBwCnuSt24NagH3eW/beL3H1RiFiuIQfmBD/k0cy?=
 =?us-ascii?Q?c6fQa4PuQIujCKeVi9o8X6uY0a/zBnjdvYmH9SjQFIKsWJtIgFweL5H4gahS?=
 =?us-ascii?Q?dCqpvimexjHQpNjK0+n1RR0DchDBSjfGb/TUoGvsyX0QqjELlZkzpTFgI4AL?=
 =?us-ascii?Q?BB7aeTu/+dSXfa5T5i0uSCdaQtVx8xc1KzLh2lCIUoujx2knznk3Xlw4dOTW?=
 =?us-ascii?Q?I4O2krk2Q2Suh9jBZ76zVcgDiHofG+u3qeuuc36fRGIOJkV2V33CNn8bV7SU?=
 =?us-ascii?Q?mjnqtNEcZ4+mPXV4Si4AqRR6/l3WkkksramKtj8IghQBgl5/pOAjgf+Q3LkY?=
 =?us-ascii?Q?AgT8zJblvxlEtkZs5b6i3BCdjCjIho+eKBLuLM9OjbygXFupQfjyzaVy4TSq?=
 =?us-ascii?Q?DlL/XdVYdjZU/AT4OifDHnMcQKr9efetlSAAbO+bAaxMYEBOa+NtynS809nh?=
 =?us-ascii?Q?NfgkjBET4oGSLb6MyTOmzXSG1RCx6jYM6L75AyvNpBfFfmOEM5yr1O8C+4/D?=
 =?us-ascii?Q?sdgxkprZ1mVFXlSeIHQRAMbXOcSryX/6zd+nrHAHJ5dqkOla+9+p+8n+ABYz?=
 =?us-ascii?Q?/71BD0IBoHGICevxnh6liAUmkfv6cczcbKP/ApMsBIFFx93YqIWF6xJMKNXP?=
 =?us-ascii?Q?Pzvu+gDb8IpMqx5dCBO6RbJB7CbMj/JBpK9VykJzs6gWfMfCWOlW3bc6TYlp?=
 =?us-ascii?Q?YwX0mB9nL6q50puBLEvg71l2u14M7v9ENe5p+0bd1hRvHgcLxs5SO+fvk2yP?=
 =?us-ascii?Q?vFSYGrnELG+MBcPaXUV67EcGY8tBOxcW+5bL4wAs41i4TLF7yiqJD3DcGZnl?=
 =?us-ascii?Q?fhuGKSNSvxaGfFq53SU9Hoi385v5QckvtD7eDo1Y9yYWRffp1y/+kShDiSHI?=
 =?us-ascii?Q?kjJdqS2RSBACVRUQxxHbUMfINsDH9Nu8t9dZkYvvwBTIRwYhNfMMsAMbnMNH?=
 =?us-ascii?Q?CRShKOVamkpoNS7huh7T+iPVxmnQTt3tsnUSVWmqfqbElAEkEx7AQaFtAlwy?=
 =?us-ascii?Q?A6sjG7+30rjNrA+wUO99KV7Xf+07Bu7zzNxZZ3Ec6nn1hIuc2MYdbxmta32d?=
 =?us-ascii?Q?IQdtT+TDj9dQ7H/r7h5/6NEsqJOOWHSStXW/iTlJvl4S1pgKoSFu+lzjExJM?=
 =?us-ascii?Q?AhZ2RA4WhzVmZAs0bbEvotOm99IXSErCukg3Im8KVI2ZSfJ9JUnNJF6czLAQ?=
 =?us-ascii?Q?gkf3QNLTiGCrRRlSAa12g8T9JOE7YquaqxbjveQZBlSaOjFZp3wd+QmzcvzF?=
 =?us-ascii?Q?bGdkaEYYuYYYJsnLyAMx0nCb4kjqtd2uwpMK2LqEdRPaRV91XPK/DwIQ6Q3/?=
 =?us-ascii?Q?LvFk0d8RMMnhRcYpSmSVdo+aabfBMKasn+Y3rqY+abHBSGMD24v6aIHN7xrW?=
 =?us-ascii?Q?ElNWBGtqXixZxDf57uqDzOEe+ZEUrHmwy7n3IE1T+vDvtltnB4mCBdr1W6aZ?=
 =?us-ascii?Q?o/V8rDSszn/tl7Crfl9LhVJN58+i2ydZg6/3o85788gOQZAZOsQf0SUSeT/u?=
 =?us-ascii?Q?57EQG8M93zLRryf9TQtxBX1BxEUI84pYp2rbIQMtPm/CGMMvl2cA?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: a833127a-8046-4996-3d7f-08dee3c12f2b
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 05:06:39.3375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YxOk2YQRZbMbFLQ4glH0TPhzHq//yE1//y4GUUrCETLjE0ajE4fnXSayvTJArm62AFm9Vo/ImRW181PrIwLhSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4P286MB6910

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
Changes in v5:
  - No changes.

 MAINTAINERS                |   1 +
 include/linux/pci-ep-dma.h | 170 +++++++++++++++++++++++++++++++++++++
 2 files changed, 171 insertions(+)
 create mode 100644 include/linux/pci-ep-dma.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 3af0fe95a92f..f2f5a42c6115 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20846,6 +20846,7 @@ F:	Documentation/PCI/endpoint/*
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


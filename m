Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020080.outbound.protection.outlook.com [52.101.229.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E3A367B60;
	Thu, 21 May 2026 06:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779345260; cv=fail; b=EkCuFSA3WU3n6GQL+dwbOFtHSRyS47M+cD++HQ1CPT0sMZtsv7775AoFcDZBXq7XElpUXa8LKzAIt5VduVxZKOvKwH41f7OkBmONjUEAWtCtt43PdKAkr4PIwIrSDbW2UsspMYeVgxPRZHNMfENTX8A0sHHRB9eRyOaqN2Ht7qs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779345260; c=relaxed/simple;
	bh=1Em+v7A2cqwJhuhbGgZ/9MQNeTNCZT/+BfZeytcSCvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m2cGr7puhfAN5QpzZe3vo74LrIjYINkkJ+fMIuazbPl4NoZEwPh5UPbka99hNMCEaaVAiWz2P5oUJIO6S7s9Ebs18P/Zy3tegqKfSPOvJrnDuC4484Fd88H3I6HYOaWZWGnhroDCXgawd9HwkWPRhpUwgunWqGjhiim/HkuPz70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=amSZtgrC; arc=fail smtp.client-ip=52.101.229.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="amSZtgrC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J7ztN8dnozezS4w8RmMbKDgPfYIxWGudeDuEyxQb5zALp5Qu/Z1NiY4E7T026aNj7R6PVJxR8oA9MywLGRoorj8jb/obfdo45Zz7IcH3t25VSjBfIJAglEiJ8ObKW+62byDbYZaMtgQGNtsyDmkdzl2w8CJlCJZyl1Cp0GYGt6AJ9e2+sVMzMMVA9DT1V5EV8GttqqtMPjHtwVGJCWm08uxaiKb8aDsVqTJ1SrOcSbMvnCR3vroGnqwUkXEMVp6vcAShkOcf2uHzfaLcyFDG9jNQ4sYPAdzkqNpn5XTkGyWOcMmQYAbVt16HjoWIx6ANXPgq7ppf5AbLmexNua27Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q12hSfH3mna6QUA51Jv1Gmu6OuFyvhLGHx5Zc5qg0Lw=;
 b=O99cR3wTwc9VYC2PYT9IAUVFeuHNQXalkFhQ99OxgWzPlRL2DVGezFFT8Auf0OnmsVm48zwdp8WJcgAjFqyjfxk5uPdO9qp8QQLJp0J16MWdWr/MakRryztw+OZidJKCdOsxiO8hH0EiRQwlcW4oyioX1NPnx5lcZb6kW1JR8ARYsUAcdqDlqXkmrmtY6kxfvEbJM2Ize4/FHKI+OCW+onNGjF0/sjvZHPb2Xy+AdPTwsl6BSs502zmQrtO4kiDYALo00t/yYBe1Um2veU6AYyMiRQHqLGNs66pnkMjQa72RQJB7Dh7CZkykvwz1CSQBVJHsopoUx78DFeaR9YVJLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q12hSfH3mna6QUA51Jv1Gmu6OuFyvhLGHx5Zc5qg0Lw=;
 b=amSZtgrC6QsperO3w5VJKFf0k/f0OtLXyc+idoWh94nr9+Fj9N3O/aG/SPLK2Pzt0KmADCq+GIutvYYZZhjEQlLV92aRB/lUOVvOL6+rRs3pBNKZWvp/Zg1aUdfk/TtwZbm4CxZtBSYvrw71yo/290xXH9IPPK+Pj1gGZ0IOS2M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OSOP286MB3955.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:2f4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Thu, 21 May
 2026 06:34:14 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0048.016; Thu, 21 May 2026
 06:34:14 +0000
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
Subject: [PATCH 1/3] PCI: endpoint: Define endpoint DMA BAR metadata format
Date: Thu, 21 May 2026 15:34:03 +0900
Message-ID: <20260521063405.2842644-2-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260521063405.2842644-1-den@valinux.co.jp>
References: <20260521063405.2842644-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYXPR01CA0058.jpnprd01.prod.outlook.com
 (2603:1096:403:a::28) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OSOP286MB3955:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cb93583-11e6-48ca-6f22-08deb702f9f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|10070799003|376014|7416014|56012099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	DDLNUcvt2LikB0f1LCxDBF87EgnZ0QEecm5RlDSI6hjf2irMEKCgb/7MpOTJojUGIjIZ1cGzTK3usXY0yUWd8n2i9q4a3ubUP09+ii4V+WKFaPIp5/Q32iMqGI0TU2UchOqy3Twp1NpGBj0V8+tOhkHKRARbFMwatEEXUYnNhOVsJ/xmF1MLvmh01uMNIzrgSslDPgpxn6cX6KFRv+MtmBXONeyUF7MXjfiYbHPTOzz5AzvDxysdcviydsmSDDMJfyVPHvb76eYvbsFFuUehQGWKckO/s81hCOcuJbxVTrNuYXtEE3KP2ybBXB7Ad6rAIYG6S+kTBUvE0pleZNqtoSshxWZrFrfSvlJoQS82BlXQQkUtb5UX846obXqyxCtQc4D4INGihu9jXeLitqPRLVp/OJ2+buHqPk1i4y9sYLMyykwxyzjgjL2b83LJaEhgH8frGNxaseZtx8hhY/4wwI7EoADr2vRpUkIlJExmqJ6nabFO6W4X709JOTTMVulQXbXltEo3/6kh2i0lrOPCliqGzUc7aCWGVAV5cKJLK1BXBW+TAOCrgtolOXFjOuYMfO5kd8veQSwd5x8qR18vZIn9l5ijZTEBGlM7F/QLh1kRfRpmeGVztAPhKTxm1ZrDnZN5yJTG5V7tyvvk8Q3wLyvPrAKRBvPxWwD4yZ7Jj3EI5xXu9ac8Kd0L6WVZJg0h
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(7416014)(56012099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0QGcAjFXv4z6bNCCQHevRfXgT/UVd1AhqhHOj36zOXoXSVuwNeBEcbW/U251?=
 =?us-ascii?Q?Q/FlviZp1RoUgAcd/geP3jE9MneLZETeZy1Zm1TxGSqfVSTS1SS3inUgdjh+?=
 =?us-ascii?Q?pTzyBTiJau+Pef4xD2Wnb/+VwhJAncPxOTjoUMiqDLKn5X745WibuNUE7VPr?=
 =?us-ascii?Q?dxpvubyRjnw5G1cBanbBU48LYOphpe0n6B9ZhvP8z/FiHo741GiQX2eX3d06?=
 =?us-ascii?Q?LhiFdWHAE8VU1IoCFRr9QFsSPfJk79OxRzE4/aHhAJ90n2ixKYzHnye0k5ln?=
 =?us-ascii?Q?ppDUMEDvnm/IZF40dw50v8bHF++PdhKHHXHqX8JpFOOWsVue9hKtQXVPn3P9?=
 =?us-ascii?Q?h8hl71wmQ6ican4jUs87iUNvPw/VZqBj4F+Kr8trN4jpZcFkluT68w2gRvPm?=
 =?us-ascii?Q?KceDySZd7O7DsAEuZLrOOev5y0fXKyzoGDZ4MotbniK2jq+sziFcY4ED/1mg?=
 =?us-ascii?Q?rOxjTABAADxu4u0J4Q1qwOwabDI/crxvbfruM7U4clWjH3MRLBopZ7ltZFGy?=
 =?us-ascii?Q?I/sA3qQMLDVtduAo8lR74aStwakN0xoAh8hrDfsHN4AkT++E6IzR/HgVoH4q?=
 =?us-ascii?Q?WU/mmo+tl9KAJS61mJH7Gl8TCCXOAOe8cTUhX3GvBL/WgG8XIFL3k9I5Z3t7?=
 =?us-ascii?Q?AfQHRiHduxWYpjkc5QFpY9SmTCSVBllGITCbDBgsccOXhxI2cVW7E9rZd3Xn?=
 =?us-ascii?Q?neffhwCA/Jic4XJY0sZ5j5Zf8FstRmskAJ+3tjs/ta6zSNmHuAR+rqw753R+?=
 =?us-ascii?Q?B6olkDcbB52QXR7GNoavTZu5ylNaqNQS5dKPAgsQxOOZ6dkldfkeKzADhT1u?=
 =?us-ascii?Q?/s+j2wKhW8lVoucvtX1t9/JW7mod7qVi8LGk4cMbFz604kLwjKH9+7+VQmZo?=
 =?us-ascii?Q?/ZyL06Qdgg7QWVtZ/lMsiSfbaqW41aYXUbeOwcFcaPy9Ea6jgPmoH/KAoTx/?=
 =?us-ascii?Q?GXiZc+O/hVS2Mx2v01zX5m8JOlShNEoJH4YVaBaORh5fxN9TKfzHBoi8RaKl?=
 =?us-ascii?Q?WZQXl/T3KBbMEZRONFHejqOIWEIlMwUcmSEIPih1LyCS9AXZMiiydpDZoUYu?=
 =?us-ascii?Q?+n2l81G4KIUJXCFA756ppJigVffGVQuSwl2w3vAfFTRGb6aIn3O3gSk69AJs?=
 =?us-ascii?Q?0NyURhtsuJ+EGs7gfn3bKUyclrrGuJ+vlJCKTcFv9nldpDK/5+l8N4JSqLse?=
 =?us-ascii?Q?FkmHzQ+pNmQYTjGXd+76+CM0JGhOLIBchMv8MY3FYXoStmiyHo0VDYDhSp8f?=
 =?us-ascii?Q?uum73mwns6dqtDBcXlOxO1UUvK6FYpVDbAMoUzmMcZnPvZuZD6xejiaw+tSm?=
 =?us-ascii?Q?0FeSrPJjyN49BZyaoAJ9wg5yRk1s/2zXDdwrjbZ3fOUpyUWejdnyKvt/dr5G?=
 =?us-ascii?Q?Odbz/aQHh2wVHh6LxCKwdLsZhivlRcUQP+a61lvYAFPMjqmbW9Wdk8GjqZzE?=
 =?us-ascii?Q?Zd28utRfK61bC/mAs162+1MVkmuDu+9/kGHQo1DmMbcrZIFtNOLY55/GPfum?=
 =?us-ascii?Q?nHTPkR4kQSvsy9FvRMKfyj97PAVP4hvZO0hC6N8qBPwlyMMYQtg0rjRsBE2v?=
 =?us-ascii?Q?ax8cB8yT9Dq6D4qGlZlHmT9slOP3ZQmHzOSpOzgf1pt3eNY4jaPH/efWgwLf?=
 =?us-ascii?Q?g5U4z8c7vnR/Op5ie5lDPH2UzdRRU8h8cX7Ad1YU59orCR+XbjyqlSbTpPWh?=
 =?us-ascii?Q?2r1zT09Nt2Hsv5Z2rOLEpsufylqKJhPOSTDC55eh7c4KcG0Sn3W26Rf0i0fG?=
 =?us-ascii?Q?ffUVMj0wBpa6aMIgR4J4KN/IDVeYgSvv8joYk6I6WO3C59eHpeXP?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cb93583-11e6-48ca-6f22-08deb702f9f3
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 06:34:14.5198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M4QfjCIW7JiPawgpa1AQOuNtLpgcvGfelJ6DSGVMp+ZdJ9UqhlYTkKcoh+XWmFK1C2gqIV+FLkZWAtvBlPNlcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSOP286MB3955

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


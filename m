Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021139.outbound.protection.outlook.com [52.101.125.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92AD941D104;
	Thu, 13 Aug 2026 06:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786603093; cv=fail; b=aY3i5/wLNp3MT99Usj8mPAN1IqtEw9E97PKArrtN5gJgwbzf6mM1OEf8EXiSh+/23SBpwICfOHoAkg6gW0mNn10UgWabbTsPJO36gHo1srdVlS1+M/vB7CjdBa5fU7Lyio5FiV8A1D2VdAao0MZizvlFhQ2NLt39wsnOqkHTZ54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786603093; c=relaxed/simple;
	bh=KsEiFcPYPREGgiqbd01ZLs+hu1aCsJcaiGPY4z0UjUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S8awC4aal3U5/dvsbr9fCD2ANTDprkyFVwjsmh0IPVBHL7Ce8jZkOAbaMPIw3pdYjQT6vl75+kKOso+ILUQ35OSZa9prCHJNnqKcpw5mpsugOKIHw8NaJBKtugmLc83WfWSL5HBjt3+2ZXF3VubMzZulsDxU++Au5xUwn8mJ+jo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=T3vRom5e; arc=fail smtp.client-ip=52.101.125.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="T3vRom5e"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HvS1sm9tWUp1f3MnDg5C4DRTKsPZAbET4kIZFiRwb+aK/T7Ne3KJIBY2/SEkQmqIslkBgbZDfcF3erXDWIKr8u90Dhsf8NPJushVjTY0oUodEcx9hpRio/DRNxUCCX8oXlk5SbLqEJ3MeIvXbxf9W5936Lhioaa3cq5ebeFUUyxkvTtAir1vIg/oCs/vIzdICO31aj2R/7A75xHOG/YGk7C3GJTrm93XjiGpRR9QgoCN7/hY07fi/ebk+uHgzuIgeQcEq+QgiPcC8YooUQEaeqKK0yzkvZs6jKcq7hBzll6/oUWDiIIZ0RZ28fnvgE8Z0a8T23/2+TlRzWgaWNZfdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jeHwbqUwRuylskbrqymCOxQk1OEHl+kXAprqP0hyLNw=;
 b=eWCEGXzZBEmse8/fFIpzhwgkn2lwsZfwASzBxzjANwK62kPucLxbOHbqr+b8IMArRkNmcZrXSHu80a9N8Z3GaaRf5hmN7v1QNN8fT7txuqm6Ep9IvNpNFOZgXRPI4eWdvK5C/BN9KDpSWlUYSrQMyfVVemLdyPyAuF2uKOIe8khG/jbMcFHcUJGDZEiuQ3b22x4XM7rcgsbrgIjP/RfGwjIUAFb81nHzHbaKcI3q020ZGofKvQBLdOqtw4vvRHeOGJiub2XD+h1jnM7UJTijTLkWKZk/UAD2bnwvHg5ZkkvDSrU3napx+iDt0D6DZlpMWnL3ZynZeUqQBbVHk28hfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jeHwbqUwRuylskbrqymCOxQk1OEHl+kXAprqP0hyLNw=;
 b=T3vRom5e/DyvBnKExb2kbcAKRlyjZJvgtSVwyP9JCu6OOxnQ8SL+nXqsTeWX0s+pIR+sGJAiV6qmT7688krj69c2lrYBu6V2NE24qaXzKS8eIO1lHV+BI/IP7huyhHmiLzno9DpuxLF8eNzDtiS4KtMzhYWfVVJQC+/NBgVD6Iw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:468::22)
 by TYWP286MB2252.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:13f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 13 Aug
 2026 06:38:05 +0000
Received: from OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
 ([fe80::b7ab:6af2:d18e:4a71]) by OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
 ([fe80::b7ab:6af2:d18e:4a71%6]) with mapi id 15.21.0315.008; Thu, 13 Aug 2026
 06:38:04 +0000
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
Subject: [PATCH v7 02/10] PCI: endpoint: Define endpoint DMA BAR metadata format
Date: Thu, 13 Aug 2026 15:37:49 +0900
Message-ID: <20260813063757.3131865-3-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260813063757.3131865-1-den@valinux.co.jp>
References: <20260813063757.3131865-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0042.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2be::18) To OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:468::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSOP286MB7730:EE_|TYWP286MB2252:EE_
X-MS-Office365-Filtering-Correlation-Id: a5d9e0e9-23a3-471e-6f47-08def9056df9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|23010399003|10070799003|18002099003|22082099003|56012099006|6133799003|10067099003|921020;
X-Microsoft-Antispam-Message-Info:
	ZE0yC85kgXH514YYFGoHxYqZBqDr5wiUO94VqGlNiPILr1+aqsGsnpyW/iCgci/1N+X/n2pQZKDDMkAi7t2a4rECC05CijA9/eQ/BRct1wmBL0mJvQZQteJe9ZG4Y2mNuB0xu47uOkQHdZAw7OFCNHJQQr4LFoPjCArtnhnLrCaOTj1FHYhdU5zuXq1SWG25mMJc+EFO71cVRmP7nlT86jq32IAC9yPprE7M8WfbJY4rMy8NUeh4RTJLOJx4yFM661939HzwToZakozIb2ZmhXG22xyjC7yTlLSPcBT+nPzPpxiNu90A+HCc6n9PfjVHye7BVAnkoL3ll0lj/REq0ziEk7BCBBa9F/OJs1QokALLjNGRlMU/sEx84YR27xyQLF1fmAhVf1YP3473353xtLm//oL47fY6vor4+iC2WLLe9Om5x84g7xNdkbtBAF2u7KgLzFGR4F0mj76NX67SRM05cmYIyxXi5deqsghXrVUdnWI0JHv3acMpnkAKntDk/9yze/PyWB4IvH35ZbHMROBprgyy4q6xFzeqzDUwCsW/MWSqaojt2EBcAgKGxohjmR3mki7Rh34hJ7pngJq2Erj83kuP/IQMrMQTC0hypqtQCqNWses/rbsbATE5mjm58ndctk6BXkzxrah7sUsvtxBfiIE+/V8qO4gHC5zMZ6zZWS885dlZ4oVmd5/qGuwHx2R/uNb+/3/ljBfq38w0SQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(10070799003)(18002099003)(22082099003)(56012099006)(6133799003)(10067099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?viWu6/12awUvKz40oPUgtHMHaV1PblHhiQt6x+M+87EwQolCXi6+ZJ0eNiBd?=
 =?us-ascii?Q?njicgLilWp5Upf7HO44Apu+T7O0kYvxNoaebyPOeuGr5YYU4Vlo/Q02MyUwH?=
 =?us-ascii?Q?aCCtm1sgELblkmT37UjarKwxp5lVUBE93l+YhhdteBHnvFv57hdKB5o4dIl0?=
 =?us-ascii?Q?9wlLmSSbDfFUEMBvb3+oiu4lUp0v2DRLoSergTIfQVpoJcbR6VZsWXCmkpAV?=
 =?us-ascii?Q?EfODW1UY0vpvF5DMJa0hFg4T/ig//GG05e4QlDa8FTYVh4mwJ4kBXrr06TPy?=
 =?us-ascii?Q?nd/XY9cJ+zf2Ouaksxn2rBUDD8R9z9za6QsH6AA6YIBzvvbLBwIYlGskXV1S?=
 =?us-ascii?Q?1pDedr2smAk+aBrTjgB5akZ137L5pAuEtrErM10yuP3yzi33Dm/5WatgfFMc?=
 =?us-ascii?Q?zxwtwycYFRz9pXqlCicWFtHURlCSbXLQQS7LHOK3SkwkvI9RXYBtcQeBgf4/?=
 =?us-ascii?Q?W1toJ5fpxJa08UomcJnGNYcjDQewj3S+HH3qiVYaRXZNieeNVuDTlmijOD0L?=
 =?us-ascii?Q?3KTBGcdtz8YT3ovUzWPjxI6a0xJop7mOkXELnkmEif6d2Ecy1rsTMOJZgEwY?=
 =?us-ascii?Q?zfDqe66UNQdavWPMGJ8HqAdYSIVEAQtbivD5gvKF+LiqBKuOYh/PES17UT40?=
 =?us-ascii?Q?GuMtE6bIROB4HeoeDElaifPGLM4eEjyuj0qyfQGfeNwZZk11S/tWlXYq0VWh?=
 =?us-ascii?Q?BjdqSY+oEnc+EyUnGXOvnwAhv81qRq1p2weDApvhLQxhRJio9z+6CLGx8u5G?=
 =?us-ascii?Q?sb1C5Zi/KwOOUGYG2awEVAKOmf/0Y4OQE4pbt7ve8Hss+wcVH20sYZhrIkhg?=
 =?us-ascii?Q?uij+aD5R+Pi2x9T51HYPBU0vIBe6V9My4wwxiDgfhm2nIc1SbhInVCEt67tn?=
 =?us-ascii?Q?QvsTWvUqV4Gax5PPh1xWyylumMD7MmzmQA2tpOAJLpqUoR03y6+z89gFYsi6?=
 =?us-ascii?Q?R/qG4vqcqkUokj7IuMKwZNFp4T6yT03JC0SQMEQy7g/IRRSDfopLTT5GXjXF?=
 =?us-ascii?Q?2rZEpj64McOD2+OXR9fDXrpVZ0M50D+YTZBjX3AMcJAoT2ebXauN8jTa0sAw?=
 =?us-ascii?Q?w8nQC3xf3Dfkn27BcR0WFnd9g7bH5e07G8pl+Uy8VSlrvcy+YMS8PLsyO3sO?=
 =?us-ascii?Q?R5nWMDDmOsMB+ygv+r/3PcPtnIN/o9XStganjq13N1CdDFpn/dyb+ByemP+R?=
 =?us-ascii?Q?0Jafy7hOYfn35HhGoIsB7rtj33arcdSki05NP2g700Y0oEkNVImeBukdDL+D?=
 =?us-ascii?Q?MF3l8X32UWUDsh3IgMXRL/hPHI2TqAPJflYysa15GmwfqKTIHdtYhqhWnYkN?=
 =?us-ascii?Q?vI0JfpN2VKi7RhQacUIUaixTMGefXLQrBUN9xUEEWSrEBprvC4adYZpOE3bg?=
 =?us-ascii?Q?Gf4jACCg2CGh/st5aXUYF9sUhxyeeM+mAomiaBzxUW6v63yHUrX/isq2V8Nr?=
 =?us-ascii?Q?HeZF6oMJgD4EAyP2nsQDFCaymZzwAAiHtp4+kQ7P/9c9qfLMoM2rP+Z5fPci?=
 =?us-ascii?Q?LwNL8Xh9gi5v7q9NLQH4iA1flfXjJ+BbgDcUNCzzsG33A+kFC7wc0czH37vJ?=
 =?us-ascii?Q?n9+jbxTT/V9MneKCyfHzNjAzk5TPYe5NkhAC2qBeLm+G9H0ApnFY/OpPCzU6?=
 =?us-ascii?Q?SLuEIZB5h7wQNgbTNQ3p/5ENWD4ulWaIch1MlEWOaZYwbCQ/58i4LSI+cqSJ?=
 =?us-ascii?Q?fyVJz1GK6x6iSuSDjbE+/HqxL4QuA3hM1pzb6AnnXE6E7apgfeUsRDgLpX3c?=
 =?us-ascii?Q?S5HdvR9knLEoVije5t+c8gYumrZxSQsYtQmJzApBCzUC6N51R/0A?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: a5d9e0e9-23a3-471e-6f47-08def9056df9
X-MS-Exchange-CrossTenant-AuthSource: OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 06:38:04.9189
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T1t57x9FGnwTiXH60LUWzafGInKsff2d4yeV2EXhbd8gAXW7bt1EEifzuwSpj3AS4vCzOB9CT5yTTd8X2W3BLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2252

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
Changes in v7:
  - Move HOST_REQ to a separate 32-bit word. (Frank)
  - Increase the metadata header length to 0x20 accordingly.

 MAINTAINERS                |   1 +
 include/linux/pci-ep-dma.h | 175 +++++++++++++++++++++++++++++++++++++
 2 files changed, 176 insertions(+)
 create mode 100644 include/linux/pci-ep-dma.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 15c7dc516f7c..d330178ac1f7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20990,6 +20990,7 @@ F:	Documentation/PCI/endpoint/*
 F:	Documentation/misc-devices/pci-endpoint-test.rst
 F:	drivers/misc/pci_endpoint_test.c
 F:	drivers/pci/endpoint/
+F:	include/linux/pci-ep-dma.h
 F:	tools/testing/selftests/pci_endpoint/
 
 PCI ENHANCED ERROR HANDLING (EEH) FOR POWERPC
diff --git a/include/linux/pci-ep-dma.h b/include/linux/pci-ep-dma.h
new file mode 100644
index 000000000000..03b48ee7669e
--- /dev/null
+++ b/include/linux/pci-ep-dma.h
@@ -0,0 +1,175 @@
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
+ *          31                                                             0
+ *          +---------------------------------------------------------------+
+ * +0x000   | metadata magic                                                |
+ *          +---------------------------------------------------------------+
+ *          31                            16 15            8 7             0
+ *          +-------------------------------+---------------+---------------+
+ * +0x004   | metadata length               | reserved      | revision      |
+ *          +-------------------------------+---------------+---------------+
+ *          31 30         27 26          19 18          11 10          3 2 0
+ *          +--+------------+--------------+--------------+-------------+---+
+ * +0x008   |R | reserved   | ch entry size| RD count     | WR count    |BAR|
+ *          +--+------------+--------------+--------------+-------------+---+
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
+ *          31                                                           1 0
+ *          +-------------------------------------------------------------+-+
+ * +0x01c   | reserved                                                    |H|
+ *          +-------------------------------------------------------------+-+
+ * +0x020   | write table                                                   |
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
+ *          31                 17 16 15 14   12 11 10     8 7              0
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
+#define PCI_EP_DMA_METADATA_HDR_LEN		0x20
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
+#define  PCI_EP_DMA_METADATA_CTRL_READY		BIT(31)
+
+#define PCI_EP_DMA_METADATA_REG_OFF_LO		0x0c
+#define PCI_EP_DMA_METADATA_REG_OFF_HI		0x10
+#define PCI_EP_DMA_METADATA_REG_LAYOUT		0x14
+#define  PCI_EP_DMA_METADATA_REG_LAYOUT_ID	GENMASK(7, 0)
+#define  PCI_EP_DMA_METADATA_REG_LAYOUT_DATA	GENMASK(15, 8)
+#define PCI_EP_DMA_METADATA_REG_SIZE		0x18
+#define PCI_EP_DMA_METADATA_HOST_CTRL		0x1c
+#define  PCI_EP_DMA_METADATA_HOST_CTRL_REQ	BIT(0)
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


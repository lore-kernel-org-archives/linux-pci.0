Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021087.outbound.protection.outlook.com [52.101.125.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179D12773E4;
	Sat, 20 Jun 2026 17:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781975100; cv=fail; b=A4vs4cfH63KcdKM8Q5YThFNOJUh1Lm4qatPErV1HvgI8nS0BX3YVXREeKmx5HTTZDqULvImexgsRzDKYOvdDKKFQMFM0XGI+DfYMem5DCVq1wVrk75f6hwN7xLjc7KqUtcOjoF+vgsrDHtL7orV1NltVoN7MI2LZ//CdridOkf4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781975100; c=relaxed/simple;
	bh=1BxxyVilqS4h8isdocqHZggNOvXr84dWfv+OyA1WgxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GQWAt3oyGhhvmLDPHq8RBKNGDF3EcrDtftGI41rP0n3RQa0EAHtiomCknWEKFDLLIYlYpPO3hrMJ1x5f6CV2mq/q4TT0vj/QxHrjChnFHF+AK1V8qpi7CmTrqpK57Bn+Q4M/5vGo1eDp1+66wzwsEJb/PJg/CXODHAnWkF8LYW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=bOWp4SPy; arc=fail smtp.client-ip=52.101.125.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="bOWp4SPy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EEBP6NqD7HxUBVddFOE4UEG859G4+aRcyKvq8XBHP2FOIDUyb2cxFCuVCklnivctNkXY3U0h0hMGz19AczpBlJKpikinNZ8gSnINZQaKmMgk+cVoYFT3I0tbZlvwe6wmyy/69rW7tODWDFAz52W8L/ShVmaUPSxamevi4SqKQ/0rTMuYyTDj+Cq2BzY8NGJUQZIRxeGcskb5AhLS5e4sxL15rA69DetqoE1WCFQy5bH3WDxUNeIuJpyXT6fN5yZchKqh7xaQKBh9WxaPHxA9bvDaFn0uHYpJ3l/oISeKoteU1iyZrAbhw9rcY7hnNTe0gxcKa763dMHIB4Jsu+lICw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cUqCyOnmyx208MFS5OM+a28WAGuDxA0qLdQB8uGnoI4=;
 b=Tc7VQCUO8NEMbS6eJU2PXsopLEWdDoGbJH94LHAHHC703yqfaaEsE2vaFvfUT4PPl8Zl3A1QqZU1sqlJN2Mpxrl6Tj7fCQeM1ajdyr3vWa/IA90XTo5E6Ahn0zeO7AfcMQcpatIiOBjzp35W+fH8Pcu7MxrcOLgN8frYrX4mhzO+8pmWwqL3UNMCh5rceieqUjtKCg2O+JkbH+Asqo0fBnBelLYE+Jk6osh6TP+yPmLyK1LLREncwIeXxLuZwt9U0w6PuCC14+H+biWq664PmDAoSeOJJT3sg1CPVpzoqmnyncmMBMzN6NKd2aRlraGERjmQgyQ1CeByBe7DViJq7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cUqCyOnmyx208MFS5OM+a28WAGuDxA0qLdQB8uGnoI4=;
 b=bOWp4SPykEn9owGUOEQ5qjWeLASX5D9bhohSQBW3HHbF4DZv3e6CjHzPSltXN5WDtA0zvEnTRwcqXdxzD//QfsB+w8GuzQS3G1O79uwjwgQLyX2mPtqW0xYLEEueITbvYmVT4t7Ibw4+KEMWlaJqJkm5lRFTkvsLzXD3oPh28yo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY3P286MB2673.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:254::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.13; Sat, 20 Jun
 2026 17:04:56 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0139.009; Sat, 20 Jun 2026
 17:04:56 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v3 1/5] PCI: endpoint: Define endpoint DMA BAR metadata format
Date: Sun, 21 Jun 2026 02:04:34 +0900
Message-ID: <20260620170438.3756593-2-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260620170438.3756593-1-den@valinux.co.jp>
References: <20260620170438.3756593-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0053.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:36e::18) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY3P286MB2673:EE_
X-MS-Office365-Filtering-Correlation-Id: d112359d-36f0-416f-aa72-08deceee0dea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|10070799003|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Q/SxBGJ98abeM2KE1QxbAiJq8JsbTx6lSNID0YHcmezam0FdY3cZItdqpqq+s+s2J5iwo/4UxOTM5v/AxGJJXzZdjVbBgEGwCm544cBjdEEOKgxn+QtqmMkCdUuBEekMtXtVKuVfWNNA9YMZH0QFmgwROPTDRJyC9HyfOj4YO9jPJYSEUawZNqQC8mO54N8mhTmKYpfnwoBtOcNJeOy9+DpYI1Dden1KHBophUdiniwFc+jSa2/Tw3Qan3xNlR9NBB5vxx10u5RoVbRpxUEhxwRhElm9rOO/iV8060xCCWKS7BRNGd1wNXVTM3KYEmTjVO3PRinW981EtqrDNaIj33uiJLYV2VnnHzimeVVPwP70A51IGxVx5WsIQQDopa5UjJoUHDRbF9D1T+y32/kPahuG5W8n6F4+I5sZHSU0snkGmAgwnQ0RiksgjMBmKMtWfN/tzhalPh/udoJ1KdpDCWrbuCZ+/rENXu8L9r/vNnvNDr4y/JiU2P2ALZq0es/JbAt4DF5Ks30wYgWc3AGkDxSBmvrM0piL46cnkOJLuBGkavdU1783jihz2oYpzuMcVgrwhzTK7rD2Fr0psWCV6XKPpwo+bv1WWkZSDoTsqVT5E52oryZHgg+t3gw0oh3Le8MgeANzrbwK+ikpzLmV3WJITTqoOPJ+xcDkhjcQFPw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(10070799003)(56012099006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Pc0oehOIXIfggzyDt91RNbjMyl/+akrExV2k637AuVkjgx4cXVwqP8kqoIJW?=
 =?us-ascii?Q?xhzB63g+z1ahSVGwNh7pupTa2UzLsZW+wnuNA5ZFJAviW1Sxxoye2aF8Cobi?=
 =?us-ascii?Q?5/KpGeBrs1fUOo8i/fXw7YF96JoA+GG3UIQ31y9ZR4AaeFCAWLLMHGHMzgUZ?=
 =?us-ascii?Q?DC4hMgwpx8V+hA4B24+ojTl6JFmXsdKoRjVZLa6KJABDcgqh8Ze4BzjnNAw2?=
 =?us-ascii?Q?qwPhGhyo+zsXISoJ+e1kZId6sJnO9J2F43N+OV3kYGCmdcD43jJvKeM/18VD?=
 =?us-ascii?Q?/o7WLq9/G6/Iij55yAjpquW/QIBJUlUWDbsqhAh+/kfKPHmAKmYXxCIq0HZV?=
 =?us-ascii?Q?/m0mWKGbLzmpzg4P4DP7K/ITbbv0I1vv7UqtdpJms+zyVWgFzhrLDdceG72d?=
 =?us-ascii?Q?oaHK78uBUaC7AwGkzNrJVVaOR8fsEvll5KGpqde7aQ+ycSaHt6UJWMh3rUUi?=
 =?us-ascii?Q?R/aJbUIYWQKuT7sb4lfUqzZw0YvndDujhTg/Pv1gFeX/nkq7cnz3G+o4Oi+e?=
 =?us-ascii?Q?X7tGTFCOrxXPmbI/xVVo6Z4pbYyXRF0qBR+xIsz7YPytlxeFDjSemqY21xTw?=
 =?us-ascii?Q?qpoE5h5SRvbpn/wXn5+Gv2einJhr0nkvg5t/SapvAw576QMxlX41lqlrl/JA?=
 =?us-ascii?Q?aiwVe9QtPMt8tWZyrba5Vv36RmrbfamLhjXQoLkgF7HCdnmU9O4ZG0HO9bOC?=
 =?us-ascii?Q?fjBmU/DpjWtOoPexioU3c4ByDDmnh/sSK8vbwkCrdZX7Q9hZ++y1iXqU2L1X?=
 =?us-ascii?Q?I9QEYjg1HF2ebrapvfppgXUIhO509TPFS989SIczNodWd+4VIwmKfOWCEiUl?=
 =?us-ascii?Q?PYX5eAWdpTSM6feSy084DR/R/dmVLdR/gKv0aThLecz5catqJs3VBFnN9fVG?=
 =?us-ascii?Q?ybIWBYdsOLbIgASS0BwTsKM/qBnwfcfgxIciymMKwRMMLE9aFlO2A2DdaSvc?=
 =?us-ascii?Q?M40n7vyQ7nAZoUozHAn04033z+OZ7NF5ii2c//qGe3jPBz1oGc8o/PkyKqYc?=
 =?us-ascii?Q?sVsoQMD0g3etofo7BZVqoYZYHuVUc0H7NP3b5oUPclHjrjFn41nAY1qR7nTN?=
 =?us-ascii?Q?xrROLRODdlex4qj+9STXcxDwo6d8acji8DaPGwvViVsDAnxEyTEmJBjqEelq?=
 =?us-ascii?Q?5yFHDrYuwUElUB98g6wLBx/IUQkiU+XZgPBC+I+vUW+IMJm7LPaqzH8a2H5B?=
 =?us-ascii?Q?eWCKGakYZoG/OIxlQm/JukjnHYhznefDiIGaVg1ZXPxzaom71m08lUcFQsNt?=
 =?us-ascii?Q?jguq45ZCUg2g1gPUGjrMO6xx6eR6vO8robjHvSwEp47fpfP45bAGVjkR444t?=
 =?us-ascii?Q?YXnAOWun1w3pA6xseC17Qj9i/RfoZ+fvO+u9L4981mj4u4x8dw+7tZzLM6bD?=
 =?us-ascii?Q?mHO7N8ExTSVIVoCJqdavPOAjycyxAzSaPYL2AccsgMJMn9a/Gx5AznV4E1CW?=
 =?us-ascii?Q?Ymh5h4xwzsBbEPTHTx//m+8peQoKIHym/mgwW33qHfiTxXqMSsNaM1ljoj3Y?=
 =?us-ascii?Q?bRsktWQgbFTsOWyYJmtGW8UVJmvUDf6ZrEnN4XIX0fSCaXZPFl03x9DOa/4B?=
 =?us-ascii?Q?ZV8VHTIaPEOZb3vCz6qg1A+ilkE6792GcpOv2tsffXHy57DkQThxdCQDQ7HY?=
 =?us-ascii?Q?+8J5DpeLH5Y/3EikQ/yU8nZ1bODEsoOWxgnIY3nMVUl62GAMA0vygJ8FbQl+?=
 =?us-ascii?Q?WfJyn3yJK40NiBe3fRrVfdwab/AF71fV7ZbLE4ZDwiDw+dOxHTgOl5V3dbo9?=
 =?us-ascii?Q?YQPwCIfEAEvUVJZxfYKd7lAqXHoPBx+oGVEijFe3y2vHB2pEtPra?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: d112359d-36f0-416f-aa72-08deceee0dea
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2026 17:04:56.4660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Ua/EX0pXbTXhARMePxQyhdLAJJo1bUeHKo9YvaxJ4BGlNgS5UqiZmMEy21eJrd/HfDVGvIoE+nJ62HdMVd8Iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB2673

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
Changes in v3:
  - Update commit message to describe the AMD (Xilinx) CPM6 match
    present in the new base.

 MAINTAINERS                |   1 +
 include/linux/pci-ep-dma.h | 163 +++++++++++++++++++++++++++++++++++++
 2 files changed, 164 insertions(+)
 create mode 100644 include/linux/pci-ep-dma.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 895a87b571c3..ff6f7d2595d9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20802,6 +20802,7 @@ F:	Documentation/PCI/endpoint/*
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


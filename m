Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020131.outbound.protection.outlook.com [52.101.229.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7AE3DA7F9;
	Fri,  9 Oct 2026 05:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791522013; cv=fail; b=B77H7G9tnwppv7vk4aQxCz8kPDyeIRNxq4uQ+mkcqzS/GqInnH3mywlWoR8k4fodVpYXdM8tkdIr+mC5RPzXf1XcUUYaNZvocihw5fmZvFUNuZEwTUl8mzBOpVVFn4lvrY5LVRHdO8jLKd+505XTfnXWbnbV1K1737ld+nUY5PA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791522013; c=relaxed/simple;
	bh=9xLGErfk3NpaK2ukFgvaONkcmuzEmRzOXyuEA18uwqs=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=aiIJjSC+03c/C5jRDY+tPDVti8+k66M6wYqQRSwj1BsxLyE++IXRKhmfkkGKhU2lpX45PYaU4AQhbUg5A7e7kXPM9fSqDNnLl9l9DwSUApBuJrvlgZPloBhrb9QgVq9RxcUhBkZISMf05f/ksq4EMg5V1dOODK1n9gGdt5sAunw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=ksMKwEzz; arc=fail smtp.client-ip=52.101.229.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="ksMKwEzz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xQGHXN+7nFk+soLOnHP6O1BsAkWursQKtrH26zd1mjpVoPJKkY6slBL0ELqkZ1LBA2qAJHBM5gn7O9NRwqsKB3xkw0LD0mLKn8+jsk0aEOrgsIoMqyhMuzQFGZlLHT/Tbk+MU1Vq2NXNQ+MWXAFo+43fzIEUoesXY7RhQnPbK3smrg9m6VO5ZPTYA8/vlaYm/pO+rTU8+KPNB+7c68fm0n3SxRCuvEET01bOtYBdYufXQ5Yavwqc4Hx2OgXgYIULrC+PQ1nUBPhjKcTwQfs9EVBihpjSzmbYAzXZgnghPGGqolCHc6iE2hZtPlDZKO4wJfSGKXD2IaU/AAuOSbY7Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PTOwtBgapTDZGK+mYbeNiKtB8ANvoDYwPpr4JoZIZao=;
 b=G/aERhNPHTyFtToSi+Usrjr/pI5E0i0oiZo5re2RNhgXiJNhsEwzqmaM+/yqItJ2vRqW5gVOEpCiMSj4eTDLgZWOnG8xJi55XjMOMcR1aLH2XRgXFbCCnQnPc1T1tqGshi8Fm+CNwK1Kux4fe7ZXWaujmxJBV4geWcmhKC1TZ40V+LzQlN+IoKvti3Q8famZxWsZSHfmTf3DvHYVtF7qIhocdqW5REmQivQNvrZk6kehUb7/kYSPuR6igldcubntHAnIFpmfEkISI0mVCAu3+KPlGFyMEHSYenU4Iv/yVRfb1Qj9jDXo5J2Kj3u6tj/SbNv0WtvH5iJf9eMxY1NdeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PTOwtBgapTDZGK+mYbeNiKtB8ANvoDYwPpr4JoZIZao=;
 b=ksMKwEzznqfHTnbHIAxRrYkLXRN786zWSOnGtGulngy9daWERIVKisq8tecbZr6UURPfQtXeYkVla86+ZOhrBVfCBwPSuWUm4nj5AK1yCNTAdlmWtpv/RDV09oz/zgQWkl/SPQZ441bINlDqN4RFKsVf4ieXYX6CA95o+Uf7BZ4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OSOP286MB4369.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:309::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 05:00:04 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 05:00:04 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.Li@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Jerome Brunet <jbrunet@baylibre.com>,
	linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ntb@lists.linux.dev
Subject: [PATCH v5 0/7] PCI: endpoint: Remote DMA support via vNTB
Date: Fri,  9 Oct 2026 13:59:42 +0900
Message-ID: <20261009045949.1109871-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0090.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37a::12) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OSOP286MB4369:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ee361bc-e873-4859-57b6-08df25c22e9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|23010399003|7416014|376014|1800799024|56012099006|5023799004|10067099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	i35ckzNtgWjnNjcA8xRlr2p4yNS75lnqtcWFHUcxjFGyC1w7iNjYg28U1b90ziZ7jnvz+bwCjx0eoNXQ/cw2Ef4E0QoxMMh94l4F6WVKvek2LPewheuKHVQEUOOgboMXMS855lwqZzukBhgqzq2V4wLVKWjGbl4lEDa0W3kUB0Q68qCiMqjWdV4SWL4tCTDi+uH2FfBCVQZ0HgkgVWVar9sbfC6nNSvhG2YFWWtaZfb/j7z0qN6HJ2iIrFKjzlw6Mmqy1E10DWzowkvFuAGBv6E9hhI8CMzWpqWnAqOL5suf7JeYKKxi0nVE1I727a5utJUvZZShzg6rRF+YNRTKLxr4pnW65ycjUHKq1mzd5N5ej3qG3MoOlHcyf25rczZksyrAWp0lt3NfzpaaGPLe3e2tAPshiNdOsG/IBnqoG3A53dcWF1SSSRg2q3sh61U/rSjRqe6co7yt4+sJzHgVKMGdTW6C2DskDyQFZ5bxCgLFmieKEeBcQA2tyabu4z3+qyyWp/H7W4KShaV2v/ER+brbx0uqZgJbsBt6BjW2Denbcjcstce/EbslhNp582ec+u5pogBdPRaS5hBxtcY0j2nTxo/77+ZRzaLFJlQfgbfi4Xw76SGhr0LUObg/+MP+
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(23010399003)(7416014)(376014)(1800799024)(56012099006)(5023799004)(10067099003)(18002099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5bjeeuxyt/FgGI91l6SGOI1/MzxZj5do8hYDfgtU3RtItxpOyF41HmPok1wc?=
 =?us-ascii?Q?RdxKRQMdYrrCeWfNIfX7L5C4gtlN8qCiJWLy5Ww/D7vdwpyMLL20hhEI0htA?=
 =?us-ascii?Q?kJdsVZRp0pndNbs76BDBD5vwWwjnBa542IxzTqzyHnSWgaczoZ6eiBiR9ki2?=
 =?us-ascii?Q?SkJ6VvVCRQ9lzIAlWvN9nnHDP0hWvo5XxvBVROF6KPelt3FMDdyPkhLpGPXH?=
 =?us-ascii?Q?zYYl00vq3rLE8hCWtFDPTWDvrvrowEsYR7dPKQ0ik3cjk1dElXrtBU6ELdA8?=
 =?us-ascii?Q?SYTnKoOlntbFYg/3MIrb7i5EfZ5TylBgue8Tu04V51sjgEMFK9//3pctkOMH?=
 =?us-ascii?Q?U8IcPOLG1qj/AvFcb1A7Oss2e9v6CqwNEumoAr/VEbPULSeJNG2HqSjS7sTy?=
 =?us-ascii?Q?JARXKFieMad7q9FrUaR8oO161Wi8gV8rHDiettwsOQqbyE7A+IiMcpeREBMT?=
 =?us-ascii?Q?cuE86k81+WnXDqbYTdklt3JgkqgknzjovPuHzSq9+H+/q+U1r4g+IzOtGeL0?=
 =?us-ascii?Q?vdw3Swjt9kQNyMm45foyniZyBP09bIOTI71py7Q5oUgUR+m0wbydI2NlAYev?=
 =?us-ascii?Q?oxoJdFRWuZM9eefg4o/8blRSF3QB4N9s1oJV2G7gfAtMeWNRRdyI2haH8RWr?=
 =?us-ascii?Q?uEELXshPO1ois1Lg965BRPniQzDbDOFXGhtq1q5dI4k8ymnAw85qI34R/DZV?=
 =?us-ascii?Q?BUdQpCwtNZBto3WVL+uKnOS+4bbKioysKJkli4GB+GcVXdIkdwvnCJm/paRC?=
 =?us-ascii?Q?RzJEjB5eBVBK778MSLTiPONv1LSmeerbuYL6n5PLKTt8eJzcbVxgPEmmQTLo?=
 =?us-ascii?Q?UMzQKOQUWIpjtbZbqM4mq3fHngJOOrKJmkJFAGGnyHNfQmvTGnv02t3ohwmJ?=
 =?us-ascii?Q?06Ime2cHQSw9aXW5IXzSqi12fDl+Dgq2dR72n9qVCKGEAUqtTzAshcDEEC7T?=
 =?us-ascii?Q?F7JMnURsCw+9XERb+yEQHIsN5yqMdmqox0q+KC21tqOHTN4QZ7Q1McG037C2?=
 =?us-ascii?Q?AemcA4Ea4Cj8irWG+hOC8efd7mXT2yw3ntXbNp+Lhz/EIN5WBA2jvmNmg55Q?=
 =?us-ascii?Q?55ub1LUB00jy3MU0o50YW3umy3hSoQiAHdMlaHvIlGwl83EPTTF7HhlnI+L9?=
 =?us-ascii?Q?luNV9zdlYUEvRjInCUptCUuXtfEiLCLjRGwIqvJyXMRyQAaWtRoeS3VYi7h9?=
 =?us-ascii?Q?zJVHwsWwPM42nNQjD4NN8ee6HYWfLvlRSux7blGich/80xBO6mX0ySrzJK8L?=
 =?us-ascii?Q?hPxXv1O8tohTUMyaugC1L3bCtvSjGZYPlJjnhrT/db6aAMvrsEWmml+ONnih?=
 =?us-ascii?Q?2tRbCRH1XkxDP/3qyy3Rkh3aXaCA0WUSP4vq+i6sKxOcU2jQeUq+o+9RyImI?=
 =?us-ascii?Q?m0E7gayXJ5x9BU/1mSdnpKzMdEE8F+l6tSXucKpWb+sSvuGix5YCfZkZ8Wtr?=
 =?us-ascii?Q?mzJDedjgYLVSkD2wHGDLKysoO1k9JaJx5YRECSUgD1KshH1u0YgDaBCnqDih?=
 =?us-ascii?Q?+oNN+HdFS4GxsP+k98MdGxl0Ahlus/U8ooJ0PQ/nLysCzHxDS5m6zr00vHG0?=
 =?us-ascii?Q?7aV248tFDrIyjGSrs53GkDAjvgjHr75I6vGNlxYMMsWJYevgghxuUPy9u9wJ?=
 =?us-ascii?Q?lcCnMCQhKvqJhQy7csZPtMAPWEqxPo7q/NZrFUE6vA4x5Q31gyerPwqJ77Uw?=
 =?us-ascii?Q?FM646mA4XuPMUHwIrPEqPclt2YHhyieYnG081mQR2dnZJY696H6opmWTNNbq?=
 =?us-ascii?Q?gsfhgC9fGumOkHku4DzxTw7KTroRyppcXFjCIKMDNFnrPeHC4D0c?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ee361bc-e873-4859-57b6-08df25c22e9a
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 05:00:04.6328
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: obY9864BkKn7ApSS9ZIMbWYip5izNvt6F+l2KHovWu80s8Xw+IBlUPgLm0HJKm2tsBfCxG+UzV+IgTHlZM/v+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSOP286MB4369

Hi,

This series lets host Linux use EPC-local DMA read channels through
vNTB. I also tried a separate PCI DMA EPF, which reached v7 [1], but
came back to this vNTB-embedded approach after discussion.

An EPC-local DMA engine can use host DMA addresses (IOVAs when IOMMU
enabled), as PCI addresses to reach any host buffer mapped for the
endpoint. Letting the RC side drive its read channels also gives the RC
a direct path into endpoint-local buffers.

A major motivation is direct TX in ntb_transport. Both sides could use
the same dmaengine-based TX path, sending directly to RX buffer DMA
addresses supplied by the peer. This avoids MW bounce buffers and
per-transfer MW remapping for payloads in both directions.

This assumes both sides trust each other. The RC side still programs DMA
over MMIO, so this is expected to pay off for large data transfers.

DesignWare eDMA is the only supported dmaengine backend for now. Other
EPC-local DMA engines can be added if there is a need and they have a
suitable programming interface.

This series does not include a consumer for the dmaengine channels exposed
to RC Linux. Native HDMA support is also left out to keep the series from
growing too large.

Setting pci-epf-vntb's 'dma_bar' configfs attribute enables DMA export.
The default is -1, which leaves it disabled. pci-epf-ntb is unchanged.

(Re)based on next-20261007 (b01868671970), which includes the previous
dependencies.

Best regards,
Koichiro
---
Changes in v5:
  - Base the series onto next-20261007.
  - Simplify the implementation in several places. See individual patch
    trailers for details.

Changes in v4:
  - Base the series on the vNTB lifecycle fixes, so unbind removes NTB
    clients and the virtual PCI device before releasing DMA resources.
    (Sashiko)
    https://lore.kernel.org/r/20260901063238.631166-1-den@valinux.co.jp/
  - Keep DMA BAR submaps for the EPF bind lifetime and drop TEARDOWN_DMA.
    (Sashiko)
  - Rename CONFIGURE_DMA to SETUP_DMA_BAR to distinguish this bind-lifetime
    BAR setup from CONFIGURE_MW's outbound mapping.
  - Continue without DMA if no DMA IRQ is available or the advertised DMA
    type is unsupported. (Sashiko)

Changes in v3:
  - Rework DMA BAR setup around pci_epf_assign_bar_space() and submaps.
    Allocate backing only for uncovered BAR ranges. This handles the BAR
    backing alignment issue in pci-epf-vntb instead of adding a generic
    pci_epf_alloc_space() workaround. (Sashiko)
    https://lore.kernel.org/r/nvgnu3enktslxuiv7kdapcotoaxlfqhivar4jbf2tqvrk4otz5@exapzemrq37q/
  - Set up a shared DMA/MW BAR only once, preserve MW translations, and
    simplify error paths. (Sashiko)
  - Make dma_bar the explicit opt-in and drop use_dma and automatic BAR
    selection. Split BAR sharing into its own patch, then document the
    final interface at the end of the series instead of updating the
    documentation twice.
  - Validate peer-provided DW eDMA region offsets before MMIO mapping.
    (Sashiko)
  - Include several other minor cleanups and refactorings.

Changes in v2:
  - Rewrite most of v1 and move the dw-edma preparation into the
    companion series. Drop the generic pci-ep-dma API, auxiliary-bus
    child/frontend, test ntb client, and preparatory MW-state
    refactoring.
  - Replace v1's post-registration channel-ID cache with driver-supplied
    static IDs. (Frank)
    https://lore.kernel.org/r/abMcgQOHDD55Yv0e@lizhi-Precision-Tower-5810/
  - Let pci-epf-vntb reserve channels with dma_request_channel() and
    configure interrupt routing with dmaengine_slave_config(). This
    removes the PCI EPC DMA delegation API. (Frank)
    https://lore.kernel.org/r/ao2nHoCwfTEEiFSr@SMW015318/
  - Drop v1's dma_offset and dma_num_chans attributes. use_dma now enables
    export of the complete eDMA read direction as a group.

v4: https://lore.kernel.org/r/20260903082327.2345602-1-den@valinux.co.jp/
v3: https://lore.kernel.org/r/20260831182657.329614-1-den@valinux.co.jp/
v2: https://lore.kernel.org/r/20260828170932.2735807-1-den@valinux.co.jp/
v1: https://lore.kernel.org/r/20260312165005.1148676-1-den@valinux.co.jp/

[1] Superseded approach, PCI DMA EPF, v7:
    https://lore.kernel.org/r/20260813063757.3131865-1-den@valinux.co.jp/


Koichiro Den (7):
  PCI: endpoint: Add DMA auxiliary resource metadata
  PCI: dwc: Expose endpoint DMA resources
  PCI: endpoint: pci-epf-vntb: Move epf_ntb_is_bar_used() up
  PCI: endpoint: pci-epf-vntb: Export endpoint DMA channels
  PCI: endpoint: pci-epf-vntb: Allow DMA and MW to share a BAR
  NTB: ntb_hw_epf: Discover vNTB-embedded DMA
  Documentation: PCI: endpoint: Document vNTB DMA export

 Documentation/PCI/endpoint/pci-vntb-howto.rst |  31 +-
 drivers/ntb/hw/epf/ntb_hw_epf.c               | 336 ++++++++-
 .../pci/controller/dwc/pcie-designware-ep.c   | 107 ++-
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 678 ++++++++++++++++--
 include/linux/pci-epc.h                       |  34 +-
 5 files changed, 1106 insertions(+), 80 deletions(-)


base-commit: b018686719706a781c45a874ed51374a2dc4b767
-- 
2.51.0


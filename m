Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021078.outbound.protection.outlook.com [40.107.74.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CF8301719;
	Fri, 17 Jul 2026 05:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784265006; cv=fail; b=R+YMfrs7XxnXKsnLXqSBxILSQbwRESy7EkbxxEGsEdCdoJJdEJa5gs2uPW9efUtCQHbbsplAgqFjTLjfhMBY246bsd2SGpuAckAq8mm7xIexaK98GEFgG3TRbt3aFQiAFC6veEYrWK5CHP58phAeHyByutnjOj7pDFC91FsW7/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784265006; c=relaxed/simple;
	bh=7QMhZvJAiILQ1yxmbYh7w+i3FO0OMxVDH5LHXymYZDk=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=SaLMozIOQFxuorVPF0jxilQdgmSLjdjmzuvvuACw6pFU05R5zMgIxvuWYVEZxCZ/YMOWy2h9KeoIrzrvg3ZrYtSpSFmYoOs8yFB4nKjom4UZEk8A1Le7WYVpDKFy8vpLjltvKfawU3lDUnLlxmiepOjxZ22mBL+rQT5yFdJryrw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=Idemzyyo; arc=fail smtp.client-ip=40.107.74.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="Idemzyyo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vsiRi2FMp4F6tvi6vDg/vGXGRsLQvRv3TYT3hgOpbDdWQgU4UOAxcNKIRx70YZibT9ojAc9RaaI0IGb7LxqTvexafSfkhDESUY6Y5rE8Ebg5b+wk57kWmx+95LbeVmabuUJwfbCiIf/00Ekf9nt7UNGbDXeNO083iwhkjvD+yBnkkP0vgmoIh2p0Vhu6O49Vwkbm+de09Dp95as+qO3WeGW+XliLOuGQXSquEw618YgB6qnJkDX2PeIhpHbMHxyF+nEjffYLV/0Mq3UzawpULoDGXqM6riJ12UyMYD3Siee5QAaFANlKGy9NkPsvaJ91i4rZ2oYKI2y8/GBegtv5aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qf04pQGbhtiHUVe0r7GTB5gKqt00MPCv2vnUoWz4XrM=;
 b=IB2jiwkwfd764PGFDIL3mpVunVHeY+a2j+Tk0N4QFOXOQ3ruorqpRom/Yps0+AfAQNM/VmbbjjZeLOwSp4ft5+Kx11DtunaufwjJtblQ78rTpXGSysN7AhKP+859CCu05GqEyrKEQ49FCcVdOiH/PT0yC7wjXj5xR5muitLEOcf4NPCV72OwpUxMY4mjhYW1Lp3KxOQAtN/LRa5rWBUoIo5mWdNDYJRnL+vXxh2jfb19r3zs/FUWYi/0xF/1Su6U11cuoW7SxXyXGqTgLlt5sOaUXaVWn0hWhnmoJl9UhB6Zr9qaH9zzruzYnrYaBz/kFGsn1Gun03OsMQIVQ04wMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qf04pQGbhtiHUVe0r7GTB5gKqt00MPCv2vnUoWz4XrM=;
 b=IdemzyyoaXBKRMn0afJuUtd26HQoG6nhgH2sRe2U6+tsBbe2xbmX8W8b5Axjy+FB0fi4A2xj+jJ6e7hk4AenxAKwGr20T2fP2GcaIYOozJSFlSPbkkh3nSuivXQ5LrKTkOvJ6Bq26biio4JCc1R4MZ+y3N0CvzLtnWx/pse144E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OSOP286MB7889.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:47a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Fri, 17 Jul
 2026 05:10:01 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%3]) with mapi id 15.21.0223.008; Fri, 17 Jul 2026
 05:10:01 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org
Subject: [PATCH v5 0/3] PCI: endpoint: Add PCI DMA endpoint function (part 3/3)
Date: Fri, 17 Jul 2026 14:09:50 +0900
Message-ID: <20260717050953.2145851-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWP286CA0020.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:262::7) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OSOP286MB7889:EE_
X-MS-Office365-Filtering-Correlation-Id: 54f5e823-0904-4f28-bca7-08dee3c1a789
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|10070799003|1800799024|376014|366016|23010399003|921020|18002099003|10067099003|3023799007|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info:
	LIk1bsY8OnvnQh/JYlafLCsHtAy7W2uLB2s+k8GW1K954WZyDugzoZz6kVEHQz48xbv50tqBOoSMS6FZIuO7lA8TaC4ErNkfoM16k1aKj27HwvewGv0BC+3wLBKQyXb1xmRJeey41DtBYifzsyNPDvYNauowRmCsj4Ype9Djf3Ch+0PDxsT4OPo4jx3yYBba60PYp9esQjrsKvtj3MI5JzmkVdUw+ma80jzlB+nQcbwhnnhwXi9v67Qmed53k8wMSgB8/0Kh7qmp8rHzwFOLffUzcu1A5NClkhOrSweaYZ7zbhCyxAQAk8n7m29jCCGOyKmjTThsn3E08j5oaFPXxAoOJ6pINhi7RVhw6j4oBRgKTsU4ByQlyvJf1c3KhXzju4DqHMlsrglm5EOpDpojDS9hJI1YMuGj0Un2QfjhCfOxVsCFAS858sfWPXnPaUXAQvx7uDSAWUd+d3FfwPtLki6PRADLMK694dmUwZ32ZEIyXoZIGSF/b83dQjvqCLYyyBC4I2Yz8nSftiD2J+vamTD6FiOrW1FJQu6Sj96KyFdhIsC9gMNz7ej81DarZ41c21ynuDIcLfG7Fg6POqKmyfjMR/FtBGCxcLoaBXNTopeGw6HEHJlB57eKwva5UwBmlRjY5QZlP6PAeCsVrl12Z/KR/u7Nlf+ZO7j0dDlLWKfnS573Px6ptPwH/r8wDt/8P8Pnk0gpDvI9QC1IjJ9nPQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(10070799003)(1800799024)(376014)(366016)(23010399003)(921020)(18002099003)(10067099003)(3023799007)(6133799003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PnzmlXiXN5E8de+NC2tN9H5oQeykmdp+FA1qhXCu0Mctg82dYl/OO2pf1yTl?=
 =?us-ascii?Q?+MtEPSi555iqBdgFTrSpYOK6cCXkI5ssc1Y34FC8sK4Xg11/e3t83j/1NLRP?=
 =?us-ascii?Q?/U9hRwGHfbYhLg2vPX4kCXhjdUuisqUoj+0rIi6KLuL3nN+3GOYGTSsaEcUc?=
 =?us-ascii?Q?8pZdgK/KL3nnKL2iZ6TJfANxrIlN5XAAAL3L2AQiB3LLyJ2MzlsFAIS+SkVJ?=
 =?us-ascii?Q?Y/MxrAW60YELWDb+7hXqZpGGYMEe6NN1uCghJl37+4s3i/x+YwV4lhidcWMj?=
 =?us-ascii?Q?CsApaYFxgY2UAntI/lU5CP/bPcXzgFAIVedE/DoxpLqll3OraMcVhEXuSzID?=
 =?us-ascii?Q?UMG01XS+qvLLNYq8JgxIsA29K0CRoiE29EX935RFkSDCT+mqBdnSA4PuXxZ4?=
 =?us-ascii?Q?T8hd053i/LLvC/MoigC4F4ATMFqINUUWp6o490UPI+/CqaYLiwtAZwHcfmR2?=
 =?us-ascii?Q?ZcbyD0Tr1RrX0zqipG+cbhXHYeWvJNBHDChreAZq7D8c73oKUE6q8x7r7Qfy?=
 =?us-ascii?Q?IeOxWlA/G8o3sdfc1mA3kM7sRkC2BiJC1+tSTtHUbVrFR6UkN0gQ42HfqkIl?=
 =?us-ascii?Q?RszrGDb2n8hgYYLz/zQW3R559xKduBtcUQax59MDkxpGCzIdsAnnNq7ydBV5?=
 =?us-ascii?Q?nTihvn2yTL9Ik8hmLJSPnvkoSFCqNS7lfXEXc7GqklW3GBKr7FKJpWER4T/+?=
 =?us-ascii?Q?BW9DBEqRKolzjN2wEMMzeR8HQ4J9iLax6tMGB/2Eii8As0J191YBvzzevul5?=
 =?us-ascii?Q?OEwcsgzUBzFMm8PJBCoQ1GZIN6RSNDeID5rWrqmztffWXyhej3hY5lh5A4FH?=
 =?us-ascii?Q?8y45ERqlmGZ6t94uKo6f2HNe+HzJsBV2REAeeBghbv+L8w4bZ8jpkxrMMoKG?=
 =?us-ascii?Q?mhmADu1eBo2Spavs9vfT86CSshfQamAENVd+yO7SiQ3Dw504MaGPhNala2Cy?=
 =?us-ascii?Q?4JP5mbK9jIijVBOyZdSOYM7F/MY36SquWT/On+LK7C9K0mXp5heUWKgHZjJl?=
 =?us-ascii?Q?q88mQLIvF+78FUNCJeFV8fW8ZLeyHko1o+DrC0pLrbhrC4pyY5zUys5pE+Vk?=
 =?us-ascii?Q?rXz+Ekm8yl8ARvPTSRET/D0vSOC53wTeoAvMAWE4044Iv1S+w+GGm3DPmwma?=
 =?us-ascii?Q?OXmwL80WC0gI/alNn+x1TY5lhHv2awbBqXAiBat8NHr+56b5V9qO7LkkEjYF?=
 =?us-ascii?Q?TudgA9YsJg1j4BeWmlEdE0B8rwQ0vcJfZsAWf/wwF6iJjAFcXAqjDjhFCxUC?=
 =?us-ascii?Q?oOrsPSHDX//+qwfRLJojefhmnF8C54nM1XoXAHVYVWNmr2OsCPuMgEp+Z0rV?=
 =?us-ascii?Q?LQ9xDIJSw4hqcjJfYNvVv08bLA4a8XlFqHfARibqlOZ+LrNpALatvWv8gStE?=
 =?us-ascii?Q?mErZ6C9rnvRjJZY88Pb1dcXBAagk6eibLr4M47jtrBy1fE+PfsHpqKF+b35M?=
 =?us-ascii?Q?klozX8yHhtvlcSY2qXTKVvzM/Ea/DVq7B69LUVAJDDShYUJ2w+ev9s8yjp7h?=
 =?us-ascii?Q?8bw7Ha989fKYtfEnFGVOn10+F7g2ZhIXoPx7ieuW/4XfWszn+MvoOmSstU95?=
 =?us-ascii?Q?+3IBA+ruiXBSpIqOq0fnqCxcVdbUesX49THqR2ckCr/zRSKl/zmdjRSHb1pW?=
 =?us-ascii?Q?M6BxHGdfth9vnDknav5yUBhMnrCacv/DW09nTLgBrCiZBiuKA6aRKZc9hCF4?=
 =?us-ascii?Q?cETouT8tGKnqzhLWzo694YY27pGoFsZrmaQHB8jNLp8DQxalDaI6evrjanpt?=
 =?us-ascii?Q?KdiJLP5C+rnQXFRD4uqxQeojg6oLngPL4PMQFg0Q8vzpKde+Od8M?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 54f5e823-0904-4f28-bca7-08dee3c1a789
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 05:10:01.3886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: opRHVjleuL27VHdhOsNBDprPdvYliSiMiB5V1TWNByyMCG+YMqXdOVtD34gnp58Za0C+NngDsRT97UZlDt0M4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSOP286MB7889

Hi,

This is v5, part 3 of three series for PCI endpoint DMA.

The three series are:

  * part 1: dmaengine: dw-edma: Prepare for PCI EP DMA
  * part 2: PCI: endpoint: Expose endpoint DMA resources
  * part 3: PCI: endpoint: Add PCI DMA endpoint function

This series adds the host-side metadata parser, the pci-epf-dma
endpoint function driver, and documentation.

The endpoint function exposes selected endpoint-integrated DMA channels
as a separate PCI DMA controller function. The host-side dw-edma-pcie
driver discovers the BAR metadata and registers the exposed channels
with DMAengine. The endpoint function keeps the metadata BAR stable and
uses a separate DMA window BAR for resources that need dynamic subrange
mappings.

No fixed PCI ID is assigned. Users provide the PCI vendor/device ID
through configfs and bind dw-edma-pcie explicitly, for example with
driver_override.

This series depends on parts 1 and 2:

  [PATCH v5 00/14] dmaengine: dw-edma: Prepare for PCI EP DMA (part 1/3)
  https://lore.kernel.org/r/20260717050308.2144108-4-den@valinux.co.jp/

  [PATCH v5 0/6] PCI: endpoint: Expose endpoint DMA resources (part 2/3)
  https://lore.kernel.org/r/20260717050635.2145014-1-den@valinux.co.jp/

One open question is how to support endpoint controllers with only one
PF. Keeping DMA in a separate EPF requires multi-function endpoint
support. Folding it into vNTB would work on single-function
controllers, but would also couple the two implementations. This series
keeps the separate EPF model.

The v5 RC-to-EP path was retested with a small out-of-tree DMAengine
client on RK3588 and SpacemiT K3 endpoint setups.

Best regards,
Koichiro
---
Changes in v5:
  - Quiesce each shared-register direction once during channel release.

Changes in v4:
  - Rebased onto the new parts 1/2 series.
  - Support IOMMU-backed EPCs by DMA-mapping the dynamic DMA-control
    MMIO BAR submaps for the EPC parent, keeping descriptor DMA
    addresses unchanged.

Changes in v3:
  - Select endpoint DMA match data before copying DMA data and require
    driver_override for the generic endpoint DMA fallback. (Sashiko)
  - Accept HDMA native linked-list endpoint DMA metadata.
  - Consume logical DMA channels separately from descriptor memory
    resources.
    (Sashiko)
  - Delegate channels through the EPC DMA channel delegation API instead of
    v2's EPC-provided DMAengine filter callbacks.
  - Allow HDMA native linked-list channels to be delegated at channel
    granularity.
  - Preserve HOST_REQ across link-down and retry DMA window submaps on the
    next link-up.
  - Drop trailing colons from documentation subsection headings. (Randy)
  - Document HDMA native linked-list mode support and the current non-LL
    limitation.

Changes in v2:
  - Follow the part 1/3 and part 2/3 v2 channel-claim model: pci-epf-dma
    now claims delegated channels through DMAengine filter information from
    EPC auxiliary resources.
  - Select raw-address dw-edma-pcie platform ops from the endpoint DMA
    match entry instead of using a match flag.

v4: https://lore.kernel.org/r/20260710082727.2397253-1-den@valinux.co.jp/
v3: https://lore.kernel.org/r/20260620170844.3757241-1-den@valinux.co.jp/
v2: https://lore.kernel.org/r/20260525063456.3317509-1-den@valinux.co.jp/
v1: https://lore.kernel.org/r/20260521063638.2843021-1-den@valinux.co.jp/


Koichiro Den (3):
  dmaengine: dw-edma-pcie: Discover endpoint DMA metadata
  PCI: endpoint: Add DMA endpoint function
  Documentation: PCI: Add PCI DMA endpoint function documentation

 Documentation/PCI/endpoint/index.rst          |    2 +
 .../PCI/endpoint/pci-dma-function.rst         |  188 ++
 Documentation/PCI/endpoint/pci-dma-howto.rst  |  201 +++
 drivers/dma/dw-edma/dw-edma-pcie.c            |  401 ++++-
 drivers/pci/endpoint/functions/Kconfig        |   13 +
 drivers/pci/endpoint/functions/Makefile       |    1 +
 drivers/pci/endpoint/functions/pci-epf-dma.c  | 1524 +++++++++++++++++
 7 files changed, 2328 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/PCI/endpoint/pci-dma-function.rst
 create mode 100644 Documentation/PCI/endpoint/pci-dma-howto.rst
 create mode 100644 drivers/pci/endpoint/functions/pci-epf-dma.c

-- 
2.51.0


Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020106.outbound.protection.outlook.com [52.101.228.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007A23BCD2A;
	Mon, 31 Aug 2026 18:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788200826; cv=fail; b=j4h9gF4rjE4prYBB5AcozXL1x0GuC5sfOwQk3KI8dQNvoeQylfiwXr/Vfh26jCrV8FqIBL24mGXgNcwMFeS1exiWCCz67I965pDBlFNtO0bN8Milf6s2KBVjlT8TL9fNn1u32luRRmZWNuBiew87wZd4ynsxCWpcOHI+9X1W5Bc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788200826; c=relaxed/simple;
	bh=el07Ln6frtJzW8GdSpsot7sBXoQf5PT3bVZMA9Ezo6s=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=VKtKut3+cTg6Y0Lq9zH3xiMPK4mNYQGDJIt4SIFJLyFySJEsnKgqi3UFdyKy2vqSN57YB5J+x31ryFvP+ZC1CgtL/n+hrv2F1VhWT8V+vAWQHP9ovfZuZ1YFNKL43Uv8voOiVdm/Pwh13sU23cjHpI6RUOROE5Hy92DRkh0JxcM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=RyiL34GV; arc=fail smtp.client-ip=52.101.228.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="RyiL34GV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fW2Ca74TR3e8TqTHOPw8qc1uhpOVkTus9Ms+GFhVumE1RAcwZXXT3Z+wXXDNhZEuWv2IZRRnQ7CCqg5aLh2GBSmbgnYX5cWJ+gWQ+8fE2Il+CCOp518avYeeM1htVUNQu7ZVqOseFPNuqd/C6cvZAGRmFRd3JP/+b9w2JWeAS7LKZ3EaUl0K2gV4uonV4pwxvF9A0CvvpQ8btpKUXveDOG5SQOmkuA90Pg731EmI454PkUFpDQCPjK8CYwdAUYvU+iNEwankhzNnJ7r49tXG2uc4XQAh3g3VRszCN3h96dbuCPW53nuquU/phNVwCmMHYld75kYuCg0f9juvuhFsfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yNvwynLSmDOjBfT3KquKLhR1A5F973eR7oKHm9TcJtc=;
 b=HhQc0DxbZVbn8vyA+zymNjP09DEoRfpTFwi1CYl62sm1fQdrJKlqVYdSETaYmvzreGyk3iBrXbACIQ716e/MfolcL5/oiDVbjL9wnLprE5T10H1iMhc83xI32PAqgp2S6tpYIppiO/rOh3G3UeK5xdx4Z1IwRHmfYGR0e3MptY38vvxxocsfjgmFLtRrPYoM/haBiDOi24dymDak9aDMrCLSbVwLrjCCoogW5pMgswBsxwkY4AuWmDBjQvmdImWIzXsrxyjIUjyal8Q8Q4b4KLZBnCB4MqM31xLhf+ean83dRxAg+bpWhIir2WwURef0F9SykrKoIiotUNpYnUgr4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yNvwynLSmDOjBfT3KquKLhR1A5F973eR7oKHm9TcJtc=;
 b=RyiL34GVsqn8EYC27UsRKXWRyZ64FC78lF2Q+lkGfrP0KHuUqEKmt5v15autDU7egdzwUJofx5jJ3mG6xRtTdLT44h17pMEL2cSvwwAfqSYjeuFataX1J+zorb86E9lno88ovYS3aDbBYH0ghHsBumVSbmqsiX2SWaPzfBqldkU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYCP286MB1802.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:11c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 18:27:00 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%4]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 18:27:00 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
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
Subject: [PATCH v3 0/7] PCI: endpoint: Remote DMA support via vNTB
Date: Tue,  1 Sep 2026 03:26:50 +0900
Message-ID: <20260831182657.329614-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY6P286CA0023.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:3b9::9) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYCP286MB1802:EE_
X-MS-Office365-Filtering-Correlation-Id: c1d87b80-f2eb-4587-25d3-08df078d72ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|1800799024|10070799003|366016|376014|18002099003|56012099006|6133799003|5023799004|10067099003;
X-Microsoft-Antispam-Message-Info:
	Fmhtjcz3UtRqYVW779BppqFx7KBuvWdp7PHwxwW0IkkohaZdJi/AdlzHpi4nxEMtzsWXOKypK2PUPkjCeTVCSDNChZGQDuPH3Y5hWI3itMldxbzV2m1eyoFKYnBlwZSUmioI6faiTMCxdR4dPGoqYwHdzqT/oo276mcCQciCC31uF/EgeRj4XgtNv1UJpI3hViKTVCWgyr018HCJqRHBSUnk/6mBgTC5WM+wornUjs3qNudn1pnGFCQY5He9R59f/wUCwUFbXd377CTDUcA9DgAma8OkmsgDi9Y9HXVkKdAAV8+PEGiwotr3MO16du5bfzHdl+ri5Oasv7ADJypVXFHS4d9/qfESTFWlHkox2MhwfkoJc+76xXNxjZkqcEVeHsoIxpeDzWERKHpZBuwqZLWbWEY4tiQs7BTlPLLBVG7hz1aQTOX6pnEfvLJoBzOnKf9iZnL5qtIS7H8g9LS65us6heayX03Z3hoDkDqtrO9ITfPqUPPmRc91628tae47BfM85yhZt2TYtqNUqztJq3NZn2Sqxw9qROxibUB+rltXciH7lpnu6c/MRvjMvl+9re2HhZHlKOywA/fyEiWiW70abCNqxb0oIhAFG00mm9zg8h3vQO7evPYC2f1NGDPA
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(1800799024)(10070799003)(366016)(376014)(18002099003)(56012099006)(6133799003)(5023799004)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6815sWAlNoTIZCJhEzFGZl9862dmSZwQ81eI4iuBkVN2wzDiZhfC5StvDAeR?=
 =?us-ascii?Q?s6yRpTMFcb3SULkiaG57CBZe+BVLuV6u4q49sO1uFVwDzdFYEFNET5LhgwUI?=
 =?us-ascii?Q?RsPF1KCumOFHRuNaTKWChyD3Fay5/920vI1xA6DQligrs3Ka0HnG98oMwSaG?=
 =?us-ascii?Q?MmiaKYM2/vP4WExgE1fpbmYr/xeNlpHa62k64qXwgn/dFjUuMZDOwl62J6oc?=
 =?us-ascii?Q?cCMU0cgq6U5U2d148ESakjdFnnUKETOJGsDppDbFggHTWQJELi92PE/cy52I?=
 =?us-ascii?Q?TYIIYxjvMKvWcxmecXJGtQzgZOzwcSTdNtyed6QSr2ElRjnumyyu4V98N7bs?=
 =?us-ascii?Q?1haeMSklHPeAGaSa25WAOZXFXqY7EtFDmVie/0Ed3YjigIF2Yw5EHHef47ZJ?=
 =?us-ascii?Q?X5om8v+ceHROr04EMt6ZWiZLqbuW2w5jEJmVzjW5A2VSlLngpR+L58R5Siij?=
 =?us-ascii?Q?uHUDbKLfEefiJeW+vc8rd6Gn9LpDC/2xD2uo6GNfI7SgK2oQ1Sk3yjH/zzm5?=
 =?us-ascii?Q?fFe/JWqT4VnLfI8xdnJnBFfQ2eMua8ztMLD1VTuC2kMPWHtNjb9YY+Jtk8qa?=
 =?us-ascii?Q?pcSMaUHYAKCttkZ0pA0Jtjvcx4nBMRgsr9CVFKzsDJkK6A5Q/7kn1Bnh85L/?=
 =?us-ascii?Q?QX39IX6hfoiuRJMWQ4DHfIPvXUOfqn5tkDAIahNvr/IJporW9mYwz1fxeRSz?=
 =?us-ascii?Q?G90F4NjLZ2gQ119j3V7N5sMx2FLmJWrUU4dvuFmomCAh6BCrCPZ3ZB6a+dI/?=
 =?us-ascii?Q?hn56RdoIkEIyrsRh6VrkncMfQcDLYVZ2Sz0uz0s6NiCEitrXtcFLRI34w7si?=
 =?us-ascii?Q?HQNcr30MA05h4oVbsdCM9O5uSjSbC1xQXNVNkohZjc1Lrd8IMgdqUlrVoGCA?=
 =?us-ascii?Q?5h6swRNGdTO8XIAYFJPE8TELgbIuxnG9R9U0Jj07ikAUy+VtTzy3WNBl1oR/?=
 =?us-ascii?Q?+YKJBdJZAgVp4l7mUo08dIIIrvNADf/6l4kcrPjlj729U/rBd8gM0putNihl?=
 =?us-ascii?Q?fVj9/xutrEp8VjosxQTqIDoSNkzcYPwRdHpODwZ1E3xG3zWU2He8JJZ5zwbO?=
 =?us-ascii?Q?1hqiRt2/CLth6wDwzVHzLhqOh0lupkXFPZp6bXK+xbKoaO5mjZkONbMU5Atj?=
 =?us-ascii?Q?VFcuWVGB/U/2acgjCrQ1OmHyIUDYclV3+ef9NvLAiVu7Z9FCWx3FVdn18csK?=
 =?us-ascii?Q?d4egKSfu90kUM4UjGtReUJZzYWBw6Bl6s7c58mWb0bSolQnf5xryQru1xcNa?=
 =?us-ascii?Q?tH7L2RULzT4qguPOycXohT367CWSAf/nECK0Mw9rnkAp87HkBHHiugn55DWj?=
 =?us-ascii?Q?fmsj/1ojV529W3d7cMH+gdJZZgeXqVseJ9D/Dy26e9uVzEtWXr35epy6ApUh?=
 =?us-ascii?Q?1JMTkuRmcTRaDmCp9vSvPXhE64RN8JmnBub+sn7tyuyGYCCouaRMqfaka6Hh?=
 =?us-ascii?Q?nuiLdMrqna/LXr9ivyXe4zEyUqkGJiQ/fNqltPqPxPK17pKGZoa8kmvHbsyj?=
 =?us-ascii?Q?8VCrtyM2sWGTqsHipjpikxVsOrV1yqVCiSj4Ntd/VsWimpdEXz2To4zT+KAu?=
 =?us-ascii?Q?cmmWn12y9g99UsDbDaE0IrccqtUpMjCQ2jf8VySsxJUvW5J5VbYwFg/fJN9G?=
 =?us-ascii?Q?lVOFbB4eprdXRwwtr4/vlx7pkFZWjroe54vrEL/7KlOPXKtnEr/i8PwzXMrt?=
 =?us-ascii?Q?DwGCDud5LoungGxYWpd5TzFc5tntLoht+t3bfWmor4vOYgdTtrBCZ7StnpPy?=
 =?us-ascii?Q?Bz3BsWeoxjiAw+jMYT/x7QPJE0FUV03TwOqxWCP/ofPpdTf/qj/Q?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: c1d87b80-f2eb-4587-25d3-08df078d72ad
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 18:27:00.6164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 82rrE1WMZnUu7RFnG3B/epUM26nruC/DAdvTJsBH5jyrcAsT1UtFb5iuUjRc1nxeZVzkO1699FGil2NCQqqkcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB1802

Hi,

This series lets an RC use endpoint-local DesignWare eDMA read channels
through vNTB. It keeps the export within pci-epf-vntb and ntb_hw_epf
rather than defining a generic remote-DMA ABI or using a separate PCI
DMA function.

On the endpoint, pci-epf-vntb reserves the complete eDMA read direction
and exposes those channels as a group. HDMA is not yet supported,
keeping the series minimal.

The DMA feature is opt-in through the pci-epf-vntb configfs attribute
'dma_bar', which is -1 by default. Without it, no DMA extension is
exported. pci-epf-ntb is unchanged.

Base and dependency
===================

This series is based on next-20260827 (3d83758432b5) plus:

  [PATCH v2 0/3] dmaengine: dw-edma: Prepare channels for remote use
  https://lore.kernel.org/r/20260828163611.2691264-1-den@valinux.co.jp/

The prerequisite is for the dmaengine tree and is not part of
pci/endpoint. linux-next provides a common buildable base for both
series. Once the prerequisite lands, this series can be rebased onto
pci/endpoint.

Best regards,
Koichiro
---
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
    See individual patch trailers for provenance.
  - Replace v1's post-registration channel-ID cache with driver-supplied
    static IDs. (Frank)
    https://lore.kernel.org/r/abMcgQOHDD55Yv0e@lizhi-Precision-Tower-5810/
  - Let pci-epf-vntb reserve channels with dma_request_channel() and
    configure interrupt routing with dmaengine_slave_config(). This
    removes the PCI EPC DMA delegation API. (Frank)
    https://lore.kernel.org/r/ao2nHoCwfTEEiFSr@SMW015318/
  - Drop v1's dma_offset and dma_num_chans attributes. use_dma now enables
    export of the complete eDMA read direction as a group.

v2: https://lore.kernel.org/r/20260828170932.2735807-1-den@valinux.co.jp/
v1: https://lore.kernel.org/r/20260312165005.1148676-1-den@valinux.co.jp/

Related PCI DMA EPF v7:
  https://lore.kernel.org/r/20260813063757.3131865-1-den@valinux.co.jp/


Koichiro Den (7):
  PCI: endpoint: Add DMA auxiliary resource metadata
  PCI: dwc: Expose endpoint DMA resources
  PCI: endpoint: pci-epf-vntb: Move epf_ntb_is_bar_used() up
  PCI: endpoint: pci-epf-vntb: Export endpoint DMA channels
  PCI: endpoint: pci-epf-vntb: Allow DMA and MW to share a BAR
  NTB: ntb_hw_epf: Discover vNTB-embedded DMA
  Documentation: PCI: endpoint: Document vNTB DMA export

 Documentation/PCI/endpoint/pci-vntb-howto.rst |  24 +-
 drivers/ntb/hw/epf/ntb_hw_epf.c               | 362 ++++++++-
 .../pci/controller/dwc/pcie-designware-ep.c   | 107 ++-
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 716 ++++++++++++++++--
 include/linux/pci-epc.h                       |  34 +-
 5 files changed, 1166 insertions(+), 77 deletions(-)

-- 
2.51.0


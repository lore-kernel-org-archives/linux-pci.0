Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020124.outbound.protection.outlook.com [52.101.229.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4322EEE89;
	Fri, 17 Jul 2026 05:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784264802; cv=fail; b=e2LNlbzY37r/9SbeBtuDb9PRtrTN/x2XH+AA3GwO0AaChy52MXD+i8bkPfAOR3fPzXnkWa+qom5FIFotkpZnZWo8gzWSngMW8oOCE5HK7m9RKJBAmZ4Xn1PsoqaEGg1cwLVDvQbwItkNIAKjYN/j1St8datfz6C/4emagYRIUEg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784264802; c=relaxed/simple;
	bh=tgoCUZ6Wre736kkj4EzJul8tuCxobQeg9n/hePfnU4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=nOwzVcYMgz27sRe+6YIQ70NC/ORjhQfjBKw9J5jYFmUaGZSwKQaFfFUssod4IXeYe0HUmZ2Sah4x0UGHT3H94mWIyAdtJfETZkYeqVjXQX+riMmHLT3PC3oHOee0j6XWeb0yAxkuN5ExkyXD0YXuUU9MAto35Hl2B1xj0oYFzjE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=gCa1EEUU; arc=fail smtp.client-ip=52.101.229.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="gCa1EEUU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uVUF3MyyQpMNBl9uRuc7j9eyDTp7Vi+lsJ5GlmTkrvOrVLu+KfqtJNc4zQthD8LCsw9Ua8J+xEuDPA0VhzJlwv1lZRPJ4OKZXsib73RucpnYuJF4/Z2rg29W9AU3BgPXm/VHrdwLlmCy4Pb74RbVocCqEtsmPAWleeyq3OeIEShTaBJAL0OQEj7adn5bEjZctWZg9Shat8bHtBWVK4QiSFUmKg7Fouw0XmUTumwxcvs2KilyVh2WGbA+R5Ztb3wJbMc+mpOSJDlXC0f0KwvNvuCXwgURI7XH5NkGJBehvKpmOrmM/Ddh/7W0cD4mktUnqJ7w9ys0lJ54eiFXlCMG/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1wwW+zUTOwPAGj3HYik+PZx/EHfM+37eqj6dshoexCM=;
 b=FgKILG7LorHSuN3QdyaLRVHSFrcs6o0INDTU35wTNzZNLC3N1vYpcBBFv37ulB/j7aEHe8bwhhbteZBEA20xQteLKVTvN9sFNphffz+sRZvekxLRAdSn50W8eyxM3Bkci7QkfzXKpgyrpK38dJl7n/K9EuQxNx+kzyU3w4uQsBLN326XDrVkDoJ0wAiRXaCR64Lck/m99f1nN4Ikbgs5fJ32AIWzRM3WFIAHjf5TM1sm+nMQXQ8Mzz38iqaMH9IiSrgDylMbULSmefmGlsyPCYzRwDfTuu2B5SxGpv2+RcaEf3pkMNV/9xvYBgQJcHI7G3zmR4myVXWj1AgA/8MKnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1wwW+zUTOwPAGj3HYik+PZx/EHfM+37eqj6dshoexCM=;
 b=gCa1EEUUhd+TwjxwgyQaV9Y6bFfcfipN+6RfPZMHzeIHugKoYnXo+eeaCHGawS8p3wH1sWwd+YUmCuF1yEidMJ/dtNsvzkM6PnKUUZb7szSTNMEoDx5uLoovYvomc8S48jomskpa/qEWz+lT0rC/f/fFBGnPcxyksbwFcLlcyek=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY4P286MB6910.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:33c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 05:06:38 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%3]) with mapi id 15.21.0223.008; Fri, 17 Jul 2026
 05:06:38 +0000
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
Subject: [PATCH v5 0/6] PCI: endpoint: Expose endpoint DMA resources (part 2/3)
Date: Fri, 17 Jul 2026 14:06:29 +0900
Message-ID: <20260717050635.2145014-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0082.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7b::20) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY4P286MB6910:EE_
X-MS-Office365-Filtering-Correlation-Id: e82e22be-ef90-43dc-d40c-08dee3c12eb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|7416014|1800799024|366016|10070799003|56012099006|10067099003|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	v+xzvmSoi1vTNmnILD1X7ee4LK+YR4ImGX4etZ0RjzjgrckTa/LuVyKQ1Pd7VaZk4bgZkW7OcL1c70/1bunJ6kkCsgGJHPaF/RBTFoZx9RryHVkR6W/Y5PveH2yjSsq7+TBrtsF3iKfQhmM3O7s1XYUVL4aJNG+mGj2dUL/7dGcu7gsBXENWZ5BVr21paCMWuG/NrsUAkYK05b1FW7a33UntA4VCONC9gwaO4yN9qSkAT897IRfN6BxuIuyqUYFHK50ShJDAZgM8hjPocBEq1jIe47tc/RwrVIf2uVwFeXOT/OglPiHowEEjj/UOhVEdNH/zM7iOLmzEG68pjy7FYBN7VjGWMwjS7QU4lWCAniPd1fS+frRy2T+tPm7jzoghtpF0qfjNhb56fkZBYBvrSaGhgVuh1R6PMZUHxlNH7ghvdEcLzJe1Qj1a3y0E2VulVH+7WZxKuUX0QYmKQb/ETF6IzN66PJFd+S76E7EPK3cZ5+CoRZqFsj9szKSShOHjj2cFmCYe6wxYpIHNoEy615P+bQBNvGkwi+bv1YTTt77JBvmUkbA20U1qoaGzdfvQC+OgrHz7XFDMgds7J9s55KwWN0K3mCiP6i9AMYpF/OyJu8VwGZnrJ7Zm0Jh2fzUIarvwpD6cYnNFXBZx01gq7eOBEz+afw/6sRBZmX+Tf9g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(1800799024)(366016)(10070799003)(56012099006)(10067099003)(6133799003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Yrv9j4x7fvzMhdVVF6GVom/FAgYkR3IfUWc3UsTrOKkKDrn0f65OQtHz5QfF?=
 =?us-ascii?Q?6TX05O/4FQ81Aj7U7FrueYQtsxEgj5B1iV5MiKAGZhVaqaNTHu1GDefjoe1/?=
 =?us-ascii?Q?UuVOUqoKsRXyyc7DZtgplmOLxpKg60XPWu5yFR90GkZxrBsZxoS5AotUmpbx?=
 =?us-ascii?Q?JF5LYiTn/jO+11Hu7H91j+CMwDnie3CDst4I7SdYkHpwJkbAKkeOWXOjNe9H?=
 =?us-ascii?Q?RYyXVvAUX+R8mK8klXripDcIRu3UkVlYf3Ug1JNOsPKEqN9obIzvG2ym6u2S?=
 =?us-ascii?Q?OT3sAOc1jsh7WnI/k4jFP5ZE/kd5QSCUwpDe23+foVXrM2SEbX1Fq1v/e48L?=
 =?us-ascii?Q?qEufJjffsPhmWCLCuHu7Pi5z8ql87x8/e5sfmx/O3GvZVMvvroscLVyyLx8J?=
 =?us-ascii?Q?0GH5p55cPejFjBj311gvqf3lvboKIxTtz4g6uAraMWoQGhqbAmDpF6yAjKVn?=
 =?us-ascii?Q?9spH8cpwy02AvtKEMSU0jA3HHkMT9cUceyfN+JJFegpVDnOg1lYgI41rt2xU?=
 =?us-ascii?Q?lyzcc0GUZh9ZqoqbeSC3NCbEfCDk9Pyun5dHBDdpffay9vU0qyHY8K4a3Mbz?=
 =?us-ascii?Q?EDAbfIumxqn5nZnz+B460SALnRlqJkWp1WmnGKRpbmXF33SAGVdv6qjZjfml?=
 =?us-ascii?Q?OASkbvr97/9DPUCROl76d4VeMaBMLENQOiOK3e4fJtmxjvAcLv3qJ56J/Zly?=
 =?us-ascii?Q?6HUBi88zQKAdxqFpwl2B2M343FND3ik7JGfOVJ2ba0Xirsc4/epUtI91FxK8?=
 =?us-ascii?Q?aHS26geQalUwP8w44jUVa5wHyjcsZwBc9awhUjq40DnkQYi9ppwAXQOvdE9E?=
 =?us-ascii?Q?rNHaa4bn2HUsoJ963BYMo8beaAi2BDc3aYEutrNF/WZgMlifxGAo0MJ4hHMQ?=
 =?us-ascii?Q?XLBAYoYO0oH+YCJsUXVrcz8KTN/7NgIrDs7ND6ix0KG4Ii8KKPXmurzVaeaT?=
 =?us-ascii?Q?QiJH1mr3JvO+QAPpIVcLp5A2v2z3r6JxrEQxmadSv9+35Zeq/bg2ZjMGKvXA?=
 =?us-ascii?Q?XB8h677liTFrpqNWNizn6pTceUWIZVNrNUT8CtOJYp/ikPDd4kLKXDO3Dk6p?=
 =?us-ascii?Q?l7D8ic+px/I9evruPeTsOb5JoXBfDSw0WVLOzGJGh5a97pE/quB89BbYiOfx?=
 =?us-ascii?Q?LsnasY9KQxotpkPXJ5otc7oe536kGa54ViAuIcKj/cS8LXs0q9SAN4FExTG2?=
 =?us-ascii?Q?dmYJp0rodAH3vvwFH5pMttzVsQxYvWR0O/htN8UemSfXZxQwjgKmx58BgfEc?=
 =?us-ascii?Q?dxCv8DMMbKXIJT15uwLnQvfQYdew6ozVGpkG+UvnUC2ZTBvSMum6QakB53jh?=
 =?us-ascii?Q?3IJdxcYBK2BqDxLY2ibgKg9rn5GOOdRk0yrnymYG20IrdaJhWeMnf8IVJyxO?=
 =?us-ascii?Q?E5i5DuT20StNVKio6+BwWRPHIBFGE8KIK06SCQuSLFbOEra1458JIzUT4OGZ?=
 =?us-ascii?Q?8R6Zj250PVxgubzH3HbENC9zdbssp3hFPh0fTMPjMbiHHxX5c4kYdYYF6ulr?=
 =?us-ascii?Q?7jktFfATVtdd5FazkaouNEjfzdTjM9KRZiE+j4N2B3A2L4GS3QPJlS9v2MIv?=
 =?us-ascii?Q?dPNu27eL8S2S3mbLgcA6QXY2FiDmu/LUwGw8hsEJPsNYKs6PFVDtoATzoN/R?=
 =?us-ascii?Q?pwFC8aq9n2O6aSVsOGDxhcFiB5Rpq1EjcUmLvG+w5Ta/sUV8KpgsIFtJjiXU?=
 =?us-ascii?Q?xIsVs2l2s5cmYuLlHfu1RmOoiI5Ha+oCC0xXxBIleAvFBLsP/sanMttQ58it?=
 =?us-ascii?Q?jApkI/EYCTwK4nAiLDzPgmh2gH9akZuStg47G/VuKua8S3cpBvTk?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: e82e22be-ef90-43dc-d40c-08dee3c12eb7
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 05:06:38.5828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TgM6U9itNo/mcZj6nhJyk6j074q7lJL1egtF5YbhJPnMLSiNr4slGGwu3JhKIUXzdgl4XSnC31ozrN6TRHNfxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4P286MB6910

Hi,

This is v5, part 2 of three series for PCI endpoint DMA.

The three series are:

  * part 1: dmaengine: dw-edma: Prepare for PCI EP DMA
  * part 2: PCI: endpoint: Expose endpoint DMA resources
  * part 3: PCI: endpoint: Add PCI DMA endpoint function

This series defines the endpoint DMA BAR metadata and auxiliary
resources, adds EPC operations for DMA channel delegation, and teaches
the DesignWare endpoint controller to publish and delegate its
integrated DMA resources.

The metadata lives in a normal endpoint BAR, not in PCI config space.
This keeps discovery independent from controller-specific writable
extended capability storage.

This series depends on part 1:

  [PATCH v5 00/14] dmaengine: dw-edma: Prepare for PCI EP DMA (part 1/3)
  https://lore.kernel.org/r/20260717050308.2144108-1-den@valinux.co.jp

Best regards,
Koichiro
---
Changes in v5:
  - Keep reporting a standalone doorbell when linked-list DMA resources
    are unavailable. (Sashiko)
  - Serialize irq_mode restoration with channel state updates. (Sashiko)
  - Clarify the provider-defined sharing-group quiesce contract.
  - Use guard()/scoped_guard() for new code.

Changes in v4:
  - Rebased onto the new part 1 series.
  - "dmaengine: dw-edma: Add delegated channel request helpers" moved
    from part 1 into this series, next to its only users; this also
    resolves the undeclared-functions issue reported against v3 5/5.
    (Sashiko)
  - Lift the v3 PF0-only restriction on DMA resource exposure and
    channel delegation: part 1 now programs the per-channel requester
    function number. Delegation to PF1+ therefore requires part 1
    applied on the host side.
  - Move pci_epc_function_is_valid() up to avoid a potential error
    pointer dereference. (Sashiko)

Changes in v3:
  - Decouple logical DMA channel metadata from descriptor memory resources.
    Logical channels now refer to descriptor memory by resource ID instead
    of embedding descriptor metadata in each channel resource. (Sashiko)
  - Replace the v2 DMAengine filter-callback metadata with EPC-level DMA
    channel delegation/reclaim operations, keeping DMAengine provider
    details out of generic EPC resource metadata.
  - Add the DesignWare EPC backend for DMA channel delegation.
  - Limit DesignWare endpoint DMA resource exposure to linked-list channels
    until non-LL metadata and host-side parsing are added.
  - Suppress DesignWare DMA auxiliary resources when the local DW eDMA
    provider is not available.
  - Reject VF DMA resource and delegation requests because the DWC
    eDMA/HDMA register window exposed to the Root Complex is PF-only.

Changes in v2:
  - Follow the part 1/3 v2 channel-claim model: EPC DMA resources now
    carry DMAengine filter information instead of raw DMA channel
    pointers. (Sashiko)
  - Update the DesignWare endpoint resource provider accordingly. (Sashiko)

v4: https://lore.kernel.org/r/20260710082156.2395844-1-den@valinux.co.jp/
v3: https://lore.kernel.org/r/20260620170438.3756593-1-den@valinux.co.jp/
v2: https://lore.kernel.org/r/20260525063129.3316894-1-den@valinux.co.jp/
v1: https://lore.kernel.org/r/20260521063405.2842644-1-den@valinux.co.jp/


Koichiro Den (6):
  PCI: endpoint: Define endpoint DMA BAR metadata format
  PCI: endpoint: Add DMA auxiliary resource metadata
  PCI: endpoint: Add API to delegate EPC DMA channels to the host
  PCI: dwc: Expose endpoint DMA resources
  dmaengine: dw-edma: Add delegated channel request helpers
  PCI: dwc: Implement endpoint DMA channel delegation

 MAINTAINERS                                   |   1 +
 drivers/dma/dw-edma/dw-edma-core.c            |  91 +++++++++
 .../pci/controller/dwc/pcie-designware-ep.c   | 175 +++++++++++++++++-
 drivers/pci/endpoint/pci-epc-core.c           | 105 +++++++++++
 include/linux/dma/edma.h                      |  14 ++
 include/linux/pci-ep-dma.h                    | 170 +++++++++++++++++
 include/linux/pci-epc.h                       |  62 +++++++
 7 files changed, 614 insertions(+), 4 deletions(-)
 create mode 100644 include/linux/pci-ep-dma.h

-- 
2.51.0


Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.67
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793943696;
	b=bmFfGz0M0hyrNIVKrJI9U8hHe7MwU4imxtDubSErVSlFeqUzXDB/bW0HDu73JsPOKGGu
	 Ce0VLocFWgs/ijgw3Na1xIf7VVSueRm2VbRf7PdEmtClb6W3Y2Yw8B942Oj1lLpZcDKTI
	 2T/zFLn13zoTxM8VsWk7qhsRP3LOcu6JAf6snzh0ToXkVfF8LnqTL7LSip03+4VXtfqPp
	 RZijkxTRwcPiP0dirJYjHVAy4bAMkMykCn0D31/HgwmOJDMPgF92ATFPrJw2muRCTXxjw
	 8oZnbeVgsg1psLJmZBFl4y0wfOaqjdpBRk6yIqcEUQ0Esoi5Vyq0licMy1cXOtL9fcQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793943696;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=b/pacOJmD1JXCZeGEU4C7R08JaIwKIkpw+AUSbknYj4=;
	b=tz2ir45ac602wHXLlzRsdo7eyuzqX0Ao90S7OJWJhZUdyKV1ejqJU12f+ZTSPhnY4K0g
	 /RC+Bvovogw+vN735CxsKwGdoxp2avFNWZfElgCo9sJ7EtgRfdbKCiMd+2U9T+j96CV/V
	 3g8PcGtirvUT0J3ozYeVkVg0TxBOesgZS5dXqOLi+DFUjt7xSGz//JXqQacFGiAVPiHek
	 1bV+MCjyFo/19njuis7hotYmYMHVKtLkVqJsRYAMn2H7mlnN9JDGtDWBCQqxHK9XOAapF
	 THcJudN/gR7pxwwkSXHInPsJ4RcYA6cZK8zDY9ZTHxe4NGyZ/lwTdjO78tjFXt88vmA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=InEX2vN2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.67
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012067.outbound.protection.outlook.com [52.101.43.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39030606A326;
	Fri,  6 Nov 2026 05:41:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39030606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=InEX2vN2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w27UBuDA0GEcs5IFR39qfTIk41QKksrAMbvYji0+mGRWMcfU++mrELYDmP6zh3008IwuY5iJ9JYcg2eBGcTFDoCa55I7pSwy23r0DBpfpW3SIONGh18gBdCT4+axRd1fqfCeudcAFekFq6JThLKC8nxacXn8SQqf8KMXC1sGYaqupNaUg1tQK9h24wa22rv3sKbxya/NunsIszuatuizuIAmCrrDd0+1NJgxxzlPa4p34QsSsjL6tU4KvAsbhyvMNfmoWBBW5lo/9HIS4BkSlP5RZhWMMnF2Z8o3raLoGpie+batkKLFFgyo8pYgCKG7qLtFcdVNuAGCccW/4N/4Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b/pacOJmD1JXCZeGEU4C7R08JaIwKIkpw+AUSbknYj4=;
 b=N8GU8BYlwuHK6sjjt14NXpwl4vpi4lvsR6WpiwVaWCl1JJk5WFhMtPuOLbvUaA+3R1SQSDNxu5kGE70eFHOP1UHWqXqAcejHAeQX56d4pNOpG5YilN9/aEyIkQr0ybNgo87cNreji01i3zD7d/CE+ciuS9yfN/fTfDmZEuixMRzsBPsXH7EoicwAilTG+d99nZ6EtliToBsxWcaBQb9t9zPeyMsmw/qRH3vO6D6zFP+TK2CSPh/2s9rARkmoIM53CqLbZlWQQ8zqgZ2OxztWoFSJHIOcbbMn5psix+s9G9VqR97Aoapk6fGEn2g6Y2h4WP18atxw68Aj21sGebEgnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b/pacOJmD1JXCZeGEU4C7R08JaIwKIkpw+AUSbknYj4=;
 b=InEX2vN26AsFZZHGMSS6d2g8qa5mDSWhRtaGUzdDXhyljnbOx3WRxv9WvFoYTH6SdmIWmEdzhiM0AnDOvcveJFazFJUtxSOvtubSlEBobrccDdrfLubCPmQMRBhv6JTxd+VKlPt4tL4vv8xuMqU7NVMe2udowWdlOgBGT58ETIsuaDwO2djRWWtiMJw7DVhNgQjngk3oAmHvomqsaNjaEO4+7agj8Rkc9l8EYO+N2GitYQn2e3HnzmH3qwgzdji+1Wg9CYNqqxiovboQaubsn8GpGh2uV570xQwrWn8ybxIoNE3j+lakXHL/RkLxSHh/3MYsunFvN1FxMKz0pHFvOQ==
Received: from MW4PR04CA0342.namprd04.prod.outlook.com (2603:10b6:303:8a::17)
 by SA3PR12MB324744.namprd12.prod.outlook.com (2603:10b6:806:531::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 05:41:30 +0000
Received: from MWH0EPF000D8951.namprd05.prod.outlook.com
 (2603:10b6:303:8a:cafe::91) by MW4PR04CA0342.outlook.office365.com
 (2603:10b6:303:8a::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Fri, 6
 Nov 2026 05:41:29 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000D8951.mail.protection.outlook.com (10.167.249.217) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 05:41:29 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 5 Nov
 2026 21:41:11 -0800
Received: from kalok-SPC741D16QM3.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 21:40:59 -0800
From: Alok Kumar <alkumar@nvidia.com>
To: <dakr@kernel.org>, <acourbot@nvidia.com>, <kvm@vger.kernel.org>,
	<rust-for-linux@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
	<linux-pci@vger.kernel.org>
CC: <alex@shazbot.org>, <jgg@nvidia.com>, <yishaih@nvidia.com>,
	<skolothumtho@nvidia.com>, <kevin.tian@intel.com>, <airlied@gmail.com>,
	<simona@ffwll.ch>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
	<boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
	<lossin@kernel.org>, <a.hindborg@kernel.org>, <aliceryhl@google.com>,
	<tmgross@umich.edu>, <markus.probst@posteo.de>, <jhubbard@nvidia.com>,
	<apopple@nvidia.com>, <joelagnelf@nvidia.com>, <ecourtney@nvidia.com>,
	<cjia@nvidia.com>, <smitra@nvidia.com>, <kjaju@nvidia.com>,
	<alkumar@nvidia.com>, <ankita@nvidia.com>, <aniketa@nvidia.com>,
	<kwankhede@nvidia.com>, <targupta@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <zhiwang@kernel.org>, <zhiw@nvidia.com>,
	<boqun@kernel.org>, <daniel.almeida@collabora.com>, <tamird@kernel.org>,
	<work@onurozkan.dev>, <jgg@ziepe.ca>, <bhelgaas@google.com>,
	<kwilczynski@kernel.org>, <dri-devel@lists.freedesktop.org>,
	<peter@colberg.org>, <xinmengs@nvidia.com>
Subject: [PATCH v4 00/32] Introduce NVIDIA vGPU manager
Date: Fri, 6 Nov 2026 11:09:33 +0530
Message-ID: <cover.1793906667.git.alkumar@nvidia.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000D8951:EE_|SA3PR12MB324744:EE_
X-MS-Office365-Filtering-Correlation-Id: d8aa44a3-78aa-4f68-cda5-08df3bc89b87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|82310400026|376014|7416014|1800799024|260925022911599003|261022115727099003|261022105027099003|261022113327099003|261022075727099003|261021130227099003|261021135927099003|261028144727099003|261021123027099003|261021121427099003|261026130827099003|261026140227099003|261026121527099003|261102130727099003|261102123227099003|11063799006|56012099006|10067099003|5023799004|260925021311599003|18002099003|261009223027099003|13003099007|6133799003|3023799007|260925021911599003;
X-Microsoft-Antispam-Message-Info:
	Hs+zBgYvPmGEkrdS+xqakbgwwOsr8RMhPeJURaLX6b6IhbjHmFKGgZmfrSB7ir+rrSJKkFORc4E/qHdWktTOgUlFc4pz0/trmgizQ5mHKMm37qFNwFx5NJlbcn7xXR30DS5Da6QCnd4iI9+7C9Zf/77RYw/BYGNlBgef8K3MYbiYQNjH9ELS+Sx4wAllVW3zzvAf5qLsxZXQjWTchwndNh/Mhj5YpPkVJNEu1HPVmEss1ObGWTlHrXIXRSSueBQJ4kyudLZmU92tbVVKDF81L5+y2mQ0kiOt2/qf386IT2MRivH/eaP5OxHACfsq46RdH93ERnihv6pFhluX1i/uuAo1R6Gghp/m4sktKQFvc5jxjmNfQzQgQ5Cbxr8rVfkDMgq0DpzU8bLzkg/D2HPyju60k06ndWmOyIbzdlORUoQ9BkvV3pkTR7yRw5HDolFH6hV53Jg8N8z6U6wqBanYi6oAnrE6Ii5DVQBOfb6Nwee9PTp5Jhbcs8oQo98xGfhYmE1v0IxUSFMW9Sq0OB0oWiH97y1/ZG9PWW1Adx2H+M7E1NQzlYh6ebFls83Ck05MnhbQvl+fCQ9BdfOLYy2iFioNeBVN0E8/plcypiWewlpj+kQk50572I20nnXSrsybiB90FVawYCvjfsA7WZH1VymUq6RAMcpKlwEQMnJaJ3XS8FevMF7z/d/FNRPumwf8L4QA0t+1LY4DHOSyjrTUAA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(82310400026)(376014)(7416014)(1800799024)(260925022911599003)(261022115727099003)(261022105027099003)(261022113327099003)(261022075727099003)(261021130227099003)(261021135927099003)(261028144727099003)(261021123027099003)(261021121427099003)(261026130827099003)(261026140227099003)(261026121527099003)(261102130727099003)(261102123227099003)(11063799006)(56012099006)(10067099003)(5023799004)(260925021311599003)(18002099003)(261009223027099003)(13003099007)(6133799003)(3023799007)(260925021911599003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	PDlpsMlDZtbLGlj93uie21oCS9RUeK4ej6v5aO9DKug9H3i7Q16DPM21xJdjx7Zrip3/R8Tp9640AmjXcJGCvukHszpj4sibsKjgoXT3noM1C/qcLpFiJX+7LAWRua3kbUotouWLqiBYccMv4+wcp2bNaAeymIuSehsbrAZGlEh+AfnyPs1Del6IUtcsL1y2AUgtoRya3XUY+D2yAy3GSA+BL85mkgyp38PzgaUfidApHqgqSlTaMTJg3fLGZ/aDMf6K0TQYF+2mJJzHnMm/KZ0qgPXVpzJk+No9D5PSSl0msuq49V/zWoOK79Qx04/vdYD4CKDO2YTTPqg9Hfl0bJnvq+XofeOCsPG+1tHcqpcrQ/wfmbdm7ewcgrpUcXoQhhSfnzY5F2M/vaDx4HfActT/e3Qp7LMXriiL2t72iGbFmmdGXS0VA8P+XZyxnvjH
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 05:41:29.8148
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8aa44a3-78aa-4f68-cda5-08df3bc89b87
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000D8951.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB324744

Add the nova-core support needed to create and manage NVIDIA vGPU
instances on the current whole-GPU SR-IOV path.

The overall control path is shown below. This posting contains the
nova-core manager and PF-side lifecycle APIs. Typed PF-service
publication and the VFIO variant driver follow separately.

 +-----------------------+         +-----------------------+
 | Linux guest           |         | Windows guest         |
 | NVIDIA guest driver   |         | NVIDIA guest driver   |
 +-----------+-----------+         +-----------+-----------+
             |                                 |
 +-----------v-----------+         +-----------v-----------+
 | QEMU (VFIO user)      |         | QEMU (VFIO user)      |
 +-----------+-----------+         +-----------+-----------+
             +----------------+----------------+
                              |
                      +-------v-------+
                      |   VFIO core   |
                      +-------+-------+
                              |
        +---------------------v---------------------+
        | NVIDIA vGPU VFIO variant driver           |
        +---------------------+---------------------+
                              |
              +---------------+----------------------+
              | binds PCI VF                         | PF lifecycle API
              |                                      | open / close / reset
              v                                      v
     +--------+--------+               +-------------+-------------+
     |    PCI VF(s)    |               | nova-core (PF driver)     |
     |  (virtual GPU)  |               |       vGPU Manager        |
     +--------+--------+               |     VRAM / channels ...   |
              |                        +-------------+-------------+
              |                                      |
+-------------v--------------------------------------v----------------+
|                      NVIDIA physical GPU                            |
|            VF resources                 PF / GSP / VRAM             |
+---------------------------------------------------------------------+

The manager queries the type assigned to a VF by GSP-RM, reserves its
channel and VRAM resources, boots and configures the GSP plugin, and
handles shutdown. It also scrubs guest VRAM before reuse and exposes
per-instance plugin logs through debugfs.

Host resources remain owned until firmware teardown and BAR unmapping
complete. Failed creation rolls back through the instance owner; if
firmware ownership is uncertain or teardown fails, the manager retains
the affected resources until device removal.

This continues the rework of the earlier vGPU RFC [2]: firmware-facing
management belongs to nova-core, while the VFIO driver binds to the VF
and uses the PF's services. The companion VFIO driver does not need its
own copies of the RM firmware headers.

The patches are organized as follows:

  1     Retain BAR1 reservations after an unmap failure.
  2-8   Boot state, runtime parameters and the 48-VM WPR2 heap.
  9-12  VRAM allocation, region views and BAR mappings.
 13-14  Synchronous GMC transactions and completion events.
 15-19  Plugin bindings, property queries and instance allocation.
 20-28  Plugin boot, shutdown and RPC.
 29-31  CeUtils scrubbing and plugin logs.
 32     SR-IOV PF lifecycle APIs.

Changes since v3:
* Include the BAR1 unmap-failure fix as patch 1.
* Rebase onto r000 firmware stack and drop changes already supplied by the prerequisites.
* Adapt boot-state/VF information handling, firmware encoding and GMC
  transactions to the interfaces supplied by that newer stack.

Dependencies:
This series is based on drm-rust-next at
41871f4ddf710339863f957bcfcab5094c234771 plus the r000 GSP firmware
and other integration prerequisites.

The complete integration tree, including the prerequisites and the
companion VFIO driver, is available at:

    https://github.com/alokk-nvidia/nova-core/tree/nova-vgpu-wip-20261105

Previous versions:
v3: [1]
v2: https://lore.kernel.org/nova-gpu/20260914074907.1399629-1-zhiw@nvidia.com/
v1: https://lore.kernel.org/nova-gpu/20260905081116.106613-1-zhiw@nvidia.com/

[1] https://lore.kernel.org/nova-gpu/cover.1790580105.git.zhiw@nvidia.com/
[2] https://lore.kernel.org/kvm/20250903221111.3866249-1-zhiw@nvidia.com/

Alok Kumar (2):
  gpu: nova-core: gsp: decode the FIFO engine table
  gpu: nova-core: vgpu: add VRAM slot allocator

Zhi Wang (30):
  gpu: nova-core: mm: retain BAR1 reservations after unmap failure
  gpu: nova-core: gsp: pass boot context through setup helpers
  gpu: nova-core: gsp: decouple boot context from VgpuManager
  gpu: nova-core: vgpu: detect boot state independently
  gpu: nova-core: gpu: add a channel ID pool for vGPU
  gpu: nova-core: vgpu: initialize runtime parameters after GSP boot
  gpu: nova-core: vgpu: reserve the 48-VM WPR2 heap
  gpu: nova-core: mm: borrow BarUser for temporary BAR1 access
  gpu: nova-core: mm: add VramBlock
  gpu: nova-core: mm: add VramRegion
  gpu: nova-core: mm: add BarMapping
  gpu: nova-core: gsp: add synchronous GMC transactions
  gpu: nova-core: gsp: wait for GMC completion events
  gpu: nova-core: vgpu: add r000 plugin bindings
  gpu: nova-core: gsp: factor out NVKV payload conversion
  gpu: nova-core: vgpu: query VF assignments and properties
  gpu: nova-core: vgpu: add instance create/destroy
  gpu: nova-core: vgpu: encode vGPU boot requests
  gpu: nova-core: vgpu: add GSP plugin communication buffers
  gpu: nova-core: vgpu: add instance boot
  gpu: nova-core: vgpu: add instance shutdown
  gpu: nova-core: vgpu: initialize GSP plugin RPC buffers
  gpu: nova-core: vgpu: add GSP plugin RPC transactions
  gpu: nova-core: vgpu: negotiate the GSP plugin RPC version
  gpu: nova-core: vgpu: send GSP plugin configuration parameters
  gpu: nova-core: vgpu: update the GSP plugin BME state
  gpu: nova-core: vgpu: add CeUtils commands
  gpu: nova-core: vgpu: scrub guest VRAM with CeUtils
  gpu: nova-core: vgpu: export plugin log buffers via debugfs
  gpu: nova-core: vgpu: introduce SR-IOV PF APIs

 Documentation/gpu/nova/core/interrupts.rst    |  20 +-
 drivers/gpu/nova-core/fb.rs                   |  28 +-
 drivers/gpu/nova-core/gpu.rs                  | 111 ++-
 drivers/gpu/nova-core/gpu/channel.rs          |   4 +
 drivers/gpu/nova-core/gsp.rs                  |  30 +-
 drivers/gpu/nova-core/gsp/boot.rs             |   8 +-
 drivers/gpu/nova-core/gsp/cmdq.rs             |  28 +-
 drivers/gpu/nova-core/gsp/cmdq/gmc.rs         | 223 +++++-
 drivers/gpu/nova-core/gsp/commands.rs         |  11 +
 drivers/gpu/nova-core/gsp/commands/gmc.rs     |  34 +-
 drivers/gpu/nova-core/gsp/fw.rs               |  44 +-
 drivers/gpu/nova-core/gsp/fw/commands.rs      | 108 ++-
 .../gpu/nova-core/gsp/fw/r000_00/bindings.rs  | 175 +++++
 drivers/gpu/nova-core/gsp/hal/gh100.rs        |   2 +-
 drivers/gpu/nova-core/gsp/hal/tu102.rs        |   2 +-
 drivers/gpu/nova-core/gsp/nvkv.rs             |  42 +-
 drivers/gpu/nova-core/gsp/nvkv/encode.rs      |  12 +
 drivers/gpu/nova-core/mm.rs                   |   1 +
 drivers/gpu/nova-core/mm/bar_user.rs          | 209 +++++-
 drivers/gpu/nova-core/mm/vmm.rs               |  18 +-
 drivers/gpu/nova-core/mm/vram.rs              | 131 ++++
 drivers/gpu/nova-core/nova_core.rs            |   6 +
 drivers/gpu/nova-core/regs.rs                 |  31 +-
 drivers/gpu/nova-core/vgpu.rs                 | 111 ++-
 drivers/gpu/nova-core/vgpu/commands.rs        | 321 +++++++++
 drivers/gpu/nova-core/vgpu/fw.rs              |  70 ++
 drivers/gpu/nova-core/vgpu/fw/commands.rs     | 470 +++++++++++++
 drivers/gpu/nova-core/vgpu/gsp_plugin_comm.rs | 496 ++++++++++++++
 drivers/gpu/nova-core/vgpu/gsp_plugin_rpc.rs  | 170 +++++
 drivers/gpu/nova-core/vgpu/instance.rs        | 642 ++++++++++++++++++
 drivers/gpu/nova-core/vgpu/log.rs             | 171 +++++
 drivers/gpu/nova-core/vgpu/scrubber.rs        | 173 +++++
 drivers/gpu/nova-core/vgpu/vgpu_api.rs        | 158 +++++
 drivers/gpu/nova-core/vgpu/vram.rs            | 179 +++++
 34 files changed, 4085 insertions(+), 154 deletions(-)
 create mode 100644 drivers/gpu/nova-core/mm/vram.rs
 create mode 100644 drivers/gpu/nova-core/vgpu/commands.rs
 create mode 100644 drivers/gpu/nova-core/vgpu/fw.rs
 create mode 100644 drivers/gpu/nova-core/vgpu/fw/commands.rs
 create mode 100644 drivers/gpu/nova-core/vgpu/gsp_plugin_comm.rs
 create mode 100644 drivers/gpu/nova-core/vgpu/gsp_plugin_rpc.rs
 create mode 100644 drivers/gpu/nova-core/vgpu/instance.rs
 create mode 100644 drivers/gpu/nova-core/vgpu/log.rs
 create mode 100644 drivers/gpu/nova-core/vgpu/scrubber.rs
 create mode 100644 drivers/gpu/nova-core/vgpu/vgpu_api.rs
 create mode 100644 drivers/gpu/nova-core/vgpu/vram.rs


base-commit: ccfd86490ddf6fd9c8f59a1a3171c652afb44c7f
-- 
2.53.0


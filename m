Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.70
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795528849;
	b=4cHKoVtCxYdpxKJgkf2TVvmfBXpPpuRoykdFhGzuRyDX5ttcn3BSgkhnS5/fhwVkzfch
	 p1ghRVuuM0oO94mehoIweAWCak2J2mVh8znnvhNsZf9nJC4Qk+09XzioPdRmoC5kDNhdi
	 XeJBGytvTIhMXv90x1kCEmKX8F0ab3JJdEwbpfDK67aMkfcmVYD7ubSd/BMPhBjMnbBWB
	 MF4NSy8WKib1o9QkI3XYmvvboxbyDKLm/E89TCRBITqphwQAoA8QHIqlQij4twqq2oHjL
	 Cu6r99Du8czjYZhmF9nJmFWi2ZwP3uWb/VJdxweIKGy8qtyMp2vF13+X+cBXtxHSSTw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795528849;
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
	bh=3/qqqgrpPiTXcXj/266oFciaDVvenAuW6UxQbKtq5P8=;
	b=n5mYoXKAQK+cJ1MsUkZ3qW5G5Va6kSRh89InPtPC+KXVuhb50mota5Jsv8PPlLz7M4Xa
	 ALNpewWqJ2C8NY86PR8TaTlCbbPwZ1ZgKinIqw+zdlSM3+J82wMQHUt3NgTZUG9OfjV9v
	 QG8BFp5+wozEIG7XXyTtQFplgYvmBsu8Ymhl76Ze9pMT8OOmZ9wShPrqh6ncop/JDnDVO
	 m/e90xu/FozGjYOiHzO1gscvuAsYw/YLDSt00Ytg6FnWkUfpRw5XtQnXAxXt1rQoq8+rm
	 cxEMB8y/CEO9yoXVGwUp2eh16aNZiYufvgIKaxDZS05F9/Xw/sX9K1qyyUPA9iNeSVQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=E0vOZciE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.70
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013070.outbound.protection.outlook.com [40.93.196.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9E8606A338;
	Tue, 24 Nov 2026 14:00:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F9E8606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=E0vOZciE
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E8HRPNvbQN/2VHy+K61366E4YYZJrad2r6CacD6Dvr6o+IH2gokYFYlmHyfxjdYVq7/iVhYeSkvaKzR+x6i5mgi6FKy6zIuWGF7akd23ieOBOH/P6yaFMAfC95EK5ep/vFlLI7YXZm/kZrxPkTHuajSfAYCZYq7kaM2nZhyleJdtfaMdphJKXcTNv/Ku1f4OfZ4j4w4jzGHe49S4wYi5g8uWbyGb2kixGTlEJT+XMa2BrHTPv2tm+w3wBHF3+xLem0pNAV7LK86pEhDBQs07UYsUziXRTvFoo2TxYWEmgTpMl26oNl+5A7HzUw63WNqK9TrJbqqaHwCHq+kxEJboAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3/qqqgrpPiTXcXj/266oFciaDVvenAuW6UxQbKtq5P8=;
 b=WBW1EVfUQ0ndtYPs1M107YcZgv3LlYaBEsh9Uhp1HFIUvhpXiUmBBvUVOoUHjtjambqrqMBYUGPPhnWsRGdhr3HePmgm9XkM9IFaXOaEqJvYxEQfg2nZIdUkLeRzkcOT+8KGNjLXSg3JeW50bEMMmNtW/M/BD0eWxyLKJQxEKewSUeJsl8WmO2QBo0PrnEH7d20LjVn+oiHnv1MMkWc+zBN+kyi5ZMM39DA/xhVCLsODxrSAslCXsLJXNtMCxbdsJkaCDSCtUYhGeecWgnH0s0IFcbl+VEm1uUEOFgjoGNdgqrVD7WFjiQUS/my9YUNZlC5jQAQ36/ustBflU00g+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3/qqqgrpPiTXcXj/266oFciaDVvenAuW6UxQbKtq5P8=;
 b=E0vOZciELh/tN4mAWlULm15zPyQnlHtsAYB2KYCs899Mdptgo7MF73HpN9m2zlLHo6HYIwAm57DIfR0u7lquzQtYf+8spFlIswA9t1OhUP8nxy+wHWUJ/98+CEsNpAKdCjclYDQBMibNQqIFmdpnGhuCwjB8Qd7dgceyAFN3uvnqXro0/y2/z31fmb0zh2VSrnVKWQ4LI9b4uu4I1JOeMJUf5GlvTI3oME6s3MARMf4g5/hfmE/E5U1YGZ+tTkUAqOniTiOOZC9WGeN77ApZvPniVqioLyiXoeF1PC7HL/Ac5Dcyawsmh8K9gD+m/M3Xna8EdjsL62+YNFd293CxqA==
Received: from BL1PR13CA0137.namprd13.prod.outlook.com (2603:10b6:208:2bb::22)
 by DM4PR12MB5819.namprd12.prod.outlook.com (2603:10b6:8:63::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Tue, 24 Nov
 2026 14:00:37 +0000
Received: from BN3PEPF00022BD4.namprd03.prod.outlook.com
 (2603:10b6:208:2bb:cafe::98) by BL1PR13CA0137.outlook.office365.com
 (2603:10b6:208:2bb::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.6 via Frontend Transport; Tue, 24
 Nov 2026 14:00:37 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF00022BD4.mail.protection.outlook.com (10.167.248.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Tue, 24 Nov 2026 14:00:37 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 24 Nov
 2026 06:00:13 -0800
Received: from kalok-SPC741D16QM3.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 05:59:59 -0800
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
Subject: [PATCH v5 00/35] Introduce NVIDIA vGPU manager
Date: Tue, 24 Nov 2026 19:28:56 +0530
Message-ID: <20261124135937.18583-1-alkumar@nvidia.com>
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
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BD4:EE_|DM4PR12MB5819:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b2a019f-40d3-4d29-8410-08df4a3350ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700016|23010399003|1800799024|6133799003|18002099003|3023799007|260925021911599003|260925022911599003|261026140227099003|11063799006|261022113327099003|261021130227099003|56012099006|5023799004|261021123027099003|261021135927099003|261028144727099003|261026121527099003|261021121427099003|261009223027099003|261102123227099003|261022105027099003|261102130727099003|10067099003|261022075727099003|261022115727099003|260925021311599003|261026130827099003;
X-Microsoft-Antispam-Message-Info:
	6mccWild8a8r+fDMJxj9l9rppRUq2JFcSqYN5QFJyssrw23QWV1vbONz7cvpw74NECoUgXoCbCICaGGx6/yojD1VNq29AqyJDr9Ii9aCdm1cqqUPABz2Vp8aPrIARUSQS+elsobLaXvs/IwFDdUDldSAVVJFAwTlOFrWYBkXN9XIG5Ni7+bNlFMDsAt1TxK5dfmoNgzMrWJXVNjRI3RNVCXk/uyH1dYRbqHebvjw0oXXtYoEJuo+K4TfQrTLCcAhhtMP939wSUAHKK7cYYyMyrMJR8NxCbBSJJzl/V+x3mXtqM/EXZHss4igjCxpDuIPvJDUXbuW8X1OZT5EPhlD+yZHapEvMCML6G/knbRVHHdMnYVMO0jDTUKYjXyauFdRUM+OQzEy/9IEqv4leTdGSXny1VXfkFquU76XoET+WhewJ6Jd7ev3rbJnvVrekiCOSZuRUK3RCnHTPMchKLuyvhSTP0JQVxHzP78ZxtrPS4JIjx3ix0qy89MsJF0BAT6P7OgAfKxOtW1AyWZ2/Y2XsZ7EhjtAiNz6Ab67WKRBB69vV6foD6ZSL4ti1Hu8ZvBSFWu8DQvhS4sP1DrHICzCr/Uv2/ObyDw1y/9rWaEnH8XLWmBTDjANO9PHQW7WVas2u7tS4HKzy5eL3L8SnPJMRYmpE5YxGAiX2p39h4+miOHRayOV13ioLlBjiyNtF/H4SMrmiLYOP9y1r6C6fDxNKg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700016)(23010399003)(1800799024)(6133799003)(18002099003)(3023799007)(260925021911599003)(260925022911599003)(261026140227099003)(11063799006)(261022113327099003)(261021130227099003)(56012099006)(5023799004)(261021123027099003)(261021135927099003)(261028144727099003)(261026121527099003)(261021121427099003)(261009223027099003)(261102123227099003)(261022105027099003)(261102130727099003)(10067099003)(261022075727099003)(261022115727099003)(260925021311599003)(261026130827099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	d2a3H8CSXTBbWgYo1E+SWUl8EHP0Gd5Wwhro0Z8OJRdGjiZ7ZjzwrLAIag71/70MgcqpJqhdufGrgVyiIZzW/+KJSL5crnwxIDaJxkZlnDK0ThdurTUl/EYo0Cv9KJXuDpf0qoLb6bMUNjShJXU981f9KK3eyWaFWBRSG2ZwCQiLppzb1v6ZwNefVhnPAFn5sU4TEBsRqpG/WqAHZpWqop9N95h3SQEN+RdSzOqRzJqKdx5xT/sttlA3404huKjjhbmkUnEeYFASb1/bVssG+uW+bzvEt2vwjHXrfvr9c1/OmRbRH4LhPacjwDTAov1/jsXRyMZ73AFAKkWSF1ZxE+ts3lkh0Ud4feIRc89ZARtcmYi295nAGUIzaLuP7cFgMs56P9bmMmtvxSmmdljKSYDQPXaiNMu6K7QzrBQ8UnOjQtjMCD2f7b6+ruNZQ/f+
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 14:00:37.1178
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b2a019f-40d3-4d29-8410-08df4a3350ff
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF00022BD4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5819

Add the nova-core support needed to create and manage NVIDIA vGPU
instances on the whole-GPU SR-IOV path.

The overall control path is shown below. This series contains the
nova-core manager and PF-side lifecycle APIs. Typed PF-service
publication and the VFIO variant driver are separate series.

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
handles reset and shutdown. Guest VRAM is scrubbed before reuse.

Host resources remain owned until firmware teardown and BAR unmapping
complete. Failed creation rolls back through the instance owner. If
firmware ownership is uncertain or teardown fails, the manager retains
the affected resources until device removal.

This continues the rework of the earlier vGPU RFC [2]: firmware-facing
management belongs to nova-core, while the VFIO driver binds to the VF
and uses the PF's services. The companion VFIO driver does not need its
own copies of the RM firmware headers.

The patches are organized as follows:

  1-8   VF boot information, boot state, runtime parameters and WPR2 heap.
  9-15  Typed BAR1 access, mapping ownership and VRAM allocation.
 16-18  Typed GMC payloads, command IDs and completion-event waits.
 19-23  Plugin bindings, NVKV conversion, properties and allocation.
 24-31  Plugin boot requests, communication buffers, shutdown and RPC.
 32-33  CeUtils commands and guest VRAM scrubbing.
 34     SR-IOV PF lifecycle APIs.
 35     Preserve BAR1 self-test page-table ownership until GPU teardown.

Changes since v4 [1]:

  - Rebase onto the newer r000 firmware and vGPU integration stack.
  - Include VF information in GSP_INIT in this series.
  - Add typed BAR1 MMIO access and SharedGpuMm support, and rework the
    memory helpers and VRAM slot pool for the newer interfaces.
  - Use the existing typed GMC transaction API. Add variable-length
    payload aliases, vGPU command IDs and a typed completion-event wait.
  - Place plugin ABI definitions under vgpu/fw/r000_00, keeping them
    separate from the base GSP firmware bindings.
  - Query VgpuProperties through typed requests and retain BAR0 in the
    manager for instance plugin RPC setup.
  - Fold plugin RPC buffer initialization into the communication-buffer
    and RPC transaction patches.
  - Leave per-instance plugin log export through debugfs for a follow-up.
  - Include the BAR1 self-test lifetime fix as patch 35. The test borrows
    the persistent BarUser VMM and releases its lock before BarUser::map()
    acquires it again.

Dependencies:

The drm-rust-next base is:

https://gitlab.freedesktop.org/drm/rust/kernel/-/commit/0dbf41fd03abee01a37a83336ed84cd5812af633

The complete integration tree, including the prerequisites and the
companion VFIO driver, is available at:

  https://github.com/alokk-nvidia/nova-core/tree/nova-vgpu-wip-20261124

Previous versions:

v4 posting: [1]
v3 posting: [3]
v2 posting: [4]
v1 posting: [5]

[1]
https://lore.kernel.org/nova-gpu/cover.1793906667.git.alkumar@nvidia.com/
[2]
https://lore.kernel.org/kvm/20250903221111.3866249-1-zhiw@nvidia.com/
[3]
https://lore.kernel.org/nova-gpu/cover.1790580105.git.zhiw@nvidia.com/
[4]
https://lore.kernel.org/nova-gpu/20260914074907.1399629-1-zhiw@nvidia.com/
[5]
https://lore.kernel.org/nova-gpu/20260905081116.106613-1-zhiw@nvidia.com/

Alexandre Courbot (5):
  gpu: nova-core: mm: replace BarUserAccess accessors with typed MMIO
    view
  gpu: nova-core: mm: add SharedGpuMm
  gpu: nova-core: gsp: cmdq: gmc: add types for variable-length payloads
  gpu: nova-core: gsp: add the vGPU commands to GmcCommandId
  gpu: nova-core: gsp: cmdq: add send_gmc_command_await_event

Alok Kumar (2):
  gpu: nova-core: gsp: decode the FIFO engine table
  gpu: nova-core: vgpu: add VRAM slot pool

Zhi Wang (28):
  gpu: nova-core: populate VF information in GSP_INIT
  gpu: nova-core: gsp: pass boot context through setup helpers
  gpu: nova-core: gsp: decouple boot context from VgpuManager
  gpu: nova-core: vgpu: detect boot state independently
  gpu: nova-core: gpu: add a channel ID pool for vGPU
  gpu: nova-core: vgpu: initialize runtime parameters after GSP boot
  gpu: nova-core: vgpu: reserve the 48-VM WPR2 heap
  gpu: nova-core: mm: retain BAR1 reservations after unmap failure
  gpu: nova-core: mm: borrow BarUser for temporary BAR1 access
  gpu: nova-core: mm: add VramBlock
  gpu: nova-core: mm: add VramRegion
  gpu: nova-core: mm: add BarMapping
  gpu: nova-core: vgpu: add r000 plugin bindings
  gpu: nova-core: gsp: factor out NVKV payload conversion
  gpu: nova-core: vgpu: query VF assignments and properties
  gpu: nova-core: vgpu: add instance create/destroy
  gpu: nova-core: vgpu: encode vGPU boot requests
  gpu: nova-core: vgpu: add GSP plugin communication buffer
  gpu: nova-core: vgpu: add instance boot
  gpu: nova-core: vgpu: add instance shutdown
  gpu: nova-core: vgpu: add GSP plugin RPC transactions
  gpu: nova-core: vgpu: negotiate the GSP plugin RPC version
  gpu: nova-core: vgpu: send GSP plugin configuration parameters
  gpu: nova-core: vgpu: update the GSP plugin BME state
  gpu: nova-core: vgpu: add CeUtils commands
  gpu: nova-core: vgpu: scrub guest VRAM with CeUtils
  gpu: nova-core: vgpu: introduce SR-IOV PF APIs
  gpu: nova-core: mm: keep BAR1 self-test page tables alive

 drivers/gpu/nova-core/fb.rs                   |  28 +-
 drivers/gpu/nova-core/gpu.rs                  |  97 ++-
 drivers/gpu/nova-core/gpu/channel.rs          |   4 +
 drivers/gpu/nova-core/gsp.rs                  |   7 +-
 drivers/gpu/nova-core/gsp/boot.rs             |   2 +-
 drivers/gpu/nova-core/gsp/cmdq.rs             |   2 +-
 drivers/gpu/nova-core/gsp/cmdq/gmc.rs         |  68 ++-
 drivers/gpu/nova-core/gsp/commands.rs         |  11 +
 drivers/gpu/nova-core/gsp/commands/gmc.rs     |  86 ++-
 drivers/gpu/nova-core/gsp/fw.rs               |  23 +-
 drivers/gpu/nova-core/gsp/fw/commands.rs      | 127 +++-
 .../gpu/nova-core/gsp/fw/r000_00/bindings.rs  |   2 +
 drivers/gpu/nova-core/gsp/hal/gh100.rs        |   2 +-
 drivers/gpu/nova-core/gsp/hal/tu102.rs        |   2 +-
 drivers/gpu/nova-core/gsp/load_exec.rs        |   9 +-
 drivers/gpu/nova-core/gsp/nvkv.rs             |  42 +-
 drivers/gpu/nova-core/gsp/nvkv/encode.rs      |  12 +
 drivers/gpu/nova-core/mm.rs                   |  31 +-
 drivers/gpu/nova-core/mm/bar_user.rs          | 209 +++++--
 drivers/gpu/nova-core/mm/vmm.rs               |  18 +-
 drivers/gpu/nova-core/mm/vram.rs              | 141 +++++
 drivers/gpu/nova-core/nova_core.rs            |   6 +
 drivers/gpu/nova-core/regs.rs                 |  31 +-
 drivers/gpu/nova-core/sbuffer.rs              |   7 +
 drivers/gpu/nova-core/vgpu.rs                 | 136 ++++-
 drivers/gpu/nova-core/vgpu/commands.rs        | 412 +++++++++++++
 drivers/gpu/nova-core/vgpu/fw.rs              |  45 ++
 drivers/gpu/nova-core/vgpu/fw/commands.rs     | 402 +++++++++++++
 drivers/gpu/nova-core/vgpu/fw/r000_00.rs      |  25 +
 .../gpu/nova-core/vgpu/fw/r000_00/bindings.rs | 183 ++++++
 drivers/gpu/nova-core/vgpu/gsp_plugin_comm.rs | 243 ++++++++
 drivers/gpu/nova-core/vgpu/gsp_plugin_rpc.rs  | 170 ++++++
 drivers/gpu/nova-core/vgpu/instance.rs        | 559 ++++++++++++++++++
 drivers/gpu/nova-core/vgpu/scrubber.rs        | 172 ++++++
 drivers/gpu/nova-core/vgpu/vgpu_api.rs        | 153 +++++
 drivers/gpu/nova-core/vgpu/vram.rs            | 150 +++++
 36 files changed, 3414 insertions(+), 203 deletions(-)
 create mode 100644 drivers/gpu/nova-core/mm/vram.rs
 create mode 100644 drivers/gpu/nova-core/vgpu/commands.rs
 create mode 100644 drivers/gpu/nova-core/vgpu/fw.rs
 create mode 100644 drivers/gpu/nova-core/vgpu/fw/commands.rs
 create mode 100644 drivers/gpu/nova-core/vgpu/fw/r000_00.rs
 create mode 100644 drivers/gpu/nova-core/vgpu/fw/r000_00/bindings.rs
 create mode 100644 drivers/gpu/nova-core/vgpu/gsp_plugin_comm.rs
 create mode 100644 drivers/gpu/nova-core/vgpu/gsp_plugin_rpc.rs
 create mode 100644 drivers/gpu/nova-core/vgpu/instance.rs
 create mode 100644 drivers/gpu/nova-core/vgpu/scrubber.rs
 create mode 100644 drivers/gpu/nova-core/vgpu/vgpu_api.rs
 create mode 100644 drivers/gpu/nova-core/vgpu/vram.rs


base-commit: a8b840ca342e40b0d8af03b85958b63cdf29ff41
-- 
2.53.0


Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.24
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793943922;
	b=kg3gjCEolqUP30hg0Rt3YebacAZHAG/4fsb+hSvar9H0TTaYlUztsMzQbFk3CTmsg3oh
	 ySjybY0UR5AN26NjZ/Sgea+yZcB4ZnotJfa8wUBgGUa6VcrkKTOfQgr/fkWMqpK8iRtC1
	 86+xQ6v3LZjSeCNE3D3TSxGGOfl7w03MlvEDRMknBhgVxD16AC+VW8y7TEWyhm+9XXLN5
	 ag7WqQem7lU3CZdPm+N/QVSCYkRTXmvsDGwytL8V0f/5v/aQg49qfI+n1YqY4zJFgaKIk
	 Iv+I14K8CqpGYl5JF89JSJHBD96v7W6zT36yD0YoCBNBS7/aZQoYzSDatsX0PIJDo/Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793943922;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-Originating-IP:X-ClientProxiedBy:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=obc3t+izecPi55HUeVY0nlZHc41MLcXIDSdVz/pmPCs=;
	b=YQ/hwevyRt2cILxwj2gZ5cx9/Ent0G6ru3o1ry9yPemI2NH4y1xC++/HpcUjgnP5JfeV
	 k+LGdps3/hExuL9qjHeWeY4k1Wl2LuBGlQGFnGi3vQ1ITlIC5iMx+wsC3pwraFfRN/2Si
	 GF9pm92nGicx19RiJaw+3r84oVGjUKzPeqFNNk/g+OA+mjZo0cUhcIckHM4azJCRpEdtb
	 BeK6QuewpgjsMLj+sfR9jH68XVwTDh3nbg0ubHH53ADvXdTSdVVcaMXkBwwtPFR5b3QFq
	 ZufTqOnEfoISmM5g3x/eB20MGGHLxXTioHvEtwffEuQs0CzBlySHyyRtp6Ik28NM9pQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=oZ6qFFDO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.24
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010024.outbound.protection.outlook.com [52.101.56.24])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD83606A329;
	Fri,  6 Nov 2026 05:45:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7FD83606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=oZ6qFFDO
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pox2xnWij9ozJcDFkq9bnMh8n44jFekHRyeeAeek/+98s68TJniI7K4eTUhtq0IjE/erFlU2bNroYGwJfdeaPEhZkRZ4XUoChmGiCDVBZTSSPGfqR0hpBiAEUAcXg2CuYdtgytYBrO7x8Fsc18cwgVjGz7z++cCEPxD76UbCcEyfkDXlMZcSAaA0gq0b2kPI7ceqCiUIZ1PggbgFTnp1tDUo8NKGPoZbQ7bTwHtUgUNzoCaYmeE+PJSiu4B+Tu4Dxw1LkUuZuxtxWTqarGxWVH/Mn7q20kweuD5uVvZQ7wtc+lobGqQUVJo9QBA4KV8VwHvEnRpjYwN+VaDXB5oBuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=obc3t+izecPi55HUeVY0nlZHc41MLcXIDSdVz/pmPCs=;
 b=HMs/Z4ZPb+Rb0UIn81SmlFBd9muqj5Fxg9xqIlF2KRhvsREQXlart7GMh4LKooJGHtUNVZmNExgE989Z5fhWwnjvYd/SzQBzmb4DcV6TTxTKGw927D5CvH4Bcj0Dvowgov3cpJj7F7a62B3JBMcRf2DGD7rh02dAblw/36EsTXGxHCvpXxOfbxxclaXpoyZB6uEPJRyJ77AIoWYh0NTyvM+kvdY3qf5zSgW7fbT4rnhYDr78WepQaMq4qPNGnz/RabTBel0tPRyw5ZSihEXMc2BwNyNveYOcbKdzk3qLD2t6g8chKgQCEOEEbRGTXVBdLCJaA7Zg5Khd245D5c7gPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=obc3t+izecPi55HUeVY0nlZHc41MLcXIDSdVz/pmPCs=;
 b=oZ6qFFDOMbqLLQfi6z9BzzrC+C72OZTE1xSLC0TlqKJx/dl09vSKUr+mzHqphkMGXv7EvgBhD9Dcc1QrRJXu2ndasXhXn3JWwMIebRZGdbFDrM5unsbp9WUsulmoNkQFcyazc041BI0sRZsJAkkNA6mhjJZcn48tgWMkBkHkHLGeJraLbhHuYaQIKqTfQJiOmf61+dQxGIO+fQAMazT4OdpquZzTFYKnc3qCjxAma+cGqAMVQC7gEwsIP0zIDnxPWlM7jCaMpXp7XzbC1hbyDqZ3/PR40RB3dm4oulE3CLe5r+YylG1JBQR+ZbSxd7wHREVLSZ2+35SNW4EQwmT0Eg==
Received: from PH8PR05CA0009.namprd05.prod.outlook.com (2603:10b6:510:2cc::26)
 by MN2PR12MB4421.namprd12.prod.outlook.com (2603:10b6:208:26c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 05:45:15 +0000
Received: from CY4PEPF000392DA.namprd03.prod.outlook.com
 (2603:10b6:510:2cc:cafe::5f) by PH8PR05CA0009.outlook.office365.com
 (2603:10b6:510:2cc::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.5 via Frontend Transport; Fri, 6
 Nov 2026 05:45:15 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF000392DA.mail.protection.outlook.com (10.167.247.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 05:45:14 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 5 Nov
 2026 21:44:59 -0800
Received: from kalok-SPC741D16QM3.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 21:44:47 -0800
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
Subject: [PATCH v4 18/32] gpu: nova-core: vgpu: query VF assignments and properties
Date: Fri, 6 Nov 2026 11:09:51 +0530
Message-ID: <287040b1d5369fa6c76d9baa1829d96778cd4fcf.1793906667.git.alkumar@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1793906667.git.alkumar@nvidia.com>
References: <cover.1793906667.git.alkumar@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF000392DA:EE_|MN2PR12MB4421:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b4484b7-8088-42a4-aeb1-08df3bc921b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|82310400026|7416014|36860700016|376014|261022113327099003|261026140227099003|56012099006|11063799006|261021135927099003|261021123027099003|261021121427099003|261102123227099003|261026121527099003|261028144727099003|261022105027099003|261009223027099003|261022075727099003|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	vaegz03QG35hrO5M1oveOfoTwhwIJZ8+1t5uwXyRPMy7bsyUPngQ8KUrUOcc4jdTFAxoD2tAG4KGd7YOLiPCSCF0zVgfH0KchCIWW4c5lenMCFo2QOZcZUDFsbkDdyKKm4ZTlJlaPyTYXEqQsB/zFdBWrdypVHeueCpqqjR5pdYuTcDqGS+vPkQoI5byPp2Ohg4ly40nE8N4REI9iK6c60k5lxSw+wBh3AXeVxdsg6DWBX/f9ruMbuZ4a16BL7te52Q3bJimTqnh4rH/56AysjzgpjzfzyVBLME2URmCKwhm3L/1XB+jOVtbCzD+AfSPvpVwRYd0PcwmabyRwvpQiSbH6cHq2j+c7AjswyM9vyeT+ovlrHLcYL5fyy1wlfGXUWRz4NrcpdFZ1WLLHP/wxlgDdiGV9BG77RqqH661yZ1otjeHjDFrZzB/K0oERntrxuGid4PC0kFZYBVUntusqxPWX1I/UUNQWfa4Nq8TuTW6O2vvvp8p2vcymjmVyLUo19yyBo+32TsN6PX/oiBfrxqhHForrwRQt318B98ZR59UJ6ME48vnAdDKUJ9DN5GcIkDMUtXZr1rcGvTQyk2GcGF+o4gnOQfOusbccqEXi/UKjqvFNcgUY00mCfWokmWKyf7HavnvfoRMh1GbgNY9+Y9PhFo6aqLqsRNi49rUmqjUFlUnkousQvexyxIPg457EqArgpeXe9U5Aoi/hpkkaw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(82310400026)(7416014)(36860700016)(376014)(261022113327099003)(261026140227099003)(56012099006)(11063799006)(261021135927099003)(261021123027099003)(261021121427099003)(261102123227099003)(261026121527099003)(261028144727099003)(261022105027099003)(261009223027099003)(261022075727099003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	URLRP9X4BC29vEptTGS7uXt6bWXnYCcdE9cr2a6UOkD7Jcj5fnsPTaLzn48ll3nQR2NrrrjkYWuL5rZ+fRvRSbsMuIr2wPHX+UdPHxcw0PPNDdwEvEOBz3O1iC+97pCT8cjCrGES5g9UG0Ni3bCFyOLQdIFcIBsMsSvTvDSXWTd/SHV2wGPF1uQMkzv+dEZO7gvluhYvrq2CAhPaGfRsy1xr/S4Wf+kxlD790Mh1acH842Vgh0RgZk/DGPhUkEK3iSHzrbFoYAkDqwusGObKjf1M5N+h/+9NxLe4VcsOXPlXNqsIZb3yuYksGDnySuqp6fKbl7AIqgjo+W83eOgUTGR7XVDvtzDXksl6CYHHd+IJdun/4y1h/XzQOe2dK+JlJZpuk/JJccrhYIZTGin33+qCE5GUijcZP5LZ3wJ9no6d36FocZ4yKivvY6E80xNg
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 05:45:14.9000
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b4484b7-8088-42a4-aeb1-08df3bc921b1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF000392DA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4421

From: Zhi Wang <zhiw@nvidia.com>

Creating an instance requires its VF assignment and the corresponding
vGPU properties before reserving resources.

Call Cmdq's synchronous GMC interface with each query's command ID,
request payload and receive capacity. Check the matching reply's
firmware status before decoding it, and report the command and raw
NV_STATUS when firmware rejects the request.

Decode the VF assignment and NVKV property replies at their query entry
points. Validate the returned type ID and nonzero instance limit, and
initialize the decoded properties on the heap. Keep the raw queue
interface available to firmware-control clients.

Co-developed-by: Eliot Courtney <ecourtney@nvidia.com>
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
Signed-off-by: Alok Kumar <alkumar@nvidia.com>
---
 drivers/gpu/nova-core/gsp.rs              |  1 +
 drivers/gpu/nova-core/gsp/cmdq/gmc.rs     |  3 -
 drivers/gpu/nova-core/gsp/fw.rs           |  2 +-
 drivers/gpu/nova-core/vgpu.rs             |  2 +
 drivers/gpu/nova-core/vgpu/commands.rs    | 92 ++++++++++++++++++++++
 drivers/gpu/nova-core/vgpu/fw.rs          | 17 ++++
 drivers/gpu/nova-core/vgpu/fw/commands.rs | 95 +++++++++++++++++++++++
 7 files changed, 208 insertions(+), 4 deletions(-)
 create mode 100644 drivers/gpu/nova-core/vgpu/commands.rs
 create mode 100644 drivers/gpu/nova-core/vgpu/fw.rs
 create mode 100644 drivers/gpu/nova-core/vgpu/fw/commands.rs

diff --git a/drivers/gpu/nova-core/gsp.rs b/drivers/gpu/nova-core/gsp.rs
index 8424aa3937e7..7e10a1deeafe 100644
--- a/drivers/gpu/nova-core/gsp.rs
+++ b/drivers/gpu/nova-core/gsp.rs
@@ -32,6 +32,7 @@
 mod regs;
 
 pub(crate) use fw::{
+    r000_00 as bindings,
     GspFmcBootParams,
     GspFwWprMeta,
     LibosMemoryRegionInitArgument,
diff --git a/drivers/gpu/nova-core/gsp/cmdq/gmc.rs b/drivers/gpu/nova-core/gsp/cmdq/gmc.rs
index c5ae5943c8b8..d41d5e533cf7 100644
--- a/drivers/gpu/nova-core/gsp/cmdq/gmc.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq/gmc.rs
@@ -302,10 +302,8 @@ pub(super) fn log(&self, dev: &device::Device) {
 /// Response from a GMC API command.
 pub(crate) struct GmcResponse {
     /// Response status (`NV_STATUS` code). Zero means success.
-    #[expect(dead_code)]
     pub(crate) status: u32,
     /// Response payload copied out of the message queue.
-    #[expect(dead_code)]
     pub(crate) payload: KVec<u8>,
 }
 
@@ -356,7 +354,6 @@ impl Cmdq<'_> {
     /// # Errors
     ///
     /// Returns the same errors as [`Self::send_gmc_and_receive_timeout`].
-    #[expect(dead_code)]
     pub(crate) fn send_gmc_and_receive(
         &self,
         command_id: u32,
diff --git a/drivers/gpu/nova-core/gsp/fw.rs b/drivers/gpu/nova-core/gsp/fw.rs
index ce4a7c45caf2..94ecf35ac04b 100644
--- a/drivers/gpu/nova-core/gsp/fw.rs
+++ b/drivers/gpu/nova-core/gsp/fw.rs
@@ -2,7 +2,7 @@
 // SPDX-FileCopyrightText: Copyright (c) 2025-2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
 
 pub(crate) mod commands;
-mod r000_00;
+pub(crate) mod r000_00;
 
 // Alias to avoid repeating the version number with every use.
 use r000_00 as bindings;
diff --git a/drivers/gpu/nova-core/vgpu.rs b/drivers/gpu/nova-core/vgpu.rs
index 1402e37541b7..d910445dd2b0 100644
--- a/drivers/gpu/nova-core/vgpu.rs
+++ b/drivers/gpu/nova-core/vgpu.rs
@@ -20,6 +20,8 @@
     gsp::commands::FifoEngineList, //
 };
 
+mod commands;
+mod fw;
 mod hal;
 mod vram;
 
diff --git a/drivers/gpu/nova-core/vgpu/commands.rs b/drivers/gpu/nova-core/vgpu/commands.rs
new file mode 100644
index 000000000000..dc2534175e11
--- /dev/null
+++ b/drivers/gpu/nova-core/vgpu/commands.rs
@@ -0,0 +1,92 @@
+// SPDX-License-Identifier: GPL-2.0
+// SPDX-FileCopyrightText: Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+
+//! vGPU firmware command operations.
+//!
+//! Sends requests, checks responses and coordinates the firmware command
+//! sequences used by instance lifecycle operations.
+
+use kernel::{
+    device,
+    prelude::*, //
+};
+
+use crate::gsp::{
+    cmdq::Cmdq,
+    nvkv::{
+        nvkv_words,
+        Decoder,
+        Schema,
+        UnknownKeyPolicy, //
+    }, //
+};
+
+use super::{
+    fw::{
+        commands::{
+            VgpuPropertiesSchema, //
+        },
+        GMCAPI_CMD_QUERY_ASSIGNED_VF_VGPU_TYPE,
+        GMCAPI_CMD_QUERY_VGPU_PROPERTIES, //
+    }, //
+};
+
+pub(super) use super::fw::commands::{
+    Dbdf,
+    VgpuProperties, //
+};
+
+/// Reports a matching command's raw firmware status before translating rejection to `EIO`.
+fn check_status(dev: &device::Device<device::Bound>, command_id: u32, status: u32) -> Result {
+    if status == 0 {
+        Ok(())
+    } else {
+        dev_err!(
+            dev,
+            "GMC command {:#x} rejected: NV_STATUS={:#x}\n",
+            command_id,
+            status,
+        );
+        Err(EIO)
+    }
+}
+
+/// Query the vGPU type assigned to a VF by its DBDF.
+#[expect(dead_code)]
+pub(super) fn query_assigned_vf_type(
+    dev: &device::Device<device::Bound>,
+    cmdq: &Cmdq<'_>,
+    dbdf: Dbdf,
+) -> Result<u32> {
+    let command_id = GMCAPI_CMD_QUERY_ASSIGNED_VF_VGPU_TYPE;
+    let payload = u64::from(dbdf.into_raw()).to_le_bytes();
+    // Preserve the firmware receive budget; only the leading type ID is consumed.
+    let response = cmdq.send_gmc_and_receive(command_id, &payload, 64)?;
+    check_status(dev, command_id, response.status)?;
+
+    let bytes = response.payload.first_chunk::<4>().ok_or(ENODEV)?;
+    Ok(u32::from_le_bytes(*bytes))
+}
+
+/// Query and decode the firmware properties of one vGPU type.
+#[expect(dead_code)]
+pub(super) fn query_vgpu_properties(
+    dev: &device::Device<device::Bound>,
+    cmdq: &Cmdq<'_>,
+    type_id: u32,
+) -> Result<KBox<VgpuProperties>> {
+    let command_id = GMCAPI_CMD_QUERY_VGPU_PROPERTIES;
+    // NVKV replies vary in length. This is a receive capacity, not their encoded size.
+    let response = cmdq.send_gmc_and_receive(command_id, &type_id.to_le_bytes(), 4096)?;
+    check_status(dev, command_id, response.status)?;
+
+    let words = nvkv_words(&response.payload, &[])?;
+    let decoder = Decoder::new(&words, UnknownKeyPolicy::Ignore);
+    let mut schema = KBox::init(VgpuPropertiesSchema::init(), GFP_KERNEL)?;
+    let properties = KBox::try_init(decoder.decode(&mut *schema)?, GFP_KERNEL)?;
+    if properties.type_id != type_id || properties.max_instance == 0 {
+        Err(EINVAL)
+    } else {
+        Ok(properties)
+    }
+}
diff --git a/drivers/gpu/nova-core/vgpu/fw.rs b/drivers/gpu/nova-core/vgpu/fw.rs
new file mode 100644
index 000000000000..23097cb13121
--- /dev/null
+++ b/drivers/gpu/nova-core/vgpu/fw.rs
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0
+// SPDX-FileCopyrightText: Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+
+//! vGPU firmware interface.
+//!
+//! Exposes command constants and communication buffer layout types from
+//! raw firmware bindings.
+
+pub(super) mod commands;
+
+use crate::gsp::bindings;
+
+pub(super) const GMCAPI_CMD_QUERY_ASSIGNED_VF_VGPU_TYPE: u32 =
+    bindings::GMCAPI_COMMANDS_GMCAPI_CMD_QUERY_ASSIGNED_VF_VGPU_TYPE;
+
+pub(super) const GMCAPI_CMD_QUERY_VGPU_PROPERTIES: u32 =
+    bindings::GMCAPI_COMMANDS_GMCAPI_CMD_QUERY_VGPU_PROPERTIES;
diff --git a/drivers/gpu/nova-core/vgpu/fw/commands.rs b/drivers/gpu/nova-core/vgpu/fw/commands.rs
new file mode 100644
index 000000000000..efab30287f05
--- /dev/null
+++ b/drivers/gpu/nova-core/vgpu/fw/commands.rs
@@ -0,0 +1,95 @@
+// SPDX-License-Identifier: GPL-2.0
+// SPDX-FileCopyrightText: Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+
+//! Wire types and codecs for vGPU commands.
+//!
+//! Defines request encoders and response schemas independently of command
+//! submission and instance lifecycle operations.
+
+use kernel::{
+    alloc::ArrayVec,
+    bitfield, //
+};
+
+use crate::{
+    gsp::nvkv::{
+        nvkv_decode,
+        Array,
+        Key,
+        KeyId,
+        Required, //
+    }, //
+};
+
+bitfield! {
+    pub(crate) struct Dbdf(u32) {
+        2:0 function;
+        7:3 device;
+        15:8 bus;
+        31:16 domain;
+    }
+}
+
+nvkv_decode! {
+    pub(crate) struct VgpuPropertiesSchema => VgpuProperties {
+        // TODO: `name`/`class` required?
+        name: Array<u8, { VgpuProperties::STRING_LEN }, { Self::TYPE_NAME_KEY }>,
+        class: Array<u8, { VgpuProperties::STRING_LEN }, { Self::CLASS_KEY }>,
+        type_id: Required<Key<u32, { Self::TYPE_ID_KEY }>>,
+        bar1_length: Required<Key<u64, { Self::BAR1_LENGTH_KEY }>>,
+        max_instance: Required<Key<u32, { Self::MAX_INSTANCE_KEY }>>,
+        ecc: Key<u32, { Self::ECC_KEY }>,
+        profile_size: Required<Key<u64, { Self::PROFILE_SIZE_KEY }>>,
+        max_fps: Key<u32, { Self::MAX_FPS_KEY }>,
+        num_heads: Key<u32, { Self::NUM_HEADS_KEY }>,
+        max_res_x: Key<u32, { Self::MAX_RES_X_KEY }>,
+        max_res_y: Key<u32, { Self::MAX_RES_Y_KEY }>,
+        dev_id: Required<Key<u32, { Self::DEV_ID_KEY }>>,
+        subsystem_id: Required<Key<u32, { Self::SUBSYSTEM_ID_KEY }>>,
+        fb_length: Required<Key<u64, { Self::FB_LENGTH_KEY }>>,
+        gsp_heap_size: Required<Key<u64, { Self::GSP_HEAP_SIZE_KEY }>>,
+        fb_reservation: Required<Key<u64, { Self::FB_RESERVATION_KEY }>>,
+    }
+}
+
+impl VgpuPropertiesSchema {
+    const TYPE_NAME_KEY: KeyId = 0x3100;
+    const CLASS_KEY: KeyId = 0x3101;
+    const TYPE_ID_KEY: KeyId = 0x3102;
+    const BAR1_LENGTH_KEY: KeyId = 0x3103;
+    const MAX_INSTANCE_KEY: KeyId = 0x3104;
+    const ECC_KEY: KeyId = 0x3105;
+    const PROFILE_SIZE_KEY: KeyId = 0x3106;
+    const MAX_FPS_KEY: KeyId = 0x3107;
+    const NUM_HEADS_KEY: KeyId = 0x3108;
+    const MAX_RES_X_KEY: KeyId = 0x3109;
+    const MAX_RES_Y_KEY: KeyId = 0x310A;
+    const DEV_ID_KEY: KeyId = 0x310B;
+    const SUBSYSTEM_ID_KEY: KeyId = 0x310C;
+    const FB_LENGTH_KEY: KeyId = 0x310D;
+    const GSP_HEAP_SIZE_KEY: KeyId = 0x310E;
+    const FB_RESERVATION_KEY: KeyId = 0x310F;
+}
+
+pub(crate) struct VgpuProperties {
+    name: ArrayVec<u8, { Self::STRING_LEN }>,
+    class: ArrayVec<u8, { Self::STRING_LEN }>,
+    pub(crate) type_id: u32,
+    pub(crate) bar1_length: u64,
+    pub(crate) max_instance: u32,
+    ecc: u32,
+    profile_size: u64,
+    max_fps: u32,
+    num_heads: u32,
+    max_res_x: u32,
+    max_res_y: u32,
+    pub(crate) dev_id: u32,
+    pub(crate) subsystem_id: u32,
+    pub(crate) fb_length: u64,
+    pub(crate) gsp_heap_size: u64,
+    fb_reservation: u64,
+}
+
+impl VgpuProperties {
+    const STRING_LEN: usize = 64;
+}
-- 
2.53.0


Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.40
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795528948;
	b=vys0tcanDtor2gBbjFd6lFw/TgYjVTktKu9YgWIrwRidnft3coaSr3Ih3+wbDCoDXkqQ
	 jLqMo4kiEZfG6mTgxQxPK1xWtVpPdMpdcQV3u2CR/CcN2R8yduvh6q3smaueEtSW8gawn
	 WZ2nTqx5D77QKwW1bOd1veXFBKpyRE1iGbhHU3q+aJrLyDDrrMi78Z3koBLcefynrEj9U
	 nkwK+FAeoQ5DkwGVi2pkRsc9xhd77cQh/H/MaY/gbaSHLcNBB6dUWrAhAszvnw4DLvE4d
	 YQ6bwK0HTVAjZjQung2JJyAYbOZrubOH9vIdOoByci6rvIuy/iuHCLaXnlthLuIuy9A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795528948;
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
	bh=E9QJpxzqq7JpRWCEv7ft6TwjLcsh1GMBDe8TpzdYDcs=;
	b=RJhP6coOPbPEJ4i0h1efq08POX03FuhVkR9Ya8iRnP+wgJt20lF7T6M4Yp9mYvtfQVrp
	 3kuKGFW+qfs1sQ6hGJ8gdrvhWLQTY4ablmkD7A5rWJCJOHMqDpFHzsVnecSjv3ZoZP1y4
	 hTUS5lRrrudVWmlCn90P7hCa8n84/8y3lbiFANzBOYczJdYe7y9SGKXHnEIpFFmM0lWdo
	 zHGEQEHpY5VlLyIwhGLWPn+2pE65oSA9nCNNQV3oT7YKlUm/fVuv5H8XYxt07dEa8T7uK
	 h6TMU7EeuKbXr9KJ9iGBAaRQatDcNST98r/UhRu2T04hvgwYJ9Q8Nus+7E0m6kRJeMA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=jzJkucgv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.40
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010040.outbound.protection.outlook.com [40.93.198.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765C5606A6A2;
	Tue, 24 Nov 2026 14:02:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 765C5606A6A2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=jzJkucgv
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L0zSOOmnTwLULMLEvQgLjqEqwvf6TLKnvrS7iE+C5PbqvoY9ejnJlqoDabVhKjZUfOpdItIRZKp8Mgstfsmv7gPjmuqPuMoRWbMxPZgB+KeSgaJss3nj2EwBxvaWpklA2o/dlsLhZo7IUCgIJLg3nTgsmkkhUNLK2Wz9ZbRhxGhOeGEf+DobialABVhFykW7h3Co51P8U3dlBBcQVuzS4kvaDlppJHABUb8up5LyQVGDWc9YNXgEPJSFMP+KdV1rVJDlqHgz/BBXIML9lGoE4LqYYtqJKUkQShV/nm40X9eB1kaWzA6NmTZx3biwNaU7sK66VoZIhgikOcjjwDMhYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E9QJpxzqq7JpRWCEv7ft6TwjLcsh1GMBDe8TpzdYDcs=;
 b=rTxP/XqXouHYqPpyG9+THn2CBx1Q1rnRH6mhZ150OIINOw12DWCm3s1fvadiiP9XOgLVRHu6b5XVSe7N4NxzN3zILfXzYrPrmpQP3QskvUdwSLE20cHfy6R9rmBpa/uaunE/iX4IfMh7X1uj+fvdOr5YmDV6axAIXS8b7pvkTwLJJ2B8eqoIjULwLXndnz8JQpVRUv+mw4iBOdgGemBfK12m/1wZZdOg3oHrnpfVEuU7pOOpqRUyBaJ3JCP0dQpfrXAQmt9uDyPk83IDIp/dRXM7/cFS6wKtDgsSdv4k9yXo0JjsrVtyKloiMuhWc69zKUNphd5/66Sn3CGB9wOUTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E9QJpxzqq7JpRWCEv7ft6TwjLcsh1GMBDe8TpzdYDcs=;
 b=jzJkucgvRPr08U4w96I6510BkUJFBZsDfOJn/cSs9x+Hjv9VyXx+DIPJZ8ZfjG1mSDAInl7VuDea2lwp40a/3njW6UnlNJEq4zSsXj/Y4gLCbF+uLGcyxlffh90VBmg0WOxqrzSQkdnMVPCvK4KkNSQjbb659GMrdEhurb9gb1Ng5oVPqQSXoQd0Wt2e1JoCS5BTaO8iuCdMxhxlBfVms6XwyFxpJzXBS8qOnHWR3Oy+cNKK5tDZzQ6PFH/LLv+ZMWeVeTx9t1F6XsXZWCBZI0IcI5sIOS1jjaYHBmVhoeJIWmJvP8nlfmpVkgEaJA/9TBci3m6/IDvTfTvUZJpxvg==
Received: from BLAPR03CA0047.namprd03.prod.outlook.com (2603:10b6:208:32d::22)
 by MW4PR12MB6825.namprd12.prod.outlook.com (2603:10b6:303:20d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Tue, 24 Nov
 2026 14:02:13 +0000
Received: from LV8PEPF00000069.namprd03.prod.outlook.com
 (2603:10b6:208:32d:cafe::85) by BLAPR03CA0047.outlook.office365.com
 (2603:10b6:208:32d::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Tue,
 24 Nov 2026 14:02:12 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 LV8PEPF00000069.mail.protection.outlook.com (10.167.248.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Tue, 24 Nov 2026 14:02:12 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 24 Nov
 2026 06:01:42 -0800
Received: from kalok-SPC741D16QM3.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 06:01:29 -0800
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
Subject: [PATCH v5 07/35] gpu: nova-core: vgpu: initialize runtime parameters after GSP boot
Date: Tue, 24 Nov 2026 19:29:03 +0530
Message-ID: <20261124135937.18583-8-alkumar@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261124135937.18583-1-alkumar@nvidia.com>
References: <20261124135937.18583-1-alkumar@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: LV8PEPF00000069:EE_|MW4PR12MB6825:EE_
X-MS-Office365-Filtering-Correlation-Id: 7261902f-2687-4d92-28d3-08df4a33899a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700016|1800799024|376014|23010399003|82310400026|11063799006|10067099003|56012099006|261022105027099003|261026140227099003|261021123027099003|261022075727099003|261021121427099003|261028144727099003|261102123227099003|261009223027099003|6133799003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	he/qwpHXcYEw5o2A9sg+0RKtdzI/JKuPrXwgtEsbSOf1ETDAoykR8kKev6Xc4E1ebZqjAxh2/5nlUg0QeyP4ohh452ST06ZXfa+OyVmq7lwsk1uT3sBzfR/oQYy1cSy/wg/Q1e8KNa9IU4g2HdE4pZpoDSgjuq0svutbWM8AUvjv2F3TQ4v6E48enOdBeTxPbPocejoJJQEs0dSGuUOXob/FmeItGuTPqmz67vvLyFHHh9i0LgLW3tRKs7ZWgn0tZmWZW5LIjxyb+xcb95g0SZHizfAcYJ9FAdMvUzMp5WQqml7XAUnHoCmuTNaeBVlECOqcxNtBbzO+tEFAXsg8DnaQiQN5mEGAoS7IXqGvxJHXdpcWRqE3D9ZFuup6uby7rMNYjsft+VDUQ21izVZJA6TiYx+uBcfTHc6wROGOsL3gtcHGLduwxaUoVPh4w53cgUYRVdhi7CLY1wMQVl4kQNUM6Qcz20/W3rh1wL17GlRjOcbcvbR/ZNz7uQFg3JK+UJ5eWBTk3vLlN9J5eFnaIAVPKhN58YCV0CxdK2HD/G1gpd1YMe9qp+7fTH2lRuPLgnQTsyviMqOWBkueRYblgLWIrmxd27WSvHjqtfrewmaa9/HvGZ8NKM2/3pwboqJFRx45IJ9bx4AAd5mckOYVXmA7UvC7Qf+R1fAOR9KjWwLNNDXuvz4hnihPpy5d8ZNKwbzCC+RTlr1ptARfkq/MmA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(36860700016)(1800799024)(376014)(23010399003)(82310400026)(11063799006)(10067099003)(56012099006)(261022105027099003)(261026140227099003)(261021123027099003)(261022075727099003)(261021121427099003)(261028144727099003)(261102123227099003)(261009223027099003)(6133799003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	HC8UIZahGyJAWBoq/20cPJ/2ECsZFgkqf7gPsc0Z3gZSwYwuoGNL9sPgo/uuOqWTBt/ajOqAd/+RFp5MbJeAkro472AmWgesZfWYhvNDBVgvCgDE6rVqQ53IoGNfpwHafUJcD6H11EAFAmO9XdzlQWdxN1bL0lVU5itM4BFkXH/g97wF7Qfi/SwV2+l7gpCW+oINGGFUsPndS7MsybPhKXe7zXGzeKLSxlJukkG1yfTvwzNt3Vld/w28MRGXS1ya15rloV4ESUrnqxO/wDas8WeHqPIwluHXya4LeN+XAUTFDiI6odM2q6r//DFtq8rzPrG7zltbA9LsmUKJVKIu7icR6PdCkLYAHeG+6SrobPfFcjBrwWXRnnIh9IkKAjWjXw9anZPGg7zdMlYBOyfI4K+XysijxmmU/uace75mTCkK0+wqvCM3JBZH+OutFPXL
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 14:02:12.0897
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7261902f-2687-4d92-28d3-08df4a33899a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	LV8PEPF00000069.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6825

From: Zhi Wang <zhiw@nvidia.com>

The vGPU manager needs the VMMU segment size and FIFO engine topology
returned by a successful GSP boot to divide instance resources.

Construct VgpuManager only for a vGPU-enabled boot. Retain the GPU-owned
channel pool, the ordered host-driven engine
list and the VMMU segment size. Expose the existing decoded VMMU value
from GspStaticInfo at its first consumer, preserving zero when firmware
omits the key.

Keep the runtime values in the manager for its instance module, and drop
the manager before the pool and memory resources it borrows.

Cc: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
Signed-off-by: Alok Kumar <alkumar@nvidia.com>
---
 drivers/gpu/nova-core/gpu.rs              | 20 ++++++++++++-
 drivers/gpu/nova-core/gsp/commands.rs     |  5 ++--
 drivers/gpu/nova-core/gsp/commands/gmc.rs |  1 +
 drivers/gpu/nova-core/gsp/fw/commands.rs  |  2 +-
 drivers/gpu/nova-core/vgpu.rs             | 36 ++++++++++++++++++++++-
 5 files changed, 59 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index b3775365a74e..cf7173b72a13 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -54,7 +54,10 @@
         Timer,
         TimerState, //
     },
-    vgpu::VgpuState,
+    vgpu::{
+        VgpuManager,
+        VgpuState, //
+    },
 };
 
 #[cfg_attr(not(CONFIG_KUNIT = "y"), expect(dead_code))]
@@ -395,6 +398,7 @@ unsafe fn new(
 #[pin_data]
 pub(crate) struct Gpu<'gpu> {
     pub(crate) spec: Spec,
+    vgpu: Option<VgpuManager<'chid_pool>>,
     /// GSP event interrupt registration, and the enable of its subtree.
     ///
     /// Must be kept declared *before* `gsp_resources`, so that the handler is unregistered, and
@@ -602,6 +606,20 @@ pub(crate) fn new<'a>(
                     bar1,
                 )
             },
+
+            vgpu: {
+                let info = &gsp_resources.boot_result.static_info;
+                match gsp_resources.vgpu_state {
+                    VgpuState::Disabled => None,
+                    VgpuState::Enabled { .. } => Some(VgpuManager::new(
+                        chid_pool.get_ref(),
+                        &info.fifo_engine_list(),
+                        info.vmmu_segment_size,
+                        TOTAL_CHANNELS,
+                    )),
+                }
+            },
+
         })
     }
 
diff --git a/drivers/gpu/nova-core/gsp/commands.rs b/drivers/gpu/nova-core/gsp/commands.rs
index f5ec27995627..799f26e0ae74 100644
--- a/drivers/gpu/nova-core/gsp/commands.rs
+++ b/drivers/gpu/nova-core/gsp/commands.rs
@@ -11,7 +11,7 @@
 
 use kernel::prelude::*;
 
-use super::fw::commands::FifoEngineList;
+pub(crate) use super::fw::commands::FifoEngineList;
 
 /// The static GPU configuration, which GSP-RM reports in reply to [`GspInit`](gmc::GspInit).
 pub struct GspStaticInfo {
@@ -25,6 +25,8 @@ pub struct GspStaticInfo {
     pub(crate) usable_fb_regions: KVec<Range<u64>>,
     /// Exclusive end of the FB physical address space.
     pub(crate) total_fb_end: u64,
+    /// VMMU segment size in bytes, or zero if GSP-RM omitted it.
+    pub(crate) vmmu_segment_size: u64,
     /// Host-driven engines in firmware FIFO order.
     fifo_engine_list: FifoEngineList,
 }
@@ -68,7 +70,6 @@ pub fn gpu_short_name(&self) -> core::result::Result<&str, GpuNameError> {
     }
 
     /// Returns the host-driven engines in their firmware FIFO order.
-    #[expect(dead_code)]
     pub(crate) fn fifo_engine_list(&self) -> FifoEngineList {
         self.fifo_engine_list
     }
diff --git a/drivers/gpu/nova-core/gsp/commands/gmc.rs b/drivers/gpu/nova-core/gsp/commands/gmc.rs
index 4f813a780d1b..14e04db90594 100644
--- a/drivers/gpu/nova-core/gsp/commands/gmc.rs
+++ b/drivers/gpu/nova-core/gsp/commands/gmc.rs
@@ -185,6 +185,7 @@ fn read(payload: &mut SBufferIter<core::array::IntoIter<&[u8], 2>>) -> Result<Se
             usable_fb_regions,
             total_fb_end: reply.total_fb_end().ok_or(EINVAL)?,
             fifo_engine_list: reply.fifo_engine_list(),
+            vmmu_segment_size: reply.vmmu_segment_size,
         })
     }
 }
diff --git a/drivers/gpu/nova-core/gsp/fw/commands.rs b/drivers/gpu/nova-core/gsp/fw/commands.rs
index af3948ed79f5..d9dd4841566f 100644
--- a/drivers/gpu/nova-core/gsp/fw/commands.rs
+++ b/drivers/gpu/nova-core/gsp/fw/commands.rs
@@ -387,7 +387,7 @@ pub(crate) struct GspInitResponse {
     gpu_gid: ArrayVec<u8, { GspStaticInfo::GID_LEN }>,
     fb_regions: KVVec<FbRegion>,
     bar1_pde_base: u64,
-    vmmu_segment_size: u64,
+    pub(crate) vmmu_segment_size: u64,
     fifo_engine_count: FifoEngineCount,
     fifo_engine_gmc_ids: [u32; MAX_FIFO_ENGINES],
     fifo_engine_flags: [u32; MAX_FIFO_ENGINES],
diff --git a/drivers/gpu/nova-core/vgpu.rs b/drivers/gpu/nova-core/vgpu.rs
index c59e7d2f933c..8a6d87233aaf 100644
--- a/drivers/gpu/nova-core/vgpu.rs
+++ b/drivers/gpu/nova-core/vgpu.rs
@@ -14,7 +14,11 @@
         Fsp,
         VgpuMode, //
     },
-    gpu::Chipset, //
+    gpu::{
+        ChannelIdPool,
+        Chipset, //
+    },
+    gsp::commands::FifoEngineList, //
 };
 
 mod hal;
@@ -81,3 +85,33 @@ fn query_state(
         }
     }
 }
+
+/// Runtime resources for an enabled vGPU boot.
+pub(crate) struct VgpuManager<'gpu> {
+    #[expect(dead_code)]
+    chid_pool: &'gpu ChannelIdPool,
+    /// VMMU segment size in bytes, or zero if GSP-RM omitted it.
+    #[expect(dead_code)]
+    vmmu_segment_size: u64,
+    #[expect(dead_code)]
+    total_channels: u32,
+    #[expect(dead_code)]
+    fifo_engine_list: FifoEngineList,
+}
+
+impl<'gpu> VgpuManager<'gpu> {
+    /// Retains runtime parameters from a completed vGPU-enabled GSP boot.
+    pub(crate) fn new(
+        chid_pool: &'gpu ChannelIdPool,
+        fifo_engine_list: &FifoEngineList,
+        vmmu_segment_size: u64,
+        total_channels: u32,
+    ) -> Self {
+        Self {
+            chid_pool,
+            vmmu_segment_size,
+            total_channels,
+            fifo_engine_list: *fifo_engine_list,
+        }
+    }
+}
-- 
2.53.0


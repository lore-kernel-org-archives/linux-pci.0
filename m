Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.22
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795529011;
	b=fLYW9kZ3ZklE0/NmU02VVVd9ZlCQgA7O6cdCpnMgInlgXpyFRSg7gLzUUTu3EPV0MZk5
	 RIZrQquLGZY6JO2mof3nz/7rwgRe4S7nIomcUBg9DQmNYB3CbhWq3eYFcH0IZ1Lj/G1Dt
	 lox4QWmUzUYda3AmyZ+Q+YB/tR/WEHsxQFt9tHj7dnrZF8fNXmnmT8S5JydfOZ3qvKKIl
	 GzbRMqcqnza2WpDKotTVdKpadfIE8gemPiZJlATw8X+GtE6EhowaIMZhddtna3TN83fSH
	 rAbAWPVJlYwk4zIk2FgDxyBGu4dFi2sB2CcchRaHp4O8SyGInajYQ11rZ+YPX7i+LOQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795529011;
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
	bh=oLMpS8cwSh59Fdl8br4K4ySQ+KtytEjk0zPWr1ET+48=;
	b=gbnx3v1vnjcIt/KRFGF9YCQRNVqSH8iVOrSWFXvuEXRyEdmIbXA0RErBA6XQcGTNxyn/
	 fySYpEloRvOOuCGPGez+60y7GferpR97VP1yjtKSQkK4ILbNFIm0Ur5P+cG7CnvTy+9wk
	 NyUBIZSxsr5r+lTifbKC4yBWjG+02IvO7Rk7Ms/yoMRpW6aQBnoo30jzRHFACsHMY4THm
	 iq0C+31jvlIf246NPQ3F66m4wKxCnyt/nrbUIFIqYTtLJYg34UQd6mqFluYrbGSaYR/XO
	 GoGTceZxzayHEt1WRN6kAnQYtSVxXTMD0vWEzEp71vw1HDaUeNeMFNH3H/4TD06CvjQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="LjyoDp/B";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.22
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013022.outbound.protection.outlook.com [40.93.196.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8492E606A321;
	Tue, 24 Nov 2026 14:03:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8492E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=LjyoDp/B
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O7m5WyMNzl7tvveQpemvb2tCj3LQKvsZK/5SVty0dVOvUmHSBkD69vNj9lSbkx+PWTsgNODAa591NLc62fBLkrGTCVlbxaWCMDGyUwaOE29dwKTVKeHkqhPC9Xo49NHC/WKoUKLRckkmSn+KKklm4D/+YA1/VBsfO2Eyl50CEXUtKDR/PA1tJeVwUHRONc4ic81C6agXdkORL+SrgS/fK0kPnmHGxYQo61l3bwo/xhtmCY0vBAkk8e0JX82inHxCzV0QtcvOTTupsfiwC2cXnzGTpL6a/AeUXLp0gICs2DbyvSZzwpw4jocs3q5kpsQeK85izjKjEkVq4wq5sYGKvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oLMpS8cwSh59Fdl8br4K4ySQ+KtytEjk0zPWr1ET+48=;
 b=iAKzY8KBlvcukhJ1vRql+wkMvL434D2cF71YRPOYPAsjmzedbebE9SV+kCTixI6kL8BEWtuWGHWP9N2jPQFsTKAFe70CpkjU6tW5O+xTEArjijIgcO2IcdCrBAuirRp3RitAZuwLVf07sX00kvB53XAK40BzeFan40pPeA6RHuOrjf8EFwzN8XhKUhiOiv5kjXsKACCeGE9Wub7RBivMC8qLCbvU+BN/0daWSN6qUPAfjUFHjjLChowJzX5rlgcNsthoL2vj02SCWpR/zMm2ha6wWMUTsYywzvKDNAxDElmXYgPY6EHegtTC8+E140ILeZRxAo1lS7LThwW4bfsjcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oLMpS8cwSh59Fdl8br4K4ySQ+KtytEjk0zPWr1ET+48=;
 b=LjyoDp/BfIA/wtvqBh7DNkye00fu2vchhq7oF0k3TVPoH5tYyKrbB8RsDAMuPz6Hz0S10Mq++aYU2o1VPcG7KfqQHd4OjNssHfUA6VbAgVmYCNHBWFa/+xieod0KHNJRJ838IvrrIgaegVVnuY6IU3fxz/lpraWIDWlcUNh2iZy0/tY+Wa8/Ivjsdmr5JScHw9JSY99bHmtcbddhxV1oktwzXtScIYgvoKpwWtIaiestQB3CB6ivbu/xSmptou4aMaSgs32UBLohdNjlkiqOGsSZsomBc7PD6bZCwSmIZOJvW+1HdkbrTpnfyjLprPeGoG0rDtUSauRMFBW655EIFg==
Received: from MN2PR03CA0030.namprd03.prod.outlook.com (2603:10b6:208:23a::35)
 by CH1PPFF9270C127.namprd12.prod.outlook.com (2603:10b6:61f:fc00::62b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Tue, 24 Nov
 2026 14:03:15 +0000
Received: from LV8PEPF0000006A.namprd03.prod.outlook.com
 (2603:10b6:208:23a:cafe::51) by MN2PR03CA0030.outlook.office365.com
 (2603:10b6:208:23a::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.14 via Frontend Transport; Tue,
 24 Nov 2026 14:03:15 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 LV8PEPF0000006A.mail.protection.outlook.com (10.167.248.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Tue, 24 Nov 2026 14:03:15 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 24 Nov
 2026 06:02:47 -0800
Received: from kalok-SPC741D16QM3.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 06:02:34 -0800
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
Subject: [PATCH v5 12/35] gpu: nova-core: mm: add VramBlock
Date: Tue, 24 Nov 2026 19:29:08 +0530
Message-ID: <20261124135937.18583-13-alkumar@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: LV8PEPF0000006A:EE_|CH1PPFF9270C127:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f2f41a8-496e-4a33-e7e3-08df4a33af68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|23010399003|36860700016|22082099003|18002099003|56012099006|11063799006|261026140227099003|261102123227099003|261028144727099003|261022113327099003|261026121527099003|261021121427099003|261009223027099003|261022105027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	OeRT7007f3Qygm7KTipaXk+0n0xU4Qx8XKpJwApI62joWcWE5N2wU5+z46h5sHtMvsh5vlVAYTJgXQl2jAhCpld9YHirIVIUTnKROBYwodTKkyheddV1O38omINVGvj3bTqCY0k94b0IgeS2q/VFctoJWLUYX849udYY4zfDkRHzk4LbsoxccRu1RiWi3exVGOihISSY2Vzha+OD16PsWiaqnl/1lF3DnKJeljipSoNrk7+Nb8L0wCOCZiTRsiiDx+n3ix/1yhqppn9GQLutz1yc12ER5K5+mQPWNh7FWAlmdfu+BOQ+woD3a6ntbrzXoV0MDwI5LB7uuXUTunnYB4d+aarQ1H9xPCI4u/N2ubwZsrWwKw+LjSst5i8F2AdAU7vb5D3wFwNfAk4dFsbdAzmSv9zVq8Q5dtx4F+0ujx78U4Vd/pK/yb0xkep5xnp5E82HVuU+Y+kUZbsXe2rpzWSmAcumS0cJpReax4rmVemYnosrDCuHsRnSHEfUnwfhAdTtSsdL+WYtzJgzbWsZWyRcKySIJPpTKYtfLJCV9iTJQ7QEsfw6GhZUA7PaKevoUni1k62Hrw85GzuQe9D9mSQ6jXvJhWpks+4lLy0HX/SGye75gnObDHhIa3kd4QoKNVpFf1znJKwZOlRc75vqDrB7Mkv8IMrA/OejKgu+ANLi/g89JGAqAtffQUTeSk1BmboPtaYqTy9HBKNzgdfNFQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(23010399003)(36860700016)(22082099003)(18002099003)(56012099006)(11063799006)(261026140227099003)(261102123227099003)(261028144727099003)(261022113327099003)(261026121527099003)(261021121427099003)(261009223027099003)(261022105027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	mVB9lY8DZXKpqwqZwINnAdyIJLLUwjusFthrNyFUVuGnVmzDAQDvNyaSHh5n6Z4ZB++jfhLUiHyhCd99XlmmeiyG8u2oE+o77P9OAWBzVNei8OX9iBmV0wmz5sz+WLCDtZTCM1HOauA1kit9E18Qrig4WD8jhru15DdUXD2vlWSrPs8lg/ibIT/mH3IbhOQg6WP7YWJsJfj9e2H9WgMGfjn9wFnJfyrxgN+gTeOVpg2pg7R1HfaqjNkt/s7YgGsdfy/D4IFrKQ87lYDlW+uVjiOijY6Yq/0VrSJd00nc5v6xO9sgkj5doVUwD6IFVMt8yWKuN675gC7Vx0A4vijemcNAYc256TEHWlzPcrEsS0GkYorukhc6vd4aOfogafDG+arJtmi1sZVhi8X65PVqdFSJHAo2VfDzNboTpfsPrbFY+1C5u+Gax5d9RA9j/1Ec
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 14:03:15.5153
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f2f41a8-496e-4a33-e7e3-08df4a33af68
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	LV8PEPF0000006A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFF9270C127

From: Zhi Wang <zhiw@nvidia.com>

vGPU memory slots need allocations at fixed offsets within usable VRAM.
Add GpuMm::alloc_vram_range and VramBlock to own these exact allocations
and return their storage to the buddy allocator on drop.

Use the buddy allocator's range validation and retain the checks for
absolute physical address overflow and alignment.

Cc: Alistair Popple <apopple@nvidia.com>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
Co-developed-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Alok Kumar <alkumar@nvidia.com>
---
 drivers/gpu/nova-core/mm.rs      |  2 +
 drivers/gpu/nova-core/mm/vram.rs | 85 ++++++++++++++++++++++++++++++++
 2 files changed, 87 insertions(+)
 create mode 100644 drivers/gpu/nova-core/mm/vram.rs

diff --git a/drivers/gpu/nova-core/mm.rs b/drivers/gpu/nova-core/mm.rs
index f53886f9ed91..a0aeb96bfa36 100644
--- a/drivers/gpu/nova-core/mm.rs
+++ b/drivers/gpu/nova-core/mm.rs
@@ -67,6 +67,8 @@ macro_rules! impl_pfn_bounded {
 mod regs;
 pub(super) mod tlb;
 pub(super) mod vmm;
+#[expect(dead_code)]
+pub(crate) mod vram;
 
 /// GPU Memory Manager - owns all core MM components.
 ///
diff --git a/drivers/gpu/nova-core/mm/vram.rs b/drivers/gpu/nova-core/mm/vram.rs
new file mode 100644
index 000000000000..6839960eeb2c
--- /dev/null
+++ b/drivers/gpu/nova-core/mm/vram.rs
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: GPL-2.0
+// SPDX-FileCopyrightText: Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+
+//! VRAM allocation.
+
+use core::ops::Range;
+
+use kernel::{
+    gpu::buddy::{
+        AllocatedBlocks,
+        GpuBuddyAllocFlags,
+        GpuBuddyAllocMode, //
+    },
+    num::casts::FromSafeCast,
+    prelude::*,
+    ptr::Alignment,
+    sync::Arc, //
+};
+
+use super::{
+    GpuMm,
+    PAGE_SIZE, //
+};
+
+/// A physically contiguous VRAM allocation.
+///
+/// # Invariants
+///
+/// `range.start <= range.end`.
+pub(crate) struct VramBlock {
+    _blocks: Pin<KBox<AllocatedBlocks>>,
+    range: Range<u64>,
+}
+
+impl VramBlock {
+    /// Returns the range covered by this VRAM block.
+    pub(crate) const fn range(&self) -> &Range<u64> {
+        &self.range
+    }
+}
+
+impl GpuMm<'_> {
+    /// Allocates an exact byte range relative to the buddy allocator's base.
+    pub(crate) fn alloc_vram_range(
+        &self,
+        range: Range<u64>,
+        align: Alignment,
+    ) -> Result<Arc<VramBlock>> {
+        const PAGE_SIZE_ALIGN: Alignment = Alignment::new::<PAGE_SIZE>();
+
+        let align = if align > PAGE_SIZE_ALIGN {
+            align
+        } else {
+            PAGE_SIZE_ALIGN
+        };
+        let size = range.end.checked_sub(range.start).ok_or(EINVAL)?;
+        let buddy = self.buddy();
+        let base = buddy.base_offset();
+        let start = base.checked_add(range.start).ok_or(EOVERFLOW)?;
+        let end = base.checked_add(range.end).ok_or(EOVERFLOW)?;
+        if !start.is_multiple_of(u64::from_safe_cast(align.as_usize())) {
+            return Err(EINVAL);
+        }
+
+        let blocks = KBox::pin_init(
+            buddy.alloc_blocks(
+                GpuBuddyAllocMode::Range(range),
+                size,
+                align,
+                GpuBuddyAllocFlags::default(),
+            ),
+            GFP_KERNEL,
+        )?;
+
+        Ok(Arc::new(
+            VramBlock {
+                _blocks: blocks,
+                // INVARIANT: `range.start <= range.end` was checked above, hence
+                // `address <= end`.
+                range: start..end,
+            },
+            GFP_KERNEL,
+        )?)
+    }
+}
-- 
2.53.0


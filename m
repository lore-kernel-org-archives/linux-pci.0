Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.63
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793943894;
	b=MK6e4rqCnN0HG067wswAtTRD5rOK6RcTuVryI8VhzW9KCr7DNzNGCmuNUIKWgwtYxeLw
	 9v8OIj1Jk6TwAaXeRwNuDmm+80tctzTDmOB7zU+o82vmpBN2YSCzNrn9B+jvWucUVkQXJ
	 EVKwYcy4gY9KcSqJX8dEZg4aFfNfJD8KBud1hACEfYTO43LQnT98686nwk6vnl53Up/F2
	 1PQnZ5wdsNQIbfj7tDI8g1fMyHF4sEOkMhHU1dt6WoLLOFJuQx+b1BaKoO7Wsn/iCzfP2
	 Ncrm3IDid8B6vXLOLubDmfc4/yAlCuveoRSHOhvUItIy4+tlOHpKMEL27qGDGol6+hA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793943894;
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
	bh=EJT8hBWGHEug5Gp2s5r7Hy9LEUzxrhWog7iwxILitLo=;
	b=z2MokicsRW1MZr7F2UGbYHvrSW7jj/aZfENUwG+5KtAQxzQtAwTvk3QgMqKC1xg9qAei
	 TfywP1uCTL6P4o4k6QsB8AHkuxuQu6rBRrLGKFtX9PJtzUPRa7dbK6M6bprqQfFdqss8D
	 oAvn3gVKYVSVbDmlM+Kdw5Ol0eMK+fTQ8eNubJEXFXyFeObNoVJdR9MYjjpGA8ZrNg6Im
	 7xpRJuqO0JtIe+JE09Z7I7a9Zq+pZEOs7rL3mWK8oOTeE3NCDQdY27E5RfjjMsb1nTv4f
	 Ymxl3X1Dye4cSGThlFx5GWG/TIKIEBoSpu3JjntM1NhujndhD9OOQM2mcoUiu64sWKg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=tBP6zgDn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.63
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011063.outbound.protection.outlook.com [52.101.57.63])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21EFD606A328;
	Fri,  6 Nov 2026 05:44:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21EFD606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=tBP6zgDn
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ep1bAj6pF9iQemshOdLyvHtjznd0cqaNOJcGxzQYfH5jALp4Z/wgyIcgwR5Tq3wV4ltxP+nmL0k/8KKHrsFXA0REL3Pdfw2zJ6QQEaK2ZpNchn4lsFfz00HhSHKPbsOvMY6PBFCjEOKl7QU51J+sMf4NsaYvwtXpiH3sTVOLseEexow6e17B92J9wXSvP8b1ogTuPZlOTfof0GDuV6b/jAIaPxq54eQS/oX7QOmmI6xCMQKXzquqlxS1c23ISxXY1szx5dXke5VlKcsz9UPPDAJaVB1LtKAzZQyHqxpzzNj76P/qxDpFQov5o/guayPKcpmFZdU2tuQJ1wiSd2KW0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EJT8hBWGHEug5Gp2s5r7Hy9LEUzxrhWog7iwxILitLo=;
 b=DrMORZojVDi9Z5nWCz0ZAWzjxR8njL4rMmXSSGCkPizl6XvpN3k7Yn5W7BKy/bsGgcZPEH3klyTxnm//D3nt6bJ1JDshA3qwGfDaVN7m1MRhBiFJcRcRooT+9cYw5qEYI5Wvv4s657l/yh75HSvgk19+7YwVK2A+uk9somwn7qefFEQWrAF7HqAzy+iF9Y7qVhuUGNRsRQJcCLpNAZ3xiuxRq1cxEiUbl3DII9wO86B4egveU1M+UJtiKqfd5kaaHsmodj2MPif1Mersqt75Ed3cMI8d7v4zW+XgBtDThYezhxx9zGt+CqvBWoWSjcD4AkR7bvRu49NfdjojLK0m+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EJT8hBWGHEug5Gp2s5r7Hy9LEUzxrhWog7iwxILitLo=;
 b=tBP6zgDnHtTMttRu8foD7o42I9M4g6S7jTC4VMX8spjwByDv7BGjrEprr5tho4lP+FMNF/JdsrWXXaCEokkhyWOqHk72hiSQBsP50IPut6aTuOTv6JdP827lFgKGQa5DvhlhMrer3sLaPoTslETCinJ0XezuFgcBPfS6z11a6B9QX+rYKgbO4qC7C+4g1B5BJGJPu4KI+NHXuEOOCiOKl+GpnVgqm23iNsqfCB3S22ZU5k2GCSsSFsT6falPlvuCZeEiml2BjU7HQnvBAPcFI09NcKM0m3CyYmPJhgRzH4DOHQfEJNEGDB0BUqbrS6M4wGSoURKLyxCzlxfQSM+hbA==
Received: from DS7PR03CA0167.namprd03.prod.outlook.com (2603:10b6:5:3b2::22)
 by CY5PR12MB6059.namprd12.prod.outlook.com (2603:10b6:930:2c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 05:44:47 +0000
Received: from CY4PEPF000392D6.namprd03.prod.outlook.com
 (2603:10b6:5:3b2:cafe::84) by DS7PR03CA0167.outlook.office365.com
 (2603:10b6:5:3b2::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Fri, 6
 Nov 2026 05:44:47 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF000392D6.mail.protection.outlook.com (10.167.247.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 05:44:47 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 5 Nov
 2026 21:44:34 -0800
Received: from kalok-SPC741D16QM3.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 21:44:22 -0800
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
Subject: [PATCH v4 16/32] gpu: nova-core: vgpu: add VRAM slot allocator
Date: Fri, 6 Nov 2026 11:09:49 +0530
Message-ID: <28cc75e149ca6eca905ed46a4c2cd4e7b88bbd2a.1793906667.git.alkumar@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF000392D6:EE_|CY5PR12MB6059:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a1a42c7-62b7-42ee-fc41-08df3bc91151
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|82310400026|36860700016|11063799006|56012099006|261022113327099003|261009223027099003|261021121427099003|261022105027099003|261026121527099003|261102123227099003|261026140227099003|261022075727099003|261028144727099003|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	es+3Mg0kiYL7IrUJrhUck74NvX+wFbcNjxM5uq5qVnJY+vrqLYQ7j9g/I24kjTjGBxw6JyF+RkSXl1JN2IyTZXIYJzsBeZSRRm00A24MZwpMlmfxeOKGzWSAOQhMYl2jApKj+oalljAojASFT+mNnaoyT1NlyLIQoipt9rlo9Xt21Fgf2IQKh8IvGsipZq8dDDRt5IWmaMbIr5qJTzmteOYHEYSrfgrTdzfO/pu4qUmop14I5VNcgJF0zkCImPTc6fOcf/CnphpPz1AyBraRxHT1NoxRGRAh6PEDC97UylkqiGwkSzwG/g0c/kP+KBh7VQdEvb+vLXpN1JB385RJa5yiMjwAt6uyJZdwSnrjg3nuofW46PSLOUijghZ1Xp9rlUm5i7Pev6r3QdF270uMVzAWq2EZWxxKtUhTrx7ym/taZjDbGoMFTsLckn6kX+0iDswt4BszMYKbVAiJR4JbsRMLNlyO/F7BjzSlbyfMDdVZ7DOjppSNEdVuj9znBvgvPjCYR4Jqky/v4oeRtgcrC8ppRK2yLfAYNqgzyODA2Ubympbnw51HhbQof4wmbRnNlwJXv4hp/1GITNAPH11avnoNfeN7LLmUh0CaPdyY6i4Or3XR6xjt90mh1YW9DAG5wmjmtBHSyc8oOGCkQuCD9q68MiivbOAOZLNtBnMa141nBUJShT622jxZZrvI+rhjl4r8uHZhGxisCEVZ+qBspg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(82310400026)(36860700016)(11063799006)(56012099006)(261022113327099003)(261009223027099003)(261021121427099003)(261022105027099003)(261026121527099003)(261102123227099003)(261026140227099003)(261022075727099003)(261028144727099003)(18002099003)(22082099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	QWj6S4mVeMk1iYrjdwKdVLTNZM3zQgdciVKdDC5VduTDEbgRAxnYwv0ryt/w6wL7FKeLvzjCcjoji6Vtq7WM8WlsgefITmMOV0W+4g8Tuz6mRbgQo2gCIJDT91E/kTQfuB2t8BsgGmuvzTqAZ/yyaBu+bIqiygCNLTLCkmW0xNY301/6l02vrB2cx8Lt5dUDpg3rBV9yfA/bKNQFwmvACeQG3lP1Qe/2nu2OZc1gaG3fHbVVjSyh/yHA2mFNMHReO7vjQiDGHPsI53KRso9SwYt+/oMR+QQHkfTwKRM4ZTI3L8kSRO6bzeN0/u1THXiV7TIfyTcMQsljBg8ml+GDLqxUfoFeB9v58rQHDUv3ye3//lbao8JdblZdLdvZ657XsJ7gHv2p4UOyXBc8cAz36ZUjplcsfRBSc1GxHhJqHasqc4xz5X4FGrLtmcXgY72m
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 05:44:47.4297
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a1a42c7-62b7-42ee-fc41-08df3bc91151
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF000392D6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6059

A vGPU type specifies the guest VRAM and GSP plugin management-heap
sizes for each instance. Allocating these regions independently fragments
VRAM and does not preserve a stable layout for the vGPU type.

Add a standalone slot allocator that reserves one exact VRAM range and
tracks assignments in a shared, mutex-protected bitmap. Validate the
vGPU type's layout and reject an allocation request whose layout differs
from the active pool.

Lay out all guest VRAM slots first and all management-heap slots
second, pairing them by bitmap index. Require the guest VRAM stride and
pool base to satisfy the required VMMU-segment alignment.

Return an owned slot that clears its bitmap entry on drop. Keep the
bitmap alive while slots exist and release the entry if constructing
the VRAM regions fails. Require users to stop device accesses and remove
mappings before dropping a slot.

Co-developed-by: Zhi Wang <zhiw@nvidia.com>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
Signed-off-by: Alok Kumar <alkumar@nvidia.com>
---
 drivers/gpu/nova-core/vgpu.rs      |   1 +
 drivers/gpu/nova-core/vgpu/vram.rs | 181 +++++++++++++++++++++++++++++
 2 files changed, 182 insertions(+)
 create mode 100644 drivers/gpu/nova-core/vgpu/vram.rs

diff --git a/drivers/gpu/nova-core/vgpu.rs b/drivers/gpu/nova-core/vgpu.rs
index 5cd82adeb0f8..1402e37541b7 100644
--- a/drivers/gpu/nova-core/vgpu.rs
+++ b/drivers/gpu/nova-core/vgpu.rs
@@ -21,6 +21,7 @@
 };
 
 mod hal;
+mod vram;
 
 /// vGPU state detected during GPU construction.
 #[derive(Debug, Clone, Copy)]
diff --git a/drivers/gpu/nova-core/vgpu/vram.rs b/drivers/gpu/nova-core/vgpu/vram.rs
new file mode 100644
index 000000000000..65e6a945ea6f
--- /dev/null
+++ b/drivers/gpu/nova-core/vgpu/vram.rs
@@ -0,0 +1,181 @@
+// SPDX-License-Identifier: GPL-2.0
+// SPDX-FileCopyrightText: Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+
+//! VRAM slot allocation for vGPU instances.
+
+use kernel::{
+    bitmap::BitmapVec,
+    prelude::*,
+    sync::{
+        new_mutex,
+        Arc,
+        Mutex, //
+    }, //
+};
+
+use crate::mm::{
+    vram::{
+        VramBlock,
+        VramRegion, //
+    },
+    GpuMm, //
+};
+
+const VRAM_SLOT_MIN_ALIGN: u64 = 4096;
+
+#[derive(Clone, Copy, PartialEq)]
+pub(super) struct VgpuVramLayout {
+    pub(super) type_id: u32,
+    pub(super) max_slots: u32,
+    pub(super) fb_size: u64,
+    pub(super) heap_size: u64,
+    pub(super) fb_align: u64,
+}
+
+impl VgpuVramLayout {
+    fn validated(mut self) -> Result<Self> {
+        if self.max_slots == 0 || self.fb_size == 0 || self.heap_size == 0 {
+            return Err(EINVAL);
+        }
+        self.fb_align = core::cmp::max(self.fb_align, VRAM_SLOT_MIN_ALIGN);
+        if !self.fb_align.is_power_of_two() {
+            return Err(EINVAL);
+        }
+        if self.fb_size & (self.fb_align - 1) != 0
+            || self.heap_size & (VRAM_SLOT_MIN_ALIGN - 1) != 0
+        {
+            return Err(EINVAL);
+        }
+        Ok(self)
+    }
+}
+
+/// Slot bitmap shared by the allocator and its outstanding slots.
+#[pin_data]
+struct SlotBitmap {
+    #[pin]
+    used: Mutex<BitmapVec>,
+}
+
+impl SlotBitmap {
+    fn new(count: usize) -> Result<Arc<Self>> {
+        let used = BitmapVec::new(count, GFP_KERNEL)?;
+        Arc::pin_init(
+            pin_init!(Self {
+                used <- new_mutex!(used),
+            }),
+            GFP_KERNEL,
+        )
+    }
+
+    fn alloc(self: &Arc<Self>) -> Result<Slot> {
+        let mut used = self.used.lock();
+        let index = used.next_zero_bit(0).ok_or(ENOSPC)?;
+        used.set_bit(index);
+        Ok(Slot {
+            bitmap: self.clone(),
+            index,
+        })
+    }
+
+    fn is_empty(&self) -> bool {
+        self.used.lock().last_bit().is_none()
+    }
+}
+
+/// A slot that clears its bitmap entry on drop.
+struct Slot {
+    bitmap: Arc<SlotBitmap>,
+    index: usize,
+}
+
+impl Drop for Slot {
+    fn drop(&mut self) {
+        let mut used = self.bitmap.used.lock();
+        debug_assert_eq!(used.next_bit(self.index), Some(self.index));
+        used.clear_bit(self.index);
+    }
+}
+
+/// A VRAM slot that clears its bitmap entry when dropped.
+///
+/// All device accesses and mappings of its regions must end before dropping the slot.
+/// Clearing the entry locks a sleeping mutex, so dropping the slot may sleep.
+#[must_use]
+#[expect(dead_code)]
+pub(super) struct VgpuVramSlot {
+    pub(super) fbmem: VramRegion,
+    pub(super) mgmt_heap: VramRegion,
+    _slot: Slot,
+}
+
+pub(super) struct VgpuVramSlotAllocator {
+    backing: Arc<VramBlock>,
+    layout: VgpuVramLayout,
+    fb_region_size: u64,
+    slot_bitmap: Arc<SlotBitmap>,
+}
+
+#[expect(dead_code)]
+impl VgpuVramSlotAllocator {
+    pub(super) fn new(mm: &GpuMm<'_>, layout: VgpuVramLayout) -> Result<Self> {
+        let layout = layout.validated()?;
+        let max_slots = u64::from(layout.max_slots);
+        // Keep guest VRAM slots contiguous so each starts at `fb_align`;
+        // interleaving page-aligned heaps could misalign later slots.
+        let fb_region_size = layout.fb_size.checked_mul(max_slots).ok_or(EINVAL)?;
+        let heap_region_size = layout.heap_size.checked_mul(max_slots).ok_or(EINVAL)?;
+        let pool_size = fb_region_size.checked_add(heap_region_size).ok_or(EINVAL)?;
+
+        let slot_bitmap = SlotBitmap::new(usize::try_from(layout.max_slots).map_err(|_| EINVAL)?)?;
+        let backing = mm.alloc_vram_range(0..pool_size, VRAM_SLOT_MIN_ALIGN)?;
+        if !backing.address().is_multiple_of(layout.fb_align) {
+            return Err(EINVAL);
+        }
+
+        Ok(Self {
+            backing,
+            layout,
+            fb_region_size,
+            slot_bitmap,
+        })
+    }
+
+    pub(super) fn matches_layout(&self, layout: VgpuVramLayout) -> Result<bool> {
+        Ok(self.layout == layout.validated()?)
+    }
+
+    pub(super) fn alloc(&mut self, layout: VgpuVramLayout) -> Result<VgpuVramSlot> {
+        if !self.matches_layout(layout)? {
+            return Err(EBUSY);
+        }
+
+        let slot = self.slot_bitmap.alloc()?;
+        let index = u64::try_from(slot.index).map_err(|_| EINVAL)?;
+
+        let fb_size = self.layout.fb_size;
+        let fb_offset = fb_size.checked_mul(index).ok_or(EINVAL)?;
+        let fb_end = fb_offset.checked_add(fb_size).ok_or(EINVAL)?;
+
+        let heap_size = self.layout.heap_size;
+        let heap_slot_offset = heap_size.checked_mul(index).ok_or(EINVAL)?;
+        let heap_offset = self
+            .fb_region_size
+            .checked_add(heap_slot_offset)
+            .ok_or(EINVAL)?;
+        let heap_end = heap_offset.checked_add(heap_size).ok_or(EINVAL)?;
+
+        let fbmem = self.backing.region(fb_offset..fb_end)?;
+        let mgmt_heap = self.backing.region(heap_offset..heap_end)?;
+
+        Ok(VgpuVramSlot {
+            fbmem,
+            mgmt_heap,
+            _slot: slot,
+        })
+    }
+
+    pub(super) fn is_empty(&self) -> bool {
+        self.slot_bitmap.is_empty()
+    }
+}
-- 
2.53.0


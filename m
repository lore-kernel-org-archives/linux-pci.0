Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.22
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795529129;
	b=qGRGvvbGHWvhbMIrVtBz54yCi+onirY/bUUbykU3bidOTSlurBBbZy+cZxn/LtTMg31O
	 jOcyKFYQecR8rhNjyX9b6KDb5Kgl3qagAskiqcOFuPrVPx5AS+RhBmBbRPxXAMipJi/Jc
	 16SgCKKb5EbDF/UyJZFYb5ga8+o3yRnsPzwoteMh10Y0hmjWCq8RqVxNr3Blqy8MnRqNM
	 Y9PEI8AcXpkMCUT3EnGTzzp42R7vTzUWuZKF3m3dhOG4uJoPp+bUSCa3FB135W9lSeSTv
	 oCsjB4gqfT/vHoNOaXZQnHmNmXh4bpdOX/a9ZbNafRPcmaUT0t6U+DuK3PYgEnD3Isg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795529129;
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
	bh=rJosQjalIQnpINy6fNufS6WviGWrMie24aLGclblL8k=;
	b=Jm9PyDIIkW/hWUxtvtoetD08jWXei2YADUrP6Js6u8HvEHy/ICiZtFSmmcb6ZZqfdD/P
	 4j0wC4mKJeeUDIskkZ4M5V7rskxedjOz47oy6wAVrDJ+lh0CZ+/M+BN8zHv6TGX3bOdjv
	 fq9N5G+oXtWXu75EQhglikB0zDU0XhsIJRVa0sg3E4a9jFUZwbParf2vSH3yTTZ00HmNG
	 33psr+nY/39MlqxuqxEZnS4nwwsSQFzAFPcdD3WsRF7EWO6RWTsL+pNgAOzSKr/9nxwGi
	 VP5EFiBmGsoOS8Q5OqA5xlnBeCGtuaXtFYT1nfkc2enkyVdm/xeCg7rfJvP2yeWmkVg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=YmyL7Iyh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.22
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011022.outbound.protection.outlook.com [40.93.194.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24E1606A330;
	Tue, 24 Nov 2026 14:05:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F24E1606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=YmyL7Iyh
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YM1mqBTjeCzoUiO8gDn9Aqmsl/8lSsFtcoCi0Jl7l9mH503x5pmO26hun7YZxlkP+W2VYOw88u4QRVIl0nwS+1n9iPCu8uNzLzuHGwUOZyfLgEhpLavc8UEm4NcX1Kidy+eAjB2bVrULODPPnGzPJflS12OKjaP3btjXxtYAcZ+0ZU0qYOMOX5/ERU1t2Tsa2JiXL5EBGYp0XmYG3b4MdS9g4AuKfssbWkkv2yQNllDb32PRknq7Vzn/kYWTkTMC//1MWfBQvWhKyU45hPpVqh8C2KIFTy2nCyLj0tq9kLOhXl/9FixC1Pz4zUk4EHHEFlz8pb1zk0UJ1XAyQYAHLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rJosQjalIQnpINy6fNufS6WviGWrMie24aLGclblL8k=;
 b=DeVbO7yPOUzAeLsxTG4JTr4T5hwKyKcc18Zy1fK5Xd2xUG7i+FEdlV47p+0jX+w/7s0MBs9UN+7K7NaCmGUfcz5P6UhxgFGqBUJTrJjhwROTeYnjGkt4cWp5eruB4GoWe9fIAnneoD6nYTMHigcqnZeQeBeC3EIXwU2r1c0hoMCiWvRPFzKNl5AKHJf4fYXud/GI0LTW1t61n0PmnWkZo7wLg9+N7FEQ9gA1f728G4asK1O4K5AmAcLrTTGDsPrAZKLyeEDg0/gZsvI6grlD1UM1Lz+FyQQFKgq/L7uxG+9eEvxYT5jAf4b66nrKgBWNVLyAXmLPROwklcBZA+OXbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rJosQjalIQnpINy6fNufS6WviGWrMie24aLGclblL8k=;
 b=YmyL7Iyhf2Ilyl846KHNpcsAWI6ws2al9nDVYeu9iJTYaXDa+FeevxW96Xt5P6nLj9F2hEtwCHvz3LONZAxU+3GQi1jlZTKdQH8cNYkw+l8jDKkQF4pgvm+CuVXrVN0M9R9NlYK0cX3+h6anRrdHXO9lAQdB+kEDa9fmmOFCnXtjPzmuw1fGu0IaCZxEGFYQ9zMaxPZ3fver61U32I08b3uBTnWt4QhVJdcdEFm52IW0IEiBmG/I8STn7tQ3OiwNMjzLYwXV2ScKKqHG1P+F1RCSp58obpcWvXPEnK2Asf0Kp05vJk7XOTC/0kL5ORuWYhr8eoVJkz+yKtzn9o9gxw==
Received: from BLAPR03CA0072.namprd03.prod.outlook.com (2603:10b6:208:329::17)
 by IA6PR12MB074433.namprd12.prod.outlook.com (2603:10b6:208:5fc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Tue, 24 Nov
 2026 14:05:22 +0000
Received: from LV8PEPF0000006C.namprd03.prod.outlook.com
 (2603:10b6:208:329:cafe::38) by BLAPR03CA0072.outlook.office365.com
 (2603:10b6:208:329::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.12 via Frontend Transport; Tue,
 24 Nov 2026 14:05:22 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 LV8PEPF0000006C.mail.protection.outlook.com (10.167.248.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Tue, 24 Nov 2026 14:05:22 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 24 Nov
 2026 06:04:57 -0800
Received: from kalok-SPC741D16QM3.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 06:04:44 -0800
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
Subject: [PATCH v5 22/35] gpu: nova-core: vgpu: query VF assignments and properties
Date: Tue, 24 Nov 2026 19:29:18 +0530
Message-ID: <20261124135937.18583-23-alkumar@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: LV8PEPF0000006C:EE_|IA6PR12MB074433:EE_
X-MS-Office365-Filtering-Correlation-Id: e73d6848-026b-4225-788b-08df4a33fb23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|82310400026|1800799024|376014|7416014|261026140227099003|261026121527099003|261022075727099003|261022113327099003|261022105027099003|261028144727099003|261021135927099003|261021121427099003|261021123027099003|261102123227099003|11063799006|56012099006|10067099003|261009223027099003|6133799003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	hipqHaEDLhbAU2/vDFQyiZZQPipf3TkwB7BmTY6ARfWDtdNM7Li41cG8H4H9fTCnZ4zeJPU5RwPO2Nu6BgMoCeilqgtE+b1koBXxk+l3NfAD507KmxvrbVKc4SrvdvTq0hb9KXcj10K50rPvkDbjZmfbkM2h6prjCegFBOQzMG08bqn8J2gVBthuljO6Ftn1NWK0BCYTTJiZ+agsdLUn1t6hT7+v5SyzI6QJeJH1xnNbKdgsZre35HnwOrLKr12qPMfyCSEXBrM6RGMGrDpzWh2wA9AjHfRm9MUGYMqQ28y/vj1NRg6jvScmQ269YmQDxcQ7vEu3JAzZPdoIQbWjzXXNbwrc3YIiybYXW7e7l1SUJ1VLR84Jx0HiCVF/HUbcGGvv4JyB1q9genwbeclG49QWoLR6EU2vXR/qt2pD1h6f5tWrhjyEcOH5Z0UsRZEZa1k66Nhu1hqah7c2H1JX2wRIRy4GWl/pLAL6kQZSAZeaExGbHgo0QqpcNUfUhYtvg9u5nD1w0fRVukA7v4UfsfrjkRJrV1vC30hSlXjv5oTtDRx8NqR0YZjGih34gIqoAX1gnpW8Yu2odSjsRIoXWq2hd42LyO+jw1IE3AXVv902eqwhNgwyAVYllhaEag+iE3yYYBUBjdKhWsvLjpzFIDyq6QLc9fx4MsLKXUl0m8eo+ktdHNUWasEfdcBaeZLQzArGBVfddM1xQ26MuhV8ig==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(82310400026)(1800799024)(376014)(7416014)(261026140227099003)(261026121527099003)(261022075727099003)(261022113327099003)(261022105027099003)(261028144727099003)(261021135927099003)(261021121427099003)(261021123027099003)(261102123227099003)(11063799006)(56012099006)(10067099003)(261009223027099003)(6133799003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	DAmu7ntf2/6ZZMhPeHnXAi89ssGGTB3tiPWC2usN9jx8OKvB+0+wZxtuirqSjyU2ODSB+fXUe5Izu30MXa0v547sXSWmWk6JD1yMylK03rNOGRWgmA0lFVD+udkrUvenkR3Ur0Gep1I/08nGhVd0hSMAKUO2P7Ulv1TUR2fZym22K8rtH88lw9RkuzNoZbZYAHBLh/S03vOk8R6kJj4K1xzxqILPqlV7gvT2sbu43E22BtJCAua8RgKrfdeCG0et/ZZZcczTeAtCutRg1FnM6q1ABoiUqEML55VPEXgtQ3duYv/+ALfX15OIasK8FFcwp1m61MLgo2fJaWnbpop1uHhaf4tiFl9BEQ+v6Pb0QjcmjIeZfAI/mY37Rh+4NGPPlG6wOlsG48QewV7EaLNNQ9DuonYXl7dE35WloZoHpSt57JjtAI7mlpYRXbLr3bbh
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 14:05:22.5721
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e73d6848-026b-4225-788b-08df4a33fb23
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	LV8PEPF0000006C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA6PR12MB074433

From: Zhi Wang <zhiw@nvidia.com>

Creating an instance requires its VF assignment and the corresponding
vGPU properties before reserving resources.

Decode the VF assignment and NVKV property replies at their query entry
points. Validate the returned type ID and nonzero instance limit, and
initialize the decoded properties on the heap.

Co-developed-by: Eliot Courtney <ecourtney@nvidia.com>
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
Co-developed-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
Signed-off-by: Alok Kumar <alkumar@nvidia.com>
---
 drivers/gpu/nova-core/gsp.rs              |   1 +
 drivers/gpu/nova-core/gsp/fw.rs           |   2 +-
 drivers/gpu/nova-core/sbuffer.rs          |   7 ++
 drivers/gpu/nova-core/vgpu.rs             |  11 ++
 drivers/gpu/nova-core/vgpu/commands.rs    | 126 ++++++++++++++++++++++
 drivers/gpu/nova-core/vgpu/fw.rs          |   6 ++
 drivers/gpu/nova-core/vgpu/fw/commands.rs |  75 +++++++++++++
 7 files changed, 227 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/nova-core/vgpu/commands.rs
 create mode 100644 drivers/gpu/nova-core/vgpu/fw/commands.rs

diff --git a/drivers/gpu/nova-core/gsp.rs b/drivers/gpu/nova-core/gsp.rs
index 4bce365c96e5..125dfd06aab1 100644
--- a/drivers/gpu/nova-core/gsp.rs
+++ b/drivers/gpu/nova-core/gsp.rs
@@ -29,6 +29,7 @@
 pub(crate) use logbuffer::RetainedLogs;
 
 pub(crate) use fw::{
+    GmcCommandId,
     GspFmcBootParams,
     GspFwWprMeta,
     LibosMemoryRegionInitArgument,
diff --git a/drivers/gpu/nova-core/gsp/fw.rs b/drivers/gpu/nova-core/gsp/fw.rs
index 6daabb6aea78..5158f0e7c12c 100644
--- a/drivers/gpu/nova-core/gsp/fw.rs
+++ b/drivers/gpu/nova-core/gsp/fw.rs
@@ -2,7 +2,7 @@
 // SPDX-FileCopyrightText: Copyright (c) 2025-2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
 
 pub(crate) mod commands;
-mod r000_00;
+pub(crate) mod r000_00;
 
 // Alias to avoid repeating the version number with every use.
 use r000_00 as bindings;
diff --git a/drivers/gpu/nova-core/sbuffer.rs b/drivers/gpu/nova-core/sbuffer.rs
index b8c01104c255..fd410aef2a1f 100644
--- a/drivers/gpu/nova-core/sbuffer.rs
+++ b/drivers/gpu/nova-core/sbuffer.rs
@@ -161,6 +161,13 @@ pub(crate) fn read_exact(&mut self, mut dst: &mut [u8]) -> Result {
         Ok(())
     }
 
+    pub(crate) fn read<T: FromBytes + IntoBytes>(&mut self) -> Result<T> {
+        let mut ret = T::new_zeroed();
+        self.read_exact(ret.as_mut_bytes())?;
+
+        Ok(ret)
+    }
+
     /// Read all the remaining data into a [`KVec`].
     ///
     /// `self` will be empty after this operation.
diff --git a/drivers/gpu/nova-core/vgpu.rs b/drivers/gpu/nova-core/vgpu.rs
index 5fd9641db579..0934932e051d 100644
--- a/drivers/gpu/nova-core/vgpu.rs
+++ b/drivers/gpu/nova-core/vgpu.rs
@@ -4,6 +4,7 @@
 use core::num::NonZero;
 
 use kernel::{
+    bitfield,
     device,
     pci,
     prelude::*, //
@@ -21,10 +22,20 @@
     gsp::commands::FifoEngineList, //
 };
 
+mod commands;
 mod fw;
 mod hal;
 mod vram;
 
+bitfield! {
+    struct Dbdf(u32) {
+        2:0 function;
+        7:3 device;
+        15:8 bus;
+        31:16 domain;
+    }
+}
+
 /// vGPU state detected during GPU construction.
 #[derive(Debug, Clone, Copy)]
 pub(crate) enum VgpuState {
diff --git a/drivers/gpu/nova-core/vgpu/commands.rs b/drivers/gpu/nova-core/vgpu/commands.rs
new file mode 100644
index 000000000000..66669948230a
--- /dev/null
+++ b/drivers/gpu/nova-core/vgpu/commands.rs
@@ -0,0 +1,126 @@
+// SPDX-License-Identifier: GPL-2.0
+// SPDX-FileCopyrightText: Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+
+//! vGPU firmware command operations.
+//!
+//! Sends requests, checks responses and coordinates the firmware command
+//! sequences used by instance lifecycle operations.
+
+use core::convert::Infallible;
+
+use kernel::{
+    device,
+    prelude::*, //
+};
+
+use crate::{
+    gsp::{
+        cmdq::{
+            gmc::{
+                CommandToGsp,
+                MessageFromGsp,
+                MessagePayload, //
+            },
+            Cmdq,
+        },
+        nvkv::{
+            nvkv_words,
+            Decoder,
+            Schema,
+            UnknownKeyPolicy, //
+        },
+        GmcCommandId,
+        GSP_PAGE_SIZE, //
+    },
+    vgpu::{
+        fw::commands::{
+            AssignedVfVgpuType,
+            VgpuProperties,
+            VgpuPropertiesSchema, //
+        },
+        Dbdf,
+    },
+};
+
+struct QueryAssignedVfVgpuType(Dbdf);
+
+impl CommandToGsp for QueryAssignedVfVgpuType {
+    const COMMAND: GmcCommandId = GmcCommandId::QueryAssignedVfVgpuType;
+    type Command = u64;
+    type Reply = AssignedVfVgpuType;
+    const MAX_REPLY_SIZE: u32 = cv!(size_of::<AssignedVfVgpuType>());
+    type InitError = Infallible;
+
+    fn init(&self) -> impl Init<Self::Command, Self::InitError> {
+        u64::from(self.0.into_raw()).to_le()
+    }
+}
+
+impl MessageFromGsp for AssignedVfVgpuType {
+    type InitError = Error;
+
+    fn read(payload: &mut MessagePayload<'_>) -> Result<Self, Self::InitError> {
+        payload.read()
+    }
+}
+
+/// Query the vGPU type assigned to a VF by its DBDF.
+#[expect(dead_code)]
+pub(super) fn query_assigned_vf_type(
+    _dev: &device::Device,
+    cmdq: &Cmdq<'_>,
+    dbdf: Dbdf,
+) -> Result<u32> {
+    let reply = cmdq
+        .send_gmc_command(QueryAssignedVfVgpuType(dbdf), |_| Ok(()))?
+        .map_err(|_| EIO)?;
+
+    Ok(reply.vgpu_type_id)
+}
+
+struct QueryVgpuProperties(u32);
+
+impl CommandToGsp for QueryVgpuProperties {
+    const COMMAND: GmcCommandId = GmcCommandId::QueryVgpuProperties;
+    type Command = u32;
+    type Reply = KBox<VgpuProperties>;
+    /// The reply is NVKV-encoded and varies in length.
+    const MAX_REPLY_SIZE: u32 = cv!(GSP_PAGE_SIZE);
+    type InitError = Infallible;
+
+    fn init(&self) -> impl Init<Self::Command, Self::InitError> {
+        self.0.to_le()
+    }
+}
+
+impl MessageFromGsp for KBox<VgpuProperties> {
+    type InitError = Error;
+
+    fn read(payload: &mut MessagePayload<'_>) -> Result<Self, Self::InitError> {
+        let bytes = payload.flush_into_kvec(GFP_KERNEL)?;
+        let words = nvkv_words(&bytes, &[])?;
+        let decoder = Decoder::new(&words, UnknownKeyPolicy::Ignore);
+        let mut schema = KBox::init(VgpuPropertiesSchema::init(), GFP_KERNEL)?;
+        let properties = KBox::try_init(decoder.decode(&mut *schema)?, GFP_KERNEL)?;
+
+        Ok(properties)
+    }
+}
+
+/// Query and decode the firmware properties of one vGPU type.
+#[expect(dead_code)]
+pub(super) fn query_vgpu_properties(
+    _dev: &device::Device,
+    cmdq: &Cmdq<'_>,
+    type_id: u32,
+) -> Result<KBox<VgpuProperties>> {
+    let properties = cmdq
+        .send_gmc_command(QueryVgpuProperties(type_id), |_| Ok(()))?
+        .map_err(|_| EIO)?;
+
+    if properties.type_id != type_id || properties.max_instance == 0 {
+        Err(EINVAL)
+    } else {
+        Ok(properties)
+    }
+}
diff --git a/drivers/gpu/nova-core/vgpu/fw.rs b/drivers/gpu/nova-core/vgpu/fw.rs
index e4571cfe11a3..2d32e196a771 100644
--- a/drivers/gpu/nova-core/vgpu/fw.rs
+++ b/drivers/gpu/nova-core/vgpu/fw.rs
@@ -1,4 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0
 // SPDX-FileCopyrightText: Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
 
+//! vGPU firmware interface.
+//!
+//! Exposes command constants and communication buffer layout types from
+//! raw firmware bindings.
+
+pub(super) mod commands;
 mod r000_00;
diff --git a/drivers/gpu/nova-core/vgpu/fw/commands.rs b/drivers/gpu/nova-core/vgpu/fw/commands.rs
new file mode 100644
index 000000000000..d1864d7ab530
--- /dev/null
+++ b/drivers/gpu/nova-core/vgpu/fw/commands.rs
@@ -0,0 +1,75 @@
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
+    prelude::*, //
+};
+
+use crate::{
+    gsp::nvkv::{
+        nvkv_decode,
+        Array,
+        Key,
+        Required, //
+    }, //
+};
+
+nvkv_decode! {
+    pub(crate) struct VgpuPropertiesSchema => VgpuProperties {
+        // TODO: `name`/`class` required?
+        name: Array<u8, { VgpuProperties::STRING_LEN }, 0x3100>,
+        class: Array<u8, { VgpuProperties::STRING_LEN }, 0x3101>,
+        type_id: Required<Key<u32, 0x3102>>,
+        bar1_length: Required<Key<u64, 0x3103>>,
+        max_instance: Required<Key<u32, 0x3104>>,
+        ecc: Key<u32, 0x3105>,
+        profile_size: Required<Key<u64, 0x3106>>,
+        max_fps: Key<u32, 0x3107>,
+        num_heads: Key<u32, 0x3108>,
+        max_res_x: Key<u32, 0x3109>,
+        max_res_y: Key<u32, 0x310A>,
+        dev_id: Required<Key<u32, 0x310B>>,
+        subsystem_id: Required<Key<u32, 0x310C>>,
+        fb_length: Required<Key<u64, 0x310D>>,
+        gsp_heap_size: Required<Key<u64, 0x310E>>,
+        fb_reservation: Required<Key<u64, 0x310F>>,
+    }
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
+
+// TODO: extract from bindings
+#[repr(C)]
+#[derive(FromBytes, IntoBytes)]
+pub(crate) struct AssignedVfVgpuType {
+    pub(crate) vgpu_type_id: u32,
+    _swizz_id: u32,
+    _placement_id: u32,
+}
-- 
2.53.0


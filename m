Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795529099;
	b=J6+blpG0GI6vceRnGSvdYndbzw7ys5bhPpUIIubpZtYQFCD+mCfa6YUfrA0oOITOxxyO
	 0nBNFfCZ82/H/dpGhqBHIB0LXpb6LrUFAt5zBCs4q1uLmoEKohI04iyQvzy75GhSPx6qg
	 xF5aZrQF+F5pEXO6zGarAaDtZg40pVZESGIZp4bRo1uZch6HnQMCLQNPuRakWQ6oc2WhW
	 2cEHyuV/+MNmPs6m04ncbC5pWj3x00/MGliOPsPzhz8XEZS7TSvTKl1GLDOwrzB6uC9QG
	 DWnj3NM8qQwyoWdJPx5m405Srws7lH0iCSJOS141ltoo+Mm3iONPb8CyKxXcxdKj8LA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795529099;
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
	bh=uK9drtW3KoXzfzlRarQz6s1Ll2nChmvJmb0w58BzsSA=;
	b=aUc3NViWD1TaytXwIkYCVy34+lfXwCoJ3IrfQ7bv27PvbU2vwM55+woxLiHU3OzUcnPS
	 Uf/NgyW3qQYsJqTZJokUZ5sR2P4Rt49RED/6ZC6AtSSaeSX57sFpvEwZKHjCSkhZ2VMOb
	 +lnYOdYYMH0+aPZ16eWHHBxycX7Vs7bh4A8Kg4oD1YpOlbamNQ6B7Q63eRLrxPtOjZgny
	 Qz+pcChq3K21iX/nOJTg9gL4Kvc5SOyGA2Jae8E8Fnv2O7apOv3s/hOUvIlwg31J3hwMS
	 Nb2IuzxOiRppl251H278UQ1m3+px9jX39bqrDyIiv5HVbzXiQOqeDOkhmiqqd0mjS1g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=qZ4gtPK8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.19
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013019.outbound.protection.outlook.com [40.93.196.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639BE60A3831;
	Tue, 24 Nov 2026 14:04:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 639BE60A3831
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=qZ4gtPK8
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tKovUdZcGbDLzv5rexlWjOHNArzhBl3Oab6/g4ZodDWGFRBBCAMxWTtxtPM31HoRn+KJwPlKPm/6Ye1FZ2R6YeyQjuffUsOaK5MxRcJ2g/A8Idtlrm+OQPb1eoysiNekGEIr1Ed7nQTY5qvO7IRuIuR5VLEgRajizdmGOqn7Yp6d4+8/a6eJZM2V746idUQDX+FDdHuectQo/s2G6wJDHQwfP4KGM/emyM57MtCIZT14JiWfv1LOGtWCtXoYVU7tgvGpkA69mT8TouXReByrShgdXWPcFhyeTwQF6LMmhYqpB8ysmiB5BkgD7464qq8p0X6ux+XKpzkdFXHU1W5M4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uK9drtW3KoXzfzlRarQz6s1Ll2nChmvJmb0w58BzsSA=;
 b=f1v15HT/lSpGHd2EWHYJ3726WLFhdmTkTcrvfoAIDYz53lxbSnG3C+LW5u0HyKJOSUnKuWrU3bbUuiPtKsMWspRTuv9SmUjTXSv8Ot6DsQ3bEltueHqK5eNtgKGMsGg5fB4kfRVW4yTXfjFyJD6Uf2q11qztscMoSp6rmk6pHqr9DnI64xGQHxKjcYAHEoN6qmZqj9V9FQ+9YivnXB5D/VNQ37XG6KLNoWXxE4jaNb/a5txvOaQPIn/UJyvnvXqAE8RFnitAVl5WZhK4cqQYsb2Xk+N3vc/1PJnrZT9ZWgPFUm47BX0K3Xc3mx5zafG9AjNQVc0JrCH4AcmKIgU5Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uK9drtW3KoXzfzlRarQz6s1Ll2nChmvJmb0w58BzsSA=;
 b=qZ4gtPK8T4diI8DZufPTcNI5y+GFvb8Spa77xUsvn7uRnUr8n9aAO7+6lWmoJQ897Tqw8p8MvqdmTqDEgjcO4QVNrLvkCdMnW/Eq+Z8sGl+FcvuCVqKodu+r36E9yz/W1ZsqP9DOck/byxf8Cmyvh1v1m4wikckGafOj5N91oI5L+tagjhG1mobQFalRzdiQK7B+lli8qintJ591//0ZRzXrwsblySZwXWPce3X0uQq4nNjpnaMrBSqCwu7NP8h6VFdUjg8OTztxH6R5+W6zQpS3vWmmOSlxzQuinfkNducrgpvAf0wIHQyso3/QRfXLEn/UBDSybF8oArZxaLzVKQ==
Received: from CY5P220CA0008.NAMP220.PROD.OUTLOOK.COM (2603:10b6:930:ed::9) by
 PH7PR12MB7967.namprd12.prod.outlook.com (2603:10b6:510:273::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.14; Tue, 24 Nov 2026 14:04:49 +0000
Received: from CY6PEPF00000047.namprd03.prod.outlook.com
 (2603:10b6:930:ed:cafe::8b) by CY5P220CA0008.outlook.office365.com
 (2603:10b6:930:ed::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.6 via Frontend Transport; Tue, 24
 Nov 2026 14:04:49 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY6PEPF00000047.mail.protection.outlook.com (10.167.247.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Tue, 24 Nov 2026 14:04:48 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 24 Nov
 2026 06:04:18 -0800
Received: from kalok-SPC741D16QM3.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 06:04:05 -0800
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
Subject: [PATCH v5 19/35] gpu: nova-core: vgpu: add r000 plugin bindings
Date: Tue, 24 Nov 2026 19:29:15 +0530
Message-ID: <20261124135937.18583-20-alkumar@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY6PEPF00000047:EE_|PH7PR12MB7967:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c5290d1-be3b-458c-f074-08df4a33e70d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|7416014|82310400026|1800799024|376014|261102123227099003|261026121527099003|261022075727099003|261022113327099003|261021135927099003|261021121427099003|11063799006|56012099006|10067099003|260925022911599003|260925021311599003|261009223027099003|18002099003|6133799003|22082099003|261102130727099003|260925021911599003|3023799007;
X-Microsoft-Antispam-Message-Info:
	XwieLGtfxusTT9IEZhp+GqToAZauna1jHzId4AJJFT6U/dkb1eNk9IYpaAcglNGs8JGbmLM3GqOp9GnYCj9FmpGtXQGy5UQEfUBtneyeLBbH2XtwSvwHp4UgQc9UJIGOx3vBmwQ/i3fj4dOHrcajsfQzFznGV/odf6acbvfaqh5qk1XUwcwOPkf7+hCCQgEOcABvRq0Ttzo05REZm/8O8wstruM01kVFt/PBamyJcDhT9D1vkgXrHl1LpKyrCdsGXlxTBXRee4bjRwahtxjOk2MrsAgd7BRJmE6Ow/AajYcUE4H54qWXnZk5sszHrMbAOFvk+YvHIB0caqtnBy2beYvPa1kVzXUSxPHxSobMUxs+bLPLiNiAhDDSi+ykFyM3OjakHTCTBLBUEq83/QrWxfb8yflrWLJWPcN5Q6cQ3SYdtwGm0NUL/8Wb59S8/0Q7WA9dh+yPQd1p8ayiIdzHxuVefz/R+67OmRCNaimkomq9fDj8iSjXbz8cICps3X7hRj6TnQT2E7yVg4i+8xxH6isIifsw30K0NeEN93cu7iXqLmKv8LvgQnImJzW0heTPNq6QgR7UuYH9KLbtIwExkQDWjp52jKRQbZsez9heHl8w6JEhp02oQzxOkqx/rLkEYOlWZLOwNPo55902C4JSNiylmMrLgwGCRj31mDAucwh6FN6EOjwfO+Hmn55cZRA+PF99EEClgiW3Cz5NCkNZxw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(7416014)(82310400026)(1800799024)(376014)(261102123227099003)(261026121527099003)(261022075727099003)(261022113327099003)(261021135927099003)(261021121427099003)(11063799006)(56012099006)(10067099003)(260925022911599003)(260925021311599003)(261009223027099003)(18002099003)(6133799003)(22082099003)(261102130727099003)(260925021911599003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	VQFq2Q2E+W7BONOqAcwPceqD6u0aqCCBHSOudlV4eaUMeI1FOrrkQqKJh+bNTDcfVSoVVI97A+j8BtzG1QMNaa+2+kQw3wsEkBEpvzD8i2bAaXWkRbheebdxcpN8cMM9qttXxTwwJWjld+QmnKFl9u1OsLl4RSwh7A0g+rK49PqZvCfgTq+Bcz6tQQoOJuiWBKhKa9CFAEyfeGnaJ/xnMgsnhUUsX6HCk2U/b61ejrn1kPPGMn4ckogwjPDqrQj+qxzXFlWCjD6TvdH+mWtzB+zMP3U658Cm0kTddL5TmTukYUS+G4yfwQx07ZF5MW3sdAR9fl9d/3wub9v+iGn1MBKDuqXWSq5rI+27djXAj9R+difw7/Zsd8MGpKMdNMNo3uL50Y3L9gSCbuW19FpgONRstxyF8oM0A3WAmOzwhtWgMN35Fo0/BElNJxlGK7+r
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 14:04:48.9636
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c5290d1-be3b-458c-f074-08df4a33e70d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY6PEPF00000047.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7967

From: Zhi Wang <zhiw@nvidia.com>

The GSP plugin communication area and RPC protocol are defined by the r000
firmware interface. Keeping local copies of that ABI risks letting the vGPU
manager drift from the firmware layout.

Extend the existing r000 binding set with the nova-core subset of
dev_vgpu_gsp_shared.h. The bindings expose the control and response
region types, message IDs, and firmware-defined region sizes. Keep the
raw declarations private and expose only the symbols needed by the GSP
plugin communication layer.

Signed-off-by: Zhi Wang <zhiw@nvidia.com>
Co-developed-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Alok Kumar <alkumar@nvidia.com>
---
 .../gpu/nova-core/gsp/fw/r000_00/bindings.rs  |   1 +
 drivers/gpu/nova-core/vgpu.rs                 |   1 +
 drivers/gpu/nova-core/vgpu/fw.rs              |   4 +
 drivers/gpu/nova-core/vgpu/fw/r000_00.rs      |  25 +++
 .../gpu/nova-core/vgpu/fw/r000_00/bindings.rs | 182 ++++++++++++++++++
 5 files changed, 213 insertions(+)
 create mode 100644 drivers/gpu/nova-core/vgpu/fw.rs
 create mode 100644 drivers/gpu/nova-core/vgpu/fw/r000_00.rs
 create mode 100644 drivers/gpu/nova-core/vgpu/fw/r000_00/bindings.rs

diff --git a/drivers/gpu/nova-core/gsp/fw/r000_00/bindings.rs b/drivers/gpu/nova-core/gsp/fw/r000_00/bindings.rs
index fa17d3e2edf6..f836d7ee84a0 100644
--- a/drivers/gpu/nova-core/gsp/fw/r000_00/bindings.rs
+++ b/drivers/gpu/nova-core/gsp/fw/r000_00/bindings.rs
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+// SPDX-FileCopyrightText: Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
 
 #[repr(C)]
 #[derive(Default)]
diff --git a/drivers/gpu/nova-core/vgpu.rs b/drivers/gpu/nova-core/vgpu.rs
index 8a6d87233aaf..ea4bb5915879 100644
--- a/drivers/gpu/nova-core/vgpu.rs
+++ b/drivers/gpu/nova-core/vgpu.rs
@@ -21,6 +21,7 @@
     gsp::commands::FifoEngineList, //
 };
 
+mod fw;
 mod hal;
 
 /// vGPU state detected during GPU construction.
diff --git a/drivers/gpu/nova-core/vgpu/fw.rs b/drivers/gpu/nova-core/vgpu/fw.rs
new file mode 100644
index 000000000000..e4571cfe11a3
--- /dev/null
+++ b/drivers/gpu/nova-core/vgpu/fw.rs
@@ -0,0 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
+// SPDX-FileCopyrightText: Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+
+mod r000_00;
diff --git a/drivers/gpu/nova-core/vgpu/fw/r000_00.rs b/drivers/gpu/nova-core/vgpu/fw/r000_00.rs
new file mode 100644
index 000000000000..77d6b06961f7
--- /dev/null
+++ b/drivers/gpu/nova-core/vgpu/fw/r000_00.rs
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Bindings generated by `bindgen` from the r000 GSP firmware headers.
+//!
+//! Use them only through the parent module, which abstracts or re-exports the symbols that the
+//! driver needs.
+
+#![allow(
+    dead_code,
+    clippy::all,
+    clippy::undocumented_unsafe_blocks,
+    clippy::ptr_as_ptr,
+    clippy::ref_as_ptr,
+    missing_docs,
+    non_camel_case_types,
+    non_upper_case_globals,
+    non_snake_case,
+    improper_ctypes,
+    unreachable_pub,
+    unsafe_op_in_unsafe_fn
+)]
+use kernel::ffi;
+use pin_init::MaybeZeroable;
+
+include!("r000_00/bindings.rs");
diff --git a/drivers/gpu/nova-core/vgpu/fw/r000_00/bindings.rs b/drivers/gpu/nova-core/vgpu/fw/r000_00/bindings.rs
new file mode 100644
index 000000000000..85f965335b64
--- /dev/null
+++ b/drivers/gpu/nova-core/vgpu/fw/r000_00/bindings.rs
@@ -0,0 +1,182 @@
+// SPDX-License-Identifier: GPL-2.0
+
+pub type __u8 = ffi::c_uchar;
+pub type __u16 = ffi::c_ushort;
+pub type __u32 = ffi::c_uint;
+pub type __u64 = ffi::c_ulonglong;
+pub type u8_ = __u8;
+pub type u16_ = __u16;
+pub type u32_ = __u32;
+pub type u64_ = __u64;
+pub const GSP_PLUGIN_BOOTLOADED: u32 = 1315261039;
+pub const VGPU_CPU_GSP_CTRL_BUFF_VERSION: u32 = 2;
+pub const VGPU_CPU_GSP_CTRL_BUFF_REGION_SIZE: u32 = 4096;
+pub const VGPU_CPU_GSP_RESPONSE_BUFF_REGION_SIZE: u32 = 4096;
+pub const VGPU_CPU_GSP_MESSAGE_BUFF_REGION_SIZE: u32 = 4096;
+pub const VGPU_CPU_GSP_MIGRATION_BUFF_REGION_SIZE: u32 = 2097152;
+pub const VGPU_CPU_GSP_ERROR_BUFF_REGION_SIZE: u32 = 4096;
+pub const VGPU_CPU_GSP_INIT_TASK_LOG_BUFF_REGION_SIZE: u32 = 131072;
+pub const VGPU_CPU_GSP_VGPU_TASK_LOG_BUFF_REGION_SIZE: u32 = 262144;
+pub const VGPU_CPU_GSP_KERNEL_TASK_LOG_BUFF_REGION_SIZE: u32 = 65536;
+pub const VGPU_CPU_GSP_GUEST_RPC_TRACE_BUFF_REGION_SIZE: u32 = 65536;
+pub const VGPU_CPU_GSP_COMMUNICATION_BUFF_TOTAL_SIZE: u32 = 2637824;
+pub type VGPU_CPU_GSP_BOOL = u32_;
+#[repr(C)]
+#[derive(Debug, Default, Copy, Clone, MaybeZeroable)]
+pub struct VGPU_CPU_GSP_VGX_VERSION {
+    pub major_number: u32_,
+    pub minor_number: u32_,
+}
+#[repr(C)]
+#[derive(Debug, Copy, Clone, MaybeZeroable)]
+pub struct VGPU_CPU_GSP_GUEST_INFO {
+    pub vgx_version: VGPU_CPU_GSP_VGX_VERSION,
+    pub guest_driver_version_buffer_length: u32_,
+    pub guest_version_buffer_length: u32_,
+    pub guest_title_buffer_length: u32_,
+    pub guest_changelist_number: u32_,
+    pub guest_driver_version_buffer: [ffi::c_char; 256usize],
+    pub guest_version_buffer: [ffi::c_char; 256usize],
+    pub guest_title_buffer: [ffi::c_char; 256usize],
+    pub guest_branch_buffer: [ffi::c_char; 256usize],
+}
+impl Default for VGPU_CPU_GSP_GUEST_INFO {
+    fn default() -> Self {
+        let mut s = ::core::mem::MaybeUninit::<Self>::uninit();
+        unsafe {
+            ::core::ptr::write_bytes(s.as_mut_ptr(), 0, 1);
+            s.assume_init()
+        }
+    }
+}
+#[repr(C)]
+#[derive(Copy, Clone, MaybeZeroable)]
+pub union VGPU_CPU_GSP_CTRL_BUFF_REGION {
+    pub buf: [u8_; 4096usize],
+    pub __bindgen_anon_1: VGPU_CPU_GSP_CTRL_BUFF_REGION__bindgen_ty_1,
+}
+#[repr(C)]
+#[derive(Debug, Default, Copy, Clone, MaybeZeroable)]
+pub struct VGPU_CPU_GSP_CTRL_BUFF_REGION__bindgen_ty_1 {
+    pub version: u32_,
+    pub message_type: u32_,
+    pub message_seq_num: u32_,
+    pub __bindgen_padding_0: [u8; 4usize],
+    pub response_buff_offset: u64_,
+    pub message_buff_offset: u64_,
+    pub migration_buff_offset: u64_,
+    pub error_buff_offset: u64_,
+    pub guest_rpc_trace_buff_offset: u64_,
+    pub migration_buf_cpu_access_offset: u32_,
+    pub is_migration_in_progress: u8_,
+    pub __bindgen_padding_1: [u8; 3usize],
+    pub error_buff_cpu_get_idx: u32_,
+    pub guest_rpc_trace_buff_cpu_get_idx: u32_,
+    pub attached_vgpu_count: u32_,
+    pub is_gr_init_done: u8_,
+    pub __bindgen_padding_2: [u8; 3usize],
+    pub host_info: [VGPU_CPU_GSP_CTRL_BUFF_REGION__bindgen_ty_1__bindgen_ty_1; 16usize],
+}
+#[repr(C)]
+#[derive(Debug, Default, Copy, Clone, MaybeZeroable)]
+pub struct VGPU_CPU_GSP_CTRL_BUFF_REGION__bindgen_ty_1__bindgen_ty_1 {
+    pub vgpu_type_id: u32_,
+    pub host_gpu_pci_id: u32_,
+    pub pci_dev_id: u32_,
+    pub vgpu_uuid: [u8_; 16usize],
+}
+impl Default for VGPU_CPU_GSP_CTRL_BUFF_REGION {
+    fn default() -> Self {
+        let mut s = ::core::mem::MaybeUninit::<Self>::uninit();
+        unsafe {
+            ::core::ptr::write_bytes(s.as_mut_ptr(), 0, 1);
+            s.assume_init()
+        }
+    }
+}
+pub const MESSAGE_NV_VGPU_CPU_RPC_MSG_VERSION_NEGOTIATION: MESSAGE = 1;
+pub const MESSAGE_NV_VGPU_CPU_RPC_MSG_SETUP_CONFIG_PARAMS_AND_INIT: MESSAGE = 2;
+pub const MESSAGE_NV_VGPU_CPU_RPC_MSG_RESET: MESSAGE = 3;
+pub const MESSAGE_NV_VGPU_CPU_RPC_MSG_MIGRATION_STOP_WORK: MESSAGE = 4;
+pub const MESSAGE_NV_VGPU_CPU_RPC_MSG_MIGRATION_CANCEL_STOP: MESSAGE = 5;
+pub const MESSAGE_NV_VGPU_CPU_RPC_MSG_MIGRATION_SAVE_STATE: MESSAGE = 6;
+pub const MESSAGE_NV_VGPU_CPU_RPC_MSG_MIGRATION_CANCEL_SAVE: MESSAGE = 7;
+pub const MESSAGE_NV_VGPU_CPU_RPC_MSG_MIGRATION_RESTORE_STATE: MESSAGE = 8;
+pub const MESSAGE_NV_VGPU_CPU_RPC_MSG_MIGRATION_RESTORE_DEFERRED_STATE: MESSAGE = 9;
+pub const MESSAGE_NV_VGPU_CPU_RPC_MSG_MIGRATION_RESUME_WORK: MESSAGE = 10;
+pub const MESSAGE_NV_VGPU_CPU_RPC_MSG_CONSOLE_VNC_STATE: MESSAGE = 11;
+pub const MESSAGE_NV_VGPU_CPU_RPC_MSG_VF_BAR0_REG_ACCESS: MESSAGE = 12;
+pub const MESSAGE_NV_VGPU_CPU_RPC_MSG_UPDATE_BME_STATE: MESSAGE = 13;
+pub const MESSAGE_NV_VGPU_CPU_RPC_MSG_RESET_MIGRATION_BUFFER_PTR: MESSAGE = 14;
+pub const MESSAGE_NV_VGPU_CPU_RPC_MSG_RELEASE_CLIENT_DATABASE: MESSAGE = 15;
+pub const MESSAGE_NV_VGPU_CPU_RPC_MSG_CHECK_IS_ALIVE: MESSAGE = 16;
+pub const MESSAGE_NV_VGPU_CPU_RPC_MSG_SEND_STATIC_INFO: MESSAGE = 17;
+pub const MESSAGE_NV_VGPU_CPU_RPC_MSG_MAX: MESSAGE = 18;
+pub type MESSAGE = ffi::c_uint;
+#[repr(C)]
+#[derive(Debug, Default, Copy, Clone, MaybeZeroable)]
+pub struct VGPU_CPU_GSP_DISPLAYLESS_SURFACE {
+    pub sequence_update_start: u64_,
+    pub sequence_update_end: u64_,
+    pub effective_fb_page_size: u32_,
+    pub rect_width: u32_,
+    pub rect_height: u32_,
+    pub surface_width: u32_,
+    pub surface_height: u32_,
+    pub surface_size: u32_,
+    pub surface_offset: u32_,
+    pub surface_format: u32_,
+    pub surface_kind: u32_,
+    pub surface_pitch: u32_,
+    pub surface_type: u32_,
+    pub surface_block_height: u8_,
+    pub __bindgen_padding_0: [u8; 3usize],
+    pub is_blanking_enabled: VGPU_CPU_GSP_BOOL,
+    pub is_flip_pending: VGPU_CPU_GSP_BOOL,
+    pub is_free_pending: VGPU_CPU_GSP_BOOL,
+    pub is_memory_blocklinear: VGPU_CPU_GSP_BOOL,
+}
+#[repr(C)]
+#[derive(Copy, Clone, MaybeZeroable)]
+pub union VGPU_CPU_GSP_RESPONSE_BUFF_REGION {
+    pub buf: [u8_; 4096usize],
+    pub __bindgen_anon_1: VGPU_CPU_GSP_RESPONSE_BUFF_REGION__bindgen_ty_1,
+}
+#[repr(C)]
+#[derive(Debug, Copy, Clone, MaybeZeroable)]
+pub struct VGPU_CPU_GSP_RESPONSE_BUFF_REGION__bindgen_ty_1 {
+    pub message_seq_num_received: u32_,
+    pub message_seq_num_processed: u32_,
+    pub result_code: u32_,
+    pub guest_rpc_version: u32_,
+    pub migration_buf_gsp_access_offset: u32_,
+    pub migration_state_save_complete: u32_,
+    pub is_migration_allowed: VGPU_CPU_GSP_BOOL,
+    pub __bindgen_padding_0: [u8; 4usize],
+    pub surface: [VGPU_CPU_GSP_DISPLAYLESS_SURFACE; 4usize],
+    pub error_buff_gsp_put_idx: u32_,
+    pub grid_license_state: u32_,
+    pub guest_os_type: u32_,
+    pub frl_config: u32_,
+    pub guest_info: VGPU_CPU_GSP_GUEST_INFO,
+    pub is_guest_info_populated: VGPU_CPU_GSP_BOOL,
+    pub guest_rpc_trace_buff_gsp_put_idx: u32_,
+}
+impl Default for VGPU_CPU_GSP_RESPONSE_BUFF_REGION__bindgen_ty_1 {
+    fn default() -> Self {
+        let mut s = ::core::mem::MaybeUninit::<Self>::uninit();
+        unsafe {
+            ::core::ptr::write_bytes(s.as_mut_ptr(), 0, 1);
+            s.assume_init()
+        }
+    }
+}
+impl Default for VGPU_CPU_GSP_RESPONSE_BUFF_REGION {
+    fn default() -> Self {
+        let mut s = ::core::mem::MaybeUninit::<Self>::uninit();
+        unsafe {
+            ::core::ptr::write_bytes(s.as_mut_ptr(), 0, 1);
+            s.assume_init()
+        }
+    }
+}
-- 
2.53.0


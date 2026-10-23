Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.16
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792770090;
	b=bZp9hOk/hPRW47vLKfyTATOVwvopfsbvFDM2VuImcwupN0+NIhFhRerwG2yNlOKh1ig2
	 Rp4H+GgNsZfIIbKDhbkDQ2jW9n9nAhS7RmNHIAd4WfZgEmAnK7e/mAQzlBbFtkfGoqnLY
	 E0Lp9Qq/xK0/MiXkXpi+0j9wqLrTg+0GDJEwWRuvt8KilTLYR3fncJWr2MDAoyCkWEXDQ
	 dN6C57domaQged5H8P2nCWk3j7ibrgGEy39VtaIFfAhtCfEcJ84wGgcqo40K8u4lHgL/V
	 QUWZElEHkdmW2gBRoy9Ij8VHnXK1bV4RCxw1JN8ep18NLeG90GpRQSiJNlDTQmmobnw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792770090;
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
	bh=Es8v+TmDgsT7AaU8tCGUkyLbuR3yWL8yc++7cel+0/U=;
	b=Ca7YPluaguj0Gw3doNIcuYzuRNIYeFOSi48f/qiWuQkDFXxoEhEzkK1ertnHE+qxF0TX
	 MTW9AZf4FsU7cXmXftLHxecoNa94bBfZyN3i7UeMwc1jgIlN5vOqmI/yIXaXKOsajnx5y
	 7Tqj4sFYEjrDOMKKpJEdg7vCXXdg5BcT4BiQD5FjR+fOVhBHjW0/MiZIFh2iT3g6CS5LZ
	 LW1JE1LKY5cky1TvOwJ4S71jpZEpp7Bl3JTPorlcERPc4qBuYhjupi9m9p/Le29cYcK1A
	 diWS72LgbaGRuMpUUlPVjaeMI0Ymk6ovDIHkU58ytXvEdbgnfKzMSS83J8yXc33MT6A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Fo9YrXNh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.16
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010016.outbound.protection.outlook.com [52.101.201.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6E2606A31F;
	Fri, 23 Oct 2026 15:41:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E6E2606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Fo9YrXNh
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dsT36FRsB0q3f0gA/O1hQY4dbr4qRBcSVybhiUu5VoZwr8p5q/MOCsF6hffw6KT1+Yn3iP79PFjmosR9Ej6avIh4Ti567XVeYvBhjgLOTgzhXC1U9bEAPyZgPDSTlrCU3IcI1OUUA0S3ihTqLzJzm9ma5SuMVlHE2huviufg+3qSfVlFMeMl2DtTVtOKSiztV5OK7/VBz/lSZPKaWtQk836P9bshFFz2IVYHn8V5DmEigm6SdOeaxsFjH49QnyoUMyEK381t7+iSWsycjRRVMvmP2LUTLOPV9kiiLuBrP4is2M8+Kzln7TpxSqc3AyqG3z9H045uQdoS6rqDzqxGnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Es8v+TmDgsT7AaU8tCGUkyLbuR3yWL8yc++7cel+0/U=;
 b=OgyQemrJIUWecvidN16uSRHbRlwh+qtYlfupt/f2hzNtPjR1e6EomWMatX2VMp5wK4eDOnQhI5tBY+VI4GUBT6JHNPS9oQpbI5iuUdHIfNQqbfjfSJLqYa4DF4MAFrTrQ1ulQouDny4m5AV19j9/1k19R+6iVhm139AW/H285ONLVGttwmRdzN9SqQrTy2VlQkakxSDCkBQ7X3hOwF6nK4OQLR+hEzh+3/SFhzbYBPFBTE5lRtWkW+UIyijqXtZ8tNpCBNgpxoLzSAPqptsTyywGFIOxl6SOaExk6H6GPQmCVaxC1PEBcqUALw1Xp9eFgBOsFqLMjeAU9iVXBqx10g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Es8v+TmDgsT7AaU8tCGUkyLbuR3yWL8yc++7cel+0/U=;
 b=Fo9YrXNhNK+c3XVRkNcGGElMtMH3FAoNIvGqviHXZdSyjdP6QQmSe4o4K4kPLHPwbkDkCIpKGDhmRSjKgnVRTktbw0SNon7EoZtjfE8aOTg+JFsj+G3JTyIlWkPxYBdOVH7PqRbD9jldshT6kRxJTkbxFKvHIj2j+sm1sfh6++kicJJ/dDoQqCncKqVtdlYVh2okFrwhzEOAEDpthwXsZmmjVUWtVPSAoXfZzyJchMdTGmQ6uIhVJ76z67IXaGnpKM0ETkJ8xD7T3O/YJgRrQ2/F+Gku1lOhAtWpCLE6T4bBdjY2svKAx9SHM7F1P6YnDe/YaXRylADEGVWlnxLqAw==
Received: from SJ0PR13CA0195.namprd13.prod.outlook.com (2603:10b6:a03:2c3::20)
 by BL1PR12MB5897.namprd12.prod.outlook.com (2603:10b6:208:395::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.18; Fri, 23 Oct
 2026 15:41:19 +0000
Received: from CO1PEPF00018861.namprd02.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::1e) by SJ0PR13CA0195.outlook.office365.com
 (2603:10b6:a03:2c3::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.4 via Frontend Transport; Fri, 23
 Oct 2026 15:41:19 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF00018861.mail.protection.outlook.com (10.167.249.250) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Fri, 23 Oct 2026 15:41:18 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 23 Oct
 2026 08:40:56 -0700
Received: from xinmengs-dev-vm-linux.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 23 Oct 2026 08:40:54 -0700
From: Simon Song <xinmengs@nvidia.com>
To: <dakr@kernel.org>, <acourbot@nvidia.com>, <kvm@vger.kernel.org>,
	<rust-for-linux@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
	<linux-pci@vger.kernel.org>
CC: <alex@shazbot.org>, <jgg@nvidia.com>, <yishaih@nvidia.com>,
	<skolothumtho@nvidia.com>, <kevin.tian@intel.com>, <airlied@gmail.com>,
	<simona@ffwll.ch>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
	<boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
	<lossin@kernel.org>, <a.hindborg@kernel.org>, <aliceryhl@google.com>,
	<tmgross@umich.edu>, <jhubbard@nvidia.com>, <ecourtney@nvidia.com>,
	<cjia@nvidia.com>, <smitra@nvidia.com>, <kjaju@nvidia.com>,
	<alkumar@nvidia.com>, <ankita@nvidia.com>, <aniketa@nvidia.com>,
	<kwankhede@nvidia.com>, <targupta@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <zhiwang@kernel.org>, <zhiw@nvidia.com>,
	<boqun@kernel.org>, <daniel.almeida@collabora.com>, <tamird@kernel.org>,
	<work@onurozkan.dev>, <jgg@ziepe.ca>, <bhelgaas@google.com>,
	<kwilczynski@kernel.org>, <dri-devel@lists.freedesktop.org>,
	<peter@colberg.org>, <xinmengs@nvidia.com>
Subject: [PATCH v2 12/12] vfio/nvidia-vgpu: add the Rust VFIO variant driver
Date: Fri, 23 Oct 2026 08:40:07 -0700
Message-ID: <20261023154009.2246627-13-xinmengs@nvidia.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261023154009.2246627-1-xinmengs@nvidia.com>
References: <20261023154009.2246627-1-xinmengs@nvidia.com>
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
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00018861:EE_|BL1PR12MB5897:EE_
X-MS-Office365-Filtering-Correlation-Id: 553a72de-b4aa-4517-848a-08df311c14e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700016|23010399003|1800799024|5023799004|11063799006|56012099006|261022075727099003|261021123027099003|261021130227099003|261022113327099003|261022105027099003|261022115727099003|261021135927099003|261021121427099003|261009223027099003|10067099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	5khIg/a/zUkMnRKdE6tMoJ7nuVeeZZVcAXLcn+sQfUUT0F77wcGncNvq77vVUxo2Oo/V4eT4DSZCzu/NPAnF1SlX46W6d2F++tOCozNIMnNSvW/jWABaOg8YGj0Tps56g7dgDCLC/noQtYLei5CxOSjXSG29UP8VWY37OTwcEg8854LEUoo+UWGrNB4NjXnI+F/aUX4WTZbFwwVvQu8Rgyp2Vvqrytaryz0yBku+UHPZ9WZBGqpBM16zyErgWZaOYee539YfW/aMcR7NBiN/H/wnv7sB1Mv3ql8El/i5nKUSVA9teq35JLk47LNb6OOHRgT4fVCkKWfn0kn8iwdpQN4zS76nTdqrVZRb/g+xjBbGtXJ5dfuzAqbHtWAibRh4vTO3o/tANq6X92uJZ84ghSU9UBn/+vin8efK5tNvzlLiht9hCX/QAAT1vN8xKIR3OSZDOkzlTfHWJsGfl6s1fv4uv3co0PRNBZQ0H8jADtFRsqq6bNXUqCCwYwBK22O5VEchWx/x0gHFtpO+LB/topYfAjhBzENikTu1t2udCBLZ5vLaMFKrFN5odFstam41AR5iv4xdBEUt6rdo/p5q572YxazLbiVihLDEoVEzWykfdFn4avW2a4SRUQ48Ec1J4mZ8x8mKH0OCqlFq9ahDTS4srdyP5idhaqcLD5ybkmUswpYEuWNEc7MNeiaHfzw/oPgAJ7A7SvDgHh3fd4tU8g==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700016)(23010399003)(1800799024)(5023799004)(11063799006)(56012099006)(261022075727099003)(261021123027099003)(261021130227099003)(261022113327099003)(261022105027099003)(261022115727099003)(261021135927099003)(261021121427099003)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ruhYlfDSLF+XfLok+XoVwKvuWQakGWdvlEzfgveObR71v9+C2FIJiKq0KzZAztfYcquRVhpIvXWnaQf0PycnL73HOJxZriUSvB0UYLd6tFBfmPcuDr9iXCsDwm1JVO/59mHBwUremIULnRgEUUznvfhCLLtDyi7iAUx6/R4d8CdJMmk/6ca0WT6jNk/hfSxU8jKqYGTjPdE3/saxac2OV89C1RJT/jnsC8ulG5qxwaFqy51UqORWCm7G7exwAAaMgHLQI2OXdamrpNcw5i3VUkDvNSLVQgeDUY/ZFCctW8k1FRk1lyI+HOT7WYzTUezRZjDBm+PE8RaAaJLs8dzvIbE70FgmnX9AhN0KzoW6CTJtzlvJJYzcHumChqw0J9cyomg9J47ST6VbVWMnlf4pDoys1DMJxxFTorraab/0T7Glmov0IzViQFdtI2UyB+h+
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 15:41:18.8685
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 553a72de-b4aa-4517-848a-08df311c14e5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00018861.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5897

From: Danilo Krummrich <dakr@kernel.org>

NVIDIA vGPU VFs need nova-core to manage their instances when assigned
to userspace through VFIO.

Add a Rust VFIO PCI variant driver that uses the typed SR-IOV PF APIs
to create an instance on first open and close it on last close. Expose
the assigned device and subsystem IDs, enforce the assigned BAR1
aperture, and coordinate firmware reset with PCI reset.

Match NVIDIA devices through a VFIO override-only entry. Devices
without an available Nova vGPU interface use ordinary PCI passthrough.

Use the PCI adapter to keep callback data available throughout
registration and removal. Extend the GPU build rules to make nova-core
crate metadata available to the VFIO driver and export the Rust symbols
it references.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
Signed-off-by: Simon Song <xinmengs@nvidia.com>
---
 drivers/gpu/Makefile                        |  15 +-
 drivers/vfio/pci/Kconfig                    |   2 +
 drivers/vfio/pci/Makefile                   |   2 +
 drivers/vfio/pci/nvidia-vgpu/Kconfig        |  20 +
 drivers/vfio/pci/nvidia-vgpu/Makefile       |   3 +
 drivers/vfio/pci/nvidia-vgpu/nvidia_vgpu.rs | 402 ++++++++++++++++++++
 6 files changed, 441 insertions(+), 3 deletions(-)
 create mode 100644 drivers/vfio/pci/nvidia-vgpu/Kconfig
 create mode 100644 drivers/vfio/pci/nvidia-vgpu/Makefile
 create mode 100644 drivers/vfio/pci/nvidia-vgpu/nvidia_vgpu.rs

diff --git a/drivers/gpu/Makefile b/drivers/gpu/Makefile
index e372fc02139..1b8a907e716 100644
--- a/drivers/gpu/Makefile
+++ b/drivers/gpu/Makefile
@@ -19,8 +19,9 @@ nova-core-y := nova-core/nova_core.o nova-core/nova_core_exports.o
 obj-$(CONFIG_DRM_NOVA) += nova-drm.o
 nova-drm-y := drm/nova/nova.o
 
-# Export Rust symbols from nova-core only if nova-drm actually references them.
-nova-core-export-deps := $(if $(CONFIG_DRM_NOVA),$(obj)/drm/nova/nova.o)
+# Export Rust symbols from nova-core only if dependent modules reference them.
+nova-core-export-deps := $(if $(CONFIG_DRM_NOVA),$(obj)/drm/nova/nova.o) \
+	$(if $(CONFIG_NVIDIA_VGPU_VFIO_PCI),$(obj)/../vfio/pci/nvidia-vgpu/nvidia_vgpu.o)
 
 rust_needed_exports = \
 	{ $(if $(strip $(2)),$(NM) -u $(2);,) echo "__DEFINED_RUST_SYMBOLS__"; \
@@ -57,10 +58,18 @@ $(obj)/nova-core/nova_core_exports.o: private cmd_gensymtypes_c = \
 		$(obj)/nova-core/nova_core.o
 endif
 
-# Output nova-core's crate metadata for use by nova-drm at compile time.
+# Output nova-core's crate metadata for its Rust consumers at compile time.
 RUSTFLAGS_nova-core/nova_core.o += \
 	--emit=metadata=$(objtree)/$(obj)/nova-core/libnova_core.rmeta
 
 # Allow nova-drm to import nova-core's types.
 $(obj)/drm/nova/nova.o: $(obj)/nova-core/nova_core.o
 RUSTFLAGS_drm/nova/nova.o := -L $(objtree)/$(obj)/nova-core --extern nova_core
+
+# Build the NVIDIA VFIO driver here so metadata and generated exports share
+# the same dependency graph as nova-drm.
+obj-$(CONFIG_NVIDIA_VGPU_VFIO_PCI) += nvidia-vgpu-vfio-pci.o
+nvidia-vgpu-vfio-pci-y := ../vfio/pci/nvidia-vgpu/nvidia_vgpu.o
+
+$(obj)/../vfio/pci/nvidia-vgpu/nvidia_vgpu.o: $(obj)/nova-core/nova_core.o
+RUSTFLAGS_../vfio/pci/nvidia-vgpu/nvidia_vgpu.o := -L $(objtree)/$(obj)/nova-core --extern nova_core
diff --git a/drivers/vfio/pci/Kconfig b/drivers/vfio/pci/Kconfig
index 296bf01e185..b48d8d1af42 100644
--- a/drivers/vfio/pci/Kconfig
+++ b/drivers/vfio/pci/Kconfig
@@ -74,4 +74,6 @@ source "drivers/vfio/pci/qat/Kconfig"
 
 source "drivers/vfio/pci/xe/Kconfig"
 
+source "drivers/vfio/pci/nvidia-vgpu/Kconfig"
+
 endmenu
diff --git a/drivers/vfio/pci/Makefile b/drivers/vfio/pci/Makefile
index 6138f1bf241..58c88304a18 100644
--- a/drivers/vfio/pci/Makefile
+++ b/drivers/vfio/pci/Makefile
@@ -24,3 +24,5 @@ obj-$(CONFIG_NVGRACE_GPU_VFIO_PCI) += nvgrace-gpu/
 obj-$(CONFIG_QAT_VFIO_PCI) += qat/
 
 obj-$(CONFIG_XE_VFIO_PCI) += xe/
+
+# nvidia-vgpu is built from drivers/gpu/Makefile for nova-core crate linkage.
diff --git a/drivers/vfio/pci/nvidia-vgpu/Kconfig b/drivers/vfio/pci/nvidia-vgpu/Kconfig
new file mode 100644
index 00000000000..1363f84163e
--- /dev/null
+++ b/drivers/vfio/pci/nvidia-vgpu/Kconfig
@@ -0,0 +1,20 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config NVIDIA_VGPU_VFIO_PCI
+	tristate "VFIO support for the NVIDIA vGPU"
+	depends on NOVA_CORE && PCI_IOV && RUST
+	select VFIO_PCI_CORE
+	help
+	  This option enables VFIO (Virtual Function I/O) support for
+	  NVIDIA virtual GPUs (vGPU). It allows the assignment of a virtual
+	  GPU instance to userspace applications via VFIO, typically used
+	  with hypervisors such as KVM and device emulators like QEMU.
+
+	  Devices without an available Nova vGPU interface use ordinary PCI
+	  passthrough. Both paths use the VFIO PCI core defaults; vfio-pci
+	  module options do not apply.
+
+	  The NVIDIA vGPU allows a physical GPU to be partitioned into
+	  multiple virtual GPUs, each of which can be passed to a virtual
+	  machine as a PCI device using the standard VFIO infrastructure.
+
+	  If you don't know what to do here, say N.
diff --git a/drivers/vfio/pci/nvidia-vgpu/Makefile b/drivers/vfio/pci/nvidia-vgpu/Makefile
new file mode 100644
index 00000000000..bce0133562f
--- /dev/null
+++ b/drivers/vfio/pci/nvidia-vgpu/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+# nvidia-vgpu is built from drivers/gpu/Makefile for nova-core crate linkage.
+# nvidia_vgpu.o (rust-analyzer marker - DO NOT REMOVE).
diff --git a/drivers/vfio/pci/nvidia-vgpu/nvidia_vgpu.rs b/drivers/vfio/pci/nvidia-vgpu/nvidia_vgpu.rs
new file mode 100644
index 00000000000..f16d6cf6a4a
--- /dev/null
+++ b/drivers/vfio/pci/nvidia-vgpu/nvidia_vgpu.rs
@@ -0,0 +1,402 @@
+// SPDX-License-Identifier: GPL-2.0
+// SPDX-FileCopyrightText: Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+
+//! NVIDIA vGPU VFIO variant driver.
+//!
+//! Nova VFs own an instance between the first VFIO open and last close. Other
+//! matching devices use ordinary PCI passthrough.
+
+use kernel::{
+    bindings,
+    device::{
+        Bound,
+        Core, //
+    },
+    io::resource::Flags,
+    pci,
+    prelude::*,
+    sync::{
+        CondVar,
+        Mutex,
+        MutexGuard, //
+    },
+    types::CovariantForLt,
+    vfio::{
+        self,
+        pci::{
+            GetRegionInfo,
+            Ioctl,
+            Mapping,
+            Mmap,
+            Open,
+            Position,
+            Read,
+            Write, //
+        }, //
+    }, //
+};
+use nova_core::{
+    NovaCoreVfApi,
+    NovaCoreVfApiHandle,
+    VgpuInstance, //
+};
+
+struct NvidiaVgpuOps;
+
+struct VgpuRegistration<'a> {
+    api: NovaCoreVfApiHandle<'a>,
+    gfid: u32,
+}
+
+#[derive(Default)]
+struct InstanceState {
+    active: bool,
+    resetting: bool,
+    reset_error: Option<Error>,
+}
+
+#[pin_data]
+struct NvidiaVgpuRegData<'a> {
+    pdev: &'a pci::Device<Bound>,
+    vgpu: Option<VgpuRegistration<'a>>,
+    fb_bar: u32,
+    #[pin]
+    state: Mutex<InstanceState>,
+    #[pin]
+    reset_done: CondVar,
+}
+
+impl NvidiaVgpuRegData<'_> {
+    fn lock_instance(&self) -> MutexGuard<'_, InstanceState> {
+        let mut state = self.state.lock();
+        while state.resetting {
+            self.reset_done.wait(&mut state);
+        }
+        state
+    }
+}
+
+struct NvidiaVgpuOpenData<'a> {
+    registration: &'a NvidiaVgpuRegData<'a>,
+    instance: Option<VgpuInstance<'a>>,
+}
+
+impl<'a> NvidiaVgpuOpenData<'a> {
+    fn new(
+        dev: &vfio::pci::Device<NvidiaVgpuOps, Open>,
+        rd: &'a NvidiaVgpuRegData<'a>,
+    ) -> Result<Self> {
+        let mut state = rd.lock_instance();
+        let instance = match &rd.vgpu {
+            Some(vgpu) => {
+                // The firmware DBDF format has a 16-bit PCI segment field.
+                let segment = u16::try_from(rd.pdev.domain_nr()).map_err(|_| EOVERFLOW)?;
+                let dbdf = (u32::from(segment) << 16) | u32::from(rd.pdev.dev_id());
+                let vm_pid = kernel::current!().tgid().try_into()?;
+                let instance = vgpu.api.open(vgpu.gfid, dbdf, vm_pid)?;
+                let info = instance.type_info();
+                dev.set_device_id(info.pci_dev_id as u16);
+                state.active = true;
+                state.reset_error = None;
+                Some(instance)
+            }
+            None => None,
+        };
+        Ok(Self {
+            registration: rd,
+            instance,
+        })
+    }
+
+    fn bar1_size(&self) -> Result<Option<u64>> {
+        let Some(instance) = &self.instance else {
+            return Ok(None);
+        };
+        let physical = self
+            .registration
+            .pdev
+            .resource_len(self.registration.fb_bar)?;
+        let size = instance
+            .type_info()
+            .bar1_length
+            .checked_mul(1 << 20)
+            .ok_or(EOVERFLOW)?;
+        Ok(Some(if size == 0 {
+            physical
+        } else {
+            size.min(physical)
+        }))
+    }
+
+    fn limit_bar1(&self, buf: &mut vfio::UserBuf, position: &Position<'_>) -> Result {
+        if buf.is_empty() || position.region_index() != self.registration.fb_bar {
+            return Ok(());
+        }
+        if let Some(size) = self.bar1_size()? {
+            let offset = position.region_offset();
+            if offset >= size {
+                return Err(EINVAL);
+            }
+            if size - offset < buf.len() as u64 {
+                buf.truncate((size - offset) as usize);
+            }
+        }
+        Ok(())
+    }
+}
+
+impl Drop for NvidiaVgpuOpenData<'_> {
+    fn drop(&mut self) {
+        let mut state = self.registration.lock_instance();
+        state.active = false;
+        drop(self.instance.take());
+    }
+}
+
+impl vfio::pci::Operations for NvidiaVgpuOps {
+    const NAME: &'static CStr = c"nvidia-vgpu-vfio-pci";
+    type RegistrationData = CovariantForLt!(NvidiaVgpuRegData<'_>);
+    type OpenData<'a> = NvidiaVgpuOpenData<'a>;
+
+    fn open_device<'a>(
+        dev: &'a vfio::pci::Device<Self, Open>,
+        rd: &'a NvidiaVgpuRegData<'a>,
+    ) -> impl PinInit<Self::OpenData<'a>, Error> + 'a {
+        NvidiaVgpuOpenData::new(dev, rd)
+    }
+
+    fn ioctl<'a>(
+        dev: &vfio::pci::Device<Self, Ioctl>,
+        rd: &NvidiaVgpuRegData<'a>,
+        _open_data: Pin<&Self::OpenData<'a>>,
+        cmd: u32,
+        arg: usize,
+    ) -> Result<isize> {
+        let reset = cmd == vfio::DEVICE_RESET || cmd == vfio::pci::DEVICE_PCI_HOT_RESET;
+        if reset {
+            if let Some(error) = rd.state.lock().reset_error {
+                return Err(error);
+            }
+        }
+        let result = dev.core_ioctl(cmd, arg)?;
+        if reset {
+            if let Some(error) = rd.state.lock().reset_error {
+                return Err(error);
+            }
+        }
+        Ok(result)
+    }
+
+    fn read<'a>(
+        dev: &vfio::pci::Device<Self, Read>,
+        _rd: &NvidiaVgpuRegData<'a>,
+        open_data: Pin<&Self::OpenData<'a>>,
+        buf: &mut vfio::UserBuf,
+        position: &mut Position<'_>,
+    ) -> Result<isize> {
+        if let Some(instance) = &open_data.instance {
+            if position.region_index() == vfio::pci::CONFIG_REGION_INDEX {
+                let offset = position.region_offset();
+                return position.with_temporary(|next| {
+                    let count = dev.core_read(buf, next)?;
+                    buf.write_overlapping(
+                        offset,
+                        count.try_into()?,
+                        u64::from(bindings::PCI_SUBSYSTEM_ID),
+                        &(instance.type_info().pci_subsys_id as u16).to_le_bytes(),
+                    )?;
+                    Ok(count)
+                });
+            }
+        }
+        open_data.limit_bar1(buf, position)?;
+        dev.core_read(buf, position)
+    }
+
+    fn write<'a>(
+        dev: &vfio::pci::Device<Self, Write>,
+        _rd: &NvidiaVgpuRegData<'a>,
+        open_data: Pin<&Self::OpenData<'a>>,
+        buf: &mut vfio::UserBuf,
+        position: &mut Position<'_>,
+    ) -> Result<isize> {
+        open_data.limit_bar1(buf, position)?;
+        dev.core_write(buf, position)
+    }
+
+    fn mmap<'a>(
+        dev: &vfio::pci::Device<Self, Mmap>,
+        rd: &NvidiaVgpuRegData<'a>,
+        open_data: Pin<&Self::OpenData<'a>>,
+        mapping: &mut Mapping<'_>,
+    ) -> Result {
+        if mapping.region_index() == rd.fb_bar {
+            if let Some(size) = open_data.bar1_size()? {
+                if mapping.region_end()? > size {
+                    return Err(EINVAL);
+                }
+            }
+        }
+        dev.core_mmap(mapping)
+    }
+
+    fn get_region_info<'a>(
+        dev: &vfio::pci::Device<Self, GetRegionInfo>,
+        rd: &NvidiaVgpuRegData<'a>,
+        open_data: Pin<&Self::OpenData<'a>>,
+        info: &mut bindings::vfio_region_info,
+        caps: &mut vfio::InfoCap<'_>,
+    ) -> Result {
+        dev.core_get_region_info(info, caps)?;
+        if info.index == rd.fb_bar && info.size != 0 {
+            if let Some(size) = open_data.bar1_size()? {
+                info.size = info.size.min(size);
+            }
+        }
+        Ok(())
+    }
+
+    fn reset_prepare(rd: &NvidiaVgpuRegData<'_>) {
+        // PCI holds the device lock, and VFIO may hold its memory lock. Open and
+        // close release this mutex before entering the VFIO core.
+        let mut state = rd.state.lock();
+        state.resetting = true;
+        if state.active {
+            if let Some(vgpu) = &rd.vgpu {
+                if let Err(error) = vgpu.api.reset(vgpu.gfid) {
+                    state.reset_error.get_or_insert(error);
+                }
+            }
+        }
+    }
+
+    fn reset_done(rd: &NvidiaVgpuRegData<'_>) -> Result {
+        let mut state = rd.state.lock();
+        let error = state.reset_error;
+        state.resetting = false;
+        rd.reset_done.notify_all();
+        error.map_or(Ok(()), Err)
+    }
+}
+
+struct NvidiaVgpuDriver;
+
+kernel::pci_device_table!(
+    PCI_TABLE,
+    <NvidiaVgpuDriver as pci::Driver>::IdInfo,
+    [(
+        pci::DeviceId::from_id_vfio_override(pci::Vendor::NVIDIA, bindings::PCI_ANY_ID as u32),
+        (),
+    ),]
+);
+
+#[pin_data]
+struct NvidiaVgpuData<'bound> {
+    reg: vfio::pci::Registration<'bound, NvidiaVgpuOps>,
+}
+
+#[vtable]
+impl pci::Driver for NvidiaVgpuDriver {
+    type IdInfo = ();
+    type Data<'bound> = NvidiaVgpuData<'bound>;
+    const ID_TABLE: pci::IdTable<Self::IdInfo> = &PCI_TABLE;
+    const DRIVER_MANAGED_DMA: bool = true;
+    #[cfg(CONFIG_PM)]
+    const PM_OPS: Option<pci::PmOps<Self>> = Some(pci::PmOps::new());
+
+    fn probe<'bound>(
+        pdev: &'bound pci::Device<Core<'_>>,
+        _info: Option<&'bound Self::IdInfo>,
+    ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound {
+        try_pin_init!(NvidiaVgpuData {
+            reg: {
+                let vgpu = match NovaCoreVfApi::handle(pdev) {
+                    Ok(api) => Some(VgpuRegistration {
+                        api,
+                        gfid: pdev.vf_id()?.checked_add(1).ok_or(EOVERFLOW)?,
+                    }),
+                    Err(_) => None,
+                };
+                let dev = if vgpu.is_some() {
+                    vfio::pci::Device::<NvidiaVgpuOps>::new(pdev)?
+                } else {
+                    vfio::pci::Device::<NvidiaVgpuOps>::new_passthrough(pdev)?
+                };
+                let fb_bar = if pdev.resource_flags(0)?.contains(Flags::IORESOURCE_MEM_64) {
+                    2
+                } else {
+                    1
+                };
+                // SAFETY: This probe owns the unregistered device; bind/unbind handle registration.
+                unsafe {
+                    vfio::pci::Registration::new(
+                        pdev,
+                        &dev,
+                        try_pin_init!(NvidiaVgpuRegData {
+                            pdev,
+                            vgpu,
+                            fb_bar,
+                            state <- kernel::new_mutex!(InstanceState::default()),
+                            reset_done <- kernel::new_condvar!(),
+                        }),
+                    )?
+                }
+            },
+        })
+    }
+
+    fn bind<'bound>(_pdev: &pci::Device<Core<'_>>, data: Pin<&Self::Data<'bound>>) -> Result {
+        // SAFETY: PCI installed the complete driver data; `unbind` unregisters it before removal.
+        unsafe { data.reg.register::<Self>() }
+    }
+
+    fn unbind<'bound>(_pdev: &'bound pci::Device<Core<'_>>, data: Pin<&Self::Data<'bound>>) {
+        // SAFETY: Bind succeeded, and PCI has not removed or destroyed any driver data.
+        unsafe { data.reg.unregister() };
+    }
+
+    fn reset_prepare<'bound>(_pdev: &pci::Device<Core<'_>>, data: Pin<&Self::Data<'bound>>) {
+        data.reg.reset_prepare();
+    }
+
+    fn reset_done<'bound>(pdev: &pci::Device<Core<'_>>, data: Pin<&Self::Data<'bound>>) {
+        if let Err(error) = data.reg.reset_done() {
+            dev_err!(pdev, "VFIO device reset failed: {:?}\n", error);
+            data.reg.error_detected();
+        }
+    }
+
+    fn error_detected<'bound>(
+        _pdev: &pci::Device<Core<'_>>,
+        data: Pin<&Self::Data<'bound>>,
+        _state: bindings::pci_channel_state_t,
+    ) -> bindings::pci_ers_result_t {
+        data.reg.error_detected()
+    }
+
+    #[cfg(CONFIG_PM)]
+    fn runtime_suspend<'bound>(
+        _pdev: &pci::Device<Bound>,
+        data: Pin<&Self::Data<'bound>>,
+    ) -> Result {
+        // SAFETY: Called from this device's PCI runtime-suspend callback.
+        unsafe { data.reg.runtime_suspend() }
+    }
+
+    #[cfg(CONFIG_PM)]
+    fn runtime_resume<'bound>(
+        _pdev: &pci::Device<Bound>,
+        data: Pin<&Self::Data<'bound>>,
+    ) -> Result {
+        // SAFETY: Called from this device's PCI runtime-resume callback.
+        unsafe { data.reg.runtime_resume() }
+    }
+}
+
+kernel::module_pci_driver! {
+    type: NvidiaVgpuDriver,
+    name: "nvidia-vgpu-vfio-pci",
+    authors: ["NVIDIA"],
+    description: "NVIDIA vGPU VFIO variant driver",
+    license: "GPL v2",
+}
-- 
2.43.7


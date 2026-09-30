Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011033.outbound.protection.outlook.com [40.93.194.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660804B486B;
	Wed, 30 Sep 2026 10:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790766008; cv=fail; b=qcszoWE+BA5tk+lANNW0SteOKsVVwLkYBgQebYgevZpal9RV5j9VEzn0znR9wCWEAEUWIj9PdKglONyD7+lC4aH8TIIGdMsO/iIYSGB6VYqxyX/z3jHv4djjcgxCHdLazbBrzIfS3Du59wFBJdlGo3ppZgBHVaIWS1yuQ2lL6nU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790766008; c=relaxed/simple;
	bh=luTPTX72mTWtWLAvX5GU6Uaa8Sx6lCu3iD4eZfzTI2c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oNPdGK3iBDmOs9/X6nz/k5JktxNXnlIiKLxgspid2JgEpwoeHdH9zRBP6warTwbbDScmm1hNdmqdTaYNYkDyh3Fj7x8pANqsFVAprj7R4Fzq2ASp8E0kDD+jcI47RIVfpUrKrId98fwS+uAN4CX3QZ9D8rsbzvbaviN1BtuZqSg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=P076ecpx; arc=fail smtp.client-ip=40.93.194.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="P076ecpx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u8dW3O6M1yhXMi4mn1c9nO+W5kFCWPKRwQKoug7Bq+U7iizGcXBnvCiQ/ycr1T+bYmWheS9oWAQVpQOK4F4/V38d315RBrmuI08yE8eO1v1VkMwDK698uBxYdn+L6whOlfJ0Q2OzG0FhcgDUCbgHouTyaBS0d8ZOHHnW2gI0IvCXhOADeAmIHxW2E6KMNaE0IRVYy3o/ceJTJgNH5oHlv5zJ87EEOz5763OPQrFkyw5H8/0PYD8U9roKBZGbAtVP1YMSd4ENJpMbGFhcUPYs+A1JzWqLrobFX7vLMR14l0MnUymTbZo+QYIt9fbukaccxw05GODADBZTnjbp/TnhYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hc6r7q6BZ4/ay2ZEibSvdt3QJUt91a7HrKb06g5P+Z4=;
 b=yVlMzKWQWbvaw4gHSn6lANan0fRJ5p0klValoyW0i2T1/OttIldElS0Prvi3hqLAyz5mJo8CvUnD0G++N99oFh8nyBHiPDJ8pf9V3KWHWFpSTAIL9JN0QNymiDCqzWpsh8awIEBlYf63FlWM59wWE2PEEP1Oiupz3RKsXH/t5edOIApUp2aMe57BJG3s+5lGqhkpdyINbJSVOhEpcwzGP6FyibvaDsdzJk3pCBVOqivgsrF9oKH/DLz5S/H+5SjDgC8Z+ABADpcZe+4DJqJ339xUlB8HJByulZzlDY91lQ1HRdUiY//nZvCZI09HF5BSn1PBD55ograXU/LpC58SLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hc6r7q6BZ4/ay2ZEibSvdt3QJUt91a7HrKb06g5P+Z4=;
 b=P076ecpxw2Z399lx4jrU9oc7OqrIYi0ZiIqDIdUgljKSiQ1TTfW847YGXALNaX48Z7ZFYRVBvFB87s+AUgjsgtxpcAP1Rh/Dh1AqKzZIjlHF6lv9cAjPrKZwYshC3+QnO8/SRdcZ5Fwhw2eTI05glGAflL/Qw+1mRQ1PeXoYTJf32wOdnhYwhQ4DfY8jpKyqYqF8vcrwWerQ5/AnBQ7uAQRH9Fq9Cl+/J7xajSk1KBIOsUosh5IPaf7+pg+tgwNELh/+t4HxquGcQPYQPuuyLq1jSonDjqM/TQjlHBIc5J7w/R0QJfSv0TGl7/WRZ05uwmtQsN7lxLMxjbB8i+7Lrw==
Received: from CH0PR03CA0349.namprd03.prod.outlook.com (2603:10b6:610:11a::33)
 by SJ5PPFDF5E260D0.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::9a6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Wed, 30 Sep
 2026 10:59:38 +0000
Received: from LV8PEPF0000005F.namprd02.prod.outlook.com
 (2603:10b6:610:11a:cafe::58) by CH0PR03CA0349.outlook.office365.com
 (2603:10b6:610:11a::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.15 via Frontend Transport; Wed,
 30 Sep 2026 10:59:38 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 LV8PEPF0000005F.mail.protection.outlook.com (10.167.245.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Wed, 30 Sep 2026 10:59:38 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 03:59:20 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 03:59:19 -0700
Received: from inno-dell.home (10.127.8.11) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.49 via Frontend Transport; Wed, 30
 Sep 2026 03:59:09 -0700
From: Zhi Wang <zhiw@nvidia.com>
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
	<linux-kernel@vger.kernel.org>, <zhiwang@kernel.org>, Zhi Wang
	<zhiw@nvidia.com>, Boqun Feng <boqun@kernel.org>, Daniel Almeida
	<daniel.almeida@collabora.com>, Tamir Duberstein <tamird@kernel.org>,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>, Jason Gunthorpe
	<jgg@ziepe.ca>, Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	<dri-devel@lists.freedesktop.org>, Peter Colberg <peter@colberg.org>, "Simon
 Song" <xinmengs@nvidia.com>
Subject: [PATCH 7/7] vfio/nvidia-vgpu: add the Rust VFIO variant driver
Date: Wed, 30 Sep 2026 13:57:49 +0300
Message-ID: <1dcd4305976c7f7ac89e1e3d516c3dfb5df8b70d.1790764573.git.zhiw@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1790764573.git.zhiw@nvidia.com>
References: <cover.1790764573.git.zhiw@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PEPF0000005F:EE_|SJ5PPFDF5E260D0:EE_
X-MS-Office365-Filtering-Correlation-Id: 40b25189-8129-4275-ae59-08df1ee1ebc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|23010399003|7416014|56012099006|10067099003|6133799003|3023799007|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	IlslAJXYj/VWKgDxXCi4lGQSL1QIw1U5xtbvxt0zZO6AJkwGCcF7TAyBFayOmmtGzedgSCP8ODKlpSc+3RfAfzb29CYtWfta5tPgB15VTQRTAMFuBOPSD02wFvsPl+KqJt42+5+EEpwcTOxkvpVzcMK1NYZc2c40Ia1Z0YzT98EeXMDwcvN9tWx4BJk1/PcVa8JD6ta8+ST78MTQgzXMGAp6PdFwcqpscYa1e+5CIR4IaWh+EszcJmJqECl/ZOKEYHOU6aWKT9fGSUCU+k+T536M1Ey9RdPUvLnCcC0xG2gnA2HT3L6r6T9Q/vR6lB078PdyulhaX27r1EmYRukdH1b4k8pGcffJ9mwk+HDRi4L+HFPMWrUpFQaoxOw6me/ncl1haOiJYJOasHQ9y/y30JefawZRpWD7g4Lja/g0z7+7KcHrnat2WOaCrWfIa1sq/DY5FNkWO9bCV5LFJyISYsyJX26JfGfYaCIVJ+fZ5gno8ZuqTLBWHc4qx1t0J48rHkhV13k5GdF1TqIbSfAAGrUA3AH2SqHvA8WztYQ37BAd4CQ4Li2IrnslSCMGeW2TAktnBc45DxaXVp81yZTW3Ey7ERVeC9fPy2X+dgZAesuTmqExMIno0gSV/aQtyjSgiLfuSPbsPQKZwcYSPbIydsW69zyn5vtfBabXYQeTm6Kjn57ETYg3LAfC5154pFpw3V9nNxN9+hyzaBrUM9TpaQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(23010399003)(7416014)(56012099006)(10067099003)(6133799003)(3023799007)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Q/YYcvpEXMVqmybAweU3nXXc5Y47NbsDVG/e2f+jj6Tses9Fg998wu7Za5kgDoump4sNFZAAREpDhY/8DDhGXRP1rSpSeBXbGDKjAF/Ud9EGy7fka5KAthJ2kBDAEMJqBGa5lbHTRJusOufBFsDcgxMwcq7kEYSQig8/8wSakXkBtg0PJ9AGkJj/xkHkv6SU9rRWVZ+lbdpGifHPuXmIqwa7BinZSsXMpzQK0Z/TCGQKXP+5hr/NqEVfbKcsTkOgiLmFMaoO1TBLHuASVZGya9FLjUOCtur0339UJCan2PPYjDXpp2FMh5ZYi+hZbMm3FMr7WstHJTPLz5tInBwL4vUF5YhV4GNBGr+PKIyYr57YpYN1CkJPmLgAw3Dz31O8wCrOVbQL7JS2ZbLs6H92YSzW2YgdxrdsXboyRXnu5Omjw2teX6Yoy7zCiWZ1ptcF
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 10:59:38.0424
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40b25189-8129-4275-ae59-08df1ee1ebc4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	LV8PEPF0000005F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFDF5E260D0

From: Danilo Krummrich <dakr@kernel.org>

NVIDIA vGPU VFs need nova-core to manage their instances when assigned
to userspace through VFIO.

Add a Rust VFIO PCI variant driver that uses the typed SR-IOV PF APIs
to create an instance on first open and close it on last close. Expose
the assigned device and subsystem IDs, enforce the assigned BAR1
aperture, and coordinate firmware reset with PCI reset.

Match NVIDIA devices through a VFIO override-only entry. Devices
without an available Nova vGPU interface use ordinary PCI passthrough.

Use the VFIO PCI adapter to keep callback data available throughout
registration and removal. Extend the GPU build rules to make nova-core
crate metadata available to the VFIO driver and export the Rust symbols
it references.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
---
 drivers/gpu/Makefile                        |  15 +-
 drivers/vfio/pci/Kconfig                    |   2 +
 drivers/vfio/pci/Makefile                   |   2 +
 drivers/vfio/pci/nvidia-vgpu/Kconfig        |  20 ++
 drivers/vfio/pci/nvidia-vgpu/Makefile       |   3 +
 drivers/vfio/pci/nvidia-vgpu/nvidia_vgpu.rs | 366 ++++++++++++++++++++
 6 files changed, 405 insertions(+), 3 deletions(-)
 create mode 100644 drivers/vfio/pci/nvidia-vgpu/Kconfig
 create mode 100644 drivers/vfio/pci/nvidia-vgpu/Makefile
 create mode 100644 drivers/vfio/pci/nvidia-vgpu/nvidia_vgpu.rs

diff --git a/drivers/gpu/Makefile b/drivers/gpu/Makefile
index e372fc02139f..1b8a907e716b 100644
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
index 296bf01e185e..b48d8d1af42a 100644
--- a/drivers/vfio/pci/Kconfig
+++ b/drivers/vfio/pci/Kconfig
@@ -74,4 +74,6 @@ source "drivers/vfio/pci/qat/Kconfig"
 
 source "drivers/vfio/pci/xe/Kconfig"
 
+source "drivers/vfio/pci/nvidia-vgpu/Kconfig"
+
 endmenu
diff --git a/drivers/vfio/pci/Makefile b/drivers/vfio/pci/Makefile
index 6138f1bf241d..58c88304a185 100644
--- a/drivers/vfio/pci/Makefile
+++ b/drivers/vfio/pci/Makefile
@@ -24,3 +24,5 @@ obj-$(CONFIG_NVGRACE_GPU_VFIO_PCI) += nvgrace-gpu/
 obj-$(CONFIG_QAT_VFIO_PCI) += qat/
 
 obj-$(CONFIG_XE_VFIO_PCI) += xe/
+
+# nvidia-vgpu is built from drivers/gpu/Makefile for nova-core crate linkage.
diff --git a/drivers/vfio/pci/nvidia-vgpu/Kconfig b/drivers/vfio/pci/nvidia-vgpu/Kconfig
new file mode 100644
index 000000000000..1363f84163e2
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
index 000000000000..bce0133562f3
--- /dev/null
+++ b/drivers/vfio/pci/nvidia-vgpu/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+# nvidia-vgpu is built from drivers/gpu/Makefile for nova-core crate linkage.
+# nvidia_vgpu.o (rust-analyzer marker - DO NOT REMOVE).
diff --git a/drivers/vfio/pci/nvidia-vgpu/nvidia_vgpu.rs b/drivers/vfio/pci/nvidia-vgpu/nvidia_vgpu.rs
new file mode 100644
index 000000000000..e3f1cd0abf5f
--- /dev/null
+++ b/drivers/vfio/pci/nvidia-vgpu/nvidia_vgpu.rs
@@ -0,0 +1,366 @@
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
+// SAFETY: The selector only borrows this device's sole registration and cannot sleep. This driver
+// uses the VFIO adapter below and does not enable SR-IOV from probe or unbind.
+unsafe impl vfio::pci::Driver for NvidiaVgpuDriver {
+    type Operations = NvidiaVgpuOps;
+
+    fn registration<'a, 'bound>(
+        data: Pin<&'a Self::Data<'bound>>,
+    ) -> &'a vfio::pci::Registration<'bound, NvidiaVgpuOps> {
+        &data.get_ref().reg
+    }
+}
+
+#[vtable]
+impl pci::Driver for NvidiaVgpuDriver {
+    type IdInfo = ();
+    type Data<'bound> = NvidiaVgpuData<'bound>;
+    const ID_TABLE: pci::IdTable<Self::IdInfo> = &PCI_TABLE;
+    const DRIVER_MANAGED_DMA: bool = true;
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
+                // SAFETY: The device was allocated for this probe and has not been
+                // registered. Private data owns it, and the VFIO adapter handles its registration.
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
+}
+
+kernel::module_driver!(<T>, vfio::pci::Adapter<T>, {
+    type: NvidiaVgpuDriver,
+    name: "nvidia-vgpu-vfio-pci",
+    authors: ["NVIDIA"],
+    description: "NVIDIA vGPU VFIO variant driver",
+    license: "GPL v2",
+});
-- 
2.53.0


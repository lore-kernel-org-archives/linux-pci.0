Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.32
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795819815;
	b=pVZ7twrviG6qZcvmD9vdJNxg1AbEe3l84eRkLApAAScLoGK+6i0GtpZN6thQ9WuoUdk1
	 1UmmgmvWpgdZiOgE1J6NzdIx2W2dVKs+Xbi86CsvtrLbmIBxhTd4v0kYZuj/UP/tC6bi8
	 B9nvyG3h3ZvNrFv/dlVBLxS82PjXNb/eLtASLG1dxoVSnMf/TGe2vELeuk3CzUlrPJAfr
	 rGRTmceSeZBchIOuHXd3jCFEtrU7txBhOzhfjhPkk+/yN1mwUHxXlLDJS2ytah0QsFx3G
	 WHuAzMF7jQVcN5zv07J1sP88peavvSECz90mfaIM16x/m+aio6P6uzhJN+FsNow8ywQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795819815;
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
	bh=MHGeFSlB36WEIRUtoibAweZJWaA85GR+UD3NO8KlBFQ=;
	b=HCaEkglGvW0b335lDAjhxACY0N9XNA1w3ZiU3dljirHOXoM7qkQNRici872Fi5NEKcrZ
	 dqL+za/VvheynhkbAqszm6QV+YaTgTxwlybg5CGiMZxU+WNVeO6KEUJs63yiU6KamTQjO
	 vNVOCfWY/Y/+rMjf/KtWmrYZDvth8aoHWARXdtOsdd1DH4IHSekUIP0pomVInMrLCT2a9
	 SZG86xTb/84xYmVP3BHzVgLVTvs+2vdyCxI0SJBF16bWc5wMIKoNh+79aqCVpWpWkK5hJ
	 t3R31F73FR8uQ/7Ko1AaKUbh4D6QjiZUIFR+qrfDockkhAcHRodw5SLWGzHyxJcpSew==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="VY1x5/u7";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.32
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010032.outbound.protection.outlook.com [40.93.198.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26DD606A6B9;
	Fri, 27 Nov 2026 22:50:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E26DD606A6B9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=VY1x5/u7
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tCT4z3SrnhAXwlqGTCpHKO4U5WyqTGpDpJEc19dQLI6hh2jjJcsA/I67Sne6qGTXztpzY7t97xCQgczdpI59Er9XSNsRVIjMlwf4++Ga1E9QQI1xvDaNyiJHTlEO3l/7M8wkVuj/Zw+Ys9YkoDB3VXHnzDjCrNwGPUFgXcIiUAo4U3kEvdpEoSIeGyhIX386ck2kjxD0uhP1aFxkZswAEqSWX5LSQsxvKC/E3VSuPB20LKRdYGuj0h3t00GIXnAnj+5zDi2SKPEzcxaP/LMQCtdfLc9rmccw3GepKecl3OXQtZcFa88rl2206niYbh+xdAJzMD+LuSXG5NmaaLYIqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MHGeFSlB36WEIRUtoibAweZJWaA85GR+UD3NO8KlBFQ=;
 b=cMBxZAkjHDRkoyWnz7wp/NWr+DI4J60mhcICj1cb7vfmG8oo1HsmjeZo7aR7C5fH3h0E8vxYfW6/3h3lY/Emt+P+Xl++vMxsbhw9e3KgUtsgF/7InZW039JYnwPWyRxtu28H+VOqgYXBGdzkGTRxTMPuwMteAElcXgVsQULHw4wIKyD1Wr8/a7SpAczVAjqP5kFEqkk/tzsa9N3vxfE3RB/S9t+xluBkOwFuPEIheEO3xsCfLGs2qlAwPie7bavAboxIZqLg5rjcFrvlG24qS9RhCgdEB/1msT1dtDq2QsbuJhaI5KEMVuMo5+0qfjZHJBVL3smSYwf7OPo/hF/Wuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MHGeFSlB36WEIRUtoibAweZJWaA85GR+UD3NO8KlBFQ=;
 b=VY1x5/u7sWaaDQTjzWMJ9JOU/+PZJadCl96PInhQywGQeORhCoq8hPBfPKoELg46NidhK91h4Ts9irav/WforT0uMJggR4WteamQA2DL7R4yWU/xhvHnAJYug7D7d6AgvMmmiQntJMIi2ZtF6ZlpHp+2Z/+932rLFjd/I9lqVu7SU4q2DylDlntKyPDq/p4lGQtv/+eug8gqTD5IXkjEeEc8POYNxognu6/b+vQVghJYMda999JyjBW+GuCS4z4urLo6RwqnbbPVbomoqIsJfuyP6pHAkSeTzS+5MyVQxo+eKRt6NC0TD3zyEViR0m46gIs3xqc2dvNJFC3JEe335w==
Received: from BN9PR03CA0472.namprd03.prod.outlook.com (2603:10b6:408:139::27)
 by SA3PR12MB7902.namprd12.prod.outlook.com (2603:10b6:806:305::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.10; Fri, 27 Nov
 2026 22:50:06 +0000
Received: from BN7PEPF00000092.namprd03.prod.outlook.com
 (2603:10b6:408:139:cafe::ae) by BN9PR03CA0472.outlook.office365.com
 (2603:10b6:408:139::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.10 via Frontend Transport; Fri,
 27 Nov 2026 22:50:06 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN7PEPF00000092.mail.protection.outlook.com (10.167.245.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.688.5 via Frontend Transport; Fri, 27 Nov 2026 22:50:06 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 27 Nov
 2026 14:49:59 -0800
Received: from xinmengs-dev-vm-linux.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Fri, 27 Nov 2026 14:49:57 -0800
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
	<peter@colberg.org>, <xinmengs@nvidia.com>, "Liam R. Howlett"
	<liam@infradead.org>, <linux-mm@kvack.org>, Lorenzo Stoakes <ljs@kernel.org>
Subject: [PATCH v4 5/5] vfio/nova-vgpu: add the Rust VFIO variant driver
Date: Fri, 27 Nov 2026 14:49:17 -0800
Message-ID: <20261127224928.1511382-6-xinmengs@nvidia.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261127224928.1511382-1-xinmengs@nvidia.com>
References: <20261127224928.1511382-1-xinmengs@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN7PEPF00000092:EE_|SA3PR12MB7902:EE_
X-MS-Office365-Filtering-Correlation-Id: dffa396a-d387-46f9-7599-08df4cd8c818
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|36860700016|376014|7416014|1800799024|261102130727099003|261028144727099003|261102123227099003|261022105027099003|261022113327099003|261022075727099003|261021135927099003|261022115727099003|261021121427099003|261021130227099003|261026140227099003|261026130827099003|261021123027099003|261026121527099003|11063799006|56012099006|10067099003|22082099003|18002099003|6133799003|261009223027099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	kWkkSU3W0tVQVfF2v5tlRyOc2Ay7PyHj16GARGEx+xC0z/fUVAgDgsi0WRJT8xy4Sk8dpx125i0Hls2yBwDJXiS5SV8hTVp+oLNydlMa107rjLVloQDH1Vg4jyOGUprnspelAvCDh4f1kQ3yNBNsVeoyWArtvUs6vB9PIkAq81dX/3kqoQE8cf9ThPt49iQ/lpzCmndxwlXjtM+5yq5q8/SpABIUU8Gzo9IoWJRAtlU2tIaiDbyIO5K9Ksy5eovnEp6+h2pXFSGVsHYC9VriFfIS2ZWjhX1CRl/nWfPG1+NRc0M4PcfcifE19EEZ6w2eOFsWDxylGmRyZ7n4fpzagKrms5WS/MOuV/ZUk1XybmaVrWaVyrfL+u6zyxAO17m/RY/TxL0IzexKzb0GDLADHD6sdzo6Aqi+RRhdIX7r82dVGiJpO+dtAM+hkIZZeYYu5p87o+V/EpcBdHiyix+Yak1xN6/2lb3w5aRc4mTqrq8Zong9VjQgApQMSziBqdeBXOc6JPBx88aCIr/m++lxhji9b8D8+LOoFx8Pnh2MadEt8PGyNjxG1AXiUpzshW6skq8i607YUarbIEB/DzQOW8J7nMQheMI6gJCAMaBQt06ll91hq5+2g4pGJeDLqQMCQJ4gvVCbQZARJzmP+YVS6BucO3+dwWgB9M8VWHUufDn3+EvrXi6TtijDd73wJZZ8owkwTr4qpIFNlKn87idjGA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(36860700016)(376014)(7416014)(1800799024)(261102130727099003)(261028144727099003)(261102123227099003)(261022105027099003)(261022113327099003)(261022075727099003)(261021135927099003)(261022115727099003)(261021121427099003)(261021130227099003)(261026140227099003)(261026130827099003)(261021123027099003)(261026121527099003)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003)(6133799003)(261009223027099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	r1dZGaEFjb4Av0X8YDRmsEL9aqe0f23lp1CqyQiW68G0DDXezlpRwvde2+O1zhj8FtTfmMTnF0vTXAM+dUo+hE+DcGEpbAfm5M1yJ6j6g5LQnO9+ZzaJxuunWLVj1SJ6YK6qenVPLBHmSri5EkvwK4d8U77ce1rraY5BZdMmPBwkWPFJ5/uBSmXuRHgl6b1sepnDw6BnLYj1KXrWuXxJYi5/O97aBQpsuJKGdAEza7SEm6qqAGgX2/MW/5IoVjA7XZQwHpyFlR2tSVwNQ9n12hHs/9a3BU65NsqBPt+R9YfzT9gKJqUNY2gC5ALBvW2icyYiGttEYCaZz5w9I8n0fmqxla9q3ipTdFgf/PiOpuxjhyU0hOYy6wbO4CnfBBfh9zpZJ5RKuK6B1tinrolP0N6TqIhssP7BcUAIJMUCd5cWvIbbPVHj75ir5KY+AZvE
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 22:50:06.2241
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dffa396a-d387-46f9-7599-08df4cd8c818
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN7PEPF00000092.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7902

From: Danilo Krummrich <dakr@kernel.org>

NVIDIA vGPU VFs need nova-core to manage their instances when assigned
to userspace through VFIO.

Add a Rust VFIO PCI variant driver that uses the typed SR-IOV PF APIs
to create an instance on first open and close it on last close. Expose
the assigned device and subsystem IDs, enforce the assigned BAR1
aperture, and reset the active vGPU instance on PCI reset.

Match the supported NVIDIA devices through VFIO override-only entries.
Devices without an available Nova vGPU interface use ordinary PCI
passthrough.

Register the VFIO device from probe and keep the Registration in the
PCI driver data, so that unbind unregisters it. Extend the GPU build
rules to make nova-core crate metadata available to the VFIO driver and
export the Rust symbols it references.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
Signed-off-by: Simon Song <xinmengs@nvidia.com>
---
 drivers/gpu/Makefile                    |  15 +-
 drivers/vfio/pci/Kconfig                |   2 +
 drivers/vfio/pci/Makefile               |   2 +
 drivers/vfio/pci/nova-vgpu/Kconfig      |  20 ++
 drivers/vfio/pci/nova-vgpu/Makefile     |   3 +
 drivers/vfio/pci/nova-vgpu/nova_vgpu.rs | 418 ++++++++++++++++++++++++
 6 files changed, 457 insertions(+), 3 deletions(-)
 create mode 100644 drivers/vfio/pci/nova-vgpu/Kconfig
 create mode 100644 drivers/vfio/pci/nova-vgpu/Makefile
 create mode 100644 drivers/vfio/pci/nova-vgpu/nova_vgpu.rs

diff --git a/drivers/gpu/Makefile b/drivers/gpu/Makefile
index e372fc02139fe..5fd610a172ad1 100644
--- a/drivers/gpu/Makefile
+++ b/drivers/gpu/Makefile
@@ -19,8 +19,9 @@ nova-core-y := nova-core/nova_core.o nova-core/nova_core_exports.o
 obj-$(CONFIG_DRM_NOVA) += nova-drm.o
 nova-drm-y := drm/nova/nova.o
 
-# Export Rust symbols from nova-core only if nova-drm actually references them.
-nova-core-export-deps := $(if $(CONFIG_DRM_NOVA),$(obj)/drm/nova/nova.o)
+# Export Rust symbols from nova-core only if dependent modules reference them.
+nova-core-export-deps := $(if $(CONFIG_DRM_NOVA),$(obj)/drm/nova/nova.o) \
+	$(if $(CONFIG_NOVA_VGPU_VFIO_PCI),$(obj)/../vfio/pci/nova-vgpu/nova_vgpu.o)
 
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
+obj-$(CONFIG_NOVA_VGPU_VFIO_PCI) += nova-vgpu-vfio-pci.o
+nova-vgpu-vfio-pci-y := ../vfio/pci/nova-vgpu/nova_vgpu.o
+
+$(obj)/../vfio/pci/nova-vgpu/nova_vgpu.o: $(obj)/nova-core/nova_core.o
+RUSTFLAGS_../vfio/pci/nova-vgpu/nova_vgpu.o := -L $(objtree)/$(obj)/nova-core --extern nova_core
diff --git a/drivers/vfio/pci/Kconfig b/drivers/vfio/pci/Kconfig
index 296bf01e185ec..dd9b755262a4c 100644
--- a/drivers/vfio/pci/Kconfig
+++ b/drivers/vfio/pci/Kconfig
@@ -74,4 +74,6 @@ source "drivers/vfio/pci/qat/Kconfig"
 
 source "drivers/vfio/pci/xe/Kconfig"
 
+source "drivers/vfio/pci/nova-vgpu/Kconfig"
+
 endmenu
diff --git a/drivers/vfio/pci/Makefile b/drivers/vfio/pci/Makefile
index 6138f1bf241df..1d9fb11eb3c21 100644
--- a/drivers/vfio/pci/Makefile
+++ b/drivers/vfio/pci/Makefile
@@ -24,3 +24,5 @@ obj-$(CONFIG_NVGRACE_GPU_VFIO_PCI) += nvgrace-gpu/
 obj-$(CONFIG_QAT_VFIO_PCI) += qat/
 
 obj-$(CONFIG_XE_VFIO_PCI) += xe/
+
+# nova-vgpu is built from drivers/gpu/Makefile for nova-core crate linkage.
diff --git a/drivers/vfio/pci/nova-vgpu/Kconfig b/drivers/vfio/pci/nova-vgpu/Kconfig
new file mode 100644
index 0000000000000..29fad96340ce6
--- /dev/null
+++ b/drivers/vfio/pci/nova-vgpu/Kconfig
@@ -0,0 +1,20 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config NOVA_VGPU_VFIO_PCI
+	tristate "VFIO support for the NVIDIA vGPU"
+	depends on NOVA_CORE && PCI_IOV && RUST
+	depends on VFIO_PCI_CORE=y
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
diff --git a/drivers/vfio/pci/nova-vgpu/Makefile b/drivers/vfio/pci/nova-vgpu/Makefile
new file mode 100644
index 0000000000000..0875c782602e4
--- /dev/null
+++ b/drivers/vfio/pci/nova-vgpu/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+# nova-vgpu is built from drivers/gpu/Makefile for nova-core crate linkage.
+# nova_vgpu.o (rust-analyzer marker - DO NOT REMOVE).
diff --git a/drivers/vfio/pci/nova-vgpu/nova_vgpu.rs b/drivers/vfio/pci/nova-vgpu/nova_vgpu.rs
new file mode 100644
index 0000000000000..3a7a5a26b49ec
--- /dev/null
+++ b/drivers/vfio/pci/nova-vgpu/nova_vgpu.rs
@@ -0,0 +1,418 @@
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
+struct NovaVgpuOps;
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
+    fb_bar_reg: u64,
+}
+
+#[pin_data]
+struct NovaVgpuRegData<'a> {
+    pdev: &'a pci::Device<Bound>,
+    vgpu: Option<VgpuRegistration<'a>>,
+    fb_bar: Option<u32>,
+    #[pin]
+    state: Mutex<InstanceState>,
+    #[pin]
+    reset_done: CondVar,
+}
+
+impl NovaVgpuRegData<'_> {
+    fn lock_instance(&self) -> MutexGuard<'_, InstanceState> {
+        let mut state = self.state.lock();
+        while state.resetting {
+            self.reset_done.wait(&mut state);
+        }
+        state
+    }
+}
+
+struct NovaVgpuOpenData<'a, 'reg> {
+    registration: &'a NovaVgpuRegData<'reg>,
+    instance: Option<VgpuInstance<'reg>>,
+}
+
+impl<'a, 'reg> NovaVgpuOpenData<'a, 'reg> {
+    fn new(
+        dev: &vfio::pci::Device<NovaVgpuOps, Open>,
+        rd: &'a NovaVgpuRegData<'reg>,
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
+                state.fb_bar_reg = 0;
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
+        let (Some(instance), Some(fb_bar)) = (&self.instance, self.registration.fb_bar) else {
+            return Ok(None);
+        };
+        let physical = self.registration.pdev.resource_len(fb_bar)?;
+        let size = instance
+            .type_info()
+            .bar1_length
+            .checked_mul(1 << 20)
+            .ok_or(EOVERFLOW)?;
+        if size != 0 && !size.is_power_of_two() {
+            return Err(EINVAL);
+        }
+        Ok(Some(size.min(physical)))
+    }
+
+    fn limit_bar1(&self, buf: &mut vfio::UserBuf, position: &Position<'_>) -> Result {
+        if buf.is_empty() || Some(position.region_index()) != self.registration.fb_bar {
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
+impl Drop for NovaVgpuOpenData<'_, '_> {
+    fn drop(&mut self) {
+        let mut state = self.registration.lock_instance();
+        state.active = false;
+        drop(self.instance.take());
+    }
+}
+
+impl vfio::Operations for NovaVgpuOps {
+    type RegistrationData<'reg> = NovaVgpuRegData<'reg>;
+    type OpenData<'open, 'reg: 'open> = NovaVgpuOpenData<'open, 'reg>;
+}
+
+#[vtable]
+impl vfio::pci::Operations for NovaVgpuOps {
+    const NAME: &'static CStr = c"nova-vgpu-vfio-pci";
+
+    fn open_device<'a, 'reg: 'a>(
+        dev: &'a vfio::pci::Device<Self, Open>,
+        rd: &'a NovaVgpuRegData<'reg>,
+    ) -> impl PinInit<Self::OpenData<'a, 'reg>, Error> + 'a {
+        NovaVgpuOpenData::new(dev, rd)
+    }
+
+    fn ioctl<'reg>(
+        dev: &vfio::pci::Device<Self, Ioctl>,
+        rd: &NovaVgpuRegData<'reg>,
+        _open_data: Pin<&Self::OpenData<'_, 'reg>>,
+        cmd: u32,
+        arg: usize,
+    ) -> Result<isize> {
+        let result = dev.core_ioctl(cmd, arg)?;
+        if cmd == vfio::DEVICE_RESET {
+            if let Some(error) = rd.state.lock().reset_error {
+                return Err(error);
+            }
+        }
+        Ok(result)
+    }
+
+    fn read<'reg>(
+        dev: &vfio::pci::Device<Self, Read>,
+        rd: &NovaVgpuRegData<'reg>,
+        open_data: Pin<&Self::OpenData<'_, 'reg>>,
+        buf: &mut vfio::UserBuf,
+        position: &mut Position<'_>,
+    ) -> Result<isize> {
+        if let Some(instance) = &open_data.instance {
+            if position.region_index() == vfio::pci::CONFIG_REGION_INDEX {
+                let offset = position.region_offset();
+                return position.with_temporary(|next| {
+                    let count = dev.core_read(buf, next)?;
+                    // A VF has no device ID of its own, so the core keeps it in vconfig, where
+                    // it is set once at open. The core reads the subsystem ID from the hardware,
+                    // as a firmware update can change it there, so replace it on every read.
+                    buf.write_overlapping(
+                        offset,
+                        count.try_into()?,
+                        u64::from(bindings::PCI_SUBSYSTEM_ID),
+                        &(instance.type_info().pci_subsys_id as u16).to_le_bytes(),
+                    )?;
+                    if let (Some(size), Some(fb_bar)) = (open_data.bar1_size()?, rd.fb_bar) {
+                        let reg = rd.state.lock().fb_bar_reg & !size.wrapping_sub(1);
+                        // Byte 0 holds only the flag bits, which the core has filled in.
+                        buf.write_overlapping(
+                            offset,
+                            count.try_into()?,
+                            u64::from(bindings::PCI_BASE_ADDRESS_0) + 4 * u64::from(fb_bar) + 1,
+                            &reg.to_le_bytes()[1..],
+                        )?;
+                    }
+                    Ok(count)
+                });
+            }
+        }
+        open_data.limit_bar1(buf, position)?;
+        dev.core_read(buf, position)
+    }
+
+    fn write<'reg>(
+        dev: &vfio::pci::Device<Self, Write>,
+        rd: &NovaVgpuRegData<'reg>,
+        open_data: Pin<&Self::OpenData<'_, 'reg>>,
+        buf: &mut vfio::UserBuf,
+        position: &mut Position<'_>,
+    ) -> Result<isize> {
+        if let Some(fb_bar) = rd.fb_bar {
+            if position.region_index() == vfio::pci::CONFIG_REGION_INDEX {
+                let mut written = [0; 8];
+                let range = buf.read_overlapping(
+                    position.region_offset(),
+                    u64::from(bindings::PCI_BASE_ADDRESS_0) + 4 * u64::from(fb_bar),
+                    &mut written,
+                )?;
+                if !range.is_empty() {
+                    let mut state = rd.state.lock();
+                    let mut reg = state.fb_bar_reg.to_le_bytes();
+                    reg[range.clone()].copy_from_slice(&written[range]);
+                    state.fb_bar_reg = u64::from_le_bytes(reg);
+                }
+            }
+        }
+        open_data.limit_bar1(buf, position)?;
+        dev.core_write(buf, position)
+    }
+
+    fn mmap<'reg>(
+        dev: &vfio::pci::Device<Self, Mmap>,
+        rd: &NovaVgpuRegData<'reg>,
+        open_data: Pin<&Self::OpenData<'_, 'reg>>,
+        mapping: &mut Mapping<'_>,
+    ) -> Result {
+        if Some(mapping.region_index()) == rd.fb_bar {
+            if let Some(size) = open_data.bar1_size()? {
+                if mapping.region_end()? > size {
+                    return Err(EINVAL);
+                }
+            }
+        }
+        dev.core_mmap(mapping)
+    }
+
+    fn get_region_info<'reg>(
+        dev: &vfio::pci::Device<Self, GetRegionInfo>,
+        rd: &NovaVgpuRegData<'reg>,
+        open_data: Pin<&Self::OpenData<'_, 'reg>>,
+        info: &mut bindings::vfio_region_info,
+        caps: &mut vfio::InfoCap<'_>,
+    ) -> Result {
+        dev.core_get_region_info(info, caps)?;
+        if Some(info.index) == rd.fb_bar && info.size != 0 {
+            if let Some(size) = open_data.bar1_size()? {
+                info.size = info.size.min(size);
+            }
+        }
+        Ok(())
+    }
+
+    fn dmabuf_len<'reg>(
+        rd: &NovaVgpuRegData<'reg>,
+        open_data: Pin<&Self::OpenData<'_, 'reg>>,
+        region_index: u32,
+    ) -> Result<Option<u64>> {
+        if Some(region_index) == rd.fb_bar {
+            return open_data.bar1_size();
+        }
+        Ok(None)
+    }
+
+    fn reset_prepare(rd: &NovaVgpuRegData<'_>) {
+        // PCI holds the device lock, and VFIO may hold its memory lock. Open and
+        // close release this mutex before entering the VFIO core.
+        let mut state = rd.state.lock();
+        state.resetting = true;
+        state.reset_error = None;
+    }
+
+    fn reset_done(rd: &NovaVgpuRegData<'_>) -> Result {
+        let mut state = rd.state.lock();
+        // A VF FLR leaves the vGPU plugin's software state intact.
+        if state.active {
+            if let Some(vgpu) = &rd.vgpu {
+                state.reset_error = vgpu.api.reset(vgpu.gfid).err();
+            }
+        }
+        let error = state.reset_error;
+        state.resetting = false;
+        rd.reset_done.notify_all();
+        error.map_or(Ok(()), Err)
+    }
+}
+
+struct NovaVgpuDriver;
+
+kernel::pci_device_table!(
+    PCI_TABLE,
+    <NovaVgpuDriver as pci::Driver>::IdInfo,
+    [
+        (
+            pci::DeviceId::from_id_vfio_override(pci::Vendor::NVIDIA, 0x2bb3),
+            (),
+        ),
+        (
+            pci::DeviceId::from_id_vfio_override(pci::Vendor::NVIDIA, 0x2bb5),
+            (),
+        ),
+    ]
+);
+
+#[pin_data]
+struct NovaVgpuData<'bound> {
+    reg: vfio::pci::Registration<'bound, NovaVgpuOps>,
+}
+
+#[vtable]
+impl pci::Driver for NovaVgpuDriver {
+    type IdInfo = ();
+    type Data<'bound> = NovaVgpuData<'bound>;
+    const ID_TABLE: pci::IdTable<Self::IdInfo> = &PCI_TABLE;
+    // SAFETY: VFIO hands the DMA ownership of the device to userspace. This driver never uses
+    // the kernel DMA API for its devices, directly or through helpers.
+    const DRIVER_MANAGED_DMA: Option<pci::DriverManagedDma<Self>> =
+        Some(unsafe { pci::DriverManagedDma::new() });
+
+    fn probe<'bound>(
+        pdev: &'bound pci::Device<Core<'_>>,
+        _info: Option<&'bound Self::IdInfo>,
+    ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound {
+        try_pin_init!(NovaVgpuData {
+            reg: {
+                let vgpu = match NovaCoreVfApi::handle(pdev) {
+                    Ok(api) => Some(VgpuRegistration {
+                        api,
+                        gfid: u32::from(pdev.vf_id()?) + 1,
+                    }),
+                    Err(_) => None,
+                };
+                let dev = vfio::pci::Device::<NovaVgpuOps>::new(pdev)?;
+                let fb_bar = if vgpu.is_none() {
+                    None
+                } else if pdev.resource_flags(0)?.contains(Flags::IORESOURCE_MEM_64) {
+                    Some(2)
+                } else {
+                    Some(1)
+                };
+                // SAFETY: The registration is stored in `NovaVgpuData`, this driver's bus
+                // device private data, which is never leaked.
+                unsafe {
+                    vfio::pci::Registration::new::<Self>(
+                        pdev,
+                        &dev,
+                        try_pin_init!(NovaVgpuRegData {
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
+    fn reset_prepare<'bound>(_pdev: &pci::Device<Core<'_>>, data: Pin<&Self::Data<'bound>>) {
+        data.reg.reset_prepare();
+    }
+
+    fn reset_done<'bound>(pdev: &pci::Device<Core<'_>>, data: Pin<&Self::Data<'bound>>) {
+        if let Err(error) = data.reg.reset_done() {
+            dev_err!(pdev, "VFIO device reset failed: {:?}\n", error);
+        }
+    }
+
+    fn error_detected<'bound>(
+        _pdev: &pci::Device<Core<'_>>,
+        data: Pin<&Self::Data<'bound>>,
+        _state: pci::ChannelState,
+    ) -> pci::ErsResult {
+        data.reg.error_detected()
+    }
+}
+
+kernel::module_pci_driver! {
+    type: NovaVgpuDriver,
+    name: "nova-vgpu-vfio-pci",
+    authors: [
+        "Danilo Krummrich <dakr@kernel.org>",
+        "Zhi Wang <zhiw@nvidia.com>",
+        "Simon Song <xinmengs@nvidia.com>",
+    ],
+    description: "NVIDIA vGPU VFIO variant driver",
+    license: "GPL v2",
+}
-- 
2.43.7


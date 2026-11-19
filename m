Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.70
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795125124;
	b=OO7c0nGj4k9XNVlPq9k97IgNjXFcMei8/1QFfrF8EHy7KzNxSpJYmssSrC2uTuJrpDnb
	 7piDjCvqq/y6OaYXUvwJEmjwuLJPd1s29fd+9uTUu3JLd0mL5HDHhGcNeO8Q7CVmzRLA3
	 TO/O2jVcS5GdCR0WJQVAjNBIUBHBeFQN0pYJy+IiBYM0vINzOOpe7P96js8GWLoLyw+qT
	 w7QBVgK2PVg6FCC8iNnzajIil+ze1iEoibDKmvRaw11J7sK7MFzvWKhr6Hu484iUhoB3d
	 ofdH4FOvMfTYZ9iN7pfZrXsKC17Qw/k2kKXJJPnah4TouQifmmyXsfF85ZyueZAbR1Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795125124;
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
	bh=UK5QGMQ+0+d3nBoWBjguM2+KwtLJ0JRhXJ8fxArkGp0=;
	b=NJIEne/NAMMJTvM5vuQfycgd9LkIslGHv242rgf51nEy4OQu/+Hh9KkRjsZekrq0rRmN
	 1QNOz+FWUVYOQ9gljSRvdFtUKV0VuFLH8emzorPUxVcbRMJKFGDC2jziDASqmxenKgoTS
	 7OgRx6upuJ4XoJLtzhqExovKNh/Lyp7le51Xq0E4qW9Ab+ovYEVrOpJTdU8OMA4rP08e0
	 zmVi5cy75DyiUvLJ7mtWBlQCaLyAWZ+jDjnmEUVPubHOBvIMrmhvjAvQzWYq9y8J5WtDx
	 IRI1Itb09ve4ISb6uz7CRfMkD5wVJawZ3kW0/JgRQ8LvPO/YdMBjPbXKq+krKWdF3zg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=LovJz0Sc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.70
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011070.outbound.protection.outlook.com [52.101.57.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0A060A260F;
	Thu, 19 Nov 2026 21:52:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B0A060A260F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=LovJz0Sc
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pUQ5n6UBE1fRLy46Fucs/KjYNsdnevlRAVYRzwmAZKxROtIEm9D9B0sWeB5SJSf3Jj5vgEjBa5udX241fsOhoTbG8qbsf25TS+C8KOJZBI4MHaIp8X1PeebOb6zn0mgmA9psTce+AXM0GPFlrsqx5K/NmiZ7ncTEpagN/eCP4oSjIkaJhvlFEUaugVPm4Rybx+rifTJpWhfzRNHpdlFVzqtRh/SgvbIkzfd/n0cS50HOWvnUB2PZg0tqVa5KJ7Uhi0uiHk6ftQ2kjb4msN5uwNB9Jb9t8lUGPzlN1X9b92zPcWGCThpCGJ9BiYFsLhT4hOkfJ8RuQGYKQuuPL3xYgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UK5QGMQ+0+d3nBoWBjguM2+KwtLJ0JRhXJ8fxArkGp0=;
 b=ppGMKfqCymPppKm200AyfoYkB3QJvF3ChCyZvY7OvHN3w7hKBAXnd8yOjacTnaDKm+IXUDGsWtZ5RbtNslLI7MGRDC7v1pEE+oC1vYxXS3HdGArmXPHt4xlNed3qzS+h41KWos7rkmbC/lVQnsZvi5TUQMf7iady+o16RJd0zb0j2HPmo1OhUR2C5J/qiqEpyzPrIJ9Aj1ZPybi7Q5Ug4daYw1IJ+KaHp+oGxXfSwhCutyc8+z2QDvoprBe/SqqWEO9Si7HVyaG+PogjRS9FjUFEN7dO+M6hY97jtri4iWv2jq2wc8DogB5Xg+65oCj6Q6lbGzLBD7cpi+jTMzXTIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UK5QGMQ+0+d3nBoWBjguM2+KwtLJ0JRhXJ8fxArkGp0=;
 b=LovJz0ScBmHDNX7aaT6i8QevSvq0nIXq07CfU1XPlPOddISKfKbL5KhkDwIyzVY+DmI9Na2qy1Jickr59O0GWEdxZPNNN416Qx+d3seHYRPC0oUmD/mg9QC3xh8F4HQJfoCBTKwK7j+hWLyJ/3A3o9TLi0KqUaPZ0qcR8HTGucSoYatDKwwGXCB43/ZxJkJ5vXhSSbR3atGMQwalhP9biBrypM6rBXlyo9uUzo1XmpdmO64gSt6pYv2mX2WOKlkUw7mCCF+FClZs7Oc3OdWrJXRHu5lCH65pyfAzrxWqXh9uZW+BSB+Bx/LX0j4HiHOVWapioTvjql1YdnHhoSNQTg==
Received: from MW4PR04CA0190.namprd04.prod.outlook.com (2603:10b6:303:86::15)
 by SN7PR12MB8789.namprd12.prod.outlook.com (2603:10b6:806:34b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Thu, 19 Nov
 2026 21:51:54 +0000
Received: from MWH0EPF000C6185.namprd02.prod.outlook.com
 (2603:10b6:303:86:cafe::ae) by MW4PR04CA0190.outlook.office365.com
 (2603:10b6:303:86::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Thu,
 19 Nov 2026 21:51:52 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000C6185.mail.protection.outlook.com (10.167.249.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 21:51:52 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 13:51:24 -0800
Received: from xinmengs-dev-vm-linux.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Thu, 19 Nov 2026 13:51:21 -0800
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
Subject: [PATCH v3 9/9] vfio/nova-vgpu: add the Rust VFIO variant driver
Date: Thu, 19 Nov 2026 13:50:44 -0800
Message-ID: <20261119215046.2892839-10-xinmengs@nvidia.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261119215046.2892839-1-xinmengs@nvidia.com>
References: <20261119215046.2892839-1-xinmengs@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6185:EE_|SN7PR12MB8789:EE_
X-MS-Office365-Filtering-Correlation-Id: c4e45212-57cc-490b-1299-08df4687521f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|36860700016|376014|7416014|1800799024|6133799003|18002099003|22082099003|3023799007|11063799006|261026140227099003|261022113327099003|261022115727099003|261022075727099003|56012099006|261022105027099003|261026130827099003|261026121527099003|261028144727099003|261021123027099003|261009223027099003|261021130227099003|261102123227099003|261021135927099003|261021121427099003|10067099003|261102130727099003;
X-Microsoft-Antispam-Message-Info:
	efAeJWrrCLC1eUfxhRh6NTejl1av1pHEii9EsKb3g0B//BqAxAH9btISDCB+UEHg9HslAY5Ex9cpfZ247hvYqr7GWnCR5d48X2TfTEKqy1puxyvaHB5frdf49173tsp2kK5qFSxsC45UN9ADR0qjh+y8c4GNBn7sJdI1TYz0wlagY4IEzgB9CQ+3ryqhyBFxUMohYGfzKe7AYQ8PDh5OTbnWBNHgtysDMB2Q1GvbP9IczRlZBNwuXh4LEYlAmfzMdm2EBlDpeiPg0hH1ovzjDWBDtlFv2gMcjZzcOu+kWI9REOZI0N8zNA8E4B4v4WE6lXepzDMe6frp0lXhjUn1OnqMbF08QbMbn/z3oWybAWQRAc6PYpQBhByofcDhEmYakDQhV0klqP2as17pb81vaAIohNd0a6h6pyHhG3+UJZGYZh0X5XubHmMfdOteBOhWtXprwHhj8Cl6vtrjeHXbVYbw5qtaarRUft1yFCRLZDLARZ+Dd+ec6EgH1PBV/SpqbaVw6XBxJfrbcW6KmlzFPsIWNaqorF0esIU7xin/QHMt3PISkBFkycxvyGFG+4vnWoTEPmzA8jEUHrTfrEKcNHQssZPnPlgMPgEyxGMKvsrhpk3H6jo+jMG8WwStVjgibZJJ14U1mdNWaf3HnSPuK0We/9pm+GGk47ISV/bBCuB2HgND//9mHJjWbgKdcxNEj71ecMC9RfwGRm9IJ3iccg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(36860700016)(376014)(7416014)(1800799024)(6133799003)(18002099003)(22082099003)(3023799007)(11063799006)(261026140227099003)(261022113327099003)(261022115727099003)(261022075727099003)(56012099006)(261022105027099003)(261026130827099003)(261026121527099003)(261028144727099003)(261021123027099003)(261009223027099003)(261021130227099003)(261102123227099003)(261021135927099003)(261021121427099003)(10067099003)(261102130727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	GznSiGmwMoF/Ejg80YAfWQQBZo5YOlKTR6huGPEGOYvwwyboo3VOVI/DVUNjWsQQikAzgWRsMgfIXXJjG3GNE9cDjKspY2JtqzxGvpu1WFcRlDJ1b8Dy/P0U329tnI45ytrD1R5YRgPF1PQj9suboBBoaq/74eYq+k5uugHuzja4FTWJQB80PZ4xpiMdiKr3ygfcv5Dbx+6MdGl9gn6+//7KMZkJluG4k0isC3vFDzRMBEyi6kTFoN3V5PLVxt+x9Hyb+DAk2vWpzU1D3PxPsCCCU96xhbgZWZ1w1rucwD8bD6Rzk0qDmQISmJYioNu7Kyxi+K4SNJ98JPJdGnTNSD8YHdIg5CnZXbU82HWQkpHHiz9bC+WzQgHQTSeByLurYXqJRr8auGF/eQFdp1aWTjN+HoJY6NSDUwZCe/anwGvjWjnyUv+FnfTNSpa21pGV
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 21:51:52.1789
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4e45212-57cc-490b-1299-08df4687521f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C6185.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8789

From: Danilo Krummrich <dakr@kernel.org>

NVIDIA vGPU VFs need nova-core to manage their instances when assigned
to userspace through VFIO.

Add a Rust VFIO PCI variant driver that uses the typed SR-IOV PF APIs
to create an instance on first open and close it on last close. Expose
the assigned device and subsystem IDs, enforce the assigned BAR1
aperture, and reset the active vGPU instance on PCI reset.

Match NVIDIA devices through a VFIO override-only entry. Devices
without an available Nova vGPU interface use ordinary PCI passthrough.

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
 drivers/vfio/pci/nova-vgpu/nova_vgpu.rs | 375 ++++++++++++++++++++++++
 6 files changed, 414 insertions(+), 3 deletions(-)
 create mode 100644 drivers/vfio/pci/nova-vgpu/Kconfig
 create mode 100644 drivers/vfio/pci/nova-vgpu/Makefile
 create mode 100644 drivers/vfio/pci/nova-vgpu/nova_vgpu.rs

diff --git a/drivers/gpu/Makefile b/drivers/gpu/Makefile
index e372fc02139f..5fd610a172ad 100644
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
index 296bf01e185e..dd9b755262a4 100644
--- a/drivers/vfio/pci/Kconfig
+++ b/drivers/vfio/pci/Kconfig
@@ -74,4 +74,6 @@ source "drivers/vfio/pci/qat/Kconfig"
 
 source "drivers/vfio/pci/xe/Kconfig"
 
+source "drivers/vfio/pci/nova-vgpu/Kconfig"
+
 endmenu
diff --git a/drivers/vfio/pci/Makefile b/drivers/vfio/pci/Makefile
index 6138f1bf241d..1d9fb11eb3c2 100644
--- a/drivers/vfio/pci/Makefile
+++ b/drivers/vfio/pci/Makefile
@@ -24,3 +24,5 @@ obj-$(CONFIG_NVGRACE_GPU_VFIO_PCI) += nvgrace-gpu/
 obj-$(CONFIG_QAT_VFIO_PCI) += qat/
 
 obj-$(CONFIG_XE_VFIO_PCI) += xe/
+
+# nova-vgpu is built from drivers/gpu/Makefile for nova-core crate linkage.
diff --git a/drivers/vfio/pci/nova-vgpu/Kconfig b/drivers/vfio/pci/nova-vgpu/Kconfig
new file mode 100644
index 000000000000..228f6ebc108c
--- /dev/null
+++ b/drivers/vfio/pci/nova-vgpu/Kconfig
@@ -0,0 +1,20 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config NOVA_VGPU_VFIO_PCI
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
diff --git a/drivers/vfio/pci/nova-vgpu/Makefile b/drivers/vfio/pci/nova-vgpu/Makefile
new file mode 100644
index 000000000000..0875c782602e
--- /dev/null
+++ b/drivers/vfio/pci/nova-vgpu/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+# nova-vgpu is built from drivers/gpu/Makefile for nova-core crate linkage.
+# nova_vgpu.o (rust-analyzer marker - DO NOT REMOVE).
diff --git a/drivers/vfio/pci/nova-vgpu/nova_vgpu.rs b/drivers/vfio/pci/nova-vgpu/nova_vgpu.rs
new file mode 100644
index 000000000000..20553b7b4e2e
--- /dev/null
+++ b/drivers/vfio/pci/nova-vgpu/nova_vgpu.rs
@@ -0,0 +1,375 @@
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
+}
+
+#[pin_data]
+struct NovaVgpuRegData<'a> {
+    pdev: &'a pci::Device<Bound>,
+    vgpu: Option<VgpuRegistration<'a>>,
+    fb_bar: u32,
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
+struct NovaVgpuOpenData<'a, 'data> {
+    registration: &'a NovaVgpuRegData<'data>,
+    instance: Option<VgpuInstance<'data>>,
+}
+
+impl<'a, 'data> NovaVgpuOpenData<'a, 'data> {
+    fn new(
+        dev: &vfio::pci::Device<NovaVgpuOps, Open>,
+        rd: &'a NovaVgpuRegData<'data>,
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
+impl Drop for NovaVgpuOpenData<'_, '_> {
+    fn drop(&mut self) {
+        let mut state = self.registration.lock_instance();
+        state.active = false;
+        drop(self.instance.take());
+    }
+}
+
+impl vfio::pci::Operations for NovaVgpuOps {
+    const NAME: &'static CStr = c"nova-vgpu-vfio-pci";
+    type RegistrationData<'a> = NovaVgpuRegData<'a>;
+    type OpenData<'a, 'data: 'a> = NovaVgpuOpenData<'a, 'data>;
+
+    fn open_device<'a, 'data: 'a>(
+        dev: &'a vfio::pci::Device<Self, Open>,
+        rd: &'a NovaVgpuRegData<'data>,
+    ) -> impl PinInit<Self::OpenData<'a, 'data>, Error> + 'a {
+        NovaVgpuOpenData::new(dev, rd)
+    }
+
+    fn ioctl<'data>(
+        dev: &vfio::pci::Device<Self, Ioctl>,
+        rd: &NovaVgpuRegData<'data>,
+        _open_data: Pin<&Self::OpenData<'_, 'data>>,
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
+    fn read<'data>(
+        dev: &vfio::pci::Device<Self, Read>,
+        _rd: &NovaVgpuRegData<'data>,
+        open_data: Pin<&Self::OpenData<'_, 'data>>,
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
+    fn write<'data>(
+        dev: &vfio::pci::Device<Self, Write>,
+        _rd: &NovaVgpuRegData<'data>,
+        open_data: Pin<&Self::OpenData<'_, 'data>>,
+        buf: &mut vfio::UserBuf,
+        position: &mut Position<'_>,
+    ) -> Result<isize> {
+        open_data.limit_bar1(buf, position)?;
+        dev.core_write(buf, position)
+    }
+
+    fn mmap<'data>(
+        dev: &vfio::pci::Device<Self, Mmap>,
+        rd: &NovaVgpuRegData<'data>,
+        open_data: Pin<&Self::OpenData<'_, 'data>>,
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
+    fn get_region_info<'data>(
+        dev: &vfio::pci::Device<Self, GetRegionInfo>,
+        rd: &NovaVgpuRegData<'data>,
+        open_data: Pin<&Self::OpenData<'_, 'data>>,
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
+    fn reset_prepare(rd: &NovaVgpuRegData<'_>) {
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
+    fn reset_done(rd: &NovaVgpuRegData<'_>) -> Result {
+        let mut state = rd.state.lock();
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
+    [(
+        pci::DeviceId::from_id_vfio_override(pci::Vendor::NVIDIA, bindings::PCI_ANY_ID as u32),
+        (),
+    ),]
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
+                let dev = if vgpu.is_some() {
+                    vfio::pci::Device::<NovaVgpuOps>::new(pdev)?
+                } else {
+                    vfio::pci::Device::<NovaVgpuOps>::new_passthrough(pdev)?
+                };
+                let fb_bar = if pdev.resource_flags(0)?.contains(Flags::IORESOURCE_MEM_64) {
+                    2
+                } else {
+                    1
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
+            data.reg.error_detected();
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
+    authors: ["NVIDIA"],
+    description: "NVIDIA vGPU VFIO variant driver",
+    license: "GPL v2",
+}
-- 
2.43.7


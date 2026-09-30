Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010035.outbound.protection.outlook.com [52.101.85.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848934AB1C8;
	Wed, 30 Sep 2026 10:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790765920; cv=fail; b=B1SEwrtYBesF3g+ob+mSvYtC2vRpyVS0AmvbIwNkdMfvRoV+TGrYgewZ13jx7hdgBNWhvhkk4BlMEOn1rXXA3DbUEa5B3ZRs+fXw/RgqKmVDorqEC4ifoAuEYTcAvXHfaKcUzVFSpHvO4iHRGEe5abeXrbBa++HeCMoSX8FxZ08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790765920; c=relaxed/simple;
	bh=vJMrP1GymRIwAxGAZfX6I2w5FiV8FzzByXFV9Uu+eaE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EIa+ayYkHzkLgZ3pzHCa39Q3p3gfLcEKG/45/IL0lyH4NgKOhv9D7ZAuSwjH7Jn24e8YlnMgz7QKLB7gviztvFec08l4qiiHYjHf6Px7J/JtecstrwRYqv7zXCL9NnJXgYGugIQhHQx/aWNHsEozVHMpTJlIR7QabydyygJdOR4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BpMdo1Tz; arc=fail smtp.client-ip=52.101.85.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BpMdo1Tz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EPd0IohEr+H97R04lBzC9ooM7flJniVkbfgzfgNxcw02JGlNh1aqPQ6qDcy6EA/n0/mnLBzGmZ9iyUS9mUJQzJ+nDLu81cSg+KKqPm2TQcYPhwHqqc1eQWfw6vyqvMY0zi4X1H8mzTwjPlWn1iY7CSqrLLy5QAjJpv+pvD05FHnOaWYI4xF5BVsskuAkf/OexAa7OjrmGziWeLGBMXOtPTk7aEr6OqypDy5tdQtGBePrKR7o8mtfhCOu9jO7s0uc9OgEoIikQdHkqC12qrC/jjVCakjVjsNEv1DXXv+UL9wOfVF1/89SVz/9ZVXHt/4BmLxD+20TxgqakY8M6hFGbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FH4rkFzXotimjSWGZMuYEkLqMeKVLbJgTyZE577KJXo=;
 b=PgrMGGLWraPcP5PUyeGmaJlEacF3SgqQPdIkta++DWIw1xkpzmMd2kzRkUFNTZpCNw23C1neZpTds1ZkT+pK0oYmcvUIdMHaxXdUMcLaBtOMVfnUSY8CGYRbMqHyBuVJMqXyL7NBQ7S6qaMgsSPpmr4P18I8cF5cEgsW6AbRfDoiTuy1bs6s6Cy0yG5gkqBafaTTDBYqdu1Z4ywVB19pgfHErDLWAYoQp5dL3ELRZLOna4bk3qIQSnYCbQO+PpAQFoz/zj4Fmxa2hVdsR281dB1ajcjA8u+yHtEP2ECz27XKt5UIfMGcZuuZtE6sZnwhjQy9XHJ4DFcUgna/T6dkcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FH4rkFzXotimjSWGZMuYEkLqMeKVLbJgTyZE577KJXo=;
 b=BpMdo1Tz6BBGRyBSfM/HOoNymTfyj7kPFFk6UzG+TJISgr7jvWTcVou7uRYvqEwyY/86rgl01RZ+IRXFDCTtbACzFD0XUmNWhSZP9y1oDLCyBtZijrKmy2ys6IXZ6sN2w3RfHRQz/JtZzhqCQLfOGWIYxps38rNr3mw0sWf9HQNotip0xhakTbgkzf7GyQKxn5gB4iTQkb1+E6v9umFVDdwXk6wBhIXrRkC7UsPooQgVdyesrbji+YsCGjO0eO31WEHLo6JSH5dEdzP3FFFKv0CfPVhyRVze+OcW/xuq9DqBhR0cHv6hOat00LPZBGrd7dvW2HuNzUkgOrrZpearkQ==
Received: from BN9PR03CA0033.namprd03.prod.outlook.com (2603:10b6:408:fb::8)
 by DS4PR12MB999099.namprd12.prod.outlook.com (2603:10b6:8:2fd::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Wed, 30 Sep
 2026 10:58:22 +0000
Received: from LV8PEPF0000005B.namprd02.prod.outlook.com
 (2603:10b6:408:fb:cafe::45) by BN9PR03CA0033.outlook.office365.com
 (2603:10b6:408:fb::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.23 via Frontend Transport; Wed,
 30 Sep 2026 10:58:21 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 LV8PEPF0000005B.mail.protection.outlook.com (10.167.245.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Wed, 30 Sep 2026 10:58:21 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 03:58:02 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 03:58:02 -0700
Received: from inno-dell.home (10.127.8.11) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.49 via Frontend Transport; Wed, 30
 Sep 2026 03:57:51 -0700
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
Subject: [PATCH 0/7] Rust VFIO PCI support and NVIDIA vGPU driver
Date: Wed, 30 Sep 2026 13:57:42 +0300
Message-ID: <cover.1790764573.git.zhiw@nvidia.com>
X-Mailer: git-send-email 2.53.0
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
X-MS-TrafficTypeDiagnostic: LV8PEPF0000005B:EE_|DS4PR12MB999099:EE_
X-MS-Office365-Filtering-Correlation-Id: fd9cef92-e6f5-4cc6-229a-08df1ee1be42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|82310400026|1800799024|376014|36860700016|3023799007|13003099007|10067099003|11063799006|56012099006|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	DxeeAshvcExNfjNz67TEjun6dPs5b/Fdr6tQrb9zEIFLM2dq2qJ+o3KFdllHICHtz5/zt/ucwBiA0pBkYQ3O3rXaxWfQI7DeanW1lF/sE5bAyMLgkq5O1nt+V/LkwPkND9UcgNwXFklFDfeD6j4I68gg4XH1KVqs02omlyElqZplHVB4myWk9WBXirncOcHmiebTu3jWFD1sltmg+sfcOlF9Snph1A10ym0JELFd7G687zY8MG4kk59Vz1jPXj0gv/eKBL4/s9Q9qeyyGvDiMnmYZgqlcNC1ll+Ih8TmB858ZfRX6mOc91H53OeVnOHU6Fxz1UWGh7Z2qayMGMqGyEIijTkPh6Ygs2ESnXXYIDG1zp0p4Xy+RJ+52ZHBlkB8KAg3qLX2ad103R9NxbIaYwEoPLhnDBtoIqfKpoq6f0v9ATIbPPLNlj0x6fBYSpcgXv5WWpixM38t1bAIf9pcHaGYRiwcp868YS6aP2YDiueHde7JQlIVQM/mA3a5L9pPY1ErIhTovWE4o5sXOA6JZKaMesp+7gUekHNDAFiA0z17vEC5r6Qg6h++To6hcEy88A0W5/iaUhjMVDR5GPMoUKAlgefsEi3GW/QGaDcGEdKQVANFkgRhY0ja6HzuUhq7BB0P5k2Eqb4jxnb26jGzN/WYMzN6HhHadIpWFcVt70g3FtIwNgOOAQKXdNzDT6kIBOElE+xhkezqpxBhadFR6A==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(82310400026)(1800799024)(376014)(36860700016)(3023799007)(13003099007)(10067099003)(11063799006)(56012099006)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	iL9RtLDO0za0vMhhPo9o8OY3FqgoGAWets8vuLaMmmipbIrW5/drMT7u87hb3OaMZR6org4kOCmY4U2c8giWbKAJ4ixQKgQ3sB4/o9zecBeXYcPT1gh6VQyXAMwWcILVGYkdm7/oz5aPyvrgTm/yiX3i5bEVFeWPwxN2WurHNFyYSSZe16tIhKGPlFHOTj+AyGd1hVCPwLqaddGb3JfcyeqgMwIVFEkWN69H0Q2asZ9jgvPIm18deF7ElB26S1PdxEPU7CgzRreUd7ob+M9ubymQyVZgkPiCVbPbX0xzX7CrtGip0yRy8e5S2VeKjnkQ2i0SCjRgGmgvoyDS8gL3uKhcVUP2sCO6Gtss7WWzFaxrlCLOPhW8DR040FZbItCTMWavunPHJEnABM9uhJONgbnQpox9RnwMtIMIh6nxWWxwqufYkuyKcgElnqsmCRBk
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 10:58:21.6887
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd9cef92-e6f5-4cc6-229a-08df1ee1be42
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	LV8PEPF0000005B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB999099

This series adds Rust support for VFIO PCI variant drivers and an NVIDIA
vGPU driver using Nova's typed SR-IOV PF services.

It follows the discussion of the original C NVIDIA vGPU VFIO variant [1]
and builds on Danilo Krummrich's Rust vGPU/VFIO proof of concept [2],
including his PCI helpers, VFIO abstractions and NVIDIA variant driver.
Keeping the variant in Rust preserves the ownership and lifetime
relationships with nova-core across the PF/VF interface, and allows
registration and first-open/last-close resources to use Rust's RAII model.

The VFIO core prerequisite is the work of Simon Song and Alex Williamson,
discussed in [3]. VFIO core previously required PCI driver data to point
directly to a vfio_pci_core_device, conflicting with Rust's typed private
data. Their changes let each driver's PM, AER and VGA callbacks recover
the core device from its own private data and pass it to shared VFIO
helpers. This addresses the concern raised in the earlier thread: the
Rust driver can retain its typed PCI private data without adding a
separate VFIO pointer to struct pci_dev.

The main changes from the PoC are:

  - Separate common VFIO device and callback-data handling from the PCI
    wrapper. Require covariant registration data when restoring erased
    lifetimes, keep callback borrows distinct from data lifetimes, and
    extend callback-scoped access to open, write and mmap.

  - Add a VFIO PCI adapter for PM, AER, reset and VGA callbacks. Register
    VFIO after publishing initialized PCI private data, and unregister
    before releasing that data.

  - Connect the typed PF instance handle to the existing Nova manager's
    implemented open, close and reset operations. Make PF service access
    fallible and reject PCI segments that do not fit the firmware's DBDF
    format.

  - Match all NVIDIA device IDs and classes through an override-only
    entry, with PCI passthrough for devices without Nova services. Wire
    up IOMMUFD PASID callbacks and passthrough BAR DMA-buffer operations.

  - Enforce the assigned BAR1 aperture for read, write and mmap as well
    as region-info queries. Set the guest device ID in VFIO's virtual
    configuration space and retain the subsystem-ID read override.

Integration branch:
https://github.com/zhiwang-nvidia/nova-core/tree/zhi/nova-vgpu-20260930

[1] https://lore.kernel.org/all/20260905081116.106613-13-zhiw@nvidia.com/
[2] https://lore.kernel.org/nova-gpu/DLCRZLO06SIO.LS7TWQXIPZSQ@kernel.org/
[3] https://lore.kernel.org/all/20260929144243.5cb913a0@nvidia.com/

Danilo Krummrich (5):
  rust: pci: add VFIO override device IDs
  rust: pci: expose the VF index within its PF
  rust: pci: allow drivers to manage DMA ownership
  rust: vfio: add PCI variant driver abstractions
  vfio/nvidia-vgpu: add the Rust VFIO variant driver

Zhi Wang (2):
  rust: vfio: separate common device handling from PCI
  gpu: nova-core: publish typed SR-IOV PF APIs

 drivers/gpu/Makefile                        |   15 +-
 drivers/gpu/nova-core/driver.rs             |   47 +
 drivers/gpu/nova-core/nova_core.rs          |    2 +
 drivers/gpu/nova-core/vgpu/vgpu_api.rs      |   82 +-
 drivers/vfio/pci/Kconfig                    |    2 +
 drivers/vfio/pci/Makefile                   |    2 +
 drivers/vfio/pci/nvidia-vgpu/Kconfig        |   20 +
 drivers/vfio/pci/nvidia-vgpu/Makefile       |    3 +
 drivers/vfio/pci/nvidia-vgpu/nvidia_vgpu.rs |  366 +++++++
 rust/bindings/bindings_helper.h             |    4 +
 rust/kernel/lib.rs                          |    2 +
 rust/kernel/pci.rs                          |   11 +
 rust/kernel/pci/iov.rs                      |    8 +
 rust/kernel/vfio.rs                         |  290 ++++++
 rust/kernel/vfio/pci.rs                     | 1038 +++++++++++++++++++
 15 files changed, 1888 insertions(+), 4 deletions(-)
 create mode 100644 drivers/vfio/pci/nvidia-vgpu/Kconfig
 create mode 100644 drivers/vfio/pci/nvidia-vgpu/Makefile
 create mode 100644 drivers/vfio/pci/nvidia-vgpu/nvidia_vgpu.rs
 create mode 100644 rust/kernel/vfio.rs
 create mode 100644 rust/kernel/vfio/pci.rs


base-commit: 808dda6545c8775ea0abce0490308ddfeb5b8178
-- 
2.53.0

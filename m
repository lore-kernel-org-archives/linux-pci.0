Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011013.outbound.protection.outlook.com [52.101.62.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E8633D6EB;
	Thu, 22 Jan 2026 20:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769114742; cv=fail; b=Yp5TFeijIYczH6jf05gJJnJ3bqu9ycVBMGik7Wiu0ujOhmrfO7Qby1EksCeHXZp2MDpFfkTvBjL4R3MaGELEjNlu0NtwL7x0+M1SR011n1ZOdyap3WAPJGSsolTMBpX/t4fG5zmnqrBJoYkdK4fh0xl/1pMulDkLdeC1/uHW7Rw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769114742; c=relaxed/simple;
	bh=QLZBCk5n1FgQjNa1HdggTlHl1LIvFcpwirDZAoBac0U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V4y1pEH9jAEiA/JzlZfQYiE5reoIKq1COiz8ccpTYjlqmh0UzTg5tl701Mwxk/+tYt+5eSeo68z3C+D0tyeNdVpwaTKsuhi4+NauXocpTib6hRgErrkedr0krYNkYDRbffcXJtxTMB8RILsh7UDGMQ0Awxb6BiT4IOtMdff+jbk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rJclaDbO; arc=fail smtp.client-ip=52.101.62.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rJclaDbO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s/5ib50F0iz8JKiHkKxkJS10pDYhwiXfTjkY1qvz9KB2f/FdcWC/s9gqJ3v9OwRi+5Ftt22oFAfmubFbU6KNyyE0qtbM0l4RMq6nNuq0UyZmGFVY1lnveel/zp7g/A0mr+wr0gyn1tA45272thDv3BJZ8Y7UAAbMKcM6yfFGZ7prM1VlbdvtFhFybhROLPDhRsT9iPtE4Z3cI4FQlmCX9MjkleqX8vRcHKiF3/kLyWAkxNQexziuTdWUkLjzz9klYmPH10e6GOi/48yQTV7c4OfDOg55FLJEt5MCyrcmXS7MzViObrjLgTKi7hNf+yGXE/K8Gk6KkW8ej2NTjHjy+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CkhklPhIXpJDHdgb+N+P3aeQFyW8A63jllzosny7reI=;
 b=Vheo/wPWfsIba1yrg2dj3/06PrQWe6ndgsIUQfg7/tRUFgyuzuRTFzBFiy3iXIO6OCsMRdZ4hMQ/HVOaQ9o4j5AX8UD6lVwW9OkbL3TTxTaVnDF7JEjq6dm0kEIiqdutinpcSrzydHb6p7V10CNxBhiHu+9TRzxUXFVy3KNiudaPGKsQq/UIPA3xRPQANf9OtujNpHQGzsuEPpAxApBDQayarOPXkCE9fU8ohrsSPw4ty4sfD5HL9L0v3PGtmoz2CzU/sG8CTLFg5sPHQANXcgsTHi2XDTXSueJ/gVJh/whp6QTcfVxpigd/3xI3fhiTlLWcSXzfyMTaIB+RtR80BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CkhklPhIXpJDHdgb+N+P3aeQFyW8A63jllzosny7reI=;
 b=rJclaDbO5XLmTWnifJMgoBwAH3f2G3ZYc/wrH3GYAxl4DHIp7O+MM/Jgqdry6qawD4omhC/czNagSet7ClGNAff/4IL5SvJ4pb5ZU363Qe4IDL5VZYgJRdvKOecCk/8rmGCfPoYAzv+Tf3uHEPLCMYzdX3ISlg6uDTqCVrK29DtbbOio0HdeMpxRNcoX97f9+Znzu4Q7d2XS8Dkgj1pTmO8qPFis+y6cOGR3WUTJCQa6eoWf5iVz34i23Y65lcPhxrV9t+stW11X3Yc2jV9Co5DR61gfbOnyboFX8WkMO1wIHDDGKI4E1NAbM0M1sn2QUx9He0dEEgkr51tPxls8nA==
Received: from BLAPR05CA0044.namprd05.prod.outlook.com (2603:10b6:208:335::27)
 by IA1PR12MB8588.namprd12.prod.outlook.com (2603:10b6:208:44f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Thu, 22 Jan
 2026 20:45:25 +0000
Received: from BN2PEPF00004FC0.namprd04.prod.outlook.com
 (2603:10b6:208:335:cafe::f3) by BLAPR05CA0044.outlook.office365.com
 (2603:10b6:208:335::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.3 via Frontend Transport; Thu,
 22 Jan 2026 20:45:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF00004FC0.mail.protection.outlook.com (10.167.243.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Thu, 22 Jan 2026 20:45:25 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 22 Jan
 2026 12:42:47 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 22 Jan
 2026 12:42:47 -0800
Received: from inno-vm-xubuntu (10.127.8.13) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 22
 Jan 2026 12:42:40 -0800
From: Zhi Wang <zhiw@nvidia.com>
To: <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <dakr@kernel.org>, <aliceryhl@google.com>, <bhelgaas@google.com>,
	<kwilczynski@kernel.org>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
	<boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
	<lossin@kernel.org>, <a.hindborg@kernel.org>, <tmgross@umich.edu>,
	<markus.probst@posteo.de>, <helgaas@kernel.org>, <cjia@nvidia.com>,
	<smitra@nvidia.com>, <ankita@nvidia.com>, <aniketa@nvidia.com>,
	<kwankhede@nvidia.com>, <targupta@nvidia.com>, <acourbot@nvidia.com>,
	<joelagnelf@nvidia.com>, <jhubbard@nvidia.com>, <zhiwang@kernel.org>,
	<daniel.almeida@collabora.com>, Zhi Wang <zhiw@nvidia.com>, Jason Gunthorpe
	<jgg@nvidia.com>
Subject: [PATCH v2 1/2] rust: introduce abstractions for fwctl
Date: Thu, 22 Jan 2026 22:42:30 +0200
Message-ID: <20260122204232.15988-2-zhiw@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260122204232.15988-1-zhiw@nvidia.com>
References: <20260122204232.15988-1-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC0:EE_|IA1PR12MB8588:EE_
X-MS-Office365-Filtering-Correlation-Id: b82b2c06-a35a-424e-b222-08de59f72bb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?E9pxa/i0N2tP8S0T26ZDpr9SnFbL9Eolo7Jx29JTUh72LvdjE7OrhipKxFRV?=
 =?us-ascii?Q?jc9jD03TyAeAfdCumLC6oK3fo5M0EJa0m+x5b9AXZtQg/wEx+s3P7vd1AIGx?=
 =?us-ascii?Q?vpwqXk3QxGWNRX1H9k2fgzx1QN+oykitRXgbOCQOle0Gb4UBzd/cwWBfDqog?=
 =?us-ascii?Q?0pbo0jc5gFySpbWmE1SOMgqXTYR8n2Hs2zmIiAzbvEPgpgs4j3ektthdRBZ1?=
 =?us-ascii?Q?yQjqgyd/Rb4o4qsI8UlwZXv1o1I5xM1whSxzzda1TbD7f1HTX4iuULwwFIut?=
 =?us-ascii?Q?F0V+FaWlJb0sKYlqdx9w9TSsOMhQrHaM+G4AIV4x0YJcSluKNV8aZy25zo3l?=
 =?us-ascii?Q?BK6gRvsU/Ezg0QxVJJxgoIqLTAsLm9nh28+LiddELWF0Hyazg7KGNyNuKLzW?=
 =?us-ascii?Q?dyF9P9cNWfqk7Rh8/3CfvD6p9we7SLgpvCCY1KNTlRrblBAUtXvD0QZDeiA+?=
 =?us-ascii?Q?aQESpzTX3TUZGbw1uohUW5RVt/4Itc9I2NJGUtNDopDRaLiubOp9/BlkDcoc?=
 =?us-ascii?Q?YLcYSRT67JDKtVfAnr6qzGWfPOVljufJ2Ep+KgP9k9B++/hJ8Fp5kOOpptUS?=
 =?us-ascii?Q?gY4eM6s0QTVqLUJ1JJR8rQxfFEPoMPMualKN8pe03U1viOtj/9Ol/RL4wX9N?=
 =?us-ascii?Q?kxMjCgtu/rLTdde4d3oRIKkc1sIFbPTZJQEsORireD1KnU52XYiIagk66cg7?=
 =?us-ascii?Q?MnA8Qln5YEkGIqE40NxvysXMiVSdruu6Vag7ZCyzNHboliaex0IS6RDATZnx?=
 =?us-ascii?Q?tPHe1edfNsCa4z0eX055/U8fTSJaQWk5k4ReWRgIYcU006c4OeykHogjxRtY?=
 =?us-ascii?Q?X9FijADXkMIHCwMQ0TvXZiKJrxWndTZYiLEZ91tg1ar2Lx3OrUWczG7xj4Ip?=
 =?us-ascii?Q?J56cc/NkCVqmKh+ky80wiBJYvFouKHoYnSK/Z+8drGCsJoH0Jkw1SVLkE4uw?=
 =?us-ascii?Q?n0GauBM9DTpufhbuq/6+TRWM2KaDrsq1JnHRaoSX8P8m7SautONPJsDNPZhN?=
 =?us-ascii?Q?uvliuKRxytvnvrbgKymKXVKqPb0Lh8U7Keg71+ckSH2qfUq/c6KWr6WHXBo9?=
 =?us-ascii?Q?Jns2XGxaELAUNQl6EZhHkJD9QHmipeXpXPZAIFDRckuW2JOvj98yz53qZ1lF?=
 =?us-ascii?Q?PV2Khfs481ZaG8sKa/VPm9OEyoA7uJPLKovGUzrm9/tfT2lW8z5d9nFIx0yi?=
 =?us-ascii?Q?xH8eUSMT0WHxyA9B6A18xvoTuF5qtNaR5MxkUKgbbhZbWGGdtKDvmvchq1PU?=
 =?us-ascii?Q?QKHjQH05I34g5fjUJC9TL52I2S2VO975GOkeBdJH1WmXjq5PJALFwQykuH7m?=
 =?us-ascii?Q?txErHDld5A+lukCjcFS2QTU7A/QlNMjWYn++Pq7JATmll2Y0mKaJ/Z2geeHr?=
 =?us-ascii?Q?EH0PlabMHWZg6fFTa3AZZOzz2AWDqgabLLO9EJbn7IVd6GiDUlieiX1uEK7F?=
 =?us-ascii?Q?+6mrjbby9ExB3GUVvqNAvknYDDeJpDACoytVe8ExuPf3xNM5jbwtmM6OdcU0?=
 =?us-ascii?Q?DQ1TguhbzLSjxBP1b027ozQrIGqRCYMP2hweA1On0PrFUKtZTUTwcrOkr0qq?=
 =?us-ascii?Q?sC26XFWudVr25oaVG9sXZ1+8NtMDjGY2zF0WaDnJzOCI/1tx3WKpUrLev8Ny?=
 =?us-ascii?Q?YpuNdaLxbogaqJvf7CPjSIIeEPr5L/c5tB/Rujqw8S8v20ql50lzmP1NyqRb?=
 =?us-ascii?Q?dqRYEw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 20:45:25.6520
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b82b2c06-a35a-424e-b222-08de59f72bb5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FC0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8588

Introduce safe wrappers around `struct fwctl_device` and
`struct fwctl_uctx`, allowing rust drivers to register fwctl devices and
implement their control and RPC logic in safe rust.

Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
---
 drivers/fwctl/Kconfig           |  12 +
 include/uapi/fwctl/fwctl.h      |   1 +
 rust/bindings/bindings_helper.h |   1 +
 rust/helpers/fwctl.c            |  17 ++
 rust/helpers/helpers.c          |   3 +-
 rust/kernel/fwctl.rs            | 456 ++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs              |   2 +
 7 files changed, 491 insertions(+), 1 deletion(-)
 create mode 100644 rust/helpers/fwctl.c
 create mode 100644 rust/kernel/fwctl.rs

diff --git a/drivers/fwctl/Kconfig b/drivers/fwctl/Kconfig
index b5583b12a011..d8538249f3ae 100644
--- a/drivers/fwctl/Kconfig
+++ b/drivers/fwctl/Kconfig
@@ -8,6 +8,18 @@ menuconfig FWCTL
 	  manipulating device FLASH, debugging, and other activities that don't
 	  fit neatly into an existing subsystem.
 
+config RUST_FWCTL_ABSTRACTIONS
+	bool "Rust fwctl abstractions"
+	depends on RUST
+	select FWCTL
+	help
+	  This enables the Rust abstractions for the fwctl device firmware
+	  access framework. It provides safe wrappers around struct fwctl_device
+	  and struct fwctl_uctx, allowing Rust drivers to register fwctl devices
+	  and implement their control and RPC logic in safe Rust.
+
+	  If unsure, say N.
+
 if FWCTL
 config FWCTL_MLX5
 	tristate "mlx5 ConnectX control fwctl driver"
diff --git a/include/uapi/fwctl/fwctl.h b/include/uapi/fwctl/fwctl.h
index 716ac0eee42d..eea1020ad180 100644
--- a/include/uapi/fwctl/fwctl.h
+++ b/include/uapi/fwctl/fwctl.h
@@ -45,6 +45,7 @@ enum fwctl_device_type {
 	FWCTL_DEVICE_TYPE_MLX5 = 1,
 	FWCTL_DEVICE_TYPE_CXL = 2,
 	FWCTL_DEVICE_TYPE_PDS = 4,
+	FWCTL_DEVICE_TYPE_RUST_FWCTL_TEST = 8,
 };
 
 /**
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 9fdf76ca630e..2c50d5bab0cf 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -56,6 +56,7 @@
 #include <linux/fdtable.h>
 #include <linux/file.h>
 #include <linux/firmware.h>
+#include <linux/fwctl.h>
 #include <linux/interrupt.h>
 #include <linux/fs.h>
 #include <linux/i2c.h>
diff --git a/rust/helpers/fwctl.c b/rust/helpers/fwctl.c
new file mode 100644
index 000000000000..bb4a028e7afb
--- /dev/null
+++ b/rust/helpers/fwctl.c
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/fwctl.h>
+
+#if IS_ENABLED(CONFIG_RUST_FWCTL_ABSTRACTIONS)
+
+struct fwctl_device *rust_helper_fwctl_get(struct fwctl_device *fwctl)
+{
+	return fwctl_get(fwctl);
+}
+
+void rust_helper_fwctl_put(struct fwctl_device *fwctl)
+{
+	fwctl_put(fwctl);
+}
+
+#endif
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 79c72762ad9c..19a505473bef 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -27,8 +27,9 @@
 #include "dma.c"
 #include "drm.c"
 #include "err.c"
-#include "irq.c"
 #include "fs.c"
+#include "fwctl.c"
+#include "irq.c"
 #include "io.c"
 #include "jump_label.c"
 #include "kunit.c"
diff --git a/rust/kernel/fwctl.rs b/rust/kernel/fwctl.rs
new file mode 100644
index 000000000000..4065c948784d
--- /dev/null
+++ b/rust/kernel/fwctl.rs
@@ -0,0 +1,456 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+//! Abstractions for the fwctl.
+//!
+//! This module provides bindings for working with fwctl devices in kernel modules.
+//!
+//! C header: [`include/linux/fwctl.h`]
+
+use crate::{
+    bindings,
+    container_of,
+    device,
+    devres::Devres,
+    prelude::*,
+    types::{
+        ARef,
+        Opaque, //
+    }, //
+};
+use core::{
+    marker::PhantomData,
+    ptr::NonNull,
+    slice, //
+};
+
+/// Represents a fwctl device type.
+///
+/// This enum corresponds to the C `enum fwctl_device_type` and is used to identify
+/// the specific firmware control interface implemented by a device.
+#[repr(u32)]
+#[derive(Copy, Clone, Debug, Eq, PartialEq)]
+pub enum DeviceType {
+    /// Error/invalid device type.
+    Error = bindings::fwctl_device_type_FWCTL_DEVICE_TYPE_ERROR,
+    /// MLX5 device type.
+    Mlx5 = bindings::fwctl_device_type_FWCTL_DEVICE_TYPE_MLX5,
+    /// CXL device type.
+    Cxl = bindings::fwctl_device_type_FWCTL_DEVICE_TYPE_CXL,
+    /// PDS device type.
+    Pds = bindings::fwctl_device_type_FWCTL_DEVICE_TYPE_PDS,
+    /// Rust fwctl test device type.
+    RustFwctlTest = bindings::fwctl_device_type_FWCTL_DEVICE_TYPE_RUST_FWCTL_TEST,
+}
+
+impl From<DeviceType> for u32 {
+    fn from(device_type: DeviceType) -> Self {
+        device_type as u32
+    }
+}
+
+/// A fwctl device.
+///
+/// Wraps the C `struct fwctl_device` and manages its reference count.
+///
+/// # Invariants
+///
+/// Instances of this type represent a valid `struct fwctl_device` created by the C portion
+/// of the kernel.
+#[repr(transparent)]
+pub struct Device(Opaque<bindings::fwctl_device>);
+
+impl Device {
+    /// # Safety
+    ///
+    /// `ptr` must be a valid pointer to a `struct fwctl_device`.
+    unsafe fn from_raw<'a>(ptr: *mut bindings::fwctl_device) -> &'a Self {
+        // CAST: `Self` is a transparent wrapper around `bindings::fwctl_device`.
+        // SAFETY: By the safety requirement, `ptr` is valid.
+        unsafe { &*ptr.cast() }
+    }
+
+    fn as_raw(&self) -> *mut bindings::fwctl_device {
+        self.0.get()
+    }
+
+    /// Returns the parent device.
+    pub fn parent(&self) -> &device::Device {
+        // SAFETY: By the type invariant, `self.as_raw()` is a valid pointer to a
+        // `struct fwctl_device`, which always has a parent device.
+        let parent_dev = unsafe { (*self.as_raw()).dev.parent };
+        // SAFETY: `parent_dev` points to a valid `struct device`. The parent device
+        // is guaranteed to be valid for the lifetime of the fwctl_device.
+        unsafe { device::Device::from_raw(parent_dev) }
+    }
+}
+
+impl AsRef<device::Device> for Device {
+    fn as_ref(&self) -> &device::Device {
+        // SAFETY: By the type invariant of `Self`, `self.as_raw()` is a pointer to a valid
+        // `struct fwctl_device`.
+        let dev = unsafe { core::ptr::addr_of_mut!((*self.as_raw()).dev) };
+
+        // SAFETY: `dev` points to a valid `struct device`.
+        unsafe { device::Device::from_raw(dev) }
+    }
+}
+
+// SAFETY: The fwctl_device is reference counted through the embedded `struct device`,
+// and inc_ref/dec_ref use fwctl_get/fwctl_put to manage its lifetime.
+unsafe impl crate::sync::aref::AlwaysRefCounted for Device {
+    fn inc_ref(&self) {
+        // SAFETY: The existence of a shared reference guarantees that the refcount is non-zero.
+        // `self.as_raw()` is a valid pointer to a `struct fwctl_device`.
+        unsafe { bindings::fwctl_get(self.as_raw()) };
+    }
+
+    unsafe fn dec_ref(obj: NonNull<Self>) {
+        // CAST: `Self` is a transparent wrapper of `bindings::fwctl_device`.
+        let fwctl: *mut bindings::fwctl_device = obj.cast().as_ptr();
+
+        // SAFETY: By the type invariant, `fwctl` is a valid pointer to a `struct fwctl_device`.
+        unsafe { bindings::fwctl_put(fwctl) };
+    }
+}
+
+// SAFETY: A `Device` is always reference-counted and can be released from any thread.
+unsafe impl Send for Device {}
+
+// SAFETY: `Device` can be shared among threads because all methods are thread-safe.
+unsafe impl Sync for Device {}
+
+/// The registration of a fwctl device.
+///
+/// This type represents the registration of a [`struct fwctl_device`]. It should always be
+/// used within a [`Devres`] wrapper to ensure proper lifetime management. When dropped,
+/// the fwctl device will be unregistered and freed.
+///
+/// [`Devres`] guarantees that the device is unregistered before the parent device is unbound.
+///
+/// [`struct fwctl_device`]: srctree/include/linux/device/fwctl.h
+pub struct Registration<T: Operations> {
+    device: ARef<Device>,
+    _marker: PhantomData<T>,
+}
+
+impl<T: Operations> Registration<T> {
+    /// Allocate and register a new fwctl device under the given parent device.
+    ///
+    /// The returned [`Devres`] wrapper ensures that the fwctl device is unregistered
+    /// before the parent device is unbound.
+    pub fn new<'a>(
+        parent: &'a device::Device<device::Bound>,
+    ) -> impl PinInit<Devres<Self>, Error> + 'a
+    where
+        T: 'a,
+    {
+        pin_init::pin_init_scope(move || {
+            let ops = core::ptr::from_ref::<bindings::fwctl_ops>(&VTable::<T>::VTABLE).cast_mut();
+
+            // SAFETY: `_fwctl_alloc_device()` allocates a new `fwctl_device`
+            // and initializes its embedded `struct device`. The `ops` pointer
+            // points to a static VTABLE that outlives the device. The parent
+            // device is guaranteed to be bound to a driver (Device<Bound>),
+            // ensuring it remains valid during allocation.
+            let dev = unsafe {
+                bindings::_fwctl_alloc_device(
+                    parent.as_raw(),
+                    ops,
+                    core::mem::size_of::<bindings::fwctl_device>(),
+                )
+            };
+
+            if dev.is_null() {
+                return Err(ENOMEM);
+            }
+
+            // SAFETY: dev is guaranteed to be a valid pointer from `_fwctl_alloc_device()`.
+            let ret = unsafe { bindings::fwctl_register(dev) };
+            if ret != 0 {
+                // SAFETY: dev is guaranteed to be a valid pointer from `_fwctl_alloc_device()`.
+                unsafe {
+                    bindings::fwctl_put(dev);
+                }
+                return Err(Error::from_errno(ret));
+            }
+
+            // SAFETY: dev is guaranteed to be a valid pointer from `_fwctl_alloc_device()`.
+            let device = unsafe {
+                let dev_ref = Device::from_raw(dev);
+                // SAFETY: We just verified dev is non-null above, and Device::from_raw
+                // returns a reference, so NonNull::new_unchecked is safe.
+                ARef::from_raw(NonNull::new_unchecked(
+                    core::ptr::from_ref(dev_ref).cast_mut(),
+                ))
+            };
+
+            Ok(Devres::new(
+                parent,
+                Self {
+                    device,
+                    _marker: PhantomData,
+                },
+            ))
+        })
+    }
+
+    fn as_raw(&self) -> *mut bindings::fwctl_device {
+        self.device.as_raw()
+    }
+}
+
+impl<T: Operations> Drop for Registration<T> {
+    fn drop(&mut self) {
+        // SAFETY: `fwctl_unregister()` expects a valid registered device.
+        // By the type invariant, `self.device` holds a valid fwctl_device.
+        unsafe {
+            bindings::fwctl_unregister(self.as_raw());
+        }
+        // The ARef<Device> will automatically call fwctl_put() when dropped.
+    }
+}
+
+// SAFETY: `Registration` can be sent to other threads because:
+// - It only contains a `NonNull<fwctl_device>` pointer and a PhantomData marker
+// - The underlying C fwctl_device is thread-safe with internal locking
+// - `Drop` calls `fwctl_unregister()/fwctl_put()` which are safe from any sleepable context
+unsafe impl<T: Operations> Send for Registration<T> {}
+
+// SAFETY: `Registration` can be shared between threads because:
+// - It provides no methods for mutation (except Drop, which takes &mut self)
+// - The underlying C fwctl_device is protected by internal locking (registration_lock)
+// - Multiple threads can safely hold immutable references to the same Registration
+unsafe impl<T: Operations> Sync for Registration<T> {}
+
+/// Trait implemented by each Rust driver that integrates with the fwctl subsystem.
+///
+/// Each implementation corresponds to a specific device type and provides
+/// the vtable used by the core `fwctl` layer to manage per-FD user contexts
+/// and handle RPC requests.
+pub trait Operations: Sized {
+    /// Driver user context type.
+    type UserCtx;
+
+    /// fwctl device type.
+    const DEVICE_TYPE: DeviceType;
+
+    /// Called when a new user context is opened by userspace.
+    fn open(
+        fwctl_uctx: &Opaque<bindings::fwctl_uctx>,
+    ) -> Result<impl PinInit<Self::UserCtx, Error>, Error>;
+
+    /// Called when the user context is being closed.
+    fn close(uctx: &mut UserCtx<Self::UserCtx>);
+
+    /// Return device or context information to userspace.
+    fn info(uctx: &mut UserCtx<Self::UserCtx>) -> Result<KVec<u8>, Error>;
+
+    /// Called when a userspace RPC request is received.
+    fn fw_rpc(
+        uctx: &mut UserCtx<Self::UserCtx>,
+        scope: u32,
+        rpc_in: &mut [u8],
+        out_len: *mut usize,
+    ) -> Result<Option<KVec<u8>>, Error>;
+}
+
+/// Represents a per-FD user context (`struct fwctl_uctx`).
+#[repr(C)]
+#[pin_data]
+pub struct UserCtx<T> {
+    /// The core fwctl user context shared with the C implementation.
+    #[pin]
+    fwctl_uctx: Opaque<bindings::fwctl_uctx>,
+
+    /// Driver-specific data associated with this user context.
+    #[pin]
+    uctx: T,
+}
+
+impl<T> UserCtx<T> {
+    /// Converts a raw C pointer to `struct fwctl_uctx` into a reference to the
+    /// enclosing `UserCtx<T>`.
+    ///
+    /// # Safety
+    /// * `ptr` must be a valid pointer to a `fwctl_uctx` that is embedded
+    ///   inside an existing `UserCtx<T>` instance.
+    /// * The caller must ensure that the lifetime of the returned reference
+    ///   does not outlive the underlying object managed on the C side.
+    unsafe fn from_raw<'a>(ptr: *mut bindings::fwctl_uctx) -> &'a mut Self {
+        // SAFETY: `ptr` was originally created from a valid `UserCtx<T>`.
+        // We cast through `Opaque` since `fwctl_uctx` is wrapped in `Opaque`.
+        unsafe { &mut *container_of!(Opaque::cast_from(ptr), UserCtx<T>, fwctl_uctx).cast_mut() }
+    }
+
+    /// Returns a reference to the parent device from a raw `fwctl_uctx` pointer.
+    pub fn parent_device_from_raw(
+        fwctl_uctx: &Opaque<bindings::fwctl_uctx>,
+    ) -> &device::Device<device::Bound> {
+        // SAFETY: `fwctl_uctx` is initialized by the fwctl subsystem
+        // and guaranteed to remain valid.
+        let raw_fwctl = unsafe { (*fwctl_uctx.get()).fwctl };
+        // SAFETY: `raw_fwctl` is a valid pointer to a `fwctl_device`, and its `dev.parent`
+        // field points to a valid parent device.
+        let raw_dev = unsafe { (*raw_fwctl).dev.parent };
+
+        // SAFETY: `raw_dev` points to a live device object.
+        let dev: &device::Device = unsafe { device::Device::from_raw(raw_dev) };
+
+        // SAFETY: The device is guaranteed to be bound.
+        unsafe { dev.as_bound() }
+    }
+
+    /// Returns a reference to the parent device of this user context.
+    pub fn get_parent_device(&self) -> &device::Device<device::Bound> {
+        Self::parent_device_from_raw(&self.fwctl_uctx)
+    }
+}
+
+impl<T> core::ops::Deref for UserCtx<T> {
+    type Target = T;
+
+    fn deref(&self) -> &Self::Target {
+        &self.uctx
+    }
+}
+
+impl<T> core::ops::DerefMut for UserCtx<T> {
+    fn deref_mut(&mut self) -> &mut Self::Target {
+        &mut self.uctx
+    }
+}
+
+/// Static vtable mapping Rust trait methods to C callbacks.
+pub struct VTable<T: Operations>(PhantomData<T>);
+
+impl<T: Operations> VTable<T> {
+    /// Static instance of `fwctl_ops` used by the C core to call into Rust.
+    pub const VTABLE: bindings::fwctl_ops = bindings::fwctl_ops {
+        device_type: T::DEVICE_TYPE as u32,
+        uctx_size: core::mem::size_of::<UserCtx<T::UserCtx>>(),
+        open_uctx: Some(Self::open_uctx_callback),
+        close_uctx: Some(Self::close_uctx_callback),
+        info: Some(Self::info_callback),
+        fw_rpc: Some(Self::fw_rpc_callback),
+    };
+
+    /// Called when a new user context is opened by userspace.
+    /// # Safety
+    ///
+    /// `uctx` must be a valid pointer to an initialized `fwctl_uctx` structure,
+    /// embedded within a C-allocated `UserCtx<T::UserCtx>` with sufficient space.
+    unsafe extern "C" fn open_uctx_callback(uctx: *mut bindings::fwctl_uctx) -> ffi::c_int {
+        // SAFETY: `uctx` points to valid, initialized `fwctl_uctx` structure.
+        let fwctl_uctx_ref = unsafe { &*Opaque::cast_from(uctx) };
+
+        let initializer = match T::open(fwctl_uctx_ref) {
+            Ok(init) => init,
+            Err(e) => return e.to_errno(),
+        };
+
+        let uctx_offset = core::mem::offset_of!(UserCtx<T::UserCtx>, uctx);
+
+        // SAFETY: The C side allocated enough space for the entire UserCtx.
+        let uctx_ptr: *mut T::UserCtx = unsafe { uctx.cast::<u8>().add(uctx_offset).cast() };
+
+        // Initialize the uctx field in-place using the pin initializer.
+        // SAFETY:
+        // - uctx_ptr points to valid allocated memory
+        // - The memory is properly aligned (guaranteed by #[repr(C)] and our compile-time check)
+        // - The memory is uninitialized, which is what PinInit expects
+        // - After this call, the memory will be properly initialized
+        match unsafe { initializer.__pinned_init(uctx_ptr.cast()) } {
+            Ok(()) => 0,
+            Err(e) => e.to_errno(),
+        }
+    }
+
+    /// Called when the user context is being closed.
+    /// # Safety
+    ///
+    /// `uctx` must be a valid pointer to an initialized `fwctl_uctx` structure,
+    /// embedded within a fully initialized `UserCtx<T::UserCtx>`.
+    unsafe extern "C" fn close_uctx_callback(uctx: *mut bindings::fwctl_uctx) {
+        // SAFETY: `uctx` is guaranteed by the fwctl subsystem to be a valid pointer.
+        let ctx = unsafe { UserCtx::<T::UserCtx>::from_raw(uctx) };
+        T::close(ctx);
+    }
+
+    /// Returns device or context information.
+    /// # Safety
+    ///
+    /// - `uctx` must be a valid pointer to an initialized `fwctl_uctx` structure,
+    ///   embedded within a fully initialized `UserCtx<T::UserCtx>`.
+    /// - `length` must be a valid pointer to write the output length.
+    unsafe extern "C" fn info_callback(
+        uctx: *mut bindings::fwctl_uctx,
+        length: *mut usize,
+    ) -> *mut ffi::c_void {
+        // SAFETY: `uctx` is guaranteed by the fwctl subsystem to be a valid pointer.
+        let ctx = unsafe { UserCtx::<T::UserCtx>::from_raw(uctx) };
+
+        match T::info(ctx) {
+            Ok(kvec) => {
+                // The ownership of the buffer is now transferred to the foreign
+                // caller. It must eventually be released by fwctl framework.
+                let (ptr, len, _cap) = kvec.into_raw_parts();
+
+                // SAFETY: `length` is a valid out-parameter provided by the C
+                // caller. Write the number of bytes in the returned buffer.
+                unsafe {
+                    *length = len;
+                }
+
+                ptr.cast::<ffi::c_void>()
+            }
+
+            Err(e) => Error::to_ptr(e),
+        }
+    }
+
+    /// Called when a user-space RPC request is received.
+    /// # Safety
+    ///
+    /// - `uctx` must be a valid pointer to an initialized `fwctl_uctx` structure,
+    ///   embedded within a fully initialized `UserCtx<T::UserCtx>`.
+    /// - `rpc_in` must be a valid pointer to `in_len` bytes of readable/writable memory.
+    /// - `out_len` must be a valid pointer to write the output length.
+    unsafe extern "C" fn fw_rpc_callback(
+        uctx: *mut bindings::fwctl_uctx,
+        scope: u32,
+        rpc_in: *mut ffi::c_void,
+        in_len: usize,
+        out_len: *mut usize,
+    ) -> *mut ffi::c_void {
+        // SAFETY: `uctx` is guaranteed by the fwctl framework to be a valid pointer.
+        let ctx = unsafe { UserCtx::<T::UserCtx>::from_raw(uctx) };
+
+        // SAFETY: Creating a mutable slice from `rpc_in`:
+        // - `rpc_in` is non-null and properly aligned: guaranteed by the fwctl subsystem
+        // - `rpc_in` points to `in_len` consecutive properly initialized bytes
+        // - The memory is valid for reads and writes for the lifetime of the returned slice
+        // - The total size `in_len` does not exceed `isize::MAX`: checked by the fwctl subsystem
+        // - No other references to this memory exist during this callback
+        let rpc_in_slice: &mut [u8] =
+            unsafe { slice::from_raw_parts_mut(rpc_in.cast::<u8>(), in_len) };
+
+        match T::fw_rpc(ctx, scope, rpc_in_slice, out_len) {
+            // Driver allocates a new output buffer.
+            Ok(Some(kvec)) => {
+                // The ownership of the buffer is now transferred to the foreign
+                // caller. It must eventually be released by fwctl subsystem.
+                let (ptr, len, _cap) = kvec.into_raw_parts();
+
+                // SAFETY: `out_len` is a valid writable pointer provided by the C caller.
+                unsafe { *out_len = len };
+
+                ptr.cast::<ffi::c_void>()
+            }
+
+            // Driver re-uses the existing input buffer and writes the out_len.
+            Ok(None) => rpc_in,
+
+            Err(e) => Error::to_ptr(e),
+        }
+    }
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 6d637e2fed1b..956e865c17ea 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -97,6 +97,8 @@
 pub mod firmware;
 pub mod fmt;
 pub mod fs;
+#[cfg(CONFIG_RUST_FWCTL_ABSTRACTIONS)]
+pub mod fwctl;
 #[cfg(CONFIG_I2C = "y")]
 pub mod i2c;
 pub mod id_pool;
-- 
2.51.0


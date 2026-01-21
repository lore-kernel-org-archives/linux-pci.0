Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011043.outbound.protection.outlook.com [52.101.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A043EDADB;
	Wed, 21 Jan 2026 20:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769026977; cv=fail; b=HsRzP0LhaHxrgK+B/dh2dUaaDtQgEWksY+FbiELli0s3WtjA1i1YPGAwOXhQbIkF+u0NL+J6/qUg54HPtdzL1RD/Aen/uVjrjwfO4529UVSTqM15HjqXquF0XyfIm2znuY/YMa/9kQo9s33Z5PrAEH0EamcBC7k/vGFSXjn6OnU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769026977; c=relaxed/simple;
	bh=htpxWmumglNCX8kauWKNJF6VbHve7Dwubm2JfH/Be20=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JxnafHgjTIfFDi1K82kxLo9tZR6EB0Z5Hr0od3Tabk6lzrJFOju25q2QXcYbfBI/xbZ5sNZJ8hbQTDvVsVHpJtBrlYSNGVscVqq0sHXagK5Zy2ppkjCxnOo1Fv+Tys/qyFEb8YfOfvLEdHJE1FyxbQIrjRTYYOHTyju9iUyUI84=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aKrfHJGF; arc=fail smtp.client-ip=52.101.52.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aKrfHJGF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZoLyV3b8m8ABj5cYbZ+e8KHnepsk/C9YGsXX4oVwqgNIZFKlM0dXaIR53Cisg6qSgeJyRa6wOabrS1EhL7+uds7wR0i1ZDkQN3zO6Y9mtFLAZsTnhLr8DuN+1ars7aAWAdgEMRaLuaz7eApajyZsqWPfYh06cZSwFeP6I7rmv8PA5HFTMsl07T16ubzr5Sd/XGVyrmkD67+5QDztQkPUsmhA6kKPHKAMRjMT+xMYP18ynfWoh/XCyqutDpf+yTVVnp8jJBk+w+c3w87LNZASyQe5uUvpUmooq87vRkmCyN4CfIL9QIDZwxQbyTvfYVz4j2KumJPtLskf9b/mpWTb2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JcRZro5+6Bfg1SZvzFK8B/Jbx0vcHMUf72GL/qqK8GM=;
 b=KexsfdluFkuZRRlGpltVvVG3u8GYNRKNapNttgdkJ58pcfhMLEcOBTZ3pVSp/HPsFRqxvAyfFnbxu+RTLyovsXTXcetIWynUSV9SJpKWd+zOC1Dhq0HXdnzsl6CRzL0xR7l1SWyixRC2BBZfRYuZnwABLbexnqsp10JyPXxZUopCThDPMTdyySEn/D0fJzb8Eih2zth9fUBNnkVp1bzci2yfmWswaldYQNjqIhf/AsioLbTVJ2GSK0cD9EJrOZ2tLEGu3Ye6/1X24JtF1IW7Gbr5IrCHibMC7/HSv88Xok2Xl8bx1Jr38MGWcfc56VPLhIPGmxo2RSOPsQpgRSZ2Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JcRZro5+6Bfg1SZvzFK8B/Jbx0vcHMUf72GL/qqK8GM=;
 b=aKrfHJGFQeuYwOhcYV6P9HI9uY7qSSYQMsVsTpbIC5Pfs3o6xVwkIMaR1RkkZKajGhoXiQRx8r2RYWPh+P4aoUdglL7BpaQ98Qzmh1BxjJYnEbxfyzdSbksGDut0iTvtB7L6oTCSMlgjtwibb2EdFY5DC8snLUM0JN9HzC1EQXHyDWrgLdZ4Aldh/9r2OmMyLl/qbIOLxPzcV2rH3wJcM3N7Bp2cGjdy7SEQGUGPoXxuzH1MFgoTMmWzoAqD/xkhtWdgYQDLxKN6j9mQ2KJFzlTYuCsOGu2JXezD6zt2fIEjJYMqLQNFKkKG+NVm6OrPNTWWc+g1P6zqm69iTG/6VQ==
Received: from DM6PR08CA0036.namprd08.prod.outlook.com (2603:10b6:5:80::49) by
 SA1PR12MB7293.namprd12.prod.outlook.com (2603:10b6:806:2b9::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.9; Wed, 21 Jan 2026 20:22:47 +0000
Received: from DS2PEPF0000343A.namprd02.prod.outlook.com
 (2603:10b6:5:80:cafe::4d) by DM6PR08CA0036.outlook.office365.com
 (2603:10b6:5:80::49) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.10 via Frontend Transport; Wed,
 21 Jan 2026 20:22:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS2PEPF0000343A.mail.protection.outlook.com (10.167.18.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 20:22:46 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 12:22:26 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 21 Jan 2026 12:22:26 -0800
Received: from inno-vm-xubuntu (10.127.8.11) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 21 Jan 2026 12:22:20 -0800
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
	<daniel.almeida@collabora.com>, Zhi Wang <zhiw@nvidia.com>
Subject: [PATCH v12 1/5] rust: devres: style for imports
Date: Wed, 21 Jan 2026 22:22:07 +0200
Message-ID: <20260121202212.4438-2-zhiw@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260121202212.4438-1-zhiw@nvidia.com>
References: <20260121202212.4438-1-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343A:EE_|SA1PR12MB7293:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e912918-7a4a-4a6b-0da7-08de592ad769
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YXrSsaLNPvi8J9cIcdengeJnPxYprQIXqEYr5hSyaZpeWeEyJmXya1pTbyw6?=
 =?us-ascii?Q?X5jt/Z7qN4fDRMpXPvZNFn2KdOmpbWV3nlnSq+CCHYZBGzgB3s8bLIjDR9aG?=
 =?us-ascii?Q?tGTWtBE4Y6hCKhz800yLPAwmnV6kWHLkv/bSnILpJyHkOwwhk1q33i0yYktt?=
 =?us-ascii?Q?R0tClUXlE1NyyU7UKqBruWdBDDHGNxVzdWpsR1LsGsme9TECIp8FXtyDkP9c?=
 =?us-ascii?Q?t338Yh0unN6F7QwGD9v22Y83N+p6G2eP4OtIp9kq64jUCQKCIz4trHKR29Yj?=
 =?us-ascii?Q?DQ9OH7WaLUs0oijpFxG15IL0PMtxFKiSrLCYLrbeD/cajZmlUFB3QKtt79m0?=
 =?us-ascii?Q?1AlfIxMdVvuf/wC/I35sisFsFE7JuehlyGszxghRfPnsoEfg7MuKVqugd3ql?=
 =?us-ascii?Q?NPrAONB1x6fbX4eY+9iShys8LTzwTEaPJeF61snDExZIZPewRgo1pgfwA1LD?=
 =?us-ascii?Q?wH0Jqx9ND0upFGHvEDTeBz2dvC6czcpRuFXjcVgzh0jkkv35WPVA9XTjInUM?=
 =?us-ascii?Q?IbDagzQzbTQT6vrsIC+ya7SwLi0Tt/nhwbTGU5BiSYhRLHb4HHgfd6abZheF?=
 =?us-ascii?Q?xAhmzSw5+yczZZSYxm9UywuKpxTrFW+OHkJCfSblwbKQWPqJT/K9x9VcH6w4?=
 =?us-ascii?Q?Slo3Zrw7VC2lQlnrx3LtM9lxaObUvKAoI0fbzqyPSMUgqMKteHfYZ7MXRJq5?=
 =?us-ascii?Q?HZEEYHGeeaYvjtXAUn6FuVP9zLY7i0hu+khY7h0s5HAnBcgPyZLzcXpJzzfc?=
 =?us-ascii?Q?/pLFr7pTevb7gOxkzQ/DMI/qsZ+ilXEfgsm8eCGekv5AmBeFin+ct1cf5prg?=
 =?us-ascii?Q?gDFZW2djiiGiVmTTlJvwyjPHfsVV5NdfR0twiOWUcpTZ1HXL9dg2r5fFoJGW?=
 =?us-ascii?Q?PAMp6GLMzcyJJfmRdk666lzm8yHZeVbUvrv61uqfzRulUNc0qEiSwyir4uXa?=
 =?us-ascii?Q?3hHe4QJdE9G36toz6rfFXMNRTAKZpwWnzyrwkB1q1QUZDdNd1yV5z39GjBXg?=
 =?us-ascii?Q?GvQvPrSPPTWYvLhzJgoQYkdEOg95gC37NZNXqmEg4zB/agJtaHz4w/4FPCPv?=
 =?us-ascii?Q?Bd55gLZM738TIzR4tDgvGKZC62KGY+0U0umcmH8t2RRQvybA1vlrK9wPUnGo?=
 =?us-ascii?Q?QqVAd35P6N7WpKCr61REjZjcoWji6ZPp0bvLQTH7iC+hY0qoVuWrTXKdCdYD?=
 =?us-ascii?Q?5BVVZoOiGx178LDuipi7MYLGru8KTDHjy4Bqc+d3wCebp+1VRYBy/BM1qrK+?=
 =?us-ascii?Q?NFKrkD+uU1NxPI3mlM45svku2y1TRpRgPbMykDaLPMvZ6IoG1hLXQLHPXX5l?=
 =?us-ascii?Q?uDFqmc3FNdc6EanwIs8JSAsuTmveHErhBRPGDp3wlD/QPpXieoWyHTqpZiuR?=
 =?us-ascii?Q?3HG0qDdaDsuSdwzk3+Kw0rdJo/87A7VsVj2eu1MJp3u3GGEoG3RFLQawl6F2?=
 =?us-ascii?Q?eDXO9OHkX1WKjdTMxsYNnfyJMdCo7q/6nQiqj+zMK4O5aL5ayQUeudxlHEKY?=
 =?us-ascii?Q?1H3StjSzPgqBI8xGz/ATZJYSANMid7b888p02a+0FwPqH1IQbVvuIVf7SxNM?=
 =?us-ascii?Q?tSVUqibiz1vR6eOt4W+YtMXgyw6mWXzVqsOv4Tp3FEDgk1khDZlLawOMjGj5?=
 =?us-ascii?Q?RhUJNo4ZbuSGc/1Vc2JvsXeCT8GpkGgR2rDiE/nxhu9XscRDbB9VdeelT3QT?=
 =?us-ascii?Q?/V/uXg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 20:22:46.9392
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e912918-7a4a-4a6b-0da7-08de592ad769
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7293

Convert all imports in the devres to use "kernel vertical" style.

Cc: Gary Guo <gary@garyguo.net>
Cc: Miguel Ojeda <ojeda@kernel.org>
Reviewed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
---
 rust/kernel/devres.rs | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
index db02f8b1788d..43089511bf76 100644
--- a/rust/kernel/devres.rs
+++ b/rust/kernel/devres.rs
@@ -254,8 +254,12 @@ pub fn device(&self) -> &Device {
     /// # Examples
     ///
     /// ```no_run
-    /// # #![cfg(CONFIG_PCI)]
-    /// # use kernel::{device::Core, devres::Devres, pci};
+    /// #![cfg(CONFIG_PCI)]
+    /// use kernel::{
+    ///     device::Core,
+    ///     devres::Devres,
+    ///     pci, //
+    /// };
     ///
     /// fn from_core(dev: &pci::Device<Core>, devres: Devres<pci::Bar<0x4>>) -> Result {
     ///     let bar = devres.access(dev.as_ref())?;
@@ -358,7 +362,13 @@ fn register_foreign<P>(dev: &Device<Bound>, data: P) -> Result
 /// # Examples
 ///
 /// ```no_run
-/// use kernel::{device::{Bound, Device}, devres};
+/// use kernel::{
+///     device::{
+///         Bound,
+///         Device, //
+///     },
+///     devres, //
+/// };
 ///
 /// /// Registration of e.g. a class device, IRQ, etc.
 /// struct Registration;
-- 
2.51.0


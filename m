Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012041.outbound.protection.outlook.com [40.107.209.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D922748B39C;
	Wed, 21 Jan 2026 14:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769005482; cv=fail; b=ZslvGPoKmEqQDwI6nvb7oyz9wxUCP44p9KHtV/bEzMbNRQVfn46P3r0Fx9Gk83jiPYliLxJqatDspOMaXTA8GYfQDT3LpF64XG5eS84UVL1/AKmdtaIex/MVW8iSROqOaBQhv8PNDalJZG0C26OTWk35zj7Ovm48EO7dgtR5nqg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769005482; c=relaxed/simple;
	bh=Lxj4PkBapAtBNnB2X0r047B1aw4vPK6YYG+v7Ht85A0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AN9ob+qI7hIS4kEnTgcLQ6aFWxlCz0YFjG9K8Z43nQFz8RY1mHmcVWcGTpqwLuhAbNayzgLriNEYsJlKZ7RtvuxmmIKOc3M68r/BfUvlK0WpcKGO4x5+/c7DTJbpzlt+HCyAMOWsRqcuRdVXLtRlXf5mfxV8nlHiy1O52oca7q8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Y8tYoPJE; arc=fail smtp.client-ip=40.107.209.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Y8tYoPJE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QixhPyaI/DnATTS5rzx5jx0S0LersfSvn4duuZCKiElqq6bACQ7Ys2FysH7i9+sX9JyL34yvH0L2mDboO3+N3hYTTYpnKGTcvb/ebhnxcbI8B+3e0+VzvlyAG2E2EeX1Dpf571fV92DcBq4rS14L4t60LA7aRk8ADJeB1ZKcFPhCjDa1PR+Vvaot0PVoDo2XBf8wExB6X/MddevfYfn+npNOuCl+0AxAjOY4qrm7L7jZHsjG0ImRr9pMg56gfzSMDN2TK9PMvVyXnXKCk1YaXCMrxHU2fIr8eP6a900lNH7T5Y2+WREpT2/3i/A3/js8SkNVUGfyGDz2K0KqNwv41w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PVr6029GJBT27W7/udV0dd+wNmZk+pMBNPRUNVuJAYA=;
 b=OlUq2j6r0UuUtWYN+lbdflCkfmHLcdsng99K6KxNPZYvtG8a0DuM6UWYIbnLcH44Y0aZuBg/XGxceVEjQqy8bPdiGmZ2Y4kAcoCGeFV/Luli4ZE4VMEDqFratjFQZUDX3sXzCGa8GYolYhTcVmeMTTkof+gbD39o/ZjIiyy4amQ9ZFZ+nuQfE0aBb2DzD7Df2+N+yKL2TngB3FC1KoeMPLCRmZgsRp1wco4RrspauMOItLjUubsQxvf/a4EqiFRxvII21OiYK9ZcxVYsjZKS+3ZPfRJFoyxh79TmLqOoGsmXhyWVEkl/lag84tHRJUjv7HqQ43Pi4FpeMsZNDqnNvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PVr6029GJBT27W7/udV0dd+wNmZk+pMBNPRUNVuJAYA=;
 b=Y8tYoPJE97cV7BU52jfm7AxC23aGchsBthhdY43cK90NBoAMQH3GYNWo08ksDhxNcCmNKrEaXXn6Hmf97lGtPAcEGUsywiFnzn8EeLhE/C64vmWy6xJB5849qvxtPq5vks9AXVBgfAuCEaDOIgoZPhGuEmNQX3FXsmoB1Ow6MsDq1Rt98QYnVJnNkNxb5XldB2PGts396eaf/NvOghB0M1jEmT0hH4+R8eHuFhVThfnTRHrDnnOOjuW+zAxq7HdJFkj4fLyhY74BVG47RYLa7rCAE8VUe064Ek8Rs/GxBQODwEddoRzaGnckFy/xydyItEpHoTES6ds9VsW3k+6LIg==
Received: from BYAPR11CA0067.namprd11.prod.outlook.com (2603:10b6:a03:80::44)
 by DS2PR12MB9664.namprd12.prod.outlook.com (2603:10b6:8:27b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 14:24:33 +0000
Received: from CO1PEPF000075EF.namprd03.prod.outlook.com
 (2603:10b6:a03:80:cafe::f7) by BYAPR11CA0067.outlook.office365.com
 (2603:10b6:a03:80::44) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.10 via Frontend Transport; Wed,
 21 Jan 2026 14:24:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF000075EF.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 14:24:32 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 06:24:10 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 21 Jan 2026 06:24:10 -0800
Received: from inno-vm-xubuntu (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 21 Jan 2026 06:24:04 -0800
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
	<daniel.almeida@collabora.com>, Zhi Wang <zhiw@nvidia.com>, Miguel Ojeda
	<miguel.ojeda.sandonis@gmail.com>
Subject: [PATCH v11 1/5] rust: devres: style for imports
Date: Wed, 21 Jan 2026 16:23:50 +0200
Message-ID: <20260121142355.4761-2-zhiw@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260121142355.4761-1-zhiw@nvidia.com>
References: <20260121142355.4761-1-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000075EF:EE_|DS2PR12MB9664:EE_
X-MS-Office365-Filtering-Correlation-Id: d318538a-45a1-4f6f-d46b-08de58f8cbc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9D+Hg4sjkx86h32PqTWJ9ErouQBj9BaEbTcm+lY2CpS3z/f+Fzdq0SFswJ2t?=
 =?us-ascii?Q?RGXWBw80kDBm3CCtiOWrAKLoxkNlQi6JWXsOPO2aw5g/6fc6xAMrD4ls57YU?=
 =?us-ascii?Q?E/u9qkHBpMEQj7qH9L7Mh0tiwaJJTmhSdJ8Lj0YL2hQlH7aLF9smXQ04lx1x?=
 =?us-ascii?Q?0G9jp8GdchO7939aOO8fQuJIm70rZ0ni3a4vygus00EQdhfLf7jz85uIEzYx?=
 =?us-ascii?Q?Qs0idhLqHDb9UjO6U/QcMINm9LzEvuyelG0fggg7p8cN3Wm4oGxn+9qbd2gy?=
 =?us-ascii?Q?MQUnxMwAecREjUUmKa9c9icaiQfINHiLNNbsVTFZQcipj/rJU7mp4fGApHuk?=
 =?us-ascii?Q?oDRJWyxMQFiFOgq4BqFROaaalyvGB/mu1jmpTfnCBw+xEsfieQgWAo9wkJpI?=
 =?us-ascii?Q?hI2ZpztXsJphLUNKSmKSDD5PeKXbL0p8mwd3DiqKfcUGTsHbvmRWat784BaG?=
 =?us-ascii?Q?oSqDFWVUIpDETYrptlDMyQvSXiYB0AmZhMlvOTtL2aDzQKSAczLml5QbFSVq?=
 =?us-ascii?Q?ee5aJDrP1e6AlNjVoqZMOzYxKLqfQLykAxJq+EJkDqXjE0QLylZqx9PK+Vgc?=
 =?us-ascii?Q?faq3/aOVljhTl0vlNJlAjvri9ndhW1BMPma9yJzu0SY0GwChIZ4oxi9Q0jjV?=
 =?us-ascii?Q?pC9jYoBrIUs/Mbv3nCGsMwC7+yLh8S5pv5smarr/FRRUJS7ebTFsI7zom987?=
 =?us-ascii?Q?v8V2kcC51a5wYnWwmhqLx464QrvJWmqHOJnfNZrIHVb4WF1Jiy8FEfjPhH61?=
 =?us-ascii?Q?hCd9+jp9UlZo7YvycWcd8uksUKd5DEN3QOxPSTpClrsEzXY3kpGBCsay3maT?=
 =?us-ascii?Q?OEHKwzON03fCLfyQyHdgIy4Y2aWwUEKLqH8hpy+3Pr3KrYoSmxGdX6CqkxdY?=
 =?us-ascii?Q?hj8NZ0RPcihnwTuUETTBA149gyDol63ABwGk8I3fa+dJMTN6S9n7kHuYgWXS?=
 =?us-ascii?Q?hJQF13GWnIZ6Ruca/UTFC1Q17R/tElKPTXiEPwLkFCeisT3ZZgFBWr+n3mbd?=
 =?us-ascii?Q?FcZg5pzwNTjNrHXvagFXCp2/9OQYwTYTtTtV1UMzPuF+vS8XcwurixiaGU0G?=
 =?us-ascii?Q?tBltSLwf7Y0da/1ESuzqYAVcv6zy2cWurnLZYOJY4jNKhuj9Qn5InQ99Z2gM?=
 =?us-ascii?Q?z6/kk3amh4uSw5myLJtMPVOo6GMV7gPxSq6PPGjREpPk4rlWoXN55EDiAEtD?=
 =?us-ascii?Q?7AgjgDjw5J7X5QiEOsAx5Ia4MLruz9CuBPNcsR679Q8/1LlL/zCMRAo3KhBM?=
 =?us-ascii?Q?W7FjaL3vuRo6TqP835BTBUjC1NZwx8oIMjgipt9IzZSC/3M5nUtcTeGLmE5t?=
 =?us-ascii?Q?DQ9DKQGTB5Oa1C9QMuwx0o3QWlzyQxGfK6kdRIqOIMv6isBcenspfdrS0r05?=
 =?us-ascii?Q?wMM4g/VW8SEiHzEA1qHZz0MpGuenDvj+7dkvVtJwDbNz73xzbSXdVsaK0w4W?=
 =?us-ascii?Q?O1LWUyrf1WJxUuZoXK01L9Jxeo0kyc8fZe2qzFMv17/KWocZjJg6IB9kHk2V?=
 =?us-ascii?Q?RMeg7IhYRtw8hwELkoSJ3CgmBp40yLwrH7rTKSJNDzsKB2LoxtdufDouUNMq?=
 =?us-ascii?Q?KaG7kkCcXbNuczg9KkuYy3+GW+SqNFv3DyuVWKfWt2Zu3V2XZ1dZSjVTo4F1?=
 =?us-ascii?Q?kmS11ANvD25tB7GJsYozK5fGU8nLdvmR6hW1ifZzpolgRgFg+Suc4AC9Vy7L?=
 =?us-ascii?Q?vQVdhA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 14:24:32.6120
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d318538a-45a1-4f6f-d46b-08de58f8cbc4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075EF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9664

Convert all imports in the devres to use "kernel vertical" style.

Cc: Gary Guo <gary@garyguo.net>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
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


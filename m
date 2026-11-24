Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795529050;
	b=cP4hUzOwVOcX/S7Jx6F5reKnncxSTDZ5yXXYWLDCvJwCs1d1NsyLM+2+7XJort+3OjYP
	 Ynm4t75GgiuO1HSYzPHzMgSW1YfR39mV0DNPiz1nMgebMYnW5ncaplTbXytWnVwq1Wxjf
	 FNAPW0bEy1nxDdto3vEZwu9rb9lEDOPht2Xm3jL7GHC04LO5fVvAxYA9yzcFBIm5BGzf+
	 gGKp5gNY+xVpd7Xm2bkZ7tnbTNmg7veRDMMG5H7NEclFIx5VH+V3hGPqb9KBcIv80soZd
	 1mKKw/wipzB16sOYy15oTVkCb6PtzLvC36iSTIqKUYCw4KBkya6hdcZhOQiUBdKS0qQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795529050;
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
	bh=btgtIlwqqRrX7HH12xY6Jvy/Ercje2ISEFpewqk+x2w=;
	b=uiuk9j267s7PzfDE+xk9REbwH9rCMMcDV+DJ7/xfTX40yMDH/74S+YOuewG5DtXfG+TE
	 e/L46y8ThT/11kRKUnb6LqfiI2Y23yq4OAIZ4DhD/LA9Zb5IRwF5OG/7EXq04cK1vgL/7
	 JyImzuWBovy/oL1pTwdCouZjdVoZLJYF3Jhgzr72AYeU569dBbQ36J3jaiOFdwUt6X3eZ
	 gzoegzqpi7OBM0oPO1Hgw4JjGbd0+TVltoTrOTKdAkbLXRDXIWyYSFlZLlOfV/bO3x37X
	 4g6TzVpzr90bXpwbjK01lOf4c4OLZSHgIzE8fhm5+k1mJvvlu2dq4rT0e7F+/3uvGSA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Drulr5Rt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.43
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010043.outbound.protection.outlook.com [52.101.56.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237B9606A32D;
	Tue, 24 Nov 2026 14:04:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 237B9606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Drulr5Rt
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P1sclqkF8jyhp6tdDQph/6V269++keOGwGKhbC3N9PyQcP50kZk9SXFeCXdIhbW27OyO3VJjmHgoTFRN3fqNVH3J/YdaismtFmrlcKCr9GeqlnTbDCWnfmKY7UCzfofIlzeZWr/83pF5KgNWgY9EDMpsf0h+rSbVC/8Itt7B9mMl575VrrqEBigJ+1ww1diKu5f7PDuT4I/7UAg4wcffyvc9KtRVFwQ+tKQOO5WzuGUr0buxfFZzcOU4o5JNVC9XE4ZMCFIbyLWlJ17tlatDHLIiGGkHSrCDJoMvsCpEc2RwSlQml90MCMImNGWkgftDPYy3KmYBRWCg3nmgeH+49Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=btgtIlwqqRrX7HH12xY6Jvy/Ercje2ISEFpewqk+x2w=;
 b=IzVvbjklseNheVwANgROZeIRlOdvCTgkf20mWhS0Sxzxh0TK2GwPg9zRpRarjUorHStfm7LKeNS3PP7a0VYGKYF9ZKvhZWUV2wbdmsMydOae1mbXHpN25fhnM7HYRlaZp1j/Pov8CqEsbWxXmIHgI6Gz/Sx8hIm96BYIVXhc4536Y6FRhG3xwSielfFV5hObKi1OlyhyRU24yPJdHS3gnzrSfMK2kvvYjM/PD5eFtah55uxS6Ovxv43/SEnlb0RDETIGWvTV/W4rpyoxjhzZEBcRRuRJWfSNvYNMbz0gmiA0xWni/iZPMYy0XgKQP1t9TsJ4+FLeSoLxDpUvTMB3cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=btgtIlwqqRrX7HH12xY6Jvy/Ercje2ISEFpewqk+x2w=;
 b=Drulr5RtKPCDIPf+Js4wL3J/7oBPuGWpuG+Y6P1Y0I74aKMUVPL1l9RWLfOENR7oMJ9U3jDa/10SsTjnEq4GPg7p9ItohyLXscgLPJLwOo4PEVZlbZKPAVmpIHh0BWflJosTCoscAWrByEAMYTHzH/X3swzv6f41QIierMNMWlEHOOUrsn/RiBoJNIUYrI3+8jH92ROQ1bwPbHLAh4lvF3XNxoxVbNXptOPB2lDfggKQVZbzOfhgl8qBjnR3MxS/ZoaA1O0fzwi95aJaydhy0O66qiK0YJ5Y2OcZxOZQbfo/IidxqjnJMoTRoRO7JfJCHu2aYEpxY980+IGXfrYvFQ==
Received: from CY5P220CA0006.NAMP220.PROD.OUTLOOK.COM (2603:10b6:930:ed::17)
 by IA1PR12MB8357.namprd12.prod.outlook.com (2603:10b6:208:3ff::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Tue, 24 Nov
 2026 14:03:58 +0000
Received: from CY6PEPF00000047.namprd03.prod.outlook.com
 (2603:10b6:930:ed:cafe::9) by CY5P220CA0006.outlook.office365.com
 (2603:10b6:930:ed::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.6 via Frontend Transport; Tue, 24
 Nov 2026 14:03:58 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY6PEPF00000047.mail.protection.outlook.com (10.167.247.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Tue, 24 Nov 2026 14:03:58 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 24 Nov
 2026 06:03:27 -0800
Received: from kalok-SPC741D16QM3.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 06:03:13 -0800
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
Subject: [PATCH v5 15/35] gpu: nova-core: mm: add SharedGpuMm
Date: Tue, 24 Nov 2026 19:29:11 +0530
Message-ID: <20261124135937.18583-16-alkumar@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY6PEPF00000047:EE_|IA1PR12MB8357:EE_
X-MS-Office365-Filtering-Correlation-Id: a673e464-97eb-4725-6adf-08df4a33c8b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|82310400026|7416014|376014|1800799024|261026121527099003|10067099003|11063799006|56012099006|261028144727099003|261021123027099003|261021121427099003|261022105027099003|261102123227099003|261026140227099003|261009223027099003|22082099003|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	dIGVpVh3wkgyNny7vsfPlhTxaXtXb+dryOsdEZp2pSam7IfybezfgrJipYG9LwO8KDk2aiuOP5Y5Nc1IFL3W4vtVPS5+mvHgzHkLbs6hSLvvLBk7DRmpjZDIwGU/KVrn473VEMq9R0ivpeNT7GkHdkTyrNYP+YzafeEt51iWMCf2vtAfsmDL0wxZ89f2HLIayjSXWugs56H2PEraAa/fxeAkvXusV1irM5ZFThOV8lps7LSu8DekwKeDFA+ciMNlyBSh+vkpx0qWpYDIWTdDOt7kTsj6KBN8UaR3wXTREhWi8htF4dsQDhQZ1Knj0YPcrR8mikuQGHWxp80q42ek04KBrkH5OxtlCUxd/0PE7raJQH61Btt2mRu65RyDfNQJOwoTM7WcEwr8Vi+d9bU7/HLcWP5xuQLZS4rWt+DsN4yI41S4KZQ9YWoy2htlss/7hRCmVe7fv8iqRXQolWYfL2rpmgwkp5tIJis0V34kreHddvV4tdEpTg7gU5Rzys+iYMIMnezYuw4+kum8VGLiH2eFT/rrB3F9Mxm7/wBn/XpW5LyAt38xpBSyno1dQpbhr2JxtdxDcdHbHRZio1PIsHlKGoIHL+BDcZIjKrwbvWkEChYA7QB2OiFL0uHOE2Wri2f2H7lcEX0fW3pHNTyDuNTvi02kBDNFHb4fwnwyv/mr9yRMIDB2zeLuEMZmUGUzE4LkhjqWfrsX2Y7lRoZqGw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(82310400026)(7416014)(376014)(1800799024)(261026121527099003)(10067099003)(11063799006)(56012099006)(261028144727099003)(261021123027099003)(261021121427099003)(261022105027099003)(261102123227099003)(261026140227099003)(261009223027099003)(22082099003)(6133799003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	vHfLtvyM5njkm3oo674WbZT/3pFI2aGvYSdOdfzRkthJhrcXbwu89ZXFYdUSr4qlzhVT6mxGuvRu5ui3ppgiHdKXiqZv1PB00udtRsbWnjb2fn91IPMqdEa1r3DpX2h1fqJaD74LcKKZ3wQaTm7adfIXkpBWUo1Z+Gmi639flgb6jXP4HQYkUGn+4TkFnj9Ffe91aTzEk14qYLaHfPGe+0z3C+PWfrW4Ang1vfSTOmypT2e0oTMoTSvkN+4TwwdaqU32JmH1Qh/6DB5ilR/7tXy5H90eP8ZPK7fBJCGnYQE8c3daM+4vgQWfZX4d5R4qKflH1YOgAZbarlNDmSBHo3HILlmTmwDNui4KmJwWf3RgYByyz58YjLvweqmJe0K0FkBXCWXg2a3GKxxC0CdFziUBNMbTdBCCo+akoH0Mzb+zTHBKRDAOrHWOn5eeGIhk
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 14:03:58.0234
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a673e464-97eb-4725-6adf-08df4a33c8b3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY6PEPF00000047.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8357

From: Alexandre Courbot <acourbot@nvidia.com>

Share the memory manager through `SharedGpuMm`, which hides the mutex's
invariant resource lifetime behind an existential lifetime so that it
and its users remain covariant, like `Cmdq` does.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Alok Kumar <alkumar@nvidia.com>
---
 drivers/gpu/nova-core/mm.rs          | 31 +++++++++++++++++++++++++++-
 drivers/gpu/nova-core/mm/bar_user.rs |  9 ++++----
 2 files changed, 35 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/nova-core/mm.rs b/drivers/gpu/nova-core/mm.rs
index a0aeb96bfa36..d4cba022ccad 100644
--- a/drivers/gpu/nova-core/mm.rs
+++ b/drivers/gpu/nova-core/mm.rs
@@ -44,13 +44,15 @@ macro_rules! impl_pfn_bounded {
         GpuBuddy,
         GpuBuddyParams, //
     },
+    new_mutex,
     num::Bounded,
     prelude::*,
     ptr::{
         Alignable,
         Alignment, //
     },
-    sizes::SZ_4K, //
+    sizes::SZ_4K,
+    sync::Mutex, //
 };
 
 use crate::{
@@ -117,6 +119,33 @@ pub(crate) fn tlb(&self) -> &Tlb<'gpu> {
     }
 }
 
+/// A [`GpuMm`] shared between several users, serialized by a mutex.
+#[pin_data]
+pub(crate) struct SharedGpuMm<'gpu>
+where
+    // Hide the mutex's invariant resource lifetime so `SharedGpuMm` remains covariant.
+    exists<'res>: 'gpu,
+{
+    #[pin]
+    #[uses('res: invariant)]
+    inner: Mutex<GpuMm<'res>>,
+}
+
+impl<'gpu> SharedGpuMm<'gpu> {
+    /// Creates a pin-initializer sharing `mm`.
+    #[expect(dead_code)]
+    pub(crate) fn new(mm: GpuMm<'gpu>) -> impl PinInit<Self> + 'gpu {
+        pin_init!(Self {
+            inner <- new_mutex!(mm, "nova-core::gpu-mm"),
+        })
+    }
+
+    /// Runs `f` with the memory manager locked.
+    pub(crate) fn with_locked<R>(&self, f: impl FnOnce(&mut GpuMm<'_>) -> R) -> R {
+        self.with_inner(|inner| f(&mut inner.lock()))
+    }
+}
+
 /// Page size in bytes (4 KiB).
 pub(crate) const PAGE_SIZE: usize = SZ_4K;
 
diff --git a/drivers/gpu/nova-core/mm/bar_user.rs b/drivers/gpu/nova-core/mm/bar_user.rs
index 243f8739dfe6..75970cb0b5cb 100644
--- a/drivers/gpu/nova-core/mm/bar_user.rs
+++ b/drivers/gpu/nova-core/mm/bar_user.rs
@@ -26,6 +26,7 @@
         vram::VramRegion,
         GpuMm,
         Pfn,
+        SharedGpuMm,
         Vfn,
         VirtualAddress,
         VramAddress,
@@ -178,7 +179,7 @@ fn drop(&mut self) {
 pub(crate) struct BarMapping<'map, 'gpu> {
     /// Mapping of `region`.
     access: BarUserAccess<'map, 'gpu>,
-    mm: &'map Mutex<GpuMm<'gpu>>,
+    mm: &'map SharedGpuMm<'gpu>,
     /// The VRAM region that is mapped.
     region: VramRegion,
     unmap_error: Option<Error>,
@@ -189,7 +190,7 @@ impl<'map, 'gpu> BarMapping<'map, 'gpu> {
     /// Maps `region`, which must start and end on a page boundary.
     pub(crate) fn new(
         bar_user: &'map BarUser<'gpu>,
-        mm: &'map Mutex<GpuMm<'gpu>>,
+        mm: &'map SharedGpuMm<'gpu>,
         region: VramRegion,
         writable: bool,
     ) -> Result<Self> {
@@ -210,7 +211,7 @@ pub(crate) fn new(
             pfns.push(Pfn::from(VramAddress::from_raw(address)), GFP_KERNEL)?;
         }
 
-        let access = bar_user.map(&mut mm.lock(), &pfns, writable)?;
+        let access = mm.with_locked(|mm| bar_user.map(mm, &pfns, writable))?;
 
         Ok(Self {
             access,
@@ -250,7 +251,7 @@ pub(crate) fn unmap(&mut self) -> Result {
         if let Some(error) = self.unmap_error {
             return Err(error);
         }
-        let result = self.access.unmap(&mut self.mm.lock());
+        let result = self.mm.with_locked(|mm| self.access.unmap(mm));
         if let Err(error) = result {
             self.unmap_error = Some(error);
         }
-- 
2.53.0


Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.61
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795528975;
	b=pY7NsZnTnSCixdwEyfv+/44qslfCmoTX9/M8TgJLjsmQEGJqHtR3Te2NQ4ySwVkAHzUc
	 bb8isU1q4zfwFRMd6VN60nIP//ltZY+tyXV0UyDS2jjEBZnrA7/i7rvh0MR8As9oE4jh0
	 7RgOWSDiKNSQh6LOXelwkchckenIosEELza6lqeNzdog7rW+XNrWw+vroO4PfPR9QBUbB
	 x/Nrgl+VV/4JYPLb4ZmZOshZcvXkMxErSZuwy0VCqBV8Y5J8wVMLGu2ECGeFsHf2PrbMp
	 IUUl5eYPfUb4d66mut5muqmdxNbCLOsSr+L5bbe4INFGOi8ChEJ8qiFj7tqRkqdm7Ew==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795528975;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:
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
	bh=jczDwmFJMXY8TcGYl+oMfA1gSyW0uQZakUGP9vD8mhE=;
	b=BA8HTwl2G5ePk3DM16apNBVd7UR1MNCTYTypHtmcr3YjS5h716ooG6jmdOe7Wf0mkZQz
	 ZErBONq64fRGueY4yMOUDaAQ5gIaAgcjH9kuWxApNtopu5pB6S0c51EgR0r+QNkQ4iBpJ
	 IkYz3+HJcG/GXvJGshd2dUpKHf8w0N9ernECSyXi3rngeIgGfaUbC5YEgdrgOQupuavIL
	 vdUJTkUzQlimiQWkT80cxugL/WoHxpPrNAcU3dizeJOgMFEhk54sE9o+N68KXbMT+iROC
	 j1Tl5iUsU7LCQ+xI6vjktp8i6570edpCWKxwLt0rTPTFNpyB8PVNBT/RV4V6lpMAVfQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=gKm6NOxa;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.61
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010061.outbound.protection.outlook.com [52.101.46.61])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C14606A335;
	Tue, 24 Nov 2026 14:02:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2C14606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=gKm6NOxa
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XPfQ6w7vtYErid0PUDm06k2iLplpUe5srNMPnXThiH5+JTzntfxjIX9TQACOenvxX8/Rpitu8nrhqWcUEA82tlJHT5vFA/SpERBbDifI6lUdLfdfM9LjHarYozKO61WRkJxactMcx1y6IEJK6Ag30AoRxCl5GdDZ2CRX1RSe9DbcoQmxeQvg15tktYqtmMktg6aqwiB8BuAvWa3UlDQkTGAxglzYcLcEYB9AnTRYPPgGfXbeGsrfRVIfuulVINIx/qLo4cfrknU0QZfiv54hisYgWuACLluEl9hBAgE5gC85BqBnKWfy1Qa3SMbDLQ0cjbzMDjYw16BT+NtdbSBwTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jczDwmFJMXY8TcGYl+oMfA1gSyW0uQZakUGP9vD8mhE=;
 b=IWkOKhrn0ojYy0X54n1Po3pvX8baIEjabIG4TffvZX5zZY59NSU3oktM1qvPKChc+tLzRQbNXSCY00lB3TUGm+LPBQ+/Zhsk+JQANvOAZsCmjQVPa0/OK1zfYmNSa2/5aV4L7CYJTt9m82RheCiD4ag3j6YCYvRaKwTVY3hn8eXREbjAPWWVjMekP+qxtD6vgpDFTJ4RR3a3UJgoIRm2Cgb/nJkMTcJAW5scx02WFKVjxjXBq3tqrre9GPj+19Yl9n1tZFEDy4bVXiJX7NotGChHshU8etrsFlYoLG6DTzNcngLTruFZBeq30x0cNG6oue4ihKsdHV2RIj9mceUaqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jczDwmFJMXY8TcGYl+oMfA1gSyW0uQZakUGP9vD8mhE=;
 b=gKm6NOxadfkHWkbVWkcjwNMc4QCTAJnW/BixtX1cVnr7uDoxWXgSLvuRPWtGMOVvMVROyd3fM3iJC31VVVr0WwxVu87MXXgak+bg7SCGJPw5Pj6oWNrmxLqp0iOME/VZsRXnxGVZ3+ZXxrk/gVWD8HVxJ+ijhp2mT6GqtmvIJrdA4YieWwtqJx2ivZwj4botUpQ+GdPW0hHexvsDmSfLd/gd0baWSJMGS1pQbn8uckvhDBKCykl4w6rZN3Pts2AVUSevtKYNdGzCsNLUp0db6n+wsDhiSPs6PeiNiLW9t3zE6xQzWAiI3s/Fd3MszfoDVykEdHCRJbn/FNxy7GdCRw==
Received: from DS7PR05CA0022.namprd05.prod.outlook.com (2603:10b6:5:3b9::27)
 by SJ1PR12MB6363.namprd12.prod.outlook.com (2603:10b6:a03:453::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.5; Tue, 24 Nov
 2026 14:02:47 +0000
Received: from CH2PEPF000166BF.namprd04.prod.outlook.com
 (2603:10b6:5:3b9:cafe::7a) by DS7PR05CA0022.outlook.office365.com
 (2603:10b6:5:3b9::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.6 via Frontend Transport; Tue, 24
 Nov 2026 14:02:47 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF000166BF.mail.protection.outlook.com (10.167.252.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Tue, 24 Nov 2026 14:02:47 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 24 Nov
 2026 06:02:21 -0800
Received: from kalok-SPC741D16QM3.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 06:02:08 -0800
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
Subject: [PATCH v5 10/35] gpu: nova-core: mm: retain BAR1 reservations after unmap failure
Date: Tue, 24 Nov 2026 19:29:06 +0530
Message-ID: <20261124135937.18583-11-alkumar@nvidia.com>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF000166BF:EE_|SJ1PR12MB6363:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f97202f-be76-439c-dc63-08df4a339ea1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|82310400026|1800799024|376014|7416014|6133799003|22082099003|18002099003|11063799006|56012099006|261026121527099003|261026140227099003|261028144727099003|261021123027099003|261021121427099003|261022113327099003|261022075727099003|261022105027099003|261021135927099003|261009223027099003|261102123227099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	AMPDF5kdCiUQ5sWdcVonGYOnoOAGH/tK/C1+DRZoHXZvhXVdWe15JS8ApsXgRl9YsvwSUvvN3PJ/fV+NjokiRkm292eqQ6NETMNtW1NOR43t2DQiVZameLNwfqMTocHaWzcpwb0jXv3zII9cPqhDm6gIZpAwfiPTh3cgajokuGVihF1HoeWNor0sLhTdVRAhI8djjsQK2N6XCNr9n5EVU97c0pgwL01xsNlJIhnfptU04Xp8r0cFn1ZnkZSu/wl3R7ppQKqYqKcbAyP1jST3BYU5WCpK9v4kFrAeq+SgVJaAS/PK48o/McxjCKxmeUcZFcgMGPvg6oSLL/EWh4xzz2k0fJ5dMth2iSGCcYu+noXAfjeUzv3x2EP7ScUhSIIHnOejqFHmPOahuX0c1r/6POYFcuVpVt+Kavk/P/6RBRmkWki7Lx0fKMmWp99gb8YG6AeOmJ+ErZfqVAcGFc6pFF9AJF75rKVhb592WhHEYa8cVM9k+rdEH3gFg22BSPb5a9uMTAGDGbcSZu4ywnVsAReBXpIkl3qR0tca19E8+dhDyoKmM9Xv2pgrdQfrEPRezBG64Xf9g0xKddbp+1+hylWK3kncTIF5yqB0redfVUX+C43HQqnF49t9jRGs+b19vuN3ANffiOd3Od1DIYN7Uc0DMqO+HmxP528qLLG46FBQE/Moz7nXogGi1KnCF9nAQKNAMJbuT/E8LKS0ZOq5Rw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(82310400026)(1800799024)(376014)(7416014)(6133799003)(22082099003)(18002099003)(11063799006)(56012099006)(261026121527099003)(261026140227099003)(261028144727099003)(261021123027099003)(261021121427099003)(261022113327099003)(261022075727099003)(261022105027099003)(261021135927099003)(261009223027099003)(261102123227099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	44BQquIs0v45pJUlMUqESsVg36/gtlPXGbwHWcOAC4CQ0P8K1mFRUOgkpw4tnXhkqOh9hU+0TJH//WcLfOUGRbMLBQKrQjzmfmp3jI5fWjbIYifqL3kCugNWTVj04Ffd6bThG+09vLAEt4nHtnZhKUpxF/Df61nvy1DhIlDxnOESnNtlYTarobUeKGCxoNkgAHmHmyfrmc37pFEo52MNynslesVUhC9wftqYH2d58FHbGDG50vYnvgZR2ftLyT8FuR5ULTERKako9WRSf/eYq4VMsj0Q6fQq7i4H1/RaIs9dmT3AhOtNCsh5iDTHYhchqWRldSqqWuUKX7tfaxcuvPYpWVNnQj/S7tkb/mzT50H9rGc26EcuiZ5n/KzBRCiBOk1PTZvn30aMpJb7gUXeu8jnQ4MLn+2giQaITbku0L5Tclf8PdlLeOTPreAHyVte
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 14:02:47.3991
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f97202f-be76-439c-dc63-08df4a339ea1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF000166BF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6363

From: Zhi Wang <zhiw@nvidia.com>

Vmm::unmap_pages currently returns a virtual address range to its pool
even when PTE invalidation or its TLB flush fails. Hardware can still
use that mapping, so reusing the range can alias a live mapping.

Borrow MappedRange during unmap and release its VA reservation only
after invalidation succeeds. Disarm its drop guard at that point and
reject a second unmap of a range whose guard is already disarmed.

Keep BarUserAccess's mapped state until unmap succeeds, and update its
callers to pass a borrowed range. A failed unmap leaves the VA reserved;
callers must retain the backing storage while hardware may still access
it.

Extend the MM self-test to unmap an old range after its virtual address
has been reused. Require the stale token to fail without invalidating
the new mapping.

Signed-off-by: Zhi Wang <zhiw@nvidia.com>
Signed-off-by: Alok Kumar <alkumar@nvidia.com>
---
 drivers/gpu/nova-core/mm/bar_user.rs | 35 +++++++++++++++++++---------
 drivers/gpu/nova-core/mm/vmm.rs      | 18 +++++++-------
 2 files changed, 34 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/nova-core/mm/bar_user.rs b/drivers/gpu/nova-core/mm/bar_user.rs
index f82372ccab6e..5a8770782d14 100644
--- a/drivers/gpu/nova-core/mm/bar_user.rs
+++ b/drivers/gpu/nova-core/mm/bar_user.rs
@@ -87,8 +87,7 @@ pub(crate) fn map(
 /// Borrows the [`BarUser`] managing the mapping for the lifetime of the access object.
 pub(crate) struct BarUserAccess<'a> {
     bar_user: &'a BarUser<'a>,
-    /// [`BarUserAccess::release`] [`Option::take`]s this; `Some` at
-    /// drop time means `release()` was never called.
+    /// Cleared only after PTE invalidation and its TLB flush succeed.
     mapped: Option<MappedRange>,
 }
 
@@ -96,16 +95,22 @@ pub(crate) struct BarUserAccess<'a> {
 impl BarUserAccess<'_> {
     /// Tear down the BAR1 mapping.
     pub(crate) fn release(mut self, mm: &mut GpuMm<'_>) -> Result {
-        let mapped = self.mapped.take().ok_or(EINVAL)?;
+        self.unmap(mm)
+    }
+
+    fn unmap(&mut self, mm: &mut GpuMm<'_>) -> Result {
+        let Some(mapped) = self.mapped.as_ref() else {
+            return Ok(());
+        };
         let mut vmm = self.bar_user.vmm.lock();
         vmm.unmap_pages(mm, mapped)?;
+        self.mapped = None;
         Ok(())
     }
 
     /// Returns the active mapping.
     fn mapped(&self) -> &MappedRange {
-        // `mapped` is only `None` after `take()` in `release`; hence unwrap()
-        // cannot panic here.
+        // `release` consumes the access, so no accessor can run after successful release.
         self.mapped.as_ref().unwrap()
     }
 
@@ -158,7 +163,7 @@ impl Drop for BarUserAccess<'_> {
     fn drop(&mut self) {
         if self.mapped.is_some() {
             kernel::pr_warn!(
-                "BarUserAccess dropped without calling release(). BarUser address space will leak.\n"
+                "BarUserAccess dropped with a live mapping; BAR1 VA remains reserved.\n"
             );
         }
         // The inner `MappedRange`'s own `MustUnmapGuard` will also fire,
@@ -259,19 +264,27 @@ pub(crate) fn run_self_test(
     };
 
     // Cleanup - invalidate PTE.
-    vmm.unmap_pages(mm, mapped)?;
+    vmm.unmap_pages(mm, &mapped)?;
 
     // Test 2: Two-phase prepare/execute API.
     let prepared = vmm.prepare_map(mm, 1, None)?;
     let mapped2 = vmm.execute_map(mm, prepared, &[test_pfn], true)?;
+    // An old token must not invalidate a new mapping that reused its address.
+    let repeated_unmap = vmm.unmap_pages(mm, &mapped);
     let readback = vmm.read_mapping(mm, mapped2.vfn_start)?;
-    let test2_passed = if readback == Some(test_pfn) {
+    let test2_passed = if mapped2.vfn_start == test_vfn
+        && repeated_unmap == Err(EINVAL)
+        && readback == Some(test_pfn)
+    {
         true
     } else {
-        dev_err!(dev, "MM: Test 2 FAILED - Two-phase map readback mismatch\n");
+        dev_err!(
+            dev,
+            "MM: Test 2 FAILED - Remapped page or stale-token rejection mismatch\n"
+        );
         false
     };
-    vmm.unmap_pages(mm, mapped2)?;
+    vmm.unmap_pages(mm, &mapped2)?;
 
     // Test 3: Range-constrained allocation with a hole — exercises block.size()-driven
     // BAR1 mapping. A 4K hole is punched at base+16K, then a single 32K allocation
@@ -363,7 +376,7 @@ pub(crate) fn run_self_test(
             }
         }
 
-        vmm.unmap_pages(mm, mapped)?;
+        vmm.unmap_pages(mm, &mapped)?;
     }
 
     // Verify aggregate: all returned block sizes must sum to allocation size.
diff --git a/drivers/gpu/nova-core/mm/vmm.rs b/drivers/gpu/nova-core/mm/vmm.rs
index 51b500a27233..49b1e5db1498 100644
--- a/drivers/gpu/nova-core/mm/vmm.rs
+++ b/drivers/gpu/nova-core/mm/vmm.rs
@@ -324,23 +324,25 @@ pub(crate) fn map_pages(
     }
 
     /// Unmap all pages in a [`MappedRange`] with a single TLB flush.
-    pub(crate) fn unmap_pages(&mut self, mm: &mut GpuMm<'_>, range: MappedRange) -> Result {
-        let result = self
-            .pt_map
-            .invalidate_ptes(mm, range.vfn_start, range.num_pages);
+    ///
+    /// A failed invalidation retains the VA reservation. The caller must keep
+    /// the mapped storage alive while hardware may still access it.
+    pub(crate) fn unmap_pages(&mut self, mm: &mut GpuMm<'_>, range: &MappedRange) -> Result {
+        if !range._drop_guard.armed.get() {
+            return Err(EINVAL);
+        }
+        self.pt_map
+            .invalidate_ptes(mm, range.vfn_start, range.num_pages)?;
 
         // TODO: Internal page table pages (PDE, PTE pages) are still kept around.
         // This is by design as repeated maps/unmaps will be fast. As a future TODO,
         // we can add a reclaimer here to reclaim if VRAM is short. For now, the PT
         // pages are dropped once the `Vmm` is dropped.
 
-        // Free the VA range regardless of PTE invalidation success, so that the VA
-        // range is recovered even on failure (PTEs may be stale, but that is better
-        // than leaking both PTEs and VA range).
         self.free_vfn(range.vfn_start);
 
         // Unmap complete, safe to drop `MappedRange`.
         range._drop_guard.disarm();
-        result
+        Ok(())
     }
 }
-- 
2.53.0


Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793943720;
	b=xqxN2DRHBXDG2irVSAHgjLN771IogiXIdSVsKdCxd3vdVXon/DlgW0E21Wvcs5GhD7Wu
	 25fVfzdQcb6w0SFatERmaXHHeFuvCeHNl1nvpCqoZjGGcf8wXTIIhHg/vATchTvGqgtOW
	 ivH0OO4L69YQRoJC3q3mfTKzXM7zL9wjq3rZY9G73OFneouYaVjCtaYlq2fWPFQ/Hy2SA
	 UR+9r9pZ3nB2+N/QDPqL09GFnXCoiX66lOLp625y+GIWYf4rXi8GGLPKUm7LsSgpUTjWZ
	 kmpt8riaRpiisFeKBG8QsMCpKzOGONdXu4Y/ra1B0a88xRrDJEAv95N7e6BE/3WZ9Kg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793943720;
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
	bh=l1hstpZxf54coPq8UY/WYDB8GE8OTB/9KGafJp9ldQA=;
	b=u+EZ45It8wQ+f1HdXM0r4I7Ls482wstERkhxFHSrft2Oc8DXFrsE4FzUiVlQ/GEx1fLO
	 4Bvn5gFJVjY33nBHUVshZdlLkMTxttbWylbnWLjqh0Sd67Ars9BNSXnBtcNiNaoADLtKc
	 A+wR7VxVk7NxsbXRXWv1S6WpDv7fDOHh+DkgxUc5zdzg1+14P6tY914kjl+NXHpFJa1TW
	 BC6fMiB/emK/8svFoYPEFZP+xUkzO5u7wbo9h6ZMTpT6rxkEVWRSVXY/Rtvkm2HONrlDs
	 YUM9dNTYgOIZga6RLP2rtKT6H1rCBNcTaPqZL3GZKxSL+DEW0h5+rlqRMEm3CqHT8mg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="t8ZWk/c8";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.43
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010043.outbound.protection.outlook.com [40.93.198.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3F7606A329;
	Fri,  6 Nov 2026 05:41:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D3F7606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=t8ZWk/c8
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QYj9v32jbcMj4galPRDnGzQ8mXNNRGaGA21Mo3kH+adCZtAUe36Cgmhz8aEMYnZ9hnEnIVBNnKtxvleERqvsMIkKEZQNI/Z6SCdyJyWKoPVmoOIDdPpjNN/KMnc1TVptkRvWWFSp47oKoSE2gnADYCa4CNlAmzBH3/ZG8Tr2DBOW6xTX7J5Lk0UcvpxLkPiNxIU4uqxR2rdts1ISPoAho4jl8A29aR7ZCnxmzWnEcGiiTE2o7r8ohbuRcbWmGclTKXvovl4eaAh9uws+ppUqeSM9CpfGHVood+PHcwbH8usbcpF+dQbPekwsKutbTOEG1o1dio1UkFNBe8JxYxwClA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l1hstpZxf54coPq8UY/WYDB8GE8OTB/9KGafJp9ldQA=;
 b=SzIZJ1VWtKOfrKD0pAusHYoV8MZsBeq8U8286bQkrIwRK9q8UzSi9nBF2w9NGR0XDWwtoPBhxNiH0mll0JsyezphxyAhJQeB3vWF2ULy5PW+RHXDVQhQv8reI8lFUk1w+ITl33nX+/X3ugisFI/MA2SKndw0/YL0Iyc+Rfaon0x8AWZMIfsdqNw529TNdWFJJhNipAp3QlBUUb7nxDy35z57VVJJcXuCd2oFAzeIWa6+2g3DMUHHE8Vzkbah5rP+fhgxR53kHw7JzuVqwNHq3F4nYOxv3EbnGII3XXnoO3b3stb/WyFPY1k1boWCdAvT8OPF6mgwmexcYuXhRzn7Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l1hstpZxf54coPq8UY/WYDB8GE8OTB/9KGafJp9ldQA=;
 b=t8ZWk/c81Lbu6ZH/gvMpBGUa459YFbJyDRtHU2Et1hc64rW4hOKLHqNFnAfek0wXnP5FDeJj5P7MwO4UuOLBdyRjH1JP1y+Pv+ADdwY0KLbPHkO4Ve/TX4JpedMgnRptNwYzg2JVvU5jASWGTklC9hH+UV6tbLlzpyKc0YtwX4NeXYq3TRVCUgtQ/zIjfAPo/ZdnOPVg3WHjkBBatd2OMYuSFL378fsD1pxoXZItCDH99YWb0QWlbarWfASSysxyMEN6JZ3wizzwkwGQg7sdwG64zGrwk/uUPHq5sGx0d3sHG4SbbY/6HO1DeOWlqdNE2l/ONFfCwohCjXG8B/845A==
Received: from DS7P221CA0014.NAMP221.PROD.OUTLOOK.COM (2603:10b6:8:25b::11) by
 SA5PPF9BB0D8619.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8d8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 05:41:41 +0000
Received: from DM3PEPF000265C2.namprd03.prod.outlook.com
 (2603:10b6:8:25b:cafe::61) by DS7P221CA0014.outlook.office365.com
 (2603:10b6:8:25b::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Fri, 6
 Nov 2026 05:41:41 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM3PEPF000265C2.mail.protection.outlook.com (10.167.23.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 05:41:40 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 5 Nov
 2026 21:41:27 -0800
Received: from kalok-SPC741D16QM3.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 21:41:14 -0800
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
Subject: [PATCH v4 01/32] gpu: nova-core: mm: retain BAR1 reservations after unmap failure
Date: Fri, 6 Nov 2026 11:09:34 +0530
Message-ID: <07d29749942490a34d94164d150d55fda6c03453.1793906667.git.alkumar@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1793906667.git.alkumar@nvidia.com>
References: <cover.1793906667.git.alkumar@nvidia.com>
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
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PEPF000265C2:EE_|SA5PPF9BB0D8619:EE_
X-MS-Office365-Filtering-Correlation-Id: d818323a-7384-4918-9c86-08df3bc8a230
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|36860700016|82310400026|261022113327099003|261028144727099003|261022105027099003|261026140227099003|56012099006|11063799006|261022075727099003|261021123027099003|261021135927099003|261021121427099003|261026121527099003|261102123227099003|261009223027099003|22082099003|18002099003|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	DYo0IwMtvzCfRK/3u/mSTLrgPT+i8ZKIuNlktmHAMn/LBvLBOqth4w8zPn8x8JpGuCm7up3arBJ84ExpApsJIaHaM5LUiAlW/vpUy+k+hlAqcy0YfdLb9FmEEbd4YzL4g17i/86t32mFCLFkQ77scDYp+PkEHrW1kx5cdRMS3Y/7aRz4xEVelOkAmEyzB8SlM3EgSsd1xZNkfY15xOGU+MqaWPgD7TxCFtkdY9g7pUxff+5SuVVR8kvyVxLJPsbK68O5sHsndbb6WjcUPdJ1d+wkvIoGoJvuwoDizJg+w8n0VF1dGxNhJCgXCtEgdRLIQ/PZOMLYP/nROYeHkwTYbawoMNtgzjYUM+SlFHnbAZsSQzjw7/fBbWpMvEUkxzFfpLpnJ7CHk/3/XmVWiXvpZrRSrB78MXGukCygPRzIugWYSnRMzwOTfK8PUruoLarrR6fdKT/Ruw8YssJXTMSRQ9kQAXTLjvCc+NVL7MV1KX9NEHLDJIO06nL55oN/QJuJbMxWYaNkJaguEN7/qEvTZVjH11Wh92HfdvEywopXu3+IBc/DO/DixOBA9xTVgMD0NJ2KSA0QGDVCrlYw7ezCg4WB9UOoREjVlN5p2IUeUaYdQYVYVMcYLGLQXfW9KruLQ8Agzt+U9HAybDAZoCTh1NvtJiDa1MlKVEPweynmUWPCsmsjYHkI0QiCy+rRIF9Uy2n9Q3BWMUbVBZvy87/Z0w==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(36860700016)(82310400026)(261022113327099003)(261028144727099003)(261022105027099003)(261026140227099003)(56012099006)(11063799006)(261022075727099003)(261021123027099003)(261021135927099003)(261021121427099003)(261026121527099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	OUJ5Y57zaOcHC8T5iF9ab3Iiub9U2Xd9KAIbbfJHl0VM0MRki7FF5nt0ZBFYhgyytonsGjvVdcFjFxJxGwPRaho8Xg1X+Kvp8WTk9GQ6F2MYJcILbfZZM7nfvRPQqlflqyo7JUV/C28G9uhWdCBo5C9vnHuL9bhgTr8D232CEq2nz5TQyQ0QmAymAbg4W03AStvX5FbAqvWXdBZrthNvU3uK/JIJs9G369030ZH50b38ciCxSM+XafHqlqu98T8KzuTNu8/EpgJvDLga6QcXsR7TOKZ6FX16O4BmCGKzbwVcbZJ+YxnlhQJaa99wVfneoX4hFYt+G/VbpJdu9cKOGySu9bUyqYgvSGY4di4LcG6BwlO5YW2rBRNOXyarwMXddvTJfNEdADhqdgn1OEqaJbE5wH/pW8Hqy66bNBKw6wNgFXHAIs7FqHE6BYywQQr4
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 05:41:40.9548
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d818323a-7384-4918-9c86-08df3bc8a230
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM3PEPF000265C2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF9BB0D8619

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
index 6e9384f06f43..622a79f1cc22 100644
--- a/drivers/gpu/nova-core/mm/bar_user.rs
+++ b/drivers/gpu/nova-core/mm/bar_user.rs
@@ -83,8 +83,7 @@ pub(crate) fn map(
 /// Borrows the [`BarUser`] managing the mapping for the lifetime of the access object.
 pub(crate) struct BarUserAccess<'a> {
     bar_user: &'a BarUser<'a>,
-    /// [`BarUserAccess::release`] [`Option::take`]s this; `Some` at
-    /// drop time means `release()` was never called.
+    /// Cleared only after PTE invalidation and its TLB flush succeed.
     mapped: Option<MappedRange>,
 }
 
@@ -92,16 +91,22 @@ pub(crate) struct BarUserAccess<'a> {
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
 
@@ -167,7 +172,7 @@ impl Drop for BarUserAccess<'_> {
     fn drop(&mut self) {
         if self.mapped.is_some() {
             kernel::pr_warn!(
-                "BarUserAccess dropped without calling release(). BarUser address space will leak.\n"
+                "BarUserAccess dropped with a live mapping; BAR1 VA remains reserved.\n"
             );
         }
         // The inner `MappedRange`'s own `MustUnmapGuard` will also fire,
@@ -266,19 +271,27 @@ pub(crate) fn run_self_test(
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
@@ -370,7 +383,7 @@ pub(crate) fn run_self_test(
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


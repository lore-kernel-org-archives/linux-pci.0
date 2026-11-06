Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793943815;
	b=mEwZidFq2tMuSkphjwjrVoDmHb/Qg+LY5cwJeTzC9Ni+s4m3toEFAZbwHGlxuTPmmpIz
	 YCPGNdtCQnjg6CLLyPzNwHRMRggi9HdAKIJjroRVwikNAKjr8mUZi+0VHhUNRbFE7boRa
	 5vTQi7E+ALVK8TlQKPhqsVM5+GGJMHM8p+fsVbfADjU9KH2bY3Q/IhY0dYuFBFIGbIIs1
	 AZLpX5CndibxgcQ5uki8o7QQsZ++YpKO6iThzeDAuRUlCJx5nGKbwmBPEMp5cJIiJ9cjy
	 Zz+HNJeqK9dfYoxPVHFlGbJX/53S/cBEDg/Dbb3uRMUsVindIh+mCJJc3HM4/BLICVw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793943815;
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
	bh=6TQAUdGqLmXRD1MyvEPopXGPOp3HSh86pkVaerkZUNk=;
	b=Y7KC6mFbYt6LVTFQlTjtw1fbXaG5hQG4Q2pCUaOrUgiO0ZC2ixsnM3kGNPrrF8lCN1em
	 G3vcdNpNGgvviH14Cu3QZ1npWZyt5B9k9Tgw0IJ9e4c5EtgHO+PC/fwI4SB4YpNib/BKp
	 iEaVvyY42v9VMjlrrfMYFp3HaEZ8aKGNZLAG2JO9YrKY6yBg3S6nZnc+m4D7tpDPTLBf/
	 Wv/09B6dqnyGT4kwVRtCwH0ZNnOUoPVuxcpoqLKDU0fCnGlp/FD+hbIjUMlVbyoC/1xxF
	 aZyrzGpEdUeLM4ye0UaWq9W9z5eDsuyIumtnbO3VVIHJEhRUuxbeaY0z7kjfJQ9S4yw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=HEcWhOMY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.41
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013041.outbound.protection.outlook.com [40.107.201.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B079B606A32C;
	Fri,  6 Nov 2026 05:43:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B079B606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=HEcWhOMY
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S3MyucW60Wjx027xT/9o6F7bzRHEuuCXqgja0FRKdXr/31QLQVdRifLH/CGgxrrgnfknvDHvsaoXzW/FpMCu9p3oxPgmz4Dfi45BnEP7nWu8sbMZ4d4YKXVk6bVgMLVQrc/6+f1Y5o+Kim83LMxxiaqakEboAKiRbnlSsXLKLmvaFqWrSoB/eMb/f51otuk7LXTChgITLlUjLN7cC/gzMjYeXNZevb5+sQLlIaSlss/O+AOsHhieI38+uJcPe1YRdDy5HiaJC++vh4ReBWqPuK7Ii1qlMvUlu2QyGc40LpQ5F2pGduBC0dC7RnIUWappJQirTRlcwcpenwSUqMF20A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6TQAUdGqLmXRD1MyvEPopXGPOp3HSh86pkVaerkZUNk=;
 b=O7G5tcYwRtVmxrhghqUEvM+UTs/bBIAYgc0bwY+ZWGK7N4gJWi/2lY0JygdlyPeXm6JxCGGMARxgWSJ9ioPR8ZbqmUFv362RMN8RFvtel0boPKMFipQA9YevmTUtmgotYeWxzPVqtoSBBleFO+BYyz9scl0xlvvVGrsO/Z8CfCwGk0QmVqcgqF1xvjah0i6AlvasX7ElT81P845f8ZaHiy5XfkeOqb1TjQPqJNChzGkIUIcMJkPrRQ/2r2CjgutDJOBmR8eJuU9Lo0U0oLBkXMR9kvb2Pe6sY1jRvCpZo2yK5cEE0o9a++AQgKDKqSi/hZboML9Rp3jqjr5HkiGCSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6TQAUdGqLmXRD1MyvEPopXGPOp3HSh86pkVaerkZUNk=;
 b=HEcWhOMYjunBS8I1/W7eSLTLsF4hB23Uwx7jgD8MJf1BDg7Kwk08CHIntdp09Medj9UXISCVYu4UBelgO4bVZhz0WzBVIIk9FLUxVzYnwkXqXWf1P1nxb3dd6cL4PvcgZOBq2G7bkEKsvwtdhh4ZfoS1ii1HmjbuIrodat2InCgKpgD8odxvwCV4eHY9puXxcqRnFZYnRTkv3Rm6C5VthPT2+9XlgR4+ZwJE8Qj8eK3GGJ/eS1ZInPGrcrLPHCBVkcEtpJhHfcIMNcbYw053qXR8yEhRoSMvY/HYvpTUzrSh4HnkssWbqxJxFZTLcwzMe4gdvxlo++nf4ZyfPCSkdA==
Received: from PH7P220CA0101.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32d::17)
 by DS2PR12MB9687.namprd12.prod.outlook.com (2603:10b6:8:27b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 05:43:24 +0000
Received: from CY4PEPF000392D9.namprd03.prod.outlook.com
 (2603:10b6:510:32d:cafe::72) by PH7P220CA0101.outlook.office365.com
 (2603:10b6:510:32d::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Fri, 6
 Nov 2026 05:43:24 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF000392D9.mail.protection.outlook.com (10.167.247.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 05:43:24 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 5 Nov
 2026 21:43:07 -0800
Received: from kalok-SPC741D16QM3.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 21:42:54 -0800
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
Subject: [PATCH v4 09/32] gpu: nova-core: mm: borrow BarUser for temporary BAR1 access
Date: Fri, 6 Nov 2026 11:09:42 +0530
Message-ID: <d18fc4e423a4f1e7a91dd00bb103be6d0b56cef4.1793906667.git.alkumar@nvidia.com>
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
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF000392D9:EE_|DS2PR12MB9687:EE_
X-MS-Office365-Filtering-Correlation-Id: d64bdba5-db37-433f-9a4f-08df3bc8dfe1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|23010399003|376014|7416014|261021123027099003|261028144727099003|261026121527099003|261022105027099003|261021121427099003|261102123227099003|261026140227099003|10067099003|11063799006|261009223027099003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	rg038BsszFqNQlCtx3UY1u0c477mla+rSbdzq1WpLf9sVD8ORMT/nJrW1SAdCxpyiMddbpw7BcNoZ00d8DFN8MW1WvvAqy0ajRrrS+WWMVBXz0Tj4FiW3bq92/KAfZi4GO6TIb+z2+iWU0Lu7USuskmzR+eft32GAAlNOWnfMBF5atqpu54QkthSp8o6L3FRpxdyPVcfx4NC/Ucv5fTfHULBVXyzp0zeV71IdDPmqSHgnGpkuSeOXZysMmfSv9Km6Yi7q9Bwz7y5a+w26PTrL3KTRV+/q74b3pN3A401lf5294Z/xSe1LWicjdoLxwEIOlLjljpMB7CZzBj6M9xUgKs2wg1HpyqN+Yt/X6jCp1uja+9smYjw2EPF4UAhvy7RA73orUGaAAJuiTegzZI1Is4s+Uf++QfjZEOh52xpzgLUgRFTdULBI2O37wjPyF9De1CRSW6Q8c7kYIOBkyMKU4OAj7K7MEEeOUWiwQ3SujIXP7bNZj6A9bl4SzsuHwI1neg/z7GZvVBM60/Uq32eMCeYoUtQqsxmGNSXSlsARcxIxTgZlsNYIDICngYMYrFhn6bbU3qlvOYz1c4/Fb4snV1vykZk8s7f1vEYRwQT2ektlqHx3PrtocVTvbMAFjXZo1d2cuwyYWEGus6rNfMPaQhc4fzrU33cldHAow1ggo1Z/IfUy9bxg3nXz7kBV5u5HtlQhAaczEI+jJGzboDNGQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(23010399003)(376014)(7416014)(261021123027099003)(261028144727099003)(261026121527099003)(261022105027099003)(261021121427099003)(261102123227099003)(261026140227099003)(10067099003)(11063799006)(261009223027099003)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	briYDJcmWQ8a8z4ngBfUAbQUSZLvcc81ivHUr1z4xc56xnrQCiw0dAvfrWFaFayY5NalTaE1izrj/JvHNAsWLjbWS4y8OQUeVW4lLSHWJDZM2AcbTgSVV//TxzS0rSaBb+K7M4FLbZiQhhCWVFydzcIqGhB8TJk8zoDtxLoUOMkH3q4Ez6ZoEvCJsm+iKprag+diEQCLeKrIe+VVO9rtAmvcX79+g+cpbjY17hd1w2Z1aeFUfd9YZcsUYo6QzG5vhsKjyq47ucsgi2IdYDXtrWpvHk6yYnB+mSBel6Cdud0Jygaueb7LCR6Z4Rl9tkRDkrz9NKno8lQfWJGJ67wKM1pjwBJmjlukcfOpdhIlwITUxSP+0JVmpjPZVoXcNdpWqL8NuLWo5CWpp7rI4hGbOzlENk090FN7xcNyN72koFyrNMYjjTduHwtvkbPkFOxM
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 05:43:24.4855
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d64bdba5-db37-433f-9a4f-08df3bc8dfe1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF000392D9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9687

From: Zhi Wang <zhiw@nvidia.com>

Temporary BAR1 access needs a borrow of the GPU-owned BarUser. Store
BarUser inline in Gpu and borrow it in BarUserAccess, avoiding a separate
allocation and reference counting for these accesses. Update the existing
self-test entry points to accept the borrowed interface.

No functional change is intended.

Cc: Alistair Popple <apopple@nvidia.com>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
Signed-off-by: Alok Kumar <alkumar@nvidia.com>
---
 drivers/gpu/nova-core/gpu.rs         |  2 +-
 drivers/gpu/nova-core/mm/bar_user.rs | 16 ++++++++--------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index 002c5ba134a6..98772868979d 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -666,7 +666,7 @@ pub(crate) fn run_selftests(self: Pin<&mut Self>, pdev: &pci::Device<device::Bou
             dev,
             this.mm,
             &info.usable_fb_regions,
-            &this.bar_user,
+            this.bar_user.as_ref().get_ref(),
             info.bar1_pde_base,
             this.spec.chipset,
         ) {
diff --git a/drivers/gpu/nova-core/mm/bar_user.rs b/drivers/gpu/nova-core/mm/bar_user.rs
index 622a79f1cc22..7f389aea7ca3 100644
--- a/drivers/gpu/nova-core/mm/bar_user.rs
+++ b/drivers/gpu/nova-core/mm/bar_user.rs
@@ -59,12 +59,12 @@ pub(crate) fn new(
     }
 
     /// Map physical pages to a contiguous BAR1 virtual range.
-    pub(crate) fn map(
-        &self,
+    pub(crate) fn map<'access>(
+        &'access self,
         mm: &mut GpuMm<'_>,
         pfns: &[Pfn],
         writable: bool,
-    ) -> Result<BarUserAccess<'_>> {
+    ) -> Result<BarUserAccess<'access, 'a>> {
         if pfns.is_empty() {
             return Err(EINVAL);
         }
@@ -81,14 +81,14 @@ pub(crate) fn map(
 /// Access object for a mapped BAR1 region.
 ///
 /// Borrows the [`BarUser`] managing the mapping for the lifetime of the access object.
-pub(crate) struct BarUserAccess<'a> {
-    bar_user: &'a BarUser<'a>,
+pub(crate) struct BarUserAccess<'access, 'gpu> {
+    bar_user: &'access BarUser<'gpu>,
     /// Cleared only after PTE invalidation and its TLB flush succeed.
     mapped: Option<MappedRange>,
 }
 
 #[expect(dead_code)]
-impl BarUserAccess<'_> {
+impl BarUserAccess<'_, '_> {
     /// Tear down the BAR1 mapping.
     pub(crate) fn release(mut self, mm: &mut GpuMm<'_>) -> Result {
         self.unmap(mm)
@@ -168,7 +168,7 @@ pub(crate) fn try_write64(&self, value: u64, offset: usize) -> Result {
     }
 }
 
-impl Drop for BarUserAccess<'_> {
+impl Drop for BarUserAccess<'_, '_> {
     fn drop(&mut self) {
         if self.mapped.is_some() {
             kernel::pr_warn!(
@@ -186,7 +186,7 @@ fn drop(&mut self) {
 /// address space. Uses the `GpuMm`'s buddy allocator to allocate page tables
 /// and test pages as needed.
 #[cfg(CONFIG_NOVA_CORE_SELFTESTS)]
-pub(crate) fn run_self_test(
+pub(super) fn run_self_test(
     dev: &device::Device<device::Bound>,
     mm: &mut GpuMm<'_>,
     bar_user: &BarUser<'_>,
-- 
2.53.0


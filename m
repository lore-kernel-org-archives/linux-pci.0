Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795529294;
	b=WW+OCeVNJaIKq7OEfCOCPnv6TFplx7WIcz6idt4lAHvQdgXHV2vEuWHvnrwtEpaTVC/8
	 JT7lXrK6Mqai/Su9CpmAFJ5txNnj/TW+jwDcFu4WeXS/rxWGncCX5m28yaz4YBfzHvMHK
	 HlsgaRZA91/vCOUwWihox2C760qbSHoMCzwCjwGwQkjpHLydI3SQ4dYJLdfpKwpi/ebr8
	 DgWBKmKY6p0hdHN69MmAPcP5ZIB8/lM7AvKEjOB1mUV2tKJjuFOai9SHx1pBYQHqb6Iu0
	 fcxr1650YT83EAyUJr15XnAGtnckj4W6gXuwzTyKC1L8BcRRK++H3P0DBLUMbzFyPLQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795529294;
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
	bh=Vo7nPrK6ShaXaAkS9pvRRcJ/KNMTChQuzwt7kAvALg8=;
	b=bLVp59FYOStsuG8p92cbCQna3uwLAJtUPnSsXvMNkypxnxVejvWr+kzqEDCsK8kPwNna
	 9f+Ft3B6K6eb78NNxbIbP1HMS9aBB2HwM99U67tT+AGk8OsFfvLFfo2UKls9e0i5NP3sD
	 dCsy+HkwPW92JWoFHddou9fV37WKHRHFs2o2ylkmmvnRDq5KRPMDvOa5ydhjaU3UdJsKM
	 DWxxe0qm1KmGjNqJLn7gUr1f91KA43Mc6x5J7iDZTuKFwj7+kDGPwKrc0gvBcYoU1dvtj
	 lalL2aZRrUSxPiR4/y+knEOadmWkUhP5EGCxEAOomtPING6hg/7wpThb6k04Z0HvdWQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=teYmBm0S;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.13
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011013.outbound.protection.outlook.com [52.101.52.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BA3606A6BF;
	Tue, 24 Nov 2026 14:08:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30BA3606A6BF
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=teYmBm0S
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cYqQgC+gbMLlJYVA6AsMfdjSp3UkMyVd/qCzBMRIEnjt9/9gpcnONSezFoMrliKRZND98eQ2grY8qcvdJ9JtohlBW9ooE92zjMURZcGczfzADua4IFH5QID3fLW+/o4muKFXOHBb1wyVuT7F7cDfyXRdPl7r+ul9taWv0joj9+TMHl+B5rsfDQ/31CfrGVhJ33W7lwM+iK/Kli4P92q8QqnnYjiTOC9NjGq4ir+lBZT5A9O7Lx04ZJGLKpbQ4bLIIj2u+v0HT/Cv0E5FldsLGjXiRCDmcTrMm5DxF1VL9NVf03V556qZyXO25c+zxY7+yCCrKxnhVuglR4WkxiQOsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vo7nPrK6ShaXaAkS9pvRRcJ/KNMTChQuzwt7kAvALg8=;
 b=VihYe7HIW4ZQ6WDyxsqF0woTAv1gkPIcaIgarprCLMCr8iS2xH8gPKp21Qb2irarpNqwUMmoWpwiVuOyTluk829pAuQ5O1+QhuPbRs9hsN0kevrFiztyCx04C2+N0Mx9dkiOvn7jt5aDnIc7TMdRP6H+NTeH03lXYZflXM4CzKc72L4ousCFXoLYvRYbHZPTuouhyS3rcJ4uWeVzPAss8tJuymFU2VoeKHoKzxmwOV9HRqfkWOgAOTWha2YA29Ct7pwZHDydv7fE4pXP8p9snAUQ02lMK8vfP2gwdXR7+lrtU3S0Cct4yPXLJH+Cp7+1knckYrCH0n0WR5VuqCRDRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vo7nPrK6ShaXaAkS9pvRRcJ/KNMTChQuzwt7kAvALg8=;
 b=teYmBm0SZmVePE1VId8nZTAhBWc1YgoOD5jAdiwg5TtsIb7p+KVpCFXjifs4UdPbhSQM2Il45mzoEAtxqkRusFs2U8uNIybTF7r5CZ6zAuzjlbUBR2yOWIk5zQmfKEZV9qYjDHLTyeMZPK8sYxu2BVuIqTgxn9WsD88URkWvBy/9IDqbfmeVuhF9zvTGCm4SOAcnVCp5Y1A74xlWzgUDzOx7pLQYTJbfZqPhlgVv1sgtaH+V/Qno9Pn7sxp7XKBoiGaLsm1YddvNmv0jwrPcVZBtWeJktE5bgipNkKUJocxXrYnvaXsZh7ALGKXd6V0rb/+xO9irIlq6EG5A7Af05Q==
Received: from PH3PEPF000040A5.namprd05.prod.outlook.com (2603:10b6:518:1::54)
 by PH7PR12MB7938.namprd12.prod.outlook.com (2603:10b6:510:276::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Tue, 24 Nov
 2026 14:08:09 +0000
Received: from CY6PEPF0000004C.namprd03.prod.outlook.com
 (2a01:111:f403:f910::) by PH3PEPF000040A5.outlook.office365.com
 (2603:1036:903:49::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.6 via Frontend Transport; Tue, 24
 Nov 2026 14:08:08 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY6PEPF0000004C.mail.protection.outlook.com (10.167.247.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Tue, 24 Nov 2026 14:08:08 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 24 Nov
 2026 06:07:45 -0800
Received: from kalok-SPC741D16QM3.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 06:07:32 -0800
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
Subject: [PATCH v5 35/35] gpu: nova-core: mm: keep BAR1 self-test page tables alive
Date: Tue, 24 Nov 2026 19:29:31 +0530
Message-ID: <20261124135937.18583-36-alkumar@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY6PEPF0000004C:EE_|PH7PR12MB7938:EE_
X-MS-Office365-Filtering-Correlation-Id: 033cedb4-7886-4c58-1dd8-08df4a345e2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700016|23010399003|82310400026|10067099003|261028144727099003|261021123027099003|11063799006|261021121427099003|261026140227099003|261009223027099003|261022105027099003|261026121527099003|56012099006|261102123227099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	GBczuy8MBZup5CDy/Uv4GNq2z6fAHEgkpB1s63i5gq0b7vI3EqwpgcYvViHBtL1FPQKtdIGCCvPiIakhdhKhuNdPSHdT7TU6LMDScHo4ScyQwhS7H+ZbCnRi3puIeEoxcPN8ObLdyaQ03ek6J2reiZGMSm8K8hyvgYE1EC5K4+1lkBAZ9rYektrsuZsKd7vvcWBXvtypFC70e1V/WXNWSjZRUKTXvUc8Pe6w/Rxa980H3XvG4lLJ7Er4D4ofAr3CsDfnoHosK1xxwhxAZjA5JgEpvjUkcH4o5zlp/yHJ4olb2nQpsMG+m1ERmdk6wBI0TSZRBuMb5U/hFA/X/mIHIwcKlg4w5rVO5EL2IqsGcml0T3KG2d1QfuPzaPMj5Nh8qht7/DqTR4WDq8T5rteSFcY6LUWqLJdeVQ82AyG2JXrw2HzLisoNa+b5C84mPihr2ebCXbYsGN1q99SPNixTLqtzr8bLYI0LxEdl7q1fm7tPXbwCXivQcEYQTd36s711abwrgX8AJKZ+YIPHyhRZRvimbikboWwiUYqMu9eYjP9IoDy7JNOIKzIqH0lyv/A4vwDVa33eRefTZh7jR+fDLTQnV1eI1gTmKuvq676JeZdHaV45rYyZ12fZxRTJE5Y1X4qeKGcH8XFX0oZbvzclfiZDgOuj8gPd7qiznJlv7BaY6+GvdFxlk8wygKxfDrHEQGMmLDY43DkVLyjjpCh/SA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700016)(23010399003)(82310400026)(10067099003)(261028144727099003)(261021123027099003)(11063799006)(261021121427099003)(261026140227099003)(261009223027099003)(261022105027099003)(261026121527099003)(56012099006)(261102123227099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	F1LMZqXBnUhQkfkEDP4zE2aWK4cyXUbEA1RizQp/sbrog9qf9V7R3c2Ua1iBSOqbOMsft4yZOo+HtyBcx7xkdspgFYx32O9eDJSSXpTbQ6JSjWeheFF3yIS7uIFSbJ/N8vKVgvEIWZdD38TSltTuworhOn7fFXEMb2QfOGBjiXTFB/Ye2lIvCBqS1hGprLYuT64xnu385TkIrumWkElHFLL2rup0Hi8sQ9+cpoACyQrMXCk74vxMKWxCa0/JnUDzKV6CfPuLjKoC55iJCSRK+6BjMTI2FhmhDkZjS5U2EHdIrRlT3qBaSgBXey3m3UCu0jWShk+035KAQMLsBis4Sh0o6WwxsHR5ZCcEz6KG9KrKciHG3EXD5p2IibNV7/AxnAWRNTI0+xrk0xlDTmguN8+A1R61JXfmoZzYrt6+cMhvPzfuSMLy8J6ocJS8vOcS
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 14:08:08.8009
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 033cedb4-7886-4c58-1dd8-08df4a345e2d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY6PEPF0000004C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7938

From: Zhi Wang <zhiw@nvidia.com>

The BAR1 self-test creates temporary Vmm and BarUser instances on the
live BAR1 page directory. Dropping them releases their page-table pages
while parent PDEs still point to those pages. Reusing a freed page for
another leaf table can make disjoint BAR mappings alias: unmapping one
vGPU then invalidates its sibling's mapping.

Use the supplied persistent BarUser for all tests so the installed page
tables remain owned until GPU teardown. Borrow its Vmm for the direct
mapping tests and release the mutex guard before testing BarUser::map().

Fixes: d669686f8170 ("gpu: nova-core: mm: Add BAR1 memory management self-tests")
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
Signed-off-by: Alok Kumar <alkumar@nvidia.com>
---
 drivers/gpu/nova-core/mm/bar_user.rs | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/nova-core/mm/bar_user.rs b/drivers/gpu/nova-core/mm/bar_user.rs
index e0fc62630fbe..4a49962f7f68 100644
--- a/drivers/gpu/nova-core/mm/bar_user.rs
+++ b/drivers/gpu/nova-core/mm/bar_user.rs
@@ -329,8 +329,8 @@ pub(super) fn run_self_test(
     let test_vram = VramAddress::from_raw(test_vram_offset);
     let test_pfn = Pfn::from(test_vram);
 
-    // Create a VMM of size 64K to track virtual memory mappings.
-    let mut vmm = Vmm::new(pdb_addr, chipset.mmu_version(), SZ_64K.into_safe_cast())?;
+    // Page tables installed in the live BAR1 PDB must keep their owner until GPU teardown.
+    let mut vmm = bar_user.vmm.lock();
 
     // Create a test mapping.
     let mapped = vmm.map_pages(mm, &[test_pfn], None, true)?;
@@ -490,7 +490,7 @@ pub(super) fn run_self_test(
         test3_passed = false;
     }
 
-    // Release Tests 1-3's Vmm before Test 4 uses the GPU's BarUser on the same PDB.
+    // Release the lock before `BarUser::map()` acquires it again.
     drop(vmm);
 
     // Test 4: Exercise `BarUser::map()` end-to-end.
-- 
2.53.0


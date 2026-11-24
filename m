Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.30
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795528968;
	b=Ia24XElchJidt6wuFm/0PuFRsERslJh00sASkh0NlPypCYlgPTnOSDR0ZDCIpCFdOY/W
	 ZmgErV5bmSJrzbaCbgnQ2oaaAJRfFE8A221fIJI9g5yNTW8XwO6cF4lHJYyKyHUZyVGIv
	 0Lb/pDH5/77QXlY2vbnOpuhDze3WgRi/LS2STwBWQtKI27kCuWt87MFa4p0V6hQf7Q3M6
	 Wvk9lYU+M8t3aVey+fyMvmhcWcna0vDyZKpmFZPEnsvuctmKuenCbcAXoet6UbEr9ETk4
	 evZPFu3iurOG1l49idbUn/LhmhsffBiNRCS3/85aBHjo+g0wMJ4sjUOZXCsGrugbsWg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795528968;
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
	bh=Ws0XtHNeGzl7tbA1Amy8Ah+LIOF2Ba+JvslikoAdsZo=;
	b=ssfK2qIajt3CdmJvasZCLGOv1HSb/3ZjBLbu/z1finrGEBpghuwSlYyd5Fmu2yiNsCsX
	 KkqvcxcsqoixX129nqAohxziFKo6JmUXVgLlY+i/j39CMFtT9hTcRWLyNLLT9om4MDlis
	 hBg9E1Ps0M3uVDKXUBEL4FilYqX7j9UDVAyWDJNUUCfS4gvbrSe6aJOj/eGCaEnzDs0Iq
	 okgzDUwlmr2JQOIclgTMp6XjcML7fbgpleMB9lQQNotfuOEUM9BcTAeiVCSdVWPJZPwdg
	 zsqx0N7y7wn7sQHHBvo9EyKQf9cKrlPG9NhMZe1dp4QMiJjJZ05zU+8cd6/Yy2OlHCA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=mmmyx4QE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.30
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011030.outbound.protection.outlook.com [52.101.52.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6ABC606A31E;
	Tue, 24 Nov 2026 14:02:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6ABC606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=mmmyx4QE
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uc0hr0HXYzU+8nHcd0YG/s5MeGxkLzWBHnlTphKI19VHAOWrPY1FQR/hYXWgjhP+eOhSY3QYZYK5ayv8st0DO41X4LCk2OOnDN/qiRqNEAt31uvPqXbRCIvrPzGgxJnfh3P026xYhdMxfqr4dzsYf4qvEQclRWbzmEgzToy0oZ3kMjpTkRwnC2b+7rZYhbg/uBNemV6oKzceEVTMtOWcwnCshHvS7eWa2k1lYjTv4eSABujtHKIPQdM2EXNVdpE7bfaIaMuK4ZcUz0dQ0iGp1m5fpb3nKTDlnNzXgDrDXVyqS+2ZXP+IjZqkK5zcisuyIwDkQICVi9QjaRFgfBsETA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ws0XtHNeGzl7tbA1Amy8Ah+LIOF2Ba+JvslikoAdsZo=;
 b=zVhdbHN+XuFoPBzrwd5mEvIotQP0HOb8r5gKhRVAjN/R9aKvlx8rxVaXqtkGxXO6y7eDAWDmbY6GDPJe0AmcouFGxmvBwheDh0mV3ZzUbod2a/M0bVK513/ZABu/PeLJMBXwVUlLYe3etkO29od3em5pmO7fpIfrSTwXpKsXZLkKSD6CgcIXTgU00uWoi0DSLGEiSK2mziH0g8UvcM5QYAFA3ksiMd8i/hTSUcjzYOCvejpmrts0+WYoW2wdpb6EvgY+GoHQ6YIEUxbx2h/bhO/KE/VKHSeJS7nhSunSYqzs0dvTWAvmhnSYcHbnhOqcg538yroGL6mEFWirbB5Gow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ws0XtHNeGzl7tbA1Amy8Ah+LIOF2Ba+JvslikoAdsZo=;
 b=mmmyx4QEkGRGJQOjExZo+c46d0tQPyMmsZXnFLPec3Exe5Qe7pyt/AVnhvXATYbp5+eLRwJwaRSQqlwCy+ZpZTHoXQhGSPD/Zxn0v0xHb7dRJxfFfDK+u6UKeGF8anpbFmbEnU62lMr33Y8fQJTeHPrMHUNvRVUmuwNldc7mwgGM2Ppx3eT0sLdX9OTP56YMz6EP48G6g5EQYTofhOAfY4+ULdQmzU5a1Dqa4js6iaIwl+Md5IL2WJsjPt/kSHRCndm3XbYrfkuIvm7IYMpy/xT/Fi+5vXlVldGblELvb39Ox6bZa1RGiOFe2xU2egj5qJUDzP4KdaIjhNgx9kS1Xg==
Received: from BN0PR04CA0114.namprd04.prod.outlook.com (2603:10b6:408:ec::29)
 by CH3PR12MB7499.namprd12.prod.outlook.com (2603:10b6:610:142::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.4; Tue, 24 Nov
 2026 14:02:37 +0000
Received: from LV8PEPF0000006C.namprd03.prod.outlook.com (2603:10b6:408:ec::4)
 by BN0PR04CA0114.outlook.office365.com (2603:10b6:408:ec::29) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.6
 via Frontend Transport; Tue, 24 Nov 2026 14:02:37 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 LV8PEPF0000006C.mail.protection.outlook.com (10.167.248.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Tue, 24 Nov 2026 14:02:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 24 Nov
 2026 06:02:09 -0800
Received: from kalok-SPC741D16QM3.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 06:01:55 -0800
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
	<peter@colberg.org>, <xinmengs@nvidia.com>, Alexandre Courbot
	<gnurou@gmail.com>
Subject: [PATCH v5 09/35] gpu: nova-core: mm: replace BarUserAccess accessors with typed MMIO view
Date: Tue, 24 Nov 2026 19:29:05 +0530
Message-ID: <20261124135937.18583-10-alkumar@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: LV8PEPF0000006C:EE_|CH3PR12MB7499:EE_
X-MS-Office365-Filtering-Correlation-Id: 138a9086-a703-41ea-b64b-08df4a339865
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700016|23010399003|6133799003|261009223027099003|22082099003|18002099003|56012099006|11063799006|261028144727099003|261102123227099003|261026140227099003|261026121527099003|261022105027099003|261021123027099003|261021121427099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	j+opQLhRYA7ht31OtYX/C0nyAkPv0oq2UbLV96N1LMvJWu1A0yHGwdjGNXkrTHETz0EBvV8HSx/DTdof6ixVTyaDv0P8kwYuVbBqDIYm1fTlmfCEhOuEHHz/6M372dSvaXIKREiMG5nZZvCgZdo78beCz+09rcA7oGgs/pIKEsYqtQOweiu1IA1oztY2Xec2ITgoYoQUs6I5Q+wyp7SeSD9Pm2EYCg2p+BPPL1ggD/XrNAjaVsLZ3RAMm7cqCw+IvrpAhx0GTVwzw7bXKfkrzVqANK6s259tRwW8dQhurCeT9dAh9rz3KxPcgB7Hk2pwIP2RqPdvZ0y7OaHUQiSs7j4EfPpOQ/Jvc/sodWqSqZQgmMjJUCQCyfsPhjPY3wfC8S8e3EN6uAhlI30HpkdQ4f1NLOTno3fW5h5azwXLi7HCQIWdUcqpAmToft67OrVbmECejq55ZfpwTMfy8TpZmLswx9qqDgRBFSJat4+sWUpKJilxlFIsS63S9qrIeJ90iVyvdl1gtga/MTdyUcxjpLYN+UyKuTMX6d8+1YvwlUcWpXZdURPpHyR38J35F02AixMyTIS/dahXecopgpbgtqGDULOWnEWjSzIYt2AQhhhOvL4NZcPGOX1VDqS2Lr7T8ZhKNwug+v2W1/O+uWO3DinqlDNfUNzI8JWBhjHxlwUpCRkN7Y11CYsCd/hOV9OfxU8mWAbUpedi/AGsaGvfZQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700016)(23010399003)(6133799003)(261009223027099003)(22082099003)(18002099003)(56012099006)(11063799006)(261028144727099003)(261102123227099003)(261026140227099003)(261026121527099003)(261022105027099003)(261021123027099003)(261021121427099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Z4U25eWZJfBdTaFG1TcFOUp3HqIPFcrWAhkUdJcXTtxAhjP8b7OjJz/FEWDGGt0Lcb1u+MHMlbzG272naUwQHBhGfrAqjDq9KY84tSXLDZqtVljDIGJDR9+l78dWlEq2rTVBaB76D5yFq5ajDOR/LujvAZkz1Q7BHTXoAJxW5pQ43bAhLjCpAb7J6K7KwtJmL32py5g2MtvH6HEhOfICrfn/WsOzw6v3WT2wBj8LXbrhZzm0ggJU1LX1MTAdwk+rqY6hMO0WLabXjnGxuifbgf8NCVnPjm6uTCezC0KxE04H6s2IGi1yily2nFJxJTNYFJougMSoUT1hQoCvyCZPb6+TNCoCHvbAwxZ8wOq5oyvBWc64TJyyyUJYpsojxNGZrCkqky8DD/UEbH4itDKALrbBiO8yDUZZTF15dMMzLTZHkWDvnNfJH20Nea/Lux7O
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 14:02:36.9096
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 138a9086-a703-41ea-b64b-08df4a339865
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	LV8PEPF0000006C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7499

From: Alexandre Courbot <gnurou@gmail.com>

`BarUserAccess` exposes one fallible accessor per access width, each
translating its offset into BAR1 before doing the access.

Replace them with a single `view()` method returning a `Mmio<T>` of the
requested type at a given offset of the mapping.

This lets callers describe the layout of a mapping with a type instead
of offsets, and to use the regular I/O API.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Alok Kumar <alkumar@nvidia.com>
---
 drivers/gpu/nova-core/mm/bar_user.rs | 58 ++++++++++++----------------
 1 file changed, 25 insertions(+), 33 deletions(-)

diff --git a/drivers/gpu/nova-core/mm/bar_user.rs b/drivers/gpu/nova-core/mm/bar_user.rs
index 2e8bd2a8ed91..f82372ccab6e 100644
--- a/drivers/gpu/nova-core/mm/bar_user.rs
+++ b/drivers/gpu/nova-core/mm/bar_user.rs
@@ -4,7 +4,11 @@
 //! for GPU work submission, and applications to access GPU buffers via mmap().
 
 use kernel::{
-    io::Io,
+    io::{
+        io_project,
+        register::OffsetLoc,
+        Mmio, //
+    },
     new_mutex,
     prelude::*,
     sync::Mutex, //
@@ -125,41 +129,28 @@ pub(crate) fn num_pages(&self) -> usize {
         self.mapped().num_pages
     }
 
-    /// Translate an offset within this mapping to a BAR1 aperture offset.
-    fn bar_offset(&self, offset: usize) -> Result<usize> {
-        if offset >= self.size() {
+    /// Returns a typed MMIO view of a `T` located at `offset` within this mapping.
+    ///
+    /// Returns an error if the mapping has been torn down, if a `T` at `offset` does not fit
+    /// within the mapping, or if `offset` is not properly aligned for `T`.
+    pub(crate) fn view<T>(&self, offset: usize) -> Result<Mmio<'_, T>> {
+        let mapped = self.mapped.as_ref().ok_or(ENODEV)?;
+
+        // The I/O layer only knows about the bounds of BAR1, not the ones of this mapping.
+        let end = offset.checked_add(size_of::<T>()).ok_or(EOVERFLOW)?;
+        if end > mapped.num_pages * PAGE_SIZE {
             return Err(EINVAL);
         }
 
-        let base_vfn: usize = self.mapped().vfn_start.raw().into_safe_cast();
-        let base = base_vfn.checked_mul(PAGE_SIZE).ok_or(EOVERFLOW)?;
-        base.checked_add(offset).ok_or(EOVERFLOW)
-    }
-
-    // Fallible accessors with runtime bounds checking.
-
-    /// Read a 32-bit value at the given offset.
-    pub(crate) fn try_read32(&self, offset: usize) -> Result<u32> {
-        let off = self.bar_offset(offset)?;
-        self.bar_user.bar1.try_read32(off)
-    }
-
-    /// Write a 32-bit value at the given offset.
-    pub(crate) fn try_write32(&self, value: u32, offset: usize) -> Result {
-        let off = self.bar_offset(offset)?;
-        self.bar_user.bar1.try_write32(value, off)
-    }
-
-    /// Read a 64-bit value at the given offset.
-    pub(crate) fn try_read64(&self, offset: usize) -> Result<u64> {
-        let off = self.bar_offset(offset)?;
-        self.bar_user.bar1.try_read64(off)
-    }
+        // Offset of the `T` within BAR1.
+        let base_vfn: usize = mapped.vfn_start.raw().into_safe_cast();
+        let bar_offset = base_vfn
+            .checked_mul(PAGE_SIZE)
+            .and_then(|base| base.checked_add(offset))
+            .ok_or(EOVERFLOW)?;
 
-    /// Write a 64-bit value at the given offset.
-    pub(crate) fn try_write64(&self, value: u64, offset: usize) -> Result {
-        let off = self.bar_offset(offset)?;
-        self.bar_user.bar1.try_write64(value, off)
+        // This also checks that the `T` is within BAR1 and properly aligned.
+        Ok(io_project!(self.bar_user.bar1, try: OffsetLoc::new(bar_offset)))
     }
 }
 
@@ -193,6 +184,7 @@ pub(crate) fn run_self_test(
             GpuBuddyAllocFlags,
             GpuBuddyAllocMode, //
         },
+        io::Io,
         ptr::Alignment,
         sizes::{
             SizeConstants,
@@ -397,7 +389,7 @@ pub(crate) fn run_self_test(
         .view()
         .write_val(PATTERN_BAR1);
 
-    let readback = access.try_read32(0)?;
+    let readback = access.view::<u32>(0)?.read_val();
     let test4_passed = if readback == PATTERN_BAR1 {
         true
     } else {
-- 
2.53.0


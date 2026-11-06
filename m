Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793943841;
	b=Pr40uLQ8M6RTiJTaszSYLNmmHNNC9eszIRaWIfwJI0AE1oK1wP62B2xmmB7JVO3aWtVq
	 l+LaEZSwLBqYgBscdaXdrHg/FU0ZnLsyCm8brMS3hxf8Auj9aHKtLi2OkAC+OplI8JABb
	 zJpwbAgOFrCYPSdAWQbK3vvtSqLE0biErnOplOUC6cu/RhavSdQ0asoQtrLOURCuxAy4N
	 7LhbO4wWM7cjFc4WTzF/fKg4KmbbOcRZQPNzKympNah8Qz9Ms8JQe9lXVHFw7YCXRqIcq
	 H80qTr4wcoSJlokqacxFjfE7cBITKp8fdTCsqybZpfFQERKad9l+/HVBr9t8LIWry4g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793943841;
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
	bh=GaEkpJcFjAHzAJtS7rm32zam+RM1SMTq40uz/jMUhAA=;
	b=bj1+DeVj0/Paj4PUmCBD7dahUULaUm63L8W7Tq3S+KW+myxH2uUWwwOoRmdD3stIM53j
	 p98S5yNOWKe973wwX8qeX7ZM5jXR+mpPG0VnIVWfto8w5ff11dYdg9IMTtmgeo5W0JqYr
	 7qbr49zCs+mvEgSnjqkkS0AyOcAHWtqoLa1a2LyRMWgZmVKddiBrFZnEgwrZMGXrwENxb
	 +v43xfuuNyPuelCT45ysxELr2nDI6KX13oCDVmp4a90GkUXY7hAV85WAvsTR6kwyRHIJX
	 Wr9iMd1Tcwyqf637O0TjAQZ9ZiJJ8t6DM2MoZiI8evRaCJk0MjRAOp3dKL9Qp71SxIg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="FofzY/LK";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.51
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011051.outbound.protection.outlook.com [40.93.194.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93E9606A33C;
	Fri,  6 Nov 2026 05:44:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B93E9606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=FofzY/LK
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SI4Gh5L01aUTRryghnKtuKLAwdodIcg9nSf/sA3X1oTCNYObmJrbDFfqGqtMJN2G0goNlgu1YoxNUmpd8PcW2psWnQo9Yb2yD6HGb5gwVXttnkn1NTi/eNCWEErOhXTOKOOAcnPZrjMmTxYl2YGsdOR9xLTJB9OTkjaikLLgR8Io8KuNpzHR/ENgAd23RfVrIlBM25EVRkSnUU2WUEbLGZOAQaim2knowjodjb7M3EqYEjGDCw486yUeG9AEjoisGc9gqKlJZzq/mjhzbS64VG1CAcqzi7a3ta7lII1bkwEtAr+5qx6q+tul+7NEvn+KnNwfywFr4Xd25aqjMWWyVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GaEkpJcFjAHzAJtS7rm32zam+RM1SMTq40uz/jMUhAA=;
 b=t5N8sXtUMiRkJB1Bxu4FSJr2jgw7kg3wFZOwMgBJe9vTHjBp29o1PZynLIpN8dYu+d0h6VVwx2PXJQYuxy8bcYwXj3yFNjgoz1ZhFh9//YtpuSR9AiaCAuGpzb3aNYXgVhOE65DaXdnp1/j7mByJ7vF0iwDy5CDWsoWwwNIdEmeWkXoVpVlPk9kz8e4ggiZhCbul5Wwn6K1x9tFfXwYWcfjSTnWvb+icpdM/QNte9J17cSWzzXN0dxt5rXRyJ3pyX/PKWs4qqFJ18DTSE43yaqOG8XO6/foG5ScVosvhy5PgnzWkysP4xJHPevTIT9JlH0BxR8k5kThDsuiiXLViiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GaEkpJcFjAHzAJtS7rm32zam+RM1SMTq40uz/jMUhAA=;
 b=FofzY/LKyrbqCM4IwGhlXv6PP7oRSO3x4WNdq7w8RFw5bRxeXX6ccfpCAL2iMStSF7uFfzomyMNYtj/q4kQ3w3ddXrnJ7bFVQDk4Pp13a06JDxAXGSwpb3iEnbiYZbkDlnqL+x0lpKh1TAlbe3M9eNdPmEkjumOA6JpocZMXP61epm/MlyKeIhqE6lDzymM7asnhd4SV2543DpNS0ndmuqG5HD+nm39+tzuu5UOnbRM44+iiX6FNgBqTdrxg4rexkRHT0axqLVHl86z2PW+YmtcS6annssHkd88ZpKredjw+Puh8QY8wvVAofv+YvqoV/JuNYp3KKIDMrTNH8C1IxQ==
Received: from CH5P223CA0015.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:1f3::15)
 by SN7PR12MB8791.namprd12.prod.outlook.com (2603:10b6:806:32a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 05:43:56 +0000
Received: from DM3PEPF000265C6.namprd03.prod.outlook.com
 (2603:10b6:610:1f3:cafe::52) by CH5P223CA0015.outlook.office365.com
 (2603:10b6:610:1f3::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Fri, 6
 Nov 2026 05:43:55 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM3PEPF000265C6.mail.protection.outlook.com (10.167.23.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 05:43:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 5 Nov
 2026 21:43:44 -0800
Received: from kalok-SPC741D16QM3.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 21:43:32 -0800
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
Subject: [PATCH v4 12/32] gpu: nova-core: mm: add BarMapping
Date: Fri, 6 Nov 2026 11:09:45 +0530
Message-ID: <fb30f728f6ee24dd769d5629971a02cc53fa1d31.1793906667.git.alkumar@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DM3PEPF000265C6:EE_|SN7PR12MB8791:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cdd0662-d798-47ba-3c08-08df3bc8f25e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|36860700016|376014|23010399003|1800799024|10067099003|22082099003|18002099003|56012099006|11063799006|261021135927099003|261028144727099003|261009223027099003|261102123227099003|261026121527099003|261026140227099003|261022075727099003|261022105027099003|261021121427099003;
X-Microsoft-Antispam-Message-Info:
	mu7dCoZV5gqeZOi2Ae2Su3uhuk0Gzw7F24MuuGNfi9uZV3Qyuxh+wFPmyj7UM3SuxrMmnquxj7rnAbB4dODj5CZNFwUfBvFGwSOX8MIlXpdO0vknutGfAfYkPsgqgzBbp81VETcd5tSEvN9XBxiC3tu5B1VcHTVM3k8XjL9vB4yDvctfzg0W0mKi0Lrm0ysRzMm34sul5ur3FUWdLA6doMop2sc3DmYtvi8ocNz1Wyh5SQEIlx8b4t/2f38U9EQxXAAaCBlzWvuTvvx9WA6zAedt4KzGRQWqCebgP+F49U4zqI2Jm3qEHR6/YDMZuuaOfaKuNJC+BWJw9NtFPpaiMMJvXfCqy8oCQfwzYLexrZFHc6beojxwv+vDWfdbJK3v2/4nU9HfclD7HOnTKu/FLlpZN6S6Ky7u9HwBUnyKNcNibinPML24Z4GaHdW/75OFFm87peu5IKYFcT9OnWk2G2DRdONiJA9KVPAEDCM/3uFGOegOlZ+MzcFD3cvGSiFAE5s4c6QgLXuimC7XTdvCIImUHwBbNDZeLmUXUeOb7Ajid8/Vsha0l22cj9DZr7K1JvaDtfmuwFu6w9PF7yHnlNCAzX5pd0xdZk6BR2efbIImPFzONlA1jgypYhgvTWv7f9uF3ie36MF55fabuavvifsj9gGG+fDWFI0e0rF6sbwVPcVVWKOGpPqCHOuj3GYTfs7NDX6fwLEc5cQLI95NpQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(36860700016)(376014)(23010399003)(1800799024)(10067099003)(22082099003)(18002099003)(56012099006)(11063799006)(261021135927099003)(261028144727099003)(261009223027099003)(261102123227099003)(261026121527099003)(261026140227099003)(261022075727099003)(261022105027099003)(261021121427099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Vv/edCQ9TsX91Luh+/2/4zX+munRAqA6+bvSsrn+ukNogl17Vok9CZlVgqyvSyj6smwiTWgPJcNm6lDgbDNmr9cqJNQGssiV05mUj6cKqDVIRHGHPqldfzV8vO+eLKJddksQJfvWMeXOsCENC27kyw23AiVKvhp38ni7bGc0ipnp41LB7FrE8VXcrEaMZfd66ef/Pn3yoMA0dEEfP6T5ZQx2pHcquHzBbZXYg6eNH2hNEMctaOcSPKAJVCO1xzaOX34NKS1/cQXDYtzUmV2z/hGsD8e1p+3kljB0yUb/etqfZzKZt6j9q1iuzBnQ0/xt7HsXgbZOl+YO9+xUKrYwbcky95pHIPn60Tbkw75N49GROg4TRoBFtz+NiehYQ/AZhKwC2/7gQjk3pN4k8fu/cjtkzIiy/8FzTDTg+viHWzIFxdxglLCGCKeyFa0KyW33
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 05:43:55.4619
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cdd0662-d798-47ba-3c08-08df3bc8f25e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM3PEPF000265C6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8791

From: Zhi Wang <zhiw@nvidia.com>

vGPU communication buffers need CPU access to regions within their
VramBlocks. Add BarMapping to map these regions through BAR1, including
regions that start or end within a page.

Retain the backing region and borrow BarUser and the MM mutex for the
mapping's lifetime. Restrict CPU accesses to the region's byte range,
and unmap on drop using the retained MM dependency.

Provide an explicit unmap operation so owners can observe errors before
releasing resources. Keep the mapping and backing region on failure,
remember the first error and reject subsequent accesses. Owners must
retain failed mappings until device teardown; drop does not retry an
unmap that already failed.

Cc: Alistair Popple <apopple@nvidia.com>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
Signed-off-by: Alok Kumar <alkumar@nvidia.com>
---
 drivers/gpu/nova-core/mm/bar_user.rs | 145 +++++++++++++++++++++++++++
 1 file changed, 145 insertions(+)

diff --git a/drivers/gpu/nova-core/mm/bar_user.rs b/drivers/gpu/nova-core/mm/bar_user.rs
index 7f389aea7ca3..d4364f94b13e 100644
--- a/drivers/gpu/nova-core/mm/bar_user.rs
+++ b/drivers/gpu/nova-core/mm/bar_user.rs
@@ -7,6 +7,10 @@
     io::Io,
     new_mutex,
     prelude::*,
+    ptr::{
+        Alignable,
+        Alignment, //
+    },
     sync::Mutex, //
 };
 
@@ -18,6 +22,7 @@
             MappedRange,
             Vmm, //
         },
+        vram::VramRegion,
         GpuMm,
         Pfn,
         Vfn,
@@ -180,6 +185,146 @@ fn drop(&mut self) {
     }
 }
 
+/// A BAR mapping that retains its backing VRAM region.
+#[must_use]
+pub(crate) struct BarMapping<'map, 'gpu> {
+    access: BarUserAccess<'map, 'gpu>,
+    mm: &'map Mutex<GpuMm<'gpu>>,
+    region: VramRegion,
+    region_offset: usize,
+    region_size: usize,
+    unmap_error: Option<Error>,
+}
+
+#[expect(dead_code)]
+impl<'map, 'gpu> BarMapping<'map, 'gpu> {
+    /// Maps the containing pages while restricting CPU access to the requested byte range.
+    pub(crate) fn new(
+        bar_user: &'map BarUser<'gpu>,
+        mm: &'map Mutex<GpuMm<'gpu>>,
+        region: VramRegion,
+        writable: bool,
+    ) -> Result<Self> {
+        let page_size: u64 = PAGE_SIZE.into_safe_cast();
+        let page_align = Alignment::new::<PAGE_SIZE>();
+
+        let region_start = region.address();
+        let region_end = region_start.checked_add(region.size()).ok_or(EOVERFLOW)?;
+
+        let map_start = region_start.align_down(page_align);
+        let map_end = region_end.align_up(page_align).ok_or(EOVERFLOW)?;
+        let map_size = map_end.checked_sub(map_start).ok_or(EINVAL)?;
+        let num_pages = usize::try_from(map_size / page_size).map_err(|_| EOVERFLOW)?;
+        if num_pages == 0 {
+            return Err(EINVAL);
+        }
+
+        let region_offset = usize::try_from(region_start - map_start).map_err(|_| EOVERFLOW)?;
+        let region_size = usize::try_from(region.size()).map_err(|_| EOVERFLOW)?;
+
+        let mut pfns = KVec::with_capacity(num_pages, GFP_KERNEL)?;
+        for page in 0..num_pages {
+            let page = u64::try_from(page).map_err(|_| EOVERFLOW)?;
+            let byte_offset = page.checked_mul(page_size).ok_or(EOVERFLOW)?;
+            let address = map_start.checked_add(byte_offset).ok_or(EOVERFLOW)?;
+            pfns.push(Pfn::from(VramAddress::from_raw(address)), GFP_KERNEL)?;
+        }
+
+        let access = bar_user.map(&mut mm.lock(), &pfns, writable)?;
+
+        Ok(Self {
+            access,
+            mm,
+            region,
+            region_offset,
+            region_size,
+            unmap_error: None,
+        })
+    }
+
+    pub(crate) fn region(&self) -> &VramRegion {
+        &self.region
+    }
+
+    pub(crate) fn gpu_va_addr(&self) -> Result<u64> {
+        self.access()?
+            .base()
+            .into_raw()
+            .checked_add(u64::try_from(self.region_offset).map_err(|_| EOVERFLOW)?)
+            .ok_or(EOVERFLOW)
+    }
+
+    pub(crate) const fn size(&self) -> usize {
+        self.region_size
+    }
+
+    fn access(&self) -> Result<&BarUserAccess<'map, 'gpu>> {
+        if self.access.mapped.is_none() {
+            return Err(ENODEV);
+        }
+        if let Some(error) = self.unmap_error {
+            return Err(error);
+        }
+        Ok(&self.access)
+    }
+
+    fn access_offset(&self, offset: usize, width: usize) -> Result<usize> {
+        let region_end = offset.checked_add(width).ok_or(EOVERFLOW)?;
+        if region_end > self.region_size {
+            return Err(EINVAL);
+        }
+
+        let access_offset = self.region_offset.checked_add(offset).ok_or(EOVERFLOW)?;
+        if !access_offset.is_multiple_of(width) {
+            return Err(EINVAL);
+        }
+
+        Ok(access_offset)
+    }
+
+    pub(crate) fn try_read32(&self, offset: usize) -> Result<u32> {
+        self.access()?
+            .try_read32(self.access_offset(offset, size_of::<u32>())?)
+    }
+
+    pub(crate) fn try_write32(&self, value: u32, offset: usize) -> Result {
+        self.access()?
+            .try_write32(value, self.access_offset(offset, size_of::<u32>())?)
+    }
+
+    pub(crate) fn try_write64(&self, value: u64, offset: usize) -> Result {
+        self.access()?
+            .try_write64(value, self.access_offset(offset, size_of::<u64>())?)
+    }
+
+    /// Unmap while retaining the mapping and its backing storage on failure.
+    ///
+    /// The first error is retained; later calls do not retry the operation.
+    pub(crate) fn unmap(&mut self) -> Result {
+        if let Some(error) = self.unmap_error {
+            return Err(error);
+        }
+        let result = self.access.unmap(&mut self.mm.lock());
+        if let Err(error) = result {
+            self.unmap_error = Some(error);
+        }
+        result
+    }
+}
+
+impl Drop for BarMapping<'_, '_> {
+    /// Drop unmaps the region and may sleep. Call [`Self::unmap`] to observe errors;
+    /// on failure the owner must retain this object until device teardown.
+    fn drop(&mut self) {
+        if self.unmap_error.is_some() {
+            return;
+        }
+        if let Err(error) = self.unmap() {
+            kernel::pr_err!("failed to unmap BAR1 region: {:?}\n", error);
+        }
+    }
+}
+
 /// Run MM subsystem self-tests during probe.
 ///
 /// Tests page table infrastructure and `BAR1` MMIO access using the `BAR1`
-- 
2.53.0


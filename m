Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.40
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793943795;
	b=jTBxa2s1Mq7T56B1s/xygE6oH62YGrTkiUynyc94RFd5LoWIRYtdi6toasF+jb481pBW
	 nI59Pf2KsCbieNm2b31j6KfFEdDSqwnslNuNgTP3XUCqQzbt7HT6v0vnVlVtO8GLN1kRX
	 zaiM5rVdNdKR0YWRqdocm98xpJlObiPPFNeDpP3ugqN6Xq2YXpfSaOawLytVfx2M57Yvh
	 UYsuSp9b5HKu9isqjT/T6i9GEPPpfvArWrmYm3d9X+tpoweHgyU8650+ASwln4MPXJFA/
	 mUteLUQf69ZtJ8dC0anaXrRwfHs2csPrNCxYwFDU+KqtHiGDPARpHZus1TSCAp789GQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793943795;
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
	bh=45+6ZZqP9kDgYz8r9//ysGdCDaSlxs8D5PICdbELNPM=;
	b=C1Jo+TfHAM78WYrf/SJ9aBoW4eikbNp8blEkTfQr8RyFXisVLmlhnMjmyohS1SZHsZIj
	 TBrg0vMRMeK0HQqsWFHUpDht6Pa20xwwzDL6ee8Ej9q6ZkyRJu5wQB5Qq/E99ySr7tGdM
	 n0LQP/VsIKbteSbDbJoF1CAT3qBkFWMGakkDp0m+GQPBCg4YWrwiKOipvKJ0FYgpmgF/5
	 w+6eysRMfxaSuqS7aRy2/tVWOpVe/32s2k+LE49sAefKlVc5tqAafBN896oBu8IchIqPj
	 sG/S6zhdiY7X+qRlejtfxfoKTirP5wrPfDrWMMrb2D72GX2PQNT5crZyFi9eD6dlT2g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=NtWPlute;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.40
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010040.outbound.protection.outlook.com [52.101.85.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8165606A326;
	Fri,  6 Nov 2026 05:43:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8165606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=NtWPlute
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kvp7BOnPjfgfzMm3gjtbpQ/Xn6z0Os7IWUQs5W76734ldQWMosTwOM0KSHj2uRAKxQl9zNtXrkILepCNFQSIAhOn9dOaqbgg9IckkgKkKDDq3INLLe6gkoCMlepGZoqqsDO1yD17p2OkO3A/D3a4jvWytoQJRfJx7E6KgYvUxwEHVIyL3nwQrvsf6YrpnhgiQT2W/sH5REUI6S53KvnSNpXyxhGDcHJwiRyl/f6vtdLKBSkA9i+Ogsz/ZQYJY3a5uvJA0oIef2SLBjbe1BPzGvc8i+0y4e8v103chqHACbnzeuz9NQNkWtPixBGxSfFs8EoR3Kq4LQ/igjlyBNi4og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=45+6ZZqP9kDgYz8r9//ysGdCDaSlxs8D5PICdbELNPM=;
 b=EqH7mvKC6PwXG2Fp6K5x/26+XtcWQOYf3GkVRDB2xOzrwa7wBooHEE1YfAJToc3cXVBQRdRIMdB6EiqSZvjkD3TIL+X+380iAwh6llmOpWyllZyoqgub3J2T0VSnjEfsW/nZI3Qy7ZVdSu0BDnUE4gl0JE1lKx46fI8ZlZMn99520WIwf1ZSgI1BEC6xb4miMETJBW1oBNxWvC3RPsUNUmfDQkB1iTEbtwBgwNOM75RD+H4vD/Jnh4xVBjYvOcxjwwp1S9JtZQZ0vcQJ805vlKrg+pZ6WWeoDUty/kfL1CV5WzBdVynliVCFAOv86iaBdIonMwWpISJtIjsH1xmxZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=45+6ZZqP9kDgYz8r9//ysGdCDaSlxs8D5PICdbELNPM=;
 b=NtWPluteWIikj102PDqzJcjH70oyxzSkP27GAybq7chTTgKGsSaSVGIyHynKzozJ551zpt/q5VxmYfzSK/bAA72Yq1MFGYqRFoqlikc09he082zNV/qeRlssL/6utSHJtXqfe17Cs2LO5BkEZx8frDzvTJJdfxKLZBQJF/R201oxJauGUgSG1eefOPdL8PjTSm18euKs5M08zM7K7LlpaQbEcv4Rvb4oDFmwI2DRmBFLtO6rYUX1l6M4tPkfduJmnVmW1VjS1iIAWUVMPdvf7D0BBMIwxC4zhAOD/+OcRayP8z38Bw0iQ9iXK69YKPnuhQpwRSg7aOEi91H77NRGSA==
Received: from PH7P220CA0118.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32d::18)
 by SA5PPF8BD1FB094.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8d3) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.11; Fri, 6 Nov
 2026 05:43:08 +0000
Received: from CY4PEPF000392D9.namprd03.prod.outlook.com
 (2603:10b6:510:32d:cafe::98) by PH7P220CA0118.outlook.office365.com
 (2603:10b6:510:32d::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Fri, 6
 Nov 2026 05:43:08 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF000392D9.mail.protection.outlook.com (10.167.247.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 05:43:08 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 5 Nov
 2026 21:42:54 -0800
Received: from kalok-SPC741D16QM3.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 21:42:42 -0800
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
Subject: [PATCH v4 08/32] gpu: nova-core: vgpu: reserve the 48-VM WPR2 heap
Date: Fri, 6 Nov 2026 11:09:41 +0530
Message-ID: <66c6f591bd86612778ba2bdf65aba2971be408f5.1793906667.git.alkumar@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF000392D9:EE_|SA5PPF8BD1FB094:EE_
X-MS-Office365-Filtering-Correlation-Id: 8470a36a-be21-4b32-3012-08df3bc8d66e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|82310400026|7416014|1800799024|23010399003|3023799007|6133799003|18002099003|22082099003|10067099003|261102123227099003|260925022911599003|56012099006|261021121427099003|261022105027099003|11063799006|261026140227099003|261028144727099003|261009223027099003|261021123027099003|260925021911599003|261022075727099003|260925021311599003;
X-Microsoft-Antispam-Message-Info:
	cysq9lSudWtpi32Z9qz2ip/Tcv6hVCUONzhBzFhVDX6gMGHJTt2KUmI8RtIyyAsb7PYkwYvuo2TUH1wMwctjB8sP2kCBCkiW0YDl+w3hyBrjtf9vpfYfDovPL1++E17z2r937L5TzMn72woQ00NvTJD1cKXK+j7HDV/o2bcqODRQftpvLoqkOSHdv4m7ZnZCazIRxfRoa6iFdI3WBY4EVDDYWZv/wY6CLYY79h7nwlW9elpwkKQ8LHEmoKayY2Bkd8aW2DZNEgGlx4J4c/u/YuJ0MdwGiGgWSSDucayc5ubnvBBDc7jotSdbl2FJZRfk7fKH6KCi+GeATxAentHUOL1IuvkfXj8AZnmx3WJRenSuc+XvGmSKcDaLsyVdVSqjWmPH7Vpvbi5jGsBRqDGlJ5rv1wnI/OHDPZ2a9wNauZAt4ahSq08Rhj8pn7Kuw3Ew8NoY9wGFKqbFWPwtoq/mHF/UlJavudkczNUKMYkOvmPd5/WK9Ea5pgjD8qcr7+oO7VgWJLj/qyf9vMiGZ9qzuD7W5Ob2dOBrHwfjpuia811G5bvALKh7/j565q6gy7vNtSJoDoJ14FVn8hVMxpGGStNaatuKBap8lBBLuvAfgGct19Gt7kS9nW4KT+ZaX5u2DqWX8ZdAEjfgLi1EUfVC3k2PlKNQDWy2O/zxHUhOZiyxslzm/vtfK4cBEnqutYqqYo+NRTg6HzrMrYxV9iK45w==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700016)(82310400026)(7416014)(1800799024)(23010399003)(3023799007)(6133799003)(18002099003)(22082099003)(10067099003)(261102123227099003)(260925022911599003)(56012099006)(261021121427099003)(261022105027099003)(11063799006)(261026140227099003)(261028144727099003)(261009223027099003)(261021123027099003)(260925021911599003)(261022075727099003)(260925021311599003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	sU+94pDprFo0lIwR2Lb6IfiFZwEXxuynvbzcHQTYLzI8vLglgS7ukuxjUqU5ufAfA9BPs+h7SEWuypVYhdtv9o820oJ7kYFeRe8ckHu5xkRUB3gGWhSWEfVmIWZrWNFuUx01SMnIQBQ+CI8lWt75A+jmrqWKB/0bZg8dUv+tEmKeWKg7eqMM3uTZOMWO3/4u0qedxXoF/pjUbbwms0ckZtlvCPWE3b6jbxM77ecann7t7FBBRrES0/S7JfSMVAAyuQ/XfvAZzVRKc8nf+pXuDOU62AJ+G9mjwPv3domHDosTeXYGQQ43RN7NF81X3kVKLGk1AaHxqCm48GBi6vaVHQMdWA+djvNbIJgvs9L2WlwvKCckIjI3uiS4qzoaxhMW0mGykXLhLJc1ZsA3fDvA1vvCZ4seQ0GDYuLa50ha2zgKLqh2SYh8NLR/u9joPEVx
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 05:43:08.6302
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8470a36a-be21-4b32-3012-08df3bc8d66e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF000392D9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF8BD1FB094

From: Zhi Wang <zhiw@nvidia.com>

GSP-RM needs the larger r000 vGPU WPR2 heap on devices that
advertise more than 32 VFs. The default heap is too small for the 48-VF
GB202 configuration and GSP-RM fails to start.

Select the firmware-defined 48-VM size from the detected VF count while
retaining the default size for configurations with 2 through 32 VFs.

Signed-off-by: Zhi Wang <zhiw@nvidia.com>
Signed-off-by: Alok Kumar <alkumar@nvidia.com>
---
 drivers/gpu/nova-core/fb.rs                      | 2 +-
 drivers/gpu/nova-core/gsp/fw.rs                  | 7 +++++--
 drivers/gpu/nova-core/gsp/fw/r000_00/bindings.rs | 1 +
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/nova-core/fb.rs b/drivers/gpu/nova-core/fb.rs
index 882827bcfd3a..ba68a812b095 100644
--- a/drivers/gpu/nova-core/fb.rs
+++ b/drivers/gpu/nova-core/fb.rs
@@ -302,7 +302,7 @@ fn wpr2_heap_params(ctx: &gsp::GspBootContext<'_, '_>, fb_size: u64) -> Result<(
         ),
         VgpuState::Enabled { total_vfs } => (
             u8::try_from(total_vfs.get()).map_err(|_| EINVAL)?,
-            gsp::LibosParams::vgpu_wpr_heap_size(),
+            gsp::LibosParams::vgpu_wpr_heap_size(total_vfs.get()),
         ),
     })
 }
diff --git a/drivers/gpu/nova-core/gsp/fw.rs b/drivers/gpu/nova-core/gsp/fw.rs
index f1efd3c66d2d..dfe7aafcf31f 100644
--- a/drivers/gpu/nova-core/gsp/fw.rs
+++ b/drivers/gpu/nova-core/gsp/fw.rs
@@ -138,8 +138,11 @@ pub(crate) fn from_chipset(chipset: Chipset) -> &'static LibosParams {
     }
 
     /// Returns the WPR heap size to reserve when vGPU is enabled.
-    pub(crate) fn vgpu_wpr_heap_size() -> u64 {
-        u64::from(bindings::GSP_FW_HEAP_SIZE_VGPU_DEFAULT)
+    pub(crate) fn vgpu_wpr_heap_size(total_vfs: u16) -> u64 {
+        u64::from(match total_vfs {
+            2..=32 => bindings::GSP_FW_HEAP_SIZE_VGPU_DEFAULT,
+            _ => r000_00::GSP_FW_HEAP_SIZE_VGPU_48VMS,
+        })
     }
 
     /// Returns the amount of memory (in bytes) to allocate for the WPR heap for a framebuffer size
diff --git a/drivers/gpu/nova-core/gsp/fw/r000_00/bindings.rs b/drivers/gpu/nova-core/gsp/fw/r000_00/bindings.rs
index 454d0ea9360f..fa17d3e2edf6 100644
--- a/drivers/gpu/nova-core/gsp/fw/r000_00/bindings.rs
+++ b/drivers/gpu/nova-core/gsp/fw/r000_00/bindings.rs
@@ -84,6 +84,7 @@ impl<T> ::core::cmp::Eq for __BindgenUnionField<T> {}
 pub const GSP_FW_HEAP_PARAM_SIZE_PER_GB: u32 = 98304;
 pub const GSP_FW_HEAP_PARAM_CLIENT_ALLOC_SIZE: u32 = 100663296;
 pub const GSP_FW_HEAP_SIZE_VGPU_DEFAULT: u32 = 609222656;
+pub const GSP_FW_HEAP_SIZE_VGPU_48VMS: u32 = 1436549120;
 pub const GSP_FW_HEAP_SIZE_OVERRIDE_LIBOS2_MIN_MB: u32 = 64;
 pub const GSP_FW_HEAP_SIZE_OVERRIDE_LIBOS2_MAX_MB: u32 = 256;
 pub const GSP_FW_HEAP_SIZE_OVERRIDE_LIBOS3_BAREMETAL_MIN_MB: u32 = 88;
-- 
2.53.0


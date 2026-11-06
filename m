Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.69
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793943908;
	b=umVhdK5SW33M4IYsyty9lBNI+zMWNa6PtH4Oi76VIEiAK9vwL45GYKSolMav4igYORAH
	 H5QJT/IPiiengMYPvIjNTep2rTRWPhgF4q0RxUiuNEU8f6PZPtmEzKhI12F/DUi/hgz4J
	 7VOAZ8c/Dl0VrOxEdiaMawjpafPv7uqtb1SJlaV0LXG5czDBb/ux9FxJRuBYkJ8S3vz3h
	 6o16UI5ImqppDD0A+iKz2aJiMpgd4Z4OgxAfmCPDNi4PjbZIPmmMp/hk4WFcyPOfhKxdB
	 7ZwYgIFtL5guAy1ba9YKl11w5j6hAzwuuVaekZ2IMG3XoVMeH4Zl0BFrM5z7QXB69bA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793943908;
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
	bh=G8mgOswGuepWRRBaUG9ZWm7C68CwS0Zp37xHFTz+mus=;
	b=TfsGMg0zi18IF/FXLqSrzU3WyWIBJ737DLWlUifFZQXRHU0Y2mUMA0WBWOTgsTbtw1Mi
	 B5ftTZ56XNNt2sKYzsvFb2UKO0sxhtOhMlB0I1vMcmTQE/465wpwawMfhV2QvwYqtW2R4
	 S68jlGiDv2Bkp18rUjprzSkt0K6l8cAc9sjmjgqnfpASmSq/ki4XJx7j5m5YJQKrEjov+
	 VDn6KuwkZXXDvOt6SLY548HeELg9H+qiYDtA8lkDGbqyc0Kyjv4uyEsupY5IBuKL0Lt1V
	 lacp82x497oi6nyp+7kJv6n/wBQLv9mj7DabHpXEH1bM0c4PNrna1fVT9JdlHrB0ejw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=cOMeMN7q;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.69
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013069.outbound.protection.outlook.com [40.93.196.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAB7606A332;
	Fri,  6 Nov 2026 05:45:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EDAB7606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=cOMeMN7q
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OjWs2dNuYe6kSW6vGrH4NU3uOTLR2GRFzb94i1ipMwGNawygwl47KuEnxNbHDjicgSDCBElW/aoy4Qvzgkj/gAKA1MQ1flyj9A1Ig9Hb+5uGLYbo4XLpeZ5VKkiSFEL4axYZw1XBOMpGjOOuLB9bE9qdsqbZRVq3940qwzDjs8R9uY5XvbPNA742BRMOKVCp7HRwFmcePNXhzq/NVvwva00TuYvIfLzzykxyTLpGhoxdrfDBaalEv16oqLxEqdHvOct5Va16r1PMqUnMuAw+u1F+Pov+oxi+HF1n92HuKoEFwytzepvzn+6ZoLPnx6Ogb0X2N/gR8fHCgInU3lNrKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8mgOswGuepWRRBaUG9ZWm7C68CwS0Zp37xHFTz+mus=;
 b=Ll+t8s6z5z8vKdtHApzvoxlLLIki9Q+vfcEH5F79MZRL14igKcJxE+JwAaQcgAszOTLYe/eG1FWOCDxaIMnNqrQwU5rjxbsLKUkQU3W8ofWv/L3XVxhEW+EIaKBk/J9rPuMWLs92UXHu6qN2t6PDeETMoQ7Fkz1/PVvBn/T0eaT3e1A+nZXjHs014D/nQGV1i/jNDUSGoakOrOkJWuM9Emp8olhbSzpRvTJi7Eefd6zRzjqdCoQ17uM29ihmY3rGSG35hIAqVCjVNGoIHYhnsUG3b+mYgrR91jgWYAiFJPwh2WFgogx38AM7oafnMMjwBiVkr4RrX/x6SHcXnabBKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8mgOswGuepWRRBaUG9ZWm7C68CwS0Zp37xHFTz+mus=;
 b=cOMeMN7q76xTZSaB7Zy/N279VzlUKxb6HTKB5c4cAS0mU4/JKjdCWh0/K1Cx1iEiyJ0nXC1gnSIqsaSS3bM/gwkskwo620h5gQtCFHCE5ywrkXwkHq4BjpSFM/mOZE5tJjgFrvV406jWyzERu/pmrY96eymc46qbImZemWjOw8Gdm9MAsLjSXPjL9OnX6Q+aaG9FJm1VJOMJKzA21osmmbB44aziSnXzfRjdT3K+SpSbUS7JZ5SG+YdIdWHhbcewLM9HrMrYTqMhrwcThTaMOEW/B92ywoivX+9bYKTXqhfwnlTzk8MtkV87bUgAuuW3xHKAuK2wrQsvqkrp7wRekA==
Received: from MW4PR03CA0334.namprd03.prod.outlook.com (2603:10b6:303:dc::9)
 by LV0PR12MB273923.namprd12.prod.outlook.com (2603:10b6:408:3b5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 05:45:04 +0000
Received: from PH7PEPF00000009.namprd04.prod.outlook.com
 (2603:10b6:303:dc:cafe::25) by MW4PR03CA0334.outlook.office365.com
 (2603:10b6:303:dc::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Fri, 6
 Nov 2026 05:45:03 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 PH7PEPF00000009.mail.protection.outlook.com (10.167.243.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 05:45:03 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 5 Nov
 2026 21:44:47 -0800
Received: from kalok-SPC741D16QM3.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 21:44:34 -0800
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
Subject: [PATCH v4 17/32] gpu: nova-core: gsp: factor out NVKV payload conversion
Date: Fri, 6 Nov 2026 11:09:50 +0530
Message-ID: <6acb8db2973e5fc0047815ab76d121330bd6fff4.1793906667.git.alkumar@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: PH7PEPF00000009:EE_|LV0PR12MB273923:EE_
X-MS-Office365-Filtering-Correlation-Id: 619efaaa-76c7-41c4-6c84-08df3bc91aa0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|82310400026|1800799024|36860700016|56012099006|11063799006|261021123027099003|261102123227099003|261022105027099003|261021121427099003|261009223027099003|261026140227099003|261022075727099003|261028144727099003|22082099003|18002099003|6133799003|10067099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	7sIk2VBQ+EsW2LGeMySR4efi1ldzNRpejtxlpoX3Hq3ZoxYY5YXkYhjWAuGSn4or/ztHdP+/QIWX+PJ90t7bc4R+ph8dWqIrdmUUy8oHZaljv9j4YlDhqFZ+UWS9pAB2VEXfyb164SUFJVu2m7zwcFdGSyYuORej6qW0vVC2uH7Otl+oLlQhS2hLI5CpYRBUQflFCfXaOroTza8zXbMzTHN+BhaQULSmUt6CTYQn774xiNOaGzaR32dpLrqMwoP0X8llF40+9PqUXDoxJy5BU5CFnAAX6+uLwrorXcm5PP/Ks0bnSblT674ApBYFuIhXqcY8j8V4NnS/yfoy1e6MEr2k79YZMo+xPe3kRqNpInUVX/hrpywhMXVx1CBv2Aqm3K2YF1hB5qeJmFLPpRoq2GVMFsV4pTLCF+q+N+FCPI25w/Q6QnOJTzfgirgygQDOOYRgaYstyLy0Q2Zo59f3d2F3ODaJwu3OwghabYEtRRHq3CvL9Y6//L/ygZ3k27KSVlAxQW/9MD5zKQN+2Z6yPjbPUQ5lLhiJwcJzYhDig3awSxv+fPCeyp1D3x6E50AjmBWCC5ho4shCK315wf82C0nvaPv9XTSLmZqwkHf6H64zDK6MA4ty0D3OlixxsXOeZQG/Vph9EphEnhSvNV4PF3iv0TT3sN/P8qY9Ynoz3sI9DWXxVmOK8UBNt3Zd90YVk1ZoqwaG2pPS8u7MPFaQfg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(82310400026)(1800799024)(36860700016)(56012099006)(11063799006)(261021123027099003)(261102123227099003)(261022105027099003)(261021121427099003)(261009223027099003)(261026140227099003)(261022075727099003)(261028144727099003)(22082099003)(18002099003)(6133799003)(10067099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ZSPugBiDaK1NAw6cUEh9tDgqCitYspMJa+kyxZEr3d8ZJlcLm3qbwxPZtHxIqnRrFcv1VHRaU4b1cNp9BetIpEyAX085KCBKyrNIbkLHR8hHxo22lt2O9glpESRDlfupMzELzDcHpi3HItSsiBSvtu+MhrHiq7xue1GUmTZbHWMfwjK/cnIG2nyF2Ta4NOUzp5uqbXrtk+mA34xuFT2XYvTntzTyq9d6IENip/TPwrtOfMznbxDZLsuH2xi9nxdCIVyfFdqk5MKzhgvOS7YD3hD+UonOS5SRkyNBSm6Ieo/tSrYmRRVOMMzK70lnOv6WFfXYNbnDy0AWTsY4QCyn/hJo9F19PyeFm6FWQHxdGFVbtc6S33ICOWdW9jUlXLC/evQ3MefFWOTQjGTIlV2Evnu9CIuPH0uII7WS0WJrXI3pQBxiYT5ZzPNcDktUpVDU
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 05:45:03.0530
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 619efaaa-76c7-41c4-6c84-08df3bc91aa0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	PH7PEPF00000009.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB273923

From: Zhi Wang <zhiw@nvidia.com>

Both GSP initialization and vGPU property queries decode their replies as
NVKV streams.

Move the byte-to-word conversion helper into the NVKV module and make
that module accessible to the vGPU firmware interface.

No functional change is intended.

Signed-off-by: Zhi Wang <zhiw@nvidia.com>
Signed-off-by: Alok Kumar <alkumar@nvidia.com>
---
 drivers/gpu/nova-core/gsp.rs              |  2 +-
 drivers/gpu/nova-core/gsp/commands/gmc.rs | 12 ++-------
 drivers/gpu/nova-core/gsp/nvkv.rs         | 31 ++++++++++++++++++++++-
 3 files changed, 33 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp.rs b/drivers/gpu/nova-core/gsp.rs
index cac123cbeac4..8424aa3937e7 100644
--- a/drivers/gpu/nova-core/gsp.rs
+++ b/drivers/gpu/nova-core/gsp.rs
@@ -28,7 +28,7 @@
 pub(crate) mod cmdq;
 pub(crate) mod commands;
 mod fw;
-mod nvkv;
+pub(crate) mod nvkv;
 mod regs;
 
 pub(crate) use fw::{
diff --git a/drivers/gpu/nova-core/gsp/commands/gmc.rs b/drivers/gpu/nova-core/gsp/commands/gmc.rs
index 6f88c99349ac..33aea614cf72 100644
--- a/drivers/gpu/nova-core/gsp/commands/gmc.rs
+++ b/drivers/gpu/nova-core/gsp/commands/gmc.rs
@@ -29,6 +29,7 @@
             GmcCommandId, //
         },
         nvkv::{
+            nvkv_words,
             Decoder,
             Encodable,
             Encoder,
@@ -151,16 +152,7 @@ impl MessageFromGsp for GspStaticInfo {
     fn read(payload: &mut SBufferIter<core::array::IntoIter<&[u8], 2>>) -> Result<Self> {
         let bytes = payload.flush_into_kvec(GFP_KERNEL)?;
 
-        let chunks = bytes.chunks_exact(size_of::<u64>());
-        if !chunks.remainder().is_empty() {
-            return Err(EINVAL);
-        }
-        let mut words = KVVec::with_capacity(chunks.len(), GFP_KERNEL)?;
-        for chunk in chunks {
-            // `chunks_exact` yields slices of exactly `size_of::<u64>()` bytes.
-            let word = chunk.try_into().map_err(|_| EINVAL)?;
-            words.push(u64::from_le_bytes(word), GFP_KERNEL)?;
-        }
+        let words = nvkv_words(&bytes, &[])?;
 
         let decoder = Decoder::new(&words, UnknownKeyPolicy::Ignore);
         let mut schema = KBox::init(GspInitResponseSchema::init(), GFP_KERNEL)?;
diff --git a/drivers/gpu/nova-core/gsp/nvkv.rs b/drivers/gpu/nova-core/gsp/nvkv.rs
index f81a9e60d89c..5887a61af02a 100644
--- a/drivers/gpu/nova-core/gsp/nvkv.rs
+++ b/drivers/gpu/nova-core/gsp/nvkv.rs
@@ -20,11 +20,40 @@
 use kernel::{
     alloc::ArrayVec,
     bitfield,
-    num::Bounded, //
+    num::Bounded,
+    prelude::*, //
 };
 
 use crate::bounded_enum;
 
+use crate::sbuffer::SBufferIter;
+
+/// Joins the two halves of a wrapped payload into the `u64` words an NVKV stream is made of.
+///
+/// # Errors
+///
+/// - `EINVAL` if the combined length is not a whole number of words.
+/// - `ENOMEM` if the buffer cannot be allocated.
+pub(crate) fn nvkv_words(payload_0: &[u8], payload_1: &[u8]) -> Result<KVVec<u64>> {
+    const WORD_SIZE: usize = size_of::<u64>();
+
+    // Each byte slice is at most `isize::MAX` bytes, so their sum fits in `usize`.
+    let len = payload_0.len() + payload_1.len();
+    if len % WORD_SIZE != 0 {
+        return Err(EINVAL);
+    }
+
+    let mut words = KVVec::with_capacity(len / WORD_SIZE, GFP_KERNEL)?;
+    let mut bytes = SBufferIter::new_reader([payload_0, payload_1]);
+    for _ in 0..len / WORD_SIZE {
+        let mut word = [0u8; WORD_SIZE];
+        bytes.read_exact(&mut word)?;
+        words.push(u64::from_le_bytes(word), GFP_KERNEL)?;
+    }
+
+    Ok(words)
+}
+
 mod encode;
 pub(crate) use encode::*;
 
-- 
2.53.0


Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793943780;
	b=uM3LN1iMgrOzezGg/7JIyWKRx5pHj6Hssg+7qHFb6uNjrLhQ//a5BDGy7B+NVpnY+K2n
	 zUPLsSgIBEWJeAnapm11ywywNs1COBFSELqEHDUkbCqNqOIcYnA79JrGmVY8dv7uXn9Ax
	 DJXneNG6Ury7W1k8Y0LT8elU6GSDs4UpopQV1kFZ9XFe9VlERJ4wsrwqcr8nt7OXQdmqP
	 jvZGqHrtTOI2Dkxr5JhbKHBScOKe2OcgLPC7num5oqXCr++V0agntTkPtwylwwQqKiG85
	 Zk6gGvbTS881aaQj2BNyfuuP/0MlDVxeXgHW2Vs6PJa3NL2uOno2DrB/HTNrbww503Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793943780;
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
	bh=4+od1AHOrgWZOoZEEBBWaD71t1PxJcDSwVIKa83rZSU=;
	b=v882QOds/Ss8wPXMvtSNA/5qgFpqBx2ezTI3XWNgR+t80NV38awYgw61T6c5JkuTJk86
	 HJocs0P5SS5Zdk+cK1VSfitEf1qieolOerWRjS0VgX0EGsCHiqE7z1M3p2PCkKFNEMH5X
	 bFkrHWeti/96zWjsAyDyIlP3d6RRUVnasRoJs6VaJm3I1YD8oEbyxuor7s0YJf/0ZODaH
	 vYnsQWUc1NIqD43aTlZ3kpuaZlm1DB3yAppeQMyNMPb1b+v1swBxg1e3JkD76Aa0+a81Q
	 dr1RAs9ZAuwA1vZaQaPjdrxynRLkQ39Tj3zoOaVL+sBBg93p0He+e6ktWB5pGCYJgXw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=hlw3iHe5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.41
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011041.outbound.protection.outlook.com [52.101.62.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F698606A326;
	Fri,  6 Nov 2026 05:42:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F698606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=hlw3iHe5
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UA9zRbdTX3u5SQXoVtilkhgCeiB82uSWbBROZTn7hl1OzYbPPK4libGjdmIbdwtkRtLgEL0yHhDEn4kwm+y+WJB5HGaA4hIhrXYJCykWi2kUqFbSXVT5tA9gc6OgmGq4dvVL++Ywoz/at+G5WpIEjjsJUpobIN8qsln0KQ9T+mmhy1XvPVnRT8K59/NwgmYqzCaSPDHv9gb0xIRbZm8EZeiyQn+mmqhdTv0jDUPBTY1NCywEQGlJXIvnJMNL7xLTL3m8bf45EqClEEZOkrV5tAWNdUXItQkK3lj+U7GkpGMxT950spXHjjix6lY5fBuMZeNrvgEa9G036t0kjtrAGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4+od1AHOrgWZOoZEEBBWaD71t1PxJcDSwVIKa83rZSU=;
 b=SXnae1qHLAHvMkfztWW+YkFIhcAJx6BZFJ68u3pTCfb6drzx7ACwMoaUa7nJetsZjxHmBNR9TaRWY8zZrVPpahRpg6kkWi3J/sbhWcFd2+5LtSu/sX8cjiyWFT47rhEWhlX8oswEa/cBW5zrQfAWKVz+yre3BzwGvclLuNVAf0bu8W2Xq+J99JLupPX3rPDyDXznnJlnSNTa+3HpyzU1mnCOWpYXroBEX/efLZbDjGuqNslF37wMum3xbfKdCN/EWLtvg44LZBxzTk/+lCpXR4Atk0TmfJBc2VqHz738734xqSrb2sbyd16YyCnbZCkiIl4RYcQoIrLZ0U6XGy8v8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4+od1AHOrgWZOoZEEBBWaD71t1PxJcDSwVIKa83rZSU=;
 b=hlw3iHe59YURrLmvEA1pdkZdiIV4zpYbKgLPX61SQGm8qFhN+MHWFPow/tVP9RzadRqQbQvz0vupzHAvb7DjzoTzEMN/VB7aoumalgG9/gbqRzyFCjHsK/89vH+ifNM1L58Wl/1li30yiTTwqGuuAXCPzhwRmK11Hu5eOWYYFsv7/c9gKwYKWL0U82u+2j/c3twrfOMq/2XGk4TSDlyF34EF0qv0FIGTw1ldhDBxR6o0VW6QXgPgwi2CQajVGxWmNRuqu/qoeSXfqwpdrohhKz8FfeUpMmb5tf/6TQ4Wn46TNoQ4e1BO1jCTB+6iGBrqc6IpY+7yWZp5j90SjYyWdA==
Received: from DS1PR05CA0004.namprd05.prod.outlook.com (2603:10b6:8:457::7) by
 CH2PR12MB4101.namprd12.prod.outlook.com (2603:10b6:610:a8::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.12; Fri, 6 Nov 2026 05:42:44 +0000
Received: from DM3PEPF000265C0.namprd03.prod.outlook.com
 (2603:10b6:8:457:cafe::a5) by DS1PR05CA0004.outlook.office365.com
 (2603:10b6:8:457::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4 via Frontend Transport; Fri, 6
 Nov 2026 05:42:44 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM3PEPF000265C0.mail.protection.outlook.com (10.167.23.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 05:42:44 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 5 Nov
 2026 21:42:30 -0800
Received: from kalok-SPC741D16QM3.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 21:42:17 -0800
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
Subject: [PATCH v4 06/32] gpu: nova-core: gsp: decode the FIFO engine table
Date: Fri, 6 Nov 2026 11:09:39 +0530
Message-ID: <340c9bb08c456c19d8768f19d4dc0bc4b3bf34b1.1793906667.git.alkumar@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DM3PEPF000265C0:EE_|CH2PR12MB4101:EE_
X-MS-Office365-Filtering-Correlation-Id: 6881c5ed-a42e-488d-6f18-08df3bc8c7fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|1800799024|376014|82310400026|36860700016|261009223027099003|261021123027099003|261021121427099003|261021135927099003|261022075727099003|11063799006|56012099006|261028144727099003|261022105027099003|261026140227099003|10067099003|18002099003|261102123227099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	opavxQrwjNiF6wjXFdit8PNhLSnn+4pRwH4XMD8AnowmLKZAEL/nuDqFkIdcfPoJqyOUbzJOkHYSA10a7AYMiVwg+5M26MKEs1r6MIsuWerJhw/BnsfpPcyarkMVv8/aw7eSspSH5wl1wR/8jVkBeIOZegtNHCzkwJkadZUno5/OBQZWEHy3oX9YyFxPndrUKvh6v+MeYfDXJLjDGkIvh/+u70pWoG1Zr4ay2ghLOUU9xPg0aUS13bJAqCFY6KkmOXQayBG7IEANlPUiw6dUNtSc0nk4qLtOJAXBS+6dpTue/gP5E3Mg36MXEHnBJZkUN0bkrP0eJVJRX0UWN2YAOapBaMfwvK0iFCz4R3CczmF6wABYyA0rQP84+RGaiDnBD/JnD0mnBk/B8Gz5PtMy2yly1EZsaUSDirMDByo3QoH/9hwGeVD87Vks0Buoho7/mOR8Zcj3Pz+slBmgCBUo3P+3pQR0s3f5EZy+J3kVh3zmwwTzObyZ7PXHU3cgYoilZ0oLvJBD7jjpuIxynV3o2mXHO04il2IvRsINDVZml33ffcLd/ZkQEr2Z/hHyY6HYhCGJXoUJkxsOajryXzglUD5oV9G4jf6RmZIYa2uI7EWHyedPE1TEsiCf+UsSABtuZz/W1WiLIjaeGtvS1/p+MXGDD9MLpj3xaLT+OkKaTsaC7jbVa51glRhKp6zSI+UAQuAD5Q5QmJ/sJwMk9xPXmA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(1800799024)(376014)(82310400026)(36860700016)(261009223027099003)(261021123027099003)(261021121427099003)(261021135927099003)(261022075727099003)(11063799006)(56012099006)(261028144727099003)(261022105027099003)(261026140227099003)(10067099003)(18002099003)(261102123227099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	6VEesdqmvXtCwX8XLAOD98XqDCmFgUJpZJoagiwkT4yZzNIr2E7Fam8nXIjFdjJl9IMxFAJ9qiFMCbay/zYl3tq/1ZzeppjMZjx1p5trkO+QCZdX1SKtQCuzHdQ8HCo4YpVEe8/rLTGiyaugb/OUZ0iznIOTPCMszMWpYk+br1TYcK+3lI7mnK/0BrgLBwPfELBc3jP7i7yY0kJudJglcd6o8ZBtj7VXt1xcdaeRcXP/ZrYPUEfFseasjQ5YvsjDH7YDqPLbJFzuKwUcGw276M50Uv4ImMgFsOV6nAqoSPyqbGxdia6l/8pRpX42hQhJOHsHgiYetf/mvRbZ8VtkmnC+nlIflSkgNf+zA2HGcxIMcGxCvXqFBH9HX1x1ST2nHMFTNmBgiOicPzOXDaQXviVjQiJ2cfKRgW1vPh/76nyIt2ATgQmRfFf9GAOqZs9z
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 05:42:44.3607
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6881c5ed-a42e-488d-6f18-08df3bc8c7fc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM3PEPF000265C0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4101

GSP_INIT reports the FIFO engine topology used to build the channel map
for vGPU instances.

Decode the count, GMC IDs and flags into GspStaticInfo and expose
host-driven engines in firmware FIFO order, retaining repeated IDs.
Reject counts and indexed entries beyond the driver's 64-entry table
capacity rather than silently accepting a prefix. An omitted count
remains zero.

Cc: Alexandre Courbot <acourbot@nvidia.com>
Co-developed-by: Zhi Wang <zhiw@nvidia.com>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
Signed-off-by: Alok Kumar <alkumar@nvidia.com>
---
 drivers/gpu/nova-core/gsp/commands.rs     | 10 +++
 drivers/gpu/nova-core/gsp/commands/gmc.rs |  4 +-
 drivers/gpu/nova-core/gsp/fw/commands.rs  | 77 +++++++++++++++++++++++
 3 files changed, 90 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/nova-core/gsp/commands.rs b/drivers/gpu/nova-core/gsp/commands.rs
index 8b047744c36d..f5ec27995627 100644
--- a/drivers/gpu/nova-core/gsp/commands.rs
+++ b/drivers/gpu/nova-core/gsp/commands.rs
@@ -11,6 +11,8 @@
 
 use kernel::prelude::*;
 
+use super::fw::commands::FifoEngineList;
+
 /// The static GPU configuration, which GSP-RM reports in reply to [`GspInit`](gmc::GspInit).
 pub struct GspStaticInfo {
     gpu_name: [u8; Self::MAX_GPU_NAME_LEN],
@@ -23,6 +25,8 @@ pub struct GspStaticInfo {
     pub(crate) usable_fb_regions: KVec<Range<u64>>,
     /// Exclusive end of the FB physical address space.
     pub(crate) total_fb_end: u64,
+    /// Host-driven engines in firmware FIFO order.
+    fifo_engine_list: FifoEngineList,
 }
 
 /// Error type for [`GspStaticInfo::gpu_name`].
@@ -63,6 +67,12 @@ pub fn gpu_short_name(&self) -> core::result::Result<&str, GpuNameError> {
             .map_err(GpuNameError::InvalidUtf8)
     }
 
+    /// Returns the host-driven engines in their firmware FIFO order.
+    #[expect(dead_code)]
+    pub(crate) fn fifo_engine_list(&self) -> FifoEngineList {
+        self.fifo_engine_list
+    }
+
     /// Returns the total usable VRAM size in bytes, i.e. the summed lengths of all usable FB
     /// regions.
     pub fn vram_size(&self) -> u64 {
diff --git a/drivers/gpu/nova-core/gsp/commands/gmc.rs b/drivers/gpu/nova-core/gsp/commands/gmc.rs
index 890462beb11f..c9258ee9e059 100644
--- a/drivers/gpu/nova-core/gsp/commands/gmc.rs
+++ b/drivers/gpu/nova-core/gsp/commands/gmc.rs
@@ -145,7 +145,8 @@ impl MessageFromGsp for GspStaticInfo {
     /// # Errors
     ///
     /// - `EINVAL` if the payload is not a whole number of NVKV words, if the stream is malformed
-    ///   or omits a required key, or if GSP-RM reported no framebuffer region.
+    ///   or omits a required key, if GSP-RM reported no framebuffer region, or if the FIFO engine
+    ///   count or indexed entries exceed the supported table capacity.
     /// - `ENOMEM` if the words or the decoded regions cannot be allocated.
     fn read(payload: &mut SBufferIter<core::array::IntoIter<&[u8], 2>>) -> Result<Self> {
         let bytes = payload.flush_into_kvec(GFP_KERNEL)?;
@@ -184,6 +185,7 @@ fn read(payload: &mut SBufferIter<core::array::IntoIter<&[u8], 2>>) -> Result<Se
             bar1_pde_base: reply.bar1_pde_base(),
             usable_fb_regions,
             total_fb_end: reply.total_fb_end().ok_or(EINVAL)?,
+            fifo_engine_list: reply.fifo_engine_list(),
         })
     }
 }
diff --git a/drivers/gpu/nova-core/gsp/fw/commands.rs b/drivers/gpu/nova-core/gsp/fw/commands.rs
index bda6a7ef5ef7..07115ccf3e95 100644
--- a/drivers/gpu/nova-core/gsp/fw/commands.rs
+++ b/drivers/gpu/nova-core/gsp/fw/commands.rs
@@ -21,8 +21,10 @@
             nvkv_decode,
             nvkv_encode,
             Accumulated,
+            DecoderValue,
             Encodable,
             Encoder,
+            Indexed,
             Key,
             Required,
             TruncatingArray, //
@@ -307,6 +309,52 @@ pub(crate) fn new(ctx: &GspBootContext<'_, '_>) -> Result<Self> {
 
 // Decode:
 
+const MAX_FIFO_ENGINES: usize = 64;
+
+/// Bit mask for `NVGMC_SC_ENGINE_FLAGS_IS_HOST_DRIVEN`.
+const ENGINE_FLAGS_IS_HOST_DRIVEN: u32 = 1 << 0;
+
+/// Host-driven GMC engine IDs in hardware FIFO order, including any repeated IDs.
+///
+/// # Invariants
+///
+/// `count` is at most [`MAX_FIFO_ENGINES`]. The first `count` slots are the retained engine IDs.
+#[derive(Copy, Clone)]
+pub(crate) struct FifoEngineList {
+    gmc_ids: [u32; MAX_FIFO_ENGINES],
+    count: usize,
+}
+
+impl FifoEngineList {
+    #[expect(dead_code)]
+    pub(crate) fn gmc_ids(&self) -> &[u32] {
+        // PANIC: The type invariant bounds `count` by the array capacity.
+        &self.gmc_ids[..self.count]
+    }
+}
+
+/// A FIFO engine count that fits the supported tables.
+///
+/// # Invariants
+///
+/// The count is at most [`MAX_FIFO_ENGINES`].
+#[derive(Default)]
+struct FifoEngineCount(usize);
+
+impl TryFrom<DecoderValue<'_>> for FifoEngineCount {
+    type Error = Error;
+
+    fn try_from(value: DecoderValue<'_>) -> Result<Self> {
+        let count = crate::num::u32_as_usize(u32::try_from(value)?);
+        if count > MAX_FIFO_ENGINES {
+            Err(EINVAL)
+        } else {
+            // INVARIANT: The count was checked against the table capacity above.
+            Ok(Self(count))
+        }
+    }
+}
+
 // Should decode with UnknownKeyPolicy::Ignore.
 nvkv_decode! {
     /// Schema for the `GSP_INIT` response.
@@ -317,6 +365,9 @@ pub(crate) struct GspInitResponseSchema => GspInitResponse {
         fb_regions: Accumulated<FbRegionSchema>,
         bar1_pde_base: Required<Key<u64, 0x1020>>,
         vmmu_segment_size: Key<u64, 0x1050>,
+        fifo_engine_count: Key<FifoEngineCount, 0x0500>,
+        fifo_engine_gmc_ids: Indexed<u32, MAX_FIFO_ENGINES, 0x0501>,
+        fifo_engine_flags: Indexed<u32, MAX_FIFO_ENGINES, 0x0502>,
     }
 }
 
@@ -328,6 +379,9 @@ pub(crate) struct GspInitResponse {
     fb_regions: KVVec<FbRegion>,
     bar1_pde_base: u64,
     vmmu_segment_size: u64,
+    fifo_engine_count: FifoEngineCount,
+    fifo_engine_gmc_ids: [u32; MAX_FIFO_ENGINES],
+    fifo_engine_flags: [u32; MAX_FIFO_ENGINES],
 }
 
 impl GspInitResponse {
@@ -381,6 +435,29 @@ pub(crate) fn total_fb_end(&self) -> Option<u64> {
             .checked_add(1)
     }
 
+    /// Returns the host-driven engines in their firmware FIFO order.
+    pub(crate) fn fifo_engine_list(&self) -> FifoEngineList {
+        // INVARIANT: The list starts empty and appends at most one ID per supported input slot.
+        let mut fifo_engine_list = FifoEngineList {
+            gmc_ids: [0; MAX_FIFO_ENGINES],
+            count: 0,
+        };
+        for (&gmc_id, &flags) in self
+            .fifo_engine_gmc_ids
+            .iter()
+            .zip(&self.fifo_engine_flags)
+            .take(self.fifo_engine_count.0)
+        {
+            if flags & ENGINE_FLAGS_IS_HOST_DRIVEN != 0 {
+                // PANIC: At most one slot is filled per input, and the input has at most
+                // MAX_FIFO_ENGINES entries, so the next retained ID always fits.
+                fifo_engine_list.gmc_ids[fifo_engine_list.count] = gmc_id;
+                fifo_engine_list.count += 1;
+            }
+        }
+        fifo_engine_list
+    }
+
     /// Returns the BAR1 page directory entry base address.
     pub(crate) fn bar1_pde_base(&self) -> u64 {
         self.bar1_pde_base
-- 
2.53.0


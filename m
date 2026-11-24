Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795528924;
	b=GNhddrhcsGuygaJ+DPDC56OkwF/GgVuwAGKccS1gKTok4i34IgLyHmDNT735+/nFBqxD
	 TLMKDbxDk5Bw2MkKQ3aOIuaTLNmHqtlx+YxNKCA1l9SEwZD2V6UGz8A2a1WPr5LAvW/7C
	 SVIvTha7etL4EKXdjHWWsOdm7CxeeY6vHUUSpEeA59A2GMdcj/i30EfmYz9MeTaIcxV7x
	 A7p9B4jd4QidWlJoyANHuV+ng/ofOdo98nU5/Y+AOvbWOXERJijNaMn75RZVCGGroiZzj
	 VNgkYK2+SM+/hXTZkRyGHnzmgN3xHU4y4lSS3vhLa9XvU/4+ibttUWbGJph5zUkZTTA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795528924;
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
	bh=ED3s6DD0XLV7fWeaOpQMeJoN8CUUIOrSZU9Q5nF1yO0=;
	b=deUWr+Sx93eNK++5OaAtkQqvqn/iabyiw+SyUuMJQ4jtaH556xkF5DBfoJwXJjqoCpyj
	 bjMSyc8aH7jAnIh4egPs4gqS5+usCmoDyy3yAF9zmDNrR2m2MNNr9Ms7kz2/0B+MUtGY/
	 dfmA2aLF8CjlhONTQRauSQ2oSBxRi5Ms+ao1wsmlUw1cWzAE5eKfxNViCqINuLNnzWDqO
	 nirGRqXSp/e+rxrSH4PbqLt5WN1lSfom0um23HWoJtiZ7apzHWdBHNsiOQWJVkSHJNjw2
	 jn67vg4qD5eshaEwlx7IwumR37parE4nu6lGrpRYAfEWBM5IMqWugPsal/HfEJuDYbA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=VjY2V8Ri;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.42
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011042.outbound.protection.outlook.com [52.101.57.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF553606A335;
	Tue, 24 Nov 2026 14:02:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF553606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=VjY2V8Ri
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QJ+qATFOUooLnxLA1e7ew6a+2WwaMBp0pXzNEe+0MXotDGZwaLVVz5/j0yr3dG1SBB1U588EuyMO6o24XxmCWkTWUQv0IpU7hFDLyyP07/Vbzyaw2DnSiI55S7E1DBS5zeY9i0VOaLJ8ZxeXAOYl1j5FMStv/W2H/IVJ4IhyLwM15SUOmKjM2gvODl4V/0g1c4kZQxO1WlxqthNu/e5tTVpXbtMpGjV6yp0j7qbUyrn6MLIFQHrI/e3iosFxTiqo/6Wx5ARWVCDIEwJ6YQTzZeGKB/Z+3Fa9mmXWawj3JrjYW6QSQB971C15g17G1+eEC3Zg85WL+eUmHRd5QDPJiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ED3s6DD0XLV7fWeaOpQMeJoN8CUUIOrSZU9Q5nF1yO0=;
 b=ctiq50WzWNWPDuTo4loyAtA7q2P+jOB2A93kwlNC79Y5fojKeB1cCcZeXW+PwFGmodIlQsMSergD5/IGsmWMppwQo9qixrFtqA0sTwFtEWwd9DGaEmP1FMVW1lrJixSHBcATnZeYEk96h2mEJ+I2jejMGoWoncw2uDL/x89ztH4S0DS/e5IdPxO9nDmN7lv3j3uu38VZbHAkfeeEsqepAbS736M2vVmeiVkkjcEkoXsZGqxQTohNIOwVeTyjy9fp+ry1o7TqVLInk21hs6omw5BDWe6Dit+SBNTXTxIdx6rKgNOVGup0eyCM49QrJKoHp+hOqJFieiZT0FyzUIXEOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ED3s6DD0XLV7fWeaOpQMeJoN8CUUIOrSZU9Q5nF1yO0=;
 b=VjY2V8Ri0VdypJLrnIJATL5YIosJ517JLk4bLD1CHhx99JDrLeI/+q/Ylsy8udvagx7oOsZOPMyE53Ohp1ITDlas9fzvZOTeLWl8QljlrMfAky1XJhhZfZvZ2jhNGaxQG/+6C8wSBGhoCcVJoeE+qmxM0omaQYawCHmB7mGuVtieNenCLzcbtMp/uWEcenOivxHJ84UzZ7/fqT7AhHffFbRa/GHtW9zozloVrmT9fH2MgFUfmwSYuqgJBiFts2tgd1jijjUZtCetwDj8Tk3L52UkuxZDmkIYwL0NIzS8p90Qj/Tku6GklW4wkFiHcwnEjz0q/gGUoZl38bh1sW7y4A==
Received: from CH2PR04CA0021.namprd04.prod.outlook.com (2603:10b6:610:52::31)
 by DM6PR12MB4235.namprd12.prod.outlook.com (2603:10b6:5:220::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Tue, 24 Nov
 2026 14:01:56 +0000
Received: from CH2PEPF000166BE.namprd04.prod.outlook.com
 (2603:10b6:610:52:cafe::2e) by CH2PR04CA0021.outlook.office365.com
 (2603:10b6:610:52::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.6 via Frontend Transport; Tue, 24
 Nov 2026 14:01:56 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF000166BE.mail.protection.outlook.com (10.167.252.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Tue, 24 Nov 2026 14:01:56 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 24 Nov
 2026 06:01:29 -0800
Received: from kalok-SPC741D16QM3.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 06:01:16 -0800
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
Subject: [PATCH v5 06/35] gpu: nova-core: gsp: decode the FIFO engine table
Date: Tue, 24 Nov 2026 19:29:02 +0530
Message-ID: <20261124135937.18583-7-alkumar@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF000166BE:EE_|DM6PR12MB4235:EE_
X-MS-Office365-Filtering-Correlation-Id: 376c7601-f454-47b4-87b4-08df4a338002
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|1800799024|82310400026|376014|7416014|261028144727099003|261102123227099003|261021123027099003|261021121427099003|261021135927099003|261026140227099003|261022105027099003|11063799006|56012099006|10067099003|22082099003|261009223027099003|18002099003|6133799003|261022075727099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	vC7RC8NXOrizNlq+HsjSFuvNP9b46e/cM2eVlZcLHhhzwyH99k3yp0qKKiQQ3/AJijMa4zrTfXrnfbLGyPkMga30CzwVU0pIGjZX5y9eb9h68vStHLdSC+A8BqllC7gwXtj3Eajo0oM5AHIAgMjTp9qhWeDQHHOp3wzKHfehLJL8mI3IOCUsCqqnyyr8EXq+JvGA0+bg3xJ8WVjTaBhs7TQWm+G3/shFnY5GwfqGp0rYFIgRRMZ7UzyghJif9G/eV3vX7g4T0Bre5qiOcbbRss7OYBA5qjuXfxxHH8Cqudjaik6q3loDwJ1qHNAlp6l+kL5EfcgIKBkFi0PspSfmikI35M65LMm99kObhiYyEk15RbPCSezHumep4K0iK2QUgpCDt6WgZ2LQ+Jsi9+gSBrK+EjsD30axD6T9cosolvjNPgcwEVd6RTLFjPSP2dVTELz9y+xY+DUlRdjKy9qun5G/9eBWDglZ3B0UQuT08KAao9pIEUBvWSZHYD1YIBWJn1H9ugktIwwSIY66JCHAPqA5Vc5y1Sfd1eXByMtX1kAeO01ubkg4nNvemtmARogoLv3aJOiXOjMtz+QlJvMOikaQtEzMjwKj8F8YhkwuOcQOjZwllGlF1Jr4ARuX+9omdbToySZRPaJ0vqhkftGcOglSsZuj4SLA8pIYWqAJOe+8HVMgu5cGuhv4KYpnS6ZvSbe0HmK77nO47ct+AVG2QQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(1800799024)(82310400026)(376014)(7416014)(261028144727099003)(261102123227099003)(261021123027099003)(261021121427099003)(261021135927099003)(261026140227099003)(261022105027099003)(11063799006)(56012099006)(10067099003)(22082099003)(261009223027099003)(18002099003)(6133799003)(261022075727099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	1U+G/o2Lv4qXid/Asz+EgQWJvGu4CS3bZmMrTC5QRtEDoGYSk7NtSjxoE8Cgc/MNq9aF7ljv9MRLDURj/gUb547DteTqyj3QOLinTBpcNO8rq8JRJh1fY8ZGd3v6hSp+aSD9qvI39ODbChsBzKZqtSzZyIXcmeHh5VIwBvwzWTD0f5oZpBPQj47vl4qzYUJdf0gD1PurSyJja8eecw65Dl2Vr+vCMAcigIayY0Kqsds3eihFU9BRRdIUlncwPW55LTFI155OlgchyieGQWbXy1O+nJxcy4/tgFQhgV4vPrV1uAABO7Hhru4mT4ulLxhGdwMv5Z1UTjjtSpFyulEvX6/tu5ES51xCaDhTu45F82dwQgXldD3Sz3JDZaHTRnzZ4GLLDytHGq6mF8PGYOJYdVVXWmQwZzxUI3NWztqAP8i1rTJjivWWDpeMq9OnbsEy
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 14:01:56.0236
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 376c7601-f454-47b4-87b4-08df4a338002
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF000166BE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4235

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
index 27bd67fbe93e..4f813a780d1b 100644
--- a/drivers/gpu/nova-core/gsp/commands/gmc.rs
+++ b/drivers/gpu/nova-core/gsp/commands/gmc.rs
@@ -144,7 +144,8 @@ impl MessageFromGsp for GspStaticInfo {
     /// # Errors
     ///
     /// - `EINVAL` if the payload is not a whole number of NVKV words, if the stream is malformed
-    ///   or omits a required key, or if GSP-RM reported no framebuffer region.
+    ///   or omits a required key, if GSP-RM reported no framebuffer region, or if the FIFO engine
+    ///   count or indexed entries exceed the supported table capacity.
     /// - `ENOMEM` if the words or the decoded regions cannot be allocated.
     fn read(payload: &mut SBufferIter<core::array::IntoIter<&[u8], 2>>) -> Result<Self> {
         let bytes = payload.flush_into_kvec(GFP_KERNEL)?;
@@ -183,6 +184,7 @@ fn read(payload: &mut SBufferIter<core::array::IntoIter<&[u8], 2>>) -> Result<Se
             bar1_pde_base: reply.bar1_pde_base(),
             usable_fb_regions,
             total_fb_end: reply.total_fb_end().ok_or(EINVAL)?,
+            fifo_engine_list: reply.fifo_engine_list(),
         })
     }
 }
diff --git a/drivers/gpu/nova-core/gsp/fw/commands.rs b/drivers/gpu/nova-core/gsp/fw/commands.rs
index 1b2cd342c404..af3948ed79f5 100644
--- a/drivers/gpu/nova-core/gsp/fw/commands.rs
+++ b/drivers/gpu/nova-core/gsp/fw/commands.rs
@@ -22,8 +22,10 @@
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
@@ -316,6 +318,52 @@ pub(crate) fn new(ctx: &GspBootContext<'_, '_>) -> Result<Self> {
 
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
@@ -326,6 +374,9 @@ pub(crate) struct GspInitResponseSchema => GspInitResponse {
         fb_regions: Accumulated<FbRegionSchema>,
         bar1_pde_base: Required<Key<u64, 0x1020>>,
         vmmu_segment_size: Key<u64, 0x1050>,
+        fifo_engine_count: Key<FifoEngineCount, 0x0500>,
+        fifo_engine_gmc_ids: Indexed<u32, MAX_FIFO_ENGINES, 0x0501>,
+        fifo_engine_flags: Indexed<u32, MAX_FIFO_ENGINES, 0x0502>,
     }
 }
 
@@ -337,6 +388,9 @@ pub(crate) struct GspInitResponse {
     fb_regions: KVVec<FbRegion>,
     bar1_pde_base: u64,
     vmmu_segment_size: u64,
+    fifo_engine_count: FifoEngineCount,
+    fifo_engine_gmc_ids: [u32; MAX_FIFO_ENGINES],
+    fifo_engine_flags: [u32; MAX_FIFO_ENGINES],
 }
 
 impl GspInitResponse {
@@ -390,6 +444,29 @@ pub(crate) fn total_fb_end(&self) -> Option<u64> {
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


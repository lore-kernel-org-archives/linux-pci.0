Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.3
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793944102;
	b=tmpS9aM3ulg4pEesYrhQny50viikpb7F6TiblCMMN0KrDIhKDobM/J0ZGABjipNHR8Z5
	 gRIYXlBonBABiXl924rrz/TL3fhTYTa14XTJ2e1hvaxik0W4hlnKrwe/VTEMeJePBHXBv
	 d/Dn+yzSAA1L9sKM4MYdpXzp73mSxo83zmKb3nBdLr8osFtvM1vFXmmkgj7+oxV8JZtae
	 urefne3G3dVu0sqk3bcmv6QOCnzbtuzfBp7mmXHc2l8AazJNCaUfd9+iJlPoG0KAjMp6Y
	 IEr0c2nCAbwLN8ngFZ+Umbhx436yjdA5SEvhWZCB6JeDoXatzcblixx4IRVdIjHMfdA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793944102;
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
	bh=H3bs97v7GCiWmsV7fZ5KxLhtX0hx/kh0DcaEBTm7pys=;
	b=RHjSik+tLWwDOfmL3G8FLFDrOpS4h0Ugx0ksf2/c27aOBsfx+8/ju1h8QWs1gIrZzH4t
	 u4dWaDxOywpYmgBFymewNCqs+FKeo86GS1NmI6NJsJiJVZ1FjAVrBGEPIqqoq3zjIPddI
	 TGSLeRDqIxq5Hga74wAD0xo83iVmEUqtp10Wkj4kERZ9WWIo5zVscsu4KgtI4MpYuO6kC
	 kv2cFqMl9tOIEz6z2QkEkpD7LqlmRC09J+T/3R7UjcUMeTbZ82iYqhxB33sonl6QJlSYs
	 LWu2o1ZGSwKP9L2AqCsGlflKCZQ5hB+C0+avzi4GphG3G2Wpf0xc2c0snZQEMoW0CsQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=PXrEhDe7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.3
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011003.outbound.protection.outlook.com [40.93.194.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132D1606EEB1;
	Fri,  6 Nov 2026 05:48:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 132D1606EEB1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=PXrEhDe7
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L0XzF6Z5A7ky3L22JB46mNbp9iACZPcP6Voz+OKh0VR/ngk4B7noklfFANjPsja9EoAMYU/9sO3+sge20II5Iyw2hknxZZ7Z1HEx/Cmfi+4HqAqk2xB4iyFNe/9bsIQ/4BK1Hanfv5Tei30ZL3qTKs5j93sGsfL+Ce7uE4DFaV7nPmRc2b6lJGjkoQIeeEtl+ckRB/v2s6I/fg/CgM4cVdUNoA/bvhDoiSndO6NRetjeBZkIv6Tn/mJu9+0hsazG0SeIOl0BDpmUChmAPLqYPpvs78BAPLi92yyh7uFxpO+BqEwH4cBymGWundh4zsxiDZHQnZzlEv39+n03diy3VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H3bs97v7GCiWmsV7fZ5KxLhtX0hx/kh0DcaEBTm7pys=;
 b=EOSctXasUaScUZ6H3W+dipkty4NThanq6PoWzzZKutCV43TxFho3SkamUBLdGoB35TOldPdRz3PucNjypmbo/prbPUKiu+Gbx7wxizyrkFsgLuFpdxdrDbG1O61aAWts+BqoJCrnRqKJnjAuhBGskWUTGdvwSmVFF6Uv1kzaEvhzLjc/rc7KQhm8e9vZoLsO89E7oO2cpt670toV531NZu7RS/iS/g1Wwfb8jQ5hGQCcbtrP34nZettfF1LypjHOsqbd23PKdPc8LixaLhMUOwrcUjQocA8fWzEeY3URGAn/Ed86oX5mdlFDKiTWdF/S/kdPdUX2wymVA2EU8DsktA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H3bs97v7GCiWmsV7fZ5KxLhtX0hx/kh0DcaEBTm7pys=;
 b=PXrEhDe77eWVy05v6Ea8SZTnSzl+a/e61PODbolUaxvLO0g/NQDznsHSbGC2p9/yQWP9nIRS2nCZC3vhHQMo2mqz0Hhbn8C+KcJopH29LHXiPx4SbBjuhj9rd+Wd+vrLV0jm2JF/3AxOlkPGCAWrs1d9MQJ3KGRUULdNv+JqJtfK+10ILxPtOHty3WwsXSsusKDkOpas70OQvhCk3pCmnsHvjwc8sLyqovRH17wZLBCkVAyVFAcg2xgjxub1nn8BBmhTcInD5wxTQFZzHIYr6TN940PTtRT6RNLOGf6jsdlAGWPP77GfKUNq2e12xck/F8riVuXIP/aMjUylGmAhyg==
Received: from SJ0PR05CA0197.namprd05.prod.outlook.com (2603:10b6:a03:330::22)
 by BL1PR12MB5897.namprd12.prod.outlook.com (2603:10b6:208:395::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 05:48:12 +0000
Received: from PH7PEPF0000000A.namprd04.prod.outlook.com
 (2603:10b6:a03:330:cafe::71) by SJ0PR05CA0197.outlook.office365.com
 (2603:10b6:a03:330::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4 via Frontend Transport; Fri, 6
 Nov 2026 05:48:11 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 PH7PEPF0000000A.mail.protection.outlook.com (10.167.243.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 05:48:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 5 Nov
 2026 21:47:55 -0800
Received: from kalok-SPC741D16QM3.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 21:47:42 -0800
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
Subject: [PATCH v4 32/32] gpu: nova-core: vgpu: introduce SR-IOV PF APIs
Date: Fri, 6 Nov 2026 11:10:05 +0530
Message-ID: <132a3ca37584de0473193e8186c61e46ff8042d3.1793906667.git.alkumar@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: PH7PEPF0000000A:EE_|BL1PR12MB5897:EE_
X-MS-Office365-Filtering-Correlation-Id: 5557df02-9517-4892-2926-08df3bc98b23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|23010399003|7416014|376014|1800799024|22082099003|18002099003|3023799007|10067099003|56012099006|261021121427099003|11063799006|261102123227099003|261021123027099003|261028144727099003|261022113327099003|261022105027099003|261022075727099003|261009223027099003|261026121527099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	oiY9DI8GHD2/yc8PsnfNhh+NvVmL5gCWbwaPfoMrvIOtt9UhDmFP/8bJ41brfCDX10RklRuaNZGm0Eeqk80MuGihWkL4hxpLm7E9gF27X7UmOEv5XSXgqL7kGdsGiPEJ/DaFG3sOHEMrFN3fnVQrBMXmAO+IIucDKRJ9vAY2wV1BUWAEBeW92d3R1NW2kjpd/N7GOtTn5gyFmcf5AW1gWi20OHJtNoek43PQM7cTf48ZhiXEO9TUhlMWfOgA9XoSeAarNN+FwwDyx3cNKF1Mf7pQeC1xoMX3NVdxQnnm3NTJ/+hZV3pB7rVVlzhbwCQn73iL6X9Gg1cuYlSGMJgBerIxZSRd5FMkC+0AahxPzEQih8ZymVgzH3Byn8jJV46pcZ6X90jNyFZfa1VGMhq0E+Ox3c1ByDol++ZGLuqpkG7nPtyzoEXbtYISca3lNB7npziLE9jEAiv0Wkp1HSl8djk7bYGw3KU/stVzz/ttfzrHtD/Y/ORbWlZJwj0zDRx35zcZtjXaeR1QzZGt4BYooVRxHP7c7IaaPfz2+5FHUn+Cx1zNcJdD9qnt1JR2CE+i00pcs7DXKzPRIj+sdOBZNlBSlJgx9ZvIrXsd9u4K8+waOEvWs7cq/x9aDAWHz8Tn+5b6Rv6H0W86DVjj9Yst5zEiSfSzVvj6QFhLoLcMe0i7cvoQSEH5oY72ni24cfADCV+IQGYF5ba7yh+qOfF4qQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(23010399003)(7416014)(376014)(1800799024)(22082099003)(18002099003)(3023799007)(10067099003)(56012099006)(261021121427099003)(11063799006)(261102123227099003)(261021123027099003)(261028144727099003)(261022113327099003)(261022105027099003)(261022075727099003)(261009223027099003)(261026121527099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	oG3KrQUHidQCYo8NgZgPUix4MLN6L1wptlZ3u6oztcgcxSiRnjcJN1gJBWxGYKWFAE5Y+49uPD+Invh8F1TyaSlQsNSDqBaqL1O17Y8lcBazX8q262IPMh7PSAeUWn9IPHt9iy8XHGAfycMBiUrCLTKT5oVovPR1XC0BlrEL8cP0EQbj/2wzSFtn3WDYLScq1ZpUd4tKH33eaPJtmxujeJ78LxqWtM7mq4SAD3vpJMJirhfE1J1VI1jjI0eFkzIrGP79M8+9h58qYficTcpmpB4jcd1ecH26yJqovDYNJBr9se9kmJ0PQTB1VsjbWiPvJAywqrtnKZwriaNY1xZO7YbV3yp1Zn+I0HaZfp43QgzOAOwx2qQOlQ7TaL8NRD6EGEp5YjeUuW1eIErh6Jnkj7Bi5Z2cKYTHJKm1KjlsvCaaUZAo6z2hDJG8yN9FhfO+
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 05:48:11.8146
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5557df02-9517-4892-2926-08df3bc98b23
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	PH7PEPF0000000A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5897

From: Zhi Wang <zhiw@nvidia.com>

Provide PF operations for querying vGPU availability and creating,
closing and resetting VF instances.

Validate VF identifiers against the PF's VF count and route lifecycle
operations through the manager. Retain the GPU context needed to create
plugin RPC channels and return guest PCI properties after activation.

Signed-off-by: Zhi Wang <zhiw@nvidia.com>
Signed-off-by: Alok Kumar <alkumar@nvidia.com>
---
 drivers/gpu/nova-core/gpu.rs              |  24 +++-
 drivers/gpu/nova-core/nova_core.rs        |   6 +
 drivers/gpu/nova-core/vgpu.rs             |   2 +
 drivers/gpu/nova-core/vgpu/commands.rs    |  10 +-
 drivers/gpu/nova-core/vgpu/fw/commands.rs |   1 +
 drivers/gpu/nova-core/vgpu/instance.rs    |  93 +++++++++++--
 drivers/gpu/nova-core/vgpu/vgpu_api.rs    | 158 ++++++++++++++++++++++
 7 files changed, 280 insertions(+), 14 deletions(-)
 create mode 100644 drivers/gpu/nova-core/vgpu/vgpu_api.rs

diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index 02145f16a2dd..c097c83c5c47 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -1,6 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 
-use core::ops::Range;
+use core::{
+    num::NonZero,
+    ops::Range, //
+};
 
 use kernel::{
     device,
@@ -472,6 +475,25 @@ fn drop(self: Pin<&mut Self>) {
 }
 
 impl<'gpu> Gpu<'gpu> {
+    pub(crate) fn cmdq(&self) -> &Cmdq<'gpu> {
+        &self.gsp_resources.gsp.cmdq
+    }
+
+    pub(crate) fn vgpu_manager(&self) -> Option<&VgpuManager<'gpu>> {
+        self.vgpu.as_ref().map(|vgpu| vgpu.as_ref().get_ref())
+    }
+
+    pub(crate) fn vgpu_total_vfs(&self) -> Option<NonZero<u16>> {
+        match self.gsp_resources.vgpu_state {
+            VgpuState::Disabled => None,
+            VgpuState::Enabled { total_vfs } => Some(total_vfs),
+        }
+    }
+
+    pub(crate) fn bar0(&self) -> Bar0<'gpu> {
+        self.gsp_resources.bar
+    }
+
     pub(crate) fn new<'a>(
         pdev: &'gpu pci::Device<device::Core<'a>>,
         bar: Bar0<'gpu>,
diff --git a/drivers/gpu/nova-core/nova_core.rs b/drivers/gpu/nova-core/nova_core.rs
index a8f6dc22057b..f7753d63c432 100644
--- a/drivers/gpu/nova-core/nova_core.rs
+++ b/drivers/gpu/nova-core/nova_core.rs
@@ -30,6 +30,12 @@
 mod vbios;
 mod vgpu;
 
+#[cfg(CONFIG_PCI_IOV)]
+pub use vgpu::vgpu_api::{
+    NovaCoreVfApi,
+    VgpuTypeInfo, //
+};
+
 pub(crate) const MODULE_NAME: &core::ffi::CStr = <LocalModule as kernel::ModuleMetadata>::NAME;
 
 // TODO: Move this into per-module data once that exists.
diff --git a/drivers/gpu/nova-core/vgpu.rs b/drivers/gpu/nova-core/vgpu.rs
index 2dbf95222d4d..47a27236a086 100644
--- a/drivers/gpu/nova-core/vgpu.rs
+++ b/drivers/gpu/nova-core/vgpu.rs
@@ -42,6 +42,8 @@
 mod instance;
 mod log;
 mod scrubber;
+#[cfg_attr(not(CONFIG_PCI_IOV), expect(dead_code, unreachable_pub))]
+pub(crate) mod vgpu_api;
 mod vram;
 
 /// vGPU state detected during GPU construction.
diff --git a/drivers/gpu/nova-core/vgpu/commands.rs b/drivers/gpu/nova-core/vgpu/commands.rs
index bb446d742e19..3ac03eac77e5 100644
--- a/drivers/gpu/nova-core/vgpu/commands.rs
+++ b/drivers/gpu/nova-core/vgpu/commands.rs
@@ -78,7 +78,6 @@ fn check_status(dev: &device::Device<device::Bound>, command_id: u32, status: u3
 }
 
 /// Query the vGPU type assigned to a VF by its DBDF.
-#[expect(dead_code)]
 pub(super) fn query_assigned_vf_type(
     dev: &device::Device<device::Bound>,
     cmdq: &Cmdq<'_>,
@@ -95,7 +94,6 @@ pub(super) fn query_assigned_vf_type(
 }
 
 /// Query and decode the firmware properties of one vGPU type.
-#[expect(dead_code)]
 pub(super) fn query_vgpu_properties(
     dev: &device::Device<device::Bound>,
     cmdq: &Cmdq<'_>,
@@ -207,6 +205,14 @@ pub(super) fn set_plugin_bme(
     rpc.rpc_call_nvkv(dev, RpcMessage::UpdateBmeState, &bme)
 }
 
+/// Reset an active GSP plugin.
+pub(super) fn reset_plugin(
+    dev: &device::Device<device::Bound>,
+    rpc: &mut PluginRpc<'_, '_>,
+) -> Result {
+    rpc.rpc_call(dev, RpcMessage::Reset, &[])
+}
+
 /// Whether a failed allocation may still have transferred CHID ownership to firmware.
 pub(super) enum CeUtilsAllocError {
     /// A matching firmware response explicitly rejected the allocation.
diff --git a/drivers/gpu/nova-core/vgpu/fw/commands.rs b/drivers/gpu/nova-core/vgpu/fw/commands.rs
index b040c8c36572..670ff2b02e7e 100644
--- a/drivers/gpu/nova-core/vgpu/fw/commands.rs
+++ b/drivers/gpu/nova-core/vgpu/fw/commands.rs
@@ -36,6 +36,7 @@
 pub(crate) enum RpcMessage {
     VersionNegotiation = bindings::MESSAGE_NV_VGPU_CPU_RPC_MSG_VERSION_NEGOTIATION,
     SetupConfigParamsAndInit = bindings::MESSAGE_NV_VGPU_CPU_RPC_MSG_SETUP_CONFIG_PARAMS_AND_INIT,
+    Reset = bindings::MESSAGE_NV_VGPU_CPU_RPC_MSG_RESET,
     UpdateBmeState = bindings::MESSAGE_NV_VGPU_CPU_RPC_MSG_UPDATE_BME_STATE,
 }
 
diff --git a/drivers/gpu/nova-core/vgpu/instance.rs b/drivers/gpu/nova-core/vgpu/instance.rs
index 82a568ee3779..c887ccd7db7e 100644
--- a/drivers/gpu/nova-core/vgpu/instance.rs
+++ b/drivers/gpu/nova-core/vgpu/instance.rs
@@ -39,13 +39,16 @@
     commands::{
         free_ceutils,
         negotiate_plugin_version,
+        query_vgpu_properties,
+        reset_plugin,
         send_bootload,
         send_cleanup,
         send_plugin_config,
         send_shutdown,
         set_plugin_bme,
         CeUtilsAllocError,
-        Dbdf, //
+        Dbdf,
+        VgpuProperties, //
     },
     fw::commands::{
         encode_plugin_config_params,
@@ -124,7 +127,6 @@ fn wait_plugin_ready(
 
 impl Gfid {
     /// Validates an external GFID for a device supporting `total_vfs` VFs.
-    #[expect(dead_code)]
     pub(super) fn new(gfid: u32, total_vfs: NonZero<u16>) -> Result<Self> {
         let gfid = u16::try_from(gfid).map_err(|_| EINVAL)?;
         let gfid = NonZero::new(gfid).ok_or(EINVAL)?;
@@ -142,17 +144,30 @@ pub(super) const fn get(self) -> u16 {
 }
 
 /// Resource requirements and device identity for one vGPU type.
-#[expect(dead_code)]
 pub(super) struct VgpuType {
-    vgpu_type_id: u32,
-    bar1_length: u64,
+    pub(super) vgpu_type_id: u32,
+    pub(super) bar1_length: u64,
     max_instance: u32,
-    pci_dev_id: u32,
-    pci_subsys_id: u32,
-    fb_length: u64,
+    pub(super) pci_dev_id: u32,
+    pub(super) pci_subsys_id: u32,
+    pub(super) fb_length: u64,
     gsp_heap_size: u64,
 }
 
+impl VgpuType {
+    fn from_properties(properties: &VgpuProperties) -> Self {
+        Self {
+            vgpu_type_id: properties.type_id,
+            bar1_length: properties.bar1_length,
+            max_instance: properties.max_instance,
+            pci_dev_id: properties.dev_id,
+            pci_subsys_id: properties.subsystem_id,
+            fb_length: properties.fb_length,
+            gsp_heap_size: properties.gsp_heap_size,
+        }
+    }
+}
+
 /// A vGPU instance and the resources reserved for it.
 struct VgpuInstance<'gpu> {
     gfid: Gfid,
@@ -166,6 +181,7 @@ struct VgpuInstance<'gpu> {
     vram_slot: VgpuVramSlot,
     chids: ChannelIdReservation<'gpu>,
     ceutils: Option<CeUtils>,
+    active: bool,
     needs_teardown: bool,
     /// An uncertain or failed operation retains resources until device removal.
     failure: Option<Error>,
@@ -222,6 +238,7 @@ fn activate(&mut self, vgpu: &VgpuManager<'gpu>) -> Result {
                 error,
             ),
         }
+        self.active = true;
         Ok(())
     }
 
@@ -323,6 +340,7 @@ fn shutdown(&mut self, dev: &device::Device<device::Bound>, cmdq: &Cmdq<'_>) ->
             send_shutdown(dev, cmdq, self.gfid)?;
             dev_dbg!(dev, "shutdown: gfid={} stopped\n", self.gfid.get());
         }
+        self.active = false;
         Ok(())
     }
 }
@@ -335,7 +353,6 @@ pub(super) struct InstanceInfo {
     vm_pid: u32,
 }
 
-#[expect(dead_code)]
 impl InstanceInfo {
     pub(super) const fn new(gfid: Gfid, dbdf: Dbdf, vgpu_type: VgpuType, vm_pid: u32) -> Self {
         Self {
@@ -381,7 +398,6 @@ pub(super) struct VgpuInstances<'gpu> {
     vram_slots: Option<VgpuVramSlotAllocator>,
 }
 
-#[expect(dead_code)]
 impl<'gpu> VgpuInstances<'gpu> {
     pub(super) const fn new() -> Self {
         Self {
@@ -480,6 +496,7 @@ fn allocate_instance<'a>(
             vram_slot,
             chids,
             ceutils: None,
+            active: false,
             needs_teardown: false,
             failure: None,
         };
@@ -538,7 +555,6 @@ struct PendingInstance<'a, 'gpu> {
     committed: bool,
 }
 
-#[expect(dead_code)]
 impl PendingInstance<'_, '_> {
     fn activate(mut self) -> Result {
         let instance = self
@@ -569,3 +585,58 @@ fn drop(&mut self) {
         }
     }
 }
+
+/// Query and decode one vGPU type using the typed NVKV schema.
+pub(super) fn query_vgpu_type(
+    dev: &device::Device<device::Bound>,
+    cmdq: &Cmdq<'_>,
+    type_id: u32,
+) -> Result<VgpuType> {
+    let properties = query_vgpu_properties(dev, cmdq, type_id)?;
+    Ok(VgpuType::from_properties(&properties))
+}
+
+impl<'gpu> VgpuManager<'gpu> {
+    /// Allocate, register, and activate a vGPU instance.
+    ///
+    /// Keep the registry locked through creation or rollback so duplicate checks and
+    /// type limits remain stable. MM and BAR-user locks are acquired only within
+    /// individual memory operations, in that order.
+    pub(super) fn create_instance(&self, bar: Bar0<'gpu>, info: InstanceInfo) -> Result {
+        let mut instances = self.instances.lock();
+        instances.allocate_instance(self, bar, info)?.activate()?;
+        Ok(())
+    }
+
+    pub(super) fn close_instance(&self, gfid: Gfid) -> Result {
+        self.instances.lock().destroy_instance(self, gfid)
+    }
+
+    pub(super) fn reset_instance(&self, gfid: Gfid) -> Result {
+        let mut instances = self.instances.lock();
+        let instance = instances
+            .instances
+            .iter_mut()
+            .find(|instance| instance.gfid == gfid)
+            .ok_or(ENOENT)?;
+        if instance.failure.is_some() || !instance.active {
+            return Err(EBUSY);
+        }
+
+        let result = (|| {
+            reset_plugin(self.dev, &mut instance.plugin_rpc)?;
+            instance.ceutils.as_ref().ok_or(EINVAL)?.scrub_guest_fb(
+                self.dev,
+                self.cmdq,
+                self.bar_user,
+                self.mm,
+                &instance.vram_slot.fbmem,
+            )
+        })();
+        if let Err(error) = result {
+            instance.failure = Some(error);
+            instance.active = false;
+        }
+        result
+    }
+}
diff --git a/drivers/gpu/nova-core/vgpu/vgpu_api.rs b/drivers/gpu/nova-core/vgpu/vgpu_api.rs
new file mode 100644
index 000000000000..f9f3e527bdc0
--- /dev/null
+++ b/drivers/gpu/nova-core/vgpu/vgpu_api.rs
@@ -0,0 +1,158 @@
+// SPDX-License-Identifier: GPL-2.0
+// SPDX-FileCopyrightText: Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+
+//! PF-owned lifecycle operations for Nova VF drivers.
+
+use core::num::NonZero;
+
+use kernel::{
+    device,
+    pci,
+    prelude::*, //
+};
+
+use crate::{
+    driver::Bar0,
+    gpu::Gpu,
+    gsp::cmdq::Cmdq,
+    vgpu::instance::{
+        query_vgpu_type,
+        Gfid,
+        InstanceInfo,
+        VgpuType, //
+    },
+};
+
+use super::{
+    commands::{
+        query_assigned_vf_type,
+        Dbdf, //
+    },
+    VgpuManager, //
+};
+
+/// Guest PCI properties of an activated vGPU instance.
+pub struct VgpuTypeInfo {
+    /// PCI device ID to present to the guest.
+    pub pci_dev_id: u32,
+    /// PCI subsystem ID to present to the guest.
+    pub pci_subsys_id: u32,
+    /// BAR1 aperture size in MiB.
+    pub bar1_length: u64,
+}
+
+impl VgpuTypeInfo {
+    fn from_vgpu_type(vgpu_type: &VgpuType) -> Self {
+        Self {
+            pci_dev_id: vgpu_type.pci_dev_id,
+            pci_subsys_id: vgpu_type.pci_subsys_id,
+            bar1_length: vgpu_type.bar1_length,
+        }
+    }
+}
+
+/// PF-owned operations available while a VF driver is bound.
+pub struct NovaCoreVfApi<'gpu> {
+    pdev: &'gpu pci::Device<device::Bound>,
+    cmdq: &'gpu Cmdq<'gpu>,
+    bar: Bar0<'gpu>,
+    vgpu: Option<&'gpu VgpuManager<'gpu>>,
+    total_vfs: Option<NonZero<u16>>,
+}
+
+impl<'gpu> NovaCoreVfApi<'gpu> {
+    #[expect(dead_code)]
+    pub(crate) fn new(gpu: &'gpu Gpu<'gpu>, pdev: &'gpu pci::Device<device::Bound>) -> Self {
+        Self {
+            pdev,
+            cmdq: gpu.cmdq(),
+            bar: gpu.bar0(),
+            vgpu: gpu.vgpu_manager(),
+            total_vfs: gpu.vgpu_total_vfs(),
+        }
+    }
+
+    /// Returns whether the PF booted with vGPU support enabled.
+    pub fn is_available(&self) -> bool {
+        self.vgpu.is_some()
+    }
+
+    fn gfid(&self, gfid: u32) -> Result<Gfid> {
+        let total_vfs = self.total_vfs.ok_or(ENODEV)?;
+        Gfid::new(gfid, total_vfs)
+    }
+}
+
+impl NovaCoreVfApi<'_> {
+    /// Creates and boots an instance for a one-based VF ID.
+    ///
+    /// `sbdf` encodes the VF address as `(segment << 16) | (bus << 8) | devfn`.
+    /// `vm_pid` identifies the VM process's thread group. This call may sleep.
+    pub fn open_instance(&self, gfid: u32, sbdf: u32, vm_pid: u32) -> Result<VgpuTypeInfo> {
+        let dev = self.pdev.as_ref();
+        let gfid = self.gfid(gfid)?;
+        let dbdf = Dbdf::from_raw(sbdf);
+
+        dev_dbg!(
+            dev,
+            "vgpu_open: gfid={} sbdf={:#x}\n",
+            gfid.get(),
+            dbdf.into_raw()
+        );
+
+        let bar = self.bar;
+        let cmdq = self.cmdq;
+        let vgpu = self.vgpu.ok_or(ENODEV)?;
+
+        let type_id = query_assigned_vf_type(dev, cmdq, dbdf)?;
+        dev_dbg!(
+            dev,
+            "vgpu_open: gfid={} assigned type_id={}\n",
+            gfid.get(),
+            type_id
+        );
+
+        let vgpu_type = query_vgpu_type(dev, cmdq, type_id)?;
+        dev_dbg!(
+            dev,
+            "vgpu_open: gfid={} vgpu_type={} fb_length={:#x}\n",
+            gfid.get(),
+            vgpu_type.vgpu_type_id,
+            vgpu_type.fb_length
+        );
+
+        let type_info = VgpuTypeInfo::from_vgpu_type(&vgpu_type);
+        vgpu.create_instance(bar, InstanceInfo::new(gfid, dbdf, vgpu_type, vm_pid))?;
+
+        Ok(type_info)
+    }
+
+    /// Tears down an instance, retaining resources if firmware cleanup fails.
+    ///
+    /// This call may sleep.
+    pub fn close_instance(&self, gfid: u32) -> Result {
+        let dev = self.pdev.as_ref();
+        let gfid = self.gfid(gfid)?;
+
+        dev_dbg!(dev, "vgpu_close: gfid={}\n", gfid.get());
+
+        let result = self.vgpu.ok_or(ENODEV)?.close_instance(gfid);
+        if let Err(error) = result {
+            dev_err!(dev, "vgpu_close: gfid={} failed: {:?}\n", gfid.get(), error);
+        }
+        result
+    }
+
+    /// Resets an instance and scrubs its guest VRAM. This call may sleep.
+    pub fn reset_instance(&self, gfid: u32) -> Result {
+        let dev = self.pdev.as_ref();
+        let gfid = self.gfid(gfid)?;
+
+        dev_dbg!(dev, "vgpu_reset: gfid={}\n", gfid.get());
+
+        self.vgpu.ok_or(ENODEV)?.reset_instance(gfid)?;
+
+        dev_dbg!(dev, "vgpu_reset: gfid={} done\n", gfid.get());
+        Ok(())
+    }
+}
-- 
2.53.0


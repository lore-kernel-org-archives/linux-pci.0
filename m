Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795529219;
	b=lbh2bxjJPNEsIr5GjCHAUn+ItufR7WQuWXwdkVHTqnz4dx8znEBagDTN2Vcx8j8ldgfm
	 QIqMol807MJwGKo8FVDIcYCNiDnwNlif5MyiXGFNkn+cc6NErLfSCfbGhjlI0H0CEVwOx
	 DZ6NOOl2L58zWaB5LejUeZ2fjMRDs3NPcEq1yiDLFuZw3lIeFL7RybRBEbsRowub7uBsN
	 dmXIiSCIOXF70jt3B2taJT2Zv+UpYjdPaYXzaOS/OI1GJmhxePoBl08sy/hUUZJ3550M9
	 +9AXqP7VLCV5CpMKeb3TlFwTxDuK4uTFPkemlVl1PPn/yKBR4uWV4ONaDwE5xi/m/mA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795529219;
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
	bh=WIhUYILwaMEfxgcv7IXXyXP1rTMNcfNLEhrbq6z5Tms=;
	b=HHv1AC/Q2TPCIP2ABe+4Xq8namkab3PCwoV1PFoLjDZyCa33KklsTuCq+seWfdfNCx/B
	 B3llAE1r8OyHEjebjkTaqWf5bUBLu1A/wbtuHcvKQGqD1roL6fZXycSyZay9BBE+GKxrX
	 b74xkHycUaSAisiL38ruzCr3f6ZJhH+joIUytv1KDKlkiigKhriyLYXK5coPw6hIeZbGU
	 C6m9lT2ooXUDZeuDL1IWEmaUrrUFaHFjz8Vx93tihvhIMeHS05Gy4Cl3b2gpKE4J7Ko7Z
	 Oh0qE1fTQtiNkKpyOC5RSZrCRU1MwJ8Vi4R8wawIXtY+ONOJWHQazUZ/0fsgWUjCXHg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Ug966nhe;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.48
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013048.outbound.protection.outlook.com [40.93.201.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12DB606B741;
	Tue, 24 Nov 2026 14:06:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E12DB606B741
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Ug966nhe
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GUMHxXqlz/2j5iao9KMtTcZmregGexabECHr3q/G9N9bMaZjz81rYJJHDmn1/EfERXre6hxETGfWXpWDEK3bW/z5zbytL50eebliMWsvjGkP/v9mezvWgG+01e4IzZkFARKxA77ekfHflvYCQtpVC+aZOc47J5g+9q5+tMjP3jHMBlEiGX8fV9TDnbtDkQDTXSdOoPlGyIXah93EBPnC6Jbsxnkm/sT6IR47SOL108625sYjIyNEDE3+JZgoGLc/gZ+FGyIxKgtoyE7N99l1amUx6a4t7Sa+2ExHMbcK5kmr91LjyWGdB9mhVKEe98dpyYh6gY0QtPRObYywdtxXgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WIhUYILwaMEfxgcv7IXXyXP1rTMNcfNLEhrbq6z5Tms=;
 b=IJAPxXghJdgffGPAjN2tG+04Nmb1ihL7SRqrhUwYakTuGCQAP2TPsgmLWycuAvZym9wJjaiLWhJVl4NRH/hmejxGapauPU1Z1xTaH9qtvC/fQ4wsSc4s8FM38UfA5O2A2sFVZGQz3qUp//rBI5SVi3dO+VVJTnU0V+MWU0Wy9Wqa7A+OWeuqDYJDj/ZExHRA9KAME8YKOF/MDoorzGQ2rJSOyqXmnY9weqbJG0C3Etsg6pf9/oZPbY+ImvLUF4NmqKxEIZn38nLUfhJYijvaNCM7WMyZ0LTaBlAkIHIHnq8rjLgsTSho2qSE8AqUjqXOAE763WVsHZBiAzWySR31Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WIhUYILwaMEfxgcv7IXXyXP1rTMNcfNLEhrbq6z5Tms=;
 b=Ug966nheYftDHs9DwmUtrJewWXvFw9QXh4ShLNFJz5CEqUBUdeN95e4JDcA5YNa99C0ps0lfwN8jRi2GBjeLMsH9gds41lD6Nbh/i3c3Suk8K3QSjB9ulKIxAaN0xMUtTd0WW22Ky9UTR9JvRVV7ntuZHmYSOgqZJnT063Y8bwKdZh8wUmvY8yc7PZxNEGa+WlyE9djG8XOcOLwxaf71QSjiDtFqBrXpAHIap5JEQlS5ThZhn4S62GkYnX53dv+9sq8Lx+ypZR2L249tBhC9jfL570xHLbAKjYCr2Ax24z6jzxbn79s9k0cjyNMCTw1D5KrGoUTD0buLL4ICh4mmsg==
Received: from PH8PR21CA0008.namprd21.prod.outlook.com (2603:10b6:510:2ce::29)
 by MN2PR12MB4207.namprd12.prod.outlook.com (2603:10b6:208:1d9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Tue, 24 Nov
 2026 14:06:52 +0000
Received: from CY6PEPF0000004B.namprd03.prod.outlook.com
 (2603:10b6:510:2ce:cafe::75) by PH8PR21CA0008.outlook.office365.com
 (2603:10b6:510:2ce::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.688.3 via Frontend Transport; Tue, 24
 Nov 2026 14:06:51 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY6PEPF0000004B.mail.protection.outlook.com (10.167.247.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Tue, 24 Nov 2026 14:06:51 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 24 Nov
 2026 06:06:28 -0800
Received: from kalok-SPC741D16QM3.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 06:06:15 -0800
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
Subject: [PATCH v5 29/35] gpu: nova-core: vgpu: negotiate the GSP plugin RPC version
Date: Tue, 24 Nov 2026 19:29:25 +0530
Message-ID: <20261124135937.18583-30-alkumar@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY6PEPF0000004B:EE_|MN2PR12MB4207:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dddd66c-9c78-4399-fdd6-08df4a34304e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|36860700016|82310400026|10067099003|261022075727099003|11063799006|261028144727099003|56012099006|261021121427099003|261102123227099003|261009223027099003|261021123027099003|261026140227099003|261022105027099003|261026121527099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	uM3M0y12Hn2Nz06USk+P8PEzTH6JXYXnOkqNFYgDuyhEVxOyjnrAphFYqTcLg7+Cm3IL1RILzC8/lnCC1bBwtKlAsZcqIe6JLQAVvbpk6Pm4mQt6c9PfMybS2XaxkPXCuKnpinx0dJuFoOiiOw8iwSDJ6XA5ZYk+G1Wi6BPo1W+RlmLI2OigUgYR0w95newFf5TV3+CvOCc4tTUKYUYhp5zPD3LfOMZiIyXru5Hy1Tpb7zC/n2R2JASyG8lslNaHuthyHz+Dif62iqe0CZ/f70X5pfadBq/NgfIfoppYauT7ybdD9KXXdS6xunRbGArojs8eZ1ckDdmFd/ff5ZeMy+H1hZ15zSutRMLoDcnR5Ot3Z50djN8u6nOx/mq/afcIWNL7CRsJuzgHcDob+VfX3OGsYo/Fo+c2xIqGIcdMUHLZQUNhNNTb11REh18TqbPrUQgrsdcvPE7GpTILT2ZAW2N5hK7afi8ts7V7rhpYvcNZTHOUpyx3W8sbGDowbM9cOWSXCrMlKT4pnEaINt3PC+1NnziFHLdmdiivv/sIqIBCpSGSPdOhUAFeqYuo3lv1X+9n+rJuDyHgM7dpnK0UrUgadSwndVC8ICCbZ7rWm0mqVBAqsCG8AjM1Ck1zv6aJw5g4UYIjm8WL1qxuZSrfj8EC1KWzBycIwoubXEElD3OAcOryUTFnBzshhh65/ZX2xEnOUQsXJg2qUTzvn+9y7g==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(36860700016)(82310400026)(10067099003)(261022075727099003)(11063799006)(261028144727099003)(56012099006)(261021121427099003)(261102123227099003)(261009223027099003)(261021123027099003)(261026140227099003)(261022105027099003)(261026121527099003)(18002099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	bXw45C54tts7zomjTN1NlG+LYRYO9ASSs4iH91dtpC7RIeE9YpVz5r6IvSk/7DiIIwmgDmWeymUpTxTsqO0ix1hE4P05R9fWGXUgSt+dxmv5h8tr7cC6wbmmNFZvsPdIg1D6bEIe3HiCSEnCic6Ve4s6WL2rITtWb+Ai94y78dHTB+resXkDNTnPVUDWgSgDZjRZp24rrA6Gcd5bQ6m3OJ6SuQsW0Q6sWauciuKGqXlh0T83G95m8wYHc7iSRh8blaIZwM39XJToMUsuw6qrbRxWDwfqgYJODZ9mO+QaPZtlEO0ifoz27oZ1eAQgtSPJteM36iSEcpQTf7ubbsDLnNNzjcYip70JK5HU/6zXLIHiS/+lhdZDL+00MsUVR9AV69ROg4kvOIaaD5Nk4GZ35ODgG08R3qW66nQ9Mm31kwnKA8sVtnYh2uA2iD7VgXPz
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 14:06:51.8504
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dddd66c-9c78-4399-fdd6-08df4a34304e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY6PEPF0000004B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4207

From: Zhi Wang <zhiw@nvidia.com>

The host must negotiate the RPC protocol with the booted GSP plugin
before sending instance configuration.

After observing the plugin's ready marker, initialize the shared RPC
buffers and submit the existing typed version-negotiation request
through the instance's PluginRpc channel.

Co-developed-by: Eliot Courtney <ecourtney@nvidia.com>
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
Signed-off-by: Alok Kumar <alkumar@nvidia.com>
---
 drivers/gpu/nova-core/vgpu/commands.rs       | 20 ++++++++++++++++----
 drivers/gpu/nova-core/vgpu/fw/commands.rs    |  1 -
 drivers/gpu/nova-core/vgpu/gsp_plugin_rpc.rs |  2 --
 drivers/gpu/nova-core/vgpu/instance.rs       |  3 +++
 4 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/nova-core/vgpu/commands.rs b/drivers/gpu/nova-core/vgpu/commands.rs
index d0fd7ab2593b..c1783ace8b3f 100644
--- a/drivers/gpu/nova-core/vgpu/commands.rs
+++ b/drivers/gpu/nova-core/vgpu/commands.rs
@@ -38,11 +38,15 @@
     },
     sbuffer::SBufferIter,
     vgpu::{
-        fw::commands::{
-            AssignedVfVgpuType,
-            VgpuProperties,
-            VgpuPropertiesSchema, //
+        fw::{
+            commands::{
+                AssignedVfVgpuType,
+                VgpuProperties,
+                VgpuPropertiesSchema, //
+            },
+            RpcMessage,
         },
+        gsp_plugin_rpc::PluginRpc,
         instance::Gfid,
         Dbdf,
     },
@@ -223,3 +227,11 @@ pub(super) fn send_cleanup(dev: &device::Device, cmdq: &Cmdq<'_>, gfid: Gfid) ->
     dev_dbg!(dev, "cleanup: gfid={} done\n", gfid.get());
     Ok(())
 }
+
+/// Negotiate the host protocol with a bootloaded GSP plugin.
+pub(super) fn negotiate_plugin_version(
+    dev: &device::Device,
+    rpc: &mut PluginRpc<'_, '_>,
+) -> Result {
+    rpc.rpc_call(dev, RpcMessage::VersionNegotiation, &[])
+}
diff --git a/drivers/gpu/nova-core/vgpu/fw/commands.rs b/drivers/gpu/nova-core/vgpu/fw/commands.rs
index a8f6f0316d25..168a2447b67c 100644
--- a/drivers/gpu/nova-core/vgpu/fw/commands.rs
+++ b/drivers/gpu/nova-core/vgpu/fw/commands.rs
@@ -31,7 +31,6 @@
 use super::bindings;
 
 /// Message types supported by the nova-core plugin RPC channel.
-#[expect(dead_code)]
 #[derive(Clone, Copy)]
 #[repr(u32)]
 pub(crate) enum RpcMessage {
diff --git a/drivers/gpu/nova-core/vgpu/gsp_plugin_rpc.rs b/drivers/gpu/nova-core/vgpu/gsp_plugin_rpc.rs
index d96f6072a941..c68681d8d08b 100644
--- a/drivers/gpu/nova-core/vgpu/gsp_plugin_rpc.rs
+++ b/drivers/gpu/nova-core/vgpu/gsp_plugin_rpc.rs
@@ -65,7 +65,6 @@ pub(super) fn comm(&self) -> &CommBufferRegion<'map, 'gpu> {
     }
 
     /// Initialize the control and response buffers for the first RPC.
-    #[expect(dead_code)]
     pub(super) fn init_rpc(&mut self) -> Result {
         self.comm.initialize()?;
         self.message_sequence = 0;
@@ -82,7 +81,6 @@ fn next_sequence(&self) -> u32 {
     }
 
     /// Write one RPC message, ring the VF doorbell, and wait for its response.
-    #[expect(dead_code)]
     pub(super) fn rpc_call(
         &mut self,
         dev: &device::Device,
diff --git a/drivers/gpu/nova-core/vgpu/instance.rs b/drivers/gpu/nova-core/vgpu/instance.rs
index 94735df79e1a..2c8542a45643 100644
--- a/drivers/gpu/nova-core/vgpu/instance.rs
+++ b/drivers/gpu/nova-core/vgpu/instance.rs
@@ -31,6 +31,7 @@
 
 use super::{
     commands::{
+        negotiate_plugin_version,
         send_bootload,
         send_cleanup,
         send_shutdown, //
@@ -161,6 +162,8 @@ impl<'gpu> VgpuInstance<'gpu> {
     fn activate(&mut self, vgpu: &VgpuManagerInner<'gpu>) -> Result {
         let dev = vgpu.dev;
         self.bootload(dev, vgpu.cmdq, &vgpu.fifo_engine_list)?;
+        self.plugin_rpc.init_rpc()?;
+        negotiate_plugin_version(dev, &mut self.plugin_rpc)?;
 
         Ok(())
     }
-- 
2.53.0


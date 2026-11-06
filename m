Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.62
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793944082;
	b=ej4mB5p2J5a997Td9KiqQOKY67p/1HXFG8GrWxOpgF+MIcR2/7Vv1qoPgzfG+cNGcmuN
	 js6CmprKXC61mcuPTFMUKwN2Rv9W7RcP3gpnGqns0BTyemR432EmwX984qhpIdjafez5r
	 n1J77EnsLOVZB+RDplc93L/YaSr8HIQSC0o5q5h26BdvtQteLYTDExln2C6oAlGY9++Xe
	 X6f8pCnAQHYxdCl0hVXYjVtIMqGRDpb6B8d4IW9Kl0FV79KyANZwKtiZa+MZIew4h0r45
	 H2laeXq2221IzqalwHs9RFIQQ84+AAP9/72iVJQkdVeTr097a2KuXZ8s4rzIUswpCTA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793944082;
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
	bh=FHoV0hzNr5ODmocCpC8Fyt8vmsPlM9I76HMhrsMBgjs=;
	b=cbqrVEs69DWf2uYO+i0rcoJZ6m1mI2qqX3+CTUDdxIuycgKa4/ik1DxC0AGVplUKi2Eg
	 PcYgAerAavHqAs+dbCjqBGB6pjxIJWkmSThMIuH+K6YopaewlbqVYQO/ivSBS0x3El34p
	 A9Lt623yBIiMpsnqTO5GgMItTzaIZtlVe1cmcQ08oR/PuWk1frH96b//haxAzZn7S/vpg
	 PWhQTCBTyVjYI6vnUN5+G2FVEnZJZfNltPomZuXh3StzAFZ9u8z7wVH5OfZkpI2S4e2ux
	 sDwyRhekZlQW+czPaIn5+9diO4Cp90TBi0Yz1anq0QhmwnQCwfx57exz4UtcLZUvdMw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="cXdG/Ad5";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.62
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010062.outbound.protection.outlook.com [52.101.61.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C479C606EE97;
	Fri,  6 Nov 2026 05:48:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C479C606EE97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=cXdG/Ad5
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DxgumLpbp9ZQ05Piy0s/c2n2nbj/+eTUlDkXMc4jBN9r50TikqMwjlVGZCIOti/zGKO2BsOKp9uFByk7lXEn+JCA/Q8xvnDE0ruhV6RQQALxfsKQLaWUMQF4PYAQSgMlgn5O2Jp/zf5A2Yq5g+g//STBhfW4VdFyWIZDrqfEC25+n+P9g5e8MsLNhivdPVxoWDrLK0vu3jIdFxlRDbHpY2HWnmoiBrIL33gBq6PA9ULkfbvqdOOjr1QwBXWjN9K9tnpZEXj/u7E9Oj/c+jMSQXzs56SBJfufTFTC1sR70S6DbrOutVHaCbhuJ6FmvUzkXgoXn5qPgON1t0gr/hwCOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FHoV0hzNr5ODmocCpC8Fyt8vmsPlM9I76HMhrsMBgjs=;
 b=KlM3qWKbbQZqrbg3theaynjWL42guPdCXohzbcxqbCzg2Y8Fk1h6ByqC7dR4PUAaM0+PpzDWyLZOE1yivKMhdqJequwL9r9AHcvNBE3lshkxy8lJxddLiqzo4QH1BQHu7hWwHKcvGRYty1iUNR/vqo7VXkXwooitRLVzF77Y6D4+lmmIV26IVi9QjPFL5SVR+wTRr1AbEv2RIDuV8uJyg4MbLnFoN2H7Y5sVwqwYD5iJfU7dkJz9i1vVkB16v41FrEUHKwgZx8G1TQseciZyddjrjUJ0izr7HWzBl31VqR8rWxfiG3+u/B+bgr69qVjNtg9PlbSISI6nlEOQO5EdOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FHoV0hzNr5ODmocCpC8Fyt8vmsPlM9I76HMhrsMBgjs=;
 b=cXdG/Ad5tnR1e9KbW9j59AHv1ztfQRC5312E4BRDUI0MgJqFE33j1N/WW2otXDU2ISLDZejYMi2fY0B3exDKbuRvMOUoTCW7sDIOKkomNSg+GZbAhU/tVgg0ko5aru+TWTlmKLC+NcByYC1/p1IIaLBiJYWH6Fk5iTslIlp3r5LkE+++fpRHP6MI8zOE/giPi9zBMQ3Pw31M1LfxYPhJgTrqBqoQaEcGPg5Zwv0sARIoeLMKJGnkrrwNGDnHUgldYMywnH/3hJ/UgyfIO+WoMyeFkJGDWwks2raXpsNxLI+HcLY/bw55+fMF+3lggXAZaSvMzjRIfMTgf6eSC1eFQw==
Received: from SJ0PR05CA0184.namprd05.prod.outlook.com (2603:10b6:a03:330::9)
 by BN7PPFEE0F400A9.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6e9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 05:47:19 +0000
Received: from PH7PEPF00000009.namprd04.prod.outlook.com
 (2603:10b6:a03:330:cafe::50) by SJ0PR05CA0184.outlook.office365.com
 (2603:10b6:a03:330::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4 via Frontend Transport; Fri, 6
 Nov 2026 05:47:18 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 PH7PEPF00000009.mail.protection.outlook.com (10.167.243.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 05:47:18 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 5 Nov
 2026 21:47:05 -0800
Received: from kalok-SPC741D16QM3.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 21:46:52 -0800
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
Subject: [PATCH v4 28/32] gpu: nova-core: vgpu: update the GSP plugin BME state
Date: Fri, 6 Nov 2026 11:10:01 +0530
Message-ID: <7b6393dd83cf43e81f3be6dffc9daab5e8f23b4e.1793906667.git.alkumar@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: PH7PEPF00000009:EE_|BN7PPFEE0F400A9:EE_
X-MS-Office365-Filtering-Correlation-Id: 58d4c26f-f96d-4452-d969-08df3bc96b5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|23010399003|1800799024|7416014|18002099003|22082099003|6133799003|3023799007|10067099003|11063799006|56012099006|261026121527099003|261009223027099003|261022075727099003|261102123227099003|261021121427099003;
X-Microsoft-Antispam-Message-Info:
	mupC0172U64fi+vNsUWQAvf9cIYfgG5yaHT8S+ShNpnnnTgBZBVxClaVchoTzWISJ0K6sB9YRfpnZSlpx4ATjU9gxccHCM64a9cniNAp3SM7+vXDTSEer4olM5L1HYVVv0CXFy4fjbX3n0XvlgQD2HVwJDfcwJoIG0kcmg/uRhgrG/WK93UazZ46tdoqW8lJnl42ZV8f9u19bzfHYFskJsAWPGUyW1IcEkfwt1f30N6VigJJa7MXMrvQ3qIlmXMrHLLayM2JlqkT9+75hE5P7b/xvk1N2lQACVI1ROZ1dYSkfOCJK3knQznlaOwwEB7M1TcPXTVrUNAs+V4x8a2CJ273bhMcK6lKPDm1J6qnm4zEYh4tYb7Jw5cu+j2J/IKO+yzNS9dANUUM4R/ed5/zuz2wQdoCASeFZLGCbg8xB1NJnB/uQ1GEluK8RufIvTBVIcRKy26hF/yMk36ioVtGEmvtxzBc5sbO4QX0oGmfI04UAQFwaeBadP/Y7DPt5Fz/q2/Bv4yM6NzpNRvWoOksy7JuY89A5/EhQ70G3YZz5Wp/KauMBls4r5p67Xj335r+QGgT6oqR3DhfjQIAOIOub6P2C8IlQAvCNtxveMq4Snou67lUavhh+xnxuZePwXJPgIGopVr2nJTVZdivta2GZf1HtZ5oiBG3UePxeEIq3074Kxz7qjWpDm52MtFXJpn0JhWeLcaQn2DeLM7sciNa9A==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(23010399003)(1800799024)(7416014)(18002099003)(22082099003)(6133799003)(3023799007)(10067099003)(11063799006)(56012099006)(261026121527099003)(261009223027099003)(261022075727099003)(261102123227099003)(261021121427099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	8UCyx1OBMACKaQlrEoVsrhLaBNOvYn+2y5bb9QjV7k0beh3ZMyIp9eM3vVMhZpiq3L8M9Cb4uexQu9BEEN2ToJv1gpV3v6PBs5yGsLpvFgkufNluQqgeBJYNt/ymfiMs0Umx9ugytYZGbvjmUs/Rl0k3UGrb3RA8x14bCIhFZj20WXrlkHY9+AAOoJzgudfEw+k7W0mbjOevW12URBeDGY3AB2fau6uBfyXEbctS2Bwn51QqLdKOxetb9J0orVDUXswmopDTIXpw8LUT6GgfVLaMNEwxgGThZGIKHgi97gyURh5+FjRtUW7G1wEOxZhG7i5bMYnpnq21dNqVn0H+t75vqlT0VJyLyM9mMrDNbXGuvaZHKM817G0L+LhNoNLQ8Mnui1wjuzoQGYkGkFnBLUClYKSsX5tTKTolhPrRr3BdqWgugEFRkRXcX0ii8um4
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 05:47:18.5115
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58d4c26f-f96d-4452-d969-08df3bc96b5d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	PH7PEPF00000009.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFEE0F400A9

From: Zhi Wang <zhiw@nvidia.com>

The vGPU manager reports the enabled bus-mastering state to the GSP plugin
after its initial configuration. The guest can then use the vGPU from now
on.

Add the BME state request and NVKV encoder, and send the enabled state
after configuration succeeds.

Co-developed-by: Eliot Courtney <ecourtney@nvidia.com>
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
Signed-off-by: Alok Kumar <alkumar@nvidia.com>
---
 drivers/gpu/nova-core/vgpu/commands.rs    | 11 +++++++++++
 drivers/gpu/nova-core/vgpu/fw/commands.rs | 22 ++++++++++++++++++++++
 drivers/gpu/nova-core/vgpu/instance.rs    |  2 ++
 3 files changed, 35 insertions(+)

diff --git a/drivers/gpu/nova-core/vgpu/commands.rs b/drivers/gpu/nova-core/vgpu/commands.rs
index 968942273b9e..7f26d2dabca4 100644
--- a/drivers/gpu/nova-core/vgpu/commands.rs
+++ b/drivers/gpu/nova-core/vgpu/commands.rs
@@ -26,6 +26,7 @@
 use super::{
     fw::{
         commands::{
+            encode_plugin_set_bme,
             VgpuPropertiesSchema, //
         },
         RpcMessage, //
@@ -179,3 +180,13 @@ pub(super) fn send_plugin_config(
 ) -> Result {
     rpc.rpc_call_nvkv(dev, RpcMessage::SetupConfigParamsAndInit, config)
 }
+
+/// Update the bus-mastering state reported to the GSP plugin.
+pub(super) fn set_plugin_bme(
+    dev: &device::Device<device::Bound>,
+    rpc: &mut PluginRpc<'_, '_>,
+    enable: bool,
+) -> Result {
+    let bme = encode_plugin_set_bme(enable)?;
+    rpc.rpc_call_nvkv(dev, RpcMessage::UpdateBmeState, &bme)
+}
diff --git a/drivers/gpu/nova-core/vgpu/fw/commands.rs b/drivers/gpu/nova-core/vgpu/fw/commands.rs
index 3f94435e7a59..9356b4fb643a 100644
--- a/drivers/gpu/nova-core/vgpu/fw/commands.rs
+++ b/drivers/gpu/nova-core/vgpu/fw/commands.rs
@@ -36,6 +36,7 @@
 pub(crate) enum RpcMessage {
     VersionNegotiation = bindings::MESSAGE_NV_VGPU_CPU_RPC_MSG_VERSION_NEGOTIATION,
     SetupConfigParamsAndInit = bindings::MESSAGE_NV_VGPU_CPU_RPC_MSG_SETUP_CONFIG_PARAMS_AND_INIT,
+    UpdateBmeState = bindings::MESSAGE_NV_VGPU_CPU_RPC_MSG_UPDATE_BME_STATE,
 }
 
 bitfield! {
@@ -397,3 +398,24 @@ pub(crate) fn encode_plugin_config_params(
     request.encode(&mut encoder)?;
     Ok(encoder.finish())
 }
+
+nvkv_encode! {
+    struct PluginSetBmeRequest {
+        bme_enable: Key<bool, { Self::BME_ENABLE_KEY }, u32>,
+    }
+}
+
+impl PluginSetBmeRequest {
+    const BME_ENABLE_KEY: KeyId = 0x0100;
+}
+
+/// Encodes a plugin BME state update using the typed NVKV schema.
+pub(crate) fn encode_plugin_set_bme(enable: bool) -> Result<KVVec<u64>> {
+    let request = PluginSetBmeRequest {
+        bme_enable: enable.into(),
+    };
+
+    let mut encoder = Encoder::new();
+    request.encode(&mut encoder)?;
+    Ok(encoder.finish())
+}
diff --git a/drivers/gpu/nova-core/vgpu/instance.rs b/drivers/gpu/nova-core/vgpu/instance.rs
index 247e88bdc82f..23c2b791aa25 100644
--- a/drivers/gpu/nova-core/vgpu/instance.rs
+++ b/drivers/gpu/nova-core/vgpu/instance.rs
@@ -36,6 +36,7 @@
         send_cleanup,
         send_plugin_config,
         send_shutdown,
+        set_plugin_bme,
         Dbdf, //
     },
     fw::commands::{
@@ -162,6 +163,7 @@ fn activate(&mut self, vgpu: &VgpuManager<'gpu>) -> Result {
         self.plugin_rpc.init_rpc()?;
         negotiate_plugin_version(dev, &mut self.plugin_rpc)?;
         self.configure_plugin(dev)?;
+        set_plugin_bme(dev, &mut self.plugin_rpc, true)?;
 
         Ok(())
     }
-- 
2.53.0


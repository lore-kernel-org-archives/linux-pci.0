Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793944063;
	b=NtaAVuLV6QYjUsHe1SN4mPw1C7Z4YxKelZLZwmWFCoBNaFCtWJi8UNQ18Ljk6T5/HtSi
	 9wYbWkQLnP8RSTA+vAtO9Qj6/K7hwurTIhvJh2RGA3LD+5VO+LdKVOBcOB0wbMyGydM/U
	 d2Rvn4fmbU1hlXg2bmaTzBUinwmfNpWOcYLDdsNMWedTPGBTgYNZAMSJiohD8KE5Uf0tF
	 5wl5nbfP7nUu8igoBFvJP56t7DSaZSORN46T9rvbW9YD1nKoxZR/Wn6sIgTdB38zYT0Ri
	 +Anc4DypaMADe+fpgTWvTIldlnhe4ep7vLBjvHlfxNssV3jLd4cERDBZTKgWd7KdRvw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793944063;
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
	bh=fkbvrJqvJ7+9YxgFK/ZLnesemnp2O0m8vjRnKRAvF6s=;
	b=DPyjvLcXg3x97u7HMx9G7S+2f67viryK9eF44yfX1Z+flu9cHCpbRsWJeBkI9iCccvEr
	 t/VzJgo/IK/bYrEsBwbZty9tb3YjFcmZ9uLGf7ixZFk05mYkKTMJkPw9oKQYHfQCfSVQY
	 m5iMbAwnAAxApOMrNRm7KVGiKwgFabDCY6qUvbDe1V7Lb2LwR7w1ZYF57BAMh9qrT4410
	 HEOsMJ44ddvtAtArXHkMKCaHDVFKefmhTzWrKWNotPqCb6piwowplsGHs4mu7TRuKH/uz
	 on63TO5TCFxl4RwpBqv0o6JwYS/DMa0WxtImYXr4mmj7qhxBHJ+HhY7vRaWslFMWytQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=lVdUshaK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.41
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010041.outbound.protection.outlook.com [52.101.56.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4301D606D824;
	Fri,  6 Nov 2026 05:47:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4301D606D824
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=lVdUshaK
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=axiCdKWkOji7nHgrH0nmcGqWzpoyF5GtLUUxUpyc4Cl9mdek7SPNHBfkAKzb96PwltqHE8j9MQMUFs/xSAYyVRdLcy3ZfJpNhunhDqpmsEikebM/CuznTgFCiaDhb+wKyAQzhBmhIa6A9zch847jCCOhlfypBKyT9+pD/OSOpDBQcV+sDZsQ1k/vbc1iKxjD63eCYseKN7CmEAg4sFbE74x3FA2VA3ZRbk19j/0LHu3vvhiKKXAUwieSQX2hsxx91C4A0KwdfjIQ2mVS8l4VP+4ARygA++iEtjcRbs+iXI0AKRiXCnMSGK7jNA8LrstaGvGHkrVieR/l4WUNPtCOpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fkbvrJqvJ7+9YxgFK/ZLnesemnp2O0m8vjRnKRAvF6s=;
 b=RffuWDhVxTdCXVlmQrIleZXHEpO8WSTjAB1MnA7ttZJAnQAtasK2ql/TTPThP/hRM7aTgjjUs54k73r7ZAId/axN1tf1saPwwNW4tLYtFQgZ/nIkJjn8TFfP/pKUKkERXNGaUB6yD+0c7Y8hIfDzyBlE6mBPPNtnTqH9d5jITtO3R7mhEsN+fahht6naaT/PxRpei77bX7BGTb/MFrvlAptzs5RTAyL+y1kJLrYrqVcNC5Ph0/bhxQe/jMq16vEHxjE0jUxhdqPDvHVsxDxYOhCwt8LTekXcoPzaJn0mR1jCIMni2nJxE8nAWwVGCKTZ4aowVn/kahoAqjMIJliehw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fkbvrJqvJ7+9YxgFK/ZLnesemnp2O0m8vjRnKRAvF6s=;
 b=lVdUshaK637qI5LN//bigoGf9z4Eupae6IfHATDum0lebq/NF14Ru8y63YjGt70l08P1E7Z+K97Ih+WCQVN6MLbpwnb6iGv0DTheEgeOUDnefk9slJw0f2Abt/aKBHDVHpAasjc5SmJykhLkvalcW62CZPu9Etxqx5dt5QV8J1a/tV+PKXRvfWVC0FSeznU3ie2wXQALlkQMGIkQN5N9I/9F7OIDsvoNNRwg6mib0Z538k0vEcs1Li5FAMqyW5rtBMhyNntvjo22PR440K2LU5FhK8i6Ywi6gqcOTvAZCj2qJnYoSgRv879vbSSCdfHzQdBNtZYNXnMntkVrbg/AtA==
Received: from SJ0PR05CA0194.namprd05.prod.outlook.com (2603:10b6:a03:330::19)
 by PH8PR12MB7182.namprd12.prod.outlook.com (2603:10b6:510:229::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 05:47:34 +0000
Received: from PH7PEPF0000000A.namprd04.prod.outlook.com
 (2603:10b6:a03:330:cafe::8e) by SJ0PR05CA0194.outlook.office365.com
 (2603:10b6:a03:330::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.5 via Frontend Transport; Fri, 6
 Nov 2026 05:47:34 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 PH7PEPF0000000A.mail.protection.outlook.com (10.167.243.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 05:47:33 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 5 Nov
 2026 21:47:17 -0800
Received: from kalok-SPC741D16QM3.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 21:47:05 -0800
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
Subject: [PATCH v4 29/32] gpu: nova-core: vgpu: add CeUtils commands
Date: Fri, 6 Nov 2026 11:10:02 +0530
Message-ID: <f2c38c1b8efcf80d8487482f9d024b9a9a59708d.1793906667.git.alkumar@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: PH7PEPF0000000A:EE_|PH8PR12MB7182:EE_
X-MS-Office365-Filtering-Correlation-Id: 87239ec2-873a-4f47-ace8-08df3bc97494
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|7416014|36860700016|23010399003|6133799003|18002099003|260925021311599003|22082099003|260925022911599003|56012099006|260925021911599003|3023799007|261026140227099003|261009223027099003|261021121427099003|261022105027099003|261021123027099003|261022075727099003|261026121527099003|11063799006|10067099003|261102123227099003|261028144727099003;
X-Microsoft-Antispam-Message-Info:
	uqoyLnVHEE568rFaVOaMYSntNBGKezNUZhGGlngUhoGDWgmT+N5BZqlFLfRHRXaw3krgCmbf0JIueM2Nwn+uL5jVw31fpQXprCvgkiPXbEZeZqvA4ehZ8/EJa3QN/YFTRgOX3kDeXkO1KMiTNje2GybXvbfMLc/M77p8ixOL9iUoAEVHeBo0DnljozD5rYQP719gQGm5kNhCeAZfbixqj4BhpzOMkHlOHGUr2oEuTgGeVeTaCJDiqZDoiYFEv7on4diUwTwd9mm5zKce11BlbkkeBb6cyws0l3SyZnnfOUWKx+tfLKMrnOfpH1PH8kbysy/a03ZLCdZmb4YRYR6Cuu5n2lwdtfwkUcIX55AlPHxp2rWY8WWdV1KbF8GcSrjeEm+FNAFvSSwfGelFTmpc3oGUkBQPpJgpgAoxomavXDLhm/hU+JydwsKltSnsDahVxcyuFj1nYj45usRI7fEBL8Gdne7LY3sCk7AhoJVNacSIxjNSHC2H/w3BlD/sXeUyaxGPUKCmqiheHbS1ALM6gGNFlVoX4yoWo2hgzoGbaKkq3rx+6ZJoFYUvv08WuYt28ITuIfx/Gw8kJLfvT9bcGelWwTUAymczkHGh4at2qNM8IPQXKvjZEWVrBFWTEdWA1p6RLFDMnrgUub0U4IRMaxqiFGy5PbaBWIKivfavtn5wUfA81IB1Anw4LQTy3e3l26+qHRVPYoNbpsWP27fmNg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(7416014)(36860700016)(23010399003)(6133799003)(18002099003)(260925021311599003)(22082099003)(260925022911599003)(56012099006)(260925021911599003)(3023799007)(261026140227099003)(261009223027099003)(261021121427099003)(261022105027099003)(261021123027099003)(261022075727099003)(261026121527099003)(11063799006)(10067099003)(261102123227099003)(261028144727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	+uiBjmzAqRSZrH5K3H9aTt+aCukr4Z+ExlbJbnGM7B1N6P79oyFmb/fl4JyS97ahHE/iSP12nq6apc4zCycu6frgWPthcrudEYk0YyP1FfsnrHR4xG5rqrBIo+aCgBBb45smgTebOoGqtyQgVrLSDSeOuPW+RAcF+bvcmvEROu7KP/+chkFdvl9B8TBalKA3fjFpjitayK8PC/kUPwHICcHRR7XIWJxst+L4vMWmpWvo+wrngg1wpTNEY/1Hqzi9LeR6LQgDDQEV6oy6GZzSKUo/aC/BkQQg+IvAjrzyh4m1jGHdRX3Jrx216THPPTBgxlVLlgDKKl4XH7AsqlgcruTIY4tiZZDoWzjuwG2ZdKBOrVsemTQu96El6ugfuqKFl2E8e/keUghzfkaTmHyMSpQksGeuecKOj8+YuMhhCMikgIPGCSL9D4erdk3Blbp8
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 05:47:33.9302
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87239ec2-873a-4f47-ace8-08df3bc97494
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	PH7PEPF0000000A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7182

From: Zhi Wang <zhiw@nvidia.com>

Add Cmdq operations to allocate and free a CeUtils channel and submit
guest VRAM scrub requests. Decode the allocation and scrub replies, and
validate the returned semaphore address and aperture.

Distinguish an explicit allocation rejection from failures that may leave
firmware owning the channel, so callers can decide whether to retain its
host resources.

Signed-off-by: Zhi Wang <zhiw@nvidia.com>
Signed-off-by: Alok Kumar <alkumar@nvidia.com>
---
 .../gpu/nova-core/gsp/fw/r000_00/bindings.rs  |   1 +
 drivers/gpu/nova-core/vgpu/commands.rs        | 145 ++++++++++++++++--
 drivers/gpu/nova-core/vgpu/fw.rs              |  11 ++
 drivers/gpu/nova-core/vgpu/fw/commands.rs     |  52 ++++++-
 4 files changed, 198 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/fw/r000_00/bindings.rs b/drivers/gpu/nova-core/gsp/fw/r000_00/bindings.rs
index 3cc718bb2ab8..333256ea8a04 100644
--- a/drivers/gpu/nova-core/gsp/fw/r000_00/bindings.rs
+++ b/drivers/gpu/nova-core/gsp/fw/r000_00/bindings.rs
@@ -851,6 +851,7 @@ fn default() -> Self {
         }
     }
 }
+pub const NV_ADDR_FBMEM: u32 = 2;
 pub const GSP_PLUGIN_BOOTLOADED: u32 = 1315261039;
 pub const VGPU_CPU_GSP_CTRL_BUFF_VERSION: u32 = 2;
 pub const VGPU_CPU_GSP_CTRL_BUFF_REGION_SIZE: u32 = 4096;
diff --git a/drivers/gpu/nova-core/vgpu/commands.rs b/drivers/gpu/nova-core/vgpu/commands.rs
index 7f26d2dabca4..44ab9175313f 100644
--- a/drivers/gpu/nova-core/vgpu/commands.rs
+++ b/drivers/gpu/nova-core/vgpu/commands.rs
@@ -8,34 +8,50 @@
 
 use kernel::{
     device,
+    num::casts::{
+        usize_as_u64,
+        usize_into_u32, //
+    },
     prelude::*,
     time::Delta,
     transmute::AsBytes, //
 };
 
-use crate::gsp::{
-    cmdq::Cmdq,
-    nvkv::{
-        nvkv_words,
-        Decoder,
-        Schema,
-        UnknownKeyPolicy, //
-    }, //
+use crate::{
+    gsp::{
+        cmdq::Cmdq,
+        nvkv::{
+            nvkv_words,
+            Decoder,
+            Schema,
+            UnknownKeyPolicy, //
+        }, //
+    },
+    mm::PAGE_SIZE, //
 };
 
 use super::{
     fw::{
         commands::{
             encode_plugin_set_bme,
+            AllocCeutilsRequest,
+            AllocCeutilsResponse,
+            FreeCeutilsRequest,
+            ScrubGuestFbRequest,
+            ScrubGuestFbResponse,
             VgpuPropertiesSchema, //
         },
-        RpcMessage, //
+        RpcMessage,
         GMCAPI_CMD_BOOTLOAD_GSP_VGPU_PLUGIN_TASK,
         GMCAPI_CMD_CLEANUP_GSP_VGPU_PLUGIN_RESOURCES,
         GMCAPI_CMD_QUERY_ASSIGNED_VF_VGPU_TYPE,
         GMCAPI_CMD_QUERY_VGPU_PROPERTIES,
         GMCAPI_CMD_SHUTDOWN_GSP_VGPU_PLUGIN_TASK,
         GMCAPI_CMD_SHUTDOWN_GSP_VGPU_PLUGIN_TASK_COMPLETE,
+        GMCAPI_CMD_VGPU_MGR_ALLOC_GSP_CEUTILS,
+        GMCAPI_CMD_VGPU_MGR_FREE_GSP_CEUTILS,
+        GMCAPI_CMD_VGPU_MGR_SCRUB_GUEST_FB,
+        NV_ADDR_FBMEM, //
     },
     gsp_plugin_rpc::PluginRpc,
     instance::Gfid, //
@@ -190,3 +206,114 @@ pub(super) fn set_plugin_bme(
     let bme = encode_plugin_set_bme(enable)?;
     rpc.rpc_call_nvkv(dev, RpcMessage::UpdateBmeState, &bme)
 }
+
+/// Whether a failed allocation may still have transferred CHID ownership to firmware.
+#[expect(dead_code)]
+pub(super) enum CeUtilsAllocError {
+    /// A matching firmware response explicitly rejected the allocation.
+    NotOwned(Error),
+    /// The request may have completed despite a transport or response-validation error.
+    MayOwn(Error),
+}
+
+/// Allocate a CeUtils channel and validate its semaphore description.
+#[expect(dead_code)]
+pub(super) fn alloc_ceutils(
+    dev: &device::Device<device::Bound>,
+    cmdq: &Cmdq<'_>,
+    gfid: Gfid,
+    chid: u32,
+) -> core::result::Result<u64, CeUtilsAllocError> {
+    let request = AllocCeutilsRequest {
+        gfid: u32::from(gfid.get()).to_le(),
+        fixed_chid: chid.to_le(),
+        force_ceid: u32::MAX.to_le(),
+        swizz_id: 0,
+    };
+
+    dev_dbg!(dev, "alloc CeUtils: gfid={} chid={}\n", gfid.get(), chid,);
+
+    let command_id = GMCAPI_CMD_VGPU_MGR_ALLOC_GSP_CEUTILS;
+    let response = cmdq
+        .send_gmc_and_receive(
+            command_id,
+            IntoBytes::as_bytes(&request),
+            usize_into_u32::<{ size_of::<AllocCeutilsResponse>() }>(),
+        )
+        .map_err(CeUtilsAllocError::MayOwn)?;
+    check_status(dev, command_id, response.status).map_err(CeUtilsAllocError::NotOwned)?;
+    let (response, _) = AllocCeutilsResponse::read_from_prefix(&response.payload)
+        .map_err(|_| CeUtilsAllocError::MayOwn(EMSGSIZE))?;
+
+    let semaphore_address = u64::from_le(response.semaphore_address);
+    let semaphore_aperture = u32::from_le(response.semaphore_aperture);
+    let page_size = usize_as_u64(PAGE_SIZE);
+
+    if semaphore_address == 0
+        || !semaphore_address.is_multiple_of(page_size)
+        || semaphore_aperture != NV_ADDR_FBMEM
+    {
+        return Err(CeUtilsAllocError::MayOwn(EINVAL));
+    }
+
+    dev_dbg!(
+        dev,
+        "alloc CeUtils: gfid={} semaphore={:#x}\n",
+        gfid.get(),
+        semaphore_address,
+    );
+    Ok(semaphore_address)
+}
+
+/// Release a CeUtils allocation, including one whose allocation reply was lost.
+#[expect(dead_code)]
+pub(super) fn free_ceutils(
+    dev: &device::Device<device::Bound>,
+    cmdq: &Cmdq<'_>,
+    gfid: Gfid,
+) -> Result {
+    let request = FreeCeutilsRequest {
+        gfid: u32::from(gfid.get()).to_le(),
+    };
+
+    dev_dbg!(dev, "free CeUtils: gfid={}\n", gfid.get());
+    let command_id = GMCAPI_CMD_VGPU_MGR_FREE_GSP_CEUTILS;
+    let response = cmdq.send_gmc_and_receive(command_id, IntoBytes::as_bytes(&request), 0)?;
+    check_status(dev, command_id, response.status)
+}
+
+/// Submit an asynchronous guest FB scrub and return its work identifier.
+#[expect(dead_code)]
+pub(super) fn submit_ceutils_scrub(
+    dev: &device::Device<device::Bound>,
+    cmdq: &Cmdq<'_>,
+    gfid: Gfid,
+    fb_offset: u64,
+    fb_size: u64,
+) -> Result<u32> {
+    let request = ScrubGuestFbRequest {
+        gfid: u32::from(gfid.get()).to_le(),
+        reserved: 0,
+        fb_offset: fb_offset.to_le(),
+        fb_size: fb_size.to_le(),
+    };
+
+    dev_dbg!(
+        dev,
+        "submit scrub: gfid={} offset={:#x} size={:#x}\n",
+        gfid.get(),
+        fb_offset,
+        fb_size,
+    );
+
+    let command_id = GMCAPI_CMD_VGPU_MGR_SCRUB_GUEST_FB;
+    let response = cmdq.send_gmc_and_receive(
+        command_id,
+        IntoBytes::as_bytes(&request),
+        usize_into_u32::<{ size_of::<ScrubGuestFbResponse>() }>(),
+    )?;
+    check_status(dev, command_id, response.status)?;
+    let (response, _) =
+        ScrubGuestFbResponse::read_from_prefix(&response.payload).map_err(|_| EMSGSIZE)?;
+    u32::try_from(u64::from_le(response.work_id)).map_err(|_| EOVERFLOW)
+}
diff --git a/drivers/gpu/nova-core/vgpu/fw.rs b/drivers/gpu/nova-core/vgpu/fw.rs
index 6cec92c9b505..795ce4855586 100644
--- a/drivers/gpu/nova-core/vgpu/fw.rs
+++ b/drivers/gpu/nova-core/vgpu/fw.rs
@@ -27,6 +27,8 @@
     VGPU_CPU_GSP_VGPU_TASK_LOG_BUFF_REGION_SIZE, //
 };
 
+pub(super) use bindings::NV_ADDR_FBMEM;
+
 pub(super) use commands::RpcMessage;
 
 pub(super) const GMCAPI_CMD_QUERY_ASSIGNED_VF_VGPU_TYPE: u32 =
@@ -47,6 +49,15 @@
 pub(super) const GMCAPI_CMD_CLEANUP_GSP_VGPU_PLUGIN_RESOURCES: u32 =
     bindings::GMCAPI_COMMANDS_GMCAPI_CMD_CLEANUP_GSP_VGPU_PLUGIN_RESOURCES;
 
+pub(super) const GMCAPI_CMD_VGPU_MGR_ALLOC_GSP_CEUTILS: u32 =
+    bindings::GMCAPI_COMMANDS_GMCAPI_CMD_VGPU_MGR_ALLOC_GSP_CEUTILS;
+
+pub(super) const GMCAPI_CMD_VGPU_MGR_FREE_GSP_CEUTILS: u32 =
+    bindings::GMCAPI_COMMANDS_GMCAPI_CMD_VGPU_MGR_FREE_GSP_CEUTILS;
+
+pub(super) const GMCAPI_CMD_VGPU_MGR_SCRUB_GUEST_FB: u32 =
+    bindings::GMCAPI_COMMANDS_GMCAPI_CMD_VGPU_MGR_SCRUB_GUEST_FB;
+
 /// State observed in the response buffer for an expected RPC sequence.
 pub(super) enum RpcResponse {
     Pending {
diff --git a/drivers/gpu/nova-core/vgpu/fw/commands.rs b/drivers/gpu/nova-core/vgpu/fw/commands.rs
index 9356b4fb643a..b040c8c36572 100644
--- a/drivers/gpu/nova-core/vgpu/fw/commands.rs
+++ b/drivers/gpu/nova-core/vgpu/fw/commands.rs
@@ -20,10 +20,10 @@
         Array,
         Encodable,
         Encoder,
-        Index, //
+        Index,
         Key,
         KeyId,
-        Required,
+        Required, //
     },
     mm::vram::VramRegion, //
 };
@@ -399,6 +399,54 @@ pub(crate) fn encode_plugin_config_params(
     Ok(encoder.finish())
 }
 
+#[repr(C)]
+#[derive(IntoBytes, zerocopy_derive::Immutable)]
+pub(crate) struct AllocCeutilsRequest {
+    pub(crate) gfid: u32,
+    pub(crate) fixed_chid: u32,
+    pub(crate) force_ceid: u32,
+    pub(crate) swizz_id: u32,
+}
+
+static_assert!(size_of::<AllocCeutilsRequest>() == 16);
+
+#[repr(C)]
+#[derive(FromBytes)]
+pub(crate) struct AllocCeutilsResponse {
+    pub(crate) semaphore_address: u64,
+    pub(crate) semaphore_aperture: u32,
+    _reserved: u32,
+}
+
+static_assert!(size_of::<AllocCeutilsResponse>() == 16);
+
+#[repr(C)]
+#[derive(IntoBytes, zerocopy_derive::Immutable)]
+pub(crate) struct FreeCeutilsRequest {
+    pub(crate) gfid: u32,
+}
+
+static_assert!(size_of::<FreeCeutilsRequest>() == 4);
+
+#[repr(C)]
+#[derive(IntoBytes, zerocopy_derive::Immutable)]
+pub(crate) struct ScrubGuestFbRequest {
+    pub(crate) gfid: u32,
+    pub(crate) reserved: u32,
+    pub(crate) fb_offset: u64,
+    pub(crate) fb_size: u64,
+}
+
+static_assert!(size_of::<ScrubGuestFbRequest>() == 24);
+
+#[repr(C)]
+#[derive(FromBytes)]
+pub(crate) struct ScrubGuestFbResponse {
+    pub(crate) work_id: u64,
+}
+
+static_assert!(size_of::<ScrubGuestFbResponse>() == 8);
+
 nvkv_encode! {
     struct PluginSetBmeRequest {
         bme_enable: Key<bool, { Self::BME_ENABLE_KEY }, u32>,
-- 
2.53.0


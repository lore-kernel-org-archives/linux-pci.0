Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.70
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793944020;
	b=JGY8DhoU6JQdV8AN/WjWs2Zr9HLV/RyBXZCfhwiQcSSusidOIDjsgGRuTSTIfzoeUMjX
	 Rgb2H+zNjaZ6uFiTOIS7VXelrRN6u74a5x2VR/EMbnVXAJ0xUEIMnlibSI0aC8DAFq5CX
	 nUOKoCbtJKowzoXbBuijIJFOzNinLBQpRCEbVXsX58Y4KBzi1xApATkJL9zVk/LakF5up
	 5NRLw1VKHXsmAYBIxc8OMkEN11PkBz5OPYmh48mDVdgVsdMssVhdXZTzvMLoPgQbYmxow
	 s8ahrH2QKUZ7jLSoYIP+NIIPlF8CZppu5HHTaOwYmIcoGztJ+cneZAPRiwe/DC/K64Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793944020;
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
	bh=YHM0DATVwYj1+TQXpHHq5s0uIfSh7Z1jau7VMlebINI=;
	b=M9fh6XUCXzCyCmLNoWqf5gw6IvuD4ZN3+lBzVVsW9i9kgsi4+hzKBPGKPobkZq3I76R9
	 MuoziakqA5Ra8lZpltqbBmqDu0sYVXs9c+jVskU5uIR8zp7sCuqbWDSLf88hJsYnmVF3J
	 iDFfW6Sb0ZO43V1xr3Gv2nMW9CoCiUX16lExzj1gTniD6G9DEscVkU2PFB9MuRlQQVT1w
	 G+H3mjQ+7ATa0B6Z+FCqECRl/Wn5otN3Ljr0ORImHVDMyIX/4Cp7UU78GFAnikUMqiH/E
	 00+CRUhe1wfNldrHDS0UGCbRKneSffRJ0J254pmzNgRX5XS+X5+x8PS4/Lmh5PdehTA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=BPb3pkTO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.70
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011070.outbound.protection.outlook.com [40.107.208.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800F3606A331;
	Fri,  6 Nov 2026 05:46:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 800F3606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=BPb3pkTO
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wG6Xm4r60MbSeINEDR+PquFCng1SG+VBga5PXxyKo/m1UH5l1h5rXHhqr+QcJGff/+DV/8vSekIZQ8YgZjf/f9THMzYn2yxBCVILGxI+ArmuQsCCuY3rfCd45JKKDOEkUtPco5PyDkcev76WJ2Mz//PSn9BhRrq9C6SVDcIQWTHVxy3HKCbEUh1IGU2YTozc9Zpe+2ucYREN/k/DRHWQ7S12DpgLtG6qlSc574hfV1iE62DcKf7rukCgACdsDXlJcq5NY+5Zvx484qly+w93k99BVQSA/wQKhxGUS6UEs4ioN+J2DR2Xa6BByvpnGn9Ctu2sa8rLXC/tBN+7TvaN0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YHM0DATVwYj1+TQXpHHq5s0uIfSh7Z1jau7VMlebINI=;
 b=F2DDWa43hnqMpTs3igd/L4/I9hiy/fl2k8WWwxYZQZi3kdUTt3SnESE/MTH9bal90yUyXj2Fbw52qPM+Ul40431EvLTi6+QPTFy4/jNBvEoPV/RJjQYGuYHsGkp9CZ8F5sJHhAsiPJyAluH5+L6dQKCLrjMcmey67VCRcLdaSPZYQx5lArVAjAVbK2w1efoVeVoqzJOEanATegMsbjLX0w6VdN62pT/mmqTbnNZqDbs8umxc5hdZqW3ndWGIrkO9Fefv6S3LjCEsr1ggL047cFNkPTgQq1WNxnGfJn0C1p2BXqSHG2OLRmuiIVj/+yhEGUgFUpW7to0mouwGfx8yBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YHM0DATVwYj1+TQXpHHq5s0uIfSh7Z1jau7VMlebINI=;
 b=BPb3pkTODMdzL6P1F0sv+jJPX245VIGiYWrdqFTSk+DXK+qt63d7Bwzw1AzBujB8F5NScDTUiRGNKWfTQ721xihNYIx/2LCzn72R1bLTjtBcpS7BlvGB0RGIE4jlV5unQIFyurriaIt8znS+0DnTD0pHEOHY7cdI5AtFQ6DbJH20gPHsZtYJx61xOItutw1o+Hm6dtQwhRefUuGR419ngbiaA36xWY7pGXnPeXNzmDaB9V7Wy0tBIqb0Man2TwZNXLOoHGrVeKOR1rGULhLr9UHur/2NQys7xXheInnXulwXJrULfcsBNhM1h2UTjbIGZAXCTRprIir3sqqGuKX17g==
Received: from PH0PR07CA0116.namprd07.prod.outlook.com (2603:10b6:510:4::31)
 by BL1PR12MB5921.namprd12.prod.outlook.com (2603:10b6:208:398::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 05:46:54 +0000
Received: from PH7PEPF0000000C.namprd04.prod.outlook.com
 (2603:10b6:510:4:cafe::57) by PH0PR07CA0116.outlook.office365.com
 (2603:10b6:510:4::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Fri, 6
 Nov 2026 05:46:54 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 PH7PEPF0000000C.mail.protection.outlook.com (10.167.243.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 05:46:54 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 5 Nov
 2026 21:46:40 -0800
Received: from kalok-SPC741D16QM3.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 21:46:27 -0800
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
Subject: [PATCH v4 26/32] gpu: nova-core: vgpu: negotiate the GSP plugin RPC version
Date: Fri, 6 Nov 2026 11:09:59 +0530
Message-ID: <febc3089bb6480b991605b22119df087017ac8be.1793906667.git.alkumar@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: PH7PEPF0000000C:EE_|BL1PR12MB5921:EE_
X-MS-Office365-Filtering-Correlation-Id: 3143655d-6674-4266-e1eb-08df3bc95cef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|23010399003|7416014|1800799024|18002099003|22082099003|6133799003|10067099003|3023799007|11063799006|261102123227099003|261026140227099003|261026121527099003|261028144727099003|261021123027099003|261021121427099003|261021135927099003|261022105027099003|261022075727099003|56012099006|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	Hoz815tU9RsIh4gEQakJqVE/aClpjwpeU96JkSuhw8jeOcBHAaOw2z1Q/uzV3Wqhzvylupg7WruUiAWn8aFeUnAfHWds/FEXsYuu0sXC3oyD1adJysIyDIjKpil/puDgOM5alY8uPXci309GnWTzJTtaITalMBA3Q7LGdDMkmUEU31uNGD/MnpUzgZebyiu75Hf1QpYnjRLkZTAlnJdnFnrC9fyi2xEPCsdHwtJMpsDNfqfPLDWQiTZGtTSvjTwL4R0n2zjWNzgthflAtjtxy7kwDbkGrmvUTpRkIBPcr1gL3NiDJcByUIahbwUvLpgLUWUTcrGxDhP6fK3t2PkkL5mzGlMNb/Yc43688Gbzv0+98YKFslarxJqFEWKyDR6NSyV2s6n30Fs3XoxrPYhXRYyIg/8cZdyDLduO2NH/CiCGpYLmBVldulKYacboErVk1HQFLfVW0C8tBGo3jfk4CA7DmpYG+AuXqB5l2igax3suQu/NSSWq+je3zQyrrDdS6SJ2HYB2dz3hZB+K9jHJmLBCc1IILuVCQHw0nim37qupZjAsnXVfhO1dkEgIM++YqWFMcE0xJoKbZPpZzmH955JYeUmUTtLJHjUoli/AxX7HRYF2wfRIU4loYMSUeK91p9bEl7Rk700Fs4hwlYJ4Yi/Okztu5PS84QZMmvKzUJ6L0QSAhxzVqqDnsSTqu6OCliUr5LZny31nihWE/bSHQw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(23010399003)(7416014)(1800799024)(18002099003)(22082099003)(6133799003)(10067099003)(3023799007)(11063799006)(261102123227099003)(261026140227099003)(261026121527099003)(261028144727099003)(261021123027099003)(261021121427099003)(261021135927099003)(261022105027099003)(261022075727099003)(56012099006)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	W/pvGKzX11E0KwBvPMK4N36CKyw/5GJRtCLwywc05x0lo+PqOGQW47kHNThBs5XDxAu+OCAexGCjnav3ueXVUQ3cmYzJ7dwu1cncrrZwbYiOOcXkvfQfXd1/5pYTHGuYE1qMPVt+vDao3nvb2Cs4ATlet2fGHegOgmjPUZsleQJ/Lj4pw15W3425jel/AaALDY0c4XfiR27zo38hH4G4F6UbkjR+ydQMJNVTa/GtHUKGqh4dcjmW3+3FTeS51aZstNEaXzr73aZFKfEUkBOT7VhPKRMm1ZLup01Mj9CnufTidASnOU5TJwTK/0HZetwfZOByxeD0/BvHt7+MJjwuMXHpVqqUTpgxOZE40n75iVFuyVCxA0sdbI9uCB80dgUQi/WZQ/ypSXQtcg+HzCzALrAzkaTg2qQCRZcPuRRwDKUCT2mgNGTcVmg/TUL9wiIH
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 05:46:54.3035
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3143655d-6674-4266-e1eb-08df3bc95cef
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	PH7PEPF0000000C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5921

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
 drivers/gpu/nova-core/vgpu/commands.rs       | 12 +++++++++++-
 drivers/gpu/nova-core/vgpu/fw.rs             |  4 ++--
 drivers/gpu/nova-core/vgpu/fw/commands.rs    |  1 -
 drivers/gpu/nova-core/vgpu/gsp_plugin_rpc.rs |  2 --
 drivers/gpu/nova-core/vgpu/instance.rs       |  3 +++
 5 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/nova-core/vgpu/commands.rs b/drivers/gpu/nova-core/vgpu/commands.rs
index 00da8fa4f910..a68841fe4019 100644
--- a/drivers/gpu/nova-core/vgpu/commands.rs
+++ b/drivers/gpu/nova-core/vgpu/commands.rs
@@ -28,13 +28,15 @@
         commands::{
             VgpuPropertiesSchema, //
         },
+        RpcMessage, //
         GMCAPI_CMD_BOOTLOAD_GSP_VGPU_PLUGIN_TASK,
         GMCAPI_CMD_CLEANUP_GSP_VGPU_PLUGIN_RESOURCES,
         GMCAPI_CMD_QUERY_ASSIGNED_VF_VGPU_TYPE,
         GMCAPI_CMD_QUERY_VGPU_PROPERTIES,
         GMCAPI_CMD_SHUTDOWN_GSP_VGPU_PLUGIN_TASK,
-        GMCAPI_CMD_SHUTDOWN_GSP_VGPU_PLUGIN_TASK_COMPLETE, //
+        GMCAPI_CMD_SHUTDOWN_GSP_VGPU_PLUGIN_TASK_COMPLETE,
     },
+    gsp_plugin_rpc::PluginRpc,
     instance::Gfid, //
 };
 
@@ -160,3 +162,11 @@ pub(super) fn send_cleanup(
     dev_dbg!(dev, "cleanup: gfid={} done\n", gfid.get());
     Ok(())
 }
+
+/// Negotiate the host protocol with a bootloaded GSP plugin.
+pub(super) fn negotiate_plugin_version(
+    dev: &device::Device<device::Bound>,
+    rpc: &mut PluginRpc<'_, '_>,
+) -> Result {
+    rpc.rpc_call(dev, RpcMessage::VersionNegotiation, &[])
+}
diff --git a/drivers/gpu/nova-core/vgpu/fw.rs b/drivers/gpu/nova-core/vgpu/fw.rs
index d80f36465296..6cec92c9b505 100644
--- a/drivers/gpu/nova-core/vgpu/fw.rs
+++ b/drivers/gpu/nova-core/vgpu/fw.rs
@@ -10,8 +10,6 @@
 
 use crate::gsp::bindings;
 
-pub(super) use commands::RpcMessage;
-
 pub(super) use bindings::{
     GSP_PLUGIN_BOOTLOADED,
     VGPU_CPU_GSP_COMMUNICATION_BUFF_TOTAL_SIZE,
@@ -29,6 +27,8 @@
     VGPU_CPU_GSP_VGPU_TASK_LOG_BUFF_REGION_SIZE, //
 };
 
+pub(super) use commands::RpcMessage;
+
 pub(super) const GMCAPI_CMD_QUERY_ASSIGNED_VF_VGPU_TYPE: u32 =
     bindings::GMCAPI_COMMANDS_GMCAPI_CMD_QUERY_ASSIGNED_VF_VGPU_TYPE;
 
diff --git a/drivers/gpu/nova-core/vgpu/fw/commands.rs b/drivers/gpu/nova-core/vgpu/fw/commands.rs
index 917de4d21861..c3d0acece2eb 100644
--- a/drivers/gpu/nova-core/vgpu/fw/commands.rs
+++ b/drivers/gpu/nova-core/vgpu/fw/commands.rs
@@ -30,7 +30,6 @@
 use super::bindings;
 
 /// Message types supported by the nova-core plugin RPC channel.
-#[expect(dead_code)]
 #[derive(Clone, Copy)]
 #[repr(u32)]
 pub(crate) enum RpcMessage {
diff --git a/drivers/gpu/nova-core/vgpu/gsp_plugin_rpc.rs b/drivers/gpu/nova-core/vgpu/gsp_plugin_rpc.rs
index 0ee32f011f63..696127c7169f 100644
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
         dev: &device::Device<device::Bound>,
diff --git a/drivers/gpu/nova-core/vgpu/instance.rs b/drivers/gpu/nova-core/vgpu/instance.rs
index 8a2d8e3970a3..445d7f513fdc 100644
--- a/drivers/gpu/nova-core/vgpu/instance.rs
+++ b/drivers/gpu/nova-core/vgpu/instance.rs
@@ -31,6 +31,7 @@
 
 use super::{
     commands::{
+        negotiate_plugin_version,
         send_bootload,
         send_cleanup,
         send_shutdown,
@@ -156,6 +157,8 @@ impl<'gpu> VgpuInstance<'gpu> {
     fn activate(&mut self, vgpu: &VgpuManager<'gpu>) -> Result {
         let dev = vgpu.dev;
         self.bootload(dev, vgpu.cmdq, &vgpu.fifo_engine_list)?;
+        self.plugin_rpc.init_rpc()?;
+        negotiate_plugin_version(dev, &mut self.plugin_rpc)?;
 
         Ok(())
     }
-- 
2.53.0


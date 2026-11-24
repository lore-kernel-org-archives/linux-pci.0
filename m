Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795529073;
	b=cW4kLtdxtdx5hd2JuaMxMsghr1YbVGjCsUXYzM0O5r/rNM4xr8QiVxVTk2F4QjqXTmZj
	 BVV4lYhCxM7cvpJjJfEiz0vbpE3DqAfRTjvhM6Vvyqhaqidd/sm2ySI6qr8b/jtLAIe00
	 Z4MFvOYR2m9bcnp02rwGSavMbOZ4GAxwCl91OcTBlvHzyGQSPRaHHiCPnWHYS3bXgyywl
	 dRPf4eLBqsNVKUaep8SiCmU5bqr8v9jU1Ymg75PVz7kHmisXhWdVRdsW8UCHKFkF0IG1d
	 aRSbLiICVWa4bNJSqWNHqYUZ5b14onMvrUZfMpuDnRXRrQMs/Vs4qPrLVf1kR7eFY/w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795529073;
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
	bh=1hVkqR868BWXjRgEfEKTz4D5YWsSoCUNnZUfrqwIDIA=;
	b=Azl+hqMeckW+sTzYqbENuadACdCw2cV9b8fSWThj73qykPm1XqNpHfpI63gNP8U7DQQo
	 r4xbT4i78ld/O0uwcgUGhO2MmOSFYd/Zjtu4+WQupnPZpDlOHxre+S2rYQ5oR9tl/qlJB
	 mt6zkli+1ZVDlAd1aKcNA+zec/a4yhkELWVx5RarV0g6W+NkIAINClaP8ylBkmvrYFF9C
	 aPbsrxMH+/1TkLk8jRA0XPM4plsXa9JYmERbQeOPMmUOcooZZNXbftG6lBUR3CBmKsamv
	 0sbJfa/+JnbieNdGzK36MJKuI/n5g/Nb3lmUrJ7bKgyCJem5cQ/MxmHSQj0d4SvLMJQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=CameVHpO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.49
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012049.outbound.protection.outlook.com [52.101.53.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD7860A3803;
	Tue, 24 Nov 2026 14:04:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1AD7860A3803
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=CameVHpO
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MQhzUth9iQrUdV9TGuNK+YjNKPj8eCgHkYOMD0O50P/ZAyo6zTsumjX8skDAW5hzT4fJjBUAK+mHu3CHmpPaNDesLk3odYl3BqQ/oWt3bvBHcJneLNfG+eejBaxpHhzoaFKla8O24WhsqDWiay5VuK0XY6fCalwMj7ms7JEpBJ8WJpz5SWElGA5Ibg3VTYvEVdx/lniL7C7pgyxWMvhbmSy46OQhsOhDfQAr5TBQtf2U6pDJpurMAy6Fx5xyDpOSqEkHxqtSDQ2IB7ab/KQ5EZ1QNi8oTFoOlWN7rXwEetxMsu0uMHFHAC9xDZ00SBTctbM2HkOLxkFfHmJ+bWaIwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1hVkqR868BWXjRgEfEKTz4D5YWsSoCUNnZUfrqwIDIA=;
 b=g1OM8Db0nrnIy0zJWiBokfnD1TRWHZ7TxkIGvgegwfPHpEJ2WnsGogoVCZApBMI5TwJcWVmj6BhzvYnmK5xBwSijw++IAGoZ8IQLN/aRu9f/P0Fr2hYxzyHuKbFAx7FPCJ3rSVkdJw/D5z0UdM/8Od1JpOUu3e0CbAOVj+lBEtuTvawQEuIFrrU+GKMVWAC+Y2AvBzyLHPi6HH595m40IjX5KoVcAENDAeKWJ+7XC0ixQdgZ83uGcpBx//FHAUpp2t/9qnU/K3TxyN79oOS0IN6cDYqJUd+qrA4+Ol7jp7TQkUpvrmObqGCqGgvNTX2Myd5zyM7bJgKw0O3z/qnfdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1hVkqR868BWXjRgEfEKTz4D5YWsSoCUNnZUfrqwIDIA=;
 b=CameVHpORJ0roLfc6l/dsKW4EwpPOG940B8ko9NJTjV6nKBHtngzYfUom0tOggJiyvh5MDPIr0mqc8PWABg9bcn6BASYJbRNKEDftn4uk3Bio2VN/1CNgln1SL1JpjbbzsBnGh30g2tvU014VBIq6ahQx8n943XCLA5AZkGqnEk4aYWPRndINLvkZtxWJWkAFEEw5PfhVTrYIQ2+BDke8RptUR4bJ0U9Ek5wzNSTT7cuZ9YwL8n7/aqC1+22qlCp0nzMR7wXGJOsxb2msWlb1Ci322nBq9VjhUjM0T41wExCktnRnCFG9gbh9HGCfydEA4CkzspYimYjuot1XV4qaA==
Received: from PH2PEPF0000384A.namprd17.prod.outlook.com (2603:10b6:518:1::67)
 by DM3PR12MB9285.namprd12.prod.outlook.com (2603:10b6:0:49::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.4; Tue, 24 Nov 2026 14:04:24 +0000
Received: from CY6PEPF0000004A.namprd03.prod.outlook.com
 (2a01:111:f403:f910::) by PH2PEPF0000384A.outlook.office365.com
 (2603:1036:903:48::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.6 via Frontend Transport; Tue, 24
 Nov 2026 14:04:23 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY6PEPF0000004A.mail.protection.outlook.com (10.167.247.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Tue, 24 Nov 2026 14:04:23 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 24 Nov
 2026 06:03:52 -0800
Received: from kalok-SPC741D16QM3.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 06:03:39 -0800
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
Subject: [PATCH v5 17/35] gpu: nova-core: gsp: add the vGPU commands to GmcCommandId
Date: Tue, 24 Nov 2026 19:29:13 +0530
Message-ID: <20261124135937.18583-18-alkumar@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY6PEPF0000004A:EE_|DM3PR12MB9285:EE_
X-MS-Office365-Filtering-Correlation-Id: c245fe00-1eb0-4866-e69b-08df4a33d7e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700016|23010399003|1800799024|82310400026|10067099003|11063799006|56012099006|261022075727099003|261022105027099003|261022113327099003|261021123027099003|261021121427099003|261026121527099003|261026140227099003|261028144727099003|261102123227099003|261009223027099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	vwjxyLeQ0mAC0RSh+4JNGrJZgCZtiTfB23gFcfnJM0/hpWtfXLS3IapmF7SfcgxwdKcMJn+TSQQ55fPZ5rmpESrKVUL46Hs90a6htJJ7wJaeoWv5fX+eOwmjnRCvMgrYHW9JZq0p4BlvUR0sJ32dBjdB4WD6VWhcFqoiS2lJ+sD1LnMUJmUM/79JLEr6xy6bASPiWUJTAuoKdTz6zf6nb3zdNgvNNK0tIn6bvBUBDPm3ZarH2aB3e4jgTGB8lFHEIZR1fzB8UI9kcF/m6Viv3SWpTDWHpGiLrUn9Iz3Bbzka3dYztYD2uyl8JL2o1SWV+4MRYdgF4iCZ4qVc5NfOZPHQckIXSzROQUK87624V+jgKyjvAZEr0qIIaNwQKB80CxLRwXy964942hgjy9iZ3e6PhanORhdpSnTZWSuiQVC6g+ppN0D4DWaHoW7yXtw6qV+5rR5O5D/hqWpc0FE3tYn4Y1/XmO3WPAp5ItBoWjWzypaUgSAInY4GvQllsbBpo2mqvZHMqrgZ6Fdb5EVdGU/LVzJ+LmdbesX/+TMSZYFjwdyorsb6OV/THJ1PUDfC1muVT+ky/VK+hKCMMS4O+dD0/rZzt2vMKwGqsXKzdZhytGpDtKNkyoOY8fscS48ifa6wywLuSlF1uwrQIxe10MpotZrWfb+tGrAlPB1/WK4c6fcb+eMPQaLvVtjh8890TyiiAUd6zhDlN8oStxy8pw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700016)(23010399003)(1800799024)(82310400026)(10067099003)(11063799006)(56012099006)(261022075727099003)(261022105027099003)(261022113327099003)(261021123027099003)(261021121427099003)(261026121527099003)(261026140227099003)(261028144727099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	E0GuyxyZcZ/dOVP3iXkWo7WipaB5ybqWpxdTALvxhxRhXNfuLuerE/N2MBVxU7Q5kqY/JXIJTTAzJEPm5BF5ev51A/OkcvL1eKl5jlyxN8w+34+T570zbQJVEkK57zYCJD9FxhxgTPtlgK/lHAgc8UBtRogwLta30dWivCUVZ72Xwr96dSS9zUfhd8fsygtAiKiYoobrYiv3g0LtlTI1PELaTaKb2XH5vpf1O4L3FcqCzFrpYuP3Vwy11yN/o1M+YR79bj20eF/Yz12eBLRTlnEw4PuFh47wJ0zhUkjj9ZUL5G4JvQW5w4l1yl31UDBpTLhB2ZvU+np/mAYQDiHp2nw7zyGr2ueSD84AGOqxfop8lEpYM2pcC+sE5zA+pFtwHQgzJOzxfnhDxyTR6SRUs8oYfGmuFIBVb2PmZRQWJ5GypU7x+wzjSaZihxvKaZQw
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 14:04:23.5056
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c245fe00-1eb0-4866-e69b-08df4a33d7e3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY6PEPF0000004A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9285

From: Alexandre Courbot <acourbot@nvidia.com>

The vGPU manager sends GMC commands and receives GMC events that
`GmcCommandId` does not list, so they cannot be recognized.

Add them, and make the `gmc` module visible to the rest of the crate so
the vGPU code can implement its commands.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Alok Kumar <alkumar@nvidia.com>
---
 drivers/gpu/nova-core/gsp/cmdq.rs |  2 +-
 drivers/gpu/nova-core/gsp/fw.rs   | 14 ++++++++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gsp/cmdq.rs
index 990edfcd2bc2..0977cba4d122 100644
--- a/drivers/gpu/nova-core/gsp/cmdq.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq.rs
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 // SPDX-FileCopyrightText: Copyright (c) 2025-2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
 
-pub(super) mod gmc;
+pub(crate) mod gmc;
 // No caller sends an RPC command: GSP_INIT and GSP_SUSPEND replaced the RPC commands that the
 // driver used during boot and shutdown. The r000 GSP-RM still accepts RPC commands once it is up,
 // so the RPC send and reply paths stay, and are built as dead code.
diff --git a/drivers/gpu/nova-core/gsp/fw.rs b/drivers/gpu/nova-core/gsp/fw.rs
index 46d3605b24b1..6daabb6aea78 100644
--- a/drivers/gpu/nova-core/gsp/fw.rs
+++ b/drivers/gpu/nova-core/gsp/fw.rs
@@ -720,6 +720,20 @@ pub(crate) enum GmcCommandId with TryFrom<Bounded<u32, 24>> {
         ExecGenericBootloader = bindings::GMCAPI_COMMANDS_GMCAPI_CMD_EXEC_GENERIC_BOOTLOADER,
         ExecHsBinary = bindings::GMCAPI_COMMANDS_GMCAPI_CMD_EXEC_HS_BINARY,
         GspSuspend = bindings::GMCAPI_COMMANDS_GMCAPI_CMD_GSP_SUSPEND,
+        QueryVgpuProperties = bindings::GMCAPI_COMMANDS_GMCAPI_CMD_QUERY_VGPU_PROPERTIES,
+        QueryAssignedVfVgpuType = bindings::GMCAPI_COMMANDS_GMCAPI_CMD_QUERY_ASSIGNED_VF_VGPU_TYPE,
+        BootloadGspVgpuPluginTask =
+            bindings::GMCAPI_COMMANDS_GMCAPI_CMD_BOOTLOAD_GSP_VGPU_PLUGIN_TASK,
+        ShutdownGspVgpuPluginTask =
+            bindings::GMCAPI_COMMANDS_GMCAPI_CMD_SHUTDOWN_GSP_VGPU_PLUGIN_TASK,
+        ShutdownGspVgpuPluginTaskComplete =
+            bindings::GMCAPI_COMMANDS_GMCAPI_CMD_SHUTDOWN_GSP_VGPU_PLUGIN_TASK_COMPLETE,
+        CleanupGspVgpuPluginResources =
+            bindings::GMCAPI_COMMANDS_GMCAPI_CMD_CLEANUP_GSP_VGPU_PLUGIN_RESOURCES,
+        VgpuPluginTriggeredEvent = bindings::GMCAPI_COMMANDS_GMCAPI_CMD_VGPU_PLUGIN_TRIGGERED_EVENT,
+        VgpuMgrScrubGuestFb = bindings::GMCAPI_COMMANDS_GMCAPI_CMD_VGPU_MGR_SCRUB_GUEST_FB,
+        VgpuMgrAllocGspCeutils = bindings::GMCAPI_COMMANDS_GMCAPI_CMD_VGPU_MGR_ALLOC_GSP_CEUTILS,
+        VgpuMgrFreeGspCeutils = bindings::GMCAPI_COMMANDS_GMCAPI_CMD_VGPU_MGR_FREE_GSP_CEUTILS,
         MmuFaultQueued = bindings::GMCAPI_COMMANDS_GMCAPI_CMD_MMU_FAULT_QUEUED,
     }
 }
-- 
2.53.0


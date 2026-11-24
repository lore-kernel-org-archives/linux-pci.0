Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.200.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795529312;
	b=uP6aGfiguk1wQyu4wDWleZrjjQfioVk/qos8C7EbDGOT7uw1lqglNHApYkRZ4Dv0c0W9
	 5ocBGGyag4d0+ld6QWmvK9IkbzqtsVakkEhBtlgs/bm9vuhw3PNlTu+0GXYKBu0XMS5Kz
	 zNFSahKZdTosVwVVkodx4QawO05sFZfVFilyTaSvJ4kPb6L4RgxEEW9JAt8uAfa73KUEw
	 O+wEVq9lVgq2Xc45lB9+UxER6gPQe9N5E20svjLRaFzOJG+MsbQ0qE27HrhZdR6OPGuw7
	 bUVYaDgV10x9RfrVLby/2jv2zHIClq7d99Mc0EaBdipUrrAdH5Wy7HlBGvXJ5TOm9/Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795529312;
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
	bh=xThIdp2HlkqNWpMNLP07j7X60ktCSL68JGjWiKXzQkQ=;
	b=be8yxGu5b+x8QdNUwkRfYiYk4OiqAHG0Zym2M/R1Ht214SNV2UbJhSRcPObThgW2lgE5
	 NwSrHOXAHnm/2c1gummVE76OWVmiTly6mNs88RLrg7TbB48SdlGXC1O6YTLrHJA3vc1A9
	 FHmEQhKU69ECv2jFi66abxC4rnnaOO1Laht+0e01eF/NaaSjT4fQKnMteiwIkH1G+dbm9
	 bo2QQvWiokijGfnzfB/nFss7cne6kyuzTsmwJm1LHpRVIU0swOhuCtVnqDEe+jqCg+QYd
	 PIG5BwZiQWMT+iBU7N9CagRckX/Qdd82B+pYU4hXpm4ACxneNmjwuxZ8wiZnmm0NXqA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="LkwY/UJ8";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.200.51
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012051.outbound.protection.outlook.com [40.107.200.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495CA606D0C1;
	Tue, 24 Nov 2026 14:08:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 495CA606D0C1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=LkwY/UJ8
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I1wZo9RNAsTKHNPu7WXQUhc2+zg1mgcS0jIrupJXhsIb47NJB23a16DYzl//Mp2znFsbwYtWPYV60EeddQODTEP30I/q/SO3DFVLFfikHY6zISx7fm9/ZolmEHUuz3Eu/WnX86fpa2oWkNYahhVs6lJQFd6uFixIdQNShNAhtJg4TJeFC9/+nNnqau4kSavQXy65MDZtL8QJOhrWn7krunnvO3QyPcQ/tvTcN0i9NTUcesKiyILhkK1N9L9SwfL+7QNqrVA3FZkveFIRLmLrGtmbwr95b3H7Hp9uGq0fuPklozoYm1EC2gXlGEA8FftZSEl0wf9FIjI+nC2VJKFQPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xThIdp2HlkqNWpMNLP07j7X60ktCSL68JGjWiKXzQkQ=;
 b=ZI04Obimmmu+F4wUkeFfrDEbkh0FgfmAWyOjcMZaFlCKDHZLonam/k8WQPqbLTfez4frtsobJRj0QX2x1OY5X41RU2n4OK6EH0cdk9gtAgUAc4C/StGR6fYgXal4EJjSvzZivk/s40JEyboKUJL17IhybHClz7/ZgGFpT/XqHwFLM6YQMwmH7rPSR9idiBGqdJcKTLEteJlke3M/nw4buWl8MZtPuoW+KoHYJPg52Iv9ypaKBFpe2+H03DdTohoXA8MIJtmKCg843kM+TMWX02GUexrjnyg698evRQK+AQgoGMcLsD/nk0/Y9sMGWkuQAnVrYfGuGsN3IHV9ujjCQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xThIdp2HlkqNWpMNLP07j7X60ktCSL68JGjWiKXzQkQ=;
 b=LkwY/UJ8dlJmvGem8CW0kdsng166XVyX89ZWgPQjm2rBzxjuIuzD3OWvFxEReiCUgnBUMlkpzR4fJSoX33VGafjeWd7bCYa6l2AvVL7VZFZdk0dN5TLBR+SoOrIbNIfUBu4TULhhmyGhLZx7Aioqkc1+VkyBOERMLOyzPrf5ayiysql+IyL47thN5b+JCW8hyADHSCDHvjEZrcQJpART6d6sTWmG45ylA0NKtpQ8cFXcR7NWCSVPAfn5z6H2oJxWRiNFsy4HTdYdwp+/SE5PAMDG2imBUsz/bhHf7BCycou/0IdJN4Wcw73JxIFIAV79BAwoNjBELGNYWJHEovsPXg==
Received: from BYAPR02CA0036.namprd02.prod.outlook.com (2603:10b6:a03:54::43)
 by SA3PR12MB7997.namprd12.prod.outlook.com (2603:10b6:806:307::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.5; Tue, 24 Nov
 2026 14:06:23 +0000
Received: from BY1PEPF00026957.namprd05.prod.outlook.com
 (2603:10b6:a03:54:cafe::6) by BYAPR02CA0036.outlook.office365.com
 (2603:10b6:a03:54::43) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.6 via Frontend Transport; Tue, 24
 Nov 2026 14:06:23 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BY1PEPF00026957.mail.protection.outlook.com (10.167.244.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Tue, 24 Nov 2026 14:06:23 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 24 Nov
 2026 06:06:02 -0800
Received: from kalok-SPC741D16QM3.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 06:05:49 -0800
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
Subject: [PATCH v5 27/35] gpu: nova-core: vgpu: add instance shutdown
Date: Tue, 24 Nov 2026 19:29:23 +0530
Message-ID: <20261124135937.18583-28-alkumar@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF00026957:EE_|SA3PR12MB7997:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c82901e-a431-4865-04cb-08df4a341f35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700016|23010399003|1800799024|82310400026|10067099003|5023799004|11063799006|56012099006|261022105027099003|261021135927099003|261021123027099003|261021121427099003|261026121527099003|261026140227099003|261028144727099003|261102123227099003|261009223027099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	pBUB65M8JPeq76pER9M8riyrWb3mVbdduIWFPbjlsTxzOj7XQFmImSsVyIWLfTVVcxYGgc1BiFh8cJYBl1c+yIAGqmjRxnPCZ7NDf+M6M/wiDvaIS4pLzKeRNRA3FglHm/nA0l3ILBVwojlDaNfxyQ3/owI2xgpsou7tb3RPNB1sZjk1K7FmDku2WNI+SNgLLj0BM3VjUb3rVmhfLLqfXt8t4ytt1miwVDJLQXFIjXBPfWZQyk8zArP2S0fx5fGyRQOZ39CFguIz61jXfKnK76s8gVyzqX8rCW/n2W+BN6d1mpZ27WsfMtyx0gJsH63TC/ZJgqdGTR10YwBOAc6txRgLVuyYw3Y3XHCkHuaqGvpd3SVWUxIjTu0wvMT9w1ctogI5rdA68LVn6+bLjulipp2B6yjwSwCZ6hDxHb9vvw3WTqamxi8yu9tHIxeE8Cr7miZoJOD5x22yeop7zr+V7ftHA405HBrVBYXhnsAL+ZUB3JWC0WfivSSTBWYBMvi6BP5Q3Cr0nnXeGW+p04OyoVmebEEbT4YhahS4ees4TVL8uBSH95R97m7EXZH6hOKNDOCU+lBMmcjyQkES8X5Pgsjkp5aSK0V4Hmn44zPlK3Z57GoEawHletV3sChyID9TAtWm/wsHDH17Qcl5zwCjE9Dz6DIMjNb37/MLiPqxG3i4mV937PVGJtdyWl1RPj/+JpSlmLw0E7uYJaI+o7MorQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700016)(23010399003)(1800799024)(82310400026)(10067099003)(5023799004)(11063799006)(56012099006)(261022105027099003)(261021135927099003)(261021123027099003)(261021121427099003)(261026121527099003)(261026140227099003)(261028144727099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	wc407w/jSqo5QUF6vZuPGgCbvFuzTt79lzZw0mvfMUOOHH6SZjASBe+eXv+xXXNiZiRSOelcaVZjeqM6Il2Vbni0UzrZAtjBtYOakWbs2aBbqsrhW9fZiELbZVAf7eSFpzyOEZ6fKdptMjVhBBwcA9/yChU7ykiqulxe+V7owtaekC3QgVLz7cd5Xi7TUmmlBEVPgQpOuGrgl6WokFoalhRinZ5BUEGd5fbjRPCr9+xVSXzkZxSaXuwY2zgTea7o3+NgO6WFyccBLmDATmDP2UUE90l9VRJ7qS9CWwitMKDLqpxCrXkkoSOckIwal5mowqhPYi/oS7BNlc5jbIlIkxR9/bpAZCRc51O8+rOGDBR7FBLyMb9WvRfisCJJy4o5xs2FM8KPzm98xkQmN9q53vXGqvjF4+596PXCD/rbbhnTiMw0vklLLZhNlgDqpbn8
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 14:06:23.1978
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c82901e-a431-4865-04cb-08df4a341f35
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF00026957.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7997

From: Zhi Wang <zhiw@nvidia.com>

Stop the GSP plugin, wait for SHUTDOWN completion, and release its
firmware resources with CLEANUP before unmapping the communication
buffers.

Signed-off-by: Zhi Wang <zhiw@nvidia.com>
Co-developed-by: Alok Kumar <alkumar@nvidia.com>
Signed-off-by: Alok Kumar <alkumar@nvidia.com>
Co-developed-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/gsp/cmdq/gmc.rs         |  1 -
 drivers/gpu/nova-core/vgpu.rs                 |  9 ++-
 drivers/gpu/nova-core/vgpu/commands.rs        | 66 +++++++++++++++
 drivers/gpu/nova-core/vgpu/gsp_plugin_comm.rs |  1 -
 drivers/gpu/nova-core/vgpu/instance.rs        | 81 ++++++++++++++++++-
 5 files changed, 151 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/cmdq/gmc.rs b/drivers/gpu/nova-core/gsp/cmdq/gmc.rs
index d4017c2e04ce..b4e956a2ed50 100644
--- a/drivers/gpu/nova-core/gsp/cmdq/gmc.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq/gmc.rs
@@ -367,7 +367,6 @@ pub(crate) fn send_gmc_command<C>(
     ///   framing validation.
     ///
     /// Error codes returned by the command initializer and by `on_event` are propagated as-is.
-    #[expect(dead_code)]
     pub(crate) fn send_gmc_command_await_event<C, R>(
         &self,
         command: C,
diff --git a/drivers/gpu/nova-core/vgpu.rs b/drivers/gpu/nova-core/vgpu.rs
index e1dbd46338a6..fbaaf8e1d6fa 100644
--- a/drivers/gpu/nova-core/vgpu.rs
+++ b/drivers/gpu/nova-core/vgpu.rs
@@ -132,7 +132,7 @@ pub(crate) struct VgpuManager<'gpu>
 ///
 /// The instances kept in the registry borrow the GPU resources below, which makes this type
 /// invariant over `'gpu`.
-#[pin_data]
+#[pin_data(PinnedDrop)]
 struct VgpuManagerInner<'gpu> {
     #[pin]
     instances: Mutex<VgpuInstances<'gpu>>,
@@ -175,3 +175,10 @@ pub(crate) fn new(
         })
     }
 }
+
+#[pinned_drop]
+impl PinnedDrop for VgpuManagerInner<'_> {
+    fn drop(self: Pin<&mut Self>) {
+        self.instances.lock().release_all(&self);
+    }
+}
diff --git a/drivers/gpu/nova-core/vgpu/commands.rs b/drivers/gpu/nova-core/vgpu/commands.rs
index b384c190a66a..d0fd7ab2593b 100644
--- a/drivers/gpu/nova-core/vgpu/commands.rs
+++ b/drivers/gpu/nova-core/vgpu/commands.rs
@@ -25,6 +25,7 @@
                 MessagePayload, //
             },
             Cmdq,
+            NoReply, //
         },
         nvkv::{
             nvkv_words,
@@ -35,12 +36,14 @@
         GmcCommandId,
         GSP_PAGE_SIZE, //
     },
+    sbuffer::SBufferIter,
     vgpu::{
         fw::commands::{
             AssignedVfVgpuType,
             VgpuProperties,
             VgpuPropertiesSchema, //
         },
+        instance::Gfid,
         Dbdf,
     },
 };
@@ -157,3 +160,66 @@ pub(super) fn send_bootload(_dev: &device::Device, cmdq: &Cmdq<'_>, payload: &[u
     cmdq.send_gmc_command(BootloadPluginTask(payload), |_| Ok(()))?
         .map_err(|_| EIO)
 }
+
+/// The `SHUTDOWN_GSP_VGPU_PLUGIN_TASK` command.
+///
+/// The GSP does not answer it, and sends a `SHUTDOWN_GSP_VGPU_PLUGIN_TASK_COMPLETE` event carrying
+/// the same GFID once the task has stopped.
+struct ShutdownPluginTask(Gfid);
+
+impl CommandToGsp for ShutdownPluginTask {
+    const COMMAND: GmcCommandId = GmcCommandId::ShutdownGspVgpuPluginTask;
+    type Command = u32;
+    type Reply = NoReply;
+    const MAX_REPLY_SIZE: u32 = 0;
+    const COMPLETION_TIMEOUT: Delta = Delta::from_secs(10);
+    type InitError = Infallible;
+
+    fn init(&self) -> impl Init<Self::Command, Self::InitError> {
+        u32::from(self.0.get()).to_le()
+    }
+}
+
+/// The `CLEANUP_GSP_VGPU_PLUGIN_RESOURCES` command.
+struct CleanupPluginResources(Gfid);
+
+impl CommandToGsp for CleanupPluginResources {
+    const COMMAND: GmcCommandId = GmcCommandId::CleanupGspVgpuPluginResources;
+    type Command = u32;
+    type Reply = ();
+    const MAX_REPLY_SIZE: u32 = 0;
+    type InitError = Infallible;
+
+    fn init(&self) -> impl Init<Self::Command, Self::InitError> {
+        u32::from(self.0.get()).to_le()
+    }
+}
+
+/// Shut down a vGPU plugin task and wait for its completion event.
+pub(super) fn send_shutdown(dev: &device::Device, cmdq: &Cmdq<'_>, gfid: Gfid) -> Result {
+    cmdq.send_gmc_command_await_event(ShutdownPluginTask(gfid), |event| {
+        let command = event.header().command();
+        if !matches!(
+            command.id(),
+            Ok(GmcCommandId::ShutdownGspVgpuPluginTaskComplete)
+        ) {
+            dev_dbg!(dev, "shutdown: ignoring GMC event {:?}\n", command);
+            return Ok(None);
+        }
+
+        let (payload_0, payload_1) = event.payload();
+        let mut event_gfid = [0u8; size_of::<u32>()];
+        SBufferIter::new_reader([payload_0, payload_1]).read_exact(&mut event_gfid)?;
+
+        Ok((u32::from_le_bytes(event_gfid) == u32::from(gfid.get())).then_some(()))
+    })
+}
+
+/// Release firmware resources after a plugin task has stopped.
+pub(super) fn send_cleanup(dev: &device::Device, cmdq: &Cmdq<'_>, gfid: Gfid) -> Result {
+    cmdq.send_gmc_command(CleanupPluginResources(gfid), |_| Ok(()))?
+        .map_err(|_| EIO)?;
+
+    dev_dbg!(dev, "cleanup: gfid={} done\n", gfid.get());
+    Ok(())
+}
diff --git a/drivers/gpu/nova-core/vgpu/gsp_plugin_comm.rs b/drivers/gpu/nova-core/vgpu/gsp_plugin_comm.rs
index 310230702562..e4ce82c6b2d7 100644
--- a/drivers/gpu/nova-core/vgpu/gsp_plugin_comm.rs
+++ b/drivers/gpu/nova-core/vgpu/gsp_plugin_comm.rs
@@ -206,7 +206,6 @@ pub(super) fn initialize(&self) -> Result {
     }
 
     /// Invalidate the PTEs and release the communication mapping.
-    #[expect(dead_code)]
     pub(super) fn unmap(&mut self) -> Result {
         self.map.unmap()
     }
diff --git a/drivers/gpu/nova-core/vgpu/instance.rs b/drivers/gpu/nova-core/vgpu/instance.rs
index 6df3d9ec8dde..2d045ebcd9cd 100644
--- a/drivers/gpu/nova-core/vgpu/instance.rs
+++ b/drivers/gpu/nova-core/vgpu/instance.rs
@@ -30,7 +30,11 @@
 };
 
 use super::{
-    commands::send_bootload,
+    commands::{
+        send_bootload,
+        send_cleanup,
+        send_shutdown, //
+    },
     fw::commands::{
         encode_vgpu_bootload,
         BootloadInfo,
@@ -147,10 +151,12 @@ struct VgpuInstance<'gpu> {
     // Unmap the communication region before returning its slot and channel IDs.
     vram_slot: VgpuVramSlot,
     chids: ChannelIdReservation<'gpu>,
+    needs_teardown: bool,
+    /// An uncertain or failed operation retains resources until device removal.
+    failure: Option<Error>,
 }
 
 impl<'gpu> VgpuInstance<'gpu> {
-    #[expect(dead_code)]
     fn activate(&mut self, vgpu: &VgpuManagerInner<'gpu>) -> Result {
         let dev = vgpu.dev;
         self.bootload(dev, vgpu.cmdq, &vgpu.fifo_engine_list)?;
@@ -158,6 +164,26 @@ fn activate(&mut self, vgpu: &VgpuManagerInner<'gpu>) -> Result {
         Ok(())
     }
 
+    /// Tear down once, retaining all remaining resources if an operation fails.
+    fn teardown(&mut self, vgpu: &VgpuManagerInner<'gpu>) -> Result {
+        if let Some(error) = self.failure {
+            return Err(error);
+        }
+        let result = (|| {
+            self.shutdown(vgpu.dev, vgpu.cmdq)?;
+
+            if self.needs_teardown {
+                send_cleanup(vgpu.dev, vgpu.cmdq, self.gfid)?;
+                self.needs_teardown = false;
+            }
+            self.comm.unmap()
+        })();
+        if let Err(error) = result {
+            self.failure = Some(error);
+        }
+        result
+    }
+
     /// Bootload the GSP vGPU plugin and wait for its BAR1 ready indication.
     fn bootload(
         &mut self,
@@ -196,6 +222,7 @@ fn bootload(
         );
 
         self.comm.clear_plugin_ready()?;
+        self.needs_teardown = true;
         send_bootload(dev, cmdq, &payload)?;
 
         wait_plugin_ready(dev, &self.comm)?;
@@ -203,6 +230,15 @@ fn bootload(
         dev_dbg!(dev, "bootload: gfid={} plugin ready\n", self.gfid.get());
         Ok(())
     }
+
+    /// Stop the plugin when firmware may own instance resources.
+    fn shutdown(&mut self, dev: &device::Device, cmdq: &Cmdq<'_>) -> Result {
+        if self.needs_teardown {
+            send_shutdown(dev, cmdq, self.gfid)?;
+            dev_dbg!(dev, "shutdown: gfid={} stopped\n", self.gfid.get());
+        }
+        Ok(())
+    }
 }
 
 /// Identity and firmware profile used to allocate an instance.
@@ -324,20 +360,44 @@ fn allocate_instance(
             comm,
             vram_slot,
             chids,
+            needs_teardown: false,
+            failure: None,
         })
     }
 
-    /// Remove an instance and release its channel and VRAM reservations.
-    fn destroy_instance(&mut self, gfid: Gfid) -> Result {
+    /// Remove an instance only after firmware and mapping teardown have succeeded.
+    fn destroy_instance(&mut self, vgpu: &VgpuManagerInner<'gpu>, gfid: Gfid) -> Result {
         let instance_index = self
             .instances
             .iter()
             .position(|instance| instance.gfid == gfid)
             .ok_or(ENOENT)?;
+        let instance = self.instances.get_mut(instance_index).ok_or(EIO)?;
+        instance.teardown(vgpu)?;
+
         let instance = self.instances.remove(instance_index).map_err(|_| EIO)?;
         drop(instance);
         Ok(())
     }
+
+    /// Release the registry while the manager's MM and firmware dependencies remain available.
+    pub(super) fn release_all(&mut self, vgpu: &VgpuManagerInner<'gpu>) {
+        for instance in &mut self.instances {
+            // Failed operations retain their resources until this final device removal.
+            // Do not resubmit commands whose firmware outcome was uncertain.
+            if instance.failure.is_none() {
+                if let Err(error) = instance.teardown(vgpu) {
+                    dev_err!(
+                        vgpu.dev,
+                        "vGPU teardown failed for gfid={}: {:?}\n",
+                        instance.gfid.get(),
+                        error,
+                    );
+                }
+            }
+        }
+        self.instances.clear();
+    }
 }
 
 impl VgpuManagerInner<'_> {
@@ -356,6 +416,19 @@ fn create_instance(&self, info: InstanceInfo) -> Result {
         let mut instance = instances.allocate_instance(self, info)?;
         let result = instance.activate(self);
 
+        if result.is_err() {
+            match instance.teardown(self) {
+                // Firmware owns nothing anymore; drop the instance to release its resources.
+                Ok(()) => return result,
+                Err(error) => dev_err!(
+                    self.dev,
+                    "vGPU creation could not release gfid={}: {:?}; resources retained\n",
+                    instance.gfid.get(),
+                    error,
+                ),
+            }
+        }
+
         // Register live instances, and failed ones whose resources firmware may still own.
         instances
             .instances
-- 
2.53.0


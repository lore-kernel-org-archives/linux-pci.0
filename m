Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.5
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793943990;
	b=SRaElRx8IUmz/ffA9PK7oydqC4x/+/k0YxI9tTzhj33TDL0rISNvkMSkOk7CAw+cEWmu
	 tUoidge5xMer6kJ1OnFI0QbOcngVLpppbc3LP2AVf9kVKrJdecun57D6Zjz05W4fy63nR
	 ZW9uw9Dhja62BAsw8TnovKCkA1wbSZ8VZwOa0+ZcJ4cjFGF2V5Zus7L/LxNILzQRb/JFH
	 ntqWmAN8avMdDyzLffgPYAS2AUY+pJ6rcCqKSqNXJZhRMp0vF+p8drVK0BKFp4/GumIOA
	 b0Lu4eOjGBfQAlEllmRQM0Qqm/xxrZennAt4mODreewMgCjnZEulbIx4/mfzo/VMARQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793943990;
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
	bh=p05P81KRoGY5eh4F8ULUN9R6ypc1slLAnjhLoXi8zXo=;
	b=1Eqe1KLq4uD6WkQ6siYLiUZvqXVtU3Y2TjXiy7GRjN2S+fACB+0LQoGS9pJCiiCbSRO4
	 9cFKHnLCFnr0C1eflAk3dg7D79kR9Th2QAWJNS4WBkgblvQ+etS+v/GibuhlP06bBoUV0
	 L30PnABxjMtByzbifENZVsG5ln03L3wThG5acbD6I1f7UN42k2D/wWZn+fCRGSmbu6QVb
	 6mSNK4ksU0+kqJoASRzzdrgwRFe4kngsD7aJBq4haGJhbWbe/rnkSs9XTPDAGhvwO2AD2
	 9fq94oAvKjWi5iyOU43zgoKb3YNYF7eax2WPUOEo3/RkLphBjtZ23DviM+vGN1EP9DA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=b6miyil4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.5
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010005.outbound.protection.outlook.com [52.101.46.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3BD606A328;
	Fri,  6 Nov 2026 05:46:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1A3BD606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=b6miyil4
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gpgctFLZeWQvNNu50on4ozGD7ajU0oeECWpHmbrI/Nd+68nrhEH3het2rPqilNfauYbWrohjjfuywMrFrNpZ4HvCj1avRmmLPaC1t45HSaoggThnHM1Yc4856t7Y1FklUEPD1YMoqsUi1896bBPFmF4Y1Bdlj3X3P+ox5xqPVElN/QhbHIhExClqpnw2ym/8ttU6xyMT6/WDyT1imGM0sSDK5n0FZMTnmteGT214iF5TtbKmLgl1gWP14O3TZBfOu7drvbwMuSBi/eAfK8xK2ayUIHxPL1pi75OXf2TFhVDZZiGyynriGZuj4VKPZ2oNZfBoXwSgfxCvTVnRDLZ/KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p05P81KRoGY5eh4F8ULUN9R6ypc1slLAnjhLoXi8zXo=;
 b=EPxVgmVfG8rcFGALbFbsAxp7txHTfyJ4IqYmYfo2rzBDTjx+yfNLGqnfdaLQP8inp/aHtkeUo4B+CtHCEdDszxX5wv5vq2L4n23di41io01P/r8yKTvuszYVxjwQSbqyeItemoxZ9ZaKsXnEzrK2paZsx4b2T9pk/mwGIhMhyx4F7pYl8Hoy8WAXi9PmRnAoM7QLEqCaNQUXKX9Wxx6jHvamG2RankcS22+IXxvVucaTxEXX+QUw3LukkYzwK/DOC9Q/7lt/VX2zpA0A7H0EZQ25YBKC5wpknTPcdfgKQ+pLYX+6z4mkkr62aUgLQdrBtzIgKFdUziNzBAclLlDttA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p05P81KRoGY5eh4F8ULUN9R6ypc1slLAnjhLoXi8zXo=;
 b=b6miyil4doDd7PxeD8PfQAXmBGl3VRfRlM7RtsWtq5r8vH0WBzDZhPH0GnqYvTwwn4nlTCxSmdSco87R8obfBBDEvi3cIhAM840HrMhSgLdcDsy7K96gCW9TBzOGBNmRfArzE1wQZ4BZs22RYz4sv1huqnH8pvf3nJ6mniqTwTpV5KbmohRn+dym7HyW8SgIFO+agNrtUmId58rVe+VgA+NWA2NQokyXCZ2pLyPH70AGTbtG9FQu53Q5JDOk/T+B0HhtjL3w1P8HipgiCePgnmRqcp+FM88LivviKsIgBcGqnGt7zi8LBGHkx0eUd21booNHgi5Jjka/6cKtbwP7sQ==
Received: from PH1PEPF00013306.namprd07.prod.outlook.com (2603:10b6:518:1::13)
 by DM6PR12MB4266.namprd12.prod.outlook.com (2603:10b6:5:21a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 05:46:21 +0000
Received: from PH7PEPF0000000B.namprd04.prod.outlook.com
 (2a01:111:f403:c95d::5) by PH1PEPF00013306.outlook.office365.com
 (2603:1036:903:47::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Fri, 6
 Nov 2026 05:46:21 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 PH7PEPF0000000B.mail.protection.outlook.com (10.167.243.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 05:46:21 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 5 Nov
 2026 21:46:02 -0800
Received: from kalok-SPC741D16QM3.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 21:45:50 -0800
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
Subject: [PATCH v4 23/32] gpu: nova-core: vgpu: add instance shutdown
Date: Fri, 6 Nov 2026 11:09:56 +0530
Message-ID: <33da25f031dd9a32cc52bafd3d44b69b250d4cfd.1793906667.git.alkumar@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: PH7PEPF0000000B:EE_|DM6PR12MB4266:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e345971-5f99-4056-f967-08df3bc94936
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|36860700016|82310400026|261102123227099003|11063799006|56012099006|261021121427099003|261021123027099003|261021135927099003|261026140227099003|261028144727099003|261022105027099003|261026121527099003|261009223027099003|18002099003|22082099003|10067099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	dVEsX5IuJpgWVusnKnbePnPmqmFpsUSVoQcT26wm8mlFAD8VHbYlmfPoOGvBq5+81xlqcteG9Mjlts/BFbfqmpF1XKWxeOgoQvK8DTvG3MvdWE5jh/jDxvPUAEl+bEAfNXhZTk2sC0dPurbrEPyu94s9DJBn/JOBjks1404+kklxRv63kooSKnAeRrJlELf6kyY8drMNGpe5yE6moIN2uRWNe2LBky3OOWMKtz+5gsF53cgvwYMk9xMC6dfSeN0sazaj18yF37Ok82gcxlz6Uf+s96CbJ023/R+4z/jN3cICvCBsA6bq0WGx0Z/JAtwSaTyecikoIPKmBWYDn4SJzDs2Spx9ICucomTpzrb1Mp8uAFA361jdWGSlV+BLmXcWTtP9/5PC9j8Oh5e7AklOL1begAfdyD/MGmTNr0icl1Bz5u36Zn0UJIiApdV7wXNNPQavontLod77+bNCYSkkPvRolHiSDybfpOmLi4H9D9WlRPqTxtxtvRJ3Aq1i8CRkPpXXFbCYDkVQnqGAnfa2Vq5tb1vBZIIUlkBySWlwlW1VqLr0BYQBKlcC0iWShAMgOR9T3ZB+Jm+SlC3V/oKuScHmlw5VKlmidGGEQsX70jMZCXBWtU3bKwvd1oxxOhNmxGre3TqGmGROETNvclK+pyZM2Mu/P1Udl+KzFQFbct0bOYOl4ixmY5qBCLhSbFrT3TjZ6qj25AyZ8CiQ+LEe5A==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(36860700016)(82310400026)(261102123227099003)(11063799006)(56012099006)(261021121427099003)(261021123027099003)(261021135927099003)(261026140227099003)(261028144727099003)(261022105027099003)(261026121527099003)(261009223027099003)(18002099003)(22082099003)(10067099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	gAeaQq+lJvXh49lm9J180aE1KfOEQ7wiDlkVkjiXRT2vA8nwglqeHqeiKZybXckZ/O6F5aBsXpZnBN64DtFAfImQie382oUUSSRyJQfp9O8TejerU0rXF81d3F7vOXPlFp1x/lGwPTmdZMntxXRqNZdRFav+mPAS7vQhgvKnJdpBYN8lxjfyCNJOm13uUzjOGP86vNOCTDppUdFlDIGbA7yLLYjZ+h4V92+/1Sj0Mf13yv0MZ01hqR7Sb5DxIVWmBpfODmQfpykm0lfyg2BeWKAsHYXWiynlNoBrv4b2jS5TFP8XqtMMEnRHWhOujCdqZ2yBr99++ILwy9XjyFjpjndxUnsbvvBEmjr8oSmhDBwAoeDzQVuZFMqYkyse4HbdhVM8Ax+Vi15K7QQSeWYVH/0QIywQbyOHxYr3FAa8ilPPE6+1VnJur6apFABEu8Py
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 05:46:21.2133
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e345971-5f99-4056-f967-08df3bc94936
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	PH7PEPF0000000B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4266

From: Zhi Wang <zhiw@nvidia.com>

Stop the GSP plugin, wait for SHUTDOWN completion, and release its
firmware resources with CLEANUP before unmapping the communication
buffers.

Add PendingInstance rollback and manager teardown. Register host resources
before firmware work, and retain them until device removal if firmware
state is uncertain or teardown fails. Keep the manager's dependencies
alive until cleanup finishes.

Signed-off-by: Zhi Wang <zhiw@nvidia.com>
Co-developed-by: Alok Kumar <alkumar@nvidia.com>
Signed-off-by: Alok Kumar <alkumar@nvidia.com>
---
 drivers/gpu/nova-core/gsp/cmdq/gmc.rs         |   1 -
 drivers/gpu/nova-core/vgpu.rs                 |   9 +-
 drivers/gpu/nova-core/vgpu/commands.rs        |  55 +++++++-
 drivers/gpu/nova-core/vgpu/fw.rs              |   9 ++
 drivers/gpu/nova-core/vgpu/gsp_plugin_comm.rs |   1 -
 drivers/gpu/nova-core/vgpu/instance.rs        | 118 +++++++++++++++++-
 6 files changed, 182 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/cmdq/gmc.rs b/drivers/gpu/nova-core/gsp/cmdq/gmc.rs
index d41d5e533cf7..3bceb080f9a9 100644
--- a/drivers/gpu/nova-core/gsp/cmdq/gmc.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq/gmc.rs
@@ -469,7 +469,6 @@ pub(crate) fn send_gmc_and_receive_timeout(
     ///
     /// Errors from initializing the request headers and from either callback are propagated
     /// as-is. The current valid element is consumed before a callback error is returned.
-    #[expect(dead_code)]
     pub(crate) fn send_gmc_and_wait_event(
         &self,
         command_id: u32,
diff --git a/drivers/gpu/nova-core/vgpu.rs b/drivers/gpu/nova-core/vgpu.rs
index 84c4d0b3839d..f7184e7009a5 100644
--- a/drivers/gpu/nova-core/vgpu.rs
+++ b/drivers/gpu/nova-core/vgpu.rs
@@ -105,7 +105,7 @@ fn query_state(
 use self::instance::VgpuInstances;
 
 /// Runtime resources for an enabled vGPU boot.
-#[pin_data]
+#[pin_data(PinnedDrop)]
 pub(crate) struct VgpuManager<'gpu> {
     #[pin]
     instances: Mutex<VgpuInstances<'gpu>>,
@@ -146,3 +146,10 @@ pub(crate) fn new(
         })
     }
 }
+
+#[pinned_drop]
+impl PinnedDrop for VgpuManager<'_> {
+    fn drop(self: Pin<&mut Self>) {
+        self.instances.lock().release_all(&self);
+    }
+}
diff --git a/drivers/gpu/nova-core/vgpu/commands.rs b/drivers/gpu/nova-core/vgpu/commands.rs
index 6207211d7f9d..00da8fa4f910 100644
--- a/drivers/gpu/nova-core/vgpu/commands.rs
+++ b/drivers/gpu/nova-core/vgpu/commands.rs
@@ -29,9 +29,13 @@
             VgpuPropertiesSchema, //
         },
         GMCAPI_CMD_BOOTLOAD_GSP_VGPU_PLUGIN_TASK,
+        GMCAPI_CMD_CLEANUP_GSP_VGPU_PLUGIN_RESOURCES,
         GMCAPI_CMD_QUERY_ASSIGNED_VF_VGPU_TYPE,
-        GMCAPI_CMD_QUERY_VGPU_PROPERTIES, //
-    }, //
+        GMCAPI_CMD_QUERY_VGPU_PROPERTIES,
+        GMCAPI_CMD_SHUTDOWN_GSP_VGPU_PLUGIN_TASK,
+        GMCAPI_CMD_SHUTDOWN_GSP_VGPU_PLUGIN_TASK_COMPLETE, //
+    },
+    instance::Gfid, //
 };
 
 pub(super) use super::fw::commands::{
@@ -109,3 +113,50 @@ pub(super) fn send_bootload(
     )?;
     check_status(dev, command_id, response.status)
 }
+
+/// Shut down a vGPU plugin task and wait for its completion event.
+pub(super) fn send_shutdown(
+    dev: &device::Device<device::Bound>,
+    cmdq: &Cmdq<'_>,
+    gfid: Gfid,
+) -> Result {
+    let payload = u32::from(gfid.get()).to_le_bytes();
+    cmdq.send_gmc_and_wait_event(
+        GMCAPI_CMD_SHUTDOWN_GSP_VGPU_PLUGIN_TASK,
+        &payload,
+        Delta::from_secs(10),
+        |command_id, _max_response_size, _sequence, payload_0, payload_1| {
+            Ok(
+                command_id == GMCAPI_CMD_SHUTDOWN_GSP_VGPU_PLUGIN_TASK_COMPLETE
+                    && payload
+                        .iter()
+                        .copied()
+                        .eq(Iterator::chain(payload_0.iter(), payload_1)
+                            .take(payload.len())
+                            .copied()),
+            )
+        },
+        |command_id, _max_response_size, _sequence, _payload_0, _payload_1| {
+            dev_dbg!(
+                dev,
+                "shutdown: ignoring unrelated event command={:#x}\n",
+                command_id,
+            );
+            Ok(())
+        },
+    )
+}
+
+/// Release firmware resources after a plugin task has stopped.
+pub(super) fn send_cleanup(
+    dev: &device::Device<device::Bound>,
+    cmdq: &Cmdq<'_>,
+    gfid: Gfid,
+) -> Result {
+    let command_id = GMCAPI_CMD_CLEANUP_GSP_VGPU_PLUGIN_RESOURCES;
+    let response =
+        cmdq.send_gmc_and_receive(command_id, &u32::from(gfid.get()).to_le_bytes(), 0)?;
+    check_status(dev, command_id, response.status)?;
+    dev_dbg!(dev, "cleanup: gfid={} done\n", gfid.get());
+    Ok(())
+}
diff --git a/drivers/gpu/nova-core/vgpu/fw.rs b/drivers/gpu/nova-core/vgpu/fw.rs
index 82c29dfb467a..1528cc56ce74 100644
--- a/drivers/gpu/nova-core/vgpu/fw.rs
+++ b/drivers/gpu/nova-core/vgpu/fw.rs
@@ -33,3 +33,12 @@
 
 pub(super) const GMCAPI_CMD_BOOTLOAD_GSP_VGPU_PLUGIN_TASK: u32 =
     bindings::GMCAPI_COMMANDS_GMCAPI_CMD_BOOTLOAD_GSP_VGPU_PLUGIN_TASK;
+
+pub(super) const GMCAPI_CMD_SHUTDOWN_GSP_VGPU_PLUGIN_TASK: u32 =
+    bindings::GMCAPI_COMMANDS_GMCAPI_CMD_SHUTDOWN_GSP_VGPU_PLUGIN_TASK;
+
+pub(super) const GMCAPI_CMD_SHUTDOWN_GSP_VGPU_PLUGIN_TASK_COMPLETE: u32 =
+    bindings::GMCAPI_COMMANDS_GMCAPI_CMD_SHUTDOWN_GSP_VGPU_PLUGIN_TASK_COMPLETE;
+
+pub(super) const GMCAPI_CMD_CLEANUP_GSP_VGPU_PLUGIN_RESOURCES: u32 =
+    bindings::GMCAPI_COMMANDS_GMCAPI_CMD_CLEANUP_GSP_VGPU_PLUGIN_RESOURCES;
diff --git a/drivers/gpu/nova-core/vgpu/gsp_plugin_comm.rs b/drivers/gpu/nova-core/vgpu/gsp_plugin_comm.rs
index 0b4d03c5f0fc..a00f4d2affc7 100644
--- a/drivers/gpu/nova-core/vgpu/gsp_plugin_comm.rs
+++ b/drivers/gpu/nova-core/vgpu/gsp_plugin_comm.rs
@@ -210,7 +210,6 @@ pub(super) fn is_plugin_ready(&self) -> Result<bool> {
     }
 
     /// Invalidate the PTEs and release the communication mapping.
-    #[expect(dead_code)]
     pub(super) fn unmap(&mut self) -> Result {
         self.map.unmap()
     }
diff --git a/drivers/gpu/nova-core/vgpu/instance.rs b/drivers/gpu/nova-core/vgpu/instance.rs
index b2a0b25c0e15..bf02595590e1 100644
--- a/drivers/gpu/nova-core/vgpu/instance.rs
+++ b/drivers/gpu/nova-core/vgpu/instance.rs
@@ -31,6 +31,8 @@
 use super::{
     commands::{
         send_bootload,
+        send_cleanup,
+        send_shutdown,
         Dbdf, //
     },
     fw::commands::{
@@ -143,10 +145,12 @@ struct VgpuInstance<'gpu> {
     // Unmap the communication region before returning its slot and channel IDs.
     vram_slot: VgpuVramSlot,
     chids: ChannelIdReservation<'gpu>,
+    needs_teardown: bool,
+    /// An uncertain or failed operation retains resources until device removal.
+    failure: Option<Error>,
 }
 
 impl<'gpu> VgpuInstance<'gpu> {
-    #[expect(dead_code)]
     fn activate(&mut self, vgpu: &VgpuManager<'gpu>) -> Result {
         let dev = vgpu.dev;
         self.bootload(dev, vgpu.cmdq, &vgpu.fifo_engine_list)?;
@@ -154,6 +158,26 @@ fn activate(&mut self, vgpu: &VgpuManager<'gpu>) -> Result {
         Ok(())
     }
 
+    /// Tear down once, retaining all remaining resources if an operation fails.
+    fn teardown(&mut self, vgpu: &VgpuManager<'gpu>) -> Result {
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
@@ -192,6 +216,7 @@ fn bootload(
         );
 
         self.comm.clear_plugin_ready()?;
+        self.needs_teardown = true;
         send_bootload(dev, cmdq, &payload)?;
 
         wait_plugin_ready(dev, &self.comm)?;
@@ -199,6 +224,15 @@ fn bootload(
         dev_dbg!(dev, "bootload: gfid={} plugin ready\n", self.gfid.get());
         Ok(())
     }
+
+    /// Stop the plugin when firmware may own instance resources.
+    fn shutdown(&mut self, dev: &device::Device<device::Bound>, cmdq: &Cmdq<'_>) -> Result {
+        if self.needs_teardown {
+            send_shutdown(dev, cmdq, self.gfid)?;
+            dev_dbg!(dev, "shutdown: gfid={} stopped\n", self.gfid.get());
+        }
+        Ok(())
+    }
 }
 
 /// Identity and firmware profile used to allocate an instance.
@@ -255,8 +289,12 @@ fn alloc_vram_slot(&mut self, mm: &GpuMm<'_>, layout: VgpuVramLayout) -> Result<
         Ok(slot)
     }
 
-    /// Allocate resources and register a new inactive vGPU instance.
-    fn allocate_instance(&mut self, vgpu: &VgpuManager<'gpu>, info: InstanceInfo) -> Result<Gfid> {
+    /// Register host resources before submitting any firmware work.
+    fn allocate_instance<'a>(
+        &'a mut self,
+        vgpu: &'a VgpuManager<'gpu>,
+        info: InstanceInfo,
+    ) -> Result<PendingInstance<'a, 'gpu>> {
         let InstanceInfo {
             gfid,
             dbdf,
@@ -316,23 +354,91 @@ fn allocate_instance(&mut self, vgpu: &VgpuManager<'gpu>, info: InstanceInfo) ->
             comm,
             vram_slot,
             chids,
+            needs_teardown: false,
+            failure: None,
         };
         self.instances
             .push_within_capacity(instance)
             .map_err(|_| EIO)?;
 
-        Ok(gfid)
+        Ok(PendingInstance {
+            instances: self,
+            vgpu,
+            gfid,
+            committed: false,
+        })
     }
 
-    /// Remove an instance and release its channel and VRAM reservations.
-    fn destroy_instance(&mut self, gfid: Gfid) -> Result {
+    /// Remove an instance only after firmware and mapping teardown have succeeded.
+    fn destroy_instance(&mut self, vgpu: &VgpuManager<'gpu>, gfid: Gfid) -> Result {
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
+    pub(super) fn release_all(&mut self, vgpu: &VgpuManager<'gpu>) {
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
+}
+
+/// Rolls back this creation attempt unless ownership has passed to the caller.
+struct PendingInstance<'a, 'gpu> {
+    instances: &'a mut VgpuInstances<'gpu>,
+    vgpu: &'a VgpuManager<'gpu>,
+    gfid: Gfid,
+    committed: bool,
+}
+
+#[expect(dead_code)]
+impl PendingInstance<'_, '_> {
+    fn activate(mut self) -> Result {
+        let instance = self
+            .instances
+            .instances
+            .iter_mut()
+            .find(|instance| instance.gfid == self.gfid)
+            .ok_or(EIO)?;
+        instance.activate(self.vgpu)?;
+        self.committed = true;
+        Ok(())
+    }
+}
+
+impl Drop for PendingInstance<'_, '_> {
+    fn drop(&mut self) {
+        if self.committed {
+            return;
+        }
+        if let Err(error) = self.instances.destroy_instance(self.vgpu, self.gfid) {
+            dev_err!(
+                self.vgpu.dev,
+                "vGPU creation could not release gfid={}: {:?}; resources retained until removal\n",
+                self.gfid.get(),
+                error,
+            );
+        }
+    }
 }
-- 
2.53.0


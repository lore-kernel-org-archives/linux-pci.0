Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.58
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793944001;
	b=Tn0PWrS9uM1tgi08Zq8uItb3VbmosCxt7jDrYtyR2LtwRKHHSun6ylNWkv8rqC/tsjxf
	 AzYDN7mvKrm38CVZ43l3pLc4Qt8jp1OghRaYd4VSoZeiSgRo/1/C9cESMCdImYoK3rBcM
	 nGY7ZojLt4+5ZJL3SA0u8rJR+eqDifRnrP932k7YYGSBTaV6wlGNPlAjxo52pJ3ekwsT9
	 84xhk7WBoChaFnAmxygxdB3A04rNeIf+dbWzgqA0cqA4vWlB2XSvH/jijnTuQlNcIA0zq
	 SI87WQSTGqBJh2Ez5BUjq6md01Jn8mkpRMZCiHxdsVqEgpQkVVgJGJZL9W5CptgCg/g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793944001;
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
	bh=KEBjNFMdiVduQpA7n6gVQ8WYebEw5hYSNONdJy0zDkA=;
	b=wVXGd0Gbo8GwBzMhsWOu3UXrn4adgURT0xW6n0Ul7GPbsa1SM8bA/QNxLUE/GVsmqSx6
	 06SS4PG6LEKPhgyL/tkEWdIHEzLZZF4544UiCZomcBLmLw1LujXxcOFQYh+PN+TJmXSyy
	 AS7x7f0KMDs/7hgjsKCh1LzI5Lr7SXY8QmpIL3yXXCHV6iec4S/5JswiU86Yxtnf1QXa1
	 F/OaSd9l8NYkd+aiA60kpUhHj5l9q5hgWIGY1WcKZ6t6CbB8DJb5bPuXq/tfcTVo3Q/0s
	 0szYuT3aTyLG6lSI8G0QWMokuOgVnvFiZRCzKWkQQfteWrwciSQIWn088axM87x68tA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="lBljz0g/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.58
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010058.outbound.protection.outlook.com [40.93.198.58])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0CD606A337;
	Fri,  6 Nov 2026 05:46:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A0CD606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=lBljz0g/
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G0WrzNkS8ZoNU5bAfjHH7xiwM58RJdXYRrQUmxFk/4HYOtrTvB/iKebJeHMOvoJh6CWdRTa3dY9cER0ptTEqniVup+MyrpnCH1KBzHJQOifbn58qhWknLuINOzqAJpTTkm8orfmxpCFYt7Xlf2Zsi34AfUWxwpIIGWT0t3r7p5w/cyQbgrrDKHIsCC6npfW83IDWUQ8NQh7gLL3RYEy+gb5sBFjYD2b8K7/gOENdYC1kgClHt8UA2ynRg/du4A3x2zylOpni3uK9Anyqcnxr8mMv+gjewJmlld9OENZ+7EXDavPcu6uZ9fxxb3h7mNbg1gzjWpA65EuWoZ4YPHMocg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KEBjNFMdiVduQpA7n6gVQ8WYebEw5hYSNONdJy0zDkA=;
 b=MMcyWVeboHd+Z2pABtsieGlPNxsDygXwHaGg2ipzFQioBQfqsk3NrLHqcQUIDc2kUlelKrLk0FJ3rqeq8RfxvGSqBtUeGdPQjHx8dzDxnhEE4oPWmxXWa42YgSKkMTDYlv0RvHobTQdeXruWH2mSUU2QIfmytT8wjAdz4onEkaKUm14Z9gVN7vvVM3RktbyJ0UUTEhxpPV14VY+3Da4CualRNfNx41NV7uspbjPgdX+VxntRkkeNNhCq3PbF3IZGXBEK9PPdKdDR05H9gJ/636G2pNyZCj1BByED7rFLAQK+H3geKIP2arua3cc1BB8ManGw6aQDPat9EIdyshf/Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KEBjNFMdiVduQpA7n6gVQ8WYebEw5hYSNONdJy0zDkA=;
 b=lBljz0g/0KBIYUb236PFICzYJEdxK384tJ+Ujq0k7ppbhrWF4SvB6yvgn4HzbmMj7XzhGBtOYRnNsJpSS6EK00j2bUW4t5wIsQpdf3nMMVmgUpU2rUEwzZAMSHPaIKrGs05JecfvV97M9Vj7Ihy66IAcg/ETix4x4pT+B5dutPQrdIfZiSFLl2AJeDGe02JpPHwgVq7DjsCJd8a06cPTfttD61VzSkmXPEY//+ki7odQZC3sEElsWB86CNKIe+lgdrCapFCXwh0xJsNCnKuhRlJoH8ch6e2nFouPhhWmm8RIWIpe2emMo1SAmMBFbfroymE6/Eevl3K9lDDz3ciRDg==
Received: from PH7PR17CA0046.namprd17.prod.outlook.com (2603:10b6:510:323::6)
 by DS0PR12MB7748.namprd12.prod.outlook.com (2603:10b6:8:130::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 05:46:33 +0000
Received: from CY4PEPF000392DB.namprd03.prod.outlook.com
 (2603:10b6:510:323:cafe::60) by PH7PR17CA0046.outlook.office365.com
 (2603:10b6:510:323::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Fri, 6
 Nov 2026 05:46:33 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF000392DB.mail.protection.outlook.com (10.167.247.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 05:46:33 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 5 Nov
 2026 21:46:15 -0800
Received: from kalok-SPC741D16QM3.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 21:46:02 -0800
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
Subject: [PATCH v4 24/32] gpu: nova-core: vgpu: initialize GSP plugin RPC buffers
Date: Fri, 6 Nov 2026 11:09:57 +0530
Message-ID: <a3e0fa94888010dec8eee00b902122cae7dcdc3b.1793906667.git.alkumar@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF000392DB:EE_|DS0PR12MB7748:EE_
X-MS-Office365-Filtering-Correlation-Id: a9a037dc-36d8-42bd-1330-08df3bc9505e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|23010399003|376014|7416014|1800799024|6133799003|10067099003|18002099003|22082099003|3023799007|261028144727099003|261021123027099003|261021121427099003|261102123227099003|261009223027099003|261026121527099003|261022105027099003|261021135927099003|261026140227099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	kPiL9JTDQI8mdZdBjm6WVxSzvHm+k2l+xVhdm/dUXXCoNlwoEjJlCeLT5girzD3jx2PXTlc0EOodXX9f+aWuYHsxn4jFH+AGOQN6jIXttpK4lopQjTQfgM2UBy4G4jG1FmdyUV/MZgAOV4ThgcxZMXwwQPJX+PPq5tpopmYqtET9Kpv87hYBzsxD6Rk/i3dV+Ww6GekQBjCV3PC+4pQysol43ITmYeAvaMAPtFtqMH4e9cqNCXeUsGZlJ0VapViBpyMjCDGB/bULknsxiiBYKpOrDedmDr/z0N6V6i6iN0KTgH4m6sBb2P+whUvQUB/kTtC1tRFjMbWU7nyUO2vdjIEIeqx/APNZqBpRaYxTqa2/L4s5p2wqjp1Vmf+h8Ql8+s8pDa1tsbWZuya2YnDDMYeMLlWeJEU+jdd445hn6IGzNDDoKV7+ZbVaAUOOE6gI1SoGcFI0GbA10wEyDGtL8UH2TAa6RUUILs/XwtJf35wWzlNQcGP/P6OpIsgSAWJKynHP3aPTTBc/wY0p2DJ+8tkETfxoOqoyBOJZAQr4rprivCI9xDOGUgVcZsv5zwaIgSorggUwiLEP7bz5DjJlErsFlheNrqv2ljDEISxViDRPpoVqQGUvkY+pjzt6uD5UeOpHYfC6VC50Mby3ljoGiemYTiOnSZ/Wl/flrF/TCCFmQCs0m7EbBwUH1DYmQDGlvLmuHNYdF4muE3FiCvJD2g==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(23010399003)(376014)(7416014)(1800799024)(6133799003)(10067099003)(18002099003)(22082099003)(3023799007)(261028144727099003)(261021123027099003)(261021121427099003)(261102123227099003)(261009223027099003)(261026121527099003)(261022105027099003)(261021135927099003)(261026140227099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	GkP6IM+79D+UsGaJKQlImw6UGY7A65oLgrvLrtm65vdKZQkVBFZ4BPXskWZPgLolKoxRADetrP6NnbadUk2Y6erFt4oFDU5wVodvt/NnGAfiIPyKDxpJ+y69RxD/Rw11eUNfupnB1cLCsLHlvYyZ7RILWLfi0jGdTHXm35yILdH+txXoJvmL9GFuxvCvwi2Wx8ES4O2q8Y2wSvunRD5twOeIig6nsCma4CPyFbyEg6lUJn+CdGW8K8gBZNfjsTL1bLCO6wSKVuwukShxeuUPPlZE7bou3c1+JJVLCjlJFtgwftzGVyTIgCO6Mn8JO7b9wuMU4SBSmg3Op9+KpMcR1ODP57zjZmVGz9aaDqggU8ssRetXMk8alB0Lv28UPNWvaBBg+QZZvpOLBZpEjhd1scyG/LLe5RLsQtBDKeqrSu9BJh2ytRQLaiG/tENO1IDw
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 05:46:33.2120
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9a037dc-36d8-42bd-1330-08df3bc9505e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF000392DB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7748

From: Zhi Wang <zhiw@nvidia.com>

The first plugin RPC needs region offsets, a protocol version and
initialized control and response state in the shared communication
buffer.

Add BAR1 accessors to initialize those fields and verify the fixed
response structure size at build time. The control sequence field first
carries the boot-ready marker, so RPC initialization must follow the
plugin's ready indication.

Signed-off-by: Zhi Wang <zhiw@nvidia.com>
Signed-off-by: Alok Kumar <alkumar@nvidia.com>
---
 drivers/gpu/nova-core/mm/bar_user.rs          |  10 ++
 drivers/gpu/nova-core/vgpu/fw.rs              |   2 +
 drivers/gpu/nova-core/vgpu/gsp_plugin_comm.rs | 141 +++++++++++++++++-
 3 files changed, 147 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/nova-core/mm/bar_user.rs b/drivers/gpu/nova-core/mm/bar_user.rs
index d4364f94b13e..925bbefbddaf 100644
--- a/drivers/gpu/nova-core/mm/bar_user.rs
+++ b/drivers/gpu/nova-core/mm/bar_user.rs
@@ -154,6 +154,11 @@ pub(crate) fn try_read32(&self, offset: usize) -> Result<u32> {
         self.bar_user.bar1.try_read32(off)
     }
 
+    fn try_write8(&self, value: u8, offset: usize) -> Result {
+        let off = self.bar_offset(offset)?;
+        self.bar_user.bar1.try_write8(value, off)
+    }
+
     /// Write a 32-bit value at the given offset.
     pub(crate) fn try_write32(&self, value: u32, offset: usize) -> Result {
         let off = self.bar_offset(offset)?;
@@ -287,6 +292,11 @@ pub(crate) fn try_read32(&self, offset: usize) -> Result<u32> {
             .try_read32(self.access_offset(offset, size_of::<u32>())?)
     }
 
+    pub(crate) fn try_write8(&self, value: u8, offset: usize) -> Result {
+        self.access()?
+            .try_write8(value, self.access_offset(offset, size_of::<u8>())?)
+    }
+
     pub(crate) fn try_write32(&self, value: u32, offset: usize) -> Result {
         self.access()?
             .try_write32(value, self.access_offset(offset, size_of::<u32>())?)
diff --git a/drivers/gpu/nova-core/vgpu/fw.rs b/drivers/gpu/nova-core/vgpu/fw.rs
index 1528cc56ce74..03225b9833c3 100644
--- a/drivers/gpu/nova-core/vgpu/fw.rs
+++ b/drivers/gpu/nova-core/vgpu/fw.rs
@@ -15,12 +15,14 @@
     VGPU_CPU_GSP_COMMUNICATION_BUFF_TOTAL_SIZE,
     VGPU_CPU_GSP_CTRL_BUFF_REGION as RawControlRegion,
     VGPU_CPU_GSP_CTRL_BUFF_REGION_SIZE,
+    VGPU_CPU_GSP_CTRL_BUFF_VERSION,
     VGPU_CPU_GSP_ERROR_BUFF_REGION_SIZE,
     VGPU_CPU_GSP_GUEST_RPC_TRACE_BUFF_REGION_SIZE,
     VGPU_CPU_GSP_INIT_TASK_LOG_BUFF_REGION_SIZE,
     VGPU_CPU_GSP_KERNEL_TASK_LOG_BUFF_REGION_SIZE,
     VGPU_CPU_GSP_MESSAGE_BUFF_REGION_SIZE,
     VGPU_CPU_GSP_MIGRATION_BUFF_REGION_SIZE,
+    VGPU_CPU_GSP_RESPONSE_BUFF_REGION as RawResponseRegion,
     VGPU_CPU_GSP_RESPONSE_BUFF_REGION_SIZE,
     VGPU_CPU_GSP_VGPU_TASK_LOG_BUFF_REGION_SIZE, //
 };
diff --git a/drivers/gpu/nova-core/vgpu/gsp_plugin_comm.rs b/drivers/gpu/nova-core/vgpu/gsp_plugin_comm.rs
index a00f4d2affc7..31da31de4fd2 100644
--- a/drivers/gpu/nova-core/vgpu/gsp_plugin_comm.rs
+++ b/drivers/gpu/nova-core/vgpu/gsp_plugin_comm.rs
@@ -20,7 +20,8 @@
 
 use super::fw::{
     self,
-    RawControlRegion, //
+    RawControlRegion,
+    RawResponseRegion, //
 };
 
 static_assert!(
@@ -38,6 +39,10 @@
 static_assert!(
     size_of::<RawControlRegion>() == u32_as_usize(fw::VGPU_CPU_GSP_CTRL_BUFF_REGION_SIZE)
 );
+static_assert!(
+    size_of::<RawResponseRegion>() == u32_as_usize(fw::VGPU_CPU_GSP_RESPONSE_BUFF_REGION_SIZE)
+);
+
 /// Physical VRAM regions containing the vGPU plugin logs.
 pub(super) struct PluginLogRegions {
     pub(super) init: VramRegion,
@@ -80,9 +85,14 @@ fn take_region(region: &VramRegion, cursor: &mut u64, size: u32) -> Result<VramR
 pub(super) struct CommBufferRegion<'map, 'gpu> {
     map: BarMapping<'map, 'gpu>,
     control: VramRegion,
+    response: VramRegion,
+    message: VramRegion,
+    migration: VramRegion,
+    error: VramRegion,
     init_log: VramRegion,
     vgpu_log: VramRegion,
     kernel_log: VramRegion,
+    guest_trace: VramRegion,
 }
 
 impl<'map, 'gpu> CommBufferRegion<'map, 'gpu> {
@@ -97,22 +107,22 @@ pub(super) fn new(
         let mut cursor = 0;
 
         let control = take_region(&region, &mut cursor, fw::VGPU_CPU_GSP_CTRL_BUFF_REGION_SIZE)?;
-        take_region(
+        let response = take_region(
             &region,
             &mut cursor,
             fw::VGPU_CPU_GSP_RESPONSE_BUFF_REGION_SIZE,
         )?;
-        take_region(
+        let message = take_region(
             &region,
             &mut cursor,
             fw::VGPU_CPU_GSP_MESSAGE_BUFF_REGION_SIZE,
         )?;
-        take_region(
+        let migration = take_region(
             &region,
             &mut cursor,
             fw::VGPU_CPU_GSP_MIGRATION_BUFF_REGION_SIZE,
         )?;
-        take_region(
+        let error = take_region(
             &region,
             &mut cursor,
             fw::VGPU_CPU_GSP_ERROR_BUFF_REGION_SIZE,
@@ -132,7 +142,7 @@ pub(super) fn new(
             &mut cursor,
             fw::VGPU_CPU_GSP_KERNEL_TASK_LOG_BUFF_REGION_SIZE,
         )?;
-        take_region(
+        let guest_trace = take_region(
             &region,
             &mut cursor,
             fw::VGPU_CPU_GSP_GUEST_RPC_TRACE_BUFF_REGION_SIZE,
@@ -143,9 +153,14 @@ pub(super) fn new(
         Ok(Self {
             map,
             control,
+            response,
+            message,
+            migration,
+            error,
             init_log,
             vgpu_log,
             kernel_log,
+            guest_trace,
         })
     }
 
@@ -177,6 +192,21 @@ fn read_u32(&self, region: &VramRegion, field: usize) -> Result<u32> {
             .try_read32(self.io_offset(region, field, size_of::<u32>())?)
     }
 
+    fn write_u8(&self, region: &VramRegion, field: usize, value: u8) -> Result {
+        self.map
+            .try_write8(value, self.io_offset(region, field, size_of::<u8>())?)
+    }
+
+    fn write_u32(&self, region: &VramRegion, field: usize, value: u32) -> Result {
+        self.map
+            .try_write32(value, self.io_offset(region, field, size_of::<u32>())?)
+    }
+
+    fn write_u64(&self, region: &VramRegion, field: usize, value: u64) -> Result {
+        self.map
+            .try_write64(value, self.io_offset(region, field, size_of::<u64>())?)
+    }
+
     /// Return the physical regions occupied by the three plugin logs.
     pub(super) fn plugin_logs(&self) -> PluginLogRegions {
         PluginLogRegions {
@@ -209,6 +239,105 @@ pub(super) fn is_plugin_ready(&self) -> Result<bool> {
         Ok(value == fw::GSP_PLUGIN_BOOTLOADED)
     }
 
+    /// Initialize the shared control and response buffers for plugin RPC.
+    #[expect(dead_code)]
+    pub(super) fn initialize(&self) -> Result {
+        self.write_u64(
+            &self.control,
+            core::mem::offset_of!(RawControlRegion, __bindgen_anon_1.response_buff_offset),
+            u64::try_from(self.region_offset(&self.response)?)?,
+        )?;
+        self.write_u64(
+            &self.control,
+            core::mem::offset_of!(RawControlRegion, __bindgen_anon_1.message_buff_offset),
+            u64::try_from(self.region_offset(&self.message)?)?,
+        )?;
+        self.write_u64(
+            &self.control,
+            core::mem::offset_of!(RawControlRegion, __bindgen_anon_1.migration_buff_offset),
+            u64::try_from(self.region_offset(&self.migration)?)?,
+        )?;
+        self.write_u64(
+            &self.control,
+            core::mem::offset_of!(RawControlRegion, __bindgen_anon_1.error_buff_offset),
+            u64::try_from(self.region_offset(&self.error)?)?,
+        )?;
+        self.write_u64(
+            &self.control,
+            core::mem::offset_of!(
+                RawControlRegion,
+                __bindgen_anon_1.guest_rpc_trace_buff_offset
+            ),
+            u64::try_from(self.region_offset(&self.guest_trace)?)?,
+        )?;
+        self.write_u32(
+            &self.control,
+            core::mem::offset_of!(
+                RawControlRegion,
+                __bindgen_anon_1.migration_buf_cpu_access_offset
+            ),
+            0,
+        )?;
+        self.write_u8(
+            &self.control,
+            core::mem::offset_of!(RawControlRegion, __bindgen_anon_1.is_migration_in_progress),
+            0,
+        )?;
+        self.write_u32(
+            &self.control,
+            core::mem::offset_of!(RawControlRegion, __bindgen_anon_1.error_buff_cpu_get_idx),
+            0,
+        )?;
+        self.write_u32(
+            &self.control,
+            core::mem::offset_of!(
+                RawControlRegion,
+                __bindgen_anon_1.guest_rpc_trace_buff_cpu_get_idx
+            ),
+            0,
+        )?;
+        self.write_u32(
+            &self.control,
+            core::mem::offset_of!(RawControlRegion, __bindgen_anon_1.attached_vgpu_count),
+            1,
+        )?;
+        self.write_u8(
+            &self.control,
+            core::mem::offset_of!(RawControlRegion, __bindgen_anon_1.is_gr_init_done),
+            0,
+        )?;
+
+        self.write_u32(
+            &self.control,
+            core::mem::offset_of!(RawControlRegion, __bindgen_anon_1.message_type),
+            0,
+        )?;
+        // Replace the boot-ready marker with the initial RPC sequence.
+        self.write_u32(
+            &self.control,
+            core::mem::offset_of!(RawControlRegion, __bindgen_anon_1.message_seq_num),
+            0,
+        )?;
+        self.write_u32(
+            &self.response,
+            core::mem::offset_of!(
+                RawResponseRegion,
+                __bindgen_anon_1.message_seq_num_processed
+            ),
+            0,
+        )?;
+        self.write_u32(
+            &self.response,
+            core::mem::offset_of!(RawResponseRegion, __bindgen_anon_1.result_code),
+            0,
+        )?;
+        self.write_u32(
+            &self.control,
+            core::mem::offset_of!(RawControlRegion, __bindgen_anon_1.version),
+            fw::VGPU_CPU_GSP_CTRL_BUFF_VERSION,
+        )
+    }
+
     /// Invalidate the PTEs and release the communication mapping.
     pub(super) fn unmap(&mut self) -> Result {
         self.map.unmap()
-- 
2.53.0


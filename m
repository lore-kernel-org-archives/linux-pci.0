Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.28
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795528852;
	b=kOkl6X0LgEi3JbaDvoQ/LvsCA2d+o4O2iBrkVFU+d10rbuyaaC4k1VsxXpTpZcA/8cNp
	 gsywwLpBqg9gtxlJPDTW8QXoWLxlXKQJK9TbaxdkvhPxaKW7dB/Zdtt90OMRT7m3w/r1A
	 zBXHAJ/Hqp9trfnYOTCYgjvbiuNuHM06iSKFMh2f345Vae0CY8CNAijelSlxMc/MmG4qy
	 31Cu/sAmXtE7bh00eZfz3nQ1gF8xfxfjyklwjLJswCjGVnI9YKlG8JqTE3kjt2tLR2FDF
	 JK/35JgXoK0gGB3HvmazOm0pyf1sNByQ2g9I9siXo8uZwkuVTZmqN1gdng6YjbySwOQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795528852;
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
	bh=bdjx/VxR/IQnwS8XrAeIKNwZ2HkBl83TZRV/MtEb0zg=;
	b=TaMG5oRpGLC+V0FJc5dQBtcHZX8zE+T4pLzN4VmmNKXrJGmD/bNdZMmCxJ6kFUpJyBKq
	 vESLPjj2rIiJhCGRcMkcg62v30MwGg4sHFQ24YWHVpaB43cWvTuxLavEOqa9ZV8Mq/wUu
	 bQ1uVAB8bqVjaUB8+KXJ1LhpBkCzJ9AD2fnf5WdLWyAgYIp359Br8VsYrjdJLmglKdZHU
	 lG9csGGD5kcxGOK9xfsazJa3ib6kkrEMqiP022IZe84GZZdCH0XoapV0/Kfcwi6dwMRj7
	 bN6K+14/s7n66/ZbxbWcJeCHlNlsKZF73m/p5LtG1Pnn9RMCT+m/JSZBD2oogaMxfyw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=PNsOrjzt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.28
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010028.outbound.protection.outlook.com [52.101.193.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2BD606A32A;
	Tue, 24 Nov 2026 14:00:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B2BD606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=PNsOrjzt
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eMWGmLR+20W/RRlmm9a1rdsv8vWjzBfXRjixr9SSqx2GQw9CHBahhdXMMb3Im7rpF65IozWU+i1iB8rAmMnRUJTHp6ZfLg5WRHpbDnyoQhMD5607mw6U/wsaOiP77sEypBhA9q0gvMolLCzGUyBAscS+hRj/nzIQ9J3ySM2/IzDP1l2ZPsvcdoVeQ6MRvf1vHl5jYsR63NnkJi6Ce273eG8DefXwi6q+J/uwZ/SLqhZQ2WWeJ8uipWQ9Yl0S3G21A3FmP7oMMjAyfUyMmLaqHMPBUZ7u8ETTLqt0F6BX391oQMa1T/PG3exySENNJipiV5bbjl7G4e8FW7S37jqqvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bdjx/VxR/IQnwS8XrAeIKNwZ2HkBl83TZRV/MtEb0zg=;
 b=F1yFsXUNQr3eVCLDDrZFiRx8Jy66/6xeuSWHbTtxsDtm9lr6wnemWXS989N4dS+O/CZOIwuq96cfRajg96YkSphPjd6w+w0t4r79vl4u2/3gJzhWmAMLrR8bZ5QjdL+KrjAVThk2WYaJsf1+aKbZquN8wI+cJinAeHcJyL1iLcjf/rJRj12igslVJ/Qxtj6O0Qxaa9bsQcmR1UlmGIjI8+oY3GfZDUusXX28BqHbH2CbmmWIGIXCuyBKmFCKkDjAZvBiLN1GXJv5kj9bqup8hbx3HF+nGZAaP8rrIQXD0G8PRNoBgHfdXTtk4tlUTEm5Ok6dPbGOjKyhWwBnN63qdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bdjx/VxR/IQnwS8XrAeIKNwZ2HkBl83TZRV/MtEb0zg=;
 b=PNsOrjztd0CH1nfHscngnO7EYc5NlTCC6EJzJX5KHVzG8f23FTZBBQbpikdILt/eSmYOCCRkmiA9VhTaTxRhgvF743UN//3VL6uKMTdalpPJ4HpPHlUzdxblQ13n/drhLWk0j7OmGicIsOWOoVyJmRX76OwTDx4tXtJu7rrTu9SfHWm/QU3dj68KQyXMBdRU9/m0Xj5ab+5QMOTf+v1wYCn2m7KpMFtMC5Q9KzS8LX+/Z0qxkWhVKziixZIXoqcBkxx/GOx9o39ninDgRqdlR86ICMFePg/kk1QsxYjYLC0z8AQrDT12m99TYSEln6aYjD6YFKGUsPK/LBvq/SDBMQ==
Received: from CH0PR03CA0271.namprd03.prod.outlook.com (2603:10b6:610:e6::6)
 by CY8PR12MB8316.namprd12.prod.outlook.com (2603:10b6:930:7a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.4; Tue, 24 Nov
 2026 14:00:46 +0000
Received: from CH2PEPF000166BD.namprd04.prod.outlook.com
 (2603:10b6:610:e6:cafe::8) by CH0PR03CA0271.outlook.office365.com
 (2603:10b6:610:e6::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.6 via Frontend Transport; Tue, 24
 Nov 2026 14:00:46 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF000166BD.mail.protection.outlook.com (10.167.252.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Tue, 24 Nov 2026 14:00:46 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 24 Nov
 2026 06:00:25 -0800
Received: from kalok-SPC741D16QM3.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 06:00:12 -0800
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
Subject: [PATCH v5 01/35] gpu: nova-core: populate VF information in GSP_INIT
Date: Tue, 24 Nov 2026 19:28:57 +0530
Message-ID: <20261124135937.18583-2-alkumar@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF000166BD:EE_|CY8PR12MB8316:EE_
X-MS-Office365-Filtering-Correlation-Id: 54930076-2910-45a4-9ae5-08df4a3356a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700016|23010399003|1800799024|82310400026|10067099003|11063799006|56012099006|261022075727099003|261022105027099003|261021123027099003|261021121427099003|261026121527099003|261026140227099003|261028144727099003|261102123227099003|261009223027099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	1RK25h2MsMC92bE0HTY1NykDM6k3Vpja080FuWiRrmK3PElpN62s+6xPB7sBGPfkyghcFO/nit5R7huqiMHFFKYkonXmG5PcjBxqIFfau7yJ8ROwypRFxMJoc7L/oGHZPdLufKMG5sk0B4+8zndjUesVeN+ZZ+rQ9rW3Vrwh11esV6Xb4HQiwVZ9ShAIT/6ow4Rub6F1mArl7GZMrHpZ5WtLw5L80eYlj2SCxAqoVt2lAY4ki/bY8PTvmt3nhRIuqeJRdXnl3twsNk7+Z2K+0NWi5ooMIyjaD9YduphwB5px8DTsWteyuqaL5+79ZykJMYNLScrmRXV0Mv72aTHBtrryhQSUzY4EO5QC2+L4Kn+Kph6d2hSnz+malAwI/ucdZxTeAZv32WKBfZVSF3dl4AJen2L5CsOr9UDotYlHEBjnROGeYwK35JswSRnHcZgZmVFjbM7WIxFd9r+wXh5K+3hz3VKb9D8n8nv5fpDjfK3R6koKLFfFdZh69R7EpBE0cIId1tqyvibMUv40W0dD94jo+1WfWOMLnhgfeHlsIB1tiPeH+TtdVTzTRfRcaGX3VnVBRS0K84JtEKXmQ6pZ8ha7qs6gUbeMNAzN6J2Cicv/TBhJAYhcviuJGYItsxxuEPCRu4gO+IEvLe4Qj1SPWakvgDjh3F+a3qCHvAhKT8+Wgaxmn4iYinThR71zySeRxnSHxqIhvF1yla5J1jZ8kA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700016)(23010399003)(1800799024)(82310400026)(10067099003)(11063799006)(56012099006)(261022075727099003)(261022105027099003)(261021123027099003)(261021121427099003)(261026121527099003)(261026140227099003)(261028144727099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	LdCBVR9CSkXO+QXDuAu48EeEEWuztKu81UzatZBv3OQBS0J/1HFwe/N/8bozntX9nXg1tIMBKSspnOU1SuNBGR5cY4EgDFiTrsLWQeq5ihakzhLwTb7gXOj6Gdczd3QA0GRwBjvMRysykXEZt8q2UcJkjX8Bgl0pM5Fm8DLB0e9/qfnBL9w72dkkHoO/3AekWCCrPtlc/SgI1zrMgqvUKIajtsH8wKfZjay+lpxy5yMRIPwslwXShhswWHTkab2JWaXmyUYBiTaruBgUYw2M4pOEPFukzNSns4wCJXQG/CEUwjSFTWPFHSqFkRBzLzugobAk7sTmSzB/0vDA+o3BBrogjCerbExGwKI9oW3ocT4AVGCcAYXVX0Ov0rVBlP0+3XxghVUojZ/QJ6Gut+fK6N+DXrt/g/gQ1pe2qWIn3XzIBDzCsWSIZLN/H2clfH2r
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 14:00:46.6024
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54930076-2910-45a4-9ae5-08df4a3356a1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF000166BD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8316

From: Zhi Wang <zhiw@nvidia.com>

GSP firmware requires the VF BAR layout to route interrupts and doorbell
events to individual virtual functions.

When vGPU mode is enabled, read the VF topology from the typed PCI SR-IOV
extended capability and populate the existing NVKV VF information schema
in GSP_INIT.

Link: https://lore.kernel.org/nova-gpu/20260730181404.776028-2-zhiw@nvidia.com/
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Alok Kumar <alkumar@nvidia.com>
---
 drivers/gpu/nova-core/gsp/fw/commands.rs | 34 +++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/nova-core/gsp/fw/commands.rs b/drivers/gpu/nova-core/gsp/fw/commands.rs
index 3c9fa459af88..4cc4b086c1d7 100644
--- a/drivers/gpu/nova-core/gsp/fw/commands.rs
+++ b/drivers/gpu/nova-core/gsp/fw/commands.rs
@@ -245,6 +245,38 @@ fn new(dev: &pci::Device<device::Bound>) -> Self {
 ];
 
 impl GspInitRequest {
+    fn build_vf_info(
+        dev: &pci::Device<device::Bound>,
+        vgpu_state: VgpuState,
+    ) -> Result<Option<VfInfo>> {
+        let total_vfs = match vgpu_state {
+            VgpuState::Disabled => return Ok(None),
+            VgpuState::Enabled { total_vfs } => total_vfs,
+        };
+
+        let sriov = dev
+            .config_space_extended()?
+            .find_ext_capability::<pci::ExtSriovRegs>()?
+            .ok_or(ENODEV)?;
+
+        let mut vf_bars = sriov.vf_bars()?;
+        let bar0 = vf_bars.next().ok_or(EINVAL)?;
+        let bar1 = vf_bars.next().ok_or(EINVAL)?;
+        let bar2 = vf_bars.next().ok_or(EINVAL)?;
+        let flags = u64::from(bar0.is_64bit)
+            | (u64::from(bar1.is_64bit) << 1)
+            | (u64::from(bar2.is_64bit) << 2);
+
+        Ok(Some(VfInfo {
+            total_vfs: u32::from(total_vfs.get()).into(),
+            first_vf_offset: u32::from(sriov.first_vf_offset()).into(),
+            flags: flags.into(),
+            first_bar0_address: bar0.address.into(),
+            first_bar1_address: bar1.address.into(),
+            first_bar2_address: bar2.address.into(),
+        }))
+    }
+
     /// Creates the request for `dev`.
     ///
     /// The registry keys are [`REGISTRY_ENTRIES`], plus `RMSetSriovMode` when `vgpu_state` reports
@@ -280,7 +312,7 @@ pub(crate) fn new(
             host_arch: HostArch::host().into(),
             bus_device_func: u64::from(DomainBusDevice::new(dev)).into(),
             regkeys,
-            vf_info: None,
+            vf_info: Self::build_vf_info(dev, vgpu_state)?,
         })
     }
 }
-- 
2.53.0


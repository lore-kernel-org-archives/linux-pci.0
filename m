Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.23
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795528924;
	b=JUx6q4FEPp26W/fdc8T8IvG37E0VyvCxWGOc/7Jxx8pvfNb0fBy5ztXqNd/VpNp+8QzN
	 X83Q9wlMFwm76hV3bZTxzwviJbV5WoZ60bHy123W7dlBkgEHg4p7dSAM0vWNpb9bHqekm
	 OZmVpNEIlvgp1p27B0siZ4JnZpmWu0NavXDGJ4ZydlG4xm73xvGPPPp3Zwo5arlrgruYP
	 irAPLR1V2wsm+JbTH2jlM0Obqq8e18UV6jkShehwag/Eg+RmiNVtolQhRFGRuxhPqIz5R
	 hQYMFQJCLuAYtVrpj+TH4JPtNIRoE3tHAu/vx9GqVPIFzMjeUZ7mtxROhZR5F+H0h5Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795528924;
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
	bh=wzW5zSkjjuWvAZgnG6RV4qtiZAXA7Eorbj/YVekHk1k=;
	b=WoywMuIMUWK+mhkHvTuCF/aPPYcSd4O6+7k8UGooB6VfrGNn6YnTdO+bB3jbOv6rSf+Y
	 JW1LhlHTeKJb4iWEAbv5dvOVzj5BRIIIA6N7utUVqkd4ERBjdEDGASFmjINEizHzzc47P
	 4i0IevA33t6bTz4Xoy/1eQvRweten9Xui55mkWoiV2H8m/DHJdgBH6K2rDlU2p4nLUL8d
	 cxyx3SXTQPZFlj/MgJ3HQuy9yNVv7BX1aHF28NQ2+FxRYExqtFkRTdTRvZXkhWrh4lyBB
	 KyMp4eRUrTIT/vvhtmZY4VvDWJm0SG3dA/Pj9bTh0AbrlkYdoKD4kcOdgn5JbsoeIAQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=qV0b9bj4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.23
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010023.outbound.protection.outlook.com [52.101.61.23])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A0A606A331;
	Tue, 24 Nov 2026 14:02:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79A0A606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=qV0b9bj4
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X8QEAvq+kLWRZE8nX8txSiAUoLp1A6qggrg6IDg+ZyyuF4tYzFxnEKz/Y/UgIYjasYDhwkaiOruFws7pK3elMwQM1pRAHxCsCWfEKXCghzKgtvQnZ+KmDKxzIpaiHafAilwHYoG96UMweU9EBR05YaypdZ4+sjyzR+c7wi9ko1U6h4CHHUcxTOYDD25JM53Eegbji4ZqQaZtjwB1ix1N3MzCOXWwQG/+TZ8vbaO0KgQX8HJkLo2PKQFmJeCmI3cx8BGOFu7gUa5FAuf/w0GwHK9mPVVjB06XS6JrM6+ZBzAtIiLY+kFW8W01mNUvouIRbHsfVjj/3UZ/TGWWXPqlBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wzW5zSkjjuWvAZgnG6RV4qtiZAXA7Eorbj/YVekHk1k=;
 b=G1r6MPkBABpRLjFgIHouq1UxXi9kZvJT1oQKwdihatiRrAa66G1c0u3n8uoXsZ3cPw/NE26Auewd7p3D16doG+1Slfb01jd66SJo58z46QKyuje9o5geET+0NfGnhFtTVszgVh1xuwAb+mamAdNFAYRInNUjj1WRZcd9z77hyo82ThFGDzvzYeIs5/Wlq/4UtQPRpCgVTqU5wm0SuPfS0TittP3wbQoLBg4qMcbRa09yTPPFOxQRG9urGsydxDE+XjlR4M6A53zL9DpqAMsAX9HvGXY+/nVxOe9kBHTzcG33wCW31CPhAG44CBHbUfiBCqmZeDAV5ufr9ZF1Hfc/9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wzW5zSkjjuWvAZgnG6RV4qtiZAXA7Eorbj/YVekHk1k=;
 b=qV0b9bj4/jESJ5KO3lNGn/JNnE9n/h1j9cAnZjtUDIkxdgacLd+8RVb2/bP56j/acm7jkCMjmwoLyUyikZYOnOkXrE+A+lg8lpMliBozL2zQg6ceMhoD7ZdBJFQNiTq1LJ75yrCKfNOJeNwCXgqXQ59CZM22Y8DSCBzrv6Rmu6mGnuCKjDJvICDT5ro2VmiyAhJqdva/Uv+apSwrvRkbClAo0eql4uG/PTJoqrFwJ8CNXBiH0VK9mBcHnZLsOIR4pM1FDiwmafszIZ03166QpdkowrajXx8P2sPdImiQSwp/T+2PDy7kJuRzBeNFHbSAUtgxy0PpfMtoe8kU0O5Ntw==
Received: from CH0PR03CA0084.namprd03.prod.outlook.com (2603:10b6:610:cc::29)
 by DS0PR12MB7925.namprd12.prod.outlook.com (2603:10b6:8:14b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Tue, 24 Nov
 2026 14:01:48 +0000
Received: from CH2PEPF000166C0.namprd04.prod.outlook.com
 (2603:10b6:610:cc:cafe::84) by CH0PR03CA0084.outlook.office365.com
 (2603:10b6:610:cc::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.6 via Frontend Transport; Tue, 24
 Nov 2026 14:01:46 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF000166C0.mail.protection.outlook.com (10.167.252.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Tue, 24 Nov 2026 14:01:46 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 24 Nov
 2026 06:01:16 -0800
Received: from kalok-SPC741D16QM3.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 06:01:03 -0800
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
Subject: [PATCH v5 05/35] gpu: nova-core: gpu: add a channel ID pool for vGPU
Date: Tue, 24 Nov 2026 19:29:01 +0530
Message-ID: <20261124135937.18583-6-alkumar@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF000166C0:EE_|DS0PR12MB7925:EE_
X-MS-Office365-Filtering-Correlation-Id: 0619ec31-146d-4a55-789c-08df4a337a29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|36860700016|1800799024|376014|7416014|22082099003|18002099003|56012099006|11063799006|261028144727099003|261102123227099003|261026140227099003|261026121527099003|261021121427099003|261009223027099003|261022105027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	5MRa/QOQHGmxu0n51h/Gv8ClF2EneZJeBe6eph8Kwode1Me5zp9GsATq+mCM2YsspjZNItAOlXClXkKLlGUK/bGGJ+JiR+N1dQdUWgwSqSxOJpKZAFOKEoEKy8iDKPpb7F4kfFnJN3Yl7KJWzwbUvlwahZ5LCKwUllzPd7hn0j7IfBXE7UF/Fm6JxUqYmsilBniqzsV8FaZKLLRWFgK61XcIVLYEenRt/F6MPZdA24dpxGJ3XKD0EVa6UkJD7TG9/CzD9vMauG5C21582wbSsa6NSLOm3y7N3isN3E+bVw5x5g9ox0glcTD7PmFLmM2+pxSotueuSg4uOldAD6aV+DIfsQAPDEuOtHX0FYDeK/DJsV7rw5LuDfeQpBoWMoqJP7Jl0vrpG/cdrnrlFRzklkaf56OPdJmyEctSANWuZeaDkUEcWhkwz6l0QlM31ZN/cKT2xuqSSnCs2B40Y5PSvuZFuSrl5SUDDsIZCPovyZnpBRywLuC5q7FKRcmcLEfjmfFTlscHwK+iXUzMM8ROkcqRYIDjnjy2KjB4cQ8ZL2k9gfA7+L3x/3bW51GkYWnkVl7WL/Zq0bwiAU0PykcuAExR8zHxXipkLogQCk27sLjY6KQLVoekegEshI0ixLXBGHyyqhIHNgtOdMZrH7NpV1MQ5M1VGEevheygs3cjAZ5SM3yN8Act9nMDauXfgUWE36cV8CioZENdfu8pqcNCuA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(376014)(7416014)(22082099003)(18002099003)(56012099006)(11063799006)(261028144727099003)(261102123227099003)(261026140227099003)(261026121527099003)(261021121427099003)(261009223027099003)(261022105027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	VB7U7Unl3RSKsEsGO3Yqi+csWRrycfc3M3HBqeggdIZLjyS25w4yaRj2Yr4gC90ku0sN5QViWx0mzhGcuIw1rT9n58KuryewjUcSe9s4rqpxjsDplmztbY76oI8V/zm3Wk0zOw9pf2N9fT/dyk/OhUw+apovIjcPgo/DG1bNiy9Rj24xrEV92frDVjP+2iv1hm/KTMgDXzaUQLaS0x1dYlHX5u/LJUFRnXRpYURMelMTg2IyyI3SVjd+IUp5CEMPQbnVvTCyT63MxDTcq+Kwh+a20RWigo/Ebt0K1f7WELU9wXs1tMruIyUP9SOwdKw6cIzZjugM6YyMir2TUsBb9ILC4MKVv4lHfFUtCU6/OmjiB4TRnUArn9ut3M+rU2Jp5Ns3tgwC/dWpg/fTM460MSDvs6bjVqb2sh1nzLZ+l1MDONIs1JbpWfCwox/IyNLl
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 14:01:46.2091
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0619ec31-146d-4a55-789c-08df4a337a29
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF000166C0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7925

From: Zhi Wang <zhiw@nvidia.com>

Channel ID reservations need a GPU-owned pool shared by vGPU instances.

The pool must remain at a stable address while its reservations exist.
Its storage also needs to remain available throughout GPU cleanup.

Create a private pinned ChannelIdPool with a single 2048-channel
capacity constant.

Cc: Alexandre Courbot <acourbot@nvidia.com>
Suggested-by: Eliot Courtney <ecourtney@nvidia.com>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
Signed-off-by: Alok Kumar <alkumar@nvidia.com>
---
 drivers/gpu/nova-core/gpu.rs         | 9 +++++++++
 drivers/gpu/nova-core/gpu/channel.rs | 4 ++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index 5c304a129df2..b3775365a74e 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -49,6 +49,7 @@
         GpuMm,
         VramAddress, //
     },
+    num,
     timer::{
         Timer,
         TimerState, //
@@ -61,6 +62,10 @@
 mod hal;
 mod regs;
 
+use self::channel::TOTAL_CHANNELS;
+
+pub(crate) use self::channel::ChannelIdPool;
+
 macro_rules! define_chipset {
     ({ $($variant:ident),* $(,)* }) =>
     {
@@ -409,6 +414,8 @@ pub(crate) struct Gpu<'gpu> {
     /// GSP and its resources.
     #[pin]
     gsp_resources: GspResources<'gpu>,
+    #[pin]
+    chid_pool: ChannelIdPool,
     /// System memory page required for flushing all pending GPU-side memory writes done through
     /// PCIE into system memory, via sysmembar (A GPU-initiated HW memory-barrier operation).
     ///
@@ -486,6 +493,8 @@ pub(crate) fn new<'a>(
             // Initialize this early because `gsp_resources` depends on it.
             sysmem_flush: SysmemFlush::register(dev, bar, spec.chipset)?,
 
+            chid_pool <- ChannelIdPool::new(cv!(num::u32_as_usize(TOTAL_CHANNELS))),
+
             gsp_resources <- try_pin_init!(GspResources {
                 device: pdev,
 
diff --git a/drivers/gpu/nova-core/gpu/channel.rs b/drivers/gpu/nova-core/gpu/channel.rs
index 7263bb4227d8..790d9be7c26c 100644
--- a/drivers/gpu/nova-core/gpu/channel.rs
+++ b/drivers/gpu/nova-core/gpu/channel.rs
@@ -21,6 +21,10 @@
     }, //
 };
 
+// TODO: Query the channel capacity through GMCAPI once an equivalent of
+// NV2080_CTRL_CMD_INTERNAL_FIFO_GET_NUM_CHANNELS is available.
+pub(super) const TOTAL_CHANNELS: u32 = 2048;
+
 /// Pool for tracking reservations of channel IDs.
 #[pin_data]
 pub(crate) struct ChannelIdPool {
-- 
2.53.0


Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.4
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793943832;
	b=RjyZTvjzwSIjP7gpIMjYqOBJWhvICTm+J2VwgwZtiy8wgrnJIXdSgKbZHQt8mEa0q875
	 ynw9YahLV1w/sBNbeupeES9RxrIzcpJ42sPc/KVKD7umnxFcfLFoJLVp3T0jDHL8PxWB1
	 U7w2dHLcRxbVqmAd3Guk4VXmPK23+QrOT0NDGTv+yr02P861MTZbp4XYewcUFWwd2D2jq
	 Khnw9OSRVFDEC3ahTkhbMTHwW0KL2+40ksNgIf9qPLK5rxXrBQ3w4pJiIukLUH9eGnhq4
	 2yuE8NS35FsTcqk10CsIx8SvwDozHCgPRVgNpnaUDouP52YE1rKxdf25qWlqby2/r4w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793943832;
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
	bh=Ddvc0xSU5pmVnzATNQRdwZD657fUHRlEnQ2P6Gub98o=;
	b=388J3GEAk/bBSkavBio0PltIPlE8LylBZYYm8vdDy9xafY+6L7eTE3zkqzuF/3pZOOUo
	 GgWT/K6uLLc9QjIJmSdNvF41yvTntJbRoZ+wr1G+AJICZyeXPhHwsV1ygGaPPBnwrXuvS
	 fl7LnX+sG7cQji0Vg6VF6uy+7rycI5hf7QmNZn+NZZJv6+k85VOq7058xCcdxq+MM1UNo
	 92S02lZfh4R9XVF5hoOQE1N6KGe8QKYys6Uxft1V4V+DEbRTlT7iAskw0e/rocI3x7cJA
	 uFYxt0buqd0d2YqfI8xSd4WfuSgsvSF9ZQ2yVE2MS5CkkXYX+ovejXuQ5FrjdHP1frA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=TpxbTOb7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.4
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013004.outbound.protection.outlook.com [40.93.196.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F370C606D81C;
	Fri,  6 Nov 2026 05:43:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F370C606D81C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=TpxbTOb7
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yS4Mker6RQx9zT3Di6+IqpW0yn/d6CmftKr8on4YOA1lQLTy0K0MsSCUfqhhHDPiVXTnIbwVvjTui45rcOsptAiWgZyTlvQhWqYW7a8VA3Wrkdgsc0XRM+C7ZfamuXptgBLbq7DCbBOemC4cLtd547EMdYeWQJfOe5h7O+uwKNm/Odeg49Ae9fij+cEbkOWr9Xdo7zotNI26jq61jZChGOn9BHGL/o98lbQAth9RCuWeiji3lnk9ezQqK3vaN1y9xSUQPjKueohpErZANUlU+FsrNe4ymmlJy+sXgkgy99kXER4UtxbaVT9leUPXfkZ0KEv1nXhOOyr1yVam7wZxNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ddvc0xSU5pmVnzATNQRdwZD657fUHRlEnQ2P6Gub98o=;
 b=PJrr8eEliz4h+gbHsAarGGf9m5QVu6tMw7HNCSkRNx6prSrbkN9DrnudeD1rffRdL9Y9F8w5bXhiH6DuSWSryeB+3nNFWELyvIBTc2n7FMfletGUkR62mG9gVRMW6VP6mXwfDjoE282FFXGMqqNkDjFMXtNwvXS1pXu95vyyGypuazIHEKYotDkreL5v1xWdj71Y0SNCYJTvWsTbcUhpmhFcTsfjmKFfqOoTVVkcocAUDpaE6YR9j/wbLUfKT4PSBgrv7aLPXSWRI4SWjDlvVDj58bY8OTIjelPWgso0xdersCaUphBK16sHxfYkP/XiqH7o1AX9YoSJHRKPcyfGsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ddvc0xSU5pmVnzATNQRdwZD657fUHRlEnQ2P6Gub98o=;
 b=TpxbTOb7/tSg7TMNb7yja4zyld5KL0omKlSczB6IEsdjUBe0PR7rMheFdqt9phj5L5y+1x9zaWxiqX+0sAhTHoOxAl/02aFs42BGZQZ1u/wj2QRYsljPS9Xa34wAU8f28XvEuBtW88Bn43TMQimcjqwLIyfGmGQpBVkoVgEgqO0B4HgRmlYMuWWhvyAotf3oNFhkjsWBx2D8Gh4Gd6U37xIGt2qEs/BmRsX4OnVYLwZRcDP88/MZ+zjLYxRa0NiyDg6LwM/qXLKeKh3J5yTexEf4mr0tX+wcH8uHa8MHlPnXgO/ytoi9cmT8nOj9lYiFXLfZeombbQK1KbWC0UXLQA==
Received: from CY8PR22CA0016.namprd22.prod.outlook.com (2603:10b6:930:45::27)
 by CH8PR12MB999206.namprd12.prod.outlook.com (2603:10b6:610:35a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 05:43:45 +0000
Received: from CY4PEPF000392D8.namprd03.prod.outlook.com
 (2603:10b6:930:45:cafe::ad) by CY8PR22CA0016.outlook.office365.com
 (2603:10b6:930:45::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Fri, 6
 Nov 2026 05:43:45 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF000392D8.mail.protection.outlook.com (10.167.247.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 05:43:45 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 5 Nov
 2026 21:43:32 -0800
Received: from kalok-SPC741D16QM3.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 21:43:19 -0800
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
Subject: [PATCH v4 11/32] gpu: nova-core: mm: add VramRegion
Date: Fri, 6 Nov 2026 11:09:44 +0530
Message-ID: <5312c9e19a686ea9f590d1caf24289c04215e575.1793906667.git.alkumar@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF000392D8:EE_|CH8PR12MB999206:EE_
X-MS-Office365-Filtering-Correlation-Id: 97652848-2f2f-41d3-184b-08df3bc8ec70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|23010399003|376014|7416014|1800799024|22082099003|18002099003|10067099003|11063799006|261026121527099003|261026140227099003|261102123227099003|261028144727099003|261021121427099003|261022105027099003|261021135927099003|56012099006|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	Cd9oLnrd1doIY7ABG8+MDpGxx1cXvG3MqKBnJZ2Q4afiwrb85OLTcsh/fRkNAGpKQDtIllpsqJAzURFvrGLUC+pYH/4JeCkfOXHix8H2qcaFi4SgP6ASGz28/EwjmRtYyWxSf5rb6ginJv8he/DX9xlVB7Ta9S6uXI1AtrAlxWVp2AmSukMkiFsFHPqzDdM+dT3zr6l6WErq4YoDZoJrZMLcVMzfKeygIiB0MdJtgWQL51ipiGZlxXStJkKaWvXcYTHvffg3zVFo2e5tjDSl5geIFLIppm3Lgc/J5BBoBlhJsAfPNAX7+OPHOtazmO/BQEjCDnFg2GWYe5jocCNZ80hyVODfm5ylVe2PE2l3v/qEWFhAw2lMMS0MaMqIODc4zSFZVzyFMKsaSg0YPPgW/Vb5OedMAPnAg9iRx4qsshrZSHJxBVK/x2bdo81RpQuqV15wr4S5R5rvO50MzV9vRfs4CRUA5hR/pkjIyGzhqR7/EHCBfPYjSk0uG7wBfD3We22aelPSwq2WynOcuknUZdMaCji+b4dYZXyfZIVF+wLN0nL/NDdg8DX3Fx2Y/i990tpd5uRKd3Us09mCdmnM7clgM7r1hPJ9oT69TrVaMRQMFUfM35rtOBuBxWxh9j/S35kKDKiaCXYmIxu3P2quPBMuIiqjI95cPMpRqmYLPisE6zCJRyR0N4cm5cEG/pwSl/7oPdQ8W+mej83oaAtJ/Q==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(7416014)(1800799024)(22082099003)(18002099003)(10067099003)(11063799006)(261026121527099003)(261026140227099003)(261102123227099003)(261028144727099003)(261021121427099003)(261022105027099003)(261021135927099003)(56012099006)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ynXsGAq/MltiPa+n7Ibhb4sVYtUI73kMpMOSxa/HhCAyOyBAYBGQURLj82JGaRBk2JiXbD4x6xynSLFCly3yfPNK0iv1zyJuQJfUdv078t1KEIuROC/Yw0S18p7wmADJ2gjR3cGudr4JJHAzc+4BoJK7bPUzTNBEdTkRn5ZteqDif0HDgFhAOHducTXi0mcJMNlxQ0j7Yb/FQlxwPIPG5/veq4Ot53TN1/KhatQCG34KlQLx984HGNWnassP4hiL0x/9DjU1zGFE5Gs30rHdueCz7dOszB3xq/icWKxTpefuWaod3PbQuqxO3RlYbWIsC3LYRroBDfbgbIX1m/OcDdiOdokDnMRl79bf9GtLwk2x83Tu1v5RWOuaMM1SNDyuSK6uQuqga1c9J/5eAJjkGhrEq68k39YOwGwlLUbtb65M9R39WBspw4tySwFy6eQJ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 05:43:45.5412
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97652848-2f2f-41d3-184b-08df3bc8ec70
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF000392D8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB999206

From: Zhi Wang <zhiw@nvidia.com>

BAR mappings do not necessarily cover an entire VRAM block. A region
layer lets a mapping select a byte range while keeping the underlying
allocation alive.

For vGPU, communication buffers occupy only part of the management heap
and need a BAR mapping of that range.

Add VramRegion to describe ranges within a shared VramBlock and support
bounds-checked subregions.

Cc: Alistair Popple <apopple@nvidia.com>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
Signed-off-by: Alok Kumar <alkumar@nvidia.com>
---
 drivers/gpu/nova-core/mm/vram.rs | 56 ++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/drivers/gpu/nova-core/mm/vram.rs b/drivers/gpu/nova-core/mm/vram.rs
index b6cc177825d7..bed90a3de8bd 100644
--- a/drivers/gpu/nova-core/mm/vram.rs
+++ b/drivers/gpu/nova-core/mm/vram.rs
@@ -34,6 +34,62 @@ impl VramBlock {
     pub(crate) const fn address(&self) -> u64 {
         self.address
     }
+
+    /// Creates a byte range relative to this allocation, retaining its backing storage.
+    pub(crate) fn region(self: &Arc<Self>, range: Range<u64>) -> Result<VramRegion> {
+        VramRegion::new(self.clone(), range)
+    }
+}
+
+/// A byte range that keeps its VRAM allocation alive.
+#[derive(Clone)]
+pub(crate) struct VramRegion {
+    backing: Arc<VramBlock>,
+    address: u64,
+    size: u64,
+}
+
+impl VramRegion {
+    fn new(backing: Arc<VramBlock>, range: Range<u64>) -> Result<Self> {
+        if range.start >= range.end || range.end > backing.size {
+            return Err(EINVAL);
+        }
+
+        let size = range.end - range.start;
+        let address = backing.address.checked_add(range.start).ok_or(EOVERFLOW)?;
+        backing.address.checked_add(range.end).ok_or(EOVERFLOW)?;
+
+        Ok(Self {
+            backing,
+            address,
+            size,
+        })
+    }
+
+    pub(crate) const fn address(&self) -> u64 {
+        self.address
+    }
+
+    pub(crate) const fn size(&self) -> u64 {
+        self.size
+    }
+
+    /// Creates a nonempty subregion relative to this view's start.
+    pub(crate) fn subregion(&self, range: Range<u64>) -> Result<Self> {
+        if range.start >= range.end || range.end > self.size {
+            return Err(EINVAL);
+        }
+
+        let size = range.end - range.start;
+        let address = self.address.checked_add(range.start).ok_or(EOVERFLOW)?;
+        address.checked_add(size).ok_or(EOVERFLOW)?;
+
+        Ok(Self {
+            backing: self.backing.clone(),
+            address,
+            size,
+        })
+    }
 }
 
 impl GpuMm<'_> {
-- 
2.53.0


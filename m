Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.60
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792770098;
	b=M4z7HPNyOtOJaTySVMw9osWLdxxw0dXg5S3SoUtA3NceBDecBYYCF7Q0l34FTrP+90P9
	 0F77GgJrBRrj+Hkn3oUlEnDbSixVJJVol9D0Nn/LTl/bnbAvq5sFC2fK/o4LsexcGxmyh
	 vcCZvq0/XZAsgC71MA8QfCM9JC4Q47ivdKttOs0ooEMC0QUnPtCj0AeLXzV2ce4NK1sHo
	 Ener7F29Wi9dBiSXKIxtfRDBYPA8kZB/uVswuHbuMf5lpzsL0yATWdw5V2po0mJ6VbUUN
	 AM8EVk31lxhfKx2ExqhbaG6Gaj0EnrzJWNemSSZhKKdx2MA8sN69alppGRDEKnhzmqA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792770098;
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
	bh=7YUWWAhjzO0AVAvCxR6WWaQ0hTCmKJ5+4AL11pcgXeA=;
	b=y0J0qO4NVAq1/ne2i5yBpD1p7/bThVPX7rsZaqq1NoWj3IuLrJK5zs3yaY5Nzp3zqbkD
	 ZnunpyfeYFt3LX+YkpUxVgd8+lA15ub18HQ++qqXLsC6XqQfan4KN755d0Y83VRt//IfX
	 Or8c80T9OBmNm3NeQwC4Y1yMM1NfDgIprjodQH37ClTyueIr2uzv7WYyX5pgF1IyElK0y
	 Yl1dG/kkKA00pnedxxFgdLinV5hPaM3LaR8Ru8xyTKNC6wmeZfec0eTZw4gjlThXRmYdK
	 Squc06rFoTZU0hthfg62iPcLTRAsznqbIIF5GH9e0Mey/ODpG08mk+2ASw/yyGnt5gg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=LJcvuIT4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.60
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010060.outbound.protection.outlook.com [52.101.61.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4501F606DB6E;
	Fri, 23 Oct 2026 15:41:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4501F606DB6E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=LJcvuIT4
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UyhUlvUmZ/zNubefmBVE3Oy21N8CKEmEhuwV7WXVmMjN22m8W2IGCeAyNRFe2K+RNOplw8+snsEg5svg9M+sX67q8MW5ePaQ4FE58fcARXJYhX1eNBW64YmqmyPj89c2pZC4TUBts3KZuXa5Q4a6BgW0T6VLeay46nzTwhADtWdA9vV8F6StCQZ2KplfWLkSAtQxcOAvxlDHwkobYU4/VD2rHgYC+4hXxiOWNe1Yof5/3/ik0peWF3q4Mb5pIuVWMLS/G8doTvOabBn1k7hrw2YaukDUNtEaBCgPwO+n/V8gPSc2eM40r6Rb+wbjZnDznmH4L/UvXtqH7ExOcVDlyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7YUWWAhjzO0AVAvCxR6WWaQ0hTCmKJ5+4AL11pcgXeA=;
 b=sO9KmbskFBy4EZVOhlgS8GrFQ7dAmLbDx43B9y4yQOarDIZqWfp0Tv2NLhpR0kjnkGx8RqsOge7wlgPLZDTC6EDc5l/Y6simBhKl6mSPFvsjz+8jOtCZIP8QSot43Me39Ut0Hr1fvoVDclPWLSMwuGdCdkbTGJCeSQId+2QOwg082YmKtFBy5JJx7URKci3lRDUaDOBTwsVXX7W3E38WwOO6ANq5WzGAzUK5FfVLfDWCM3s12qNn9+PXFtLmZD1GTbGpqDpt18Tmu+zIqut44t39DxKnVlDpt5CG4WN3Y1bAPGU1ynQpThTleAcZD4tFEm2afl/vx5wUvMDzvOHl4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7YUWWAhjzO0AVAvCxR6WWaQ0hTCmKJ5+4AL11pcgXeA=;
 b=LJcvuIT4zzdi6djv71CACk4tT2MOm6Z9bolkMbY2w+jfPsmU+y1Z44weRhy0lumeFwiSk6uKkln1GRqkngfR/1HxbwMxek/cTG0yfLaVssM4TC97aXj7UvIxEkxwrwduj+rvolFzfn9VYVGwZdZEbSlCsQvyB8tntuJttWqBvzpBLtu/ADvytlkj7JpZgSO7dEBIdlBNcNvAbQByYQAqYQvcYFcLG2a357Ya3R//RqAW1ghg+hv8JgtVVWmdxxl4Qg4e36TlBHsOIdHTv4p4/XyttX739Vvm8noOvcTYDDDIAOWVdzdhkhYBwsVWVsjJsF9NbC5A/K6Zbf7euLkW0w==
Received: from DS7PR03CA0280.namprd03.prod.outlook.com (2603:10b6:5:3ad::15)
 by PH7PR12MB8016.namprd12.prod.outlook.com (2603:10b6:510:26b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.19; Fri, 23 Oct
 2026 15:41:05 +0000
Received: from BL02EPF00029929.namprd02.prod.outlook.com
 (2603:10b6:5:3ad:cafe::8c) by DS7PR03CA0280.outlook.office365.com
 (2603:10b6:5:3ad::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.19 via Frontend Transport; Fri,
 23 Oct 2026 15:41:04 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF00029929.mail.protection.outlook.com (10.167.249.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Fri, 23 Oct 2026 15:41:04 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 23 Oct
 2026 08:40:33 -0700
Received: from xinmengs-dev-vm-linux.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 23 Oct 2026 08:40:32 -0700
From: Simon Song <xinmengs@nvidia.com>
To: <dakr@kernel.org>, <acourbot@nvidia.com>, <kvm@vger.kernel.org>,
	<rust-for-linux@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
	<linux-pci@vger.kernel.org>
CC: <alex@shazbot.org>, <jgg@nvidia.com>, <yishaih@nvidia.com>,
	<skolothumtho@nvidia.com>, <kevin.tian@intel.com>, <airlied@gmail.com>,
	<simona@ffwll.ch>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
	<boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
	<lossin@kernel.org>, <a.hindborg@kernel.org>, <aliceryhl@google.com>,
	<tmgross@umich.edu>, <jhubbard@nvidia.com>, <ecourtney@nvidia.com>,
	<cjia@nvidia.com>, <smitra@nvidia.com>, <kjaju@nvidia.com>,
	<alkumar@nvidia.com>, <ankita@nvidia.com>, <aniketa@nvidia.com>,
	<kwankhede@nvidia.com>, <targupta@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <zhiwang@kernel.org>, <zhiw@nvidia.com>,
	<boqun@kernel.org>, <daniel.almeida@collabora.com>, <tamird@kernel.org>,
	<work@onurozkan.dev>, <jgg@ziepe.ca>, <bhelgaas@google.com>,
	<kwilczynski@kernel.org>, <dri-devel@lists.freedesktop.org>,
	<peter@colberg.org>, <xinmengs@nvidia.com>
Subject: [PATCH v2 02/12] rust: pci: expose the VF index within its PF
Date: Fri, 23 Oct 2026 08:39:57 -0700
Message-ID: <20261023154009.2246627-3-xinmengs@nvidia.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261023154009.2246627-1-xinmengs@nvidia.com>
References: <20261023154009.2246627-1-xinmengs@nvidia.com>
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
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00029929:EE_|PH7PR12MB8016:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ffafc72-ea17-4adb-55c0-08df311c0c2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|23010399003|376014|7416014|1800799024|6133799003|18002099003|10067099003|22082099003|56012099006|11063799006|261022105027099003|261021121427099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	A3rEypZK0LBYFKB7RUnEhGF5xPft6UE4CrEJMvPtzFT/+h4an7Jum2MAYC45ao+g9IRzk/wmX+10DzIxuov9uGbakaWuXkrn8d9FcilxUISKTz17CoyXDEMyrLRVt0xbwSIR3qMwBtfq18ewSmyDxq0f3S/+gFugVwvFKfjgsPD1inv0+9UdWzINO1Cwm1Y9LDVnqgGsb17DbM9QHyjIzH4fG54fdIL5cE+GtXP/vQeVlUli7H5OdJwIwuOb+QgFrWtD+LTCIy8sPqUqEShqWqWlunVx2yIUbGOgeR9o/ZWK7/UNCL/opW8A5ar2TWN7Nz8v+QHt8Z+R6nYH+9HIo83Rr8Z1AYdIj2iZ9XQMy/In6JtYDDSo2drbkA01Mmv5zGM2ZCTwEJhEx693GRlvmu++eWpoSwV0n7hxsV0uRaaiX55yvI3qXynPBoV8ERnWA3BlcTOLO5/QB8vZGbcDzJpyOkP374cskyrAcurPUdMcpf9x72x8WJFuN5bgi0HLy+rgoCzzo0u3dJWb/a03wHio/fH8Owp3/qWyYYlnJ0P+zWI8XTXuLw/4TtJgO2hQBvIxknVeuJQxQsJ9tON5PBnXYNSWNz9tNaibISithgPQqjU3EnqSiHLLv3eusNKG48o54L4q9p0DLXmpCVxPbwoJ6w4P3DK1fKRIL7LE4Jth4O3gYqiUPMMcu2/u+7BqThrHxZRk9Czq60Aq8wc+/g==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(23010399003)(376014)(7416014)(1800799024)(6133799003)(18002099003)(10067099003)(22082099003)(56012099006)(11063799006)(261022105027099003)(261021121427099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	EyNX0hsoOAMDadMQLJFefPku969vWF/7xURJZW85PpOiPRdP1+zw4j0YgM6W5swFE0m2A+AS5mKmuKTTHW7bB31MESXfMxfxzUlOnz7dKhkNLMMfhKg+LIMog9D+ccbZIuJRu7WEmO1jO5SWf2pReNadd7dLC9+n++DY/GDQbGDIZVzO+llLDhogMMOXxE/yR8WL5O/KM6nJGETe5qc9lMMFj9PRkqcTh6DbHK+6Bmh5lc3oqLfQVEgvX0YJMJ1h1wgA0y035FQCrcmCKCWkRli9GZTmlrEkXllPgARHbXfkVyqIEZQ2Qgf2YQTqXOnwv5IYl6UAi+I9jB7E0aEnfY+ZTiqjoy0nkDZ0o1Ozpwa533z1w2wnamKwmGV/s7RwvkYDqFT9UQZoaWwr9MLHjPdE+QhKGPqxupFX4FBOZ64HCmM6FxxcdK8vhycxVxbZ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 15:41:04.1232
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ffafc72-ea17-4adb-55c0-08df311c0c2b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00029929.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8016

From: Danilo Krummrich <dakr@kernel.org>

Nova identifies a vGPU instance by the VF's index within its PF. Expose
pci_iov_vf_id() through Device::vf_id() so a Rust VF driver can obtain
that index, with an error for devices that are not VFs.

Restrict vf_id() to Device<device::Bound>

Suggested-by: Danilo Krummrich <dakr@kernel.org>
Suggested-by: Zhi Wang <zhiw@nvidia.com>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
Signed-off-by: Simon Song <xinmengs@nvidia.com>
---
 rust/kernel/pci/iov.rs | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/rust/kernel/pci/iov.rs b/rust/kernel/pci/iov.rs
index 9d9bd3ac702..76b2e395ca3 100644
--- a/rust/kernel/pci/iov.rs
+++ b/rust/kernel/pci/iov.rs
@@ -329,6 +329,14 @@ unsafe impl<F: ForLt> Send for VfRegistration<'_, F> where for<'a> F::Of<'a>: Se
 unsafe impl<F: ForLt> Sync for VfRegistration<'_, F> where for<'a> F::Of<'a>: Send + Sync {}
 
 impl Device<device::Bound> {
+    /// Return the zero-based VF index within its PF, or an error for a non-VF device.
+    pub fn vf_id(&self) -> Result<u32> {
+        // SAFETY: `self.as_raw()` points to a live PCI device; the helper checks VF membership.
+        let id = unsafe { bindings::pci_iov_vf_id(self.as_raw()) };
+        to_result(id)?;
+        Ok(id as u32)
+    }
+
     /// Internal helper: reads the `vf_registration_data_rust` pointer from the
     /// PF, checks the `TypeId`, and returns a pinned reference.
     ///
-- 
2.43.7


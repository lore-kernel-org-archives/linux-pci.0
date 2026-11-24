Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.1
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795528954;
	b=G3ip+BT46V+TJxbrqWKzUn2g/sAt9ewBfO95X/A5+GhIwa8VpvXkwEFzEcfrYDQfNd0N
	 1jDYFzwruAshsFs/JA6TlOkgTFSowNgpGtmzaJTIgsTFkPiIwKDHu5Tp3KSw4gGguVb9s
	 15JLZfkaNDVPBn3KmXKdujf9FhAuwz57FeTC6DQ5e5iSlDd7x9nRpIiSOHrD9twyRqkuI
	 H5TKZQntldJRmgzij6eD+9XX6/9I3/zA+v+FVELdeP5yk6MDw+0IhmsUGPv1AR13LRK1Y
	 aXhePswscxEyjQ2RxUCql7B+OZSa4qs7jyuei05/GTLKTmRPcfgK7fNtxS870JzSzdg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795528954;
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
	bh=cFSWRvD5RAkgG/oTWMoMy+AZgFQGFZqMVtOkqIkTNLE=;
	b=rx/2e+OeQoVWKR5lka1B/9ggmAMTIQyeOBq2/ok3E9QV5redqEtSBgwkFS7qxx5QE9LN
	 ovpFwWdjbwzz6NRycN+YhPrX80LLfTW2aDAGHiebUwP0/QVvS4uTwD0r6k85URmDEKQ1F
	 NjYgNN4bniUi5YmDfTHxRSPQnOubi+FPX75w9xI91WNztGu/pzu7zT0BZ5awMFe+aCo+4
	 vqTO0hmpcmgGDhDFSZ2vxZxKr5t5o4Pe9TXRAyJtnZkxGh0OEL73yBY5ZgI4Zj12BSfHx
	 zOylKmUM8Q8Yv8g1l8Um8D8VJ151EQk9HpmbBsyHIQ1yuoxCi/iMxdnsGBLT1ZxZW4Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=NWVa5Er6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.1
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010001.outbound.protection.outlook.com [52.101.61.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB3B60A2624;
	Tue, 24 Nov 2026 14:02:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EDB3B60A2624
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=NWVa5Er6
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=olmR1G75aBU/h0Ewxz6sztbMnlPC+sI9sC0JBgoG5d3T3GDMRHDPIU7q6lr/JAkS+QBc0wixbIfixFQBRKkCr3rL2SlUg5pykrH7c5yWJ24YIwMiqrbBDPr0dDqRdQgcj8DuU5YsyU7y+ZuQtY5GI0LkMsIPbHD01sfV6BybatvWSBl/EPIJ3sHkprDB0m6r9+Mgavnvup3UM8nAjPs8jRMnf3u3KuuSiHhEFUPboWd4OYMQvPnMasOH5bRPPXiy7gifDuuXDLlKKXi1AHjuYDHKiZlYIdzraI5phk9uXlUZ4FJZgbaNOfM0m4+1wRx8iJmNmMdkk+uz6gioQJtTWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cFSWRvD5RAkgG/oTWMoMy+AZgFQGFZqMVtOkqIkTNLE=;
 b=wO9ciZs+yan8KirCy2DM2RS2aE5ULcR+PQvaBIiwwJ3uR25deAOxXXh/zGj2zworSiLjtyNz0Mf6WF/W0eazfbXcR8QLk0Zyw2S/0K35Ee4HuVKhRYMf+2jsy/cWyWTrDeCLYvnGPl5HL9SSykpAJJxVt/KA7SX9DRPHXt7WJ1MAOdnBa/W7x/04d5f0ArVI34mL5/lQkCgNbrOqXRV5N/wcxh3pSwNct/LEFnwhQcHuY+nnHdZzZfIiVVnJCY1whkcY+gqj7Rbb2skdXhtxg8ZLoN+qle9dq7LylN+0mq9Ekv0mL9B/gGFhA/I+bJqWoG4oM5DMRAI12hiwFIohZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cFSWRvD5RAkgG/oTWMoMy+AZgFQGFZqMVtOkqIkTNLE=;
 b=NWVa5Er6N0MpDHC8yTtK65wqEfgMl2+Kjtdr7QlTVsnj5RNdyW9Ssd5xFXKsY+ZqK+r6OFlgJmDE+WkMK7k4x6G5SN4KKSH+enCosnSnJlDZbC+Lw76R9ekoXB1DrUSdc8t4Zz/Wh7Nahp5Nvn2Lh4jXj/Pvkl3plqKOsrvPw4tFa+IjugP6tyxd9E/Ryv6++AqBk/XP/BcROWhTSFn5TgNfqi5l0mfz8v0H2gKgccwzqYtRVbS8KHdE8IVmq5GIwpc0gD0h0r7URSAhhcBKquT3AYEek6T47FkiBdiJx0eGDstvNJ7vg5TD/fqU912Pb0Bs9aYPstzhMpoFfEtb9A==
Received: from CH2PR03CA0009.namprd03.prod.outlook.com (2603:10b6:610:59::19)
 by SN7PR12MB6690.namprd12.prod.outlook.com (2603:10b6:806:272::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Tue, 24 Nov
 2026 14:02:20 +0000
Received: from CH2PEPF000166BC.namprd04.prod.outlook.com
 (2603:10b6:610:59:cafe::8f) by CH2PR03CA0009.outlook.office365.com
 (2603:10b6:610:59::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.14 via Frontend Transport; Tue,
 24 Nov 2026 14:02:20 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF000166BC.mail.protection.outlook.com (10.167.252.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Tue, 24 Nov 2026 14:02:20 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 24 Nov
 2026 06:01:55 -0800
Received: from kalok-SPC741D16QM3.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 06:01:42 -0800
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
Subject: [PATCH v5 08/35] gpu: nova-core: vgpu: reserve the 48-VM WPR2 heap
Date: Tue, 24 Nov 2026 19:29:04 +0530
Message-ID: <20261124135937.18583-9-alkumar@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF000166BC:EE_|SN7PR12MB6690:EE_
X-MS-Office365-Filtering-Correlation-Id: d24f6719-af90-4d22-043a-08df4a338e64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700016|23010399003|82310400026|260925022911599003|261022075727099003|260925021311599003|261026140227099003|11063799006|261021123027099003|260925021911599003|261009223027099003|10067099003|261021121427099003|261102123227099003|56012099006|261028144727099003|261022105027099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	0lOW4eMYWMCeYkq0DCBCNnKTALH++wS7/vdfUxhDgPMSox9wnN6vWcIPGEXXoPgYdF3cTiKIG6NiZEwHzBlH4DLXVlVipxJN7ON0gziWedYuREmK62MQkJ5JJroLr7Y0bMS3tkDFs4wdBtvxCmcE7MI3uuNNyHnoE1G/g1FXZewpvehRnIn2CI5MGfVXdL+m+V1ug8BZ+h9zatvvDDih/QT9JKJuUuJYLYylwPR3cUsWXkSvZgn7T6JqcZC02JWxFtbuY8ZjDVv8bRKIfwv2PKSX2aaWvoCqpwa3syOSumNiPxcdyPi6mRX/kFnzxuQXzoy4cP0356+OsFPtxIExrbuoYZHoxE6Jx7eilyKvxXF8Xg7FcwvOJ+a/dGA/NS0NnmzN68ApRB0UwK6Zd7gT8VVzivdnmAGeIFbk6LgdboK60IXhefY7JgnhwDRNEyhs6U8aW6xBZXmwQ61a+qK2yCTnS26vDSCsBYTwtdYnQJDKjaVg7mLU0higlv840dVwQNb6g/1AdJhDHl/HrmYvkj0ta1fkrUWLOwASi6SH0wVPsQwGzWAep0Av3HuGgefZKFHEVSdUy86i4nOeFyc0MeAUqG5lRBCqocNUpBVzEBejAIbgR/699ZjXZtYEINzz1vpTtUmhESXMAu2MNrNNmQHF795OTsa6sdEI21L7ZouEgVFcsEIjqcvHY8BxZSc6oIFx+vjaEuqkst31pWi2lw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700016)(23010399003)(82310400026)(260925022911599003)(261022075727099003)(260925021311599003)(261026140227099003)(11063799006)(261021123027099003)(260925021911599003)(261009223027099003)(10067099003)(261021121427099003)(261102123227099003)(56012099006)(261028144727099003)(261022105027099003)(18002099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Q0oUFE/JUO2AbAF3nMm7D9bUqKVq5U+6/Tu+uvJ8Wul19tEujeZCnbzNdQHPAeNehfY2u8odHZFzj7SwXdojCMAVYpA2s/pAJLl4zNo/GW1AETbEcWtIVPWLproQZj7O44TIWPBO0ddEgroqCQf1PLsk8+/KETfFbJ8TmD8A0BHzzE+Am/U6R8P9kONfdYt3FaFU4+b79HGBd9rDGkSZH698CS0Z4BsvVZODydHYKNrUrWsjbM+J8lbp5Ms0YjlHb7j+iJhHS8upyEJyzU+vDnQ6X7Q5Q5guuduZNRdgyjD62D/HRa3d9IiGiB+PylPetQFjwuDDbX/ETksGvte6OSYuG6RvatjQW3dHw+cM+XymZxpjKU8p90YXscd9ySoSh3bY/As0SAMPITszo4xkXnEZCovDOLRCaT+EvFOzaf0NVTV6cq43Lrr0SeXGl/MY
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 14:02:20.1487
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d24f6719-af90-4d22-043a-08df4a338e64
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF000166BC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6690

From: Zhi Wang <zhiw@nvidia.com>

GSP-RM needs the larger r000 vGPU WPR2 heap on devices that
advertise more than 32 VFs. The default heap is too small for the 48-VF
GB202 configuration and GSP-RM fails to start.

Select the firmware-defined 48-VM size from the detected VF count while
retaining the default size for configurations with 2 through 32 VFs.

Signed-off-by: Zhi Wang <zhiw@nvidia.com>
Signed-off-by: Alok Kumar <alkumar@nvidia.com>
---
 drivers/gpu/nova-core/fb.rs                      | 2 +-
 drivers/gpu/nova-core/gsp/fw.rs                  | 7 +++++--
 drivers/gpu/nova-core/gsp/fw/r000_00/bindings.rs | 1 +
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/nova-core/fb.rs b/drivers/gpu/nova-core/fb.rs
index 882827bcfd3a..ba68a812b095 100644
--- a/drivers/gpu/nova-core/fb.rs
+++ b/drivers/gpu/nova-core/fb.rs
@@ -302,7 +302,7 @@ fn wpr2_heap_params(ctx: &gsp::GspBootContext<'_, '_>, fb_size: u64) -> Result<(
         ),
         VgpuState::Enabled { total_vfs } => (
             u8::try_from(total_vfs.get()).map_err(|_| EINVAL)?,
-            gsp::LibosParams::vgpu_wpr_heap_size(),
+            gsp::LibosParams::vgpu_wpr_heap_size(total_vfs.get()),
         ),
     })
 }
diff --git a/drivers/gpu/nova-core/gsp/fw.rs b/drivers/gpu/nova-core/gsp/fw.rs
index 6e44fe14b2f4..46d3605b24b1 100644
--- a/drivers/gpu/nova-core/gsp/fw.rs
+++ b/drivers/gpu/nova-core/gsp/fw.rs
@@ -137,8 +137,11 @@ pub(crate) fn from_chipset(chipset: Chipset) -> &'static LibosParams {
     }
 
     /// Returns the WPR heap size to reserve when vGPU is enabled.
-    pub(crate) fn vgpu_wpr_heap_size() -> u64 {
-        u64::from(bindings::GSP_FW_HEAP_SIZE_VGPU_DEFAULT)
+    pub(crate) fn vgpu_wpr_heap_size(total_vfs: u16) -> u64 {
+        u64::from(match total_vfs {
+            2..=32 => bindings::GSP_FW_HEAP_SIZE_VGPU_DEFAULT,
+            _ => r000_00::GSP_FW_HEAP_SIZE_VGPU_48VMS,
+        })
     }
 
     /// Returns the amount of memory (in bytes) to allocate for the WPR heap for a framebuffer size
diff --git a/drivers/gpu/nova-core/gsp/fw/r000_00/bindings.rs b/drivers/gpu/nova-core/gsp/fw/r000_00/bindings.rs
index 454d0ea9360f..fa17d3e2edf6 100644
--- a/drivers/gpu/nova-core/gsp/fw/r000_00/bindings.rs
+++ b/drivers/gpu/nova-core/gsp/fw/r000_00/bindings.rs
@@ -84,6 +84,7 @@ impl<T> ::core::cmp::Eq for __BindgenUnionField<T> {}
 pub const GSP_FW_HEAP_PARAM_SIZE_PER_GB: u32 = 98304;
 pub const GSP_FW_HEAP_PARAM_CLIENT_ALLOC_SIZE: u32 = 100663296;
 pub const GSP_FW_HEAP_SIZE_VGPU_DEFAULT: u32 = 609222656;
+pub const GSP_FW_HEAP_SIZE_VGPU_48VMS: u32 = 1436549120;
 pub const GSP_FW_HEAP_SIZE_OVERRIDE_LIBOS2_MIN_MB: u32 = 64;
 pub const GSP_FW_HEAP_SIZE_OVERRIDE_LIBOS2_MAX_MB: u32 = 256;
 pub const GSP_FW_HEAP_SIZE_OVERRIDE_LIBOS3_BAREMETAL_MIN_MB: u32 = 88;
-- 
2.53.0


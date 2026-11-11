Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.22
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794436483;
	b=TwxO/sYL438YRGIPoKvnaHAuMbOu/itoRRa57olLG6s2mHdmr9PncOy9DfTOx6h9yUrB
	 zpBMLsHyq9npNP4hlyqalRv8D4ZIX5nDXFy9Ah7L72i4XTngGlt2tiHXR8HTgljVDXeR4
	 HpPzh0LgGCEt6PYwRACli41cG4pBC5ZVwzsy9yPsRRFqoy6VeA8xHS0WMN/leH0o7MOb6
	 UIFVXfZi8ryHJXIthtMopJ9zVe/ne6Lafiz8ygOnshhnS53Vi1CV0l6oKjpo/2xyukhgl
	 /TOEe6uOlC5awP2bOJATLLLa1w1yBP7hrpZhgQgEyujrXMx09Nm1Ly2GWaw9VVGE8hg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794436483;
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
	bh=nA7kMxGWXFFlxZo1EfxqHW/LlkhDgI2pHwHwHwzYjR8=;
	b=Zd9jai3m78eUOi79CF4FH0FpKQ9QbbmsEfNA024W0ae+ZGgorE8k+kXODZKqRqIUt9z4
	 1w1oQVMBCCfZnsE+Pv2TVsCiWg7fu/Bi8zQlaP/WyuMUFN2eJUwgtgTOKNnpqQ43XdBn8
	 5x6w4eKdMEhR6omW91NXpyMp6ReIiZD/66d83GvY7BwypXezqzNMRHJF1Q5vRqt8YSv7A
	 UmOCcremCNpT10vT/607GDGHp1e+NMdAG0pGOY8bLrAr2xYSnvlflzCiHNR+/QbvHAyyJ
	 7YbhyRNgdntgQzt9yDPtyfwlsX7gUZgUI6/5aEDgG0rj3c3A4UCPIcKKEPUBxy8ZZyA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=txVkKFqa;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.22
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011022.outbound.protection.outlook.com [52.101.62.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A117160A2630;
	Wed, 11 Nov 2026 22:34:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A117160A2630
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=txVkKFqa
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KTxddJpTr1amnEcE9biUw1WcSCYhQm6UKLDzN1nWRyzs6/DhS4HiYttvlO4CfHTE4lNLi3Ni9TAdcTw64TvgfnnFaJAB9hO1ZbT9cO5TWNejLYWJLX31W9JSYx2ZQJu8niZzbo/RmrqGb/4+A3LEAfEM+l3urgPwLgwzTXP2wiFNM1bbfshbfmGRBrW5LCNkvsDFs6GqCm5SwX81S3P1TnqcRUvmOUOnKNXtim8puml3AfhFDswKhLWKjiKrLxCFDjbNaih68WSaxh/O2GvF2pW+lHmHmSyy+rGJld8HOrVCUfxe+WweoL0ZSMRflG7AfIc3RIZwQ2TFtMRCRUajMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nA7kMxGWXFFlxZo1EfxqHW/LlkhDgI2pHwHwHwzYjR8=;
 b=SvLVgBvptIt82OB5lJbo3ouqclwlRipc84C8Eg7wa0IIcTvMzKClJT6MI6bYsZUZD5QSaB1DcaC1spkoDjpYyrhLlMPZpIpUcjKjAP3mEdgNkqQy6L06CS70MlcLPG1d8MnT96La6yXJ2SV4Xn+iPFcpYDJIxV/aYsGuEcOwRIV9i1rkBrEzkfcaRV2SHNRbNnULRLA2OJW+XbbEMqzZm5CzekkJJ2xrVZWWR/gkajuhyWc78E1QkqbvgJI9HURGwmvQFroMjjn6gYC7c67PnSn9+bVRkjhqp+pusNEAch2pstXXU23lyYde4GmqvHMVi6kxIPh2d/l+R0RvlfXYpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nA7kMxGWXFFlxZo1EfxqHW/LlkhDgI2pHwHwHwzYjR8=;
 b=txVkKFqaNhSh19FqOfO/udLEl8+zq9EBFv+o07qPDF+R+cvhwE5jE8ipjnoF+vsUg0eJXX/ouodYeWnZPHEhSOGBC08U9Zr3jH8yA1m8MISUfluWCZ9fnZAf88RlLNXvaysjvLlQWEvzJGkhn6ScabUqyN7RlVi8cM+1XXKTR/zhs5I36ciML1yYZ66/p368sGt5mltuJNd0LjhB9u0NKtmbmNSm+mkDAalehFc/vaScX8oTR9jwgF/i9gHx99HmAnIDYiQp6Q0QInIHLUfCjvlQJMu770hSysPhHaDfMOM/ZUQR5yKSB1kFU8Q8oGaQwvu95klnfxj6SBeXSXCoTQ==
Received: from BN9PR03CA0265.namprd03.prod.outlook.com (2603:10b6:408:ff::30)
 by DS4PR12MB9562.namprd12.prod.outlook.com (2603:10b6:8:27e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 22:34:26 +0000
Received: from BN7PEPF000000A0.namprd04.prod.outlook.com
 (2603:10b6:408:ff:cafe::6) by BN9PR03CA0265.outlook.office365.com
 (2603:10b6:408:ff::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Wed, 11
 Nov 2026 22:34:26 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN7PEPF000000A0.mail.protection.outlook.com (10.167.248.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 22:34:26 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 11 Nov
 2026 14:34:04 -0800
Received: from xinmengs-dev-vm-linux.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 11 Nov 2026 14:34:01 -0800
From: Simon Song <xinmengs@nvidia.com>
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
Subject: [PATCH v6 03/11] rust: pci: add is_virtfn(), to check for VFs
Date: Wed, 11 Nov 2026 14:33:28 -0800
Message-ID: <20261111223337.508989-4-xinmengs@nvidia.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261111223337.508989-1-xinmengs@nvidia.com>
References: <20261111223337.508989-1-xinmengs@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN7PEPF000000A0:EE_|DS4PR12MB9562:EE_
X-MS-Office365-Filtering-Correlation-Id: 708c0d08-d56e-4edc-3027-08df4043f15b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|1800799024|376014|36860700016|7416014|56012099006|11063799006|261022105027099003|261021121427099003|261026121527099003|261026140227099003|261102123227099003|261028144727099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	vQpftH3B2dc7npLxqqzLlP5B2ea+Pisyr+wiB69CNEZRLjSwtFI1+aHdHk6p2LXwf+kE/zNk9uxHY1BAX3l74psdj8/wqJ7bBtL/LQ1XKvG7AXgZmSDxqr4+T1xa7HSv3xsd45hv9q1GnyXMgiS55DkGyslMocqCWv79IgJCSHO6lrnlQjqcrAMDTqHAKq1bP6KCw/CSKF09R+k9ehhnrOViaRRE9Z9i54RJqs02z5K9T0Be1zCUfj+mdV4w1t+svkuBF4m+mOyShSzaYP1ex6Dc38T7eElBiqbakXQhZl6lquvj5CVTj/OCjNEPWXoiIutLrzcE8ock60zpS1sW4DzTZ/n79bod8B+Dx1nsumZhXmor/btjW0wBdTTn7aBi1Nmd5RQBCIlSRFIjzzBtA8M10CF8A0IPzHHuiB5zVBJTODANTyMSrzg2JccwE8cjfmV41wimLD8Wfwi0xI6WvlZfV74wTFjF/8dzyMKQXSfq+IDhETVfvuRecukzVlc+xYh9xcSf3VjnoswOZs8XAbwNUVxi9GKwYRBTNDiYP2N1h7xSyoyYbua0cyqvn3Zb5c7qi3nLGtTEMNyP2jpyNqxZJbFYQt7YbaUURUrDZIdCWNdirgTPch219zv5Q5mQxDNieGpwQCMwsUeU5GTHZ0rhCKFG5gnVFZObozxgULj4jkIHWQdoZG2xA2UJkfZANblOKTGr0hxHmldvX3p68Q==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(1800799024)(376014)(36860700016)(7416014)(56012099006)(11063799006)(261022105027099003)(261021121427099003)(261026121527099003)(261026140227099003)(261102123227099003)(261028144727099003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	GVh5bjv691h3pP2iX4YCiifvw4+1/B9LpVEePtlYKS8+qRBcP2ZE4eawFH0/nHgLN/HW65sS1iJdQ47s9ZLzAArVu5Ylg6BMGM7fcwaewOqZqoyZA+8vqo0EPGcDSfdINIabLTFXdTw+xHUlGsulBVPOKwAirjOz8s5Z419fk9wkk6VpskiFYGG119+vSsmK7JvMoIkwoOqG5F2eFgnXDk/1I5FS5QsEufoHtj/VXPfwYj4WeFVEZDFgumktmKVsOHn2MLaqe1XzsJDUZvt7LE2hnuhkym8Uo0R7dXrWpu3eUKBuFtR94phtc7yE06sxGcJhdnWQZxMConeFF66F7fE6K+HiHUu79k/NcQoTFxSdVgL5+RI8Vf7yjGvtF7BdPU4JZkyO1D8FRQKBRmVFRcyVtnzFHfRWZAM12+ap5935OzfxNxFL3Yzb9lIR7IrO
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 22:34:26.4799
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 708c0d08-d56e-4edc-3027-08df4043f15b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN7PEPF000000A0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9562

From: John Hubbard <jhubbard@nvidia.com>

Add a method to check if a PCI device is a Virtual Function (VF) created
through Single Root I/O Virtualization (SR-IOV).

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Alistair Popple <apopple@nvidia.com>
Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Peter Colberg <peter@colberg.org>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Simon Song <xinmengs@nvidia.com>
---
 rust/kernel/pci.rs | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 4d32b55779fd..9e31b9bb4d0d 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -362,6 +362,13 @@ fn as_raw(&self) -> *mut bindings::pci_dev {
 }
 
 impl Device {
+    /// Returns `true` if this device is a Virtual Function (VF).
+    #[inline]
+    pub fn is_virtfn(&self) -> bool {
+        // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_dev`.
+        unsafe { (*self.as_raw()).is_virtfn() != 0 }
+    }
+
     /// Returns the PCI vendor ID as [`Vendor`].
     ///
     /// # Examples
-- 
2.43.7


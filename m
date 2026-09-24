Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011044.outbound.protection.outlook.com [40.107.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB7D34DB56;
	Thu, 24 Sep 2026 19:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790276851; cv=fail; b=NaCawiJGDrBMJKsuPFbIj+KGW329d9bGPmyUNUR62X2H2aRu5XzihKMvJwdcYyBRGt8SfoxsE8YX9SxUua42iS3vOrplx4Nl+aL00JJ60/5ZfwXw2T7KONeZZA8AB4zb/mX3rg9f6n304X7J1HRkYN1QZ/MzN3Okb/Oh4GMAo9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790276851; c=relaxed/simple;
	bh=Q5wSfVryd8HuQWa25zGJl8Uo+ebV4iXvLs6TwF9v0SQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MTNiCRzU6hLEPAnW0cOaK8dktGCnOwpXUKDzPZRzEhHKGcimpXiFi66BSKwWcVq0nntOnuG1wGsyvvNPwD12ubfAQ/Nw80ayIXbI34oV/653QKqejvC2Z62eNwR4L4nrMrll+caaLpc7J3Xy/kDgQ66Jp3lD3vZGJTWFKuTcyOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jxScxVDb; arc=fail smtp.client-ip=40.107.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jxScxVDb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TR00bXKPfXS+MCjvC6qgUtMMsAHFZnWik8IWl9N0iJwLQX2inddldvpPSiZiK038UfV591jEQrAq2TmqebCeB+vKCbcZmfLtnmIbGqnnWDZmrTqfXyJvRHOVmXgzseut7G8aXacfw39mJlvNwhJ0JghvxCJ3GaESmuws2AnqaIelH1JUTHthf5cEdPLX2aUXDG+/Hae5QypCUBoquizSgvTliTd5XARf4T81ZNCm+esgBIb8dBTzEazDRRvIyemiVIZEyhszFKCrk/9XCbj4kDJjENysi20o51zLC+pxQb3JKAxZ0TyNGNVLVn06tjIuqUZkaQDhqZutFsHTUTtxTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y0lzOpd2G06u9CQRr/UyTRKpzAJvPOeEklzmW1CCYIU=;
 b=Tz8x5rS3Zc+G+l66t8f7dSpZi44GOVgge4g4cIAk5b7r8zAxtOyF6pT+HFEt0TqJtZJM/8jbvMVIa086dX7rYSpTPMNeOiz5/IWGXEREoCSYKwm9KVOxjm1p0BG12dzdz1Lyq8nlvDZTHv15Xu/i3SguIItbtCOMW4NWX/SuMs+sQz/yoqULWGMj4CiTEaqlmYUhYJWSd6FPsOHhltsNG9gLJiS9bQ0nb/U/1ll1/bYuuD5vI3HCCCEU939bcngSHDay4+m9ecIQOUbnjGOpvEVX4U5I/qkPCUOuBYNLBZBNwEC5aaTQ39Q6myrQT4qLWKn/4qfQMN4BX732zm6OyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y0lzOpd2G06u9CQRr/UyTRKpzAJvPOeEklzmW1CCYIU=;
 b=jxScxVDbzE8TdpxmFGN1L5opkcSFEXhxNkgdhAtqUKeQrYokE1tfZx+FAe5GNrPD8T4Yeq/rsocpSOFXXodD04Fjq890L91oFOagT11ncYFlVL04peI1K8jm5ZPp9A+6g3FELYRmYfyTWFKAII0TXi701IXzOQWBhGazjXWZAl1occD20xNz5Z0TTk872WKF/JhIsAocQqmJscUZqvxR6N4xnkECabxNJYMEmNvH0SMGnbJW6zo/eBzM0RyfAhGhdhJJud7IoGBepws/VuKVVG4FR4wz+XstVIkxlPsZbne1RZi5yb9Dma6vSoO+NeOXrFIxWb1kokoxjYLGRfRFlQ==
Received: from SA1P222CA0182.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c4::20)
 by IA0PR12MB8896.namprd12.prod.outlook.com (2603:10b6:208:493::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 19:07:23 +0000
Received: from BN2PEPF000044A4.namprd02.prod.outlook.com
 (2603:10b6:806:3c4:cafe::a6) by SA1P222CA0182.outlook.office365.com
 (2603:10b6:806:3c4::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Thu,
 24 Sep 2026 19:07:23 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000044A4.mail.protection.outlook.com (10.167.243.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 24 Sep 2026 19:07:22 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 24 Sep
 2026 12:06:52 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 24 Sep
 2026 12:06:52 -0700
Received: from inno-dell.home (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.49 via Frontend Transport; Thu, 24
 Sep 2026 12:06:42 -0700
From: Zhi Wang <zhiw@nvidia.com>
To: <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <dakr@kernel.org>, <aliceryhl@google.com>, <bhelgaas@google.com>,
	<kwilczynski@kernel.org>, <ojeda@kernel.org>, <boqun@kernel.org>,
	<gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
	<a.hindborg@kernel.org>, <tmgross@umich.edu>, <markus.probst@posteo.de>,
	<cjia@nvidia.com>, <smitra@nvidia.com>, <ankita@nvidia.com>,
	<aniketa@nvidia.com>, <kwankhede@nvidia.com>, <targupta@nvidia.com>,
	<kjaju@nvidia.com>, <alkumar@nvidia.com>, <acourbot@nvidia.com>,
	<jhubbard@nvidia.com>, <zhiwang@kernel.org>, <jgg@nvidia.com>,
	<alex@shazbot.org>, Peter Colberg <pcolberg@redhat.com>, Joel Fernandes
	<joelagnelf@nvidia.com>, Zhi Wang <zhiw@nvidia.com>
Subject: [PATCH v2 4/8] rust: pci: add is_physfn(), to check for PFs
Date: Thu, 24 Sep 2026 22:05:51 +0300
Message-ID: <20260924190556.1620886-5-zhiw@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924190556.1620886-1-zhiw@nvidia.com>
References: <20260924190556.1620886-1-zhiw@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A4:EE_|IA0PR12MB8896:EE_
X-MS-Office365-Filtering-Correlation-Id: 4570c9d2-9c9f-4516-5da7-08df1a6f1071
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|82310400026|7416014|1800799024|23010399003|10067099003|11063799006|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	O0IT3JVkPSLnGvd3Hnrw5jdJn0TcKJDLALK7xolOa56zwWYCGc7hdvRAlOt/fKOyfzds9H5fNA2nUykJzsa8av/9Ej+GOW0k06cjf0S5i11t62WDIhDs3S0ahWgZEHfKc8wpJm0pSem8URZsAV+zuqJp/csIC+JjQ8+pTbX3i9EyIvDLYHEMtW/vIAG4fna6yb3bCn0Lck3iezxoiAXGwmNBc+UhhLwO2mU7QYX7sOI9FQGFRG1RZ0xGeSpu4GKi41A2Tvd+AWRwHbfYPZrTbtAQfKzeeWo9BsIBc+Ve0315/4AsRSzTj5qLpY/U/FqZPcIkt3T12ZxID1uwReOc+MMjFGyXpR44ne03wtYE8jhdY5ehLs7v34NgGpxG9EdgXekt7yYP9PKI98xrNyfb/9HfpcllbQZkX0dEHkX7Y7od6L8BDpA4x9MepHsfRGOtUSoJ7XQW45qCihksdEH8le/Fty/VnzqiNz14bnwCD8+Wm2NHAoK/nHIm3ankq1bjh/CeuVmKeRwIykYNVbrvlwq6yrE2DYWvRL0fVmbxiUlc4N2be7PggLEkjtfRavOJYyCYi+kvHh3EATWuHqTI3QyNVuQ7zEZ+MzrbJYY3rKUqQ1ZqDHwriLLtJaGfRsgsLWd53zAeCKNxa7MijkhXag8qP1PgJ9BpXSinyGQXy3iWPcKN4MzBtpWEVwYaXjoeODdN3E0/E30+eUbV/FpigA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700016)(82310400026)(7416014)(1800799024)(23010399003)(10067099003)(11063799006)(56012099006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	DWaOtMmHBPtuC5dmXcTKaAI5muCInDFUnhz0dGGjcQvETA+2qdJSEJ0oQCPAxbxj5zpn16MntSkNNZSSI016QGAycwf8E+eiTNkX5910nkjiMif9Rpe+8aAXEpvtK7S5sq6IePOuCTLBFrd9t0HUcNoYdotyyRHxaHq6c0PYhXCT4E10nYiwlLNGORHKW+kUH0kY8aUzOf475XTsm1X234IZrUuAl1hf5w64Lpr/Lj1mzfNSV7N4zHm8DkLMOffFBlc/OkoFGWZOhb1os3bNrAfVrLa37Ymrx0z/6NYjEHyOGfuxo7kxKJ3vcxXWU8RqbwpiVuREunxWSr18TcQb/G3UuHT5VR1bMsUefMvTJe8zQ5KFuxWQVk+oMZIvFWMOS+Al7N7K5tYCDr3HKdW75WPiNVrQ/CAsJalEuEFVcOrXm4khR6reztMmZVFxF5OL
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 19:07:22.7662
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4570c9d2-9c9f-4516-5da7-08df1a6f1071
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8896

From: Peter Colberg <pcolberg@redhat.com>

Add a method to check if a PCI device is a Physical Function (PF).

zhiw: Keep this role check private to the PCI SR-IOV implementation
instead of extending the public `Device` API. Add a dead-code
expectation because this standalone API commit has no in-tree caller.

Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Peter Colberg <pcolberg@redhat.com>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
---
 rust/kernel/pci.rs | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index b04f6aff6c34..ca009775bd61 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -433,6 +433,14 @@ pub fn resource_start(&self, bar: u32) -> Result<bindings::resource_size_t> {
         Ok(unsafe { bindings::pci_resource_start(self.as_raw(), bar.try_into()?) })
     }
 
+    /// Returns `true` if this device is a Physical Function (PF).
+    #[inline]
+    #[expect(dead_code)]
+    pub(crate) fn is_physfn(&self) -> bool {
+        // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_dev`.
+        unsafe { (*self.as_raw()).is_physfn() != 0 }
+    }
+
     /// Returns `true` if this device is a Virtual Function (VF).
     #[inline]
     #[expect(dead_code)]
-- 
2.53.0


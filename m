Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013001.outbound.protection.outlook.com [40.93.201.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2C3299A82;
	Mon, 22 Jun 2026 19:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782157522; cv=fail; b=IfxkLCi+k/8BMQPLJ7iNBjNQRSgHoYOdP5NW8Uvvb6rct7osfo6ioRBcUsrUMxC/3t0s668na8Tp3yi2Hv7dgUwo6l7yVfQGYjcwRbe2Sq1THLlCNl3d8o++MswpR53vx5tgm7na25o6ahlWh4qCwvLOB8x01MKgLwo9hOUtWTM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782157522; c=relaxed/simple;
	bh=5t+uZQOhy7cjHQ6nHGiinYMVu7Bp6YpXg1bYQhTIv9s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s9RO0jltpV3WMO6GTSOIvbC+pZ/giAsJgNnR1456i7EgYbrA97KUTwOO+leq1YEC127lBXPz8M9O+FR40oBv5Zn8kCHNU9XI9gGKyhC8HBaaq09dfL9It63blkjzZHeY9iL7NSCA/OQAEKoTzFw2Ew/+fTm4Kk1e+hTsky7ZrUM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Dx0wuJQc; arc=fail smtp.client-ip=40.93.201.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Dx0wuJQc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DzRY+nxP6gO72kwphc2APTva+hHjXzG19BoUxj6tQFn0Oh7AskA/dwHYBbA+wJm9vo8PcyMjqp4Zh1vAxdeOchn3d5F4undNLV9B+y5Box4jfSjRlQOibGtn09zJF99HVfurFNJLX/apLxSEI3GlVXIoe7H3va4ruwqXmaeVwqr6Pp96Q6wa/RGJU8yNAT1Li6C45V9fOlQGRisn1Kekzcn/uU0SJTJCesK4ZLXVJMarSmkRVHTewozJj8esGcChl4W5UtWjMnUMhXdO4mGTYSrPFtplJMFTXsVBpuVoiUTAsHBpkfbS0aDCjU2bNERUEnuaNM2RNaeZfObL67/2FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s6nxw+aQIAG5EDiWeJM309bB6ABxYMbkXweCxYk4Mlg=;
 b=Pj8Ar9UVaqeMncoz4dYQY6Qql6cafdYXlxbLAGrSbM7eLOMVaKPfwghWebngcB2eCzXXF3Y0LwSHmJGVXVpl8YUP2JzuGDSg9flPO2b+vcrbvtUmlrn+PgHw5OTmp/0zDat58DRLARTnuJO432SeWpK4+NmnuWTyr7wMAyc/r2zUTGQpVNq5HmxcPYiB3xNBKsyNG0x4JXSCBRi4DOp+KRzwQ9LoLkqZNJbx+7Xy2GXnQKdXgoW0hDEjY7GTG5sD8+B8rG6GBFTC1GDMmALXAZLB33tKFtDDfW2kr3/v0A80AbwV13BB6Up+cjGyH8cK1eRvBzuACCObmt1rkQvU8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s6nxw+aQIAG5EDiWeJM309bB6ABxYMbkXweCxYk4Mlg=;
 b=Dx0wuJQcPHw/VhEqQbf3lPyASN5SqVRSt6ItW9s2xTb+iBoOevgU8UEqF2YlBqtotrXYmZQ5zKal/6w/9xtsAEwOBMIWu+q5CyI+96FLWDvw43KMyMl8VUkHqbDLaqyUuvqWdU431akuFQw6fYpnAKEM6uAvi0g1I670Pdkso1A20E+CgC37Tx2IfrwJhH0KUtCHBBLi/BdpM+tC/GjwxH+bTzO5IxJj4+GpwBGiXHqqhYK7WifkA/unXP+a8xyGpjY2xdHi6Ay5Cey6x3C0M6GcKB2Exbcxpts5UEEwPOzuHs/1pdDl6YbF13KPrU3fgS2kpwYfv2Vh3dfujkcjvw==
Received: from BN9PR03CA0109.namprd03.prod.outlook.com (2603:10b6:408:fd::24)
 by CH8PR12MB9839.namprd12.prod.outlook.com (2603:10b6:610:274::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Mon, 22 Jun
 2026 19:45:15 +0000
Received: from BL02EPF0002992E.namprd02.prod.outlook.com
 (2603:10b6:408:fd:cafe::64) by BN9PR03CA0109.outlook.office365.com
 (2603:10b6:408:fd::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.20 via Frontend Transport; Mon,
 22 Jun 2026 19:45:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0002992E.mail.protection.outlook.com (10.167.249.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Mon, 22 Jun 2026 19:45:14 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 22 Jun
 2026 12:44:51 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 22 Jun
 2026 12:44:50 -0700
Received: from inno-dell.home (10.127.8.9) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 22
 Jun 2026 12:44:42 -0700
From: Zhi Wang <zhiw@nvidia.com>
To: <dakr@kernel.org>, <acourbot@nvidia.com>
CC: <airlied@gmail.com>, <simona@ffwll.ch>, <ojeda@kernel.org>,
	<alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
	<bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
	<aliceryhl@google.com>, <tmgross@umich.edu>, <jhubbard@nvidia.com>,
	<ecourtney@nvidia.com>, <joelagnelf@nvidia.com>, <apopple@nvidia.com>,
	<cjia@nvidia.com>, <smitra@nvidia.com>, <kjaju@nvidia.com>,
	<alkumar@nvidia.com>, <ankita@nvidia.com>, <aniketa@nvidia.com>,
	<kwankhede@nvidia.com>, <targupta@nvidia.com>, <nova-gpu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <zhiwang@kernel.org>, Zhi Wang
	<zhiw@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>
Subject: [PATCH v2 2/7] rust: pci: Add sriov_get_totalvfs() helper
Date: Mon, 22 Jun 2026 22:43:48 +0300
Message-ID: <20260622194353.1308872-3-zhiw@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260622194353.1308872-1-zhiw@nvidia.com>
References: <20260622194353.1308872-1-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0002992E:EE_|CH8PR12MB9839:EE_
X-MS-Office365-Filtering-Correlation-Id: a54aad99-2f58-4d8f-6187-08ded096c770
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|36860700016|7416014|376014|82310400026|18002099003|22082099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	2ZZL4bLhLyaaIfYglq+pl8svwEiEl6vPR0j8QNDgMkdJpFYsDDhdGotO5c/xkJodI5Vfkeo5k9nyGi358PDeShU+vJouK5dAkgY891m5bxuEXMyWcdiglR6kjufZ7EFjCrNuiYUM9mkZrl7+K6ufhcDcdvOqIVI7EeMFxQKotJrDtWoXsReImXohNpsdXhtgMub/MACKm36OqtlxoSFJz/98UjRH3D6uXyu6YC9EspASVXG5Cd7JpWLA76YhMNYtGzeapWp/X53l1vr2hJ7BNE657nPJ3BSICoEMKXz4hfubLpLKZQFM1MpIGIOtTFrTBgziZEIjOUzQcYhhjSEDTQvn0FAIL8/iTl0wKdSdGOdrrk5TcX1B+rKJWjSAqRbPPhe3mFN5uE9o4To6hbNzwB6lx6gnESMrnvZQZ4WWUF4NNpj2yJWEreQ9m+SDGttWN6+ndUGGAKLfH+0oihtDfjQcqXXautWoJREe4C6AT5o2jsCk2BoHLmZ3kF2cP+SHhVT46pjb1RcNl/xMyjv372VJgwtjp2086S5td//a9L/RI88ptNJkJJ0qmLh3Kv1OXjB67SbGg/T9MR8ZmYdIpUNB71nFQiDhywzLaYMyVF394Up2k8OCn0bq51KkltBs2b4sF967wj6fiZnnHZ2hyz7lNoUaOkMUGRk7bCX3PMWPVxfpNPtDKhBYCZYZurHVi9zvoBCyoCzbmPHeC7wHbw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(36860700016)(7416014)(376014)(82310400026)(18002099003)(22082099003)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	bu0O4RwlpQHHsDEv5h+ZAROnOhJ9VfAtGt/Anl9j5Q6YA3ivZ1f9GjPB/Vr3zEA2x3Tvwj13sMkYw0pS4TA8AJmL5ukNp63O6ZUICXuXMNSlRqXwN5Pxy1WxHyk7DHmLWcZ1ukqjLBxmCxl7LuagoVSvUwZUaI+bqHpLm55VrxjcdY2HS7VcM5IQR/EG9VivTE/FbUmx2dzaGLt/O8jSaj9LoI0DjLIcXZ2+6DDoKuG6oFjx16UBMJBORlEOzyx0MxOrLcTq8KM4edqWCElw7LO2ihgRVmD8hGi3NeR9Cdf8qQqOHmmLMd8UgP/DK3NXtzSpSchGIvSMvOv8fQpIJ9EBKV+luVerzUtAFleMWRqFIJJumP5lQYBG/aXH3b/xzw+3rD3hxy6w8xx5H89kMD/lPQru8Vd6a6hBKoeOC36VMeE4Hy7850hnZk311uBX
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 19:45:14.1069
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a54aad99-2f58-4d8f-6187-08ded096c770
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9839

Expose pci_sriov_get_totalvfs() to Rust PCI drivers so they can query
how many SR-IOV VFs a device supports.

The C helper now returns u16 and reports 0 when SR-IOV is unavailable
or the device is not a PF, so mirror that API directly instead of
modeling 0 VFs as an error.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
---
 rust/kernel/pci.rs | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 5071cae6543f..adcb99fd0a2e 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -450,6 +450,12 @@ pub fn pci_class(&self) -> Class {
         // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_dev`.
         Class::from_raw(unsafe { (*self.as_raw()).class })
     }
+
+    /// Returns the total number of VFs, or 0 if SR-IOV is not available.
+    pub fn sriov_get_totalvfs(&self) -> u16 {
+        // SAFETY: `self.as_raw()` is a valid pointer to a `struct pci_dev`.
+        unsafe { bindings::pci_sriov_get_totalvfs(self.as_raw()) }
+    }
 }
 
 impl<'a> Device<device::Core<'a>> {
-- 
2.51.0


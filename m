Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012049.outbound.protection.outlook.com [52.101.48.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D530382380;
	Thu, 24 Sep 2026 19:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790276836; cv=fail; b=elcYlhLfBPTooMr1MCEhfhm9NN+K2+dx5sVByDO4Pgn6QWbJfdSZjjibmfDzRFF54rs7Bee9aGm1BxM1Ota1sA7RHBL/FWD7mSRw+Cg5SqTkyWknLyObM9FPq4ZLWkn0Pd5lWqxJdP4V/eZD23x8yXqOexck3B9I0Afvn3t/H04=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790276836; c=relaxed/simple;
	bh=xwm+9/Cuk4VzmU96SYp5yyEq/3PKjzHk/+BAqgdzPGo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=li35r1aaD81nvaLC1nk6+z0Z7QU5KuG64zG4QeX0GtMle++mA9ht/Q0ba4w/fwUdTQn3BL5u6rMFUcKs4O5/V5M+NKrq6rjg/nMjgPggK2+f/kH0ImPmTq9XT1ds1wK1J2OD7EF9fuG1PNOgaueRqMBhX61jjPhiMqHnwvHA608=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bJlihB0m; arc=fail smtp.client-ip=52.101.48.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bJlihB0m"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xgkyfgPAFeApZjQOdW+NExEgYX/R0APomKVT7VNRCSQ9D9gSL+j5P1LEajC7UQecJEMvfUCSoNyKI/rK1rUe7avSs1Y3HM99IXizvQy4TJAaq4pWuFYYGMpv1iYePbNfsT88vT1XbMGE5RQ97OsPSE04VNC+j0TE6rSruxC6SF1h4/cMqB1lYrfgqLFph5DsT9ugLTerNwDe//NTaS6hxYI6ZVpnQY0L9q/HkZVyOdW5pd0c+cQKywR2vUwR62ywm8lx/j0HZVUkv1aGMKt1rJyp+stWk9K+sWRjsTEZKaK12kS4VXppZss2nLuUcJkMslVUjnJveCey0L1yRHjQqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pRCFtJKoF0s+7zF80Gjuk28/XggOa3OmzW9/aOQ0a5g=;
 b=oxoObQl0xFcqMSNzQFK0nEz+Zfg6ZsSfy5Usc+k48oapH0OZZ+drEl3duB/8+ImIbeKwYTb/FyxXsI1VTeFOfxpuCffeVSWOdtWGL8M2hDU6ManAk5IjYzO9G/n1CPDNUg6J5+CTmsE3uCtxPPT8KBt3uhxcwSJp+yWxZqzT7sqlnMUqUYT7xOHIniZiwTzSauIMd3OgVTsSlYulIgDq+yo53f4KFco7Uhwx50wkiO+407Geaap+90qlfVMIGwQU62GWJPDq1pFQYnUbpTbU6BTdmD99i3K5VcFilHz7oDdEuJ/rXlqR1ZImX3ngiWAm4Vwcq7Dc+Lanqutvvrhb8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pRCFtJKoF0s+7zF80Gjuk28/XggOa3OmzW9/aOQ0a5g=;
 b=bJlihB0mNlKecBhmfVRmjzu/9o7JXVWWSEgX8K1EQJHaJ7VLchMkSzAuFzdVjvP25bKkli1eGsxh3+I9+Y9Wjku1Y0hm32+R7eVyLQdp84HleU3F5deCko9lPwEmS3s9+jcxPWNn4iYNVTxenIXcxh0BhsUR+ZdSAKqwXYdBmkkbnwEcSjHOd0EFyVRIipCwoptux70i8Fzm/iEOdTKRHyIySriHz1TV89vSxlC2HsSYve+1QCZEmfpNcIXoBpl9G4QJiwS7WxXsT2NZ4NYMxqgXqAfVacZ/ENsskfz+YOGJKMZlmQvwcOc5ojynngp6kThZSHAGNR9eutnBDft/sQ==
Received: from BL1PR13CA0125.namprd13.prod.outlook.com (2603:10b6:208:2bb::10)
 by MW6PR12MB8706.namprd12.prod.outlook.com (2603:10b6:303:249::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 19:07:11 +0000
Received: from BN2PEPF0000449D.namprd02.prod.outlook.com
 (2603:10b6:208:2bb:cafe::39) by BL1PR13CA0125.outlook.office365.com
 (2603:10b6:208:2bb::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.7 via Frontend Transport; Thu, 24
 Sep 2026 19:07:09 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF0000449D.mail.protection.outlook.com (10.167.243.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 24 Sep 2026 19:07:08 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 24 Sep
 2026 12:06:42 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 24 Sep
 2026 12:06:41 -0700
Received: from inno-dell.home (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.49 via Frontend Transport; Thu, 24
 Sep 2026 12:06:30 -0700
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
	<alex@shazbot.org>, Alistair Popple <apopple@nvidia.com>, Joel Fernandes
	<joelagnelf@nvidia.com>, Peter Colberg <pcolberg@redhat.com>, Zhi Wang
	<zhiw@nvidia.com>
Subject: [PATCH v2 3/8] rust: pci: add is_virtfn(), to check for VFs
Date: Thu, 24 Sep 2026 22:05:50 +0300
Message-ID: <20260924190556.1620886-4-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449D:EE_|MW6PR12MB8706:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f28c723-e715-4256-534b-08df1a6f083a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|82310400026|376014|7416014|36860700016|56012099006|11063799006|6133799003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	j+L559AOaJwuY7JMrw9pyxxp43536M9Es/GYhFcOIZrT5BGIWAuSaYyl2c3CyobGTSkWBQzfdKZPhZ3TTgdF5qzRGyMqtOkHoeqg0WXI5LnzdmNiLC5QOxAbQebkrw07SJnes5GzFNE4vSTW+salD52jEUlWe5tQb5lJ1lmEn51beu36ZNLFy5UvI5EzR1dLsCNzE3DfRw3s85uKNHFeGqmO+wPHi+IW18XLlhq9H37hh50/0aGncx2ckY7QSj47M2tunLWTWrm0N6SWnKcV+WlATIysrE9fum54LZyWYAcHwLSmjslm+a80DxEY6ZwsrvfzDkrvHoH5Bax/2zFRZTFuIy5FYcv8dyweSlSZXTN4AFUx95bReK846eK0Pj+DVeEBgx7vzT5BuH1dlRfUipKW9ItdTenS6mQgs6lbRs4q1at9wRs7wf0WGEJn5Z7VoF/jqD9uH074XzdqROAa5pTE3SfS9Wt+imiQxBKFeB4jgIH7G3qIsBXW0ag9NYYor6hIdcJqkr2kH25boGwhg/uH4qjBumguBOI3vz4LJOhIOesXstX4QAgYixGgwBwyowcxQGSodxZ9YNMeSJbMQbB5UYEPj7ekorkUfy5BkyIt2GHFt1EnaZZbyBbhI5oF0kL+MqtzmDl1TI/C4zTZPdNIKaYVZZg7EMj2onfWADMRBwtd+aDPuGhgi3jg0cS2vpNKzSVxbRt7txlHdNPwMg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(82310400026)(376014)(7416014)(36860700016)(56012099006)(11063799006)(6133799003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	K2JAcU6gHHtz9lBvEsCrIOrS1PWMx+faHakQjOjaCNmTa5yXOdDSHWQiKRasZiiIA03vrj39YhMnYRnot/ONpJzMdX4JMLOhDIzsf1JvIS0MXAdBONWJRtJ99TePvxxoVHKHV2GIAkSyszQLo1q1LbvizyLibgfY9NpgblF1ggBnYQab9kCNEgkz6byZljqb4EiHrGkItO55u2gsXRKxbqHVXwEcGZwdQlond66/c1rGstF6iF0VMN+q0YOpl88js+SjGxVrz3YB5P5EbrE2wxPTIi3MlZwe3ixvymjU/2W9KeKgcwQhDOsFRsiOFASQXDifWesLR+yv7mhJxdC9WpSnl/Ck5k+O/H2P2Hs7jDAa/h4hUWNrVmojEqy8PdM9vV50KQus2zI2MlKbBINVfWsxzSNkTOXsYvANYbiA/7Xth51ZXI23RyZh/C6zFJXF
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 19:07:08.9771
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f28c723-e715-4256-534b-08df1a6f083a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000449D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8706

From: John Hubbard <jhubbard@nvidia.com>

Add a method to check if a PCI device is a Virtual Function (VF) created
through Single Root I/O Virtualization (SR-IOV).

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Alistair Popple <apopple@nvidia.com>
Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Peter Colberg <pcolberg@redhat.com>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
---
 rust/kernel/pci.rs | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 622cf91fe5e3..b04f6aff6c34 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -433,6 +433,14 @@ pub fn resource_start(&self, bar: u32) -> Result<bindings::resource_size_t> {
         Ok(unsafe { bindings::pci_resource_start(self.as_raw(), bar.try_into()?) })
     }
 
+    /// Returns `true` if this device is a Virtual Function (VF).
+    #[inline]
+    #[expect(dead_code)]
+    pub(crate) fn is_virtfn(&self) -> bool {
+        // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_dev`.
+        unsafe { (*self.as_raw()).is_virtfn() != 0 }
+    }
+
     /// Returns the size of the given PCI BAR resource.
     pub fn resource_len(&self, bar: u32) -> Result<bindings::resource_size_t> {
         if !Bar::index_is_valid(bar) {
-- 
2.53.0


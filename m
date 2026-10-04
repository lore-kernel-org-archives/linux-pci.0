Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010011.outbound.protection.outlook.com [52.101.193.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F981238166;
	Sun,  4 Oct 2026 12:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791115708; cv=fail; b=Qm8z9FV5Cd1OaMNKLNql/+JNKiUemcZXSVYsKpVlJkbWFA6Flh3wkBc6tEIHg1X8yH5D4mhUBiS5NZ1xG23PT00vIeqgwi+/6tB8CB/XgcWemiOTvoZdtaDay//I7kP4AweewY+7NgsfGuNoeMQ9sJ4U5WFALvBZrUm4EO8UfwI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791115708; c=relaxed/simple;
	bh=7gJmPFv8J25xgi+nU8pSescFnZCIDT3XEfhRd07MI8A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NlhX8Ep7PWYcmJf4KRb6kTDzReUYte8FIIjfWbniXFMqLPesMglkSqeEM+y2UHWxXZDIfYSnw8Qofchgx2vbtCxB0i4v78SYBt48mhK2kzpPHwL194ILt/v+hqf8sK0t2FGVrj8cKhIDoE5hCRQDvRLvR+aUcJygHjnbLz8AZ1k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KuJrBC9A; arc=fail smtp.client-ip=52.101.193.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KuJrBC9A"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z03SuQDULuJ2Lm3a8H+BnwpNHO45wL/o52k20LQjOzkmF4aL2G5Rjll0T2AzRn4WXtGuH2cuZP6fLgZTL33uGSqMwusHFeq6zLTh6km67ALZx0zEcSZgW+/+oaPT8HiZGWoQQEr0jNvwQ1Yz75KswsuV9+ANz/ohb5Pqv1OJbl/64bad1xrUhflWZItXYUZnOV3/jIZY5FdI4kLKhTYfnWgsNsxHB5w+TuRmLSEhzAqGZF8rstr/e15/OlxYLINWhCT6UPPUOJICMH8DKlZUH7M/qXASUIn74uWNFzw6eBrj63ds99rx17SPIuG1+JP4/useGgVvslk76OmUZuMzoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i2yvRwkhHDr2m3WEs0xKIyHINwp/KB+O1UzdeDhvrbw=;
 b=o7Ye9R43FW+3fwTeaPFiQ7OlK94jNcDcQ/IHVskNOQ/DNRFUbadPrCF9nPae7ds3laujZFm0hmHtxfI1cVV2o3mVWmDYV+zXRFX6UXGZek8M2GNDOL7siZLM3TEATELIAPfwpSOzdrXrQ0CXE4oiUgrg3MAxeIn5ICO2TJg4JmguztOg5HHBDawl23JzL9r3GMP+XXM62T1XxQ+IDZBvHJ2pWC/+xsB8ikKZLk87V+Si/PzA1XT0JqWSA1eXRjXb/y+6Clkw8gdmItm71+kcNs6kJn+r72yRlI6nFAqJOSphp/rrxR22NnSNpaeM/qvlMToaeamb+wfgAvG3a/08ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i2yvRwkhHDr2m3WEs0xKIyHINwp/KB+O1UzdeDhvrbw=;
 b=KuJrBC9AjugN3WYIn3LLaKFJCzo1rrV7jZ2+TM9rcOL0Rn/0qriFWD332CKkyfNai4x592GGveqI1ocsmqgBht4Hanef5lU77Vi6sI8Ytq2TX1X2jFNGh0renhiVSWIDvfLIH8pZvEmLkrF0RS4cZOBJQ1IvEb9pyR2faL9j0Kvjms3YfT1skR75+ldJZ2qeNy3BZgQ5OOLgzf8kl5UTUcDrRpxJARVgU6ABRbNQVUuAwHUQ25kH/7aev+f02UbZalbxEI9nzbo0QsD/bHs/vsbZErXu+AZ4tUKAqNZi9lcTI91XwRvD6HLQ2pqhV+Nj2GQovRBOWtoPkr06xFtJsA==
Received: from MW4PR04CA0148.namprd04.prod.outlook.com (2603:10b6:303:84::33)
 by SAWPR12MB999318.namprd12.prod.outlook.com (2603:10b6:806:55a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Sun, 4 Oct
 2026 12:08:23 +0000
Received: from SJ1PEPF00002327.namprd03.prod.outlook.com
 (2603:10b6:303:84:cafe::7) by MW4PR04CA0148.outlook.office365.com
 (2603:10b6:303:84::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Sun, 4
 Oct 2026 12:08:23 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00002327.mail.protection.outlook.com (10.167.242.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Sun, 4 Oct 2026 12:08:23 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Sun, 4 Oct
 2026 05:08:02 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Sun, 4 Oct
 2026 05:08:02 -0700
Received: from inno-dell.home (10.127.8.11) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.49 via Frontend Transport; Sun, 4 Oct
 2026 05:07:55 -0700
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
	<joelagnelf@nvidia.com>, Peter Colberg <peter@colberg.org>, Zhi Wang
	<zhiw@nvidia.com>
Subject: [PATCH v4 3/9] rust: pci: add is_virtfn(), to check for VFs
Date: Sun, 4 Oct 2026 15:07:24 +0300
Message-ID: <20261004120732.1045629-4-zhiw@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261004120732.1045629-1-zhiw@nvidia.com>
References: <20261004120732.1045629-1-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002327:EE_|SAWPR12MB999318:EE_
X-MS-Office365-Filtering-Correlation-Id: 74a8e659-5c81-4e73-9ffd-08df2210304b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|1800799024|36860700016|7416014|376014|6133799003|18002099003|22082099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	9tzLDa7nmii5CQu2KxBBbSjZmtLqzXbbju54A8GiUedXEnSTJNjn6soaHe4+J+8cHPPuKpiMkS4iDf/mQiOkm/RDAGdjmGZ2W2E/X8Re1a5a+MS6KKz2US3h3IGADKmpKK571JdhrQQVPzirVt3bNRx2wHdXF/rErhVp8zVhfVyjsioKaZoapu+X8Gfilz5wSwIGrU/3ccfupTCsggxzyvTlhMPYZr34pP5eCxQqBzjJKBBRW5SDfoIJJKjiqlZPBNcrmnHpKOyvvzbUR4L9P5/Ls9x3lCbOfPr53GxUldBihYdvHsJ39+ACW/BiKpqu+gJwEM07PMn66t4uP6JfBX+SW+wEUl916cQ6xKRWWb8ndWxGrvzHZar1IJSnzj0L+/BdZW91RPc2pR57qiNb3eWkYZgUAxptN+rmo9Xo6Gai7yu0Hc/k+iPDiw1TvfmOiBo85BTCZvEr45CHFkIh2dzIbxAv8vcnuPpwQMQ5A75IXJNpgLsQl8mr0PzK1IE8TYuhQoK2T4GLV35+K8/Ulwhhmck5fc6zhIGG0LPu0+NGIz8QCbn7T0b4I1ZSUq8MwCk8U1Ymh0INptIgWpTV/6cwKy3ddACwDbFpzY0KgI/6Ua3NRfBdCkLCaqfhk11rVg6e5cHPRvoEbQZCUh0dBI+ULw7Cb3CcfLGkEWqtzCUjzD33E+Um6KOws4UrFPLPOvTR/XmpMWHDyxq9Tg0hCg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(1800799024)(36860700016)(7416014)(376014)(6133799003)(18002099003)(22082099003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	uGSNNPn3t4CeoYuyXUa0u3hJk7gSQUGIBeHu1CRf8kk7aSN8/FzccbEBD52jlZSEtMIdwr6i2+xMirSCukOl8TjePhBHOcTKIuY7W2qXwH5VTMy0ESOIcVSfS4QzSBga+/KYANTdRrSLDJYK0zm/3U5qFikXjrVuMhzeW5+VkEcUr+P6OcGXVWtff2K6A6/w7/8gYVPV+W40YsVtGrYKHs2nAEJ1xGh63e8EXs56ACCzFst/xomylACnbyB6XjFO3uWkHX5P/TaF5uev9bNb3tW6uNX/2RjDkQqKuNiLx9rYEA7wqHZnunGswB0mXZciYReTSnniCa6Ro8I99KyvgAjbzQPQRGF8vuq3RZkBKg7y4NWtjmOVd9+QOvDBmiX1IAjuHgEnVXMDSZiSU5t4zfl9YJi8A3NWdT7YsjIHFrSPpkbR67dwwFlx3JAsKDMw
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2026 12:08:23.3653
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74a8e659-5c81-4e73-9ffd-08df2210304b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002327.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR12MB999318

From: John Hubbard <jhubbard@nvidia.com>

Add a method to check if a PCI device is a Virtual Function (VF) created
through Single Root I/O Virtualization (SR-IOV).

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Alistair Popple <apopple@nvidia.com>
Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Peter Colberg <peter@colberg.org>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
---
 rust/kernel/pci/iov.rs | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/rust/kernel/pci/iov.rs b/rust/kernel/pci/iov.rs
index 1af5bdc19830..616ac40b8bcd 100644
--- a/rust/kernel/pci/iov.rs
+++ b/rust/kernel/pci/iov.rs
@@ -11,6 +11,15 @@
     prelude::*, //
 };
 
+impl Device {
+    /// Returns `true` if this device is a Virtual Function (VF).
+    #[inline]
+    pub fn is_virtfn(&self) -> bool {
+        // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_dev`.
+        unsafe { (*self.as_raw()).is_virtfn() != 0 }
+    }
+}
+
 impl Device<device::CoreInternal<'_>> {
     /// Enable the Single Root I/O Virtualization (SR-IOV) capability for this device,
     /// where `nr_virtfn` is number of Virtual Functions (VF) to enable.
-- 
2.53.0


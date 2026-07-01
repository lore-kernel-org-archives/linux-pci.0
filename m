Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011008.outbound.protection.outlook.com [52.101.62.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA903A3809;
	Wed,  1 Jul 2026 06:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782887250; cv=fail; b=QowsQa2vbHnQOlNaDhGqdXfsiL/Ar5aBAg5wBCLno9Hxdc9keGB39A5c4VIOXisMAGch9qAK28pcOAxDE47Sti9+Xyqiwf1zC9orhgxQpAtWuVpVUu+06hfs3XNS15b1kfctPO7J0+vszl7FTpDB3W3uc91RFWy8RuSvquSgGI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782887250; c=relaxed/simple;
	bh=opIruNLfJgTCuK1i2Dn2XxKP3OQaYj852qyEySy5yHM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QMePNmva6ZpNG607e183kxXNKfWXJlicmK3SfskJiHaEHgXBw2efaxlhvU+CFsg1V9nNeyhTqrLiEpiBPBXm3bp/yLPlQT2BNDCPD1XFRolvxZXNdqObUzKUN7uSH4Etw1gFtTctennfg0+SygDewmwd79GqIuKiR7CkLOEpl98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rIrM8WJa; arc=fail smtp.client-ip=52.101.62.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rIrM8WJa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dyLxg48ft7i946U70JVMYhxaJleVI3L7HRp/UlNkWZ0nHwCGdmSiDhQln1J9yL95BGkw6VhWU1mZFedpWhIX8kk9psmSnF9TCCRGl5Dchn/y9yH1QAb8TO+D+lt4Eq3eHWM6HR2aWf+UQt7Nlb/HufZgcdWnqLH+6CJ47PFmNDzuJ2j4N1vLfK87p2cAvyOzgEnUUDf/ozte4F3C2IaU+qtkVzU6OAK0YPKhd+Hw+g22zJOto1PpStMC0v8usjymlw+TUfqZXs0lbewFe+Z/Zv0oc8KQOUepqvgGDXwtul7Br37bZhWAsebd4er3m/ouvDhOE0v7H7lwS4qAJSoAag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VT6qN40sKCmTGDoEZz1zXD+CFPMefIC2BZDL7sQa8gI=;
 b=CDHgDltGnMcsLuwOewQQueSCsiEICIFqX5i/OaD5KFPCDaFcJg2XPuO2tIf6bHUu5xGssgiVzenLjUjewbGYKoX2T1P/HCIlKEo5h2V68WZt0HjOE+58XmeWcleWAqEdLLbagonf6T0Uw/CmaTC/D7D6n0kcb04eSvuxVq/niP1tpAYaLJD2kcpz30NLAB5aQuAjPYGFV7c4ntucdeWGjaPc0CvnXbfiUDMMeg7UEtrZQUo7u3GntapNYF7qLxjz1uMKP5URmyR0rcAKvJSGIAOn7iFBaWvDraVmefvqpjCA5Jfl2q3ewrr8wOxnLM4zCA1RI9i7wv5XNQBBxiFVaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VT6qN40sKCmTGDoEZz1zXD+CFPMefIC2BZDL7sQa8gI=;
 b=rIrM8WJatmDO7Y01V2qz7jPuikaG2/PW6uQukbjQeO0chPJOtm7BcbbzwgcDP4dl/kKX8NXokBbG3N5r3RkFBY2Lq+iyrgsYbcpKSMEZ8BDkqo5zc4Qzgk15lvLNxcE4GaOCjqYWy6oimZlM4HuZl4DgQwUV70L1UzmKqYhPt2yzk0qCLc7LxAVxkrnDMVT+9y94yWD2bVtpETzXZHVOxkNbC+kTWCwVz/uHG9U1bh3tP1xRV6CN1nrHYE/ZF3s+okDrk0FvPNehfrHtnpxgP9MzceM3r4A26gfluzsr4SN9bLEjvBlTFJrir8Mu8Wy7U5Jh8rTOToZ8bMgj/N/jxg==
Received: from SJ0PR05CA0069.namprd05.prod.outlook.com (2603:10b6:a03:332::14)
 by IA1PR12MB8189.namprd12.prod.outlook.com (2603:10b6:208:3f0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Wed, 1 Jul
 2026 06:27:25 +0000
Received: from MWH0EPF000A6733.namprd04.prod.outlook.com
 (2603:10b6:a03:332:cafe::ac) by SJ0PR05CA0069.outlook.office365.com
 (2603:10b6:a03:332::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.3 via Frontend Transport; Wed, 1
 Jul 2026 06:27:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000A6733.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 1 Jul 2026 06:27:24 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 30 Jun
 2026 23:27:01 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 30 Jun
 2026 23:27:00 -0700
Received: from inno-dell.home (10.127.8.12) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 30
 Jun 2026 23:26:50 -0700
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
	<zhiw@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>, David Laight
	<david.laight.linux@gmail.com>, <linux-pci@vger.kernel.org>
Subject: [PATCH v3 2/8] rust: pci: add sriov_get_totalvfs() helper
Date: Wed, 1 Jul 2026 09:26:16 +0300
Message-ID: <20260701062622.3499033-3-zhiw@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260701062622.3499033-1-zhiw@nvidia.com>
References: <20260701062622.3499033-1-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6733:EE_|IA1PR12MB8189:EE_
X-MS-Office365-Filtering-Correlation-Id: 9390ac31-4961-46da-213b-08ded739d0a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|376014|7416014|82310400026|1800799024|18002099003|13003099007|22082099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	i/sxuPKo3CAVI1Mve4+nJcunz4p8Tt7WFBtsKgujT2+qlvZXyK/bAz5/av9YLhTx25AhCXIwZ5N2oP9p5HPbTEehbjM0TRP1I3XLkUs7FmmQe0vph/5JK+cIWuwfnoG4VvWVu0opmfIDRdYQH/N18wmjhImO7ex1C66u03vND7kGeMsxKTzfi4yYzx0EClVZ5L9d9bg6DPpcoz8+gSTQoAmvcQKjB5oaYLqji9+fzWxIwiQu3+LlJI0MxwwW0b1TT+bEVt5qeZSeGT0nxW/PfHFFHq1RITzbpZKXLX8CyAyuOrQ9xotraXkg9xgIxmezql/kybx2rEraOROIfCgtkxtdv7lShYNA9U7HU8kcjX60FLF3M7o2jvKuOLFqhmWS7Xr4fF56bEid4DNLFGepp9xLdEl2B06nrqLLX8Zz8qzPOeOgyolysMYho5FUer6d8Sfg3WHHxnv88jZR0ZbTKkVQwXjn0ubUtal+b5NsI/w1Yh7I7sxJR84UIw4SvSQs4ax2KcbUfnWo6IOh+j27reeqRljypbct+9zyw/Ltc8CleY74pQg+ocdX3zvX0Iynkythbq1VyhhAsTQ4yrwr6QdnjWAP25zX0IA7BbAVa+XOx5i4Njh862TbpztYqUi26c7QuLwMjmOKlFIOi/27E+EHV+tR81GpS/EQMRpGt8kUHe75yejdHfREAcYQXx0bI3g5oQDqXkVvuzCCRVsrQA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(376014)(7416014)(82310400026)(1800799024)(18002099003)(13003099007)(22082099003)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/OY120A9XJLpTowCAetq93qIxW9Qmg6aaVDrhK7ZoL3EfeyB9s3uCk+FkiTzG6I7M6H1WCJ7dnnekaK0O0efGiH96BsrHDygiMgx4Mz8c1aXBJqEeQ5Fz2hSaCJu4sc5ha2CH+PINZE5lSgkoW9u/7onNE3P0DsegkVPeEljVGGkHLxU0A4w8xDz+I3Tu/aNn/GGJ7LblwrBuQlC4/SKRvnJhr+/CGKWNyjbD3G0xsb1M3c51ZWztELTxDAf8rErMJY5BomZZDifFCFeDrvbL+Qi51zj300lGHDlOs0giR9RUaDeVcsl9/ZC2Wt9WNG+uLdIaKUL7M0kDhVggH7R0M8m4F2GSRAREU75rPk3bw6KfabNlAHumq6ziyG6pQ32RwQRtCoh/MfiGbps07GrX6e7qbxGgzDhxGPgbjiuTdxSB9vZktwvmNlpApN6u0w3
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 06:27:24.5409
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9390ac31-4961-46da-213b-08ded739d0a3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6733.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8189

Expose pci_sriov_get_totalvfs() to Rust PCI drivers so they can query
how many SR-IOV VFs a device supports.

Cc: Alexandre Courbot <acourbot@nvidia.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: David Laight <david.laight.linux@gmail.com>
Cc: Gary Guo <gary@garyguo.net>
Cc: linux-pci@vger.kernel.org
Link: https://lore.kernel.org/all/DJHPRE4TGGT8.BUTMYOF5YE05@nvidia.com/
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
---
 rust/kernel/pci.rs | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 5071cae6543f..21c51981c02e 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -450,6 +450,17 @@ pub fn pci_class(&self) -> Class {
         // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_dev`.
         Class::from_raw(unsafe { (*self.as_raw()).class })
     }
+
+    /// Returns the total number of VFs, or 0 if SR-IOV is not available.
+    #[inline]
+    pub fn sriov_get_totalvfs(&self) -> u16 {
+        // SAFETY: `self.as_raw()` is a valid pointer to a `struct pci_dev`.
+        let total_vfs = unsafe { bindings::pci_sriov_get_totalvfs(self.as_raw()) };
+
+        // CAST: The C helper returns `unsigned int`, but the value originates
+        // from TotalVFs/driver_max_VFs, so this cast cannot truncate.
+        total_vfs as u16
+    }
 }
 
 impl<'a> Device<device::Core<'a>> {
-- 
2.51.0


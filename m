Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012031.outbound.protection.outlook.com [40.93.195.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636D943802F;
	Wed, 23 Sep 2026 07:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790147970; cv=fail; b=pP7rX2DJ+F8/tHxUUmSUD51EIQ2dC6hTqh3mbsYd7m3I+fP81ZU1SVMRWV/TVpnoAd+OxtnliBL6Rra/nXIB86OHNzjolXb76LNyLEZCe+41Gv70yQdgCsQmiL6FEuwvAXZ3iylmnQXigUHoSclT3Reyi+rBUdhWLTzx5/PRhlU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790147970; c=relaxed/simple;
	bh=2RwZmGmklMksUc92KmEGArjbAevx1e3lsIB4hE6NRLA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rbcy40nZ8sXHqVh8dDFLeJOmYxuPsA+o0rmP40KLPa34ZaQxPskVtx1mHgavcXi4/HCg6aDrziIZiXbcW8EpyE63Fxj0o7a57nHOB/ZUrpdYiJWn7BU7aXAcE5X3nDqZ3u81GAWT06m3Y/dJsbGKum5pXF61yos6JwSE3RQCA6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pq8HGVqo; arc=fail smtp.client-ip=40.93.195.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pq8HGVqo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ed2Iz1MT1boLfYP/4mss0eRo3w9KDxAaj8vultZv3zm+87upxHyA0TVL5r8hh2OecDt7tnzDzamrAW6wFQR2R+1r46JDfe4voKEHlOV2NuEyxiIVPu+xgAQAgzKInd36/5EjNIaxTsY1fPzbEwrUS6oCLxzVm7FQpQtpi5HrHSFbvCaNB5NQ7/9CKkk/1Ew4swlwb/gt+5SS+fS7+WKX0ayo1DRpG/WjorzEdyogzX7Cl3JzV9I+Lqs11tJeeaPKA3miWD1K4XsFGoGgbKYN6w2YeHGagbkJjI2MX2Okisz1joS4ZdTUbOBM9uR4DcoFqzGWnsBtUGFCaFW2xF1F6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CqssuJ8sXPW4+e1N44XiiS97/SltMmPrijdHypUD8O0=;
 b=Imw75XjcDQVQggi+0FqjgsLCvJiaW3aD82vwK7pUMdt5WA3Dydzl/Vbd87DvpRkVdDZ/pcduMsAT6m3oWa8WqExuWGww/6MhTMMUhvqRxwquAH3eyYH9ndLO9G3fxRetAD4e37gei8fIIVcdT2+qgzvOMlvCebFPNb/DyuDfk1VWc+EIIq+EpzBZCM8YmbN6T8WtrvYdhACGsizVUi67fdFmw2lViMfufazT5UK3QEkXUDZ+ReSjXj0EqFfUmCW+jugc/vea6Dub0DZ031sLP2q0LyTdGjIEAn10z4RNWk4F8lVi+fB/0aJ6nfWbcLhIamgMvmLjA3N+MLainkrjwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CqssuJ8sXPW4+e1N44XiiS97/SltMmPrijdHypUD8O0=;
 b=pq8HGVqotv/g3AdaEKCBXZteXnIZJEQMO+tVrSl3ElS30Rzq1sT6q4I9WrbC/+NLfTasNuYY0lNKroYa9o0eyhD3vsHGpw72O2eDKAhXR8k+SC9clkSL51xiMYSMSTmGr6FXLBXgICiW40xlJhe6np02vxYSgyM9kQbcXgytGYjy07BJeFdcRYg6lU8PQOsRiPn8eEDtGt1ET2bdnAaxD2sVXSr9eru2x1dj5VWxDf4GmTeosDJOJ71w8z/8eMVlqfwxdjAnV8DNgunXxWofFeBp7AP5MsSF8uFwVVwwjgYvPaZZrP7EwzQWprYWdPzrsQOA6sFTF3PvWUvSJv4Icw==
Received: from SJ0PR13CA0230.namprd13.prod.outlook.com (2603:10b6:a03:2c1::25)
 by DS0PR12MB7948.namprd12.prod.outlook.com (2603:10b6:8:152::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.17; Wed, 23 Sep
 2026 07:19:21 +0000
Received: from SJ1PEPF00002314.namprd03.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::28) by SJ0PR13CA0230.outlook.office365.com
 (2603:10b6:a03:2c1::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.14 via Frontend Transport; Wed,
 23 Sep 2026 07:19:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00002314.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 07:19:21 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 00:19:02 -0700
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 23 Sep 2026 00:18:58 -0700
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: Jingoo Han <jingoohan1@gmail.com>, Manivannan Sadhasivam
	<mani@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, "Krzysztof
 Wilczynski" <kwilczynski@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>
CC: Rob Herring <robh@kernel.org>, Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>, Vidya Sagar <vidyas@nvidia.com>,
	Niklas Cassel <cassel@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH 1/5] PCI: dwc: Add RAS event counter field masks
Date: Wed, 23 Sep 2026 12:47:02 +0530
Message-ID: <20260923071706.1134320-2-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260923071706.1134320-1-mmaddireddy@nvidia.com>
References: <20260923071706.1134320-1-mmaddireddy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002314:EE_|DS0PR12MB7948:EE_
X-MS-Office365-Filtering-Correlation-Id: 0789e342-4cc1-4e53-795e-08df1942fd07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|82310400026|1800799024|36860700016|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	x1MRC7LL80ZN8SvdtiKVkU5ONOsZwYrG6EmIT+vjA51NcEaZ+uHrA+AcBBD9aEnHX2MlNgBWob+794l3t5sAmXzCMa2SsL7Gc6gRZVtPdQ0KVk3PsNt3FdY5eO7LKad/wk9GQmCSQWciSBeQWXjANLcqqBlYSdwEiFz/M/TcreYQQVCB25oR0HDuLDG6KDT2OGt0/wHPVTTKlFVHzJC35B7VnZkbiedMr4NVbUETkw1d8X12g93kG0DElpgIqpl3rzWqwJNfy7VKUxCGmXyQfn+HH9Bmzp1l0fbtRd/LLj9Gyxsp9i26LTMhVw5evXPKNW4WHN+K0TFlh+bk87G2lvSFX1sRwoQaSfaOOw8ZWeQd0PVJzFPjaBcZPTlv3cnYjd9zq9voVrKyTJ6/shFpRxyXsAzTccqNB+taOZ/Q/6bN0oTOtj7xy7NLKM2a7fcKDXeFKfWXBnlY8TJ2lC4/g9hNvN4ai/ERdufCBdLx59tYiXeEtpDi0W4GgrCD6S5SLSabodZvYOvYHI5HnaiiEFrmrL+v9aTKJSmz/Y9hFjxMMHQ0WRwIWO7mr8J9KwAQMZXMafHluuDa81jLblgJw/RcAP9we8L6vEEaGGWfbyOEHXZ8YLqytoFGDsSd4TnAlPXjo2oBOixQMM4TmWGWLLZgSA1e710qRRLau2VaAIdLWHi1rqvJmbrhdekRd5TQz1HcCzbnCC3LdYKlcBQl5g==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(82310400026)(1800799024)(36860700016)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	METzHlcWNajwGOxdplkx/Lvtitekv8okRBeIquXnyXQtn+14m2g95UKdOO91UDOiR7SJ2mUVso/otczMO1ZBVYeNSgFPrp9QDd5u/ufjq4DQye/YpJplf317gchMweWWt16gMlJb1lv1wzRTjEKPRBJ1SsqrG7nuQwE43iD/X09/7ZVYZM01PFT+VeMqTfD4zJLMJ3d8+CMDY75PZGFlnFg3m4SDVfoxVLQiAmEd5rQowambvmEe3lCQXHfqisiCen2+LYAw2mq+E2QQ4ljQ2al5rqnIgNTfZCbokrVXeLwPNIquLDoGpLG+1T+39LQWBpIu+h7En53LNWmxlGbJidV9xwCqTbDVhYrpgKltJ88+lgEDzlujOzMarjfBcN/9wl2NIX1JbV/Qe/cjMwFPPkBUw7Y8YBeXk/eq5+8QJ0qyfzB1St7VL9iQUeaYjggu
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 07:19:21.3226
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0789e342-4cc1-4e53-795e-08df1942fd07
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002314.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7948

Add complete bit masks for the DesignWare RAS-DES event counter
fields so consumers can use FIELD_PREP() and FIELD_MODIFY() without
open-coded shifts.

Keep the existing shift-based definitions for now so current users
keep building until their call sites are converted.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
 drivers/pci/controller/dwc/pcie-designware.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 0735ae940924..c4db241547be 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -278,14 +278,17 @@
 #define EVENT_COUNTER_ALL_CLEAR		0x3
 #define EVENT_COUNTER_ENABLE_ALL	0x7
 #define EVENT_COUNTER_ENABLE_SHIFT	2
+#define EVENT_COUNTER_ENABLE_MASK	GENMASK(4, 2)
 #define EVENT_COUNTER_EVENT_SEL_MASK	GENMASK(7, 0)
 #define EVENT_COUNTER_EVENT_SEL_SHIFT	16
+#define EVENT_COUNTER_EVENT_SEL_FIELD_MASK	GENMASK(23, 16)
 #define EVENT_COUNTER_EVENT_Tx_L0S	0x2
 #define EVENT_COUNTER_EVENT_Rx_L0S	0x3
 #define EVENT_COUNTER_EVENT_L1		0x5
 #define EVENT_COUNTER_EVENT_L1_1	0x7
 #define EVENT_COUNTER_EVENT_L1_2	0x8
 #define EVENT_COUNTER_GROUP_SEL_SHIFT	24
+#define EVENT_COUNTER_GROUP_SEL_MASK	GENMASK(27, 24)
 #define EVENT_COUNTER_GROUP_5		0x5
 
 #define PCIE_RAS_DES_EVENT_COUNTER_DATA		0xc
-- 
2.34.1


Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012022.outbound.protection.outlook.com [52.101.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3753346E51;
	Fri, 16 Oct 2026 07:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792136469; cv=fail; b=Rb8d+XEqC6dtQ/35lzajeExtTBIrAONEHT+kJBZLPp5dUFV74ZOJg4ZTDG4e4UvuKjp5Az1Wj1ZY8Ld1+TIh68UkNa4X5TeDDtin0DB9cNzN+ZTjY/stuLy88D0TeiycWbzZjqboJbGmyJndzi7Pn/qqNXLokej5YJbkHhjk9E4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792136469; c=relaxed/simple;
	bh=+8ZyDKNaCjxv1CtjHAQXHGXX1ynr8fmFLe6FwTZpVdk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qZk9vz41/bIW8R9fEmwZwHZVUMG1pzUstSQC72oY1/FD8uCE54QZ3TKpP/CWy8JOUrtrKd+KAOgFTuHj3htMXZ/S97x9JStt6OQLMEQkqBw5+H2LdQUvwSv01DTpvggs9x5hcRjdk8cWQrnka/UZG923quPqRwBWuEgw2Ozxhgc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bq02HmC7; arc=fail smtp.client-ip=52.101.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bq02HmC7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ET5AY2mBqv5pQPj911CDuND9cAQsS0yiyWRTYurUDRlKjRW6BH0ihbIIEhB7AeFDwvmyGOvId/kDvfg+lOoEO9GeFrGwJax2r+mp91O0lRWdLW/wC0lFAY3lWxkpJYAJiDqATH4RdajkC992ldWKxMbmRUw/uKHqnsQkSbSPkcbiS8jpGoc5NGEmnyrVKIrsuxdZ+rbTg6vZgy1YMJXQzdMlux0NdjzKesbypzc2E/0F2uYNXCCDjop3fZqDyPIkAApK2Br6J8bnT6Adk4waxcpQxQXY65Zu7MXnGdK+j/HVuxPZM+/ZAqmv+roMMD6htGWsn9N6JeYI5X6TmQgI6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ufXIfqoyytwHusXrcLoKxMGBZ7IAawRImXMYPV7fzlQ=;
 b=hCKT08CToZ2PF0Xekcf2lkmUw+dovxSj7eoklXZZYw9BezfAMA8a93MWI3WThCClq8uyJHz0S5EiGMRF/IB7B470bu9B0wfCMpKpMG2Ftq2BuG/f7IRY2GA2TGvpZTg09gXtFUmptzPqbcaGHNjd3ep3a3X8gMBwbbq8a6gR0/ocaUkVvVf1PNABmAT4wZa7u0YOYSR0PQxNOOAZ1m6PGjR9DC7Gq8J5IytTc4jtJojKdkEReqzk4tOvirZAON+VnDjPtSXDrmEu8MWQtHweEsEa4/LwWhZDhjKQaSU1ycRlCSjGpVvRW/Hz+F+IoSNcolWjbFCXA3svjbFm2falEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ufXIfqoyytwHusXrcLoKxMGBZ7IAawRImXMYPV7fzlQ=;
 b=bq02HmC73AvM/j0l94mjW1p19zTmOn3A49IeCGJ9L6vJuwcomi9qRLPlRcmNOdsqizUKPrnMFTWiiLDF/HLlyef1EonHMr1/FxlEMvjSA947uDws8T7clfVaYDgGffRz3ZVDi66IZNyAB+FUCGf0rPLZUWm81iVSv7VHu8nzABuam0dYZmDz7BIci5UbJvsNDvDi8DZnG93MkSt4Ghy+xJ0NIGZeFFB1rvhmcL4SDjqwQKb4ZOwCSYxEJlCIp8afts8HZtIS+Gd5vtUdgBECjvvTv7VnDjNnkYw+i8fG0phMQeTwqpy0c9RoV3Tvk4kA+mxTMWurKgnj26/HBXiP+Q==
Received: from MW4PR04CA0188.namprd04.prod.outlook.com (2603:10b6:303:86::13)
 by CY8PR12MB7657.namprd12.prod.outlook.com (2603:10b6:930:9d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Fri, 16 Oct
 2026 07:41:05 +0000
Received: from EA8PEPF00000008.namprd05.prod.outlook.com
 (2603:10b6:303:86:cafe::13) by MW4PR04CA0188.outlook.office365.com
 (2603:10b6:303:86::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Fri, 16
 Oct 2026 07:41:05 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 EA8PEPF00000008.mail.protection.outlook.com (10.167.249.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 16 Oct 2026 07:41:05 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 16 Oct
 2026 00:40:45 -0700
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 16 Oct 2026 00:40:41 -0700
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <jingoohan1@gmail.com>, <mani@kernel.org>, <lpieralisi@kernel.org>,
	<kwilczynski@kernel.org>, <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
CC: <robh@kernel.org>, <thierry.reding@kernel.org>, <jonathanh@nvidia.com>,
	<vidyas@nvidia.com>, <cassel@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <mmaddireddy@nvidia.com>
Subject: [PATCH v2 0/5] PCI: dwc: Clean up RAS-DES and register field handling
Date: Fri, 16 Oct 2026 13:10:21 +0530
Message-ID: <20261016074026.564302-1-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: EA8PEPF00000008:EE_|CY8PR12MB7657:EE_
X-MS-Office365-Filtering-Correlation-Id: d5a88254-d039-4c1b-ae24-08df2b58d5c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|82310400026|36860700016|11063799006|56012099006|261009223027099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	Uf0+pTfOuC5yl8mE3axpLXsA1QQaGACLMugvX6XZi9dglih/nokvDFwJS2FeZeasfatEeOMopMpVOyFVUq9MsFgst4BTrObR5YL1+qhLu25DbKzGhhIlK0TLfonkbmpRMfVE0pomQUpwhD7CkI6qOoWLTYql0odYIbgr3lhf+9ajVvaMae3X/CwsL98ds56ow9NqdtlbdpfPs0CPhkekGrqfI56STzsVsydRRoOvA05VYtNDz6dXsTzrfQn4QJAv4piIURIkf/7i43KwPx+Gb4A9HsjDtg/6BanW1NnIpNNbc1I836kk9UHxFf2AzDjek1ChAJIBPfgLHtzq31nCCCg5XHwq3Ih80P2ZM5EYtWGUMgiIOrFS1WhphLxYlIkTHhjrlRMngsNuqjV77tqHLO6lghkLFoZt/U1yuHIkFESjW4Ur7eI8puZyQaq9iqdScDbuDEl6MVdA3tyR7KohWDMXmq1ggJumi8r7J5GUhpmjXQ5XubpepBIIJFEoV6JwV5vEzllXdU6W4z1AUiutnoUbUxEKOl2sSnArhF+HrbeuiP04FeyKBaoaSsL6lhXs0XGAJoFcGp/oUbPd/KgqPTA2+ul+wYOl7mZhg7XrIfd4q0tgQ/zrzATnwuVTCcv9HJJo8/SFcvohUW62yqOWUxQfm2yTtCRU84OHclo+FPynbfVYwhsTNa2Qw8LW1b4Mk33H8lmaklZD3oEpDdGQ2A==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(82310400026)(36860700016)(11063799006)(56012099006)(261009223027099003)(18002099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4l+HlPP6qKex3AQP4M0z9oQ7B6fH+/U9HT7u5fi65oPdeZWMxrog1PCorNHChVRT3+32BhfS7VrrqFcuaXb+7gtU24NQeSwrpEdqDHi5r9zj2mnZkTnfd9M37kEXJSabxi55Zy3uhuP+ivzGskrF2KS9OmTpRKZ60jUgWmkci92M7eLIJm6G3YkttURuHjBjFGTFucXSD9Kvbea9+ndrvUOSNFirUm0GBUqib6x8sTgdhe/KqrodxAI5J8yIUi4j9HMXVMYLBAXK43GfgFbR7WzdGUhW1s/nX94w36dsGlO2khyPCsL8PzFikt4n4I1i8nrO+O3c/ACLJDbI8pwIHnKMMr/i/9VrGynqrVo1/Znsl5vdCkL5TuZDw05IMNU2H4T4CUROwiWrQRQ5yIKDQ88SomodDnCKw5Eh/IFEKlzFuQo2MRcfRPmumG+sVEHd
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 07:41:05.2292
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5a88254-d039-4c1b-ae24-08df2b58d5c3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	EA8PEPF00000008.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7657

This series addresses review feedback around register field handling in the
DWC PCIe code and the Tegra194 PCIe driver.

The first patches add shared masks for the RAS-DES event counter fields,
convert Tegra194 register programming to FIELD_PREP()/FIELD_MODIFY(), and
drop shift macros that become unused after the conversion.  The final
patches make Tegra194 use the common RAS-DES selector definitions and
consolidate the event counter field definitions in the DWC header.

There should be no functional change intended beyond making the
bitfield programming explicit and keeping the shared RAS-DES definitions in
one place.

Manikanta Maddireddy (5):
  PCI: dwc: Add RAS event counter field masks
  PCI: tegra194: Use FIELD_*() for register fields
  PCI: dwc: Drop unused shift macros
  PCI: tegra194: Use standard RAS event selector mask
  PCI: dwc: Consolidate RAS-DES event counter fields

 .../controller/dwc/pcie-designware-debugfs.c  |  56 ++++---
 drivers/pci/controller/dwc/pcie-designware.h  |  10 +-
 drivers/pci/controller/dwc/pcie-tegra194.c    | 145 +++++++++---------
 3 files changed, 106 insertions(+), 105 deletions(-)

-- 
2.34.1


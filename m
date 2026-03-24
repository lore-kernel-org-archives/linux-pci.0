Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011001.outbound.protection.outlook.com [52.101.52.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFB93B8D5C;
	Tue, 24 Mar 2026 19:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774379452; cv=fail; b=Q7o7J07OrgJtSyhSnBKFw4Shd9HU8aRe5lXadeBTeoGSknmmDZeZyfs9I93NY9ioDwiKiHnur+g6eTZBSqvkq+TIexVJSo8KckKr820MT80eVEiOEXvbfpa3scofgAc8KD0qrLwaplLCSCzGVPTSQ1QuHNiqrxb+IVaELDxRyh4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774379452; c=relaxed/simple;
	bh=bTPvUzXaOIvxh1jPZ6eCJqeLaVwSrXhboz9g8fx+fqg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=q7WbLFdcYYC/BmxyEtjFcOhLBmvyhepPd6A7ClzR8f4VPizMSGI9Zp6UNxZPqTtZSMDN38O7CbFyhS1jcQNVupJ95bAdUJDQZsNd222kECqSk0yeFuF0/4lxH8CWf4vwXnEY2Vy3ZTLy4QtOEZqGJ6Ctr95+zk96fNQl+dBvTFA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=a5JN1KHY; arc=fail smtp.client-ip=52.101.52.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="a5JN1KHY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oeqhpkIhUbGqYoTDBfNzdsF7aNiJH6Yq/YCMCAJODQGGLzjDIyJlqBIXn/OU9WpT42CSEEqr79wRaE7wG73WnyA7CcFBxBZTxxEbXGqXR4MrNwScAw662Sh8cSHeRyuOAFSgsGVG4u1dSzTZ6FyfCAU3M6Em/wWrrLBCE6xx4V9wBOqwyxuNtxtiBRh2N68K4en4TdhCu89Jj9/ViJMSM0TK98NQ0dcRfg4UAV2v8KmtmpJstU2whp6NYs7RGp1ZYkZX/qZRb/iCBMT1KKxf3PMbwJx/kbNqw34U7ihRQlc1Lg+PFS6lSlMnS9jCqaI8FIGYMvDUC3JJ2NizmqglEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XEzRWJX1ol8yMPjNBKMn9Si0EdY6PI65k2NmkU0jRdQ=;
 b=VFEw9OvAkG6s3eqJ8NPQXwP8J6X/e5Z2J8S/JMdFwRtp8Ak+OKRVq2Orc7IyaoMH+MQ7DJhHcPqndQgmEz2K1EEcf0t0kmO2phvrhGxhHvcc7leu0r80Jn5y8YKQozDMNePJPYDqHffDOecgk8Ef05Bdv5GUEthiSmiRBJkInwu/2yBAOaU7+6vSh14bP7pPO2h1+7Dguc/IFNAcUk1FINJB5pzXGKaPXhD27g1i+LJMgWUNlO0f/AlddpkwxyvZmQ95OkzgqESMqeCUjCZ6WfDQ57FxCW5umXmet9XA6X4UKTBOjXb9ZVdpBa4kSmWMXN6GOxbT5rJJ773yTMM3JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XEzRWJX1ol8yMPjNBKMn9Si0EdY6PI65k2NmkU0jRdQ=;
 b=a5JN1KHYETPZ1NqITmgtdAGUofLO27Km/smXH+em835vOMs/+SuWb1svaQMyPLS5ZN2KFOMiBwCOqZ9h3kzLE/4qeTT30FVx64VGROPRl6Mzvs8f08Lzllv6slplX+5K0GHx1RTeW4IFj5/7UzEhqO1qSOmQqjzljro60peSiaaAYY7umJCfLobrz625bkNSeLASO/er4xTq2c3MyG6srvXfX8v7bCZILt3zUkstPimST8ddnO04nzsOroflj+CSf8C7Zasdl78Sk8SxSr4gK7tsuLth7ts1o6dugyuFwqBUZ9VWhJd2OvVnC+eHY36ApcJuL9vFkqp5LrNOpKtvAQ==
Received: from DSSP220CA0014.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:3d3::7) by
 BY5PR12MB4289.namprd12.prod.outlook.com (2603:10b6:a03:204::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 19:10:44 +0000
Received: from DS2PEPF00003446.namprd04.prod.outlook.com
 (2603:10b6:8:3d3:cafe::f2) by DSSP220CA0014.outlook.office365.com
 (2603:10b6:8:3d3::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 19:10:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003446.mail.protection.outlook.com (10.167.17.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Tue, 24 Mar 2026 19:10:44 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Mar
 2026 12:10:21 -0700
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 24 Mar 2026 12:10:15 -0700
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kwilczynski@kernel.org>,
	<mani@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<kishon@kernel.org>, <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
	<Frank.Li@nxp.com>, <den@valinux.co.jp>, <hongxing.zhu@nxp.com>,
	<jingoohan1@gmail.com>, <vidyas@nvidia.com>, <cassel@kernel.org>,
	<18255117159@163.com>
CC: <linux-pci@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH v8 0/9] Enhancements to pcie-tegra194 driver
Date: Wed, 25 Mar 2026 00:39:51 +0530
Message-ID: <20260324191000.1095768-1-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003446:EE_|BY5PR12MB4289:EE_
X-MS-Office365-Filtering-Correlation-Id: bf70a471-aa28-4e85-fcc1-08de89d90c6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|36860700016|376014|82310400026|921020|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	UTh6ZAwMrhQMK98HCnJPQ64b5TFwETXONPmwPBE/0VSMoBnznxUfK1IM87Z///WOEmKgxSAznLWvSG55uUjagYp+GPLeP9D33ba29ZLlSEtiSGD6FtkFw4Wqg75if1zTStFHRsP5S/zha1BZkG41vq6nBBTsIyB4G008BellI84MOxnVqr7Au9Ll8swh9/qTNYjkz+USAGIkzVpdilrqz5dKboCC7mWGC5Qnpt2vaChzRdZ+92IuFt4+RLFlKKDxeit8/hspHsndOUvutb6AoskTLaTgrc0FZbkHi/G5eC9E/l/gvVUnXW+0EolufIeM3CEQgC7OY1pS/+zgcHmhuOc4rYUavUW/Uk62+0awgunCHJ0I0bFjxjujf1JXIJ9Zg4Ps/QLYe4CuWQG2ntt1Z7XymtMUx/7vUx2h7qRZN6aZzSzD/bSIns6C/7WCscr1dlG5XkoSL4skMi7lppZu6AIkQP4Qs4377a36WInpHNSB08CV5e/HYZB8YxwPS/tSTSdsRaooDN6l6jZvgp7qEPkSLwrwM+BBXZUyi6Jg/czXAj2t2q9BV9SkSiRJQPxEhbSs/O/gfbetcJEUhTbanOQPMHtXmaNxisxDdLU5jdoR/L6aI1P962oRYJv4vx/51+rkQlewJeDB3ImicBJ9Pmqwqn6X23vksXTzcXsYxHpRfm984o3ud1snjlucVUQ701lNfktCr2MFbCe7pCSaPD59rvIC4GDwQCYkh6Wfti20DYNndDE9CXtmvdcKxN0VcAFgvU+WQ1DdQtPmk6YoTSHD4nwtLYrws3Ax3WUK45rNYl83XM3QfNR5JrAUMTtq
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(36860700016)(376014)(82310400026)(921020)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	c+DhNNHzaeFoQh+r72We0HpJ8nrdwdiIKNoH+BMghXJdSYT72fCOw+9jFtqzcLkzecMys/AYRZPQaSQPWXxInHDTBFbdLpFDabp7/r+Qt/jrIJZ+BCF0M9f7+L0G13uAsZQoNdC6FxHmf0kNJWBqIj7DvZ1rNHCyzYGUsPSWf4+y5aaX1Ti3rnohoX5ewxuOQ2qyWCaKbtJbPa0fv94qRR+8tDgtLFzohAiZhxLH68EKpJL3UQXvlfe3J3kFDVBsRurvsk40dPgUR6UlQ1P+J+CIaBhNWUNdB1yl3G6CsP288ZrsztLwXIM85/EtQ7sWRbJf0Uvtu+d0K+E5P76a344CDYebdxQoNif5n4hvx+ilhhUFK9dohNMEpZRLdBCENl4fX3mrz1Bv6FUtAcKLngoAG7d9quIYVTjkEtTMsv0+euNooOl/Trp8rQT4+nTQ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 19:10:44.1049
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf70a471-aa28-4e85-fcc1-08de89d90c6c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003446.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4289

This series[1] was originally posted by Vidya Sagar, and I have rebased
it onto 6.19.0-rc6-next. I addressed review comments and split this into
two series, one for fixes and the other is for enhancements(current).
I verified these patches on Jetson AGX Orin(Tegra234 SoC).

Disabling L1SS capability based on support-clkreq device tree property
is moved to common DWC driver, so I reworked below patch to disable
just L1.2 capability on Tegra234 SoC.
 - PCI: tegra194: Disable L1.2 capability of Tegra234 EP

I added below new patches to tune the ASPM parameters, commit message of the
patch has the details on the bug and fix.
 - PCI: tegra194: Use aspm-l1-entry-delay-ns DT property for L1 entrance latency
 - arm64: tegra: Add aspm-l1-entry-delay-ns to PCIe nodes

I added more context in the commit message for below patch based on review
comment in V3.
 - PCI: tegra194: Remove IRQF_ONESHOT flag during Endpoint interrupt registration

I fixed review comments in many patches which are posted in v7.

Manikanta Maddireddy (2):
  arm64: tegra: Add aspm-l1-entry-delay-ns to PCIe nodes
  PCI: tegra194: Use aspm-l1-entry-delay-ns DT property for L1 entrance
    latency

Vidya Sagar (7):
  PCI: tegra194: Drive CLKREQ# signal low explicitly
  PCI: tegra194: Calibrate pipe to UPHY for Endpoint mode
  PCI: tegra194: Remove IRQF_ONESHOT flag during Endpoint interrupt
    registration
  PCI: tegra194: Enable DMA interrupt
  PCI: tegra194: Enable hardware hot reset mode in Endpoint
  dt-bindings: PCI: tegra194: Add monitor clock support
  PCI: tegra194: Add core monitor clock support

 .../bindings/pci/nvidia,tegra194-pcie-ep.yaml |  6 ++-
 .../bindings/pci/nvidia,tegra194-pcie.yaml    |  6 ++-
 arch/arm64/boot/dts/nvidia/tegra194.dtsi      |  9 ++++
 arch/arm64/boot/dts/nvidia/tegra234.dtsi      | 16 ++++++
 drivers/pci/controller/dwc/pcie-tegra194.c    | 53 ++++++++++++++++++-
 5 files changed, 87 insertions(+), 3 deletions(-)

-- 
2.34.1


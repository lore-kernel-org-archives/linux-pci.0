Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013032.outbound.protection.outlook.com [40.93.201.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D81932D0DE;
	Tue,  3 Mar 2026 06:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772521117; cv=fail; b=WU7FkGlYLVHCC1KWVmNx12nrrcqQqS2PVK2yCuqvt+rF9HwqkylHJMhcv7DfrQN42dT/ldhV8cPXCYJG1AnMoZ3vBz6ZApX201SK6Fn/ogYsMc75Oc65++QQq2YkYJDipubgizLq5SwgOda8+zi/ZSeXTlBpNDBygwk0u3cd2o4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772521117; c=relaxed/simple;
	bh=YQzrQL2W8DYyDJKF8B9ozCyRfVEwdbDhiK5iYxhBJqk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nFbQyv0t8GLSOrM1Hb6G6AOM+hd7Ye7MSV+Mt0ncmJtvlqz80oVTHtpwS0iJ/zJvz3Uw2jA8tEHBROK1TfkHqlVtfytUIlqfHZsM9x1fIyztt6fkh8oLkLNEUhm5fnI3WB1Ermyva40okwwHaVvsq2f2WzbwoOXlq9oKQrzX5aE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Wi3Tx+Z7; arc=fail smtp.client-ip=40.93.201.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Wi3Tx+Z7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lAlHwoLkrPY7XvCBChO/uhtabGJfwPzzz5oCwuuuRhKp2J2qfbeh87sWPhUH8N+h15kmCITizwZGT4MstwrMySb3dogsKlnnNbTzZ9P+1PPZ/klPGQ03z1buil/zlYky/l2lsqccjpFYwbhFr3URf9WKTCzaa9HafEVFXnhP1mww+KodhdKPytH71YrJnbI+VXELnMklI40vgxIVtSWbxbSJUxSnRaiesOV7X4Vu3nqwPv+CEdcOolTz9agbfOC3Ioa6XBXZMTFAsZ2CdWWe2+hSHDCCJia3MK23bTxze7hMT2eOclKW6r4JV6y2rmlTu7RYf8swl3CGbTtrJEetzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fu39rOUHQGil6ErZWihvegDIF1Rklu8EGNScmPYjcDs=;
 b=UA+j+U4I8lKrtCgPB1Ou8po5eauT6MccTeqtGcssqG1cCMR34fL6LgQvBZbH9Fk46vsGUKy2GIt6e1m9UMrCdiuMy6APIrgZBJ0nAKkhh562ExTGrhFJ3ADJFUXaAjEla660dX1yzr7s390osrmZAHgOZaXa5e4wbSwAxrKsB4zwzJz4SvG+c8ldqXukN+OPkr6ro7UkvjA0dgAzlj5dOnn1VI2N5cKvQjB7rcxVopUvAzeu05f8kGsOEOeb5SsGMO7kANK2J6hyBJ8W4t1l03051qGmDvanTplqdOjTt0d3LgsTbXHHb4BM0fXWsOyZpaYsGenU0bbhTFNkHczQ+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fu39rOUHQGil6ErZWihvegDIF1Rklu8EGNScmPYjcDs=;
 b=Wi3Tx+Z7vvXWShLsYM/lqwqZ9BXl/fL67cofdtccDsTzr27M7QQBW+I+n9r2HBjBSmsMdrVO3CZjaa0+GZI2x8Yc6/rPsZo0joJZyv+vF+II1XdAaH8jqtcrVEmF2jkkPswuhx1OGRYGgfpLupaweruW5LqQaFizz8yqix6EBLUX2i3pN26oa5EluGsCVV8KQxgQ8lRndKG737NTlsG9v1lznZit4bMmL/cmom/965CDjckwzV2gyROxS0RX6v+OA22JTC/cfbTGwODhx6aPmm0nTJp37170bBMLg0f8DEq3SWl4NqA728hBzioYEzrtf/g7rmLLmKVZjpbKAmAwrg==
Received: from BL1PR13CA0267.namprd13.prod.outlook.com (2603:10b6:208:2ba::32)
 by MN2PR12MB4485.namprd12.prod.outlook.com (2603:10b6:208:269::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Tue, 3 Mar
 2026 06:58:32 +0000
Received: from BN2PEPF000044A5.namprd04.prod.outlook.com
 (2603:10b6:208:2ba:cafe::3d) by BL1PR13CA0267.outlook.office365.com
 (2603:10b6:208:2ba::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.21 via Frontend Transport; Tue,
 3 Mar 2026 06:58:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000044A5.mail.protection.outlook.com (10.167.243.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Tue, 3 Mar 2026 06:58:32 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Mar
 2026 22:58:19 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 2 Mar 2026 22:58:12 -0800
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
Subject: [PATCH v7 0/9] Enhancements to pcie-tegra194 driver
Date: Tue, 3 Mar 2026 12:27:49 +0530
Message-ID: <20260303065758.2364340-1-mmaddireddy@nvidia.com>
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
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A5:EE_|MN2PR12MB4485:EE_
X-MS-Office365-Filtering-Correlation-Id: 53b3dfb2-7588-4dd1-8ee8-08de78f2485d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	0qO4Wk7cBhE+jLTUXJgmMVfO07+eJWbTJ9SVtppeUykfy+0QejIzI/aCzkZ/nuAwLxU/pSCkihTsiSA99raOjRhoDtPXH04qAhVWTxltRQwUrQjVWy9V3vCSJXNQCjD7IbWBJFV/U4Qx5iymeolAuSysI3RDK9V2T+dbxOOi+7g3xExl1ZjQyOEVEb5K6AR8ZZ2L2WnQFA7kiC9lYOr75iP19NQVOrNhimfpI04iIp5gzoxgoZidMb1QXsTsaZOxheVkgedqq8KaL3sYmd5Ql5jpOKEoYqXejqJrQRVRCi5kydymA3s4arjtaoM+WYPztP6VFYEOeHQ4OPl79GxPQRzhYBkFG27QrrMx/vxiPmG+3sSp0PX9ZARHhlZ69gVNn+HRhpY9r40uS9U9SHv+nzXpK574Xp+ni5sfCUNjbOGzqiKylIUWSnm0tupo302hi3e25S6sfRwYwIZcwrniUBhLIHaRXMSYFyelJGFT+w1U5B/S1KhTh54ddpyfzRxdo83VWjS0BrvWVw6vAXMQGBSAKg0O8g0xEO/FjBdblpwaHXEzraQcYcU0EHpbDe8ERvr6/olQHGR2pWsqxRFF8dFV00nzJQJP5MeGwz2L30xgchJi9dGnQ8XN93cMf7SioU3JW8jxWTFFyFChTAZZv66RxXINpC41U38ZtHMk52gJsIxtPqmhEVG5eIDus3NpJzlQK9PLDrKRDsZBEw4A2hm0vDwiSnE3BJRGPNyi3PjcCfHgjhZT9cs6JARx7HDfxQ8ihVee2TIQppD1wHhIGzg6YIzveDw5WCsSIC3UvDssJlQ3koZymkdgr5JW0QDs5jJqpSOSzKmd9TqQ39VABk+84boy1Ta1TyA742NclDg=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Jl9Myf1zNbm0gYf0wijA+OBaOOxbt9GSrwEqGVQsoE4x9CMBtVtbL/CD1gqZOjfHZPUVmbci1UdMlSbSDP/caBCtNtmSrOpFiYgh0PbJ1kc1YXM5t05GS5pDoJZU2rRoR0NA/fZc+zc5xMbnr0vJiy7kydB1J+XND4wLn6d417mDpfjueTJ5X31Gg+q6yA3IFlRidQ1pQE7KChfumhwCTg4yH64RYI9YbgzgBAfMN9g07k5cbclxI+KeRcUSAs7T8fxXbAE1fUgoO9dTgi81GFjQUcuceEL/YZqQ8gCIB5xiTlZyKbZdHoskxD6Gm3WqjdYCeh5js4hvcMN0o2NJABHd+5i2mF0dgpF9xb1Rn/3WZixggedk4m8SBMHq3rRHIVfDz19MwSlGFlI3xSeS8EbDOSAMNaFakPiJba6VobC214+Y4I1oFsPPY1h4AOwT
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 06:58:32.2833
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53b3dfb2-7588-4dd1-8ee8-08de78f2485d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4485

This series[1] was originally posted by Vidya Sagar, and I have rebased
it onto 6.19.0-rc6-next. I addressed review comments and split this into
two series, one for fixes and the other is for enhancements(current).
I verified these patches on Jetson AGX Orin(Tegra234 SoC).

Disabling L1SS capability based on support-clkreq device tree property
is moved to common DWC driver, so I reworked below patch to disable
just L1.2 capability on Tegra234 SoC.
 - PCI: tegra194: Disable L1.2 capability of Tegra234 EP

I added below new patch to tune the ASPM parameters, commit message of the
patch has the details on the bug and fix.
 - PCI: tegra194: Add ASPM L1 entrance latency config

I added more context in the commit message for below patch based on review
comment in V3.
 - PCI: tegra194: Remove IRQF_ONESHOT flag during Endpoint interrupt registration

Rest of the patches are same as the original V3 series, just rebased them on
6.19.0-rc6-next and fixed minor comments.

Manikanta Maddireddy (1):
  PCI: tegra194: Add ASPM L1 entrance latency config

Vidya Sagar (8):
  PCI: tegra194: Drive CLKREQ# signal low explicitly
  PCI: tegra194: Calibrate P2U for Endpoint mode
  PCI: tegra194: Remove IRQF_ONESHOT flag during Endpoint interrupt
    registration
  PCI: tegra194: Enable DMA interrupt
  PCI: tegra194: Enable hardware hot reset mode in Endpoint
  PCI: tegra194: Disable L1.2 capability of Tegra234 EP
  dt-bindings: PCI: tegra194: Add monitor clock support
  PCI: tegra194: Add core monitor clock support

 .../bindings/pci/nvidia,tegra194-pcie-ep.yaml |  6 +-
 .../bindings/pci/nvidia,tegra194-pcie.yaml    |  6 +-
 drivers/pci/controller/dwc/pcie-tegra194.c    | 67 ++++++++++++++++++-
 3 files changed, 76 insertions(+), 3 deletions(-)

-- 
2.34.1


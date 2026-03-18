Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011046.outbound.protection.outlook.com [40.107.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7611F2FB084;
	Wed, 18 Mar 2026 23:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773876927; cv=fail; b=jnqVdF+r9suvdsgrTylt728iPNuLLtyvQIxfYoA6vBePXun9jIvryhzgmH99ea/niPI48vq1Ye6oPU2SHW8kS4Xnb9p+K3i6O/rFVLdzTeP6JhzLjceqDn9slhRx+Jl2A5qe3lJHSiLTeUa/KXnRxe6yIIBekSGLKQQMzHswk/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773876927; c=relaxed/simple;
	bh=Q3oEdo63bv1CwTDtbrbn8t6JE/QJ0VhaOz2F/+rDL2g=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fkZsQ3dA7R3HtebZRczhdX98opf2NAWG9El+8r6s+CdP5xFLdzpurRLhYM0Qaro9EtYV5MI39saTkKCaR/d5L7w/C1YPWy4ThKAha46ChuX1f+OmowF5RjyPgHmBqs7WBknSDi9hP+/kzQsK2DzMMDkXlHKJz0urZfnYOhminec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=f1W3fqsR; arc=fail smtp.client-ip=40.107.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="f1W3fqsR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zij/NwqLW6PJDjZ2g7bMO+pomxe7cuXJW/Ckje+rItPHKGh05BY475Qzgy5KeM37Cuv/eu3sY/3ayxPqVQv60z5e1KwiBgopcT5qd3nHbh8hF1rl9d15ZELOE8Lc4e1LV24SM8Pn+O6Riu1r3JHtxXMUyDkbdQgvSMzYuvYwCgdIbjnNYjNJXar2W9QLCf9Vi3go5sHhJvWY7bjSIvDx/SMuCerjBr/iHFtl8P8RgOMNxjumXuQarnlkTzXsjRDNhiMauS4hdt7s38pJjci5rJuNCMUBQ6pcDIhMp5t9Orsz8FG1w+n7NQuwx5Sc92+xm0cLNrmhek8usVTLKNxJtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UGrb3MvnmCACNIQgYsYd8ZIfl5hzQGjLRYEpgQWFrW4=;
 b=brtPAPI1JXGcv1vbNqKiRKO+FSfRSidyxwgpI2NXuS4DrmX1PEi3Oxl3bLfpkWt0Gxe+unQGwHHIWGRD/95PDDbD9hNfSO8Zi0L7GBmLrkxZzlDWvonpeS2ERxxDJ4S0YGwjQBaj89Jji2sFEszGSO821V6nA31WCXPWK3MpHpAAxju+VhSb7S5HkWy6DULSsrTbP6txceN13iyu3yx1FYuL6CVeU1yvmhKO49ibj9mGn5rwExNnOxQfh37ZJlpMNs5xu6odBuOqn0/ysXejvPrugAC9dT5Uv12KSbyCnWwVbAPEFVwnEgaeIGo69t3SAcW+ZxTvttG/iHbz443Cdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UGrb3MvnmCACNIQgYsYd8ZIfl5hzQGjLRYEpgQWFrW4=;
 b=f1W3fqsRq9SQlfRmj2l0/2uythjec/5pQjWKzp9xe0qGt+VAUZYfrxBpymTz+sAhH+trgwZ5PZic1TA/2TMFs2YQQPBz2PhqQIWHET9aij8TkJdoGHneW0dNC1I7MOkSo2jeKu2amd72LvYMwB6n8hntfy8QFlPhgS9+l9AgZIoojjyx93ew4qx510yMm+y3muv31KkPg83kjw6tEf41MMieY2l1lJ1pzob7L7Ljvgk54n0xuJ7ZYuVWqxTNw05v/2wppOE8Xgfdea7V4ey2kcLvHA32t4ukAWlc9Thn4uFC2EYycUhCQh2HxtfNLaC+7Dujc7qkOCssPp9u8NxNzw==
Received: from PH7PR02CA0001.namprd02.prod.outlook.com (2603:10b6:510:33d::18)
 by DS5PPFA33D606F8.namprd12.prod.outlook.com (2603:10b6:f:fc00::65b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Wed, 18 Mar
 2026 23:35:21 +0000
Received: from MW1PEPF00016160.namprd21.prod.outlook.com
 (2603:10b6:510:33d:cafe::ad) by PH7PR02CA0001.outlook.office365.com
 (2603:10b6:510:33d::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Wed,
 18 Mar 2026 23:35:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MW1PEPF00016160.mail.protection.outlook.com (10.167.249.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.0 via Frontend Transport; Wed, 18 Mar 2026 23:35:20 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 18 Mar
 2026 16:35:03 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 18 Mar
 2026 16:35:03 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 18 Mar 2026 16:35:02 -0700
Date: Wed, 18 Mar 2026 16:35:01 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: <bhelgaas@google.com>, <joerg.roedel@amd.com>, <kevin.tian@intel.com>,
	<jgg@nvidia.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <xueshuai@linux.alibaba.com>
Subject: Re: [PATCH rc] PCI: Fix nested pci_dev_reset_iommu_prepare/done()
Message-ID: <abs2pTxKL6pJzu7R@Asurada-Nvidia>
References: <20260318220028.1146905-1-nicolinc@nvidia.com>
 <20260318225705.GA479639@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260318225705.GA479639@bhelgaas>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW1PEPF00016160:EE_|DS5PPFA33D606F8:EE_
X-MS-Office365-Filtering-Correlation-Id: 926d6627-f6c0-4cac-3da1-08de85470510
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700016|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	NgfDgOrPyIJ1OcIN7N4HhgNkDBJp9dSwnNsYlt1C/L9SH8peYloRI7K1hmntf+/YYkgDAjlP7e8VrdpsPK8pw0cp1go1R5LNNa50xXbN0lwfepaA64A2/KIwaqy+acjo8xVvfoJGHq/7yOX2Q6+D/KSrNn0BaEcLeTHrNFJdBV42GdIjEiO0XlKJCuyLCTpzZymkAgVunUS76P6lk7YkmK7R8PonGtSOJLzFy+5Jk9lJd93idqwEZr6yjrYY3ZuKGKuyY5+4AlRdMXxStiWuVOrqlt8oDGBNZxfudbNjkwQYsulE1wNtd+swgfu7FfngDXs1Cwu/iujh33nu3vry8IQR9Qbtimo4Hzg8odGw572DzyEz8qNo+Yeu+hmG1UHnomVqJqs2MkKiAve2pMcW009kdwybWUj3OLSMskL3v1IqoVOomvDI1mDahnBDqtwCTdbCQKmGAi0GQZTGKNiv+gm+GFfWIOqLEJnhbyQolRef51relCo4TmwoAstjZ692UHSyo12gaNipkgvcC+HEyCqL3yOSAzpJArvwWdyEQsXDuFCzf6r0vpInK36GZeqvjIQnjGkG2Lbt9lqiijUVSujli913gOOQQYjmI64PWhlZSdqlFNchWDH1OVoaOXyUCYq+T7Pk08YZfo4rRCW/HHfcT9pf4B7UL/ubfBD58k0w2mFuTQlHfEhTw24B/GjbhanvNBfJRyNGDXohFqUjnHuWr1qUUhXoPGvzNr8ZNGV3M6Xd0rAsWm6NyJnHgDjNX7nnztKpvW7LBwbZ8+DHXA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	OwnKFwjGpsYpXOIWGhFpSQCnH/RIQg+7sGupTalj2q7lvaDZbPfDS/AS6x/T7aUx1VnU9jELd3mVCQaBt/p8bUwdRbnXRpHPvXqnZYt2obM85n6Unj7rxvSKl7bmmIkSXuyo+sbzCaAeqoBVlMuHbpPab7zlXWsIFU7m28DBp9Aw+O7k/P5xo7bGB4IidQ7R6Ya9U/rOaxl2l45LmZbHuAgizqqQEb0FFIE353OxL1oNvEDAUoTNV6njocO2j+jBHGkdp2PLliHHnkAZc0UYdqhS9biX1OU6YwBg6s87p9lRVwo0NQrDunlAojrnSnqC2Dhqc18+NdY3TmVyGHAfff1vKjH7/YcfieHV3SYaMyEOWEc2/KLBjd7ykhxTMBR04/cZpc6/d5wUQm0L2aVf23c2r582z5M3caBZAhbfqFSNIyoGLgoeVSLU/PrZht8R
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 23:35:20.6603
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 926d6627-f6c0-4cac-3da1-08de85470510
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MW1PEPF00016160.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFA33D606F8

Hi Bjorn,

On Wed, Mar 18, 2026 at 05:57:05PM -0500, Bjorn Helgaas wrote:
> On Wed, Mar 18, 2026 at 03:00:28PM -0700, Nicolin Chen wrote:
> > Shuai found that cxl_reset_bus_function() calls pci_reset_bus_function()
> > internally while both are calling pci_dev_reset_iommu_prepare/done().
> > 
> > This results in a nested pci_dev_reset_iommu_prepare/done() call:
> >     cxl_reset_bus_function():
> >         pci_dev_reset_iommu_prepare(); // outer
> >         pci_reset_bus_function():
> >             pci_dev_reset_iommu_prepare(); // inner (re-entry)
> >             ...
> >             pci_dev_reset_iommu_done(); // inner
> >         pci_dev_reset_iommu_done(); // outer
> > 
> > However, pci_dev_reset_iommu_prepare() doesn't allow a re-entry for now.
> > 
> > Digging further, I found that most functions in pci_dev_specific_reset()
> > except reset_ivb_igd() are calling pcie_flr() that has nested those two
> > functions as well.
> > 
> > Drop the outer callbacks in:
> >  - cxl_reset_bus_function()
> >  - pci_dev_specific_reset()
> > 
> > Replace with adding the callbacks in:
> >  + reset_ivb_igd()
> 
> This needs to say clearly what the issue is.  Deadlock?  Crash?
> Corruption?
> 
> I guess it's a deadlock when the second call to
> pci_dev_reset_iommu_prepare() acquires the group->mutex?

It will trigger a WARN_ON and fail the inner reset function:
	/* Re-entry is not allowed */
	if (WARN_ON(group->resetting_domain))
		return -EBUSY;

> Since f5b16b802174 appeared in v7.0-rc1 (merged by Joerg), I guess
> this fix also needs to be in v7.0 -- please confirm.

Yes. I marked it "PATCH rc", hoping to cover that.

I'll send a v2 explicitly mentioning the WARN_ON and -EBUSY failure.

Nicolin

Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010036.outbound.protection.outlook.com [52.101.46.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBCE1C5D72;
	Sat, 27 Jun 2026 00:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782521049; cv=fail; b=kcWziHtir37QbpfWYHWkRPhKBpt8d1XYU36jqnH4cIzvIjIeJ8nBnqrugSks84GUBbZvsB5Lks7Xm/yrMHjTyA3jCwWd8+bO5xiheXPdOuiR8tFKX6V6UgD37+9mBCQjSyUEunoxZJWgSba2Yp7v8af0nqnvB4LQtD82lQ2hEo0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782521049; c=relaxed/simple;
	bh=tYG+8ObdQxu7GnPk1VmtugnbHiIB2lGMTfxcEiSFRCs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YYMKmj5ieMogzkleHFWcoYiEIRIsb/jGYFO0TdEqdW3BIHrT3C/hjGA1+zD7bPfLs1XUnIfr5tNRihA9ozFOnBjI5YIMIZiTA2OGnLy6TZMa0orEbRF5CskEV3uCygiqAb7Hxqy0EyejlY8cG5s1Pg8Z3TfWB4QupIws7/MLLjQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FuajB8T2; arc=fail smtp.client-ip=52.101.46.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FuajB8T2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BZq451jfmcDjMsgChqi20MWSCy76z4UN5c7epPo6+ikQgPBlw9C8HZffi9qtWJQB2J40kjtZv7XtXDW1azDcZOzLbltoMa1iLSIrzLY5WrS2m1Y3rp4VnY2mT10CXyWLvn8i7kzWUO20VUX2LkhVeid+bMC5XLktlvQAmBv/69UtnEIOA4hU7mqaGd7bndFjXAL2RPjB7zxgsaePmfrTh0vNJdHRi5r9dqZ+f9unfgi0Su3oPWa9w9V8srqE03Iim45lyYLw9bPDVdbZHpuaBttkTEDY9DFjCTY9fUOjDvz2I5z6Lw2CqHdTmSTVRjXr30XnJh86pyEBa4UK6B6pEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=64zjSgv3P/Re1bNsvsKFg8rg8hvmMn9H1u2kLWvY0C4=;
 b=lVnGNohcJgXeKorwcmdea5xB6ZatDU8RvJWaytiEOgmp7+hNJr7xX6lLpDtopv1GhDPOjryeAIlhQDGJGUCWxzVa+Oq6/qAOJTAb1bOU+jWctgQ7ZcucFn2x/ttBKvp/wt+u3ZqjViRvV0j7stJsG16kHXvvVkcM3s41YO0PVvq/j9sDk7NUQ0l2a3vryVyujMBpFPpQZoXnYB1rHHy4AsuOum636Ysf5FRVOUN38Pn8HNNVPtgGqIHD3qLrljmJjyOocpUagq10Pd0M1vNRoSNuJLpHuLyfXXC9TVL9t4wGf4dxq6o8fSO1imhKilgwXPHkgDZVJaIaVfw9Qj4p0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=oss.qualcomm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=64zjSgv3P/Re1bNsvsKFg8rg8hvmMn9H1u2kLWvY0C4=;
 b=FuajB8T2NVL64EpwZ4AXHjlcMq17a0Z2CokhKVm9+006CEn1sE3f376hvncaM4T+5iNIx4A3sD+Dotg11a/Eflnw54eY3/E4WuptHoHlYEeAvvhUy+gErHUOE/5ZlAhg5wrwylgQ7Qu263Fca0B9CauKYNp5viq8bjz6csY4gioRfAfI24GtTqBa4tUZfxwL/H74XO362v6B9SDs541cs0ekqw/1XeYVWfBgeQ58Cph3upFtphK/TP9YI7rwcZVTIU43MFs+VVj1FMSOpKWDmG+F5pn3kWz8l87fGIPW5gvahXR+JnD1JwJOlsClnHeoH27Se2yflw++7IPJgzAIfA==
Received: from CH0PR03CA0189.namprd03.prod.outlook.com (2603:10b6:610:e4::14)
 by PH8PR12MB6673.namprd12.prod.outlook.com (2603:10b6:510:1c0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Sat, 27 Jun
 2026 00:44:01 +0000
Received: from DS3PEPF0000C37F.namprd04.prod.outlook.com
 (2603:10b6:610:e4:cafe::70) by CH0PR03CA0189.outlook.office365.com
 (2603:10b6:610:e4::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.17 via Frontend Transport; Sat,
 27 Jun 2026 00:44:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF0000C37F.mail.protection.outlook.com (10.167.23.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Sat, 27 Jun 2026 00:44:01 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 26 Jun
 2026 17:43:54 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 26 Jun
 2026 17:43:53 -0700
Received: from nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 26 Jun 2026 17:43:51 -0700
Date: Fri, 26 Jun 2026 17:43:49 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <harsha.v@oss.qualcomm.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>,
	<joro@8bytes.org>, <bhelgaas@google.com>, <praan@google.com>,
	<kevin.tian@intel.com>, <kees@kernel.org>, <smostafa@google.com>,
	<baolu.lu@linux.intel.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <skaestle@nvidia.com>, <mmarrid@nvidia.com>,
	<skolothumtho@nvidia.com>, <bbiber@nvidia.com>
Subject: Re: [PATCH v2 00/11] iommu/arm-smmu-v3: Add PRI support
Message-ID: <aj8cxQ4qDo603gVP@nvidia.com>
References: <cover.1779944354.git.nicolinc@nvidia.com>
 <2a52ecb1-be8a-4522-aa23-f3277f0555fa@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2a52ecb1-be8a-4522-aa23-f3277f0555fa@oss.qualcomm.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37F:EE_|PH8PR12MB6673:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a4498fd-eea9-4242-101b-08ded3e52e89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|376014|7416014|82310400026|1800799024|11063799006|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	5/CMz7L2LgyD0FA5GoZ3xoSlEOVh5sJnO3Y0fx2lZ8fSqRsmqaM3qJ5bQf+fmk5h1ILSalwafC2nXUMWHuGUt4bsYCBbwZlz1SAHuHM4k7/+CZTK3+ogbbJa4mb+Bfw4mhCgAiUpZq6UMOw9WuCKtkfeFtRTc/jq3l+wf98lS/+MgkuVOq1tRQ+qcKf8ajhRGnmRVxwcTt9X+RF2TkkNm8ERBv8j8uoTbLi0ot6wY76kcqaQnA6KRLQSEfTRGXI9SKBcxw+pkwxS5JpvM1mruMqLLlJhGjFLVrKuRL8nzNFaofGuojKeyouxis6dF5NO1gJ2Usv9lxn8/J0QQnAvyFeRaK9arAoDOYAyfMWmmMHRZTt/OitknunLLp6ijDdL5ej1uz2PiQKjnj1dzLx3GuKB+nFFxQh5jQrjKxqgaC0ea9DYDgS9Z9Cm7is/fcScGK4laUHSmoW1/nNMxh/9jW3RujhzGCsX9eCC5u4UJ7y1RoBpKRwHH3pQt3GG4FjQOxRHjAd20lRaTId1uGMB28+skiVKEDZsBRROdV4TwoIvmxpEyCZGHfY1MI09BZJbA6CkNcUZzQpSJMDdBQmcnX9zw2kU6AvqnF4qhPU0laXmqE8APqJuJ372M3XFEdVD4dAIIpZzSGrhsN3ksDaqQWnX43kSPYkBmist/3+Ql9X/yq3ydoZW6x4u9qapFTXHSfz/hOIzwRgYV1LCjSdn9A==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(376014)(7416014)(82310400026)(1800799024)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	8nLKyoPBnQ9IS6Lo1Ql+tFn8b0jkxXDFITCyz2aI0BLbaiphrpsEiNKCq3IN/cKchDJuLR+D67uhrm7GMhPLpNjvBQw+TrGXBbOCOxufeSL7VrYQCyf6n6CMye3RMOX6c/XJ7Ga6qxKTEWJnZ7snlAdwNbITJ8WJASRRW+uaoyGXlrbBbmNwVGpigVF201OBsbDNcCNDDzmynFnSlOcL4mgEeBeGU9laqtEr7UnCJ4B3ecLkr96y3UdLLe/ICClnD8NlSCof642wOfu2m8cPpq1V0a6voW5ACSCeBFcgE3Lpkdobvy2XYEy+FeKN8n13ds4ObLVxcL2sSMl5Yc6in9IcPxhr7KnRV1rHDHE+mX70gLpoNnVMbkqclVB6Hg3u9br94W+Ql84mUr+iiy5UjyHc9q71D7uL9gITTiEl5f44Q1PJdWoln/sh2thRA4iM
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2026 00:44:01.3749
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a4498fd-eea9-4242-101b-08ded3e52e89
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6673

On Fri, Jun 26, 2026 at 08:24:31PM +0530, harsha.v@oss.qualcomm.com wrote:
> One thing I noticed while reviewing: when arm_smmu_priq_thread() detects
> PRIQ overflow, partial faults (non-LAST pages stored via
> report_partial_fault()) whose LAST page was lost in the overflow remain
> permanently in iopf_param->partial. This is a monotonic memory leak —
> it grows with each overflow event.
> 
> Intel VT-d handles this in prq_event_thread() (drivers/iommu/intel/prq.c):
>     if (head == tail) {
>         iopf_queue_discard_partial(iommu->iopf_queue);
>         writel(DMA_PRS_PRO, iommu->reg + DMAR_PRS_REG);
>     }
> 
> iopf_queue_discard_partial() was written for exactly this scenario.
> Could we add the same here arm_smmu_priq_thread()
> (drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c) ?
> 
>     if (queue_sync_prod_in(q) == -EOVERFLOW) {
>         dev_err(smmu->dev, "PRIQ overflow detected -- requests lost\n");
> +       iopf_queue_discard_partial(smmu->evtq.iopf);
>     }
> 
> At this point all surviving entries have already been consumed by the
> loop above, so discarding unconditionally is safe — implicitly matching
> Intel's "head == tail" guard.

I will fold it in.

Thanks!
Nicolin

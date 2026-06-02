Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012031.outbound.protection.outlook.com [40.107.209.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6023DEFF5;
	Tue,  2 Jun 2026 12:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780402115; cv=fail; b=CPwmuZlsV2CYHkvN3GNYf4TuPecI2rhPxOFGX1dnW3Wa1c21VYDh9XHNFrJmPSYr2On35IGFS3JylWMtTo2xXDr/FlKLYxR6PlJPBPkFr3nZ1gbYoufcH5fbuO8/32oLjKd6qZVJp4MEbM4GHjhAlz8zQi2Mu7gVMdHT1M0mH0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780402115; c=relaxed/simple;
	bh=G6C5j+1in8X81z1kV3ST99beDVpWufPyXeGd7IXUNjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mvNcOm7OqoPMIIOF46r8kpm+/mGuINdG2BatHpOUDh9BOpixNcVz4XQWAjj6YINB7mDCJZO4k6eigXQ+mkXTQsq6FKoXMnrHrSpFhFHht1Ee331/2nqcZu+j3xqssonFG+dD1dlYO4gsUOB4V6shEzdJ2COBvV/zR+Dg95vdZos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BRPQ2c5F; arc=fail smtp.client-ip=40.107.209.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BRPQ2c5F"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c7xPewRuajGBvQlxSb5xW55IRm3vvbNgVJB7P02w+u1t8j2JJJleSmLaoavc02YTdQIvlkMZKt89wO+w/fnjPiM2erm0/yb6WxjyWVaaOxpqd11PtvNjqyBGgmNWMq2ljnAJnIGf4F1yhoPZEoGH9WgmmA+nynKkvZz5iqEFmcCQFaVpKMY/IvRtwvZXdh/wzFP+8ECjezqmxadSWeBqQM7/6rcpW7F9MCJZaoUc7ma1RKNdPq23Ui0xj4VEU8LWSYKOeS6MKNOZsUUgA8b1FEQiLx6XmQ/W0D+adZ2Xd5tOWjjXHQ/UZcIMqqvoP6QfsrBhO+qWBmtXMNzifvqI1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Se/NZzgO0WXjciY54YxGZzzopqt73P/rfJvoxfcjmp0=;
 b=D/ShxDA2LVrnVkZkb/8Z9X06aKSWK7ki4lTO+lalzd3TYnjq6HTczcvkMH3Jgb9qKvfUwu6QzfLDErlZF3zk8vvaOSnKXPeHfufEuACduzs5kMmNt2uoP0CTBDx6oTMcjWK+oqcODm7/O7XCPKRAMOg6wAdZFrtxv69EzI7ldwuBYQ8+jnzOW4Mz+9HoJ4wWfqWUqzYCJR8BdUCW1Ty9Zrd4Rlu35hMxRBYVB1pyMI3bB7ZdqqZGH2UQxcSsxDhoQBktx0L2h2ukkrXxWvcH3+8svYCW/Sdai0EAveWZGaIaZ+QaMk/yRGLfHfqZf3vXO0F+L8JH4QG+pd4XCcEY+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Se/NZzgO0WXjciY54YxGZzzopqt73P/rfJvoxfcjmp0=;
 b=BRPQ2c5F9Wr8luLob4UFXAI1gUPFP13yZN32GPpaIDbHKWLn7WSiVLjx1rIjCIuj6pVmQcN7/wpmhhZmHQxWmWh4vDVXQksnM1xJdx197//tlMe4k3FJF1Wt4B0UnYgcePPXblpQPdTe7T2SWA2uLyEOb04OpDzkbdyOnquSWTa0r0T7pimXaaaQYcVZmNQs+YWeXi/wms9eAgVCl2AbaUJaS00wy9uFE/mhQb8bny8Wd2RTTr5d/XzusOG7UIihtHdYZSUsEo5xpYEnDKtdbzwiEiuGt/uc5srtG25AIL7JEI6bXGt2luF6RTAwMLZVRawv3DJiZJq3Q2+JhDn4ag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SN7PR12MB7177.namprd12.prod.outlook.com (2603:10b6:806:2a5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Tue, 2 Jun 2026
 12:08:31 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0071.015; Tue, 2 Jun 2026
 12:08:31 +0000
Date: Tue, 2 Jun 2026 09:08:29 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: Pranjal Shrivastava <praan@google.com>, iommu@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Ankit Soni <ankit.soni@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Samiullah Khawaja <skhawaja@google.com>
Subject: Re: [PATCH 0/6] iommu/amd: Refactors for ATS updates
Message-ID: <20260602120829.GS3195266@nvidia.com>
References: <20260601134204.2150602-1-praan@google.com>
 <62a4a7bc-091f-4d9b-a0c2-b2368fc399ab@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62a4a7bc-091f-4d9b-a0c2-b2368fc399ab@amd.com>
X-ClientProxiedBy: YT4PR01CA0448.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10d::22) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SN7PR12MB7177:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fde36b1-8c21-45bd-7f8b-08dec09fa972
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|4143699003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ctVBFeG1sU+zm8Y5U4c227FZigp0N/u2zPrNFW4P1ZcqOi/1Q1wWD9gxQVrRSW5X530sngAGSSn8w2f8O5V3EFBWVS7ptRys1ozT/2k2tVizs7/YTaSvdM5PKK7GgIU+wS426u9qdnYnJcXxo0YTD/TmzpuLn01I2Tw7Hl529HkCW/oU6FaWyGQRflz+DVNmQRSm5f/9kFlcvKM1er4cRuzjjTkx9k9iPqS5cpcHnhsBp0ruc/HeHNxH59BTBLuJWd0Oi682QAXr5Jcd3l4B2JD4lzxf5cWqQjucbiCu9f2fP64cFWVNfzFJGrVGpUNy4+h+zjnmLvHsDAJN1HrM3XwYImTLZOZD8z6SwJ5dCYQXldoqlx1D6Tqe6+hkvXgcB2qZMIlQ8fZWXKXV4k0z2DhLzvAGBVH/y7YAy+3CVVTLn9hLVSKU8ptjilbpggvdXxL7J/iEK+rikgfHk2ay7hwjPrhfiusdQGZYc3IXh5gz7cAUPugtj8bnjkMCXAhdj1SEcT8EhchLmGpuof5A9IbiTfdsGLTPHhXZnr1dSJk0G412dE++bT6I1+SnfSYJ1iGNDmk+k6kf8eyXomD4a9E0YsaUMBaFw6cQWUz2SYcB0H5wa4wfHzQ1hF0Q0e9O2VmEhF7/1dVv9k8zMx0y2tPlKyUrQaZfULg6bvilpfLZfPX+5bUp22iP5UyFl9yy
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?G8JbbKr4S7FKutBPERKekgcoazuU76g1KM0IIPu0IQ4X0K6wRziI/oVbh9mW?=
 =?us-ascii?Q?3vaNkFftWRm+D2dKM5UoLsX4ppDdKXDlLtGD09Y9HOD3JwIbiGuO2ymOYwQz?=
 =?us-ascii?Q?7LHZayLtsUm2X09rCTRGIky5axkO5zYwmNOe71mA3wH4x8NYatJ1VSF4Zh8R?=
 =?us-ascii?Q?/ndVy9BpNkT87ai40RwdQ01K7AgJo56pLBJT5GUjZ4TyG52gzJqwZdv1QJpv?=
 =?us-ascii?Q?j45yseP5mnrC2QQw6XoXo7du5T2KCaYn7ywfjsyh31jDZFHAmccgt0ZGBPmE?=
 =?us-ascii?Q?1oL/HAkqF/cG9v4oYw4FTILP8PyPdE4w/e/UaaDfLOK6C7ZpNEJM+32yztT4?=
 =?us-ascii?Q?4MYuefn5RXtXV53roVY4zQne9sVyJj9NKq3wEaJKcN5az4sX/iXK+rO+c/M4?=
 =?us-ascii?Q?8qJO1mtcJ28WyCFmp/KWQVWqfinpgYt8sWNBHw5lxHB9OXkyS+ClS6ZkhuT2?=
 =?us-ascii?Q?kKb10MZnZgmBU/geCuJUh9Q33nbffdwqbRTeIsLO1fAr7puCaI/lJf/CE6Kt?=
 =?us-ascii?Q?Um1WliCG83v9MVTv+bpNMH/cLkbDDD0dgBYWt4Vy24LBx0vuzh06W2kaiv8M?=
 =?us-ascii?Q?ycVHYRcpLV7lEjraKFRDIJdA/wgyGWFh3E2RgpHOq9xXJQFWODVkuHiFpiHH?=
 =?us-ascii?Q?vAngjLE7mzVI7KSchJwzi0NBnNow0V1yLLbDxjy5ptGolZBB5A33XW8koDju?=
 =?us-ascii?Q?GS4HkaWHzuT9hbIbcQ8uMTH8EcO8OHO+yyqAeNH2BeNtq7jEr21QKGf7EnFw?=
 =?us-ascii?Q?E9aCnXfwU3BEq94i50KpjHWdfuG/y/0SgfqFlk+3NM2MJDpoQFtvw19+RB8j?=
 =?us-ascii?Q?EnxbfMboTNA4KEyXW7nxIfHr/LV7ZX29wBEUxxsUmrGVv141bXDb2eBZFyMR?=
 =?us-ascii?Q?HjalpmIgAlBxiZJFMDrgA20twHn6+fScIlUu7FjXb95pKyHQye12pQFMgx+P?=
 =?us-ascii?Q?zRiymla6L0ddbJvUGNDEQGuSBJwmadLWqXw1PPETG5/wMY3vI9dD9ceDGR+Y?=
 =?us-ascii?Q?MWxcQ2oeHj4fVV1lXfLoEGBW/rQQHzFKQzXDR5vlhkj9QuLpOkNTBe6ykmd3?=
 =?us-ascii?Q?lcIDBxuqJ+/Yf3TXUikPziUD1z+sKLU329ZO9+AL1G6hGif6j3M8oBu1RdeW?=
 =?us-ascii?Q?PwR6qpvV5weHoHIxfVKbMLeh/U2KQPFYeJpUw/SM0Dxme4q4hwbhUpqSMP4p?=
 =?us-ascii?Q?UyPbxhE/+u0vhfoYoG8BboYk0zPQw5e+A0tIcGxNL1Av0ycuawombARa8v+J?=
 =?us-ascii?Q?HI4hstth5SLylCEFaShF/q6s3XQ6kzZMH2/w0t9cq35AFB/2NdweXjrJXW+P?=
 =?us-ascii?Q?ziOKh6Qd8ekvdUsqENAWYvj/BHrqDegiOUqDjSr4dCt1cJZMAahah8d574OD?=
 =?us-ascii?Q?jrtjj6QqnL34q5hLIqzK28sxsolFWiclHJeN5QVgQLLAk4GK0NQ9/XYwEOLq?=
 =?us-ascii?Q?0bavN5ZH0/lkeC2K17nyB26Yj8YF5wGibf8XeOxeGfhvRbsMVz7etcW6q3me?=
 =?us-ascii?Q?NS3LNwEpxIdoSr5TPivI1kX9QwP3DXKdN5/B6brRSePypRdngvu/wrA2AJQ1?=
 =?us-ascii?Q?H7sMoWWcdRdUWBxTcXcTVTp/4J4ZbB7hXuflOXqWIey1RMtewKynqBHSv4FK?=
 =?us-ascii?Q?pR08jU/dxqLPplaCrRRr57w4Wf8zruJmt1ZIzwGJ7+9sbYIGWkRQh9XLXejI?=
 =?us-ascii?Q?BNgVJOB9h7cheI987yfPee0R0/52h2vwPgyb/OWFiqMBnfPK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fde36b1-8c21-45bd-7f8b-08dec09fa972
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 12:08:31.0978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 12+4OVIx3G/lwYdOLRhBu/S/SKxkBeK3CfYiKAP9nsqFxiev4R5IrSVAHgTXPiC9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7177

On Tue, Jun 02, 2026 at 02:19:54PM +0530, Vasant Hegde wrote:
> -static int iommu_init_device(struct amd_iommu *iommu, struct device *dev)
> +static struct iommu_dev_data *iommu_init_device(struct amd_iommu *iommu,
> +						struct device *dev, u16 devid)
>  {
>  	struct iommu_dev_data *dev_data;
> -	int devid, sbdf;
> -
> -	if (dev_iommu_priv_get(dev))
> -		return 0;
> 
> -	sbdf = get_device_sbdf_id(dev);
> -	if (sbdf < 0)
> -		return sbdf;
> -
> -	devid = PCI_SBDF_TO_DEVID(sbdf);
>  	dev_data = find_dev_data(iommu, devid);
>  	if (!dev_data)
> -		return -ENOMEM;
> +		return ERR_PTR(-ENOMEM);

Why does the AMD driver do this? The dev data is supposed to be
allocated during probe and freed during remove, it doesn't make sense
to search for it in probe - it should not exist if the kernel is
working right.

Jason

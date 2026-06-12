Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011029.outbound.protection.outlook.com [52.101.52.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6BD392C2E;
	Fri, 12 Jun 2026 13:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781271408; cv=fail; b=eBQ+5DevKJB4fbNonwfj1UJWmM8yKCdkInKMDiNQKDbZqGv+BOGvRpfZR6afhd76g+j38tJOiWx18H+8q8WOpsce6fd3j8Qj/EuRG6ZWQQ/iy0svYVij1JmpQTfehoJ/MxSOKEZkVwMA4wKNcv2xKBJRQ5RkQxTtKwAw5gCHCAE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781271408; c=relaxed/simple;
	bh=mPx50copXHFmLbQ3fFBlOqlsOwvu+UUTvfm97kmA/k0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ajYGqOUn8UF9Zu/lkGRDums1Zsibz9kVLeHC+gj/hwTYwuGYksblgubawr4jsNiIDbj744qnSYZvoUwknETVTHeWTfARWtaO5JNIXhJpCIwXeOLcMvSX65dQz4e7cTdvSFaJWj+sTuj0a/3ibYYLeCCdw12hVK3/2gJv7NIaopk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cwE6ZPdb; arc=fail smtp.client-ip=52.101.52.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cwE6ZPdb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xlV3GUcL37FwdmTn5/iyfFE1VQWW9jsott8J5MrD+e51Sin09daAiXQrSyxxYz44FL6B05xVVLRPApRM/gq7Y1fsTb+hruN/gFELjVBEqSzxKF5Fh04KimWcXrPFs4NjN5Hj5MqsfDpWB1L8mhfOsTNVpfuaz6bkucLlrxM612Pods54iUku2bK3pZadTWv2y2Qm4NAlq3282dJKbomDdw9OJHVzi4GIHsS0J+jgzJ/qwOPdjxcaEAFXxVVMsrsGMckH3WaUT8ia2eKujW5p0epAjg6qviUmHQIyy3x+WMNx9YBV2kxOkme8+fUhfYF/5QyxHcFg6D14ALrhv02Hqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6B+uqQz7p9tpHfNSH9TVXCbUgLVBbD7eCZdjkAnHKJo=;
 b=xhHLzU3X25dpTO+OX7e93GgMY+I+FOo0iKgVxOA284hoiXwlWWkVkkBMMaUDtUhjhrSE0uaXbIDNMYLN7eiPwSg/L2uR2LsDkcf8OJzesOVQ5BUzHEse6D7q2UMUvphBA977nGgT7BTolc7jm7jtYTIXN6r/WCb1WcXZMPhmHknXT5MvLov+nq33JumYt28ATJ3CCTsTQlJ6Og9JmaS8LEEfrwQqU4GoMLwG5DQsHq8pZWOOpAPf3Gg3+rlsopOhYCwiEbifE3rEv/ghDgRQ/dFRwsV9IR+n1XeKVCjLd4jMiZpTVAddc10JS/ChM9/ZuZv9Wkfy95EjDXeCwKvA0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6B+uqQz7p9tpHfNSH9TVXCbUgLVBbD7eCZdjkAnHKJo=;
 b=cwE6ZPdbACVqEln3SBF+ZYvJmm0nx3SLJBofJiHE9G+of5g8kkIfvFYyJqIw8/FznvGjqSEmX2HXB98pErR5em5yxQ+/EevKkarctOrdUFVvhdYFtGPdg2cv/baUbALhZIneFY/HPw2JmgWlYkyM/gn1gRyQ4z+mlERCQhoFGtuip7RCxYgjMVyoEGo+ZdOErBw4pBNY1wwa/rNniHGrdCcmQIYYQ0bz03Vt8Lz5KdZvbLdJB/e7gxKf/CoKnsrCUxDcA19X9SQTd7vGW+YjVGJ0RqAa9zbbM4ZZ81B4+WlL3u25qdJoh6Iygg1WR6wHg6+QolgyyEHfSK/HwucWxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DM4PR12MB6494.namprd12.prod.outlook.com (2603:10b6:8:ba::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Fri, 12 Jun
 2026 13:36:42 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0113.013; Fri, 12 Jun 2026
 13:36:42 +0000
Date: Fri, 12 Jun 2026 10:36:38 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Baolu Lu <baolu.lu@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Samiullah Khawaja <skhawaja@google.com>
Subject: Re: [PATCH v8 3/4] iommu/arm-smmu-v3: Standardize ATS enablement
 failure reporting
Message-ID: <20260612133638.GG1962447@nvidia.com>
References: <20260604182116.3179005-1-praan@google.com>
 <20260604182116.3179005-4-praan@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260604182116.3179005-4-praan@google.com>
X-ClientProxiedBy: BN0PR03CA0006.namprd03.prod.outlook.com
 (2603:10b6:408:e6::11) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DM4PR12MB6494:EE_
X-MS-Office365-Filtering-Correlation-Id: e5c45e4a-5d20-416f-d490-08dec887a3ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|23010399003|56012099006|6133799003|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	jOyWjqHxQqIQF3S5S8EFKwcPdqatKkwhgiof7kkXAvs+rVmDEfQrpVpkIXeqkZmgu84zqAG9e9Fq4OEh8eLZQdc2mCGN/rhx9p6TxqdGs/tacY2slMI20ZuldhA1EdXPETztevX5k/o9RtFFll97w32zRuZf89I5SWCAShla2DMyMq8CzzeHCcpTHjGU877rEOWO7a7JGsjlN3H9hcZngAi4KTVZXmgL+PWg6MZLYEWCQJsZCggYMdGDVdYkdAv9hckpWb4kaMPf1sXKOU43XKBM570QKf1vW+qzQ71Z2BZXp3dOW06nU81Fl8iWr1dgaTLIAZyjRgeEE4ZiYYW3r2JmdHIjc6E/opDRPVpuas04AsfeUmbkVW/L3peSEIikQsXyYth+se0GQ2zXj3rSFNHSl6SdvXftFTbsvebE+dGKH6EUUSLMEWdbHCxCMZUZlwxA2YVTx8+KRKlRcvl0QjjzgUFdDZ96iWhGEo1OblY6f8lmkZSC+b7JI0WWpfAX15ALmHvXuY8QeuXPMv/qzgTWaO5LtYVbGfvpCvAMSi+lhMb2xJGJsAtKNkqe2VhHjKpdR9GtqH/U0CPiEAhA5rU2bH6uT2z+wVTgbeNMRjdQNCHNOoje1h8QYWQnMOoDe+Ky9uqjfzRLniPbSYR/qK7hLnBOrWh17Ic4JBfkXGlwueZh194ig19sjWu9G+E4
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(56012099006)(6133799003)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ur8SJ7nQkeET8TKodpZbV9ZJS5BG486Bf1Y7rsSHRNYi2P36AzZan0zUWpa3?=
 =?us-ascii?Q?mYn9mEaztQQRlAeIQuQp5KsTG1DJvtqqllTsH6GlGDXiyWgltFtMUv6sHDTa?=
 =?us-ascii?Q?dWgtsIywXSxlkl6qdRCKcKVKKJr/Ahip02PTB8CIIbhVGWFL/i+xtVNifVCN?=
 =?us-ascii?Q?85TU1Rg0adGREJHJ38uE2AZ9a56kQ+5+z4boLgEIT3moYN3mG1V/jJ9mDj/N?=
 =?us-ascii?Q?PIM6aadmlNFlIylJ7I+xPiDfK6RAIBv2iO5UcOf3e5HgGxlcmN2gER6uYDmy?=
 =?us-ascii?Q?QJ/4QYqcR3WaCQVZpoi/jejcBHToGDpgevUJEbVO++JydZJ8BddZuySWmjl5?=
 =?us-ascii?Q?XSBAC10vCFMuEvCZnmSub13BnmkfJS3DkPAhmsR9vgQSB38e5nTNKNAlWe5y?=
 =?us-ascii?Q?ePsw3O0YhJcgN64PFTdCI2CsEsI7TpfhLYCabvQTLb9vqW1l7LN1KezEhFxS?=
 =?us-ascii?Q?AadwiNMNswcfNcFhbp+XbZ0vfPoDorokDNE8GKLsgdiyB16x4w3iWj7U+Jt1?=
 =?us-ascii?Q?IcgWmsZc0SWedBMLxy8mwwT4K4vJDlENGb/AOyK1HSaKJfRSfRmWQla8kKQ5?=
 =?us-ascii?Q?2rvjekLjPI4zeIj1Zkw7WBGz+HuoHk/18tt+9QkHyG9QKEtE7EP2rMsh+zkF?=
 =?us-ascii?Q?Z7jIQ3nIt3Z9bvSjf+hqf3Vwz4TmdnBlkSoxg1LAa1Yz1RyhrBf/iWYpFkzz?=
 =?us-ascii?Q?1qzcso31FIVEuHH+H/ChGsNM8XEk2NOnKzRNeKBawSQrCQT8O5rddHpQgPeB?=
 =?us-ascii?Q?mSZ7eEP8Hwru4JAPiEsTIjplNIY8arfTQrJrr+Yu63BPmLQRyrmeBnTZehIC?=
 =?us-ascii?Q?BJW/F96bbPLwrIAbV1RJsyjC8IJI/gNSr76PcZiEz6I5XGqNe5QDzFqu7FAR?=
 =?us-ascii?Q?nMrAt20e0ml8FbrW5X/xGV5sEZCFl5eVjCIA1nY4pspCA5dPh+e/v27nmJQ6?=
 =?us-ascii?Q?y37x+QeaGCSy2sa434/pSX3QF4rqRyv2Vy1gQgY4R5VP6ZzixZUKmIB78oar?=
 =?us-ascii?Q?rEvD119K0EsL5VECHgnni3h3g3o4fI7/fW1RarZy/bi7zexrn2lubwJuj4+E?=
 =?us-ascii?Q?WsYdQWhI63XwOueo2lPj8Jo7WPui2j3eueeWt6SATsKezI1MYXZFnoO5K21r?=
 =?us-ascii?Q?1z44JI6bY1pk9uvf/xN2ytLxJ0DqPi8q5vFbrjlyOxCUAETYjwQcSPPuHZUB?=
 =?us-ascii?Q?I5o75LSfuwnpj4jK2/7pRdJR+1MGoEnDd1x40mTEHhtnGqoVjL5zUrjRBXB4?=
 =?us-ascii?Q?w2QfJZStXtIrNJOs5N4+vSNKnxcpAW26GRw94hnIT6EXM7M5O1JlEgHC5xg5?=
 =?us-ascii?Q?ITirWLGBFP7CEMSsvNHolbYL4+wL6Gz/PkhaBHW1PELXsstpgXnKcyNhRlTm?=
 =?us-ascii?Q?2WTO2k4CRRa66hbnP7S3gkpv9YqVcYij0Qukxgl60vc+rjH4Ltawmwlyp53m?=
 =?us-ascii?Q?iqc6ZEWeDqDYPtZ9kqQRLla/kPrIS1YpITlDwbb3JmoQarLmRI6+sb8UtHsL?=
 =?us-ascii?Q?jveIAK3zcbMYrIMF6RhH73ln6G+nt1Ed6BLdADZbFC25R49Tt4lOJrUl5P91?=
 =?us-ascii?Q?mjy4svyvZFb3MrrN5Mg2S8whdR+GsNnHvM+TF6Kf+BxN1t/r+L3YT2GFSjNE?=
 =?us-ascii?Q?+zfiINLeArFZStGdzEIkKTswYXYDp17G+QMdwYOURl3envr0mz/FV9pA4SaB?=
 =?us-ascii?Q?nwcvSCojIoGTlAHxnqT3pMiOt9E04gtrFNrustz1e5vWBpy8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5c45e4a-5d20-416f-d490-08dec887a3ba
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 13:36:42.8070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d+jJp02MNMCSv5hFyHNyhmONOgAY544nioqWoIZ47uN+Xw+ib17mjuqNWoirWhS6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6494

On Thu, Jun 04, 2026 at 06:21:15PM +0000, Pranjal Shrivastava wrote:
> Update arm_smmu_enable_ats() to wrap the pci_enable_ats() call in
> WARN_ON(). Since probe-time checks now preclude configuration errors
> any failure during hardware enablement is considered a kernel bug.
> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Pranjal Shrivastava <praan@google.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

> +	 /*
> +	  * Since pci_prepare_ats() has already verified the HW capability
> +	  * and programmed the STE, pci_enable_ats() should not fail here.
> +	  */
> +	if (WARN_ON(pci_enable_ats(pdev, stu)))
>  		dev_err(master->dev, "Failed to enable ATS (STU %zu)\n", stu);
>  }

I would fold the dev_err string into the WARN though

Jason

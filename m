Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010006.outbound.protection.outlook.com [52.101.201.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BE04A49A0;
	Thu, 10 Sep 2026 14:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789051221; cv=fail; b=PAAoUiy0NcT9s6sADy5zIqEm1oMUu4Kdq7LSO15Tf0wM7vk+SLGKL8ACKLRjM7KHFIVGCbVwbzYYJCb0vBV39VDTqQDQvj2DiDifTii3j2PDnnKd7u2PnyhNX8G1f63dtJw/rInLxmGhYReulcCx2c2ljaWFeFG1+ANtxgUbwvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789051221; c=relaxed/simple;
	bh=mFERtMBjiBhcIwI1Ho1C8NZpAy8Jy+GseBJbg9z8gl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kk/k8RBGzJorge8XZNQUU8iUC4m/2v+lbyJdoZ9aMMkg2KMG7geHfy9J4h8RJzSa3rAmTRfoAg76cmTq+UnbFwUdp+PIY0NvwJZK9g7Me3efVu7fby0pXkJc1mJDfdIHgY7yhvx9y58Tv4usRM/iCiTQrreNEDnq8b6KzHPdRQM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MSEco+uv; arc=fail smtp.client-ip=52.101.201.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MSEco+uv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hJpPFJTyAGNzOoTQfPj101P5bjzI2/wixjV6ghAG8gUm8ZgM3NVWvn3fMtCjxjfg7ixxAhNI7raCF5Dv+OZL6VLjJhHt1fAGjbYMLfA69R3iiRN/RJEcY/eDyPUF9fiFmWqHYRL6ozIWP23mBNngHhZzRa+0tqs3N3M1qUqCKmwSUMu4cUz9GgXv9DksQT1NQtU3ID6P6b8gRE2pJrUTmseFd72Llxq+QCnLa42EAslyaolZO4kK4QZMuHcauxBr67CGwNCaL6jx0mIjlqFtHDN/k7EesNB0kNtsqCkzANa57W8jrBjZJQAv9UiBFgbOqmdMkvFnKRdL/2qKGYfQSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RK2lHbDOkytFhmipdF8NzE/wHVKv91Oz/GNOOVaQ69o=;
 b=f879yQe1PcoKZwgzM9spJKcsiN5awX16wawYOxV3ZpekKliBrIsJNFHvgf2OHjfNkCDN1hOSZBqLcKz49d8j4QZHin1xYNnc6xyAP2Tken4XHXy/WeKl6PW4zZ7qGdOS1dWMd9awyYAwN9+7I1qqledjPa99DVX55lHVpP4NVaEy0SQL6PDv7t1PkqjNjJxVxELQaSFvzdLkjjKylZssITJgcVIURAdVJmPyOnObErCvVwuWXW6hWwWrXx3MOHhSDSonlTjz3Yuh2CiSVVLCM/lRSLVm1TvFMupjk53liO2g+AyDVOSB/zPcfn9q/k28aT8Xy+ECAS7c9YWuk7CqGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RK2lHbDOkytFhmipdF8NzE/wHVKv91Oz/GNOOVaQ69o=;
 b=MSEco+uv0oyDX/ivoDIDj1mT3UICFmY8xQtPyVH5cYH5D81QgTUVdeaDIQ8YbxrJ27hwq9xYNY6/l54qjhVPzHA45x0BEgYmJXStOZIxCfi9IhqLhRjAOLdOCRFQN+ZaczbIpHw6wza15CYHLygb/HWoDvAymsFcIGWvvpON23pFlG0skOOzEGM1ZlyPJYet4Fqc0zHGxrhWc3ITROac9PqlVx6XN5oeSSV/oYkgVH03fKyuGWUPkQXb8yGjDMHikQrDnWEB2j9a4UyIS7SNF0Yqv/Nok/CY7dMrNZrMTmNmdsXk0QNmKkqCz3vPmKGK/zukagu5UyO+4g7Eidu/Ag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SN7PR12MB8132.namprd12.prod.outlook.com (2603:10b6:806:321::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.8; Thu, 10 Sep
 2026 14:40:12 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0406.007; Thu, 10 Sep 2026
 14:40:11 +0000
Date: Thu, 10 Sep 2026 11:40:10 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Ankit Soni <ankit.soni@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Samiullah Khawaja <skhawaja@google.com>, sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/4] iommu/amd: Remove iommu_ignore_device()
Message-ID: <20260910144010.GE3968357@nvidia.com>
References: <20260910142655.3281464-1-praan@google.com>
 <20260910142655.3281464-3-praan@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910142655.3281464-3-praan@google.com>
X-ClientProxiedBy: YT4PR01CA0391.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:108::9) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SN7PR12MB8132:EE_
X-MS-Office365-Filtering-Correlation-Id: da36919a-1ad7-484a-fddf-08df0f496af6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|7416014|1800799024|4143699003|11063799006|10067099003|18002099003|22082099003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	9cSUJa74s4eWW93j4SedsEsw6KJgLlAaB2mW3NySMoBhBwgp5JNctY1QJDr0eyLpsbEu1aWP9EZujfTJp2lkl9ZpB3kK2+ilIDicLIQfpPm7KHB+ImZcIxB7LM+IH3afRNHWBTucXxjdAOwLv5kwdbBZvzTxi7o3yORmTUW98sQtkwXAV0lO30IaRJWdnYykrokhZFm4DOM7MkatAjZm/zBxlnZ8IG1tgVRVAeLIFdMw0FHiUf4ZPSclZV6Hvoxkv/aB3EUA6x3s5UQKEtI10+E8wk/jph2tauRpkuHjkk1NVvv7uoJJ+EwyaHcoQHQN+5ftJP18bwQvZOBpVWIbqNG7TI0Uz3mJa80i5z/IgvOjARQGP8grUd5PLaKa59cJ0qsLlaCt/pvpS4w/zkRZnHztEgRBtWsEswEdCwStPNtBa+en7yCYxAOzR7H9OyP4ojZ9tQhc8rwY1j/7JzEfCUVWYR8+txQQO+IDyg2omsEC7+5AelesXXdOnYxiW/p+1gaMPoWsIYvwv5lIomT8xpcF8y+JXisHUWkdN9s6L7sOKHTPH/TlUUORpuqjA9o5L6EdhYM4RGfILpAEUijKuLcCeX/DSBxa74hORiuwoU9xMqgRI5QM2hhykKyvQtnovhpasazyReJavKeVwMUa6TsQCJ91Kb8Tph7V7EclA2E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(7416014)(1800799024)(4143699003)(11063799006)(10067099003)(18002099003)(22082099003)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GXT9Eek0q5VLB3yl5GfYTUUiEy8BGGCJbH3FiB3eCF28f8SZFSz8aORVdgDH?=
 =?us-ascii?Q?hkIq7OKSkY/rCoLaE0ef35zq0KQQxfGKWrVbNlP5CH1p2HPPA8h6kxrWS6gu?=
 =?us-ascii?Q?x7CspU2dZzVVpH/sJAvsedF9+gAkAWViQlf091ucAySYJb/oVXZXYljjbZFz?=
 =?us-ascii?Q?amdzOTHFtIx2Yak2AilbASjLFs1hg8XCLweVqjzHEnZQ0u008f9A8Qdh1Vnk?=
 =?us-ascii?Q?Kt/Qo0v9TB2J5jN5c/bzgPttmWl771741WZqDJXrLRvvq3n8wDov52QimGxE?=
 =?us-ascii?Q?upOJqz70ua8rmmszROoiHIAb54+gbj/AA4ls8nCyAPaS5yUR6M2vxrEaQBWH?=
 =?us-ascii?Q?3kIUoJAPT4ITw9xIK/tTL9k6ID3sLOuooVyFomTNE+SuFkuj/XGGf/5E25oK?=
 =?us-ascii?Q?Qnc1w3skMRUfzlaL+l2RJBnRlaK6iNvoNTATvRkXI41MOFZKDpwWAcgYSBiU?=
 =?us-ascii?Q?tc4ow1B5Hqlv+8pijXmL+k2faPhcl3841L0ucdodjGu1Y4/Ir18kd/3b8ZK4?=
 =?us-ascii?Q?q50V0u1uoJInZBzRDvGAZ63GDqrBUcpwkhxYCQMTuhIFlksw4WVOZlQkaB21?=
 =?us-ascii?Q?skU2gRExqkZOPx3EFMonpXDtqcbwWe5enxbXZ9Ql6zk7GCr9wPlsnOWoWgH5?=
 =?us-ascii?Q?X3J+I0dYWIB9Gc+rtRr7WL8d2tGus/YeJJwp5yYcO74gnLX1Qd7r5mTYfY85?=
 =?us-ascii?Q?V/WwwVvfUNb8bCMzTXAR30rsq/g7xVD2hlZZ3c6ipnDZfPeamju/2brYrnoc?=
 =?us-ascii?Q?t53y3n8Bs7GvOR1AMA600IQy3qtNbsoaiEScE+9447aKfZUQHNMo7m4FfyRG?=
 =?us-ascii?Q?vSIT1i/VI0r5K+k1Qh/HnlXokE+z2UNVMb88Li6JIb5iTWWhZ+DDL8TRxsZ0?=
 =?us-ascii?Q?PlLK2Ed5YFcphA5QS7IB07nt7rO/HUjoiU2t98ZqRDelr80oncW/q8D3BfIW?=
 =?us-ascii?Q?BTPRaomtPSmBOMPyMzQWtCYHUmRyHCrU5XTk5LmB/LwqyFYc4JwDPaFpvOQn?=
 =?us-ascii?Q?6Tp2y+vhOUpxl/j32ZEtRh0fLD20zUMqWe88R8/z1Lyor9coxwdFvvZ/DMDi?=
 =?us-ascii?Q?12QKWb4xhresM8aHdSmijfO3VswpzSj5/qGDSXI56fT5IjdHjoybRfvpsZPK?=
 =?us-ascii?Q?RoOwMpfphwVyvr6nfovbd4d5MqV8uzWnkyXzhNRv69EsXbtLiRMdMI2OwucP?=
 =?us-ascii?Q?v1Fmo5YCTmWC34T7WlNN0y4vVo73q01dht9d2W/rlRWL4sis4FFPtZR4Tbc4?=
 =?us-ascii?Q?GJ/JcWoizDIC1sIa1FVSLtuaTxXDHSloaFhvjoGgs6CNoIsyZAyA2SU/WtHc?=
 =?us-ascii?Q?oI1VpxGerrKOcQ1zBPTjfiu8tShZVNhx3qzpRcf6hSW5XLkz0in1DNNx1f8W?=
 =?us-ascii?Q?aLgeeu2vi5gffslvBMQFulCYTWnkMkzL05OBXm9mL1T0uxh/ptSz3NWBfIXB?=
 =?us-ascii?Q?1JYMExPkER+LSKcnEHjRoyuUAAvolTIjVWJ9pBr61ZV4K6dhJDSfDoAKOvVL?=
 =?us-ascii?Q?jfNobcDnBmp8+xBAXtdK5QUyL0qK7G++5GTwS+v8OJFesRoRY/d2LSRc1sfw?=
 =?us-ascii?Q?NtjFSfwGq17x53XYLvuMO6Cbo51saEgBIdL1BYGiDx3y5ypbl43AZxB9I1i9?=
 =?us-ascii?Q?5CMQpmrvHGmrvxarWB8SEZAxFqJPYYBf/iSoKsOhU0fFWRUlsj1RMSucmt8D?=
 =?us-ascii?Q?EB7CkA+/IdTi5oSEvRCktAIUelBj0tEx8mQeMthoJzqLB4km?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da36919a-1ad7-484a-fddf-08df0f496af6
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 14:40:11.2387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mFl5hUXxp186U3YqxpXG/oS34wwgE8NJKIV43E2V/KSKdXI2gVKOJWSEfkQES6y0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8132

On Thu, Sep 10, 2026 at 02:26:53PM +0000, Pranjal Shrivastava wrote:
> The iommu_ignore_device() helper was historically called on device
> initialization failure to clear the primary Device Table Entry (DTE) via
> memset() and nullify the rlookup_table entry.
> 
> However, clearing the DTE on probe failure is problematic:
> 1. During normal boot, DTEs start out unconfigured (blocking DMA), making
>    clearing redundant.
> 2. During kdump boot, pre-existing translations should be kept running
>    until deferred attach rather than abruptly clearing them, which risks
>    breaking in-flight transfers.
> 3. Writing to the DTE table via memset without flushing the hardware DTE
>    cache risks aliasing & torn writes.
> 4. Clearing the rlookup_table entry breaks interrupt remapping for
>    devices that fail probe or operate in translation-less modes.
> 
> Remove iommu_ignore_device() entirely and simplify the error return
> paths in amd_iommu_probe_device().
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Suggested-by: Vasant Hegde <vasant.hegde@amd.com>
> Reported-by: sashiko-bot@kernel.org
> Closes: https://lore.kernel.org/all/20260529153216.2AD1E1F00899@smtp.kernel.org/
> Signed-off-by: Pranjal Shrivastava <praan@google.com>
> ---
>  drivers/iommu/amd/iommu.c | 24 ++----------------------
>  1 file changed, 2 insertions(+), 22 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

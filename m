Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011048.outbound.protection.outlook.com [52.101.52.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CB03D16EB;
	Mon, 30 Mar 2026 12:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774874984; cv=fail; b=T5BRt7zNtXe4pKlO6r5torEuWKNSivTIYyNq/vvqVVcHRF+mnO+dY7iN11l8EhVVZb8DYXoRms4Ay0pp7LybIe7w4lHNKCt1KeSOK0lSM2v+xoVsPU/wudYFqO7XgvLpV392rKfkPMQz+qUFtgVh2SWM88qpTCHznE/stF4t8/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774874984; c=relaxed/simple;
	bh=d2GTlXXiuUh9OCs1LmmFHO/VyLDhMP+Uzf1A++2RRn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oS2Y7Wvzw0PGyN5AdcdHCjbpqd00xAxjwYGYE4v1yC9Tc/Z40TSqIzG5wA53kEOXilLIyCA0BN1EVQCudkf9UcC4GHSxdaUIv5VWxhGnLmdvYMaBNbVJs1gXb2svIBko9d1/tnU59EiVs1GhDVbynh/sBY5qnwOSAFaTmUvDois=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DGlLZ1ka; arc=fail smtp.client-ip=52.101.52.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DGlLZ1ka"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fHZ3e5e4UMdH85i/1+q/iqcdnrCFE8vl+uYNb92VTY8218ZYkRAjsiK3wR5VSfzuXsOqUx1h1GhQStaskUU+hzWFh135L83WjIqUTtBn3mtFtJ2ISJhnW6+vmkgECHH3S7h7ytzTgAbNOPsrhFFrksMmHcM1UwCBlHpLFGtG3LRdDZjgSKtlRrV29c0cao1TCk0+Tk8UfNU7tP6rt+kPMst88Z+Q9w3wIZS+gSe7Bd0CFBhbvQ9L+04CETRXLme+6CSsu+iXeBiDixN31tFhjyL7qnZw6SZvFREA/Ov+u/mc/5U2gYYBNeejjnqKeeQq9/+/kFMsLi3ZxecLupsISA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KaCPSpguMBXOWxCmSzmWjnBjkDhtBYeJ2pUoXpj1Hbs=;
 b=zOULDPHtDtRlUmdxOZAqWG/SLDILDfn338qdIeySB4tvwRsKtpZTPPsncf3z+UtFVw/Je5C3ZejT1TDYWI0n3XcnWwzOlnN9AMj70LQ2w4lyE6L898S0o0DiJcKuQmgPM5Wk+6WzpdGyOWwHG6CkAr/Sg+dXl2prc3s/RD9mc+3lj7TyWh3DMHNF9Uopz0HbGWSTI+l7O1RbB8USD6PabIp7R1zZj2IfSND3AN4CDYyTtEXQ/54IFdNQKJDT8+l5zpuDe9kai1t+iwoF40s5ZaFd9T+NsiyOvLC5MMNth761U7FWf/rSdCp77bAK9Gqa/xmw2d8eegivT9+ueSE+CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KaCPSpguMBXOWxCmSzmWjnBjkDhtBYeJ2pUoXpj1Hbs=;
 b=DGlLZ1kasAibd+kdaPHZ6qB2U1T7qHN0kNZax6+BdpiTVczCTPlZI6Q9wRGXCSi5kwuuFuxHy/0jhGcbqIMJ5WLZ0VJSYZZ9Y6k5kzeokhdpaVJNSO0weq8pjR2Tx2mBWWysmpWZuBulrXxHZEcQOqitl8MPLpBvYzxODnpXG7b/9VirORp+Lhp0MATxhZWk1L4746LylvMN+LcmGrJc5xFch2NXEXI6LUd2eGFf4lJAcZklkK4eRqAfZNW3yIVCvmVfEcir01tROVG7GEiTr1DY4+Of0z7pul0QdkaUDjCUL8FFHn+ft+LVRxWJAitqp0IBYPCU+egMV75Av1DcWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by LV8PR12MB9667.namprd12.prod.outlook.com (2603:10b6:408:297::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 12:49:38 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9769.014; Mon, 30 Mar 2026
 12:49:38 +0000
Date: Mon, 30 Mar 2026 09:49:36 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, bhelgaas@google.com,
	joro@8bytes.org, praan@google.com, baolu.lu@linux.intel.com,
	kevin.tian@intel.com, miko.lenczewski@arm.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	dan.j.williams@intel.com, jonathan.cameron@huawei.com,
	vsethi@nvidia.com, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v3 2/3] PCI: Allow ATS to be always on for pre-CXL devices
Message-ID: <20260330124936.GJ310919@nvidia.com>
References: <cover.1772833963.git.nicolinc@nvidia.com>
 <c715b10b49d50eea5429454108d4221c1a78efaf.1772833963.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c715b10b49d50eea5429454108d4221c1a78efaf.1772833963.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BL0PR0102CA0024.prod.exchangelabs.com
 (2603:10b6:207:18::37) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|LV8PR12MB9667:EE_
X-MS-Office365-Filtering-Correlation-Id: ac1a2927-ce59-464f-5325-08de8e5acd72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	T3ASxTWSRh2y7i9DEfIT0KjQ1aI9M+Jp54qQbI5T/ZMJ/HLPybEPhfff/KhpOEf7iZquommTvsreHJiF93l/URJqjCJShvpM/A6cNTKdwsKBzBtHzQ966NkGPb/wZxStQk9zzNqrv9R/L6pfydQoP3b+gXU5stV4qEaX0aHIvACDebf0+syWvXTQ6FAuPHNhlltz065Fm28zqFmXQY/bLii2rhCFIWABC0uG+IB9F5QbWykbX3R96uVoKejjItBCegSY295/hxvK0a77IVSY3qui/jvMwjvWlcw9gZrhrxHbbexU9Z2cwnaXxCM4wLWs89oyRCiVldvfKRXRY+Sn4lATHkjdnB7NTJuQD3q0CSiZtUXF9UPRzgu0RbzMYX51hJmaLt+qOEivuZlF+I2nYZj/yp+M7gY0u+wu1yI5JG0dCUr0MENm7whX21P43azicWQ/GGQYZSuFclft5YkxKzzNtSXc/ONXhhyh/Wcftm+0cZiu5SgMl8uI9BnynzKPsy9aDSztL3TeVXs/c+NkS66Sw7EBqTOdnROvgJt5mcd/uHSAEmiifN320tiOUtj9YLrq/l3NVsZu1+7R9yo+Xt23v9ltsq9na1uqgwk+LYC7q3F6gepSkahzIMJi3XbNwd6EAMEykkEKD3RRr424WAgVxDZlcf4t12n6tXyj9IMzZ6ShWjf0MG5CqTjMsrOA+XrMcTu7zfgufZRklCvT8LwPrS/zAW0rxKq4MWgsVww=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Dlqzom7FoQEHjfW2EhFelMIySZ2pDWsjRmDEL8ooN/T4zqTJDB6LwfnnZi96?=
 =?us-ascii?Q?G5H0BGni1DSJtdwDi1Qm63UzoILI9TftBKpEYHG6pHe/zR+LjqTOPHkCq/Ad?=
 =?us-ascii?Q?cQBaC3UvkO8wMrutP1Jw/YR+5OPKNJ9Xjz1zlmA62BrIGzS42+q/m2VDTMtX?=
 =?us-ascii?Q?HlTFLk68Ooyco+brTfL1K4pD5vWrzuFZxzkJ5R76AnC+eEfbJTmvJWM+NkNQ?=
 =?us-ascii?Q?vTmr0ymCxyrwdIIs/SOxlcMtnpcp5l8Kcrzm+SpjdthZ1OFBcracZ8XdX2MG?=
 =?us-ascii?Q?uu0YZMA5rJafV8FuuJQUY9OCDUpy9JsRo1f7SHkwiuAYuCqwstIgrrF6SOv1?=
 =?us-ascii?Q?N3b6SMH5+aApUT9lnp0i8PemFsR1uQ/OFJdhgRo3B89q5vXPPf49sg9QxrZa?=
 =?us-ascii?Q?zhqjzd6sS4IssKvhVI9f/vy1AgTk1Ai1uzc8Fx4hnMTyX08CxiKpjD/DwD2c?=
 =?us-ascii?Q?JAoTq3WU3ArPDF+r7lEo7Ymn8kbjo7Wokn0sKTegeUEmyS81OpT+zNhhiXQR?=
 =?us-ascii?Q?8RTZDhkiUM5LXvSfwshrVnV4rTIHcM1lsSODcMt4nZtvTpYssOZRLJONkJtu?=
 =?us-ascii?Q?1xzS5BeOUDiXa+mbmD3HueR1BymervXkKu+DbmpYWwZGv5H2kwyppBwTF42D?=
 =?us-ascii?Q?st3sCf79mCxhijvrkFO9VPr6t3f61qYbyUNDpt9Jl/XniWXUwdErpc2rP5Ky?=
 =?us-ascii?Q?uN++o5pPb0ghfUYIYHt/3kd4ab7rkNdoL0H0cKxjOR8yiLzqBSpQKVQuSc2x?=
 =?us-ascii?Q?ALKySYHoet8BIXt96l3jS8iNjmXjVsRpADHKJAKwbNWc/Kz6Zdy0lx5v9MRW?=
 =?us-ascii?Q?uP0JXm55LmjdYRH9evDcNZ+GsHu65uyoPkvGBZR3fUQZ5SmEJBrIfoNB/qlE?=
 =?us-ascii?Q?nuMNKOnd4jJex3aAimt9f9J61jo9cwZn5ebFdK45IVEKbiH+Iep5F1K97Tp2?=
 =?us-ascii?Q?Q3aEWx4I3JY7J7aXweYtbCLmdqv6BU+K74FKBEiSe4f8JV/zCOQkXSE3LSRP?=
 =?us-ascii?Q?PlA6pkUmA+MwcYFAeJmWSHOMcVotHRMz1w0u7/3sG8C7GRlbcfZetyOYAwkZ?=
 =?us-ascii?Q?B/1TOQCGgcMPG45VgK/1nGB90SurDX1fBJMwjJt7Qtlq1+XhrGyf64G9Ky43?=
 =?us-ascii?Q?l07mdAzOCKJ/jnF+liVTjc9Q8gVLWjABZjJQMYrGBbLNpBqd2x1QA/rn+IOn?=
 =?us-ascii?Q?FENonF+Iqk4N1nwYqGkr5e5QYqRsLMv8CUnvLRAajj7JCisyN7vTI+4w/dHM?=
 =?us-ascii?Q?7RyMIbtA5fsWVWPYsildWwFsPAFYL4lRogTiUVxPPSmeWjaqI60y1gMCPAE9?=
 =?us-ascii?Q?RjMKd1Fxpn62ZCfP0Dr9R8d/XxvOhTPLhMJuMpzhgByGDeX5/sS4FvBzUg/G?=
 =?us-ascii?Q?cepNj2+2ZcyucTo2U7H0Ro4PV9DWPP7MGInz9a6DmDrfFFa0Er/l76/mmVqj?=
 =?us-ascii?Q?ZeE4Yu9bMsGm1DAelt8LPuyzYbU9KBPMJdXgkVqZ1vbFYZeLR4Ze+UZLsHqB?=
 =?us-ascii?Q?8qoNUazXQXIgROetlXdh48wMTDkls5BmRbvINLtk4TEu4l1prhZudvs4Q0Wm?=
 =?us-ascii?Q?YmqDPhaKY3nte/HP6sQkQlGffYbbekjOlFD8iB1hzao5BvT++56tmJV0whD4?=
 =?us-ascii?Q?wcpGrX9ulqpiRAvMtbTIwMsGXStHOsckwajZiVJtMnvZ8aRR+IUpN3tdrJ45?=
 =?us-ascii?Q?k9RvHfrm45A9vl6NtQ+eUyChdBONlywKqgdpBHNwNOCNqvwc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac1a2927-ce59-464f-5325-08de8e5acd72
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 12:49:38.0597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oITzp/Vo9c+kXOzGIK7Qjykj72m9lR0esqYKUY0sfGIbGFZZidEBxwWi1ZDOkwmv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9667

On Fri, Mar 06, 2026 at 03:41:16PM -0800, Nicolin Chen wrote:
> Some NVIDIA GPU/NIC devices, although don't implement the CXL config space,
> they have many CXL-like properties. Call this kind "pre-CXL".
> 
> Similar to CXL.cache capaiblity, these pre-CXL devices also require the ATS
> function even when their RIDs are IOMMU bypassed, i.e. keep ATS "always on"
> v.s. "on demand" when a non-zero PASID line gets enabled in SVA use cases.
> 
> Introduce pci_dev_specific_ats_always_on() quirk function to scan a list of
> IDs for these device. Then, include it pci_ats_always_on().
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/pci/pci.h    |  9 +++++++++
>  drivers/pci/ats.c    |  3 ++-
>  drivers/pci/quirks.c | 26 ++++++++++++++++++++++++++
>  3 files changed, 37 insertions(+), 1 deletion(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

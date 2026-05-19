Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011055.outbound.protection.outlook.com [52.101.62.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6BCF4C9564;
	Tue, 19 May 2026 12:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779192468; cv=fail; b=Q3Iyj8IYEVGYTqEXYOmwOKW0tw9RT7D0O4V9OPDJC+OCdY9ld1YiLnBeTphGw2dxjlsPodP+Gky03VExrU2C7HwxbCr4MquT54S89sudLceqF1JTsJ62LkVj7fht2ljZ5E0iTe4naZasnBq5zSUr6k1vUhHQ5d0tJl4DJLl/z6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779192468; c=relaxed/simple;
	bh=Rm6iZe7pyhymjiAyf9mWVwmWFyChCwDUeoOJGnRacqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eOHrF5Okq2erHv9DQ3c3uhRvI5hZ9LVxAcWa5HolPK2/HtlNN3k/e/btqmU6ssuN26sEQM88oFdGoO1iSGxFGxaStCew3ybz3Y+GdwOI8fXsgR7QWRldqPNguJD99Jw7wRfWE3M2jYkPtLPGsu5k3UnsvkyM2MpXXKrb+vt8OtU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JibABYyL; arc=fail smtp.client-ip=52.101.62.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JibABYyL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uxh/Abq27X7mI8YfwILja5UkiPAvIfnxOFcu0SAmBrlkrhYu0FkKLYXQr4iiBANHNIJh+ZgoDDBWr1hg6yd7D8YXSmXMXtc2zLgKqM0/bj6UCnmXu45Wd+D3oFdrmM6ltk3xYoWGH5XSmFUB1feynJKQS99arFBSnfkxP35albng9uSSo4CaeiB+6FWVB0go4as7Aikwtc1J6tdJq0yiW62AqDi5iQay30hdJmjWnLmH6FSCJnNlbAycSpg++nXi6SKKssBbxFhzNGzjLZb8Z7wLKUdZz26nF2SF9jgiRBRE/7IRWafu4ZEL4rWalT8k/0CRPm+7gvaAPMkipgcwFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=urJTSMyoi5SDQ8lUrIH4Gof4d1qZsp/n12CWPCAKzgU=;
 b=GZ7pATO75V47cR7YwFSNCqa4jODDDSI34cgb+w/YJeg+5PCwyqQ8YvP0iFhijjemeKzQQh5N1rKlUKRYO0KxUJDjutsozCv5xnE8vaaza8SHrExDYzd0e7UAAwNWTQaMgLZHYEuDRO6Lbn2q9kKxv1W/4KflF0gHf/Eyp2Q5NTYQE92mVbPn8x8YDMRpDZuATe0T7YH8VUu9qfp4cJTd9QE6XrO+iRrJsZRV89iiXLrDEC8qjIgKKapbR+eVchzEHLCFu55ty4J36f4dBI9nJkx6KE63TddKeV74IoDSlRLmFRmBNKdoB4j1YWgj7CUWHfzUYaSpMhVxvUB4DvLSvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=urJTSMyoi5SDQ8lUrIH4Gof4d1qZsp/n12CWPCAKzgU=;
 b=JibABYyLIb3ea416Y2aqQfT+TNo9zYv2wTm/Hm0cMEgyDZSAlKS7+biTbYvNOtlA1WgB84bbnpDnm5mcsgW1JNHhZEVvV9zbo19Hvkd9lYek7VhAylD+jHhvVfdEkTyaTHVxGJ8DcG4a8wLzuc4IdtwnnaPO4AUmSh7K9fwJVCgeJQZWTX9qX8tXGb3WbPf93quyEnmB5dy9gdhGDIUYbDAB03fq9Ty8hmD3q280qTuXYV4g+kvq6QOVpp5Fd9IbEQgvBIbmST2207ZNvaOQV9HLPcclFbtg65Qdvcl5FDPnV3StB054dumbWnOe1Vgqus5zfsUXeLLhNBao7AXXQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DM4PR12MB6040.namprd12.prod.outlook.com (2603:10b6:8:af::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Tue, 19 May
 2026 12:07:38 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.21.0048.013; Tue, 19 May 2026
 12:07:38 +0000
Date: Tue, 19 May 2026 09:07:37 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Pranjal Shrivastava <praan@google.com>,
	Mostafa Saleh <smostafa@google.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, vsethi@nvidia.com,
	Shuai Xue <xueshuai@linux.alibaba.com>
Subject: Re: [PATCH v4 11/24] iommu: Add iommu_report_device_broken() to
 quarantine a broken device
Message-ID: <20260519120737.GQ787748@nvidia.com>
References: <cover.1779161849.git.nicolinc@nvidia.com>
 <745da1a819eb943f2519e660c8bcfde715885c6c.1779161849.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <745da1a819eb943f2519e660c8bcfde715885c6c.1779161849.git.nicolinc@nvidia.com>
X-ClientProxiedBy: MN2PR20CA0046.namprd20.prod.outlook.com
 (2603:10b6:208:235::15) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DM4PR12MB6040:EE_
X-MS-Office365-Filtering-Correlation-Id: 34657824-74b8-4d84-b012-08deb59f3827
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|11063799006|18002099003|22082099003|56012099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	fUeS89dBOyDaC4ofm6HfyFCtqPNPBsvIvmbXOKY9h6J6gHhaB/IfenQ/McCV9bfb/C0a4Q0JKUsxDrTwdlp06KhcsECoCgkRoaZKWvZXBT9NQv+AxECHNT1XUh87/UUUkrbp8KYIML56rLmxtLJGzs+jK6w5mlA/M6ulMrIs+MqeBLAZTaUepQcKSsCQCf4jIz1g2rgwP49k3qrlf9+iGDhHmsQXult86wd0/LAS8Y4wLVmPxDgkpeflT9U0BRJwUJEW7ohqXt4UQmoxBoMWMO8mMA9b7efv8OnfBwNXgOhkOhEbOqTYJu7pij9ifo/tZ1bTrjUTRB0OiKUh2gh2PeOErQsUmjUTbD+COZdJ+WQm9wOKmoxbyzp6UtBLbMm1CYS0fDqHmTwqlRNMtvNUhuJU9Z7RelCUKT4iVikidJkD3XtPXEhoAj1PBSlUIk4KhVnTyUEFYRmfrpQ7zfe9OLpbnA1JRNGZS3gx0g2MUDOWWd2fdX7fgJfWQuGhmEcsHpSWN1i1FAKuRqxY35uLUyHuFqdDq4aEHZWIcXbLRMniGSTi4LJReewpSbRw2gN9y6rCnoheX3/4n0NozkKOGPUBrQBiwMf7hSVtA+JbD3N+ydPf2jl6Nvo92/+kF5dTrkZqr7JVSuz90ekTc81s8+brak+bxKLV5zGo52/S4KuioGxnn6ZwlaWBhKHVlp7I
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(11063799006)(18002099003)(22082099003)(56012099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Vi4kDl7XMSEDDnvEvAuxrceRsGVpfgog8vW6ZspNy4IwsalTJSDucz1J+MC4?=
 =?us-ascii?Q?mql32xk+o5aIAm9WOeFnhmnNLdFngG6nVe1Wjfhn2xiixf8CXElhyjKdj9zL?=
 =?us-ascii?Q?vp8VVSF4yvL5AG4Gqm2Z6ljliOeJQfxjDDxkZOjuRvm7nvfHdCCktgpcCg9C?=
 =?us-ascii?Q?s4jFtvRazRUMI3qZODCyIOxdhobIaUiijk+whEppJPYd4neUjQ3o9sgDjT3p?=
 =?us-ascii?Q?GTWy+CwuwHEbgfgK5yIlmL0JyuouT9IEXgi9Bf58yILeJ7RB8EqeC8r33/V6?=
 =?us-ascii?Q?3C4v6opH8cuSvkrbhUfFTON0+Mt0PeHlUXjNDEakH4y2GuDVnFCYlaAR54id?=
 =?us-ascii?Q?1LkPgXX2nnu51fwRWx5Qvq8RLeVRwzEYA64RBkBK8eL4FcnmaE2wYRWLJZx4?=
 =?us-ascii?Q?apZmzhIIR6YG3en1RvCz2m2T01OATWKo70He4Yd5lzVNaxKnhCKQBX51C1bh?=
 =?us-ascii?Q?piuWMyDRT6OopFMGm6p+aBXWHZkR9Vymu+Ood45Ga1gfyTLDaPIuynsQkTVU?=
 =?us-ascii?Q?ILFpCjSKuI1g7m/yzoxb/4hfJHP4Dh9v1F+kfqfYGFefmZLwGeMKmRsQXFxr?=
 =?us-ascii?Q?yjwvtA0z3bO43nuJMcUnadtAg7NmsNKvNGv1xbvh24FZr81ZWp6oZ7HRkvgV?=
 =?us-ascii?Q?Vz2ZsoHGOYCPvDZXbJXqIl6sOGH2MJJOmjJdwFUtiPmZOedqRjDGKDmxICov?=
 =?us-ascii?Q?pXU44rCny751rrwIIu+5exlB/KVbXxhwQDo0y4Ppn2vghEAFUaazlchqhE5c?=
 =?us-ascii?Q?AS+Og44AZK1HAXVFyaY4GjJpiaIFR7z4gRnpDMHpgRtDvNzUCMaIfzsGZf1k?=
 =?us-ascii?Q?r/f8+eu6/dPnU5nzJKqFISSLexDVASyVagh63HWgKohbEIz4/VhvxPSvK2Q2?=
 =?us-ascii?Q?d3tg0BrcsqSYjvUWpuPCwCc5iHRPjZB1JH/B4wo6qKH4mlm5ycplJrdcOEE0?=
 =?us-ascii?Q?4cmWCcLzOn2GHzUcKKjWMri9+r4a99tafaMtOYqtReNG9XcA5+RDTAh6BbeV?=
 =?us-ascii?Q?x0fX0g6Rdy27g5QiXUvekymrk93PpL4CruWJWntl2LpVdo2qjbSDfTIN3rE3?=
 =?us-ascii?Q?bXHKpVzDg5BWGsHbJmGKOsPBfmXopIg+dJAD5v5x5XLsO21KpOIP+s4DoXJb?=
 =?us-ascii?Q?fqSxzC4DjwiOYbL19/aLVNnhUpIA94/wbvlG0qJVM8r+LY2gmvLo5ffqpc5a?=
 =?us-ascii?Q?v8rKg9+ru9nJJ/P8+NgEQvbz3hvsEIZ+DRi+phsSdXWIlmVddu3Vg54uzPFb?=
 =?us-ascii?Q?OUhuCE4jMRtjMHK+tVrNscXtqZ07CNL4qKzoeQQkDX3V7zVRUKtLuvokMVdv?=
 =?us-ascii?Q?VLpNkwm5LO1ASYAGSQFZz06UHBhGVh0ismTPcYDBvMT5oSmcqR0qNAKpJX46?=
 =?us-ascii?Q?FRtWEq8jsZeNIBXu/qhinw9e7/rrBZqVpPWnhUG4Y8qV4QjZHpAFH+b+hGxz?=
 =?us-ascii?Q?6VpAy4DrFm+tQQb3YMmK8Tz51+f9fVAsNES0wvqKh/kTBKhwra6MYfuELXjd?=
 =?us-ascii?Q?yYZDHUh2/MX+eB+DVdUB8P7HylQ+Ri2PSgKIYVeUcxfvoPWMRRtL7xt+N0ns?=
 =?us-ascii?Q?Zzt0vyEul3sQaaSjxCeqUavjzKyaLT7qBvd2YqGShyaIY4bXJDZp1Y4fkz6t?=
 =?us-ascii?Q?PvTErFt3+R/bkRE2aWcNP3VbcwEC0IjUzgI+tgxTyeP/1XvkHKZkelJ2GsEB?=
 =?us-ascii?Q?oIO6msaMIoLX2yZCHGXVi74j35tFp5eEfcEq73jFWOingUdz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34657824-74b8-4d84-b012-08deb59f3827
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 12:07:38.2444
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y5t1UhIv6t5o7fw5vB3y54Ol/wErQrqvZD+TbbGVPsJ6rx7OkZbRfFbDON4rnJDi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6040

On Mon, May 18, 2026 at 08:38:54PM -0700, Nicolin Chen wrote:
> +void iommu_report_device_broken(struct device *dev)
> +{
> +	struct group_device *gdev;
> +
> +	/*
> +	 * We cannot hold group->mutex here. Rely on iommu_group_broken_worker()
> +	 * to validate dev_has_iommu(). The iommu_group memory is RCU-protected
> +	 * via kfree_rcu() in iommu_group_release(), and group->devices is an
> +	 * RCU-protected list, so the lookup runs entirely under rcu_read_lock.
> +	 *
> +	 * Note the device might have been concurrently removed from the group
> +	 * (list_del_rcu) before iommu_deinit_device() cleared the dev->iommu.
> +	 */
> +	rcu_read_lock();
> +	gdev = __dev_to_gdev_rcu(dev);
> +	if (gdev) {

If this is why the RCU is being added it seems like overkill.

Just add the worker to struct dev_iommu and push it there so it can
use a mutex but I'm confused why are we even adding this function?

The entire design of this series was supposed to have the IOMMU driver
itself adjust it's "STE" to inhibit translated TLPs synchronosly
within its fully locked invalidation loop.

Whats the async worker for?

Jason

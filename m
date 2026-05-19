Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012008.outbound.protection.outlook.com [40.107.209.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AD54C0433;
	Tue, 19 May 2026 12:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779192127; cv=fail; b=IVvpLTeZiwWi6FssBegIts/2H+w+UG6A8wExUWnvzXEv2TwhZnCQW6YrHo19mp8Fn62iugYwu14Akqjv5C1ig3WuWacSQaljkCXsNCEnjT6dst1WrJuA5+rQMOIGX0ZWsYXhK4c5FwjzCbaemBtPeFyuQJapHXa0aAZE0k8GNi0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779192127; c=relaxed/simple;
	bh=Da3REWnCBzU8xxFhL5qGi2glXeDo2xRQ9LSok7ungL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dVhPrhPqD9oAT9kWR32rka8Ks5FWAV6+ASuBNkCMiLDk8dB0Sq6GZK0+9yXTWt4RzYpD1ruOpO0m5VRqbZHfgxUiYqrIQb/MgpCby1gzdW38TON9nDKHwvGldybIpWsxV46Ri+abU07SIjyIqb3yZNpe9bVPT8kMqV+eSLaMmug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hAZfKSv5; arc=fail smtp.client-ip=40.107.209.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hAZfKSv5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MOMrTog1yHexCC49XaekwCrJVm/9MH/KENNc7iUWpJjZEdzabElMuOuaxjLNvtZnvj/RM0B25DUpF1uvVacf1w3lHvgm0BRXmuhm7sLuzSXQkqzreqV5n+y4zpC0MCaiMQNqZDydIF/y873FxXiuJatrQyFamLPZAGgT6wUCVSYRUgiEj5/BzfmEU5q0+3PcvTPXTOgCrEEMP3slRJPF6O1/s0gyWbtIqWWCjfUQsNkVphEioGMLYdGuKS3eIJsKFkLkqxmTHL4q9Xx+MXI2oYTNUugelcTOKZLGhACzcGID/9dBuaPsvLL6bZO9s7pVIr04y/lPRaNIk3Z77DKoog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xXt3caDLxr9b08np3/+L56yljFj3B6qtLP2ybCBMaQ4=;
 b=bx2KGZ6IRt6zF2kIxjFMZr0hXoY4Sl9hHwAO8cwi0I799FUUqZp/4PzTHg0UoYAyp4fmjpg0OTNIPRUHleNVm1b+lXbrhgx6MqeFJAyfKX1uKsGKmjqCsK2ijX/SIWcyZILxdxVO/G3oL4kn3clkOWoLCCqNs+/HhFZoQK+s8hEEiUI3uC0dtWlk+1FVovenpb6BP1bxcu93jqH49i348iusL/Qoe1EF1pezrAx4xaqeW3/jUSsLjzGv9+pQJEyAK3Ht9yS91GcCdcJPZfh5PLyKzib93L/W0jEmHng8U8R+Ljse48sajCRNRxOkxyRT2XcxyrVgWm7Y2rCkGLgM9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xXt3caDLxr9b08np3/+L56yljFj3B6qtLP2ybCBMaQ4=;
 b=hAZfKSv59BzztYTwXXYwEvaAxNb+NeGKV/Od8sYxZ2fKFcK9ASaTiaN2FOdNVZuDvJnXh/8r9sRMlmuX1gP+ZsrqK1vqE1PA3+Dlq+ucgB21eRtqb/PIi53Kgtk13ah6ezyTsiIxdebJrFTp4CQu7a+5gxpBPq3kyGnb/Nuf6K3tfv4OJ3MekouVh9WYRxy1+HtJjBnaRjcC/TVvyKbI3rv6TvQnK7jSkO0Mc8NQEmkCbjfvKniHLqfm/U1n8QxMJM8MhXNzB1ljt4DnPotkRuj74bfRykUBLF6WM/yFo3DBCl/ZYyqQiOv6IBWAG0R34cqwALD5Ch7o6x49FmOa+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DM4PR12MB6040.namprd12.prod.outlook.com (2603:10b6:8:af::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Tue, 19 May
 2026 12:01:55 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.21.0048.013; Tue, 19 May 2026
 12:01:55 +0000
Date: Tue, 19 May 2026 09:01:52 -0300
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
Subject: Re: [PATCH v4 17/24] iommu/arm-smmu-v3: Add master in arm_smmu_inv
 for ATS entries
Message-ID: <20260519120152.GA3477375@nvidia.com>
References: <cover.1779161849.git.nicolinc@nvidia.com>
 <2ea9edeaf0b23840670c62a57e71e7cf73f41ad6.1779161849.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ea9edeaf0b23840670c62a57e71e7cf73f41ad6.1779161849.git.nicolinc@nvidia.com>
X-ClientProxiedBy: YT4PR01CA0473.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d6::6) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DM4PR12MB6040:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c8216fd-349d-4690-9410-08deb59e6b89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|11063799006|18002099003|22082099003|56012099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	HH4kwQPIpCRUqEqwyvf9gwGWqPiNgqNZzHqt2iDBlTy9zbzJbZm5HhG2APZTz27wzrVqah2cmKyTJMP6bJzCNR4FnZys3vkg0V/GDGoEU/1VSemwhYxDhW7fEbHApyUdPiBNQScNqq4b/rScfw4UUTHKEVpqxjshMSOZ/HZs4I4x/sZjTWeWr317PFsO2WbYiKU7MZIFUuIW1prGJI5VBbJVwJUtt0KfhA3smjS1QODze1OfptXD943ma94lckS08kL6lmrNicmtx8v0jpPQytM/pIRRyw4N2LE0qXExF9AbQujqXDNbdugmvTl++LJGVsS5OrXVRqWabDSKZ55Mm0BsG0Zoxss2gYeaxuxWxl/Xlncf0sGiGqrfrcEblWinUauDdbeSr4RiCQcwNPeZMn34WT30Xs2gcvPzlmS3r0+d2nkFUz07h1yR1pCwTo9SygGj+CQhoGxLQGM4QVOP8iQRs4SUxovL/48Zu90HW03BipHi3GV5FmRUEy3XDPQ06rxq7V2qdKQ188j8IVfiSDnnMZuh84Eplw6axLxXxNG+TblYybn8Ouc1GISWIyC0V4e11eBhXBzNgL5aBRLUgb54YmrkF0EPGDTltE7iGkdqn63o3a1o6fCPRE7Rqu3FloLVxLhqeMRSv9JzY/JWv42SaltQCTOB+ZBprNrG1zb2694t+lyu4FCXsboE4qm0
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(11063799006)(18002099003)(22082099003)(56012099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sp8+lmNPIAB+cTCzBusqNzcjzhg/tXs3c6fxJRS2MXdXiTpxbqgBRNbAID+d?=
 =?us-ascii?Q?wYTAxKJiQxB1RE+v89ZJVvtnRDtvM1n+lHxefHOd2CUri6m8wqh2zcU2AX9/?=
 =?us-ascii?Q?C49xshu8qTvUqBpAL/Ntba6BVFOdvBGFjSrAiOLDEo4g3jX2TsR174ZjC/Pd?=
 =?us-ascii?Q?Fy8+4LgkEqPhojBR7fC2ihsXUzb+H8t8XDyrXtRZCJYsi6FGksvaU8nQzI6Q?=
 =?us-ascii?Q?2neiTLIFC0TWBYIVX9K4iLyyJRDFDPmLV39vf+birtlTzF0IPcau3itPCpLn?=
 =?us-ascii?Q?/3Br5iaJwHgKvH6hjrl3v7peyyPv6nGxPR00pH4SUWWogfy6gyNnprFWRVhy?=
 =?us-ascii?Q?pbbxX6VNHJpTiy4v26QFqvYWfAJ9+ctoHGxO07fro03VJVj5uNaijPr38kV5?=
 =?us-ascii?Q?LRBkIt6ZDWl7S+c+dbOwr+5axb3DSU1irPvMHAuhpBZ5K+bCKJ0M1wRBHpFO?=
 =?us-ascii?Q?9LTprBGR2q8uD3zn4JGU2n45qn6nxwFdKh51Z6K3uj+IhhM2JrTb/mt6hMRW?=
 =?us-ascii?Q?Pwyb6HZ8PblnF2HJNueFyUP1BYyVVCJYlp4YHGiwLolZhioiqU5hAA+RIjvd?=
 =?us-ascii?Q?EXgLN6R8mFu6dpKfX7e7EVHrCYuTv2ckvgl32WROGP3xUU2q+gAUhdvYoAps?=
 =?us-ascii?Q?Etsd21+eyf0n/LK2Wcnemunrl2Hdq5WuSQj+WvxHPjoF1TND2TN3/Mpy5I/k?=
 =?us-ascii?Q?WXCA9zPzPfECkFrH1sR6KklWt42MT8Uu6ofj6bmvkpUDEsQbrjd7/PbVJ7+t?=
 =?us-ascii?Q?0XsV1LYhHNBtU7QkL44DEYkWGhbIvLk3OaJ2OFvxyYH/QGQgPE3bFVrLx3+l?=
 =?us-ascii?Q?i+yE8i533SxQbPG/GbUmODYcz2m4yL55Ggs9Vgka1wzlDmJSgB7ouDfW/RTW?=
 =?us-ascii?Q?94KBDHzWZnFgK1d09q0lcomFymCrjpuonP2rtd5n2LvEA2r70Q9WqdvmvE6O?=
 =?us-ascii?Q?gR1eAfBsfC4MaN2C/mwSBAdtG6duq2oJREWnTQP/5t89p1MI45Ia70DLncNP?=
 =?us-ascii?Q?CD8h5M/buQDQmbT7w9Zpfnc4HM+x2JRVrSCBHGExHz8AhpkZoqipbjIfrRnd?=
 =?us-ascii?Q?+RCn+l9gTbHdHGwoXmqlUOSN4ZjHp8JVNd6xLGUouajwEWSZQQgf/H1UgvlI?=
 =?us-ascii?Q?8qc4lr80a2EP4o7I8PrJngXKN4smKvgb4i8dPp4SW78gSVpkNEUltKzbSNec?=
 =?us-ascii?Q?6IojiQElTuqJV+nu28Vcp9mtdt4aExhz80++tWxzzCctuVvKGTsnX/BjgE9F?=
 =?us-ascii?Q?r5uX/NbhOSjW+WiKOCVC7Pr/q3F8TMlrLaE6Y1zHL86onT7nPI4iowyzBW8c?=
 =?us-ascii?Q?MzmqI9T1QQP/1Lu73AmxWNRHHwPEKZyONkA94986CKlnW1AwbtaJCD76bODQ?=
 =?us-ascii?Q?sKOweHg1QA56v/YfwEdZnkdhgdxg2dhpD66eP7k2LSbgydXAW+MoAng9NW24?=
 =?us-ascii?Q?PdtB6uv+3Q0lm8v2gd9JZPH5y2eC9FGETXgoGJCeSefbrbk1VN3BYBzMy5ge?=
 =?us-ascii?Q?UNT0TB7y3oMgon+23OuPgfixC2TzWK9KCav0IAym7gRi/P6J8azyCw7k1E20?=
 =?us-ascii?Q?EZ4nyqk8WiHWLRT6jmdLrcf1MxQZWgwU1JszrzF0rtiy8CUminxvZbjzXrUF?=
 =?us-ascii?Q?C0iNVwGFcqDx66D64+oBR0pKcecYXBOhXn1DN2oP9Lt9580yzwqJIHqUycWZ?=
 =?us-ascii?Q?pWvoX/aYHE5Ci8+/cijUzIeVCrfoUqKtLt9YU/igkNSaC3Sg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c8216fd-349d-4690-9410-08deb59e6b89
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 12:01:55.0629
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zwsHI67kUTFDsVanJBpDNEn5VqI6eRkGsy8ge9zuQRldB5tnisoDvQ7Pv4UOwtHQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6040

On Mon, May 18, 2026 at 08:39:00PM -0700, Nicolin Chen wrote:
> Storing the master pointer allows backtracking it from an ATS invalidation
> entry, which will be useful when handling ATC invalidation timeouts.
> 
> Don't simply swap the "smmu" pointer for the "master": a non-ATS entry may
> be shared across multiple devices (masters). An ATS entry is okay since it
> is tied to a unique SID.
> 
> Master must outlive any concurrent RCU reader iterating the domain->invs,
> because inv->master is dereferenced inside the read-side critical section.
> 
> Add a synchronize_rcu() in arm_smmu_release_device() before freeing master.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  1 +
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 14 +++++++++++---
>  2 files changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index 604f7edf54158..df6e539f75274 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -738,6 +738,7 @@ enum arm_smmu_inv_type {
>  
>  struct arm_smmu_inv {
>  	struct arm_smmu_device *smmu;
> +	struct arm_smmu_master *master; /* INV_TYPE_ATS* */

I don't like this and the locking for just a slow error case.. You
should use the SID for this and have a spinlocked ATS master list to
search for the SID.

Jason

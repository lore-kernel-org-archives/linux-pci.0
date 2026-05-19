Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010069.outbound.protection.outlook.com [40.93.198.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2146D3FCB3D;
	Tue, 19 May 2026 11:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779190763; cv=fail; b=XUwwbdb42szevolbA1LA4lNm2j6lyHeQBAFNUyqzpo4qNWcgj+F2Zb356fCKf5kpD1wjpQLztiCoJ2/o/aBH/62hfPW1M1eHH1g7MopAwFzBULmldfwVY+2s6ALRTB2Sxwqv2llqXUwQhT5M0BdDM6CGoBCx/WmLR1jPDiPjc6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779190763; c=relaxed/simple;
	bh=SO5j+4qdE/QSsZ0k1HAA9FbbbJau4EnEeFwc5TYIPRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=V9uP0arPHxXpRcnBprmwUSNo8vQOMkx1BXxXadxAVVr1Vce6Vjotuk8O5mSYDLy1vH5Pacz9GZeE8jhgE6K11vVyEfFaeh0Io0I0jBu/vigoyibR6fdn36ffTOfBtPy3SKuqWJgyLc/vXi6uh7QvmW+oUZtWjV9PALdYABn97/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=t0ykYH8F; arc=fail smtp.client-ip=40.93.198.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="t0ykYH8F"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LeC9IftA19bG4NEZN3Sk970o5z8U0UbM+xZhmm0rKE09HOYTYU6S8r4PAn16TsDp2e/nT/HR4pMUtOG2xfkk/xRa02LOjd0FyD57MybWRduNTtk5IZxTnKgVWo+4uczseit6vnZtVXGFJUrF/SIphiI0MAiyTQUeDO+cMvAjS1HiDCiN644YSA11eX2APfkq0PEY3qFGLN/51nGh+FD9UYbqIdgVSI0+Ce0aCY31CmSpqgansziUbM3XphFHb/EB7Um2c4dx+vs9fYeWZpCAH3YL1fNI3PytPRCaqI1ZCXh8iFz4VATlh1HwcxdJjYvzzod8spIJnCHtfYAAsiLwpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vhhz8Jk/e0c5NgJuWPlb15BKdi0hQoxAx01QkMQ2sBE=;
 b=LcRcpUZxERECrttv7Oo+nJaU3CrOSoSDGUJWEXyhkE07P0NxfjUCA70uexYtCGyzafG50MKlRiCXAvrJ18qbi+6buWRRFKt2QZhPTPGKoW+TRRWg+TJ5MKMkMT4t4k5+ab0D1IQMJEo2zq9XTmrYVYjFQTQT7fncILb3IpmWapVa2VG/094tKXqAlvwY6yur1oSssUngbxiqFtQ8xLgtD2cvf6HuRvnVQBozeHdBbZ+vHKbazf/EC5CZ8BJBqcon+rCIR5UtXF5x6PamQnQi6pes4an30hhHik/WnjvpCpmbajIUeXVsBLh6vcvuGVr/SV23NLkLhrbxVZTpf3+Ysg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vhhz8Jk/e0c5NgJuWPlb15BKdi0hQoxAx01QkMQ2sBE=;
 b=t0ykYH8FlbqiC6gqAfVZR18Tz8XKNiyjpwiv1ePymXF5HAVDrhf93TsWsMqZZH+vPwSyBjqKHVTedrmyfco0fLUM/Hxz2hUPAGRsMpFIPb8Sh0kQe/HDI784JcqGJienZUUbPhF5kOOwOzC6IwNtt8t/njoYK3SseNwOa5h7Y+U8sdxKSGaGt0rk6akcGcCLjbtejSj2UUOI66duc/p9B15Jqq6l0zNoldKlPOG9kIb+07zG8/sGEPdtE8MyDEZKVpwZbwBylQbszWNgFw7ak2qYTBH8K47jGUJiUYuHga94/AhBPDYUJ9uWUGIFx/rfGunzY+Yh3PJyypJ7H3XzPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH7PR12MB5687.namprd12.prod.outlook.com (2603:10b6:510:13e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.25; Tue, 19 May
 2026 11:39:17 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.21.0048.013; Tue, 19 May 2026
 11:39:17 +0000
Date: Tue, 19 May 2026 08:39:16 -0300
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
Subject: Re: [PATCH v4 06/24] iommu: Defer iommu_group free via kfree_rcu()
Message-ID: <20260519113916.GO787748@nvidia.com>
References: <cover.1779161849.git.nicolinc@nvidia.com>
 <a65846f5514fd3b7ef6c19e060ed3a25af75bf03.1779161849.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a65846f5514fd3b7ef6c19e060ed3a25af75bf03.1779161849.git.nicolinc@nvidia.com>
X-ClientProxiedBy: MN2PR16CA0061.namprd16.prod.outlook.com
 (2603:10b6:208:234::30) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH7PR12MB5687:EE_
X-MS-Office365-Filtering-Correlation-Id: 78692564-c769-4fe4-23d3-08deb59b4266
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|11063799006|22082099003|18002099003|56012099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	H5pj88I9EZ+W9pSsqGqyqW22UiLeaosz33UaBTmMMx4gPFpK2rgEoxR2QBtgRE2BgGIuUkRwvHuFPddF1ACA5tAgEOxNEbeJjtEguw4zq3hPUKOYh4eMeGO/+9A2wH1W+ea6FML7ACPN4OWJWJ3/MVJLFujVoSKhuJrJQ1BbqjpiVJq2+Sv+vYFaU/HTNy2Zg3MxQG3gqYxF+Le260H1uSpUuwbXXfknq/7dTbbkU+eyAMyLOmKZQMlrNdmzEpg2WR5JNbD8hzyxyMrzE54cR9116QI2pOKE/W2O1S/zAUG75nzRZ/WDf+Kq1Y8Rm4HOPzYmed96ZY0CNK7KzvSIKXpAlPg10lJ1ZKsoJOSdtUJmTmAvaZIUoVXXVNeg8rCcUUtxNB6jcE2t9+ii6vOX8zvevRoT6jw80MJnGu7QsjM3K/PaHEY7mq3ar4MG2fvUyMWCmmEMnXAFF3KnvyUnz26gqz/d452ztl6Pxtk3nnU8UjG8/7UZ1TGOENAEFh60D6t1zz7/gkKwsgB2XFhjOK2SE4EpEZcsMvj7YcdorqLNbmtgDgEVwzKaC/eSDgG9DxbML6BwX7e2dhwHKgEZpLo+uakfPamqwr2d4cuOM/maHIkzmwgUn+z2Ourh+mbS8OcGY1fcehbuin4yNTtAMol2Na9OlODMr4V+jXHsGqiqgvKIGg4yqpdW03SkH2vn
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(11063799006)(22082099003)(18002099003)(56012099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rXkILSzgrBr+8t/bi+SkrGc3Bx+vrQyzZ0BtNAU0PMvJBnlkEUhunuk4OA97?=
 =?us-ascii?Q?dNK/DPJK3xasPGzbuTO9BoziRAo9YKl3UxaRzqw4QmFtKlATOrYhHxxyuJNS?=
 =?us-ascii?Q?i8b4UtGwyXPos624LR91+bA9C7RoaYPeXM5x1joCjkItUG5wUtKcnJeZHvQe?=
 =?us-ascii?Q?PNWdDJyJBeDID9nbD2duPtLPNOqMIbkxK+CiLbqxhmKAEvHleOCO7GqWOXIC?=
 =?us-ascii?Q?Hnq8oYhKQZzOwTJwj36X5Qc/2Z8T6qYzSMsGfcLV7lOrYTsov5kF3UHon4gH?=
 =?us-ascii?Q?kC5f3HV9r6jsebcIDCbok8jL0K12/AYI2T+XJHE28k/jQ6R2/gS8OEdOS6BP?=
 =?us-ascii?Q?S6Pd/fN7dX3cYozbZcrXlYAfWJ/RkMTl6R+v6mwVEsbnDDkUCL8az9oe8L9y?=
 =?us-ascii?Q?YU4haC1giPvKt+NWzQhVO7XW+mgehEBsvi/kQcvErdqZRvbgDyP+sHCed9+c?=
 =?us-ascii?Q?yw8jzXzBC37/ml3gX3eYbJswC4E4KUCA8t+vlshC5hjyuJljbsy9fpj8bXMm?=
 =?us-ascii?Q?mMc90QYs4xUmDF7gQqeoI+b5YfpmXKZrWWTfFvt7VK03OxLC6wvbPShTdgF1?=
 =?us-ascii?Q?/H9d3xClXNDgRVpKZ6ru+MmYQBPRImddIX0HkgMRgKj5Rsme6Ew1Uef6YEJq?=
 =?us-ascii?Q?6xQUbJUrUoAPwamJqDDW25U3P9y3hPPRgHauQ5g3GmX9ucYZAusQaMN7c/Yk?=
 =?us-ascii?Q?UQrKYcUlVhAl1t+kJAgCSDxDbFdKVG2zEbhHltxXUiXnc/pH876fPXyee4DZ?=
 =?us-ascii?Q?t/Zdlu312uEGmOwI1QaJuyGCJIezGcF4JEP20sLwQczuOsjzGQLar4MncMhK?=
 =?us-ascii?Q?L90gU4OQfC0GDTJNrmv1aTaau7O3X+oSkLK/fOk85uglOlPnP6x9YYwYw6cO?=
 =?us-ascii?Q?0sQY1YWTZOErX5Cqp7RB2cHZUVg3Vq/cTPyhgZqL2HzcvrV+8g2kTs0Rf68f?=
 =?us-ascii?Q?fyuM+/WxSg64oZjBcrFp0iBtn4KRys9n3X3X70EFfnMi4QlSEAxAdV/f2m6F?=
 =?us-ascii?Q?FBYJzVLMR/rOk9DaHFn6PceCy8HRC3mJnFWjZcTQBKrGQ7n5Qg8jbhfeGpQV?=
 =?us-ascii?Q?VEcNasndTQInrr5DGchcIp0XZSdGpcmlVuxmzCu65NC4Hlxqrhf63rLs1g1t?=
 =?us-ascii?Q?j9hMeW+CN48KCfUVc1OSDeaPeGv8aBwqWL7e6WMKOEL6j1BgOPXqFH59dO1B?=
 =?us-ascii?Q?K+BOt2C8SHXAck1WG96ZkhBpthS+1t4ratVo5xi9fSiconBAoOp7+7BgsQWl?=
 =?us-ascii?Q?5UMJg+pfHW3WJtnGuMtKv+A0ox69WgOT3ewsV+Me/NcTPnCffBDco/JT386P?=
 =?us-ascii?Q?fyKYXzJMOHNyDbVR3iGE5rahkgPA3lMauBMjHPGrL/kRqvIC8GmUFS2HMNrZ?=
 =?us-ascii?Q?fCMfmFIkaJgXaG+frG2RrudgEA9mnXmFOtOpPAdFj80W3526Cf0ErEVPepjR?=
 =?us-ascii?Q?2QXyNsAbXqDBKrWNjyQjpRKa55IuuydXRQNoz8hiIJra3YtCZ39YonNKnk13?=
 =?us-ascii?Q?8vjhZZFeI/CQ2CSjUU7mrWdq9SDuXwXhWsxoM4B3OLNflZFv7YM09ftXwH1t?=
 =?us-ascii?Q?1cfzV8DF7L+7NweQMtG6exmUD3SWts6fS4lX0MvCGHGu7M4cvxi7tW2DaEw6?=
 =?us-ascii?Q?lCYAyB7TaVIPms0CUEn6XMynRbe3lBMCH8jbKAW1qKtnFMhePit9zjo4BJ5I?=
 =?us-ascii?Q?Q7nn1rCUeN1zgtx0AddRmAb6ZBra1gbBOpTL+ub2FrwkuLIf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78692564-c769-4fe4-23d3-08deb59b4266
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 11:39:17.5760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VOGnj9fbiwCxF0zWb92wiJ+6v/9tdLw7TLoJcI4dF24yyYkKx3AC65Tpq8riIj6g
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5687

On Mon, May 18, 2026 at 08:38:49PM -0700, Nicolin Chen wrote:
> dev->iommu_group will be read in an ISR-context to look up a group_device
> for fault reporting, in which case mutex cannot be used. For that read to
> be safe, two things are needed:

What driver does this? iommu_report_device_fault() has to be called in
a sleepable context - usually a threaded IRQ handler. So mutex is no
problem.

This seems like Sashiko slop - iommu_group does not change while a
driver is attached and a driver is not permitted to do any "fault
handling" after it has detached, it must flush and synchronize its
IRQ if it is using this from a hard IRQ for some bad reason.

You need to be alot more critical about the noise that Sashiko
generates, alot is useful, alot is not. It is a not a tool you want to
have 0 reports, complaining about hallucinations is expected.

> +#define dev_iommu_group_rcu(dev) \
> +	(*((struct iommu_group __rcu __force **)&(dev)->iommu_group))

Don't do things like this.

Jason

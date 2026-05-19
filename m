Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012016.outbound.protection.outlook.com [40.107.200.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB893A874A;
	Tue, 19 May 2026 19:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779218199; cv=fail; b=k8Y6uOY7prH0jMke//aIPLbXHxru9qfXFXdNfqnj/XrRIuXScUp9/PxgAp9cx5XmeDlcB9MlkVCpErv5sriZHSAcFIWGhAP2bwjdpJeLC9p1yCbSGS8/edsW6l2DLHYHvxSsh695G+e6aohk+D3SwTjnxJCssjVjLpIzzbXzBLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779218199; c=relaxed/simple;
	bh=gjUnPCVWk0kVCetrmCCNH7uoiMnG2Y7VsIVzgGw1Oq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TgKCzZyJudm5ZXk3xrWngSai5GNl7pTmIlx6RZ+g55r5tXRRveRp38HKOww1hFftdXo6vR/OF65955xfI50cUCIk97GdlFUrnB+R9e2lcVAmnEmIfhZiaoWd/ML6RYn5RtN0mL/gXFIMtvd27bifUTODuyel8jJZTU35jDLEYgs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VvVa0iUP; arc=fail smtp.client-ip=40.107.200.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VvVa0iUP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NIyz7nwI/lklsxeepeaHjJCMod4cE9f2ot9joGxa92qw3EDQjYJuCMbdirG0OxpG7JPEL8h+e28wbQN9GOrQnW4csEjCUv0pXiENQTaLLhTlAOSAPSgdMj6DySXHA2uqdWmcGp+t12VOuvFyaxp6McgRtsJ8fd7vqu/qjQbiZDP1Pv/ob+WvWJTB6XS9E7dOZ0At5NltqmL4DPQ+d6uYdUExH0A8GvEwRL+A6LY9AgtmRo/CJ1qKRY1HzE0zYjX+2dqjhYQtWlNSr4P0JwDQfG21s3QEMBb7AjHeIwmjSMqywoyvj6b3c2kBX8d9kpSv0HAK46RpUtZqFLlu1JFXcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gNvfUzv66IFlG6bJPbP9i6LZEOGo7RGx7Sh0rLn8Xi8=;
 b=XkfH8Kg/upJgKyqIMLj19Q+FUnYoikITQy1hQMUO+QniTM2YfzmDGFdFDxj8K2IFXjD+oTDE5/LkW/K1cuLN6HpFG8imRy7FPlUDWTt0MiPwD1YbM0VowIBK6kzEDOCwbss0X30b9BCqRYQXpA4lMgL2izI3DlX53KHlwTqpCllM0LzAZOfCKgtWZleMy7s+6JglrvYhk5K3H3OQr22aa1Hkm78Ckf+VI0Syc9eGhuysj2YWf6TxYltHeeL82K41Vv4z+Di60z6g70WcFXWAoU2P1TsZDvGmPe387Q3g8BaHZl02rmJ9ItY4FMcX0xJrTZJKzfO1bCV9nkqG5FEgaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gNvfUzv66IFlG6bJPbP9i6LZEOGo7RGx7Sh0rLn8Xi8=;
 b=VvVa0iUPPbIeIqGx8+zj1eTQZXdXhjRvAT5uFXHVERYpWfr1UTZcgCF3lvl7uQX/JgUHb8JR5jCpSYPSrVkIIvfeddXYdPthFxEXaYaci+flfS4UIPDkzl4of3YjeMySI7/oyCZq3zLVUgGteCJ+BstIE0LaLEbPiSo2WH2BWM1GlA/47Ktf7p2CRlPf8PgXk2l6RlPD/ipB75jZxOpq4n0dvL6uQls6Zw7cvGZdjLVhh4xRZGrY9MGO0zVi2O4P4kPF8p73i+D5hkN6MKw8V29Kk095+3N+wc/8zebk6r+it79JOGe9VvFOH26psz6ZMFHci5sE8xeyDPRkKGxWuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS0PR12MB9424.namprd12.prod.outlook.com (2603:10b6:8:1b4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.18; Tue, 19 May
 2026 19:16:27 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.21.0048.013; Tue, 19 May 2026
 19:16:27 +0000
Date: Tue, 19 May 2026 16:16:26 -0300
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
Message-ID: <20260519191626.GJ3602937@nvidia.com>
References: <cover.1779161849.git.nicolinc@nvidia.com>
 <745da1a819eb943f2519e660c8bcfde715885c6c.1779161849.git.nicolinc@nvidia.com>
 <20260519120737.GQ787748@nvidia.com>
 <agysAyreCY4huf0I@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agysAyreCY4huf0I@Asurada-Nvidia>
X-ClientProxiedBy: BN9PR03CA0967.namprd03.prod.outlook.com
 (2603:10b6:408:109::12) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS0PR12MB9424:EE_
X-MS-Office365-Filtering-Correlation-Id: 852daa22-b1d0-4ba8-c113-08deb5db201d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|4143699003|18002099003|22082099003|56012099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	MKd37Blj3m97Akwkl5ol5sK+66wvdq7SIdAlS9Qn2hwe/qbx/xRCMJiDqnzrOzWgdg1TWh779aLKp6eIra1KzW0zso9UumnjkyZMrBtxtjhyuq5bggN32DjDcSzSEgGKnA4Iqojjuuiar7Vvya9jBN2C8JWGcAlw53y/3Ci7DEM9yWcn97mujNPK3HrzLUK+pIqk7SAbTofsDDkvwsitGJSmlDCQ4mUOq7NxPyCe+A3LeuPahRkvqH0xyMSZtGj/kY1o4LtExcSwcGJDm0PhT08zGTwX3QdJuIL6Ls+xe6yNqeH8EEO6RspFkRkir7fFF+2+0E7buQAgwMNpNBwohYmls6QtIDg7m8sbrGWV2u2dygDMj3tQoF603z7oB5VBAwAsZ1nDGz9rxV/Isp327yqxKdhkHRtbM9Vzp3Mucmx24qnDjyJUSxYXQOHJiZRtAF9u8+XRqYAsWjWyyu54p6OcrRFtvHGPv8RQuZt77qxxqX81fin0hJAus+zjeEhw/cutXt/Qew+Pvoc4i7Tb0daFxfG2ICCE+1E3PkkLBH+hbM7rJ77yhzcXQaJ/y9TqxBkWYHdUkMAjyVXLU+IMEQx9FU7qKoyOFC2lrYJ1P7R+B1c28D8ZI7tQqejC+KcfKE1IbZaV5ZObkW9/pmfJPSbpnxyRLVYkvEOu8vi+3Rsy2wvRkg63MVDGsDBKWt1P
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(4143699003)(18002099003)(22082099003)(56012099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1StthuqfahQIvTduMoXKoSTtRm/rCKpMxj2cU0/R9LjNPrwVSUNbC0BQJIrj?=
 =?us-ascii?Q?Fv8Xp9Odp5mzWlnxGaQtpmr3GD43MLRLgwL9cd39L67RBdgqsch1F6Q0A1/y?=
 =?us-ascii?Q?oL7FphVEyqaWD0hcfL9J8/GbHSV61fyCjQumEmAkrB1CtomdA/+hQ/NcK1WV?=
 =?us-ascii?Q?201L0SH3cTO9/YvNjm//Z+EEsYzCNqQe+U120k7b8wboxYsgGXqfG8yw8Iy0?=
 =?us-ascii?Q?Y5YW0oN22SQMjjnw6I2+0HiQXOu8LxUm8VXtcIOGDo2BQW9OkIrfz3PvWIMT?=
 =?us-ascii?Q?1HoRIAoaIKItg4jHSmWaNKvFcQ98pcpUUSXL3kjzCocg++70AUtVdS3QTv+d?=
 =?us-ascii?Q?aEd6EY8z2zTmRzTfgUJYa738IaPwtaOt6ZqShirsYTnOhl15VhD2rM7WDuKJ?=
 =?us-ascii?Q?eLiFY3sUQyJXByXSIcNY5jMoy2IZELfsDwdSCMfLbViHcCKDm5jRhdmDSmZL?=
 =?us-ascii?Q?VRBtWh5grehpHRuU/87Xui3BysXJ+kAx6C2jAFDg2/ylneEqUCm8/61gJf3V?=
 =?us-ascii?Q?nx8rBhNw3HDb9E9Okdk833u3pHP4lyXzOYCJ+P1qNmN3HXbhNmtGxk1qUEVc?=
 =?us-ascii?Q?soHZzM4iOVM+rhtm70FqHhRokwiMjU3WH4JoPKvRzF3dZV6sBvbGfyPEBHAy?=
 =?us-ascii?Q?Th5a8VwxnGFRzgXrXp80P9KWEDE+HO1/R11O1EYozXg+hnC/CN/DrzgUEgDq?=
 =?us-ascii?Q?n19icvLigvwyZkiTfLMrEgzXYzkmmTUwuN0yufxLXWlXLJO9TDeZcxrqyWZE?=
 =?us-ascii?Q?y/leCbVM9VEnHTF8sQoHxeO/+UFK2P5WKOQqDjzLad1mpJ20U06IfS/0VPsb?=
 =?us-ascii?Q?PUJhb/F15nEEUnRfqPAEvRX+nEPJZk+pRxQCD2H8XavAVIzFN/VsIz7j/QWI?=
 =?us-ascii?Q?fr7VCoNxMRqh35JQ3PrzdrkjdRXlvviyzNxH+gs55paJ6Cln5efWEi4+uHvt?=
 =?us-ascii?Q?h5aMFtza+VnzAqeIvlv9zw1cwp8xRuARr8jMtwedsm4Mqjc+Vt/SYyvP6pXZ?=
 =?us-ascii?Q?ZIf8cKZ1y5pyDRhInhNzKjAKV9T0EmsQ9wkqE0wOLRiaNMSeMv1KjCF4JpBo?=
 =?us-ascii?Q?PJ8T0IN5gTIq37astCLLVLF93aXhUvfURbRNP9L2aF3skYlyc0Q6tKkgVYpt?=
 =?us-ascii?Q?UxJIYYvGR+ZLj9w63WNSUvB05v2K+DtFPm1nsTaUlOsScXQ2tWuKcmQLrTdK?=
 =?us-ascii?Q?ZCg9tKhuGr/l21Yx0bLE4nv9nQuPNjlUzrysrYAIpcvu9bhIQyPO5HFRIr7m?=
 =?us-ascii?Q?VOZGtjGCjrb0/jUFiQkPDvIn8OLY36Nh7iMrB/DGl04tKmyn30HTnWSbo6og?=
 =?us-ascii?Q?4RjuC0QdcMBb9icMzThRcaDyS8QvGGFWeRH+vT3EjvgnoPh5y3PbdXFwJuWk?=
 =?us-ascii?Q?n17qHRXLt3NTvl70gpVhfA93gGhzfH3kH/A4QzIk9lnjw9mlTHFXBOhqcTIp?=
 =?us-ascii?Q?4RpCp0BsAsIVUZUUn5m+VJLuTxI1vBTXqUjryoQ0hqM6i3nO/QlFEeNKg7pB?=
 =?us-ascii?Q?/sE6lDM6d6bFBqhMYAVaOEva2WVF8XKFGLGE3t5zrQrwb7ZcGMyBnPaoUAML?=
 =?us-ascii?Q?yeZKZaaHinmEYBOIGiTpxMHc6oLkqQ1wwLd0TWY0u8pHLBLeNtslYUcv6SgK?=
 =?us-ascii?Q?gVqmXgAYWdhGH2iRs+miZOHnL29zDmmkwz1wRgrKWmenLckHCUHW83/crCqs?=
 =?us-ascii?Q?SFCo4vq3FkVHj9UNiwOzx4GGM4t8cxRSRMDEWDb3Tj3kpCw+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 852daa22-b1d0-4ba8-c113-08deb5db201d
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 19:16:27.5698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R+NkIOBFtVy6WOguuI4Ny7Agd0l/NReprMFPxRCS2+4EQzdJ9y1miecS6yGFMtxy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9424

On Tue, May 19, 2026 at 11:29:23AM -0700, Nicolin Chen wrote:
> On Tue, May 19, 2026 at 09:07:37AM -0300, Jason Gunthorpe wrote:
> > On Mon, May 18, 2026 at 08:38:54PM -0700, Nicolin Chen wrote:
> > > +void iommu_report_device_broken(struct device *dev)
> > > +{
> > > +	struct group_device *gdev;
> > > +
> > > +	/*
> > > +	 * We cannot hold group->mutex here. Rely on iommu_group_broken_worker()
> > > +	 * to validate dev_has_iommu(). The iommu_group memory is RCU-protected
> > > +	 * via kfree_rcu() in iommu_group_release(), and group->devices is an
> > > +	 * RCU-protected list, so the lookup runs entirely under rcu_read_lock.
> > > +	 *
> > > +	 * Note the device might have been concurrently removed from the group
> > > +	 * (list_del_rcu) before iommu_deinit_device() cleared the dev->iommu.
> > > +	 */
> > > +	rcu_read_lock();
> > > +	gdev = __dev_to_gdev_rcu(dev);
> > > +	if (gdev) {
> > 
> > If this is why the RCU is being added it seems like overkill.
> > 
> > Just add the worker to struct dev_iommu and push it there so it can
> > use a mutex but I'm confused why are we even adding this function?
> > 
> > The entire design of this series was supposed to have the IOMMU driver
> > itself adjust it's "STE" to inhibit translated TLPs synchronosly
> > within its fully locked invalidation loop.
> 
> Yes. Surgical STE is done in the driver. But, core-level attaching
> state doesn't reflect correctly. So the driver calls this function
> to notify the core (this is in an invalidation context -- not able
> to use mutex).
> 
> > Whats the async worker for?
> 
> Then, the core needs to block the device using the similar routine
> to the reset prepare(). And that needs to hold group->mutex, so it
> needs an async worker.
> 
> Do you see a much simpler way?

Put the work on the dev_iommu and forget about rcu.

But this is all probably better as some later series if at all. The
driver can block the ATS and the expectation is something will FLR the
device. The FLR will set the blocking and then restore the
domain. None of this async work seems functionally necessary, though
it would be a nice to have. Lets focus on the bare minimum here it, it
is already a difficult enough problem without tacking on these
extras..

Jason

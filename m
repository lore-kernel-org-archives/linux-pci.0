Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012007.outbound.protection.outlook.com [40.93.195.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793523F1AD9;
	Wed, 20 May 2026 17:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779299493; cv=fail; b=kM1hPW/CMqLR3krPsDF3sCvEjfw/jn1KFFSeBXIod/YG/A5gClGu8eu4tQbPRvb7co/b8Y8UkG55SvRiZqP7q/8CQ41dbS41oicbcc/9zVe8QFprE8XfmosbERjyx3OU4y/7xffewgacyMNvKhP82Omr5Gx9A+qMtldklG/sqPQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779299493; c=relaxed/simple;
	bh=6hjBYbU7tyWmzeSqFIPMO0wITPKphDEGo95lcILhEZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Xy8YlHgMPJy7euCRH0ikAb/Czw56d9hfksDLs2pChmfaBX1BEAwe9N5aH4gDY0SCG4tLNQf93zNjq1y9eF9MquSJcAsZKtYZtgGtAPye7oYj5Rxj20/fNl3Kb6V5qFpzF+SjYTffzI2eP45iMdGEgQJYJYNnU84DRK3tSn+m65E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qychlFnd; arc=fail smtp.client-ip=40.93.195.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qychlFnd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cT/PX8r+RHfI/Rvwsq7e/1I1ldFEDxjVBskMbDB/4w72Hkos6+Kxn3V83/JFQrfpo3KZaZuWOoj3+Ei8sgXS6gh0toleHaZqNbz15OLq9DH0GGHncssEcHEAAepIHlDvpBB1heKQN2xWzZalNpBb2Tfne29NnbJOgUqki5U+K48Xrv9AXt9RUZzb6mFoiTT5iIkV92XVJTIPdazI4DTxUCnL7ZD2mjHtKnw5UUqE/9h76ENHfGCvwfKTjR4HZVdOyM444lWokoDL5gqglNlLTOpXoAS6lJ7Zv+8/L+KWbSp4RlG9PveQEVSNpERewJzYg+VAatVuRe/NdCtBX00vuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1RHI3T04WVx4klEuwSec5bejMZ7Dt3KXut4T+UVNNsg=;
 b=ggHm5k4hK6MeU6zCqPK1DWVkkXNhPVwN6HSoHkQPVJvOAltc7XyMQR/U3GHXoxO8jkmAwfcvGCAEiqueptPPES7FHcIMdHhaDDXP+HaRUM3GsiXIlYT1qYlOf2PSttUrcpx1LcQ2OCC5hVUVtQIACMT1Ab8asKuqiCaeaIjuy4U5YpGr3WvC/gMsDOdGRyJzhMleIRQmK3DwxgAZOKWqtuxYG2O/IdaCRR6P3GIvpqHn4D+OpajowcB32Z9Frav2tGoXzGpjB5SVH/tQ5xIrsAd09V0x2ee/vcuA92An7+7m/ex0mVu5l89gz/jwYEOQ2WC3XOBxQP5TlthfvvF+1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1RHI3T04WVx4klEuwSec5bejMZ7Dt3KXut4T+UVNNsg=;
 b=qychlFndoRspVBROPaSi7t0lPXhtnSQ+smOomzjo0uCqf7LZI/MwXyzbVwwFR0lz88Z5+yK0kwnCu8GL7qsLp4d8JOhKuetsoHD4/q+M8SNcV1Mwq4x35L+Oksm9AIy95OveHPjSUTKTrXCTy/3U2fTU4jwWpWIdtpZabOp5m5SDXvyqB+Cyphza3i53r2Fy9WbdRk+PaTVvUtP8n0ulYU4XMhU2iDRmtKQXkoBuBn0fwqnhS2jafLk41b6RmLdvLLhonTO5oztylV0+twItCL0YQV2J8+Kv9m3yu3VZj2WliYzQAZFzzA5X1cyech9NXCr5HzoKv2QjcpQNaJV19Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CYXPR12MB9319.namprd12.prod.outlook.com (2603:10b6:930:e8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 17:51:25 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 17:51:24 +0000
Date: Wed, 20 May 2026 14:51:23 -0300
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
Message-ID: <20260520175123.GZ3602937@nvidia.com>
References: <cover.1779161849.git.nicolinc@nvidia.com>
 <745da1a819eb943f2519e660c8bcfde715885c6c.1779161849.git.nicolinc@nvidia.com>
 <20260519120737.GQ787748@nvidia.com>
 <agysAyreCY4huf0I@Asurada-Nvidia>
 <20260519191626.GJ3602937@nvidia.com>
 <agzkldmlG1cuDkj4@Asurada-Nvidia>
 <20260519230204.GM3602937@nvidia.com>
 <agz+kL2S8kcgHywG@Asurada-Nvidia>
 <20260520003023.GR3602937@nvidia.com>
 <ag1guf1fHg4fE7Lw@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ag1guf1fHg4fE7Lw@Asurada-Nvidia>
X-ClientProxiedBy: BLAPR03CA0085.namprd03.prod.outlook.com
 (2603:10b6:208:329::30) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CYXPR12MB9319:EE_
X-MS-Office365-Filtering-Correlation-Id: f88478e2-024a-45ef-67b0-08deb698690d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|56012099003|22082099003|18002099003|11063799006|6133799003|4143699003|3023799007;
X-Microsoft-Antispam-Message-Info:
	59TNYz3tKwHKgMu1vQTg6D9+14o87g+vQlq4xbrUgdv3j56G1Nb/JMmBguhoDEvWX6HXMHnHWbjIQf6RHYa0f4nDQczqNdqSlxl3QEmIX65od6brMf9ttEKc7j8UPWnnztDLdlJ2qAPjh3g3i3fT7nKcLWV78Kpev8xS/ucMdqeU8qxNEkeOQctlZjGnm4Tm3IhHsAbuvo/IM3s4iiDKAFhlJyqHrXIhm1E+NhH+oWLfl5AZGAjpyXeMelKdtQ7WW2vaEPtiXCAbX9BRfDTg1+r7R/VkLoQQ7EoxpD+ns1UnJWn1dbdlJsExzAThctbt7/POoFnKrMUAP8qI7ksl1mEYDAQjWobgR+2iKYVGNIW8sAP6JbmMOkaBsBvMfVC4Xm5bb+EVf9nNuJrLNvhEHM40bxbFfjO5cdtlsIpUA5AhyK5IyUxZdqljd/DKrKlLq7gO8JtLGiAamJXS2q5ktHPum7DzEnHe9zNfGGd5R/2NgECH9qxBIZgNvRM6m1a0/aqvuWwQgGlF/uKBZy3rsA49egiWA+TmdHuRWxKUx4om7XEA3Zhk4mBLBuHWxONf7MJ1iDgrxV1/hBqrLwYjjqx+Trg7bgFQ9GaTHifdC1BItYTwjZq/H7MDlRa11AsEIHXIg5HHpltev6f/aoZcHQhMasz/1R1PabZLkITMNUB3jVGdqPksH/9plOgspaY9
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(56012099003)(22082099003)(18002099003)(11063799006)(6133799003)(4143699003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zCtDsokfrMe5M3uoKPwBGW7JscD6RM28KSuFw1kaAL/A5Ge8+cYZNQuV4CXv?=
 =?us-ascii?Q?i7ER4yHyHr+9qZCk++ebpAwDbFYisRWDpSccWT0/SpcEln7aqg7tFclFhOak?=
 =?us-ascii?Q?g2JIUlm6QZlIloQkXiAcwln15Q6LmsswbHfq1NU2MNk0vWL7tEULzP7T1idw?=
 =?us-ascii?Q?yID27CQk76Rr64GCO236lZ51NwnnC7VDdEdseNN8nRk/aVE+kRqvCf1hzSG3?=
 =?us-ascii?Q?UhrRVNGO6KSSWIMR1KSIypsOhWwZIX59uKfq6W5d48VKu/yJVdqubl782S+B?=
 =?us-ascii?Q?blC4ZTEVXHxKsye07Begs1j6hPsH95dDcBEI+XOhgtdiC0HsDP4AaCNV7YOK?=
 =?us-ascii?Q?pkqfcipk8YnMStehWsuzHQPY4tkvbnOwbsig0ZrBUTkHM++Tr9CgbU/mCMkK?=
 =?us-ascii?Q?eZQ/gweytMpoWmt5upETlSDCSP4KOsVxoN+qf/IsLa+RDfV/XZjZ/PP6stZb?=
 =?us-ascii?Q?zqXLb2mmtoWRP8+aNZZq/QeR1mDC4/G47nJT+ZxLfrQaBWUUuWB/GQYw3L5C?=
 =?us-ascii?Q?55LYxqStxjeU5ZIKFI1yPLbABWMcxhngYhgWeRHL4eKu+pogLdWJZ7+tPSa3?=
 =?us-ascii?Q?q0mLA7F6YF5q4C4F8JjUGielvJuvWNL+aWotsTpHDkeNOzjEDl/JX72BY+vY?=
 =?us-ascii?Q?xG0EClJd6VVDQev3f7CsGYgHIPlWBi1qsPIQddcKrs6ZjzCN1dNAjkkg84nA?=
 =?us-ascii?Q?wkyvOMGTKlZP062ePy2ZvTk0o98icdX55N8nK7dSyOmU/L/Nwj840qTk9Q3W?=
 =?us-ascii?Q?TqwaS/VmW9oVdx7/cQdKtJficOJEI7ojWyFo7o7jU0JESXomIUk7EoXtOu34?=
 =?us-ascii?Q?d95CQdCmVhMOj9NTx8feQzREndF7DGb+c0Nd5J33HDIXZwKK/zZr4I5drlJI?=
 =?us-ascii?Q?TIlV9ew2GvbKb1hVbdwt5yfT5FV+VdWdeaG54XxbvsBJ2NtdG40bT+JesXAu?=
 =?us-ascii?Q?fr7m8xiMTBBYx5PLKe8ASJNEX5evR9bQJ2wiB3vDIlDXmkVufFhCYOorGwDA?=
 =?us-ascii?Q?5cIsM1WOyVSTIvgm3ePcSK+qhEQt1w6uhFJj+4zJu82dcKWA7TTfvNyrCRIz?=
 =?us-ascii?Q?Z+Sg36HKFQX5Oh1hkZ8CPxgwqsxsiDqfcCy7TTL9lFYVvfcRpPagXT4B35QP?=
 =?us-ascii?Q?BI0fcd6lTpdEp4bXIRmzl+hS7MO8YVz7amTCWPWP0B/VzBeIDNU6Nqtz0BGI?=
 =?us-ascii?Q?SPjE07qNHDLleuiFYmp3ozTSF2lo1H17uKyPVAFeBYMtAHit8ZFUcnrA8jNW?=
 =?us-ascii?Q?nfVlI6OweAHr8I6rJX47zqtOImKeOGUZIePM2Pa7Z9x14kbxx+X6TOm2n2wI?=
 =?us-ascii?Q?n8f+8129G8/pda2QRPNvurGCmZ49atrf2k5lDBQuKEPoqSQ6cSGFONMBVnks?=
 =?us-ascii?Q?pwv5UJFLcQDWvNDEfZ0oH22HSyUekllFyaH9YEWEmH3GcrsY1KFkDG+cj3VC?=
 =?us-ascii?Q?04oAJhaGj8vwNVWpz1GKMF6qOaUUvztx8dU4S/wCJpy8Lz/UM2L8EGrmYsbl?=
 =?us-ascii?Q?xUZ06q/M/SsKxYue5UekYWFlt0tFKRaKhVRfDH54xBrYRoGempHM8Ok1+nYC?=
 =?us-ascii?Q?32Bz2PyOfCosreziat4ri+uMXQ0nbmILsUYynZ5AFdN6dTSSler0IfUEDeWG?=
 =?us-ascii?Q?rpJ5LCsM0NimgHhOudN4Cp5OsgN7x08Y9pLISMnpq3eoNtBOwvrCKXL2HG9z?=
 =?us-ascii?Q?Wg/qAHiBn7gDe/KSBW+6Sc4GBgO+SclL5VZHh1Sdwi74XcdW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f88478e2-024a-45ef-67b0-08deb698690d
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 17:51:24.9191
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ct5RBfrK4mx6k1OYniNIxP9lHOs6GI2old7can+I/ib/N3BOVtuA4RFCSuRSdLby
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9319

On Wed, May 20, 2026 at 12:20:25AM -0700, Nicolin Chen wrote:
> > > I see you suggest to treat the entire batch as ATS-broken. Just to
> > > confirm: without per-SID retry, that might falsely block a healthy
> > > device in the ATC batch, right? The driver now batches all ATC_INV
> > > commands via arm_smmu_invs_end_batch().
> > 
> > Yes, it is not good, but a giant complex series is not reviewable. So
> > I'd start with trashing all the devices, then come with a narrowing.
> 
> I can take that path for now and leave a FIXME.
> 
> Another option is to not batch multiple devices, until we support
> retry (which shouldn't be hard to add since we've already done the
> coding)?

That's an interesting idea, it undoes some of the meaningful
optimization we have recently done though :\

> > We cannot eliminate parallel ATS invalidation. Two threads could be
> > concurrently processing the invs list. So it has handle it, the driver
> > is going to have to tolerate a number of redundant error events.
> 
> OK. That sounds like we still need a flag or locking so that at
> least pci_disable_ats() would not be called again. I will see
> what I can do.

I think we can call pci_disable_ats() as many times as we want, we
mostly need the driver to merge multiple error notifications for the
same event.

> > It depends on the driver, mlx5 has a FLR RAS flow for instance.
> 
> I assume a driver like that would trigger FLR flow on its own?

Yes
 
> > A driver with a device that can blow up ATS should implement the FLR
> > flow if it wants automatic RAS. It requires driver co-ordination.
> 
> Or FLR via sysfs, which I have been doing...

Yes
 
> > But I wasn't thinking we can rely on existing AER events here, yes
> > probably there will be AERs associated with the device exploding so
> > badly it cannot do ATS, but also maybe not..
> 
> So, should I put the AER injection on hold for a future work? To
> be honest, I am still not very clear how AER injection could help
> here; or is it for a case where ATC times out while device isn't
> aware of any AER fault?

Right, if we don't get an AER fault then we should ensure the ATC is
surfaced, but you have a reasonable point that it isn't so likely the
get an ATC invalidation timeout without a corresponding related AER..

Still, I'd feel better if it is was definititive and we didn't rely on
this. This further points that the driver has to merge multiple error
notifications if it gets some AERs and a new "ATC ERROR" all for the
same key event.

Jason

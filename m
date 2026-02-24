Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012054.outbound.protection.outlook.com [52.101.53.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7D239E6E8;
	Tue, 24 Feb 2026 14:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771943904; cv=fail; b=FxSH6GvYt2mny0Y9R2KlKxaGa/ODdF/gFuWBqjgIcR7YkHauEI+Ql9P5N7WXwZ0DZhsKZZb/yW9Y6+SavQFsON/od99TcO1D2tJEQSBFzVuSCsqrVhuS8BRHRO/qqXAE+mw7Lm6sK09WcsqGlPgZr4pE/ENPwUlEgKQfiHmry9o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771943904; c=relaxed/simple;
	bh=nBi9p4mCWohg+2pIHkxzd6K4T6BlRhJ14qOg1IV5Kns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LSaKQks0f5VOC82/8LWsVTuwLrbvgfkNnxoiGtH4oKcAlXb+K5yRyHVPjVMLh4dvXD8Lp2q6wIFXA5mYgQyrcuN9a0gZ62Qv/AMRz2kGJr3aYZxs55JbRkNTtlb1ZU/4vG1rTs+QBl4uAzWZs6ckqI2zw0cf/2EV4sVtWQYytto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KITSLE2W; arc=fail smtp.client-ip=52.101.53.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KITSLE2W"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nJIJSYdpx2UYUO/e1/dqoxd6NtNkizJKZCeo76Uz2CH3Pmyk7dVvmyrzNiJlJDB0GZqIFMwf8pgVu6GiR7L1DKZsb+p64iDGLfsleosTcugZrPd221mP8GgqtaJoOMRmeiiSJJgbdEXoZhL7NXWJYzmmTzPqk+YUPSiTJrV9kFeT62hh7Z04n5VXqCCKLT2RhA6Ex96Y87tHN7oSE3l0poz8fj/+m3X1mRazjpt0z+r8k7CrM4r1Sxs9Pji0LtuZKefzRkGHPAlMhMn8PC5m2NhK1PVPZp+Lj7i0Z7+K/LMoHijfy1YGzdsshAIhZLHkWsfYooy8A9wPQw56Od8JZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nT8yG2jm1Z0rnRkroia3ywEyGWFFG0wrFWTnHfcIj9E=;
 b=WU9fKp+bHpn2/zGenVN369Pry1HkYTyngLfCHW9RnZDSv2X/3cU1BTnWLmDnd3UIFRSExnD24NWv6aOkOFOwuOCHXsU5kA7tm2BORhVZS+tNpFFn8B8YIdtk6DKmBN+VqmZbHXtzFqY6csp7A7I1r0+toL0J0IV3EI6SM8gN71rnnQKKIEoDjHCATgYJVwW+xMcFrNrFq3hHUuSuT3llZO+cc3dF+Ql3uah2vV4YHkiRRP9fvCmGr8yyCNZPCUN4rhqUgQRSqaHaF+LLZndeMTrjhTwMyy92b3GNGUBra511RKBSFJJ4YeF2S1iCa7V6ELamJP8VxdrySHiVFT4rlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nT8yG2jm1Z0rnRkroia3ywEyGWFFG0wrFWTnHfcIj9E=;
 b=KITSLE2W9pjWObCwtnDpZP1LfTOVn2lhLflwfU7MZ2jtJeBTozJlDwbBk/EmKuzhIwWEmCKtefYxkeJJ9ztumiK7hG56fyw5pcSongsWJU2OgD3A1wyb1lwXt/M0iV9pLT1EslDr1uaIqQVB6MeyHx53FpJvEk23L9HNFk7GKdeSQPubqTPQ0NKB/1+VaeWq+Cr4B+DNdMvdhuhQUEhe4mpYSczDIBbO4/zOM/v8YHDBGQ+BrgyUtqghYCu25KIKReJLjzA4e0RrP8mJKe7b8chDSjUXzY7oxFLR+j1eb7n6rBxR3weBjHiPWYUT9vfmOFECAv8zp2FKPToZDDlfMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by BN7PPF28614436A.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6c9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Tue, 24 Feb
 2026 14:38:18 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 14:38:18 +0000
Date: Tue, 24 Feb 2026 10:38:16 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: dan.j.williams@intel.com, "Tian, Kevin" <kevin.tian@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	"will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"praan@google.com" <praan@google.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"miko.lenczewski@arm.com" <miko.lenczewski@arm.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH RFCv1 1/3] PCI: Allow ATS to be always on for CXL.cache
 capable devices
Message-ID: <aZ232JHtVU6N/tFx@nvidia.com>
References: <20260203143348.GA3931454@nvidia.com>
 <aYI0LUdXqrjmRcMo@Asurada-Nvidia>
 <20260203175540.GC3931454@nvidia.com>
 <aZZDo3BeuBKh9q24@nvidia.com>
 <20260219143737.GG723117@nvidia.com>
 <aZc//6kvH3Eqfwfe@nvidia.com>
 <20260219174139.GI723117@nvidia.com>
 <aZfoqETxb31jp/Pk@nvidia.com>
 <20260220125044.GK723117@nvidia.com>
 <aZispVftDE/6u+Xy@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZispVftDE/6u+Xy@nvidia.com>
X-ClientProxiedBy: YQZPR01CA0145.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8c::11) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|BN7PPF28614436A:EE_
X-MS-Office365-Filtering-Correlation-Id: e18247c7-feeb-474a-11be-08de73b259b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mgWNFJYZag0TOSN0pEEZDzn7m47CApr+XuhuKkJ9m6mu2nwo1HiaJ94/RN7j?=
 =?us-ascii?Q?vAeEFPQbwHO5Xkzc24qspoZ81rTMxQ8u17y9zY3mEzKWQKUWJOwrPFrjFGdG?=
 =?us-ascii?Q?oYqiEVdKZuYQm+VRS7ojzGkJBZCF2AdD1FmwTQocfc+NHWBqMd8OOZg8LBND?=
 =?us-ascii?Q?oGz55Rm1U9EkhgYHLSauSonQj6j7ybP+Lc2/wbJ/YXXUymaXgAZT/qVbi8NF?=
 =?us-ascii?Q?YhTFPWpGY5ZwhGFNx2eUwxvFapNO/9tk0pgyW6YsJlWLyX502UkKFtl4C7MK?=
 =?us-ascii?Q?zZsQkEvQ9x26asXRxJFbQgrbvH7RGoGUA4TcGbYoooI625G+a095GnApCD1d?=
 =?us-ascii?Q?4xdDxvk0UeRx7zFmE+gLZreg3/Tfuum6yy/nxJ+w+N9pUFFW+93MmTfLz0UU?=
 =?us-ascii?Q?z6ZPPN+a/4/OIrZQHQI5W9E2HnwPzh98Zx2sBpndQr6oEsLeZGLAz/XdBph9?=
 =?us-ascii?Q?e3gDzJRDGzMqMWvzlK3E2gkMEOFf/ASLgAeElyrLwJ5o9V5Ovm0eYUt6vAfb?=
 =?us-ascii?Q?oDa95SmZBW7Kd+MWYgTodcWglGaYNpDKy+tRZui/IUoSmn3bIa0l/u6Mekk+?=
 =?us-ascii?Q?7joL1Pas+x/2lj02smGm22edImMzSQd9rUeiLt6m8YSz8JHu8goVWTULeLvt?=
 =?us-ascii?Q?9oPtEH1b22OjlqQIxCQveOANgsfuwFC00IugHQq/IhnqM1mNSPcMBwFF+qP3?=
 =?us-ascii?Q?pbvbt6asUwt0WrecrdhjZ/VTUvaBP9EJKFfJuVEZ7NY4oao9rYzICplEwPeW?=
 =?us-ascii?Q?oc0sNaPZ6icojTHpbbvby0s+dYkih/l4WeGmhPGNQ26EaKdQA6UJaMEkPUhv?=
 =?us-ascii?Q?x7kAe7l8pO9jB56lI+of+Z6D+H8UxoAm36kW5sUnlIlNk5nweMsbhkBE2Ar9?=
 =?us-ascii?Q?ZkMaD8Eo0/n5jUHbE/ev2pCj2QtRnTUjynX2WD/+GYto6FGUc03+oeHHcSIc?=
 =?us-ascii?Q?52xgBJyqfUc3A8wIzeavmaMi0vlP9gXm4wkh4iqcRp7Z+ThWcrIDnv8FrMfR?=
 =?us-ascii?Q?TF3wV4wRep2LAfhfDx7av34myOgNY09rCtKbHjPvjj55men9YTziQ8u2e0lV?=
 =?us-ascii?Q?x2jJKcNZhjLoijwJkbn++N/8sEv3s7mX/4xGjjQgTAiy5YL+1nL1Z2rVPQ9H?=
 =?us-ascii?Q?xtFLQ6pXAzsKWgMsKslmHbHJ3+3YZmjQKVHD9x3YI/2Nb2b7MedYDV2OZf6v?=
 =?us-ascii?Q?aI+MKjvBFWVM435BRiB9uZjUZ44FdEa9wwxwBeoZC+ObgrjfqTLrXoIN9TTn?=
 =?us-ascii?Q?dXF1wImBAIH3EUtj7vJzIsz4tprVvs9GGt4g7QzNctDGJdXg2S1gKjLv5HMR?=
 =?us-ascii?Q?b0D0Sc7WSz0jdmRDyKCZOeVmR0w/AqA1viPG0/+0kkF5QTd0BNgh4WjgF5Dg?=
 =?us-ascii?Q?w08Tz0LbhM6NmB2cr2tHUySfHeGLUrvaK7dpyve5awIg0ntgJkQefrwrDYBK?=
 =?us-ascii?Q?yK7uiBcnswUVBm5NRgrXdZUJWSt9269udlcHLHPnKb8FC+9sltp7Fy4UcJCp?=
 =?us-ascii?Q?PRVRsyjjzV5WDynGOcA9LwQ4UT+usijzKdHTi5JLQjJIV4Oh5Ep/78UzWQLJ?=
 =?us-ascii?Q?MEdkFdpt3ML3XNn5gIc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wj/Mo7naP2MgbnQZjLzvmVoq623BMhY4eijtd14pT+ZbTFKjrJBhAp4VDPu4?=
 =?us-ascii?Q?TyX7gVOQECmetONZT9PG6PPbx5KBV/fO66X32lhJn6rCzn11Kibtlt1xqKLl?=
 =?us-ascii?Q?tYNrGFmmmfbS59QJs5rb5uA0e7wKPM2U54GRNroVuQ/PGnMZwGqGy3hVHafp?=
 =?us-ascii?Q?WvjhAHuw2zj6vVVIB5FF/J1+jVCZEKTyT/3uo7ItYOJlcMHx3SRTCPRLZxOu?=
 =?us-ascii?Q?0lP9o/dPw/9/TnoOmyq8S9wZ+aexQ4D0PZkkaSEcuTk5wMCyBOH4M22E1P8W?=
 =?us-ascii?Q?oOyO/sRCAIH0vPU8uiFWJxSUCmT3pUwUo3tjPsgK4urOTmFtgbrSLP/2htR/?=
 =?us-ascii?Q?UrVMZkUnMm7Pv5NsnIM9ZmYfrhHpHCKxGart8/RwDKaqJCNthAqxrYlB+QHy?=
 =?us-ascii?Q?9nQGiCVlmz9PmpISMhtURJmtKtfR/hQiBf09wYDI3WfnVY01BktksJ2ra53N?=
 =?us-ascii?Q?EBAOogcOnyE4wHIR6WF5dBBxKxmI0cBHcNmjJaY0HRsivBFkwPT/f1ksxqDs?=
 =?us-ascii?Q?wuY/UkJnhciWDDsfyOgfdRR53nfVVpjOsPb/ECX0vUytfuy/YravHQFCt/sI?=
 =?us-ascii?Q?Bfoak01gIWn867y9135fAD6zXmmX6pmayFbWApPikmbZdK+vC5/NLd30Avsr?=
 =?us-ascii?Q?7mf6WqNIao6dyU6kYWvTQuA6hwXndNB3niSyjO8iPP5AQJdXApjjUlNVg/qV?=
 =?us-ascii?Q?RaNdW69XBRNa4RzOIU7AgsCCcsMjitagSpBUDd7lNyIvw20KCDYBRHz1UCLf?=
 =?us-ascii?Q?gBqiIx1PAtV1gwN0BYEo9hZ9owms/uYzbr/z4TkyB0PE9KiKAt6virD8ZQbu?=
 =?us-ascii?Q?P82cmmx2YIKBzciJqoB7+j+JEdbrkpDYyHBbnw081876T677XQZJq5qhsOl1?=
 =?us-ascii?Q?Ved8p0J2HpsD2ouHUbOm/CbaIkZyOGA/zJbSBWQs4fYUG01GllNpT7IC/QH/?=
 =?us-ascii?Q?Ml/mqV7SddQKIrqHUjtqHzysWCV4XNUga9kC8Dgwzj6c8ii4xqDw9N0xJhCp?=
 =?us-ascii?Q?cRnz8f6mzTJTEMSamBdF6/qac+SlBnsph2Nn1AlD8/+bYFhKDijJeM4dryyn?=
 =?us-ascii?Q?RGWcbby8WNlSrbzfSggmCuk/+Q5Y8OPiTKu6+1+AS2N54M4fzmBo+pL7roVe?=
 =?us-ascii?Q?9S7EYCusHEJAIqL2GSZd0oQjasy4Zm7UFUTsopFYGMFS1V0N8e9VXYlwFgU1?=
 =?us-ascii?Q?q723pECyF9Uoypcu3KHA7+ZU5h8tKw6RTGyNnABEpVhIjKWqP1IDknm/KU93?=
 =?us-ascii?Q?AvfUtaYtvAGCinsl7tl1FDd68Dl/LriGcAIs3Sf5EpHVrz4l6KDwecW6tgg4?=
 =?us-ascii?Q?sCBWCzKv7o0w2I2z9JBoE5JhcbSZRSLJJFfNWPyXmP3hiCRt5SiVKxEsLYah?=
 =?us-ascii?Q?7oMdrHpotjTfQs9uwYg65TdZFVo69jR+O3isqgkrAoFUNXoH8hQtKrURYEq4?=
 =?us-ascii?Q?wBGVKhOqOIfxGJJJ0J1Z5BP5y9hO5ZglO/azGyTR7yBpdP3Ncv4owbAv8Ysa?=
 =?us-ascii?Q?klMW2Dqn9sUelgm1B/Fxf80pNZ5kVp7xoLgbVtdtV1+JmAjAEdjHSb6fCAwz?=
 =?us-ascii?Q?OOOrj+tmjGIrOAn32DQGfR97ZKCf93Mqwrco6tEc1y2qyVWgxF6e29Ko+Foj?=
 =?us-ascii?Q?X6AsK6+AaIn340HarHmx4yD1bKOEldITphToIUee9HiGKASXnC5PMW0/ZaAQ?=
 =?us-ascii?Q?Oqspy0k2IrZMqufH9Y4l7JUD9GbzYdF9bOKxaT66NW9ccOzGHCry/8GwyM/e?=
 =?us-ascii?Q?zBm3eELXag=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e18247c7-feeb-474a-11be-08de73b259b1
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 14:38:18.2236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y0qT3ARe28r1BffnKMAMQSry74nzERpyP+K2poBKAQQJbdFHbFH9yBdBFSOp0xSy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF28614436A

On Fri, Feb 20, 2026 at 10:49:09AM -0800, Nicolin Chen wrote:
> On Fri, Feb 20, 2026 at 08:50:44AM -0400, Jason Gunthorpe wrote:
> > On Thu, Feb 19, 2026 at 08:52:56PM -0800, Nicolin Chen wrote:
> > The next suggestion is to park the device in a real DMA domain with an
> > actual page table and DMA API hooked up. Now interrupts will work and
> > the domain is empty so there is no translation. The issue here is the
> > domain doesn't block ATS. We could fix this with some "disable ATS"
> > domain flag.
> > 
> > In either case when the driver is bound and requests that the DMA API
> > start working if the user requested IDENTITY then it has to be
> > switched away from the parked domain to IDENTITY.
> 
> Thanks for elaborating. This seems very orthogonal to the issue
> that driver_managed_dma skips iommu_device_use_default_domain().
> (And I see you discussion with Robin.)
> 
> Regarding the empty-DMA domain, I have an idea of accommodating
> ARM cases with an IOMMU_DOMAIN_MSI_ONLY, which is essentially a
> paging domain that only allows IOMMU_COOKIE_DMA_MSI but blocks
> everything else.

Yeah, maybe, but also we probably don't need such stringent checks
since no driver will be bound while this domain is setup, so the basic
DMA domain is fine too.

> > A final thought would be to change around the driver managed DMA
> > mechanism a bit to allow drivers to indicate they use IRQs but not
> > DMA, then the bind step could switch from a BLOCKED domain to an empty
> > DMA API domain to allow MSI to work.
> 
> Yes, "driver_managed_dma" is so unclear in pcieport case, since
> its driver doesn't really manage DMA...

It should be taken to mean "this device never does DMA when attached
to this driver"
 
> A separate flag could be clear. And the IOMMU layer might do an
> AND operation between driver_uses_msi(?) flag and another IOMMU
> device-level flag msi_behind_iommu?

Perhaps the bool can become an enum:
  NORMAL DMA API
  MANUAL DOMAIN MANAGEMENT
  NO DMA MSI ONLY

Then the latter can switch to a DMA domain out of blocked on driver
binding, and we'd teach VFIO to refuse multi-device groups with MSI
ONLY members on ARM because it doesn't work :\

Jason

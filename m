Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010024.outbound.protection.outlook.com [40.93.198.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F6C342177;
	Wed, 21 Jan 2026 13:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769000602; cv=fail; b=PAjSms7tRZFsCYhRzzE4N1Q8VuYeWgkenQD+QQyB6ysVzivO4uQET7Wq0fgtVXLs+9fY0amHZyyOwuYOYyVRnOpr7VD/xGYvKNt1CqTzYo4TTWT1nAE98/yH7JrGsh0nuY4rVX/DxoC3EtmEMTfWqu8fL938bH366pYoQwqwlcg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769000602; c=relaxed/simple;
	bh=sQckp2PK22gVBYYSpB4Yg382XmElTxYRk7r5ndU+ETU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZCVa0FniMrtIRc50u6NEPuK+7BmQMArbndj91emn2G9DppklSaQNAI7EDp0lXTlf5fE54lkah/uZHreQQ4MNiWf1f9hJ7L+Lj6rXoPxhow1qHsJUs2S7z4cAtosNBpT2sHpx7katsP95FDsNbHdd+h38L2YcMtGtHmtZNgpW85I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MXBwrqeL; arc=fail smtp.client-ip=40.93.198.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MXBwrqeL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oyALL3L4vBrWqOJX5c5qNqff3UwFPwuITDj4DwaZiQqRB/Hdy9AMpG21RC/ln3POfCwMdHpN90bsLK/uTy54dQQd5KvWJ6Ty45a2WDhRFoCL9sVH+CQ/j38oMpobOK9rWFFZb0odJsgciOvWTaCtvK0tcbQ/iv1ybnjTVuqAALUb1ZrUNHilNk+sT47rMHRv1oPquPPZFlIkOEOaQQVv2cEgb9sb/ojAzBtrQbJUb/hmrlVpoCd52VA6OqOJ++z+Ftw/ES4XNVbBKSpQCl5YhwSdWq/9WF6VLf5M8O3aV185QWSU2X1SC1uZa5n8dTeL0Pvpemtp3MfmSclOKCclxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZuFCnTQyBaTDQSaTYaas2DCwg540pBADxzfrApZwFso=;
 b=gJdJHwua7qX10Hm2L9xuC/pVUyt7IEUqN1Cu9wrDEyN2ppxNFiUO5Nc5thEIQ8ppcrJ+kDjsYx4UR8VacSd/QRt4Yzks13gnq4iMzPnASPm2+rP3aWVW6/iWnnIDMvbzCGN99B1OP+Lk0dCO4mH17nPkr7x5JK03XN/gZ0VdJd/7jEtWoPuEth2Vd483KeAMSSvg2XNrkGlv/06Wicsch0PG3nCnTAn85/ZClyyXt4vXaUJUsH/lVBRNBfu//9n0OSuHmDeUCyP/B/oh+aIJkg2LyDRJtgC5mTxlcrGOWWGTI+aWWxKcoitm4IVoDlGXywhSy0WMGfLlSGx118mI7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZuFCnTQyBaTDQSaTYaas2DCwg540pBADxzfrApZwFso=;
 b=MXBwrqeLUjmJPC5m3JOq4fvNfkbLZRltpnsmkINyWtMiLeIAzQTz/Cj0lmNbkcmPi66lOQoieV+SR5UUVQINwZpqqM2y2fD8qHAJ4lw1/OiQ8thFMzJFnZnMmzhf4k3y1RPi5IbGIFAHy+EmTJvl32PpCjS5sNtS9ospaCtLE/4o2cDYoRBpPYY1GFnUGJs6sKWqCWZe5oNsLeWbh5lRtgRHtx0p22v2I3Uf27pYrnW0b7no6uXLxPhE+hs7htsZ4a09TFneAJJgAnX3r/BTkTyhUPmojkObbLKVDLFBy442gF7EOmR/TUSbkMwRJ5EeXJFq50tk3gWAknTKcpnrNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SA1PR12MB6679.namprd12.prod.outlook.com (2603:10b6:806:252::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Wed, 21 Jan
 2026 13:03:16 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9542.008; Wed, 21 Jan 2026
 13:03:16 +0000
Date: Wed, 21 Jan 2026 09:03:15 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"Williams, Dan J" <dan.j.williams@intel.com>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"praan@google.com" <praan@google.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"miko.lenczewski@arm.com" <miko.lenczewski@arm.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH RFCv1 1/3] PCI: Allow ATS to be always on for CXL.cache
 capable devices
Message-ID: <20260121130315.GE1134360@nvidia.com>
References: <cover.1768624180.git.nicolinc@nvidia.com>
 <d1768bb6384050a23769f20ca28216f520f77e26.1768624181.git.nicolinc@nvidia.com>
 <BL1PR11MB5271F0BDC68C2D7F172122E98C96A@BL1PR11MB5271.namprd11.prod.outlook.com>
 <20260121100307.00004e60@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121100307.00004e60@huawei.com>
X-ClientProxiedBy: MN0PR04CA0020.namprd04.prod.outlook.com
 (2603:10b6:208:52d::19) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SA1PR12MB6679:EE_
X-MS-Office365-Filtering-Correlation-Id: 72a57c4b-7f62-4183-0c64-08de58ed7116
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?a+ZvPgh+o+e5A3+xu9EUV++0ssi9PQOG5VTQLipnKlBFMIP0qSSTr+SDqp6L?=
 =?us-ascii?Q?KKRYzVhnIMVyVJzVyqhjJrnpzR7LCtXWpsjoHsHNaf4go4fo374aEviWyZeD?=
 =?us-ascii?Q?3DK/SH0UARgKo4VeHtjSd/Ei+bnxTfVs+WlJMWlV3L8c1mi/XZZMKLNdHsmW?=
 =?us-ascii?Q?EsSt6+BP+bUxz+YcOKkly8weyHzVd95wBJN+S94FfQaGJLwMgIRiPncW3/KX?=
 =?us-ascii?Q?tuKWcb9xYRbkumWYCB7mlDUlHeDPdZKxZtimm4wA4vPFDCAuztM8tcYd+mj1?=
 =?us-ascii?Q?XaAcsBwHU//VWcvLvVjT3zX7XWy8dUCvzuXk1s6dHf4lkQgElUzfsKM/x87X?=
 =?us-ascii?Q?O1Xm4BHf16wYkStHHD3ng41ExCArDg7t7H69omaKuNGe5hlVN1bUm26dX7yE?=
 =?us-ascii?Q?QhLMcUCxoJM6ODTpP+qX4mHoKrKFIchG/o8JURPjfk+Hup0BaVQMPtXG+Aua?=
 =?us-ascii?Q?K9jT/5i7mu2Hj95D7ctUllJraEH0m5cDVkB/1nr+obvJ0gUN7cfLGLKOVOij?=
 =?us-ascii?Q?uxYzeHsfgNIYaClckpt7ALnt78/BNmYHcBkrrfDBA4Nwt/3gFju5UFgVraFW?=
 =?us-ascii?Q?nGBeSFNd9EXgFRDtmbjwiVJyhgSlafYEV8BZ0ROP+QK5nt1cPdWGsgDdV7qv?=
 =?us-ascii?Q?E4VUmXeFDf4aqSJ9vQBhmtcoBM6nL3qJqvZoAkWqAwuw8hBiMQsbxQKPBES+?=
 =?us-ascii?Q?f4gyXJIpQn/zhR4gVMqjHwmIDu3RXwHEQkrHm4GpLHYV8+nJjecmdK4RzD4z?=
 =?us-ascii?Q?UeKEcCno+W+ZBvE1JKPHz7s4UugsoYX9VvCnrIm4Suz8eSoLrab0k+R86TlM?=
 =?us-ascii?Q?16VjkCBY9vpRyNytn6jbsMioxQjUjNUDVeNeoVHyqtWy+r9LZ5QqQu4ZAVmh?=
 =?us-ascii?Q?lH3br0PSDYFz864Y+i+jVYNIaBaX2RrFmx17VDvNPq2sX+YMUYVksUPUMIRO?=
 =?us-ascii?Q?s0DuGE64wqGmniypXPzGdMeFWdCiYKUQeWc1ho8ahHrGuVOmDmCkR0jd7KPx?=
 =?us-ascii?Q?FKetqgQ8TqN6u8aAHQs94ltaBF1gJQZz/kwqc1c5C7BQML//xq8xEzsCFmql?=
 =?us-ascii?Q?JK6/WckrQxDNMRoq17WH2ksljh5OXm7U6kb0YBQy74uP6NcW3gY24LjFeW8s?=
 =?us-ascii?Q?9Zk6oM+LLzDToL+Jr9vZUJh7kcT29P/c0jBQ67LyVMvdHJF63v24a2DTExTW?=
 =?us-ascii?Q?c4J9bxcnbcT4f9tmzu4kJsSxGCS4xyIxNaDdx2Ddy+UdnnweaUhEtvc2cvgl?=
 =?us-ascii?Q?ITAAuWdnY5Aj77p64KqS5/AgNDFQCkWg5xoHLkqeqTgImeNP0mvlIlObr7bn?=
 =?us-ascii?Q?IwE6ExDAM78nbcM1luiHgflq/6DJjvthrTew8LuNYxEKKyHZCuIcEoWJuAIq?=
 =?us-ascii?Q?HLj6iEB6Xqthg8XIYHak3PIBhbKX9XNJU6dRfmliZwcMOUqiBLkI8vuEaoXn?=
 =?us-ascii?Q?Cptj2ffuJ/Wjb5JgwD3YhORMlndKhXwTNMaX+5U8nZh6jve43p4wabFCo9nr?=
 =?us-ascii?Q?v+uwccOJLX5BvXB0Dpr7iAvbQSwJGhUF0/tpJyyOHWW5GCyrANobGNjWAyRk?=
 =?us-ascii?Q?3fdGxEebAzj03nTY1yM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mb9xmtsogK+QMf+wXOkchEnKvzCaef+kpd5WaQdU2RMzFhv0oDQkPWQrtm06?=
 =?us-ascii?Q?v6Fut/zHet5FuD1/mcxldxuFlsJENK3G4Ef11B404rN8Vm89zuOrEafUPwM5?=
 =?us-ascii?Q?jF1n5RNX+4gRNLPJgszachaOSpW6SrBicD79W2SsORd7IG/6qt+dZnSzAem7?=
 =?us-ascii?Q?M737gW4hZQ0WxXWxmLYPF5zlTgnRS7Vo2rtnB89Sf9dyglWtnftvPtI3EUuu?=
 =?us-ascii?Q?hRAgqHShhuqYiqspuVEto4Z4AuSe4YgCHZ7QvD2pEROlmgxjgzulcC97Asdt?=
 =?us-ascii?Q?ha9DZzIVL5D0VZoq42VsNsBcnIy5nPchQs36xfYPTY7o+nDBQjQDxrAY0QPO?=
 =?us-ascii?Q?ZRanxeOh4RjjyUD9lqF9KkYrROrh5bmwBOexAl8PRZlKYPOEnU7weUK94pgh?=
 =?us-ascii?Q?hJVSLbifNh+wr6JC2c3ZuEHYWdsFt5LiRTCKeio9d70epb+pJhSG4lIRXfRY?=
 =?us-ascii?Q?c1SWytsMYB4b4avHVy8cCtkZ43ZEJNX3qcYt693qtPKr+f9UbKSVQZ3JD1Az?=
 =?us-ascii?Q?t7uaUsGj910/ZcETWdlJqaBqdkwHiXNh4tyeHtfgMA+ei2tukpDZMzRS/Eqe?=
 =?us-ascii?Q?6itYm1wJ2pGopqLBsX+j28X4js6drTBW8JO+HKCkUocW6ONKREkMUGfXjjM/?=
 =?us-ascii?Q?4Jx8PHw/CIyYs/PA2eK5EuoPo2xq72y3JHR5N8ijUq6dzSztw114KYdGTsJa?=
 =?us-ascii?Q?ziKiGmegwtX5trhmlSQ5F2PjDCVkfQRcR6WmqWS8C4Fp+UtoGutk4p4XIJO8?=
 =?us-ascii?Q?qHZmwkqYpkaqI0BzqWCtk0X5cm3vtauh/kRg2XZy+Xb6MFsa15he3/9NFr5c?=
 =?us-ascii?Q?Dnr97DQxT6PAJ59Jzs+yz/lVkPnDEiin621RF8WKyqBH/ISUGeD3qDZLjMOx?=
 =?us-ascii?Q?qSMu32jzOHUizNIfSiq0moxa/b8Th+fmcK74tbwK2+5wo5B56UEaNvEF/BZ/?=
 =?us-ascii?Q?t1cJD8GJj4/nTjtMCZM9RBgfYJ43psw6RWltlF7J/N+LAyzkZ9URCtfmUc6w?=
 =?us-ascii?Q?ZbCmcbjMYZxSOgKkKoR5rFqQ9t9tbGS2+JSLDq+m+QkMiDn/Ht0nGngPKCUR?=
 =?us-ascii?Q?tBrK3PkHWIFABSyPjq5QWda21hbMD9VW9gdI9hK/W11IsrUn+XHpcrppELji?=
 =?us-ascii?Q?0jFFXSIesNOxpiUs4JldGU6lg09CTgrr0FJt8YTGpL4qlYzaIPnLxNOhhuUb?=
 =?us-ascii?Q?i+xUleO40G+1qpJdb4+huWakaFVfCKdzBgtB8p/BLOFRfTZ/HUyP4Glw3NWt?=
 =?us-ascii?Q?4igv9JhMTsG2W3dIlH/1KTCUVG8aXU3s6NBMFG03glfTQ2dDJ/68ekRSmn0h?=
 =?us-ascii?Q?TFEl1vMckCTED7TTSuxtOUh4h1sNpuc51yOR33ZiZkA2eIZb2ufYAdLGX26D?=
 =?us-ascii?Q?wo3Jc5h1EFiOECQn4YcrBs4kMvVBZnQnq5u7ZP4GocQeYnCEF8280yIYCzS3?=
 =?us-ascii?Q?BbOuf+9BSn6l+9jBatxZZpy23qM3RZeFJ0MXYlrs5AU4biCEThQ4XrmzIhXl?=
 =?us-ascii?Q?qDDl3Sc8O3qU4zfsFmHr3lxuWMAlI6MyqcySwVqKTdtF2+tW4/CawuWh8uww?=
 =?us-ascii?Q?EHrxzTAziwQI2Bkh3EBie5xCBqzxTWh3qYpGhxZ6b//Qy1cml82UQ+6Xab+T?=
 =?us-ascii?Q?WrOdac2EkrlAsMCyTQTOQxLR1J6J5L1PPZfD+0jtuamj19eIDyMHU4XkFzQO?=
 =?us-ascii?Q?2lLt6Vq3ptrlbVN+Uu6rCPtAJGUWqah3vtsmEVxOYZKc6lVS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72a57c4b-7f62-4183-0c64-08de58ed7116
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 13:03:16.5274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aaP9REZHjOdwOlg1Tmx5FyLFI8pTV4FxiN0LCJHb+V3mEN8CazpvyWGoWO970PFQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6679

On Wed, Jan 21, 2026 at 10:03:07AM +0000, Jonathan Cameron wrote:
> On Wed, 21 Jan 2026 08:01:36 +0000
> "Tian, Kevin" <kevin.tian@intel.com> wrote:
> 
> > +Dan. I recalled an offline discussion in which he raised concern on
> > having the kernel blindly enable ATS for cxl.cache device instead of
> > creating a knob for admin to configure from userspace (in case
> > security is viewed more important than functionality, upon allowing
> > DMA to read data out of CPU caches)...
> > 
> 
> +CC Linux-cxl

A cxl.cache device supporting ATS will automatically enable ATS today
if the kernel option to enable translation is set.

Even if the device is marked untrusted by the PCI layer (eg an
external port).

Yes this is effectively a security issue, but it is not really a CXL
specific problem.

We might perfer to not enable ATS for untrusted devices and then fail to
load drivers for "ats always on" cases.

Or maybe we can enable one of the ATS security features someday,
though I wonder if those work for CXL..

Jason

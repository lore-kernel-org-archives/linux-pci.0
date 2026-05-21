Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012044.outbound.protection.outlook.com [52.101.48.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0013DA5AA;
	Thu, 21 May 2026 13:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779369180; cv=fail; b=hzpsGZSfB+ZnzGm0XVhOsdzpZV2nFM8uidZytPh4Ya60k3lSZYNt1ZbsdGy5/WvJ2TAMhtg3xbzN5nH5Kn5dWhU8niuS1577V+z1qtQvg8ugauklMcXmbfuaMoDiIGI4PUbWks+F6WCK+yAASSde/HmwwlJo1m/G8HPAEz9TeRQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779369180; c=relaxed/simple;
	bh=5pgx0NX5y+TxxDvVeLe50ds6DIg2I05tb3wQo4Axcq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Vw8Oh+OiDU+EANx293VnMN+qgPrwtztcmU9Q/1aBJNWtLM3Nfbo7RUAVDhJI9HYuLG/ehDVi8560JEzMry0AXwk5jgnplysGqE5MeUmHlrDixAYeDdkRaBouqE2s5+APsoRXWv801zhICM2bkgzVpwZfmuWhXPKIXLoQuzYcweo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HPWgrqwu; arc=fail smtp.client-ip=52.101.48.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HPWgrqwu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gM+DvkPKeQAmFA+uARCBwWTIHGBUahnzkKwTvbTTS8qRP7LylU+ysZ2T5rSOs8+pCBCBLHTZahfqClp4IJspXCHXxbSX1o5haKlX2lEJUWx2ST/nm8v4EPfkWw8KEZ0QRamBiaxblqCLoDgaScnzOvBRKn0L3cIicwsv6eAiD7+ygPoEEvxuKuI2LwcCe9rDFh3tHH5VsQJDw3JBE4KUzsW5P8DJss9cPUbJMJitMbJlTZunvLWad09mru0fXpOUOuVLs1MYUPUQ7JOtfYkQFrd7Ryu6iHbiDI//PaREUClVFuMqyCtIUQPEmB9VNnZKE61zbMV5lE8vEAL3PRl6MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9AWPNTEyx6b99FtUG7Kp0z+zpui/ej/y72NDhWEXzJ4=;
 b=DZadaSiin3D+LJkFml2GoVnrHCrpoL+GewKw4LAymxBhYd3lG4AOH1Sqo0eyYGjhNxwrYjMMo/Fo53NhRGFUdFupHropISBBE/qAWSmr4Zbt/m8w4PFxv6deAq7X9e3g0cYGqt1eUnWl9aArXcTNZSTOd771h1559Qy5JZ9gE3r5Ee90atAG0KA69EQmgDbB2erm5fYIuEijdBnDiE2Yp4LabUokr4uXWVS46MQvL2SMcYU+vYJjaV+ZjA9XzzssMMzQ3TxfemM5LBVYPvM/X/8eLw0pOUvAwcSIKmrEBgayCbcTJbipBmqCwZonPWD/xT7tQ+WVAMDcDVAwMrE93Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9AWPNTEyx6b99FtUG7Kp0z+zpui/ej/y72NDhWEXzJ4=;
 b=HPWgrqwuZKhAQDS6Uz67muFFley5rVgoIcTTnjo9YNgTdsSmFq7Kfqnb7baJU0J502RWFeshHneI0+8igYe3umLLnqF5Wbf7dl55LYRvbSFLWzOxYTM3uDCvXIXrosy49Zj8bCQHc0LKc1hHj2Tnk2JMMjAuu/k5vZPyoJIhr5/y69CBV+PIRG1NUW5Czi62P26WEQ+GUaBOtran7jnGan2D2ddZAF1iFmd0b3jAcPagiRwiHY5UJxJ2IbO1wW6zgctzb2+78vxOVNeeO+9GwUg3IObtH5hVMHYaPQAa52qeW7iXvL1SilPdr1CslJOjlOEi1bxXPULcFonLA8u6Tg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MN0PR12MB6197.namprd12.prod.outlook.com (2603:10b6:208:3c6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.19; Thu, 21 May
 2026 13:12:50 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.21.0048.013; Thu, 21 May 2026
 13:12:50 +0000
Date: Thu, 21 May 2026 10:12:48 -0300
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
Message-ID: <20260521131248.GF3602937@nvidia.com>
References: <20260519120737.GQ787748@nvidia.com>
 <agysAyreCY4huf0I@Asurada-Nvidia>
 <20260519191626.GJ3602937@nvidia.com>
 <agzkldmlG1cuDkj4@Asurada-Nvidia>
 <20260519230204.GM3602937@nvidia.com>
 <agz+kL2S8kcgHywG@Asurada-Nvidia>
 <20260520003023.GR3602937@nvidia.com>
 <ag1guf1fHg4fE7Lw@Asurada-Nvidia>
 <20260520175123.GZ3602937@nvidia.com>
 <ag35umFgzIRGZAHA@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ag35umFgzIRGZAHA@Asurada-Nvidia>
X-ClientProxiedBy: YT1PR01CA0110.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::19) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MN0PR12MB6197:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b6058cf-c015-4ce7-a91d-08deb73aa8c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|18002099003|22082099003|56012099003|4143699003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	rn4A9OmIW1XsiBxxAzVJbx6VFMxhxNoLJ4M13HcgfqhQ+T4RZPSeBGTkoXkeTn/hNoII01zoIEW/p+Wbirr2oTbasqCuDpySXjPPAhOT8uZnDtKu+CksrcBmnVoRb523aGNmTp+zItJICUGaop8Ov0kA5mkx2VRQMaZJSsLGvzibMz6q42VFtMymIxHJnKdbtb8Vz8dyv8hzKx9yedzS0lcbvJnGoTzAXh6NrfLzYmBQPsIyJ4cAau/SR0u/KQRd6go14JhoHrmXBCg1OSfmn/I+5gP+hq46ItzRDp9UaAWvBwP/Ti8EokDzIUyVDYnDTGpuir9EP15rx4TeMcFfY8ScgG6Li4aTdbAcmZSRcnLi6jzv5+KXL/kAE5Vgmd05LnzzeTTv47JAMEyro1HjI1qSlel4HagWvNNmIh/ZAmN78SBv0Au5xGGY/FlmdtuJtZAvjQ0M9VSTv90MbDB4/wtXNj8fC1OZsamEqfkRVBiCe1n4U2LkGmJJXu/uLpT+VoCETOadfD/A5Hg/wQC7EYlUrMsa0bu/XTFVJ7yZ02bho+ikSdTnoFgnY6Udl+P37v4bq9zvrTTZM/fMuuLVTu7oz84wBMJE1hQcAuxuos9NwrmbMvDt/KKI3BvyW6k0W3FH477oepXg5LzdcKr1uZPjeCsaxTYyZ6QcT/F/8FprE0kwZByevqt81D7hs74b
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(18002099003)(22082099003)(56012099003)(4143699003)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QnKEZTupe4M9SwbM9NuyW9Np/24lkDZH1tsq4MTEcvj1ICJTTNi2YCaEvwVm?=
 =?us-ascii?Q?jI/ZinKBL/wSLgY16X8tMXYCVz8uTPhYuGNDWMzdkwVTwSKMbvZdB1BHdsl9?=
 =?us-ascii?Q?NwDGqyxCpU9XjnOrmXmtzTIVqKs4NW1cKo6vDrCKZB1jd3oifh211lQmMIot?=
 =?us-ascii?Q?41X2EJO1JkfqiJYclUN5j+bkYlxGIKZYMMjo0i66n44NkU6cyYdVWjwUh44a?=
 =?us-ascii?Q?rDn+uHDGFyqENeG/iFPCBOAtS+OdABe4RXLT8oesDtVhirSM/6VMdkSB5Xsd?=
 =?us-ascii?Q?Mgo9xT2R13UBl3fMoo/cxixZWtsBFZIG4mAMe58xvoUQg+FjhBpR3hoPr27a?=
 =?us-ascii?Q?p/UQDnPjiEmXSmeg6Q9235GGmZ54GmpxmO/2n1S4olidvA8uvEKtby/YYr4e?=
 =?us-ascii?Q?xygW8mX5ewbP534TbTQMpa4EyVXi/Ah0/54alIr3bU5vDTnslbiPOeWMr+7R?=
 =?us-ascii?Q?N2asc2bIleWhlg3fxNOOPXsq5CfvDqC/hCbn5xz7FRQmIzMijZ93dCnVtMyL?=
 =?us-ascii?Q?p5iYzlcATXRwVfIvscvHCRa7BFz3Y7kMaksnhR6jyvX0QlvZdEjDJhaC1IqH?=
 =?us-ascii?Q?i6o3x4uYHQeqcQjlfaUHW813+2OTXwLadgzAPlDXZ8Sln0Jr8stI/jR2TgXM?=
 =?us-ascii?Q?YaQb9XF0MpnX9TUE7AQCpZkOucm5YuJujtmslhIhj4AXXaKpBHQ1DC5E3rdm?=
 =?us-ascii?Q?GUh0MrjWGek49GgAiD1Vr2T0CcfDzhiaYIfRHBGTEvNSyXLve+FzhfFGVxwz?=
 =?us-ascii?Q?Kl2xALljmKop9o2O2WeFE7XfbYGjlj4AO/UXH8qsfGf4Vq1dFIX5e/f/4jF5?=
 =?us-ascii?Q?IzzUFiFUqvlIVLKctdK4WZlvTu4rRHpSMCeqGUJ+9xrephlTuimDG/l78+QC?=
 =?us-ascii?Q?eMbZvU2a5imFgu7rHvze61y3rnyFw9nF2X6fL1rqiy5bIPNsG2m+TIJ34WfY?=
 =?us-ascii?Q?BM53drcZQ91EO/Ko1bt4xtvIj/SEHvPU8sZkcpjccXp260WFXoeOrrI83mHn?=
 =?us-ascii?Q?x/RQEndn+zGK6cRg+ab9g8CML5bcWPct+99mGZWX++SXgL33/3PfEG/PC3vv?=
 =?us-ascii?Q?P6zr3F2q7vRRRiv3i1zjEgIMnoGSz3qTvxVmSsf6xAIMIN0+uUR9C/9djj/z?=
 =?us-ascii?Q?3IsPFJ9YhTOZ3cHH3UVk77ZEgArLnjj+93VOLJQBFdJClzPCn4H/OkFbt6ql?=
 =?us-ascii?Q?8tgLzZlFk/a5pPrpfDJugaFgvG3vBLEDyuLSKW73KmM8asvoQzCD19xk/7cu?=
 =?us-ascii?Q?CqcDyGXJv3AJjZLcIgazJL/RLHp+gYVxBr0b21TGZ/4NlbIwyAfZkDYitEez?=
 =?us-ascii?Q?dpd6aMBaG8qjDLiXOQ4I6ImvtbATuKIe4BY9b+zBaS1utwDrgrsObxXByNVT?=
 =?us-ascii?Q?7rVsvR5pTpcEtHK0REeqj6t14FDbqoYDDTbwKDOCUKk+Kw5BUYYC+FDcrjIP?=
 =?us-ascii?Q?nRsP76AvJ1a59rwG+Pd3MKG5z3Fhkozyu5MMv189IonqiVgWXjAPyKWo4aZo?=
 =?us-ascii?Q?uqe2mNQeyMldcstCDFR7vTlPNkcmy3o+7oaadS51PPNwT80Z903yLwXWSpq6?=
 =?us-ascii?Q?L1NmyjngLk3gsHjaQu/dt79fqLhK4Z0NsQX4IFEVj7EHyI5YENcL34SCs0TE?=
 =?us-ascii?Q?nDXYjx3CpN/ZMwG9CWJGWw52oaeZfwzUFKnh4RGlzUjdjMl8EWiyIbsgBmOw?=
 =?us-ascii?Q?/4s5vcuHrPkx0cB0B1eEboaJo95nlm2JRH2ikP9LMXV+xYju?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b6058cf-c015-4ce7-a91d-08deb73aa8c9
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 13:12:50.2333
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oAqAB3oZqj+8FyCQnwPNw78D9f6/Zn60bM72jaKYppLNTdhFTXKmFEGUZmlpi90I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6197

On Wed, May 20, 2026 at 11:13:14AM -0700, Nicolin Chen wrote:
> > > > We cannot eliminate parallel ATS invalidation. Two threads could be
> > > > concurrently processing the invs list. So it has handle it, the driver
> > > > is going to have to tolerate a number of redundant error events.
> > > 
> > > OK. That sounds like we still need a flag or locking so that at
> > > least pci_disable_ats() would not be called again. I will see
> > > what I can do.
> > 
> > I think we can call pci_disable_ats() as many times as we want
> 
> That triggers WARN_ON(!dev->ats_enabled) in pci_disable_ats :-(

IMHO I'd rather take that out than add a bunch of complication in the
iommu drivers..

> > Still, I'd feel better if it is was definititive and we didn't rely on
> > this. This further points that the driver has to merge multiple error
> > notifications if it gets some AERs and a new "ATC ERROR" all for the
> > same key event.
> 
> I feel some race here... Part of the complexity of this v4 is to deal
> with concurrent device reset during the async report() between IOMMU
> core and driver. Now, we add AER that could compete on the device side
> as well...

It is always going to have concurrent events, so long as the resets
sequence in an orderly way it doesn't matter if they overlap.

Most likely the driver will have locking that prevents it from pushing
concurrent resets.

Jason

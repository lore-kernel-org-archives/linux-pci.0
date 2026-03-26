Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013068.outbound.protection.outlook.com [40.93.201.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDE426A1CF
	for <linux-pci@vger.kernel.org>; Thu, 26 Mar 2026 12:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774526456; cv=fail; b=kIy9U+jcl5hUHlOrEYrs0zKFNXnXXTbkOoY54owqdRK5SSd6wy+LZ1hgyYxf6Q7gpxA0HVe1iNbXZOb+UWNbjQubaIQhUW0hPDQQA0GrjLpmEY7kyS1Sb2yDoGyjrE0eMSr0wzFpARcBDFXk/1IA6icC+rU9fKCrky6ObTk4IsI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774526456; c=relaxed/simple;
	bh=CoUiCHIj63s28OJCc5TbRq/M4C9yyygid4wiV5VEbTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kQprUKevRLoLEIGIC0WED+PSx+H9TYcTNygF0FkAEcp4VusCcZtXBgOuf1auuRFho2UyKIZynjE6lCOSCQxCp5AINWTxmsI6jFqgzST45DHTAnO3IGHB6E50BG8t/yGA0Oasn/dkWpnnIvSpxYyCuKSzhWggOTmZKsYwRuuWYqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=I3wwRJ9x; arc=fail smtp.client-ip=40.93.201.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="I3wwRJ9x"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BN7g8zZdnZ47YSYEtvK7n/fmJxsOkem3yqQvonKkFfNlasJROyNyAZXxbZiVnhw6sm8hNGb0iqXFPV9Hmfggcw+u+tAhBvLpJYlZQW7UJsTF6lwsKK4IzfXUBxh6oRbJiZez5le72AEZ8sVldsb+Z071rN/88K+KJmakJJeSwPoyLPsxdFj+n5xPjuRryWu9Il/CdjkexiTiVjwgLqO7wGr9CesT1hhPw3dXzY777Ev86TJAZi5T+0iOkMnVsh9gqELIqQ82luZRm0N3fjrSOjELUs3dTEKM2uji8jeBa7fyiUgztbNtcOAz1I3LGiHRFF7CWaRt/yukL++cZ0nTcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4o4orl00r3QM247cXe8NLQJmxvyrzMNTAdINqBv83D8=;
 b=oxSgPsfSDw4AH1ju5IY/wX2/5PHQn/mlJUp2DawhJk65D9nachB9st7K4JDohxCtuBQwzupRnAe2N7fuXlbcg7jZMPGEap1O9ACBhSh3TicZgsmbR/gkRCPec+Ww3BtqdTKikayxWSKqwO5H5kz4jb4DQ6RE5Ghmn6virvEkDNVkrE+cxThrlYVqzonYrEY/4xHxFp4GDpfJGngDKf2Y6n85VXnipm0EJuaMgrWFl0tEWHjlq3hEYhyWFJHE0e6BTisKIW++P6fjEyeQiqNi+RvPXLnG12lTXh3T6eltPANrVMBsXSazmEbckJbihJAenJ+JX/7zqhtiPi3Q2UHpcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4o4orl00r3QM247cXe8NLQJmxvyrzMNTAdINqBv83D8=;
 b=I3wwRJ9xSUL2asVRdMdBaqtY0dENvjcJJ3/HTY2ecOaF7V4c6iRLixV5ghVXdBr34iKI9sWeC6WL9UoYKkKhaluOPWd59VrgLvL5ZgPvbGeyT6rrnLVWwldlyXHJaF+dN+P701uHb8hjDXZJrbxTVAzWhPkRXC+DKNh5M1zjmiEi0Ubxw/Dyo4DCt+2e3bY6TBC+9decV7qHdgB2LkQUGjy8UzlS6pMy4MLMHlFAglkQ30sAC5yWXEWzV4F9HDfR1Nv3CpH1lKiXBHKNct0sm4YllXWhS6xVlsV4ioZQSfUxCujJ1zDVRoBketyaZeYlWEFdB78aTdTPAiLzbf4PVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH3PR12MB8851.namprd12.prod.outlook.com (2603:10b6:610:180::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.15; Thu, 26 Mar
 2026 12:00:47 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9745.019; Thu, 26 Mar 2026
 12:00:47 +0000
Date: Thu, 26 Mar 2026 09:00:46 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org, aik@amd.com, aneesh.kumar@kernel.org,
	yilun.xu@linux.intel.com, bhelgaas@google.com, alistair23@gmail.com,
	lukas@wunner.de, Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Roman Kisel <romank@linux.microsoft.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Subject: Re: [PATCH v2 03/19] device core: Introduce confidential device
 acceptance
Message-ID: <20260326120046.GG67624@nvidia.com>
References: <20260313133235.GC1586734@nvidia.com>
 <69b46bd7935d9_b2b6100b7@dwillia2-mobl4.notmuch>
 <20260313202421.GG1586734@nvidia.com>
 <69b4baab2b950_b2b610013@dwillia2-mobl4.notmuch>
 <20260323181413.GP7340@nvidia.com>
 <69c1f469f2814_51621100bc@dwillia2-mobl4.notmuch>
 <20260324123649.GY7340@nvidia.com>
 <69c360d2107ca_7ee310052@dwillia2-mobl4.notmuch>
 <20260325115607.GB67624@nvidia.com>
 <69c48b682e6fe_7ee310068@dwillia2-mobl4.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69c48b682e6fe_7ee310068@dwillia2-mobl4.notmuch>
X-ClientProxiedBy: BN1PR13CA0005.namprd13.prod.outlook.com
 (2603:10b6:408:e2::10) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH3PR12MB8851:EE_
X-MS-Office365-Filtering-Correlation-Id: b8660638-08e6-433d-8250-08de8b2f50c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	9apuHNHF1cnJoZkiclD0w/lC5q8Hvk2toxVCqel3zQSeMnBCZ3hx/o1onUZAE7NNjjVXeTDGFG/mYxXahVhxPjlpgrV4qCNOhQiXGqjhIb4SHo7xzQnXYrzIlRBuyRBnOqYeRxbQNC/9dL1JDvPFzpYXZdMgPXE3/0FZyMi0wA7eS9h5/xMn0Vj0DgzVLvd652bYslQYOD91iKuLYYt6QQ0TswF7jJvTz8VXlzI8y59cgnswhHdmcmD/Tp9y7dO2DC/wiRv47xim1GA1FOtgjouJNNenQyLxlfjcIg1KLqbpI7v0Ly8i4TxHybyYSWJQSR1Ar6ODyl8cvkZfGDdJZ4393J5HoAUHO6DDJ+WHUICdf/fRp4YW8jZ6o4n1YubnH9CIs1tPEnzz7u7zlunFgdCisF6qoJ4v6janD6tvf4BFUZhl3Kga/PrcgMpCqhVgXE3Y+TG9SdYVtarp5S21W1KHqXQFCzbkRaUIieYPeqYKZUw7bqzyavVn8L/2y6bFzLMC5/McA+MSrBpwsGkAvqFGqAGpl87bTB1YYaESFq/liN4N2GfvzDFizJQZAtVih69+i1wzsrDiiH75HobYtx4kuqSSeR0q+gYIVgXrMSRrXoxUC28SS62I0xNfcYN4H8C7IO7oaebmheDaRAHw119KeUiKM3WetCMQLLVyaZlvNIMKzCqFlbDsYfifujL3575eI0JBhD/amSD7ZWax5NDQomwmCBax7k6n7ryqyLc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6KGoo96XgNnVAI7HL5B20iEw1htu8q/vg8+MWtFioty0b7HsD8KwnL92w9fG?=
 =?us-ascii?Q?pRU11gKwJfh2AC1tBi2rgZsXQQ0HeeX1GFNVQVJcs3VmsYiCacj0fdhyXi24?=
 =?us-ascii?Q?3fjdcpWJWXoRfo6WgHzR+YZwTGPveVmpOfkO3D9uXYivC/TGf+xpckvc7BnV?=
 =?us-ascii?Q?1ia0ndhh18xLzZ0g/K3or5ogYZltT2oUf+uJh2cERSVjhvBSUMJmWkH2hFnp?=
 =?us-ascii?Q?qG88Q7MlgqB25r3/AItm+cT6/XD6lOv9asRWGJQEW4ZrG6mWXfvwEkbzLAbA?=
 =?us-ascii?Q?LjjHLj4hW0AK6zHIRY8cn7iK8WU8NsF5bbdYcZWRpRUDoekEf7WY07kjk+pu?=
 =?us-ascii?Q?459QcPaYIQqsY3sNRLQApEoe/WhY9DM3g4iK27c/TA2oIonZOQ+zoQlFkz4D?=
 =?us-ascii?Q?ppi4BvQTJ9rPm1LUTuocH+zlunXZUfkqIl0avfTQCvOfi+NkPfuyn6+GLZNn?=
 =?us-ascii?Q?/lvkLhAbF5Mmb3EAKPX0r4ggPMMX3dp1Tg8cuAb6lCo/lkIb1QkD74xJpgFU?=
 =?us-ascii?Q?jJhtddL7qn/5Z84FYcjKj1HtVGp5T8kGdByItJZLhgoTAuxW6UVITsMY1893?=
 =?us-ascii?Q?qFseRI87bsBui/kZu4VeRtVeNt2HMAFl7qkwi66RneNwDz+Tuz/eUcIlx3BN?=
 =?us-ascii?Q?y37nDS/AA8U9j3jCEbnlqcpN6KhbJ8uReX9Of7yqZLnriPLiDQDK3VhM3ECv?=
 =?us-ascii?Q?L18xsUQ+5CnUsRXb0JW0JiljJpaaB9m5KQMYGx0+I09YMVeEEm8daY8rnxXT?=
 =?us-ascii?Q?0AuOfXgB+2ywdETgg7y+hu1ooql4C6Qe8PWiv9wXCSblaXt8lfbVXBNcmLE5?=
 =?us-ascii?Q?v4uBCXrBPt7WRWtqikb1jFnEldro98HGq7OnbzI1Q5VCh0ICZSNmlVEgkp+R?=
 =?us-ascii?Q?K0B6sNNqBpmSp2BmY9GbyxgO8UvLWmEgFcd5j+l+9qCuI9hWmy/Z+IpHLvT3?=
 =?us-ascii?Q?SFJjIWNJfcMleNPkaPOWxYhoszPNE8tFCznr0rRF58/smF0vAnCCAn/zW64s?=
 =?us-ascii?Q?VN4D24X3tTo5VhVloIk1aggiOi/K0Zyo7eFzrIr7JofJ+qgczjE+RQ1KT6OH?=
 =?us-ascii?Q?2h5Q8V+i3t0URmxw5c0psKWUL8wAUFbIl/3bI2I1Nxzqcry5fRPLTh19+0ve?=
 =?us-ascii?Q?wAJYIP4x6pEjARWTrmLZV9pSsnhCvQJuEICk5QIhn87QI5jn9GiTzTc73D5Z?=
 =?us-ascii?Q?afNm7B9XuhxniAtdRIh4/lWFYB623WSJEW83TLjtyMFZW0gJVpQYPr2CCW75?=
 =?us-ascii?Q?Nlie3Q2EOj1dG2JB/MYBcCVLa69j+O8MPeZR6x4KYw1+VeD629LIb528CoNI?=
 =?us-ascii?Q?t3NJXf2Oa8TsnrjYXbzpHEHWCEv+cgH3wAG4jEG086xYQtDNKp+pZZD7RxFf?=
 =?us-ascii?Q?XISFNRy/+E4N8/9uIUXIgG4gj9l/MB79T3pOFaOpGRwgVhs+he3l/mNOsKAN?=
 =?us-ascii?Q?TvcxXgZ3vRjmI9drM2Zp683l9tDkK6LUxChu7VJIgix1IRCY0l8BOdYPrPts?=
 =?us-ascii?Q?sSJBBCO8/QXFoLBvNzZ3dJyIzCuAvGAfiHMgqfg4SnZx6VqMMtC8AmYWHinW?=
 =?us-ascii?Q?qqhJBgEjCf9U4UbLppPFgW+3kTnOfCffJKPIImco5/S1oSs35hAWmvV584na?=
 =?us-ascii?Q?5p8wdkKRMoIzK5CFp5P4YqzVAhQPKeMNim2ooaIdz8Zwa10jaP4GiaCQkoCU?=
 =?us-ascii?Q?mxnGRikvDK4sbFZoEf+xLlHebGDMb3YF11SqMip1PeTGYxnD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8660638-08e6-433d-8250-08de8b2f50c7
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 12:00:47.1654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rYHeAufll3y6dtqusc+mkT6BjlCk/rZiZprt1DviwG5PThZmIPt/sznLuIXbJ4Mf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8851

On Wed, Mar 25, 2026 at 06:27:04PM -0700, Dan Williams wrote:
> Jason Gunthorpe wrote:
> [..]
> > > Right, the potential to see in-between states concerns me because TSM
> > > uAPIs would have fully enabled the device to wreak havoc, meanwhile
> > > dev->trust is still showing the device at some lower level of trust. So
> > > I think trust modification needs to be synchronous with privileges
> > > granted/revoked.
> > 
> > If an iommu is present then the device will still be blocked even
> > though it is in RUN, I'm not sure this synchronicity is so important.
> 
> Oh, maybe we are just quibbling about where the mechanism lives. The
> "unblock DMA" step in current preliminary patches is currently behind
> the "struct pci_tsm_ops::accept()" op which also handles transitioning
> the device to RUN / T=1. It is a bus callback.
> 
> However, if the IOMMU layer is enlightened to block/unblock DMA on trust
> setting then the TDISP "unblock DMA" step can be factored out of this bus
> callback and into the IOMMU trust responder.

Yes, I would prefer this because it makes the whole IOMMU mechanism
entirely general and not tied to TDISP - which I think is sort of what
Greg is pushing on too.

> I assume this would also expect that encrypted MMIO mappings are also
> not established while trust is less than "TCB"? That would require some
> additional enabling to catch attempts to establish an encrypted mapping
> that the hardware is prepared for, but dev->trust is not, all without
> needing to modify the driver to worry about this difference. Drivers
> would just see ioremap() failure in this case.

Hmm.. I don't know if this matters. Once we decide to use the device
the MMIO should be mapped in the correct way, whatever that is.

If we decide to eventually allow a lower trust while T=1 then that
should be taken to mean the user wants all the features protecting the
communication channel but also all the IOMMU features restricting what
memory the device can access.

Remember there are two parallel things here, one is T=1 which is
designed to protect against hypervisor and physical attacks, the other
is the trust level and iommu which would be able to protect against
attacks from an attested device itself.

Even if you are in a T=1 environment you may still decide you don't
really trust the device firmware that much and would prefer to have it
more restricted.

For example, if you have a system with a NVMe drive then all the data
on the drive is probably still encrypted and has be CPU-decrypted
before it can be used. It would be reasonable to run in T=1 and attest
the drive to limit attack surface but also use the IOMMU to limit NVMe
access to only the memory used to bounce to the CPU decryption as an
additional fortification.

This is why I am tending to prefer that the kernel's view of trust
level and the physical HW capability are somewhat orthogonal
things. Even if the HW has high security the user may still prefer
that the kernel distrust.

Jason

Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011048.outbound.protection.outlook.com [52.101.52.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C2444471C;
	Tue, 11 Aug 2026 14:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786456893; cv=fail; b=XQ5dE+UGmtOSfnnaSO4idgej1W5iZFv/j/C/HKyeyrnvc/Lm6M7V8zEf06rm4rk2nPmimm/BtTNwGPd0dGg7w29JxI5rnPRc/SI1Ji3Jiu/1/CZDpW4ByBv42Z2G0eJRicuHVsMo85ZM03eSR2g4EzM6pk6BmYOWwoa2N0BMiP0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786456893; c=relaxed/simple;
	bh=maIvwXAtmk3bCroLL7s01ei/eZj+tpYOrXJbx+qwccE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bAqkEx4siNVfMWa45wcqZwycTrxjDoF75e2tyJ5ym38pAxOhZKutxQ8yub5Od/HJn6sEwN8y0UN69bZP3EDle+0MQcHawQQz5IioWCj2Ftb7IvHEZC1suFuVFgheKzXnnEndEKVIGBBKaOsWmZALk+JVi9fXEplUBJoI4AsEpkM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pDraq34v; arc=fail smtp.client-ip=52.101.52.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pDraq34v"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JRv24A6CLe2t1Po18/sanYbT8hvvmUEXBFRzQuIQP1OB9Ihe3Im8kYlT2My2I3Mt6goqvZ1KFQKU2kTe6B0J9+965tel7NGO/H4BawyBiu1E6SjdPF6yHvRk1+mlsuKSBTHtj4NHSQC3svYOuF2PCSs4MlFtMesqSfUCFMqIDyGaGZbT3BhODe5kQRqbbFpPjnr8+R/PuhAtayaimg5Fjq7gnw60dWzUOCVJVKjsXHX79pRFawMw4zMMSKWOwLt6CEJHxL/XWJcaB3ckoppaDSSBv5qAMNTBl2QUVfPorSBF6ANtauqprCoYn06rj+/j9WTQ1k9Oekhp6DsBVqPp9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nkWLxwwdYuggExPmge2MmNucevk1MI6qR6n7dII6LRA=;
 b=eLDoVG+KyY3zElzfOZlipXSAZM2JitVmDeUGlOV1ZMUhg//QyElztURPsDu3DyVfCgGc+V5YtqhyWzijHmoGVTh3eqo0HQo+pVKko/E8is2IIMls8whi2kw05xrHIpfxb+GiCriM3RWZygn3thBMQbps8YEwwPuDoJ7ZYwM+X2CtGPDsJqwO0THOo9JGHIezvgfVDQYOhD3qhogZAJqwCz+PL+4i2Yr1DPj4/CNI5aasylwhpP06hoVsp12rmEdg8860Na0wWAVOVd4U+F+lPC3lZGY+As+nr540xnDpXxiviy50IJDGfFpe6diF0ItwI9+NJZEs0Zw3iVdNLrXn2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nkWLxwwdYuggExPmge2MmNucevk1MI6qR6n7dII6LRA=;
 b=pDraq34vPOBwo4DhnY1UBBoDJnp7U6J/IVUQcOCMr04/MkPpGjwJhfbTaWEgMQB66ypivIFU7gKhC9UuBwt485YBRyVNwg6UYEUvBn9ZNtHl5jOZ8mHmDW2nf6J81g/SZbK/5kUQ81OXcvCT5atGMGOKmfMML7k+rs0F3lK/1WqDVzrBykXQ77zaMkWB2O3Ngwqlinyz8ncBwdPy04dritLrzfQK7qzBfhJRSmtbFNnflYH4IZxgGC4vNgupciR9jP5zirXci5XuOT/CYTPkt03ehlEmG6J2X2E6Vc2tR9uZciM+E7vHmYauee/KPWWSxrHN8qK/FqvTtz2yMc8X7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS7PR12MB6168.namprd12.prod.outlook.com (2603:10b6:8:97::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.25; Tue, 11 Aug 2026 14:01:24 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0315.011; Tue, 11 Aug 2026
 14:01:23 +0000
Date: Tue, 11 Aug 2026 11:01:21 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Matt Evans <matt@ozlabs.org>
Cc: Logan Gunthorpe <logang@deltatee.com>,
	Alex Williamson <alex@shazbot.org>,
	Leon Romanovsky <leon@kernel.org>, Alex Mastro <amastro@fb.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Pranjal Shrivastava <praan@google.com>,
	Mahmoud Adam <mngyadam@amazon.de>,
	David Matlack <dmatlack@google.com>,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Ankit Agrawal <ankita@nvidia.com>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Alistair Popple <apopple@nvidia.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
	kvm@vger.kernel.org, linux-pci@vger.kernel.org,
	Longfang Liu <liulongfang@huawei.com>
Subject: Re: [PATCH v5 2/9] PCI/P2PDMA: Add CONFIG_PCI_P2PDMA_CORE
Message-ID: <20260811140121.GA59938@nvidia.com>
References: <20260715174737.15287-1-matt@ozlabs.org>
 <20260715174737.15287-3-matt@ozlabs.org>
 <e90b0bd0-fb8e-4d4e-b282-609c26692e4a@ozlabs.org>
 <b30e75d8-37d6-478d-bc72-a9ed0b7e200c@deltatee.com>
 <20260805003914.GK27883@nvidia.com>
 <554c73c8-bc17-4336-8e38-f4cfe8d8b3fe@ozlabs.org>
 <20260805164052.GQ27883@nvidia.com>
 <72c83c2e-fcbb-4925-ba50-5be01af359ad@deltatee.com>
 <1ccd055c-9369-45ea-b3b2-e26c39b4f696@ozlabs.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ccd055c-9369-45ea-b3b2-e26c39b4f696@ozlabs.org>
X-ClientProxiedBy: BN0PR02CA0021.namprd02.prod.outlook.com
 (2603:10b6:408:e4::26) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS7PR12MB6168:EE_
X-MS-Office365-Filtering-Correlation-Id: b65416b9-cfd5-4889-16a1-08def7b106db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|7416014|1800799024|10067099003|4143699003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	EWlkZB3W+d7JibqaTAY4h1EgjoVn/S5JSChVVFWM9drdU8Rh4q4nJO9u49WN+EiMuHzU2fiXnPDihWqx+ISkn0vgBbK9ckIuA//VL7YgIJe2Oc4qo0EltaDKApKY2fjYEI50Wq7Vyvp5CLEYRLD+vYkypoRb2bGxFUJeWi+RWX3Q9r/QI/gn3E7QCSpDU4dXblcW0psAKoGp1H0q1TJ83n4mLKl9K8EJQAs+HudaSaxkoDjh+o+IaOpm/io3/qhRha3wSVWhvyubahmDTsq2+/koZA0N5daftE2B8h+vbPMB+7flNerfuD7mq2JMLxMSn1ZXHX2WF9mDUHelBtberVyte8eqvjH0dmT8Vr24E1isCS2QhSvy7ITyMDX6KU24y7K9NwiECkmdzY7AuHnx3W+FZCFH2qBzUUiBeEtZHx0hzIbJAuNDOnRS52O2EUnVH3QNHOobAs6gMYi0/iKDJa8ow1CifiQ0xqvfNHDb6FRX9Up9bcH3w6b3DL6Yc0UTMWWJMR3zaojfoABLNoPw9UKSjV/raL5o2G2+E+C7EzPTwdcjseV0Z+ZpOdovYV5dHgY+mDoIl/wwj38h4YzNzmJ4+jXR26fbV7jNSsBnOVcIlG3tMTgiD2k+G8wTxOrLBOMD3sGhUZNR/IhTYfrQazRNUHel93NWoRsFQ/F0rR4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(10067099003)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6uvSgHoCoTTaUwDjngNrZAh2hInzzrEVT9kIixcj4rvFA+zgMpL1y3qoCefE?=
 =?us-ascii?Q?Mch0w4TG3+NydSkwDNf9f/nCvk8ZlNfaiaNM5t1XrQDHtSA3iHTQ/Kl6RH+X?=
 =?us-ascii?Q?u0PIaXqB3Rv9PSFKb2z7N/Bys8HMh4ZpnVlZEDOZfolG43JZKHBTtN89459h?=
 =?us-ascii?Q?ml6n4T0DoNzhdiWOUZ8y+rnD/25NRsY7RElPtqk7hAEU0/PwbpNJfRfszqiI?=
 =?us-ascii?Q?ALBtIoNaU9ylJ8GCHO/vZi+GVURYdJzraYKVDN0w0Iuap/fXAlzoaWMI3EM9?=
 =?us-ascii?Q?79Knp0r+7LGS4J64+j1fy7iunhYmP0xqyfhh5C4W30ZkeZAALIB8F3WfEpdh?=
 =?us-ascii?Q?T5NNZcyTzYw3QnZuEwZtUvst0lFzgRhjoENx9ERanEEF/i4e6ErsLcYMaecZ?=
 =?us-ascii?Q?q20MZxcAO0L3+mr5VwHRglAerSEztUk9pWlHOdn9DZjOFXZTzbCt1B/m+cUb?=
 =?us-ascii?Q?a0OZLvflt04chcd4aS9iKrtNDp8fttGooBb1dXwNUalWaLxsUR9fHwdaUEjr?=
 =?us-ascii?Q?EV64U01MIkOQc0+Kx4kG3YKY/SKWSr8HTur20ujyaGqkUJffM7CcmRgKurRP?=
 =?us-ascii?Q?M36P6Y2qJga75jrwr9MJ+itODtgs5KiA4M9adooklmUOZVaD1nt5moOk/prH?=
 =?us-ascii?Q?WO7yPw5Hr8iEu9xaV+K3ZyZ4V9agTu0ZaL07wvudzX8L8T7Kh06RCjIKF03d?=
 =?us-ascii?Q?2Kt38XSaavU8rmHze+aLAi/NRPaLWJas/h1j3ok5QctJgQZ7eWgJJ7wsV2hO?=
 =?us-ascii?Q?sdPU4mqJxtJbakZ/tup01R0dLV97fqBEPmuKI4jLwBbpHqJtb/sZPP3vOydp?=
 =?us-ascii?Q?IPWUX51/bxpftFjBYd8hA2gPHJ8G1niojMKesDwqoPrUFLibtSeYj8PKkEHF?=
 =?us-ascii?Q?Qp/eKkkOw8apAwKnErphQ0LD0KFXJj7yzfuNaFl98jYPrhZy+iyRonvOCJL2?=
 =?us-ascii?Q?qwO63KnNMpyU6TxooyK+KPUg+BUUQilN1HA2E7rEZCfn+t9I2iHOxXJmiYo+?=
 =?us-ascii?Q?9FMLg8K/AfOhUT5ym404Xx5XJxmiLB/eTd9+R8SPzNG5MVxChXmCl35FsK7v?=
 =?us-ascii?Q?aIkINyrwKoaaeFazYqJFKYUbeAmCIYCXCL0oMTC4Q59a+i7EIlXqO4fVKRPA?=
 =?us-ascii?Q?GB7JMy39yZFdAFKhCGxaVC2VFS+lLmht5u2poVe0gAfF+9YrN233wiNB9Img?=
 =?us-ascii?Q?alqx5XLM9+3aPs4f0RX2+LMmrVA5kpaa0mOkw4+9/ZUcFGeSf+9dO6ApnIgi?=
 =?us-ascii?Q?gn6xWDZp2wF7YiOCNYCKCHqJ1nTNlhPtS7v/SWwrVZFOuddH62S32zDwofHP?=
 =?us-ascii?Q?ZmQK2K/m5e6UVP+YlorCcCPKhYcw0/5Q8SyRJkusO5op1MlWRAeQa6IvEJ/F?=
 =?us-ascii?Q?eS7MrZMmahPkMpVqwft07mCs0zt9ZB8M/9a8ip5GItYjPXzypxkj8/6a7aA4?=
 =?us-ascii?Q?P/k6Ba3nzv4A2N+9i/rUr7npJk1bJGfY0J93JarX4GeDBmwpUMUfTuK+J9c8?=
 =?us-ascii?Q?+dt1ma7o5Dy0gznfQO4A79bQZ5GpEkSznpuQGiQJ0ZfJVeX3BnFiYrZbB1EB?=
 =?us-ascii?Q?b1ghuPSC9RKwZufFxlMuiKlBu99TXWrYBhQHZVE9eKIA5IDbUOjAN4TDktO6?=
 =?us-ascii?Q?tjY4eBxwUyG2Ja1IB3aQvt3WulOAmMtVJv8Uiue1Ar3p+l4jtf4bP7UKMo64?=
 =?us-ascii?Q?Mi9B6RqA2ao8VbTEV/CmS96F9bJve23tlLUhqWKAKRiURMVgGDqV30YMU2DZ?=
 =?us-ascii?Q?kl90BI+QeQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b65416b9-cfd5-4889-16a1-08def7b106db
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 14:01:23.1394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nQoolz9kIY/Li+P2CfoPDAOU6VMMC4+6xmtqHAGEgokiC78Z3rhTLjcFJIt+Pa1B
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6168

On Tue, Aug 11, 2026 at 02:45:59PM +0100, Matt Evans wrote:
> So we can just do this:
> 
> - VFIO exports DMABUF internally for mmap()
> - It attempts to get a provider for the export, but if
> CONFIG_PCI_P2PDMA=n then provider is NULL.
> - The DMABUF works fine for CPU access through the VMA
> - If someone were to fish out the DMABUF from the VMA/fds then it cannot
> be imported unless the provider is valid (dma_buf_map_attachment()
> returns -EINVAL)
> - Drop the P2PDMA changes entirely
> 
> IOW, when CONFIG_PCI_P2PDMA=n you obviously don't get to import DMABUFs
> into another driver for P2P, so the provider is unused ... and when
> P2PDMA is supported, the VFIO BAR VMA's DMABUF has a provider, so could
> be imported for P2P.  The struct vfio_pci_dma_buf only needs to have a
> valid provider if the DMABUF could possibly be imported of course.
> 
> The behaviour of pcim_p2pdma_provider() is unchanged, as are any other
> consumers such as mlx5.
> 
> This is way simpler.  I will drop these first two P2PDMA refactor
> patches from this series.  Sorry for the churn and time spent on these;
> though a cleanup/refactor could have merit separately it sounds like
> there's discussion needed on exactly what that goal should be.

We are going to want to do this eventually because not being able to
import a dmabuf means vfio won't work with iommufd - and there are
still a bunch of architectures that will be impacted by that coupling.

I'm fine with you punting on this issue though

Jason

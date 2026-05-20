Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013032.outbound.protection.outlook.com [40.93.201.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D6D3D5647;
	Wed, 20 May 2026 18:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779300831; cv=fail; b=AF+XZTuJmtDE0XmWZxiFHaRDukGUc9LA1E6LqjiqxI86xyvbn83QuWeV4DSVNMfb/Q7OrnedLedFNUBi2moGuUIbvXCf8EkI/t+TqGxPr1IIPptx3NUE9cvWtXcbYmwbn9EVm76+EbBdSKNjbZ4iOrKRfThTzFcDwuiY45bIYeo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779300831; c=relaxed/simple;
	bh=2QHmeTDWmI11zUsUCMBScSfAIXqc3pgGX6yCW7Bretg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q5IsDPFj2obGkX5tjWyAABxmOcykDqMPDtqULSsdSjBEQIRujUcPzIoCskRwtU1wVKtBFQK+Z1js9GG5J8WqEsguyKwv/HMyu1omdO7fmufeKFX3V6WoQeR/t90zvOZqJ+0Ea+j709wM3Z+zFW85ayZKCNYu65UP9YzoS+ruK70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fmXVk4ss; arc=fail smtp.client-ip=40.93.201.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fmXVk4ss"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R8zIb28dg9K0OTz6GG+9jnasE3LmNAamy5G7YCC28nbjZJHmX4hXXhopZz7O90vmN05d0yWnMEOynJsrehimP67Co9S8oKBuSTuZmsxv5KhvDzi8NInFcYMA24c3FOLnZwmqncv7zRsiev1o56dC6BNM/eoqoijzqch3YNZ/ciX4I24PeziH2Oy7BTAvO/kATHC0UZGu/LSf90RnCWE1VBuCud4ws7pTr23iHfbcBXnZYGxLrAAV4ttwG8YknKnPUiufBWwOkJLfc9DhwgnjW0mTDYCpskevA6w8PGgRq2ti07fyJCS58sWJ8fmrrHqE6W6zcr4dFztj6UVPcKR8uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=leT0Ykt3R7iAgmve6jyCfz8AOhpa75O4X2OfPY8Fzgc=;
 b=haECTcG/WBCB0Th5+EVgokKZYWhIWnVW/Vb+9Kw4pLvIKRQPEJ5Jd5onTg61xRF1k6bPpzwmKN0kcyFGHnSFgUrlrP0ZTe0OoAz5X8Tzqmmjhf3w8ILE53aP/Fl4c+sXFnyI+ZdfvTSZmCtS8iLbv0AqNlDotJAMFPPCsbUPrvlR7BwoQ3OFldXufarCMVbQBIbrpbum1YljaZGu0Widecykn1x622ecLDbCpwtBeCgwq4oEbvVmJd2aeikoNiryrd9iJoMt800ZvdlbXpJRxSQ/YH1juafGGYgGapimzwjMbnHCb43YLsPrHI/PHwbwUeFbNFhMCZU2769PnaTgpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=leT0Ykt3R7iAgmve6jyCfz8AOhpa75O4X2OfPY8Fzgc=;
 b=fmXVk4sspw1bly4BaiDmqF5yAlOrmkuIYoG0kYmgh/MqG/G/u9pJJ84NQfWpIdPraT3nF/hgi0YO2pA5eP+8PmUVr9kicZZvdRCswDp713AznBbctXkSNLfHNv4HOI9g6oOoCGzF7vBRpwQsu6hMzUg0oQykJNkIEkJswLYC3RaNS8T/rPFF0WNR5dOFYfRoTR7wHkF5Fz3MvHuiZaZx18YodKNnEyvONXyAc5M64ZS67xf5wBdiSAV6OWIRkDVczzlfEVB0eIayxYpXRfyIEz0bN8V9fcFV63yWOh+DQJyjf0govzNHvghTSj3RPyMnGTdcUM/XS9wafdEl6s7xWg==
Received: from BY3PR10CA0024.namprd10.prod.outlook.com (2603:10b6:a03:255::29)
 by SN7PR12MB7129.namprd12.prod.outlook.com (2603:10b6:806:2a1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 18:13:41 +0000
Received: from CO1PEPF00012E7F.namprd03.prod.outlook.com
 (2603:10b6:a03:255:cafe::54) by BY3PR10CA0024.outlook.office365.com
 (2603:10b6:a03:255::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.16 via Frontend Transport; Wed, 20
 May 2026 18:13:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF00012E7F.mail.protection.outlook.com (10.167.249.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Wed, 20 May 2026 18:13:40 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 20 May
 2026 11:13:17 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 20 May
 2026 11:13:17 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 20 May 2026 11:13:16 -0700
Date: Wed, 20 May 2026 11:13:14 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Joerg
 Roedel" <joro@8bytes.org>, Bjorn Helgaas <bhelgaas@google.com>, "Rafael J .
 Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, "Pranjal
 Shrivastava" <praan@google.com>, Mostafa Saleh <smostafa@google.com>, Lu
 Baolu <baolu.lu@linux.intel.com>, Kevin Tian <kevin.tian@intel.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <vsethi@nvidia.com>, Shuai Xue
	<xueshuai@linux.alibaba.com>
Subject: Re: [PATCH v4 11/24] iommu: Add iommu_report_device_broken() to
 quarantine a broken device
Message-ID: <ag35umFgzIRGZAHA@Asurada-Nvidia>
References: <745da1a819eb943f2519e660c8bcfde715885c6c.1779161849.git.nicolinc@nvidia.com>
 <20260519120737.GQ787748@nvidia.com>
 <agysAyreCY4huf0I@Asurada-Nvidia>
 <20260519191626.GJ3602937@nvidia.com>
 <agzkldmlG1cuDkj4@Asurada-Nvidia>
 <20260519230204.GM3602937@nvidia.com>
 <agz+kL2S8kcgHywG@Asurada-Nvidia>
 <20260520003023.GR3602937@nvidia.com>
 <ag1guf1fHg4fE7Lw@Asurada-Nvidia>
 <20260520175123.GZ3602937@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260520175123.GZ3602937@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E7F:EE_|SN7PR12MB7129:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c2a5b67-01c1-41a8-6edf-08deb69b857f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|7416014|1800799024|22082099003|18002099003|56012099003|4143699003|3023799007|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	fl50iSAGgAGzRyZDHou3rPH6SN5d7hmN4gHSjr9a9uQV69eTG/y6siJkVVuGyUb/kXGu0g1UhmqnQvP6b9f4uwvWcMliMtvk4Vxs9oqCcVyRbufkYZyiFDKI+ZFlf+GiX/wntxXtJ7iTE7XL8mJROvZsM0WRFMlbUXmt88VOKzup+UNkw+dmq1McbGjDEBQ4+MUhFVUp8GRQ96A09HTL7ZOfsP48KnnR+jU9dmXj8VAiXym9TdjuGDCupj7AHpD6aGUEq7/cm/pogxYEYCLBcIM1nQcS9CzG7bK+IWNiFxsRQfuwRVdfcViwCEKkzvCtB9KywVl+9JpZbcql7U55VG7mWjHWvO/nJB1PXNmmJiwov/n1mZ8s6er/Q9X9Qh42TdRIRwuirFZ+JNgdLirGxVyyHaoF0g1lyOHuB3CcTwLMq2bls3uoXIygcl8gNGige8DGw5scVm46Y/RtxTZ5o++ef9eBCIJIYJFieZg/l+fI5VJ6Z9PwBluQwWWNWI3LHdmpk5vRG0x4D2TzQZyWHBUGqOf052AxhS7Lu9RxbnCBbnOzaeYJTv/8rr+DqH8NEIB3NmYSnI0Mj1Smpm5WFwyniCCuBRwZGgJ3XXZfkgNcyFXdF2psO5mP+oic2PCDgWn3Nv2cDYQgySBvk1POFTbBhIo7BlUX6EGUoL2Q94h3q29XogDEo8/Ozo/W6DG2pNIZjFsXt4E+WhwM7cqIDJFzsH1w3+ODxjs27MsP+1c=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(7416014)(1800799024)(22082099003)(18002099003)(56012099003)(4143699003)(3023799007)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	k6RKnpUcpsrh4dKbEa9bOvQBWzm83UZxcsSQMbEqGwc2Kb/s6jsjJsU7dQcFxY7X28XLihlJG+EHIikBNfVROh+m7X/MXYQ3H9qXx5X8v+gDntqg8BTZaATkumXWz8Qg+boOwgxLdxzGD4c5r+RBmZKpksMAqqEJGZU+6ZkdpUH5Kfmnn9+qBASYQV/tg9SkVgN6yDNv1EuYqi36xsVQnIF0q+Tqu6w1Iyhjtf2Wll6/GfpIGMh5ajHQ1of3c0873Yn1oJSZCrOpykxuodyXMkV+fqkY0CuiEgJsvMjALLXi/RC7pAFSsmAibrcJ8KmBdr2ByHD8uvhqUJxhvTj2hI6lFle4OpySmUEVUBVY1ZOTqcmCqh+pkfEKfMZXAKUoJc1PwKTsUNHBb2ITi1PcwJm1Y+GBpjBNIlnk/GzBn6QbJda5CH+eW3t/bkpEh24v
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 18:13:40.7380
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c2a5b67-01c1-41a8-6edf-08deb69b857f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E7F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7129

On Wed, May 20, 2026 at 02:51:23PM -0300, Jason Gunthorpe wrote:
> On Wed, May 20, 2026 at 12:20:25AM -0700, Nicolin Chen wrote:
> > > > I see you suggest to treat the entire batch as ATS-broken. Just to
> > > > confirm: without per-SID retry, that might falsely block a healthy
> > > > device in the ATC batch, right? The driver now batches all ATC_INV
> > > > commands via arm_smmu_invs_end_batch().
> > > 
> > > Yes, it is not good, but a giant complex series is not reviewable. So
> > > I'd start with trashing all the devices, then come with a narrowing.
> > 
> > I can take that path for now and leave a FIXME.
> > 
> > Another option is to not batch multiple devices, until we support
> > retry (which shouldn't be hard to add since we've already done the
> > coding)?
> 
> That's an interesting idea, it undoes some of the meaningful
> optimization we have recently done though :\

I remember you didn't like it. That's why we had the retry(), which
I feel we should keep it..

> > > We cannot eliminate parallel ATS invalidation. Two threads could be
> > > concurrently processing the invs list. So it has handle it, the driver
> > > is going to have to tolerate a number of redundant error events.
> > 
> > OK. That sounds like we still need a flag or locking so that at
> > least pci_disable_ats() would not be called again. I will see
> > what I can do.
> 
> I think we can call pci_disable_ats() as many times as we want

That triggers WARN_ON(!dev->ats_enabled) in pci_disable_ats :-(

> we
> mostly need the driver to merge multiple error notifications for the
> same event.

Yes.

> > > But I wasn't thinking we can rely on existing AER events here, yes
> > > probably there will be AERs associated with the device exploding so
> > > badly it cannot do ATS, but also maybe not..
> > 
> > So, should I put the AER injection on hold for a future work? To
> > be honest, I am still not very clear how AER injection could help
> > here; or is it for a case where ATC times out while device isn't
> > aware of any AER fault?
> 
> Right, if we don't get an AER fault then we should ensure the ATC is
> surfaced, but you have a reasonable point that it isn't so likely the
> get an ATC invalidation timeout without a corresponding related AER..
> 
> Still, I'd feel better if it is was definititive and we didn't rely on
> this. This further points that the driver has to merge multiple error
> notifications if it gets some AERs and a new "ATC ERROR" all for the
> same key event.

I feel some race here... Part of the complexity of this v4 is to deal
with concurrent device reset during the async report() between IOMMU
core and driver. Now, we add AER that could compete on the device side
as well...

I will see what I can do here, yet likely would defer it to a followup
series, given the direction is to shrink the size of the series.

Thanks
Nicolin

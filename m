Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012049.outbound.protection.outlook.com [40.107.209.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A534B2594B9;
	Wed, 20 May 2026 07:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779261658; cv=fail; b=l3z54D+8rsJQsnoS1cFl0G4/4lPwSKvjlwZuxJ5e+aRUNpUy4ChYOzrzroHJyPKN3+v1VWXJgdzJ6kGbBA1JOO99aF1QEMN9vEjumo1wt1YgazzXSHDa+iVwgFCb2TMW8GA2C2d/aINKS3O+rvQ0yQGPBt4uvtnhCHTox+pzhRA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779261658; c=relaxed/simple;
	bh=VrL6XZX8sl44W1xdhpn3KPVAsVh6K6EWoIPiHYa8Iw8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SguBdka2h/ZW3qCe86RARaGgmfUgBRmwbAVO2BYaUv0dyUDFKfLHqYrFypdlcQsgtxEsh9VXUxb6FncP8jmtIGrdXxgM1D3ypSH8ERSxCmLfXi+XgqZMnyhAm9LDWj/iW9R2ni3nsIjaYY/gm1y44ZDpRouGy51GYlv+XE0H39I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IUmdT6jP; arc=fail smtp.client-ip=40.107.209.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IUmdT6jP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kzxf5+FAkLaHaXRW5TYPrePIKYGLCtcdCGnld9H1DNgeD2BZi8NQrYlLWNKlKahvGDylcTbV6d3CEl0JcLfNFM0aDgxp6UFuB4UzT6c/selIqoxVLc13Yqjwe5yKP7MbBxJD+8FbAqSgUZU0BZN0LNMz9UgIS7iN900GP7+63ISoROfnsrj38MY7QlkVhCiUj4Pb9r9TruEVtvX15tKOG/UEMt/LkoFdEcgrwZQovBBbfoHd/9dD0BYbA6tqFdCpHK4L+9QSIA0JYZRB4X/h/qfbulhm9rQxK5rntNVgOqopvzBqXPTkU0skocdYedtNV/SEeNljyjp53cH3fBcqIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fhOeUuTRNmh6V1MPjm98rvZOq1whC5w7W5ClRL6ssKA=;
 b=hYC8Gc8BGIgGoaX4qvvkZGkWaHOLjsny3lK6oZ0pgPJUUzI0ZyiR2zeBQz6d+qEyt3HnL/+GenlFJid9TgCPngaO7mPYPFybC3styY2X7jyabqKRxSMjg8nGbaQ3mTOJ7Z9mCI1l0Hb4RUkuv+36SUKJKhb/LNyjI2e+AKl2IFfKaJS+DJljq9mPD96l/lwMg07bJQ9VX9h8vjFnWOMoI8Cp9lK4P5CLTRD6MCRDP+iQ0whwyI3/eiNGIQuvaSwZktY5HmDjaKSg9zmQeqftnlJIHdjnMnhiUZBEpZu/0sfth8KmxfgzWigbCKoJeL7XRsnF2LQwAXzA8/+TME8zUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fhOeUuTRNmh6V1MPjm98rvZOq1whC5w7W5ClRL6ssKA=;
 b=IUmdT6jPNw75EotYvlee/ot81GmNQz/cU3rhSg2sKNme7fnbwrMwlO5kuQrehjRGm1/R1Q3Xrrjkh1LznLZtfI7GJ1DGhAv4I2PywqSMT7ECxvbKHAAoiPg3UdypsLZbLVetqYA80cp1cCAKVvQsmX+7FwlVQ3mlFHlkHdtyYQqY22XySNLII1W/84esUSyNr5yU6I+lT0FhgqmB0ya1wjp3raQPxpaCR8GQT8zrtoeIEUGZBX2gLTQUP0YuKI5uvJxc6R1KADqA0CKAdqQiraD6nOrcifTw3oPTYW8+laCBAORM1kuexSIp7V6XM8FKMtbXmWFAHGMFc1+ZIQS3/w==
Received: from SJ0PR03CA0206.namprd03.prod.outlook.com (2603:10b6:a03:2ef::31)
 by DS0PR12MB7926.namprd12.prod.outlook.com (2603:10b6:8:14a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.21; Wed, 20 May
 2026 07:20:47 +0000
Received: from SJ1PEPF00002324.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::55) by SJ0PR03CA0206.outlook.office365.com
 (2603:10b6:a03:2ef::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.14 via Frontend Transport; Wed, 20
 May 2026 07:20:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00002324.mail.protection.outlook.com (10.167.242.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Wed, 20 May 2026 07:20:46 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 20 May
 2026 00:20:29 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 20 May
 2026 00:20:29 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 20 May 2026 00:20:27 -0700
Date: Wed, 20 May 2026 00:20:25 -0700
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
Message-ID: <ag1guf1fHg4fE7Lw@Asurada-Nvidia>
References: <cover.1779161849.git.nicolinc@nvidia.com>
 <745da1a819eb943f2519e660c8bcfde715885c6c.1779161849.git.nicolinc@nvidia.com>
 <20260519120737.GQ787748@nvidia.com>
 <agysAyreCY4huf0I@Asurada-Nvidia>
 <20260519191626.GJ3602937@nvidia.com>
 <agzkldmlG1cuDkj4@Asurada-Nvidia>
 <20260519230204.GM3602937@nvidia.com>
 <agz+kL2S8kcgHywG@Asurada-Nvidia>
 <20260520003023.GR3602937@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260520003023.GR3602937@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002324:EE_|DS0PR12MB7926:EE_
X-MS-Office365-Filtering-Correlation-Id: e4f19cb0-812d-4ce0-c452-08deb6404fde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700016|82310400026|1800799024|376014|18002099003|56012099003|22082099003|11063799006|4143699003|3023799007;
X-Microsoft-Antispam-Message-Info:
	U8MouGReJ5xTr6TUP3fO7Y6sAtBHv5c1Vk+eyN4pD8EV2tbUT5lzqM/wQA0QTVBgQ4rk74f0fUzeGhpfOtoWCBPv20thsa0f7YrP8BtvZP3WNur1tGYxTPhqC+iq7gjs07Yrx+bklx5kL5t8sAsfc0ar/PSpuTtwjrXHBd1Ors5uDv1D6r+EqvlyasXFutEk7DQc5PGL7wxKUUoS7YvG0oGpGBP7f4F0gjqIDb3yo7cE4Ubb8Gvh+GYQi3mDbK345WgaflovCU+cUdvssLL9qbWdxG/TaNOsviQVq7vkZxqRrKSMTQll5gRoDjP3xtJUH+sIBDDHrlzYBpW+WbDnksgPZ1PrPZuiy07x3exKNoz7Y1cArPaUEyHCVT4ZU5BKWoqzZVEa550ex6VtT0wZ+26kgMlY6eucz9MWLsL/mzttupMnZRfJ369wciN9V/N+P60qBnFmwEmNoHJcL2MwNfLHZBOUce9PkFqTCecHAd5sTbp8wqK3e3bjOZq28xxqeKmdIi5trTBkFwI6ohUARGq8ROZqZ0BgXaAeFXnkIWt3g+6LTb5hSBKgj+WvlnQv8aBfUi8vViJMDGUcy8SnDvV87vQo2YLphCldwV9hD0u38AWSdNcpWqzQBSNqUZRmP14gA5C23gpQsKFyMJw1vTqJumPPrvkIMPGJ8eSlPXHosEX2UN1Rti4kyIyA2lPuFc6JysgXXZXA7LIaopaLNbmdcYUNFaXaAMfVg/Gz9VE=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(36860700016)(82310400026)(1800799024)(376014)(18002099003)(56012099003)(22082099003)(11063799006)(4143699003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	T7fpmfErv5t+RBFmzc3m+hU97lTIBTA754Wjary9y9YJ2o8PirnfmiB40cG0dcvnPbe5R/oHTM1kq1r5ylW7DVFshTVoQuzZF5ZEyEIzjlhP8gV18xFOgV8lBlL23HoorYA8pgUJNRER6whcrUyuF9WVKfxCqT53v/qCt1G/Zg/1uq8uhybpFXIRrrd7Qo8Ij0cnbdFBs96XYKBmxRTzTjTaLs7etjEmLx4xzmH0Z1IXJiknr/56aGF+DmgG95LrqoFSC2VUiRgOSyfILfdo5463BduHWsftGgmkR3aXQmyhn1c9IB9VstAWCjcsGBh/EYJ83KZ577O7jBi2VlQtUCq1LTsGfn2fcDpsrvCLrU21xT7Bt7hswPjgJmAtobjOEUyUBsUJMZJ2ztRyDgK651DoSyB36+lMAUEnuc5DcWOJnd0UvM6CWOa0WVyjoxJl
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 07:20:46.6906
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4f19cb0-812d-4ce0-c452-08deb6404fde
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002324.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7926

On Tue, May 19, 2026 at 09:30:23PM -0300, Jason Gunthorpe wrote:
> On Tue, May 19, 2026 at 05:21:36PM -0700, Nicolin Chen wrote:
> > On Tue, May 19, 2026 at 08:02:04PM -0300, Jason Gunthorpe wrote:
> > > > OK. So you are suggesting a quarantine at the driver-level only:
> > > > 
> > > > 1. Driver detects ATC_INV timeout during an invalidation.
> > > > 2. Driver retries the commands to identify the master.
> > > 
> > > I might argue to push even this out to a followup series given it is
> > > complex and I suspect it becomes much simpler after the batch
> > > removal...
> > 
> > I see you suggest to treat the entire batch as ATS-broken. Just to
> > confirm: without per-SID retry, that might falsely block a healthy
> > device in the ATC batch, right? The driver now batches all ATC_INV
> > commands via arm_smmu_invs_end_batch().
> 
> Yes, it is not good, but a giant complex series is not reviewable. So
> I'd start with trashing all the devices, then come with a narrowing.

I can take that path for now and leave a FIXME.

Another option is to not batch multiple devices, until we support
retry (which shouldn't be hard to add since we've already done the
coding)?

> > > > 5. Driver sets master->ats_broken to fence concurrent attach:
> > > >    arm_smmu_write_ste() and arm_smmu_ats_supported().
> > > 
> > > Not sure this is needed, if we race some attach then the attach will
> > > re-set EATS, get another timeout and clear EATS. Doesn't seem worth
> > > trying to optimize for.
> > 
> > I didn't see that coming. master->ats_enabled && state->ats_enabled
> > in the commit() for a concurrent attachment would issue an ATC that
> > may timeout again to re-start the step 1.
> > 
> > And since arm_smmu_atc_inv_master() doesn't use domain->invs, it is
> > not affected by INV_TYPE_ATS_BROKEN. So, ATC_INV can continue to be
> > issued in this case.
> > 
> > Ah, I feel that we are walking in the mine field where every single
> > step could be a kaboom. But your insight is clearly a safe pathway.
> 
> We cannot eliminate parallel ATS invalidation. Two threads could be
> concurrently processing the invs list. So it has handle it, the driver
> is going to have to tolerate a number of redundant error events.

OK. That sounds like we still need a flag or locking so that at
least pci_disable_ats() would not be called again. I will see
what I can do.

> > > We do need to push a pci error event (didn't see that in this series)
> > > so the driver can catch it and start the FLR process. I suppose that
> > > will still need to bounce through a workqueue, and once you have that
> > > it can also set the blocked domain prior to calling out to the driver.
> > 
> > In the specific case that I am trying to tackle with this series, I
> > do see AER error prints from the device already but there is no FLR
> > process. 
> 
> It depends on the driver, mlx5 has a FLR RAS flow for instance.

I assume a driver like that would trigger FLR flow on its own?

> A driver with a device that can blow up ATS should implement the FLR
> flow if it wants automatic RAS. It requires driver co-ordination.

Or FLR via sysfs, which I have been doing...

> But I wasn't thinking we can rely on existing AER events here, yes
> probably there will be AERs associated with the device exploding so
> badly it cannot do ATS, but also maybe not..

So, should I put the AER injection on hold for a future work? To
be honest, I am still not very clear how AER injection could help
here; or is it for a case where ATC times out while device isn't
aware of any AER fault?

> This is also a problem if we shoot healthy devices as the first stage,
> there will not be an AER from heathly..
> 
> So I guess we need to decide which is better to tackle, the dedicated
> event or the single invalidation sequence..

I feel it safer to not break healthy devices. Otherwise, would a
nesting parent invalidation falsely block all devices, if one of
them times out?

Thanks
Nicolin

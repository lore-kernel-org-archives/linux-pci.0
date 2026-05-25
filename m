Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011042.outbound.protection.outlook.com [52.101.62.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF77330C62D;
	Mon, 25 May 2026 20:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779739556; cv=fail; b=kLkSEaT8Eyj114H6rKVZ0xqvK7XnllgwLliri6Zuiyg8CNbMxeHdV5F6y5Bax/Rd2WwmTzGe+gGmPhLvDENhqyWjt6zkQBYq8GhEGX0eiLx/ercxWqFso49n4oSJCpMqkkssRCw7ohjYErTp78Y1yjLcFfFkFVUzEL767FkLF2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779739556; c=relaxed/simple;
	bh=6/4jTBp6ViGvDQ9r1IAfv9I6WX7JVI+1e82T4ooSM9U=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CPM/+gLFI9XAYN5WQWyxxZKhYVv+JEvla16clo60XYRyO7Q7pSYxuAuapsXKRi/G+7Ow9uw1FcMVA3eq9cSR7GMFkBhlpkKWWInyAglFRk3ggUMDX54Dtf5tuBMEwsCNQhDZ0F/o3ixoOPcJpLtggeFZY7AAvx9gFVGR8HQ13Og=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=S8U60xFC; arc=fail smtp.client-ip=52.101.62.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="S8U60xFC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bf9OAv/S8Z+EN1cwCXPOrTCwn2kz6u7cS4i8Wav0tOp0MxZH5UeqhnlK5gDPDS9Keu5F3oea0kGx5CDo8/heoKcauQs67Qf63EFAoQf+ZFx7miMql6tnbw97z9oeDRouqXWG3BZHHDFBiKvgB/+aVpUI4jzM8eC9MYflogX+13RYvsOO7FG3nKSNgn4/Dehz88+6eRloJjwbRSwkLlnoQl/LfCdv8rbP63bzcSayD3ms39mHvGG//T42zkYSZgILcen3KHJ+7+0+eyllc11edfu/kEsU8pRnsnmt7hbhoz+SFb5HaJakgIumOn3doqZC+EA/fFnjWqIVWBEdSPyDUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mIsArXoQ4fmUAmVv1qc5ewZ6YHXQWG7LZuZEGibkT0E=;
 b=ebj0pCfS+KkUo/9x5Pd97RTHVDEFVOJoZeReTF9fbAy1GabwRApnfLBwwQPK6sGaVrtZ2MXgc2VmFv8ptcwTKfvAcRquajkzgKT1IqefTXCQANYzkZ6USJA9qaVXaCpFeC5gTIcrJrLIjs9lkI7PUO+X75EvW7qBDTc5P/2p8X4xpeUFr7jIT+HyD2vEmDYGvj2tCIYjnd8bOxtVfvy+QYvV2ev0DGhKFlfL9loyZEWSpDn6D1GZo5kldWQfP9f0RT3PfV+/q/U66vSePTbj6rETHUvIqcJt/qsxOK6mhTIm4vA5bt9PZ8IpM4KwddF7sJ0vDI275pzP2c9JgWpe8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mIsArXoQ4fmUAmVv1qc5ewZ6YHXQWG7LZuZEGibkT0E=;
 b=S8U60xFCKXLtSeO6aI+RhNBJq16UQhG5GseMfn8wZZ4MR4shCp3lJtUs0GuVT18POFO5IF/sllz3yky/0hGdQ4xInuVY90ZmsISKU8vnzytWttv5yoPe1Tg/LdOjCL8zKIEunVZBMwz97QQAqLLGku+ez5Zep1uA1vsKncdWj+dfoEQtGGaq7mI/SBSSKIyrIfneV4107jfEoGRYYuACTFGvI4apVrxaavLwUKJRE46W/E/7T/Bf4EmQZT+ackI8Po/L130wJI9FxKJYY1f0Y6mMKg1qkpkYTssDprMhNEGqbFnuzfWDXUW6BKKk7i6yUMZHNLF/POhvVrGAtVhEzA==
Received: from MN2PR06CA0016.namprd06.prod.outlook.com (2603:10b6:208:23d::21)
 by SA1PR12MB8699.namprd12.prod.outlook.com (2603:10b6:806:389::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Mon, 25 May
 2026 20:05:50 +0000
Received: from BL6PEPF00022575.namprd02.prod.outlook.com
 (2603:10b6:208:23d:cafe::2b) by MN2PR06CA0016.outlook.office365.com
 (2603:10b6:208:23d::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.20 via Frontend Transport; Mon, 25
 May 2026 20:05:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF00022575.mail.protection.outlook.com (10.167.249.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Mon, 25 May 2026 20:05:50 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 25 May
 2026 13:05:39 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 25 May
 2026 13:05:39 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 25 May 2026 13:05:38 -0700
Date: Mon, 25 May 2026 13:05:36 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
CC: <iommu@lists.linux.dev>, <linux-pci@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	"Joerg Roedel" <joro@8bytes.org>, Will Deacon <will@kernel.org>, Bjorn
 Helgaas <bhelgaas@google.com>, David Woodhouse <dwmw2@infradead.org>, Lu
 Baolu <baolu.lu@linux.intel.com>, Robin Murphy <robin.murphy@arm.com>,
	"Suravee Suthikulpanit" <suravee.suthikulpanit@amd.com>, Jason Gunthorpe
	<jgg@ziepe.ca>, David Matlack <dmatlack@google.com>, Samiullah Khawaja
	<skhawaja@google.com>, Daniel Mentz <danielmentz@google.com>, Pasha Tatashin
	<pasha.tatashin@soleen.com>, Mostafa Saleh <smostafa@google.com>
Subject: Re: [PATCH v4 3/5] iommu/arm-smmu-v3: Fix ATS state tracking
Message-ID: <ahSrkOv+4QZWrcJq@Asurada-Nvidia>
References: <20260525184347.4059549-1-praan@google.com>
 <20260525184347.4059549-4-praan@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260525184347.4059549-4-praan@google.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022575:EE_|SA1PR12MB8699:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ce48b7e-9ebe-4291-2da9-08deba9904c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700016|1800799024|4143699003|11063799006|56012099003|18002099003|22082099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	1vbUS5woaL6iF5za49wDC+aImWHJ8R32CN4VlR+TfOd90z1QWjm4xWJrjRqz4BElx5sa7R/kdkqU0aARsoBVdMtkz9v77AOYFocp/QDVFysFrs5GbGx5EZqohPf/FZIBp0VqXa20bPtzGM9TkI0PwhzwYxMcMj08uo6n1AD4yzy9x7VzAI347iDBS5BOUNSzZWPP8hPMhf4jLIy1BbGdSD2SJ5WMJ7B9ZS24f7A5g0BkiVpEuxz2zHs3ReCdUOveSIJefUz4MV5d76MYrlDMg3wA6yq0vSojZ3Qb2sEiShIza37GcG2odyYps75uArANW7qtQWLoHFJ4/tyAsO6R4HF7nQjxqnqgkWAlOQWdNliZyMtc771WbXeihStDkrurrl6Dlbaq1hNJj17M03XEMj8GB44Tc5waz7r5o+0tPD9+tysMbQcdAU1QnGJ/a5imgdrGtWTPMoSasjAn/vb4yP1fK8Jqa5wm7PEHjAjMUfKvQJK+IKOvPgBZHDod8erRKefXvqSl4TPWrrjaWwp8fQ8cNGRqO7oPF2Wx3FS1pIPUmDIg2dJtrgUW164Bu02uR4lQwxh4uI6JE+kYrnxQcFxM9YaNzJIAw55udXDKAddPXyKgMlBPETTIt6DPhMs5+/EVVn60DEQeHAGA03psgoY2Xh7Dpi08gVkbFZH2YxetbREuY8ku4ZRv6lbYeFgK6uK2go6zvXAVXtW7WzRYUw2dxV6aJq9sX9l1YjR+FeQ=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700016)(1800799024)(4143699003)(11063799006)(56012099003)(18002099003)(22082099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Gxcs462pQM9dgXEUoI8+3tbLHj2Ou94bAqhHOMrWuxhlUVbQ5Hf3P25Vby+OX0Bt5B4QIywK+zkWjZn2j+9Xq5F5ieFxI/exIbFfbJtg3UUMNqB8N0KPzhn1PPnV+kf/q5R6PmCILFhXqJWeA6jEZvYI7BYWZuqyK+WSoLoc9yHNc/8qLPMBgFg1mtq8BTTIHktM+okTBz5cu74yEdFCI4IRLFz4+a9ATQ/Uy4GGnhziDVhjylNhEOTm7LEnXLbAxmlV9z34caFEg/fkPnXreXOMxMi/O4g1Rg9QyYFeYqO6LYazpybyMaQYOEGl7StOKucc39+nwcxRDsb8FU+5E/8BdC406En0LB3osSkakcDLMzSBbfzfYzksChFD+iDW8w7g/SnJcYuilfrSxQ5Lk6q2wtsdjhv506n4LphjMCoPFJM/md1hp/9rTqH2a5fE
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 20:05:50.4341
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ce48b7e-9ebe-4291-2da9-08deba9904c9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022575.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8699

On Mon, May 25, 2026 at 06:43:45PM +0000, Pranjal Shrivastava wrote:
> @@ -3065,8 +3065,14 @@ static void arm_smmu_enable_ats(struct arm_smmu_master *master)
>  	 * ATC invalidation of PASID 0 causes the entire ATC to be flushed.
>  	 */
>  	arm_smmu_atc_inv_master(master, IOMMU_NO_PASID);
> -	if (pci_enable_ats(pdev, stu))
> -		dev_err(master->dev, "Failed to enable ATS (STU %zu)\n", stu);
> +
> +	/*
> +	 * Any failure at this point is a kernel bug. pci_ats_supported()
> +	 * and pci_prepare_ats() have already verified the hardware capability
> +	 * and programmed the STU. Thus, pci_enable_ats() should not fail here.

Nits:
 - WARN usually indicates a kernel bug already.
 - pci_prepare_ats() covers pci_ats_supported().

	/*
	 * As pci_prepare_ats() have already verified the hardware capability
	 * and programmed the STE, pci_enable_ats() should not fail here.
	 */

> @@ -4264,9 +4270,16 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
>  		master->stall_enabled = true;
>  
>  	if (dev_is_pci(dev)) {
> -		unsigned int stu = __ffs(smmu->pgsize_bitmap);
> +		struct pci_dev *pdev = to_pci_dev(dev);
>  
> -		pci_prepare_ats(to_pci_dev(dev), stu);
> +		if (pci_ats_supported(pdev)) {
> +			unsigned int stu = __ffs(smmu->pgsize_bitmap);
> +			int ret;
> +
> +			ret = pci_prepare_ats(pdev, stu);
> +			if (ret)
> +				return ERR_PTR(ret);
> +		}

Again, pci_prepare_ats() covers pci_ats_supported(). So, the check
is redundant. Instead, it should check arm_smmu_ats_supported().

By the way, this would conflict into my series:
https://lore.kernel.org/linux-iommu/18bb6f421b3be891caa8f1fb50f3a4d56b52d5be.1779392420.git.nicolinc@nvidia.com/

It would be nicer to have an arm_smmu_master_prepare_ats() so that
both series would have a common ground; mine would be just adding
some additional lines if your series goes in first.

Thanks
Nicolin

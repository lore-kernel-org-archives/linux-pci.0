Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011069.outbound.protection.outlook.com [40.107.208.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659573382C9;
	Fri, 29 May 2026 21:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780091545; cv=fail; b=ikODGCwHWHM+Yi33jI9GrILuL1uQzKD1ZRngysPhqMBap5SnYmVNfB4lhB9AqBEoJ1u3P0lTSbX7CZ1eq7e+b+ONHmMreJ5Um0pzlLyL7oNl2ggzHKAEGZddJBM5ghJM8Bk7P0QpfRwubvz7um93EpssQdAojUn2u3YsQHIufNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780091545; c=relaxed/simple;
	bh=125ejURtGQgphC7UkzKazNolniloNs6dm9e+iPT6fpY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k4KVMJKmcVoxEeVWUAhbFBpl2ldS2mGgPdCKtCv+yu5Cq1UzK6LFz81Y8b6GNyLU8OF4gcjCf2TjaEVsIScaZLM9uL5BZ+PhzuOUTfaPUCECB3xGL2hQiLCbqXuP00TuLXFRh6lTuIcZlzq5+cGXA8SBFRPCAoPuaN/dDhrBBIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=f0+6JMUw; arc=fail smtp.client-ip=40.107.208.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="f0+6JMUw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r+ofrnGC3nHJ3CwIJaGRJgxJOk45UVkUMG3zyxtN6sC/JviCjfN3sCEV9RA6kIW7fBDONjnDQylE3IopKcw3M5Mk2jGNET4hBYxPXgvOPiVupUiU93q+6IvJv1CTip/x5ktxFzsMYcFM/nhW8DoVWXPKtaXwqG4bVISHimfHq1EG2+WORhS/omQgQxsvP3D6PKqVyeAXpWT61L4SmClGC4pklX71/CMqrtzKkHrZltaa6nQV/Gya+f3YYsvvkrsJN+ZrT/MIPnd/GkPxuKC20GCSPYyH8wPBMISci0Lr3Ha5emufumGKV+N/EdbKnAhrejQqhfj5JI6EYlufbzrv4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZmdTXdXDT66M4x5VHfY8EZ7KnWFm/67YY3OUZ1vJ3Hc=;
 b=CmjEW1+grckLHlgbVRWaoPJbR2Bahgw1t9gYYZLbSabp2W1rEoAlEix9U8zvdGnh5D8StQu2YkoOZhHK2MFIaaj4EhT+/rUPfoM1UnlcztP2nAJfyCCuRLr4vUmLFIZqiDMpiN+8hLXNTtUHzzdal08N9oK/ZUeTdSeJ9Fzo3ZTtPjTBRwuCC1Joy5hu+ghVHpfpZ3AJEhmlEh5VeLA2Wd4exDnE5qci7C5/+P1sRQ3zVYEcdUoXr2Wl2c6O4idn3ZE6JVUFQoIe3TzeAXJMvSwssQb075DnV6kYl6TkBceRBrBz9q3ucUdoF3hW472+XCetcSX16sfFu+Bp5U1nIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZmdTXdXDT66M4x5VHfY8EZ7KnWFm/67YY3OUZ1vJ3Hc=;
 b=f0+6JMUw+IRWeViVscC1hVebq0wxauupTv6mpW5YzKFKlW2/jsKp5WM0IA/QJPjU2rKXUO0OmGZ8Tdh6OhlHqN1cMFjd/Jyv/+WDMeh9Q6J92izwBvalnsWPAkgCY4f7BjK5X09qblrBU72cT3iigATtw9Kkmnl62wevTrovJTweJZVjXOUOLQbceLqlBblynZjbntYvBZjM0hDn64cFDo6TwqxlXPeAdGlIl8R00usXkUo1yGMiIkp5yUGVaerKLVK/6pdpaYVoJiVsV19WVS2zlgYT7qbSEQN13R08m0Xlgjiuw0Y6SdXxrfODur82kOMglyRepOg34gn/ikke8w==
Received: from BN9PR03CA0180.namprd03.prod.outlook.com (2603:10b6:408:f4::35)
 by CH3PR12MB8403.namprd12.prod.outlook.com (2603:10b6:610:133::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Fri, 29 May
 2026 21:52:18 +0000
Received: from BL6PEPF0001AB75.namprd02.prod.outlook.com
 (2603:10b6:408:f4:cafe::55) by BN9PR03CA0180.outlook.office365.com
 (2603:10b6:408:f4::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Fri, 29
 May 2026 21:52:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL6PEPF0001AB75.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Fri, 29 May 2026 21:52:17 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 29 May
 2026 14:51:54 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 29 May 2026 14:51:54 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 29 May 2026 14:51:53 -0700
Date: Fri, 29 May 2026 14:51:52 -0700
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
Subject: Re: [PATCH v6 4/6] iommu/arm-smmu-v3: Standardize ATS enablement
 failure reporting
Message-ID: <ahoKeEmFhU8nWV3P@Asurada-Nvidia>
References: <20260529111208.387412-1-praan@google.com>
 <20260529111208.387412-5-praan@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260529111208.387412-5-praan@google.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB75:EE_|CH3PR12MB8403:EE_
X-MS-Office365-Filtering-Correlation-Id: 3862e659-4dbb-45c4-5c13-08debdcc8db0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|7416014|1800799024|82310400026|13003099007|6133799003|11063799006|56012099006|18002099003|22082099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	K754dz/WLT0cIkY2qP+mPT+BEgTmAhNv7g/J6vRemDRttLrteMrFsiUDrXCaSb6Nhh0ie776LGbrIkl3YJSlrQ0oxdqG+stjFynEunD/Wm9ukyXFJqsTwsClwYyweh/il2wRYmMipI+/JP+rc0DUsPz5rf+nTHSE89N4THU6MbPo4crCipvrvCNWx3r+uJj0nuAM5q6guSzmN486WEdjjA7F84cxCNzgIUVj51AxD35lpQ6SQNdnHTVxuR1kBWsD34CT42wsSp1ElX6mFcKq0sg42mvJiFYRhIDGhJPgKx4uy86Vv6CMQ8zwrxw9lTFoE195c9cJGE4Pw9PLot4wI9rvCD/t94ddnhpTmqXMzALMa0/b2e/vff1C04IhoxCCzwyyXME1wHW62tS7L7cq9cI62ujt2wi1tkZWVmfvfiLSndczLEY6QmzWJ4QODdx5emDMInuY465dmql2Tq+dyJNcamV9jGnd4AMyXchkWPoUPC2cOkfSWNZQcDkpdT/5UKMz1iChwyyRhORqrhyUZt5AtfDcC9/PSLeuAM6fjyjzEhZqbwByVJziSW8WdcRZATrYVDHd9bwTfQbxC8UPMTsorfHv9cc3Nk9qNJeUq9BW5CdlFO0FBDQe4nIFmRlhlqdPAyq4kzg9kNPFaBJdjjasfCxIaj+7oc/VLP1H+IzmuPrK2HE5nIOQ8kVd3uGuDNmGsJFKVzb4w+Q58AR2IudwUy/Lqnv3AiiU5/RaTU8=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(7416014)(1800799024)(82310400026)(13003099007)(6133799003)(11063799006)(56012099006)(18002099003)(22082099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	7uzzJPdOgp5ycc7IWCuep/0R/8RhgoLPnA60YFepj94Cx3bipTyaNkVLSH5RBSizbIjBlVXdQZlpfY8NVcNlP9mMHUVBV/BeGMNTbMdptxBuLRFcbSZbqhBAJqUTtEszxDySWwv9u5TyQNwAPeIuZOajmMVzqKMeHmb20BLhUpAuJWgmGFudLkZ+1cG0NnuptXm+RDwR8RIeIsLn6A8EaTooGugOhxTZvtLf+WohB5AEMYqxIYsBxlNzI7gvrz8HEcdJqpSM/h3bR14fNkoaK/ajc1n416h+vqELYmPDDpE1K2pyoHvN/tqPxrmiCMHI417DD3cWZrQuj6kH6IiWl8JHBzqV55zuTuQBMQeFONL2z7tuNM/qYmtaL+qYt7ncLltMcCxa8hhXK1cPyWCUUS/0ayaOyjjnKwX8d0slO6g9nmShQ4piqpy2yGw2zSc2
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 21:52:17.9385
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3862e659-4dbb-45c4-5c13-08debdcc8db0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB75.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8403

On Fri, May 29, 2026 at 11:12:06AM +0000, Pranjal Shrivastava wrote:
> The SMMUv3 driver currently has a two-phase commit in its ATS enablement
> flow. During arm_smmu_attach_prepare(), it predicts whether ATS will be
> enabled using arm_smmu_ats_supported() and accordingly increments
> nr_ats_masters and merges ATS invalidations into the domain's invs array.
> 
> However, the actual hardware enablement via pci_enable_ats() happens
> later in arm_smmu_attach_commit(). If this call to pci_enable_ats fails,
> the SMMU driver's ATS state tracking remains polluted, i.e., the driver
> tracks ATS as enabled on a master that is not actually using it. This
> leads to an incorrect nr_ats_masters and triggers a warning in the PCI
> core during detach:
> 
>  1 [  127.925080] ------------[ cut here ]------------
>  2 [  127.925084] WARNING: drivers/pci/ats.c:132 at pci_disable_ats+0x94/0xa8
>  3 ...
>  4 [  128.068169] Call trace:
>  5 [  128.070603]  pci_disable_ats+0x94/0xa8 (P)
>  6 [  128.074688]  arm_smmu_attach_prepare+0x104/0x310
>  7 [  128.079292]  arm_smmu_attach_dev_ste+0x128/0x1e0
> 
> The issue was exposed under heavy load when running a VFIO-based DMA
> map stress test (iova_stress).
> 
> Following the addition of the arm_smmu_master_prepare_ats() [1] helper during
> device probe, failable ATS configuration (STU setup) is now handled early
> during probe. This ensures that any master reaching the attach phase is
> guaranteed to have a valid ATS configuration.
> 
> Update arm_smmu_enable_ats() to use the WARN() macro for any
> subsequent enablement failures during the commit phase. Since probe
> checks now preclude software configuration errors, any failure here is
> considered a kernel bug.

The commit message feels like mixing a stale background and the
real requirement (based on the latest code line). Could that DMA
map stress test still trigger the WARN_ON in pci_disable_ats(),
after having arm_smmu_master_prepare_ats()?

It'd be nicer if the writing can be simplified a bit.

>  	arm_smmu_atc_inv_master(master, IOMMU_NO_PASID);
> -	if (pci_enable_ats(pdev, stu))
> -		dev_err(master->dev, "Failed to enable ATS (STU %zu)\n", stu);
> +
> +	/*
> +	 * Any failure at this point is a kernel bug. pci_ats_supported()
> +	 * and pci_prepare_ats() have already verified the hardware capability
> +	 * and programmed the STU. Thus, pci_enable_ats() should not fail here.
> +	 */

The patch that removes pci_ats_supported() from pci_prepare_ats()
is dropped in this v6. So, my previous comments may stay true and
the two lines can be enough?

 	/*
 	 * As pci_prepare_ats() have already verified the hardware capability
 	 * and programmed the STE, pci_enable_ats() should not fail here.
 	 */

> +	WARN(pci_enable_ats(pdev, stu),
> +	     "Failed to enable ATS (STU %zu)\n", stu);

https://sashiko.dev/#/patchset/20260529111208.387412-1-praan%40google.com
Please check Sashiko review (for other patches in this series too).

I think it'd be cleaner to just have:

-	if (pci_enable_ats(pdev, stu))
+	if (WARN_ON(pci_enable_ats(pdev, stu)))

Nicolin

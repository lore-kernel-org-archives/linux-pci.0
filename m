Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012064.outbound.protection.outlook.com [40.107.200.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30135334374;
	Mon,  1 Jun 2026 06:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780293635; cv=fail; b=RQ2qkcWYQbS5xL/pUduPf7J1YE5YceLMxigO3kY6XR2WFqmbLEx/BkLVhIVHPfou28WZvnqjK4+HvYockpl408lJq8cukO/CDN0a9Ze2KP8PmiI8r7xbkhQxYjzOr8L9BtRak+y8Uolyq1oPciC7oZQsKyIdq0DBkc25LAXo4Ow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780293635; c=relaxed/simple;
	bh=yVywrEGQIlfd20B0kZDe351eZzrVez+/5RfUPyEtwEM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BdtN2nA/gfSSvVf1MncY4au+IDxGGa6OhCIf7jNyR7f6p4whO3DsJzB4Xs/j8Z7ZvlnLxrFWnqKhuvxeneTGi065I2yDkUEo8eTO6mhcTOr8eeWWSK9syNYFyuh0g+fEwU+dyjZ5+hbxTwkJFumePDeVI1HYSXNM4g62/1cSwt4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Tk0Aww9w; arc=fail smtp.client-ip=40.107.200.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Tk0Aww9w"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ANJNxC05UaOn8OF70vbUjdi0imfkOk7uK6VCyttLaFaCeME52/EB7XC99gq/njcBg/j0xTEQ7N9nv92WsdKptWWihwA/35AOi38XQBNTi0F+LFN7eCKeJx+Rqo7PAC47trngikNqreL9Q6HDoZl+aAB7XDL2NRKjqT+sKixDJvsYDkxvWFvXHB/Yz85vWT6BFIXSV9ogbOH7cj9kLN2/jmMLrU+mZ2L7num3c9tCBwe8fzhMtOhpvY2HGLU1znwFs6/tvRrUrP5aI1AZpFMCAks9K8pJVAp6AnOFW98g4YuBQMc49mxbCJ3VwgAkEF7vlSMDZWub5HnIhjClhfs/uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VxCZADAd+XREcoFQpsPm53rlCtvs9Z1bnuL5QFg3aSY=;
 b=C0QBTo6aHhneFskcfMJhCxvc8T/ELyLXaetErjDxS0aV6ENKTGH0bXMyr17YvIHXfoA+A1r88eWtUbYZRNIQKJiwgUyCVyiJXW+pEc3sfiRpE/NwxPTgcUuZJhlkhn+RFGmf1ezyLTGHygqsw2BX0T3GyYmfFbUmF+Ow/TtpYPtNLIbOOWiqvkr9Rkqf4ZMkIE58gMQujcyqIbbNsWSMANF54N1YsM2o4cizk2BH4s1QAByewdEQuu2G0dzHbXU7ibzrZcQDBm/a9SX6rR0kIdL5ZJOpVNsJPD2X9wYbZ9M1tkNH36773pPvKQ67M5cd7SFqwRuXsc8l95s7hvv9qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VxCZADAd+XREcoFQpsPm53rlCtvs9Z1bnuL5QFg3aSY=;
 b=Tk0Aww9wmus56ceYpo5qmXwC+dAAOiM/nwXxBjXhU2nWPdRuPxLdO5Etjuykjvwf/qFwwCefD0qGmG/uKgM5NkuCwAnSqEx3bFFx+msKlESdwCHj/XlEneW6D1aHCcH6RvsovwdoNO/DSu1Ebdv7qqFn2VP9QaQQCuA7JQMHdtw=
Received: from DS1P221CA0028.NAMP221.PROD.OUTLOOK.COM (2603:10b6:8:242::15) by
 PH7PR12MB5734.namprd12.prod.outlook.com (2603:10b6:510:1e1::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.16; Mon, 1 Jun 2026 06:00:27 +0000
Received: from CH3PEPF00000013.namprd21.prod.outlook.com
 (2603:10b6:8:242:cafe::90) by DS1P221CA0028.outlook.office365.com
 (2603:10b6:8:242::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.18 via Frontend Transport; Mon, 1
 Jun 2026 06:00:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH3PEPF00000013.mail.protection.outlook.com (10.167.244.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.0 via Frontend Transport; Mon, 1 Jun 2026 06:00:26 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 1 Jun
 2026 01:00:25 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 1 Jun
 2026 01:00:25 -0500
Received: from amd.com (10.180.168.240) by satlexmb07.amd.com (10.181.42.216)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Mon, 1 Jun 2026 01:00:20 -0500
Date: Mon, 1 Jun 2026 06:00:15 +0000
From: Ankit Soni <Ankit.Soni@amd.com>
To: Pranjal Shrivastava <praan@google.com>
CC: <iommu@lists.linux.dev>, <linux-pci@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>, Joerg
 Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, "Bjorn Helgaas"
	<bhelgaas@google.com>, David Woodhouse <dwmw2@infradead.org>, "Lu Baolu"
	<baolu.lu@linux.intel.com>, Robin Murphy <robin.murphy@arm.com>, Suravee
 Suthikulpanit <suravee.suthikulpanit@amd.com>, Jason Gunthorpe
	<jgg@ziepe.ca>, Nicolin Chen <nicolinc@nvidia.com>, David Matlack
	<dmatlack@google.com>, Samiullah Khawaja <skhawaja@google.com>, Daniel Mentz
	<danielmentz@google.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, Mostafa
 Saleh <smostafa@google.com>
Subject: Re: [PATCH v6 6/6] iommu/amd: Fail probe on ATS configuration failure
Message-ID: <unqzyef2n26wdf6tmc6vvwvpsgv244uvz7cxji4scymqmoofyb@trkzr7ix5bog>
References: <20260529111208.387412-1-praan@google.com>
 <20260529111208.387412-7-praan@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260529111208.387412-7-praan@google.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000013:EE_|PH7PR12MB5734:EE_
X-MS-Office365-Filtering-Correlation-Id: e1ab607c-2b61-4697-53f7-08debfa31382
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700016|82310400026|6133799003|22082099003|18002099003|11063799006|4143699003|5023799004|56012099006|13003099007;
X-Microsoft-Antispam-Message-Info:
	SdIgMHKw/P2Rphjt5gLFd5nsWC0L0MVmbnEyj9njVlooMUgHmv0INA6TZzv8ZcoEiUxd45E4/Gdf1Tu5Id2JvVsp2hMy2XF3PfvlZWwhkzEuKGZoF579R+ESqRd0uh0Yu0fwHwfSOcBmoL6iU2Ti72S5T5wr/zaNXhlI49xv/yUdP/CVMm6vnNoneFCpXBdy8kjzmzXROy8lfThHrGeeC4rBJmQJFUYaxD6oOXWO8ObdOOrM/PLxCiSD6ESLM6oq6EhNjNxK2wxtp2zttnjMqFd4l/4wWYL5a9heFaPMaUwcTBZJsh/YSZlSjJNL3UR5vBzf46KYDPMqNPpyW+6uXVGizPpHfQRkISce3hCCg1vb8X0nRhr/FB5Eac8lme3+ch3kt4RruGN0GuSn+l/0/Hcl7dX6kFRFOi88Ma/qfF7GnuUhjC/RO1+XPCBMGCxmrlt6/931ZAB4z8TP/2EeN0WWGt9D4qYLMLa8/XpsSoOAzp9UHg4mvJnqzY9t/nwPnQcHt7f3NLOOYWYsDUFUnhNCzfh1aBGrZ3OcEv0kXdAUMjHHaeffmz2xedt1FazRy4Xst0rEygqd6Saqz4BJtrkfblKli+d1S7E8QGmqHo03moGU0LPaJmCninrU1+IJZsgm5/+bQ2fhGYbblhcrf0KnPrhHR1ilU/DglNRWqgftTqZrUsHJ9MAp79oO7vT/Kunfo0TPElwSGPccHLm7t/1dR0uf/5si2udrG4xHNz1LUB6+NUnkzqRq+DBDMsO7
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700016)(82310400026)(6133799003)(22082099003)(18002099003)(11063799006)(4143699003)(5023799004)(56012099006)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ICPZV7EvLJdmwerwwXQF/FcVklmtfW7Z/ywAQdV+nRQl67X3E3L8kNNl2ZeGuXYOG0azqERzxmHIwZ1PsDxL6erlPtdljfyN31vkg6orcq+uCr4wpCW0SdVbwj1EK2Q2YIvaTOeeExNX7sFk/8AJ8DOlLN0eWDduYiIRhawYllZEIPLtklg4muWRLU87u5mh4KSs8IoNv3xQ5Vgf5TaRpZiKN9e14E3iGbxeBGVvj1oV9WozvgG3Kfg4jFyj9CeRnonDplrxb1GHuIuuWz7Ta0p/nME9FMnH3QQGYmVln41vdxZMPw2wfJlxe58dE+++qaPM2AyBA5t4YCLHFGSgCns6jnp/AY9sCUMwU5Ju+Ke3w/bDEAFN14/knVg2Aa4H6o0iOlcq7PmIPUPse3eGJcMo4c2bctlFeVVLg3HdpBzCDhkneXOJaSc2qk7HoN3k
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 06:00:26.0472
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1ab607c-2b61-4697-53f7-08debfa31382
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000013.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5734

On Fri, May 29, 2026 at 11:12:08AM +0000, Pranjal Shrivastava wrote:
> Update the AMD IOMMU driver to handle ATS configuration and enablement
> more strictly. Specifically, update the device probe to fail if
> pci_prepare_ats() returns an error. This ensures that any ATS-capable
> master reaching the attach phase is guaranteed to have a valid config.
> 
> Additionally, update pdev_enable_cap_ats() to WARN_ON() if pci_enable_ats
> fails. Since earlier checks in the probe phase preclude config-related
> failures, any failure during hardware enablement is considered a kernel
> bug.
> 
> Fix a pre-existing Use-After-Free risk by ensuring iommu_ignore_device()
> is called on all probe failures after iommu_init_device().
> 
> Signed-off-by: Pranjal Shrivastava <praan@google.com>
> ---
>  drivers/iommu/amd/iommu.c | 30 ++++++++++++++++++++++++------
>  1 file changed, 24 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 84cad43dc188..b74c4504bee3 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -570,10 +570,16 @@ static inline int pdev_enable_cap_ats(struct pci_dev *pdev)
>  	if (amd_iommu_iotlb_sup &&
>  	    (dev_data->flags & AMD_IOMMU_DEVICE_FLAG_ATS_SUP)) {
>  		ret = pci_enable_ats(pdev, PAGE_SHIFT);
> -		if (!ret) {
> -			dev_data->ats_enabled = 1;
> -			dev_data->ats_qdep    = pci_ats_queue_depth(pdev);
> -		}
> +		/*
> +		 * pci_enable_ats() should not fail here because earlier checks
> +		 * have already verified support and configuration.
> +		 */
> +		if (WARN_ON(ret))
> +			return ret;
> +
> +		dev_data->ats_enabled = 1;
> +		dev_data->ats_qdep    = pci_ats_queue_depth(pdev);
> +		ret = 0;
>  	}
>  
>  	return ret;
> @@ -2502,10 +2508,22 @@ static struct iommu_device *amd_iommu_probe_device(struct device *dev)
>  	else
>  		dev_data->max_irqs = MAX_IRQS_PER_TABLE_512;
>  
> -	if (dev_is_pci(dev))
> -		pci_prepare_ats(to_pci_dev(dev), PAGE_SHIFT);
> +	if (dev_is_pci(dev)) {
> +		struct pci_dev *pdev = to_pci_dev(dev);
> +
> +		if (pci_ats_supported(pdev)) {
> +			ret = pci_prepare_ats(pdev, PAGE_SHIFT);
> +			if (ret) {
> +				iommu_dev = ERR_PTR(ret);
> +				goto out_err;
> +			}
> +		}
> +	}
>  
>  out_err:
> +	if (IS_ERR(iommu_dev))
> +		iommu_ignore_device(iommu, dev);
> +
>  	return iommu_dev;
>  }
>  

Hi,
This regresses IRQ remapping in the PD_MODE_NONE branch. By design
rlookup_table[devid] must stay valid for IR - init.c:2257 documents
this: "Do not return an error to enable IRQ remapping ...". Pre-patch
the PD_MODE_NONE branch returned ERR_PTR(-ENODEV) without nulling
rlookup, precisely so irq_remapping_alloc() / __rlookup_amd_iommu()
keep working; this unconditional cleanup violates that.
The new pci_prepare_ats() failure path has the same shape:
amd_iommu_set_pci_msi_domain() ran earlier and parented dev->msi_domain
on iommu->ir_domain, but on this new out_err that's not unwound. So
nulling rlookup_table[devid] makes irq_remapping_alloc() return -EINVAL
on the first MSI alloc for the device. Sashiko also flagged this in [1];

Also if iommu_init_device() branch fails, iommu_ignore_device() will be
called twice.

[1] https://lore.kernel.org/r/20260529153216.2AD1E1F00899@smtp.kernel.org

-Ankit

> -- 
> 2.54.0.823.g6e5bcc1fc9-goog
> 

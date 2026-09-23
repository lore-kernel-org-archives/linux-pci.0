Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010001.outbound.protection.outlook.com [52.101.201.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B329A4779AA;
	Wed, 23 Sep 2026 21:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790199646; cv=fail; b=KhQo2PQawsyDhpJ5S+eePA80SkWro0VtKa8o5TjgDvbzsNor0rwIlrNW3vdrnPWVaRh5rUodqHO1kTNTd69kGa+FYF5x+urQuxE912N5tXeiOlj3K1MYWnRw4f4lnum164bpREVmijwWW2g3q1k2xtyHztpP01sK2BYFREo/U18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790199646; c=relaxed/simple;
	bh=Jpo4bLFLFSnfVE0TPwCL0CS6SYhgiEsV1Ep77vcf7cU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=FoR2EqrH9eHscMjcZ9dNcs5iI5Q/KKL7HgWK5KKS3RAR/95UX45exSCWXdvE6gUVoYDuMG+J3HZn2OMOIqALiv8PWBdXBkN4splMnD2QlJLL9TbzuF0LUrc1yHpBrh5mc8gohooWId9eTdjCaV26ieoM8YZEbZIBxxm8s0nrMfg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mMFYGxc2; arc=fail smtp.client-ip=52.101.201.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mMFYGxc2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VpaGAnei8WmiLX0B7XoLaQxw5GIi/7GdEsNnJJfsdj8jnPWeMtkS0YV8PvUKpAEHSmPAMM+SDnRlRc2XVvgnowt8pQU4mchTbq3s09xspZzQnk9IIXnD5j7ZUScVoWgXjpY2jTX6EhPuLjwhD7qdise385YdSJ9ps4wB3b21baM096CMM/vMiES4OxpvRKhaHbYefukSZy2KIyhO+QL3WBWxjzDESZ4S/tAgWJuH2bsYTsSFmkNdeB0Sf4Zyqq51M3GG0RwWvkWCUX/eBsYPjuJo/xSL/lkcBPZr9Vgf2AND8jUSBhij/LcX8bavdJpgtmSL7kI4vCmZ1RKvI5GRhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n8Btu48LpRchI2bh+HyIENatkK440gTPqenig5/tRu8=;
 b=GBVH6on5HuCufgQV9FXQvk1uxggFyF1dFhZp4eXn6IuISs5goZnLALBHTiIEXTd0MOCUKipMONIIDR40JR3EgrynzK4tI/YQ+CmU7IA/0WAqdYoy8JpAqTgvilq9IAuCuWAQrDI2/DfrYVphs7VVLBB9cFzNBC78rMOIJQ09Q89LtslECIA8xK0RL0dMje0LBaP8poiNS+EOxLKncURZXKqyrWqtvqFnhUAXo2o65W6PJO+oZnLREENTcufAGKrI5GuxY1sIq+1tglnOes1XCHCibYRKGWPXJAjHTCKywXZqwZMpAGPx3qeQb6KTfz4fIVnMKMzTC0kVVbRJtInUzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n8Btu48LpRchI2bh+HyIENatkK440gTPqenig5/tRu8=;
 b=mMFYGxc25GPOaALmqYtd4oHfNG5+ws3iH6KNHNGz7MvHnL13x8KUc0xFzJieQjs/oXvFuWkAoxgEZlmp6r4vl0cw5dWdqHP/6T18TILj+i6gHRJw+8Ry45LSSeJO7f94dbceqZkYXRdHLi6Mz8yot0fNILGXekeiiQOns769PdE=
Received: from BY5PR03CA0012.namprd03.prod.outlook.com (2603:10b6:a03:1e0::22)
 by DS7PR12MB8203.namprd12.prod.outlook.com (2603:10b6:8:e1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.17; Wed, 23 Sep
 2026 21:40:40 +0000
Received: from SJ1PEPF000037AB.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::1c) by BY5PR03CA0012.outlook.office365.com
 (2603:10b6:a03:1e0::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Wed,
 23 Sep 2026 21:40:39 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000037AB.mail.protection.outlook.com (10.167.244.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 21:40:39 +0000
Received: from [10.236.178.170] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 16:40:32 -0500
Message-ID: <2c37c82b-8db6-44d1-868b-0b98bae57459@amd.com>
Date: Wed, 23 Sep 2026 16:40:31 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v13 08/15] cxl: Refresh cached PCI HDM decoder settings
To: Srirangan Madhavan <smadhavan@nvidia.com>, Alison Schofield
	<alison.schofield@intel.com>, Bjorn Helgaas <bhelgaas@google.com>, Dave Jiang
	<dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny
	<ira.weiny@intel.com>, Jonathan Cameron <jic23@kernel.org>, Vishal Verma
	<vishal.l.verma@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Alex Williamson <alex.williamson@redhat.com>, <vsethi@nvidia.com>,
	<alwilliamson@nvidia.com>, Sai Yashwanth Reddy Kancherla
	<skancherla@nvidia.com>, Vishal Aslot <vaslot@nvidia.com>, Manish Honap
	<mhonap@nvidia.com>, Jiandi An <jan@nvidia.com>, Richard Cheng
	<icheng@nvidia.com>, <linux-tegra@vger.kernel.org>
References: <20260922083924.2451158-1-smadhavan@nvidia.com>
 <20260922083924.2451158-9-smadhavan@nvidia.com>
Content-Language: en-US
In-Reply-To: <20260922083924.2451158-9-smadhavan@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037AB:EE_|DS7PR12MB8203:EE_
X-MS-Office365-Filtering-Correlation-Id: b5c95039-d9ad-4a25-6df9-08df19bb4fe0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|23010399003|36860700016|921020|4143699003|56012099006|11063799006|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	Pl9WpPayC25FTjigeBLgY3dbpw4Oupix+QpCDxT14YvQYpZRFAviLZc5q8bVp5+JY9Lwm2L0Ni9hPpjP5rDGCzz1ej7XuxMxh2+1f0BCdNWGG4nKbINX/xYR5WL6+FK7hjTkxs6CziwNj6/mdgNnhvK8AEzGNXfeI4jSegXvQS/1FCCCLaCotH8Nk/0+u/NpLiVunpKrgxeDXciGS9Zg5CV3JiaM0OLnW6zCu21QInizRl13J99HEYUq8PADbOFjPR/0Mi+8U5BPWAIgD4fyZvN1KSLQCLYmbe3BRfz0Xaym8K3iLxqo5hZJtZmqzgw5IJwsOTE+sRJUlwFrskpzPAik/L0xItL2Y0upsab2S0yqwxYHQiIb+AwEKj/pmNP4dfVkBrUDrTcJe3ho7+A436IyaRK6PWphKij+jCtK5k77NPcWuWjZXjac5fXW2Ci9MpSDy5zUp1/iwGrfq4qTT7qcdNu0J7knfSi85wSPdsyKHmPWdcHqyKjQ3giKDgIqusYUFy06Ps6MMgbnE1m4k7Ls+MYccWwJCkkOznGUyBo8MeM5+kTuZaYijeCZHPMz3bL8eSsfSe0UP+ycH6rAReu7SviXRhwtY4iv2uHI+V2UaXnahWr46XduL8G5V8dDQcwLDrObm2HM6LjCnsF7x9CGsR5NSUf274mGHaQ35C8CsVsdjOn+LNVtMlCu3Hzs1KtPxuH80w00gFhgbIJC61bgQLuO+RWTNj6+P70NRS3flUfIjrlLU42HS1NZWFco
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(23010399003)(36860700016)(921020)(4143699003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	udK8ZDQ7Kbbi4OLqwu05rmU1IU8LNekZQmIjj/YEkVonTWSyCzqDY9Pz49GZNaiv5K0Ahz4ruzIpzok9sBtRfJkGvHjqoasgHaozWq0nmI+cA2+4KJ6LX/Nig7FRBSUecEaIVOXCOKcFiDxtjFLV4TSyvardPYu9DtnyTs3NrOOj0Q2g09uoQkzMv8a1xI4ah3n525Hxj8JmsWiSrwjACPhSBAhqOILxyAgSz8gRSoY3ItjrluZI8swrW+QPMwCrRW/0XmoSrRcgDXnGTnxd1TlgK6ouxSm+mTZHMG7VEuLMqSiK13BkCAJi1vio14dMmV/OyJ6L2H+S9CrABjfpyyZjpixfttmDjmJMUzCs4xbvw+Umm80DaP4iKh+Yexyw8wBplKE3UT4dniOCuPdLIhknpPDPfRbHKJR6kEj+uo33WroetHP7vY/P5cJixsez
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 21:40:39.8316
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5c95039-d9ad-4a25-6df9-08df19bb4fe0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000037AB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8203

On 9/22/2026 3:39 AM, Srirangan Madhavan wrote:
> Early PCI discovery creates the HDM cache, while later CXL enumeration and
> decoder operations provide updated programming state.
> 
> Refresh the PCI snapshot when decoders are enumerated, committed, or reset
> so reset recovery need not walk the CXL topology. Ignore updates when no
> cache exists and reject decoder-count mismatches.
> 
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> ---
>  drivers/cxl/core/hdm.c | 66 ++++++++++++++++++++++++++++++++++++++++++
>  include/cxl/cxl.h      | 22 ++++++++++++++
>  include/linux/pci.h    |  6 ++++
>  3 files changed, 94 insertions(+)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 98268e8e15b2..0ae250ea4ce3 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -753,6 +753,51 @@ static void cxl_decoder_snapshot(struct cxl_decoder *cxld,
>  	}
>  }
>  
> +#ifdef CONFIG_CXL_RESET

The CXL maintainers are normally pretty against #ifdefs in c code. I was going to suggest
moving it to resource.c, but it looks like cxl_decoder_snapshot() needs to also be in this
file. So, I think the fix is to put:

if (!IS_ENABLED(CONFIG_CXL_RESET))
	return;

immediately after the variable declarations.

> +static void cxl_hdm_refresh_decoder(struct cxl_hdm *cxlhdm,
> +				    struct cxl_decoder *cxld)
> +{
> +	struct cxl_port *port = cxlhdm->port;
> +	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
> +	struct pci_dev *pdev __free(pci_dev_put) =
> +		cxl_port_get_uport_pci_dev(port);

This line needs to be at the first usage, i.e. right before "if (!pdev || !hdm)" below, to prevent
lifetime bugs.

> +	struct cxl_decoder_settings *settings;
> +	struct cxl_hdm_info *info;
> +
> +	if (!pdev || !hdm)
> +		return;
> +
> +	guard(rwsem_write)(&cxl_rwsem.dpa);
> +	info = pdev->hdm;
> +	if (!info)
> +		return;
> +	if (cxld->id < 0 || cxld->id >= info->decoder_count) {
> +		pci_warn(pdev, "CXL HDM decoder %d exceeds cached count %d\n",
> +			 cxld->id, info->decoder_count);
> +		return;
> +	}
> +
> +	info->global_ctrl = readl(hdm + CXL_HDM_DECODER_CTRL_OFFSET);
> +	settings = &info->settings[cxld->id];
> +
> +	/*
> +	 * A disabled decoder's software object may retain its old range and
> +	 * target state. Leave only the decoder id in the cached settings so stale
> +	 * state is not restored as an enabled decode.
> +	 */
> +	*settings = (struct cxl_decoder_settings) {
> +		.config.id = cxld->id,
> +	};
> +	if (cxld->flags & CXL_DECODER_F_ENABLE)
> +		cxl_decoder_snapshot(cxld, settings);
> +}
> +#else
> +static void cxl_hdm_refresh_decoder(struct cxl_hdm *cxlhdm,
> +				    struct cxl_decoder *cxld)
> +{
> +}
> +#endif
> +
>  static int cxl_decoder_commit(struct cxl_decoder *cxld)
>  {
>  	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
> @@ -804,6 +849,7 @@ static int cxl_decoder_commit(struct cxl_decoder *cxld)
>  	}
>  	port->commit_end++;
>  	cxld->flags |= CXL_DECODER_F_ENABLE;
> +	cxl_hdm_refresh_decoder(cxlhdm, cxld);
>  
>  	return 0;
>  }
> @@ -876,6 +922,7 @@ static void cxl_decoder_reset(struct cxl_decoder *cxld)
>  	writel(0, hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(id));
>  
>  	cxld->flags &= ~CXL_DECODER_F_ENABLE;
> +	cxl_hdm_refresh_decoder(cxlhdm, cxld);
>  
>  	/* Userspace is now responsible for reconfiguring this decoder */
>  	if (is_endpoint_decoder(&cxld->dev)) {
> @@ -1089,9 +1136,27 @@ static int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
>  {
>  	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
>  	struct cxl_port *port = cxlhdm->port;
> +#ifdef CONFIG_CXL_RESET
> +	struct pci_dev *pdev __free(pci_dev_put) =
> +		cxl_port_get_uport_pci_dev(port);
> +#endif

This shouldn't be here, and if you move it to be inside the below if statement
then you won't need the #ifdef as well.

>  	int i;
>  	u64 dpa_base = 0;
>  
> +#ifdef CONFIG_CXL_RESET
> +	if (is_cxl_endpoint(port) && pdev && hdm) {
> +		guard(rwsem_read)(&cxl_rwsem.dpa);
> +
> +		if (pdev->hdm &&
> +		    pdev->hdm->decoder_count != cxlhdm->decoder_count) {
> +			pci_warn(pdev,
> +				 "CXL HDM cache decoder count mismatch: cached=%d hdm=%d\n",
> +				 pdev->hdm->decoder_count, cxlhdm->decoder_count);
> +			return -ENXIO;
> +		}
> +	}
> +#endif
> +

Add IS_ENABLED(CONFIG_CXL_RESET) to the above if condition, like above.

>  	cxl_settle_decoders(cxlhdm);
>  
>  	for (i = 0; i < cxlhdm->decoder_count; i++) {
> @@ -1130,6 +1195,7 @@ static int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
>  			put_device(&cxld->dev);
>  			return rc;
>  		}
> +		cxl_hdm_refresh_decoder(cxlhdm, cxld);
>  		rc = add_hdm_decoder(port, cxld);
>  		if (rc) {
>  			dev_warn(&port->dev,
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 1acdf537e4e9..005259e38f4b 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -77,6 +77,28 @@ struct cxl_decoder_settings {
>  	u64 target_or_skip_reg_val;
>  };
>  
> +/**
> + * struct cxl_hdm_info - cached CXL HDM state for a PCI device
> + * @decoder_count: number of entries in @settings
> + * @hdm_bar: PCI BAR containing the HDM decoder capability
> + * @hdm_offset: offset of the HDM decoder capability in @hdm_bar
> + * @hdm_size: size of the HDM decoder register block
> + * @global_ctrl: HDM decoder global control register
> + * @dvsec_ctrl: CXL DVSEC control register
> + * @dvsec_ctrl_valid: whether @dvsec_ctrl contains valid state
> + * @settings: per-decoder programming state
> + */
> +struct cxl_hdm_info {
> +	int decoder_count;
> +	int hdm_bar;
> +	resource_size_t hdm_offset;
> +	resource_size_t hdm_size;
> +	u32 global_ctrl;
> +	u16 dvsec_ctrl;
> +	bool dvsec_ctrl_valid;
> +	struct cxl_decoder_settings settings[];
> +};
> +
>  /*
>   * Using struct_group() allows for per register-block-type helper routines,
>   * without requiring block-type agnostic code to include the prefix.
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index d31a8d107b1e..7bb37fcb556d 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -339,6 +339,9 @@ struct pcie_link_state;
>  struct pci_sriov;
>  struct pci_p2pdma;
>  struct rcec_ea;
> +#ifdef CONFIG_CXL_RESET
> +struct cxl_hdm_info;
> +#endif
>  
>  /* struct pci_dev - describes a PCI device
>   *
> @@ -566,6 +569,9 @@ struct pci_dev {
>  #ifdef CONFIG_PCI_DOE
>  	struct xarray	doe_mbs;	/* Data Object Exchange mailboxes */
>  #endif
> +#ifdef CONFIG_CXL_RESET
> +	struct cxl_hdm_info *hdm;	/* CXL HDM decoder state */
> +#endif
>  #ifdef CONFIG_PCI_NPEM
>  	struct npem	*npem;		/* Native PCIe Enclosure Management */
>  #endif


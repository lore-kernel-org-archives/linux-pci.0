Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011056.outbound.protection.outlook.com [52.101.57.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBEA5423EB7;
	Wed, 23 Sep 2026 21:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790199655; cv=fail; b=k0j/nbTIcGsnS9GifjcNYGe6wHqANU8FQV16v5WcHhUseVuFcRRrdgFnW0o9iKwwJfymqRQSA4FNSCTEVw3HaqqaOtCxw+btBDzBX0EmzlkbxVzyZopt1B3k0m7Q4fReBAwrI1A6zGbGV4myT4QrYV/Zii0Pcspwr0ksMANDKNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790199655; c=relaxed/simple;
	bh=Si/vAen5FrLc1/V23TnAbFVyoxfXkb62MgWZttYYcco=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=t440RTLHtdbFAzgSyu3p/Ur6S0CKjnXnMxcwQuAV9wpLGk9odUFiVS+WQcjn0P+yT1zGs6UpTrKn29FOFZp6eS1TZ6eOzkY5Gaeg5GuYM1y56arQd54lPFCdx4ZOrLS+ENL3Xt9BWWj0C1vU1YxcXU29+J7/EVmJ2l0WOYpzg0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DLmB312i; arc=fail smtp.client-ip=52.101.57.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DLmB312i"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K1jEqLcvmGPX4PAGbt/ZS4Qjrf276oI/SdklpC0BQfB85GFogRDJr5WkeyD1bELdF5qbRNXBHqh3aKGTrqaoMvKvF6V0uIeZ5PJhqNEs08ZD81v3jQbogjZa84oIaso6FBRlB9nEMzgZTJI4JHfyJ2H6l3gKCv2J8lVqXi3fjtKaDjJl1IfLWrLw10mlLoUHo1TuFqpwjJ565b7Pos32nKatr6C6Hr4pguecw3RH7D+AH3GpkVcxA5QVESOl6evN4VcXn7hS8f9gY9vSszdfrza4FVNY1iP5Ygu1U9gWWDoplMiczI7YY5wPvsuqPcYXlyYbQuKTYcJB3DbfNklC+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FgGnPq73XifySuBgQglBddFnGXS7TGGFZPy0g25aOS4=;
 b=pWgr3kJbG586y8LboWG1tEcMy0xFm+XHstrBUegqyvguBIEwCbioTlji0KYkF/GM22faTTUy8UgCLQW+jS4WdDY6kFdc3M8UR+8ZgUWf4V0ho3nSbR3ZkDB/F3irmxmuRat/CnXcMOs1w0wtWV/bxSGgBrSImL+zURoPO2apqTth2GqvNDCOVZjNVbiFZtFgsjmxgEP9EK5nT5qwzsHobbI9QoyiJ+B6bRehE81gWaEYH4rfvT1SJMIC0K55enmIRz00fDHo0TmUSKp7Z2zB8fRgdF416LNRJtyMHuvGJcGjMKQjvfh2zDUo4XLFwGSowAWXVU3pfJTGsYmPogNLPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FgGnPq73XifySuBgQglBddFnGXS7TGGFZPy0g25aOS4=;
 b=DLmB312iNcTXCMQqODtUP92Xhf07EJ6I8zp0Ow4A9DAScc6Xxwo8hfVOXTKpIk4iKqaeGGd+gEwCqjBNTkRdY7KPv69K9dcKUFgwzGDb3/hiprHgeoeY4APJJQwrRkw+EoSIZwthRMfemkQeHD6LnMFazRvOY9Pe8yjvQfYP5I8=
Received: from BY5PR03CA0027.namprd03.prod.outlook.com (2603:10b6:a03:1e0::37)
 by DS6PR12MB176549.namprd12.prod.outlook.com (2603:10b6:8:468::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Wed, 23 Sep
 2026 21:40:46 +0000
Received: from SJ1PEPF000037AB.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::ad) by BY5PR03CA0027.outlook.office365.com
 (2603:10b6:a03:1e0::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Wed,
 23 Sep 2026 21:40:46 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000037AB.mail.protection.outlook.com (10.167.244.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 21:40:46 +0000
Received: from [10.236.178.170] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 16:40:44 -0500
Message-ID: <71af56f9-6e2e-4210-9f67-386e29f45ccc@amd.com>
Date: Wed, 23 Sep 2026 16:40:43 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v13 09/15] cxl: Cache endpoint HDM state during PCI
 enumeration
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
 <20260922083924.2451158-10-smadhavan@nvidia.com>
Content-Language: en-US
In-Reply-To: <20260922083924.2451158-10-smadhavan@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037AB:EE_|DS6PR12MB176549:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f5667b5-23da-48b2-ca3c-08df19bb53a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|36860700016|82310400026|921020|11063799006|6133799003|10067099003|56012099006|5023799004|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	lKD2IuT7wo5ip59jHqGUbiu/GArEm8obmMv/bCn0TUJgwXnWZrynGhab7QzZQiHTd1KxO3PvgZranMW8Ub/9B6XKH7oX7vOWQjSErjpn7g7/eo8jWjpjPe9lNugAm3Vcv2Hnhh8OnRtI9goGEqz0EQLbJqPdK5DtCt2Z7dGSXeC/cID4hSj6QhHJstjQi21y0ligFeG2K6HwisZqbCetnTP55FBz+lrMW5dnadF6NNxtkGRkptmqJ9OCD8bYm/wNfc7uuZ/ZMVWsTRbu/YCU7tqdfARYXIGu1+OslRWAdHVbyG1SzIbBJrXoNBkrS2FCO4uK7v3bCsEDG7y8W0Tq4DZb1Wca9Ru9eYk4lxAAOCVdIHH13s2lwNGaz+bKXhjfnKLYHnFC27CM+rWqXImt2rPga5Pii26ntARRh1R3kd3CfAqNb9teHLmL9XGuVCuuhLE5b37mg9WwUuAO6HBI7FooMgVFSpFgUGIrcP5sI4JisdQYwQi/BSBrO6jQqZjvmgV30R6vJPaXAdt5YjPouFsJpNxatWxOW/0053mQK780sO08rSUM0AzuLrkAieEKMeEPBNjTdQf7sWrTF02nzV5/6zO8wXACN/BgFtQrWfIRcUSyuO43SmY/hwBWZnHbMMAlwLltkfI9LqFbhTjYmhUzYamm1Ia47LtbWkaoBXRwne4ibfAGs0oqEQBqy/bsxQXMMAn9dneyx3Wxu+0XFEvXgiyVdNUQqjR27W1g31KcjUaHOiGL9JChfLNAAMuI
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(36860700016)(82310400026)(921020)(11063799006)(6133799003)(10067099003)(56012099006)(5023799004)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	u7eOy62uzO2Wve6/HBCajQxQxkpxDB+10feSn9es84WAfQf6+kpkdP53mVryY82CeZlo70UupdKVVCWuYG+s3OCgPvl7bNKVxz4GtvDTfwjVtY/Zy53jZBQO1nJzLmuw6DyE4cbGYNr5D4A/ZgWcPDHfxomu71pbvCL+lE9MSAq2fRQ8pK0TsctEIQTfi13lbswdjj7OtUTmec+RFZJyH/WoN9tB9aevOf67/8Z7fRe2gmGwZ0kw0vdyb1C54rS+9Ml5FWUQ5e5qvzDpWG4zZLla24lN7ShqNK5j7T4j1DjTL4v9d5A/ruO3sEAegvCMYmfamUnMaqlab4JjYr28tQuHFblaLssQAzkoHr+xz5PTANJisLJTvaQiTuZzFJwUN1PzMg1Ra0yQ5U7rxonOu+kHioLRLEYMGJF5m/XLiwsxi++xmXe//pVDs0y46lxL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 21:40:46.1642
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f5667b5-23da-48b2-ca3c-08df19bb53a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000037AB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR12MB176549

On 9/22/2026 3:39 AM, Srirangan Madhavan wrote:
> PCI capability initialization runs before BAR resources are finalized,
> while driver binding is too late for driver-independent reset support.
> Create pci_dev->hdm during pci_bus_add_device(), after PCI resource setup
> and before driver binding.
> 
> Cache BAR-relative HDM location, global control, decoder settings, and CXL
> Device DVSEC Control, then publish the completed cache under cxl_rwsem.dpa.
> Restore PCI_COMMAND after temporary MMIO access and reject decoder-count
> changes.
> 
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> ---
>  drivers/cxl/core/Makefile   |   3 +-
>  drivers/cxl/core/pci.c      |  15 ++-
>  drivers/cxl/core/regs.c     |   9 ++
>  drivers/cxl/core/resource.c | 255 ++++++++++++++++++++++++++++++++++++
>  drivers/pci/bus.c           |   2 +
>  drivers/pci/probe.c         |   2 +
>  include/cxl/cxl.h           |  21 +++
>  tools/testing/cxl/Kbuild    |   1 -
>  8 files changed, 304 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
> index 30470799e059..2335059f687a 100644
> --- a/drivers/cxl/core/Makefile
> +++ b/drivers/cxl/core/Makefile
> @@ -1,6 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_CXL_BUS) += cxl_core.o
> -obj-$(CONFIG_CXL_RESET) += resource.o
> +obj-$(CONFIG_CXL_RESET) += regs.o resource.o
>  obj-$(CONFIG_CXL_SUSPEND) += suspend.o
>  
>  ccflags-y += -I$(srctree)/drivers/cxl
> @@ -8,7 +8,6 @@ CFLAGS_trace.o = -DTRACE_INCLUDE_PATH=. -I$(src)
>  
>  cxl_core-y := port.o
>  cxl_core-y += pmem.o
> -cxl_core-y += regs.o
>  cxl_core-y += memdev.o
>  cxl_core-y += mbox.o
>  cxl_core-y += pci.o
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index bf7fc77626d9..cf7fefd595a2 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -180,6 +180,16 @@ int cxl_await_media_ready(struct cxl_dev_state *cxlds)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_await_media_ready, "CXL");
>  
> +static void cxl_hdm_cache_dvsec_ctrl(struct pci_dev *pdev, u16 ctrl)
> +{
> +	guard(rwsem_write)(&cxl_rwsem.dpa);
> +	if (!pdev->hdm)
> +		return;
> +
> +	pdev->hdm->dvsec_ctrl = ctrl;
> +	pdev->hdm->dvsec_ctrl_valid = true;
> +}
> +
>  static int cxl_set_mem_enable(struct cxl_dev_state *cxlds, u16 val)
>  {
>  	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
> @@ -191,8 +201,10 @@ static int cxl_set_mem_enable(struct cxl_dev_state *cxlds, u16 val)
>  	if (rc)
>  		return pcibios_err_to_errno(rc);
>  
> -	if ((ctrl & PCI_DVSEC_CXL_MEM_ENABLE) == val)
> +	if ((ctrl & PCI_DVSEC_CXL_MEM_ENABLE) == val) {
> +		cxl_hdm_cache_dvsec_ctrl(pdev, ctrl);
>  		return 1;
> +	}
>  	ctrl &= ~PCI_DVSEC_CXL_MEM_ENABLE;
>  	ctrl |= val;
>  
> @@ -200,6 +212,7 @@ static int cxl_set_mem_enable(struct cxl_dev_state *cxlds, u16 val)
>  	if (rc)
>  		return pcibios_err_to_errno(rc);
>  
> +	cxl_hdm_cache_dvsec_ctrl(pdev, ctrl);
>  	return 0;
>  }
>  
> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index 20c2d9fbcfe7..ba1f942d20e1 100644
> --- a/drivers/cxl/core/regs.c
> +++ b/drivers/cxl/core/regs.c
> @@ -200,6 +200,7 @@ void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
>  
>  	return ret_val;
>  }
> +EXPORT_SYMBOL_NS_GPL(devm_cxl_iomap_block, "CXL");
>  
>  int cxl_map_component_regs(const struct cxl_register_map *map,
>  			   struct cxl_component_regs *regs,
> @@ -285,6 +286,8 @@ static bool cxl_decode_regblock(struct pci_dev *pdev, u32 reg_lo, u32 reg_hi,
>  	}
>  
>  	map->reg_type = reg_type;
> +	map->bar = bar;
> +	map->bar_offset = offset;
>  	map->resource = pci_resource_start(pdev, bar) + offset;
>  	map->max_size = pci_resource_len(pdev, bar) - offset;
>  	return true;
> @@ -309,6 +312,7 @@ static int __cxl_find_regblock_instance(struct pci_dev *pdev, enum cxl_regloc_ty
>  	*map = (struct cxl_register_map) {
>  		.host = &pdev->dev,
>  		.resource = CXL_RESOURCE_NONE,
> +		.bar = -1,
>  	};
>  
>  	regloc = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
> @@ -339,6 +343,8 @@ static int __cxl_find_regblock_instance(struct pci_dev *pdev, enum cxl_regloc_ty
>  	}
>  
>  	map->resource = CXL_RESOURCE_NONE;
> +	map->bar = -1;
> +	map->bar_offset = 0;
>  	if (index == CXL_INSTANCES_COUNT)
>  		return instance;
>  
> @@ -518,6 +524,7 @@ u16 cxl_rcrb_to_aer(struct device *dev, resource_size_t rcrb)
>  
>  	return offset;
>  }
> +EXPORT_SYMBOL_NS_GPL(cxl_rcrb_to_aer, "CXL");
>  
>  static resource_size_t cxl_rcrb_to_linkcap(struct device *dev, struct cxl_dport *dport)
>  {
> @@ -634,6 +641,7 @@ resource_size_t __rcrb_to_component(struct device *dev, struct cxl_rcrb_info *ri
>  
>  	return component_reg_phys;
>  }
> +EXPORT_SYMBOL_NS_GPL(__rcrb_to_component, "CXL");
>  
>  resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
>  					   struct cxl_dport *dport)
> @@ -642,3 +650,4 @@ resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
>  		return CXL_RESOURCE_NONE;
>  	return __rcrb_to_component(dev, &dport->rcrb, CXL_RCRB_UPSTREAM);
>  }
> +EXPORT_SYMBOL_NS_GPL(cxl_rcd_component_reg_phys, "CXL");
> diff --git a/drivers/cxl/core/resource.c b/drivers/cxl/core/resource.c
> index 7eea2bc38d94..b5f8c28e613f 100644
> --- a/drivers/cxl/core/resource.c
> +++ b/drivers/cxl/core/resource.c
> @@ -2,9 +2,17 @@
>  /* Copyright (c) 2026 NVIDIA Corporation & Affiliates */
>  #include <linux/delay.h>
>  #include <linux/bug.h>
> +#include <linux/bitfield.h>
> +#include <linux/cleanup.h>
>  #include <linux/errno.h>
>  #include <linux/export.h>
> +#include <linux/io.h>
> +#include <linux/ioport.h>
>  #include <linux/kernel.h>
> +#include <linux/pci.h>
> +#include <linux/slab.h>
> +
> +#include <cxl/pci.h>
>  
>  #include "cxl.h"
>  #include "core.h"
> @@ -164,3 +172,250 @@ int cxl_hdm_unpack_decoder(struct cxl_decoder_settings *settings, int id,
>  	return 0;
>  }
>  EXPORT_SYMBOL_FOR_MODULES(cxl_hdm_unpack_decoder, "cxl_core");
> +
> +static int cxl_pci_hdm_dvsec(struct pci_dev *pdev)
> +{
> +	u16 cap;
> +	int dvsec;
> +	int rc;
> +
> +	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
> +					  PCI_DVSEC_CXL_DEVICE);
> +	if (!dvsec)
> +		return -ENOTTY;

Why -ENOTTY here and below? I would've expected -ENXIO for a missing capability.

> +
> +	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CAP, &cap);
> +	if (rc)
> +		return pcibios_err_to_errno(rc);
> +	if (!(cap & PCI_DVSEC_CXL_MEM_CAPABLE) ||
> +	    !FIELD_GET(PCI_DVSEC_CXL_HDM_COUNT, cap))
> +		return -ENOTTY;
> +
> +	return dvsec;
> +}
> +
> +static int cxl_pci_hdm_read_decoder(struct pci_dev *pdev,
> +				    struct cxl_decoder_settings *settings,
> +				    void __iomem *hdm, int id)
> +{
> +	u64 target_or_skip, base, size;
> +	u32 ctrl;
> +	int rc;
> +
> +	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
> +	base = ((u64)readl(hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(id)) << 32) |
> +	       readl(hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(id));
> +	size = ((u64)readl(hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(id)) << 32) |
> +	       readl(hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(id));
> +	target_or_skip =
> +		((u64)readl(hdm + CXL_HDM_DECODER0_TL_HIGH(id)) << 32) |
> +		readl(hdm + CXL_HDM_DECODER0_TL_LOW(id));
> +
> +	rc = cxl_hdm_unpack_decoder(settings, id, ctrl, base, size,
> +				    target_or_skip);
> +	if (rc) {
> +		pci_err(pdev,
> +			"CXL HDM decoder %d has invalid configuration: %d\n",
> +			id, rc);
> +		return rc;
> +	}
> +
> +	if (!(settings->config.flags & CXL_DECODER_F_ENABLE))
> +		*settings = (struct cxl_decoder_settings) {
> +			.config.id = id,
> +		};
> +
> +	return 0;
> +}
> +
> +static int __cxl_pci_hdm_read_info(struct pci_dev *pdev,
> +				   struct cxl_register_map *map, int dvsec,
> +				   struct cxl_hdm_info **out)
> +{
> +	struct cxl_reg_map *hdm_map = &map->component_map.hdm_decoder;
> +	struct cxl_hdm_info *info = NULL;
> +	resource_size_t hdm_offset;
> +	void __iomem *hdm;
> +	int decoder_count;
> +	size_t required;
> +	u16 dvsec_ctrl;
> +	int rc;
> +
> +	rc = cxl_setup_regs(map);
> +	if (rc)
> +		return rc;
> +	if (!hdm_map->valid)
> +		return -ENODEV;
> +	if (hdm_map->offset > map->max_size ||
> +	    hdm_map->size > map->max_size - hdm_map->offset)
> +		return -ENXIO;
> +	if (check_add_overflow(map->bar_offset,
> +			       (resource_size_t)hdm_map->offset, &hdm_offset))
> +		return -EOVERFLOW;
> +
> +	hdm = ioremap(map->resource + hdm_map->offset, hdm_map->size);
> +	if (!hdm)
> +		return -ENOMEM;
> +
> +	decoder_count = cxl_hdm_decoder_count(readl(hdm + CXL_HDM_DECODER_CAP_OFFSET));
> +	if (decoder_count < 0) {
> +		rc = decoder_count;
> +		goto out_unmap;
> +	}
> +
> +	required = CXL_HDM_DECODER0_TL_HIGH(decoder_count - 1) +
> +		   sizeof(u32);
> +	if (required > hdm_map->size) {
> +		pci_err(pdev,
> +			"CXL HDM decoder count exceeds mapped register block\n");
> +		rc = -ENXIO;
> +		goto out_unmap;
> +	}
> +
> +	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL,
> +				  &dvsec_ctrl);
> +	if (rc) {
> +		rc = pcibios_err_to_errno(rc);
> +		goto out_unmap;
> +	}
> +
> +	info = kzalloc(struct_size(info, settings, decoder_count), GFP_KERNEL);
> +	if (!info) {
> +		rc = -ENOMEM;
> +		goto out_unmap;
> +	}
> +
> +	info->decoder_count = decoder_count;
> +	info->hdm_bar = map->bar;
> +	info->hdm_offset = hdm_offset;
> +	info->hdm_size = hdm_map->size;
> +	info->global_ctrl = readl(hdm + CXL_HDM_DECODER_CTRL_OFFSET);
> +	info->dvsec_ctrl = dvsec_ctrl;
> +	info->dvsec_ctrl_valid = true;
> +
> +	for (int i = 0; i < decoder_count; i++) {
> +		rc = cxl_pci_hdm_read_decoder(pdev, &info->settings[i], hdm, i);
> +		if (rc)
> +			goto out_unmap;
> +	}
> +
> +	/*
> +	 * A changed decoder count means the snapshot no longer describes the
> +	 * complete hardware state. Reject it rather than publish a partial cache.
> +	 */
> +	rc = cxl_hdm_decoder_count(readl(hdm + CXL_HDM_DECODER_CAP_OFFSET));
> +	if (rc != decoder_count) {
> +		pci_err(pdev, "CXL HDM decoder count changed from %d to %d\n",
> +			decoder_count, rc);
> +		rc = -ENXIO;
> +		goto out_unmap;
> +	}
> +
> +	*out = info;
> +	info = NULL;
> +	rc = 0;
> +
> +out_unmap:
> +	kfree(info);
> +	iounmap(hdm);
> +	return rc;
> +}
> +
> +static int cxl_pci_hdm_read_info(struct pci_dev *pdev,
> +				 struct cxl_register_map *map, int dvsec,
> +				 struct cxl_hdm_info **out)
> +{
> +	bool restore_command = false;
> +	u16 command;
> +	int rc, rc2;
> +
> +	guard(pci_dev)(pdev);
> +
> +	rc = pci_read_config_word(pdev, PCI_COMMAND, &command);
> +	if (rc)
> +		return pcibios_err_to_errno(rc);
> +
> +	if (!(command & PCI_COMMAND_MEMORY)) {
> +		rc = pci_write_config_word(pdev, PCI_COMMAND,
> +					   command | PCI_COMMAND_MEMORY);
> +		if (rc)
> +			return pcibios_err_to_errno(rc);
> +		restore_command = true;
> +	}
> +
> +	rc = __cxl_pci_hdm_read_info(pdev, map, dvsec, out);
> +	if (!restore_command)
> +		return rc;
> +
> +	if (!rc) {
> +		rc = pci_write_config_word(pdev, PCI_COMMAND, command);
> +		return pcibios_err_to_errno(rc);
> +	}
> +
> +	rc2 = pci_write_config_word(pdev, PCI_COMMAND, command);
> +	if (rc2)
> +		pci_err(pdev,
> +			"failed to restore PCI_COMMAND after CXL HDM cache init: %d\n",
> +			pcibios_err_to_errno(rc2));
> +
> +	return rc;


I think the above would flow better as:

rc = __cxl_pci_hdm_read_info(pdev, map, dvsec, out);
if (rc) {
	if (!restore_command)
		return rc;

	rc2 = pci_write_config_word(pdev, PCI_COMMAND, command);
	if (rc2)
		...
} else {
	rc = pci_write_config_word(pdev, PCI_COMMAND, command);
	return pcibios_err_to_errno(rc);
}

return rc;

> +}
> +
> +static int __pci_cxl_hdm_cache_init(struct pci_dev *pdev)
> +{
> +	struct cxl_hdm_info *info __free(kfree) = NULL;
> +	struct cxl_register_map map = { };
> +	struct resource *bar;
> +	int dvsec;
> +	int rc;
> +
> +	scoped_guard(rwsem_read, &cxl_rwsem.dpa)
> +		if (pdev->hdm)
> +			return 0;
> +
> +	dvsec = cxl_pci_hdm_dvsec(pdev);
> +	if (dvsec < 0)
> +		return dvsec;

Might be better to just return 0 here. If the device doesn't have a CXL capability
then I wouldn't consider that an error from the perspective of the PCI subsystem.

> +
> +	rc = cxl_find_regblock(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
> +	if (rc)
> +		return rc;
> +	if (map.bar < 0 || map.bar >= PCI_STD_NUM_BARS)
> +		return -ENODEV;
> +
> +	bar = &pdev->resource[map.bar];
> +	if (!pci_resource_len(pdev, map.bar) ||
> +	    (bar->flags & (IORESOURCE_UNSET | IORESOURCE_DISABLED)) ||
> +	    resource_type(bar) != IORESOURCE_MEM || !bar->start || !bar->end)
> +		return -ENODEV;
> +
> +	rc = cxl_pci_hdm_read_info(pdev, &map, dvsec, &info);
> +	if (rc)
> +		return rc;
> +
> +	guard(rwsem_write)(&cxl_rwsem.dpa);
> +	if (!pdev->hdm)
> +		pdev->hdm = no_free_ptr(info);
> +
> +	return 0;
> +}
> +
> +void pci_cxl_hdm_cache_init(struct pci_dev *pdev)
> +{
> +	int rc;
> +
> +	rc = __pci_cxl_hdm_cache_init(pdev);
> +	if (rc && rc != -ENOTTY && rc != -ENODEV)
> +		pci_dbg(pdev, "CXL HDM cache init failed: %d\n", rc);

I don't know if it's worth filtering out -ENOTTY and -ENODEV for a debug message,
but that's more of a question for the PCI people.

> +}
> +EXPORT_SYMBOL_FOR_MODULES(pci_cxl_hdm_cache_init, "cxl_core");
> +
> +void pci_cxl_hdm_cache_release(struct pci_dev *pdev)
> +{
> +	struct cxl_hdm_info *info;
> +
> +	guard(rwsem_write)(&cxl_rwsem.dpa);
> +	info = pdev->hdm;
> +	pdev->hdm = NULL;
> +	kfree(info);
> +}
> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> index 655ed53436d3..d866452222b6 100644
> --- a/drivers/pci/bus.c
> +++ b/drivers/pci/bus.c
> @@ -18,6 +18,7 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/proc_fs.h>
>  #include <linux/slab.h>
> +#include <cxl/cxl.h>
>  
>  #include "pci.h"
>  
> @@ -359,6 +360,7 @@ void pci_bus_add_device(struct pci_dev *dev)
>  
>  	/* Save config space for error recoverability */
>  	pci_save_state(dev);
> +	pci_cxl_hdm_cache_init(dev);
>  
>  	/*
>  	 * Enable runtime PM, which potentially allows the device to
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 27008e2ea5af..752347464a4d 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -24,6 +24,7 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/bitfield.h>
>  #include <trace/events/pci.h>
> +#include <cxl/cxl.h>
>  #include "pci.h"
>  
>  static struct resource busn_resource = {
> @@ -2484,6 +2485,7 @@ static void pci_release_dev(struct device *dev)
>  	struct pci_dev *pci_dev;
>  
>  	pci_dev = to_pci_dev(dev);
> +	pci_cxl_hdm_cache_release(pci_dev);
>  	pci_release_capabilities(pci_dev);
>  	pci_release_of_node(pci_dev);
>  	pcibios_release_device(pci_dev);
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 005259e38f4b..4bad41e74f74 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -26,6 +26,7 @@ enum cxl_devtype {
>  };
>  
>  struct cxl_region;
> +struct pci_dev;
>  
>  enum cxl_decoder_type {
>  	CXL_DECODER_DEVMEM = 2,
> @@ -87,6 +88,9 @@ struct cxl_decoder_settings {
>   * @dvsec_ctrl: CXL DVSEC control register
>   * @dvsec_ctrl_valid: whether @dvsec_ctrl contains valid state
>   * @settings: per-decoder programming state
> + *
> + * Publication through pci_dev.hdm and all mutable fields are protected by
> + * cxl_rwsem.dpa.
>   */
>  struct cxl_hdm_info {
>  	int decoder_count;
> @@ -172,6 +176,8 @@ struct cxl_pmu_reg_map {
>   * @base: virtual base of the register-block-BAR + @block_offset
>   * @resource: physical resource base of the register block
>   * @max_size: maximum mapping size to perform register search
> + * @bar: PCI BAR containing the register block
> + * @bar_offset: register block offset relative to @bar
>   * @reg_type: see enum cxl_regloc_type
>   * @component_map: cxl_reg_map for component registers
>   * @device_map: cxl_reg_maps for device registers
> @@ -182,6 +188,8 @@ struct cxl_register_map {
>  	void __iomem *base;
>  	resource_size_t resource;
>  	resource_size_t max_size;
> +	int bar;
> +	resource_size_t bar_offset;
>  	u8 reg_type;
>  	union {
>  		struct cxl_component_reg_map component_map;
> @@ -190,6 +198,19 @@ struct cxl_register_map {
>  	};
>  };
>  
> +#ifdef CONFIG_CXL_RESET
> +void pci_cxl_hdm_cache_init(struct pci_dev *pdev);
> +void pci_cxl_hdm_cache_release(struct pci_dev *pdev);
> +#else
> +static inline void pci_cxl_hdm_cache_init(struct pci_dev *pdev)
> +{
> +}
> +
> +static inline void pci_cxl_hdm_cache_release(struct pci_dev *pdev)
> +{
> +}
> +#endif
> +
>  /**
>   * struct cxl_dpa_perf - DPA performance property entry
>   * @dpa_range: range for DPA address
> diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
> index 2be1df80fcc9..e80500f457a9 100644
> --- a/tools/testing/cxl/Kbuild
> +++ b/tools/testing/cxl/Kbuild
> @@ -55,7 +55,6 @@ obj-m += cxl_core.o
>  
>  cxl_core-y := $(CXL_CORE_SRC)/port.o
>  cxl_core-y += $(CXL_CORE_SRC)/pmem.o
> -cxl_core-y += $(CXL_CORE_SRC)/regs.o

Did you run CXL test with this change? I don't think there are any test symbols in regs.c, but you should
make sure this doesn't break anything there. You may not need to even fix anything if it does, but just
make a note of the regression.

>  cxl_core-y += $(CXL_CORE_SRC)/memdev.o
>  cxl_core-y += $(CXL_CORE_SRC)/mbox.o
>  cxl_core-y += $(CXL_CORE_SRC)/pci.o


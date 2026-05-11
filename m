Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010008.outbound.protection.outlook.com [52.101.56.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9202F8EAE;
	Mon, 11 May 2026 04:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778474871; cv=fail; b=XZ76RFBvTgAPBBL/iXYxmJy3m/kG1ddQjxp5wmOr/YQjSKTb3NmlZM5hqhh9o1H8KXZDw6IyeffE2ehs8WJFoh3Xbgi95NETwVJde9VK3H02UCj3kolgfE3UzS09SgFR6DrjVmJp6QKuV+bB7+GtozRclrxeJ3b0cSeww47EsJk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778474871; c=relaxed/simple;
	bh=gjWrfxOy64X3w6rpP1qc9h3N2DarsRyIJXUxLSJ/Gqg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=V5Gxf0ncSkiahhn9r93R5G8Yw4UBw0Jq8ah/GAzrU/0tMxCpDAygbBq3knckztxSBTnorihisW+r9/Fn/OC/KfkZn85nwzwESKhlcTBJCrjz/V5/Yvy6FmJ27GSaQBBHIb/S0f6LoeAytWJ4LgtDloc5jVCu+UoC62ZJRMMqAJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=aMByqYno; arc=fail smtp.client-ip=52.101.56.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="aMByqYno"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xf6l/FUR4qLudq7O5VerGiMPCh3FQ/tVxAyhW5NFs8wuJIYLHvXUD+vqzJmky592lQZculaOyP8euOgXkzANThXb3ML/vdeCMIIr5BdLn+cF08TdO8APeIIARXjQl2YA16GKQmXROBkouuTgx1bhPJe2mD7y2oMlWb8SoQmGUve6d0YGL8pQIfPuZInZfat/vlPSMKsbInkTGNuGTeVLBJgczxb61eRUB5CDWh0KUEStT0/HPNT1Oq+MdIaSk5kfmmt/nOwhhyMxkToYXZgFsfJvTJbK7kV4Psz2tYG4rN0XhzZ46xWY+XkaYZleArJScDT0c9X9VSxebpV9MTdI3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dGVMIuyl2oEgx46bpgmlWni8peBq2DNW87xKvyjQBtw=;
 b=C1g+fbKD9OV20dWWL4mK/iereFF4ta26asdLxLZPpchAkhQMkM7LrSMUjrPY/O+H8ATu+XoZjPFzjkb+Jou7N6OOOBcO/nOhM71HBA+JAquKiQWLdy3cVDdSteHezHKFz1z2Li2YiSw/Q5MoPtJAxQTcZdwgmJ8DDWrKN5EUdBa/GLYkiMeBFxeEXujohKnsk1HW9tf769xnLrYl8LKwL61hPi2Svw2Pt+QSlbNdlVxi8HQkqV2MP/AgyuElreTmo7dtkiiW7FVSyV/gg3JALOfIY2YcIjP/t11wPeh/LxRavYesRhWkqtMk6dnbxgxJVbwJ+0+FWJUoieIU00dOWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dGVMIuyl2oEgx46bpgmlWni8peBq2DNW87xKvyjQBtw=;
 b=aMByqYnoQxPAjaqHJIOfSwIjfUqf4qXaBgWTvKg660Auzb+zu7B+khoKeQHwvPAf8nUd4CbVUgLOHxWqHGufGUVaWN4bcH+QRkn8HMsF14I1HzzG8tHxg5u1Q2ZHnxjhmEVHI7vhq181Qn7fVxCFrL56zM2L1DS6D9Vot8uaFkA=
Received: from BYAPR05CA0023.namprd05.prod.outlook.com (2603:10b6:a03:c0::36)
 by BLAPR10MB5105.namprd10.prod.outlook.com (2603:10b6:208:325::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 04:47:47 +0000
Received: from CO1PEPF000075EE.namprd03.prod.outlook.com
 (2603:10b6:a03:c0:cafe::2d) by BYAPR05CA0023.outlook.office365.com
 (2603:10b6:a03:c0::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.14 via Frontend Transport; Mon, 11
 May 2026 04:47:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CO1PEPF000075EE.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Mon, 11 May 2026 04:47:46 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Sun, 10 May
 2026 23:47:44 -0500
Received: from DFLE215.ent.ti.com (10.64.6.73) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Sun, 10 May
 2026 23:47:44 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Sun, 10 May 2026 23:47:44 -0500
Received: from [10.24.68.129] (a0507033-hp.dhcp.ti.com [10.24.68.129])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64B4lfx82936634;
	Sun, 10 May 2026 23:47:42 -0500
Message-ID: <2788061a-bb42-4a80-9537-6e8796d7a65e@ti.com>
Date: Mon, 11 May 2026 10:17:40 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] PCI: cadence: Use dynamic PCIe capability offset
 in host driver
To: Hans Zhang <18255117159@163.com>, <bhelgaas@google.com>,
	<lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <mani@kernel.org>,
	<s-vadapalli@ti.com>
CC: <robh@kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20260509130716.2104103-1-18255117159@163.com>
 <20260509130716.2104103-4-18255117159@163.com>
Content-Language: en-US
From: Aksh Garg <a-garg7@ti.com>
In-Reply-To: <20260509130716.2104103-4-18255117159@163.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075EE:EE_|BLAPR10MB5105:EE_
X-MS-Office365-Filtering-Correlation-Id: 13f5cb97-64a8-434d-39be-08deaf18723c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	rJ2qoRs4h9qNypR0qtkXt0m1INPwqoK7NQZdF4qtkJjMl/WrjEt3RR+j/+++9k/3qEnn1rHnWGUOexkCkfX5ApFg919lXD9J8VuVo00hmwUU8bd6jK5aH320b4dkEB1BNQdf+FVrgQjI6LEVuTqsewUd+gpA0xGrF1TgCs7uanbvsvwJpCBzq9OoRQqPUH1TkWN3H5brch1/tIXwrU1f3zJUiIDt3Bn/878Uv1hw2qJ7Ablt/zYcreKxlF3Hn0TcEoUMzrHsdbhtL8ZECk9feLVTAwvhgFMfvnR5vLL5iZ7gcDzkd6iUxm2/L6/BOnGDu0NqGrxh+wSfcOTzPhwEKlRGwXUJB5tkw9T7PathRr/pmvJ1eloSIGETQAVxTvrO934oohTGNrb970FvQ6fniBMbW4cc1yZBaIEktg0Wpo1h3weFcu8gKdH//etLRYXaFriSe/2PKedqOUmoMvnYRPaMWssw3OJTgKnSJHmbJIKE0fSGN3xVV4V5bUM1u2hxQa2yrczLmc68wCEx38dgRPhMMn6Ls3CCUdH5zmmuVG93Ug4PSmg26lC7SfYCUl+k7lQEqqoujQwCMM0WF0+UQhxOy5WVcaDSUDvQEaUembenipR/5mx7gWoJs+beaCHR6cpF8+auOMqEq8M4uiPY6/ebokaugzsL8xM6wCKhgtTNUhW7DtKS6xFDBg0K+ckMb083ESbEDQRQYE0cDT0d1uQN9DdFuvLQTFsWKXNKX2g=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	dy7gTrV51VqrwLNjpXMiW2ryj5mHDA4IUKna/XoIuZQkg9kw79RMBOlMeftnRm0VcS9uutkwnsHMt9AdK+VC6sa4OnDpWSKebnCSFgeZT+NARtkbj6p22WA8XhafUqeVVnKFu9qxwSYfxEIcB47qTHSQtF2L3UKWNw8MNVRS1iO9wytA9cbMCK9dvtlaFA+CNPPNFaEDv7IagI4s+6uz13L1ODAjd6N68K2OPZr0/TlQqhBGfphxdPpml1+tw0oflIjOKE/WKHak+0fqOv78nrjTHZaF2TnP5cIbHutzdOfOKDT7yjFrW+YUbgYrzllAJqHTKfl5l4NwBHJ/Z3ePl7/y3N2xoBP+iglbiPpFsQDd7jnXI2noeXl87fbP7g8NY+irBhA3qj9YstwAGG23fL8GeqVBK7KWcQM2/OwbuMwF1F0WU8BaoJVzhGEAmbH/
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 04:47:46.2551
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13f5cb97-64a8-434d-39be-08deaf18723c
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075EE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5105

Hi Hans,

On 09/05/26 18:37, Hans Zhang wrote:
> The Cadence PCIe controller may place the PCI Express Capability
> structure at different offsets depending on SoC integration. The
> hardcoded CDNS_PCIE_RP_CAP_OFFSET (0xC0) is not universally valid.
> 
> Replace all uses of the fixed offset with the dynamically cached
> pcie->pcie_cap obtained via cdns_pcie_get_pcie_cap(). This affects:
> - Root Port training completion check
> - Link retraining
> - Root Port initialization (ASPM quirks)
> 
> Also remove the now-unused CDNS_PCIE_RP_CAP_OFFSET definition from
> pcie-cadence-lga-regs.h.
> 
> This change ensures correct operation across different Cadence IP
> generations (LGA and HPA) and SoC designs.
> 
> Signed-off-by: Hans Zhang <18255117159@163.com>
> ---
>   drivers/pci/controller/cadence/pcie-cadence-ep.c          | 5 +++--
>   drivers/pci/controller/cadence/pcie-cadence-host-common.c | 4 ++--
>   drivers/pci/controller/cadence/pcie-cadence-host-hpa.c    | 2 ++
>   drivers/pci/controller/cadence/pcie-cadence-host.c        | 6 ++++--
>   drivers/pci/controller/cadence/pcie-cadence-lga-regs.h    | 1 -
>   5 files changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
> index 38a0157b60dc..eeee954f7dc7 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
> @@ -571,9 +571,8 @@ static int cdns_pcie_ep_start(struct pci_epc *epc)
>   	int max_epfs = sizeof(epc->function_num_map) * 8;
>   	int ret, epf, last_fn;
>   	u32 reg, value;
> -	u8 cap;
> +	u8 cap = pcie->pcie_cap;

Can we eliminate the use of 'cap' variable and use 'pcie->pcie_cap' 
directly, just like in cdns_pcie_host_init_root_port()?

>   
> -	cap = cdns_pcie_find_capability(pcie, PCI_CAP_ID_EXP);
>   	/*
>   	 * BIT(0) is hardwired to 1, hence function 0 is always enabled
>   	 * and can't be disabled anyway.
> @@ -690,6 +689,8 @@ int cdns_pcie_ep_setup(struct cdns_pcie_ep *ep)
>   	}
>   	pcie->mem_res = res;
>   
> +	cdns_pcie_get_pcie_cap(pcie);
> +
>   	ep->max_regions = CDNS_PCIE_MAX_OB;
>   	of_property_read_u32(np, "cdns,max-outbound-regions", &ep->max_regions);
>   
> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host-common.c b/drivers/pci/controller/cadence/pcie-cadence-host-common.c
> index 2b0211870f02..26b248231558 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-host-common.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-host-common.c
> @@ -26,7 +26,7 @@ EXPORT_SYMBOL_GPL(bar_max_size);
>   
>   int cdns_pcie_host_training_complete(struct cdns_pcie *pcie)
>   {
> -	u32 pcie_cap_off = CDNS_PCIE_RP_CAP_OFFSET;
> +	u32 pcie_cap_off = pcie->pcie_cap;>   	unsigned long end_jiffies;
>   	u16 lnk_stat;
>   
> @@ -68,7 +68,7 @@ EXPORT_SYMBOL_GPL(cdns_pcie_host_wait_for_link);
>   int cdns_pcie_retrain(struct cdns_pcie *pcie,
>   		      cdns_pcie_linkup_func pcie_link_up)
>   {
> -	u32 lnk_cap_sls, pcie_cap_off = CDNS_PCIE_RP_CAP_OFFSET;
> +	u32 lnk_cap_sls, pcie_cap_off = pcie->pcie_cap;
>   	u16 lnk_stat, lnk_ctl;
>   	int ret = 0;
>   

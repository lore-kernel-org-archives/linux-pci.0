Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013071.outbound.protection.outlook.com [40.93.201.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642C781ACA;
	Mon, 11 May 2026 04:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778475494; cv=fail; b=RPwtjG9z3k2M9L4IwBqWPpONBi5k84vm/WbY8BXBRE3oc7rT1L1Mi+mBlQdae9o/WPtzSJQibPNXW9D34Wg5+Y8q4NPsiJMlkfiDbLm0ib2yNc04nWrkWm/sl6VPds4amUpyu2r3IyWbgLjQfbdXbhsmEMylDT/HJtlHBPmDvpQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778475494; c=relaxed/simple;
	bh=QLun6iKVAaL2uUMt1OXagFk57OAMn239CUQ5Hhaar5A=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=szDYKO4NTEfd/AzNUjUaJftkXBxfl8q1ka/0GqmQUbQI+RtW3weQeavZnQnL1ZsbYQeUGuZOiwWvdE6ZoGGi1va70UkH8nzPAZ/oKmcGZKCaPoiHk6/K3CisI/YQ7bS8f6c74xzUmJnqKcFKtcuha+rS+7Rd0FzmkuPFOUVTPCw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=rli8qsfq; arc=fail smtp.client-ip=40.93.201.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rli8qsfq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QPMVhP/t8NVkK8N5eRGSLI/85XTB9ZXNvil3Ld1Dm2ksSo77DW4hNoS05Fm7EmSjxM5FQWLfwnij59sWZ0C+XOYluJorZyTTaMiQ76q1jZOOrp5XyXnVXksrLLkCZ4CqCMOFc03SZ/0Olkb0GkWmt9/WE1K1ULRU89lIEDOZS3TUIkP7yI/AO2/EnPAk1o5ytZElapxhKI4KsvZ8zKE/2ajIdBiGGgfUUQP1muq+qfuV+EUAkb64LHgdymX3Cy8cxiZn00iPd4uZ2cxY+RJ/9NL0tCeXj/Cuk/RZ0wOLOOaVjxDC9Cr/3k7abVwl1Mzye9yIjjiAJGm+LnYSFPwEsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AG5MFqJFPmr2i7ZkApXiYwWPHzQorecZF5Z225qosSk=;
 b=oPtTo6vUKkwKArTnbPtJa+WNEITrfzh/9sEo/i1EOFK8AVpUWhKlbivz4zvN7BlSBdExulBy6w+itFUArRF6TjNmxAFcZXABd5b9MU22mErVmwTkb2luIpfm31zTbLGRBR+pMIsgtYximj4GOYcLPn3gRLaJ/uuz1xftjzOC3Z1u1Yz1Csqh0fT4LXximyz6RDJ0oH+iRN6zgVnDgD3WmwPMR8QkIXv3ESVy3RxGwxD9qKsC9lvMF70JWwsqWRHa2vDZ+LmkjHe47yn/+j9MhaenAmjNZOmX59Afhh3FsRnGBpfRQjeczsqM3gUx1OOCqq1+Cog9Nn0wN2Y6if4IeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AG5MFqJFPmr2i7ZkApXiYwWPHzQorecZF5Z225qosSk=;
 b=rli8qsfq6ACjY6qsX/o9Tche2hFbf+St0X6n/i802i94y5Z6qwWf8p+uIYKAN+KyzEpWd2ftvXf0fRvNRrrH1ndkmGb09gbmUH2nX1otlD6F720qYZ3cs3TN4zQPiJ7kq8DFq+BeXHRjYpnFaYz9YO3JX7Uj+Xs2ApDM2JH03do=
Received: from BL1PR13CA0435.namprd13.prod.outlook.com (2603:10b6:208:2c3::20)
 by LV0PR10MB997614.namprd10.prod.outlook.com (2603:10b6:408:33d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Mon, 11 May
 2026 04:58:10 +0000
Received: from BL6PEPF0001AB72.namprd02.prod.outlook.com
 (2603:10b6:208:2c3:cafe::98) by BL1PR13CA0435.outlook.office365.com
 (2603:10b6:208:2c3::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.14 via Frontend Transport; Mon, 11
 May 2026 04:58:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BL6PEPF0001AB72.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Mon, 11 May 2026 04:58:10 +0000
Received: from DLEE207.ent.ti.com (157.170.170.95) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Sun, 10 May
 2026 23:58:10 -0500
Received: from DLEE212.ent.ti.com (157.170.170.114) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Sun, 10 May
 2026 23:58:10 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Sun, 10 May 2026 23:58:09 -0500
Received: from [10.24.68.129] (a0507033-hp.dhcp.ti.com [10.24.68.129])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64B4w6kT2625561;
	Sun, 10 May 2026 23:58:07 -0500
Message-ID: <41c7dfa0-493a-4c85-bd71-003a4396426a@ti.com>
Date: Mon, 11 May 2026 10:28:06 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] PCI: cadence: Add cdns_pcie_get_pcie_cap() helper
 and cache capability offset
To: Hans Zhang <18255117159@163.com>, <bhelgaas@google.com>,
	<lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <mani@kernel.org>,
	<s-vadapalli@ti.com>
CC: <robh@kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20260509130716.2104103-1-18255117159@163.com>
 <20260509130716.2104103-3-18255117159@163.com>
Content-Language: en-US
From: Aksh Garg <a-garg7@ti.com>
In-Reply-To: <20260509130716.2104103-3-18255117159@163.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB72:EE_|LV0PR10MB997614:EE_
X-MS-Office365-Filtering-Correlation-Id: 24c93fba-bee6-4daf-05fb-08deaf19e66b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700016|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	zZtOoBg0T0AoUYpP1spJNi9pOa8gNGeeYWe0348huu5oST9wOFZhTlMF3dbXEOW8HiJFgBhddxydRamHrgIdZfWhCjemhdclmUE+A5oShkQZKKdyNPJlu3kGm+ObJjsdg/RjfjwCYs/o/It8ZvuNbiDfSi/ajbMuEfAtj/f76HwD2g65u//PL1U5GWoWtLnThim+1c0Jty/DzYlQJ/PrK8IZx3F6AdwEYqzoCr/HxEfujFzFdlOc9D0b8qHsjcO68a54inEpPGYN72KVg77i8e4r7C51mGmH1jMBs9xhEiUMea/sNgdu8RI9Aq1iEQM4dZfOg0Z1CgbVgoxAuqZBcny9ms/PgazZdeN0IwFbD/4UtvMrWVRnx6FbHEU6XHR22zuBbUmRbJzh0Z59Az5n6UAU+3bAPl5P9DI/gjLKZLMVjPu3NSjV7QLN8IXCE8FLNKFXU/chES1DaiDXZDGLTnaNQVAu5cmMcn2UJ/eAyqnXQsJEw/ii5Q2gLC16Hg6fMeO3POh5AmOf5GkT6SSPYA2LMEUqLy4Bqj+LvZyVnJzyfR9gZ+sFrZ5nnlQmw4mthBHbPjlHfh6Pqol/gSf34VeZOqEwsuxVCYFnVGAxMSuClIJ9gO7bUIn/tr0OQz0UTI6qWsFWjSErQ0/RMMzkfqsLqhHK1druBTdRhE+ewkJeNK8dph8oSM/YKfiBICPKUBnNFy6bGh3gk6i9XJy58TABQT3gHD8zLcHOPTWx+DI=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	h7YtOal5GPDV1I9OAevZIrVW9S1Ec3sLnQmu4N+k5Gldbyb/pDnVCapjnAgMDyB8nltpIuMO04eaQ+xsgac3L/brEA+RJf3kZRId33wsXqX/+ZMIkH5lz6QeWRaZFD43Eiqv4MoxJqmwdYpDSnk/po2ZPKUcbnRsiScNJBYazDk5lMKQIpWfKSQY8+oS4h9CPd5d8ElPD4SH9SBsgeKPCg9PDidaRKv4fm9JkPaGUYCLHmGKwkW6zr2XF/dpH7YiEODzQlRxfHMsQAMwbC1MfVINkQveGZkavDRbmre2B9EKTgaZN2IHzWRU5N1JwYn4Fxqqj4j2AJD/BjaPzbSIstvTbCHzFLcOaTyyK6LFd0hqdt+i4i0d/c5rc49S8+V5tHxusoA1MxXQnOm0JIeQtz8MwW3USOgQXEolsZkDN5SPaCX5y4RbqrX3IieDn0jP
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 04:58:10.6832
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24c93fba-bee6-4daf-05fb-08deaf19e66b
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB72.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR10MB997614

Hi Hans,

On 09/05/26 18:37, Hans Zhang wrote:
> Add a helper cdns_pcie_get_pcie_cap() that finds and caches the
> PCIe Capability offset in struct cdns_pcie::pcie_cap. This avoids
> repeated searches and follows the pattern used in other PCIe drivers.
> 
> The helper uses cdns_pcie_find_capability() to locate PCI_CAP_ID_EXP
> and stores the result for later use.
> 
> This is a preparatory step for removing the hardcoded capability
> offset from host driver code.
> 
> Signed-off-by: Hans Zhang <18255117159@163.com>
> ---
>   drivers/pci/controller/cadence/pcie-cadence.h | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
> index c057f4b393e6..bbd275193bc1 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence.h
> +++ b/drivers/pci/controller/cadence/pcie-cadence.h
> @@ -219,6 +219,7 @@ struct cdns_plat_pcie_of_data {
>    *       wrapper
>    * @cdns_pcie_reg_offsets: Register bank offsets for different SoC
>    * @debug_dir: debugfs node
> + * @pcie_cap: PCIe capability offset
>    */
>   struct cdns_pcie {
>   	void __iomem		             *reg_base;
> @@ -233,6 +234,7 @@ struct cdns_pcie {
>   	const  struct cdns_pcie_ops          *ops;
>   	const  struct cdns_plat_pcie_of_data *cdns_pcie_reg_offsets;
>   	struct dentry			     *debug_dir;
> +	u8				     pcie_cap;
>   };
>   
>   /**
> @@ -651,6 +653,22 @@ static inline int cdns_pcie_hpa_ep_setup(struct cdns_pcie_ep *ep)
>   
>   u8   cdns_pcie_find_capability(struct cdns_pcie *pcie, u8 cap);
>   u16  cdns_pcie_find_ext_capability(struct cdns_pcie *pcie, u8 cap);
> +
> +/**
> + * cdns_pcie_get_pcie_cap() - Return cached PCIe Capability offset
> + * @pcie: Cadence PCIe instance
> + *
> + * Finds and caches the offset of PCI_CAP_ID_EXP on first call.
> + * Returns 0 if the capability is not present.
> + */
> +static inline u8 cdns_pcie_get_pcie_cap(struct cdns_pcie *pcie)
> +{
> +	if (!pcie->pcie_cap)
> +		pcie->pcie_cap = cdns_pcie_find_capability(pcie, PCI_CAP_ID_EXP);
> +
> +	return pcie->pcie_cap;
> +}
> +

This function is only used to find, and cache the offset of
PCI_CAP_ID_EXP in pcie->pcie_cap. This is supposed to be called only by
the cdns_pcie_*_setup() during the initialization. After that, whoever
wants to use this cached offset can directly use pcie->pcie->offset
instead of calling this function to return the offset. Hence, this
function can be renamed as 'cdns_pcie_set_pcie_cap', and needs to return
nothing (or can return error if it is unable to find the capability offset).

Regards,
Aksh Garg

>   bool cdns_pcie_linkup(struct cdns_pcie *pcie);
>   
>   void cdns_pcie_detect_quiet_min_delay_set(struct cdns_pcie *pcie);


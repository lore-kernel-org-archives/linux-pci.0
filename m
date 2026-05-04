Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011049.outbound.protection.outlook.com [52.101.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752D57260D;
	Mon,  4 May 2026 05:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777871183; cv=fail; b=d7eKk7WVC3QiTXdre65bnExdf92i6kRtHBGacPe+p11IW6F1CCYs2NxWcMmLfT2I+AkTOSaU7xwesOjI3R4O685OVnCQpNj252MGpf32XePM5tVeTWpRLsRVSMxJJkeDfj4iONslcXs35lCyQ7Ycd294dxkVOcxlFngX1Cc7Fxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777871183; c=relaxed/simple;
	bh=p/w61DppiioIdTJl73mCn6o7xw1D9U3U2T9fvY4sMAI=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KsEL57UCXM8pL7KHUHJtCWxQK0wkvvS7D1nVSnJ4r0Pp2eqEIBb9ATFa0VDzFKSt5iDLJcgJlH8CvpUY+5f6d6XwbTtNDsMdOzKRkSLeGDwBEsPAxnUIGi7YUkTcpUAYoltcowLS+HZEvxQ+sBrBLgQ6gat0qX55q+IRpxePQAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=M5uNFWyJ; arc=fail smtp.client-ip=52.101.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="M5uNFWyJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QIyM0YIGWehalZxK6rlcMAtHykuZwvPrLo1t+2sBs+8MXJaJN/ZtpKb1dgYuUW0K7USNHnzpvpTp9TFDVAkavRsUZXETwNNWkjarHVs6vqgtdAYaboS++NYNQT+Glls8KUu547XbvY+9af5/SWLryrmnErSGFyrKuw8/Qitrd3DP6YnPNKtE/KBaqnFcR6oeMB9DRpHyICz3Nu0pfvtE0NcOGKUXYCn7licnKcABU0XLqq8H5wvf0rzyzj8rtouZwoo+Up/gKK8aiYNb50BwTyNowQEekIdCmpGohuuJfysRd9zkdjjYJMjlQJsNyJD3dSXH8CQwFV4CRQieY1ONuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S/yp72eiDDJzFXPE1wC+Kg9xANlHqRw3z99UmTLcuPo=;
 b=epyFpCb1DP+5E51UWVkpGtHvzcWVgkDGIR8vJ+lBfm5bRI5kM9it5c3DPrf9RagM0zsE0N2lQSXOsmEHTWZ+Rhk7ZpRCwuqGJpYwwQxl5gY8ezX4yAbwKNX3+dCMDByBkpBv3HTCdeh/NBfVtwxe030Nm/oKqJG4k82tVWtqkqsmf+kDLph1S4bFZjha86DeOcn52b7HD2jHc2B7wU7OI40qfSVFghzNoN1z7koXHYX1H2YpS7X7LVJEFcXzNTYc/BVofTBisqHpS0jhzs9AhwCho6eqAcAArugR5GBsW6YIDWz4WsdeldNvawmInM6zO08b6rO22xPiFT7Ir+bRrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S/yp72eiDDJzFXPE1wC+Kg9xANlHqRw3z99UmTLcuPo=;
 b=M5uNFWyJIxbSTmYe/4802UwL9bPGns/baVUwymC3kM8pQZeKLj9omsUkTmkWXgem5+a+tlS6sJ8JNDaOw3LXcTFEXFZvUYTtEnWcMjZVLrM5tlpq/N7X34x8a3B6Z779zVMryY0flL2/Lhn/uxWRroUYxdCbg+B3Tc0HvIWNkn8=
Received: from BLAPR05CA0005.namprd05.prod.outlook.com (2603:10b6:208:36e::14)
 by IA4PR10MB8304.namprd10.prod.outlook.com (2603:10b6:208:566::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Mon, 4 May
 2026 05:06:17 +0000
Received: from BN2PEPF00004FBB.namprd04.prod.outlook.com
 (2603:10b6:208:36e:cafe::77) by BLAPR05CA0005.outlook.office365.com
 (2603:10b6:208:36e::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.14 via Frontend Transport; Mon,
 4 May 2026 05:06:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BN2PEPF00004FBB.mail.protection.outlook.com (10.167.243.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Mon, 4 May 2026 05:06:17 +0000
Received: from DLEE203.ent.ti.com (157.170.170.78) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 4 May
 2026 00:06:16 -0500
Received: from DLEE211.ent.ti.com (157.170.170.113) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 4 May
 2026 00:06:16 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 4 May 2026 00:06:16 -0500
Received: from [10.24.73.74] (uda0492258.dhcp.ti.com [10.24.73.74])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64456Cw2006638;
	Mon, 4 May 2026 00:06:13 -0500
Message-ID: <a3093010-d120-4c5d-b272-d8cb3884f0b3@ti.com>
Date: Mon, 4 May 2026 10:38:34 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <s-vadapalli@ti.com>, <bhelgaas@google.com>, <lpieralisi@kernel.org>,
	<kwilczynski@kernel.org>, <mani@kernel.org>, <vigneshr@ti.com>,
	<robh@kernel.org>, <linux-omap@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] PCI: cadence: Ensure that
 cdns_pcie_host_wait_for_link() waits 100 ms after link up
To: Hans Zhang <18255117159@163.com>
References: <20260501153553.66382-1-18255117159@163.com>
 <20260501153553.66382-2-18255117159@163.com>
 <4ce9f13a-b17f-4149-ade8-57519f4a4752@ti.com>
 <699bd359-7389-45fa-a79b-10046f73bf12@163.com>
Content-Language: en-US
From: Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <699bd359-7389-45fa-a79b-10046f73bf12@163.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBB:EE_|IA4PR10MB8304:EE_
X-MS-Office365-Filtering-Correlation-Id: 95ab2f0e-6e62-4e6a-ea28-08dea99adf6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|7416014|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	KT0D9CN22MLbsrpJKxkXBpuuCKavH3oBCYO1J7D300yXtheDmLluYl+6gYPP1daBsYTS6if7o2kf8GvQ7Nkv6zp5Q4XLaooWrMe5lgtEDo9Y+4+nwbXhIYqBE8+IRVM0JUYCLY6HRMS7icFL998kZnjeBd6a0wXoZtcIue87519Kc017XbOdsgR4iDfDiti9Hn+OJ3/DKZOseTc8Bm/B2QcC6KysCpRn3fB6DxXAg7ZZTA2LA/yVViQyA7Je54gAH6R19uYtZekQDCiAzYA82/WMLg5QLUx/ppD5alNatlQUXNLJYw10+0CHr+eCGCY9agRcbHrq+TGEJtNGRA6HOtlnqSOfvKAY0Fxox0mCG4Hwa2RNEKz8FPNtcIf6b9hEy/xRgBWV3XoGbljODq0qbJWuhrQCqiI/2LZ/jhLAREYA8NmfPkLMjzcjIJWeEK3zF+BVP7096fBIRVCCcrjzwBVCUP8mpUOOya9vT8Y61r5zeqheewqQLeqWwhCCa5F7K7v70ISz4b3QOLRQ+jWhi+HdWek9t/59VQbO1IQRnUaOu6JaCKSoOnbUkqorsw87OjZ4w9Uly9BcM2NqZbkmH84RPEjro5Mjb9tEGwbjgR/sqz2B8EOWsAYJwcytKJwVgKTpOSTAgI/4BWX/Fp37CdFmLgAHxhvOKnrNgPDcLkyA39t3UWLkKE243jvMgiSA2h7mWqXQ/cjcIre2gcWHsnbE7Aewhv/KGbTthrZpJjs=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(7416014)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5Z5691qK+/dCnjGhvDpqeqIJQXlorCHZtf92mkMQtuZ90eslAnETwumuRO7mp+G5/Vibv2SDEUUDGbdGP2odlNQdhN7AWyMw4gujfXS8k7o3LWqP9OcjCSHpT7IVRZTa19A0y6W4VI05JtViTXxGJqaBXGdohmnU3gQQ3eYLvc7iN7gcYwxZMbCVMid94ixJdaeKUjg/nUOVPsqc4NKIOjtJvvwATrdC+3QTCBThXYLuBq6+AZQ5PgGtRQlLty2+Zx2q2KLUuuXtQb5xnge8PwradBJY76uQHilOVXHRa9Hw2H2yywnj7fmmolL8hQlYRPVOL/1trXFgHCGDS23MYM7MMM7AXaSdNz7Tv8yGvddlwZnPUf4cZOWi0fKzG4bj9usqbOTAQsJApXIlrMavtKordnH8EYkZlPiOy5qUqIqVEQTSBo3hKhGu4pHwuha3
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 05:06:17.0653
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95ab2f0e-6e62-4e6a-ea28-08dea99adf6e
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8304

On 03/05/26 21:16, Hans Zhang wrote:
> 
> 
> On 5/2/26 13:18, Siddharth Vadapalli wrote:
>> On 01/05/26 21:05, Hans Zhang wrote:
>>> As per PCIe r6.0, sec 6.6.1, a Downstream Port that supports Link speeds
>>> greater than 5.0 GT/s, software must wait a minimum of 100 ms after Link
>>> training completes before sending a Configuration Request.
>>>
>>> Add a new 'max_link_speed' field in struct cdns_pcie to record the
>>> maximum supported (or currently configured) link speed of the controller.
>>>
>>> In cdns_pcie_host_wait_for_link(), after the link is reported as up,
>>> insert a 100 ms delay if max_link_speed > 2 (i.e., > 5 GT/s). This
>>> implements the required delay at the common Cadence host layer.
>>>
>>> Currently max_link_speed is zero-initialized, so the delay is not yet
>>> active. Glue drivers must set max_link_speed appropriately to enable
>>> the delay. This matches the approach taken for the Synopsys DWC
>>> controller in commit 80dc18a0cba8d ("PCI: dwc: Ensure that
>>> dw_pcie_wait_for_link() waits 100 ms after link up").
>>>
>>> Signed-off-by: Hans Zhang <18255117159@163.com>
>>> ---
>>>   .../pci/controller/cadence/pcie-cadence-host-common.c    | 9 +++++++++
>>>   drivers/pci/controller/cadence/pcie-cadence.h            | 2 ++
>>>   2 files changed, 11 insertions(+)
>>>
>>> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host-common.c 
>>> b/drivers/pci/controller/cadence/pcie-cadence-host-common.c
>>> index 2b0211870f02..d4ae762f423f 100644
>>> --- a/drivers/pci/controller/cadence/pcie-cadence-host-common.c
>>> +++ b/drivers/pci/controller/cadence/pcie-cadence-host-common.c
>>> @@ -14,6 +14,7 @@
>>>   #include "pcie-cadence.h"
>>>   #include "pcie-cadence-host-common.h"
>>> +#include "../../pci.h"
>>>   #define LINK_RETRAIN_TIMEOUT HZ
>>> @@ -55,6 +56,14 @@ int cdns_pcie_host_wait_for_link(struct cdns_pcie *pcie,
>>>       /* Check if the link is up or not */
>>>       for (retries = 0; retries < LINK_WAIT_MAX_RETRIES; retries++) {
>>>           if (pcie_link_up(pcie)) {
>>> +            /*
>>> +             * As per PCIe r6.0, sec 6.6.1, a Downstream Port that
>>> +             * supports Link speeds greater than 5.0 GT/s, software
>>> +             * must wait a minimum of 100 ms after Link training
>>> +             * completes before sending a Configuration Request.
>>> +             */
>>> +            if (pcie->max_link_speed > 2)
>>> +                msleep(PCIE_RESET_CONFIG_WAIT_MS);
>>
>> I think the above could be moved to cdns_pcie_host_start_link() as follows:
>>
>> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host-common.c b/ 
>> drivers/pci/controller/cadence/pcie-cadence-host-common.c
>> index 2b0211870f02..0f885dcbdb12 100644
>> --- a/drivers/pci/controller/cadence/pcie-cadence-host-common.c
>> +++ b/drivers/pci/controller/cadence/pcie-cadence-host-common.c
>> @@ -115,6 +115,15 @@ int cdns_pcie_host_start_link(struct cdns_pcie_rc *rc,
>>       if (!ret && rc->quirk_retrain_flag)
>>           ret = cdns_pcie_retrain(pcie, pcie_link_up);
>>
>> +    /*
>> +     * As per PCIe r6.0, sec 6.6.1, a Downstream Port that
>> +     * supports Link speeds greater than 5.0 GT/s, software
>> +     * must wait a minimum of 100 ms after Link training
>> +     * completes before sending a Configuration Request.
>> +     */
>> +    if (!ret && pcie->max_link_speed > 2)
>> +        msleep(PCIE_RESET_CONFIG_WAIT_MS);
>> +
>>       return ret;
>>   }
>>   EXPORT_SYMBOL_GPL(cdns_pcie_host_start_link);
>>
>> This will avoid an additional and unnecessary delay when 
>> 'cdns_pcie_retrain()' retrains the link.
>>
>> Instead of checking for the link being up using "pcie_link_up(pcie)", 
>> checking for 'ret' being zero should also work (ret being zero indicates 
>> that the link is up).
>>
>> Since configuration space accesses will not be performed until 
>> cdns_pcie_host_start_link() completes executing, it should be safe to 
>> switch to the above implementation.
> 
> Hi Siddharth,
> 
> I think this is applicable to LGA IP as per the method you mentioned. 
> However, for HPA IP, additional repetitive code needs to be added in the 
> following code.

Yes, additional code is required as you rightly pointed out, but the 
problem I was trying to address with your patch is the following:
	cdns_pcie_host_start_link()
	  calls cdns_pcie_host_wait_for_link()
		Link is Up and we wait for 100 ms here
	  calls cdns_pcie_retrain()
		  calls cdns_pcie_host_wait_for_link() a second time
			Link is Up again after retraining and we wait and
			we wait an additional 100 ms here.

Instead, it will be sufficient if we could wait just once after 
cdns_pcie_retrain() returns.

> 
> Regarding the "quirk_retrain_flag" tag, I reviewed this submission record 
> and it appears to be a workaround method. Can it be considered that it is 
> not a universal method? Or is the same processing logic also added in the HPA?

I am not sure, but to the best of my knowledge, the quirk is not applicable 
to HPA.

> 
> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host-hpa.c b/ 
> drivers/pci/controller/cadence/pcie-cadence-host-hpa.c
> index 0f540bed58e8..65159f52067d 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-host-hpa.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-host-hpa.c
> @@ -305,6 +305,15 @@ int cdns_pcie_hpa_host_link_setup(struct cdns_pcie_rc 
> *rc)
>          if (ret)
>                  dev_dbg(dev, "PCIe link never came up\n");
> 
> +       /*
> +        * As per PCIe r6.0, sec 6.6.1, a Downstream Port that
> +        * supports Link speeds greater than 5.0 GT/s, software
> +        * must wait a minimum of 100 ms after Link training
> +        * completes before sending a Configuration Request.
> +        */
> +       if (pcie->max_link_speed > 2)
> +               msleep(PCIE_RESET_CONFIG_WAIT_MS);
> +
>          return ret;
>   }
>   EXPORT_SYMBOL_GPL(cdns_pcie_hpa_host_link_setup);
> 
> Best regards,
> Hans

[TRIMMED]

Regards,
Siddharth.

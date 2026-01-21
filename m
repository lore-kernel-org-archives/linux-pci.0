Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013070.outbound.protection.outlook.com [40.93.196.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D924D3ECBEB;
	Wed, 21 Jan 2026 11:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768995373; cv=fail; b=Bs0FFSA96JGBJ9L/yq184FXSV8DozzfUeIFdZN5wTuj6fIDEiw/5VKE+zK8zX1koW4Maea5pJGXTUU1WqGxOqFi++O1DYy2roxP+7NxcbuN77VTRmnKpgYgmdWpL05ZCnH7j/7dpHQbqqRRMbDyti+7DoqswDNMyD5g0LcdcmVA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768995373; c=relaxed/simple;
	bh=mjvABaYTcI3+B4gqOiMx4zutpMcwmo4YNKNBrJoIAsk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OXquvzMIRAeyrTkoWDrchKv43X3kCvT5I/QEXAD8GR3YQeolDBuIM3vI9P7I1zZcSMqi1QVdEWzFWDHmzb6cCcF+86YfIN35zkuvRkGnvcHTtuxb8krGo9EbI8XiZ/ENHCGi6c920/s94ri/GGYpktCO89G+u7gViWPtkCUGGOg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=V0WMnaaI; arc=fail smtp.client-ip=40.93.196.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="V0WMnaaI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mdHEO8/DuM9EbWaPTmm2+Mv5VWalPViuOoQ5ZiJpE5b09mEZb98MMBpcf7/YXmlLT7GhVH+gg86EGWS0tuGY9OyV81cbe7stjgayB72b7kcNtv3od0Skn/YsjaGNfQ4YybIdaC9iTVawRj0hkHXr+tv944C+toIHyeyrl432ZuMG2b38dHoI1U4GVyaQU80Qzhl0Cf02D1796CVQ7SqlQ58VTGYv0S16GAHV9Z7dsyIdHusZQUpZcsLEI45Lf/FLxLOqWEzVgtMAWLVYhwrM1C6ahV/RNiJMueCUWVa+stc+NC03kyeFVN8ty/0moyB1E9YiecBjZY+vYggKcYfF4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6XEW63xGv8klB6kVx4oTo3ZsJ/em8IS0YX6sv2fFql0=;
 b=KIg9IFcMYgeXs+0AitTUMoDZ2DKTqG7AoSONyemgHB8YrPEpxSH/gCqDRkvtYGFdIZGvUwXR9t5B2Zgs0iPvWW3cAzjX1Hylcxeg1XEj6/ztDyqKMAfbMhaqH/FQyKyxgbRgz6Ru4Gfs09RkwU/JVW9X1OffhGxigqx/WA6IB3+A7dpPXjA5vZuxqgBne6G5OGowtKSte+/J6L6blUlRrx6GGrY5MEPalXmoSa+deuIFkqoY+mQQr9rOIzwoNu3YgiZQjaH+HtAahzttZYbtb63z7ZAysrqNK6mY+JGbYkhUYsAOBhX26Y+bKbnWTdIPweMwC0Le6O42BSO3WyX0PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6XEW63xGv8klB6kVx4oTo3ZsJ/em8IS0YX6sv2fFql0=;
 b=V0WMnaaIU9OX87X3RtK+QwljBWU+3Nfp7tIHz/AMWOsyGsQP3tUmhh/KusFZjYgWd+WfRliGEG9GDXfmQ9P6ahIYx7HWcJ+1Wp6+2c36QPk144DHtajRofNmulZuc4RJjos94+9BmNkGDOkGzHG4sAMVc1N3pPxqMUhclHZEr6I=
Received: from MN2PR15CA0027.namprd15.prod.outlook.com (2603:10b6:208:1b4::40)
 by PH5PR10MB997732.namprd10.prod.outlook.com (2603:10b6:510:34c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 11:36:04 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:208:1b4:cafe::88) by MN2PR15CA0027.outlook.office365.com
 (2603:10b6:208:1b4::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.10 via Frontend Transport; Wed,
 21 Jan 2026 11:36:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 11:36:02 +0000
Received: from DFLE205.ent.ti.com (10.64.6.63) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 05:35:54 -0600
Received: from DFLE213.ent.ti.com (10.64.6.71) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 05:35:54 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 21 Jan 2026 05:35:54 -0600
Received: from [172.24.231.225] (a0507033-hp.dhcp.ti.com [172.24.231.225])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60LBZoJC2797796;
	Wed, 21 Jan 2026 05:35:51 -0600
Message-ID: <c7d4e9cf-8b0b-4f87-a354-d4f443da0964@ti.com>
Date: Wed, 21 Jan 2026 17:05:50 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] Re: [PATCH 2/2] PCI: dwc: ep: Add per-PF BAR and iATU
 mapping support
To: Niklas Cassel <cassel@kernel.org>
CC: <linux-pci@vger.kernel.org>, <jingoohan1@gmail.com>, <mani@kernel.org>,
	<lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <robh@kernel.org>,
	<bhelgaas@google.com>, <linux-kernel@vger.kernel.org>, <s-vadapalli@ti.com>,
	<danishanwar@ti.com>
References: <20260121054214.274429-1-a-garg7@ti.com>
 <20260121054214.274429-3-a-garg7@ti.com> <aXCaba4I0woHJCza@ryzen>
Content-Language: en-US
From: Aksh Garg <a-garg7@ti.com>
In-Reply-To: <aXCaba4I0woHJCza@ryzen>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|PH5PR10MB997732:EE_
X-MS-Office365-Filtering-Correlation-Id: 28ef153a-729f-4b21-7e87-08de58e141e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ODBVdnp2RnlVUWo2MC91ZGhicFBQUllkTjlpVHk3ajJQZytLb1Y3N0hIUnZ2?=
 =?utf-8?B?cGE3NHZqZlFGSkxSd09BTHhBTUZCUzk2VWRnaDR5MGFRS2M5QTJSQjhyQzZ2?=
 =?utf-8?B?NHMvZ2RZQ1AxWDFXZ1BkaUpkM3U5d3JhdXhnR0lCaGYzWnJHemJJZDZDbHdS?=
 =?utf-8?B?YTE5eHZhT2VXR0RYblJnUWxjdVVYdlUvbnVRWTdBMDk5eWlzc1lxM1h5U3l5?=
 =?utf-8?B?SmdUZWpvQzNGNlNjamQvMC9vWno2WXloUWRPcjdMMGQ4dUZaRTFWRTVvd3NB?=
 =?utf-8?B?TUUzNU9XVU40c0xGY0dmTVlwQjZpK3diZSs0ZU1TVWVGMDg2VVVTVE54VnIv?=
 =?utf-8?B?aktZZllyWkRwOUVaWnpPYkRTdTVSdk5uNWE1WXF6b09EN01CVzJleEVlaFNk?=
 =?utf-8?B?cHpMZzk3eXpmdVcwakJnMVZiMzBkWTBGVHpFMFQ0ZnhJYXN1VHlzNXR5TkVZ?=
 =?utf-8?B?OGZCVWFFcGtXQUM4L0QrOHI1Tld2SlNzTGY1MjF0cTVkb0hwSnJOd3l0bmdK?=
 =?utf-8?B?RUpzajczNGUyVklkUTlzdHFEbVhESGxIb0daaFc0YVdBczZ2Q1dFUjQxeWFu?=
 =?utf-8?B?TnB3M29UVUlpT3FQK0dIUTJpTXlmd1oweU00M1FkbnN5cTAzc3N4WkM4aTB6?=
 =?utf-8?B?MUJXOVMvRm5MVGprLzdyb2w3ZURQV0U5WS9GTndrdFREUGlqVXkyTDVUQ3pQ?=
 =?utf-8?B?eE1NT3IzSWU3WnBhanJaQjNldmg4ZWt0Rk14SjhXeFllbFhnaWZXclh1WFJ5?=
 =?utf-8?B?WDV1WXNueGhycERLSU1lcmRnQ1poZ0tMaXNxaEpQVEpmUmhDWnRqQTJTSkxH?=
 =?utf-8?B?UXp4bUNPdUdxTlhTY3NteHdXSFR6YlNoaXNHQVpRb0VUdjhvOGlteU1kVzBs?=
 =?utf-8?B?TnRvQ2lFRTZaSHRoMjU1R3NrVHU0dTA2dUVpbkNTYWYyNFZPWnd5eXhlTmdE?=
 =?utf-8?B?RUhjemkzekxydnRlQVZaMjFuQXZ3Q3ZDT0V0TW5WbnoxVllpd09oYlovV2Vw?=
 =?utf-8?B?SDM4S2loYWR4bzNmWEJ1YUFMMWl1d0F6U3FKRTJwdytDc1FYdzI2MmdUNm9m?=
 =?utf-8?B?dngwSzROVDQzS0lUUlpiMlpGMkpXbDZXbVRRNjg4THdtcmRaZisrWUNmMUJH?=
 =?utf-8?B?OUtrZGJWb0xFc25EZ0JXYk5LVkMxbU9wQVBLSFVTK1o3ejhCeFhMbHhyK09V?=
 =?utf-8?B?RktxaFVhVWdHS05rQU1JSDBqSGlVaGhJTloxelF5N2FRa2FpcVR0S0Nrc2dn?=
 =?utf-8?B?OEpsTW15YXp4K1A2djBpZW1sSU9iTkV5ejZqeTl5YWdXNm11KzlMaXIvdVM5?=
 =?utf-8?B?RGU5dGFYWEJxcHc3V0dZcE1UbWxMbkdPRlM4RC9hM2FxVEdIZms0Z3lHMVBw?=
 =?utf-8?B?bGZkQkZlN3VSNzk0MHVJbWFQdFNNaDBnQUlaTkR0cjl2bG1QcXRBektRYWdv?=
 =?utf-8?B?anV6RWRmallmUFNCcmNDWHFDclhnSFB1ZlkvYkMzNjR2bkVTb0hPaXM0Zmh4?=
 =?utf-8?B?a1dob2VNdWRzUk51cXhjVzRFdU96RmNKK3JDb05jRkVQMUppVVU5NjZPOVYy?=
 =?utf-8?B?dUx0SDUrL3NPQjhIbVJkNFBxaHRSdXJkYjRlcGs4TEVkbkFoL0ZrckV1UUpp?=
 =?utf-8?B?QVBaRk9NWWNuZHkwY05vcUtQU2NrTGJYRlowR1JvTUJCRitLQnJyQ3hMUTBk?=
 =?utf-8?B?TkJROHdsajU1TG1QQ1dWcWtQQTc1TnZySVRuWWFVN0czVXIrYnFWTE0wVm15?=
 =?utf-8?B?eTVVTmxmU3Z0QmhNWXlMSjdsK1NZSk9qd1ViVlJ1Y3pDTDBjUlh5QW1PenEw?=
 =?utf-8?B?TVdlYWI5cnNrYmdqdmwyUTBrZWtMOWY0OTY2dFBKRnJFRGlhUTcreGJqQ05j?=
 =?utf-8?B?UzROSnRJcmtrbllTblBva3FyK09NelQ3UEtnV1pSMTJRVWNKUHJRa1owUVZR?=
 =?utf-8?B?M0E0R2ZIU01CK1U0a3l0RzQzYXlhQ0x1ckV5SmdoV2tYYkZudHhCbUp6eDZC?=
 =?utf-8?B?Y29STnJld2FlZjVMRjFoSnc4Y2wrQ3hBSGEyanl6eFZhVlhOUndJMEQrVlIx?=
 =?utf-8?B?RzFwcThSVzBGVFhPakRJN0NOYTVqaEVnQU1rQnVHN1RjdzRTdU1wZm1iaE5H?=
 =?utf-8?B?OEhodGFnUnpnRk9BOTAvRGh4ZGR1dUlDQTluZHkwQUM5S09Ccm9WU0J3VjBF?=
 =?utf-8?B?ZkVYYlJBV002QWNKSGsyMUJ2TnZzRUhwcGxmRGdzNkJURXhSYTdYRkVvaWxM?=
 =?utf-8?B?QnJpVG5xRHFpb2NrNWgwNHBkWUpRPT0=?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 11:36:02.8183
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28ef153a-729f-4b21-7e87-08de58e141e2
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH5PR10MB997732



> On Wed, Jan 21, 2026 at 11:12:14AM +0530, Aksh Garg wrote:
>> The commit 47a062609a30 ("PCI: designware-ep: Modify MSI and MSIX CAP
>> way of finding") adds support for each physical function to have its
>> own MSI and MSI-X capability structures by introducing struct
>> dw_pcie_ep_func. However, BAR configuration and iATU mappings are still
>> being managed globally in struct dw_pcie_ep, meaning all PFs shared the
>> same BAR-to-iATU mapping table.
> 
> You are mentioning commit 47a062609a30 ("PCI: designware-ep: Modify MSI and
> MSIX CAP way of finding"), but you should probably also mention commit
> 24ede430fa49 ("PCI: designware-ep: Add multiple PFs support for DWC")
> which added support for PFs in the DWC driver.
> 
> That is the commit that is incorrect IMO. You cannot add support for PFs
> and then have a different EPFs over overwriting address translation for
> other EPFs. The design was simply broken from the start.
> 

Yes, the commit 24ede430fa49 is indeed the culprit for this issue. Maybe 
the way I wrote this commit message confused you. I was just referring 
to the commit 47a062609a30 saying that as this commit added the feature 
for each PF to have its own MSI and MSI-X capability, I wanted to move 
bar_to_atu and epf_bar per-PF as well, such that each PF should have its 
own epf_bar[] and bar_to_atu[]. The index passed to these fields should 
be unique across PF+BAR combinations while the current implementation is 
only keeping it unique across BARs but not PFs. This results in 
overwriting address translation regions across the PFs.
I will rephrase the commit message and add fixes tag for 24ede430fa49.

Please provide your input whether the above explaination is sufficient. 
Should I refer to commit 47a062609a30 as an example in the commit 
message, or that would not be required given the above explaination is 
added?

> 
>> 
>> This creates conflicts when multiple physical functions attempts to
>> configure BARs independently, as they would overwrite each other's
>> iATU mappings and BAR configurations.
>> 
>> Move bar_to_atu and epf_bar from struct dw_pcie_ep to struct
>> dw_pcie_ep_func to allow proper multi-function endpoint operation,
>> where each function can configure its BARs without interfering with
>> other functions.
>> 
>> Signed-off-by: Aksh Garg <a-garg7@ti.com>
> 
> Fixes: 24ede430fa49 ("PCI: designware-ep: Add multiple PFs support for DWC")
> 
> 
>> ---
>>  .../pci/controller/dwc/pcie-designware-ep.c   | 50 +++++++++++++------
>>  drivers/pci/controller/dwc/pcie-designware.h  |  4 +-
>>  2 files changed, 37 insertions(+), 17 deletions(-)
>> 
>> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
>> index f222677a7a87..769602b58bd7 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
>> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
>> @@ -153,11 +153,16 @@ static int dw_pcie_ep_inbound_atu(struct dw_pcie_ep *ep, u8 func_no, int type,
>>  	int ret;
>>  	u32 free_win;
>>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>> +	struct dw_pcie_ep_func *ep_func;
>>  
>> -	if (!ep->bar_to_atu[bar])
>> +	ep_func = dw_pcie_ep_get_func_from_ep(ep, func_no);
> 
> There is no reason why this can't be initialized on the same line as your are
> declaring the ep_func variable, just like we do for other variables, e.g.
> struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> so please more the initialization to same line as the declaration.
> 
> 
>> +	if (!ep_func)
>> +		return -EINVAL;
>> +
>> +	if (!ep_func->bar_to_atu[bar])
>>  		free_win = find_first_zero_bit(ep->ib_window_map, pci->num_ib_windows);
>>  	else
>> -		free_win = ep->bar_to_atu[bar] - 1;
>> +		free_win = ep_func->bar_to_atu[bar] - 1;
>>  
>>  	if (free_win >= pci->num_ib_windows) {
>>  		dev_err(pci->dev, "No free inbound window\n");
>> @@ -175,7 +180,7 @@ static int dw_pcie_ep_inbound_atu(struct dw_pcie_ep *ep, u8 func_no, int type,
>>  	 * Always increment free_win before assignment, since value 0 is used to identify
>>  	 * unallocated mapping.
>>  	 */
>> -	ep->bar_to_atu[bar] = free_win + 1;
>> +	ep_func->bar_to_atu[bar] = free_win + 1;
>>  	set_bit(free_win, ep->ib_window_map);
>>  
>>  	return 0;
>> @@ -211,17 +216,22 @@ static void dw_pcie_ep_clear_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>>  	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
>>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>>  	enum pci_barno bar = epf_bar->barno;
>> -	u32 atu_index = ep->bar_to_atu[bar] - 1;
>> +	struct dw_pcie_ep_func *ep_func;
>> +	u32 atu_index;
>> +
>> +	ep_func = dw_pcie_ep_get_func_from_ep(ep, func_no);
> 
> Same comment as above.
> 
>>  
>> -	if (!ep->bar_to_atu[bar])
>> +	if (!ep_func || !ep_func->bar_to_atu[bar])
>>  		return;
>>  
>> +	atu_index = ep_func->bar_to_atu[bar] - 1;
>> +
>>  	__dw_pcie_ep_reset_bar(pci, func_no, bar, epf_bar->flags);
>>  
>>  	dw_pcie_disable_atu(pci, PCIE_ATU_REGION_DIR_IB, atu_index);
>>  	clear_bit(atu_index, ep->ib_window_map);
>> -	ep->epf_bar[bar] = NULL;
>> -	ep->bar_to_atu[bar] = 0;
>> +	ep_func->epf_bar[bar] = NULL;
>> +	ep_func->bar_to_atu[bar] = 0;
>>  }
>>  
>>  static unsigned int dw_pcie_ep_get_rebar_offset(struct dw_pcie_ep *ep, u8 func_no,
>> @@ -349,11 +359,16 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>>  	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
>>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>>  	enum pci_barno bar = epf_bar->barno;
>> +	struct dw_pcie_ep_func *ep_func;
>>  	size_t size = epf_bar->size;
>>  	enum pci_epc_bar_type bar_type;
>>  	int flags = epf_bar->flags;
>>  	int ret, type;
>>  
>> +	ep_func = dw_pcie_ep_get_func_from_ep(ep, func_no);
> 
> Same comment as above.
> 
> 
>> +	if (!ep_func)
>> +		return -EINVAL;
>> +
>>  	/*
>>  	 * DWC does not allow BAR pairs to overlap, e.g. you cannot combine BARs
>>  	 * 1 and 2 to form a 64-bit BAR.
>> @@ -367,14 +382,14 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>>  	 * calling clear_bar() would clear the BAR's PCI address assigned by the
>>  	 * host).
>>  	 */
>> -	if (ep->epf_bar[bar]) {
>> +	if (ep_func->epf_bar[bar]) {
>>  		/*
>>  		 * We can only dynamically change a BAR if the new BAR size and
>>  		 * BAR flags do not differ from the existing configuration.
>>  		 */
>> -		if (ep->epf_bar[bar]->barno != bar ||
>> -		    ep->epf_bar[bar]->size != size ||
>> -		    ep->epf_bar[bar]->flags != flags)
>> +		if (ep_func->epf_bar[bar]->barno != bar ||
>> +		    ep_func->epf_bar[bar]->size != size ||
>> +		    ep_func->epf_bar[bar]->flags != flags)
>>  			return -EINVAL;
>>  
>>  		/*
>> @@ -420,7 +435,7 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>>  	if (ret)
>>  		return ret;
>>  
>> -	ep->epf_bar[bar] = epf_bar;
>> +	ep_func->epf_bar[bar] = epf_bar;
>>  
>>  	return 0;
>>  }
>> @@ -782,7 +797,7 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
>>  	bir = FIELD_GET(PCI_MSIX_TABLE_BIR, tbl_offset);
>>  	tbl_offset &= PCI_MSIX_TABLE_OFFSET;
>>  
>> -	msix_tbl = ep->epf_bar[bir]->addr + tbl_offset;
>> +	msix_tbl = ep_func->epf_bar[bir]->addr + tbl_offset;
>>  	msg_addr = msix_tbl[(interrupt_num - 1)].msg_addr;
>>  	msg_data = msix_tbl[(interrupt_num - 1)].msg_data;
>>  	vec_ctrl = msix_tbl[(interrupt_num - 1)].vector_ctrl;
>> @@ -845,11 +860,16 @@ EXPORT_SYMBOL_GPL(dw_pcie_ep_deinit);
>>  
>>  static void __dw_pcie_ep_init_non_sticky_registers(struct dw_pcie_ep *ep, u8 func_no)
>>  {
>> +	struct dw_pcie_ep_func *ep_func;
>>  	unsigned int offset;
>>  	unsigned int nbars;
>>  	enum pci_barno bar;
>>  	u32 reg, i, val;
>>  
>> +	ep_func = dw_pcie_ep_get_func_from_ep(ep, func_no);
> 
> Same comment as above.
> 
> 
>> +	if (!ep_func)
>> +		return;
>> +
>>  	offset = dw_pcie_ep_find_ext_capability(ep, func_no, PCI_EXT_CAP_ID_REBAR);
>>  
>>  	if (offset) {
>> @@ -876,8 +896,8 @@ static void __dw_pcie_ep_init_non_sticky_registers(struct dw_pcie_ep *ep, u8 fun
>>  			 */
>>  			val = dw_pcie_ep_readl_dbi(ep, func_no, offset + PCI_REBAR_CTRL);
>>  			bar = FIELD_GET(PCI_REBAR_CTRL_BAR_IDX, val);
>> -			if (ep->epf_bar[bar])
>> -				pci_epc_bar_size_to_rebar_cap(ep->epf_bar[bar]->size, &val);
>> +			if (ep_func->epf_bar[bar])
>> +				pci_epc_bar_size_to_rebar_cap(ep_func->epf_bar[bar]->size, &val);
>>  			else
>>  				val = BIT(4);
>>  
>> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
>> index 31685951a080..a4d1733f5c6a 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware.h
>> +++ b/drivers/pci/controller/dwc/pcie-designware.h
>> @@ -463,6 +463,8 @@ struct dw_pcie_ep_func {
>>  	u8			func_no;
>>  	u8			msi_cap;	/* MSI capability offset */
>>  	u8			msix_cap;	/* MSI-X capability offset */
>> +	u8			bar_to_atu[PCI_STD_NUM_BARS];
>> +	struct pci_epf_bar	*epf_bar[PCI_STD_NUM_BARS];
>>  };
>>  
>>  struct dw_pcie_ep {
>> @@ -472,13 +474,11 @@ struct dw_pcie_ep {
>>  	phys_addr_t		phys_base;
>>  	size_t			addr_size;
>>  	size_t			page_size;
>> -	u8			bar_to_atu[PCI_STD_NUM_BARS];
>>  	phys_addr_t		*outbound_addr;
>>  	unsigned long		*ib_window_map;
>>  	unsigned long		*ob_window_map;
>>  	void __iomem		*msi_mem;
>>  	phys_addr_t		msi_mem_phys;
>> -	struct pci_epf_bar	*epf_bar[PCI_STD_NUM_BARS];
>>  };
>>  
>>  struct dw_pcie_ops {
>> -- 
>> 2.34.1
>> 
> 
> With minor nits fixed:
> Reviewed-by: Niklas Cassel <cassel@kernel.org>
> 
Thank you for reviewing the patch. I will fix these minor nits.

Regards,
Aksh Garg

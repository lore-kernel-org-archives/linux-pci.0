Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010033.outbound.protection.outlook.com [52.101.201.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE216314D34;
	Tue,  5 May 2026 08:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777971078; cv=fail; b=rWQ2eZWzXjJ7HWM0mnPrE786iEvOyI628Bc25Tq8PfK6TkUspIzlfARUS/cXrzjBh2n5fNIFqddeczIir5J86N60WPtIWRvLy9fJF8KUU+yl2WeF9KIXFDVUmogyvwERh+CgKhm5/T0dIxy3mbqA7o+XBVMjgvmQ01sh+Qu1pLQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777971078; c=relaxed/simple;
	bh=uTBN7tgoiEuoPxJ02ChOjDdouxG6ZW94NGrZfu6myn0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bpNg6vYbhAXIJNw5Bg6QjGdInGNgBvyHw6YcaeYJYLeL07UpzXyHJh9AgL/JS9QJIF0kjcQY5aHpYNvZjAbilziUJodsYVn5YdUzsIk5eBqShjiQGlGEXoBs1C7YjjemauqcWov+YwhQNwePlVrDo3CojLQVR7u+sxNrXwT/SJ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IoPqVN3O; arc=fail smtp.client-ip=52.101.201.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IoPqVN3O"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=psDoinY/l3/iGwIujDX2yXVEp4WYyWpRfziVrpSsQdORn78AFO9/Pf8TRfAiEdCurV+y5q9v1i1/BqGtEhHDL/QP+4Yxqu5RuGFV34iIjTCwLSX4CbuKfxk0jWELlWO3QrM1u6oTqmWv38sXDQVJohHDbU8xoaXS8AqkJFhECyy/yYkywrxFUtUxVJOScVkVBPapzf+xZikICiEQKhRDleq3ho+EKkwFdaVZf1pRag/Otn9Mq6JJ46Rscmv9M7L2z5x/u6GA4B32xBrxESlNDs0mn/n/m4JCRO7RWf5RZ9JleSHJtR1tGb4b/S6V4+VTs82Rcmu7YAbfU/+HVHcmqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NPtH1RI9X7X6N84MRcV5V3PhqTmdLvMgBPNYZ9nnhoI=;
 b=UzSprzPLQLjRcN3SAZ9jiXiir/ZAtBdOVWleHtLMwQL7D/J9rpogbYax6GT+UE6CtiGCRlEPJpmRS9ClD5ZG9DtrxLX3Q+7UCN00sGG81ayf9t2tIcVcy9p5GM5JuqOppCyRfqbM17Q8tb7vc8L0CFNswu20NdjNapZCVki0cKi6gKdXgK+Of/z4v9AuiEyOeKTEfNsv7NZH7go8eXgrHdStgAnXH/GPkeigF5p3NN8vRmshAD56gSPnkhHrWMybOYKrn8fH9Jy2sVGjDFsvvdxw10sm9EOaMsuUFh1sv8hAtbW+2mDEbVEP71ofAYhytnABKLLhWjPT9XNv7cfPlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NPtH1RI9X7X6N84MRcV5V3PhqTmdLvMgBPNYZ9nnhoI=;
 b=IoPqVN3OFLenlQ2UfnYSu7kGwcjXbdh22zg81jEPmpiMTZx7oDmEXiqrizH7AzxSeO+ueQFjueqm3Z75RDuChUg0zZxHm2VhZQLQWqIU7gJTts0La59MPLggORPC0xNcxvf+WMU/JE99+Ot5SBjieNFXwnpo2DMx211p5CjK5kZ/nWsnjAM32ng9a2Css04uXlt23CU6NKEoJV1zerjGo2Dsze29LNumsUP3fy/cNhJUB1P7/L3mRDMG8rxbZAev+DIZhvfJFcVYqpGkbYGYLT4+YVMtq8d3njihGaK+w5rLvZx0mlLr+U/m4FQuBte6dRxltIgsvRKqnvAk4heMHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9750.namprd12.prod.outlook.com (2603:10b6:8:2b0::12)
 by SJ1PR12MB6100.namprd12.prod.outlook.com (2603:10b6:a03:45d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.27; Tue, 5 May
 2026 08:50:58 +0000
Received: from DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391]) by DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391%6]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 08:50:58 +0000
Message-ID: <58f54b48-7c06-4564-9ec9-d1efb1cb8687@nvidia.com>
Date: Tue, 5 May 2026 09:50:52 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: tegra194: Use aspm-l1-entry-delay-ns DT property for
 L1 entrance latency
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>, bhelgaas@google.com,
 lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 thierry.reding@gmail.com, kishon@kernel.org, arnd@arndb.de,
 gregkh@linuxfoundation.org, Frank.Li@nxp.com, den@valinux.co.jp,
 hongxing.zhu@nxp.com, jingoohan1@gmail.com, vidyas@nvidia.com,
 cassel@kernel.org, 18255117159@163.com
Cc: linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260410073330.837238-1-mmaddireddy@nvidia.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20260410073330.837238-1-mmaddireddy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR3P189CA0061.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:b4::6) To DS2PR12MB9750.namprd12.prod.outlook.com
 (2603:10b6:8:2b0::12)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9750:EE_|SJ1PR12MB6100:EE_
X-MS-Office365-Filtering-Correlation-Id: 6811f488-5e1b-4908-d87b-08deaa836d47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	/DAUyhpF0J58rD23LMgS03sGwKMoOlq2wv9KYwwK5hQZ7pjXJddxv5T3A2WyL84Lbf1DSHJLZwmHzynWqjW6ypXyUk34bfdXPAVinfRFTfUcu1ICqqKuTXS3mfs0Ka5WAbfLN73xjHj0GTcoUPo3DVztAxFRe97r7m8PjEpCj2doveqCCgXrjwCWUCVEW9u/S17hW0PGX/EJz1k7n1Ner2huzwXIGz1b1IqRFbc38r8cjwbyx/VNkvtGrpjJ9qKPZZtwrKSMJmdbUfMHewzzv5AiYE/kjBOTIy6ZrIetPvMlr8mavWXGF3PxNbFFA3MN1dOPfrs8nJY9mH+7uEouRxd5uyAWisnBKYuhhV0mVtzyI0MrOcNFmtX9CulB7LtE7z7waqag9+yiF5q+5pbJsEny5avtDf5ojfwaQB4JFUHTDBeHCJqKBY9Q9JWuRe+XcSRd+UTpylaFGGqN5WAFgOWGPDEqzbix9rr0uhByg/80iZg+SWQvfV9ESLdYFXfZNFSL8CnkAJXjR54wWfg1UJ/LBSKewhP5HU8pc4qTPTgceQ4HGRga+LUA/vRhL7ugg3DLQqTOtOfg+8DWzWvLtxEBobvUThCrPXiQqlyAxgLUk7gppIpWpHbdnXyUsQcTpgEPlqOdLr4BmQB3mp3WK4PFiJxAHvw6Di1VE3qASQzW6k231WzuMVut5c2GBuW8V76yIufC59vJPLRlnz2rxLdNMAAV7E04vu3CGRNbvAM3dAzhZSpFHPRh6pepr+x1
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dERZektYSFB0YzZLWExtQzlsQU1wL1VyMzhwcys0clIxSE12QjZSSk1RNytQ?=
 =?utf-8?B?MWw1bTlobzNCT295SWx6MDdKZDNocTE3NGxhbWRJd2d3QzMyQTB6MFZCWVNL?=
 =?utf-8?B?MzNCWE1xTTFwZ01Waml6cVA2eWhlV3Y1Q1VJU2lJU2F0QXBnSWdiQmRhcU1Z?=
 =?utf-8?B?SW1kOTA2M0Q3ZHFPd3U3VWlieVY3UjZDNnNWUjB3TXVSWVhTZ0NjL0MvL1pF?=
 =?utf-8?B?YlZJQy9yN0pzRUFucGdlMVJIRUNJRzBFR3dITFBwOEJrZDR4YXVRNkk2Mmc5?=
 =?utf-8?B?VzJiUmh2eDZyUEF6aFZJNU0rbDg4ZHF0ZE1LK2VZdTIvdTUwNGJvQzlHamJX?=
 =?utf-8?B?Zlp2SzZWZjhROXhESXhmc0c1NlppMms4dGsvWWRVWUZ6dlU5dnVZK1hpOU9H?=
 =?utf-8?B?TEZTZUlxQTlGTXJWSGVBbUlPZ2Y0bGs1UFhrV1didEZ6dVVGcVJ0RU42VEpM?=
 =?utf-8?B?ZlRva1g3bGN1SjVmUDBCRnVKSDhLMWh4R2hxR3g3T3dzSE9hSFhDUWg2QTdL?=
 =?utf-8?B?WGVDU0tXenpscFF4OGZtUXBCYTh2bWVWU2t6SFlNZjJ3eXdVblY4MWNRQXdU?=
 =?utf-8?B?TTFEUWU4TFNpSjJsV0dyWGEvcXFpaXRwS05VOGl6TmsvQ2dQa25keGFDNjNL?=
 =?utf-8?B?a2lKZWxzWlNmM0dsamxiVk9mUjBUVVNOQlhjait0TnkxMmpzUlNUNGgzZU1n?=
 =?utf-8?B?Tk9KS0pVL290RWh3d3NaMFdiaGIxaVZSL2wrcW5ndWVpZnZaY083UW1GSlZk?=
 =?utf-8?B?ZlBDcmcxazJLdk1nU1dzYjdRME9oaXZ3bExJOGZOQ1dsRHNobjJCendvRjA0?=
 =?utf-8?B?Uy94YnhZTVhVSWtSRENIZ0ZRWjUvWnNPTTRIc0xnQmFGa0dZaVg3eTBaRHlQ?=
 =?utf-8?B?UE5MdnQwbjFRSlNpLzYwd21td3NqRm0xd1Ewa2RBbmNaRkx0MGlDY3RieDR4?=
 =?utf-8?B?Z0hOZVlmN1ltdEVwTHBBRERwWldzYTg2QjFWdHg0ZG9TRzNaL3FMcENCd1Jl?=
 =?utf-8?B?clVpZ2N0ZkhxWFRZbjR4MUVBdUt1d1BFS3V6MGFGeFBaeUlJSWlhQnhSQjJK?=
 =?utf-8?B?UEdlNU1EdlpnalAvOGtkdFpDdHdBN1BFTmtkM0MrNW9HME0wd0JzYjJ0aTBB?=
 =?utf-8?B?Ry96U1ZoZHY3dmhEV09NdUV2TS9zeDR0SVJ6ckhiNHBJb0FWUWl0VXlVQ2d0?=
 =?utf-8?B?anFBdnFRV2lTbG50S0V3dklzck1pYmtueVhjUDdXMHN6RjRKSmxDWGhMYkFp?=
 =?utf-8?B?VDgyZnJ1Y1lTRlcxa1BDV2d4eXpYK3lwSFczeGo2WWtvVVBIcisxS2kvSm5j?=
 =?utf-8?B?ZTdtc1BTR05ZNDdkSzhtbWMzWC9odEhlTFFWZWwyTkc2SzN5bnRZd1IwbFBy?=
 =?utf-8?B?TXlMQ3MwOU02ZU13TEl0b3M4ZDhaUnNYWHNQMUhKOWJNb0k1TWxmeEJUV2xQ?=
 =?utf-8?B?dU5ZcGRZVkhKbHJoL2MxL1RqaGc3TzQ4aFB0MkRISzI3dWQxZW9sTk45bWdO?=
 =?utf-8?B?RVpvdWpzWlo1UWVoTzVrSkRpd2g1c1l4dm1FS2ozVmduRC9jZzhVdmpzUUZO?=
 =?utf-8?B?cFI1OUZ3WXpyVVlhZnVLclJCWWlKWnJ5M0tuK3NDenVVN1dmZmJGeW5tL3pz?=
 =?utf-8?B?cHRXVFduZTllT2NiVnB4VUVSdFMvZFBGQ0Z0N3A1dDNkVGdjTHpOTkZGTjBu?=
 =?utf-8?B?amxPZjB2N2ZFZVIvdnlYRCtuLzYrRFRlZmhnR0lCWEpaR1l1QUNvM1E1cUxz?=
 =?utf-8?B?dTk1T0lLUnM3RjllcFhRK1dDdzdwVkx2NjlTSFkzV3pCUWlJdkdxeHYwaEN6?=
 =?utf-8?B?ajdUU3ZaRlBnMFBod3ZsK0MxUmREMHRNY0djNkxXeEFVVUxJOG93bld3NGVo?=
 =?utf-8?B?NU5mRXVxL0ZRUllydUU0b3F0d1ZLQzZ3dHFqbUZHNzRuYmVvbUFWd1BYakN2?=
 =?utf-8?B?dVdLaDh6QjFGV0dBdWtmMXhqby9wSXRRTXRGRndVZVZOWE9CK1hTVXliblR0?=
 =?utf-8?B?eEErTnNlZnBoRWxHZjBzTm1xMWR0c0l0M0dxZVBFVDZiKzRLdVZObWRhQVBD?=
 =?utf-8?B?K3Jsa2kwUUdMdlpjcDVvWHBYbXczdnZLRkIyeEF5ODBJeWlhREJTNWQ0bjE3?=
 =?utf-8?B?blBtQUhiV0ZRaS95aEswa2hsSVF6YUVjWDVRTjRGUGN2YUVyUXZZaXJURnRW?=
 =?utf-8?B?TEY5Nmo2MGdPOUhtK3NXMUtOQlBzUWU2QjRnYityZ0Yybzl2R3NYTzk1dlRN?=
 =?utf-8?B?a2FlWHJORllwa0ZxeWkrSTJvMDlQNGpobU1USzRrbDNMMEZGVkVIWnRCMVBI?=
 =?utf-8?B?OExjbUhKSytma251cUpSbVNxRzR0NmlobVUySkc1UktYVGVIZ3VIUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6811f488-5e1b-4908-d87b-08deaa836d47
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 08:50:58.5011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BYYrJzUEht7dYhRMsZnLtij8v7SLIOofZyhkOCCclpNVYK9ZwwVJxsYcFmwcMOSpYZv7PKnzVgVotJgrs5W2ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6100


On 10/04/2026 08:33, Manikanta Maddireddy wrote:
> Program ASPM L1 entrance latency from the optional aspm-l1-entry-delay-ns
> device tree property instead of of_data. Convert the value from nanoseconds

Is the 'instead of of_data' relevant here?

> to the hardware encoding (log2(us) + 1, 3-bit field). If the property is

Its says 'nanoseconds', but the equation above references uS. I see 
below you convert ns to uS and then take the log2. So I guess this 
should be 'log2(ns/1000) + 1'. Also the '3-bit field' bit is not very 
clear. So may be ...

"Convert the value from nanoseconds to a hardware encoded 3-bit value 
that is equal to log2(ns/1000) + 1. If the property is absent or greater 
than 7 (the maximum latency value supported), then default to 7."

> absent, default to 7 (maximum latency).
> 
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
> Link: https://patch.msgid.link/20260324191000.1095768-10-mmaddireddy@nvidia.com
> ---
>   drivers/pci/controller/dwc/pcie-tegra194.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index 50c5ef12552b..f171f7e32b75 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -18,6 +18,7 @@
>   #include <linux/interrupt.h>
>   #include <linux/iopoll.h>
>   #include <linux/kernel.h>
> +#include <linux/log2.h>
>   #include <linux/module.h>
>   #include <linux/of.h>
>   #include <linux/of_pci.h>
> @@ -272,6 +273,7 @@ struct tegra_pcie_dw {
>   	u32 aspm_cmrt;
>   	u32 aspm_pwr_on_t;
>   	u32 aspm_l0s_enter_lat;
> +	u32 aspm_l1_enter_lat;
>   
>   	struct regulator *pex_ctl_supply;
>   	struct regulator *slot_ctl_3v3;
> @@ -710,6 +712,8 @@ static void init_host_aspm(struct tegra_pcie_dw *pcie)
>   	val = dw_pcie_readl_dbi(pci, PCIE_PORT_AFR);
>   	val &= ~PORT_AFR_L0S_ENTRANCE_LAT_MASK;
>   	val |= (pcie->aspm_l0s_enter_lat << PORT_AFR_L0S_ENTRANCE_LAT_SHIFT);
> +	val &= ~PORT_AFR_L1_ENTRANCE_LAT_MASK;
> +	val |= (pcie->aspm_l1_enter_lat << PORT_AFR_L1_ENTRANCE_LAT_SHIFT);
>   	val |= PORT_AFR_ENTER_ASPM;
>   	dw_pcie_writel_dbi(pci, PCIE_PORT_AFR, val);
>   }
> @@ -1110,6 +1114,7 @@ static int tegra_pcie_dw_parse_dt(struct tegra_pcie_dw *pcie)
>   {
>   	struct platform_device *pdev = to_platform_device(pcie->dev);
>   	struct device_node *np = pcie->dev->of_node;
> +	u32 val;
>   	int ret;
>   
>   	pcie->dbi_res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi");
> @@ -1136,6 +1141,15 @@ static int tegra_pcie_dw_parse_dt(struct tegra_pcie_dw *pcie)
>   		dev_info(pcie->dev,
>   			 "Failed to read ASPM L0s Entrance latency: %d\n", ret);
>   
> +	/* Default to max latency of 7. */
> +	pcie->aspm_l1_enter_lat = 7;
> +	ret = of_property_read_u32(np, "aspm-l1-entry-delay-ns", &val);
> +	if (!ret) {
> +		u32 us = max(val / 1000, 1U);
> +
> +		pcie->aspm_l1_enter_lat = min(ilog2(us) + 1, 7);
> +	}
> +
>   	ret = of_property_read_u32(np, "num-lanes", &pcie->num_lanes);
>   	if (ret < 0) {
>   		dev_err(pcie->dev, "Failed to read num-lanes: %d\n", ret);

-- 
nvpublic


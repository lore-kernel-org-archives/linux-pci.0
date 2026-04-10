Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010053.outbound.protection.outlook.com [52.101.193.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD4C39E164;
	Fri, 10 Apr 2026 07:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775806755; cv=fail; b=tkX38Pz5xWt89eUAVAI7WEk4aIJMpRqiu0LGvHA+n6+yHkM5HsrvawjsVDgMDOOQfGDVUsXS2FB+l+299x8VwlIv/0l0YzGtiw1if8XhbVtfHeT0nJXWz70EaXnl851uw+KzC2kLhJdDKjgoBCQssYq3en+vBl1mU4cgcu82cRY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775806755; c=relaxed/simple;
	bh=JjwrXAuaWwwXkMZQCyNHmQQ8S8D/tg6Tcaya1+DooHU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DV1xLH0v/mceDTZuCBX0GPOr9stm1BJB2k9YKlEFgSV+BSKlO/gv3Y/9vq3UEz8U3dBYABwTKf0nkrifxCRrfCZJZ/6KvolHNfBPH3P0+Lh/Pmo3XWAGjFdjsncSVE0tHtg5UYJP8v1PR0XiHfaaNsR9kk/YE/gIc7wL54xReEo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=W0EA+t+d; arc=fail smtp.client-ip=52.101.193.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="W0EA+t+d"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pwIQ2VQuZl0yqnBO3HulX139hKvJIuL2/yPwHR3AuQ9pjBl3C+MoHzEh3eDYk8rtcStEpWXKWcBOwcvEsH0IKDc17JmNUK3mKdfJtNmpT1n/rWYq24S6VHuDadT5wEgX4OdjPIWW0KKSe2Jip2xMfHilCcHLmMi3nQLg+9b7AKFy7kxjWOy83F3yhL0vL9K3bxtfdp5w4AOXvk0ztJ79N7yNXKG6ebYQMJGtp1XNHgrxWvv82Vna7hP9ol0qkuzXpvOUgT45oICQVf3w9ZMWimWB7A6r/jXCamShjLDaAfWvF/J74rthaGjpjNI6ZmZZIFjLDntdfxg+suOQmByrpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zX7/K9KpvF90wIriV0ZcM86svsQF8N3c+1ReIt1Uz5M=;
 b=Yq1P37HIQtLwaQECTz+JsmmnfMceRmkI2aTObRNrOq/jM8hXlg5kGUw3tDEnWB+yLhiqnilHgEq5mIg5b9D7t/F4Am16G9OFtu7RmMTZ3V33SvAj0ZaLol9/rshVZtuiN1Afu5vupx+9aCnOgL3Ckt4PTl6eaPGC4jRkrZafbuKKfkOmzewqdHrF0WKGkVH8J+aa11n4jS4zUM6mNhfku489q1RCm/9DC463TCQi6guRga/VFTOb9cMsUMnUgZRtGoPummQvRdj2XGczxMgrG6F1y+/GXrRLqrSY1wqGPyl8ckA4wMvJrBhuX+qL65FlScGqtWIaUWdkysh6LgReag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zX7/K9KpvF90wIriV0ZcM86svsQF8N3c+1ReIt1Uz5M=;
 b=W0EA+t+duylP/9KEbh9afDHkys8bHkpYBH09h/yELcJSqfVhfX/RdCXIBojPBjBaV1hEwi5YHvQdqevkGHXbV5EHzKLsl9Lo0QPnU31yJCuquGNIPWyz1pGVuOy3ymT7J1Aiz1Z2Cox1KQpkcr1HcsR1Q5XbfGkbq00/1u6Qb6Wm7SsG0Q7i8fR5kQyhyb4/mDY1sQ61fjQOZTanzfdld6+F4UDO7hycg6s3ZM/AswVJca4nV9g8mwUA9vrfmNWGtKZgrdt0Dy/VgeE3n3ogz+zAZ2CwEOP2gK/iM+k9nmKHsKYTa1NBVmdpf9y2Sqw/4Q77unfl2j6GgkDR7IW6Xg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB8245.namprd12.prod.outlook.com (2603:10b6:8:f2::16) by
 PH7PR12MB9150.namprd12.prod.outlook.com (2603:10b6:510:2eb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Fri, 10 Apr
 2026 07:39:01 +0000
Received: from DS0PR12MB8245.namprd12.prod.outlook.com
 ([fe80::e7c5:cfca:a597:7fa4]) by DS0PR12MB8245.namprd12.prod.outlook.com
 ([fe80::e7c5:cfca:a597:7fa4%4]) with mapi id 15.20.9791.032; Fri, 10 Apr 2026
 07:39:01 +0000
Message-ID: <afa89c48-f41a-4124-a19d-8aa6a79c2c7c@nvidia.com>
Date: Fri, 10 Apr 2026 13:08:48 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 9/9] PCI: tegra194: Use aspm-l1-entry-delay-ns DT
 property for L1 entrance latency
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
 mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 thierry.reding@gmail.com, jonathanh@nvidia.com, kishon@kernel.org,
 arnd@arndb.de, gregkh@linuxfoundation.org, Frank.Li@nxp.com,
 den@valinux.co.jp, hongxing.zhu@nxp.com, jingoohan1@gmail.com,
 vidyas@nvidia.com, cassel@kernel.org, 18255117159@163.com,
 linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260409184034.GA508609@bhelgaas>
Content-Language: en-US
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
X-Nvconfidentiality: public
In-Reply-To: <20260409184034.GA508609@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0046.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:81::16) To DS0PR12MB8245.namprd12.prod.outlook.com
 (2603:10b6:8:f2::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB8245:EE_|PH7PR12MB9150:EE_
X-MS-Office365-Filtering-Correlation-Id: 216a3051-4789-4619-80fb-08de96d43bb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	3xoa1RLEVFIqAD64grvY0cJ7+PL0QnYAQjdj8ToPFQB57VzxL6oqSbShIPxYDUzKWYnpyNvilp6i9GskmEHDT+bNGfT726X7nE+b5vnZQxviwalwvwC8mn0dmAANIHpKnEI8pyrFE/zzmwj5ErxfO7dh1WO0QpvpPSp1hAZybuDZPm/I3dmIih7L77W1kplqB13W/AUYLyoLkj4MueVYvC01NnGGJdfUUNjY+hF/VWxwkUyKzuryi28FW3RdoIRh9i4FwllDPOhj2tS9arOd1kr8FSSwbsLoZ2HIfypt3tvxMfUwZygYzFGm4sYt/nOCK0Y2wUPKgVUtKagiRbtj9BOJXoqveMJ3t687rp/yz5PhwC1kO9rvTZi+MJki69WiFWfaN4hXjuNEZppj0WyOgTrxHENtuDazNo5+lLDPd3QXon33KmE7sOIOIrplMFxgOgaHd1vEs6mGfMjFm9i8sxGdpVMkhNsgqtwPsJnL2Nd2lqiyj+oTMDpmuepBJLe431oFsOx1YN2PPF27yGX7MV9tLEPTn6LkI2oPw4GR4jfym9tI4dIyP80dbtWWPjXHm/WaOVRjFAxgCg8gNZQmFtvttiqvCQpOv1HBeTN7jJkqYZTMDwKLslWQ+uFNx/8lS3e4oTSWslQMLOojkIG39h0YraP0FyNq8FsPi0YWYDmTbPkBd9bfHe3ps0df4A71eOjQFSZcec5yqqmclzgjlLs+3GjBc5fPDzfRc131FpmY+3AqRyAmtj0h8221nFHr
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB8245.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZVMwTGpFditXaDRaVHdHRkEvVGNiT0hGSmRtVVJMSVk0RFh1RXM3OFR5QXZj?=
 =?utf-8?B?NDZlTFlMUHQ3N1hwS0l6ejY0VVlYZG1UOUM5R3RIdEpwd0ZsWTZYenMwNTdy?=
 =?utf-8?B?S2p5U1pFMjNCeko3RzQ2Q2E3QmRMOWwvdVpEaGxDWXgvMXk2WGNwMFQ2VjR6?=
 =?utf-8?B?dHZIS1JOZVVGcDNnMWJ0SXJPejRGZ1p6R2JBVzBVd05BbjVCRGZ2QWNZblV5?=
 =?utf-8?B?Qy9jaFR6bnRrOFh0MnRTQkxuZzlvdHhabjB0aStucm5zUkZzcnBzT0JWZExP?=
 =?utf-8?B?QlEyT053cmVVTGJrSzhRbWFQenhBMnlITHM1OTVrdHJaVmFCVmplZEw2aThy?=
 =?utf-8?B?QjdwYlllWDZqdTFsc0JUeG5tbndWRFNMTFFZRzUvbWkrZWl5aFpDM09iekU4?=
 =?utf-8?B?Yi9YbENteGtsWXMxSXhsZUl1SUJLOVdpbGVCejc2bjZobnFxa2d2WGFrME5k?=
 =?utf-8?B?MG43czJDL2tWcVM5WVhPZkZPaEEyR2w2dytObzFRS1BYZG83VFFUKzU0dkgv?=
 =?utf-8?B?Mkw4bEpCOVZWamd0RU5SdzRtV1o1RDlrWUxjNkE2VktCY1FSRG9tcU5JYlNm?=
 =?utf-8?B?WUJpUHdtNjRza2ZNYjN5K204N2pNZHdqV2UzMGdlQ2hDVzBzdjdISW4rb09S?=
 =?utf-8?B?MTVmSEdRWGVielhTaDlEMWtQVFp0d3RGOVZvOFZ6R2FuTXh1dHh0S1ZlS1d4?=
 =?utf-8?B?bFdJOHM2Q01KSWQ4a1hlcW5XajkxUENCeVlXMUJsOW5EaG9qWWZhYnExdmxZ?=
 =?utf-8?B?a0tRTG1RVWN4Y3l3VlJWOEQ4QjY3WlRBTGovVmxhNkFsUUt2K3hPcWU2VDBS?=
 =?utf-8?B?QnhBOHNINzEvMUhvcHBjc0hST1VIeTl2NDlySCswS1dlWTRXcFZuWDRhV2Fy?=
 =?utf-8?B?M0hLQjR2TFJQYWFodWsrRGFHM1Vyd3diRUdKQlVZKzJjSUQ0d2hGbXk0UFJa?=
 =?utf-8?B?Y09IS2RQZ0QvNWQ2YkJwQ1o0TUJLMlAzVTFsUGNFbnY5aUUvMzJwL2xrTHQw?=
 =?utf-8?B?R1UyQUlFZ3JoVHRrTm9GRGNLbjF6YjlVTGNvdHZpTmUxakVZbnJsWDV5YXFs?=
 =?utf-8?B?a0cvOWtwd21HYU1laitFSjBhRC9QV1ZXdzYrYkVGRWRLTGRDL2ZEUjF2akJs?=
 =?utf-8?B?dVNEc1F4WG5TVmN6MHlDakgrZ1JtSFEvTW90SjRTTmF3eUJBeEI3TTkzOGho?=
 =?utf-8?B?ZStxZmVQRzI1bEE2bmJTV0hYVFBlOXpQbXJrQ09BQWlXa3M4bGEzYU1veWNr?=
 =?utf-8?B?QnRTZHVCbFNwRjRvTFZ4ZTBWSlpaODUyTDRRREhzbTA2TDlKQmxQamF4d3Bp?=
 =?utf-8?B?K3NIRUkyMWtrUzBuVUhSRkRPMTF0S2t3cXZaRWVIWXQzT0JWdThsWFBPQnR1?=
 =?utf-8?B?RG04ZDNmRmR4NGpJMklFRGx5VEYyaWp5UWxFUHdIS24vc3JNb0dFbWdGbFRa?=
 =?utf-8?B?K3RFTUtWVjNkelo0ODIyNkhnRytxdGlyVWE2eWIvWmhaL3N3MGY4UjVXTWRl?=
 =?utf-8?B?bzZiQTJKR1YyZ2ZBVklvY1RvT3V6OTdTNmQxYVdQQ0l0NlVYdUhsMkxxWmZT?=
 =?utf-8?B?a2dsRU1XcE4yYjNwTHkxVzl6b0Z3Nm1taDZLbmh3S2t0Tjljc3RlbmJDdzYz?=
 =?utf-8?B?NnVtUmkvejUxdHkzQy8rZ245blVzalZZY1EvSnpma1hPcGVXRTVsM1M4a2po?=
 =?utf-8?B?YUFsSHhuYnVHM2x4RXZYSTk0enJ0cXB1WkR4NThOWDVJejdhNnhaWnJGbVUv?=
 =?utf-8?B?eHBNeGJ3Y3dkR0p3WFpHczFuZFhmdWJBTmtxRDgyNUxpRVJNQmg2OXhFVkl5?=
 =?utf-8?B?TnRsL09obVVoMlVtUEV2b25WOFhnR3hTMUhaOENmUThKSnJOaWRLaTRRQm1Z?=
 =?utf-8?B?T0ZhdkhXbjVRTHlDNEZETENjdkFJOU5jd29xUXJyUFNwL04va1hSS0VuQk91?=
 =?utf-8?B?RjlIbTBYOTdsbGFTVGh1UXI3MTNnaXM3RGd3cnZLcEY0UnFhTmRadTFwS2hm?=
 =?utf-8?B?eU5YYUNuQ1NSaHM2ZURkbDZ3aFdqZ2lFeExGZituZXBLNnVJTi80MzdqV1Fx?=
 =?utf-8?B?SDdUeCtTaWFhNUtGOHhKK0ZQNHpIMERjY2lKQlVYeitwQlNMNmFZcFdYQlJv?=
 =?utf-8?B?c1hCcTkvdmc1a2c5YXVoeVZQUDhKVWhtbTFCVE5uSFpOa3AvUnhUM2hGQ1lY?=
 =?utf-8?B?N0x4bk1YQ0pOUGVRZURmZStqNDMxSldRTm9zd1ZkbHRPUFdoVVVYNUZTRmFI?=
 =?utf-8?B?SThtaENvaDV4eHlYMFZmZ0pUbDg1SlhVSUZSQ29mT09LUUVOemVsbHZMVUR1?=
 =?utf-8?B?clNZdHcwYzJOK09rTVJud3dqT25YWnhVOEdWakdHdWc1QlBhaHNEdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 216a3051-4789-4619-80fb-08de96d43bb6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8245.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 07:39:01.4555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qZX8MSm8xuRD4nJvTqeM36HvHUvELz39XbZDZUgIRgfX3on1Prie2834NS0aes8YjYlriav48RkgdESNI91RMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9150



On 10/04/26 12:10 am, Bjorn Helgaas wrote:
> On Thu, Apr 09, 2026 at 11:26:15AM +0530, Manikanta Maddireddy wrote:
>> On 09/04/26 4:00 am, Bjorn Helgaas wrote:
>>> On Wed, Mar 25, 2026 at 12:40:00AM +0530, Manikanta Maddireddy wrote:
>>>> Program ASPM L1 entrance latency from the optional aspm-l1-entry-delay-ns
>>>> device tree property instead of of_data. Convert the value from nanoseconds
>>>> to the hardware encoding (log2(us) + 1, 3-bit field). If the property is
>>>> absent, default to 7 (maximum latency).
>>>>
>>>> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
>>>> ---
>>>> Changes V8: Use aspm-l1-entry-delay-ns instead of of_data
>>>> Changes V1 -> V7: None
>>>>
>>>>    drivers/pci/controller/dwc/pcie-tegra194.c | 14 ++++++++++++++
>>>>    1 file changed, 14 insertions(+)
>>>>
>>>> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
>>>> index 3278353b2c29..a856a48362df 100644
>>>> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
>>>> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
>>>> @@ -18,6 +18,7 @@
>>>>    #include <linux/interrupt.h>
>>>>    #include <linux/iopoll.h>
>>>>    #include <linux/kernel.h>
>>>> +#include <linux/log2.h>
>>>>    #include <linux/module.h>
>>>>    #include <linux/of.h>
>>>>    #include <linux/of_pci.h>
>>>> @@ -272,6 +273,7 @@ struct tegra_pcie_dw {
>>>>    	u32 aspm_cmrt;
>>>>    	u32 aspm_pwr_on_t;
>>>>    	u32 aspm_l0s_enter_lat;
>>>> +	u32 aspm_l1_enter_lat;
>>>>    	struct regulator *pex_ctl_supply;
>>>>    	struct regulator *slot_ctl_3v3;
>>>> @@ -710,6 +712,8 @@ static void init_host_aspm(struct tegra_pcie_dw *pcie)
>>>>    	val = dw_pcie_readl_dbi(pci, PCIE_PORT_AFR);
>>>>    	val &= ~PORT_AFR_L0S_ENTRANCE_LAT_MASK;
>>>>    	val |= (pcie->aspm_l0s_enter_lat << PORT_AFR_L0S_ENTRANCE_LAT_SHIFT);
>>>> +	val &= ~PORT_AFR_L1_ENTRANCE_LAT_MASK;
>>>> +	val |= (pcie->aspm_l1_enter_lat << PORT_AFR_L1_ENTRANCE_LAT_SHIFT);
>>>>    	val |= PORT_AFR_ENTER_ASPM;
>>>>    	dw_pcie_writel_dbi(pci, PCIE_PORT_AFR, val);
>>>>    }
>>>> @@ -1110,6 +1114,7 @@ static int tegra_pcie_dw_parse_dt(struct tegra_pcie_dw *pcie)
>>>>    {
>>>>    	struct platform_device *pdev = to_platform_device(pcie->dev);
>>>>    	struct device_node *np = pcie->dev->of_node;
>>>> +	u32 val;
>>>>    	int ret;
>>>>    	pcie->dbi_res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi");
>>>> @@ -1136,6 +1141,15 @@ static int tegra_pcie_dw_parse_dt(struct tegra_pcie_dw *pcie)
>>>>    		dev_info(pcie->dev,
>>>>    			 "Failed to read ASPM L0s Entrance latency: %d\n", ret);
>>>> +	/* Default to max latency of 7. */
>>>> +	pcie->aspm_l1_enter_lat = 7;
>>>> +	ret = of_property_read_u32(np, "aspm-l1-entry-delay-ns", &val);
>>>> +	if (!ret) {
>>>> +		u32 us = max(val / 1000, 1U);
>>>> +
>>>> +		pcie->aspm_l1_enter_lat = min(ilog2(us) + 1, 7U);
>>>
>>> I haven't investigated yet, but I see this build error on
>>> pci/controller/dwc-tegra194:
>>>
>>>       CC      drivers/pci/controller/dwc/pcie-tegra194.o
>>>     In file included from <command-line>:
>>>     In function ‘tegra_pcie_dw_parse_dt’,
>>>         inlined from ‘tegra_pcie_dw_probe’ at drivers/pci/controller/dwc/pcie-tegra194.c:2148:8:
>>>     ././include/linux/compiler_types.h:706:45: error: call to ‘__compiletime_assert_515’ declared with attribute error: min(( __builtin_constant_p(us) ? ((us) < 2 ? 0 : 63 - __builtin_clzll(us)) : (sizeof(us) <= 4) ? __ilog2_u32(us) : __ilog2_u64(us) ) + 1, 7U) signedness error
>> ...
> 
>> I don't see this error at my side, but kernel test robot reported this error
>> at
>> https://lore.kernel.org/oe-kbuild-all/202604051407.AODe3ddZ-lkp@intel.com/.
>>
>> I published a patch https://patchwork.kernel.org/project/linux-pci/patch/20260407145749.130753-1-mmaddireddy@nvidia.com/
>> to fix this issue.
> 
> I dropped the original patch so we can just add the fixed version so
> we don't have this commit plus another commit to fix the issue.

Hi Bjorn,

I published new patch with the fix.

https://patchwork.kernel.org/project/linux-pci/patch/20260410073330.837238-1-mmaddireddy@nvidia.com/

> 
>> Could you provide me your build environmental details like which tool chain
>> and make command are you using? I will incorporate these steps so that I can
>> avoid mistakes like these in future.
> 
> Sure.  This is an x86_64 Unbuntu 25.10 system with gcc version 15.2.0
> (Ubuntu 15.2.0-4ubuntu4).  Command was just "make".  Config attached.
> 
> Bjorn

Thank you.

I am able reproduce the error when I compiled for x86 with the attached 
config.

-- 
nvpublic


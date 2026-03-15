Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010013.outbound.protection.outlook.com [52.101.85.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2183533A6F8;
	Sun, 15 Mar 2026 14:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773583839; cv=fail; b=qOg4P5p8icd72nbJCAHrt/2MhvKNer4Zc2CxZ/yau1aREarAf62kkGf6Nn/bN9cL9TKf+wvMP4YoDulCebahyOIT7FjG1T5B/54SGGfvE3I9X/W0x6BPrc5YViW2M8+3bZAjZ+fEuoDdHVCTi4d1wTg7XMoYH/IEtCLob+4q4dU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773583839; c=relaxed/simple;
	bh=S9d3/sIQuWZgGuImpKTG2q6plptASHZ+Sql2Vszy8F8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TLHhR654L/ynOSVTRD+Z1IMpKte4MZTD3l4p+j4ELsph/7XTiGminHB832F/ywmTsBF25+AMyZMdJLbfEcdHvSJ7h8wFYAt8SNUyf2XeRnEkp8GOsrOwcB0DOC5FHY8rRNfYfFsoWtI2uYKJJpx1OyIusoFSD+JRn98JQGnrLnA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JGaQPWtI; arc=fail smtp.client-ip=52.101.85.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JGaQPWtI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=drxkGehAa9FOu9+FWWS+qsr66MPowUCCVJyBMZtjbPe4/xTu8g/4SUY1yR4YWSrEq8Yrpyei2h1+iVNHCprMFFE3va6BYOGn4f6P8DGemVMryLYq3fnGcEFFPXLNOSNXWOIWX5sy7xsnbSBqODWlY1yebKhhKivEs98ujOfLGjVSWh8uWPvga1aVGDd8baasxBZYIerofYCKVcZ93LvZMbSkigTJsmFHIpgQHk9RAnfkjsrV0VZbC2jGCAq/MvsBeti6MH0ECVrieWkggJqf43mMZLITlHWU9qdlBfPWya7GvH1lkd3y2qWVloCAPW5l8FNw1gcug71yoa8sgQIfyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h2/VxKYefxzGKkVH7q+pZc+iClEaY8EYmukgGKXFjEY=;
 b=uAIIuqieIS2qPX7gWoL8ydza+1aqTi9YpcGLlZIITvPbqIU5mAKyhUTuEWVAMwTsMKpMLLVW6J9dqesfCAHKzMoMepNLFMQM7MxyUGk3xVtoYb6LbRf1cHfw90MSr+GMyZTifCd+rSwZLCmNFUWx2/f+8zr+Ho3piUa1yLStHeMNOd3bwmNOIkawgHdD/NdT3b2vNYImtisFK+YSm0uYD1TjNwfS72tpzcjTHCTaqhGXy4j3V1ZmG13JIvBiWidKXxIEOxvRl4s33nyrQqcz8znE7Dko9xRVV69tn1gazvEvCvPElO8THJVDRSQir67o9NDsb/HFTB8QFy5O/3IXkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h2/VxKYefxzGKkVH7q+pZc+iClEaY8EYmukgGKXFjEY=;
 b=JGaQPWtI95e80KFaUVpooeLZ2YRjtwXnrtgnAN8yhzJ0XH6oRijyGzRijC1KtOePGEyRNYlbCXt9OnO52AJRNnLsvvZYvBBsDX2pGCOKLU8OnyNHrR09SJpnZdBpmIup3MKH35Ci/k+l0CPu1UhZM0mAt8NqfOXGxxa3xDbR3TpTVLZw2i/hyyBgv3cj6Rhp51iACP1Idk4HbMgl42HaD1Hp+W2/4vn98FWBpXTnRtBuUeLM/rwk7OJwLyXT0ehMGtzNPoFgRVqKOMpugq/HDzj6d+rYTHHyx55XHr3tULZu3yyXHvhsMtCKXVVYM3X8t1Ae0MvpewwfvmqmxWEXlw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB8245.namprd12.prod.outlook.com (2603:10b6:8:f2::16) by
 IA0PPFA8EB66EE9.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bde) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Sun, 15 Mar
 2026 14:10:34 +0000
Received: from DS0PR12MB8245.namprd12.prod.outlook.com
 ([fe80::e7c5:cfca:a597:7fa4]) by DS0PR12MB8245.namprd12.prod.outlook.com
 ([fe80::e7c5:cfca:a597:7fa4%4]) with mapi id 15.20.9723.014; Sun, 15 Mar 2026
 14:10:32 +0000
Message-ID: <95798840-8104-4fbe-a373-f33e30064d6e@nvidia.com>
Date: Sun, 15 Mar 2026 19:40:04 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 09/13] PCI: tegra194: Allow system suspend when the
 Endpoint link is not up
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: "bhelgaas@google.com" <bhelgaas@google.com>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
 "kwilczynski@kernel.org" <kwilczynski@kernel.org>,
 "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
 <krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
 Jon Hunter <jonathanh@nvidia.com>, "kishon@kernel.org" <kishon@kernel.org>,
 "arnd@arndb.de" <arnd@arndb.de>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "Frank.Li@nxp.com" <Frank.Li@nxp.com>, "den@valinux.co.jp"
 <den@valinux.co.jp>, "hongxing.zhu@nxp.com" <hongxing.zhu@nxp.com>,
 "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
 Vidya Sagar <vidyas@nvidia.com>, "cassel@kernel.org" <cassel@kernel.org>,
 "18255117159@163.com" <18255117159@163.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20260303065448.2361488-1-mmaddireddy@nvidia.com>
 <20260303065448.2361488-10-mmaddireddy@nvidia.com>
 <f556ofs7s7d3tzcefxhwqalzz3z6mmj3pc22frqii4ozkoseit@mbo43kjsvbwz>
Content-Language: en-US
X-Nvconfidentiality: public
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
In-Reply-To: <f556ofs7s7d3tzcefxhwqalzz3z6mmj3pc22frqii4ozkoseit@mbo43kjsvbwz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0176.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1af::17) To DS0PR12MB8245.namprd12.prod.outlook.com
 (2603:10b6:8:f2::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB8245:EE_|IA0PPFA8EB66EE9:EE_
X-MS-Office365-Filtering-Correlation-Id: 215abf5c-ccbf-4fab-21f5-08de829c9ec5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	qn91+ckjUuYY8bvmLKUU89NJ1S55AvP+irYXbVWSC5TWwf3atfRa0+3S54b4hOSEiJJilgquyluE3Gi6om7riv/gyVHlzgZbCCLB19UzQnshad/mPyuXAxFHn66SQGmKwZq9dOdd5m3aHy/d4arHFtYKtZyTOFBp2RyMAfVFO0jm50rpHnjBBYJTryL6Ram7tvl5mV1mwLFGj1wMku7k7JWL7melnRnSK6GkA5W9F1ganilXVFGWC5v8RSEt3x3/pMaK0AsfU0Khnncz9vPegqwIsIp1cVY2S1wMxrT/FRKeqJvZQ/Q+kPUd3jsZZdhAz797OsN4nx8tvw0dNMtN9uUCAcTjXVPKUNTH8wuar8vIkZjnZ6QFwfNowaTfMqi/412xBTlhkP1UCSVWCUj5LFUVYDRpaOIb4FQz06oyUMAOSHxY3oQXbl8C38i1ZokH5XXMlzTiNU/qZlCiOEYPqdwwMyHl52CruXu+bEz4NYTSFfGV4KWbtAUfaVI8i1oToUiSMXKHWB+49pLBbuAHqZsZgnLo4HxITwnMauoXsEiHRHrA2gNHqVgYDUQDQh08SjWLLwSJt3nLyclCuNX4D2iu1F9M+Y4FvG92C/3WRGttvJQ+Gb54rScA3/pLGnA0caARfd3Tien8F5tDoUXJF5B6eTUY8DkA6Em6NYmJ3q/hXm0ekKUzFAfnN69GJsD+dfU2xR9GpwfT8WTISv3x0aGb7GJsGKHFZL9TIHKJiXc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB8245.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cW13ckgvdXgvMkkxbkJrek1HbkRHVld3M25BeHZEOStEVU0yTFMxZVV3ZGhP?=
 =?utf-8?B?ZnA3R2JWK2FSbEpHVk1lY0dlSW1ENjZ3SjRHTXJpVlNJZmtLdC81Q053dUFl?=
 =?utf-8?B?YlNIR0hhdG5sSnhSaytNVUljZVlwMmZDWm4rdTVMUzUxc3lhU2lTWXpVVG5V?=
 =?utf-8?B?di9paS92T0xRZFk5NW1WOFM0WFV0NFBuVURFUVBXT2cwR28xTUhOUTB4Z1VI?=
 =?utf-8?B?eTlwa29BUURUM2RPN2FvNStIRnhvbmRaNUs5eGZjVDFKaEJkVU1OZUVqYnNs?=
 =?utf-8?B?c3BpSjdTcDlIY05iV1Y2VG1rN0EzdDlsaExnVlczS3ExOUlNakVNVFNodzls?=
 =?utf-8?B?YTM2dk9kaXJ3RTRwNlBlR2NIaThVYlVjVVJhTlphQzZITktEV09JcEVqZ3ph?=
 =?utf-8?B?SGJSbXNIWWU1eTM2R0R4ZkNNRnFWQTgvWTJWdkFHZjZtYyswZU9teExYbklS?=
 =?utf-8?B?clpuQmdsZXJzWExtL0pHUDVGNHNaYk56U2pxTTBOMHFZcXh3eGlQWkJxWmNn?=
 =?utf-8?B?MDRBaGZtUUkxOGVxUjFmb2hJZUljVWtqTy9JTjF6ektRMEdSS0gwdUxxd1R5?=
 =?utf-8?B?RWxORXlUaVdIK0QxVTczM0QrQTR6eUROSFc2dklYdEM1dDVUZGFXcEpZd2k2?=
 =?utf-8?B?UmlSZkl0VFhnNStrK3JjMzRCMDJKdVhEOGZ6eTBZR3NrMnhqM2lEcVhRbEFD?=
 =?utf-8?B?My9UUDRTdExiVzdaWXdJTVZVRFVFL2JJN2NxWXhFRE5HcmMyVHJ5b0EreUY2?=
 =?utf-8?B?VTduNWkwbzM1alY1eTllSXBTdnczMWNBbWViL0tob2FmbEh4NXNNQVc3Q2tG?=
 =?utf-8?B?enY2UmZjWWhSSG9va21IY1BEQkZ2NkxMajZwNnB6ckUxLzloeUxtcGlNdlRy?=
 =?utf-8?B?S2RiNnpXeC9SSzZydUZDYU15Y0E4SUN3OENQaVd3WnN6L0lJTE1kQzNmdUdX?=
 =?utf-8?B?UFF5VXNSYyszWTR0dzN3MURNNDU5T2grZHN6RWNHZXZ1QXJHYys4cXFFdmdt?=
 =?utf-8?B?em9RWjMrK1lnb281cHNJeUxKUGNQNnFZb25yWU1QU2R6aGZsQmJ2ckxGRExH?=
 =?utf-8?B?ZGhNVW1GU2hBSGNVUEFCY3loSlFjaTJKNGNHV1U1Q1laSjVIaGxXa3BrUVFu?=
 =?utf-8?B?MGlUWUVvbjJnSUNaWnhyRUpiMDN2dXJDRFV6bVFUTkV6R1Q0WG81R2x2dVI0?=
 =?utf-8?B?V2QyamFmdDFOa3pzWnRKcTFyT0pQSFp6NnRwQ0lHZ0JreDhDLzVTcmdHQlhp?=
 =?utf-8?B?dGxzcDdlUCtocHpTalBpeWJtOUNUc2psOEFCYXdUdCtqczN3c2l6eDJrWWZx?=
 =?utf-8?B?MDZlMTd2L0xqZkJJaVhxUTJHZVlVOWNTR0M5b2tPR1JaZVZuQUZhTU8zZmcy?=
 =?utf-8?B?d2hNYXRQWXFEakp1elRSb3FsK2taVDlQTlYxSG1lRFZ3L1ExVGFLOUNQMGZH?=
 =?utf-8?B?dTNiUE9VaWtyWVZoTjRtejFmMWhsZjdHRWtwdXRsRkdJSjdxNEpQWEdSckNy?=
 =?utf-8?B?SmdId2NiVFM5djVTODcxeTdLZGxpbFhwemVhRWgwMEEzM3M2ZTBEQTdnVXhu?=
 =?utf-8?B?M2VIMzFMZEZka0hIb1o4bFU3UEllVXhjc0FqOHVKTkdhbVpIZEw3K2JyT1ZO?=
 =?utf-8?B?K2c4UFo4YWZVOFdOVUxwMVJkR0sxQ3JyK2NwZzhENE5BVVBkMGdVRzA3RkNw?=
 =?utf-8?B?eG0rVW94eE1kdHJwSmxlbVlDdVdyNWhmaW5FTDNnT3ZYenh5TktIYVZJMmhQ?=
 =?utf-8?B?Q0VsVFZGcEdvdGxLV2FMYzVsd3NTbnhIZERjSG5PK0JPaWJHdnVTMVBsK1Vl?=
 =?utf-8?B?Rm9kQVFlQmxCM2xPWldvaGdFVDBidEp1RnNxT2lTZ2pRMkdVR0lEKzhQMFdN?=
 =?utf-8?B?U3puUGwwOStFTHV1Wng5MW1hb1Y5L1Y1YktvaUhIbFphWHhCWU5FYlJpTGZO?=
 =?utf-8?B?UGxiOUZqdExva2tIZlNWT1BXQnp4MzdjRCtFelJWNHBqQ0V6SUVVK0ZCOFdY?=
 =?utf-8?B?LzhDSE5LU2hZSGhzc1FvRXcxMDBkN1RWMTFMM1JlWm9iQ0JFdDhMTjkvTUVw?=
 =?utf-8?B?UGdDZWgzMmVPL2pzMHhQd0J0Mzl3VzRhNTljV1hmdTBtYkJ1OUY0bG5NUVVF?=
 =?utf-8?B?SzNGa1dzZ3BLTFZVbTM0eFRaTy94aFFLbDJ3dnNBMzZ5NWFYNVdXRUp4VEdn?=
 =?utf-8?B?MHVaQ1I3bk5GTUVTeHNPYkxwVFRaaHNwWlVRbXY1cnhTc1diR3dBbEVhNUV1?=
 =?utf-8?B?cGh6dGpmd0NNUVlRaE5lc3hKbHBwY3pUR3YvUHNNT2NWeHlXeGpOcktiNThQ?=
 =?utf-8?B?N2lCK29Vb2lkZHl5WmdvNGNBQnRzay9sRmVTZUtRaHJRRThLQm1WQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 215abf5c-ccbf-4fab-21f5-08de829c9ec5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8245.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2026 14:10:32.6963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bhv6vOniQ+hbqv3aUItUdR44JPqcyejHBI2V6mPD6pLTCOsxIhgFOQVDJcjAUeHdRDOvltNeCU0ep3OnlaOwEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFA8EB66EE9



On 05/03/26 3:59 pm, Manivannan Sadhasivam wrote:
> On Tue, Mar 03, 2026 at 12:24:44PM +0530, Manikanta Maddireddy wrote:
>> From: Vidya Sagar <vidyas@nvidia.com>
>>
>> Only a Root Port initiates the L2 sequence. PCIe link is kept in L2 state
> 
> It is not Root Port, it is the host software which initiates the L2 entry
> sequence.
> 
> And L2 is only guaranteed if the Vaux is available.
> 
I will fix the commit message.

>> during suspend. If Endpoint mode is enabled and the link is up, the
>> software cannot proceed with suspend. However, when the PCIe Endpoint
>> driver is probed, but the PCIe link is not up, Tegra can go into suspend
>> state. So, allow system to suspend in this case.
>>
>> Fixes: de2bbf2b71bb ("PCI: tegra194: Don't allow suspend when Tegra PCIe is in EP mode")
>> Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
>> Tested-by: Jon Hunter <jonathanh@nvidia.com>
>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
>> ---
>> Changes V1 -> V7: None
>>
>>   drivers/pci/controller/dwc/pcie-tegra194.c | 31 +++++++++++++++++-----
>>   1 file changed, 25 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
>> index 5b79d3c28ba6..b2794be35cfe 100644
>> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
>> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
>> @@ -2267,16 +2267,28 @@ static void tegra_pcie_dw_remove(struct platform_device *pdev)
>>   		gpiod_set_value(pcie->pex_refclk_sel_gpiod, 0);
>>   }
>>   
>> -static int tegra_pcie_dw_suspend_late(struct device *dev)
>> +static int tegra_pcie_dw_suspend(struct device *dev)
>>   {
>>   	struct tegra_pcie_dw *pcie = dev_get_drvdata(dev);
>> -	u32 val;
>>   
>>   	if (pcie->of_data->mode == DW_PCIE_EP_TYPE) {
>> -		dev_err(dev, "Failed to Suspend as Tegra PCIe is in EP mode\n");
>> -		return -EPERM;
>> +		if (pcie->ep_state == EP_STATE_ENABLED) {
>> +			dev_err(dev, "Tegra PCIe is in EP mode, suspend not allowed\n");
>> +			return -EPERM;
>> +		}
>> +
>> +		disable_irq(pcie->pex_rst_irq);
> 
> So you just disable PERST# IRQ during suspend? And even if the host deasserts
> PERST#, EP is not going to wakeup?
> 
> Technically it is possible that whenever the EP wakes up, it will see PERST# IRQ
> since PERST# is level triggered, but it just sounds dumb to let the endpoint
> sleep after host deasserting PERST#.
> 
> - Mani
> 
I need to check if PERST# line in Tegra has wake feature and 
corresponding PMC changes are available. Anyway adding wake feature will 
be separate patch. In this current patch, I am trying to reduce the 
impact of Endpoint on suspend. If Endpoint is never initialized I don't 
see a reason to block suspend. Are you OK with this current patch to 
reduce the impact on suspend? Or do you have any suggestions?

- Manikanta

-- 
nvpublic


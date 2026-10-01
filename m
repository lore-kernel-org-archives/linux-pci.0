Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010064.outbound.protection.outlook.com [52.101.85.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A269F2798F8;
	Thu,  1 Oct 2026 23:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790897167; cv=fail; b=J/2lJOaNP/7qchaLe/fLRZMdEi3kfmzLFJ+XimJbyWIt2UCiJ42kELoMZTqGdk2n3uzJezsembb2LUwHZ9ujDmWKlye6Mo1Zebx08vvMvivk91KUH5LSMw5vyUsg69nmfYcpJFIxBQ59hrp2JsoKCKoTtO17F8CH7mOyPoMDFpA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790897167; c=relaxed/simple;
	bh=OozJZqPJve1sksqVPXez8bNJpxq84pcG/fsTm8/Az6s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KrpcAxq7mX57Y3FDdpCeoKh8HuzM9d/27Dxt37+rqcG8v1LKL6PqpchQNA20u8Ur7VCqcZaS9boduOU3Uo8cCoQBBNUvTKQKl+Kyx5DIM/HQCM4H1quFFEbAA2ZQGozdSqYAAq7XQOrYjOCxhPCm0merEKCrMZyIKXJIeICEyCc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ENT+Q2bf; arc=fail smtp.client-ip=52.101.85.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ENT+Q2bf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NlnWVu5Q0wRDh40VS2s6BHrBxHPLT7mag6RIeQPwYxVCxeN3Zanpsb3cOT5Gs41rXpzz4QEYBn0wkBhW+RRp++Ireyycou/xsmoJ6EpA4Uj5o95yge3wInY7vtgBj5dHt5p54Myd2YwVHz1Gv6OO/DxSc614WrOgHZk5FRru9mVZb6+VHX3AZfjJe5crQz7Ey2/t+81WroMPPKIs3RvNOU54mXF5yGm3S+bWBSAfH10xK9OBF7IRhD7bCuN9uYw3shxxJF8DBMt+3pQb7NEiUlEUso2Jkwq60HTuDtNDp+TtXwdRPR+Lf2jHOUghYVMZ45G4uUWtoarMyb1uMkc3dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yEyG4GWA2sY6gxxjt1ckdJXN4KS1kO7Uv9jGkHdikak=;
 b=FybFRf0dl5El4CdxnfVfB+wIKde9mHEcixzEIKG+4Xwn+n5UbZ1ZRLyJwtz+C0iPF6fDe8kshDMm2saFFO5wG9dR17QmFqpWaXWvZHOAlXLL0Cy53w6fQrGqeImIf8t3AiuHSlLzjjtcwAz5gSBvziqu8GdT1sJEhxQ5ay8d7m6LRz6fHhisebR43+m/jKOwHtlZf2upAYx5uDqAjhvVHvLaNytxz9DhEe5pCvC4f4MFUQ9HrCZQRJMQ1bEGiLrmLHa8j8jX3Hngbw4LQET+8IqI1MmHq6xMbBgSXjv2NqdOHk7HeqHUL82E82hHAd+ZL0TRuOHLGTmhFWeqf9tDPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yEyG4GWA2sY6gxxjt1ckdJXN4KS1kO7Uv9jGkHdikak=;
 b=ENT+Q2bfjY5ynoC+0TEjDrIMHL1GSr8VpmS81+ayWXX9360toLDGHK7tTKmiAT233/vYaupGcymaNLYhHocKnNdrS8EzWkMkYZr+HZj7JzueLx792a/os6c5PKeZQsC4qnE0rql91Src+nyY6+uNlRM56c61JoJ/pJlCj+I94lZfWwwc9F/mGs58+tPPTiQn8Kb2XWf5LPprIPBsJeObAP1fe+SjFEmVwFqGkv/moQ3dZLdW4mgJtkopGmacE+Pks6QnNx7kvpyaIewuKiwXaTIikdZ5sMS/+U+vIK65wFaRNTw/QBZeYAU3z8nOhFHt4h3wwE3OYGnWa+QQy73xhw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by LV2PR12MB5992.namprd12.prod.outlook.com
 (2603:10b6:408:14e::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Thu, 1 Oct
 2026 23:26:02 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0451.022; Thu, 1 Oct 2026
 23:26:02 +0000
Message-ID: <7224941d-602d-489d-b51a-7f9923c5645b@nvidia.com>
Date: Thu, 1 Oct 2026 16:25:59 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 11/15] cxl: Validate and synchronize HDM ranges around
 reset
To: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Dave Jiang <dave.jiang@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny <ira.weiny@intel.com>,
 Jonathan Cameron <jic23@kernel.org>, Vishal Verma
 <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Alex Williamson <alex.williamson@redhat.com>, vsethi@nvidia.com,
 alwilliamson@nvidia.com,
 Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
 Vishal Aslot <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>,
 Jiandi An <jan@nvidia.com>, Richard Cheng <icheng@nvidia.com>,
 linux-tegra@vger.kernel.org
References: <20260922083924.2451158-1-smadhavan@nvidia.com>
 <20260922083924.2451158-12-smadhavan@nvidia.com>
 <a434e275-a558-4053-a474-b747c93ee9bb@amd.com>
Content-Language: en-US
From: Srirangan Madhavan <smadhavan@nvidia.com>
In-Reply-To: <a434e275-a558-4053-a474-b747c93ee9bb@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR03CA0030.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::35) To LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|LV2PR12MB5992:EE_
X-MS-Office365-Filtering-Correlation-Id: 591cc0bf-bb13-4c0c-6b04-08df20135bbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|7416014|1800799024|18002099003|22082099003|921020|4143699003|6133799003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	PN3dZ5IsfpDxc1tT3rqxZFM8ERmIzjFbB+OhEnlPc1C8qqqzcH11ajZ8DnOnYe8LokU8r4XWrj/6YkfC/Idk1yVCAWletEuc69lZVK4JFySSvl3NaylxEHqyL2FuKdgtbTvVje1LBmCndNclQMVO0G6lSZBA4w6OLWjQ7cZJ43tAaG+hM2xAe/DASKmaCDkUE3fGWbBs9IdQxXFKatko6OqU1vskAtcLUQlAYzcIGPyhBFH1lDLjwk5JhMMkCM80mL0ytMjICvb/gsEUDBnlInli2Sz7kppgNQDSiKpngnXYiSPQVN68CY3NYi8ckJsr/ung1ZNgwqliGwa5kEvzsSIY0y2Y5xpQ01VsjXTFO3JTwVW0rjdbaVyEj0AwkZ+b0GkMaB4/pu/h/IZoOaXNvectcaHcvAml+9HikbcoroqlrVqcCbLtSvByALKeYp5bG0ltjwWM7mQYVxoW+eCv96EBU1N/wqPAqZroqPf8t/mRYmFOp+5tRs8asrm/iF1u8YSG3mb6OUePr+nQBNgAKk/SL8kgfIoO6bOp3cXcrkRdku0Ed7Nl1zUyPukaobz6O/I8dzeKUTut3xw4ftt5EnJAOsY8JxBXnvv7O+Yp6X1NzAs3iImqFxO1eojTZ4s9wf4LS4yCEGjUwhHtU5a/AsQEVaAacSFN82syC8fTlXvC+1/eWBSHCyHbSE062kBogAhos49tgDxYEK3J86DLVw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(7416014)(1800799024)(18002099003)(22082099003)(921020)(4143699003)(6133799003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cnpHQVNhM2lSa1pwMmxxbXduc0ZkRXllbmk3V0dQRUREY0N0cWhueHpBRjJF?=
 =?utf-8?B?Wk85UE5ObVQ2ZlBMQis3SEh2dWJoRGdFWDQ3c0J1RFVsWUxsOXZsQU5wOVF6?=
 =?utf-8?B?MzJkNGE3VUUvSnQ0emkzTXdTSWxmaFIxTjBwUnIxUnU2LzJBeFpPSEhtb2Rk?=
 =?utf-8?B?S0ZFR0JVb0pHVjZsbzRpamlBV1lqb1ppNElpYW96VytZaEFOMDRIUDNjSXpx?=
 =?utf-8?B?M01MNi9pN0pFWkhwZWo0bk1mRWxYb1ZiWnlaWk1ESzVkMTZzWWFUV1V2Z1Rm?=
 =?utf-8?B?YzlNL3RKMU4xbHBxaFlqdzlwVVpYWSt6K3VUejJyUVM1NnRtYkV1YzRzN084?=
 =?utf-8?B?T0pDbjdxVndJNTlEcWJmQUkxRVJHTURid0hrTGtVUE56SlU5SUs2cENRWmVJ?=
 =?utf-8?B?R1hINzRKZmhZanZjaUxUZ1NGQ1BNMTJCWUN5WFM4VmdORGc0Uyt2UjQyMzdv?=
 =?utf-8?B?MEVYdlptaFByUEQrUlh1OVJad2dkOFlkQUpHLzJ0dE9wTWRTd04rblQ1WFBM?=
 =?utf-8?B?c2dQdS9idHEyZ2JXK3RsYTVsMzk3V0JPZGp6bG8ySU9xMndDR3BIeXA1U0JF?=
 =?utf-8?B?Q0hUcHFJVlUzNkpsV2FIM1B4SlA5NFJoY1VXaFhhK0ljcXNiVnQzcnZyOUNs?=
 =?utf-8?B?UHgxcFAwaHd1RUZMclVPaGJOZVppUzBlZ2k1bW9GNUp3VE9PNGUxZ0c5ZjhW?=
 =?utf-8?B?Q2R5OWc2RGdrZ01wRCtnM21IQ1ZBVjg5SzBQMEd2cVhDYm1VeTFqTXlkY1ox?=
 =?utf-8?B?TnJIa3BJQUtNai90MElYQ2dBdHZTOWZ3VWV6Um81elZxMzZQMDJLajY1bEJt?=
 =?utf-8?B?c0NZZ01FQmlGTUZBWTZqWEJnN1diMHFYUC9qVHBQZlo2T3pTNUgrbjlmU0tB?=
 =?utf-8?B?UTFjUjBNd3huTDZ2YXBqdGc0VHJxN05yMHhzRFJVeHR0QndPYTcxeFFGL1ZN?=
 =?utf-8?B?cVl2emo3U3M2RWlOUjQ0bXV6VFpIOHN6ajgvQ2ZHMDhrYVdUd0NicEY2MnN1?=
 =?utf-8?B?REwwUkhCS3ZkSGlFYW8rTTUwV1hDWmpzN0pReDRxalJoUVVENDhyNXBsV1Ni?=
 =?utf-8?B?TWU1VHFNd3N6a3JmZG9YS2JhVW8xbEhhcDFtZFEreDRnRWt6U2twUFp0TjE4?=
 =?utf-8?B?NkFMU0VKL3FydzRZNmlUU3V5WjJmUHAwWnBDVWhpVFVvZ1V0clZJVFcrWDJa?=
 =?utf-8?B?UDk3d3BqYWsveURjTDg4TEh2QXJqUjkvRVM4bHFaNS96dWhwVlpTa1VPRHk3?=
 =?utf-8?B?Nkc0a0NQQWdsbUR1a2NUMTJwUnVzTndCaFdGTG8vOGFjWTR5MUYwSTFTeWph?=
 =?utf-8?B?SWVMblZDNW9DRlo1M2dsQWNQSEVzYTlFSXlGNXJWZ1B5RjhCSjc5SDB3ems3?=
 =?utf-8?B?UzBDbTJSbTNveEhwR1N6enNyTzFTWEppS1BhV2JFVnFINUNqV1orUFJHdlBu?=
 =?utf-8?B?TnowSlNxQjNPZDZJd3l6TG1yeTZPZi94eWVubWJ1Q0JNTzBhajBMdWVtQkRV?=
 =?utf-8?B?RzF3YUFWUjdCNGM1WnkwYndZREtEd3VNQTVzT0tKR1lLNHJ6NmlUeG1PYTZL?=
 =?utf-8?B?ZWcvRTRVN3pLMVh0YmswTnVLcUNYQnpRR2JZZi80amNnQVI5dFhRajhnYWFw?=
 =?utf-8?B?RTlVbmdON2FrNmhhZkwrN0t2Z1RHTkgwbHZCWmpONmFNeWs2UEp3UGhzUXo1?=
 =?utf-8?B?ZlNhajJhbVUyTWpYYVRsSUVFVmQzY3VJeGhnYlZMSENKMUs5ajZ0Zno4SEdx?=
 =?utf-8?B?K1VlQXVOODg0Vm9xSXJPZlIxNUcyZWRnMmY1NnFURHE4UWtyMEFOYU9TSnBI?=
 =?utf-8?B?KzF2bTdwU0M5dFZiS2dOODZGT3dndkxiRHRQTXlsMVo0SXF2L1UybzFJZXRy?=
 =?utf-8?B?bzlNVWwybUd4TDBnRGdNRkhSN05yajRMRlZuTit3UlpkVWFjTGxObjc4LzdM?=
 =?utf-8?B?ZnJzbGl3amdIbEl3aWczTnRqUEI2U25DbVQwWkFQQ1FPWmZ5K05XcnY4RjN2?=
 =?utf-8?B?WXFQTWI5QVViT0ZraXFaYitCKzVCV20vS0UwWlZDNFZpQ1JKeWlrcWM2MnRx?=
 =?utf-8?B?VDR5M0xEQWh1Q3hzKzZ6R0lZYmI0RUN1bGVXeHQ2SGtYWjZzZDc5VkdqdVla?=
 =?utf-8?B?TTlSWm1IYnY0dTRJUm1NVk03WFBPWjRCbkg0YzNvZ01DTU45cnJzM21TL2Q5?=
 =?utf-8?B?THdzUFpqRHRzUU1iZmV0ZnBzVHVGelBSN0dnaEVNQStsemtQdlRHQk1sOXFy?=
 =?utf-8?B?a2dhQkdDQ3ljTlFwVU5QOXdxelU0SGVJL210Nlgwc2lEUWhFcWgxWnJseWEy?=
 =?utf-8?B?NXI4SzlvNFZUbUdyT1V4eExjN3pqNU5iNXE4cTBMbllvVVNEd0JJZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 591cc0bf-bb13-4c0c-6b04-08df20135bbd
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 23:26:02.7336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P1l7dVt3nkENRds4NIHK3kReQDFmEzAw5jqgqWSyto/zhXGqdEw0U8vWButx9+1IMVtdAfiTKHvSPO7gIP5tsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5992

On 9/23/26 2:40 PM, Cheatham, Benjamin wrote:
> External email: Use caution opening links or attachments
> 
>> +
>> +     list_for_each_entry(range, &ctx->ranges, list)
>> +             if (range->hpa_range.start == hpa_range->start &&
>> +                 range->hpa_range.end == hpa_range->end)
> 
> Maybe resource_contains() instead? I don't think there'll be any overlap, but no point in reserving
> a fully contained resource. You'd have to add some extra logic to remove the smaller resource though.
>

Done in v14. I used range_contains() for the struct range values. 
Already covered is skipped, and a smaller collected range is removed 
when a larger one arrives.

>> +
>> +             if (!(config->flags & CXL_DECODER_F_ENABLE))
>> +                     continue;
>> +
>> +             /* A committed zero-size decoder maps no HPA. */
>> +             if (!range_len(&config->hpa_range))
>> +                     continue;
> 
> Nit: these two if statements could be on a single line and just put the comment above it, it's pretty
> obvious which condition the comment is talking about.
> 

Done

>> +
>> +out_destroy_ranges:
>> +     cxl_hdm_range_context_destroy(range_ctx);
>>
> 
> Same thing here as the last patch, but I'll let you do this one ;).
> 

Ack. V14 splits the reset sequence into smaller helpers and removes this 
cleanup-label flow. Please let me know if it is better now.

>> +
>> +     INIT_LIST_HEAD(&range_ctx.ranges);
>> +
>> +     scoped_guard(rwsem_write, &cxl_rwsem.region) {
>> +             rc = cxl_hdm_ranges_prepare(&range_ctx, pdev);
>> +             if (!rc)
>> +                     rc = cxl_reset_execute(pdev, dvsec, cap, &range_ctx);
>> +             else
>> +                     cxl_hdm_range_context_destroy(&range_ctx);
>> +     }
> 
> Probably better to just copy-paste the range context destroy call and re-order as:
> 
>                  rc = cxl_hdm_ranges_prepare(&range_ctx, pdev);
>                  if (rc) {
>                          cxl_hdm_range_context_destroy(&range_ctx);
>                          return rc;
>                  }
> 
> 
>                  rc = cxl_reset_execute(pdev, dvsec, cap, &range_ctx);
>                  cxl_hdm_range_context_destroy(&range_ctx);
> 
> instead.
> 

Ack. In v14, cxl_reset_execute() owns the range context from preparation 
through cleanup, so this handoff between functions is gone.

-- 
Regards,
Srirangan

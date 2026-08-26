Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011057.outbound.protection.outlook.com [40.107.208.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B23439EB5B;
	Wed, 26 Aug 2026 18:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787770071; cv=fail; b=QfbNgPu1TVGYHfRRxnXsGMFR1CkiD55565uEeylt0QfFYnrLVqAoRmoBpDoynb+xlLu0tt94i+9WrD98Y+y6Gu999OlZaIjSP3wJGyNzfK6bw29oOl6cbsJcOZqKDmTv83amUKkCc1EGAeNZEqCa6r9UMGpO8CXYnh3+LLBBuJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787770071; c=relaxed/simple;
	bh=QPsmXIxghiseHD2sS2MlyeGDOPD+KGkO0dIhBoMBXWI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=M4Fna0yJVCu9sGTPkYJeqf84yHL8ZEsXY+9yeZZk6oy3ij9lfP3g6AtQR4IB3r9f6fv1pmVhE581mEhKOHUHo0rFus4ls01SeBTulXagzJOon0ALnXF4ncLddRqjatnZUlPSJF8JohDKJxI9jcgcVn5N1hmSd+bOmIh1OG6A1ig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gt5dxGTS; arc=fail smtp.client-ip=40.107.208.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gt5dxGTS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d3nMbTZ0Vs4z1i6Ek5x8Gm3TSSnjPplkn/7hcegFSjuTqJTTitRGa9IL7doKg8ba3PuIbjFpOQEd8CPSCcN8nbxk+V6ZVSou6haRfJ6O4Y3Qqs19tmRlP1zxtRDn8nYynTGCGa34ztWFlzN+G7HCrrySax3Yr0eyuloKJ1WtY4Vx98+sbyt0ELxwlKbe9O6qAlCZQR6SbSU4EGcOHqyRRkvj5k4bVoLhS2rbCSTlzeyjtq7zbvypn2EDNEbywwSC40x/ST5yk+lb0vGG9G3G2o5Rjoinev10Z0f9X7HtjXfGgrg/NsfjyVsTyxQXuHVwkkava3yuDmE/P8ysT2wTug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5DoRYrwKnnUfwHgxPIISEtOPf5fEaeRTAXt9BOoEs60=;
 b=H+EXxoZR47f23OFvpB5CseCjMctr04SNJVkMzRkpDi8UYyqu/TB34nK2l4L4SlKtZ59rY4iZS6q7yTJ2v3DGdmq2fH2V3oGWnz5WYBKctMq7bFHXWFzpgSK5cI00G5LEWVLje8Ov8gNTBDeptqOjy8Khy2R6ZHMcyYwiefGz/vzH341pHvU2Vpwd2ZwAxjEQN7S6kNodSDhVsINCy5vMoEnOXWyFnrBds1BBrzilLun3wSzxkFhDJEodtDJXaAJbSZ7YjgOdA012qS7DHUNkBfAtcbyea1ZmE69+9zmBy+sD/oHrjB61d4u6Tdwyj6wPcPUjyHOxcBDiHny0oVJHug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5DoRYrwKnnUfwHgxPIISEtOPf5fEaeRTAXt9BOoEs60=;
 b=gt5dxGTSiUBCH14wlQ9wsetjSdiAvKLAsblKyohFS4cGTpW3afHBgjtCMRV6b7oC4qlDPop41pLExOb5Pkt9b04COC8pYZlhrEgli5BQAbg07NXjZsO+woKleSbgsXjteTd5PZzKWmgd5OZWKV5i2zznkGhVnUrrjsh1ylDLzjQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6254.namprd12.prod.outlook.com (2603:10b6:8:a5::17) by
 CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.7; Wed, 26 Aug
 2026 18:47:36 +0000
Received: from DM4PR12MB6254.namprd12.prod.outlook.com
 ([fe80::8211:9b5a:99d2:ffa1]) by DM4PR12MB6254.namprd12.prod.outlook.com
 ([fe80::8211:9b5a:99d2:ffa1%6]) with mapi id 15.21.0360.006; Wed, 26 Aug 2026
 18:47:35 +0000
Message-ID: <ec0509dd-8bfb-4b97-a8bd-3ba450cc4dc0@amd.com>
Date: Wed, 26 Aug 2026 19:47:28 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 08/12] cxl: Reject CXL Reset on multifunction devices
To: Srirangan Madhavan <smadhavan@nvidia.com>,
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
References: <20260804192958.1823952-1-smadhavan@nvidia.com>
 <20260804192958.1823952-9-smadhavan@nvidia.com>
Content-Language: en-GB
From: "Lucero Palau, Alejandro" <alejandro.lucero-palau@amd.com>
In-Reply-To: <20260804192958.1823952-9-smadhavan@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0002.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:150::7) To DM4PR12MB6254.namprd12.prod.outlook.com
 (2603:10b6:8:a5::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6254:EE_|CH3PR12MB7763:EE_
X-MS-Office365-Filtering-Correlation-Id: 64f2aeaf-1a54-4914-1d9a-08df03a27ebb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|23010399003|1800799024|10067099003|56012099006|4143699003|6133799003|11063799006|32116099003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	5uv9JfyK5Fro6bJvWME2claEaypLXZO73G0cq5ojHqQ8yKHVHiPc6MWdbpn1wswzs/k5M4fgsnnr+9/FHbLCyKosFRk6n8bpze+QVQT3JC6yFwTkoGPavFUqqUOZT7R0ORQS4VJgwH7IFjhoti6MV2aWLtrviMZHO+Rx+ohpIJSoY19pE+SxxVlVKrXZNs2VwwjyvOvIu9y1uNvDgnsg3PWFMZk0MjjAlKR+gXAuObzS321G7Wt31bLjWn2TGJ5ja4pyTzupHWil07Sg02LgWd9ovnflz0nqkZzgOCJZAT+ZCzUg5T6z0VUDQpeD9VJjr1uSevTXPZeWEYzHmrjBlrtwiqowtkZmEMeeDjqPPiBbtq4qvgpdN1iGnwphh8RWqeiK9njun6680wlhotXQAXN3mGiltI7McFL2K1DlXmFwULMHUg3oKui/eLik+47cXM8WmHRSA9zFCT0vNE7ezJkWGooj8oqL5908lOCCrB06DTIs1iRI4cvtWyPnKRnHnk8qZPcrpTG4uH1qMOU31sWs1kxqP8RO/hn2Ke6F++jWxzpKf0u7TOZ70wQcf/b70bXuXh8Jos4+7JEkMlYDx6+9vP8iGYyapVluox2fmSnXQPCbiTN+CYl71fyDNM03JiYM0Zgss9V1RNQfLia4qqbTEmX/GlVNZ8VobDTr+pFnNHIVfimIf+V80o1pT/X+gYqsbkAh+ji+81z1o5y6SA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6254.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(23010399003)(1800799024)(10067099003)(56012099006)(4143699003)(6133799003)(11063799006)(32116099003)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?LzJBMllBQWhaeUlnM0lDWXFEMUx1NThGQUFJdmoyMnZuYnB5a2svV2NiOWxZ?=
 =?utf-8?B?dGFPZEM2UVFlYWFCQnlXUWZ6RDRPY0NWWFZZTWJpeUh4amZBdmhRNGxoRTEx?=
 =?utf-8?B?bVdoK2NYUjZjUVFsYlhxK1IrbXVnQVZMMmd4Zi95QWxlbEJ5Zzg2dU9kSDdi?=
 =?utf-8?B?OGNHOThMYVFMUzZFbHlod1NBM215bFJ3T3IyYTFDRjFBQ1c2NldxbDduUlBK?=
 =?utf-8?B?WEFtTHl2WGJidkpIVnBzUndSVDVnMGxVOVRmaEQ4ZGJCVmMyclg1SDNhT0JY?=
 =?utf-8?B?ZkpsRWVDZTNOa1Fmd0xKQzg3ajZoemVCWGVpckp0L2xXQlZqbnJKSzNZUm05?=
 =?utf-8?B?am5lZVVEeURjR2ovZWMybmJhS2ZBb3lXZ0hlcEc4QnRBUVVtdmFGSGdlSVBy?=
 =?utf-8?B?VjNGR0NmbUJBSytqRmpOK2FON3VaS0VNSi9ZWkVDK1dNMWoyWjZmME9BVXRM?=
 =?utf-8?B?ZXduT0txZlU5SkJrVnY1dkdEZm1qbGlYYmxMeVNoaGxEUlQ1aG9Fdm9yT2hj?=
 =?utf-8?B?NDFlalBhWkxhWDBIUFQ2MjUvenpRNkxpT2hTVm9QazNEaWFtZzFQS3Q1SmlB?=
 =?utf-8?B?elpWZ1pyeS9IL2hrOEc0MFlZa3BmcDFNcWdtK0kvTTdTVjZycVJuQlNqWGNE?=
 =?utf-8?B?ZFRqUFN2VE5rTmtVeWhlcnZrekRKQlh1QlN4L2FkTnlRbHBRUVNtNzNFOUFi?=
 =?utf-8?B?Z1VtRzlXaHRha2V5dGxyWW1iV2xEN1BhbUMzTmFuZWFpYWFMaDdwV2htVzZq?=
 =?utf-8?B?UGRmK3RmbzkrQzVRNUVIZHd2N2ZadnovckY3T3RNMTI5Yk5NaTJxQldkaDdJ?=
 =?utf-8?B?UGNwcnpIT2dYK2pPQ0t5emdUVXliRXJlMng5V29CRjZNRWkwRXY2bjNkaXho?=
 =?utf-8?B?MUJJZlZ2NEVkUWxFQVBuVjl3WkdxbGcvY1BkcTllTzUxRWtLc1RBd2RwV0tY?=
 =?utf-8?B?MDA2RGV1UjBVVXFUbnZ3N0JVYW80aThOK3ErbU4rYXJJa2pEMUY2dnBVU0RM?=
 =?utf-8?B?N3lSTDM5VC95dHVBN09jWGQxOWpCdDJiYlNXQ3djVEhSWEdEaFBGV0cxT01H?=
 =?utf-8?B?OXp0a2VocjdhUXVHcDQ4Q1poYmFJUHJMeUhsYUJzRFNTS1cxSlBBL0lrN2V6?=
 =?utf-8?B?cG41cHdJZmtZdkRybWxJdWxYQ3pYQ1NkeVN5dGM0UHREb0J0WlpjZkxLMVIw?=
 =?utf-8?B?WXc4bERpcW5ORFZ0a0kxWmQrelVKMUpYL1RGT25iN2IrUnkrRW5wd1dHWEhF?=
 =?utf-8?B?OFhqUTBjL2pSbm52cHZ4d0E3UXR3RkwxY2JmRFc0UURidU1OK2FjeUJ5VW9l?=
 =?utf-8?B?WGFZdzhad0hEN3FnVDN0UUs5YWlOakFjN2FjeTlpRXZXRStrZ1dTeEhCNkRN?=
 =?utf-8?B?SGV5TTlidDVZS2VyTjRzTEJuNGhhWEtMTlJ3T2Ntbm5vTlllb0U4VG9qVjBw?=
 =?utf-8?B?WkVmVDhXNEVJclN3U2tJcm1DNGRHMWUxY1RsR3J3Zk5Wbm9yK1g2aWsveWt4?=
 =?utf-8?B?STV6Q0t2SUh0LzcrcERmWXJRdlpxdHhleFlWZmx0K1c2eWh2QUErc29hRDBs?=
 =?utf-8?B?L0V2UHU5QXVnNXRFRzJpU3Vpb1JtekhlQ3NlcGlwaytyRStZSTJ2SGRtcE9U?=
 =?utf-8?B?aXBQeHEzTDZWTWlOTmIvR2dvV2lXUmVXOFdpWnY3emdQdjdpemNDVHlUNVJa?=
 =?utf-8?B?UTUvZFNVU3lwZ01mWkcrSEJlbDlBSk4rVEhPRmhRWVpXYUFpUUhXUnZGMFEx?=
 =?utf-8?B?em5adWZaRG40Z1JPM0E0MmpaZ2tkUGtEU3c5aUlRb3FWRGRjWEk1UU0vOUZP?=
 =?utf-8?B?K3BWdlNRUVM2SENGRExzUGlDNmFDMWRJdjF6ZHhQRnNqODJKVksyUzJKUXJK?=
 =?utf-8?B?elpoZFB5c2RGNGNibGx3UnBNSmpZSjZWdS84ejg5SkltY3VOTVV6Q2Q2Uk1G?=
 =?utf-8?B?VkxKaW95RkZ0aEIycmI1MDZrK25GaGZFTkxYOWVTVGF5QWxnSGFoRXE3MkxN?=
 =?utf-8?B?eE5LVVlOTndIWEtjQ1pQSEhYY1ZpcHlkT0ZTK2JlRDBHWGdNWjlVeXR6WXlU?=
 =?utf-8?B?TGNGSzIvd0l0RkdXRHlWZm9WU212OFJVcXFWNWwwN1g4REdIR2NzeU5sWWVH?=
 =?utf-8?B?aVJUb1M1U2RrT1c0aDdHQkhDVlVkWW1tNG5rMFZ4cjdTaVI2ZFRMTksrRDRH?=
 =?utf-8?B?bU5ZK1d5clZYZlh1bEVBc1pOZW91RXJ0Qmo5V3RqRkZZQkFUS0IyWTVvaDBQ?=
 =?utf-8?B?STJtQ200UUZPcDZscnV0dUVYTmNCcG8yb2NZMFZ3RzgxT0RBWlhzdTlFd1NO?=
 =?utf-8?B?WS9PZ2ZKRVlya3lXcTVjYllPWkk0MjF5ZU5saDA0Wk1nOHFDeEdWdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64f2aeaf-1a54-4914-1d9a-08df03a27ebb
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6254.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 18:47:35.8605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M3gJvHV9qRXBrLk0fP9HjRsjR0BiuilGOcJXxE+Xy40i4qDb148wy7DxDRGDolETfwZqUMFQWpPU73QEMhJfFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7763


On 04/08/2026 20:29, Srirangan Madhavan wrote:
> CXL Reset can be exposed as a PCI function reset method only when the
> reset is function-scoped. PCI reset-method probing runs during
> enumeration, so walking sibling functions there can race with functions
> that have not been added to the bus yet.
>
> Reject multifunction devices for now instead of trying to infer reset
> scope from sibling state. Systems that can prove a multifunction device
> has function-scoped CXL Reset can be enabled later.
>
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> ---
>   drivers/cxl/core/resource.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/cxl/core/resource.c b/drivers/cxl/core/resource.c
> index 6d4528f77c53..464ca9bdae05 100644
> --- a/drivers/cxl/core/resource.c
> +++ b/drivers/cxl/core/resource.c
> @@ -979,6 +979,9 @@ int cxl_reset_function(struct pci_dev *pdev, bool probe)
>   	if (dvsec < 0)
>   		return dvsec;
>   
> +	if (pdev->multifunction)
> +		return -ENOTTY;
> +


I think I'm the one to blame for adding this patch after my comment in 
v9 ... and to blame because I think it is not needed after all.


I thought the reset_method() and the reset() sysfs files would be 
specifically created for this cxl reset functionality, but they are pci 
related and will be for any function. Because the check already present 
in v9 in cxl_reset_dvsec, non-PF0 functions can not have the cxl_reset 
method, what is good enough. So multipf can be supported and this check 
removed, as no non-PF0 function can use the potential memdev if PF0 is 
not using it, what is already ensured in your patchset.


Maybe to add some warning/info when someone tries to configure cxl_reset 
for a non-PF0 function, like "PF0 owns the CXL functionality".


In any case, apologies for the confusion.


Thanks,

Alejandro.


>   	if (probe)
>   		return 0;
>   

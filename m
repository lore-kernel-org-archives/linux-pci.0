Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013029.outbound.protection.outlook.com [40.93.196.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B91B64A8C;
	Wed,  2 Sep 2026 01:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788311895; cv=fail; b=HcPRzQlOtyW+3oMpV5DR7rCaoSTakwa3u9QnCwW02R6lgJdMLOk7w6dDC+ArmggPG908ID2bxCZqdchGB7jB5l3haxhAg/uV8yr9xzHtZoE3+qYDBwvSW/EmqMdKvnVpXWMXSxk386grjniaGxT1EuzBpO2I8PB/TyOYLMcRpgk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788311895; c=relaxed/simple;
	bh=DWJSHzPphbkBqR8Dapp3sVkQKJEODsIDLPsabBEuRZQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=T2kVFE8vw32CrfL5Fe+erLEFKYLPNeF9vpgsJMVq1DyD/8ZoC1uNjG8T0RgCm8wRmgNgHPcmgnjCBnV3kEkI+XMCfp+P2h5AWfW0I/Aaa5f5l899g1WYZ1C5bo+t45M1LYel1QsRZtBHq1Lzl/6C237PrW6HkTERMDCSwflnbu0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aDN4nfHK; arc=fail smtp.client-ip=40.93.196.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aDN4nfHK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v2TpTNBmPkbW/A6RJg0irm/L5oMSoXU0nkOuHCDt9P9ibVB+hnJuj3rWI8rn+hyNyNbxYto1uJ6jGGwa1oUHi0t2/QndXW5aQImFaQxs3fBTf4aheZkfzmF9XGH3ns82RuddV52eFLn5vToBIqqF9MDTyIxlZtiHiXdCfqdi5hQNuD8aeraoqP1W2XEr87i0PFuQhnJs6jZe4a5d98RBO5efdsqjebi7IOIW/Rtl2DvrHOq5BT+89NGfyO0RdB4HSUNkT8HdBt2YfeBp+IVYRSuzR1R1+czRiqgOL8gRYuQFCjgbVW1V8GRQ69Nq6BB/7J2v7xr5mey+jAp0K+MISQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Knr0nDW+GTfCK/wT6qyBQE4iNyC2593WkJYEBN58gzU=;
 b=bZcvfHM/q4nVCuPWzULYiafCozc1+YRMxY7QtZOUZ+/WsSeLUsLNfY0enqgc9aUCfc5TyNy5CbgYopHYmjukMwe3kx/sW7yT3jc/YnL+WUvbFl+DdkhVETx668W35urUUWTfdQ/OW6WyihdQYFNeIVPpup2Hm4ZX4DmVhw2oN3k2NOqvOeNWBbhZl3hctJnqqNoPlzgZZ50b59gUcNRDicnK8cfQBLBPMVEfHT8aFkyFIvxM1QlHNFGlFBNTxMrzQ402vlWX5HZqK71VM4EriXGkwiQxkzf9LspyPhP1CO/Emca+qjNDT/Q8BfXXYTGUtslzejYZZexypjVWQGy6DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Knr0nDW+GTfCK/wT6qyBQE4iNyC2593WkJYEBN58gzU=;
 b=aDN4nfHKFahJ43MeoZHtns9QQGXt2v0v7GFOS6ubUDXU2FiMPbjyS9S02s4TfxIZFaEm+RM8f22ZMlHT585HXiOQH7TmUE9LFjeugSNE7ml5JiMo/UXmKUmC46g1ehC1n32up5LuhVrhnpRc+M+BCMWqS+iswSAR2NntK5Y87gSWGGiyOLLb6anh5OJboF/sa7CQDb0ComVVIufO5XIH1r3j4niOhVksoUYJzjFBhdAESX/snFXQ1a9nN0E5WwzbG8Hhe/4keIrqAnE0oN8UGrlGKaa8nhsaQcDTJs4hMXM6PMaLlfNLXS/6nr24hrI2WCUidV5tgaszb1N9NsHtnw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17)
 by MW5PR12MB5684.namprd12.prod.outlook.com (2603:10b6:303:1a1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Wed, 2 Sep
 2026 01:18:08 +0000
Received: from DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7]) by DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7%4]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 01:18:08 +0000
Message-ID: <8f6afdac-d161-4b3c-9de2-7fbc02e9b3ff@nvidia.com>
Date: Tue, 1 Sep 2026 18:18:06 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 01/12] cxl: Move HDM decoder programming helpers
To: Li Ming <ming.li@zohomail.com>,
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
 <20260804192958.1823952-2-smadhavan@nvidia.com>
 <1570f22e-8764-4cad-be74-6e52be953bf6@zohomail.com>
 <85ea3a25-3b1e-464b-92b7-d8cbbf1c714c@zohomail.com>
Content-Language: en-US
From: Srirangan Madhavan <smadhavan@nvidia.com>
In-Reply-To: <85ea3a25-3b1e-464b-92b7-d8cbbf1c714c@zohomail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR10CA0014.namprd10.prod.outlook.com
 (2603:10b6:a03:255::19) To DS7PR12MB9474.namprd12.prod.outlook.com
 (2603:10b6:8:252::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9474:EE_|MW5PR12MB5684:EE_
X-MS-Office365-Filtering-Correlation-Id: fb04634c-4740-4c88-3fec-08df08900c0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|7416014|1800799024|11063799006|56012099006|10067099003|4143699003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	qGa/Jl1EbZElVWgZmIe+dMYCPuIjO9Fiou8ngZEp5qs/A/LvW9pSLDa4/6nGp2oAao4tNfXGupe/RHRehPV+GH9vq9YK/ld6A4tbRYXZSAasN0WWXrvmQ4sv06aVLgxmM8DxcQYSelcd5aiW+i8T9T3boEtpyL+ENARn1T/aPK8ChUmc11hw3+fnpBYBHYwqr+g3ZKyYxzS2/ItHN3r1cq0fiXn6TmkvXrHGYqdFuQpGRRYLUiub2TM9sOH25W8O3BJjSoExiKn2zvzEMAiIKBvj/vWDkjq3iWxi1IcYdR9j4Ytutew6xiK0yIy33nDK/V1f6c4oM9eHRTvXNvhlQI8gkWDXUGa0D1Wr24OOzyTGSx3Z5vZYBbm8d99lIQLBuuyK55nc4zce7PXuD6kZxydy15Pvwra9noW2IlndjgzdtSj0uId6iyIpajxAdIYGlw+2PszwC+2CkG2Nc5AlyJv3uDjeryWXQO1/yeppkTWSIzUl2mBYVLdPxAv767w9sZvlPtQOboZ3IapQfDlhSn3qeCx9dBkG5s8/SURbxBS4QVYXjrbv0vy0qZ03s3kyFfKdbCrzhS43k2gBSwZ8O+BjLNH0jDEWKpq+MxjcJkOBsNlvcoXQrLOwH8jsfw2fZ2VzksWG0Q13Xnd4G8UyGawdohB+gfoHGWkUSPyl5HO2ix42cArQ7j30maZ82U7RratH7XtvzjlVqv1NmrYjUQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9474.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(11063799006)(56012099006)(10067099003)(4143699003)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bGh6M0s1d3Bobk1yTjhWN0J1a2lud2t1ZUR5YkorQW1hbzNCdUhMUTlvTklZ?=
 =?utf-8?B?SXlZYjJqTEdRSEFoTzNtR2ZvT3hCWkh4aDI4RHRVSTJkbDhEM2pLSVMxemc0?=
 =?utf-8?B?bFc4OUhCN2pTZjVDL3NhaWd5eWN1SEFBWno2QjcvYW4wN3p3amJiVnBYd3NI?=
 =?utf-8?B?VjZPWlpBdXdRblRxdWM4RDdPUnVVZHg5bFVBOHpJbWdBQkJiT0Z4djF4RE5a?=
 =?utf-8?B?SjN4NjdZd3F1dDJ6Qzllc0NlSnJ4RmNjVjdlVTFMNzFnMXpOMytoaXFkWS9r?=
 =?utf-8?B?Z29adkpPYy9WM0s5SXB1bFI4d1hJV2FrRkMrRkF2YjBZOU40bGFESThzWE5v?=
 =?utf-8?B?d3RGS1JLRFUxZlowcFNmZEZhUnpmOVRiQmcvWExEb2RsTzZjNGE2cTBUYUJM?=
 =?utf-8?B?TmdOKzliNHZPa1ZrQXQ2aDdvN0FmaHl5ZEhEMWcwcC82UzJZZkZkWDBvVmtR?=
 =?utf-8?B?UVpSM2xCZTJLbnpNWWp6ZnFsT1cyUlBZNVV4UFFRRTNua01MYU5WSnFUQURX?=
 =?utf-8?B?clBNODl1MU5WN0lYK0NxOE5IandIQnNkejg3YTVqdVkrcGdtb1ZTUnRCK2Zz?=
 =?utf-8?B?RjNsUVJMNEhhT0EvQStJRzRGK3ZnRWVmeVNNbEg2NTBESTZqZlZDYUNPaWRx?=
 =?utf-8?B?WXVzNitKS1laRjFBcjVXWmgwRllxTnVwdkxEaVBJc01jRk1GNDk4QUJpTDll?=
 =?utf-8?B?M05UbUpMT0I0S1NMV1Ixa3JKUk85bVBCQ1lCeHhsNkNWZnRSSkF1WG5rbjIw?=
 =?utf-8?B?MEJnSlN1a0o2KzNqSjJIY1BJaGlFRGNHZCsyYVVSZHp3YU1oNmpyK2xOaU1R?=
 =?utf-8?B?K3pyc096RkNabTYvT1BBanFTNHpUTkliUUlCNHN6c2pCdGtkcDJKUUU2UjlR?=
 =?utf-8?B?V0RxOEtmUzBheU9LRUZ6VVUzbGRHeCs2NDlBTy9Sem96eGVsWitSRzh5TEFV?=
 =?utf-8?B?WHFUYm8vUWtmVXRuZmNRMy9yNW45MENuUkZKQUE1dHl6V05ZWjMyTnlneVda?=
 =?utf-8?B?KzhKYk45WDlmMVF2MjJHdld3ejB6YXhCcmwvaFlOSlpGVWp0SVM1RUd6bGdD?=
 =?utf-8?B?OUZQRVExdmc1VUNWTkYzczlEN1hyN1ZxV0IrZ1UwVmZUSGMxQXcyOXNHMlRq?=
 =?utf-8?B?dmZVaDJIVHBlUy9mUkhnVTZ3UlZWaE8rUlNVYWNHQ2ZZZkFJejNtY1dvUWpW?=
 =?utf-8?B?bE12Wm9hbVdkWlVLRDE5WXR5Q215b1M1OVFyVFVhakduL3dra29qekV0blBx?=
 =?utf-8?B?alJFZnQzQSttMmxLU0N5Q3AyaHQ0NFRTNzRaSUl2ZWpKT1V3OENmQVN2NFVD?=
 =?utf-8?B?K093NldjMG1YaVVyN1NKb3N1RDNjNDByOXFsN2NOeEg1ZXpmVEN5QjZ3M0JJ?=
 =?utf-8?B?ZmtydXVpaDVHK3dhQ1locFl6QUl5UnVPSVJlNU80SmZoYjF3NWpVMllZK0du?=
 =?utf-8?B?VnJqcVNlRnNqS3Q1cGdkVmJHdGc0aTdrdVJOREdzdVNWNk5yOXNYckZSUGFs?=
 =?utf-8?B?L0h4azI5M3g3aWlLUm9iUlJnYTZXU29JL0wrZXJqalljNURwRjRSVVFCQjAv?=
 =?utf-8?B?dnNSamtCVjU1UkdHdStMV2ltQXp3cXI5OGpzM3pjMjFMTWQ4c1FOL3QrYlVs?=
 =?utf-8?B?empGeHhtQ0VqcU83VkF2SEthL0wxL2NnZXl3cjUwZHVhSTRrbzBlaUQ0Y2dO?=
 =?utf-8?B?SGphbWNmQnNFNE0vWTY1R0c2a0QwSXRnMU9YdlhYVmo3REVPSS9jYklQRkZ6?=
 =?utf-8?B?SVpHN1V6RjM1ZFdmYTdVZCtSMTk2RXJBeWJHZzF5VE1oVWU0aUNQNDFGeldQ?=
 =?utf-8?B?bEVDYUlIdCszTllONlBPdGN3WXVkbnpqaG5Ca3dCVThUcjRiUzQ0ZW82eXpv?=
 =?utf-8?B?QlVBMmoyQ2M5R0FnQjR0L1JRRnd2L1cvQXBrYXRCbTAza2FPa3ZWWFhyQ3Ja?=
 =?utf-8?B?QVc5by9taEZoWVVmVGY2eTNzVkpNdDZzbytsSi9BZS9RZ0JNS2p0dllwbGFG?=
 =?utf-8?B?VzBkVnExdnk0Q2k3MXRFUFNDQXZreDQ5WjdTcFdjWnArMWU1TThsaUl3djB4?=
 =?utf-8?B?K2R3KzhMaWkwVEZmZ29qb2tWNnhMazUrL1FhMXdjQVRtdDdtQzl3MkJpRzVo?=
 =?utf-8?B?TUM5VDBId3pZVWFHZEJvRk5VSHN4akxucWh1MUt0T3lLRGVIR1g1aFJJekZs?=
 =?utf-8?B?YUpjdkZpaW4weGZzR1V2b1NoRVc1Ulg4Q3VsK0FYRlVtZ1RpL29tQUVXNUZE?=
 =?utf-8?B?WHJwNElLUDJ5Nm5PUGNlWDNGZkN2ZWIwK09MSk9UY3YrMDl2VTk3aDhjVE5z?=
 =?utf-8?B?Wlk1bndPTHczcWpUYUJHamc1YklZUWVEWk1qNTNsYmpZanZBN3QyZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb04634c-4740-4c88-3fec-08df08900c0f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9474.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 01:18:08.2141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MLaGZpcZvsh57b7ZJe8E7K228iSDGPF1p++ZlNLfSExxpQGi7DZPkRzt+EvywLockjjV03W4oaTC5bZ35wtQuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5684

On 8/24/26 12:19 AM, Li Ming wrote:
>> Redundant blank line between function implementation and EXPORT_SYMBOL_FOR_MODULES().
> Oh, sorry, I saw you deleting this EXPORT_SYMBOL_FOR_MODULES() in PATCH #2.
Actually, this turned out to be some churn on that line since it gets 
added and removed. I've cleaned it up in v11.

-- 
Regards,
Srirangan

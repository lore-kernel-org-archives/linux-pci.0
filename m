Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012028.outbound.protection.outlook.com [52.101.53.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7EF202F65;
	Tue,  3 Feb 2026 18:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770143737; cv=fail; b=Ra15jDWOATctOGK4vbwzR0SfsFwdRKKdrY+KWoZv10R3S1JYK4IJZt0nyqi6CSLcuHo/uMCC0Ywam0hTd7sNH1U7FhOeLvWfWeWfo7Dl5VnJb3rq6h6ql+Y6c0IL6MbuXogNVmwPsuCCQX1xDohlMCeN8QhSFTXjDyQZERP7eo4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770143737; c=relaxed/simple;
	bh=6i4Ss+48WWcLclZSJFlQx+CHQTTa8J3od2SOgpyVlRI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=L56KwfAwdo1EIlz9ftSIYE55Y5cEj2HkXHU35Pr9njbMZruqloeT0BjVtYQxBMjPaz4/r6318LyG/TWOwKbtwM/3SH9s13JbFXRK0m9LkcCI5v1oko0NHB0ngoXxVgDPPC7lmvwjRBrEDRDVJ1hE0lpRvP0j2WGzn8uOPXFVNXQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=teyTs/RN; arc=fail smtp.client-ip=52.101.53.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="teyTs/RN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JIE1p9zHd66+wfEehxV6O6vHPlEL6im9URT5qvmuBfMAbMX1cOibruEjIIqzhhMqsiIvF++kJkcilnAbQ/im0k7t9eeXPmW5pzCX7VSf99/6M1YzthgJqeypMeSO6jvBbwvM9mxb7XmkkqXYywcKM/Qy0aQUjOX0v8BLGuCkwO3ptxFSHOYeDzDVp35drRAQM1+YCpHrC3CShQYIFr6yuKTgQBDhRMcDO/QJX5krdcQqQikgZbjf7yfSE3xVP0h9lxV+ER5bocOkFngahwIkw3fN6Vza8IEf5U6/KcAtVjui5+f8kNEAFk4zidY17IpodiTE5yaOBuavAUSwAgTKOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OjJxYI7/OaV75z4KWPdvK/pTrRki1gMGkp2Gf2d0Tx0=;
 b=ZeKPahOCPlvXS3qIFPK2arQs3IMWlVlNBNt6859AMbGM6d2p3BwS2w3Fxw2GMNABoL7aqrFyu/I7985yoPWuQ8Vx5BEX5tR4GPJyyd9coGamPLIVUJaTTcs4djbS0joLkFzijUpBan7/rKtrNR0m4vxnzRR18C/Q8Nm7BlUi9mCYYGQmCLj2SRsClG7G3FF4Vpj0LxwCgatu7Avolj9sPeYrt9E4x0CNkR/DGgQme8bmUDexKkuL8yQjj/bUr46TcatE7/izzJDPmgugdEbc5oXpax2RdY3bo2NvJZcQjW8iUmpbLkadhiGAZfhehS9d1mreOuCRJJB92tifyI1ypw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OjJxYI7/OaV75z4KWPdvK/pTrRki1gMGkp2Gf2d0Tx0=;
 b=teyTs/RNnB6R/TmJVyQhUPpBQG91RuXX9Q0S9LhzypdxBFQqVQW+sQawL9Y6iP2/c1kgPu8fwNcQaAfX9efK073wA5BckstqLUV9I0Jq0xrLwmN1o/VaC9LSbG1LIjqDkhLZe+NreeYhu3elZP7EHQHa9+oE7SSrHmIfTH4sNdk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS2PR12MB9749.namprd12.prod.outlook.com (2603:10b6:8:2b9::14)
 by CH3PR12MB9282.namprd12.prod.outlook.com (2603:10b6:610:1cb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 18:35:30 +0000
Received: from DS2PR12MB9749.namprd12.prod.outlook.com
 ([fe80::ad8d:e59a:e61:4e9e]) by DS2PR12MB9749.namprd12.prod.outlook.com
 ([fe80::ad8d:e59a:e61:4e9e%3]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 18:35:30 +0000
Message-ID: <66927d59-4a27-462c-b281-078967f4fca9@amd.com>
Date: Tue, 3 Feb 2026 12:35:25 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 7/9] cxl: Update Endpoint AER uncorrectable handler
To: Dave Jiang <dave.jiang@intel.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, shiju.jose@huawei.com,
 ming.li@zohomail.com, Smita.KoralahalliChannabasappa@amd.com,
 rrichter@amd.com, dan.carpenter@linaro.org,
 PradeepVineshReddy.Kodamati@amd.com, lukas@wunner.de,
 Benjamin.Cheatham@amd.com, sathyanarayanan.kuppuswamy@linux.intel.com,
 linux-cxl@vger.kernel.org, vishal.l.verma@intel.com, alucerop@amd.com,
 ira.weiny@intel.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20260203025244.3093805-1-terry.bowman@amd.com>
 <20260203025244.3093805-8-terry.bowman@amd.com>
 <cecc5dd9-616a-4b8b-b081-d77ac947ccad@intel.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <cecc5dd9-616a-4b8b-b081-d77ac947ccad@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR13CA0001.namprd13.prod.outlook.com
 (2603:10b6:806:130::6) To DS2PR12MB9749.namprd12.prod.outlook.com
 (2603:10b6:8:2b9::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9749:EE_|CH3PR12MB9282:EE_
X-MS-Office365-Filtering-Correlation-Id: e80729d0-e913-4d67-4811-08de635301e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZkhvRGszcnF6a2x4bUFZZ20raWNjK2Z5NG1BalZ1Ny8zNXJQckg1dURFQ01n?=
 =?utf-8?B?N0U4NVptWG91VmdkaUZJNUhBWU4xN09TWEhJVzltb3JhbVp3aUMyaEdnRWEx?=
 =?utf-8?B?a1FvMWtpQzRaVTR5b2l0VGh5dmptdVJ1WmVDVFQzdThOdUl4QkhONUxob205?=
 =?utf-8?B?MnNJczBnRmVSNmkyTnhLRXlXTTVFNVEyOS9IYWVoRERKZEZzREE1VGViQWRH?=
 =?utf-8?B?SUI3VExDc0ZJZ1F0QVNLQkNPeCtTWnA2UTFUSHBqcmZWSU9LL0tvTGR2VFov?=
 =?utf-8?B?Mldad0V5dDFKUVlYM25iRGhsS2sxZWVFVWdnM3dJS21sdUYzVVRpd3NYRGhr?=
 =?utf-8?B?TThna2lZZ25Ba0FaUTYvd29sVUZwdEJ0SDVZVnNKRU9reklWSXhtZ1QrY0w1?=
 =?utf-8?B?d1F4TjhxUEVzYmxzNCtJZjhxNHN5TlFYSGtnWSt3Q05vTDJhb3pveWN6RUxP?=
 =?utf-8?B?VWdMWDlQTmFMV3JyTGhnTFJQOFMrMjk3eEhjYkhZTmgwVEQ2SExsK2RjMFg2?=
 =?utf-8?B?bkpmOFhtVmlBSHFmOXcrbm5zb0dCV3diSUtOMjV4NFR0bFdCaXpQRXNJQVdq?=
 =?utf-8?B?WWdqZkdkNkNlTmlTR3dUQXFNUUgraEthRThtc3g5akVqUXBYRjl5ak53WUp0?=
 =?utf-8?B?VHVQd3IxQVdKMWloU1lnOFVyQVJjT2Z0WnpCYm51R0EyWUFLdDN0S2VQdjZH?=
 =?utf-8?B?NCtSRDdyVXpuWW0vQVlpUW9WcWZMRFV2TnFBNWJGYWcwT2ZBaXZOek5rQzhF?=
 =?utf-8?B?UVVHQ043cnlkUCtLUHJpdjRJdXJ4c0kxbXd4K0pWeEIwYmh6OVdleTN4Zm1H?=
 =?utf-8?B?b2YrTWFZdC9OVHB2TndjWGlJV2lITVk5M2pEQ2d4T0hIMEhpeStPcGNxQkRL?=
 =?utf-8?B?d0dIN1I0ZzZWUkdvMk56WE5OL1M3N2V0b1oyb3VOZHFMN3UxM1JmREVXd2lw?=
 =?utf-8?B?bk9SU1VrSVBPTzdTNXR4bFZZSnZ4eWVyZ1BDRXRIUjI4S3ZkQW02ZEYvam1v?=
 =?utf-8?B?UlgzOXZBcnhmbEZMRWRtbjVxaktRaXFXZS9kWUdFVERiL1hEZ3h2ZTZidlNM?=
 =?utf-8?B?NStxNzlmd1lvRUx2d2Q4S2Q2U3JxMDZKSXg2bzd1c2VYMEJ2bEd6RStQL0ZO?=
 =?utf-8?B?QkR4dFQ3ZldBVDk3ZWR4R3FoRHlzRFkwRmxzL3NmUkJVTXo4N0FkRnlnMHhO?=
 =?utf-8?B?eWRSUHFIT2xiMEdnZmNuTGZIcTg2UndFSng4TmxuZzRvUzQyc25TSzhvSEcw?=
 =?utf-8?B?c3RNMHpWV0p3aUovR3hDdDVVMlBKZTZDbzBZU0hRMkhvWUg4V0xEM3REdnBM?=
 =?utf-8?B?NGxJekNjV0tYN1ZNUVZvK1FwQmIwYTlMQ095R1dqTTFjcDByeThNb3lpMUtu?=
 =?utf-8?B?WmMwQWd5YXVqNjNsbFBEU3c5YWk2UDBPcTd3Q2tPdDFzbUd0ay84Z256R0Ns?=
 =?utf-8?B?TlRnN0pRanZkUGk5Y3NycUE3encxN1cwQ09LYWRzYTcrL2toZFlSRmxTdDBn?=
 =?utf-8?B?cWpZak9QdVc1eGZUVklpRjNLVzc1aHc3U2ZHUGM0dkk2WTNEdVNrZ05kWWtG?=
 =?utf-8?B?bkFHT0FEOVFESGYzZVFQdVpMN0RmelYyakZKbjVBaU5ML09JajJqZzJRMmtz?=
 =?utf-8?B?N3IxM0dzN0FpVFVlUVNxY2JyaEowV2pGM25RVGU5RVRxRkFUcE5yU1Qrb3p0?=
 =?utf-8?B?NjY0eDFaRzB5MjAreWRVbkZwaWEvZEV1N1ozRWxYeWZrSWZXZ3ZaN21qbFg0?=
 =?utf-8?B?ZjAvV0JROHNxMTFmbUVsWDFncTl2TzZpVklhTk9BM2VaQ1BvbHBpWm41eGtS?=
 =?utf-8?B?c3ZTdnlBcTU1SFlCdU8wMkVHa2NwZUwrRmhHMG43SXZ1VEdmYTVHYTg4ZThW?=
 =?utf-8?B?UmZzY2JzendRWVVrREJjNnQxWCtUTUhGcExjcEFubHYwSkxJQWo1UjhwdW56?=
 =?utf-8?B?bEtXWHMrTFVkbXV5WnFVdXZpTm1qeGRCbU1WdWpGMHFzR1hXb2kxOTE2QUps?=
 =?utf-8?B?SFR1RWp4RHp4NS9Galhxb0dhbFRRVXNpYUxuMWt5M2xJSE1IYm5DM0FrbzJk?=
 =?utf-8?B?OHBrUmdmK0JxOHA5YXNGT1dMMGQ1QmVNZzhVL1U1MFhzejRZbUkrOUVxV1Nu?=
 =?utf-8?B?R2UrTVRUc042U3F4NzZUcEVXbHVHb2dLanlGZ1RzUXBKbWVST2VMdzMwb1l2?=
 =?utf-8?B?UWc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9749.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OGljdWxoVnZsRDdvUXJRWlM0ZTRza05EVlp1d1NvVnR3WWVodmcvQ21OYjUr?=
 =?utf-8?B?cmVtUmdzNk5KSTNUSzZYYlRIS1k1amwvL3pDTlBMMHFCNUgwTUpDVGxpSTdt?=
 =?utf-8?B?Y1M2eHMwSTZuTmFKajNZNE5rWHN0RHg5RzlCelp6Q1lLcGQ1UGlyU3RYazd3?=
 =?utf-8?B?Y09hSUxwdXRmSnlEaFFvYjVXK1oxSWRNVnNQclkwczAweGRUSFRlbWJvTjlC?=
 =?utf-8?B?MnF5andVTzNxdnF2SW5RcTBmUGg0M2w1anlPUFZNNFkwY25HNnE0bVQyTzU3?=
 =?utf-8?B?cmkyOG5IdWticU5ENkxJblpKakFRNDRZTWtXVUpwMFNLT2laVGFJQm41Ny9T?=
 =?utf-8?B?ekRZekJ0RUF5TmEvWXBsNHBhSzdHTzN3TzgzVXlTNS8vaXkvc0lwY3hlOVJH?=
 =?utf-8?B?Y2hjZmZ2bENiYUZzOGlhWGRBRzQ4cGRHWUI0Q1IvY1E2VXdzbE5EWld2WVRw?=
 =?utf-8?B?aE5oREFMV2k1NzhERzJlOEZ2UTh2ZDJEdU5GTjJBT1dOQWpGdHp5aHk0YXhD?=
 =?utf-8?B?aWNZWFZOL25BNDdpMG1WNTZpaU1SVXdsWnJmR2hyQ3doY2xoaFBLMXdHQUV6?=
 =?utf-8?B?bUpBb1ZXbWNnU2pPWVBzcVVsc0N5WGtvRGI3b1BqRU0vNXRrSXFjQkxTVDZl?=
 =?utf-8?B?UFk2Z1ZlYVdKSmRNZEVzYVNuQ3Qrd05tYW0vSHEvdFkxVE9TZFE2K1ZjVW42?=
 =?utf-8?B?dEpaK21HWmcwNlBpN21wNTA1RzBrV0hsRFQxOUVEbWNnU2xsdWM4dEVockdO?=
 =?utf-8?B?RXk5dkhaMEJoOGR5VTREbUJGdWcxc09kR1RzUDZ0L1ZYazNleGYvQ1g2djNt?=
 =?utf-8?B?eDJ2T2p6YkZ5Q21PVUhPVHN4NWZpcUYvZXQzOThFWE5OL21CcURDdERxeUNl?=
 =?utf-8?B?b240ZmFPK25SZzlodWlsNHl0TURJNWl6KzZLV2xJMEdjTkVoYU1IVHlvU0VV?=
 =?utf-8?B?OHV0Z0ZqOHozQ2t0czRuQkpnNXczY0xDQlltYWVNdGVCakUvTTdSMG5MQmhl?=
 =?utf-8?B?ZTV1cVMxc25xaXgwR3IxNllLWjRBbkg3bDQ4L09TMmNQSjRpOW1SUWNKMHBq?=
 =?utf-8?B?OGZ5eU1BeDJPNmpheGswS1ZzakVjUkZmTkZnZWFFdkwxV1p3ZmwrbkEvbFo4?=
 =?utf-8?B?QW84M1FkcGc3NWdwOFoybnpQWThEeHZxdnhxTlVZZUIvc2hIaCtRbktuS1hl?=
 =?utf-8?B?TjVZVVVXb01qSGZWV2J2R1JwMnk1elN4ZHdaNVZENkM4c1BjR2gxQW5ibnVF?=
 =?utf-8?B?Ymd4K0IwZTRQbEViNVdJMzNCZHdCelBxVzlRU295eUNuN0lRejhpZjFEQWNl?=
 =?utf-8?B?cTlFdTVwR1k5WUIyZmY1TTVhWVJYNkx2cG5mNDAyU3o3bnN1SVIyM28xWFZW?=
 =?utf-8?B?YzFYYTNCRlJaa1B2b2lJcjJqR1NsOVI3c1pxZW5hUjJnNHpxV3hHZ0cxdEwv?=
 =?utf-8?B?ajNycHFYdjZ1R2NOWlBzNm8xeHV2RTlSTDlWYlNGLzNvVWMyKzVmM2pkckxU?=
 =?utf-8?B?ZEI2YkowNlJpMGtEOFE4SE9oWG9YK0ZBV0xjNVdyN1JvYkV0TnU2MG9Ec2hs?=
 =?utf-8?B?NVBRdXpzK3dRdnRmbHZlMTMyRFFKWVhQNTVXZ291RysvY1JsVnlZVmRFZVhZ?=
 =?utf-8?B?ampZYk9LRUcvRGNCMTJuVjlkUU5GR0l3YWM4amEzZkdHWUE5Tmo1NXVvdTFE?=
 =?utf-8?B?cWdNL2JnamxjdXdJRVJUMXArVnduL0pVbGxBcjRNSXJMRVBTSEYwSmhqN1BX?=
 =?utf-8?B?cTlsZVdUUkVsUEpTUTdOR2ZiTTdzaEhSMktvalZaRUN6aTcvL0NzcURLQWxY?=
 =?utf-8?B?MjlZcVpTQndyRmI4TExqN0l2NmpKVWlCRUZOOEduODhrL09xbmZVQ1o5WWxE?=
 =?utf-8?B?TTV0Y0VPdkR6Qk1KRjQzV3k3ZlVyY2t6aDMweHRET0EzbW8zTEd6SnhBc2sv?=
 =?utf-8?B?amljWGYwVGhSYldkTnVoRVNNY28vWE0ybFlhelRWT25UbDNxQ3NwZVhGemFF?=
 =?utf-8?B?a3VnQTRxTGZFOGZOTmNBUG1DOUVldFdSWlMxY1pxUVdNdWltOGpWS3BKUnF1?=
 =?utf-8?B?YnlXR3czNEQ1MWNoUVdmNWpZZzdyWHZPQ2NHYXh6c0x5T0NjcnJrdVBGQ2cv?=
 =?utf-8?B?TlRkMGtsREs0b2xHSG9pY0RFaldwVitDYktHQ1RQT1hjQ3NlWnhnQUZ2elpO?=
 =?utf-8?B?Y0hxL09uV3QySXZsRDBaZ09XU0hsYWFhZm1pQlBaUXVIK3VJS2ErRXVSUkp4?=
 =?utf-8?B?V3ZnYnVkWEJhL2NRRUkrZUc5WmtBQVdmbGlGMmtpa1YzMlJNUUIrMmFCLzFC?=
 =?utf-8?B?U3UvQ3psclllYkY5ZWQzTHpkRTVzZVlpaCtOSDNyemhtSG1ZMS82QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e80729d0-e913-4d67-4811-08de635301e0
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9749.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 18:35:30.0178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QeBZq9BikeUtbc8L4twexBHvCR8bKjinjHs9WAaS/H4QAQKm2DNJCA0yAcALWD0vokcO5ibEhWRxxCA1wTRc9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9282

On 2/3/2026 11:31 AM, Dave Jiang wrote:
> 
> 
> On 2/2/26 7:52 PM, Terry Bowman wrote:
>> CXL drivers now implement protocol RAS support. PCI protocol errors,
>> however, continue to be reported via the AER capability and must still be
>> handled by a PCI error recovery callback.
>>
>> Replace the existing cxl_error_detected() callback in cxl/pci.c with a
>> new cxl_pci_error_detected() implementation that handles only uncorrectable
>> PCI protocol errors reported through AER.
> 
> Do we need to explain why only uncorrectable is handled?
> 

Would it be Ok if I removed "only" with s/only// ? 

After mentioning an important detail I shoud elaborate. But, how about if 
remove it and not refer to the CE at all here? CE shouldnt be mentioned unless 
good reason in a primarily UCE patch.

- Terry

>>
>> Introduce helper named cxl_handler_aer() amd implement to handle and
>> log the CXL device's AER error.
>>
>> This cleanly separates CXL protocol error handling from PCI AER handling
>> and ensures that each subsystem processes only the errors it is
>> responsible.
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>>
>> ---
>>
>> Changes in v14->v15:
>> - Title update (Terry)
>> - Change cxl_pci_error-detected() to handle & log AER (Terry)
>> - Update commit message (Terry)
>> - Moved cxl_handle_ras()/cxl_handle_cor_ras() to earlier patch (Terry)
>>
>> Changes in v13->v14:
>> - Update commit headline (Bjorn)
>> - Rename pci_error_detected()/pci_cor_error_detected() ->
>>   cxl_pci_error_detected/cxl_pci_cor_error_detected() (Jonathan)
>> - Remove now-invalid comment in cxl_error_detected() (Jonathan)
>> - Split into separate patches for UCE and CE (Terry)
>>
>> Changes in v12->v13:
>> - Update commit messaqge (Terry)
>> - Updated all the implementation and commit message. (Terry)
>> - Refactored cxl_cor_error_detected()/cxl_error_detected() to remove
>>   pdev (Dave Jiang)
>>
>> Changes in v11->v12:
>> - None
>>
>> Changes in v10->v11:
>> - cxl_error_detected() - Change handlers' scoped_guard() to guard() (Jonathan)
>> - cxl_error_detected() - Remove extra line (Shiju)
>> - Changes moved to core/ras.c (Terry)
>> - cxl_error_detected(), remove 'ue' and return with function call. (Jonathan)
>> - Remove extra space in documentation for PCI_ERS_RESULT_PANIC definition
>> - Move #include "pci.h from cxl.h to core.h (Terry)
>> - Remove unnecessary includes of cxl.h and core.h in mem.c (Terry)
>> ---
>>  drivers/cxl/core/ras.c | 68 +++++++++++++++---------------------------
>>  drivers/cxl/cxlpci.h   |  9 +++---
>>  drivers/cxl/pci.c      |  6 ++--
>>  3 files changed, 31 insertions(+), 52 deletions(-)
>>
>> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
>> index 970ff3df442c..061e6aaec176 100644
>> --- a/drivers/cxl/core/ras.c
>> +++ b/drivers/cxl/core/ras.c
>> @@ -441,55 +441,35 @@ void cxl_cor_error_detected(struct pci_dev *pdev)
>>  }
>>  EXPORT_SYMBOL_NS_GPL(cxl_cor_error_detected, "CXL");
>>  
>> -pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>> -				    pci_channel_state_t state)
>> +static bool cxl_handle_aer(struct pci_dev *pdev)
> 
> For a function that returns a bool, the function name doesn't sound quite right. Maybe cxl_uncor_aer_present()?
> 
> DJ
> 

I was trying to follow the pattern of detected() function calls the 
handle() function as done for cxl_handle_ras() and cxl_handle_cor_ras().

I will change to cxl_uncor_aer_present().

-Terry

>>  {
>> -	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
>> -	struct cxl_memdev *cxlmd = cxlds->cxlmd;
>> -	struct device *dev = &cxlmd->dev;
>> -	bool ue;
>> -
>> -	scoped_guard(device, dev) {
>> -		if (!dev->driver) {
>> -			dev_warn(&pdev->dev,
>> -				 "%s: memdev disabled, abort error handling\n",
>> -				 dev_name(dev));
>> -			return PCI_ERS_RESULT_DISCONNECT;
>> -		}
>> +	struct aer_capability_regs aer;
>> +	u32 aer_cap = pdev->aer_cap;
>>  
>> -		if (cxlds->rcd)
>> -			cxl_handle_rdport_errors(cxlds);
>> -		/*
>> -		 * A frozen channel indicates an impending reset which is fatal to
>> -		 * CXL.mem operation, and will likely crash the system. On the off
>> -		 * chance the situation is recoverable dump the status of the RAS
>> -		 * capability registers and bounce the active state of the memdev.
>> -		 */
>> -		ue = cxl_handle_ras(&cxlds->cxlmd->dev, cxlds->serial,
>> -				    cxlmd->endpoint->regs.ras);
>> +	if (!aer_cap) {
>> +		pr_warn_ratelimited("%s: AER capability isn't present\n",
>> +				    pci_name(pdev));
>> +		return false;
>>  	}
>>  
>> -	switch (state) {
>> -	case pci_channel_io_normal:
>> -		if (ue) {
>> -			device_release_driver(dev);
>> -			return PCI_ERS_RESULT_NEED_RESET;
>> -		}
>> -		return PCI_ERS_RESULT_CAN_RECOVER;
>> -	case pci_channel_io_frozen:
>> -		dev_warn(&pdev->dev,
>> -			 "%s: frozen state error detected, disable CXL.mem\n",
>> -			 dev_name(dev));
>> -		device_release_driver(dev);
>> -		return PCI_ERS_RESULT_NEED_RESET;
>> -	case pci_channel_io_perm_failure:
>> -		dev_warn(&pdev->dev,
>> -			 "failure state error detected, request disconnect\n");
>> -		return PCI_ERS_RESULT_DISCONNECT;
>> -	}
>> -	return PCI_ERS_RESULT_NEED_RESET;
>> +	pci_read_config_dword(pdev, aer_cap + PCI_ERR_UNCOR_STATUS, &aer.uncor_status);
>> +	pci_read_config_dword(pdev, aer_cap + PCI_ERR_UNCOR_MASK, &aer.uncor_mask);
>> +
>> +	/* The AER driver logged the error */
>> +	pci_aer_clear_nonfatal_status(pdev);
>> +	pci_aer_clear_fatal_status(pdev);
>> +
>> +	return (aer.uncor_status & aer.uncor_mask);
>> +}
>> +
>> +pci_ers_result_t cxl_pci_error_detected(struct pci_dev *pdev,
>> +					pci_channel_state_t error)
>> +{
>> +	u32 rc = cxl_handle_aer(pdev);
>> +
>> +	return rc ? PCI_ERS_RESULT_DISCONNECT : PCI_ERS_RESULT_CAN_RECOVER;
>>  }
>> -EXPORT_SYMBOL_NS_GPL(cxl_error_detected, "CXL");
>> +EXPORT_SYMBOL_NS_GPL(cxl_pci_error_detected, "CXL");
>>  
>>  static void cxl_handle_proto_error(struct cxl_proto_err_work_data *err_info)
>>  {
>> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
>> index 970add0256e9..5534422b496c 100644
>> --- a/drivers/cxl/cxlpci.h
>> +++ b/drivers/cxl/cxlpci.h
>> @@ -79,15 +79,14 @@ void read_cdat_data(struct cxl_port *port);
>>  
>>  #ifdef CONFIG_CXL_RAS
>>  void cxl_cor_error_detected(struct pci_dev *pdev);
>> -pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>> -				    pci_channel_state_t state);
>>  void devm_cxl_dport_rch_ras_setup(struct cxl_dport *dport);
>> +pci_ers_result_t cxl_pci_error_detected(struct pci_dev *pdev,
>> +					pci_channel_state_t error);
>>  void devm_cxl_port_ras_setup(struct cxl_port *port);
>>  #else
>>  static inline void cxl_cor_error_detected(struct pci_dev *pdev) { }
>> -
>> -static inline pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>> -						  pci_channel_state_t state)
>> +static inline pci_ers_result_t cxl_pci_error_detected(struct pci_dev *pdev,
>> +						      pci_channel_state_t state)
>>  {
>>  	return PCI_ERS_RESULT_NONE;
>>  }
>> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
>> index acb0eb2a13c3..ff741adc7c7f 100644
>> --- a/drivers/cxl/pci.c
>> +++ b/drivers/cxl/pci.c
>> @@ -1051,8 +1051,8 @@ static void cxl_reset_done(struct pci_dev *pdev)
>>  	}
>>  }
>>  
>> -static const struct pci_error_handlers cxl_error_handlers = {
>> -	.error_detected	= cxl_error_detected,
>> +static const struct pci_error_handlers pci_error_handlers = {
>> +	.error_detected	= cxl_pci_error_detected,
>>  	.slot_reset	= cxl_slot_reset,
>>  	.resume		= cxl_error_resume,
>>  	.cor_error_detected	= cxl_cor_error_detected,
>> @@ -1063,7 +1063,7 @@ static struct pci_driver cxl_pci_driver = {
>>  	.name			= KBUILD_MODNAME,
>>  	.id_table		= cxl_mem_pci_tbl,
>>  	.probe			= cxl_pci_probe,
>> -	.err_handler		= &cxl_error_handlers,
>> +	.err_handler		= &pci_error_handlers,
>>  	.dev_groups		= cxl_rcd_groups,
>>  	.driver	= {
>>  		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
> 


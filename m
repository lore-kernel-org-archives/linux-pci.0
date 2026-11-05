Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.29
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793894797;
	b=wX0Aq+PqVDvRcT/lApMOvS54OdWuZRagSYrju3qPnsELaWBwQQcROXftGpLWXibjYMvs
	 bagbxcMAZpziOAJn0CtLXy0DVft0UM2sqLncNQpEe9RDmcnYszVj0RbrO0ODeX2JC2QVm
	 JZ+mI/YnQhXLSLbd90AkRjBuBlehEeEGqsnnlKqSdBc8g8ULLw3t3oZf/ZXxtc5sO9Bcd
	 u4doxaSs0BKFOysRHLrroIf+yP9EEetIRBQ8B5E6Vh/NcJQBSw5uSy2zaXV/X+U9smMrl
	 qP6b8bcNaaVIp6Ts3PVrDZLAWD0n5T5oGdcVTaDoOLomML9xpJCI3IavqKzlHyRfptA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793894797;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=V0Ab4n8PjvQEM5sVg9OGcUM3HvzhpkL56+/kJYxM7SI=;
	b=qMSMeHAh+419kS/52w8C434EWe2rliRGRjmX1OzZk49m6+OvBbVzKRikoqzoHN5bvyb0
	 lKRdxOYEQNpOxYXiGSHoUoB3pf6DUo/M5rboA2E8fYoHHDJsPoCzDL+NxPsaJysLylTqO
	 xvXAKzjAxaG7bbQCu/97QQWAgP8qn78ckZxv3vpsKTogh4TU8wlSsNt/wxiaaiA4dYfFU
	 CJbCRRD19HcPVK9dr98fckeGQiJrqaSR7A+rvY+7PAdHilzoIPFH7ReD88iGzkZXSJrc5
	 9hR5r3lYrPoGi9BRcjRJp5aWLWAxknpgLs0pBAabG013tYxGamwgNR+Oqk4tFcetxyw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="I/8YOR2B";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.29
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011029.outbound.protection.outlook.com [52.101.57.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081D7606A339;
	Thu,  5 Nov 2026 16:06:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 081D7606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=I/8YOR2B
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X9rlVhO8/lWDa6Br4wQLS44NktvuPLqwelcSPtWtWSt1VfZUghdepDTnjNtQgaH1BlyF7j6U7qe274xpdvq0+5fJwS50sOvVSNtpUvDFzRXJLGTRQXkK1FZkW7Fg5Ins8vXLQ4zXQ0O3StQi89QyCHjcVh+ZafD31ZUULGSIOf+7jvGaBZ2xe9UVm4lFAzJfs9nLQqAxeUb2oEzjm9dcM6HhrzkV8z0jLTXx5an52YJK+vOAcPOYFz4R6Z6BF2WYPFxCa+Y5HymrGQ3Zrqk0PFisXm3LkEQ3oe0IgUnsy55LnUkVz6+uBv0ncmLmZIF2Wbws2DZuh/xLz8G0f5SOSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V0Ab4n8PjvQEM5sVg9OGcUM3HvzhpkL56+/kJYxM7SI=;
 b=fCZWZXjp254l/FABdrU3+RSai+KocJSiMmhcXy843fBkNc4RzgQy9UK5eNS1LmJn6CNgo5wBG4maumBsI7luUvm77mTvCc7zx9CnCFWZDUhemKcVnck/ii9CdW9sxrgVtdaKziUkmFD01EZopT1Q0TgrNe0Ki6bFR9gn5ZeaX+zZ2fQvzLx9328Z6IiR1sLjjttn1qDkMyhY7FJ7NOgtJOohJaMfc9uW5TLZgoX/19BHekJ1Ne8gJMBxUPD9IaHVhr1V37JE33KzLfjylpBzDGMVUVdN8w3D5ILblu8DBqXrlR5T9ig1ZPFlrtz2UN5vwos4/+ti2c1gcWli6BTbwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V0Ab4n8PjvQEM5sVg9OGcUM3HvzhpkL56+/kJYxM7SI=;
 b=I/8YOR2BcN6JmeUIAWmHMR5/3BmzGOUWiRWZD4/q/RHDujHitBzXk9b9fYdB5eZOxZzKBy2pO5QY/Kk6JFEZSdLPkPBMM1sIsUQ3wiyjvzJFOPHPXQPGQ44nswrgNLj7FDu9m9m0VETL0GTwqql0KDplXquAYKaM20z+l+criiID4oblpTncPu8+4XQi1+2dvIgGu2WVLprbqN5YzimTKMQ57Bw3xDwwwpSNY0Vj+179LVXketVLbTkWOMYw1xZzWc/Nx0+sPxUyJnUNRqo8eTpWUODDwdaD/aWOpeBwWBrQ/THE2+ppoPPGLf7Mk6dH/N7EWbaT2GsF43IVXjJx9Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by CH8PR12MB425199.namprd12.prod.outlook.com
 (2603:10b6:610:32d::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 16:06:32 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 16:06:32 +0000
Message-ID: <45e3d778-d484-4359-8d7b-edd1de303a2a@nvidia.com>
Date: Thu, 5 Nov 2026 08:06:28 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 11/18] PCI/CXL: Cache endpoint HDM state during PCI
 enumeration
To: Richard Cheng <icheng@nvidia.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Dave Jiang <dave.jiang@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny <ira.weiny@intel.com>,
 Jonathan Cameron <jic23@kernel.org>, Vishal Verma
 <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Li Ming <ming.li@zohomail.com>, Alex Williamson
 <alex.williamson@redhat.com>, vsethi@nvidia.com, alwilliamson@nvidia.com,
 Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
 Vishal Aslot <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>,
 Jiandi An <jan@nvidia.com>, linux-tegra@vger.kernel.org
References: <20261029145703.2185231-1-smadhavan@nvidia.com>
 <20261029145703.2185231-12-smadhavan@nvidia.com>
 <auRQN6a3QVtqjd5a@MWDK4CY14F>
Content-Language: en-US
From: Srirangan Madhavan <smadhavan@nvidia.com>
In-Reply-To: <auRQN6a3QVtqjd5a@MWDK4CY14F>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH5P220CA0007.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:34a::12) To LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|CH8PR12MB425199:EE_
X-MS-Office365-Filtering-Correlation-Id: 465f602d-ae3a-4e29-aaac-08df3b56c255
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|261026121527099003|4143699003|11063799006|261009223027099003|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Q0vfVIhKP6hCta55nzPvJPoagIZpqSwZsIVGgQQSH36XdDBSlpuZvNOYdDXM3+uW3xikOoUF19pZJYhx2y8h7Vg/sKThWEZHDFoFqQ5HYSkpEQmz5J7/1+2dbUfcMnXjbDRLcfVr7ehEcT2pFddD28VpZoSHKnU18JjxpTUyWfSANpQ0NHWKAjbJflZ4UoQIMBoWghvlrImvbluqEbmTJ/Q7EBVFMvPPkc1Qo1YfqSfLk4mjAkOfj/Gyef4jgtsZm6lA0zWcJcw9KHBJVFUuXn9ZAYVAPLKXRR01iOmDaZKw6/JbQJ7tDNrATy3GCpRQDSJUgOh8oU/uzy9D1sW3l3Az5HhVvn2ZHAz9nXLt9Cl6Rl6ctDI/GX6CcI16A58yq3brB5+VLohhQHrxy/y1FuC+CMtkxC8H7kIyUCpk2gjZQs04NmTT5t3RTyjCcOQjdV7F5ZJs77PMl9IIvpEw/ajFpFFMrCctI+GmxpRD3bxZ4842g9cdn9chdFxfidNvjoraVQ9PlyxFsMiLkqgO0f3G/SKZf3NcW/0+yE2txcS53zUAn9cLhzGd2kocm6h9+oLhfZutj0Y4uscvG+PJCmz1dNjNeKTJZRpLCmg0mYMPv7XFauilukBrSxdMi/1YhOXi6vdHY01FvayxePD3l8CNfbmwL5JiySnBDyHD73c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(261026121527099003)(4143699003)(11063799006)(261009223027099003)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y2UwYTdtSCt6NkdVR2VQeWFOM0REVUxUamYyUXhSb3JtYVdWNVhrUUMrNnA4?=
 =?utf-8?B?S0hkN0xveHFzNFdOZ2xPKzVLQ1pBenJreHNCTVJVOHpTSkFvajBoL01vSmZL?=
 =?utf-8?B?M1poSHRDa2RqM3Q2VE4vNjVob3JJR1E0UzUzZUdHdDU4YTNZUWJlYUpUR0ly?=
 =?utf-8?B?V1c1b2VuN2F4SWFRbTViVk9nT2dGR3h3KzRabnZnNjZlckVEcXVhS0E4RUd3?=
 =?utf-8?B?Z2tlc0JObXV1dkVkaUFzTkdkeTBpcURFWVlueXZWN2hoMnBFaXNuOFJuUkI0?=
 =?utf-8?B?ZzQ0TUoxdG8vTVM2MW1STjBsRWc5RXRLMkVUWXhsd1c0V3h4REM2enFXOWFa?=
 =?utf-8?B?SW5SaXU0SklFMmpCOWNVdERlSTluR3F2SlllbW9wTUs0YU53a0VlRFQwME5a?=
 =?utf-8?B?Qi9MZ1p1QmpUbHViU1lIQ1RkR2NPS0dnN0p4WSszS3pmZlZDeHRTT2t6Tnlx?=
 =?utf-8?B?OEVrc0VQd3A4RzJxdVRZeEZqR2ZTU0kybWhjQ21tdXZlSVAyeEZBMkFueEVG?=
 =?utf-8?B?aVhjM2ZMblFVeG5ocDFWU3VLN05rM21Sa1E1M3pzZ1J0NDRrdk9JWThqL2dL?=
 =?utf-8?B?RXhxUnowMGxWTUtJdzRudXl0SjRtZjZyOWZaVmxUaHoycFRVMlJKKytRY21n?=
 =?utf-8?B?cklPcjI4L2M2NGZybEg5QisyaEQwekM0Zk1kRWE0S3JHRmVPRmtvWUd2dDFO?=
 =?utf-8?B?OW1oOTBHakQ0emZKQWFHYTcxbFc2S0hQazlveGJZd2x0L2VXMlBkalN4UWUz?=
 =?utf-8?B?enJ1VkFDWXpsZnp0aWJ1aWFKV1FKZHJ2MGtYMCttc2VUb1hXMnU4bGVUL3NL?=
 =?utf-8?B?NXhWNmdOZmt0YUM3SmpaR1RKUlk0SUExdGpjU081emtrVlh1Q2xaeHRtS2Ft?=
 =?utf-8?B?YjZxRDdMblIrMENIK3NkamlMekdSbnFhWlZscXZ2dkdNckgrN3RyNmpHOS9h?=
 =?utf-8?B?SlFZenFNdFNhdVZNQ1dLb2t5T2p1UG4zcys0clRYVm16cjQ0N3g1aHVmUDMz?=
 =?utf-8?B?c1JvbklhNE5nTW0rTTRLQ1VCYnl0anowTHhmQnI5WHJ6d2tTQXN4WHVWNWNO?=
 =?utf-8?B?Z1JLTEtGMHErWXFjTzc5dmFvd1JHMHhKaXFWK1I0U2JKSCthdkhlZEJkbUNw?=
 =?utf-8?B?VFM0dXFPQWU4VnB5YXJ2SkZXQjJOKzFrUjZjYlVkOTAxRS84NENFb1YyZ0Z4?=
 =?utf-8?B?RG03TFcwUHBpU3hhRWNkSjhET3FUL0tqaEo2TDdrZ01jT3FnN2ZzMGFkU0U1?=
 =?utf-8?B?VHhta2Y1d2pmRzI0dVNYQ0xneHZabllxSkMrbEFKQ1B6NmxRdDZya1VMRG9W?=
 =?utf-8?B?K3FJVjRIQVAycE9iekczaTUzdzF5TFNpcitucnBKMzRrMFNKdVFPb0ovVXpu?=
 =?utf-8?B?bXcramtoL016Q0FLODdtWVYrOUFaeFF4U3lFOUZKT0VkazJWZ3NRcFpnM0xL?=
 =?utf-8?B?dHhUN1RRUGtPTm1vbDNRcWtmUWw0eE1uWXFxb25tOWRjdmRBK0VxTXZNejNM?=
 =?utf-8?B?Rmx4MThwZUVrT2Jabzh5cHNFUVFHUFNZTi9TWGRPL21mVEhyZnJlMktOWVVw?=
 =?utf-8?B?VFRyRWtVOHRTM1BrVDVUbkUzTC94eEFsYkVYSy9DVTBPd0U3eXJ4c0FnK2Ft?=
 =?utf-8?B?Sjl2YlRnRFozMG4wNGFDYnI2VTZFRFFtMjY5WlgydFZEQk5DREhFaStxdmJP?=
 =?utf-8?B?N3c5UW54ZHlJRTJ2amRaY3h1YmhlWk1sYkhOZjFxaXczSUlGOW45YnhjYk9r?=
 =?utf-8?B?K3NQcG1BZVlFN0pjb1AwcDUvRFpxZ01RSlp4UzBrRTlLTjlwd1lnRHhkRTMw?=
 =?utf-8?B?eTJUNXBFRzRJcE9hQm1hT0R1TlVXSlIrK2pwYmhaS3lWRzFBdnMwalV5bWYv?=
 =?utf-8?B?SzhLRXcwcjMvMDhNaVpxbEdNTFUvZFd0WW8ySGZIMFhsMGd5dFhCbTB3cmZD?=
 =?utf-8?B?eDRGU2kxeXMrc0xwV0pCdzFmck51dWE5ay9CZEt0UndvR1RLR1h4NG41UzdF?=
 =?utf-8?B?RzcwWjA1M2JSclVGQmdKWHpLOUh5OGV5WmRiYUVSZUVYY0RRUVkwaFlRdUR0?=
 =?utf-8?B?SFZvWmsrdE11R2FuMnNVeFgrYnBpMGlmTHpKTU9Zc1IzOGs1TkVTUDloVEFC?=
 =?utf-8?B?Uy9IejIwdmJpcjU0VEZ1RFRMWXVTREZHYkgyV3ZJelV1VGhpWHUzelFhMCsy?=
 =?utf-8?B?eUs3SE5YTmhDTlBOaVJhT3VNTjFqZEhoNDV1WjlUL2Erc1lSSDdZNUp0bURZ?=
 =?utf-8?B?eFJyMnV2TUlYTXdJUkJ4TlYyZm05K1MyRmRrT1BXN0ZyQ0dxYUU1YnE0NFIw?=
 =?utf-8?B?ZmV0NVUraVJmSUNZV2xkblBLV0FqdlZmZ3p2eGEvWUdnKzZJTUZkUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 465f602d-ae3a-4e29-aaac-08df3b56c255
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 16:06:32.4516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xaQ6tF7GJwC9Wa8x4z6NpCxHwg2febEt31XXUNzNcKjjR4rZUooEk7A9rqGS9RrT7uFpCsZ6/6nbJiISl9hgZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB425199

On 10/30/26 1:22 AM, Richard Cheng wrote:
>> -	return 0;
>> +	cxl_hdm_cache_set_dvsec_ctrl(pdev, ctrl);
>> +	return ret;
>>   }
> Hmmm this change the old behavior that when "ctrl & PCI_DVSEC_CXL_MEM_ENABLE == val",
> just return 1, it does cxl_hdm_cache_set_dvsec_ctrl() now, I wonder the reason ?
> 
> Update software snapshot for the new design ?

Hi Richard,

Yes, it updates the software snapshot for the new design. A reset 
restores the cached DVSEC control value, so the cache has to match the 
live register even when MEM_ENABLE already matched. I added a comment 
saying so in v17.

I also made cxl_set_mem_enable() return -ENODEV on an all-ones read, so
that value is neither written back nor cached.

-- 
Regards,
Srirangan

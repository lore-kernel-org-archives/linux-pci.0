Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.29
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793894850;
	b=T3veJAQiqHNJREEiCuPIZqeBTW1JOifG/QpYOJ1M3AVAx3g9NlIyKJEA28iVgfoqhEoh
	 Orluyra6gGGh6DJsO6iL8YjVCJA8R05K9KgMJwKKOwprPYdHwbJ9mGmjh/9UJPQQt2GPn
	 EsecMM1WiPmJuChJaY7MKRrYi8XLSY2jVLF23oTk1V6SrYacuAVcUATUst7Ve92z6+iWQ
	 zMSQlYO/8XyRSAquBrIRJVI6yJO6GpdZqzC++nqXfOExAN8+Z1+FCgmGbOQIxUSO3RUvE
	 s7flzFlrjkyLAtKsx1otBd01i5I0qLUyHETVAVqTrB2exiB8XQkQyCLwYTz2pAbVUZw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793894850;
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
	bh=5RWE0VEOJQ8vdTzSZPFKEph2xDDFhE+L3KeW3fVADVY=;
	b=ULio0HNR4DmF7lprE9c7AOEUbtkx64JE1N+aMxkSpC9OSbzcddupO6OIw0m73YS0g9br
	 IHTQF8CtCaI4IfzlJ5rODznWfr9v96QPXRKInClSkXj53TH/6AqLeOES3E0AYVWpenb+z
	 hUOHqh96ifpgSG8EfQQihQLTwuRbtGSyr4WBl13N0Dx7RAsIguYfiBOBh4wiF9PFhrLGg
	 /IGk6s3JVCYZBMiQu6AEHB6vTC6uVQHQBifhwnWlplmh+jKL3AhvBelVJ8z3sqNHlnbKQ
	 Hchi80yZtr2KueGhYvlLw1iwQ6qwtgAY8N/MHxFlCzXWZMY/2PEnsYaFPzFy9e85VGw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=TpqLZ1ub;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.29
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011029.outbound.protection.outlook.com [52.101.57.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82469606CFAD;
	Thu,  5 Nov 2026 16:07:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82469606CFAD
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=TpqLZ1ub
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WhOOlobLgr8NpKQgMBS5rt4Hpcsch6BY17ypQVnU7+UeMnvJk1hWbl9v3s0pZ1Ukrwrxf7jHbAfmY2MwErZNlxZTMoaQL/shcZuVM2p79XQhnvS3fm8vBvXCnMI5qWct3kXbjf+VfeqJp0r7iwGA91stCgD/vXCbjLSlJdb+iEIq/7RtdaXwz8igIyPC3ciF4pvXSjHEzF+vtXleXPwkisz1UPdj6z5d6F2Hpw4Ghg6YRBjCtUk/gPJF0WJErclopdlDFpoP7PfPDgsT+Jf7krk25jlccpGUrRB/XOSJlYLtI7wYubEaFCKk4LihjnnJYwt4wUKQl4TbB7/hJzZK7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5RWE0VEOJQ8vdTzSZPFKEph2xDDFhE+L3KeW3fVADVY=;
 b=Fn3klvlna5MFWh7h9TVgLaD1QgrR0VXEOb3Ux9vbjuly8K1vQHvXbi4PcYesgTAtvOmGYqzVWk/E8dcHnKuC21NmtZoETG8AkPeXJNrb2sc0478x4y9TR1YoPnyktd8tYa6+XSB7DGULtgCUUD1O+kIClxxJQyPgVRu8QHB7Lu10cwDTyyiG+SlOJvZUShMqVpmHJTW+fQyd2Arfa75H/WYAXb7FUN6QUF2jgxaymCrPMVNVjQ6UjGZEP/XtzmGLh03MGj//yOXD5VqCGKKioIKKPXXf3r6dBII0rU18pI8gMwev8RJgrKlJbWcMz1Jt7T3SFn8bwPLF+cvnE4whmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5RWE0VEOJQ8vdTzSZPFKEph2xDDFhE+L3KeW3fVADVY=;
 b=TpqLZ1ubo8AI5DC8MVHP9/54DLFcCt3f+KorcdvwPT1WwPG+Y8HJZc+mBYz+fWuPFJtlofG9i/OqBoXlhXEEOzbgoIdGPg3H10c7t5TrTrxKVut/MBaI80lQJ3vddRokSkZ8UkAg96FK8dXrYMvQnfr5mOGpegKyDuGMAmvGj9pk1yJFTsklMJ6RaMB2Tou8udeAwLnA8bHG/rYv1Yp5Fv3kzNLThxITpbQzX+05d8WRNjvEMm4L0OGE00S8FshCjbSWzeRxp+KrWHyzFWBu/kSFEzEAq3xI2gR2D/CHZ52NCqkv9QtXI2ZRdNzxcEPs8k29f4Ngkd+cBAQYMCN/Kg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by SA3PR12MB8804.namprd12.prod.outlook.com
 (2603:10b6:806:31f::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Thu, 5 Nov
 2026 16:07:19 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 16:07:19 +0000
Message-ID: <6dddd6b7-725e-4b97-ae8a-15f7de1a6b0c@nvidia.com>
Date: Thu, 5 Nov 2026 08:07:13 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 07/18] cxl: Share HDM decoder register unpacking
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
 <20261029145703.2185231-8-smadhavan@nvidia.com> <auQ27s1rSCcbdRJ3@MWDK4CY14F>
Content-Language: en-US
From: Srirangan Madhavan <smadhavan@nvidia.com>
In-Reply-To: <auQ27s1rSCcbdRJ3@MWDK4CY14F>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0229.namprd04.prod.outlook.com
 (2603:10b6:303:87::24) To LY0PR12MB727857.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|SA3PR12MB8804:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c283558-237b-4849-4df8-08df3b56de0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|7416014|10067099003|18002099003|22082099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	XSpIfEp1mKWhTaKp67QveV1BvQbiIy7/3HyC8nub72G5zhNXBrete7v646ft6cF98MOcDsdjwOCUawJQLxWXtgNgi7/QYwq8fSZ+/OTSlIeBny1G9v7buuU6V3m0lyAu3FzZ83ExRZQtyoKBTRe/jGbasLGxYODxFzNCURhBCeRYs+nrTUz/0K3/vD9ifro1ZolAno/vlvfwz7YaIuUuoOCgw3Z1DGwNpxdtsmMecyT7FN/DWKPyGVso9safDBciWvX2j/HMsnmKutzKWgvnKfF/mZh4ZPi+rLO0dcfNtRWq+YfIMMtFNwuEX9LBVgJPdMZiCMMnGd9HGb8N3YeU+Q8CUIKbvZIOaSDdxo9hmAlsTQQNrDZdwQJ0cR5a5XEmIYO7CZC4OPuMvTanj4ckOTgDFnjpmK6ipcisYhpWy4Fp0H+BureJPUPzaBy2R6s/xwlQ6e1BFEJq+sutwk/5VDc8j+uzKoV0aOZNHk7J8D6bdzCk7fDosB+4lsdNj2dX3uOedVNael3si8ws/pVbXkvCbG/UBaxZwa/MlS+dhpU+6JAGimB7ph/y1Z5H1DiObby6Lqex9dzv/dpH1UaWjP9xLDxCWOxpTukWPgtr8UKsQWr/xabiX4aRjTUVTvnJ6Zx/03DQj0c79OFF7lE2u5Hol9trCoQ2X4eU47E7yHg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(10067099003)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b05McHFGeExCUGdEaCt1T3lMdndrVTJicXJHOHJ2TEtrbnBMWithVndUQkVC?=
 =?utf-8?B?RDhqZ3FaclpIUGljM1ZUbkhIY1E1QzBHRTNhRSt2Z2Y2bE9hREtOdFZFdU1m?=
 =?utf-8?B?Mmk0NFJnTFRxRHprcHZ5anZVVSs0Ym5PVFhLVVBZUFJGZGl1WkxhMkFWS2Nm?=
 =?utf-8?B?TnRKTDI5QlhuZWdGekFwRmxYa0FPM0VSK2NJdXRaVVdGL1hENm1pem1BOFV4?=
 =?utf-8?B?d0lwQ0VjK3F5ZXE1aWg5TzRCSGRHWlNFWHZobUNCSEF4aGFPRG10MFI0Smdp?=
 =?utf-8?B?elJEcEt0cmc3VmZoSGE5UDkwSzZEU3FZTWhxN3o0eUFXR3Bnc1IzZFlsNmxi?=
 =?utf-8?B?N3FsakZXcDN6R3VxRnBkejFvTXV5NWJQYjluWWkxVFlTMU9ZdVNsN0ZmT3Iv?=
 =?utf-8?B?ZUYxNE5WZWxpZXZXRHA1QkVwbnZIR0lUSVNnSWZlWG00dkVjaGlOa2x1QjJI?=
 =?utf-8?B?S3pVdWRzUjhtOHN3V054SVYxWGJLYTNpcFpabzh2QTF6YnZFNGtUNnRlVkNF?=
 =?utf-8?B?ZEdEWkZHNFIwWTNXU0VqSmxVeitNbkVxbDJQRWxmOFhDMnl0RTZWWFBtUWZa?=
 =?utf-8?B?NGV1YVFHS05SSFYxOWRYalY2VHFETVUwUHN3Q2M3ejNhTHFpbnUrZlNnbG5Z?=
 =?utf-8?B?TnFOZXFmdGNyWGpxYjR0V09JT1lhUlJwNXBSZHVRL3h1N0tRajNtRitWaG5L?=
 =?utf-8?B?UWZMQkNVcFVFMm9zeW81SkpCTk5QZXNJMTBUaGZqWE8zL25zQSt0RnlvT1Aw?=
 =?utf-8?B?R0V6eGdsQ24yN05LVm9oU28wdVpnR0F5RFV1QkN5N2lkNGxwNk5vWk5vRDVW?=
 =?utf-8?B?Kzd2K1ZDV2FzSCt4Q0NRaVZyblBzWTNFdUlBL1FwWDRoNExZeEVqSVFrUGMy?=
 =?utf-8?B?bG9pU3pxb29lOGh6NmplVkZZWmdRYmd3OXBpNDRmYkJXaGZDREkxUzMvbWVM?=
 =?utf-8?B?WmNKWldzZm1GSUlkc2svdlRwU05BL3dQL05nVExsaVhLRzBFK05qb0s5TzNm?=
 =?utf-8?B?bWtoekxZRUxGd0Q1U0k1S3JBYWduSEtGK3RrMlU5SkVVVUUwMEtSYWdJM2hy?=
 =?utf-8?B?RzNpVFhwRUZ1d3FBaWdUMUg0TUR2THVUeGJtNW4vZWI4Y3BSM3dXZnRIbjdo?=
 =?utf-8?B?aW5xZDducG5Ya1hWb0daWEdRUW5sRndXZEJRRCtUUVAyOEp2U2l4M1d1emRV?=
 =?utf-8?B?bTNqcUpmR01nZjh3d2dRT1o5bitXYTFoN0dSTzA0cTJGYmZKVDY3OU1IZUNZ?=
 =?utf-8?B?SVlDLzM3bjNHTnNJU3NIYnZrMkg1UnIxYVVmOG5CT2k3UDR4UG1MSG4vamNC?=
 =?utf-8?B?RlJpL25vM2lBR2hUdU94L0NsV212QTZvbVlRL3lUNk4zcm8ySEdqRHhPalpJ?=
 =?utf-8?B?dXVlZy9lNWU0THhKVldFWXZJSzNnWStyR2VRVHBnendReGdVSWtudUFvNFJX?=
 =?utf-8?B?SjcxOWZrRzNITGIvTGxQT1JWcERqbTI3SXNBQzFSSTVxa05id3NpK29UQTN4?=
 =?utf-8?B?QnlwaDU1amM4YkZMazZ1L2ZDdktyUnJEYjcwM1JxSHpOenBHZE0zVFRZZytP?=
 =?utf-8?B?a0VFTTg0NGsvcGxETEs0WkZMaFplMm01RkpuNnVqUkRLNmQzYVQzQ01oRkJz?=
 =?utf-8?B?cG5EM0FJQlNjRENqRTBNbHpQVVhLZ3JDWi9pTDU1akZGWExlMWZteHZ3Tnow?=
 =?utf-8?B?YlJKbE1TdzNOU3FzZERrT1hPY1JKb2lrS3dnbmhGMGFoVktwNHdzV2lvbzBC?=
 =?utf-8?B?RmNheitlM2p6RjlCVC84K3A2c3FDYnJ3S3lCSVR0VThFZXI1MTlOVHRmeVRw?=
 =?utf-8?B?YWhvQmh5VWN2SFlkY1o0Z3hUWUxlcnVSUlpCNndCT2pGTThKbXR0UGZhYnNv?=
 =?utf-8?B?YWRPN3BnT0dzNHkramN2ZFlTeHV1Y040MWJpSDY3YWFwaTR2d2NNVHdzb1My?=
 =?utf-8?B?d0Q4Q1FhSVVMTGxlcHlOUmhRamhrK2ZhQjVPc2hhWDhMdE9KeTZidU4zWUJ0?=
 =?utf-8?B?N2xIK05xWlRDS242ZWhPQ3NLdkJqUS85bC9qM21JVjl4T0ZKaXV6MlZaT3FY?=
 =?utf-8?B?aGkzcEZMQWtxRWdNOXppRDJENHB4UnBSWFh1anE0b3FOcGZHUisySmxxbzFz?=
 =?utf-8?B?Sm9zRHBHU2dkcE1INEpkTkVBZTloT3V3T1V2VTlhMGpvcFFjaHY2Z0hhb21z?=
 =?utf-8?B?ejh6SjllaFN5aGg2cjNUMWduQVJmYlgweVRFK2J1Z1o1c1ZvcmhqRXlVNWNp?=
 =?utf-8?B?aEV6RFdxTytKVlRsM0luZHFDenJPQ2I2ZXFIYTlxYlR1MTY1eENLZ2lPaHJN?=
 =?utf-8?B?eldhR1NBWUp4YVRTN0liZFlIUmIwV3VBWEZsd3pVMnNpSmxVc2V2Zz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c283558-237b-4849-4df8-08df3b56de0e
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 16:07:19.0301
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VE6yqTHxXdOWYZU4i2VhWZdVwMP+RjM27xdcV2iYXbSNW95rf8CoY6ikIBx1ncITYAFM3hz+FEYqqzOLFxX5lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8804

On 10/29/26 11:21 PM, Richard Cheng wrote:
>> +		end = base - 1;
>> +
> What about making "end = base - 1" the default value of "end" and then call
> "check_add_overflow()", this would preserve the same behavior while elimate one branch.
> 
> Just I think we can add some comments describing it's for the case of zero-size HDM.
> 
> Best regards,
> Richard Cheng.


Thanks, I applied this in v17. The end defaults to base - 1, with a
comment that it covers a zero-size HDM decoder, and check_add_overflow()
now runs only for a non-zero size. I kept your Reviewed-by.

-- 
Regards,
Srirangan

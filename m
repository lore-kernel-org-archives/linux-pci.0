Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.28
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793903111;
	b=kL1Oouk45NCVPqiWLJrKaDzoWd3DYpt3PXsI1WuR7sw11YUPHNfXzWDxzsGIeH/bEKD4
	 OJbgWTJ2F0JJ/KPoUoqxz2NEBko8ILq5VRuwdKNCq0PT/lSoLcHaiYfamNNvEdz6DNBhT
	 d0dBWqPtbeTCHqxjHe2cS7MecJIHj/bLhtNB3iJ/VLj33zhnO2UWB00T1Fdo5w9aGU8x5
	 XeBY03DtfnIb6SGZ/jvVU2xLT9Tu/gDaYmoQV4TS1R1PtvbXiDQSDiDjRKO+ojzOuNwbp
	 o92mIBB2djYFZfiqbk9VjZHVNnPHeCWKMoP8SBFsA28DQzJDWfHkdWOlbrJVla7K9NQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793903111;
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
	bh=ZEA2DTtadowjkxYcfut9XEi9b15Ly/KJBBywlNAdT/M=;
	b=dZ9jTp5hBFs5Wd19QzuNVagjqUpud5gRgXyV62Uw2EM685TM6/l7GCxvvUbARLUdClea
	 Eu6HYSR5nukC5qypiQspSHQZNvF2IcrR71GfK4WnnKiALsYEXjRq4Hhr8x7NAkPV6NjGE
	 y/ripsax4AzLEGq8dFdurjWRUu20dgn1B7IH0Khk3bqQEwlN5qEZ9n1yK9yPziWI/RH30
	 2Y6UZvHCnwzHBYEX1LkABeG6/pDLd85elaz3Z4HxVTNwlSpuzvE3Xqc8fboJIxj7FdtK9
	 RnJZXl77VK2fWAGOXJrlLFK4QZVDLSjXejU4/qXQqgk+YBalYGSwVsh2h/RDW0SaGhg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ld5PB0tw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.28
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012028.outbound.protection.outlook.com [52.101.48.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092EC606A326;
	Thu,  5 Nov 2026 18:25:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 092EC606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ld5PB0tw
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GgfqT3A6uMWwS+47nZcBVZnTcUI8Od7GfQUB6LhwH3lY/7T/hTj7UjiH9XmikZ/TOqt6fasRkYxJFScIWXNTwYjKJC/2MMQ+f6KYmRsQfTvdBU4Z7tsoQytxReyVMRYX6qX9EwY1VPD+fu5mWd0BF644csd8c2f4yzs/NXz/N17Uriltw1881M0JRFADtmITwGZIWRlPpXdWlX/8/hk6CMbK4yQ9u38a3iFARRKW7+sxz9v4ft0+32gFHdE8N8fycAYVBg+PatmLDvTyWZXmA1sZ63YFJGFQ4ptIaov+Xibg8u8kwg7LurVcDZTiqUeVTtKdoxxXv6Y3UlnJGV7GZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZEA2DTtadowjkxYcfut9XEi9b15Ly/KJBBywlNAdT/M=;
 b=GRd1Gl6ofdCccUPEjl04wUXtDGDwn2SJ76f5hK2rvl/ol5/1c5zNTybAHUuFGqpMDM5EP9K41mvttWK6LQyt3BcIyNw7PaC2cd+jMJrlnZyH5Vv1zMeWaO/gFCs2UX4Fko6N7AlGAyWpxdOc6G+1py1QXa1A8dA2NA3FVR206SBfGQYdYM1ucPl7+U5bQFBLjr8J43o5m4/nbHA0IImkKJyAWdTKh4Cjxgh9aWHWI3JnTf1ys+57OOCWDFXyi1K8t/OlY3xn3Ak5Ogs0A21Lca7gwlNUyUiaWdmN5gd6+BjNM90n7+cK1y1XkHPuQaSsI+d0gdAEQrG32to2DCiidA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZEA2DTtadowjkxYcfut9XEi9b15Ly/KJBBywlNAdT/M=;
 b=ld5PB0twds1bTGzoORGINqZG8CbA9D6kmS/5Yo+nrAAnurZXWMboX0SR/58P5eSAXf/PqxWvMrWCJik2nI8Xh0Lj5F8shoDKgxAK1nsx7mS9JpFpMAKQoc884e8HkS6dxiyRdjfvAzsOoKnMoWRWLMugwTt85dH4N8ZyykKMQlQ=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CHAPR12MB999249.namprd12.prod.outlook.com
 (2603:10b6:610:300::24) by MN2PR12MB4046.namprd12.prod.outlook.com
 (2603:10b6:208:1da::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 18:25:08 +0000
Received: from CHAPR12MB999249.namprd12.prod.outlook.com
 ([fe80::1cfd:535b:cec6:5077]) by CHAPR12MB999249.namprd12.prod.outlook.com
 ([fe80::1cfd:535b:cec6:5077%4]) with mapi id 15.21.0592.007; Thu, 5 Nov 2026
 18:25:08 +0000
Message-ID: <86e44623-7c4c-49f5-9bc4-3aaa15f26408@amd.com>
Date: Thu, 5 Nov 2026 12:25:04 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/25] PCI: Add SNIA SDXI accelerator sub-class
To: Frank Li <Frank.li@oss.nxp.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, David Rientjes <rientjes@google.com>,
 John.Kariuki@amd.com, Jonathan Cameron <jic23@kernel.org>,
 Kinsey Ho <kinseyho@google.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 PradeepVineshReddy.Kodamati@amd.com, Shivank Garg <shivankg@amd.com>,
 Stephen Bates <Stephen.Bates@amd.com>, Tycho Andersen <tycho@kernel.org>,
 Wei Huang <wei.huang2@amd.com>, Wei Xu <weixugc@google.com>,
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20261103-sdxi-base-v4-0-3668ccc7aab8@amd.com>
 <20261103-sdxi-base-v4-1-3668ccc7aab8@amd.com> <auzGnNOril-cAyRw@SMW015318>
Content-Language: en-US
From: "Lynch, Nathan" <nathan.lynch@amd.com>
In-Reply-To: <auzGnNOril-cAyRw@SMW015318>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR12CA0007.namprd12.prod.outlook.com
 (2603:10b6:806:6f::12) To CHAPR12MB999249.namprd12.prod.outlook.com
 (2603:10b6:610:300::24)
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
X-MS-TrafficTypeDiagnostic: CHAPR12MB999249:EE_|MN2PR12MB4046:EE_
X-MS-Office365-Filtering-Correlation-Id: ef7d61a8-168c-4861-c9db-08df3b6a1f0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|23010399003|11063799006|4143699003|261026140227099003|56012099006|261009223027099003|261022105027099003|261026121527099003|261028144727099003|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	6N6nWTdcmnZiR9ld61cK/3xoD7LvEh2dsFUJQcyMdaKqW6SyfNiL+NMT2NTd/podVsapP6S0UILP68/6Q0K0hp8Yiz5pqZvqchgcSFEsBejHH2kvfWcAu3eYgs4KgWGNYo6N2sXiSi1byz6IOKXWByeB4jb8fR6HUmflLTBBOAIRtuIQAFadyaCJUSeWVBpQtZsh7bVNQCJTTbO5Mz7FupDgNSMQm1r1Bs18/DbkU2ug3fxlXViWkrUolp8Wru2UZAsZWXGvGxBGHmZiLBWpaMB9QGHJtPJia5h1d6exyigNh/WvP3hCLZCliJ7Txxgmlqn47MYIWJEH1ahyfMrW2cGwSczz9Koe6mE8d+Hg8ItUQwx39CV8CdM/Y2cQNSaAJvrSEfIadKytI9/jnVdypHbLJ3p1rZJNoJTdW2yEO7TqLdpwdMHwVhXVcc13hQTBJJE9EXT+NtWFvnII0K5//B/k0q8hwgUWFnn0nIk12tcMU+bcdFVRbMh3LjweylKRFlhmbXArcU8//ORW4Sfp06MRhK1ko/Gp7XdWyp2YEr9Dl6CnEloHhUAfsjoH3Mo8b3A+l/MQYWX7t3lXImbnR3GF8N6sjX0MY57wJko3AWn87l76iT2srz1ltOBpAfJrDNjK1VY2YgqDAgE+mHnVi+Byup/oSJRjlcBTwY+B3Fs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHAPR12MB999249.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(11063799006)(4143699003)(261026140227099003)(56012099006)(261009223027099003)(261022105027099003)(261026121527099003)(261028144727099003)(18002099003)(22082099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RUc1djVldWdycVk3MXBUVG9XR215c0FMcVRVWVBYSWthbU5EbFE4RUpQUU5W?=
 =?utf-8?B?aEpEc3RkOFpJamtRcy9uL3QyN0l0S2JSYkh0TG01WVVXWHVIUEJQMVlNVFZi?=
 =?utf-8?B?allIbmF2WXlKL3V1dzBuSUVRVU90Mis5cnovZi9ITmhlQmhDSUZWUTZtNmRp?=
 =?utf-8?B?YUNZU1FSQ1RXOWdUNmhYNHc1MUNIZHlwU3AxN05NMzNUcjBEa1hlc2FIK09U?=
 =?utf-8?B?V3F0VElKR2lEeTc5OThkUTcyc0lUZXZ2TlNZbUR4VjJ5a1htcUJJSlV6ZlpT?=
 =?utf-8?B?U2VYZERodGVscW82Z0lCNU4yZnhNei9tZmo5cDMvRE5VWEdZWm9Zd3Z6MlBy?=
 =?utf-8?B?YmRvVkplb2FOSTVnWE0xdGF6Vnc2YjBrdElKSDh0dWpZN1hqRnFmWU9pZzZQ?=
 =?utf-8?B?NHVXdTI5ZVZLMk10OUVHUHBOSUoxUWp0QVcyZFVINExtNWFDd0E5SkkyRnF1?=
 =?utf-8?B?a1BCSXNJQ0NpSUNLWW9Db21wc00yV2RFQlBoNDg0UDBFZXZvZXIzUEFRNWdU?=
 =?utf-8?B?MVZJcjJCUFdReGRpd1JVUmJpUEswck84amFpeE40SmdnWUtNYjlGZ2lKUWxW?=
 =?utf-8?B?ckIraXE0eDd2cTM2cmxaWnptSjlMaXNSa0xkU2E0YzM4MU5WSzcxZ1hVMXZi?=
 =?utf-8?B?Vk43U0hxVTU5eU53UnBkSDlOYUdTY1F3RC9SeW0zOHRBUXB0M1dVYWF4elln?=
 =?utf-8?B?WnZDNW51QVFYNkdJK1BDdzVOanRGblM2R3JmeFd1S1BuRkxUN3VzVGxpVHh0?=
 =?utf-8?B?VjV6QnI5ZEtoTVQ3ZGZMMWpZUzh5YVFrakZCakV5V1I0OTEycWJPWlJpYkYw?=
 =?utf-8?B?Zy9WYkQraUZJd0k2Sm1iYXNUWGgvZ2xIUFRKM1VpYmxZMEZnU3VxNHBnOHZL?=
 =?utf-8?B?L2o5aDVIWi85bFZ3VDE2U3U0M05JRDlUdVhMMkFsQzRXUW44SXc4MmRjVkRh?=
 =?utf-8?B?UUFkdEg5TEkvZjF1YzJ6cDh1aEx5dzhhd1dKbXZHYUoveWNnZGtmSkpRQlNZ?=
 =?utf-8?B?S2FYVW15dGp1ZjhuLzNPMW5IOTBHRzU2SHF0bitKd05KVkh3TkFEaGQzV0w4?=
 =?utf-8?B?T2NBTHBmbTJnQmlKYk11YWc0VDY4MEo0MGdHL3JyVStOY1YzSW5RQzlCc1Zr?=
 =?utf-8?B?TXRhWHV6azhyNkxKdjlCclhDcmd0dzZNb0tCUk1UTTkvNWRDYkFBSndTbDkr?=
 =?utf-8?B?UnBwY21lanpNcGx4QzMvN1BOMWFoTlhabVFYeFNRb2tkSG5UTGhFblg3UkZS?=
 =?utf-8?B?aUxpVHZTcTN2OHNYWFhkemtYZU11bWl1UzNkRFZzNVdQRGlOZlB2WUVEY240?=
 =?utf-8?B?RFduQlJjU0hKUFFyQjNINnNMTTRicGFxOFlRZHJsWGRDd1pIYlIxaWx3Zjli?=
 =?utf-8?B?bFJyTFoyVDMzbjZOdTBDS3dZVmFVQ0VjZWZSV0tteXJPRWYwY2R1amVva1Qw?=
 =?utf-8?B?QVRHSllTdXFGTytmN0pUcE8xZ1dlQ0htQzROYW4wMkhTaUNwVmlVOStpb1h1?=
 =?utf-8?B?NzArbTBDTmc2OThabENpamxQeEt0U0EvQ1NxeFRvSWdlS2psNEk4cm9LK2c0?=
 =?utf-8?B?YXRNN1VVM3FoMUQ1QWFwNkFGNCt1OTBiKzlGV1VFZENZVHByS0FsbDRKWHls?=
 =?utf-8?B?MGkvS2tQalhKNlprL09OakxMdjA3Y3djZkJzclVrMEM1R2NBME9qdnBJRmVw?=
 =?utf-8?B?cEw3WG0rTXd2Szc1VFNkd1M2ZEpvNmlkQ1FvME5LZi82Z0cxZ09xVzAzMHNx?=
 =?utf-8?B?MENCQVcwOW5XV05wRDhDTGRxK1d4dUdCWmNRc3QwWlROTVAwM1QyUWVUZnpl?=
 =?utf-8?B?TWQ2dFVqRXg3UTBIcDFicFhRdmN0Y3NRSi9PYWdCcmNJSFU1dlVaR0hvVjly?=
 =?utf-8?B?TWhwRVU1S1ZRM0FJaU9CZnA2YmdNODRVaWVxNENPMzVjaDdSeVpYWjBZemtt?=
 =?utf-8?B?WkdKZlQ1WXRpbnVaQ3BtNWtZWURNd1dHanNjUjRmSjBRVE9RYi96b1A0QVFa?=
 =?utf-8?B?d3ZIYlJTVHd5WERqc0FFUmRSaU9pdWJiVkpOSXJVTm1XcTczd1AyRTBZcTVm?=
 =?utf-8?B?K1pBS2xJSytwWWJSbHR3ekcrVGdVcmNpOXhDU2NZTzc3aXhDVHVnNk1MZEFW?=
 =?utf-8?B?NnpyOGI2VXN5K0pJbHZzSklvdkI0VGVNTzVpZldIa0E5QVJPMUhEcm45VmUz?=
 =?utf-8?B?ZmpUSS8vamxRZngza29BdHl4TkJxSnoxT3pKQ0pHM1pBc0kzdFJ3MHoybFMw?=
 =?utf-8?B?NkJGR3Q2NXA3eXdiZWRDS0JxU1FGQXFLWGUwZzFMZm5MYmQzaFUxLzVodk10?=
 =?utf-8?Q?mnlkarvtzECqA2UKKp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef7d61a8-168c-4861-c9db-08df3b6a1f0f
X-MS-Exchange-CrossTenant-AuthSource: CHAPR12MB999249.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 18:25:08.4717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5NMs06/LBh3r5M92Cb8yx6oBhoRlhKPz1Fy4ztEGHUL1bO+E0BQ5hhOr/2/+Ij5BIK6vmkj2i/NThJxgAK1sKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4046

On 11/5/2026 12:10 PM, Frank Li wrote:
>> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
>> index 030c86dd6d67..dcb26f52b5a1 100644
>> --- a/include/linux/pci_ids.h
>> +++ b/include/linux/pci_ids.h
>> @@ -154,6 +154,7 @@
>>
>>  #define PCI_BASE_CLASS_ACCELERATOR   0x12
>>  #define PCI_CLASS_ACCELERATOR_PROCESSING     0x1200
>> +#define PCI_CLASS_ACCELERATOR_SDXI           0x120100
> 
> Does it use for differecne drivers? I remember PCI maintainer require
> Only add new item when more than one driver use it.

Oh I wasn't aware. There may be a vfio driver in the future, but I could
keep this definition internal to this driver until then.


Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.24
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793902061;
	b=F5qQN6lV1pbKp+0ikxsxcXIwcIGLLUpyZ/3oQm/f20p2ABgggF/sB+N7Awwc4bYzcCEn
	 qlKohjuMZUMjApFFA8lXYoQXE2k61sP72AE05QibZ9xnYfL1qqSCDHUUpLaIk7ZW5qI8W
	 tNULExNT8OEeDdgfsCMaHy7W5SzvjGGdpCzzFxVG0EF/TRHsqXBQXUGsZxk4iqkp4gTqR
	 qcb7diXbP/v1uESmH6qx1VeMs07CpCgQfbh6wrIawgwH28dt2+YGc2N/CEESvKCTwu76L
	 h6UV9lCXEfeeVdskbO26JJGUqL6QnfaSrHHEKnKt56NT+FQn/+C7k7UBTAX53opmdGQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793902061;
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
	bh=uH2LZXcgn0zkz5za7QuyXZWnBq8jmgc7nPqTl5IDYbM=;
	b=ijhTldY1vXdTm0oLbcTSTA0ifgM6gkRzM8do5sjV8b0M8iIHFIv44NL5JoJ7ujahP3UM
	 2xk98cyzeqmmFXiwBSx/sCpHGl5fld9K4Mjsfq0hHdSkEShcCGJBCm107G40G7zIM7JrL
	 1GvEFLFaSExWO0cy7Yr2wbDZ4O4URqs8RP7Sh+jtUx7ibpXNNimR5cDyES2NAJcboAang
	 jAEZMG5ThNFDdn7YcOwNwQRZE4WM2vRidJTEfLsww6DF8QDrxKca+YEGboBWO/1MP5vM2
	 i7Uiy/r6QVwg3l0IrcWFzsH8AtYZAreieGQnEFIDkyILEaLnODppRYCj0P++px52eRg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=5hpDYQm3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.24
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013024.outbound.protection.outlook.com [40.107.201.24])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DED606A328;
	Thu,  5 Nov 2026 18:07:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87DED606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=5hpDYQm3
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=edKmE/K2iVRYeiMISE0VToL+UbZvQmsBFB6YcuYJTka386VTNlL9rE5VjExyIFoLRKr05TcH/kHT8at1bMHdyyeHCUgmgRivIGWag2CEyll9z3nHxi8y/ulvri3UiJOCF7HdqHimJ8ZYjrHD1VGXAqgN1lNXeBqLzHTRVKz/cRWM0z4MKJJZJEpFho4RLqjiruYpQfusTvNGv0I+b6W8SX/t8EG+Cm4i/HED73yp2H7NBXmPzB+uVGQ0d89BfzbVRWgJ5tjfgSy/OuNUFY1VB2wOpkBAh7MHC5APBgLRobtX+mB6MZLJH9l4X/+1E2I1/rZXuVV3rHkHxM8sHKxjfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uH2LZXcgn0zkz5za7QuyXZWnBq8jmgc7nPqTl5IDYbM=;
 b=YQE8Zuq7mb8vYa7IK19zN/KoHcb2Eao5l/UnH/kHCKzvUX7kQMhfUZr5vwKzQsWdhQNnHUqOiTvlhkPhsT3cqiIxsnuorsTbKApWa9OEATREMzEfxuXvZtf0Aj6v0IusXgyRXCLA4YBwzm/i5Le5xThzz5TpG84VInbLljcdx2jcGcylOF2jYr6D6S2OU+dKoAcLhc3NMEl6jP6p8RcPYgSphWzrqYUU6S2+N+7E2oJRbduYbY9V99buONeAtMzxyLRixzdf/pfm740w9+6HxZbxOXGtSwmDMBUzZcmsL3FwiNAEoZgtmPLrKXcKbCLx/SgbYxc4eFfrZFjA11OAGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uH2LZXcgn0zkz5za7QuyXZWnBq8jmgc7nPqTl5IDYbM=;
 b=5hpDYQm3DXGpEQQmUKH2Nc626Big4qlKw88woyjvg4IW3lNa+qFH7rZ1yHhs+bzXASrwbvJFUbk3wiZ+ujTwAn6ITPxrDl+uCjW4zexOLMnorvvUUSBhsq/aC+KzNjdYk582uEhf34q1KvJBpJkoI8IpEQsc8fvGuVyRAY/qLIc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CHAPR12MB999249.namprd12.prod.outlook.com
 (2603:10b6:610:300::24) by SA9PR12MB407125.namprd12.prod.outlook.com
 (2603:10b6:806:a6::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 18:07:38 +0000
Received: from CHAPR12MB999249.namprd12.prod.outlook.com
 ([fe80::1cfd:535b:cec6:5077]) by CHAPR12MB999249.namprd12.prod.outlook.com
 ([fe80::1cfd:535b:cec6:5077%4]) with mapi id 15.21.0592.007; Thu, 5 Nov 2026
 18:07:37 +0000
Message-ID: <78cfd4b1-4b0d-4472-9ab0-fd8c134577f7@amd.com>
Date: Thu, 5 Nov 2026 12:07:13 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/25] dmaengine: sdxi: Add PCI initialization
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
 <20261103-sdxi-base-v4-3-3668ccc7aab8@amd.com> <auzEG0jcbuzxTG_Q@SMW015318>
Content-Language: en-US
From: "Lynch, Nathan" <nathan.lynch@amd.com>
In-Reply-To: <auzEG0jcbuzxTG_Q@SMW015318>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8P221CA0018.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:2d8::19) To CHAPR12MB999249.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: CHAPR12MB999249:EE_|SA9PR12MB407125:EE_
X-MS-Office365-Filtering-Correlation-Id: e6129ae0-c159-4b6f-11a0-08df3b67acb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|366016|56012099006|4143699003|11063799006|261009223027099003|261026121527099003|261022105027099003|261102123227099003|261021121427099003|261026140227099003|261028144727099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	OrxmUlINVsN3qSRfvG733E1BatXrwXOwC7b8qUaW+DFBD/NyJvJfY9rUiHw0PWiPMUYAQkcnQcHWs3Ug58xdpYWEnASxc3A0A0eHE95wIPl9ZORmEyA5Xf/GFhdeUwaPo6vizxo/RZgwryJrG7uy2KYk5d1VGRSgqNhAYD7Cae6esSPlQrGVnn5pWHkTOampX17E5SDBbXJkIAsyrow6jvOwd3H4CYUf5TUxj5c85Ib4BfixmUZQRHYXrgEMYipjRb3RBk0H2F5ixDtidzXDdw0/w6b6NhjID4cuMtBht2MIilOQqyiTxAvb1HV5ChLVsqslk2jSs/ymnbMssVcuItqVvzJT+XP+z4R0l4xDQUIfyy+LURO8WkgzJ5KMxp4Ovs6tn+/2SEpYNd5N5NWjF5PkuzEzgQFGI0JiUKdubxvJ8ovZGU315HQJAVu2dPlysZGwYOemEZJv3+M0oBKtQ0+fUA76e7dgB22J8/sQdYHKRyouShhg18q1a9ACr8OrmI7IEWZ7v52tyCQ5mT5hEcp/yNmmQFwgqGSOO+0vqDdwpT3k5dMJhEasWF7jeeQAv6G84q+QdDkexIzD4RdA62ViwkweI0dzJjJ4mhD+8N7ktsKfPkQKaXJb2DZi0AlMXKp4tnJCez2vP2ALf+NPOIb2SpJNkrz1lvkLdcWbnn0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHAPR12MB999249.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(56012099006)(4143699003)(11063799006)(261009223027099003)(261026121527099003)(261022105027099003)(261102123227099003)(261021121427099003)(261026140227099003)(261028144727099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cCtJWGYwTDZlLzd6TEJlVW5zcWpxSm9JemxiQ0xJazF5TkFFRVRDWHIreXhz?=
 =?utf-8?B?QXpRQ3MyYVA4Wi9vZ0QrOHBzMXdaY0NVQUswSXhZREpSVFA1WDR3WmQ0dDZ3?=
 =?utf-8?B?WWc5WmU3b3c1SFFXSzNRT3FBUDVtOVdSYnFQdFExMkFBdTBTL2NQczRjZWU1?=
 =?utf-8?B?RUdNUGhnSjBBUmdMU1FQVFh3TFpWT2haaXgxSE1FVDUrOGZBakdIOHFaY1Fq?=
 =?utf-8?B?c0pOQTVWSCtTVk81YmQvTU1XVlgxcTJEcmN4RnRYZUZjSlA0aFc3YnFNWDJo?=
 =?utf-8?B?Tmo4K1g2MTkzQzhSa21OTHVmRVgxUDJDbjBMRzNhS2pmVU85SGR1YU1XeVJS?=
 =?utf-8?B?TTI5NHZwREZZa2ZPbW8xSTBCQzdYYldHMFMzSVhsdUR6eHdKZEpIcGhrNzd6?=
 =?utf-8?B?dWVXTG10U0x4TnpmVXdPV2ZDdFAzTkFETzV0VEo2d0JndVUyY0ZWa3YwNVpP?=
 =?utf-8?B?T1k4TkswaHVaOVdFZm9rOW5sMEhyQVB0RHlsUG5uRmo5L3ZGTmdjL1F4NzFp?=
 =?utf-8?B?ZS9WeXFXSnQ4RnFENzRtVE1sZnd3WS9PTW9QTGRLTllraUNpdFpjSTBsYUhu?=
 =?utf-8?B?U0VDdERFNFJYOGxYQ1A5Y2Y2ZzBYbVNUMG9iTXYyN2padTg5WEp4TDJHSmNQ?=
 =?utf-8?B?NytzMzc1WFhtTXZVUG9GT3QvNU1ZbTZoSElDRjFzTHNNUVlYYnpmK1QrSnU4?=
 =?utf-8?B?c0E3TlcrUVBqMzc0d09lUEpWdU9VUHlVSEtydDBrZUZWZ29heG9DYWxxdlpB?=
 =?utf-8?B?U2FEaDJJVjVWOGR0Ym5uUEo4U0VCMXFSYmtzRi85T3d1ZnN1OG1vUlEzbUhh?=
 =?utf-8?B?SmlUN0J1dzl5SGlWVTRGUmRjbEdnQWdhcW9jblNSV3V1eTFNTWZjdHBnanMw?=
 =?utf-8?B?OXNoZms0VEI0dElCSTdsSHVvS2hZRFdaWHlVTDFOS2dUQ2drY1NtNHpobjV0?=
 =?utf-8?B?KzdvcDU5aEFsLzJHQmw1L2dvM2Fpc1RhQytKbHFxemdESkVnRzh2U05LbzVN?=
 =?utf-8?B?Tnl1T3Q4TzUwRkVWUGEvam1JKzRzcEJqRW1tRjJHck1HbzRRem1TNjVCeklG?=
 =?utf-8?B?UGx1SkVHRHJmN0o4NnMxakVJekthRHJyN0tOQjRkNXl2UWJQVlNLaHlGRHRF?=
 =?utf-8?B?eXlJa24xVEVVZXkzL21FZ3RTNXBOME56YUFTdUd3akVHdEE4TmE4dXA1M3VW?=
 =?utf-8?B?TGtvcG92bFM4OXpDWkNpVGF3eVErd3RvTmYyQnp4QmZzQXdYY0tNcXhvYkM4?=
 =?utf-8?B?U3kwS2hiYmpzeHZ4YzlUbThXcndWR3FMNmFRc1ZHS3NXcDlhY3BmTE9RUjJn?=
 =?utf-8?B?MWI0U2VBdHFOMThNOE1CYS9OVzlJTy9oa2lsb0RyTk9NTnFvZ0RvbVU5d3FL?=
 =?utf-8?B?Y0h6YmVGZUJjTGNxRnRoNTFvR3o4ek1Md2I0ZjVLcTdkMkxVUnZrRnRyN1hz?=
 =?utf-8?B?Qmhid0hJcVNDS2pKcjY5SXYrNlE2VDZmdjh1NVlMRmpOTFNzaktWMXFlWXhB?=
 =?utf-8?B?ZkxWblpTUXl3SzlLZ3llN1graldpVXV1aG8rVm53K05kVFd2aVFTUjBuVFJn?=
 =?utf-8?B?cTZ1N2czVGVKSXRUUWdjOXhneStNdnFwWVZ3dXlDR3ZTN0M3M2xrY2o0ZHVD?=
 =?utf-8?B?UWswUVVmMHZ2RWdZRWIxTjBDRjdRKzhMUzhoYVRhRlkrdkpJRDJiZWJhM2hv?=
 =?utf-8?B?OWxMZGIraUVGWmVoYjdLNXhySXhxK1lMbEZwY0R3Q3ppSFRzN1cvQThKYzZM?=
 =?utf-8?B?dmEzd25sQ2ZHOHJZVW1JREI0a1FzMjUrT24raHpIZk84KzFycEpvZjA0NXRt?=
 =?utf-8?B?SWlNaUpqTkFIK1lidkI3ZFhDc0lQd2FWaEtEWVZacGl5NWEwd1BlZ1JVQUJD?=
 =?utf-8?B?dWNLMXp3dlRUM2dQRWdWRGM5VHR6ZFhZNGxEQ2FRR1pqTXBMUlhLNWdtZHpj?=
 =?utf-8?B?V3ZnTUlMeFpqRExDSGVWVmdSMWFxc0wxY3dHOXZBMFJXTG5vUTc5RHNnMmw0?=
 =?utf-8?B?eTdWRDVQdlowcTRHWGplOWdvdlBJVXMxbXUwV3lQQis5NXVzRk45NDQwRFc5?=
 =?utf-8?B?N0cva21ocURuL20yWERGazNydEtYajZLODBERkpKR2owUDVzenBrTVQ1Z2JC?=
 =?utf-8?B?WU9QSHdFa01lNm9VNE5GWHNUNHJGUTJ0cStlYWJ1VmorOUlRZnNwVDNnUTQv?=
 =?utf-8?B?UFhUdy8zbU1LOUdRbmY2cVduL2NRcXE1WTd3eSszY2llN0Vpd2Z5czliSTlW?=
 =?utf-8?B?U1lwMHRySmpDSE83SXJyZzB3M2x4MmUyZDFOWUxIbzVyVDFoVnIvS2h0Q3Fx?=
 =?utf-8?Q?0ruNOVI+YfBTCp+hFF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6129ae0-c159-4b6f-11a0-08df3b67acb6
X-MS-Exchange-CrossTenant-AuthSource: CHAPR12MB999249.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 18:07:37.6267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yDBRURLPI7X/0D1SvjygGpURZ7ISh0XQLwVYHW5bO95Y+CoCV6cuNvK4hWRLHbb0dtA23NZebzkBZehtSKvpRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA9PR12MB407125

On 11/5/2026 11:59 AM, Frank Li wrote:
>> diff --git a/drivers/dma/sdxi/Kconfig b/drivers/dma/sdxi/Kconfig
>> new file mode 100644
>> index 000000000000..b91b44231a04
>> --- /dev/null
>> +++ b/drivers/dma/sdxi/Kconfig
>> @@ -0,0 +1,28 @@
>> +config SDXI_CORE
>> +     tristate "SDXI (Smart Data Accelerator Interface) support"
>> +     # Doorbell updates require naturally-aligned 64-bit writes, per
>> +     # SDXI 1.0 9 MMIO Control Registers.
> 
> why comments here? is it related config ?

Yes, it's intended as an explanation for the 64BIT dependency.

> 
>> +     depends on 64BIT
>> +     select DMA_ENGINE
>> +     help
>> +       Enable support for Smart Data Accelerator Interface (SDXI)
>> +       Platform Data Mover devices. SDXI is a vendor-neutral
>> +       standard for a memory-to-memory data mover and acceleration
>> +       interface.

...

>> +static int sdxi_pci_init(struct sdxi_dev *sdxi)
>> +{
>> +     struct pci_dev *pdev = sdxi_to_pci_dev(sdxi);
>> +     struct device *dev = &pdev->dev;
>> +     u64 cap1;
>> +     int ret;
>> +
>> +     ret = pcim_enable_device(pdev);
>> +     if (ret)
>> +             return dev_err_probe(dev, ret, "failed to enable device\n");
>> +
>> +     ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
>> +     if (ret)
>> +             return dev_err_probe(dev, ret, "failed to set DMA mask\n");
>> +
>> +     sdxi->ctrl_regs = pcim_iomap_region(pdev, SDXI_PCI_BAR_CTL_REGS,
>> +                                         KBUILD_MODNAME);
>> +     if (IS_ERR(sdxi->ctrl_regs))
>> +             return dev_err_probe(dev, PTR_ERR(sdxi->ctrl_regs),
>> +                                  "failed to map control registers\n");
>> +
>> +     cap1 = readq(sdxi->ctrl_regs + SDXI_MMIO_CAP1);
>> +     if (!FIELD_GET(SDXI_MMIO_CAP1_MMIO64, cap1))
>> +             return dev_err_probe(dev, -EOPNOTSUPP,
>> +                                  "64-bit atomic MMIO access required\n");
>> +
>> +     sdxi->dbs = pcim_iomap_region(pdev, SDXI_PCI_BAR_DOORBELL,
>> +                                   KBUILD_MODNAME);
>> +     if (IS_ERR(sdxi->dbs))
>> +             return dev_err_probe(dev, PTR_ERR(sdxi->dbs),
>> +                                  "failed to map doorbell region\n");
>> +
>> +     pci_set_master(pdev);
> 
> Add empty line here.

OK.


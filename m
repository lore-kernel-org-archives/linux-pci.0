Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.61
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794582060;
	b=XPN6m8YaXkbucQPqpOTXodqvqw7AL81nwbODUUV9Q6s+mi8LPh4iqE2YNeFeOczda7zy
	 pYmqcfDMOAUCvs2YFqQrUlzxjHOHic9dPylvYGgmhepq282SRz5s7ZRwto1YoqoBuM/iN
	 wJcVoisFsxuXswpb7Obz9voaN+B+Gd/iginkXAVPVH4oO6Y+UP6Pn+uXVSNrey/gzM4TE
	 fMtMoYd5y6TP7R+NfxOj38Oi2Ifzve64C0ijwaLU/ALt7qk21wad5+njRVeXFeSnByAgg
	 OUc6v+jezqMpu5eRBEsgaSAbn8NjpZKLTzYjTPhmiaGDGmg0GVc8dm/lUTllRG3dD8g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794582060;
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
	bh=oc1aEWhAuh4jZUejTMhjwN7S3C0dMy7JI5U6EM1JGog=;
	b=WEEfB2vFuYV5F2WDUcMDemOj8taKOinssFG1NXK/gSzHJXsGEAqzwiI6od9aFzY3seat
	 57PEMLd3p23jSRVmfmH293LXibTuw2BkJ9oKT5Y/ibdOrIWuKJxWFb/Sj/YWpPo9q8kLD
	 ma7p2urX1pYI3VGUwqmxrBLgrhpc+HYSg9EQbbwCRS5cL191m7SwrxJAPVBNa888jE8Mk
	 iazMt2fVm8aNtR/5AttVlvwUX+0sgggB4rOwe02AmRBFa6P/U0wupx+t2c+8+wHHKowzV
	 nJnXDJcQ0qr/7x9/0hxHHsWJv3URONDsfTWLMgi6jZ/rNy1rxk2VJsLZ9SQQD6FIVCA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=CPafSa+P;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.61
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010061.outbound.protection.outlook.com [52.101.46.61])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4675606A897;
	Fri, 13 Nov 2026 15:00:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4675606A897
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=CPafSa+P
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F5hqbrI8ImBbT9nzjU3mYPdR+7oYheOvFopt/2m6OfuAxi2+uuvRm3wTfNo/Xhy+rB0/DcH3f0fAiF+Y1gZf0yQFHZAOKdKqoda1t8toJLw0o3GQQS6VqX+BFGM9ErYO3zAI7rKf/wYIEgzcEx8wxvE9eNDdd579w0XD1MnQsg6I3ueZF1Lt/6TaFuirsL23DVUnB6RcxvnQ7iWACfqtjD18GWUHcGwkrTHBz20JZwP7mIzgSz7tu3OtObXMwtks0KpE9LUY8XlYTuc4i9V2WulCALjpdbEzCwNMoi4/ScivoIKkgXowHikwAEWH13K7IteXdGTVdtNoyWSGCIb3/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oc1aEWhAuh4jZUejTMhjwN7S3C0dMy7JI5U6EM1JGog=;
 b=icM8TvuRuSoS19rWv9qaJCvb5CxpevzfnadglXqOIYwZa7DCisi68xSMBhBwkuR1T5WQINNHIHE9i8Lp2AIxuCwkUhKJYnen78hhJz25DTN+kXL70g7tlP5ewdUbmpUDGJDtRjicklnVAoCef9qMpDP/LgJtCGNwIA6SbuzWMX255UpUjkW9p7u0tDj6a1XFt/xMmrFfEhpCo4BNhlhtnd0SGua90nZcxynSgnr/v4ZbfPBEQ1YvwWEiuKvq7UbCIJu/pRNol76AYG8hcGhsnflEwGSRbcZzqBwmwVh8yqMhCs1Fshx2uTLC+Q6kMDIWo6CUJgVuHHKD7cwEVCt7Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oc1aEWhAuh4jZUejTMhjwN7S3C0dMy7JI5U6EM1JGog=;
 b=CPafSa+PgmeRAiBCfLWz74MCPHbJHad/hOUG2g1sCvlEohHKhfMv+27diayHpX0Av6/Y9HCsSW/962w/jWcqiFL4CqWDFQATTRY8iTZdsullstpe1lkIMJqN4tMRa3fL93WZNY/ZjF/2B4UAEbps9vdPfQSLZZwz5oZAK47YQr8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by SN7PR12MB8169.namprd12.prod.outlook.com (2603:10b6:806:32f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Fri, 13 Nov
 2026 15:00:52 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%5]) with mapi id 15.21.0615.009; Fri, 13 Nov 2026
 15:00:51 +0000
Message-ID: <597f67ff-fd19-4ef6-a6fc-216a1198c463@amd.com>
Date: Fri, 13 Nov 2026 20:30:45 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/3] PCI: Cache bridge firmware secondary bus number
To: Mario Limonciello <mario.limonciello@amd.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Alex Deucher
 <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>
Cc: Oz Tiram <oz@shift-computing.de>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
References: <20261112-vfct-regression-v7-0-69b1e0cf45c2@amd.com>
 <20261112-vfct-regression-v7-1-69b1e0cf45c2@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20261112-vfct-regression-v7-1-69b1e0cf45c2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0115.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d0::15) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
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
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|SN7PR12MB8169:EE_
X-MS-Office365-Filtering-Correlation-Id: af7c1059-d8a9-4f4e-82fd-08df4196e8c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|261026140227099003|10067099003|4143699003|261021121427099003|56012099006|261021123027099003|261009223027099003|11063799006|261028144727099003|261022105027099003|261102123227099003|261026121527099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	KRtLk+UUQmvChB56/EVu58ahx0L7KYYWRpZi6OwSEXR5Ho1ZKTCJYsjVt6OCB7z0xxgtxtGniiIZESTsslDO9TcYES540Tbu2llM5qxbzuHOPATWIkZ61W5xvGkMzV/cuagAzqRcO5LONS6ENDkUPk+dr+kBagkMbDWiOy96GErta6/h4US5+p1JD+Q2QYVdxj/zPZ3YkiNIlVhbYyVSDD72oqAo95eymcPBqbEcHp1hdNj/YUrRMMqPMZc+EZ/L5iYUxlHUVW8TdvSpFSG2FROp8aaTe3lqghNynRbgbg7B5P90BvD71leeGE9u+R5bb/igmsV75bnNSehV3Gl4+3uWogBqBo2WrycSQjns6+hmx7xWXbzh+HzMSFr+q9uquysG76Z17fVPmr913M42qHhnQOMxTmGbBfyaRgAOdKDvJ+Tj9sHYkRgB7ajVp6ECRsfDnSdFlWk+5Ud8Q5Vb6d94gGKKjEOObspgkm83cQbUdGLRQ0tcvUefHNlLt8F3F/Fkd7+x6aDsdEZEJTIw+mKeOt0lnGgTUxgpXn1UFSaMWglSDJVqQcGe8yrKxjKA+GRnULKVXkNxfXEP4vAAmjCrIF1gGV1qeI707Lj5k+SwjxHXz8o6qL7R8JgWgJpL
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB7091.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(261026140227099003)(10067099003)(4143699003)(261021121427099003)(56012099006)(261021123027099003)(261009223027099003)(11063799006)(261028144727099003)(261022105027099003)(261102123227099003)(261026121527099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VkFMcHR5b3FxUngyNVAxbWQyaVozcFpRZVdxR0FuZ3Nlcm1PTUdHckZkazFp?=
 =?utf-8?B?VHVZK1R4OC9YSzBOWGU4WlJYdmRGYzlHVzk3emNwd3ZWMnVDbXBTSFJMY3hz?=
 =?utf-8?B?U1Z5a2FIbTdMaFVEbHRCU0dDNzFna3hHTkNkMkFNa0o0a01JODYxTStxV1I5?=
 =?utf-8?B?NkY3YjVla3ZJem0xWk5aL0VRMDVDQ1ZkbDRtQ3RsUFJqcGRkMzMvZmxuMkpL?=
 =?utf-8?B?ZGxHUHpGNXJJMmc5MFJPbVNNVHVtT1ZTNGkxaXlzYWdsVW53WFJCOXdhaEdD?=
 =?utf-8?B?ME1IVlhjN29YaE9LVGlrencySDQwQ2RWQzNNcVphTWdFQnJxOWhUc3dubnZN?=
 =?utf-8?B?OGpqRkh0YU1lNXE3NTFsVFpWK0JBSU5YeEdPcE1wa0xQcmg1N0dVU2Nkbzgy?=
 =?utf-8?B?cnAwZTFmYXZLaDcwaklKMDhkMExhanluUFlENy9CU3FKcnNsZ21OcjdXcENR?=
 =?utf-8?B?Q3lPMDR4TXg1YjhFR3FZV0c3UWRHRVpvOG1FU0J2VUU5ckxUMWxWOHJIV0ht?=
 =?utf-8?B?aGFadVVZRWlrT0Y3OXhYSGV0SnlnV2kyNjFQemFhelVpemphVU9xWmdaMWNq?=
 =?utf-8?B?WEhDdWdOYU81dlY3a0FJbVVLK3hrNDRPU1N3M3dYZVBHdlEvSWxUQnhyTDds?=
 =?utf-8?B?TmhTeFplY2YrV3BaUUY5N2lsRGcyeC9DSEVteGlzSDREY1dLZDFjV2RqeU4x?=
 =?utf-8?B?amplV2I1cTNodkRRTVVlOHFvK1RINzdhQy94S1hVTVFianhBRSs0RDNlRHV5?=
 =?utf-8?B?N25zN2JldXBOWVlOcFU3d1lpeVF4YkRGbnhtV0RFai9MZ01ranBnRWhkK3Vi?=
 =?utf-8?B?QlA4TlM0ZVBhY0ZPSG1MclBIbzZhd1BDeWVVaG1kTkY0ZEgySVg2R3dqYTd1?=
 =?utf-8?B?eEFIeU02VlFXbWhIMnVzT1BMem95UWw4cDd5SHNXYnZJVUJnMXZNYytLaXk2?=
 =?utf-8?B?K2xGUDlzZms5SUo4eEw5T2FTc00veW9ZU251eEdOTzNnRWE4UnBBTHduRWN0?=
 =?utf-8?B?My9IV1IvK0hNZFEzMHpuYTlONjRGNVNYQ0t3aVE4dDV0OENMNnZiczQwR1dK?=
 =?utf-8?B?WU8wdmJQRHdZZzh2Y3ZYb0QxVUIxdHYrT0xPQXBud0FCQnRNR1hENi9vVWdX?=
 =?utf-8?B?dUFaSWNJb0IwT3JuQnlDb1U1VVNFRm1uclh2SFkzdDJ3RFJudlg5ck5NNlpx?=
 =?utf-8?B?TVdVbzBvU1lMMDd1MEpGNzVEUTNEbnlWdklicUsrSHR2VVpaQXlzK1ZzVnZT?=
 =?utf-8?B?NmN1cnNFWTViK0ZadzVkVC9CZmRMOGJFZHJWQThIWDhaQ0ZRa2pJSjAxaE5p?=
 =?utf-8?B?KzFhQUVPYStPcGkvVkZzd2FCNnVJUnA5YnRhN3o0OFJKTkFvTG1CTkE3MXBl?=
 =?utf-8?B?cU5OMkpJZHdQb1MxWnpMSnpjcTVvZWpucG5GRCtaMDdoeVdzVHlBWW03WkZO?=
 =?utf-8?B?UU9ld3d6dEt0V2VEa0dLcTcyNTYvU2QyM0IzMmhQdU1EMXlqWDZXK240QndR?=
 =?utf-8?B?OTMxWXI5aDdQSmUxMmRlL0JuWXAyYzZWRWtXaGpjb0c0YWhaTE9tcHliNmR5?=
 =?utf-8?B?Unpmd09kY09xaVJFYmJERkJ3aFhFRmZ5WU9PV1BIeFNUQUVPSWRoTWZBeW1G?=
 =?utf-8?B?TDdaVW5jMlpXRnNlV2IwblBxNWQxYytUWmI2MElaNjlBUllLUTd1bzVqeGxk?=
 =?utf-8?B?emlheWo4a0NvZndVM1dTVmdZOTR0aVVuY3FFM2lFUXRZV01GOFM1K3FlZmJV?=
 =?utf-8?B?dXArWnJ0NlA5bC9VZXBkVXhxVE9ZRFNjclJ3Y0hnUldGRS9ybFMxSmlSM0VS?=
 =?utf-8?B?cUxCTzE0YWxsOFlIOC9VOCsxWjlRU3hFV2hFNUk5cG4xNGxsa2tCL1cxRFFa?=
 =?utf-8?B?QmNybEw3T2NJY2thS2VqTnhyOHJNWDBVb3JYSjRQMTRlWU1tdVVuTCtGVjdx?=
 =?utf-8?B?LzI2UW1EVXZGSG4zZ1ZrWFoxRUJERlBnYjZHYktGdFlpcGN6bkQ1cHZnVFVP?=
 =?utf-8?B?ZXdPalJhZENnZlhqbHNmb1BUbW5GSWdaSHFZVkNsNnhwZXhqeGZPNzJNeEtD?=
 =?utf-8?B?UGI5UzJUSUkxYmt0bWlib3c0ODdWUlNJR01yVGdLNEE2SWE3b21zbkNyZzQ4?=
 =?utf-8?B?cWVKdnVWdkVjS1Q0MzNOQlFVUzNSTXVXS1FnajNlRGJwWCswWHVIdFJxTlJk?=
 =?utf-8?B?UTVuaHdtOVZpVkFPVHlpTmRIOG1Pdk5wVWpPTGJsMEEzM2tJa0JGeWFXNHNK?=
 =?utf-8?B?RjNnS0tzOWkyS01FWWdib1lhUDJTdXhGOTlOLzFSR1NjSVVzd21wczZiZzNi?=
 =?utf-8?Q?IAgW8B1BMS3ZOws/Wn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af7c1059-d8a9-4f4e-82fd-08df4196e8c0
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 15:00:51.8004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GQg7j8yit4oWucOLBgx3SQFd+pwYLFMJT9N7dsUq4szDijzznvHPiZLOtcFWui3h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8169



On 13-Nov-26 3:24 AM, Mario Limonciello wrote:
> Drivers such as amdgpu and radeon need the bus number firmware assigned
> to a device to match it against firmware tables like VFCT. The PCI core
> may renumber buses (e.g. with pci=realloc), after which the runtime
> number no longer reflects what firmware programmed.
> 
> Record the firmware secondary bus number on the bridge's struct pci_dev
> the first time pci_read_bridge_windows() reads the bridge's bus numbers,
> which happens before any renumbering. Devices behind the bridge can then
> retrieve the original bus number via their upstream bridge.
> 
> Only store the value if it is usable: ignore unconfigured (0) and 0xff
> secondaries. Use a separate "sampled" flag so that later rescans, which
> would read the renumbered runtime value, never overwrite the cached
> number, and a "valid" flag so users can tell whether anything was
> recorded.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/pci/probe.c | 16 ++++++++++++++--
>   include/linux/pci.h |  4 ++++
>   2 files changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 27008e2ea5afc..f20a4b8f7a23b 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -505,14 +505,26 @@ static void pci_read_bridge_mmio_pref(struct pci_dev *dev, struct resource *res,
>   static void pci_read_bridge_windows(struct pci_dev *bridge)
>   {
>   	u32 buses;
> +	u8 secondary;
> +	u8 subordinate;
>   	u16 io;
>   	u32 pmem, tmp;
>   	struct resource res;
>   
>   	pci_read_config_dword(bridge, PCI_PRIMARY_BUS, &buses);
>   	res.flags = IORESOURCE_BUS;
> -	res.start = FIELD_GET(PCI_SECONDARY_BUS_MASK, buses);
> -	res.end = FIELD_GET(PCI_SUBORDINATE_BUS_MASK, buses);
> +	secondary = FIELD_GET(PCI_SECONDARY_BUS_MASK, buses);
> +	subordinate = FIELD_GET(PCI_SUBORDINATE_BUS_MASK, buses);
> +	res.start = secondary;
> +	res.end = subordinate;
> +
> +	if (!bridge->fw_sec_bus_sampled) {
> +		bridge->fw_sec_bus_sampled = true;
> +		if (secondary > 0 && secondary < 0xff) {
> +			bridge->fw_sec_busnr = secondary;
> +			bridge->fw_sec_bus_valid = true;
> +		}
> +	}

I believe the original suggestion from Bjorn [1] to do this in 
pci_read_bridge_windows is to avoid these extra checks as it's one-time, 
and also to make sure it is done only for bridge devices.

[1] https://patchwork.freedesktop.org/patch/763534/

Thanks,
Lijo

>   	pci_info(bridge, "PCI bridge to %pR%s\n", &res,
>   		 bridge->transparent ? " (subtractive decode)" : "");
>   
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 5ffcf5ce8c966..045157488b8e7 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -363,6 +363,8 @@ struct pci_dev {
>   	struct pci_slot	*slot;		/* Physical slot this device is in */
>   
>   	unsigned int	devfn;		/* Encoded device & function index */
> +	/* Firmware secondary bus number saved across bridge scan passes */
> +	unsigned char	fw_sec_busnr;
>   	unsigned short	vendor;
>   	unsigned short	device;
>   	unsigned short	subsystem_vendor;
> @@ -414,6 +416,8 @@ struct pci_dev {
>   	unsigned int	pme_poll:1;	/* Poll device's PME status bit */
>   	unsigned int	pinned:1;	/* Whether this dev is pinned */
>   	unsigned int	config_rrs_sv:1; /* Config RRS software visibility */
> +	unsigned int	fw_sec_bus_valid:1; /* Firmware secondary bus number usable */
> +	unsigned int	fw_sec_bus_sampled:1; /* Firmware secondary bus number captured */
>   	unsigned int	imm_ready:1;	/* Supports Immediate Readiness */
>   	unsigned int	d1_support:1;	/* Low power state D1 is supported */
>   	unsigned int	d2_support:1;	/* Low power state D2 is supported */
> 


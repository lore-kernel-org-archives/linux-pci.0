Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793029877;
	b=fZ0yVUBcqnXjXyQ8P1JKhyS20NoJhTJxaODYgcqHIY75MhpZk1s7neWP3fVOLNRxiv9V
	 OZVvzsCNMoPs3/zjjhnoiPsdezWoNACWNurQdBRY9r54VUK2WdcxJ2pqPhStOPndc5fHq
	 qzCUtSRMKJKmWB9EEwafPso7AhEyZLzFlnI0H/c5x5b8jf/Yt6VUMPNgek6ao+imMFWRv
	 NkpQj4IrsPZd38gFDL1XCOQU58tG8PZrhkpqo9fZICMNnPDadUI7ZA3b/oKRu6ylD3w9y
	 2SLafUUc1w3056HtG7U3PQDGyYAmW1gEtKp8qT4uUTRzuQiNroJq77LsEPEy1IoGUoA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793029877;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:Content-Language:To:Cc:References:From:In-Reply-To:
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
	bh=KewUB/LTDdhliYuh5xtwwdl2uTZTVVSr/9GRMA2z844=;
	b=CK4dco+DLfuGHyl2A9s/mYpjPDkwqJfxD/z45qHmq7zoW/hAQ7epS1akNvRexakq7W5L
	 GrJwqw2G1Pj2eMswCOPpmuom2PVMQw0HYgz+Bfqe6ctEq6+4N+6g4OWMeZFMW5LGO9A2p
	 Ic9d3e2dpeN8O0aMwD5fHpKlUNaNSDIWLYJ2xzQ7QafYzNJ7fg0+NeCZUGlmqc9VXc3y1
	 4nFWmDIgsznUA3TQ9sI0ZgQswudV/h9g/2MhWGCYUxs9b6dAMCCSz3o+23//TvutoXjwA
	 NWR9RZ5k+k2Nh/PyiHuMPOh/fxrPH3Vbx7zSJTp2pFiVREW669rWUZHIm7JOqfwVwlQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ejjptGSn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.13
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013013.outbound.protection.outlook.com [40.107.201.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A8A606A31A;
	Mon, 26 Oct 2026 15:51:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80A8A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ejjptGSn
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jM7bHIvW1HZOaYcSKTZFAGUOronKY6aNn18bC7RRbnioJEDfBDIsWgaaMciYyyrN49+yk/y1O6vPC5HzS+VGcs1jIBndjgkLfn0Iz6aU+1vjdLOhw2VEFDYSAdc5FZDUIBpLVCw037+cmDWUMjQh1gmKlu5RjYx+hdinskbkCnDQzyV0UtvZD5U8+p6SJzC/Nmaaf4gMpAzA969zpBgMOJZS73ltaysFCw8jb6EmbojoAAdXEbVk4W4YqkKkkJ1iTP3u4Gkt3iQyIGtcmbB2dAWCbqQ13fX1TAsAS843HN+3oV1qjUoEOxg6DemHnZmI+NEU3a+5dtMPwcCA40WX4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KewUB/LTDdhliYuh5xtwwdl2uTZTVVSr/9GRMA2z844=;
 b=yzWN2zJl5BXN+DQIGTsZCoXjGL5zE37wBcFyGdUWIO85A9PcEBmLiGqjJZq7YNahk66RR0QcWSbqPFkRvB/jpCSuXSeFc1+F/2NogNqoCDemHCsBQ4/NC+y0U3nIB0ws2yslYJf7W1YUISQ8W1Czasz0P3iZlhTjTpNfmHhZ+ETbAldEDtqMeBQp2sDpln4TFS5w4w6dwFH7iEOtaBd/AG9Bl023K8yxiAGOLXSVF8dJ/0cBTDNZ+/yd19MWI01g+DAjTq0UWKPjzvgxTQnX8BvKmFRQcHLo/SDqX0vGjYBIu45EFDeBBbRTiHgRM298656bEFi+s3Md0jVozbDCZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KewUB/LTDdhliYuh5xtwwdl2uTZTVVSr/9GRMA2z844=;
 b=ejjptGSnkZD8Mi4Svuqvdwi7/4k+ga52q0KnBliD/27Hhi7H3etu0vAvdz7SjWW+QVDdJKaFRZ/yiglan43saVI1NdEyAejfDMRqcQr9dktTXUWLRrq9o9aPLMBP6Rct7uKPxW4XWVkfLFi3tSx748UcxCeBwU/fZgH7BO/J5Y0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB9174.namprd12.prod.outlook.com (2603:10b6:510:2ed::9)
 by DM3PR12MB9287.namprd12.prod.outlook.com (2603:10b6:8:1ac::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 15:51:13 +0000
Received: from PH7PR12MB9174.namprd12.prod.outlook.com
 ([fe80::eaaa:b430:ba9:5dc]) by PH7PR12MB9174.namprd12.prod.outlook.com
 ([fe80::eaaa:b430:ba9:5dc%7]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 15:51:13 +0000
Message-ID: <16303023-2c73-4296-aa12-5f04b34e5610@amd.com>
Date: Mon, 26 Oct 2026 10:51:11 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] drm/amdgpu: Match VFCT using initial PCI bus
 number
Content-Language: en-US
To: Bjorn Helgaas <helgaas@kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Oz Tiram <oz@shift-computing.de>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org,
 Reza Nikzad Chaleshori <rezanikzadch@gmail.com>
References: <20261026-vfct-regression-v3-0-fe9586ed6978@amd.com>
 <20261026-vfct-regression-v3-2-fe9586ed6978@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20261026-vfct-regression-v3-2-fe9586ed6978@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0030.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:22c::6) To PH7PR12MB9174.namprd12.prod.outlook.com
 (2603:10b6:510:2ed::9)
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
X-MS-TrafficTypeDiagnostic: PH7PR12MB9174:EE_|DM3PR12MB9287:EE_
X-MS-Office365-Filtering-Correlation-Id: 58fc7ec1-3933-4ae5-9741-08df3378f656
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|261026140227099003|11063799006|4143699003|56012099006|261009223027099003|261022115727099003|261021123027099003|261022075727099003|261021121427099003|261022105027099003|10067099003|261026121527099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Q5jf/gyKMDh2prT9VOLcA+esqqER9SC0DelVk/0i5c6VmGGFpHGj2nF+QK/hJx1K/sLsWrDc031QJLzZFC280+kcbtJfinlA6GPWNSa8RjKTWOXWfVCL6a0P+mfqu0h2WOB4Bt0iAItYwtI3jRFY0DxOWGrqi44BDxbStv44MLFSkaxS/gYnqi0FXxKPiKUrReN0pfEdhC4LDIE5GS2OVr9xpnM0yCPRYcB+x5umw4d1VhIlW/oHfcJZRai6rW6wOBF3GGnTCoYKUrZMhAqyufkNBhjoFEmF2+nbM9AlcGJGVBmbtUilSAfYpxjNfVAXZBVYoYl1hGLyfzRD09sXIflmSGrjSSahUaEfzpc2D/KcEr4UKPzDFjHXnM7VKhw0Iy8oonRe0w45pO9dmhOGWAgQCK0SmOqU5qRAF4xleKepEb74cmQlogmN7EZHA0SQn8sG8TbTgc0yrVkpFq/ZBYW53VmBZYrEnybdn/PzTTJmPrWXJ+zAdK2DNwN7LUoHlksThODM5ZXI1G7d0Wk4Laot6LgebPNgWLIRY+WZ/oXMBnTdKBN13ogTnsZSoQ+7smJRI4w06QjXZ92ByaNZfU2OXG+2t20brcZ0k7rf8dj3aN5uUPVDjmBep+SqA90J
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB9174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(261026140227099003)(11063799006)(4143699003)(56012099006)(261009223027099003)(261022115727099003)(261021123027099003)(261022075727099003)(261021121427099003)(261022105027099003)(10067099003)(261026121527099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WnpjNjRmNEJkd2VISmkyNXNWeGFkMGRkQlhyTW10S2N2N3hCZ1JncGx1SlZ0?=
 =?utf-8?B?M1RTYmVJTDdjV04vTWpTV1BNL3JhTVFyUDRRNDFabkFqUkJwRDFCRmlZM2NX?=
 =?utf-8?B?ZUV2MXk4MGdhSkVUbSsyazh5WEhaQzI5U1ZFRU9FUm9pem1Semt6OUZiWkN3?=
 =?utf-8?B?dXNveXowTStjd3RUVStlekJYOVZ6N0p3YzdHK1FhU2hZN1dqWWRMaHpPeXJV?=
 =?utf-8?B?Tm1RMjh5U1VGeFJHUFl0VTNxUzllSG8rdW5kSFN6cWVXaXRadGYzcndRUFFS?=
 =?utf-8?B?MHM3U2NLT3FCeXVQVk5VNTNrVFJyaVJNNGpJL0ExcjN4ejB4NlVseXNOR00w?=
 =?utf-8?B?aytYRTNZVkpqbUpDRUF0YWpNZi9XeEE3WFdqYTRZcmFRVWVTS1A4QTZSa214?=
 =?utf-8?B?aXlTZkVuV0R3VkZ6YVN3Ui82elpHUmJ4TnRHY0NPU1pVc2pIOFpqNEdZS3Z4?=
 =?utf-8?B?bU1zUzdtc1lySGR2eXdvY3dPWHQ5cmZnU3hxRHk4YjQ1ZVI3RlJUWGdEbTZy?=
 =?utf-8?B?VE5sbklvUVNNekIzZ1Z2eWVteUxiYU5kdWlPbmFIelJiUVhybXJRaFcvZzRa?=
 =?utf-8?B?SUNKY3I3bjNPUDhaUE1uYklhQ3lNZ1lmRzV1UTQ1a2kxMnJLblBRbkoyVHMw?=
 =?utf-8?B?UndxcmNZdFpmL0E2UnpDWDVBeUh5eHo1aGh5WXErQkxONTYxaWREOHRFbXE1?=
 =?utf-8?B?Yk05L0huUUtLN3Nsc0dNYVRwdndjbnNiWm0waitHUmNjOGFmWEE2ejg5Mkpr?=
 =?utf-8?B?cXcyK0dWUVpJcVo5ejZHZG5MVklwWlNWYnVwRHZIaWNsa3ltMytMeFhEUUNM?=
 =?utf-8?B?R3Z2YmJxZGYwYmdHN25pMDRLRkNmQ043MmZObHRCa0d5ZDZ3Y0FRYnhVRnlY?=
 =?utf-8?B?eis5VmNTY0FzMnRLMDlpb1FxU3FUVFRrRjJ1eTZIaXNPMnpUMWRCaXllSElH?=
 =?utf-8?B?L0NTWFVaUWpkVWhtaC8zU2d6ZnpwUTNFQXZtYWsyQlFQbGI3MDZJcHFoM1Z1?=
 =?utf-8?B?MXhPYk9SRG51NmJ5N2ltQzcvT3Q1VUJPUW5VVU0yRnVUU0MveE1LdVNaY0tt?=
 =?utf-8?B?OE5RVGxmY1crUXRRNEJUaVVFbTJrUDJNME9vaVY1Qml3MFBnK21SQmM5QjYz?=
 =?utf-8?B?SE9kNkw1YWwwK2NQRUlxS1IzelRFaHRYSVFjV2prenRaRkMrcXB0dGZnYTJl?=
 =?utf-8?B?UHJ0WElUTW1mWnVoVVl5V1NzTEJuR2lGTUZpM1FtNU5ocU5Wc1hNKzlxNW9Z?=
 =?utf-8?B?cUpQZlorbTBENTc3Ullicld6SGdFV25ocXYzS1RZeHJ5VklLK2pCZTVZZnVq?=
 =?utf-8?B?VFdMUHBkNEhOSlJwczBKcGEzYjlvM3pYUEhvdFU3dTVSV2xTQkErek1PT0tl?=
 =?utf-8?B?Sm9LSGs2ckpuZVlMeUROelZsd2tqQWRhNHQwbjFJN0RhclBwKzFMeFhNaWVa?=
 =?utf-8?B?WDdZWXZsZCs3bExRajRWZHpwRXI5alFISjdZQkNvRXgzVVN0bUZPTWVMcENk?=
 =?utf-8?B?MkZ1cjQrNHNqMUtvVEdIcnA2amV0NXdwdFNQc2xHTWZOVUk3NVZjSGpXeTdy?=
 =?utf-8?B?UDNDbEhvYWUvYmw2RURLd3czSVYyWCtacUdpcDBlMlZXU3g4cU9aTVlxdDl2?=
 =?utf-8?B?QUdlL2h0Y0NjV3BneERsb2NCQk9VSUZyMGhXQzNnaHhRalJMYUdqOHlIRWlj?=
 =?utf-8?B?SzdYUTZmbWwzZWo4cVhCSDVNaDAvb3NLZ2VzQzlRdG10Mm5DN05RM2FTaHpV?=
 =?utf-8?B?MmFYZk82YlYwdmZpMGEydTFCQldmaktEREFEN2VFUGJrUTY1anRhZHNMYndy?=
 =?utf-8?B?RWRZN01JZ2RoK0xVaGV6MzFjdml2L0RGMGcyT2V5Sm1RWDZnTUlDWWM4OGx0?=
 =?utf-8?B?NW1UNmM3ZzdOT3VBbnplb1p5U3Yzd3ZVL1lydjVuRjVmVUhlanNiZ09LNlB3?=
 =?utf-8?B?ZFRBT2FRUXo0d0J6czVjNFNmL0x1bFJXQ2lXblJTTjUyNStsanlSOENtdWJE?=
 =?utf-8?B?VlErdVpMdG5TQ1h3LzJJa2Y4blRBWXVBaUxpWlJnTG5EcVpuRjdwTHhrdU9O?=
 =?utf-8?B?cmNJaXFGSWFDaUFqZXNja3pIOSs0Qi9Hc1NyUnduanJEdXBEcFhjRThkZUFI?=
 =?utf-8?B?dUJaQVBGWERXRkw5RHhERGtWSnVhaFU2eEJabUZCVEhxT0NCajVHY0NBTllP?=
 =?utf-8?B?dHJRMXhOVDd1MkZKMURoS0JsSEg1QmZHK2F0ZXUxMFhXbm1vRituSWdzeUpr?=
 =?utf-8?B?Z3JOanBxQUcybWVVREZFZmNYNnpjQ0dJMS9VQUp0WTJiYytoa2tmR3J0S1Ro?=
 =?utf-8?Q?jRsxEW1HzwdJMCnkxI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58fc7ec1-3933-4ae5-9741-08df3378f656
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB9174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 15:51:13.3373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z9RjcrC2FTvjWCA2ZcpgAQh4Hsnu8TLKWz5HL9Td2WoELmzeI0KSwELTT+qnvgz/vgRvfkWmaXr1psZ7PwaPzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9287



On 10/26/26 10:48, Mario Limonciello wrote:
> VFCT records the PCI bus number from BIOS POST. The current bus number
> can change after PCI core renumbers the bus, while accepting a mismatch
> based only on device identity can select the wrong VFCT image when
> matching devices are present. Compare against the bus number captured
> from the firmware bus assignment before bridge renumbering.
> 
> Reported-by: Reza Nikzad Chaleshori <rezanikzadch@gmail.com>
> Closes: https://lore.kernel.org/amd-gfx/20261014080523.186533-1-rezanikzadch@gmail.com/
> Fixes: 11c141672045f ("drm/amdgpu: Fix VFCT bus number matching with soft filter")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Accidentally lost Alex's tag when I rebased.

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c | 17 +++--------------
>   1 file changed, 3 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> index 08ed1eb695586..051be1905e296 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> @@ -386,10 +386,8 @@ static bool amdgpu_read_disabled_bios(struct amdgpu_device *adev)
>    * VFCT entries contain the PCI bus number as recorded during BIOS POST.
>    * On systems where the kernel renumbers PCI buses (e.g. pci=realloc or
>    * resource conflicts), the runtime bus number may differ from the POST
> - * value.  Match by device identity (vendor + device + function) and use
> - * the bus number as a preference: exact bus match is preferred, but when
> - * the bus numbers disagree we accept the entry if the device identity
> - * matches.
> + * value.  Match using the bus number captured when the device was
> + * discovered, before any bus renumbering.
>    *
>    * Returns: 0 on match, -ENODEV on no match
>    */
> @@ -405,16 +403,7 @@ static int amdgpu_acpi_vfct_match(struct amdgpu_device *adev,
>   	    vhdr->PCIFunction != PCI_FUNC(adev->pdev->devfn))
>   		return -ENODEV;
>   
> -	/* Exact bus number match - preferred */
> -	if (vhdr->PCIBus == adev->pdev->bus->number)
> -		return 0;
> -
> -	/* Bus mismatch but device identity matches (PCI renumbering case) */
> -	dev_notice(adev->dev,
> -		   "VFCT bus number mismatch: table %u != runtime %u, matching by device identity (vendor 0x%04x device 0x%04x)\n",
> -		   vhdr->PCIBus, adev->pdev->bus->number,
> -		   adev->pdev->vendor, adev->pdev->device);
> -	return 0;
> +	return vhdr->PCIBus == adev->pdev->bus->number_initial ? 0 : -ENODEV;
>   }
>   
>   static bool amdgpu_acpi_vfct_bios(struct amdgpu_device *adev)
> 


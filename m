Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013063.outbound.protection.outlook.com [40.93.201.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF2437880B;
	Thu,  2 Apr 2026 19:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775159891; cv=fail; b=iL0W+sDyq6uzgutL/eqWFWXadKDcsyoZmjvgOoP7PgGU+06wlVqelxqlfFaJKXWY1NfLZq6hYdKfz50w5Um6L7pbO4wJiewKcCT3xUbgjOuaJaZgvQP6C/cBwK2SBBjnSYhfK4lPfsD8RXJH12c85I/emE1ZO0Vzfer3aHHleZg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775159891; c=relaxed/simple;
	bh=nWGvkhVIlygtWijnfhGHnRlU9dBt4+mhFkouEt1lgd0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=n8YKtc2cwLArVlecOTTOY93ltQ8ZbWX/GBbWyCqqRW4mJr6KqXNHSWX5778uF815o8PW6f1FwRKOpsFAuWQoXULeETuHsnM4jppX3ttFiywZuHBiV8oXnbIw5eJ9W+cc9gio8PSBYxqdE+sn0fLp1QdC8pE1lXJ87D4VhcmjBbs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3N8UMSsu; arc=fail smtp.client-ip=40.93.201.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3N8UMSsu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yTotF/fHQKq5DDRN0UfMayZO1FBbQLFpaqBj6mIN4g7CJtjl+SHt9NJL0gtz/4ykCBOx+6aY71ylsqjWzo/eoj3Y272iNN/uDcZcHeXBEZOBMPmaAdnfQLiyMlWrjr9ctGvjYvNsVIFdlix979UXZbJbN9ms2jhVbqUCEiGYyElDe0eFefxCGVRVj0NBJQ1l88Cssp8EI168Ksy6Ck064mgNXMsVe3JeKEqgcEcHCmZfWvdEF3yBKOqbE91fkK5z4aazaRPu20J/+lXKtwdflSQpaLYWzZdulMj8rPJFdlv7OXDtXMN8WXTLgwgh0tSiW6laLNvajZ+i0JRKr3hKlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w0cxzLPc833EDh8BwDS9gByK9zezT045cl4zH1zCqs4=;
 b=fdKsa0uaevqkv2rO1Z0K8AJhdz4bF/Gr9ePugdBlpXB7gH73eogm2gJ1JRIgzCROx7/QzlmLfdPfJMXUFXOpb4cErwFs1xLJrfjnhYJFyHb5fju3/5jYZLdSrXDgzNMKBOjTDtwYXMweFEqD1rrjmddXXRzqmDYNYaf2JF6Aq0KOQgSdwA97ohRQoRi6lUAFhMT3EYg/UYlYaa1mg5+W2nc57RN0LP8RCPfaOXE7qTp50NswBSq4hgbTix7ai0Iuz7sb8BrZozVn2FHJATG/YctijZwMW5kjlLp8Mk2f4mzDcIfqgC4t9y6gEqJsbUyZWchpjIftcin0YU63JAZQNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w0cxzLPc833EDh8BwDS9gByK9zezT045cl4zH1zCqs4=;
 b=3N8UMSsuFZz7FGM4592Kut51v2COSsoPEPK1Pr44zQ21/8yAuH5Y/Etyp8k0bPF+Rn40oVjLVEnctXm1Qo0mpqYle6X2o25Xdm0BEHbw19mAjVZju9dFM+IMdwsjbGd7uEUSuNdFM2YSIcZp303CJSZTb+27Pknv8vAjc8yLljs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by DM4PR12MB6447.namprd12.prod.outlook.com (2603:10b6:8:bf::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Thu, 2 Apr
 2026 19:58:06 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287%5]) with mapi id 15.20.9769.018; Thu, 2 Apr 2026
 19:58:06 +0000
Message-ID: <a935b2e3-e11d-47ec-af47-7eb7e86a9dd0@amd.com>
Date: Thu, 2 Apr 2026 14:58:04 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] ASUS ProArt PX13 HN7306WU: amd_pmc s2idle S0ix corrupts AMD
 1022:150b root port, NVIDIA dGPU returns header type 7f
To: Joyful Lee <joy@joyfullee.me>, platform-driver-x86@vger.kernel.org
Cc: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
 linux-kernel@vger.kernel.org
References: <CADj6jrgK+sRXoNaYH90Rdc8DYEFK2iSF4vkJC=KE4UaZ73y67A@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CADj6jrgK+sRXoNaYH90Rdc8DYEFK2iSF4vkJC=KE4UaZ73y67A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0112.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c5::25) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|DM4PR12MB6447:EE_
X-MS-Office365-Filtering-Correlation-Id: eca7cb42-52f1-4589-2baa-08de90f227dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	/TAAjzSbi/opAyG+zcjFSm4U+iEaAbUZYDpm13vTDlTmwL/tgYbpU6tGQs4ayXtaXIKwaWVRxnxtwvt7bUakcvWF5QiiN/2GOJtF/glAeP8VHY28OH5+2KeeBJfAbjE0JS/xbFuvxiHuGlS8jwJpS/OrfgKtxcDUxAwXn6pg49XMLSL2qHAwEmeU1O+vrggaAha2BVyGvl01HZqr81P0BgAkX5kzytL2G1nsjvi1ExiOegZrfOe93q6tUWBjiZrP52BgA2oZ7vzNyD6l7pnMM/fo1HDI4F7QldI68jex1JG3Rzii2nnoIQUZD8Z+6EhgjfLVrPeVdr1+/wGjZKI7h/MKhXFHqoNWb8DnvIUS8Lzbmls7tA/HTUT2N5rO7++sB10DeU4C+Bv6hGpxI8YPTf3KmiZsRlP9LUlIkRb8j7Q4Mf9L8yMR4vJYvPzVdZH/VEfSaTgcNVEFIqWHHWbhbz8efgLZ1EcN6GJhJ9j/jn1Z8ibnAHVhyic6XePAyKOmxz70KQqWUC9NxysQFbunIg0qgKFE61nyzOpzAwzHBYBB4x6B9R9dwTJntsIKu9hnycMpDctiEI8NE+wW+Sa5LF6dL38gwNkBaJM9ERL6SieLZPXU3OYkEPwIwu89Mjl80ESt1amqSYRYpsa+DTMMS7Ui/nIu7Mi9WXho5zd8pGkmdzrvNy1IMFQUBvqh/YCp
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4557.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dlRVU3gvUkNFKzhrQ20vREhoblNTbDRUNGFhb1UzNUIrUWMwVXo3N1Y4b0pF?=
 =?utf-8?B?Z0wxTjdqYjVMMnNGdzI1TmJvL1RWRlpMNUZRNUFScENyWGx1d0RielFOV05O?=
 =?utf-8?B?cDhxRjhtOXRZcWRRdlBWSWwwSnhJaUN2TFZKc3lqMUh1VDVvdW51cmVsMHJW?=
 =?utf-8?B?Y1Qrc3cweUtmQ25icVp2ZFlJaStpOFkwYXBPN3FLa2dFeUpCSVlob2tKRGRU?=
 =?utf-8?B?NWREMUN6aWVsQ05LS1BhSklabWFBU0FTVzlhMXZ1NEszL3VoVUQ5a1BJTlNv?=
 =?utf-8?B?amYyTm1hM0E0U24zT1k2RUNmdThWamVXajkxajRWK1RNeGFadHU3Qzh5cm9L?=
 =?utf-8?B?ZW4veW5ONUVBaWpaYzBlU1lDVXNlMFdJSEJhVDdjSmlwTzk3SUgxQTJvbzlp?=
 =?utf-8?B?NmVVMEVhWE84bGRtQzhQS0oycDFUMHJOemNXbmEvSlhabGZ1djYzVWprOFRU?=
 =?utf-8?B?ZlY2cWlzTkN2YmhBR1ZacVdranhObnlvc1h2T24xWW5PQjdibzZXY0FHUk1Y?=
 =?utf-8?B?bE5neEQxaEVhWnQ4dzFrVjZUZ3FXRXhGM0VMcXpDd1ZzNE9VVWdpTnFYWGpv?=
 =?utf-8?B?QTNCMGlUNVZpWVpHdkx4bWdLTFhoZFZNTGhPVUR0K0xwb0pnams1UTNhcmRH?=
 =?utf-8?B?bUVrWFJRdkdMTERSTHh2Snd1MTBlWjlXZjQwMkdmYTIrNVN3SGNSTUdyYWF4?=
 =?utf-8?B?dUkrYnRsS05ZUVZJUlBFWE43VzhSRkFmK3hBVFJTbE1Kcmh5cFRCMWZmVllV?=
 =?utf-8?B?WGR5Nm5tZkRrSERUNUUxQTBzU0FZb1dpTmhaaXdxQ3RSMksxNThCZFhiaXpM?=
 =?utf-8?B?bmthV1BId20rSkFGVjJ0VDcwMFZHNlR6UmFXSHU0Q1NVRENzd3Vxam9PRVF2?=
 =?utf-8?B?Uk5BaUIybzlUUmNaN0xFQk1EQ0JjWWNJcFUreGl3QzNFMDAzdnpoTzNpUGdY?=
 =?utf-8?B?VVNjbjM1K2RwNytFMndKWFdIUEEzZHVseldCenpSRmVVbzJKYkszN29PQ3VW?=
 =?utf-8?B?T0dDYmJvT3h0NXdUV0tPTE02N1VIb1lleUxGSU4zaURCam55eDcrYVFCa0VN?=
 =?utf-8?B?SHJGMlZzMXhyVGUwcldIaTV2MDB1M0VKbmt6ekNNNVhMaDZ5UjFRN2x2Z0ZT?=
 =?utf-8?B?a01iNUZGZkF1dzIreUIzVHZBVG55eE5tUHFQTml0UmE0aWhBbEZiNUJaUHRE?=
 =?utf-8?B?MHVkYzV1NlMrQnN1VXlhdCt0eUtwVC95UFBUazVHdXhQWTRsaVNPMXIvTFJj?=
 =?utf-8?B?YXVLSjdPU29zeXZNUTFqMzVBeGFLNVY0UVNVeitOazRkTFVicThaS2w1dFUz?=
 =?utf-8?B?b25BSUZzU2JQZitrY1hUd3JUVThmNHd0U3lCQkZabjdhZndnYUFKZFRNaVR4?=
 =?utf-8?B?M3orVCtBdFdyaHJ3c1R4ZHIzTjZEeG4xekZGczZaektzSDBhWWw4UVEvSmNh?=
 =?utf-8?B?SXdLQWtKMGU3WEJORjQ4NHFOM1I0SEhNditnck1mZHNkZ3JjOXhEc3NtVEM1?=
 =?utf-8?B?WFJXTDg0dmV5Ky8yN3E5d2xqeFl6eC82WFRCckxJQmJETW1nQWV2YlVZaTNW?=
 =?utf-8?B?RDEwSVMzYVFFMUJ2dVlUeDg3U1FtVFNNbjI3RXRnMHlQemxFMkNHRXVzOXF0?=
 =?utf-8?B?OU9rencydUFiV1NGbkszdFJvSjU1Z1A2MEFpS3BPb1ZHUHJWRUhtVDZ6VFBS?=
 =?utf-8?B?TmNvSVlkQllpVXBYNms4aVJJa2VjMTVVaG8vcEgvQ2M5RWNZZzdyNGs3SDBj?=
 =?utf-8?B?UmJlTVJLZ0tmVnk0L1p4aG9HYmJmMGU3c1BsNFFkSngrS1RjYndiLzBUTTBx?=
 =?utf-8?B?ZkJCNEx4anRvTVNyQzNTMWE0Slc3TUNPbDFkdGdyTnlFMEh3d1JKQyt0OXFj?=
 =?utf-8?B?aWx1UEQrWit4WVcxQ0ZPQTc4b1p3b1V2dTByK2FpK1d0Yit5Kzd1aXVMbDhv?=
 =?utf-8?B?eFZiNHRHL0JJT3lyd2F1aTA4bnhDODkxbDRMWmFTd0Q0MFl3SjVOV0p4TnVh?=
 =?utf-8?B?Uk56Q2hVbmRISWdEUzNRNnl2TlZBVWxieE4yUFlzM3NoN1djZVlYS1dkcmNX?=
 =?utf-8?B?aTJVbFB1aW0zL0FmNVpWZkgvTFlGQnJyVTczKzBsMDRjNGw1V3l2T05Ga2Ir?=
 =?utf-8?B?RCtITXZKOEVvZGhaaTVjY2diL0JUMFZrRWswYkw2SDdRRDlPSnJQcXVKcFRQ?=
 =?utf-8?B?K2hROXJ5VVY4TkdKRUN4UHZ4eVhUVytRdVVlZWFZNWJ0NFpneXNQaWJHNVFw?=
 =?utf-8?B?a1Zjbk9Sb1hMaHJrekMvQ3prYnU2R0NCZlV0SWpmbHhIeDByQmtRM05VR3VO?=
 =?utf-8?B?VEZGUGFBZ3FUWlFQL0pTd3FFcU5NNWdJK1RZbjJzdjFMQnpCYm5xdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eca7cb42-52f1-4589-2baa-08de90f227dc
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 19:58:05.9680
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MtCcjaeyP09cFajlGvLZH80K/KuvzFDOr8Z/71K/pfBwNlcS7/OutPUqj19/8kLz4SvCfo7Ud9FcLZ8u2qQywA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6447

On 4/2/26 1:49 PM, Joyful Lee wrote:
> [You don't often get email from joy@joyfullee.me. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
 > (LLM garbage)
 >
> So far, every path that reaches real S0ix through the normal 0x03/arg=1 PMC
> flow still corrupts the root port, while every path that avoids real S0ix keeps
> the root port healthy.
> 
> (LLM garbage)

What does corruption mean in your context?  Because I don't have any 
idea what a root port being corrupted means.

Basically I don't trust a single assumption that was made by that LLM.

Can you please get an amd-s2idle report from an unpatched mainline kernel:

https://origin.kernel.org/doc/html/next/arch/x86/amd-debugging.html#s2idle-debugging-tool

*Then* let's talk like people used to before LLMs came into the picture 
about your problem.

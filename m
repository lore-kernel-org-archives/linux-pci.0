Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010028.outbound.protection.outlook.com [52.101.61.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E88390615;
	Wed, 14 Oct 2026 09:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791968786; cv=fail; b=F/EZAUtU0LfhLj3BXGzjHRl8eb8IZy1nSdvtxDkOABTe86R4hzvJCUHpgk6OReU6ocpHuPrSdWl9w5mv2P9wYIaYTpUKB/Nkk/kE/LvI9EdnkhK9MUCzwirNVG+lEeCgPz7W/AXKVgK0Ild1rv058AUhH710UNcw6+9wa7vJc2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791968786; c=relaxed/simple;
	bh=F4uGNjlf0Xpd5TAN3tz1fd4KMYPpvOar7/pur10f57I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LSFQhV8wxTF2Nigb6PaCbnQrPzEPasTIEPqqLNnw44oOcrBym1D1cs0HgxCREHatYQ5IbGcqEYvOXGf2L1CIlrj+R3YezgHkOYegG/b1cZUXa6UkjRM9IrdurVYEmolxKeGJhSYWPCogplvcZkGhWQc5QLOga74C0bTsA2S+cXw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hSZa7std; arc=fail smtp.client-ip=52.101.61.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hSZa7std"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kFad1DwEr/ZZWkfOM/rjh//GJYpvAmKO2b3/XZXT2kcEKFUkLTD2gQBZj1mfEAISMWrh3RT2cyFPlLSImK1fVXI5So/UnhWrWTIwZKNUC3lm2yu6txZa+EolcJVv0XgZgG4b9UxOS8xZthR/a2n3otC+7O9XZJblXU6noxoccUyqjli4KzjBQAat3G4eOm7QV0MThihEgIAp60PhbDchXkfk3JL74UFjbo5QIMH+5xWCgBylstBKKrwAt6DCBGI3mflp1ruEy5iMF5cx5yin+9I3FvhMCPikRrU5UiNsaGgF9rhURzASwbkcn5TnpZO4Q6bMd1P8fGUHUUO2wTk/0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=klg/26MDdsv+/aI7HfGuVC75nTBv8IvhKZWlV2oodIY=;
 b=m30h6UGXnQ5P5L4S/XTnVxxC7qpyGIe4nyQKx9jzv/B9ltq0YCgpIj3f8vre1UQ/c3vkFHh3ewaLCgy5ZMuHqja8cHcjYpoCoVysBcbJ5g/as/1lkhVFdJU1I6rduIGCzUObsEqSUov+/KwKmrfup9az5ce5pJYXIgt5hkP2Uk4pjdtvsdtWKlWBrO0whZ+9p8WS0p5i68pD/+2UUPXkEXY/BhzlcucpFtSzMvPwOExfkO/69Nqb8XHWnoFiDjGXcJcwuCW2CYioiUm+Tioaco3lyXxAW6Uyf+OsTfbZIWza9vIXLBHeQRKmvO2Q+z5hm52HJPjGPjLIqwxzSsygxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=klg/26MDdsv+/aI7HfGuVC75nTBv8IvhKZWlV2oodIY=;
 b=hSZa7stdmXhWMuz1t5Hkk1mLeqUqN/v+RiTxMqrm8KbPyZbBFG9RQgx2psGdXybvWw7Fqq6LeUZ+RwfTwQmepH1/SoJWcrVeUKfZY7vSaTA7msEG0blacQxz2AgINeZ1sfAaoCfjCrLBqgG9HhDxU0ElPjYutamGQ3GyDqLzSJs=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA3PR12MB389676.namprd12.prod.outlook.com
 (2603:10b6:208:713::5) by DM4PR12MB7670.namprd12.prod.outlook.com
 (2603:10b6:8:105::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Wed, 14 Oct
 2026 09:06:16 +0000
Received: from IA3PR12MB389676.namprd12.prod.outlook.com
 ([fe80::fce:ac3f:4c7c:bd76]) by IA3PR12MB389676.namprd12.prod.outlook.com
 ([fe80::fce:ac3f:4c7c:bd76%4]) with mapi id 15.21.0522.011; Wed, 14 Oct 2026
 09:06:16 +0000
Message-ID: <3f903190-62a6-4e22-a447-c261037231e6@amd.com>
Date: Wed, 14 Oct 2026 14:36:04 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v2 0/2] Macro Ordering and Typo Correction
To: Vinod Koul <vkoul@kernel.org>
Cc: mani@kernel.org, frank.li@kernel.org, den@valinux.co.jp,
 dmaengine@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, michal.simek@amd.com, devverma@amd.com
References: <20261007100336.4009004-1-devverma@amd.com>
 <asYknhxjo8mo8CeG@parshuram>
Content-Language: en-US
From: "Verma, Devendra" <devverma@amd.com>
In-Reply-To: <asYknhxjo8mo8CeG@parshuram>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0249.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:21a::9) To IA3PR12MB389676.namprd12.prod.outlook.com
 (2603:10b6:208:713::5)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR12MB389676:EE_|DM4PR12MB7670:EE_
X-MS-Office365-Filtering-Correlation-Id: 305cfc39-a43d-41ed-af2b-08df29d266fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|18002099003|22082099003|10067099003|11063799006|261009223027099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	NMEKIt6xPSiRbLC8Eh2t8MLkYORIACHFBw1VCZFcLZyKtDLm+pAcIsWJX2D/SvS+wAmJSqPlxNEBIHOlEbJ/5oDpHjCyf5UEDo4DiaE8jG8p4cTOG0PJUKLanRQz0jwn3tIqTZxVlP8BQK33Qwg9E8BoocRVz+V2ALo14xsrVqbYnlZbaKjBx8HTcM601A+66jmLxAhS6r4ThlGNdb8/khEhmjaqVLE2DcvCXbQBuvILdAOZMU3/L+QSWV9FPXSenJs5hmQghR4Kxtt6COW4t7oxS4uSJGhpuMbx9AcvSnB5iXF+epMMeAamXCVw1a2yDIslkLOidL+o2m/te8+p/f6BHTccpNBr6pdYpgk1WeeTFQJyAu7t5cFqW9Znrvi7bmE/OVsRoxa6EPvvGgsPyDcmCY8Q4ufx3kX6AYZSQz4CW8Z5zGetaIBdTcGFE/GeTNIEuAXNar00bJfwo64UC90/TaSNM4uUqtZnmPZin8F/xZWrtE/UTL6UQCnybDMkuB1iJzMYgD86dHEeTsawjAr66wJaQnOOh4PHU5pM6mDB8hFZt75tj6SOHqofiRNl13yAqKzTM53xDyJSZ7hv/AysJXPoyV7l5rfB94y0yN0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR12MB389676.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(18002099003)(22082099003)(10067099003)(11063799006)(261009223027099003)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TjFkRkdicmhUSEVHUm9renlINWQ3VmRWaVNUQkRDQ2dhRTFUOEs5T241dUxL?=
 =?utf-8?B?ekladGZiaDBEelpwYnlPc2FHR3FlMHg1Q2Q1MTE2Yk40QkxIdGVIVVVHWjl2?=
 =?utf-8?B?b05RcWFmMFBGQk5BeFJMVTlHS1pSTHFka1ZaMDUzN05XcHVVSVNhVUJVZ1d4?=
 =?utf-8?B?WS9mUk13SHZQZ2ZnNmlNT1RFbG5OU3ZGaGo2aWVWZ2NkREhDQ242RWxSYmk2?=
 =?utf-8?B?ZHQvWlVMQWpSUjdZOVpEMUxsZ214WlZ4S0YzWjFmUGp5N1VibVhocGVPbXBH?=
 =?utf-8?B?VkdqSEZ6Y2NBUkZYSkh2N1IrVWVpZlltdlprZEc1bjBXcThZY3Eva0k1Yjh3?=
 =?utf-8?B?SDQwSFY5NWcwMjZDNW5TWkVOS3lUSm9TSXluOENLUS9lRUhJNUpOMCtLT21B?=
 =?utf-8?B?UGpaTGd1RStCaDlLRmxGNWZpYWk5M1I5cVR2a0EzRU04QW4rN1AxNGlSelQ5?=
 =?utf-8?B?Z2hiK0NlM0NrZHY5TXZWODJ1dzVyVFQzaFhwY251Smt1dGF4dS9WWGFuZVZS?=
 =?utf-8?B?TVNCb1NQYTl0VTdyZldCUVNsK1dmMTBHbUF2WjVobUFQMkExTzlsNzhIc0Nn?=
 =?utf-8?B?OURqMFRJazduUGNTcmY3aXNrTUs5YXBtWmFxcXlhTmp4ZnNCTktwdlRPRXEy?=
 =?utf-8?B?VlI3aURMdHNaMCtvbVhZajZuL3J5cExXZGpZTVhZdUNYYjlQM2hRR3Mvc3RF?=
 =?utf-8?B?L0xHajhrbmxuejVCSkFRbFN0NmNsNFovbElOc2hCd3l3QThsQ3Y3SjBSb0Vt?=
 =?utf-8?B?UFAvVzNrcTJSUTl5bFQ1L3ZLSVIxcy93d3V1T2pUc3hlbDU2OXdLcFNqR2pn?=
 =?utf-8?B?YlhvZGxha3p4ZXdmTWtVd2xPOW1pZFZsT1dQQlRKeUlIMDJCNGpSd1B5N2pV?=
 =?utf-8?B?M0RJVUlHdTVVUDdFMEJqeEJ3ZTRpb2YwUC9PcGZ4ajY4WFRDNFlhOURsSG9K?=
 =?utf-8?B?dTNqdDRYYWNnelowajYxYmdhZ0F0d010ank4NEx3ZU1sSkF3YXdFZmtWL3o3?=
 =?utf-8?B?KzhUUlNwTUVMV2hyemgzSmpkdi93RXlvM3VtTWxaZlZ5Mm9pQU9oYUR3TXlL?=
 =?utf-8?B?UmJPRUN6d3BNckp2S0F4MGpxeGRaOUlLeTRKM2xHdU1Wc1ZUcEVWWlBwR09y?=
 =?utf-8?B?WHQ0bk1oNUdmV3BCNFFDSkR0SmpBY3hXKzhaOW0wSHV0bXhyaUk2WXZ4YXls?=
 =?utf-8?B?eFkyajR2NVpzTWdLelprWkN2M0ROcnEva216ZlMwbXVRV1RIQVE2M0tUU3VY?=
 =?utf-8?B?bzlkWWRjSDBQWXJTdmFmRDQyWjBJU0l5WjZEZ3NEcDRTd2hVTVVMQ3lrR1Yy?=
 =?utf-8?B?LzVzTGpCYXJxRGNEWnBmSzZzSktuMjRkRVgxSFkzOUc4RG81cGZ4TncwcGtH?=
 =?utf-8?B?akVSRW9mSjRnTm9hbFVwdG1oNGlJRUxSdldBMzJISkY0emtCZk1yTE9Jb05Q?=
 =?utf-8?B?L1ZqS2V1MEFvdi9CY0Y2WnBrb3A1OFY1OFdzWXlCSFprYS8wc3hGbHhhM1Fx?=
 =?utf-8?B?aUprTkVhYllHUjBNYUZFclhndmNiY3MzL2FCWWovSnFta1pyMWVVN2tFMWpS?=
 =?utf-8?B?ZG42Skd4b04wZkxDMXBQSzIvdXNGek5qdGNDYU5Vb3NkekdDc3ZSbDdyd1BV?=
 =?utf-8?B?dXhEdE53L0tqZ0pYWFFQTTAzMUxQdnY2MHNtQm5zcmtmeFh4Qy9DWlNWUTVo?=
 =?utf-8?B?SCtqbitWZG0zU1FCY0djeFJhdzNCMGJveVc1SGozcCt0U0ZHcVNvMERsMHl3?=
 =?utf-8?B?d21yelk4czAzYVg3OGZBc1JTNlpxZk5xQXNZTU14dmxjKy9CZHd1S1JDc1lr?=
 =?utf-8?B?U1NaVkU0cVpINDh2ejNrT2pGTG1xelhDaWNPdXBhZ3dERHJzMmN5dGxCb3A3?=
 =?utf-8?B?bnNkOE1sYUw5b3JNYUhJL3NRWjVPWndvMWVVczdhelBxQWJ3Rkh3UUF2cEFC?=
 =?utf-8?B?NUhYdEtLUEN6OHpQeHdET3ZMblc0M1ZFY1VYdXZqaHI4R3hXYXd3c0gyWFRp?=
 =?utf-8?B?VzFnVG4xMFVHMWQzVXZPd1Zzd2xic1dzeU5ReWV4YnZNR0kxeUNsT3VCY3Fq?=
 =?utf-8?B?eWwwMTVXUCtUdGZCeUkyM0JWUTl0TzhnVU9QVlZGRVQ1MGxkQjNSUmJuQWp2?=
 =?utf-8?B?Zk1WbVQyKzNnVExNZDdYbFN3SzdLNSt6ZG0yYTNhclpWN05KeGV5UmN1V1VW?=
 =?utf-8?B?UXhOMlNUYzlTUmlUTmVNV3pjT1VNRC9jZEtwQms4eEgwNDdpcGhJaUgyMmNs?=
 =?utf-8?B?RlMzcEhTbnpCV0d3WDhleTNQTDgrakhjVGZqTzcxZ1BCeHFsNmR5dld0eWl0?=
 =?utf-8?B?aE53cUhBTUpwZHk1L3pIYnMwYnBnK2h5Tzk0R3JJOFNta3pNa0ptUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 305cfc39-a43d-41ed-af2b-08df29d266fc
X-MS-Exchange-CrossTenant-AuthSource: IA3PR12MB389676.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 09:06:15.8671
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wIMDhYi6k1t9+0Jk4HQinVw4ItZr6Yd5syaiGUd5qra59Dip/nZrMmqbPZtmAytOBToWvKrEOGL8U4qiNEArVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7670

On 07-Oct-26 16:23, Vinod Koul wrote:
> On 07-10-26, 15:33, Devendra K Verma wrote:
>> These are minor and cosmetic changes.
>>
>> o If the macros declaring the bit positions of a register
>>    are in order then it provides a good view. Corrected
>>    the ordering for once such register.
>> o Corrected the typo under the IP related data struct to
>>    have the correct name under respective IP structs.
>>
>> Previous reviewed-by tags were part of the following
>> review:
> 
> Please post a v3 after rebase on dma/next. As I told you code has
> changed and this does not apply and you posted the same thing again!
>

Hi Vinod
Thank you for the pointing out the cause of error.
I have posted v3 of code based on dma/next branch.

-Devendra
>>
>> https://lore.kernel.org/all/aoW7vxy2lpXEbmRq@SMW015318/
>> https://lore.kernel.org/all/dx5jvko7ygrqugzkt3k74l3d7lk7iauikmxrzuhvn2b4bdv5ub@s2l6zl3alx3z/#t
>>
>> Devendra K Verma (2):
>>    dmaengine: dw-edma: Sort Register Field Macros by Bit Position
>>    dmaengine: dw-edma: correct IP name in xilinx_cpm6_dma_data comment
>>
>>   drivers/dma/dw-edma/dw-edma-pcie.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> -- 
>> 2.43.0
> 


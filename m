Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012031.outbound.protection.outlook.com [40.93.195.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD46B155C97;
	Mon, 30 Mar 2026 17:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774890179; cv=fail; b=h/7RXaqeNkF303Z5k6bjDEr3LpaqFKBKdy6JDA8rYQWBqDC6n5wpurUoIf4KR94dcnqeD/ISeGyuZdf6ytbN4JYuZ2buVACofLplm9hSoVejOQ1/HHOTWRltmkNooGbvjuTT2yN8V7ds2qAIYzWWm5TY8F7UUMmNAltZRzshyfw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774890179; c=relaxed/simple;
	bh=/a2ezHvanAeR16O6jFsNFRp8JHjwu1phm50K9w6u1io=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=L5VQwDh/kAqheJ14yulg2+dRRUsOD6PzTPxCroPZC9BTF8Rx7H7BPQ748xCitKRwApnoe7+fYRCFX0wjl5mVKfH2AUOMS6HI0rSn2dl/xYoi11keaTRS6PUEwrsq/ZyEP16tQ0XL0QdTDe2tMPU+MFaXSJDvBN8fJfFmjO64rSs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=K7d0z3q9; arc=fail smtp.client-ip=40.93.195.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="K7d0z3q9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VW5ZlfPJ+0tVAetPyHnfavnMbiLcI4rPJVf0I8A5OniXujojHnCXFEcyHo2dSnIGn/YjSKS8aodJUJD37Eg1JH+af6T90dLzOAjRZ99QbB2PC8q0P4u9G8csxvnO25A6Vmicr4EBRuvBBE51bYhlfpCXG6lirDBdFG4MWu/O1f8D7OI+SeRNeR5WN3m+4v5Tw/3aQFPLmJxJyH6k4vEykL1W15M4qNfRTH9rFy9hNqgGll7y+Cvr0xfaOovYM0d0rmnns4GyJoz0YWS32OGxsIW4sJoXCLz9I2cnDXHZ/VSX3eX7+PcFehzuYzHUoUfjgx0qdaFr9U8kEh6mnxKNvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5BHjh5TUodeiMVDLKIMFF1svqvufAt3Lx1v+gS0G4MI=;
 b=dg2xNX6UM2Kfnswk16ozvsqBat5WIgL1dlpd/rogMitUPgp3dUQwBdCq2R405LNeiGH2lkBiB/CvlelvAvqr2wBdvu+oG9P7dHUWvdbKdDNFMehJs81c0k6aqL8dA+MC4K0dVUaHYb3fEdbsmf12lst54liQCtKX5dXoZ9MmDPoV4aFS9Tpy3i0NhcP16/38yqNUqyMWFVNQv57hylWF8VZwWjZ9cQAAyGe2mFK+F9sm5QZrNtyNkwkz7Y4/319c0hLOAICKJnxjVRVqoacPd0ANLEQIwlAZK54xZW1VwzcYspljRvk4uimoWIvgRD45MRM3hfRtaB5m9ZZxIiHVgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5BHjh5TUodeiMVDLKIMFF1svqvufAt3Lx1v+gS0G4MI=;
 b=K7d0z3q9gAPmYi8OfErQNRiCp4fRcpWB8GhdVEKZPpJiEaJTbWfNFYCQfkIwbrNYFDPiS43XfI5SWa3q4kmiNqaKqNV+mn9cJiB/0ta2t4/ekMSbJlaqmPgW8ZL58zsiY+Uh7j3h7oU5f9wIQmE5hq8Kwfp8LvXlP88NybLAVyw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH8PR12MB9766.namprd12.prod.outlook.com (2603:10b6:610:2b6::10)
 by SJ1PR12MB6100.namprd12.prod.outlook.com (2603:10b6:a03:45d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 17:02:54 +0000
Received: from CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9]) by CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9%3]) with mapi id 15.20.9769.014; Mon, 30 Mar 2026
 17:02:54 +0000
Message-ID: <a5fc85a2-7ace-4ebe-b774-58f5f569a664@amd.com>
Date: Mon, 30 Mar 2026 12:02:51 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 06/10] PCI/CXL: Add RCH support to CXL handlers
To: Dan Williams <dan.j.williams@intel.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, bhelgaas@google.com, shiju.jose@huawei.com,
 ming.li@zohomail.com, Smita.KoralahalliChannabasappa@amd.com,
 rrichter@amd.com, dan.carpenter@linaro.org,
 PradeepVineshReddy.Kodamati@amd.com, lukas@wunner.de,
 Benjamin.Cheatham@amd.com, sathyanarayanan.kuppuswamy@linux.intel.com,
 linux-cxl@vger.kernel.org, vishal.l.verma@intel.com, alucerop@amd.com,
 ira.weiny@intel.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20260302203648.2886956-1-terry.bowman@amd.com>
 <20260302203648.2886956-7-terry.bowman@amd.com>
 <69c9c44ad84f2_1789041009e@dwillia2-mobl4.notmuch>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <69c9c44ad84f2_1789041009e@dwillia2-mobl4.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0001.namprd03.prod.outlook.com
 (2603:10b6:610:b0::6) To CH8PR12MB9766.namprd12.prod.outlook.com
 (2603:10b6:610:2b6::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR12MB9766:EE_|SJ1PR12MB6100:EE_
X-MS-Office365-Filtering-Correlation-Id: aebe3b92-76b3-4d80-1c97-08de8e7e2f42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	7o1DNiS4wfPJUAYBec7uy/vc8zq4dt+OgwkYwz6aZCBp6kg+anFGSZLbCWW+FNEWLZXVQUxnu2YXrrN5gPnr4ZqVQkyIVojxruYwmbnqrLYBSiqKm0fCHreTa3Jm1O4UsYh9nNFo5yidV3GoyP5EP3xlQJS4AFP/d+VgAZlooaBsNNN9zZ8ieeNhFR8fEMryyrt+SLF0Ep6e/LOuOVDfafJg/fuqvYKv0vLuuYP7F1Y8eSbuqwx5F0W9qApE+etOFQD04tm+VBg5XsbD6bWH9dQHNxenHTQlWgdEdoT0sVVqKWxHz6/75yVuXDlqpBqtRdOh+vlgcPquyxxxIfSDfFhha+E/i95blpJVpndZWt5+6XMEP1wjvROXKI7i9y1eCtZAILUE2eTRUv9oyT2rsoiTrbccC7ycLeK4fjjxLubIUPAqRMIwLSk3ThuBpIY7F4sMw1cOM8qALsk2ub7nQDuL/eGe1EndrZifxSnJoTbhgJXacvbyW3X20EmpAj+5RFS2K4ekiL8upK1JewIB0OXGbVNjF0TpY8a10DUP+mfCnQKMLbADPn4+Ylb3qnjpYsqTD3Swis7f4R3d8jUJ02NH9NsrYZiu1f08At49IT2XrECHKCcYV/MIzFJs0kLObKtrTSE+foLB1yb7/VJnJ0jpU8L172AWoA/IZv6KO5wZQZjC5VXJJij5ZAX6W4ginW4zJp4Gj0wJmfWtCqX8mxSPzQIOo6ZzCrNDSz8Y+XcxR+jfqA+gmIsjSwZj/0QkoKQH8vHhu6L4wbU9OjjjLA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR12MB9766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NEVEQUdPYlFDVXZkTzRRQXBSNUJSMGpaQWhjb3hRbGljWS92L1hpMjZ2VWhG?=
 =?utf-8?B?b2RaMHJmaTBUUnBzekdBNGwrMGhMM0U0STlUd0o1a2FMUzB5ajBuSDJuL01W?=
 =?utf-8?B?VEpJVFFZMEI1NVI2UkE5ZVQ1cnpJandaTDV1LzFlR0Z3c2dxTHArMHBTNnc5?=
 =?utf-8?B?S2dCQU1ZaEREa0piaXV4YlRPWlV5TGR4N0ZBNmc1VjNVQWFoMDNIMjVUTzNn?=
 =?utf-8?B?Qm1kUC8wVVVtelhUbGo4R2c2WFJyVWVFeUUrbENwZjlML1ZRYUtaZmVWdkZC?=
 =?utf-8?B?N3I5RVdHWFFPRndWbzgvMnpLNHlSbDBkOFdiZ0paamw0Ui9NR3ZKTWVaaXhp?=
 =?utf-8?B?Y0FUVlRqUkhtV0wyMnJyam96TFVWNEZFQVB0V3hwbHBHcU1wTWgzRE1NRk52?=
 =?utf-8?B?OFlZVmRwM0ptbVdYZ1NnVEppTFRER3FkbTdYVTZEK3hQOXRvWnN3QmpEUVhE?=
 =?utf-8?B?SWRDeWNuNGs0Q2NrK3hjZzFsdHQvTGRuRVk3WVNFeUNFRWdha0grak12Vkov?=
 =?utf-8?B?Q29XYjJMUklxU0dsZjZqMTRWOFhUaFhtY0NLaEl0NWFIc2pwdzhVazBTVy9j?=
 =?utf-8?B?RTRBTjY0OURYdWpJSGQyNTVJVkdaL1BmSGY5WU5sWW1zZEtTQUFsSjRkdlV5?=
 =?utf-8?B?WlVGYnArbXYwUkoyWURrVkt2Tkx2ckttL3YyUGxxODhUTGxJUVFXQ2hKMFFO?=
 =?utf-8?B?aGFsS3BGWTF5cTdsZmZ5eDduQWxIcjBpd3A1amFJdWVmQWRGZzM5UUpmeFV3?=
 =?utf-8?B?Mko2bDB0czk5VkFCWkJXOVJaWnJmVlAxVGluZUFRRlNTZm9UMHlzYjgxL0xD?=
 =?utf-8?B?Q3J4UnlDQjJIcTE1RUU1a0tRVVJFRHd3cVJtNUlvUVBjYzZSRlVENElRSkpz?=
 =?utf-8?B?T3RMMFYyWk1DTmxkZUV1RkVnSmJyVG5oamdhODQvUEVCNGRyRjVPdk1nbHBM?=
 =?utf-8?B?SDQ0Vk9tSlJZbjdoN2pGanFWNlhNWHRIVlpULzFMY2VpL2VBTFdTcGZSSFhq?=
 =?utf-8?B?WmMwY3JWSWkrQ1E1dTFwbGpFRUY1cEJ4QzJRekd3M1NRRVdYcnQxdFZlY3Nx?=
 =?utf-8?B?Q01vYVNlOTFzdldzTEU5eWJ6THJ2QVFreG9ZdkxvRHFuWHJjaHAyVFpOU0dT?=
 =?utf-8?B?ekYwZlpSUHFhV1pCc3R6NmxhbzVKUlJYK2Z1amRkSlBMMUJBREpYTzdPWHl4?=
 =?utf-8?B?Ri9YR3l5bFFHcEJqSGp2RXZzYTNjUW1YaEpINjRrY2l3OFY0bHFrd1pNa2xF?=
 =?utf-8?B?TnBhTW44aXBUd1MrVUFtbG9qdjQxcHEyZlZDOEtvc0xXK1NscWVVc0x6UlZz?=
 =?utf-8?B?YUN0QWdLeG9sNEkxU0ZIdEw2SFJPVHA5UjRENXRVa0wvSXdzdjFHRjVkZ3BO?=
 =?utf-8?B?K1ZlUGhRTEYxeUtvbTZWVERaTXVwVjZ5bFpZbmM3MnBDblcxbU01UGoyRGgy?=
 =?utf-8?B?WjlpeVJGSXA5WmhuM3ZGM2dRalhIM1FDQmtoalI1WFhJQlR6NVRwS0ZaM1R6?=
 =?utf-8?B?OGJWd1JFNXNGK2ZHemtMbWpXeUdpalNRQS91bk9uOUVxSDg3ai9sNlhNZ2dL?=
 =?utf-8?B?MnVOQ29Da2xVSm84UDBCSnJ2WElvVmw5SElidzZSVWZzb2hjSzE1U0RaYUVu?=
 =?utf-8?B?WTIwMmVLK2txcU1YMkhXbG5YZ3hCYmZLSjlZZlRsaGZiM0NBRk9rR01iN1h2?=
 =?utf-8?B?QVd1K3pxekYxVVZOQ3Z4ZC81QkFEUGpoUUJ0Z0UvSTFrb1YwQ0Y2OERieXZ5?=
 =?utf-8?B?UTZKQVVVZ0p3dVhDeGxiS3FvbWJXOGFnU0ttQkVadEpGVjV5My90YTFPanV1?=
 =?utf-8?B?OU9tK3dSZXF2Z0ZjTmFXZExVWmJ3R1YyYUhucmJKeXAwdXRDRTRCVXg2NXRS?=
 =?utf-8?B?WHlmZGJYZis0MkpxZldWY2RMUmF0cnVXcXVadU90MkhOUTZPd0wrZkpXUU1V?=
 =?utf-8?B?MTB6VHg2RXYzU1FCM3BIVFdvTzZreU83aXc5QzRZZ0tFVXVjR3gydEpMbmJX?=
 =?utf-8?B?dkQ1dlRrZktpZ1o2UHBGL3hKTU9YajljRSszaGhyMjZzWXpHeEFYeE9pbTBj?=
 =?utf-8?B?K2lkVklIRFltNStBWHBkZVNOY3hHeGRRb1FiU0hwWVBZdEJGS1BEZDF4bUdO?=
 =?utf-8?B?Y09SeldWeXI5VmFUbmVDT0tqN1JRWjc0VXRzQ2h6d1pncXZJd3dpVGF1R2NH?=
 =?utf-8?B?NkxpcFhwb2FaNlAzZEZIUjdKWjU2QjVERGZNUEp5RXJzTGFYeG5CbjZ6eTMw?=
 =?utf-8?B?eUdZbk9LM2tiZmFwTnhISUVzKzBHcHRBOTZYY3hXV1hzQURzTmpWaWpTR011?=
 =?utf-8?B?YlVEdjFUN2xHd1lITWRnWUJiU1B4MGlZWVNkUEY2cjlpS1VtcndNZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aebe3b92-76b3-4d80-1c97-08de8e7e2f42
X-MS-Exchange-CrossTenant-AuthSource: CH8PR12MB9766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 17:02:54.4150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: woD9gttmtn4QeHBaQ3KKrI+RlF4uUVaQ/bhsGsf+AEx09YWTgjAUllWz5pD1o29JFcpihjGc2mQ9mXki+ADdwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6100

On 3/29/2026 7:31 PM, Dan Williams wrote:
> "PCI/CXL: Add RCH support to CXL handlers" makes it sounds like this is
> a brand new capability rather than converting old support to new
> infrastructure.
> 
> This is more:
> 
> PCI/CXL: Forward RCD errors to the CXL port error handler
> 
> Terry Bowman wrote:
>> Restricted CXL Host (RCH) error handling is not currently supported by the
>> CXL Port error handling flow.
> 
> It is awkward to reference brand new infrastructure in a series as
> legacy ("not currently supported"). It is useful to quickly set context.
> 
> "Now that the PCI core is prepared to forward CXL port errors via a
> kfifo and the CXL core is prepared to receive them, it allows for
> additional unification. Convert the existing "Restricted CXL Host" (CXL
> 1.x "RCH") error handling from custom error handlers in the "cxl_pci"
> driver to generic CXL port error handlers in the CXL core.> 

That does read better. I'll update the patch message with this.

>> Integrate the existing RCH error handling
>> into the new Port error handling.
>>
>> Update cxl_rch_handle_error_iter() to forward the RCH protocol error using
>> the AER-CXL kfifo.
>>
>> Update cxl_handle_proto_error() to begin the RCH error handling with a call
>> to cxl_handle_rdport_errors(). This function handles both correctable and
>> uncorrectable RCH protocol errors.
>>
>> Change the cxl_handle_rdport_errors() function parameter from a CXL device
>> state to a PCI device.
>>
>> Report the serial number of the RCD Endpoint in the RCH logging. This
>> is used to associate the RCH with the RCD in the logs.
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> 
> Patch looks ok, but it will cause some adjustments to the fixup patch I
> shared against patch5. I still need to rebase all my proposed fixups to
> the end of this series.

Thanks for reviewing Dan.
- Terry

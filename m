Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010013.outbound.protection.outlook.com [52.101.193.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2913B313532;
	Thu, 14 May 2026 17:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778778876; cv=fail; b=ccboRHSxDiSD0Et/sySVZ3gMkF0xKjHrvLz86R1ywAdIXgZFlZiRYhRQFdhf3WXL+ZZSU7cRWJHcZXuIF51728ei+qZCW6KSUzHmcfotPJvwQcrBUagAc8ixMwSWGWibuWxLYlFVpqnGvqBdAuPrHAcU9AfqozpXYlRUeIPWsyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778778876; c=relaxed/simple;
	bh=+hFlVwjfXI//nwraDSclg9tOugN+9tjKAgP4R+8VN2I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mrpLRgvJ/bba/HAGUCHxYuVOybh/HmskCM7W9xL0l3ZXFt6L2ZNVS/e6mkvxwYK/3VXnJw1vhrQq7MnTCz9VpLNOLv9VgU7ytRrrT5PA7ZEaqAJ5V7Y1rbLYvvOvZN25sUgGZILeHHMUgmr61ekndYZ9sWDI7v30IJU0F43R9FQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SF1YTZnP; arc=fail smtp.client-ip=52.101.193.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SF1YTZnP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qr6oK5UBNz7bfByivypBJV+AWQBZOpAVoTYFY7XYFem/ec/jN+jvO+yZm8jId/AIV3J5eztlN0ZE1j/vYR4wsspLCSjt4yDaBvlbIaAtDrDHmVFN/nevXzcKYJWAL6IWpqu1plI57meiD2IAPc8sRiQaGQGwKUOZzN3ZrkALhRxhYhmxas3JZTlQ/Ajj3Iwu34XT71XMdsO8oqWhogQQ1TtMWBtzUpsk3/ebEQhlbXwtSQ5U2LswcL1YsC8k0VCjyegq/tkKBOOXq0PBbNvdQy8UAWmR4r+48uDENd5N9LHXOchfh7zPYYSrX1sgJTEasw5Ouh6bKsT6frowO6An/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AGVEyXO7kh8+/BKo9y+WXmqJ9Fldz0FpDH9wzoBrYk8=;
 b=S12lke8zJad246Yo9MLlpDujWuIApXisUt4zzvVl27Z577zwB1dH8RXffDwZnBv77rNuMW8EDS2PwzEkFUxj7D09t7R1p/4muJLVU5Cf5246Q9eliAYPYCKE5zT7t2QqT5l3MC80SL6M5uQW289fTO5ol/0kPZyCuWXJQGZaEcKEjYkM0hFHRHSqKzfIxl0u+wSAwI2hoAI/iri+J5iJMOEDGksEO+40mdhcX3XJLL8wvmKH0K6it2+5Ev3sBXYBkxKV42rOK6lMwhLIFMAFRRe6EDmKYbvpC5y10ot7HjvyVtugNC9E4kKZv8BDFMtAc3uEiburxFtC/FR/zi+mnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AGVEyXO7kh8+/BKo9y+WXmqJ9Fldz0FpDH9wzoBrYk8=;
 b=SF1YTZnPSs/l470o1oCVQ657Zul3pFiNyNoJmJsquAcTfx2iXZDw/Uqw5ntVaL1NJs90LrkqH9XzMoFwTdfXB6IKozF2BeXH8SKq/T/aNzT7GluS05JiHA3qiERcKH+de4P687RMQMZirZX+hoUOFwOw+kiu6cPSphSiO/FA8GM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DSVPR12MB999147.namprd12.prod.outlook.com (2603:10b6:8:38b::11)
 by DM4PR12MB6304.namprd12.prod.outlook.com (2603:10b6:8:a2::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9913.11; Thu, 14 May 2026 17:14:31 +0000
Received: from DSVPR12MB999147.namprd12.prod.outlook.com
 ([fe80::98c5:8206:6a4:c445]) by DSVPR12MB999147.namprd12.prod.outlook.com
 ([fe80::98c5:8206:6a4:c445%3]) with mapi id 15.20.9870.023; Thu, 14 May 2026
 17:14:31 +0000
Message-ID: <3c6a9ff7-95b2-47dd-87c2-62eec4aefbb1@amd.com>
Date: Thu, 14 May 2026 12:14:29 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI/ASPM: Enable L0s/L1 for removable devices when BIOS
 didn't configure ASPM
Content-Language: en-US
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Bjorn Helgaas
 <bhelgaas@google.com>, "open list:PCI SUBSYSTEM"
 <linux-pci@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 Lukas Wunner <lukas@wunner.de>, linux-pm@vger.kernel.org
References: <20260506152721.GA790227@bhelgaas>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260506152721.GA790227@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS0PR17CA0016.namprd17.prod.outlook.com
 (2603:10b6:8:191::7) To DSVPR12MB999147.namprd12.prod.outlook.com
 (2603:10b6:8:38b::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DSVPR12MB999147:EE_|DM4PR12MB6304:EE_
X-MS-Office365-Filtering-Correlation-Id: 75234f4b-0c11-4cbd-496a-08deb1dc4308
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|18002099003|22082099003|11063799003|56012099003;
X-Microsoft-Antispam-Message-Info:
	qfavrpnuFbSFex7Mnb99U3tq/FMmCYfBN4YzAUJ1TNi5TnO0sDjCcV8SfptCduUUiq2DcrgVnp8URySc2HUfHEcdE7GiLJs1HKm39DXHsN5zOOwEFF8k79Sj1mbbLawN+CbB43wArrCxjMpk3brtlxh6aDFoGDAZI0tiNtfKrp2FCDqdHyCE+gaXGaNhzu+sd4YKrHXmEI1IjHk0PEh73jTV9+kZLgYFmQIhZfAxu/t7egIULCp0eISADJ/KbUrQn5c+ImBBPel9DGj9kmK5jS67pZiFckWEibfZZNVEyywgUlUdFt+4gwxVy+Vg3Q/nJ/A16nr6I6u9ODpbcxEn/pekg7uAPi9av5kB4MSm0tFM/nct19U0FRdJ8ILBvOJw/gR5o8aaVwgqOa9Ctp2vCpayqwmOvhj24J5iBMYMRpHbRez16W/n3s9/QCBl5166x/cVAHp7osatX/nfaqwr2S77BYUA7RbwZ+gSQqEPKB/R/4U7dESKOBrJvLXHXD5jXA3/HzSAdNX2iclwjYutr85b96c0B624mdObq8fqhShQ8F5eZ70opZji6xL/qyOdtcO39PeCGyXVxEUQ0PxfUlVWO9WTH3VynWjScllk2XE+t7AG9g0tjHZWjjpeUp/I5FNiW3zhyzCWn2G5PB2ZONW9cfjoLvJPmyIvNTsGvQN1uCnb/Gd0myF856EcgYHK
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DSVPR12MB999147.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(11063799003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bCs1V3RiUjV1TjVOTXNvT0hpckFjOWFjSFcvcG14YS9nMU1lYm9tcjVRRWZQ?=
 =?utf-8?B?Y0NMaGxoUHRmN1JhK0hmN1VIM1p3aTE1eGdPMUtWNWFqeVIxa2JpNnhLa3JG?=
 =?utf-8?B?ZVg4SUg1OTYxRDlDTmZ2dkJCL2cvUDk1SGV3L3RXWHlIUHMyZGVJdE83aVJo?=
 =?utf-8?B?ckViU1lYQjB4NDVwUElBL0hycDVlaUNTTWl3SjV4Y0ptakw1WklHc0g3Zm1H?=
 =?utf-8?B?dndTdTRZODAvOVhWWjZzblkvUHR2VVA0cU8zKzE5N01WMXE0VVp0ZnZNRTBE?=
 =?utf-8?B?bzZFL3dTbzdnbkFLYWJRZFRycWlkMGNjekNyYVdHNnVwLzROMU9aeGxZay9S?=
 =?utf-8?B?d3FwaEhDZ2w0ZFlDL2lLUWtQVWlwVVJuZVZWQ0ZKSEJnU1d1T0E0R3FacG9H?=
 =?utf-8?B?VzBUVkhWZVI5dzB6RWkyc3ZwZTB2Z1BQNmlGSTNGZXJmQTJzQXY0SGhVa0pj?=
 =?utf-8?B?eVZHNkhOZVlqYitEZGVFcndPVlZiK2N1UTdUZ0ozTDYyc0ZsbEcrd2c1L2pN?=
 =?utf-8?B?V0wzRkd3QWVYTHpzMUhpVGFBYU5zQjZLZFlIU29BV25tMVBMZWk2S1NSeCtU?=
 =?utf-8?B?QmVwc3lXN3pydHlLd3VXTFRXcFJnZE5rU3NLSnJUL2xtNTlteTJxeHhGMGo0?=
 =?utf-8?B?WldJRjZRcWRrSlBoU2NkOUlUOGcwQWo5Wk1jVlh0VVBqVnNRamV3T0FweHk4?=
 =?utf-8?B?aEVVZlVKQUV3ckpUQXVQZk1wNVYwRkFTZXNIeGJ1dW9LSzE3eGFPNE4zV0N5?=
 =?utf-8?B?dTJTdGswZ2xldmgwcXJ3RlFRdElUSkpicW5PZmxVdExCclRaVGpJdEtSWE52?=
 =?utf-8?B?MjB0a1EyRGpMUHNPc1Fpb3Vza2ZVdEF2Vksvb2ZZNzV3L2o2SC9vdUNSdk5o?=
 =?utf-8?B?bkRYaUhHMnc2YjlEdWxIQVdqNDA2bXdqZ3d1Z21ac05YV0lmdXFGb2loa0Vl?=
 =?utf-8?B?MlUvZlZWQVIxZHMzNWNUdk5DR3ZXeXlWcTJNUlFzQWhrL0lsaENqdThKY3Ew?=
 =?utf-8?B?S3ZYeWd4Z0F3Sks2dEV1NzN1Rm5yR1JYSk5iUi9OVTg0RlZ4c1FqbnR0bFBz?=
 =?utf-8?B?aFFsMEIvcGxtQlJ0NVJSNXlJUTlSSHJSTEcxbXh1djJ5NDd1VWxLNVlNc2pv?=
 =?utf-8?B?U0pGaGViZ1pobXJzNFhpcTRRN2RUUmVDQnh6UlBteGV0cFVremF5LzY3cnJD?=
 =?utf-8?B?V2NURzI5RXIwZVVaN25vVTlKZDhtbWFDRG14TC9nZ0c5QW1BaWN5Q1QvZGtE?=
 =?utf-8?B?OEV0bXdtcjN0czRzNllCQ1RPMGFORG5Idk5DejFCRlRTOVFnVVdqYkFuNXVR?=
 =?utf-8?B?cjVZalJtdmQ1S3JNYUpkN3Z3a2JKVFhJS0Y0TElXT1dCQ0w3aTlnS3IyNEsv?=
 =?utf-8?B?ZXhSMENTSUFIZU9hcjdaeDlFc1hSRTVkN0EzNVkwOUNDMUhucmFZREFuTDVt?=
 =?utf-8?B?eGpmMXVpcFlnMWxtcTFrQzI3UDdsUEhHYW56cXNMaUwramRvSkhQR25tMnp1?=
 =?utf-8?B?RWJaMEFQVU9MdUZnOE80S3JwVFVRY1NoeUtmUzg1bmFFSG1qOWg2YmFhcVNM?=
 =?utf-8?B?d2pLNWp0TUlSaUtwVnNFbjViRWRabjQ5WUplRnRaTWk2U3B1ZG9RTXRrOTM5?=
 =?utf-8?B?ZGk5cnZzWmN5L3FxYTRZT3BRRWxoOUlxbzJ1TUhvNDFmTVFJZTROTEFVVzVI?=
 =?utf-8?B?VnBUODZYTlN3c2l6VzFNU2ZzNDUyZFRza0FIQk1vNEhSK3VvYkdEV2pZNjBO?=
 =?utf-8?B?ZTRxcEZVTitOdElhNkFxdmNXbzFSUlZQZzBrM3BtbW5IVkJlL0NTL0k2OHo3?=
 =?utf-8?B?bHNnY0tiY1I4MmJObkdPcEdFeUlld2hhNGdibjgzWUs3UWhDWnBKa0hOMEpE?=
 =?utf-8?B?bjlOUm9tdFUzdjNOUDJaYi8xTm1DMGkycUFMSHdJVFFTZkNGQmlpVDdQZ3Zy?=
 =?utf-8?B?UWNoRk1LTGdiYTY1S0c1RUUrcFFQRy9QVVdXaTlscGxUNVNZQUVFNjByZUZ1?=
 =?utf-8?B?eHlpK01PSFVtcEtOWWJoaHZSRXNwTk9WU1c3cGI0SEx1elhRTkdpdVFqSGdj?=
 =?utf-8?B?b3ovSk5aQmZHOGRNVklTOEt0aGZkaGV1VVJxak15NTJ2QitxMnFMZURzcFQ5?=
 =?utf-8?B?amdUeHNmaUs2azhXd3lpaGw4VW1jeHptSmdRYUVxZm9rQXNvL3c4MlhpV1NC?=
 =?utf-8?B?aWhYYkFoTkZQNTloM2plRkVUaC8rMmN6SmMxWllkWDVmTWRtWDFhSmlUTFVY?=
 =?utf-8?B?WHlncHB4bW13dHQ2YmQycVJIWVJBVFFxWm9ZQU1CVCtHOFdXU0pQME1SYkJr?=
 =?utf-8?B?Uk45OUNDY3VNdm9KSkJlMmJpK0MwZWVTTFlnYk5rY2pGZm5PZnluZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75234f4b-0c11-4cbd-496a-08deb1dc4308
X-MS-Exchange-CrossTenant-AuthSource: DSVPR12MB999147.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 17:14:31.0174
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3LDDWzQ14KCtyDTjf6AYKD5brqiP5ZN1wV2Va+NuVjKTnAFOu9sTVljwse0Vyh0VJyaPqkE9c75GuVKv+7yV1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6304



On 5/6/26 10:27, Bjorn Helgaas wrote:
> On Wed, May 06, 2026 at 10:10:47AM -0500, Mario Limonciello wrote:
>> On 5/5/26 23:53, Mika Westerberg wrote:
>>> On Tue, May 05, 2026 at 08:09:22PM +0200, Rafael J. Wysocki wrote:
>>>> On Tue, May 5, 2026 at 12:53 AM Mario Limonciello
>>>> <mario.limonciello@amd.com> wrote:
>> ...
> 
>>>>> +        * For devicetree platforms, enable L0s and L1 by default.
>>>>> +        *
>>>>> +        * For removable devices (e.g., Thunderbolt/USB4), enable L0s and L1
>>>>> +        * by default if BIOS didn't configure any ASPM states. This handles
>>>>> +        * hotplugged devices where firmware may not have configured ASPM.
>>>>> +        */
>>>
>>> Only L1 is supported over TB/USB4 tunnel (no L0s, no L1 substates). The
>>> PCIe endpoint and the downstream port it connects to of course can support
>>> the full range as that's a real PCIe link.
>>
>> OK - the comment should be updated but I do expect that below code
>> (link->aspm_support) should remain OK.
> 
> TB/USB4 are examples of removable devices but they're not the only
> ones, so I think it's OK for the comment to mention L0s.  In fact, it
> *should* mention L0s since the code below includes L0s, and mentioning
> only L1 would just be confusing.
> 
It sounds like you're suggesting no changes to this proposal then, right?

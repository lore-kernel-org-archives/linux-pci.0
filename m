Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010041.outbound.protection.outlook.com [40.93.198.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7192580F2;
	Fri, 11 Sep 2026 14:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789136798; cv=fail; b=sfgkUCKnkcuOogPvEdQCfRxSPLfOhplN9oEVs++G3T4dN+ph6aHf9NJQoZ6paDk4aT7U7LGM+FH9DMOB63/wzn8h1vWwhi7oa+L9H8oTHMnicUrHtVJ7RAYaPnQy6N/OysqXGsf15EfAq+AxvOAQ46iQQjve5vifVjwIiC4Tl6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789136798; c=relaxed/simple;
	bh=Vr3PRRyYcGIp9xsVbpe0knY6F7uwDfQ1FqcPgD5606I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=n0N9+6mIY1MtKwV+eawP0O1Xow8tjcKRAQNNshaIWFaIUngAImeBFYooIgF4QZiYekDs2ZGOuiz8mtSE3wo5KSixDCefhSBAKXfVw2OOw/5BXSRd7uGU5MVWa22Bg0wPIL11HeVbeYvbRtUiMz84TQPZ1G5bQt5EXISOwjoWOTU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3xO4sSf7; arc=fail smtp.client-ip=40.93.198.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3xO4sSf7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d7swDH6sbmM+GYCwclisImw5qTRB/nHpUwd2Fwoir4raF+ao8619XSAxNRoPhaORgYhQtMyNcn3To2P1pG8RRNvlQ4RMlDDUTYBP5tnLUnPr+5M3whW1QhoFFSv2vB9fVpa4CeeJiAb/7JxVnhsXWjDpAJgRdtOzJLqb7I1wO1trQoYuRKxqeTds6sHzE4ZGIIh/3fBpQv24gft0yrk6sbh0Aj8iSIG7GyOdrNzBDkSSSNU6racdb7yT/6b2PG4ldD2i6P2CPl9eLETZdb1BGXsn+MX3FAYCOBfSqDz3ol01mXFBAiXCvPpYF81HeSH0T3tt6lVdqqvDmC+u1ZZzGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZUiKTmZqcwiFO93cf5t7QtmoU6USQqymjAi84ShrkXc=;
 b=fyCPn2hdqbl7FJv5XtzGcp6j69DL4pAWA2YKAHfLBJSbj2l8d6wyQ6oWx7bf1BzPBY3lUq/v5DDpK4u29SnMBvQ9o+86A/QAokHuDvhvGaijuNTOp9ciSp2AT7sY8pwfqJKfbEFYZrodMzleIFCROM2AgZkA/jBHXOvl+yhNrrAPOMn3//cYnsa4AisghC2uAPwFN5uRfNtEwjn5kBE0V+X5eJoQW4b5t8cC4kZ1633z5H9gpyYL4GIou/4qEfJ9EKlB7Gcu52eevy76SdhgUWqRK6L4UdeTpfuI2mnZxCT080Fy0zAuxq1X09ASSn0NdD7o9G6Zw0kxEhoojTDQ3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZUiKTmZqcwiFO93cf5t7QtmoU6USQqymjAi84ShrkXc=;
 b=3xO4sSf7j6qFnHrp5+qonhMeRndjSgo6BgcZJy7EJciwLloShX8agukP+iinJc5oYwpm1eXBoRPTfn166p95Q2Bt4WUUHimVYFR9+fcLGXldMu72JauNATaAttYIcN61hbvbaBsekLUcsVjrZQP3+bO1HIj45tMatISU+2ch37Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB6921.namprd12.prod.outlook.com (2603:10b6:303:208::8)
 by LV3PR12MB9144.namprd12.prod.outlook.com (2603:10b6:408:19d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.10; Fri, 11 Sep
 2026 14:26:30 +0000
Received: from MW4PR12MB6921.namprd12.prod.outlook.com
 ([fe80::cbf7:e2db:1d37:c83b]) by MW4PR12MB6921.namprd12.prod.outlook.com
 ([fe80::cbf7:e2db:1d37:c83b%5]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 14:26:30 +0000
Message-ID: <b2776bb0-e18d-4638-bc9f-b19a07744a43@amd.com>
Date: Fri, 11 Sep 2026 09:26:28 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hwmon: (k10temp): Add PCI IDs for 1ah/80h
Content-Language: en-US
To: Guenter Roeck <linux@roeck-us.net>, clemens@ladisch.de,
 bhelgaas@google.com
Cc: linux-hwmon@vger.kernel.org, linux-pci@vger.kernel.org
References: <20260911134304.226286-1-mario.limonciello@amd.com>
 <091d3bdd-f9f5-4f67-a9be-ff9e49ecaee1@roeck-us.net>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <091d3bdd-f9f5-4f67-a9be-ff9e49ecaee1@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CYZPR12CA0017.namprd12.prod.outlook.com
 (2603:10b6:930:8b::14) To MW4PR12MB6921.namprd12.prod.outlook.com
 (2603:10b6:303:208::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6921:EE_|LV3PR12MB9144:EE_
X-MS-Office365-Filtering-Correlation-Id: ea1cd148-9ffa-49d6-ce17-08df1010abe8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|4143699003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	FmgY8qkIOpZ6TAcbwMxmVRwpUq473lr96gMoSL4wB7gASJuvw9d7nf/5gR4o2rHyUXwgMgfShEE6kKF1NSfQUblYk7NlzOpItc6ZXIASkw237X8CvzLC2idCOVelPbJPineb7PPe/VIJ4CVax7hjAOrMG0NUP5QgoZEPdYOIC62Yws20WesrQuBav084ywOJE9VVXQ1u7gQKxtyCxm1v/v8HNz5xFjpspgNmdVRPdwQmmFW25csqyEZnKNaG8yqYnB+GtEfitKapAQ6VKPkqXLXOSiGApVE5iR8W9DUcnFLvs/XccbapggnOSnTTj1JDGXryXlJIXl9zmbN7+3mWo9V3FjrW6uKdh/gnDu8xdVFIIEF7cejwDzLKDuB8Ag+MgV8i3bPCDLPvWwLdR1AeBAL0+0GRWoun3Eks1QZYvtnsQvqMXDMzh3j0I+TPXKBE8PBQjI+DbP+ostbe/r5gJzu3g4D/AGjcm7BIygFYHdBvKNOWFMVqxZAtmV+cDFAfZsuoMreNXjFa3Cjnprv0wWFxVOgsCTPASqfxK918l0Vsp9W65pdLuaKdRy+9E1z+NoQZzULK0T0HLtHe41fUAe3m+JcLfsRxfmLitjMdgCgGk4rvIY1VOeVgidksnwpKYtH1Zm9MATuKwtP6hV3gM5MR09WWV4PmBPM7eIdZkRI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB6921.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(4143699003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SkR3b0wrdGZoa2c0MEo2bk5XelhkWjkzMk4zOXZsSjFFWlpBTEpHV2R1aVUv?=
 =?utf-8?B?MmpkM0dkU1Ryd2l5QTN5TDdwNUc3MENzMWZHREllRW1oZ1hidms3dUxpN3FO?=
 =?utf-8?B?L1ZYb1JvR2tmdEhKMGxtaU1ZOVg1S2ZSWGRCM1ZvNjc1S0EzWjZiOWxsbHRr?=
 =?utf-8?B?Z04vZUhhY0VQUzlwV0hBaFI4TEp6R2YvNGZFdENFVG9ucEpQV0hqMCtMbGVm?=
 =?utf-8?B?a0ZCbVBCTDhlcnlRcXc2V29mZno2eDJyNm9wVEM1R1ZFZ0FxYWZralF5VUty?=
 =?utf-8?B?MXBNTktGbUZiSGh3QWIzdjFwUmtQWDFwb0xHd0t5dDNUMjJtbXYwSTIzeUlC?=
 =?utf-8?B?Y1JXRnlMR1ZXSTQza2JxL29YeSswNWRFbjhXOUZPZHdEZ2Q0ZGFrQTRsTjBq?=
 =?utf-8?B?MUhnTW5tQTI4cXVXYTY0clhXckJTekl1VlF3clJYMHBUTWpEaTRlU0JSSzNo?=
 =?utf-8?B?Z3pMcnAwSzkrMG8vTlk2emtZNVBlcTlxeDFncTZVV2ZzWjhzM2xxRjdjQzFP?=
 =?utf-8?B?NkVuaGplR0w4RHUvNEhvQ0lVVFMzNUFwTTRjek1lRlFmclZPM3IzV2lMbXBG?=
 =?utf-8?B?S0ZCTUZGa2NxY0RhNHNWcG5xQVJBczYwSUxsY1hWNmIwaVBmbXBxQUdaenRN?=
 =?utf-8?B?ZHoraHZ3Z0VCRWJpQVJWeUNjdmRvUnBnTDQ3SDViTlczaTFSc1ptdHhtK1pS?=
 =?utf-8?B?TkNsN3EvZU9zVkVFM0dMd3M1cytQeU9KMXNCaFhoWkFjS3NrVnR4L1NIbE9a?=
 =?utf-8?B?cVZ6empiTXZYeTh5K2Y0Z0xibGhRRkNDVXR6eHFJTm1OaG9qckF5UENBWGxi?=
 =?utf-8?B?bTVjTlovc2N3dHJNZnFrQUJLemptZUlIV0NkQ3ZGTlcvSFZ5dVhWSHBMR0Uv?=
 =?utf-8?B?YUM5RldqZlNJZy9oMi95a0h6aXkwa2Z3dkVYck9YVXlzU0hBa2RseDZMcDVu?=
 =?utf-8?B?cmI5OVlxNmNyVkNaODJUVUhNRlg0WTNkMXllR3I3TDF3OHZjSUNaMXdRc2xE?=
 =?utf-8?B?M3FLUWU3RGlBS05QdjM3eWgvUk9rUTEvUXZSbjByTUtkY2Y1MVZ6b1Uwb2NJ?=
 =?utf-8?B?bGNIUVprR2J2VXlnOUdpdWZQZVRuVkRzZkdZN0ZPbW5jMG1HaE91YlJjYkZL?=
 =?utf-8?B?Q2J0TElJU0xYZG91YmRNRkNVWFVMbzE3SFE5Nm9FL0EwMUVLZk12S0VTQnU1?=
 =?utf-8?B?M0l3ZkRwWFoyR0ZTckZQL1hrSkZITmxMR1VVYzVtV21jQlRuM0xSNEMzNi9T?=
 =?utf-8?B?YzQvMlA0MTBQSHdZdzFyYmNqcnMxTzNXK0RxcWQraGxlVHF4WW5MRi95SWFm?=
 =?utf-8?B?cm5VQzJVK3J4S3JUT3QwZWp5WjVmSktrYWg0dU5WRGpHS0xVejlkSHA5dnRI?=
 =?utf-8?B?WVlLZTNJSUQzOUk3TFFWRDNRNnlZTTFqRCtRbUxKRFZWUk5Hcm9WU2tjYlB5?=
 =?utf-8?B?QjF1SUl1UjZRN1p2cGU0QXF1SGdqSW9lT0pNa0tJRDlVTXgrTWQyUzMrVUsr?=
 =?utf-8?B?cjV0TngydEFROTIxdlhWZGQ5bXhtMUkxTzBzdUxXNUFxS1F4YnQwSzZjQmdh?=
 =?utf-8?B?ei9GcE9mQ1M0T0o0dGYxbHFZRnl3M0cxMm1YR1NvRTk2M1hkSitoYlJkQ3Ex?=
 =?utf-8?B?ZlNjUDVSS0dJQ1FOLzlISmNaU1hrQzhlNEdUSStGN2M3LzlwbE93QW80WGhh?=
 =?utf-8?B?S01TL2ZrYzlPMzdGQWhWa1hTQVk1MHo0aGN5QnhWZmhTb0pZVjNialQ4elVH?=
 =?utf-8?B?dHZYcXZJQXZRUk11c0cwV2VVZ2lNRGl3cG1NMjU4c2hvYW1lcE9pMERSTnRE?=
 =?utf-8?B?bVJyTm5JOHcvQ0pPSHR1WUtScFBEbzhXK05hcDBIQ3NiS3NDazJVNGxyWUpO?=
 =?utf-8?B?ZWMwNkpiMzVxdThSc3g0eXB1Q2ZLL2ZWZzh1THJGTGhyaUV2OVRudFM5Zmln?=
 =?utf-8?B?MjNYZmpEVXN4SFNxMHpRZ1NYcXlTUTN1dnB1dnNhZlduMHB4eFJQVUo0eGNh?=
 =?utf-8?B?MnpjVmhZc2o3aVF0L1JsYkJCUlpubVZCYXlzLzJVeGoxb255MnVNbzFiMGRa?=
 =?utf-8?B?N1pNaFpTOHhwaFdtalNJN0pjeW0zSzhnMUxqRnZid0g3UHJaRmxIWDdiT21L?=
 =?utf-8?B?TG0weE8rWC9WblNEVU1TM1ZoZEx6Z0hYcUlVZ3FJb2M5TzlTbG1ETFNCaGk4?=
 =?utf-8?B?Z1FxL2gzTVJHZ1VNUnNaR2pudjkwcURPVWxWVyt3RitDTCtDS3l1MkM1L2dP?=
 =?utf-8?B?MkRXK1AvVmdBaEtzUnd5cWlSbXAwTDFXWHpPY25QbXBRMnhBa0NnWXg2aWZX?=
 =?utf-8?B?bXdSWWxoV3U0NUJ0UjhiZE1NaDB3blNDSnh1cXdZazJ3allINUFYZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea1cd148-9ffa-49d6-ce17-08df1010abe8
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6921.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 14:26:30.0927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dM6P88tgeD/BaLxmSkYIH3/ANHHxKgpWYbZSLfyRRfplAa2fk+HN827y9JUiFXt94AuIzkrjis4aWzn3muLAug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9144



On 9/11/26 09:24, Guenter Roeck wrote:
> On 9/11/26 06:43, Mario Limonciello wrote:
>> 1ah/80h uses same base as other programs.  It only supports Tctl.
>>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/hwmon/k10temp.c | 1 +
>>   include/linux/pci_ids.h | 1 +
>>   2 files changed, 2 insertions(+)
>>
>> diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
>> index 3e7e63edc6a30..b00081deb2e86 100644
>> --- a/drivers/hwmon/k10temp.c
>> +++ b/drivers/hwmon/k10temp.c
>> @@ -582,6 +582,7 @@ static const struct pci_device_id 
>> k10temp_id_table[] = {
>>       { PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_1AH_M50H_DF_F3) },
>>       { PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_1AH_M60H_DF_F3) },
>>       { PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_1AH_M70H_DF_F3) },
>> +    { PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_1AH_M80H_DF_F3) },
>>       { PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_1AH_M90H_DF_F3) },
>>       { PCI_VDEVICE(HYGON, PCI_DEVICE_ID_AMD_17H_DF_F3) },
>>       {}
>> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
>> index 63774ae2bf71d..57a4ad9984798 100644
>> --- a/include/linux/pci_ids.h
>> +++ b/include/linux/pci_ids.h
>> @@ -585,6 +585,7 @@
>>   #define PCI_DEVICE_ID_AMD_1AH_M20H_DF_F3 0x16fb
>>   #define PCI_DEVICE_ID_AMD_1AH_M60H_DF_F3 0x124b
>>   #define PCI_DEVICE_ID_AMD_1AH_M70H_DF_F3 0x12bb
>> +#define PCI_DEVICE_ID_AMD_1AH_M80H_DF_F3 0x1243
> 
> Please define locally in drivers/hwmon/k10temp.c. I can not touch
> this file, and additions for single-use defines are usually rejected
> by the maintainers.

Thanks, I'll respin accordingly.

> 
> Also, it would be nice to list the chip family in the commit message
> and add it to Documentation/hwmon/k10temp.rst. But then I see that
> all chips from family 1ah are missing from there, so maybe that should
> be a separate patch.
> 
> Thanks,
> Guenter
> 

It would need to wait until after product launch too.  I'll set a 
reminder for myself to do this later when I am allowed to.

Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010061.outbound.protection.outlook.com [40.93.198.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9D823BD1B
	for <linux-pci@vger.kernel.org>; Sat, 11 Apr 2026 17:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775929360; cv=fail; b=J1gdEm5N1WwlvPp+Pim5yOuBYd49DZSF4dptp8EClEJb0bO6GmzE3SkFW85/+Tv9XIuU+l9itKP6fWU/xbi9n4l907+hXnJ25p/2qPXgdK4Rq7KIexJjX5btBRGRKz7zBweFYBRHmdZsSOSRFwpz3DohrB3MUGUfHHRf5A2ekaM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775929360; c=relaxed/simple;
	bh=fUEfRwAjOYQApdXoRWZDUMZAHN3EntaD7NmKGSu2M1Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=b9F3Vtljat56jSPqR9hKx4NyhewC7q6NNYg2VAO8cR2I2MV1olVMZIZC2NNlspQi2uhtSVQfpukKGzzGeMhs/xpwNEMFc+7WOUzDHAoML2i/gAbvlS1leqRGf+cUUS7pYEua49M9UZsUq3O67zZTOam6zsqQTCzUXZGGr7PM3u4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kfqlek5/; arc=fail smtp.client-ip=40.93.198.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kfqlek5/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W1r5Bgrxh993jb8yQh5+zvrDHfaQIMOGcV6QmMUitSBGe5UWukDfe9KIg89uuVuUm7vhwJiYgEPESGjx+twDVmc2K7lITWuBJFI/oJtszSgP/ZYChoqX/uLYZr3ktCRb8j36nryWo8yePKdXy9PPBKDtbgB7E3iIeeVzjVbwP34yW07SimuCpS5qNVuG8BRGcfuO9H2kubEC4fzGDqxjlVaQEpaKbMXoa7ykt9UruVC71XUq0nK0Lmj6WsN9cE0HSSXEGqrPJHE5cz6/UK+hXF9vTK7Nq2wllso2QfcemSyO+y58Xhjifva6E+nzxCUvAfUTunb5PArLv+X0+dK7EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4C8hlr/FkkQJISkJEIoryFzBDDU4YlYqkSrOXk/x0i8=;
 b=rrPTdpMRnlwzJXwz8QBGyCH1Oz59xsldURmaJc+m4ir7jPEaBy12tC2rWIr01atwQ6XpyCuwEzka8q9blAjR9EeXalSWOUjCU+ZLfvUQKEzIjr4t/TzZIAMG1wfkNVWZwV+tnoDSWL0OkcmdIz82hUiWLS1Xd4ESBGNHAXH5iJNtrmx5Qn6yYgtNpFDnDq7CU5FbfReG1bSk2kM6FPqoMglFbiB+VAsBI+jaFt9QnyWoMl2K0hdKYgBkVnzMKPVmKqOssNQ7OZ45LsdxijYGe0BVJ2afzCpbZjdLRcOurS5gqqNx+BEgqt/gng/SjXzlKwDiWoipoW9oUjW1Ncusdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4C8hlr/FkkQJISkJEIoryFzBDDU4YlYqkSrOXk/x0i8=;
 b=kfqlek5/7niJ9Df1o5da297d1z/IrPn5PH1VCXfA75WnxqqHZwNEYVsmhLTAiGw3u8OAdSXR8bKa1ACWvPbt5DKtzZcBqHaMZQX+Yns4bGQfgFLszUovdr0XTa1Y5jQwglmgXDRMPhm2IS7QlU/ZimZQWBMLFZ15eH/90CppnXY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by MN2PR12MB4342.namprd12.prod.outlook.com (2603:10b6:208:264::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.46; Sat, 11 Apr
 2026 17:42:34 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287%5]) with mapi id 15.20.9769.041; Sat, 11 Apr 2026
 17:42:34 +0000
Message-ID: <b6968406-e35d-4b1e-83fa-719334611223@amd.com>
Date: Sat, 11 Apr 2026 12:42:31 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI: release empty sibling bridge windows during rebar
 expansion
To: Geramy Loveless <gloveless@jqluv.com>
Cc: Cristian Cocos <cristi@ieee.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 linux-pci@vger.kernel.org, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>
References: <29a5ee31baf8be7d07617beea016c3f6d03934bf.camel@ieee.org>
 <20260410052918.5556-2-gloveless@jqluv.com>
 <efcba31b-4c5f-d4ec-e2e5-d01254c8256c@linux.intel.com>
 <CAGpo2mdZ6Ge9ZSYK4kKYJ7etBu5JqoVR-_G7jnxfZYhfQxxryA@mail.gmail.com>
 <ec0d287c884cbdd5131e1b09147b9b3cd56faf1d.camel@ieee.org>
 <CAGpo2meYZ+JmBo5veqF3tAexu+RevMMRmPgB5QjfZKncntYGZg@mail.gmail.com>
 <CAGpo2mfVV-UcTg2ST9jHC-irUDYEb=rk4yvf2AQc2Gw9EgyFuw@mail.gmail.com>
 <58b240e489d3a4d41e7dbbe5720b80c310700582.camel@ieee.org>
 <2fe254c2-38f2-4213-9055-43b810502ccd@amd.com>
 <CAGpo2mdvW3zL8p8kZCu2Q8r6kdrZ_N_YyMQkE-ayAvMrN7bh+Q@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CAGpo2mdvW3zL8p8kZCu2Q8r6kdrZ_N_YyMQkE-ayAvMrN7bh+Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9P221CA0006.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:806:25::11) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|MN2PR12MB4342:EE_
X-MS-Office365-Filtering-Correlation-Id: 061917f7-9843-467d-329d-08de97f1b6b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	VZR/zU3KLUvXVusOlkfFPH9oUbXeftmuN8N/vumrmLZU4lLgO+lbrDGc4XO9UpAgppK+mMNjry6aD8YgC7xw2oHBuy0m4UofISrz2+P8elBLqz87RyCa0iOn3OrWHrq0vQ+ffRZ56Pju0GpHkeDrFmREnZVsWDXIBf4b8NfFk1am4jCC42dVQlKvWudjWturraKlOm4dnBk8QgGCeVKOYcIDDXP0+GeqDTZV2qASoxauxYUZFkIgBNwf/xVFVZW0lA1l5LRQyJ4PHEig1iTg0jKM9HaD9GCoGC+Gky6oQYRZHkQaEnGeWSpeAQE1dqyrgYi/9nGIj6JBcDLNxefL6CyY4u+ktscIapz/Y/8SSnwRfNhZ65DOuDQOhXozM3yFHOqdeXtoGZenQLMa63AbT2+4XnzoXZ3fgRXFVXOBPaDU9LbDZFO/pYfes4DmRzx449T5OkKeFEFHOp00UVz+LwotFkQv0sQHbbshkS3iRelHIHHxIXl0uMhftfFSPQVgbuFqs03HUFG1mLccd91rx88QSB4472OcXPmMdmIluunoJFfYyoemsZgqBsVkc56blt2KKqxjdozvfLDOHsjrVsg+R6U+E3+mLRYLVtO+GA5g4EoyMW10gsSaLmAGuW3Q8LQ2KPojixI93xBLR5DUkrAUP5OsOWvQJWF92GmtEznHjqV/gn39UONJZA0yZ87CMDgjQDe9zmvTs8a3F3WQlDPQUrPsjg0YVPX8RcWRm9c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4557.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WkE4Ky9tVXU3ZElPWTlCUXJ5U2N4T3A0K1FBWGNVOUdCOFg3c2RWSmkyYWpw?=
 =?utf-8?B?Q2dMZXdUdTZaeENuMG9XSEMzaE44OUV6VkRwbXlsVGM5VGs3WXZiSWtNTEpt?=
 =?utf-8?B?Y01PYTQzbWlsWEZ1R0lmcjc3bXVBcGVBbzA4WnRLQmZOa1daUnVKVnRnb3lD?=
 =?utf-8?B?Si95NDVIU1BHSS9XSmRSejExT2F1TktKUFZMU0VnempNbnR2dWtkMWRnRnIz?=
 =?utf-8?B?cWtWTFNpRy9uVXdidFE1RUdubEQzOEFuMWcxM1N3d3ZGQ1BydGJGYnBqQ2tr?=
 =?utf-8?B?YnJta0NEeFRXbkkxSlFKMmU1ZzJDaUkvcHhhOW9RM1ZwRW5LdUxnWTMyZk8z?=
 =?utf-8?B?ZjhrM29HWlBHTDB2VXZ4a1BzMi90K0tmZzhIN2RlMTFFZ1llc3k3S1NZbTVx?=
 =?utf-8?B?NWhxdC9MU21LWjFLRlRxdGJqeFpkSkxvYVhveWc2WkxvNDRjajNTSzlqcW9E?=
 =?utf-8?B?TW54dTgxWXVncE54WHJtNnJNanRmQmNDa0drUFFXZGRHK0ZMUU8vQ2RsQjly?=
 =?utf-8?B?RUJLR3FEa3dLNDRxNTNYYS85MDBvdVV1RVYvT2ljUWtJUC9CZU10MFA0djNx?=
 =?utf-8?B?b01jRVhnbDhDUDRXWWpvTExMK0NmTXdwTjlEcHZPNUJJSnpLZy9samdJbmxz?=
 =?utf-8?B?Y3JqaTFYbDdldUNOYVlVdnJZZVVTQUpaY25KNmI1eTlCQW1tcjhWVW1aMVhr?=
 =?utf-8?B?TmZHSjVPaHhsTERYNnViUlV0bVBkTzBTRldGWVFpL3dvSmNLazJPUFBaTmRj?=
 =?utf-8?B?UHhwTjd3WlBvbVJ2cGlTeUJEa1hqNGd1dDI3YWQxSk1zOGZVUDEyay9LdGNK?=
 =?utf-8?B?K2FNanFRWWhFZ0NPQi8wWmhmNWMwMDBuOUF2cVBsZ1JVUEtWKzd0NVJob3k4?=
 =?utf-8?B?dlJGalF3eGROQ2Z5SDNhNjR1SEpmZzFpZzFWaFh5MFY0UU1kZllkRzA3Z21m?=
 =?utf-8?B?YnpuZXh1M1BpS3oxZ2MrT0ZmVHRjMjVwUDYvWmxQZmNDRFo5RTRWWlNBZW1j?=
 =?utf-8?B?UlFvaWpNM1pSdjB6U0NtK3dxNStMMVhhR296QndFekJFRHR0djBMNDZrYnlQ?=
 =?utf-8?B?V1E5QXVhN0M5YmtCd1hCTHBhNlkxTnJSZTZXR3MrTFllc1oxSDNyMVBUSThv?=
 =?utf-8?B?V21IOU5qeU1HRFFkcHFsOWlxVVVLK1p5YjVnUExPTzJpbllvWkJqNEJvL25I?=
 =?utf-8?B?bWNkSWFLaWtDSnFXcWNYNXN4bWdVTSt3WTVrUzh4Z1pNUzd6cVVheVhHK29n?=
 =?utf-8?B?SnNwYzRZb3lkY3RqQ2hkQXJWdXM4OGdLWlQrck55WDFpenBIRDVvNWpaK3dm?=
 =?utf-8?B?RVVtU2tsbHYyUHBhYy9oQm9lcWNMY05XQ0RMaHhBM2ZiSWZBdkh6NzhFZkQw?=
 =?utf-8?B?SzdzSEVnUXNMKzNhOGZiZkRWMUhhbE5HM0ZMSVh1c2kzWWtsTVJNajNFaUhO?=
 =?utf-8?B?ZHRyRU9KRU5tQ1NWclJnWDFmays3dU85blV1QTRsTkx6enJodCtncm9BOXJi?=
 =?utf-8?B?cGVQcmpDaUFwT3VRZzd6a09WTHF2a1k5VThyWlNLYXRiWlYxb21jSGVSRkpT?=
 =?utf-8?B?QmV3U2EwNWRKUExwTlVWU1Q4NnZwbTlRR00wb3NzcDVlM2xlOUhPclVDNGNJ?=
 =?utf-8?B?Zlk0SkttVFA0U0dnNWU1RE1wWStROCtaZDFMZVdUTno5ODl1eVo1Z2FDNVFE?=
 =?utf-8?B?b0U2UU9zSHhERHJyUHdHbFJFUWZIbkpmV0E0bmkvUGtRdWZBK1R2ekFZUEt3?=
 =?utf-8?B?QXJERDF6YXdWdW1KU2Q0TTRkbFZzV1I4cGhXbVFtVWFzNzl1cjZ5VUs4Ti9X?=
 =?utf-8?B?ajlvU0o3eXBGTEt0ZGhqVVUxbWhFU01ZSEVlNGdEeFZPMmFlUkZEUFlDaVpB?=
 =?utf-8?B?bzFCd3pJV1h4clozNXZIRGtHUnpDNTV3Y1M2Z1FUWUtwS1M5Tm14Z0h4Sjln?=
 =?utf-8?B?ODVweVhnWnYyc05ieGhRakdKYXA2N1M1SWdSWVlpaVFtRSs3VXlKU3dUZE5K?=
 =?utf-8?B?NFJLWTY3cndHejN3NWVBbWp5SVc5S2VLTngyV0ZBZEhEc3BhbDZUdVllMzky?=
 =?utf-8?B?QThTWnpwQ1VMTWIxelp6NU91WWd5cldOWmlPQ016cDJORVFYSVJwZFltSG8v?=
 =?utf-8?B?aTJuV28vRFc2MG5Wd1VhWDZmK2NROVhBbm9MZjRSUmdqZEdoZlNwTHNFMnFi?=
 =?utf-8?B?bWZ6c0szMFdYTERjanR0M0xNM0dxNVhzclFLN3F2STh5WmlMY3J6MStUK0xC?=
 =?utf-8?B?SWpoWlFXelpGZ0RlcVdSTy9qYm1ibEt5b3JtWWtBSFo2WHN3R29lOG5zY3gx?=
 =?utf-8?Q?zS9ExBbZfkDlFP6nFU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 061917f7-9843-467d-329d-08de97f1b6b5
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2026 17:42:34.3408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6ZIVmz9GtWam8FB0UqiTQn1156PHKkiknAgc0FrDRaJ7g0VZF1Mh5v1p4fYzyIH/K0JiY+dCkk0wtHiB7ZIsuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4342



On 4/11/26 11:30, Geramy Loveless wrote:
> Mario,
> 
> Yeah I would consider this a bios bug but it seems the MS-S1 isn’t the
> only one with it. I’m not sure how bios development goes together or
> who standardizes the ACPI table that would be the right way to fix
> this.

BIOS development is generally done by independent BIOS vendors (IBVs). 
These vendors work with OEM and ODM for BIOS solutions.  It's entirely 
possible the same problem happens on multiple systems, but it doesn't 
change the fact it's a BIOS issue.

> 
> I would think the faster way is to adapt the AMD driver to use the
> Thunderbolt provided function in the kernel to detect if it’s on a hot
> plug table port. 
 > Which would only work on driver versions that where> introduced 
during the time the kernel had that new capability. It
> could get backported / patched. That in my eyes would be the fastest
> resolution, correct or not.

We shouldn't choose a solution based upon how quickly it can be merged.

But in terms of a solution to this BIOS issue, what is wrong with adding
that it's thunderbolt connected "to the cases" that it was detected as
removable?

Then it can be applied to all drivers that use a removable check; not 
just amdgpu.

>  We could update the ACPI table during
> kernel load but that seems a lot more hacky then using pre-existing
> thunderbolt provided functionality for detecting if the device is on
> Thunderbolt.

Right - we shouldn't look at ACPI table modification for a kernel 
solution.  You can try this locally to prove that things work properly 
with what appears as a correct BIOS though.

> 
> I already patched the driver with the additional thunderbolt function
> call, I’m not seeing any problems at all. My kernel loaded with the
> devices connected and made it the primary display PITA but Linux has
> always been a PITA for displays haha. :) once done what is your
> recommendations for submitting all 8 patches I believe or should I
> just do one for adding “is thunderbolt” function call?
> 
> Sorry about the last reply my phone doesnt like text only mode.
> 
> Thanks!

I'd say try adding it as one of the cases to removable detection and see 
how well that works.



Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013000.outbound.protection.outlook.com [40.93.196.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59EA315793;
	Fri,  3 Apr 2026 14:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775226303; cv=fail; b=KMJGD3W6UbN+l/tK69Ka8bHMr1oCvx3i4M2lxkH+UlFM5SySrueGu4z9HCU8Lj/cdD5Bl0jAZUCc8CvLtzF6Z8Wn4e/sPOPRQ0216qyOtjG7ciV3bj+ExxDZw25xq0hNY89i47R0o/QWxDlJxl93Nm9GVrnMlenIryRQUIi3/kk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775226303; c=relaxed/simple;
	bh=UhbP1BMVP3m4krq/keRvu0Z85ub9T+38VoyJqe0D5rE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=R9ROVbzZnww98KoSOFrizQg2HHfTnqAm+qE2Uy4uq0rR0nxH3kRkL+PXYsurwrCU6oR7xEx4ueOB++uoFQ9yQw3rfvsTf2qFC6wSy5CIckGgDkoe4uZNOVOq0vt2FH4ONKwJON4Vru2vqge0LFEVElGnwitqMgeEgGXTqYcHxuE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lRCKNAdz; arc=fail smtp.client-ip=40.93.196.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lRCKNAdz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MzmMZwig2FrWqy2l/6xWPkU5oL8eqRj80VWp8TRdggUzvlyjZ+diCpVqEjvlAKytEh8FTKGsBul6huBz6ndwl9eUhFwczt2MbAmNxUlRgRLvRPYwh2H/Kcjzh4diL33JuEQlJF0ouxqrMmaY1Hvb/ZHNp1bdrwDI/3VXwHFAGwsORK0HfygcCxs3ofzp3bJO93PidG3Jc7e9ypnQAevtHLE78wxb+Pq7xHrwUJj2Cd07vtjI81Ml1aO09R4anZqEKfIKaREqv7KwnrgTXsnErMtHkXJxmgs0YXq//sWlLPnbt8YekL76Souc+Za0zW1ATAg99ewZOiVfMrHE6nhQPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rvHSAi0SAE6l94glfBSSIA7i8dfi5wBU8JTul+Us5xU=;
 b=MFHL+Juz0spAL4ukRUGadXsJuAjNND/GvQZ0wnU8pJRFCSk4xymTkBwkcCxmF6MU6/K41sqvTzJukSHUq9Or0J+TyTaA4LPTjeK9CZdB6xL7hNTl5x8AVsVYVsEcI8/2N1F/hbJGJYfqMc4RAAmER+fz3JuQJhT4JUJw2ypo51XM5qkFmdnwRQY353kcgC1K4T8k4e07KLan0m9GFpoubLuOyg+0BxTbdm0zy3TdH9EpP1oK30tqJQog6ixvo7IdnS/nawP1oTZUe14b3Uu/9E5IsQtolQNHTrWifDEMo/XN+X9KCrpPmQSw4ZhvQsvJxEWBLitHXMM0HJjSCnQ7yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rvHSAi0SAE6l94glfBSSIA7i8dfi5wBU8JTul+Us5xU=;
 b=lRCKNAdzGoTSZ2qAMOfQax0//fv/98t5bGMz7RTMQNfTLfgOqqlHN6Uu2YsUC5KazzrOZWtRgHISRcQz8fvjad0Bq2kQoOAFyrWrswqOOOPQn0Ja2te9O97UTcQMk49mR/UwYqBiRRvRcivxTITL2f0B5DFaxd4ClgP4ak4qZ5A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by SA1PR12MB9546.namprd12.prod.outlook.com (2603:10b6:806:459::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.10; Fri, 3 Apr
 2026 14:24:57 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287%5]) with mapi id 15.20.9769.018; Fri, 3 Apr 2026
 14:24:57 +0000
Message-ID: <867b2fa7-a8a4-44ad-aee8-fbb9d0555072@amd.com>
Date: Fri, 3 Apr 2026 09:24:54 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] ASUS ProArt PX13 HN7306WU: amd_pmc s2idle S0ix corrupts AMD
 1022:150b root port, NVIDIA dGPU returns header type 7f
To: Joyful Lee <joy@joyfullee.me>
Cc: platform-driver-x86@vger.kernel.org,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, Hans de Goede
 <hansg@kernel.org>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, linux-acpi@vger.kernel.org,
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org
References: <CADj6jrgK+sRXoNaYH90Rdc8DYEFK2iSF4vkJC=KE4UaZ73y67A@mail.gmail.com>
 <a935b2e3-e11d-47ec-af47-7eb7e86a9dd0@amd.com>
 <CADj6jrgcuz=Bcp0q7BHVizVeF=C2r_8qXw7r0Mc5X9Vd8uWK-w@mail.gmail.com>
 <4192851c-20d1-4185-9f63-32c66ed2a664@amd.com>
 <CADj6jrgse2NksUgkHUzTm0332ba4qnV=0QOJAnupS=Lr=5hh4A@mail.gmail.com>
 <4978c9b7-00bf-4562-baae-098bd0d09ba4@amd.com>
 <CADj6jrh2AT6vvQqujB5UN5tfcQ-qdDKjV_7fK18zsqkHpFTMzw@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CADj6jrh2AT6vvQqujB5UN5tfcQ-qdDKjV_7fK18zsqkHpFTMzw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR07CA0052.namprd07.prod.outlook.com
 (2603:10b6:610:5b::26) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|SA1PR12MB9546:EE_
X-MS-Office365-Filtering-Correlation-Id: fe2de54f-e03d-46e2-825c-08de918cc7d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	j3QaLf4MvZ04F4HRJQWg/CS6pt3dMbazPfrebLmtx5mj2cEqrNDxMC/uRoivKqrbe2YyQnIB5xfDhHvT/nc8Y6mOpdSF2/bfdoMSEfM/ZIfHbL9yDlH9N0jOqlcrRLT3EqY9iPBXLcdniC18uhLnBx1AuUj+lFqo1V9vwUsyE3vds8PwGBgunkOjy9nNYSYQcLNqm4u1Zbqm9galovt927IWjVENDwfSYpPBZh1tpWithyEtpsaFKF1YyQUjbfjm6Saf/9+onVfBHPyIQYRbtn4g445ivpXOvemdR5azk829tNeMiCr7S1yq2g02MJ4ZGQMYHPijiDVQB45Y070xGOlu54HXKhHuDUv4zrhrYzWar4QONwY1TiK4qs4kSrsziG8n8hlCOtSpK6z9haaLJybQ4ZiyUYnXgrwRJZ4ItMYlAd+NVo9lEcCRFvgb5gLAfC4HrvdlWVOnFlByQUktFLhH7HXM6dpTjcNQl1bbD2XXKXqrD3WMOyISIg4GtzMDnHiLp9Ei3Ek6yk8kHY2f+hNfK5CgO+AY7/EuBjmdPWIfb6+4khfMwW0gXWKi6Pw4/N1nyyDC864KC8IFLkUSqghomX7kkGoJASj24aGGGHAZFtcZJY+re/Xpq//l/ubNyJYimgmmr7GT0QaLomqIy64hanY9PxwYX+8cQ+zuT3IcuK59xznNA0JCF24qh3liGw0ZClizZdOLKqh1CsFbKT7hfQlpFx0rrAK0AUDwlzs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4557.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R3hkRzB6Qi9vK1g1VmNQeHZhR2orM3dVQnRaQU1YaktzWW93b2w2NmVyUXdU?=
 =?utf-8?B?YXZBL3E3UTI5RUJPb3NUaGNHTGlGbUNRdmdHOVJnMEtLU215a2lkeTZURjdU?=
 =?utf-8?B?MzN3ZG9VOUlFNzV1ZVd0akZKZ0RRU3ZwRnB0MlIxc0FpQUl4S2hTV1NSVHRn?=
 =?utf-8?B?cFEydUkzUWJMQUphd2NiRUZKMHpVSkZpTEpWdkpaWVM1T2hXeVcwdm13cGRD?=
 =?utf-8?B?NTM4TDhYY0ZFREltVG9tK0hrc3FJdStjNG5qeG9NQllQbFZMM0FPSTE0MWFZ?=
 =?utf-8?B?Z2ZJVFQ1NnZLTHNDL0xMVkw0dFcvYkRJT1g5RlhvV25NVmhrelg5bGtvUWNG?=
 =?utf-8?B?RnhKRzNCUExuNmVMZ1NkU05DS1hrQnRhNEZJV0xBMnNGeS9ybzJURTF4blRM?=
 =?utf-8?B?VGRFYUdNTzJBcS94dml0QW5SQzJWb2ZpOE5iSUhHdzVkVi9XekkxSG5zaW03?=
 =?utf-8?B?aEdkak4rVGlsaldENDF1NVlVemJOSzZ6WStKaVhBTW9MWDN2dnEyeGlJYW11?=
 =?utf-8?B?MkVjbU9QUzdyT3UvYTduampzY1RpdG1xdGN0VkNvVU5Yci9La0tEN2VhcjlW?=
 =?utf-8?B?aVI0SWpHcld6MXQvaTA5S2VOMXRjK2lmbjRDRmZPcTBUY2FIUDRpRVBGck81?=
 =?utf-8?B?b0MrU2RBYkd1T1BqYkdFQjlKc3hDdVlRV1NjYTdjQjZ0UUd4bXY0aVo0ZEU4?=
 =?utf-8?B?bCtseE9BM3VNVkhoWUMvQllsYkprZjdqb0k0U3A2SUxhMEFod21ia1NIWHRZ?=
 =?utf-8?B?c2RkSmVrcXVLeGp4Njk5UUpuK0w2b1FnUE9rNmlrQVowZlI5V2VRMmVBNTJn?=
 =?utf-8?B?N2lmVkFCZFB6Tm5kQWFldGYrNHFZL2FCN3YzTUNPTW5DTVFqYmRwU2hZZ09S?=
 =?utf-8?B?RDFHczJrVUU0aE5kNk4vbEtDWXJJMkhvemw0cHl2ckJCWk9lN1UwVlgyMGRR?=
 =?utf-8?B?NUE1ZGVCbk15YTJvUFVWaHJzeWJ6bFRVb2ZvTTc5ZzJKenhMdlg2RzZ2cmtH?=
 =?utf-8?B?UkFib0h0U2taNk9xTlpSTVF0RURYNk04WFBFZjU3bWllR1FERjRFcDdtd3FC?=
 =?utf-8?B?MHE4cFd2aGJKdHhZbzRwbG16TXl2UzlCL1BlTUpuTTh1ZWRkZ3FoL2VHOEJE?=
 =?utf-8?B?SHU3L0MwQ2VxR1R0U1RyaW9ONUdMb1NyVTZ4MTRSWmNlQ2xNVDNDQVpXTitM?=
 =?utf-8?B?VUpzbTZDWmRZK1phaEgvUmFZQTkxdDc4NXNGT09yc2ZIT0k3T3h0eTUvWHZ0?=
 =?utf-8?B?NFYrTjVWRVNkUVV5VHFvSTRKcWtBRXNKRDFYUjJ1S1hsbVlHcjcxcEJ4eEth?=
 =?utf-8?B?ZFJXMERRL2Uxd2FNVVNvWVo0TmYxVE4yWkVuY2x1VVhaQ1NWcXVsVmMrdURj?=
 =?utf-8?B?eGs1Y2lXeDFSbkZsZ242eGtWejZaU3BjWjI5OTEwTWszSXNtWSt0dUJ1NitC?=
 =?utf-8?B?a0ZEUkJDQThYWXBTazNoMEtNaHgvMU5YVERTSWRIQkVySTJKZit6OXJJZHhm?=
 =?utf-8?B?SEhPajRrSmRLTjk4U3dJMFdhNmZEbHlENEZGT2FlbzNZSy9aODBxRytKSU5s?=
 =?utf-8?B?eEcwbWp5cU5rYnovREpqL29JQmxLYXZVeGR4RjY1YkNYMWw0SlFMdTRxdVhF?=
 =?utf-8?B?QXI3MXRKelRhbVNVdXIxdDVlYkdYUlBNVVJRS2xtMmp1Ny8zN3hWVUJMclVB?=
 =?utf-8?B?R0Q3OWxXVStxVEpRYks0cDdJMnk4YUlDcytHOGU5V1RibmZwdGtTamJEeVpO?=
 =?utf-8?B?ZWlXZm9RWmM4bXVSd3MxUkhDRDBta2h5UjV3ai8xZzhtS0VqSWlsZlhBMUgw?=
 =?utf-8?B?dll3VXZFMTI0aG5UMElJQWIrbTAzQk9MQzNRVHZJTnN4K095dzNZcS95NitQ?=
 =?utf-8?B?UnZ3VCtLSXlWUlpnTVFOZ2hGZkx0eHBQUUU5Tmkxek14c2hjdU1paE5kMEZq?=
 =?utf-8?B?SmlTM1VVMlJTTnJBMmh0S1QydUhBQmc5dXlMbkRsRS9JSFlHQzNzZE5nUFZh?=
 =?utf-8?B?REVZdXRoTHQ2Ty9NOXIrNndDY3AxV3pCVVZNdVVsV2JJMjJjbi9QK2lEU2FU?=
 =?utf-8?B?L1JweEhpMkRoRit5eU5hUWE4TFdUdDZnb1ZnV3BJUFlTVWI2ekpPTS95cDZQ?=
 =?utf-8?B?V0hIRFFqWkF4bEJzUWtqRE1jTGwvZkVpUG1ldVM4a2s2d2VuOEsyU2FpNjQr?=
 =?utf-8?B?RFd5ZEdaV2RWa0NTV0NpWDlWc084b2xNUFlkeTRkZ0tpbWZyenlMQWl2a29r?=
 =?utf-8?B?WTJ1NEp2NGIvUDkrSFVETjNTTkNtWUJDUXh5RVY2Y2hqOXZTVFRSL3N4VVN2?=
 =?utf-8?B?OG1vc1BsY0J5R1VOajYrZldTTU1sMFdkQ1NRYjQzWGExT2hsSk9ydz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe2de54f-e03d-46e2-825c-08de918cc7d9
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2026 14:24:56.9179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qMIB54zN3qaWQDRyY+JfwqAnjogUtKJ7GH0sg/txNt/IwSS42/4ltLPejN2fvwg9r//qZkv4bFGLZElAWikX+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9546

On 4/3/26 9:11 AM, Joyful Lee wrote:
> On Fri, Apr 3, 2026 at 9:23 AM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>> To your questions in the original post (again sorry for the original
>> knee jerk reaction):
> 
> No worries. You are right to be skeptical.
> 
>> 1) Yes semantics of how AMD-PMC works are correct for this platform.
>> There are lots of other Strix designs that do everything correctly.
>> 2) Yes; there are FW dependencies that are design specific.
>> 3) There are no quirks for working around this bug you've found right now.
>>
>> I believe this issue you're seeing is likely a platform firmware bug.
>> Whether it's AGESA or it's ASUS firmware is unclear right now.
>>
>> I have not seen this specific symptom you mention on other systems
>> (including AMD reference systems) so I am /leaning/ more on ASUS firmware.
>>
>> I notice that the BIOS you have from ASUS is quite old:
>>
>>   > bios_date| 03/18/2025
>>
>> Any chance there is a BIOS update available?
>> Unfortunately ASUS doesn't always make flashing in Linux easy, but
>> hopefully you can find a way to flash the update if one is available.
> 
> A firmware issue is what I was afraid of. That 2025 BIOS version 316 is
> the latest release for this device. I'll reach out to ASUS to see if
> they have an unreleased version they can send me, but I'm not
> optimistic. I'm still in the return period so I'm feeling a sense of
> urgency to either fix this or move on, but I'd rather try to get it
> working because it's a nice little laptop aside from this issue.

That's really unfortunate to hear.  If I was in your shoes - If not 
solved by the end of the return period I would return the machine and 
purchase one from a vendor that has been testing, fixing BIOS issues and 
supporting Linux.

I'm not going to pick favorites, but Dell, Framework, HP, and Lenovo all 
have offerings that they do this.

> 
> Your first idea that the kernel could be racing the firmware prompted me
> to try a few timing hacks--really just shots in the dark like inserting
> a 2s delay immediately after resume prior to the kernel touching the
> devices--but no luck. While I'm waiting for ASUS, I'm happy to try any
> other ideas you got.

By chance does the BIOS offer access to "AMD PBS" or "AMD CBS" menus? 
If so, there may be an option nestled in there for dGPU D3 behavior.

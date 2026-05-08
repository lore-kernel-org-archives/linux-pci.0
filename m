Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010053.outbound.protection.outlook.com [40.93.198.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D3330BBBF;
	Fri,  8 May 2026 16:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778257651; cv=fail; b=WhcwC90Th7vTEq4Yel/XYIYF57W82bFB+wkHLT6KXxOn6B/wZgQ1v48pn0mXZtUgiW7RM0YY6f1YjURLP1+hwV0gBXqIQBpTyqXAX/5nPGAR5B+53dKVCn2/kJaRxeDnZNTJaoMwzDWHw/hPFFr3EjXVi3UXTN+bCDNuKROymO8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778257651; c=relaxed/simple;
	bh=IPrhcqyUCxiuRWFEFEyDBBW2IZK9/gr9I0PYES++Muc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=n206W+kosyTIV8je2ikl5jDvcMD/rNhSq+OQxj5igS6NJCQzWf7Xar+fj/PKZ8XqFb2q7GCgiiyDBjsp03jVzUV9V9nKWARdF+llxoqdiMncCkY3InONl4fafUUpcO7hiTXErcicHf3TrMEyT8Aw02TfGpWJvR40oKXiUh13Cco=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BiE0iZ6P; arc=fail smtp.client-ip=40.93.198.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BiE0iZ6P"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XvaYN4NQavJcV4B7M5g93kh6MSydAdE5ARbp8pTqasPKM7p4MsjqVLgs9uEXSTgcwUAJ4cNQU92Kx83451k5ctLbSktA7/jGPGXy0HeQc7cAta5ZxoaKOPA0TnrZ1tslWu2dlSk+A8+jt8Djq2iVhobhx0w81hYoVzkYoJVU43o7slESC5oBUKB7E9k2qFjgzFLB3Qo+9+IwRnVP+ZK0Oh5L0gkDuR4FRD9n6K8/IP4T3Bnu7sVlS2xMCdXG1h+61W9ks082U6KxzRiFBrjo0D6NOUSJlP1p5SKsCNbio64QwdUxuRPwavDVcgBrE00CkthH6N0uc0nBiyF0FAq+zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xajWmA05dYFXq3UBkGXuWAxwfZZ7SIk+8PygALyOHP8=;
 b=rCzPYo0YQgcme5A6MP5F9SyXIAW1UP260S8irKYRGU2zy1CVpEajAi0ffZ/WDqG3qJ6+s604wf7LIcOlXdVXvgf4j3TB7cDaXybrf0VR6gTLGdnIy8AbUyRXIUBoBnwgIPwKDNi+RyNJuEwf0uS1q8GjKxl681ZAsdejycG/ofs4aLT/+OaQho/XyLmIr1fpq0yfwMgg1tWK7CBqCYj02Yl4fpiP0cgCveZhTrIKkoTHVqA4clKKOsb2ZQLxFrrXSti4CnGorZTF0cehWrsM9WHlF97H/7qDj3FWT9gM7WQ3HtLRUukekfgzKYlUSAe+oWDfnBeWtwWU5Inr01+lbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xajWmA05dYFXq3UBkGXuWAxwfZZ7SIk+8PygALyOHP8=;
 b=BiE0iZ6PfblQv0DkEY/MhLa5wMgYJWstaTeWg8dyZ6JZVKg1Wh66Fhlojs9ViJB8k7ODWnGG8PTrlhoCOubKgIlYchH6XFohUC/VQ29ju/lQHe04JhaHOer1608y9Oz1LDVSWXywNY2bLJVCD4Gu/b4EtSbx+tWQfeIDk4x+7Us=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by BY5PR12MB4177.namprd12.prod.outlook.com (2603:10b6:a03:201::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.19; Fri, 8 May
 2026 16:27:24 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287%5]) with mapi id 15.20.9891.019; Fri, 8 May 2026
 16:27:24 +0000
Message-ID: <70035490-eafb-4610-8889-9e04931c8b32@amd.com>
Date: Fri, 8 May 2026 11:27:21 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] hwmon: add AMD Promontory 21 xHCI temperature
 sensor support
Content-Language: en-US
To: Jihong Min <hurryman2212@icloud.com>, Guenter Roeck <linux@roeck-us.net>,
 Jihong Min <hurryman2212@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mathias Nyman <mathias.nyman@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Basavaraj Natikar <Basavaraj.Natikar@amd.com>, linux-usb@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1778123510.git.hurryman2212@gmail.com>
 <0c35058bb088213397b42fca8d51e9ad0bba5169.1778123510.git.hurryman2212@gmail.com>
 <35c2436b-d172-4172-a684-a96c4a0dcabe@roeck-us.net>
 <16c4f7e5-e33d-4271-a7af-5d6c7fca0570@icloud.com>
 <6745fd21-2001-4e06-af41-96ae63154c02@roeck-us.net>
 <198ae20f-49c9-4f81-87e2-e16e81053f08@icloud.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <198ae20f-49c9-4f81-87e2-e16e81053f08@icloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS7PR03CA0177.namprd03.prod.outlook.com
 (2603:10b6:5:3b2::32) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|BY5PR12MB4177:EE_
X-MS-Office365-Filtering-Correlation-Id: dfb10e12-ebe1-4e19-2786-08dead1eaf95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	RfUTJvNyFnGomcX/Q/F/Myzeiv2n1PEgQeT/7cvx+42eOj8Xxlqv3gMapaXu0OCV5H6/6LuTpcjtPXLV/Cb9+DZ8QEX6FXkfbmxrPQMsqpKZQPoVniszFfpKbga9Eh6luUhrzdHzR8XgIb2ANiZ3d2QbYOn1fcSwfrB7YEbWpX8TwaZOvJQgEYHUOob0qZbYwN4yJuz/LAABRwpuHSgCAQfpOFqGsZD2F/098Pkf7yIEYpMJqseybdQ+fGAHGm257RJsQ3WSkRuMgE8URChM119gHBEKZ21KueF4lOF30tVxOYsX1L9oqaTQsEvMnMchnQuVO0axEz8+czdFNe2zoPKmyeAbPFRQBrY82c2LTQovM2DeJNx0NDc4PyDPwdBpKyBBFyf4SYEa5oW3roRVls/Wsp4ekxr4K2vsjBAkOKc0bNMzyCYypqXwfX7FDz4sTb9wsstm//TUlA8SZQiJ8SXnLmI7hoyPvklMo4xti9aeR5Q5CVwCkPAiEheo8XvBSMlpYltBmbdCoQh/V5oKjd9hh/no24/0ePxJ2pDu3ncVNEekOQ4AkeBzVXLpCfAxFHaLPKnZPyJYhFg61mz0x9qjVUjpkVabcTICFO/7LZPSj7huYqrTVYKNeSe1/6rwpCKKs+hx4c9+3pOiO/MqLA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4557.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eURmNUpIMWZYK0J5NURoNkU2cmJ2ZTFrUDhQVEdJdmduNGhPOUorTXRGUkdQ?=
 =?utf-8?B?dDg3ZWEzbEQ2WXBWT0MyS2V1VGhQN2toNVo2RlJVT3hsSmNwUzdQV0VJZGp6?=
 =?utf-8?B?em9yVk5VMXU2YmhaM0J2N1VYVFozM0FEU2pEbmZFYXRzbHNRaEFzTDRraHly?=
 =?utf-8?B?V3VKMzB2K3gvNWorb0xwQXFVVU9NYWdyYWxTaXEwQ1U3ODRJUFJsRmd0UDdk?=
 =?utf-8?B?OGliWGFMamw1YzhLZWVZdWxhWDQvaWl1aTNxazhaOWRKSXBMcGQ3UnhyNUl6?=
 =?utf-8?B?NXhOblF6NzdvczRzQnhheWNVWEY3L2Q5bkF2dDlyUUZGbmp3WnM0NmU4SVFw?=
 =?utf-8?B?T2M1bkpjUnJRVkNHekpVa2pnQXZld1ZldzVNYXUxaUd5UWxYckg4QXFyN1M5?=
 =?utf-8?B?Q2dOelBKSVo3ejh6OHNNQXd4L0Z0OVRWWGMxNisyZnpSSklLdmc5R0RHaU1W?=
 =?utf-8?B?VlpVWjVvaHh1YWtra0JYWnBSZ3NaVE5CaFhPU05QS1JIZ1JQUzRNZitteFM3?=
 =?utf-8?B?RUJyN1NFSHA2eDZtSml2bUw1YzhSSjYxRWJpZU4yZ0MxRGd6RGFjWkUwNWlh?=
 =?utf-8?B?UmRWSkk1dGVlMTJML3hFVVVWK2cwK25NOUd6bkdMQ3RXS0NXTmxpdm1JNVJ1?=
 =?utf-8?B?djEvUDlXYVNqWlQ5MVpncTFQRW9hNDVMSU9JNjArZVFXRXlsTkdrRmVWaElo?=
 =?utf-8?B?aDNSNGdLQ1RSaFRYeG1TRHBWYWRtaENNMXEwN0ljVFE4R2NpTnFNalVnSk5k?=
 =?utf-8?B?UEQ3TDZFb0dIdnZjNGovZkpHZjdReG13NFpndkJZblZRZEJDOXgzSnpiZzJi?=
 =?utf-8?B?dU9UaHUxWlc1S0xnUCtEOHhWcUhETndNbG9QbGJFZHk4YklZUzN0eGJqVVNR?=
 =?utf-8?B?RnhtcnZpMHhXbTJjM1I0RXBIbGRaclVyQlhDalRiWTV3RjdYUHptenVuRVFq?=
 =?utf-8?B?OWNkQi83aU1vU2lUalllc1E2Q1Zvb0F6TVZCaE9wWld6dElTTjcwSW5PQmtI?=
 =?utf-8?B?cmk4VjA0ME1WN1pDbFByYk5aM24xbC9PVGx6RnFVcWtjVTljYklyWlFLN05H?=
 =?utf-8?B?KzljczF3bmowZ282Q1BvYW9pcExmMXNtZnZKRmJzazk4UEtCOW5xMW9Kb3JO?=
 =?utf-8?B?Rk8zL1FtcXJ4SkZXVDM0NTA2aFJFcTZtTEVrNWZJekZOTTArcWFtQ2pHOEsx?=
 =?utf-8?B?ZEJxNWZGbThUbjJBeHBtTko2RmlaU1VCdzRMalAzN2t1L1UwTG50U25HZE50?=
 =?utf-8?B?Yk1rZ2tBVWg2YmRnYWZsTlhwcStqVkhMa2VXalNzTGhCUDU1cXhSRS9nNjRj?=
 =?utf-8?B?Vi80MlpFd2lOdWNxeXNCbjBmRVpyUVh1dndPekEweFNDK2NOS3hZd2lFY0th?=
 =?utf-8?B?QyswMVRtMzNwVTlDV1ViRlpnZFA5QVBzb3RkcW9rTTU1dG11Tk9GL1V1MFcy?=
 =?utf-8?B?bTBMcWFvK0lnZ0tVY2U2RWliRmIrMjdQdzJGcnlCNHpMK1BVS1VCNkdrME00?=
 =?utf-8?B?SzBzU0NEb0c3UHhROVJEaWwxRTZYQlcxSzRGSlVaYUdWUXRzMWVpTXhFYnVH?=
 =?utf-8?B?cUVtQzkxU3UvQjhmcHRXN0d5K1dNM0pzbjQvMDZrNnBDZFlrTEZQZW15OUdw?=
 =?utf-8?B?aXF0K0swRHRuYmZkNEhlK0hybllWM1g4UWdlcGlkR2lVVHdibGxtTWQwekwv?=
 =?utf-8?B?cW5qOTFGeXd3dDFRN3BRL3VPVVBxRE5yRkcvRTZLVG1jb3dBc1c1WUc2dUVu?=
 =?utf-8?B?WUs3aFBVaGJsUW1WbVJKQW1oWjBwM2Vnb1FyMG9sai9ndmYxRXhHRW16bXpQ?=
 =?utf-8?B?czdraXMyUGxPcGF4T0pWOVZkOTV1emhibnlDa3NSamZJYmxLSmg5K3lwaHR5?=
 =?utf-8?B?cXI3cnlHQzRtRExSRW5mMHE4cjc0aXZ2dU1NWWJwelFqaVlrSjYyVEl0Y0JR?=
 =?utf-8?B?ZWlxNjhqNHV5VldyQ1lGYVpvd3lQSGh0ZDBtWnJjWHJ1Z1N5RVRiZW4vYU8x?=
 =?utf-8?B?UDlnZ0tmTXNUdS9OcTg0VWRtNGI2Ulp3anh3NGljOXZoUDFLODlraVJYamtm?=
 =?utf-8?B?NkpPUk8zbUVwMkYwOFNmWVp4RFZJa0VROWxjZHhlQy9ObjRBYm5HMVJsd0RZ?=
 =?utf-8?B?VFljalJuUU1JOHM0bXhudDJDRHhOdVhZVE1jWDlsMnVUMEhQRGF0ajYvTDJt?=
 =?utf-8?B?UThmcFZnRUE1bVdNc21nRk5Mb2VYTDdMYlRQbjZ0SnlDdjlKTzBZTzduUVNZ?=
 =?utf-8?B?QVlMb2F5ZHlRb0FyaDBpa0NRM0Jtc0Y0bjBNV01jZnNGWGwrYzhRckVGVG1y?=
 =?utf-8?B?b2dvQWxsNVhJQkRPVWlLT1VUTkRNV095czR6SDBBMUdNeGtQVWVYQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfb10e12-ebe1-4e19-2786-08dead1eaf95
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 16:27:24.2826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fkdmyoDZPKPpK6UYdLa4xzFTVVSjW2Rwi4u0U54fLxQKeuB+VcPBvk73rxeotqFbliMYcRhXqgB95/1a2B5xSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4177



On 5/8/26 09:21, Jihong Min wrote:
>> Yes.
>>
>> Please note that you keep top-posting. I don't mind that much, but
>> top-posting is (sometimes strongly) discouraged for linux kernel 
>> discussions.
> 
> Sorry, this is my first kernel contribution and I was not familiar with the
> mailing list convention around top-posting. I will avoid top-posting and 
> use
> inline replies from now on.

Another thing to mention is that you are going too fast between patch 
versions.  All your patches show up in a ton of people's inboxes.

It's great you've gotten feedback on them but I suggest you give it a 
few days or a week between versions to gather more feedback.

If you haven't already; you should take a look at what Sahiko finds on 
your patches too.  Be sure to look at the feedback critically and take 
it with a grain of salt; but it often finds a few nuggets that are 
worthwhile to consider.

Here is the Sahiko link for v4 you can review if you weren't already 
looking at it.

https://sashiko.dev/#/patchset/20260508143910.14673-1-hurryman2212%40gmail.com

> 
> I have addressed the review comments in v4, including runtime PM behavior,
> temp1_label removal, -ENODATA return, the PROM21-specific xHCI PCI glue 
> split,
> and making the PROM21 PCI glue built-in only when enabled. I also 
> adopted the
> naming scheme discussed above:
> 
>    - drivers/hwmon/prom21-xhci.c
>    - CONFIG_SENSORS_PROM21_XHCI
>    - hwmon name: prom21_xhci
> 
> I will send v4 now.
> 
> Sincerely,
> Jihong Min


Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013059.outbound.protection.outlook.com [40.93.196.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF4A3AB26C;
	Fri,  3 Apr 2026 13:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775222627; cv=fail; b=Uxto+joQxiprxRcFCnoWpi1DFNWKAPs1nSwD2q+vNaldSv43/YNrb/I6CGFrPIMwo2PyL7Qxlufm8Gs+l039r2RflSDxrUpZiYjHehQAcAB6F7a+AzQMLqDEh3OLgaz8JUpOz7jWYLwhMgLHNUmbz7w7smbYIQZFlIZ27GIYQWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775222627; c=relaxed/simple;
	bh=bpECJ2n4t7SoM4N4woTzlRUUfPSyABFOM7MFnBg+s6M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Fxan/3VY1JVhMNyFlmPGeqV74Y1ZbzY+R76BhviWYMhHnqcQD3/S1HZBiD8tz4GB7/vzFY52gZxxv+UtviXqbhjOjEskDXB/vAxutMpOPihe8bmASSlfAEZ7lxvfvRmUqszZskfaODU5MimT1Ddcuw+lGWZA/3hTXOK9wxDIzPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IEPw6v8Q; arc=fail smtp.client-ip=40.93.196.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IEPw6v8Q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uoZ14pLlZICmdzWKH9dNxkrep9EkAggCyjAHHtbW9VihZW7GTyc9OJ2nPPIlatzkKlml/oHA2/ef0x9kPtz7gcN3PG4yx29SbGnhnhyP48Z5Gz8+Hitk2njqbg6+42FTEGR+SDK5Tu973kJtFvE+owVoDGd3ITuVFnHNVdU1BsLOLQ1JJtA6lthJFJOKgfvh0jeRpBiOjaHSr3RbdkPbF2WrNsHg+x2Cv3NCbUkORZBnu+M2q2y62S1mj+eI6QcX8stH9iULnY7SFOUIYiZ9aBksIu33rMSKXFf4RnIEcGXClIRfApnVe7J+Eygp1kOEZarpO0f+ZfG0yiA5GSbbxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z+RPGj5zuAJgN5ZHITsaQeOEYhN/vSYfCLbgow2M3SQ=;
 b=lKgCfRKWG+wzU4kde4Mo4UutKWVmxwDV6uLwRfC0FV+NjpW5zc2MVeS3A+8EPYiI2rdrkPiUj2pZY5++25cMwguZCEKpLJubmwKdjFvNJQOB7nLGbsvzW4UOCXG/4JrcEvrDuqm7/apknFi6koahK2cd7IiYYBh3B5pyUBElF7lmiFqxw9mWS3RBO3sQNi+Ehrf7RCvp+wTDL7J1TUZFv/J6JR8AE+nCJ67T8TDhpXYHwQ2sBJ8fcQgzhHNVHI6yHgz2qUGGsN+m4FoGaV/jRF3nOygMuU2VMEAhsjT8liBwzwgVZCjOyNZvLtCTCC69ykBxt1p8xrizjrZuoTc0NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z+RPGj5zuAJgN5ZHITsaQeOEYhN/vSYfCLbgow2M3SQ=;
 b=IEPw6v8Q0bqRfa2mQwyF53KzzTU51qhNYSsLMCYQBF8/IHTCl24VIOObvsvp8IVPeoTjSkOt2MzQznNH3oFkv5oR0gJZgrV91e2kMImoRj++GEfjsRurVoI2CajMUsmeR7NpVpT1sobkIcL/1Ph3zbSQOZKUbc1lfDcH9sXseEs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by PH7PR12MB9222.namprd12.prod.outlook.com (2603:10b6:510:2ef::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Fri, 3 Apr
 2026 13:23:42 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287%5]) with mapi id 15.20.9769.018; Fri, 3 Apr 2026
 13:23:42 +0000
Message-ID: <4978c9b7-00bf-4562-baae-098bd0d09ba4@amd.com>
Date: Fri, 3 Apr 2026 08:23:40 -0500
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
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CADj6jrgse2NksUgkHUzTm0332ba4qnV=0QOJAnupS=Lr=5hh4A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS7P222CA0016.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::8)
 To SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|PH7PR12MB9222:EE_
X-MS-Office365-Filtering-Correlation-Id: c7073c3f-95d0-4a12-6c79-08de918439ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	6kqPsO/NC0vsXvwIcJJiHDivirQoysp9nbewvfDNm/smcC449Jo0ibV5JpNi3M0dnxhBw1CpUzUu8pvL98OzK47z7qC30XAe50jeuU13eufBGaMWG0e9xmP44IWsAf8NEtRUTuwErXSb5FMuyNRxzN6giMcCUNc53CUDY3QIy/ddDi7xVtl5N+NT9bO9S6gUpF+cAuz89A9OcfX3girCyH6jI3s04c5UANdT+4fPQ5qbFAv16aRVZ/t9VaGKRDLoOXkfslXT8cKEiOGCNcrIKZfPBzpjz2MbycUHR9WtinTRC57X2TMpGv2U+1YtM+g1px66v5PNlz1ACdXcjRFX9jbPT+SHy1ZIZjbBk+U8wx+qIkRyzEsujJFK5BFG2ijUuzINt/lvU4wIWoXdlo5k1KTmO8NvKS8+MT0Wfkl6QQppJcWxFsF0FOYX86OaTaFy9CmQYD446J0sKlkex9bUXGLVWVFKi6O4J9GLijLuLr1fFRZJ0gEiOHUG0+v8HensNsh8rgHuGOpsFHBWNHJDbK7U+CIGjkOX+vs0Bb962zM+n1ulZrYExHZR7cqBBbSBxt4xF9UAClnHc1Ux5VN8UwYWOipqYzevBbpnSX/cXAPCd47BwyTHV1D1kWAET4N1RCSseewPtdmHDsN4NdxlV7dZjCPz9GKg6UZmSSlgtXxkAyXMKqZZvs0+IfrP6K1EjYZKLk/D6MfDmiiCT+iBtgzdWv+pfOQPLdvpV8DvM3c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4557.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R0wwTU9QS2NQVlhxNWE4clNoc2FoUXdxZVFZTlJYckJIeTA3MUxrUzBWRTFy?=
 =?utf-8?B?Wm92dGlOSWpZS1g1VUhNRVFNT3d6TlVmUzdzeTlsYmNkSEF2b0EwZ2ZhUUpu?=
 =?utf-8?B?NHFteHAveHZIYnJVTHNPYzdhQlpidFlvbldUMHlDVmhsSnhraXF4UzN1K0l4?=
 =?utf-8?B?TCtaOFBNTUFjU2JlZlhiaUtWR0p2WC9Mb2w2cTB3ZDkzbDR6aVoxYnJ0T01G?=
 =?utf-8?B?MlBmdHIxaEdqZXVLN3BGYWJQcWx2UkFROXlxZHV2Z3BPM3Mrb2Yvbmw5WEFH?=
 =?utf-8?B?aXIzeHc0T0VEcTFYeGJRb0hHSjYrTC9PSU80NW9zY3VBdEZ3V29uZlE5d1ho?=
 =?utf-8?B?MTQraGc2M3V2dW9uQjFNYkcveU8xSllNVmtBQWNCbjl1V0tDRVhhcmh3Tmsx?=
 =?utf-8?B?T2l1Ulpva0xrZXg3VUdDVldZTUthdk9DZGxjc1M4cjBoUWljQ1Fja3JwYTVn?=
 =?utf-8?B?NmM5enBLZ0EvQUNXdVB2cDFMc01vajZvbDFaZ0QxVjIyb2JOR2xLUXFuTUFu?=
 =?utf-8?B?dlY3SC9XaHlZZCticDFGVE9YVWZKNEwvK3FvUHo4b1ZNUHRkbmZlamtDVk9E?=
 =?utf-8?B?V2hzN3BoSG8rWHJKSnF0RnFhdEhTUUhNSElRU0ErQy91ZGtHQWhvRnFieHcx?=
 =?utf-8?B?cUllc0xZanp1RUNNeWRIejJ0MW1lbjRtZUc3UTBJUUJmZ24rTGdxcXB0VE9Q?=
 =?utf-8?B?ajJaVkZDRXE3N2hEb2orQUpndlVEQmJnSWpMUmNtZXprZUI4eFR6VitYUmJJ?=
 =?utf-8?B?eFQ1Q3Y5d2hYM2VUZlIzV212ZjVhaEFMKzJBS291dkd5MUw2VWlUb2Jza0ln?=
 =?utf-8?B?ay9qZVFqN1JRTXg0WFhqY1ZZNzhyYkZxK1Qyd2FOcVJlN2RPS3V4TVc5ZTNH?=
 =?utf-8?B?bU4rNzZvaFhLRVZEUUlTZXg5MzVOeWptSm1od3dSOHJCcW5qZkxFbVdkbEpK?=
 =?utf-8?B?eU1ZWXphVlFqYldsZjFOdkxzYnlXZzkxTnRRNkFpcDRYdDU2MldIZnZ3SWpr?=
 =?utf-8?B?UFVkRXhLSk1mZGg5aXM3VDJRSGRWNDRKaVN2eXV5bytnY2UzdmNTa1IwMjVu?=
 =?utf-8?B?K2I1ZUZqTjJ3cjdWbndBclZqVFg1TkRPcXBvUlJGVU5Na2xKTHBCUndkZ01w?=
 =?utf-8?B?aERVRUdIRkdHQ3Iwc3lFRDlETTIwSUFVMCtHcUtqcjI4emNwWUd5VkJGNEhQ?=
 =?utf-8?B?Ty90V2svMzd6SHBXcTZIbW15STFHNU9RWDlSbmZWTzc0c1R3QjVGYVo5MFoz?=
 =?utf-8?B?enNYbExET3loY1p5akU5SWRKUTBYN2JlYzFEeFBNejdONXJLcWZDSFFEVWc2?=
 =?utf-8?B?OERjTGhvVVkwaElkMGdDeG9HM2NYc2dzV3RzU1k2VlNIQ2pqcGsvZFAvRkZi?=
 =?utf-8?B?c0tyT1JMUUF3Q0RreXlZZ2VrYk5jMDFHODQ4NkJmNmRLOHlFclZEYU9jRmhO?=
 =?utf-8?B?dkNReFFQUlRIUUhVZk1RS28rOUJ2V21kL0tCRjFqWHRjb1V6RlpGaFpkWVAx?=
 =?utf-8?B?blhEcjRvaVFhVGVxZUxVczIvRVB2eHlITjJpSjRNeFViQUhRa3VnMGlXZmI1?=
 =?utf-8?B?VGhCWHF6cVovSGNsei9xbG14eTQ0OVZ0b2NSQml6MkZlWDdUSytMRnh6c3lP?=
 =?utf-8?B?RGhIUGg3aVcrUW5pa2ZhZzEyWk9HeDMvZlNsY3hNMnEwa2k2dmZLTENScUtu?=
 =?utf-8?B?RnU2OHk0TXZ0RHZnTmVuSmhMZkdQV2FkWTJJZU9vb0pEVDZQa00zY3dFWSti?=
 =?utf-8?B?V0g3and2SlZUMHpCNnJnV0VTamoxR1NobzBtMVVRdzN4NEtWdU1lNGVMUVhY?=
 =?utf-8?B?Q2tQU2FnVVcwRzk0SC9FejZ1azdQL3VFWi9ZWldOREVVQXpPRGtoMWFBTElV?=
 =?utf-8?B?QlJwUk56K1l1Tlo1aXZybzRyVnQzSk5LS2VUYU9tNmpEM2ZtRXdHdWducU9Q?=
 =?utf-8?B?TVBzNU9NQXRYQWJoQkZkL1dlZ3pYblN0MUVHL0dSc3JZWmNiVnVNTXJ5TSsz?=
 =?utf-8?B?SlUvQlhKcWUwNEkveU5samVNVnNaQWM4UjdpSUVTMWJoZy8xcVg4WGwvKzBX?=
 =?utf-8?B?NVVzMUR1Rmt0K0lRanRQQmxtVUI1WWs1ejRRdm00MUloUUdzM0h2alJUSFVD?=
 =?utf-8?B?MUVCQVZESVJBVzhHbEtYVkU4V0NkQ2JKREpUdGNiT2Jxdzk3eDV6VVNlbTVM?=
 =?utf-8?B?UGRWc0VzVkVBVktmZUdLQnJDSDNpTjJsTlZGOHJHZ2JDbkxmM3YvZmU1QkM3?=
 =?utf-8?B?QzR5YW9LTmhZVER3Z2hVbERDdWJraThlcUY4TVF2YjlNQU1lYkJ0MCs3VkFQ?=
 =?utf-8?B?OTUxc28vb0lRNFMvR3JBOGdoTmQxVlpnK3BWZHNCQnNoTXJ3WmNOQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7073c3f-95d0-4a12-6c79-08de918439ba
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2026 13:23:42.5195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jSGA+pB77ZB5/4stJLwZFC/aWA67feq8u0S5zWyEUPk2P7PEB0KCgx6nLV0tQcEzETnBooBpwIhz+lx5dAakwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9222

On 4/2/26 4:32 PM, Joyful Lee wrote:
> On Thu, Apr 2, 2026 at 5:14 PM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>> Can you please explain what root port corruption means?  Are you
>> actually meaning graphical corruption?
>>
>> A few things I want to point out after resume that might be relevant.
>>
>>   > pci 0000:c4:00.0: Unable to change power state from D0 to D0, device
>> inaccessible
>>   > snd_hda_intel 0000:c4:00.1: Unable to change power state from D3hot
>> to D0, device inaccessible
>>
>> Both of these devices are part of the discrete GPU (VGA and Audio class
>> endpoints).  So neither came back to the right state, which to me has me
>> wondering if the EC is cutting a power rail used for the discrete GPU
>> and it's coming back at the wrong time.
>>
>> It wouldn't be the first time that the kernel raced with firmware and lost.
>>
>> What happens if you pass a PCIe reset to the root port above them after
>> resume?  Does it recover?
> 
> Corruption is just the best word I have to describe the way the dGPU
> bridge (00:03.1) comes back in an unexpected state after resume and the
> two devices under it (the NVIDIA GPU c4:00.0 and its audio device
> c4:00.1) become unresponsive. The two lspci attachments on my original
> post really demonstrate that weird state.

Got it.

> 
> Indeed, the "Unable to change power state from D0/D3hot/D3cold to D0,
> device inaccessible" messages are the main symptom of the problem. I'm
> purposefully avoiding the nouveau and nvidia drivers at this point to
> reduce confusion, but the problem happens even when they are loaded, and
> both of them crash upon resume.

Thanks - I agree with removing drivers from the equation to look at the 
behavior of bridges and root ports.

It's unfortunate that turning off pcie_port_pm didn't help either.

> 
> When I issue a reset to the root port after resume, it does not recover.
> The kernel prints the "unable to change power state" messages again and
> the devices remain unresponsive.
> 
> Joy

To your questions in the original post (again sorry for the original 
knee jerk reaction):

1) Yes semantics of how AMD-PMC works are correct for this platform. 
There are lots of other Strix designs that do everything correctly.
2) Yes; there are FW dependencies that are design specific.
3) There are no quirks for working around this bug you've found right now.

I believe this issue you're seeing is likely a platform firmware bug. 
Whether it's AGESA or it's ASUS firmware is unclear right now.

I have not seen this specific symptom you mention on other systems 
(including AMD reference systems) so I am /leaning/ more on ASUS firmware.

I notice that the BIOS you have from ASUS is quite old:

 > bios_date| 03/18/2025

Any chance there is a BIOS update available?
Unfortunately ASUS doesn't always make flashing in Linux easy, but 
hopefully you can find a way to flash the update if one is available.



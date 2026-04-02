Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010012.outbound.protection.outlook.com [52.101.46.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC243A3E7A;
	Thu,  2 Apr 2026 21:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775164496; cv=fail; b=TXQJTRPxaaA/bOYbPN1+UTYBdZZ6jv4GhZWg6seTFwkcUWwtKniCLnHWo18ELMMvDpkWEBWmzZg0awSjwS0u4d/2YLBxhjdEFTdcNW88gvItayvlfCdcD77c2KmOHWrE4gbie2AqT2aqnVqJpdzSvyCJQ9lWeNdi+qhJ/dGf5YY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775164496; c=relaxed/simple;
	bh=yRu6LQCOmsNBAIenOVEg0nw9mXmF1NoN9P2zN7XSRfM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=k74zzh2/zg4Ga1yMjDnfCbqHYv7YTg5D9gbsAozB30VJpfHMF6vk3aCla9jfiZtpt2dBGteEADyQH7KF3bxV3EbLsMYuCIboviQYHuKXULl+2afwV0OQ2G19B2BTh5PrxHIbO5mRraabWdjUl2HxmKWq4cx1OcbU1dVVf6NWsdg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Fz/haSNL; arc=fail smtp.client-ip=52.101.46.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Fz/haSNL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=amKvv4g0ggwmaHxeIOV6Z+C7GGLZt+/r23fOcR3Oe7whYE0PwnYngDREBtt6M5LIlU4Dfja7yyeqm8ClTeMtsaec4goyYtTohe+umUN1DH29O8qB5iXmXzAV3i4tI+ngrTp6e3Nmvgv2KqUkHpzEzsMFUOacsbBMRbWsdHIflXBeGW/1XR+Gld8au6mjfFRvF/C/ISfxT2laiZP6nuCrztWohmzfWOLCYG0m5yWT7ksmNqubcwT0/6lO4Hb532JU+841TrjcxlPrD/InSkmLC20iLepaHVANgItC1LSxa/hHfRX+qAqKqYZmXZa4vRdbGvP+hJwnaEO3BAhuqCMJSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kQ50CeJiWYknmVfxwNDBX4/W3QtnKTD6Mu5e904b4wQ=;
 b=B8bAow494AhnWxsyD22LFAe7S/d1gqYPh4G7blpeSqo0A3ZWtltVHmqDLD745CaUIxRc1keowJQGv58yTHJytKNq8QpkymfNANJMNuyEAgKlNYJLdFrYr4M6HGtbGQQ8G/tQpte6frHmtU1M0sOB/uo4JRd7VicY+ZJgrCT+XPAfLx4U95Uw5WKAVFX2BqK/uxmTYzPo37/xJ5hD5jT3dxi5+QSnxiTNBMpV9qQ/0cDBoqvyZ/I8B1uFL7pjx/Qx2jPhYSnwxeEcBYXYcvJlfCBcZStz6XuUCUD7f9gmvypPmG0hj6t1XI8fcb3PFMeCajJBoR2kGbnoAamL6xXgXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kQ50CeJiWYknmVfxwNDBX4/W3QtnKTD6Mu5e904b4wQ=;
 b=Fz/haSNLVP/EAlSD9S/+HgOX+9frALF5amcvRzDGuurqBu4I6R1gaV5n2CDRwGQBIn23yuiyj9Xa2bJTNt/sD5kKp6oWVL0lsy16bGp31I3e/8dijpatuepTBHP7orGloAtcXJCz3LCelHAp9k5Qdz1nHvWndZzwtp/xhmhFnGY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by MN2PR12MB4469.namprd12.prod.outlook.com (2603:10b6:208:268::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 2 Apr
 2026 21:14:52 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287%5]) with mapi id 15.20.9769.018; Thu, 2 Apr 2026
 21:14:51 +0000
Message-ID: <4192851c-20d1-4185-9f63-32c66ed2a664@amd.com>
Date: Thu, 2 Apr 2026 16:14:47 -0500
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
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CADj6jrgcuz=Bcp0q7BHVizVeF=C2r_8qXw7r0Mc5X9Vd8uWK-w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CY8PR19CA0040.namprd19.prod.outlook.com
 (2603:10b6:930:6::20) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|MN2PR12MB4469:EE_
X-MS-Office365-Filtering-Correlation-Id: ea4a763e-c7b1-42a4-e6b8-08de90fce115
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	5ncEtm4yp/DPwo7X/06L0UAojhN/+poeTdlu40hUL0oA67aG8As1BCSpf4tmBAWR3Z2PtNLy6Uc6ZdpxHvZnt82j7t/IsBq2aE+7MN1QVPX/bfavYfmJ5x3OhtEnSyJFx9ozVF7AvvuEoIr95EJbk70PTyCnuraa1S9MkP42sY8Xbr0rAArEzcIb4ilPcVNz4n9qsDsH/eptIsaJoPGqOIiXRj4/Upo5O8REd1XWcWxm2HAKbby/goKLG6DfcaQ2odnICXUr+oePukDvf4qoHZmJrwn4LGHO9yGybDyfuk2KXBp/yH7N3N82bJKFX1u6+NI/kB601jxRVCwlw3LhsltHpgjdJXLXNwdC0qxIm+2gCaRKsDR0REGL/X2DUb4Qk/hyf9UuNTifWPZr4E0yPPyKw3AvInoXsOtDhXCmsttVLKs/1BjFpU3a6pzaRvfzyUwjVgyHizbVqJL4H2zIy233boWN9c/If2T/wt6uJkQqNnQQHZwQwnYVYPSv/qPBk3tE/Z/cmhYf+rNLbcrhavrypRI4TrBGTydHjtB323WHDS2O8mlzlBf/AatimoTGA7/DYS9T55i+D7aW2smioC6a4I9DfXP0cmKausWyzNSQw0Z770B0A5SlLBoF5/JMpJN//EaF4CiDdznaX1L98H3DFJhyJ3ZumRoTJymhqzKDtSlvEStK+qoe83UxIW2O
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4557.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bWxWRzZZYStYajg3OCt6UlQ0WXhld0FhSFR6MFBMcEpOR201SERHMnJCeWp3?=
 =?utf-8?B?TUh1Wjd6U2hoc0NZTVZwdldqMWc2ZlorbzVIbkFEY2wzbmxFWWdmclRHU2pB?=
 =?utf-8?B?MGhGRnNWY291YlRiWVlUS3EvSkJUWXRaTGE4ZnFkWlozWXRBaGNLTFBiTEx3?=
 =?utf-8?B?SlExcDA4K01jSlRrWW9BdGs4eWJ3ejdzODc3Sm4yVXBPanJOeTNVTk5Qdm0v?=
 =?utf-8?B?eVJTTjllWEJob0NCTkZGaW9Ob3N1Q1JjeSt5Yi9EWEVQdnJnN3NMYnJOYyt2?=
 =?utf-8?B?NGdLdC82UDFHa200dW5xcnlwRDRRMjUzNXVjTFRkWlVaNFZSbDRlRksxUjRG?=
 =?utf-8?B?MTFOM2h6cVFSMGlwNDFqY2pIR1hxWExRc2haZHduTE5JQTFCZjZBd3MvOVQ0?=
 =?utf-8?B?d0J2UXpkZU8vQjNCaFVGUG4wbGU3dENndW1wYVZTeFZUdCtuanRpbkNDT0hy?=
 =?utf-8?B?YkdWTWpBcWdnWS9vVy9hSHNVeXFnb1p6RjFGZkRVOWFCQXFJMzJzR2svNUdE?=
 =?utf-8?B?MUo2L0wxek5lUlBucTQ5eGJwVk96NDJCMmdiYXlyNmNJOVBxdzV6a2R1aWRC?=
 =?utf-8?B?QWVnbWxLNG92RERlNExlVWRsMTR3cm5VcnB3N2lPUkpSaXNJQ0c4ZGxCbzMr?=
 =?utf-8?B?Lzh3SytMNm5JdVZWSzBtQ2VwVjZ2UGQvOXZDeGptRHlBTlg5a0JLVWpubXQ4?=
 =?utf-8?B?UnltWDZZaS80TDFYdDVmZ2V6Mm0zRUJoY1ppeVlBcE94b2UybXRjNnJHb3Qz?=
 =?utf-8?B?aWU2V05TbWZ5a3crQS9CalFFNFpxcnJpUy9HUmZDYktjMGtCLzRXS2N0YnNR?=
 =?utf-8?B?T2U5RnpDbkpSZC9zZSs5cnhPYkV6WFlMWllONVh6NTA1cDh0T3RqbmNHN3dK?=
 =?utf-8?B?UnN6bllsaHg3ZTVGa29sNk03Sm95Q1IrRGJ2cEJsM2FLQVV3QXpzRGNDOFU3?=
 =?utf-8?B?K2Y2cWI5dGJ3M0tMeGU3Q0dGSXdaSnFiNnJhR3grK0Nyck51QUdwbWtBTVE5?=
 =?utf-8?B?SEk1TExiRzMyN2EyQTRQK0h5enZtZFZ2ZktjU1NVTXdrNk1GR3BLdEpOTUtZ?=
 =?utf-8?B?TE4wZXpWenphM1hrL3BYWGNyWk9aSE52VE5GTEdzUTR5eGdqM254R3hTOUpy?=
 =?utf-8?B?TmZVR0JlT1VoeXZvS2VNUUZURUcyWWtYNHZYMmc1V1ZldVd3OGJDVUVlLy9V?=
 =?utf-8?B?SWtZRUx0U2pNQXBHT29pZHBrVHh3cEVtZnJlMkswaGhIV3NkdGRORGhaQS9s?=
 =?utf-8?B?SUlIL3N3MHVDNlZVbE1pSDlWd0FlL0VCR09sQmplY1F1a3RlQXFZTXdQUjN2?=
 =?utf-8?B?cmgzVlRlM3dVMjFTWXJuR0UxaldNZGlyUWc0Vnd3azdxV2FybTVmSmc3WnBu?=
 =?utf-8?B?NUg0SmNialljUkg0VGsyVVNKd2NtRHdzS2Z0MnFpdU0wT092dGd4cmJkVE5p?=
 =?utf-8?B?cFVxaXkzL1JRcjdXejdYVm1TamFSUnplUk9Da3IxZWRaaWFFaC9SUmpDc1dL?=
 =?utf-8?B?YzZRSUQ3VGo1RDFpUU5zN0J1STJnTEFyZSs5d2o4cVJVQll5L1R6a2g4N2ps?=
 =?utf-8?B?aitHaHFYM1Yvbzk1NTF2RUR3OHRaeVRDSFhTU29mNUY0eHNKaHhPejhibGNH?=
 =?utf-8?B?N2EzS3k1OEJOcjJEZ3E0WFEvWU1jRTRTMERUVE5RZHJlenNYUWkrUmU2Tnpm?=
 =?utf-8?B?ZkJVVUxVVlBuRTZKN010SFlFQXI0RlFONFZ2bVNtZ28wa0NPd0VXbkl6RHdO?=
 =?utf-8?B?VXgybHlJZk9tK1FKSnNkNTZjNVRKUWZnQlRVaVNKUVdRQzhMd3JKUG1sdExu?=
 =?utf-8?B?RXdqZlk3ejg3aGRVVEt0VzJIMjVFNWFmRGpDSkFNc0swdDdXV1NCM3Rsd0o0?=
 =?utf-8?B?RzRtYmJZNXJINk1KVnljdkNtOWlzMHpxVENCZUtHVUUwU0FCakpwRy90Z0Za?=
 =?utf-8?B?UjlnaldKZW51ak9VTmxWdWp5eHlvNlVNQzZGMno1UWVSN1prY0J6UGlvM0Ru?=
 =?utf-8?B?c3FiVkNidlIvNlZRODFFMVhTcmhaSmFJT0VYaXZSYWdzbXVyRHptZnhndlYy?=
 =?utf-8?B?dHAxcXVZZW85SW9Qb3NYMmRzaTNiSTZMQ3dISTFCQ1lkZHlheXNGVWM3b2dN?=
 =?utf-8?B?ZldXcUw2M3lrZkpQQ0loNVRHaDZhamxrZSt1UVFhUzgxSXpuaFZPckZYdmtE?=
 =?utf-8?B?bzRCbHVWb1ljRUpwSEw1Smc3QVJyRXVDMm40TWhXN1BPVEtmRGJxam51OXd3?=
 =?utf-8?B?TExxR3FXbHc2VG05TGRCT0l1dmlleTEwQ0dkcHZiRXFUcGZmOVRkcGNRZHpv?=
 =?utf-8?B?Q3JiOFgrT3hkQzBHL1FaOEFXWEFwMWxGVVVsSTkrd1F1TEp6SjNQQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea4a763e-c7b1-42a4-e6b8-08de90fce115
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 21:14:51.6826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lzsS5NauveHndBIoSNgErNyLXBMR5yDFY3eB96pCFSwnFVNrP8MjsGXkDiBofp4Cy2h8bw2f4TRAlrf4zwfrcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4469

On 4/2/26 3:59 PM, Joyful Lee wrote:
> [You don't often get email from joy@joyfullee.me. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> On Thu, Apr 2, 2026 at 3:58 PM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>> What does corruption mean in your context?  Because I don't have any
>> idea what a root port being corrupted means.
>>
>> Basically I don't trust a single assumption that was made by that LLM.
>>
>> Can you please get an amd-s2idle report from an unpatched mainline kernel:
>>
>> https://origin.kernel.org/doc/html/next/arch/x86/amd-debugging.html#s2idle-debugging-tool
>>
>> *Then* let's talk like people used to before LLMs came into the picture
>> about your problem.
> 
> Hi,
> 
> You want to talk like people? Let's start with this: My name is Joy and
> I worked very hard on that bug report. Everything in it is accurate, and
> for you to reduce it to "garbage" is not very professional. 

My apologies if I came across rash.  My time is valuable to me, and I've 
had multiple people reach out to me from CLAW instances and I've started 
to see the formula of LLM output. It's incredibly tempting to trust, but 
it's too often wrong when it comes to debugging issues that cross kernel 
and hardware.

So yes - I want to confirm I'm talking to a human with how much garbage 
is flying around and it looks like LLM formed output.

> Second, I
> appreciate your and anyone else's help on this problem, but it is not
> *my* problem. It is a problem put upon me when I purchased a product
> with your company's logo on it.
> 
> As I said in my original post, I'm happy to test anything you want with
> very quick turnaround, and you asked for an amd-s2idle report from an
> unpatched mainline kernel. You got it!
> 
> Thanks again for your help.
> 
> Joy

Can you please explain what root port corruption means?  Are you 
actually meaning graphical corruption?

A few things I want to point out after resume that might be relevant.

 > pci 0000:c4:00.0: Unable to change power state from D0 to D0, device 
inaccessible
 > snd_hda_intel 0000:c4:00.1: Unable to change power state from D3hot 
to D0, device inaccessible

Both of these devices are part of the discrete GPU (VGA and Audio class 
endpoints).  So neither came back to the right state, which to me has me 
wondering if the EC is cutting a power rail used for the discrete GPU 
and it's coming back at the wrong time.

It wouldn't be the first time that the kernel raced with firmware and lost.

What happens if you pass a PCIe reset to the root port above them after 
resume?  Does it recover?

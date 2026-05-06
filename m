Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010058.outbound.protection.outlook.com [52.101.56.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A976E30DD1C;
	Wed,  6 May 2026 21:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778103417; cv=fail; b=mpTeaOCknV+WghAdx1m35v7pySgsnUUvYQZ5Qn93RGfrzRxahNqxUeJvMh8ek+05VV4A960DrDOmXXcutBVPAzyvZLI9qK01zmA2fL6eJj4/ab66l7ma7diJe1rWyGG1T5pqHNE7gVxxypRcuTu4iw2MMq94DAUrFmN6spXpXxE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778103417; c=relaxed/simple;
	bh=onJWV/xrbGLNOuITWrgGfPk2xc/1uvfYLplnv4Yd2rE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bT8aEMzsZ/oQl/gO6HVF2yoY6y6Yck2p8KB2CIiwKvlqHfKPIGju9SRS1qFLcInJFgS8Bq5IvJfRuWu6EDKfMU/1bXJDZseJneZTrqwzVWxrYJk2oRS9vG6trxZjRniIXMRYopO8NzpzNATKZvo/xYsAcX+sY25pSCuEjQQxs2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UvsnLOWN; arc=fail smtp.client-ip=52.101.56.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UvsnLOWN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FqnlVrcfPO5rYxKdJewWhA2MHTThE34BHzb7poPtH3qltwt3cuhH1OjkbQ5KFnlX0h0HZ4R0rtgrDvLs659J9K+hwV2qP7F06FSc62KXQ9eyb4vjB1gi5h5WwwBNm4w2V16sBhR0INyZ2Rv6MP/a684D1aAjqhRPOcVk0Ojm5lYWEa25Zp/xCGoJrALbTvO8HjDVOqnrv1zruP+lOvV/W90qCJaA/M7jWhMC1r87KxkuGIQhrk4uIrZXydPUM579PsOgEO64rjvf8QKnGRq4BMwuqq6cOfAOMUBMD6whJZPQ6rHaS3fOasxj9RCt6eeURgbSAD0+cELvKOx5rC7NDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kc1a82Cnqb3GoUmf2yn6Uw0ghjwDJJobqn08QhW6yRw=;
 b=eemfTAtfxoM2oaG/Tg11t6KGuzB5N36hR4B5OJB93E++3pj7G4d3B8fuCGh2+iZhbO42rZrFoOALN/HSPtuKOoSJwVbzB0g/QmqVNq3+f9dHuZJYy1Rscz+M4OhDBOHxiDyYaaAUzblpD+XtG/A5lKUiVmmw+PjY/L4ptfEcV0Zvo03vkIju10eToorABmW14Vx4a2i+T+guk/MNH5BYstwLU/TV1kzbnWme3ilm9cQ9i4iYLnm7hBmfuxlBJGy4GrxYatZDpOImeNMifow6DTK8p42W4d0PAAmNPhMKhHMG9V07hlVBjlHoIEg9kCTwDRVCg+h7Z87bxYK3V3JfKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kc1a82Cnqb3GoUmf2yn6Uw0ghjwDJJobqn08QhW6yRw=;
 b=UvsnLOWNqeY4wvY+cr8lrfYRJST8yMmD53ksfzEtQG/n8FDA2TRNJCzEm8GV0QTSNeiubUAFYupTFNIYcxXRIzIWJXHBWxgKPxXBMPTuAXX63GB7pNzEnvWJlIiYiB7v7czzKJd5NOEaZe0L3G8m5UqRMyWQje+hpgqJR3fhFpw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by MN2PR12MB4063.namprd12.prod.outlook.com (2603:10b6:208:1dc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Wed, 6 May
 2026 21:36:52 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287%5]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 21:36:52 +0000
Message-ID: <424c4dc4-1810-4ffb-ae93-7ec9f880ec1e@amd.com>
Date: Wed, 6 May 2026 16:36:49 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] hwmon: add initial support for AMD PROM21 xHCI
 temperature sensor
Content-Language: en-US
To: Michal Pecio <michal.pecio@gmail.com>, Jihong Min <hurryman2212@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mathias Nyman <mathias.nyman@intel.com>, Guenter Roeck <linux@roeck-us.net>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Basavaraj Natikar <Basavaraj.Natikar@amd.com>, linux-usb@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260506032939.92351-1-hurryman2212@gmail.com>
 <cover.1778099627.git.hurryman2212@gmail.com>
 <2e2ea249b30168a2eab62fc110c226a511f21bf2.1778099627.git.hurryman2212@gmail.com>
 <20260506233332.664f220c.michal.pecio@gmail.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260506233332.664f220c.michal.pecio@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:806:2d3::11) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|MN2PR12MB4063:EE_
X-MS-Office365-Filtering-Correlation-Id: 616a36cd-8663-4257-c313-08deabb7965a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|56012099003|18002099003|22082099003|3023799003;
X-Microsoft-Antispam-Message-Info:
	NM63taJjzZIOPTdN6kg/T3u2RvuFsvMsjx1ow3mcdLzMKhdiLWucqNZgoQlkfWxR+hB9Z8QzX95V0gfwuxUVmWhd6ZbR9644nMoiGjxuI8OFRu1m/tgSw7A4mF7pjngry9XI4ZREy5RX9vXEQWq/rnVwgbLVBN5ahAOKmDpC14aCFSsEt+AtzVSvyMdnbWMVPhmFlsNanTnKjAU+qeIQlvVd4pgEmEnLj0+dE4PVvUyGDq2VnPDi1TEQ4nIuohZFgKzQsOUH9Sq/JMOR8AgXVUqs15XPLvHMWuM3IzMb+pjJ8CPjmLQXdaQUp7rNTq/OkvggVmXCcqqlKdKhdHqU8q4f4q+zVPhiRJ9hfgybsZlHUxTp0XDckRdD5dF0yMSH78yrl8PvWT+evjyu9HlKW/0yEzR5LwXKyAKrKvsOf68eatEQFNm+KkLoa+lE3OtDKK1ZdC/pVNHPDVqy9+sfs4ylGD2JQUSMn8VrcLvOJYiQHzIICD4gKEVlezHZbgbhewT34TFGH6iGvoUT8fBJCdtNgC8tuXVkJ8sLLLFkhrTuslEWnnQSkfL5cxtP1Cs4heYUYjHzLYilr7aJPmhQXqXWgwWdzQNsRQ/n+jNqNRhPylYhRr3k8cd+TIzq0V7NxeJJNnJz7+rDurhYH67zMfe5gmhm6teR7dHOBHPEEJMq298LeXodVUcDlJ1GldHn
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4557.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(56012099003)(18002099003)(22082099003)(3023799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VmdpTVU0cEp0WjNRTHZQczRYU3hCbjVyUXl2ZFV5aC9LaFVhbExXeHRMSm51?=
 =?utf-8?B?enQ2NW1SaElodjgrSUNQS3Y1b0lxK2EwZkpxMHNBQ3VhVUdkeW1OYVRLVXh3?=
 =?utf-8?B?NlJTVWVzTG1GZXZ0bVpkMkgrRVRlQVhYWk5mWDM4M2c3N2VUakZ0c0h5WVVM?=
 =?utf-8?B?SFJjRy9CTVljOEt4ZnVVNXR0cnplaVlPdlpQbXlIcnJQMXh5VFQ3SCtWYldD?=
 =?utf-8?B?NnRUbTlVTlEyTTV3M29JM2xHOVhsaWRudU5KbEJrT3huQ2Y4SThDYjRnZS9R?=
 =?utf-8?B?eXB0TE10WithUUVBeiszNkFBU3Y2Y2lJZVZ6RnBqK3J3YU5EczkwcjFoZkRC?=
 =?utf-8?B?ekE2emIzM1JIMWxnL2FvaEFCbldLUUY3ZTAzZFV5U3RKMEEzM3orcUZoMys4?=
 =?utf-8?B?MUpoQmxuNUx5bmtBeWJvMEV3NG8rVGdCb3RRRUkzRGM5MUhIcHF1U2FHWUo0?=
 =?utf-8?B?ZHFpazl0S1VlMEVsNW5SMUw4Y3d1dUZTbWRURC9hVzNYTE52R09zRHdHYWVo?=
 =?utf-8?B?YjhBalVTbXJLMXVjWThnSW5xMkMxTkt2NjJhSXR0Q0l2QnpScWpIZmEyUHFv?=
 =?utf-8?B?SDVkeldXaGYzRlAvV2t2eTdTVkp4UlArMVk0WkZtSnBKbnRYN0JvUGtxMWZ3?=
 =?utf-8?B?NnB4OGlTVkVuVjNINlJ1MGsxZlE2dWk2UmpKdVhTOTllUnNBY08wMDg4dWc0?=
 =?utf-8?B?RzhLaVRWUEU0aDA3L1UyYzFZNndYM25qT1EwbytvdEtYZGduYWo0V0lUU0Nn?=
 =?utf-8?B?d0VGUzVldEthRHFMaEtGRWhqTVRqMjBQOGhxWHJZcnI0Z1ZtVUlaeUxqQ200?=
 =?utf-8?B?N2V2RDhHZUo1OUdReTVTcFZOQWkzWjUvZ2laSmZaU2hSdFJZbmZ0MEljTTZN?=
 =?utf-8?B?enhkOHh0bTM2RjdhM2RPK0F6ZklkdlQ3QVRmQW5Yb2pFeEZDY1pnUW9ZbFAr?=
 =?utf-8?B?R3N2SkZ4a1lhamdtbFhBSXMrd3B4KzVvMWZVTUJiTGo1b3E3SXEvdFhIbXpI?=
 =?utf-8?B?R1M4NkROMlpjeWpVb1hud09JTTF2cTFMOTFKUU9jWkVFWG5PZVYreHhHMTlv?=
 =?utf-8?B?RUxoaE1vL2xDNjVab1lEM3g5bzAwMkRrT1p4ekpxQ1JLL3FLREpCSnBLVGlC?=
 =?utf-8?B?VlYwN2JBZUNQTlQ1ZVhXdEN2Yk5tUGNCaytvQ2dFQ21INDQrMFlKRUZzOWZv?=
 =?utf-8?B?cFB5MmdMbVQvTUkzSnlUdllUNDh6U28wWEpJZEQzN1MxVjYvRm0vQitNQ3VU?=
 =?utf-8?B?djFDdXozVVFyM1JlZWRwNDdxYUdiekZKbGUzR2w5cElsVW1zeUZiVmphME1N?=
 =?utf-8?B?MVRyOS9ISmNPSGRNQ09EMytoL0JtM3lYNHNlMEVxM1kxT2NJTG1DaTBqelVa?=
 =?utf-8?B?Vm4zRXlCUzA2RFMvQ0trS2IyUkNIck5ydEpUOGhsQUpxSENiRStPeEhuVldZ?=
 =?utf-8?B?emEyRzN4aTMwbU5zakNnN1orOHhTeGRYZ2M2cHVneGlmVlhPbUh6K0VPalFo?=
 =?utf-8?B?cGQ3NXZaa1hoUmRVRGppTGRjWDJ0c1h4TVM3T0loSEkvd2xtQy82Tk1YZmNy?=
 =?utf-8?B?WkVMTmJjdU5VN0hNWVExOHEyRDdacDZYOG5KTGhTNlh5NHMrM2I3ODVtdXJ2?=
 =?utf-8?B?VTY1WjNGRTExVGUvNHBkMnozbTl3QVBvcVdEQmd4QkxlNlU5dVUvQlQ0OXdF?=
 =?utf-8?B?QmU5N1V4amZQSkxiVUJaS1oyeU9pKzhxblBlM1NvaWVtM015ZFMwbkl3VG9P?=
 =?utf-8?B?T1VGd2pRbVhMbGljNU1XMElYOFJ4N1F3TEk0d2FSQ0w2S0diODdOMDZidjlx?=
 =?utf-8?B?eVFmV3poMlV4eHZUSHJRWTNuK2ZTNFFCNEU0cndkbk8rVWFFZXcwV0xRRU1E?=
 =?utf-8?B?YXZDbi9zTmVUSUFkUFc5M0hsUGdkT1BqWFJGL1NQZWI0WW83T2RYL3JHK1VT?=
 =?utf-8?B?RDd2SGE5dTczd1oxWHFiZzBlYW9pUCsyK3BXUFNyVDlLd1dxZHBVSmV6Yk85?=
 =?utf-8?B?Tmo0ZkZkM0hhTHN2SEVaUDA0VjJtVEc1YnFPM2VwTU5tNWRGRDFBdG1CK0hn?=
 =?utf-8?B?dzk4ejdvK2tqb2ZwZnQ3aTd5NDdob0RGazMzdlpXeENPYWRBbUpOamM5M1BW?=
 =?utf-8?B?cTFjZ2JoRVZVUnE2bENubC9PbGhUSGJ6MUw5TytrNzFLckFjZndycnc0TTd6?=
 =?utf-8?B?WUE5YTMyR1kwNzlsME9DOHZoL2lMQWduS0VjVzRKbUdveFcwTHN4S1RDNytB?=
 =?utf-8?B?RjNOYllGTFpRck1vb1BUZ3JpbzdIZzdUcXZidmV1T2Y0dTVXRUh2dFM2UStW?=
 =?utf-8?B?cVJ5Y3FLL1dQV1RwUjg2aDc4dkVwcjZxblV4OHJDd1R1cnZkSmM3dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 616a36cd-8663-4257-c313-08deabb7965a
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 21:36:52.4476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xs5FQCcBbk/49wqHvEFzGmb/UEuW0VcbrIbeNkS1pqMNA1mJvngb+G3pSHB4UaMVEvAoJkai2PHpZiDLsdI0FQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4063



On 5/6/26 16:33, Michal Pecio wrote:
> On Thu,  7 May 2026 05:40:34 +0900, Jihong Min wrote:
>> AMD PROM21 xHCI controllers expose an 8-bit temperature value
> 
> I think this commit message and certainly the Kconfig help text should
> include full name of the chip and perhaps its official marketing names
> too, so that people better understand what hardware is supported.
> 
> So: "AMD Promontory 21 chipset" and "AM5 6xx/8xx series chipsets", or
> whatever they are called by AMD and motherboard vendors.
> 
>> through a vendor-specific index/data register pair in the xHCI PCI
>> MMIO BAR region. Add an auxiliary hwmon driver for AMD 1022:43fd
>> controllers and bind it to the xhci_pci.hwmon auxiliary device
>> created by xhci-pci.
>>
>> The read path verifies the parent PCI function and uses the
>> initialized xHCI HCD MMIO mapping. The vendor index register is at
>> byte offset 0x3000 from the xHCI MMIO BAR base and the vendor data
>> register is at byte offset 0x3008. The driver writes register selector
>> 0x0001e520 to the index register, reads the raw temperature value from
>> the low 8 bits of the data register, and restores the previous index
>> before returning. Expose temp1_input and an xHCI label through hwmon.
>>
>> Register the hwmon device under the parent PCI function so userspace
>> reports it as a PCI adapter, while the auxiliary driver still owns the
>> hwmon lifetime and unregisters it from the auxiliary remove path.
>>
>> No public AMD reference is available for this value.
> 
> Is there any documentation of the index/data registers themselves?
> 
> Any potential danger that something else (FW? SMM?) uses them too?
> 
>> The conversion formula is derived from observed temperature readings:
>>
>>    temp[C] = raw * 0.9066 - 78.624
> 
> Could make sense to describe methodology, particularly in case some
> people would come and question the formula.
> 
> How was actual chip temperature measured?
> Was the output compared with any other (Windows?) utilities?
> 
> People will be comparing these results and possibly trying to draw
> some conclusions, like OMG Linux runs this chip 8°C hotter, should
> I demand a full refund of my free Ubuntu download????!!!?
> 
>> The temperature register did not return a valid value while the xHCI
>> PCI function was suspended in testing. Keep the existing behavior by
>> default and allow temperature reads to wake the xHCI PCI device. Add an
>> allow_pm_switch module parameter so users can disable that behavior;
>> when disabled, reads do not wake the device and return -EAGAIN if it is
>> suspended.
> 
> Is such behavior useful?
> 
> Maybe the driver could just disable runtime PM while it's loaded.

I'd encourage what we do in amdgpu for dGPUs. The hwmon files will 
return an error code (I forget which code) when the device is in runtime 
PM when called.  Don't explicitly wake it otherwise.

This prevents someone installing a sensor monitoring application and 
that application "being the only thing" keeping the dGPU awake.  If it's 
awake already for other reasons (like being used) then return valid data 
to the applications.

> 
>>
>> Document the supported device, register access, conversion formula,
>> module parameter, sysfs attributes, and sysfs lookup method.
>>
>> Assisted-by: Codex:gpt-5.5
>> Signed-off-by: Jihong Min <hurryman2212@gmail.com>


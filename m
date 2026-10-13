Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011052.outbound.protection.outlook.com [40.107.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9FD5540AA;
	Tue, 13 Oct 2026 21:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791928100; cv=fail; b=olxZ9T1hiB1SLUCwUaoMOr+L2/oqbwEphV9GtsI5RNZ+Iie06EuoOFUk1tnK3Lds9rH7qXI6Ve96L1Q5wsz0c8pHduaFB4oX0QgkmkLZyDHF/FE/su1uZ4Dr3QpavdyKwz3DVGQEIaAKxaJkbloWyyVQVMqZHohWquLYUv/8egM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791928100; c=relaxed/simple;
	bh=JWQQwIMG9vsrFXkPknbpz9uOynW/98OHDom2RgkWtb8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cKCzjpl4wP64k05FZ/hGuLVcd//w2MNwoYtjJmY84tywfchAjoamVWP5YRsxc6gjt0xl6Nvfr5kpaNgsNyxa7L0p6iBMSrWttAwvO6aRLZ3V8+h39Wi2XQYhTMamKQUAsgMffMK68FbzzgDR9VBMF8ckYQRNvhPgPZsLq4S2fFk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xalqaGgD; arc=fail smtp.client-ip=40.107.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xalqaGgD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S+7TZIdTel/D+uR+OshhMiMV/ra6AOKJYSyOd5iof9Isg5iHOFIRl3PYHv0FRtSbGiNiUK6dvMALvBs3NZqb5eN3zXzapf8c7v96qwd3MvZDCt+IYn5E+YT54zqHHZCBY/rRq26ngd9OaSIq6JgznDwlEU9q6Fmarcxaz2lkPiXQ8JKbZ/ajRXdl3aKBBTkZjbI5NnjiYZ448J4byZS1YGqqE5GEvCIaqRhjHXBlGxSlhPRAAJySUpWjgnT3u0d7f6fXDgYI47W2D3P0l/uDAU4A/DIjKW4ni2co5W2YYxAfNp5HVfkgNVXnd/qOyp1qXE8zfj2q56cPC57FkqxWBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XwIJHSEgZVyvhSkOiioe6owpcIDZyq9erulqHDoNypI=;
 b=G82q+Poy7RxK2XuARy03AEzzzS6HhB1nSDADbGe4gXcmlhVIEOXAQuXE980JprXbnKLURHuQc1r2QKl6HEukZUFJ4amWAn+uNccxGY+N/JKow/Ouea/qkxfA2pzZqCasMohpuSG45Ze0F4rEL48mqUnTVs7mn88U/6KQTgy4vyfhre7iYkaENZp555CMLQni0bW0/XdEVmpVWde1mkxgRozRtr7px5E6x+zhR+odweuVX4Xez+GFkS68Wpve9+RWwArenasGJHp772JpynD5jF4hfEW8Y53l5ONcQQc25xNaKwph1BBFMUfVECyclwZMMgv4c1226/v/C/nt3FF7jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XwIJHSEgZVyvhSkOiioe6owpcIDZyq9erulqHDoNypI=;
 b=xalqaGgD4A0qmPeNRzpgBGAkotfzFK81GVr253BJxU+VshDHI27R5WWl3qYDDIbJxHHAnJ/wb7Gi+G9Yt+b6DJMHwK13T6mnkjd1PIOvMtyYPcxSWq5FhQpIzS307fhPyPFqDLtPAjK+jAHoKlG6+iwCKWxx51M3VDnAYJ2IGGw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by CY5PR12MB6107.namprd12.prod.outlook.com (2603:10b6:930:28::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.24; Tue, 13 Oct
 2026 21:48:15 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0496.021; Tue, 13 Oct 2026
 21:48:12 +0000
Message-ID: <80c964e1-30d3-4b09-aef8-08c04e119e79@amd.com>
Date: Tue, 13 Oct 2026 16:48:09 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI/PM: Restore BARs after powering up during
 enumeration
Content-Language: en-US
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Keng-Yu Lin <keng-yu.lin@hpe.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Matthew Ruffell <matthew.ruffell@canonical.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, andy.liang@hpe.com, david.chang@hpe.com,
 s.collins@hpe.com, jenifer.golmitz@hpe.com, pravallika.kamma@hpe.com,
 zhen-dong.lai@hpe.com, zachary.pabor-ext@hpe.com
References: <20261012104645.975190-1-keng-yu.lin@hpe.com>
 <CAJZ5v0iGhqaF1m-Vc2xdXQXj_BxPFFWCBTP=Ypg_gWQEqWkNfg@mail.gmail.com>
 <642c49e1-7d47-44fd-b597-e5ff0877bb56@amd.com>
 <20261013060957.1023448-1-keng-yu.lin@hpe.com>
 <CAJZ5v0hndk_ck1hcgWXyGX=OHmbfbhKsrJQsNQF9DQrucRNMDw@mail.gmail.com>
 <d11aa70c-4753-4a28-9955-990c45649677@amd.com>
 <CAJZ5v0h2-S=Yf84LveK=36AkeutJxj5qYzVXnjhAnawi097x0g@mail.gmail.com>
 <CAJZ5v0ie2AvCbdv8-zkpYzHLcTwUPUj+=WWOQjDAPmSepSAQPg@mail.gmail.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CAJZ5v0ie2AvCbdv8-zkpYzHLcTwUPUj+=WWOQjDAPmSepSAQPg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN0PR04CA0090.namprd04.prod.outlook.com
 (2603:10b6:408:ea::35) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|CY5PR12MB6107:EE_
X-MS-Office365-Filtering-Correlation-Id: 109fb17f-fb75-4ee3-2b6d-08df2973adcc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|23010399003|261009221727099003|56012099006|261009223027099003|261009220027099003|4143699003|11063799006|261009221227099003|261009223327099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ZneHvfZagPKEpcURQOeyC7GmI3Led4WqGP+UT8XUu683tBsXQzmrvjviVb3d84Fz/UkQj7ZnaZPY8QBUVje2oG9ItmTAiJ+cJJR61zM2kaf8skuJbN+noQabfKk0qgca0tTKJK9rYOAmVZVjbQWBVOuj9nRQpwucr0BK3dOfTcunozmDORRudD8tj9TkmAUARt+Z5xmvfgThsBujTrRIAOs9xqAeOOo25DxiYKAPk99tdcwZ4KcSzlhWfYcDFPfaS87wGBjCCL4hDz9MYRvojCxlBjody101hnTXPE5mkssaqKN5Ncm8aRLjV+lHnT0Gd6RZ0fOYX+cXHamjYz9kfE2tsWP4SDPEh4gaHNwTndW/JF5zNm493SOv/aYwohLH9vzzebohH9U/CtmYwyUdqbTKugnSLTESlFb/3jAKf3Ixz1PO8exdy0vv6x897A4T1OMAn6UBo2nJemGZmDij0K2NS6hC1Esf9vnOjbNstCBRY7z79pC0OaRgMq1Arc3lZbPFfeZqPvWPZ7iMDWL/ZAua/mgY1P0eR+0oq2y1m07P7Or5Pqhq8MfCU1d7FxdN0LLKYZaRka02anMPHX6JOz4sJtYdgO1kde/sqlZMC6qu51f2itkjqeK5CK9yMip5mXhVoo4QcAhmqc5HTctNqY/VLdrKH++iLeILNsSbl3A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(23010399003)(261009221727099003)(56012099006)(261009223027099003)(261009220027099003)(4143699003)(11063799006)(261009221227099003)(261009223327099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZEh3c2RkOFRiRnQxbE5OV21ON1RDb0liZnc0TmpldkxLRjE0dXI4QW05ZEZX?=
 =?utf-8?B?K3pZcWs5NU1NeVN0UTVtcDlpb2VKRVlpRnN1czRYNWJRbmxRWkJQR2doblB5?=
 =?utf-8?B?NXh4QkxtR0tFdG5hL0UyaUkzcWhYL2hXT1dKNWlSOHdpQTZKWWVSdHcwM3R3?=
 =?utf-8?B?bjlCTlZFVEpKYUZPcDJUS1dpZ1hIVmY1dm1aNW5aZDBYb29ES0tkUE91bm03?=
 =?utf-8?B?WFl6ODhmNXZJVitEbHNPK0hoWlhmTVdFMElBSVc4UnY0YWs1Q09xSXZjbXc2?=
 =?utf-8?B?V1FYemlLTDVxOEtwZlBvT3RlWjBWWVUvR2R0bGd5LzRrY3IwTElyTmtSWnlZ?=
 =?utf-8?B?L3hKMk9qbStEVGpQTzVudjhxR2NVRzVLcmIrd1ZaM3ZQVFh3WmxIRjVZREd6?=
 =?utf-8?B?dFVQa0RlVnRKOXNpQkhabHgyQzdKL0Qralp1SXpBWTdqd0l0dGYyUWpLZjFu?=
 =?utf-8?B?MkkwZ1JyMWFPbFZsSzYyak9lQmdBclAzVlhCTFNORStGaFpWa2lJRzVGWUJj?=
 =?utf-8?B?T1I1TWJqZXdpRTdnVlkrTVNLK0JxYnptYkVFYTNSeUVvdldRajZHNG5FaVBj?=
 =?utf-8?B?YjJEbFdNMjFodWlVQ2xlWnFPdU1LWHN6TEphdGVHdEt2ZngzTXU1VG9WbDFw?=
 =?utf-8?B?ZDcxcGE5QWhtM0NHcm9QRVZ3cmZTQmNzeC9pcFdXYkNiaTZjQVhxZ3IxSUV4?=
 =?utf-8?B?am9sOCtEQVIrdy9nejEwTlNqNS9HZkd3MnpyWEkrTzBvemkrQ3YxaE1UTDdU?=
 =?utf-8?B?cE12bzFqMERhSTljaFdBWXdNK0JENE1IcDAySjl4YnZ2OVp6YUU2NzlNS1Ez?=
 =?utf-8?B?SzNyMVROMjdudlFEdllyOTNuZlJPdW1HSnNwN2o2UGN1M1hOWTkyQ2Yvb3RT?=
 =?utf-8?B?T0picTM0MzdkbW9qN1hQeGJnb0liSlNzL2ZGNmZCUzBBa1pqYW1VQW40Y29J?=
 =?utf-8?B?TG5iMHFJaHo1SzRpZzB6alFsRnF2UWJ2NlNNWGY0dXdEU29ZR2xRVmNSNFI1?=
 =?utf-8?B?YitHWU1wSXNWZHd1OVdoMHBNTjVlOFkrWkw4TzVGcnFxZ1BVSzMxcHJCckFO?=
 =?utf-8?B?TVNaQnJYYk9ZbzNLcXl5VmVBWkRaNHQrZCttNTlwSFJCNzQ2YUxpeUZLTHNS?=
 =?utf-8?B?SFllaEd5OGN2NmJkOEFmRCthcFhjRzA4S291Ny9Eeit4WkFDTi9rUUdYUTVm?=
 =?utf-8?B?V2w5cThCVHV0L0hhZmVWeTdPbXRHUmloRSthYTBrTEppM0RJdzlOZFJjQnFP?=
 =?utf-8?B?dHpEVEJ1VjBON3R1NHJDaldFb1FOeEs1ZmJVN0tkazUraUY4ZDBCT2ZlRWxj?=
 =?utf-8?B?anhjUS9nc0NxQ2JpbG5Td2VqcEJ0clBTams2ekh4bVdQN2RFNGg5a2ZKR24y?=
 =?utf-8?B?S09rZ0lWVlIrdEhYQjhNdjkzWUdjN01RUllJQ1lTV3dNeUlFcXczVGpXeGdM?=
 =?utf-8?B?cDFxZWdHUlorNlBuN05YQWZSdmtFV1NqdFB4VFlnd20yemJnLzNNM003a1RS?=
 =?utf-8?B?bjRvWjArUDB2VC91Y0hEMDhZcjBUVEk1NnNsbUxwMmswaHpqWk9MN25OTEU5?=
 =?utf-8?B?MEVxUmw0ZmJoNmthSW1TRnlTS0luaEJPZ1NPUml4aG81amxMSHgwc3d0eVMw?=
 =?utf-8?B?M2JpaEo0QzRtOVBTaHNVWVJYMkVtdGxVU3ZYRjY0ODV1dXJZdGxEL2ROT1Mr?=
 =?utf-8?B?K1JySXpnQVFyM3dHeHdSaFdicW5lSXpVUjVuNnhEMWYzMHhIMS9SQUFjeFl1?=
 =?utf-8?B?NmhxWDhQdFJUbTNqZDNRQ0xpcnN6V21vOStHaUUxa05Vd1lUNHJnTHZxTThB?=
 =?utf-8?B?SnhOK2Q3bG9oRVhRdjVhQUEwMmgrU3UzZWIxamQ3eEV4My9Dd0dIUWtWcXV2?=
 =?utf-8?B?eUhLN2pxdDhxcVQ1SUN1SUk2TWdhb051WVhnWW5neG0xZjg4enhLT1dtODJK?=
 =?utf-8?B?SEdDMHgrdlBua2R5LzBKMFRZaTdnWkhERUdRUnZTR0xYQzdmM2hndHJqVHlJ?=
 =?utf-8?B?dTU0SUNXSi82TXh3aTZjMFcvNjAxaVliQTV0SWtsVHEwOVpOc204MTNCbjZL?=
 =?utf-8?B?a240dnFkZWQybGdkM1FBaUg1SUpCdmVsT01hVCszRTdKUHp3MG5yYnVjdFln?=
 =?utf-8?B?NGs0ZS9ITDFGYlhzOVhXVHg2ajVKcWlyL3ltNCtPNWQrd1VxbVJKUnpFN2ZV?=
 =?utf-8?B?bkM4cEFveE45TVJYUlErUFdwYmZVQm1tZlJxQ1R3Rlp6YS85KzhiOWFoY2ln?=
 =?utf-8?B?VVkySngrR0hTd0lkcExQQytsLyswWlJGZ0JFMFVxN2dLVXh2ZXdFdEJqYmVQ?=
 =?utf-8?B?aHQ1WG9sdlV2Z1hva1ZOUit0UHdIYVdENy8zblBEVzRPN01NLzY2dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 109fb17f-fb75-4ee3-2b6d-08df2973adcc
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 21:48:12.5342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RL6916UeWiQB7FNqcnBFjMFG2NWAP9+2l5vg/UwovfgOx9UkJcjfq2SQ2+wba4ejf8ODig3CqKWnyRZYISBhAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6107



On 10/13/26 11:57, Rafael J. Wysocki (Intel) wrote:
> On Tue, Oct 13, 2026 at 5:52 PM Rafael J. Wysocki (Intel)
> <rafael@kernel.org> wrote:
>>
>> On Tue, Oct 13, 2026 at 5:41 PM Mario Limonciello
>> <mario.limonciello@amd.com> wrote:
>>>
>>>
>>>
>>> On 10/13/26 10:23, Rafael J. Wysocki (Intel) wrote:
>>>> On Tue, Oct 13, 2026 at 8:10 AM Keng-Yu Lin <keng-yu.lin@hpe.com> wrote:
>>>>>
>>>>> Hi Rafael, Mario,
>>>>>
>>>>> The initial read is not needed to fix the reported D3hot-to-D0
>>>>> failure. I added it to avoid extra BAR writes on devices already
>>>>> in D0.
>>>>>
>>>>> pci_power_up() does update current_state, but need_restore is
>>>>> calculated before that update. The check includes:
>>>>>
>>>>>           dev->current_state >= PCI_D3hot
>>>>>
>>>>> For an initially unknown device with PMCSR reporting D0 and
>>>>> No_Soft_Reset clear, this still requests a BAR restore. Reading
>>>>> the state first avoids that request, although the final
>>>>> current_state is D0 either way.
>>>>
>>>> Fair enough, but if the device is in D0 already, it need not be
>>>> powered up, so if you make a point to update the power state upfront,
>>>> you may as well skip the power up if the outcome is D0.
>>>
>>> It actually does need to have all the ACPI calls that happen as part of
>>> the D0 transition though like _REG.
>>
>> Good point.
>>
>> This basically means that the upfront power state check belongs to the
>> logic to determine whether or not to restore the BARs which should be
>> part of pci_power_up().
>>
>> So now the question is, if this upfront power state check is done, is
>> it still useful to read PMCSR after calling
>> platform_pci_set_power_state() in pci_power_up()?
> 
> Or what about using the following sequence:
> 
> pci_update_current_state(dev, PCI_UNKNOWN);
> if (dev->current_state == PCI_D0) {
>          /* No need to do a full power-up, just sync-up the platform state. */
>          platform_pci_set_power_state(dev, PCI_D0);
> } else {
>          /* Power up the device and restore BARs if necessary. */
>          pci_set_full_power_state(dev, false);
> }
> pci_update_current_state(dev, PCI_D0);

That looks great to me.

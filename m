Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011048.outbound.protection.outlook.com [52.101.62.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD10A2475CF;
	Mon, 13 Jul 2026 03:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783912938; cv=fail; b=m1OlqTi1OkcV77ynxw+mewnHgT0zMiDasXRz4YSyFasnksDGJ1tTvbfIZo37cQeFm+y2FBCqTwKT1mJaLvLvCP3xbIrWrdIAf84umEkhJRQbSnrbMvcvJ+wjxKyrRfqVRKvUgWs3FUShcwCplXBIyVLpxiCRRkvzwfV3igDWtPk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783912938; c=relaxed/simple;
	bh=qeBoTdnJ1bzWHZb+IQvGiwqJY0Z9BE6T+Vb2Ce77A1M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=q75XgzQImCFyNWbwxonU1rSA78QRUkKx46rmGftf0yNd7V7hmWzZZWPPnumiirtoychqep0cjW6Y8z7QMK0d+6DqMZdrMfVdLTyvmTZdOiSwcynLsRvtVuccX7YGs1xknjQz6srGI1phh5k/nucItjiEhIppzKaSdvBQx1GdiR0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Sna5nQ6J; arc=fail smtp.client-ip=52.101.62.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Sna5nQ6J"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RNiCKf6OOi7UKHx/977E/t9PZ4A+IxqPKeqLbgtcmCdBFrxztBCDkjHue1Z+EbjjjhadklZcpvcPSJoZE+LwpFwiZS0IopAdDG3m9UfZAdxD29kVMqSB4jPjW6ISUwzHr0m2gG7qvmuZQgWqwg6dyVIy/kRxIZ2qEF5cULeMah6oB6pRO0VMc1wOVgE9/2bazFkwhQR/dsJ4WEIeCWy9iW4ir/TblSr1v6V50MzZIgVwpI07DJZ/45fjcBlcaX8cnjLwZXCHgsfYLFOvjL6Dh6GUOM1TXBvwROzMmiazPFIXeDSy7VnYLrbX3uLyxkOR0tf0cuz1z9H9hbidHbengQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fwiSXvKydvze6h3jB9Regde4xCLm5bFLD9D2qnwR6XA=;
 b=YOn9V9+ImJq3LzEY4w6kpl64G7OOrf4+O5MHpK+0tA5ekOXvIOTHYNwgmF1fSc/iXidzDuFn3//Vy0INN4ym7ghvKxcDM4YJKJkFKTaM2Fqrwvax7t0YD7lhG+9P87VljmixuTfUxhHpV4tUJIpRkAvCQhSWmGtZdkP+ZGcHOJuBLXCNvMPFbmLy2CMRPqaeP7WNxdDPr3X96GzdulEtqBb5UOX3pjYB7SS+lIfNG3D+EfUzDM4Oeu0BuSNScGMzmZqWW2M1XdG/gnK/Z5tvw00SOE6HUhHlCK6zi0TMcIOBJf02eUAfo8EyHYG7kv6t3mJ1YdCuj1V6+wj3UxRXNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fwiSXvKydvze6h3jB9Regde4xCLm5bFLD9D2qnwR6XA=;
 b=Sna5nQ6J0ifUUiw/NDv8b5a6UdJ7L7QKkrW7D0RuRv1mX5iEJNHUKsqeHBnKRz7hM6yg+BwyrmZMIECCbiyK0vpWP1SbY6N5cA4/NkVJ9TvkWdQMRfi/B1run/uP2r0HzWFNLx3C2jwRra+LGWpF5c07dWZk4eZeF2Sp/+cGsYQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by SN7PR12MB8026.namprd12.prod.outlook.com (2603:10b6:806:34b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 03:22:11 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%6]) with mapi id 15.21.0202.014; Mon, 13 Jul 2026
 03:22:11 +0000
Message-ID: <b58496ec-1af9-48a6-9e50-45948726b399@amd.com>
Date: Sun, 12 Jul 2026 22:22:07 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: Apply mandatory recovery delay on return from D3cold
Content-Language: en-US
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, mrh@frame.work,
 stern@rowland.harvard.edu, hannes@vonhaugwitz.com,
 jase_harley@protonmail.com, superveridical@gmail.com,
 david.c.hubbard@gmail.com, bugzilla@logical.ink, michal.pecio@gmail.com,
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org
References: <20260710201658.GA987633@bhelgaas>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260710201658.GA987633@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN1PR12CA0024.namprd12.prod.outlook.com
 (2603:10b6:408:e1::29) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|SN7PR12MB8026:EE_
X-MS-Office365-Filtering-Correlation-Id: dac8a633-5e10-4e8c-36f1-08dee08ded25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|7416014|376014|6133799003|4133799003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	yU2a7LTKrP4vOWzLxR+L+TtTDH/Guk0G2USadr6gwFodrzy0ybCllo/Q33MErLFBmxSCykrbhm77DjxDR3R6Cfk66BGFNzj2fgg7Va7giRmmyzvl+OI25g7hRk/vk2qtfaJoYhFbXJNqZvqaOtcZyHyiweefsQ2btqXE2RceP661IOmYeQ7wZL5gNJ/MPf+gv6vuXM9z6PRDXbKzGP/HavbOqC+2pwzSqZA2fAquAleGz2Fa6HqqQL2KJHJLyPjshdmq10gvlHuv7m13FAcUZrPMtC2kjp+NVnOEt/O2UNUndsOgfyeA9LQ5xGkXCYUwE6cRmjLrfmrEzZFJ94MzpobTpDbXHmExwVMpYMlv5R+GJEKe3bRz5/3C+jTITsQYRCbeORI/VlI8347Z6T0StUjodf853fzzxkQPoohHj2bZBnsK42S31qDP0/x0u7QvwipaxquMKEeI+15vGKt2nKDOn0lqSwTpdpvGvnZDGdVCYMl5LJ4wbDgWbxER/EdUFAjOxb2a4pyCdM008Np2GH/MYoZMCHl5AEfMfLu2J4D8iklCmUAa7Kx/tavBYzOs2fnf9OVullB7BSNJvmSgt0I4Rvhod1R/r5mAHh3nj1E1RsG5MuIi5BZ6htfZk6f/1ywEARwO+ETwjuap5V70RPZbCwvLFYL2DgaaAW1uPFs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(7416014)(376014)(6133799003)(4133799003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZWFRY0dMWmljRUVWcDB1Z1A1SEVqYkdaK0NHamM1WDNabVBUZXdWTTEzZjhs?=
 =?utf-8?B?RnJ1WWtGV3ZLQkhXZmJ3MDJ0UVl1WlV5cWdKaHp0ekp3TDk4aG9HSmVwMVlD?=
 =?utf-8?B?UTQ1OXFpK2FXSDdQVjMzWG1yeHNSSGFxeW5xMGdEYUhmVCtXakkvSUlhb0Iw?=
 =?utf-8?B?M2xoK3M3SzNKZlBlVlBsVFg4V3g5ME4zaUJOZmtCTittNk05RS9nYXFYTHRF?=
 =?utf-8?B?Y2w4bGdwN2R5bk5HMkZuUTdvTnMzeEh2OG13d2VrcWxKbU1DQzhvRUdNdFFl?=
 =?utf-8?B?MVRLTy9maVVFRHYzSnJoakxGUjVmTmVKcGxGL251ZnJmUjhFS1pxUWZFMVo4?=
 =?utf-8?B?eHkrZmFRLzFpcm9hUWNNRUxteFB4QkVWL1prZ01BcHkrTjR2MkFBUWx5bzZv?=
 =?utf-8?B?ZkNtSEdWVXlEQkkvSjYrUCtRbTVQdFR5N3Z2K0dZZXNwTkhIY3Z4aCtjWVhy?=
 =?utf-8?B?VlJzMWlPd3E2c2NURnJBazlWM1RtYXgwSHR2NU9HUlJ6dHY0VDJzSzU2RGRF?=
 =?utf-8?B?dVU2eEhqK0Z3OG4zc3d6ZFhremN3VGE4Q2VvQlFZUjNvZFRiMnp5Zzd3dkgx?=
 =?utf-8?B?UWVlRVN2a2g0ZE93M3VUSkZHNEk1MmdqOUZmcUx6bVFOVkJjb002NEI0WFVy?=
 =?utf-8?B?MGRDL0ZSR0lKSkxabEFJMndPNkkySFVzWGI2R1MwV2ZCYlovWFdHOGFjUjRl?=
 =?utf-8?B?VmNjWUZKbkNaYk0zZVlTcGt2SUs1WCs1K0Vxckt0ZE1sMU04YnAxTVJOTEJX?=
 =?utf-8?B?aTBrK3RCV1JlcGNnUmFwRFRueGwxRlozUm1NVHpXem93QU5Pb0lkNzJ5Sytq?=
 =?utf-8?B?UnREazFzU1hydnBtQ05kRFh0dVNBem85M01na25ISUVtVzlmZGtaMVM1c0Jq?=
 =?utf-8?B?Wm9ISEN0Qlo1aFczZU1OektvNjBrci9YNFI3bm5MMFBxK2oyRnV5c0VTRVBv?=
 =?utf-8?B?MGQrTm5EeHh1cjQxaVFKeUZYTWtvYnJxWVl0czNnWTU1SDBtT05tQUJVN0N5?=
 =?utf-8?B?M3UyZ1hNaUJycy95bXJEeXNoYklaWlZqaC85OW9EL3ljNlI2NVRma01vUCtu?=
 =?utf-8?B?U3pDN1BLejk5STBWZTIwanV4aFp4ZkZJR0grR3YwbldnNjBMUHdqenNDcFlv?=
 =?utf-8?B?bC8ra2tOZmtDcHBqVWw3VnVvL1oyRENrRG1KZG8zbXppR2gxYUZHWCsxcnE4?=
 =?utf-8?B?S3ZLWU9jeDRVeFdhYWFucHp4SklUOFhWdlVCTzNrUHgzaVJXcms4dTVtdlp4?=
 =?utf-8?B?MzBRK3lUelh1WFQ5aFBvYlZiWk94SVhOTlJHdjlFL0NyaENLY1o4dUlkNExI?=
 =?utf-8?B?OFZuUlovOS9iVlJuamR1ZDh4Vy84QVZIWmZJZmdKYzZIVUZKSkVrYkFRYjVQ?=
 =?utf-8?B?eCsvVmtoL2VnU3l0TEJrOHJGYjdCbEZkV0hCSDhFcnoyTk5lMDNiQ3dCeExG?=
 =?utf-8?B?REdSZ3dQRGFFUVY5TVQwNDRoZFNKRkFuM3Bkd1EvZkRYL1JBUFN1MjQwaDlv?=
 =?utf-8?B?elR1SDM5ekpVQ0lGTm9DZ2wvKzQrMGZnbjAvN0pwQS9JQVJYSDJqNUpiTysz?=
 =?utf-8?B?ZkFRUHV4UDNMQ3g4andKanUraU1nODZ6QWRlRGZyMXZteGtqbjd5eUQ2RHpV?=
 =?utf-8?B?a2JZamhsTUhUMGs3VWFreXRjUVZaWlRSOE5TV2VLOFZMOHRhOW1KMU1NRk01?=
 =?utf-8?B?dDJ1YlduczRFNytLZU9WSS9xUmdxcHJpWTEvNzBocG54VU9tUFRXZXE5b0xy?=
 =?utf-8?B?K2lmRzdSOHYwT0xNZklvZE8yYVhZL1dFT2hZajRYWlM5Z2hVL0x6eXZSL3RT?=
 =?utf-8?B?WDZNRmdYWHo5LzZmcUF1a0RQYUxaeTY0OUZmVDJiRHdwQWk2eG8yRWZ5elgw?=
 =?utf-8?B?UjBkWmhRUDM3QnBxb3RqNjFxSlRqR29BUnF2Z1BMYURobjdDNFREUWRvZytB?=
 =?utf-8?B?NEJobEkwZDUwdGZITHpmcE9zU01nMDBVQ0FsQXNBWXlUS09xSksvcG8rOFVj?=
 =?utf-8?B?ZEx1Y3cyMlhvWlljTlI5ZTRVRjREa3dQMmx4NDNKQmxyNnBlclhtcXRIVWJw?=
 =?utf-8?B?OXhoeU94UXJYeklTemRnUUZwWi9nNm4wVzFGVjU2U0J0cW5IZlc2eUZHM3B3?=
 =?utf-8?B?am5lL0d5TDdsWlpCT2xBVHB4REVjTGFIWUowY2tMcjRBaXJvYjNIV0VaZ0FF?=
 =?utf-8?B?UUdRdUtwTDhPWTRYdTFjNmp0MG9lSkY5Mm10TmpiWlFSdEhGYmRzbzA1a0Jp?=
 =?utf-8?B?L1FDdlB5Q3V2Q3dOd05KSXNUNHB0MUVSRnl2ZVRPVkY2ZjhDckRqcVc5OGg0?=
 =?utf-8?Q?aGhjjsSJSfh28IE2g7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dac8a633-5e10-4e8c-36f1-08dee08ded25
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 03:22:10.9120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TF1a1uWrKR5ibzWWUQNH4JUE1Il+uWffvAkhpgoef6sUDlFYamR0j6J6QTT4sxSeuZ17hYiBx77bT+z3k/40yA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8026



On 7/10/26 15:16, Bjorn Helgaas wrote:
> [+cc Rafael, linux-pm]
> 
> On Wed, Jul 08, 2026 at 10:26:50AM -0500, Mario Limonciello wrote:
>> Per the "PCI Bus Power Management Interface Specification", rev. 1.2,
>> sec. 5.4, there is a minimum recovery time between programming a function
>> from D3 to D0 and accessing it.  The spec does not limit this to D3hot; it
>> applies to the D3cold to D0 transition as well.
>>
>> pci_power_up() only honors this delay on the D3hot branch.  When a device
>> returns from D3cold, platform_pci_set_power_state() has already restored
>> main power before PCI_PM_CTRL is read, so the state read from the register
>> is D0 and the transition delay block is skipped by the
>>
>> 	if (state == PCI_D0)
>> 		goto end;
>>
>> early return.  The register value is masked with PCI_PM_CTRL_STATE_MASK
>> and cannot represent D3cold, so only dev->current_state still reflects the
>> D3cold origin at this point.
>>
>> Apply the delay based on dev->current_state, ahead of the early return, so
>> it takes effect on the D3cold to D0 path before the device is accessed.
>> Use the device's d3cold_delay, which the platform may tune via _DSM and
>> quirks may raise, rather than the D3hot delay.
>>
>> To keep the existing D3hot callers unchanged, pci_dev_d3_sleep() now takes
>> the delay in milliseconds and a pci_dev_d3hot_sleep() wrapper supplies the
>> D3hot delay as before.
>>
>> Reported-by: mrh@frame.work
>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221073
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>> Cc: mrh@frame.work
>> Cc: stern@rowland.harvard.edu
>> Cc: hannes@vonhaugwitz.com
>> Cc: jase_harley@protonmail.com
>> Cc: superveridical@gmail.com
>> Cc: david.c.hubbard@gmail.com
>> Cc: bugzilla@logical.ink
>> Cc: michal.pecio@gmail.com
>> ---
>>   drivers/pci/pci.c | 26 ++++++++++++++++++++------
>>   1 file changed, 20 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index 77b17b13ee615..e09cfb28fe61c 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -81,9 +81,8 @@ struct pci_pme_device {
>>    */
>>   #define PCIE_RESET_READY_POLL_MS 60000 /* msec */
>>   
>> -static void pci_dev_d3_sleep(struct pci_dev *dev)
>> +static void pci_dev_d3_sleep(unsigned int delay_ms)
>>   {
>> -	unsigned int delay_ms = max(dev->d3hot_delay, pci_pm_d3hot_delay);
>>   	unsigned int upper;
>>   
>>   	if (delay_ms) {
>> @@ -94,6 +93,11 @@ static void pci_dev_d3_sleep(struct pci_dev *dev)
>>   	}
>>   }
>>   
>> +static void pci_dev_d3hot_sleep(struct pci_dev *dev)
>> +{
>> +	pci_dev_d3_sleep(max(dev->d3hot_delay, pci_pm_d3hot_delay));
>> +}
>> +
>>   bool pci_reset_supported(struct pci_dev *dev)
>>   {
>>   	return dev->reset_methods[0] != 0;
>> @@ -1333,6 +1337,16 @@ int pci_power_up(struct pci_dev *dev)
>>   	need_restore = (state == PCI_D3hot || dev->current_state >= PCI_D3hot) &&
>>   			!(pmcsr & PCI_PM_CTRL_NO_SOFT_RESET);
>>   
>> +	/*
>> +	 * A device returning from D3cold has already been powered back on by
>> +	 * platform_pci_set_power_state() above, so PCI_PM_CTRL now reads back
>> +	 * as D0 and the transition delays below are skipped.  PCI PM 1.2 still
>> +	 * requires a minimum recovery time on the D3 to D0 transition, so apply
>> +	 * the device's D3cold recovery delay here before it is accessed.
>> +	 */
>> +	if (dev->current_state == PCI_D3cold)
>> +		pci_dev_d3_sleep(dev->d3cold_delay);
> 
> My understanding is that the "mandatory transition delays" below only
> cover a transition caused by the write to PCI_PM_CTRL, which would be
> from D1, D2, or D3hot to D0.
> 
> If the device started in D3cold, platform_pci_set_power_state(PCI_D0)
> should transition it to D0uninitialized *and* take care of any
> required delays [1].  The device should be Configuration-Ready upon
> return (and we've already read PCI_PM_CTRL above, and the read
> returned something other than PCI_ERROR_RESPONSE).
> 
> But evidently adding more delay does make a difference, even though
> the config read of PCI_PM_CTRL seemed successful.  I guess it's
> conceivable that platform AML doesn't wait quite long enough, although
> it does seem to affect more than one platform (AMD Strix Halo,
> Framework Desktop/AMD Ryzen AI Max 300, Lenovo ThinkPad T14 Gen 6 AMD
> Ryzen AI 7 Pro 350), and I *assume* the issue doesn't happen under
> Windows?

Based on some more testing that occurred this patch doesn't help.  Back 
to the drawing board.

> 
> [1] https://lore.kernel.org/linux-pci/CAJZ5v0iZN5NtUztqe=MxCRcXdBaaqzZ749OqSUkadwwBy0ugUQ@mail.gmail.com/
> 
>>   	if (state == PCI_D0)
>>   		goto end;
>>   
>> @@ -1344,7 +1358,7 @@ int pci_power_up(struct pci_dev *dev)
>>   
>>   	/* Mandatory transition delays; see PCI PM 1.2. */
>>   	if (state == PCI_D3hot) {
>> -		pci_dev_d3_sleep(dev);
>> +		pci_dev_d3hot_sleep(dev);
>>   		if (!(pmcsr & PCI_PM_CTRL_NO_SOFT_RESET)) {
>>   			ret = pci_dev_wait(dev, "power up D3hot->D0uninitialized",
>>   					   PCIE_RESET_READY_POLL_MS);
>> @@ -1514,7 +1528,7 @@ static int pci_set_low_power_state(struct pci_dev *dev, pci_power_t state, bool
>>   
>>   	/* Mandatory power management transition delays; see PCI PM 1.2. */
>>   	if (state == PCI_D3hot)
>> -		pci_dev_d3_sleep(dev);
>> +		pci_dev_d3hot_sleep(dev);
>>   	else if (state == PCI_D2)
>>   		udelay(PCI_PM_D2_DELAY);
>>   
>> @@ -4511,12 +4525,12 @@ static int pci_pm_reset(struct pci_dev *dev, bool probe)
>>   	csr &= ~PCI_PM_CTRL_STATE_MASK;
>>   	csr |= PCI_D3hot;
>>   	pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, csr);
>> -	pci_dev_d3_sleep(dev);
>> +	pci_dev_d3hot_sleep(dev);
>>   
>>   	csr &= ~PCI_PM_CTRL_STATE_MASK;
>>   	csr |= PCI_D0;
>>   	pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, csr);
>> -	pci_dev_d3_sleep(dev);
>> +	pci_dev_d3hot_sleep(dev);
>>   
>>   	ret = pci_dev_wait(dev, "PM D3hot->D0", PCIE_RESET_READY_POLL_MS);
>>   	pci_dev_reset_iommu_done(dev);
>> -- 
>> 2.43.0
>>


Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010046.outbound.protection.outlook.com [52.101.56.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BCE408023;
	Tue, 22 Sep 2026 20:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790107227; cv=fail; b=f8t1dndEM2VNipBvYiPAaQKQVfEN3OwQfv6RNNpxSBAp2Zb51FRvFmp5MxkTFyDqrIoGQDH6MvwEAINp/bopr2fTYEwcBjPqJvdJ5dXa9v9eu4dr+zcJbbfDIiFsp5funw/eEaj0QS4sZsVt0WzuMAlRM187CsfXDELaHocZlqU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790107227; c=relaxed/simple;
	bh=9hzRwm/cwkk9ouG6X8bimtYro4gax5/sSGesu4/bvnc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cikqs3AUJ9xAiyD5tvHa2nrmm7ermzjb60GNFl4SIF1UKoWG9kYrS0EWDpkX1GaF2xlb28hBqx0v5Y+/BJowUeUdxuesGGtoPagEgH2i9BFmpg7LOngedRIWmOXn6wHA4b0ggNBqOx9zg2G6g6nws0GYqWSB3mcxdMKdhRB1yQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Nj73Q4Uf; arc=fail smtp.client-ip=52.101.56.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Nj73Q4Uf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bm/Ue6mm2nucxbMi3JP6aXCK2C5usnMWGuGjhW2esZtQ5n1ITQ0LdNDOLMwnzea0JagFxEpDBoEQSvLSmt1CYkPFMuZLgT0PnghO6avzHXBLHlWR5ZPePbr1r1BXIlTarX+750HOfOh/MNukv1mTdMzoZYBGGXGga2AJZVIQBYuQp+01Moop9rgVdE2dUwfpt8vSUe5MD6t3zu98qSAWWhnACRWxfoudKqh6mSfllIel/JaGUEO5Q4jgBvdGoTnPxa8DO3h5mfH7MBZCn/WC9tkeu6Bqu7IYsuSN7GjZWP24NRuceTGvG6aUnSacIcPv/KIo0QSAKfuBp5+40IAMaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FhgGkyxuDRLeQSL5yk/ipbrqGWEgaHqN3S/1zVLX3c4=;
 b=TSS5yM0pSFvPL/IVhs2JyC4flQvplFtrSc4keReqEmzRAWelNyvZk46+Tkkg+MUIE9/gYjz90vKyrMsGH5qtnU6XWqidBZC4vB3Yri6FZXTwlkSuxkhjVxKWUTU2mQVRLsjjadlcnWC9HjstUACc8IGMasVn722g/JannDSWWLlOjZE8tIHjE/Z9VWwM2vdb/0SM9DES6n+/1jAlbJHTsIBbgQHkcnFEynR+T3zHL3u7olHo6hYgocCYNXWrktEPXqeK809pEU1FrCfWmmBPOKorGOTZi2vNdGv3UdVLzBFLZ7N3XYZ8eNaFKCYy8fVXW9s5A73KS7GiO4zbRKndMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FhgGkyxuDRLeQSL5yk/ipbrqGWEgaHqN3S/1zVLX3c4=;
 b=Nj73Q4Ufx0prpZKdAqR1zP2Tl4eIHBAOGswhyavuQwt5JC1OK+I9+vIfmepdQbBf8I0ZUG0Rg/MRZdUlYJF42AYY0VhXq2pcXWCsSsdKW/DzbHDJvfiJShPBPpyVSBI36ZXLrMHI2rpHBYl5N6GG46xinprpMa6FoSqNc0xv53I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by BY5PR12MB4067.namprd12.prod.outlook.com (2603:10b6:a03:212::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Tue, 22 Sep
 2026 20:00:15 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0451.014; Tue, 22 Sep 2026
 20:00:14 +0000
Message-ID: <eaaf891b-7b0b-4eea-b104-de2c0db7cb42@amd.com>
Date: Tue, 22 Sep 2026 15:00:10 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] PCI/USB4: AMD Phoenix 1022:14ef runtime suspend prevents
 JHL9480 downstream enumeration
Content-Language: en-US
To: "Kovacs, Alexander" <Alexander.Kovacs@amd.com>,
 Freeman Z <SHD-ISAC@outlook.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "westeri@kernel.org" <westeri@kernel.org>,
 "andreas.noever@gmail.com" <andreas.noever@gmail.com>,
 "YehezkelShB@gmail.com" <yehezkelshb@gmail.com>,
 "rafael@kernel.org" <rafael@kernel.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "S, Sanath" <Sanath.S@amd.com>,
 "Natikar, Basavaraj" <Basavaraj.Natikar@amd.com>,
 "Martinez, Juan" <Juan.Martinez@amd.com>
References: <TYCPR01MB1092795BE7AB51121BBAB292496862@TYCPR01MB10927.jpnprd01.prod.outlook.com>
 <20260921050450.GM106095@black.igk.intel.com>
 <f8b929da-b4ae-48ae-9667-3eb93aa0a4bd@amd.com>
 <TYCPR01MB10927E6DC71CDC3B39C26F35196832@TYCPR01MB10927.jpnprd01.prod.outlook.com>
 <BL4PR12MB9533BF5ABF7035E6DF151C0A9C832@BL4PR12MB9533.namprd12.prod.outlook.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <BL4PR12MB9533BF5ABF7035E6DF151C0A9C832@BL4PR12MB9533.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0415.namprd03.prod.outlook.com
 (2603:10b6:610:11b::26) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|BY5PR12MB4067:EE_
X-MS-Office365-Filtering-Correlation-Id: e9e9524c-b873-4fd5-af8e-08df18e41d98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|7416014|10067099003|56012099006|6133799003|4143699003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	92YogMmYNDdYItOUOducraRHsOEA0gC//3XqXRVthC387cHI+8N+VpjCYaTPfTZm0xAikzbfFo+aP5wksbzYsMr2TiQaNiW1acoY4THuQf34G9CyVnFAJNhOzJ+dnFGRJcf7WonPP5OaSRxeck770889ca3CMsvw+jBS3bSZf8gp2ledtaILPj1cTmOQ8WffWDfp0sTyCEHlUKFs3CixJ0jpjEDd1V6ouDVzWhcf9mkiX2nYDYr30baZCDlOUqH4hMIYDsXxaoPaLWUd2fgGTmxXdXZr/beuig1v/K/Qh3DpsAM9zKb2r3oi184AFfUqSFD+Opvyef08ppYaY1hCXbQpitphU0mRdePHDVfdF6zlUa56+p4rtttgePbq4dVnxLUnbMe60uxQqOM4mAEJjpEbWb2IuZuh0j+X+yJftl7UTtOP+gZ/sLNMh/XjYrnhh2JZn6ta3e/45++UaoAvzrKxM5DHLwVJ3BdKK292CvTfZIhTIexiDqAXjpQ8IaaMt/s3J6DGkSjbO2naFtt7UevdPpkWfEc8+cXms4K3ZJcQTMUsV8icPLaFIgL4I4a94okFXgJpG61vL3+Et44BELAwCwp1WLCs5CHb3rvFnFOIU+Cx/iqGF0/RXUch+ASff70VL3EpsUnYjGWzawPpL6b4GTfbjMb6Pmlhm6L1Jwo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(7416014)(10067099003)(56012099006)(6133799003)(4143699003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZFdES2hjUkpnRlFXa3lXdVA4TlRBMGE2NjVVNWt0eHB2eUdObXk0dzR0ZW9k?=
 =?utf-8?B?Y3lleTZPMFYxa0JoZVBxSWFUVkNuL2M4NmtuaGs4ZCtHK21vTytCcXRMQXQr?=
 =?utf-8?B?V0RRL293MUdxc0x3TnFndTI4ME1vamF1KzBhL1VRcTNSU0hCdXRWUGp3T0VU?=
 =?utf-8?B?eGZkam03OFk0VEF2RjdjdnUvYUVDODRVc3pMUS9SbjNnRUFiNnk3VWNLd0JS?=
 =?utf-8?B?OVdjU0pWa2g3OEZmZyt6RGMybm1xck1ySUZxcjVRbng0WkJPbE45cE4xbzlT?=
 =?utf-8?B?U0NzaFBkQkxrVUp0WXJJSDQxcDFrekxyOU5EcDZMVFBudGU2V1VGK2lPWU9M?=
 =?utf-8?B?TTgydFNsWHBLQjBrOHJ2dUM4MWJJZCtuTUttZTRRVldMY2JrYXNqY2xldWpS?=
 =?utf-8?B?aE5xM3pDTTkzbHpBbFVOZ3FrbDFXMWJmUEQ1TjJkTERIMnI0RlpuTFd0K0Jy?=
 =?utf-8?B?L1ZCMFpUakRHSmtNOW9YTW5PMUhpVUExZEd5dDQrTFJEUHVlQ0s4RG1pbVRI?=
 =?utf-8?B?elZtU3IwL3BocE42NHVRTUFDR2p0cVlkaURPM0VSUTRkZmh3NU9ROGRIZE5L?=
 =?utf-8?B?bXRFR3RxWnFnZkJzTGwzc0I3ejExT1cvTVkzbkkyZmNNSUE3NnU3Z2w0TXlJ?=
 =?utf-8?B?SVVobmJRMTgzVHdXK05OY0E2bjJPZjVUa2RzNkRJN3VBTC9mOTV0cXZWdlBI?=
 =?utf-8?B?TndJL3llcWVOeU5LdlE1Q3VHOFU3THU5MFJoM3BweC81Z0tvdVI3TTVMMGRB?=
 =?utf-8?B?MHh2bFZqbDIxajBoNDRCdmZuU3k5ck9iU2JMSTFjQnBRVThCVE8vMFpWamlK?=
 =?utf-8?B?TFU0QmM5Rlk1S0tpS3BzQjRwd3pKMzRsaUkyOFhDWllQU2s1cXVrQmtpdm1J?=
 =?utf-8?B?aFZBUnJkWFdaUmtBRmtKbnpIU09rTk1OZ1cwbGZPeXhnb21TS280QW5MZ2lN?=
 =?utf-8?B?ZzRabW1zdFRkY3NHZXpSd3dGbExFYmtxNGhzUUlUcU1Cc1lIM3p4VDhLT1lh?=
 =?utf-8?B?MVg4Y0tSWlV0TlByZzR2QXRUTHZUS3ZFblZkYm5QbHhzekR5WHhJbTU2WWtX?=
 =?utf-8?B?bjZaMlVFZGZCY1RVbHZzYzdqN2RYbE9sNVV2STZmNzZFWHppZ1RKcXlqVksv?=
 =?utf-8?B?Z3NjY2RtUFhXeC9QWlZuVnBpVFF5VGc1N2FKSmdJQmRSaWpjUERiaVdPVDBL?=
 =?utf-8?B?QVVxSEVWeEp1cmN0d2pwS2R2TnpKMWpIaHdGNFRQbW9aY01sQ0w4Q1ZJUnd1?=
 =?utf-8?B?YzFyaElrSnQzQm9Ha0U3Wk5MM28xNTdURWJHVWdsdXRjNlE3dW0rVjNRUzBK?=
 =?utf-8?B?bmtIc003dzNrd0VVOVU5eHhRQnRaTGR6YzB0M1lYRDJGdytCbXRVbmE1MzQr?=
 =?utf-8?B?RXRPUGlDdlhCN1RvV1hFdHZidURYZHVnWE93Q1pVSXFDcEdTZFpvY3JJNi9M?=
 =?utf-8?B?L054aU9DR3E5T3dRZU5rQXhVZGRLNmN0YSt3R1ZGZjVDclErSlZWakp2UWNY?=
 =?utf-8?B?QnlTZk04MFZVTFU2NnZNSFViNXh0Slphd0JvSEU2UEhuZVEwaUxoY3hHdmlz?=
 =?utf-8?B?SVo3MHN1d2ZmWmpnWmRoU0M5eHdsMWZEc0Y2NmJVMG9ZQ1hLS0FCQmkxUURN?=
 =?utf-8?B?Vk90czlZNXEzMEFiWXJjZGtJSlNxYUxrRmZLVUdBaGN4b01LQXhXb1BkN0tQ?=
 =?utf-8?B?Ly9RTDd3dVpEWnF2RnBpcmxRTGxCanFBb0tSVlVwUVVOMjh0M1oyMnk2WjJ0?=
 =?utf-8?B?TllMSWlCT2hWSktNVDFZbStkMEcxNkVlYnN1RjJJTkVoeTY0bHBkWEd6eDBh?=
 =?utf-8?B?N1pCRGFvWmJRTDZnbTMrRVpwM0pXVEFVZzk1T2RwQXR6YmdEcDFkOHN5Vkdk?=
 =?utf-8?B?eHNsOG9scEYyR2RYdC9OZW1BUnlka3k1bTg2VVpyVGFLcmtMK295cjRjdVRY?=
 =?utf-8?B?Ui9BS3dKSmNlazNPVFIzcEUrUmVMcDlFeUY1WjIrRlRhZUtMdnN4L25obkRr?=
 =?utf-8?B?SDlRNkd2VEw4Zjg2ZzNmWnhMRTRzQ2cxNTFhdzJIdmpjbmtKTGtUcHM5M2tS?=
 =?utf-8?B?eFFXTG40djhDdjJEUmp3YmRYT1RDdlRZN0xwRm9EZC9wb3lXaGVnWE50ajRy?=
 =?utf-8?B?RC9SRnB0OGhZZTBFM1BJTE84Q0VDZUp1cC8rdE9QVWdUMDU3WkpxcVFlMTIr?=
 =?utf-8?B?UjZOU0Q5WFhBT3NDWXJzR0xucy81Tks5cnJtUkFwOEFYekZmcjZiYy9qdDhO?=
 =?utf-8?B?NWFKMkdOeDdUYUtpdENZU0h1b3pSbzBybWQvMXVsL29ESWZ2VDloSTk4ZjZF?=
 =?utf-8?Q?eLd+axqmO3/IGI8fCy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9e9524c-b873-4fd5-af8e-08df18e41d98
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 20:00:14.0636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 00s96xUyKk0e3bQbb5DU5lfHC8K9RgjijIuOsbt95ar0pg6Y6oRzXMjDe9VJOHb/OuMhs1jNeBx7OaggI9cA/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4067

> -----Original Message-----
> From: Freeman Z <SHD-ISAC@outlook.com>
> Sent: Tuesday, September 22, 2026 11:41 AM
> To: Limonciello, Mario <Mario.Limonciello@amd.com>; Mika Westerberg <mika.westerberg@linux.intel.com>
> Cc: linux-pci@vger.kernel.org; linux-usb@vger.kernel.org; bhelgaas@google.com; westeri@kernel.org; andreas.noever@gmail.com; YehezkelShB@gmail.com; rafael@kernel.org; linux-pm@vger.kernel.org; S, Sanath <Sanath.S@amd.com>; Natikar, Basavaraj <Basavaraj.Natikar@amd.com>; Kovacs, Alexander <Alexander.Kovacs@amd.com>
> Subject: Re: [BUG] PCI/USB4: AMD Phoenix 1022:14ef runtime suspend prevents JHL9480 downstream enumeration
> 
> [You don't often get email from shd-isac@outlook.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> Hi Mika, Mario,
> 
> I reproduced the failure following the requested sequence on my installed CachyOS system with kernel 7.2.6-1-cachyos and thunderbolt.dyndbg=+p.
> 
> For this trace the dock was physically disconnected at boot. I did not run lspci before or during the reproduction.
> 
> Before plugging the dock:
> 
>      0000:00:04.1
>        power/control        = auto
>        power/runtime_status = suspended
>        power_state          = D3cold
> 
>      0000:6b:00.6
>        power/control        = auto
>        power/runtime_status = suspended
>        power_state          = D3cold
> 
> After plugging the Kensington SD5000T5 and waiting about 15 seconds:
> 
>      0000:00:04.1
>        power/control        = auto
>        power/runtime_status = suspended
>        power_state          = D3cold
> 
>      0000:09:00.0
>        missing
> 
>      0000:6b:00.6
>        power/control        = auto
>        power/runtime_status = active
>        power_state          = D0
> 
> The Thunderbolt dynamic debug log shows the NHI/control channel waking and the USB4 fabric being configured. In particular:
> 
>      thunderbolt 0000:6b:00.6: control channel starting...
>      thunderbolt 0000:6b:00.6: 0: resuming switch
>      thunderbolt 0000:6b:00.6: 0:2: is connected, link is up (state: 2)
>      thunderbolt 0-2: Kensington SD5000T5 EQ Thunderbolt 5 Dock
>      thunderbolt 0000:6b:00.6: 0:5 <-> 2:9 (PCI): activating
>      thunderbolt 0000:6b:00.6: PCIe Down path activation complete
>      thunderbolt 0000:6b:00.6: PCIe Up path activation complete
> 
> However, I do not see a PME message corresponding to the dock insertion.
> The PME messages in the full dmesg are the early-boot
> "PME: Signaling with IRQ ..." initialization messages.
> 
> So in this reproduction, the NHI at 0000:6b:00.6 wakes from D3cold to D0 and the Thunderbolt driver successfully programs the PCIe tunnel in the
> USB4 fabric, but the AMD 1022:14ef PCIe root port/tunnel at 0000:00:04.1 remains in D3cold and the downstream 0000:09:00.0 hierarchy never appears.
> 
> I attached the full dmesg captured after the dock plug, plus the small before/after state files. I redacted only unrelated local network identifiers, the hostname, and filesystem/LUKS UUIDs; the Thunderbolt debug data and device UIDs are otherwise unchanged.
> 
> This particular dynamic-debug trace was collected on CachyOS rather than the Arch stock kernel used for my earlier reproduction.
> 
It sure sounds like a PME doesn't deliver properly for some reason.

I suppose that while in this state - if you ran lspci the root port at 
0000:00:04.1 exits D3cold and 0000:09:00.0 shows up, right?

Does the PME show up in the logs after you've done this?

Any chance you can easily check Ubuntu 26.04.1 live media?  There is a 
7.0 based kernel there, and I would like to know if this regressed from 
that.

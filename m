Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazolkn19013077.outbound.protection.outlook.com [52.103.43.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D94A3033EF;
	Mon, 26 Jan 2026 09:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769418685; cv=fail; b=OQGxUt383gG6w/D91+AO3Y81jXDb4Mwp2EkMOXPeA7Tgnw3qBXW0OJwmbScjbyTUy8/uzbmbb5sWr0D3lZTR7ZN5Hq2g1c1S1kEyODvwBSTmnla9Vpfg6NNf/UAeV1CCjcjEjSgAsdwxnC9tfNIS+HKvc9IHfQrMBdG4nAFIzhg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769418685; c=relaxed/simple;
	bh=0xReLW4ErsWufYVFmkRrWIwmTwJzkfegrJjM3669HCQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=d9p8/aM4/HRwq/sNrN7OOjMX40w/B9CxU+cHDpa6ydtnJRHdcsqEAurECbrFnweucUDEHwwNaNW02GQeAKAByDGiEX1V4hGyGXtMY4uO9Y6k+T8eU4rFDeYUx7A1lCZNNJqZ/J62iBkWIWq0h7ESgToYz1V/jFkKRS1rqdTQYvk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=a15b1rJs; arc=fail smtp.client-ip=52.103.43.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="a15b1rJs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=upds+HVAUs3tjf8qwx5E0dmhO8S06LBLXKDStY7HUAOG0o3BU5SZZUzRTnoW/bGSoICJxWhbxCrVHT/IflLWOMZ3rwzMV71skOwvNeEX9WNNXtDnfoVSQV/NnNesV4Vj51s/6s7jAoajnWfVnyl3lOyevKcIHjaiPYPOdLpSOtADenOYsmS4Z5LYHV2p09NiqoEHcye0tgpSH0gjEasrdVKNPPwhOifL2c2x2+qV+NGUS2JUxS7/euQED5YeXnQF+emEXH6YQLgMl8uFeY+j1ocsOmRi37ZoLPOXbW1hnygyZCYmznI5/JRTe44OXecYZS9/7yV2/Dp4CTDVRNaJWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qjYTUrmWbe0t6cFjonzBvM5cbmj9bdY2dmO72jcQTYw=;
 b=mrGCwVUkb9cP8mvmpzmY1Gtrkm6x/+nieaLsql6cZFPFhc6PR5dsn1jY7sL43TkIcrjxWdo1cKFVXEf5ZyikZGFBn5H4cnXVz6BdBiongrNrv8IQNhigcboPrvj32qrqXqu8h5/Qb3G1IlhUa+H7bpQqcSaAhoMkM5/i0HrKrWxu6eiXrG3VfLOx7VCq3dGtiR4WFZU6xkzkp1IbgI0SpaHkc3KNkwr6Qpb6w1G581NGjMSzi2OQ/FU2c4LZ9IQ9XhVgCrrH4a/3zbKjdYmoDMcUO1QB9XZjmXP0jrUCqzEmLj6PLDSH/KlZ/t5vQt2SG4COdX6xLbcfrtaKbA1FNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qjYTUrmWbe0t6cFjonzBvM5cbmj9bdY2dmO72jcQTYw=;
 b=a15b1rJsaL2ELFN5nmWAWXWAs8oMzIXLaqaiTWRCr9z5D1AQ4EYufR+3PZRJEPeDfj6DSRs39p2HANChsV0ZUQM5PO35MqIZ7aW6R7oDg2lJYfw9NqPMVfVfy0acrwtT8ZsBrTaSjmiyPygjsoXkUq8aFMQELLb3qJcR+jrYtGDdTlECCv3Oy8COwr72JnyzzpnlYoQ2XZsK8+TBN2vLAaATE4oVmQ+zXJvllug8N5X+/zQBe0Y69wdH/fIWFovd8iW/mZrXPdTAFC03V0zJ0A5jDMyirbGmsV6vylrvfBCvT1RpviX9lWRp/KnI8UwvUan4NU+lH19bhMtbc2lghw==
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7) by KL1PR01MB5447.apcprd01.prod.exchangelabs.com
 (2603:1096:820:c7::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 09:11:19 +0000
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c]) by SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c%4]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 09:11:19 +0000
Message-ID:
 <SI2PR01MB4393D4D3E28FC1E22E3DF3CDDC93A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Date: Mon, 26 Jan 2026 17:10:18 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] PCI: Add the enhanced ACS controls check to
 pci_acs_flags_enabled()
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: bhelgaas@google.com, akpm@linux-foundation.org, bp@alien8.de,
 rdunlap@infradead.org, alex@shazbot.org, kevin.tian@intel.com,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <SI2PR01MB4393B836EA4FEDD1823483BADC94A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <SI2PR01MB4393ADC9C367C4A6F8032A02DC94A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <20260123145113.GA1134360@nvidia.com>
Content-Language: en-US
From: Wei Wang <wei.w.wang@hotmail.com>
In-Reply-To: <20260123145113.GA1134360@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SEWP216CA0027.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2b6::16) To SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7)
X-Microsoft-Original-Message-ID:
 <4c42ad62-0fc3-462b-bdc9-c64b8dec6cbc@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR01MB4393:EE_|KL1PR01MB5447:EE_
X-MS-Office365-Filtering-Correlation-Id: b44a0435-d4ba-418c-2569-08de5cbadd85
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|37102599003|8060799015|12121999013|51005399006|5072599009|6090799003|19110799012|15080799012|23021999003|41001999006|461199028|1602099012|4302099013|3412199025|440099028|10035399007|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WDgrd29Gb0p0NjRndUxjd1NTeGtxRlBtb2FDR29UTjNUd1pDNUY2NjQ2WWcy?=
 =?utf-8?B?MXNBc1hsbUlxV0MxNXFqRDhERnNKVHovZVkxUld3WlpwQ3RSL0RaTzFpZ0FS?=
 =?utf-8?B?TDVDS2crRVRLWHZGZTZtTjNuSUpoQk9pK2p6QktiZ2UyczNEOUNwcGFQeDlF?=
 =?utf-8?B?ZDVKZkpqMG5sU2MrNnNPZnZ1cjQzcFU0a3JiVFUvZjNhRXZRbzh3TmpFQWE2?=
 =?utf-8?B?WnNnVUQ1Nk9jb3FoTWpBUUZzd0JUbkRJTm5HKzFuWXVSbzNzdXFXcHRBMnUx?=
 =?utf-8?B?SlpETzVvajh6T3ZHdGVIcElaRG1oaG15S2ZCa3VrNG1pOFVoMTdpdmtxNU5l?=
 =?utf-8?B?LzFKdnVBbmxvWEpGN3hSWjcrMVZBcEZvWWpMVGhEalN0R1NyZ1FONE5sZDJI?=
 =?utf-8?B?TnhpdThlZU1VdW5hTU0rQnROMC9aYncrUzg5R05ZbWF3VjBrS2l1TGFGQ2pQ?=
 =?utf-8?B?c0luSnFmMEpCVFpkSllONkwwK2oxc1UrMmxLUksvbFRobHUweHk3VjU2OGN1?=
 =?utf-8?B?NkxxUkRON1F3Sk1zR3I5NkQ3UFg5ci9wbzUzTFliV0JlclI1NkVYR3g2UDcz?=
 =?utf-8?B?STJSVlhpSjM3c0dURWhRMkI3Vy83d1MzU3UyeWVtc1ZkUS9BMzE0THJMcmFm?=
 =?utf-8?B?UTZSTFprLzY4dnNHYjBvaCtKeUZwc3AzdWpaVmI3UE1iNzNyM0Jza0c0OTJs?=
 =?utf-8?B?bHdHcVd6dXV1STdzS1crdzRzRGZiSnR0MTZ0QmozRlRQQUpmK0tIMzdQR2JV?=
 =?utf-8?B?T3Rqekp1TUJpMXpHRFNocnJhUGNZcks2Nm9LUktiSTRoMUp6UWlYclBPU0xz?=
 =?utf-8?B?TVZrWjlDck05ZmtuL3JhYTBRN205M2luK2p0b0ZVRkxRRE9vTE41S004ZTRi?=
 =?utf-8?B?Mm9GYWFQVVJtaWp3VmV2ckNlb0lsRFlBY2NxckFrcE90ekN4T1pTeGt4Y3Vp?=
 =?utf-8?B?VWNTSlNrOFlpRFVOaVFkcUtqcWNmdzhKcEFXWko3dHNZOXRMWkJQQmZJa3ZK?=
 =?utf-8?B?c2RqYXk4VnM3RTJKUjM4SEF5NmNnbVJhMTNOWENlWmx1VEZaNTFQNytmc0pT?=
 =?utf-8?B?OFhZajZ6eGVjRC94NWNaNUN2YW9QWUVqdVhqdmE5Q0VjQnUzYzM1dVdTblgy?=
 =?utf-8?B?K1NmdHFyeU9UR1FQczViM2l6TU0vcWFmdUxUQ25TVEV2RnVMY1c3SUF5empY?=
 =?utf-8?B?c1dzWkJyN253T2Q1Sk42TmxmSkxQT3JDMS81aTRTTDNMTkE4N2pJQWk3ZHgv?=
 =?utf-8?B?YkRtdkQ2aTErcVdoR2NTWXJLeDFranFlMGlUbmdUTDdBQ3FQQUFBNmZWemN6?=
 =?utf-8?B?QWx2R05YWkc2RSt0TmlQN3NyYVR4MFBHeXNTREZjOGFLSHM2QStVZWZRQmVF?=
 =?utf-8?B?SHM1UUZWdjlyUDVLUkhzOGMzYmVMM1VaYmx3NjBKQUN1NGMxdzdCbzRGUDBh?=
 =?utf-8?B?a2R1c1p4YVl3OE9lOVhIajhjMXl4dUljUDQrWGhwK04reUJLNW1BVlFRekQy?=
 =?utf-8?B?NW14aUFtNE9TTEJqQXBIamU4TldJZTVleDlTRGdGMDNyUWZXa05vWXJRcW16?=
 =?utf-8?B?YnVHUVJaeFQxTFhBYmlPUm5Bb3pmMEZXZTh0WU05clRFaHhpRXcwcU5PTlJT?=
 =?utf-8?B?ZGE4dnIrVlZzdXpYZXQrYXdBWmV5Rms0WHFqZXpqOHB6eGo1VXZPa1VITzFw?=
 =?utf-8?B?ak9FSHRPRlc2ZW9HNDErT0dlTGZveUJuSnJGaU5nZDRIbGhHcWQ3SGF3cHRu?=
 =?utf-8?B?UFg1THFDZzFKVUlTREZJWTJUZjNNRFd3aFlnci9kUVZDZmNUTjFNOHMveE1z?=
 =?utf-8?B?bS9sQVI1WVJYNkg2dUh0bThwbEtHdWlYT25ZWmlPU0ppRVJnVWtTZGMyZ0Qw?=
 =?utf-8?B?bnF4ODVhUlUvdkpEMjlNaytDRHVPYjhXN2t0TjRQMzlFVXNoMkRDd3NvK1Rn?=
 =?utf-8?Q?7PLRnPRg2dHbTJwHMPB9pTw0kCT0idul?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WldtQkZVNlUxZnZMbzlJSi9DaE1FNGd6YXRWRWwxTXQ5VG9MQXNsb0hhY3dz?=
 =?utf-8?B?NDgrOEE2a2U4R0YzeGZzQXFCeE5UTkVhMG11Nk1MdzFyZkFlRDhYUDZGYzRl?=
 =?utf-8?B?Qy91WGUzeWdUakhuTWdTb3pwTmt5RHhQZHI0L2pNQjBIbWg1Tlh3dzlLSUtC?=
 =?utf-8?B?cE9MRGFTTlIxWGUyWEJ6OVF3NTFoZDE5TTlMQjZ6TVU2dHhXbDd3K3ZEMU05?=
 =?utf-8?B?Rm9PS2twWlZXSlpQNnJ6WjYzYjEvMzNHMDlDRDVpbC9LQWxNaWhQVXBsZUU4?=
 =?utf-8?B?ZGU1enVKSDBsM2svYTZ2akpDM2svamdrcjl6ak1yb0tZQVJtMnh5UkY1aFY1?=
 =?utf-8?B?bUQ4NTVXWnJrT3JrbDd0Y21Fb2x1ZnpsY2pWU1RKcHp3MkNwbzhZM3VQc0xu?=
 =?utf-8?B?dlgxS1lrM2RKeVRBTFMrZFI4dXpSdkIzMjIvK2doQ04yZWxNY1VJMXJNZkRZ?=
 =?utf-8?B?Z0R6ek83QkRiM3BlZkhlVEIxaThQd01LNnNSNlN2ZkVaTHNqVHFNNzlteU1v?=
 =?utf-8?B?c0s5KzhxYlg3MnEwOWhVT1lLMUlpbDZvRmVjWitNM1lFdkkrRmEvT29kaHFH?=
 =?utf-8?B?RTRJcmJsS1E0UFVmY3dHODZ2dDNnL2k0R0RkMFN0cWdvTWxFckZOaUZudmxp?=
 =?utf-8?B?M21OaHNsMm5Db0tWY3U3SDY1NWFMMWRMRmY2ZWNWclBLTWhlYkRLUlcxRVBO?=
 =?utf-8?B?cGc4SURsUTZzRlZPTUh5ZzVnQ2hsdjg2L0NGeklPS3BmNlBmYUNOOTJhQ1Br?=
 =?utf-8?B?U0NpaWtYTkFCWHFUdkJIWGhhMG1pYTl2TGozb3hvaFFFMFhxbmpLak5WSzYr?=
 =?utf-8?B?bHdtbk9LZFFmQ2JlTWZLS1Ruem1qNlBxeEFIdk5WZ3RYVFhpYmw1dXFDRlBy?=
 =?utf-8?B?MDBvUDdEVStkYWRvenVpM3FGcnNMVXF4U3hSVUphQ3A4VDJlMDJwWnlzcCtB?=
 =?utf-8?B?VjUyMEZhNFhkQVBpdkJVTEtQUGpaZkN5elEyWFBqYjB6akJac2ZGT3hrMVFR?=
 =?utf-8?B?N3AydE5weVlUWHRPT2gxcEMrcm9NcG1kWERjWGtJWTJzdHg4dzBQV0VKVjRv?=
 =?utf-8?B?SUhFVmdHcXdWelh0a2RPRUpLb1FCVEQ1UGtCakpiRWJ2dDc4SVl1S1J4Z21Z?=
 =?utf-8?B?T1pRTzFxUUdEWVpCamNWMzFhYnowWHpnMXhQZXpJMjJpQVBYS21DUm1VcHlt?=
 =?utf-8?B?cDhZUWN6YWltbUJwZ1ZMc2hFNnVEL1hVK20yZzB4Y0F6ZUpSeVM3c0s0LzFz?=
 =?utf-8?B?ZVp0U3UrUFYrVERBWTZCaUlVVXBuTG0vMzVTQ0xIT3p4VzZuN2MvdjVkcGto?=
 =?utf-8?B?aGdRZzFPRzNzOVlDbG5mTzJadmJiZWlXcW1QV0xKTmNiSVI0OWxsUXBXTzBt?=
 =?utf-8?B?eUJ6OEtFT3RVd3BDOGVOQWtLbzQ1ZktkTjQ2UExoL0c5OGhCNDdoV3ZDajdZ?=
 =?utf-8?B?MWRYQUxmb1hNZHNaQ2pWb1R3clVEL2oyUUFtak5iMFZKYjFZRjM0QS9mYXQy?=
 =?utf-8?B?MlJFcUpJMlNLeGF5eHlKVzdhN1E5SWhDdU10TXliN3JFdXJvc1FyYUtsZUh4?=
 =?utf-8?B?QVoyWlBQQUNEZjhOWkU2cTY2Y1lvNUJvRWRDTnZqaFFjMzJOZGY0R1lKcW8x?=
 =?utf-8?B?eGdxYnZHaHJxaEgxYmhBd0NYQXhkZ3ZkRllTZG1uN0xNcW5BcWpWRkthalhU?=
 =?utf-8?B?Z1hkaUZFRHJxbm9WVTAvaWF0YmhHWVdWaFJnVTJ5bFFwZ1RUUXJDSWM1a0VX?=
 =?utf-8?B?YUFJUFg0S0d0K2ZHK05XVnArdk1ycy9yZGtNS2VPaFVzMHZIeWxuWmxCSkRY?=
 =?utf-8?B?KzVuN3pkR1VZYlppYXhxb0w2Sm9EVXJPd2luZ1FPUnJidTJJMGhIUWNXeURM?=
 =?utf-8?Q?RmSFxyaP/WD42?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-5f51e.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: b44a0435-d4ba-418c-2569-08de5cbadd85
X-MS-Exchange-CrossTenant-AuthSource: SI2PR01MB4393.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 09:11:19.2332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR01MB5447

On 1/23/26 10:51 PM, Jason Gunthorpe wrote:
> On Fri, Jan 23, 2026 at 09:49:43AM +0800, Wei Wang wrote:
>> The enhanced ACS controls introduced by PCIe Gen 5 ensures better device
>> isolation. On devices that support the PCI_ACS_ECAP capability, the
>> controls are required to be enabled properly:
>> - ACS I/O Request Blocking needs to be enabled to avoid unintended
>>    upstream I/O requests.
>> - ACS DSP and USP Memory Target Access Control needs to be set with
>>    Request Redirect or Request Blocking to ensure the Downstream and
>>    and Upstream Port memory resource ranges are not accessed by upstream
>>    memory requests.
>> - ACS Unclaimed Request Redirect needs to be enabled to ensure accesses to
>>    areas that lies within a Switch's Upstream Port memory apertures but not
>>    within any Downstream Port memory apertures get redirected.
>>
>> To maintain compatibility with legacy devices that lack PCI_ACS_ECAP
>> support, pci_acs_enabled() skips checking for the capability and logs a
>> warning to indicate that isolation may be incomplete.
> 
> That's every existing system, please don't do that.
> 
> The issue with ECAP is the way PCI SIG re-defined what Linux has been
> doing forever as unsafe.

My viewpoint is that there are known bugs with the legacy ACS defined in 
PCIe Gen 4, and PCIe Gen 5 attempts to address them through new controls 
in the Enhanced Capability (ECAP). From the Linux perspective, we just 
need to adapt accordingly to ensure 'better' isolation.

That's why I was considering adding a warning log to inform users that 
these legacy bugs may still be present. In practice, these issues 
primarily affect virtual machine scenarios. The host kernel isn't 
impacted as the USP/DSP holes and MMIOs are marked as reserved regions, 
which are skipped during IOVA allocation.

The warning is intended to raise awareness for users, so they can make 
informed decisions about continuing with this setup.

> 
> Jason
> 
>>
>> Signed-off-by: Wei Wang <wei.w.wang@hotmail.com>
>> ---
>>   drivers/pci/pci.c | 67 +++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 67 insertions(+)
>>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index c4cf835ec8ba..ff974ced90aa 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -3527,6 +3527,56 @@ void pci_configure_ari(struct pci_dev *dev)
>>   	}
>>   }
>>   
>> +static bool pci_dev_has_memory_bars(struct pci_dev *pdev)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i <= PCI_ROM_RESOURCE; i++) {
>> +		if (pci_resource_flags(pdev, i) & IORESOURCE_MEM)
>> +			return true;
>> +	}
>> +
>> +	return false;
>> +}
>> +
>> +static bool pci_acs_ecap_enabled(struct pci_dev *pdev, u16 ctrl)
>> +{
>> +	struct pci_dev *usp_pdev = pci_upstream_bridge(pdev);
>> +	u16 mask = PCI_ACS_DMAC_RB | PCI_ACS_DMAC_RR;
>> +
>> +	/*
>> +	 * For ACS DSP/USP Memory Target Access Control, either Request
>> +	 * Redirect or Request Blocking must be enabled to enforce isolation.
>> +	 * According to PCIe spec 6.2, the DSP Memory Target Access is
>> +	 * applicable to both Root Ports and Switch Upstream Ports that have
>> +	 * applicable Memory BAR space to protect. So if the device does not
>> +	 * have a Memory BAR, it skips the check.
>> +	 */
> 
> This doesn't make sense, the special cases PCI sig clarified only have
> to do with switches that have MMIO on their USP/DSP and a case where
> the DSP aperture isn't covered by all the USPs.
> 

Do you have a link to the clarification from PCI sig?

In PCIe Spec 7.0, the ACS DSP Memory Target Access Control field is 
still explicitly required for Root Ports and Switch Downstream Ports 
when the ACS Enhanced Capability bit is set

For USP Memory Target Access Control, the spec does not list Root Ports 
as requiring this field.

> These tests shouldn't be done outside a usp/dsp context.

It might not be difficult to tweak the implementation for this (just 
skip Root Port in the check).
(Curious to read the clarification from PCI sig first)

> 
> You can look at what I drafted earlier here:
> 
> https://lore.kernel.org/all/0-v3-8827cc7fc4e0+23f-pcie_switch_groups_jgg@nvidia.com/

IIUC the implementation also applied the DSP Memory Target Access 
Control check to the Root Port?



Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazolkn19013081.outbound.protection.outlook.com [52.103.43.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180B131A545;
	Tue, 10 Feb 2026 15:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770736083; cv=fail; b=kOAEPVMOiMDkuVzDE5Nf5SUQ9nkXzplfbnZYYJ3sI9KTvryPBpgIf+a/1adNh+Rw0h0xPmnwGbDU4J9E+XttesttzNZY32hmZUg68DIPVEq8TwzmZZ1KKc9R2YOD4RA3JQOzr6RkeBlkOdXZME+/rTdlCie3uH7zTwYLGur97XQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770736083; c=relaxed/simple;
	bh=1i0RLpOUroOQ9Rh8ROAz4wRCZqoWg1z3F2NwTbRqX9U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pgFh95Eys+pyARnRkO6kuLEm2l43H1KrOGVmefMOH78RD+/b5668fIiCc5OdQP8hTSLHVX9AuREmkLQWtDUo35hkyyAQ3XuphbxJ7p9hzZr8edH1CR7cyW0okKGS10oPBDuYMXjF0LjSUor3G4kcv8w8sVHuaQhutCUZ381KB3U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=F4N2SjOu; arc=fail smtp.client-ip=52.103.43.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="F4N2SjOu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ABod6ssWqTMRT4dIsQnkDLyVnpDT001A5TfGvaOgWKZhGBF6RktO50nr2w6xj2vNtaeNOsIamf2Wp5LM5Vx5oxZnVFhgkMY9O53xgOP2oq2WLtslIG2+4zuMjdP0U5zlPYn//2wlcrGb/DK1U0PDrcadWYt75TXrKmWySAIztSGJ/dAr02lIw/Zmu/g1e/9N9VkjYrArVb/ycAfOOXkRL/p9mhZdhi8lz/DEcaFSig1EkhFdrYV7BCeFnZRx3jiJtWNJB0dIS5rpB2qUyMQGC5LuVWfwHcQpTkBour3Yh2BP6PjpX3KahPLVHu/iGnbHK6esUV/I4DgHCnsLdFQYgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a5lkXGcYQ23pV+9uTDaeeMIF9fC2kiv9bZg85NXuxjM=;
 b=HyGfKDxZh8oicSJVyBGKDegllsYqu4pIpmPOURu3b5GWgN7MbDR7A4orimkNJOokhaJxoP/i+DJh3fsFtSCpcAjRr6vXeBxEXp0Y7cFcWZP2Xs66NPuutuuFSNvb3bMOBbt4k5bWckFeGHR/g4FTFYDWDxDxbRY11YZS/z3iFrfruPZ/qRINxMaC0Qf0JKFRznSeQmvZdpegaSRhqk0XYPWhwif5uaPo7tbWI+kIBx5GznoIIT+hYO7VKKw+gh78SKxkoR8GJ3CAxEieJ2HJBqAiH/7ZjVXdUjn90e8WiZLdTDMajbVre56pd4qJkBq7LL+TMXcRTYEQZdmvhlPnbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a5lkXGcYQ23pV+9uTDaeeMIF9fC2kiv9bZg85NXuxjM=;
 b=F4N2SjOuU/vrS6RU7lhy7yrLDcwP/yZJfjdUOASCUg8Q3YlE7Pl1DzmrDg/MaT0KH9eoQLViNfokIH1BPLmvNOPtTY4HnDQ4I9qwKOfcpUVGpJvTKYlHmH1g8gsYS1gem0IYwNuD9JaToYp3x7XE4Ns1CJP7LOu7cSJ7fQ1VlbU5IjMXvalICqBb57aVKk0tWQQK5222PEytTNItFdwcG0ZpTQAikDP4EUpuYiK8eVsqwKi0sMrZKOehVb71jrIJ/N8aSmySWMLu03uniqMuskICPt+TbGLhnr+dB7iU2XecwPQlpKRnoXD/15q/9RX8vhhfJOYn9/8574MvNa+ZXg==
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7) by TYZPR01MB5756.apcprd01.prod.exchangelabs.com
 (2603:1096:405:27::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 15:07:58 +0000
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c]) by SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c%4]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 15:07:58 +0000
Message-ID:
 <SI2PR01MB4393C23645A7A3D0DFA04E4EDC62A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Date: Tue, 10 Feb 2026 23:06:53 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] PCI: Add the enhanced ACS controls check to
 pci_acs_flags_enabled()
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: bhelgaas@google.com, jgg@nvidia.com, akpm@linux-foundation.org,
 bp@alien8.de, rdunlap@infradead.org, alex@shazbot.org, kevin.tian@intel.com,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <SI2PR01MB43932C799AE9111C7D2C319FDC65A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <SI2PR01MB43931402377765D5DEA04ED3DC65A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <20260209165014.000070da@huawei.com>
Content-Language: en-US
From: Wei Wang <wei.w.wang@hotmail.com>
In-Reply-To: <20260209165014.000070da@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYWPR01CA0040.jpnprd01.prod.outlook.com
 (2603:1096:400:17f::9) To SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7)
X-Microsoft-Original-Message-ID:
 <d5b8fae2-2857-4d7e-a358-48247ea92f4c@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR01MB4393:EE_|TYZPR01MB5756:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f39395d-8bfd-43eb-a76e-08de68b62c90
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|51005399006|461199028|15080799012|19110799012|23021999003|41001999006|6090799003|8060799015|37102599003|40105399003|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YlRhTkNZSkNmTS9nbk9VL25kd0RidUt3bkE4S3h3RjBBRHF0L0h6WjhmalNC?=
 =?utf-8?B?eWRmbmEzdXlxNE95WExGc2dUMTloYW42WjZqZVU3WERIUmJOakRhbjY0VHBV?=
 =?utf-8?B?VTNHUHJ0ZkZmemRFb3d2YWNpK2l0WTJ3S0RXUCtoZ0c4d3RTYnhnbXNVd0xp?=
 =?utf-8?B?SzV4c05VWUNJUEs5enNWcU81L3VsTkZFY0dOOEswKzJ6d1V3N2NUREhPY2M1?=
 =?utf-8?B?eGg4b0wrM1pjQjQ2TldaUFVmbUgwV01xTjRPSTRDMWZndGhFZG9qS2tMb3Vy?=
 =?utf-8?B?QmQvRVRTRE5IR0xyT2dDdFhpZ2Q5aHBtaEUvQjBYSEd5aGdEc0pOZXNlYnN5?=
 =?utf-8?B?WkMxMzlEU2lCNVhSUGRrMkUvOG9tQmgraGdUL3Q5Vk5NanVFclR1Z3JpTkNj?=
 =?utf-8?B?R3BhQ2VXSGN0bmhWSHZRNkt1OHhOOFFBSlgzcVY4ZGY4eE1xNUZXR08xdXlB?=
 =?utf-8?B?clBzTTA5T2NCT3VLRkY1RUxwOERLWVpHL2g1aE84cVNzek12eVVBNGFBbFYy?=
 =?utf-8?B?L3gyay9WbGRXeTROeHRkQnVKZ3YwOGNITkNvT2ZSK3BON01ITWNQbzB1LzRP?=
 =?utf-8?B?MXczWlZkNmM1RkV5a3FxbmVmTFd5YkhwYmhWZlJkTjBVaGVEeEcyT3FnM0FO?=
 =?utf-8?B?cmJJeS94YUVHSGFIOHVYWmQzbTZrWUhIV29xZ3JnbmFhUWFBWGFNdEZKVWdW?=
 =?utf-8?B?d0ZnMGNmVXNoaUJMUmZCaW8zNWVtcFdMMDJNc25kcEJDdGdueG9XUkxJRVNL?=
 =?utf-8?B?eWJWeE9OUVBOdEU5NlNnbjVnMjRZeFNuWnArRFVITmNHRXhaM01rRkY2SGI5?=
 =?utf-8?B?d280MGN3cXJSUzVvSWNLbjdTNVNDWC81bzIrd2lrTHZDSmhDSW1PRGZSVkow?=
 =?utf-8?B?Y3hVSnAyYitEVlJvZkU4YWZKVkFkOEF6b2MwSU9oL1VEYk9zSDJPdFpEUDVu?=
 =?utf-8?B?YVo4cmpoeXhxZDRiWUVqdFBXYXVaR3FidTZLMWZjK2RsZGlMelVhZkxsRXJp?=
 =?utf-8?B?SThCNjRKenpFc0t6bzhNVnpxLzM0eGRWTEhQUEtOWjRtdVk0YUpYdW1sdFRr?=
 =?utf-8?B?ZXNEeWlqbUtqcEdoNU84Tnp0K0pqd0Z2aTA3RmxWMTJjekV3bjV5a1NQZVE5?=
 =?utf-8?B?b3NCa3h6N0FuZC9qajRheXcrWnFTbHF2ajNkeXpBZS9NYjFiVGlYODVOaXlS?=
 =?utf-8?B?UVorYkRMVkUyclQ4ZE9xU1hFakhlR0poSGViNVZmSjNkZHNUUVpYMmxKTHhu?=
 =?utf-8?B?SFdzMjl1c2ZrMlkxakNsSlNhYWk1djkvWThncHNEeURWa0pZSnFvbVg5aEpl?=
 =?utf-8?B?NFNZcjVmQzkydi9JL0M5ODhva2IvK3drRWF6dkJ1ODI0S29ZMksyWmxRUGZ1?=
 =?utf-8?B?cmhmTUpVWEExaHlMSklpbHBjYW5nbFhOR3JvVlhOSGV4R2ppS3VIUlQrUkVq?=
 =?utf-8?B?U2ZSRTRjckw2Y2F5ejJITmIyaFZPNGRvNTRTMmdUV2d5ZmNna3hDeDRrb2dZ?=
 =?utf-8?B?azJsUk1nSGNDaTloejJYb1E2VnN6b0ttTlA0amFXR1czSFBWdStzQm9hb3Rk?=
 =?utf-8?B?UGM3U0svTzFtczJZSGMwMXhYaGg5c2pCQnRSMytrK0htbjRvVDNWTFRxOWlV?=
 =?utf-8?B?RFIrS2lKZ3YvMngwRlNoSzNOQmsxUFBPNnlYUHErOHkxK01QeS9MaExyQ1Fv?=
 =?utf-8?B?VkNyT1hoQlZ3VEV6Wm9EMms3cUNhemc2QnNCOWpLWWVwdi96SGc0U1lRPT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cTNLRFpGQk5kaEMweDE5QlNZSFVQdjlyZGdrNnBxVnNjU29Bb0ZoS2xjU1I2?=
 =?utf-8?B?QVFtWWZVekxSVjNCSWx0Ymx6UlEvTG1MQTZaWVlmUTJDdENPZnBCRW5tclU0?=
 =?utf-8?B?YTN6MFhzUlo1NGJxb1hORmVVZ2RWeEpRYXlxTzF2c3Vpc2tVUUMxN0o4ajZv?=
 =?utf-8?B?aDUrMkd0c0NHckVxd3B1SWpUYmhRcVd6UzM5cmJQNVlwYy9zMDUrYUlQekl2?=
 =?utf-8?B?WjVWWjQ0NHU4bEhiWHJabVhNQ1Q0a3V5c2twbW1PYjJpTm16bnYyYksrNWxO?=
 =?utf-8?B?Um1PYmJQUlBPRFh4NzZjUjUyVkF3NDhPblV4czljei82ajRoaXhxb1pNZS80?=
 =?utf-8?B?aGpWc0sxVXlCUFdHQXN5RmdtZWlvOCtQNkFUdUpQdURsQkErZlRWUURPQUV6?=
 =?utf-8?B?UVdIWjZZZDV2N3J1Nml5UFpQVkFESFk2Q1hUbi9ra2o1bHozV3Rpdmo0bSto?=
 =?utf-8?B?Y3ZNYURZR2kvcG5iSmlzQ1d6NTRmKzBhYWFROGJFNVEvVEJ5ZDJmS0JEd1R4?=
 =?utf-8?B?N0N5b29VRlNPT3o5czNRclhWbjkySEpET1NZZDJvSFlJUnVlWW5IdG9xczgv?=
 =?utf-8?B?L01XRWhndktscmFETVZUcFVOSkJFUUkxNlFnRzE0c1FHNXZ6RnF2SURwc2dk?=
 =?utf-8?B?UDVaTnhDNXQ1M1RoSWI3TEtGNWM2Y0dWWEZRdFR4UDQrV2pzT1dZUVlOSmhH?=
 =?utf-8?B?NlVpc0FmNmlWUEJxQ3cwOG9Gek1lOUNNQzY5VnRyWEVDaThvOVZzb2ROUjA5?=
 =?utf-8?B?N0xKc3BjRTZxeFl2VlBDcGducnVaU1VjemtPZ21YYTVHV2tkOWNUZllWUGo0?=
 =?utf-8?B?VXQwalBPUkVmUU1xNEZzUFd5V25XTFl6RHNjaUc2aEZjeld1NkRuMG5rZHlC?=
 =?utf-8?B?aWtTb3QreGw4NkxXa1Z4ejA3amhLY3FNeGdiUy9sazk5NFVPVWhGUFFLVkUy?=
 =?utf-8?B?OUxMbWNFNjIwckFGdnZ5cEdTenZ0bmFDQkdoS1IwOGNhNTdIZ3lQSHZza2Nk?=
 =?utf-8?B?N2ZDQjZhMWRtWXdtK0NNMlJkTkhIcEx2T0lnZHJKNkZlQnQ5aEF6UzZQdk02?=
 =?utf-8?B?MlBDN0huYjJqNDhVK3V1dHBGc2VJNWVCQkc1eGxLeFhvbDQ5RzVwNWVYNEtu?=
 =?utf-8?B?WHVXL0czTnZsWnEyT2RmU1dNMk10UElDcXM0SkYvNG1RcGd5VkpOOWhKSFBk?=
 =?utf-8?B?ZkJqTW5yWStJaHBaTGU2MEpJd3RMOUxVSWdKL2FVMVVWNHd0eEVnanF1a0tv?=
 =?utf-8?B?dDBaUmhGY0tzZzNJcUpJQjJCRU1McU83TSt5SFFyV0JtVUlmSTA1L2l5c0xH?=
 =?utf-8?B?ZHp5TEhJbi9wbWFJM3dHdEFtWDI4QjZSdzBrY3FPenN1aFJwcWRrQkVzeFNZ?=
 =?utf-8?B?UE91V1NraDY2RG5EMEcvT05KbEpOMzR1b1RTVmVwdlpSMC9PTmlLdlRSRWFF?=
 =?utf-8?B?bjJJZHJMYjhkVEFCQkh3MzFTVzVYTER5ZGw3ajhIZXByN2p5VmJKUFA4RS9z?=
 =?utf-8?B?V09VT3RGajFGU05BYVo5NFpTeGQ3ZU9CK0YzL29NdVg3cHRydndEd1d4S3Jp?=
 =?utf-8?B?RWUyb0VpZkhSdnVORG40aENDVklzT0hNeVdqS2RsbSsrTGxCTVhFUjZxM28x?=
 =?utf-8?B?aEVuUjRrZnZuMjRoN25wVEpodjdLMURJVUwrajVQMURBMHFxVEpBNllObVJt?=
 =?utf-8?B?bnZ5MzcySHVZc1dlR2dMY1F6YU1QSmI4TVpmSVIxZkprZks4QXZDV1o5b1Fo?=
 =?utf-8?B?Q3F1QkRTVFNDSFZhWlZBellmTkhTWlBaWVBLdCtpQUhnaHFpT1J4bWMxMTVz?=
 =?utf-8?B?eHpoc2pWWVRhZk5lQTBCMDA5Q1oxTzYzVkJMaEFKcGVUcU9seTRkdTM0ZjZH?=
 =?utf-8?Q?2PnZMtyvZjRRv?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-5f51e.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f39395d-8bfd-43eb-a76e-08de68b62c90
X-MS-Exchange-CrossTenant-AuthSource: SI2PR01MB4393.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 15:07:57.8922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR01MB5756

On 2/10/26 12:50 AM, Jonathan Cameron wrote:
>> +	/*
>> +	 * The USP Memory Target Access is only applicable to downstream ports
>> +	 * that have applicable Memory BAR space in the Switch Upstream Port to
>> +	 * protect.
>> +	 */
>> +	if (is_dsp && pci_dev_has_memory_bars(usp_pdev) &&
>> +	    (ctrl & mask) != PCI_ACS_UMAC_RB &&
>> +	    (ctrl & mask) != PCI_ACS_UMAC_RR)
>> +		return false;
>> +
>> +	/* PCI_ACS_URRC is applicable to Downstream Ports only.  */
>> +	if (is_dsp && !(ctrl & PCI_ACS_URRC))
>> +		return false;
> 
> I'd be tempted to group the DSP specific handling and drop the local variable.
> 
> 	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_DOWNSTREAM) {
> 		if (pci_dev_has_memory_bars(usp_pdev) &&
> 		    (ctrl & mask) != PCI_ACS_UMAC_RB &&
> 		    (ctrl & mask) != PCI_ACS_UMAC_RR)
> // or use FIELD_GET() to get using the mask suggested in previous patch then
> // match what was in the filed here.

Sounds good, thanks.


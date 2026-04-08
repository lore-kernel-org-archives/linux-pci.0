Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011008.outbound.protection.outlook.com [40.93.194.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A442E37F75B
	for <linux-pci@vger.kernel.org>; Wed,  8 Apr 2026 22:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775686997; cv=fail; b=f/XaxXpfK7KewcFucFUr+bTWzlConlXzZnTzSRM8WErazfcB5owND2iKacU1iFJhWwXMrPm9QcdXGEEn/w1dhNkwtQJs41a1eq5OufHRamufsoEUxpIgt/TiG5aINy3kxi4QohTsBwijp+dPHruU0hPeI463kpS8T9zLedxXFOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775686997; c=relaxed/simple;
	bh=ZeYb+suF9GNheyi/lssy/AnHfcm9YgBYe775GInSSBU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DIMB9zJ1S2fGjDP3G9pDKbk8XxY5JmrTR6t65MOjBnEq5FoYBRwVtjDBG0SBr2xnfH0UOcvbNULuRGe3OnsatgsQZWAC8ewPmnlXgM5SkltpQLoHP92Y3VK4Hwuek3Z7bhlF2hYFSPn3VCUUsK+8Yld6K4HQ2rzGbQvzFxcsWJs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vXBMs3qg; arc=fail smtp.client-ip=40.93.194.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vXBMs3qg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I0TrbPo8WEG2mMCq9CS1SZIzZ/o/OlkZkFORjkkCakbDImYdOAt+u6yybBZNvLIoBUjSJz+yjtg/6l2lqzlQT+TOb1pu8wUsw7ES4ukESJtsuLWrgCvU/Mm1hXx4aPdRYjNuAZwwZCuyFyvY6jNDXVKwkc0CeCtEy7WsAGd2ryBhoYtXqd3FIk/oIkCDbVjHAvaTkWHGwAIJ2LOlEVwa4uo9KU50PXPEOQ/5WXOsO8viGt8lnmfz3GwtXRedbmI0TuX3u5XRkgbamh33fS5qQXuT/Dsvn0k994crkd3igtp3nxDcKAke9nCrkZNgOTH4iWEGDV2dvguNCG1RVSb+HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LUgk9XsHx8OENGpmXfNkn6Cb3ORTiA/EnqKkyWluSOk=;
 b=ioNpcsfL0/1UsmTUPndStylgGNppDQNnImIroKgsamHUACrDx5dgWN5Vu+9oJ9MIjlZXTn7VLKAVl52qnm6vjfQQY8clXZYf3C/ZYfhid+npFqZEPJTutwux1mC293UDTGwzsTNOtjzsfzCZaOv2xnkDLRz6iCTadreRpnjYi7JZ3+Xku3LAWyVw2U6nGtcPtGtlF4oecIFnlGQcUCTmU7JNvtgL/kj0WxMa+NqCZqbSlizW6UPOH49BMVps51gsZmZPCF58oDFYg2hgmgQZ9lI1xoBhDG28T6WvdzT86MiHq2CjlQXxkWF57lIY2pds5cAvJ1vph8oTg/f0Pi3K8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LUgk9XsHx8OENGpmXfNkn6Cb3ORTiA/EnqKkyWluSOk=;
 b=vXBMs3qgdDUwgYK7v53ckO7sDSWir5Kbuk49E35fNHTWz4yWxiDHp0JAm6q5iqOF0KKenBJ8VuNX7tTsT+x/56ujAvDblGJIOErj4U2CPqqaq2KUivkMbOCclEthnylHpk8k9dFRccvuwkBttBtw8s6oIx1mroQ6cGJ54UNVGC8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by PH8PR12MB7375.namprd12.prod.outlook.com (2603:10b6:510:215::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.19; Wed, 8 Apr
 2026 22:23:08 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::1e6b:ca8b:7715:6fee]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::1e6b:ca8b:7715:6fee%6]) with mapi id 15.20.9769.016; Wed, 8 Apr 2026
 22:23:08 +0000
Message-ID: <3685257e-9dbb-408a-81db-c32ed13cdf77@amd.com>
Date: Thu, 9 Apr 2026 08:22:57 +1000
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v2 09/19] PCI/TSM: Support creating encrypted MMIO
 descriptors via TDISP Report
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Xu Yilun <yilun.xu@linux.intel.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
 linux-pci@vger.kernel.org, gregkh@linuxfoundation.org, bhelgaas@google.com,
 alistair23@gmail.com, lukas@wunner.de, Arnd Bergmann <arnd@arndb.de>
References: <20260323182014.GR7340@nvidia.com>
 <fa1c6e1e-068c-46d7-a623-58c225bb03f4@amd.com>
 <20260327114921.GL67624@nvidia.com>
 <d5059386-1ed1-4110-8283-16e3a8407760@amd.com>
 <20260330114902.GA310919@nvidia.com>
 <46de1d41-a660-460c-a49f-ae2d2ad7afe1@amd.com>
 <20260403140858.GJ310919@nvidia.com>
 <70912675-0737-4ebf-8ba0-ab9a2e493bbe@amd.com>
 <20260406222109.GQ310919@nvidia.com>
 <7ac346d1-323a-4231-8a2c-bd287e627e1d@amd.com>
 <20260408165452.GF3357077@nvidia.com>
From: Alexey Kardashevskiy <aik@amd.com>
Content-Language: en-US
In-Reply-To: <20260408165452.GF3357077@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY5PR01CA0121.ausprd01.prod.outlook.com
 (2603:10c6:10:246::20) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|PH8PR12MB7375:EE_
X-MS-Office365-Filtering-Correlation-Id: baa27a56-c953-4d04-610a-08de95bd698d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ImGZXoIxTT1iQSbPVJkR6JfV2xgKFNbM4MCvm0oShlfwUVOVBdrARoYohPgkV6QwDF9knZ28Rz2nTXB9m2627SCAaRbHg1WCPSTl3svhHAFHWYQULyysutNBnC5KQG0Hb+A34W8PMh0vPhLo+ZR4HunWYOOstwqVOjY0qRrKM6HWNn+hto+1hd9SYUtn6zMTq9QSmVLkMCLyAs6tbsV/iupJDlowZNsrGfLIXxFKpSNcO9bWZVY834j6pJ0GNwMqDZqBvy5SVJbctUMrIw9GVtQvfRSpTYK6K54phbWFANFaKXrTjt2m7gbHCx7IUJKxG8uopWLVRo4uZrBX2SZNmdl6AsKbqn8w47GTQIxJBSYv51udaLwT+gtrmTwmGmdSPj0VH+omvPFwez4QlEjZ5zZZdZXosd7gGxeaDpA08cg0Ojd2p+/nEiNxvGbeQoAfC0bBBDqe2gGLVhgJcj7uzF5XvJxiUz5BD738sBjRi0QJ6VaVQlbaYl3uZjK6A4ah6x9jh9gO0AKDj4+5h1pW+PyIGW5vQtVFqEflchfPW3r24PeocoP94gexPo4Rl6to8iYEYEOBiBIUHBjutBN80XZt66qm3fW/LgLq3ZzpLou/D37J8MQZVe2GAJ1l4B8JDTgv9KllSbduYw3e8NvTmbv7eZT0T+NK/iYKEKe1DO/Q7uFOKAckLfwQK8c96kpEF+2Ac208QvlkACeI/0Ab7eTb4s6djWRFEsW+LUZd2Mw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MjIvVXZIdis3VU1iOHRpSEMxNDF0TFhkMG1ha0lPS2NYQnhhQTlkVlJpdFFm?=
 =?utf-8?B?RUhqbmRKYjd4TXFpM2lQYlhTMXZ3L0pvVVpzdURXRmdIZkxUeXFIYXJ5TW5z?=
 =?utf-8?B?emhCSHZubmlNYVFUNzZ6MlB3QWtiUUVmUG1rMlp0eEFWL3lOZDFrenZ5R2dp?=
 =?utf-8?B?NkhLK0cweXBDVGNtbm1uams0WlVycnRIY0MwRFp0SWFDSjRpV01xQS9WcTlO?=
 =?utf-8?B?djFyd3F4VFl3bWlFUjhBenRmcGY0emV2Ni92bnl2TjRaYWhLRDYyc3V3TVhj?=
 =?utf-8?B?ZWdsREo1Wms0aE9GTWE5R084bjdCQzRHSzJOdkxqWmJERU5Ma09HUzZILys1?=
 =?utf-8?B?Wm12OWJheDVzMUl4QytMWjNDTUVEZU1HVE1oWlMrd3owaksyN2Nmd05jcVBy?=
 =?utf-8?B?YlNVaXZrK2s0ZVRzSmVKRmw0bU9KblZxdUpOK3dub05aSUhEYlYyQVRGSytQ?=
 =?utf-8?B?bml5TVB5cFdKZ1lKYW5zTE5GTUt4Z1Q5VE10MFdqY1R3S0JLajFXSXJGdjJu?=
 =?utf-8?B?U3VNR24yckpLV0FJaVkrSy9QeWNFRy9oSTI3cGtUczFJYTBqcVVOejBvTjla?=
 =?utf-8?B?bWREQU0yZy9TQ200UWpDTUVVTU50TFJmcEFQdVNQRXErQXl6SFJzWmovYWhO?=
 =?utf-8?B?ZnNxM09iekRhcVFSU05OcTJIeXNhWHJUNjkxRk82dU5reUMrcWY2akVPOHpP?=
 =?utf-8?B?Qy9SaVQyK2d0UmN3RDN5dnNVQ1ZqeUxYUCtzaFZtVVpKNC9XQlNXbzZibWE1?=
 =?utf-8?B?VXVNM2p2aTVXR3ZONjlhU3pEN3NNMUdMS296ekk3L1NIcGtGYUpwYnhIZ1JR?=
 =?utf-8?B?RHBVY01URVRrbDNuUmhlRkRrYlZWc3Y1emYwNm94NVE2TENvbVM0MXI0Wll6?=
 =?utf-8?B?V0svWjBOSWk3dVhWaHM0Wk5qZXNpaXNvTFY1eXZxeXliT0YwSzAyNjFFamFR?=
 =?utf-8?B?Q3NnRlBDbU1LYm95WS9jNHh1ZWI4blQ2UEtaNEJMSzE0NldNRWtrZXNmVFpv?=
 =?utf-8?B?RENuMm1MeUd2RmVpaEpGdXRiSXI1NUUzcENtSStnV1FZakl2aXYxREU0MEtJ?=
 =?utf-8?B?Y3dOWG1TdFNsK0d2dkFRWEx6QlFHT1NYSlJDNXRwNWZQRyt0VWtEUisvcXp2?=
 =?utf-8?B?RzkrbXh2MTRBbXFES0FNczZqOEEzSDlNMkYxZ0x5RmZWSUNRbG1XcTNsMWdF?=
 =?utf-8?B?MldSMWZubFowLzI3Y2VZdTY0aWhwM280K1hreWVCdFVjMXBUR3ByakpJL2Ex?=
 =?utf-8?B?MmpvVGVDL0lZUmVpNmdGaTE1MTNzR1ovTm5HVkNIKzBUcTV4SjF5d2I3QjFY?=
 =?utf-8?B?NW9hQkpETm5JOTIvQUxReVJDTnpjcTlId2xXcHhtbEdFOENxVUkrMk5lTWNW?=
 =?utf-8?B?Mm9TdnN6UVI5aHd6d2d6cC9oS21RY01XWXVyS2w0MXk3RzFCbHMxSDNUZnNa?=
 =?utf-8?B?LzkvelVFT2lsNTMyYU9YYU5tRHJuWlpLTTEzNG5Uek1jVmkycTl2Wmx5Q3lu?=
 =?utf-8?B?RHZqcVplY3FWVU16WDQyK3dBUWZ5QkJxYjVaWWZKMHBHS290clIrZTdjcnRQ?=
 =?utf-8?B?NDd2dXE1dkhhRzFWNTBWZE9nWDBhVVU1U3NZa3drRGVrVUcwUTBTcFJQRmU1?=
 =?utf-8?B?Nk1ESGRJOC8zMVVzUGk1L2lVLy95ZjJCNGdVS1dKd1FzN2tEQ0xmRW5sditZ?=
 =?utf-8?B?SVBIYWpFVnlqU3BFMEh4MzRmRWdsZnRoK3VVOVVRNFFGNXNqWGFCTUxURGVo?=
 =?utf-8?B?d3dJdUl0M3hVYmlrdzB0S2U0QlFjcUxPRTREZE5FNWhiUVpjRG9pVTBHSnRk?=
 =?utf-8?B?L3NqemRvU3dnSXlWQ096K2FHczJ4TVgvTTVVQ2I2YUdUT3o5djBvQitrNHZ4?=
 =?utf-8?B?OHdoWW1kb2lHN0FwdnJGanQweGJmMmNJV21Pa1h6S2wvS2FrblpYaE5MSzZi?=
 =?utf-8?B?SGNTUG00dWZKbGdQeG9EOUZYMzZUV3VKSktTQTE1cTJMLzBraWxWOXlMUFdX?=
 =?utf-8?B?dkN1cnRDMkM0Y0hOUUtsRzZQWjQ5MXllUk5FNG12cVlXNjY1TUpudHpCM1ph?=
 =?utf-8?B?V1puTEIxV0I3dkFOaEN4TDB1czdRWEZyQm00SFhLVUYyWFg0djlDbzZMOU1Z?=
 =?utf-8?B?d0NTV2kvTzNkSmNVOGJmV3lJZjhZV1c5dnEvNFpMMGRkQ1llRG45VzlzaXNN?=
 =?utf-8?B?dnQ2Z3pWcjhMTi92Z3hMRE1Rcll0SUFNV3U2bVpDY2lmaTJMeGRqNlFGcmNj?=
 =?utf-8?B?bXBiYytlMHQvZjlMcEQ3bjlndlNpMlBxWDZpbkZxTzdNRS9tNi83cm0wYzlP?=
 =?utf-8?B?dE1wcFo0dzdrK1VXc280L0lpNmVRd09vU3FmTU00NHJOdUM4a0Z2dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: baa27a56-c953-4d04-610a-08de95bd698d
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 22:23:08.7143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mf2Vu4XsvPs9LCasar8pGs6LIzhrNa+1zHmnLa+3R65JAoD8pm6WMeAXweRtmfXZKar8d3N1skgqrdKlKZD7sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7375



On 9/4/26 02:54, Jason Gunthorpe wrote:
> On Wed, Apr 08, 2026 at 05:03:16PM +1000, Alexey Kardashevskiy wrote:
>>>> This is what I am trying to clarify - if all ranges muI thinkst be reported
>>>> (as some think this is what the PCIe spec says), then no, not
>>>> anywhere.
>>>>
>>>> pcie r7, Table 11-16 TDI Report Structure, MMIO_RANGE:
>>>>
>>>> "Each MMIO Range of the TDI is reported with the MMIO reporting offset added."
>>>
>>> I think the argument was something like it didn't have to report
>>> non-secure ranges? But I don't know, it was hashed out in some thread
>>> for ARM and then I know our folks looked at it and nobody pushed back
>>> to insist that every single byte of the BAR had to be covered by a
>>> reported range.
>>
>> That's (my ignorant guess) because of the ARM FW TSM guy which sees the BARs and can easily make sure that MMIO_OFFSET is such that BAR alignment is preserved (and there is a clause in PCIe about how such offset is "permitted" to be calculated) => does not make much difference on ARM but it does in my case :-/
>>> I wouldn't take the sentance you quoted as confirmation, you need a
>>> sentance that says every single byte of the BAR is covered by a single
>>> reported range.
>>
>> Why "by a single range"? Every byte of a BAR needs to be covered
>> (which is what my quote suggests)
> 
> No, your quote doesn't suggest that at all, it just says if a range is
> present it has to be offset.

At all? My hw architect says it does.

PCIe says "Each MMIO Range of the TDI is reported with the MMIO reporting offset added."
Not "Each reported MMIO Range of the TDI is reported with the MMIO reporting offset added."


> In fact the spec specifically says not to report ranges sometimes:
> 
>   Bit 0 -  MSI-X Table - if the range maps MSI-X table. This
>   must be reported **only if locked** by the
>   LOCK_INTERFACE_REQUEST.
> 
> So if the MSI-X table is not locked then what is reported? Seems not
> covered by a range at all is the consensus answer.
> 
> Thus you get this case where the non-reported MSI-X table could be at
> byte 0, not get a range and then there is no range covering byte 0 of
> the bar at all.

This is the only case when dropping a range in the report is allowed and even required. When this happens, the OS knows MSIX is not locked (part of the FW ABI) and the OS knows where MSIX BAR is and can easily amend the report.


>> and the spec allows multiple ranges but also requires strict
>> ascending order of the ranges, 3 paragraphs of text about
>> it. Thanks,
> 
> single range per byte means there are not overlapping ranges.

ah, misread, sorry.

> This was the old thread with my suggestion.
> 
> https://lore.kernel.org/all/20250911134107.GG882933@ziepe.ca/
> 
> If this is important to AMD they need to get an ECN with PCI-SIG to
> clarify. I think as of right now Linux can't assume the ranges start
> at bar physical offset 0.

uff may be...

> 
> Jason

-- 
Alexey


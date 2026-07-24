Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010050.outbound.protection.outlook.com [52.101.56.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D43427FAF
	for <linux-pci@vger.kernel.org>; Fri, 24 Jul 2026 10:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784890471; cv=fail; b=u43XkcLUXAkGlqng0vSM7pGIWqwruqtCh54DMOCia6X7eST7Gi5OH2wa8DWyr3mpJMFS7Y1Cvj3eIyGR6XSTiC+h8coSQeZklJZgreeQocqQ2upB+8At+inlBg2qGyVVmZ7s77fy/1xCAqmjRllZQ324bXFnhYEbdY+3DSt83Hg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784890471; c=relaxed/simple;
	bh=Y1/1FhVpTQP+xpBrMs3Glv0B5ySF8XB8ByKEBFcAEjQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lTSNeeuQxpZN3zdadREPJvbyYTkVIK6m2DkhQmfRtaZew6/x9/rlV3meX3scRbL3ywWJbtHXD0ZjjqVUXX5968twV4obgNG9BawFn5LugPlEKAGstelrwH3Z+b2HU2YiKXAttUbV0L2yrhEtVegXlAntjaEREYDSYffHSL50BGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tefZRjDD; arc=fail smtp.client-ip=52.101.56.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tefZRjDD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YEyM2bXArKWpyO+quhcA5WeKTJstk7F6bwTzct01z0K1q9IPE2/tN/PJStHEEraqw4TnN28FHpo3mmu/9mTh8xlP7j74Ou9sQsS1L5n2EcZ8azJnfycp/eilN5aVThg4Ane4C8xArKwmDVMcmFLjiTnQ1+EHdhkpngXt2zH0XiJzoo6tYkkjIJSMO2yxK6j1IpW/3NUvO3xV6NkSeiTg2x7QvYxe6i0UF+gH+iQA7gnQREuBjTumR/j7KUkE4vj4a1wkrgOXrepVCzhbaZykGuvHkRb52xX54ESvsq5PdE+/nysx/ritwVE/YbSRcv8I/I7tnl73PwF8lFpjN+e0AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EuQnASDcq/B0Zt/b5V29avyPtS0cTevMSZs/Mk1+neg=;
 b=J8v3pWW481pWoW2YTuU/UQkd/65EcF/wWniCSV0eCiGGWLPsyQdHbHNXEI2whqV6xXlU2V1DM3w+RcBmV9Ol6mi+00JUeTtgKQw5ynfrvMGaNP6zDwXMaBJ+XTu0GE0i8uZbqOB0fKneEAA5NFHcUSWzGn+pkqrw11kxYwN0/A+LYLUsR9xJ2umxPBewUWFwGkM2iMqn/wJG9Ivtczv+98FaAfAdsEh/zHXurSVDGhakE5sZP71V7VhjbtS/V8/qJgRFjAF2hi4eftsu3GZTYbqx2A5Q4B7VAEWIwFrQ5zuION1vfrzgyHNaxOSygaTYEBtM7ZTjd5TDHDzND/28jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EuQnASDcq/B0Zt/b5V29avyPtS0cTevMSZs/Mk1+neg=;
 b=tefZRjDD3pw/5gnon4N6qLg68/gwpLk17emrZHRvQUO7Hm/camgIa3kzNf3aF7pYdcYC9D2RuwBiWa0hoUasnN0KQiXw+w1hT/aCbfzOOZGumadBIwnlqqydSNfe61J5GCxmbXKK0Qc0lVvFJGIZ7hqKKHNq2tcvjmQhcFwUXnk98na19x8LBbpJ6lnLwHtrKvOXHsgNpWJckiJ2/uX/g2AWXJhhF2UWZF3bDlNn703M3yLmhWhMoAQhjn83MVWquHbqhrNRMncVs0PtJrPMK8+7lsdN2Sq6BMOiOzaQ7QL3LVWamwmhZ43+FpbTHEaT/dbUeY0Be4ifObiQQVSTFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB8245.namprd12.prod.outlook.com (2603:10b6:8:f2::16) by
 DS3PR12MB999216.namprd12.prod.outlook.com (2603:10b6:8:38d::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.10; Fri, 24 Jul 2026 10:54:23 +0000
Received: from DS0PR12MB8245.namprd12.prod.outlook.com
 ([fe80::e7c5:cfca:a597:7fa4]) by DS0PR12MB8245.namprd12.prod.outlook.com
 ([fe80::e7c5:cfca:a597:7fa4%4]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 10:54:23 +0000
Message-ID: <61780da8-9590-4278-9794-0836eb39cf84@nvidia.com>
Date: Fri, 24 Jul 2026 16:24:15 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: Disable NoSnoop and Relaxed ordering for Intel
 wireless BE200
To: "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>,
 "lukas@wunner.de" <lukas@wunner.de>,
 "thierry.reding@kernel.org" <thierry.reding@kernel.org>,
 "helgaas@kernel.org" <helgaas@kernel.org>,
 "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>,
 "treding@nvidia.com" <treding@nvidia.com>
Cc: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <20260722170438.GA735886@bhelgaas>
 <204d9dab-96de-45fb-867d-20defc0b79e6@nvidia.com>
 <534363f87b37ba6f1449d0524400bcfd7fdf5b3e.camel@intel.com>
Content-Language: en-US
X-Nvconfidentiality: public
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
In-Reply-To: <534363f87b37ba6f1449d0524400bcfd7fdf5b3e.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0043.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::19) To DS0PR12MB8245.namprd12.prod.outlook.com
 (2603:10b6:8:f2::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB8245:EE_|DS3PR12MB999216:EE_
X-MS-Office365-Filtering-Correlation-Id: f17c59c5-0061-45f0-f722-08dee971eb8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|4143699003|10067099003|11063799006|6133799003|56012099006|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	CzfaFZnXipbxgTgKmKF0deayIHZXzc2fSFadRZS6VxPrpaJNhPvaMR0JeFnQfeK1XFZXE1m4lEd+kebfIkcOu8oGgTf7mVWpIbUNVr47r4V4OQTPwCvIfTPVzoasHnourVk5rHiXpjdRe5Vt8UnZS+1F1E42/P4F80tBsdaD8h1wKAhUPws8UCb5oBQcXIgW3EAOOrsUynMJ0qVkp9pW7VSe05mUJrrMmGTXgb5kfVfMxlBqukH0ohdLmPjQDMlYqnC/Zqdt/RO6zKBAwYw7HGrpibiZgbYZsP29zXKhOX6RhWXITd0vXoW0tKxAWe+GOI2tZ2gdWTIwdTDRdD5Uoeq8LOhQX5mOu5bpwme2mLniC0VJpQq35aM3doWjKKm8H9ONlyaZ+qeg+mxDsPW/WFXOmXL7bkIVgrX+rinulnLkJ5ZDG0mAAxnRJrgqnLdFxLl5KVOa7EQx09OzDd4v4zERj4ylgaEMkQ4ghLWf6UZXDSWrILp0fE+ELkF7WkeIb70zWiUII0EtDyGvFpwFXPSMsSbbX7BnWyknWABMJ3PyRJyHRs784yw2iYaHtdxCBu6oqzVQl+uCmOa9AhbYIUftaVO3FCe1/rN51a9KYQ1GRElvkTZGrsMOAa87d+HyrM1+jr1+dBok4rAI1Baj/cp6tbXs6zUWxo2n4bvwicM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB8245.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(4143699003)(10067099003)(11063799006)(6133799003)(56012099006)(3023799007)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MDZFYnF4alExWFUxQ0pwOUJsdEdLTGVRNmNjb0liRFBpeGxHQ2J2T2VWMnlz?=
 =?utf-8?B?OE9sMlJaTmdLSWIvRERBS1RKMFdSM1pVTEhQL2szRkhqQVJSbHR2N2xyS2dJ?=
 =?utf-8?B?OGlJcGcrTUROQnlYaks1UldVYTgxME1IR0Q3YXZTeEY4Q0xIUGVvVWtDRndr?=
 =?utf-8?B?TnpraC9keFI5d1lnWWgrMDBFbkZ2WmxnTHdzSlIvVWVJNW1weUhiOU01L0NU?=
 =?utf-8?B?dXJVZy95NEgxVi9yemtJSlZWdVNkRHN4b2k2SjkzaG4ybmI3cXpUTEU3SFVB?=
 =?utf-8?B?cWVycFhkd21QRTFxMFJocHVTZTJPNW8yVzVTTmlxNkcrZlhVTnRTZEFUZWF6?=
 =?utf-8?B?ajR2ZUExdXdBKzIwNHJFZVNadUZjVDRUSkpGejBNalkrZEFVa0VEQnFYNk8z?=
 =?utf-8?B?K1pjMjJSczEwdzZTT25UaTYyWUx5SWpSbzlSck8vZU5wZndPRlVFd1B4RE5P?=
 =?utf-8?B?eS9DODVPQys2ZlVPdGtQaGdWT1hudm5YSjRZTW5nUWRuSUM3WkZyVm9DdU5J?=
 =?utf-8?B?Y3VKN2NpcmpQQ1lxN2dyd0syd2xLU0hXTExKQm1jNkE3WHB0dVpiMmpSeHV6?=
 =?utf-8?B?N2hueUwvWnlWd0hzcWFMZFRMWVEwNHFEandIV21SOHIwWG1xR0lscTVGYVpZ?=
 =?utf-8?B?b3RoVGJoVU5kN3RrOThkVkdwdnYzQXdSejl5bW1acGl0NnJRa1lINWI2S0do?=
 =?utf-8?B?ajVCOE9ObGNZaUltK1RiUUJoUnZqUytEb2NxV3dYRG80VWk5cE5pL3R6amE5?=
 =?utf-8?B?eVdjS05xcC9acURRVm13SXhZaVA5RzI4bU5kTWRxQjZCczRTVDRySFo1K29k?=
 =?utf-8?B?czh0dGxlTVV3U3gyeXVMckNISW5NczFKbzJBaUx3bXByWnpIN2xEbU1VWEoz?=
 =?utf-8?B?ZkYxc1FtTUY2Z2VOU1pnMzA1R3VHa3FhUlRpQTFkeXJlUThPNlZ0MFhIMW5K?=
 =?utf-8?B?ZkJ3RzhQVW9ITUlHVlUvMGI0VnJBdWNjK0I0eEIxUDdNb3JhbGpWK1MrUDF5?=
 =?utf-8?B?dzRMejQrY3dxenY3R0dtUzFTS3NOYk5oc2ZFdFdlOVQyaEh1VE1XVUJWMFBp?=
 =?utf-8?B?ZFIxeFFUcWVIanZaQnAyeU5aUkFvUFNONU9YRjlNK0V2dVpkeWxIRmZqcS9X?=
 =?utf-8?B?SGoyL0p3dGpHN2l1THhPN1lvMmJ5SDNkeEJteHA5V3A0Ulh1aUNFd3FZQlg0?=
 =?utf-8?B?WUl5aksxNzhPSmg3Qm54N3A5dUk4WnFSWDBQdkMxZzhhWnlQTzM4aEllV0RM?=
 =?utf-8?B?a1FnTERXbnVWNll6L0ZCdVZiV290R3hPYk1Nd1dDYk4xQUxZaGs4STR2bWhR?=
 =?utf-8?B?bXpsOHU3NG81ZFlIaVVxK1lpNDhDWWR0MWFjZDcxbytRRGNaWk43UitrVlAv?=
 =?utf-8?B?N3cwaC96RXhMYThLcUtEbTk1Mzk5WWd0STFzSWhBaDUxcXhTRFFxVmxGOWVh?=
 =?utf-8?B?aXJYenJyWHI1Y2JLazR2T3ZWa1ZjZngxZDREVDRGcHhDVEhMS2VSbGswZTFX?=
 =?utf-8?B?bFdwN2hQUFBqTEJTcmpRSmFkbGl3Nkp3aXZIUWZ1bDBZQzgyZTNYa2hQdW5J?=
 =?utf-8?B?ZFBLNGNvZlJOTTl1S3hQUG40YUh3dGRPWXhkNEY1eGtMNDNYYjhrdGpPeTVr?=
 =?utf-8?B?a21hMVFTaHk1S2ovS2F5R0JMaDlSVFdZaXB3Z095NWJ5bHFPakEzdUo5bjAx?=
 =?utf-8?B?YUtmQkR1Y3IyMlJrV2poTGh6dFIyQU96Q09IZEZLWi9QNXBzZFhYZ0Y3TXNF?=
 =?utf-8?B?K1Nyc1poejlsTEZqcUJHaSswd3Q3MzV6Y054S0hyRk5KdFlGRGljTWZIZXVM?=
 =?utf-8?B?WmlPR3cxdG5VcW8wTWZvUDF2blplaHdqNHczUUZXOXR1ZThVSEFlUnFrQm9a?=
 =?utf-8?B?eGhrRktlS296MGZqbGEyejcvTnk4RGZ0VERLRkltdVRNckJvM0tDaEdRelU5?=
 =?utf-8?B?emt3cmNPZG9mOEVFenRsclZJU2h2VjJGdWZxOFdhaVNMekNqVjJNRFdmbHhH?=
 =?utf-8?B?S1RVMDJiT1dmMEF2L2NSbFhwVjZWQzJsOEZvMG1zM1ZzL3hDaVd1Qlo4amdR?=
 =?utf-8?B?MjNRd2RoM3RuRWVTaHA3Y25XMDAwK3lnZXp6YnJlSDluK05wNnZlaHVSRUxP?=
 =?utf-8?B?UC9zRjY4bTNkWXd5aWFJdXF6L3JaWXU3dGF6VzYzWnd2dWh4Z3ZRZWx0ekI3?=
 =?utf-8?B?Q3NBRmZXbmVHUmJuV3EwdzhIWlcxd2poTTRJVEVkYTZnRXZkV3RNYVFKaC9Q?=
 =?utf-8?B?S05oN2ZFdnB4VHYySkN1bFBkcXhuL25qTnZpbFpOamhXT3Bxb1FSb2JERGZo?=
 =?utf-8?B?V0Y1YlJSZ2Zabk8yaVVxT1pBcFJZVTFvYlcwR3hHZTNoTU52aEV1YnMvLys3?=
 =?utf-8?Q?RqfBcQGlUasW6T2c=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f17c59c5-0061-45f0-f722-08dee971eb8f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8245.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 10:54:22.9530
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /udSXeouu/eEuqGF0xSw8aWQl4dmVv3PIu7ES9gV9toS2UBsBf/xlS6kSUb1baNtLIBKiI9D/r4OYXiENbEX6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR12MB999216



On 23/07/26 5:05 pm, Grumbach, Emmanuel wrote:
> On Thu, 2026-07-23 at 15:19 +0530, Manikanta Maddireddy wrote:
>>
>>
>> On 22/07/26 10:34 pm, Bjorn Helgaas wrote:
>>>> The problem was that we didn't show up at all in the enumeration.
>>>> We
>>>> send a malformed TLP. I'm not quite an expert at this, but our
>>>> PCIe
>>>> experts run a PCI analyzer on the enumeration on that specific
>>>> platform and they saw that platform's PCI controller sets the
>>>> NoSnoop and Relaxed ordering bit in the TLP. According to the
>>>> spec
>>>> (which I ignore), the BE200 is supposed to return the TLP as
>>>> received, but we reply with 0 Attributes and the enumeration
>>>> doesn't
>>>> complete successfully.
>>> I'm curious about the details of this enumeration failure.  Do you
>>> know which TLPs had No Snoop and Relaxed Ordering set?  Per the
>>> PCIe
>>> spec, they shouldn't be set for the config requests used for PCI
>>> core
>>> enumeration.
>>>
>>> At least*some* config reads to the BE200 must work; otherwise, we
>>> wouldn't know the Vendor or Device ID, which we need to apply the
>>> quirk.  So I think you should see something like this in dmesg, and
>>> BE200 would probably appear in lspci output:
>>>
>>>     pci 0000:04:00.0: [8086:272b] type 00 class ...
>>>
>>> Is the failure that iwl_pci_probe() itself fails somehow?
>>>
>>> You mentioned that this happens on Jetson Thor, but I'm not sure
>>> what
>>> PCIe controller that is.  My guess is it might be Tegra264 [1],
>>> which
>>> doesn't look like it's merged yet.
>>>
>>> Thierry, Manikanta, do you have any insight into this?  Does this
>>> PCIe
>>> controller set No Snoop and Relaxed Ordering for some reason?  I
>>> don't
>>> think endpoint drivers are expecting that.
>>>
>>> [1]https://lore.kernel.org/linux-pci/20260716-tegra264-pcie-
>>> v8-0-23e51589229b@nvidia.com/
>>
>> Hi,
>>
>> Jetson Thor(Tegra264) is not setting NoSnoop and RlxdOrd bits in
>> config
>> read TLP.
>>
>> I made sure that both these bits are set in RP's DevCtl
>>
>>                   DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
>>                           RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
>>
>> and dumped TLP header for a config read towards BDF 0x100 with offset
>> 0x24.
>>      0x04000001      0x0000000f      0x01000024      0x00000000
>>
>> I think dmesg and AER log with header information might help with
>> this
>> particular issue.
> 
> Ok, so I checked again the logs and I was wrong.
> We do see the device in the enumeration, it does show up in lspci.
> Problems start when we want to access our registers.
> I attached the full dmesg output. In that log we try to load iwlwifi
> twice.
> 
> I'm adding here the snippet of the first load:
> 
> [   15.275887] iwlwifi 0001:01:00.0: Adding to iommu group 53
> [   15.279737] iwlwifi 0001:01:00.0: enabling device (0100 -> 0102)
> [   15.280047] iwlwifi 0001:01:00.0: HW_REV=0xFFFFFFFF, PCI issues?  \\ **
> [   15.280070] iwlwifi: probe of 0001:01:00.0 failed with error -5  \\ **
> [   15.280087] pcieport 0001:00:00.0: AER: Correctable error message received from 0001:00:00.0
> [   15.280104] pcieport 0001:00:00.0: DPC: containment event, status:0x3f01 source:0x0000
> [   15.280110] pcieport 0001:00:00.0: DPC: unmasked uncorrectable error detected
> [   15.280127] pcieport 0001:00:00.0: AER: found no error details for 0001:00:00.0
> [   15.280154] pcieport 0001:00:00.0: PCIe Bus Error: severity=Uncorrectable (Fatal), type=Transaction Layer, (Receiver ID)
> [   15.280157] pcieport 0001:00:00.0:   device [10de:22d8] error status/mask=00040000/04400000
> [   15.280160] pcieport 0001:00:00.0:    [18] MalfTLP                (First)
> [   15.280163] pcieport 0001:00:00.0: AER:   TLP Header: 4a008001 01000004 00000028 72040000
> [   15.280274] pci 0001:01:00.0: AER: can't recover (no error_detected callback)
> 
> Does that help?
> 

Yes, this is completion with data TLP. It matches with the 
quirk_disable_root_port_attributes().
>>
>> Thanks,
>> Manikanta

-- 
nvpublic


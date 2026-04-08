Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010037.outbound.protection.outlook.com [52.101.61.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31314364E88
	for <linux-pci@vger.kernel.org>; Wed,  8 Apr 2026 07:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775631808; cv=fail; b=uP1bYYk+x+/zbhe/jC/lEbPS8cq9bMhSG/0NW4JR2xWJzlJJm/4zJ3DqzCrygMZOCb0RuILK+bT4qRKZiH380l2us9E835qytytSL3hHRTjZU53EBwbiFMDJyIopDsGjT4bnVTrRXLBA0uA8afZw1mtjf+zeaQ0MWH7Qdq2O3wg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775631808; c=relaxed/simple;
	bh=EljPk9iaH4uZfBlM5Ho4yCFXp142BGBnGSHEw76yvas=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YKLxMZIZq9gb49AFIDlV71bAI2ltfQEQr7cB/V6v/+Hy0TLIGq92agqmu8u+BE7Oz75sPUVZshmOAR7ucpSYHuFIwS676WHn8EcL72ieealu+fUxv2tFyvMgejopLwybhyFvNcD8cgIMYAGYcXvq5ZWp3wXIaBWcFj47CUP7bMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uvhmic33; arc=fail smtp.client-ip=52.101.61.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uvhmic33"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S4npk/pnZEmu5rwHbHh0+AGbRpdZqBymitgg1YNtKqor6GHn2WwMw8ouXEpD3iWukJchqLiTyJ4E7uEM3xf3TO0+MCpzm09GO+Evma9IXP0nZWWDgXqYdnIGGlaCL+a+fb4PP9Y3/NzVXMTDNCU4hsdCoMV1p61kzLFwiv7FD66rZ4pz54ElYSyTUiDZZNxSDjrTSAOFsYKoocdPPUBB7V1RI47FYZ+9ZlZ3G5+anaM9WsoWw/bujRnaRw5mHm9PzAQoCQwfsj+k8Pd1vTre5FasOLBFRn7WwwlhmX4O1y/aPYUkKOdOfDTGgau0ih+OrKZhhoUXoxb/uiSR/4GTiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eHXWBzMCKKG6dyTsHrozKsTvU7IkDcVzjhH05N7Pvo0=;
 b=AhV7Qzcz5i70xarzB1ZjLE00Pk67S3fmaFVOhPjB/eixP/W4SHjN4rxRBCz1Nv3Qdvc8Oxf/cTAMCvte31OISGIbj17Z5lmYBtIYhfE7f66zLB9jWSoCoOVorGZw9UTejJjlR3tm+zYeGLJmyNLArFWK6o7I5fJZ/e02N7dkIlM5Ve18pHIR1tzJ4ACDIwUJRtb5Ya5B4yMIfwyS3Wtwa7NVpdQvX8lGZTuViXiAdKPRFkF6EewOzCPPeMyadOdwkhzNXVfDiuwNmHIZ/QFvhY3Qs5vEHfQjbhkaGFfRE+5pEUQC2ubnI0hEFkWdqiqCROd/5qAn/C8BPWl5I94PVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eHXWBzMCKKG6dyTsHrozKsTvU7IkDcVzjhH05N7Pvo0=;
 b=uvhmic338HVdjZ0lo1tGjsx9IimuAqgdl46D8H+m9GZqHdiCz19+RINm+o/siKYvSwPlKbis2GYgrsWH6DLm/e4zuFTm86iZ34Y0YELT0FOgR81N5E4gOi6JiOfByR96OyV/j96CV4FxNgaYubeT80HqcszJaXv2oup/ktKfDzo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by DM4PR12MB5915.namprd12.prod.outlook.com (2603:10b6:8:68::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Wed, 8 Apr
 2026 07:03:23 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::1e6b:ca8b:7715:6fee]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::1e6b:ca8b:7715:6fee%6]) with mapi id 15.20.9769.016; Wed, 8 Apr 2026
 07:03:23 +0000
Message-ID: <7ac346d1-323a-4231-8a2c-bd287e627e1d@amd.com>
Date: Wed, 8 Apr 2026 17:03:16 +1000
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v2 09/19] PCI/TSM: Support creating encrypted MMIO
 descriptors via TDISP Report
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Xu Yilun <yilun.xu@linux.intel.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
 linux-pci@vger.kernel.org, gregkh@linuxfoundation.org, bhelgaas@google.com,
 alistair23@gmail.com, lukas@wunner.de, Arnd Bergmann <arnd@arndb.de>
References: <abPlt8oNUOqGvbA3@yilunxu-OptiPlex-7050>
 <228298b7-76bc-4ffb-bec0-0c35fd487c4c@amd.com>
 <20260323182014.GR7340@nvidia.com>
 <fa1c6e1e-068c-46d7-a623-58c225bb03f4@amd.com>
 <20260327114921.GL67624@nvidia.com>
 <d5059386-1ed1-4110-8283-16e3a8407760@amd.com>
 <20260330114902.GA310919@nvidia.com>
 <46de1d41-a660-460c-a49f-ae2d2ad7afe1@amd.com>
 <20260403140858.GJ310919@nvidia.com>
 <70912675-0737-4ebf-8ba0-ab9a2e493bbe@amd.com>
 <20260406222109.GQ310919@nvidia.com>
From: Alexey Kardashevskiy <aik@amd.com>
Content-Language: en-US
In-Reply-To: <20260406222109.GQ310919@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY5P282CA0187.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:249::8) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|DM4PR12MB5915:EE_
X-MS-Office365-Filtering-Correlation-Id: 60c6b663-45b5-4d4b-80a4-08de953cec8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	4MiP/6C4Tx+A9KtCKUCQ6/zZBtDEahcIXyE7i0TzcAyqkGXOq88ajL8c+TAlO3hBzYphGBrwSD2m3bQEZ8tQV6QeFM6h/B8AhnInPgfjf69jCFWFaDSsAGbC7b/ZXPCJbQ+1HEjD6zFBd7yVfWp9k7FEqduBwFdzRIlWYKLFecqV+QM7jzMgVosTuCW8LfdzmH59jJ6fLgDTUUjUpR1jL177h+diSdICppTau7pIfCqOQt61j5A9It3u8SClhvpT1OE6LRYKmuLRTyWD9th5/t07dQ+iZJ2Jb5MLcZDp5WbWqZTSzqJAoxUm3w8iLnRdUa4m61PaL6E5Rk0NVSqLdxvrxaAAsV6lXvDUKis8jowBVEST3woBQipS68iDP0x9Pboxw7JJ/SKbkK3d2IJfg0k/pvh5BeMzjnqNLqa9EQuOtpnuc+evufotdztkfWPlHXTDn6WH8a9waZBHTsk9dMr3EMQzA8Vh5ibf/5p5303tsfnDk/CxQjS0DH9MZrQI5RGt9xXsdsj2IPuCJCC67Z5olyFnT6k9n0prjxnRmsWU1ddoFXNJVWPgOtKvk7dTGik0smyzdKKDzRZZcdEICto6Rh/RO1+8nTZuA9TgeoRaRs28asoGYrd4qgKGXzca4hwwWrRc+nqy9F2ujSfQCVfM7VGiE+vKy769Sa5+owMVCWFtoafTj9gqmanSqtYDbV/UgKL1Bbx9NtmDqDAYBFKvfFit7wVn+bJv8wpeMns=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SHFUS3YvejF6RThxRTMyb0NyVzNDeGRyMkZxcUszR2VkdW1zZXptSUZBcm9p?=
 =?utf-8?B?dFk5cmFKS2ZpSU9adyt1TU9PbkczUnQreHJ3bkFVcnZZcTBFbnlWRTJoeVp0?=
 =?utf-8?B?UnJ5b0RZMGdRZEpCcDlqcFEyZjRCcUczNTNxb2kvbk5hWUZUcHJvcWZLY3Bm?=
 =?utf-8?B?ZG5OTXJhVzNnVjFuN2NlZHNKZnM3aUpYMFBQb0EwTDdyVk1qcHIyWXVPd3U3?=
 =?utf-8?B?RWxtN0VjNUVqUU96SnAvMnZ6WkNnZWNuaWg3bzF4OHpUcEMzeEdJU3lWWkxT?=
 =?utf-8?B?bldDUGcrVTRUaDdhakcvWm1vSks3d0lWbWcvUnZQOXdjbTc1alN2Z1hGZW9I?=
 =?utf-8?B?RG5abitpcWJ6bS9tbFJSWGl2Wlp4V1BmK2dIZjBGTjZWaThmRjBlODF4NHg1?=
 =?utf-8?B?aGJJY3l5SzV2cnptUU4xS0Q2OVZZYVVGZlJuODFtSGFuVjV3dXBVOFI4bUhF?=
 =?utf-8?B?WWdJRjVYWE1IZnYvZmtVVnpuakFMbm8wOWRvQ2pMb05ILzczeGpDUS9GR2E0?=
 =?utf-8?B?Z0ZYdzI4Mzg2ZDhQL0RjMXlTREFJYkxBOVhvRm5OZVRkYVRLa253NGxyMFpQ?=
 =?utf-8?B?Q1NxU2p6RzN5SVB0UXRlZ3VaTnVRZUp6eXQvQU9HTkY0Nll0RFp4VThTUUZD?=
 =?utf-8?B?NnhUQXgwMUp0a3NZZWJaNW81YkdvWFhXbVBNSGFOWGtBVUpLaWxnb2ZSVDd1?=
 =?utf-8?B?SEpwaFRkM2xPL1g2YTdlZTB2MldMbU9CQTZKUlhuSm5ZT3M1M3hKWnBESE84?=
 =?utf-8?B?V2s1U09XYnYwZlpRdXY1WWkvbjlUdHpHK0pmeUkzekl0YkswMXJnTE5tQjlD?=
 =?utf-8?B?K2JhNUIxYmFLL05va1pCQlFMclE5aU9ZZENrZ2RsL2N2b3dSeTNmY29Na0hZ?=
 =?utf-8?B?VTRnY1NiTm03NGdRYWJsV29zZlhTVGNTWmZJK29heHo5VWJNMWlUTjJUVXlD?=
 =?utf-8?B?SzVsVXRhQjc2V3MwNlByd1VHOXNUMTlTQStIa1VrajhxOEhWUVg2OThDamVU?=
 =?utf-8?B?dTVuYjdrNVluVWZaY3FmeHNEcThrL2Vhc1VuYWQyNFlSeE5yUDFZNlR2T2pn?=
 =?utf-8?B?QittWFM4dWtOOHY4cko4dHE2WTB6aVkrMExYOVg4bGhaR080dGJxd1BhNm0x?=
 =?utf-8?B?MFZKdHJKMXdRWk16Qm1kZmdGU2RhbDMyOXFTNi9UdUdrNlU5dERBR2xPMW1C?=
 =?utf-8?B?U1dkak9hUVNQOWhjZENrN2g2NTJwZFdrY3d2TUVjL3NYa0VSK0xYR3pIZmFC?=
 =?utf-8?B?NThjQTJKVCtHUTZ3VXgvKzhDem1IK2xvQnQzQ3JVaXp0YTFMckxJZDFDQyt4?=
 =?utf-8?B?d28zMlA1ZWdoRU5pQUVSMzR6NmttTEprSmxrUkZYZkRnYVVHb3F3WDVvOWlH?=
 =?utf-8?B?UHhiSVArWmpLRExleUhlMmhScm5Ndis4ZnU1M3Fja3l4WjdaV0dpTWJaejAx?=
 =?utf-8?B?TDRONnhCNkpoN2FjQnFqdjc1RjNDYzBidGRrdFo5R2RRZTNOZDFwNlc2L2lZ?=
 =?utf-8?B?RnRJSTN6c1hoVys2UkR3TEZwaWM0RVR0alk1VnE5S3hNN2dKVW8xbDA3Y1Rm?=
 =?utf-8?B?L2xvbHovOG9uT3dRMWZ4c1F2QmwrdEd3MnFMZXQrTHNhc003elhHY0xpZjJh?=
 =?utf-8?B?d3BXVURJYVErSWFVbGhSVGVwWlVseFZkVmw2UCszNkJGc2lzT3l2SU96SDZY?=
 =?utf-8?B?b05WYnYzcUJOMERpcm9MV2FiSytRL1VrRENXeWp3cDZPQjNNRENudFYzcFUw?=
 =?utf-8?B?blFnRjVoWWxqWDVBWHhSb1FWcjBYUEk3eWJ1ejhoR0lZSTE1cWJ3Mkt1bHhx?=
 =?utf-8?B?cHlJZW1SbisrL3oxY0VTL1M2dGg0ak9yemlSZEVyOHYyb2FSM0ljd04rV3pI?=
 =?utf-8?B?ZElGMzFvV1E3SjlDMlVYQVpPVVVQL0NJRGl1amFiYmYxVmh6dUxvaGRYTy9R?=
 =?utf-8?B?MHZCUkNpYzJ2ZmV3Q1E3SmtmcUlNR2ttYXE4M0J5enExbzFLdFlyb2Rsa1ZX?=
 =?utf-8?B?TTdtakV6TUtBOE9OWVZWOXJwMWcvZTUwRkwxclA4VTRXY2dLVElQOGVhVmhX?=
 =?utf-8?B?b1BSZDd0bGQ5eFljOGR0STBpaG5jaDUzYmRkL0JaRUltVFF1NkhDSE9uQjBM?=
 =?utf-8?B?dTRCOTVOU24yaTFtMHJRQmpIWEx5NURhTjZOY1VXYU1WUjJLM2RkOE95cnVw?=
 =?utf-8?B?R0pZOTJGUmR2bTlkR0lseHZTN1RjdHJiL21vL29PL0R2V3ZTcUwzRWRzVFhq?=
 =?utf-8?B?V2Y0T0wrRDdYZjZFOUJiUDVIYzZsWWE3aHQ1ZFhOZEhRN2JoMUF0cFNWNTdv?=
 =?utf-8?B?VFdvdzROL0V0WWFrZkdWUXV3YmxmL2cxdGJUbE9SMG1PZzdZQ1dHQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60c6b663-45b5-4d4b-80a4-08de953cec8f
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 07:03:23.4292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z7S9RtGuafg/697RnO2pmMoooFD9PIjLTrhQDRnA/RbRD8VgUaajtXjmq7s+dd2rHg0yhrQ5CkyuZz1FnzCkvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5915



On 7/4/26 08:21, Jason Gunthorpe wrote:
> On Tue, Apr 07, 2026 at 08:08:51AM +1000, Alexey Kardashevskiy wrote:
>>
>>
>> On 4/4/26 01:08, Jason Gunthorpe wrote:
>>> On Fri, Apr 03, 2026 at 11:41:25PM +1100, Alexey Kardashevskiy wrote:
>>>>
>>>>
>>>> On 30/3/26 22:49, Jason Gunthorpe wrote:
>>>>> On Mon, Mar 30, 2026 at 04:47:44PM +1100, Alexey Kardashevskiy wrote:
>>>>>
>>>>>> What do I miss? Thanks,
>>>>>
>>>>> You can't tell where things start so there is no way to relate the
>>>>> offsets to something the kernel can understand.
>>>>
>>>> Reported ranges have BAR indexes and start addresses (with the
>>>> reported MMIO offset added), and the first reported range starts at
>>>> the first 4K of that BAR.
>>>
>>> I was told this is not the case, the first reported range can start
>>> anywhere in the BAR?
>>
>> This is what I am trying to clarify - if all ranges muI thinkst be reported
>> (as some think this is what the PCIe spec says), then no, not
>> anywhere.
>>
>> pcie r7, Table 11-16 TDI Report Structure, MMIO_RANGE:
>>
>> "Each MMIO Range of the TDI is reported with the MMIO reporting offset added."
> 
> I think the argument was something like it didn't have to report
> non-secure ranges? But I don't know, it was hashed out in some thread
> for ARM and then I know our folks looked at it and nobody pushed back
> to insist that every single byte of the BAR had to be covered by a
> reported range.

That's (my ignorant guess) because of the ARM FW TSM guy which sees the BARs and can easily make sure that MMIO_OFFSET is such that BAR alignment is preserved (and there is a clause in PCIe about how such offset is "permitted" to be calculated) => does not make much difference on ARM but it does in my case :-/
> I wouldn't take the sentance you quoted as confirmation, you need a
> sentance that says every single byte of the BAR is covered by a single
> reported range.

Why "by a single range"? Every byte of a BAR needs to be covered (which is what my quote suggests) and the spec allows multiple ranges but also requires strict ascending order of the ranges, 3 paragraphs of text about it. Thanks,


> 
> Jason

-- 
Alexey


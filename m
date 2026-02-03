Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazolkn19012059.outbound.protection.outlook.com [52.103.43.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9302039B484;
	Tue,  3 Feb 2026 10:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770112875; cv=fail; b=aJ1KoVbKhKI0xidctmw14DrajcR2LIusYCiRPrYCMjlJvSVirGmY8fPUv2hYRFzCNhj8CD1EnwswWborRqJc9ObtSiJh7DlvPCkYqkSQrEk+j/xJlfp+iy8IddyTZFg8xCnMd3+sywWFHn/66He/KsWNE/triYdncYoYaDi6Xvk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770112875; c=relaxed/simple;
	bh=DEgDisZA8mkczK3/5w1zHcvHCWmLIgOGJOHkbrBCA1U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bH2b+KnVpSC19KKzJpglDw1fVhiWBy3Ne+mwS2aFSWf4lRncovvS9oOL3cBv6n/gB0T56YiQhQ/ouG6O7UbSdYxnNgH2FIMkRgD5jei5X0VCLfdt+dEXOvAa4eM4zOXeyCFRtn8RbBdGbv2OmXOtq4SAwN5ZCd0VAI8Na7D3PF0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=IsRM0X3T; arc=fail smtp.client-ip=52.103.43.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="IsRM0X3T"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eJ1Q33E5cZqefDZQFq++M4lJ/ZFCwnrieutHibmFGVl3XlUJimrG6QECHfV9+XSbcn9douAMhVvVF0qoSKtQWe8Mn03Z9eu6XHzpFscCEZaZJ4oLbGzh+vtxYi0YfqgM8cWUPk6ar7YjlxDrvM7K3X+qMhFRarzKStp8mfIePtjR3b9aK2pOz70DjDQCO2Xs0FCj9DhO7U1l7t3Pp1jhWvQel2ewdp7IZ5/v2wh49Gptz7Ol1bm75ZEoZ0PmzqEx9XLKgv7leKMMGY3hntyF5vq0zeKaaFKt/PqcWxG/MRKHb/yhkGYpltK6wche8O1kFPIIyWuml1RJ/YFV3eddnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gQWMYqquLEpQCZgSp05dZbkNJK+zp2ii7FNs//fgUGY=;
 b=IUeJKfLx0Q3+cx7NGlvlE6NAU2OxPJ80uJjdsKyvcZKK3247sXTjII1bgRxQ3DtghI5NGyI0FzDBOOHoWlwwZ3iD2jwkeH8oV/52F8KInYUqpG9wWSdh53qDKUWaCNvA+0Yw1nhrcybkz6EnP9I3Gw2ZR20KF/iNHzfbfrcnjs2GyRgIG0FcYX0bbnXGWxDKfpAqQdNLw0Ko9NQE7L868Cd4g1rDlZDTtVAWY3Xv9D0Mwmm9dk4rAtY3o/k5DOac/m33sjGtYfwIIhy3o8cGE3+qqWV2qhN7M59wi6Y1eajGPYFq5A89/hS1uZMMCoq8Hb2ya+45CkubBQC2CKuykw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gQWMYqquLEpQCZgSp05dZbkNJK+zp2ii7FNs//fgUGY=;
 b=IsRM0X3TG0fVAEPUJo3M76l2G2fHoMUoE2GpxyBkE4uHHlldUYLiVosmNAGYqpo+uvewQdsd/YOMsbMypEJ1lzELTDjhys7iTA/7fOl1uSabQOzxwN4O+O3U70Gniv7N3cOvszv3yTMeC75hKvtGB9yVzn2lkir296/EIbMGh3ld0KilJ1JzbXNC/UEiof+nijRGIh2bVOGtTI/pB2/ZbeRkJzlyyFUrxT4bNrTmE5JHB5c+6DEbG4MLfJ0L2qTSeBHKikSGCKLgCt3TR09bOuuYM3Ml2nydRhkaX4Ya8nHxIrpysGOA/OGT0E3nIREEuyzm4zCCWvmc+Za+hgx0wg==
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7) by TYZPR01MB6033.apcprd01.prod.exchangelabs.com
 (2603:1096:405:72::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 10:01:08 +0000
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c]) by SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c%4]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 10:01:08 +0000
Message-ID:
 <SI2PR01MB43933B0E7155F1858ABF5498DC9BA@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Date: Tue, 3 Feb 2026 17:59:35 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] PCI: Add the enhanced ACS controls check to
 pci_acs_flags_enabled()
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: bhelgaas@google.com, akpm@linux-foundation.org, bp@alien8.de,
 rdunlap@infradead.org, alex@shazbot.org, kevin.tian@intel.com,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <SI2PR01MB439325B4E44D5A39F34A4015DC9AA@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <SI2PR01MB4393537C4A9D8081FDC6B8EDDC9AA@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <20260202160324.GT2223369@nvidia.com>
Content-Language: en-US
From: Wei Wang <wei.w.wang@hotmail.com>
In-Reply-To: <20260202160324.GT2223369@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TPYP295CA0008.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:9::9)
 To SI2PR01MB4393.apcprd01.prod.exchangelabs.com (2603:1096:4:1b0::7)
X-Microsoft-Original-Message-ID:
 <a804a97d-2174-4e19-b0f2-3c1d1075c704@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR01MB4393:EE_|TYZPR01MB6033:EE_
X-MS-Office365-Filtering-Correlation-Id: ab6db86b-c049-4555-3daf-08de630b241e
X-MS-Exchange-SLBlob-MailProps:
	WaIXnCbdHrPy8Gg0T1tV+ubdyTLMpos/Jq3lTA987Bs36e7qOTp8LRaTktvnGewUs1BTl+wtVGRrUSA/I46U4r6c2Lc7dLRSus/rXDpN/m5ldIAYTIKRDaOVY+CvnOZxuuLUaRgKPPAREi8jOKRUKv3Hme2OYHW3/Qb3gWZyqmZa4wPjRfJU4BlmxXNUdu5/55RPbAwsvovuzLBZEPr5KoEk9JMteCayQDnHsiOTAxDMELE/qUtKu/YSHoPvQntBxjW6SKCPFiUUrwUJXfV9ypsV//eP1gP6SvG1ScpflhHJuwEIQDZbgAVWXAAOHIyCQ2yTuc6kQh1Thzc3SM7osbqrssHl9ixuwL2vlpwsimSHy0E9JxkzBomqV7CzP8vCfd+jnhNhlZvRMc9aM0bqruBlRvpTghIzZbI0yC0zXN4qwUPxvgwypZ3qcSpRhaxz0NRb58K3H0/i/HecvN/bHwdILZm14ca9Z8vxCEnXMqVq8cG3T87VeywI1YjoTDZe8MyXkaF8+SDoHXgua2JS1R7j2FkreqLEhDnXMdMg6H6dxQ/f3XHephmloo7TEvSHaLd18Uec711ltzHUdzCuXQYIQmQpELvTSJsXS1xpH9yhrQDMhgiwepnX/qf+AIG+4kUWrjmsKGXNWKzekoZNgogEgeLb/Y091yj+uSwAgQxmpNC5v8/xK7QQ7CMbJ07Wepc56GpDmII2WUgZW1bHXygkEndmuv73iyc5CDbFBqDwX0SIsVvOdfTV+fr3jnCCrrC4YsocMy0=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|41001999006|461199028|8060799015|23021999003|19110799012|12121999013|15080799012|37102599003|51005399006|5072599009|6090799003|40105399003|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OHVMamlZMmsyTi9sTmkxSnlSUFFaeWhCQnBYUCs2djZoY0k1TlpRNW56WXBX?=
 =?utf-8?B?SmN3RzB5SEZnQUp0MzA3RVoxRTc1T1BQRSthNUE5Z3FaQjAwdTREN0RNRFVK?=
 =?utf-8?B?UVlDbEc4NTFJRXNlK2VUUlJjRXNUc2FzOU5kNlBESzdxSlFWbkd0cFVMOUJw?=
 =?utf-8?B?R25RWnI4UWdQTGNGYzNnZ0FsU2ZaZnBXL0ErUjVvV0IxdC80OEtwc1dDZzFE?=
 =?utf-8?B?RDh3RmJWTXFqV2FuV0RRWEFJV1JEanZoQkJERW5nNS9nR2lXSmdvcFJWZy9j?=
 =?utf-8?B?djBiMU1KYzJDYm1QNFpYUVl1VmUzd3BSZHM3MERrMHBSODl5WGhmY0ZCS3ZI?=
 =?utf-8?B?NWZWengvSmhmYi85MWpNNWNGQ24ycHJQaXVaMkp2RTRvTVJ2aWI1eVl0ZUZT?=
 =?utf-8?B?a3Y3SUpIa2p4eGFOeWpSR0doeEF3clY4a2pGVTFxTTJhbzVsSnMxMUtIcGdG?=
 =?utf-8?B?OXkvR0VmeFpraXUvb1IvZGhOOUprRjVqMkRmTEdQSi85UG1kN0pvWlBYNE9j?=
 =?utf-8?B?NHk2QXJVc3pNNFBveHF5Z25UTzFzQ29hT1U4VS9mRStpa0JHTkVlclFqTVJm?=
 =?utf-8?B?V2lPaXFpY1VJOVFwSVVMVDA5RmtQWjdLZlc4eWNySHFtRUNLaFhQT1hqbUxt?=
 =?utf-8?B?TmNHV0FPbGs1MnZHNDZESmptdnY5K1ZDdFI4cG1jR0orN29NWitSWWkzbW5W?=
 =?utf-8?B?QVNQaGZIVXIyZ3dCVExZd1BsMXd0a3dQVWw0MSt3ZHA1cDFaYTV2OUVKSXIw?=
 =?utf-8?B?SHNyanJYeXM1dHJyTy91UXVXc2pIdkRFck9TanZleGZHTkwwRTRJQXFsQUJZ?=
 =?utf-8?B?Zm5IcHloQU85encyaTZ3WDlMdW4rcXR6Y21tTXdPK2tlTUpjdmtjVTBOL3hH?=
 =?utf-8?B?b29PelYwQjZtNEJkdlFSWjNuM3NzcWVUYWpBRUk3VVNFdlpKSmUrRXlVeVFj?=
 =?utf-8?B?djJsdE9ZaDJzREdjdTJLdGthWFZJaHZITTVJRUt4dys2clFGS05EYndRRzRq?=
 =?utf-8?B?VjZxaHM3dXZ2WTU4TDlDZUlTdVJJcHZvWk9rKzg1Y05KS1BWRjNaN01NL0py?=
 =?utf-8?B?QllyQ2JETmR6V3BOOHZVZXFtakFya2ZzaUhlWFpPakMvNVdHNFJyTElHOVhT?=
 =?utf-8?B?TVl0R1NsTEJ6S3hMMVByZ09UN1VwczluTWZIVUlXdm9rNTBNcndGeHlGdWY4?=
 =?utf-8?B?YTZyRkpySEh3QkhKaEgwa1c1Y09OaGRDdUI4YWJvbS9FU2xkQVR4OERlTVRn?=
 =?utf-8?B?L0d1a0JCNXdZNFJYWjlJN2M3a29NTUdPRDlaRDZyYkc4Y0FuYzRHZ2Q1amtY?=
 =?utf-8?B?VEdXa01FSnFtWEFBbTJmWGZNWVh3N0VvdmhGT3JYSHZkWHJpVm5uTWRlUXpK?=
 =?utf-8?B?bTZQeFJ3MG9kOVg1cWYyQmNXREhGR3Q2ZnlKWElyTWVLYlVJNVhVYUhYTVZz?=
 =?utf-8?B?TUN6a09Mb05WcDhxTVFxV29BSUpXdUpncUV4SWdsUHFJMEdRR2hzQTlSdllu?=
 =?utf-8?B?S2RnWURPK2ljRUQvMlBQbUZDM3RMb3VpeU5vTDd2VnBrcVc3UW5TMk40aXZZ?=
 =?utf-8?B?eE1sNkdZd0dkRTdxOFZEMkk4OFBwU1BBYjEzcFRrd256ZXNXeDJwZm9LM2Vz?=
 =?utf-8?B?dHV6L2xabldPSGgzTUlZRTYzRGR6dy8vcVRpRUk1STAycytxV3dXelpBZ3Vj?=
 =?utf-8?B?bGhqVHRRQVVFdGtZdEdyRExyZkFqYXpsK1RDRXREa000RjFFbEt5ZThpSVla?=
 =?utf-8?Q?H+TLn9J1WpX0Bv1GfM=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d0FSeXJaMmo5WXFBN1B0SHV3NjRMaCtxekRYc014VDdxMDhONDB6OEF2aFp5?=
 =?utf-8?B?MTRSYVM0dnZtclhGSWUzS2I3WDVUakN3bnU5ZCtPdk5hUzRYTi9jQk50eExu?=
 =?utf-8?B?RXllbVRmcnVaT1A3L3ZMTWlLS01JNDcyQ1hETGU1Ykw0MmdPRzBoT0FHaU5Y?=
 =?utf-8?B?eXY2Y3JqVERuVFVBNkh3aXMyQ3ZBdjM4L01zUUZacENGem5ZekxyZThTQjhr?=
 =?utf-8?B?bis5TUVNV3E3ZXg5a0NOQ1BTWXJjUDgwN1h4bEFvaWtlRjFwSjRhSjJhMGRN?=
 =?utf-8?B?YVFwT0JtQmRpbWxKc0NUVG9ZY0ZLTmdLR0lNRmF2U2RGcFBaV2dMQlRyanRu?=
 =?utf-8?B?Qis2UVpudUdkMlVndSs3NHdnUUNHcGgzRHk2R0NVS09pQkRKV2lQZlgwY3BW?=
 =?utf-8?B?KzUzM25uOC9EeXhTSTN2bVEvSzd3QnBEeGdrODRmcnNUblAxZ1dDU29Pc1Bz?=
 =?utf-8?B?aTQ3Tmh2MTBvNFB2NzI4TkJtbWJBTFloTDhVMXdwTVRtdURJOFdkN3hmYkpS?=
 =?utf-8?B?dDBHMElwRU9Fci9BTHFseXZyZDRhMFhrV2poT0daakp2dmdpUXZ0S1h3WHNC?=
 =?utf-8?B?UTJaK0h5WGZPTFJHMHlNSUdLcEo4Z1pXamxkQWxiRVZRbWF4aVd0TXg3WU42?=
 =?utf-8?B?VW5CNlVJR2c0TTErdmZjc2J4VHFPbXBBWWYzY2wvem5yM3BUczM5NFpTcm5x?=
 =?utf-8?B?T3gxczA2K0xZZnV3b0FDNWxtVkxtWnRnbElUYlJtSmoxUEJOMFFUODZnL0Fq?=
 =?utf-8?B?bytNOUlDSGxUVGNNeUEzRU9EQnYzYmpLZG1rZTcrNkc4ckJUenk3VDl1UER1?=
 =?utf-8?B?T3V5SmVnTjBETmwvSTRoQ1JJRWFYaGlHdklXbzlrYkIyMExiT1BESmlRdGFp?=
 =?utf-8?B?bWl5VG5IWDZkWTJDZTNJcXlRekkxcVE0YWpYbktGTkRHQXBUMS9aWW8wUXd6?=
 =?utf-8?B?S05VZkFVUFlHdUdxeUc4QkUvTkh1RjZmZDB6bG0rNmJRRlprOWpiVkpHSkJs?=
 =?utf-8?B?WkJCWFZCUEZWbmwzYmgzUmJKVWQ4dzdCR0ZxRXFDQ1h1YW1HUnREZHNOSEVE?=
 =?utf-8?B?bVR6OEwxM09OcmF5WHlqSVVPR1phdExUeldIbWdRQytob1d4aEJkSklPZ0x4?=
 =?utf-8?B?S3NTYXRZT3JzaU1wT1JCOGFCN1lzRnE1bDdCMm44VzhDRmk5dWlmQngrWW1q?=
 =?utf-8?B?UHFqMDBuUUoyUnR2ZDMvSCt6MHlBZm95dVJ4Z0RRWUU5c3RucmNTYU5OTDRa?=
 =?utf-8?B?Uit1Wk9RRnFVYkx6dllyVCtoT2ZPZ1A1MytkenF5d3lOc01OUUpqVi9VME5v?=
 =?utf-8?B?RzN1RzVNVUZSSnJRNjFEZWw3M1NzRXA5T1hNbEZleDE5ZW81c2NqTXVIOGtP?=
 =?utf-8?B?a3JoQVMvUXNlT09GQlBSb2pQaXFtOGhqR0x5L0xyOW80dFVSRktZNkxzVGxJ?=
 =?utf-8?B?aWRDazZVZ25yWHRtS3NSQnV5VEtPSGw4dXd3Q3RNT1pCZjBNS0FPdHRKdXp5?=
 =?utf-8?B?WlV4ZWFxenQrUlM2N3ZnWjJ0dDlmRS9ZckFLeXJ4ZjJrTHhNOWZIZGVPT09o?=
 =?utf-8?B?cSsrekF3VTBuQVYvbURxenlKR2JQQ3c3aUxaL1lHS2hxSDE4OWFydGNKVktX?=
 =?utf-8?B?Ym9DWUM0UjMwYStXeHBza290S2V6VkVlWUQ1M3lXTlJlbER4VERKb0hnN2JT?=
 =?utf-8?B?U1Z2dWF0TDBaNGVOL0dCemVCWm1sdW0xUklrTXB2VjgvNHBFcXJROUVOSU96?=
 =?utf-8?B?dmhBWHN0K2ZkOWxTYWFTUkptR3dyaCt5cUxjQmxqdVYxRVE3WndYcFVxbFlS?=
 =?utf-8?B?THIrTkcyUTJPZkpuUW8zU1JVaE9kbVZjSmlLc2NxMitOdTlXeTZNTGxSa0Vx?=
 =?utf-8?Q?6/4NdJ8fBFVOG?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-5f51e.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: ab6db86b-c049-4555-3daf-08de630b241e
X-MS-Exchange-CrossTenant-AuthSource: SI2PR01MB4393.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 10:01:08.3080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR01MB6033



On 2/3/26 12:03 AM, Jason Gunthorpe wrote:
> On Mon, Feb 02, 2026 at 07:33:35PM +0800, Wei Wang wrote:
>> +static bool pci_acs_ecap_enabled(struct pci_dev *pdev, u16 ctrl)
>> +{
>> +	struct pci_dev *usp_pdev = pci_upstream_bridge(pdev);
>> +	u16 mask = PCI_ACS_DMAC_RB | PCI_ACS_DMAC_RR;
>> +
>> +	/*
>> +	 * For ACS DSP/USP Memory Target Access Control, either Request
>> +	 * Redirect or Request Blocking must be enabled to enforce isolation.
>> +	 * According to PCIe spec 7.0, the DSP Memory Target Access is
>> +	 * applicable to both Root Ports and Switch Upstream Ports that have
>> +	 * applicable Memory BAR space to protect. So if the device does not
>> +	 * have a Memory BAR, it skips the check.
>> +	 */
>> +	if (pci_dev_has_memory_bars(pdev) &&
>> +	    (ctrl & mask) != PCI_ACS_DMAC_RB &&
>> +	    (ctrl & mask) != PCI_ACS_DMAC_RR)
>> +		return false;
>> +
>> +	mask = PCI_ACS_UMAC_RB | PCI_ACS_UMAC_RR;
>> +	/*
>> +	 * The USP Memory Target Access is only applicable to downstream ports
>> +	 * that have applicable Memory BAR space in the Switch Upstream Port to
>> +	 * protect. Root Ports, which have usp_pdev set to NULL, will skip the
>> +	 * check.
>> +	 */
>> +	if (usp_pdev && pci_dev_has_memory_bars(usp_pdev) &&
>> +	    (ctrl & mask) != PCI_ACS_UMAC_RB &&
>> +	    (ctrl & mask) != PCI_ACS_UMAC_RR)
>> +		return false;
> 
> I'm not sure about using this logic to detect a USP, it would be
> better to drive it off PCI_EXP_TYPE_DOWNSTREAM

Right. My thought was that only Root Ports and Downstream Ports reach 
this path, and only Downstream Ports have a valid usp_pdev, so it worked 
as an implicit DSP check.

Using the pcie type directly seems clearer. I’ll add:
bool is_dsp = pci_pcie_type(pdev) == PCI_EXP_TYPE_DOWNSTREAM;


> 
> Everything else looks OK though
> 
> Jason


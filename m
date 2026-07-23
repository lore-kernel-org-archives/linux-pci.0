Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012051.outbound.protection.outlook.com [52.101.53.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB68E363C55
	for <linux-pci@vger.kernel.org>; Thu, 23 Jul 2026 09:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784800198; cv=fail; b=eIXoBmX5q8dWWd1bXRHnK4LMmwANugMuBYCXsCe9iHP2O+ysy8NKgtuefFIrlNaAle9jxnIUpNHV9T/1LyVHPsfk8w6ZPN3qxM5SkKkAXcPtnbqkRi4TxfawJUSohPntTyXlwtWPXL/WM74+0BSHj2I4F+yJzAO9slFxQz1t9hU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784800198; c=relaxed/simple;
	bh=XcD2MOzgxZjJAHA5xa5p12e6EGbIBdXjU9Jsl+2jNvE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=e+DFPWjCimk4Txn+FkRkUq/upHCUY6IPCpG7sKNr5sNPHEDirD2FUG1q29F5Z+udV8Ye/U2S5PIzRb8nW3Bma+jtE2MyElJ87WMG0W/Osn7bbmWc0HJhOQKEA/DvGFscHfVY2ybZ/7m0KehsRBMNsDs2Gour+rkYMFAenYHbr7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YiTRxWyz; arc=fail smtp.client-ip=52.101.53.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YiTRxWyz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EeW2hoi5S8ZBsqLlt6Qu0yFxG3Nil54aTOTnivStir+E2ZAvcDEjzIJtv/LvEq4fvvPVK8DtOR05NE/HUUYAXaQIsJgzyBWwh9eUUMoyhC53Vm705WX9B6++Y/vuHgEoRIZud02oSh+GelgN6Sq3HXK4g4l3Wleh9v2fFWAVoVX1+V/kw1VkUU3vUemHDPHG1pAuFK39RgX3WXqLh8CDZeFjbM/Nh+P2Y8B0DWxS5wtfUT1OsHCWK/De7H9DJd6FlSVFBGXlXqHYQhZ8IOhHBNDadG1L6FAjAapmMwCfL9Fcwb9QaPYj57vxRDUIBh0+Fv/J2zfu66uVQWDAwTFVFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F0EiqQql9ZlOvO3ATYhfRQc9vFGYrM5DNWkTat6vpUc=;
 b=tn6H2zX/0qnlOGssqLG1yKFk8x39sgb+Y3W8i7r9L0jupP9Bz7dTJA6YCRyFQxNxQQenhiKlhXTmdoCMWl6CL2L8tEEk5nnbC7xW56nFpt1JrSvKATFuGNya+jSkDsdJFE8qbQtK748JlKtE+FWdz0g5MeKUuzGvq9u8wP/+qSidEMgG6MnJcvyz07SPYaDhFXcUMjZIktbZfRjYN/Lek2XAT38Ybidv7cyCqCTAQXHsKszJs3R/ghmWImrpW7BYtrEiAnSXc5sqy+X+dFWdHbFzIVe/xkacZDG4BjSFG+z3Cl7zZ4KkLvtbH075KoAomDFl97thkFx2Ng05It7aPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F0EiqQql9ZlOvO3ATYhfRQc9vFGYrM5DNWkTat6vpUc=;
 b=YiTRxWyzxvtvnUw1+Vp3NRWc/T81VxvW/Lbcg1/u3HuZCJ8gzWWP7OtqRcELCXX5NMI6o9kUuAuIB9AioMc/TQkjBIor6llZldt5i5fDN7jG3zUk9DGvJIopehVZSMEXxdssReUAlnUEml8ONZk6Dqrmg3f6hx9cpwTV1zzyIf5jpzWMZr/P44dh3L9dg62FjGF58FpYrT79+3bOcLtd2cdnZq1JkrJE7vnE1cRgPP8hx5XzyZZd55totCDJeASTHwl2NAZ8uuSxZgCvdadIo++59qI3G1jIefP/j9+hXFbNDG3xojbfpPgx6A7KWUUvKvYqUcubK47/p9dfZaKNIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB8245.namprd12.prod.outlook.com (2603:10b6:8:f2::16) by
 DS7PR12MB5720.namprd12.prod.outlook.com (2603:10b6:8:73::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.10; Thu, 23 Jul 2026 09:49:51 +0000
Received: from DS0PR12MB8245.namprd12.prod.outlook.com
 ([fe80::e7c5:cfca:a597:7fa4]) by DS0PR12MB8245.namprd12.prod.outlook.com
 ([fe80::e7c5:cfca:a597:7fa4%4]) with mapi id 15.21.0223.017; Thu, 23 Jul 2026
 09:49:51 +0000
Message-ID: <204d9dab-96de-45fb-867d-20defc0b79e6@nvidia.com>
Date: Thu, 23 Jul 2026 15:19:42 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: Disable NoSnoop and Relaxed ordering for Intel
 wireless BE200
To: Bjorn Helgaas <helgaas@kernel.org>,
 "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>,
 Thierry Reding <treding@nvidia.com>,
 Thierry Reding <thierry.reding@kernel.org>, Lukas Wunner <lukas@wunner.de>,
 Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <20260722170438.GA735886@bhelgaas>
Content-Language: en-US
X-Nvconfidentiality: public
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
In-Reply-To: <20260722170438.GA735886@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PNYP287CA0090.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b6::11) To DS0PR12MB8245.namprd12.prod.outlook.com
 (2603:10b6:8:f2::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB8245:EE_|DS7PR12MB5720:EE_
X-MS-Office365-Filtering-Correlation-Id: bcc5fdfe-5436-4df2-8bb1-08dee89fbd95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|6133799003|18002099003|22082099003|56012099006|11063799006|3023799007|10067099003;
X-Microsoft-Antispam-Message-Info:
	e9BLw/quK/WTbZ0oDMPt0TJ6PBc/cNJjvcarrqSNsM3IAROcRkT5wV4Ds4sVr8slZvoEsC2JVMW2yYrtt44xhUK5A5VuCMEncSuBKdf29cL+zemUvUGRB9gsx7w7MjJm+cNMQo1VfVPVTAZhaVuz1WoSn2cE+rJO+JsLGMIR0v16EBheQn95LDKtoePc2/iGxpi1gjiOy2PhyJCCDuycktg9L1o9H7DLTB7P1ZskTaCjGkuIDMXWEeLwLBrLxbG+0imLQoe/fW2LM2sXzXEGVRqquYIn9RvT1dvURFQwlOm7DK+TR/oVckwhS89ZvR+xrYaG+CiTGv6Q/TUZnrMlLxtCHLytRXR/ZHanaXPyPm6jrUgh1tkuXx96lOGlneHNvdVwuzNaFViKVE3LHsWFVM3T1mdZ+Xjs36v1uMMjZI2viVpxPa2LFbkSCfsJsychvIRRNfL0ikwTNiSWkcWy0tTdw+BVYJsmgOU6git0FdASYaqqOU7iHHujTBuTabb9BOmnygZWKFacNW0GbPTR9/DjJoAdnE8Gkm7U1EDR6ApnApLc0KEsbX10LVRQjaml+4ikowuVNT430RpFMOc/4Yc1YIXFOhy0/xgBc+D1gFNCMp+ma7MlaJEhrrx4i84b+0ExPkOl/fApfRJT105FJwEHDOenEFQGkpDpL8Bxukk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB8245.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006)(3023799007)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZmNrQ2dqelh4Z0FEMnlGV1ZaYkJteElUQ05LdE10djJrdnpkOXg2dVQ1ZGYr?=
 =?utf-8?B?OTlqd1VOVlkwclNSdkNzdCtmTnB1RHpCV3hqbk5QOWkwSW11QjQ1U0txS1Qy?=
 =?utf-8?B?aWp0THJZT0VRQmJvcTZvQUdweHJDazB4NnZ2ZktRdWhBanpxd2xXSkRZNWVH?=
 =?utf-8?B?U1czY1oyMjNsVmpmQU1ZbzVMSVVNSWtPelUycFVjTktVakl2YlpsdDNkUTBU?=
 =?utf-8?B?ZXRtZkVzdnFpdVVDZHduQk1ya3J4L200WjloTDJtbS9DNTF6MXhyS2p0eHc2?=
 =?utf-8?B?Y1NGaDZ1aFZ2UVIvSFlzWVJ0ZWc4OWNCbmtqYytBeFkvZDhPV0ZhRHBiOThw?=
 =?utf-8?B?NWU2cldLRzdqL1FYSjkvU21CK0JVMHhtT014TFEwelFYejlUQzQzejZ5Ykg5?=
 =?utf-8?B?Lzg2emxRaHcvbnhmRDFHV2hxUEZPdE9xTGNUNW5jeVBxUVVmRDVGR3NvY1Zn?=
 =?utf-8?B?bmlTcGxKTlFlOWwvTzhPajdTY1FJajdFREppTmJTKzU1QTVjdUZzZVlZRlpJ?=
 =?utf-8?B?clI5UmFpTXJzejhIWjdVM3luRjl1Z1c4Zjk0MVUvUThMMDJaTGMxUkVhaHNX?=
 =?utf-8?B?Qjc1UFBrYWpQTFdXUnhaeEo5VTJ1RFA0Q3Ava3A2MWhld3ZTSlpLYTZhKzFn?=
 =?utf-8?B?eU0zZkZqbjBZMWNXUVBEYU11aDR2RzV4OUp0T21WNUtOR3k5aXVFb2hKL2lv?=
 =?utf-8?B?WXZtV0FmUzlkb3V6dnRMRGs1MnFxd2NMaHZrN2FkQmdMbFdwdklZbkpIejNE?=
 =?utf-8?B?dm5vQlcwNFJhVlc4TGY1U2k5Wm9xQXoybWo5dS9ibkkxa0txd3VPSUVXbmEr?=
 =?utf-8?B?blNyWHBxMG1YMHBicXc1cEdOWkRjbUJNekVCemVtc1pGNHZMamd4V0RTZGFO?=
 =?utf-8?B?N0VWNmFTTGpHMTR4RDJCaHR2ZC9WVk5BSVZJVkNKa240TmlybmJLSzFlMU9r?=
 =?utf-8?B?ZWlPMzZJa3JRUVdWOEx4YUw3RU01cVVhejN3QkV5R244VTJNZjVuR01Ha3pX?=
 =?utf-8?B?NjFOTmNOVlNISXVuekUxbWViNXVDdVJGY2JSRzBSQjVUN1NEeEtEQStuNnRE?=
 =?utf-8?B?UGhwV3VkWFg2bE4rQm1jOWtVakNBeVlVZEhDWCs4R2NDOVdyYW1uOFBHaklk?=
 =?utf-8?B?Y05YSDNlY3hVWVEwYzhtYVgrQklZaEJ2SGRUNTB4Y1h5NHVLV2VkeG5iZTZo?=
 =?utf-8?B?czZyekxVSFVQaGNZT3pudkZ4aWNhQlNIaVNkVnVwaDZMZXZTaERLZkNUcDVa?=
 =?utf-8?B?cTdncktqY2xxVnYrNkQ2bzhhQjQ2bXhMRTJGdXZ0a0cwWElZeUVVWTg2aG1J?=
 =?utf-8?B?RG16VjRIOWUyTjJCWlc2N053NFA4TmU1OEFCUGJyN1M3MUEwRmMyQklmdUI4?=
 =?utf-8?B?dUZjTGI4K1Boa01BeGRQRVRUb3FRbXJ3WTdsbVVyaC9QanlYQXhPcWpuSjVk?=
 =?utf-8?B?bjZTNXAwZFZ4d2lTRUZSMDFJclJQRE9iWnVEMjhZZU4vRTVhVXc2ZWVVSVdk?=
 =?utf-8?B?c1VIaVVld2dhcm13MzBaaktzSXRyQlFVL0pwNlJCalZrZEFheWVONGRqMDRa?=
 =?utf-8?B?dzg2ZTJHREZxQnJ4Tm1ZSTQ0RUJ6VDg0Z1ZNMU9BdnQzVVI3N1FJOHBiaXg0?=
 =?utf-8?B?QXVCU2RxQnN4QkZrRUxTbXNTYjNmVDUyWGRaM01lUSs5TkU0YjJ1WXFiOVJN?=
 =?utf-8?B?ZUkvSnRJWHMwTzVsZzNJbW9tZGVBMEdLMFJwUWp4aWx4eTZrYUZ6cmZNek9t?=
 =?utf-8?B?TUxnVVdyZWFFTkQyaVduUTlxb2t2LzFkT2RhMW5HeHQvRmNIUFFCUldsVmhj?=
 =?utf-8?B?dlVDVXNDTEdZZHRid0dKLzZOU0ZRTEFNWGwxZFNGMzIwT1RtTVp5eEhYUldy?=
 =?utf-8?B?dFlFY0JSRWRWaTBDZ1NJY2FZbzdIZXhrMlVxblpxelJ1bmdRdkxiUUNoT3pI?=
 =?utf-8?B?OXlYV3NmKytLSWxmYndueElXZUF3VTVVSUZhdUVJVDdadTNrY1RPZWRhQ1NX?=
 =?utf-8?B?VUhsdFJ6VVYySUFsSHhsZEJyampqbWhzUWdYYmowdWlJcWR4N1gyOWRvVnVY?=
 =?utf-8?B?T0xyRjdQVjZVbWRPalZOWTkzeERvUktRVTYrZjVQc245VmthNEFkNmkwdlRY?=
 =?utf-8?B?RzlGMGlKWTA3YVFScHZFL0ZhbXBtYVhFQi9PM1hPV2R2OUhKWTM4YWhIcXAw?=
 =?utf-8?B?cWgxMEJiaFQ0UUdrNE9kL1lET29zQklLWlNGSXF3c3VJQjF2R0FSTTVEemhh?=
 =?utf-8?B?OHhWTXhpejBzWHJ6aVN3eWpKb21CdzlFMmRSV2ZsUk1IVTJzRldnb010ZkZ6?=
 =?utf-8?B?cWwrNEY5VDJlQzV5bTdmSm1xc3RCVzk0aTZVUVNQRUdWQzlxQ0Ztdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcc5fdfe-5436-4df2-8bb1-08dee89fbd95
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8245.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 09:49:51.5177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hj5m0Pf9smsC1ZbeyX2dUWXNLrzzLUmGobyt7ZwuL+9LDC+xuIofSaagp77Tr8FURtTdfBZtZFsjUadOqhZ0TA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5720



On 22/07/26 10:34 pm, Bjorn Helgaas wrote:
>> The problem was that we didn't show up at all in the enumeration. We
>> send a malformed TLP. I'm not quite an expert at this, but our PCIe
>> experts run a PCI analyzer on the enumeration on that specific
>> platform and they saw that platform's PCI controller sets the
>> NoSnoop and Relaxed ordering bit in the TLP. According to the spec
>> (which I ignore), the BE200 is supposed to return the TLP as
>> received, but we reply with 0 Attributes and the enumeration doesn't
>> complete successfully.
> I'm curious about the details of this enumeration failure.  Do you
> know which TLPs had No Snoop and Relaxed Ordering set?  Per the PCIe
> spec, they shouldn't be set for the config requests used for PCI core
> enumeration.
> 
> At least*some* config reads to the BE200 must work; otherwise, we
> wouldn't know the Vendor or Device ID, which we need to apply the
> quirk.  So I think you should see something like this in dmesg, and
> BE200 would probably appear in lspci output:
> 
>    pci 0000:04:00.0: [8086:272b] type 00 class ...
> 
> Is the failure that iwl_pci_probe() itself fails somehow?
> 
> You mentioned that this happens on Jetson Thor, but I'm not sure what
> PCIe controller that is.  My guess is it might be Tegra264 [1], which
> doesn't look like it's merged yet.
> 
> Thierry, Manikanta, do you have any insight into this?  Does this PCIe
> controller set No Snoop and Relaxed Ordering for some reason?  I don't
> think endpoint drivers are expecting that.
> 
> [1]https://lore.kernel.org/linux-pci/20260716-tegra264-pcie- 
> v8-0-23e51589229b@nvidia.com/

Hi,

Jetson Thor(Tegra264) is not setting NoSnoop and RlxdOrd bits in config 
read TLP.

I made sure that both these bits are set in RP's DevCtl

                 DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
                         RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+

and dumped TLP header for a config read towards BDF 0x100 with offset 0x24.
    0x04000001      0x0000000f      0x01000024      0x00000000

I think dmesg and AER log with header information might help with this 
particular issue.

Thanks,
Manikanta
-- 
nvpublic


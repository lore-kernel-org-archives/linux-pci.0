Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010009.outbound.protection.outlook.com [52.101.85.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE493B6346
	for <linux-pci@vger.kernel.org>; Wed, 29 Apr 2026 13:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777469147; cv=fail; b=pDRSAau9y+IRXWSMdUIpejs4q+Xeth2dhIQoWe9RC2gEmp/4ABi8wA7YMEixBq4PNokDk0UrKMV+cyUt2L3ByyKZMUda27GoBrCweAj5MeqqrVnDv3lhT7j4ZkexmRWr8+s822NuWXmgQYHTccmq8tIUBw0NKKf1F3J3xM9j7b0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777469147; c=relaxed/simple;
	bh=bt7PoTIL3XPdWjNSN01Rny/JFFKF8RD8jsM+lHcc24c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jMCvAZKsqHtIViOOABNijDhBEfTUI+9UBeRIMNDWM0DTq3QpULoMuzi+EM7ILOcAcPFCreRAe7wdrYTg3RGRQEgsKrroQ+/dPF4D+Zt3TLoPIFrXg4OnKV3lofYrd1kdlgCBk7SGkXD3/BWxpGrQ425cutL+rutP6zF0GrtP0iY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QTWvboCK; arc=fail smtp.client-ip=52.101.85.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QTWvboCK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jkqEZTBNG80+V/IMZ9lLkH06nfQAql+wcXRMtvm6NrqoTnm+j5ULEhBk4HPr+D3q2vaghimi15REkZCWgYoGZlLTqC0pf4q6PaJ5/+kM5JzecCFgmHkEK8NlykuTOV46LQSraSl9/QTp+iSCy6+NhnMgwK8c3ER/5LWFsEmWEFcRmy+3NP2DGdUX+QKp5gMHodyavu/zzK0p4x4UQsjzN2MDISveB64CtqprMaV26zYTtNfXQAlPoyA9KbmgX44CjojyrRVSyreVlzG2AUriqM10dG8whM1/UlsTNE/q8yskN95zUl2UvX1na0rEva6/h7Y+bdfJRU55rJ/C/Lx+EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n3rjqPSR2+eYiTtkHWwiP+NnWOEc4dKx7uF0q2nCOmw=;
 b=cu3jGagwY+7KgiiwIRtiTDPPsNiMpa0PhTCOVWKUvpTamtCLTMZoRroGd5rWgLjiT7B0ilBCV4bS8wX0SfusCPYu343SC/VT7BWz/JKOj/0NWDjvOxShoaZHTltH1rE06rv3FoKc8iYdqOlpjmFJIvDwToLV9nSWYEyyPXX1qf0fvJ46I4t4uUye/kzbZn31R+GWQsviS7+72wzdyoK4saubcfMDVmRCrehsFkfLh1YMreoH9kPCXPkKBiiJI5+3WLNkelbVrIYXnBfwPn2GEI/G8Nfup273pcTArL0dPPdnMFiMAonEmvUE/F6+IhCdpg3dxMIg3NvQi4kDgvBcHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n3rjqPSR2+eYiTtkHWwiP+NnWOEc4dKx7uF0q2nCOmw=;
 b=QTWvboCKVrTlZZpEqZSYqQxc3Q1RV4n7gCuat7X/eUghHMKlmvk2CutDwD5Wx1FFtSo2fPkXJ2lbLHUAiCGGF39Fss2wxC1KlXyp9uYfGTZMGOt4MglxPv7XWHo7j7tdjSCulmUCxIAwtz+eoIcOeMUfgxqfI3CBRkYqrmh4w/M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH8PR12MB7422.namprd12.prod.outlook.com (2603:10b6:510:22a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Wed, 29 Apr
 2026 13:25:42 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9870.016; Wed, 29 Apr 2026
 13:25:42 +0000
Message-ID: <21ed8a45-f19f-4a14-9aed-dbe0f545ae27@amd.com>
Date: Wed, 29 Apr 2026 15:25:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] PCI: release empty sibling bridge windows during
 window resize
To: Geramy Loveless <gloveless@jqluv.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Cristian Cocos <cristi@ieee.org>, linux-pci@vger.kernel.org
References: <20260428225146.3104063-1-gloveless@jqluv.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260428225146.3104063-1-gloveless@jqluv.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0130.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH8PR12MB7422:EE_
X-MS-Office365-Filtering-Correlation-Id: f3000ab2-b4de-45b3-9a08-08dea5f2d000
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	NpWxx5ruDHOWpJ3vEAJWbgqphOg3fVHJCKvz3sh3IplcJJLNcV751QsMY5kpYb3Jtd5VMkV5BuaqzHDbswI0CtiSG7TYENX2gdONfkoSpSrFDylqKTmNftcpDFw+tEVX3EcaWb2RCyLc+Pml4DaWEJHETD6JYm78KP9PXUb7j7krpcj7VzoEMaEYkVBKgYUqaXe2WRWmWdrRQGfJXoO4VO5mPLdBQfp1vD7+0pRl+e0n/X3xgOB8Rosnf/VjXn3KD20Ajm7TYO0pj8+RXy5dG/onnsUOxi97WCUilgpsU4ApQE54eT/J+uIBiQSN1Nh9y/6Mn2UZ/LszPQ7byfO9cl1gs2pu2b+LzB6C3LC2+CVS8rSFKUyk63PhMmKLjyNSuJCsfaTSjylq75DtTrxvUtD6a5z0aJgG3Mn0km5oJuOLFY7u23W+HpdhREcNJgnCOp/AxjC5+gappraot4HWs6dhp5RBQJF5tUzeLGs4ZNFzfdd92iFjUxM+2cxllYhiJjukfHp6ePRKhmQ5kXs8J9Bqk6djyB/lCfCLb46cT5s5H+YBZr6EhCrHzp4V1/A7wxNgTwDFvVGYnsdi4i/KLWlbra2jvgaFEOxnrYdKrpoNWaiNq2mIl0wTrIyMiSeEs1bazDtCvkNO7PMdYAWOGJJQPP6JUROcdFrJyf+okTwrnewVAe0EDDnUUjmJGm+JF2arVMdP+akPRJXpMOHkj3Z9qsLvItpDoF0hOvD7e/Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ODFaTzRlZ20wY0NGZXd5Qk83c2x1aFhCN1RIeUNjZ0lJUFdod3N4L3VGbGoy?=
 =?utf-8?B?YWFrVndhZ1BPbHZZSE1SRGZUSjhZMnBRdFhwdVBhWm1aSEJrRWZhMDJCaTRI?=
 =?utf-8?B?VVNBbEw3aWxCanQ0VkVpMXlNeS94VEpwOGV0RWhqOFdBK2prK24wWGIzWUR2?=
 =?utf-8?B?ZmxuZ2lVclB2Z24ycFhWY3lXMkZIYlJYVHRQUmNTWkNhaXJsM0RCQUE3OEN6?=
 =?utf-8?B?RlBmOUF3MUFncFRnVTNUMEJBaU00Nm9DK25OaGZyV3hhQWRCaVZmUmpBM3VG?=
 =?utf-8?B?L2pBcVo3YjV1aEcwR25LU0FxWHJTOTlRVUd5bGpNNTZMZkVzSTcrbXV5cHQ1?=
 =?utf-8?B?Tzg5Zy9NRDI3VUpoVHprYU5LSlB6UVI4WFJqRHNEbEYzeXV0eStjQTBkRm1K?=
 =?utf-8?B?VTJWeEEzTnFYY2trL1hleks3RjdKRzlYRys3M3RZbTJ0RFI1VWR6UXhxeFJt?=
 =?utf-8?B?OERxWm4wZkJSbHVhbG1CcytUODlraGxnYWdPS2ZjbFZaRGZUZ3hiR1F5cGRl?=
 =?utf-8?B?K0tuRHFIa0tIVGl2SnlYdTFlUDlXTmw1RVkvak5kdEg5TWZFRy9yYjlTYjNN?=
 =?utf-8?B?UGg4VVliRkg5aDNibWc2VUJSVk1rQmJNL3gxYlFISldlMVlpQ3J6R0RTS2xs?=
 =?utf-8?B?TEp0Skw0L1BhdjIwVU13dHgyVktiRDNpMnpSYU83NXZPQjNRQXlBZVVWMGo2?=
 =?utf-8?B?ZGRYWE9xRS8xZUN4Z3Z1VWY0YmhrNUVwNnFOOFA1YXJUdzJtaUhwMjBVM0VP?=
 =?utf-8?B?blluYjczZG0wUUlKZGYrQS9vbk5pdko2UWs1ck43bWdjUnpuTFA5eXNoOTdo?=
 =?utf-8?B?dS83amdnbjlJNHc4OU9oTDdubUVSaEIzMFpFLzBuV2owMDY0dk5tZzdPellK?=
 =?utf-8?B?RS90OWQzaVhZSEVYM1puUFZZMENyNUZFTXQvYnlGU25TUnFaVkFRZHZ2TzJG?=
 =?utf-8?B?dXNqREFveGpFQ3pMdEdTVGNuRFRuYjN2a2FkUUJsNCs4cUcwOHhmZEhlOGpR?=
 =?utf-8?B?Zi96VFB5Q3N4Z0lYclBoOTVoaUIwWDV3em9TbnpSRE1OZzJJUDc5ZEpCREx3?=
 =?utf-8?B?ZGh3QmVJbVlaK2M3Q1NtNmJjcnR3Mjg2cmlncEg3VzJEVlB3MFFkNFdOWWhM?=
 =?utf-8?B?Z1dtZFhGdEZhVlhEYTBIVXdwelI5ZFRTL2R2UVBLd2dwc2ZxOGRZUTh4WHpr?=
 =?utf-8?B?RnNnOURGZjVCc2ttNUpoaGNSV3VKdHZCd2Z1Z1ViaEZITTBnKy9yNUtFM1dQ?=
 =?utf-8?B?eWV1Y0dKMGswQWNFSmRBRUlqemJBeHVLSGlNUnJGTzgyT0t0MGdXd1pUOWov?=
 =?utf-8?B?Q0o4U2xvcEMzdlNwaHBVc1lBZ3llRXFSd0FkRzFhZ1B3UEpudExsSUVFbmdH?=
 =?utf-8?B?Z2ZycXQ2V01qQnoyUXhqeUQ1ZmphaFdMSEVoSDhTb2FZbG5TdDMrYUJaL2RQ?=
 =?utf-8?B?N2RSNXhYMk9sVFRnb2Q5SlNkY3ZLUmR6Q3d0SWU1NEdSL2NCN0NZcDIrSTNv?=
 =?utf-8?B?TGZHTitLRW53dS9OVnI3eDhuV3BwRkNSRERIV0RGNkMyS2poRFdwRjZidWk0?=
 =?utf-8?B?cStORG8yaXV2Y0xoOUhqUG5ERWh5Z042RXFBc0pFTndTZmdlUXF4WnhHOVdz?=
 =?utf-8?B?ZFNqdlRXaUNJbXlTK2w0aEN1alVpWXM1YW1Nd0ZxT05odTRvc0x0eGtEZjZi?=
 =?utf-8?B?eGErSnBmUklHUFlkRWFQdkF4aS80MkpxUDQ1cGlTN2VLUGE3YTcvUzBrMlEv?=
 =?utf-8?B?UzZmVjlRWVVGUU1LRWtHays0aWdHMUE1M20vdUt5cWZSRFJQYlFPUEFtZGMz?=
 =?utf-8?B?aDdDQW1zYUt5MExhSlNLLyt0ZTRvRVFDNkdQZXNXMkRVdFF5OEFwUzJ5SkNI?=
 =?utf-8?B?czAzMFZQQ01LLzRkNzdzQUVVZVF1TklJVjJ2MTNDcXFqaEp1RFZLSVZQcXNm?=
 =?utf-8?B?U3BqUHBvdXNnaGRkeTBsNnY2a2R2SkhyM3Qzc0Z2UW9PeitiaklSYXI3OGhv?=
 =?utf-8?B?M2JYNWRrRWwvbXhKMURldVRTSjVxYmNCTmhZVU5nSmU0ZkJLMEI4b2hRdjlh?=
 =?utf-8?B?TEhNK1Qwb2tpcmN0UktjREVvRXpQeE90VDF2WkxRcWlSRW05N20xR2JkeWFk?=
 =?utf-8?B?NkNRakkzN1c4UUZsUUxjeXU4bEdLaUEvMUg1VHZtTzdtR0x5MVU0QmpYMWZn?=
 =?utf-8?B?K2dzNXR6cXlSWHRadlZZc0JRbmttQ1dOT0hFSi96NURHcWJYcmlXZjJ3RkJH?=
 =?utf-8?B?WlpBUTR5WWtoRjBHMDEvUGxPLzZmNmlJVGNsU3hCb0tiUnVnOEs0SUNNODY2?=
 =?utf-8?Q?gOVZfE0hVUSroSrWE7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3000ab2-b4de-45b3-9a08-08dea5f2d000
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 13:25:42.5506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n9dtEN5dLFUTDryMuTQ1ffYsj695QVRaZ+IPyjcAxtl5QqNQolvpIOGFLNWC/g84
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7422

On 4/29/26 00:51, Geramy Loveless wrote:
> pbus_reassign_bridge_resources() refuses to release bridge windows that
> have child resources. On multi-port PCIe switches (e.g. Thunderbolt
> docks), empty sibling downstream ports hold small reservations that
> prevent the parent window from being freed and re-sized for rebar.
> 
> Walk descendants of the target window depth-first, saving and freeing
> each empty bridge window so the parent can then be released and grown.
> 
> Without this change, attempts to grow a window deep below a switch
> fabric leave nested empty windows pinning the ancestor:
> 
>   pcieport 0000:65:00.0: bridge window [mem 0x8880000000-0x98800fffff
>     64bit pref]: not released, active children present
>   pcieport 0000:00:03.2: bridge window [mem 0x8880000000-0x98800fffff
>     64bit pref]: not released, active children present
> 
> With the bottom-up walk and upstream ancestry check, the chain unwinds
> and the rebar succeeds:
> 
>   pcieport 0000:96:00.0: bridge window [...]: releasing
>   pcieport 0000:95:00.0: bridge window [...]: releasing
>   pcieport 0000:94:00.0: bridge window [...]: releasing
>   pcieport 0000:65:00.0: bridge window [...]: releasing
>   amdgpu 0000:97:00.0: BAR 0 [mem 0x9000000000-0x97ffffffff 64bit pref]:
>     assigned

That sounds reasonable and I can see the rollback store 

But do we make sure that we can allocate all released child resources additional to the resized resource?

E.g. in the above example how is the new size of the bridge window determined? Does it include the released child resources so that they can be eventually be re-allocated when drivers start needing them?

Regards,
Christian.

> 
> Suggested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Signed-off-by: Geramy Loveless <gloveless@jqluv.com>
> ---
> v3:
>  - Restructure helper: outer loop only recurses; inner iterates bus
>    resources via pci_bus_for_each_resource(). The release path is now
>    unified, so the caller-side block in pbus_reassign_bridge_resources()
>    is gone.
>  - Walk the resource tree upstream when checking ancestry of @b_win,
>    so descendants in nested topologies are also released (Ilpo).
>  - Drop pci_resource_is_bridge_win() filter; bus resources are
>    inherently bridge windows.
>  - Rename pci_bus_release_empty_bridge_resources() to
>    pbus_release_empty_bridge_resources().
>  - Drop misleading "Uses PCI bus/device iterators..." paragraph from
>    commit message.
>  - Kerneldoc tweaks per Ilpo's review.
> 
> v2:
>  - Use PCI bus/device iterators instead of walking raw resource tree.
>  - Save released resources to rollback list.
>  - Filter via pci_resource_is_bridge_win() (now removed in v3).
>  - Call release before the !res->child check.
>  - Check bridge->subordinate before recursion.
> ---
>  drivers/pci/setup-bus.c | 63 +++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 61 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index 4cf120ebe5a..0c1fb654c9c 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -2292,6 +2292,60 @@ void pci_assign_unassigned_bridge_resources(struct pci_dev *bridge)
>  }
>  EXPORT_SYMBOL_GPL(pci_assign_unassigned_bridge_resources);
>  
> +/*
> + * pci_bus_release_empty_bridge_resources - Bottom-up release of bridge
> + * window resources in empty subtrees.
> + * @bus: PCI bus whose child bridges to process
> + * @b_win: Ancestor bridge window; only children of this resource are released
> + * @saved: List to save released resources for rollback
> + *
> + * Recurses depth-first into subordinate buses, then releases bridge windows
> + * on the way back up.  Each resource is individually saved before release so
> + * the entire operation can be rolled back.
> + */
> +static void pci_bus_release_empty_bridge_resources(struct pci_bus *bus,
> +						   struct resource *b_win,
> +						   struct list_head *saved)
> +{
> +	struct pci_dev *dev;
> +
> +	list_for_each_entry(dev, &bus->devices, bus_list) {
> +		struct resource *r;
> +		unsigned int i;
> +
> +		if (!dev->subordinate)
> +			continue;
> +
> +		/* Recurse first — release deepest resources before parents */
> +		pci_bus_release_empty_bridge_resources(dev->subordinate,
> +						      b_win, saved);
> +
> +		pci_dev_for_each_resource(dev, r, i) {
> +			if (!pci_resource_is_bridge_win(i))
> +				continue;
> +
> +			if (!resource_assigned(r))
> +				continue;
> +
> +			if (r->parent != b_win)
> +				continue;
> +
> +			if (r->child) {
> +				const char *res_name = pci_resource_name(dev, i);
> +
> +				pci_info(dev, "%s %pR: not released, children still present\n",
> +					 res_name, r);
> +				continue;
> +			}
> +
> +			if (pci_dev_res_add_to_list(saved, dev, r, 0, 0))
> +				continue;
> +
> +			pci_release_resource(dev, i);
> +		}
> +	}
> +}
> +
>  /*
>   * Walk to the root bus, find the bridge window relevant for @res and
>   * release it when possible. If the bridge window contains assigned
> @@ -2316,7 +2370,12 @@ static int pbus_reassign_bridge_resources(struct pci_bus *bus, struct resource *
>  
>  		i = pci_resource_num(bridge, res);
>  
> -		/* Ignore BARs which are still in use */
> +		/* Release empty sibling bridge windows bottom-up */
> +		if (bridge->subordinate)
> +			pci_bus_release_empty_bridge_resources(
> +				bridge->subordinate, res, saved);
> +
> +		/* Ignore bridge windows which are still in use */
>  		if (!res->child) {
>  			ret = pci_dev_res_add_to_list(saved, bridge, res, 0, 0);
>  			if (ret)
> @@ -2327,7 +2386,7 @@ static int pbus_reassign_bridge_resources(struct pci_bus *bus, struct resource *
>  			const char *res_name = pci_resource_name(bridge, i);
>  
>  			pci_warn(bridge,
> -				 "%s %pR: was not released (still contains assigned resources)\n",
> +				 "%s %pR: not released, active children present\n",
>  				 res_name, res);
>  		}
>  


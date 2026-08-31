Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012016.outbound.protection.outlook.com [52.101.53.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74416390CAC;
	Mon, 31 Aug 2026 18:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788199682; cv=fail; b=A/y0Lu1BoyLJsW3E9rqXhFWb57XRtT57yuL4kzPZJHkOgUjaSYAo/cBesDRxO82w+4/UscnSu80mEZjgnoOd+pfNgzoTrPU1wJrVO1gWak5g9SRqYRX67Db/5Y9TDqYgqU49QSHKDVOpXy/wPN1mqEu8PsB6Ndi1JdSY/wVfIhU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788199682; c=relaxed/simple;
	bh=FMZ67ulPcZS6Q8HomniHYCDzaEpKlts0LZuBtE+/XwU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GrQPpQ7TAccXUoC3kgKqWlEf4c33iqpWwats+M8osb3sh8xew/MJugn3WFoTRtDyeSdySQ/UVgob0Mlg3Q5Jy8fNOnaaa6ld9KNJHulw/xWLdhZjl+CPe1u4LOGMkWT2l3rPfbpl5gVCSXjf+l2r7UenIUvMydNFWzmTCDxnaQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GgU6PkfV; arc=fail smtp.client-ip=52.101.53.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GgU6PkfV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WF3VPW5kp/tpjK9nXEAMF3L29JLlnFXVNnahmAWFLxVGLBLC1r4otZBr7nLExtmANzFrtU05YdYHbKfmWZCk/S4cUiskaSFi+bOQ+93drIvymWnru9X1UfrQicQpyfPrdDRHTMH2E1TCz6r7TdGZpGtCc5RIm3c4TvcC6Jo6kenRLNnzWX87i3HU5iPXyt9C0uSqJ/bMQX+7cp3Wkmm48VNFLYSpDDbcLSaYsAlylrl0h+f++EUrjJqGOVg50bOS8vs4hXR7nx1xcb08QyC67ZCBGoKmLyZldLLmzPXFXHxNlhq1RW8p5C8xe+tsbs6AEhA8dc/xX0CkqViSssglbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mRM2YspsMtzx2Re+gl0C27KuYZ3AUylWD2tdOvny+YU=;
 b=biDWEpjLxJFE8Jl9Q+Z0fdP7yj4tkrObL31Os0MKQypARPkqGMwApe3+SLkzYxzWpvjFfGN8Usm4vpsLt6bXAjOgSdagfUb1t42sy4UjJw0jxdBnKCqzZGMk5ur28vlNSPRPyCdF8h2XVrz6DJoIaEGVckO5TQZxOyoWqiLD7QP4f+lP26y62qMFf20CwFxmJ9ey+4HyHA0/h3yGrtTTSRPDg0Jwzaer5lPlYChgyT+mOUNV1DLUPxgS4bZHhcu0ENWUStxXto1uxivW/P1YQ9I+qku/tTrga0vdj88X32a6MHbnCbwmq1ixxe2wCKMjHVeZtxQdOusVQ40fKy9kxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mRM2YspsMtzx2Re+gl0C27KuYZ3AUylWD2tdOvny+YU=;
 b=GgU6PkfV0MC4ACJ5eSUZseUkS4KslM9qfQ7C7PpGyJCuqp06aO+SvtdWhUGS6fuguUrILWMKbGmGnGvHyQLYwOPCSt8yYakqERJnaaL40sFtPY+6eCJTY9aXfzCQJ+pRVO2NTKTCmeMRIlw7Y5Ro4MHTSacofPyWKoUQyPraK84=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH8PR12MB9765.namprd12.prod.outlook.com (2603:10b6:610:264::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 18:07:57 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0339.007; Mon, 31 Aug 2026
 18:07:55 +0000
Message-ID: <b8cdbf77-0149-4805-8e41-d4db36579679@amd.com>
Date: Mon, 31 Aug 2026 20:07:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: Reserve prefetchable window headroom for Resizable
 BARs
To: Geramy Loveless <gloveless@jqluv.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, alexander.deucher@amd.com,
 amd-gfx@lists.freedesktop.org, mario.limonciello@amd.com, nra3088@gmail.com,
 meiling.leung@embeddedllm.com, linux-pci@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>
References: <39e09dd8-f73e-4dc2-ba36-8a9228516d26@jqluv.com>
 <d4c3ea40-d92a-49c4-ab2c-925fc70c4bb9@amd.com>
 <d6c56ff3-0b83-4d2e-7e6f-f3e65a284341@linux.intel.com>
 <1eb85efc-43f4-4929-8390-467308522236@jqluv.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <1eb85efc-43f4-4929-8390-467308522236@jqluv.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0248.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::7) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH8PR12MB9765:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b6dd07a-0028-42da-c679-08df078ac825
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|4143699003|10067099003|5023799004|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	KwBpuyLmS9glttsNoY6K4/pVGD+DQJfju7jHniMz5rcLQc39uZMDPEjZEyqXCck5dO0S23b/CJVBoNBBrA9eJLFd0rhcwq+9PwtK6EmqFKiN+xj9/TsQbB9o7/fs3Hkwipc9JEQuUtP3K4jcghNwUUZVTjErOAzmR1RM9Z7WmarYDDuuVyNriLtayJ79stzuQB4WnF/zS6jgsrb7p/AzNP+iFaWJrdxNGbodtukhp8HtXNADPk8LJAJ/15zUndXmuIOF6SFYIw8KTVo8jyEjwXm2ssclcMDir6UWq7GPLGyk+dgvqbJMVc7w+tyy9OEIZ7EmroAe6z3+deXXKTNY6qgw92w8jbDAVqFDf8UkkN5EnWFH32PX40HvZFTdBIRpOx1l7lJOEjvLjvsHnk/hDkIuxyVQpcpAeHIjY3BhigBoCzVEshfjp5X+8qUX0zZl44XmU4cYvE3+StvJ9Aq3B5i1bQzjl534kREdoi7Xml/9/2/o+2cV6mOH7RlFL0qM8sOyl3Bvvzn40IDzu6yFZLUx+IEI7/YkXYF7W7XQpK8Ipn29dd0Fj6ML7nbLjPsIYcctFakqF474NCCpGszCXNje2aXgvixMPVuyuDcbb9t6l1fyXnL3FK/V5g1muRZm533mR//cVFIi2+s3nSruvIniKkVZozDsAxxCk9pRBHQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(4143699003)(10067099003)(5023799004)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OHRWeFFGamFURUs5bkJZdXJwaUFLUlFYaHVYTEtHeWtQbEVQUWRDVXZFYzFs?=
 =?utf-8?B?UkJDVm8rUmxPRUhpL1N3MENXVnkxSENvd29BMHNzcHdlTUxBMlo4MmlPWEQz?=
 =?utf-8?B?U3FvUFR0cWZaMjdTcHlZeGtvajZXYlZBVkZOUzBia0Q1UE9nRTA2MW1nVSs4?=
 =?utf-8?B?aWpzWit3OGtaTkV1ZTk3bFZ1N2ErS1N4eUhNb3huZVpZYTFvNDJ2a0hZbTBX?=
 =?utf-8?B?eXRScmZkN2FiMEh2RWZ0ZHlOVytBeHZrcVkzVmtMRU5JaHh4enQzenlTS2VO?=
 =?utf-8?B?ZFYyYnlmNDFndVhFcktqMlpiS1lRdFFyb25XbHBSekVTb1J6Mm5IR1N4Z0RG?=
 =?utf-8?B?eEZ4WkVmU2lhQS9WaWYxRW1mU25JcGxsbjFEa29hRktBa2FNUTc4U1pOOWNh?=
 =?utf-8?B?eXpsbms0a1NLYVVhV3VrZndDcWljL3dLU0FuSjRhaGZrK0NJZk45Q1c5RGph?=
 =?utf-8?B?d1pLc1l1UW9DN2tNblFjWEJHdDQ3MExBVEkrUEh6cnl4OENJQTdxTVZDdzZJ?=
 =?utf-8?B?aGIzOGZZV1M1Q0Uwa0YwUXRla2dUenZhRkZhMkgwUEoyU2pTdGNmNkhNY0pQ?=
 =?utf-8?B?VEVtbldDcUhMMVNCTXg4NEN3Ly9MMFFzVXVOWEU1bmtJeEtoMFBoMnpqWEor?=
 =?utf-8?B?YjlIQ3BvZTlNb3VuK0tMTEkwMzBMeHkzZ3dBaFk1TmlqTmVCbDhRUitvVE9a?=
 =?utf-8?B?T3prc214eEEzSjZkajlpcnBWeUtGRkRkcEtiTWdUQStKV3RzRE9ZOWRsOHBV?=
 =?utf-8?B?Y0VmSzQ0anFOazkrczNzZ3dXeEJJdHdwbUhkdkNLMXduc2RHdFJZZlZpaHdC?=
 =?utf-8?B?QmhkdENMYytHaTFNWVIxdzI3UUhtd1VZd2sxQTBnVnBOSmRKdmtNQmVGaWp4?=
 =?utf-8?B?Q3I2LzF2OU5GdTBLYmJob3dxclJEbFNKbUVvVGdXMDdLSld6M3BqMlEwMWFK?=
 =?utf-8?B?d3ZrL014TmJFQ1djNUlEdWhjMzRnazRwSnNpc1pPSnhqSEM1YVB1U0QvSmpY?=
 =?utf-8?B?WVkxQ2pCeHVkSmZFRUVtdDJac09iWVZmRWVJZXA0dmo3VjZ3YlV5TEVScmNX?=
 =?utf-8?B?dXdHck9MZmljWGFXSUlLY2pZNDlnMmk3SWVDLzJWSXFHZU80bzJUZThJak94?=
 =?utf-8?B?Vy9TMWxvM1pjS2NkMy9aUlVqNFcyQjdHYTNjY3V0WG1HL2MvVnlBZFVwZG56?=
 =?utf-8?B?dUxsQlJ3Z1NZZU5NdkhraWtZbC9ncFdsSFZFRXBweVRhVnlEMXM4WWlqTnF2?=
 =?utf-8?B?TUdJSjhia1MzeTFtMjIrQnZZZlpVblZXdEQyaFQ1VUd5YzU3Z3RpdGFrOWNN?=
 =?utf-8?B?TUlxNVBFcUdhWUV6VVNQS2lpZGJaNnUvWThoOXhlZGhUdGJUMGdrSkhxNlZZ?=
 =?utf-8?B?NXFhTUQ0U05sNGlBZERKN2F1UmE4eWhDSW40cHJVYWJoYzJJNGR4R0FxYnJ5?=
 =?utf-8?B?aTk4YzhvYmZ2UzZjUHdpVlFGbGpmbWZtQzd6WnFsbU84SFNsUXBwY2R3MzdJ?=
 =?utf-8?B?MjZaNjhyM1plcEJ5Z3RxcWtIcDhwL1FQdWdIVnp0M3NWa2hFQjJKRjBaeU1x?=
 =?utf-8?B?OFAzZDZncUk0d0JxTzI1b2RNTjB2RVNmZUxNclphR3RvZmwveUUzN00wTFhx?=
 =?utf-8?B?VERlR3YzZys0R2JnSWgrTVJreXhuVkJMS1diQXYzSDN1aFQ2aFJhK0d3Y0Zk?=
 =?utf-8?B?d3ZOSTZtQ1JnMWI4TndBQnFlNzVOZFhmckVxNlZ3aTJtak44NGJ4WHM2ZGNZ?=
 =?utf-8?B?Nmd3VStSSDFhTjM4N3k2NEhkcTRiZnJ4eDAvd2FRcVNFWDRJTDI0Z09jZy9m?=
 =?utf-8?B?ZnR2VVNnMlIwRjFYUHJsVjFZSE9pZmdiL2RUWFdFL2trK2IxUnFvV1diZnVM?=
 =?utf-8?B?YVJLRTVZY1dEYStOa055QzJ3THJiS0pUall1bjlCMmJESUxCSkxkSStDbll3?=
 =?utf-8?B?L01FNVUrZldjdlhqeUdMdW5MbzBoOERNdCthSGtkUmljM01IWEJIQUVFZ3Z6?=
 =?utf-8?B?QW9tUkw3bzZGa2tpVHFOTGRXc25tWUkxZTBTeXpRMXlyQVhRY2I0cW5tTnd6?=
 =?utf-8?B?Mm0xY1R5R2ptUnNjUk0wTjRzQ3dVSTVUVncxVVFwZDBLd3B2ZTRoRnhsWll6?=
 =?utf-8?B?aHpGcFZKTEVJRk5lNHZkcFFGeWdpVVFXUlJLeTRPQW5MN1pwSzZ1SGZwRXVi?=
 =?utf-8?B?ZnhqUExCZzY3RXNPSXVTVjYwdVpJbkdlc0szQzdjdlBqOUlmRHhoZ0NnZmdu?=
 =?utf-8?B?UGVJbVRUY2hnMlBEMXIrODZRdFN1bXNRWkIwZ1B1SDRPcDlyYkFscjhrVUlV?=
 =?utf-8?Q?4EDIdK5lNWrulYdoam?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b6dd07a-0028-42da-c679-08df078ac825
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 18:07:55.6376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1DhGOGWPUEm/vUeDAWsIBPceBxGRW3vYzcFc38HlvIkBsuEnbvvtUtCuxxmsIGuN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9765

On 8/31/26 19:49, Geramy Loveless wrote:
> On 8/31/26 9:58 AM, Ilpo Järvinen wrote:
>> On Mon, 31 Aug 2026, Christian König wrote:
>>
>>> On 8/28/26 23:37, Geramy Loveless wrote:
>>>> Firmware typically sizes prefetchable bridge windows for the boot-time
>>>> BAR size. Behind a fixed (non-hotplug) PCIe switch fabric, there is then
>>>> no room for a driver to grow a Resizable BAR afterwards: every window
>>>> from the leaf up to the root is sized for the small BAR, so
>>>> pci_resize_resource() fails with -ENOSPC. 
>>>>
>>>> Furthermore, a small prefetchable BAR (e.g., a 2 MiB doorbell) sharing a 
>>>> bridge's single prefetchable window with a much larger one (e.g., a 32 GiB 
>>>> VRAM BAR) pushes the required window size past the large BAR's alignment. 
>>>> Because bridge windows round up to a power of two, this forces a massive 
>>>> alignment waste (e.g., 32 GiB + 2 MiB rounds up to a 64 GiB window, 
>>>> wasting ~32 GiB per GPU).
>>>>
>>>> This patch solves both issues to enable ReBAR on cascaded switch fabrics:
>>>>
>>>> 1. Reserve Headroom: 
>>>> Reserve prefetchable window headroom for the maximum size of each 
>>>> downstream Resizable BAR during the bridge sizing pass. The device BAR 
>>>> and hardware ReBAR are left at their boot size to prevent tearing down 
>>>> firmware-loaded state (e.g., AMD R9700 PSP) before the driver binds.
>>> Yeah that was suggested before but that is clearly not something you can 
>>> do in common code.
>>>
>>> The ReBAR fields often doesn't reflect the actual needed space but 
>>> rather the maximum the HW address logic can resolve.
>>>
>>> So what you end up with is allocating multiple TiB for a window which 
>>> just needs few GiB, sometimes even completely overflowing the 64bit 
>>> address space made available by the root complex.
> 
> Yeah I could imagine that would be bad, hence I tried to compact the 64-bit space as well. As far as I understand PCI/PCIe standards its making this patch difficult.
> Christian I'm not sure if you could share these reference documents but that probably would be a better start for me to look at before I update the patch or make changes, also I need to wait for a review on the last patch I submitted too, so that leaves me with some time to review some standards if you know specifically where to look, if not thats fine too.
> 
>> Yes. A naive approach to (only) go to the max ReBAR allows just doesn't 
>> work well enough to be usable in general case.
> I did not know the max would report above the amount is actually needed because of vendors decisions in the cards, that's interesting.

Yeah as I said before to actually figure out how large your BAR needs to be for an AMD GPU you have to load quite a bit of FW and probe the connected RAM chips.

If the GPU is your initial display device that is not much of a problem because that happens quite early with the VBIOS load, but if you have non display HW the driver actually needs to do this ASIC init/reset.

The bus interface just gives out the possible BAR sizes which could potentially make sense on the board.

At least AMD has also produced quite a number of GPUs with bugs in the ReBAR registers, so for example Navi 1x reports possible BAR sizes of only between 1 - 4 MiB while it should be 8GiB at least.

I clearly don't recommend using that register as source for the resource estimation for upstream bridges.

Regards,
Christian.

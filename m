Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013052.outbound.protection.outlook.com [40.93.201.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE84A49E5D2;
	Mon, 31 Aug 2026 17:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788198911; cv=fail; b=TPaBonlP9UT2mAd4YzYxgI7isUm5Qzi1/PFQkI1ybbw3RPcsfUa6X5pWPYuAIKC+VVi0nHAV0I66xeA1vgdBvN8JpEkws8/H0+7OdDNOzRpp5rXkM7TkGUCH8I+pgAO1oMzxEixFXAjl46vRRg+5DINSQAuvKusNKGsMRWzcOio=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788198911; c=relaxed/simple;
	bh=ykiLA7S5AKidzcve8NvHOvS/XETVcn/89npTTIwU1Uc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uG6lhcOYKKxm693m6kvLiHSoYk1dlbexY5BcTEA/SrVZlINCDzUrIES2XdRaDaCAKGaVpOLuTuwn6yYj8Ly03t1c8tAsisGesG8ebB2JGSgWgM8SCZb/B+ilE1j3TlhanstXcXFksPht2ZOHZzvbEZ2bMW2aKBSSnM0MHlNECdU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MLt4NHmX; arc=fail smtp.client-ip=40.93.201.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MLt4NHmX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KMTvTnPNiHrrG8cDmH4PWlqI7W9+HC4wREqeDYeq7/FB7DJ46KImc90zDIf9ndyfnNyxlzhbzhrsvwKykhYsm2eo4p5SjNjaejLnchY8csJJjow56GEZgsYFczL5TzgDc4UYO6P/G6LF4nMATKEMdcEG1ASuPjFoZ4zOZC5zlWEn/yEkxuPSczAd2XSrgu1kZp+tSOXnz5gTJer3JGQHTejw4JtV4W7czniFR5/IyOAgrvo0LNlaLukIkfltTzPkT7TciT7qbe9v/9lyCEsWZxsoh0WnYLbFw8TPgtilJmz9S5fihlr+GI7XWgGGG7yq9m71D/bSnp/0dGh3AuM5LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2UJDrtCO/KMHP28Myb2UatMD688qu+BkTN4Xu4rnNyI=;
 b=vltSdcjmFbq0rUaLKKnikCypVVXdxeOL/gfo0MlF/6B1pdhFNeth3i9xKdNZkqyrFemXMmIB9ruQLqIkDzrKwuJktQPUHQgm9ynIlcUtbKZcquAUn/s8fYVNm8p8vZxMOrJXC5MJXs3hhnvWYg/y/v0666l4lgvEw0vNdWNAzmynDYlWUaAj1O9Vaj801jhV/FU+f8oXv8/XKftr9/s3/gW21A1kXZGHI223nyMMCEehJcmAvDLsXq070CKt40ZuBKiFd/HDUQvvPOgBBKGfVdRB4LnJ2/7WP+Cscv0Ewn4g+vxflzfcyXkVORAD6/04RWb0/2wjNhR7hHpupkFgyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2UJDrtCO/KMHP28Myb2UatMD688qu+BkTN4Xu4rnNyI=;
 b=MLt4NHmXGOca2JRVtRombNhneiD9xPtRdFPcDBRj5s2n8dHXiS5787s1j8U254iJZLh8MmF/5zfPOx3ACqFRI45OYlb95RaKxJT5OcPrO8nxNU9dxnRjFauWuNhdNDPle2lhowDu81qixtZ02sPNonukCYVrzLSNMVsv4fVw2Yc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by DS0PR12MB8504.namprd12.prod.outlook.com (2603:10b6:8:155::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 17:55:03 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 17:55:03 +0000
Message-ID: <9d2e5f9f-1713-47a2-a5c3-d6385e691d2a@amd.com>
Date: Mon, 31 Aug 2026 12:55:00 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: Reserve prefetchable window headroom for Resizable
 BARs
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Geramy Loveless <gloveless@jqluv.com>, Bjorn Helgaas
 <bhelgaas@google.com>, alexander.deucher@amd.com,
 amd-gfx@lists.freedesktop.org, nra3088@gmail.com,
 meiling.leung@embeddedllm.com, linux-pci@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>
References: <39e09dd8-f73e-4dc2-ba36-8a9228516d26@jqluv.com>
 <d4c3ea40-d92a-49c4-ab2c-925fc70c4bb9@amd.com>
 <d6c56ff3-0b83-4d2e-7e6f-f3e65a284341@linux.intel.com>
 <bb909250-14e3-4a0f-a017-44731ee0f5a1@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <bb909250-14e3-4a0f-a017-44731ee0f5a1@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0095.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:35e::26) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|DS0PR12MB8504:EE_
X-MS-Office365-Filtering-Correlation-Id: 90e9f5db-3503-4310-930e-08df0788fb98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|10067099003|4143699003|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	QKxZ0i42aGVyeAbM2V4DB3cfSXlJSHH/VdoiDcL3xCkkqIqqyd+NKMQbWCQqP1hlq190BGpL2KOwCkBVDAYfV9934eNMVgaTxvdmeeAXo+pNEj/z6FIFZJWIerLEbLGBznw32J7258C2W8aPYA20mJzRC3XqBmjOh9klV03Xr7AH9znXBZPyBxMcewJKNrlbSHbtogtB9I4vkgZRiTS8SMwrsXEhb0DJWd3AR1XDUzcgn67TCW2YP7GqGKDJ1i8PjWgp0H64vYLUE2hl+3ODqqcd3N6zkDwwWt8fmMzEW5NX53xtGhJvayVk151zy8G6y3fs0DnED5uy4ewQjuVUK8Pg/t9fM5LZcPlPdY3AmYaDPYkvvjjZgSF0/nbcf1jDymTXMq+o15DRMqPROu/Gnz3eiSAsyBllR9KILyHL0hCMBeCuUc40coVqk2z16HM4AR6oqP7MxSR9bK7OSXKg6i95XHqAWfy386zgIlRF+tK4l79WcTknKu++yMpugPG8ZG69rr+h0oy5n7uxfp1GElIlw3DLZQbo2yj0QP2vraksFQDqEm0HX2X2hKyLujVpqE3tirwiGozQWUZSKnIchLobAOBTaYJXBaTtYAD+MMncAo5KPcWhN857Jf3u9h2sFQk4QD4CQTL4hcLppLZucl2+JKAigP5mofqL2fP7Xt8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(10067099003)(4143699003)(11063799006)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RVU4a21aYjcyMFpBY1U4WjNnRUp6djBIWUV3U3J4ZDVaREpxUGIxdU13SkE5?=
 =?utf-8?B?UFBTUk9OMzllRlZEa2duZGlyeEliZWhybUxVV2FEYUZ2N01VWG5ST1VFZVcx?=
 =?utf-8?B?T0tkTUlDMGlhQ1V1ZDhzUnZKaElTOTF2SnhHS05rNjlkUEJCZnpKY0Z4Q1NG?=
 =?utf-8?B?dVpPSjluclRvTHNzR3F2d0FNeWxxcEMyWmpCK0lZUENDSys3S2FFaDN5dHNU?=
 =?utf-8?B?eHEzMTFCQkJyVmV6bkU1Z05zNGE2OFRIdCtWS3B2RVVmZmxsNWlxK0VhYlVT?=
 =?utf-8?B?c0FvRkU1dG1iRHBtYXIzSWJocWM2d3QxamhqZG9zekpldUdmV2E1ZG4xeFRM?=
 =?utf-8?B?bTN2VFFhV1dZaTN6ejUwN0pGcUhKcVk4TmNZTzdnaGd2eUFwZlN5QkQzL2pM?=
 =?utf-8?B?dStoWWJKdWNjclc2a1JRQUhHWmlWLzdSeXU5UVFmcHhNVHh4NHVaMG1mZEE4?=
 =?utf-8?B?S1dGbDdvMjlsd1hsdDM5NG1kYmxhQThtU1NWaDJFdlphK1Y5c1piMzg3d3Yr?=
 =?utf-8?B?bHNaOEx6cUp1cG41aEtXbkpNQXJ1V1h4aVBHWm52YmNyTS9IQ0g0Q21NRG5C?=
 =?utf-8?B?NUxnQnZ5THl4WUVtRThpalo4azdUZ0JhRXNYWXkyRWJUZ3lVV2huSWptUW5y?=
 =?utf-8?B?U2hXN2FyN1hrMGswR3ZVRStkSjJkZjZWeG8zRVh1VVk2ZEJpUFFKNlhjMzMr?=
 =?utf-8?B?OGZhOURqMjRWK3gveFkrbGZwek9BbXIvRitPRHI3NWJ1MHdIQjhzajJQUnhX?=
 =?utf-8?B?S215VCtscmQxVjhjNDl4cFJ5MkJRc3dPRTg2MGJ1bXJBRGVJMmttTkZyWS9i?=
 =?utf-8?B?eVBWZHZCcG9WZ01ULzBiQlBiWFI1TDVaOVFjUGxrRXZjSmg1RjhDN3ExQlRN?=
 =?utf-8?B?ZjNuVGt2YlBTd2JPUnRlcCtOMmdLUkF3MTR5WEFSSEJEeWJXZUkxYVNMZW1m?=
 =?utf-8?B?VHhxR004aW0vOWpEZ1hpamtXcEJQcDdaMFlFU3NkV0N2TkorVzR5TGxqd244?=
 =?utf-8?B?QitINllkMU1uclNKNm9HMUtXZ1lSVkphcXp6Ync2RlQzZjI5YlNtNkR5WllB?=
 =?utf-8?B?SXhUWDNWMUp6SGNma0Q3elFGSFdkMlVoOE1NdFdNT1NhaGdSS3IyT2ZOWmVQ?=
 =?utf-8?B?T3VCWjBrcUlQM3QrWVFIRDAzWi9hWEcyTXE5RmxaaGZZeGthZUZpd3h5R3ls?=
 =?utf-8?B?cjJMaGRHOVhIVVhoMHppZ0h3RHk1Uk1IUE5zY09VTDhpcDQvNStVYTFDL2NC?=
 =?utf-8?B?aXQ2Rk9BZ3dkSWR4Y3VudE1TODNac2E5cmIzT2gvQmtVUWJGeEYwTXQzYWlw?=
 =?utf-8?B?ZmtZaHFIdjNjOVBkSXZ1V1R6dnNRV2RnYkRqQ2VEQVJGK2k4bjlHK1dUdzdC?=
 =?utf-8?B?bTdYayt2SllQTnFDWFF5QW5iU29SakZtS0p3cWZpbW8zbElad29GNVNkWndl?=
 =?utf-8?B?V2JDTmdaTmI4WlBYaFZIYzUwMHAyZ1dad0M4cUtNWjlnUzdyeWh0QndPdXN0?=
 =?utf-8?B?akt5K1NSS09DdW1ZYkR0THhRTGhySXdBL1RtMmFoY3R1YVpSUHY2aUw3dDdJ?=
 =?utf-8?B?aDA2bWFrbzI3elR4QVhoMk05L1YxRlhLdzhGRm16bkE5RUV3V3lpWmNHWkpl?=
 =?utf-8?B?YUNGcEcrQWhyZFVORUdFcXBzbUpjblFoWUF2SWRiRXpaNVoreEVkMCtiOWhC?=
 =?utf-8?B?T1l2VXBxWjhDd1lkQVRVNUVBdkRBRmZ0Z0VXVDJpRXpKMUs3OHJzWnZpbkVi?=
 =?utf-8?B?dnpDZHVhQlc2U2FaK1g2UU5QZkl0UDFoR0N1aXFnUVJPaTlrUlBMZElqOFRE?=
 =?utf-8?B?dWI2SWpKVDFoZTZZTUpySjV2NnF3eVd0cnR6SUh0Q3RsZExZM0dCdU5RTi9x?=
 =?utf-8?B?QTJCK0dvamdMaFVLbU5UVjFWOUZzUmNzc21JVlM4YWdtRXFpRThHdW5JaVp3?=
 =?utf-8?B?cUo2enlZQWV0bjB3MU5OMnFUVTAvdXlob0xmVkJiT2JWaWd3bEtQQTFKM0hh?=
 =?utf-8?B?U283SFRLdEc4ZU9EVHMzcGtscG9yd2FqZE42Q0hGUm0wbW5NSnlvd1pXZFlC?=
 =?utf-8?B?Vk9tS2xmS01tZGhZNCs0NVVMNmsrYnpDc2dKSTljWFJqZ2RINEZXbGdSSkNw?=
 =?utf-8?B?eTMvQ0RDTmJCUEMvTU5EWVdzaXdVc0ZHY0tJU0g5ZEZVY29KcHlRWVdOOHAz?=
 =?utf-8?B?MTJkYTJZWlpoUFRZS0JlTFhwR1I4Wmhaa2pKOUpsaHhIYjNSUE9vbzhpUTZ5?=
 =?utf-8?B?SGpHcGZScUNiVmFZNzhzMHNMMnV6bEZETytlL0ZUaHVqc2p3OEpTb0JZV0s4?=
 =?utf-8?B?NDhJcGRsbTVzT1VIdzd0UUwxSG03NTBndnk3V2lZbmR3S0k4VnRXZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90e9f5db-3503-4310-930e-08df0788fb98
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 17:55:02.9305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q8yudwfyGnER665IoRm6emr45es/5IkQAKf0SPir/S9Jf5wArAqpnOYyi6uN8vhvdcaNSlCGCYMJahxWbwvhZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8504



On 8/31/26 12:52, Christian König wrote:
> 
> 
> On 8/31/26 18:58, Ilpo Järvinen wrote:
>> On Mon, 31 Aug 2026, Christian König wrote:
> ...
>>>> 2. Pack Oversized Windows (BAR Demotion):
>>>> The PCI-to-PCI Bridge spec (r1.2, sec 3.2.5) permits a prefetchable BAR
>>>> to be assigned from the non-prefetchable window. By clearing the PREFETCH
>>>> flag on small control BARs during enumeration, they are placed below 4 GiB.
>>>> The prefetchable window is then cleanly sized to the large BAR alone.
>>>
>>> Interesting hack, shouldn't really matter for AMD GPUs but that is
>>> something more on the heuristic side.
>>>
>>> A perfectly valid trick which is done by BIOS implementations but what
>>> the Linux PCI subsystem still hasn't learned are back to back
>>> allocations, e.g. something like this:
>>>
>>> BAR0 32 GiB of GPU #1
>>> BAR1 2	MiB of GPU #1
>>>
>>> BAR1 2	MiB of GPU #2
>>> BAR0 32 GiB of GPU #2
>>
>> Assuming you're oversimplifying the layout above, this was added by the commit
>> 9036bd0efcb6 ("PCI: Align head space better").
> 
> Oh nice! Yeah we had quite a number of bug reports because of that.
> 
> Usually hot unplugging some PCIe HW and then re-plugging it caused surprises when the BIOS assigned the resources initially and then the Linux kernel on re-plug.
> 
> I need to dig up those bug reports and add a reference to the commit to let people retest.
> 
That's actually "part" of why we have a behavior in thunderbolt.ko that 
we do a USB4 router reset at module load.

It gives you a clean break to let the resources get assigned by the kernel.

The other part is consistency with other OSes.

Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013053.outbound.protection.outlook.com [40.93.196.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8F449B5A3;
	Fri,  2 Oct 2026 13:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790946778; cv=fail; b=dOon9dvGl/OS0IFaWCWFw636XxBsRPrucGGiVce5r5x73eCe+R2QZK/Y7Lhe3RgPR+4C90yM2Eb5oLrC2o5aowVhu8mtAyO41JtXJq74wDzPzE/EfWOyCtVbw/uyDJAN6M2T78CBMCjIMwsgu7K4D5BWA9Fv7AQUGfl1jWwC93Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790946778; c=relaxed/simple;
	bh=egCLb1maIpwWxQ7QNbWBEqgbzweueMnh5I3B0wRaYDc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XifOGu4YhteEpkwT8xn7qtEcwV/q7zRg1yTFSOB3COyCjgBK42fcp94YF4CsLA0TDYYDPOTyR+G11yHo296sd5GfUOKoyi8C+IxmHf4BErwJi37WO2GO2zHshZbpuUPq5KyktkioLsst7CupwfJyOrQmXYr1Zzsq+ocWvzzREII=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=n902WWvw; arc=fail smtp.client-ip=40.93.196.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="n902WWvw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qKi7v5ILbaji/x9QPrqzWJaVbN7afhjMa8Ht3K7sx767BlNdCXwGBAPUqSaBxUhZae1bBhE/dJl46hBnfFRuvFQ9C+6kHbpR1k+AShQm+qbVCmXDS+i/F1+m51SSTSAA53nx1D99jvF3BbQZyKjH7o822R/P+zmgNaVtwUGpO76baS5wwmEiuaHhzKB/s/CRPqWPnb8BtrKTyVM+cXCXBBn+qD3UTAvKpIqn8YWfI9REjRFc3iT4FCVA5NvgEtWxClBhDIdFKm0/NuRJkA/WsEa/PGnxCOq6I4Stb9vXbvE/dAsogjTSLPIVSCSSG/C1P5E2dKCJ1MOQwbNIfXCCEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4wwnGBmFA1navNLN9f9mHqYzkEQt26wo4hDc561/tmg=;
 b=t2wHSsn8IBctSwW315i8mpCMEUZ3wDafL9auNpVbSd97jE5nQQsNVfFXQN/fHsfWzwL7QhCQGdfo6Oa5PjmZWMLUV4a9DPOHllhWS97hdC18Ydp8QJMfpCVx1tmoZdhsrfwQ+bRCRVARaH4p7gLDPh+9Yq8HvhKs6uqI9FIgpUE2f35G3umvzM+i1WVA2BDxrAnoBYhQvk+lLSelChnKUPdIPw8Km9NZmSzHRYCCnNMGsgGQj+ppP5z/cFbr5j9Rcdwab/8RMfIlSf9lSMEWttdNP/evPJrMY7gpeV7cGj/pyKWeUxCW7F7DQ6KacuLQv0M7WGNw3dfvnJYkscCquw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4wwnGBmFA1navNLN9f9mHqYzkEQt26wo4hDc561/tmg=;
 b=n902WWvwiJ94pJ+VDy4ZuVDGwYjlr9EDcSM7eWCOc/BLw012hF+/2+1YYn2ed0ENzvJvqRQWpmdCc+JqFh3oobyiiC/iFUT0VP+FjbrflxHTX1vrWEVE+vazjX1SuRy7Lu2677Gxx+r2FvPVCkt2ImLWUeiFZbs3NGp1VV96rgU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by SN7PR12MB6670.namprd12.prod.outlook.com (2603:10b6:806:26e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Fri, 2 Oct
 2026 13:12:49 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0472.016; Fri, 2 Oct 2026
 13:12:48 +0000
Message-ID: <ed87f3e0-3a50-4203-92f3-51bc4f20a7de@amd.com>
Date: Fri, 2 Oct 2026 08:12:46 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/7] PCI/quirks: Avoid certain address on Genoa systems
Content-Language: en-US
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Maciej Grochowski <Maciej.Grochowski@sony.com>,
 Nikolas Joshua Britton <nbritton@exabit.io>,
 Geramy Loveless <gloveless@jqluv.com>, Eric Auger <eauger@redhat.com>,
 Alexey Fomenko <alexey.fomenko@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Rob Herring
 <robh@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>
Cc: Bradley Morgan <brads@mainlining.org>
References: <20261002113319.6652-1-ilpo.jarvinen@linux.intel.com>
 <20261002113319.6652-8-ilpo.jarvinen@linux.intel.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20261002113319.6652-8-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0145.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c2::29) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|SN7PR12MB6670:EE_
X-MS-Office365-Filtering-Correlation-Id: 28d1f3e4-5745-46da-df88-08df2086db4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|23010399003|1800799024|921020|4143699003|18002099003|22082099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	Wy7akPBcDynfFrZTEOWYMXz7o6D4u6kPk9kjl9v5lC4nSJfotmrxCrXm8oqj7gf0PrcakFuV1IjZ1ypOJpnaV4Kog+Hn5JirtbxX4gq10BNV3QLjQsrKe89KF7Tl24vtpmSxO4Tz7ZbUOXnV4G9J59sC+x2qzD0xwL3lsprYJ6ZkeBAySTLOZY5LDVqu/fg2wjALSyRxmqt3WuutEOCqIs7x6iqO1a+mgNoe0cTjxuKUx0tI0ZVX6Qu7eXs4icwzHThNSArSud9X6sXmrex2+sOw07R9OMRJL0czbPReCdtE5a/n3+ufFXUDvETjMwcbkAldMTualoLa+ZErc/NsldtwfzTPpNpW6vp1GqnIm4yWB6P6lypQ3OvCMQlDDv6vJaddHQsZ0Wyv9o1coXzHsRVxDj46MX/7gsU1ZIgO2OH7u3ircpznh8uA0jnSYfspXh94U0eb4zMpv3Qep4c/g1KVePS7b9KwaC5mnTZUVOaiDCfYtn3VGUWZ7B38zoWMx9j6bBrlZF1pcPdxo6UvZUuwOkyxcHwS27sTofuRhg6HFsrzHsSqUyVAPMm5Ghsx2GGsSg4fM1mVKRsha558qdP9I7L/ok2iOPr12Jv2OUUQ4Ik3uNzwdB6ZoHONXm/azUYeNCTNcNDjYgx2Y8H7GVG23HaNGrdGBLYNprFZI2g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(23010399003)(1800799024)(921020)(4143699003)(18002099003)(22082099003)(10067099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YnhuUUUrZzRKaDcvQ2s4KzBYZUtVM2gvSzJrVlkwYmZXL25ZLzJ6VnFKeVF2?=
 =?utf-8?B?ZnJTTXFXUWxvdFp2WE91elZSeSs3L2p5TnRzK1kvQjRCeE5pbERvNDlTNlhF?=
 =?utf-8?B?RE9rTHpnVktzRnovZ2RzdkhOMEtSTklkWSs3U0NrakFqNU82WXlLNFBNYzRx?=
 =?utf-8?B?aWZzcWFscVprcW90eVRTUTMrTlRQQXRwMStxckMrZ2JPU0V5UlVUNitQL3Zx?=
 =?utf-8?B?eVFGeTF4czIzMVZDRXZEcVk0UEZIWVBqRW4vOHA1bUxtUHZLNTBINTJGTnM5?=
 =?utf-8?B?cUszbkMwSnRvK0xQOHVQSHMvbGZ3V1lIV2pxbDA1Q2ZXUkxMcW10dXdrY2JD?=
 =?utf-8?B?aUpEZncvUmtWOW9BN0poQW94L2p5V01Ia0dOOEduaUpQeFpZVmlZMVM3OTFQ?=
 =?utf-8?B?R1g1Nmpzd3N6VUZvRDVqaEZoRDdheEhSbmxDYk43TWdBMVhURkNjQ2NQb1VL?=
 =?utf-8?B?d1hxZUhUcWlIZGt0WnJFNDlIYVd5WFZ2SzhISmJka2FPU0ppR1RwcDNINDR2?=
 =?utf-8?B?TGNFbk5MU0xNaldyeERVUDd2OXZSN0dyemhCMk9JbXIzKzhib0JVVUFtZ1lL?=
 =?utf-8?B?RlNxRCszSEt1WFhEZk9DelFONjdQYzJEVlpQSTJUbWd1QVRNSHI2NDYwcEJI?=
 =?utf-8?B?TDEzME1ra3c1MUgvQVFVVHNyYjBJYTJDZUxwN1BpR2lnM3NuSHplbnl2UXUz?=
 =?utf-8?B?TFloakFTNEtzT0lJTVIwcTM0eXhoNERVOXl3aDJmYndRbFdkQlBFbWZmNmdO?=
 =?utf-8?B?MkxWQitFdVNoV0FudjJhVlJnSDQwWnpIYmhxN1lGZWlEVXdHaFp6R2xiaVhZ?=
 =?utf-8?B?bnhaRG4veE1QZi9adnZOZ0xlaGYzaE9Pb3JxNjRNeU5yN3EyV05WbDc4aElO?=
 =?utf-8?B?eFVXcDJkS1NMcmtHcVNyUGdGMkNBTE9Fb1B1ZWNxbUJpcXFIeEhZZjJyR1Fw?=
 =?utf-8?B?bWJ5NTY1Y2N4SmFZeWJKZDhLbWpHdXQ2bGU1b1dWMWlqOXdkY0NWNnpieml0?=
 =?utf-8?B?U1Y1YS9HVFRRUTlrTjU4T29MdW0vdkhIUG5ZZ2pYU3B5UHdrK3NGUDBHNEJ0?=
 =?utf-8?B?NVROR1loTlMySHJ4bU1laXFSdjZJMUVDaVlwdmRwNGdVdDI4REhsdDBTWkZr?=
 =?utf-8?B?b2ZuVFhjRnIrdXYrYzA4RnpLczY0UWtZREs0dmE4NGNCbjhyazBLS3B4dnoz?=
 =?utf-8?B?dlkyMnFWeXE1NkkwQjNsTE90YjROYUNhQjdaWTJXZncvYjZBdG1VNWQ1SC9k?=
 =?utf-8?B?aUpMdklRbnh1OGFGQTdwVDRxU0lpRGxYTXk0ZkJrVDM4ZVVUYU93a2s3VWY0?=
 =?utf-8?B?Wm94YjZsN0I4eXZHcWhFR3JpQUswNnMxMS9mOWJnSjloS1NYcFdLTk9iWmZu?=
 =?utf-8?B?c21xLy9YN1VQVzMzOXgwSDBmeWpPK04rT0JocFVxalhsY0U1c3ZNYUgzaXpy?=
 =?utf-8?B?cm9PWGVoRDA3dFF4Vjc4bDVIblBxT2FWeDI4SndYL1M1ampjMUltWDVqR0Rw?=
 =?utf-8?B?UFhHelRHK0hOdVJDS1NFcWtXT3QvTzlZSk03MFg2N3RQVDJtMTRzSzcwSmta?=
 =?utf-8?B?V2w5cm1aT3ZjR2w2UHFnSjNLbVliREZPb05TclVaOGRYei9IbnJOelJkc2hP?=
 =?utf-8?B?b1VJbEhPaHF5VlZ4cEh0Z1dnQmhrckpCdE40cDY5R01relgxNmhsRmFHVkVj?=
 =?utf-8?B?MHNCcDJIcyt1MzdGUlYrR3pvZVZ3Vm1zUm0xWU5hNlExNDE3VzFvcFQ3cGdK?=
 =?utf-8?B?eU9YWDRsMzB3UTRHbWN5T2E1SWoyTVAyVTJ4TnhZYkpHaUJhNnk0UWhhZW1y?=
 =?utf-8?B?SWUwbTJpUjBsMUVsckp1T2ltWitzTkxSSW1JZXVFaUxzV0FLNzdBUUt2b0Qw?=
 =?utf-8?B?K2JCUDFtdmNROTQxdUtreU5DNGlwQldjelF3S1QyZE4vdXFsLzVqMnNJaDJZ?=
 =?utf-8?B?OUFWbk05cGlGUXhJLzFpcnh5Q2ZZY21FeDlFb1dPcUlDS0ozTXBSYWhDWXhQ?=
 =?utf-8?B?WlNocVJOaG9odnhIam5aZXpVVGVjdTluWXZkZGFsZXFyQ2ZkaFpRbmNCVFY1?=
 =?utf-8?B?NGF5YnAvVG9RNGJTMTBLOFRIVjNqK0dEWlJXYUZRRHdsNTkwdkJpWkZXRVFS?=
 =?utf-8?B?dUVZa1JMYjViclhhWlp5ZjU3RlByREk4Tm9Sc1VtYVFZWEg5Rm9OWE0ydkpJ?=
 =?utf-8?B?VW53Zjk1QldVOHY5VXFRVGxyaVY3RzlmaTkvdlhqaWlBenBwY2o5T0d2VlZi?=
 =?utf-8?B?elBtT3l6K1VvTWs1VHBLUm5IVW1KUE9uNWlQOTNNUDFyY3lZR1dKY20zWTU1?=
 =?utf-8?B?Zm1OM0htRGxNTXV3NWZVLzBQcFhXeXpleHhlYStIelVJcC90aHBCdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28d1f3e4-5745-46da-df88-08df2086db4d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 13:12:48.8644
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KoNnmS56rovWwmvD8rpLUT3nZGmmQS8lg66SOh37bqiTtiDdLuEN7H3HewZP7Oux3GkY3UPmtoAUkubOnA8T/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6670

+Boris

Please include him on the next version too.

On 10/2/26 06:33, Ilpo Järvinen wrote:
> While testing the resource placement changes, tests hit a case where
> igb fails to probe when BAR 0 is placed at 0x9c000000:
> 
>     90000000-9cffffff : PCI Bus 0000:a0
>    -  90000000-902fffff : PCI Bus 0000:a1
>    -    90000000-900fffff : 0000:a1:00.0
>    -      90000000-900fffff : igb
>    -    90100000-901fffff : 0000:a1:00.0
>    -    90200000-90203fff : 0000:a1:00.0
>    -      90200000-90203fff : igb
>    +  9be00000-9c0fffff : PCI Bus 0000:a1
>    +    9be00000-9befffff : 0000:a1:00.0
>    +    9bf00000-9bf03fff : 0000:a1:00.0
>    +    9c000000-9c0fffff : 0000:a1:00.0
>       9c100000-9c17ffff : amd_iommu
>       9c180000-9c1803ff : IOAPIC 8
> 
>    -       Region 0: Memory at 90000000 (32-bit, non-prefetchable) [size=1M]
>    -       Region 3: Memory at 90200000 (32-bit, non-prefetchable) [size=16K]
>    -       Expansion ROM at 90100000 [disabled] [size=1M]
>    +       Region 0: Memory at 9c000000 (32-bit, non-prefetchable) [size=1M]
>    +       Region 3: Memory at 9bf00000 (32-bit, non-prefetchable) [size=16K]
>    +       Expansion ROM at 9be00000 [disabled] [size=1M]
> 
> igb 0000:a1:00.0 0000:a1:00.0 (uninitialized): PCIe link lost
> ------------[ cut here ]------------
> igb: Failed to read reg 0x18!
> WARNING: drivers/net/ethernet/intel/igb/igb_main.c:724 at igb_rd32.cold+0x3c/0x4f [igb], CPU#32: kworker/32:1/706
> ...
>   igb_get_invariants_82575+0xff/0xf00 [igb]
>   igb_probe+0x3c8/0x1190 [igb]
>   local_pci_probe+0x3b/0x80
> 
> It turns out there is a 64kB iomem black hole at 9c000000 that returns
> ~0 and this is where igb's BAR 0 resides. If another BAR of the same
> card is placed into that address, it is similarly black holed.
> 
> Mark the problematic 64kB range reserved using a quirk bound to the
> bridge found in the problematic system.
> 
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=222074
> Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
> 
> Mario suggested the quirk to be based on the bridge instead of the
> endpoint device which certainly looks better and cleaner than the
> approach used in v1.
> 
> The current plan is to try a different card in the same slot but it is
> a bit hard for me to predictable on what timescale that can be done.
> 

FWIW - I do think this approach is pragmatic for the given situation.

> ---
>   drivers/pci/quirks.c | 35 +++++++++++++++++++++++++++++++++++

I think a better location will be arch/x86/pci/fixup.c as these quirks 
will only matter for x86.

>   1 file changed, 35 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index de9bbccda21f..5483b47d8d54 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -6288,6 +6288,41 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1536, rom_bar_overlap_defect);
>   DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1537, rom_bar_overlap_defect);
>   DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1538, rom_bar_overlap_defect);
>   
> +/*
> + * TODO: Remove when/if root cause is found.
> + *
> + * Genoa appears to have a 64kB iomem black hole starting at 0x9c000000
> + * address for which all reads return ~0 blocking an overlapping BAR from
> + * working.
> + *
> + * Work around the problem by reserving the space prior to making any iomem
> + * allocations that could overlap with the black hole.
> + */
> +static struct resource black_hole_res = DEFINE_RES_MEM_NAMED(0x9c000000, SZ_64K,
> +							     "reserved");

I'd give it more detail for anyone looking at reservations to get a hint 
back to this function/commit.  Maybe "genoa_black_hole"?

> +
> +static void genoa_iomem_black_hole(struct pci_dev *dev)
> +{
> +	struct resource *r;
> +
> +	pci_bus_for_each_resource(dev->bus, r) {
> +		if (!r || !r->flags || !resource_assigned(r))
> +			continue;
> +
> +		if (!__resource_contains_unbound(r, &black_hole_res))
> +			continue;
> +
> +		if (resource_assigned(&black_hole_res))
> +			pci_dbg(dev, "iomem black hole workaround already applied\n");
> +		else if (!insert_resource(r, &black_hole_res))
> +			pci_info(dev, "iomem black hole workaround enabled\n");
> +		else
> +			pci_dbg(dev, "iomem black hole workaround add failed\n");
> +		return;
> +	}
> +}
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD, 0x14ab, genoa_iomem_black_hole);
> +
>   #ifdef CONFIG_PCIEASPM
>   /*
>    * Several Intel DG2 graphics devices advertise that they can only tolerate


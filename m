Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792439236;
	b=Y4dBLIYsVt67ioaDYLIdaFwSSikNqTn/5EwTUXjVxo8y4AmpL3Sad71heOPAJAntYXq7
	 2xqQoJZrx2qGMPFFlL62OT1h7i7TkgfeEdK+re6fVhmJgiBMStgYjuvSB3xx6naHo+JJX
	 PY7dbsVROnaUq9reLkD2ENloy0W1XbZGBNrXsarxOjqZNUG7Masm/q8X7OmWkQAx8b2bN
	 UIWBUNQQphT2OFVDLXsuhINkSj9PAewJnOy/3IBqfPKCcmEq8j2eUcQvY7nzo2L1qbi5y
	 GqVA2safzcL/ahzzrVTMRUP7HY7Aa68rEVO6WbdNtXjKQ+Xk2Qu8NFpi1e/ceRskeVQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792439236;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:Content-Language:To:Cc:References:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=bcOY64N3wp0JcUsL5U4HfMMETQV/8+AKms1rjFxObOQ=;
	b=QSYutsIoNhQSXgqgrVV0JTjGkmtFF6ogpqVvAyODwXuSf18qESsm4n5DM39bXv/Gzk0W
	 bg/5ayG9QXdVWkq2fiEZQDHlwb9S4HUu8gs7PCxT/tjkrRGdglgIc0wh1CZkpWSUDULSX
	 ZF4PYFNM7ujflDiPm0MgZThlr68fWGOJS4xs5SxuMaKK1+gZJYUWbWnoKO7smayF5EWct
	 XyD8p7tEDtSJa86cFPRFy2CrNZd6LAp37KXgLcmeSxCS6vLFg7qjf8VjaiAxzPqYXlEt9
	 C0bTaFCsMYWhuYbPUarZ59onKgb4BAmqdmXZBrQV3LgTT9qJmKniawA3QyFatWUgAGg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=FWNPNtG9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.49
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011049.outbound.protection.outlook.com [40.93.194.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1DB606A31A
	for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2026 19:47:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E1DB606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=FWNPNtG9
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PMYqq6Vn7HECFGsv2c71I/SZbcE4VkPBiwIfRNP1eB3aCAwXQBgN/bjVUsOZIdqo9kPVM2g8BlqmnIwODZsUQQc5w1iNFjrrMRSLJCYY4fDQ4OYXdtREQmkR1WKTZyOcs8HhJCxDDetctvir7X8nmzxhj3PNh/b17NcwTW98IF6bDu+x0V+pp/p1iN5XdRke3OonMo3Fw3wNZHqCbncFBUIXy0Ef/y4SciVHY7hGF6+CT86gT7hwFSSf/GStdqS9GbQxbFdM9m/X44h2RSNBFlu4lHpZtjbumrpg20BwtXw+Uuq7VNVxguCS+LXXvmcl0AmpG0c7B9mk8BCchuEy2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bcOY64N3wp0JcUsL5U4HfMMETQV/8+AKms1rjFxObOQ=;
 b=ivMB1KCFBUGCLZbKDnA64idbEnxwPzTNVZqJGo+oFW8LunVKQT86LOJ2LFFFKH8rnktQ0CtZZJR5BISqr5eztLctwbnB8GEQ0OygJuTjtpQj4wDozw6KOHjYUGtBr1UJ/v5MtMeMJnBRFrQsictQWENX2AsatKqzSDD2Z0IDQu7RZrr0vA/45++/yoDOLAvGrT0kSIaLPYo7I8QKGTw/gCTz8YkHBIE9TFrpqve18yTAUaDNG/CmtEV2PlF0o7zmN3ayHfR65ob4SRKX6w6TZFuIlCwrVh5BFDlATKllBLdH1kDFPyddv1U/NGCWhdoQHHaxECS2dBHI7ptLjE33SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bcOY64N3wp0JcUsL5U4HfMMETQV/8+AKms1rjFxObOQ=;
 b=FWNPNtG9BPoY+jFz9WzYiEeIuZdShnBeM8EY95NeYqIqa4oOpswoYqH/xoaBpx1uznHMrEZ4Sy2EFKUQr+5YBR0uYHPGKTuGydgcJlKc4DzD6KsMF4cXmN7NMkUgyRTHBrejc3i7UEmYPiqxJFqY7iuSS1+IPrTRkIxs4E1G22M=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by DS0PR12MB8785.namprd12.prod.outlook.com (2603:10b6:8:14c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 19:47:11 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 19:47:10 +0000
Message-ID: <a8838ac4-ee24-486a-ab57-19d7c6a8901c@amd.com>
Date: Mon, 19 Oct 2026 14:47:08 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] Revert "drm/amdgpu: Fix VFCT bus number matching with
 soft filter"
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Bjorn Helgaas <helgaas@kernel.org>
Cc: Oz Tiram <oz@shift-computing.de>,
 "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>
References: <20261019194106.2796150-1-alexander.deucher@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20261019194106.2796150-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7P222CA0008.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:124::12) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|DS0PR12MB8785:EE_
X-MS-Office365-Filtering-Correlation-Id: cdf786e7-65f4-42f5-73a2-08df2e19c3ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|18002099003|22082099003|10067099003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	SQ3VDsoA5SVsFHWGMfwTXI6CHudHhDC7o7tHxxJ6B8Qh0irG4YyoIY35LdHxvZYw3OxtR8/O+y+HynL5MJLK96JTMDs6UHbbvBbi/xhgio4D7kPp6Vq4S5uci/6gUiJdFnnP+moZ+uQLBRsBdTnBpqap0dN/0k2pel0HNYkuVSQxBImEESHbNonalsdvcoAX8ki8ygUib3+LI+KT/eC9BRBqrieQYKq08bFJb4piN6Sb9GLWxXxRbWeroSqZbkjfZYXj0S5rdzz/Ts/IG1+r0NPE13idQ1JvSk4/tOpf5wtZnlQ47E6n9N9ia3onCXf45B7S51gGvLG3l3w5wb9Pqjue52MOhQQZxgLR1PAKhIxVniWDHuyQ2/0sqUvRiFcloa/pjG5m7+Gymv0VhDScLadrA+/rtsou9QqezYEszmDi9X+lhdef3S1lhRpXQF6lwQXEKe3BTlPn4AUM1oXDBXaCSNePyz06nFuSP2IZv2L9yuR1ypLeYnfAgI1E0gHdj+ic7l9LtUzbzdt6S0+F03IadqaB0JH5Q++8k/76yyIa/e2GG2O1TZsGzi378GS5HeyEjlq8FdWPrqry7dh+EybXozgvxG2Ohcjl3KWxFBCqK+ZCX8ciuhd7I3uHu2tU
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(18002099003)(22082099003)(10067099003)(261009223027099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Mnl6ajVLQ1VvOEQzNE9QMk9RYThzdlp6VXVkZjU0dXBHWXpGdHNONjJmdVlt?=
 =?utf-8?B?OThrLytZS1JmbGVnU1hmN1JsT1BCZFFyMzQ0N2Rjak04dXZNZ3BkeGNpVE02?=
 =?utf-8?B?eGwvRnhGVnQ5OEp1VkVidVpSR0psNmNqWENVRDF6MjZTcWttQUVTUDhlaVI5?=
 =?utf-8?B?bzZYN0g1NXdrczB0RnJ4RVVDRzVyazFGeXh1S0VOVlU5Ky9kOXdRWmdibjhK?=
 =?utf-8?B?eFVIdGk4V2h5M3ZqaU5aZlkrMm1weDBoL0RQTDBlTWo2RnZMK1lZUEZxdm5G?=
 =?utf-8?B?MFpPbExremhGRFdEbk5vYnNMb01WQjA0Ry9ZSjl4eFR6UllFMzljSVkzc0FX?=
 =?utf-8?B?dGcxZlMwQVE5MUNzUG8xamhBbldPSDZBZzFVbTZiTHFYbzlQdHMrYXVCMWdB?=
 =?utf-8?B?anVpS252d1lEUDBtR25IdGNsRlF2djV0dk1WQmx0Uk9tZWdFTXNGeVFuUHdF?=
 =?utf-8?B?NUtRL1ZQbm9RMGlyclNDVGZrRWZzUnkvQ2JlZ2xhTWhXYTJRc2VORkxLWFBG?=
 =?utf-8?B?d1RxOFBkVkdMWE41L3R0ZlNoRmw2czFzZVdEZXQ4SzY5ZjNTNUVDNkxXWDdK?=
 =?utf-8?B?K3NLbTc2QjNmTUtHNzRyQVVwOXlQRnBpSElTUmM3MTQ0ZDRISjVaYVF1OW9Z?=
 =?utf-8?B?RStFUTBmVTZJc3hXTHMvOEl6NmxjaW16WElnb1VxcnlpZHpOY08zSHZXZzhV?=
 =?utf-8?B?WUphZklCUDJNK0VoV1JuRWlDdE9rUWNTS05temhCRFdWdVRUM0xVZE14emxB?=
 =?utf-8?B?VTFvLzBpWUZjOERrLzFTY2Jvb0JuaXFjK0pvSFJYZ1QxSXdhaFdobU13Skdl?=
 =?utf-8?B?RnZQOUs1K2lYV04xVUF3Y0R6RFhiWHdLRUZlVnhGT3BtQnhXeFBaelg3akZs?=
 =?utf-8?B?bkVyOFRBTFhqMjN1dEF1T0d3SU16V3JIbjJYVW1va0dpeDdKSmZpdVpTUzBH?=
 =?utf-8?B?eGV0WU1LVHBQYTZOMjNCSlFMUjVxUVB1MUhHVlVJMUtXMUF1K0k5Q3dLNHZp?=
 =?utf-8?B?NHJMNm1ROXA5N05TV0MwVDk2SytMci96RktWSlpYUXBPSnFETFArVkMzSGFR?=
 =?utf-8?B?dldoeWo4alRGcHExWk1JWWhMUnFselBSTlBjWFhpTk1zbVV5UFB5S0pCL0Z0?=
 =?utf-8?B?THQrQ3ZoY0VScVZJeDhaM2tWWlBTSlJxSnpsWFAwRGtIcmF6RlZJRy8zeHlP?=
 =?utf-8?B?cXRpT1NUeVBtYnZRUXF4RytFb1pxY3R6bW02dW45eHR1SklkcTZIWExUSXpL?=
 =?utf-8?B?UlhIR2VxVmRrQWFtMGdsWWNUN2d4aXJOdmh2VC9VZlAzWEh3aE9YeG1yVkNt?=
 =?utf-8?B?UG8xWWc4bE9YankzRjQ1QXQwdEk0S2hYOEtaMStMb1IvcEdZL3BDbHVuVW5L?=
 =?utf-8?B?Y1ZKTFRkK2RGQ3lSai9rVHFHdlpzdVZLc2NDWW05alZtVHRpbkRQbGQ5OUI5?=
 =?utf-8?B?YlZGY0Jjdjh4UkVIam5ibmtrUnVRN0dMcFE1b2trWEJrK1RuSCtXM0phbFNG?=
 =?utf-8?B?VE9QWXRqN0JHcTVSTVlScVdMSVkrcUNjQ1JPeG12dFZGam9FUzFqazQxUUdY?=
 =?utf-8?B?TUl2SWRuSGFFTU1RU1hqUlhaODV3VU1rZkpSWTRESXZMZzVlNmJ4bHFSWVVq?=
 =?utf-8?B?UEc5dndmUkl3ajhuRnB5OVB6aVdKcWJmU0hjK0QrRGRWYkhVajNPRUhKZ2hZ?=
 =?utf-8?B?QmlNRzRnMWV6RVExaVVoTWlidVoxcWlGUlBYY1lmT1pyRWRqWGxZTTB4MlBD?=
 =?utf-8?B?RG0vUVpISVdkOVBIekFYdVpjVW5UWjhabTZlVU5GYkxEVlNyYmIwYi9WMnlT?=
 =?utf-8?B?UEU3ZU1xdGdSa3RuNFdBZGEyK0F0R09HSzIyT081eVd0QkxRbFRxRDZWQlR6?=
 =?utf-8?B?K1dlVy9oOGZ0WDBUN2NEb2xZVFI2d3RRS3lIM3ZPa01Ra3BaVUZLVTRuY3hZ?=
 =?utf-8?B?Tm9HWTQ4Y3pnS1ZhT0REaDZRM1ZrQnNWWmFBNzllbVFhSXc4RFdoSGFwcHVK?=
 =?utf-8?B?eE1Lbm5oZkRrSm43cndQVDJyTTdVelA1cllZVlYrYzg3OUhaU0oxQ2QvWCs1?=
 =?utf-8?B?MEVUaDJ2ZmVmUG5LdWNmWXU0MGtoendBTDFpRXdudU1mQnFSKzBscFVJQkw4?=
 =?utf-8?B?VmljTGRValcxUFRBU1RBTkF6MHZaTzdGYkRNbGVyN2MvMlFlWGVMY3VzVUdw?=
 =?utf-8?B?WHB4Wi82bVRRaTRlVlFrZ3ZjN1VSakhTRm9GNkhXdHFRdzUzRTQxZEZUQ2ht?=
 =?utf-8?B?Ry9ldjdEMFB5Y2VwcmR4MkgzN3pUcDQzQzh6L1N3Umd5YVl3TTlpcVUveDg3?=
 =?utf-8?Q?0UjLk4fGiAd8IL/BF3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdf786e7-65f4-42f5-73a2-08df2e19c3ec
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 19:47:10.7983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7xc8GF0w/1ziWXmmHesWlgKYWWHevwbGJqpev6h8uhA2BV8ox4bLm4VFGUmo8wdG6wDTq2GiUMnZwnJl0NvsDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8785

+Bjorn
+linux-pci

On 10/19/26 14:41, Alex Deucher wrote:
> This reverts commit 11c141672045ffc0187aa604f2c0f597bc334fb2.
> 
> This was added to work around systems where the user specified
> pci=realloc on the kernel command line.  The firmware specifies the
> BDF to match, but those may not be the same with pci=realloc. This
> causes mismatches when there are multiple cards of the same type in
> the system and failure of the cards to initialize. pci=realloc is
> not the most common case so let's revert for now to fix the regression.
> We probably need to store the original BDF in the PCI subsystem so
> we can use it match later if the BDF has changed.  This can be properly
> reinstated once we have a general solution.
> 
> Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/5762
> Cc: Mario Limonciello <mario.limonciello@amd.com>
> Cc: Oz Tiram <oz@shift-computing.de>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---

I hate to trade one regression for another; but arguably pci=realloc is 
the less common than the case of two identical GPUs.

Bjorn,

You open to storing the original BDF in the device somewhere and letting 
drivers access it?

That's what I suggested here in response to the other way (let driver 
detect pci=realloc).

https://lore.kernel.org/linux-pci/4284d6d4-244d-4d49-bbdb-f1bda89fc1e8@amd.com/
>   drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c | 45 +++---------------------
>   1 file changed, 5 insertions(+), 40 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> index f9315e0472fe9..6bbca70a4e2eb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> @@ -428,45 +428,6 @@ static bool amdgpu_read_disabled_bios(struct amdgpu_device *adev)
>   }
>   
>   #ifdef CONFIG_ACPI
> -/**
> - * amdgpu_acpi_vfct_match() - Check if a VFCT entry matches the device
> - * @adev: AMDGPU device
> - * @vhdr: VFCT image header to check
> - *
> - * VFCT entries contain the PCI bus number as recorded during BIOS POST.
> - * On systems where the kernel renumbers PCI buses (e.g. pci=realloc or
> - * resource conflicts), the runtime bus number may differ from the POST
> - * value.  Match by device identity (vendor + device + function) and use
> - * the bus number as a preference: exact bus match is preferred, but when
> - * the bus numbers disagree we accept the entry if the device identity
> - * matches.
> - *
> - * Returns: 0 on match, -ENODEV on no match
> - */
> -static int amdgpu_acpi_vfct_match(struct amdgpu_device *adev,
> -				  VFCT_IMAGE_HEADER *vhdr)
> -{
> -	/* Vendor and device IDs must always match */
> -	if (vhdr->VendorID != adev->pdev->vendor ||
> -	    vhdr->DeviceID != adev->pdev->device)
> -		return -ENODEV;
> -
> -	if (vhdr->PCIDevice != PCI_SLOT(adev->pdev->devfn) ||
> -	    vhdr->PCIFunction != PCI_FUNC(adev->pdev->devfn))
> -		return -ENODEV;
> -
> -	/* Exact bus number match - preferred */
> -	if (vhdr->PCIBus == adev->pdev->bus->number)
> -		return 0;
> -
> -	/* Bus mismatch but device identity matches (PCI renumbering case) */
> -	dev_notice(adev->dev,
> -		   "VFCT bus number mismatch: table %u != runtime %u, matching by device identity (vendor 0x%04x device 0x%04x)\n",
> -		   vhdr->PCIBus, adev->pdev->bus->number,
> -		   adev->pdev->vendor, adev->pdev->device);
> -	return 0;
> -}
> -
>   static bool amdgpu_acpi_vfct_bios(struct amdgpu_device *adev)
>   {
>   	struct acpi_table_header *hdr;
> @@ -503,7 +464,11 @@ static bool amdgpu_acpi_vfct_bios(struct amdgpu_device *adev)
>   		}
>   
>   		if (vhdr->ImageLength &&
> -		    !amdgpu_acpi_vfct_match(adev, vhdr)) {
> +		    vhdr->PCIBus == adev->pdev->bus->number &&
> +		    vhdr->PCIDevice == PCI_SLOT(adev->pdev->devfn) &&
> +		    vhdr->PCIFunction == PCI_FUNC(adev->pdev->devfn) &&
> +		    vhdr->VendorID == adev->pdev->vendor &&
> +		    vhdr->DeviceID == adev->pdev->device) {
>   			adev->bios = kmemdup(&vbios->VbiosContent,
>   					     vhdr->ImageLength,
>   					     GFP_KERNEL);


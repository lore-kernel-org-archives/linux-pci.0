Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021078.outbound.protection.outlook.com [40.107.74.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEB41E98FF;
	Mon, 11 May 2026 06:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778479801; cv=fail; b=G+rvjlB/wgSMRWrinsSb9/pecb5DsJFY2yaIUZnwDviYxG6r6oEgDJLOWvwjHiqyf5VmfBw2XdE7ll1EdNtgLOtCVdlDTYLz4KiqWhMPT0uCi/idTkW1vj3f+3WR0wbImGzxnBWAtnPyTsqy+IcTo7JQUN5iJyO+e5rakkW9q9g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778479801; c=relaxed/simple;
	bh=ZHEXPHE7Sj4iQbA+MqGqDdFWyDj6d6aTlkiULls5d04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DFp+AW8bugdtdKnnxFyJYIdV6Y3L1IXuLGiHOufgxc7Q9isoCmyOq5rJjHzcOfnBv9gNuUwWDCN81aa/Ch1mAHH+bQP6eIU5N98783AfYSY8WsVKfPmG60/he3TXXamMOJbwOTF2+Cz6Of9bpAvvTvO9g76YEV/5/6MTe6XaSDc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=J3opJHpU; arc=fail smtp.client-ip=40.107.74.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="J3opJHpU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m9tv6SK907tOb1VuRto+0cYn7rtrKaqxpY4gXhiJvz2bEmaRFpo4qgnJ18ZuO7AFDiQF93q5ZvKzX37jWxk9o9sOgFN4Th2qoE3YafQzTYd/6w9pBCqXvyNaT8MuZGbJljcKJg3E5LDrEY5tPZEOhjDeWYqayBpd1+bs5EqMzIIShNTjDP2w5nFgTh9wFvSvIqAWVdGpLnW0hj37L1OZ2rwqv7qJ4vvpSpUC4JGstYKPgoaeegBT+FlqmdGA8jxa0JUqjL3yWzq4OSr76lmhKobeWj8Bk/itCQLbkM61FeqevMN8rGI4QShJFYGP/voiKfnaLfKrrh1fXiycWCIMrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mX9M165fRjvNmMhzknORHu0YDmYXjBmi04RTHKz1AIg=;
 b=ic54fUxdqtKPadLpKr8JcFMar963+WaTqaFYPlRpZxYoIOKzICqEw8Yk7e1tA/sOgTwCOof03PTuwWsXxEeOBDoTjTWkPmAQxe9X2h5gKmV70mP7/pDMg7wObLIXwVFbFnHXrd2fD0mp+tuK52v23yYLkY3OUkDtA/rVm5+qrXT8WVcBUdiPQDoWKwZsP1436S6hKaRTA+JMAbSdj9N4BE6dkRvuzmjUvANZglchFBlPAtdaJm8a0CCxYIrPmaE1Ra27AX7dbZ9yk9do8Oftnbhsu6FIA5t/82wBHZeK2TatfNI2c4Quj/fobOykIFLLhMr9gzsMULnYsMoy4x9UWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mX9M165fRjvNmMhzknORHu0YDmYXjBmi04RTHKz1AIg=;
 b=J3opJHpUwwrtUoP0ePFq6ZoG5oWEVRg2qTGJ/qTjDFZXnuGuIrauaWZkru7yEce1pCCs01gNUSGsALruqOX1HJmfWMprWXZZZ+/JGBEKLHLi+A76nYBmd5MGop4llP+IO/HWiqWiLfWgGWbwUFGT9jmEkUR5relcl/tsQO1flJs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY4P286MB7208.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:368::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Mon, 11 May
 2026 06:09:56 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9846.025; Mon, 11 May 2026
 06:09:55 +0000
Date: Mon, 11 May 2026 15:09:54 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Max Boone <contact@maxboone.com>, Niklas Cassel <cassel@kernel.org>
Cc: mani@kernel.org, frank.li@nxp.com, allenbh@gmail.com, 
	bhanuseshukumar@gmail.com, bhelgaas@google.com, dave.jiang@intel.com, jdmason@kudzu.us, 
	jingoohan1@gmail.com, kishon@kernel.org, kwilczynski@kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, lpieralisi@kernel.org, 
	marco.crivellari@suse.com, mmaddireddy@nvidia.com, ntb@lists.linux.dev, robh@kernel.org, 
	shinichiro.kawasaki@wdc.com, mboone@akamai.com
Subject: Re: [PATCH v14 4/7] PCI: endpoint: pci-ep-msi: Refactor doorbell
 allocation for new backends
Message-ID: <y2jqclduzd2zkolgxxavsu6uvu7wcjcbt4mi2rl75qpfan5a7r@x4i3siuuvixu>
References: <2F694A6C-23BA-4025-ACD7-2751595982CB@maxboone.com>
 <afHQWdn2rmG4mAA4@ryzen>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <afHQWdn2rmG4mAA4@ryzen>
X-ClientProxiedBy: TYCP286CA0178.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c6::9) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY4P286MB7208:EE_
X-MS-Office365-Filtering-Correlation-Id: d898b5c5-3094-4e72-3252-08deaf23ec58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|7416014|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	qj/vl4fAd2hxQ1+lARKCCaj26GUyxfA6XUMdygmOpOMbUJt4VaYpEDJHFMhGucnd6ZAUwI4iR8Ov25lSQSs61Hz1CF4FkxHlau66YFGD4vRQwPw/fLvredo10TE+n3eBrib73qdZjgbD1nvpl4H/7xKl8P5nBNDzmEJLzaVRzQjrL41iGSSBEtmeVNQacHMYaQ5NNnzqQsh39cT4W9WwTioz3ALWc3jvJt5Np71D2hM1xSICfuVguWXNBSsAXf6ijpWitkKIk+3TQLWZxF9X70LmODoyui5+govGjfbg1O5gBunAvKl9bTqR9MXk1y0UF1EsCOW3vUTLgXqxzDzuCDlwXAGLK08hDrQOBwKpVylutYSwb9QGZWqIeeWhpehpnsCY6EI2Q1HWoCU4AJlo2GByza9HwU/tfoKsYU4te/UvoowgFMl3REKGT+YOBmiwgoe1G0kXtpt5buCaZ8mjGxE5SZbKz0ncjmPJEf4VpshxmhyTwxACNj8tt2qFdGBVkIqTboPcWdMDHmkS1w3CFG33rCu5KJ+jGyAVjRPoiW7/ZA69a3xoI45h8i3NnLtvJGClrNYW7cn3Ic0QNPUgxeOEg0rN/Na1+OLZ07UWNPFARcsLDS3u0XidFG3Oorooceo24quIaMlN+T0vAROOaQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(7416014)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cExINzEzNHJEdlJQNEtaUDE3dkI0NFE4WVdmWFRiNnFRbjY4UEFPSGRaeDhV?=
 =?utf-8?B?OXN1RE9oNzFiOFVwL0hsdWtVeEJpTlZtZTdNa2lRdllkbEVJN1NJZzNxem5Q?=
 =?utf-8?B?Mi9semt5SGVvTEZTYWt5R1I0RnIxb2Vyc0V4Uk5DMUtWUHFSMnhlY1g5M2F1?=
 =?utf-8?B?VVlnQkZzYlV6UksvUkxPa3lpa05xZ2g0YU11YkpzWHVObFF2QklqMDNDbktL?=
 =?utf-8?B?VW1UdzNBZ1hlUXJzdEh1OWVGTGN3S1Y5MWxiUExsRW5YQm5IcnJGYkhNRGg2?=
 =?utf-8?B?eVBBeFdLa1FmcUNvU3ZRTnk2UGJGWTFteG1zM2xCMGpBWUJXKysrK1plbFJ3?=
 =?utf-8?B?blJ4K2dKM29WUEU1RUg2MkZhdlV2Z2NScHhKQXV2TmkzR3RCZE5CSVBUME1w?=
 =?utf-8?B?NytWNERlQUU4bzRFc21xZlpWWlFORmpKaWFMQi9VRGNDdjdqemh6Q2NER0ZL?=
 =?utf-8?B?QTNHNVpQbFRneWJ6NlNLcndwVHhhYTBuamZCZjl1bjE0UlA0ZEc3aXd5WTRo?=
 =?utf-8?B?NktEY3JpRkltd1Z2TURRM0FOYXB5b3R3b2pYSUNaL3FhVFVubEtaSU1pQU5B?=
 =?utf-8?B?UDVna081NDEra2k5NTNtWHVTNjMvcCszVVV2bDJUNzVZTGc2MllyY2kyQmUx?=
 =?utf-8?B?cTVDZUlJaE9mSGpiUWNuVVUveTZPQUhOWVViaGVoclp4eUZvYW9MY2FWbkNH?=
 =?utf-8?B?RHRGV3MrRFRBOU5DaTZSZDJXdmNSVXVIYVVsOG5hUGdGN1pUZzlJVzJXalhj?=
 =?utf-8?B?bkNURnlPQ0VWa2duQW0xdktGVGNXRjVveEZRU2NLUjFYVTNoNEI0a0hZUDZZ?=
 =?utf-8?B?UjBQaEVrbUtOQ0tUME9GcHYxWXRIbDFrS00vTGkxNUU2T2diaVB2V0dKTnNy?=
 =?utf-8?B?LzBYV1NCc3lLWUxaTzVJa3d6MFFuZldwcVNqMzByREFKa25CYk1SaW4xUXZF?=
 =?utf-8?B?cTk2aWRaL21tMUxxUVpxakZXeUhkWkJZNmVPbS8xcVNsUGxxT1BYY2VWaCtO?=
 =?utf-8?B?TS9kaUJ4bXZPRG5qQlV2U2hydEZoMkppVlZjajgxaFVkeUJROEU5N05IandC?=
 =?utf-8?B?d2l4bHVCenF4eFplQmtjblZtS1R3Tjl5YVZIcFBGY1h4ZkgyTnRhck9KVzVZ?=
 =?utf-8?B?ZU5sZzh5VVBPMHc4RnBDelo2VUZUMWdYaFBOS1NpQVNvVWczejZSWVkvWXk5?=
 =?utf-8?B?dUhnOUUzN3hiblNrNnFrYVlzYnF2RW51SFp6YmVvRmsyTlRSMGdRUGFpTG1L?=
 =?utf-8?B?WU1zWGdRU0pmdmNraDg5VE5PWWF5eHhRYjNUYU9QWHViWW5saDNoZnVtaVM5?=
 =?utf-8?B?Tm1WMis0OVBMemNmNTJCNWU0SlRoUTdsbUNOL1NHS2Zhak5lWjlGSm9LMmd6?=
 =?utf-8?B?K0hVa201RjdOOXJibEZRSG05QjkvTjZpTi9wZ1NFQnppR3JVSlFOUERvc0ZQ?=
 =?utf-8?B?QkhCUk5jVFlFdGJ1MVNhU285ZmR4aEQrS2RjeWZuOUVRdWduWnVtSFhEVmxP?=
 =?utf-8?B?QXJqdkp1Y2hkQW5wcml0M0VtZzBudVBhWndncUNRbjRGSStOUysyN3JpaWEv?=
 =?utf-8?B?SUNVUVQ0V2hJUDNzNWIwZHV1ZzAxRW9uUXZsVGlHK1dTOGRQMEpzc0RFbWpU?=
 =?utf-8?B?aDRIZHRTWjVhZm1sZGpHUEowaUFxY1BrRk5oZkpzallWVS8zQlpaOGlPUFEx?=
 =?utf-8?B?YkJzQzhBOURrOFdRVjc1dHplZWpoZnVINDJJZDR2aW5uTFBhUGgrWVEwdUN1?=
 =?utf-8?B?U1k2QWQvSEdjcUYvOXpzUENSZ29XNkxTMTA1cE1pMmlQQWFsemxjZnJtK3cr?=
 =?utf-8?B?Yy9kQURzcEN4VjVGY1lzc0Z6ZUV0cXlWcXVRMEFsQWd5SUJFMzlyTFhSNnJG?=
 =?utf-8?B?bndSNC90QkQvZHhLZWtEUE5tQTB6NTFkNnFrVHBLUFRVZVhXVDFDRFlPNG9W?=
 =?utf-8?B?blRFMi9YeTR3YXVDNGhHclpDY2Q5c1U4UGlmeit3NjFGMmEvSnN5b2xsZHNl?=
 =?utf-8?B?QXpJWUJZY3Y5QUF0OFFYUDZ1V3kvVGlvMEgxaVVnS1N0QWh2Qlh5OS9neHRM?=
 =?utf-8?B?bWszRmxuMHgyNTN5RUhycmxkYW16RXRGQ0FtLzF4NW44TVAxNU82dzFZd2dG?=
 =?utf-8?B?WHd4RGRqS3pNVW5jQXhNcVBscXJxWkhYQWtkYTU5R3ROUzRuUmpMK3gwN2NP?=
 =?utf-8?B?ankvQnBiYW42OTVzUDFzWXhDN0FESlV0Y1VsNkFrTnhmekRBTndmZThvL2lV?=
 =?utf-8?B?SVM2NjFTNGdlWVJ6WURpMGJ1Rit5S014SUFqLzF5VDBNUXBCT21KbUJ6eC9O?=
 =?utf-8?B?OHVjOW9HZWlQQVZQaXVzU3E0WVo0Rjh3bDRKRmxkRzlibzZncTRWRkh4am9j?=
 =?utf-8?Q?UEhxDIVVthxmF2kCzKE3o28cP7UnFUwi3e+92?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: d898b5c5-3094-4e72-3252-08deaf23ec58
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 06:09:55.8405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ffkAf9b2Sc22G2N4dbv9wFMpkFmKWXLy84znNz/Xa++xq+okRnURvC1DqUD9RSpnrKr4wdPyB/tW8U0anmfcKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4P286MB7208

On Wed, Apr 29, 2026 at 11:33:13AM +0200, Niklas Cassel wrote:
> On Tue, Apr 28, 2026 at 10:36:15PM +0200, Max Boone wrote:
> > 
> > I’m not very fond of keeping this implementation in the pci-ep-msi file,
> > as the platform MSI and this implementation are both iiuc specific to
> > the designware ep driver. Even more so because the MSI implementation
> > is enabled by config rather than through device tree.
> 
> Why do you think that the current code with DOMAIN_BUS_PLATFORM_MSI is
> designware EPC specific?
> 
> I don't see anything that is designware EPC specific.
> 
> Sure, it relies on GIC ITS, but I don't see why non-designware EPCs can't
> use GIC ITS.
> 
> 
> > 
> > Wouldn’t we want end-users to specify what kind of doorbell they want,
> > as it seems to be that a more specific doorbell BAR layout can be 
> > programmed with eDMA, allowing native support for nvmet’s doorbell
> > BAR for example.
> 
> I also wanted to use my designware based EPC for doorbells in nvmet-pci-epf,
> specifically the support that Koichiro added for inbound subrange mapping.
> 
> However, most designware EPC have a strict alignment requirement
> (CX_ATU_MIN_REGION_SIZE), which is often 4k.
> 
> This alignment requirement is there both on the PCI address (address within
> the BAR, and for the physical memory address (target address)).
> 
> I thought that we could use the inbound subrange mapping and put the doorbells
> in a separate inbound iATU, so we could remove polling in the nvmet-pci-epf
> driver, just like they have done in the vNTB driver. However, it works in vNTB
> because they have a register telling exactly which BAR and offset in that BAR
> where the doorbells are.
> In the NVMe PCIe Transport specification, the offset for the start of the
> doorbells is fixed, at offset 0x1000 (4k) and the only thing you can change is
> the stride between the doorbells.
> 
> Currently, a doorbell is a single 32-bit data, sure we could call
> pci_epf_alloc_doorbell() with ("number of I/O queues" + 1 (admin queue)) * 2
> (submission queue and completion queue).
> 
> However, the address which we get from pci_epf_alloc_doorbell() might not be
> 4k aligned.
> 
> We have the function pci_epf_align_inbound_addr() which can split this
> non-aligned address to a 4k aligned base + offset from that base.
> 
> However, that would also require the host side driver to write to this offset
> from the start address. (See e.g. doorbell_offset in pci-epf-test.c).
> 
> So, basically, with the current limitation that the doorbells must start at
> 0x1000, together with the fact that the doorbells returned from
> pci_epf_alloc_doorbell() might have an arbitrary alignment, I don't see how
> we could add support for doorbells in nvmet-pci-epf.
> 
> If we could supply an alignment requirement to pci_epf_alloc_doorbell(),
> e.g. 4k, and the API is guaranteed to return an address that satisfies this
> alignment requirement, then we would be good.
> 
> However, right now, we don't have such an API. We simple get an address
> somewhere within the GIC ITS MMIO region.
> 
> 
> > 
> > Originally in a patchset by Frank Li the API that was proposed was more
> > generic, and the pci-epc-msi implementation was chosen because there
> > was only one implementation:
> > - https://lore.kernel.org/imx/20231019150441.GA7254@thinkpad/
> > - https://lore.kernel.org/imx/20231019172347.GC7254@thinkpad/
> > 
> > I’d personally prefer to see an abstraction that is weaved into pci-epc-core
> > and pci-epf-core that can be implemented by drivers as they wish. While 
> > still keeping the enum for different types.
> > 
> > That also gives room to pull a poll-mode doorbell into the pci-epc-core,
> > which deduplicates that code from the nvmet and vntb epfs, and allows
> > other functions to use RC->EP doorbells without needing to bother with
> > writing the polling mechanism.
> 
> Sounds like a good idea.

Hi Max, Niklas,

First of all, sorry for the late reply. I was away from late April, then caught
pneumonia and was out sick for a while...

- Regarding the common poll-mode doorbell:

  I agree that it would be useful. I don't have a detailed implementation in
  mind yet, but I can imagine it as the last-resort backend for
  pci_epf_alloc_doorbell(), used when no interrupt-capable backend can be
  allocated.

  In that design, I don't think this necessarily depends on making the backend
  type selectable by the caller. If I misunderstood what Max meant by "That also
  gives room to pull...", please let me know.

- Regarding the enum and explicit backend type selection:

  Earlier revisions (~v4) were somewhat closer to that model, before v5 moved
  the fallback selection behind pci_epf_alloc_doorbell():

  https://lore.kernel.org/linux-pci/avey4i3lwcqt4wsy3y2wjlx7ixo7sqe64hngj2ne6vubl4mjzv@kaksbjkspifd/

  For the current vntb/test users, I tried to keep the backend selection
  transparent to the EPF. If the MSI-backed path is available and working,
  explicitly asking for the embedded /eDMA fallback does not seem very useful.
  That's why the path is tried only as a fallback.

  That said, I'm not opposed to extending the API. For future users, it might
  make sense to let callers express additional requirements or preferences.

  Since this series has already been applied, I think this can be handled as
  follow-up improvement work.

Thank you both for the detailed and constructive discussion.

Best regards,
Koichiro

> 
> 
> > 
> > P.S. I’ve been working on a vfio-user based epc for development purposes
> > personally, and the last hurdle before I want to send it in for comments is 
> > support for doorbells, and came across this patchset checking if there’s
> > any other activity in the space. Having an implementation-agnostic
> > doorbell API in the EPF/EPC core would be very helpful to me.
> 
> I have looked at adding doorbell support to nvmet-pci-epf, but got stuck on
> pci_epf_alloc_doorbell() returning an address that is not 4k aligned.
> 
> (Since the NVMe PCIe transport specification has the doorbells at a fixed
> location, we can't change that.)
> 
> But if we could provide an "alignment" parameter to pci_epf_alloc_doorbell(),
> then I think it is possible.
> 
> Sure, the GIC ITS MMIO area might be quite small, so it might not be able
> satisfy such a request. E.g. on rk3588, the its1 MMIO region is 0x20000 (128k):
> https://github.com/torvalds/linux/blob/v7.1-rc1/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi#L2414
> 
> However, I have not idea of how much of this region the GIC driver uses for
> actual registers, and how much of that region it can actually dedicate to
> doorbells.
> 
> 
> Kind regards,
> Niklas

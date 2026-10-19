Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010012.outbound.protection.outlook.com [52.101.201.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809554848AC;
	Mon, 19 Oct 2026 11:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792408453; cv=fail; b=h6a4PPk1TJ8frbww/unOkEiyHhNVo+D7ZoaXP3mOoMNer9xN3dNZkCVwJTGttsc3f6082losLZpltTXfUsyI0+tj89LPj7nP0CDSPfr9q56I+Lm/3c2w1wPvemaR2vbjHJBik+JguGmVOvPi0WEptgDZZEVNJRLnHBLH0FgVT9A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792408453; c=relaxed/simple;
	bh=4V1EeEIDpUZPJwumvCNO2Vk/v8ckyTzKFq7FJVmmFL8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=awLGBLtJ7llpgnkb0HI10RzOFJC1fxZLCzbgEkMcHk52Wf6sFhqKkOzT/dN0KV313hWak0DA+eqJNME4GwZiHGMCNL9Ci52ufbyPcR9l0VD4fOtpkaUfHDOx8Z3S7/G7REYtfh/ouiQkGCPLbvJy+CtOvMIE9hJtXyWVxFW5LRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bf5oWsbk; arc=fail smtp.client-ip=52.101.201.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bf5oWsbk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xeJOHZdym07a1vAVtLmDlJkYXhzgCVBOpgyBQ+NunwXiVbLGIc3SrGUAzvgHAG57yNpzN2CIGzJR7x53hyLsXhkozh2SDzurcSvpx0L+iUAYKTudj9neLTIVpLHi0UFDo/rUu7UuMBrjyLdFw8SvygLEC0pDUWtQMKMMbDzdJjeowGTs0QMeBg8jdqBGLf5j/q8ASl6yBfX5myJCyaja7tcCVvQFRF5scDm2TBQq5NBHRSxs455xNQiGrgO3bhpK617jxPQMRAljS8gWWtNNjb/dIpH6Ct1PXgXF/valM0Hg8wkQnl/PiHvlH8yAPhSFfjGTGwJp+X8r+VquOWGeIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wP8wBXIBuq5ZdlxvFkMbU13JOKJfZV7kPsxH+W00P78=;
 b=nGvPIhUEbhRb2pSFggftw0M0ZKcnpsWj7GWZujSKXvTHHKYFEYMSIUXjNJrDvd7Vrka2EuGb/O99P2KbaM9ydcg6Ck8FXzgK5Wf+ZgzdlHNgNcE0G6GlGW72d2ZAzUwQe88G7TWDls9mzcX54EqEKOjPdTxdU0EkpwPI2QTakdcwFoJbqsKhwFeMv3nh34waSs5cXOxDxuYbIF/lG+H3W/xfC6Ia3Xu200rulpTwBrYl2LU496UDlVrHAbkn0NrjQn1wdWgBbHrCPzbG0v2TZ5l0FvcyCGQ+j17veXkbAcBPrIe7lMqCGcALMVVOwrZsgRU1Gyama2BXY4L5UilUUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wP8wBXIBuq5ZdlxvFkMbU13JOKJfZV7kPsxH+W00P78=;
 b=bf5oWsbkjlBtIdRymuPO94REd2561ZiTUt4psTwzKEuW/N4Me8qNonLgx1tA/+xpvvZwEAeOtxOtE0Jh5OwYYR0kIdUg5Lt0kkjekhWvp76Yv36e24Tm4meQEqDHLNhDyuIMg7N9tFAYZfY21DljHrbXgUb7lncBwsnoI2qj3lJ/HdoF3jHEwbOw5f3Ozu+cMmu04GBs+u66QndfCB6AcDV5BwPQa+03zfnevg8RDVinxSOGV6xxXNF7Zu5TmDsE2WGRVxoDFzzx6GkxKPLGTLiLG5j5V3k79EDUBO3ZAQED8LJSCbMnw/wN2Fzf3jn5cPWoMMDnWY09CugkYpZ7vA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB8245.namprd12.prod.outlook.com (2603:10b6:8:f2::16) by
 SA3PR12MB8045.namprd12.prod.outlook.com (2603:10b6:806:31d::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.24; Mon, 19 Oct 2026 11:14:07 +0000
Received: from DS0PR12MB8245.namprd12.prod.outlook.com
 ([fe80::e7c5:cfca:a597:7fa4]) by DS0PR12MB8245.namprd12.prod.outlook.com
 ([fe80::e7c5:cfca:a597:7fa4%3]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 11:14:07 +0000
Message-ID: <549bbe12-d171-4874-902e-bd38bb900957@nvidia.com>
Date: Mon, 19 Oct 2026 16:43:57 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/11] PCI: endpoint: test: Do not relocate fixed MSI-X
 tables
To: Koichiro Den <den@valinux.co.jp>,
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
 Niklas Cassel <cassel@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Krzysztof Wilczynski <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas
 <bhelgaas@google.com>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>, Rob Herring <robh@kernel.org>,
 Thierry Reding <thierry.reding@kernel.org>, Jon Hunter
 <jonathanh@nvidia.com>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Frank Li <Frank.Li@kernel.org>, Vidya Sagar <vidyas@nvidia.com>,
 Marco Crivellari <marco.crivellari@suse.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20260923072237.1139013-1-mmaddireddy@nvidia.com>
 <20260923072237.1139013-12-mmaddireddy@nvidia.com> <arPjAeYzVbe5_qo8@ryzen>
 <179198883276.63727.4456977474157450415.b4-reply@b4>
 <wfzi6cojnam2flqksk55i2nghpovhteeirsy3phfa6zxlloy66@oajxjlhqusrb>
Content-Language: en-US
X-Nvconfidentiality: public
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
In-Reply-To: <wfzi6cojnam2flqksk55i2nghpovhteeirsy3phfa6zxlloy66@oajxjlhqusrb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN0PR01CA0003.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4f::8) To DS0PR12MB8245.namprd12.prod.outlook.com
 (2603:10b6:8:f2::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB8245:EE_|SA3PR12MB8045:EE_
X-MS-Office365-Filtering-Correlation-Id: 683e58a6-20b9-40e4-d601-08df2dd2174f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|7416014|23010399003|5023799004|10067099003|6133799003|56012099006|4143699003|11063799006|18002099003|261009223027099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	sVCo4w4rk2D5ORWLwltqeSVXVG/e5hjE2OKqUlSpCkx8fzFcODGKBVouciQJEB2R7Du9PhNkQRpKax1lYX7TNDMmo5GvbTmx9rjp6ZznKmnrMW3mnovTrQAA4BhMEDHTlEvj18/mESdsR0GgNMu+SbsTYoFSqm1k/ojATCClSVTAG22W/D7zry+/kDFvmcELkeUfpXBc0Oaa32/XtJ05EQdJP2i8vLX7eXhbjySbhgafCLjWEcBfiTg0tleUs3sn1W+Mbds6Hu4mFvOHkFgztCM17nGOP8NAohMPeWFyfotwQpaP8YE3NBZBiLzqhrfFIXb7CrtGXjIHRemUY5ZVh5a5zON8TRW9309N3a+9LUjyfnnQRHdSjamzkXWXgihEzLSi/ZMFE+aADj8LKLX4xt/V5n1d6niDKeHxUzJuky7E83Pn3cDxm7BssG3Rd6FfJoBQUYtQ41bwMsBXi/7E8klE0OLoomDn7yUXTcyM6q9QfOvOqeR4sznkIqvNsAPMyTT1tDVEL63jNqocQmDvjPMoUATaU10GM2yJABO3S3LrGC/F0nYO6zVCC1FeFxfXpsin0DYJL6fu3XM0QDDHifOYBcCXT7GfJ+TF2ZPsOBlPN81GHAKvIJrDQuCrRd/6E35LyIJxrHARpeltaknR1GTfLy8vcGFCZn1llFL3Ftc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB8245.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(23010399003)(5023799004)(10067099003)(6133799003)(56012099006)(4143699003)(11063799006)(18002099003)(261009223027099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NERoWHpBUDdlM0tUSmhoUy9nZTY2TG0rbGpqcjFDNEVUalBIM2QzWHI0Y3px?=
 =?utf-8?B?VnhCYmR5dmZyMldBUlJESUI1Q3pienRhSlNCWldPbXp1dTFUMGlxcmhhUnVW?=
 =?utf-8?B?bVc1VnlmWjhFNTJzZit2SktmckJvUkhRWWpROGJtNVhMSkxwTXpaMldxNkVL?=
 =?utf-8?B?b3dPZmpLZml2dzhONmNMYjRoT29jZk9DUXlPM2YydHhBQzZBRTNwUWRJZmFW?=
 =?utf-8?B?NnVIWlAwVDhldkl6U3l2bFhtWlYwVjRUeG5FSk9wWSs3Mm5uNThWUWlCVnF1?=
 =?utf-8?B?T3dtdkE0b3dPNDBYajNGY0RBZTZJSVF2cGFtclRGYmQyellyOGZFcUxYeWtG?=
 =?utf-8?B?dWZndmV4ZHBvRDBZSzFuaWlUd2xIYUtLaTFaM1hpbGFMbTVuOVprNFJ2NG9B?=
 =?utf-8?B?ZUFZa0dnOEZTK25hM3dqSmlLS2R0citTeGdDajlvb2pXWG5rVXVHYTJrOW96?=
 =?utf-8?B?WFJlemZXbTVwdkpJN2Z5YWxreE1GTkdJZFQ1SkY2MjI2ZitqUktSZlJJYjA5?=
 =?utf-8?B?NlJQZW5aUlFsY09Qb1M1bmVpWmFEaEtIdEUzVFBxQk91SzdxWVpNZnFzTXM5?=
 =?utf-8?B?UEFUbEJxY3hDK3NtQjllRWNOQzEra1QzdDVoVkdnRmFjcTR1QWQ2RlNZM0lY?=
 =?utf-8?B?Z2NHTGlGWFh4UjRjTkVrRFJFallycjR3dG8xYnk4Wno5VmplZDFza2VDNUl3?=
 =?utf-8?B?YVBjNkpPRzJiMnlXWjJKbU1Vd1pPb1plZHhKbktLTlJJK3ZhZ1lDYy9HTk5i?=
 =?utf-8?B?U1RucEJUeFBZRG1sdHRyZGZDK3lzTENUSVhONjRQUkNyMlFrZlBiWUd0U1J5?=
 =?utf-8?B?b1hHNjNQZlFhTHBiekZCL1BGNGVlUXAraGFWTGd0ZlFoZkVQcG44WHBWSGJB?=
 =?utf-8?B?VCs0bTBhTFJXOStoWXlZaUsxeGVVTjFwcHdTNk9iMmpWVEdHbWNyRnJwbURV?=
 =?utf-8?B?U01nVXlsajdUSVZEWjVLMjJDRFRsSVFid1BmUUtsWmZDSCtxV3hIQmtwT2lh?=
 =?utf-8?B?N0hwVWRIWUhVYStPTWpseFQ1OUVXSzRJRGtkSllEL2N2cXBaRUx1YjJRa0lZ?=
 =?utf-8?B?ZE1PWUdGUjFZcFpUZ3lORDdONjRwYzB1cGRlRGJjZ1lyS1ZPWFZXM21Wc3ps?=
 =?utf-8?B?c2tQZm5qNXY5T2t3QTBkcWRhWnBzUnhYS3VNRGhFdW1YcDNNdElab1lzMkJn?=
 =?utf-8?B?V0I5SWMvaFFmM0Z0Z2RsbDA5N3Uzb0xmQ0IzRUpoTWpKeVBDcFRQZGt2akdS?=
 =?utf-8?B?MCtCczhBNnVBN2xmM01DTk9UWnJ5QXd6WENJZnRubkJiTSt1MjNuMzhTVVJN?=
 =?utf-8?B?eG0yZXhDb1pCZVh4WUZ0QkUvL3hVZUlCMVFRbFFpTWU1REVVOE9pZU1yZTBa?=
 =?utf-8?B?VExRck1TNVZMcWwzQ0hCY0l1UHFWNUg3L1cycXFid3B3NW5Mbmhxc2FRak9W?=
 =?utf-8?B?bFJQeCthdVRtaFRyRllnNXgyRWU4eGVrZXJyVUJWTVlUN2xORmV0a1lBZmNh?=
 =?utf-8?B?SnlpQ29VM2JzQm51QXVSeFplRTgzeHdSaklrSjB3RzM2R0dwVkgxZWJ1cmFU?=
 =?utf-8?B?bEx6Skt6Uzhwa2VHeDJIb1V1YmVtV0ZWZ1c0bzllNHpnYjRHUDNJTTFmQ0hO?=
 =?utf-8?B?VkY5YU9kNDE1eDdCY3M2M2ExNTY1L2VnWWFzcFdOaytLbmJ0V0R3OEszMnVp?=
 =?utf-8?B?ZlJyeUpOQ3F3aTdKaFR6dkl4dTd2WEpJQzQydnJ4OVhkU2FBdllERE1OSkZD?=
 =?utf-8?B?MzNQa2tPYU0zc2ptQlNsRzVqTFZ0MWt1QTJCYzdiVC9XZk1scG1MbHdyekZI?=
 =?utf-8?B?OXFjWC9Na3VMRFQrQnNJdUxoOWpLdzZzM0QvMVRQcS8xR0RGak92MndqWjVD?=
 =?utf-8?B?ZzJBZFBud3dHTlB4Mnl0WVdZZm04aFNIdzY2OGRwOVZuZW55a3NUbmZ3U2RS?=
 =?utf-8?B?dlJXMThTUFhJQ1gyM0hCZFRDcHZyeWM0TTlqbEIyOFltTGRGOUthTmliRUlF?=
 =?utf-8?B?bXRPNTNXWjJFN25wcUtJZlh4MzRvWUVsSWhzYTZrMTlYRmZDUENUaGI4ZVlK?=
 =?utf-8?B?T3o2TUNBMXdOQWU5SCtUdk0zRitDWm40cHFpWnhnOUpXUysyd2I1d0ZKOEFm?=
 =?utf-8?B?MVJEKzRhWkp4cE9yVm9sdFFmR3RZc2dmNkFra01ObWM2MnAwR29KNnR5N05i?=
 =?utf-8?B?VVlaa1RoZm53alpmVkVWYWhUK0xkalRCeEJXK0ZRUEJ5Si9IZDBSaERZZFhr?=
 =?utf-8?B?M1RocFlRVmc3Y0tJRzVIZnV3NFZ6RVpzUEdaN1daT2NHZ1R6c0xqTHBzdEl2?=
 =?utf-8?B?OVBIdmlUbUNwL20rOC8wNVM5MDJtQ0FjSEs4ZG5LdjI5OUNZUFp1QT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 683e58a6-20b9-40e4-d601-08df2dd2174f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8245.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 11:14:06.9259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0K4sriuQcmQ0AmjHZIIBe25SQEqBerVNzb4Z8K1N5QLzQorlBz4hqT7aUd3bb5gl0ahsNM9Z2Y95aJ+2MEnbFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8045



On 15/10/26 11:13 pm, Koichiro Den wrote:
> On Wed, Oct 14, 2026 at 08:10:32PM +0530, Manivannan Sadhasivam wrote:
>> On 2026-09-23 16:32 +0200, Niklas Cassel wrote:
>>> On Wed, Sep 23, 2026 at 12:52:37PM +0530, Manikanta Maddireddy wrote:
>>>> Some endpoint controllers expose MSI-X table/PBA storage at fixed,
>>>> hardware-owned BARs. Such BARs are described to endpoint functions as
>>>> BAR_RESERVED with PCI_EPC_BAR_RSVD_MSIX_TBL_RAM, so the function driver
>>>> must not reprogram the MSI-X Table/PBA capability to point into ordinary
>>>> function BAR memory.
>>>>
>>>> pci_epf_test always allocates MSI-X storage after its test registers and
>>>> calls pci_epc_set_msix(). On controllers with fixed MSI-X storage, this
>>>> overwrites the controller-defined MSI-X layout. For example, the generic
>>>> DesignWare path derives the PBA offset from the number of vectors, which
>>>> can make the host program the wrong MSI-X storage and prevent MSI-X
>>>> delivery.
>>>>
>>>> Detect fixed MSI-X table BARs and leave the controller-owned MSI-X
>>>> capability layout unchanged. Keep allocating and programming MSI-X
>>>> storage in the test BAR only for controllers that do not advertise fixed
>>>> MSI-X table storage.
>>>>
>>>> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
>>>> ---
>>>>   drivers/pci/endpoint/functions/pci-epf-test.c | 27 +++++++++++++++++--
>>>>   1 file changed, 25 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
>>>> index d4905aa8e4c0..82d4714e998c 100644
>>>> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
>>>> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
>>>> @@ -83,6 +83,7 @@ struct pci_epf_test {
>>>>   	struct config_group	group;
>>>>   	enum pci_barno		test_reg_bar;
>>>>   	size_t			msix_table_offset;
>>>> +	bool			msix_table_fixed;
>>>>   	struct delayed_work	cmd_handler;
>>>>   	struct dma_chan		*dma_chan_tx;
>>>>   	struct dma_chan		*dma_chan_rx;
>>>> @@ -98,6 +99,26 @@ struct pci_epf_test {
>>>>   	size_t			bar_size[PCI_STD_NUM_BARS];
>>>>   };
>>>>   
>>>> +static bool pci_epf_test_msix_table_fixed(const struct pci_epc_features *features)
>>>> +{
>>>> +	enum pci_barno bar;
>>>> +	int i;
>>>> +
>>>> +	for (bar = BAR_0; bar < PCI_STD_NUM_BARS; bar++) {
>>>> +		const struct pci_epc_bar_desc *desc = &features->bar[bar];
>>>> +
>>>> +		if (desc->type != BAR_RESERVED)
>>>> +			continue;
>>>> +
>>>> +		for (i = 0; i < desc->nr_rsvd_regions; i++) {
>>>> +			if (desc->rsvd_regions[i].type == PCI_EPC_BAR_RSVD_MSIX_TBL_RAM)
>>>> +				return true;
>>>> +		}
>>>> +	}
>>>> +
>>>> +	return false;
>>>> +}
>>>> +
>>>>   struct pci_epf_test_reg {
>>>>   	__le32 magic;
>>>>   	__le32 command;
>>>> @@ -1214,7 +1235,7 @@ static int pci_epf_test_epc_init(struct pci_epf *epf)
>>>>   		}
>>>>   	}
>>>>   
>>>> -	if (epc_features->msix_capable) {
>>>> +	if (epc_features->msix_capable && !epf_test->msix_table_fixed) {
>>>>   		ret = pci_epc_set_msix(epc, epf->func_no, epf->vfunc_no,
>>>>   				       epf->msix_interrupts,
>>>>   				       epf_test->test_reg_bar,
>>>> @@ -1282,7 +1303,9 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
>>>>   
>>>>   	test_reg_bar_size = ALIGN(sizeof(struct pci_epf_test_reg), 128);
>>>>   
>>>> -	if (epc_features->msix_capable) {
>>>> +	epf_test->msix_table_fixed = pci_epf_test_msix_table_fixed(epc_features);
>>>> +
>>>> +	if (epc_features->msix_capable && !epf_test->msix_table_fixed) {
>>>>   		msix_table_size = PCI_MSIX_ENTRY_SIZE * epf->msix_interrupts;
>>>>   		epf_test->msix_table_offset = test_reg_bar_size;
>>>>   		/* Align to QWORD or 8 Bytes */
>>>
>>> Here you are only updating pci-epf-test. What about the other EPF drivers?
>>>
>>
>> How can we test those other EPF drivers if there is no hw setup available? TBH,
>> we don't need to add all functionalities to all EPF drivers. Adding them to
>> pci-epf-test driver is enough. If other EPF driver maintainers want to add the
>> missing features, then they can add them after testing on relevant hw setup.
> 
> I wonder if nvmet-pci-epf was one of the cases Niklas had in mind.
> Patch #10 sets .msix_capable = true, so with msix_interrupts set to a non-zero
> value, nvmet_pci_epf_init_irq() selects MSI-X and calls pci_epc_set_msix() with
> BAR0, which looks like the concern this patch #11 itself wants to resolve.
> 
> So, Manikanta, have you tested nvmet-pci-epf with MSI-X on Tegra with and
> without this series? I don't have the hardware, so please correct me if I'm
> missing something.
> 
>>
>>>
>>> Also, if you run then pci_endpoint kselftest, with the default 2048 MSI-X
>>> interrupts. Are really all 2048 MSI-X successful?
> 
> This also reminds me of the unresolved entry #0 issue Niklas and I saw on
> RK3588... The kselftest's final status hid the failure when a later vector was
> skipped, so it's worth checking the individual results. If the same symptom
> appears on Tegra, it would be useful to compare the two.
> 
>>>
>>> It seems that often the "hardware owned" MSI-X table is much smaller than
>>> that. See e.g. Koichiro's series which tries to use "hardware owned" MSI-X
>>> table, but if the "hardware owned" MSI-X table is too small to hold all
>>> 2048 MSI-X IRQs, then "hardware owned" MSI-X table would not be used:
>>>
>>> https://lore.kernel.org/linux-pci/20260830151948.3547577-2-den@valinux.co.jp/
>>>
>>> +	if (layout->table_size < table_size || layout->pba_size < pba_size)
>>> +		return -ENOSPC;
> 
> Unlike my previous series, this patch skips pci_epc_set_msix(), so as I
> understand it, msix_interrupts does not change the Table Size advertised to the
> host. Assuming the existing Table Size matches the hardware, that would avoid
> advertising more entries than it has.
> 
> (BTW, skipping pci_epc_set_msix() alone would not be enough for RK3588. Its
> upstream driver does not yet advertise the fixed MSI-X Table/PBA regions, so
> this patch does not change its behaviour. But if we add those regions later, the
> interrupt path may need to change too. dw_pcie_ep_raise_msix_irq() reads an
> EPF-owned Table through ep_func->epf_bar[], which is not populated for the
> reserved BAR4. The rockchip driver would need to select the controller doorbell
> when using the fixed Table.)
> 
> Best regards,
> Koichiro Den

I verified only with pci-epf-test driver.

Tegra MSI-X HW supports maximum 8 vectors. pci_endpoint_test drivers 
supports MSI-X allocation from 1 to 2048, so this driver is allocating 8 
MSI-X vectors and I could see 8 MSI-X vector and the count increase on 
all 8 vectors.

  152:          2          0          0          0          0          0 
          0          0          0          0          0          0 
DW-PCI-MSIX-0005:01:00.0    0 Edge      pci-endpoint-test.0
  153:          2          0          0          0          0          0 
          0          0          0          0          0          0 
DW-PCI-MSIX-0005:01:00.0    1 Edge      pci-endpoint-test.0
  154:          2          0          0          0          0          0 
          0          0          0          0          0          0 
DW-PCI-MSIX-0005:01:00.0    2 Edge      pci-endpoint-test.0
  155:          2          0          0          0          0          0 
          0          0          0          0          0          0 
DW-PCI-MSIX-0005:01:00.0    3 Edge      pci-endpoint-test.0
  156:          2          0          0          0          0          0 
          0          0          0          0          0          0 
DW-PCI-MSIX-0005:01:00.0    4 Edge      pci-endpoint-test.0
  157:          2          0          0          0          0          0 
          0          0          0          0          0          0 
DW-PCI-MSIX-0005:01:00.0    5 Edge      pci-endpoint-test.0
  158:          2          0          0          0          0          0 
          0          0          0          0          0          0 
DW-PCI-MSIX-0005:01:00.0    6 Edge      pci-endpoint-test.0
  159:          2          0          0          0          0          0 
          0          0          0          0          0          0 
DW-PCI-MSIX-0005:01:00.0    7 Edge      pci-endpoint-test.0


For now, I will drop msix feature from this series.

> 
>>>
>>>
>>>
>>> Apparently NTB EPF needs to read the MSI-X table from RAM:
>>> https://lore.kernel.org/linux-pci/pj5vpwwd5tr5tuvhdq3bcpefnq27r6ljvwoysguz2o4tglcqx5@l7zmb6wjnhla/
>>>
>>> Which is why he also decided to let an EPF driver choose if it should
>>> use "hardware owned" MSI-X table or not.
>>>
>>
>> Yeah, makes sense. Otherwise, we will see kselftests failures.
>>
>> - Mani
>>

-- 
nvpublic


Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012037.outbound.protection.outlook.com [52.101.43.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B1540B364;
	Fri, 31 Jul 2026 12:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785502357; cv=fail; b=aazTxilYGPOVTlsoFEqC8GwD8wSVsFgjoSIAbvo3ed6RZQLg5RxTq1zdgk34fR7/DmBf9/8RODwHrw9odn95xQZesy2kZb3yT6qFX1jDOj0OSbzcdu2iOovlFSYn2Nyksj1fbSW1GzRK9xpU1p4mXeZFkfWJroU9ukImyjzK+tI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785502357; c=relaxed/simple;
	bh=k/6Z6N2gkQSJZhGno4CC6iUXEybzFevfPNQ7zaPLp4Q=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=BaTx5ndN8A+PNDeUAh1pT4nxmFBp95eGDPNNAOiOzurjx+3o13t0JAjbTY269yMAppLmE2O4XDH16f9J8665hxImfD6ieRGxHYjR41UjpufqPAf+lFxJRhilqEcyLW1gYsbp1OzEr26H5bV8AAM0qm0mDE4P60RylZWpDxzdjs4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Pe/BCHqW; arc=fail smtp.client-ip=52.101.43.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Pe/BCHqW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S+rkhUe491h5hKEa5gtpcerznZrv1L/BWR3M8bMeLL+IZXAsHNlkWwv4DGSPmZOwtx5PopJMyl2h3iZ608kdAZe/e31Gj2Jx0FxZwkLaJ4UVL4M5N62MmfZmT/Z9/T/+BHq2PFDyDrijQYeMT5EelfrkOQMk7BHtI1kYtl7aWFgot2jzSJ1/AB2f6GMW7fBngs91siyN0PEEnMdDOI/WDQX8ZWWgLuUpvKmIoF2MNxrQPWsF1gBtT1Q2qr+/b+EyofOPO7TJgpyykDfGjya6Tb0W3nNnXmXPBMgIA1raSNYWSfR3xWUWsOm6X2ygaI3W/Pr6ec893gbZZz92b71Gzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EzdyfcJsXZvsQIcfDVopmkjYO55JPjt2PWlFiw5hzOM=;
 b=auur4/DPO3aDTV9jal+e7lAVp+cquK9AS0LXp484yilb6zjx529Bnn8dR7cIs80j3mUQohC63C1w114M2x55fYgKj//8CjiPV/pX5YQkuYIIHdXR0qFLT202UFTws1cBcW3GAY5u4epddtolS3PvZa/3uNJSLPkJkWRNXlvvDLdMAOAGDulnBqTsrZCHB/0TktwB3QiLydwKr1slfPQBCZYWjl1pStC0FJfXQZh8HoEjmgU9s18sY/KV9Lm5F6q7YnIdB7e4ItziIY7dvsvScjUm5Q+xRUWgAPNeCYJdHLP7gBbRDCDCLT88LGNW2QmmrNRXq2z60ylHY2bfbnaOfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EzdyfcJsXZvsQIcfDVopmkjYO55JPjt2PWlFiw5hzOM=;
 b=Pe/BCHqWezZ0Ovlz5xHP+Ab6/PGitDRPeon/Kry/ubCQpxu3yat8GPthOkejK1tM4CI1AobGWlYZaVLCmX4v1fBp7HYiUHyHqdHdFNBhAhc6ODJBI+w22Gl+VuxIY2YlKWv1cTnhNXL+rul0zeXxzRSswyTbUsOaqlnk50MenTQXbIDkQ1/xW9QBPfPkFBydUQXroD5DLhUCB2NIO0nEYUW2wEleKafv+GTabT5kF05TJKBQSef60CtV3W/tJhpzqicJwov+WcCNOAShRmGPh8DFcLey18Z2pUcUSv+bPqdQy+hIZOkrh58ZdMQJKQLwFYIDkCBjv4TWGohl93G2IA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3997.namprd12.prod.outlook.com (2603:10b6:208:161::11)
 by IA1PR12MB6258.namprd12.prod.outlook.com (2603:10b6:208:3e6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.16; Fri, 31 Jul
 2026 12:52:27 +0000
Received: from MN2PR12MB3997.namprd12.prod.outlook.com
 ([fe80::73c6:e479:9b75:b2cf]) by MN2PR12MB3997.namprd12.prod.outlook.com
 ([fe80::73c6:e479:9b75:b2cf%6]) with mapi id 15.21.0270.009; Fri, 31 Jul 2026
 12:52:27 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 31 Jul 2026 21:52:22 +0900
Message-Id: <DKCRR8O2JC03.366O1ZBGQ8I7Z@nvidia.com>
Cc: "Zhi Wang" <zhiw@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <dakr@kernel.org>, <aliceryhl@google.com>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <tmgross@umich.edu>, <markus.probst@posteo.de>, <cjia@nvidia.com>,
 <smitra@nvidia.com>, <ankita@nvidia.com>, <aniketa@nvidia.com>,
 <kwankhede@nvidia.com>, <targupta@nvidia.com>, <kjaju@nvidia.com>,
 <alkumar@nvidia.com>, <joelagnelf@nvidia.com>, <jhubbard@nvidia.com>,
 <zhiwang@kernel.org>
Subject: Re: [PATCH v6 1/1] rust: pci: add extended capability and SR-IOV
 support
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>
References: <20260730182954.783568-1-zhiw@nvidia.com>
 <20260730182954.783568-2-zhiw@nvidia.com>
 <DKC4MR1ZBQMP.3L7X2C96OJLFU@garyguo.net>
 <DKCO1B3HUGD1.1IP1J7ZZ5MHCH@nvidia.com>
 <DKCRGMZJXO6X.1SWGREC78DH0W@garyguo.net>
In-Reply-To: <DKCRGMZJXO6X.1SWGREC78DH0W@garyguo.net>
X-ClientProxiedBy: TY4PR01CA0065.jpnprd01.prod.outlook.com
 (2603:1096:405:370::19) To MN2PR12MB3997.namprd12.prod.outlook.com
 (2603:10b6:208:161::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3997:EE_|IA1PR12MB6258:EE_
X-MS-Office365-Filtering-Correlation-Id: b83e7a0b-7a15-4322-7ba6-08deef0292b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|23010399003|1800799024|7416014|376014|6133799003|3023799007|56012099006|11063799006|4143699003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	FMjlM1t+Aytkk5Yr5y+pM8Zd/HQsvWCQLrnny3WRFzcV4M9nhddhOpqKRumKkETd481eE78O0qeXcDjHy0bU3b8R+3/zjCyr6gcahN3b4MpgzgMAd5gbsU6IWVq8sMhpvwMy7qbFUY0mBgYV9+ZFH7s7bJC8qlIpsVmrDUsvRo48Y4ytdlJfA68Gto8js39RRT2Okz9NTl60/ExQLDxJGF0PFWsa7hsVgEBWj6DbcGixRjQQKC8UwzzMyMgVVJvhSU3Wmt+4WNTilFCxOZxIVVf48tKkohEgEALWtxhTa+c2tfzBJWc3X/xC0VGWXzBHL50RNuv4YcULwqP4Za27W+Noy46eTQ8GTxHp/AqCB23jmjfuehSSFdHKYPzUn37xqH77ZkIiGCUBaw1hj3Et+sKGAizsa6tgBazllnMdvLa4z/1gPB4DTeFaSxvQCDlDyq2IrlsP3nt8G9Pq+2fmHSFvMqQT6NAuMr6af6nHNAxSfpIbuLJBWbOhAGlPJ0gYhOWg6Sv3EkxvGbv8lHSZ1fngRzfHAxKTp0KPef7o9/5UUYtz8bwzpi1yR7isAXVxTxqjYm/LZbOw4Vpmj21huDQr0T+gXrh+IOCC3xRF91l4+1r67MwandcyEWOs1dnrobhFUQQzE5ejhQkpMNpgQtbaTjdvE1UNQ0qCgZIJWg4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3997.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(23010399003)(1800799024)(7416014)(376014)(6133799003)(3023799007)(56012099006)(11063799006)(4143699003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bWdzOHVuTXI5cERXVWlQZ2xoZUNlYVJxNXczaG5NSXIyMmVRclh1bUVhd1By?=
 =?utf-8?B?aVcyS0luQ0xhL2tDb0I5ZWxVUEVkMDltQWNiM2trRzY4RjNoWityV2JyeWhK?=
 =?utf-8?B?enBNQlA3U3ArWXBlT0E1U2QvaHRhVTYrYitvYTI4RkY0MVJtNWxRWkpyNkFS?=
 =?utf-8?B?TkNjNXQyQWlNd3VZcGVJaXpxQjdkMU92NjdhOS9rb2t0RndxWWlabkF5ZFpJ?=
 =?utf-8?B?UkxiTFI4U0VvdHlKY3hLV0s1Q2xpeko3TzZlUDZKbVpWL3h6S0dFOHluRVdH?=
 =?utf-8?B?cFlBWEhzUzY1bXozYjBxQUg4MWowVjJibG5uVzc5NXVocm1BS1lKZ1UzbDJz?=
 =?utf-8?B?dzR1SXUzN1pHZldxa0VXenB2b0hBY0wxNHFub2htUFNhTEpxZkZGYm04MERt?=
 =?utf-8?B?N0VYNkw0RWo1R0FWSkptUnJOalByU1ovSCs3dlY1MG93RTNYK2tubXVVeXJM?=
 =?utf-8?B?VVRoWFN0M0RLcVREcWpIZWZDbUNFeHdvKzFxcjBKamZhWE55bE5oYmhBVFJy?=
 =?utf-8?B?YWs4MHJZakE2KzZIYWdsdEpuQUVyN0FNZ1hoem5YcVdRR2ZhT3g4by9MQ3Nh?=
 =?utf-8?B?L3dIQ3NBL2JBRWF1OVhJWk9VcmlaMUY3dzdHZW82ejcwcW4wajBSWFVCUjY4?=
 =?utf-8?B?b09XVXpWMGgyZGNTRVBFWllNZERMUGgxdndrMjVWd2FidHZkRUZNZzVTeGRD?=
 =?utf-8?B?QWNRMWVKODJHVGdXSnp4WitrMmt6S2h4NmFUYWNPVzVBV2xvdUc1OEc2ZlRW?=
 =?utf-8?B?akdjY1dsc1dmT0htWElzUHYvbDErMnJ2UkQ2SDBycGZaSktyYlk3NWI1QkNp?=
 =?utf-8?B?MERxMHNYK1ZTeEw0MGlDYytNRkhWR3JtclZ6V2VTcmV4SzVOVWo0UUQyejkz?=
 =?utf-8?B?b0hnQSs1VCtjQ3BidmJSdjlOakV6NEJFMlhRMFpDS2M2eHFQK1NWUldXTUk1?=
 =?utf-8?B?NWJIeDhOT1FvRGpicm1nUDhoRzFidDl0V08veEFzOVU5a3JRM2NoeThpYnB1?=
 =?utf-8?B?M1VoQnZZNHFQcG53VjUxWm5UM0lNNkR2MnQydDI5NVBDekNLTGZwSzhCaUFC?=
 =?utf-8?B?bkU3YVFpd1IxQWMrTnpTbUJpL1FMejBkVERNSTNTRnZTK2ljNE9heWduQUhY?=
 =?utf-8?B?bldBSFV5OG1sNi9lU1dHM25hbWxJb21xUlkrc2pFMVBQNWY2N3VJcm41Zi9S?=
 =?utf-8?B?cVBjUG9aRER1YjREeXlWditNZ0FWTUUzbHpDdzF3RWhwSERiVG0xSDN4c1dn?=
 =?utf-8?B?VFZSUHV2V21yb2pUQ2cvYmVIY1d5eEttVXp0SEthNG0yNzNEY2xhK1RydklP?=
 =?utf-8?B?WExuMy85NW9WYjlVdnY1YVV5K0dRUzlPN3Vmc2QvWGhmWmhGeXU5eGlubFlP?=
 =?utf-8?B?dUlxR01NbUUrMUxZSjZyZ3ZNZU5WenBHQitZUENSVENrRzNxRFJQQngyOERW?=
 =?utf-8?B?TGlmdDNTbi9sU3VrUjU2WUcrZ25BdU1EUjFKTkNtYlVXT0xFTWl5WmVNM0Nr?=
 =?utf-8?B?SGpPOHBlKzM4cE5yNDNua1B2OW4rdXM2ajdXVlJqYzQyL2FoRXBkR0pnWU1N?=
 =?utf-8?B?WW5iYkFnMUJCWFFONkg2b2JkckttU3FZNUVXZ0phOTFySkwvKytuRDE1K0wy?=
 =?utf-8?B?NEJGOExGY2E4RlFpVzVVUUs3b2MrQ0FaZ0Q3c2NjWHNQTkFwd3dDbVppdGlz?=
 =?utf-8?B?ZHhOUTIwcGF1TThuRDZqamtEWW9wbEUrS3ZJYU9USTNQUUtLZWJPYzNiYzlu?=
 =?utf-8?B?QjduMFF3ZzVITTRuWDlFL0RhZ01aSHc1ZXVTZGl2RDFSejg1R2xOL0pBRTVo?=
 =?utf-8?B?UklQd3YzZ0hZZXJ4c0RCUmRPTDZYTEJXM3R5WjdaS2FlTDZkMXlSdUZOWkNJ?=
 =?utf-8?B?aFNqZkswSWpGdlhLRjhYNlVsN29SM3hDdkltTTZ5TW5hMFFpeEVtVU1qZE5a?=
 =?utf-8?B?TlZBcFl4eGY4eEZtUEl3dXYvckNPN1hoYm5GQklXVmppVXFVSDlmYVRRSUs5?=
 =?utf-8?B?ZEZyaGtub2FvOWIxSmtiazFFQ3VnaW5JQkVUaEV3VjNwQ2w2aXgzS3A0UGFX?=
 =?utf-8?B?YnFldjY1ZERYOXhDZzRTTHFxWVZNeGdUQitnbDhURnhIZ3pwcERBQjlTeEVR?=
 =?utf-8?B?MStzVkhkNERpcXI1OEJaRzJCNFBFV0EvdjdEMy9TeThjb0NXLzhsMUkzUlUw?=
 =?utf-8?B?TDlsL0sweDZlNEpoM0dPZlhKdURORSs4bmxzQ0RuQ21aNXZYbFlEcjRERW1j?=
 =?utf-8?B?OXY4RHhjcndkTjRXdURtSElyZldoU29keTRUUWNUQXZUaEc1blpqd1NvTG5n?=
 =?utf-8?B?eGJZQ2Z5R3c2RUNsaDhiU0hFYnF4MnNNSmQ0dmhzR1NOeGhOck5yTTBsRDJz?=
 =?utf-8?Q?HTLefX4pyjdhwX2CdAMoy7Yfapsy8ef3egW0C9gtMKVmu?=
X-MS-Exchange-AntiSpam-MessageData-1: JI5crz5yASaZyQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b83e7a0b-7a15-4322-7ba6-08deef0292b3
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 12:52:26.9110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ptL7YBLkxxsXynm5SkflE/yAuJjF1P/RJi+qeKlOSPEPFAVxS/9Vf+wwm0tM6jWo1W0pvhoG/bsSFwZyMFWjzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6258

On Fri Jul 31, 2026 at 9:38 PM JST, Gary Guo wrote:
> On Fri Jul 31, 2026 at 10:57 AM BST, Alexandre Courbot wrote:
>> On Fri Jul 31, 2026 at 3:45 AM JST, Gary Guo wrote:
>>> On Thu Jul 30, 2026 at 7:29 PM BST, Zhi Wang wrote:
>>>> Rust PCI drivers have no typed interface for locating and accessing PC=
Ie
>>>> extended capabilities.
>>>>
>>>> The SR-IOV extended capability describes VF topology and VF BARs. Expo=
se
>>>> this information through the Rust PCI abstraction so drivers can use t=
he
>>>> existing typed configuration-space accessors instead of raw bindings.
>>>>
>>>> Define ExtCapability to associate a capability ID with a register layo=
ut,
>>>> and add ConfigSpace::find_ext_capability() to locate and project that
>>>> layout. Bound the view at the next capability or the end of extended
>>>> configuration space. Add ExtSriovRegs and a decoded VF BAR helper that
>>>> returns the address, width, and next configuration-space slot, using
>>>> PCI_SRIOV_NUM_BARS for the number of BAR slots. Since PCI_EXT_CAP_NEXT=
()
>>>> is a function-like macro, expose it through a Rust helper.
>>>>
>>>> Link: https://lore.kernel.org/rust-for-linux/20260730180349.771719-1-z=
hiw@nvidia.com/
>>>> Cc: Alexandre Courbot <acourbot@nvidia.com>
>>>> Cc: Gary Guo <gary@garyguo.net>
>>>> Signed-off-by: Zhi Wang <zhiw@nvidia.com>
>>>> ---
>>>>  rust/helpers/pci.c     |   5 +
>>>>  rust/kernel/pci.rs     |   8 ++
>>>>  rust/kernel/pci/cap.rs | 236 ++++++++++++++++++++++++++++++++++++++++=
+
>>>>  3 files changed, 249 insertions(+)
>>>>  create mode 100644 rust/kernel/pci/cap.rs
>>>>
>>>> diff --git a/rust/kernel/pci/cap.rs b/rust/kernel/pci/cap.rs
>>>> new file mode 100644
>>>> index 000000000000..08c044bedb70
>>>> --- /dev/null
>>>> +++ b/rust/kernel/pci/cap.rs
>>>> @@ -0,0 +1,236 @@
>>>> +// SPDX-License-Identifier: GPL-2.0
>>>> +
>>>> +//! PCI extended capability support.
>>>> +
>>>> +use super::{
>>>> +    io::ConfigSpaceBackend,
>>>> +    ConfigSpace,
>>>> +    Extended, //
>>>> +};
>>>> +use crate::{
>>>> +    bindings,
>>>> +    io::{
>>>> +        Io,
>>>> +        IoBackend,
>>>> +        Region, //
>>>> +    },
>>>> +    prelude::*,
>>>> +};
>>>> +
>>>> +/// Number of VF BAR register slots in an SR-IOV capability.
>>>> +// CAST: `PCI_SRIOV_NUM_BARS` is 6, which fits in `usize`.
>>>> +const NUM_VF_BARS: usize =3D bindings::PCI_SRIOV_NUM_BARS as usize;
>>>> +
>>>> +/// Attribute bits encoded in the low DWORD of a memory BAR.
>>>> +const VF_MEMORY_BAR_ATTRIBUTE_BITS: u32 =3D bindings::PCI_BASE_ADDRES=
S_SPACE
>>>> +    | bindings::PCI_BASE_ADDRESS_MEM_TYPE_MASK
>>>> +    | bindings::PCI_BASE_ADDRESS_MEM_PREFETCH;
>>>> +
>>>> +/// PCI extended capability IDs.
>>>> +#[repr(u16)]
>>>> +#[derive(Debug, Clone, Copy, PartialEq, Eq)]
>>>> +pub enum ExtCapId {
>>>> +    /// Single Root I/O Virtualization.
>>>> +    // CAST: `PCI_EXT_CAP_ID_SRIOV` is `0x10`, which fits in `u16`.
>>>> +    Sriov =3D bindings::PCI_EXT_CAP_ID_SRIOV as u16,
>>>> +}
>>>> +
>>>> +impl ExtCapId {
>>>> +    fn as_raw(self) -> u16 {
>>>> +        self as u16
>>>> +    }
>>>> +}
>>>> +
>>>> +/// A typed PCI extended capability register layout.
>>>> +///
>>>> +/// Implementors describe the register layout of one extended capabil=
ity. The layout must start at
>>>> +/// the extended capability header, and [`Self::ID`] must identify th=
at layout.
>>>> +pub trait ExtCapability: FromBytes + IntoBytes {
>>>> +    /// PCI extended capability ID for this register layout.
>>>> +    const ID: ExtCapId;
>>>> +}
>>>> +
>>>> +impl<'a> ConfigSpace<'a, Extended> {
>>>> +    /// Finds and projects an extended capability into its typed regi=
ster layout.
>>>> +    ///
>>>> +    /// # Examples
>>>> +    ///
>>>> +    /// ```no_run
>>>> +    /// use kernel::pci;
>>>> +    ///
>>>> +    /// fn probe_sriov(
>>>> +    ///     pdev: &pci::Device<kernel::device::Bound>,
>>>> +    /// ) -> Result<(), kernel::error::Error> {
>>>> +    ///     let sriov =3D pdev
>>>> +    ///         .config_space_extended()?
>>>> +    ///         .find_ext_capability::<pci::ExtSriovRegs>()?;
>>>> +    ///
>>>> +    ///     let total_vfs =3D kernel::io_read!(sriov, .total_vfs);
>>>> +    ///     let vf_offset =3D kernel::io_read!(sriov, .vf_offset);
>>>> +    ///     let bar0 =3D sriov.read_vf_bar(0)?;
>>>> +    ///     let bar1 =3D sriov.read_vf_bar(bar0.next_index())?;
>>>> +    ///
>>>> +    ///     Ok(())
>>>> +    /// }
>>>> +    /// ```
>>>> +    pub fn find_ext_capability<C: ExtCapability>(&self) -> Result<Con=
figSpace<'a, C>> {
>>>> +        let offset =3D usize::from(
>>>> +            // SAFETY: `self.pdev` is valid by the type invariant of =
`ConfigSpace`.
>>>> +            unsafe {
>>>> +                bindings::pci_find_ext_capability(self.pdev.as_raw(),=
 i32::from(C::ID.as_raw()))
>>>> +            },
>>>> +        );
>>>> +
>>>> +        if offset =3D=3D 0 {
>>>> +            return Err(ENODEV);
>>>> +        }
>>>> +
>>>> +        let size =3D self.calculate_ext_cap_size(offset);
>>>> +
>>>> +        let base =3D ConfigSpaceBackend::as_ptr(*self)
>>>> +            .cast::<u8>()
>>>> +            .wrapping_add(offset);
>>>> +        let ptr =3D Region::<0>::ptr_try_from_raw_parts_mut(base, siz=
e)?;
>>>
>>> The signature should be=20
>>>
>>>     Result<Option<...>>
>>>
>>> where the result is usually handled via `?` and `None` needs to be hand=
led
>>> explicitly, rather than matching on ENODEV.
>>>
>>>> +
>>>> +        // SAFETY: `offset` was returned by `pci_find_ext_capability`=
, and
>>>> +        // `calculate_ext_cap_size` bounds `ptr` at the next capabili=
ty or the end of the extended
>>>> +        // configuration space. `ptr_try_from_raw_parts_mut` verified=
 the region layout.
>>>> +        let capability =3D unsafe { ConfigSpaceBackend::project_view(=
*self, ptr) };
>>>> +
>>>> +        capability.try_cast::<C>()
>>>> +    }
>>>> +
>>>> +    /// Calculates the size of the extended capability at `offset`.
>>>> +    ///
>>>> +    /// The capability extends to the next extended capability, or to=
 the end of the extended
>>>> +    /// configuration space if it is the last one. `offset` must be a=
 DWORD-aligned offset within
>>>> +    /// the extended configuration space returned by `pci_find_ext_ca=
pability`. If its header
>>>> +    /// cannot be read, the capability is treated as the last one.
>>>> +    fn calculate_ext_cap_size(&self, offset: usize) -> usize {
>>>> +        let header =3D self.try_read32(offset).unwrap_or(0);
>>>> +        // SAFETY: Pure bit manipulation, no preconditions.
>>>> +        // CAST: The next-cap pointer is a 12-bit field (max 0xFFC), =
always fits in `usize`.
>>>> +        let next =3D unsafe { bindings::pci_ext_cap_next(header) } as=
 usize;
>>>> +
>>>> +        if next > offset {
>>>> +            next - offset
>>>> +        } else {
>>>> +            (*self).size() - offset
>>>> +        }
>>>> +    }
>>>> +}
>>>> +
>>>> +/// SR-IOV register layout per PCIe spec (64 bytes starting at cap of=
fset).
>>>> +#[repr(C)]
>>>> +#[derive(FromBytes, IntoBytes)]
>>>> +pub struct ExtSriovRegs {
>>>> +    /// Extended capability header.
>>>> +    pub header: u32,
>>>> +    /// SR-IOV capabilities.
>>>> +    pub cap: u32,
>>>> +    /// SR-IOV control.
>>>> +    pub ctrl: u16,
>>>> +    /// SR-IOV status.
>>>> +    pub status: u16,
>>>> +    /// Initial VFs.
>>>> +    pub initial_vfs: u16,
>>>> +    /// Total VFs.
>>>> +    pub total_vfs: u16,
>>>> +    /// Number of VFs.
>>>> +    pub num_vfs: u16,
>>>> +    /// Function dependency link.
>>>> +    pub func_dep_link: u8,
>>>> +    _reserved_0: u8,
>>>> +    /// First VF offset.
>>>> +    pub vf_offset: u16,
>>>> +    /// VF stride.
>>>> +    pub vf_stride: u16,
>>>> +    _reserved_1: u16,
>>>> +    /// VF device ID.
>>>> +    pub vf_device_id: u16,
>>>> +    /// Supported page sizes.
>>>> +    pub supported_page_sizes: u32,
>>>> +    /// System page size.
>>>> +    pub system_page_size: u32,
>>>> +    /// VF BARs (BAR0=E2=80=93BAR5).
>>>> +    pub vf_bar: [u32; NUM_VF_BARS],
>>>> +    /// VF migration state array offset.
>>>> +    pub migration_state: u32,
>>>> +}
>>>> +
>>>> +impl ExtCapability for ExtSriovRegs {
>>>> +    const ID: ExtCapId =3D ExtCapId::Sriov;
>>>> +}
>>>> +
>>>> +/// A typed view of an SR-IOV extended capability.
>>>> +pub type ExtSriovCapability<'a> =3D ConfigSpace<'a, ExtSriovRegs>;
>>>> +
>>>> +/// A decoded VF memory BAR.
>>>> +#[derive(Debug, Clone, Copy, PartialEq, Eq)]
>>>> +pub struct ExtSriovVfBar {
>>>> +    address: u64,
>>>> +    is_64bit: bool,
>>>> +    next_index: usize,
>>>> +}
>>>> +
>>>> +impl ExtSriovVfBar {
>>>> +    /// Returns the BAR address without PCI attribute bits.
>>>> +    #[inline]
>>>> +    pub fn address(&self) -> u64 {
>>>> +        self.address
>>>> +    }
>>>> +
>>>> +    /// Returns whether the BAR is 64-bit.
>>>> +    #[inline]
>>>> +    pub fn is_64bit(&self) -> bool {
>>>> +        self.is_64bit
>>>> +    }
>>>> +
>>>> +    /// Returns the configuration-space slot index of the next logica=
l BAR.
>>>> +    #[inline]
>>>> +    pub fn next_index(&self) -> usize {
>>>> +        self.next_index
>>>> +    }
>>>> +}
>>>> +
>>>> +impl ConfigSpace<'_, ExtSriovRegs> {
>>>> +    /// Reads and decodes the VF memory BAR at configuration-space sl=
ot `bar_index`.
>>>> +    #[inline]
>>>> +    pub fn read_vf_bar(&self, bar_index: usize) -> Result<ExtSriovVfB=
ar> {
>>>
>>> Do you expect people to pass in a random index instead of 0 or next_ind=
ex? If
>>> not, this should be an iterator. Otherwise it'd be possible to index in=
to high
>>> part of 64-bit address.
>>
>> I made a similar suggestion on patch 3 [1], and I think Zhi kept the
>> index for ergonomic reasons. But given that not all indices within range
>> are valid, an iterator indeed sounds safer.
>>
>> [1] https://lore.kernel.org/all/DHRTUAF52GNI.1J98TSAG1LS6Q@nvidia.com/
>>
>>>
>>>> +        if bar_index >=3D NUM_VF_BARS {
>>>> +            return Err(EINVAL);
>>>> +        }
>>>> +
>>>> +        let low =3D crate::io_read!(*self, .vf_bar[try: bar_index]);
>>>
>>> Given the bound checking above I'd use `panic: ` here.
>>
>> Or better, one could just remove the `if bar_index >=3D ...` block, and
>> keep the `try:`. That way it will be used for what is was designed for,
>> the bounds checking will be done against the actual size of the array
>> and not a constant that also happens to be used as the array size, and a
>> dedicated error code will be returned instead of the ubiquitous
>> `EINVAL`.
>
> `projection::OutOfBound` converts to `ERANGE` so it'll be different. Also=
, when
> this is converted to iterators, for the first case you'd probably want to=
 just
> return `None` and for the second case log an error that the device is hav=
ing out
> of spec capability.

Yeah iterators are probably going to make this moot anyway.

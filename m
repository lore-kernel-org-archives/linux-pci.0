Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012048.outbound.protection.outlook.com [40.93.195.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D021E885A;
	Sun, 21 Jun 2026 09:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782033439; cv=fail; b=eFJi0UWbaFaTOgYphvH8zHlKuWzKQ6GPrsoMEs/aYWOEhotUrk59DeAaNYgANbhyu68iwTtqO2kgzQfYTDhJ/rFPgdLBjjKsJGX7B5MdiyTYtjaXXX2660g+b85DDBIO/PChqr3+huObzMJ/MU4DRePrKsb3PT2hWn06mx/Zxo4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782033439; c=relaxed/simple;
	bh=VCaVJn6CoGbnW1NZCtbLcbQpSM/phfIeNWTX7cKt5HI=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=M19MejNGR/VMd93bLaQNW04rt6BzfbCTu1poONocRQ0HaS8iWN6rQHAnyEBNFhavV1W2ZzsTS0XbJ6dMGXmMbJ/iCpTL3xnNZumS6vIbLLKj7IZ555Goi3ZBErxaS9k29TiymcZjLuatACnPXTy6U+5VVxl8HI1kKTiVwCjsyGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KEFgXn8C; arc=fail smtp.client-ip=40.93.195.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KEFgXn8C"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ron7ui/DLwx9n4UkoHtavV6zYNtfiRAiarvAAGiG3GeVxGKD/P6YJ/OROtrpRznNPonbyRhaDc0hUB2oLN81zRYMHfEBUg9SVOzXSdH59x2FAZgiFnzQJlSsFi3ZiSYfLY5htTNLdecopK9QYvDnof53q8GNg1ebYIAsF54qsUqL61aenTA7QFlVUnlVanbMRhnW+QqbtfdyS5Mqd6T9DymSlq6/Yrdned4qtA9shfbXSbFtPWldDxjjpFt61esTp4ydeENU6fG7CUztXzFOmhy4BDakYZZ1nqv6hH0e8xnDtrUz+zwoE+ROhCGkhTLM6GKyN0pOLnP1yoM43a0QfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p6Pi7+aqwuPyeqCt7tA3XwkbMoUjbqVopEkDHmSmP0Q=;
 b=ykTlZ4RE41VsVjaP49EXYKGPUoDLllfq+ETmOnyFUYobwz6fXprz3JNSqJ+vUy3jjb8DTb1/q0nqkd30FvFB+FQIvn74cj66KzPIvugsdMVo32ByXsgza9D0mFhYre4mNc23w4ZfhWPJlSxm5BLJ2BOgJOa5J7rvC8yZxnVJI4Iz7T2dHKla9Qi5MVSRcmieTDuJKAwji7GxEqAZOpCSYCsPC1ill1GzSgNkMgRUflZkD0J73V4bz5NHsH2knZHnpKMzawtpXFHfB2wcJRypthJ/zeyTWUAlgjXCmAQ8funC7OUWN/PicaMCcweSYrr33al7OQSe2/iIiAXQT8eqjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p6Pi7+aqwuPyeqCt7tA3XwkbMoUjbqVopEkDHmSmP0Q=;
 b=KEFgXn8C0ZQAq9ltQCmbcv/1900YwQmS7YFo//9VWTMA1Q+Jz2atnGLm3ybbMiRH1T1CBIEak/u00kSoApKAXjjFAvTtoFoyaEOB1WhfbPjKrCeT3U73jAPSFs4FCWYSvpDN+JpuvPU6kbhwxwNHTbv6nRiESLGTQVTAUt5Wom8Fg8Ew7n0Xt5jEGtWyQZ07Pl6qE8zUCLUY2agDZHc2zz89d5KcFePnT/MTIUQqDHmqlX1nUR6iwcIHNxr2v0cO8m04w3z7g+Ac1FdXyfg0QMsk9YPjkDshrbYMQxSlyyOtr6QygancZOnyhdI1MF0YpgqGLOCHHut47cSsavaYTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DS7PR12MB8230.namprd12.prod.outlook.com (2603:10b6:8:ed::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.19; Sun, 21 Jun 2026 09:17:11 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0139.018; Sun, 21 Jun 2026
 09:17:10 +0000
Content-Type: text/plain; charset=UTF-8
Date: Sun, 21 Jun 2026 18:17:06 +0900
Message-Id: <DJEM4MAO7RON.1EC4OJM72BCNB@nvidia.com>
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Abdiel
 Janulgue" <abdiel.janulgue@gmail.com>, "Robin Murphy"
 <robin.murphy@arm.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Danilo Krummrich" <dakr@kernel.org>,
 <driver-core@lists.linux.dev>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v4 09/20] rust: io: use view types instead of addresses
 for `Io`
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>
Content-Transfer-Encoding: quoted-printable
References: <20260611-io_projection-v4-0-1f7224b02dcb@garyguo.net>
 <20260611-io_projection-v4-9-1f7224b02dcb@garyguo.net>
 <DJAJ51781EOF.1Q2VTH6CQVXYD@nvidia.com>
 <DJAK39S4J6EP.2VY3R7CIBAPOL@garyguo.net>
In-Reply-To: <DJAK39S4J6EP.2VY3R7CIBAPOL@garyguo.net>
X-ClientProxiedBy: OS3P301CA0046.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:604:21c::6) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DS7PR12MB8230:EE_
X-MS-Office365-Filtering-Correlation-Id: 38d840b6-61cb-4317-08aa-08decf75df8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|23010399003|366016|7416014|376014|22082099003|18002099003|6133799003|5023799004|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	qEihtLEE1uIF1IFippXPlqRlFWL3t0edwY56hd6w0NYfHqFMRI/hk1OU/2MePHs1PQegFzJXWWvV5yUXk2KqbOhvZoBurm2v9VHVYMs/I3hDcIOV3el3dZ4c/MipH3jA7BIuvgTtt0tbmr9QvGCeE0EtG5LCJ6tYxsQf6jNsh1v4R9Q2jKiHjvIdKjoCm8JOsikfEbYrbf3Kfgt65UxEd+GtuHxxT6QsO2hl7MX7M39+0rulaHGmYwNOiy1C3mt+6Z5eHAmCdHa3AtGuXh9Yju7wF9rWiC6xe3rhLRYGfXz0uKJGmOx3y7bS2fh+U4Z3pLdz4PpKQq+hTp4XHBmiNyYv5ZUEkXXSKDqGzWFiuHJwUuAV7RdiQErg4wHAq7yJKvm+1mTXN6L3D6VK1wf4ISxMA93mFicAfyNoSerhWvgh102eSdMKL7378QsVej7pyly2m5KNqD3jPBo9PgCqcWcPGs04+zKXc9V+IpJRdtVg+UFMR4DPxlRsNWIwCC/hEv1TCo7rk7ZfNes4X03onqA25a19QWAnJbvQXO2K3NZ/d7/c52Wpa+5nyf/igJNetSRRqRFgHFa0zW9is0sZenEUAS7u2ottuAUNtJ+hdGUFPh1rGEoos1Z0esr1n4U2q/g2QVNvor53P8rROlCL9HbtCyrYHEMbfrRZc6Rgk5A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(23010399003)(366016)(7416014)(376014)(22082099003)(18002099003)(6133799003)(5023799004)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WVFFK1dYLy9UUXVqSlB1VjZjQndSOGlKQWhmYjhsWnRxbEo4b01iTW1jbFVm?=
 =?utf-8?B?R2lnVVdjQmlsR2pVYmtGanFiYmI1dTB6TmhQcGdaV2QrWXhOQSt4RFNUSWVn?=
 =?utf-8?B?a3BTMWZOcTc3eWNPWVdEVWpYeCtLZWRmSDROUE93QkN0T240am52VkV5YmVC?=
 =?utf-8?B?SGJjOHlxMkFKTTRZRTk3KzBZaklLOW5qZW9zYUJDZHpsN0w3MTRPZ3E1TU0w?=
 =?utf-8?B?TzVYNnRIdG9zNWFoWVA5QVpNelM4aEptaStiSVJtM1R0dW1yZERnWVcyeTNP?=
 =?utf-8?B?T2NkMis2K1o4aW5OY0RaSkNHTDZ5K3RPSWt6VTNuVWRMQjMrZy9ONVlQM3h4?=
 =?utf-8?B?eVhwakZ0ZDRxRDhxS0hZZ1c2bkI5eU4zSmhlSThCcW00dU9zekdvcy9hQWZq?=
 =?utf-8?B?NnRhM3J5Ni9TLzJWVGVyQmtHR3YvcUpQT0tFTUVtWDEyUEs5STgwbFY2OG5y?=
 =?utf-8?B?U0RERDBtVU54NU5vdUIwSVQ4QjNTcUMzdnVwTzFmQ0IreW1vclBCMXFtNEs3?=
 =?utf-8?B?cDdYb2puNWdkcmtXTWdaMHE3cTdFaXZ6aGEvL04vR3YvaUhqWGNCWGxsMGMy?=
 =?utf-8?B?dldvbkUxV3VCUnlsNE5TRnpBdDF0MnRvdkRZbEVpOXNHNWZNVHlUQlY5d2RM?=
 =?utf-8?B?TUprZ3VTUHkwNDRadjNBcVROOE5wRnl6S0JkcEs3VWdzcHVsOXg0Mi8zVmkv?=
 =?utf-8?B?cWpFOElFRm4yMm5VaVg4T0JUNmcvNkh0M0RocDhmTFVYM3QvQTV2ZWVnTUJt?=
 =?utf-8?B?QzJvWHlXdXlUa1l6NmlOdVdTVU9wT2ZhUTRIZzVDRjRLTXF5b1g3Wnk2TklG?=
 =?utf-8?B?dHZNMEp1STJreDRPM1hlNlJkamtyNFJMODFDcXZKYXZJTVVJV25XVXFydFBp?=
 =?utf-8?B?bXB1MmxERFRoYnFrYWpacnJFSStXeXI4bS9kNkFWZUN0VVpaZUlPYmtyejNw?=
 =?utf-8?B?T2VDU2xieDZ5TGEwaDZvVFRNd1VsQW9JK1IxTkswY0pET0phM0RqYjFJNDRl?=
 =?utf-8?B?Znc5dzcwU2lkU2dDOENPZjZXdHFSbmxTUUFrSXdGK0xrQks1Q2N3OWp3UHpm?=
 =?utf-8?B?U1BJWDY1V0x3SWt4S1hQL1BQV2xRMWs1VVR1WFk2ejV4dWFQREhZOHd2TDZ4?=
 =?utf-8?B?czh4MlU3VmJmNVMremFPTFl6V0o1L1VHRElEUk9GZk90ajJ6MEJwVkNKdVRI?=
 =?utf-8?B?MEdXajZTTDhrVWNzWFV5Z2NNS09wUGlSbGFkZ0VCbWtCcnVxUjI1OW5rRlJm?=
 =?utf-8?B?dFBUQ0RIVVVZZkNzRUhPNGxkb1NCZGtKSFpGZXpXeVlSTFFPZVYzM0w3OFZr?=
 =?utf-8?B?b1NsTGxGMFZRbHlBN01lenZLRG50bEtOREh6SWRnOHlNZXZBeDg4emJuS1BD?=
 =?utf-8?B?RGE2T1FrbXhTdE5OTFh3anVrTGFIT05pQ2M2SVN4c25QMGZackxVSVFvei90?=
 =?utf-8?B?RG52WCtvS3lpVUxjandYNm81YWxyTVFDbVdDcVVnMkJkTWgxTCtOOUExbUgz?=
 =?utf-8?B?WkhvWXBhdjRGaUdKZkNodldlUkwzUmxtWDZoTUszUVBMYUxuKzBjdFBmSGlT?=
 =?utf-8?B?STBLK0ZveGRsUk9wYjByZmcwYjFpNHFscU5lU05FWVhjRUw0ajIwcFpXbTd2?=
 =?utf-8?B?cnh1clh5NUpIbnBjS0ZENXVTY0xmelZFN1gxalVPRUNXeW1Gd3hpaDlobmhW?=
 =?utf-8?B?ZU5EdXF6ZTc5OWoyNDhScVRuT1ZjdndqUzVnRFdzOHZQUitJY0VTREE3OHkz?=
 =?utf-8?B?U1hTU01RWS9xMjg1L1ZkSmN3Rkhpdis2MlJTR1FFT1BuN0dCUXVPRmpLK3Zw?=
 =?utf-8?B?OExSMVFCbzhMK0pONE5VVC8yWkFPb1RTNHNBUVkvemdxQWxBbFlyOUl0alQr?=
 =?utf-8?B?QjROaFlIVjZmdmV1TkhKcDRjRXlPMnpYRXUrQThEaFErb0phRExGWXNBRWQx?=
 =?utf-8?B?eXoycjVZcUZFZzFFY1hRQTFSUzcxc24rdXFsdGVBN1BHOWplZ0tPSFlqOXJz?=
 =?utf-8?B?TnBjZXlZZ1Vvb0VNMUpNVFVHZWFla3FXd283S2lKSE9PK0x3Q3pLYmROMXZM?=
 =?utf-8?B?RTNhVHNzWDQ3YUZkS25zOHpEMldqbFdhLzJWR3diZHZKS2tiVVVSM1Z4bWVC?=
 =?utf-8?B?QU84bFdpTlBMSDRrOXhKVUtJbitGZEpaNVVRdmRkQmx4LzRaaEpHZnZuMlcx?=
 =?utf-8?B?VmdQYmNIOEhCTk82RFlDWVJCYjNKQ1JTbHBTbjhxYnFOMFZVOXVvTXQyNUU4?=
 =?utf-8?B?ZUxTejVhdWRsVUdpc0VNZkN6WFZHZk5DT2JZYVE2WTlXc2txOGptU0sxVFN2?=
 =?utf-8?B?YzdwY3BQVEtyTENvdUtKYnlid1RNelQwYnJJMG5SdnpKbVpsZSsyTjZrbGZu?=
 =?utf-8?Q?Cvpdwi2pNWU55+ni2NffTdNuiE32Z/wVuNFFi4QR57UJ6?=
X-MS-Exchange-AntiSpam-MessageData-1: 1N1b4w9sxBUktA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38d840b6-61cb-4317-08aa-08decf75df8c
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2026 09:17:10.8436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GfXSH76Q/02JHwWsPMjkLJ4YFhwO42KI5Ic/dHhQZWswt8iBVtWa9+Q/YGeIajPLp/UAPtzsDBZjU1BXNVUFSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8230

On Tue Jun 16, 2026 at 11:50 PM JST, Gary Guo wrote:
> On Tue Jun 16, 2026 at 3:05 PM BST, Alexandre Courbot wrote:
>> On Fri Jun 12, 2026 at 1:28 AM JST, Gary Guo wrote:
>>> Currently, `io_read` and `io_write` methods require the exact type of `=
Io`
>>> plus an address. This means that they need to be monomorphized for each
>>> different `Io` instance. This also means that multiple I/O implementors=
 for
>>> the same I/O kind needs to duplicate implementation (e.g. `Mmio` and
>>> `MmioOwned`).
>>>
>>> Create a new `IoBackend` trait and define these operations on it instea=
d.
>>> The operations are just going to receive a view type and operate on the=
m.
>>> This has the additional advantage that the invariants can be moved from=
 the
>>> trait (and guaranteed via `unsafe`) to type invariants on the canonical
>>> view types of the backends, so `io_read` and `io_write` can be safe.
>>>
>>> Note that view type is needed; addresses are insufficient in this
>>> designk, as they do not carry sufficient information. For example,
>>
>> typo: design
>>
>>> `ConfigSpace` needs `&pci::Device` in addition to the address.
>>>
>>> Signed-off-by: Gary Guo <gary@garyguo.net>
>>> ---
>>>  rust/kernel/io.rs     | 345 ++++++++++++++++++++++++++----------------=
--------
>>>  rust/kernel/pci/io.rs |  70 ++++++----
>>>  2 files changed, 224 insertions(+), 191 deletions(-)
>>>
>>> diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
>>> index 3ac8b396f5a7..e422a5ff2a5e 100644
>>> --- a/rust/kernel/io.rs
>>> +++ b/rust/kernel/io.rs
>>> @@ -244,6 +244,38 @@ const fn offset_valid<U>(base: usize, offset: usiz=
e, size: usize) -> bool {
>>>      }
>>>  }
>>> =20
>>> +/// I/O backends.
>>> +///
>>> +/// This is an abstract representation to be implemented by arbitrary =
I/O
>>> +/// backends (e.g. MMIO, PCI config space, etc.).
>>> +///
>>> +/// The base trait only defines the projection operations; which I/O m=
ethods are available depends
>>> +/// on which [`IoCapable<T>`] traits are implemented for the type. For=
 example, for MMIO regions,
>>> +/// all widths (u8, u16, u32, and u64 on 64-bit systems) are typically=
 supported. For PCI
>>> +/// configuration space, u8, u16, and u32 are supported but u64 is not=
.
>>> +///
>>> +/// This trait is separate from the `Io` trait as multiple different I=
/O types may share the same
>>> +/// operation.
>>> +pub trait IoBackend {
>>> +    /// View type for this I/O backend.
>>> +    type View<'a, T: ?Sized + KnownSize>: Io<'a, Backend =3D Self, Tar=
get =3D T>;
>>> +
>>> +    /// Convert a `view` to a raw pointer for projection.
>>> +    fn as_ptr<'a, T: ?Sized + KnownSize>(view: Self::View<'a, T>) -> *=
mut T;
>>
>> Same as the previous patch, this pointer is not necessarily
>> dereferencable (e.g. for `pci::ConfigSpace`). This should probably be
>> mentioned, or maybe we can use a newtype to prevent dereferencing?
>
> This needs to be a pointer for pointer projection to work. I think the fa=
ct
> they're raw pointers is a very good indication that they can realisticly =
be
> anything; but I can add a note like
>
>     /// Convert a `view` to a raw pointer for projection.
>     ///
>     /// The returned pointer is private implementation detail of the back=
end;
>     /// it is likely not valid. It should be used for projection only.

Sounds good, the limitation should indeed be taken for granted given
that this is I/O, but making it explicit is helpful nonetheless.

<...>
>> And potentially, a more serious issue: `io_addr_assert` and `io_addr`
>> remain part of `Io`, which is a public trait. They only verify size and
>> alignment for `U`, not whether a projection of `U` at `offset` is
>> structurally valid. AFAICT this remains that way by the end of the
>> series, so users are able to call `io_addr*` to create and use invalid
>> projections.
>
> I think this could be solved by adding `U: FromBytes + IntoBytes`? We're =
only
> using it form primitives anyway.
>
> Technically, even without the bound, nothing can cause any breakage anywa=
y,
> given even after the full series to do things with the view you'd need to=
 use
> `copy_read`/`copy_write` which themselves carry the `FromBytes`/`IntoByte=
s`
> bound.

I should have provided an example - here is a minimal one showing the
issue. I have put this module into nova-core and it builds just fine:

    #[allow(dead_code)]
    mod foo {
        use kernel::io::{Io, IoLoc, Mmio};
        use kernel::prelude::*;

        #[repr(C)]
        struct Regs {
            status: u64,
        }

        fn io_addr_abuse(regs: Mmio<'_, Regs>) -> Result<u32> {
            let high_half: Mmio<'_, u32> =3D regs.io_addr::<u32>(4)?;

            Ok(high_half.read_val())
        }
    }

As you can see, this lets a 32-bit access be done on the upper half of a
64-bit register, which sounds like it should not be allowed? Similarly
one could change register types, and so on. This might not be "unsafe"
in the sense that it is still aligned and in bounds, but it lets the
structure set by the type system be bypassed. It could also potentially
be a violation of the hardware contract if the access width is relevant
for this particular address.

The same thing can be achieved using `IoLoc`:

    struct HighHalfOfStatus;

    impl IoLoc<Regs, u32> for HighHalfOfStatus {
        type IoType =3D u32;

        fn offset(self) -> usize {
            4
        }
    }

    fn ioloc_abuse(regs: Mmio<'_, Regs>) -> Result<u32> {
        Ok(regs.read(HighHalfOfStatus))
    }

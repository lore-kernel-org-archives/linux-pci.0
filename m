Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010021.outbound.protection.outlook.com [52.101.61.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8813BC69C;
	Mon, 27 Jul 2026 05:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785130080; cv=fail; b=Vwj7Tch1sWTauXkfHqCfBmysoLxF/ZYnJafDS3I9rzyHzqwy0fAXYhYmxXU1Fmr1UWnsmGeMp5gNDVXagYQe9GO1LcytLZLzPaKld/T3Vs1+ZxISHhXzx5eGKFzmTyWmJWYIqBrYZW8DDBwdbXwfPy4oaaZdxR7CLSiCjp5yK3g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785130080; c=relaxed/simple;
	bh=qevEeMi0UERYJtkhYCEDQZCqAqGFEfSL/3yNW5w3pnc=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=LLz86N4EJjRAoJJaY6kXJWokJXVAPZHsB+ElZ+YHC1VMznP/eO4uHyNiXzLkkqTxc8uGmbiBcO6RX74I1Xn85JCTsJezM41xJenwkRb+WpFNG5imsquPWR4wJPLK6vQDziYXJvqUBKgm+oukCKV1PTVdBLhLTl82xYE+BD/Pbfs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SOifJdpN; arc=fail smtp.client-ip=52.101.61.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SOifJdpN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SqCPrsrI0o9Fw8UdtLWZEYjfSZRVOZUls64vXiVML6bT2o/bFg/Eg7q2C8jWWlIais+jS7n0Xi60mydvw07KF91UtzAJvcQXhLr8R9tb5hTboKJxPEumF9m9v5zCzgx8/GGJ+iwCIPWSifekFHtkeUJSlLUk2nsGbb5uQQtZcqUIAkKKFNZ51RKBL/2mqTElymsputnT0wjn+llSEXK80336Zgqk6L0JRpr77gjtoLZsFuMScsnCqd+HmKRpIcv9PDUvudjmStMZ3AYZkMfoN3QKkkYbBYRJD0YgU47goVVTT9NVp4s2bUKS3mGJhl8CMwVhrINpQXSpt12XR084Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K0VJMg7NwvPzb9/LGjrMruPSNNqT0V01sODWoPsqRsk=;
 b=bSPuUNalXObxL3zgALdjAU+HCCPk1zF6WchlbKMC5FMe/jXm0Fnej78XZ2J6HqCuqcFF9PTtLvhKjHiCP7pAZqjl0uIxhDyfyVaKBt96bDRnp8s+sdPA5PmhvvuhhOh/hPbtq37bWhnfiNdoLNYfL/YvHXAXb43lK424vmfQlatSPhyDLgjIN3sTBOlHeyYZPEMMyhGhk2O7Zb8A5Zldh6Xl4xaKcTF4Q7dQM8eOzozAfCqXViQoJdEpuoiZ3R/SIrZEbS/1BBwTYNkoprgjoZvrz7yVz12rcC7b8iDSncN7wRYdecmJ3dBN17g+h7Og4+an3tLR0fFKgoxycYBseg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K0VJMg7NwvPzb9/LGjrMruPSNNqT0V01sODWoPsqRsk=;
 b=SOifJdpNlTKc3+aXQCVfSpefcwFBBscp0mfXoDG/0gXYzJOayeK1k2lC4d7RbkMA/iZ7cVfOu0evnWA1QyxUaD94dMUrgWoWfPoAqeXK4iUjv5haL5V5Gtmx4714VWHG8M1KbC9md9NBe+ClAnx2H7fffCAJ5oiCUsEsreYFqDpGmn4wMI2Y0MualXZaYVwVOrA+JovRzU6YU9Hrd69uf46dapDeJISfk65pwqv6tyq0JMcGdI9ZMsf9IFf0R/cnLpaKhSQ9/10Tna85Ax6AmJppj+oJMhdkBN01ViA+1sYr0dJtAmsJ5qBuELwei7215fXzIW4SVfxzBuf3c5fRgA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by SA0PR12MB7089.namprd12.prod.outlook.com (2603:10b6:806:2d5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 05:27:54 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 05:27:53 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 27 Jul 2026 14:27:49 +0900
Message-Id: <DK93SOJQHSVI.1UCSJRLNZORJB@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "Daniel Almeida" <daniel.almeida@collabora.com>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Tamir Duberstein" <tamird@kernel.org>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Bjorn Helgaas"
 <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, <driver-core@lists.linux.dev>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pci@vger.kernel.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH 01/10] rust: io: register: allow explicit base type
 specification
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>, "Alexandre Courbot" <acourbot@nvidia.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260721-typed_register-v1-0-452d72b60262@garyguo.net>
 <20260721-typed_register-v1-1-452d72b60262@garyguo.net>
 <DK6LF1ODPWC3.3QQV3SXQ55SXP@nvidia.com>
 <DK6U0LR7D57N.3FW1CZG9R42YF@garyguo.net>
In-Reply-To: <DK6U0LR7D57N.3FW1CZG9R42YF@garyguo.net>
X-ClientProxiedBy: TYWP286CA0030.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:262::20) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|SA0PR12MB7089:EE_
X-MS-Office365-Filtering-Correlation-Id: 8de0d068-28ed-4d54-34d6-08deeb9fceb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|10070799003|366016|1800799024|23010399003|5023799004|56012099006|4143699003|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	NloMeb/6Dy8wHXo+nUJqzdHIGIJxTq7WHxKoLt0K63uEipa1m+sTdBLQWU+sLhvpw5ZFXpu/hX1j3lYVjfVqDL81k5AjBTM/NhUlIFlehloPVBtBGR7Re8d1SOt4Zm4lsgHUVibcHgmYD2kZQl4fzWO/lNgyIY+Q2gzM2vigbnyyf8m/VMZ8LU+Ns0gPuSZnA3gWren4EuSKEOdL0syUrmg3/Qi0DDfXt1/zC6xDneoaIolJu7JB+SF6AyyLK1zeToKLxH824prKp5ReDoM9l3VmdOZ2QialW4VF8UggP8v0FV7ZDSQN+Q4UJuAd1rAWL3fmye8O9eo5UDndZI9mR/c0Q6+zkELj9zfzF/xdIDaVQVfcLhfGZ1YSx3NoYSCFO+Ipa31qBpTG2TMe9kVDXL/k7GllCUaU5hHcCbxdO7ajPrq40e8//TTzX4h0/dhZYWv+j0bCJEqyJJlxahkcavLTDwXglrk1y2jYIL+dFhJEg3AyUazWpz4qji8mgCvMha6D2hsfD/jT93QBCyv9eS52t5OfhS8/5TxbLEAqbBPM0GwLtoJzbST0rbEIVGNBkmSC9RWicT9XlggDjwe380a1mKVZdIzTZQM12nrBvyXLB/S3Rz3SIAtoooMkx6wHDUybEEjtmE1xDOUL49+t677EPY8nCNTJWNjWwnOjYBA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2353.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(10070799003)(366016)(1800799024)(23010399003)(5023799004)(56012099006)(4143699003)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q0VrSllUUkpTeFlZeDBzb0JGVXhYelV2U3BjL2FNSnNWak9pU3RORjV2UWY4?=
 =?utf-8?B?Y0VnUFkyMVRnTFdvU1RFdXdjTEJQbG5VTVNzczBhRkZRK3d2WWJ4TUszbi9X?=
 =?utf-8?B?dDR0eTdyaTRLbmw3Q0F0KzRtd3dqbE93SWJtenkxSGU5U0pKd0RVZ1ZZeGhr?=
 =?utf-8?B?K0t3UlE3MEFHN09vMmJsWWVQeHZnbldCMHcrRm1jcXZpa1BBWmhqbDlpN1lm?=
 =?utf-8?B?MHFlOHhjOU9UVTlPazh1WUJVMGpUL0hsZTdZRjBuMzY2cUtJQnZheFp5QVQr?=
 =?utf-8?B?cEFyNU5pMWMzdlQ1b2NFeEpYNW5BdWdxc2tmOFFGazBvYWErMlRiVE1PZ2Jt?=
 =?utf-8?B?U0twK0Y5MW4wemNmVk5iWElQd0NhZmlFMGxsK2R4RjVpM09HRDlyYmZWZmVW?=
 =?utf-8?B?WUlUM29yajJrYnBaRTdobHpsaUlabHI1TzNLb1BGZmFpMGZkWWhIeEN1eFVG?=
 =?utf-8?B?REV2QW1YdjRoZnJGSEJoTGhBK1JlVVZ2K29vbStIMUtyRzdDOGRsRmRjUzJx?=
 =?utf-8?B?ZjdRU1ArNXhVaFVhTGcxN2xXNVBudjNhOHBSblVJZENleWhYMVNiWGptSXNO?=
 =?utf-8?B?b1IrTmVKMXJXSGFzejJJbG4xNWk5R0RseVlTUlhFSHlNODYvMXordDFudVZR?=
 =?utf-8?B?citnemxKeTkySlVld3RFdGJMNkFkZ29pa2VSRStBekQ3cjBHQ0hMTmRBUWQv?=
 =?utf-8?B?bU9rQ1dCOHRmbU9OUkQwblJ6amE2S2E5U1ZvT1ZEVFZTNk1ZTEh1STBRYkFq?=
 =?utf-8?B?dG5TTWlWQVRGUXJybUlLV1RRZC9TdE1HazlTbTNYSmVrdlpOV2svSzVtQmE1?=
 =?utf-8?B?c1FnYWNNR2doemFrdll1UUwyL0N5K1Mrd1JpeG9vbVIra0x1WjZWZHdwbEZY?=
 =?utf-8?B?T1IyUG9qWEErMTNiZUlLZXhtZkVTaDU4RHpXOWZSdzJnS0w0QjVvSklXRk1p?=
 =?utf-8?B?b2F2dVpNa09QMzY3QnJobGFWVlk3RGlTajRMMENVZkhzSlNSTnpnbGIrMDdm?=
 =?utf-8?B?V2FPN2JBenlKamQrY1ArOU9tS0hEWHdMSWcvZURWQTd0M1ljZExjcG9jU1FB?=
 =?utf-8?B?YjR0R3gzU3hNaklTWE51b3NVQXdJSFBqSS9hWm1SZXpTUHJiWVVlVjZEYTNP?=
 =?utf-8?B?ZnBFMk9DL3kxT3RhaHBXbjBLbG5jcGJkSE9HSkVwTUtIS3oxTGs1clJUdGg2?=
 =?utf-8?B?ZVdJbllvenVnV0ZYNXcwQmlLRHBxT2pSL2lXUEprRWY3TG9qeTRCLzdTc0o1?=
 =?utf-8?B?SWcvWHRHVEpUZmJRVGpiMzVMZDIybVkzT1p0c2dYcWxqdzNEQmJSRTNTaFp2?=
 =?utf-8?B?SVYwMW1ZWnRwK2ExaVlYKzl6ZVIxWFVuN2RnbVB3Y00xY0dHSGM2VWk0K05k?=
 =?utf-8?B?dzB2bmsrQkhTWitYQ1lrVkZ4TmpoVE9iVktWb1k1YXFRbnRpVXQwWE9lSXpM?=
 =?utf-8?B?azExakI2TUY3OGd5SmRsVDY4QUpNSlN3cEJOcVJtK3E4TmF5MHdxbkdVbVJr?=
 =?utf-8?B?ZmhTNGNGUTJ3RmVWMmlwVXdyZC9hMGdDY2NsV1RkQUtVQjNyNXg1Q2RYWHF1?=
 =?utf-8?B?czd2bjc1UVV6Z0RlZkVSNmhWTzFPamh2NE4zMVh0eFJ4emlDWFZOeE9IdzZQ?=
 =?utf-8?B?M0VjQWdSZ1hSaWxtVVlJcjBxamlNTGdMUHR0cC9ndEhVQTIyUXJhcGI5VHNw?=
 =?utf-8?B?aTViQkpvWFVRTTNyZnA2aHIvMkptcWpIdXFqcmFwSUJIaEhNV0dQdVI0UEFm?=
 =?utf-8?B?bFYwNVdzSVprejNYbklIamVIUXRoNGlCYXUwbVV5VFlWcFdYNWVzaHM1YzY4?=
 =?utf-8?B?SWd6dmxqUWxJdEhsZ1RqWFpCY2RSb2ZYUmEzekJYYUVUN2RZbXlWSzhpOGlK?=
 =?utf-8?B?cnRZdEc0QVpvc0RjZXZlVzJZaFZ3YXhUK3lROE53QWM4bGdac0x3SUxFY1Yw?=
 =?utf-8?B?WlNjT2NxUWtQTjI3QzJ2R1JHVGtJMDVJQkg3c0V6MmJqdDF5T0o2c3RhYlND?=
 =?utf-8?B?c0xQZTN0TzFiNGRyN2hVaU9LdVh6ZzhBZXBGZTNkNVpyQkRLdDBXVnd4V01i?=
 =?utf-8?B?TlhlWDRtMkJodTRkMjY4Qnc2NTVWd0crVExPa1VPVEhUemtzQmVuZjNqNnRk?=
 =?utf-8?B?WFFrQUZQQVZKS2FsOFNreHFid0Q5a0QweUdDdHp2Mit6WUNKeTR4VldwWkFZ?=
 =?utf-8?B?OWt2UFB6Z1NXdXBlNVk0a2NoUld3ZXJIM1h0WEg5UUNSVXdBdnpZcDdSMG5L?=
 =?utf-8?B?RVBxTzRlLzk2MlZXYkNvYVBUdFBCaWV2Zk9WUHpDUTk5V3hUZFlMd3VZcWVW?=
 =?utf-8?B?eXNJRFZJN2JZWEljWkhhNlVIK1BzVmt3dXFlVnFiYVhpbUxvWmd6dUU5QjRh?=
 =?utf-8?Q?RhEKybWqQc1ttKyXVW1v8douFH90f9P7UhFC/tlDe3KaX?=
X-MS-Exchange-AntiSpam-MessageData-1: v1drSO63rzaeqg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8de0d068-28ed-4d54-34d6-08deeb9fceb0
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 05:27:53.8036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AuiLpRxr2Qm++lKE3skvN41Q5l/Axf5rxCcDJ5xf+PNWq6aqxK1X41kJSFG1QfxCW3/zRzAmn66QcpEGegmerg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7089

On Fri Jul 24, 2026 at 10:22 PM JST, Gary Guo wrote:
> On Fri Jul 24, 2026 at 7:38 AM BST, Alexandre Courbot wrote:
>> nit: the base-commit trailer points to a commit that only exists in
>> linux-next (next-20260720) and is not easily discoverable - it would
>> help if you could mention the base in human-resolvable form in the cover
>> letter.
>>
>> On Wed Jul 22, 2026 at 1:54 AM JST, Gary Guo wrote:
>>> Currently registers work for all untyped I/O regions, which is not idea=
l.
>>> It allows registers defined for device A to work for another device B a=
nd
>>> there is no safeguarding at all.
>>
>> This doesn't sound like a real concern. Registers are typically local to
>> a driver, so one cannot use registers for device A on device B even now.
>> And within the same crate registers can be isolated by module if needed.
>
> Even for a single driver you don't want to mix register definitions. E.g.=
 if
> you have more bars, e.g. if you have subregions of registers, like PFALCO=
N and
> PFALCON2.
>
> Your relative register design uses an artifical marker type to distinguis=
h
> between two different subregions, which is a very good motiviation to say=
 that
> registers should be typed.
>
>>
>> Even if we restrict the base type, the examples given in this patch only
>> partially address the issue: registers from different drivers using
>> regions of identical sizes could be used interchangeably without
>> complaint.
>
> This patch set gives you the way to do newtype on regions. Ideally all dr=
ivers
> would eventually use that and not use the `Region` type.
>
>>
>> So I don't think this patchset addresses this particular problem, for
>> which namespace isolation is the correct solution anyway.
>>
>>>
>>> All users of the `register!` macro know what type it will be operating =
on,
>>> and that type is consistent across the driver. Therefore, add a `base`
>>> parameter to `register!`.
>>>
>>> Currently this parameter is unused in the generated code; it will be us=
ed
>>> when all users of `register!` is converted to gain the parameter.
>>>
>>> Signed-off-by: Gary Guo <gary@garyguo.net>
>>> ---
>>>  rust/kernel/io.rs          |  4 +++
>>>  rust/kernel/io/register.rs | 79 ++++++++++++++++++++++++++++++++++++++=
++++----
>>>  2 files changed, 76 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
>>> index 95f46bb75f9e..c5f07c38e59e 100644
>>> --- a/rust/kernel/io.rs
>>> +++ b/rust/kernel/io.rs
>>> @@ -883,6 +883,8 @@ fn try_write<T, L>(self, location: L, value: T) -> =
Result
>>>      /// };
>>>      ///
>>>      /// register! {
>>> +    ///     base: Region;
>>> +    ///
>>>      ///     VERSION(u32) @ 0x100 {
>>>      ///         15:8 major;
>>>      ///         7:0  minor;
>>> @@ -1028,6 +1030,8 @@ fn write<T, L>(self, location: L, value: T)
>>>      /// };
>>>      ///
>>>      /// register! {
>>> +    ///     base: Region<0x1000>;
>>
>> I'd prefer if we could limit the `base:` parameter to registers defined
>> against a specific block (like the current relative registers). Having
>> it on all register definitions adds an artificial limitation (that e.g.
>> regions must be of a given size, which may not suit drivers that support
>> several generations of hardware with varying BAR sizes).
>
> This is more or less intended. Your driver code would have a fixed known =
minimum
> size, even if your code works with multiple generation of hardware.
>
> It's just that code touches registers outside the known minimum size woul=
d need
> to use fallible accessors because the bar is not guaranteed to be large e=
nough.
>
> If the code is written so you have dedicated HAL paths that the register =
will
> always exist, your should just create a new type for the larger region of
> specific hardware generation and define the register on that instead.
>
> E.g.
>    =20
>     #[repr(align(4))]
>     #[derive(FromBytes, IntoBytes)]
>     struct MyNewGenHardware([u8; SZ_1G]); // This new hardware gen has hu=
ge register space!
>
>     register! {
>         base: MyNewGenHardware;
>     }
>
>>
>> Top-level registers are currently working fine without this, so it
>> doesn't seem justified except by the safeguarding argument, which I
>> don't think is relevant here.
>
> This *could* be done, but this means that we need to change register trai=
ts to
> not have `Base` assoc type but have it as generics. It is however problem=
atic
> from trait coherence POV, because Rust complains that downstream crate ca=
n
> implement
>
>     impl FixedRegister<MyRegion> for () {}
>
> and conflict with blanket impl.
>
> Also I think this is not really needed with strongly typed regions (see a=
bove),
> hence the design.
>
> Best,
> Gary
>
>>
>> The syntax (specifying `base:` only once at the top of a register block)
>> is a great improvement over the current one; if I were to pursue my own
>> fixup series I would definitely have adopted it.
>>
>> Still going through the series in detail but wanted to raise this point
>> first. Overall I think I like the direction, it makes the falcon
>> register accesses read much more naturally.

I like that we can remove the relative register which feels
non-orthogonal to Io views to me. It also feels natural to me to specify
the space that a register is in (Region), and you can decide what method
you access that region (Mmio, other, etc). The cost seems to be that you
need to specify some region on every register, but afaict you could make
that a Region the size of the entire BAR0 space, or a non-sized Region
and just have all your accesses fallible. So it's a bit noisy but otoh
it's nice to think about what space each of your registers exist in.


Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020105.outbound.protection.outlook.com [52.101.196.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63AA93BFE34;
	Wed, 29 Jul 2026 10:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785320701; cv=fail; b=RUa4tqcm291y1LFfqhITSbf5rOb3TrEh7ZNReheNaoQ22PkE6qyK339HV1BwNJ0MvVNBh7oDafB0b9dyMmSBcA4AYrE5GcO6zlg/34HCuWHvak0NGxukFWY3LY7E7Ei+IZBfKgAD4GmV43fBpWUu7hN75DVh+iNIa2PmGi/7PiA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785320701; c=relaxed/simple;
	bh=5ek5dMI3qKBb4SE9vRauUXviuOeNkDbRzCblY/oeEVc=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=GaTKqrJzLon7yPRVFjYQ2XutFH6CVVi+uASVK8gppBHHctIaDctze7DWn09TUSYNi98esui2bvas7ikuL4uMhGkFjIWh4JxuuhcVekROiyBi8sL8NZJCjzoSxarmRlaOssf5ozcEedp6jfKgt+hdggZdJ5sis8NcFyY38z5tYhA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=dDwik63l; arc=fail smtp.client-ip=52.101.196.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="dDwik63l"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xRfI+EDMp2tx/ZKiZ6gOlQQTjeAaPvIrPDaPTkiXzXkWadSfJwTqULVJMj5ea0aC7rbfyDVn10NVniF9ZcgJuRtRmeLwM8P4a+lyVCbCuQvp5xojRTCikZwJF458apSsw1fYoC/Ij3CV4VYVO9ZFnzn2z/eN6+EggKGxA+nAVfcfgoa4Q1M4ANSYNuCkOxV8HNqxO8JX5t3qrGy3Gd2stTBd5aUwSH7D8IyCmvq2cGRXN7xSe/ukjNHrRl1NIlx1/0rZiCXzFJNMUX7ae5UtVER6W2zBqKhGjJQfjmU0dDJwXKexXRsBg08dXh7v86FSY7QLGQupK6b4vMIfDgamQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ek5dMI3qKBb4SE9vRauUXviuOeNkDbRzCblY/oeEVc=;
 b=oUQPpBZTd5yr76xjPcVCo/9ZJGa4EYEGA3eBZje7cj6gZgqhwjMsIV20oEY3vzVgoW6XPQ4JqkO3ijKWN7AkJS4IWxKpI9e1rKrbENYOC0NppkGfsp2E7bzKU4aqNX5So1OqPfKxxKrOjW92sJQSoGCID5/0TitPtWdi+QFCD2j+gfFCtv/BlC+YgS3VgZueuJMGvr3ZUCO3uFSrhEnDAsh2PsEpFjzrW2S5qfD0uCe9ZTy5Fjpq46KWq60/r6xO9WXtycvknJRfqC98Hcv00Y3q02LdFHlpry6Ir7zUOqraHwBaxNuObvhytM+NHu9A750M4Hnm34hu3hlDp0u0cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ek5dMI3qKBb4SE9vRauUXviuOeNkDbRzCblY/oeEVc=;
 b=dDwik63lFXSujIkMi5DctnNnCK9EJ18Gn812rlnM1+vTeTWkpxLbZiiI5e+L1nDi94IbacVS1dFYkbH8Zj1TtwwxicNlgnOCcemGBedhgHPKgLMBG3X6Ysd7aWZmJWxA+Ka1uWpj2ExdFcwKgdW8FVLc384u6X6/l5sVWGw7DKk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWXP265MB6314.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:191::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.13; Wed, 29 Jul
 2026 10:24:56 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%2]) with mapi id 15.21.0270.009; Wed, 29 Jul 2026
 10:24:56 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Jul 2026 11:24:55 +0100
Message-Id: <DKAZD90KWY0L.2E1289J71UF8Z@garyguo.net>
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, "Alice Ryhl"
 <aliceryhl@google.com>, "Daniel Almeida" <daniel.almeida@collabora.com>,
 "Boqun Feng" <boqun@kernel.org>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Tamir Duberstein" <tamird@kernel.org>, =?utf-8?q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 <driver-core@lists.linux.dev>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 08/10] gpu: nova-core: use projection for PFALCON and
 PFALCON2 registers
From: "Gary Guo" <gary@garyguo.net>
To: "Danilo Krummrich" <dakr@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 "Miguel Ojeda" <ojeda@kernel.org>
X-Mailer: aerc 0.21.0
References: <20260721-typed_register-v1-0-452d72b60262@garyguo.net>
 <20260721-typed_register-v1-8-452d72b60262@garyguo.net>
 <DKA02Y5RE1YJ.2FGI97Z60X96R@nvidia.com>
 <DKA4Q5QUBUXM.1K6QS2QPXT12H@garyguo.net>
 <DKAASRCK3M06.G9XODK0T5AAK@nvidia.com>
 <DKAD64Q7CEQD.Z15OS6MRHEKE@kernel.org>
 <DKAEZ4LDA10F.1RFA9JKBGY2CF@garyguo.net>
 <DKAFMD8X5LFP.UPKPHK5FYZPH@kernel.org>
 <DKAFRETW93IW.SXUWFVB47V3B@garyguo.net>
 <DKAH4S5IE3RZ.10VD33NMVVLDR@kernel.org>
In-Reply-To: <DKAH4S5IE3RZ.10VD33NMVVLDR@kernel.org>
X-ClientProxiedBy: LO4P123CA0037.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:152::6) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWXP265MB6314:EE_
X-MS-Office365-Filtering-Correlation-Id: de57bcb6-441f-4fd3-86c2-08deed5ba2a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|7416014|10070799003|56012099006|4143699003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	sCdKx9NCGzOPIa8Q8nFHhkjiQW286/pDjaEtG+YliIG7TjfXEYKmW6r1NG9U1nqS0NSqErRyQ79uhGi51/oubjdf6SJ5BlpUPBtftzSJjnPTl4sLwaiWKWLo4sEhtzsANrW8mbPEqOiTzhyBaMEf9Qz6sVW9ohtjhe73wNW1BPO543E84HKECgpq47/3PdfxvhHC8/oWj3ULAKRIet0NG42LMwM3uwA5eAzoNPSn9RWbHzi8EbyTRyOUG7XW/qBq+lJyY4H6vKtILMhWlCnMYcH3TfcjuJ5yPDYsMS2XmjlPnMoBU0m97BEP8sclVsiWsjdgj/m07Pr6jsKZq1WfEIC9S77COhMxumE/o+46si1ai/bfOAnxQgBnqAJaVAZRmUsLddO1nkqHfRQY6Gh+Ya5XXuA3sOJkUd6SbvUzFXqM2ZVnMiEqAsTS42eFHHdMMYBqGKDJGBCK4KcSz2CkjCY8VysRO4DXhB6EI73PdPCD3/RMCFNR9QdX04okPuzfEveWxO9K6wfizbYBw4VcsUxKWcqjsyb4YxU8IRyK1dIB+tm5k4dnFloaRCT2lK9amXXX+ZG2orB9+ZbZZmF2UAk9lGde80J5+zxpLV8mnHZ6dxx+P4j8y3shCwzfi6fBvC9JJF96Bwg8E049si2n2lceYTY+u+1WVYQzuDaoQrY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(7416014)(10070799003)(56012099006)(4143699003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VHBsOUduWlR1TlF2OUJ5YWgvL29LVXFSYTVwZmxXOTBSU0hMY0lUK3dkeDJK?=
 =?utf-8?B?d0hvOUxldlhrT3lmM3V6NUdlNTMxWDhDcXFrSDNGNjZ3SXMxaEtseVNtUmZZ?=
 =?utf-8?B?RTdTa2hUTnp5eEhhSXVpcnR5TVVwZXlmR1hua3IzK1NibUtyR1NiUllhZ1Vt?=
 =?utf-8?B?akV1S0Vmd1Y3NjZya0M4ZVhvdzV4SkkrTVFJOS9lcTRxSG9FTW1nUkhPVFdY?=
 =?utf-8?B?TWdKWW9zQzhoSllJdVdpMDdQMksrdEZodzVvZ2M0OGRXSmcrbUZOdFdORVhq?=
 =?utf-8?B?c2x6Y1hCYXFQOGJzSVdIOExmZ25EWlBIVlFyOVFvOXVPbjVncDYrL0pkcnkr?=
 =?utf-8?B?VGxmMU55VDNsekZFSDhqUWVEQTduSHNnR0lQajl0a2FyZ0RvTXJGYWhsWUJY?=
 =?utf-8?B?Z3RMOGJ2SzBUT1cxbjE3U2pQREVLZkhaa1MzVkhkcjJ1aUUybjgzbmJSM3ZH?=
 =?utf-8?B?NTgrU0hWUzRtVWtxWFhRWjdsbmtMeXVxMzBQRlBubmM0aDlQaDcrRHUwRkpu?=
 =?utf-8?B?cnBpalRleEh5em9YZlRLOHlGUzU1dEF1d0cvT3kxd3czR1ZBUFJXUU5abEhx?=
 =?utf-8?B?U2VVZUhReWp5dFdNOHR2cFYzZFl3czlhcFlBSTZyTGphdTROMitpZVRpVGxC?=
 =?utf-8?B?KzhMSi85NnVoeWY4SjlTWi9laS94b0lWM1RRbVBLVmh6VDFpQ3BxMEFIL1hV?=
 =?utf-8?B?eDg5WVhGYXVSa3RTU1VqZVlQcG9YaGVrVzR3VkZxMFJNODVTOXdDRGxjYSta?=
 =?utf-8?B?aktjcHk1aS9WZm1GdWtwU2liN0Q5YTFHNDVkNFdZbkZoNXlmYlVQWHU1ZURV?=
 =?utf-8?B?eThmeER2dWc5NE04Nk5sVGMzdVlNNzNVN3Q1TEhzb1V6TExPb29uSnFFUnBJ?=
 =?utf-8?B?aWVqSjFIMEN4bnJBSHJDN2txbUZlcllZWW55di9UdkFpT0htdDZFUDAxcUFC?=
 =?utf-8?B?RGNneTFCa3JHQWFFY2R1Njd0Wk5kNllhT3ExNGZOZWtzRldGYjQ3WUxZbWpB?=
 =?utf-8?B?aktMYWJCRXlTdmdiTWh2OUNFU1BBczcrRVVCaHZxRk1VNkNrU3FFQmV3SVlW?=
 =?utf-8?B?QUVxcDQwVU1QWGMvZW83LzZIUk9vTGd4a04rZmFveUxKVmNmVUcwQi9GWTZr?=
 =?utf-8?B?SEtaQzVKM1VpOVFDM0Y5ek5CNmpjNmMyL2FOTzRoRGYvc2xWL3czUVNIMEp6?=
 =?utf-8?B?dXJQM3hYT3FHZk9JQmp6ekVJazFXVXNqM3lSUDRPV3dlZTMydW1vQktUVHVi?=
 =?utf-8?B?TUNqdm5PcnM0VmRBYTcyV1h4U3QwUXcwa3hLTlEwb1lTclBFbHd4eDdjMGpR?=
 =?utf-8?B?bVBJOEZEK3J1cE84WVh0Y3pqa0lDd2U3aVFQdjFoT2wxbkRNQnRuRER4YjNU?=
 =?utf-8?B?VndYS2FhMzd0THRIUXZuSDZmT1E2ZUZtNXdycDkvVDRDcTZmTHRuUmh4ZWtQ?=
 =?utf-8?B?dGg4M3d4cnpYdEd2eTBtQ3g2aTFrN1Rub3R6OEE4VGY5QkJaL2dLL0ZVOUNS?=
 =?utf-8?B?OVp2TmJrL3FQbGFZUHhzbDhtcmFaalBLb2NHTFd6OFRCdDJvNGN5b2xBOCtS?=
 =?utf-8?B?aFRWMTZuQ3hPSzRBbFdYUXF5QTBneUIySzcyWnB2Y2pwQjRvRUErTFhaYkVr?=
 =?utf-8?B?T3BRTWl2SU55MWtackdvbmtKbUtLbkNaeGVVd0paRU0yK3ZRcCtDY1hHUUF3?=
 =?utf-8?B?UTVVVmJySmdRRnBvNUErcGZCSlpQU2w5S0NjU3k1MVoxWnhzT3RXTmU3MWFW?=
 =?utf-8?B?Z29kc0FYLzlGNGx3ckpoZ0pFcWdIOUFMYlZYM3pqcTJJbGVjdHJrL3hUMkJR?=
 =?utf-8?B?cWFEZGhNd0hhSUFZNjBNYmN1SEM5YTJuZXJUQm81WmVISUdSUGtUUHgwNTlE?=
 =?utf-8?B?VjF4ZzBDaWtMeG52R0RNNmU5bitaUVJjTG5PZWVGNDhmSEpSUVhWS0w3cU5h?=
 =?utf-8?B?czJpMWJEajBEV1NGSTliRWg4dk5uQkxXWHgwVE9NZkJGVUg1TDB0d29JNjhU?=
 =?utf-8?B?S2FZK21jbmdPeHhEeVJLT2dhWitla0pLZTU3aUhRRFp6MWRxYThRUitrRmIz?=
 =?utf-8?B?Wk9QT2d1ZWdhOEhJSjZ4M0JUZWo2bks4bzhNYko4S0lRQWd6K25ML2VwWkda?=
 =?utf-8?B?Z1RJMDNaaWloL0lsUVpySFhMWXh5ZTUveTNwaFNxK2xNS3VJeXlVYTAxckdq?=
 =?utf-8?B?SmptNXhOczZzWWdjMlhhVnhLZkM3c1JFNW5GcVRUL3lLeWkxMU4zWG9Bc1F1?=
 =?utf-8?B?QmxTNEpsdGFCSkZMVXNkeGttVUJSRU9mQjZqdDdxVHA0TW5NRlE2ekNOU3Z0?=
 =?utf-8?B?S1RtOXBuaGdQamFDK1E2L0ppYXpCL3hkVDJ2c0JiRCsxNnBoSlRuZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: de57bcb6-441f-4fd3-86c2-08deed5ba2a4
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 10:24:56.0543
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zMoqVPzr94HGxfj81VZcbE0cAheaKKRsVmWGQZyD6RnfsPHsw8KWwy5xF+jIKdW1QDM7DZd1aggGalkM8MhReQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB6314

On Tue Jul 28, 2026 at 9:07 PM BST, Danilo Krummrich wrote:
> On Tue Jul 28, 2026 at 9:03 PM CEST, Gary Guo wrote:
>> On Tue Jul 28, 2026 at 7:56 PM BST, Danilo Krummrich wrote:
>>> On Tue Jul 28, 2026 at 8:26 PM CEST, Gary Guo wrote:
>>>> On Tue Jul 28, 2026 at 6:01 PM BST, Danilo Krummrich wrote:
>>>>> I may have a slight preference for a separate subregion() variant for=
 the
>>>>> purpose of working around generic_const_exprs, as it probably is a bi=
t closer to
>>>>> the final solution, but trait methods are fine with me too.
>>>>
>>>> I am not sure that's the final solution that I want. I want arg-positi=
on
>>>> const-generics which would syntactically look more similar to `build_a=
ssert!`.
>>>
>>> arg-position const generics would be great, but that's just a syntax di=
fference
>>> and not related to supporting expressions involving const generics?
>>>
>>> In any case, I think my point about being closer to the final solution =
holds
>>> regardless.
>>>
>>>> Personally I think most issues with `build_assert!` can be fixed by ha=
ving
>>>> lints, which is on my radar.
>>>
>>> I think it can be improved, but in the end it relies on compiler optimi=
zation
>>> that may or may not happen as expected.
>>
>> It'd be a compiler bug if const folding is expected to happen, the whole
>> BUILD_BUG_ON depends on it working.
>>
>> `build_assert!` is a useful tool that I'm not giving up. If there is a n=
eed to
>> use it, then I'd use it compared to having two variants to do the same t=
hing
>> with different syntax.
>
> It is indeed useful and I don't want to give up on it either.
>
> But, it is more fragile than const evaluation, so we should only use it w=
here
> const evaluation is not sufficient.
>
> In the case we are discussing the problem is that const expressions invol=
ving
> const generics are not yet supported, but in general it should be.
>
> This is different compared to e.g. read() where the syntax difference wou=
ld
> actually hurt and const generics would limit flexibility, where we actual=
ly rely
> on the compiler to eliminate unreachable code paths regardless of a value=
 being
> known at runtime only.

The offset for `subregion` is no different to the offset for `read()`. In b=
oth
cases you are supposed to only supply build-time const values; and in both =
cases
you can argue they are needed there due to const generics being too limited=
 to
what they do.

We probably could even just add a method that gives you a subregion based o=
n
`IoLoc` similar to other methods. This actually might be a good idea that I=
'd
pursue in next version.

Best,
Gary

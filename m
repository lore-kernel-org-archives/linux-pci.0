Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020080.outbound.protection.outlook.com [52.101.196.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C563B3C81AD;
	Fri, 14 Aug 2026 14:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786717644; cv=fail; b=EwOKkhv9FqvJJ9A4WmEePwOEND7Yzo9vl/vRqN8+R+g9ES2bjVWSzRl7C0rfwnnzgN5WlMqbNsN5QCyRWqwakT1yPgu+/AGed5VCHOOcmINsPQ7PDijKA5zHZRumRyjEyknaEwkQjhm5dKsCcx3aqMrgytfRO83ZwiinQNAOwwA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786717644; c=relaxed/simple;
	bh=drpzLNcpwbkoCGrYRroGiJlgRVP8N59/jDK/c4XK3/U=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=qIjed+0vyCjqxCsHljZMXsv5GPDmtLRSTxXXMKZuqOgbgjzbH5+TPeldWT0H3KjQGNNUjlLamcY2X5tVW5hLFqezewA398HXMtmSVZhALrimO5QScU3kDbUUu9sNA3RHCD6RPYatwRlRINIT3SQJC2pK1S7jZ/EGAtLAaz5MT30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=Gnidgyaq; arc=fail smtp.client-ip=52.101.196.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="Gnidgyaq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n6rv3Z7ukkKNWt0U2wYdx9KCUfoTKaN661BVLB1EJCfPBgGaw92b+Osyl3g7kaaqW6hI6DfZdgHuRenb278PcKAzQWGveeFqeMUwVHehzc4LHuqmLbyaAg3cQHRvMesQBdh1rbTqBbUeofrfyCRkDiotSWFZw0jR8oj0n8kYA/i50Xk74us3YIgbeU894d13PlUYjEPGykDkGJqFUvZB7N20WZs5v/Wf99gKaQUaxmEx6cdr/ZmJJ/4s8fPTw8RrBnQxCOLEO98NRqJG1YTFc2KPHDqE1H/SMp/fIrGz0E9eiyxcQH9Yfl8ysumI90+QNDy54KZwmznLfNB2w28wew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c5tXyLKpPRPEcx1FkfPs9f7w/OXnOp835OC/P3kamNU=;
 b=HWfbgceag7jGEMByrXSbEdBE57YeJ9jcKDb1wqJsXNamP3Qu36BgU5U4fiMGBLMmQnqpYr7j7CXgAEuWqLgFPFbVl+3FSGCZJysefaTkna7l7kGO6DMbX/0UvCE0Qsfh+mSPtPGhCP/DDkYgj19raOQbE4Eq2GfAs19DMNA85odnSDiyexwARNcU5hLzHH+UW9Lv+0Xb4uQaSJk1Krw/zEDtUswTvpKDON9Qwpr9U2Tl14Rpku+DtxoceXu1nfrLoO+PGZpZ/uzYBzbI/Vfpld6gkmTJb2tkTbkIK+XqwStQtBYrTPUA3tjZu7tmRAUQrL5VmqG6R0HOw8ZmXoPEdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c5tXyLKpPRPEcx1FkfPs9f7w/OXnOp835OC/P3kamNU=;
 b=GnidgyaqDoDjV7qE5s9VRpZBRljnxPtPiCdxgkJqJ30sVrfH7q5T5R5pMzv5HGvhkEau4Fn6Wh1sTfzbGxW5fvjDZQd7IXaoo6wJZomcKR3f8k9CRkAM/eny6THfw1mTgyRGVjjZd6AQ/mxRf01gcoxo3wgBqlmIcHTsaAm5S78=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by LO6P265MB6507.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2d2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Fri, 14 Aug
 2026 14:27:07 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0315.014; Fri, 14 Aug 2026
 14:27:07 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 14 Aug 2026 15:27:06 +0100
Message-Id: <DKOQJEE8N62T.3A9H2AB444179@garyguo.net>
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
 <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2 16/16] rust: io: register: unify handling of register
 with/without bitfields
From: "Gary Guo" <gary@garyguo.net>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.21.0
References: <20260805-typed_register-v2-0-c3ca142220a0@garyguo.net>
 <20260805-typed_register-v2-16-c3ca142220a0@garyguo.net>
 <DKOPW4JAQQYY.1FJCI2HTRLIPX@nvidia.com>
In-Reply-To: <DKOPW4JAQQYY.1FJCI2HTRLIPX@nvidia.com>
X-ClientProxiedBy: LO4P265CA0306.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:391::11) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|LO6P265MB6507:EE_
X-MS-Office365-Filtering-Correlation-Id: 705707fb-e45f-4273-ce67-08defa101e9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|7416014|18002099003|22082099003|56012099006|3023799007|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info:
	+1RKUqHmKrqU85e/5GILBKfFCk7eUP87dAPPkoqvDeUxmg8qZsTdw7AhOtXAp6gsTBjcx1PpriD8lmTxEifbJVCgzzep+WGmMffpV7vKSH9urfxvMAh4rxlQgeGiUJpCoKamlUFyyuGjtdeH7M7lig0g5TPx6L5R5w0mZbxWbKjbULz0R5HdSMyGiDPK4OXjxuwz+kxwwgSKRihKLBldhU2ASnBthEQzCCcQJIT13u/kw9Wyz6abhwzOcu2WNv/dEz6VtkPTKsoFLqLftFXEyw9DLyKP0lE/lOkpTQmaUCwLqfIZTfnjtzO7vL2qoOEV/wUHhh0swu2cAIn+VngKs1yRju2tMJaxCFdoIQ+i5vAfnIofjOtrKUvoNwp8II1OZXEB1UV2i0Bsf5cm0xzUpQScNNytDCM60e6TdLi/KoyoZ1quC22i0UO3nYtgxPho65136y8/gxQLAl3hhfMPhGYe76VWAqfBWJdfNagIHN2iGKlgDU6ifptQY5lfg3EFjdJq1B2P5KhurRDOhTBLU94u+O/vZ6s9Q8WwYWnO558TyqIho+PC5QM0QWHsabZXtdNz1qlZGuph2gT3AiGYKl1al1ohmS8/u8WZRhLjT0rKkPTHVpj7JZX5dRtp70N6j+FuBu6eVG+r+g4fYMsBYFvRUaaBkKhj4Z9HyQNx9vU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(18002099003)(22082099003)(56012099006)(3023799007)(4143699003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c3JEZ1Vad0tUUjdiaDF1R2tMcjdYa0FqNVZzR3hKbTZRWXArVlVuaFVaTVpu?=
 =?utf-8?B?RDRMZEZCai9JTlVUOE5RM2pjZEtBejI2aVRLNHVFdmlmY2JCTWdlVWFBcCtH?=
 =?utf-8?B?THRXOGtmRml5c1pDYkliN3lRKzM1eG5zZjdBL0lnQ1dGMEZRN2U4NHZRSlhD?=
 =?utf-8?B?a3lKY0tOcUhlMlJUZG5EQ25pSWtTU3pTMk4rV3lua3U3eTRKYnhNeno0MW1w?=
 =?utf-8?B?cFpld2tENlRKU2xqTUs3STNJZWNyZmtrL1NIbi9TS056RTExT1dBMVdoRHN5?=
 =?utf-8?B?RG0rOThkR2tTSGxuaE1SNHdJYmlra1NpaEdRckVjQlhBY3hyNys4aUpwSS9j?=
 =?utf-8?B?a0k4ZVpFQlMxeHR3MDloaDZsZm9sMjFBREFObFNoQWVQY21seDFYVGpDY3o5?=
 =?utf-8?B?RXFlZEplWTR0SG5XSmRGVDZMOW1EZ0VLbS9jT0VFK0UyWWNQQmt3MEVLNzR2?=
 =?utf-8?B?NHZqN01EOVJiVFpBcHBLOXVzTkQyM3dLRlpJcy9UelpjZjRiK2dOOTJDN2E2?=
 =?utf-8?B?VzhFdkU2b0s0MEFiNm5NQUI1NE1jQ0ZNYjlCSldnY1lrbWlKSHYvLzRCaGxQ?=
 =?utf-8?B?Tko3eXdPN245ZUw2RDhWVFNKWVIrSWltaTZoT2xQakZ1NFY4US9kcUNLdk9N?=
 =?utf-8?B?QVRoalRsQWpHUnBzM1hURldqUXZ4YjYyQTRxZ1BFUXNhc2o0cmppZVkvcTBp?=
 =?utf-8?B?ZmFGWE1nVkV4cEhpN3Jncm5XczZUS2pJVmtqWHdFaFZlU05aTzdyRjJFRkpo?=
 =?utf-8?B?eUtlbzB3dG5WTDVCQTRHOGVrK1FqSUZUUlpoK1ZDN3VMdmk3K2g2QnhmYUx5?=
 =?utf-8?B?S0JVMGo2cncweFdDb2xvci8yZ3ZJUjNCbVBCZm0wMHM0NEkyOWVoQ053TDN3?=
 =?utf-8?B?WjV3bDA4SVFrdjdYMnU2SkIzakFuZThzU3VXN3B4SEdkc0Qwa3dOZEhSQnJt?=
 =?utf-8?B?Q2dHRmVDb3VuVzdFUHYzekxKRGIvbXdYOEY2N25PSll5Y09DaXl4Q3ZnQ2Qv?=
 =?utf-8?B?RFF3eXNUdE45K0NPTTkzeUFWeklMcE9XVUpLVkE1VjR6SWxkclB4Zlgwamc4?=
 =?utf-8?B?Y1Y2YnZsMGFRcFJsVFd2Wk5PNjlSNXlzRnppNElZSUUvQys0aTNmR05mMFNP?=
 =?utf-8?B?VkxveWxkOW12ZTRnOWhRT1hnc1lObVhvRk9vdlZwTDhia2JFUnNjVERKNCsr?=
 =?utf-8?B?QzhrQitTYXRNbE5pVU81dzkrT2h4dTFrdjhjdEZMeGh1cU1HejBHczZmV1ht?=
 =?utf-8?B?T0IvUnVEcHo3RUljWE1LSzZCTklhM1NsZnFsK00wOHpYZS9lRVFrQ1lwY09Z?=
 =?utf-8?B?dTNkNnJFVXJ0TFpieGRjZmtkYlRRZmF3NXMraWpyYXo4WjAydlJOWW1SeWlD?=
 =?utf-8?B?MUJjQU1nUjk1Sm1ZVDVvNVk5dzA2UU1DREx1cm0xZmdxVHNWdGdoQkliNzRh?=
 =?utf-8?B?NFJWbTlHZU1NbmdQa09Za2tuTjVaYWkvMEowV2J6cGJtdUVrOEJDcDNQby9m?=
 =?utf-8?B?d01iTzBSdXJoZkRsUGtsWFdLRjFLcGp1eXZtcE1oWkRJVEE4NE5XeS82Qjhk?=
 =?utf-8?B?L1ZZdnA1STk4N2FJZ211U0t1bll6MTN3a2ZnWjVSUTEydS9JQmNTMCtSWE5J?=
 =?utf-8?B?VWRnOU9ZUFNuSEVNVzUwb3I4SW52Ym9kYXNhMG52REtZaGtzM2sxK2pydmpv?=
 =?utf-8?B?RlZEVVIycHh5RTMyRFRhcDU3QzBONjArTVNUYk55K1FLVk8vaGIzMHFlekI5?=
 =?utf-8?B?d1c5emE2Zm1CRVJyWXI4QjJiYWN0SUtZM3hEbXJXcnR3RXJ5TXRwUVp0YXRG?=
 =?utf-8?B?bTRCMDdwTitBOHZEdnlzRzYvOFdyUzNNRG05VS9wak5LMkJ4ODVOMm1NMmNu?=
 =?utf-8?B?SjlxamhRWUh6bnJ0VW1aUm9NSVlOVXM0NFJ3NDdzRDZaNEd2UVJOeitHb3Y3?=
 =?utf-8?B?K3lRMTYxNE9zZktjZEp2QW8rRks2SzhrcG5Gbzl5c0JVNTZqQ2RuVGZsKzZu?=
 =?utf-8?B?ZDN5OXdRdnZ1aUFBb2k3SVJReSsxMWw0Wll0SFJQK0VhNFhyak84MnZ2SEpu?=
 =?utf-8?B?OGtiMEFJTDdkOWxJUXpCSWs5K1NnMTQxVEJpTFpWajJZMWZMV1c2ODJWTSt5?=
 =?utf-8?B?MjJiblgxQ0syUTB2cWNRS3JwcEt2c2NMYjhUNDQrT1lvZHZZbEduYUtHTkhR?=
 =?utf-8?B?dnVlcm1JSUZKNUFxNzV1a2dYVHpGRlR5cjlpSE5CajdNeWtWaHh4K0xBVEFr?=
 =?utf-8?B?NzdBZm84cXVNYlgwS2RHbmJBYnJyUjJ3NVR1dWdsRDFvdk43RndwRkNmUS91?=
 =?utf-8?B?MkNVZXg2Szl1c1phc1FrYm5ONVptUk1ObW83WDZSd3NWUHlyTE9nUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 705707fb-e45f-4273-ce67-08defa101e9a
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 14:27:07.4009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: igWY6Y2Zry0Z8rXF8UNCmcTGQadCpa8m2QqmlhejEZC2LXsK3BQR9ocq+HCcKk7FEmmTPatX9f4eYVBFpPb2Qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P265MB6507

On Fri Aug 14, 2026 at 2:56 PM BST, Alexandre Courbot wrote:
> On Thu Aug 6, 2026 at 1:35 AM JST, Gary Guo wrote:
> <...>
>> @@ -577,6 +547,9 @@ macro_rules! register {
>>      (base: $reg_base:ty;) =3D> {};
>> =20
>>      // Creates a register at a fixed offset of the MMIO space with prov=
ided type.
>> +    //
>> +    // This handles all of the fixed offset `@ offset`, alias of regist=
er `=3D> alias` and alias of
>> +    // register array element `=3D> alias[idx]` cases.
>>      (
>>          base: $reg_base:ty;
>>          // `$ty` cannot be `:ty` due to follow-set restrictions.
>> @@ -593,10 +566,29 @@ macro_rules! register {
>>          $crate::register!(base: $reg_base; $($rest)*);
>>      };
>> =20
>> +    // `#[unique]` indicates that this is the only register of this typ=
e in this given register.
>
> Sentence doesn't parse (in this given register?).

Oops, I meant "in the given region" (i.e. base type).

>
>> +    // Thus generate a `FixedIoLoc` impl for it as well.
>> +    (
>> +        base: $reg_base:ty;
>> +        $(#[$attr:meta])* $vis:vis $name:ident: #[unique] $ty: ident $(=
:: $path_frag:ident)*
>> +            $(@ $offset:literal)?
>> +            $(=3D> $alias:path $([$alias_idx:expr])? )?;
>> +        $($rest:tt)*
>
> This rule looks like it should be private, or am I mistaken?

The idea is that if you create bitfield yourself you can still use `#[uniqu=
e]`
to bring back the `FixedIoLoc` impl so you're not losing any expressiveness
compared to let `register!()` macro generating it.

Best,
Gary

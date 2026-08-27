Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022086.outbound.protection.outlook.com [52.101.101.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14DB47A0C2;
	Thu, 27 Aug 2026 14:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787840614; cv=fail; b=UOQrNpe5I1Hfesxcrj9YSs4WrMAtdPG48V9u8fscfYzH3i2AEIgpSg1O04kP0ZZ81zkah6RndwpHvaC5vGLYNVaxZvM5WdedzHN9NEBiWW6/5JEiKlySQAGXL5CBszp47B3szfp/fbhW6jU8rBC+la+Zy1kWfEBo+DVbR7S8ZWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787840614; c=relaxed/simple;
	bh=EJsGieJ6lALa1HmgGOOQF2++o902dgBOGvu6B9KKMi0=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:References:
	 In-Reply-To:MIME-Version; b=U++QjXuM0Rfp8rU4zCWKe1ymCgb81N7gsc2pAJvbFhpgzCPsSw5r4f1jGYnRFmV5D/5/G6Jxxpi3YTyWCgsDSyBAqEPjs+DwkOHkgr14xzpzk+hsXbomXdzwxr9ZzEvv6edFuRCrj+sr2z46e/NWck6Z6ptVGdCsvzAV6SJlgcw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=XO8v/+mr; arc=fail smtp.client-ip=52.101.101.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="XO8v/+mr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CJXY9p6fcRt8p8t7yOjXprnr00G9cYMb22L9z+x36ndSn/qtQoUza79CMKo86vthVv5JDo+wQYIoK5gM6LSJPYWts+ihx0LoNi7semzfcvS8reeNh910aACT4htkOrn99VPQikb+cl0VtvOkU83eJfYRcZLCj1RbTLLM/44Zwd7BSMzKNFq4jiyGQz6QhtcB6Liea4aaeNIreOllg6l2LFQPQYZBi+9B16jhkSMzzy0RtgVbMYAWy1yvF3em8IDPqwkUHNwl8A56XsB9kyCx0suSVVF3F9as6vya8P0tI0hTSVM8gdQ1fotmLrnm1+md5vBQwUbOC3LvjFxIJweiJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LCfPLdXpiE68Nil02qK4uH3s1U9YWV0VcpscA6zviBk=;
 b=RUI25Al0NIjV3/Jthdvl/TqRF9rQbfm4ESC28gfNyE8IkGLrkPDMr+Qb3n2bJvXWhNXPmiPbwr6bxQR7Tm5Ir3OsvnYPp8ebUbkUiHlJimEQ8JJUj3YPqZQbMgvOU+11bMvYbw5LbgP42ySI27L/D/jQbBXMm5sC8op6ra4rueVxFzt/xVemixmE1W6otzolKMJAVUoLPTFJPmuyGnuwKo+5zNiM9oJeFm2TfB1gBG9GfiR1P8WdXxxjPAuAI763qxCwif8ebFV3bQFQ8gMCYzt73bcAas62xf3zxZI9qVUFGwFhO3SzJ0BPsAPQMFybLR/sXkL5zzalomCkxNFg2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LCfPLdXpiE68Nil02qK4uH3s1U9YWV0VcpscA6zviBk=;
 b=XO8v/+mrqeziqurJZ05sBzejoqOPOSLv4PZQ6oz4v39sNRzprzCzidrauxFWMjMmz/YKzuvYy5p4eb9FH9jYZB6+OVx6WMDhYwukG4YBreZ+ZKK7H8XSc6pMTNrumha1tG680n+Za0/4JmLYfALvJ9fd4YibmrUcf0pm04tbEtI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by CWXP265MB5108.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:193::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 14:23:20 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 14:23:20 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 27 Aug 2026 15:23:19 +0100
Message-Id: <DKZSLL3OOPXR.S5FE63HNESUQ@garyguo.net>
Subject: Re: [PATCH v3 01/16] rust: io: register: reimplement as proc macro
From: "Gary Guo" <gary@garyguo.net>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Gary Guo" <gary@garyguo.net>
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
X-Mailer: aerc 0.22.0
References: <20260819-typed_register-v3-0-3699a75fadf1@garyguo.net>
 <20260819-typed_register-v3-1-3699a75fadf1@garyguo.net>
 <DKZI8IV8X6Q0.27QMUO34GOFQ2@nvidia.com>
In-Reply-To: <DKZI8IV8X6Q0.27QMUO34GOFQ2@nvidia.com>
X-ClientProxiedBy: LO4P265CA0153.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c7::16) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|CWXP265MB5108:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ab86953-96fd-47d6-f6a4-08df0446bed1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|366016|1800799024|7416014|376014|56012099006|10067099003|3023799007|18002099003|22082099003|5023799004|4143699003;
X-Microsoft-Antispam-Message-Info:
	bWKaR0z4zPwZibZCMHEQ4b5EzNLEb60oNoxI85KggniOJNh3lPKo8BeVAxSHfR1jqDLCHg1CP+w150fBjVTaBXXiBcOKBjGMlm56DJiokCtmZTZiteNkFG4RZwl9SLy6EbRkiTRZ2721FX3YbvSX3HDNj/HWD4WusigqrEs8YWajnLE9jm/zNOrSpHq2FV09IYig3Y2xn9xlLFqVzxO6+58UxpipOMRh+ec7ypRi/kcAjrDSIoxcUrCwkokxpz9gWizvm8JwLn8rmjZklRy858R+vef5stA7ACTejsKMPEaUSTGEOMO70nxY4zyaL18fH2k9QMoTt6FFORHryDdI/k8ph+k+HaotPRharznoGdFH70F2deaq/vuFzT5wEUGslLdj8/zDnAnlUAMnk0n1tpNL80H4MroOIqbkDA1r7o7gZrKOlPlCC0bMnOWooPR0WiXv/khku9Xv6tBL4o3w1e+VCofPZM+MylW/Azj/ghiheGEwcZjVbD4hlBjRPRWw8u3vM5+U1ryfz2AoR/9aJPzo8BZnxSoSSZmjnwWGEICgVhb95e9EBLKVnMpMFXiFOEZoOmJKYbU+CWm2yg3EE/mB+XAwv81SzoOMUnMScPI/TTapMWx/NYDmeXZSX7ujT5RSqJiE4sGCzXXd6emYqT2nOkf5VOUNZZNRvW312Pg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(366016)(1800799024)(7416014)(376014)(56012099006)(10067099003)(3023799007)(18002099003)(22082099003)(5023799004)(4143699003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NDBuR1RLaU1BQVVORDFwN3ppY3E1QWdnOG5GeG80OEZBVFJlT3ZlbkxMc2lI?=
 =?utf-8?B?UndDUFhkQVhhaGM1SFVSYVVrVEt3VkpSbmN0VlN2NDhCS25UK1M0YlhxYlQx?=
 =?utf-8?B?MUpLMHppdWNkdWdhaWxTNnFsRkNzeThIdmM2Uk9UQWxwbzFDMUx1OTNneTcx?=
 =?utf-8?B?VklPWWV6TUFUWXZkS3hFcVFteExkeU9NZlNMRFRhdUVqTXV3VzdjSjFTTjZy?=
 =?utf-8?B?Y0FLVG9zNXVabHZnU2pxUTVXMGwwVk05K3NJQWJHQkUveC9BdFpxY1ZvSFdj?=
 =?utf-8?B?NEFiRmtIbjZ5ajJDK2FIaEFzVUNTWnVkSjh0Z2grK3IzTEJodGRSSkVQQlRv?=
 =?utf-8?B?SjBkV1dxRkE0czM3d3dyUFdHa0pDNHYraTVOd0RWUGdid3pKbVZ3MHR1dFdz?=
 =?utf-8?B?R1kwK0lwY1VzYnBYY25MeGRsN09sOWtZUUdYdkMrR2tROFNGRVE1NWJyQXhp?=
 =?utf-8?B?dHZJcU96UGFPQ05WNnBoV0NwWDJCRE5nelR0bEplRCtOay94MVA1dE02R1gw?=
 =?utf-8?B?VXFTbUNrVkFiaHBlUDhPTjNidWlGTDZJUnc0TGVkVzNYYnVGSGI2YndZU1I5?=
 =?utf-8?B?MllmZXBORTNBUHI0Y3FMaW95L2k0MFl0OHEzZTRkbjJSUERrSVcvTzc3VDNJ?=
 =?utf-8?B?V1VnNmFVamdGdEtXT2Z3dmhBRTUzY0hveVJDK1FLanNSL1NBTzdNRUprOE9M?=
 =?utf-8?B?RkdNd0loY0o2MVNZTGQ2SE1yNFp4bElqcmFpdjc2anUwZGMvZDZyUjFhdkEx?=
 =?utf-8?B?SVQxL3I2Nm15UHM3bUJWNXg2cHU4K2NieGlFSzRQaXJMT0lnaUtGYkluNEhE?=
 =?utf-8?B?cXlGUTJSaVRSc3ZyczAyU1oxTjl2ZmVuT1V5SWg4Q1doUkpHOStQMFhNNWxm?=
 =?utf-8?B?UzZSS3ZoVHVQQjNRemxmM2NwTDNmcUtyM3RscS9rK3RvWklVSi9mNlZya1N3?=
 =?utf-8?B?WUdYMXJuN3RZaEdsdFczcmk2eWxlNWg4THo4Q2J6ZFJRL2tldmdPY1hMM21o?=
 =?utf-8?B?S3JvM3BONzRGdnJNcHpmMllSZURRNFkxMlpRNXFUSjJuUGZESGZ6ZG8wWnZH?=
 =?utf-8?B?cGF6LzRQcFJ1Nk1pMURXTXV5UWVWRUtHOERWeFQwMi9paEc5eGprUWNWRFgw?=
 =?utf-8?B?WUFqb3Vxb1Z1VmtYbkZHMUdhUklHNUZlcnYrTlhjeEZObXBYUjdVK3dwakcy?=
 =?utf-8?B?M3R5QWxzT2I3YlMxNGUxZlpuWkFlQTF0RVBwSS9EdjRxZXdybGRYZlM3SHZw?=
 =?utf-8?B?d0RicjFtVXFXRFRmc0VqK3d1YmRjYVVrbXNtSlAwS1loSmRKM2RMeGtMUmg0?=
 =?utf-8?B?RVhIelN3bjQ5T09Ud0xXd05hdHFTUSs0RDVGVmk3RG1XMGVtSnhROUs5RU05?=
 =?utf-8?B?NnBvTWZTUTNnSjdTaGpySzVSNGh5SmtJM2xTZjlVMjdydkgrMXR1Y0R1Snhw?=
 =?utf-8?B?QmhGaWNIdmtuUGlpVGZKSllQcDZORzdTbEZ3dEdvdzFrdlpIWlpoTEVZckcr?=
 =?utf-8?B?VjhCdUFqeUdVVUZ0R0huWmJvZzAxYjVaNWZNblpxRitiNDlqeG5sNWdrRlFk?=
 =?utf-8?B?RDgwNWhXMDd5Ri8vVURrTEJJdFRBN0Z4S3hyNm5HZ0tyWGVLY0RSbFJheG53?=
 =?utf-8?B?REVCVW5DcjAraXhpUDhMbHZ0Q0RLVk5yc292TGdpTUY4a0EwaEg5TXFpYVVj?=
 =?utf-8?B?S0dlcjdKLzRndWI2S1hLcG1nWUpSYWh2K3M0SVdpeGtmcWZxQUdEMU5vNnN5?=
 =?utf-8?B?bWZIZHVlbnVOWFdhN1BLWnprZzlzYXBaZ2xxL0gySlUvYnYxNG02eWdtQysv?=
 =?utf-8?B?K2Nnc211N2RoZ0ZsTWpraUV3eGZtRUQ0SGtoWUxnTGNhUVBNQlFuQTZWTnc5?=
 =?utf-8?B?MjdQcGFsSm15bVFBUG1pSUM3NkIyQ3NIWEVOMGdFeVRZeEN4dnJqeVczdkRv?=
 =?utf-8?B?QS9CenRkQjRUWm4zYy9wNGsvN2JTU2lzUnlLcjRFbHpuUmxLaWhDemxTUlFF?=
 =?utf-8?B?ZE53NThKdVNQTWZFM3BhMEJmUDc5T0NBRU54N2lCMHFLSHVnNStjYUVlRU02?=
 =?utf-8?B?NDFUMGhVNlA4QkM1SEFYSkxnaVd3eUYrRVFxT3dZRERaRmF6d1J4VHpidUxE?=
 =?utf-8?B?M2VEdHNVVnIwSG9hYy9rTDdublN3Q2gySU5MYlFVc3BtVWxLc1hyWVdaTDlR?=
 =?utf-8?B?NVhvZjBiYWM5anVQZ21Xc1dhMzZPUGFuODV5eFc3bTRxSWdhZDZIZFcwRGJk?=
 =?utf-8?B?a3VhL3hvQUozWXdQc2lFbURWaXMvZnBCS1p4c0FRNXkvODQ3Q0lTTk1XL1ZP?=
 =?utf-8?B?eTE1dWZGM3BDcmxTdmIyMSs4Qyt2VHgwM2JEb3BoT3gxTis3M1RDUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ab86953-96fd-47d6-f6a4-08df0446bed1
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 14:23:20.6402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cOIru7Znl82AsEj6mKt5oXsZ+IJhj1YDBL6XD4p3x6obG/coZ3fXF6bcKN2hQMj7fDjCtoieNFTwm4HLz2tR9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB5108

On Thu Aug 27, 2026 at 7:16 AM BST, Alexandre Courbot wrote:
> On Wed Aug 19, 2026 at 8:09 PM JST, Gary Guo wrote:
>> The existing `register!` macro is implemented as a declarative macro.
>> Reimplement it as proc macro instead, with no functional changes intende=
d.
>>
>> The old implementation produces unhelpful diagnostics when things go wro=
ng.
>> For example, for code like
>>
>>     register! {
>>         pub(crate) TESTREG(u32) {
>>             31:0    data;
>>         }
>>     }
>>
>> which misses out the "@ offset" part of the specification, and the
>> following error is produced:
>>
>> error: no rules expected `{`
>>    --> test.rs:42:5
>>     |
>>  42 | /     register! {
>>  43 | |         pub(crate) TESTREG(u32) {
>>  44 | |             31:0    data;
>> ...   |
>> 100 | |     }
>>     | |_____^ no rules expected this token in macro call
>>
>> which isn't very helpful. With the proc macro implementation, the follow=
ing
>> error is produced:
>>
>> error: expected `@` or `=3D>`
>>   --> tests.rs:43:33
>>    |
>> 43 |         pub(crate) TESTREG(u32) {
>>    |                                 ^
>>
>> which is much more helpful. Apart from diagnostics, proc macro also has =
a
>> benefit of not having follow-set restrictions, which makes syntax like
>>
>>     register!(name: ty @ offset);
>>
>> possible; declarative macro will reject this as `@` is not in the
>> follow-set of "ty" metavariable kind.
>>
>> Signed-off-by: Gary Guo <gary@garyguo.net>
>
> Well that patch was a great way for me to finally learn how to write
> proc macros! :)
>
> The parser and generator are both simple enough, but the new macro
> module would read a bit better with some light high-level doc (i.e.
> module-level and most important types). But even for a beginner like me
> this is almost self-explanatory, so no need to go too deep.
>
> <...>
>> diff --git a/rust/macros/io/mod.rs b/rust/macros/io/mod.rs
>> new file mode 100644
>> index 000000000000..39fa5bc302ba
>> --- /dev/null
>> +++ b/rust/macros/io/mod.rs
>> @@ -0,0 +1,3 @@
>> +// SPDX-License-Identifier: Apache-2.0 OR MIT
>
> Other files use GPL-2.0 as license, is this on purpose?
>
> <...>
>> +pub(crate) fn register(def: RegDef) -> Result<TokenStream> {
>> +    let mut outputs =3D TokenStream::new();
>> +
>> +    for reg in def.regs {
>> +        let Reg {
>> +            attrs,
>> +            vis,
>> +            name,
>> +            storage,
>> +            array,
>> +            relative_base,
>> +            offset,
>> +            bitfield_args,
>> +        } =3D reg;
>> +
>> +        // Use register name's span for generated code, so error messag=
es (if any) can point to it
>> +        // instead of the entire register allocation.
>> +        let span =3D name.span().resolved_at(Span::mixed_site());
>> +
>> +        let offset =3D match offset {
>> +            RegOffset::Fixed { offset } =3D> quote!(#offset),
>> +            RegOffset::Alias { alias } =3D> {
>> +                quote_spanned!(alias.span().resolved_at(span) =3D>
>> +                    <#alias as ::kernel::io::register::Register>::OFFSE=
T
>> +                )
>> +            }
>> +            RegOffset::ElementAlias { alias, idx } =3D> {
>> +                outputs.extend(quote_spanned!(idx.span().resolved_at(sp=
an) =3D>
>> +                    ::kernel::build_assert::static_assert!(
>> +                        #idx < <#alias as ::kernel::io::register::Regis=
terArray>::SIZE
>> +                    );
>> +                ));
>> +                quote_spanned!(alias.span().resolved_at(span) =3D>
>> +                    <#alias as ::kernel::io::register::Register>::OFFSE=
T
>> +                        + #idx * <#alias as ::kernel::io::register::Reg=
isterArray>::STRIDE
>
> Sashiko raised this but `#idx` should be within parentheses (this code
> is replaced later down the series but let's make it correct
> nonetheless).

Ack

>
> <...>
>> diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
>> index 24f96feaeb34..5807dee84747 100644
>> --- a/rust/macros/lib.rs
>> +++ b/rust/macros/lib.rs
>> @@ -19,6 +19,7 @@
>>  mod fmt;
>>  mod for_lt;
>>  mod helpers;
>> +mod io;
>>  mod kunit;
>>  mod module;
>>  mod paste;
>> @@ -481,6 +482,15 @@ pub fn paste(input: TokenStream) -> TokenStream {
>>          .into()
>>  }
>> =20
>> +#[doc(hidden)] // Documented in `kernel` crate.
>> +#[proc_macro]
>> +#[allow(non_snake_case)]
>
> Is `non_snake_case` needed here?

You probably already guessed it but both this and the Apache license is fro=
m
copy-pasta :) Will fix in next version.

Best,
Gary

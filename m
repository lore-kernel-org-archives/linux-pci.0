Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022110.outbound.protection.outlook.com [52.101.101.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5167B3A6B81;
	Wed, 29 Jul 2026 19:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785354702; cv=fail; b=P0mExtF1UaW3YGj/P9SY/E2kAdyKyCsXQChBeU31Ty1gAQLjv3KLrc7tSOvgta4lLuEQKM3lUoq53sX4wSuQKFMoetukznagZ3qbTCwRGAeES+XHk4BJTJAi+2agE2g44iNI6H/t8qgjRB0VYH1v96dWE7fiITpBkJw1hgSPNdE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785354702; c=relaxed/simple;
	bh=a3vsraR5Y2qITY+KaUMsa0W6FV6QzyXqT4KUU8q9mVk=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:References:
	 In-Reply-To:MIME-Version; b=JaGLbm7ak3jXY6PFCUlB6vb8dhKDSYiHwypKQ1wNg+04CA40xaNvJyxMAfjeoU7LVMDuol34d6P60NCCztbZcSwreyKPe8SxExMQNiGWggA57dPZjayl1aBFIvl2KmKGib8DzMviCMytmwX+ti32Twep1a9mG/WcdfmgTkNAWKc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=o5n+MKmB; arc=fail smtp.client-ip=52.101.101.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="o5n+MKmB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mvXp1IgZgvX8CEYDx6btoRQfCy/kGAjjOttLL/8R8AZaB5aoJA8CaheyBHDdsmYVAgL18z0n15WlZv56Ab8ENYG5TSyE/MjOKN17avBShJt2xABZksovLUpP1cgEfMnkMdWOvrqhSLX5saUBQmlhmZkZGEUzhmyCmvR9zykHCgmkU/sklrxshzChALWpEh02r3RDPeEcf/Q0t3NP/zyllLdvps3ICC4TCu9meiJLZp2MEVDNFRYW6pWIOkAt0Bw5iErrNSirU0MGSb8o9MQfdYKM+Qn6ENo96KPrloZhkhGxZejbzo01W80+E56tQ5dCjxZI5aXwY2aSrcv42/QhGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fiWHdnoa8Wb6HGWdgHJNWx6/bNVTWcLEf/+BEPNMp74=;
 b=Fi2ZZbelUKEJkPIPzAjML9QMNXteTYHwjxn8fQJTN+TTCN+aZjSu+27QkSPoITXwmsycnTFGX2qLyOFNb8VhI7d+GAruNWeEV7FYhi1E3nPfN4Q+HyLkkJPc3au/vdauZWZJjDhqpygW1DckSUOTfBYVWOC4YefcGS4R3CbV2DUfJN23Kt7XaIh1MKm/HGU0Az0P1X2EHOey2Z0g3sk4YiejBy5JyLlmHKU60kZXGnrd4VeB6WqmiaqT46fTGj1ioSzec6JeQRjWG7eb7ktDrGOXs1iSJdx4YRERqPMNFvVSwMDFWSSX5CSF6p7TEpPCaUyy/2Cew9tuEjwzirNCUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fiWHdnoa8Wb6HGWdgHJNWx6/bNVTWcLEf/+BEPNMp74=;
 b=o5n+MKmB1teBTGNzP/coomV65gPXAkspZHrIPNc3GNAc+86o2XoTPmScwb+e0FGdQza2CxwgLZ2dkIdq92avgV67QN571NNOJO2vT+Nuy64jX3nrGrdcJW2J3sTlqmmfITF7DCDkzIiPPS3lyqMWFgD08PZhMBMWkDkFyyzXzJM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:27c::13)
 by LOAP265MB8981.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:492::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Wed, 29 Jul
 2026 19:51:33 +0000
Received: from CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c9e:93c8:10db:e995]) by CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c9e:93c8:10db:e995%3]) with mapi id 15.21.0270.012; Wed, 29 Jul 2026
 19:51:33 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Jul 2026 20:51:32 +0100
Message-Id: <DKBBF354W8PU.OSV8SJACE415@garyguo.net>
From: "Gary Guo" <gary@garyguo.net>
To: "Danilo Krummrich" <dakr@kernel.org>, "Gary Guo" <gary@garyguo.net>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Alexandre Courbot"
 <acourbot@nvidia.com>, "Alice Ryhl" <aliceryhl@google.com>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, "Boqun Feng" <boqun@kernel.org>,
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
Subject: Re: [PATCH 08/10] gpu: nova-core: use projection for PFALCON and
 PFALCON2 registers
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
 <DKAZD90KWY0L.2E1289J71UF8Z@garyguo.net>
 <DKBAX2P3POG1.3CVTICXR9RYHS@kernel.org>
In-Reply-To: <DKBAX2P3POG1.3CVTICXR9RYHS@kernel.org>
X-ClientProxiedBy: LO4P265CA0028.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ae::20) To CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:27c::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CW1P265MB8877:EE_|LOAP265MB8981:EE_
X-MS-Office365-Filtering-Correlation-Id: 29133b1e-44b5-48aa-bfb8-08deedaacab8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|1800799024|366016|376014|10070799003|56012099006|10067099003|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	YvjlgEwlC0zZNizt0Th7VcGJzZuVf+Nfi5LrScGVVDI3Lji+0oTMm9Kvupm4fgkqhaW99+EhN+3uhT7p0ETmpeexC5IC9GEOBKRO4NhcmVCUfX80Bk5u8fkDDYLHozJQgrlBwhBkhpS5CffGb90j56qaWjyfc4re9yrjv/KREsaP/bEqTlY5P5v5w/KDL1C0GM/Mf8gdcH9+0wjhZkTURLQQb6PPPB2MetVu75ke8MGvtlm76FS6o24mN32fjEfCiM07NtlcKQ/k/IKesMHy0T+XbUr+WS1XHJG909esS3TnAcR5f8NmCqvuomBJuabGBWxZRS3iAhKDne+Den+FfHA6Uom0NMee4hXFZ2vO04p0NwYZGXpfSzc5SRQeR67Z4ZNQmEIAPT7k9O5ty2Ou/sFJoQrR/dM5tPno1RDAE2qKarZjeCob7+wnlN500wrKcp3pzvm6xRZwVLiF4wXskxaUYMJXcJoXyMNZEPTERVF8PYgGLyuwBF2D778/pv2lXPq7bUOjEstx9itv3ijSsh9vROi+6J29c0XjxPuq1KpcYQ636DUUomVW7zoUI3Lks9Z40kRNTPQIJ6VekOMqIKLHLkXfGff+dxIISxCap39E/CT4qLwSjOzc6aARivs7p6b09AVUeVN1WEFKBiNznRDdMT9Fiv/r8vKbhY3UbCU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(1800799024)(366016)(376014)(10070799003)(56012099006)(10067099003)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RjhCUUVBVXA1aUMzbnJsUHhuQVNuQ2V2eTh4VVJQUXpVc3RmYzRwYzFqSmtt?=
 =?utf-8?B?cTVKQW1GN0U1eUZVMTdVYVBXM0NKR1RUZ3NpenY4SUN5NCtiem9LOWV4VEY2?=
 =?utf-8?B?Vkk2UWd1c2VyTjFtNkNpdFhIREtPL2xkMXE5SXFDT01JMXZjZ0xFeXFnY1Zn?=
 =?utf-8?B?YVF2alNmY1A0NjU3U2xhSldvUTAvY1d2TlFmYTZwai9IVW5zMTVnKzk4NWQr?=
 =?utf-8?B?T3hSSkF3ckxEL3MyeCt1Vjd1SVdzemhHVzBOZzk2NENsZ2VwbmFIeExLQzNC?=
 =?utf-8?B?aHZXVDBLQkhtM29DNFBpeGE5clY3dkNWUjJReVp4T1JsakxwUVY5by9tU3RK?=
 =?utf-8?B?djBaSzFJT29FckMxR3kvZklCOXR0cWNaeTZCQmpCSE8rNjhMcjZ6YTY5a0lr?=
 =?utf-8?B?WUJUTDJkQ2JkMnY2Q0l1dDU4M0QrQ3UrN2J0bnFsZEQ3U2tpUTViMmtrUlZF?=
 =?utf-8?B?ZmZBTTZFZFRZZEU3ZzJ4V3NYWG9jRUlUTVVoY0VmaU9PVXVXc0ROSkVPVHJu?=
 =?utf-8?B?QmNwZU4wdVgrTmpJTU5RZG5LeUtIbCtnZklQMGdielhHZjBhTEloeVZGTVpK?=
 =?utf-8?B?UXVOQitXaERicU8yc2QxWm04c2ZSTjdVVEl5R2J3UjZIcGtTSStSRlFoK3Vo?=
 =?utf-8?B?aktkTkRWUzhqTnAzdStBQWhOL1VXNnA5dTRzVDNWM081bFI3QWRSditxcDhp?=
 =?utf-8?B?U3lhcG5hb3gvNTdVQmlYaDFaRTQrdStlMUkxTU5aKzBNc1FBenpLWnMwSk9z?=
 =?utf-8?B?bnhNSCtGUGt6SHZDaEdqK3E1ZmhVL01sQktiMFRITHR5Wjl3bC82Z0psdlpp?=
 =?utf-8?B?T1hBMW9RMTNUTE0vVE00VDQyRlcvczRvZmlpNWwveHF0Y3JxTWJ3b2dBUTdu?=
 =?utf-8?B?SVpSZi91NE5FVUMwUmVjeXk1US9jSHRNY0h5L3k1b2pDdkx1Y1NYWXp3Qlln?=
 =?utf-8?B?aU51bnlhc3lNREZ3VE1lZG1jR1hOZWkzZnFSYXg2TWdtbTFWY3R4bUkrbFg5?=
 =?utf-8?B?K1dsczh0eVZUNmMwUmR6dmdwck5jWmtHaHhyWmJBSjY4VzE3SWg2d0M4NmFp?=
 =?utf-8?B?dFpCWmhaRFlKMzhBS1RyZU1XTGY2ekNNMWp5QU5CNk5LM2R3SXJSb292OUdu?=
 =?utf-8?B?TnB1enRBUjFTQlQ1Lzc0aSs5MkFBakxRUkx5WVg1ZkorVFRqYzVIZk1KcFZw?=
 =?utf-8?B?UEhWcnM0OEZJdVAySFE5N0IxU3FJS1hDdlE3VTV1WkIreWEzK3lTVllYNFNn?=
 =?utf-8?B?OGRIbGc0YWRKRzlIaStRUWh5RHBMMTh4dFRhTU4xcHVtSVRXeGFLdjRoZSt0?=
 =?utf-8?B?amF3cFQ3SnFzOURFN3lHaStnUzZCVEp2RkxPaDRDSGp3Zis0WHUvUnMzdWR4?=
 =?utf-8?B?MTkyZWZSZWUzVXRQSzFjbldqSzFSMnp3dVJ3eDk0SGhkOWtrQmdia1Q0Yk9x?=
 =?utf-8?B?SDl4dm9PTGxYNEZmemF2a2xHQy8wRlZnWWFVZ1hPOEl1ZWhVNVltRitNcWM4?=
 =?utf-8?B?UXh1a3RCZVNxWkJjalErVzA4d2lrR3BJdTlrODdNN0tkbVVSbW9DWEs2S256?=
 =?utf-8?B?bE8rZVFUVVJUTmgzbDAxSkJLWWtONkJUQS9wczlHRnB4SkhIK2wreXIvVmVr?=
 =?utf-8?B?RVpOdHdCaEx5a1gxL09mMURVamtuS3dtWUV5cU1TRDlFajhPY2YzSkIxY0p4?=
 =?utf-8?B?NUVMYWFxb1h5TE9ERUM5enQvMDREWTdsbFJyUUFxRm1teEVmbUtMRmZRZDZs?=
 =?utf-8?B?cmhxUjQ3WWcySE82Zkloc1laZHFwNXQzdTZ1R3lFbnh1MW9RS1lQQ3VQNHlE?=
 =?utf-8?B?Q2NVZHROSVZidkpKaXM1dU5ha0pnVXJET1I1VmZud1ZnOElNeFNNRHFXNFh2?=
 =?utf-8?B?Y3Z4a21CbXZQWENpWFduRUJmNDAzaS93M1Q2aE44WElvR0I4ZGIzM3NFMmJm?=
 =?utf-8?B?V1hqT2w2OGFqKzd2K3ZnV1hHQzNZNW50MHA5SkU3bHR2bjBNNVY2VkQxeTlh?=
 =?utf-8?B?OFJYQjBELzZnT1hzQlRNNjJSTGN0YWlvZmhGVHIzSytRN05PclNyS01HY21M?=
 =?utf-8?B?NHErMTR6MlZkN21zaXdnend1ZDFpRVZPVnZwTG5TVGhsMyt2NVNPTFkreWcz?=
 =?utf-8?B?TmpBbnZWM3hRYXhSN1VETlRLTFVXbmxWZ3ZvTXhrdGVDSUZCaU9JamlBa05C?=
 =?utf-8?B?Y3dnZEJBSzBRTlpqVzh0SXJnbGY4NnZDN0NVQVU3WnRnNDJEOTNVb2txelBz?=
 =?utf-8?B?SkVVRDBoVVJCQ3IrcUQ0VDBtbWo0Y0JFU0RGTmdLYmNRYUZOdFZORno4Y2dD?=
 =?utf-8?B?TjBCWTdWdlFuZlNLRkUzeWx5OGhBdEFZc0pFeGptSGphayt0eTQyQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 29133b1e-44b5-48aa-bfb8-08deedaacab8
X-MS-Exchange-CrossTenant-AuthSource: CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 19:51:33.5464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0MqmFHx8YNl3WG0vEv77Yn0ELR1r3RHhFcW7TUIrKhDkzP7owipjFL+FaCRuTAWYU0osXrwf/ZVYA6NxBnFXhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOAP265MB8981

On Wed Jul 29, 2026 at 8:28 PM BST, Danilo Krummrich wrote:
>> The offset for `subregion` is no different to the offset for `read()`. I=
n both
>> cases you are supposed to only supply build-time const values; and in bo=
th cases
>> you can argue they are needed there due to const generics being too limi=
ted to
>> what they do.
>
> I see where you are coming from, but I see it from a different angle:
>
> An offset given to read() can legitimately be a runtime value that happen=
s to be
> constrained in a way that the compiler can proof that it is within bounds=
 (with
> dead code elimination doing the rest). We have reasonable use-cases where=
 the
> offset given to read() is not a "true" constant, and hence build_assert! =
is the
> correct tool.
>
> subregion() is different in this regard, as we do not have reasonable use=
-cases
> where the offset is not a "true" constant. (And I would guess that this a=
lso
> made you choose the implementation you picked for this patch.)

I think it's the same. Imagine instead of register arrays, you have subregi=
on
arrays.

>
> It just happens that we hit a language limitation where const evaluation =
of a
> "true" constant does not work, but that does not make build time assertio=
n the
> correct tool, it just makes it a workaround for the existing limitation.
>
> This is also in line with the documentation in rust/kernel/build_assert.r=
s.
>
>> We probably could even just add a method that gives you a subregion base=
d on
>> `IoLoc` similar to other methods. This actually might be a good idea tha=
t I'd
>> pursue in next version.
>
> So, you are proposing that subregion() takes an argument of type
> L: impl IoLoc<_>?
>
> Where would this argument come from?
>
> I assume you would need to bring back
>
> 	impl RegisterBase<Foo> for Bar {
> 	    const BASE: usize =3D 0xff;
> 	}
>
> impl blocks? Which seems like just adding boilerplate? Or do you have som=
ething
> else in mind?

No, I was thinking of

    struct MySubRegion([u8; 4096]);

    impl Register for MySubRegion {
        type Storage =3D Self;
        const OFFSET: usize =3D ...;
    }

this can be generated with `register!` macro if you can attach a specific t=
ype
and not have it generate `bitfield!()`.

E.g.

    struct MySubRegion([u8; 4096]);

    register! {
        pub SUBREGION: MySubRegion @ 0x1000;
    }


Best,
Gary

Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022108.outbound.protection.outlook.com [52.101.101.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BD33DEFFB;
	Tue, 28 Jul 2026 19:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785265389; cv=fail; b=FBGOsvdQcXn1Xoub+/XioUxd22Ek3FeA7MDq48rL7/hXUaQD55WptCgRMCha6pooufKYsm/WEIA1ygEjDApIFIu3YTvNAcaMSM03NMVMKPcp109jGOVaFnglKUfNxHECMqk8Fk6X4+sgyTsMLYLcmBp1wZMriAJ7qlEWk7LAYjA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785265389; c=relaxed/simple;
	bh=/X+t+mVNlD/cLo/Y5bqc2NiDmbJZY0/8L38qGKEhFHc=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=p14airi2ETRSx+1tJvexTVpZ94m+6h/mY025PgmqTPmSs2YhiC+tedXE/WZ7Tsxd/W9AmXA1Kd0o2gjC7YfJ7IfS3lSNsqZoekoWnfLH39S7mGYm3d/WpdMIkRni/4UCIeeEQs2VBzFN422/fflbppw7fYTjiD/UvDNx9dSOMzw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=qx4z/Ywa; arc=fail smtp.client-ip=52.101.101.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="qx4z/Ywa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P8tyicVEcrVrG/+CxQeooBQLRDsMjZFkJ5zF3nMy2+1djjlNVFFZrzrp8wfa18cpdToT6Ytvy6+D/6R4pkswAqqyM3AZX9nQ4G5q1ztK1x5mQbpOLCYYiS2tNy4hxuYSU+Q3e9LJ1E00FIKXybCBf0otEe/7UdQmo/AOC1bXRofdW4kVTt+ceqcpEFgEswc9j101ljIdOzF01L13S2aKWLW6oYH6+aBSUNFUhOGf7m3dzERTrlCWuudsN3c/hCnpSv+FgVPx4rafieuRwN8EYNbspxu4o44s2t8ZzwPqXWe+/thRUBszfpyFpy46iu3Obu+axSr7H/8PkvxaSJl9fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/X+t+mVNlD/cLo/Y5bqc2NiDmbJZY0/8L38qGKEhFHc=;
 b=mp3fkt8blKPukLoyn4enGa7XGCF/G0SDeASgluBgNV9719JJiGG7eC1gzO9rn4Qei8WYph53ObIS4GDRSW0TvKU4oTxrZpEFDL85WCdEmy/VB7nVH1TnvAVbbIrk0A8yhoX0m4Jq56GfAR9YA80iLGEB9GWoGFAbaNaIyuNIYJXp3LeLmGxMv2OkLNMdV3GnDrQbmvL4ENdkc+lc6Vusya74C13p/eJFsiW9+HtuCz2B/aYRoJLnZenr1uBEFk24p1EhLvWM6VxaSTyi17yEzlk0Rh2uN80zh6zfysP8jKteWWZnM6FAI5hfYOsMP0/s32b+woNBt3EcEj37jjrbgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/X+t+mVNlD/cLo/Y5bqc2NiDmbJZY0/8L38qGKEhFHc=;
 b=qx4z/YwadNNjS0GWc6djz1zUhVwsBLISSlqdlWXMFzBiISVuHN5EUhBpR8X9Dp9F0Jmkui7kUCJxDu2CDCw7cfoUuV4Ys2oT5JUBFfSymHwGbr99887A9YM2vymSINkBiN0rEg/p+jePCnRJNcfWYdvNGGk4blVj424sHp8Yevc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO9P265MB7801.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:3b8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Tue, 28 Jul
 2026 19:03:04 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%2]) with mapi id 15.21.0270.009; Tue, 28 Jul 2026
 19:03:04 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 28 Jul 2026 20:03:03 +0100
Message-Id: <DKAFRETW93IW.SXUWFVB47V3B@garyguo.net>
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, "Alice Ryhl"
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
Subject: Re: [PATCH 08/10] gpu: nova-core: use projection for PFALCON and
 PFALCON2 registers
From: "Gary Guo" <gary@garyguo.net>
To: "Danilo Krummrich" <dakr@kernel.org>, "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.21.0
References: <20260721-typed_register-v1-0-452d72b60262@garyguo.net>
 <20260721-typed_register-v1-8-452d72b60262@garyguo.net>
 <DKA02Y5RE1YJ.2FGI97Z60X96R@nvidia.com>
 <DKA4Q5QUBUXM.1K6QS2QPXT12H@garyguo.net>
 <DKAASRCK3M06.G9XODK0T5AAK@nvidia.com>
 <DKAD64Q7CEQD.Z15OS6MRHEKE@kernel.org>
 <DKAEZ4LDA10F.1RFA9JKBGY2CF@garyguo.net>
 <DKAFMD8X5LFP.UPKPHK5FYZPH@kernel.org>
In-Reply-To: <DKAFMD8X5LFP.UPKPHK5FYZPH@kernel.org>
X-ClientProxiedBy: LO4P123CA0443.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a9::16) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO9P265MB7801:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f7f6077-bc72-4cec-edaf-08deecdada36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|7416014|56012099006|10067099003|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	vnCxWUapDyA145ZRZM9lpmmjAh7ewNskM+z7UJoOlasJ4g07DIPTi284zclPTu6Gg3KsyP6BizOLkMpVQtknM2SKgadKbGP44jnmB4/anVZS2EglFK7P7GnWMixmBwyy7TDcxuMPfkNQ3d1pwlj6R4dsT3oXer9MRxGuIfhELmyCWy58TdP5UAqgKRtCARdv2RxQlma1rmSlHpVzc1mP521l8QBbdfAW89gReujVQYlAUIOHGkevf3e1w7YPx0TnM2qVeg8kOtPyk2in1Lt1wUV5By7h0/W2C5bPlrBp7DQaP8VlpWdxamOyYR/3edgKgS0uxtUJVPgsau7bC3zDl91mtKQ9KtQkbltZ73xC+uE8CAAfW2AiHcJtClh5iFmfGlau2xUNhth46KJedn6HAL8A0dLZQAenKpiUP4lVWHdwKdTs/1Mr4YOYpbo206zOVEXF3NAwxAz9kqK50WtNmNpcsyMklQWufv9bRFZj/EVAq6vB48fe+PIttIGFLQ3lC3CyJhxIbXkDo3zlqvbXJjPkYqqKzZBDeuXUvg5eNVl8iDNNoNpPxsPpZ6N596uANqHtxaRFMgVo32hlRh8/j4zTAZ3bdFjXC9UtvACS1kvGeGVrwOgSsmZe7i4GMJgmE3Wp5M+mtIyxC1YdQEtNTg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(7416014)(56012099006)(10067099003)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R0JtUWUydVFhNGhCVk9xeHErOGN4NVQ0OVlibVFmL0wvYjJtRU1paUFIOEhP?=
 =?utf-8?B?UGZCeXp3NEkxR3pwamZqTXVNdGdIdzV6bGFsVWNxZHJJbWttSU93Q3lTWGIz?=
 =?utf-8?B?V3dCSFpYL2tmYVV4OERKTzh0VmVzdTZxeFROcUd1Zm4xQXc1MnpHV3REa21V?=
 =?utf-8?B?T3JSVHRTZEJFYS9LQXFza2lHODRNSFJsVEJ2bnI2aDI4ckYra2RQa3BBaVQr?=
 =?utf-8?B?T3dNc3FIOGxJRkxDMmhZSUJiS2NKcW5sNldIeHZwQ2JCQmh4NU5hbzh6aUdw?=
 =?utf-8?B?MGlsVGtDdTFBKzc1S3hwRWxmTTUvcGlOMGZEV29uTnBWclYxWndwalptTmN1?=
 =?utf-8?B?TU1MVDlHdHJ5WDcyRzBrcFVxNkdVbzdNYnlrUWU3ak9Ja2FmbzhlUE5kaUhk?=
 =?utf-8?B?TmN1WGJtMlJCZ015SkNVek5URm5UMDFHbVp6aEZ5YnJlSG9PcjFUNiswRlcx?=
 =?utf-8?B?TENtdDJNaTdIRTAzazFDWFRJd3IvcU0wdkRJNzNjZ2VLZlJ4S01aa2tJZ0hN?=
 =?utf-8?B?aVpQY0J1c3h3MEdOWEN6aXhJTGVuaU9hZERXbmZJdU9vaTlMSWJXNWZKL1Zv?=
 =?utf-8?B?VEhPb1J3WmxRcFZ4SFQ0WXRyaTJkTkNvQ1l5RUlYTTE4SmZzQlV6eGR5Unpz?=
 =?utf-8?B?NWRnMkZaOE1LUnBPdVhtNXA3MThJeTF6VXprN2F6OTIwTk1JcENVbk9PS2Fk?=
 =?utf-8?B?cjZxM21pV3NzcUlnSVczMkNZMkk2SEFOS0Ezam9uT2lrQjdHRnJTbVp4NEE2?=
 =?utf-8?B?TUtsdHl4TzJ4K3ZHR0NNelFVTER6L2VoQ3lhcVVPZVd2ZlE2Sk0ya3dFVUhy?=
 =?utf-8?B?bVV4R2s2UmVEMm8ySytLd1BSa0pnZGJWT0o5OThsOEZCTldxbkJkRkVaQjhK?=
 =?utf-8?B?eXA2bVU0VTJrb29OZUFtd3ZRTDhFZVh4K2FOZ29kQ2ZFakw1VCsxQ0p6MnRw?=
 =?utf-8?B?aEdLNHM4ek9mZVVteUlnL3MxZzgyWDNocDZ4Sk9vVmUyc3dDWVNWdDNTcGc5?=
 =?utf-8?B?T25TTVQvR2lLdjFIUll4Qk0zSW0rcXpWV2liR0FNcnF0OUFXc3UzalZyU2tS?=
 =?utf-8?B?RzVCcDFoMlhLeG9Pakk5VkZ2ZHpTaWR5YUg5UWk1ZEg4Z203VWxQMmVIOFlp?=
 =?utf-8?B?Z2VvdkZ6R2tZS0tNTm1sMHZrVEhLNDlHU00zR3ZsZ0lPYkh1OGduanJnMTJo?=
 =?utf-8?B?VFlOb1FnZFNKTmNSanEyOE1Ubm14dHZ6MElkWkJ6enAzTlUzdTZTYkhscHM4?=
 =?utf-8?B?cFRqNDBqMjVGRkg2U0tMbGZBOE9mK0RrbFhUK2QrYWFvYm93M1lZWmRBb0Zs?=
 =?utf-8?B?OU4yRU9vQVpMUDhSaWRydWxJS2Job1NhSVF0L0o0Z3hXSFd6YmJKZ0JOTk56?=
 =?utf-8?B?RGRpYWRTODNGS2c5VEdmTjRFVE9vNUU4MENrZnBvMmJCS0NSVnFNZHJjQjNj?=
 =?utf-8?B?Vk14akFkaDBBK05NclJRQ2h0NU1vaXVmWU1TbklveU4xdERST2FSUHJXZmd0?=
 =?utf-8?B?aUt6QmtrWTZ2N1JmZVhhKytSZitIeXdjS1RQWUd2SnhjQ2lMWGpwdkhjNnRv?=
 =?utf-8?B?Nit3cUJ4aGsxZklubzdkajkzZ2NNUXEyMWxWcVg5RXJIbEI5aEFScWx5djl3?=
 =?utf-8?B?VzBBb1FRMzlFd2l2M2o0QXMyQXhQbTVoMktRbkQzZmVpNDJXdmYxWTFrdlh3?=
 =?utf-8?B?Mk9oMkpLWXZwUnpNMmxLUWxyOStrUXhWUFdxbTFsZUM0QXhMV0lvdzBTZ0ZC?=
 =?utf-8?B?Q1VmNkRDQnRsNHBJZDBPZG50UzZnQWtDMTk5aTlNbTZwWHo3eEVza2RvWWRY?=
 =?utf-8?B?RXJUNENwNE9EdEkyZmhjUEhCQ3BuVCsxdGlyemVQa0xKanZCSDRmcVZsV3Zx?=
 =?utf-8?B?SVo4MElWek44MElaSURyNmp5M1h3aG92K3NLeVRhaEFnTkthc2QwTFduY0E2?=
 =?utf-8?B?WER1VmtNdFBxcExRbnc5d080ME0xYWlKVWkzb21OQzlPUXBzREIzYmxUeWdP?=
 =?utf-8?B?SWxaNXNJZ1BRcG9tRTExQ25xeHdydXFYMXVxUTZFYjQyOHRZU0lzYlJZYUFQ?=
 =?utf-8?B?SmM1SmNwQ1Q1TFozSGYza0V1N3BOS0thRk9ub0Vzdm9OdFIwSm9KeHZEOXcx?=
 =?utf-8?B?VHFpNWFYS2VCTXhsMmlNUzNMVlVabnVhOHpQTWdkQUNZenE0N3psWnVMYlhD?=
 =?utf-8?B?UzFzRjN6VnI2amVSZXVqNmRtUG52akdGMldDRk0xRmFXamRBRzFKMDJDUWtx?=
 =?utf-8?B?VTFJNEQxYm95Ujd1Y1FVUGZNTlRBTkJ6cmF1bDc5NkpHTWlXNEc3V1p6NzV3?=
 =?utf-8?Q?+PCYMyJQhRVFet54Fr?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f7f6077-bc72-4cec-edaf-08deecdada36
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 19:03:04.2034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w5ZYpw1dJROBU+f3D2fhJMcTdUPbktTB6w4aWmaQH3ntbbOhmkzf6/1B8KeU7XROqo/Om06qN1NGim7dFsuNxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO9P265MB7801

On Tue Jul 28, 2026 at 7:56 PM BST, Danilo Krummrich wrote:
> On Tue Jul 28, 2026 at 8:26 PM CEST, Gary Guo wrote:
>> On Tue Jul 28, 2026 at 6:01 PM BST, Danilo Krummrich wrote:
>>> I may have a slight preference for a separate subregion() variant for t=
he
>>> purpose of working around generic_const_exprs, as it probably is a bit =
closer to
>>> the final solution, but trait methods are fine with me too.
>>
>> I am not sure that's the final solution that I want. I want arg-position
>> const-generics which would syntactically look more similar to `build_ass=
ert!`.
>
> arg-position const generics would be great, but that's just a syntax diff=
erence
> and not related to supporting expressions involving const generics?
>
> In any case, I think my point about being closer to the final solution ho=
lds
> regardless.
>
>> Personally I think most issues with `build_assert!` can be fixed by havi=
ng
>> lints, which is on my radar.
>
> I think it can be improved, but in the end it relies on compiler optimiza=
tion
> that may or may not happen as expected.

It'd be a compiler bug if const folding is expected to happen, the whole
BUILD_BUG_ON depends on it working.

`build_assert!` is a useful tool that I'm not giving up. If there is a need=
 to
use it, then I'd use it compared to having two variants to do the same thin=
g
with different syntax.

Best,
Gary

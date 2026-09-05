Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022120.outbound.protection.outlook.com [52.101.101.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192A3322C73;
	Sat,  5 Sep 2026 23:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788651161; cv=fail; b=lSzth5RUjzD/XUiTYIKr4HVYxWs1BcnbuuLjxQPnGDprulYOXFjgBvbvIZxfdF0CHQFsILHOitCxErue6gLA+MZOgrX2b88qf88ECxlkpKFnmCUbpez8lD0JV3EJlYr1bXSLvGthXE4YH3qp06ZHMA1iwAryO2Mx8FCJMlLix6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788651161; c=relaxed/simple;
	bh=R6jp99bRIZED4TSzot7iBUIRDFlRTv9U+1PC9s32H2g=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=sKil88pvw4+JBTiLads8QBqXBcsa/RA9CCQSjp/7IG1syzXwhKlQWeK7CUIFXrDpCaNucQXgWDx0N3WIRAv5oxOGDaLiF1aer3kx6yZYdK7yCvz8vpczW+NabX67gRCZtK+rmPMVEZixNErOnlZIlbdsrRjoCw8PHC+umUjNxI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=VFGNARHH; arc=fail smtp.client-ip=52.101.101.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="VFGNARHH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dAvRhrFYZkMXBJpcbJJ/lIIqZ6HjpM3Ag/m6I38SkYFXk+vPLaV3n72fgdAtPCCOUoET/25qXVItUjOVtkYSrMZGEfv592zJ2513yn8r2TZUSMamFdFP0xecOIL9DyJEwcyQCS3/V4ZOIz43nx/uOpz9YkU3++uqlUg6fsn1g4HxAWrROM3B2PLVfCpM1XCHkFDbXBhPNCO7sWs6uMZiYcCQv2tcOqpNiWGrvr0oBTLnzzeYnwd3f417vDzjvpMiATOmpi3YzxQtoZ0dWzlLtA6bDIPYFjiHmGivXpEDV2QDO4806qd+9sYsNwT0gpQoLPVfOT0kO7vRG2u6b8mziA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4k8FLvNwHhAb4SZo9hiMdWeCIkOp4k2nDFc5G2ofxl0=;
 b=jPp3yeRMyG0mLnmP6lp+jAnqrHVGRYew04YFTNVAx3IFDrGsF5WJ+Xg4DxFdqOLK6Qx0jdhOyjEOOcDOspArcbl9sFWn85mf9hQD5DNwkydH702fi1wugi4vJsijRk03+rPPzad+kmaRNtuAFF5d3JVVtyx+cupQv/rC8snzxnTRPw1fB676iLhqBiUTMsRNrHuvyEwXbcH4WISYgiVVSEI4ll9UKXW1bHPUHJFtug+NkE+xivHVINSkaRt6kPgNbadvQApoCKKnm3cCqTSoTKgyyDnTU0tswKe6e5ODhY6cBCDHC5evENNlgTyfxKiLec3qYhX/ZlQOtSuabpd5PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4k8FLvNwHhAb4SZo9hiMdWeCIkOp4k2nDFc5G2ofxl0=;
 b=VFGNARHHj+uwgPiTpRw1Mq4YdTrbWEqTz1FQz7bei4Yj1RdfDtbVy6zBpaoHyP7i2QuxeoO/YtE45JJoQBnEleZ3R3LlqAn1oG+XTjgmizvju5uVWvLDna0xBDF/uF7mM+bWyMY8PoVTgHXelm//LoaTMVsRHIfvV0lTEptSmRw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by LO5P265MB9367.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4c5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Sat, 5 Sep
 2026 23:32:36 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0382.014; Sat, 5 Sep 2026
 23:32:36 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 06 Sep 2026 00:32:35 +0100
Message-Id: <DL7RX130417U.10PL9U4D6JU9L@garyguo.net>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "Daniel Almeida" <daniel.almeida@collabora.com>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Tamir Duberstein" <tamird@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, =?utf-8?q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 <driver-core@lists.linux.dev>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v4 03/16] rust: mem: add `AsRepr` and `AsReprMut`
From: "Gary Guo" <gary@garyguo.net>
To: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>, "Gary Guo"
 <gary@garyguo.net>
X-Mailer: aerc 0.22.0
References: <20260901-typed_register-v4-0-5552b1d59525@garyguo.net>
 <20260901-typed_register-v4-3-5552b1d59525@garyguo.net>
 <CANiq72nxtehkGdb9RZpd=MsjWzp9euoLw=MmCzvcqOgxxEwymg@mail.gmail.com>
In-Reply-To: <CANiq72nxtehkGdb9RZpd=MsjWzp9euoLw=MmCzvcqOgxxEwymg@mail.gmail.com>
X-ClientProxiedBy: LO4P123CA0264.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:194::17) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|LO5P265MB9367:EE_
X-MS-Office365-Filtering-Correlation-Id: b10b0471-7cb2-47a9-bd2f-08df0ba5f773
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|10070799003|366016|376014|7416014|10067099003|56012099006|4143699003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	J8cuk3Q0JAHS0+yqnjJPGo/We1AOhtPm3zAhbw1a89JXag1n5dKqaLx0+Fz8q7OP91BiE7cpL6DKe8JxknK8/zib4CPSvtP6GP2HBVpN6ap9zLoedf1C2T7pqUu5VKwVGogdpgP+2On02UVIrrJsOA+sepFX9KG3SNaz0dzqUF21GknDSFD21t7UsT1pu4oWz63mk1u7SgGbArY8jUXZF++hRFm5IcH4JFh7+o1MuyoTPsY37U3T/JtsuZKocUHCv0cQHWm/hcs9VMMuPCMoForqVQoY288mqxLnZuAWAg0soyAPzWvD/byhxRwIp8YQtUtbrbR3n/B7jQtszNFKwShB7686KcdtCbb+RwYQoIpF24RCNsKPmFI9PwhbRsEzz6MlwIstS4qCxa4YQs+/ovkNbkNKoYGeHS5vQAU/+ohAiVF9EPAow28LtgWi9fLrxvADDjzdIJU896KLsGrVMuUL6iA59Tv3ClqCh5UsIjz5cpV4Z7jzXOEqK3nIXilUE2E4B7oCtejzDT6yg5EVsZpI0i9QABJqNKO6VyIopVgrYSrSQkj/MnuUhv+/sh1grS279UakWWP+lL7kUYK4TZU/KVOXrBJMFC3PCt90d3uFzQ534pn02eCPl34A/SB5ObSdbgqG6dQ4H/NEcLmKVk641h4yqPe8lkdZgCgYkiE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(10070799003)(366016)(376014)(7416014)(10067099003)(56012099006)(4143699003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eTBVL1ArODhRbEJYZ1Q4aXR0Q2pOMTVQODZnRDFVbFN0eWExbitFQzRjMXdz?=
 =?utf-8?B?a2hISjFNNExYemdOa2UzN1JId3BDeFdOVkU5d2J6ZjFUdjEwMXU1OFpwdTB4?=
 =?utf-8?B?NU1BYnNGb3VNMkgvQ1AxODNpVVNKUnMzMENEQjdGcVFZd3kzdUg2cWdrWnM4?=
 =?utf-8?B?bHBaSytNUmxERFhFWVpKMUFMSEpLWUZjZktlNDM4M3ovRW9CNjVabTNycC85?=
 =?utf-8?B?c0xrbkFTR05yOFQ3UFRqRHJGT29yd3dNaGlFMGpXNGFrTU9mbENSK1lYUVMx?=
 =?utf-8?B?NEtBM1pSV2Z0cXdqdTE5ejJjL2E1dWlMU1B5SWpQcEZuSWk1OTBwRHAwMS83?=
 =?utf-8?B?ck1GQ2FwOE01ajBqRWcvZmtNUTZwNGlQUHp2UXVRTXM4ZWlTVGNaSmErak5G?=
 =?utf-8?B?MUtLMUhnUHAvVVp2Yy9kMWhwWWt5ZGx5UVJPa1pObTBWalRLbGptUXZxOHVn?=
 =?utf-8?B?MHFQWjB2MXRjNWtNbGJWcFU0SHBob0k2ajB2Zi8xTE02bW5VR2VwOVVjeTZK?=
 =?utf-8?B?alN2SDF6ZER0SHVvOGJVSEFlSVViZVpFZDdFZCtWVGVpOWdaUVRNNkI5M1U0?=
 =?utf-8?B?dWhOZXpDdHlHdHE2MXY0SG15RnVGL3JxNzFHYWFpalM5L2thVFJzcUd1cnU2?=
 =?utf-8?B?bDJEeFN2eU5uSHNMRjhWeEs5cGRvYjZqdk5PaUFDUFRDdDlBUGt3d3lMTXF6?=
 =?utf-8?B?c0xQaXV1UHVjL0pJQURKNURwNFN1TGpzVTYwbGlWVGFkMTBIaVFyQnZNWC8w?=
 =?utf-8?B?bWoyV0pQM3g5QUpXTzdmNDZmQzBHSGtVVjdRZG5xeCs1LzdCbVFGSXpLcStP?=
 =?utf-8?B?VEUrSTluWlJSM3dJUFpxMVJwOUNvUm03VzJHQUdPSVcrKzF2SkNqRTZSaVYx?=
 =?utf-8?B?TTNmWGhSNjRtaFNwTlloMDR1QUIweXBNV1R2UXVxazl5WTFKc0hoUk1XZEhM?=
 =?utf-8?B?bmNHU21IZE1vWDVKaVFWQkc5TjloV3U5SXI4L0dKQTkybkQ5MC9NcmUwVS95?=
 =?utf-8?B?NmlhSjhqY253N1NWdHVKVVEzYllPSDhpelVNbkl2cTFzOUNQbzQzQU95VnNz?=
 =?utf-8?B?ZzlxUmlvNTFJMkdJeFgvQ0owV08wL1V4RUhtaDRPbXdQbVRmUkFpdFNodFFD?=
 =?utf-8?B?MFhyVFJEeVJxaWJJNlhreUsrOW5TNTJmd1R1bjFEUUkyeVJPSUtvTTNvSFFP?=
 =?utf-8?B?K1NRR3AvRzZmazVFMUNGVUpoOWwva0tXaWZhR3JzNEd4OWhtMC82djE1TkhP?=
 =?utf-8?B?dzgvZlM1SjNqbnVlVVVyYkpLMitKVlFwZ1NjK1NjaDJYY29jdGdMM1N6cUFs?=
 =?utf-8?B?cytwWC9xT3E0MWlWWWFnRzRNbU9pZUZZcG8rNnRwSHNGdDh3a0RZREk5OVJO?=
 =?utf-8?B?RmFHYUpnc3VIb2tRdWZEUzROMitTeWExNGgxOVE3cmUvS2Q1WVY2T0FuSXRF?=
 =?utf-8?B?K1lnSU5TM3lEcEE4YXltVG1zbXpJdkhGVndYREN4clorMENqR0lRYTJad3Bt?=
 =?utf-8?B?QXdaZkVyaUNobkY3ZkVXcFhDMHlRSmE5ekIvK2RITmN0OEtBbGozRTVCM040?=
 =?utf-8?B?MUE5QkR5dUxoZitPOHd6SE1paVYyWjlLSklXUWxrYTZiQlVUMFdRZlBNNmtl?=
 =?utf-8?B?amdsOUVrZW9TY1RyMHFzcW5ub1hseWpMK1F0NDlvZEJQOUdYQmczbW94NDls?=
 =?utf-8?B?VWdMTm14cUhCRmtab2NpZ1IwbzBSbzRXM0xZcHgzQi9EYVp0bGpoU3FwcXVK?=
 =?utf-8?B?NkR5VnphTjNpVXFoNnN3cDhPTjBJM0lhZkhqeGNGV2tkK0plZGJrTDFvaHRz?=
 =?utf-8?B?MFd5c21jTE43UDFTZCtxY2VIb0ZMQnk1ZEpJR2dmTCtUWnNrYVJrVGNCempO?=
 =?utf-8?B?aHpHeFg1RDJ2TkxCZVZ0elhiZEU0b25paVNvZjdxZnJ1aG5GMVBFRlh0bEVm?=
 =?utf-8?B?dFhmMGRvT1RURUhUVTlHRzBtdjBQYWZHc3dXcnZ5dDM2dm9tMU05c05wU2Q2?=
 =?utf-8?B?blBlYXNTTzZ2QWIrWkJLWnBWbzVwWkNBeXBXWkFCTkU4dXJoNGthTVZreDMz?=
 =?utf-8?B?YkVEYjFsMis1U09rZWdRcElTSktBRy8rbkg1T040Q2hFTlFucnJIUWhDZGZr?=
 =?utf-8?B?VDgrUGpzWU11RUdiVUhZc2NJTGhVN3JENWt2YjBXZEJmUmQ1OUhmNlRXRXJk?=
 =?utf-8?B?N3Z3TnZic093Tmg5T3NDcGJJN0x2dEFqU0xXa1M0cDRmdy9vWk0zSFlBQmtv?=
 =?utf-8?B?dUNNODYwZ2w4ek1zOVRBcG9nTkwyT2NNZTNqVzNNS3REYXE2WW5ZWnhXcFRu?=
 =?utf-8?B?ckZrOU1ZL3RHTzZ5OG1ZQUF5U2sySTZPWmIrWVhOcjZKNG5iSmRsZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: b10b0471-7cb2-47a9-bd2f-08df0ba5f773
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2026 23:32:36.0060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MdjhwE+bnTq1J7lK6IdUXgY0bXRRrxeqOeBm8CuD1wezsuYwhN2sHCdSUbu5qrBc3cGvHeMsFqIPz4CRuwNwDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO5P265MB9367

On Sat Sep 5, 2026 at 8:22 PM BST, Miguel Ojeda wrote:
> On Tue, Sep 1, 2026 at 6:50=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>>
>> +    /// Convert from `Self` to [`Self::Repr`].
>
> I think [`Self`] etc. work too.

I'm not sure why we'd want a self link.

Best,
Gary

>
>> +/// - [`Self`] must be [transmutable] from [`Self::Repr`].
>
> We say "can" in the `AsRepr` one -- we should be consistent.
>
>> +// SAFETY: `bool` has the same size and alignment as `u8`, and Rust gua=
rantees that `bool` has
>> +// only two valid bit patterns: 0 (false) and 1 (true). Thus `bool` can=
 be transmuted to `u8`.
>
> `false`, `true`
>
>> +        // SAFETY: $unsigned has the same size and alignment with itsel=
f, and is transmutable to
>
> `$unsigned` (a few below).
>
> Cheers,
> Miguel



Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021143.outbound.protection.outlook.com [52.101.95.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09BD40860D;
	Tue,  9 Jun 2026 12:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.143
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781009099; cv=fail; b=t1YndWZo6+bTs4wH8ihQcH87xOY2s5FdNC9CI9A1U5BhrgbQZ5E4y7J/ypQeUaJQ+834/oavcYcOrv1xISnbnKweMI1lBx4cXAYqT2iDNF68w8Caf/8fn8YC6bQ3LUZxc4Z8w2Rreno+J0wyJotRngY3AEocLcj7tM52td4nzQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781009099; c=relaxed/simple;
	bh=BAa4B7xlc9aulbSZecuAdUWzmJrSjoCBFXOCmgFRVfE=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:References:
	 In-Reply-To:MIME-Version; b=fbJDcFIJUjA8rUqAOVco5yqJfjoC3lJ3wbosCs/ZEVUmpMJRuZ5uRtLh/+2CCqGByhQjIPP1WPcRwZT3ZUmM/a30z/qm9E0XiALbkQNJHI6YHqCILRzqb2A/yh01ktoy729iLwnEuapElErsVwd8YiPznKnwIQsFLc0SxlSNQCg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=ZuDGzaGo; arc=fail smtp.client-ip=52.101.95.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="ZuDGzaGo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e+/UbTCKbPROOvE9XSbh1bnY8KYU08RQEu6YTp9vhvO+sqhDYmPcG5Ujow63IXItwabmk18Mz9ZvgFo+BtEKw/Rur6Tze/KNWX3PMQleerfPL3LePoQqEBXihRcz7RAgkIozCTUnQ2rByS+QTfZNg5/GVAOgjRXD67FCw4hCsqYbF2nl0Zo9bqGfSRv+jAp+8TNPnWUw+txaPqIKi4Xn2880ky0Mwlr9brDLmsrrN5Ul9AqNjYZlZA219jSv3u68WEH2G2saf4vQcWrr8KaP5u/E/P81IoOpbquYRKAMX5UCklMEuV79rcHZf68rdz9u/vmfsKgFwZWOw5TrBzM+IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IziIHHUojx0I67odiQ07xacq7bqaD1j00XTspPleLLQ=;
 b=dVD4Jd2JL+nVhGt4hYz88NStvU563h5EOyaa5Zhy1tg1lxPTgcsb4BbewOFhWPZQuW+pZ5mAAeyF9VFrFLe/35w2LUNDUloGqDhRDAVBdF3+dhVco+HW7lQYfcPdRatUDoChdU0G5bSAaDOYDVyGYIMo8wVWG4BXYZRnVbyERrK8AXQh9N3LO5Z6KXBM8qWVT5HQvK6tO5oarTHUx+iZ+REvAwD+mTZkkGaZbBGHOog2lUliremAH7ee1VOK2q/R9TUICnZ2wdpRBGw15TzBYaCPFn3h7+RdY5SHZXUWq2VUfTV8+Bo1qpP1IwPp/7UD6kmrv9cUbO9DWKw256uZ0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IziIHHUojx0I67odiQ07xacq7bqaD1j00XTspPleLLQ=;
 b=ZuDGzaGosVhS/NG2u/m5u8CTss3YAV3cqAh69PRU4dFUzE1Aupj+Bzmx/DSySAtrdTbMCrYOvz0lzmYzB/OHPCt+lBLJLCTPEB8JtNFaUPt35H+Slt0E+7/vYijYaubRgt42pLOfss3RtRqEwyTDHXuFMmjbVFFm8Gj/olRFeTc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CW1P265MB9331.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:28f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Tue, 9 Jun 2026
 12:44:52 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 12:44:52 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 09 Jun 2026 13:44:51 +0100
Message-Id: <DJ4J15P03MPL.QU45B7NZNN0A@garyguo.net>
To: "Gary Guo" <gary@garyguo.net>, "Danilo Krummrich" <dakr@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Abdiel
 Janulgue" <abdiel.janulgue@gmail.com>, "Robin Murphy"
 <robin.murphy@arm.com>, "Alexandre Courbot" <acourbot@nvidia.com>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>
Cc: <driver-core@lists.linux.dev>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>, "Laura Nao"
 <laura.nao@collabora.com>
Subject: Re: [PATCH v3 00/19] rust: I/O type generalization and projection
From: "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.21.0
References: <20260608-io_projection-v3-0-c5cde13a5ec4@garyguo.net>
In-Reply-To: <20260608-io_projection-v3-0-c5cde13a5ec4@garyguo.net>
X-ClientProxiedBy: LO4P123CA0389.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18f::16) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CW1P265MB9331:EE_
X-MS-Office365-Filtering-Correlation-Id: 43f587a8-d424-4d37-8d66-08dec624e6b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|1800799024|10070799003|921020|56012099006|5023799004|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	daYV0M75aBile6wWKS6BQuJpWjrXRHI8+/Zo1S4iczbs/89/9hsHH0wyl1RXwrmZd9VlUfnLydSuy+MkYJr3/rhdR674cqL1eAskZBhSR4qJjugY7AA5+WTOChjX73idEML6prbCnGxHrgQCVLYp2XrxLFLkdzjHc257visU1d4Jlzi86P1Coo+H70W8YxMO0xy/kjWZV00y73QiZAITwFYX7Ii0ujRALKI6OoMiRK6AttfaU6GPVrGW1xukbmiUTmMWZL0ZTcryFFC6HSDBwzxu893d6xXeCnM/LyvnloqLv5YgiYPpLD4yXjQmHIcLm0stEVoad+hyvfYvidiOIWZsFW//jsQEZaVOFxF7kUsaJHqnBJ7r0YdgYisnP2r/02LqOCKDDgXOWt+7ny12tSuy+2oanTQGrW+jvPnTpUAo8k9bLS+Pf/Hy91VjSPw/rQfhwjMWcOuvYIvqrgnetqfvSvUj6c1QBzks1lCx0/s0OOxB3A/jxj9Gepct5NRAx7yYjiRYhRyW/UwVgInxzNcY/Vhr1z6Llxb47qWTfZ1D8s2Iii3ESKQ5RJTlsqywAjI2wPpud4mAX9NeYyeCPDBQXYeJ/1I8BhOXnbcxuzE6ZF0AFkHKG2WuEWryOrGbNTyOouyP2G7TBCoodaRpYJmPZm60Y0T/sDL1CjFtuqV3PWZ5XztkPzWk3P0HTq9S
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(10070799003)(921020)(56012099006)(5023799004)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QmVJbVd3VlR2QkUyTDBhUzFidXFmK2k5ODEzdHd2dG9Ea3E2ajc1aWlkUExR?=
 =?utf-8?B?WTZDQ2wwYUIrbWk4U1pxT3hZT2Z6QmJFUXA5SWFwRC9YelJwK2RwWVk5aTJY?=
 =?utf-8?B?N0tEeFdacVE2UnpDcU9BQ1ZjOWdjSXVYOTJ6SVd3QXYybm40R0FMZFhmRUs4?=
 =?utf-8?B?MUFwUlFaRjFyMU5STjd4bVM1T2MvWHYyRVBpTkpXb0d6cStibkV4YStYSjNz?=
 =?utf-8?B?UVhuVFZLNEIrTlRxYy96ZHlQcURLT1ZIYmxpZjl2TGQ3UytNMy9pU1o5S1gv?=
 =?utf-8?B?c1lWUDBpRGlsSHFVa1V4ZHIybksvay9iMnlGQnBKY3ozclVZUFhoeTRoQVZD?=
 =?utf-8?B?SEtCMDNsVGRUd29kUVJnaDV2UEFiREI3Vm5la21vR2tJczg1OU00Mi9TZi9E?=
 =?utf-8?B?d3hjajZBWjhPZDJlYStJaG8wSzZtSldyZ2RHbTRDcFdzMHpybmE5ZCtrREhx?=
 =?utf-8?B?WGFjMitZNlhuOVZHQkxDWnN4eVQwUzFTbVFkalkyRVR5Y1gwTktrOVZ4NTUw?=
 =?utf-8?B?eUdtdW1pMTVmMlB5c1B1bmhRazBwVS9EaFFFc2xmMzZ0TGtSclJXSkk0SzNS?=
 =?utf-8?B?bXA5S2tGUGV1YTlxRiszVThTSHl3VWtMa2pzRnVWMVlPZkFVMU51ZVNOU2ZI?=
 =?utf-8?B?Zmg3ZktUcHZLcHNValJyVG9wTUFpaUdMUWVnTkhzbGprRG4wY29tNUZrZzlX?=
 =?utf-8?B?U013UkpNSCthdlVkQmRleHhFT3lFcmo3aFVEMDE0S1ZMM0txOVFxbmZKVnho?=
 =?utf-8?B?VEY0VlBLazRHN0hBRVVoSGp4cVdmcHBKK2R3cWxYb2E5ZmdoVVBCa2luSDBL?=
 =?utf-8?B?N2pacXVxL2VXUmNYOHphODBCeUQ5b0NiU1BBcXd3L1JReWRJVjdKYktoQTdW?=
 =?utf-8?B?Z2JNVmZER3pBMEtheVFWN2Fwa2drUWZVRFkyUXM5aEl5cGxVZWFaT0tLVlgx?=
 =?utf-8?B?cVVUWU42aHVHSzJ5ZUpXZXJwa1J6VEZVeENmK3N5STdRam1Cb3I1TEd3UHpQ?=
 =?utf-8?B?MEFCcGtjSFIxUVJZZWFYSlYyenZieERGWFlMZ3lUaGhpMWxqdVd5Wk5GRm9J?=
 =?utf-8?B?MUs2akY4cGxOMzExdHU4RGFPSzFUMXAzWEovaGcwRy8rRHJpRzdaVXdFbFBi?=
 =?utf-8?B?aW44bU9tYmVhVktQc2lGeHBaa0xlZ0FySUNjeGN1L09tQlFQbVRmWDZON09a?=
 =?utf-8?B?MGZQUjlYTnlQQzdBWFdRclZRVHRCWG50Q2dlUVgwMUVtRld6ZnRFdmlMa1lN?=
 =?utf-8?B?aUVTMjRxNlZaVWgwUDRwWGpmM1lZWXhIOUJ6T0RRbTVzdG4vS1Z0b2tzR1lo?=
 =?utf-8?B?K3laTElDb216eDVwMDNhSjZqUm9GNlR5cGcrNTFQK2VtUnhRUktzdEtobUZt?=
 =?utf-8?B?ckVIa1p0Z0xVa0wrZVFKYTZScURXTzVYY1J3NU56TjlZRE0vdi9oY214MVQv?=
 =?utf-8?B?Q2RreVc3aVIzVFBjQjRyYThHaWxoUW13VHBtd29xbndkbnd2YWJYRWhGZHUy?=
 =?utf-8?B?am1jTHFwNHQvZndvbjRBRUJRMVo0aVplcDB2ZTFoOWpFaWVpaUx1Q21rQ3Ju?=
 =?utf-8?B?VitsclhDSUFKSDRWVWtpVnpUTXNKa0Z0SVo1U0hUVy9nN2VjMk9RSHY4bVox?=
 =?utf-8?B?Tml2ZHI2ek9MUkp4RGtudm1kcXlSUVhaMm8zVE9HQWw4eEQxc2E5M2gySGZy?=
 =?utf-8?B?dVJYM2pqNVBybk9ZZkRmYnlWdnZWNnliUUZselVmc01yV28zNkt0MG9kUkN0?=
 =?utf-8?B?bENpQXZJUXJGeVcxYmp2MjBHNDZLa3ZUK0NIRnFKYS91U0tWSlJmbG42OEdw?=
 =?utf-8?B?YlNtNWdKNHZ2UmN6cWJ3TDE5ckorSnZ4TWFJOGJBYXcvSzFja213YW5VRnFo?=
 =?utf-8?B?TXd4SXdBK0syWS9WTUdXSFNacEppalNiV0I5QjlQQTBrRFN1ZkZmRXZ1TFE3?=
 =?utf-8?B?Q3g4MXZIdzB2OUFuL25rdmV5WDlYM3N6bEFQSkVjZFd4U0RoVXVxNFZIMUNo?=
 =?utf-8?B?bDdYUVkxWHVBczMyd2JISktlMy9RVnBMV1JEZ096WFI0bW5LM3VXVHVaU3ll?=
 =?utf-8?B?Mk5OVjVxc1VYdGRDbFhYTmk5aTk3c0FBREZHeGxxNStuSGhpRHMyZVA4anRP?=
 =?utf-8?B?RFplRFhXVHFQemNhVjFwVkxxazRpTHVNdWJiTDlQd0cxQXlYMWx0aUJDZGpn?=
 =?utf-8?B?Q0orTjdpY1Y0RGtvL0FYVjcyYkE5RzBzQVY3NFZVM2hnMkkvSmo5SHlEdnl5?=
 =?utf-8?B?VnBETFJ2VUIxbmNOT2wvRzJJVStpaGYxOCsrNW1vSUZGb3ZyaS9aWUdjN1ZI?=
 =?utf-8?B?U0EzcitOT3FvdjI5TVJvcHVZallBd0h5U3NrS3FDR0tDSlowdHQrdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 43f587a8-d424-4d37-8d66-08dec624e6b4
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 12:44:52.5636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AT8XEmEiuYM+SEdy2EuLVL0Wfrlc94eQj0cyhodnucCUNl9v2+fkaR+jihPEaOHekvWGLp/9F4QQvnkTXQafKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P265MB9331

On Mon Jun 8, 2026 at 8:58 PM BST, Gary Guo wrote:
> This series present a major rework of I/O types, as a summary:
>
> - Make I/O regions typed. The existing untyped region still exists
>   with a dynamically sized `Region` type.
>
> - Create I/O view types to represent subregion of a full I/O region mappe=
d.
>   A projection macro is added to allow safely create such subviews.
>
> - Split I/O traits, make I/O views play a central role, avoid
>   duplicate monomorphization and less `unsafe` code.
>
> - Add a `SysMem` backend, and make `Coherent` implement `Io`.
>
> - Add copying methods (memcpy_{from,to}io and friends).
>
> This series generalize `Mmio` type from just an untyped region to typed
> representations (so `MmioRaw<T>` is `__iomem *T`). This allows us to remo=
ve
> the `IoKnownSize` trait; the information is sourced from just the pointer
> from the `KnownSize` trait instead.
>
> Building on top of that, `Mmio` and `ConfigSpace` have been converted to
> typed views of I/O regions rather than just a big chunk of untyped I/O
> memory. These changes made it possible to implement `Io` trait for
> `Coherent<T>`.
>
> Shared system memory, `SysMem` is also added to the series, given it
> similarity in implementation compared to `Coherent`. In fact, the series
> use `SysMem` to implement `Coherent`'s I/O methods.
>
> Built on these generalization, this series add `io_project!()`.
> `io_project!()` performs a safe way to project a bigger view to a small
> subviews, and some Nova code has been converted in this series to
> demonstrate cleanups possible with this addition.
>
> New `io_read!()`, `io_write!()` has been added that supersedes
> `dma_read!()`, `dma_write!()` macro. Although, they work for primitives
> only (to be exact, types that the backend is `IoCapable` of).
> One feature that was lost from the old `dma_read!()` and `dma_write!()`
> series was the ability to read/write a large structs. However, the
> semantics was unclear to begin with, as there was no guarantee about thei=
r
> atomicity even for structs that were small enough to fit in u32.
>
> For completeness, I've also included the support for copying methods,
> although this does not need to be taken together and can become a follow
> up.
>
> The last commit in the series is included for reference only, as a
> demonstration on how you can use all of this to implement `iosys_map` usi=
ng
> `Either` type. It automatically gains all the methods via `Io` trait and
> can be projected with the macros.

Sashiko points out a few issues. It repeatedly reported issues in multiple
places, but ultimately there're just 3 issues:

* `Region`'s alignment. Discussed on Zulip
  https://rust-for-linux.zulipchat.com/#narrow/channel/288089-General/topic=
/Generic.20I.2FO.20backends/with/601411822
  I'll just make this 4-byte aligned (and also check that size is multiple =
of
  4). Luckily none of the existing driver depends on 8-byte aligned regions=
.

* Missing `unsafe impl Send/Sync`. This is actually quite low severity (Sas=
hiko
  reported high) given it doesn't break drivers today (otherwise I'd noted =
them
  during compilation test). But I'll fix add in the next spin.

* `copy_from_io_slice` can trigger memcpy between two `SysMem` regions whic=
h
  overlap. This can be fixed by either using `memmove`, or perhaps dropping
  `copy_from_io_slice` methods until users arise (this method was asked by
  Danilo, maybe Danilo has some use cases in mind?), and we can change it t=
o
  `memmove` then. Anyhow copying methods can be delayed to its own patch se=
ries
  if there needs more discussion.

I'll leave the series on the list for a while before I send out a new versi=
on.
If you're reviewing you can assume the first two bullets points will be fix=
ed.

Best,
Gary

>
> ---
> Changes in v3:
> - This version presents a major rework from the last version, mostly insp=
ired
>   by discussions that happen during RustWeek. Notably, the new individual
>   view types are now the central piece of `Io` traits rather than an ad-h=
oc
>   addon using the `View` type. They also benefit from type-erasure; the
>   original type of `Mmio` or `Coherent` doesn't matter anymore for subvie=
ws.
>   This removes the need of specifying generics on types that take
>   `CoherentView` on Nova code, which is something that I'm not fully happ=
y
>   with in the last version.
> - Add `SysMem` backend and use it for `Coherent` (Laura Nao).
> - Add examples to copying methods and read_val/write_val (Andreas).
> - Add a reference patch on `Either` implementation.
> - Link to v2: https://patch.msgid.link/20260421-io_projection-v2-0-4c251c=
692ef4@garyguo.net
>
> Changes in v2:
> - Rebased on projection syntax rework
> - Added a new patch to forbid use of untyped I/O accessors and register
>   macros on typed I/O structs (Alex).
> - Fixed a few safety comments (Andreas).
> - Added a new patch that implements copying methods (see above).
> - Link to v1: https://lore.kernel.org/rust-for-linux/20260323153807.13607=
05-1-gary@kernel.org/

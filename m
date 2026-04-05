Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011047.outbound.protection.outlook.com [52.101.62.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6138248B;
	Sun,  5 Apr 2026 14:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775400971; cv=fail; b=VMpb3M5K+0hGqEq1NNjQvRfzDXjEZ9yzwZhPe7hIw/wXTzMpsXd+oOto+quIjsd5ZsuYkxkjd1OuSFde63VuJOrikFb0YePDCt+HfdAv3cfVHhoxXhY9/FznoOr8qyadJCEtOI1mvsmL+Mnf1VnQ9uq78a37ZudX92ribXRXvIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775400971; c=relaxed/simple;
	bh=UNXhz4fuU/f25AtQPr+Bvn/4dJJYAal7BF7wlPBNsvw=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=oSu2Mn5YiiGHH/z1Ur0nwA3Hbg8oR3y7E6/nEoH6si5odyDb0ReZnPjG2YCVVvfexfq4tXM7Er8/y99mTjh+fT8h3U9LrulcFi7WYC9izwBVJX3JAXxdqBgYn8VaWi7kYIEjtwYV2aB85M310cjIvS32qGsst0x+Nca0qNnljFw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=o4bv9ZvE; arc=fail smtp.client-ip=52.101.62.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="o4bv9ZvE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wyKbbAiZw+Nd5KjBb8H8bkwpalMq8MwnwHZAAkY8rbWerT2v5ApFQSnFDJe4k64itH91PHykEi+JFltSh037xVq86ssZfu9U6ej5yg+AdrRL5jwO5UfkGay/JtFeATmEw2kocHGIRLi77Nhd4Qyif992d8TFN+P7HJ2EziMr2NJHo8ZUeR1JsJOFNSKA0EO0AxRFO7ObY6ElYJ72M8p2vIrBp0385sHuM9mZpTAG4H2SPhEYIPyVVXE5NcAE6KzEVfi5r8yNNKqO7/mSM3m6gBgZR8+Vbiyy4UlaPEGYGUZaGfwyGBs0O5rgdf7JKUpE/ghd9s9zsAuJBE4cmrjpkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UNXhz4fuU/f25AtQPr+Bvn/4dJJYAal7BF7wlPBNsvw=;
 b=S+A1Rq8nwzZj4ctLfguHmbavhUdwsw0z+B0fUCrYxV5rUri/x2Cr2CxYWr/O1WiF6eJYASLqzbF9Wh9goz1RsAQRcyHXYbahfDXIDMqTmxtqRzuscjQ5LzRoX4Ln9PafueDv4xVg0tUZjSB/Mhm+mjTgOjramc2Hm9/EFQ64iy9wphRJblb+rmD9yHRJIXSUclu9tkfUMGZl8AsfgOWXb6CNCUCB9r3BnWuLwvfFY4ilVOsZ+4bMlPPLE1itsUhX2JyLL2BkRMqFRg6UzT3kXiaMH0kbyyKrLIh890C6BRrZQbVFZ/ZZMeZHEPxju0trzPyuJ3m3M+bT7B/541phZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UNXhz4fuU/f25AtQPr+Bvn/4dJJYAal7BF7wlPBNsvw=;
 b=o4bv9ZvE8TahmptX2aPAsMO9dnaGs229vfj5zUlPhWErK1XqJPX8LWw6jyhyUMVyerjFzozfl//B0EJnIP2owWhc6vjcX1GJs5T4tSrdUKDPIm3nlcOmQj9v+vLOLpshycY+XocNFE+Vq0PN4nqVv9Dxa2kIprRKcj3cybuwWwxZ7mdW70YWiZyaVK7U65NadiWUTN8Y5FfPkwKJSueZ07oUMxc+eBXaXjegGOp8qvgGDBkl0fMtrKocNq6T8TtPpZtoY5vZvI6RHG1VqFuSBd89eE0Q1w5R62jwFmqSH8O2391edKZGCqu7JCPn+OuHdr3HEI6CQhWCZd49iWSdSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CY5PR12MB6599.namprd12.prod.outlook.com (2603:10b6:930:41::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Sun, 5 Apr
 2026 14:56:07 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.20.9769.018; Sun, 5 Apr 2026
 14:56:07 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 05 Apr 2026 23:56:03 +0900
Message-Id: <DHLB4703ZJUX.371TA9OH871FG@nvidia.com>
Cc: "Gary Guo" <gary@garyguo.net>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun
 Feng" <boqun@kernel.org>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Daniel Almeida" <daniel.almeida@collabora.com>,
 "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 <rust-for-linux@vger.kernel.org>, <driver-core@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 3/8] rust: io: use pointer types instead of address
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Gary Guo" <gary@kernel.org>
References: <20260323153807.1360705-1-gary@kernel.org>
 <20260323153807.1360705-4-gary@kernel.org>
In-Reply-To: <20260323153807.1360705-4-gary@kernel.org>
X-ClientProxiedBy: TY4P301CA0023.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2b1::15) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CY5PR12MB6599:EE_
X-MS-Office365-Filtering-Correlation-Id: 48a6bf6c-6498-4180-28da-08de9323774b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|10070799003|376014|7416014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	v6H6xMgSkiez/2wqpk5q1li+qBe4dEkQoBNxjPF5cOjAohCdxDDcjsSOdQMbQo9yQ4HuDLgNVIo3KY20FjTRpN3SeKkn1eQCbP8XbRQY8rmrFeGNihO/7ce1Jvhu+AAP3r0ezR7pqvgsBLweN82GeGcDPK/5QowAIFvTCBtfBpl9+ZQfqhtLPeyNN7qUaMhgKHP/elHOU/w86YBJiDYU/snEQJqinGOx+LXEBeA2zJi0qN+DlSxbLL41CqIZY9eI7Xs9bsRsxCbHwSJ14+Wk0a7jYwkhVfmm5KDdB4nHe/ZelbrZVnh4fKiW+/gm8KgDVTm6lsO/ZahqRB7QoWmHfOBX5jSe4ANo0EUWHmZYl4OrwNhdnDOdKgguVuJHTN1C1rnERp3UcrEyRggBRIQ8pEBJoy7xENn08mDLPs6mi5DqMGCsF+Q5MVvek7ew84OFCublEbPHe4fu+NooBRq6NCw79HUj4tFw6YN1lO720+qs+TJepSks+zz7GUBm3MoWqqsoDvN6wEPL0X+p1B2e0RS01CB2qa76Vzxfzbt3K3w3FlIWrXw3MyCayDwuO5NVjHZGt3Iw8xwQzoVU5nZp0EsbKNE5XS9MA0W5YmMyEKuc5MG2QQ+4IuKJm8vWR1dB1gZa4qNj71eDPhktwOvMZY6+9GAi9Kqyu2+cYpnzcOyPsmvxuIRnwESo/9LALNk7vXXKqopp/bMe3PAhKS236q5uq1+mcBTccrCmFAAZjSs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(7416014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ekxOeXBBZmp0eWIxRUcrMFBBWi80VVNyMDVOTjBQcXQ3a3ZyeWFGREpaZVNx?=
 =?utf-8?B?Mnd4QnVPY0g4bDF6cE9jLzVYTnFNYmhLUjY2Vy9iZWQxOS9jbzhMSHhSWEdE?=
 =?utf-8?B?dTVKL0NrUEc1cVpCQWwySUhuZnBsM0tudmo1OU05dUJ1ZkpTRHdnQ1c3VDRF?=
 =?utf-8?B?d1kvYUQ4Zm1ZVHRUa3FIU0pkUUNWMFF0YmVXaW1pVk9WSEcydURvalRCRzla?=
 =?utf-8?B?VnNpbjhTSGFTNjBwblQvY3JkcEdjMFAyMmhWV2pTZUdEZ21qejE5Umk1dEpK?=
 =?utf-8?B?cHNGOFdKMGcwQUduOElMZ2Jva3gwSkpYbnZpMWY1bnRQTHFlbGNmOWR2VFV5?=
 =?utf-8?B?NVpPVG0veVEwaVdJWWdvNllaMDd6MG5ta09YeStveXFHSkpjVHlncmkyQk55?=
 =?utf-8?B?cFNJKzNwNmJnU2VMU0k5ckNZSXlIcjlKKzRmSDltamdQRUxpYUJXeDg4QmNC?=
 =?utf-8?B?aElDTm9VWVBaQXpmVmh3TXFadTZzV1N5dDgxQnBQMXR2M05sVXJ1MlA0Q2pQ?=
 =?utf-8?B?bGNNT2MrYW82R0hxTTlSRSsyQnpoaTBRdXltci9LVS91azJoWU1lNldjdkZM?=
 =?utf-8?B?bU0vUDVJdFBLMkJRL1RxUnhWRlV0d3R0bW5kbWdDdGd1ZHhFMWJPeGNjMjky?=
 =?utf-8?B?Nm52T0JCYWNJcWJvWEdVYkVpM24yV3NIY01OdHZNMUpYYWIrUklyQmF1K3Nj?=
 =?utf-8?B?Z1RSdmFkbk9pUnZqMmFOTXVXOFFJaVBFQzRwVWszbEhBQzQ0anBGMnQ2NTZp?=
 =?utf-8?B?SHE5TDA2QlRqMFRSU1hHcnpucjFxTUZMYU9YMjl6Y0xsdEJ5WlMwaWRQZGxY?=
 =?utf-8?B?SVRwQ1k1UWtXRkRFQXlYOVhyWkpIN2o3RzVURTB0NVpDV0xSLzBsS1JQMjhJ?=
 =?utf-8?B?NHNDaWJaRkFHUzVSMjBuSjN5aVdlanBPQTQxWFJKdi9vU1dldWp4Vm5ZSXBH?=
 =?utf-8?B?b1c1N2ZDYjIzcjczYllqdkxmM2NEWmZIQ212VEVTTjF6ZFc5bkdJalpZTm9t?=
 =?utf-8?B?NlRYY2lJS010cTEwYVZOM3JSQ0w0aHhWclVRRG9XMDE4RlZyK2ZtTkdWeVUr?=
 =?utf-8?B?RjBQM2xxd3hMWDE4MHQ1eUJyMk1URkppRkQzQ1lWNmhNNlp4NWVZcE9IcE9p?=
 =?utf-8?B?MTNDemlCcmNTSnNKRFIwanpqOWFtK0R3QWVZdHY0N1h4TzZlMWh2SVFweTJT?=
 =?utf-8?B?RXJxdGdmV2MrV1ZZZGk0TzBralEyaGhDOWZDM2t5VmlMdFFRelJoZE1BUEEz?=
 =?utf-8?B?bjkxUkxlMXBUbHpDdkQvbE9acXArKzFSRWdLVlRKdHpwd0NveHBXTWMrSWpY?=
 =?utf-8?B?bm1hZzBBYXZ6TmsweTR0cTVFN0diYlduamlmdDJqYmhMNG9kNEFXK1J5Mzkw?=
 =?utf-8?B?dytVOVppTGpveVdVYmdBRDFnSnR3LzB6UDhBa2QzN1c1VlZ4aCtTTFNoYS9p?=
 =?utf-8?B?K0ZEL1pZV1V0bHMycURBZzJSUzJiZG4xQm4rRUpNbEkwTXdUSkxMZzlTajVM?=
 =?utf-8?B?T1M1Y0RUWlpnOW5RMFdKYjlVVDludVZSZXZ6QWwwcWM3Z0VyWncrL0UvM084?=
 =?utf-8?B?aDZxRlJnQlozMVhveHJYcDFiYS9TREVFRVBrbUpXTEt6QTQ4dXRWaTB3TXAy?=
 =?utf-8?B?a2xRZGxEbEY3dk1wbzUvc284Z2toL2pXTExqSVF3Ymt4T1FpKy8xcWhXSWtM?=
 =?utf-8?B?WGFIZk9QNUF5dmtUZjZEUFZpYzR3Mm5YdTc2MzRCd0JWTVU4dFZmMGsrM2Zy?=
 =?utf-8?B?YlBFZmxOaFdLbFEycGNuVWRLaGhtd2xJOWp6eDhSemQrYkZvOHVaUXg4a3dS?=
 =?utf-8?B?Ym9vZ2Vjc1U2cFBDNW02VHNhMHlacVhYYjY2cHVSSzNRc0Q2N2ptQ0cySzU2?=
 =?utf-8?B?N2hKV1B4a3JrLzFFN0MzTk9wbllZNENSMFVDMFlsY1RNQlJETlZzc3hnSyti?=
 =?utf-8?B?V2N1aTZVK1lhbXdKNmZZaWxSZnZseE1Ebk5LOTRzZlJ2dTcya3JGd3VadzU3?=
 =?utf-8?B?dE5SWWk2bXZuYjdTOVFjQ3VRTjlVR3VZNkdDK09OVUQrbzNIcGJDNGtLa05s?=
 =?utf-8?B?ZDduTjJKdzlrVnBQdHAxbEFaQjl0bVp2SUs3a2NEa3habTdEUXgzeHhteE1n?=
 =?utf-8?B?ckRETW9NUW5jZEhOSS85SVJ4Y1M1UVlsMDRNUWFsbUdtN2ZCQ1ArR3hqUjFP?=
 =?utf-8?B?RVROYWVzYm9acHE0V3RkVzM4enJNK1llSHc1S2hpTC9DQk92WHJHWDNIT05B?=
 =?utf-8?B?WWVwWDVoekpEVzFzMU42VU5xa3p6QU5sZVZiVzBLQVVMbzVnd2I4VVdTMU1M?=
 =?utf-8?B?N2JoTEl0WlhMbDB4c1IyUUhTamcwMURYM2Y0UWwxMnBRYkQ5cHM0b3lmT0FS?=
 =?utf-8?Q?iPCYz5FSvDanqPDwfLxmCQUIsEsPj5Gw6NqdsaCGGHcHv?=
X-MS-Exchange-AntiSpam-MessageData-1: STSwn53ezed9ng==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48a6bf6c-6498-4180-28da-08de9323774b
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2026 14:56:07.0389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 25SDooAw035qAPEsrtQfsTns3CXt8/nVBZGChfK4WPs+CnQr397Dt+5tkqpjduUm139x4yjrXNEPvAQhw4K/tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6599

On Tue Mar 24, 2026 at 12:37 AM JST, Gary Guo wrote:
> From: Gary Guo <gary@garyguo.net>
>
> This carries the size information with the pointer type and metadata, mak=
es
> it possible to use I/O projections and paves the way for IO view types.
>
> With this change, minimum size information becomes available through type=
s;
> so `KnownSize::MIN_SIZE` can be used and `IoKnownSize` trait is no longer
> necessary. The trait is kept for compatibility and can be removed when
> users stop using it for bounds.

Do we have users of `IoKnownSize` that we need to keep it around? I
rebased your series on top of `drm-rust-next` for review and was able to
remove `IoKnownSize` entirely. If possible I'd suggest removing it early
in a dedicated patch right after this one.

>
> PCI config space uses only offsets and not pointers like MMIO; for this
> null pointers (with proper size metadata) is used. This is okay as I/O
> trait impl and I/O projections can operate on invalid pointers, and for P=
CI
> config space we will only use address info and ignore the provenance.
>
> The current safety comment on `io_read`/`io_write` does not cover the top=
ic
> about alignment, although this is guaranteed by checks in `Io`. Add it so
> it can be relied on by implementor of `IoCapable`.

This patch does quite a few things, is there room for splitting a bit more?

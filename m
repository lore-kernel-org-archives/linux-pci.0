Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022092.outbound.protection.outlook.com [52.101.96.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEBD201278;
	Thu, 11 Jun 2026 16:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781195309; cv=fail; b=Rxb/d6oldqxxrJ9MH82eBAxTppTrMY4OeAJXgs9mP38XNaDSejIWlAFVdRUrubB0lawCGru/bDEF6CXnmMxVYnHcI4mdPMewbY96jbfrwRMSyZV6NIaglLp9Jac0A98r3jYZTMHZQQ/VL9vo/LChTHC7rBMwuN13umh2QPrisBM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781195309; c=relaxed/simple;
	bh=dDJSS+snyNmdBaBhijLgfoKrB/4kKcK1CV18kcTD0v8=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=PgO9NN6U6pv9W5HHGo7mJXGBhihOH8tGQYnFat8RLRsltBeQomDRVn5s+FmA6AxLq3lKlDHdZNfYJYGyRyVzaneQMvOW0ncrYTdeAWmQeoNkKqevPcafWbAZZ/dWTI2FOnaRD0zqiB1TXYudnH/7GbCYsK89JbeYlWzRtC93l1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=dZD7iAbn; arc=fail smtp.client-ip=52.101.96.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="dZD7iAbn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vsc3oaLQ1Yx/fuAU+PyAyhURdqxhEvQg7ljyrJRUdCI+FE4qd3kIaEDjAO7cWBnGi4Es403IAc7i3lErMa6W8zGOU5iSkEARetyyoA9Icd8UbX/CwFTpbchAOsTsewS+FdtSLJDidHzTc81m4yZWeWA5JwsoC9DiSD/wNIIdRSlddPpTFw6h4lYv8XSpnaWtOyBsthnc82SRQyOWMBbMx72uwlP86ShASjBRO1Sz6RgAJZWzjsWHdwgonJYT6VzlJnmNPOUVoyJxmDGqXUvpG3tWc2Y8LXTQOm84rYvhNocRCyQM+aR24nPaDOywrC7lAuRmBbdjuRJY/ajCrrZvpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jek664UjGIGMWQVtANJJiuMnQCm4USLByUovwg+kOC4=;
 b=Cwy0NW8S3APTG/Yx9484b3zaUTFxsoJGOkjn3XIb0ODoo4KMhAXQLCpCeKCZfgBcdWwx1DZ9qIyGVeBAKQ3fhqm3lEnHCJX2oGbgOobKW4zmh6RASuRkg+YEi3WF4m/8jrbxSwHj+4MBUcbPXP0ZEdVn88XKa2EOv4s5B8YNWIsjalfcQeU+iMFvTUBF+dW3FylxC/SrqXZbwrK9oYbhjv/l8PgDLfTCOBdH4+bY3FkQSz4ajsIXY2VL2wudsOtqknpBuoNcCNAtEQAe6dfdHfs+dxQ/rCVAxQ++wmSRGazkwrx2B6a3A9SF5TzlRUfwYU/6jvw05OLu2CEytwnK9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jek664UjGIGMWQVtANJJiuMnQCm4USLByUovwg+kOC4=;
 b=dZD7iAbnMkRiAa5Mvy95rtKzPcJgo6GkR9DizWxtVp96GaSV+1aDSWAHW5v29dMEcloJ7JQkMEqfzVwqyHW8yKBauXdkE+RP8a0JCzOIJ1S/vgdR7XMksCgUbw3SP+p26ewhbwqOYFQ5D6k30voG7m2SX+9xqjnvjgYtO1cAo38=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:27c::13)
 by LO2P265MB3263.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:156::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Thu, 11 Jun
 2026 16:28:22 +0000
Received: from CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c9e:93c8:10db:e995]) by CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c9e:93c8:10db:e995%6]) with mapi id 15.21.0113.011; Thu, 11 Jun 2026
 16:28:22 +0000
From: Gary Guo <gary@garyguo.net>
Subject: [PATCH v4 00/20] rust: I/O type generalization and projection
Date: Thu, 11 Jun 2026 17:28:02 +0100
Message-Id: <20260611-io_projection-v4-0-1f7224b02dcb@garyguo.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIABPiKmoC/3WO0Q6CIBSGX8VxHQ0QsLrqPVprikelCzFAlnO+e
 2Btbm5d/mff9/9nRg6sBocu2YwsBO206WPghwypruxbwLqOGTHCJOGMYm0egzVPUD6SmEooaiW
 qsgCOojNYaPR77bvdv9mNVaJTyY+w8BrjkN+wTjtv7LR+EVi6/hsMDBPMFRNUyTODhl/b0k7ta
 I49eJS6Qr75kpz2fh59JVQNNC8FqJ2/LMsHemg8PRMBAAA=
X-Change-ID: 20260421-io_projection-16e7dc5ba7e4
To: Alice Ryhl <aliceryhl@google.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
 Robin Murphy <robin.murphy@arm.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: Danilo Krummrich <dakr@kernel.org>, driver-core@lists.linux.dev, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, Laura Nao <laura.nao@collabora.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781195301; l=7472;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=dDJSS+snyNmdBaBhijLgfoKrB/4kKcK1CV18kcTD0v8=;
 b=bnijkBz73/2vm0zdg/BU0a/M3Hskmos4/ukolP3Youx7eKx6Cj/6hTvA/0SnuvLKDrMe2Kbmr
 N9aBbNdWMOhA/Nipb7x7CQfytGjbjIzJzqwweGmc6a22tqjphiob6HF
X-Developer-Key: i=gary@garyguo.net; a=ed25519;
 pk=vB3uIX95SM4eVrIqo1DWNWKDKD2xzB+yLLLr0yOPYMo=
X-ClientProxiedBy: LO6P265CA0015.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:339::8) To CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:27c::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CW1P265MB8877:EE_|LO2P265MB3263:EE_
X-MS-Office365-Filtering-Correlation-Id: 081debfe-a9c5-41c3-9ba3-08dec7d67480
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|7416014|376014|366016|23010399003|18002099003|921020|5023799004|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info:
	ekwJ1PCC5H6S92a7pJxd8sxDfU4skcoJMrkonGFOIk0J0OngwTbqpS/sdt6W2wooC06YgLEij/rRo5faMAdIdEEyxGFTRkczFKEHlZt4qcw+Nvug2F1cTWSjF1hW8UNIhIRKSHOfXXIJ7gpriiUmjJQjHZi9OupHqdKIF8u4CRogFwCKZYN3SolWp8wPDa1GpUFAR4NnoUIxcGCn+TFjOezsh3oRTtS/WxEgGBNOpxf4VluWchfdZ5sdDrZSB3U+iNC5YOTz7ya10q0C7fExGL5faXCW8Zh8EY/2YEw71NBdfllG0FgjmoDBSbOD006wNw4HgnFL58JmfhIjXJqEL9yE5MaM7turHNJXknoipjNiirXLfvUB4zXbciHRKc8foMmcpoK+sfIcv5ho7dTcJARkq+XosXi5uo9dmRQuCOho3QejqyOshenfxCpcRlzZCla2PSLh4bnnpHeWnuI6+1p3MuKwiToatJnozzPEsxza6QhHMEBJn8Z3pvWL8QHJ4cg0X6XEjUNn7JachPKqrhj9eDn5JLGTd+9iGERCXzCk1/dBBKo27Zz01OKQOtPU9HLAsQ/20cOdtUFa0w54TUJw4pGIZXvh7Y9sCCzY1rYz73/FdmP6bEfxyRq+PKFJf1rWpO/4pGIDGoz434QegNcX+ZEGz0zWvRHrtemTy3z/gLzgiWWjEAYYrymqe6JC
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(7416014)(376014)(366016)(23010399003)(18002099003)(921020)(5023799004)(6133799003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YzhGVHlucGZYUHBZcnJ0Y1ZDSFpCS255Q0FZSkw3NVZHWGJxalVpeE1nUmpG?=
 =?utf-8?B?b1gwRE10WjIxT1hQbllVY3B4emlWSmtOb0dZUDZkeDFqY00xdVBkR1Z1T0RB?=
 =?utf-8?B?SzhiN1p6UEtmSVZseVZGK3NIMGRpQ0VRRGNoZmhkejhJSXVBRTErb0Q2WG9k?=
 =?utf-8?B?cTU2eVNGejFvQ21BaVlqSit3eks5R2dGMEVkUk9lK1BDUE00UjUxbHhJL2U4?=
 =?utf-8?B?L3lTcHpneWF1RTBFWms5V09tNUN5ZitORDJ2N3RDZ213NmVpMjlQNFJMeGg0?=
 =?utf-8?B?czhGcHM5VWJ1eWNMdkxXbWZmRFA5R0ZlVkxsYkZCeFI5dTZZK2VKTG1SUVpS?=
 =?utf-8?B?TGV6dmwxcmp5N3dyNEw2aWxmdjZ3WlUwcDFhdlh0Tk40SzZoWWtGak5ENGg2?=
 =?utf-8?B?SmtLOTd6QmFSbUswWlJzVzJEemdlRmtzcS9xVW1nYUcwZWlrNE10VVFsUWoz?=
 =?utf-8?B?R0lOT04yaytmazVPeFBEbUlIU01ibWFzcUo0RnN6MjhvWjhsZTVYUmJnNGoy?=
 =?utf-8?B?b09yWk1renZKa2NBS0tQQnNabjFMSm1tWFFZRnRvVXdNTkhSeXFJdGc0ZHRE?=
 =?utf-8?B?SUVnRmhpd1pFY0VjL3ViMk1nUWVJa1FMNS8rNERjcFNTU3ExNWdueC9sTDAw?=
 =?utf-8?B?aThFODNhNkpTZFVOVXpoUTdySWdxN21uWS9JcVQzOEhodmJVUGZzVkdLRG1F?=
 =?utf-8?B?WTNRN3hxNXlkQndPRTV0aEZVY3ErYnYzdkR5Si8rUXlsOGFYV09oOE5lUzZr?=
 =?utf-8?B?TVoxN2Z6VG1rQWNDeldZU0wxM2Jtb3RraTdGZFU3T2FYeENMODZic1ZWNTFn?=
 =?utf-8?B?SS9KSTJZcW1taHovWCtPL28yUlpTU25JY0NyNEhncGdhdS9PcmZTbXJRTytZ?=
 =?utf-8?B?ZUY3N05KUGxzRXNsbk9aUnBEbHBFRDJxcG5tcmNKRit6RG9nOFdpRW5CRC8z?=
 =?utf-8?B?YWpaMlNtWmpaTENrOHFDaXdkWjBETUY3eWFpcXhmWFRROTB2cXFOenRXcjRr?=
 =?utf-8?B?VnVWMTBFRkZ5bnZmREFYMmkxTTU1emJuRE5aZ29LQ0VJU1RML2lxZFhMN1Np?=
 =?utf-8?B?VnJMNXE3MlBueWt5R3lqY2luUTFWelJnMDNpTG5oMDBqak5sY1RkRUlTeThp?=
 =?utf-8?B?anY2M2c4MGxwQmQ4UmpITXdHVWhpMkhjK29VZnM0YnhWanBna3dGcjRqMXlT?=
 =?utf-8?B?RExVYU5FMi9kUGFUNEprOUMxOEVBZnRCaVpYOU5DYitaeTZOcEpjV3g3VXBt?=
 =?utf-8?B?Z2Z4eXBWZEZuckp1V1ZPUUdoNzVJTVFISmlxVU1KOVR5cWxjNnh6VUV6U2RP?=
 =?utf-8?B?bmVNdHkwYm1ZZVJ4Z2ZkdHFqUDU1VzRXdzErZFBxUzZsNWZFU3FUWTlLYmgv?=
 =?utf-8?B?bHJGZzFIQ3E0VDM4UDVCcnBqNWJ2c21qalZYUFhkYlpOMFdEOSsvUlhGcFpz?=
 =?utf-8?B?MTBNVlUxLzVHbnd1bEx6MUNoRWE0ZmxWNzc3dENwZjNOaThvTXBaQUYyWlRO?=
 =?utf-8?B?bXBEVG9OazRXMzhXbzVncjBpWlZETVZEVVk1SHlnaEt4bmNwUGNBMU1uWlM0?=
 =?utf-8?B?cHlHYnZLc2dZeFMvK3FFUWpXZzhKOUNtdzg4Q2V5V1hTUkU2V0E4U2FOSHY1?=
 =?utf-8?B?YTQ2bFlFRDR1bXI3bXJIeTdnQnV1bVJaaFlnaG54MWJkLzJVUFppTVFzYVZj?=
 =?utf-8?B?dFpZTSt0OWJsUWFhejlhMU5obzZXWmx0bTN6Tk1vekxMcVk5M2FpQUp1RmhV?=
 =?utf-8?B?ZkpEck51dm5oc05NSUVrbmdkelFxVHl2anB4UHpxbFh4RHQ3U1REczRWRyto?=
 =?utf-8?B?cGxNVGJLd0pYYkxEV0ZzajZFNllmUkdSWUo3NWQxZlREaUtxdXR5c3I4Mjl3?=
 =?utf-8?B?WlZlWFlYMS9qaUNVV0dyUTV0YTJwK3QvdHppNXBJUHdzOG9SQ281aVZ4cEty?=
 =?utf-8?B?MXhhVXJuNmp4cGRlNVcrN1haT3dPUnF0cEttcncxTDFlMWlkV283azd4bzky?=
 =?utf-8?B?REwwMmsxT0ozL3FCc2tBN1hkL3JlaUl5OUZMUTVacHd3blkwakNuRDU3clpq?=
 =?utf-8?B?VzdBellmL0RhTmZHb2RMbUNVa1FWU2pUUmdrVWpjU0RKNUVzNGJFd1FVZllq?=
 =?utf-8?B?YjhBYkdVVUJsSm01MTFjMlE5eEhZWmljRGtzWE5kako4ejFITXZJQ2NlOW1J?=
 =?utf-8?B?Qms1Z21GcVpGdFNmbE5BR3Q1V3VQcUxCcndIeFNMUzNsejhkK3B1L0Z2RXl6?=
 =?utf-8?B?cGZXeDRtTUlucFozZmR4YTZFUDlmTFgxRXJVeVJka29zVDRhdzNCZzZvd0lU?=
 =?utf-8?B?V1Z2WUtuOXFaSkI1TU1HaWxEMHVQbVRLWWxJYVExUjNEekFQcEx3UT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 081debfe-a9c5-41c3-9ba3-08dec7d67480
X-MS-Exchange-CrossTenant-AuthSource: CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 16:28:22.5881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zQpM+4u0hdjPuVsrkYPJ+25KyrPHQoJ4NwQN52gLPJHTr2xKDI8h4wAY7au6Nwdb85VO3IIDnnsbHHJcUYAl1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB3263

This series presents a major rework of I/O types, as a summary:

- Make I/O regions typed. The existing untyped region still exists
  with a dynamically sized `Region` type.

- Create I/O view types to represent subregion of a full I/O region mapped.
  A projection macro is added to allow safely create such subviews.

- Split I/O traits, make I/O views play a central role, avoid
  duplicate monomorphization and less `unsafe` code.

- Add a `SysMem` backend, and make `Coherent` implement `Io`.

- Add copying methods (memcpy_{from,to}io and friends).

This series generalize `Mmio` type from just an untyped region to typed
representations (so `MmioRaw<T>` is `__iomem *T`). This allows us to remove
the `IoKnownSize` trait; the information is sourced from just the pointer
from the `KnownSize` trait instead.

Building on top of that, `Mmio` and `ConfigSpace` have been converted to
typed views of I/O regions rather than just a big chunk of untyped I/O
memory. These changes made it possible to implement `Io` trait for
`Coherent<T>`.

Shared system memory, `SysMem` is also added to the series, given it
similarity in implementation compared to `Coherent`. In fact, the series
use `SysMem` to implement `Coherent`'s I/O methods.

Built on these generalization, this series add `io_project!()`.
`io_project!()` performs a safe way to project a bigger view to a small
subviews, and some Nova code has been converted in this series to
demonstrate cleanups possible with this addition.

New `io_read!()`, `io_write!()` has been added that supersedes
`dma_read!()`, `dma_write!()` macro. Although, they work for primitives
only (to be exact, types that the backend is `IoCapable` of).
One feature that was lost from the old `dma_read!()` and `dma_write!()`
series was the ability to read/write a large structs. However, the
semantics was unclear to begin with, as there was no guarantee about their
atomicity even for structs that were small enough to fit in u32.

For completeness, I've also included the support for copying methods,
although this does not need to be taken together and can become a follow
up.

The last commit in the series is a reference on how you'd implement
`iosys_map` using an enum type. It automatically gains all the methods via
`Io` trait and can be projected with the macros.

Suggested-by: Danilo Krummrich <dakr@kernel.org>
Link: https://rust-for-linux.zulipchat.com/#narrow/channel/288089-General/topic/Generic.20I.2FO.20backends/near/571198078
---
Changes in v4:
- Added `Send` and `Sync` for types that internally uses raw pointers. (Sashiko)
- Make `Region` always 4-byte aligned. (Sashiko)
- Removed `copy_from_io_slice` method due to unsoundness when regions
  overlap. (Sashiko) This means that `is_mapped` hack is not needed anymore
  so I've also cleaned up.
- Switch `FromBytes`/`IntoBytes` to zerocopy from kernel::transmute.
- Changed `Either` to specific-purpose `IoSysMap` enum (Miguel).
- Link to v3: https://patch.msgid.link/20260608-io_projection-v3-0-c5cde13a5ec4@garyguo.net

Changes in v3:
- This version presents a major rework from the last version, mostly inspired
  by discussions that happen during RustWeek. Notably, the new individual
  view types are now the central piece of `Io` traits rather than an ad-hoc
  addon using the `View` type. They also benefit from type-erasure; the
  original type of `Mmio` or `Coherent` doesn't matter anymore for subviews.
  This removes the need of specifying generics on types that take
  `CoherentView` on Nova code, which is something that I'm not fully happy
  with in the last version.
- Add `SysMem` backend and use it for `Coherent` (Laura Nao).
- Add examples to copying methods and read_val/write_val (Andreas).
- Add a reference patch on `Either` implementation.
- Link to v2: https://patch.msgid.link/20260421-io_projection-v2-0-4c251c692ef4@garyguo.net

Changes in v2:
- Rebased on projection syntax rework
- Added a new patch to forbid use of untyped I/O accessors and register
  macros on typed I/O structs (Alex).
- Fixed a few safety comments (Andreas).
- Added a new patch that implements copying methods (see above).
- Link to v1: https://lore.kernel.org/rust-for-linux/20260323153807.1360705-1-gary@kernel.org/

To: Danilo Krummrich <dakr@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
To: Daniel Almeida <daniel.almeida@collabora.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>
To: Boqun Feng <boqun@kernel.org>
To: Gary Guo <gary@garyguo.net>
To: Björn Roy Baron <bjorn3_gh@protonmail.com>
To: Benno Lossin <lossin@kernel.org>
To: Andreas Hindborg <a.hindborg@kernel.org>
To: Trevor Gross <tmgross@umich.edu>
To: Bjorn Helgaas <bhelgaas@google.com>
To: Krzysztof Wilczyński <kwilczynski@kernel.org>
To: Abdiel Janulgue <abdiel.janulgue@gmail.com>
To: Robin Murphy <robin.murphy@arm.com>
To: Alexandre Courbot <acourbot@nvidia.com>
To: David Airlie <airlied@gmail.com>
To: Simona Vetter <simona@ffwll.ch>
Cc: driver-core@lists.linux.dev
Cc: rust-for-linux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Cc: nova-gpu@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org

---
Gary Guo (19):
      rust: io: add dynamically-sized `Region` type
      rust: io: add missing safety requirement in `IoCapable` methods
      rust: io: restrict untyped IO access and `register!` to `Region`
      rust: io: implement `Io` on reference types instead
      rust: io: generalize `MmioRaw` to pointer to arbitrary type
      rust: io: rename `Mmio` to `MmioOwned`
      rust: io: implement `Mmio` as view type
      rust: pci: io: make `ConfigSpace` a view
      rust: io: use view types instead of addresses for `Io`
      rust: io: remove `MmioOwned`
      rust: io: move `Io` methods to extension trait
      rust: prelude: add `zerocopy{,_derive}::IntoBytes`
      rust: io: add projection macro and methods
      rust: io: implement a view type for `Coherent`
      rust: io: add `read_val` and `write_val` functions on `Io`
      gpu: nova-core: use I/O projection for cleaner encapsulation
      rust: dma: drop `dma_read!` and `dma_write!` API
      rust: io: add copying methods
      rust: io: implement `IoSysMap`

Laura Nao (1):
      rust: io: add I/O backend for system memory with volatile access

 drivers/gpu/nova-core/gsp.rs      |   53 +-
 drivers/gpu/nova-core/gsp/cmdq.rs |   66 +-
 drivers/gpu/nova-core/gsp/fw.rs   |   82 +--
 rust/helpers/io.c                 |   13 +
 rust/kernel/devres.rs             |   24 +-
 rust/kernel/dma.rs                |  280 +++----
 rust/kernel/io.rs                 | 1472 +++++++++++++++++++++++++++++--------
 rust/kernel/io/mem.rs             |   29 +-
 rust/kernel/io/poll.rs            |    6 +-
 rust/kernel/io/register.rs        |   45 +-
 rust/kernel/lib.rs                |    3 +
 rust/kernel/pci.rs                |    1 -
 rust/kernel/pci/io.rs             |  168 +++--
 rust/kernel/prelude.rs            |   10 +-
 rust/kernel/ptr.rs                |   12 +
 samples/rust/rust_dma.rs          |   12 +-
 16 files changed, 1604 insertions(+), 672 deletions(-)
---
base-commit: abe651837cb394f76d738a7a747322fca3bf17ba
change-id: 20260421-io_projection-16e7dc5ba7e4

Best regards,
--  
Gary Guo <gary@garyguo.net>


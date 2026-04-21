Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020082.outbound.protection.outlook.com [52.101.196.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3EF3D6470;
	Tue, 21 Apr 2026 14:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776783393; cv=fail; b=BsG2eaMp4fZmPXeiNMmse79wOnF1nB+gjF2srxwnAgL198n58WTLH4nGfKtPt9KUZprAZBN7CWB9j57SX3DuqENmLytwlMybLvCTNzr1qCvYVnFWoX0iiSZaHkNV7AWzxCWA1g8Ytoqqx0DhdEnXHJKAWs8fCLzmQhvouZepCYM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776783393; c=relaxed/simple;
	bh=faM0ZpteUlJaNJZMTjGbI7mkrrDCMYhjEeLbY0rM2bo=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=aS83v+UqhyVKs0qa2F6Reef9HFld/ZR/iS4gpJknhMyCleiGqLZfcZEFx3VHkCpKOyE026TEVdDAeziKRdOdFz5tcxvtdAyuic0aw5rZKTWwyLNwE3YeY6qkvhfOZuwnLeqekwFHdaJ9y7JEIFQHRIGfH3ygJWOq4PZfRYFCb+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=PdfOfMNU; arc=fail smtp.client-ip=52.101.196.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="PdfOfMNU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rFE60l3M40jhyfxqTJ3WbjshygQqWA03GuWwXsIA3vMo1n6x3Zl+F4HNxqVjsCbZsXO78DX3panenH+St1Ws5ckjw+nA7qEQwRw+jVijj+sg+0QNZpVhKv9eEC6NiAwmYBvopNUnPzDLnOoM6ctZY2bwYr1PrR184cE5JgHuZH1IAQ3baS2etrY/A/ZOvx1uPmV0B3TK+rCi3HHY8KBeNvlpIiYuBRfhgS7boN+S9i9jkeUns9Lx3/yx1ErGTOCZ+AGXAYeRs9dn4zUHUdMWUjbQEZD/xC7ywonrSGl3cllZVtwYKAc6wcKqHBjnUY9oRBTEaAbS2DL9xY6tBXOD1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RpvjKQBEOTrrEFGy3XscM4znZyZdhB2MI4KZHqsSb6c=;
 b=KOd7sNWS8e3HTQ2d2DtQ1QJc7o3mijFfH3FXoIWhthvVSzuDlDzCwsE5DeV/zsWDPPB7vPT8q4cA7AhjfANWDme5K/dVmQuxtuz95Ti2qoh4/4wb/pKzSPwGZESDE7mB/zupT6h43Ah5x4GS17bDrkzEGAtHC3xljwtVjHmdAfa+1jbWLJAueT/L+3nmGgmm9UlW3JaBZGoCR03wLFgFCTuwnmmDVeZdNRfWoqgfK9jUmnvgH/SyzLMCnXOqbdawteqB2zvZpJzneA4smOWhPG7WOcHSEeGbls8VnzEMpS0XFqUmYzPfTPKtVHpKsy9Q6PlZVRpRhRRioOxeIbYPjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RpvjKQBEOTrrEFGy3XscM4znZyZdhB2MI4KZHqsSb6c=;
 b=PdfOfMNUKHNtdorRxVXdTxATKwEaxn4HtyhJmqXVHtKoA/4PKDMfXHhmPSZwm5L7oy4+3rndVgUe6dO7l1NfvAbviGjc4WMBDDXpAK/yt1kCVzfmg9up6MAIcRJMhPIK+YjWmL56AAz427Kt+dqfyt8ZB4ur4cdiivP47plkc+0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWLP265MB5523.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1b9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 14:56:28 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 14:56:28 +0000
From: Gary Guo <gary@garyguo.net>
Date: Tue, 21 Apr 2026 15:56:13 +0100
Subject: [PATCH v2 02/11] rust: io: generalize `Mmio` to arbitrary type
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-io_projection-v2-2-4c251c692ef4@garyguo.net>
References: <20260421-io_projection-v2-0-4c251c692ef4@garyguo.net>
In-Reply-To: <20260421-io_projection-v2-0-4c251c692ef4@garyguo.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
 Robin Murphy <robin.murphy@arm.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776783386; l=16534;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=faM0ZpteUlJaNJZMTjGbI7mkrrDCMYhjEeLbY0rM2bo=;
 b=81Koxp9RJC3hxba8mvXB9afBclGGtwdgEORR2NJq9fXTkJLb+ZFGPnT3+B6KfTXXlIvs4Bs+O
 PGABNSh/1QlDu2wVLUmPExo7yUiXX7d2AHyiU6B+NusmGMXfJ8fpF7f
X-Developer-Key: i=gary@garyguo.net; a=ed25519;
 pk=vB3uIX95SM4eVrIqo1DWNWKDKD2xzB+yLLLr0yOPYMo=
X-ClientProxiedBy: LO4P123CA0142.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:193::21) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWLP265MB5523:EE_
X-MS-Office365-Filtering-Correlation-Id: bac75a47-46e5-4887-4111-08de9fb62a5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|10070799003|366016|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	OF8sboWGzHfUwFY3SIMlSqEGA6LX30q1Ln7K/Bt1cSMIgxTJD2kXsPgX9pmBbQDykFBH4jyk4IB+2Esxo7l2DEtnAeX0DqzPnc48GIq+TZulXbx/49J5+AOtK2cEQjgdq0kKcyGFNOr9lkEiSVRzxW9WDfDyVF/pCEDWzPy2S7beKgOKzCUvINr+Vuj09W0YcjD/9rMpJbxbKiOxmbkWBSW8++UkSaIIrJicUk84X0T+xx9oNKpsSvRxpeD7VjWp5UYnQG6qzawLNCu/Y0ZF/QKBAcYrqaQ7hmKWftMLGrgrmnQZV4ixo4+Xh8m7g9roewyVzMfNkiDDoYEQsvqyRcmwFZwbMt73z183hWpcAL5TaD+FyQy9mBgw5aLRLbsxNLF3FFE1t+ZVJcbeiSYV9WUxSqCGCzIBVMz+AxJ7ICyN9ZduOncFBVcRxyZ0T7x7OwIxqLxE0EsVsfCutoiS1bf5vMmz0JoukkS6YlsTNU5qaynylh/YM7USkBO9b6K+LCwz7we0+FLF7DbGLUaDSIw+FcSFfujQfb3GGFQMXRpkX/pV/cU/HXwZdjZnvDVTZKcQLj8paWTgcLYodUuRqq4nwjpN/2H4Q5k+TAUvqjEDqEPEL2VFSgbg+oVDqnfW2vCD8Smd0INuIdzEu+/jdgtFm1QLFxFS4taK9R9NDuLR1nY9GXI28aSYpQoKh2ge/troeo7+RHibMMTc13Qr/dbt1CEHSqrZsoFUh4mg9Z3eDzUP7mrYcqW8xDQ/VZUJTRlK0dODxN/V+4SCza0lnA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(10070799003)(366016)(921020)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UnNkcDljUS9QMGpSSmlLM3ZkcC80Qm5PbnJLZS9JUnIrbmhDUm9YeXhMNFF3?=
 =?utf-8?B?THVsbDdqNDUzeTdDZjdWVlFEbTJpbUtzNHJwTmZHdUc5eG4rKzNnaXBObDdl?=
 =?utf-8?B?TjBjOWgzZlAvcVFxcVNQdW1kL3UrNGRhcktpcVhnRmFhTTZmTXZjQkkxVTN6?=
 =?utf-8?B?Rk9tUlUrNzNJaTN0YkYxSjNDQXBNOGxZVnFSenV4SzBKeVJYeUt2eE1vVCt1?=
 =?utf-8?B?cVJsNUg2RERIRTErQ1ljZUJSSit1TmdHVlJqUlQ1ZUNVM3hBZnV3aVh4V0tP?=
 =?utf-8?B?Ny9sQzd1cDQxaC9wbytsV0NISTNFZXRmbXZ5WkpsWWlXWEpWWUxCbCtNZG5I?=
 =?utf-8?B?OUl5MkhuVm0ya0twcUltazM1Y3NjTDUwZUFQcWxTZmQ2UnpIaVljSVI2SCtH?=
 =?utf-8?B?R3JJOVRwOHlJemYzOCtnUzlKVzFCRCtxN3BGQlVBdXIvWFFnUTJTSTYydlJy?=
 =?utf-8?B?QUJKZWRvdWdaaHZhbUxJSDFSZGZaTlhOSjB2QldZZlZkQTBzWXVwdjlNc3lZ?=
 =?utf-8?B?R1JQT2RLRVhTbkJ3dTJ0MWVsdzdsMHg5NkQwY2R2K29PWjZ5aGx3QVhEOGxF?=
 =?utf-8?B?Nnk3YjBWYVNqSU4yVWlrSVdPZWlac3NDSFNxbGFHeFovZktPK1VxL2NTQjY5?=
 =?utf-8?B?bE1reDUzVGZtVzlDRUl6QStDY3B1Q251cm1wRmxFbERiMVN3OGRxbGJZOFZN?=
 =?utf-8?B?aVhjUDE1bE4vNWFZZmJ2cVhaL2tlR3BwS2JRTm1ieVdqVE14Mkd4OTNxeDda?=
 =?utf-8?B?VEs3SHl5bkFQYUd5aUlOQTduYWJZZUwwZHcvVVJqemZ0VDFNTm1sQ0dsbDBR?=
 =?utf-8?B?Z3pGa2ExdXpRK0hoWVVxSjhlRHBuTmVPR2p5MWZLYWVpaDE2ckNEa2RpYndW?=
 =?utf-8?B?L3Zyc3M3RXE3c2xiODNZWEZLNHVnMHcwSjRQUU1MTWlXTnF3VzdrM2tHZml3?=
 =?utf-8?B?WUsrb29lTWgxb2RyWnJpMlRLQ3d5bHNKR256d1BmTFJiL0dRNXdhM3NhS29F?=
 =?utf-8?B?cDJNclBld3EzVkV0NE9LTTR4QWJiZVo0c1JXNnUzT1NPNDVCbm1sckxvYWlU?=
 =?utf-8?B?Mi82VEh2ODBHL283Wi9sUTI0dEQxTE9rQWdaNXBVQUF4eXRuUUNyeHRaVE93?=
 =?utf-8?B?S2F4aXlYVmtTaEZZRW9SQVJIUWFqUm9LenhBTlZMdUtPbE94MWgrbVc2c3VM?=
 =?utf-8?B?bW12OHgxcEpVY2kzWGZETXVUWW05VW9NY1pObFZHQkE0NmlpajBUaHNneWYr?=
 =?utf-8?B?RCt3Rlh6Sk9TaHF6WjdQMUk3RVhUMFVMMjN1dktuQjkwQ2FCZDF0cngzRE80?=
 =?utf-8?B?ZVJKQ3VXTTFKYXRucXB3TEVwSUhwWmVucFlUNklYSWM2aXdZWnBEcVk5WjZl?=
 =?utf-8?B?TStReUloN1FFSzdiWkZlWjJiZ29pdHYzTjRDNW9kTFV0eThEdzNCa3ZFM3o5?=
 =?utf-8?B?allLMy9ISThWV2dkVzZzdEtZRDV0Y3lxQU5YQXpHTEZlMkM1NmdJcmh6ajV5?=
 =?utf-8?B?Tms2d2kwZk1Ia09ERGV5OTNza2ZBa1BNa0poT2NzZzk4SXp4V0xwM1F2NTQv?=
 =?utf-8?B?Wlo1eDYvMnNkYnMxT0JOdUU4NHBOZ2FEdE0zUTBXMTRRTGtoU2JBN1J4UVA5?=
 =?utf-8?B?WW5uZjFhbWdRYVdiTDBKaXNITkJaWVNHT1p5MTB1cXJZYVRxYXNlSlp4bDgz?=
 =?utf-8?B?T1hwUXc0WjFRR3dCS1E5b1I2WVdZUk0vNEtSTWQ1aUluSmtmMnFZSDdKMmlE?=
 =?utf-8?B?MEZSV1pFV3VPcGhVYSsyckdZWWRiY1pqYWNaMENZNHJMS1hhUCtERVBiSWFO?=
 =?utf-8?B?dFE4NFRoemcveklBMEdrZlZJZ0hNcFdGaWhnWGM0WDBHR3IrUzlyd2kxVVh6?=
 =?utf-8?B?NEZlTDZUMkVYVTBrem9uQ3VuRDUxaFpCVlVNZGRmczgvQXJSNy81K1MyeXpL?=
 =?utf-8?B?RlRnL2lzV1c2YkRzb2Z5V0x5WFdlQTdPSXkxekdOSVg2RGJGY0NXUGRhajY2?=
 =?utf-8?B?M05mTkdCc25ZNzdJanRZYkR6QlZsWWhhL1c1cnlkWUdWTURvSHBNN25vdzVX?=
 =?utf-8?B?QmNLUkxyWVczMmM0cm1PNVc2OGxMOEw4ME9kRmN6dlU1U0gxaC8venp0Kzhl?=
 =?utf-8?B?aDE1TGpQUCswaDJTOUphL3VPcnN1d1ZNYXhHbWlDRUFRY0tQOHRXZXpCcjhY?=
 =?utf-8?B?Y3dFeUR6UVVNdGw1eWxyVHhHanA0MCt2TVRpeDhyNXo1TURuNzZSY2xxVnRZ?=
 =?utf-8?B?QWJSZTZLdDNoTWZNcldObExXemlFYU1UUTR3NGw5NmU4S3RkeFpPSy9sTVRP?=
 =?utf-8?B?UmhGS29xdC85Z2ZBZmt6UzV5MXBnQU9zY0ZYYWRNQ1ZiNGFtNlBOQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: bac75a47-46e5-4887-4111-08de9fb62a5e
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 14:56:27.7791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wHUMn/98Q1GvCqu2kP+fUEvPgpahshFQlmq47oS/dN0LZIKclqrDs+bN8/YhtC5+9eGsfa9gPQCaquvcsSHbTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB5523

Currently, `io::Mmio` always represent an untyped region of a compile-time
known minimum size, which is roughly equivalent to `void __iomem*` (but
with bound checks). However, it is useful to also be to represent I/O
memory of a specific type, e.g. `u32 __iomem*` or `struct foo __iomem*`.

Thus, make `Mmio` generic on arbitrary `T`, where `T` is a sized type, or a
DST that implements `KnownSize`. Similar to the `MmioRaw` change, the
existing behaviour is preserved in the form of `Mmio<Region<SIZE>>`. This
change brings the MMIO closer to the DMA coherent allocation types that we
have, which is already typed.

To be able to implement `IoKnownSize`, add a `MIN_SIZE` constant to
`KnownSize` trait to represent compile-time known minimum size of a
specific type.

Acked-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/devres.rs      |  2 +-
 rust/kernel/io.rs          | 63 +++++++++++++++++++++++++++-------------------
 rust/kernel/io/mem.rs      |  4 +--
 rust/kernel/io/poll.rs     |  6 +++--
 rust/kernel/io/register.rs | 19 ++++++++------
 rust/kernel/pci/io.rs      |  2 +-
 rust/kernel/ptr.rs         |  7 ++++++
 7 files changed, 64 insertions(+), 39 deletions(-)

diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
index 65a4082122af..3e22c63efb98 100644
--- a/rust/kernel/devres.rs
+++ b/rust/kernel/devres.rs
@@ -106,7 +106,7 @@ struct Inner<T> {
 /// }
 ///
 /// impl<const SIZE: usize> Deref for IoMem<SIZE> {
-///    type Target = Mmio<SIZE>;
+///    type Target = Mmio<Region<SIZE>>;
 ///
 ///    fn deref(&self) -> &Self::Target {
 ///         // SAFETY: The memory range stored in `self` has been properly mapped in `Self::new`.
diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index d7f2145fa9b9..0b9c97c0a1d7 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -44,6 +44,8 @@ pub struct Region<const SIZE: usize = 0> {
 }
 
 impl<const SIZE: usize> KnownSize for Region<SIZE> {
+    const MIN_SIZE: usize = SIZE;
+
     #[inline(always)]
     fn size(p: *const Self) -> usize {
         (p as *const [u8]).len()
@@ -169,7 +171,7 @@ pub fn size(&self) -> usize {
 /// }
 ///
 /// impl<const SIZE: usize> Deref for IoMem<SIZE> {
-///    type Target = Mmio<SIZE>;
+///    type Target = Mmio<Region<SIZE>>;
 ///
 ///    fn deref(&self) -> &Self::Target {
 ///         // SAFETY: The memory range stored in `self` has been properly mapped in `Self::new`.
@@ -187,7 +189,7 @@ pub fn size(&self) -> usize {
 /// # }
 /// ```
 #[repr(transparent)]
-pub struct Mmio<const SIZE: usize = 0>(MmioRaw<Region<SIZE>>);
+pub struct Mmio<T: ?Sized>(MmioRaw<T>);
 
 /// Checks whether an access of type `U` at the given `offset`
 /// is valid within this region.
@@ -462,9 +464,10 @@ fn write64(&self, value: u64, offset: usize)
     /// use kernel::io::{
     ///     Io,
     ///     Mmio,
+    ///     Region,
     /// };
     ///
-    /// fn do_reads(io: &Mmio) -> Result {
+    /// fn do_reads(io: &Mmio<Region>) -> Result {
     ///     // 32-bit read from address `0x10`.
     ///     let v: u32 = io.try_read(0x10)?;
     ///
@@ -496,9 +499,10 @@ fn try_read<T, L>(&self, location: L) -> Result<T>
     /// use kernel::io::{
     ///     Io,
     ///     Mmio,
+    ///     Region,
     /// };
     ///
-    /// fn do_writes(io: &Mmio) -> Result {
+    /// fn do_writes(io: &Mmio<Region>) -> Result {
     ///     // 32-bit write of value `1` at address `0x10`.
     ///     io.try_write(0x10, 1u32)?;
     ///
@@ -534,6 +538,7 @@ fn try_write<T, L>(&self, location: L, value: T) -> Result
     ///     register,
     ///     Io,
     ///     Mmio,
+    ///     Region,
     /// };
     ///
     /// register! {
@@ -549,7 +554,7 @@ fn try_write<T, L>(&self, location: L, value: T) -> Result
     ///     }
     /// }
     ///
-    /// fn do_write_reg(io: &Mmio) -> Result {
+    /// fn do_write_reg(io: &Mmio<Region>) -> Result {
     ///
     ///     io.try_write_reg(VERSION::new(1, 0))
     /// }
@@ -579,9 +584,10 @@ fn try_write_reg<T, L, V>(&self, value: V) -> Result
     /// use kernel::io::{
     ///     Io,
     ///     Mmio,
+    ///     Region,
     /// };
     ///
-    /// fn do_update(io: &Mmio<0x1000>) -> Result {
+    /// fn do_update(io: &Mmio<Region<0x1000>>) -> Result {
     ///     io.try_update(0x10, |v: u32| {
     ///         v + 1
     ///     })
@@ -616,9 +622,10 @@ fn try_update<T, L, F>(&self, location: L, f: F) -> Result
     /// use kernel::io::{
     ///     Io,
     ///     Mmio,
+    ///     Region,
     /// };
     ///
-    /// fn do_reads(io: &Mmio<0x1000>) {
+    /// fn do_reads(io: &Mmio<Region<0x1000>>) {
     ///     // 32-bit read from address `0x10`.
     ///     let v: u32 = io.read(0x10);
     ///
@@ -648,9 +655,10 @@ fn read<T, L>(&self, location: L) -> T
     /// use kernel::io::{
     ///     Io,
     ///     Mmio,
+    ///     Region,
     /// };
     ///
-    /// fn do_writes(io: &Mmio<0x1000>) {
+    /// fn do_writes(io: &Mmio<Region<0x1000>>) {
     ///     // 32-bit write of value `1` at address `0x10`.
     ///     io.write(0x10, 1u32);
     ///
@@ -682,6 +690,7 @@ fn write<T, L>(&self, location: L, value: T)
     ///     register,
     ///     Io,
     ///     Mmio,
+    ///     Region,
     /// };
     ///
     /// register! {
@@ -697,7 +706,7 @@ fn write<T, L>(&self, location: L, value: T)
     ///     }
     /// }
     ///
-    /// fn do_write_reg(io: &Mmio<0x1000>) {
+    /// fn do_write_reg(io: &Mmio<Region<0x1000>>) {
     ///     io.write_reg(VERSION::new(1, 0));
     /// }
     /// ```
@@ -726,9 +735,10 @@ fn write_reg<T, L, V>(&self, value: V)
     /// use kernel::io::{
     ///     Io,
     ///     Mmio,
+    ///     Region,
     /// };
     ///
-    /// fn do_update(io: &Mmio<0x1000>) {
+    /// fn do_update(io: &Mmio<Region<0x1000>>) {
     ///     io.update(0x10, |v: u32| {
     ///         v + 1
     ///     })
@@ -778,7 +788,7 @@ fn io_addr_assert<U>(&self, offset: usize) -> usize {
 macro_rules! impl_mmio_io_capable {
     ($mmio:ident, $(#[$attr:meta])* $ty:ty, $read_fn:ident, $write_fn:ident) => {
         $(#[$attr])*
-        impl<const SIZE: usize> IoCapable<$ty> for $mmio<SIZE> {
+        impl<T: ?Sized> IoCapable<$ty> for $mmio<T> {
             unsafe fn io_read(&self, address: usize) -> $ty {
                 // SAFETY: By the trait invariant `address` is a valid address for MMIO operations.
                 unsafe { bindings::$read_fn(address as *const c_void) }
@@ -805,7 +815,7 @@ unsafe fn io_write(&self, value: $ty, address: usize) {
     writeq
 );
 
-impl<const SIZE: usize> Io for Mmio<SIZE> {
+impl<T: ?Sized + KnownSize> Io for Mmio<T> {
     /// Returns the base address of this mapping.
     #[inline]
     fn addr(&self) -> usize {
@@ -819,18 +829,18 @@ fn maxsize(&self) -> usize {
     }
 }
 
-impl<const SIZE: usize> IoKnownSize for Mmio<SIZE> {
-    const MIN_SIZE: usize = SIZE;
+impl<T: ?Sized + KnownSize> IoKnownSize for Mmio<T> {
+    const MIN_SIZE: usize = T::MIN_SIZE;
 }
 
-impl<const SIZE: usize> Mmio<SIZE> {
+impl<T: ?Sized + KnownSize> Mmio<T> {
     /// Converts an `MmioRaw` into an `Mmio` instance, providing the accessors to the MMIO mapping.
     ///
     /// # Safety
     ///
     /// Callers must ensure that `addr` is the start of a valid I/O mapped memory region of size
-    /// `maxsize`.
-    pub unsafe fn from_raw(raw: &MmioRaw<Region<SIZE>>) -> &Self {
+    /// `addr.size()`.
+    pub unsafe fn from_raw(raw: &MmioRaw<T>) -> &Self {
         // SAFETY: `Mmio` is a transparent wrapper around `MmioRaw`.
         unsafe { &*core::ptr::from_ref(raw).cast() }
     }
@@ -843,9 +853,9 @@ pub unsafe fn from_raw(raw: &MmioRaw<Region<SIZE>>) -> &Self {
 ///
 /// See [`Mmio::relaxed`] for a usage example.
 #[repr(transparent)]
-pub struct RelaxedMmio<const SIZE: usize = 0>(Mmio<SIZE>);
+pub struct RelaxedMmio<T: ?Sized>(Mmio<T>);
 
-impl<const SIZE: usize> Io for RelaxedMmio<SIZE> {
+impl<T: ?Sized + KnownSize> Io for RelaxedMmio<T> {
     #[inline]
     fn addr(&self) -> usize {
         self.0.addr()
@@ -857,11 +867,11 @@ fn maxsize(&self) -> usize {
     }
 }
 
-impl<const SIZE: usize> IoKnownSize for RelaxedMmio<SIZE> {
-    const MIN_SIZE: usize = SIZE;
+impl<T: ?Sized + KnownSize> IoKnownSize for RelaxedMmio<T> {
+    const MIN_SIZE: usize = T::MIN_SIZE;
 }
 
-impl<const SIZE: usize> Mmio<SIZE> {
+impl<T: ?Sized> Mmio<T> {
     /// Returns a [`RelaxedMmio`] reference that performs relaxed I/O operations.
     ///
     /// Relaxed accessors do not provide ordering guarantees with respect to DMA or memory accesses
@@ -873,18 +883,19 @@ impl<const SIZE: usize> Mmio<SIZE> {
     /// use kernel::io::{
     ///     Io,
     ///     Mmio,
+    ///     Region,
     ///     RelaxedMmio,
     /// };
     ///
-    /// fn do_io(io: &Mmio<0x100>) {
+    /// fn do_io(io: &Mmio<Region<0x100>>) {
     ///     // The access is performed using `readl_relaxed` instead of `readl`.
     ///     let v = io.relaxed().read32(0x10);
     /// }
     ///
     /// ```
-    pub fn relaxed(&self) -> &RelaxedMmio<SIZE> {
-        // SAFETY: `RelaxedMmio` is `#[repr(transparent)]` over `Mmio`, so `Mmio<SIZE>` and
-        // `RelaxedMmio<SIZE>` have identical layout.
+    pub fn relaxed(&self) -> &RelaxedMmio<T> {
+        // SAFETY: `RelaxedMmio` is `#[repr(transparent)]` over `Mmio`, so `Mmio<T>` and
+        // `RelaxedMmio<T>` have identical layout.
         unsafe { core::mem::transmute(self) }
     }
 }
diff --git a/rust/kernel/io/mem.rs b/rust/kernel/io/mem.rs
index 9117d417f99c..a6292f4ebfa4 100644
--- a/rust/kernel/io/mem.rs
+++ b/rust/kernel/io/mem.rs
@@ -214,7 +214,7 @@ pub fn new<'a>(io_request: IoRequest<'a>) -> impl PinInit<Devres<Self>, Error> +
 }
 
 impl<const SIZE: usize> Deref for ExclusiveIoMem<SIZE> {
-    type Target = Mmio<SIZE>;
+    type Target = Mmio<super::Region<SIZE>>;
 
     fn deref(&self) -> &Self::Target {
         &self.iomem
@@ -289,7 +289,7 @@ fn drop(&mut self) {
 }
 
 impl<const SIZE: usize> Deref for IoMem<SIZE> {
-    type Target = Mmio<SIZE>;
+    type Target = Mmio<super::Region<SIZE>>;
 
     fn deref(&self) -> &Self::Target {
         // SAFETY: Safe as by the invariant of `IoMem`.
diff --git a/rust/kernel/io/poll.rs b/rust/kernel/io/poll.rs
index 75d1b3e8596c..2dce2b24b5ff 100644
--- a/rust/kernel/io/poll.rs
+++ b/rust/kernel/io/poll.rs
@@ -48,13 +48,14 @@
 /// use kernel::io::{
 ///     Io,
 ///     Mmio,
+///     Region,
 ///     poll::read_poll_timeout, //
 /// };
 /// use kernel::time::Delta;
 ///
 /// const HW_READY: u16 = 0x01;
 ///
-/// fn wait_for_hardware<const SIZE: usize>(io: &Mmio<SIZE>) -> Result {
+/// fn wait_for_hardware<const SIZE: usize>(io: &Mmio<Region<SIZE>>) -> Result {
 ///     read_poll_timeout(
 ///         // The `op` closure reads the value of a specific status register.
 ///         || io.try_read16(0x1000),
@@ -135,13 +136,14 @@ pub fn read_poll_timeout<Op, Cond, T>(
 /// use kernel::io::{
 ///     Io,
 ///     Mmio,
+///     Region,
 ///     poll::read_poll_timeout_atomic, //
 /// };
 /// use kernel::time::Delta;
 ///
 /// const HW_READY: u16 = 0x01;
 ///
-/// fn wait_for_hardware<const SIZE: usize>(io: &Mmio<SIZE>) -> Result {
+/// fn wait_for_hardware<const SIZE: usize>(io: &Mmio<Region<SIZE>>) -> Result {
 ///     read_poll_timeout_atomic(
 ///         // The `op` closure reads the value of a specific status register.
 ///         || io.try_read16(0x1000),
diff --git a/rust/kernel/io/register.rs b/rust/kernel/io/register.rs
index abc49926abfe..1a407fc35edc 100644
--- a/rust/kernel/io/register.rs
+++ b/rust/kernel/io/register.rs
@@ -55,6 +55,7 @@
 //!         register,
 //!         Io,
 //!         IoLoc,
+//!         Region,
 //!     },
 //!     num::Bounded,
 //! };
@@ -66,7 +67,7 @@
 //! #         3:0 minor_revision;
 //! #     }
 //! # }
-//! # fn test(io: &Mmio<0x1000>) {
+//! # fn test(io: &Mmio<Region<0x1000>>) {
 //! # fn obtain_vendor_id() -> u8 { 0xff }
 //!
 //! // Read from the register's defined offset (0x100).
@@ -441,6 +442,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 ///     io::{
 ///         register,
 ///         Io,
+///         Region,
 ///     },
 /// };
 /// # use kernel::io::Mmio;
@@ -452,7 +454,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 ///     }
 /// }
 ///
-/// # fn test(io: &Mmio<0x1000>) {
+/// # fn test(io: &Mmio<Region<0x1000>>) {
 /// let val = io.read(FIXED_REG);
 ///
 /// // Write from an already-existing value.
@@ -554,6 +556,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 ///             WithBase,
 ///         },
 ///         Io,
+///         Region,
 ///     },
 /// };
 /// # use kernel::io::Mmio;
@@ -581,7 +584,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 ///     }
 /// }
 ///
-/// # fn test(io: Mmio<0x1000>) {
+/// # fn test(io: Mmio<Region<0x1000>>) {
 /// // Read the status of `Cpu0`.
 /// let cpu0_started = io.read(CPU_CTL::of::<Cpu0>());
 ///
@@ -598,7 +601,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 ///     }
 /// }
 ///
-/// # fn test2(io: Mmio<0x1000>) {
+/// # fn test2(io: Mmio<Region<0x1000>>) {
 /// // Start the aliased `CPU0`, leaving its other fields untouched.
 /// io.update(CPU_CTL_ALIAS::of::<Cpu0>(), |r| r.with_alias_start(true));
 /// # }
@@ -633,6 +636,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 ///         register,
 ///         register::Array,
 ///         Io,
+///         Region,
 ///     },
 /// };
 /// # use kernel::io::Mmio;
@@ -648,7 +652,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 ///     }
 /// }
 ///
-/// # fn test(io: &Mmio<0x1000>)
+/// # fn test(io: &Mmio<Region<0x1000>>)
 /// #     -> Result<(), Error>{
 /// // Read scratch register 0, i.e. I/O address `0x80`.
 /// let scratch_0 = io.read(SCRATCH::at(0)).value();
@@ -719,6 +723,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 ///             WithBase,
 ///         },
 ///         Io,
+///         Region,
 ///     },
 /// };
 /// # use kernel::io::Mmio;
@@ -749,7 +754,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 ///     }
 /// }
 ///
-/// # fn test(io: &Mmio<0x1000>) -> Result<(), Error> {
+/// # fn test(io: &Mmio<Region<0x1000>>) -> Result<(), Error> {
 /// // Read scratch register 0 of CPU0.
 /// let scratch = io.read(CPU_SCRATCH::of::<Cpu0>().at(0));
 ///
@@ -791,7 +796,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 ///     }
 /// }
 ///
-/// # fn test2(io: &Mmio<0x1000>) -> Result<(), Error> {
+/// # fn test2(io: &Mmio<Region<0x1000>>) -> Result<(), Error> {
 /// let cpu0_status = io.read(CPU_FIRMWARE_STATUS::of::<Cpu0>()).status();
 /// # Ok(())
 /// # }
diff --git a/rust/kernel/pci/io.rs b/rust/kernel/pci/io.rs
index 0335b5068f69..e048370fb8c1 100644
--- a/rust/kernel/pci/io.rs
+++ b/rust/kernel/pci/io.rs
@@ -238,7 +238,7 @@ fn drop(&mut self) {
 }
 
 impl<const SIZE: usize> Deref for Bar<SIZE> {
-    type Target = Mmio<SIZE>;
+    type Target = Mmio<crate::io::Region<SIZE>>;
 
     fn deref(&self) -> &Self::Target {
         // SAFETY: By the type invariant of `Self`, the MMIO range in `self.io` is properly mapped.
diff --git a/rust/kernel/ptr.rs b/rust/kernel/ptr.rs
index 3f3e529e9f58..566e68f567a2 100644
--- a/rust/kernel/ptr.rs
+++ b/rust/kernel/ptr.rs
@@ -235,11 +235,16 @@ fn align_up(self, alignment: Alignment) -> Option<Self> {
 ///
 /// This is a generalization of [`size_of`] that works for dynamically sized types.
 pub trait KnownSize {
+    /// Minimum size of this type known at compile-time.
+    const MIN_SIZE: usize;
+
     /// Get the size of an object of this type in bytes, with the metadata of the given pointer.
     fn size(p: *const Self) -> usize;
 }
 
 impl<T> KnownSize for T {
+    const MIN_SIZE: usize = core::mem::size_of::<T>();
+
     #[inline(always)]
     fn size(_: *const Self) -> usize {
         size_of::<T>()
@@ -247,6 +252,8 @@ fn size(_: *const Self) -> usize {
 }
 
 impl<T> KnownSize for [T] {
+    const MIN_SIZE: usize = 0;
+
     #[inline(always)]
     fn size(p: *const Self) -> usize {
         p.len() * size_of::<T>()

-- 
2.51.2


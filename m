Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022091.outbound.protection.outlook.com [52.101.101.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E0C46AF33;
	Thu, 11 Jun 2026 16:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781195324; cv=fail; b=Z3KF5dv7W11hAgIVJkKWu/XPgvMKVJZLNyswodDhZYBROrPATs7yDUuHBwZxRYPWI4FYkDnqMJ6SxxE4RIpiiUHL1dehCDXECCYEoGxEuJrOMEDeIdWHLNxVqcWnlhEQS4IA5YQRA3fMVbzXopUorK6UqYXgMeGkMkMKg1uowYA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781195324; c=relaxed/simple;
	bh=4mlyjPbdnE6Ty78c6hzqGp3ZT8XiEp/nXwOWY38ZETc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=OQoNJBKgQyn7NTpMThvyS7C02RqOEr3EXk5mUO/2F+pCnqs6n+hkc2VfT57Vs3L90E2szgsLFZHcwh15RY3gIEbCkT951LdFXUOXs/MJboNdPxnUi5VftYRRxjG7pnQ5UEgNxlGG27c3LEseCYAfupY62+Jzzr0adn1zJUI+RpA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=r0LJE/sP; arc=fail smtp.client-ip=52.101.101.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="r0LJE/sP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Alr/hK1h6g2PtvELlUbZKPdzfioJeUUMO5DM6xDnfgMvTXM1P0FXenAhbXm4QTI04cjwZzrgnOcgCWbA3j15j3SMXpYxgap2gadWmqbe1N7dAT2W0WLRPbjfr2Ec0pnMaw4bRqaheXndTr/AdB4nilYnug4RPWzE1alGqrfuCt26aqVBs89Gwtx97avAIoreHg9Q64THaXkvLxqmeg0QzFZde5ADAalctzLG5ks/4LpuFpdNVsA1lIsln9e6dWUduMM5fj3Kxw+UGTB5eIay/ATmuc5c30tdf4F5fufs10tUywvMBZBAZU1ic1o9A+zla6wlyK+1C7x8jwqWGqR7Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ls5pYn8rm5lbzthj1k1q3/K3MbTAy/rku+GhqFU8EJE=;
 b=k/zDdjMAyflcwyYGTrX+Y2iwzXg7gXXsdYpndUSDHlUxqqCb8oJaCT1f6Ksb0YWnife2Nj6F36JfOb01CuGVO7SAPvr3esysaL9zUgKQAhWPezKG74t8RPzu+WkqgtSsR7BM7OZDE//QxdS/rb2LbMxLzx7ky5ipW7OGe9mqVNnECGlYPBpn0JQDpsRmGZBgyB9h3GBouOkwtHqLw/j/x9fTLXBqXsmba27vB2MIPpG6ViWTwNSURpTLGR+ygPNCd8b35PRzve3m64YtJKTsYE/dgTSI05N4tcdn3k0xAtfggH6r+lWO/k6KhZX8JEDSRAgBG2gL1kJP+N93OMWG8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ls5pYn8rm5lbzthj1k1q3/K3MbTAy/rku+GhqFU8EJE=;
 b=r0LJE/sPcrS2DWUFE/oB50pGB+yKdv+Z+2MVLcZZnKvki/QdzI+vhu0foMvf8aqgEiF8LEQz/f1c5oaiOMdD52N3o3eCkgjtb3LfYqRvPxKolmLo1VH5CBrJUGyu0sBy16JLSTR88SOLqKGME4DOo7kkzXUK91aWqXWJrATAqxw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:27c::13)
 by LO2P265MB3263.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:156::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Thu, 11 Jun
 2026 16:28:33 +0000
Received: from CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c9e:93c8:10db:e995]) by CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c9e:93c8:10db:e995%6]) with mapi id 15.21.0113.011; Thu, 11 Jun 2026
 16:28:33 +0000
From: Gary Guo <gary@garyguo.net>
Date: Thu, 11 Jun 2026 17:28:21 +0100
Subject: [PATCH v4 19/20] rust: io: add copying methods
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-io_projection-v4-19-1f7224b02dcb@garyguo.net>
References: <20260611-io_projection-v4-0-1f7224b02dcb@garyguo.net>
In-Reply-To: <20260611-io_projection-v4-0-1f7224b02dcb@garyguo.net>
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
 dri-devel@lists.freedesktop.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781195302; l=14709;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=4mlyjPbdnE6Ty78c6hzqGp3ZT8XiEp/nXwOWY38ZETc=;
 b=KR/3tNOa7Ka/uJ5/jypLk8ROUXznGYOrF+8ryesz8reZzvfx/z53RdpjxAO/Wn+UFW6JRCRnD
 REgcogNsAeMDrajuHLr3Hh6AmKq7+3dS8a2ShwXnn06L4qrGraN4tyo
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
X-MS-Office365-Filtering-Correlation-Id: f15b4f6b-9a3e-48be-148d-08dec7d67b34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|7416014|376014|366016|23010399003|18002099003|22082099003|921020|3023799007|5023799004|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info:
	54LNM4DXH0vqdYEPt5BteK27YoLAmFEKs5EoaZi++mMxG1p3/J92cXq+e1SRTwhE8yqi02uKGLOrHEAWcl1bbn2Q3Ygrfbm9A9RurVLayb0pybLvT4xp5UHyI8/PZS829LliCrNdxCwm0Fau5IZPTpqN+DTDYMB+KVTTqmuOmTPvpjorh0SbkNzpW5mqDuYelJ9z5Hb7X3j6g61FeZKxl4rgCUUgBfS1l2epo4Sqb4HolDM4rWwNUf0giUYIqM/iKbe4lJkA+k0C5NlxH3A9QVGGmWG55/Ip1wfWyailhLHKnNoURvwEbacDWNqv6XItJmStdSRM1zbMV5OR7CmpYOy1bpShPIhjqRVwxfuurD+2SL2Fg25q0HBqYSRh6IH3au6HookThdmpD+DKZCBKKVxwQEFeIwnESmfoEFqmG+UmZodsv5qZhauZ+LeqB/0GOtuz6M9fdy/FCbhKAjqfWkHwBDOsovNYp8vjZ5UddkbZjoZLZIPimaBGxLoM9HvG6ol3oUdbJ4oCzgV/uMJO0Y641X1c/gGBXjzFpn8SM+Ba9PdoI6TnUGoX+/TExnw+89KtIKHHG0kPdPT09DzlB9/FOobWZe42hcH5VlZWS+F/Z04/wvu5TfwNY+Y37Oz/hi7gMM5XagiL/Dgr5rVNWnqIDv/HrDagR9io7JrBL31krTg40EcAI67AD20UKeZb5w9oK61mVenwF56jM750CUz15aGayKhwTjoRaIQpDVA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(7416014)(376014)(366016)(23010399003)(18002099003)(22082099003)(921020)(3023799007)(5023799004)(6133799003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VDE3TG50bG95VUVvU1pra3U5RzdJam1hc1pDcDVrcCt4M2k1aEUrSW8rdnpo?=
 =?utf-8?B?TXFmYzFZRHlLakZuWXB0Vll1bUI4QS8yZlNFRnBGYlJBT2ZYeG9iaGk0cjJP?=
 =?utf-8?B?VWFzWVBXdDFTT2tHSWRnTHJzWWdwbkttK2hLVERaV1dOanprd3pPcDJSUHFa?=
 =?utf-8?B?MGJFTGYzZVoyYWdJRDV5Q1BTK2s1ZW9OV1hKTXlOZklKdUZNNFFwWDduTjdv?=
 =?utf-8?B?NThmUWdKNXhqVjlDZGRqalhtb2tuc0pJU29IUXlGcHZMRmhPQ2pLZXlId1hx?=
 =?utf-8?B?Umk3S0NQZ1dQSE9Cc1U4a0srOVNrdWNGdys5bDBpbDREZUplbEpselhaZU13?=
 =?utf-8?B?UnJ2elFyc3RFM2YwMzBrYWRCT3NKeXFOcTQ0aVBYYlQ3emt1SDFzR09jZ1hP?=
 =?utf-8?B?MHZtQkdEQkJRdFN1Lzg0akpxT2F6WW1vL1ZadW93ckRiUS9PVTZlZS9Uc0M0?=
 =?utf-8?B?clRJcTE1d0wxQlFTeWpkWUo0NmtVL3Rqc2l1ZHhpUUZpREFwOGdDcWFzRVZ6?=
 =?utf-8?B?R1I5eE9XRDEyWEppUFRMeWNTdERBSk9oY0NaaHpqNUZVMjl6d2hMd05mQlRw?=
 =?utf-8?B?RkFPVHByL2YrOXBuMmx5NlEyUml2MndIeUJQaGNkTExuNDlSNEhWbE94MmNT?=
 =?utf-8?B?Q2tLYTcyRXdLUmNOeVNCLzZWaGpGMDNMcmhyQm44bjlzdzBPMUl5Z2RWWXYv?=
 =?utf-8?B?eHFMQ1ZmY3pCelBFZnNuODlzalQvMDFXZUlIaW1xRXZtQlFIK3FLUithSHRE?=
 =?utf-8?B?Zy9qQXMwM3R5UnFCMlJ5OGplb2ZWWnJUMWNObVpLempGMzRXekw5WWdiaEdo?=
 =?utf-8?B?QkM5R3lZUC8yUDBDZEpldTNWUFcvUGQ5d3dqNVl3ekNSTk1zdTVBSDNueVZD?=
 =?utf-8?B?ZjBmVG9zQTZhSDZtN0w5STJvMEtJR3hWMDJKanRDVkRZN0FsT1ZsR0sxME9X?=
 =?utf-8?B?aEdxTVAwTnQxdGdxNDVzbU5JOHZEcThGMXErc3Fieis2Vzd0ODRMaHRkUFZz?=
 =?utf-8?B?WWszL3NieEZrRHlLbFhEOVFIa0dhZXd2dzE4OWt4d1pFbEtFVDk4R25LWEtZ?=
 =?utf-8?B?SWdaY1BNZ2J2ZXNGUDhEemlrUVlhaTdjY0FJM2tCU3M4N0tyTGJoOEYxbTRm?=
 =?utf-8?B?QXBkQjc1S2tXd05XanVrQml6K2dWQ3lGYW8wY0dPNERCK2ovbWp2N2JBM1pJ?=
 =?utf-8?B?dnc0UnFPUjlCUVAyQWpiQ1gzQ0RnYW5DQmRLbTNHSjNIUEk5anVzSlFvdXU5?=
 =?utf-8?B?S0oyLzlqUHlQcDdWbnBFc3dxTUVRSkRuZjhMK2xtYVVCMXJvSGdhTW0vWjMw?=
 =?utf-8?B?UXBtNW5GUDJGeEN3WTNoV0dTck5NR2p4aUlIWVNUTGVtS1hNdk8wS0VDNWFV?=
 =?utf-8?B?RHJOUFRXMFFydUxiREtnWFMyV1d6VEpNM0xQWDBzc2dLeGJxdnNkaUNRdTI3?=
 =?utf-8?B?Z2szQ2p4K1ZFTFhlRDh1Tm5xbDhtdW5ubDY0eU52WUhRZy9YZjQwVTBzZWZJ?=
 =?utf-8?B?czBrVGlXVGh1OFRNendYenVvQ3VkWEVIb3JsS2k3SVJBR3FaUzNoNWVNVkky?=
 =?utf-8?B?b0pmeWJGZmtsblNJSmtaTGlrSkMvWnFBRW5JTUJELzM5Snp3YlBDQjY1VE9O?=
 =?utf-8?B?cTdJR3JGWit6eTFHT0Rjd3E5clZyUitKZTRHMnE4YnAzUDFFbms2RHY5UXVq?=
 =?utf-8?B?U1NtclJiYnliT1V1dTZ6VTYrMU14ZWUrYkNRbENFcTVQdTFTL2JyNzJKZG1F?=
 =?utf-8?B?QnNSc3owNnorcSthNTc2NVZqV3J1N2xrYjl4NWxDWHk0ZGJ1b3h2TytKUEJU?=
 =?utf-8?B?Z3pBRGJVVjI3enFXTkNhTU9mZmpxNWNMWTRZci9vaGhtSGRLWlcyYnl5dGds?=
 =?utf-8?B?K01VdnJBQUZwMTVldEgyQ2Q5QVMzdVljN0JXV3VReUh1cDU5TTFvMFRsN1Zy?=
 =?utf-8?B?SEpTOVd0RHArM2VhSDdQNjU2MWY5Uk5jNkxzRktrOWhmdXZXM0dkUzVvVDdR?=
 =?utf-8?B?WFZHM0xDaFpjOXhucGM2aExlOHlHejNyS29NMkpHMW8rNUdObCtLZU5Xbks1?=
 =?utf-8?B?Sk5ydC9PQk5MV2VJclZhcFNlYnozVndReTVlUEhQdnFEKzV6OWtpZmZ2WW9U?=
 =?utf-8?B?WnJFRWc3OEdtSjBFOGF5ZEoyRlNVQ2gwNEpxYjlHZ2g4QWFPS2NVVWMxYldn?=
 =?utf-8?B?N2Zac0tsN2l3cmxhY1g3b2tRVHNzclBuL3g2bmVsaUZJU3V6NFdXakFsWmxZ?=
 =?utf-8?B?ak82R05zenBFSXpLSzR4UW9RZGQ4c1pTbkJZQWhFRmpLSDhoMGNyUDFjU2Q5?=
 =?utf-8?B?QXhRS2s5Vy9QemloSGozWk55WnBhbkh2MnN3TWQrRnk0UmNoRUViQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: f15b4f6b-9a3e-48be-148d-08dec7d67b34
X-MS-Exchange-CrossTenant-AuthSource: CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 16:28:33.8044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vi0j7krBLBhirHsUFhhXqKqLkOhAgB0swwg2Jtb3+E7oqw25iy4Ej3XxM61ti0H7p9d8qQNkWCv6+yH0Lq2nGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB3263

One feature that was lost from the old `dma_read!` and `dma_write!` when
moving to `io_read!` and `io_write!` was the ability to read/write a large
structs. However, the semantics was unclear to begin with, as there was no
guarantee about their atomicity even for structs that were small enough to
fit in u32. Re-introduce the capability in the form of copying methods.

    dma_read!(foo, bar) -> io_project!(foo, bar).copy_read()
    dma_write!(foo, bar, baz) -> io_project!(foo, bar).copy_write(baz)

Model these semantics after memcpy so user has clear expectation of lack of
atomicity. As an additional benefit of this change, this now works for MMIO
as well by mapping them to `memcpy_{from,to}io`.

For slices which is DST so the `copy_read` and `copy_write` API above can't
work, add `copy_from_slice` and `copy_to_slice` to copy from/to normal
memory.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/helpers/io.c        |  13 +++
 rust/kernel/dma.rs       |  25 +++++
 rust/kernel/io.rs        | 238 ++++++++++++++++++++++++++++++++++++++++++++++-
 samples/rust/rust_dma.rs |  15 ++-
 4 files changed, 285 insertions(+), 6 deletions(-)

diff --git a/rust/helpers/io.c b/rust/helpers/io.c
index 397810864a24..7ed9a4f77f1b 100644
--- a/rust/helpers/io.c
+++ b/rust/helpers/io.c
@@ -19,6 +19,19 @@ __rust_helper void rust_helper_iounmap(void __iomem *addr)
 	iounmap(addr);
 }
 
+__rust_helper void rust_helper_memcpy_fromio(void *dst,
+					     const volatile void __iomem *src,
+					     size_t count)
+{
+	memcpy_fromio(dst, src, count);
+}
+
+__rust_helper void rust_helper_memcpy_toio(volatile void __iomem *dst,
+					   const void *src, size_t count)
+{
+	memcpy_toio(dst, src, count);
+}
+
 __rust_helper u8 rust_helper_readb(const void __iomem *addr)
 {
 	return readb(addr);
diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
index 0ff4cce8e809..37bc20895803 100644
--- a/rust/kernel/dma.rs
+++ b/rust/kernel/dma.rs
@@ -18,6 +18,7 @@
         IoBackend,
         IoBase,
         IoCapable,
+        IoCopyable,
         SysMem,
         SysMemBackend, //
     },
@@ -1196,6 +1197,30 @@ fn io_write<'a>(view: Self::View<'a, T>, value: T) {
     }
 }
 
+impl IoCopyable for CoherentBackend {
+    #[inline]
+    unsafe fn copy_from_io(view: Self::View<'_, [u8]>, buffer: *mut u8) {
+        // SAFETY: Per safety requirement.
+        unsafe { SysMemBackend::copy_from_io(view.cpu_addr, buffer) }
+    }
+
+    #[inline]
+    unsafe fn copy_to_io(view: Self::View<'_, [u8]>, buffer: *const u8) {
+        // SAFETY: Per safety requirement.
+        unsafe { SysMemBackend::copy_to_io(view.cpu_addr, buffer) }
+    }
+
+    #[inline]
+    fn copy_read<T: zerocopy::FromBytes>(view: Self::View<'_, T>) -> T {
+        SysMemBackend::copy_read(view.cpu_addr)
+    }
+
+    #[inline]
+    fn copy_write<T: zerocopy::IntoBytes>(view: Self::View<'_, T>, value: T) {
+        SysMemBackend::copy_write(view.cpu_addr, value)
+    }
+}
+
 impl<'a, T: ?Sized + KnownSize> IoBase<'a> for CoherentView<'a, T> {
     type Backend = CoherentBackend;
     type Target = T;
diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index f64ca2202ff2..16f818d396bf 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -5,7 +5,8 @@
 //! C header: [`include/asm-generic/io.h`](srctree/include/asm-generic/io.h)
 
 use core::{
-    marker::PhantomData, //
+    marker::PhantomData,
+    mem::MaybeUninit, //
 };
 
 use crate::{
@@ -227,6 +228,61 @@ pub trait IoCapable<T>: IoBackend {
     fn io_write<'a>(view: Self::View<'a, T>, value: T);
 }
 
+/// Trait indicating that an I/O backend supports memory copy operations.
+pub trait IoCopyable: IoBackend {
+    /// Copy contents of `view` to `buffer`.
+    ///
+    /// # Safety
+    ///
+    /// - `buffer` is valid for volatile write for `view.size()` bytes.
+    unsafe fn copy_from_io(view: Self::View<'_, [u8]>, buffer: *mut u8);
+
+    /// Copy `size` bytes from `buffer` to `address`.
+    ///
+    /// # Safety
+    ///
+    /// - `buffer` is valid for volatile read for `view.size()` bytes.
+    unsafe fn copy_to_io(view: Self::View<'_, [u8]>, buffer: *const u8);
+
+    /// Copy from `view` and return the value.
+    #[inline]
+    fn copy_read<T: FromBytes>(view: Self::View<'_, T>) -> T {
+        // Project `self` to `[u8]`.
+        let ptr = Self::as_ptr(view);
+        // SAFETY: This is a identity projection.
+        let slice_view = unsafe {
+            Self::project_view(
+                view,
+                core::ptr::slice_from_raw_parts_mut::<u8>(ptr.cast(), size_of::<T>()),
+            )
+        };
+
+        let mut buf = MaybeUninit::<T>::uninit();
+        // SAFETY: `buf.as_mut_ptr()` is valid for write for `size_of::<T>()` bytes.
+        unsafe { Self::copy_from_io(slice_view, buf.as_mut_ptr().cast()) };
+        // SAFETY: T: FromBytes` guarantee that all bit patterns are valid.
+        unsafe { buf.assume_init() }
+    }
+
+    /// Copy `value` to `view`.
+    #[inline]
+    fn copy_write<T: IntoBytes>(view: Self::View<'_, T>, value: T) {
+        // Project `self` to `[u8]`.
+        let ptr = Self::as_ptr(view);
+        // SAFETY: This is a identity projection.
+        let slice_view = unsafe {
+            Self::project_view(
+                view,
+                core::ptr::slice_from_raw_parts_mut::<u8>(ptr.cast(), size_of::<T>()),
+            )
+        };
+
+        // SAFETY: `&raw const value` is valid for read for `size_of::<T>()` bytes.
+        unsafe { Self::copy_to_io(slice_view, (&raw const value).cast()) };
+        core::mem::forget(value);
+    }
+}
+
 /// Describes a given I/O location: its offset, width, and type to convert the raw value from and
 /// into.
 ///
@@ -304,6 +360,24 @@ fn size(self) -> usize {
         KnownSize::size(Self::Backend::as_ptr(self.as_view()))
     }
 
+    /// Returns the length of the slice in number of elements.
+    #[inline]
+    fn len<T>(self) -> usize
+    where
+        Self: Io<'a, Target = [T]>,
+    {
+        Self::Backend::as_ptr(self.as_view()).len()
+    }
+
+    /// Returns `true` if the slice has a length of 0.
+    #[inline]
+    fn is_empty<T>(self) -> bool
+    where
+        Self: Io<'a, Target = [T]>,
+    {
+        self.len() == 0
+    }
+
     /// Try to convert into a different typed I/O view.
     ///
     /// The target type must be of same or smaller size to current type, and the current view must
@@ -391,6 +465,105 @@ fn write_val(self, value: Self::Target)
         Self::Backend::io_write(self.as_view(), value)
     }
 
+    /// Copy-read from I/O memory.
+    ///
+    /// There is no atomicity guarantee.
+    ///
+    /// # Examples
+    ///
+    /// ```no_run
+    /// # use kernel::io::*;
+    /// # fn test_copy_read(mmio: Mmio<'_, [u8; 6]>) {
+    /// // let mmio: Mmio<'_, [u8; 6]>;
+    /// let val: [u8; 6] = mmio.copy_read();
+    /// # }
+    /// ```
+    #[inline]
+    fn copy_read(self) -> Self::Target
+    where
+        Self::Backend: IoCopyable,
+        Self::Target: Sized + FromBytes,
+    {
+        Self::Backend::copy_read(self.as_view())
+    }
+
+    /// Copy-write to I/O memory.
+    ///
+    /// There is no atomicity guarantee.
+    ///
+    /// # Examples
+    ///
+    /// ```no_run
+    /// # use kernel::io::*;
+    /// # fn test_copy_write(mmio: Mmio<'_, [u8; 6]>) {
+    /// // let mmio: Mmio<'_, [u8; 6]>;
+    /// mmio.copy_write([0xAA, 0xBB, 0xCC, 0xDD, 0xEE, 0xFF]);
+    /// # }
+    /// ```
+    #[inline]
+    fn copy_write(self, value: Self::Target)
+    where
+        Self::Backend: IoCopyable,
+        Self::Target: Sized + IntoBytes,
+    {
+        Self::Backend::copy_write(self.as_view(), value);
+    }
+
+    /// Copy bytes from slice to I/O memory.
+    ///
+    /// The length of `self` must be the same as `data`, similar to [`[u8]::copy_from_slice`].
+    ///
+    /// # Examples
+    ///
+    /// ```no_run
+    /// # use kernel::io::*;
+    /// # fn test_copy_write(mmio: Mmio<'_, [u8]>) {
+    /// // let mmio: Mmio<'_, [u8]>;
+    /// mmio.copy_from_slice(&[0xAA, 0xBB, 0xCC, 0xDD, 0xEE, 0xFF]);
+    /// # }
+    /// ```
+    #[inline]
+    fn copy_from_slice(self, data: &[u8])
+    where
+        Self::Backend: IoCopyable,
+        Self: Io<'a, Target = [u8]>,
+    {
+        assert_eq!(self.len(), data.len());
+
+        // SAFETY: `data.as_ptr()` is valid for read for `self.size()` bytes.
+        unsafe {
+            Self::Backend::copy_to_io(self.as_view(), data.as_ptr());
+        }
+    }
+
+    /// Copy bytes from I/O memory to slice.
+    ///
+    /// The length of `self` must be the same as `data`, similar to [`[u8]::copy_from_slice`].
+    ///
+    /// # Examples
+    ///
+    /// ```no_run
+    /// # use kernel::io::*;
+    /// # fn test_copy_write(mmio: Mmio<'_, [u8]>) {
+    /// // let mmio: Mmio<'_, [u8]>;
+    /// let mut buf = [0; 6];
+    /// mmio.copy_to_slice(&mut buf);
+    /// # }
+    /// ```
+    #[inline]
+    fn copy_to_slice(self, data: &mut [u8])
+    where
+        Self::Backend: IoCopyable,
+        Self: Io<'a, Target = [u8]>,
+    {
+        assert_eq!(self.len(), data.len());
+
+        // SAFETY: `data.as_ptr()` is valid for write for `self.size()` bytes.
+        unsafe {
+            Self::Backend::copy_from_io(self.as_view(), data.as_mut_ptr());
+        }
+    }
+
     /// Returns a view for a given `offset`, performing compile-time bound checks.
     // Always inline to optimize out error path of `build_assert`.
     #[inline(always)]
@@ -981,6 +1154,28 @@ fn io_write(view: <$backend as IoBackend>::View<'_, $ty>, value: $ty) {
 #[cfg(CONFIG_64BIT)]
 impl_mmio_io_capable!(MmioBackend, u64, readq, writeq);
 
+impl IoCopyable for MmioBackend {
+    #[inline]
+    unsafe fn copy_from_io(view: Self::View<'_, [u8]>, buffer: *mut u8) {
+        // SAFETY:
+        // - `view.ptr` is valid MMIO memory for `view.size()` bytes.
+        // - `buffer` is valid for write for `view.size()` bytes.
+        unsafe {
+            bindings::memcpy_fromio(buffer.cast(), view.ptr.cast(), view.size());
+        }
+    }
+
+    #[inline]
+    unsafe fn copy_to_io(view: Self::View<'_, [u8]>, buffer: *const u8) {
+        // SAFETY:
+        // - `view.ptr` is valid MMIO memory for `view.size()` bytes.
+        // - `buffer` is valid for read for `view.size()` bytes.
+        unsafe {
+            bindings::memcpy_toio(view.ptr.cast(), buffer.cast(), view.size());
+        }
+    }
+}
+
 /// [`Mmio`] but using relaxed accessors.
 ///
 /// This type provides an implementation of [`Io`] that uses relaxed I/O MMIO operands instead of
@@ -1145,6 +1340,47 @@ fn io_write(view: SysMem<'_, $ty>, value: $ty) {
 #[cfg(CONFIG_64BIT)]
 impl_sysmem_io_capable!(u64);
 
+impl IoCopyable for SysMemBackend {
+    #[inline]
+    unsafe fn copy_from_io(view: Self::View<'_, [u8]>, buffer: *mut u8) {
+        // Use `bindings::memcpy` instead of copy_nonoverlapping for volatile.
+        // SAFETY:
+        // - `view.ptr` is in CPU address space and valid for read.
+        // - `buffer` is valid for write for `view.size()` bytes which is equal to `view.ptr.len()`.
+        unsafe { bindings::memcpy(buffer.cast(), view.ptr.cast(), view.ptr.len()) };
+    }
+
+    #[inline]
+    unsafe fn copy_to_io(view: Self::View<'_, [u8]>, buffer: *const u8) {
+        // Use `bindings::memcpy` instead of copy_nonoverlapping for volatile.
+        // SAFETY:
+        // - `view.ptr` is in CPU address space and valid for write.
+        // - `buffer` is valid for read for `view.size()` bytes which is equal to `view.ptr.len()`.
+        unsafe { bindings::memcpy(view.ptr.cast(), buffer.cast(), view.ptr.len()) };
+    }
+
+    #[inline]
+    fn copy_read<T: FromBytes>(view: Self::View<'_, T>) -> T {
+        // SAFETY:
+        // - Per type invariant, `ptr` is valid and aligned.
+        // - Using read_volatile() here so that race with hardware is well-defined.
+        // - Using read_volatile() here is not sound if it races with other CPU per Rust
+        //   rules, but this is allowed per LKMM.
+        // - The macro is only used on primitives so all bit patterns are valid.
+        unsafe { view.ptr.read_volatile() }
+    }
+
+    #[inline]
+    fn copy_write<T: IntoBytes>(view: Self::View<'_, T>, value: T) {
+        // SAFETY:
+        // - Per type invariant, `ptr` is valid and aligned.
+        // - Using write_volatile() here so that race with hardware is well-defined.
+        // - Using write_volatile() here is not sound if it races with other CPU per Rust
+        //   rules, but this is allowed per LKMM.
+        unsafe { view.ptr.write_volatile(value) }
+    }
+}
+
 /// System memory region.
 ///
 /// Provides `Io` trait implementation for kernel virtual address ranges,
diff --git a/samples/rust/rust_dma.rs b/samples/rust/rust_dma.rs
index 6727c441658a..b629acc6d915 100644
--- a/samples/rust/rust_dma.rs
+++ b/samples/rust/rust_dma.rs
@@ -12,7 +12,11 @@
         Device,
         DmaMask, //
     },
-    io::io_read,
+    io::{
+        io_project,
+        io_read,
+        Io, //
+    },
     page, pci,
     prelude::*,
     scatterlist::{Owned, SGTable},
@@ -35,6 +39,7 @@ struct DmaSampleDriver {
     (0xcd, 0xef),
 ];
 
+#[derive(FromBytes, IntoBytes)]
 struct MyStruct {
     h: u32,
     b: u32,
@@ -74,11 +79,11 @@ fn probe<'bound>(
             // SAFETY: There are no concurrent calls to DMA allocation and mapping primitives.
             unsafe { pdev.dma_set_mask_and_coherent(mask)? };
 
-            let mut ca: CoherentBox<[MyStruct]> =
-                CoherentBox::zeroed_slice(pdev.as_ref(), TEST_VALUES.len(), GFP_KERNEL)?;
+            let ca: Coherent<[MyStruct]> =
+                Coherent::zeroed_slice(pdev.as_ref(), TEST_VALUES.len(), GFP_KERNEL)?;
 
             for (i, value) in TEST_VALUES.into_iter().enumerate() {
-                ca.init_at(i, MyStruct::new(value.0, value.1))?;
+                io_project!(ca, [panic: i]).copy_write(MyStruct::new(value.0, value.1));
             }
 
             let size = 4 * page::PAGE_SIZE;
@@ -88,7 +93,7 @@ fn probe<'bound>(
 
             Ok(try_pin_init!(Self {
                 pdev: pdev.into(),
-                ca: ca.into(),
+                ca,
                 sgt <- sgt,
             }))
         })

-- 
2.54.0


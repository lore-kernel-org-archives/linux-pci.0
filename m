Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020111.outbound.protection.outlook.com [52.101.195.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FFAC30E0E5;
	Tue, 21 Apr 2026 14:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776783394; cv=fail; b=iV8gRLb/hmlQIROHX5AkcvjBdbbab/M0yFs7z+HowajUys0CB0vX3BWC45dCKMrtDXF3d+nLGGc2xC5MgEW4vmfCuD/pFog+t18ZxrgH0XZTYjeNEOi6ZIXnR9uXzXG0mKDUq6Km5xo0GsaoigAGEUD/lltybreQT9IisQH/qgA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776783394; c=relaxed/simple;
	bh=Sx5ASB/s1JTnFW22MELsFVBJd+afu94iWVkqh0/qKrM=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=HjKhufqJohWiGv+xkZFA4nU+fsRKccxbxkSodk1MFMoggiPDRwdhHUWUGdhOGXUFIi79LDONvyMlD89HrMcQrz6y8n5nXhkWXIhxUzaEFQ2XheI/Fm6gmRL56eR4TigWvGmTgwnJnv258uyQzYIZTLFmr0Sez2mCBe2x8wJzS8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=ifqdLYA2; arc=fail smtp.client-ip=52.101.195.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="ifqdLYA2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lRvvcmx5FJ18V4p+GoXb0zltNWEslJJhWE+T/h2jlAY7Pp57RjEvCZKGa7Ds5LTmsmf2X3NN4g+AptTVUnIMJLycnN4ee4hqk01EbUjmny4IfQHG8cVD9Ueis43C3CijUVAH/MGN9azgOIcEs+rWVbBLu+Hdyj0mbzIDaZK3NM86chzk4ZCtzhn6VlISJCsnDBOnEgSQatxVnuXFtLbZA/7r5OPrReKWer+GTDFVG4g1bHlEaL5C5z/W4JZv7HnQ4frknSMfUawFQLya5zBQbXOzshgM1Km7LYelAdTuWxu7vdl0kOxo1xBjyjQa8NDLNeuJt2pio9zyQEz+xQSIeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lCfV2+t++hO2k8Fn1VZHy6caeMFxqr4HNYPKk7oJ1Ak=;
 b=r2cub9jGPkP92rTTzLxhIL4lx7Btl0rEDul6hBKZi1jHobZeKzrzPx/Pd2r+Yc/X67O0YZBBpQZCooWoCWgpTYGMNehNTKzoIgV3ey7IoD5Imls7u2xJqB+nH9Tnx1aC+B8gdVszyA7ClDEoW/DXu9XFLi1Nejrx1nwq2pyCvsCrrg4xSs/fAlMxD1FxzJAzTlCfKN+sCBa2UTe39PIK2NslBnRKTZzp2zdPp84kiju5CaqwUL5d8isFHNnIT5INmEjle+hrherOUdU+/GZwybqTiior71kZ0XnqCnb1LqY2V3mY5jXSq3VlrW+L+5WgFjG08SkhkWIbKAA7Bs5N9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lCfV2+t++hO2k8Fn1VZHy6caeMFxqr4HNYPKk7oJ1Ak=;
 b=ifqdLYA25e5BOHiIzCFeTQKbPSqgJGMInsU4qRqxGD0ofUsUxQYu6cWKzamoBNOi69OqGEYO16J20dkiDbOLe1Qf/DcZm7uN1lmRKcTahKvfoeTZFlB4+JpQEKxhwUaDTzaNY975Nwdc/iUPbVlJGBvssa3nVcULUKU4qcU9Iak=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWXP265MB3558.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:fc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.33; Tue, 21 Apr
 2026 14:56:27 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 14:56:27 +0000
From: Gary Guo <gary@garyguo.net>
Subject: [PATCH v2 00/11] rust: I/O type generalization and projection
Date: Tue, 21 Apr 2026 15:56:11 +0100
Message-Id: <20260421-io_projection-v2-0-4c251c692ef4@garyguo.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAuQ52kC/02O7w6CIBRHX8XxubsBiS5fpbkGeCtqggGazfnu4
 Z+tPv62c8+5EwnoDQZSZRPxOJhgnE2DHzKi79LeEEyTNuGUFzTnDIy7dN49UMdEAiuwbLRQssS
 cpJvO49WMq+9cbzv0aqEXyU54fPUpFDfs10nZtcIE/CXCx0Y5gse3809Q5YnKIxVKC14NbDEqG
 RC0a1sTq8ziGGF/lpJ6nr/IBvSO4gAAAA==
X-Change-ID: 20260421-io_projection-16e7dc5ba7e4
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776783386; l=4249;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=Sx5ASB/s1JTnFW22MELsFVBJd+afu94iWVkqh0/qKrM=;
 b=+bzmrS9xdeeVnlweBLz6DjizV9+0yqELImt2Wk5nGlB/UwGdGcTI5ZmsCSVCDI0H41z9VpaGl
 f/2DvECszc6Do+dFcTeCio+PotO4ReIoQAXeR0Xfu8SdjXkbZsR9kD7
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
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWXP265MB3558:EE_
X-MS-Office365-Filtering-Correlation-Id: b05d3aa6-a5bc-4484-ef93-08de9fb629e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|10070799003|366016|1800799024|921020|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	9uXyyxKup4sRzKADW2cCUsRUn+x8hiX8Bkzog2SmEQYyoMz4QzUV6y5HQoBd7cOx95ZS2JOopWfBSf2gWrgDjouNZJOkQERGFAjp7fK5BFBgadVuCeCbS8jqX1hHkxPLMy1spwM9hEkh+BFX6F4USq854eUMnV5zWi0nCGnAej3PS0DVMAa49rCF7Y9QgC3QRUgFnvNc6HUQ80aAYV/YhCt6HuMZ57AG9q9LvNoq+IHgu4FAKJv/GvhXJ7tGxhZTihVnIItXMp7rehURKkVS+QypLdLSZk/9dKmPMlAk7823i0AKLNUWoQP2x8n0ooNeEXzSgt51NWvXT21KzAuQ2HidUaIxGm5E1qIwv7OcXMaOx3Cxy5BKAzUmQO43qE6hiNSfS5rPoQdY3rRNAuIvG/yLkR9tonY17C6It4wWqBfoDqOcEfmipdJM+zAt9paqxukJ8ZW2Za2ZVeG6XBg114VjwkEcSEVeQeSnQxKCHoWQHnC7wm1PZDHdhGa9zMCrcmLcVvUETkS5Va015FDx0qjg+E5ee/p3McP7Epwjnfzja3yXNFZuAAylsgg1cRuIa9Hzsf7jHPYI6yShJMt14lohYryGna7gJsFkT++ivGhZVnIXJ+Kem6JNFV/Z8IxMrTjCZ8tF3DosrXMGc+ZaPnMWWpDB0c/BPkupcP2qxTcw+Z/ksiJooNe/m0ujWz8loIYzXxpCdaSaZi6Mgw1UtwwmFZLdz823C5INPz92FYw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(366016)(1800799024)(921020)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RVhQZVIzRTZTTmtoZ3ZYTk5uQmgwamViMUR0SjcyM0xCU1R6N0xZYkZtM0w4?=
 =?utf-8?B?Y0tTMFNiRzJ6SFlnTEl4cmt1Wm9LS2NwcklHaU5ERXAyYk5wWTdaekFlTXYv?=
 =?utf-8?B?L0R2MTMwK3Q2RHRYb3FmK0lBSkpETHBtK051K2JaOTBQcTFqdjNxL3FnanRV?=
 =?utf-8?B?eDNGaEFWQmhnSmdScVRQaW00b3dtV3dFL2NPNGVuSlk4aVozTEZuOEw5U1Fu?=
 =?utf-8?B?d3ZZQUNodWx3VG55NDdRaEdIZFJLK294YzVIS2o3dFIvRzVTZkd2d1lIcjJw?=
 =?utf-8?B?YkVLYjJQUlJvRXhldWZjUXhnV01OZldDekVKekg2Lyt4cUdrUmF4eFpnWStz?=
 =?utf-8?B?eTdhNnpnbnlLaGU1VEI0dVhyUXhNaUJtT1JPdEJ3RXJKVEtoc1VkZzZUSzJw?=
 =?utf-8?B?UDBJdzNlNGxnU1dkTEVnWW9BY01QZUJOSDhGOGlITGlyMFNVVTFieXIwdHNB?=
 =?utf-8?B?R2ZCaG4wTVVSSGs4SklQbnAzWXFRVDlWT3U0TzVjaGdCMlUwZkIrZzcxV2dU?=
 =?utf-8?B?aHVnbDZwYkhOWElyQmdqSHY1Z3ZTYzA3dGVQeDJLN0IzZWwvTFpQN0d1RDRw?=
 =?utf-8?B?RU1LSVkrQzlLOXdLS1pPb2p4cWhrV0F4bjFseVZGTDNYOGdMcnFzUHdqTWR3?=
 =?utf-8?B?V055WTQycmhKZldMVWVYSnpWL1IxbTUwcm9WeWVVS1k1OWNyem80MENDbXlk?=
 =?utf-8?B?M3ZsNklkVWVDTFV5K2pDVG12dlhSY1dkb2ZYL2QzaVIrTnF6NzBZZGxyQTE2?=
 =?utf-8?B?YkZZaEMwSXdjSjhLTFlsWFhqZXNBb0srTUFmcG5ia3NxWThVaGRqOXZnd3h2?=
 =?utf-8?B?emRaTzNqd0ZvWTg1b0JSUlQ4dERQMmpxODJ4Q01vL2o4VTdlS0U1V3BOc0xh?=
 =?utf-8?B?ZFpxb3hLRktCOCtRRWVlVHB2RDZYWVRzSC9BOHF5OStOK3ZDL29aYkZMeE9p?=
 =?utf-8?B?U0pvZllqanQ0TjgvV2pLVzJKUVlPZUFKVFQvTmhlc1JjUDdaYzd4MkU2WHNM?=
 =?utf-8?B?ZDFPWE5QWDIwY3RGOHd5VFp6eTNNQUJPYWc3V2t1cG5aS01xWTFPT24reXo2?=
 =?utf-8?B?RVloRG1zZ1U2bGlDYzlweHNVczdZaERQeS9Yd2RyYmdBbWRwWmJFRGdia2ps?=
 =?utf-8?B?aUVWVW52U3NLUGZSUzNPeEgxeEpRUlNpam5tRXNUSHpTUWpQRzE3YUFPQjFH?=
 =?utf-8?B?NXRBZ2xBMVBoMFpWTlVIMmMzWHA2MkVCNWVvRXQ2dGd6UjZGbk1LbkZFV0R6?=
 =?utf-8?B?STFzdnIrRGRXb3l5czl6cVMwalFjS1QzMlpvM2lMblJpNnA4S0NVemxKNit3?=
 =?utf-8?B?T2FRTmlTYXpsMzJMWXljRE5sUDlKSjl2SmdMUlZ4aUxiRFRKM1E0YUl2RVd4?=
 =?utf-8?B?Tk5IOVVkZzBTRVRnOEx5cmJ6SFpUbENuekNCTCs1UEo3Slg3NEN3a05HQVkr?=
 =?utf-8?B?WkhoRDFpaC9DZCtqemNtZHFFRGxhRmNJYjdIcW05OXRCbFJRb3NiSUthOUFG?=
 =?utf-8?B?MTN3bWwybTJOa0piQTI1VUdueHJ4ZEFuc3ZwZkRFMnozVmFiNVZrNVlXS1pR?=
 =?utf-8?B?WVJBdVRzWmdNU1k4NGtQUFRFcTBxY3EzSEdmTGF6TEU1Ty9hWGJKbm1uYU9S?=
 =?utf-8?B?WTFST0FCRUQvNW42aGFrTmdtYW5jVENwRmN1blZSaUFOOXdHS2RqVDgwWEpU?=
 =?utf-8?B?UEhUKy91NUxtaTEwM2QrR2xvdHp5YVlFSk1jWkJibWZyamdhOXBOYWxLYkpY?=
 =?utf-8?B?aitMaFh6a2NncC9lY3d5bTFpWDQ0QnpGTkFaSWFQVUFuKzZrM1JYRGVMWkRG?=
 =?utf-8?B?K3dxaW1KRkh1QmpwYndNZE5TQjcyOEVQWEhycHZISDJmVWdZeEpSYnIzcjBO?=
 =?utf-8?B?Z2NzWGdVeHFKY1ltVFpZZ1U4NzlUYkJGaVhCVmlqeDlnaTZNUGJ0R1AwNUky?=
 =?utf-8?B?Z003MFhvSysyRno4cGM5UDlXTzVqRlVVayszNVp0UlA2MGVaaTcxSE1RK1NB?=
 =?utf-8?B?STJGMVFhc0lrdEgwNlRPVEZBKzFqUmlBNkZ3ckRjRVZhWGh6RHVyYVptNzJM?=
 =?utf-8?B?cklDZjk5TTlyZ2Frd0ZuVU0wK0d6WHhoUGt1RjFNR0JQZzNzQXZwbyttb2hp?=
 =?utf-8?B?VVdybXpmTWlsMGt3aFlJSndFZlVWaFZMaEduUXFlbzRFQzljdGNPdHNpZ05h?=
 =?utf-8?B?UmJUSDhwYmZNN3RPOEdaS1ljQnNJV1ZIanR3RXZBR2hEMy9wVHZDUVBlZEQr?=
 =?utf-8?B?cTNoREV3bmFTMmxHOGpPQVFKQTVHOFhNTUFobk9OV0xGMHFIMkd2VVFiSFU3?=
 =?utf-8?B?d0ljY2o3V3VYUENFc1hCUy9MRFg3WUxVaDZ0MTVqR3ZTZ0IrVXJjQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: b05d3aa6-a5bc-4484-ef93-08de9fb629e6
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 14:56:27.0207
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OQ3EEvFMth9NOwTativDAe2vIwjgxZWOXiknG7oFoHTzU7E7YdRya7j4CWwfi/x4yTNA6JcfAz9rfFpy7Tw5iQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB3558

This series generalize `Mmio`/`MmioRaw` type from just an untyped region
to typed representations (so `MmioRaw<T>` is `__iomem *T`). This allows
us to remove the `IoKnownSize` trait; the information is sourced from
just the pointer from the `KnownSize` trait instead.

This enables us to implement `Io` trait for `Coherent<T>`, enabling
unified handling of MMIO and DMA coherent memory. It also paves the way
to uniformly support shared system memory, which Tyr will likely need
[1].

Built on this generalization, this series also add a `io::View` type
which represents a subview of a bigger I/O region, and a `io_project!()`
macro that provides a safe way to perform this. Some Nova code has been
converted in this series to demonstrate cleanups possible with this
addition.

New `io_read!()`, `io_write!()` has been added that supersedes
`dma_read!()`, `dma_write!()` macro. Although, they work for primitives
only (to be exact, types that the backend is `IoCapable` of).
One feature that was lost from the old `dma_read!()` and `dma_write!()`
series was the ability to read/write a large structs. However, the
semantics was unclear to begin with, as there was no guarantee about their
atomicity even for structs that were small enough to fit in u32.

In this series, I've introduced a new patch that re-introduces the
capability in the form of copying methods.

    dma_read!(foo, bar) -> io_project!(foo, bar).copy_read()
    dma_write!(foo, bar, baz) -> io_project!(foo, bar).copy_write(baz)

The semantics for these are modelled after memcpy so it has clear
semantics. This also makes it work for MMIO, which maps to
`memcpy_{from,to}io`.

This series depend on the projection syntax rework series [2].

Link: https://rust-for-linux.zulipchat.com/#narrow/channel/288089-General/topic/Generic.20I.2FO.20backends/near/572377073 [1]
Link: https://lore.kernel.org/rust-for-linux/20260415-projection-syntax-rework-v1-0-450723cb3727@garyguo.net/ [2]

Changes since v1:
- Rebased on projection syntax rework
- Added a new patch to forbid use of untyped I/O accessors and register
  macros on typed I/O structs (Alex).
- Fixed a few safety comments (Andreas).
- Added a new patch that implements copying methods (see above).
- Link to v1: https://lore.kernel.org/rust-for-linux/20260323153807.1360705-1-gary@kernel.org/

---
Gary Guo (11):
      rust: io: generalize `MmioRaw` to pointer to arbitrary type
      rust: io: generalize `Mmio` to arbitrary type
      rust: io: use pointer types instead of address
      rust: io: add missing safety requirement in `IoCapable` methods
      rust: io: restrict untyped IO access and `register!` to `Region`
      rust: io: add view type
      rust: dma: add methods to unsafely create reference from subview
      rust: io: add `read_val` and `write_val` function on I/O view
      gpu: nova-core: use I/O projection for cleaner encapsulation
      rust: dma: drop `dma_read!` and `dma_write!` API
      rust: io: add copying methods

 drivers/gpu/nova-core/gsp.rs      |  44 ++-
 drivers/gpu/nova-core/gsp/cmdq.rs |  65 ++--
 drivers/gpu/nova-core/gsp/fw.rs   |  84 ++---
 rust/kernel/devres.rs             |  11 +-
 rust/kernel/dma.rs                | 232 ++++++------
 rust/kernel/io.rs                 | 769 ++++++++++++++++++++++++++++++++------
 rust/kernel/io/mem.rs             |  10 +-
 rust/kernel/io/poll.rs            |   6 +-
 rust/kernel/io/register.rs        |  40 +-
 rust/kernel/pci/io.rs             |  80 ++--
 rust/kernel/ptr.rs                |   7 +
 samples/rust/rust_dma.rs          |  14 +-
 12 files changed, 948 insertions(+), 414 deletions(-)
---
base-commit: 77a9bb0193d790fb71c0edfc567bddc1b56fb3ff
change-id: 20260421-io_projection-16e7dc5ba7e4
prerequisite-change-id: 20260415-projection-syntax-rework-b790a305bc52:v1
prerequisite-patch-id: 110c29f61d0e7259d64057b6f364587c5ee501f5
prerequisite-patch-id: c157387d475fa22e32fc87d831a1ec384d256ca4
prerequisite-patch-id: 4109733485cae727763b2cd9ece69742e3d17cbf
prerequisite-patch-id: 5b686696f7dada42bb0768d255699dda0252234b
prerequisite-patch-id: a736703c95dc35a23e8c52bbdcba0ca9f38b55fb

Best regards,
--  
Gary Guo <gary@garyguo.net>


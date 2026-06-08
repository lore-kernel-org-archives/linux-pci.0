Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020099.outbound.protection.outlook.com [52.101.195.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF873E832C;
	Mon,  8 Jun 2026 19:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780948756; cv=fail; b=dGVN27ifJE11019w8gUOQwVNqh6iGAue3W2BQCF+ZKWG17bn/wJlTLgCNi5b1X5fonC6jjZ9jjiN5Ef8tAN+OBKcG4T1sAdrhEfluz0lDO6MCDiCaLboF+jzgCQ1DRV2j8seDkHXllC/f1/pI/BatqJ16j0Y0JQ0D/si7r9IWFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780948756; c=relaxed/simple;
	bh=Tea55Lo1duKNxqLyhoQ5f6Xol5yJCDNFmnNksA5tcio=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=Vt0wQtEJMfeQEXk6l77715NO+GyvmC2RsBLeXL9kt9Lyh+tpd60E1Dj6U0S/f6QD3W/XOMIaqt8aRhEs80oZRs91mJyDbbiIV2B8B0p6oDStyohmg8efk4kFC5BDI+r0bAHFvcustNBJwT7MDPdXc2LQ+LJTk2vDb/LIbl/lzPE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=XfqZ9Eux; arc=fail smtp.client-ip=52.101.195.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="XfqZ9Eux"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yvfq7GsfnO7DLyGOpoDd8eUs+nI9A1Eda1LInrUowwaE+JCo5Qo4lsDmDNnvSbUa++zNiF5cxmwBKLZ3HynpprL8r2jVRf+0+Mu1fDLPAXB0azV1QBmKZv4BK5MjHwPTA4FGX7oni7whM0VuyUQ8Vw/FTivhnp7BbTowFSOz4h92rgA/BRLIHRQuFg7D052g0pfccn7nxm248F9+V5r4mzs/tdeu9+iYXznGeWUB9TbFPKEnFzU7YLk8g21JJ7q799Vs5aGeGBRtOduucY0f8Esk2xl4Dbe5VPeeTRgx4Zc4Zg10h6z2Q+7rtohNtoLzRedcxPtwodDvNB6dCACpVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JUvtWacBg9F/+q5hTGN2jHh5mLHZsCdc2+BdNsX6lvg=;
 b=g38T2IgqTzs8zS0nRdlV2yJ8VHoadRMm26WB+hdyJ15V+S/JFf+ae4e5KTjvB2crlDQfAE9UvHLbEhpXnurjl+yyqHQUzjgRsIarx/LZU35rVoOG0w9IyQuiPAIOF1YR/pXNIL1B77k4tof5dzGb4OOkeAbK6nH3HmiXN5rklbbjsRTjt29lEBfZcIlwPMEs9iPalio9ExjfIWRxChbnFNzOrYPpsuCbmRg7Oc9DPkknDBG8Q5iH5AM6ammOYLS3BYhZx77+B/3BCpJaqyvflW5Dy+5GdCOJVHlVYBmAVOpngyvfFymf9xlfSLjyLRECB/pVrHkMEibK/CzI+sXmbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JUvtWacBg9F/+q5hTGN2jHh5mLHZsCdc2+BdNsX6lvg=;
 b=XfqZ9EuxkErk70DKAdYtBViI+bwt1zswREVdYyDizxhecEgkXmq/tM1HlJSMir9QhwrFlfCa/dx4H4zUF4iF+O8RZfI3FxjWMDdHhmXQ/sC1/m0T2BqJAwOpWAuz4y0EG0qE5SPogXNxPjBC+jwb1eLm8eKnDFWD7Tf1CiQ9Vcg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO8P265MB7398.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:3ca::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Mon, 8 Jun 2026
 19:59:08 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 19:59:08 +0000
From: Gary Guo <gary@garyguo.net>
Subject: [PATCH v3 00/19] rust: I/O type generalization and projection
Date: Mon, 08 Jun 2026 20:58:57 +0100
Message-Id: <20260608-io_projection-v3-0-c5cde13a5ec4@garyguo.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAEfJ2oC/3WOQQ6CMBREr0L+2ppSCygr72GIKeUDNbHFthAI4
 e6W4tblJG/ezAoOrUIHZbKCxUk5ZXQIl1MCshe6Q6KakIFRllPOUqLMc7DmhdIHkqQ5Fo3MalE
 gh9AZLLZqjr5HdWQ31ju9S36Exc8YhvyBQS0cEmneb+XLROPsSRzL6RV2Ra+cN3aJDycWG3/OT
 IxQwiXLUpnfGLb83gm7dKM5a/RQbdv2BbsA8jrvAAAA
X-Change-ID: 20260421-io_projection-16e7dc5ba7e4
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
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
Cc: driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 Laura Nao <laura.nao@collabora.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780948747; l=6702;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=Tea55Lo1duKNxqLyhoQ5f6Xol5yJCDNFmnNksA5tcio=;
 b=fmLLI3kPtvVdfU01RoU6xak8iTgvOwYe1dOhPmmIVepzlT3tDPgMVC9hqMKLZZ+Vs2xiU7d/3
 oolmtqwZsjNDZAk8FU5Ykj3T0fe2L8lxv89YPx56MOz3dsItqU5TE9J
X-Developer-Key: i=gary@garyguo.net; a=ed25519;
 pk=vB3uIX95SM4eVrIqo1DWNWKDKD2xzB+yLLLr0yOPYMo=
X-ClientProxiedBy: LO4P123CA0344.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18d::7) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO8P265MB7398:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c3569a9-68ba-4038-c465-08dec598668b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|10070799003|6133799003|18002099003|921020|56012099006|5023799004;
X-Microsoft-Antispam-Message-Info:
	DhUGFv0Uh2A480dbLnoBgNq6owinhWledY52ZqmWXw8Xvt6HwkR305Es22tnr/MXgQtTP9xUvOUDmUlHW5rMyWTz0xQgbAUpoSpdX/Lx9AA5HR6hkMPtddTotIgvPbrfCBqHgeztEPD2ZAnCBoWhtISF1T56TZZrvSEZ6Nt1vf5tfXQAz0p0nKQXD/65DVKLvTTM+vy1t8q2lszeAwmtdAPpdsi0hwoYUq/XH3T41ucMGWGtTwzFO03LPJbDa4z2exop0WCMauTioRJVJJyeAqjS2B03j3ULVHaU4IagHJZM72PKQWgZPWFuuRTrl9vTKpc1MHOgYW0YrvMGcjM6hG4c5tcphKlos2rJXCaPxkc4Jsqly/+fHZrYJFtfuWUmxOaxcN6Z7bAmj8DlGMUrE5WMl1sA7I2SiZvSsCb0ODpdYDrYHRxDjBTK+2fWfm1dmaJcm2a8yZAUFfJkYJAzFc4i3ATyS1B5OZTgouscSRk2uYS9x0G3TU6vc4BVODOz0hIpq3qT59sND6HA0cbbHepBsx+nb7su7Eggyk4PuVJrXX7bcvDO+4qyLQnuqYuYxXuT+8FGsIl0B7M/klgOR2GwKJWlV2qM/lD1X+LrWgGnsIVTNEtg2EkM8VcCdvfrJmvNhH8KiHS4kSC3fqYG9WNSMJ7QKig3vlNcBky6zg/vD0vVmWCJoohIa4tndFyy
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(10070799003)(6133799003)(18002099003)(921020)(56012099006)(5023799004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b24vaStmQnMwblVXcjRjOFU2NnJIS1IrVlJqaWMvWHRzNEk3Tk5Yb0ovbGkx?=
 =?utf-8?B?Ty8wOHhXK09Rdjh5UUNKZ01JWkNzQ3pGK2d0V3BmVml5dlBkQnkwM0d0Yy9t?=
 =?utf-8?B?b3pyOENQMzkwT29DaUtQamYxRUYwQmJ2K0lpL1ZrVXdVRjdTV29PZm81WWxK?=
 =?utf-8?B?UE1Qbnd2VUovdlUvU2NJWjlWenhDSFlpQ3ZLYlE4Tmp5dm1CZVFDQlNSSnlK?=
 =?utf-8?B?ZUppYjlZK3NmUVBBQWZuajFBNXhZNFhyck40NFhLRnMwMkh6SjN1S29tZHJL?=
 =?utf-8?B?NTNGTk1iejYyMGVRQlVwbjhMdVVoSGpXVmhROEdYUFJCaUY4T2E1OXRvcEFF?=
 =?utf-8?B?bUFJMzlUcXIxVGYya1EwWkluTWNGNXJwWEdjRHZqN21QTUJBdWxHR0VRc3dR?=
 =?utf-8?B?cmd2L1dxQ3RqalR2MndEZkt6dVdSdUpHckpCdXg5YjJKT0FiN3JndTlSQXhK?=
 =?utf-8?B?ZnhqM3NtS2NMZnJ3WGlUL0FHWW45MmZJMGw1YXh0dXgwaWVyRyt4ZVE4bVV2?=
 =?utf-8?B?SVBVZUQxVDB2aXZKdzBWOVlZZ3BnbHljUnlOdEtScHdEa1BRb3hrT0EwZVA2?=
 =?utf-8?B?bEpIV0tqbWthWG9MZ2Q4N3dFN1U1RjBRUDVjNS9pOSszbFFGejNHOURVS0pw?=
 =?utf-8?B?L0s1OHZBaFhUWHlUMCtEVzRvVXRHNm4rMTVFWUhwVzd1Y29ZR1JZZklaUHRj?=
 =?utf-8?B?eno4dWNjZXpQOXdPTlhSTGhUUFR2elJQUUIrc0wzUjBsUkM4Vk1OR1A4RWlC?=
 =?utf-8?B?OVpqbXN6WjFYOWxGc0lzd2NlWURMRitMTVlOQ3ZyZkJNK01DMDlQcnhGOVlM?=
 =?utf-8?B?TDZVc0NNWmdvNGpzRzlYOHllUnJYNDVQM1pra0FqUGF2UkJ6a0MxbDYxN2FF?=
 =?utf-8?B?czhGN09mdDJBT3FLcnhjeGJBS1pWMDd2RkRCWll1bEJHK1VEYmNjQU5oVXdS?=
 =?utf-8?B?bGdLZUt5MFBWU1BnMXRKY0xlRmRIZTVOR2dXUFVCOFJGdVNFUnVPNlNCYTFr?=
 =?utf-8?B?VnY0YWNrTTQxWFBXMFIyLzBuODh3aWk5WEpVQ1J3dmk0cFpGeExEQmg5bmpZ?=
 =?utf-8?B?Mk1ZYjdTMHdsVUlsRUxWNjFTT1VJL1lselVTbktrQ2dqemxkQ2FtN0d0UUht?=
 =?utf-8?B?aUpkQXQ0T2cvODEzeXhMU0tIQk5CTlhLMTZZaWRQcFFZS3BuekhHRm1zT2xU?=
 =?utf-8?B?d09mRDhBN1JINS91d2RrQVJjV0Y5Z3o1b3piMmJDampSZmFpS25FYVNET1pr?=
 =?utf-8?B?Tm5OVWlndGZJcWlVcytmRmc1by9aTW9zcTJ3bUdKRTFSV041RnIzdDB4QXht?=
 =?utf-8?B?YjQ0a1I0Q0paaG4xM2pBdnkwR1RXaTNlWmR2d2pScVViUUNzYkp0OWV2R1Yr?=
 =?utf-8?B?cm40MDRSQUNJRW4ya2pnT285eENYM0kyTE1xREExeFV2WXkzdHN3TjQ4WWNN?=
 =?utf-8?B?b3didFhzSEZiYWpMWkZqTDZWMENrNkV3bURwdk40U1NUN3lKVTIwd3R0aXI2?=
 =?utf-8?B?MVdHMFEzVW5TMUxsck9kSFlBcnd3WlpYUXRDdXlVL0pLR2ZITlVXc0hKelhq?=
 =?utf-8?B?YURTN0FzOUxMMEpBbDlXeUNNTFBYQ09zZUg4REFCdlN4eForN1F3dm9CRkFY?=
 =?utf-8?B?UVBqNlRzME5sOWY5R1gzT2xQZmpFb3p5ejM4WHE4WFozRXkyZm9NandLd0ZK?=
 =?utf-8?B?bWRNYk9qMDFJeXV6T0NySkQyQ2VxWlpXeEJtUVYwVHRPeFdkOFdrNE01RE02?=
 =?utf-8?B?M1ZnY0NuZ1RCNzZEWjY0YW9TTDcxbTJUb2lIQ0VZcDM4aXZJazRRbUJGV2RT?=
 =?utf-8?B?MEVnUEJhZTl3ZkpuSWV4dHRiZ3NUR05zSk1CajdzWGpmbExNWTI0YTBSYlRF?=
 =?utf-8?B?Lzg3NEtIRTNhRy9xcEpiNDd6YytmWlhaQSt5UUIxY3pwckxWR05nZzZ4dFdR?=
 =?utf-8?B?Y0xKengwb1Q1S2g1Rlh5QmdlQ0NlRWlhcmZXY01sK09MSlgrakpYZ1pkRXpz?=
 =?utf-8?B?eXFzMzZWNno4cXAwRkpMQmdUSDdHaXNpOXpXQlQyZDNRR01jeWtSMVYwcEZG?=
 =?utf-8?B?bGZCN2lnWGxkQnVCWVZFL3g1bTBFcVBJZFJBdjNhc0VmK25ZTUtUTXFJV2g1?=
 =?utf-8?B?cjE4Wis2Q1V5UjVKUXVVUVBKSEVQZkFDa0VEK1BWclBKbFFPY3VEREhaczFJ?=
 =?utf-8?B?ZmNEYVVvSmlkaEVXaERuR1BvOGlVV2hFNzlJMGg1S3ozQ2QxUzlPa3MzOXRz?=
 =?utf-8?B?YURHZTBLRmlBa2ZDdjUvTnBiaDhpSTkyZURrcDBrSXMvLzFYbzNnZ1N4TmR4?=
 =?utf-8?B?d0tiNnl1cDI3NVZVc1laZDRMb3V4U0p4MWc1Qmp3ZE9KU3d2SStjQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c3569a9-68ba-4038-c465-08dec598668b
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 19:59:08.0611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wU+ACFy9bnBmRGjjC4y4sNNTuzKLkKvRdGe/3EtKBODsPMaOCyLDbbsvqxaKqSJ1JdVdL5Mr1dHRo/rulEvfBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO8P265MB7398

This series present a major rework of I/O types, as a summary:

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

The last commit in the series is included for reference only, as a
demonstration on how you can use all of this to implement `iosys_map` using
`Either` type. It automatically gains all the methods via `Io` trait and
can be projected with the macros.

---
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
Gary Guo (18):
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
      rust: io: add projection macro and methods
      rust: io: implement a view type for `Coherent`
      rust: io: add `read_val` and `write_val` function on `Io`
      gpu: nova-core: use I/O projection for cleaner encapsulation
      rust: dma: drop `dma_read!` and `dma_write!` API
      rust: io: add copying methods
      rust: io: implement `Io` for `Either`

Laura Nao (1):
      rust: io: add I/O backend for system memory with volatile access

 drivers/gpu/nova-core/gsp.rs      |   40 +-
 drivers/gpu/nova-core/gsp/cmdq.rs |   66 +-
 drivers/gpu/nova-core/gsp/fw.rs   |   82 +-
 rust/helpers/io.c                 |   13 +
 rust/kernel/devres.rs             |   24 +-
 rust/kernel/dma.rs                |  264 ++++---
 rust/kernel/io.rs                 | 1559 +++++++++++++++++++++++++++++--------
 rust/kernel/io/mem.rs             |   29 +-
 rust/kernel/io/poll.rs            |    6 +-
 rust/kernel/io/register.rs        |   45 +-
 rust/kernel/pci.rs                |    1 -
 rust/kernel/pci/io.rs             |  162 ++--
 rust/kernel/ptr.rs                |   12 +
 rust/kernel/types.rs              |    9 +
 samples/rust/rust_dma.rs          |   11 +-
 15 files changed, 1666 insertions(+), 657 deletions(-)
---
base-commit: ea8a803d3ef1bc668d777516e00c3bb478d17c23
change-id: 20260421-io_projection-16e7dc5ba7e4

Best regards,
--  
Gary Guo <gary@garyguo.net>


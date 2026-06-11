Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022091.outbound.protection.outlook.com [52.101.101.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450C643E9F9;
	Thu, 11 Jun 2026 16:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781195320; cv=fail; b=Y0c6jHBt362F0EnZHPSkilUX9iLJkzNK8z/JqkDvE5ukEj1JXKzDJhOu7X28ivaAScwveunNGbcOKV/cFT/bjkWpv5/nbpFIoz4hBIHZCTSw4c+jR/oIwTlMLEgndBHaoF19RKJMbBiInGYO7xU53jKGGDuRVUQcJlE13zEFOE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781195320; c=relaxed/simple;
	bh=m2abPIgZ6CghqZ+aAQw1cMwRAHP/vg/dHPFnI7W46lk=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=IbYVpuoGM7KYYTEOrk+KVmaji+2kpDeKBXM6DZxLgAeBzn9wGaYW/IuFPrDKO1ENUvPob1uq3ZXQHev0j617ooBQ1Bg7SbVGPBqiDoNZiqgkmSI7Gq/lCHLir8ra9L5YVdlBLHnnvf5dN33uxw1iiWudodDLmO0uPoSbhkwm+v0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=FVQzuuiY; arc=fail smtp.client-ip=52.101.101.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="FVQzuuiY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G2Q1mhaC98SskEesl7dCUq3skb3zBKSpgPImMqJOj8bPud6WOfay2IgYB/B+4OZiZPDtS90lJghZLKkgc9EGr5Cvv6OR937HFsG7z9TaTTgniWfKsxy78HRcfLu/3Syv8dzhtmmDQTVtB5axqigWGdCfC0OC2Nq8kKl1PozveA/6X5WkR4Z/+hyv6wrTluKES0fv4ON7TWr3o+STs+c8RbzoNOEvFk7SIEh4iw3xlkiCWSZkNocGJqpiuQ+AWWQmKrgSqF8XJqznvGawnkHG+2gZDYrENC5NesZH1U4Y7YjswX6vXh42EvGnJSSnZWgh89etaiMBXHGIsBomXee4lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5aB7+V4PpNFVng659EBSbn8C1kIck9PoJQ0ssacoBk4=;
 b=UfaxJC6UTebMaC58pQpdARDzmPj6ig9JvmvmT8wmzmx9eM9hEC2s5ynKSJKid8DVV5rn2mE3s2I4oHt4iZObQjDt/mHs9ilpuTF0mnSoRgfk2ndSO4+fjl39lGb6mzGCw9doftW8vrW2Tm+/u24huAc8d502L/fkrk4X9MaPxvB9O6QWkRWaL+iwV2CXZrOe/qCPVeAdLLAKPHSUWXITqMqNLFMuwukTMcMKgp9zaWbp8ni9oKU3WYdQklcHhFLnXNnmpETYzzwY8TSI2ChIGOjFux6ffF/ittdAT8w9+3xsRawZSsPjYZ1HdgrKlKF7ZukqKQa+gYwDGOvmwQk0Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5aB7+V4PpNFVng659EBSbn8C1kIck9PoJQ0ssacoBk4=;
 b=FVQzuuiYhUWnLWVb+c6geYB74y/fiKLdAsfljr6gL575/wmg+fWvrlmD9Q0wzKUlXYuubh/Kdj+T6zt1trlVMLVcyb7MQFjDdTAtgXl9+GmZmX5Vb+zIbELvCOwzn9KUoxSuUrSGATluVJCuHOwsP53iEgYTkO5tHhL+ExjCFjs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:27c::13)
 by LO2P265MB3263.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:156::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Thu, 11 Jun
 2026 16:28:24 +0000
Received: from CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c9e:93c8:10db:e995]) by CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c9e:93c8:10db:e995%6]) with mapi id 15.21.0113.011; Thu, 11 Jun 2026
 16:28:24 +0000
From: Gary Guo <gary@garyguo.net>
Date: Thu, 11 Jun 2026 17:28:05 +0100
Subject: [PATCH v4 03/20] rust: io: restrict untyped IO access and
 `register!` to `Region`
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-io_projection-v4-3-1f7224b02dcb@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781195301; l=13424;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=m2abPIgZ6CghqZ+aAQw1cMwRAHP/vg/dHPFnI7W46lk=;
 b=E3vwb+pYw4gMGFfXfia7vl/heUsfCI4bd0lGSWgEszcov236tU9FJzMeTZLRn7FGzoHz546Sn
 4pLfhwfCewvD+rCaOZFXQTESnSEkwHvfAYtnk05/y0SnrNQoqpu4z/u
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
X-MS-Office365-Filtering-Correlation-Id: a3ad979d-a615-4c23-31e9-08dec7d6759a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|7416014|376014|366016|23010399003|18002099003|22082099003|921020|5023799004|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info:
	VacDnDYbnl88uTwclzXsYy7oNLi5D7SQZjRb1Wc4zxUmmOymG8I/W8YK31tJ/qgsalbsg0GU8gZ2IUODDUwGa53YUlNumzlZw19Vuu1XEo4OdTeqoQ353z6rXjfcY0HxBCyIza1SNzYS2hQpCxPRr3JwC77RG/taOtsJdiIwQ7nzxoiVzWvoNFrXK0WZcdnVRHCnQkdA4uBHxqFQMjxckHmBFz8iHmqk2AO/ICTLpRsYP13AplriYZfyenZAjBqkAOdhLAMt+MNv+DxNrSfHgc/5ZckCF/v+VL0+456KzYErGnzjGnTxlUA5JjboN9qCJ1XJXSBrTcwjjPVeUyI7H6st0/RvY7HvIxC3OMQg8OYigENB+v73AwYXP0dSIupUz1p106GRfMe1l5S1rqpDdhGAWFtUrMUHgS7/NDqnHX/eADr7917TicbztjNVEwfkd4sPHdIIKxQWTd+MY7JH74JudHHDn2wt/LTLUdHy+VupsMxmBWqtnXqzU29Lj792j6um2CBKvyKfoFuFupTOYp1wUtQgE3G3X70orAgEJ2PPIfDnZ23l26G7HcQT8sYaocbSsL2r29dC6pRYdClvtKv7B6Mxcxs26uJRdOc2dF1dpcsISCni7OSipRxBgVPFKXy4KYl4jO8l8zi+VmRY1oUafiEfr21+L/1JISToclgmAG5sn/EIy3cZAb30u+NQL3rPvkX07yj3995vgUEH1R6pdldGFr/8GKfsPMfTohHTk9Ou/wQBqMMjSRguI8RD
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(7416014)(376014)(366016)(23010399003)(18002099003)(22082099003)(921020)(5023799004)(6133799003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?My9sYjhIaTNjbVRqVlZEQXFmN0V1S1hwUHJ3QjRMUVFhZU9GK2Q2QnpYMWIv?=
 =?utf-8?B?OVBSRDFTSmJ6OEhvNS9pVnQ5SXBoUjJxT1dxQ0xCZjVhdVR2bG5HbGtyRUhU?=
 =?utf-8?B?Tng5RU1nSm9qaUhMNXJQa2R6VmV5OEE3eGM3TVA3bWlyUllWeDIzRUZKZG9k?=
 =?utf-8?B?MFJFL29BcnRmZ1NTZFdZK25Ga2l3c3lFbC8yR0t0L2ZVQ1oxU25SRTZTRTVD?=
 =?utf-8?B?UXQ5WmtwSkxYbjJ1MlJ3SVBYR0k5aVhIK2hEU2tab2VITFB1ckdMeWg3NXFt?=
 =?utf-8?B?MXVuNDdpS0Ftc0YyWUgvbHMwRUhMUXdsTUFlWWpNejZ0ZWpQWWswQ3l4WXUw?=
 =?utf-8?B?dlI3dXEvUjYwajFLbldVYXhVTlNQMitQNURxM0pSdE1tMmk2MWt4cXhGWUFK?=
 =?utf-8?B?WVcyMUg1bmV0KzYzZjBnczVPcmZqaDBKUEdjUlRwaFlRYlI4YWJYOTNpNk8z?=
 =?utf-8?B?czNVOSsyQVFublFGQllIMlFxTW8rODFsNlpYQWJ2MUdDN0hxY2NjQTdsOG8x?=
 =?utf-8?B?eGtQVVQ5NC96SDZHbDUzNjAzWGNoT2NHNERQNEZrNW00SGtiTGVnSitFVGpu?=
 =?utf-8?B?UjZ2UU5wYTJBS3Roa3R0UHlMYjA3SExPRmpPOE51bG4xbmlzS25FWnlOdjFl?=
 =?utf-8?B?elRLbWIvMkxRUXBNU0ZPNC8xd01iVkh0eFMzSUkyNkNad3lONG1NUDhDQSsw?=
 =?utf-8?B?enVWTEVsMHdsS1hpNmFsWWNUWm4vMkZ2S1dCNDBVQkN5N0hxTmxUYVhxcjZo?=
 =?utf-8?B?bU5rZ0RpRWFRdVNlQ2FGaHJxUElkTFZudTAvdk9LVGNuT3dLRTZ1UFppTnho?=
 =?utf-8?B?ZVZZdjBQS3JLemNWZVVkNG1NOHNLbmFXb0theWlibVBscW5yemU0emM0WnhY?=
 =?utf-8?B?VGcySEpxTEFadHlJS0hNNGxtZ2pZRDEzVTJjOTFQK0hTS0FPck1BTHpobjV2?=
 =?utf-8?B?U2lDbk1oL0JvRDJSZXV3VzVyNmpvYTREeC93eDdiSjBvMkw3T2F4akZ2RzBv?=
 =?utf-8?B?RFJSandMdk9YSm9ZUWxROXRia25JOUpTZk1wYmJRakFYODN2R0hVclJudXRK?=
 =?utf-8?B?ZnFCT1gvN1Q5L3l3bDBtd1lZQ085QlB0WG5NY0EzNVN5SHRxM0R5bDYwekRm?=
 =?utf-8?B?eC91aktDajlMMUNCRzRXQnpFNERIUmpmbTNQZVlWcDk1VGpzWW5MbDZlNlV1?=
 =?utf-8?B?L09PNjdoYmwvL2NyeUFkUytDN28zNWdOUGRxZDNlSnVRNGJSelBNK2h4QUM4?=
 =?utf-8?B?cDJ6WFFnS1ZVUG15YWkwY1FEQTdYeDZZZE9FNlBrY2s1T21jZitlaUJvT0FH?=
 =?utf-8?B?ZGlrZGpaOS96dnhzRlZYaHFWTnJSNjRrc2RBZnU2cUxRZVZOL2lWU0EvaTlu?=
 =?utf-8?B?MXVvWGlGR1FTRXdJVnRNQjZ0YlN2UkU2R2ZNNlFsSUZPYXUzSjNYQ29IRDBP?=
 =?utf-8?B?VG1lR29neEI5d3RWQitsVDVQTHRqc1h6TG1DcEcyeDBuVWcvZmQxTUZHQzg2?=
 =?utf-8?B?cHNHNjhXYkVGZnpjdzEyQUtoeXhoZUY1RHVZQTRDMC9BbFVoeHJwbUJneEZ2?=
 =?utf-8?B?Q0dlekprTFpYZm9rT2R1VE5jaXllc1pxZWp6dEZFbFVZWEZDQW05TWdmMURJ?=
 =?utf-8?B?czBYQkFDbmd1TFdmS1NRd3lsdDVsRXl1bFZwRFRYK0lTVXk2Z2RCWVZYUW1q?=
 =?utf-8?B?QUJZTS9QZVR4NDdET2ZISzY3QVQ0Q3g5UTA5dm9wMC9pdGRjVk1YcWZWL3Fm?=
 =?utf-8?B?Mm5peXF6TWpYd1lKU3VPbFZBL29pVWZLVVh6Y0NlWEhsZklFa3lDeTNINGV0?=
 =?utf-8?B?WTFHaTNCaENZenRyQ3BINVpNWDBFaVZkS1FZdnp5WWQzeWlranZqYkFjWkhT?=
 =?utf-8?B?MmVnQVRaTXJrcFVrSHZaUjA5NVlIWnhJaWFhZ2RWNXZ1ZFNhRXBpUTBteVgz?=
 =?utf-8?B?TUZxZFpoWlk0aHRZbTl1Uk1RdXVvWFhkVTA2TlFrTlZVVnJTais0aG9qcWFm?=
 =?utf-8?B?a0JETU85ZDhwS2tWSDRWRy95Znh3K1ZwcHMwNmdTcU5EVTNncGlsd1pSTlpS?=
 =?utf-8?B?S0V5MlN4VDc3bkRvb0szRFExcHplSFB6c3VmTkR1YlloSW9DSnEwVmpMcWd3?=
 =?utf-8?B?Y2oxQWQ2N1lRdk1uSXdzN3IwWEFUVUxuNi91MGZ5OGFtTy90T2hrS0UyU1Zj?=
 =?utf-8?B?NjNvYW5TTmpHYnVGcG1kRllWWDNMeW9tWG12cStnUG1GQUhLZEZEekZrRnJm?=
 =?utf-8?B?aUtoMkxWS0FIQ1FFaVBCTTFETkV6L3EwbjcwUklpK0xBK05NeWppa2Vkb3lZ?=
 =?utf-8?B?VnFWSmhKR0ljdUhRd2kybGFBbGZIUm5xbWVJYTBBUFFoZGt3b0d2UT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: a3ad979d-a615-4c23-31e9-08dec7d6759a
X-MS-Exchange-CrossTenant-AuthSource: CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 16:28:24.4036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QpnLDvngK4V7JVd7MiMjqAG6uCNEq87+PVh930STEgEfZXhm+d4cRVC5XLJmcS3B2bU9JA/i/CQRfnmIzFyzsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB3263

Currently the `Io` trait exposes a bunch of untyped IO accesses, but if the
`Io` region itself is typed, then it might be weird to have

    let io: Mmio<u32> = /* ... */;
    io.read8(1);

while not unsound, it is surely strange. Thus, restrict the untyped methods
and also the register macro to `Region` type only.

Implement it by adding a generic type to `IoLoc` indicating allowed base
types. This also paves the way to add typed register blocks in the future;
for example, we could use this mechanism to block driver A's `register!()`
generated macro from being used on driver B's MMIO. The same mechanism
could be used for relative IO registers. These are future opportunities,
and for now restrict everything to require `IoLoc<Region<SIZE>, _>`.

Suggested-by: Alexandre Courbot <acourbot@nvidia.com>
Link: https://lore.kernel.org/rust-for-linux/DHLB3RO3OSF5.2R7F27U99BKLN@nvidia.com/
Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/io.rs          | 49 +++++++++++++++++++++++++++++++---------------
 rust/kernel/io/register.rs | 21 +++++++++++---------
 2 files changed, 45 insertions(+), 25 deletions(-)

diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index fa9ae39ad9d2..38281636b4da 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -244,15 +244,16 @@ pub trait IoCapable<T> {
 /// (for primitive types like [`u32`]) and typed ones (like those generated by the [`register!`]
 /// macro).
 ///
-/// An `IoLoc<T>` carries three pieces of information:
+/// An `IoLoc<Base, T>` carries the following pieces of information:
 ///
+/// - The valid `Base` to operate on. For most registers, this should be [`Region`].
 /// - The offset to access (returned by [`IoLoc::offset`]),
 /// - The width of the access (determined by [`IoLoc::IoType`]),
 /// - The type `T` in which the raw data is returned or provided.
 ///
 /// `T` and `IoLoc::IoType` may differ: for instance, a typed register has `T` = the register type
 /// with its bitfields, and `IoType` = its backing primitive (e.g. `u32`).
-pub trait IoLoc<T> {
+pub trait IoLoc<Base: ?Sized, T> {
     /// Size ([`u8`], [`u16`], etc) of the I/O performed on the returned [`offset`](IoLoc::offset).
     type IoType: Into<T> + From<T>;
 
@@ -260,12 +261,12 @@ pub trait IoLoc<T> {
     fn offset(self) -> usize;
 }
 
-/// Implements [`IoLoc<$ty>`] for [`usize`], allowing [`usize`] to be used as a parameter of
-/// [`Io::read`] and [`Io::write`].
+/// Implements [`IoLoc<Region<SIZE>, $ty>`] for [`usize`], allowing [`usize`] to be used as a
+/// parameter of [`Io::read`] and [`Io::write`].
 macro_rules! impl_usize_ioloc {
     ($($ty:ty),*) => {
         $(
-            impl IoLoc<$ty> for usize {
+            impl<const SIZE: usize> IoLoc<Region<SIZE>, $ty> for usize {
                 type IoType = $ty;
 
                 #[inline(always)]
@@ -339,6 +340,7 @@ fn io_addr<U>(&self, offset: usize) -> Result<usize> {
     #[inline(always)]
     fn try_read8(&self, offset: usize) -> Result<u8>
     where
+        usize: IoLoc<Self::Target, u8, IoType = u8>,
         Self: IoCapable<u8>,
     {
         self.try_read(offset)
@@ -348,6 +350,7 @@ fn try_read8(&self, offset: usize) -> Result<u8>
     #[inline(always)]
     fn try_read16(&self, offset: usize) -> Result<u16>
     where
+        usize: IoLoc<Self::Target, u16, IoType = u16>,
         Self: IoCapable<u16>,
     {
         self.try_read(offset)
@@ -357,6 +360,7 @@ fn try_read16(&self, offset: usize) -> Result<u16>
     #[inline(always)]
     fn try_read32(&self, offset: usize) -> Result<u32>
     where
+        usize: IoLoc<Self::Target, u32, IoType = u32>,
         Self: IoCapable<u32>,
     {
         self.try_read(offset)
@@ -366,6 +370,7 @@ fn try_read32(&self, offset: usize) -> Result<u32>
     #[inline(always)]
     fn try_read64(&self, offset: usize) -> Result<u64>
     where
+        usize: IoLoc<Self::Target, u64, IoType = u64>,
         Self: IoCapable<u64>,
     {
         self.try_read(offset)
@@ -375,6 +380,7 @@ fn try_read64(&self, offset: usize) -> Result<u64>
     #[inline(always)]
     fn try_write8(&self, value: u8, offset: usize) -> Result
     where
+        usize: IoLoc<Self::Target, u8, IoType = u8>,
         Self: IoCapable<u8>,
     {
         self.try_write(offset, value)
@@ -384,6 +390,7 @@ fn try_write8(&self, value: u8, offset: usize) -> Result
     #[inline(always)]
     fn try_write16(&self, value: u16, offset: usize) -> Result
     where
+        usize: IoLoc<Self::Target, u16, IoType = u16>,
         Self: IoCapable<u16>,
     {
         self.try_write(offset, value)
@@ -393,6 +400,7 @@ fn try_write16(&self, value: u16, offset: usize) -> Result
     #[inline(always)]
     fn try_write32(&self, value: u32, offset: usize) -> Result
     where
+        usize: IoLoc<Self::Target, u32, IoType = u32>,
         Self: IoCapable<u32>,
     {
         self.try_write(offset, value)
@@ -402,6 +410,7 @@ fn try_write32(&self, value: u32, offset: usize) -> Result
     #[inline(always)]
     fn try_write64(&self, value: u64, offset: usize) -> Result
     where
+        usize: IoLoc<Self::Target, u64, IoType = u64>,
         Self: IoCapable<u64>,
     {
         self.try_write(offset, value)
@@ -411,6 +420,7 @@ fn try_write64(&self, value: u64, offset: usize) -> Result
     #[inline(always)]
     fn read8(&self, offset: usize) -> u8
     where
+        usize: IoLoc<Self::Target, u8, IoType = u8>,
         Self: IoCapable<u8>,
     {
         self.read(offset)
@@ -420,6 +430,7 @@ fn read8(&self, offset: usize) -> u8
     #[inline(always)]
     fn read16(&self, offset: usize) -> u16
     where
+        usize: IoLoc<Self::Target, u16, IoType = u16>,
         Self: IoCapable<u16>,
     {
         self.read(offset)
@@ -429,6 +440,7 @@ fn read16(&self, offset: usize) -> u16
     #[inline(always)]
     fn read32(&self, offset: usize) -> u32
     where
+        usize: IoLoc<Self::Target, u32, IoType = u32>,
         Self: IoCapable<u32>,
     {
         self.read(offset)
@@ -438,6 +450,7 @@ fn read32(&self, offset: usize) -> u32
     #[inline(always)]
     fn read64(&self, offset: usize) -> u64
     where
+        usize: IoLoc<Self::Target, u64, IoType = u64>,
         Self: IoCapable<u64>,
     {
         self.read(offset)
@@ -447,6 +460,7 @@ fn read64(&self, offset: usize) -> u64
     #[inline(always)]
     fn write8(&self, value: u8, offset: usize)
     where
+        usize: IoLoc<Self::Target, u8, IoType = u8>,
         Self: IoCapable<u8>,
     {
         self.write(offset, value)
@@ -456,6 +470,7 @@ fn write8(&self, value: u8, offset: usize)
     #[inline(always)]
     fn write16(&self, value: u16, offset: usize)
     where
+        usize: IoLoc<Self::Target, u16, IoType = u16>,
         Self: IoCapable<u16>,
     {
         self.write(offset, value)
@@ -465,6 +480,7 @@ fn write16(&self, value: u16, offset: usize)
     #[inline(always)]
     fn write32(&self, value: u32, offset: usize)
     where
+        usize: IoLoc<Self::Target, u32, IoType = u32>,
         Self: IoCapable<u32>,
     {
         self.write(offset, value)
@@ -474,6 +490,7 @@ fn write32(&self, value: u32, offset: usize)
     #[inline(always)]
     fn write64(&self, value: u64, offset: usize)
     where
+        usize: IoLoc<Self::Target, u64, IoType = u64>,
         Self: IoCapable<u64>,
     {
         self.write(offset, value)
@@ -504,7 +521,7 @@ fn write64(&self, value: u64, offset: usize)
     #[inline(always)]
     fn try_read<T, L>(&self, location: L) -> Result<T>
     where
-        L: IoLoc<T>,
+        L: IoLoc<Self::Target, T>,
         Self: IoCapable<L::IoType>,
     {
         let address = self.io_addr::<L::IoType>(location.offset())?;
@@ -538,7 +555,7 @@ fn try_read<T, L>(&self, location: L) -> Result<T>
     #[inline(always)]
     fn try_write<T, L>(&self, location: L, value: T) -> Result
     where
-        L: IoLoc<T>,
+        L: IoLoc<Self::Target, T>,
         Self: IoCapable<L::IoType>,
     {
         let address = self.io_addr::<L::IoType>(location.offset())?;
@@ -584,8 +601,8 @@ fn try_write<T, L>(&self, location: L, value: T) -> Result
     #[inline(always)]
     fn try_write_reg<T, L, V>(&self, value: V) -> Result
     where
-        L: IoLoc<T>,
-        V: LocatedRegister<Location = L, Value = T>,
+        L: IoLoc<Self::Target, T>,
+        V: LocatedRegister<Self::Target, Location = L, Value = T>,
         Self: IoCapable<L::IoType>,
     {
         let (location, value) = value.into_io_op();
@@ -617,7 +634,7 @@ fn try_write_reg<T, L, V>(&self, value: V) -> Result
     #[inline(always)]
     fn try_update<T, L, F>(&self, location: L, f: F) -> Result
     where
-        L: IoLoc<T>,
+        L: IoLoc<Self::Target, T>,
         Self: IoCapable<L::IoType>,
         F: FnOnce(T) -> T,
     {
@@ -656,7 +673,7 @@ fn try_update<T, L, F>(&self, location: L, f: F) -> Result
     #[inline(always)]
     fn read<T, L>(&self, location: L) -> T
     where
-        L: IoLoc<T>,
+        L: IoLoc<Self::Target, T>,
         Self: IoCapable<L::IoType>,
     {
         let address = self.io_addr_assert::<L::IoType>(location.offset());
@@ -688,7 +705,7 @@ fn read<T, L>(&self, location: L) -> T
     #[inline(always)]
     fn write<T, L>(&self, location: L, value: T)
     where
-        L: IoLoc<T>,
+        L: IoLoc<Self::Target, T>,
         Self: IoCapable<L::IoType>,
     {
         let address = self.io_addr_assert::<L::IoType>(location.offset());
@@ -731,8 +748,8 @@ fn write<T, L>(&self, location: L, value: T)
     #[inline(always)]
     fn write_reg<T, L, V>(&self, value: V)
     where
-        L: IoLoc<T>,
-        V: LocatedRegister<Location = L, Value = T>,
+        L: IoLoc<Self::Target, T>,
+        V: LocatedRegister<Self::Target, Location = L, Value = T>,
         Self: IoCapable<L::IoType>,
     {
         let (location, value) = value.into_io_op();
@@ -764,8 +781,8 @@ fn write_reg<T, L, V>(&self, value: V)
     #[inline(always)]
     fn update<T, L, F>(&self, location: L, f: F)
     where
-        L: IoLoc<T>,
-        Self: IoCapable<L::IoType> + Sized,
+        L: IoLoc<Self::Target, T>,
+        Self: IoCapable<L::IoType>,
         F: FnOnce(T) -> T,
     {
         let address = self.io_addr_assert::<L::IoType>(location.offset());
diff --git a/rust/kernel/io/register.rs b/rust/kernel/io/register.rs
index f924c7c7c1db..64fff9193a13 100644
--- a/rust/kernel/io/register.rs
+++ b/rust/kernel/io/register.rs
@@ -113,6 +113,8 @@
     io::IoLoc, //
 };
 
+use super::Region;
+
 /// Trait implemented by all registers.
 pub trait Register: Sized {
     /// Backing primitive type of the register.
@@ -129,7 +131,7 @@ pub trait FixedRegister: Register {}
 
 /// Allows `()` to be used as the `location` parameter of [`Io::write`](super::Io::write) when
 /// passing a [`FixedRegister`] value.
-impl<T> IoLoc<T> for ()
+impl<const SIZE: usize, T> IoLoc<Region<SIZE>, T> for ()
 where
     T: FixedRegister,
 {
@@ -143,7 +145,7 @@ fn offset(self) -> usize {
 
 /// A [`FixedRegister`] carries its location in its type. Thus `FixedRegister` values can be used
 /// as an [`IoLoc`].
-impl<T> IoLoc<T> for T
+impl<const SIZE: usize, T> IoLoc<Region<SIZE>, T> for T
 where
     T: FixedRegister,
 {
@@ -168,7 +170,7 @@ pub const fn new() -> Self {
     }
 }
 
-impl<T> IoLoc<T> for FixedRegisterLoc<T>
+impl<const SIZE: usize, T> IoLoc<Region<SIZE>, T> for FixedRegisterLoc<T>
 where
     T: FixedRegister,
 {
@@ -239,7 +241,8 @@ const fn offset(self) -> usize {
     }
 }
 
-impl<T, B> IoLoc<T> for RelativeRegisterLoc<T, B>
+// FIXME: Make use of `Base` type parameter of `Region` directly.
+impl<const SIZE: usize, T, B> IoLoc<Region<SIZE>, T> for RelativeRegisterLoc<T, B>
 where
     T: RelativeRegister,
     B: RegisterBase<T::BaseFamily> + ?Sized,
@@ -283,7 +286,7 @@ pub fn try_new(idx: usize) -> Option<Self> {
     }
 }
 
-impl<T> IoLoc<T> for RegisterArrayLoc<T>
+impl<const SIZE: usize, T> IoLoc<Region<SIZE>, T> for RegisterArrayLoc<T>
 where
     T: RegisterArray,
 {
@@ -370,7 +373,7 @@ pub fn try_at(self, idx: usize) -> Option<RelativeRegisterArrayLoc<T, B>> {
     }
 }
 
-impl<T, B> IoLoc<T> for RelativeRegisterArrayLoc<T, B>
+impl<const SIZE: usize, T, B> IoLoc<Region<SIZE>, T> for RelativeRegisterArrayLoc<T, B>
 where
     T: RelativeRegisterArray,
     B: RegisterBase<T::BaseFamily> + ?Sized,
@@ -387,18 +390,18 @@ fn offset(self) -> usize {
 /// which to write it.
 ///
 /// Implementors can be used with [`Io::write_reg`](super::Io::write_reg).
-pub trait LocatedRegister {
+pub trait LocatedRegister<Base: ?Sized> {
     /// Register value to write.
     type Value: Register;
     /// Full location information at which to write the value.
-    type Location: IoLoc<Self::Value>;
+    type Location: IoLoc<Base, Self::Value>;
 
     /// Consumes `self` and returns a `(location, value)` tuple describing a valid I/O write
     /// operation.
     fn into_io_op(self) -> (Self::Location, Self::Value);
 }
 
-impl<T> LocatedRegister for T
+impl<const SIZE: usize, T> LocatedRegister<Region<SIZE>> for T
 where
     T: FixedRegister,
 {

-- 
2.54.0


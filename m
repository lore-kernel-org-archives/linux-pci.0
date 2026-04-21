Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020131.outbound.protection.outlook.com [52.101.196.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1181F3D9038;
	Tue, 21 Apr 2026 14:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776783395; cv=fail; b=RPQLBwhMAZxc9jEg6kBxbyN2U0Mp2nhuP3BxiNtHKSm/3S6R9iaFBmeBJwqbF+xpN2jq7oL56qAUa8tWaGb5Yy5wnrtGH8yWIRDLleYCGV2majWp9ME8kj5rOLHXFbUNSvm6WD+/S+ZEPCy6PeQEGQPnM1M+qkMoeZGQ1OWWFf8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776783395; c=relaxed/simple;
	bh=5GVZfqmlRD7YS7IuSASRsDrAHqXip3Elc7FIgJl4J90=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=uvE+8RaZ6eI76Hr9Mzad/kFYK1OvNlwqXuKKOe7u1jxoxQ6zeZ7QVqKt0vnvh1SUViY5rydPbnc5FC4H6ETVW3uFxqFvTP1EW2bEE/gSa9ZjK9w4/lEuBGOREr5TSFzZfoMBhxcnAaYa+LirWrFHTUFhWVrFkeAckVc16tAwE6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=cm+4JCk3; arc=fail smtp.client-ip=52.101.196.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="cm+4JCk3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S1JnXNn4Zb26InXVpjl6gmdj4bUlVRvWJieswDgDL03Bp3gc61Qi/MGW/fgKc6wGd5tBwZP6tmnWCMJu+vFbL+ddc2bHrCvLG6fUCpp5VLZBbHz6qgX4VIB3PbwfiUrmw166gTRp2HoGMMzRHXTr7zXxgTpjI0HdzVNE0aNNBYfGJ0eXefJHO5jz+nBTpOEfhxdw/c2J/Pv8UQGD1FqaOAHvV90DyysydBLFmJTBJ+3MRllDu3M4D9iXaGHr0ecbJzExN3PY0MEqZdlYPALLtggKSwahLuXd0wMNlf6V+V9zNEzupvLySQ0DYNaum0tFFytfQ+TkaDyNLkbsr0F3/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gz3InflAKtslVQJSJgHeMm1kKTjdd/kLAIC9qXKn59Q=;
 b=h8BP9FqLKnS33bacO6FUK3uryFXX/cTLkv3g1myeFfRCscTURDnbH+ERuzKZc8bRxf9ngMKwLIPWWg/EyNKegN/E+AP83YQrywVJVUHijUYZiqRRLhDZiwsqkkhogJkooqyHEs9ng7f2DlDwQ9GrS4R7ldKHlpUh0F18VcTRvEoLyP7McufxP2016QEXXieNxj6lA0z1Ks499lcrzobH0FJwfEpMv5EOLn03G+PggWcj7LDmoG8PB/bJudK/hXzDc1ltAKofNyvFhohqzGNXfMCHmG2u6/B/A2nSlwkAodJ7yS0b0XlOyKe7mUTw1JkJAEZz4ENW+7hsERsrag9kwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gz3InflAKtslVQJSJgHeMm1kKTjdd/kLAIC9qXKn59Q=;
 b=cm+4JCk3ICMruZutIeOuFVyPP3lgT6qN4jJGEwjpooGYqVBbloLK0IwK1YBygtpTsJWIejCvd5/HXksoz8IL5iXDl9hoqGQFrgNh5a214o/qRNr2mdwYW3hWgKZ8bczytII6y1cbtkW0P+0dc3QmZogYxSHZUtXeAoe5JKE1AO0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWLP265MB5674.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1b0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 14:56:29 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 14:56:29 +0000
From: Gary Guo <gary@garyguo.net>
Date: Tue, 21 Apr 2026 15:56:16 +0100
Subject: [PATCH v2 05/11] rust: io: restrict untyped IO access and
 `register!` to `Region`
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-io_projection-v2-5-4c251c692ef4@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776783386; l=13259;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=5GVZfqmlRD7YS7IuSASRsDrAHqXip3Elc7FIgJl4J90=;
 b=c1qQ5DpiFXu6Q0zRPZm7320fqpB78rfHQksb0sudcivMAAKQYhzpxwNBIUibr1/TiYsVppY+p
 7AbPH/XqylgBDkvynB8TgT9tMoNc/xeftqQZz0KLpoay1KVl9dinsf4
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
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWLP265MB5674:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a6122e1-0478-49c1-b797-08de9fb62b1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|10070799003|366016|921020|22082099003|18002099003|56012099003|18096099003;
X-Microsoft-Antispam-Message-Info:
	w9F7UZYmeXl2Nk4FbIOOuMmyidCSMmgu6s8FekySQxwyaQ6ELAipScnds2x+DwaHZqXtMr/1dcOh+wujm9wZu49HsOAipnwTavvgFJoNLxpExu9FQwJeaOBOBYQsHeOR2a9Br5ig7WzBgblqAYBfkmSwxpqwEocJ6JlN2C1Jmpoh56fKWse/gaaqy1e/GU06bzY5ii4+MVTTZvi9wYNfLXY3LrVjR/T0SjfdDpoj89ee1PqxQyLUT2MON/QczapouZ1agggk0ANcFscc3A24OORaw/nC6OAzSe3w6+vbzlBtmzORo5q9a6Nar+Ffv12vMbEfUNbRFb5iGNm/eIoEtcs3R+8vdtdwbpe0f7utuz2ya7taPX3G5QdPB9W/K0kUOnMUwpCHEcQ2WjtE8W6+f9O07BvPZXEuKNLG4JKHqjZYL/+FwDedWUVai1+tFgQPqo9vk9sy5zo/tQ3M4+iPmL2MnQuNTyWPhAkx2/1vD/T8sI41AVfNtwM93csiRCEAkix43j2bk7jJJatEvgBMez+ln2CCUZSjSX8V8kabICdA5PuLHOA8LQJFrqq22suOvjOgMw6cLisllYpmoynEiJilXwgMR/+f6PXR0rjuq2R7GqNMm4Zje018TdnymwPmvEchooVfA68Z/2wjIYvrJcJlNN4AiUltn1RTsnv7DlUdaMhWAohyTnRsDAknLag52saWmzY+PkDSNyQKzd4wFROksSKIQDznzQyhQ64j90GKiH3hIjkmfDcIldEZFNRcvSQZ6iH8LND9r2clqzUueQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(10070799003)(366016)(921020)(22082099003)(18002099003)(56012099003)(18096099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZmI1ZURDdU5UUjU4ZW5ZU2h1M1ZuOEpHOUtoL1lBTUk4NlhrbFU1d0ZRTFFa?=
 =?utf-8?B?M2FodE00TWJqR3BzSUQ4ZDlPSWRZUDlhTWU5ZzhrUy9nV1ZWMHhtREl3M256?=
 =?utf-8?B?M2VHNllITjBZMjR5RDkzcEk1MnpKRElySFoycWEwV0JUVkZDNlpCRlhzYjJu?=
 =?utf-8?B?THhRM0NsNVAyMXlSRzNaWkwzL0w1eUMxNGdmVUI2aFBhUkRGcXJSQUJqekRD?=
 =?utf-8?B?dWNVNHlOMzkxbUFKZVBoREFGeVRLcGI1SHJRR2hWZlI5NGJQQU1wRnJzYUM4?=
 =?utf-8?B?UWl0NzVOZE95RWh3OHoyYXRDZW9OOWlTQ0g5eStVNWoxM1J3ekw2Zmo5NjJ3?=
 =?utf-8?B?UDh0dE9TNDF6cUVBMVpWS29temxaN1RyRFNhd1djTTFOVkd3TzlzTTVacEp2?=
 =?utf-8?B?RU5BdE1kSFFYMk1UNS80RThsODlPNnZ4SldPNVZZQUd4QUpqMDNKQi9NYmVC?=
 =?utf-8?B?NDRwZCtJd1BZbnhld25tK2RWNC9mdTNCRnlDMnB1bHF1Yll4cDZobHBDMXB0?=
 =?utf-8?B?TkJVSFlScUE3SjFra3haR2FvN291M1IyRFZJQ0luclU4UmZxWkRCRTRIREhW?=
 =?utf-8?B?N05NZTZIbWdUU0R4c0VQa2RRQjIyd2x6STBQQitFVEZtNGt0a3VaUDJ4UXNX?=
 =?utf-8?B?dEY5Q0FIQmY4WmFyTHJOM0tSSFVpWFFJMGNHNWtUckloQjF5N05YazhRWlNO?=
 =?utf-8?B?Z1NSVVJPL3JIbmdaY2NpblNNa0FjSHR1M3dXaU56YWpiZEdhTmNYY205eGpa?=
 =?utf-8?B?QlFidzNFU3JBODlBc0ZIK2Frd1ZBVEk1VEZqTzBLT1U0dWtNQ2VuQVI5dHlE?=
 =?utf-8?B?cm15NEEyc0FnL3ZSWXMyeFdoekgrUzJBMkwxQ01JWHk1U0JwNWpFMFZxNTVN?=
 =?utf-8?B?RUVrQ0FzS3hFSkY3SmxQS2RNOWhuclIvWDVrQlpQTmI2cTBNNFdlSTNYVnAr?=
 =?utf-8?B?ODgwN2hqdkdqbXV6K1A1YzhBQXlVK0tNUjR3YTdld1RZdDVTeVFsUkRMWjVR?=
 =?utf-8?B?VDd6a3VxUFBCVXFibWoxcDRvOTJLdVdyTGR6K2l4aGRaQTZBMkd4M1hkM0Ev?=
 =?utf-8?B?OWw3NEd3Z2lXV004RWxLYlhGR2RWV3VHZDRXNmZOMFNpQytjK1c1cUcyRXVr?=
 =?utf-8?B?N2tubFBMTDBoWmJDTFdZMzFuMlZNYzRyRXpFQ3JOVG4vLzBFVVZNTk5SQnJG?=
 =?utf-8?B?YUcvbGZkRGJvc2FtczZNSjNoejRnSDhBNGlWc1Q2UFpTUFBvYlIwYk54WlZl?=
 =?utf-8?B?SW1NUTVMeUNER1IyNzB1SUoyZjU1VHBBMXNLcjZiUStwTWdHTFFhUFJJam5J?=
 =?utf-8?B?QWJaT0ZHOUlhV29hU2x6bUxBbjNHYlM5QytSMFlVMVY0QSsxWVV2d3RYTVl6?=
 =?utf-8?B?bzVuUXQyV25naVVNclYwZVNQRmRNTGtjazIrRGplVldwSXRkMHR0MGNvYkho?=
 =?utf-8?B?QkNGd0V0MTk4Q3NrVUJHYTRiSDlmTHhxK2RzdzBveEdkenBjblo5bHpNWTNW?=
 =?utf-8?B?TTF3YnFRN2FXcHlnUWpJTGtlQnMrc3NhbnRjWVlsRXFNTTVEUWR0MmxvNHZB?=
 =?utf-8?B?dUJZWWUrRjhtcyt2QmFjbm91cHlCMWh0T3Z3d0hDQjN1MVpjQVRBSC96RVdy?=
 =?utf-8?B?WGI0M3VENFJldW4wZVB2RkdjdURWSndmd1h5cE0vZmVHZHlmTGoxM0lIdG1N?=
 =?utf-8?B?QWlQOXhmcVowMmNpUUorcmwwUnFmSUZidW1iVzREU3BnV05tSzVRZmJMWHVE?=
 =?utf-8?B?T2FwcDRKZDAzb2x0N2ttUHdFeCtnOVNDMDIwZ1hNMjZpUFJaN1VDRlk3TEVa?=
 =?utf-8?B?OVdYMGJ0SWNtcXVZNDNpc2VxOTRiVVhyVlI4N2pmVDZVd3dkOFh4bVlsQXZI?=
 =?utf-8?B?TjlIUE52aDZUTWo3RTBwS2hqYlhSNlVrdWdoNzBoZEtiUENBdVVndGFsYm4v?=
 =?utf-8?B?Qk4wTk4zazFKeS9Ka3dSa2x5bUQyMVptV1A4b1ZPZ25qdlhVWmQzV29FZVYy?=
 =?utf-8?B?cFQ1WUtMaXZnVHpKdW5uVFNCK0F1OStadEFvQUwxeVVQdUNTTFcxcjc2YmV6?=
 =?utf-8?B?cTVrMmNlMFJxcjA1cXN1RktSZ1Q0c2dsU3NIUmxxNG8rcXowOTRwa25uZ1Na?=
 =?utf-8?B?K2Y4MkdUcjRwRVoycFdjWkpLemRoeFcwV2ptcDB4Vzd2NmVmUlhKQUhreHph?=
 =?utf-8?B?N05NODYxOUtIWFMvTEZ3ZFZPK01MNnErN2RZYXdmbTZGL29tZHVZS0NBR2Va?=
 =?utf-8?B?SGVOWkh1a2JVQnE0K1VnbGVyZHhWcGt5d2NzMVFwZ0ZyT3NVVHhVQXIwRWF5?=
 =?utf-8?B?TVQzYmNDWGdlcGxQQ04zclFEMTBMaEJMTnpHekxtTWJNNVl1ODE4UT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a6122e1-0478-49c1-b797-08de9fb62b1e
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 14:56:29.0683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6vlJU61SMvVn1TYtMLIxUaMkpVCJ4xodcqxXU3/UsitaErlu79WNV+uwfUMdnb8hZTwGpTeq5urd7eoD2N4Xwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB5674

Currently the `Io` trait exposes a bunch of untyped IO accesses, but if the
`Io` region itself is typed, then it might be weird to have

    let io: Mmio<u32> = /* ... */;
    io.read8(1);

while not unsound, it is surely strange. Thus, restrict the untyped methods
and also the register macro to `Region` type only.

The way it is implemented is by adding a generic type to `IoLoc`. This also
paves the way to add typed register blocks in the future; for example, we
could use this mechanism to block driver A's `register!()` generated macro
from being used on driver B's MMIO. The same mechanism could be used for
relative IO registers. These are future opoortunities, and for this patch I
just restricted everything to require `IoLoc<Region<SIZE>, _>`.

Suggested-by: Alexandre Courbot <acourbot@nvidia.com>
Link: https://lore.kernel.org/rust-for-linux/DHLB3RO3OSF5.2R7F27U99BKLN@nvidia.com/
Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/io.rs          | 47 +++++++++++++++++++++++++++++++---------------
 rust/kernel/io/register.rs | 21 ++++++++++++---------
 2 files changed, 44 insertions(+), 24 deletions(-)

diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index c6d30c5b4e10..a13be8c5fd2d 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -238,15 +238,16 @@ pub trait IoCapable<T> {
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
 
@@ -254,12 +255,12 @@ pub trait IoLoc<T> {
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
@@ -328,6 +329,7 @@ fn io_addr<U>(&self, offset: usize) -> Result<*mut U> {
     #[inline(always)]
     fn try_read8(&self, offset: usize) -> Result<u8>
     where
+        usize: IoLoc<Self::Type, u8, IoType = u8>,
         Self: IoCapable<u8>,
     {
         self.try_read(offset)
@@ -337,6 +339,7 @@ fn try_read8(&self, offset: usize) -> Result<u8>
     #[inline(always)]
     fn try_read16(&self, offset: usize) -> Result<u16>
     where
+        usize: IoLoc<Self::Type, u16, IoType = u16>,
         Self: IoCapable<u16>,
     {
         self.try_read(offset)
@@ -346,6 +349,7 @@ fn try_read16(&self, offset: usize) -> Result<u16>
     #[inline(always)]
     fn try_read32(&self, offset: usize) -> Result<u32>
     where
+        usize: IoLoc<Self::Type, u32, IoType = u32>,
         Self: IoCapable<u32>,
     {
         self.try_read(offset)
@@ -355,6 +359,7 @@ fn try_read32(&self, offset: usize) -> Result<u32>
     #[inline(always)]
     fn try_read64(&self, offset: usize) -> Result<u64>
     where
+        usize: IoLoc<Self::Type, u64, IoType = u64>,
         Self: IoCapable<u64>,
     {
         self.try_read(offset)
@@ -364,6 +369,7 @@ fn try_read64(&self, offset: usize) -> Result<u64>
     #[inline(always)]
     fn try_write8(&self, value: u8, offset: usize) -> Result
     where
+        usize: IoLoc<Self::Type, u8, IoType = u8>,
         Self: IoCapable<u8>,
     {
         self.try_write(offset, value)
@@ -373,6 +379,7 @@ fn try_write8(&self, value: u8, offset: usize) -> Result
     #[inline(always)]
     fn try_write16(&self, value: u16, offset: usize) -> Result
     where
+        usize: IoLoc<Self::Type, u16, IoType = u16>,
         Self: IoCapable<u16>,
     {
         self.try_write(offset, value)
@@ -382,6 +389,7 @@ fn try_write16(&self, value: u16, offset: usize) -> Result
     #[inline(always)]
     fn try_write32(&self, value: u32, offset: usize) -> Result
     where
+        usize: IoLoc<Self::Type, u32, IoType = u32>,
         Self: IoCapable<u32>,
     {
         self.try_write(offset, value)
@@ -391,6 +399,7 @@ fn try_write32(&self, value: u32, offset: usize) -> Result
     #[inline(always)]
     fn try_write64(&self, value: u64, offset: usize) -> Result
     where
+        usize: IoLoc<Self::Type, u64, IoType = u64>,
         Self: IoCapable<u64>,
     {
         self.try_write(offset, value)
@@ -400,6 +409,7 @@ fn try_write64(&self, value: u64, offset: usize) -> Result
     #[inline(always)]
     fn read8(&self, offset: usize) -> u8
     where
+        usize: IoLoc<Self::Type, u8, IoType = u8>,
         Self: IoCapable<u8>,
     {
         self.read(offset)
@@ -409,6 +419,7 @@ fn read8(&self, offset: usize) -> u8
     #[inline(always)]
     fn read16(&self, offset: usize) -> u16
     where
+        usize: IoLoc<Self::Type, u16, IoType = u16>,
         Self: IoCapable<u16>,
     {
         self.read(offset)
@@ -418,6 +429,7 @@ fn read16(&self, offset: usize) -> u16
     #[inline(always)]
     fn read32(&self, offset: usize) -> u32
     where
+        usize: IoLoc<Self::Type, u32, IoType = u32>,
         Self: IoCapable<u32>,
     {
         self.read(offset)
@@ -427,6 +439,7 @@ fn read32(&self, offset: usize) -> u32
     #[inline(always)]
     fn read64(&self, offset: usize) -> u64
     where
+        usize: IoLoc<Self::Type, u64, IoType = u64>,
         Self: IoCapable<u64>,
     {
         self.read(offset)
@@ -436,6 +449,7 @@ fn read64(&self, offset: usize) -> u64
     #[inline(always)]
     fn write8(&self, value: u8, offset: usize)
     where
+        usize: IoLoc<Self::Type, u8, IoType = u8>,
         Self: IoCapable<u8>,
     {
         self.write(offset, value)
@@ -445,6 +459,7 @@ fn write8(&self, value: u8, offset: usize)
     #[inline(always)]
     fn write16(&self, value: u16, offset: usize)
     where
+        usize: IoLoc<Self::Type, u16, IoType = u16>,
         Self: IoCapable<u16>,
     {
         self.write(offset, value)
@@ -454,6 +469,7 @@ fn write16(&self, value: u16, offset: usize)
     #[inline(always)]
     fn write32(&self, value: u32, offset: usize)
     where
+        usize: IoLoc<Self::Type, u32, IoType = u32>,
         Self: IoCapable<u32>,
     {
         self.write(offset, value)
@@ -463,6 +479,7 @@ fn write32(&self, value: u32, offset: usize)
     #[inline(always)]
     fn write64(&self, value: u64, offset: usize)
     where
+        usize: IoLoc<Self::Type, u64, IoType = u64>,
         Self: IoCapable<u64>,
     {
         self.write(offset, value)
@@ -494,7 +511,7 @@ fn write64(&self, value: u64, offset: usize)
     #[inline(always)]
     fn try_read<T, L>(&self, location: L) -> Result<T>
     where
-        L: IoLoc<T>,
+        L: IoLoc<Self::Type, T>,
         Self: IoCapable<L::IoType>,
     {
         let address = self.io_addr::<L::IoType>(location.offset())?;
@@ -529,7 +546,7 @@ fn try_read<T, L>(&self, location: L) -> Result<T>
     #[inline(always)]
     fn try_write<T, L>(&self, location: L, value: T) -> Result
     where
-        L: IoLoc<T>,
+        L: IoLoc<Self::Type, T>,
         Self: IoCapable<L::IoType>,
     {
         let address = self.io_addr::<L::IoType>(location.offset())?;
@@ -576,8 +593,8 @@ fn try_write<T, L>(&self, location: L, value: T) -> Result
     #[inline(always)]
     fn try_write_reg<T, L, V>(&self, value: V) -> Result
     where
-        L: IoLoc<T>,
-        V: LocatedRegister<Location = L, Value = T>,
+        L: IoLoc<Self::Type, T>,
+        V: LocatedRegister<Self::Type, Location = L, Value = T>,
         Self: IoCapable<L::IoType>,
     {
         let (location, value) = value.into_io_op();
@@ -610,7 +627,7 @@ fn try_write_reg<T, L, V>(&self, value: V) -> Result
     #[inline(always)]
     fn try_update<T, L, F>(&self, location: L, f: F) -> Result
     where
-        L: IoLoc<T>,
+        L: IoLoc<Self::Type, T>,
         Self: IoCapable<L::IoType>,
         F: FnOnce(T) -> T,
     {
@@ -650,7 +667,7 @@ fn try_update<T, L, F>(&self, location: L, f: F) -> Result
     #[inline(always)]
     fn read<T, L>(&self, location: L) -> T
     where
-        L: IoLoc<T>,
+        L: IoLoc<Self::Type, T>,
         Self: IoCapable<L::IoType>,
     {
         let address = self.io_addr_assert::<L::IoType>(location.offset());
@@ -683,7 +700,7 @@ fn read<T, L>(&self, location: L) -> T
     #[inline(always)]
     fn write<T, L>(&self, location: L, value: T)
     where
-        L: IoLoc<T>,
+        L: IoLoc<Self::Type, T>,
         Self: IoCapable<L::IoType>,
     {
         let address = self.io_addr_assert::<L::IoType>(location.offset());
@@ -727,8 +744,8 @@ fn write<T, L>(&self, location: L, value: T)
     #[inline(always)]
     fn write_reg<T, L, V>(&self, value: V)
     where
-        L: IoLoc<T>,
-        V: LocatedRegister<Location = L, Value = T>,
+        L: IoLoc<Self::Type, T>,
+        V: LocatedRegister<Self::Type, Location = L, Value = T>,
         Self: IoCapable<L::IoType>,
     {
         let (location, value) = value.into_io_op();
@@ -761,7 +778,7 @@ fn write_reg<T, L, V>(&self, value: V)
     #[inline(always)]
     fn update<T, L, F>(&self, location: L, f: F)
     where
-        L: IoLoc<T>,
+        L: IoLoc<Self::Type, T>,
         Self: IoCapable<L::IoType>,
         F: FnOnce(T) -> T,
     {
diff --git a/rust/kernel/io/register.rs b/rust/kernel/io/register.rs
index 1a407fc35edc..5a7d44c51477 100644
--- a/rust/kernel/io/register.rs
+++ b/rust/kernel/io/register.rs
@@ -113,6 +113,8 @@
 
 use kernel::build_assert;
 
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
2.51.2


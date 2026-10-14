Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013031.outbound.protection.outlook.com [40.107.201.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A752A379C3F;
	Wed, 14 Oct 2026 15:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791991003; cv=fail; b=U2INbpT966c3Pw/j2NkYdCec9knI54ncTrP3fUAtj7TNiTfyyou2AYcUCLtmY3OUqEeUl+LNwutp2fMVCVTCnBn1WuSduyzDz5+3ULK17caEYviV8G8kNW7R326e2ycjPkVvccbGs11uA9QxwF1LDKyqR3b5hXpPzm751hPkMvM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791991003; c=relaxed/simple;
	bh=eRZSsxauA1tFsDlyKpLrBjpXwvMs72ALvEDOK13F5QU=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=ZXgWNT/cVUgOUnz6dIn9urux2+0/UM/hZwHjojSMbn58zsNuKqrkIfplHUoYR7hwUYJxSBfewhkPftFY8bXJ3GoRQ1Jfk+VXN5wP/u8vJugWIme0ppiAQdwP7/lDzzB8wNp1wLDVIJ0o9yNbFCWgKHHL8airBKZToHxPcnhMNSs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Dc09jPPV; arc=fail smtp.client-ip=40.107.201.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Dc09jPPV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hNlqCcTKMFpLUX2WTAARmkTssAYLooitCmrPkGk9Wu7GHNidLcSirYyMbJfxAQy9kZNeArcHgll/V43/dFUlUZH7WOdGrejsm14hdKtJVph1ZW122DpMExt4jlgi1J4gPQh/9gRALwg+hYyreJz/owoVdyyKo6F2yBUGPaKILeANgbjs6CpaGW335eCjHfF2vxO+zxZpYQN3TSCodKB8D0c6K2nq+Fr8eojtkIzXaKQ/tE1MgiSXDTvFwjukeg0jtN2e2s1hHnA5IYyb4ozM+CpCkWTDYpmhpTqI2QYPTBjrBczePFvfrP0MQjSRcQsiIQoxoMTY4MZesUidPmeyug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NbRjVKEBQ6r3ZgtWeTBrzBdwJ3582j3W4in0BRArX/M=;
 b=aJ920fbN2aSB3wZZSafCMMIxxoPtL9El4ggT6/OnY2fl5sU+05Uq2ygnfd7ONthMet7ScRd/obrsVUbdIWIs9DFv7zKX7yHGOX89fCIC4XqbKEYMQwXABb+1Ok+5BAlqtYLVwXkqKbBJhfUoqpkcU0UCVlkFszY1DI7noHSqAcKswUbcz1YNzjOHe1c7uEX4buvIwoidvk3AVcuV5P+Bk1fWX58gBvoO3XXMStMZee6Mz7GpyHu5ygf9nZRPA/2dwQwbtW9weV0u8mogxg5mWYiRlmTD3nubenpJmNDNYoYcU1rCoaCFF+oEjw3UqeSMaBrhWk7nQVFN5EzhuMnFHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NbRjVKEBQ6r3ZgtWeTBrzBdwJ3582j3W4in0BRArX/M=;
 b=Dc09jPPVhW56mfC1Em1D0h21clWG/BK94/IOyytCfVCd42CtMBDY0djY4CTS/ESwSIz8l+AgO8B1oypY0c4zFFP4NJvDJWF1E1ueKA+Mu7IJkAbpQ3eE40QXBELnfGbEni/Lw96Io/j5TC4R5i7e71ZvdDNo/qiuaNR9K+0CUfqCRm5txXq2cJ3W5xx699unO046VC1ZTZnu9ZDta0OhxGu6BzPVVWE/IO1BUExZnLkE3rrPzS4fI3uJsTPiWegMPctks6EZUUNBDExGwZBzweeMMEfE6v9vDjNia8LkhiXJEr2SQETIGwuKS2paVKK+8jCKyHYTcUxu3lyYBy9e6A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by PH7PR12MB5880.namprd12.prod.outlook.com (2603:10b6:510:1d8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Wed, 14 Oct
 2026 15:16:35 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0522.011; Wed, 14 Oct 2026
 15:16:35 +0000
Content-Type: text/plain; charset=UTF-8
Date: Thu, 15 Oct 2026 00:16:33 +0900
Message-Id: <DM4NSHDSYI0V.23GB4GJJ2PCOO@nvidia.com>
Cc: <lukas@wunner.de>, <linux-cxl@vger.kernel.org>,
 <akpm@linux-foundation.org>, <Jonathan.Cameron@huawei.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <jic23@kernel.org>, <bhelgaas@google.com>, <alistair@alistair23.me>,
 <djbw@kernel.org>, <linux-pci@vger.kernel.org>, <wilfred.mallawa@wdc.com>,
 <a.hindborg@kernel.org>, <gregkh@linuxfoundation.org>,
 <alex.gaynor@gmail.com>, <aliceryhl@google.com>, <benno.lossin@proton.me>,
 <boqun.feng@gmail.com>, <bjorn3_gh@protonmail.com>, <tmgross@umich.edu>,
 <gary@garyguo.net>, <ojeda@kernel.org>, "Alistair Francis"
 <alistair.francis@wdc.com>
Subject: Re: [PATCH v4 02/22] rust: transmute: add `cast_slice[_mut]`
 functions
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: <alistair23@gmail.com>
Content-Transfer-Encoding: quoted-printable
References: <20260928011123.450800-1-alistair.francis@wdc.com>
 <20260928011123.450800-3-alistair.francis@wdc.com>
In-Reply-To: <20260928011123.450800-3-alistair.francis@wdc.com>
X-ClientProxiedBy: TYCP286CA0285.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c9::20) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|PH7PR12MB5880:EE_
X-MS-Office365-Filtering-Correlation-Id: c6460676-2f2b-472f-b388-08df2a0622e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|10070799003|23010399003|6133799003|10067099003|22082099003|18002099003|4143699003|11063799006|261009223027099003|56012099006|5023799004;
X-Microsoft-Antispam-Message-Info:
	2SJzC4JjaoUsF52HmjhLg3ApQlz14rOucuImUqW38EsLgZIbnkKTLAqpPT6qLbxEsJx/BZYfae4wrSQnQ5SaBWusqr5H/sgfPI9hsZvzAeY1RZCTih+WyfNjf9jUxWjePpf//631jJNFzqqHj9nBFVZq500cJH7VzLUbcElnZPXAgrOP4zDbKIKmZD7QbF3o9baKWtVzINMjrgySORxqFcVNXfkq3hE5T1t749sugZ53mU8eKbWjcfC12+jUwZiGbo83UKtMPMX8Vi197qSrFg5OOeRtFo7VCzm2lyJ98PxkziBEI1063z13xT0fcv+fuECzljoEJMmvdTj2P3jdHZtahWLy+kr7Za14pJJ57jVrOmTKm26rG/iPOIku+5z3BHT9SkQsEG5eMRSqFC+XV1uAaR3mh0vaY5xCF4ZM1iKLoo6I9A6Y6ycpeq81Dz9bfnStcWhfB/52WvkJncDpLduCqnCwe+qMIP04C56CVkamCOyxJq5oblY8/TZz8QHUs8xpNWVwwRgX7N8SdN5Zyxlm2v1+ZCDgj/4w4tnTlrsTZsdesIW3SjFYgnQBD5mntdFFRX9RTTMOyROVuykz4kCWtQLGNlFs7x5upF8cPxij4TpBkEVYZMFav9GVcD8WXyGHW6jVrn9LYwhrp2QcmWDg76aArt4yaFze8wvM3DY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB6873.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(10070799003)(23010399003)(6133799003)(10067099003)(22082099003)(18002099003)(4143699003)(11063799006)(261009223027099003)(56012099006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UEZHM0xDMHh5a0J2UXJiajhnT1QxUFA2Y1RMNVp0Rkg2YmtFNzlBcXM1U1I5?=
 =?utf-8?B?QkZia0t2L3h4M3ROU3c4WVFxRXMzUGlpWkVORFdNZDVrOFdVSEVWQUF3eE80?=
 =?utf-8?B?aUJHb0p6UkJpVzFxVVFsUHZRRnpoN0NCeWlTL0F5blkyVmJIT0gvTTR3OUk5?=
 =?utf-8?B?c0QyazgzMFk5RnhRczNYQ0hPRHhSU2FNaGFSZENJYjdmYXBaRG1jdXFSSHk5?=
 =?utf-8?B?UGdtQjhoWDBFSUxxZWZ5c0tGb3VzVHl2YVJJNUMvRjdXRXd3WUY4Z0p0YzFi?=
 =?utf-8?B?WlN0T3VUYngvZXdMUmVzV0dvRWZGS1ZJMEJDbXJpT3QrVjR6WTJsaURVTjVQ?=
 =?utf-8?B?TWhnUW1FUi91cWVqbE9nWkpZYXJrQURiVDNxQ3pBRzY5RlZhVUFuQ3FKSmpy?=
 =?utf-8?B?Rm1obXBudFRkbEozNGlrT2d2UWcycitCR0JnZ1hzQ1JEaVRieGJqREswL3Fk?=
 =?utf-8?B?WlBPQitrM2Nkc1R6WGdldUpDSWJpVGpteVk4a0YyRUNPaEhVcXA0TmovWXEz?=
 =?utf-8?B?S1l5dGpzUmdaaDluc1FNWHdpZU9VTEhJK1N5MUs2RmZEV2UvT2ZSRmhteU9w?=
 =?utf-8?B?R2p3eHhVWmV6TFlJR3BZUjNPbGcwZzdWOElCWEVWS1BWaDJJcXR3Qjc2RmdW?=
 =?utf-8?B?b2p3ZGZHMUFVS2tYcU9WYVh2bmtqQjBmWExzZzJtSEFqamgySkVaWU5QTjZG?=
 =?utf-8?B?RnpmZThGdzdoNXZyMUk5VU5YNjE4L0IxUVJncFdKQzI0TlcxMUJtalNPc1Rt?=
 =?utf-8?B?RFk3Y3ZBTUkwQ0ZMY2pFZ01tWjZTMjkxV3ViNzd1QU5OemFtamIwenUyVlFQ?=
 =?utf-8?B?K0JuaGpZQ3pZVUZFT2pja0RQNzY2VFFmTEhKdk8zL082RG5qRmJjb3BpSWlC?=
 =?utf-8?B?a2RsU3Z4RUpnbzV2QkZ1T0hXbzR2Ujhic3hhd2d1Z1Exem5tVGZqb2V5N2hB?=
 =?utf-8?B?WU1VN256VDFsZXptYWRENm5NWmVScS8wLzM4c3NjVytuTW50SVBNSThUNlZC?=
 =?utf-8?B?MXZXQlRWY21wTUlEYllnWnliYXFhdURBTVRUUElkQkplRGUzOGdtWWh3eEpO?=
 =?utf-8?B?VmtYQ3dua1lZNllwWWpMNVNIYTgwazd5MVVCdytuUlhtTUlMNHc4U3d5Uzk0?=
 =?utf-8?B?VnRFOHN4eit0K1pqbVJnbFpqNHVVdjQxUFhnaC9FZVlueU5rajY1dTVNbHRC?=
 =?utf-8?B?SnIrK1JKOWQwMGpnZU9yUEZ3QVArQlNXeHBpQjJhZWtFT1JCSnZhdlA5RjZ3?=
 =?utf-8?B?MGZvTkxLM2ZJYWZUaWdjTytscHVNYW5MWGVGcEx3M3FaS25FeFQ3VTFEQWdw?=
 =?utf-8?B?dFEvOFFsWkVmSEs3d0lVM1NwZVA4czdrVWpGSHo5VThwblpZQXBJZUNGVGFQ?=
 =?utf-8?B?MDVlajh5YmN0amFDQTB1VWk3TzBxenpnRmhVYmlMalZxK1RsWkhNQVpZRHNX?=
 =?utf-8?B?UGNPaHJZaEZjSjRpbHNqTE5kTWdlUEhxZjlONTgyR0JQZWdCaHpQcXVEeWxF?=
 =?utf-8?B?eHFLWmxqcGRoYUVrdHFmZzR5NS9ib05VZEROVmJ2L3VldTIxVnFrMWlmcUFP?=
 =?utf-8?B?WEpiSXRXMzhFOC9OTnFaMVZ6T3hWSk1TdXk5QUwxTFJPRElDVkpzUzV5d0dU?=
 =?utf-8?B?U3A2R0poMHR6dkVPenhUaklPYlh1WEZGSVcvMkJERDhtYkhYUnBidG1EcWZC?=
 =?utf-8?B?NS9Ud2t4WUR1NjczZlNoUXJjS3dqalhGT21YQjIyTXYwdmV0bHk2QXlmRzhE?=
 =?utf-8?B?MDhOY3VMT1k5aks0cTBjNFA3NW5Qb2hQZlhGaVVzYUFjeDI0d0p6dzVZYjJt?=
 =?utf-8?B?SGRvakxmcnR6UGFRRWdLYXpkZkU2Y0hhMjJYRkZ5MUhDZGdFekR4ZFZFTXB2?=
 =?utf-8?B?V0hKR09Xa2swNXFtc3ZYZHV1VmpkYjFGOWdLam1adW5COE5QT2JaSlRzWHNB?=
 =?utf-8?B?Rm5ON1ZjQnFDNExnckdTS3NxSm04bCs5bXpyNWRveHFkMm9uWDNFekVhY1Na?=
 =?utf-8?B?Nm96Q2loQ01DcWJBdnZjN1c2a2VDdVpNbHo4WnQxNFFaTFFFOWlVeG1kUTFj?=
 =?utf-8?B?SS9ReGI3THpWVEFwWVVHVnFWRm4zaW5uRWx1ZzR0V01SNWVrWmxNdEY0M2Ex?=
 =?utf-8?B?Y2tmbXI5ejVmRXRpMENHVGtyZHZsbVB3blNQdW1Da290cEVwM3RvZEJKT1F5?=
 =?utf-8?B?NWU0aWhibjk2Wml5ZVVybHpQeGh5RjNUbkp5Z3huM2R4ZlFIalB0a2dKTE1y?=
 =?utf-8?B?eWtqWU5oaFhSTTJpMWVMajZxT3pGbFdQN3A2NnpWRERYMDFwcStCWm96aVdY?=
 =?utf-8?B?a0pJc1Y3TjBKcmxQNzVad0htbFBWSi9GY0RWQmFBK2lyZXBrNUE3K0p4enpW?=
 =?utf-8?Q?XpWF8JCjpkrCcd2oGeJ3B7jbjb+c/n8/6vHC8wE7pPAA0?=
X-MS-Exchange-AntiSpam-MessageData-1: zRILEN8WeDDPFA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6460676-2f2b-472f-b388-08df2a0622e4
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 15:16:35.4683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +aFncYuxp4oiSeo9a4AWXKgW3KeillvnnKc1/6L8v0hyYOn2s/w2m/jJLVyKmYaG+PlP75eSkVeLlI1B3sQjLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5880

On Mon Sep 28, 2026 at 10:11 AM JST, alistair23 wrote:
> From: Benno Lossin <benno.lossin@proton.me>
>
> Add functions to make casting slices only one `unsafe` block.
>
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
> Message-ID: <20250814124424.516191-2-lossin@kernel.org>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  rust/kernel/transmute.rs | 71 +++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 70 insertions(+), 1 deletion(-)

`transmute.rs` has been made obsolete by the introduction of `zerocopy`,
so I dont think the timing is right to extend it, especially since the
new methods allow to basically cast any slice into any other without
any constraint. Thankfully I don't think we need this at all: the only
users for these new methods are the `Deref` implementations in patch 3,
and I believe these can be implemented better (I'll comment there).

So basically I think this patch can be dropped entirely.

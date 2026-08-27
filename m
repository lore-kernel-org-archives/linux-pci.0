Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011043.outbound.protection.outlook.com [40.93.194.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6582C0F6C;
	Thu, 27 Aug 2026 07:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787815042; cv=fail; b=GeqDJs5KqeP35wQAKcwj2kngmOzyeO7ZrIGYGF7J4bdB+e3pXMuo+f+P+1L7mPxY1BNACWjKUhpmKkCZqbfW4IWOiOo9lR7UC5k2CtCjDv+GIoIJYLS6rCncBCeJKSoPzCx2HT3xWcx4u5MERfyMvdg7lCbtQtd9IjS1Am+MpEo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787815042; c=relaxed/simple;
	bh=WtTTIGcbRUvcxnSJuy3anSjWNYpY5itNWffDRNJvUj0=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:References:
	 In-Reply-To:MIME-Version; b=nUhNMDRBb/QoK1HAUehl5TmGxApx23bJHkSXp1ygvep/nNLxamSTLQxckWyplV3Sp1PXU+Sf6PJjy2ajQgaxU8ZpeM9RTX/05vZpaPeTo73k/1dtjFMsW69Vhq4LacIh0WL8qYZf8+zK+R0SWSmx8rB1YBPpprpTWrKEFu2Ju0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=czH0Hxxk; arc=fail smtp.client-ip=40.93.194.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="czH0Hxxk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZB51Pk1EzwLdsAtTi8tyH6YFngmump+WA88EOGCL7xIwH86kX2rzfvyaiIVsS4aGJ6tEpuI6GGLTyZuyI5v+tUZPfYXuRBdHJmSj5e+B6x0/fE3oOjDff1XYFWG0VegVd6B/lhux4uEnLb6GC9RcPlRJfAz82eRnD/dt9ZFjYNGJY2hDk2Q8FEorYydys6js2EdSjn4Ra++6vxEc/vvEYPVEOjsCol1mGVKAxj3N0cPfvmeZRNf55esTHoq/PlfaE0VzAvx2zE5K+GmnDsbKFemVidiyQojftsJki9CYR2b79WL9cL8CSXPsKBpKSAxZMEk47l2p4GkHNkXaWQWnlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tHp3HF1fckwqvw7XIZQN/pMQrtdM8efsYXf0ZUyc0JI=;
 b=LMZaViELZWezhqezP2h6FNttxigAPJhxQuTSADQade6qIoqR/kce5QrN6rKJAZg5SJmR2v+nENs11bKElFJIqWWNoSgXEi5MB8uYQH9BHJbU19MOZqGhl3W6A/q6I8L0vChK7/qbxw4Cxat+Zv9hnblrpIjuLdUZiMPo+Ei2D/x1fYH3wy22kw/GEX0zOZIHarZ1VEs3U/c6eYYY1nNCi4Exx3CgdEHBJvJGXEquc9PmfHYYzV9w1EBJhNBcG2TWalCYK6n1VQXtYNyZ301071qMQzrHS2O+dL7x/n5QdSdPWuPYL+qG1TSb5F1k5x97okJYW5J+cwXZoiHnFuI2qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tHp3HF1fckwqvw7XIZQN/pMQrtdM8efsYXf0ZUyc0JI=;
 b=czH0HxxkLG+Nr4g8DzQaPc0m4W6oYyz4OkJ00fP5eT30tNZs0cUIG1WWiVTm7D0Em6AJ/zJLO0eTNA0S/Ywd05gKLLvjBwlUzMhqZS/rLWZmtvDHmaCTk8pEOvhIeIu/7/TGMPJ7iLMADBL5WzUiH5/87Rpv5ILhnQv383ArSHY/BQBxWjp80EN6rQ5m2CkGY6hYuQvObglxpSGusM7AFQV0IUu5XaQ/whKKT1yI7Z4F0bZ+A+c1SKETmXfiYii4azTO9dLATvpUzQNyZRFQjkb7hFlW80KjYTqJyGZc9xBambDWrcA8bz29IdHJ145/6sR5A4Gsa56dmMOrw2MMcw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by BY5PR12MB4324.namprd12.prod.outlook.com (2603:10b6:a03:209::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Thu, 27 Aug
 2026 07:17:15 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0315.014; Thu, 27 Aug 2026
 07:17:15 +0000
Content-Type: text/plain; charset=UTF-8
Date: Thu, 27 Aug 2026 16:17:12 +0900
Message-Id: <DKZJJBS1UJVH.1HXS6MF69RT6R@nvidia.com>
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "Daniel Almeida" <daniel.almeida@collabora.com>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Tamir Duberstein" <tamird@kernel.org>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Bjorn Helgaas"
 <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, <driver-core@lists.linux.dev>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v3 06/16] rust: io: register: allow explicit base type
 specification
Content-Transfer-Encoding: quoted-printable
References: <20260819-typed_register-v3-0-3699a75fadf1@garyguo.net>
 <20260819-typed_register-v3-6-3699a75fadf1@garyguo.net>
In-Reply-To: <20260819-typed_register-v3-6-3699a75fadf1@garyguo.net>
X-ClientProxiedBy: TYCP286CA0363.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:79::10) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|BY5PR12MB4324:EE_
X-MS-Office365-Filtering-Correlation-Id: db286559-0311-41b4-c8fe-08df040b38f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|10070799003|7416014|376014|23010399003|6133799003|10067099003|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	IXybtYFN1bkoR85VQuYvVSgpvQrMNsUHyMYHJNCz4iDABuszIxyuDih2vPuA1P1mZF6iMfLCUpbsYEVo5qIOqyk3TbKf2v0TrIGaOYAMQaRlchF6JHvop5xwti2u3+bfMw9RIIoaQtIfDYEu+FfrpxxTLxyE6+clhnUmZqidkqGFJOROASd2XFLIfXhrfBhhjV3gnuEuGet0tU2nNlCy9TB2vz/jiONSz9ErE/D72EMaPL2WOQ59CE2EHPN0W4McMtPiGJJ/zpptT15C+NjHBoVt+PJmN1Uza1cpR5//UsLF2sYLQwg3EYJb4d2C2fB7JeFXFcgMYcVrVy0pkfr02XDWOhhtKPHGx4yYQr5ZmNXZpgkGKgrK/xFT1RPlu9gHTXcsg9fcYhTA0q1UNYREzBIdU+L2XnK4a9csMdTJxXJ5k7PKlPp0aTm3Cnqx4zbJ98k8dbDJLM2WUEV73UlMw+VbhvKYI6byeLcFy/77OMzFQbawPQIwqVWnEDI3tpaor2wb9ugKY8Kw3dJcV2h4sbfjt9ClTQZWWZ7N910oy4qM3L96du6DgSEl8hTRbPGZM7xil4ymrH3OWghJQHCrPQDDyNQeZmB8vM5yOhI+yppOuhnsTo5nCJ01JJwWdNDZ/+fHSNKJTvikkmWQgIHn8kWJgXcJjihstt4brMurW2c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB6873.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(7416014)(376014)(23010399003)(6133799003)(10067099003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UVVOM21VUVEzdUZqQmlHOWxWTENtRGE3SGxkdmZlUFZiRkJXZE94WmlMUmls?=
 =?utf-8?B?YVdxLzQ1elkvdTh6YTlaK01aeHBhYzNUT2FGdVFPWFNuRVNwdGw2d1JjOGc3?=
 =?utf-8?B?eWZLblhUdHBheDR0VStTMWU1RzMxcEhFcFVVYVM2SzBVaHY4MUZ6VllyaThk?=
 =?utf-8?B?ZTkrNndJU3Z1eDhJRURaK3FXSndzRzJySG05cXJIeEJia00veTVUMUNQVWJq?=
 =?utf-8?B?dWs5Rk82ZklKYVR4bVBEYXd5UFlzUGI3bEplRVdxaktXZXY2M1liOGZyTTdv?=
 =?utf-8?B?ckhoWkwwRGtaRzZYMnhIL2NON0J0VEhOckpHb1U5aUhmQW40TkhFcEtIdWRm?=
 =?utf-8?B?cUdaYmVydkEwc2l3eDJHWjFsUnFzaWsydHVLZE5nN2R1OTJUYkZpWXV2eEFD?=
 =?utf-8?B?NnVwRENrMGphZ05QaFJYQjlYSzRqalplQ1VzZExmbGpTK0JwRGJCZ0NWV2lQ?=
 =?utf-8?B?YW5Oc1QwT1VwbXBPN3JTazNncUhiQnprWVZGUlVyV2J3Mk1FSVY3SGFuRnZ1?=
 =?utf-8?B?K3hoYWdXdVNCenkwTlVvcCtsTUhTbUcwbVBFZVUzRGxIMDNzeHR5eWhCZE5I?=
 =?utf-8?B?Zk9vQU15UElWSERjdzRtMVkwa2VHcTZhL1gvV2JoT2tQTTd3aFlZeTJxMkcv?=
 =?utf-8?B?dEY4Mzl0eWgweDNSVnBSTlB3SXBzbkVPMjk5cDVLTXV1c3Q3eFdaOFc4YVQ4?=
 =?utf-8?B?VUNSbTNuTkRLOVUxeTUvSEU5VnFITzJFYlZSNFpsVjM0K1pKUFgyMnhrNTM1?=
 =?utf-8?B?bzVhQ0RPaVpOQmRxUWhhdHVuakIxWmQzN3d0Q0l5NDVuUGFiN1JDQzdSSG1Z?=
 =?utf-8?B?T1ZpNWFOcmMzLzJYRmo2YTBSVzgxTjRlby9VOGFFaWJSWW9BbDR3SWlUblNB?=
 =?utf-8?B?V1BjMTg2cDFGZE9TL3NRenlXSkxoQnlYQnhsNXhQL0J2MTVKcFRDVitNVW9L?=
 =?utf-8?B?QWlHMUR4NUxWbTEzT3FIWmZieDhTcURuM1V2Ym9rVnhTV1liRkpOWVZ3TC9R?=
 =?utf-8?B?TWM5b0VCTU8zTG0rMVhDbUFUYU5OaGtXRldLRHM2TEV0MzB6ZUppR3BMaEZ5?=
 =?utf-8?B?RVJ3eW8xZkt1NTZDczRaWlFhbWVmZkx5Mml2VktpRG5mWHZMZEE1N0dHdGFL?=
 =?utf-8?B?ZHlERnRiVi9yRnRsc2tGSGFOTU1tOUJGMW1DSVJVQk56djVqcmsvSjUra01J?=
 =?utf-8?B?Y3BLSXNWSTV5VWZKREN6cWdRMkFxOU8wYlBmbnFWQzRlWDlVSjlDUmsyNkpG?=
 =?utf-8?B?U3hyQ3FsNjJrZHVPUEN6bHRxcU5YcHFJaWNMZ2FRdlNLdlRreTFRL3ZqQWl3?=
 =?utf-8?B?NDJIZlZ3cXlFeFVTKzVVY0ViTUVwa3BoQWlMME5IN3IxTTJ3OFZzQUVNNGJH?=
 =?utf-8?B?SHpkWUw2Unp5eXVxVENrbVhQaDlzWnpETE1Zek53YmhaKzBlcXBxT1BLMENP?=
 =?utf-8?B?NHBDU2NCNnQ3Sjh1cGtmRlFNZFU2N0lCYTdnVGRIY01URjJmdWFlL3ZFZkhU?=
 =?utf-8?B?Wnpuek9RaytNa0tjZkJxZlFtR0F2VzYyQ2gyTHV2NStLRm1hQWpZdEVzcmww?=
 =?utf-8?B?d0hVNk1RTlBIUUpOMDUvd096eVlLem9ROURuZkxxd3M2N25sUE56QzBEekdQ?=
 =?utf-8?B?OUtRaDdoYllnbk1Kdlg4MmttbHNYY1hTQzEvcEtwRG9GZnFrbHMwNSswQzVy?=
 =?utf-8?B?TmxxOVA5WlBZNENKdWROMVIwS1pYWms1OWwwU0tTQ2JwYzUzWXRzcnVScGRr?=
 =?utf-8?B?eGcxdW0zY0szcklFSGRERVpYRkhkRlJCUU8xMXNmREhnQ2c2VjgwdDVDNWNR?=
 =?utf-8?B?TVYxaE1WYTAvUHJwRFZCbFkxK1FpdjZ2OUo2OTFrWlJuUTJnVHQ0STJTY3dh?=
 =?utf-8?B?ZUozeFVyMGVuTk1xcVVpNVZ2dnprTGs2a0tlL0RHQm9ZeWNmYUJZcERYTVgx?=
 =?utf-8?B?STdNdDYwdVp1bmg5VHArVDBrMnVYWjE4ZndlT3A0WktoU2l1TXAxZit0Wmo5?=
 =?utf-8?B?QmUrUUhpMmwzd2xQREhGcDNONU9UMkY0M0lBTzgwUlg3bkhZc2VyNXl6Vnlu?=
 =?utf-8?B?dERRYjZtNWYxWXRuOXJtdHIzNEVobDVsK0t2VHVLMGtrQmt6enhoRmFQYkls?=
 =?utf-8?B?TGY2ZDVXWnZ0aHJLL05EcmlTenhHSDRYWkFWUXJSQ1gyQUFyeVFJT05mT3dN?=
 =?utf-8?B?ZWpVSHQ2azBuWTBBYWhaWTE3TXc4V0NZTlBlRnhoTWhqNWJiTEtoaWRrVmFU?=
 =?utf-8?B?OWNMbXI2TEl2dDYxOEI1a3BrZ0RZUHg4RlBFM0VFZmlKaDdwcUJ4dWMrT2ZL?=
 =?utf-8?B?UXl0SWtTSzMrTXBBYnNVT0pHRFBrTTJOQldna0xLWFRKYS8rQUtpSG16Z1p1?=
 =?utf-8?Q?ASdb+z1gf2c7xgEofa9+i/uRox7AebxVP2smrm7IUlCRY?=
X-MS-Exchange-AntiSpam-MessageData-1: Lnxzi/IOjuJlrg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db286559-0311-41b4-c8fe-08df040b38f1
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 07:17:15.7248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TNbFsnH7Z010EqSGRVnak6CdauWeYIHCUwH7yzvPWepjdm1sL1iLR+uClAsOALhRKGzz0qsMTINXEanrpao5sA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4324

On Wed Aug 19, 2026 at 8:09 PM JST, Gary Guo wrote:
> Currently registers work for all untyped I/O regions, which is not ideal.
> It allows registers defined for device A to work for another device B and
> there is no safeguarding at all.
>
> All users of the `register!` macro know what type it will be operating on=
,
> and that type is consistent across the driver. Therefore, add a `base`
> parameter to `register!`.
>
> Currently this parameter is unused in the generated code; it will be used
> when all users of `register!` is converted to gain the parameter.
>
> Signed-off-by: Gary Guo <gary@garyguo.net>

While trying to confirm Sashiko's doctest warning I stumbled upon this warn=
ing:

    warning: field `base` is never read
      --> ../rust/macros/io/register.rs:143:5
        |
    142 | pub(crate) struct RegDef {
        |                   ------ field in this struct
    143 |     base: Option<Type>,
        |     ^^^^
        |
        =3D note: `#[warn(dead_code)]` (part of `#[warn(unused)]`) on by de=
fault

... and a few rustdoc ones (introduced before this patch I believe):

    warning: unresolved link to `transmutable`
      --> rust/kernel/mem.rs:83:25
      |
    83 | /// - [`Self`] must be [transmutable] from [`Self::Repr`].
      |                         ^^^^^^^^^^^^ no item named `transmutable` i=
n scope
      |
      =3D help: to escape `[` and `]` characters, add '\' before them like =
`\[` or `\]`
      =3D note: `#[warn(rustdoc::broken_intra_doc_links)]` on by default

    warning: unresolved link to `Self::Repr`
      --> rust/kernel/mem.rs:83:46
      |
    83 | /// - [`Self`] must be [transmutable] from [`Self::Repr`].
      |                                              ^^^^^^^^^^ the trait `=
AsReprMut` has no associated item named `Repr`

    warning: unresolved link to `Self::Repr`
      --> rust/kernel/mem.rs:84:19
      |
    84 | /// - Note that [`Self::Repr`] must be [transmutable] from `Self` =
as well, however that is a
      |                   ^^^^^^^^^^ the trait `AsReprMut` has no associate=
d item named `Repr`

    warning: unresolved link to `transmutable`
      --> rust/kernel/mem.rs:84:41
      |
    84 | /// - Note that [`Self::Repr`] must be [transmutable] from `Self` =
as well, however that is a
      |                                         ^^^^^^^^^^^^ no item named =
`transmutable` in scope
      |
      =3D help: to escape `[` and `]` characters, add '\' before them like =
`\[` or `\]`

    warning: 4 warnings emitted

<...>
> diff --git a/rust/macros/io/register.rs b/rust/macros/io/register.rs
> index 8af12caa964b..2fb48e1be82d 100644
> --- a/rust/macros/io/register.rs
> +++ b/rust/macros/io/register.rs
> @@ -27,6 +27,7 @@
>  };
> =20
>  mod kw {
> +    syn::custom_keyword!(base);
>      syn::custom_keyword!(stride);
>  }
> =20
> @@ -139,16 +140,26 @@ fn parse(input: syn::parse::ParseStream<'_>) -> Res=
ult<Self> {
>  }
> =20
>  pub(crate) struct RegDef {
> +    base: Option<Type>,
>      regs: Vec<Reg>,
>  }
> =20
>  impl Parse for RegDef {
>      fn parse(input: syn::parse::ParseStream<'_>) -> Result<Self> {
> +        let base =3D if input.peek(kw::base) {

Here as well Sashiko's finding looks accurate, albeit probably not
serious. The proposed fix is cheap though.

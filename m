Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011048.outbound.protection.outlook.com [40.93.194.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1AE34EF07;
	Fri, 14 Aug 2026 13:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786715820; cv=fail; b=tZsEM7de/RpIk6rlib9b6YoGUhf721gOZANSFvk36uCG2O2i/ffbtZQvQigxDGrrUZO1XeGZOdcT+pYp4getGL4dtnVIidnGelHWfhJ8vE7iQJvekwhQdsmQJf26kOBJG1VnvHnD4C+ylYRjfLCxrD/FC1arUIDxfdw/OSMNCgU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786715820; c=relaxed/simple;
	bh=qPrP+mO+XuQSaMdvV77qYCXmsfukVIR2V3hA5VpSuqU=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=ZItLL2qPHiGgEsur1yORlgM4d+9VPy2Wbu1FX6vsY2hzX17bvd0VGHG8KRGeETO0W2Mccg2begvIxdW/+C8CHd9FD3QvyeZYkunEX8Yb/D6/2JEHtOOD7ZqDtz0mTtnACtqZsI3+oJ4DqttBn7xE/VtcVnW5VQWm5Olbt1BylTE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Rc6qGYDS; arc=fail smtp.client-ip=40.93.194.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Rc6qGYDS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KkGK9NTTUd/f7TAxNUvRdg9aD7P6VQnMFUsG9vCarJQ0D+ecpXn8orYFO84VmkapN1RqvQiR9oFIjd0+XxqvqFFp4cm0zmeaBJ5F/wiTs1z6iJmf88Vdz0mx9j9BId63pnli7iddu2WkZAUoQAMs8l368kdGgS+ehZswhfGKs1AhhwWo3dbVEwsJdNyQRj8PAhLLQ1Hui7F15RCzRJ9jxVUFbiPPCe/otWNdYJyJpG+z6AXgqdkpwRuKTZjXEQkzRAB+DLZAC3uy02VjRmOSzg2WOiZb0UsdyTL5urbBXJC1uqtPLwVwLv+p/CrMKd81oaFFYpe6WFfAnokQy1E2zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j+Khl3NBdsJQ/yYsSsCoq+no6DAIO6NfZg1uD5h9RrA=;
 b=kVshjFKou8V2SkOoEwV5zD1IS+wGsTmmL5hF6qGdF8qcnTCDBxQTZDLP2FK65+alf+i6GrUn7pJJRt2RYciVqCPzNrwUFSoAdkaIQIFIkR/F+b+U6dGLWdO+eqmf6NlHqVRZbh6V5PpAwsGGPdtE3zbB1ECOjwoWPt2i2ty6lQWLzdvAx7vRg8YZt3GAQvQtAMksBQmGWT9ukwvI63zgibPRZi1cn9Of9N321/4oLK0vc6Ll83jwwAfbmhqW/8dNiTgQuTJ8RdsaI01kCOuOrUKJvNeQXH1AxFnUIJzbGR3+/UQVnFXK6NAXGU1hFR3wZl94v4qfLud0dfijvKGh2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j+Khl3NBdsJQ/yYsSsCoq+no6DAIO6NfZg1uD5h9RrA=;
 b=Rc6qGYDSfD3Q0d2itY26udbTZXWnm9vtt5QMP/SnaAtTb1jITowFfwpiUneyGdcwlxkZVGnZfk9Z/8Y1tMbnU35zSlY00DusHsdDmpBSiG6fwNQfIkudhC3nWlUyleO2YcZHV9dvReDtZTnsiaZ8a8WM8PQtFOTrhiksg2fnCzMRxTuKjJHe9XBje+JYgLnRTGFKet99d4H4gfhrUqmEvFICPOy4neOpyQY8KfrjEarSS/O2x2D692x2ECN6T/QBDyyRTPkFtaCpWq111L7qKe038KD/Nns+o7xZV4/AL2fosFAEGSKuxO9x2HfixSQMnxsjIU+1iJkC4ZIUafew6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CH3PR12MB8258.namprd12.prod.outlook.com (2603:10b6:610:128::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Fri, 14 Aug
 2026 13:56:47 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0315.008; Fri, 14 Aug 2026
 13:56:47 +0000
Content-Type: text/plain; charset=UTF-8
Date: Fri, 14 Aug 2026 22:56:42 +0900
Message-Id: <DKOPW4JAQQYY.1FJCI2HTRLIPX@nvidia.com>
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
Subject: Re: [PATCH v2 16/16] rust: io: register: unify handling of register
 with/without bitfields
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>
Content-Transfer-Encoding: quoted-printable
References: <20260805-typed_register-v2-0-c3ca142220a0@garyguo.net>
 <20260805-typed_register-v2-16-c3ca142220a0@garyguo.net>
In-Reply-To: <20260805-typed_register-v2-16-c3ca142220a0@garyguo.net>
X-ClientProxiedBy: OS7PR01CA0031.jpnprd01.prod.outlook.com
 (2603:1096:604:257::17) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CH3PR12MB8258:EE_
X-MS-Office365-Filtering-Correlation-Id: 3378f3d3-3595-4bf1-d0de-08defa0be194
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|23010399003|1800799024|366016|10067099003|4143699003|11063799006|56012099006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	3LFtyrnRJ/zYDix/sZkwxBlJLyZqsuIMkd9n4jb0CH38Tq6d3+FPoV4T5Km0glc7nzlLSyg/tDvoAl+r9nCOHzj3D+gJ4JjIYBLIZHpkR7L9bZTbh7FW/MMUu6GZTp0yecffuFysKnC9Ov3T7sU/fhbD8swHp2XFPRZjfM4c1A3LRl3awY8YHKyLS5+4yNB/p2f9C9ouzFw0DTgsZIIxMK7ddPOdS5Ini5MmaSxEzaxElo3MURH8s12HibmoH2UCl+zj9My+kIm9q1K7YlhWro53KguKFdKCyop2d1FtYeDjUh2+vkMR4KY2QgB+/4fyJGtymNvTOsB0J4oiN6bFLD0aK41jUtI7OtjmDvInSY9lPY9aN+AGY1s9VqNBK4pvLIlTZqKHfyR7CpPi5ldF2hzBlYtT0DOfg3UQROyFOSXjXweJc+tRjWXPTskaR8/ldV2mDZ16vafCkm4a9SkVMsdIDlkj1rAzmKM1UGYnxy9GZ8cUU5RkJljpIh+KdT4gWHFbXqatPZ8gi2k0B2W9UyQJN0J3QbfulyyZ4z+EEaHv+0hVfeWLiBvx6u1hYJiM25oK5/y4hJE865ZBsIDZLhgO1JCSrj2crtOV/oGhF5TvoRbwgruClIVeOnKPigt0ZqabwgmN8HB5HJ9d2CZfW574wZdGDDj5H2KuiOalvos=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(23010399003)(1800799024)(366016)(10067099003)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UEliUHM1NTgxaHZSNk5BQ3p2VlFYZ055NG42Rlp6cHlvVFZudXd2ZHpkV3Bv?=
 =?utf-8?B?SWNRK1gwcjJ1Si9OWExwOS8yV3lHNTRtN1QzSGVWYURlK3o5aHdkN1lBZ2th?=
 =?utf-8?B?NVVObWpaUWNtUlkyT1g2N2l2MUhYWFZFT00rbU5HM2h4Sm1OMGhId2pUUmVt?=
 =?utf-8?B?ckpMTGtTVm90NW5rMnFwUkZ6dW10NUZ5TTB1N21Vb3VIYy92WUt5WGsvMyt6?=
 =?utf-8?B?c21FaFpkWkVWZlRsUXVZdzM4WER6Y3E3MjB0c3k3WVUzSG1kREIrWlNEWjBq?=
 =?utf-8?B?VU5SY1NPSTlWdndNUDUvM0ltcGs3dWM3em45aU5EcVVGQXRxYUQ0NWVNTG9s?=
 =?utf-8?B?UzdaSGQxbzV0TFlxQUFKZXpibTBmUnZoRkNMOFFVaXlKWHJ5ODZ2UmdOb2Zv?=
 =?utf-8?B?NWpIa1piTGwwM0FuZzVESnhkQjlPbUtjanViSVZxZkNxNlBzT1RmaHBJNFdP?=
 =?utf-8?B?ZGxPcGdoeEZiWWIwM1o3NkZveW1JZytNT1NvTnUwdm5HbFJsdWxpNStZN3VV?=
 =?utf-8?B?aEhYRVAwSmlDcVFZNVEvQ1NES0dtQ29VdmRBTk5LVGNVZjFSeFBoMUtsQUxY?=
 =?utf-8?B?WENUenVTUWwrSy9TY1BrVXg2UjN1M3FvaUZIME1XQVl1bVZBcVJ6V1UrWnla?=
 =?utf-8?B?ODhaeDNDUmNablF1eUtKRWh3TjF0c2VzN3ZVQXYySDlyNnpZY1JKM2pkQVkx?=
 =?utf-8?B?T0p0TmtkVC9CMDZuRW9lMzlCLzBEUkVwNFdjUHhYQyswNFhER3lkamRuMVVV?=
 =?utf-8?B?WlZVVUhSR1RHT2x6WlZxTS9YY2FkOFBhemFnRFk4ZWhPQzAyZ0FURWJVeGNX?=
 =?utf-8?B?L1N6VWwvcXl6bCtoTks4cXNzN2lzbmd4T055QzJYSDkyQUtLTzgyQnpVUS9B?=
 =?utf-8?B?blJKZUF1bUVUdnNyaXQ0aXpGNmdvZlF3NUNab0tYT0JEaDJ1L1FpU0JISVdv?=
 =?utf-8?B?d2t0aG4rMG14c2ErV3ZQM2tjTkR2ek14QXUwTE8zbG9XM3JLdWcycHE5ZzZs?=
 =?utf-8?B?ZzdWVUNZakJSbDljRG01RTd4bG9xRE9HNGt2UFdRSGNWSmo2UFlEZFQ3SXgv?=
 =?utf-8?B?V3JNdCtQSG9OL0RIb1Zndkx5VDd1Rjd5ckhMaXU4MkswMFY5YTJUVVVzdTBw?=
 =?utf-8?B?YzYrdDR3S1NhQ1RWVmJDSjluak94Sm5KNnA4aTZYM0U3ZndqTTVxRWFzZDdq?=
 =?utf-8?B?RTFGTjY4ajBVS3VjWlNyNk01cUwxWlgvRXBtcDFNa01OOXdyK2RWVERNT3dG?=
 =?utf-8?B?TTEvNGFjNjNPeDVyVWFmeUp6aFg3T21IZHBMVitRanRmOXErZDdrbTltSExr?=
 =?utf-8?B?Wk1ab0pRQ1dob1ozOGFwcFF6VVBEMFpPTjYzK1lKemNJS3dnb1BFYkdCUjNq?=
 =?utf-8?B?WGtnN2tsc1VHb1ZpbzdSWGFYdGlkZWQzM1dKMDV5alNWOXNxVnd2MkVBdnlw?=
 =?utf-8?B?ejhTSmtTajh5SU9waHNtb3JocEhULy9jV2M2QWF1dlg0TVM2QUprTEJNajhD?=
 =?utf-8?B?bExsZlM3SHp4TEp0VGRWOHBGN0VVRHBnODhlcmpVVnlrRitydE9jUTQ3Mkl1?=
 =?utf-8?B?VGZpU2trU1hUVWU1N2wvbGVUM0R6eVRzSHdoWnpFOEFKcmJpUkpFdldNaGZC?=
 =?utf-8?B?MFFsK0ZXSVRjS0JIbU1GeWpBVkRYUldEMnFsRFBqYmx0N1BMNXU1czF2L3VJ?=
 =?utf-8?B?ekxadlhpQ0t6WFlyamdVODdDR3krT0pZMHM4Z1N5eVgxY3Z0VWNLM0wrSWVH?=
 =?utf-8?B?bHZXQWxuYjNZL0p3UDFoTHlta0hHNkVQY2o1Q1h4VWVnMjY0d0drZ3RLOEV2?=
 =?utf-8?B?Q3hLUjZOY0NPTm4vU1R2cm42QUJDQ3hKY0cwem0wUm9tSXJMcUpuSFRwZ2VT?=
 =?utf-8?B?eUJCdnJDcmphd3p4RURBRjN6Sk9nTzkvSmVlcFMwTFJ5amJ0MlV1Q2lMNnM5?=
 =?utf-8?B?c1RSd2ZRT3hQVVYzbjYzaFdGZ3JwL0hsWXNEcTEzL0hHM0ZDWmx2a200N01C?=
 =?utf-8?B?dHR1WVRGdEI0MlVCczhFQzg5SG9vZDNrQ2xlcUs5cEFkS2IyakdZdXFFUnFO?=
 =?utf-8?B?aEUvYlZGZlVyRHVtbkpHVWVWVTFGcGxJYWlZb2F5RElPeGpiZVBKTUtnaVR5?=
 =?utf-8?B?K3ljSlpQTjRZZHVQaEJQVUtkRTlRTFZOalNTSThManQ2R0JuSUdiTVBwMU9K?=
 =?utf-8?B?Wi9Tc1NEbVk4Nk9QZTZWOWlUSDhXQW8wRExaVTdSL0Z3T3ZLZVpRSVhZeXd5?=
 =?utf-8?B?SzF2OXBSRDJCT0tJZzRnRDhJbW5zdG84eWRaeVVRTzFNV0Riby9wZmQvckkv?=
 =?utf-8?B?VkdGeXpxT1kwZitDaUczMkh5LzJJdDRYOEdHeEZiWUUvb1MrS3hGSHh1emx3?=
 =?utf-8?Q?qLJoLyD7a3s+20hyXPcjS2s8I/qpBoTa0QMgfoz4PRdKr?=
X-MS-Exchange-AntiSpam-MessageData-1: l/NBulGj9rx9kw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3378f3d3-3595-4bf1-d0de-08defa0be194
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 13:56:47.0652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CE1yJv/lXtCnN/Vfx9nlRJRLdEvtBcsjQEfrczS566uPu/FPW/FxfBHt78seFmzraVKG6VReiEGXFzY8d8R/0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8258

On Thu Aug 6, 2026 at 1:35 AM JST, Gary Guo wrote:
<...>
> @@ -577,6 +547,9 @@ macro_rules! register {
>      (base: $reg_base:ty;) =3D> {};
> =20
>      // Creates a register at a fixed offset of the MMIO space with provi=
ded type.
> +    //
> +    // This handles all of the fixed offset `@ offset`, alias of registe=
r `=3D> alias` and alias of
> +    // register array element `=3D> alias[idx]` cases.
>      (
>          base: $reg_base:ty;
>          // `$ty` cannot be `:ty` due to follow-set restrictions.
> @@ -593,10 +566,29 @@ macro_rules! register {
>          $crate::register!(base: $reg_base; $($rest)*);
>      };
> =20
> +    // `#[unique]` indicates that this is the only register of this type=
 in this given register.

Sentence doesn't parse (in this given register?).

> +    // Thus generate a `FixedIoLoc` impl for it as well.
> +    (
> +        base: $reg_base:ty;
> +        $(#[$attr:meta])* $vis:vis $name:ident: #[unique] $ty: ident $(:=
: $path_frag:ident)*
> +            $(@ $offset:literal)?
> +            $(=3D> $alias:path $([$alias_idx:expr])? )?;
> +        $($rest:tt)*

This rule looks like it should be private, or am I mistaken?

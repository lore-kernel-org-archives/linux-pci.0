Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011015.outbound.protection.outlook.com [40.93.194.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451D53515D6;
	Thu, 27 Aug 2026 13:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787838133; cv=fail; b=uLQs86WDVqllc7hzyNxJ7BTfDJbXtMm0u06Y2ruZmXgBTBCu0U6WZFp0L+Evt/jKO7oWkaJUSq37Pp7QmZ3QZdJ1gjyqb2twWC7Ui2zg8xUPEcQmvVh+kH6iCHfGFUAlxkW4FpcA17b9F1uP26hkzj4c8hk635lW7bmi4Cz02Fg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787838133; c=relaxed/simple;
	bh=V5gFoybJADCZ/oVBN3rKpXwtq8n151XeCMfF+/6hWAI=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=kzdGgo4b1+Ox5vWtCClc66Yl7X16ayQ6SS+9P8QJkIIPgMwEXVygmk4ISsCD6nn1l2q3QJBbbO2OeqjSMXMSotM/aLxACaiNXlsrEh+H7HggWz3CRyIZ1kPn4vYa9snrA/op9qQSqB9qvdtVotYnahe7WmqRUbC2U8J91fZDZho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=c00y4Mob; arc=fail smtp.client-ip=40.93.194.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="c00y4Mob"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AUTsNeCgVSVjVzFaN4f1sUvaGqSzDDWAa0uQoYd5YdKtgVOvaICU37rAkj4AtdrIuNqE2x9T+NaLUS0PhKsKYbENJbj8IcUlNkk20WrkMqKolDbuNq9T/SXeH4T7Lx6i7b8uK2oECHZcmRqkbu4Z3NAjfIDwu2ZapeT0CL61LMlx3XXeT232BeuIe1Cjwd+lWHaQGoKsJHEUrGoAn6b6wAxf3wBFIXEnTRVBG7wkrssREL17j+UCn4Z4tM6+A7fFtNsmI9733OL2UzgXrepjT+IuQn5kok5O276D3LRoxVoKpNjii0/cXW8rFiXXsMUb0Y/AUtE7qpidvZGpI2GPpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6hztRY1U21gTGeMq37zt7iKEbhV5TK5Te0BAXE/es+4=;
 b=qmKKYJh/uuwgwX1gcc4/cuGnLBr12c4aPcsbVS1qrK3pAVlxdw15CZgMw77u3FP8UDbWm4Vv5bHgTk77W3Xak0hugTO+dAX0sX62mTJIJj80rjm8/NlxUGvrJYmLlCqTdgWEU80jN24GJM5VfUG9TMK+Sz3glMH/rnZqi4l2HGb2T98RcI8iksJASD7EsJCbUOfvPy79QNP/XZvy4ULhkAL0z3nKqr1p8t+boq/tBXtaqTXpfkV9Hzp2m0KifoOBuB3BXC+smtiPegrZL0s4fvHUCI1cdsvICXBu1R8dx4w8mimr/HdU/lv7zTJw37K20SX34kTf7tdECATk7ZMZPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6hztRY1U21gTGeMq37zt7iKEbhV5TK5Te0BAXE/es+4=;
 b=c00y4Mob7EyNMp92YYshlJJFHqQTs1ALjQva4KBqkZuwKyTB0SqWvI5Xh+tjBnIO7y85xJMpW5nN9vaI5YsjpAUvzreBH8TLu7lJnBU1urPc1o0nKRBqwat+/wz0MumfubHhMoXvOkFrCI6zNAmdi8aHBLgqckslyHiYwhInf4PY/g+NZBjVI5nAPkJiecselqHmA13/IIk6b11lLeCzWg+ZjeFnZwNC8R0Mi+eFTxWkaSYLodxSOSq2ucFgn+wN/RxnNFxAT+JVjHcfjkvfn9lQ0I+fApaven+u5bHq74her07uHAVwGCZfJBuhHEnTE4p8bFnOhM6HDcOa7+cUdg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by MN0PR12MB5764.namprd12.prod.outlook.com (2603:10b6:208:377::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Thu, 27 Aug
 2026 13:42:05 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0315.014; Thu, 27 Aug 2026
 13:42:04 +0000
Content-Type: text/plain; charset=UTF-8
Date: Thu, 27 Aug 2026 22:42:01 +0900
Message-Id: <DKZRPYOFOIY5.3RAONSST6MTL4@nvidia.com>
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
Subject: Re: [PATCH v3 10/16] rust: io: register: make register have a typed
 base
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>
Content-Transfer-Encoding: quoted-printable
References: <20260819-typed_register-v3-0-3699a75fadf1@garyguo.net>
 <20260819-typed_register-v3-10-3699a75fadf1@garyguo.net>
In-Reply-To: <20260819-typed_register-v3-10-3699a75fadf1@garyguo.net>
X-ClientProxiedBy: TY4P301CA0027.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2b1::9) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|MN0PR12MB5764:EE_
X-MS-Office365-Filtering-Correlation-Id: 21f72a2e-8342-445c-7379-08df0440fae4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|10070799003|1800799024|376014|366016|6133799003|10067099003|4143699003|56012099006|5023799004|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	yCD5QqJyGPj3QpFWxEfh0hMKj745v2qRQXo07IQNWkQPtoVYD7ZWqRLKc4Hhz5yRUGJyrZEsfihNFA0kWhmT6lhAax4TACjL9isuCzoN6STEf3nfIxCNKRKN9Vv9tG8tbF7mQl/bDayWMHxTToDcCQKlHAXSoASo7sOkd2z0PIgZK1mSHvND1XvLzqQ769ZE9Mi9fN+J9qr3fr5ndIScY4gIc2M/3EssyrxFKxpgAjRdvaOuBbpm4sPKuiIWnPhhlLD900DPvFIQXJ2+cUBNqQO1m9ZSrNQYzYN80xKdeB07BziONGjnfePApEBKHOP7LI+BrYsZe3wJU2dJVR+LFCTQmB+bmcqcdqFjJOPB3CieFfbAIkl9b5aDxT0Fh+ShZ0lXmvYAa4d9CgHi8dcUYiRZv1s5Sx1H+59OpGZ/vwa/cHd8aB9WMTvUymh+aZulVx2ZF8Sl8s6+V7SAJnoD0b24ZAmTlEpvai/fJlWNvlYJfpUmMO9S61JHpBNwVB4vL3IvDUsyte4lQ6I4IjaW8OrLElqzO59/opL5BeT6/Y6ehKgOvkbH4Modx4RW0rwdFdOz+tvLGKhANr8962/TeHIisQNudEDrF9pLcsPBx17ulPHpPJf5xAOph0SUOu3DpzijA79knHz5UuO+n0DAxh77nWSZOCu9y4hiwy7yIpA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB6873.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(10070799003)(1800799024)(376014)(366016)(6133799003)(10067099003)(4143699003)(56012099006)(5023799004)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WWpHZkpRQjFpN2dlUUdPZWsrNlJFYWpuaml2N2RkaEdOanE2Y2hDM25JUmhk?=
 =?utf-8?B?ZEVXQUUranlvWmNtVFBNRzgxV29wWkpUcFJ6alE4NndybHQ2TVErWHlZZjlr?=
 =?utf-8?B?Uk1OWHJEeEJoZkoxVEw0MzI1VmVONkMvMUpXYzlQdldDWUlSNHRZVDllQkcv?=
 =?utf-8?B?eGlKVFU4Z1FhRkRmbVE4SnNiaUNzV3phQzR2Vjl5d0FiN2dsMmRhem1xUXhN?=
 =?utf-8?B?cEdObHBvcmtRTVVUcEx1cDJmNFB1c0w2M1hBd1hLSDBzMHVoM1c0VmJmZlBa?=
 =?utf-8?B?S1lzY3VRbFBCZHllNW50TmE5NXRoNDh5dVdFMElKUy9ZY2RGWGx2N3JiQWEw?=
 =?utf-8?B?MmhOSHQzbzA3V3RBZTc4eUhCT0JwVlNYT3RBS0VDUXhTeFlETkxEM1lUUGl6?=
 =?utf-8?B?bjRjVnVsM1VMMnp3U3hYdVA2bWhnZnhjcGtLN296QWQrckxMb21wclYxT1Uz?=
 =?utf-8?B?aHRJTFpCRHhMZUZKZ004YzdWell6YVhXbXc3ZkR3bXd2Mzl5SENzNFV0UGJT?=
 =?utf-8?B?S0tPQmtuZytsSy9UbFRRZVphUnJSK04wS1RteG9uVlpVUEtpM2FKbTVpa0VT?=
 =?utf-8?B?WUpYYjdmOE9rVGZKd25wN0plcDg1b1VMOHhmZnJBL3R1UGwyeWRQY2VTRHFP?=
 =?utf-8?B?dVErcGd5RS92eEVuNmNIYkFHbWNZY1VpZmtXeTVWRDIvdTlMVDU5Z2x5eVpC?=
 =?utf-8?B?U0tpTzN6S3pvZHB2VnkxUTFMaDU3YzQ2bFFMWG90UUMzWGljN2VMSitnbkFM?=
 =?utf-8?B?Vk03MXM4TUhWTXhWaEZtV1Z0L3VTZWFLbmlkWk9ocEloYUlsVDFSY1lQM2t0?=
 =?utf-8?B?NEkzc3J3b1NCbkN4WHdLbHYzWFhHSjJNZFFtcVdoRmJySUdITzh4Y0tpOHVM?=
 =?utf-8?B?Y3JTS2E1elN5TC8vZmVDcFkyd2d6ZE1Oc0ZxSHFaRTM0aWd4NWxKSEZSVzI4?=
 =?utf-8?B?b0Z2RWt3UC9sL0F3WUtxNGhOL3ltVWdaQTlxKys2Qm4wOUFUdnMyS2RJWnZ5?=
 =?utf-8?B?TDRjRzVUOU4vVDc5V0RjMi9MYnVxQmN5Ukt6amlvSHR0TEJ3bFlMZXk3citY?=
 =?utf-8?B?czQ1dGdZTm95eHArQlhoWG9QSkZsM2QrQ0hkMGNyWEl0SXJpZmhtTjF2WkZP?=
 =?utf-8?B?UjZyNENFYndKN05iMVk1M1QxYmNnMWRZQkRramExQVJ4SXpJQng1V2kvNUln?=
 =?utf-8?B?b1U1K2dkaFZFNk1wNm1qVWRQUm5kWWdFZ1F6UDFGaElLemZ3aDJ6cHZuVDk4?=
 =?utf-8?B?RnlRUWh3NkNGdUxuN2VicVFUak9VNkhXQVE4STZDdm52RU1yOGRpQjBvVlh6?=
 =?utf-8?B?RHNkWUlMb0JvVEI1SE9vcUhoR2VheDdDQlo3aDV2WE80NUxSOEl1d0toOUc3?=
 =?utf-8?B?UGxIdVdiRFFzZHJkeS9vQW9KWGlLcEQxSm82WEM3ZkdaY2YxNmxHWi84QzlP?=
 =?utf-8?B?dU4yQ3UvUlU0YkVBTkJZV1pBUzlzNDh6VUdJOHN1c3NoelZLcUtpN0Q3OHJv?=
 =?utf-8?B?YndqY1cwNVJGZWtvUGRPNWk2a040N2Nsa0FNNVdPSnlNTi9EWFFDWDNSY0NM?=
 =?utf-8?B?NzBMcUNvTW9JanVVYy9TSVZEL1R4MVVjdmFVa1pJZVk3dUNqWVlDQjRSUVJV?=
 =?utf-8?B?SmtHYkRBWndJSGxnTnMzTy9RVFBtOE9PZElUa0N6S2hDQ2lSSjZaRnZmZWN3?=
 =?utf-8?B?ZURsdG1NNlZ5b3JtTHZhbXhNWDJHb0FRSys2OTMvZko2R3hZend1dzRlcWlP?=
 =?utf-8?B?T2djeVVYRGF1N2NYaDRicWV5YWV5QjVaQ2NxQUxKbGRma0JSWCtvcVZkcU5U?=
 =?utf-8?B?YTRJOVRFaitCeVA2QW1GZHY0WkR1YWNPd2twNjNPS2M1OVQ4dWFBeVNJSWtJ?=
 =?utf-8?B?akJaRi9mM2NGdlB2cVVvQXlHVE9UNXhYWWZpaXJsenpweHdtanZmVHI2a2J6?=
 =?utf-8?B?NGdjYlgrUXg2YUtKQ1NrSlc0bFZ5eUxCUWc2a2JTZHlZUlp4SWRKVWpVdzBL?=
 =?utf-8?B?WUpDVGFHYU43YXAwcjFLUjlmZGdHbEpMSVBybklGN1dSSW5TT3Vub1BSOVY0?=
 =?utf-8?B?dkl6MktzNjdUYjM1SGNoaFV3RHZyVnJhdzZaNEtuaFM0TlQ1SFA0RVNHZVZR?=
 =?utf-8?B?MkNDNDZTdjNNcmlPTGZHOTNITU1yRnZOMVcxakNEN2FWdmFpN2pUUWlmSkV0?=
 =?utf-8?B?V2xtc1JIVzYyZHhFb2duOEJ6RkFFT1g0Y0NJaVFiMHRoUnBNYkhoaHAxMEky?=
 =?utf-8?B?dmx1V2ROQkxGb1ZDWHdnVkNEeWNtZEhDVXNOYkthay9rUmgzek5WQURMRnJQ?=
 =?utf-8?B?VXVCMjNFUlJ6QlRXb3dudDBubC8vcHJFc1dhbnFYMmVwN08wSDA0U09JUEo3?=
 =?utf-8?Q?D01sVeOYONw2Vi4Nrb7XJVNATPGCTqe26uiwk+0kOhlv6?=
X-MS-Exchange-AntiSpam-MessageData-1: nKV2rTcnFyDIfw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21f72a2e-8342-445c-7379-08df0440fae4
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 13:42:04.6915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rtv0sNlY0oWt3bP0N/Sht2HsFDp4+5xQspUKnGHYnkLHM6NCkj/4nxHiVdZXgcSHnoOxowe5Vf8hhJEu6xL9Rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5764

On Wed Aug 19, 2026 at 8:09 PM JST, Gary Guo wrote:
> Previously `register!` defined registers can be used on any untyped I/O
> regions. With all users specifying their desired register type now,
> propagate the specified type and restrict I/O access only when type
> matches.
>
> Also, add an `io_project!` example which is enabled by this change.
>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> ---
>  rust/kernel/io.rs          | 13 +++++++++++
>  rust/kernel/io/register.rs | 55 ++++++++++++++++++++++++++++++++--------=
------
>  rust/macros/io/register.rs | 34 ++++++++++++++--------------
>  3 files changed, 68 insertions(+), 34 deletions(-)
>
> diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
> index 84dd876b3407..4542187d6b91 100644
> --- a/rust/kernel/io.rs
> +++ b/rust/kernel/io.rs
> @@ -1692,21 +1692,34 @@ pub fn project_loc<U, L>(self, location: L) -> <T=
::Backend as IoBackend>::View<'
>  /// The syntax is of form `io_project!(io, proj)` where `io` is an expre=
ssion to a type that
>  /// implements [`Io`] and `proj` is a [projection specification](kernel:=
:ptr::project!).
>  ///
> +/// `io_project!` can also project to subview of registers defined with =
[`register!`] macro.

nit: "to a subview".

<...>
> +/// Helper function for register alias implementation.
> +///
> +/// This is used to enforce base matching. Only called during const eval=
.
> +#[doc(hidden)]
> +#[inline(always)]
> +pub const fn alias_offset<Base: ?Sized, Alias: Register<Base =3D Base>>(=
) -> usize {
> +    Alias::OFFSET
> +}
> +
> +/// Helper function for register element alias implementation.
> +///
> +/// This is used to enforce base matching and provide bounds checking. O=
nly called during const
> +/// eval.
> +#[doc(hidden)]
> +#[inline(always)]
> +pub const fn element_alias_offset<Base: ?Sized, Alias: RegisterArray<Bas=
e =3D Base>>(
> +    idx: usize,
> +) -> usize {
> +    build_assert!(idx < Alias::SIZE);
> +    Alias::OFFSET + idx * Alias::STRIDE
> +}

You could convert the `build_assert!` (always good to eschew) into a
`const_assert!` if you turn `idx` into a generic parameter:

    pub const fn element_alias_offset<
        Base: ?Sized,
        Alias: RegisterArray<Base =3D Base>,
        const IDX: usize,
    >() -> usize {
        crate::const_assert!(IDX < Alias::SIZE);
        Alias::OFFSET + IDX * Alias::STRIDE
    }

You get a better error message, the const parameter is used in a
very controlled environment well within the expressive power of const
generics, and that function is not public interface anyway.

If you don't like it (recent discussions make me think you might not
:)), then let's remove the `build_assert!` and keep the `static_assert`
emitted by the macro until this patch; it's not as elegant as checking
the condition into the same block of code that uses it, but again we are
in a controlled environment and static_assert > const_assert >
build_assert so this may actually be my preferred solution. You can
document the invariant in `element_alias_offset`.

> +
>  /// Defines a dedicated type for a register, including getter and setter=
 methods for its fields and
>  /// methods to read and write it from an [`Io`](kernel::io::Io) region.
>  ///
> diff --git a/rust/macros/io/register.rs b/rust/macros/io/register.rs
> index 2fb48e1be82d..cb02e850b23f 100644
> --- a/rust/macros/io/register.rs
> +++ b/rust/macros/io/register.rs
> @@ -140,21 +140,23 @@ fn parse(input: syn::parse::ParseStream<'_>) -> Res=
ult<Self> {
>  }
> =20
>  pub(crate) struct RegDef {
> -    base: Option<Type>,
> +    base: Type,
>      regs: Vec<Reg>,
>  }
> =20
>  impl Parse for RegDef {
>      fn parse(input: syn::parse::ParseStream<'_>) -> Result<Self> {
> -        let base =3D if input.peek(kw::base) {
> -            let _: kw::base =3D input.parse()?;
> -            let _: Token![:] =3D input.parse()?;
> -            let base =3D input.parse()?;
> -            let _: Token![;] =3D input.parse()?;
> -            Some(base)
> -        } else {
> -            None
> -        };
> +        if !input.peek(kw::base) {
> +            Err(input.error(
> +                "a base type needs to be specified for `register!` invoc=
ation with `base: ty;`",
> +            ))?;
> +        }
> +
> +        let _: kw::base =3D input.parse()?;

IIUC here you can avoid the peek/parse and just do

    let _: kw::base =3D input.parse().map_err(|e| {
        Error::new(
            e.span(),
            "a base type needs to be specified for `register!` invocation w=
ith `base: ty;`",
        )
    })?;

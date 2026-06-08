Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022083.outbound.protection.outlook.com [52.101.101.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38B228469F;
	Mon,  8 Jun 2026 23:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780962781; cv=fail; b=Q+6oh6jxN3YjuZZIRvXrFiWAL4WkiMMSesG6eUmM+w4zuu9aDcox6713B0ZAH+ylbPAN9twTfRIXAa4fy0OTfKJcHLY0HuDgGZJpeJSuaAqJXvVj3Be0X35554r2NMqj5DkZ/6GYMmYTwhXfARWUafFOCD/lZc3YB7AYjtjzIp4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780962781; c=relaxed/simple;
	bh=tmdYm0vw4RJ0F5vDwFhy08ek5WXAhFUquStCNg3KOX8=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:References:
	 In-Reply-To:MIME-Version; b=W95oVe4S514S9URHHvPt6FWKrjqhdrTjSPNm3/MZl8XGcQdoCfRbrcsfJr07E+0nRgX3zYygwAQO4JVLIYiWg5oEYb0QJPbcYCZyZj6/2c6IB0O0CXdRAzQu4zL1M5MRHLmXyxnY5tm09eOMtMAJHoM6dCo4WGWFGzQ1Q7bcw2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=zxKbCeEX; arc=fail smtp.client-ip=52.101.101.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="zxKbCeEX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aVffxSPb+uXBsyCG518L3ac6Ik6jIVwJO2kq5xHcs41HOKCzHPBGFJY1WumcsngRGJlJC45x9bw158S5bB4JBmjGoKaSzKmLUiijQISOSIIbO7DmfPl7nHdjhTvIskFXxwr5uiTARigWNi6JzlqoJM+YfrJmpdEPvoBhbi9aCLS8bmo7ngf78yBwjzv5XxttTTR5ZmKyxi6MRXOND/VYohhv4cbbCgSNMo2jkUqGOgtmNMekxM3uVgKwKCXjU6t+bmbbifZ4JpIX+FtCrPoz9Yd3Xsw7SveuSy/5AU58Dpdp1KmHpMtWk9Dyu/U8SRozyw6VgcLnE/a1CmgURv/P2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VsousIV1EWT/vc6TdcuQLfDln7H+bQO2fRvOPZMEZUE=;
 b=zQPGg+V+9sSq3aPI9YVkg3nWd1j5WHsKzG5+UHM8rDXVKAtX5mGU8y9EsZA5AY6+vifKhk76sEYrAO04EH+mrRcB6K42tkWPB9O8xxEoQkd/rTBwSAxoF5qCWWvl++Lousw0/mvp+FmdxZqypd/gzp+fvpYG7AGo/3oROvu1nbLeXA7kll8GrdWnjJzT0IAzID8xUX3jVxYu+ZJmYDjDSDcOyHwaxRc9TcAesg08g9NGmZfwkdf4BGivz0NOGXGPLeVGvoXZF56TMABzLQNEtrSWiM31cK+UzaHiYDLLvcqqZdjbo1EoPZ5XWldjWoi10Hc4nXsutewTpYmOAy1LYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VsousIV1EWT/vc6TdcuQLfDln7H+bQO2fRvOPZMEZUE=;
 b=zxKbCeEXlKAowZ1vthfzMKC4rKjU48QsxCJRfo/yHrELEn1RSbP9EGCZd0SOF5clBGFzdDb6WUxpTwVL1gziTG1IbMPH6ZE+HdyhEwj1PPtshwz/Kfr80deZ6J6MQzadwWMQy/OJJKLnw+QFU0DCAD1baY778tmtYtAukgiBdws=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO9P265MB7567.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:3a5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Mon, 8 Jun 2026
 23:52:55 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 23:52:54 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 09 Jun 2026 00:52:54 +0100
Message-Id: <DJ42M3IYBE7R.3TXIL5DHQ10LK@garyguo.net>
To: "Gary Guo" <gary@garyguo.net>, "Danilo Krummrich" <dakr@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Abdiel
 Janulgue" <abdiel.janulgue@gmail.com>, "Robin Murphy"
 <robin.murphy@arm.com>, "Alexandre Courbot" <acourbot@nvidia.com>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>
Cc: <driver-core@lists.linux.dev>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v3 01/19] rust: io: add dynamically-sized `Region` type
From: "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.21.0
References: <20260608-io_projection-v3-0-c5cde13a5ec4@garyguo.net>
 <20260608-io_projection-v3-1-c5cde13a5ec4@garyguo.net>
In-Reply-To: <20260608-io_projection-v3-1-c5cde13a5ec4@garyguo.net>
X-ClientProxiedBy: LO6P123CA0053.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:310::18) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO9P265MB7567:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c7e1bfa-817a-4178-e9a4-08dec5b90f13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|10070799003|7416014|366016|1800799024|4143699003|56012099006|6133799003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	he79nTIiU9wGand8BJU73FsbktkfqQdIYK3jr7XO48zgtYw/exDIWMXeUwbpUDMU4lw8NYdAJjYY7TGr4ac/pllbl6YsywJFc88hsAU50v6jvI3kFG8yt+WzB++6gqDKuLbWIj1K82ZEeNmaReJv4N1iYH9D9Yzp9RKxoe3vN1T0793G0i8DmX0SFyi61kTXQEblq78LCNCTcmUkqHPd1iwPukVzpAEcJrNqwYWoz2HTqGAUwHLtU9j7Kx4sBfw3dZxrBUog/HoFHicidTszrXW9lsZ28sex0Q6hDBwHBnujPWXL/yJppQbLuO5NyGHxn71iyyXxx5oMUd6EdL1DrrKfKI2aiWdZ2KsuN0ewHboj5tk6f+51B6watiSWGWW3VIQG0KZVyEztcDcNMpHJ9Li33uXMyd9SpkLiEoeXzISu/zNWBunOXN11BIt1IENS7oGcPHyqDg6gL/rgsauzWq9OaJXpiN3m2CfJ1TKERFkmekMYT/IOvPVKHOeZmuHA0WzY9q4vuAE16mcCSvOe8JKE3HedI1L5qiLplHVqzXtZmbAqFDcuENTQGGBre7QPZsqQdXpnMqtVcr4lEj2mhG54ThNMWLkr7SZMOSNnQeUYTW9h2Gf6z0h43/2mUB1Yx0pJ8IaqlVgPiVD+H6kok+hTyeun3alAhqnVnl+F08rTetUsoiYMi78UBRCuW0TGMVQnkVmh+5ggYPGgE3E7JoKPM7WtOKCcrVZtQo1lemE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(7416014)(366016)(1800799024)(4143699003)(56012099006)(6133799003)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eDIvTUJRaWFSREt4a2ZPa21BdXJ4UEFVeXRCTlowOHY5SStrU3I5M1AwLzUy?=
 =?utf-8?B?SlRjeFhpOHVXMHhyVFMxWURTcjh0NG5KZE9ZdGxTSXpUKzlISmZBQ0NtM1la?=
 =?utf-8?B?RXI5VW5LU0ZCcHc4NSsxRFU4L0VrM3FjKzMzUEZ4UnhXMWZFd0E4SWt0L0tZ?=
 =?utf-8?B?N2szN3J5QzFHY2xJeXN2emVNQTY3Q2tQSkJuVkZSSTJWM25LK0UwVGFIK3ZZ?=
 =?utf-8?B?R1Y5RmRsVUFNVkRyQ1dxNHB5S0V5d3RGKzdseDQrN2Nsbzl6UVNSVkYraEFy?=
 =?utf-8?B?c0FYZ2k4U2NHdU1EeE5CUGIyRGtsY3QrS015SmxBNkxDZGJhUVkrSWRsczYw?=
 =?utf-8?B?WnQ4ZE85dWErOWRsUmdtQzhhdlpFdEM1ekY1K1U2d3BvTkxKV3V2a2NoYzFR?=
 =?utf-8?B?OEVwVEVhWWVLSG1yZ0NMUFFmRDFyK0IzdjN5eGwydGJlaUE4ZmpMM21DYUdZ?=
 =?utf-8?B?Z1dVcUVBdlJBaC9ZVncxU2ZVYmx5bVcwWVpVMXpOaGRwQTFtbWtOYmtDU1hq?=
 =?utf-8?B?TGxLV3hyelBCYSsySVZzN093WU1aTndPeXRVb3BLNSszd3QrL0lIQjhiNEhw?=
 =?utf-8?B?Tm5tWVJFZW5iK0VOV2E2MUlCVHNyeDF2WE53UUFuc25oQjY3YzF2bTZiRWRT?=
 =?utf-8?B?R0RBN1E2MWRpeUZNa0EzMXZhWW1CUGNvMWp3TFhMVTdHR2NDNUs5czFDVitT?=
 =?utf-8?B?L05aS0RhWjlzaFVCMXE2eEtVT1c4YXQvaEZXK040R0JNZStYNkRYWDZLdm5J?=
 =?utf-8?B?bmI3OHZLOTVaaHczcWMxTHdzUUpZcE9sa25hMFBJbjZCN1hLR3JmejBzSEk1?=
 =?utf-8?B?MUVkcVp2ZmsvOGJ3SUg0aDdMOURqTUg1dGRBeGc0K29lZVNzUmIxQlNaVEtZ?=
 =?utf-8?B?eVUzOFp2T29ub3RQMkpFQndxSTVoRFlkV3lWOTRSYnh3TXd0NFlZVThwUXpM?=
 =?utf-8?B?aFRhNUYvQThZb3lyenRMclFKRklYT2RFeDFlbkN2d1J0SXh1UXRsNWsySjZ2?=
 =?utf-8?B?d1JIdEpMenZ0dC9xOTBEOWQ2enNUTE5XRnVtL0thcjd5cXhpbEJ2ZFo1a1NP?=
 =?utf-8?B?dFZZallUY09UbG1TT2xpUUJyUkZGeExhbnhJVkZaVDljRWtwRkJHQjhMR0JZ?=
 =?utf-8?B?ZEExNllyNnk0aE1JOUhIRzlLdGNOZm9hWEViVTUzVmdyamN4VElwSzBsYmxp?=
 =?utf-8?B?N0xRbzZsaTloM2VPSWxOMnJLSHVHRFlVODJvR3FMWWFnWmpVOFdoNlZ1d0g4?=
 =?utf-8?B?UlZyMWU3VWhIRTFGSnlJaTQyLytlTi9aWnNlL2wzWElRYVlYVHUyQmVXanR2?=
 =?utf-8?B?MFBJN3JRRmh3dXRjaDBBbDR4cjNURkF1ams3Mk9MbHVmSnQ3bmkyUFdjbmNN?=
 =?utf-8?B?Tk9oK29hbnpqRDBZRHpobzJQZGNTZlZvZC9KRFJnUVpKTXZ4ZEhucUhIM3Ra?=
 =?utf-8?B?WGZqN3hmVGoySFVucTBKTEJRRFVJWk9OZW02YWNQcCtOdnU1R3UzSURXbTdh?=
 =?utf-8?B?QVd2NitVbldtVVgzdnEvZVB1NUR4Q3ZVeDdGVFJVcE9vb2RuTllnNjZ6Z0Fv?=
 =?utf-8?B?VXJzU24rTVVHZ1hWNFZGNnplTE1QY3FMWVQvMWJLSDRnSDdmY3JaZVlZY2lz?=
 =?utf-8?B?MHhVNHIxY1hCQWw2MDdleFdzNjRUdkw2SDFvZmMrd1VpcEw3MkNHZGRDZ2xw?=
 =?utf-8?B?aHpHN0s2bk5ETjNlWHB5Nm1jOHVJdjFQY1JlMTh2SWpadDBHcWZtK3VvdUZP?=
 =?utf-8?B?VzY0Mkh1TFNkUTV6U0dwV0drQ2xucTlqeGFabXRlenhlZ0tYRkYxU1N1WGJV?=
 =?utf-8?B?RXJWeml4dHE3SGdKOEhDa0UyRmVzL3pYU2kxTTdITjNDVUtHTWJxVXBtV0t2?=
 =?utf-8?B?dzVmVE9sRDZWSDYzamRGQ0VvYm9RdlllMHNwSE1vV3ROUVRkZkYzV01yNXhp?=
 =?utf-8?B?L3gyQ045Rm91QTFaYzNkQlRJVldTdE1BcGZSMU5wQ0ZtYUdBV2NiTW1xYU5k?=
 =?utf-8?B?bGE0M3lyOHdmTmRwMWFESDczdGpScGRLbkRDSUswN0Mxb0M5ZWM0d2w0TUVu?=
 =?utf-8?B?dFdFZmQ2TlBCa1gra0p3MHpnRlBOd0dIQ2N5bEFSS1dBQTdrblJhTWpRWE5S?=
 =?utf-8?B?L25iSWF1QUF6MW91WkdicTFuU2JNSXdHUm9CRk5tM3EvTWtVY2dhUkg1MWRV?=
 =?utf-8?B?Vk03VTE1UXhjb2x6M1R2eE1rS1VVb0hkY1NJekxtck9zRnJSY1pkd2dNMW4w?=
 =?utf-8?B?aTlFN2gydkRBN0tjY0pvMVBhejFzaER4elA3eDAvN2tRVHd0TE1BTURSTmFw?=
 =?utf-8?B?bm1LT3JhSWRVOWlaZ2RJMDQwR25vZ3JYTllRSmg2SmJCVjk4YlNvZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c7e1bfa-817a-4178-e9a4-08dec5b90f13
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 23:52:54.6942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lrWgfFs/V6ZTz3HusxTgXDCMN23iXBE3h77xECGkn08diSSD5eWj9NAMNrvVWaUoqktoAUBh2kkn8hbtbN/3dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO9P265MB7567

On Mon Jun 8, 2026 at 8:58 PM BST, Gary Guo wrote:
> Currently many I/O related structs carry a `SIZE` parameter to denote the
> minimum size of the I/O region, while they also carry a field indicating
> the actual size. Proliferation of the pattern creates a lot of duplicated
> code, and makes it hard to create typed views of I/O.
>
> Introduce a `Region` type that carries the `SIZE` parameter. It is a
> wrapper of `[u8]`, which makes it dynamically sized with a metadata of
> `usize`. This way, pointers to `Region` naturally carry size information.
> This type is required to be naturally aligned.
>
> Expose the minimum size information via `MIN_SIZE` constant of the
> `KnownSize` trait. Similarly, expose the minimum alignment information vi=
a
> `KnownSize::MIN_ALIGN`.
>
> With these changes, it is possible to add an associated type to `Io` trai=
t
> to represent the type of I/O region. For untyped regions, this is the new=
ly
> added `Region` type. Remove `IoKnownSize` as it is no longer necessary. U=
se
> the same mechanism to indicate minimum size of PCI config spaces.
>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> ---
>  rust/kernel/devres.rs |   6 +--
>  rust/kernel/io.rs     | 131 +++++++++++++++++++++++++++++++++-----------=
------
>  rust/kernel/pci.rs    |   1 -
>  rust/kernel/pci/io.rs |  40 ++++++---------
>  rust/kernel/ptr.rs    |  12 +++++
>  5 files changed, 116 insertions(+), 74 deletions(-)
>
> diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
> index 11ce500e9b76..ed30ccc6e68e 100644
> --- a/rust/kernel/devres.rs
> +++ b/rust/kernel/devres.rs
> @@ -68,7 +68,6 @@ struct Inner<T> {
>  ///     devres::Devres,
>  ///     io::{
>  ///         Io,
> -///         IoKnownSize,
>  ///         Mmio,
>  ///         MmioRaw,
>  ///         PhysAddr, //
> @@ -297,10 +296,7 @@ pub fn device(&self) -> &Device {
>      /// use kernel::{
>      ///     device::Core,
>      ///     devres::Devres,
> -    ///     io::{
> -    ///         Io,
> -    ///         IoKnownSize, //
> -    ///     },
> +    ///     io::Io,
>      ///     pci, //
>      /// };
>      ///
> diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
> index fcc7678fd9e3..dcf3b40ffa48 100644
> --- a/rust/kernel/io.rs
> +++ b/rust/kernel/io.rs
> @@ -6,7 +6,11 @@
> =20
>  use crate::{
>      bindings,
> -    prelude::*, //
> +    prelude::*,
> +    ptr::{
> +        Alignment,
> +        KnownSize, //
> +    }, //
>  };
> =20
>  pub mod mem;
> @@ -31,6 +35,59 @@
>  /// `CONFIG_PHYS_ADDR_T_64BIT`, and it can be a u64 even on 32-bit archi=
tectures.
>  pub type ResourceSize =3D bindings::resource_size_t;
> =20
> +/// Untyped I/O region.
> +///
> +/// This type can be used when an I/O region without known type informat=
ion has a compile-time known
> +/// minimum size (and a runtime known actual size).
> +///
> +/// This must be naturally aligned to `usize`.
> +///
> +/// # Invariants
> +///
> +/// Size of the region is at least as large as the `SIZE` generic parame=
ter.
> +#[repr(C)]
> +#[cfg_attr(CONFIG_64BIT, repr(align(8)))]
> +#[cfg_attr(not(CONFIG_64BIT), repr(align(4)))]

I've made this aligned to `usize` so the build-time alignment check can wor=
k in
patch 2 for all I/O sizes.

However Sashiko points out that MMIO base could be 4-byte aligned and not 8=
-byte
aligned, which is true as some simple drivers (e.g. GPIO) can often just io=
remap
a very tiny 4-byte aligned region but isn't word-aligned.

So I'm going to make this unconditionally `repr(align(4))` in next version.=
 This
does mean that if you're using `register!()` macro (or just old fashioned I=
/O on
untyped regions), using one of the build-time accessor methods would fail f=
or
`u64`, as there is no way of knowing at compile time the MMIO region is 64-=
bit
aligned. Thus, `u64` can only be accessed via `try_` methods once that chan=
ge is
made.

This doesn't seem to break Nova or Tyr, so I think it s good short-term
approach. If there're users that require 64-bit register access, then we mi=
ght
need to create 64-bit aligned regions.

Best,
Gary

> +pub struct Region<const SIZE: usize =3D 0> {
> +    inner: [u8],
> +}
> +
> +impl<const SIZE: usize> Region<SIZE> {
> +    /// Create a raw mutable pointer from given base address and size.
> +    ///
> +    /// `size` should be at least as large as the minimum size `SIZE` to=
 uphold the type invariant.
> +    ///
> +    /// Just like other methods on raw pointers, it is not unsafe to cre=
ate a raw pointer
> +    /// that does not uphold the type invariants. However such pointers =
are not valid.
> +    #[inline]
> +    pub fn ptr_from_raw_parts_mut(base: *mut u8, size: usize) -> *mut Se=
lf {
> +        core::ptr::slice_from_raw_parts_mut(base, size) as *mut Region<S=
IZE>
> +    }
> +
> +    /// Create a raw mutable pointer from given base address and size.
> +    ///
> +    /// The alignment of `base` is checked, and `size` is checked agains=
t the minimum size specified
> +    /// via const generics.
> +    #[inline]
> +    pub fn ptr_try_from_raw_parts_mut(base: *mut u8, size: usize) -> Res=
ult<*mut Self> {
> +        if size < SIZE || base.align_offset(size_of::<usize>()) !=3D 0 {
> +            return Err(EINVAL);
> +        }
> +
> +        Ok(Self::ptr_from_raw_parts_mut(base, size))
> +    }
> +}
> +
> +impl<const SIZE: usize> KnownSize for Region<SIZE> {
> +    const MIN_SIZE: usize =3D SIZE;
> +    const MIN_ALIGN: Alignment =3D Alignment::new::<{ size_of::<usize>()=
 }>();
> +
> +    #[inline(always)]
> +    fn size(p: *const Self) -> usize {
> +        (p as *const [u8]).len()
> +    }
> +}
> +
>  /// Raw representation of an MMIO region.
>  ///
>  /// By itself, the existence of an instance of this structure does not p=
rovide any guarantees that
> @@ -85,7 +142,6 @@ pub fn maxsize(&self) -> usize {
>  ///     ffi::c_void,
>  ///     io::{
>  ///         Io,
> -///         IoKnownSize,
>  ///         Mmio,
>  ///         MmioRaw,
>  ///         PhysAddr,
> @@ -241,12 +297,25 @@ fn offset(self) -> usize {
>  /// For MMIO regions, all widths (u8, u16, u32, and u64 on 64-bit system=
s) are typically
>  /// supported. For PCI configuration space, u8, u16, and u32 are support=
ed but u64 is not.

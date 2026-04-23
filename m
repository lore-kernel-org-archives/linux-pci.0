Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020079.outbound.protection.outlook.com [52.101.195.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF091FC8;
	Thu, 23 Apr 2026 11:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776944086; cv=fail; b=k6p3Q78s4iOJGm9SBtOg0of1pZ99X6Q7Cw+bYjbdavCMIeTIhjlE/slQtwvSIUGqod45vEfemXAYOpngcDJ+HQKb4iR0nHFNzRoUwsjNBzHrLk9Boi6IFNHAbp+PSVTIur/2PI/SYk2KSPArtrekepQptpuxkI99C6qyttk96R0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776944086; c=relaxed/simple;
	bh=lMDNDe5CGVrtCAo+Pqv0CHn2z/EIBB0kThPUnNgO9Ws=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=nNJzSZbJ7Vf3+XKgFRcdW1DUQ8V8cVYcIC3T4tuNkBL8BOoCIfUrhXLH6umkuDdvCMIe3HpzKA3yyP3PYrLb66XTgvrly/1A4AuES92GBk2Dv261vFVUQrlTv4o+Pu4o4mzGFbwHX6VZUyy/F8cn1DIh5ODFydxVJG3srnpsQCg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=tTFsGxiv; arc=fail smtp.client-ip=52.101.195.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="tTFsGxiv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d8HC/UMaKQIaiYAK9ehiBlBSVYRmXqspVhFEIHgsiiC8T9GxXuKdSo7EdB5uy94AW7WnEpMyOP1jnf+SNm+6PGxc0kv7+nEUxJE+/6hUwNEZ/39wNV9eLXgz6W5n0sXhVl+wQWmInHRRxUduEysLji6IWZd5qgq1D8WC9VFXi+8ccL+OO30MKqGnNR8Yd2ruaVHnTFaQ3zStPh6dSdeT/QJPO9apbIuVKhUrPx/uxzLEBwsUYaQM9i5v9YjqZeAGVhXZ7yAVNofYRTLvVDDiEgkc8bVPEBMY4urUBf8HL+dulqa60a1WMdUUMEVzK72BKl2I8gyUZMi8VQPbuOFxtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c7DplJiGF3GFUHZwQB9/ZjsSCLIFOsIFt5Q424beC5U=;
 b=jX2o6Y6RdYdwLFhI+3ZRD90aySDqmsZaFXp+vTRhmZhGxOcBrw/oQVcGNN5v+ctwDIWcG5apvIpjlaDiCZVsnQQmPrS3la5vHD+8/C7Lx8HqTr4c6HXpNNl4L7EEpP+Twp/CqeR+f3PH+vS3PiwOQ9mTT5TrPcJKkXmpu1deqKI33oZYfvpuEVzP6Daw6Pp2M+sfvgktVEJYQJcIJYajDqmBGyMmR9f1znuHFYiBJ2wM/0y33qgxcU4mWkn6eR1PN2d8OzKOD/yxBBMMQq+mXrgZgdmG6u/M8MB+bu7DKa+tPyNl5yAZiFhe+VM9zFy4k30kTL+OEWLJXYdLNBDyCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c7DplJiGF3GFUHZwQB9/ZjsSCLIFOsIFt5Q424beC5U=;
 b=tTFsGxivf5dWYm2kIha8869MgP3HgkRQDcAQzA2Je8AvcH/vTkLiMy/OXdxVmqe1/C8J5hoqoONLNjKaTr+2M++e0AQXUQkUkEWYiCaEy5vvWWuPrFJPuFqZwYwm2zZDetyvSSnV0EPKhDYX7O5A6F65RGqvGgc+8JaP2HctSmE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:27c::13)
 by CWXP265MB5180.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:193::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Thu, 23 Apr
 2026 11:34:41 +0000
Received: from CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c9e:93c8:10db:e995]) by CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c9e:93c8:10db:e995%6]) with mapi id 15.20.9846.016; Thu, 23 Apr 2026
 11:34:41 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 23 Apr 2026 12:34:41 +0100
Message-Id: <DI0I3TH8B8ZZ.2118S8MDUHG@garyguo.net>
Cc: "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Joel Fernandes" <joelagnelf@nvidia.com>, "Timur
 Tabi" <ttabi@nvidia.com>, "Eliot Courtney" <ecourtney@nvidia.com>,
 <nouveau@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v2 1/5] rust: add warn_on_err macro
From: "Gary Guo" <gary@garyguo.net>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Bjorn Helgaas"
 <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Boqun Feng" <boqun@kernel.org>
X-Mailer: aerc 0.21.0
References: <20260421-nova-unload-v2-0-2fe54963af8b@nvidia.com>
 <20260421-nova-unload-v2-1-2fe54963af8b@nvidia.com>
In-Reply-To: <20260421-nova-unload-v2-1-2fe54963af8b@nvidia.com>
X-ClientProxiedBy: LO3P265CA0002.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:bb::7) To CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:27c::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CW1P265MB8877:EE_|CWXP265MB5180:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c8d6c5f-370b-4857-ed36-08dea12c4f7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|10070799003|366016|1800799024|18002099003|921020|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	dmnucVv3RvQrvaiFg1A12ABJC5zaKu7Olgf56p6jOVIAUBb3p5yFwzohBIrHWBDv30MaZBSEuCoWCnmurdaWmhQh75sCgV/5LELw2mEmvBxggBB4Xss9h0k3Dgb+G2x6WekhWnLmHkguFQ39cUSxpgx8pL3BfdLcGqEjzM654qBwgPlHs0H7ijcIP3bXVp1TD2W4cl5XdDIRW3a5x+QmzLoUH7LiyQzrHziw71ch3ypR5V5hHAKWzgR3wxGdkCZ15OISnE+/sbxNX2bZOi3VpMaoolrcAjFm962zExnOChxBv4UMpVkD1Q69SUHPr0jbLjdHhtgBSpmvfoR1momdOhGcfGa8+ihKIqn3BcYZyAny+2HythvrXJCox3eF3Y/HEpvX1H1ojAeQgWsKT4YRq5W3Cx2Fx4tdCi5FmV0OwqhXvwn+fgb1WJTzEGJhPzcKDaimy/SFLz1Kw7Eq/yK1ORoWhMDXSCb3A9eIzhiE1H5ZUiRnm4A6vA4W5wqbxX4pSbkl91Jv4h/K0p6UGGAtrdQ89i+tEuCz4g/ZQrUpH1LgQ1ar93bHW+VXZ8pvvqIgLakWs3gUGLnqRjcf+uLNruxWwdnb9g9lgTxdFHaYpMuCg6++BDCglH4WUhZAfxBVBJKtKti3nrOtKDNFhpKIQSVMrq+S5ASxd6+Y6rQkY/Dv4DUaYUDybEIR5t9eSB1NOUFWe02WSf362lln7nmCnMtTp6+IUzYymYMDgupG0x1qxdfECxjYXLXV4Vm19+Kccmh4zE/ol+9Z2o1J+u91Uw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(10070799003)(366016)(1800799024)(18002099003)(921020)(56012099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YXovTTJsTGI3M3BpblZxSDg5a3drT2RiZzFjQnBmRFBDMW9zNWVDa2xZYzhw?=
 =?utf-8?B?cFJGUDluUzgyNjExQ1VqVnpZTHErSHB5anBYVy8zYUI4VGRkQ3ZjOEVBMkIx?=
 =?utf-8?B?Wml4SFBRWi9rRVNHbE1XZEhNSVMzaFkwMmxseDZxenhUc0kzbHhDZlFBb01n?=
 =?utf-8?B?YXVwb282dS9UMFAzZW11b0UvYSs0TmVsQ282aXJHUXlNSVNGeFZYUWowcFJJ?=
 =?utf-8?B?aVZGaUIzVUkrM1RIUDJqOVhkVlZBMEhZaEpDTHZmaWdwMm5KeTNoUGZNVzlj?=
 =?utf-8?B?cDF0SVdMUkhxNjF0RHpGZjhocW40NjR6eGxIZXE1V09Ub0FRV1FlMVp5cHpF?=
 =?utf-8?B?NXBYbExzcDBVZDJaMWpIMDI2cGF2ZlVBWTIzQ0lCc2FFSytJNktZVndOcEFZ?=
 =?utf-8?B?YUN2MzFXazNJNUZnVTAzOTBYZmE0SklJZmxTRzArKzZMakJoUDZBbkg4ZVRL?=
 =?utf-8?B?YWJDc1Q5S0VyVmhJMzZGWE9vTm5UUmYwRXNiRURXZk92ZWV0VlJLWXdubmw0?=
 =?utf-8?B?UXJSK0J2SldONk4zTjBKaXR4TEZYNFVHK0I2dzVpbDdaMTA4R1pOSUJZSnVP?=
 =?utf-8?B?WjV2L2dEMWJSejVndHpQai9LR2dKUDhhSTY5TGVoVWU2bGROeXhxRk5tZ3FP?=
 =?utf-8?B?YzFqZHVVRFVzNEwydFdWUHNIWllqUVhDSGtIZTVYQXYzOVBBK01XZ0FqYk5v?=
 =?utf-8?B?dHFPV1RvUTZuZlRScGhEV3gyUUNCMVBFc2tyODdvcG90SUYzeDFybUc1aW56?=
 =?utf-8?B?TEd1Y25FS0kxMkIxNHBqeHlscDdHVmdQVkl5SFRPeFhWSlFOMzdid09KSytS?=
 =?utf-8?B?VnI5NFVTVHBwWlB3bjU0OTNlb21rOVBoclRCcWJ5enBRRDdyVzYzM0FPY0dx?=
 =?utf-8?B?RVlaUDZwa0hRRDRLZFdDS0RZaHRrNEg3cVJTQ2ZKbG9tSGppWW52YVFnSkVG?=
 =?utf-8?B?OHZiVm5sQzJWQ1RwQ1NydWhTVk0vejVQUTg2YldBcFBkQWE4Nkx3NW9DcnlZ?=
 =?utf-8?B?Y3NyRldubWpVWk51cm42VDY3K21oSkNPTlIrYXZiUWwzbHY3d2NaeFprVzBO?=
 =?utf-8?B?VFM0OFJLZHpOZ0QzZTJZeWUwdVF5M0s3L1NlUXhmZEl0UllPN3ZkblNyTHpJ?=
 =?utf-8?B?WE9hVmJtM2NHRCtYR3ZONGhvbUxuUkorRnI1NUlMMk9qV0RQd0tSM0RJZ0VM?=
 =?utf-8?B?WnFpNUsvSm1jUTZKd0xOaFFReUxXNVFnMU4yVW1EMjlyWmhYQUpYUE1nYmIx?=
 =?utf-8?B?TVlKaDB1MnczdzFSWnNnQVU0RlpOOEZqSlE2VjlDRmZyRW1uWW51TzRXZWJD?=
 =?utf-8?B?cktIeXhENmtiNThqeDZ5Y1NiWXYzaE5yTmFiVlVJdzA1R3VoNXhMUldmbklO?=
 =?utf-8?B?czd0SUVOOHZOcCtubVNVSUg0S0hJZWZ1N2orOXB3NSswQWUvYVEwdmQvU3pJ?=
 =?utf-8?B?Y2VTcG02VDROM09TWnRQYjkwSG9XN3FQMFpPSVQrZ2FOWEVVdlczUy9nRkR5?=
 =?utf-8?B?OUxhN05tVm1jbUZ5d05ScmVhbFVwMi9lanJIc2Vob1l4Yithak5ROG5yendZ?=
 =?utf-8?B?VUZJRVNQM25KS1dTc1VRNUhCdDVGUzZUWjhpUlB1SzE1Z3ovKzZtUkNONEha?=
 =?utf-8?B?Ni9hSVFkMjVyd0x5bG95cGxTeUREWFVhSndKN1N1TE1KVkorbkpPMCtOQTVx?=
 =?utf-8?B?dGYwN3ZQUjMrQjk4Qk0xQlBBMnYzN0svZzV2dUlQS0Y2V2U0SDQ0QXUrNFp2?=
 =?utf-8?B?QVBZUWtDbTRPM2QvNVRDckJkOG8wSUs2aGwvNjB1Y0VyMlowNWR1RFplaVJN?=
 =?utf-8?B?RWxYZWpGcjEwcEZjQWFsSEtiODF4eFd2WFF6WjhveGhpeU5Rbzh4L1RqOURT?=
 =?utf-8?B?a3NmOE1uelZNQU91Y1hLOWF1TFJZUnRFb0hkMUFmWDR3VVhBM2orUU1vZ096?=
 =?utf-8?B?S3RSL1FDN0RaaU5mZERrNzB1Z2oyNW1zcFgrNEV3S013aEErSW1MVVpWLzlh?=
 =?utf-8?B?eWZBcjJtZWdhVjVuWGk5eUthWUVGMzVqbE5VWHdmZ1MrQStqTXNPNVhNWTFN?=
 =?utf-8?B?Vkg5bkVTbWdNK3B5eTltT1pnQnZKSHRkellnTGJiaVFKK2NSaXM0bDdSNFow?=
 =?utf-8?B?Z0VaOXd6NVpJWUdaSWZoL0lOUGd5RkYyNUsyVHVYZ29acVlDQWVvTG03Q3E0?=
 =?utf-8?B?c3d2YlFLNWlVQWVWY0E5T2p4VW04d2t3cTVHelRobTFGVmdUa2FRM25zWGJK?=
 =?utf-8?B?Wit2c096TERkbjNKNG1HeFlwazNKWFdQZlJFcDJLQUllRzNCODhSU2tLM0ln?=
 =?utf-8?B?TFIwYU03amVKYjkxcXhmeEhibHBGMnMzcWRmMzcvVVRRb3VOWTRvUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c8d6c5f-370b-4857-ed36-08dea12c4f7a
X-MS-Exchange-CrossTenant-AuthSource: CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 11:34:41.8296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: us2Hgn3qe/+Fk7ICmqizx5qWCA0L++4sAN3Y0yBTfiorNm8isBkwvxsp88MukQrFwiBOCjTKwS76bFDV9ffz4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB5180

On Tue Apr 21, 2026 at 7:16 AM BST, Alexandre Courbot wrote:
> While we already have the `warn_on` macro, a common usage pattern in
> Rust is to check whether a `Result` is an error. Add a helper macro that
> allows this.
>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---
>  rust/kernel/bug.rs | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/rust/kernel/bug.rs b/rust/kernel/bug.rs
> index ed943960f851..2fefc0aeef81 100644
> --- a/rust/kernel/bug.rs
> +++ b/rust/kernel/bug.rs
> @@ -130,3 +130,13 @@ macro_rules! warn_on {
>          cond
>      }};
>  }
> +
> +/// Report a warning if `res` is an error and return it unmodified.
> +#[macro_export]
> +macro_rules! warn_on_err {
> +    ($res:expr) =3D> {{
> +        let res =3D $res;
> +        let _ =3D $crate::warn_on!(res.is_err());
> +        res
> +    }};
> +}


I think `warn_on_err` could just be expressed as

    res.inspect_err(|_| warn_on!(true))

Best,
Gary

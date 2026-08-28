Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011054.outbound.protection.outlook.com [40.93.194.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA52B3F1055;
	Fri, 28 Aug 2026 00:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787877515; cv=fail; b=aLGu9GkLHai0jdr/bx6cP8sp3+4G31kH2QMdJe1t4itVoJv6saudMNyHdy5OqDw+jlB82ANyX/hmO4Zk/yow8HhRb8KqZyvamVt7NYOp7Cm79hzeaH8aIZPgy/9g3/ZMqakol7FKSKibFzDOm6ipsRiWyVRa2PQ7Rc7FF8cHQvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787877515; c=relaxed/simple;
	bh=2zjM45m923oOGv14cv3JSNopxhcKtowCfuZMiWWT/bI=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:References:
	 In-Reply-To:MIME-Version; b=uUmPVMOIiw4Yn6/XAS+FdZ4hz9n5i2wxtkTQ3Ioc4ayhc5njuHA903rHB2ok5tL7DMoFtkIAeJruSxz7PwOQXiUUvaOXZz2d5uLTwO8uGhByU6NHI99uLk6JOYxkcMZH65vU9+5YhtqMaG+Xw5RFbm+FtqRcbbHUkxWS6mDx5Gw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=C2viTy3Z; arc=fail smtp.client-ip=40.93.194.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="C2viTy3Z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yRWmfIIlIqqfg+6Z9H4QuF9ycOr9gXkrCY/k5OrX49DnYFmleetDclns0bZAqwjQe0hO7IEo9N8sMe0hIf19WuWD3Ak/GvT1fLxaUoprKNCUl89on6ICyWIndsVOQYGTWB8Rz0vowmAHNfxpmzHHVnw8hMI4BD0xpZpV7KTrONGUmoz/TEMT7BiUsYAYDgkPVMD4/Xiw+1QnI9I51MvtxDEuDrfF2xAKLHwA/3EKlfhB0F53b0Xm1aqATogaS4VCvCovguEigfyvdTjRICi+v1naa/BjmEGpfFaUv79EfvQvjUNUNZ5JRxT4J+0Cte/U11OMpLKOTYeB0G529q1hJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1sCG1KwSUU35II1dx8Ov5yZmR1vxoANh8obCfo6moOk=;
 b=iz+VUBjPlJ4OWYUvyc1kNzuIKlsVR9QmejquDvruw+iCcQGSLUIHJEuiUT7mpTtX/XrFAS31fg8A8/MePj8mtuGced7BGj4Fz2S4efdC4wH2J+88ugvSGXb1L/IfnC/Jm0o/uaSHRbgJeHqUOHu3qZDmNgHn1DptW5JXnDVir5jEYY7lhzZe7hgthFHx6nUjJ9j8jrWYlx1i8GkgdluFrkL+63S/iWyJG5qT0elA+yGZGk0OxQgPm1OxaC3C7w7icuDr81gVBzlmGsSdIMtlx8S5FlDSOpFOFQkAct07IREnxnEbGfCHe2YHyQ3hus56WRIHvV2+cn1iGWxxRWUzVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1sCG1KwSUU35II1dx8Ov5yZmR1vxoANh8obCfo6moOk=;
 b=C2viTy3Z+LZH/4qi97Kt1n4NQxBdSICd+n6sbdmsffcVEr8iLH2/q0/ujF+rwUB0pkO8jH+SCcY+M9g0CFLwb7+QcXctGliMqn9j8lZk3cAvR87+c8I0oi5bFnFyv2PMjex6Mv05sk7CqagMADUq7iS7/7diu9mXJ60EO5i3DaxO/swLtPcDoC+FxWBRcP0OtMc4l7Ecl82wk+YeTE/hPNEyJAmWD1jHFeyxTZLCHPgGQIXrRLXdy7S0cyZXu+Ac0zH6krpj7x/FEikjUH8u5SYHNUzrRAlxjvfRFvAoGVz13oBeQH2Gxc1sAxr56SoZmvGCVlXJh2OQQYv83hiTBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by PH7PR12MB6000.namprd12.prod.outlook.com (2603:10b6:510:1dc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 00:38:29 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0315.014; Fri, 28 Aug 2026
 00:38:29 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 28 Aug 2026 09:38:26 +0900
Message-Id: <DL05OJNKFLI2.24DJRACWA723H@nvidia.com>
Subject: Re: [PATCH v3 11/16] rust: io: register: support fixed offset
 register without bitfield
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
References: <20260819-typed_register-v3-0-3699a75fadf1@garyguo.net>
 <20260819-typed_register-v3-11-3699a75fadf1@garyguo.net>
In-Reply-To: <20260819-typed_register-v3-11-3699a75fadf1@garyguo.net>
X-ClientProxiedBy: TY6P301CA0023.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:3bf::15) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|PH7PR12MB6000:EE_
X-MS-Office365-Filtering-Correlation-Id: 02b90b11-c95f-4184-0dc4-08df049cade6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|23010399003|366016|376014|7416014|10067099003|11063799006|5023799004|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	IipEiH8qXrmRsq1+lTGP4uP6S6+YsE48IxoL1i/gGuCO37arAW+M4/mTMzvFVU9CeOVf1OVzS+W3D5KEKpsVc4N8yqLzTulj2XmFxJZ5MN9BfoHqU6zdGdz90iO4tDS9bsLkvFt1vUw1y5JjvZk3bRJvIh7XKcLea0EAs/D2iAthksMNVbAjyA8Eakija0ogAhZcAR65f840SUCV18HBV7kFc8FEMJxvPrRIvOdV9Jh6cAowsvPQQTM8StVyv8WX4Qm1zsEbNfOe/fpBDDQLH4Decx1UwUaj6j/l8Azzvd6r7pYGQ38TO5a6vOdiI83cQG4Kjfj/Kjg1nir1yAxnpwAl6e/aPVK6uhg1Saq2jGFKhH6aVqHi5wOBV9LRvwRCHuwGzioM5Nxcy6Nhv8jLP4VMX0xvYlf6T/kwDz3hjB/Hhsd31ZjCnHPKZDhy9rVQCBdiNvTpzMnbSov346u79GCcoHHpzHNT0gISTmCr52aCRiXRq8ZOBKoeQ1H14EcqFM1kUuZsoVGDUjjbQDmdZTirMlMGMqNxS88hl7luGrY0mgJRFNYw4MxO3sZsOsJBB5Q4bCzmaZBijjCAF2Qf751/V2eyhrCWI9VUSTKEq6TomQqZi/A91pFMqln8mNvOV9mSVTU3FwRDGegIneCYYHKiZwtCyioQxfNY1E5v6zM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB6873.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(23010399003)(366016)(376014)(7416014)(10067099003)(11063799006)(5023799004)(4143699003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TFpic0djcG9nWUEvbGJjWnVQMFFmZTZmWm14bFkwbkFSRzcwRXV4cVpubHYz?=
 =?utf-8?B?QmRhQTBTTEVZVEtPckhjcjFvM2podFJyb0V4NG10SXZ1emphTUxhdzcwVkZS?=
 =?utf-8?B?cWk3TjNrM1hDWWVCOG9mem9xcllxTzh1bWdOT2pFQm9FSS9ndFFHdXQrcWd5?=
 =?utf-8?B?V1lmUlplSXNGeTF1c2hqV0tmZmcyQUN4K2loRGgwRllZQjNMQlBkUDVwaktl?=
 =?utf-8?B?UEp3Yy9HTkV6QW9rWFV3YVZkaUg3VlVKU1QwaXhtRzlPd1RoSHhJQnNRRVJQ?=
 =?utf-8?B?T1NvMysxRUMxOHN5djRNTFU3UVk3Vy9maWRiSFZOY01kOHVzRXJrWDg4YmJ2?=
 =?utf-8?B?WGFyQmQ3TG5WRVU1Mm12eXRDdnd5L09BTzJGaFppenhGaXJ6d1Q5N0NTV1Mw?=
 =?utf-8?B?VWVhK2VTWTFYbkMvMHNHVjJCNUMvOHVXVEY4SG50Z1JJUE9IRElrWW1zMGtl?=
 =?utf-8?B?SitrT2t1d1hZc1dvWmZocXBYNms0SlllV2VTTUlYNDR5TVRJYlc1SGp6NFI0?=
 =?utf-8?B?RlY1YkFTd0RzZzFaNkcxd0NNdFdzQTZoUHlEa0wzRUhjUjFpM3RDSkRGV3hT?=
 =?utf-8?B?VzVtTk9Da0FFOVpIWFNKL2lKN0xzMk1KV01HcFFJMkR2WDljOERBWEZxNkFv?=
 =?utf-8?B?OWVoeVdyZG9IelRTdytvaW9TcGtQckx2SDRDMElQc3U1dEdpeDVDVjVKdGpm?=
 =?utf-8?B?aWlEOEdBZmM1YmhJVDZOQU9ubmJMenZXUVdESWRuYi9PcHlGdmJPejZtMlJR?=
 =?utf-8?B?YWdYSFVmdVFPaUxwRWZBWk90Yjd4NlhhNjJBaEVFT25EU1pEc0xZejN3OWM0?=
 =?utf-8?B?c0s2R1AwQWtZR2VvYmZoWGdyMXlETGhZVCtQMmRFTjQxZWl1Q053N0NySWZ5?=
 =?utf-8?B?aWZpZ21jQWJlKzZNSWpHcndPYXBYT2VYQ2lDaFF0dlZUMG9zWkZCbklheXg4?=
 =?utf-8?B?T2dodEIxcEZCV25vdmQrb0pvQ0YxMURZVjY5RGJmcU8yT2ZPSFV2dFd5OTlH?=
 =?utf-8?B?alNkZUkrYzZPZCtZTUJ6MmdyZ24rMnNia3NmUXR3QjBpVkpnR0c0WDdIVERr?=
 =?utf-8?B?Zmd1UTdHUXZYSXI2MFl2Zm1QYW0vYUxXR3ZQWDRCampYZGtyTGVhRmRhOHZN?=
 =?utf-8?B?cnY3Z1czcnJ6S2lrQ0NLYWxjNVNCc2xuNjFhYjh3eHNBdlU3aVRZMkV2MVdx?=
 =?utf-8?B?c3ZHdXFDQm5uQ1NGNVV6bGQ2dnFEWFg1NCtTT2V5NG1MUlNiT1o0a1FmN3Vw?=
 =?utf-8?B?ZXFEOEZ1WXlGVm5naEZqTFI5QUdab2hGSUxQWXRmcnc3WEVKNU4xZDFzNktC?=
 =?utf-8?B?OURBZSt4MlFSWmNLa1oxclpNc3A2NytWVHE1UEIrenVXRjhuTys5MWgzQWRV?=
 =?utf-8?B?eGw0bFZVUXVXdmlrd1lYSXk1cCtEalJBdHBOSm44QW1aZVZrTWp1TEVaUEZo?=
 =?utf-8?B?WVRTU1l4OTB1QlQ1b0NFVVIzVFNJd1RzTDNBQzd4L3NmdnJvY013cUJOWUhx?=
 =?utf-8?B?eDRpWEIzYldDRjdDd1psZzdzWTg2V3RaK1R6MnNSU2V2UVU0Q2l6MDlsaWVv?=
 =?utf-8?B?dTFFMjBXRlVUK1BYSkk5QllVRWRScm9jVG9ObUtadENFeTd6UmhtdEkzRlRV?=
 =?utf-8?B?M0hOSmtXYmlJdU52Y2NWeDdDUU1yRXYvWjJUZjl3c0o2cVJlTUFkZGhsMnRU?=
 =?utf-8?B?cVBYQ0RPQ0JicXJhVmMwaUZXbzVTdjlTRDFxOGdyUFdRamI3cjFrbVRJSm5l?=
 =?utf-8?B?cDR5eGIwVHJHMzBhY2xjR0tmY3p5dUtWcmIvS0t4cmhtWXM4Q3UydXdWbG1p?=
 =?utf-8?B?aVdyZnJQVUYyaDdqMFFqeDBMWXdTQklQUnAvU0h6U3c5UXJaaEtuTUNUa1Uv?=
 =?utf-8?B?bzhqVTZIZTIyeFdBNDRVeFR3bGRwMERFMTFjQkJubU1DeE5kU2JyaisyU0Er?=
 =?utf-8?B?NWdxc0JVRjA1bUtyK0lqd0Z5ajVnRlIwc0xKZU5qWG1Pd09vbk9xZDR2NUZy?=
 =?utf-8?B?aC9EcFFFMGpVTjNxWTd2RWxhTzZma21Rd0VpVFZNNmdSWFJGZldxaWpzQTRz?=
 =?utf-8?B?ZkRlaGt3ZjhNMm1oVkVwYWJMSnZEU3VqL05oa05KOWczUGNOQTJMNWNxQmNK?=
 =?utf-8?B?LzgyaG84cVp1U1Y1ZG51ZkxkOEw0TkFzaEVhWmdsL0dUVkk3L3hOM2pqRENx?=
 =?utf-8?B?T2NMR0xGOVFINXhkc0tHb2xyU2VuTWlMNUxWcWxTRG9KY0JmSjR2dk9POXk3?=
 =?utf-8?B?SER2a3Nic1NYSTdEQmo4MHAvQ1FUU0tscTBQbUtYM0FiV25jNE94TjNKMUl5?=
 =?utf-8?B?L1RrTVNWNHVtbExPOTFWSFpSWi9mMXljU29WRzljcHRGcGx6RFpLWGZ4aWZs?=
 =?utf-8?Q?fTG9zVbaoT+ubeSzNuQ5ih++KVZpeWWBts97pA54qh9lH?=
X-MS-Exchange-AntiSpam-MessageData-1: gvLnemy+LWAkvQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02b90b11-c95f-4184-0dc4-08df049cade6
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 00:38:29.1644
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1NjezyMxt/KCRWSzaPChT19/FO/Gr0iiD+F8z/ifs6KiHE6gXn7Qom92A5hLgJ1/YvYBCm9qQ18t/EiGeZRfHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6000

On Wed Aug 19, 2026 at 8:09 PM JST, Gary Guo wrote:
> Add a rule to allow creating `IoLoc` in `register!()` using an existing
> type and not create a bitfield. Add an example to demonstrate this for FI=
FO
> registers.
>
> This rule is also going to be used to create subregions for registers; th=
e
> example of doing so will be added later when relative registers are
> removed.
>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>

> ---
>  rust/kernel/io/register.rs | 30 ++++++++++++++++
>  rust/macros/io/register.rs | 86 +++++++++++++++++++++++++++++++---------=
------
>  2 files changed, 89 insertions(+), 27 deletions(-)
>
> diff --git a/rust/kernel/io/register.rs b/rust/kernel/io/register.rs
> index f622057f7346..63c054162e54 100644
> --- a/rust/kernel/io/register.rs
> +++ b/rust/kernel/io/register.rs
> @@ -182,6 +182,23 @@ fn offset(self) -> usize {
>      }
>  }
> =20
> +#[doc(hidden)]
> +pub struct OffsetLoc<Base: ?Sized, T>(usize, PhantomData<(T, Base)>);

A short comment (not doccomment) quickly explaining the purpose of this
type would be helpful to readers.

<...>
> diff --git a/rust/macros/io/register.rs b/rust/macros/io/register.rs
> index cb02e850b23f..0b4e0d1903dd 100644
> --- a/rust/macros/io/register.rs
> +++ b/rust/macros/io/register.rs
> @@ -14,9 +14,11 @@
>      bracketed,
>      parenthesized,
>      parse::Parse,
> +    parse_quote,
>      spanned::Spanned,
>      token,
>      Attribute,
> +    Error,
>      Expr,
>      Ident,
>      Path,
> @@ -49,11 +51,11 @@ struct Reg {
>      attrs: Vec<Attribute>,
>      vis: Visibility,
>      name: Ident,
> -    storage: Type,
> +    ty: Type,
>      array: Option<RegArrayDef>,
>      relative_base: Option<Path>,
>      offset: RegOffset,
> -    bitfield_args: Group,
> +    bitfield: Option<(Type, Group)>,
>  }
> =20
>  impl Parse for Reg {
> @@ -61,11 +63,23 @@ fn parse(input: syn::parse::ParseStream<'_>) -> Resul=
t<Self> {
>          let attrs =3D input.call(Attribute::parse_outer)?;
>          let vis =3D input.parse()?;
>          let name =3D input.parse()?;
> -        let storage =3D {
> +
> +        let lh =3D input.lookahead1();
> +        let mut bitfield_storage =3D None;

You can avoid using `mut` if you turn the next line into `let
(bitfield_storage, ty) =3D ...`. The final form of the patchset already
uses a tuple due to `unique` anyway.

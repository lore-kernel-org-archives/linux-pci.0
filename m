Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012052.outbound.protection.outlook.com [40.107.200.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D2F3F1068;
	Fri, 28 Aug 2026 01:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787880833; cv=fail; b=JVcB5q/8ddBftSqH49Kxu3/3YowO6r1rzHaoRY7uo+DgBjIxSK/4G2DQUSdJMXYAltqRjGtAnqxLq6/GzgytPOI6nMdr32gIw21z/quQ3J7pl5pl3O/tlwocgXehrBo6CSx3MmnL4a9obGZJPgD/i72u1jZatFyiXzcCfzN1m6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787880833; c=relaxed/simple;
	bh=f2NLjHfMJiGNnPyy8LKuCds7HifuaFvyS5gIwTuiflM=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=j1Za9UC5HW4vf9LeARKH/X35nHUBMfMJ1oAoK93nUkDXmMJNxliGbYL9hxkhceUEb1MOfJb1MdvlbTBeRCJQzIilXHMn3GO3d+xp0OrwqrGMW/9k8rEbtWB2cUtQodmUT2OqTxd/7By8zceoJDrkwNL3HHgkp21AgLZ01o8p+WE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GCvmFgLL; arc=fail smtp.client-ip=40.107.200.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GCvmFgLL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DY0S9yk+5T7nflLifKha0mmwAkLZBGi0Yf2rKRFV0n6q2dbTmngKlLe15m49I3+u6GVyhwPXEIXIUHOPqFlBcuv3GLvtu7StQx+0xdEVVRjuudEkCWf6qIDF92a9pubDaAQYdA/rZgK2zlsPSlxWIc5oAJXwI3/lKJnAH8jMDAcHzvr7nUShu5yQssBw+nzWO6GNsdps1Zot9hocgbRyajD7gpZooLHMcTsalmSlgYjrRX8MtRne0KBga6rcFy48DmxPTKV/2j4dNdBlhtKsBr2BRDDCKkX7zCZmmQIVh/ZSsrTB2AXDISLYHxANSbB9eXg2qTxzSTL1rB3gE0Gu7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ohFDdh4m5HTyj9rSKKYk+PtZTS27I2ZntPwkMhq3lkM=;
 b=fuSDD72DzevG7lMEiFlmOfDojSqipsY8o2Cnt+C7mqVIpqmDvJVnUHbxq3xlGPgdAIhOLgOJwgkZ4dEqM8GCRJrsjwEKfoPkk1gXwElTkwEYz8WJ+N/lqXXlxv3OVuU3/watz4oWJAsxZigP7BhMWiy1YZDSDL/PRR6mcHtn9QI1Qc/BcSjO8Ani10GA+/8s3JlW+50IVO6HuTRlgghrl4fcpqSKdrPb1LVCS5YGeW3KJ1LNUdjlboqL7gX04B3LTvcEIJT01l4vhqRh3eHvfAr6JyWdEIshXOkvTFzOIDhCUCM8IsN4mK8gkOOn9lOJQrIT0BaDZJh77JY+t/MpWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ohFDdh4m5HTyj9rSKKYk+PtZTS27I2ZntPwkMhq3lkM=;
 b=GCvmFgLLjW49nhrcw3QOsIEeDn3v5HrmoyhXRqlrJ1wx0axxDoIdQqe0i6yDByM+6/3GO2sWmifl4e2OT83Z2NDfSll8jenhTcOWP9dYr27MGUWUMy/U7979KaCgHje4wK1Oe+UHrtx0w1LU8UxNzeJje43bECh7hX0+2r48qUsfVNbSchLeSnnsoKNzK10uENa27e38sAhZBvkxirinTxCWc3bfWVHQzg8QiTj80nWzje2helLcQjErYt7GwzQVRd1ZGdFhXsWKaYYyuxAk115m4PLaCMYjBHcJ0o6d8o5tJ+7MonDYyS8Ys3PLeT1T9gbBOB233EXdNR84jII+Wg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by PH0PR12MB8776.namprd12.prod.outlook.com (2603:10b6:510:26f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 01:33:48 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0315.014; Fri, 28 Aug 2026
 01:33:48 +0000
Content-Type: text/plain; charset=UTF-8
Date: Fri, 28 Aug 2026 10:33:45 +0900
Message-Id: <DL06UWAYHK5E.3GMA2E2HA0AE@nvidia.com>
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
Subject: Re: [PATCH v3 14/16] rust: io: register: remove relative registers
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>
Content-Transfer-Encoding: quoted-printable
References: <20260819-typed_register-v3-0-3699a75fadf1@garyguo.net>
 <20260819-typed_register-v3-14-3699a75fadf1@garyguo.net>
In-Reply-To: <20260819-typed_register-v3-14-3699a75fadf1@garyguo.net>
X-ClientProxiedBy: TYCP286CA0149.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31b::12) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|PH0PR12MB8776:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a3cca30-ed35-4434-8af6-08df04a4683a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|1800799024|10070799003|366016|376014|10067099003|11063799006|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	2wwauoR57ULCk7+EDw7rUS+yu1eJhE1i/9OlpUBYHS4TLL5uogV7KCYxGje55/s3XnRZBdD47ahLvovYO77CtWGNlbnVDWi5rrVaDSKm+I+p0JfjnhYK6DissArivvc5dSPzbzq8eF4wIAgIO+QN01c12Wc6j3jsu4uen01CBlm4Ywu1ezSxKBdd6lS/QDrCu3coJkz5TZNrbm64IZHMsjUhvHEQRYU9T54rC05yIaXOYw7Cpf3AHp24ivK9PW7c3B30au22ufrQeMtwV0Cd57/sdVQVx67+4aZ3CR+VMe7bbpX33jC9XhBlzwCWeKqGOgZLlxGYSMaYAzp6moxgAqeSKYpx6gkxaiYH4WkajtrGHbh8qx5kArKYJfYRpQ4dXGcZfQ4As/pM7RbnArErNMnx6Q7x+1U+eZAYdgU5/K56iSis7N+9tpWcCQcSMQLw3VKOTxkuwyNbpD8ZiDPt48ZnIhb5f+gH8PZPKiAbgd+acD6dr7FMdtnyq/NfeoK21ZCF8+RyBIAiGTyVFCGJcNVHGB89qJWHsYgsib94h2f2jVrcqDbAY0aLSOy9gUgaItJKMPtv6uvTfR8WeESrqzibKCK7Nqat5864V1EuTkvyfaTjryXfAA45BaysRAB/eYLaIcnKFccAyDfZswvty2TDDudGW7BhIoEj6nWv9IY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB6873.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(1800799024)(10070799003)(366016)(376014)(10067099003)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RHJiZHdCN292cUlvMkV3TmZVTVZ2RHZwL2JnN05DTFhFVUpYSld2OW1PSFc4?=
 =?utf-8?B?OWZiMExGaE5CQVhzVldiN2ZFcDZyRzcyR2xibTZFZ0JUdFo5V2JOQzlPelFN?=
 =?utf-8?B?M0d4MjlobDJyNlVieGhSaG54QWtzUkNpcVpUMTEwSDh1ZkJwNEVWRlNDRUxi?=
 =?utf-8?B?dzJlcVpSc0ZIYTk3VWtyTUxBQ3hDSUllblNIYjNCSmpwY1J3NHRiSGkrUnZi?=
 =?utf-8?B?M1J3dm81ZVczUjFOWnNLYlo0OWlaVGlzRmROeUgxQmJ6WkJmSDY3WjFJamNi?=
 =?utf-8?B?dE9yaHdnaUZuMWpwQWk1WDJ6L0l4bGU0V2M3UU5HYUdRMFUrOG1ZNkpBWWJq?=
 =?utf-8?B?QW83dWk4b0drc3dDZXVUcmhRTDZjQUsrKzgzZHZadi9UOGh4SjhCVzJsMks0?=
 =?utf-8?B?b01wNlhKTU1Qamg0WFJIZXpQd1VaQmdhb0FBOHZjK1Zvam9KM0w2b3lKTldY?=
 =?utf-8?B?N2hoOFlseW0vVEVBbEFHSzZkYTdKdXluVStYOXMvRTF3SUlINUhNT1NlZGJD?=
 =?utf-8?B?anZDZWx3MlBMNzh4ZmJSTWE0MEZpVTMwRjRvWURoTUVUQ3BURWIvd3RieVlk?=
 =?utf-8?B?WVZ0NE16OWNDcHIyU0cvTytnc0Nvanh2dDdMTktzYWhUVjRGRm9UNnkwRkdo?=
 =?utf-8?B?emZTK2kwSFJXd0h4TjQ3TWRCcXB6elpsMnRPMXVoUEtpcDdXUTBCSUlzcEJZ?=
 =?utf-8?B?a1NYUCtKQ2RRVzB6dWdpWXdUcUJDNWUrOXRXc3hrbzZWdC9tOU9yek8yclpQ?=
 =?utf-8?B?a0NPelNhdjkyazFTQklwV2c3dFd1Z2g2RnYrT0JzcU9oc0Iyd3N4MGN1TXBO?=
 =?utf-8?B?WElSN1RWcmtYMWI2emo5dmUvOFA0QnZLUVNsQlc4dE52bnk3ejdaTDZsWXhJ?=
 =?utf-8?B?bURscUJtSnNSZ0lnM3E5aTBjRm1EODZFMXV5OWp6eVFhdWk4RW5QRXNYSE90?=
 =?utf-8?B?NlVJNE5iclNCc0RCUHlXMzU4cFptWnhOVWpDMzh5RTI3MCtqMXh0bG90aHlC?=
 =?utf-8?B?UmRnc0M2QjhUZVZnNkpoY3pUS2g2OUs3U0lyKzdiMWtUYWxWVXcvUkx3Q3J3?=
 =?utf-8?B?MlIzUlBxYUxSSU1aRWVUaTNPRjNkekgzRXMxNDRrdGtIR1hUcDV2WkowRlkw?=
 =?utf-8?B?cWZkeUpkVGNUSkJUWmdicG5LYlVDZjBQbDBaRUp4THNtMmxmUXIrdG9XeEV0?=
 =?utf-8?B?emZ2bzZsc2R1NzZPOW1pYmVHc3BQWld4MkhERnlHQ00zazNiVjNvcnpETm1j?=
 =?utf-8?B?cE5CNDNWQTNoMnRxNWRlMmJVbGxFRGVvQmlvOVlZUTE0K3E5dnRlSUIxUk42?=
 =?utf-8?B?aVA0bTZyaVk5M1VBL2R4Z25iV2lBNmtnL1gya1c3RjJpaWpjVTY2bTE0S29v?=
 =?utf-8?B?dWJ6MkdlMVU3RHVjUTREWlNTUlRXRytZMURKdjBSanJ0S2pYeHYzUHFtUkFn?=
 =?utf-8?B?eCtjdUxycDlEL0l3bnNPYUxwS0x3S0grb2RHOUN1K09VbXZpdXJvWEhzOVVk?=
 =?utf-8?B?N0lpSEVqS3p6TzBjM3A1dDd6WWhCU3FZRmtnMGlUeURjSXIvTUtCamhianZF?=
 =?utf-8?B?cDFMSnhhd3NEbElXQWhvaGJjVldwbVRYZ3FvckdxeWxmaE9NLzNueklLeXRU?=
 =?utf-8?B?U0p3L3Azc09EdkxWWHUyRFg1SnRTcWwzenZOWWwwK2gzR2hVQ090RUxzRlJ1?=
 =?utf-8?B?K2Y3N3BuQjh1bVB3VW43bmpTYUJPUjlzRHlaNkNaNkFWSFpKNVpDVjVwMUtz?=
 =?utf-8?B?dUJ1cFdyRjRhaEkxTE5HQUlBMitOUkw5UDZjUmdIdmFVdGFzaktySEhTVlhE?=
 =?utf-8?B?WEZZdmkyM3Z1ejFqTnFlNWd5K1ZNZ1dKSFAyUmdmZk1lYktleWxJL3N4YldI?=
 =?utf-8?B?WXBaODdzSFpqWS8zVDQ1ZnEzN29KOWpSUnFRVmZZOHlhSU1BUHF1Rmc5WUZB?=
 =?utf-8?B?Q2tCZVVBbXprMVc3ZXNnWUVieFZrYWdEdFhCUVBrSmUzQ1R1QnF6M1UvT2lq?=
 =?utf-8?B?d1ZJbGRoc2lERmF2RVhsZDFhY011WHNNaFkxYm9MeEZMOTRBVGNUQjVCUFho?=
 =?utf-8?B?U2FQRnMxekpBOE1GcldobW03YUk0Q0hkMFJYa3h3R3BmYUhPa2N5QS95dEo5?=
 =?utf-8?B?blBiTVRVdG1BNGxzbHhZQXU2WnVUQm02SlVibkE1a1o0Y3o2Q3RuejRHdVpk?=
 =?utf-8?B?WVJTeFp3ZU1RcGNBQk5mb1VsT29OalpDd0lucndxbGZZeVdJQVNPOGQzQlAx?=
 =?utf-8?B?QzVHVldPeVBMdlpBN0lGbEZzVy9EbnRHbUc4aVJXWGVkRDAwMEhlb2JKR1FT?=
 =?utf-8?B?aHM0b2dKYU15ZjBZeHU0TjRIL1gvbElkaFNIdXlhenNndFJ6WHFHTGJmU2V1?=
 =?utf-8?Q?nxHCBF+PRxKV8lJKF0NfOSZEOUXMFb8R+cmeU3uE7dhuL?=
X-MS-Exchange-AntiSpam-MessageData-1: DjUI8N6440ZWKQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a3cca30-ed35-4434-8af6-08df04a4683a
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 01:33:48.2161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WuQf8BTjoL+osAe8lgj6E1+wT05wJ3CfaqZZMQNb6ppcolMc2dZ0iKx4w9x0JBZ0sTalabM1BjEfdUkLPYQ0kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8776

On Wed Aug 19, 2026 at 8:09 PM JST, Gary Guo wrote:
> Relative registers can be better served by projection to subregion instea=
d
> of ad-hoc handling in register macro. Projection composes better (e.g. it
> natively allows relative registers of relative registers without needing
> additional support).
>
> Remove relative register support, and update the documentation to
> demonstrate how projection and subregions can be used to achieve this
> instead.
>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>

And good riddance!

<...>
> @@ -763,115 +511,83 @@ pub const fn element_alias_offset<Base: ?Sized, Al=
ias: RegisterArray<Base =3D Base
>  /// # }
>  /// ```
>  ///
> -/// ## Relative arrays of registers
> +/// ## Relative registers
>  ///
> -/// Combining the two features described in the sections above, arrays o=
f registers accessible from
> -/// a base can also be defined:
> +/// There are cases where a register region is subdivided into small sub=
regions, and you may wish to
> +/// have your register definition be relative to these subregions. This =
may be needed, for example,
> +/// if these subregions are instantiated several times, or you just want=
 it for encapsulation
> +/// purpose.
>  ///
> -/// ```ignore
> -/// register! {
> -///     ...
> -///     pub RELATIVE_REGISTER_ARRAY(u8)[10, stride =3D 4] @ Base + 0x100=
 {
> -///         ...
> -///     }
> -/// }
> +/// For instance, imagine the following I/O space:
> +///
> +/// ```text
> +///           +-----------------------------+
> +///           |             ...             |
> +///           |                             |
> +///  0x100--->+------------CPU0-------------+
> +///           |                             |
> +///  0x110--->+-----------------------------+
> +///           |           CPU_CTL           |
> +///           +-----------------------------+
> +///           |             ...             |
> +///           |                             |
> +///           |                             |
> +///  0x200--->+------------CPU1-------------+
> +///           |                             |
> +///  0x210--->+-----------------------------+
> +///           |           CPU_CTL           |
> +///           +-----------------------------+
> +///           |             ...             |
> +///           +-----------------------------+
>  /// ```
>  ///
> -/// Like relative registers, they implement the [`WithBase`] trait. Howe=
ver the return value of
> -/// [`WithBase::of`] cannot be used directly as a location and must be f=
urther specified using the
> -/// [`at`](RelativeRegisterLoc::at) method.
> +/// `CPU0` and `CPU1` both have a `CPU_CTL` register that starts at offs=
et `0x10` of their I/O
> +/// space segment. Since both instances of `CPU_CTL` share the same layo=
ut, we don't want to define
> +/// them twice and would prefer a way to select which one to use from a =
single definition.
> +///
> +/// This can be done define a new type for the subregion, and then defin=
e registers that use the new

nit: "done by defining ... and then defining registers"

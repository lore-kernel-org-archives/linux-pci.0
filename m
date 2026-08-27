Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011055.outbound.protection.outlook.com [52.101.52.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E7134D3B2;
	Thu, 27 Aug 2026 06:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787813622; cv=fail; b=q5mUBvC7m59F2m1AKhUoXKUF4DseLOxgLsp575kl3a+oW1y9YWDLdxPO//fvx1JRMM1ht6SakAOo2m9a9bq25FM6xLkVZImztwhc3EEbezxSgLBSMTJULhgO2OqaUYzMYSivhAQTaTZ6VakHSuDwj6TlvfszLidQBohuz8FbnkM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787813622; c=relaxed/simple;
	bh=WIbltHOn2BQFS/B4rFukhi3ulwmhg07ELog5g6ZRdp4=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:References:
	 In-Reply-To:MIME-Version; b=dUCpaO+zDovIgZYyXx/ViEmJLrkkIoDCBFUI0uFphztuyzQwR/bajQRv+oGWxDd+vAgl9ySaxw/Fh3FX6b3EqCnxVzSf/QbyYjGIkumjsJh1LkNjoi6iM+JM4QnVlZ3FkxWa8vQabganzXRsqSHOHHXGrhlNX7iT5GamWqqQoOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=a7OFvBcS; arc=fail smtp.client-ip=52.101.52.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="a7OFvBcS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HJH4p7IINNGa74O//Rk6ZdTHp3Iq78GTk5E6UerrNerFDTXmlDh8Ky15qoErdthjHszJBfZmK6Xd6GhTA7lMIxYPXF2FlFZmqdmLcjTOIYqu09ByEAOv4rlUaJLz3TTO8rgBtU7LKg0YuagSTJKzZjTWn2TIxfMzJvrTvLeKrp3NMACv0gtXysk7DqMol/5ln5CiKNPv8UOzyIIJf8UkGDKvj8sXv3vQXt6GHutCXGm2TkG7S22BTutD+gVr/pDkBanWHokKUvoiB2FOnZ5QefMvpsXfsgsdxv4LOGDlav/KbuGbLpo0j9OZInMq/mzCBMOKpj6XXERTmVw7dLT0DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HD2JdwJr3ALjL8NT2lj8pSCavRlGJi4+srPiYMYjQT8=;
 b=W1Vu++UxPzI+T9FDcC2/UKWRfa8ChJwemXgl5PrHXPazRc0VHsKTChI0IWElhS9FRqxMB/vgW28k8qTTZoBV/7flOhrfG0QDzOSUKXEmJsA5plF2y/8Ij8gyIfZB+paz5OX4L2t8mdDDu9ZJHyOrpwJqspqTWEI9ccDr9nOZcLq13kc4mLwbMK5O3PcMlRjrqaYmqzHQxYduZMssff7ZcryQw36BP5QrlWMo3fspFnuCYjMx1YkC6+FIeCt2eyFMccWMS62DOcydeAt11TUC10Od9J5gb4gPMzLfXSGjwuIYkw7yiOnSfeNkB4RbMJR6yJtKERKVrzn0xp6yhFNWhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HD2JdwJr3ALjL8NT2lj8pSCavRlGJi4+srPiYMYjQT8=;
 b=a7OFvBcStCLVqyNgTabrp3axVaRQl9woHPtuDxRsAokvk1I906WCQb5hAOLV6mRWXo+LEJeksTAB0vUOpjnK5eqjOmFgWSaE/2kF7INdr9t+6JMorMQ1Hwp02aqiKWuhqJMl5YvFIbC2u+VBbJDRm9VbWuGTvRS9umc5lQ50AhyWQnAZOLH9GT1ZOwr+WSayxisk5JsG/HyHSpxjFEZZHrNU0kLdgCEKh/0/LGBE72FA3M2oHs35TolQ9cYpOHBalI1L6bV1DCyV3gISK0Rbg9V/qTN9FS11rIkAIhq/RyC22suUNMbFPu4Dv2G8aRUJvRjudjK1ZrRmKfYQ9bSgPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by CH0PR12MB8551.namprd12.prod.outlook.com (2603:10b6:610:186::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.8; Thu, 27 Aug
 2026 06:53:29 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0315.014; Thu, 27 Aug 2026
 06:53:29 +0000
Content-Type: text/plain; charset=UTF-8
Date: Thu, 27 Aug 2026 15:53:26 +0900
Message-Id: <DKZJ14NCZ37X.31YOYFWBKZ478@nvidia.com>
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
Subject: Re: [PATCH v3 04/16] rust: io: perform conversions using `AsRepr`
Content-Transfer-Encoding: quoted-printable
References: <20260819-typed_register-v3-0-3699a75fadf1@garyguo.net>
 <20260819-typed_register-v3-4-3699a75fadf1@garyguo.net>
In-Reply-To: <20260819-typed_register-v3-4-3699a75fadf1@garyguo.net>
X-ClientProxiedBy: TYCP286CA0099.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b4::17) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|CH0PR12MB8551:EE_
X-MS-Office365-Filtering-Correlation-Id: 17f9d4e7-2953-4455-543c-08df0407e6ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|10070799003|376014|7416014|1800799024|4143699003|5023799004|11063799006|56012099006|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	XZyX/MCCo5ih3UmMRZMfOw138OBGuEIvTTeQ0V0s39Pes8zz0DYVBklKeDAlaPeBCT4tcICcdy33JRKaodaPAMQe6iq8VDxEH2Zjh88EDvz2PqmUk61I7k7U2jEY+ZFkqvedyiPbv01cxPPoFX9wms18iwjwc57qYOjqjLmBsdsXxnbuuS+uDoRx29K2lXcuHuu+KCC6I4/ju4DgAXKqENIHsdXELX4Wd29nDsLCqKmTWSGRei4KtFwwxAJtbWu4oFy56nUK45ak3xpOuze4SgPR3JRewgCdXp7eS+1ZGgdA26BQVi7gMgyjmICbjwzwgRaYYo/JPE06v+d80XNp5YXjiSNTa2a1A4JDLJXDabvLhemT+9SFvbdJ4Fq2X59yY3hPnza5/y5qyx0aC3kUKPE/L11PZaQnma08TIUIc3V+wLFRor6jzzWquA8SnSBlvBkoKqxuOe2dJLrwl0JaKNzWYK2e/Rsndmy54d/tqiV+eDg+BOo9VLnBz0rm1q3My5Dd8jUEUyNaHXXNjDee6W3cVIzj74TuI49S/n8KKNXfMjIeB9FmmMkBeZ9UviOpX7X2u4pN8bs4IbfXQ7PisBSsseRGS0gmjnYW1dIo9UKfhuqFNADcsVN2/a1UJcnCoA1WBKYDPOym7S9uEmdW8N3mBX/expdsv/i22JpqPt4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB6873.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(10070799003)(376014)(7416014)(1800799024)(4143699003)(5023799004)(11063799006)(56012099006)(10067099003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SlovK3ZScmhKaFErVldReUxFS01WUWRqWkFrQVJDSkFjNlJWS1NPbXRXdWZj?=
 =?utf-8?B?WWNmeC9QUERlQ1o5VE8wbVJCdzcrNnl1N2JIVTROd2FuQnowS0hlMiszZ0tF?=
 =?utf-8?B?eWMxdTYxekxtK3RSWWN5NXdDK2kzOHpTVC80ajhQSFpGQ1NMakNhT1Nzd000?=
 =?utf-8?B?aSsvNnl5aFVLR0xuOGY4dGtCSjQveTBxWEUxbXlYMHEvNklZaXB4UFBrN016?=
 =?utf-8?B?dkMreDRvRjRNMCtjNDZrSHFRZXAvS1kySUg1NjczaVI4aWs0NVF0K2FYNFFt?=
 =?utf-8?B?dVZ1M3doK2NmMWlqWko1NkQwcERDS2JnLzR1YTlNY1BWMUtIcXpseE9pTDhj?=
 =?utf-8?B?c3NETDk1UWlQUEJ0Y3dzSkFEb0N2YlJLVE40Y1ZkZkdGdHpjcW5jMkJydSti?=
 =?utf-8?B?Wk1DeXF3VHZMWEpWR2ZlVS9NdzFUemttTTBiSU1OWmtNZW1OajZxRk9ZRGNG?=
 =?utf-8?B?d01NZjI5Mi9SUFBlQ0EzVWVEcUNJQUlnNUFIVDBlUTAzYlhEVUg5Yktic2x4?=
 =?utf-8?B?N2pLRzZhaDhoMGlaUXJrQ1lVcTdrY0lvUmxwWThGS3AwY3V1eDJ0NUtieERm?=
 =?utf-8?B?K3A3aUFuV1kxY0tmYUk5TTl5aE5HY20rT3hJK3dRckFteUowM1pkUGhueVVO?=
 =?utf-8?B?eGJrM3RRMzNQTWg2ZUVVMVR3Q3dkU01vckJDMDZ2UkEwSE1Cd0hrbmlqaEVP?=
 =?utf-8?B?dndOYlR2K1VleGZvWjZ6cnZsUXZCMzhXalpMZmIyckp4aWV2ems2U3ppUDkw?=
 =?utf-8?B?UkJ2Q2lCaTlaRHlyeGU5Q1NEZjdTVHkyNEIzd1VOQVg5Y3dGRVdSMFBFMGY5?=
 =?utf-8?B?M3E5YXJWQWY0M0lrakVIaFJjVUxBODkrYkR0UkJ1Zk9jTThRbzdBRUhtUkZQ?=
 =?utf-8?B?b056VG1OVmtTdGd3NHZvSEVEY2J4eXlNOThnbGcrSFpidXlzbGFCSDh4UEd4?=
 =?utf-8?B?LzN0cGp5M1c4WGVsQzdXN3hlRitZT1J2cERpRld3eWNpa0JjNzRQY3dxZkEx?=
 =?utf-8?B?S2J2b3pxTkpKUHRqRnBFOEVUblV0SEFLWnFWNWh6Q2pib1U1eTVQQ2pIYUlK?=
 =?utf-8?B?YlRHd3FaNkVsbHlwREppN3N0aUh0enRMMWhRWlArZXVvMHBuYkJHN1g4SWxk?=
 =?utf-8?B?bmJIdE40UlR0K3lwSFRhV0MyK0N2cFpPbFpDV3lsSmtzbVBGdzF1V1VaTTB0?=
 =?utf-8?B?QjdyWFJxTDNiWjFYMTlMdmF4aXArb2VoZlFETm43QXQ5eUtPcFMzRzc2dTVj?=
 =?utf-8?B?Wk9tcmZOYXpQMjNWTk9UejZKRnpBUG1uWXM4OUZ1REcwdXNWWkgxZWxQNXZL?=
 =?utf-8?B?ZHZJSzhGQUhmQTlNa1BRelQwcVkyV3lBZVBiV3M0ZVlUMFh3VHlMTjUraHVW?=
 =?utf-8?B?bXBUTEFhVnRXcGdqQ2ZLRWtuVi9tOVBUS3hZbXQ4ZVVuOGpGWks1QWRSUXp1?=
 =?utf-8?B?UnorOWNxeVZtWnB2anJYYXNrWXZOVVB5SlEwWXN6THRqMHNhaHcxYjZFaGJM?=
 =?utf-8?B?bkpkZHhJV1ZKd3hEcjY1UUxpd1hDVkFPTHpZUVpZa1FtcStZWXRIZURJdWxq?=
 =?utf-8?B?Z3hDRmt4UU1RbHdWS0UwNFdRZnBUQUVpRlZvUGNaSDI4a1ZPUmE5T3dlcndZ?=
 =?utf-8?B?alNOcGNoRUYvN2pHaWkwTXFxVjlodmRNMEErZktCYmN3VVBvSVRxYTFqS0d2?=
 =?utf-8?B?NDdUV01wcmNvdnZCVUpTWmhqSTh3a0Npc2d4Wng5S08zMklXTmJRY08wVFJI?=
 =?utf-8?B?S09CSnBEREU2L1crZEpaeGVKVlRkNFd4TnU3Y3c5dnhYaGtjcWFWNVo1ZzBm?=
 =?utf-8?B?bzhVUmdZcCtOMkg1dGJSNFBmRGxTZ00vK2k5OVFKQTI0cFNtOEcwdStMV2h4?=
 =?utf-8?B?RUloVno0dEdBNkdsMGM2dk0vcmJ5RllNY1ptRy9NNkdFTElTT1VYczN2RVZS?=
 =?utf-8?B?TDgwOTNRRVVrZHVocmZmUUJXeG1lb1ViRjRxWERiWVBSNkFGUkp6SkNzWk5w?=
 =?utf-8?B?MzZPcXhhMUZkdllhY1h0aXU4NVNPQWNmLy9YWURITFJEYTgzRzhMdVVtcTBW?=
 =?utf-8?B?RmJZNG5HKzV2YXdFaFFqUTVhUkY3QTBHRjB4SkR5ZlBJK2FrelNoN3pWc0o3?=
 =?utf-8?B?Q2xKZS83TWIzTUROaEdodk9uNTVBcUlMbzdDMUl6ZHA0eTRNZ0ZTT3VCa3Fw?=
 =?utf-8?B?eHBLaTkwYVNseHVpS3dLRU1DdkNNQ3lRMnpHSGF6QWVQaVRZaURuTkpnaWlT?=
 =?utf-8?B?U1ByYlRaVUw1L3Z3K3N5SlFnMDRDeWN6Z2NvUWp6L3dWVEFPSTdLb05SeDI4?=
 =?utf-8?B?dzJ2UGQra2RxWjZnenlpT1hLeEZxRkRjeHVmN0JySFZwRmRwVlJDaDdZcytk?=
 =?utf-8?Q?8lZ6AjjEVSJ9NmSbGL1asSVC9/5sRiYzLDX/ztWYVkNuD?=
X-MS-Exchange-AntiSpam-MessageData-1: nkPyuHB0yEFhAg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17f9d4e7-2953-4455-543c-08df0407e6ee
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 06:53:29.6747
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HoYC2h1bROVLiYl++S66/4zP3JVMknTfs/mWMpLiEepRkiOhQeRpPfA4inmoPLw43H8yGwUZGOtZ3m8Br1OjsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8551

On Wed Aug 19, 2026 at 8:09 PM JST, Gary Guo wrote:
> For types that are layout-compatible with an I/O capable type, we would
> want the ability to use them directly for I/O operations. E.g.
>
>     bitfield! {
>         pub struct Foo(u32) {
>             ...
>         }
>     }
>
>     #[repr(C)]
>     struct Bar {
>         foo: Foo,
>     }
>
>     let mmio: Mmio<'_, Bar> =3D ...;
>     io_read!(mmio, .foo)
>
> Currently this feature is available from `register!()` macro but not
> otherwise available with `io_read!`, `io_write!`. Support this by
> performing conversions to I/O primitives via the `AsRepr`/`AsReprMut`
> trait.
>
> This makes the `IoLoc::IoType` and `Register::Storage` redundant; thus
> remove them; also convert register methods to use the `read_val` and
> `write_val` instead.

Nice, the redundancy was bothering me a bit so this is clearly a better
design.

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>

>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> ---
>  rust/kernel/bitfield.rs    |  10 ++++
>  rust/kernel/io.rs          | 135 +++++++++++++++++++++++++--------------=
------
>  rust/kernel/io/register.rs |  15 -----
>  rust/macros/io/register.rs |   2 -
>  4 files changed, 86 insertions(+), 76 deletions(-)
>
> diff --git a/rust/kernel/bitfield.rs b/rust/kernel/bitfield.rs
> index a0d089423f21..619c5e2189d1 100644
> --- a/rust/kernel/bitfield.rs
> +++ b/rust/kernel/bitfield.rs
> @@ -308,6 +308,7 @@ macro_rules! bitfield {
>          $(#[$attr])*
>          #[repr(transparent)]
>          #[derive(Clone, Copy, PartialEq, Eq)]
> +        #[derive($crate::prelude::FromBytes, $crate::prelude::IntoBytes)=
]

Do we need `FromBytes`/`IntoBytes` for every single bitfield type? I
mean that probably doesn't hurt, but if we need them for registers then
we can derive them from the register macro.

<...>
> @@ -498,10 +497,19 @@ fn try_cast<U>(self) -> Result<<Self::Backend as Io=
Backend>::View<'a, U>>
>      #[inline]
>      fn read_val(self) -> Self::Target
>      where
> -        Self::Backend: IoCapable<Self::Target>,
> -        Self::Target: Sized,
> +        Self::Target: AsReprMut,
> +        Self::Backend: IoCapable<<Self::Target as AsRepr>::Repr>,
>      {
> -        Self::Backend::io_read(self.as_view())
> +        let view =3D self.as_view();
> +        // SAFETY: `AsRepr` guarantees layout compatibility.
> +        let repr_view =3D unsafe {
> +            Self::Backend::project_view(
> +                view,
> +                Self::Backend::as_ptr(view).cast::<<Self::Target as AsRe=
pr>::Repr>(),
> +            )
> +        };
> +
> +        Self::Target::from_repr(Self::Backend::io_read(repr_view))
>      }
> =20
>      /// Write a value to I/O.
> @@ -520,10 +528,19 @@ fn read_val(self) -> Self::Target
>      #[inline]
>      fn write_val(self, value: Self::Target)
>      where
> -        Self::Backend: IoCapable<Self::Target>,
> -        Self::Target: Sized,
> +        Self::Target: AsRepr,
> +        Self::Backend: IoCapable<<Self::Target as AsRepr>::Repr>,
>      {
> -        Self::Backend::io_write(self.as_view(), value)
> +        let view =3D self.as_view();
> +        // SAFETY: `AsRepr` guarantees layout compatibility.
> +        let repr_view =3D unsafe {
> +            Self::Backend::project_view(
> +                view,
> +                Self::Backend::as_ptr(view).cast::<<Self::Target as AsRe=
pr>::Repr>(),
> +            )
> +        };

Can we factorize the two `unsafe` blocks of `read_val` and `write_val`
into a common private helper?

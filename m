Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021140.outbound.protection.outlook.com [52.101.95.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD3E2D47FF;
	Fri,  4 Sep 2026 13:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788526991; cv=fail; b=T2SGyxCyEP4Awm19q1iiJglxp6Ol1Oyfrgp30hph4UdQTm68UOV0257swxNqhn5ZVZX+AVieh56GrXaebTvhnQzpNq1w/6RSfk3JC6TBJrcKXd1ZMaCbGPGEW5TC14ikl/tvGBWNYn3Eq5CdzYcMqAxcgDAS8JKljKHH4pGDvaE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788526991; c=relaxed/simple;
	bh=m7szfGkZMPVCeB9+LxyBhhw60+H2PawbDiHVcC5fP1E=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=EwPE29RlaKtl6k0PX67m8NGszP1RPABsiwpOUdJuGsnwPCi3vDjUu6i8USHzMOOnyW1x99JyacBG7TEhi1BSZVwK9+Vls0DDaHGKa9oc0ISv6/qx+gbK987vGIfL7zHGWJiPoLtH9mmtVK2F5rFbwQUoMVNf9kbAZdvGCEnhUpk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=EMyLYFYb; arc=fail smtp.client-ip=52.101.95.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="EMyLYFYb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l3Jp2glvt99LLHDWgHRYB4JRS3izlPbNIbQxRKEGW/CeqGXgmkQD7hfYqeGghQ99W1Czca6OxmlegPfXE3mD0aESArUnAWrHSHzAkiafCobfHsmGtucITT1FifZBs5t51GjWNbK2m5uQRjI67cGul+FIo8ZJls8zsj4LLfwcMRbudQTf5ko0VVqkqMe2zwD35hwXvncSrJgvxgu7vN01LoEci6FtWe3YoywPzO1cteBLcHNKOMu3qSHZ1GkNMcNWHb0pluE9yRv106xTb0LjxxT9LUzxmgCQY1ZPXSPSSrXVd3hdk4dxcz2YrDLnroV/JH0LkLLFFN9vvr0k2vDIsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q93GhrDNpJue+te+T86YsYK8q50hQRYy/UJhTykFejU=;
 b=l8rDceM63cyYFrhk/l+qhPb2W0OG+bmkBohIxBrXQ2mNToZjIaxmRvR4v6kfq6b9MjgwogmLxlFz9/MwzQCh7KiRuRT1sZb2D7JqivSVgomCr2KTivuD95XOfLboxjoO3YtnLk3PN65lh9Hr+70ROA8mY4PpA6WHqemf61emeAJAKN/3za4Iec8o7l6TtaMNzlNs27oJ86X7j0HfGhzq6bMxxoLVOkdtXXVJ+qyZr38orY2x7e5vE8ZKvU/Hx23hgu4i1IdJ24B12GxDGnMSv8ZnhtRMlQvd8QUc52SYozCDMP7FKw0+bDhHH0fR8oZeSn3WVgDwBx7dFcqsL1223w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q93GhrDNpJue+te+T86YsYK8q50hQRYy/UJhTykFejU=;
 b=EMyLYFYbpuSumsuvUwA9VJ4NEsnKh+JgLv/zmuuh5kc5zpiqES18Rl2qshAH4lYT/ARdZQ7lAraPfJLoOL/xyvLFBrjO75Cx9BwZGnlqu8P/YyFWQHIfJu2FZAQQsYG7YI/4ZST92LRxHlD+b9FIHpAOUz+tJK3/JV5clChZKRQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by CWLP265MB6449.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1e3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 13:03:05 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 13:03:05 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 04 Sep 2026 14:03:04 +0100
Message-Id: <DL6JWHOEG91Y.1BKBUP653Z5D@garyguo.net>
Cc: <rust-for-linux@vger.kernel.org>, <linux-leds@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v24 1/4] rust: leds: add basic led classdev abstractions
From: "Gary Guo" <gary@garyguo.net>
To: "Markus Probst" <markus.probst@posteo.de>, "Lee Jones" <lee@kernel.org>,
 "Pavel Machek" <pavel@kernel.org>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Dave Ertman" <david.m.ertman@intel.com>,
 "Leon Romanovsky" <leon@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Alex Gaynor" <alex.gaynor@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Boqun
 Feng" <boqun@kernel.org>, "Daniel Almeida" <daniel.almeida@collabora.com>,
 "Tamir Duberstein" <tamird@kernel.org>, "Alexandre Courbot"
 <acourbot@nvidia.com>, =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 "Ira Weiny" <iweiny@kernel.org>
X-Mailer: aerc 0.22.0
References: <20260903-rust_leds-v24-0-8d9e4c04db69@posteo.de>
 <20260903-rust_leds-v24-1-8d9e4c04db69@posteo.de>
In-Reply-To: <20260903-rust_leds-v24-1-8d9e4c04db69@posteo.de>
X-ClientProxiedBy: LO4P123CA0675.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:351::19) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|CWLP265MB6449:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dd4f1f1-0bdb-4e65-b5f7-08df0a84dbc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|10070799003|4143699003|921020|10067099003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	o7exBDUrAgc9ycfA//YkXtiVjDGV08TCta0lcDhxiNtvqJ/iONnJnvAYYwuH2aad9dHoCZQ4rCK0LDAcLuUoMZxtH5FNJ0/lWaSCxktdhFVMtgkNmLo+putXUaeqUJxU5T1Bp9feYQBMugC6lfDy+QH1UnTKYKalQw+m2ZFO4YdeKVnlbwgVUCv/iTtVn8WKKEtyt/FDNuvgAaTVwg7lodAn7QWdt+FQFifjT/BG+CLLDfaXZQFrxWSt/bmBrASzF7qS60bQlfi4osbjPrJmfyVjfQM4duQwFHRg6H+2/dtHpMNkd0YgpMOYb7c7A6u71FdG0m52MS6sUWjc53uWJSxPgcNn3IPCxg90XGySBcLyiFVD1draKXe+OFAz7hh3wTeAFrI4kRJPSaD+nm/w7e+Y3q+3SOz0+NNtt+pJYi9KR60vQo/5YdNZewHCqWXL6H8COfHqMaB0d4i02Eoj5yJNYgzyOo8oXtFTf2S/OTgJbHX5winxtI9clmG2xlhcU64XfqgHCHk9VAxQfrqROOfezTete+etP+6N5e3n6XWmk4R3KtK/fKsLl0/gu2JDYiPE/MEdL+9QNyRArRPiJEd/kcCIbXTvLNbl2vaPR180xy6cEL3lLFDU+rSLqoy4R90WjKJ3XnswdpFz9ucuq9Bd2VXySwWobC6ndcYSnNgCbN/UuUQm+KrGMshC548D86STVKLdbqStZ43cSkIkSw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(10070799003)(4143699003)(921020)(10067099003)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NGlORnRKdGRscWJaT0FLcWRoNlVKbTcvUitSUCtIczVkaVJhdEtqUnVLYm1G?=
 =?utf-8?B?TXVpcTdSeHlwTysvdFpGcmltbkxDcmRKUjFoNHMrMDF1N3hkZk80MzZBRnBq?=
 =?utf-8?B?TmdraVRkdk5TNzlRMDBTSFpkcGpFVEhtRHM2dXZLbVZiZG4wdFJ4My9wYnBm?=
 =?utf-8?B?dTU4SDlSYjZhVjdzWVJxZ3BVRVp1dEpoLzZPRXNHSHlUUFk3R2NXVFp5VjI4?=
 =?utf-8?B?ZUZtbFV1U3V6dERyamJ5aUppTmpTN1hxYmhESjJCT3RrYmREdGJDbmRhT0E3?=
 =?utf-8?B?RzNRbUFPQlJRTEtNVnR4Rlg1dFlzTWtpZTN0U2dTeXFUblNFMENUbTNYaHJt?=
 =?utf-8?B?RHVUYVpHTEtSQmRVZ1lpVVNqWmt1cEdXam5DbjhvYSsyRVBCaTJlNTUrUVVm?=
 =?utf-8?B?ZmRmRUFscWpYYzFGK2N4ZmZsWnYxcVhQSW5PWHlJSFNKanFUU0RaWUpGcWdI?=
 =?utf-8?B?enBtelo5cTZzNE9GdVJLd3lURFpzMEtTSHlUaGsyelJTUXdqYjRjelpyaFRq?=
 =?utf-8?B?Ri9OT0V6eUcyakdZT2ptaEpaTUVud2NXQ2duREloRkl1UDJpaTVhamV0UHdv?=
 =?utf-8?B?dThZUENvNTcxNm5rcFZVbjJsdXFiclN5UW45bmZobDB0MlEyTU5QQlVQVjlI?=
 =?utf-8?B?RGxIYTFROTlZYzhiR2UwUjczeGd5bzhhV2MrUFZ3bG1vSlRQRUhKeUJBa0E3?=
 =?utf-8?B?ajFaUVcxTmg1WVJqL3J1YTR1Nm9SU1huUHZPODh3ZUNxRTRxUjhNL1hoamd0?=
 =?utf-8?B?SFNzbGlDMFpma2ZKcG1EOURMdTBFQ0lCUlE3RUpTL2NiYWNZNWdvS1duYlU1?=
 =?utf-8?B?K0h5Z2U4aXpsSFRwOFJOS1crMDJCNStwcWxJcWFRSEtNeVllbHYyVTBzdk8w?=
 =?utf-8?B?bGFDTGRDK2laTjhBVE1oUjZhbFJOZEw0c29CWmNzTWFDemY5ZHRkeVZtMVE4?=
 =?utf-8?B?bDNFaDAzUitXcVdKZTJDeWZqSjYxZlZxaU9yVkg3ZjNUMFZGRHNoUk42Sms3?=
 =?utf-8?B?dGtZMmJjc3k5YmJMdk15aCtUUnRrSkdCK0JBSjNhV0FpLzloelRTTDhJMkZN?=
 =?utf-8?B?RExVNCt2REszd05UQk9vRGFhOGdxVkJsZDg0MjdNeDhhS0IrN0FKV29pZU0w?=
 =?utf-8?B?QmE2U21NaXMxcFN3NFoyZ2FZNFhIY0pUQkM0YmpiTGU3VjIxYVVxNjV1V0ND?=
 =?utf-8?B?M1NOZGNkbXVOd2FKRzBFYy9abUFQa1NMTVJNZjdMVk5aMVIxOTJHVDlWaUF1?=
 =?utf-8?B?SlNhc09DbXJIaEVzdTFBSHpZazAzblNJd1V3OXRnbHhReVhVeGxOKzNHRmhi?=
 =?utf-8?B?TGhtb1RVOHFpamVQa1AwM1JzV1M3dFhKN0xibkhHcW13U210a0JqSVVQZTFY?=
 =?utf-8?B?Qk5VNkk0aVNqamJBMUdxeW1kVUo3ODZPS1U5eW5ZQ0ZaTkd0Zk1TNDMrZDRl?=
 =?utf-8?B?RXhxL0tsTmlJMnhvK1o3ejJ6ZlppellRWCtxYitMVVEyQkF5K3poT0YwaDcz?=
 =?utf-8?B?Umk1VjNQRmRsN3NORU51VWNMVURxUmRLVEZuemJyTStRalNWTk5Qb0g5N3Rw?=
 =?utf-8?B?bkpHZ2MwcG0zT282SnNJRmpTZk9JdkoxRm9mWG12MTZERG02aWRkT0lteWJP?=
 =?utf-8?B?TnpBRjM2NXdsSXlLL0lGUCttNURkUWdxemgvbkxMVXRURnpLOUk1bTBLNTQ3?=
 =?utf-8?B?NkgwRFNHM1lpRzVTeVR3YXpTSzFtN3VTdS9VdUhSNFRXSFlSTjBGamZUZVF1?=
 =?utf-8?B?M09hSEhpeHVkaTR2bUNWV1lhajk5Q3RvaWFIU3ZKVFZndXRKQ1dndU15YVhW?=
 =?utf-8?B?eU1ldzUzcWR1UWlVaUhHc3dIOE9ZVzZoUXpmUnFha2drZVV2c0NkMzJFeEVK?=
 =?utf-8?B?b2tIdzVISEw1eVRpaTRQQThuOC9Wc3hlcElMT0FYaWdwRVlXQTM1SDJ4Qi9S?=
 =?utf-8?B?cWNTNi9DdXB1UTE0bHpKWGh5OW5ZNnV2NGExcDRPYmRrejFyNWhYbmhSL3Ns?=
 =?utf-8?B?aEQ2Y3hSVTZLaGtIM1FiZDZHcHUyUG9ZdDgxUTlkTU5kelNDNXhjeXZJQ0h5?=
 =?utf-8?B?SUJjQWcxYUU3cjRUNHBCUW1xVEY4dmgxMUZxQXRCTnVnSVE0SmxqZDlmTFg1?=
 =?utf-8?B?SHZaQ3E2SVRJQzFoNDViOVZtU09Cck5RSTd2TUdSVzdJa1RNWG9CSlliNVJo?=
 =?utf-8?B?TlNYV3czWklEZXplU2prbGhlMlBwMmRGbVZHU3dCSDdidHFjWXlQNmx3THBz?=
 =?utf-8?B?UHdaWktjam5ycWpnaTJ5S2dnZzc3TzNYMlRXTGpUdGpDb1VRYlBHVFVvc3Ev?=
 =?utf-8?B?MTQ1d09sQW5ReVQranUwSVprcWNhTlUzd1N1UGg0V2FYZk5UMFlLZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dd4f1f1-0bdb-4e65-b5f7-08df0a84dbc8
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 13:03:05.0493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GQWVxaLEJE1whfSfoAisweGVZo/b7v5wfPEHvMDjZbcLC3EykMy0jqw6bxITo0jQp0me9uZt+WtTgNYb1viw+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB6449

On Thu Sep 3, 2026 at 12:01 AM BST, Markus Probst wrote:
> Implement the core abstractions needed for led class devices, including:
>
> * `led::LedOps` - the trait for handling leds, including
>   `brightness_set`, `brightness_get` and `blink_set`
>
> * `led::DeviceBuilder` - the builder for the led class device
>
> * `led::Device` - a safe wrapper around `led_classdev`
>
> Signed-off-by: Markus Probst <markus.probst@posteo.de>
> ---
>  rust/kernel/led.rs        | 288 ++++++++++++++++++++++++++++++++++++++++=
++++++
>  rust/kernel/led/normal.rs | 230 ++++++++++++++++++++++++++++++++++++
>  rust/kernel/lib.rs        |   1 +
>  3 files changed, 519 insertions(+)
>
> [snip]
>
> +/// Trait defining the operations for a LED driver.
> +///
> +/// # Examples
> +/// ```
> +/// use kernel::{
> +///      device,
> +///      devres::Devres,
> +///      led,
> +///      macros::vtable,
> +///      platform,
> +///      prelude::*, //
> +///  };
> +///
> +/// struct MyLedOps;
> +///
> +///
> +/// #[vtable]
> +/// impl led::LedOps for MyLedOps {
> +///     type Bus =3D platform::Device<device::Bound>;
> +///     const BLOCKING: bool =3D false;
> +///     const MAX_BRIGHTNESS: u32 =3D 255;
> +///
> +///     fn brightness_set<'bound>(
> +///         &self,
> +///         _dev: &'bound platform::Device<device::Bound>,
> +///         _classdev: &led::Device<'bound, Self>,
> +///         _brightness: u32
> +///     ) -> Result<()> {
> +///         // Set the brightness for the led here
> +///         Ok(())
> +///     }
> +/// }
> +/// ```
> +/// Led drivers must implement this trait in order to register and handl=
e a [`Device`].
> +#[vtable]
> +pub trait LedOps: Send + Sync + Sized {
> +    /// The bus device required by the implementation.
> +    #[allow(private_bounds)]
> +    type Bus: AsBusDevice<Bound>;

Does LED class device has no private data that driver can use? This can be
either a private pointer or extra allocation living at the end of the class=
dev
struct.

It's usually a antipattern to get the bus device directly, especially that =
in
Rust we do not allow anything other than callbacks to access data on bus
devices.

Instead, the class device registration should provide a data initializer, a=
nd
the callbacks would receive a pointer to the data instead. In cases that a
device resource has to be referenced, it should be kept inside the private =
data
by the driver themselves.

Best,
Gary

> +
> +    /// If set true, [`LedOps::brightness_set`] and [`LedOps::blink_set`=
] must perform the
> +    /// operation immediately. If set false, they must not sleep.
> +    const BLOCKING: bool;
> +    /// The max brightness level.
> +    const MAX_BRIGHTNESS: u32;
> +
> +    /// Sets the brightness level.
> +    ///
> +    /// See also [`LedOps::BLOCKING`].
> +    fn brightness_set<'bound>(
> +        &self,
> +        dev: &'bound Self::Bus,
> +        classdev: &Device<'bound, Self>,
> +        brightness: u32,
> +    ) -> Result<()>;
> +
> +    /// Gets the current brightness level.
> +    fn brightness_get<'bound>(
> +        &self,
> +        dev: &'bound Self::Bus,
> +        classdev: &Device<'bound, Self>,
> +    ) -> Result<u32> {
> +        let _ =3D (dev, classdev);
> +        build_error!(VTABLE_DEFAULT_ERROR)
> +    }
> +
> +    /// Activates hardware accelerated blinking.
> +    ///
> +    /// delays are in milliseconds. If both are zero, a sensible default=
 should be chosen.
> +    /// The caller should adjust the timings in that case and if it can'=
t match the values
> +    /// specified exactly. Setting the brightness to 0 will disable the =
hardware accelerated
> +    /// blinking.
> +    ///
> +    /// See also [`LedOps::BLOCKING`].
> +    fn blink_set<'bound>(
> +        &self,
> +        dev: &'bound Self::Bus,
> +        classdev: &Device<'bound, Self>,
> +        delay_on: &mut usize,
> +        delay_off: &mut usize,
> +    ) -> Result<()> {
> +        let _ =3D (dev, classdev, delay_on, delay_off);
> +        build_error!(VTABLE_DEFAULT_ERROR)
> +    }
> +}


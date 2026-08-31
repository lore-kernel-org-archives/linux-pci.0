Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021112.outbound.protection.outlook.com [52.101.100.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14883DB30F;
	Mon, 31 Aug 2026 12:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788180346; cv=fail; b=lglB0suu3ZJd6v3u+p6cC3TW4JUsdSMjMIZHuJPs1LPLzAyBe7p+kZ6p3hWyMB81A+ClXvCH8kKbYJWeiDsFg/N/a2i4bcOtpGhqqMOy2BWErBncJ4+QSvioeSdBv7w2+7CLz/XnKKIzH3gZePvAdAAf6XfEge8vU2cfpaROLDs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788180346; c=relaxed/simple;
	bh=ZjWuL0EX/xxEX1sTa5JKHcK/T8DMbEtIwmW3pU6zKEM=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=l2lk7FwHiGldy+K++bbEFzX18nenNmHW33pPy3svHHUbrgMOL9RPtyaFmRSQyjvl4GWB6tvHXsTAjqjJ+lzI9Q8qVZx1F24e704dZebSVZAeZ82rc6Y2koTdK3S6LN8Gagk4uQRUdWkTf2PPwLP9fzmd8OQFwOX0LYUhXQX8C3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=sdM9snMX; arc=fail smtp.client-ip=52.101.100.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="sdM9snMX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DJMJ6lXnYy/LAWLwY40tNtZA3X0zyQVMxSAyuzG8XoKpYiWcM4oQ03M/vjN8k8tmhT2M/ZW0tnjKv/bpHssMPLep+Qk5phdIia7Wf63zpyYWIL9AkbOVRU9dEb4NsaigRy6dvXEKHj79R4ZW+m6KdVr5lWxKkhxx8NKRsi6Q0gmWK5XDefcwMCITrvw0VxFyrxG3XExZ51bG4bMm08n7YwSR9Py7QBCidc6nKINSRz9Ft8QEYiUgXPBotw5HOHZ+iPikwWm4XXLrmcQ4zagqCgyYPKvZkmz5WwMt7jPdIqCO1HHKnIFW1VPBuI72YK355vc5KNuv1uD+EGY3hluwwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XE3g9/kEQPE0oXCf1nI3RxROndb16eWXKx/QzVjDFNU=;
 b=J5sTCp0WeWRb+Bl7oLj2pUbl/5OXIP8UBSdTfWV3ziRLNSqOCAlHsx5mlK+pWwSCkWPG4525tSqAqVogNJX2PjtC46SVrGAqaPlUQlfcCcQV6/cY/Sq9HrtTwoDAYy7hcSNl8ZLCbppafyvq0I/Sc6BBC9L3eyFXJLMMclDRnuUopSn9uJsUgeiOlzoyt+ykoRpmOVf9nP6OduKye6vkUgM+ud4Pewd+nJcoLNlRRcJ5zxUeWPKdqM0PzYJNRMOCow37OIYUWNfLNyYEv2dmMdNvR39Xk5rMZDA4m/MKp/LvgkYzLbJh3pqdQpkYGdNz1tKzsoyfOCbYZ0ogdzMphQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XE3g9/kEQPE0oXCf1nI3RxROndb16eWXKx/QzVjDFNU=;
 b=sdM9snMXzWocsFrU1ssnaeCIcYcgPaHqIXG4tePLFRU1B4nToFijPMOfRjsoq3koCmpjZOcSxKWfEnGEixvNdHFKKNuym9GY5KuzsngLOfHkOY5or9djc+7GnaFgtIADUxXIUNVHXuK+Mri+7aGSMaRJqpJH6GdPtkCGfhvou2o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by LO6P265MB6542.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2d2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 12:45:35 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 12:45:35 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 31 Aug 2026 13:45:34 +0100
Message-Id: <DL350X20BPP5.2Y218YDKZP8CL@garyguo.net>
Cc: <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] rust: pci: reject out-of-bounds IRQ vector indices
From: "Gary Guo" <gary@garyguo.net>
To: <aiqubits@hotmail.com>, "Danilo Krummrich" <dakr@kernel.org>, "Bjorn
 Helgaas" <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein"
 <tamird@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>
X-Mailer: aerc 0.22.0
References: <20260831-fix-pci-irq-vector-index-truncation-v3-1-a2103084d20e@hotmail.com>
In-Reply-To: <20260831-fix-pci-irq-vector-index-truncation-v3-1-a2103084d20e@hotmail.com>
X-ClientProxiedBy: LO4P302CA0019.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c1::11) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|LO6P265MB6542:EE_
X-MS-Office365-Filtering-Correlation-Id: c76ceeaf-39b0-4920-d1a9-08df075dc07a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|10070799003|23010399003|366016|376014|18002099003|22082099003|6133799003|10067099003|921020|56012099006;
X-Microsoft-Antispam-Message-Info:
	OlHVQi1r1RbRZl+mtXBK62GhOCOTDskcZov78IXxf+h/m6Z9NHn0xY3L05J2Ec8JCen2jxtOKZTm3fK/ZTydAlUXCX+r/+B/xC9hFto8ahLutyVrHvlTb57mjdGrSmEH5tRsDE4Vw/foDeCvOgYYaka994YpkW63fIrjav9DiCWJjh7DikMnzGunnYeF1EKQEIrOZ6CYCLNkBxtBl0ZUwocV3MnIchWgVXbpXwXWr09KBYUOgUDhDk12LMb82hfjnBAzNv6/8/O4dzct6fhcnZWqmeVbS7xCSRzwq4t52ByWtwygSRFPD4JSYc9IQCLeuhaV3/UKUc1DgfXyTok6lWy3AR8nSgaY8vRf6+zibG0Ai5S/M9jztFZE4yyTT1Pn7nSSUvrSKtX8Jit+6R72vvQG/T0K/LTIf3JszSELoclHjkfRNpGMdqh+CfW2AFt7v1UY9fqoz7jGBi8FTyVBH0qw6DYT2MnFbRdprCUkr6+i8gHwRVOOPYv5M6KT9rQOVHvLqU6dX3wq8G8+mPXmJMqKgjffR9X+LXYTzFvSr2QVXbRGbY8ZlHUqTVnejRi5fPNycGgckzLD0FXSZoGWhdv4I92IZvHbqNAjPzxg2IxV2dVEsQH08TxRp1glgSdwguOZ+qn8yUYrLUjmrfAHhyHx1oZkYipjSs/0l1D3658=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(10070799003)(23010399003)(366016)(376014)(18002099003)(22082099003)(6133799003)(10067099003)(921020)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WmNseTF6K3dQWWwyaG00bGtvR1dCWTRPRlk5TTJVRWZZbmcwcmNjMGRseEdx?=
 =?utf-8?B?c3dDUUVoVERjMlo5NWZHZVBmYVluWUhMaVU0cy81L0pDd3dOTDVOOFNGUkdR?=
 =?utf-8?B?UmFtUDlWSmUrcVMvZmNNdnE4djZuOVRVaVMxSWZmajRXemttdHNQajlEck9I?=
 =?utf-8?B?cGJ2V1Y5bEVsUlVZMjhzYkxJbktrb3o2enhZMFptOVNnRDJicjRvQ04vQmhP?=
 =?utf-8?B?ck0yVzBFK2FCd3l3RkgyQ3k5TmtZME9TaE5FcjBrdVRsSm91dEhjZzZZVjQx?=
 =?utf-8?B?RXEzK2o4T3F1K0ZpMjJKY1dqVGpCUkw0cnB4Z0NBcnpCNU13eDUvOFJTY1cv?=
 =?utf-8?B?UGY2Wk5zblVDZXRvbHV2bWpZVEZhay9wdk1vWXZnb3RVRjhhWkhaRDM0clQw?=
 =?utf-8?B?aUNtUFkxQzRCQ2RieklEV2pHR0ZHeXMxdk1XeTdTSHpSYi9ZM2xUcW5yT0Rs?=
 =?utf-8?B?ei9OWVg0QjBxK0ZsMjRLbVdVUlRDQ0htK3AwS1kwZ3FVZWJQUGlNemRMU3ZZ?=
 =?utf-8?B?L2lZVnlGYnM4SmlOdmZCY2VlSk9GVWxwZHF3WlZLanM1NTZWdFhFeTEzVEF5?=
 =?utf-8?B?N2QrYWlTRFRvejdwRGQ3RyswaDlUTVNET3Q4VDNqUFEwTVdEUVI5dTFIQ25m?=
 =?utf-8?B?NzAybHN1ZHFmR3FIaDJ1bDBMWGxjRUMwT0NlWVZ5U3lWNHByOWhzMlZGM2J6?=
 =?utf-8?B?R3J4Nm0yYlFRWXJtbkZMcTBTdk5YQ0dOcXlJM1g5RTZsTTB0ZUFKaUlSK2FJ?=
 =?utf-8?B?Yk9tSUw5WFpVWjFMUEtGUDBsRFpIY2x2dHZBQ2ZhaWgxUFVWY3ExWXBtRkpF?=
 =?utf-8?B?Tng4Y3VvOWFwRGloSWFyV3NHd2hWNUtid1JJeU56UVR0d2wrVVE1THVOZmFm?=
 =?utf-8?B?N0JvSTl0SVNsQWRJa1M1TXkzS1lYbG9WSkpKUi94dWRzaXJtOHNjMFplRjhE?=
 =?utf-8?B?MFVlcTBVWml2UGlqNERGNjRMekxEbVNSbWZzdndGbVB1Y0lPclBHcUtTQ3Y3?=
 =?utf-8?B?ZVU2MCt1VjE5bm5KVTVOTE4rMWVJWE9Gb2NaL0owNGR0M0ppYXFQMjJVNGxL?=
 =?utf-8?B?dTY1V1JhN2IyYWQ3UndweU9hT1RoUldtcWpPdVZuRm0xRW9XKy9SeEJkSThJ?=
 =?utf-8?B?NDZuc290Z2JtSHA3MTlzQmJsbFZEVUpwRjZ5emxRTmoweEF2bituOExGdEVm?=
 =?utf-8?B?cGxDQk5UNDBrVHc2aHlaaWhpRHFmb3lnY0hFUVZwRTF0NUtwaFJSaXFlRjZo?=
 =?utf-8?B?dzExc3JaQ3pjY0pvUG9MdnpRV2JTcFJpcm1NMFBjdXF6bnNUaVI3bFc1QkNv?=
 =?utf-8?B?QTRNUnZTRzJ6eUwvWXJaYklEd0Z2cFBPNEZSTWJFZFd0WGVHcitjWWlEUGZl?=
 =?utf-8?B?UVJ0elZteSs1Qnc0UHIvdXk1bmxQcjcydVZtNzM3UHR0V3dmSDNVQmNTeEpQ?=
 =?utf-8?B?OFR1RE80QThlaDVwc3U3eUFjSnNueFhOSVhNMmk3K09aYlFzcTlpRUJFTUZO?=
 =?utf-8?B?RFVxTHRSKzZXMnR1T0tuRnlPMjNkTlE3aDE1WXp4Q2RubkxEMy9OSDcrUzRm?=
 =?utf-8?B?THJER1VWWm1QWUdDSzFVd01tWHVEK1JuK1R4VHlSdU0vM2I1TXdzT3o0N3dR?=
 =?utf-8?B?eDI0Rm4relgrNy9tQjJMV05jRUtDSkQvdTQyZElmd2IrSXd0cE1tMFBkZFVI?=
 =?utf-8?B?THNEUzkzaTFNb1IwZThTdEhIRkhrY0ZNTjhEWlJHSmhmWFdaMUx0bFhCZmd0?=
 =?utf-8?B?WjNpVDFyKytQSDQ0SmlDVlZPajlEWmFUQU0wQTg2dXI0NVl0RE9DNXhWVld1?=
 =?utf-8?B?bi9EaFJJUXYyTElzWWQwN1JzVWxTS1hwL1hEMVNxaHRUQ21xL2dMa3NiVDlE?=
 =?utf-8?B?Q1BIcnp6Q0tTeHU5d1VoQjdZSDcwN0Q4b0JzSyttUW5mVXhpQ1JDRm8rSHVq?=
 =?utf-8?B?RHBRM2NUNWVqbWh3dWdRak0vTHlnLzJZa0R4OExzQ3RpZURpWGhqY0VWOUt3?=
 =?utf-8?B?TEgremRxNjA3dUxLL3hsVUVLdzJzd2xhbkdPY1lXVnQyMHpyZXNQZk5mdjFr?=
 =?utf-8?B?WTdLMHZMRS82eUFadXVHVjRobGxpaktZZndwclRXTU5kWkgyNzJ0M3U1OGc2?=
 =?utf-8?B?Qm0xWFd4ejFBdDJIekNUTEs1QWs1NVRvZFVDMWd0endMUUpLcGttclJCK20z?=
 =?utf-8?B?SXRZK1dTQWs3b3RuSFAzUEVmcVdjS1RXS21YdmtMVG5vNmRNZGZsMXhCL1NC?=
 =?utf-8?B?QnZuQVhySmpXdnliTmZQS0NzOTEwakFaWGdxb1lrSmdiSHBjZmJXd0JOdjFm?=
 =?utf-8?B?b2FPb2xwRVVsd1hSRndwQi8rdnhSRnpMRFRZZGVvNzhPenB3U3Zidz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: c76ceeaf-39b0-4920-d1a9-08df075dc07a
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 12:45:35.3440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PPqqdmAAzEO/lrcjNYL6OTekyZgRF+jXX3fUpdOFqyVlYRbIAYAufOsyyk5yGFjehPST6UD39DJ/hYIF1/AZ4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P265MB6542

On Mon Aug 31, 2026 at 8:17 AM BST, Sophon Z via B4 Relay wrote:
> From: Sophon Z <aiqubits@hotmail.com>
>
> IrqVectorRegistration::index() accepts a usize and documents that
> out-of-bounds indices return EINVAL, while pci_irq_vector() takes an
> unsigned int.
>
> Casting an index larger than u32::MAX wraps it before the PCI core can
> validate it. In particular, u32::MAX + 1 becomes zero and can resolve to
> the first allocated vector. Values that fit in u32 but exceed
> MSI_MAX_INDEX can also reach msi_domain_get_virq() and trigger
> WARN_ON_ONCE.
>
> Check the index against the registration length before entering the C
> API, and keep the usize-to-u32 conversion checked so the ABI boundary
> does not rely on an unchecked cast.
>
> Fixes: 2fb7755b0a7e ("rust: pci: resolve IRQ in index() and embed IrqRequ=
est in IrqVector")
>
> Signed-off-by: Sophon Z <aiqubits@hotmail.com>
> ---
> Changes in v3:
> - Check the index against the allocated vector count before entering the =
C API.
> - Keep the checked usize-to-u32 conversion and document the C-side warnin=
g.
> - Link to v2: https://patch.msgid.link/20260831-fix-pci-irq-vector-index-=
truncation-v2-1-4030ea7746a9@hotmail.com
>
> Changes in v2:
> - No code changes.
> - Link to v1: https://patch.msgid.link/20260831-fix-pci-irq-vector-index-=
truncation-v1-1-d63217d99b67@hotmail.com
> ---
>  rust/kernel/pci/irq.rs | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/rust/kernel/pci/irq.rs b/rust/kernel/pci/irq.rs
> index 6741046ec1c0..dfab323f26f7 100644
> --- a/rust/kernel/pci/irq.rs
> +++ b/rust/kernel/pci/irq.rs
> @@ -151,8 +151,14 @@ pub fn irq_type(&self) -> IrqType {
>      /// [`Self::len()`].
>      #[inline]
>      pub fn index(&self, index: usize) -> Result<IrqVector<'_>> {
> +        if index >=3D self.len.get() {
> +            return Err(EINVAL);
> +        }
> +
> +        let index =3D u32::try_from(index).map_err(|_| EINVAL)?;

Just having this line should be fine, no need for the length check above.

Alternatively, just have the check above, and do the cast, while documentin=
g
that `len` fits u32 as invariant (which is always true given the length is
handed out by PCI core.

Best,
Gary

> +
>          // SAFETY: `self.dev.as_raw()` is a valid pointer to a `struct p=
ci_dev`.
> -        let irq =3D unsafe { bindings::pci_irq_vector(self.dev.as_raw(),=
 index as u32) };
> +        let irq =3D unsafe { bindings::pci_irq_vector(self.dev.as_raw(),=
 index) };
>          if irq < 0 {
>              return Err(Error::from_errno(irq));
>          }
>
> ---
> base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
> change-id: 20260831-fix-pci-irq-vector-index-truncation-6752f3751a0d
>
> Best regards,
> -- =20
> Sophon Z <aiqubits@hotmail.com>



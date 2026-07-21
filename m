Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020095.outbound.protection.outlook.com [52.101.196.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE219397E80;
	Tue, 21 Jul 2026 20:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784666844; cv=fail; b=tJjUNkl+Yskrh9dniIviHHtlr4FCKas+ws/0U3Pc3wYJ6KKN0zISVHbLTHRuCcgTyvBFFOrFShmv14GubY9xRB9PdbwzAngh9uPqyQGfJJWIWxiJx9oQWMVeTZPU7pKqlavEIXhuQiMfC5htNO9zvBg9HEulXKHxuuRDG7ZtJ9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784666844; c=relaxed/simple;
	bh=jIFJacByfeowkNg98n+xNPH0mDGvHpyxsG7qGPFgflE=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=copyvuHbFUUpGNCCZp7F4PQGDcGvESGeYNgJNAGtDfi37dUtcHTHtH8AOSA+KqpUkfdGm8MkgTryEtpJZzToOSGgtUgWH/Ple6CZRHjZTP3YXziT5KYlyl3KDx7XJpYWFpLEOAIeORyGD/TsBXUeDy+tCkz9lw+jmoGAoWFyLo4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=BkWVEXbh; arc=fail smtp.client-ip=52.101.196.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="BkWVEXbh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UhPRk9Ml8xcOuuai7ttR9v9n+YEP3VW7LpfRozt2JU/OD5Lv6kk2i0veY9AtxuNKWRpjI7MpdayYKAzymGQ9L5VJ9kQgMSXHtCup6+vPKoMUVJZU1nc0007M11Ig3RT62TCf2ztiMNtaymei+iJGnMUBD0svX7WLTiJGE7V1Bg3OzFf0aNfCqldzFYXqLpbhxnUKff4u+vZTh8wIarlJPDzgmwOjNf6cIKmNU+OIEwk7Oq7qqjcFZU4tZE1un/7G5FZIriLaG/lwO/VT1NzvCTtu8wWvoLfcZCV1VtG1yy3rNGy68YnONhL8fS+OBb5A+L9X5SSvmVJGwAbgZ6UI6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IH9Rsjrm+WBDG/R9OCNHbwwCQuYPNN+so0mjjrxIOY8=;
 b=ZMmUPJ8L9vToU6fsVa3RbTiLB80hlCdtX3OCFzR2cXNfJgU1H7JTlVYAN9jrdUSGtrjAdmZ74pCNjrcIjB/y/htiLJs8VX4S+GUhipElsZAUIiiIT3+g0Ey4JFlToSiHJ1OBnkt1MgEeVou68Nwch6psj7ZKXRtd69JonYnq/FLDguLI/XKjClpQQZ8OBYagkmY06Ia2yjmmVBUmTpcJqIPm8AY3lXT6VhxIggEygMgOAPNYC2ifTPLWKxnp8hClwCLKO5urPgcfC07CKQPdEK5ENXQz4r06TWK0LzOKfyRWReQIoyC5cggSUskT0uvuCk3p03g5h3/zl7rJhGZ83Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IH9Rsjrm+WBDG/R9OCNHbwwCQuYPNN+so0mjjrxIOY8=;
 b=BkWVEXbhLn0JZppIqUsp9zmsVUkvuYGc6y7s8ezLUX75vPt/r0Y1Ktc+SmHpoec1hYheriILlecM+itw8NFVrPbByBvd3w9j1lMP6R5psP9mpcSTxjEburx0Ppoy+/u9h0fGY/HiGKCnmtknb6N0fZGnxxYu1RJ+wvZpebXmoEc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO4P265MB6429.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2e1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 20:47:19 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0223.017; Tue, 21 Jul 2026
 20:47:19 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 Jul 2026 21:47:18 +0100
Message-Id: <DK4JLF37634O.8XPVFOVD80TP@garyguo.net>
Cc: <aliceryhl@google.com>, <daniel.almeida@collabora.com>,
 <ojeda@kernel.org>, <boqun@kernel.org>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <tmgross@umich.edu>, <tamird@kernel.org>, <work@onurozkan.dev>,
 <bhelgaas@google.com>, <kwilczynski@kernel.org>,
 <gregkh@linuxfoundation.org>, <rafael@kernel.org>, <mhi@mailbox.org>,
 <driver-core@lists.linux.dev>, <rust-for-linux@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] rust: irq: make Registration compatible with
 lifetime-bound drivers
From: "Gary Guo" <gary@garyguo.net>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>
X-Mailer: aerc 0.21.0
References: <20260719153631.559341-1-dakr@kernel.org>
 <DK4C5GHMXU5G.287NUJIM67T6O@nvidia.com>
In-Reply-To: <DK4C5GHMXU5G.287NUJIM67T6O@nvidia.com>
X-ClientProxiedBy: LO4P265CA0119.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c6::6) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO4P265MB6429:EE_
X-MS-Office365-Filtering-Correlation-Id: ae09c33f-8a94-4cad-1779-08dee7694176
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|10070799003|23010399003|366016|6133799003|18002099003|22082099003|3023799007|56012099006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info:
	LFfdo3HkCqQOd+ZKyT3c4SiBH9DG/mC+NQ45/qG0VxcPb1y73LvqYX9NDBd/JUVpxPJ5+to+GM0fVy+vr751bqUM5m0dw585lQ+m8P5rTZm/+CHemJdfLMCOB92OWVlQ+M5LpMYqN0aiyDWOcfnOPi13GMk6hcbXwvoJt5kISDHSbokHqv6Cp/PhuamZbTWT1r7eDceG1C+DTJfxFqMlNN+ZnDl2nvff38Prq9gKP5remZGG2IDZN12ipqvC9AfnOmzuc9xf1bGdN727wRPyWGi6uvpBTqxPNSF1F5SFd6akA1i/FVkScvWfnPd2tTXNHfyyATesaZZ/6qmXSjS9cXsAlD5vbvWPt86Jzz0mBI3yQzBNak5R4hek63RsAnrix2vnFV21qofXpeEvCRzp5aocDpvpjSw4GKlySbGXOCMdgUztHKWZqUGY1W5dqQ4SNgZpb6LpQiATAprCfJDbiODfFYj511b/73qjOFNRqXVQBKRdBtq9UHS8cynLOOM1tC+P0KtsEC0u1++6egCdF5n35AxYaumHrfppbui2devG09uE9HUumaAKB2Ne1Bc0eH7mGG67mY1n+ARrAE8OSQWMrN4W9NSgEV0JKmheq/O7VJx7U+RRh1KzKccrzbIkxjbpWKO7g1wzto0C5/8T7MBf+Tl0xp46fe11vNyyzsc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(10070799003)(23010399003)(366016)(6133799003)(18002099003)(22082099003)(3023799007)(56012099006)(4143699003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R3pnV05Ja1ZQZ3FJUTk1R2YwT292OTg0WkVFdFNyMm9XRlo0bUFUVGJBUHls?=
 =?utf-8?B?UzJIWUltUXgyaHo5blpoNkoyVjRURXZhOGlKcDloVXFxVmRBdnA5QktyeTY4?=
 =?utf-8?B?R1Vsczcrd1Z5eHpnT3V6SGFUeUFtdGxsNmhHQTkwK2p0WTZGaVd5MG42eW51?=
 =?utf-8?B?UmI3VDhQNWxDUzJobmZrNGo1aTZoTlBabjV6TFpkRU9kb01zdjZyUy9MSkVT?=
 =?utf-8?B?ZDJDa1kraU1qNUpnU0JlR3pCckRxSStzVzBDUGxRcUVCY1dRb2lHN0ZGMEZ2?=
 =?utf-8?B?MUNwVjhYRjNtc1VKZzcxaXQ2RWw1RWk1VTIxbHlsSVNOcHNqeVJ4RDVDM09j?=
 =?utf-8?B?cDEvZUl1TFQ5MDZQcEVEZUR3dG5VbUtWN3JKRE9ZWmxhYmtuMGFSV3JraFU4?=
 =?utf-8?B?TXZneit5RGRFc1QrS1dBK0NxVThmVmxQRjJjdURzdWJWMnhqQmxEQ2tBTW5k?=
 =?utf-8?B?Ym9XOW5oTFZ6Y2hhK0dZOFZERDhGVmlYbDY4MVV1UjZWaUFnRURqRHdMZGFB?=
 =?utf-8?B?TEV1YjB2MDRhWGZVN2hsUzZyVVUwc2l5UktZOTUrK21Xd0NRYk1JRzJrZG5X?=
 =?utf-8?B?YUZjZkkydktBTkpvd00xd0Z2TU1QMlVGSFBORTRzUmt4K2k1NWdVenNPeG5J?=
 =?utf-8?B?cHFHS09IZXlKSUxrcnNLTkJBLzAwYjdubS9va1g5U2t3enB2Nm93b0lRb3d3?=
 =?utf-8?B?WkFTSDFXSWRUejVRTU1Qc1dNVGdJcjdOZXhtWVBtR3ZIQ0JJRHNPOU5yRFZZ?=
 =?utf-8?B?M2IwWURBMVdQTEFSd1JNWWg2elJ4TStIYWFxQjBkOHYvb01RZFUxUWNzRlV0?=
 =?utf-8?B?a3NGR3ZsTndyZWpJa2N3dU4rVWVCaUFBRjIycENrWThXelRBMjR0eHNRYncz?=
 =?utf-8?B?ZGFFVm5BUHVJb1lhVHlIa01qYmFORGdOcVptQy9IRzQrUVo1S2tCaUtDaFZt?=
 =?utf-8?B?NTdBYlJ5VVE0ejl0djFtOEJiaGxwQVBCN3F5OXZvNHVHb2N0cVhqOGNtaEhv?=
 =?utf-8?B?b1huVzYwRnRMMVN4bldiQjJsb0pHaG9lQW85S3d5WXMyKzFKajJYYmphMXNT?=
 =?utf-8?B?TU5URHREMUtBNktzZXhvVTVZZkJxaHpqZG9CdWhWb2FhMU1vV0ZsY0RlVGJo?=
 =?utf-8?B?ZGxEM0ZIL3crQ3c4NjFTZ1FkaDlmTm05V3NUdjg1MTRjSHZaR3EyU0FBZ2U2?=
 =?utf-8?B?RUJ6Q1pGaHdDRWs2QzRaUyswMDBralVWajVxZis3R0ZuM0dpRG9IRGpnR3hv?=
 =?utf-8?B?YTlqS3JiUksvVGh6RTl0cmthaStrNVR6blVWdTdiQnRTSFI5eDlTTk9hK3Nt?=
 =?utf-8?B?clhHWDVWc0tBWU5VMkd1UGdQRzFNYlVTS2FDci9tdVZmdnh5WHl1VWl6cFpR?=
 =?utf-8?B?TUlWZ21zMjgzb0ZaREdVSjAxY081WWdTUXQ3M2NKbEV0bVo1N0Vkd0F3OFAz?=
 =?utf-8?B?alVEc1I1OGU2aEIrSkFuQWF6VFpnL0M0Nkt5d2VHazBrbnpwLzVjS3FlRjdM?=
 =?utf-8?B?RnlTU3FBUDBOZE54MnhBSzBKYmpzNkkxUmVrVlZ0Q1RSMzNqa01pdXk3eVJP?=
 =?utf-8?B?aWw1VXMwcE1ENGlsb1Y4L1RpL1U4ekZQcU9YS21FUkF6YVk0V09ZVk42ODh4?=
 =?utf-8?B?T1NoOFhSRVJ4Tkg2NTMyNnhoVGlyUXN1YTU5OWkwSWdKWFgyYzNuUWpZZ0xn?=
 =?utf-8?B?dXh6OVZVNHJZanVRYVRjOVJkajFoNndxOTkzZWloSTlCUDgvNFhuc0JBeTdw?=
 =?utf-8?B?c3Zqblo1YlFEN21TWVpnVjNBVlZzSDZpWC9qaEFHbEZ3UVlpWS9aa0F2OFVy?=
 =?utf-8?B?bXJ4OVd4S1UwczB2NTNHdkgrSHo4RmhSMSt5YnkwL25JRUNHcUtoL0NVUXFP?=
 =?utf-8?B?NGJGcWEyYzNiVmI5cjdoRjFjckJJSUtqVjR4NmgwOW14TEF0NE16Q3lyY09V?=
 =?utf-8?B?NlFZaGVwMFdhYlRhbUFmS05NK2t4VmtyWnJXZnpjTFhTalhvclYwbG1YWGd1?=
 =?utf-8?B?RkFWSjJLOStSTHU2eFF4K2RHcTlzdk91bldEcDJGNFpHTDRoaGpJaFJNTW5N?=
 =?utf-8?B?UWwreUhFTlMyc25ieVdJb1B2dG5vT1FvcnR3YXNuakZkdnJlTE9wNG0xR1pn?=
 =?utf-8?B?WXQ1ZDlvbmdUMnU2d2Q5b1ArY3BaK25TUWs3RHVLOHRSUTlFTkllck1YMG5V?=
 =?utf-8?B?TG1SdXhKK21QWCsxVjZGQzRWVDgrdXlPMDVMV1g3RTNLaS81WjBaTHlWMWxy?=
 =?utf-8?B?dGNqcVhIQzk3eTZ1UjNtSWRVcEIzQzRFNU45M2kxVDJmczZrM0ViOXZQUVhD?=
 =?utf-8?B?eDVTUU8yMGUzd3UzR3ZXWFp1TndNUU01SjlnSzZRNXE4VGhLMk45Zz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: ae09c33f-8a94-4cad-1779-08dee7694176
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 20:47:18.9712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +K0oha+rfmDAWAnS7cnlQlJEmziN5NH6pIrREGV/mTJ1snSDMNXMqhbEe7p+DY4E34mYUSF/zTu+8C09nngbtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P265MB6429

On Tue Jul 21, 2026 at 3:57 PM BST, Alexandre Courbot wrote:
> On Sun Jul 19, 2026 at 8:36 AM PDT, Danilo Krummrich wrote:
>> Adapt the IRQ registration to work with the Higher-Ranked Lifetime Types
>> (HRT) device driver architecture introduced in commit 2c7c65933600
>> ("Merge patch series "rust: device: Higher-Ranked Lifetime Types for
>> device drivers"").
>>
>> With HRT, driver structs carry a lifetime parameter tied to the device
>> binding scope, allowing device resources such as pci::Bar<'bar> to be
>> held directly rather than through Devres indirection. However, the IRQ
>> abstraction required Handler: Sync + 'static, preventing handlers from
>> embedding lifetime-parameterized resources.
>>
>> Remove the 'static bound from Handler and ThreadedHandler and replace
>> the Devres<RegistrationInner> indirection with direct request_irq() /
>> free_irq() calls in the constructor and PinnedDrop.  Registration<'a, T>
>> stores the IrqRequest<'a>, which structurally ties it to the device
>> binding scope.
>>
>> Also remove the &Device<Bound> parameter from the handler callbacks,
>> since handlers that need device access can embed it in their own type.
>>
>> IRQ handlers can now directly own device resources:
>>
>> 	struct IrqHandler<'irq> {
>> 	    bar: pci::Bar<'irq, BAR_SIZE>,
>> 	}
>>
>> 	impl irq::Handler for IrqHandler<'_> {
>> 	    fn handle(&self) -> IrqReturn {
>> 	        let stat =3D self.bar.read(regs::STAT);
>> 	        ...
>> 	    }
>> 	}
>>
>> This eliminates the indirection previously required for IRQ handlers to
>> access device resources and aligns with the broader goal of expressing
>> every registration scoped to a driver binding through compile-time
>> lifetime bounds.
>>
>> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
>> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
>> ---
>> Changes in v2:
>>   - Move request_irq() / request_threaded_irq() to _: blocks.
>>   - Add INVARIANT missing comments and missing #[inline] annotations.
>> ---
>>  rust/kernel/irq/request.rs | 432 ++++++++++++++++++-------------------
>>  rust/kernel/pci/irq.rs     |  26 ++-
>>  rust/kernel/platform.rs    |  48 +++--
>>  3 files changed, 255 insertions(+), 251 deletions(-)
>>
>> diff --git a/rust/kernel/irq/request.rs b/rust/kernel/irq/request.rs
>> index f425fe12f7c8..c1c6525a676a 100644
>> --- a/rust/kernel/irq/request.rs
>> +++ b/rust/kernel/irq/request.rs
>> @@ -5,16 +5,21 @@
>>  //! [`ThreadedRegistration`], which allow users to register handlers fo=
r a given
>>  //! IRQ line.
>> =20
>> -use core::marker::PhantomPinned;
>> -
>> -use crate::alloc::Allocator;
>> -use crate::device::{Bound, Device};
>> -use crate::devres::Devres;
>> -use crate::error::to_result;
>> -use crate::irq::flags::Flags;
>> -use crate::prelude::*;
>> -use crate::str::CStr;
>> -use crate::sync::Arc;
>> +use core::marker::{
>> +    PhantomData,
>> +    PhantomPinned, //
>> +};
>> +
>> +use crate::{
>> +    device::{
>> +        Bound,
>> +        Device, //
>> +    },
>> +    error::to_result,
>> +    irq::flags::Flags,
>> +    prelude::*,
>> +    str::CStr,
>> +};
>> =20
>>  /// The value that can be returned from a [`Handler`] or a [`ThreadedHa=
ndler`].
>>  #[repr(u32)]
>> @@ -27,7 +32,7 @@ pub enum IrqReturn {
>>  }
>> =20
>>  /// Callbacks for an IRQ handler.
>> -pub trait Handler: Sync + 'static {
>> +pub trait Handler: Sync {
>>      /// The hard IRQ handler.
>>      ///
>>      /// This is executed in interrupt context, hence all corresponding
>> @@ -36,73 +41,20 @@ pub trait Handler: Sync + 'static {
>>      /// All work that does not necessarily need to be executed from
>>      /// interrupt context, should be deferred to a threaded handler.
>>      /// See also [`ThreadedRegistration`].
>> -    fn handle(&self, device: &Device<Bound>) -> IrqReturn;
>> -}
>> -
>> -impl<T: ?Sized + Handler + Send> Handler for Arc<T> {
>> -    fn handle(&self, device: &Device<Bound>) -> IrqReturn {
>> -        T::handle(self, device)
>> -    }
>> -}
>> -
>> -impl<T: ?Sized + Handler, A: Allocator + 'static> Handler for Box<T, A>=
 {
>> -    fn handle(&self, device: &Device<Bound>) -> IrqReturn {
>> -        T::handle(self, device)
>> -    }
>> +    fn handle(&self) -> IrqReturn;
>>  }
>> =20
>> -/// # Invariants
>> -///
>> -/// - `self.irq` is the same as the one passed to `request_{threaded}_i=
rq`.
>> -/// - `cookie` was passed to `request_{threaded}_irq` as the cookie. It=
 is guaranteed to be unique
>> -///   by the type system, since each call to `new` will return a differ=
ent instance of
>> -///   `Registration`.
>> -#[pin_data(PinnedDrop)]
>> -struct RegistrationInner {
>> -    irq: u32,
>> -    cookie: *mut c_void,
>> -}
>> -
>> -impl RegistrationInner {
>> -    fn synchronize(&self) {
>> -        // SAFETY: safe as per the invariants of `RegistrationInner`
>> -        unsafe { bindings::synchronize_irq(self.irq) };
>> -    }
>> -}
>> -
>> -#[pinned_drop]
>> -impl PinnedDrop for RegistrationInner {
>> -    fn drop(self: Pin<&mut Self>) {
>> -        // SAFETY:
>> -        //
>> -        // Safe as per the invariants of `RegistrationInner` and:
>> -        //
>> -        // - The containing struct is `!Unpin` and was initialized usin=
g
>> -        // pin-init, so it occupied the same memory location for the en=
tirety of
>> -        // its lifetime.
>> -        //
>> -        // Notice that this will block until all handlers finish execut=
ing,
>> -        // i.e.: at no point will &self be invalid while the handler is=
 running.
>> -        unsafe { bindings::free_irq(self.irq, self.cookie) };
>
> Not directly related to this patch, but I think it would help to add a
> comment explaining why it is ok for `drop` to own what looks like a
> mutable reference to `Self` (and thus `Self::handler`) while a handler
> might be running holding a non-mutable reference to the latter.
>
> My first reaction upon seeing this was that this breaks the Rust
> aliasing rules, but looking at the feedback for the initial patch [1]
> revealed that the issue has been discussed and dismissed.
>
> Since this is quite subtle, and to avoid this being flagged again in the
> future it would be nice to explain why this is safe (IIUC
> `PhantomPinned` combined with the fact the destructor never forms a
> `&mut handler`, but this needs to be vetted by someone more familiar
> with these matters than I am).

If we want to play safe, we could wrap this inside `UnsafePinned` (or `Opaq=
ue`),
but that's actually problematic because doing so will change the variance o=
f `T`
from covariance to invariance, and we actually want covariance here. There'=
s no
way to opt out, so it's not good. (`T` is never mutated here and we only pi=
n it
for self-reference purpose).

I left a comment on the `UnsafePinned` tracking issue about this:
https://github.com/rust-lang/rust/issues/125735#issuecomment-5038853925

Best,
Gary

Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020126.outbound.protection.outlook.com [52.101.196.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0ED41D126;
	Fri, 31 Jul 2026 12:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785501520; cv=fail; b=cL6ODE4NMgu6TL2mGSmDbUI1tGSCBVIhDU0FKwBmccT4gMhyNsf6UadRnPbNiRv3KM2kcJ2JKdyDf+EgNWO1Is688EOUu7PGm1lVUCeG8Vc6SjaWO9bEV/0AdhSKvk7IMcJmCEzlKFkKHCDH/kmp+wcvGfbij1NqaUWasH0lYy0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785501520; c=relaxed/simple;
	bh=3Rf0ti2Z028ZYMvYv3Te2abVhu8ne1XNqzcpgC14O4Q=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=gGabPUyNobRgU3Xx4t2DGNSh0dXPsZeF5wvkitC0DkOAc64dXtihkoEYETDW4SQn7Oiade7WLZlufdguARbIUcNtg36Uf6qndVwmVGYZBSLM5xWr5rOk/neBDFaSzIMDuJ694mcGpzA4C9FbeMa1PeBjl4OBjPbcQ9gxZ9tvuws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=q6pJlWY5; arc=fail smtp.client-ip=52.101.196.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="q6pJlWY5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IC3KItthLRpY3WAhbp0p0D1uAzQsI2stgAoUTfaeFrg2VOPetAmUn4bFfWObRg9BEFW7DGLEwbGqt7x6/MYdsBIivWzSI3OkKrLfePpzDiHHvW36ZclQ/L0z6ghfdfqLAqLGCkOM0HCiQd/oPDQWNHMkCt9V1seJbpP/IoM6WxIQCrQBHQ8y791b1q8v4eM2j6koBVoe9TxLt6fZVne1tkrjDqr8dvr3im+wc7EI6LkOHaXiID1pjxMfOeY272uGaQaPT6dF08imuSYiQqjSKg2CjpOTUlKFMdRWx7jfQToa3wsv2eUpiNNn2BNO4w8O/Zg3vMIuZiCl0IUS1QzgWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zsL/liwtk5HPag76pq9uo25GFZ8u0V1msE2rz8G+JZE=;
 b=uTf0IGVpnH1ScTOpg9n9A42ITuYj66g29h0GZraBAv8cd7iciOeR+AjWzdfPQgJrBzqcf6Cd+MR5RQ6rxrxuKdGV/1lz4KoSOaMApaUQp8A+9UU/aCUi0kSxTl+5VnLRL3RxQh90uIELR4fPXtM9/FKGSh0qM6xFhB/aw4/F3GSMjlh2H90yrsXX/Rq9XDx8uTWypbRQTPphu6nNCheWVpaw8OvwyginF1lMFiJ3lAdQGId+oR9sCjCuU6Dcz39faTKzmHFz6N2QQbx8La3PSPqnQ2Y7tdzBjbS/GYBm2E7/2KXKajvyGemytfjmYmRzC1c995yH/7yPtOmriqh8kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zsL/liwtk5HPag76pq9uo25GFZ8u0V1msE2rz8G+JZE=;
 b=q6pJlWY5YPOxQkQju5Z6z1ydYpHzKS1TXaRBnmqy4SaHnWVyS1Pr3y5VEc4qIZqtEH6Ak3qOLwkculI/7r4/XPBoyRRpsZ721Sw6/xvStfrA/1FQZcwtdnsLPZYEHulIFp2wIhaLz8b3gTAuF1H07PK2UWt8oG6XVDRvDaD0ODQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWLP265MB7242.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1f3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.16; Fri, 31 Jul
 2026 12:38:33 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%2]) with mapi id 15.21.0270.015; Fri, 31 Jul 2026
 12:38:32 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 31 Jul 2026 13:38:32 +0100
Message-Id: <DKCRGMZJXO6X.1SWGREC78DH0W@garyguo.net>
Cc: "Zhi Wang" <zhiw@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <dakr@kernel.org>, <aliceryhl@google.com>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <tmgross@umich.edu>, <markus.probst@posteo.de>, <cjia@nvidia.com>,
 <smitra@nvidia.com>, <ankita@nvidia.com>, <aniketa@nvidia.com>,
 <kwankhede@nvidia.com>, <targupta@nvidia.com>, <kjaju@nvidia.com>,
 <alkumar@nvidia.com>, <joelagnelf@nvidia.com>, <jhubbard@nvidia.com>,
 <zhiwang@kernel.org>
Subject: Re: [PATCH v6 1/1] rust: pci: add extended capability and SR-IOV
 support
From: "Gary Guo" <gary@garyguo.net>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.21.0
References: <20260730182954.783568-1-zhiw@nvidia.com>
 <20260730182954.783568-2-zhiw@nvidia.com>
 <DKC4MR1ZBQMP.3L7X2C96OJLFU@garyguo.net>
 <DKCO1B3HUGD1.1IP1J7ZZ5MHCH@nvidia.com>
In-Reply-To: <DKCO1B3HUGD1.1IP1J7ZZ5MHCH@nvidia.com>
X-ClientProxiedBy: LO4P265CA0008.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ad::16) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWLP265MB7242:EE_
X-MS-Office365-Filtering-Correlation-Id: d1299cb2-c352-44ec-78cc-08deef00a1c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|23010399003|6133799003|3023799007|56012099006|4143699003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	m1OoxRU/rWopKNUdEBswCfzqbsaXuIQbpDoIKDORUh/C5RWs+n339Eag2hg1qe/kAQufUVpS0MtyK+NdQGZrZnmGLj0uFSGex9m+ufUndGfxm8MLkyDjkrzN1NWkKSYBT78SwWALT3oCaTtNHaLMcgh6NVJSVyqszy1uRbIXoDR1sOFS0NUnbIHBE6WUstMb/HP0Kea0fehMPjQITj8i/0nav/YRxaB7Y+sXj2B1x+am/x2HFTVMZA08EUyIyBOL4PB+uUs9ThfTMm70xmwg9WVwKoqIkv1US1KSy5vJnOxugkOHeMmhN0FAO38iVkywPHZbpuGBkjOPUMBVMAn+JFmgWBlKgPKtYZMkhipHpM6BRnV+QD8kGDzIt6UnZI+EVUngzgnU6Ym4GowiSIFzA4obV6G7sg6MGmzZ75Pf0KuzI2cpP2aqQIykrA+GpXsr8JrVM6wnp5OhujegH+FW0D2YM8XuUBTF1v+BlQcOWPHKj2Ran9GuNKkgh1TkEMnJBSWV2anXl5pxp1mzdQNwzwjXTrwoDNT4bhthuprxIxBPoRrX3hbeiO6QU+6Gq05l40/Ew2jVv/+OcY827l3ApXAfqxej4tFs6PqKqIocDKvb5iZnaQ8Q6xpWIaTWvtCQ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(6133799003)(3023799007)(56012099006)(4143699003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b215Z1RkSzdsN1hZTUFnN1FibENxckt3cmFjankvSlpTRWJHOFp3U054dzRU?=
 =?utf-8?B?TGV4VmxueWpZUUp2RDBzZi8zc2tNd3ZjS3BzVmJpa1BLeU55WkNTYUxtQzhz?=
 =?utf-8?B?UzNyTlAvNEdIZmZzRnQ4VTZJRDMrb0cxaFhVQUxVKzBiYnV4UmNBd1pzbmRp?=
 =?utf-8?B?UHh3bVRMV1IyWWxRbHBqY2ZVdzZTdThkd0wvN3VtSnAzMHFaNjRkcnVOaHRJ?=
 =?utf-8?B?WXpoWlVsVForUkdTdHh1ZnF6YVE3WWxMWFVUMm9sTDhUQ0xoSzR5ek5jbHlP?=
 =?utf-8?B?amdHSHNObWx1S1dRQThlVmw2NWpJUWFhanpOT1FQaWtObzllQThQVE91RzNC?=
 =?utf-8?B?dE80bVAyL2NxMGN2ZUluTUFHSTNrdGY3NXJxb3VMbXVUNks1clZrRFc5VjY2?=
 =?utf-8?B?VVM2WnRJc1FpNlB1MlZvQWt3WkRFZmkyUWt2Wk9tWUxNbGVZY2ppbjJHV1Vl?=
 =?utf-8?B?eFJHRUV2bmVRVWJPcURMTmJId1BXbGt2aDhiR2dVK09kenNRcVZVSm5DTUxy?=
 =?utf-8?B?NjNiU3pxcnV3VVZpcjZxSW5EVUpzL2tkOS9nbjJDRFpaNWNEZ1lmZW9NRm4x?=
 =?utf-8?B?QWZ5WmRXcGtYNHZQT3JIN25pZUliWGVyTUVCSWp0RVhsMy96TVVKUXd6RldE?=
 =?utf-8?B?ZDZvWk9xckVPOFIya3ZEVytIT3hYZ0JleHViNnB3bzU1MCsrT1FWK0t6Qzdh?=
 =?utf-8?B?MnpBOTRzbTZWYUFPSlg2MUZxbkRzMXlUNVFYMWJnWkZicWdWT2tlT3ZMRDdO?=
 =?utf-8?B?dlBveVBEcHYwb1lLNjFpUXJuM1c3S29Dc21sOG9NVy9pSVR0T1NGVnhCZ0lj?=
 =?utf-8?B?VENOMlVzeUlHRURJL3k4czAzUi9TeUFVeWd6SUZrMEU5VzdibHFVZ3Frdmlh?=
 =?utf-8?B?TjltMnBGRW9kcVczcnhjRk50UUl2OUZPVzJUYitSZUVxUHVmb0ZZYVRQTUJm?=
 =?utf-8?B?cnJsRzZQWHZsa3g3ZDFoRE9SQS8wSndLOVBRV0pPOENqVDgxcTNzM0xybnJk?=
 =?utf-8?B?NFQwZHJ4dXZxYVFxd0hwa2xvWjNKUFZTcU83WjhnN2FUWTZsVmxIb1lLRFV6?=
 =?utf-8?B?MnNCRW5SYWlFMzFNQU5sM1h0MXE2R1c4eXl1aGM4NkVZckttRDdhWFlLd25O?=
 =?utf-8?B?dTd5aEVpck5hT0tlUWxhN0FIREh4andyNGlvelRyUmJOcG4reDk4eE1ORlFx?=
 =?utf-8?B?S3dRZDRVUG9wK3JQRmpHSlJiWHJxMFRWR0lMczZYQXZvYWlOY1hFTGx2MmlV?=
 =?utf-8?B?ZGNOeGkzZ1ZqK0JxTnRZUldhbW5FSXNMOURubXBhcGNMM0N5bVlYd2tsamZ0?=
 =?utf-8?B?dHRFRnNJTmllZ216cFBNUVQwRytwcUJLcHRCMWwyTkpmVnlNRU1nU2d3SThU?=
 =?utf-8?B?VEVrdURDY0UweGFkc0hOaGVYY0lFemdPcGowaU1mSDlySmVkZnRIYlArTEJ2?=
 =?utf-8?B?VXpLbHBKWU1VNXk4MUdUWiswczcxR0xPdjQwS1lpbHNYYUh3anUyME9FR2RM?=
 =?utf-8?B?QjZGbXBxQXpIR1l2YlRxcU5yMVB5Tk8xZnR3NVd5dDlpdG1VVlQwZHk0Q0gy?=
 =?utf-8?B?bDVaOW5wVDYwUFIxNXgydWJJRndtYnRMVEJudCtKUGx5b09pUk5LVStnTXl5?=
 =?utf-8?B?cjhPRlp5TllURmdYUmdCRnJ5SUF2YVE5UDloZTJYVUNMUUVBdXJ2UGE2b0p0?=
 =?utf-8?B?cU9zVmRnUWp4YmUrUVlDUldZS0M5VGVydGpNT1hyU0VMa0NRL3JTSkZzL0Y1?=
 =?utf-8?B?RHlqVHVIOCtBRUhLYmloT1B0KzBxZGlTVzhSeklteHNpNGpYZ3VkenlkQkhS?=
 =?utf-8?B?NzFFNlpMSW1XOHhpS2pFeHF1VFRxSHZPZzlqaFlwekRLV0lGdWljUUxCQ0E1?=
 =?utf-8?B?MHRQMjA3QVY2SUlSS0JkZXQzZ1lHTXBQc01ENm10OVY0Zi9BREFzTlpxa21M?=
 =?utf-8?B?RzQyOWlZWTNFbzVZNkdqaWNpcEc5YVpnRFF6WEVVVGZrV2JjV3JEVVg2dk9a?=
 =?utf-8?B?MEdaaXVQMmM5aEhKay92cmJnMXFLdmlWSTZubWhUM0ZFWEZyWk9wck8xZmZU?=
 =?utf-8?B?bjFzVi94Y1hwd09iNHlUQ0ZtYkUvamhPeUVaVjFxalZyOUIvV1NQUTFkVmdi?=
 =?utf-8?B?a2RPRExwVHphT09BSWF2UjNlZHZIK3NBenVhc3dXL0dMRzEzb3BTenNWNVg4?=
 =?utf-8?B?ZEw5Rk9MNk9zU2RUZU41QmUxVTQwdGhJVWpOeVN0ZVRHcHd4bnFFZ21wOWYw?=
 =?utf-8?B?cG1rclNLTzNYY3c0dDc0WlpDd3FnQzlNUmZMQUV1VWpNRHFMUUdzOVFUb3VB?=
 =?utf-8?Q?rJN0rbKjIFftp+8EBD?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: d1299cb2-c352-44ec-78cc-08deef00a1c7
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 12:38:32.7569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 37ETMYoPZdVnol8KLF8X59zSZwreQjdlMsvaj3l0rgXD2yFnb3PhQY4sdq3TGTpkFYqp26mUwg2I7a6ECMB0WQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB7242

On Fri Jul 31, 2026 at 10:57 AM BST, Alexandre Courbot wrote:
> On Fri Jul 31, 2026 at 3:45 AM JST, Gary Guo wrote:
>> On Thu Jul 30, 2026 at 7:29 PM BST, Zhi Wang wrote:
>>> Rust PCI drivers have no typed interface for locating and accessing PCI=
e
>>> extended capabilities.
>>>
>>> The SR-IOV extended capability describes VF topology and VF BARs. Expos=
e
>>> this information through the Rust PCI abstraction so drivers can use th=
e
>>> existing typed configuration-space accessors instead of raw bindings.
>>>
>>> Define ExtCapability to associate a capability ID with a register layou=
t,
>>> and add ConfigSpace::find_ext_capability() to locate and project that
>>> layout. Bound the view at the next capability or the end of extended
>>> configuration space. Add ExtSriovRegs and a decoded VF BAR helper that
>>> returns the address, width, and next configuration-space slot, using
>>> PCI_SRIOV_NUM_BARS for the number of BAR slots. Since PCI_EXT_CAP_NEXT(=
)
>>> is a function-like macro, expose it through a Rust helper.
>>>
>>> Link: https://lore.kernel.org/rust-for-linux/20260730180349.771719-1-zh=
iw@nvidia.com/
>>> Cc: Alexandre Courbot <acourbot@nvidia.com>
>>> Cc: Gary Guo <gary@garyguo.net>
>>> Signed-off-by: Zhi Wang <zhiw@nvidia.com>
>>> ---
>>>  rust/helpers/pci.c     |   5 +
>>>  rust/kernel/pci.rs     |   8 ++
>>>  rust/kernel/pci/cap.rs | 236 +++++++++++++++++++++++++++++++++++++++++
>>>  3 files changed, 249 insertions(+)
>>>  create mode 100644 rust/kernel/pci/cap.rs
>>>
>>> diff --git a/rust/kernel/pci/cap.rs b/rust/kernel/pci/cap.rs
>>> new file mode 100644
>>> index 000000000000..08c044bedb70
>>> --- /dev/null
>>> +++ b/rust/kernel/pci/cap.rs
>>> @@ -0,0 +1,236 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +
>>> +//! PCI extended capability support.
>>> +
>>> +use super::{
>>> +    io::ConfigSpaceBackend,
>>> +    ConfigSpace,
>>> +    Extended, //
>>> +};
>>> +use crate::{
>>> +    bindings,
>>> +    io::{
>>> +        Io,
>>> +        IoBackend,
>>> +        Region, //
>>> +    },
>>> +    prelude::*,
>>> +};
>>> +
>>> +/// Number of VF BAR register slots in an SR-IOV capability.
>>> +// CAST: `PCI_SRIOV_NUM_BARS` is 6, which fits in `usize`.
>>> +const NUM_VF_BARS: usize =3D bindings::PCI_SRIOV_NUM_BARS as usize;
>>> +
>>> +/// Attribute bits encoded in the low DWORD of a memory BAR.
>>> +const VF_MEMORY_BAR_ATTRIBUTE_BITS: u32 =3D bindings::PCI_BASE_ADDRESS=
_SPACE
>>> +    | bindings::PCI_BASE_ADDRESS_MEM_TYPE_MASK
>>> +    | bindings::PCI_BASE_ADDRESS_MEM_PREFETCH;
>>> +
>>> +/// PCI extended capability IDs.
>>> +#[repr(u16)]
>>> +#[derive(Debug, Clone, Copy, PartialEq, Eq)]
>>> +pub enum ExtCapId {
>>> +    /// Single Root I/O Virtualization.
>>> +    // CAST: `PCI_EXT_CAP_ID_SRIOV` is `0x10`, which fits in `u16`.
>>> +    Sriov =3D bindings::PCI_EXT_CAP_ID_SRIOV as u16,
>>> +}
>>> +
>>> +impl ExtCapId {
>>> +    fn as_raw(self) -> u16 {
>>> +        self as u16
>>> +    }
>>> +}
>>> +
>>> +/// A typed PCI extended capability register layout.
>>> +///
>>> +/// Implementors describe the register layout of one extended capabili=
ty. The layout must start at
>>> +/// the extended capability header, and [`Self::ID`] must identify tha=
t layout.
>>> +pub trait ExtCapability: FromBytes + IntoBytes {
>>> +    /// PCI extended capability ID for this register layout.
>>> +    const ID: ExtCapId;
>>> +}
>>> +
>>> +impl<'a> ConfigSpace<'a, Extended> {
>>> +    /// Finds and projects an extended capability into its typed regis=
ter layout.
>>> +    ///
>>> +    /// # Examples
>>> +    ///
>>> +    /// ```no_run
>>> +    /// use kernel::pci;
>>> +    ///
>>> +    /// fn probe_sriov(
>>> +    ///     pdev: &pci::Device<kernel::device::Bound>,
>>> +    /// ) -> Result<(), kernel::error::Error> {
>>> +    ///     let sriov =3D pdev
>>> +    ///         .config_space_extended()?
>>> +    ///         .find_ext_capability::<pci::ExtSriovRegs>()?;
>>> +    ///
>>> +    ///     let total_vfs =3D kernel::io_read!(sriov, .total_vfs);
>>> +    ///     let vf_offset =3D kernel::io_read!(sriov, .vf_offset);
>>> +    ///     let bar0 =3D sriov.read_vf_bar(0)?;
>>> +    ///     let bar1 =3D sriov.read_vf_bar(bar0.next_index())?;
>>> +    ///
>>> +    ///     Ok(())
>>> +    /// }
>>> +    /// ```
>>> +    pub fn find_ext_capability<C: ExtCapability>(&self) -> Result<Conf=
igSpace<'a, C>> {
>>> +        let offset =3D usize::from(
>>> +            // SAFETY: `self.pdev` is valid by the type invariant of `=
ConfigSpace`.
>>> +            unsafe {
>>> +                bindings::pci_find_ext_capability(self.pdev.as_raw(), =
i32::from(C::ID.as_raw()))
>>> +            },
>>> +        );
>>> +
>>> +        if offset =3D=3D 0 {
>>> +            return Err(ENODEV);
>>> +        }
>>> +
>>> +        let size =3D self.calculate_ext_cap_size(offset);
>>> +
>>> +        let base =3D ConfigSpaceBackend::as_ptr(*self)
>>> +            .cast::<u8>()
>>> +            .wrapping_add(offset);
>>> +        let ptr =3D Region::<0>::ptr_try_from_raw_parts_mut(base, size=
)?;
>>
>> The signature should be=20
>>
>>     Result<Option<...>>
>>
>> where the result is usually handled via `?` and `None` needs to be handl=
ed
>> explicitly, rather than matching on ENODEV.
>>
>>> +
>>> +        // SAFETY: `offset` was returned by `pci_find_ext_capability`,=
 and
>>> +        // `calculate_ext_cap_size` bounds `ptr` at the next capabilit=
y or the end of the extended
>>> +        // configuration space. `ptr_try_from_raw_parts_mut` verified =
the region layout.
>>> +        let capability =3D unsafe { ConfigSpaceBackend::project_view(*=
self, ptr) };
>>> +
>>> +        capability.try_cast::<C>()
>>> +    }
>>> +
>>> +    /// Calculates the size of the extended capability at `offset`.
>>> +    ///
>>> +    /// The capability extends to the next extended capability, or to =
the end of the extended
>>> +    /// configuration space if it is the last one. `offset` must be a =
DWORD-aligned offset within
>>> +    /// the extended configuration space returned by `pci_find_ext_cap=
ability`. If its header
>>> +    /// cannot be read, the capability is treated as the last one.
>>> +    fn calculate_ext_cap_size(&self, offset: usize) -> usize {
>>> +        let header =3D self.try_read32(offset).unwrap_or(0);
>>> +        // SAFETY: Pure bit manipulation, no preconditions.
>>> +        // CAST: The next-cap pointer is a 12-bit field (max 0xFFC), a=
lways fits in `usize`.
>>> +        let next =3D unsafe { bindings::pci_ext_cap_next(header) } as =
usize;
>>> +
>>> +        if next > offset {
>>> +            next - offset
>>> +        } else {
>>> +            (*self).size() - offset
>>> +        }
>>> +    }
>>> +}
>>> +
>>> +/// SR-IOV register layout per PCIe spec (64 bytes starting at cap off=
set).
>>> +#[repr(C)]
>>> +#[derive(FromBytes, IntoBytes)]
>>> +pub struct ExtSriovRegs {
>>> +    /// Extended capability header.
>>> +    pub header: u32,
>>> +    /// SR-IOV capabilities.
>>> +    pub cap: u32,
>>> +    /// SR-IOV control.
>>> +    pub ctrl: u16,
>>> +    /// SR-IOV status.
>>> +    pub status: u16,
>>> +    /// Initial VFs.
>>> +    pub initial_vfs: u16,
>>> +    /// Total VFs.
>>> +    pub total_vfs: u16,
>>> +    /// Number of VFs.
>>> +    pub num_vfs: u16,
>>> +    /// Function dependency link.
>>> +    pub func_dep_link: u8,
>>> +    _reserved_0: u8,
>>> +    /// First VF offset.
>>> +    pub vf_offset: u16,
>>> +    /// VF stride.
>>> +    pub vf_stride: u16,
>>> +    _reserved_1: u16,
>>> +    /// VF device ID.
>>> +    pub vf_device_id: u16,
>>> +    /// Supported page sizes.
>>> +    pub supported_page_sizes: u32,
>>> +    /// System page size.
>>> +    pub system_page_size: u32,
>>> +    /// VF BARs (BAR0=E2=80=93BAR5).
>>> +    pub vf_bar: [u32; NUM_VF_BARS],
>>> +    /// VF migration state array offset.
>>> +    pub migration_state: u32,
>>> +}
>>> +
>>> +impl ExtCapability for ExtSriovRegs {
>>> +    const ID: ExtCapId =3D ExtCapId::Sriov;
>>> +}
>>> +
>>> +/// A typed view of an SR-IOV extended capability.
>>> +pub type ExtSriovCapability<'a> =3D ConfigSpace<'a, ExtSriovRegs>;
>>> +
>>> +/// A decoded VF memory BAR.
>>> +#[derive(Debug, Clone, Copy, PartialEq, Eq)]
>>> +pub struct ExtSriovVfBar {
>>> +    address: u64,
>>> +    is_64bit: bool,
>>> +    next_index: usize,
>>> +}
>>> +
>>> +impl ExtSriovVfBar {
>>> +    /// Returns the BAR address without PCI attribute bits.
>>> +    #[inline]
>>> +    pub fn address(&self) -> u64 {
>>> +        self.address
>>> +    }
>>> +
>>> +    /// Returns whether the BAR is 64-bit.
>>> +    #[inline]
>>> +    pub fn is_64bit(&self) -> bool {
>>> +        self.is_64bit
>>> +    }
>>> +
>>> +    /// Returns the configuration-space slot index of the next logical=
 BAR.
>>> +    #[inline]
>>> +    pub fn next_index(&self) -> usize {
>>> +        self.next_index
>>> +    }
>>> +}
>>> +
>>> +impl ConfigSpace<'_, ExtSriovRegs> {
>>> +    /// Reads and decodes the VF memory BAR at configuration-space slo=
t `bar_index`.
>>> +    #[inline]
>>> +    pub fn read_vf_bar(&self, bar_index: usize) -> Result<ExtSriovVfBa=
r> {
>>
>> Do you expect people to pass in a random index instead of 0 or next_inde=
x? If
>> not, this should be an iterator. Otherwise it'd be possible to index int=
o high
>> part of 64-bit address.
>
> I made a similar suggestion on patch 3 [1], and I think Zhi kept the
> index for ergonomic reasons. But given that not all indices within range
> are valid, an iterator indeed sounds safer.
>
> [1] https://lore.kernel.org/all/DHRTUAF52GNI.1J98TSAG1LS6Q@nvidia.com/
>
>>
>>> +        if bar_index >=3D NUM_VF_BARS {
>>> +            return Err(EINVAL);
>>> +        }
>>> +
>>> +        let low =3D crate::io_read!(*self, .vf_bar[try: bar_index]);
>>
>> Given the bound checking above I'd use `panic: ` here.
>
> Or better, one could just remove the `if bar_index >=3D ...` block, and
> keep the `try:`. That way it will be used for what is was designed for,
> the bounds checking will be done against the actual size of the array
> and not a constant that also happens to be used as the array size, and a
> dedicated error code will be returned instead of the ubiquitous
> `EINVAL`.

`projection::OutOfBound` converts to `ERANGE` so it'll be different. Also, =
when
this is converted to iterators, for the first case you'd probably want to j=
ust
return `None` and for the second case log an error that the device is havin=
g out
of spec capability.

Best,
Gary


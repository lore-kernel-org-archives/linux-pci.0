Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010031.outbound.protection.outlook.com [52.101.56.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53B65519A6;
	Wed, 14 Oct 2026 15:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791991065; cv=fail; b=gManLqVR4OTcp6h4Uv9xR1WRAQlHn7I9jJRLM/cCGO95TSWoLyLCAZh19T1l7a/lMKof6/ottZNII2tQ0sjuuD5U1eEy9WV4M3t2HyNIFFQfQW6nHO5AOvaBpNb3YjlDIPb+C4QXyxnIChd7FW8pzT8SypqgLhBSskDVP/NhpcM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791991065; c=relaxed/simple;
	bh=d6R7HD8+yJ0QinuayNBrsXN2LLFO26BS9dRY/zzb+UA=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:References:
	 In-Reply-To:MIME-Version; b=mwBHUln14EYKniOSv2f7sTbeqDYRvKYXs39iQklwm60sm9AMsREJzB8NNB8TntnRakPAaxsvR261lfiu92DvzVEl+S0rLq8kCjP3LIJH4veWYMHPE+UYtLcgNsatXYD3KZSxem91+BELf3Lo7EMMeTY5AhdjNRXtLKXVkRhKljQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gJNUJPg0; arc=fail smtp.client-ip=52.101.56.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gJNUJPg0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qfMYKaqPI+Zkc2BiVQLmF50aVMuEdkjbG6vRwUIGoo8CFWHPqDhvjZJ5En8KiqLSwkyaCyUfbH0dbVdC3w2twZfurLp53dbw/p9xa7jnym07Or7RYX/QVnPatmJJBHy+qwGytHMDhpEAPsXJLPo8/fYS7Zi7toi1Rw5Z8/K1HFlrmseP2LtZs4+MeBXJCvjKkQCnPXxSCc2m50ND3dhki3ugm4Etwcf8AFabDPmBEFzihN1BpKLfJwJqGMjgGtiRe7XzsliNqKzYfSGHose7JNwbcvLpUiQTAtH7+CduCICY1PjTwBDGcIrIqIURpEfwznHwB6XcIWZszaMeQcRTVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=18Sh1oQJWsj2fNknm0Go6wv0FjwQP2TLctxKQXyaqiY=;
 b=xZJAz2KYPyO1ZQ1Vuj09F/wr+M5m3dBLyDGZ+q02n7kGLOrgvKRTMORXMBMMv/nFkfpF/3ugIRE4DKTF9iKtFqUuj/qx3H3e+lRQ4wEbiULsKbYrWS2c/ZFvPUEqVR9aET5f+tBS2LudvIgBIZ1mvoqxLbPmg/HjCjudU4H0AYecLme5dMDZk1vsnRuIiBngWKgZEhukH8DQlNU7hvJcI+ATFOyxratC9moiszJciJi6KJU07NbqV9VktyqXOv/gUF2Xc03NB4eLht/JmOavBXQw1zml3eqP4sJEJbYI6d2va1Ow34aAzbYp/Jz+gnQPUk9WM6mrWLp1iXOct4LOJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=18Sh1oQJWsj2fNknm0Go6wv0FjwQP2TLctxKQXyaqiY=;
 b=gJNUJPg0+Wi6XdHNn7I5UPU2jfNbFlx4o3LENasDHcVUxcjcY/rPbRMbdxyqFapCzavrxkk/+Uc0C7lCYjWcoLchCMKoXb9GwiIu8rgbJpee9KOmU3n9QWSFB7mPp2qd4KDgD7s5fjT/026umMNZ0PJdsqzlUOQnpcp1AuAnG9sC9yYyWdGBB/TCtu61Ogwf9Fnp2no0v7CK5eG/P3n3Sgjy6zN24pbUrCGOYNuABOlcwM+CoU8KOcTc9JVysYPHyQ/oCpNrQz9dDtaczrsICaGEWBOm0M6znfwhZ6YfAwbsHj3fw76ibd+zQHJr//IEonRdAs3tSlh1ZqQ7hp4aoA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by PH7PR12MB5880.namprd12.prod.outlook.com (2603:10b6:510:1d8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Wed, 14 Oct
 2026 15:17:36 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0522.011; Wed, 14 Oct 2026
 15:17:36 +0000
Content-Type: text/plain; charset=UTF-8
Date: Thu, 15 Oct 2026 00:17:30 +0900
Message-Id: <DM4NT7TFX4X9.1GFI128LI5ZQ4@nvidia.com>
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: <alistair23@gmail.com>
Cc: <lukas@wunner.de>, <linux-cxl@vger.kernel.org>,
 <akpm@linux-foundation.org>, <Jonathan.Cameron@huawei.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <jic23@kernel.org>, <bhelgaas@google.com>, <alistair@alistair23.me>,
 <djbw@kernel.org>, <linux-pci@vger.kernel.org>, <wilfred.mallawa@wdc.com>,
 <a.hindborg@kernel.org>, <gregkh@linuxfoundation.org>,
 <alex.gaynor@gmail.com>, <aliceryhl@google.com>, <benno.lossin@proton.me>,
 <boqun.feng@gmail.com>, <bjorn3_gh@protonmail.com>, <tmgross@umich.edu>,
 <gary@garyguo.net>, <ojeda@kernel.org>, "Jonathan Cameron"
 <jonathan.cameron@oss.qualcomm.com>
Subject: Re: [PATCH v4 10/22] lib: rspdm: Initial commit of Rust SPDM
Content-Transfer-Encoding: quoted-printable
References: <20260928011123.450800-1-alistair.francis@wdc.com>
 <20260928011123.450800-11-alistair.francis@wdc.com>
In-Reply-To: <20260928011123.450800-11-alistair.francis@wdc.com>
X-ClientProxiedBy: TYCP286CA0261.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:455::12) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|PH7PR12MB5880:EE_
X-MS-Office365-Filtering-Correlation-Id: acbe7f06-0719-4322-5d33-08df2a0645c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|10070799003|23010399003|6133799003|13003099007|10067099003|22082099003|18002099003|3023799007|4143699003|11063799006|261009223027099003|56012099006|5023799004;
X-Microsoft-Antispam-Message-Info:
	Ra1RhI5vkyunl+lsmbIBJ0SAWirXomBo+UWXpzyojVrtm+nguZnj5NWZchlMshnPHT3RjG0pLlGtxs15sJ1mhOwtcFnhdaNoU9yCkrAHo8PdhAmSCL3zUHuBF7mP9lkuBNzFmIQpBgMvNHZcguSczO1f2YhYc0/kCA651QIQBjqA8H9AX2O8LY9BtQk+7tCFeM61bC7fyyG9ZI3vo8xTYZyIl1aIeJiXg5aia7vRLcKPUWpg3y5XTevrG9jmm3jQI0If7Zu+3jGtxHKIXyh06JV9Wwo+ODLA7nW6fHsqRxSuRcqpQ28E70Y7GElquUGLZ4buIIGRAP1QrOs+2hVMZVfNlGEbkgyoqs7J2wl5NO3liM5ruQM24ALU3eByPZVzxHIhF8AnQXKioAzZDZbBwxvyvHyo7/k00N2cqERj6YHeX4ZH/OMSnLGTueBosb9k4hYAlJVGu1RA6UyJJAOE3ZtpBahbDR9pOjDXPGfoKnMfUII15zjUjwLDfSj+vg1s8UYmvnm48+PlAcynDFHyD6RCaZjcmIQ3ttG9WOgI0AWvtHckAwQEKJKb3Qpim3VDZ+6TDxDFVMlqFDq46xpA/M74G/DqlmnCmQGkt866QHioi/D4xnrIc1Ylmiqo2dKRvMBtGhDFLnh7LYkfSx1xEYdzZ1C64XFfokiSlVWtr0c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB6873.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(10070799003)(23010399003)(6133799003)(13003099007)(10067099003)(22082099003)(18002099003)(3023799007)(4143699003)(11063799006)(261009223027099003)(56012099006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dVVHRGVQYUVsOGtPdWVNMHFsWFVHQXBpdWlCbUg3cmxrVE5JcE53OHdVTmtn?=
 =?utf-8?B?SWtYMFFBVTRTWGZTYjFTMktOY2x4Mm1DR1gwY3NjM0kyN2F1bElIS01CRFdo?=
 =?utf-8?B?UzNHOW5KQUVLa0ZiZEZkdFd0eEJ1N0s3eTdxd0JkMUpNdm55MUVsNzUveWt4?=
 =?utf-8?B?ZElUT3VSQ0EvUnV4Nm4xY2o5eUV5MGNVWUxOL3k4aDhEV1E1dzBwYVNQNmJX?=
 =?utf-8?B?bmljT1ZwaW1XZXp4M3hBZXBkU1Q5RmRrVWUxeVlUVEN3TXZOMi96TDZCWmRV?=
 =?utf-8?B?M1dxY2l6NjM4NUV5MW0yWENPM0tkRFNsSGZyK0gzNFIwanRDanhLL1NIRUNa?=
 =?utf-8?B?Tk5mOXdySlNrRUtPQlZOazFxZ216ZWc2U0p4MENLZ2JtNG5DZ2IxbXprUkFW?=
 =?utf-8?B?dzZSVThnc3NBQU1xNlBVYXUxS2xSNDF4N3FuL3VUK1kxSU1KWXd0Q3dqZWpk?=
 =?utf-8?B?OW9JTXFtVnBuTFRUVmRsbWVCY2lpWkswd1R2bW5KNlRBbFI2Z0R6SUJwbE5C?=
 =?utf-8?B?aW5Fbm9CdXdjY2JwUE4raGJneEdzMHcrdDJOWlVqRHU5bXRQdzAwOGJGUlN0?=
 =?utf-8?B?VHY0WkllN1UzeDV0RWZkWk1DamdCMkZKNnV4U1RUaHpseGw1R0x5ZitsbC8r?=
 =?utf-8?B?ZnpwYTB2K21ubDFmdHdYWFNDWTl0VXQra2NPQzhBc1hHYXBjdmJmODdiTExG?=
 =?utf-8?B?OHJDQXVOQVZnM1NkbEs0NGFxcml6RWllSlA3T0xkMTBYQklZaWlwQjZ5TUNW?=
 =?utf-8?B?TWhpcEJjSEhnSllGaUI0WVBOVGp1d01LRHpjN01KZGhXaG1UNlRqQU9EUmVn?=
 =?utf-8?B?RERQYUdJTUt5OURsamRWUFU3WDFjYklxUlE3c1dSQUJES2Q1ZnNPeGNSdXhC?=
 =?utf-8?B?Z3EzcFBYQkVBK3JjS1l5WmlwdHFxVGlKUytPUTVJOWFZZDRUaXNDMC9iT2xp?=
 =?utf-8?B?RkhrbHg0b2p0UFpWc2NjRUFhZ0ticG0zaVJRcERDNlNjTnRmUzk1aUlReFNv?=
 =?utf-8?B?RkhSTHBRU2xWS3I0eTRuUzZrQkRQWnd6TkNCQ0xocGlBVVNWOXhuQk1HZnVi?=
 =?utf-8?B?emR6bXRIeG1aVFg4TWxmZzdnNjhOZmR0MmRyNFdYQkhJMmRCa2lwSDhHem42?=
 =?utf-8?B?Uk84MFNKbGNZTXcxN005MmtpTDExVFNScGhTQVZ0VS9xL0tBaloxNVZVc0RR?=
 =?utf-8?B?MVBJU05iNE1QWVZ1V0xUSC9FMEE1bjFZYTIvNnY4NVJCb2ZpRTdFZk92Umlv?=
 =?utf-8?B?cURNUzI2QTFwMkZNaVZNcmZOSHN0NmZROVZNTHYrM1JZSWcwRnJCdUJ1M1Bs?=
 =?utf-8?B?ZmdCMlZxNXV5QVlYRUhNNWtFVjJJY1ZTNWhXTmEwMllxK0k5dVMwdjNhRzI4?=
 =?utf-8?B?Q25VaWJEMG9HMllQQkZwbjZFZzl0WDRTd1c4UkN0bVpxZ29EaW1HT1VwQkRq?=
 =?utf-8?B?RWpoL2Vka3JDZmVjRG4xV0pmc1FnYkpwM2JJeXBGcEVWcmcwVThFMnV6RWZR?=
 =?utf-8?B?dVZKeVZkbEZwdnh0ckd4bkNaekFoVEhXNGx5VEo2cGhWdGZjV1AyM0hlSmdU?=
 =?utf-8?B?cGJRaWVjeG02N1pUOFJSL3IrR21wdERXa3ZUbjFlSHRVNWtSNXJBVml5RUU1?=
 =?utf-8?B?d29jQWVDQngzM2p4T3R2TS9HUUtFa014dEhrSWs3YTJzYUhkbXhVeGt3Ukl4?=
 =?utf-8?B?NlFSSy9EMFpwMHYvOWlGRE42V01aaTBCaWNCZk1pczkyWGdPUXVGZFlKSy9X?=
 =?utf-8?B?VGNZdktCNU1HSi9RL05tREx1ZFZpclhtL1Z6cFFMU04yWnlQMm1KZm9pM1Rm?=
 =?utf-8?B?SmxMNE9GTnFKTkNGdkNYWGxLN2VRdHFOTXl4eWpTeHRubGwxQ1creEhuN1Qz?=
 =?utf-8?B?LzloQWdiZjRyZ1BXZXdyV0IveFRrNlYzdmE2bVdVNzNhMEVQcHQvdEE4TTlu?=
 =?utf-8?B?Z3FsY0pmZ1ZCc0puSFJtb05YQVZYMW9mS2J0ODVRbUlHSGxLbEgzTmZ2R3VP?=
 =?utf-8?B?N3Njak1hOWk5SUV5T1g0U3lxRk1wQ2M1TnBWYTJZV3AzVmFSOG5WSExScUpR?=
 =?utf-8?B?SE05Vk92QTVkZ3FpK2FXK1JUcTdzLzRlV21oNmpPNVdBS05qRU9WeDB0UFcy?=
 =?utf-8?B?SGo5cXJFK2p3UUZIWWdvcGJCRm1NSDlnVmkyK3MwcWFqejlrTW04cFhYYnVi?=
 =?utf-8?B?eTl2YzZyNDloYTBuSDBLbHZjNnJQMk9MbjB5NXZBU0RxWFBtVnFvZFVPeitx?=
 =?utf-8?B?dUFtSCthaHZMWGZwRkIzajFobVJUL01DeW9LWitab1A3bmpTODVVUmZBeGtz?=
 =?utf-8?B?T3Exb29xOUhSVTdqekpiLzdTT3l2R0kxTE9tR1NFTU9SWjJrdWxHeTBCUkxn?=
 =?utf-8?Q?vSPECVCIDLOIG3h0EVMTLprRFrs/BhtXadrvHoVtqKUdz?=
X-MS-Exchange-AntiSpam-MessageData-1: HRVVi4dVtuFZMw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acbe7f06-0719-4322-5d33-08df2a0645c9
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 15:17:35.9825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zO8ipgziArU4zqd3RekyZ3BpivhqFwoBZIZPF7Wxw2Kj7q6x19SpgIJhBNcjr+xqFd9jlrC5KHiiF8OdKEvZdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5880

On Mon Sep 28, 2026 at 10:11 AM JST, alistair23 wrote:
> From: Alistair Francis <alistair@alistair23.me>
>
> This is the initial commit of the Rust SPDM library.

This commit message deserves to be a bit more verbose. :)

<...>
> diff --git a/lib/rspdm/consts.rs b/lib/rspdm/consts.rs
> new file mode 100644
> index 000000000000..9709f51849d7
> --- /dev/null
> +++ b/lib/rspdm/consts.rs
> @@ -0,0 +1,92 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +// Copyright (C) 2026 Western Digital
> +
> +//! Constants used by the library
> +//!
> +//! Rust implementation of the DMTF Security Protocol and Data Model (SP=
DM)
> +//! <https://www.dmtf.org/dsp/DSP0274>
> +
> +use kernel::error::{code::EINVAL, Error};

This can just be `use kernel::prelude::*;`.

> +
> +// SPDM versions supported by this implementation
> +pub(crate) const SPDM_VER_10: u8 =3D 0x10;
> +
> +pub(crate) const SPDM_MIN_VER: u8 =3D SPDM_VER_10;
> +
> +#[allow(dead_code)]
> +pub(crate) const SPDM_REQ: u8 =3D 0x80;
> +#[allow(dead_code)]
> +pub(crate) const SPDM_ERROR: u8 =3D 0x7f;
> +
> +#[derive(Clone, Copy)]
> +#[repr(u8)]
> +pub(crate) enum SpdmErrorCode {

This is in `consts.rs` but is not a const... Actually everything in this
module looks like it should be in `lib.rs`, and by doing so you could
also remove the `pub(crate)` visibility.

<...>
> diff --git a/lib/rspdm/lib.rs b/lib/rspdm/lib.rs
> new file mode 100644
> index 000000000000..1010bd38df6d
> --- /dev/null
> +++ b/lib/rspdm/lib.rs
> @@ -0,0 +1,96 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +// Copyright (C) 2026 Western Digital
> +
> +//! Top level library for SPDM
> +//!
> +//! Rust implementation of the DMTF Security Protocol and Data Model (SP=
DM)
> +//! <https://www.dmtf.org/dsp/DSP0274>
> +//!
> +//! Top level library, including C compatible public functions to be cal=
led
> +//! from other subsytems.
> +
> +use crate::bindings::{
> +    spdm_state,
> +    EPROTONOSUPPORT, //
> +};
> +use core::ffi::{
> +    c_int,
> +    c_void, //
> +};
> +use core::ptr;
> +use kernel::prelude::*;
> +use kernel::{
> +    alloc::flags,
> +    bindings,
> +    new_mutex,
> +    sync::Mutex,
> +    types::ForeignOwnable, //
> +};
> +
> +use crate::state::SpdmState;
> +
> +const __LOG_PREFIX: &[u8] =3D b"spdm\0";
> +
> +mod consts;
> +mod state;
> +mod validator;
> +
> +/// spdm_create() - Allocate SPDM session
> +///
> +/// `dev`: Responder device
> +/// `transport`: Transport function to perform one message exchange
> +/// `transport_priv`: Transport private data
> +/// `transport_sz`: Maximum message size the transport is capable of (in=
 bytes)
> +/// `validate`: Function to validate additional leaf certificate require=
ments
> +///  (optional, may be %NULL)
> +///
> +/// Return a pointer to the allocated SPDM session state or NULL on erro=
r.

The commenting style is a bit all over the place in this series,
sometimes using the Rust style, sometimes the C kernel style, sometimes
apparently something else.

For Rust items, please follow the Rustdoc style. These functions though
are the C FFI interface though, so they are useful to the C callers and
as such I think their documentation belongs to the interface file (i.e.
`include/linux/spdm.h`).

<...>
> diff --git a/lib/rspdm/state.rs b/lib/rspdm/state.rs
> new file mode 100644
> index 000000000000..c894cf30bb87
> --- /dev/null
> +++ b/lib/rspdm/state.rs
> @@ -0,0 +1,241 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +// Copyright (C) 2026 Western Digital
> +
> +//! The `SpdmState` struct and implementation.
> +//!
> +//! Rust implementation of the DMTF Security Protocol and Data Model (SP=
DM)
> +//! <https://www.dmtf.org/dsp/DSP0274>
> +
> +use core::ffi::c_void;
> +use kernel::prelude::*;
> +use kernel::{
> +    bindings,
> +    error::{
> +        code::EINVAL,
> +        to_result,
> +        Error, //
> +    },
> +    validate::Untrusted,
> +};
> +
> +use crate::consts::{
> +    SpdmErrorCode,
> +    SPDM_ERROR,
> +    SPDM_MIN_VER,
> +    SPDM_REQ, //
> +};
> +use crate::validator::{
> +    SpdmErrorRsp,
> +    SpdmHeader, //
> +};
> +
> +/// The current SPDM session state for a device.
> +///
> +/// Concurrent access is serialised by wrapping the whole struct in a
> +/// `Mutex<SpdmState>` at the FFI boundary, so `spdm_authenticate()` cal=
lers
> +/// run one at a time and the locked `&mut SpdmState` is the only way to
> +/// reach the inner fields.
> +///
> +/// `dev`: Responder device.  Used for error reporting and passed to @tr=
ansport.
> +/// `transport`: Transport function to perform one message exchange.
> +/// `transport_priv`: Transport private data.
> +/// `transport_sz`: Maximum message size the transport is capable of (in=
 bytes).
> +///  Used as DataTransferSize in GET_CAPABILITIES exchange.
> +/// `validate`: Function to validate additional leaf certificate require=
ments.
> +///
> +/// `version`: Maximum common supported version of requester and respond=
er.
> +///  Negotiated during GET_VERSION exchange.

Field documentation should be their own doccomments before each
individual field (see [1] for an example and general good practices when
writing Rust doccomments).

[1] https://doc.rust-lang.org/rust-by-example/meta/doc.html

> +#[expect(dead_code)]
> +pub(crate) struct SpdmState {
> +    pub(crate) dev: *mut bindings::device,

This makes me very nervous. I see this is passed to C callbacks. We need
to maintain the guarantee that the device still exists, so an
`ARef<Device>`, from which you obtain a pointer to pass to the C
callbacks, should be the minimum here. Does the device also need to be
bound? Looking at `drivers/pci/cma.c` it seems to be. Then this needs to
be a `&Device<Bound>`, with a lifetime to `SpdmState` so callers only
use it while the device is bound.

Just storing a C pointer and passing it whenever a function needs it
cancels the purpose of using Rust and make the safety requirements of
the callback you pass it to impossible to guarantee, as nothing enforces
that the device still exists or is in a valid state when they are
invoked.

> +    pub(crate) transport: bindings::spdm_transport,
> +    pub(crate) transport_priv: *mut c_void,

Here I also suspect we want to define some kind of ownership model for
the private data instead of hoping that the pointer is still valid when
we use it.

> +    pub(crate) transport_sz: u32,
> +    pub(crate) validate: bindings::spdm_validate,
> +
> +    // Negotiated state
> +    pub(crate) version: u8,
> +}
> +
> +impl SpdmState {
> +    pub(crate) fn new(
> +        dev: *mut bindings::device,
> +        transport: bindings::spdm_transport,
> +        transport_priv: *mut c_void,
> +        transport_sz: u32,
> +        validate: bindings::spdm_validate,
> +    ) -> Self {
> +        SpdmState {
> +            dev,
> +            transport,
> +            transport_priv,
> +            transport_sz,
> +            validate,
> +            version: SPDM_MIN_VER,
> +        }
> +    }
> +
> +    #[allow(dead_code)]
> +    fn spdm_err(&self, rsp: &SpdmErrorRsp) -> Result<(), Error> {

`&self` is never used - this should probably be a method of
`SpdmErrorRsp`.

> +        match rsp.error_code {
> +            SpdmErrorCode::InvalidRequest =3D> {
> +                pr_err!("Invalid request\n");
> +                Err(EINVAL)
> +            }
> +            SpdmErrorCode::InvalidSession =3D> {
> +                if rsp.version =3D=3D 0x11 {
> +                    pr_err!("Invalid session {:#x}\n", rsp.error_data);
> +                    Err(EINVAL)
> +                } else {
> +                    pr_err!("Undefined error {:#x}\n", rsp.error_code);
> +                    Err(EINVAL)
> +                }
> +            }
> +            SpdmErrorCode::Busy =3D> {
> +                pr_err!("Busy\n");
> +                Err(EBUSY)
> +            }
> +            SpdmErrorCode::UnexpectedRequest =3D> {
> +                pr_err!("Unexpected request\n");
> +                Err(EINVAL)

These blocks are getting repetitive. Instead you can implement `Debug`
on `SpdmErrorCode` and `From<SpdmErrorCode> for Error`, and get rid of
this method entirely as callers will be able to print the error directly
and have it automatically converted to the kernel error type.

<...>
> +    /// Start a SPDM exchange
> +    ///
> +    /// The data in `request_buf` is sent to the device and the response=
 is
> +    /// stored in `response_buf`.
> +    #[allow(dead_code)]
> +    pub(crate) fn spdm_exchange(
> +        &self,
> +        request_buf: &mut [u8],

This shouldn't need to be mutable?

> +impl<'a, 'c> Validate<'c, Untrusted<&'a [u8]>> for SpdmHeader {
> +    type Err =3D Error;
> +
> +    type Context =3D &'c SpdmState;
> +
> +    fn validate(unvalidated: &[u8], _context: &'c SpdmState) -> Result<S=
elf, Self::Err> {
> +        Ok(SpdmHeader {
> +            version: *unvalidated.get(0).ok_or(EIO)?,
> +            code: *unvalidated.get(1).ok_or(EIO)?,
> +            param1: *unvalidated.get(2).ok_or(EIO)?,
> +            param2: *unvalidated.get(3).ok_or(EIO)?,
> +        })

Here you will definitely want to leverage zerocopy's `FromBytes` trait.

> +    }
> +}
> +
> +#[expect(dead_code)]
> +pub(crate) struct SpdmErrorRsp {
> +    pub(crate) version: u8,
> +    /// This will always be SPDM_ERROR (0x7F)
> +    pub(crate) code: u8,
> +    pub(crate) error_code: SpdmErrorCode,
> +    pub(crate) error_data: u8,
> +}
> +
> +impl<'a, 'c> Validate<'c, Untrusted<&'a [u8]>> for SpdmErrorRsp {
> +    type Err =3D Error;
> +
> +    type Context =3D &'c SpdmState;
> +
> +    fn validate(unvalidated: &[u8], _context: &'c SpdmState) -> Result<S=
elf, Self::Err> {
> +        Ok(SpdmErrorRsp {
> +            version: *unvalidated.get(0).ok_or(EIO)?,
> +            code: *unvalidated.get(1).ok_or(EIO)?,
> +            // `try_from` rejects unknown `SpdmErrorCode` discriminants.
> +            error_code: SpdmErrorCode::try_from(*unvalidated.get(2).ok_o=
r(EIO)?)?,
> +            error_data: *unvalidated.get(3).ok_or(EIO)?,
> +        })
> +    }

Same here.

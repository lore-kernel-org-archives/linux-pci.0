Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021141.outbound.protection.outlook.com [52.101.95.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6601539A802;
	Thu, 30 Jul 2026 18:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785437113; cv=fail; b=fAG1isiAkhlIBn2faj+yGlD8+T9vtU6jmJxTRoGHV7EEpK5ZOnAjAwnz3ctw2ReMWyQOfT7g3xxGqOEThxNMLRMe/uk871s1uIrgLaQDuZlFNtyPVCYvJXzk5jt/W1ZyDImoRQM3CntRQem84/h7gbbG5/Fv6F+DAGJRPbpxIJI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785437113; c=relaxed/simple;
	bh=s+Li011wacHhxnDJeMu3jMr8mkszBuwT388t7uhJdV4=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:References:
	 In-Reply-To:MIME-Version; b=hnH9L8cPHrhEoQquAwmvm18m2l+sRv8bpwx4SQHWpi2zOKQYY3CpK+8v3FmesQTgGpSKtN3I9hsv/DvRf/9nxRAikQWgVsFW/Bm+1sUQZLxiLdjG++qmY4e5nYFaAzatReLFtlpPZeeqEF8f41zBbjazK1Tkt6scYViJ/zvk1aA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=o4EnA/NN; arc=fail smtp.client-ip=52.101.95.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="o4EnA/NN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vCwMEA5+DVkxd75bAco4PvmN1kJLoIx5eMMS0pmhnDwO5c+YwHMUaqT7l0xpUpquO9rAHLskBD+tj8TlKQNt77WC7AXoKEjTszMPollARbJf5y2IHqdL9vP/7QzZksYSeguBfivAFXpXOScUK4iyNCDkC4dV/udYrwPRbXDfETZ3yWMkcbK29sY3Qu8jNFFZwWux8gpT7WUJ3fcqNVCLGFzyYLYuy3Iqdi7Uhrn2zLmwDZizNhDMDal888oCmzeg6ZPIJ1BDfqyN73M0RPc8WlZvPZHNo/QyZ3bWiv2ntFTKUBaesyiemkkBe57JDuyYbYFtQtuWP1H0BH8AY7RjGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AvNIBCLwA14WU239uqXspgZW9YeeT4GhJg0F/s+l7T0=;
 b=toWQ7HLswpyoDMN4qpJoQxE8k3s1JB+X4QJjSqzUixm9A5lYmm4vV53nzuSfukm+94kj0SSe8p4yD7fvwtkEksdV5YM50SY8F9Nt6xKt6uFgZzJ6stBBypIMmUVZDLCVCwblSRdcnO52sSxUHOs1pOReeUYYD0wIxG8F7y821+yAWtg5+WERoDYH2s2ddPyUVOEXH8gFutNwt4V0su20Egf0xGbk0Xiui1nvotvWqcR9QpTOExpvTmAlIdn4H2I0wE5kSHrL+Z7HR/dPrGhJVEtdFKhn9hf0jE5EM4NmzZev4AYzdr3HheNcQKZWyGhZi8mROIuDcMyhuXMRVZ0OVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AvNIBCLwA14WU239uqXspgZW9YeeT4GhJg0F/s+l7T0=;
 b=o4EnA/NNcr4VAN8njoxiVpvlhJ/Uu0qh2xz11TwTKySDsQ2z+bTj01/su5sadKvg4SM8T6NjQU2qwm2iQrdcPNAu+BUesEkCw3rXJzxYAnegzXCk3DVWThqH7ijZH83myuJRohDMuHSWpK5ZgCJp8YxTPTGtFMjDzWBeeugtH/4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO0P265MB3241.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:154::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Thu, 30 Jul
 2026 18:45:06 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%2]) with mapi id 15.21.0270.012; Thu, 30 Jul 2026
 18:45:06 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 30 Jul 2026 19:45:05 +0100
Message-Id: <DKC4MR1ZBQMP.3L7X2C96OJLFU@garyguo.net>
From: "Gary Guo" <gary@garyguo.net>
To: "Zhi Wang" <zhiw@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Cc: <dakr@kernel.org>, <aliceryhl@google.com>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>, <markus.probst@posteo.de>,
 <cjia@nvidia.com>, <smitra@nvidia.com>, <ankita@nvidia.com>,
 <aniketa@nvidia.com>, <kwankhede@nvidia.com>, <targupta@nvidia.com>,
 <kjaju@nvidia.com>, <alkumar@nvidia.com>, <acourbot@nvidia.com>,
 <joelagnelf@nvidia.com>, <jhubbard@nvidia.com>, <zhiwang@kernel.org>
Subject: Re: [PATCH v6 1/1] rust: pci: add extended capability and SR-IOV
 support
X-Mailer: aerc 0.21.0
References: <20260730182954.783568-1-zhiw@nvidia.com>
 <20260730182954.783568-2-zhiw@nvidia.com>
In-Reply-To: <20260730182954.783568-2-zhiw@nvidia.com>
X-ClientProxiedBy: LO4P123CA0484.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a8::21) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO0P265MB3241:EE_
X-MS-Office365-Filtering-Correlation-Id: fbdc7b96-09b0-4d2b-5ae6-08deee6aaca5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|10070799003|22082099003|18002099003|56012099006|4143699003|3023799007|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	KQc0/FaIwktNKvhxjJI8QXsZgdJ4gQ+wwes93Hfn1PQs9fb6SQ7sGffJ4n4a5ONS1U3Z2iW+g2VmMSQlfAPjFOjBdahImabg4o3c7Qg4QdyVaZHfwAo3QOHUpAy4D1EDgpDesLMlGOsu0E7dRa7YqlsrzfFa/kIsPkGZqVnEVl192gn+yVlBQb3XFlmP2Zi95jydgiSFZEncdehK97Hu0TGQJpqvUGaUiEDISRZRWK4aXJL7Gkir8Clo6Q0fbtrYlAlwoIsnrVWLSfWSw9UZ44cw4la84WOFgOEFO8iEJ6xxH9Z5sX+LajBixKyZLUGu+B0FLUJFM2BDL97TcuZ17+IJne+ybUMstNLoYVYcScuPJpwBL1rTIoMy+BXXz+FvewWOCBrt9IdlKC4q261Si6ma1/i08qAFpe8z8f48ITYTGJQ6bVbB4/oIMjFOeMZa/anOdajuWlA16f/aMQ3iIM/H0Bv2s8Zj5a/9pw6mY7cVVwlzoN7pq0DxxpbVLaPPf5c3eawAi2cOfBJckZo5JrJ6hC74T/L8uYwTsCCrEwfKBLkeCeGwm4BcxfD4N3Yw3kdAwKFKA5woNQiXjAotnKBYWe3fDUh/cmSbKfw4Z5CCY8BFppjkYaWPPHsR525ffbfePLzjrRCIVLDZrh15RRojawmisyiQxZYSua7BWeE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(10070799003)(22082099003)(18002099003)(56012099006)(4143699003)(3023799007)(6133799003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cDhaWGxWSkNXcDNjVXVERWFOQUNadVc4QnhRY0JrMXlrUVhCUm81VHVoOWJJ?=
 =?utf-8?B?UE9JUGo3cnNCRG1vRE9xWmI2d0IybnFXRzl5YWU1M0Q3YS9mZll0SjFsVXcy?=
 =?utf-8?B?Z1BadVlSaFdTa3A1QXQxc2NrNzBQZWg3blZLT2h3M29wVDg5YUJKczYyUllG?=
 =?utf-8?B?TWpqUkFvbzJMNXZxalA0WVA1cXE5aTRyWXBWL1h2S3E1K0hzNFBDU3ZWd2JZ?=
 =?utf-8?B?bmVHejNnSmUzN2xDcW52RXVaVlQ1QTBLWkpkZWVkak1RQkVTa1dNYlNkVGJY?=
 =?utf-8?B?V3BHN2RldDk0NG9kdVgzRDczWHpZR3RUN0kvS2FkOGlVOWVBRFB0T05aVjR0?=
 =?utf-8?B?NVdBYTNEUU0zZUtmczVDVEM2SU5lNjZKQSs4YTU3alRjTUtGQllUWUkvQjcv?=
 =?utf-8?B?SUF0UzFSUnZDdXgzWlVQdnJ2RnkrcDYwbDlsUUtlMGVKRjJHcTVCMnlwSlI4?=
 =?utf-8?B?c29aaDNPWU5aR1VlQlpIZFZTcFFsRFJlUVZQSU05YnFiY1V5aHVSUS9sVkg5?=
 =?utf-8?B?R1JBWVQrY2VDRGdoK3BaWG5mMzdLMVdVODN5VUtSVUVPQkUyT0dLSkxZUDJ2?=
 =?utf-8?B?WDB4OWltWURST2I3TWJWTHI1S2t5SkxtMHlPUUYzSGVNTEFUcURDVmllc2k0?=
 =?utf-8?B?TEp0ZmVHZ1NEb3NMalhSUTlnUy9sQUpIUHVzbnFONFRUbTRxK2dEUVVoN3B3?=
 =?utf-8?B?bVpsVEtlVHI5UmxSKzUvUVJ4aEJaZ3I1clg3VVBidlJOQzA2QWRCRy9FdEc0?=
 =?utf-8?B?dmdrOUtqMTY3MU1rc0FJelpHTUpSOXgxYlNSVUs2bElvMk8wOXIyYnpCT2VQ?=
 =?utf-8?B?Y1Y1cW1xcU5pVm1rakpPMFJZSFhJbTFCVUNhM3FjTjhvMHdudzJhOWtPb2hx?=
 =?utf-8?B?TUVMVlhqREQyK0pldmxwM21EMHN5TGpMVHlPWGpnOTVoYzRoYjdFYmhNYkZm?=
 =?utf-8?B?ZXNRcVRtMXI2TkRUdWRyVlRDRTM3Sk82V1R1d0RQdEJuMG9DT2RHaENNUlBH?=
 =?utf-8?B?MnYyVWZaQkpUcTN1aHl2ZXU5bGt1V2pUQWpra1h4TERRaGxXZWw2TzlwYjRV?=
 =?utf-8?B?UytnWEptWFdLREF5L3Bxd1BRZEpLZXQveGlrZU1vTWdWbXF0MS9pUjFsajlp?=
 =?utf-8?B?aE40QWw4OUJZU1pZYW9uMGVUNEsyekp5dS9SOWdqMEE0b2RsQytscm9pMkRp?=
 =?utf-8?B?Mll4TFN0R2xtajJVcng1RC8xdVAxbVFTclFKbExiNGY1L2RMZWlXZ0F2dXZi?=
 =?utf-8?B?dk9QTHF6QWo4dVI5T1M1NmpKSFNaTit4UXRkN0hkQ2V0L1BYY3BoeFRDaXY1?=
 =?utf-8?B?ZSt0QUZNL1MyTGFSUUZwc09NRFJFdjZ2Z0NlS1FHWkcwOFlzRnJlU3FrVGY5?=
 =?utf-8?B?dTNTWnRLa3FwYUtPOUxZamtnVHRjZ1ZPQVZGZUxBcEtUbUEybXJLUHRNNG1H?=
 =?utf-8?B?NzFNNWJ6b2JwcUdqRTVkS01tZWRoc1BWaHNpRTNHOEppRVY2cU40dzRaYWVx?=
 =?utf-8?B?ZHhUL3JsQ0gzeTFWcXY4ZFhIYlg4RXY4RHJRSjZHVDVVTlhvVHJNbDJnWG1K?=
 =?utf-8?B?dWQ1UDhCY1FHR3M5c3RJcTBJYXQwZDJoNmtKM1dXMElocmVHaW5GSWpUUzgw?=
 =?utf-8?B?UmU1Z2pRL3RLRHZ0WmtoZW1YOHZtVUV5eFA0Q0tqYlR5TDloaHJrTVYyUjB1?=
 =?utf-8?B?S08yY0lhUWdySUVkWjk3WEsvRHg5TGM1ajJ4anpxdFJHUWZlUWZtNit1eFI0?=
 =?utf-8?B?d2FRVXNNZFFpeXpNYTI2blhpQi9yQzFERjF5V0RIRTFSNGRnWm9paHZ3WGpN?=
 =?utf-8?B?YlRDdFQzbHIrUEtKRDdVTVNsWUdsVUhGMVBROFFMTjlkYWkvaW5GWkpGZmJI?=
 =?utf-8?B?RTIwancwTjRqMnFMRTVCR2RyQ1pidDJQS2pHOWRUWjJQSjNQckZFb3J0Q3Ra?=
 =?utf-8?B?Y1FKd2FZdzB5K0F0NXJqWlgzTmxCUHVFbmo1OG5pMC9ualdUTm0ydlpqQXIr?=
 =?utf-8?B?TlY4ejJZTVY4ankzMHgyUnJmUjZaR0o1Y2JMYy9XUmFrUTN3SjRjV0dzYVA1?=
 =?utf-8?B?UENES2FRUHlFYkZvOUNDN3BWMkJMT2RNZTF5ckUzY21TYkdFRXRvdVJjU0Zq?=
 =?utf-8?B?OWg0WkRrQWEwVk5CRkRSSnFlZTZLZkdlMFJwL3kwWDhEWkNXdkpOdDRuQmJn?=
 =?utf-8?B?c1FMQldoUjRMeVc0OTA1b3dwWjg1bE9GMXpOdG9VTlovMm93Ylp0WWptTHpj?=
 =?utf-8?B?a0daZGVNaFdDYjY2OTlJcHAxd0grc2dRcXU0d2lJQktUSFVPNm9BYW1ZcS9q?=
 =?utf-8?B?VDcwNDFxT1lmTGlWZk9ob212L2tHd3JsT3JndERIZ3pPUXZHVDI3Zz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: fbdc7b96-09b0-4d2b-5ae6-08deee6aaca5
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 18:45:06.5521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FlsMNxssOTTNmwDXLfhG/EmTrAReVh/elxFghevuTFH+45txmZNvEpWsfJOVE7mh4VAlohEIM7hsycRR4I3F7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB3241

On Thu Jul 30, 2026 at 7:29 PM BST, Zhi Wang wrote:
> Rust PCI drivers have no typed interface for locating and accessing PCIe
> extended capabilities.
>
> The SR-IOV extended capability describes VF topology and VF BARs. Expose
> this information through the Rust PCI abstraction so drivers can use the
> existing typed configuration-space accessors instead of raw bindings.
>
> Define ExtCapability to associate a capability ID with a register layout,
> and add ConfigSpace::find_ext_capability() to locate and project that
> layout. Bound the view at the next capability or the end of extended
> configuration space. Add ExtSriovRegs and a decoded VF BAR helper that
> returns the address, width, and next configuration-space slot, using
> PCI_SRIOV_NUM_BARS for the number of BAR slots. Since PCI_EXT_CAP_NEXT()
> is a function-like macro, expose it through a Rust helper.
>
> Link: https://lore.kernel.org/rust-for-linux/20260730180349.771719-1-zhiw=
@nvidia.com/
> Cc: Alexandre Courbot <acourbot@nvidia.com>
> Cc: Gary Guo <gary@garyguo.net>
> Signed-off-by: Zhi Wang <zhiw@nvidia.com>
> ---
>  rust/helpers/pci.c     |   5 +
>  rust/kernel/pci.rs     |   8 ++
>  rust/kernel/pci/cap.rs | 236 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 249 insertions(+)
>  create mode 100644 rust/kernel/pci/cap.rs
>
> diff --git a/rust/helpers/pci.c b/rust/helpers/pci.c
> index 4ebf256dff23..b946b14d79e4 100644
> --- a/rust/helpers/pci.c
> +++ b/rust/helpers/pci.c
> @@ -24,6 +24,11 @@ __rust_helper bool rust_helper_dev_is_pci(const struct=
 device *dev)
>  	return dev_is_pci(dev);
>  }
> =20
> +__rust_helper u32 rust_helper_pci_ext_cap_next(u32 header)
> +{
> +	return PCI_EXT_CAP_NEXT(header);
> +}
> +
>  #ifndef CONFIG_PCI_IOV
>  __rust_helper unsigned int
>  rust_helper_pci_sriov_get_totalvfs(struct pci_dev *pdev)
> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> index 9f19ccd5905c..008c2770a3f3 100644
> --- a/rust/kernel/pci.rs
> +++ b/rust/kernel/pci.rs
> @@ -32,10 +32,18 @@
>      },
>  };
> =20
> +mod cap;
>  mod id;
>  mod io;
>  mod irq;
> =20
> +pub use self::cap::{
> +    ExtCapId,
> +    ExtCapability,
> +    ExtSriovCapability,
> +    ExtSriovRegs,
> +    ExtSriovVfBar, //
> +};
>  pub use self::id::{
>      Class,
>      ClassMask,
> diff --git a/rust/kernel/pci/cap.rs b/rust/kernel/pci/cap.rs
> new file mode 100644
> index 000000000000..08c044bedb70
> --- /dev/null
> +++ b/rust/kernel/pci/cap.rs
> @@ -0,0 +1,236 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! PCI extended capability support.
> +
> +use super::{
> +    io::ConfigSpaceBackend,
> +    ConfigSpace,
> +    Extended, //
> +};
> +use crate::{
> +    bindings,
> +    io::{
> +        Io,
> +        IoBackend,
> +        Region, //
> +    },
> +    prelude::*,
> +};
> +
> +/// Number of VF BAR register slots in an SR-IOV capability.
> +// CAST: `PCI_SRIOV_NUM_BARS` is 6, which fits in `usize`.
> +const NUM_VF_BARS: usize =3D bindings::PCI_SRIOV_NUM_BARS as usize;
> +
> +/// Attribute bits encoded in the low DWORD of a memory BAR.
> +const VF_MEMORY_BAR_ATTRIBUTE_BITS: u32 =3D bindings::PCI_BASE_ADDRESS_S=
PACE
> +    | bindings::PCI_BASE_ADDRESS_MEM_TYPE_MASK
> +    | bindings::PCI_BASE_ADDRESS_MEM_PREFETCH;
> +
> +/// PCI extended capability IDs.
> +#[repr(u16)]
> +#[derive(Debug, Clone, Copy, PartialEq, Eq)]
> +pub enum ExtCapId {
> +    /// Single Root I/O Virtualization.
> +    // CAST: `PCI_EXT_CAP_ID_SRIOV` is `0x10`, which fits in `u16`.
> +    Sriov =3D bindings::PCI_EXT_CAP_ID_SRIOV as u16,
> +}
> +
> +impl ExtCapId {
> +    fn as_raw(self) -> u16 {
> +        self as u16
> +    }
> +}
> +
> +/// A typed PCI extended capability register layout.
> +///
> +/// Implementors describe the register layout of one extended capability=
. The layout must start at
> +/// the extended capability header, and [`Self::ID`] must identify that =
layout.
> +pub trait ExtCapability: FromBytes + IntoBytes {
> +    /// PCI extended capability ID for this register layout.
> +    const ID: ExtCapId;
> +}
> +
> +impl<'a> ConfigSpace<'a, Extended> {
> +    /// Finds and projects an extended capability into its typed registe=
r layout.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```no_run
> +    /// use kernel::pci;
> +    ///
> +    /// fn probe_sriov(
> +    ///     pdev: &pci::Device<kernel::device::Bound>,
> +    /// ) -> Result<(), kernel::error::Error> {
> +    ///     let sriov =3D pdev
> +    ///         .config_space_extended()?
> +    ///         .find_ext_capability::<pci::ExtSriovRegs>()?;
> +    ///
> +    ///     let total_vfs =3D kernel::io_read!(sriov, .total_vfs);
> +    ///     let vf_offset =3D kernel::io_read!(sriov, .vf_offset);
> +    ///     let bar0 =3D sriov.read_vf_bar(0)?;
> +    ///     let bar1 =3D sriov.read_vf_bar(bar0.next_index())?;
> +    ///
> +    ///     Ok(())
> +    /// }
> +    /// ```
> +    pub fn find_ext_capability<C: ExtCapability>(&self) -> Result<Config=
Space<'a, C>> {
> +        let offset =3D usize::from(
> +            // SAFETY: `self.pdev` is valid by the type invariant of `Co=
nfigSpace`.
> +            unsafe {
> +                bindings::pci_find_ext_capability(self.pdev.as_raw(), i3=
2::from(C::ID.as_raw()))
> +            },
> +        );
> +
> +        if offset =3D=3D 0 {
> +            return Err(ENODEV);
> +        }
> +
> +        let size =3D self.calculate_ext_cap_size(offset);
> +
> +        let base =3D ConfigSpaceBackend::as_ptr(*self)
> +            .cast::<u8>()
> +            .wrapping_add(offset);
> +        let ptr =3D Region::<0>::ptr_try_from_raw_parts_mut(base, size)?=
;

The signature should be=20

    Result<Option<...>>

where the result is usually handled via `?` and `None` needs to be handled
explicitly, rather than matching on ENODEV.

> +
> +        // SAFETY: `offset` was returned by `pci_find_ext_capability`, a=
nd
> +        // `calculate_ext_cap_size` bounds `ptr` at the next capability =
or the end of the extended
> +        // configuration space. `ptr_try_from_raw_parts_mut` verified th=
e region layout.
> +        let capability =3D unsafe { ConfigSpaceBackend::project_view(*se=
lf, ptr) };
> +
> +        capability.try_cast::<C>()
> +    }
> +
> +    /// Calculates the size of the extended capability at `offset`.
> +    ///
> +    /// The capability extends to the next extended capability, or to th=
e end of the extended
> +    /// configuration space if it is the last one. `offset` must be a DW=
ORD-aligned offset within
> +    /// the extended configuration space returned by `pci_find_ext_capab=
ility`. If its header
> +    /// cannot be read, the capability is treated as the last one.
> +    fn calculate_ext_cap_size(&self, offset: usize) -> usize {
> +        let header =3D self.try_read32(offset).unwrap_or(0);
> +        // SAFETY: Pure bit manipulation, no preconditions.
> +        // CAST: The next-cap pointer is a 12-bit field (max 0xFFC), alw=
ays fits in `usize`.
> +        let next =3D unsafe { bindings::pci_ext_cap_next(header) } as us=
ize;
> +
> +        if next > offset {
> +            next - offset
> +        } else {
> +            (*self).size() - offset
> +        }
> +    }
> +}
> +
> +/// SR-IOV register layout per PCIe spec (64 bytes starting at cap offse=
t).
> +#[repr(C)]
> +#[derive(FromBytes, IntoBytes)]
> +pub struct ExtSriovRegs {
> +    /// Extended capability header.
> +    pub header: u32,
> +    /// SR-IOV capabilities.
> +    pub cap: u32,
> +    /// SR-IOV control.
> +    pub ctrl: u16,
> +    /// SR-IOV status.
> +    pub status: u16,
> +    /// Initial VFs.
> +    pub initial_vfs: u16,
> +    /// Total VFs.
> +    pub total_vfs: u16,
> +    /// Number of VFs.
> +    pub num_vfs: u16,
> +    /// Function dependency link.
> +    pub func_dep_link: u8,
> +    _reserved_0: u8,
> +    /// First VF offset.
> +    pub vf_offset: u16,
> +    /// VF stride.
> +    pub vf_stride: u16,
> +    _reserved_1: u16,
> +    /// VF device ID.
> +    pub vf_device_id: u16,
> +    /// Supported page sizes.
> +    pub supported_page_sizes: u32,
> +    /// System page size.
> +    pub system_page_size: u32,
> +    /// VF BARs (BAR0=E2=80=93BAR5).
> +    pub vf_bar: [u32; NUM_VF_BARS],
> +    /// VF migration state array offset.
> +    pub migration_state: u32,
> +}
> +
> +impl ExtCapability for ExtSriovRegs {
> +    const ID: ExtCapId =3D ExtCapId::Sriov;
> +}
> +
> +/// A typed view of an SR-IOV extended capability.
> +pub type ExtSriovCapability<'a> =3D ConfigSpace<'a, ExtSriovRegs>;
> +
> +/// A decoded VF memory BAR.
> +#[derive(Debug, Clone, Copy, PartialEq, Eq)]
> +pub struct ExtSriovVfBar {
> +    address: u64,
> +    is_64bit: bool,
> +    next_index: usize,
> +}
> +
> +impl ExtSriovVfBar {
> +    /// Returns the BAR address without PCI attribute bits.
> +    #[inline]
> +    pub fn address(&self) -> u64 {
> +        self.address
> +    }
> +
> +    /// Returns whether the BAR is 64-bit.
> +    #[inline]
> +    pub fn is_64bit(&self) -> bool {
> +        self.is_64bit
> +    }
> +
> +    /// Returns the configuration-space slot index of the next logical B=
AR.
> +    #[inline]
> +    pub fn next_index(&self) -> usize {
> +        self.next_index
> +    }
> +}
> +
> +impl ConfigSpace<'_, ExtSriovRegs> {
> +    /// Reads and decodes the VF memory BAR at configuration-space slot =
`bar_index`.
> +    #[inline]
> +    pub fn read_vf_bar(&self, bar_index: usize) -> Result<ExtSriovVfBar>=
 {

Do you expect people to pass in a random index instead of 0 or next_index? =
If
not, this should be an iterator. Otherwise it'd be possible to index into h=
igh
part of 64-bit address.

> +        if bar_index >=3D NUM_VF_BARS {
> +            return Err(EINVAL);
> +        }
> +
> +        let low =3D crate::io_read!(*self, .vf_bar[try: bar_index]);

Given the bound checking above I'd use `panic: ` here.

> +        if low & bindings::PCI_BASE_ADDRESS_SPACE !=3D bindings::PCI_BAS=
E_ADDRESS_SPACE_MEMORY {
> +            return Err(EINVAL);
> +        }
> +
> +        let is_64bit =3D low & bindings::PCI_BASE_ADDRESS_MEM_TYPE_MASK
> +            =3D=3D bindings::PCI_BASE_ADDRESS_MEM_TYPE_64;
> +        let following_index =3D bar_index.checked_add(1).ok_or(EINVAL)?;

Just use operator here as it cannot overflow.

> +
> +        let (address, next_index) =3D if is_64bit {
> +            if following_index >=3D NUM_VF_BARS {
> +                return Err(EINVAL);
> +            }
> +
> +            let high =3D crate::io_read!(*self, .vf_bar[try: following_i=
ndex]);

Same here.

> +            (
> +                (u64::from(high) << 32) | u64::from(low & !VF_MEMORY_BAR=
_ATTRIBUTE_BITS),
> +                following_index.checked_add(1).ok_or(EINVAL)?,

Same here.

Best,
Gary

> +            )
> +        } else {
> +            (
> +                u64::from(low & !VF_MEMORY_BAR_ATTRIBUTE_BITS),
> +                following_index,
> +            )
> +        };
> +
> +        Ok(ExtSriovVfBar {
> +            address,
> +            is_64bit,
> +            next_index,
> +        })
> +    }
> +}



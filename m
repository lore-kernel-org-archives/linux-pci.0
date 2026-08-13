Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020139.outbound.protection.outlook.com [52.101.196.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA61847426B;
	Thu, 13 Aug 2026 13:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786626249; cv=fail; b=OwQ8xpxx+4gJjvDRy7RHQv+/8fDJN+pPIaYThOce6kj2hnq+RWo+LBohF1Xnsk22Fz4RoN6+IYXnN4D524NL6zbUUQdilxZduSqJazyxEGfqHBMSxTluA6fyTPry4mpAI6hok8tA8aiujKMPAaKr0/Rrk+tEGKLKgaicTpdDEKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786626249; c=relaxed/simple;
	bh=03jsiZuzy4thMCyvM580e219crf/rKdFYQGFDt6OHfU=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=b0FtA9YFbAawkOmKvQhffEN1IZRLw+EzAOAe7KVUDlf94VoewTi5xUQrExeeOPGCwkSm7LLBTar+0L5Mcaz/2NRszKPIxPktjMHLDTfhOTsNGJLOHtXpYLHSv1Pw9AuaDYFww9lriL8WEM82Yylnq9pCXYopKkGbWyOh73X9eAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=NFYNOnae; arc=fail smtp.client-ip=52.101.196.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="NFYNOnae"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vk8jxcNSOgDLIPSZAoGuZEDv4sjc/5MRxIov5FKwAtxD+pqxTX525Mlulr/0pdn5/dN405wMDAiS3cZPhwatyL08L/g+kkUk9gWflDy8XsAD3CoKwcWEsUbdqNUu37O44+f2KFIUJHv7AtylvrfGFNG55ixfF9NQGztOCyM1ce4RsgRyQNcNxi8dm6tbHfg3Yeivhb13vFO73Di6fw5m82yimfkMB7YOZzGQPQi/Th3NY45vxrHED5L0IrIyRbYBunDn9XtHaz5kmlaUOPU1WAeAB0NBd/YlMDT15lx0TCIJyHB9rnQxKG/leBFuUtfs+OgSmRNLRjDANapLLLuayA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jzeVpbX8u+2yHhrJgvESSn66ugLxWRd1Ah+tcp8sAgk=;
 b=DcEuIUoTZJfkzfkwX8rCjudnGSfiybqz4dOi4SM7DVaKhfeFWwAXRw1Hm2c5SV3XNcSzBYps/pKadNku50TN/dmYhTsBSaRF9M4jXnLtQjH8fHqUeOA8dLVNd8oTOz17bYszD8zr/qL+lNfC6t+xNtjX2IHwqGoC8XWsF3CnGgvss1sizMWTIBAX2pBGLQyc7Zq3f6EwZnIA3BDcEqHCrYrSmD3j15cZQGN31roVkrgBu6HG88cIzlX4lCL6/BSzw1I+asPYj4DBOa38GkHDgsG4NSKG0Bbpr+Yk92LMs5Mc9c8s3lvmaxSjXPrmS269yJx91wZtc+uXXWzkUmiGCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jzeVpbX8u+2yHhrJgvESSn66ugLxWRd1Ah+tcp8sAgk=;
 b=NFYNOnaea5idLvrLRY5zTXdW8iwV+prT7odQFwE4DKBCNFSKXsTcuMH0YOSKYYRBPzjyy8hRmOV3YMKDXy6Vmkb17UazlkOMMy9LaRdPQ9UWMym34NrmlowPcXfztX0hsImNGTRXocicoMWizeEACMiyFdLuA26LbEPxoz5SpMw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by LO7P265MB8652.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4aa::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Thu, 13 Aug
 2026 13:04:02 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 13:04:02 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 13 Aug 2026 14:04:00 +0100
Message-Id: <DKNU588R9B98.2UEHK3YLII989@garyguo.net>
Cc: <dakr@kernel.org>, <aliceryhl@google.com>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>, <markus.probst@posteo.de>,
 <cjia@nvidia.com>, <smitra@nvidia.com>, <ankita@nvidia.com>,
 <aniketa@nvidia.com>, <kwankhede@nvidia.com>, <targupta@nvidia.com>,
 <kjaju@nvidia.com>, <alkumar@nvidia.com>, <acourbot@nvidia.com>,
 <joelagnelf@nvidia.com>, <jhubbard@nvidia.com>, <zhiwang@kernel.org>,
 <daniel.almeida@collabora.com>, <tamird@kernel.org>, <work@onurozkan.dev>
Subject: Re: [PATCH v7 1/1] rust: pci: add extended capability and SR-IOV
 support
From: "Gary Guo" <gary@garyguo.net>
To: "Zhi Wang" <zhiw@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260804161612.776752-1-zhiw@nvidia.com>
 <20260804161612.776752-2-zhiw@nvidia.com>
In-Reply-To: <20260804161612.776752-2-zhiw@nvidia.com>
X-ClientProxiedBy: LO4P302CA0010.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c2::18) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|LO7P265MB8652:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c15b623-83ce-428a-1dad-08def93b5889
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|366016|7416014|1800799024|376014|6133799003|10067099003|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	irEqW/VUuYo+HSgsHeHHW3+cGs2jo288Bx3a3RqjiDbHkNFZtKzOtIDWiB/bfmhnEPmmDsGlv76M1iG0vXIRtOR5z46uny6WIshZxbgkBakCw/9IBQjHuTpxMt4tciEIC1IrrZyYB17sdGNiYtqhxASMu60fcSWleGGv4SFBqPHWpooAFwVQStkyPgzXa6OPwJH+HWlQEArhh0VOL8/GtImNMQB4NSBhHTjcAi+7VDA8c4E/9zk2xAJR8itAfQQi2Nk+U8NzNrHsQMDN3M6Lgu2vL54DAFW2Roo8NPalxk/LTT1BJ0nkKn0GXCnsUJn6nqnea+6INctNukJR+/Im6SrFO4rTYLKcMVRTyC+ZPSOwyxTJX8exCDmum2/0Qr2D6o8mgwM6Bl81o0u9GQA6SHF7HUa8jvjHgJ7OK7z2/mmcRB+GnnReWoNHT7liv6bq2KevDyG2sCaPOXuRkFDhtGyqAFge9XFbJ4dxChwxEkrapvzh+AVf69/dB140MLd4fp+CqY5Cf5cnMJ4K27vzhoT8LWZzBuUr9CuxESjmOU01QRhFdos7agHFxuTklHsgLAXUGXTWb/I1k7h+BBnMf388i9FkO9CjL/WOtsDQg+1bIDo8CYGAiEvNXto84m+TemieNrodJQ4G8JQHsg4zS6fD2ZV1dv63k7GCCd92uNg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(366016)(7416014)(1800799024)(376014)(6133799003)(10067099003)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MHZxcDdseGpVaHlyQS8xNldSQXVDN3pFVUI2aHJadlhXNERrYXhsOWJtbTQz?=
 =?utf-8?B?ajQ4Qnp0RzRLNCtnUFVrQWJ1VUJGdWRoZUR3U25CNHEvVTQzbzQwbUhwZEtX?=
 =?utf-8?B?VkZNL0xGejRRVlFUQnBjVXplazBNaWZoTnpMZWYrY1JueWVsZnhNUXNHOHZk?=
 =?utf-8?B?NFZiQnllalBtV256NE8xcjlleXVGUUs5RWI1K2k1WGgzR3pWYzRwa0h4RUtZ?=
 =?utf-8?B?ajQ5VjFPbkRIbnVJeTFjWGgyK3hKcjhuU1JkanFmTFU1eTVGUFV1bVppQ3pa?=
 =?utf-8?B?UmZoVVd0Z3BXU2pCUWNrN2poRi9LYXlvYnB5V2NwMU1OOHN1aW5JNHBnTU01?=
 =?utf-8?B?dXI0UmVPY0RSUzY4ZlpsVTdoM2dxVjhjL0VseU1XMUlKSXdiVmFhSG5oNEND?=
 =?utf-8?B?UkZwRytqUHAyUnVSVkI5dW8zYlAzWmUrSGxRbzNYbmQzQWpONGVYWkUvZ2Jh?=
 =?utf-8?B?N1Y1U0RIeVlQbUlOdXlaMFVaRmxOVGUxS3FFTUNxcFNFaEVMVURySVYreHV3?=
 =?utf-8?B?dWxDZ0lOek5vT1V5R0xkSitYaGp0UmJOVElLbWV3RUo0d2dhczhNK2FKWVky?=
 =?utf-8?B?Z3FkbDV1WGZrVXoyVmdtK3NiNWQrbmNGczNqbHdpR0NDemFFRXY2b0pmZVBw?=
 =?utf-8?B?d3ZnSmtPdnFYZWNlS0hkWjljS1ZaNTc4Q0dqQ2g3YVlyWGEvaFZJWDI4TWdC?=
 =?utf-8?B?OS9GdnhkaUQ0UlVUYlUzZm1BZVZwZlJ2a3ptZ0xvcG9sckdWd29IZnNHbGFp?=
 =?utf-8?B?WkpBbkpJN1dwLzlSV0VZL01kdVpKM2doOVl6Ym83ZE9VeDBycitrQjRSb3Jl?=
 =?utf-8?B?YnJEWUt6cWJVZHhRY1FiVWJybk41SzFDcmluaEljRWVneGs3ME5NUHliSnQ0?=
 =?utf-8?B?N0h1QTgxanBkdzR3akxLdmN3TG9HQVdOWUx3YVF3RS9oNjJaUE9oRWVEQUx1?=
 =?utf-8?B?aC9JTkJ4ditHL2NrYjNrRlh3bHp2M2pRNGlVNnhPTjlkZzIwcG9CUWxqN1I5?=
 =?utf-8?B?c09JVmxoWVhoNFFYOW5FSHVhcFpPRDliaTlYUitVQ096eitid21USEZSUUtK?=
 =?utf-8?B?RmZRNXNPOHZmanlkMFdlWkZiU1dJV0ZpdjdVemlKWVpVVVNISUhVZDJEeDlD?=
 =?utf-8?B?S2JCOVEwTGtXeldVQ2h4YTNRK2hJbi9abVl1SUt0NDQwb3lEM1dFdWd6TUR2?=
 =?utf-8?B?cUxNcWlPb2ZUYk1vR2plZlAwc0pqcXNjclVtM1N4Q2hqZGc4bDdvMlRjckVP?=
 =?utf-8?B?OUdkQURBdHN1bjNXbi90UUpKMm9MSXBCQUl0UXlaODY5OVN3WU8wK0ZwWk5S?=
 =?utf-8?B?cDM2T0wxUXk2dzVnNjVKelVjRVBZVS9YOEJPZkN4cXFGRmd6TlNGeHNIb1VR?=
 =?utf-8?B?a0N4VWRlMkFMNnlUM292Y1psV1VTMS96L3lWLzBJcmdJR3Z2bEpZQ3NLZE9D?=
 =?utf-8?B?ZG80cGZWVEVlOTh3TG12L2FKUzd5SWRHS0EyT3hLT0pFL1NaRlUzaXRsb2JI?=
 =?utf-8?B?dlJxMHpkQVpObE1sWFBHS1RzVXVsY0pqNzU4dkNoOFExWFFQVWJKRU4vTUQ2?=
 =?utf-8?B?U2NCQ09TNEgyMDl5Z2xyYzVHUnFFRVZ0WVNlM3lwRkw5cG81Zk1hSEZGL3A3?=
 =?utf-8?B?cGpkR2V5RHFVc3QwTFROL0tXVDFiTUg4SHNIeStjRnIzZ2dBNFEzNVM4K0xF?=
 =?utf-8?B?emZVK0QrOUZ6eThKNTN2NWJFZkxyTTZGcW5weUhnYVFzV1dYLy8xVEtqTGth?=
 =?utf-8?B?TStQSkVLV2M5Z1c4QnZJWFY1SEYyUDVhbWViTU5PWSszZ1pnVWVSTUZsVVpD?=
 =?utf-8?B?STR1d0ozcmFYMENWTStScEJjZ1AwMytZR3Nrb2l0ZEUyMjFENUhNRnc3YTRM?=
 =?utf-8?B?ZnBKaHZvaEhNVEdJYllTL3QwSnN6VllFcHNxK3lXM3JkdlAxWEo1MHhFTktK?=
 =?utf-8?B?VmNjRWFoaStDMnVIbUdyZm10dy9PTlE0WllIbVNNLzgxTFlYa3plM3J0YlVI?=
 =?utf-8?B?REcxVGdpVm5ac0ljU2ZTckZpVlphek8rU0pEZnJzRlZ3TnBWZTV4a0lxaGMx?=
 =?utf-8?B?L1FLRnRZSnJQeHh2TVdGck5tV00xajFZNVlKNTVEWlhoRkpGbHRqNER6d3FF?=
 =?utf-8?B?L3JzU1FTdzY2aG1qajduV3pSdnlwYlVrbFlvZEJsejR3RDNLN3FIYysyZkZY?=
 =?utf-8?B?Um1VN1p3dENBSkJqRzBCN0pNaHZXYVFIc1czSVdCYmpEd3VqMjRMMkRaQjNk?=
 =?utf-8?B?WlZPcDRlZHlDZG1yVXZ1dTVXUXVaU0JBb3UzUjBxaXBHalZodWJDN1pJc2xG?=
 =?utf-8?B?SFptMlpTcHJQdXZvMlp5OFBBdGk5b2daQlVmYThTNitxSjNHZ2hBZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c15b623-83ce-428a-1dad-08def93b5889
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 13:04:01.8809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HKphZChW1Ejdm7/oYaC0+yVyRdkLxv3YcbM6G0lx0xW+6YejjcnNHLqYeggYLgdfBBIQsSc5inph/vCJnjoGCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO7P265MB8652

On Tue Aug 4, 2026 at 5:16 PM BST, Zhi Wang wrote:
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
> configuration space. Add ExtSriovRegs and a decoded VF BAR iterator that
> reads and validates all six VF BAR register slots up front, yields decode=
d
> BAR addresses and widths in logical order, and keeps the raw
> configuration-space slot advancement internal. Since PCI_EXT_CAP_NEXT() i=
s
> a function-like macro, expose it through a Rust helper.
>
> Link: https://lore.kernel.org/rust-for-linux/20260730182954.783568-1-zhiw=
@nvidia.com/
> Cc: Alexandre Courbot <acourbot@nvidia.com>
> Cc: Gary Guo <gary@garyguo.net>
> Signed-off-by: Zhi Wang <zhiw@nvidia.com>
> ---
>  rust/helpers/pci.c     |   5 +
>  rust/kernel/pci.rs     |   8 ++
>  rust/kernel/pci/cap.rs | 317 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 330 insertions(+)
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
> index 000000000000..c49de8682f6d
> --- /dev/null
> +++ b/rust/kernel/pci/cap.rs
> @@ -0,0 +1,317 @@
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
> +    num::Bounded,
> +    prelude::*,
> +};
> +
> +/// Number of VF BAR register slots in an SR-IOV capability.
> +// CAST: `PCI_SRIOV_NUM_BARS` is 6, which fits in `usize`.
> +const NUM_VF_BARS: usize =3D bindings::PCI_SRIOV_NUM_BARS as usize;
> +
> +/// PCI extended capability IDs.
> +#[repr(u16)]
> +#[derive(Debug, Clone, Copy, PartialEq, Eq)]
> +pub enum ExtCapId {
> +    /// Single Root I/O Virtualization.
> +    // CAST: `PCI_EXT_CAP_ID_SRIOV` is `0x10`, which fits in `u16`.
> +    Sriov =3D bindings::PCI_EXT_CAP_ID_SRIOV as u16,
> +}

This might also make sense as a `struct` with assoc constants, so it can ac=
cept
unknown values.

    #[repr(transparent)]
    #[derive(...)]
    pub struct ExtCapId(u16);

    impl ExtCapId {
        pub const SRIOV: Self =3D Self(bindings::PCI_EXT_CAP_ID_SRIOV as u1=
6);
    }

> +
> +impl ExtCapId {
> +    #[inline]
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
> +    /// Returns [`None`] if the device does not implement the capability=
.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```no_run
> +    /// use kernel::pci;
> +    ///
> +    /// fn probe_sriov(
> +    ///     pdev: &pci::Device<kernel::device::Bound>,
> +    /// ) -> Result<(), kernel::error::Error> {
> +    ///     let Some(sriov) =3D pdev
> +    ///         .config_space_extended()?
> +    ///         .find_ext_capability::<pci::ExtSriovRegs>()?
> +    ///     else {
> +    ///         return Ok(());
> +    ///     };
> +    ///
> +    ///     let total_vfs =3D kernel::io_read!(sriov, .total_vfs);
> +    ///     let vf_offset =3D kernel::io_read!(sriov, .vf_offset);
> +    ///     let mut vf_bars =3D sriov.vf_bars()?;
> +    ///     let bar0 =3D vf_bars.next().ok_or(kernel::error::code::EINVA=
L)?;

Error codes are in the prelude.

> +    ///     let bar1 =3D vf_bars.next().ok_or(kernel::error::code::EINVA=
L)?;
> +    ///     let bar2 =3D vf_bars.next().ok_or(kernel::error::code::EINVA=
L)?;
> +    ///
> +    ///     Ok(())
> +    /// }
> +    /// ```
> +    pub fn find_ext_capability<C: ExtCapability>(&self) -> Result<Option=
<ConfigSpace<'a, C>>> {
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
> +            return Ok(None);
> +        }
> +
> +        let size =3D self.calculate_ext_cap_size(offset)?;
> +
> +        let base =3D ConfigSpaceBackend::as_ptr(*self)
> +            .cast::<u8>()
> +            .wrapping_add(offset);
> +        let ptr =3D Region::<0>::ptr_try_from_raw_parts_mut(base, size)?=
;
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
> +        capability.try_cast::<C>().map(Some)

Is this cast failure is supposed to be error condition?

> +    }
> +
> +    /// Calculates the size of the extended capability at `offset`.
> +    ///
> +    /// The capability extends to the next extended capability, or to th=
e end of the extended
> +    /// configuration space if it is the last one. `offset` must be a DW=
ORD-aligned offset within
> +    /// the extended configuration space returned by `pci_find_ext_capab=
ility`. Returns an error if
> +    /// the capability header is outside the extended configuration spac=
e.
> +    fn calculate_ext_cap_size(&self, offset: usize) -> Result<usize> {
> +        let header =3D self.try_read32(offset)?;
> +        // SAFETY: Pure bit manipulation, no preconditions.
> +        // CAST: The next-cap pointer is a 12-bit field (max 0xFFC), alw=
ays fits in `usize`.
> +        let next =3D unsafe { bindings::pci_ext_cap_next(header) } as us=
ize;
> +
> +        Ok(if next > offset {
> +            next - offset
> +        } else {
> +            self.size() - offset
> +        })
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

I think this shouldn't be public.

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
> +#[derive(Debug, Clone, Copy, PartialEq, Eq)]
> +enum VfBarMemoryType {
> +    Bits32,
> +    Bits64,
> +}
> +
> +impl TryFrom<Bounded<u32, 2>> for VfBarMemoryType {
> +    type Error =3D Error;
> +
> +    fn try_from(value: Bounded<u32, 2>) -> Result<Self> {
> +        match value.get() {
> +            0b00 =3D> Ok(Self::Bits32),
> +            0b10 =3D> Ok(Self::Bits64),
> +            _ =3D> Err(EINVAL),
> +        }
> +    }
> +}
> +
> +impl From<VfBarMemoryType> for Bounded<u32, 2> {
> +    fn from(value: VfBarMemoryType) -> Self {
> +        match value {
> +            VfBarMemoryType::Bits32 =3D> Self::new::<0b00>(),
> +            VfBarMemoryType::Bits64 =3D> Self::new::<0b10>(),
> +        }
> +    }
> +}
> +
> +crate::bitfield! {
> +    /// Low DWORD of an SR-IOV VF BAR.
> +    struct VfBarLow(u32) {
> +        /// Base address bits 31:4.
> +        31:4 address;
> +        /// Whether the address range is prefetchable.
> +        3:3 prefetchable =3D> bool;
> +        /// Memory BAR type.
> +        2:1 memory_type ?=3D> VfBarMemoryType;
> +        /// Whether this is an I/O-space BAR.
> +        0:0 io_space =3D> bool;
> +    }
> +}
> +
> +/// A decoded VF BAR register encoding.
> +#[derive(Debug, Clone, Copy, PartialEq, Eq)]
> +pub struct ExtSriovVfBar {
> +    /// The BAR address without PCI attribute bits.
> +    pub address: u64,
> +
> +    /// Whether the BAR is 64-bit.
> +    pub is_64bit: bool,
> +}
> +
> +/// Iterator over decoded VF BAR register encodings.
> +///
> +/// `slots` contains the six consecutive 32-bit registers VF BAR0 throug=
h VF BAR5. A 32-bit
> +/// memory BAR encoding uses one register. A 64-bit memory BAR encoding =
uses that register for
> +/// bits 31:0 and the immediately following register for bits 63:32.
> +///
> +/// # Invariants
> +///
> +/// - `config_slot <=3D NUM_VF_BARS`.
> +/// - If `config_slot < NUM_VF_BARS`, it identifies the next register to=
 interpret as a BAR low
> +///   DWORD. Its address-space encoding is memory and its type encoding =
is either 32-bit or 64-bit.
> +/// - If that low DWORD encodes a 64-bit BAR, `config_slot + 1 < NUM_VF_=
BARS`, and the register at
> +///   `config_slot + 1` is its upper DWORD.
> +struct ExtSriovVfBars {
> +    slots: [u32; NUM_VF_BARS],
> +    config_slot: usize,
> +}
> +
> +impl ExtSriovVfBars {
> +    fn new(slots: [u32; NUM_VF_BARS]) -> Result<Self> {
> +        let mut config_slot =3D 0;
> +
> +        while config_slot < NUM_VF_BARS {
> +            let low =3D VfBarLow::from(slots[config_slot]);
> +
> +            if low.io_space() {
> +                return Err(EINVAL);
> +            }
> +
> +            let is_64bit =3D low.memory_type()? =3D=3D VfBarMemoryType::=
Bits64;
> +
> +            if is_64bit {
> +                if config_slot + 1 >=3D NUM_VF_BARS {
> +                    return Err(EINVAL);
> +                }
> +
> +                config_slot +=3D 2;
> +            } else {
> +                config_slot +=3D 1;
> +            }

So you're already decoding the vf bars here, but the `next` does an additio=
nal
decoding. I think you should just decode them in one place.

Best,
Gary

> +        }
> +
> +        Ok(Self {
> +            slots,
> +            config_slot: 0,
> +        })
> +    }
> +}
> +
> +impl Iterator for ExtSriovVfBars {
> +    type Item =3D ExtSriovVfBar;
> +
> +    fn next(&mut self) -> Option<Self::Item> {
> +        if self.config_slot >=3D NUM_VF_BARS {
> +            return None;
> +        }
> +
> +        let config_slot =3D self.config_slot;
> +        let low =3D VfBarLow::from(self.slots[config_slot]);
> +        let is_64bit =3D matches!(low.memory_type(), Ok(VfBarMemoryType:=
:Bits64));
> +        let low_address =3D u64::from(low.address()) << VfBarLow::ADDRES=
S_SHIFT;
> +
> +        let address =3D if is_64bit {
> +            let high =3D self.slots[config_slot + 1];
> +            self.config_slot +=3D 2;
> +            (u64::from(high) << 32) | low_address
> +        } else {
> +            self.config_slot +=3D 1;
> +            low_address
> +        };
> +
> +        Some(ExtSriovVfBar { address, is_64bit })
> +    }
> +}
> +
> +impl ExtSriovCapability<'_> {
> +    /// Returns an iterator over decoded VF BAR register encodings.
> +    ///
> +    /// The iterator tracks the six raw VF BAR register slots internally=
. A 32-bit encoding yields
> +    /// one entry and advances by one slot; a 64-bit encoding combines t=
wo slots into one entry.
> +    ///
> +    /// A zero-valued low DWORD is yielded as a 32-bit BAR at address ze=
ro; this method does not
> +    /// probe whether a BAR is implemented.
> +    ///
> +    /// Returns [`EINVAL`] and logs an error if a BAR low DWORD does not=
 encode a 32-bit or 64-bit
> +    /// memory BAR, or if a 64-bit encoding has no upper DWORD.
> +    pub fn vf_bars(&self) -> Result<impl Iterator<Item =3D ExtSriovVfBar=
>> {
> +        let slots: [u32; NUM_VF_BARS] =3D
> +            core::array::from_fn(|slot| crate::io_read!(*self, .vf_bar[p=
anic: slot]));
> +
> +        ExtSriovVfBars::new(slots).inspect_err(|_| {
> +            dev_err!(self.pdev, "invalid VF BAR encoding in SR-IOV capab=
ility\n");
> +        })
> +    }
> +}



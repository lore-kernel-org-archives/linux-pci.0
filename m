Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013043.outbound.protection.outlook.com [40.93.201.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD0E41F34B;
	Fri, 31 Jul 2026 10:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785494167; cv=fail; b=O85NhLPBU2qE8QWYKPi99XKq5I9TVc98jrSnMGCSufYbMwiIKsPOwOGmF9qR78PijhO0v96jBpM75zEGLaV/tuazPST1N8cTn3imKObXJTgDV4a0tnWAMjggJKw2nVcwrrexIjMluXx8pWk9U0Z/7Wfp2j6H7+olKga5ErvMdf0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785494167; c=relaxed/simple;
	bh=k2bVLs1TjVnHV7KOhLFPFoqi9RoJ43Gs1XOMYb5dEDg=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:References:
	 In-Reply-To:MIME-Version; b=WCojbzBS9kN5CGAG5gedjjtAy6TvaFV2Irl83nxBW1sQfz8quybtdo5y4Um7c8xdDIpPW+o3IKlL8nFpVVZjKyitvt9ROotpzIkxYv7ZiYvAFl9Cm9134oXZkbwo1zXckvyEqUHQYMpr8xqntT8ICrDOBF+lwDFSGDsLxDfITlc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IyvaZ+79; arc=fail smtp.client-ip=40.93.201.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IyvaZ+79"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g1vE1DDgP3jPCqS8Ieh99rfMktN95KYRFBWbc1bEpp4bbehLgaNHTNv1mQO7L1voJd5TalEte0waDR5iwwWpvv06OAwfLOkf1IYQuMMHrGheykcIXwTIAccNOABkTicCTsLtPNOaKsKf3tubPqvKek/RnfkZl+LjILFCacpTHimH7kF2M9w2r+8U13oFwXn/ZppfH35+gB/RgrOFHJt7uPLB7ML2t8uIHjEMhT10pZwnFpw3/deertEb7H6qh1JsR9lv+cDh01Y4nxnG7z5BtcU0WOpv2ivHUQ7AsD0jgIjaBK5QaL1Kt5vGw9Nab2uebBW5XoD4RaO8JFezkcgwxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WjGmqLmFSo6DA0U3J4KYL5LnEc/BzYEnjWmLGzAxh/I=;
 b=c6TP6+rUBnOTa9ulcPg4cXRBp+yYV1JVmLyx4zwp/NHAa/FABEYMitc/TuxGz7KX6zIE6AgjdcKt4/ngj+gzVUY3Q6CGyHeFMetXpSfnXI/I03AcYQXbgUw+ZLebE/M4wgaVrWv3kiJpinsQK73JDTpJ4zRKVJzds9Hlcb1McV5Ucfs1eHbbWTdXzCAIXctRMurqkQ1Ll/7UJXLnPqZTBKEy98DQ4wDZLPTbDYS4Pj6cGE6OMi8jWvHlgNB4l0JOYIekmD3mgZee0Xb2w87bwV6Q0ATkNukvJQ9d4KjdkNCVnGfGh8oSrZdUjJtN/vHpM/X+KWpak/Ci4k+jPpoMoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WjGmqLmFSo6DA0U3J4KYL5LnEc/BzYEnjWmLGzAxh/I=;
 b=IyvaZ+79ACMUVfZPml4O0BEd3urKyiQZDTujoY/7dk+9L+S7oztlMc20BH2ekL4uRA+cZrI6AhEQIa/1IwINfZITGDiwJUtsii7l9jXHBy81MLgk2k9da8mJSX9QszLv0nbrCm2BKUNSHBfvC2DgsRuuBsTRKxfeuBhwY31pA/e4VoMNouGhb487juWPW6n3K4MO7rxWhnmVuuoXkCZT4kXNBQCdQQ8wo0BvNO8BfKmhIFsLWItkGQZHb0q7EB3qqMvpBjhkfbUqHGd2NdSQT/0glVLC7qhqxWcBtj8Abk4gdXMvKsUXIL8xj6rmAWkw5Gj88IbxPHL6ua5Q1IJt6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3997.namprd12.prod.outlook.com (2603:10b6:208:161::11)
 by SN7PR12MB7130.namprd12.prod.outlook.com (2603:10b6:806:2a2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Fri, 31 Jul
 2026 10:35:31 +0000
Received: from MN2PR12MB3997.namprd12.prod.outlook.com
 ([fe80::73c6:e479:9b75:b2cf]) by MN2PR12MB3997.namprd12.prod.outlook.com
 ([fe80::73c6:e479:9b75:b2cf%6]) with mapi id 15.21.0270.009; Fri, 31 Jul 2026
 10:35:31 +0000
Content-Type: text/plain; charset=UTF-8
Date: Fri, 31 Jul 2026 19:35:26 +0900
Message-Id: <DKCOUE9DRG5R.2VAVA78UTVKST@nvidia.com>
To: "Zhi Wang" <zhiw@nvidia.com>
Cc: <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <dakr@kernel.org>, <aliceryhl@google.com>,
 <bhelgaas@google.com>, <kwilczynski@kernel.org>, <ojeda@kernel.org>,
 <boqun@kernel.org>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <markus.probst@posteo.de>, <cjia@nvidia.com>, <smitra@nvidia.com>,
 <ankita@nvidia.com>, <aniketa@nvidia.com>, <kwankhede@nvidia.com>,
 <targupta@nvidia.com>, <kjaju@nvidia.com>, <alkumar@nvidia.com>,
 <joelagnelf@nvidia.com>, <jhubbard@nvidia.com>, <zhiwang@kernel.org>
Subject: Re: [PATCH v6 1/1] rust: pci: add extended capability and SR-IOV
 support
From: "Alexandre Courbot" <acourbot@nvidia.com>
Content-Transfer-Encoding: quoted-printable
References: <20260730182954.783568-1-zhiw@nvidia.com>
 <20260730182954.783568-2-zhiw@nvidia.com>
In-Reply-To: <20260730182954.783568-2-zhiw@nvidia.com>
X-ClientProxiedBy: TY4P301CA0013.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:26f::19) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3997:EE_|SN7PR12MB7130:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e37db9e-f2a6-4234-8d1c-08deeeef716b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|7416014|1800799024|10070799003|366016|56012099006|11063799006|6133799003|4143699003|3023799007|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	rkw8SO95Nb3Y5XPR+e+ozHiNn34u2daWNMtT/pRg58n0hXiJZDpUdzYTjqZ4UuRVB0iMN+MrmE4O/MyKpv4JVduO+4KAqYDoioTHTa1mbMS9AvhjerpQm3cjCv6JF5TePSflMgwLXvAVA9XPOtKpcTqCgjZC0VWbL/10t2G3hGPrAXCCE6PP62Xwv2gUyNUNTGxTmw9Tu4gL+31C7ilpZJXTDESsRm9C4dwAiFNNmWQLeQzpiZ6gN6L6f9gxbhJZ9xUXmmfpDmvEnGOlm4PxaCw0cxLFcYLK/D91sJLXPl3n47khkCHKtfWuJBeSiEvM8GTZklyVD4UZAxyHs9vl4mTcY1BJ+qYF+YG2opflgMAgwyzdBqQlQ9Al9BHmSQKdvFNCaHapwq2qAyYaFHqIW8IoQN1IN8GH0uBhJs/S0cggcmx0JFYZH/OS9EfmHYQikhL88vRa2vzLKaUOF4P9EpJxpxTcXWnw5sWXirGbC91RJRx6uobK8LksPpUdS+pgpXtD+e8MpxTnH6HWNVZFX/pBNDyx2CrizT6Ub91yL/4II12us9DusDfbtONQfmpEi87vX1PskvX7F/6LEdnLhpVa2pxss14Bzy/M/RuShlPfyHWtRdTBru9QZeZUeEBDdlZCz6P6bCHNcD3vCSGfv52y/+mnH+fUUcqAw1mEdpY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3997.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(1800799024)(10070799003)(366016)(56012099006)(11063799006)(6133799003)(4143699003)(3023799007)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Mjd3bGVLOWpmbDdybXFBZS9lamswdG1NYmYzY1MrWEszU1JteWdNdVBjUzUx?=
 =?utf-8?B?d1BTWXV0VXNlSmN4OVpPcEVvRmhTV1dHb1dJNjIvam81blJlQnJWT1YyVGdw?=
 =?utf-8?B?L0gzMUtLb3FCdkoxN0tERnJzNkxLRVFITFBSRk1CVGZCdW1HV0tFVllNekM3?=
 =?utf-8?B?eDE2emhiMkwveHhmR0I2QWNjSGcxbDZaWFcrR2VkQkUyUUVTZmVEQ1U2V2Nl?=
 =?utf-8?B?Zlg3WUtZQmxHRFJYRkZteEtSMW40ZUdERmNpbjBQaUgybW9BZ2JiS2R4cE01?=
 =?utf-8?B?bXJaZkVkK2dEYVY4eWRsN3Y4bys2a3ZsUFRJNDZEVkVQOXM2L2lqT1lvZXQ1?=
 =?utf-8?B?cWw0eXB2REdKTm5nTzdHdXRvUTZNVkkvZi9nRTI4b1I5ZkVSZ1c3MlA3MEtD?=
 =?utf-8?B?SEtZdGRZWE5mdFAzdnhYR1NPQWIvZ1ZVUlQzb1NQSlRwNVloSW9WV1U5Rkh5?=
 =?utf-8?B?MnB0K3I5TUUwbXZUMXJiTnlMZFhzQnVlb3pVZWRBK3ZoQmpicjZraG5sRmgr?=
 =?utf-8?B?UjhVWHNjMm5OeGlYb3RqN1g1OFkwM1JyNFBUdGROSFZsbGlMdjVUZzQrR2Vx?=
 =?utf-8?B?NjBITnk5WENTN2J2YS9UbEoyL1dCeldzR3RsOFRwSlZMMDZOcWV3N1pXRFh6?=
 =?utf-8?B?OFp3VFNMUnBrT0g1cmpHMGJ4Nk9HbHcxUDhRUTV2VFNEV2Z0dWV1S1VwbTJK?=
 =?utf-8?B?aXQwUGRndVVSQkhMM3k3aytENjNoMDJwSFgrMjFUUVFaS1JkZ2I4RVIxeFVt?=
 =?utf-8?B?alJhTTZFcTR5aStEUmJ1WTh4aUQxaXRMQ05lM3ZZTDc3eG51VnI0SG9kVStw?=
 =?utf-8?B?cXcrZjFWQ096K1BFY0EzM2JUNTdrTVJwaE9za2VuMkhMV2pMWkZyMUJCT3FB?=
 =?utf-8?B?SUFjTGRJcFhKUm5UN1VIWThJZGcwcklRbkp2eHNXZkRZdm02eE1ubzVhRFZ2?=
 =?utf-8?B?NVo0WUlYZlMzRzdzUG1wN1FOSEdJMC9heTNtdENDSGdzdnJjQnQ3OGJNK0h1?=
 =?utf-8?B?anc5UTZUaXYzV1pvc3lqSWVXckI1dFNUcFVFU1cxb05IMExmS3RwNldEcnJm?=
 =?utf-8?B?MWlOQ1RrM2NMZmNxUDlJMGhKL2kxaGJSbUxPR1RXN2Z3RDZEV25UM2NLWFF6?=
 =?utf-8?B?ZWZwYkd3T2JJaU1GcXNaWGJwbUhnMUpQUW9PMkMzVmlzanI1RWM5ejE5N1hG?=
 =?utf-8?B?enpFQlRJQVNtSmtaWGFVeTF6elBMbFUzSW5OcGp0eTd6Ni9mVUJXTEdLUGRY?=
 =?utf-8?B?Mmoza2p0VHJORHMrZ2hZRHJSbU9PQnovc0taQXBMcHh2dHZqYlE3UHNySmhG?=
 =?utf-8?B?Tm43TUMrWmJIajdxWmFFdzkyYXVDeFgrUFRRWmxzWjRqS2d0S1ovekJHd1FW?=
 =?utf-8?B?cE5oU0pNeHFETGJiSDNnRmUxYmc0SnBBUStVMEFleEJmeUJGckVtSHp2RU41?=
 =?utf-8?B?bEFCRkJUQUFmWEl3dkZyT1hIT29TdDVaaEo4UXdYU2NDUE03OFpEemNHdE5j?=
 =?utf-8?B?ZnZMOG1GcEVFMXdJV1VtV3hOV2NralNJcXhqVnYrazQ5VkZ6STdZdUJMdG1n?=
 =?utf-8?B?RWFwNEh5UFpHTWljc1FMdzJaREtKdHo1QW1EYkwzM3ZaN3owVVNHeFd5WEZt?=
 =?utf-8?B?UEQxMTVRZHRUMU9VQWNPY1JiUlM0UElPSmEzYkFOSWFMSzJzS0U4M0pSa0F1?=
 =?utf-8?B?MGpNb1VGM0lsNEJlL1lvdFdxdTR4ejFUUTZLQ3VVOEVmREVkbXF4dDNJWDMx?=
 =?utf-8?B?SlpoMGdFL1ltVEd6K2ZMbkNnSmFLQ25BcUk5SC91NHNLci8rRGxwbkdSblFC?=
 =?utf-8?B?d0Z2TDFLUzN0SFRrdThqMnBZOU83ZWQvU1QwalVKdWduWVd1WWNIWHdZZmVM?=
 =?utf-8?B?Nmh4cTZ0NkFVTTA0SDZwMFVSR2wzaHVUMWFNazlHY1d6OFdkcTZSM0dEU3FN?=
 =?utf-8?B?UUNSWHRtTXdvTEMxQjlWSUVuaTQyUGtyajhPZUpLR2xGV0drSlhSUmo2aXlU?=
 =?utf-8?B?ZjZsVTN6WkYrNDFGcVBkUm1ZUTRGcXZIQlNVbkFCWXlZaWh6SVlwZmE0aXky?=
 =?utf-8?B?WnlHOUd0bkpUUkR4aGtaRWQ4OWFxY3c5MDM1Tk9POGU3c1g3ZnV1Qm5jYkNT?=
 =?utf-8?B?TkFIQ3ZJOC92T1kwM3V3SUFaWloyTk53dFlPRmhrVGRVRmJGSmFyQ1N2UVEz?=
 =?utf-8?B?cE9DMlo0Q082VmpZUUpvd1JFbVlDdXJIQmV2bEo5VGlsMm5aL2tWWkZYeUcz?=
 =?utf-8?B?NVE2NjRhU2FWNUZlZ1d5Rm51TDNDcXgxYTZyN0R3cy8vMEl1bXI2b1V3cmRx?=
 =?utf-8?B?bWJySGhkOTdmN2hDSnJQVHpVZTV0TXRaaXZMMUVjUHNIUUpYZHdUdUFZUFFp?=
 =?utf-8?Q?M6QrO4vTdHLTpw1YFF2fwu9P0ev3XZ9w9wMAKcKpkVBk0?=
X-MS-Exchange-AntiSpam-MessageData-1: ciEhrHnEOTPibw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e37db9e-f2a6-4234-8d1c-08deeeef716b
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 10:35:31.3783
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: scF7JnV3bmDbO1J29gTZ4oQRYPrPlUyWKVskMsb78HE6O4bt+WKfsmQpD14b/A5aX9iIaGQBaLjUbKE9l34+YQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7130

On Fri Jul 31, 2026 at 3:29 AM JST, Zhi Wang wrote:
<...>
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

This is only used in `read_vf_bar` and can be local to it.

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

The special behavior on invalid index is intriguing - is this part of
the PCI specification? Or can it return an error if `offset` is out of
bounds?

If we can, I'd probably prefer that as the fallback path relies on
`pci_ext_cap_next` to leave the `0` value untouched, which is not super
obvious. Or if we keep the current behavior, let's at least document
this fallback path a bit more.

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

The `try_read32(offset)` above failing means that `offset + 4 >=3D
(*self).size()`, so this will either underflow, or return a bogus size.
Which is another argument in favor of handling the special case with an
error if the current behavior is not warranted by the spec.

Note also that this can just be `self.size() - offset`, but it's fine if
you want to keep the deref explicit.

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

Side-note: It would be interesting if we could end up representing every
I/O space this way, although padding and keeping the fields offsets
visible would make this challenging. But if we can eventually generalize
this, then I guess we can retire the `register!` macro. :)

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

How about making all the members public (and documenting them)? We won't
be working with mutable values, and that way we can remove this entire
impl block.

> +
> +impl ConfigSpace<'_, ExtSriovRegs> {

Since you have a typed variant defined, let this be

    impl ExtSriovCapability<'_> {

> +    /// Reads and decodes the VF memory BAR at configuration-space slot =
`bar_index`.
> +    #[inline]
> +    pub fn read_vf_bar(&self, bar_index: usize) -> Result<ExtSriovVfBar>=
 {
> +        if bar_index >=3D NUM_VF_BARS {
> +            return Err(EINVAL);
> +        }
> +
> +        let low =3D crate::io_read!(*self, .vf_bar[try: bar_index]);
> +        if low & bindings::PCI_BASE_ADDRESS_SPACE !=3D bindings::PCI_BAS=
E_ADDRESS_SPACE_MEMORY {
> +            return Err(EINVAL);
> +        }
> +
> +        let is_64bit =3D low & bindings::PCI_BASE_ADDRESS_MEM_TYPE_MASK
> +            =3D=3D bindings::PCI_BASE_ADDRESS_MEM_TYPE_64;
> +        let following_index =3D bar_index.checked_add(1).ok_or(EINVAL)?;

Looks like these BAR registers should be bitfields? The `vf_bar` member
will need to stay a regular `u32` because we don't know ahead of time
whether a given entry is the high part of a 64-bit BAR or not, but once
we read the value we could create a typed bitfield from it and avoid
doing the shifting/masking magic ourselves.

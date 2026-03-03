Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011055.outbound.protection.outlook.com [52.101.52.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFF638654B;
	Tue,  3 Mar 2026 20:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772568964; cv=fail; b=Ko5LCJxg7PoV3iV2FBllOuxyxquDKY3bRUx3MJQeEyQ0R3TiutDI0BB0ibC//ceGu+r7EKG/euVkszWtSkLpbVa4zer43Qy1/opnq+eDSns3biRHmIpC2lmDx3buO1eyROqYrkG8tcaXGZxivAxtc1/A5ycrvdWauLygg+obdhY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772568964; c=relaxed/simple;
	bh=NM9CC4Wb6LoVxSStUF0gn8zwdgE49ScW4hvh/wzS6Ho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=n2VPyvtWtQZJ+oSMFP3QXzkcAdxjuGkkIWr009+SjCWoTjX/bH/SKkSGq5+IbdwxWuh6g/4TVMBFdH3ABvdUQ0LzrgwnIvYap0LzwTm9D9x5VnDQ3m3up3NSGu0EaOoaKAaqQn/cTW9O0WZLsomyrH0nzigwatGtTYPmDB+Gto4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iIgP+zIB; arc=fail smtp.client-ip=52.101.52.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iIgP+zIB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HbMF9tNauLJoXbsFe3SKU5gZoQKpIt6aujI188upSu6nlrNDENYg6T0dtR3uqAhfgvVvY2A++/T17AIhT7IV1TGO9MMPBqYpn/0OvCnjnd9xq/JynWTOoUkiAXRHBu+5RNNvOed3rzSv2qGhoE+T5Y8Pn97ltOoZQYTry8cOqYAhNDEXN3UH+obaqiJ5dwFh4yUdk9+7IITtxHTksNLvQqzQM6u177EVA1xlRUxmQzuByDlzTD42YUoVXyN2zo2+hwGSNxvsssVcvHsf5+hJvQVaShMyrDC8h7raqQoEmDJu68mHuGkHS2v9lU5Ody8zmcOgQ60A6URM8Op1LzqPTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eZy7ZP8vRg6gDUhNF2No194PbUS1pptmcuVGNmWflUg=;
 b=T7PKWe/SPrhGBZ1ty4vkiJocchLWgstZT9P6wFXDTNJ8AJoMw5MoZ7RULwl4byp9EqioScAXkJslYHn/x311Y6rbHGJLGIgsDTkefhu/wSwLTK8J5KCHALROvkNQdWiigq9k+a/rqzT5OEwOSKU3rET7vwlXsI74WCgusBo8aa+UIHsimbHdwNRN+iW+MJXNVC8DXaxIcMcad31JC/ZDXP5o7EItEdQyVZ+ZZggtk8hGPcnyOJDaRo63gkvHrnTpZvOv4vw5LMBwToQQZZPlH0ujU3KzGbdntoSvpEjQdS0RkSvGhp4JWmkTLnBfOoqBf7IV05Oa5zKMHy9SpG1njA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eZy7ZP8vRg6gDUhNF2No194PbUS1pptmcuVGNmWflUg=;
 b=iIgP+zIB+KGGbLyo28dYX1SFlEN21ZG4abm6eTtG+4E6bh/bwqxt93VK5T2+hVC1GwbCpa2rxUfVkkIJRs0Vo7J9cK2akNybP8Yxm2EeecdtwS5adaVkJ4PKfQcVmKbFItevLjbRjE0JKAxPWlTwQF3NIt7wYyzMnjLxPXwqr3XfpRXkMMQ/mzTesqJeo+2Q3xjZKYX23t4tNoF3jeaauoB+sLJFoinStbtcO3/s8XkGFZTvYd7Nz+yDAt7qYBbvYdIlav00leFRTPQVNudWbPRxNEJajX0zFWwppB0l36mGnE7Ga99imhuIqVlqA/6Ng6cf+l3l/oTLOZHM5QPVhQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH1PPFE5ACC0FD2.namprd12.prod.outlook.com (2603:10b6:61f:fc00::629) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 20:15:56 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 20:15:55 +0000
Date: Tue, 3 Mar 2026 16:15:52 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Zhi Wang <zhiw@nvidia.com>
Cc: rust-for-linux@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, dakr@kernel.org, gary@garyguo.net,
	joelagnelf@nvidia.com, aliceryhl@google.com, bhelgaas@google.com,
	kwilczynski@kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com,
	boqun.feng@gmail.com, bjorn3_gh@protonmail.com, lossin@kernel.org,
	a.hindborg@kernel.org, tmgross@umich.edu, markus.probst@posteo.de,
	helgaas@kernel.org, cjia@nvidia.com, smitra@nvidia.com,
	ankita@nvidia.com, aniketa@nvidia.com, kwankhede@nvidia.com,
	targupta@nvidia.com, acourbot@nvidia.com, jhubbard@nvidia.com,
	zhiwang@kernel.org, daniel.almeida@collabora.com
Subject: Re: [PATCH v3 1/1] rust: introduce abstractions for fwctl
Message-ID: <20260303201552.GF972761@nvidia.com>
References: <20260217204909.211793-1-zhiw@nvidia.com>
 <20260217204909.211793-2-zhiw@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260217204909.211793-2-zhiw@nvidia.com>
X-ClientProxiedBy: IA4P220CA0008.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:558::6) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH1PPFE5ACC0FD2:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dafcf23-a494-464e-0248-08de7961ad0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	TEW24ILcFaTtOTHLh5yNv2jatMFQafafD6uObRO07YuTsdEONNzRMIQPvoTXGDDIamvnMLYbKUBnpmxjolsJ9uslPZZWsmnNmFp4JMin59HG7ZNWTAn2lp9whkao7MpqbNG/DPlhtOJrEp3Oq3CU3fCSst1A25Qws01f76LvrQvVXuSdHBIBa0yYkBouIkmxS9xjXOoCntbrutPhyBPm0KO35bDZDO5Yth7TcEIjo5oZpa69evNk9h6dTU1lyvsMpNaS6KH8R/ycbKMY1HeUt/sGVIVG493tXFpbdlZv3PmgUIoyEV5rylHFp7YR6UBS/Qht/34JjRGEhtOErQeO62j1plNykdIbYrzV1WOu+P744CkGe6NVTPoAUsGapFCVjPCLrw4prKyKhncDddCdqRupGD7FEFZ6y5SrgYtwazXc2wgjIy54D8Q/XqPD6ruytCUpHRraFuhz8PgAMygxG2hgIqGWekpsCu8lO5mNN40s5YjfFMgC0qlX4YuAI/p1slgNsqQBRCEeYJSMDAY4krw9aD9JJS0biyBo9ZxBWux6Ni8dH9U2Mvlg2ToveVN7WOtXX9m7Gi3bJ4WbpGph0HE6MSutbewiWt++0wHOpyelkyryiN6SEl2S7yDWd5x5otTHEzwmzK2NJXlQ91zZykYcEWNKCyCkusOhWO1rjHDRjfAf6yUvLJZtcnuUWKypYMFUQbjDbBdq/xxEYUwpMuQEz1fcPIkT8MeKXMLvbFU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3vizqh2iLYXjCOsJczD/z4TNw9IwZXhcTBV9um3/wPQ+QxsaXxCuu3nA0qSo?=
 =?us-ascii?Q?NK0Y3/6xssV7MmU2oy31nnzAO6Gf2dxvKYIcziq0KtqqWmplj0glV3iQbXH/?=
 =?us-ascii?Q?BtQG8npmLywKTmtcgpPLOabt/usAA5gVdfZlqNjtbD7KL5MZLOiV2hoUHx5R?=
 =?us-ascii?Q?sLfqCF9lxhQgRuUIIHmLK5wwlBgQBsLDnWvxdEVZs5nptk0xuJwHlbsKud2+?=
 =?us-ascii?Q?yz4hx9N6N8u3C77K5zU1Nh02SN16YXcs/U5IgBEW8i9oxxdTlK9wxN37Pg5f?=
 =?us-ascii?Q?hEPqa1BH83Cl3wnpxBtq1rWxxaVR5uk8Va7Yoe8U9lEqfPPupESJl8lirc0l?=
 =?us-ascii?Q?eoq0pCH8PRQqnyt4yqHSe5Af2rw/nLFCnVjdzUQMSDNx5S06zXM1syFDz5Hx?=
 =?us-ascii?Q?TDdkrv2iCsdCfX7YLVDxHN+rwrq42vtvnNJT4LyWYdzycPXXhyzckgv6TZuk?=
 =?us-ascii?Q?uwVyufryCRybFP6HhZDAYfLwDLCEBin7/KTV5Fx0ii+3SOCWywZFvYbLhAtX?=
 =?us-ascii?Q?Kv6H1f/FrbM6uRLliHGLXzo70AT/9aIW/i7p9ts9Oj4gDMNqtzlUQhGuM0rV?=
 =?us-ascii?Q?Q9RGbqo31gua/pO/QKbGnlDuSW6DTW55CNqAwhivRzcMRC4gt/2dpHcOQSPx?=
 =?us-ascii?Q?xBdQOQ1tmNvT49KtANY38RBmJ1xYL04Do/wCL+1S4FhNIaM0v2SG9dP5COTi?=
 =?us-ascii?Q?7yk5zB6kWYxy10YaEZGd2ZMDoF/hqvsFbsrH+tmHsfYg6w5TGKs+qYTZiRUs?=
 =?us-ascii?Q?I74ApdwKmqV3YYySwLUSNSmFAzD+l7pZIKj58pjZalpLtJMdfUxhJZMNAFIV?=
 =?us-ascii?Q?vfRGEXXh5rsDSyVoXAThWi6iaYa5kHGPQpAkXHc3eMPKIx4d6bqVw/H+XNRS?=
 =?us-ascii?Q?psOy4qQ1nTOljqq3rbxbVLH8zuiwtBSgLYwLtH26K9ATFPyPpBpB0dS9ourI?=
 =?us-ascii?Q?8OWpbJszglNYw8NEetdU89mX2UsHabYytgVBatJRZ9VBrnEK24TWxlPvd/Js?=
 =?us-ascii?Q?CsQAAqyEUGUD6QhTe/sb1dXUsY79Fq9BaSPN7wqHwmkBkcXUDwls/HSiHeHj?=
 =?us-ascii?Q?8BqR2sUWJt+KJLYeqPJhdt14SxMCcGsqE8sEiSITGd2X6cCCQ+ptdxYhV4fU?=
 =?us-ascii?Q?70f0cQ6bIgnwuMDxvsLQ4xKfSA+O+dr4dHFMe2Uu4JrpTL/AL/QXPUEqzazq?=
 =?us-ascii?Q?uJ5SGENviRzyuIDIRguixszF4RJhNgWEEKXG8ukaT55vcZM7rdM+xT5AlKfP?=
 =?us-ascii?Q?Gy5TkXrWRONGaWf0yHY7hNaruAkVUMRXW5TbkgSKxDJ3NoPwEhVKb27BgzKo?=
 =?us-ascii?Q?CkH/rWpY+UQ0AidyHCUreSeQHeod5Qi3r0c4IsD+07DrcAMz8Qfxch9EUI7A?=
 =?us-ascii?Q?K+8B1mmaBWg9ymRn7AHSd8IX8Zw+l3Sk1rr0RSAikZgeZ/t4+QgbAwgCdnpN?=
 =?us-ascii?Q?/OwVv+50cG2JUlu8PZisCPA3HT+3Ej4twnpoeF8Z8W5YNBTKSXUh7YNDF29J?=
 =?us-ascii?Q?01yXwA4x0MTG97GfuxSNvp14ChuDLjFdXMXhGk28AAKwxIVHiJrvmamLbBmt?=
 =?us-ascii?Q?HblcDH2uyMmIz6IGPvJIjh0zq/sJCNtnt+5jCNDFPNEbOepFURpJDHI5pVIE?=
 =?us-ascii?Q?PsGorm565A0+1muLC3SzioZ7B9+e25BPcHTaIIQc1B7ujhABqL9XeP8C23+R?=
 =?us-ascii?Q?369bYlHtiXRAvvAq3lbAxuvhA5PBUH9Umj5kTVYNRe9jbEv1uichlVNi2rXA?=
 =?us-ascii?Q?JFbjcYeYvg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dafcf23-a494-464e-0248-08de7961ad0d
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 20:15:55.7890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kIaFlmkX5AWbYaYfi23RU7Jl2SHYsfBfPf4wlpuqs8C3lHSGZ4roFQVyEyMvNWEe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFE5ACC0FD2

On Tue, Feb 17, 2026 at 10:49:06PM +0200, Zhi Wang wrote:
> Introduce safe wrappers around `struct fwctl_device` and
> `struct fwctl_uctx`, allowing rust drivers to register fwctl devices and
> implement their control and RPC logic in safe rust.
> 
> Cc: Danilo Krummrich <dakr@kernel.org>
> Cc: Gary Guo <gary@garyguo.net>
> Cc: Jason Gunthorpe <jgg@nvidia.com>
> Cc: Joel Fernandes <joelagnelf@nvidia.com>
> Signed-off-by: Zhi Wang <zhiw@nvidia.com>
> ---
>  drivers/fwctl/Kconfig           |  12 +
>  rust/bindings/bindings_helper.h |   1 +
>  rust/helpers/fwctl.c            |  17 ++
>  rust/helpers/helpers.c          |   3 +-
>  rust/kernel/fwctl.rs            | 449 ++++++++++++++++++++++++++++++++

The binding is larger than the subystem file:

$ wc -l drivers/fwctl/main.c 
421 drivers/fwctl/main.c

:\

Anyhow is someone waiting for me to do something with it?

> +impl<T: Operations> Device<T> {
> +    /// Allocate a new fwctl device with embedded driver data.
> +    ///
> +    /// Returns an [`ARef`] that can be passed to [`Registration::new()`]
> +    /// to make the device visible to userspace. The caller may inspect or
> +    /// configure the device between allocation and registration.
> +    pub fn new(
> +        parent: &device::Device<device::Bound>,
> +        data: impl PinInit<T::DeviceData, Error>,
> +    ) -> Result<ARef<Self>> {
> +        let ops = core::ptr::from_ref::<bindings::fwctl_ops>(&VTable::<T>::VTABLE).cast_mut();
> +
> +        // SAFETY: `_fwctl_alloc_device` allocates `size` bytes via kzalloc and
> +        // initialises the embedded fwctl_device. `ops` points to a static vtable
> +        // that outlives the device. `parent` is bound.
> +        let raw = unsafe {
> +            bindings::_fwctl_alloc_device(parent.as_raw(), ops, core::mem::size_of::<Self>())
> +        };
> +
> +        if raw.is_null() {
> +            return Err(ENOMEM);
> +        }
> +
> +        // CAST: Device<T> is repr(C) with fwctl_device at offset 0.
> +        let this = raw as *mut Self;

Should this have some helper? It looks a bit fragile, in C we have a
static_assert on offsetof to prevent errors.

Jason

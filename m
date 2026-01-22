Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010011.outbound.protection.outlook.com [52.101.56.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9F42E6CAB;
	Thu, 22 Jan 2026 12:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769086387; cv=fail; b=dMJy8ivIqmh0ffapWfNNiEdMzPxnNzLD3KSjGR7vec4UdSF9C5EGjzoSR4/irKYnJxjY85WkZ8AEvGGGFmfuoiigROXJfUaflexT4wCupJvHzPOGxxyPjW5U4K2/rb8C1PqIN0csBL4iLkW9MXIYQuhXgCb7IcmXj4hxd50zYHo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769086387; c=relaxed/simple;
	bh=D9pzk02M7umXLTTeiEh1bE7DvtCZWJP6ec2kez38gxo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RxYyyVPrgcI9UMa6qHsWAXNmDWMKpivcdS0751BUlUWUvK1NvxTKrc7hl75Wvh3+OAyKSCzqA/sLBP8qwDhOY2iPDybLZ0TV8+kSKazaF8XjhiboDAt9tSGAbyuFcYEct+IclJrBFPvOYbdEt+0HyhkWMTWY65oVbaWRPG0qpKY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nhfc7FIb; arc=fail smtp.client-ip=52.101.56.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nhfc7FIb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XGmvvI1Y75nsY6/SycMwzxkPijUv7cT3iNT66++E6Bak0/XjPJOYeOGd0KfJl/1eO0A+B6N91AKPV9yhE5mpbgL66UvLhpC6aZrhDE29mT9x0rmXFhEjSN85ZPR6Aqi/PIHsUFcILILgLxxpR6KemcVlyFtR8pgX1/XXRXBBl3S8Onyi4KYGTIx4zEqJFAdPEkKGq//C6+owCeCrF3wpxup13H9Tj2+dqpVPlMgqnKkG0YPvxLf42eRZFAtz/miIvjgY1HrKNpGIfQ/11S8TnPHOdsPNeyeDEgmUiwYjgEZAqLFbYSWtCRxTMYZ00R8z+2qXy0rfegZhLWZg1fxRDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MLA2wWOsHbTEHOXYABxDS31FUulCS8wvrnWcEKs3GCk=;
 b=b0CSV6P7ttr4nY7dEyYGRIeuZgOeT2TCIRGNMgAi4JP+r4wlyg8WX71V4tiLDEfC4fIZxkD4J1/cxqcbnPZLD5yG4zZkORX/hSbcOzaHyj2dv9HJ79LeosNLm2wP8cOTgMPzER9Z90z5aTyihUt+38T9OL+u7Eyivy/Q0a7BF+UKPqn0iF3INCHl5la3D4YosaBuc47ZQ8bIelJhOBuOsipDEVM36NJLajquQiYi1+jJJtwwP5qQ16hqJ/ff+DmuiGoZXL4kaNosDTEfO55zRpVlHQUuTgLBuOt5YCbTesVstyiXtc6zMuY22Hgb52xBk9rHGPMAZyTbTZ3ZJdVByw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MLA2wWOsHbTEHOXYABxDS31FUulCS8wvrnWcEKs3GCk=;
 b=nhfc7FIbJVjM7o76TazXB2CuY2gJvJQlhE1mcCpOpOyZDY0758x51J5G+/mvZef6/lMQfDhLhkaDZiyATHC6wVIDoyXhFVcGqG0tXf/YqfNvZ9p7AeWLNHKPaNFHlz2VgmgEKgdSfIEBwjYlw758r1v77XqM2GXIyBFXBM0wQnpc5vhsmrDRKSIt/H4BWP+1E5WqQZCIaMgcFSHGhNmxAk+UIxPuPqb/+KzS99ocHlBxw8OMQ6f5nXgcfjz+MaXheZ06qDpSielOdHYEvLBDkxo+MXLQPbf7K0YaLaA2QtpjZnXm79ZLGAXhnT2PpgjFH4xSZ6giLQuWx+hbIJoeLg==
Received: from MN2PR03CA0006.namprd03.prod.outlook.com (2603:10b6:208:23a::11)
 by DM3PR12MB9349.namprd12.prod.outlook.com (2603:10b6:0:49::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Thu, 22 Jan
 2026 12:52:57 +0000
Received: from BL02EPF0001A101.namprd05.prod.outlook.com
 (2603:10b6:208:23a:cafe::be) by MN2PR03CA0006.outlook.office365.com
 (2603:10b6:208:23a::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.10 via Frontend Transport; Thu,
 22 Jan 2026 12:52:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL02EPF0001A101.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Thu, 22 Jan 2026 12:52:57 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 22 Jan
 2026 04:52:42 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 22 Jan 2026 04:52:41 -0800
Received: from inno-thin-client (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 22 Jan 2026 04:52:36 -0800
Date: Thu, 22 Jan 2026 14:52:34 +0200
From: Zhi Wang <zhiw@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>
CC: Gary Guo <gary@garyguo.net>, <rust-for-linux@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<aliceryhl@google.com>, <bhelgaas@google.com>, <kwilczynski@kernel.org>,
	<ojeda@kernel.org>, <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>,
	<bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
	<tmgross@umich.edu>, <markus.probst@posteo.de>, <helgaas@kernel.org>,
	<cjia@nvidia.com>, <smitra@nvidia.com>, <ankita@nvidia.com>,
	<aniketa@nvidia.com>, <kwankhede@nvidia.com>, <targupta@nvidia.com>,
	<acourbot@nvidia.com>, <joelagnelf@nvidia.com>, <jhubbard@nvidia.com>,
	<zhiwang@kernel.org>, <daniel.almeida@collabora.com>
Subject: Re: [PATCH v12 4/5] rust: pci: add config space read/write support
Message-ID: <20260122145234.1839245a.zhiw@nvidia.com>
In-Reply-To: <DFV4IJDQC2J6.1Q91JOAL6CJSG@kernel.org>
References: <20260121202212.4438-1-zhiw@nvidia.com>
	<20260121202212.4438-5-zhiw@nvidia.com>
	<DFV3N1SHS8SK.338Z25H89HINU@garyguo.net>
	<DFV4IJDQC2J6.1Q91JOAL6CJSG@kernel.org>
Organization: NVIDIA
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A101:EE_|DM3PR12MB9349:EE_
X-MS-Office365-Filtering-Correlation-Id: 295ccffe-f738-402b-48ae-08de59b52ae4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pK0RX3cKR+vWoQhSVxOzwlj8FCizL2WcTO7lWSNzAhTD6N9z7ATKJM6SL1NY?=
 =?us-ascii?Q?ErZPj6puyoEuMq9maZUz36JZq9m0pT9HEw4pby7xgQeVD023uQn0d2FZxZu5?=
 =?us-ascii?Q?yumT+co427GXuCU2h0PuQX3vWXL1nc2XHNRTqdOcGuwZL1ICf/BhHt5CRG5c?=
 =?us-ascii?Q?wmslrP6PpNWchl8lTKv34b8h4ux8u3U/sqDMRW9xXSQQwMQLO/w1dBzjlw1t?=
 =?us-ascii?Q?TOCAStWTWNGKK2n3pA+zch54LnWHKWyeW6dM5iImkFaywRPFrA8+BM1YQqDu?=
 =?us-ascii?Q?7m9nXc+LEMo8WFvQM2Ra8hFUFeNcnJItpyqJC/1Uga/g4zrfG2jhVoiub0up?=
 =?us-ascii?Q?0mfZMwFfSy3wtFs4gAewkBdpRmkZdu/mqnK2ajBoAOQ2CwFvdQX9gyH4XgJL?=
 =?us-ascii?Q?7xi5tc0LMBUI+cd1USanYWaEMR2xfriW4W1mNPn0GcuqPD1iacZJyMggugOJ?=
 =?us-ascii?Q?BeBPpJ5Rnj9oqN7tsUutIzvckk4cTYvZGPlSBBcEvawrYipzCoxGWirmR9zG?=
 =?us-ascii?Q?rNOT/iGL0Qx22W0QkgpexWy75oLDge1XS9FOkneSmLCmn9CqiZACsatI5CO0?=
 =?us-ascii?Q?W7qxlAIhRAn0Yvl/EdQuyu5nhssG0t6M6yjDAS2GViT75uR6a2PJ//ah0Xfw?=
 =?us-ascii?Q?c61crzz4DAsvHJ9nEvp7fqkOuKUjy/LUcTPcdD+qOW457l7ZWewQfx+U74vY?=
 =?us-ascii?Q?3BuptHk/iuG/JpovulQgt0li1DJG7vlwLh1Ly+u3SB4W69zzEN4xn/2d59iY?=
 =?us-ascii?Q?N5GxElp1owrp1wnRhInIdh87vOlhwFvUVfgYKLxSTTw5odt/IzI2pJ6EPgJg?=
 =?us-ascii?Q?Z4h+7SIHNQkt1OQyZIO9HAz5wYNDUrrE9x70FNWuRNGI1aOUeEGSzbV4P6Jm?=
 =?us-ascii?Q?pzo8FQ1Ba9XnGfnXFi7LQGXfTQI8GqOHfmBrXC8GRFxvUhnzyG6J8H+szj92?=
 =?us-ascii?Q?XVHMPHIHLvIP0HJJoy+Pd9gm2SehjEIo854+Fn85kpoquYAGFGq3eU2e2z+0?=
 =?us-ascii?Q?+dcezIFyDn3LoA1UT+B7q50fnIyYmxBMCv5qcD87GrggyXE8KYhJ2BXGJ0jz?=
 =?us-ascii?Q?FDZSfdbJg0h7QEHSO6jS0X8BIF36zRccowDkEoeDPXfPPznwcKmJNBvr0YvP?=
 =?us-ascii?Q?jCppvj+v7Yy1cuB72nw2vZBCTKWppL15zqYgppEe/ZgpLGqwu9ZRl3mnVjJS?=
 =?us-ascii?Q?4ntDlqzS9YaQzYfYv7d6MD5YRcfGna75OYB1aPdkN8UXJ4QSRXTBpzZWdMd9?=
 =?us-ascii?Q?Hk6SsDEFEn+kZcESeVEAy8zlksPkqsgZXtCZNxQR7YbAS3YEqg/QeLqAX4AV?=
 =?us-ascii?Q?2BCR2X3jyInA536LwWwY8jJ7KxXebVGdAdYDtWJJOk9RZiLeCnXYg2hC31zP?=
 =?us-ascii?Q?Wfw1hUZUMZU78OUW17vtmB8f+dR1PU1u6GSOb2SmoGdjAX0ePygVjS6LQZD6?=
 =?us-ascii?Q?LZ4VpbLsyrUGnL+LF7LWFiJxcz68WTriPXWb7X2q4cMK7Gv+jLn0sT7LDEHe?=
 =?us-ascii?Q?MeHWHq1jswcVgK4RQfRPAHB2b7Yw2QkDwzUBtYnjdrHyqjQ/rGGLZi6bnRdU?=
 =?us-ascii?Q?IdnSJfEouQ1IVe90G+Jtwhq5ipYUa8aUZ6VQUuOXDkArb2V2YZ54X+Y8jazw?=
 =?us-ascii?Q?LwO311t9xKSiORlNEYS1AdB6V5n0wBx7KMZkj3WVN2TGQ1myuPV3ksh6lbcf?=
 =?us-ascii?Q?QoOosQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 12:52:57.4886
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 295ccffe-f738-402b-48ae-08de59b52ae4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A101.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9349

On Thu, 22 Jan 2026 13:40:22 +0100
"Danilo Krummrich" <dakr@kernel.org> wrote:

> On Thu Jan 22, 2026 at 12:59 PM CET, Gary Guo wrote:
> > On Wed Jan 21, 2026 at 8:22 PM GMT, Zhi Wang wrote:

> (@Zhi: If we all agree on the diff and nothing else comes up you don't
> need to resend. :)
> 

Hi Danilo:

Thanks so much for this. I went through the code. It looks good to me.

Z.

> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> index 9020959ce0c7..1d1a253e5d5d 100644
> --- a/rust/kernel/pci.rs
> +++ b/rust/kernel/pci.rs
> @@ -42,6 +42,7 @@
>  };
>  pub use self::io::{
>      Bar,
> +    ConfigSpaceKind,
>      ConfigSpaceSize,
>      Extended,
>      Normal, //
> diff --git a/rust/kernel/pci/io.rs b/rust/kernel/pci/io.rs
> index 39df41d0eaab..5dbdfe516418 100644
> --- a/rust/kernel/pci/io.rs
> +++ b/rust/kernel/pci/io.rs
> @@ -24,6 +24,31 @@
>      ops::Deref, //
>  };
> 
> +/// Represents the size of a PCI configuration space.
> +///
> +/// PCI devices can have either a *normal* (legacy) configuration space
> of 256 bytes, +/// or an *extended* configuration space of 4096 bytes as
> defined in the PCI Express +/// specification.
> +#[repr(usize)]
> +#[derive(PartialEq)]
> +pub enum ConfigSpaceSize {
> +    /// 256-byte legacy PCI configuration space.
> +    Normal = 256,
> +
> +    /// 4096-byte PCIe extended configuration space.
> +    Extended = 4096,
> +}
> +
> +impl ConfigSpaceSize {
> +    /// Get the raw value of this enum.
> +    #[inline(always)]
> +    pub const fn into_raw(self) -> usize {
> +        // CAST: PCI configuration space size is at most 4096 bytes, so
> the value always fits
> +        // within `usize` without truncation or sign change.
> +        self as usize
> +    }
> +}
> +
>  /// Marker type for normal (256-byte) PCI configuration space.
>  pub struct Normal;
> 
> @@ -34,16 +59,16 @@
>  ///
>  /// This trait is implemented by [`Normal`] and [`Extended`] to provide
>  /// compile-time knowledge of the configuration space size.
> -pub trait ConfigSpaceSize {
> +pub trait ConfigSpaceKind {
>      /// The size of this configuration space in bytes.
>      const SIZE: usize;
>  }
> 
> -impl ConfigSpaceSize for Normal {
> +impl ConfigSpaceKind for Normal {
>      const SIZE: usize = 256;
>  }
> 
> -impl ConfigSpaceSize for Extended {
> +impl ConfigSpaceKind for Extended {
>      const SIZE: usize = 4096;
>  }
> 
> @@ -55,7 +80,7 @@ impl ConfigSpaceSize for Extended {
>  /// The generic parameter `S` indicates the maximum size of the
> configuration space. /// Use [`Normal`] for 256-byte legacy
> configuration space or [`Extended`] for /// 4096-byte PCIe extended
> configuration space (default). -pub struct ConfigSpace<'a, S:
> ConfigSpaceSize = Extended> { +pub struct ConfigSpace<'a, S:
> ConfigSpaceKind = Extended> { pub(crate) pdev: &'a Device<device::Bound>,
>      _marker: PhantomData<S>,
>  }
> @@ -118,11 +143,11 @@ macro_rules! call_config_write {
>  }
> 
>  // PCI configuration space supports 8, 16, and 32-bit accesses.
> -impl<'a, S: ConfigSpaceSize> IoCapable<u8> for ConfigSpace<'a, S> {}
> -impl<'a, S: ConfigSpaceSize> IoCapable<u16> for ConfigSpace<'a, S> {}
> -impl<'a, S: ConfigSpaceSize> IoCapable<u32> for ConfigSpace<'a, S> {}
> +impl<'a, S: ConfigSpaceKind> IoCapable<u8> for ConfigSpace<'a, S> {}
> +impl<'a, S: ConfigSpaceKind> IoCapable<u16> for ConfigSpace<'a, S> {}
> +impl<'a, S: ConfigSpaceKind> IoCapable<u32> for ConfigSpace<'a, S> {}
> 
> -impl<'a, S: ConfigSpaceSize> Io for ConfigSpace<'a, S> {
> +impl<'a, S: ConfigSpaceKind> Io for ConfigSpace<'a, S> {
>      const MIN_SIZE: usize = S::SIZE;
> 
>      /// Returns the base address of the I/O region. It is always 0 for
> configuration space. @@ -134,7 +159,7 @@ fn addr(&self) -> usize {
>      /// Returns the maximum size of the configuration space.
>      #[inline]
>      fn maxsize(&self) -> usize {
> -        self.pdev.cfg_size().map_or(0, |v| v)
> +        self.pdev.cfg_size().into_raw()
>      }
> 
>      // PCI configuration space does not support fallible operations.
> @@ -150,7 +175,7 @@ fn maxsize(&self) -> usize {
>  }
> 
>  /// Marker trait indicating ConfigSpace has a known size at compile
> time. -impl<'a, S: ConfigSpaceSize> IoKnownSize for ConfigSpace<'a, S> {}
> +impl<'a, S: ConfigSpaceKind> IoKnownSize for ConfigSpace<'a, S> {}
> 
>  /// A PCI BAR to perform I/O-Operations on.
>  ///
> @@ -281,29 +306,35 @@ pub fn iomap_region<'a>(
>          self.iomap_region_sized::<0>(bar, name)
>      }
> 
> -    /// Returns the size of configuration space in bytes.
> -    fn cfg_size(&self) -> Result<usize> {
> +    /// Returns the size of configuration space.
> +    fn cfg_size(&self) -> ConfigSpaceSize {
>          // SAFETY: `self.as_raw` is a valid pointer to a `struct
> pci_dev`. let size = unsafe { (*self.as_raw()).cfg_size };
>          match size {
> -            256 | 4096 => Ok(size as usize),
> +            256 => ConfigSpaceSize::Normal,
> +            4096 => ConfigSpaceSize::Extended,
>              _ => {
> -                debug_assert!(false);
> -                Err(EINVAL)
> +                // PANIC: The PCI subsystem only ever reports the
> configuration space size as either
> +                // `ConfigSpaceSize::Normal` or
> `ConfigSpaceSize::Extended`.
> +                unreachable!();
>              }
>          }
>      }
> 
>      /// Return an initialized normal (256-byte) config space object.
> -    pub fn config_space<'a>(&'a self) -> Result<ConfigSpace<'a,
> Normal>> {
> -        Ok(ConfigSpace {
> +    pub fn config_space<'a>(&'a self) -> ConfigSpace<'a, Normal> {
> +        ConfigSpace {
>              pdev: self,
>              _marker: PhantomData,
> -        })
> +        }
>      }
> 
>      /// Return an initialized extended (4096-byte) config space object.
>      pub fn config_space_extended<'a>(&'a self) ->
> Result<ConfigSpace<'a, Extended>> {
> +        if self.cfg_size() != ConfigSpaceSize::Extended {
> +            return Err(EINVAL);
> +        }
> +
>          Ok(ConfigSpace {
>              pdev: self,
>              _marker: PhantomData,
> diff --git a/samples/rust/rust_driver_pci.rs
> b/samples/rust/rust_driver_pci.rs index 1bc5bd1a8df5..8eea79e858a2 100644
> --- a/samples/rust/rust_driver_pci.rs
> +++ b/samples/rust/rust_driver_pci.rs
> @@ -67,8 +67,8 @@ fn testdev(index: &TestIndex, bar: &Bar0) ->
> Result<u32> { Ok(bar.read32(Regs::COUNT))
>      }
> 
> -    fn config_space(pdev: &pci::Device<Bound>) -> Result {
> -        let config = pdev.config_space()?;
> +    fn config_space(pdev: &pci::Device<Bound>) {
> +        let config = pdev.config_space();
> 
>          // TODO: use the register!() macro for defining PCI
> configuration space registers once it // has been move out of nova-core.
> @@ -89,8 +89,6 @@ fn config_space(pdev: &pci::Device<Bound>) -> Result {
>              "pci-testdev config space read32 BAR 0: {:x}\n",
>              config.read32(0x10)
>          );
> -
> -        Ok(())
>      }
>  }
> 
> @@ -123,7 +121,7 @@ fn probe(pdev: &pci::Device<Core>, info:
> &Self::IdInfo) -> impl PinInit<Self, Er "pci-testdev data-match count:
> {}\n", Self::testdev(info, bar)?
>                      );
> -                    Self::config_space(pdev)?;
> +                    Self::config_space(pdev);
>                  },
>                  pdev: pdev.into(),
>              }))
> 


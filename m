Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010038.outbound.protection.outlook.com [52.101.193.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31C33947B8;
	Mon, 20 Apr 2026 10:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776680066; cv=fail; b=b0k8ZzWbuFLNDqfYNahiT7SXGncDV85XbkgTVCn2a3m1aOPiUFm9E/z0+eZX7zkyblhAfubSJEbxXESgM95a1bDCwxqo7QBUipBjjiIcoF+0VOQacH6VvSda7kkbIZN2v0M4w1g9ZMFG1umVnd4P5onHDHRIYWolVrUSppF+odo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776680066; c=relaxed/simple;
	bh=2I2O7pB0hNHQvDPmuizEXfkb4q1swqYw5Cfpo2Vz2Gc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UWnHWJEOtwqyLNs/GTl1ODIaqgbEQL8JZ8V7hZLbBaBtIlxF54gUoOHUvTuXZBGURD9xl/l4jqY+53tDWm2xtCuar28knxNfjQAw2LUG0tDt2fvSutdX8eRamcszwmhODasyPhFokMCcYMSZPa4BohCu+XIWj3CBti6D+e50nyw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SatMF2Pk; arc=fail smtp.client-ip=52.101.193.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SatMF2Pk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E524Mzp0qHhgmPgizfgTKi4e6ykky0YZpyUpeNjP3V7m9zCmgAjh47on4xzq90TII2Mp1LZfo4KOtlqanWs3S9szlE3NYrNfnS9wBWOI1CV6pIs2yAwJ5akkaDUpji9Lsmg1n8WvrEYSRhmK98fsLsQ66aqEHf8mJLwCULnXOTgCZFn2SojoyBsLGaa0902211dPeco3dlXql3YLiWie61aRYrKk5C6bRfqJb8pjsrCP8xlM7QkxFmM4jfZeLwqA4cGlWqEkxIBjO3P8pWjOcdSXl+Y5e2kdub1K2I1kg5JnnuW3+EMRLZWwVBgE4AZ5zwC6Do1AM1tsL/MbJEO+9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XwToyZvlhSoMGHnBqEKT4cVRX5gES4fbPZTLCxJFUBY=;
 b=WZnszWmzQOik4KGkZ6E7x8qFOQvEJCPGmaoueMOLEEDF2ckqV0++8/zg+Cjp2pXCP1zzm0XFE8MGgxBmPqXIx0xA3M3O3PgXYVfTLLsAUP4eQIlvaicBzK+1ckd8HoQ+y+ZkLkjdE/nLiYB+USbsHhaQrWDV01j8i+gM6nUBk6V+qtFitvrO5KTe4ngD2vo3DLIB4ze5W7I5uTaxssI3L9cEP4yT30oduA+Xu1owxAtN1H/9fb4CMTDk0KFIF4Wz4sg563fLnotKfBZVPNiBJq5L7Wy/FL/3cC9corxep1dpAOaxO9MkvW4R4VAsqiopdP6qmAx7AEKCrM+lNz5m0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=posteo.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XwToyZvlhSoMGHnBqEKT4cVRX5gES4fbPZTLCxJFUBY=;
 b=SatMF2PkQQTk5GH1xRyTcUfZM7pxIKpuDS2K34vYSoiD6lm2xc2oGYtanewxfJ31kcMtUVZqJzupyPx03yV3EWJSx3jnOwEJYtswf+fmKEo2hKi37mH5k30rSRrogyf2mgh57nDd9uRQPLMq0OBfQUloeGMPf2IY+foW8YWT2O0F1w3/CzW+rBYmfMoATQMo2iDZI/Wy+shryj2miWBnP1hYFDEiwGXrc3GngVv2B5fP5tftYVn68ANcqMMqu5m2NoYPlpNiYh2zZjxBIewXa1zBQ3bYExMdAcu0ISSI3tH9hamnXykDUj309UcOOUUQs8SpKJuLDmhUL+pOpS7boQ==
Received: from BN9PR03CA0471.namprd03.prod.outlook.com (2603:10b6:408:139::26)
 by SA1PR12MB9489.namprd12.prod.outlook.com (2603:10b6:806:45c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.15; Mon, 20 Apr
 2026 10:14:18 +0000
Received: from BN1PEPF00005FFE.namprd05.prod.outlook.com
 (2603:10b6:408:139:cafe::e4) by BN9PR03CA0471.outlook.office365.com
 (2603:10b6:408:139::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Mon,
 20 Apr 2026 10:14:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN1PEPF00005FFE.mail.protection.outlook.com (10.167.243.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9791.48 via Frontend Transport; Mon, 20 Apr 2026 10:14:17 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 20 Apr
 2026 03:14:06 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 20 Apr 2026 03:14:05 -0700
Received: from inno-dell (10.127.8.12) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 20 Apr 2026 03:13:59 -0700
Date: Mon, 20 Apr 2026 13:13:56 +0300
From: Zhi Wang <zhiw@nvidia.com>
To: Alexandre Courbot <acourbot@nvidia.com>
CC: <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <dakr@kernel.org>, <aliceryhl@google.com>,
	<bhelgaas@google.com>, <kwilczynski@kernel.org>, <ojeda@kernel.org>,
	<boqun@kernel.org>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
	<lossin@kernel.org>, <a.hindborg@kernel.org>, <tmgross@umich.edu>,
	<markus.probst@posteo.de>, <cjia@nvidia.com>, <smitra@nvidia.com>,
	<ankita@nvidia.com>, <aniketa@nvidia.com>, <kwankhede@nvidia.com>,
	<targupta@nvidia.com>, <joelagnelf@nvidia.com>, <jhubbard@nvidia.com>,
	<kjaju@nvidia.com>, <zhiwang@kernel.org>
Subject: Re: [PATCH v3 1/1] rust: pci: add extended capability and SR-IOV
 support
Message-ID: <20260420131356.189e7209@inno-dell>
In-Reply-To: <DHRTUAF52GNI.1J98TSAG1LS6Q@nvidia.com>
References: <20260409185254.3869808-1-zhiw@nvidia.com>
	<20260409185254.3869808-2-zhiw@nvidia.com>
	<DHRTUAF52GNI.1J98TSAG1LS6Q@nvidia.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFE:EE_|SA1PR12MB9489:EE_
X-MS-Office365-Filtering-Correlation-Id: 11fe6919-d6c6-472d-7539-08de9ec594b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|7416014|376014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Kb9BqYyaGqPs5yoSjPhd6qvymqWXeBibWZSgLib+MvCUMU9bWw9lDmCkYWNVzO1nmR+dpqiSwFbBr3RfXdLm68okS/Kmzq3V7EC+grcZGnN9wzLmZNItNc1icghKCwOXx8//lFA0a4Uwsbvr4DBPYeLpkzsyg4QjoXjkHI3diWM7BNE7f2V2FTdt8TpmsPhH3YRx8cCdYVyC5Z4WetISmJq9ZB2VPNriNZDDquEEphhyzay75Rj+82HjuGDSjvKWWfsSmtnbI1ZkXW41keTNnDWNq3j85BxOSWHogmughP14l5UL+MTQL9BO+eRLfP/NPwFmcfoF/wcVfYaHGquT+/0KBENk3a44PxecgfV7+/Ml+vicgPadeW8OkpR0cGmK17/H2YvRi9vwDW8eLzGswJXYo4+6k2wJNVUctPBhTMPjg6npCtk4DEr5AwvnH4Ah7ZpT9y3f1ytdIqPm6HndNYzz44Pa7h5NmOn0aHvUqwASyTJtTjtnHG4SyKvh2fXcYLcj41GtUay5tsGGTvqa8dC6P9EIrKpyua5mKnQj2QszfomIUgB/P+ZG/yVsuonrQC50cglBwqL3F0ZBv1UBO9LR3BJ0c7CTYdDRLifoCyRtrnV/wSB67FKEJd/KKVx+gHA9qMh96vXycPy8nCpKGapLh/LDvWNth8oSKlS44f8wsVLuZo+r+hQCO8TqEuSMvMySfDBzCwPQzSsufmGVvjrqgS8vk4vUrW2lsMnzSnfN+JkMRhDS8/oBvmRMvesbTbHZxiYhn9guUWt7enO8lQ==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(7416014)(376014)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	No4XNhKNEWNNkGvcnS1UZN8EhNDmElkiiyNxDa+B6VlrTAr2QZoghIEErxLI9ulrS3h8mWEEpMm7T0OCdshhGXdSGQzEs9PVUMSFq4x474lTLvFO0Cj3AXNDB8Q4kkqb39yyVMpIknGgXmAOKq1z0sRcA0quhW324XGnm6LrvX/1TmhK6jsjKUP0S54OJOZSQ+Kbdf6OoCrtzWfqN2KxRQxUU75TDyQYL3TF1tNy1vC9Q3HwRoApnFhW9aRAxb2gyIrPOMXYmKpenc4Z5qQug7bSXDAhWQyRK4fKU21I3fS1+ojU+UEhbGt+p58rNpEyDB6rvxZB3vYTAk13EeqcNIkHYIw/SCHh9FMNai9sXnnYtdRS+i7I27uD9mbVQB+a/YzfzpY2JQQ2Ru+SaHS/xKNg7SJ7VINrY6XJthDPQZRlE0jjpX5I/B+PF0a6ygij
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 10:14:17.1793
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11fe6919-d6c6-472d-7539-08de9ec594b3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00005FFE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9489

On Mon, 13 Apr 2026 15:52:28 +0900
"Alexandre Courbot" <acourbot@nvidia.com> wrote:

> Hi Zhi,
>=20
> On Fri Apr 10, 2026 at 3:52 AM JST, Zhi Wang wrote:
> <snip>
> > +/// An extended PCI capability that implements [`Io`].
> > +///
> > +/// # Examples
> > +///
> > +/// ```no_run
> > +/// use kernel::pci::{
> > +///     self,
> > +///     ExtSriovCapability, //
> > +/// };
> > +/// use kernel::io::Io;
> > +///
> > +/// fn probe_sriov(pdev: &pci::Device<kernel::device::Core>) ->
> > Result<(), kernel::error::Error> { +///     let config =3D
> > pdev.config_space_extended()?; +///     let sriov =3D
> > ExtSriovCapability::find(&config)?; +///
> > +///     let total_vfs =3D kernel::io_read!(&sriov, .total_vfs);
> > +///     let vf_offset =3D kernel::io_read!(&sriov, .vf_offset);
> > +///     let bar0 =3D kernel::io_read!(&sriov, .vf_bar[0]);
> > +///     kernel::io_write!(&sriov, .num_vfs, 4u16);
> > +///     let bar0_64 =3D sriov.read_vf_bar64(0)?;
> > +///
> > +///     Ok(())
> > +/// }
> > +/// ```
> > +///
> > +/// # Invariants
> > +///
> > +/// `ptr` is within the device's extended configuration space at a
> > valid +/// capability. For sized `T`, the region is at least
> > `size_of::<T>()` bytes. +pub struct ExtCapability<'a, T: ?Sized +
> > KnownSize =3D Region<0>> {
> > +    config: &'a ConfigSpace<'a, Extended>,
> > +    ptr: *mut T,
> > +} =20
>=20
> This strongly looks like this is reinventing `io::View`. :) Even the
> internals look similar. Can you check whether `io::View` can replace
> this type? This would remove all the macro business and impl blocks
> and simplify this patch considerably.
>=20

Thanks for catching this. This should be updated with Gary's patches
posted in the mailing list. Will address this in V4.

> > +
> > +impl<T: ?Sized + KnownSize> Io for ExtCapability<'_, T> {
> > +    type Type =3D T;
> > +
> > +    #[inline]
> > +    fn as_ptr(&self) -> *mut T {
> > +        self.ptr
> > +    }
> > +}
> > +
> > +macro_rules! impl_ext_cap_io_capable {
> > +    ($ty:ty) =3D> {
> > +        impl<T: ?Sized + KnownSize> IoCapable<$ty> for
> > ExtCapability<'_, T> {
> > +            #[inline]
> > +            unsafe fn io_read(&self, address: *mut $ty) -> $ty {
> > +                // SAFETY: The caller guarantees `address` is
> > within bounds of
> > +                // this capability, which is within the config
> > space.
> > +                unsafe { self.config.io_read(address) }
> > +            }
> > +
> > +            #[inline]
> > +            unsafe fn io_write(&self, value: $ty, address: *mut
> > $ty) {
> > +                // SAFETY: The caller guarantees `address` is
> > within bounds of
> > +                // this capability, which is within the config
> > space.
> > +                unsafe { self.config.io_write(value, address) }
> > +            }
> > +        }
> > +    };
> > +}
> > +
> > +impl_ext_cap_io_capable!(u8);
> > +impl_ext_cap_io_capable!(u16);
> > +impl_ext_cap_io_capable!(u32);
> > +
> > +impl<'a> ExtCapability<'a> {
> > +    /// Base offset of this capability in configuration space.
> > +    #[inline]
> > +    pub fn offset(&self) -> usize {
> > +        self.ptr.addr()
> > +    }
> > +
> > +    /// Size of this capability region in bytes.
> > +    #[inline]
> > +    pub fn size(&self) -> usize {
> > +        KnownSize::size(self.ptr)
> > +    }
> > +
> > +    /// Cast to a typed capability, checking that the region is
> > large enough.
> > +    pub fn cast_sized<U>(self) -> Result<ExtCapability<'a, U>> { =20
>=20
> This allows for any cast, including invalid ones, as long as `U` fits.
> While not unsafe, this is still incorrect - I don't see any reason to
> make this public, which could be a way to mitigate this.
>=20

Agreed. With the io::View rework above, cast_sized is gone. The size
check can be done internally in find_sriov().

> > +        if self.size() < core::mem::size_of::<U>() {
> > +            return Err(EINVAL);
> > +        }
> > +
> > +        // INVARIANT: `self` already satisfies the invariant (ptr
> > is within extended config
> > +        // space at a valid capability), and the size check above
> > guarantees the region is at
> > +        // least `size_of::<U>()` bytes.
> > +        Ok(ExtCapability {
> > +            config: self.config,
> > +            ptr: core::ptr::without_provenance_mut(self.offset()),
> > +        })
> > +    }
> > +}
> > +
> > +impl ConfigSpace<'_, Extended> {
> > +    /// Finds an extended capability by ID, returning an untyped
> > [`ExtCapability`].
> > +    pub fn find_ext_capability(&self, cap: ExtCapId) ->
> > Result<ExtCapability<'_>> {
> > +        let offset =3D usize::from(
> > +            // SAFETY: `self.pdev` is valid by the type invariant
> > of `ConfigSpace`.
> > +            unsafe {
> > +
> > bindings::pci_find_ext_capability(self.pdev.as_raw(),
> > i32::from(cap.as_raw()))
> > +            },
> > +        );
> > +
> > +        if offset =3D=3D 0 {
> > +            return Err(ENODEV);
> > +        }
> > +
> > +        Ok(self.make_ext_capability(offset))
> > +    }
> > +
> > +    /// Finds the next extended capability with `cap` after
> > `start`.
> > +    pub fn find_next_ext_capability(&self, start: u16, cap:
> > ExtCapId) -> Result<ExtCapability<'_>> { =20
>=20
> This `start` offset can be anything and potentially lead to invalid
> results being returned (I don't know what the C binding does, but
> assuming the worst for safety).
>=20
> Listing capabilities should be done through an iterator as it provides
> all their benefits to users. I understand we also want a `find` API to
> look for a specific capability and that an iterator is not needed for
> this, but if we end up providing a way to list them, it should be
> through an iterator.
>=20
> In any case, this method seems to be unused, so you can safely drop it
> for now.
>=20

Dropped in v4.

> > +        let offset =3D usize::from(
> > +            // SAFETY: `self.pdev` is valid by the type invariant
> > of `ConfigSpace`.
> > +            unsafe {
> > +                bindings::pci_find_next_ext_capability(
> > +                    self.pdev.as_raw(),
> > +                    start,
> > +                    i32::from(cap.as_raw()),
> > +                )
> > +            },
> > +        );
> > +
> > +        if offset =3D=3D 0 {
> > +            return Err(ENODEV);
> > +        }
> > +
> > +        Ok(self.make_ext_capability(offset))
> > +    }
> > +
> > +    fn make_ext_capability(&self, offset: usize) ->
> > ExtCapability<'_> {
> > +        let size =3D self.calculate_ext_cap_size(offset);
> > +
> > +        let ptr =3D core::ptr::slice_from_raw_parts_mut::<u8>(
> > +            core::ptr::without_provenance_mut(offset),
> > +            size,
> > +            // CAST: `Region<0>` is a DST like `[u8]`, so this
> > pointer cast preserves metadata.
> > +        ) as *mut Region<0>;
> > +
> > +        // INVARIANT: `offset` was returned by
> > `pci_find_ext_capability` / =20
>=20
> This method cannot make assumptions about the origin of its arguments
> without being `unsafe`, as its correct behavior depends on the
> goodwill of the caller. Given that we will drop
> `find_next_ext_capability`, the code can be rolled into
> `find_ext_capability` which is now the only user.
>=20

Will inline it into find_ext_capability in v4.

> > +        // `pci_find_next_ext_capability`, which guarantees it
> > points to a valid capability
> > +        // within the extended configuration space. `size` is
> > bounded by the next capability
> > +        // offset or the end of the configuration space.
> > +        ExtCapability { config: self, ptr }
> > +    }
> > +
> > +    fn calculate_ext_cap_size(&self, offset: usize) -> usize { =20
>=20
> This method lacks documentation.
>=20
> > +        let header =3D self.try_read32(offset).unwrap_or(0);
> > +        // SAFETY: Pure bit manipulation, no preconditions.
> > +        // CAST: The next-cap pointer is a 12-bit field (max
> > 0xFFC), always fits in `usize`.
> > +        let next_ptr =3D unsafe { bindings::pci_ext_cap_next(header)
> > } as usize; +
> > +        if next_ptr > offset {
> > +            next_ptr - offset
> > +        } else {
> > +            KnownSize::size(self.as_ptr()) - offset
> > +        }
> > +    }
> > +}
> > +
> > +/// SR-IOV register layout per PCIe spec (64 bytes starting at cap
> > offset). +#[repr(C)]
> > +pub struct ExtSriovRegs {
> > +    /// Extended capability header.
> > +    pub header: u32,
> > +    /// SR-IOV capabilities.
> > +    pub cap: u32,
> > +    /// SR-IOV control.
> > +    pub ctrl: u16,
> > +    /// SR-IOV status.
> > +    pub status: u16,
> > +    /// Initial VFs.
> > +    pub initial_vfs: u16,
> > +    /// Total VFs.
> > +    pub total_vfs: u16,
> > +    /// Number of VFs.
> > +    pub num_vfs: u16,
> > +    /// Function dependency link.
> > +    pub func_dep_link: u16,
> > +    /// First VF offset.
> > +    pub vf_offset: u16,
> > +    /// VF stride.
> > +    pub vf_stride: u16,
> > +    _reserved: u16,
> > +    /// VF device ID.
> > +    pub vf_device_id: u16,
> > +    /// Supported page sizes.
> > +    pub supported_page_sizes: u32,
> > +    /// System page size.
> > +    pub system_page_size: u32,
> > +    /// VF BARs (BAR0=E2=80=93BAR5).
> > +    pub vf_bar: [u32; 6],
> > +    /// VF migration state array offset.
> > +    pub migration_state: u32,
> > +}
> > +
> > +/// SR-IOV capability. See [`ExtCapability`] for usage.
> > +pub type ExtSriovCapability<'a> =3D ExtCapability<'a, ExtSriovRegs>;
> > +
> > +impl ExtCapability<'_, ExtSriovRegs> {
> > +    /// Find the SR-IOV capability, or `ENODEV` if not present.
> > +    #[inline]
> > +    pub fn find<'a>(
> > +        config: &'a ConfigSpace<'_, Extended>,
> > +    ) -> Result<ExtCapability<'a, ExtSriovRegs>> {
> > +        config.find_ext_capability(ExtCapId::Sriov)?.cast_sized()
> > +    } =20
>=20
> This method looks like it belongs to `ConfigSpace`, and should be
> generic. Something like
>=20
>   impl<'a> ConfigSpace<'a, Extended> {
>     pub fn find_ext_capability::<C: ExtCapability>(&self)=20
>       -> Result<io::View<...>> =20
>   }
>=20
> If we use `io::View` to return capabilities, we can recycle the
> `ExtCapability` name for a trait that provides the information
> required for `find_ext_capability` to work properly, like the
> associated constant for the capability ID. In this patch, it would be
> implemented on `ExtSriovRegs`, providing the projection of the view
> through `C`.
>=20
> This also opens the way for a `find_capability` method that handles
> normal capabilities and is available to both variants of
> `ConfigSpace`. I am not saying this needs to be done in this patch
> though.
>

I've moved find to ConfigSpace::find_sriov() for now. I agree the
trait-based generics direction makes sense, but with only SR-IOV as a
user today I'd prefer to defer that to a follow-up when we have a
second capability type. :)

> > +
> > +    /// Reads a 64-bit VF BAR from two consecutive 32-bit slots.
> > +    #[inline]
> > +    pub fn read_vf_bar64(&self, bar_index: usize) -> Result<u64> {
> > +        if bar_index >=3D 5 { =20
>=20
> Why is this value hardcoded? If this is correct, let's make it a
> constant with an informative name (and possibly a comment justifying
> its value).
>=20

Sure. I changed it to use PCI_SRIOV_NUM_BARS.=20

> > +            return Err(EINVAL);
> > +        }
> > +        let low =3D crate::io_read!(self, .vf_bar[bar_index]?);
> > +        let high =3D crate::io_read!(self, .vf_bar[bar_index + 1]?);
> > =20
>=20
> Don't we want to check whether the bar in question is actually a
> 64-bit BAR?
>=20
> I wonder whether this also doesn't call for an iterator-based solution
> returning an enum with the properly-sized BAR.

Good point. I was assuming that the driver actually know its
devcie support 64-bit bar or not. Do you prefer that we can have an
iterator-based solution at this time? I think it makes the code looks
nicer though. :)

Z.

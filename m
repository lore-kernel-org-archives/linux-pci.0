Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012056.outbound.protection.outlook.com [52.101.53.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6192B299A81;
	Thu,  5 Mar 2026 21:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772745310; cv=fail; b=ZYEYBPJ4h5zulLkpstxvZJVCuO9pTyvcXRfXretSZdt5HmWgFttvzYGNqJXkEWhZyHWXZ648mVR0h73/busmGN5IK7GtD3HTSbsDjnPXOuyW3jhMdPTc6VDcEH9LWcIkSTgbHuYOdB0oG/kPW4FiCOrftw0FD0tCRy7JEIRWx7Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772745310; c=relaxed/simple;
	bh=dHOmPsiEw+c+HGawsX7EgnbwoiZjCE/KPZbANVq9058=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ofk8xPaBqCju1mawHRRIiR9BJ8EAZpVgH3+lNwlDDlPOv1h6X6lhzfk7RNwrcCGF5OIaBtB+audCA89triNdFzDyNytZzZ+QlBw0C2D9uphtGH13SkOfytpYYeHXR7x+1JNTMHYFN48b+I8dxMU1jFcV5O0Cty71aiCOTfLK69g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aDSruTqY; arc=fail smtp.client-ip=52.101.53.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aDSruTqY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p31enUuzUJID2160Hsb6ld4ZXO5PNRTy3zF7s0UIVZtXueZUcpmAQa2h8CHltCQFptnUXKvKzRjmeyArupOhAAa+sp3uqatiHl/lY5cutC1VWH6+hzhPtloJq0YJyfhZv0omUoOKXFIooCd/VbdPWUAHtdCbmJfq04GJ7L/i7XQVvUJ2DZldelBDb74eUqZC6EDdgE91ckTaMUeh9eqpBS/DCbk07n7cexIapB09T76y4bYNYfLV36Sy9z7gOBUG3K3yzkBNL1t+XDw0DiEywvG7nl3DVjBG8RWemeiByAqAWNhR8PvjcvvdwqCwNyd3V5TnTWU3kemDzp6UVeFAJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gTiI7i13E7BACgBXoaNutsHJRmSC+q5648/fq25f1Y4=;
 b=Hnl6mPlscWYvyQgLDMl3w5xnBy+p7CG1J3aWS4zQYU+uX03gP3JgSA8rNDErU4gQtXC0Wjq4MIJrs+ZICEMlkVWeUrt9ulvHCP+6eq7gYKYG87DtPp/R2720UIQMwD4Gc2E4l296QTcNlfGcxarFAO9pHou+SST4T31AhJck81JK1ldc4AXWb76D6+pptffvzItMm5wMU5mIhCfSoVtkEl38wasL4yL/S16YajDE55cHnx6tVpzfOZ0/NWehnxzBtvp3izfh+OJFgGHaaudfoAF9EebdWhUHSPAWORgRtFq/riJBsUrmMmz+tGXIbWxiYydSMzfYLs3Wzw/qXqsgxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gTiI7i13E7BACgBXoaNutsHJRmSC+q5648/fq25f1Y4=;
 b=aDSruTqY2Hoo0fIWllPT0ZOTHnnCQlUmJ6B9Ooe9WdEvRKeklfDsVN+VIXBLNIjW8VsIi9w+j61BNeJ3rzB5yRWm/1nYR+9k0kddlkRzthGX5GArEblkov1vvvCJ5xn/vVomYf+bcBYu4vtBPVJwBUTbMJc8y1yYV0RHyvkkEl+8LXsxNqEoyfpycxnt35l96vzLTH7dPF4q/R1Ne985oTVN3E8cJvRwQH90CazuMQwAbrSFNeVs2I001lW2PVKRpkZiJhC3kl3c6UOS0DeXqc4LWA5wJ8JcW6avEc3uV3liePRzIiCC8bqFNtjtDT6o0auhrc48UWsb1xMIA0cJ0w==
Received: from DS7PR03CA0289.namprd03.prod.outlook.com (2603:10b6:5:3ad::24)
 by CH8PR12MB9742.namprd12.prod.outlook.com (2603:10b6:610:27a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Thu, 5 Mar
 2026 21:14:57 +0000
Received: from DS3PEPF0000C380.namprd04.prod.outlook.com
 (2603:10b6:5:3ad:cafe::5) by DS7PR03CA0289.outlook.office365.com
 (2603:10b6:5:3ad::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.22 via Frontend Transport; Thu,
 5 Mar 2026 21:14:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS3PEPF0000C380.mail.protection.outlook.com (10.167.23.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Thu, 5 Mar 2026 21:14:56 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 5 Mar
 2026 13:14:46 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 5 Mar 2026 13:14:45 -0800
Received: from inno-dell (10.127.8.14) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 5 Mar 2026 13:14:35 -0800
Date: Thu, 5 Mar 2026 23:14:32 +0200
From: Zhi Wang <zhiw@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>
CC: <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <jgg@nvidia.com>, <gary@garyguo.net>,
	<joelagnelf@nvidia.com>, <aliceryhl@google.com>, <bhelgaas@google.com>,
	<kwilczynski@kernel.org>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
	<boqun.feng@gmail.com>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
	<a.hindborg@kernel.org>, <tmgross@umich.edu>, <markus.probst@posteo.de>,
	<helgaas@kernel.org>, <cjia@nvidia.com>, <smitra@nvidia.com>,
	<ankita@nvidia.com>, <aniketa@nvidia.com>, <kwankhede@nvidia.com>,
	<targupta@nvidia.com>, <acourbot@nvidia.com>, <jhubbard@nvidia.com>,
	<zhiwang@kernel.org>, <daniel.almeida@collabora.com>
Subject: Re: [PATCH v3 1/1] rust: introduce abstractions for fwctl
Message-ID: <20260305231432.5a054b6d@inno-dell>
In-Reply-To: <DGUZ4A6W87JU.36R2KDR7YGSEX@kernel.org>
References: <20260217204909.211793-1-zhiw@nvidia.com>
	<20260217204909.211793-2-zhiw@nvidia.com>
	<DGUZ4A6W87JU.36R2KDR7YGSEX@kernel.org>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C380:EE_|CH8PR12MB9742:EE_
X-MS-Office365-Filtering-Correlation-Id: 71a025c4-58d7-4884-9938-08de7afc407f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|376014|7416014|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info:
	P5wSK9+HMalEtlmGfYJlB69FVjyB1DGDGlwNDpi1VsFXJPgf7vmvxtxOHdTHuil71hjM7GZwGRZIygdyC5bRE1mywbUvGCFQme9ffUfDDS2cXlH1rVjCGSYmt0wpl6hry/yECtFxSdvK1z1xVwyoIsSsw8PiU0KZpdIIaiAaz+L8BfeKUUcEPmSKoC0PaC8b2fRZ7kRnjeuChnGdQobqVHsVUoB38DT6Aufv61EzVAu2rBY6ghJv9OKtAbKVTHD1B1UFWvaQHkEDVwGOTSymp7zvxVgp3Sd8EoybAFOuh0ZYXW9XGMQtIlra25QHbhiFZ/JTVtBf6lSp1ggjr/qrQngJKaJx2lleY1aBTXeoMnNKKjstM5Q47kOaGHoDeQFe/m81VFP/w0se8P5j0eHPOZhobJNeEecalsd3TeRvLne+CFG+WdOzJbiNydo0QJk/21aF6dh4CS9EvQHiFzxZ/hR++6dnTHNd3ujQCyYOpmpvq8OzBcVwB7z0HkYPCPsr3riDfuzAUJQBTqHVUQ95ynACU3mAnQm92EVZCGxdnD5yBcJVE+ItDRaR2n2ADXEN4QfKU2/IvPzqP08y61eIUIJWsg0lX68y0x88aiE53ZoV7ZuX2lL1MX8pE3wOvKgod/Bz2HK9IdYa978BGx2kAXyrPfXcfAQO9wiEzZFA2Zo/t3AtAGaMV8ua6B9dAQES19qZOR5kKGTGyq39PrYJ2c/u7c5yjqULYnrH/YdoVEho7k9C+oDeYfHiK6NwhG25ZtgTPWlfIwbTCzKB68Gtpg==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(7416014)(13003099007)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5LDPvyusRAOMuiZewCM7Eatxi6Ng8plFHVgRmei77n+BJtBD/vPCP6ofxdKaYIZE41WiYQcCIgkMzXbw+u53VCcf42hhSiGW4go2OLKu6/8NTEfoGmFMptV2sQv6SJuswOsGl3E6ZWApc4V156l90MN7qDauP/Pa3gMuTU4igBLC8U8iX3bW4Z52Wd2iruQes3/RrzSFr7VizCpu1d/646Ol6qLg5kYfKUV6Nhc0OE5qqzNvVNH8E23Y0XHmgIsyEdINCB0DpBFjWfReIOSlAv5OZ+eLzvQqSrl/VMiZPEUrHYHfn1+3crixCg5n4DWm0I+KANidmvwU2TSd6gwpGTaqgU+EWu1PEtuFPCNwOsFn2Yx+1A30SmfCZGc+GxWMplfK3ROjmfjK2m2khqC0xWw03Oh/MrxjrQR/EjVP1tKEaGvnsevwK7DILfH42pxR
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 21:14:56.4225
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71a025c4-58d7-4884-9938-08de7afc407f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C380.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9742

On Thu, 05 Mar 2026 17:02:38 +0100
"Danilo Krummrich" <dakr@kernel.org> wrote:

> On Tue Feb 17, 2026 at 9:49 PM CET, Zhi Wang wrote:
> > diff --git a/drivers/fwctl/Kconfig b/drivers/fwctl/Kconfig
> > index b5583b12a011..ce42c0f52d6d 100644
> > --- a/drivers/fwctl/Kconfig
> > +++ b/drivers/fwctl/Kconfig
> > @@ -9,6 +9,18 @@ menuconfig FWCTL
> >  	  fit neatly into an existing subsystem.
> > =20
> >  if FWCTL
> > +
> > +config RUST_FWCTL_ABSTRACTIONS
> > +	bool "Rust fwctl abstractions"
> > +	depends on RUST
> > +	help
> > +	  This enables the Rust abstractions for the fwctl device
> > firmware
> > +	  access framework. It provides safe wrappers around
> > struct fwctl_device
> > +	  and struct fwctl_uctx, allowing Rust drivers to register
> > fwctl devices
> > +	  and implement their control and RPC logic in safe Rust.
> > +
> > +	  If unsure, say N. =20
>=20
> We currently have to ensure that CONFIG_FWCTL=3Dy.
>=20

Hi:

Thanks so much for the review efforts.

I just post the nova-core fwctl driver series. You are right. I
encounter a problem when CONFIG_FWCTL=3Dy. Should I move that one within
this series? [1]

[1] https://lore.kernel.org/all/20260305190936.398590-2-zhiw@nvidia.com/

> I also gave this a quick shot and I see the following warnings:
>=20
> 	warning: `as` casting between raw pointers without changing

Will double check with the CLIPPY and rustdoc fmt.

> > +/// Trait implemented by each Rust driver that integrates with the
> > fwctl subsystem. +///
> > +/// The implementing type **is** the per-FD user context: one
> > instance is +/// created for each `open()` call and dropped when
> > the FD is closed. +///
> > +/// Each implementation corresponds to a specific device type and
> > provides the +/// vtable used by the core `fwctl` layer to manage
> > per-FD user contexts and +/// handle RPC requests.
> > +pub trait Operations: Sized { =20
>=20
> I think this needs Send.
>=20

Nice catch, I think we also need Sync.

> Besides that, are all those callbacks strictly serialized, i.e. can
> we really give out a mutable reference?
>=20

I think open()/close() are serialized by the VFS. But info() and
fw_rpc() are not so I don't give a mutable reference for them. If the
driver wanna modify the members, it should use Mutex<>.

> > +    /// Driver data embedded alongside the `fwctl_device`
> > allocation.
> > +    type DeviceData;
> > +
> > +    /// fwctl device type identifier.
> > +    const DEVICE_TYPE: DeviceType;
> > +
> > +    /// Called when a new user context is opened.
> > +    ///
> > +    /// Returns a [`PinInit`] initializer for `Self`. The instance
> > is dropped
> > +    /// automatically when the FD is closed (after
> > [`close`](Self::close)).
> > +    fn open(device: &Device<Self>) -> Result<impl PinInit<Self,
> > Error>, Error>; =20
>=20

Will fix all the followings in the next re-spin.

> This should just return impl PinInit<Self, Error>, the outer result is
> redundant.
>=20
> > +    /// Called when the user context is closed.
> > +    ///
> > +    /// The driver may perform additional cleanup here that
> > requires access
> > +    /// to the owning [`Device`]. `Self` is dropped automatically
> > after this
> > +    /// returns.
> > +    fn close(_this: Pin<&mut Self>, _device: &Device<Self>) {} =20
>=20
> This can just be self: Pin<&mut Self>.
>=20
> > +
> > +    /// Return device information to userspace.
> > +    ///
> > +    /// The default implementation returns no device-specific data.
> > +    fn info(_this: &Self, _device: &Device<Self>) ->
> > Result<KVec<u8>, Error> { =20
>=20
> self: Pin<&Self>, Result<KVec<u8>>
>=20
> > +        Ok(KVec::new())
> > +    }
> > +
> > +    /// Handle a userspace RPC request.
> > +    fn fw_rpc(
> > +        this: &Self, =20
>=20
> Same here.
>=20
> > +        device: &Device<Self>,
> > +        scope: RpcScope,
> > +        rpc_in: &mut [u8],
> > +    ) -> Result<FwRpcResponse, Error>;
> > +}
> > +
> > +/// A fwctl device with embedded driver data.
> > +///
> > +/// `#[repr(C)]` with the `fwctl_device` at offset 0, matching the
> > C +/// `fwctl_alloc_device()` layout convention.
> > +///
> > +/// # Invariants
> > +///
> > +/// The `fwctl_device` portion is initialised by the C subsystem
> > during +/// [`Device::new()`]. The `data` field is initialised
> > in-place via +/// [`PinInit`] before the struct is exposed. =20
>=20
> Where is this invariant used, do we actually need it?
>=20
> > +#[repr(C)]
> > +pub struct Device<T: Operations> {
> > +    dev: Opaque<bindings::fwctl_device>,
> > +    data: T::DeviceData,
> > +}
> > +
> > +impl<T: Operations> Device<T> {
> > +    /// Allocate a new fwctl device with embedded driver data.
> > +    ///
> > +    /// Returns an [`ARef`] that can be passed to
> > [`Registration::new()`]
> > +    /// to make the device visible to userspace. The caller may
> > inspect or
> > +    /// configure the device between allocation and registration.
> > +    pub fn new(
> > +        parent: &device::Device<device::Bound>,
> > +        data: impl PinInit<T::DeviceData, Error>,
> > +    ) -> Result<ARef<Self>> {
> > +        let ops =3D
> > core::ptr::from_ref::<bindings::fwctl_ops>(&VTable::<T>::VTABLE).cast_m=
ut();
> > =20
>=20
> The turbofish shouldn't be needed.
>=20
> > +
> > +        // SAFETY: `_fwctl_alloc_device` allocates `size` bytes
> > via kzalloc and
> > +        // initialises the embedded fwctl_device. `ops` points to
> > a static vtable
> > +        // that outlives the device. `parent` is bound.
> > +        let raw =3D unsafe {
> > +            bindings::_fwctl_alloc_device(parent.as_raw(), ops,
> > core::mem::size_of::<Self>())
> > +        }; =20
>=20
> I suggest to use Kmalloc::aligned_layout() in such a case, please
> also see [1].
>=20
> [1] https://lore.kernel.org/r/20250731154919.4132-3-dakr@kernel.org
>=20
> > +        if raw.is_null() {
> > +            return Err(ENOMEM);
> > +        } =20
>=20
> If you replace this with NonNull::new().ok_or(ENOMEM)? you already
> have the NonNull instance for the subsequent call to ARef::from_raw()
> below.
>=20
> > +        // CAST: Device<T> is repr(C) with fwctl_device at offset
> > 0.
> > +        let this =3D raw as *mut Self;
> > +
> > +        // SAFETY: `data` field is within the kzalloc'd
> > allocation, uninitialised.
> > +        let data_ptr =3D unsafe {
> > core::ptr::addr_of_mut!((*this).data) }; =20
>=20
> Prefer &raw mut.
>=20
> > +        unsafe { data.__pinned_init(data_ptr) }.inspect_err(|_| {
> > +            // SAFETY: Init failed; release the allocation.
> > +            unsafe { bindings::fwctl_put(raw) };
> > +        })?;
> > +
> > +        // SAFETY: `_fwctl_alloc_device` returned a valid pointer
> > with refcount 1
> > +        // and DeviceData is fully initialised.
> > +        Ok(unsafe { ARef::from_raw(NonNull::new_unchecked(raw as
> > *mut Self)) })
> > +    }
> > +
> > +    /// Returns a reference to the embedded driver data.
> > +    pub fn data(&self) -> &T::DeviceData {
> > +        &self.data
> > +    }
> > +
> > +    fn as_raw(&self) -> *mut bindings::fwctl_device {
> > +        self.dev.get()
> > +    }
> > +
> > +    /// # Safety
> > +    ///
> > +    /// `ptr` must point to a valid `fwctl_device` embedded in a
> > `Device<T>`.
> > +    unsafe fn from_raw<'a>(ptr: *mut bindings::fwctl_device) ->
> > &'a Self {
> > +        unsafe { &*ptr.cast() }
> > +    }
> > +
> > +    /// Returns the parent device.
> > +    ///
> > +    /// The parent is guaranteed to be bound while any fwctl
> > callback is
> > +    /// running (ensured by the `registration_lock` read lock on
> > the ioctl
> > +    /// path and by `Devres` on the teardown path).
> > +    pub fn parent(&self) -> &device::Device<device::Bound> {
> > +        // SAFETY: fwctl_device always has a valid parent.
> > +        let parent_dev =3D unsafe { (*self.as_raw()).dev.parent };
> > +        let dev: &device::Device =3D unsafe {
> > device::Device::from_raw(parent_dev) };
> > +        // SAFETY: The parent is guaranteed to be bound while
> > fwctl ops are active.
> > +        unsafe { dev.as_bound() }
> > +    }
> > +}
> > +
> > +impl<T: Operations> AsRef<device::Device> for Device<T> {
> > +    fn as_ref(&self) -> &device::Device {
> > +        // SAFETY: self.as_raw() is a valid fwctl_device.
> > +        let dev =3D unsafe {
> > core::ptr::addr_of_mut!((*self.as_raw()).dev) }; =20
>=20
> NIT: &raw mut
>=20
> > +        // SAFETY: dev points to a valid struct device.
> > +        unsafe { device::Device::from_raw(dev) }
> > +    }
> > +}
> > +
> > +// SAFETY: `fwctl_get` increments the refcount of a valid
> > fwctl_device. +// `fwctl_put` decrements it and frees the device
> > when it reaches zero. +unsafe impl<T: Operations> AlwaysRefCounted
> > for Device<T> {
> > +    fn inc_ref(&self) {
> > +        // SAFETY: The existence of a shared reference guarantees
> > that the refcount is non-zero.
> > +        unsafe { bindings::fwctl_get(self.as_raw()) };
> > +    }
> > +
> > +    unsafe fn dec_ref(obj: NonNull<Self>) {
> > +        // SAFETY: The safety requirements guarantee that the
> > refcount is non-zero.
> > +        unsafe { bindings::fwctl_put(obj.cast().as_ptr()) };
> > +    }
> > +}
> > +
> > +/// A registered fwctl device.
> > +///
> > +/// Must live inside a [`Devres`] to guarantee that
> > [`fwctl_unregister`] runs +/// before the parent driver unbinds.
> > `Devres` prevents the `Registration` +/// from being moved to a
> > context that could outlive the parent device. +///
> > +/// On drop the device is unregistered (all user contexts are
> > closed and +/// `ops` is set to `NULL`) and the [`ARef`] is
> > released. +///
> > +/// [`fwctl_unregister`]: srctree/drivers/fwctl/main.c
> > +pub struct Registration<T: Operations> {
> > +    dev: ARef<Device<T>>,
> > +}
> > +
> > +impl<T: Operations> Registration<T> {
> > +    /// Register a previously allocated fwctl device.
> > +    pub fn new<'a>(
> > +        parent: &'a device::Device<device::Bound>,
> > +        dev: &'a Device<T>,
> > +    ) -> impl PinInit<Devres<Self>, Error> + 'a { =20
>=20
> This doesn't need PinInit anymore.
>=20
> > +        pin_init::pin_init_scope(move || {
> > +            // SAFETY: `dev` is a valid fwctl_device backed by an
> > ARef.
> > +            let ret =3D unsafe {
> > bindings::fwctl_register(dev.as_raw()) };
> > +            if ret !=3D 0 {
> > +                return Err(Error::from_errno(ret));
> > +            }
> > +
> > +            Ok(Devres::new(parent, Self { dev: dev.into() }))
> > +        })
> > +    }
> > +}
> > +
> > +impl<T: Operations> Drop for Registration<T> {
> > +    fn drop(&mut self) {
> > +        // SAFETY: `Registration` lives inside a `Devres`, which
> > guarantees
> > +        // that drop runs while the parent device is still bound.
> > +        unsafe { bindings::fwctl_unregister(self.dev.as_raw()) };
> > +        // ARef<Device<T>> is dropped after this, calling
> > fwctl_put. =20
>=20
> It doesn't really hurt, but I don't think this comment is needed.
>=20
> > +    }
> > +}
> > +
> > +// SAFETY: `Registration` can be sent between threads; the
> > underlying +// fwctl_device uses internal locking.
> > +unsafe impl<T: Operations> Send for Registration<T> {}
> > +
> > +// SAFETY: `Registration` provides no mutable access; the
> > underlying +// fwctl_device is protected by internal locking.
> > +unsafe impl<T: Operations> Sync for Registration<T> {}
> > +
> > +/// Internal per-FD user context wrapping `struct fwctl_uctx` and
> > `T`. +///
> > +/// Not exposed to drivers =E2=80=94 they work with `&T` / `Pin<&mut T=
>`
> > directly. +#[repr(C)]
> > +#[pin_data]
> > +struct UserCtx<T: Operations> {
> > +    #[pin]
> > +    fwctl_uctx: Opaque<bindings::fwctl_uctx>,
> > +    #[pin]
> > +    uctx: T, =20
>=20
> I'd probably just name this data.
>=20
> > +}
> > +
> > +impl<T: Operations> UserCtx<T> {
> > +    /// # Safety
> > +    ///
> > +    /// `ptr` must point to a `fwctl_uctx` embedded in a live
> > `UserCtx<T>`.
> > +    unsafe fn from_raw<'a>(ptr: *mut bindings::fwctl_uctx) -> &'a
> > Self {
> > +        unsafe { &*container_of!(Opaque::cast_from(ptr), Self,
> > fwctl_uctx) }
> > +    }
> > +
> > +    /// # Safety
> > +    ///
> > +    /// `ptr` must point to a `fwctl_uctx` embedded in a live
> > `UserCtx<T>`.
> > +    /// The caller must ensure exclusive access to the
> > `UserCtx<T>`.
> > +    unsafe fn from_raw_mut<'a>(ptr: *mut bindings::fwctl_uctx) ->
> > &'a mut Self {
> > +        unsafe { &mut *container_of!(Opaque::cast_from(ptr), Self,
> > fwctl_uctx).cast_mut() }
> > +    }
> > +
> > +    /// Returns a reference to the fwctl [`Device`] that owns this
> > context.
> > +    fn device(&self) -> &Device<T> {
> > +        // SAFETY: fwctl_uctx.fwctl is set by the subsystem and
> > always valid.
> > +        let raw_fwctl =3D unsafe { (*self.fwctl_uctx.get()).fwctl };
> > +        // SAFETY: The fwctl_device is embedded in a Device<T>.
> > +        unsafe { Device::from_raw(raw_fwctl) }
> > +    }
> > +}
> > +
> > +/// Static vtable mapping Rust trait methods to C callbacks.
> > +pub struct VTable<T: Operations>(PhantomData<T>);
> > +
> > +impl<T: Operations> VTable<T> {
> > +    /// The fwctl operations vtable for this driver type.
> > +    pub const VTABLE: bindings::fwctl_ops =3D bindings::fwctl_ops {
> > +        device_type: T::DEVICE_TYPE as u32,
> > +        uctx_size: core::mem::size_of::<UserCtx<T>>(), =20
>=20
> We may want to use Kmalloc::aligned_layout() here as well. It should
> be possible to make this a const function.
>=20
> > +        open_uctx: Some(Self::open_uctx_callback),
> > +        close_uctx: Some(Self::close_uctx_callback),
> > +        info: Some(Self::info_callback),
> > +        fw_rpc: Some(Self::fw_rpc_callback),
> > +    };
> > +
> > +    /// # Safety
> > +    ///
> > +    /// `uctx` must be a valid `fwctl_uctx` embedded in a
> > `UserCtx<T>` with
> > +    /// sufficient allocated space for the uctx field.
> > +    unsafe extern "C" fn open_uctx_callback(uctx: *mut
> > bindings::fwctl_uctx) -> ffi::c_int {
> > +        // SAFETY: `fwctl_uctx.fwctl` is set by the subsystem
> > before calling open.
> > +        let raw_fwctl =3D unsafe { (*uctx).fwctl };
> > +        // SAFETY: `raw_fwctl` points to a valid fwctl_device
> > embedded in a Device<T>.
> > +        let device =3D unsafe { Device::<T>::from_raw(raw_fwctl) };
> > +
> > +        let initializer =3D match T::open(device) {
> > +            Ok(init) =3D> init,
> > +            Err(e) =3D> return e.to_errno(),
> > +        };
> > +
> > +        let uctx_offset =3D core::mem::offset_of!(UserCtx<T>, uctx);
> > +        // SAFETY: The C side allocated space for the entire
> > UserCtx<T>.
> > +        let uctx_ptr: *mut T =3D unsafe {
> > uctx.cast::<u8>().add(uctx_offset).cast() }; =20
>=20
> I think the following is a bit cleaner:
>=20
> 	let user_ctx =3D container_of!(fw, UserCtx<T>, fwctl_uctx);
> 	let data =3D unsafe { &raw mut (*user_ctx).uctx };
>=20
> > +
> > +        // SAFETY: uctx_ptr points to uninitialised, properly
> > aligned memory.
> > +        match unsafe { initializer.__pinned_init(uctx_ptr.cast())
> > } {
> > +            Ok(()) =3D> 0,
> > +            Err(e) =3D> e.to_errno(),
> > +        }
> > +    }
> > +
> > +    /// # Safety
> > +    ///
> > +    /// `uctx` must point to a fully initialised `UserCtx<T>`.
> > +    unsafe extern "C" fn close_uctx_callback(uctx: *mut
> > bindings::fwctl_uctx) {
> > +        // SAFETY: `fwctl_uctx.fwctl` is set by the subsystem and
> > always valid.
> > +        let device =3D unsafe { Device::<T>::from_raw((*uctx).fwctl)
> > }; +
> > +        // SAFETY: uctx is a valid pointer promised by C side. =20
>=20
> You have to justify exclusive access as well.
>=20
> > +        let ctx =3D unsafe { UserCtx::<T>::from_raw_mut(uctx) };
> > +
> > +        {
> > +            // SAFETY: driver uctx is pinned in place by the C
> > allocation.
> > +            let pinned =3D unsafe { Pin::new_unchecked(&mut
> > ctx.uctx) };
> > +            T::close(pinned, device);
> > +        }
> > +
> > +        // SAFETY: After close returns, no further callbacks will
> > access UserCtx.
> > +        // Drop T before the C side kfree's the allocation.
> > +        unsafe { core::ptr::drop_in_place(&mut ctx.uctx) };
> > +    }
> > +
> > +    /// # Safety
> > +    ///
> > +    /// `uctx` must point to a fully initialised `UserCtx<T>`.
> > +    /// `length` must be a valid pointer.
> > +    unsafe extern "C" fn info_callback(
> > +        uctx: *mut bindings::fwctl_uctx,
> > +        length: *mut usize,
> > +    ) -> *mut ffi::c_void {
> > +        // SAFETY: uctx is a valid pointer promised by C side.
> > +        let ctx =3D unsafe { UserCtx::<T>::from_raw(uctx) };
> > +        let device =3D ctx.device();
> > +
> > +        match T::info(&ctx.uctx, device) {
> > +            Ok(kvec) if kvec.is_empty() =3D> {
> > +                // SAFETY: `length` is a valid out-parameter.
> > +                unsafe { *length =3D 0 };
> > +                // Return NULL for empty data; kfree(NULL) is safe.
> > +                core::ptr::null_mut()
> > +            }
> > +            Ok(kvec) =3D> {
> > +                let (ptr, len, _cap) =3D kvec.into_raw_parts();
> > +                // SAFETY: `length` is a valid out-parameter.
> > +                unsafe { *length =3D len };
> > +                ptr.cast::<ffi::c_void>()
> > +            }
> > +            Err(e) =3D> Error::to_ptr(e),
> > +        }
> > +    }
> > +
> > +    /// # Safety
> > +    ///
> > +    /// `uctx` must point to a fully initialised `UserCtx<T>`.
> > +    /// `rpc_in` must be valid for `in_len` bytes. `out_len` must
> > be valid.
> > +    unsafe extern "C" fn fw_rpc_callback(
> > +        uctx: *mut bindings::fwctl_uctx,
> > +        scope: u32,
> > +        rpc_in: *mut ffi::c_void,
> > +        in_len: usize,
> > +        out_len: *mut usize,
> > +    ) -> *mut ffi::c_void {
> > +        let scope =3D match RpcScope::try_from(scope) {
> > +            Ok(s) =3D> s,
> > +            Err(e) =3D> return Error::to_ptr(e),
> > +        };
> > +
> > +        // SAFETY: `uctx` is fully initialised; shared access is
> > sufficient.
> > +        let ctx =3D unsafe { UserCtx::<T>::from_raw(uctx) };
> > +        let device =3D ctx.device();
> > +
> > +        // SAFETY: `rpc_in` / `in_len` are guaranteed valid by the
> > fwctl subsystem. =20
>=20
> There are more safety requirements for a mutable slice, please
> justify them as well.
>=20
> > +        let rpc_in_slice: &mut [u8] =3D
> > +            unsafe {
> > slice::from_raw_parts_mut(rpc_in.cast::<u8>(), in_len) }; +
> > +        match T::fw_rpc(&ctx.uctx, device, scope, rpc_in_slice) {
> > +            Ok(FwRpcResponse::InPlace(len)) =3D> {
> > +                // SAFETY: `out_len` is valid.
> > +                unsafe { *out_len =3D len };
> > +                rpc_in
> > +            }
> > +            Ok(FwRpcResponse::NewBuffer(kvec)) =3D> {
> > +                let (ptr, len, _cap) =3D kvec.into_raw_parts();
> > +                // SAFETY: `out_len` is valid.
> > +                unsafe { *out_len =3D len };
> > +                ptr.cast::<ffi::c_void>()
> > +            }
> > +            Err(e) =3D> Error::to_ptr(e),
> > +        }
> > +    }
> > +} =20


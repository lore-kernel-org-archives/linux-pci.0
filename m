Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010016.outbound.protection.outlook.com [52.101.85.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D883F99E3;
	Sun,  4 Oct 2026 06:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791094052; cv=fail; b=lwlBJxHpcfSfg1zj7vY7xaX9gNF0CdWzFGXi9/DLWHYmaboyc5jHX7MpcY6NzCXglzfvmgu3UG4yq+7t1gZuXcL1USOhJkerInPtLk8xNlEE0BUTrdRmWzD/YjJqbjvOmceckW9/lDbsrZ/MusL7if8h6bFQRqy6i7JDbkJaxr0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791094052; c=relaxed/simple;
	bh=V3hIvfC9pDRR3A9USSLcd83OkAuQM485ajLwIV7pt80=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nIcACJ9ETyltqma3tTAnErbZRu/GUVj6ysiBA4FBmIS3kcUtBodA09RRKDFUbaJ+cO4hNZNxYpEIoW2GTZx1QSRMv+PmWBebnxByClM5hFSrJ8B0IefywJIbtygahS5SVvdDg5faBiK6FoZQeFOy7Aya+RcvbhT3rZRd6EJEPM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JxGZZvwd; arc=fail smtp.client-ip=52.101.85.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JxGZZvwd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mINPm42JSiOxuDc76AgoBPnPwnZgmaaIFkipphe9y9xpEdF+0cdRjK233/ZW/Un9d7SPSW2aUr/M7k/0LyP+fPy8AemB8i8erlchGliSeWdBXiX46QmhvIVtP3x3gWQ8PTg4+Ngd85y10cwWuB1JLq6GDdd0Z9/ixy5jTkyFZjRXtXwVNd3XGZ28OgvmnI5GdRcRMTrVuJaiTu0vOMbGTJt7loCvPdSX7j/DZSOCTkM7L+A/PfyOx+irK54cI3WLhFOId6anYFgsR9amOTZl4BmqrRGlHAjXoUqBbaRBhTdacX2H9qnL7SqOhpUZmLWBljhYRrLCA4hMZDrJWFPAwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O7WwI66qa1gjJPr/Eb02AlmIcUtlZAJ3LqcMunHFrBY=;
 b=OascesSaWdN2StTN8KnpKrWgmz7pg0+atLlt/ymbDAEcn3zyMzw8NWCYsEpwLRoqCXuQ05KD/Gz93O23wATin0C2XQHqlYvAHayriItJD+SV9iddbNxrQWbfd5l5lW89CPJ30iVTpblVWVUYLV7wJs50YpSHD580IqNebg+kOnrX4E4ikBnSknWIuauj7QoFBJeo5x1BtO7MQUKi5mPzwV5JlPGRxUxcfevTb3KQnaZycakAoIcPKnrAiIecDhyq7/SSw6S1WNKtOw2M/ZH72WGR1ZL4kY+4wRYcS6DYtvmUpZ074FzxALFMWKP1+zV+fSN4SqvOR2tA0yhFXP8iCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O7WwI66qa1gjJPr/Eb02AlmIcUtlZAJ3LqcMunHFrBY=;
 b=JxGZZvwdNA7IcX91keu2M/w55C7bZNEx1jnkA6v//w/oKy+WzoKhHyo8iAfH/HI+UjhGKdgRqnlkaRTR/BmsGoxhLQjTBp9K6otNOe7KxZnXxQQCqwY4Jw/zLv/TlSDRdvWJL5Fv4RUTf50iha80/Z/uTyy1CTzJ2giSczCf2OWHEb3en8YDe843ND131psWDyjN1oH9XOXaxfagOA8UkJmmLs5hKM+8EkqBZ1A9wIJb9Rob8R4yEHUjGo0PiFGFC/Kwiv4S4pD2Bet4vKmbbQ5b5cn+ipVBFeiSrpLw7ebMGw7JnWcjRTUjAJ8amVR3Wimzg2ivekfXwCOGHCgL1Q==
Received: from CH2PR12CA0008.namprd12.prod.outlook.com (2603:10b6:610:57::18)
 by DM6PR12MB4233.namprd12.prod.outlook.com (2603:10b6:5:210::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Sun, 4 Oct
 2026 06:07:25 +0000
Received: from CH2PEPF000166C1.namprd04.prod.outlook.com
 (2603:10b6:610:57:cafe::40) by CH2PR12CA0008.outlook.office365.com
 (2603:10b6:610:57::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Sun, 4
 Oct 2026 06:07:25 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.232) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH2PEPF000166C1.mail.protection.outlook.com (10.167.252.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Sun, 4 Oct 2026 06:07:24 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Sat, 3 Oct
 2026 23:07:20 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sat, 3 Oct 2026 23:07:20 -0700
Received: from inno-x280 (10.127.8.13) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Sat, 3 Oct 2026 23:07:13 -0700
Date: Sun, 4 Oct 2026 08:07:11 +0200
From: Zhi Wang <zhiw@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>
CC: <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <aliceryhl@google.com>,
	<bhelgaas@google.com>, <kwilczynski@kernel.org>, <ojeda@kernel.org>,
	<boqun@kernel.org>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
	<lossin@kernel.org>, <a.hindborg@kernel.org>, <tmgross@umich.edu>,
	<markus.probst@posteo.de>, <cjia@nvidia.com>, <smitra@nvidia.com>,
	<ankita@nvidia.com>, <aniketa@nvidia.com>, <kwankhede@nvidia.com>,
	<targupta@nvidia.com>, <kjaju@nvidia.com>, <alkumar@nvidia.com>,
	<acourbot@nvidia.com>, <jhubbard@nvidia.com>, <zhiwang@kernel.org>,
	<jgg@nvidia.com>, <alex@shazbot.org>, Peter Colberg <peter@colberg.org>
Subject: Re: [PATCH v3 07/10] rust: pci: add typed SR-IOV PF registration
 data
Message-ID: <20261004080711.011f0ce6@inno-x280>
In-Reply-To: <DLSPDU29TZ0B.1O7PTVMMYQSHS@kernel.org>
References: <cover.1790705494.git.zhiw@nvidia.com>
	<9fa15232fb869a562973454d9d21a5287b3da080.1790759932.git.zhiw@nvidia.com>
	<DLSPDU29TZ0B.1O7PTVMMYQSHS@kernel.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.52; x86_64-pc-linux-gnu)
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
X-MS-TrafficTypeDiagnostic: CH2PEPF000166C1:EE_|DM6PR12MB4233:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f2453c6-faf2-4d99-0257-08df21ddc2dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|376014|7416014|82310400026|23010399003|5023799004|11063799006|56012099006|4143699003|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	iLtVqEfx1Oa85snL+DNTSXYnvOvouB8PL1WpyqJk1h7ZfB5vsufVx4nUtTZriEmG1h1g2jX0vvaZgMiNNsJgzpwVFIdpYoliuU73Md9UgHHFuKf3n1MI2OrYvu5EmpBBMy7/EFyaRRT9dhdSqXNpdusvP7E+F8Fs4VDh5xUy7vWRHVgMtQkRzjqFl58phKe4eceTRgQEnN6J/JgFIq3StI2qRKyxk6Dn9XvdNSNMidrv8tKEOTQEhjKE2hrL6WzFmpgN2CYEd9gHw7kskYvZLNB5ExAT9hAZ+xOyNn7abKCxmDf38uNAOUKDb3yq/K/9w1+Ux9U4WTEXYhoE/dZgHtCv247HlOUFTTPodtWvYZisaJVNVDDu2VqlC02WESqMUPJFKtY5wfoMLAqGFDfP+U7xVCEgyY4DvEK73up6N5Qd6dMxiiln6FEogWhJOEGERyqLjMmv1YrSihr5NGd6RhtPt1cMagn9OirgEbSqQCjTouI/qf2aKCFmv3zKFMJ7MbYOsO2lV7+NYkcVeQx8vHJOy8STg26uq8mmtPaXm8TLFqHK2+DA1xy4PJj5MvjQOg+yw21BLYOGwcACZZsSvE+L9JDNgFTykkPiz82FrzpkZUnme5/hqPUOLYt2vS+Z3oB3iASTpgT8MDPLfT3S9YrCwnzrgROwVzGx1zuuVnMdN9SBwtQRIy+E2zWnCaPbe//+4qQD1RumBcgmWEf9AQ==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(376014)(7416014)(82310400026)(23010399003)(5023799004)(11063799006)(56012099006)(4143699003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	cfePem38zmqUHG7Weu/uGF/UChHAXYbI0/GlDDeDx1VMeJsQI/OwTi5C7CRIvo88RFYMMhTpED/gFiBtXGRfL2qN8LiX0/croYl66M13OD/xbidZHEW9Q/Hj5Y8NLzI1GaQNu5YCL8OgsYFaEvyzQvdd2Ur+Z3JmsBebzb1VTTUVvTiFRI1GuVqAR0d+KIeKUJLu2buJTJSQHsc1VopxzBgrAy1m2LksrLr7PHBfmalKzuwgpba/TZ+ffAV7ESsTolw26xwfFegNJJ71jxp8Qnq5kQvSjHeWWL9wji1TJJEx9k6pVJ2byf4K32PyqYJoKQ7FAXAfenFdzjSpS8QqDZdqfC1QIG7q98n/F/bj/LAYDSUCtJyc9R+62Gp+d0RKHXsnxTjjkV67HzAqg5zoi3kZDw4SX72gn70r9dMlh09DQ1Q0a+ntxafZcpw4I48e
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2026 06:07:24.9143
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f2453c6-faf2-4d99-0257-08df21ddc2dd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF000166C1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4233

On Wed, 30 Sep 2026 15:59:27 +0200
"Danilo Krummrich" <dakr@kernel.org> wrote:

> On Wed Sep 30, 2026 at 12:18 PM CEST, Zhi Wang wrote:
> > diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> > index 1599b3a613d7..8782e9b06e64 100644
> > --- a/rust/kernel/pci.rs
> > +++ b/rust/kernel/pci.rs
> > @@ -51,6 +51,8 @@
> >      Extended,
> >      Normal, //
> >  };
> > +#[cfg(CONFIG_PCI_IOV)]
> > +pub use self::iov::VfRegistration;
> >  pub use self::irq::{
> >      IrqType,
> >      IrqTypes,
> > @@ -331,6 +333,9 @@ fn probe<'bound>(
> >      /// operations to gracefully tear down the device.
> >      ///
> >      /// Otherwise, release operations for driver resources should
> > be performed in `Drop`.
> > +    ///
> > +    /// For a PF with enabled VFs, `VfRegistration` disables
> > SR-IOV when it is dropped. This
> > +    /// callback must leave resources accessed by VF drivers
> > available until then.
> 
> I don't think we need this comment, neither this callback (which I
> plan to remove anyway) nor T::Data::drop() can remove resources that
> can still be accessed by VF drivers in the first place.
> 

I see. 

> You could have something like Mutex<Option<_>> of course, but that
> would be intentional then.
> 

Got it. Will proceed in the next re-spin.

> > != 0 {
> > +                // SAFETY: This initializer runs during PF
> > probing, and no VFs are enabled.
> > +                if !unsafe {
> > (*pdev.as_raw()).vf_registration_data_rust }.is_null() {
> > +                    return Err(EBUSY);
> > +                }
> 
> Those two checks can go into the first _: block, no?
> 

Nice idea. Thanks for the suggestion.

> > +
> > +                // SAFETY: The data is initialized and pinned, the
> > slot is unoccupied, and
> > +                // no VF can access it yet. No fallible work
> > follows publication.
> > +                unsafe {
> > +                    (*pdev.as_raw()).vf_registration_data_rust =

<snip>

> > +    ///
> > +    /// The data lifetime must be hidden behind a higher-ranked
> > closure independently of the
> > +    /// reference lifetime, or `F` must be covariant in its
> > encoded lifetime.
> > +    unsafe fn vf_registration_data_pinned<F: ForLt +
> > 'static>(&self) -> Result<Pin<&F::Of<'_>>> {
> > +        if !self.is_virtfn() {
> > +            return Err(ENODEV);
> > +        }
> 
> We don't want to exclude PF drivers to access this. Have a look at
> drivers/gpu/nova-core/api.rs, it makes sense for the PF driver to
> provide a helper API around this.

Got it. I will add a helper for the PF driver to access this.

> 
> > +        // SAFETY: This bound VF uses the `physfn` union field.
> > PCI retains its PF until
> > +        // VF removal completes, and the PF keeps the registration
> > installed until then.
> > +        let ptr = unsafe {
> > +            let pf = (*self.as_raw()).__bindgen_anon_1.physfn;
> > +            (*pf).vf_registration_data_rust
> > +        };
> > +
> > +        if ptr.is_null() {
> > +            return Err(ENOENT);
> 
> Maybe ENODEV?
> 
> > +        }
> > +
> > +        // SAFETY: The registration keeps its data installed until
> > VF removal completes,
> > +        // including when probe initialization rolls back.
> > +        // `ptr` points to a `VfRegistrationData` whose first
> > field is a `TypeId`.
> > +        let type_id = unsafe { ptr.cast::<TypeId>().read() };
> > +        if type_id != TypeId::of::<F>() {
> > +            return Err(EINVAL);
> > +        }
> > +
> > +        // SAFETY: TypeId check confirms the stored type matches
> > `F`. The data
> > +        // is pinned inside the PF's driver data struct. Lifetime
> > shortening
> > +        // from the PF's binding scope to `'_` is
> > layout-compatible.
> > +        let data_ptr = unsafe {
> > +            let vfrd = ptr.cast::<VfRegistrationData<'_, F>>();
> > +            &raw const (*vfrd).data
> > +        };
> > +
> > +        // SAFETY: `data` is structurally pinned inside
> > `VfRegistrationData`.
> > +        Ok(unsafe { Pin::new_unchecked(&*data_ptr) })
> > +    }
> > +
> > +    /// Access the VF registration data through a closure with an
> > HRTB lifetime.
> > +    ///
> > +    /// `F` is the [`ForLt`](trait@ForLt) encoding of the data
> > type. Returns
> > +    /// [`ENODEV`] if this is not a VF, [`ENOENT`] if no data was
> > registered,
> > +    /// or [`EINVAL`] if `F` does not match the type registered by
> > the PF.
> > +    ///
> > +    /// The reference is borrowed from this VF, while the
> > registration data's lifetime remains
> > +    /// abstract so the closure cannot store shorter-lived
> > references in invariant data.
> > +    pub fn vf_registration_data_with<'this, F: ForLt + 'static, R>(
> > +        &'this self,
> > +        f: impl for<'a> FnOnce(Pin<&'this F::Of<'a>>) -> R,
> > +    ) -> Result<R> {
> > +        // SAFETY: The closure is higher-ranked over the data
> > lifetime, independently of `'this`.
> > +        // It cannot insert shorter-lived references, and the
> > outer borrow cannot outlive this VF.
> > +        let pinned = unsafe {
> > self.vf_registration_data_pinned::<F>()? };
> > +        Ok(f(pinned))
> > +    }
> > +
> > +    /// Returns a pinned reference to the VF registration data.
> > +    ///
> > +    /// Available only when `F` implements
> > [`CovariantForLt`](trait@crate::types::CovariantForLt),
> > +    /// guaranteeing that shortening the PF data lifetime is sound.
> > +    ///
> > +    /// For non-covariant types, use
> > [`Self::vf_registration_data_with()`].
> > +    ///
> > +    /// It returns the same errors as
> > [`Self::vf_registration_data_with()`].
> > +    pub fn vf_registration_data<F: CovariantForLt +
> > 'static>(&self) -> Result<Pin<&F::Of<'_>>> {
> > +        // SAFETY: `CovariantForLt` permits shortening the encoded
> > lifetime to this borrow.
> > +        unsafe { self.vf_registration_data_pinned::<F>() }
> > +    }
> > +}
> > -- 
> > 2.53.0
> 


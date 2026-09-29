Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012064.outbound.protection.outlook.com [52.101.48.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D730E39936D;
	Tue, 29 Sep 2026 07:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790666905; cv=fail; b=F3bQyoBsp2G/oI9pLQcpCAyf5NiuEGQHf8sJR8BTxCs7gmthuvrEW0JzcpLYWKQ/MCmX1KgMSZ2OholYyYs7hSTpCYPSQvtZdqpyTC/ep/Ijy0HqD5PNezhXqZKdSyUQ49vJ/IPqSM4Hh8nlEOMqvWQdZ6c9181pMFPGOx0BwGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790666905; c=relaxed/simple;
	bh=Kk4Ke48T1jFjhoNefRvsg/8RmpgmAhBhY9gtx+DixOI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MmbK3CVlGzmp38zJ5Q9shKp7LGwE9MxM1aFY60g3Mk6tJz4YSozXtqFx1GJji8z8VST6jEpvNGD6CtazGBhSXcUzphs8d1bevmYrwbwG/dgmXwN1Jf+MRgVLGuD8d1BnhL93Sp1xXUf1dvjqKzkqgQnTt4PI0QvnE3W/Q68skWQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mnvM4MNT; arc=fail smtp.client-ip=52.101.48.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mnvM4MNT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EQc1hOYgqFxcSbFrIDNRE6Kg7bafvAGrm6NXjsQD5fXY8KcAEvACbAgVs/8K+lVCMZ2tfn/Tmf3bk55jI7Ynm1o4TCazQ+N8fzY2TeadNR6Kug/Z2l5hBvBalcfsHGarr0NQzXG/84nJG7139+VPoCVkIiyUljB/kgppdTWz96RaXNwUrri2oM7cyDfyFBMIqt1q7AIfZZU+cjKEhzIP02mNUa+2bW2VGIi61EML9ZpY+xWkXK3kLACLf40yU17ROUuElkdo8UxdB5fpwvh3RxEsClsl0HWUCFQX6bZ1IX6FFuBOMYBfeKhpLy6ZcZGDfS+3ZYj1OiyMzShM62ZETw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aaFzVZrF0wIojgn6TAbZrjHzXXtOmNA2s+ebg/3bQ2E=;
 b=w/TmChdoH8CDkAslbXkByWFya/xkkk3qkTySSKQqealvt7XN7G2vvd/0UzU6ZZrFByduvB8Y4qoCWXuCJcPCz55k+7rWV3qxQCYzhQAI1zq1BFXIlxQ5lRybB2sR3QDuug03HFQJM899eiIR0Tq3ySrRHcVpeQ392djRglfq1kOJGa9hIJ92ROIUv3a02aPQzuXvkqaGQY5DnwGKh/cRdYlbxvwmquXvn6hR61RDqpZH3U/1FHFNVQWefk+oNQaI32CzgFmSUaPZp3MM4jVrt5Ul3yAZ1nKNSgbAPwuPp8P3rhCdIYmcszecf6dJYJJNxg+EyV1g5EmYtSSumvjfpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aaFzVZrF0wIojgn6TAbZrjHzXXtOmNA2s+ebg/3bQ2E=;
 b=mnvM4MNTQbcNU32N4oHleeNEwpG5U+a+bOCMGKPXk0PxVGH9O2stcIPOEdJJSXdYRevQ5RvOAptFC+oYO0sVsmhCx/3SjO3BV+bm37NvLuUh+4gCjPQPiwfDD5FQDzCvN5566Fxaj1bxtc3f66QHndfU1uSxSVSAe7n4voINM9skKJZWAV0H9uftH5fhhZ6Y9fh8LLFdn+E83TG7ha5W7Tk21eLlRBPr4Qey2OIVtkp3zpeTntBq7Mex6qFkWQ6fl4Hqr8XIIrZUlk6XBYa3hs+06oQl/3IciwIRx6XNnagdtD4JcgcQ1MXKt24yUd3c1i/KpRuQVAwZqe8Q1+sEEw==
Received: from PH7P221CA0069.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:328::27)
 by IA0PR12MB8326.namprd12.prod.outlook.com (2603:10b6:208:40d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Tue, 29 Sep
 2026 07:27:58 +0000
Received: from BY1PEPF00026966.namprd05.prod.outlook.com
 (2603:10b6:510:328:cafe::a) by PH7P221CA0069.outlook.office365.com
 (2603:10b6:510:328::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.23 via Frontend Transport; Tue,
 29 Sep 2026 07:27:58 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BY1PEPF00026966.mail.protection.outlook.com (10.167.244.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Tue, 29 Sep 2026 07:27:58 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 29 Sep
 2026 00:27:42 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 29 Sep
 2026 00:27:41 -0700
Received: from inno-dell (10.127.8.10) by mail.nvidia.com (10.129.68.9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Tue, 29 Sep 2026 00:27:35 -0700
Date: Tue, 29 Sep 2026 10:27:33 +0300
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
	<jgg@nvidia.com>, <alex@shazbot.org>
Subject: Re: [PATCH v2 7/8] rust: pci: add typed SR-IOV PF registration data
Message-ID: <20260929102733.3e0429b8@inno-dell>
In-Reply-To: <DLR7ZIHFTUWF.160C4AKB6W3II@kernel.org>
References: <20260924190556.1620886-1-zhiw@nvidia.com>
	<20260924190556.1620886-8-zhiw@nvidia.com>
	<DLR7ZIHFTUWF.160C4AKB6W3II@kernel.org>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF00026966:EE_|IA0PR12MB8326:EE_
X-MS-Office365-Filtering-Correlation-Id: 223f044a-7555-4e75-39c0-08df1dfb2fcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|1800799024|82310400026|7416014|23010399003|10067099003|3023799007|6133799003|22082099003|18002099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	8gl9HbnIALrpHpVFnljFd8nuFboDdapMafdYrfMy1DMKXyWkoeFqSW64VbU8iTvRYwGQwiejrT/ikoZPIVfKJ+Qf0bTKkvA0X1qJhKhs7wJtlWA06r2ugQZWuVeK3eUJHXEQCGMI37DGJ2GLQdluYyNRK8FlN/Xr5LJ9zw8Mnak+bGCS96bTvQI9xu+4rKDYDk1iJmFGWAlUSHqUdxvqbP1WaAhNBNRkGcTQIOLTgAoQvPFsCME24nDT3HWbcJL5HoWiJihkU+yisIebmUx2lA78KzPYE1tFb3FzeMVoA5BK/pABcttW1PASzcWLkXv1HiX6vQydrrSU6v5sgT2YNv1pAKZ3po/KOSWeVWeVS0BzFgJDkHK8UxzjQabuklLZyr+nIxe2WBo/jljj4ZpxGdrvqkrH7eNnxYRgroUxu3JoC4XRwbHMaq4I/IFKyiJ+4GdcBanxxl2zMN/v73lzWlGXHnQ8opTccdTzreSOHKToLRQu3Qjvh3xR5JqQKeXGymwqy5HtuMS3/+xT0ihRA70RsvpiB0S29YXb7QEYYZ36t4WcuPtP6f1yrpRlc5Esw9SO2CexBV0B2qjU/g1MYrg+FMFhw/xwgBglWFT4z/nJfPtdswFTxMd9Gh+Cp1ZZUcI+AUfHQWwniTcYBtNYuKYX6KAk0R+wD4pB0v988eg9XX42FzNXJJ8HPULOvdW+HbkJDfY1Yi13rQ/x+CTaaQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(7416014)(23010399003)(10067099003)(3023799007)(6133799003)(22082099003)(18002099003)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	2uwPnhMSuuDqpNJfhIOimuXJXxxSYcaVD7exgAwM2dHJBOiOdyyfBkx9z94Z4gXwMBYAzshiDWpOSAKY73PFQxriKVTvdXhAVtKxBi4CSt+xmL4D/QOV8VG/XROlt1k56wzWU/pSCCUEHW6edyBLFuxHIYT8FMb5TFkb9gjA5YrvsSXRFgifwhjRuGH+NnSfUJURLDgvU3XiDUQF3Jyyi5iuOrS3cNyNuJXvwQBJezEKxLOVhTKWfIcLxRnv55kMIK4rYwym8xG/U2yZNB+lgd2Tg/5yyXc18BHiNZePSiCdymmc34CQfxtROjGtQ4Jy67EEUqNNisbLwEw2jeMrfLSD2Gu3qKJHFzKz7+lOIiVJrHU2yBywNyRCfaiwe6WDc4C3kJ9NUnT+C+au90kYHaSzQx6Znm2S0fqGyMrK+PaZl0lmDd4WeG/Fp0UxeTSE
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 07:27:58.5537
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 223f044a-7555-4e75-39c0-08df1dfb2fcd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF00026966.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8326

On Mon, 28 Sep 2026 22:08:46 +0200
"Danilo Krummrich" <dakr@kernel.org> wrote:

> On Thu Sep 24, 2026 at 9:05 PM CEST, Zhi Wang wrote:

snip

> > +            if pdev.is_virtfn() {
> > +                return Err(ENODEV);
> > +            }
> > +
> > +            let published = pdev.is_physfn();
> > +            if published {  
> 
> The published thing seems unnecessary, am I missing something?
> 

I was thinking of PF drivers that only need to enable SR-IOV and do
not need to share any data or services with their VF drivers.

If we rely on VfRegistration to disable SR-IOV on PF removal, would
those drivers also need to keep a VfRegistration with () as its data,
solely for the teardown guarantee?

Z.

> > +                if pdev.num_vf() != 0 {
> > +                    return Err(EBUSY);
> > +                }
> > +
> > +                if !pdev.vf_registration_data_rust().is_null() {
> > +                    return Err(EBUSY);
> > +                }
> > +            }
> > +
> > +            Ok(try_pin_init!(Self {
> > +                pdev,
> > +                inner <- VfRegistrationData::new(data),
> > +                published,
> > +                _pin: PhantomPinned,
> > +                _: {
> > +                    if *published {
> > +                        // Store the pointer to the pinned
> > `VfRegistrationData`
> > +                        // on the PCI device so VF drivers can
> > find it.
> > +                        pdev.set_vf_registration_data_rust(
> > +
> > core::ptr::from_ref(inner.as_ref().get_ref()).cast_mut().cast(),
> > +                        );
> > +                    }
> > +                },
> > +            }))
> > +        })
> > +    }
> > +}
> > +
> > +#[pinned_drop]
> > +impl<F: ForLt + 'static> PinnedDrop for VfRegistration<'_, F> {
> > +    fn drop(self: Pin<&mut Self>) {
> > +        if !self.published {
> > +            return;
> > +        }  
> 
> How can this ever happen?
> 
> > +
> > +        // SAFETY: `pci_disable_sriov()` is safe to call on any
> > `pci_dev`; it
> > +        // is a no-op if the device has no VFs enabled. When VFs
> > are enabled,
> > +        // this blocks until all VF `remove()` callbacks complete.
> > +        unsafe { bindings::pci_disable_sriov(self.pdev.as_raw()) };
> > +
> > +        // After `pci_disable_sriov()` all VFs are gone, so no one
> > can read
> > +        // the pointer anymore.
> > +        self.pdev
> > +            .set_vf_registration_data_rust(core::ptr::null_mut());
> > +
> > +        // The pinned `inner` field is dropped automatically after
> > this returns.
> > +    }
> > +}
> > +
> > +// SAFETY: The inner data is `Send` (enforced by the bound), and
> > `&PciDevice` is `Send + Sync`. +unsafe impl<F: ForLt> Send for
> > VfRegistration<'_, F> where for<'a> F::Of<'a>: Send {} +
> > +// SAFETY: The inner data is `Send + Sync`. `VfRegistration`
> > doesn't expose mutable access; +// VF drivers only read the data
> > through an immutable pinned reference. +unsafe impl<F: ForLt> Sync
> > for VfRegistration<'_, F> where for<'a> F::Of<'a>: Send + Sync {} +
> > +impl<Ctx: device::DeviceContext> PciDevice<Ctx> {
> > +    /// Returns the raw `vf_registration_data_rust` pointer from
> > this device.
> > +    fn vf_registration_data_rust(&self) -> *mut core::ffi::c_void {
> > +        // SAFETY: `self.as_raw()` is valid.
> > +        unsafe { (*self.as_raw()).vf_registration_data_rust }
> > +    }
> > +
> > +    /// Sets the `vf_registration_data_rust` pointer on this
> > device.
> > +    fn set_vf_registration_data_rust(&self, ptr: *mut
> > core::ffi::c_void) {
> > +        // SAFETY: `self.as_raw()` is valid. PCI probe publishes
> > the data before enabling VFs;
> > +        // teardown removes all VFs before withdrawing it.
> > +        unsafe { (*self.as_raw()).vf_registration_data_rust = ptr
> > };
> > +    }
> > +}  
> 
> Those can't be safe functions, but I'd just drop those helpers anyway
> and just inline the accesses. It should only be three places after
> all.
> 
> > +
> > +impl PciDevice<device::Bound> {
> > +    /// Returns the PF for this VF, or [`ENODEV`] if this is not a
> > VF.
> > +    fn physfn(&self) -> Result<&PciDevice> {
> > +        if !self.is_virtfn() {
> > +            return Err(ENODEV);
> > +        }
> > +
> > +        // SAFETY: `self.as_raw()` is valid and this VF uses the
> > `physfn` union field.
> > +        let pf = unsafe { (*self.as_raw()).__bindgen_anon_1.physfn
> > };
> > +        if pf.is_null() {
> > +            return Err(ENODEV);
> > +        }
> > +
> > +        // SAFETY: PCI holds a PF reference until VF removal
> > completes. The returned borrow
> > +        // cannot outlive this bound VF, and `PciDevice` is a
> > transparent wrapper of `pci_dev`.
> > +        Ok(unsafe { &*pf.cast() })
> > +    }  
> 
> I don't think we need this, the PF's pci::Device<Bound> can be part
> of the data stored in the VfRegistrationData if needed.
> 
> > +
> > +    /// Internal helper: reads the `vf_registration_data_rust`
> > pointer from the
> > +    /// PF, checks the `TypeId`, and returns a pinned reference.
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// The returned borrow must be confined by a closure
> > higher-ranked independently over its
> > +    /// borrow and data lifetimes, or `F` must be covariant in its
> > encoded lifetime.
> > +    unsafe fn vf_registration_data_pinned<F: ForLt +
> > 'static>(&self) -> Result<Pin<&F::Of<'_>>> {
> > +        let pf = self.physfn()?;
> > +
> > +        let ptr = pf.vf_registration_data_rust();
> > +        if ptr.is_null() {
> > +            return Err(ENOENT);
> > +        }
> > +
> > +        // SAFETY: The Rust PCI adapter keeps the PF data
> > installed until VF removal completes.
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
> > +    /// The closure's borrow and the registration data's lifetime
> > are independent, so a borrow of
> > +    /// the context cannot be stored in invariant registration
> > data.
> > +    pub fn vf_registration_data_with<F: ForLt + 'static, R>(
> > +        &self,
> > +        f: impl for<'borrow, 'data> FnOnce(Pin<&'borrow
> > F::Of<'data>>) -> R,
> > +    ) -> Result<R> {
> > +        // SAFETY: The higher-ranked closure prevents the borrow
> > from escaping or being stored in
> > +        // invariant data by keeping its lifetime independent of
> > the erased data lifetime.
> > +        let pinned = unsafe {
> > self.vf_registration_data_pinned::<F>()? };
> > +        Ok(f(pinned))
> > +    }  
> 
> Just like in auxiliary, the signature should be:
> 
> 	pub fn registration_data_with<'this, F: ForLt + 'static, R>(
> 	    &'this self,
> 	    f: impl for<'a> FnOnce(Pin<&'this F::Of<'a>>) -> R,
> 	) -> Result<R> {
> 
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


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2D0400E15
	for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2026 19:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790277757; cv=none; b=ANpvhSQyFIpVfQHvN0sJ8SmlYJFYFWBG8YsppGdNFyx7qFTdixtZezdI+8s/dqLplmw0yMAMoG9Nd2a/5xCpEGVMGJt3vmqmTt+KsVqIbp1RLzWg9G210pRs/XJUAfb3iSibMUR9sKF1IlZOcqTeFGV5EgtRXzFtELRnQA1hmyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790277757; c=relaxed/simple;
	bh=g4Dlgx/GDmo0vBCvy017TQvCVLSaYuU/rE0TX/oqQZo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MhZNZmmdMSCNVpD1GoCFnadYwcIH3BoYg8uvsip/SYPtM+mQdAut/a4AsXbkSQtapSdndTacfqenX+HQkBz7QJ54HbaWjK1CnKNuLF10DZawx1uKtHSw5Dr+SIHL30VesR+BByCKMtv940pIjc8vCVYuM5HOyADIc4/266y6MaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M9YBbrEi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M9YBbrEi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 383371F000FF;
	Thu, 24 Sep 2026 19:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790277754;
	bh=EMcZWDcCwGHp+3I056ocmiOVueC7YxUFcO89aS3gw/M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=M9YBbrEi0+lyFQpagYXAt0SmtEqps+oD/c795NHG82W4kvjzJSazroW8cdRUpIVkS
	 3TU+lbVr719tJvaMUCh9Esh92VPLWZnOtoNI7H7hOBFBuzwfKLD0QMN+UM2HGWV3AG
	 M7aeP9NU/lqG9GmvJDiNnhUmckMJqX1h7GEOqsSrcvnGLgrMBr5rCUPQrkEcLOuo7o
	 1ejh8Wv006sJB7j3HoT+rardgpNTV9W9f2X6TEqEGrf+PFUvyBTDCnxuyE7+VrO9P5
	 cOvOSucYax5zCK+CzfW074R7BBwF8gNLG4HqEaaz+BLYROzZbAQGGCj0BCl4D4eMxV
	 yLeRNYWBumlwQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 8/8] samples: rust: add Rust SR-IOV VF driver sample
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhi Wang" <zhiw@nvidia.com>
Cc: linux-pci@vger.kernel.org, ojeda@kernel.org, gary@garyguo.net
In-Reply-To: <20260924190556.1620886-9-zhiw@nvidia.com>
References: <20260924190556.1620886-1-zhiw@nvidia.com>
 <20260924190556.1620886-9-zhiw@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 19:22:33 +0000
Message-Id: <20260924192234.383371F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] pci: resource leak of PCI enable count and bus-master state
--

commit e1308014aae1a5196bca00ac49a31f8c5fc01f1e
Author: Peter Colberg <pcolberg@redhat.com>

samples: rust: add Rust SR-IOV VF driver sample

Add a new SR-IOV driver sample that demonstrates how to enable and disable
the Single Root I/O Virtualization capability for a PCI device. The sample
implements the PF and VF as ordinary PCI drivers.

Link: https://www.qemu.org/docs/master/system/devices/igb.html

> diff --git a/samples/rust/rust_driver_sriov.rs b/samples/rust/rust_driver=
_sriov.rs
> new file mode 100644
> index 0000000000000..c5fcf4a0c62e9
> --- /dev/null
> +++ b/samples/rust/rust_driver_sriov.rs
[ ... ]
> +#[vtable]
> +impl pci::Driver for SamplePfDriver {
[ ... ]
> +    fn probe<'bound>(
> +        pdev: &'bound pci::Device<Core<'_>>,
> +        _info: Option<&'bound Self::IdInfo>,
> +    ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound {
> +        pin_init::pin_init_scope(move || {
> +            dev_info!(
> +                pdev,
> +                "Probe Rust SR-IOV PF sample (PCI ID: {}, 0x{:x}).\n",
> +                pdev.vendor_id(),
> +                pdev.device_id()
> +            );
> +
> +            pdev.enable_device_mem()?;
> +            pdev.set_master();
> +
> +            Ok(try_pin_init!(PfDriverData {

[Severity: Medium]
If the allocation for PfDriverData or VfRegistration::new() fails within the
try_pin_init! macro, the PF probe returns an error. Does this leave the PCI
device enabled and bus-mastering active?=20

The Rust PCI API pdev.enable_device_mem() binds directly to
pci_enable_device_mem(), which increments the device's enable_cnt without
using devres management, so this might leak the enable_cnt on the error pat=
h.

> +                // SAFETY:
> +                // - probe has exclusive access to this PF before SR-IOV=
 is enabled;
[ ... ]
> +#[vtable]
> +impl pci::Driver for SampleVfDriver {
[ ... ]
> +    fn probe<'bound>(
> +        pdev: &'bound pci::Device<Core<'_>>,
> +        _info: Option<&'bound Self::IdInfo>,
> +    ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound {
> +        pin_init::pin_init_scope(move || {
> +            dev_info!(
[ ... ]
> +            let pdev_bound: &'bound pci::Device<Bound> =3D pdev;
> +            let pf_api =3D pdev_bound.vf_registration_data::<PfApiForLt>=
()?;
> +
> +            pdev.enable_device_mem()?;
> +            pdev.set_master();
> +
> +            let request =3D pf_api.submit(pdev)?;

[Severity: Medium]
Similarly here in SampleVfDriver::probe, if pf_api.submit(pdev) fails, the =
VF
probe exits via the ? operator without undoing the manual enable_device_mem=
()
and set_master() calls. Can this permanently leak the enable_cnt and prevent
proper PCI resource management and power state transitions?

> +            dev_info!(pdev, "Submitted request {} through PF data.\n", r=
equest);
> +
> +            Ok(try_pin_init!(VfDriverData { pdev: pdev.into() }))
> +        })
> +    }
> +}
> +
> +#[pinned_drop]
> +impl PinnedDrop for PfDriverData<'_> {
> +    fn drop(self: Pin<&mut Self>) {
> +        dev_info!(self.pdev, "Remove Rust SR-IOV PF sample.\n");
> +    }
> +}

[Severity: Medium]
During normal driver removal, the drop logic for PfDriverData (and
VfDriverData below) fails to disable the PCI device or clear the bus master
flag. Does this mean the enable_cnt is leaked even on the successful
teardown path?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924190556.1620=
886-1-zhiw@nvidia.com?part=3D8

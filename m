Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A7C4A0136
	for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2026 10:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790765223; cv=none; b=PZhxaTvXVtDLKlDEhaoRCgPQPX5Czo+IAmk3KccnCalqekkxfIaVW3sYfWdvBKzj43rEjyKXGlcDJNfgFKY73R7vHRIlAXNt8eI/7xf7kHn51NXeDugXYhXIHwtoj2xb8ZjTSnU+8AxMP8QSuZtEdjcEAmzqitqN1XdX2qMwHuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790765223; c=relaxed/simple;
	bh=dcw7CDHVg7V6+SAHrmGW6fjpHtLtAKYUGP2GY6xDrg4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RVxVPSgIn4iIopgLSc6MtJdEqUV/AWlzomjXeNDG57DD9UrJIs4LDLVCHFg8u/Lz0cLBrcEP9vrr8OPAOVQRfovVXkyDGTL8de6PF7dxk7s6EXnH/kG7+xUh8YBw6ODqH+IF4JdiEJRYA3swvizgBsIF34IHvwSj2xN89Vd3lQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S9BW0Mpe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S9BW0Mpe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 576FF1F000FF;
	Wed, 30 Sep 2026 10:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790765212;
	bh=gewS9JL1+wZ0sSXOS/yN5c2Xy8lmlpvJnIVMu30SjE4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=S9BW0MpehdVdxdNOSzVX9S0dLV3jpfGC087C3Kavq6xV0fFyegpsKO01xSUMQ9mK1
	 F41W2360HxLFrhjUCuHEm1fnmJqtxfThCJWkAAvwa36XM6pdqfQAAL6/vRdqTPrPcs
	 Or8eLLwhORzXcGLlGXqpvaSHq/jBfCF03Egqw8Ld1d0zkyU50NEXZrCe2mLfuwgYoT
	 sLfA1Z4Hcf9GeLXQo9yenM3B8aKnaL/mM6hm/LQiROotn2GCSt/c0uVk932ikisteq
	 +nLA4udWq10y0Au3U+yYYlZCD1dKmDgUx4AsMKB/b6/Mtu5uNsV4YIqiDmu/+KkPzo
	 ObVLujlemfpzw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 10/10] samples: rust: add Rust SR-IOV VF driver
 sample
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhi Wang" <zhiw@nvidia.com>
Cc: gary@garyguo.net, ojeda@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <a50d3eba8fca1ecf094da263a749fa012a512b7f.1790759932.git.zhiw@nvidia.com>
References: <cover.1790705494.git.zhiw@nvidia.com>
 <a50d3eba8fca1ecf094da263a749fa012a512b7f.1790759932.git.zhiw@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 10:46:51 +0000
Message-Id: <20260930104652.576FF1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] pci: missing pci_disable_device() leaks enable_cnt and bus maste=
r state
--

commit 775047d7dfd13478598c3e7650d421010c6a0cef
Author: Peter Colberg <peter@colberg.org>

samples: rust: add Rust SR-IOV VF driver sample

Add a new SR-IOV driver sample that demonstrates how to enable and
disable the Single Root I/O Virtualization capability for a PCI device.

Link: https://www.qemu.org/docs/master/system/devices/igb.html

> diff --git a/samples/rust/rust_driver_sriov.rs b/samples/rust/rust_driver=
_sriov.rs
> new file mode 100644
> --- /dev/null
> +++ b/samples/rust/rust_driver_sriov.rs

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
Does this code leak the enable_cnt and leave bus mastering active if the
subsequent try_pin_init!() block fails?

pdev.enable_device_mem() calls pci_enable_device_mem(), incrementing the
enable_cnt of the PCI device, and pdev.set_master() enables bus mastering.
Returning an error without calling pci_disable_device() or
pci_clear_master() would leave the device in an unbalanced state.

> +                // SAFETY:
> +                // - probe has exclusive access to this PF before SR-IOV=
 is enabled;
> +                // - the registration is pinned in the PF driver data an=
d dropped before `pdev`;
> +                // - no other registration is created for this PF; and
> +                // - VFs are enabled only after probe by `sriov_enable`.
> +                _registration <- unsafe {
> +                    pci::VfRegistration::new(

[ ... ]

> +    fn probe<'bound>(
> +        pdev: &'bound pci::Device<Core<'_>>,
> +        _info: Option<&'bound Self::IdInfo>,
> +    ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound {
> +        pin_init::pin_init_scope(move || {
> +            dev_info!(
> +                pdev,
> +                "Probe Rust SR-IOV VF sample (PCI ID: {}, 0x{:x}).\n",
> +                pdev.vendor_id(),
> +                pdev.device_id()
> +            );
> +
> +            let pdev_bound: &'bound pci::Device<Bound> =3D pdev;
> +            let pf_api =3D pdev_bound.vf_registration_data::<PfApiForLt>=
()?;
> +
> +            pdev.enable_device_mem()?;
> +            pdev.set_master();
> +
> +            let request =3D pf_api.submit(pdev)?;

[Severity: Medium]
Similarly, does this code leak the enable_cnt and leave bus mastering
active if pf_api.submit(pdev)? fails and propagates an error?

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
> +
> +#[pinned_drop]
> +impl PinnedDrop for VfDriverData {
> +    fn drop(self: Pin<&mut Self>) {
> +        dev_info!(self.pdev, "Remove Rust SR-IOV VF sample.\n");
> +    }
> +}

[Severity: Medium]
During driver teardown, does the PinnedDrop implementation successfully
execute but fail to disable the device memory and clear the master bit?

Leaving these resources enabled leads to an unbalanced enable_cnt which
prevents correct hot-unplug behavior and resource releasing.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1790705494.gi=
t.zhiw@nvidia.com?part=3D10

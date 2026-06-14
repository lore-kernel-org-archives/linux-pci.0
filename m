Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE7770830
	for <linux-pci@vger.kernel.org>; Sun, 14 Jun 2026 16:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781453511; cv=none; b=JtQE/RuqZ7UdbYasAiLYKKu9cSp49eadLf6Tkd9lTrIvy6drGZW0qqGS1G3DszUkXQaW+hbDkmlb4YpTACqJjbL4xHvqnfLWSveXfasiJk8Z9UqVoHy8QYG5CoyISKEBVm5fdGWMQIOpbOKp1udvhuDgPQLmmpE2cIrVbPvXQLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781453511; c=relaxed/simple;
	bh=gqBU6qmd/GZYeM02QW+zrnOLSBPf1GmiOAP+Ha0wYxI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JM1/PvGd8arhF0hjxz+uZZn91BwF2VCOx0FVbtCpExyPDXD2F326K9mYGg2RUJeMexeGEfyYjOy6CmOt59p+SNgM9xRthbwhOzmK+ppZ87uYBAYi9E4+jKiM11tHXH++XAJLtO/wZXziy2UrgLllsGBSdRnjV6V/Uf1xpeFYVV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q5gN0T8p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q5gN0T8p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AF0D1F000E9;
	Sun, 14 Jun 2026 16:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781453510;
	bh=PV3SfamUMtCdW7kgjeOQzc29HhSEUNlTopt6ZqxHRbQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Q5gN0T8pV9SgJOxOG31/tzVovOAC2ejbuKzZ/Ani5vFrt+ZIhGPPbRZZLgXusugcF
	 y2VHqMUx27aQN5Gyy+/3hfIttLEWtP7uz7rDRqh7+oz5ASMoey9/PhYZMifIxpk3XA
	 LnlzNKRdmhPitTOAva5xXweeYalVqKH8yDRsPdfLGlBtDJWA1LxUzeKThRIREjYBqD
	 ckaTmlDQ/TF60CKK7YSK+YIgd182aR9hAbtRbDlAIwJGRX/TAS4/aGeJrXjBxJMmDK
	 achsFPLshJg55MZX0nwwbTULqjcqDRLwaSzJL1K0+WwUK0h3dAoCOsl+oxvkkhVsBC
	 ny6PVbrK94pGg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/4] rust: pci: add managed Device::enable_device()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Maurice Hieronymus" <mhi@mailbox.org>
Cc: linux-pci@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260614-b4-rust-pci-edu-driver-v1-2-e3f2471b595c@mailbox.org>
References: <20260614-b4-rust-pci-edu-driver-v1-2-e3f2471b595c@mailbox.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 14 Jun 2026 16:11:49 +0000
Message-Id: <20260614161150.1AF0D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Wrapping `pcim_enable_device()` in `Device::enable_device()` trigg=
ers a legacy C-side side effect that conflicts with Rust's explicit IRQ man=
agement, causing a double-free of IRQ vectors on driver unbind.
- [Low] Missing `#[inline]` annotation on a small forwarding function in an=
 abstraction crate.

Pre-existing issues:
- [High] The existing `Device::enable_device_mem()` method leaks the PCI de=
vice's enable count because it lacks a devres cleanup action or safe disabl=
e method.
--

commit 418855d3e0788282fef9f3b016a6200435cea33d
Author: Maurice Hieronymus <mhi@mailbox.org>

rust: pci: add managed Device::enable_device()

Add a managed counterpart to Device::enable_device_mem() that wraps
pcim_enable_device(). In addition to enabling the device, it registers a
pci_disable_device() cleanup that runs automatically when the device is
unbound from its driver, keeping the device's enable count balanced
across unbind/rebind cycles.

> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> index af74ddff6114d..ca04548c82c31 100644
> --- a/rust/kernel/pci.rs
> +++ b/rust/kernel/pci.rs
> @@ -452,6 +452,22 @@ pub fn enable_device_mem(&self) -> Result {
>          to_result(unsafe { bindings::pci_enable_device_mem(self.as_raw()=
) })
>      }

[Severity: High]
This isn't a bug introduced by this patch, but does the existing
Device::enable_device_mem() method leak the PCI device's enable count?

Since this method wraps the unmanaged pci_enable_device_mem(), it increments
the device's internal enable count. Safe Rust currently exposes no
disable_device_mem method, and enable_device_mem does not register a devres
cleanup action.

It appears that any driver using this safe method will permanently leak the
enable count on unbind. As noted in the commit message, this prevents the
device from transitioning back to the D0 power state on re-probe, causing
subsequent MSI allocations to fail. Should this be refactored to use devres
for automatic cleanup, or be marked unsafe?

> +
> +    /// Enable I/O and memory resources for this device, with automatic =
cleanup.
> +    ///

[ ... ]

> +    pub fn enable_device(&self) -> Result {

[Severity: Low]
Should this function have an #[inline] annotation?

The Rust guidelines for the kernel state that for abstractions, functions
that are small or forwarding to a binding call should be annotated with
#[inline]. Since Device::enable_device() simply forwards to the C binding
pcim_enable_device(), it seems to fit this criteria.

> +        // SAFETY: `self.as_raw` is guaranteed to be a pointer to a vali=
d `struct pci_dev`.
> +        to_result(unsafe { bindings::pcim_enable_device(self.as_raw()) })
> +    }

[Severity: High]
Does wrapping pcim_enable_device() here trigger a legacy C-side side effect
that conflicts with Rust's explicit IRQ management?

The function pcim_enable_device() sets pdev->is_managed =3D true. When a
driver later allocates IRQs via the Rust method Device::alloc_irq_vectors(),
the underlying C function pci_alloc_irq_vectors() detects this flag and
automatically registers a C-side devres action (pcim_msi_release) to free
the IRQ vectors.

However, the Rust method unconditionally registers its own devres action
which also drops them:

rust/kernel/pci/irq.rs:IrqVectorRegistration::drop() {
    unsafe { bindings::pci_free_irq_vectors(self.dev.as_raw()) };
}

During driver unbind, both devres actions would execute, causing
pci_free_irq_vectors() to be called twice. Could this be resolved by having
Device::enable_device() wrap the unmanaged pci_enable_device() instead, and
explicitly register a Rust-side devres cleanup handler that calls
pci_disable_device()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260614-b4-rust-pc=
i-edu-driver-v1-0-e3f2471b595c@mailbox.org?part=3D2

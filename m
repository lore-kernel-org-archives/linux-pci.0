Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F7A47ECDC
	for <linux-pci@vger.kernel.org>; Thu,  2 Jul 2026 09:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782985709; cv=none; b=FJQ3JxSauB8jfdJdFxvZd6vsH1Qh0ezp9IbehAREJu8UVGwi46/teAruxZFOMCKIYxXlh4BaPDR0kUyIqmSvyixvYYKEVFn8zwkKnbfQX0JnxqVb56EJtCcnzsz6Ein1XsFnx0TtBhBpN1iEEz9SeJ4yKQUeH+ByPS+bKw+4SRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782985709; c=relaxed/simple;
	bh=PCI4zZTMEB6VrY3KSgtiNEna7ihhhEyKlBhMtYBOwxA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hngGbHuQ+P2jF4XGSTeUAPKiA3wiWmvADzqaNMTuV+UkZECZNd85HkLOBF5pJyMRrDJNrcbOaBoQsBxG/1b7MszmEW0/Pf4aRuuwoYw58oengshImNKDkIz6mJQm2NeWngkeGi+wv3gpw/f6Vuny2AbblJipB4jmn7E0f7NwdxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vxys6CA/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vxys6CA/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7122C1F000E9;
	Thu,  2 Jul 2026 09:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782985707;
	bh=dWfRdZnjVTFhH+ZyDc3dOTwbPQ/tWnrY7lyUJDYUYM4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Vxys6CA/IE4ll6KbNvM8N2HTlE4rJDENik4NTyfnwUVgOymkkXsBRGswq8Y77CNiT
	 5WT9evf7tsgQZ1tJaIgAHsgUBsu3Ud1cxVDoKQztGw7gDY+D5LcdHzIEqbkTigQyzD
	 yE+Ooo2aTQaBjN5oHJXmCx1yEWMgjSQYgOMqhMq1uGn0yqzkmZ6UsbyYwm6+gzKBoC
	 sXNxd58BupQ7sXVYBrJ66u0yxUczeFBm0V9YishN+FqBV8CB8MeFwnztPJJcTC1eaa
	 v3htzZVGa4S/e7Oc9xHUp0BqzA0NVk75wtEQu22m6ONLlXIhNW9D01dXzT6R676Qot
	 U2a729Rtg2cZg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] rust: pci: rework device enabling API
Reply-To: sashiko-reviews@lists.linux.dev
To: "Maurice Hieronymus" <mhi@mailbox.org>
Cc: ojeda@kernel.org, "Danilo Krummrich" <dakr@kernel.org>, dri-devel@lists.freedesktop.org, "Alexandre
 Courbot" <acourbot@nvidia.com>, linux-pci@vger.kernel.org
In-Reply-To: <20260702-rust-pci-enable-device-managed-v1-1-75bc4ff2935c@mailbox.org>
References: <20260702-rust-pci-enable-device-managed-v1-1-75bc4ff2935c@mailbox.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 09:48:25 +0000
Message-Id: <20260702094826.7122C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The new `enable_device_managed` API uses `pcim_enable_device()`, w=
hich activates legacy automatic IRQ management that conflicts with Rust's `=
alloc_irq_vectors()` and violates a documented kernel API contract, leading=
 to double-free issues.
- [High] `disable_device` and `enable_device` are exposed as safe functions=
, allowing safe Rust code to unbalance the PCI device's `enable_cnt` refere=
nce count, causing soundness holes that lead to DMA-after-free.
--

commit 47e71534c620f329a7271d6914a49b70de710719
Author: Maurice Hieronymus <mhi@mailbox.org>
Subject: rust: pci: rework device enabling API

This commit replaces enable_device_mem() with enable_device_managed() to
provide automatic cleanup on unbind via pcim_enable_device(). It also
introduces an unmanaged enable_device()/disable_device() pair for paths
like runtime PM, enabling both I/O and memory resources.

Link: https://lore.kernel.org/r/20260620-b4-rust-pci-edu-driver-v2-0-6fd668=
4f2c14@mailbox.org [1]
Link: https://lore.kernel.org/rust-for-linux/DJEPMYC7J6ZG.D0ODUD4YGFCT@kern=
el.org/ [2]

[ ... ]
> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> index 5071cae6543fd..a408b34120777 100644
> --- a/rust/kernel/pci.rs
> +++ b/rust/kernel/pci.rs
> @@ -453,10 +453,30 @@ pub fn pci_class(&self) -> Class {
>  }
> =20
>  impl<'a> Device<device::Core<'a>> {
> -    /// Enable memory resources for this device.
> -    pub fn enable_device_mem(&self) -> Result {
> +    /// Enable I/O and memory resources for this device.
> +    ///
> +    /// This function is unmanaged and does not perform any cleanup when=
 the device is unbound.
> +    /// For a managed function take a look at [`Device::enable_device_ma=
naged`].
> +    #[inline]
> +    pub fn enable_device(&self) -> Result {
> +        // SAFETY: `self.as_raw` is guaranteed to be a pointer to a vali=
d `struct pci_dev`.
> +        to_result(unsafe { bindings::pci_enable_device(self.as_raw()) })
> +    }
> +
> +    /// Disable I/O and memory resources for this device.
> +    ///
> +    /// This function is the counterpart to [`Device::enable_device`].
> +    #[inline]
> +    pub fn disable_device(&self) {

[Severity: High]
Is it safe to expose these as safe Rust functions?=20

Since they directly modify the underlying PCI device's enable_cnt reference
count, safe Rust code could call them in an unbalanced way. For instance,
calling enable_device() multiple times would inflate the count.=20

During driver unload, the cleanup path would only decrement it once, leaving
bus-mastering enabled and potentially leading to DMA-after-free when memory
buffers are freed. Should these be marked unsafe, or require an RAII guard
to track the enable count?

> +        // SAFETY: `self.as_raw` is guaranteed to be a pointer to a vali=
d `struct pci_dev`.
> +        unsafe { bindings::pci_disable_device(self.as_raw()) }
> +    }
> +
> +    /// Enable I/O and memory resources for this device, with automatic =
cleanup.
> +    #[inline]
> +    pub fn enable_device_managed(&self) -> Result {
>          // SAFETY: `self.as_raw` is guaranteed to be a pointer to a vali=
d `struct pci_dev`.
> -        to_result(unsafe { bindings::pci_enable_device_mem(self.as_raw()=
) })
> +        to_result(unsafe { bindings::pcim_enable_device(self.as_raw()) })
>      }

[Severity: High]
Will wrapping pcim_enable_device() cause double-free issues with IRQ vector=
s?

This function activates legacy C devres management for the device by setting
pdev->is_managed =3D true. If a driver later calls alloc_irq_vectors(), dev=
res
will automatically register pcim_msi_release() as a cleanup action.

However, Rust's IrqVectorRegistration object also explicitly calls
pci_free_irq_vectors() on Drop. When the driver is unbound, Rust will drop
the registration (freeing the vectors), and then the devres subsystem will
execute pcim_msi_release(), attempting to free them again.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702-rust-pci-e=
nable-device-managed-v1-1-75bc4ff2935c@mailbox.org?part=3D1

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E0334574B
	for <linux-pci@vger.kernel.org>; Sat, 20 Jun 2026 09:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781946005; cv=none; b=QZxqxJjzTQylc3LHpNfwoamiIw7ae3QIZkLsGZ6lZLMexWbDM84Dn4XnClibzXOqAnPYysmyqScylmheqYDxPtMBJ9MdkrVMt5Tfve3nwbTzHC/pcB2EdykYT24FJTymbx2AHUN/JeqgS/eaBR8KIeXP0gvunO5QJiP8powiP+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781946005; c=relaxed/simple;
	bh=oO8FypGmBy4J9RooNmeeF7WkSWAHh8uum27inp1sWp0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YuXnYb+scWJtnSESvUJ6MakeWqiHxyhkoTjZuyKFFJvRpYxtzCgOneQrNQzeSuJi8ut5D8uJSQcGE+XZQpIcd52/xfc+nT8Y4a2si0hgqlPn88Ey4x2SX2D+5GhsAhCkakU7knYjF6KUkioxe3BD4BTJW2NKJWdZPjYZ4VeNwjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XfFIm9P3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XfFIm9P3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94BC81F00A3A;
	Sat, 20 Jun 2026 09:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781946003;
	bh=O5MBe6M5r4MohzQXP2rqAje+0e/QAVjEd6tguTNH+lo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XfFIm9P3LLcddj1rnIaYxPiayXX7qvj7yOr1ZqsscaGc6+JMYxfEfPYD+oqiY4gDI
	 0SX7/dVT5oy1KjsfgrjcPALczGQrQPJtDSQ9m1WFNYwADms/sK9lkWHi2wzwitOH08
	 iTUu4jfpVtRvwvI8ECjJezLyCXzwacfbIuWDqSDXaPWL5u/3ZITVuBJ9PPLaP4cdfT
	 5E0TGmPHDH8HnM/0badZurW2qz1esar351wyb0ZlsizpFao9ANs7hun64yGQnPLyvJ
	 CqFN4qpyOPXR/pNPyR2fImXX8fDY+cqMpHaAKCwtG45iyXuk9scRo3KntLKD+j6+UC
	 CKy0k9w2cglJQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/4] rust: pci: add managed Device::enable_device()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Maurice Hieronymus" <mhi@mailbox.org>
Cc: ojeda@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260620-b4-rust-pci-edu-driver-v2-2-6fd6684f2c14@mailbox.org>
References: <20260620-b4-rust-pci-edu-driver-v2-0-6fd6684f2c14@mailbox.org>
 <20260620-b4-rust-pci-edu-driver-v2-2-6fd6684f2c14@mailbox.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 20 Jun 2026 09:00:03 +0000
Message-Id: <20260620090003.94BC81F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The unmanaged `enable_device_mem()` leaks the PCI enable count on =
unbind, breaking driver reload.
--

commit 1d6899aaf8110fc74f47f044741e7a507b4dfb2e
Author: Maurice Hieronymus <mhi@mailbox.org>

rust: pci: add managed Device::enable_device()

This commit adds a managed counterpart to Device::enable_device_mem() that
wraps pcim_enable_device(). It ensures the device's enable count is
balanced across unbind/rebind cycles by automatically registering a cleanup
action. It also documents the existing enable_device_mem() as unmanaged.

> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> index 5071cae6543fd..d076a36910910 100644
> --- a/rust/kernel/pci.rs
> +++ b/rust/kernel/pci.rs
> @@ -454,11 +454,27 @@ pub fn pci_class(&self) -> Class {
> =20
>  impl<'a> Device<device::Core<'a>> {
>      /// Enable memory resources for this device.
> +    ///
> +    /// This function is unmanaged and does not perform any cleanup when=
 the device is unbound.
> +    /// For a managed function take a look at [`Device::enable_device`].
> +    #[inline]
>      pub fn enable_device_mem(&self) -> Result {

[Severity: High]
This is a pre-existing issue, but since the commit message explicitly notes
that leaking the enable count breaks driver reload and MSI allocation,
shouldn't existing callers of Device::enable_device_mem() be updated?

For example, NovaCoreDriver::probe() in drivers/gpu/nova-core/driver.rs and
SampleDriver::probe() in samples/rust/rust_driver_pci.rs still use the
unmanaged enable_device_mem().

Would it be better to either migrate these existing drivers to use the newly
introduced managed enable_device(), or provide a managed memory-only
equivalent (wrapping pcim_enable_device_mem()) for them to use?

>          // SAFETY: `self.as_raw` is guaranteed to be a pointer to a vali=
d `struct pci_dev`.
>          to_result(unsafe { bindings::pci_enable_device_mem(self.as_raw()=
) })
>      }
> =20
> +    /// Enable I/O and memory resources for this device, with automatic =
cleanup.
> +    ///
> +    /// This is the managed version of `pci_enable_device()`: it enables=
 the device's I/O and
> +    /// memory resources and registers a `pci_disable_device()` call tha=
t runs automatically
> +    /// when the device is unbound from its driver. In contrast, [`Devic=
e::enable_device_mem`]
> +    /// is unmanaged and only enables memory resources.
> +    #[inline]
> +    pub fn enable_device(&self) -> Result {
> +        // SAFETY: `self.as_raw` is guaranteed to be a pointer to a vali=
d `struct pci_dev`.
> +        to_result(unsafe { bindings::pcim_enable_device(self.as_raw()) })
> +    }
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260620-b4-rust-pc=
i-edu-driver-v2-0-6fd6684f2c14@mailbox.org?part=3D2

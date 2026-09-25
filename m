Received: from pauli.colberg.org (pauli.colberg.org [49.12.123.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACF34D794C;
	Fri, 25 Sep 2026 20:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.123.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790369522; cv=none; b=ZKGxfvlVLq3nVMk4IrMz8YS3lJxNgx+Tv2YVljO0wIm5R9/2BljpjK/35+VzHgxQKat2FLT9Vui9UukP4LAq942UxJSbGfwjUPxiunirEtD92srduzKL3beFpRTZJeUSS4qYsnNLb4NbDPE2phDzItFS5njDOQfnJdFm+Pq5Xy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790369522; c=relaxed/simple;
	bh=baqCl2g8v0IXsGc53+FhYBoccf/DGv71eWtZ3aCrydI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lL0aZruct5KRu3IwociMDkMjk+M8BWSd0jaPB6kwnZ6YhaaRPymCgVz7hR6WUaRQDUbyQBXYcpGQ9Mekvr12dEGZVGIJJS+GV8+b/TEuqDXZ1sC0WjUs/+v6ZA5x/ZUp5ByJ0hRH5wdJITcfjza3aue++t9iuf/S/OwqnvyXAKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=colberg.org; spf=pass smtp.mailfrom=colberg.org; dkim=pass (2048-bit key) header.d=colberg.org header.i=@colberg.org header.b=kA3FAD/f; arc=none smtp.client-ip=49.12.123.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=colberg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=colberg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=colberg.org header.i=@colberg.org header.b="kA3FAD/f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=colberg.org;
	s=20160215; t=1790369000;
	bh=ZHYHOZeD0Of5TFCKmJIE2CKC6f1OnIbYO8/4uhdk89E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kA3FAD/fY9BP4dg4F5tO2GzAzhs3b/lEKQuTwxMEE6Jc3xT/oAtXJMo/z+Of2brwX
	 BgjgARTOXbQl7NBHwgweTRLTaVa/nh3AMm5l3Mbk7yA1bKX03TLNToEPCDHbCWdfc1
	 s6HDRTS7YSQo+z/Py/3gWxvKSuXJgSpLqcArD2aSiFdw+3Yn4pV2ouNzal1ZRcC4Dp
	 N3g5titrhc2fuHXZhC9A4cXIRSwLriVb24eUFlEjoPl+8QpwZ9N2TXjK5ec/Dg/XzA
	 40p581h6wWCOGsvADL3FCY6GmUxjRTikhtsTWM8H//S5EbSRTnGlYpCYjwWNVqOID9
	 TOgEYmsN1VCKQ==
Received: by pauli.colberg.org (Postfix) id E4147483A083;
	Fri, 25 Sep 2026 16:43:19 -0400 (EDT)
Date: Fri, 25 Sep 2026 16:43:16 -0400
From: Peter Colberg <peter@colberg.org>
To: Zhi Wang <zhiw@nvidia.com>
Cc: rust-for-linux@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, dakr@kernel.org, aliceryhl@google.com,
	bhelgaas@google.com, kwilczynski@kernel.org, ojeda@kernel.org,
	boqun@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com,
	lossin@kernel.org, a.hindborg@kernel.org, tmgross@umich.edu,
	markus.probst@posteo.de, cjia@nvidia.com, smitra@nvidia.com,
	ankita@nvidia.com, aniketa@nvidia.com, kwankhede@nvidia.com,
	targupta@nvidia.com, kjaju@nvidia.com, alkumar@nvidia.com,
	acourbot@nvidia.com, jhubbard@nvidia.com, zhiwang@kernel.org,
	jgg@nvidia.com, alex@shazbot.org,
	Peter Colberg <pcolberg@redhat.com>
Subject: Re: [PATCH v2 1/8] rust: pci: add {enable,disable}_sriov(), to
 control SR-IOV capability
Message-ID: <arbc5IsuFxvtJnVj@colberg.org>
References: <20260924190556.1620886-1-zhiw@nvidia.com>
 <20260924190556.1620886-2-zhiw@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260924190556.1620886-2-zhiw@nvidia.com>

Hi Zhi,

On Thu, Sep 24, 2026 at 10:05:48PM +0300, Zhi Wang wrote:
> From: Peter Colberg <pcolberg@redhat.com>

Thank you for updating the series and apologies for the silence.

As part of the next revision, could you please update my email address
in all patches, which has changed (for kernel contributions only):

From: Peter Colberg <peter@colberg.org>

Thanks,
Peter

> 
> Add methods to enable and disable the Single Root I/O Virtualization
> (SR-IOV) capability for a PCI device. The wrapped C methods take care
> of validating whether the device is a Physical Function (PF), whether
> SR-IOV is currently disabled (or enabled), and whether the number of
> requested VFs does not exceed the total number of supported VFs.
> 
> Synchronously disable SR-IOV in the Rust PCI remove callback before
> unbinding the PF driver. This ensures that when a Virtual
> Function (VF) is bound to a driver, the corresponding Physical Function
> (PF) is bound to a driver, too, which is a prerequisite for exposing a
> safe Rust API that allows a VF driver to obtain the PF device for a VF
> device and subsequently access the private data of the PF driver.
> 
> Suggested-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Peter Colberg <pcolberg@redhat.com>
> Signed-off-by: Zhi Wang <zhiw@nvidia.com>
> ---
>  rust/kernel/pci.rs | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> index 3ec897709e89..e6dac919f02d 100644
> --- a/rust/kernel/pci.rs
> +++ b/rust/kernel/pci.rs
> @@ -133,6 +133,10 @@ extern "C" fn remove_callback(pdev: *mut bindings::pci_dev) {
>          // INVARIANT: `pdev` is valid for the duration of `remove_callback()`.
>          let pdev = unsafe { &*pdev.cast::<Device<device::CoreInternal<'_>>>() };
>  
> +        // Keep PF data installed until all VF remove callbacks have completed.
> +        #[cfg(CONFIG_PCI_IOV)]
> +        pdev.disable_sriov();
> +
>          // SAFETY: `remove_callback` is only ever called after a successful call to
>          // `probe_callback`, hence it's guaranteed that `Device::set_drvdata()` has been called
>          // and stored a `Pin<KBox<T::Data<'_>>>`.
> @@ -472,6 +476,38 @@ pub fn set_master(&self) {
>          // SAFETY: `self.as_raw` is guaranteed to be a pointer to a valid `struct pci_dev`.
>          unsafe { bindings::pci_set_master(self.as_raw()) };
>      }
> +
> +    /// Enable the Single Root I/O Virtualization (SR-IOV) capability for this device,
> +    /// where `nr_virtfn` is number of Virtual Functions (VF) to enable.
> +    #[cfg(CONFIG_PCI_IOV)]
> +    pub fn enable_sriov(&self, nr_virtfn: i32) -> Result {
> +        // SAFETY:
> +        // `self.as_raw` returns a valid pointer to a `struct pci_dev`.
> +        //
> +        // `pci_enable_sriov()` checks that the enable operation is valid:
> +        // - the device is a Physical Function (PF),
> +        // - SR-IOV is currently disabled, and
> +        // - `nr_virtfn` does not exceed the total number of supported VFs.
> +        //
> +        // The Core device context inherits from the Bound device context,
> +        // which guarantees that the PF device is bound to a driver.
> +        to_result(unsafe { bindings::pci_enable_sriov(self.as_raw(), nr_virtfn) })
> +    }
> +
> +    /// Disable the Single Root I/O Virtualization (SR-IOV) capability for this device.
> +    #[cfg(CONFIG_PCI_IOV)]
> +    pub fn disable_sriov(&self) {
> +        // SAFETY:
> +        // `self.as_raw` returns a valid pointer to a `struct pci_dev`.
> +        //
> +        // `pci_disable_sriov()` checks that the disable operation is valid:
> +        // - the device is a Physical Function (PF), and
> +        // - SR-IOV is currently enabled.
> +        //
> +        // The Core device context inherits from the Bound device context,
> +        // which guarantees that the PF device is bound to a driver.
> +        unsafe { bindings::pci_disable_sriov(self.as_raw()) };
> +    }
>  }
>  
>  // SAFETY: `pci::Device` is a transparent wrapper of `struct pci_dev`.
> -- 
> 2.53.0
> 

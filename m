Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDA63515DA;
	Sun, 27 Sep 2026 16:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790527034; cv=none; b=PasKwHndfVuYVz57HzZXyVNmLRhtgWAct/SPUMaieg9tEZHftiJe16R7MvP4FbtMi+aZJ2uczLvJj0vZC6KE6IvurJWDm28wQ/JugCfeD1HSywZCj1g2/c4CMEvzxowREICL6GXO9fkifWdZXT62fl1Gm81XetSmvpZ92oceXPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790527034; c=relaxed/simple;
	bh=Idg1y+ad/cTub9H1i0hV7vvZQwV2PjFne7cJxHYlTk0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=imy3x7DMQZm2rGEZyJrpiT+BtJx35onu1SPLi2+UMEDn1J8ujUPBwRT0jBWl0CvWch2tGWavTAiC3A1scKD0asp+oPJ8A4apypeUB0QuEwphQNBAXokdbLlPpIuesmLsuL9iDrlH58iSd1+lTFMshzTIcmT2Pewj6AIPVYLSfbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PyJZ4zoE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PyJZ4zoE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B92751F000FF;
	Sun, 27 Sep 2026 16:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790527033;
	bh=4iWifuhf+mlMr2hSIS2hAq64IKM9N9DicnuVT2LclEE=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To;
	b=PyJZ4zoECmSZGGcm9YSbDtHyntuqQixsxfZju9PwvjEmQ/j1VtZ945HDlvFqTNBVW
	 nUA+X5qtLmY1hMhSIt4/lsY0Cp6fTESbaluATGKg67ZvsesQdjUTNCFschu5MIgGyq
	 1X8YFCRO1QzmL+t7+qmXYCAgNpn+o8f7nWwGFSwPjNa6nUqKtmZWsHOuKu5U4Wvajs
	 NhX7PvZ4E+hVz+1CudAsr0UqoCO658Stt60RvgwPwJUsO9cQVBIpowH+NAJ+MtWwfy
	 Y9KHOaWVU1G2/AmIeaB1AHzHOcTzQTbNtympCfjgfkb1UCW1XF4SbH23C6NidJP37x
	 eugupRS2VTbnQ==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 27 Sep 2026 18:37:06 +0200
Message-Id: <DLQ8UW9ONGHB.NBCSFW530R38@kernel.org>
Subject: Re: [PATCH v2 1/8] rust: pci: add {enable,disable}_sriov(), to
 control SR-IOV capability
Cc: <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <aliceryhl@google.com>,
 <bhelgaas@google.com>, <kwilczynski@kernel.org>, <ojeda@kernel.org>,
 <boqun@kernel.org>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <markus.probst@posteo.de>, <cjia@nvidia.com>, <smitra@nvidia.com>,
 <ankita@nvidia.com>, <aniketa@nvidia.com>, <kwankhede@nvidia.com>,
 <targupta@nvidia.com>, <kjaju@nvidia.com>, <alkumar@nvidia.com>,
 <acourbot@nvidia.com>, <jhubbard@nvidia.com>, <zhiwang@kernel.org>,
 <jgg@nvidia.com>, <alex@shazbot.org>, "Peter Colberg" <pcolberg@redhat.com>
To: "Zhi Wang" <zhiw@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260924190556.1620886-1-zhiw@nvidia.com>
 <20260924190556.1620886-2-zhiw@nvidia.com>
In-Reply-To: <20260924190556.1620886-2-zhiw@nvidia.com>

On Thu Sep 24, 2026 at 9:05 PM CEST, Zhi Wang wrote:
> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> index 3ec897709e89..e6dac919f02d 100644
> --- a/rust/kernel/pci.rs
> +++ b/rust/kernel/pci.rs
> @@ -133,6 +133,10 @@ extern "C" fn remove_callback(pdev: *mut bindings::p=
ci_dev) {
>          // INVARIANT: `pdev` is valid for the duration of `remove_callba=
ck()`.
>          let pdev =3D unsafe { &*pdev.cast::<Device<device::CoreInternal<=
'_>>>() };
> =20
> +        // Keep PF data installed until all VF remove callbacks have com=
pleted.
> +        #[cfg(CONFIG_PCI_IOV)]
> +        pdev.disable_sriov();

I don't think we need this? The VfRegistration should guard against this
already.

> +
>          // SAFETY: `remove_callback` is only ever called after a success=
ful call to
>          // `probe_callback`, hence it's guaranteed that `Device::set_drv=
data()` has been called
>          // and stored a `Pin<KBox<T::Data<'_>>>`.
> @@ -472,6 +476,38 @@ pub fn set_master(&self) {
>          // SAFETY: `self.as_raw` is guaranteed to be a pointer to a vali=
d `struct pci_dev`.
>          unsafe { bindings::pci_set_master(self.as_raw()) };
>      }
> +
> +    /// Enable the Single Root I/O Virtualization (SR-IOV) capability fo=
r this device,
> +    /// where `nr_virtfn` is number of Virtual Functions (VF) to enable.
> +    #[cfg(CONFIG_PCI_IOV)]
> +    pub fn enable_sriov(&self, nr_virtfn: i32) -> Result {
> +        // SAFETY:
> +        // `self.as_raw` returns a valid pointer to a `struct pci_dev`.
> +        //
> +        // `pci_enable_sriov()` checks that the enable operation is vali=
d:
> +        // - the device is a Physical Function (PF),
> +        // - SR-IOV is currently disabled, and
> +        // - `nr_virtfn` does not exceed the total number of supported V=
Fs.
> +        //
> +        // The Core device context inherits from the Bound device contex=
t,
> +        // which guarantees that the PF device is bound to a driver.
> +        to_result(unsafe { bindings::pci_enable_sriov(self.as_raw(), nr_=
virtfn) })
> +    }
> +
> +    /// Disable the Single Root I/O Virtualization (SR-IOV) capability f=
or this device.
> +    #[cfg(CONFIG_PCI_IOV)]
> +    pub fn disable_sriov(&self) {
> +        // SAFETY:
> +        // `self.as_raw` returns a valid pointer to a `struct pci_dev`.
> +        //
> +        // `pci_disable_sriov()` checks that the disable operation is va=
lid:
> +        // - the device is a Physical Function (PF), and
> +        // - SR-IOV is currently enabled.
> +        //
> +        // The Core device context inherits from the Bound device contex=
t,
> +        // which guarantees that the PF device is bound to a driver.
> +        unsafe { bindings::pci_disable_sriov(self.as_raw()) };
> +    }
>  }

I think we do not need to expose those as functions on Device<Core>. We sho=
uld
only need to call those from the sriov_configure() callback and should othe=
rwise
be covered by the VfRegistration.

Hence, I suggest to expose those methods via a token type, which also helps=
 to
use an RAII patterns for cleanup rather than manual enable/disable calls:

Instead of a single sriov_configure() callback that covers both cases, we c=
an
have two callbacks.

	fn sriov_enable<'bound>(
	    dev: &'bound Device<device::Core<'_>>,
	    data: Pin<&'bound Self::Data<'bound>>,
	    token: SriovEnable<'_>,
	) -> Result<SriovEnabled<'_>>;

and

	fn sriov_disable<'bound>(
	    dev: &'a Device<device::Core<'_>>,
	    data: Pin<&'bound Self::Data<'bound>>,
	    token: SriovDisable<'_>,
	) -> Result;

Note the return type on sriov_enable(), which is obtained from token.enable=
().
It can serve as guard and automatically disable again of sriov_enable() fai=
ls
subsequently and returns an error. If it successfully returns SriovEnabled,=
 the
PCI core can just discard it. The structs could look like this:

	pub struct SriovEnable<'a> {
	    dev: &'a Device<device::CoreInternal<'a>>,
	    num_vfs: u32,
	}
=09
	impl<'a> SriovEnable<'a> {
	    pub fn num_vfs(&self) -> u32 {
	        self.num_vfs
	    }
=09
	    pub fn enable(self, num_vfs: u32) -> Result<SriovEnabled<'a>> {
	        let ret =3D unsafe {
	            bindings::pci_enable_sriov(self.dev.as_raw(), num_vfs)
	        };
	        to_result(ret)?;
=09
	        Ok(SriovEnabled { dev: self.dev, num_vfs })
	    }
	}

And the destructor of SriovEnabled could be:

	impl Drop for SriovEnabled<'_> {
	    fn drop(&mut self) {
	        unsafe { bindings::pci_disable_sriov(self.dev.as_raw()) }
	    }
	}

We could still have the helpers on Device<CoreInternal> so you can use them
safely in the guard types.

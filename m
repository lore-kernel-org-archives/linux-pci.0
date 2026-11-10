Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794271678;
	b=xnklyReFoPZVV3TBiZ/8qljSxqo5SWv+5PAngGTey1Wwt0e6yl31lJxsjnk42RViQ3PZ
	 RiHFJwoivnD/IhhRLiKeLsbKAbBpun89ZeSAJ0L7/eKXV4DYQQC5gvpEK1J9ake6tQhtt
	 soL+eASAGHFc+UufWy8IILSdSOlC/T4a1rRc34Ku2aqkDUZqRmS/TXlvsTMiNuy6vHTo9
	 p0u6ieH/26Mtqn6IH3PY2c/CCO7GdqZtupX98K2WaBk26xsW5KTbn/QnFy3jxr8Mxx7xs
	 Q0NNq92URmw4iEyv1luz/JJausWoZ/AEtaza3cd0CKcLJfltdRTwLgZsyxOIG/MA8sQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794271678;
	h=Received:DKIM-Signature:Mime-Version:Content-Transfer-Encoding:
	 Content-Type:Date:Message-Id:Cc:To:From:Subject:References:
	 In-Reply-To;
	bh=/v7Lk8oO1TnQwIeXyiFCZJA2BdIlQJEIsX7ukbQLF7A=;
	b=5XdFgMH5LXEVAzWJDLQMJexz4VyW5BGWZ1kE91HXEpbVSHRBtrhEHsN1JslFqLy7s7kN
	 JLzSggZQnryLYo/gBHwdv8AGLwcc1wJJko/9oe4DKOhWovHex6P66OQQeetgsSeVjycIm
	 +QuSLGCaB26Z8gph8jNv4JrHcM24PzmEri4S+dJw9GkkP0K0ZepFpkJZXJBKwecoCrfip
	 EWH+dwFro7zwE5GHzcEk6qG7rGgW8emaK4KFZ5Oy22MDHQdu0OzGXZbUaPT4J8+q9bxic
	 M2MOL+0AGFSgn8QnVShU1a4g1c0mPj+ofMvrfR8l4QnULCSn3fbeguORhdB3kPTtj9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K1rLG1ZE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3826606A31C;
	Tue, 10 Nov 2026 00:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K1rLG1ZE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F36221F008A1;
	Tue, 10 Nov 2026 00:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794271677;
	bh=/v7Lk8oO1TnQwIeXyiFCZJA2BdIlQJEIsX7ukbQLF7A=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To;
	b=K1rLG1ZEHoNXAsQPyaiZDlHextA0PwC/XEZxrHa/HQZfaSnARzEtMt8fUkpc8uR5J
	 a11J68iI74SfPU5FabImCTr/IVE3qHi+WURhy/mQ6EGyOZGDGKuXufULXGvDwdCytg
	 ASTOp1hM3YcSJi93nK4vM95LGOd5wpJcfTLZ+SNb2BXcEBU9mN49VoZdSp9WGAs0U/
	 X1wrQiKBCN1TH2wTPCdP1Y8P36nfRaBkl/SjCh4JMpGmMcxOD7GFyJ0gxHN7M/ZwOj
	 fuhhN+A6+EvK8U56KIMO1l7bEJyndnrxqApxcdytF9pWmAKlYAOf+fLh2ju20LJNCW
	 QUMYR4PaftjWw==
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 10 Nov 2026 01:47:48 +0100
Message-Id: <DMR481ABCB7M.27TE44YRCBZK2@kernel.org>
Cc: <acourbot@nvidia.com>, <kvm@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <linux-pci@vger.kernel.org>, <alex@shazbot.org>, <jgg@nvidia.com>,
 <yishaih@nvidia.com>, <skolothumtho@nvidia.com>, <kevin.tian@intel.com>,
 <airlied@gmail.com>, <simona@ffwll.ch>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <aliceryhl@google.com>, <tmgross@umich.edu>, <jhubbard@nvidia.com>,
 <ecourtney@nvidia.com>, <cjia@nvidia.com>, <smitra@nvidia.com>,
 <kjaju@nvidia.com>, <alkumar@nvidia.com>, <ankita@nvidia.com>,
 <aniketa@nvidia.com>, <kwankhede@nvidia.com>, <targupta@nvidia.com>,
 <linux-kernel@vger.kernel.org>, <zhiwang@kernel.org>, <zhiw@nvidia.com>,
 <boqun@kernel.org>, <daniel.almeida@collabora.com>, <tamird@kernel.org>,
 <work@onurozkan.dev>, <jgg@ziepe.ca>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <dri-devel@lists.freedesktop.org>,
 <peter@colberg.org>
To: "Simon Song" <xinmengs@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v2 07/12] rust: pci: add an error_detected callback
References: <20261023154009.2246627-1-xinmengs@nvidia.com>
 <20261023154009.2246627-8-xinmengs@nvidia.com>
In-Reply-To: <20261023154009.2246627-8-xinmengs@nvidia.com>

On Fri Oct 23, 2026 at 5:40 PM CEST, Simon Song wrote:
> VFIO PCI variant drivers will use error_detected() to notify userspace
> of PCI errors through vfio-pci-core.
>
> Adding error_detected() to pci::Driver lets VFIO variants reuse the PCI
> adapter's error callback dispatch. A following patch removes the
> duplicate vfio::pci::Adapter.
>
> Suggested-by: Zhi Wang <zhiw@nvidia.com>
> Signed-off-by: Simon Song <xinmengs@nvidia.com>
> ---
>  rust/kernel/pci.rs      | 33 +++++++++++++++++++++++++++++++--
>  rust/kernel/vfio/pci.rs |  6 ++++++
>  2 files changed, 37 insertions(+), 2 deletions(-)
>
> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> index 1951b3c8a5c..ddc28099087 100644
> --- a/rust/kernel/pci.rs
> +++ b/rust/kernel/pci.rs
> @@ -109,7 +109,7 @@ unsafe fn register(
>              (*pdrv.get()).remove =3D Some(Self::remove_callback);
>              (*pdrv.get()).id_table =3D T::ID_TABLE.as_ptr();
>              (*pdrv.get()).driver_managed_dma =3D T::DRIVER_MANAGED_DMA;
> -            if T::HAS_RESET_PREPARE || T::HAS_RESET_DONE {
> +            if T::HAS_ERROR_DETECTED || T::HAS_RESET_PREPARE || T::HAS_R=
ESET_DONE {
>                  (*pdrv.get()).err_handler =3D &Self::ERROR_HANDLERS;
>              }
>              #[cfg(CONFIG_PCI_IOV)]
> @@ -223,8 +223,27 @@ extern "C" fn reset_done_callback(pdev: *mut binding=
s::pci_dev) {
>          };
>      }
> =20
> +    extern "C" fn error_detected_callback(
> +        pdev: *mut bindings::pci_dev,
> +        state: bindings::pci_channel_state_t,
> +    ) -> bindings::pci_ers_result_t {
> +        // SAFETY: PCI error recovery holds the device lock.
> +        let dev =3D unsafe { &*pdev.cast::<Device<device::CoreInternal<'=
_>>>() };
> +        // SAFETY: The device lock prevents removal of installed driver =
data.
> +        unsafe {
> +            Self::callback_data_with(&raw mut (*pdev).dev, |data| {

Please use Device::drvdata_borrow().

> +                T::error_detected(dev, data, state)
> +            })
> +        }
> +        .unwrap_or(bindings::pci_ers_result_PCI_ERS_RESULT_CAN_RECOVER)
> +    }
> +
>      const ERROR_HANDLERS: bindings::pci_error_handlers =3D bindings::pci=
_error_handlers {
> -        error_detected: None,
> +        error_detected: if T::HAS_ERROR_DETECTED {
> +            Some(Self::error_detected_callback)
> +        } else {
> +            None
> +        },
>          mmio_enabled: None,
>          slot_reset: None,
>          reset_prepare: if T::HAS_RESET_PREPARE {
> @@ -461,6 +480,16 @@ fn reset_done<'bound>(dev: &Device<device::Core<'_>>=
, this: Pin<&Self::Data<'bou
>          build_error!(crate::error::VTABLE_DEFAULT_ERROR)
>      }
> =20
> +    /// Handle a PCI error and return the PCI recovery result, with the =
device lock held.
> +    fn error_detected<'bound>(

This can use #[optional].

> +        dev: &Device<device::Core<'_>>,
> +        this: Pin<&Self::Data<'bound>>,
> +        state: bindings::pci_channel_state_t,

This should be represented as a Rust type, maybe something like:

	#[derive(Clone, Copy, Debug, PartialEq, Eq)]
	pub enum ChannelState {
	    /// The I/O channel remains operational.
	    Normal,
	    /// I/O to the device is blocked.
	    Frozen,
	    /// The device has permanently failed.
	    PermanentFailure,
	}

> +    ) -> bindings::pci_ers_result_t {
> +        let _ =3D (dev, this, state);
> +        build_error!(crate::error::VTABLE_DEFAULT_ERROR)
> +    }
> +
>      /// Enables Single Root I/O Virtualization (SR-IOV) for a PF.
>      ///
>      /// Called when userspace writes a nonzero VF count to `sriov_numvfs=
`. The token carries the
> diff --git a/rust/kernel/vfio/pci.rs b/rust/kernel/vfio/pci.rs
> index db30dbce6a8..0fbc6a920dc 100644
> --- a/rust/kernel/vfio/pci.rs
> +++ b/rust/kernel/vfio/pci.rs
> @@ -1096,6 +1096,12 @@ pub fn reset_done(&self) -> Result {
>          // SAFETY: This owner keeps the pinned registration data alive.
>          unsafe { self.dev.registration_data_with(T::reset_done) }
>      }
> +
> +    /// Signal the VFIO error interrupt and return the PCI recovery resu=
lt.
> +    pub fn error_detected(&self) -> bindings::pci_ers_result_t {

Same for bindings::pci_ers_result_t.

> +        // SAFETY: This owner keeps the initialized VFIO core device ali=
ve.
> +        unsafe { bindings::vfio_pci_core_aer_err_detected(self.dev.core_=
device()) }
> +    }
>  }
> =20
>  impl<T: Operations> Drop for Registration<'_, T> {
> --=20
> 2.43.7


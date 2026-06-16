Received: from gimli.kloenk.de (gimli.kloenk.de [49.12.72.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB1D43C05C;
	Tue, 16 Jun 2026 15:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.72.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781623082; cv=none; b=Ud2r5d2bpiqlyNSpmFpIHVwvEi8BckKh9SAdRZwCUcGZX9JOLy7HUK43xaMB+3/cC3xurvXWxdxnKrL/yQaoY1GWoebIpoVGIT/dJXF8oPEb76u5JbwcIr2Pjf6IRbowA0mjmQebJGE2bCsHYz7AgSQu3aZ9DbYIiw6jaLLQywI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781623082; c=relaxed/simple;
	bh=DisUz3XIyZTl2EMC1uJewOLYWwucQvgVGjQ7xBm47os=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LCQd/uyjMeVgi9wm2VrLwBoOBrM4gurFi3nviEzRhN4190XVZgcjWHLCLUUqQtGQIXhv2T6tRBqKmV1sDfGyKWUVF9EtOzYOCAvlxa2mEoP95Mw5HVq5EYJ8tTSOEBP6HOvHGjAdmPMyTTwfrSGv6OiBVEC3gYiHesColhxLLDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kloenk.dev; spf=pass smtp.mailfrom=kloenk.dev; dkim=pass (1024-bit key) header.d=kloenk.dev header.i=@kloenk.dev header.b=XcMKfEMd; arc=none smtp.client-ip=49.12.72.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kloenk.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kloenk.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kloenk.dev header.i=@kloenk.dev header.b="XcMKfEMd"
From: Fiona Behrens <me@kloenk.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kloenk.dev; s=mail;
	t=1781622500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gXXdM10231/qy+pBqCYwYBV52urE6a8n8HWmeoocXg0=;
	b=XcMKfEMdLOhIqWuX7EYubU3YPR1V+eYjZac7FihyTe7klHoulhwatFWHzkH8Va/7O5EKHA
	H1SlTjLu+7de32/CRCFIeuoyPiBfi5RAS19y0c+pHsXQ+LfosPvzvVbn05FOB/Zo6zaZzd
	Jg9vyVHuGTj3bmXcJ/kqJVqvzSODCDU=
To: Maurice Hieronymus <mhi@mailbox.org>
Cc: Danilo Krummrich <dakr@kernel.org>,  Bjorn Helgaas
 <bhelgaas@google.com>,  Krzysztof =?utf-8?Q?Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>,
  Miguel Ojeda <ojeda@kernel.org>,  Boqun Feng <boqun@kernel.org>,  Gary
 Guo <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,
  Benno Lossin <lossin@kernel.org>,  Andreas Hindborg
 <a.hindborg@kernel.org>,  Alice Ryhl <aliceryhl@google.com>,  Trevor Gross
 <tmgross@umich.edu>,  Daniel Almeida <daniel.almeida@collabora.com>,
  Tamir Duberstein <tamird@kernel.org>,  Alexandre Courbot
 <acourbot@nvidia.com>,  Onur =?utf-8?Q?=C3=96zkan?= <work@onurozkan.dev>,
  linux-pci@vger.kernel.org,  rust-for-linux@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] rust: pci: add managed Device::enable_device()
In-Reply-To: <20260614-b4-rust-pci-edu-driver-v1-2-e3f2471b595c@mailbox.org>
	(Maurice Hieronymus's message of "Sun, 14 Jun 2026 17:59:46 +0200")
References: <20260614-b4-rust-pci-edu-driver-v1-0-e3f2471b595c@mailbox.org>
	<20260614-b4-rust-pci-edu-driver-v1-2-e3f2471b595c@mailbox.org>
Date: Tue, 16 Jun 2026 15:08:18 +0000
Message-ID: <8733ymbk0t.fsf@kloenk.dev>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Maurice Hieronymus <mhi@mailbox.org> writes:

> Add a managed counterpart to Device::enable_device_mem() that wraps
> pcim_enable_device(). In addition to enabling the device, it registers a
> pci_disable_device() cleanup that runs automatically when the device is
> unbound from its driver, keeping the device's enable count balanced
> across unbind/rebind cycles.
>
> The existing enable_device_mem() wraps the unmanaged
> pci_enable_device_mem() and has no disable counterpart, so the enable
> count is leaked on unbind. On the next probe pci_enable_device_flags()
> sees a non-zero enable count and returns early, skipping the power-state
> transition back to D0. For a device without a PCI power management
> capability the power state cannot be re-read from hardware and stays
> PCI_UNKNOWN, which makes __pci_enable_msi_range() reject the subsequent
> MSI allocation with -EINVAL.

I wonder if this is then also a good commit to further document this
behaviour in `enable_device_mem`, so that consumers are not only finding
the other variant and overlook this refcounting.

>
> Signed-off-by: Maurice Hieronymus <mhi@mailbox.org>

Do favour the `#[inline]`, but for both version

Reviewed-by: Fiona Behrens <me@kloenk.dev>

> ---
>  rust/kernel/pci.rs | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> index af74ddff6114..ca04548c82c3 100644
> --- a/rust/kernel/pci.rs
> +++ b/rust/kernel/pci.rs
> @@ -452,6 +452,22 @@ pub fn enable_device_mem(&self) -> Result {
>          to_result(unsafe { bindings::pci_enable_device_mem(self.as_raw()) })
>      }
>  
> +    /// Enable I/O and memory resources for this device, with automatic cleanup.
> +    ///
> +    /// This is the managed version of `pci_enable_device()`: it enables the device's I/O and
> +    /// memory resources and registers a `pci_disable_device()` call that runs automatically
> +    /// when the device is unbound from its driver. In contrast, [`Device::enable_device_mem`]
> +    /// is unmanaged and only enables memory resources.
> +    ///
> +    /// The automatic cleanup keeps the device's enable count balanced across driver
> +    /// unbind/rebind cycles. With an unbalanced (leaked) enable count, a re-probe skips the
> +    /// power-state transition back to `D0`, which makes subsequent MSI allocation fail with
> +    /// `EINVAL`.
> +    pub fn enable_device(&self) -> Result {
> +        // SAFETY: `self.as_raw` is guaranteed to be a pointer to a valid `struct pci_dev`.
> +        to_result(unsafe { bindings::pcim_enable_device(self.as_raw()) })
> +    }
> +
>      /// Enable bus-mastering for this device.
>      #[inline]
>      pub fn set_master(&self) {

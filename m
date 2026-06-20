Received: from mail-244106.protonmail.ch (mail-244106.protonmail.ch [109.224.244.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1B1342173;
	Sat, 20 Jun 2026 09:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781949250; cv=none; b=k0fKKnArKTw7Z93Aa14KgTotKvXcPlpbMbBs032V4QUWFRijOLQkoNdG6Z1OFMVFmH139SwMrl/qCbSGTJyyoB5kOgsV6JoyzmJFQwsuEHvshjVGIC6zjmHvSCStHXokryE4oDb6IfrR6GF08xkndmNMv/5dg0GQbdQ5AD0ek+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781949250; c=relaxed/simple;
	bh=S1Yk1RKcx99ZYDTfGzKBDCZLgxl3y4+wT6KE2GgVEvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EXjhTDEzBEnfhefUR9GW7bezVZhSHMCN4EcQGqOElluroR8M4N79xCTHcbJZr+Cj+Kbkid6KmaP5DlI5rrahTvM6L862wjLQ6RyDnf7lnsZ1Nwxp0nSKthg5zOzatSx/QPhTUam4ODbtFPFflUepVufqplu+q+RYiw3dtHA84aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=kAPJAHIu; arc=none smtp.client-ip=109.224.244.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="kAPJAHIu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=protonmail; t=1781949247; x=1782208447;
	bh=HhMhzTTdG0bq+IWYn9DgAeFO+tTJcpZXFm0kMCHL9sw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=kAPJAHIuCeBdE6T4PJ/Fjb5k2o9/E/sw+758xjEShNh+DQln8RsJEQKcfE2/h9QY8
	 CdD8AvNcA+F40uz9yw/gkLG53gtmmC6Vva6gJ7jVj1yKpNnDYSdfePYk95gGiM4een
	 JW/mmNkCRMEFBAlu8Seq1BnZ0iSjpxYHRSp3q5RrhCdGCoKTi8qhz/TrIWj9XbXzWD
	 JxTizOGNtMeWJxWgdH0KrfS8GF3xFtdEapHAARhsSwBSY2JyG+GjTq8135DNl96hua
	 +pr3M7x+5OJwmnrSfZ+07NnO7dodyOvrkX0GHKcbtm67QL5ITUDja9uvsxh7TbTaod
	 XF63IEgV8D+fg==
X-Pm-Submission-Id: 4gj8tf6dxLz2ScPh
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: Maurice Hieronymus <mhi@mailbox.org>
Cc: Danilo Krummrich <dakr@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Tamir Duberstein <tamird@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Lyude Paul <lyude@redhat.com>,
	linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Fiona Behrens <me@kloenk.dev>
Subject: Re: [PATCH v2 2/4] rust: pci: add managed Device::enable_device()
Date: Sat, 20 Jun 2026 12:54:00 +0300
Message-ID: <20260620095401.11939-1-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260620-b4-rust-pci-edu-driver-v2-2-6fd6684f2c14@mailbox.org>
References: <20260620-b4-rust-pci-edu-driver-v2-0-6fd6684f2c14@mailbox.org> <20260620-b4-rust-pci-edu-driver-v2-2-6fd6684f2c14@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 20 Jun 2026 10:45:46 +0200=0D
Maurice Hieronymus <mhi@mailbox.org> wrote:=0D
=0D
> Add a managed counterpart to Device::enable_device_mem() that wraps=0D
> pcim_enable_device(). In addition to enabling the device, it registers a=
=0D
> pci_disable_device() cleanup that runs automatically when the device is=0D
> unbound from its driver, keeping the device's enable count balanced=0D
> across unbind/rebind cycles.=0D
> =0D
> The existing enable_device_mem() wraps the unmanaged=0D
> pci_enable_device_mem() and has no disable counterpart, so the enable=0D
> count is leaked on unbind. On the next probe pci_enable_device_flags()=0D
> sees a non-zero enable count and returns early, skipping the power-state=
=0D
> transition back to D0. For a device without a PCI power management=0D
> capability the power state cannot be re-read from hardware and stays=0D
> PCI_UNKNOWN, which makes __pci_enable_msi_range() reject the subsequent=0D
> MSI allocation with -EINVAL.=0D
> =0D
> Furthermore, make `enable_device_mem` inline and add a reference to=0D
> `enable_device` in the docs.=0D
> =0D
> Reviewed-by: Fiona Behrens <me@kloenk.dev>=0D
> Signed-off-by: Maurice Hieronymus <mhi@mailbox.org>=0D
> ---=0D
>  rust/kernel/pci.rs | 16 ++++++++++++++++=0D
>  1 file changed, 16 insertions(+)=0D
> =0D
> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs=0D
> index 5071cae6543f..d076a3691091 100644=0D
> --- a/rust/kernel/pci.rs=0D
> +++ b/rust/kernel/pci.rs=0D
> @@ -454,11 +454,27 @@ pub fn pci_class(&self) -> Class {=0D
>  =0D
>  impl<'a> Device<device::Core<'a>> {=0D
>      /// Enable memory resources for this device.=0D
> +    ///=0D
> +    /// This function is unmanaged and does not perform any cleanup when=
 the device is unbound.=0D
> +    /// For a managed function take a look at [`Device::enable_device`].=
=0D
> +    #[inline]=0D
>      pub fn enable_device_mem(&self) -> Result {=0D
>          // SAFETY: `self.as_raw` is guaranteed to be a pointer to a vali=
d `struct pci_dev`.=0D
>          to_result(unsafe { bindings::pci_enable_device_mem(self.as_raw()=
) })=0D
>      }=0D
>  =0D
> +    /// Enable I/O and memory resources for this device, with automatic =
cleanup.=0D
> +    ///=0D
> +    /// This is the managed version of `pci_enable_device()`: it enables=
 the device's I/O and=0D
> +    /// memory resources and registers a `pci_disable_device()` call tha=
t runs automatically=0D
> +    /// when the device is unbound from its driver. In contrast, [`Devic=
e::enable_device_mem`]=0D
> +    /// is unmanaged and only enables memory resources.=0D
> +    #[inline]=0D
> +    pub fn enable_device(&self) -> Result {=0D
> +        // SAFETY: `self.as_raw` is guaranteed to be a pointer to a vali=
d `struct pci_dev`.=0D
> +        to_result(unsafe { bindings::pcim_enable_device(self.as_raw()) }=
)=0D
> +    }=0D
> +=0D
=0D
How about adding `_managed` and `_unmanaged` suffixes to the function names=
?=0D
=0D
- Onur=0D
=0D
>      /// Enable bus-mastering for this device.=0D
>      #[inline]=0D
>      pub fn set_master(&self) {=0D
> =0D
> -- =0D
> 2.51.2=0D
> =0D

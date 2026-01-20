Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3BA36AB7E;
	Tue, 20 Jan 2026 18:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768935394; cv=none; b=PgDWD8udBgbshsq3W9Ij55LFOBBgKD6HtDIeUmbEZGsAzK64UUBsRhA11fJADzo+55qPTQct1hHy9pUHmqGM+Zj3fo49uLfUvTD/0VxZ/YOmaIR0cNYIODM3pOXFQtTDF2ZzW2u9UskWZ9hMyKwihiSKSkHiwq4qhicMguB4qwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768935394; c=relaxed/simple;
	bh=lHPeenipo+JjDaxaE0lcp57qJlGdlmz17mZc67T7DuM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=Hs+nn+C5lIfOzdcoXqW+7oFgXfXgZiY3UymK3cpxO+Y7B3sMj4G7fDHseOBqb7Qh12k3ejP/doDMRQlpAY3XnFAJoMsXfX1UtCgK8H7HH8KtLuzqhczEpcc7THtwlOUX+Y2/cNS6lSEd18+LoVx6jtcnBeUlxpT3Ml43MHqxiGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W2XMNB2I; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W2XMNB2I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4DB9C16AAE;
	Tue, 20 Jan 2026 18:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768935393;
	bh=lHPeenipo+JjDaxaE0lcp57qJlGdlmz17mZc67T7DuM=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=W2XMNB2IJUGQWTAvgXo+9h7Qw6pcALwSh3+VT+WLBHbWZ8iI0GL5mO2PBKtWIlDxl
	 we+3ieJKTb+XlXZYJSssU4goFRm3s6zAkh306ajEGAia2zFdOs5zFHp4cBXFa99nnw
	 ftLMJu1oBJMGY9aH2KmxCl69oj8oIN31BkzuK8SQjFbwjTavrkUvY5dPGxl6NwPffh
	 vP6GZ0eABa1D+I9BL9AZ/YJE/xtB7dE+q3P74Krw1gpop9OE6t2Twqeu2DPfp5+hA8
	 NqPTeV8+zJ1AKCtNvQ+/dkuTKBEHDdz5WLt1k9w89WrRa2LYl6yIiwZXI2Voh15heD
	 Ph5EIJGMQTQxg==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 20 Jan 2026 19:56:29 +0100
Message-Id: <DFTN9F5OGCBS.2CRNLWNC60971@kernel.org>
Subject: Re: [PATCH 1/4] rust: device: support `dev_printk` on all devices
Cc: "Gary Guo" <gary@garyguo.net>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun.feng@gmail.com>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Bjorn
 Helgaas" <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
To: "Gary Guo" <gary@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260120181152.3640314-1-gary@kernel.org>
In-Reply-To: <20260120181152.3640314-1-gary@kernel.org>

On Tue Jan 20, 2026 at 7:11 PM CET, Gary Guo wrote:
> diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
> index c7b5db9dcca1..94e0548e7687 100644
> --- a/rust/kernel/device.rs
> +++ b/rust/kernel/device.rs
> @@ -601,6 +601,13 @@ impl DeviceContext for Core {}
>  impl DeviceContext for CoreInternal {}
>  impl DeviceContext for Normal {}
> =20
> +impl<Ctx: DeviceContext> AsRef<Device<Ctx>> for Device<Ctx> {
> +    #[inline]
> +    fn as_ref(&self) -> &Device<Ctx> {
> +        self
> +    }
> +}
> +
>  /// Convert device references to bus device references.
>  ///
>  /// Bus devices can implement this trait to allow abstractions to provid=
e the bus device in
> @@ -720,7 +727,7 @@ macro_rules! impl_device_context_into_aref {
>  macro_rules! dev_printk {
>      ($method:ident, $dev:expr, $($f:tt)*) =3D> {
>          {
> -            ($dev).$method($crate::prelude::fmt!($($f)*));
> +            $crate::device::Device::$method($dev.as_ref(), $crate::prelu=
de::fmt!($($f)*))

At a first glance I wasn't sure if we really want to rely on AsRef when hid=
e it
in the macro. But on the other hand, if someone would implement AsRef on a =
class
or bus device to return some other (unrelated) &Device it would be wrong
anyways. So I think using AsRef is fine.

I think a lot of people will be very happy about this patch. :)

I will pick up patches 1 and 2 this cycle, patch 3 and 4 can go through the
corresponding subsystem tree next cycle.

> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> index bea76ca9c3da..3946ca919332 100644
> --- a/rust/kernel/pci.rs
> +++ b/rust/kernel/pci.rs
> @@ -351,7 +351,7 @@ impl Device {
>      ///     // Get an instance of `Vendor`.
>      ///     let vendor =3D pdev.vendor_id();
>      ///     dev_info!(
> -    ///         pdev.as_ref(),
> +    ///         pdev,
>      ///         "Device: Vendor=3D{}, Device=3D0x{:x}\n",
>      ///         vendor,
>      ///         pdev.device_id()
> diff --git a/rust/kernel/pci/id.rs b/rust/kernel/pci/id.rs
> index c09125946d9e..e2d9e8804347 100644
> --- a/rust/kernel/pci/id.rs
> +++ b/rust/kernel/pci/id.rs
> @@ -22,7 +22,7 @@
>  /// fn probe_device(pdev: &pci::Device<Core>) -> Result {
>  ///     let pci_class =3D pdev.pci_class();
>  ///     dev_info!(
> -///         pdev.as_ref(),
> +///         pdev,
>  ///         "Detected PCI class: {}\n",
>  ///         pci_class
>  ///     );

Can you please send a separate patch for those?

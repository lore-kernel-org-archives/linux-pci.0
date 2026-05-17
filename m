Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDBA70830
	for <linux-pci@vger.kernel.org>; Sun, 17 May 2026 00:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778979462; cv=none; b=syLmTxNDPCHk/kV6e4tEWyB1DPwyoEScmKLl8Lpt0YCrljIrb3BEQHorTCy9/gau+RLJJIyXxciasWNKrmSSX42pmYMeCC3gjPqdgCNp1Ko6dC8/v6wlTfz2EPcXSmMZ0Ve/02jzflxU20tLmnYBxZKpUlWeQ4Av9P9p/e2pNBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778979462; c=relaxed/simple;
	bh=6bUWj+h/v9SXB5gecIjoRMWO4vk9hoI/f5Bh8bGkDzw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PDY0kI8ZJM9bjUy6sWGbHJEYbcKwH3m1vaDi+rVFG7kjYnk200Cyyq0Vuw2b+XAS7Z2XcNyOAmeFoHpICeXDtLTii7xnNOgwEF/O/h6TyDe0dLrGR0Fa++9KfACbN/iCIkkeP35JvvtpRBaWfC7+UNTdrMlGyrjw6UdW1R4lVZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iY4JFlA/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iY4JFlA/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38251C19425;
	Sun, 17 May 2026 00:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778979462;
	bh=6bUWj+h/v9SXB5gecIjoRMWO4vk9hoI/f5Bh8bGkDzw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=iY4JFlA/+gUn8lJRkeHOQ4U0TIte5i2zsfEOtulDEhS2zbhKj8uHv8uz3XyQDygXD
	 SG7RpPcnUeQG3LS4eB/fVAoDpDpSc8mJjZyx2ScwkbHLbpbcwJV502YI3J2IoPWs8L
	 z8N+ALv7ZI4dhEg1TdmsJa7DZS5lvW+pV8ZQI0c0WcfSrR1QJnCVMBP9jDQLC3t5D+
	 gW4N2FuTRj8h2MzJlagiXRiDmle6iWPYAHJYtoHfxrUXeVzifl2Eq7s9StRH6URdO9
	 a7M7qTns3Mu6pZ8ivDSuVKzPR1hb52uicGHi5q/HN1Cd3WopYxdDGk7QaxcE380MoZ
	 E+8mDLzAyQqPA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 19/27] rust: pci: make Bar lifetime-parameterized
Reply-To: sashiko-reviews@lists.linux.dev
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: ojeda@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260517000149.3226762-20-dakr@kernel.org>
References: <20260517000149.3226762-20-dakr@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 17 May 2026 00:57:41 +0000
Message-Id: <20260517005742.38251C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The `name` pointer passed to `pci_request_region` is stored direct=
ly in the kernel's resource tree, causing a Use-After-Free if a dynamically=
 allocated string is passed.
--

commit 288028203fe9a624774ed430783fe427c724785b
Author: Danilo Krummrich <dakr@kernel.org>

rust: pci: make Bar lifetime-parameterized

Convert pci::Bar to be lifetime-parameterized over the device bound.
iomap_region_sized now returns Result<Bar<'bound, SIZE>> directly. Add
Bar::into_devres() to register the bar as a device-managed resource.

> diff --git a/rust/kernel/pci/io.rs b/rust/kernel/pci/io.rs
> index ae78676c927ff..5668394a155bd 100644
> --- a/rust/kernel/pci/io.rs
> +++ b/rust/kernel/pci/io.rs

[ ... ]

> @@ -146,14 +145,14 @@ impl<'a, S: ConfigSpaceKind> IoKnownSize for Config=
Space<'a, S> {
>  ///
>  /// `Bar` always holds an `IoRaw` instance that holds a valid pointer to=
 the start of the I/O
>  /// memory mapped PCI BAR and its size.
> -pub struct Bar<const SIZE: usize =3D 0> {
> -    pdev: ARef<Device>,
> +pub struct Bar<'bound, const SIZE: usize =3D 0> {
> +    pdev: &'bound Device<device::Bound>,
>      io: MmioRaw<SIZE>,
>      num: i32,
>  }
> =20
> -impl<const SIZE: usize> Bar<SIZE> {
> -    pub(super) fn new(pdev: &Device, num: u32, name: &CStr) -> Result<Se=
lf> {
> +impl<'bound, const SIZE: usize> Bar<'bound, SIZE> {
> +    pub(super) fn new(pdev: &'bound Device<device::Bound>, num: u32, nam=
e: &CStr) -> Result<Self> {

Does this name parameter need a 'static bound?

The kernel's pci_request_region() function (via __request_region_locked())
stores the raw string pointer directly into the struct resource tree
(res->name =3D name) without copying it.

Because the API does not enforce a 'static lifetime on name, a caller
could pass a dynamically allocated CString that is dropped immediately. If
this happens, the kernel resource tree will hold a dangling pointer,
resulting in a use-after-free when /proc/iomem or /proc/ioports are read.

While the previous signature (name: &'a CStr) also failed to guarantee the
string outlived the resource, should we enforce name: &'static CStr here
to prevent memory corruption?

[ ... ]

> @@ -249,20 +257,16 @@ fn deref(&self) -> &Self::Target {
>  impl Device<device::Bound> {
>      /// Maps an entire PCI BAR after performing a region-request on it. =
I/O operation bound checks
>      /// can be performed on compile time for offsets (plus the requested=
 type size) < SIZE.
> -    pub fn iomap_region_sized<'a, const SIZE: usize>(
> -        &'a self,
> +    pub fn iomap_region_sized<'bound, const SIZE: usize>(
> +        &'bound self,
>          bar: u32,
> -        name: &'a CStr,
> -    ) -> impl PinInit<Devres<Bar<SIZE>>, Error> + 'a {
> -        Devres::new(self.as_ref(), Bar::<SIZE>::new(self, bar, name))
> +        name: &CStr,
> +    ) -> Result<Bar<'bound, SIZE>> {
> +        Bar::new(self, bar, name)
>      }
> =20
>      /// Maps an entire PCI BAR after performing a region-request on it.
> -    pub fn iomap_region<'a>(
> -        &'a self,
> -        bar: u32,
> -        name: &'a CStr,
> -    ) -> impl PinInit<Devres<Bar>, Error> + 'a {
> +    pub fn iomap_region<'bound>(&'bound self, bar: u32, name: &CStr) -> =
Result<Bar<'bound>> {
>          self.iomap_region_sized::<0>(bar, name)
>      }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260517000149.3226=
762-1-dakr@kernel.org?part=3D19

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FFC42589A
	for <linux-pci@vger.kernel.org>; Sun,  4 Oct 2026 12:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791116053; cv=none; b=NRd74Vm0VyGAKjFPXMoTM+WW0hGz9dmT+MRj5P0x4mEUnKZZpUv6UDISEjDjaErNV4ZdULp4CO/zrpEkBVX4rTiQz/1+08aJ7/pBJZph/usy5fZzYIU0WxV1kArGhbWO6uIsfRWjzmP1CN6MwFEhrDXXC4L6z/TTzyjwaBqJ06E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791116053; c=relaxed/simple;
	bh=ncGbfE4tNNWnSb58zq56ZXfHdvhXmNwcVNj10P3fJvQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XGL/twe7JOwdEZhmmxk9syXydVk1OGstRG0s3qhphIFIS/UziiArEzhvCtk0bnTd6pGPW73gAwBuGpl5WuNSBjMxi+ihgwtbmHDQW3VGwjHtfI4tO379JDqxAyeBu1FE1iBURXcsV7JU7+MdxgbR23XJpLwgQqUF7d0i8lTr6Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JPg7Ddbp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JPg7Ddbp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86DF31F000FF;
	Sun,  4 Oct 2026 12:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791116051;
	bh=2+3PDlWvX4FFO8zmDaOqnhJgHbZPpv9M9WM5ny33OTo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JPg7DdbpLkIkTSGSu/TnPRyEVCRhSsuZZKkAftaRUoyKnsORuV5FnAkRYDG4gzbOZ
	 JCYePJaotzhtuvNPQKPVWrxSRYoUtYwGrDg6buuT/5XLBpwSe6WX4ZrC8C+2GGkqqA
	 83P239Zw2tWzj2s7tGzgLQ8M70ofBfYD3OiuTl0ovhaI6RSsnuXX3XHphJgm5vxccn
	 OcWKGkG3vy/np7T8ca0yQcZD/bVqQNi384SgWEHYj9lHySaBfsnJ6dxmLumBBX3teW
	 XjP2Is320dWXs7OVE8Gceu7YIzPg9iD3jEEVsjTIT83UwA+9tZTGdayfFqtSJCbkC1
	 0uKCbqUEKvYzw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/9] rust: pci: add internal SR-IOV enable and
 disable helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhi Wang" <zhiw@nvidia.com>
Cc: linux-pci@vger.kernel.org, ojeda@kernel.org, gary@garyguo.net
In-Reply-To: <20261004120732.1045629-2-zhiw@nvidia.com>
References: <20261004120732.1045629-1-zhiw@nvidia.com>
 <20261004120732.1045629-2-zhiw@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 04 Oct 2026 12:14:11 +0000
Message-Id: <20261004121411.86DF31F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] rust: pci: missing #[inline] on abstraction functions forwarding to=
 C bindings
--

commit c316165d2a3f7f2b9498fa8f5fcc7616b0e3fb32
Author: Peter Colberg <peter@colberg.org>

rust: pci: add internal SR-IOV enable and disable helpers

This commit wraps pci_enable_sriov() and pci_disable_sriov() on
Device<CoreInternal> for use by SR-IOV callback tokens. These operations
are kept internal to ensure drivers can only modify VFs through the
callback-scoped API.

> diff --git a/rust/kernel/pci/iov.rs b/rust/kernel/pci/iov.rs
> new file mode 100644
> index 0000000000000..1af5bdc198302
> --- /dev/null
> +++ b/rust/kernel/pci/iov.rs
[ ... ]
> +impl Device<device::CoreInternal<'_>> {
> +    /// Enable the Single Root I/O Virtualization (SR-IOV) capability fo=
r this device,
> +    /// where `nr_virtfn` is number of Virtual Functions (VF) to enable.
> +    #[expect(dead_code)]
> +    pub(crate) fn enable_sriov(&self, nr_virtfn: u16) -> Result {

[Severity: Low]
This isn't a bug, but does this abstraction method miss an inline annotatio=
n?
The Rust subsystem guidelines specify that functions forwarding to a C bind=
ing
call in the kernel crate should be annotated with inline to allow for
compiler optimization.

> +        // SAFETY:
[ ... ]
> +        // - The [`CoreInternal`] device context inherits from the [`Bou=
nd`] device context,
> +        //   which guarantees that the PF device is bound to a driver.
> +        to_result(unsafe { bindings::pci_enable_sriov(self.as_raw(), nr_=
virtfn.into()) })
> +    }
> +
> +    /// Disable the Single Root I/O Virtualization (SR-IOV) capability f=
or this device.
> +    #[expect(dead_code)]
> +    pub(crate) fn disable_sriov(&self) {

[Severity: Low]
Similarly, should this method also include an inline annotation since it
directly forwards to the pci_disable_sriov C binding?

> +        // SAFETY:
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261004120732.1045=
629-1-zhiw@nvidia.com?part=3D1

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C1743CE56
	for <linux-pci@vger.kernel.org>; Sun,  4 Oct 2026 12:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791116226; cv=none; b=fGjxthqO4TyEIVFQ9eOBLG47kZIHP89gTn63LH5m/0imXtyNGld+BYo+sDTy1bFt143vJniRgGehyzPt4bQzMqFHlQQNygw4ZGOPrmy3gIvF7D2DPB1Ojub/pxduuNS99IeL+n+rsqx/j7DrOowIvWINPmkFdkUlTjaSkCV8e1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791116226; c=relaxed/simple;
	bh=7Oi0vkLngrgDgtti9ZM4azukD+1qcCS9D6mmXjMeTqo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XLgB5wBfxrJd66EszxBKqXRFKJiuol/3I8AxKiY9d+Y/U4id5tbrIFJaTVORRcd3bAKde8CWXBDPPBRRql+4NdeCs6fo6U99Zs+nxvFxu70TSf75pVEUX6JproYdwNxOSty75hsb2Hk+vUQalM7rgropG0CEGPFhdk+m/dc2RTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VV7JGCNn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VV7JGCNn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AA521F000FF;
	Sun,  4 Oct 2026 12:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791116224;
	bh=9gXioh9hLwp6gqGExPHBJlbxH1tbobI5m9WuWQ0QFSs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VV7JGCNnugP8YSodExqnPWGHC7aI8fdnbpBhFf7o4rCBYyZ2ig5T89g4Dy9yMA/DE
	 Pa5qfXYpANqGaFvcOCEKs3RZYns5MWv40kQ1eNlrWmmTNWDorwVXbuXSoWzD5DeEJP
	 N55h8XbjPNifbUfGDsfREQscdsSDuLVoAI1Jt1a2UiojvEzg2SmCNjW/pJhAYhCss5
	 4szWqnSlkrCCgmWrRGL0bnyTkx5gPkOISgsVuf7j1gyqNGR1vRXiO15VsKin08K+jX
	 +cIKftvZo62BBwuDtj8K3sTfLT8B/Z9vrsC+Q4rOc/ou9CMBjmPKpU+mztNIHt9ZCO
	 v9YAq6clSFCsg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 7/9] rust: pci: add SR-IOV enable and disable tokens
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhi Wang" <zhiw@nvidia.com>
Cc: ojeda@kernel.org, linux-pci@vger.kernel.org, gary@garyguo.net
In-Reply-To: <20261004120732.1045629-8-zhiw@nvidia.com>
References: <20261004120732.1045629-1-zhiw@nvidia.com>
 <20261004120732.1045629-8-zhiw@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 04 Oct 2026 12:17:04 +0000
Message-Id: <20261004121704.9AA521F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] rust: missing #[inline] on small abstraction functions
--

commit e7af204882b55dcbfacee7ce650e2197a9830e0f
Author: Zhi Wang <zhiw@nvidia.com>

rust: pci: add SR-IOV enable and disable tokens

This commit introduces SR-IOV enable and disable tokens for PCI device
drivers in Rust. It utilizes callback-scoped guards to ensure SR-IOV is
disabled on error and coordinates final VF teardown with registration
tokens.

> diff --git a/rust/kernel/pci/iov.rs b/rust/kernel/pci/iov.rs
> index c61462595141f..449f1e9b12fda 100644
> --- a/rust/kernel/pci/iov.rs
> +++ b/rust/kernel/pci/iov.rs

[ ... ]

> +pub struct SriovEnable<'a> {
> +    pdev: &'a Device<device::CoreInternal<'a>>,
> +    num_vfs: u16,
> +}
> +
> +impl<'a> SriovEnable<'a> {
> +    /// Returns the number of VFs requested for this callback.
> +    pub fn num_vfs(&self) -> u16 {
> +        self.num_vfs
> +    }

[Severity: Low]
Should this trivial accessor be annotated with #[inline]? Subsystem
guidelines suggest small functions in the kernel crate abstraction should be
explicitly annotated to prevent suboptimal code generation.

[ ... ]

> +/// Enabled VFs awaiting successful completion of `sriov_enable()`.
> +pub struct SriovEnabled<'a> {
> +    pdev: &'a Device<device::CoreInternal<'a>>,
> +    num_vfs: u16,
> +}
> +
> +impl SriovEnabled<'_> {
> +    #[expect(dead_code)]
> +    fn disarm(self) -> u16 {
> +        ManuallyDrop::new(self).num_vfs
> +    }

[Severity: Low]
Does this small wrapper manipulating object destruction need an #[inline]
annotation to ensure optimal inlining across crate boundaries?

[ ... ]

> +pub struct SriovDisable<'a> {
> +    pdev: &'a Device<device::CoreInternal<'a>>,
> +}
> +
> +impl SriovDisable<'_> {
> +    /// Disables all VFs and waits for their drivers to unbind.
> +    ///
> +    /// The PF resources used by VF drivers must remain available until =
this method returns.
> +    pub fn disable(self) {
> +        self.pdev.disable_sriov();
> +    }

[Severity: Low]
Could this small forwarding method benefit from an #[inline] annotation?
The Rust subsystem guidelines recommend #[inline] for functions forwarding
to other methods in abstractions.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261004120732.1045=
629-1-zhiw@nvidia.com?part=3D7

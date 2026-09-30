Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84756486E67
	for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2026 10:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790764663; cv=none; b=tulD2NV41P/7xHCbMLoXhzTG7HH4IowBOjTCZJ4raH8h4XpOWyel0LWCeTZj6noDVVIiFZyaqSLooo5j2dFf6CfjHPSndxLNoYadPBhXHUauzXL1R3DaZ03czHj09Y6dqAmw229OGggVsuW4WXDFFcE8ev30GmDMznEClvdYgsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790764663; c=relaxed/simple;
	bh=dL6Oz1sNnbuNxqFVkPEe4ZkkqeR8XYlDm19ITE+v404=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KEi7COFJ4BhUOj+J975Uaau7snJChGQPHrTiWzLORttfsaiG35iXj2MSCJc4uY+2ycozgot229e/RtZVptp7lPeUPvWqh5HYw4t6QVe5Pe569Cec5wBWOB+XczpFJybsVZqEsyaQoDxif9JU7YipjvToQB7SCS04BZ+i6GGakN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ieQG9YUI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ieQG9YUI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08BA61F00893;
	Wed, 30 Sep 2026 10:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790764662;
	bh=MVPkNKOGeYUoSVIS5nCCjxvr81l/+NaGwxA+dII60qY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ieQG9YUIyBAbBGCslPuj2o5PbqD3Bx9gNw9Hd3eZiNpyowtTYn8rhEa+6dUZHbp2r
	 a7GsX/oUg7Od5RSEyBo8zDg8ou91jX2rimg121mdnmAfb7UE/0hNezZErLttklwlmg
	 DfZH9O1FAslVm/7equpd94xJqI2Wxb92WWddOtXXCO6FlNFrmklupIuwolXYn32xjo
	 iA6Ms3RACmpTsWlor/8dvPNfHzaSir/cvLIU1VD2Bd5trlzqFx1kjqtibQjCwhktdi
	 gJs7enAj9a69Rb7pd+JMa5VFYXO44zCS5X51916Ixn9UyYUMLfwulrLpa5/Nqn6FWp
	 dmUD2DAq/LeXg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 08/10] rust: pci: add SR-IOV enable and disable
 tokens
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhi Wang" <zhiw@nvidia.com>
Cc: linux-pci@vger.kernel.org, ojeda@kernel.org, gary@garyguo.net
In-Reply-To: <9b092d339961f744c7ded1e4f21911b66c80ecb4.1790759932.git.zhiw@nvidia.com>
References: <cover.1790705494.git.zhiw@nvidia.com>
 <9b092d339961f744c7ded1e4f21911b66c80ecb4.1790759932.git.zhiw@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 10:37:41 +0000
Message-Id: <20260930103742.08BA61F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] rust: missing #[inline] for small/binding wrapper abstraction funct=
ions
--

commit 4e2162272f9a80159a9c71ad8cb46433c7d6fdae
Author: Zhi Wang <zhiw@nvidia.com>

rust: pci: add SR-IOV enable and disable tokens
   =20
The commit introduces callback-scoped tokens to manage SR-IOV enable/disable
lifecycles and rollback.

> diff --git a/rust/kernel/pci/iov.rs b/rust/kernel/pci/iov.rs
> index 3411a9101564c..e608b2f1e70c7 100644
> --- a/rust/kernel/pci/iov.rs
> +++ b/rust/kernel/pci/iov.rs
> @@ -47,7 +47,6 @@ pub fn num_vf(&self) -> i32 {
>  impl Device<device::CoreInternal<'_>> {
>      /// Enable the Single Root I/O Virtualization (SR-IOV) capability fo=
r this device,
>      /// where `nr_virtfn` is number of Virtual Functions (VF) to enable.
> -    #[expect(dead_code)]
>      pub(crate) fn enable_sriov(&self, nr_virtfn: c_int) -> Result {

[Severity: Low]
This isn't a bug, but should this function have an #[inline] annotation?
The Rust subsystem guidelines state that C binding wrappers should be inlin=
ed.

[ ... ]

>      /// Disable the Single Root I/O Virtualization (SR-IOV) capability f=
or this device.
> -    #[expect(dead_code)]
>      pub(crate) fn disable_sriov(&self) {

[Severity: Low]
This isn't a bug, but does this wrapper function also need an #[inline]
annotation since it forwards directly to the C bindings?

[ ... ]

> +impl<'callback> SriovEnable<'callback> {
> +    /// Returns the number of VFs requested for this callback.
> +    pub fn num_vfs(&self) -> u32 {
> +        self.num_vfs
> +    }

[Severity: Low]
This isn't a bug, but could we add an #[inline] annotation to this trivial
getter function?

[ ... ]

> +impl SriovEnabled<'_> {
> +    #[expect(dead_code)]
> +    fn disarm(mut self) -> c_int {
> +        self.pdev =3D None;
> +        self.num_vfs
> +    }
> +}

[Severity: Low]
This isn't a bug, but would it be appropriate to mark this small
state-mutating function with #[inline]?

[ ... ]

> +impl SriovDisable<'_> {
> +    /// Disables all VFs and waits for their drivers to unbind.
> +    ///
> +    /// The PF resources used by VF drivers must remain available until =
this method returns.
> +    pub fn disable(self) {
> +        self.pdev.disable_sriov();
> +    }
> +}

[Severity: Low]
This isn't a bug, but since this function directly forwards to disable_srio=
v(),
should it be annotated with #[inline]?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1790705494.gi=
t.zhiw@nvidia.com?part=3D8

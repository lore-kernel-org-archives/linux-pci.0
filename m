Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A163C9ED0
	for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2026 19:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790277225; cv=none; b=DdwBD3dy7fyeZSnH/o+ehTfKo9mpYgo2ceICR21CoDUygSk21MgbJ15pEcxQEX/MIkPTuhYhA2lc9YTO46t4jkQkRZAPsYEwI7H+bYk+GC7j5zP8BAffFNH7vSuD7fC53j7CT7wjG8SId2+k88Q5C/kXImDAPK0XVcr4VBHv3vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790277225; c=relaxed/simple;
	bh=dZNG4U3RV1K4Sj+LbHBrMVYO2vBDQMPoC/8DQGxxsps=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lVfXJnNs35iinsq6EIwUY2QGZl9eeoFguHFYGc56rTej3Z4wwaRLtVk41tferKKwdj0BKxfmYvd/fJRjOP+qzNZsxDhmNi276KU2nveAf9fdR7Yg/JLICcWtkCfKn+bBT8LAk3xslm5qBgiKvwaubbQwad37I4tf6F+odNuKBLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K2Rn+MYb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K2Rn+MYb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8E831F000FF;
	Thu, 24 Sep 2026 19:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790277224;
	bh=tt9VCqOVxBw9FzXfrHvprOsvhXLHYcR4QtT1HTN6YeY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K2Rn+MYbxinpsuLEyqvxyBPclxtZjddqirWiaFx4OXs8qfCkXnwfw4cO1TXUIpSt7
	 z205r9l1T7S279f9YlAecqt/ViEM7OsUSdElBvxGQgKzKwTGDIaqjUd+m2s2SKdzCM
	 OwcKbMvwiKHEgWZ1MNI1K4Zs2XHkOus5cmqmARfiahQrn6GG+qpgLJG3iuIdhbwPjW
	 O4ZrlFTUu3XisH2vzn+makEMmqHkwoRYFc/cS2515VuK/wD4WjN278SYDOf6GPiTW5
	 xJVZtplq8GW1RkMVGRIX0L9kke0Ou9fFSijU9RGNqWPlwwI3L51E1tPcJmE0r0HwuF
	 wg4HplD0IRgsg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/8] rust: pci: add num_vf(), to return number of VFs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhi Wang" <zhiw@nvidia.com>
Cc: gary@garyguo.net, linux-pci@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260924190556.1620886-6-zhiw@nvidia.com>
References: <20260924190556.1620886-1-zhiw@nvidia.com>
 <20260924190556.1620886-6-zhiw@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 19:13:43 +0000
Message-Id: <20260924191343.C8E831F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] rust: pci: missing unconditional availability for num_vf() causi=
ng driver build failures
- [Low] rust: pci: missing #[inline] on num_vf() FFI wrapper
--

commit 887b28180af5e15626ffb6304f6b61300c0d3b74
Author: Peter Colberg <pcolberg@redhat.com>

rust: pci: add num_vf(), to return number of VFs

Add a method to return the number of Virtual Functions (VF) enabled for
a Physical Function (PF).

> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> index ca009775bd612..db0554f14afc8 100644
> --- a/rust/kernel/pci.rs
> +++ b/rust/kernel/pci.rs
> @@ -449,6 +449,14 @@ pub(crate) fn is_virtfn(&self) -> bool {
>          unsafe { (*self.as_raw()).is_virtfn() !=3D 0 }
>      }
> =20
> +    /// Returns the number of Virtual Functions (VF) enabled for a Physi=
cal Function (PF).
> +    #[cfg(CONFIG_PCI_IOV)]

[Severity: Medium]
Will this cause build failures for drivers that unconditionally call
num_vf() when CONFIG_PCI_IOV is disabled?

In C, pci_num_vf() is unconditionally available as a static inline that
returns 0 when IOV is disabled, so drivers can safely call it without
checking Kconfig symbols. Adding #[cfg(CONFIG_PCI_IOV)] here hides the
method entirely in non-IOV builds, which will result in compilation errors
for downstream callers.

> +    #[expect(dead_code)]
> +    pub(crate) fn num_vf(&self) -> i32 {

[Severity: Low]
Should this method have the #[inline] attribute?

The rust subsystem guidelines recommend adding #[inline] to abstraction
methods that forward directly to a C binding.

> +        // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_dev=
`.
> +        unsafe { bindings::pci_num_vf(self.as_raw()) }
> +    }
> +
>      /// Returns the size of the given PCI BAR resource.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924190556.1620=
886-1-zhiw@nvidia.com?part=3D5

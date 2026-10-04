Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB943A4F32
	for <linux-pci@vger.kernel.org>; Sun,  4 Oct 2026 12:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791116150; cv=none; b=bZfwEBQZ+oqZMPJpbstxUdn0A7VmuQEG9SxOGA4Fzxd0j8fEw2lnwW+7kMjXTgscEYcGevu1SaTrMizTuku82dbqRtDMWATycecB/Hl4udy+JjPXOozSXGTwt3eI+FjIXpuLT6vgbmb9XZUkdPY2qFx7ET8cbrMdyee9yx0e9+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791116150; c=relaxed/simple;
	bh=tUNiLpT/d1v7Ulp76hFNAsIXijlDDlPiKhQFioDjUJI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=vBPJBZ0vOwAisfWsBhm1sGxYL9xROsDVwchLmwSeTA5/g0hY9zUbCrl8xTIP+6ljdyJw5gIrvo+01WSw/ExuxWHcfAmM4EwJx2oATjj3qacOubtnDgUKaN+MilhrU6We88/m0QZZuI7mPkzxQWbwwV8x/xaUtywNCVhViegpNAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M15pCwWV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M15pCwWV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B33941F000FF;
	Sun,  4 Oct 2026 12:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791116149;
	bh=rDbAxPAMPx7xUSRaFpIjaLLmC40S8SuFRRQBvl6K0cY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=M15pCwWVpTQgt/iru7D72znKq0UQ2b0vuL4WO4m8HeyHu6yszaUpIDC2CsjSsOZKS
	 3wArO1a1eq8Ep/CNIwmPnz1JCmuVNNH48IH0oZh+JLvZ0zjVDGh0whQWsPlb2xP9Bq
	 peq4koHpR7NpZve6IlNP/FRF2t4L7peQ+1++zAZGqTvvuMUSLRONE/yXa2iHBMmL3Z
	 x47x7l19UCAqNhlmG95oFYi4dxz12mLmCfYbdUGwJJIDWDhSJlO6BDO7ydLyziNJ38
	 7fq5v9MUbBMqG8vZ+/awftilUz8E6JbJIynmcJP2Wz6NrkhVjgWUR1q50WJhRBrAG0
	 i+S3354yF0Y1Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/9] rust: pci: add num_vf(), to return number of VFs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhi Wang" <zhiw@nvidia.com>
Cc: gary@garyguo.net, ojeda@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261004120732.1045629-5-zhiw@nvidia.com>
References: <20261004120732.1045629-1-zhiw@nvidia.com>
 <20261004120732.1045629-5-zhiw@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 04 Oct 2026 12:15:48 +0000
Message-Id: <20261004121548.B33941F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] rust: pci: missing #[inline] annotation on num_vf() abstraction
--

commit 631ac1e7bf636d5226a53e025ed45307e5f2d334
Author: Peter Colberg <peter@colberg.org>

rust: pci: add num_vf(), to return number of VFs

Add a method to return the number of Virtual Functions (VF) enabled for
a Physical Function (PF).

> diff --git a/rust/kernel/pci/iov.rs b/rust/kernel/pci/iov.rs
> index 616ac40b8bcd4..4ed6ba658e818 100644
> --- a/rust/kernel/pci/iov.rs
> +++ b/rust/kernel/pci/iov.rs
> @@ -20,6 +20,16 @@ pub fn is_virtfn(&self) -> bool {
>      }
>  }
> =20
> +impl Device<device::Core<'_>> {
> +    /// Returns the number of Virtual Functions (VF) enabled for a Physi=
cal Function (PF).
> +    pub fn num_vf(&self) -> u16 {

[Severity: Low]
This isn't a bug, but this abstraction function forwards to a C binding
(bindings::pci_num_vf) and appears to be missing the #[inline] annotation.

According to the Rust subsystem guidelines, small functions or functions
forwarding to a C binding call in abstractions should be annotated with
#[inline].

Should an #[inline] attribute be added here?

> +        // SAFETY: `self.as_raw()` is valid and this call runs in the PC=
I core callback context.
> +        unsafe { bindings::pci_num_vf(self.as_raw()) }
> +            .try_into()
> +            .expect("pdev->sriov->num_VFs is u16")
> +    }
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261004120732.1045=
629-1-zhiw@nvidia.com?part=3D4

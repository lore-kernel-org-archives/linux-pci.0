Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E412939CCFE
	for <linux-pci@vger.kernel.org>; Sun,  4 Oct 2026 12:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791116278; cv=none; b=GqG1A+DbHUCH+nE47C+srVesDsQF/onO2qnULMu5QMKkDwX1/Yrbm/tVxOJEjRRhgmemw1Ayyzsv99sT6yqElPvzWgvNaRGYAQD+uDsNVZhYwmGVzRpP6AFFYVoa25KnF+6wGUKBtaIjVWFRSrHG/Q3bXgPnTVJoZKkvatLGmqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791116278; c=relaxed/simple;
	bh=CChogUJGTG4OzGe4nrmbPYCVo/sFHediChaNGumoELA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OgnK6KYHK64M5Y2FK0AWg2N31KpvzhzSUcKF1X+P+T3NfzhvQjbKi6zFsTKzKBjEievIBIcKKN20LB4UenDJxGNSAitvhpW/F23WsqH1mcsWhP3/niqh+B3Lu9Y9lOe/qwCAL7kxCeiRfrVMIBpfZwbGdiSg42nwW8zVDbDBA6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ythb976E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ythb976E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DFEF1F000FF;
	Sun,  4 Oct 2026 12:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791116276;
	bh=gW1kHZqrcjmLdBGdf+4y5KT0TUyUCjTYCPIf/yfEyck=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ythb976EK//vu2uwh88kDeuKE+2Rtmh6dzgG//HbYMlaqI8yHVJRlSPhP6BeKQNNM
	 TBRUKf4Fcby2EiKME+YQRBSecSTTa9gfq0oT9EllSIYV9jnF+AKDL1G0QK24OPPLi1
	 9dPhA1dW1k5WiTvIyD50vLC/JLFH632qLy5wNSfDN6MXEOYDl1wOr/0zGp8SodeHZO
	 wh5NCdXqn+cfiVeR5EsfFt2/jmDOZ9nFWykBwMBvDod5gXhhx1a8jD2ZA5XN77LjOI
	 cFtPPaYK0kxLoaVM6Jf78SkBLQPR0U/i5NF7kQHRpz4n5NZfE9GrTNJzBN1XtQRiJF
	 Pvau3SkZM8Xrw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/9] rust: pci: add is_virtfn(), to check for VFs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhi Wang" <zhiw@nvidia.com>
Cc: linux-pci@vger.kernel.org, gary@garyguo.net, ojeda@kernel.org
In-Reply-To: <20261004120732.1045629-4-zhiw@nvidia.com>
References: <20261004120732.1045629-1-zhiw@nvidia.com>
 <20261004120732.1045629-4-zhiw@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 04 Oct 2026 12:17:55 +0000
Message-Id: <20261004121756.2DFEF1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] rust: pci: is_virtfn() causes build failure without CONFIG_PCI_IOV
--

commit 391d320fa5a3d19a9fe3ffdc043f22844cce0dde
Author: John Hubbard <jhubbard@nvidia.com>

rust: pci: add is_virtfn(), to check for VFs

Add a method to check if a PCI device is a Virtual Function (VF) created
through Single Root I/O Virtualization (SR-IOV).

> diff --git a/rust/kernel/pci/iov.rs b/rust/kernel/pci/iov.rs
> index 1af5bdc198302..616ac40b8bcd4 100644
> --- a/rust/kernel/pci/iov.rs
> +++ b/rust/kernel/pci/iov.rs
> @@ -11,6 +11,15 @@
>      prelude::*, //
>  };
> =20
> +impl Device {
> +    /// Returns `true` if this device is a Virtual Function (VF).
> +    #[inline]
> +    pub fn is_virtfn(&self) -> bool {

[Severity: Low]
Will this cause build failures for Rust drivers when CONFIG_PCI_IOV is
disabled?

Since this method is defined inside rust/kernel/pci/iov.rs, and that module
is guarded by #[cfg(CONFIG_PCI_IOV)] in rust/kernel/pci.rs, is_virtfn()
becomes conditionally compiled.

In the C API, the is_virtfn field on struct pci_dev is unconditionally
available, and drivers routinely check it unconditionally to skip PF-specif=
ic
setup. If a Rust driver does the same, it would fail to compile when
CONFIG_PCI_IOV=3Dn. Could this be moved to an unconditionally compiled modu=
le?

> +        // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_dev=
`.
> +        unsafe { (*self.as_raw()).is_virtfn() !=3D 0 }
> +    }
> +}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261004120732.1045=
629-1-zhiw@nvidia.com?part=3D3

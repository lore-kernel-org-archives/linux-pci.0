Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C63A2DFA4A
	for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2026 10:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790764464; cv=none; b=Kw7mBq2qUlcJHz33bNmJCr7dDx8RfyYgKTVsBhNcprgeEXfU8iS9SGt+34N09Vq6BUz8H/3VzTyOtKGzBTxVc/1uSm12Haq8OfEgwA88WOXuoTds62lOl/CZVJ7axuXeGdD2zvg9E/mVfToG2EMlEdHHIsY1CS1F0qGFSQJYpn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790764464; c=relaxed/simple;
	bh=p9ds84XS48RcNt7RGyzfylBjCNEv2V32Z40DPVhgowk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YvjfSkZiR/dVLwacYX3CMKpPDaeSgZO7xFYKlFy/PRhfX7vgnn/3vnIVE9kgchOhH4hjAbB0+yOKLsPyONbc3y/wiOgRpIpbp+D7gzi/Xnu9uxCCpWk5bitmeslBI9Hb930mJMUQzSjHBbsItmtCB7iFlXVyVB5wTcU9XRzq6kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H0CtyYvu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H0CtyYvu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C79661F000FF;
	Wed, 30 Sep 2026 10:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790764463;
	bh=iYdqjMWldb41lEQjIkHDV0UMkKJ8BPBYWGb7yEyRwWM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=H0CtyYvuwvajOz9t9cGoZLbOFVVTixzuwRi7EajtqNcCNEOLncQS1egsFG4/37LVC
	 iHV3IIS0gcK3XxcDbWTubzvSELopOxBzRyhMsO3eXk2usRrod6AS9tank02Sc6sNt9
	 H/ptz44bWhWlix1iibXjIlWyCXDqysM6+vIzHSbBkH6VQy6lExverz5a3qvJT9FALR
	 QxN0Ee/IHD6EpeWqW7Peocy54GMlV67lL+ymmIsV8gEppdeiLeisIwHCqo5RMu8TML
	 Jq5GbBTP+J1ffOI0wQ6M1RTTXwWPhFRfJNyoosvq5EPx+xDbloCHINRiATbqY20LpM
	 nd54tejVONO2Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 03/10] rust: pci: add is_virtfn(), to check for VFs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhi Wang" <zhiw@nvidia.com>
Cc: linux-pci@vger.kernel.org, ojeda@kernel.org, gary@garyguo.net
In-Reply-To: <eca774843f5bbeec015307d6491ae9da5a222275.1790759932.git.zhiw@nvidia.com>
References: <cover.1790705494.git.zhiw@nvidia.com>
 <eca774843f5bbeec015307d6491ae9da5a222275.1790759932.git.zhiw@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 10:34:22 +0000
Message-Id: <20260930103422.C79661F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] pci: conditional compilation bug for pci::Device::is_virtfn()
--

commit 1fc1516a8aa1429dbd6a2108303ca0548d1cd4cf
Author: John Hubbard <jhubbard@nvidia.com>

rust: pci: add is_virtfn(), to check for VFs

This commit adds a method to the PCI device abstraction to check if a
device is a Virtual Function (VF) created through SR-IOV.

> diff --git a/rust/kernel/pci/iov.rs b/rust/kernel/pci/iov.rs
> index c37ce51346731..272ed677f1451 100644
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

[Severity: Medium]
Does this introduce a conditional compilation issue when CONFIG_PCI_IOV
is disabled?

Since the is_virtfn method is defined in rust/kernel/pci/iov.rs, which is
entirely compiled out when CONFIG_PCI_IOV is not set, it becomes unavailable
to drivers. In the C API, the is_virtfn bitfield in struct pci_dev is
unconditionally available regardless of the CONFIG_PCI_IOV configuration.

If a Rust driver attempts to call pdev.is_virtfn() on a kernel configured
with CONFIG_PCI_IOV=3Dn, the build will fail. Should this method be moved
to a module that is always compiled, matching the C API's availability?

> +        // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_dev=
`.
> +        unsafe { (*self.as_raw()).is_virtfn() !=3D 0 }
> +    }
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1790705494.gi=
t.zhiw@nvidia.com?part=3D3

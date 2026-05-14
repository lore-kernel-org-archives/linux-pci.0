Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62113F4112
	for <linux-pci@vger.kernel.org>; Thu, 14 May 2026 03:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778728480; cv=none; b=XVuH0lY4P7niG3SJ3hx9csys5SW/pSP6cg8Rw+mPmnVCjpeVlL9CWAu9Qosr0BWRCwsk/QcT4LL/h+BfW1EUuYbvIvzZG6S8LrguHaFDxlbzx1mWQ6E+3zJdNQoU4BUlL7AWWc+ForQjjR/HhZhiB9cDCm2Y9Zhoz0Ly1Wwoyxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778728480; c=relaxed/simple;
	bh=GYAsikJjjcTt5V0MmkJ9zlLfnNjIosPD1Yx7kc7bZ18=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NK2gw2BEEy6ldAMLX0583Z5MDybZ+hU9FUjH27lbqDZN3ehyKupWS8nS+Ao7QNgb95E5t5sc7ffLPZYpUtrJrtDCpi3PFxPAZ3g2Orndzfcpo2vV26bcDEFigMmsC/rqz5CEDy2xnH57ogNFC/qqc2wDt1igdUhE5FlW/HXz/4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hjmR2CrM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hjmR2CrM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 483F0C19425;
	Thu, 14 May 2026 03:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778728480;
	bh=GYAsikJjjcTt5V0MmkJ9zlLfnNjIosPD1Yx7kc7bZ18=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=hjmR2CrMRH2CO9OKAvMZpgCLFHW5Ql8dkRXnb5zN/uC9sapSKfU6ryWt+O4yIWa8G
	 yyOWZMrLEaB05vvWz98QJ48RnHcJ2c+hBw0wIuBvC5q4wM7pQyjhjGFpQez1j1vItq
	 z3Od4nPyuwQsvXh+RI89xOYFgkp1R46Jx64CXHCx2ZERh8+VGZzUUIntzbC+MAsHco
	 uY25XJrrglV/VAXMYx7bHFO33n4Aats7eEz4lbVr4W4BvxcCwAtk+dlb9OEcqvmQqe
	 0vXSE6WrXth4kSlXgQVbN3CiUUbslM8LjbcEWlmKpGM7Z0yazpKFeoYm1xtDJlY8ql
	 RcQnFITpoL0WQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 09/11] PCI: liveupdate: Freeze preservation status
 during shutdown
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Matlack" <dmatlack@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260512184846.119396-10-dmatlack@google.com>
References: <20260512184846.119396-10-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 03:14:39 +0000
Message-Id: <20260514031440.483F0C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Preservation rollback fails if the device is concurrently frozen, =
breaking bridge hierarchy invariants.
- [Low] Syntax error in the !CONFIG_PCI_LIVEUPDATE stub for pci_liveupdate_=
freeze().
--

commit f49768e50767ced554fd83ab7e5016423c3d87a2
Author: David Matlack <dmatlack@google.com>

PCI: liveupdate: Freeze preservation status during shutdown

Freeze a device's outgoing preservation status (preserved or not preserved)
during shutdown. This enables the PCI core and drivers to safely make
decisions based on the device's preservation status during shutdown.

> diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
> index 6ab03bd548b37..825166a579130 100644
> --- a/drivers/pci/liveupdate.c
> +++ b/drivers/pci/liveupdate.c
> @@ -334,6 +334,11 @@ static int pci_liveupdate_unpreserve_device(struct p=
ci_ser *ser, struct pci_dev
> =20
>  	guard(write_lock)(&dev->liveupdate.lock);
> =20
> +	if (dev->liveupdate.frozen) {
> +		pci_WARN(dev, 1, "Cannot unpreserve device after it is frozen!\n");
> +		return -EINVAL;
> +	}

During preservation rollback, can this check leave a child device preserved
while its parent is not?

If pci_liveupdate_preserve_path() successfully preserves a child device,
but fails to preserve the parent bridge, it attempts to roll back by calling
pci_liveupdate_unpreserve_device() on the child.

If a concurrent system shutdown calls pci_liveupdate_freeze() on the child
device before this rollback occurs, this check will return -EINVAL and
fail the rollback.

Does this result in a broken topology being passed to the incoming kernel?

[ ... ]

> diff --git a/drivers/pci/liveupdate.h b/drivers/pci/liveupdate.h
> index fd7693c7ddd21..30deaa673efed 100644
> --- a/drivers/pci/liveupdate.h
> +++ b/drivers/pci/liveupdate.h
[ ... ]
> @@ -26,6 +27,10 @@ static inline void pci_liveupdate_cleanup_device(struc=
t pci_dev *dev)
>  {
>  }
> =20
> +static inline void pci_liveupdate_freeze(struct pci_dev *dev);
> +{
> +}

Does this stray semicolon after the function signature cause a compilation
error for kernels built without CONFIG_PCI_LIVEUPDATE?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260512184846.1193=
96-1-dmatlack@google.com?part=3D9

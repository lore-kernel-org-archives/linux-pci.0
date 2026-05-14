Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F843F413A
	for <linux-pci@vger.kernel.org>; Thu, 14 May 2026 02:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778724318; cv=none; b=G7IHzb6F7V4JGj+zEP9XS9fWnYqkF8+bHZuqLN+bmub8D1MugE88EWgVP6wVb8/RAip5f4Gz7AXtGzHZMWnTZOepVRAs79DEGFEOyItxJ5n7umqitAsgxaL+UUqsCd9gr4Qf4ouAe6CUduUmHu1944OleoGGJhiB8OiBEqNmPAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778724318; c=relaxed/simple;
	bh=3C90ggiX6ASXJTVXFhexrsmMcpgDXZ2KGpVIbxnsNKI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BVpn3EDTGO1LpdhUBFoDBGdk4Nb8i/EgFpBRLdze+kEo4CZkNrzddsaXIx8j7Dm0GJkOM25MAMB1FuL49thvRSZyenkUsy6rURbuv56gYBm03Ga2f6yfzZY5dznU2YK6mYm1OjS8Adr43iiACRLWolcn7arURcIiVu49NzYF8bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MdP1Ed6B; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MdP1Ed6B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE0DFC19425;
	Thu, 14 May 2026 02:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778724318;
	bh=3C90ggiX6ASXJTVXFhexrsmMcpgDXZ2KGpVIbxnsNKI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=MdP1Ed6BcnBW34Fg6daFKhydOSnHT3kccntYohQQAmU7sDv0jyxAOOE33lEfAbzHO
	 fPfqqbj5A+QZvJ0eApEY+AZEB0QZV7JoOnvVegclepTUA/OD4BYPmvp1gEa2zvm7ra
	 5Ok+iV6IXiY/x+FiZCUUZ//U15KeQQKl7BzyCQAgNmKFuN+xB/hT51Z01sWXo6q7I3
	 UgNekzFwTezkre8xBVvqiGqBt3mRAns8FTZMJDLRszLTjh6j/w8lX2pOB3YrBgXdHl
	 Cr0zAi8192HUQeghpbpRge9wiOu0E0JTfnOEcnjXfdGudJqyANPQrpTMQrRdth/aAm
	 CWPgM2kQPMeog==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 06/11] PCI: liveupdate: Auto-preserve upstream
 bridges across Live Update
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Matlack" <dmatlack@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260512184846.119396-7-dmatlack@google.com>
References: <20260512184846.119396-7-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 02:05:17 +0000
Message-Id: <20260514020517.DE0DFC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Kernel stack overflow via deep recursion in `pci_liveupdate_preser=
ve_path()`.
--

commit 9dcae64241d06ee18edeb26c25b9a7b263aa05a4
Author: David Matlack <dmatlack@google.com>

PCI: liveupdate: Auto-preserve upstream bridges across Live Update

This commit introduces tracking to auto-preserve upstream PCI bridges when a
device is preserved across a Live Update. It adds functions to preserve,
unpreserve, and finish the preservation of devices and recursively applies
these to upstream bridges up to the root port.

> diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
> index 558fbaec8dddd..d8e06afde2c76 100644
> --- a/drivers/pci/liveupdate.c
> +++ b/drivers/pci/liveupdate.c

[ ... ]

> @@ -363,8 +389,82 @@ int pci_liveupdate_preserve(struct pci_dev *dev)

[ ... ]

> +static int pci_liveupdate_preserve_path(struct pci_ser *ser, struct pci_=
dev *dev)
> +{
> +	int ret;
> +
> +	if (!dev)
> +		return 0;
> +
> +	ret =3D pci_liveupdate_preserve_device(ser, dev);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D pci_liveupdate_preserve_path(ser, dev->bus->self);

Can this recursion cause a kernel stack overflow?

The PCI specification allows up to 256 nested buses in a single domain, whi=
ch
can occur with deep Thunderbolt or USB4 topologies.

Because the recursive call to pci_liveupdate_preserve_path() is followed by=
 a
potential call to pci_liveupdate_unpreserve_device(), it cannot be optimized
as a tail call. This forces a new stack frame for every level of the PCI
hierarchy, which could overflow the standard kernel stack, especially with
KASAN enabled, and cause a crash.

Could this be rewritten to use an iterative approach instead?

> +	if (ret) {
> +		pci_liveupdate_unpreserve_device(ser, dev);
> +		return ret;
> +	}
> +
> +	return 0;
> +}

[ ... ]

> +static void pci_liveupdate_unpreserve_path(struct pci_ser *ser, struct p=
ci_dev *dev)
> +{
> +	if (!dev)
> +		return;
> +
> +	if (pci_liveupdate_unpreserve_device(ser, dev))
> +		return;
> +
> +	pci_liveupdate_unpreserve_path(ser, dev->bus->self);

Does this code have the same recursion issue as pci_liveupdate_preserve_pat=
h()
and require an iterative approach?

> +}

[ ... ]

> @@ -519,28 +656,18 @@ void pci_liveupdate_cleanup_device(struct pci_dev *=
dev)

[ ... ]

>  void pci_liveupdate_finish(struct pci_dev *dev)
>  {
> -	guard(write_lock)(&dev->liveupdate.lock);
> -
> -	if (!dev->liveupdate.incoming) {
> -		pci_warn(dev, "Cannot finish preserving an unpreserved device\n");
> +	if (!dev)
>  		return;
> -	}
> -
> -	pci_info(dev, "Device is finished participating in Live Update\n");
> =20
> -	/*
> -	 * Drop the refcount so this device does not get treated as an incoming
> -	 * device again, e.g. in case pci_liveupdate_setup_device() gets called
> -	 * again because the device is hot-plugged.
> -	 */
> -	dev->liveupdate.incoming->refcount =3D 0;
> -	dev->liveupdate.incoming =3D NULL;
> +	if (pci_liveupdate_finish_device(dev))
> +		return;
> =20
> -	/* Drop this device's reference on the incoming FLB. */
> -	pci_liveupdate_flb_put_incoming();
> +	pci_liveupdate_finish(dev->bus->self);

Does this code also have the same recursion issue?

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260512184846.1193=
96-1-dmatlack@google.com?part=3D6

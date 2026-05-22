Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DEF1DE4FB
	for <linux-pci@vger.kernel.org>; Fri, 22 May 2026 21:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779484130; cv=none; b=dUEFfVk+TAkit3LQXr4VLtBiKwhTBfGPnW5IqS8QwNkJrKH506xpb4Hk99Am0xRilkEVvpDlzABJEXCFijjUZNPgROSy8K1PaD0YTYS6M6coPA5JCA+nL2ZRe1kIbMWiBcsWyu/3SbHTKc8mJ/0I1o4LEgLrZLl25pSh/PE6cik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779484130; c=relaxed/simple;
	bh=DRLZgzmSgcPWzwtaY5c3libhrekwE42Zawd0wAyk5eY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Tv+aDn1ywKqEpQSGXt78tmeSKthvosFQffIeHvmPJ+o53tf/Zx8M8gmE67B9KstKhlZc84YPArf2KLm5o5ieYc5wfHMtG0ike/jrgCXBS4VeFuXiFiylRUNWPEifcAwmoLLY6oseEU9XaAkQH/eZGEglX9jg2Ef3Q05z2yNqge8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RPF8dIN8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RPF8dIN8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E4071F000E9;
	Fri, 22 May 2026 21:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779484128;
	bh=+rxlxPzDBH+p5g7K93ZkCi2i0EpG3ksEN6f/HGoZzbE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RPF8dIN8U/QLvV/sStRQJqtwNTvopLGaUvw2Q2W3kv8P+sgBM0mrb1UezmKILk6WQ
	 Nnm+75T4uO5jQu7pMm+W9j4GXtHPkPwCBS46yHZKj2Vbb7X9/4y4CEPTqT7Ir82S8p
	 QfPSFWhZ78IJ1aoNN8U5MGeZZRpFhO5EyDnzhLBzcb0id8E73ZMRnSnVEmp7eQD2Ub
	 XqfAGYhAi3L9wXZ2vK85HuedfZ/cR9W9rCJwHiPD45YyOcJVUqLYG89x1S7SbH3cVp
	 Dovue05x1H3ny+uHwaWaEH6o3nJSHxKu8B017zaprxOwXEiK3tQLE+jmiMvNdnE0G3
	 GMQBSL9TBO/PQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 05/12] PCI: liveupdate: Keep bus numbers constant
 during Live Update
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Matlack" <dmatlack@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260522202410.3104264-6-dmatlack@google.com>
References: <20260522202410.3104264-6-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 22 May 2026 21:08:48 +0000
Message-Id: <20260522210848.6E4071F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Mixing goto-based control flow with scope-based cleanup helpers (`s=
coped_guard`) in the function `pci_liveupdate_scan_bridge_begin`.
--

commit 12ae1f010eb68b0654e38ce2800545f03bf1b835
Author: David Matlack <dmatlack@google.com>

PCI: liveupdate: Keep bus numbers constant during Live Update

During a Live Update, preserved devices must be allowed to continue
performing memory transactions so the kernel cannot change the fabric
topology. To keep bus numbers constant, this patch makes the PCI core
inherit the secondary and subordinate bus numbers assigned to bridges
during scanning if any PCI devices are being preserved.

> --- a/drivers/pci/liveupdate.c
> +++ b/drivers/pci/liveupdate.c
[ ... ]
> +bool pci_liveupdate_scan_bridge_begin(struct pci_bus *bus, struct pci_de=
v *dev,
> +				      int pass)
> +{
> +	struct pci_dev *parent =3D bus->self;
> +
> +	/*
> +	 * On the second pass, reuse the value that was set on the first pass
> +	 * so that the passes are consistent with one another.
> +	 */
> +	if (pass)
> +		return dev->liveupdate.inherit_buses;
> +
> +	/*
> +	 * If the parent bridge is being forced to inherit its bus numbers
> +	 * during this scan then this bridge must as well, otherwise the PCI
> +	 * core could expand this bridge's reservation beyond its parent (which
> +	 * cannot expand).
> +	 */
> +	if (parent && parent->liveupdate.inherit_buses) {
> +		dev->liveupdate.inherit_buses =3D true;
> +		goto out;
> +	}
> +
> +	/*
> +	 * Otherwise, if there are any incoming preserved devices, force the
> +	 * bus numbers to be inherited to avoid changing the bus numbers
> +	 * assigned to those devices during enumeration.
> +	 *
> +	 * To keep things simple, inherit bus numbers on all bridges if any PCI
> +	 * devices are incoming, to ensure that no bridge's reservation is
> +	 * expanded to overlap with a preserved device downstream of a different
> +	 * bridge.
> +	 */
> +	scoped_guard(rwsem_read, &pci_liveupdate.rwsem) {
> +		struct pci_flb_incoming *incoming;
> +
> +		incoming =3D pci_liveupdate_flb_get_incoming();
> +		if (!incoming) {
> +			dev->liveupdate.inherit_buses =3D false;
> +			goto out;

[Severity: Low]
Does this mix goto-based control flow with scope-based cleanup helpers?

According to the cleanup subsystem guidelines, functions should either use
scope-based cleanups or goto-based cleanups, but never both in the same
function.

Could these goto statements be replaced by directly returning the boolean
value instead?

> +		}
> +
> +		/*
> +		 * It is safe to sample incoming->ser->nr_devices and then
> +		 * drop the rwsem since nr_devices will only decrease. Thus the
> +		 * only "race" is that the current scan will be overly
> +		 * conservative and force bus inheritance.
> +		 */
> +		dev->liveupdate.inherit_buses =3D incoming->ser->nr_devices;
> +		pci_liveupdate_flb_put_incoming();
> +	}
> +
> +out:
> +	return dev->liveupdate.inherit_buses;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260522202410.3104=
264-1-dmatlack@google.com?part=3D5

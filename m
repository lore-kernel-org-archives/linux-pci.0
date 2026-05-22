Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C324384CFF
	for <linux-pci@vger.kernel.org>; Fri, 22 May 2026 20:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779483295; cv=none; b=Dhtn+qKiEGOUhW+Ust8bVE6Ga+UrN2eJuiyk2Tgb9oGdoH7GLKJCLw42VOCfxLYFch87Cs2Nf/PZhsrszNWKnuB+DUplZM2WWb3on5Gz6gWHdrJ+Dn7FS6HZvibNd6LuDtSVY1ZO9cl3+vJAAJEf9fNM1d5f1BmL2zU4sCol1Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779483295; c=relaxed/simple;
	bh=FXvQAvpLYOWPgQ+GmPU7zw+DV79e+daSmtLlltp8jFE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RCV75aEXU8LWUlezofqpJqKe/xJ3ZV1XcuTGORrGgezrboY7LjZ/y3co8nUU1EmUDLyasWLFytB7Xb4tkfg3wiXm7DAfGBo32/PtFIfqESdHMgyX4XP6z5Cu8DNaNmkVfdWJZxpeVSxjueCosDBTMdGpIiF2mQ4olpkRnYh7Kfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gh9K+4Ii; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gh9K+4Ii"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F34021F000E9;
	Fri, 22 May 2026 20:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779483294;
	bh=Mmb8N9TYvfVc2lHtaEH26nQOGm9UwUvHN8xhvK76cXE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gh9K+4Iie/dI4dc+Qt3yR6sW0Vn69H3DT6H1X1Lgl7Yv1/XdxwzzSuFBZOxzT6zHg
	 NLlro15JfduC8Kphk5z/YKqcezmXwRblsRcMwDuJVuh6ygWPj0+r2atiMzDZon018P
	 I+rls0XQ6fHbWxlenZZdKh52o+DSuPcDSywYinl7oqC13ZytrayZ5isT++doguU34x
	 hezvIdcqHnxi6tE9SBicEKQ9EI+NkmD2vSM1GzqFRlJRV++mGcWA/SAwdwUTjI9e7H
	 a2H37duItpvd742h1QI+qoOP34riVS6OBryvLFBHOnUz8wmUY7DTm5Z8A8XlCNikB8
	 RD8sIuyg6h9Og==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 02/12] PCI: liveupdate: Track outgoing preserved PCI
 devices
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Matlack" <dmatlack@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260522202410.3104264-3-dmatlack@google.com>
References: <20260522202410.3104264-3-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 22 May 2026 20:54:53 +0000
Message-Id: <20260522205453.F34021F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Acquiring a sleepable rw_semaphore (rwsem_write) during PCI device=
 release, which can occur in atomic contexts.
--

commit 306396f47fee049b9172957aca3ed638cf2241ab
Author: David Matlack <dmatlack@google.com>

PCI: liveupdate: Track outgoing preserved PCI devices

This commit adds APIs to allow drivers to notify the PCI core of which
devices are being preserved across a Live Update for the next kernel.

> diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
> index 737e7b9366dbe..065d5af822f74 100644
> --- a/drivers/pci/liveupdate.c
> +++ b/drivers/pci/liveupdate.c

[ ... ]

> @@ -115,6 +150,138 @@ static struct liveupdate_flb pci_liveupdate_flb =3D=
 {

[ ... ]

> +void pci_liveupdate_unpreserve(struct pci_dev *dev)
> +{
> +	struct pci_ser *ser =3D NULL;
> +
> +	guard(rwsem_write)(&pci_liveupdate.rwsem);
> +
> +	ser =3D pci_liveupdate_flb_get_outgoing();
> +	if (IS_ERR(ser)) {
> +		pci_warn(dev, "Cannot unpreserve device without outgoing Live Update s=
tate\n");
> +		return;
> +	}
> +
> +	pci_liveupdate_unpreserve_device(ser, dev);
> +}
> +EXPORT_SYMBOL_GPL(pci_liveupdate_unpreserve);
> +
> +void pci_liveupdate_cleanup_device(struct pci_dev *dev)
> +{
> +	/*
> +	 * It should be safe to READ_ONCE() outside of the rwsem during cleanup
> +	 * since there should no longer be any references to @dev on the system.
> +	 */
> +	if (READ_ONCE(dev->liveupdate.outgoing)) {
> +		pci_WARN(dev, 1, "Destroying outgoing-preserved device!\n");
> +		pci_liveupdate_unpreserve(dev);

[Severity: High]
Can calling pci_liveupdate_unpreserve() here cause a sleep-in-atomic bug?

pci_liveupdate_unpreserve() unconditionally acquires a sleepable rw_semapho=
re:
guard(rwsem_write)(&pci_liveupdate.rwsem).

Since pci_liveupdate_cleanup_device() is called from pci_release_dev(), this
runs when the last reference to a struct pci_dev is dropped via pci_dev_put=
().

Because pci_dev_put() can be called from atomic contexts (such as hardware
interrupt handlers or while holding spinlocks) to drop references acquired
during lookups, acquiring a sleepable lock here could trigger a
scheduling-while-atomic BUG or deadlock.

> +	}
> +}

[ ... ]

> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index b63cd0c310bc0..b88109a8dfe42 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c

[ ... ]

> @@ -2490,6 +2491,7 @@ static void pci_release_dev(struct device *dev)
> =20
>  	pci_dev =3D to_pci_dev(dev);
>  	pci_release_capabilities(pci_dev);
> +	pci_liveupdate_cleanup_device(pci_dev);
>  	pci_release_of_node(pci_dev);
>  	pcibios_release_device(pci_dev);
>  	pci_bus_put(pci_dev->bus);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260522202410.3104=
264-1-dmatlack@google.com?part=3D2

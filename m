Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A66279DB6
	for <linux-pci@vger.kernel.org>; Wed, 12 Aug 2026 02:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786503574; cv=none; b=VCaFL8XTQfpYtX8/djI6XyqWQErpO7Q0dyWTc6ThZakr0Rj1GObGf3Xo8BawbAUuGPkkQEbzh4i1OfZ63833AUF6zHsnRzl/+b1BqXUM90ep/DbJAqnJ+UVxV5ChPWXNUlFWq6h7MBFOR+JtoeZhCkudD+7lBcIQBVUVD43KTHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786503574; c=relaxed/simple;
	bh=5aux61gaVrfVyaE2ljSkhIFd3PF9VtTaylfbFaZbh6k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=N3ywO5kC817UKlFiV0kvatV8qtZzzgp1UUwdXQFK3mhal6ZZu1lZ25zD7G7UYcSUO1i4OgT8nqfnhQBjB04soQGAVYVI0JzPEj6/a1iVZqWYH1K8La7ey958NZQZ8c/mrWkSOfGNHPnBqI7+Yt1cg3SrqWjiEat5gAvtF5MI5gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GA1sERgh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GA1sERgh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E9DF1F000E9;
	Wed, 12 Aug 2026 02:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786503573;
	bh=CvtCto/+wyFwQVk8tzOvj/zXyHWGpfd9ORGLb1bnQPg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GA1sERghmGNc57qLbu9ZlQH07lTQ4LbMN+/abvmUQbwrgXvCXpVKXwes9u8CKo66o
	 Mlke2Vxbf5LPFizg1DQEdlS3NuX7acm+JYOEe2H2PUqyrTLE0LdNqYJz2QTZIfuK33
	 M/Q3AbOlnP/cZy6q+v7YjmfTxbdT8yydypP5ma0U0XX8y4GRE8e7UnoVrP3XeYE3+N
	 Nwkv/5BAkcJ8OQzVMMx3yEsqo9r1mCwP4u2AFXVeFK0h/e3+lO78iOBLrwxuNYQ7q6
	 pgmzXw9JKSAfKL9NWLnpjgW7wwYYNH5U8n6wc3wgrFJyNhLicl+cfhyKTE3eyDXrZe
	 AWxqUsgrHksow==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: Fix use-after-free race in pci_find_bus()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mohamad Raizudeen" <raizudeen.kerneldev@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260812024713.4958-1-raizudeen.kerneldev@gmail.com>
References: <20260812024713.4958-1-raizudeen.kerneldev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 02:59:32 +0000
Message-Id: <20260812025933.1E9DF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The fundamentally vulnerable pci_find_next_bus() iterator is left =
unmodified, retaining a use-after-free race.
- [High] pci_find_bus() returns a non-refcounted bus pointer after dropping=
 pci_bus_sem, exposing callers to a caller-side use-after-free.
--

--- Patch [1]: [PATCH] PCI: Fix use-after-free race in pci_find_bus() ---
commit 7750909a991524c7f4e93f423648abcd167d3923
Author: Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>

PCI: Fix use-after-free race in pci_find_bus()
   =20
pci_find_bus() iterates over the list of PCI root buses using
pci_find_next_bus(). If a PCI bus is concurrently removed via hotplug
between loop iterations, the from pointer passed back into
pci_find_next_bus() becomes stale. This commit fixes this by iterating
pci_root_buses list directly while holding the pci_bus_sem read lock.

> diff --git a/drivers/pci/search.c b/drivers/pci/search.c
> index e3d3177fce549..f50e83061b769 100644
> --- a/drivers/pci/search.c
> +++ b/drivers/pci/search.c
> @@ -142,17 +142,19 @@ static struct pci_bus *pci_do_find_bus(struct pci_b=
us *bus, unsigned char busnr)
>   */
>  struct pci_bus *pci_find_bus(int domain, int busnr)
>  {
> -	struct pci_bus *bus =3D NULL;
> -	struct pci_bus *tmp_bus;
> +	struct pci_bus *bus;
> +	struct pci_bus *tmp_bus =3D NULL;
> =20
> -	while ((bus =3D pci_find_next_bus(bus)) !=3D NULL)  {

[Severity: High]
This is a pre-existing issue, but while you are removing the use of
pci_find_next_bus() here, the pci_find_next_bus() function itself remains
vulnerable to the same use-after-free race.

Other lockless callers like uncore_die_to_segment() in
arch/x86/events/intel/uncore.c still iterate over buses using
pci_find_next_bus() without holding pci_lock_rescan_remove(). Because
pci_find_next_bus() drops pci_bus_sem before returning, a concurrent PCI
hot-remove can free the bus.=20

When the caller passes the freed bus back into pci_find_next_bus() for the
next iteration, from->node.next is dereferenced, causing a use-after-free.

Should pci_find_next_bus() also be fixed to prevent memory corruption for
other callers?

> -		if (pci_domain_nr(bus) !=3D domain)
> -			continue;
> -		tmp_bus =3D pci_do_find_bus(bus, busnr);
> -		if (tmp_bus)
> -			return tmp_bus;
> +	down_read(&pci_bus_sem);
> +	list_for_each_entry(bus, &pci_root_buses, node) {
> +		if (pci_domain_nr(bus) =3D=3D domain) {
> +			tmp_bus =3D pci_do_find_bus(bus, busnr);
> +			if (tmp_bus)
> +				break;
> +		}
>  	}
> -	return NULL;
> +	up_read(&pci_bus_sem);
> +	return tmp_bus;

[Severity: High]
This is a pre-existing issue, but does this expose the caller to a
use-after-free race?

By dropping pci_bus_sem before returning tmp_bus, the returned bus pointer
is un-refcounted and no longer protected by the lock. If the caller does
not hold pci_lock_rescan_remove(), a concurrent hot-remove thread could
immediately acquire pci_bus_sem for write, remove the bus, and free its
memory before the caller has a chance to safely use it.

Would it be safer to increment the reference count of the returned bus
with pci_bus_get() before releasing pci_bus_sem?

>  }
>  EXPORT_SYMBOL(pci_find_bus);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812024713.4958=
-1-raizudeen.kerneldev@gmail.com?part=3D1

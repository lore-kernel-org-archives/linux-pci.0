Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C01B24468C
	for <linux-pci@vger.kernel.org>; Wed, 23 Sep 2026 13:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790170323; cv=none; b=uh8cFdeRG/sR7BcllxmCxI8DO5MRfVdUqyARn3PMDea0jJSsOvarAkyJccgnslr8VHGKJMKBfIy94t6Kf2Vh/FbPxUEkdCtlCBmR7ojG8kVJZAA5jru3t0P/1aqIU/e9kDD6t5EiAEqRMEPapLeBMGDNvPn7KUkuMpa3k71hPiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790170323; c=relaxed/simple;
	bh=la6O+7O4tzeOom+GowE7jJstGNe2PsqD0tfmQ9LeeDI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=b3ALktXpJ8u3hqNpC/eeWuZSeX3yJj8OVGZ4bWAKo2MvT3Kug0/drAgdRrpCp6+t7ZwtEe9pqHgG24IaZjweysv1cBu0eKNANVP7UPnE5tkgE12WHhPdbAJSqtWbcHW9qxOsQ29bqMQgsWVOfa5ndPxTcjKTte4mwuakD50xe4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BDGQp0Eb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BDGQp0Eb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07DF61F000FF;
	Wed, 23 Sep 2026 13:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790170322;
	bh=TWy4/eiF5hsKS0e62kod/S0oYryxQVQwvWyMtg8YQhM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BDGQp0EbVnOpkOnxtYqz40Vd5fhDAAcQkCBkyPjkhOa7RcfL4+b7XbO8jCi1OoRZm
	 wuTzW8ZvHpwKdZ3Y5Ddzo9eAzSGyGc4q47cnYDOr1XrPz4QJzHipFA0WGiDMjhbi9C
	 h891e72yMOhvagpXwcUUOKxZG86oVjx9tndEC59Ozx6cH8RwyUCcSUOS5bXAVNzdeT
	 WK46oM+qdOiotcRIt8B/Jfe7Vs2wgJOYjkQuFmxfR1+UPYzjPFhW89jlHAGDIKssDN
	 Qfq9iAqTJgFFDZT/I6UbNQXx5gQD4K4i3SNBcNnMsmtDwlLQblVDvg7b8hMYxBz6VN
	 VEXYkYNjeNhBw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/5] PCI: Fix nesting windows with remainder at the left
 edge
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260923131757.7792-3-ilpo.jarvinen@linux.intel.com>
References: <20260923131757.7792-1-ilpo.jarvinen@linux.intel.com>
 <20260923131757.7792-3-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 13:32:01 +0000
Message-Id: <20260923133202.07DF61F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] pci: __pci_assign_resource assigns address bound min to alignment
- [High] pci: pci_resreq_check incorrectly shifts normal BARs out of alignm=
ent
--

commit 5024064a0f2ceedd425ef93754ec9f56cae0112c
Author: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

PCI: Fix nesting windows with remainder at the left edge

This commit attempts to fix a bridge window assignment failure in nested
topologies where the non-aligning remainder sits at the left edge. It
introduces pci_resreq_check() to wrap pcibios_align_resource() and recalcul=
ate
the start address if there are constraints, bypassing standard alignment ch=
ecks.

Fixes: 9036bd0efcb6 ("PCI: Align head space better")

> diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
> index 376f09630a4ab..eacce9e2486bf 100644
> --- a/drivers/pci/setup-res.c
> +++ b/drivers/pci/setup-res.c

[ ... ]

> @@ -311,15 +326,54 @@ resource_size_t __weak pcibios_align_resource(void =
*data,
>  	return pci_align_resource(dev, res, empty_res, size, align);
>  }
> =20
> +struct pci_resreq_data {
> +	struct pci_dev *dev;
> +	resource_size_t real_align;
> +};
> +
> +static resource_size_t pci_resreq_check(void *data,
> +					const struct resource *res,
> +					const struct resource *empty_res,
> +					resource_size_t size,
> +					resource_size_t min_align)
> +{
> +	struct pci_resreq_data *rr =3D data;
> +	resource_size_t align =3D rr->real_align;
> +	resource_size_t remainder, start;
> +	struct resource tmp =3D *res;
> +
> +	if (res->flags & IORESOURCE_MEM && !IS_ALIGNED(res->start, align)) {
> +		resource_set_range(&tmp, ALIGN(res->start, align), size);
> +		if (!__resource_contains_unbound(empty_res, &tmp)) {
> +			remainder =3D pci_resreq_remainder(size, align);
> +			resource_set_range(&tmp, tmp.start - remainder, size);

[Severity: High]
Does this subtraction incorrectly shift normal device BARs out of alignment?

When a user overrides alignment via the pci=3Dresource_alignment=3D paramet=
er,
the requested alignment can be much larger than the size, resulting in a
non-zero remainder. For normal device BARs, subtracting this remainder shif=
ts
the start address out of the requested alignment boundaries.

Could this silent violation of user alignment requests break use cases like
VFIO pass-through that rely on IOMMU page alignment to isolate device memor=
y?

> +			if (!__resource_contains_unbound(empty_res, &tmp))
> +				return tmp.start;	/* caller skips range */
> +		}
> +	}
> +
> +	start =3D pcibios_align_resource(rr->dev, &tmp, empty_res, size, align);
> +	WARN_ON_ONCE(!IS_ALIGNED(start, min_align));
> +
> +	return start;
> +}
> +
>  static int __pci_assign_resource(struct pci_bus *bus, struct pci_dev *de=
v,
>  		int resno, resource_size_t size, resource_size_t align)
>  {
> +	struct pci_resreq_data rr =3D { .dev =3D dev, .real_align =3D align };
>  	struct resource *res =3D pci_resource_n(dev, resno);
>  	resource_size_t min;
>  	int ret;
> =20
>  	min =3D (res->flags & IORESOURCE_IO) ? PCIBIOS_MIN_IO : PCIBIOS_MIN_MEM;
> =20
> +	if ((res->flags & IORESOURCE_MEM) && pci_resreq_remainder(size, align))=
 {
> +		align =3D min;
> +		if (pci_resource_is_bridge_win(resno))
> +			align =3D pci_min_window_alignment(bus, res->flags);
> +	}

[Severity: High]
Can this logic unintentionally catch normal device BARs with overridden
alignments and cause resource allocation to fail?

If pci=3Dresource_alignment=3D is used, pci_resreq_remainder() evaluates to
non-zero for a normal device BAR. This block is then entered and align is
overwritten with min (which is PCIBIOS_MIN_MEM).

On architectures where PCIBIOS_MIN_MEM is 0 (like ARM64), this destroys the
original alignment constraint and assigns an alignment of 0. Passing a 0
alignment to allocate_resource() causes ALIGN(x, 0) to evaluate to 0, which
can trigger a catastrophic allocation failure.

Should this condition specifically check if the resource is a bridge window
before proceeding?

> +
>  	/*
>  	 * First, try exact prefetching match.  Even if a 64-bit
>  	 * prefetchable bridge window is below 4GB, we can't put a 32-bit

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923131757.7792=
-1-ilpo.jarvinen@linux.intel.com?part=3D2

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793613754;
	b=z3Ki4+nn+BFZNqtu2j/ipSdxspiXV9nvTo3caNEcmB35xo0Jrhpaou8mFRNfDy/NThj9
	 YjOzlPoLDjv5r/XDkm9LSOjfpZUHwFtBD82ZkeIWdt76fOZmeuiW9uGbNpg9FLiz2Tj51
	 wgimH3EvGyASZC3ZXqH5jk3rkzOgiqkfKxS+S3T2uQXj2Z90a+rfWVHzFLdAL4zSFs6/D
	 uPX8OkNWQIYIeTUbkDiqGTcL9U71bjr0XXnnrnc9Su39YREoBlqi+DAGfgiLAD0U85GVF
	 MLbvMXSn8hO+9FIABzUl0+fztHbRPgxzfpdQ4VcJo5U6m3wkzEvOoGKlWV+dghbCo6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793613754;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=83Fyps+JO9OEKzkar4ZihDcVi9SGIHIM95f4QH0WYGE=;
	b=YTR6M0tDAxe/7jX7eqNSEW5ut8d/HNC1ov3mhFzAsS64WHSmWfguqUA4XzqlU0R21dy+
	 uiJgvvrneVRTWOxP04DQw6pJ3PyU2mrP0fOmjIvi3Z0NH9tgiALqfwH5mSv5LoN66CKbP
	 rDtbF4OBrzWr8+TCjmKS6uorpgASlUwoQ1D1v9yDj1xN3lb1ZwJP3sL7EN7Db6CZvcjWM
	 qXrakdXJwpILtvuwNwxGM/XSy8LRHLa5SbrQT8oAcaQq81ALCEfMJZtw11tOqfgXnSUSu
	 ZNnqykdCGOyTXy1QFe8OPkL6X1STJXgzkzABJ0f0QrE5pMJDS92p+UVn71aS6XQBhsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mgzc2MZ9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3342E606A330;
	Mon,  2 Nov 2026 10:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mgzc2MZ9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81E241F00919;
	Mon,  2 Nov 2026 10:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793613753;
	bh=83Fyps+JO9OEKzkar4ZihDcVi9SGIHIM95f4QH0WYGE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Mgzc2MZ9GwhMO21kH8kEFbfK8V8g7uTEBotZDbw/o6vZrG/hU1fYKi3d0geHoco2V
	 Z/tEg6HC2hRe5p17jeob/5mFjTUNjH4nuHKWkKGSYvE4YAWh9NDqv/HLuNb2Vkw3rQ
	 V8+edoCoDkDI3KzAapF9ylblrhUgU/cGvxameRdKr7a/uIw6VJ8lTuSsfMmSZCegLv
	 +hYIzVdzNyGOnOyftLasWfzHWZifSTJkRdR3E3Za1y9fY7kvp7d56qQv5y3ufZaorq
	 7/R9+oPjSnef/g03KiQe3CemFrxBaVn1Oitl6X5U0nU7FcpJw6aDIitS2YZ6D4oYWV
	 66JrJvTrFa7Lg==
Message-ID: <sashiko-outbox-193230@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] PCI: Allow reusing PCI domain numbers in DT
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cui Chao" <cuichao1753@phytium.com.cn>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261102095150.2370959-3-cuichao1753@phytium.com.cn>
References: <20261102095150.2370959-1-cuichao1753@phytium.com.cn>
 <20261102095150.2370959-3-cuichao1753@phytium.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 10:02:33 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] PCI: NULL pointer dereference in of_pci_bus_release_domain_nr()
- [Medium] PCI: dynamic domain ID leak in of_pci_bus_release_domain_nr()
- [Medium] PCI: uniqueness check bypassed in of_pci_bus_find_domain_nr()
--

commit 6f168ee04fb909d8010153d5588cf34c9e1e6db6
Author: Cui Chao <cuichao1753@phytium.com.cn>

PCI: Allow reusing PCI domain numbers in DT

This commit adds support for the linux,pci-domain-reuse Device Tree property
to allow multiple PCIe host bridges with disjoint physical resources to sha=
re
the same static linux,pci-domain number.

> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index b2879a6be5f80..9cb3132673f86 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -6738,13 +6738,19 @@ static int of_pci_bus_find_domain_nr(struct devic=
e *parent)
>  		/*
>  		 * If domain is in DT, allocate it in static IDA.  This
>  		 * prevents duplicate static allocations in case of errors
> -		 * in DT.
> +		 * in DT. Platform that legitimately reuse a domain number
> +		 * across host bridges (disjoint ECAM/bus/memory/IO) opt out
> +		 * of this check with "linux,pci-domain-reuse".
>  		 */
>  		domain_nr =3D of_get_pci_domain_nr(parent->of_node);
> -		if (domain_nr >=3D 0)
> +		if (domain_nr >=3D 0) {
> +			if (of_property_read_bool(parent->of_node,
> +							"linux,pci-domain-reuse"))
> +				return domain_nr;
>  			return ida_alloc_range(&pci_domain_nr_static_ida,
>  					       domain_nr, domain_nr,
>  					       GFP_KERNEL);
> +		}
>  	}

[Severity: Medium]
The commit message states that for a PCI node that does not declare
linux,pci-domain-reuse, the original uniqueness check remains in place, and
that each RC node participating in reuse declares linux,pci-domain-reuse.

In drivers/pci/pci.c:of_pci_bus_find_domain_nr(), returning domain_nr
directly without recording or checking anything in pci_domain_nr_static_ida
means that if one host bridge declares linux,pci-domain =3D <0> with
linux,pci-domain-reuse and a second host bridge declares
linux,pci-domain =3D <0> without linux,pci-domain-reuse, both host bridges
succeed regardless of probe order.

If the reusing bridge probes first, domain 0 is never allocated in
pci_domain_nr_static_ida, so the non-reusing bridge's call to
ida_alloc_range(&pci_domain_nr_static_ida, 0, 0, GFP_KERNEL) succeeds. If t=
he
non-reusing bridge probes first, it allocates domain 0 in
pci_domain_nr_static_ida, and the reusing bridge then bypasses
pci_domain_nr_static_ida completely.

Doesn't this allow a host bridge without linux,pci-domain-reuse to silently
share its domain number with another bridge?

> =20
>  	/*
> @@ -6761,6 +6767,10 @@ static void of_pci_bus_release_domain_nr(struct de=
vice *parent, int domain_nr)
>  	if (domain_nr < 0)
>  		return;
> =20
> +	/* Reusers never acquire the static slot, so never release it */
> +	if (of_property_read_bool(parent->of_node, "linux,pci-domain-reuse"))
> +		return;
> +
>  	/* Release domain from IDA where it was allocated. */
>  	if (parent && of_get_pci_domain_nr(parent->of_node) =3D=3D domain_nr)
>  		ida_free(&pci_domain_nr_static_ida, domain_nr);

[Severity: High]
Can this dereference a NULL parent pointer in
drivers/pci/pci.c:of_pci_bus_release_domain_nr()?

When a root bus is created without a parent device (for example via
pci_create_root_bus(NULL, ...) or pci_scan_bus()), of_pci_bus_find_domain_n=
r()
checks if (parent) and allocates a dynamic domain number from
pci_domain_nr_dynamic_ida.

If pci_register_host_bridge() fails and unwinds, or when
pci_remove_root_bus() tears down the bus:

pci_register_host_bridge() / pci_remove_root_bus()
  pci_bus_release_domain_nr(NULL, bus->domain_nr)
    of_pci_bus_release_domain_nr(NULL, domain_nr)

Evaluating parent->of_node in of_property_read_bool(parent->of_node, ...)
happens before the existing if (parent && ...) check below (which was added=
 in
commit f7245901de89 ("PCI: Avoid NULL dereference in
of_pci_bus_release_domain_nr()")), causing a NULL pointer dereference.

[Severity: Medium]
Also in drivers/pci/pci.c:of_pci_bus_release_domain_nr(), does returning ea=
rly
on linux,pci-domain-reuse before checking of_get_pci_domain_nr(parent->of_n=
ode)
=3D=3D domain_nr leak a dynamic domain ID from pci_domain_nr_dynamic_ida?

In drivers/pci/pci.c:of_pci_bus_find_domain_nr():

	if (parent) {
		domain_nr =3D of_get_pci_domain_nr(parent->of_node);
		if (domain_nr >=3D 0) {
			if (of_property_read_bool(parent->of_node,
							"linux,pci-domain-reuse"))
				return domain_nr;
			...
		}
	}
	return ida_alloc(&pci_domain_nr_dynamic_ida, GFP_KERNEL);

If a DT node specifies linux,pci-domain-reuse without a valid
linux,pci-domain property (so domain_nr < 0), of_pci_bus_find_domain_nr()
falls through and allocates domain_nr from pci_domain_nr_dynamic_ida.

When of_pci_bus_release_domain_nr() is later called on error or removal,
checking of_property_read_bool(parent->of_node, "linux,pci-domain-reuse")
before verifying that domain_nr came from of_get_pci_domain_nr(parent->of_n=
ode)
returns early instead of freeing domain_nr from pci_domain_nr_dynamic_ida in
the else branch:

	if (parent && of_get_pci_domain_nr(parent->of_node) =3D=3D domain_nr) {
		if (!of_property_read_bool(parent->of_node,
					   "linux,pci-domain-reuse"))
			ida_free(&pci_domain_nr_static_ida, domain_nr);
	} else {
		ida_free(&pci_domain_nr_dynamic_ida, domain_nr);
	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102095150.2370=
959-1-cuichao1753@phytium.com.cn?part=3D2

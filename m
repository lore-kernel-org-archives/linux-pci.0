Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30304A441D;
	Fri,  4 Sep 2026 13:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788530396; cv=none; b=WgXJ2ir6rWHAvVy7ZOGxjwV44mJ7K5I3SNJzhIJO+ao/1tLPkkhqNMMr11tnj9KnqkLxwUHsrI2zO1YFHfZwxVFQh2trClOCBttM5HxRo7EHHF2NfmlnRA4Ddh9KZFRyvuNb5N+o4dTvXwNJtVQNvIC7aprYpVVbUTnWKZp6uxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788530396; c=relaxed/simple;
	bh=rKF+/f8zNT/Szj7OLx7evEnULTOtSqjnNRF4F17lULY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GqWazy93z4CtZEIPn7K3Yafxa7T7b8TOkypU0ufy3/TdJ8eLtjTROlGoPULcXQcPSVXO1nB4Ho4Yvi2tmShft1a3XvYRsbXdP3feXV+gTjB33raCQWtzQJFKv4HpC9dXRUfuqTwKz1dIBw/0F/j9/ku1YANVafD/WZXNPB7+psM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cO3O7raZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cO3O7raZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 696FA1F00A3D;
	Fri,  4 Sep 2026 13:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788530394;
	bh=fiyO5GJdcNOHKmIRsdxwo/k6BvXnViOgC9z0tD/jcZg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cO3O7raZW21NLHx7RWxXYgSApokRdTkuKfn7XOuUqE0oXGORBoqtnujqn/vODZTcq
	 n409XChCxYx0oRVvg/XOaTnqU3eLkc0r0B4RE7ReXA52c+M1MUL2RBVTq/biax7KjB
	 3Wy/x3X0FkwhmYY8d6JRwNMYuXtHfEIPiGY29u/EdomJhPvNtDu+BpjTHFY3bNzfTu
	 rZU0EUIMIHQ7c9THKQBAkex765Lv0z2UpH6hw7T7/GEMQraULVByhavaVU+SrQXI5l
	 rmJWgaV6omgw3F/jRuS5ZfJIYdCQfc5WTP9/W+rLc/avDAMSsvQFp2dXKDUlkmobgi
	 I28oKJnIPqEvg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/4] PCI: of: avoid allocations in
 of_pci_prop_compatible()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alex Elder" <elder@riscstar.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260904134607.1856121-2-elder@riscstar.com>
References: <20260904134607.1856121-1-elder@riscstar.com>
 <20260904134607.1856121-2-elder@riscstar.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 13:59:54 +0000
Message-Id: <20260904135954.696FA1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The local variable `bufp` is incorrectly declared as `char` instea=
d of `char *`. This truncates the stack array pointer `buf` to an 8-bit int=
eger, leading to severe memory corruption and an immediate kernel panic dur=
ing runtime.
- [Low] The local variable `i` is declared but never used after the patch.
--

commit 0153310b625600febac7ea5aec9fbd9871d0af03
Author: Alex Elder <elder@riscstar.com>

PCI: of: avoid allocations in of_pci_prop_compatible()

This patch replaces dynamic allocations for three compatible strings with a
single stack-allocated buffer. This avoids subsequent kernel crashes where
allocation failures would unconditionally trigger strlen() during device tr=
ee
properties initialization.

Link: https://lore.kernel.org/sashiko-reviews/a647bd56-7dc8-4fec-9d96-83462=
2054cdf@riscstar.com

> diff --git a/drivers/pci/of_property.c b/drivers/pci/of_property.c
> --- a/drivers/pci/of_property.c
> +++ b/drivers/pci/of_property.c
[ ... ]
>  static int of_pci_prop_compatible(struct pci_dev *pdev,
>  				  struct of_changeset *ocs,
>  				  struct device_node *np)
>  {
>  	const char *compat_strs[PROP_COMPAT_NUM] =3D { 0 };
> +	char buf[PROP_COMPAT_NUM * PROP_SIZE] =3D { };
> +	char bufp =3D buf;

[Severity: High]
Does this incorrectly declare bufp as a single char instead of a pointer?
Assigning the array address buf to an 8-bit char truncates the memory addre=
ss.

>  	int i, ret;

[Severity: Low]
Is the variable i still needed here? The loop that used it to free the
allocated strings was removed by this patch, which will leave this as an
unused variable and cause a compiler warning.

> -	compat_strs[PROP_COMPAT_PCI_VVVV_DDDD] =3D
> -		kasprintf(GFP_KERNEL, "pci%x,%x", pdev->vendor, pdev->device);
> -	compat_strs[PROP_COMPAT_PCICLASS_CCSSPP] =3D
> -		kasprintf(GFP_KERNEL, "pciclass,%06x", pdev->class);
> -	compat_strs[PROP_COMPAT_PCICLASS_CCSS] =3D
> -		kasprintf(GFP_KERNEL, "pciclass,%04x", pdev->class >> 8);
> +	ret =3D snprintf(bufp, PROP_SIZE, "pci%x,%x", pdev->vendor, pdev->devic=
e);

[Severity: High]
Will this snprintf call trigger a kernel panic upon dereference? Because bu=
fp
is truncated to an 8-bit integer, passing it as the output buffer pointer to
snprintf() will result in an out-of-bounds memory access (unmapped low-memo=
ry
dereference) when evaluated during system boot or PCI device enumeration.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904134607.1856=
121-1-elder@riscstar.com?part=3D1

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793118081;
	b=AvXITtRaizLaGPztBdVC/s3ieJDlyYYfk5Ps/gTt8pE5AkQpHBFEz6kKX+pHspAu1Mln
	 3Ru7ZiPpGvBOEcbDp4G1ETNZ0rHCZLopybyIL7btGyAFlCsti8GFVTEwlwq3N17StAl/N
	 L/z1YXIEiaZ1eiu4AavVtr53u66cCK7km2FwN5gsD2uLRujwxFF4vzEw2WlJFb1+XfKDo
	 DvAgosoQmBVL61eXywG822/id9EjU8EQuE4L7viYrFp289f8GhSe/vS1TZj29RkZNxjlS
	 +jp1ReGsOzt6GcoTmCfzdhXJgAhNMk3QPgwA1/j9BthsGR/2Q28P6C+XbDwhxqvx8mw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793118081;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=tQvgeREBqB70/KpgxjbCymWJ93hYloOqCsuv57LILK0=;
	b=nZtHmkcRvNgkOGptbstl39q9iBE8XWUgsmLUKlgQoWu4kj33v6Zm3++fXgYvWQOGKdIC
	 r/I/z3Ca2VVI6WcKbvbZxEUSRlKCwWWZdenhyOe79wSeU0iGnhSExPRg8rkchXljqnY+v
	 ftIRA3RcmyMCBT11EhnVHDyPQ/PgsFlVpFgk+XQI1z6RH+TSjYiFp/sFfxGJxnEwPleW+
	 zDU9l+oAINNT7Vuz60kpHhlCKbVb77Kf4SABC+kZw7HG8k+B+j46ojkw9qQySHrGrxWed
	 TwVuc9jCit5Q+l7atSodhfYx7TYTgCW9Pmx/nIkVWQuucpsI4D+VLKeqOTpNu+6CLhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AQ069AOw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D29606A31A
	for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2026 16:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AQ069AOw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECC4A1F01829;
	Tue, 27 Oct 2026 16:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793118081;
	bh=tQvgeREBqB70/KpgxjbCymWJ93hYloOqCsuv57LILK0=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=AQ069AOw6aYkMZ3rPvIWnk3XXhpw8AZ3KKErgwL7PZVReM3V6dRaROqLqPZuOKCgd
	 ZA0nzJadraQqonBDe0ZzmK9pNqdliZabIj4ifGCvlEPI0jmoVAgaTl+2FkgcaMp85B
	 f0sisdbq3GpjcaKIFlT0fQ8BdI/+jcGnW7QFz6BfbrL4p5coG4RfsNETQiM9XX0d1n
	 kJaDSWgCQEda8KD66EGTeHB7BKNGpAZWVqjn1OitLmM/s811E12X4WXAVqyANeWF3s
	 nkQilFJ3U7Mxn+rc4gu1nwAV2KEZ2nGm3N01EFvEx8aGXbZv4Ul/0Fjt/9cnY/bzIi
	 8M7KgZWngEeRg==
Message-ID: <sashiko-outbox-186901@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 02/13] PCI/IOV: Introduce VF iterators
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lukasz Laguna" <lukasz.laguna@intel.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261027160446.858300-3-lukasz.laguna@intel.com>
References: <20261027160446.858300-1-lukasz.laguna@intel.com>
 <20261027160446.858300-3-lukasz.laguna@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 16:21:20 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] PCI/IOV: divide by zero in pci_get_vf() when PF VF stride is zero
--

commit a822ae2dea34f9ae5ccc5c50cffaa927173aa6ac
Author: Lukasz Laguna <lukasz.laguna@intel.com>

PCI/IOV: Introduce VF iterators

This commit introduces pci_get_vf() and pci_get_vf_reverse() along with
for_each_pci_vf(), for_each_pci_vf_reverse(), and
for_each_pci_vf_continue_reverse() macros to iterate over the enabled VFs
of a PF.

> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> index f6e74847df72c..da895e7f2683e 100644
> --- a/drivers/pci/iov.c
> +++ b/drivers/pci/iov.c
> @@ -70,6 +70,69 @@ struct pci_dev *pci_iov_get_virtfn(struct pci_dev *dev=
, int id)
>  }
>  EXPORT_SYMBOL_GPL(pci_iov_get_virtfn);
> =20
> +/**
> + * pci_get_vf() - Return the first or next existing VF of a PF
> + * @dev: PCI PF whose VFs are being iterated
> + * @from: Previous VF returned by this function, or %NULL to return the =
first VF
> + *
> + * Iterate over existing VFs of @dev in ascending VF ID order, skipping =
VF IDs
> + * with no device present. If a VF is found, its reference count is incr=
emented.
> + * A new iteration is started by passing %NULL as the @from argument. Ot=
herwise,
> + * iteration continues after @from, and the reference count on @from is
> + * decremented.
> + *
> + * Return: a pointer to the first or next VF, or %NULL if no further VF =
is found.
> + */
> +struct pci_dev *pci_get_vf(struct pci_dev *dev, struct pci_dev *from)
> +{
> +	int id =3D 0;
> +
> +	if (from) {
> +		id =3D pci_iov_vf_id(from) + 1;
> +		pci_dev_put(from);
> +	}
> +
> +	for (; id < pci_num_vf(dev); id++) {
> +		from =3D pci_iov_get_virtfn(dev, id);
> +		if (from)
> +			return from;
> +	}
> +
> +	return NULL;
> +}
> +EXPORT_SYMBOL_GPL(pci_get_vf);
> +
> +/**
> + * pci_get_vf_reverse() - Return the last or previous existing VF of a PF
> + * @dev: PCI PF whose VFs are being iterated
> + * @from: Previous VF returned by this function, or %NULL to return the =
last VF
> + *
> + * Same semantics as pci_get_vf(), except iteration proceeds in descendi=
ng VF
> + * ID order.
> + *
> + * Return: a pointer to the last or previous VF, or %NULL if no further =
VF is
> + * found.
> + */
> +struct pci_dev *pci_get_vf_reverse(struct pci_dev *dev, struct pci_dev *=
from)
> +{
> +	int id =3D pci_num_vf(dev);
> +
> +	if (from) {
> +		id =3D pci_iov_vf_id(from);
> +		pci_dev_put(from);
> +	}

[Severity: High]
Can pci_get_vf() and pci_get_vf_reverse() trigger a divide-by-zero when
iterating over a PF whose SR-IOV VF stride (pf->sriov->stride) is 0?

In drivers/pci/iov.c, compute_max_vf_buses() validates offset and stride,
explicitly permitting iov->stride =3D=3D 0 when nr_virtfn =3D=3D 1 (per com=
mit
ea9a8854161d, "allow numVF=3D=3D1 && stride=3D=3D0"):

drivers/pci/iov.c:compute_max_vf_buses() {
    ...
	for (nr_virtfn =3D iov->total_VFs; nr_virtfn; nr_virtfn--) {
		pci_iov_set_numvfs(dev, nr_virtfn);
		if (!iov->offset || (nr_virtfn > 1 && !iov->stride)) {
			rc =3D -EIO;
			goto out;
		}
    ...
}

When SR-IOV is enabled with nr_virtfn =3D=3D 1 on a device reporting stride=
 =3D=3D 0,
sriov_enable() -> pci_iov_add_virtfn(dev, 0) succeeds because
pci_iov_virtfn_bus(dev, 0) and pci_iov_virtfn_devfn(dev, 0) multiply
dev->sriov->stride by 0, creating VF 0 with pf->sriov->stride =3D=3D 0.

When iterating via for_each_pci_vf() or for_each_pci_vf_reverse(), the first
call with from =3D=3D NULL looks up VF 0 via pci_iov_get_virtfn(dev, 0) and
returns it. On the subsequent step to advance past VF 0 and terminate the
loop, pci_get_vf() and pci_get_vf_reverse() call pci_iov_vf_id(from), which
divides unconditionally by pf->sriov->stride:

drivers/pci/iov.c:pci_iov_vf_id() {
    ...
	pf =3D pci_physfn(dev);
	return (pci_dev_id(dev) - (pci_dev_id(pf) + pf->sriov->offset)) /
	       pf->sriov->stride;
}

A similar division by zero can also occur if NumVFs was reset to 0 via
pci_iov_set_numvfs(dev, 0), which re-reads PCI_SRIOV_VF_STRIDE while
NumVFs =3D=3D 0.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027160446.8583=
00-1-lukasz.laguna@intel.com?part=3D2

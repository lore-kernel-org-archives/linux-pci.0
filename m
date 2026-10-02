Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137D7492199
	for <linux-pci@vger.kernel.org>; Fri,  2 Oct 2026 11:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790941783; cv=none; b=m/EtuPNBTVfsiXWWtg5KVQCPcjCe5ooIitiiDASQEQIx5ihLcaxcpkrV9iXjvr95E9b0yvOadefC4Ic6fkuEUDW/Lh7iKThV1CybdEkZZ9Em1sQBIAVjwywhybaM+r6bK8G0kNcBpSTzewy1UWYPKmrxCQYDsMjR3mte4wKjtQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790941783; c=relaxed/simple;
	bh=a2B9JDbSazvDACc32j3LeDZPsqCvz7OmIao/w8m1llI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WWJcpgXjtjL4qgMJhtkCCIQfmtGbVggyMZtAVzbABBDvd3a9zepdagXTOK8qRs/b94QO7jSYw9xuP4R3P27C9bDHYorkcaAdvG8kuKTKo9L0SXq7VeNllMOQUpuX96T6Uu1a5ehZ2AhXn4I2utSPrO7wZlPQZAmekehdeNeVB40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YEcNIxcI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YEcNIxcI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B6CE1F000FF;
	Fri,  2 Oct 2026 11:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790941780;
	bh=UK90ShrRXd2QL2PxPL4IaGENXrV3kz0MwijSBNAuHGw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YEcNIxcIok6PLZ2ljTngF7uPIfJCv0mYaC4D0zNequPYTXNEjmufkWTWSvK178mmo
	 iLvzFauqbuenHWchs/qqufn/dW9ZekEpno1YOkT+kXkWuUesYdHW0kuD8JLiYJDKxo
	 0DLX5m0nc/iEdzSnNEZJaukGziwlvhICvnE7eWYFU//JrSlV9MJEisLytA+WIIxyw9
	 PpClaIpx22ZniWekb63GvoHFgTrkX+YY7KKdDWKxisde+qPXBXj8zozDb0isL8k3a/
	 MGGk61YhIuw1bYsURY5nInnzwe6oJxlSoHdsFFkG6X6iiH+aaPtsezClKdd5GEUJ87
	 HRqoEs4Nx6yoQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/7] PCI: Honor alignment overrides
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>
Cc: intel-gfx@lists.freedesktop.org, linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20261002113319.6652-4-ilpo.jarvinen@linux.intel.com>
References: <20261002113319.6652-1-ilpo.jarvinen@linux.intel.com>
 <20261002113319.6652-4-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 11:49:39 +0000
Message-Id: <20261002114940.9B6CE1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] pci: pci_init_pci_resreq_data() confuses default alignment with =
user override
--

commit 9d8429783cc0cbfe47ed3509438a7591dc940ce5
Author: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

PCI: Honor alignment overrides

This commit introduces struct pci_resreq_data to hold device and user-given
alignment information so that pci_align_resource() can honor the
pci=3Dresource_alignment argument. When a user-given alignment is found, any
remainder movement is skipped to avoid violating the requested alignment.

Link: https://lore.kernel.org/linux-pci/20260923133202.07DF61F000FF@smtp.ke=
rnel.org/

[ ... ]

> diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
> index 376f09630a4ab..441a62807719d 100644
> --- a/drivers/pci/setup-res.c
> +++ b/drivers/pci/setup-res.c
> @@ -265,17 +265,21 @@ resource_size_t pci_resource_alignment(const struct=
 pci_dev *dev,
>   * before res->start if there's enough free space there. This enables
>   * tighter packing for resources.
>   */
> -resource_size_t pci_align_resource(struct pci_dev *dev,
> +resource_size_t pci_align_resource(struct pci_resreq_data *rr,
>  				   const struct resource *res,
>  				   const struct resource *empty_res,
>  				   resource_size_t size,
>  				   resource_size_t align)
>  {
> +	struct pci_dev *dev =3D rr->dev;
>  	resource_size_t remainder, start_addr;
> =20
>  	if (!(res->flags & IORESOURCE_MEM))
>  		return res->start;
> =20
> +	if (rr->user_align)
> +		return res->start;
> +
[Severity: Medium]
Does this inadvertently skip remainder movement for all devices on platforms
with non-zero default alignments?

On platforms where pcibios_default_alignment() returns a non-zero value
(such as PowerPC), rr->user_align might be populated with that default
rather than specifically a user-requested override. If this condition
evaluates as true for those defaults, it appears it would entirely disable
the remainder movement logic and limit PCI resource packing efficiency acro=
ss
the platform.

Note that follow-up modifications to this condition (such as checking if the
index is 1 or 3) would still incorrectly trigger based on a default alignme=
nt
if the distinction between user overrides and defaults is lost.

[ ... ]

> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index d31a8d107b1ef..fe0233f0d9e6e 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1217,12 +1217,34 @@ int __must_check pcibios_enable_device(struct pci=
_dev *, int mask);
>  /* Architecture-specific versions may override this (weak) */
>  char *pcibios_setup(char *str);
> =20
> -/* Used only when drivers/pci/setup.c is used */
> +/* Resource assignment request handling */
> +/**
> + * struct pci_resreq_data - Data passed to pcibios_align_resource()
> + * @dev: PCI device
> + * @user_align: User provided alignment override (pci=3Dresource_alignme=
nt param)
> + */
> +struct pci_resreq_data {
> +	struct pci_dev *dev;
> +	resource_size_t user_align;
> +};
> +
> +resource_size_t pci_specified_resource_alignment(struct pci_dev *dev,
> +						 bool *resize);
> +static inline void pci_init_pci_resreq_data(struct pci_resreq_data *rr,
> +					    struct pci_dev *dev)
> +{
> +	bool user_aligned;
> +
> +	memset(rr, 0, sizeof(*rr));
> +	rr->dev =3D dev;
> +	rr->user_align =3D pci_specified_resource_alignment(dev, &user_aligned);
> +}
> +
[Severity: Medium]
Does this initialize rr->user_align with the returned alignment size while
ignoring the boolean flag that indicates if it was actually requested by
the user?

Looking at pci_specified_resource_alignment() in drivers/pci/pci.c, it
falls back to pcibios_default_alignment() if no user override matches. The
user_aligned flag is set to true only when a specific override is found.
Because the return value is assigned directly to rr->user_align, it seems
struct pci_resreq_data cannot differentiate between a default alignment and=
 an
actual user override.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002113319.6652=
-1-ilpo.jarvinen@linux.intel.com?part=3D3

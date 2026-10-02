Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B205347C0F2
	for <linux-pci@vger.kernel.org>; Fri,  2 Oct 2026 11:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790941429; cv=none; b=SnVZGf8zdqVNgVu/GRJSo4vHBogibG0YTtU6xuY8J4ImXItbEEi4NTv5gS6xLA3a/lhl28wexMz7VLz8ZAAKT2umBtcIJSqp/CY9RzlznCGeKFDq6aPrmSdWZne+ePff4NoJaVrbORrifsGGWWD+KXNHf1/zB6FKmETeZLxpXPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790941429; c=relaxed/simple;
	bh=FOww3dELPBWT58h8aZinlNSqrFDjBOZNCccWQGgetys=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tIo+r2Og9PEAPOgiDX05eAEwwmexMGDsUGTcQfsIwUJXkcZvDKgv968raS/m9oyX8SbLlNfW4umHpP+fnjy4saiqev08afnyJdd/Om8UYxb6zP64w+jlLguNcYz+yL/+NFEoL4Y8h1yiHsGSWzKduE727s3VaCXLdAd3uFMDkqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NqxAVkq9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NqxAVkq9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39A801F000FF;
	Fri,  2 Oct 2026 11:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790941428;
	bh=pYjvUZTizzLYH4W0tE4PzE2BNT0W1pDDWWdBDK0TJ+E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NqxAVkq9goCEkqNxKdDn1GQ9GkK7d6sohonNzC0evBD/wLwe0UINL+XlXGdscYZTg
	 cdB/qzGBDbkZ3Lnl4dyc0rg+8dVeuVxyhnFUFk/dWRoNoAI3Y4mqx/2AZj7HzaReYx
	 NICw4hKwX/jM6DCMDNn62UyTxZwRBR/+9hUxIpNmiW8TuZdyaH8QdaRecu0sPN5GlJ
	 7IhUQSjTBHWxARQYuzKX3rXWHIbHgJZxtAWFLkPk8y4I1pGyZj7ygx25w7aROc8dGt
	 d7WNEl/KP02oAFLh3RymveTn4efXvhbbxRvcBMwd2o3GmGmAGsq/zti+65lXUTh/uZ
	 NNVEA9pXcrXFQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/7] PCI/parisc: Clean up resource debug print & use
 dynamic debug
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261002113319.6652-3-ilpo.jarvinen@linux.intel.com>
References: <20261002113319.6652-1-ilpo.jarvinen@linux.intel.com>
 <20261002113319.6652-3-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 11:43:47 +0000
Message-Id: <20261002114348.39A801F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] pci: uninitialized stack pointer dereference in pcibios_align_reso=
urce() via %pR
--

commit e687046bde97f65f6b278cb7b13dd117863bc565
Author: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

PCI/parisc: Clean up resource debug print & use dynamic debug

This commit cleans up the ad-hoc RES_DBG() macro in the parisc PCI code
by replacing it with the standard pci_dbg() macro. It also updates the
format string to use %pR for printing resources, which matches the typical
format used by the PCI core.

> diff --git a/arch/parisc/kernel/pci.c b/arch/parisc/kernel/pci.c
> index b8007c7400d47..518f532ccddc5 100644
> --- a/arch/parisc/kernel/pci.c
> +++ b/arch/parisc/kernel/pci.c

[ ... ]

> @@ -204,10 +196,9 @@ resource_size_t pcibios_align_resource(void *data, c=
onst struct resource *res,
>  	struct pci_dev *dev =3D data;
>  	resource_size_t align, start =3D res->start;
> =20
> -	DBG_RES("pcibios_align_resource(%s, (%p) [%lx,%lx]/%x, 0x%lx, 0x%lx)\n",
> -		pci_name(((struct pci_dev *) data)),
> -		res->parent, res->start, res->end,
> -		(int) res->flags, size, alignment);
> +	pci_dbg(dev, "%pR: pcibios_align_resource(%lx, 0x%llx, 0x%llx), parent =
%pR\n",
> +		res, res->flags, (unsigned long long)size,
> +		(unsigned long long)alignment, res->parent);

[Severity: High]
Could this format string introduce a regression by causing a kernel oops due
to an uninitialized pointer dereference?

The %pR format specifier causes the printk implementation to dereference the
resource pointer to read its boundaries and flags. However,
pcibios_align_resource() is used as an alignf callback for resource
allocation, and it can be called with a partially uninitialized stack
variable from __find_resource_space():

kernel/resource.c:__find_resource_space() {
	...
	struct resource avail;
	...
	avail.start =3D ALIGN(full_avail.start, constraint->align);
	avail.end =3D full_avail.end;
	avail.flags =3D new->flags;
	if (avail.start >=3D full_avail.start) {
		alloc.flags =3D avail.flags;
		if (alignf) {
			alloc.start =3D alignf(constraint->alignf_data,
					     &avail, &full_avail,
					     size, constraint->align);
	...
}

In this path, the avail.parent field is left uninitialized. When %pR attemp=
ts
to dereference res->parent, it will be reading stack garbage. The previous
DBG_RES() implementation used %p, which safely printed the pointer address
without dereferencing it.

Would it be safer to revert to %p for the parent pointer or ensure the
struct is fully initialized?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002113319.6652=
-1-ilpo.jarvinen@linux.intel.com?part=3D2

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195283C4563
	for <linux-pci@vger.kernel.org>; Tue, 13 Oct 2026 13:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791897924; cv=none; b=X3nuxfitMWNYDKhEt6wqxrPu/yu6+qW8n0c/fp0hHPes5Vd/Pr/Q+WYkvukKZZVf1DN4PMXV6zoseGTjW1b1H6o0FWU8ShasYzg9Id7kpK531PbtOdhRHLZ2H5PFS0LahQFYa6r0AwJPVB6D4UUHEt0qQqU7Mt0NipuMiKlQcjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791897924; c=relaxed/simple;
	bh=WidWPNx+rPgG7u/YbL5s+0dJE0RbVmVg5PsQZRUo72Y=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=kAq9K8GGKp1liHAhUjcXU77sXpfCGNc/DcOSDODifphNiE/31IvvrITI2+/EmzafqPy4t96Ev0WpGILnLavKrU4oV0tR/Rny4BSOqXbfTLH+dWN1LGdkrZgp4BWd8ASPIZAcBilxgTlKy0a2Y3BTLTJ+XPO3cK9qqA+nn5VT2eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nnJp03A8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nnJp03A8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92E421F000FF;
	Tue, 13 Oct 2026 13:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791897922;
	bh=C3rysgHs+SH1KOqk0JQF8p2gIXwvOF5iH5saNNUK4zI=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=nnJp03A8zI7farjCxDhp8Mj6vXMkX+2y2wzqCzhuWlSWAOYtwwm5esUmCs83MqxIc
	 Ct5A7Yz162rnGcpy3zVgOZcPrethHaNv8oALfdmxSYhEzGGr+8e5sotoGkd6mMD7kL
	 3NmIeGIrL9SABkKFU4rdbWtOqGOB/ZGtEWZ6nEZ4rAXcc36rgiP3aQWijgbAiSkM6S
	 8n8yUJOlTvKcX44Fk8AG7kYVIFB46oo27+B6niQMCwVDDX4ZqobzpbptYVh+Ya9npH
	 pwl9x0ImaHSLEVGztkj+k7YNJmTsaPr7BTBjzy/LAf6PR7ehjgGFGlaYKu2w09CT/4
	 1U8uB/etfIHug==
Message-ID: <sashiko-outbox-169804@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/8] PCI: Fix nesting windows with remainder at the
 left edge
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261013130948.6231-5-ilpo.jarvinen@linux.intel.com>
References: <20261013130948.6231-1-ilpo.jarvinen@linux.intel.com>
 <20261013130948.6231-5-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 13:25:22 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] pci: uninitialized variable causes random bypass of remainder logic
--

commit d763cceb79214019a0738e421be1a8a6485d37bc
Author: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

PCI: Fix nesting windows with remainder at the left edge

If a bridge window has its non-aligning remainder at the left edge of
the window, assigning a nested bridge window of same size will fail
because resource side code will only allow starting a candicate range
from an aligning address. In such case, aligned address is somewhere in
the middle, not at the left edge of the window. Since the entire
available space is required for full-sized nested bridge window,
resource side code rejects the free space.

> diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
> index 441a62807719d..2ca3784aa323f 100644
> --- a/drivers/pci/setup-res.c
> +++ b/drivers/pci/setup-res.c
[ ... ]
> @@ -324,9 +366,17 @@ static int __pci_assign_resource(struct pci_bus *bus=
, struct pci_dev *dev,
>  	int ret;
> =20
>  	pci_init_pci_resreq_data(&rr, dev);
> +	rr.real_align =3D align;
> =20
>  	min =3D (res->flags & IORESOURCE_IO) ? PCIBIOS_MIN_IO : PCIBIOS_MIN_MEM;
> =20
> +	if (!rr.user_align &&
> +	    (res->flags & IORESOURCE_MEM) && pci_resreq_remainder(size, align))=
 {
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^^^^^

[Severity: High]
Does the remainder logic rely on rr.user_align being reliably initialized t=
o 0
for non-overridden resources?

In include/linux/pci.h, pci_init_pci_resreq_data() declares an uninitialized
variable bool user_aligned; and passes it by reference:

include/linux/pci.h:pci_init_pci_resreq_data() {
    bool user_aligned;
    ...
    rr->user_align =3D pci_specified_resource_alignment(dev, &user_aligned);
    if (!user_aligned)
        rr->user_align =3D 0;
}

If the user did not specify an alignment parameter,
pci_specified_resource_alignment() returns early without writing to
user_aligned:

drivers/pci/pci.c:pci_specified_resource_alignment() {
    ...
    if (!p || !*p)
        goto out;
    ...
out:
    return pcibios_default_alignment();
}

If the stack garbage in user_aligned evaluates to true, rr->user_align
incorrectly retains pcibios_default_alignment(). On architectures where
pcibios_default_alignment() is non-zero (like powernv), rr.user_align
becomes non-zero, causing !rr.user_align to evaluate to false. This skips
the align =3D 1U override randomly, breaking the remainder alignment logic
for nested bridge windows.

> +		align =3D 1U;
> +		if (pci_resource_is_bridge_win(resno))
> +			align =3D pci_min_window_alignment(bus, res->flags);
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013130948.6231=
-1-ilpo.jarvinen@linux.intel.com?part=3D4

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0C1328B71
	for <linux-pci@vger.kernel.org>; Wed, 23 Sep 2026 13:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790170146; cv=none; b=pT7yp4GsLjMGnl7GqtzV+CqZqNuFVcCgGsYtBg7pML3BEr/vTlGMhl/Ut2ZNiiAYR74vsxkYoOjm1GAHbVI+s8hZFajCziXppo0Py3+fEhy+5YG+8alJfW2u2eFsRQH9n/iWYtjjZ/xcEQaoTt6haaRJczZpFOLwuW+UM1wXxD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790170146; c=relaxed/simple;
	bh=pdLti/7R2uw2Wn5LJSIUV7xPWoXyLAsLUzlGKL5Srv8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QCHEDqd9FUBUNABTB9lghu2rtcmypoklQwOS8e7HkMxmf2t7GaUmTD5HBvkS0P/izhXoSNLUI2/MNB+/rdVRyBmgIKSvN3nb2C5W3d6xWLvmreIpFKTqwgLg/nwCRgiTaXSORDOdiqV8eVvGWvJ1rLKbORRzCv5lNJThg8rlIcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HxY0lXX7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HxY0lXX7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF0231F00898;
	Wed, 23 Sep 2026 13:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790170145;
	bh=+wCZzlZEYMFtgzHrLllW05N5BKpKqlTLfKiaJ1dBjMg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HxY0lXX7e2CJWs7+sEAdQdIwNgqf0eF4VQLlFUzOPH+LZgSLtUjXO4L7A9HmjzI0g
	 lZsMKt/EsZSHw4v+LnMNgO7EAfYRQCFoOiYrGohE7Qird7KoLp98F0rQCMdV8z7Jdc
	 CUA3ylz+eiViBrJQu5QS2q37a43Ah4HiAIBADStYSDNsLjNWKcT9zFlJd624KGrDtK
	 VHuSnMs7o5MIh5w4FPnIDXQWqCPZG/3saLfe2gXBE79Z0Tz6uCU/a4t2R5eu/8c9Ca
	 td1Q7TBcIJMVX8ulkwBH5IBEpFwlhOXWrJC5Lq9qVNgSvhyyMoaECi/tIohShQZWvi
	 LO8EnahPS8GLQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/5] PCI/quirks: Avoid certain BAR 0 address with igb
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260923131757.7792-6-ilpo.jarvinen@linux.intel.com>
References: <20260923131757.7792-1-ilpo.jarvinen@linux.intel.com>
 <20260923131757.7792-6-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 13:29:04 +0000
Message-Id: <20260923132904.CF0231F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] pci: skipping hardware update in bar0_address_breakage() causes de=
sync
- [High] pci: ignoring pci_release_resource() return corrupts tree
--

commit 140645b0838c61616e4734fb4c852db528a2c054
Author: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
Date:   Wed Sep 23 13:17:55 2026 +0000

    PCI/quirks: Avoid certain BAR 0 address with igb
   =20
This patch adds a quirk to reshuffle igb resources when BAR 0 is placed at=
=20
0x9c000000, which previously caused the driver to fail during probe due to=
=20
unexpected reads. The quirk uses BAR 3 to block the problematic address by=
=20
relocating it.

> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index de9bbccda21fd..e6f3e2ab1fd4e 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
[ ... ]
> @@ -6288,6 +6288,62 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x153=
6, rom_bar_overlap_defect);
[ ... ]
> +static void bar0_address_breakage(struct pci_dev *dev)
> +{
[ ... ]
> +	pci_dev_for_each_resource(dev, res, i) {
> +		if (!resource_assigned(res) ||
> +		    resource_type(res) !=3D IORESOURCE_MEM)
> +			continue;
> +
> +		pci_release_resource(dev, i);

[Severity: High]
Can ignoring the return value of pci_release_resource() cause tree
corruption?

If a resource fails to release (e.g., returning -EBUSY), it remains actively
linked in the system's resource sibling tree. The code below then modifies
its boundaries unconditionally via resource_set_range().

Does modifying the start and end bounds of a node while it is still linked
violate the strict address-ordered sibling list invariants of the resource
tree, and cause pci_claim_resource() to corrupt pointers by re-inserting it?

> +	}
> +
> +	resource_set_range(bar3, broken_addr, resource_size(bar3));
> +	bar3->flags &=3D ~IORESOURCE_UNSET;
> +	pci_claim_resource(dev, 3);
> +	if (!resource_assigned(bar3)) {
> +		bar3->flags |=3D IORESOURCE_UNSET;
> +		pci_warn(dev, "resource relocation failed\n");
> +	}
> +
> +	pci_dev_for_each_resource(dev, res, i) {
> +		if (resource_assigned(res) ||
> +		    resource_type(res) !=3D IORESOURCE_MEM)
> +			continue;
> +
> +		ret =3D pci_assign_resource(dev, i);

[Severity: High]
Does skipping BAR 3 in this loop cause a desync between the software
resource tree and the physical hardware?

Since pci_claim_resource() updates the software resource tree but does not
write to the physical hardware PCI configuration registers, the hardware BAR
needs to be updated.

However, because BAR 3 was claimed and marked assigned in software earlier,
the resource_assigned() check skips it here. This permanently bypasses the
hardware register update.=20

Would this leave the OS thinking BAR 3 is at 0x9c000000 while the physical
hardware remains at its old address, causing the MSI-X table reads to fail
and creating a possible PCIe bus conflict?

> +		if (ret)
> +			pci_warn(dev, "resource relocation failed\n");
> +	}
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923131757.7792=
-1-ilpo.jarvinen@linux.intel.com?part=3D5

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C2650E58B
	for <linux-pci@vger.kernel.org>; Tue, 13 Oct 2026 13:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791897866; cv=none; b=hFfHLOXdzA5LIcxUtd7ScliZoLo42hi++Zv3ht8tlV0/sKFEA9Aivw1buP+PigpYwg6ucebZOvVGhceu2T52XcbE+aQ3FAMHTTxDbT2vRSJb+BO8U1t+ONi6C39BFJ4Kjov2Cv5Cu53q4IVjCkGO8CwkrfIM+wknrh0i5+aupb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791897866; c=relaxed/simple;
	bh=38kO5EzdMsCg1Q1XVRSVSTrLZizgKm5tWg2HdCP3rbc=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=kmtfmLXp8L2gMoEN9ShOy/euzzHxJlRUbbjB3yiPfDGsV3WjOGQxGC1qCDgt1E6jFN5EmMnWaeFdYwypo6kaLFz0SpcQVIVfDafDVAozDduuhxvH7E0CqDsvqI0ggYXAPTW8rMMZi7UzJvzG3UEOFPcs4gxtZIO6o6JCH4HsI+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Th+ECMIr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Th+ECMIr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 707331F00893;
	Tue, 13 Oct 2026 13:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791897865;
	bh=QGSZ9yDKM29ILD1ouW/rRZX3oVUOjmz3eWqW3oHRFrw=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Th+ECMIrP0xtrVp7stE+hTLx2rNixbh0zFwSShzu+6xpkUW1qysS6o+W5Sfon4LzI
	 DBljXiJVqPxrPn4bNot9EKuzUXxnxla6KfY51KkELNYNpBZMkXd9dDCSTVpwHy6Cwc
	 dtQNathadqMgBiYC8DCn+H9c62oxdZPUYsxrW1TGNnWbeTLp2YG8KaMFRRpP6WvVIz
	 vSz4kRSuMkfgoFIz7KV5jUsq9slgyAW8mduCWEVxxd01h8JE0zMH59h5c3phaoeXNf
	 3TSLblBSwD3yyA4cjoLzlsCoQZOPVZh9ZGuVAjjrfq2S/9TKQzp3q4tlMu+fTjDChH
	 jP/Be8bQtCmdA==
Message-ID: <sashiko-outbox-169801@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 8/8] PCI/quirks: Avoid certain address on Genoa
 systems
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261013130948.6231-9-ilpo.jarvinen@linux.intel.com>
References: <20261013130948.6231-1-ilpo.jarvinen@linux.intel.com>
 <20261013130948.6231-9-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 13:24:24 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] pci: dangling parent pointer in static resource on host bridge h=
ot-remove
--

commit a726f0ceef0b80da9ff2163d336b376a4bbb5424
Author: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

PCI/quirks: Avoid certain address on Genoa systems

This commit works around a hardware black hole issue on Genoa systems where
a 64kB region at 0x9c000000 returns ~0. It does this by adding a PCI fixup
quirk that reserves this address space before any overlapping allocations
are made.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D222074

> diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
> index b301c6c8df753..cc463bf492b63 100644
> --- a/arch/x86/pci/fixup.c
> +++ b/arch/x86/pci/fixup.c

[ ... ]

> @@ -822,6 +822,42 @@ DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x1571, =
pci_amd_enable_64bit_bar);
> +static struct resource genoa_black_hole =3D DEFINE_RES_MEM_NAMED(0x9c000=
000,
> +							       SZ_64K,
> +							       "reserved");
> +
> +static void genoa_iomem_black_hole(struct pci_dev *dev)
> +{
> +	struct resource *r;
> +
> +	pci_bus_for_each_resource(dev->bus, r) {
> +		if (!r || !r->flags || !resource_assigned(r))
> +			continue;
> +
> +		if (!__resource_contains_unbound(r, &genoa_black_hole))
> +			continue;
> +
> +		if (resource_assigned(&genoa_black_hole))

[Severity: Medium]
Does this resource_assigned() check evaluate to true incorrectly after a ho=
st
bridge hot-remove?

When the quirk inserts the static genoa_black_hole resource into the
dynamically allocated host bridge resource window:

insert_resource(r, &genoa_black_hole)
    genoa_black_hole.parent =3D r;

If the ACPI host bridge is later hot-removed, the PCI core releases its
resource windows by calling release_resource(r). This function unlinks r
from the tree but intentionally does not clear the parent pointers of its
children.

As a result, genoa_black_hole.parent is left as a dangling pointer to the
freed resource r.

If the host bridge is rescanned or re-added, the device is rediscovered
and triggers the quirk again. The quirk checks resource_assigned(), which
evaluates:

static inline bool resource_assigned(const struct resource *res)
{
    return res->parent;
}

Because the pointer is dangling, the check evaluates to true, causing the
quirk to incorrectly skip re-insertion. The rescanned bus is therefore left
vulnerable to the hardware black hole, potentially leading to link loss or
failed initializations.

> +			pci_dbg(dev, "iomem black hole workaround already applied\n");
> +		else if (!insert_resource(r, &genoa_black_hole))
> +			pci_info(dev, "iomem black hole workaround enabled\n");
> +		else
> +			pci_dbg(dev, "iomem black hole workaround add failed\n");
> +		return;
> +	}
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013130948.6231=
-1-ilpo.jarvinen@linux.intel.com?part=3D8

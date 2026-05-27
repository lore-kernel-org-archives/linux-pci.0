Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B902A3B9930
	for <linux-pci@vger.kernel.org>; Wed, 27 May 2026 20:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779913592; cv=none; b=h9wxPLOaTdSSoFXdXVQf2fukEgGD6IQCgejTVZVjRQI6efJXXnZ1zS3DFMcbMRpDzNXjMtaE2Xm6RKckcaWhNH30pp62ls+cbMrAD8P3o10losccenswmVKXr/QjRTXEJTHdF/VaYlAmkAq99eSkbXBtiVRwve1LnPONyH7omJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779913592; c=relaxed/simple;
	bh=hQ3CkMUZhQUKjClJvrEvyq8msAEbJn65o352hcjdiAw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pteL8csoM6vXSUOwWZkZB18/3rybSbrCh4wDCr84HAuvClG2PdmJgfy8b3SEXxPDsGWPhoLJd4bPxMz+N/4eDFMSg+FF8krCTS7BjHKEyL6CGnux2CCSn50jW5kfzi6JcBzsUFOs2/2KfuKDDQLp8Ov2C2SOZ7IlIcVxGFMTqyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RGQDm1ie; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RGQDm1ie"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E01F31F000E9;
	Wed, 27 May 2026 20:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779913590;
	bh=iBvTkoIQulzShq8uGwr+Bg+jmSeUQpTVuAxumj+ENyc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RGQDm1iesV/Ef3BnNzkmoismYIfove/Vl0lcwv5JfXjl+lzefamm1l7LzRbGMgMmy
	 6Q+CLzJfdvYOh30LcL2+Lhfj7UGys6fv9naSQFEwXa22+nLeSFqMBO7vX8LvHtac+6
	 LoMoRB5+2gptooa4CUi2ufvCQtRrw8t6VJ4AARdGoc/tdLU6jtjNfv7fau0B3dyUGf
	 T9JaGQ2TULoKnEpJ6/LEqpddDYoQ7nwgrBBOo6CqtugatHPjwMzPg66cPyw3sOoYbG
	 BkO+9hoZKWF9xdMSrM2Clj0CoQ1ZPScE/JSQ/fHZvkSZg4P2yKcNUV0ykAg6rOHOlB
	 XitNRdewUIBgg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] ppc/pnv: Refactor PNV PCI Hotplug to group PCIe
 functions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aditya Gupta" <adityag@linux.ibm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260527180816.2749186-4-adityag@linux.ibm.com>
References: <20260527180816.2749186-4-adityag@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 27 May 2026 20:26:29 +0000
Message-Id: <20260527202629.E01F31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 9 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incorrect read-modify-write pattern on the Write-1-to-Clear (RW1C)=
 register PCI_EXP_SLTSTA.
- [High] Unlocked read-modify-write on the PCI_EXP_SLTCTL register leading =
to potential lost updates.
- [High] Device enable count and MSI vectors leak on teardown, and pci_clea=
r_master() is missing.
- [High] Use-After-Free and double-free in the error path of pnv_php_regist=
er_one().
- [High] NULL pointer dereference when logging a workqueue allocation error=
 in pnv_php_alloc_slot().
- [High] Lockless access to the PCI bus device list in the hardirq context.
- [High] Race condition during IRQ initialization exposes a window where in=
terrupts cannot be disabled during a slot reset.
- [High] Unbounded dynamic memory allocation in the interrupt handler can c=
ause OOM.
- [High] Calling disable_irq() on a potentially shared interrupt line.
--

commit 61762d5f66d3944b865702b98018365475b6c067
Author: Aditya Gupta <adityag@linux.ibm.com>

ppc/pnv: Refactor PNV PCI Hotplug to group PCIe functions

This commit refactors pnv_php.c to group PCIe functions together without
functional changes.

> diff --git a/drivers/pci/hotplug/pnv_php.c b/drivers/pci/hotplug/pnv_php.c
> index 997412eea4863..dd8e00b879e16 100644
> --- a/drivers/pci/hotplug/pnv_php.c
> +++ b/drivers/pci/hotplug/pnv_php.c
[ ... ]
> +	/* Clear pending interrupts */
> +	pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &sts);
> +	if (php_slot->flags & PNV_PHP_FLAG_BROKEN_PDC)
> +		sts |=3D PCI_EXP_SLTSTA_DLLSC;
> +	else
> +		sts |=3D (PCI_EXP_SLTSTA_PDC | PCI_EXP_SLTSTA_DLLSC);
> +	pcie_capability_write_word(pdev, PCI_EXP_SLTSTA, sts);

[Severity: High]
This is a pre-existing issue, but does this read-modify-write pattern clear
unintended status bits?

Since PCI_EXP_SLTSTA is a Write-1-to-Clear (RW1C) register, writing back the
read value writes '1's to other previously set status bits (like Command
Completed), which might inadvertently clear them before they can be handled.

[ ... ]
> +	/* Request the interrupt */
> +	ret =3D request_irq(irq, pnv_php_interrupt, IRQF_SHARED,
> +			  php_slot->name, php_slot);
> +	if (ret) {
> +		pnv_php_disable_irq(php_slot, true, true);
> +		SLOT_WARN(php_slot, "Error %d enabling IRQ %d\n", ret, irq);
> +		return;
> +	}
> +
> +	/* Enable the interrupts */
> +	pcie_capability_read_word(pdev, PCI_EXP_SLTCTL, &ctrl);
> +	if (php_slot->flags & PNV_PHP_FLAG_BROKEN_PDC) {
> +		ctrl &=3D ~PCI_EXP_SLTCTL_PDCE;
> +		ctrl |=3D (PCI_EXP_SLTCTL_HPIE |
> +			 PCI_EXP_SLTCTL_DLLSCE);
> +	} else {
> +		ctrl |=3D (PCI_EXP_SLTCTL_HPIE |
> +			 PCI_EXP_SLTCTL_PDCE |
> +			 PCI_EXP_SLTCTL_DLLSCE);
> +	}
> +	pcie_capability_write_word(pdev, PCI_EXP_SLTCTL, ctrl);
> +
> +	/* The interrupt is initialized successfully when @irq is valid */
> +	php_slot->irq =3D irq;

[Severity: High]
This is a pre-existing issue, but is there a race condition during IRQ
initialization that exposes a window where interrupts cannot be disabled?

Hardware interrupts are unmasked in PCI_EXP_SLTCTL before php_slot->irq =3D=
 irq
is assigned. A concurrent slot reset via sysfs in this small time window
will evaluate php_slot->irq > 0 as false, bypassing disable_irq().

Could resetting the bridge without disabling the interrupt lead to an
interrupt storm?

[ ... ]
>  static void pcie_disable_irq(struct pnv_php_slot *php_slot,
>  				bool disable_device, bool disable_msi)
>  {
[ ... ]
>  	if (disable_device || disable_msi) {
>  		if (pdev->msix_enabled)
>  			pci_disable_msix(pdev);
>  		else if (pdev->msi_enabled)
>  			pci_disable_msi(pdev);
>  	}
> =20
> -	if (disable_device)
> -		pci_disable_device(pdev);
> +	if (disable_device)
> +		pci_disable_device(pdev);
>  }

[Severity: High]
This is a pre-existing issue, but does this teardown path leak the device
enable count and MSI vectors?

When pnv_php_free_slot() calls pnv_php_disable_irq(..., false, false), the
disable_device and disable_msi flags are false. This skips
pci_disable_device() and pci_disable_msix()/msi(), leaking resources.

Additionally, should pci_clear_master() be called prior to device disableme=
nt
here?

[ ... ]
> +static void pcie_set_attention_state(struct pnv_php_slot *php_slot, u8 s=
tate)
> +{
> +	struct pci_dev *bridge =3D php_slot->pdev;
> +	u16 new, mask;
> +
> +	php_slot->attention_state =3D state;
> +	mask =3D PCI_EXP_SLTCTL_AIC;
> +
> +	if (state)
> +		new =3D FIELD_PREP(PCI_EXP_SLTCTL_AIC, state);
> +	else
> +		new =3D PCI_EXP_SLTCTL_ATTN_IND_OFF;
> +
> +	pcie_capability_clear_and_set_word(bridge, PCI_EXP_SLTCTL, mask, new);

[Severity: High]
This is a pre-existing issue, but can this unlocked read-modify-write on the
PCI_EXP_SLTCTL register lead to lost updates?

Concurrent modifications (for example, sysfs state changes vs slot teardown)
might overwrite register updates here, potentially leaving interrupts
incorrectly configured.

[ ... ]
> +static int pcie_reset_slot(struct pnv_php_slot *php_slot, bool probe)
> +{
> +	struct pci_dev *bridge =3D php_slot->pdev;
> +	uint16_t sts;
> +
> +	if (probe)
> +		return 0;
> +
> +	/* mask our interrupt while resetting the bridge */
> +	if (php_slot->irq > 0)
> +		disable_irq(php_slot->irq);

[Severity: High]
This is a pre-existing issue, but does calling disable_irq() here affect
other devices sharing the same interrupt line?

Because the IRQ is requested with IRQF_SHARED (and may fall back to legacy
INTx), disable_irq() masks the line at the interrupt controller, which might
starve all other independent devices sharing that interrupt.

[ ... ]
> -static const struct pnv_php_backend_ops pnv_php_opencapi_ops =3D {
> -	.reset_slot              =3D opencapi_reset_slot,
> -};
> -
>  static struct pnv_php_slot *pnv_php_alloc_slot(struct device_node *dn)
>  {
>  	struct pnv_php_slot *php_slot;

[Severity: High]
This is a pre-existing issue, but can this lead to a NULL pointer dereferen=
ce
when logging a workqueue allocation error?

If alloc_workqueue() fails, SLOT_WARN() is invoked. The SLOT_WARN() macro
evaluates php_slot->pdev (which is NULL at this point) and falls back to
dev_warn(&(php_slot)->bus->dev, ...).

Because php_slot->bus has not yet been initialized, accessing bus->dev
dereferences a NULL pointer.

[ ... ]
> @@ -1109,95 +1197,6 @@ static irqreturn_t pnv_php_interrupt(int irq, void=
 *data)
>  	return IRQ_HANDLED;
>  }

[Severity: High]
This is a pre-existing issue, but is it safe to perform lockless access to
the PCI bus device list in the hardirq context here?

The hardirq handler uses list_first_entry_or_null(&php_slot->bus->devices, =
...)
to iterate the PCI bus device list. Traversing this list safely requires
holding the pci_bus_sem read lock, which cannot be acquired in hardirq
context.

Could this allow a race condition with concurrent device hotplug operations,
potentially corrupting list traversal?

[Severity: High]
Additionally, this is a pre-existing issue, but can this unbounded dynamic
memory allocation in the interrupt handler cause OOM?

A pnv_php_event is allocated with GFP_ATOMIC for every event. Without rate
limiting or coalescing, could a malfunctioning PCIe endpoint that generates
an interrupt storm rapidly exhaust the atomic memory pool?

[ ... ]
> -static void pcie_enable_irq(struct pnv_php_slot *php_slot)
[ ... ]
> -}
> -
>  static int pnv_php_register_one(struct device_node *dn)
>  {
>  	struct pnv_php_slot *php_slot;

[Severity: High]
This is a pre-existing issue, but is there a use-after-free and double-free
in the error path for this function?

If pnv_php_enable() fails, the code branches to the unregister_slot label,
invoking pnv_php_unregister_one() which unregisters the slot and drops its
reference, freeing it.

Execution then falls through to the free_slot label, where pnv_php_put_slot=
()
is called on the already-freed pointer. Could this cause a double-free?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260527180816.2749=
186-1-adityag@linux.ibm.com?part=3D3

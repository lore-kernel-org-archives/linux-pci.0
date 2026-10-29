Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793260552;
	b=IBxEroORmaE5b488UM8TaY/dL4r2cxGAMXvyeIWX2ntVdNn8XQxx1seGAofl6+m4lbhZ
	 UCWx75zMJ51vNhFOX3J7S14x8IF1xc7zaOFcEtssUHF6R990nbyzrYzFow+q7dTyjRA1Q
	 Ol/AvdOeELFLFEk0bZf4EerjpXPy+qB7Urevv3kY48yZBfhXmeW1yXEoZXg3EK3VVccE9
	 amIzYQKfXw6bWTl4AxhiWsPOTVkIof421Cxcn9I6HYBvq+iSOlVE4+qigA4RdwZii9VTF
	 UtO2KcRqgREUtiK53vkWoOr6rQZyRUZxGnSSEKuDt7LLINCbhYfq8cYWgNQwoUAPuUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793260552;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=LjweFMGE1nz/B5oPlO3R6MsdId+nlcPtdLyaxHqLGmk=;
	b=dcKWOBN1JSplhEt1BQCIr7N/iUy4oTCqmqX+F1xVjsCA23GcywMR41TpLmAZBfxrNrI4
	 aVLU9iwZP9r5qD97cFFNPN26JbndmpqyVu7j3SqTvixRfYeahc+u5rgK7mHx/O60uye2c
	 FaRtLprF44Jo+TVAv1Gzol3fh4XoFAtns6fA+BUlZQrm7LgTuwjSZrIDQJlhoPNsuUG4n
	 QJquXIivFwfFjoCP9jOtAgBGR6f3mUWcbtCjXe3kRBnNSEVXT3jo2ivz123r3k7V3N0jq
	 6lR/VhFx4s4CiPNfzKwxGJoxvGaEkgPO4lzlX/JqmnbAO9kKbR/9naGSUQXZEe6FYww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DZp7NbP3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F89606A31A
	for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2026 07:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DZp7NbP3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D6861F01828;
	Thu, 29 Oct 2026 07:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793260551;
	bh=LjweFMGE1nz/B5oPlO3R6MsdId+nlcPtdLyaxHqLGmk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DZp7NbP3C0I+ANUnYHFYRyfIbj/MRo2KQ4PQf0Q5JJgWaAuqm1edcg8Ui4yQWFHaG
	 0NSX4BpkmAUtwV2gFKT3Ftzmhw73dfXhPZizFHAMRPRXbXjnsHaZToIS0ZC0ddSIPG
	 ZH6tGvDaK8FTcoiA15Cxe/XTiyYaGeIFmtwpz1uyMc6h7mMA/TZBpn3eWMspsrRECm
	 sUTv8qRGja3tGeTvP0JzmlTzshmkH5q8eHC+0v+VPo8G3bg/wbSsCWqDamGP/hn5fU
	 5Zi/Yk1cEC+ob0emjT9QDhU8Sgp8LzjwgUmt+0R2ZeIJ+4ajLatZnaWfN29Z+Ip8zC
	 eo3MAC2+9ROFA==
Message-ID: <sashiko-outbox-188923@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: iproc: Fix MSI shutdown operations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eugen Hristev" <ehristev@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261029-iproc-shutdown-v1-1-05f828561116@kernel.org>
References: <20261029-iproc-shutdown-v1-1-05f828561116@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 07:55:50 +0000
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
- [High] PCI: iproc: disable_irq() on chained GIC IRQs in iproc_msi_shutdow=
n()
- [High] PCI: iproc: NULL dereference in iproc_msi_shutdown() after failed =
MSI init
- [Medium] PCI: iproc: uninforced MMIO flush in iproc_msi_shutdown() via re=
adl_relaxed()
--

commit 1301129335cfb36f33fd6263460f6c8ea506e1a1
Author: Eugen Hristev <ehristev@kernel.org>

PCI: iproc: Fix MSI shutdown operations

This commit adds an iproc_msi_shutdown() helper and calls it from
iproc_pcie_shutdown() prior to asserting PCIe reset so that MSI interrupts
are disabled and quiesced on reboot or shutdown.

> diff --git a/drivers/pci/controller/pcie-iproc-msi.c b/drivers/pci/contro=
ller/pcie-iproc-msi.c
> index 9ba242ab95967..1d19db67f3142 100644
> --- a/drivers/pci/controller/pcie-iproc-msi.c
> +++ b/drivers/pci/controller/pcie-iproc-msi.c
> @@ -651,6 +651,22 @@ int iproc_msi_init(struct iproc_pcie *pcie, struct d=
evice_node *node)
>  }
>  EXPORT_SYMBOL(iproc_msi_init);
> =20
> +void iproc_msi_shutdown(struct iproc_pcie *pcie)
> +{
> +	struct iproc_msi *msi =3D pcie->msi;
> +	unsigned int index;
> +
> +	if (!msi)
> +		return;

[Severity: High]
Can iproc_msi_shutdown() dereference NULL pointers in msi->reg_offsets or
msi->grps if iproc_msi_init() failed earlier during probe?

In drivers/pci/controller/pcie-iproc-msi.c, iproc_msi_init() assigns
pcie->msi =3D msi right after allocating msi, before validating msi->nr_irqs
and pcie->type or allocating msi->bitmap and msi->grps:

drivers/pci/controller/pcie-iproc-msi.c:iproc_msi_init() {
	msi =3D devm_kzalloc(pcie->dev, sizeof(*msi), GFP_KERNEL);
	if (!msi)
		return -ENOMEM;

	msi->pcie =3D pcie;
	pcie->msi =3D msi;
	...
	msi->nr_irqs =3D of_irq_count(node);
	if (!msi->nr_irqs) {
		dev_err(pcie->dev, "found no MSI GIC interrupt\n");
		return -ENODEV;
	}
	...
	if (msi->nr_irqs < msi->nr_cpus) {
		dev_err(pcie->dev,
			"not enough GIC interrupts for MSI affinity\n");
		return -EINVAL;
	}
	...
	default:
		dev_err(pcie->dev, "incompatible iProc PCIe interface\n");
		return -EINVAL;
	}
	...
	msi->bitmap =3D devm_bitmap_zalloc(pcie->dev, msi->nr_msi_vecs,
					 GFP_KERNEL);
	if (!msi->bitmap)
		return -ENOMEM;

	msi->grps =3D devm_kcalloc(pcie->dev, msi->nr_irqs, sizeof(*msi->grps),
				 GFP_KERNEL);
	if (!msi->grps)
		return -ENOMEM;
}

Unlike the free_irqs error label at the bottom of iproc_msi_init(), those
early error returns leave pcie->msi non-NULL. Because iproc_pcie_setup() in
drivers/pci/controller/pcie-iproc.c treats iproc_pcie_msi_enable() failure
as non-fatal and continues probing the host bridge:

drivers/pci/controller/pcie-iproc.c:iproc_pcie_setup() {
	if (IS_ENABLED(CONFIG_PCI_MSI))
		if (iproc_pcie_msi_enable(pcie))
			dev_info(dev, "not using iProc MSI\n");
}

a subsequent reboot or shutdown calling iproc_pcie_shutdown() ->
iproc_msi_shutdown() will see a non-NULL pcie->msi and dereference
uninitialized msi->reg_offsets or msi->grps (as well as underflowing
msi->nr_irqs - 1 when msi->nr_irqs is 0).

> +
> +	iproc_msi_disable(msi);
> +	iproc_msi_read_reg(msi, IPROC_MSI_CTRL, msi->nr_irqs - 1);

[Severity: Medium]
Is iproc_msi_read_reg() sufficient here to guarantee that the posted MMIO
writes from iproc_msi_disable() have completed before disabling the IRQs?

In drivers/pci/controller/pcie-iproc-msi.c, iproc_msi_read_reg() uses
readl_relaxed():

static inline u32 iproc_msi_read_reg(struct iproc_msi *msi,
				     enum iproc_msi_reg reg,
				     unsigned int eq)
{
	struct iproc_pcie *pcie =3D msi->pcie;

	return readl_relaxed(pcie->base + msi->reg_offsets[eq][reg]);
}

On ARM and ARM64, readl_relaxed() does not include an I/O read barrier
(__iormb()), and the return value of iproc_msi_read_reg() is discarded
without any dependent operation or barrier before the loop below. Without a
non-relaxed readl() or an explicit read barrier, will the CPU wait for the
MMIO read response from the controller before executing the subsequent IRQ
teardown?

> +
> +	for (index =3D 0; index < msi->nr_irqs; index++)
> +		disable_irq(msi->grps[index].gic_irq);

[Severity: High]
Does calling disable_irq() on msi->grps[index].gic_irq actually mask or
stop these interrupts when they are registered as chained handlers?

In drivers/pci/controller/pcie-iproc-msi.c, iproc_msi_irq_setup() registers
each msi->grps[i].gic_irq using irq_set_chained_handler_and_data() rather
than request_irq():

drivers/pci/controller/pcie-iproc-msi.c:iproc_msi_irq_setup() {
	for (i =3D cpu; i < msi->nr_irqs; i +=3D msi->nr_cpus) {
		irq_set_chained_handler_and_data(msi->grps[i].gic_irq,
						 iproc_msi_handler,
						 &msi->grps[i]);
		...
	}
}

Chained interrupts replace desc->handle_irq directly with iproc_msi_handler
and do not set _IRQ_DISABLE_UNLAZY. When iproc_msi_shutdown() calls
disable_irq(msi->grps[index].gic_irq), __irq_disable() in kernel/irq/chip.c
performs a lazy disable if the irq_chip does not implement .irq_disable
(which is the case for ARM GICv2 and GICv3):

kernel/irq/chip.c:__irq_disable() {
	if (irqd_irq_disabled(&desc->irq_data)) {
		if (mask)
			mask_irq(desc);
	} else {
		irq_state_set_disabled(desc);
		if (desc->irq_data.chip->irq_disable) {
			desc->irq_data.chip->irq_disable(&desc->irq_data);
			irq_state_set_masked(desc);
		} else if (mask) {
			mask_irq(desc);
		}
	}
}

Because mask is false and chip->irq_disable is NULL, __irq_disable() only
sets IRQD_IRQ_DISABLED in software without masking the GIC interrupt in
hardware. Furthermore, unlike standard flow handlers (such as
handle_fasteoi_irq()), iproc_msi_handler() is invoked directly via
generic_handle_irq_desc() and does not check irqd_irq_disabled(), nor does
it set IRQD_IRQ_INPROGRESS for synchronize_irq() to wait on. Also,
iproc_msi_init() only sets up chained handlers for online CPUs via
for_each_online_cpu(), whereas this loop runs across all 0 .. msi->nr_irqs.

Should iproc_msi_shutdown() instead tear down the chained handlers using
iproc_msi_irq_free() (which calls irq_set_chained_handler_and_data() with
NULL, masking the GIC line under desc->lock and resetting desc->handle_irq),
similar to what iproc_msi_exit() does?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-iproc-shut=
down-v1-1-05f828561116@kernel.org?part=3D1

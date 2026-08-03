Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3CA36A377
	for <linux-pci@vger.kernel.org>; Mon,  3 Aug 2026 09:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785750432; cv=none; b=qNB3oK9Nyc7yX1gnZsryyz+04Bhmw+SC0xGPuPJtiaG7P4VDMU0MO2ZPR+pOR+llJYMQI5EBIZgROiXLhb9qMu6XBGnyw8WfVOjbshhsHljhtVg/HBHgtqNHo0XmuhP0rT4ohGn/9/WFaQk3gqh6msdTNhZRgtMedQlPOQujPy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785750432; c=relaxed/simple;
	bh=4xbq1R2Z4qtddD23rMIWY9xCPA7ed74Tznd4hR8sTz8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LAYGTaNlL/bXBGVVQd8ZyCi1hFWkcbDdQ3yuuugd0HQdkKdWqBLUt5DsIGyu62p6bdXXQv0FhICFTyxTiJFOKXKJu1F1PDvJCfvOtWchS9kSt6IuUokGagD2RAdChUK33qNIZAHNSEb1n6LoorSNrjcpB3lV9r8Op1dWyRILRZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tjd8hCYG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tjd8hCYG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F1301F00A3A;
	Mon,  3 Aug 2026 09:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785750430;
	bh=ixafuaCg1WmQSc2ExRrfQPccFq3dqKrOxCuT11su8+8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Tjd8hCYGR/zv2HRj5r+H4vOhPaRjghkCfMMMZdvtYdG3s/RTRZOoqVyDD/usCp+Xm
	 URklHQPIxLYj1pfVrnJjQQmz5CSJb8TqBF8/GOdcI7jju+9xl3046XkR/CwDUcSeW6
	 dm54A6e4nl3OxC18EMXHxBOx70BXQ1VBiFNjFcyDtURSFfNgJt0MMUjYl2pPeLC0TL
	 /3987RXQYHVLfLmCAq9KXNJkPE7EshLuqonp2CPQ4Gs9f/iFHScjJNKtG+9lFlV8h4
	 7dGB7wcvsK6yYgdbZYXkwL/Q3Rpz+3aLYjW/2zm3JJWPMDf0aNKTtVjD+flmyXpJAS
	 w8mjm9YRs+LNQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: dwc: Add sysfs for local loopback interface
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krishna Chaitanya Chundru" <krishna.chundru@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260803-loopback-v1-1-508f7f19e47a@oss.qualcomm.com>
References: <20260803-loopback-v1-1-508f7f19e47a@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 09:47:09 +0000
Message-Id: <20260803094710.5F1301F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 9 potential issue(=
s) to consider:
- [Critical] `pcibios_align_resource` is used as an alignment callback but =
receives a `struct device *` instead of a `struct pci_dev *`.
- [High] The inbound iATU is programmed with the CPU physical address inste=
ad of the PCIe bus address.
- [High] Inbound ATU window configuration is overwritten and permanently di=
sabled, silently destroying prior hardware mappings.
- [High] Hardware recovery via `dw_pcie_resume_noirq()` will unconditionall=
y fail and mask test outcomes.
- [High] The inbound iATU window programmed for the loopback test is not di=
sabled if the controller requires reinitialization, leaving a hardware mapp=
ing to freed memory active.
- [High] Missing pm_runtime_get_sync() before accessing hardware registers =
in the sysfs handler.
- [High] Calling `deinit` and `resume_noirq` during active system operation=
 without blocking concurrent config space accesses will cause a system cras=
h.
- [Medium] The loopback test uses `kmalloc()` to allocate an arbitrarily la=
rge test buffer (up to 1 MiB), which is highly susceptible to allocation fa=
ilure due to fragmentation.
- [Medium] TOCTOU race in link status check can cause disruption of an acti=
ve link.
--

--- Patch [1]: [PATCH] PCI: dwc: Add sysfs for local loopback interface ---
commit 4f4d57ae54b60f668971d41c20d2d0f542109200
Author: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

PCI: dwc: Add sysfs for local loopback interface

This patch adds a loopback sysfs interface to trigger a local
data-integrity test on DesignWare PCIe root ports. It works by allocating
a DMA buffer, redirecting PCIe writes to it via an inbound iATU window,
and verifying the data byte-by-byte. It also includes a recovery mechanism
to handle LTSSM state issues after the test completes.

> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/=
pci/controller/dwc/pcie-designware-host.c
> index 06722259d2e37..f0cfe9e885204 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c

[ ... ]

> @@ -567,6 +569,297 @@ static int dw_pcie_host_get_resources(struct dw_pci=
e_rp *pp)
>  	return 0;
>  }
> =20
> +#define DW_PCIE_LB_BUF_SIZE_MIN	SZ_4K
> +#define DW_PCIE_LB_BUF_SIZE_MAX	SZ_1M
> +#define DW_PCIE_LB_SETTLE_MS		100
> +#define DW_PCIE_LB_LTSSM_SETTLE_US	(DW_PCIE_LB_SETTLE_MS * USEC_PER_MSEC)
> +#define DW_PCIE_LB_LTSSM_POLL_US	1000
> +
> +static int dw_pcie_loopback_run(struct dw_pcie_rp *pp, size_t buf_size)
> +{
> +	struct resource lb_res =3D { .name =3D "pcie-loopback",
> +				   .flags =3D IORESOURCE_MEM };
> +	struct dw_pcie *pci =3D to_dw_pcie_from_pp(pp);
> +	enum dw_pcie_ltssm ltssm;
> +	void __iomem *src_base;
> +	u32 plc, gen3, pipe_lb;
> +	dma_addr_t dst_dma;
> +	void *dst_virt;
> +	int ret, rret;
> +	void *tx_buf;
> +	int ib_index;
> +
> +	ib_index =3D pci->num_ib_windows - 1;

[Severity: High]
Does this code safely reserve the inbound ATU window? It seems the index
is hardcoded to the last available window without checking if it is already
in use.

If the platform driver or PCIe host core had previously programmed this
window (for example, to map system RAM for incoming endpoint DMA or to
route MSI interrupts), could this unconditionally overwrite and permanently
destroy that configuration?

> +
> +	ret =3D pci_bus_alloc_resource(pp->bridge->bus, &lb_res,
> +				     buf_size, buf_size,
> +				     PCIBIOS_MIN_MEM, 0,
> +				     pcibios_align_resource,
> +				     &pp->bridge->dev);

[Severity: Critical]
Is the alignment data parameter passed to pci_bus_alloc_resource()
correct here?

The pcibios_align_resource callback expects a struct pci_dev pointer, but
&pp->bridge->dev is a struct device pointer. Architecture implementations
often cast this parameter directly to struct pci_dev and access its fields.

Since struct device is embedded inside struct pci_dev at a non-zero offset,
could this cause out-of-bounds memory accesses?

> +	if (ret) {
> +		dev_err(pci->dev, "loopback: failed to alloc PCIe MEM resource: %d\n",=
 ret);
> +		return ret;
> +	}
> +
> +	src_base =3D ioremap(lb_res.start, buf_size);
> +	if (!src_base) {
> +		dev_err(pci->dev, "loopback: ioremap of PCIe source window failed\n");
> +		ret =3D -ENOMEM;
> +		goto err_release_res;
> +	}
> +
> +	dst_virt =3D dma_alloc_coherent(pci->dev, buf_size, &dst_dma, GFP_KERNE=
L);
> +	if (!dst_virt) {
> +		ret =3D -ENOMEM;
> +		goto err_iounmap;
> +	}
> +
> +	ret =3D dw_pcie_prog_inbound_atu(pci, ib_index, PCIE_TLP_TYPE_MEM_RDWR,
> +				       dst_dma, lb_res.start, buf_size);

[Severity: High]
Does the inbound ATU programming use the correct address space?

pci_bus_alloc_resource() populates lb_res.start with a CPU physical
address, and this is passed directly to dw_pcie_prog_inbound_atu() as the
PCIe bus address.

On platforms where the CPU physical address space has an offset from the
PCIe bus address space (such as those specifying dma-ranges), will the ATU
expect the wrong address and cause the loopback test to fail?

> +	if (ret) {
> +		dev_err(pci->dev, "loopback: inbound iATU programming failed: %d\n", r=
et);
> +		goto err_free_dma;
> +	}
> +
> +	plc =3D dw_pcie_readl_dbi(pci, PCIE_PORT_LINK_CONTROL);
> +
> +	gen3 =3D dw_pcie_readl_dbi(pci, GEN3_RELATED_OFF);
> +	dw_pcie_writel_dbi(pci, GEN3_RELATED_OFF,
> +			   gen3 | GEN3_RELATED_OFF_GEN3_EQ_DISABLE);
> +
> +	pipe_lb =3D dw_pcie_readl_dbi(pci, PCIE_PIPE_LOOPBACK_CONTROL);
> +	dw_pcie_writel_dbi(pci, PCIE_PIPE_LOOPBACK_CONTROL,
> +			   pipe_lb | PCIE_PIPE_LOOPBACK_EN);
> +
> +	dw_pcie_writel_dbi(pci, PCIE_PORT_LINK_CONTROL, plc | PORT_LINK_LOOPBAC=
K_EN);
> +
> +	msleep(DW_PCIE_LB_SETTLE_MS);
> +
> +	tx_buf =3D kmalloc(buf_size, GFP_KERNEL);

[Severity: Medium]
Could this memory allocation fail on systems with fragmented memory?

The loopback test can request a buffer up to 1 MiB via the sysfs attribute,
which requires an order-8 physically contiguous page block.

Since tx_buf is solely used as a virtual buffer to hold random data before
copying via memcpy_toio(), would it be more reliable to use kvmalloc() to
avoid disruptive page allocator warnings?

> +	if (!tx_buf) {
> +		ret =3D -ENOMEM;
> +		goto err_restore_link;
> +	}

[ ... ]

> +err_restore_link:
> +	dw_pcie_writel_dbi(pci, PCIE_PORT_LINK_CONTROL, plc);
> +	dw_pcie_writel_dbi(pci, PCIE_PIPE_LOOPBACK_CONTROL, pipe_lb);
> +	dw_pcie_writel_dbi(pci, GEN3_RELATED_OFF, gen3);
> +
> +	if (read_poll_timeout(dw_pcie_get_ltssm, ltssm,
> +			      ltssm =3D=3D DW_PCIE_LTSSM_DETECT_QUIET,
> +			      DW_PCIE_LB_LTSSM_POLL_US, DW_PCIE_LB_LTSSM_SETTLE_US,
> +			      false, pci)) {
> +		/*
> +		 * LTSSM has been observed stuck outside DETECT_QUIET on some
> +		 * platforms; only a full controller reinit (mirroring system
> +		 * suspend/resume) reliably recovers it.
> +		 */
> +		dev_warn(pci->dev,
> +			 "loopback: LTSSM did not settle in DETECT_QUIET (in %s), reinitializ=
ing controller\n",
> +			 dw_pcie_ltssm_status_string(ltssm));
> +
> +		if (pp->ops->deinit)
> +			pp->ops->deinit(pp);
> +
> +		pci->suspended =3D true;

[Severity: High]
Does powering down the controller here pose a risk of a system crash?

This recovery runs in a sysfs handler while the rest of the system is fully
active, without blocking concurrent accesses to the PCIe config space.

If another task attempts a config read (for example, from lspci) while the
clocks are disabled by the deinit callback, could the unclocked access
trigger an AXI bus fault?

> +
> +		rret =3D dw_pcie_resume_noirq(pci);
> +		if (rret) {
> +			dev_err(pci->dev, "loopback: controller reinit failed: %d\n", rret);
> +			if (!ret)
> +				ret =3D rret;
> +		}

[Severity: High]
Will this hardware recovery unconditionally fail?

The loopback test runs strictly when the PCIe link is down (no endpoint is
connected). However, dw_pcie_resume_noirq() starts the link and waits for
it to become UP. Because no endpoint is physically connected, this wait
will time out and return -ETIMEDOUT.

This seems to overwrite a potentially successful test result with -ETIMEDOUT
and abandon the controller in a broken, suspended state.

> +
> +		ltssm =3D dw_pcie_get_ltssm(pci);
> +	} else {
> +		dw_pcie_disable_atu(pci, PCIE_ATU_REGION_DIR_IB, ib_index);
> +	}
> +
> +	dev_info(pci->dev, "PCIe LTSSM state after loopback exit: %s\n",
> +		 dw_pcie_ltssm_status_string(ltssm));
> +
> +err_free_dma:
> +	dma_free_coherent(pci->dev, buf_size, dst_virt, dst_dma);

[Severity: High]
Does this leave a hardware mapping to freed memory active?

When the LTSSM poll times out, the code skips the else block containing
dw_pcie_disable_atu(). Execution falls through to err_free_dma, where
dma_free_coherent() frees the DMA buffer back to the kernel.

If the link later becomes active, could incoming memory writes from an
endpoint corrupt kernel memory through the still-active inbound ATU window?

[ ... ]

> +static ssize_t run_store(struct device *dev,
> +			 struct device_attribute *attr,
> +			 const char *buf, size_t count)
> +{
> +	struct dw_pcie_loopback *lb =3D
> +		container_of(attr, struct dw_pcie_loopback, attr_run);
> +	struct dw_pcie_rp *pp =3D lb->pp;
> +	struct dw_pcie *pci =3D to_dw_pcie_from_pp(pp);
> +	size_t buf_size;
> +	int ret;
> +
> +	if (!sysfs_streq(buf, "local"))
> +		return -EINVAL;
> +
> +	if (dw_pcie_link_up(pci)) {
> +		dev_err(pci->dev,
> +			"loopback: refusing to run while the link is up\n");
> +		return -EBUSY;
> +	}

[Severity: High]
Are the power domains and clocks guaranteed to be active here?

The run_store() handler directly checks the link state by reading the
PCIE_PORT_DEBUG1 MMIO register via dw_pcie_link_up(), and then proceeds
to modify numerous controller registers in dw_pcie_loopback_run().

Since the test intentionally runs when the link is down, is it possible
the driver core has runtime-suspended the PCIe controller to save power?
Accessing MMIO registers without calling pm_runtime_get_sync() first
could trigger a synchronous bus fault.

[Severity: Medium]
Is there a race condition between checking the link status and executing
the test?

The code locklessly checks dw_pcie_link_up() here, and later acquires
lb->lock and performs sleeping allocations in dw_pcie_loopback_run(),
such as dma_alloc_coherent() and kmalloc().

If an endpoint is hotplugged or finishes link training during this sleep
window, the link will transition to the UP state. Will the loopback test
then blindly overwrite the PCIE_PORT_LINK_CONTROL register, forcefully
disrupting the newly active link?

> +
> +	if (mutex_lock_interruptible(&lb->lock))
> +		return -ERESTARTSYS;

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803-loopback-v=
1-1-508f7f19e47a@oss.qualcomm.com?part=3D1

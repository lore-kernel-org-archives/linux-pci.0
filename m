Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A04327BFA
	for <linux-pci@vger.kernel.org>; Fri, 18 Sep 2026 15:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789744364; cv=none; b=uB65v/A9lnpMOjhnBSU6VHGNrRbIznh5I2ny3zzK0KCKj/pQIea+ONlSffw0JtCL9NVdPL+qhSPfXsBRb2Yu81BWu2z12Xa4317UU4QaUEoJbRejvjjcct7ptUjJv8GhvdgDze9peksll/48XF+GddCGZ3YQGLZfpfHbJpu1qI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789744364; c=relaxed/simple;
	bh=tn1aBh/SlDZmN0/xQP6AB5Rlvc1RryHLjTnhqAvqOzM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WuNsB9CQyVnCEENXF6O47Yu05ogRRNfJHideNxyUs7UjRWuQQlTB76lakJQpiJY3DW8rx8iiy7B6h4k3LvQqJ0inTTrVhX5skjdgurgepOSbO1dk5hOs4ysRZu1+zyF5qI6mGsZd3Zn7mXNWu9LMgRe6lXspxRIapiLdC7hZ0dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RvjC6feg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RvjC6feg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1A821F000FF;
	Fri, 18 Sep 2026 15:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789744362;
	bh=sjbyGxS6q3J6vjbw9zMm7FBUFM5f6GlCH6dU3rbOlhs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RvjC6feg6AR2VE3R2kVMapqvKNj8uqdGYDaECzQtCWHhnA1LhtsAYRfAxQexv5yV0
	 4aSNCl8Rk80j4lygpobH8ZkKAungzA5J+glxzsY/SSXXcJikZyxZz3NcKbQF3d6Df5
	 psUMYgo24T7aAmZR4dkJOkC5RH0gUv5hq3dwREkko6yyaI58IKRK5ll+82Pdnrw4OZ
	 6kMfDR2ScniLPDvbib6Tky+S8Nvql63OooErOagkBL21tcAHSQfuXSMnvZGNVMKiwZ
	 /c3sEAVROPAWsLhNeRIIwkTD1Rh4ns2JASFDvTD2ujXtbgrrlQvCztppyn5TiBbAir
	 BvnAngo7GuqAQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 07/10] PCI/FLIT: Add support for Flit Logging
 Extended Capability
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yazen Ghannam" <yazen.ghannam@amd.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260918145619.3016889-8-yazen.ghannam@amd.com>
References: <20260918145619.3016889-1-yazen.ghannam@amd.com>
 <20260918145619.3016889-8-yazen.ghannam@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 15:12:42 +0000
Message-Id: <20260918151242.B1A821F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] pcie/flit: IRQ storm due to free_irq() before disabling hardware
--

commit c76b2fb611bb532cfef2fa0ae176b99d25d187a0
Author: Yazen Ghannam <yazen.ghannam@amd.com>

PCI/FLIT: Add support for Flit Logging Extended Capability

This commit adds a PCIe port service driver for the Flit Logging Extended
Capability, including _OSC negotiation, interrupt handling, and error
logging features.

Link: https://pcisig.com/specification/extend-osc-negotiate-control-pcie-fl=
it-logging-extended-capability

> diff --git a/drivers/pci/pcie/flit.c b/drivers/pci/pcie/flit.c
> new file mode 100644
> index 0000000000000..7c0b9c8dd4811
> --- /dev/null
> +++ b/drivers/pci/pcie/flit.c

[ ... ]

> +static irqreturn_t flit_ist(int irq, void *context)
> +{
> +	struct pcie_device *dev =3D (struct pcie_device *)context;
> +	struct pci_dev *pdev =3D dev->port;

[ ... ]

> +	/*
> +	 * Re-enable the counter. Per PCIe r6.4, sec 7.7.8.5, table 7-96, the
> +	 * status bit is "Cleared on 0b to 1b transition of Flit Error Counter
> +	 * Enable", which also clears the counter and re-arms interrupt
> +	 * generation.
> +	 */
> +	flit_cntr_ctrl_update(pdev, 0, PCI_FLIT_ERR_CNTR_CTRL_EN);
> +	return IRQ_HANDLED;
> +}

[Severity: High]
Does unconditionally re-enabling the counter here prevent a safe teardown
sequence in flit_cntr_remove()?

If this checked pdev->flit_info->cntr_enabled before re-enabling, could we
then safely disable the counter before freeing the IRQ during removal?

[ ... ]

> +static int flit_probe(struct pcie_device *dev)
> +{
> +	struct pci_dev *pdev =3D dev->port;
> +	int status;
> +
> +	/*
> +	 * Not devm_request_threaded_irq(): devres would free the IRQ only
> +	 * after .remove() runs, too late to stop flit_ist() re-enabling the
> +	 * counter.
> +	 */

[Severity: High]
Does this deliberate teardown order choice introduce an IRQ storm
regression?

> +	status =3D request_threaded_irq(dev->irq, flit_isr, flit_ist,
> +				      IRQF_SHARED, "pcie-flit", dev);

[ ... ]

> +static void flit_cntr_remove(struct pcie_device *dev)
> +{
> +	/* Drop the IRQ first: free_irq() waits for the threaded handler. */
> +	free_irq(dev->irq, dev);
> +	flit_cntr_disable(dev->port);
> +}

[Severity: High]
Could calling free_irq() before flit_cntr_disable() cause a regression
with an unhandled level-triggered interrupt storm?

Because the IRQ is requested with IRQF_SHARED (shared with other PCIe
port services like PME and Hotplug), the interrupt may be a
level-triggered INTx line.

If the Flit hardware asserts an interrupt during the window between
free_irq() and flit_cntr_disable(), the other shared handlers will be
invoked but will return IRQ_NONE since they cannot clear the Flit status
register.

Could this prompt the kernel to permanently disable the shared IRQ line
("irq XX: nobody cared") and break all other services sharing it?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918145619.3016=
889-1-yazen.ghannam@amd.com?part=3D7

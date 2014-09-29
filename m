Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f181.google.com ([209.85.213.181]:48068 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750968AbaI2ULr (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 29 Sep 2014 16:11:47 -0400
Received: by mail-ig0-f181.google.com with SMTP id h18so4137974igc.2
        for <linux-pci@vger.kernel.org>; Mon, 29 Sep 2014 13:11:46 -0700 (PDT)
Date: Mon, 29 Sep 2014 14:11:44 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Minghuan Lian <Minghuan.Lian@freescale.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Zang Roy-R61911 <r61911@freescale.com>,
	Hu Mingkai-B21284 <B21284@freescale.com>,
	Scott Wood <scottwood@freescale.com>,
	Yoder Stuart-B08248 <stuart.yoder@freescale.com>,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v4] PCI: Layerscape: Add Layerscape PCIe driver
Message-ID: <20140929201144.GB15712@google.com>
References: <1411888107-27640-1-git-send-email-Minghuan.Lian@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1411888107-27640-1-git-send-email-Minghuan.Lian@freescale.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Sep 28, 2014 at 03:08:27PM +0800, Minghuan Lian wrote:
> Add support for Freescale Layerscape PCIe controller. This driver
> re-uses the designware core code.
> ...

This looks pretty good to me.  I have a couple trivial comments below.
Anybody else have any suggestions?  I'd like to get this merged in the next
day or two so we can get this into v3.18.

I'd like a MAINTAINERS update, too, so I know who to expect patches and
acks from.

> +static irqreturn_t ls_pcie_msi_irq_handler(int irq, void *data)
> +{
> +	struct pcie_port *pp = data;
> +	struct ls_pcie *pcie = to_ls_pcie(pp);
> +	unsigned int msi_irq;
> +
> +	/* clear the interrupt */
> +	regmap_write(pcie->scfg, SCFG_SPIMSICLRCR,
> +		     MSI_LS1021A_DATA(pcie->index));
> +
> +	msi_irq = irq_find_mapping(pp->irq_domain, 0);
> +	if (!msi_irq) {
> +		/*
> +		 * that's weird who triggered this?
> +		 * just clear it
> +		 */
> +		dev_err(pcie->dev, "unexpected MSI\n");

Scott suggested either using dev_dbg or rate-limiting this dev_err.

> +static int ls_add_pcie_port(struct ls_pcie *pcie)
> +{
> +	struct pcie_port *pp;
> +	int ret;
> +
> +	if (!pcie)
> +		return -EINVAL;

Unnecessary NULL pointer check (we already checked it below).

Bjorn

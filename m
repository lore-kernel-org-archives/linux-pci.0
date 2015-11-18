Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:63981 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755207AbbKRJua (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 18 Nov 2015 04:50:30 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Ray Jui <rjui@broadcom.com>, Bjorn Helgaas <bhelgaas@google.com>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	linux-kernel@vger.kernel.org,
	bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH 4/5] PCI: iproc: Add iProc PCIe MSI support
Date: Wed, 18 Nov 2015 10:50:18 +0100
Message-ID: <6698299.zIsv0CNpOi@wuerfel>
In-Reply-To: <20151118084845.49ba6304@arm.com>
References: <1447806715-30043-1-git-send-email-rjui@broadcom.com> <1447806715-30043-5-git-send-email-rjui@broadcom.com> <20151118084845.49ba6304@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday 18 November 2015 08:48:45 Marc Zyngier wrote:
> > +static inline u32 iproc_msi_read_reg(struct iproc_msi *msi,
> > +				     enum iproc_msi_reg reg,
> > +				     unsigned int eq)
> > +{
> > +	struct iproc_pcie *pcie = msi->pcie;
> > +
> > +	return readl(pcie->base + msi->reg_offsets[eq][reg]);
> 
> Do you need the extra barrier implied by readl? readl_relaxed should be
> enough.

I suspect this is the one place where it's needed for a lot of
drivers: when the PCI device sends DMA data followed by the MSI
message, the device driver can safely assume that the DMA data
has arrived in memory even without doing another readl() from
the device itself.

It really depends on how the MSI implementation here interacts
with the memory controller, and we should probably have a comment
to explain this either way.

> > +static inline void iproc_msi_write_reg(struct iproc_msi *msi,
> > +				       enum iproc_msi_reg reg,
> > +				       int eq, u32 val)
> > +{
> > +	struct iproc_pcie *pcie = msi->pcie;
> > +
> > +	writel(val, pcie->base + msi->reg_offsets[eq][reg]);
> 
> Same here for writel vs writel_relaxed.

We probably want writel_relaxed() when calling this from
iproc_msi_handler(), but not when calling from
iproc_msi_enable(), which should default to a normal
writel(), so we can be sure it's actually configured right
at the time we return from iproc_msi_init(). You could
try to prove that using writel_relaxed is correct here, but
using writel makes it so much easier.

	Arnd

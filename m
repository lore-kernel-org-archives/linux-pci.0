Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:41700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751944AbdHOWjt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 15 Aug 2017 18:39:49 -0400
Date: Tue, 15 Aug 2017 17:39:46 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Niklas Cassel <niklas.cassel@axis.com>
Cc: linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
        Niklas Cassel <niklass@axis.com>, linux-kernel@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Pratyush Anand <pratyush.anand@gmail.com>
Subject: Re: [PATCH 0/2] PCI: dwc: convert remaining dbi read/writes to
 dw_pcie_readX_dbi/dw_pcie_writeX_dbi
Message-ID: <20170815223946.GQ32525@bhelgaas-glaptop.roam.corp.google.com>
References: <20170714120735.11993-1-niklas.cassel@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170714120735.11993-1-niklas.cassel@axis.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Kishon, Pratyush]

On Fri, Jul 14, 2017 at 02:07:33PM +0200, Niklas Cassel wrote:
> Since the introduction of the dw_pcie_readX_dbi/dw_pcie_writeX_dbi macros,
> most dw_pcie_read(pci->dbi_base, ..)/dw_pcie_write(pci->dbi_base, ..) calls
> have been converted to dw_pcie_readX_dbi/dw_pcie_writeX_dbi calls.
> Convert the remaining calls.
> 
> Niklas Cassel (2):
>   PCI: dwc: dra7xx: utilize dw_pcie_readX_dbi/dw_pcie_writeX_dbi macros
>   PCI: dwc: spear13xx: utilize dw_pcie_readX_dbi/dw_pcie_writeX_dbi
>     macros
> 
>  drivers/pci/dwc/pci-dra7xx.c     | 14 ++++++--------
>  drivers/pci/dwc/pcie-spear13xx.c | 22 ++++++++++------------
>  2 files changed, 16 insertions(+), 20 deletions(-)

These patches are short, but obscure, e.g.,

  - dw_pcie_read(pci->dbi_base + exp_cap_off + PCI_EXP_LNKCAP, 4, &val);
  + val = dw_pcie_readl_dbi(pci, exp_cap_off + PCI_EXP_LNKCAP);

The original call path was:

  dw_pcie_read(addr, ...)
    readl(addr) 

and we're replacing it with the much more complicated:

  dw_pcie_readl_dbi
    __dw_pcie_read_dbi
      if (pci->ops->read_dbi)
	return pci->ops->read_dbi(pci, base, reg, size)
      dw_pcie_read(base + reg, size, &val)
	readl

This is not functionally equivalent (the new path uses ops->read_dbi
if it's set), so the changelog should say something about why we need
this change.

Neither dra7xx nor spear13xx sets .read_dbi, so my guess is this
doesn't actually fix anything that's broken and this is just for
consistency.

That's fine, but I'm confused because I looked for some of the
previous conversions you mentioned but couldn't find any.  I'm lost in
a maze of twisty little passages.

Bjorn

Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:41518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751128AbdHBVc6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 2 Aug 2017 17:32:58 -0400
Date: Wed, 2 Aug 2017 16:32:56 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Niklas Cassel <niklas.cassel@axis.com>
Cc: linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
        Niklas Cassel <niklass@axis.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] PCI: dwc: convert remaining dbi read/writes to
 dw_pcie_readX_dbi/dw_pcie_writeX_dbi
Message-ID: <20170802213255.GB7667@bhelgaas-glaptop.roam.corp.google.com>
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

Waiting for ack from maintainers (cc'd).

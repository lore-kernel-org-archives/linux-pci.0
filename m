Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:50458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753736AbdHXRRy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 Aug 2017 13:17:54 -0400
Date: Thu, 24 Aug 2017 12:17:53 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
        jingoohan1@gmail.com, Joao.Pinto@synopsys.com,
        minghuan.lian@nxp.com, mingkai.hu@nxp.com, roy.zang@nxp.com,
        svarbanov@mm-sol.com, niklas.cassel@axis.com,
        jesper.nilsson@axis.com
Subject: Re: [PATCHv4 0/9] PCI: dwc: refactor ls-pcie ->host_init() and fix
 bug for dw_pcie_setup_rc
Message-ID: <20170824171752.GR31858@bhelgaas-glaptop.roam.corp.google.com>
References: <20170823060856.9387-1-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170823060856.9387-1-Zhiqiang.Hou@nxp.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 23, 2017 at 02:08:47PM +0800, Zhiqiang Hou wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> Drop the change for qcom pcie driver's fixup from 9/9, it seems qcom
> pcie controller did not implement the register MISC_CONTROL_1_OFF.
> 
> Hou Zhiqiang (9):
>   PCI: layerscape: Add dw_pcie_setup_rc to ls-pcie common host init
>   PCI: layerscape: move STRFMR1 access out from the DBI write-enable
>     bracket
>   PCI: layerscape: add class code and multifunction fixups for ls1021a
>   PCI: layerscape: refactor the host_init function
>   PCI: layerscape: Disable the outbound windows configured by bootloader
>   PCI: designware: add accessors for write permission of DBI read-only
>     registers
>   PCI: layerscape: use accessors to enable/disable DBI RO registers'
>     write permission
>   PCI: designware: enable write permission before updating DBI RO
>     registers
>   PCI: dwc: remove the obsolete fixups
> 
>  drivers/pci/dwc/pci-layerscape.c       | 90 ++++++++++++++++++----------------
>  drivers/pci/dwc/pcie-artpec6.c         |  6 ---
>  drivers/pci/dwc/pcie-designware-host.c |  6 +++
>  drivers/pci/dwc/pcie-designware.h      | 25 ++++++++++
>  4 files changed, 80 insertions(+), 47 deletions(-)

I had a couple minor comments on these, but mostly looks very nice.

I'll be looking for an ack from Minghuan, Mingkai, or Roy for all the
layerscape changes.  And from Niklas or Jesper for the artpec6 ones.

Thanks, Joao, for already looking at all the designware stuff!

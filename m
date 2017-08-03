Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fllnx209.ext.ti.com ([198.47.19.16]:61195 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750829AbdHCFDf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Aug 2017 01:03:35 -0400
Subject: Re: [PATCH 0/2] PCI: dwc: convert remaining dbi read/writes to
 dw_pcie_readX_dbi/dw_pcie_writeX_dbi
To: Niklas Cassel <niklas.cassel@axis.com>,
        <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>
CC: Niklas Cassel <niklass@axis.com>, <linux-kernel@vger.kernel.org>,
        KISHON VIJAY ABRAHAM <kishon@ti.com>
References: <20170714120735.11993-1-niklas.cassel@axis.com>
From: Vignesh R <vigneshr@ti.com>
Message-ID: <20fbc8e2-b4d6-c660-176a-86f9cd20d53d@ti.com>
Date: Thu, 3 Aug 2017 10:33:23 +0530
MIME-Version: 1.0
In-Reply-To: <20170714120735.11993-1-niklas.cassel@axis.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

+cc kishon for dra7xx

On Friday 14 July 2017 05:37 PM, Niklas Cassel wrote:
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
> 

-- 
Regards
Vignesh

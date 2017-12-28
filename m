Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lelnx194.ext.ti.com ([198.47.27.80]:19771 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753006AbdL1MoX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Dec 2017 07:44:23 -0500
Subject: Re: [PATCH v3 7/9] pci: keystone SoC driver adapted to new irq API
To: Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        <marc.zyngier@arm.com>, <Joao.Pinto@synopsys.com>,
        <bhelgaas@google.com>, <jingoohan1@gmail.com>
References: <cover.1514455857.git.gustavo.pimentel@synopsys.com>
 <d814c419df5591f9170223d61388a0af746577c4.1514455857.git.gustavo.pimentel@synopsys.com>
CC: <linux-pci@vger.kernel.org>, <m-karicheri2@ti.com>,
        <thomas.petazzoni@free-electrons.com>,
        <minghuan.Lian@freescale.com>, <mingkai.hu@freescale.com>,
        <tie-fei.zang@freescale.com>, <hongxing.zhu@nxp.com>,
        <l.stach@pengutronix.de>, <niklas.cassel@axis.com>,
        <jesper.nilsson@axis.com>, <wangzhou1@hisilicon.com>,
        <gabriele.paoloni@huawei.com>, <svarbanov@mm-sol.com>,
        <nsekhar@ti.com>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <10d22382-4914-da3b-a842-eb33693c7a83@ti.com>
Date: Thu, 28 Dec 2017 18:13:35 +0530
MIME-Version: 1.0
In-Reply-To: <d814c419df5591f9170223d61388a0af746577c4.1514455857.git.gustavo.pimentel@synopsys.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Gustavo,

On Thursday 28 December 2017 05:26 PM, Gustavo Pimentel wrote:
> This patch adapts Keystone SoC specific driver to use the new interrupt api
> available in pcie-designware. A new callback was added to dw_pcie_host_ops
> to handle a specific Keystone function and msi_host_init callback is
> changed to simplify the access to pci data structure for keystone all SoC
> drivers that use the structure.
> 
> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> ---
> Change v1->v2:
> - Removed hardcoded num_vectors configuration (now it is done in the core driver by default)
> Change v2->v3:
> - 
> 
> 
> 
> 
> 
>  drivers/pci/dwc/pci-keystone-dw.c      | 88 ++--------------------------------
>  drivers/pci/dwc/pci-keystone.c         |  1 +
>  drivers/pci/dwc/pci-keystone.h         |  4 +-
>  drivers/pci/dwc/pci-layerscape.c       |  3 +-
>  drivers/pci/dwc/pcie-designware-host.c | 19 ++++++--
>  drivers/pci/dwc/pcie-designware.h      |  3 +-

The designware specific patches should be part of
"[1/9] pci: adding new irq api to pci-designware"

Also layerscap is not related to $subject.

Thanks
Kishon

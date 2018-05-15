Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay6.synopsys.com ([198.182.37.59]:42883 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753207AbeEOOcU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 May 2018 10:32:20 -0400
Subject: Re: [PATCH 0/4] Add DesignWare EP support
To: Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        <bhelgaas@google.com>, <lorenzo.pieralisi@arm.com>,
        <Joao.Pinto@synopsys.com>, <jingoohan1@gmail.com>, <kishon@ti.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <cover.1526368368.git.gustavo.pimentel@synopsys.com>
From: Joao Pinto <Joao.Pinto@synopsys.com>
Message-ID: <bd7d0219-e70a-df60-2b9f-5e74d6c282f4@synopsys.com>
Date: Tue, 15 May 2018 15:32:13 +0100
MIME-Version: 1.0
In-Reply-To: <cover.1526368368.git.gustavo.pimentel@synopsys.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Gustavo,

Às 8:13 AM de 5/15/2018, Gustavo Pimentel escreveu:
> The PCIe controller dual mode is capable of operating in RC mode as well
> as EP mode by configuration option. Till now only RC mode was supported,
> with this patch is add EP support to the DesignWare driver.
> 
> Gustavo Pimentel (4):
>   bindings: PCI: designware: Example update
>   PCI: dwc: Add support for EP mode
>   bindings: PCI: designware: Add support for EP in DesignWare driver
>   misc: pci_endpoint_test: Add DesignWare EP entry
> 
>  .../devicetree/bindings/pci/designware-pcie.txt    |  24 +++-
>  drivers/misc/pci_endpoint_test.c                   |   1 +
>  drivers/pci/dwc/Kconfig                            |  41 ++++--
>  drivers/pci/dwc/pcie-designware-ep.c               |   3 +
>  drivers/pci/dwc/pcie-designware-plat.c             | 149 +++++++++++++++++++--
>  drivers/pci/endpoint/functions/pci-epf-test.c      |   7 +
>  include/linux/pci-epc.h                            |   8 ++
>  7 files changed, 206 insertions(+), 27 deletions(-)
> 

Thanks for this patch-set.

Reviewed-by: Joao Pinto <jpinto@synopsys.com>

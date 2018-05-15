Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:34160 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753482AbeEOPK6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 15 May 2018 11:10:58 -0400
Date: Tue, 15 May 2018 16:10:50 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: bhelgaas@google.com, Joao.Pinto@synopsys.com, jingoohan1@gmail.com,
        kishon@ti.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 0/4] Add DesignWare EP support
Message-ID: <20180515151050.GA31726@e107981-ln.cambridge.arm.com>
References: <cover.1526395185.git.gustavo.pimentel@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1526395185.git.gustavo.pimentel@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 15, 2018 at 03:41:40PM +0100, Gustavo Pimentel wrote:
> Patch set was made against the Lorenzo's pci/dwc branch.
> 
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
>  drivers/pci/dwc/Kconfig                            |  37 +++--
>  drivers/pci/dwc/pcie-designware-ep.c               |   3 +
>  drivers/pci/dwc/pcie-designware-plat.c             | 149 +++++++++++++++++++--
>  drivers/pci/endpoint/functions/pci-epf-test.c      |   7 +
>  include/linux/pci-epc.h                            |   8 ++
>  7 files changed, 205 insertions(+), 24 deletions(-)

Applied to pci/dwc for v4.18 with some small commit log tweaks.

Thanks,
Lorenzo

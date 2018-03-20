Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:44200 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751396AbeCTSTB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Mar 2018 14:19:01 -0400
Date: Tue, 20 Mar 2018 18:18:55 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Rob Herring <robh@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jon Mason <jonmason@broadcom.com>
Subject: Re: [PATCH 0/9] PCI DT header refactoring and compile test
 improvements
Message-ID: <20180320181855.GA24991@e107981-ln.cambridge.arm.com>
References: <20180307154243.3205-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180307154243.3205-1-robh@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Rob, all,

On Wed, Mar 07, 2018 at 09:42:34AM -0600, Rob Herring wrote:
> This started with just moving private functions from of_pci.h to 
> drivers/pci/pci.h, but I was annoyed with trying to build all the right 
> configs, so I enabled COMPILE_TEST on a bunch of drivers. Then I fixed 
> the fallout from doing that. I'm sending this as all one series, but 
> really there is no dependency for the header refactoring patch.
> 
> Needless to say, this series is *compile tested* only. This is based on 
> Bjorn's for-linus branch (and the of_pci.h fix there).

I reworked it and applied on top of v4.16-rc1 in my pci/host/misc
branch to get a kbot report on it - then we can decide how we can
merge it.

Thanks,
Lorenzo

> Rob
> 
> Fengguang Wu (2):
>   PCI: rcar: fix semicolon.cocci warnings
>   PCI: v3-semi: fix semicolon.cocci warnings
> 
> Rob Herring (6):
>   PCI: kirin: remove unnecessary asm/compiler.h include
>   PCI: iproc: remove dependency on ARM specific struct pci_sys_data
>   PCI: kirin: fix missing dependency on PCI_MSI_IRQ_DOMAIN
>   PCI: improve host drivers compile test coverage
>   PCI: dw: move CONFIG_PCI depends to menu
>   PCI: move private DT related functions into private header
> 
> kbuild test robot (1):
>   PCI: kirin_pcie_driver can be static
> 
>  drivers/pci/dwc/Kconfig                | 42 +++++++++++++---------------------
>  drivers/pci/dwc/pci-dra7xx.c           |  1 +
>  drivers/pci/dwc/pcie-designware-host.c |  1 +
>  drivers/pci/dwc/pcie-kirin.c           |  3 +--
>  drivers/pci/host/Kconfig               | 33 ++++++++++++--------------
>  drivers/pci/host/pci-aardvark.c        |  2 ++
>  drivers/pci/host/pci-ftpci100.c        |  6 +++--
>  drivers/pci/host/pci-mvebu.c           |  2 ++
>  drivers/pci/host/pci-rcar-gen2.c       |  2 ++
>  drivers/pci/host/pci-tegra.c           |  2 ++
>  drivers/pci/host/pci-v3-semi.c         |  4 +++-
>  drivers/pci/host/pci-xgene.c           |  2 ++
>  drivers/pci/host/pcie-altera.c         |  2 ++
>  drivers/pci/host/pcie-iproc-bcma.c     |  3 +--
>  drivers/pci/host/pcie-iproc-platform.c |  1 +
>  drivers/pci/host/pcie-iproc.c          | 19 ++-------------
>  drivers/pci/host/pcie-iproc.h          |  4 ----
>  drivers/pci/host/pcie-mediatek.c       |  2 ++
>  drivers/pci/host/pcie-rcar.c           |  4 +++-
>  drivers/pci/host/pcie-rockchip.c       |  2 ++
>  drivers/pci/host/pcie-xilinx-nwl.c     |  2 ++
>  drivers/pci/host/pcie-xilinx.c         |  2 ++
>  drivers/pci/pci.h                      | 40 ++++++++++++++++++++++++++++++++
>  include/linux/of_pci.h                 | 34 ---------------------------
>  24 files changed, 108 insertions(+), 107 deletions(-)
> 
> -- 
> 2.14.1
> 

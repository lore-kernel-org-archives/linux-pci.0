Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:57110 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752796AbeEHLwg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 8 May 2018 07:52:36 -0400
Date: Tue, 8 May 2018 12:52:29 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v6 0/7] Add endpoint driver for Rockchip PCIe controller
Message-ID: <20180508115229.GA10653@e107981-ln.cambridge.arm.com>
References: <1524796697-160764-1-git-send-email-shawn.lin@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1524796697-160764-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Shawn,

On Fri, Apr 27, 2018 at 10:38:17AM +0800, Shawn Lin wrote:
> 
> Hi Lorenzo,
> 
> This's the 6th try to upstream endpoint driver for Rockchip PCIe
> controller. V6 is rebased by droping the rename change.
> 
> Thanks.
> 
> 
> Changes in v6:
> - rebase
> 
> Changes in v5:
> - export symbol to fix error reported by Kbuild robot
> - PCIE_ROCKCHIP depends on PCI
> 
> Changes in v4:
> - remove empty line
> - keep rockchip's order next to cadence and dwc, but
>   we will try to resort it later when reconstructing
>   the directories
> 
> Shawn Lin (7):
>   PCI: rockchip: Separate common code from RC driver

There seems to be no patch (1) on linux-pci list, not sure what
happened, mind resending the whole series possibly with
commit logs updated as discussed ?

Thanks,
Lorenzo

>   PCI: rockchip: Split out common function to parse DT
>   PCI: rockchip: Split out common function to init controller
>   dt-bindings: PCI: rockchip: Rename rockchip-pcie.txt to
>     rockchip-pcie-host.txt
>   PCI: rockchip: Add Endpoint controller driver for Rockchip PCIe
>     controller
>   dt-bindings: PCI: rockchip: Add DT bindings for Rockchip PCIe endpoint
>     controller
>   arm64: defconfig: update config for Rockchip PCIe
> 
>  .../devicetree/bindings/pci/rockchip-pcie-ep.txt   |   62 +
>  .../{rockchip-pcie.txt => rockchip-pcie-host.txt}  |    0
>  MAINTAINERS                                        |    4 +-
>  arch/arm64/configs/defconfig                       |    3 +-
>  drivers/pci/host/Kconfig                           |   19 +-
>  drivers/pci/host/Makefile                          |    2 +
>  drivers/pci/host/pcie-rockchip-ep.c                |  642 ++++++++
>  drivers/pci/host/pcie-rockchip-host.c              | 1141 +++++++++++++
>  drivers/pci/host/pcie-rockchip.c                   | 1683 +++-----------------
>  drivers/pci/host/pcie-rockchip.h                   |  338 ++++
>  10 files changed, 2406 insertions(+), 1488 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pci/rockchip-pcie-ep.txt
>  rename Documentation/devicetree/bindings/pci/{rockchip-pcie.txt => rockchip-pcie-host.txt} (100%)
>  create mode 100644 drivers/pci/host/pcie-rockchip-ep.c
>  create mode 100644 drivers/pci/host/pcie-rockchip-host.c
>  create mode 100644 drivers/pci/host/pcie-rockchip.h
> 
> -- 
> 1.9.1
> 
> 

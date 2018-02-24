Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.134]:49906 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750844AbeBXKzQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 24 Feb 2018 05:55:16 -0500
Message-ID: <5A914486.9080304@rock-chips.com>
Date: Sat, 24 Feb 2018 18:55:02 +0800
From: JeffyChen <jeffy.chen@rock-chips.com>
MIME-Version: 1.0
To: Shawn Lin <shawn.lin@rock-chips.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC: devicetree@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 0/6] Add endpoint driver for Rockchip PCIe controller
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi guys,

tested on my chromebook kevin, with this series and enable 
CONFIG_PCIE_ROCKCHIP_HOST, the pcie wifi(mrvl 8997) still works.

so,

Tested-by: Jeffy Chen <jeffy.chen@rock-chips.com>


On 02/23/2018 09:15 AM, Shawn Lin wrote:
 >
> Patch 1 firstly move the whole Rockchip PCIe host driver from
> drivers/pci/host to a new folder, driver/pci/rockchip/, and rename
> pcie-rockchip.c to pcie-rockchip-host.c. It also update the
> Kconfig/Makefile etc to repect this change.
>
> Then patch 2 and patch 3 are trying to spilt out some common code in
> preparation for adding endponit controller driver support.
>
> Patch 4 rename rockchip-pcie.txt to rockchip-pcie-host.txt.
>
> Patch 5 adds endpoint controller driver support as well as the new
> documentation, rockchip-pcie-ep.txt, introduced by patch 6.
>
>
> Changes in v2:
> - remove rockchip,rk3399-pcie-host compatible(Suggested by Rob)
> - fix some error handling
>
> Shawn Lin (6):
>    PCI: rockchip: Create individual folder for rockchip drivers
>    PCI: rockchip: Split out common function to parse DT
>    PCI: rockchip: Spilt out common function to init controller
>    dt-bindings: PCI: rockchip: Rename rockchip-pcie.txt to
>      rockchip-pcie-host.txt
>    PCI: rockchip: Add Endpoint controller driver for Rockchip PCIe
>      controller
>    dt-bindings: PCI: rockchip: Add DT bindings for Rockchip PCIe endpoint
>      controller
>
>   .../devicetree/bindings/pci/rockchip-pcie-ep.txt   |  62 ++
>   .../{rockchip-pcie.txt => rockchip-pcie-host.txt}  |   0
>   MAINTAINERS                                        |   4 +-
>   drivers/pci/Kconfig                                |   1 +
>   drivers/pci/Makefile                               |   2 +
>   drivers/pci/host/Kconfig                           |  11 -
>   drivers/pci/host/Makefile                          |   1 -
>   drivers/pci/rockchip/Kconfig                       |  32 +
>   drivers/pci/rockchip/Makefile                      |   4 +
>   drivers/pci/rockchip/pcie-rockchip-ep.c            | 641 +++++++++++++++++++++
>   .../pcie-rockchip-host.c}                          | 594 +------------------
>   drivers/pci/rockchip/pcie-rockchip.c               | 417 ++++++++++++++
>   drivers/pci/rockchip/pcie-rockchip.h               | 343 +++++++++++
>   13 files changed, 1517 insertions(+), 595 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/pci/rockchip-pcie-ep.txt
>   rename Documentation/devicetree/bindings/pci/{rockchip-pcie.txt => rockchip-pcie-host.txt} (100%)
>   create mode 100644 drivers/pci/rockchip/Kconfig
>   create mode 100644 drivers/pci/rockchip/Makefile
>   create mode 100644 drivers/pci/rockchip/pcie-rockchip-ep.c
>   rename drivers/pci/{host/pcie-rockchip.c => rockchip/pcie-rockchip-host.c} (61%)
>   create mode 100644 drivers/pci/rockchip/pcie-rockchip.c
>   create mode 100644 drivers/pci/rockchip/pcie-rockchip.h
>

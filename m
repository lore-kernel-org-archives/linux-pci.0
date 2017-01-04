Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qt0-f195.google.com ([209.85.216.195]:33071 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751636AbdADRyk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Jan 2017 12:54:40 -0500
From: "Jingoo Han" <jingoohan1@gmail.com>
To: "'Kishon Vijay Abraham I'" <kishon@ti.com>,
        "'Bjorn Helgaas'" <bhelgaas@google.com>,
        "'Joao Pinto'" <Joao.Pinto@synopsys.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <nsekhar@ti.com>
References: <1483531695-9377-1-git-send-email-kishon@ti.com>
In-Reply-To: <1483531695-9377-1-git-send-email-kishon@ti.com>
Subject: Re: [PATCH v2] PCI: add a new directory for designware core
Date: Wed, 4 Jan 2017 12:54:37 -0500
Message-ID: <000f01d266b3$9e22b6e0$da6824a0$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, January 4, 2017 7:08 AM, Kishon Vijay Abraham I wrote:
> 
> Group all the PCI drivers that use designware core in dwc directory.
> dwc IP is capable of operating in both host mode and device mode and
> keeping it inside the *host* directory is misleading.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>

Acked-by: Jingoo Han <jingoohan1@gmail.com>

Best regards,
Jingoo Han

> ---
> Changes from v1:
> *) instead of renaming *host* directory to *controller* directory,
>    move all the dwc drivers to dwc/ directory.
> Next Steps:
> Split pcie-designware.c to core, host-only and endpoint-only files.
> 
>  drivers/pci/Kconfig                              |    1 +
>  drivers/pci/Makefile                             |    3 +
>  drivers/pci/dwc/Kconfig                          |  108
+++++++++++++++++++++
>  drivers/pci/dwc/Makefile                         |   23 +++++
>  drivers/pci/{host => dwc}/pci-dra7xx.c           |    0
>  drivers/pci/{host => dwc}/pci-exynos.c           |    0
>  drivers/pci/{host => dwc}/pci-imx6.c             |    0
>  drivers/pci/{host => dwc}/pci-keystone-dw.c      |    0
>  drivers/pci/{host => dwc}/pci-keystone.c         |    0
>  drivers/pci/{host => dwc}/pci-layerscape.c       |    0
>  drivers/pci/{host => dwc}/pcie-armada8k.c        |    0
>  drivers/pci/{host => dwc}/pcie-artpec6.c         |    0
>  drivers/pci/{host => dwc}/pcie-designware-plat.c |    0
>  drivers/pci/{host => dwc}/pcie-designware.c      |    0
>  drivers/pci/{host => dwc}/pcie-designware.h      |    0
>  drivers/pci/{host => dwc}/pcie-hisi.c            |    0
>  drivers/pci/{host => dwc}/pcie-qcom.c            |    0
>  drivers/pci/{host => dwc}/pcie-spear13xx.c       |    0
>  drivers/pci/host/Kconfig                         |  113
----------------------
>  drivers/pci/host/Makefile                        |   12 ---
>  20 files changed, 135 insertions(+), 125 deletions(-)
>  create mode 100644 drivers/pci/dwc/Kconfig
>  create mode 100644 drivers/pci/dwc/Makefile
>  rename drivers/pci/{host => dwc}/pci-dra7xx.c (100%)
>  rename drivers/pci/{host => dwc}/pci-exynos.c (100%)
>  rename drivers/pci/{host => dwc}/pci-imx6.c (100%)
>  rename drivers/pci/{host => dwc}/pci-keystone-dw.c (100%)
>  rename drivers/pci/{host => dwc}/pci-keystone.c (100%)
>  rename drivers/pci/{host => dwc}/pci-layerscape.c (100%)
>  rename drivers/pci/{host => dwc}/pcie-armada8k.c (100%)
>  rename drivers/pci/{host => dwc}/pcie-artpec6.c (100%)
>  rename drivers/pci/{host => dwc}/pcie-designware-plat.c (100%)
>  rename drivers/pci/{host => dwc}/pcie-designware.c (100%)
>  rename drivers/pci/{host => dwc}/pcie-designware.h (100%)
>  rename drivers/pci/{host => dwc}/pcie-hisi.c (100%)
>  rename drivers/pci/{host => dwc}/pcie-qcom.c (100%)
>  rename drivers/pci/{host => dwc}/pcie-spear13xx.c (100%)
> 


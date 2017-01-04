Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qt0-f196.google.com ([209.85.216.196]:33402 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751176AbdADUP4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Jan 2017 15:15:56 -0500
From: "Jingoo Han" <jingoohan1@gmail.com>
To: "'Kishon Vijay Abraham I'" <kishon@ti.com>,
        "'Bjorn Helgaas'" <bhelgaas@google.com>,
        "'Joao Pinto'" <Joao.Pinto@synopsys.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <nsekhar@ti.com>
References: <1483532367-9698-1-git-send-email-kishon@ti.com>
In-Reply-To: <1483532367-9698-1-git-send-email-kishon@ti.com>
Subject: Re: [PATCH v3] PCI: add a new directory for designware core
Date: Wed, 4 Jan 2017 15:15:54 -0500
Message-ID: <000401d266c7$5a643f50$0f2cbdf0$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, January 4, 2017 7:19 AM, Kishon Vijay Abraham I wrote:
> 
> Group all the PCI drivers that use designware core in dwc directory.
> dwc IP is capable of operating in both host mode and device mode and
> keeping it inside the *host* directory is misleading.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>

Acked-by: Jingoo Han <jingoohan1@gmail.com>

However, I have two suggestion as below.

1. Please add dwc pci related people as possible.
    They should be noticed. So, they will prepare this changes when they
will receive
    future vanilla kernel.
2. Please use optimization option when you make patch.
    The current patch is too huge.
    This option will use 'rename' instead of 'create'/'delete'.
    I am not sure, but maybe -M option will be used.
    git format-patch -M

Best regards,
Jingoo Han

> ---
> Changes from v2:
> *) update MAINTAINERS file
> 
> Changes from v1:
> *) instead of renaming *host* directory to *controller* directory,
>    move all the dwc drivers to dwc/ directory.
> Next Steps:
> Split pcie-designware.c to core, host-only and endpoint-only files.
> 
>  MAINTAINERS                             |   22 +-
>  drivers/pci/Kconfig                     |    1 +
>  drivers/pci/Makefile                    |    3 +
>  drivers/pci/dwc/Kconfig                 |  108 ++++
>  drivers/pci/dwc/Makefile                |   23 +
>  drivers/pci/dwc/pci-dra7xx.c            |  525 ++++++++++++++++++
>  drivers/pci/dwc/pci-exynos.c            |  629 +++++++++++++++++++++
>  drivers/pci/dwc/pci-imx6.c              |  757 ++++++++++++++++++++++++++
>  drivers/pci/dwc/pci-keystone-dw.c       |  560 +++++++++++++++++++
>  drivers/pci/dwc/pci-keystone.c          |  444 +++++++++++++++
>  drivers/pci/dwc/pci-layerscape.c        |  284 ++++++++++
>  drivers/pci/dwc/pcie-armada8k.c         |  254 +++++++++
>  drivers/pci/dwc/pcie-artpec6.c          |  283 ++++++++++
>  drivers/pci/dwc/pcie-designware-plat.c  |  126 +++++
>  drivers/pci/dwc/pcie-designware.c       |  902
> +++++++++++++++++++++++++++++++
>  drivers/pci/dwc/pcie-designware.h       |   86 +++
>  drivers/pci/dwc/pcie-hisi.c             |  326 +++++++++++
>  drivers/pci/dwc/pcie-qcom.c             |  753 ++++++++++++++++++++++++++
>  drivers/pci/dwc/pcie-spear13xx.c        |  299 ++++++++++
>  drivers/pci/host/Kconfig                |  113 ----
>  drivers/pci/host/Makefile               |   12 -
>  drivers/pci/host/pci-dra7xx.c           |  525 ------------------
>  drivers/pci/host/pci-exynos.c           |  629 ---------------------
>  drivers/pci/host/pci-imx6.c             |  757 --------------------------
>  drivers/pci/host/pci-keystone-dw.c      |  560 -------------------
>  drivers/pci/host/pci-keystone.c         |  444 ---------------
>  drivers/pci/host/pci-layerscape.c       |  284 ----------
>  drivers/pci/host/pcie-armada8k.c        |  254 ---------
>  drivers/pci/host/pcie-artpec6.c         |  283 ----------
>  drivers/pci/host/pcie-designware-plat.c |  126 -----
>  drivers/pci/host/pcie-designware.c      |  902
---------------------------
> ----
>  drivers/pci/host/pcie-designware.h      |   86 ---
>  drivers/pci/host/pcie-hisi.c            |  326 -----------
>  drivers/pci/host/pcie-qcom.c            |  753 --------------------------
>  drivers/pci/host/pcie-spear13xx.c       |  299 ----------
>  35 files changed, 6374 insertions(+), 6364 deletions(-)
>  create mode 100644 drivers/pci/dwc/Kconfig
>  create mode 100644 drivers/pci/dwc/Makefile
>  create mode 100644 drivers/pci/dwc/pci-dra7xx.c
>  create mode 100644 drivers/pci/dwc/pci-exynos.c
>  create mode 100644 drivers/pci/dwc/pci-imx6.c
>  create mode 100644 drivers/pci/dwc/pci-keystone-dw.c
>  create mode 100644 drivers/pci/dwc/pci-keystone.c
>  create mode 100644 drivers/pci/dwc/pci-layerscape.c
>  create mode 100644 drivers/pci/dwc/pcie-armada8k.c
>  create mode 100644 drivers/pci/dwc/pcie-artpec6.c
>  create mode 100644 drivers/pci/dwc/pcie-designware-plat.c
>  create mode 100644 drivers/pci/dwc/pcie-designware.c
>  create mode 100644 drivers/pci/dwc/pcie-designware.h
>  create mode 100644 drivers/pci/dwc/pcie-hisi.c
>  create mode 100644 drivers/pci/dwc/pcie-qcom.c
>  create mode 100644 drivers/pci/dwc/pcie-spear13xx.c
>  delete mode 100644 drivers/pci/host/pci-dra7xx.c
>  delete mode 100644 drivers/pci/host/pci-exynos.c
>  delete mode 100644 drivers/pci/host/pci-imx6.c
>  delete mode 100644 drivers/pci/host/pci-keystone-dw.c
>  delete mode 100644 drivers/pci/host/pci-keystone.c
>  delete mode 100644 drivers/pci/host/pci-layerscape.c
>  delete mode 100644 drivers/pci/host/pcie-armada8k.c
>  delete mode 100644 drivers/pci/host/pcie-artpec6.c
>  delete mode 100644 drivers/pci/host/pcie-designware-plat.c
>  delete mode 100644 drivers/pci/host/pcie-designware.c
>  delete mode 100644 drivers/pci/host/pcie-designware.h
>  delete mode 100644 drivers/pci/host/pcie-hisi.c
>  delete mode 100644 drivers/pci/host/pcie-qcom.c
>  delete mode 100644 drivers/pci/host/pcie-spear13xx.c







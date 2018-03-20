Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:53244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751330AbeCTRqg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Mar 2018 13:46:36 -0400
Date: Tue, 20 Mar 2018 12:46:33 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 1/6] PCI: rockchip: Create individual folder for
 rockchip drivers
Message-ID: <20180320174633.GA137590@bhelgaas-glaptop.roam.corp.google.com>
References: <1520304173-231081-1-git-send-email-shawn.lin@rock-chips.com>
 <1520304202-232891-1-git-send-email-shawn.lin@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1520304202-232891-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Mar 06, 2018 at 10:43:22AM +0800, Shawn Lin wrote:
> In preparation for introducing End-Point driver for Rockchip
> PCIe controller, we create a new folder to follow the convention
> of dwc and cadence. Then we rename the host driver from pcie-rockchip.c
> to pcie-rockchip-host.c, and only leave some common functions in
> pcie-rockchip.c in order to be reused for both of host and EP drivers.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> Tested-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> ...

> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index 34b56a8..b85ad40 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -141,4 +141,5 @@ source "drivers/pci/cadence/Kconfig"
>  source "drivers/pci/dwc/Kconfig"
>  source "drivers/pci/host/Kconfig"
>  source "drivers/pci/endpoint/Kconfig"
> +source "drivers/pci/rockchip/Kconfig"
>  source "drivers/pci/switch/Kconfig"

Why is this out of order?  This seems exactly analogous to
drivers/pci/cadence and dwc, so they should be next to each other.

> diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
> index 9419709..8434afb 100644
> --- a/drivers/pci/Makefile
> +++ b/drivers/pci/Makefile
> @@ -55,6 +55,8 @@ obj-y += switch/
>  
>  obj-$(CONFIG_PCI_ENDPOINT)	+= endpoint/
>  
> +obj-$(CONFIG_PCIE_ROCKCHIP)	+= rockchip/
> +
>  # Endpoint library must be initialized before its users
>  obj-$(CONFIG_PCIE_CADENCE)	+= cadence/
>  # pcie-hisi.o quirks are needed even without CONFIG_PCIE_DW

Similarly here.

I admit to still being a little dubious about the idea of a bunch of
vendor-specific directories, each containing a completely trivial
Makefile, a mostly-trivial Kconfig, a header file, a shared .c file, a
host .c file, and an endpoint .c file.

One alternative would be to keep the single pcie-rockchip.c file with
an #ifdef CONFIG_PCIE_ROCKCHIP_HOST section and an #ifdef
CONFIG_PCIE_ROCKCHIP_EP section.

Bjorn

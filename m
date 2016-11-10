Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:50478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935217AbcKJR1w (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 10 Nov 2016 12:27:52 -0500
Date: Thu, 10 Nov 2016 11:27:48 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        Jon Mason <jonmason@broadcom.com>, Ray Jui <rjui@broadcom.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Wenrui Li <wenrui.li@rock-chips.com>,
        Scott Branden <sbranden@broadcom.com>,
        Russell King <linux@armlinux.org.uk>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Tanmay Inamdar <tinamdar@apm.com>,
        Greg Ungerer <gerg@uclinux.org>,
        Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH] PCI: Warn on possible RW1C corruption for sub-32 bit
 config writes
Message-ID: <20161110172748.GB10384@bhelgaas-glaptop.roam.corp.google.com>
References: <20161031213902.6340.96123.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161031213902.6340.96123.stgit@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Oct 31, 2016 at 04:39:02PM -0500, Bjorn Helgaas wrote:
> Hardware that supports only 32-bit config writes is not spec-compliant.
> For example, if software performs a 16-bit write, we must do a 32-bit read,
> merge in the 16 bits we intend to write, followed by a 32-bit write.  If
> the 16 bits we *don't* intend to write happen to have any RW1C (write-one-
> to-clear) bits set, we just inadvertently cleared something we shouldn't
> have.
> 
> Add a rate-limited warning when we do sub-32 bit config writes.  Remove
> similar probe-time warnings from some of the affected host bridge drivers.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Applied with acks from Russell, Shawn, and Thierry to pci/enumeration for
v4.10.

> ---
>  drivers/pci/access.c             |   17 +++++++++++++++--
>  drivers/pci/host/pcie-hisi.c     |    2 --
>  drivers/pci/host/pcie-rockchip.c |    3 ---
>  3 files changed, 15 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/access.c b/drivers/pci/access.c
> index d11cdbb..e0cd124 100644
> --- a/drivers/pci/access.c
> +++ b/drivers/pci/access.c
> @@ -142,10 +142,23 @@ int pci_generic_config_write32(struct pci_bus *bus, unsigned int devfn,
>  	if (size == 4) {
>  		writel(val, addr);
>  		return PCIBIOS_SUCCESSFUL;
> -	} else {
> -		mask = ~(((1 << (size * 8)) - 1) << ((where & 0x3) * 8));
>  	}
>  
> +	/*
> +	 * N.B.  In general, hardware that supports only 32-bit writes on
> +	 * PCI is not spec-compliant.  For example, software may perform a
> +	 * 16-bit write.  If the hardware only supports 32-bit accesses, we
> +	 * must do a 32-bit read, merge in the 16 bits we intend to write,
> +	 * followed by a 32-bit write.  If the 16 bits we *don't* intend to
> +	 * write happen to have any RW1C (write-one-to-clear) bits set, we
> +	 * just inadvertently cleared something we shouldn't have.
> +	 */
> +
> +	dev_warn_ratelimited(&bus->dev, "%d-byte config write to %04x:%02x:%02x.%d offset %#x may corrupt adjacent RW1C bits\n",
> +			     size, pci_domain_nr(bus), bus->number,
> +			     PCI_SLOT(devfn), PCI_FUNC(devfn), where);
> +
> +	mask = ~(((1 << (size * 8)) - 1) << ((where & 0x3) * 8));
>  	tmp = readl(addr) & mask;
>  	tmp |= val << ((where & 0x3) * 8);
>  	writel(tmp, addr);
> diff --git a/drivers/pci/host/pcie-hisi.c b/drivers/pci/host/pcie-hisi.c
> index 56154c2..5b5901d 100644
> --- a/drivers/pci/host/pcie-hisi.c
> +++ b/drivers/pci/host/pcie-hisi.c
> @@ -194,8 +194,6 @@ static int hisi_pcie_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> -	dev_warn(dev, "only 32-bit config accesses supported; smaller writes may corrupt adjacent RW1C fields\n");
> -
>  	return 0;
>  }
>  
> diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
> index e0b22da..6419d8c 100644
> --- a/drivers/pci/host/pcie-rockchip.c
> +++ b/drivers/pci/host/pcie-rockchip.c
> @@ -1187,9 +1187,6 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
>  		pcie_bus_configure_settings(child);
>  
>  	pci_bus_add_devices(bus);
> -
> -	dev_warn(dev, "only 32-bit config accesses supported; smaller writes may corrupt adjacent RW1C fields\n");
> -
>  	return err;
>  
>  err_vpcie:
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

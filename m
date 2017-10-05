Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:56456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751330AbdJERZr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 5 Oct 2017 13:25:47 -0400
Date: Thu, 5 Oct 2017 12:25:45 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Andrew Lunn <andrew@lunn.ch>,
        Yehuda Yitschak <yehuday@marvell.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Hanna Hawa <hannah@marvell.com>, stable@vger.kernel.org,
        Nadav Haklai <nadavh@marvell.com>,
        Victor Gu <xigu@marvell.com>,
        =?iso-8859-1?Q?Miqu=E8l?= Raynal
        <miquel.raynal@free-electrons.com>,
        Gregory Clement <gregory.clement@free-electrons.com>,
        Antoine Tenart <antoine.tenart@free-electrons.com>,
        linux-arm-kernel@lists.infradead.org,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH v2 2/7] PCI: aardvark: set PIO_ADDR_LS correctly in
 advk_pcie_rd_conf()
Message-ID: <20171005172545.GQ25517@bhelgaas-glaptop.roam.corp.google.com>
References: <20170928125838.11887-1-thomas.petazzoni@free-electrons.com>
 <20170928125838.11887-3-thomas.petazzoni@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170928125838.11887-3-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Sep 28, 2017 at 02:58:33PM +0200, Thomas Petazzoni wrote:
> From: Victor Gu <xigu@marvell.com>
> 
> When setting the PIO_ADDR_LS register during a configuration read, we
> were properly passing the device number, function number and register
> number, but not the bus number, causing issues when reading the
> configuration of PCIe devices.
> 
> Fixes: 8c39d710363c1 ("PCI: aardvark: Add Aardvark PCI host controller driver")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Victor Gu <xigu@marvell.com>
> Reviewed-by: Wilson Ding <dingwei@marvell.com>
> Reviewed-by: Nadav Haklai <nadavh@marvell.com>
> [Thomas: tweak commit log.]
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  drivers/pci/host/pci-aardvark.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/host/pci-aardvark.c b/drivers/pci/host/pci-aardvark.c
> index da2881ba7737..af7a9c4a61a4 100644
> --- a/drivers/pci/host/pci-aardvark.c
> +++ b/drivers/pci/host/pci-aardvark.c
> @@ -459,7 +459,7 @@ static int advk_pcie_rd_conf(struct pci_bus *bus, u32 devfn,
>  	advk_writel(pcie, reg, PIO_CTRL);
>  
>  	/* Program the address registers */
> -	reg = PCIE_BDF(devfn) | PCIE_CONF_REG(where);
> +	reg = PCIE_CONF_ADDR(bus->number, devfn, where);

I think PCIE_BDF() is now unused and should be removed.

>  	advk_writel(pcie, reg, PIO_ADDR_LS);
>  	advk_writel(pcie, 0, PIO_ADDR_MS);
>  
> -- 
> 2.13.5
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

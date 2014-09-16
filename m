Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:50477 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753163AbaIPXrJ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 16 Sep 2014 19:47:09 -0400
Received: by mail-pd0-f172.google.com with SMTP id v10so842049pde.3
        for <linux-pci@vger.kernel.org>; Tue, 16 Sep 2014 16:47:08 -0700 (PDT)
Date: Tue, 16 Sep 2014 17:47:04 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Srikanth Thokala <sthokal@xilinx.com>,
	Michal Simek <michal.simek@xilinx.com>,
	Grant Likely <grant.likely@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, linux-pci@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [patch] PCI: xilinx: testing wrong variable in setup irq function
Message-ID: <20140916234704.GK5050@google.com>
References: <20140909121150.GD19760@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140909121150.GD19760@mwanda>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Sep 09, 2014 at 03:11:50PM +0300, Dan Carpenter wrote:
> We should be testing "hwirq" instead of "irq".  "irq" is unsigned so
> it's never less than zero.  Also it's uninitialized.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Applied with Srikanth's ack to pci/host-xilinx for v3.18, thanks.

> 
> diff --git a/drivers/pci/host/pcie-xilinx.c b/drivers/pci/host/pcie-xilinx.c
> index 44f8944..ccc496b 100644
> --- a/drivers/pci/host/pcie-xilinx.c
> +++ b/drivers/pci/host/pcie-xilinx.c
> @@ -359,8 +359,8 @@ static int xilinx_pcie_msi_setup_irq(struct msi_chip *chip,
>  	phys_addr_t msg_addr;
>  
>  	hwirq = xilinx_pcie_assign_msi(port);
> -	if (irq < 0)
> -		return irq;
> +	if (hwirq < 0)
> +		return hwirq;
>  
>  	irq = irq_create_mapping(port->irq_domain, hwirq);
>  	if (!irq)

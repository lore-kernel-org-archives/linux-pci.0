Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1blp0181.outbound.protection.outlook.com ([207.46.163.181]:4074
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756601AbaIIMbr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 9 Sep 2014 08:31:47 -0400
From: Srikanth Thokala <srikanth.thokala@xilinx.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	Michal Simek <michals@xilinx.com>,
	Grant Likely <grant.likely@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: RE: [patch] PCI: xilinx: testing wrong variable in setup irq
 function
Date: Tue, 9 Sep 2014 12:31:40 +0000
References: <20140909121150.GD19760@mwanda>
In-Reply-To: <20140909121150.GD19760@mwanda>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Message-ID: <8fa6fe96-183f-4db8-a741-a935793bbc9c@BY2FFO11FD042.protection.gbl>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Dan,

> -----Original Message-----
> From: Dan Carpenter [mailto:dan.carpenter@oracle.com]
> Sent: Tuesday, September 09, 2014 5:42 PM
> To: Bjorn Helgaas; Srikanth Thokala
> Cc: Michal Simek; Grant Likely; Rob Herring; Srikanth Thokala; Arnd Bergmann;
> linux-pci@vger.kernel.org; kernel-janitors@vger.kernel.org
> Subject: [patch] PCI: xilinx: testing wrong variable in setup irq function
>
> We should be testing "hwirq" instead of "irq".  "irq" is unsigned so it's never less
> than zero.  Also it's uninitialized.
>
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>
> diff --git a/drivers/pci/host/pcie-xilinx.c b/drivers/pci/host/pcie-xilinx.c index
> 44f8944..ccc496b 100644
> --- a/drivers/pci/host/pcie-xilinx.c
> +++ b/drivers/pci/host/pcie-xilinx.c
> @@ -359,8 +359,8 @@ static int xilinx_pcie_msi_setup_irq(struct msi_chip
> *chip,
>       phys_addr_t msg_addr;
>
>       hwirq = xilinx_pcie_assign_msi(port);
> -     if (irq < 0)
> -             return irq;
> +     if (hwirq < 0)
> +             return hwirq;

It is a typo from my end, thanks for sending this patch.
Really thanks for helping to improve this.

Acked-by: Srikanth Thokala <sthokal@xilinx.com>

- Srikanth

>
>       irq = irq_create_mapping(port->irq_domain, hwirq);
>       if (!irq)


This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.


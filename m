Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:36565 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754054AbbKXUuc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 24 Nov 2015 15:50:32 -0500
Date: Tue, 24 Nov 2015 14:50:26 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] PCI: designware: remove wrong io_base assignment
Message-ID: <20151124205026.GB17377@localhost>
References: <1448357812-23906-1-git-send-email-stanimir.varbanov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1448357812-23906-1-git-send-email-stanimir.varbanov@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Nov 24, 2015 at 11:36:52AM +0200, Stanimir Varbanov wrote:
> The io_base is used to keep the cpu physical address parsed
> from ranges dt property. After issue pci_remap_iospace the
> io_base has been assigned with io->start, which is not correct
> cause io->start is a PCI bus address.
> 
> Fixes: 0021d22b73d6 ("PCI: designware: Use of_pci_get_host_bridge_resources() to parse DT")
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
> ---
>  drivers/pci/host/pcie-designware.c |    1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
> index 540f077c37ea..02a7452bdf23 100644
> --- a/drivers/pci/host/pcie-designware.c
> +++ b/drivers/pci/host/pcie-designware.c
> @@ -440,7 +440,6 @@ int dw_pcie_host_init(struct pcie_port *pp)
>  					 ret, pp->io);
>  				continue;
>  			}
> -			pp->io_base = pp->io->start;
>  			break;
>  		case IORESOURCE_MEM:
>  			pp->mem = win->res;

Applied to for-linus for v4.4 with changelog as follows, thanks!


commit 5228e39e3f709c82e6c4643402fc25de54391e32
Author: Stanimir Varbanov <stanimir.varbanov@linaro.org>
Date:   Tue Nov 24 11:36:52 2015 +0200

    PCI: designware: Remove incorrect io_base assignment
    
    "pp->io" is an I/O resource, e.g., "[io 0x0000-0xffff]"; "pp->io_base" is
    the CPU physical address of a region where the host bridge converts CPU
    memory accesses into PCI I/O transactions.
    
    Corrupting pp->io_base by assigning pp->io->start to it breaks access to
    the PCI I/O space, as reported by Kishon.
    
    Remove the invalid assignment.
    
    [bhelgaas: changelog]
    Fixes: 0021d22b73d6 ("PCI: designware: Use of_pci_get_host_bridge_resources() to parse DT")
    Reported-and-tested-by: Kishon Vijay Abraham I <kishon@ti.com>
    Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    Reviewed-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index 540f077..02a7452 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -440,7 +440,6 @@ int dw_pcie_host_init(struct pcie_port *pp)
 					 ret, pp->io);
 				continue;
 			}
-			pp->io_base = pp->io->start;
 			break;
 		case IORESOURCE_MEM:
 			pp->mem = win->res;

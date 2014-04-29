Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f179.google.com ([209.85.213.179]:56231 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756824AbaD2QyZ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 29 Apr 2014 12:54:25 -0400
Received: by mail-ig0-f179.google.com with SMTP id hl10so556878igb.0
        for <linux-pci@vger.kernel.org>; Tue, 29 Apr 2014 09:54:22 -0700 (PDT)
Date: Tue, 29 Apr 2014 10:54:19 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Fabio Estevam <fabio.estevam@freescale.com>
Cc: thomas.petazzoni@free-electrons.com, linux-pci@vger.kernel.org,
	jg1.han@samsung.com, Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH v3] pci: pci-mvebu: Use '%pa' for printing 'phys_addr_t'
 type
Message-ID: <20140429165419.GA13735@google.com>
References: <1398776287-14229-1-git-send-email-fabio.estevam@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1398776287-14229-1-git-send-email-fabio.estevam@freescale.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Jason]

On Tue, Apr 29, 2014 at 09:58:07AM -0300, Fabio Estevam wrote:
> Fix the following build warning that happens when building multi_v7_defconfig
> with CONFIG_ARM_LPAE=y:
> 
> drivers/pci/host/pci-mvebu.c:334:5: warning: format '%x' expects argument of type 'unsigned int', but argument 3 has type 'phys_addr_t' [-Wformat=]
> 
> Fix the warning by using '%pa' to printing 'phys_addr_t' type. While at it,
> also use the more standard notation [mem 0x - 0x] for memory region.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
> Changes since v2:
> - Introduce variable 'end' for printing the memory range
> 
> Changes since v1:
> - use the [mem 0x - 0x] notation
> 
>  drivers/pci/host/pci-mvebu.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
> index e384e25..8329592 100644
> --- a/drivers/pci/host/pci-mvebu.c
> +++ b/drivers/pci/host/pci-mvebu.c
> @@ -329,9 +329,11 @@ static void mvebu_pcie_add_windows(struct mvebu_pcie_port *port,
>  		ret = mvebu_mbus_add_window_remap_by_id(target, attribute, base,
>  							sz, remap);
>  		if (ret) {
> +			phys_addr_t end = base + sz;

This needs to be "base + sz - 1" because we print inclusive ranges.

> +
>  			dev_err(&port->pcie->pdev->dev,
> -				"Could not create MBus window at 0x%x, size 0x%x: %d\n",
> -				base, sz, ret);
> +				"Could not create MBus window at [mem %pa - %pa] :%d\n",

I removed the extra spaces (relative to %pR) here.

> +				&base, &end, ret);
>  			mvebu_pcie_del_windows(port, base - size_mapped,
>  					       size_mapped);
>  			return;


I'm ready to merge the following, given an ack from Thomas or Jason.
Jingoo, I added your reviewed-by, since this is essentially what you
reviewed before.

Bjorn


commit 5bbf2f268b9001c2e46aff6ff17cee0e8a6b8fb8
Author: Fabio Estevam <fabio.estevam@freescale.com>
Date:   Tue Apr 29 09:58:07 2014 -0300

    PCI: mvebu: Use '%pa' for printing 'phys_addr_t' type
    
    Fix the following build warning that happens when building
    multi_v7_defconfig with CONFIG_ARM_LPAE=y:
    
      drivers/pci/host/pci-mvebu.c:334:5: warning: format '%x' expects argument of type 'unsigned int', but argument 3 has type 'phys_addr_t' [-Wformat=]
    
    Fix the warning by using '%pa' to printing 'phys_addr_t' type.  While at
    it, also use the more standard notation [mem 0x-0x] for memory region.
    
    Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    Reviewed-by: Jingoo Han <jg1.han@samsung.com>

diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
index 29d64c9efa85..7f450322f397 100644
--- a/drivers/pci/host/pci-mvebu.c
+++ b/drivers/pci/host/pci-mvebu.c
@@ -328,9 +328,11 @@ static void mvebu_pcie_add_windows(struct mvebu_pcie_port *port,
 		ret = mvebu_mbus_add_window_remap_by_id(target, attribute, base,
 							sz, remap);
 		if (ret) {
+			phys_addr_t end = base + sz - 1;
+
 			dev_err(&port->pcie->pdev->dev,
-				"Could not create MBus window at 0x%x, size 0x%x: %d\n",
-				base, sz, ret);
+				"Could not create MBus window at [mem %pa-%pa]: %d\n",
+				&base, &end, ret);
 			mvebu_pcie_del_windows(port, base - size_mapped,
 					       size_mapped);
 			return;

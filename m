Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:38503 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751761AbcAFCNN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 5 Jan 2016 21:13:13 -0500
Date: Tue, 5 Jan 2016 20:13:09 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sanjeev Sharma <sanjeev_sharma@mentor.com>
Cc: Richard.Zhu@freescale.com, l.stach@pengutronix.de,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	David Mueller <dave.mueller@gmx.ch>
Subject: Re: [PATCH v2] PCI: imx6:don't sleep in atomic context
Message-ID: <20160106021309.GC23814@localhost>
References: <1447066080-5859-1-git-send-email-sanjeev_sharma@mentor.com>
 <1449042196-25710-1-git-send-email-sanjeev_sharma@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1449042196-25710-1-git-send-email-sanjeev_sharma@mentor.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Dec 02, 2015 at 01:13:16PM +0530, Sanjeev Sharma wrote:
> From: David Mueller <dave.mueller@gmx.ch>
> 
> If additional PCIe switch get connected between the
> host and the NIC,the kernel crashes with "BUG:
> scheduling while atomic". To handle this we need to
> call mdelay() instead of usleep_range().
> 
> This is currently called from atomic context through
> pci_config_{read,write).
> 
> For more detail please refer bugzilla.kernel.org, Bug
> 100031

Bug reports have URLs; please use them.  I'll save you the trouble:

  Link: https://bugzilla.kernel.org/show_bug.cgi?id=100031

In that bug report, I said: "My first question on the list will be:
Besides imx6, there are five other DesignWare-based drivers, and
imx6_pcie_link_up() looks nothing like the other
pcie_host_ops.link_up() methods.  We need to explain why imx6 is
special, and whether all the .link_up() methods can be made similar."

The only response was that i.MX6 is special because of a hardware bug,
so we need to start at Gen1, wait, try to change to Gen2, etc.  That
all sounds like work that should be done in
imx6_pcie_establish_link().

This patch doesn't seem to make anything *worse*, so I might take it
anyway, but I'm a little disappointed that we didn't make any progress
toward making imx6 more like the other drivers.  I know this sounds
pedantic, but it's a lot easier to let things slowly diverge than it
is to keep them uniform, and bugs hide in differences like this.

> Signed-off-by: David Mueller <dave.mueller@gmx.ch>
> Signed-off-by: Sanjeev Sharma <sanjeev_sharma@mentor.com>
> 
> Changes in v2:
> 	-order of signoff has been change
> 	-Author of patch has been change
> 	-A mdelay(1000) is different timescale than
> a usleep(1000).change it to correct scale i.e mdelay(1)
> 	-updated comment
> ---
>  drivers/pci/host/pci-imx6.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
> index 233a196..c03527f 100644
> --- a/drivers/pci/host/pci-imx6.c
> +++ b/drivers/pci/host/pci-imx6.c
> @@ -499,7 +499,7 @@ static int imx6_pcie_link_up(struct pcie_port *pp)
>  		 * Wait a little bit, then re-check if the link finished
>  		 * the training.
>  		 */
> -		usleep_range(1000, 2000);
> +		mdelay(1);
>  	}
>  	/*
>  	 * From L0, initiate MAC entry to gen2 if EP/RC supports gen2.
> -- 
> 1.7.11.7
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

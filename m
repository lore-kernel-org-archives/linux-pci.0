Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f170.google.com ([209.85.213.170]:33513 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752005AbbFRNWB (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 18 Jun 2015 09:22:01 -0400
Received: by igbqq3 with SMTP id qq3so14974998igb.0
        for <linux-pci@vger.kernel.org>; Thu, 18 Jun 2015 06:22:00 -0700 (PDT)
Date: Thu, 18 Jun 2015 08:21:57 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: David =?iso-8859-1?Q?M=FCller?= <dave.mueller@gmx.ch>
Cc: linux-pci@vger.kernel.org, Richard Zhu <Richard.Zhu@freescale.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: imx6: Fix "BUG: scheduling while atomic" if PCIe
 switch is attached
Message-ID: <20150618132157.GB7710@google.com>
References: <1434614214-2085-1-git-send-email-dave.mueller@gmx.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1434614214-2085-1-git-send-email-dave.mueller@gmx.ch>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jun 18, 2015 at 09:56:54AM +0200, David Müller wrote:
> This problem has already been reported as 
> https://bugzilla.kernel.org/show_bug.cgi?id=100031
> 
> Signed-off-by: David Müller <dave.mueller@gmx.ch>
> ---
>  drivers/pci/host/pci-imx6.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
> index fdb9536..c63691c 100644
> --- a/drivers/pci/host/pci-imx6.c
> +++ b/drivers/pci/host/pci-imx6.c
> @@ -489,7 +489,7 @@ static int imx6_pcie_link_up(struct pcie_port *pp)
>  		 * Wait a little bit, then re-check if the link finished
>  		 * the training.
>  		 */
> -		usleep_range(1000, 2000);
> +		mdelay(20);
>  	}
>  	/*
>  	 * From L0, initiate MAC entry to gen2 if EP/RC supports gen2.

I asked in the bugzilla why imx6_pcie_link_up() looks nothing like the
other pcie_host_ops.link_up() methods.

Lucas responded:
> the i.MX6 link up routine is a bit more complex compared to the other
> designware drivers because of a hardware bug, where some FIFOs could
> get out of sync when changing the link speed. We need to start the
> link at Gen1, wait for it to be stable, then start a directed link
> speed change if the EP is Gen2 and wait for the link to be stable
> again. If the link doesn't come back, we need to start over.

> I don't think any of the other DW PCIe implementations need this
> workaround.

That explanation makes sense, and a comment to that effect should be
in the code.  But I also wonder whether this workaround could be moved
to imx6_pcie_start_link() (just renamed to imx6_pcie_establish_link()).
Then imx6_pcie_link_up() could be a simple status check like the
others.

Bjorn

Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:57306 "EHLO
	relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932268AbcBRHTI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 18 Feb 2016 02:19:08 -0500
From: "Sharma, Sanjeev" <Sanjeev_Sharma@mentor.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "Richard.Zhu@freescale.com" <Richard.Zhu@freescale.com>,
	"l.stach@pengutronix.de" <l.stach@pengutronix.de>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	David Mueller <dave.mueller@gmx.ch>
Subject: RE: [PATCH] PCI: imx6:don't sleep in atomic context
Date: Thu, 18 Feb 2016 07:17:41 +0000
Message-ID: <FDC088D3B5555644AE135ED28A7ABDE986504C90@EU-MBX-04.mgc.mentorg.com>
References: <1447066080-5859-1-git-send-email-sanjeev_sharma@mentor.com>
 <20160106220430.GC16231@localhost>
In-Reply-To: <20160106220430.GC16231@localhost>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

-----Original Message-----
From: Bjorn Helgaas [mailto:helgaas@kernel.org] 
Sent: Thursday, January 07, 2016 3:35 AM
To: Sharma, Sanjeev
Cc: Richard.Zhu@freescale.com; l.stach@pengutronix.de; bhelgaas@google.com; linux-pci@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org; David Mueller
Subject: Re: [PATCH] PCI: imx6:don't sleep in atomic context

Hi Sanjeev,

On Mon, Nov 09, 2015 at 04:18:00PM +0530, Sanjeev Sharma wrote:
> If additional PCIe switch get connected between the host and the 
> NIC,the kernel crashes with "BUG:
> scheduling while atomic". To handle this we need to call mdelay() 
> instead of usleep_range().
> 
> For more detail please refer bugzilla.kernel.org, Bug
> 100031
> 
> Signed-off-by: Sanjeev Sharma <sanjeev_sharma@mentor.com>
> Signed-off-by: David Mueller <dave.mueller@gmx.ch>

I'm dropping this for now because we've been kicking around the same solution (with tweaks to the mdelay amount) since June, but no progress on the *real* issue, which is that imx6_pcie_link_up() should never wait; it should simply return the link status.

I'm pretty sure the amount of time I've spent looking into this would have been enough to make some progress on that underlying issue.

Bjorn

Ok ! please share the change you are planning to implement. 

Sanjeev Sharma 
> ---
>  drivers/pci/host/pci-imx6.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c 
> index 233a196..9769b13 100644
> --- a/drivers/pci/host/pci-imx6.c
> +++ b/drivers/pci/host/pci-imx6.c
> @@ -499,7 +499,7 @@ static int imx6_pcie_link_up(struct pcie_port *pp)
>  		 * Wait a little bit, then re-check if the link finished
>  		 * the training.
>  		 */
> -		usleep_range(1000, 2000);
> +		mdelay(1000);
>  	}
>  	/*
>  	 * From L0, initiate MAC entry to gen2 if EP/RC supports gen2.
> --
> 1.7.11.7
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" 
> in the body of a message to majordomo@vger.kernel.org More majordomo 
> info at  http://vger.kernel.org/majordomo-info.html

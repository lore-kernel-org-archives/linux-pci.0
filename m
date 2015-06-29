Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-gw3-out.broadcom.com ([216.31.210.64]:58279 "EHLO
	mail-gw3-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752770AbbF2QpQ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 29 Jun 2015 12:45:16 -0400
Message-ID: <5591761A.9000607@broadcom.com>
Date: Mon, 29 Jun 2015 09:45:14 -0700
From: Ray Jui <rjui@broadcom.com>
MIME-Version: 1.0
To: SF Markus Elfring <elfring@users.sourceforge.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Scott Branden <sbranden@broadcom.com>,
	<linux-pci@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<bcm-kernel-feedback-list@broadcom.com>
CC: LKML <linux-kernel@vger.kernel.org>,
	<kernel-janitors@vger.kernel.org>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH] PCI-iproc: Delete unnecessary checks before two function
 calls
References: <5307CAA2.8060406@users.sourceforge.net> <alpine.DEB.2.02.1402212321410.2043@localhost6.localdomain6> <530A086E.8010901@users.sourceforge.net> <alpine.DEB.2.02.1402231635510.1985@localhost6.localdomain6> <530A72AA.3000601@users.sourceforge.net> <alpine.DEB.2.02.1402240658210.2090@localhost6.localdomain6> <530B5FB6.6010207@users.sourceforge.net> <alpine.DEB.2.10.1402241710370.2074@hadrien> <530C5E18.1020800@users.sourceforge.net> <alpine.DEB.2.10.1402251014170.2080@hadrien> <530CD2C4.4050903@users.sourceforge.net> <alpine.DEB.2.10.1402251840450.7035@hadrien> <530CF8FF.8080600@users.sourceforge.net> <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6> <530DD06F.4090703@users.sourceforge.net> <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6> <5317A59D.4@users.sourceforge.net> <55900A20.5070407@users.sourceforge.net>
In-Reply-To: <55900A20.5070407@users.sourceforge.net>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Markus,

On 6/28/2015 7:52 AM, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 28 Jun 2015 16:42:04 +0200
> 
> The functions phy_exit() and phy_power_off() test whether their argument
> is NULL and then return immediately.
> Thus the test around the calls is not needed.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/pci/host/pcie-iproc.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/host/pcie-iproc.c b/drivers/pci/host/pcie-iproc.c
> index d77481e..f875821 100644
> --- a/drivers/pci/host/pcie-iproc.c
> +++ b/drivers/pci/host/pcie-iproc.c
> @@ -239,12 +239,9 @@ err_rm_root_bus:
>  	pci_remove_root_bus(bus);
>  
>  err_power_off_phy:
> -	if (pcie->phy)
> -		phy_power_off(pcie->phy);
> +	phy_power_off(pcie->phy);
>  err_exit_phy:
> -	if (pcie->phy)
> -		phy_exit(pcie->phy);
> -
> +	phy_exit(pcie->phy);
>  	return ret;
>  }
>  EXPORT_SYMBOL(iproc_pcie_setup);
> 

Thanks for catching this. Could you please help to make similar changes
to both phy_init and phy_power_on calls in the driver, to make it
consistent?

Thanks,

Ray

Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:56488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751544AbdF1UaY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Jun 2017 16:30:24 -0400
Date: Wed, 28 Jun 2017 15:30:11 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: John Mazzie <john_mazzie@dell.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Enable ECRC only if device supports it
Message-ID: <20170628203011.GT17844@bhelgaas-glaptop.roam.corp.google.com>
References: <20170620190207.9292.39574.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170620190207.9292.39574.stgit@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 20, 2017 at 02:02:07PM -0500, Bjorn Helgaas wrote:
> John reported that an Intel QuickAssist crypto accelerator didn't work in a
> Dell PowerEdge R730.  The problem seems to be that we enabled ECRC when the
> device doesn't support it:
> 
>   85:00.0 Co-processor [0b40]: Intel Corporation DH895XCC Series QAT [8086:0435]
>     Capabilities: [100 v1] Advanced Error Reporting
>       AERCap: First Error Pointer: 00, GenCap- CGenEn+ ChkCap- ChkEn+
> 
> 1302fcf0d03e ("PCI: Configure *all* devices, not just hot-added ones")
> exposed the problem because it applies settings from the _HPX method to all
> devices, not just hot-added ones.  The R730 supplies an _HPX method that
> allows the kernel to enable ECRC.
> 
> Only enable ECRC if the device advertises support for it.
> 
> Link: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1571798
> Fixes: 1302fcf0d03e ("PCI: Configure *all* devices, not just hot-added ones")
> Reported-by: John Mazzie <john_mazzie@dell.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Applied to pci/enumeration for v4.13.

I haven't seen any testing reports for this, so if anybody can test
and make sure that ECRC is enabled when you expect it to be enabled
and disabled when you don't, that would be great.  This only affects
the _HPX path, and most machines don't supply _HPX, so you probably
have to have a machine with decent hotplug PCI support this patch to
make any difference at all.

> ---
>  drivers/pci/probe.c |    5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 31001017b3c4..c31310db0404 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1730,6 +1730,11 @@ static void program_hpp_type2(struct pci_dev *dev, struct hpp_type2 *hpp)
>  	/* Initialize Advanced Error Capabilities and Control Register */
>  	pci_read_config_dword(dev, pos + PCI_ERR_CAP, &reg32);
>  	reg32 = (reg32 & hpp->adv_err_cap_and) | hpp->adv_err_cap_or;
> +	/* Don't enable ECRC generation or checking if unsupported */
> +	if (!(reg32 & PCI_ERR_CAP_ECRC_GENC))
> +		reg32 &= ~PCI_ERR_CAP_ECRC_GENE;
> +	if (!(reg32 & PCI_ERR_CAP_ECRC_CHKC))
> +		reg32 &= ~PCI_ERR_CAP_ECRC_CHKE;
>  	pci_write_config_dword(dev, pos + PCI_ERR_CAP, reg32);
>  
>  	/*
> 

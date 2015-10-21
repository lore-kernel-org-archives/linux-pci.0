Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:55668 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754330AbbJUUwM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 21 Oct 2015 16:52:12 -0400
Date: Wed, 21 Oct 2015 15:52:08 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ben Shelton <benjamin.h.shelton@intel.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: IOV: read SRIOV_NUM_VF after enabling ARI
Message-ID: <20151021205208.GH1583@localhost>
References: <1444317617-13399-1-git-send-email-benjamin.h.shelton@intel.com>
 <20151015193116.GE17702@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151015193116.GE17702@localhost>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Oct 15, 2015 at 02:31:16PM -0500, Bjorn Helgaas wrote:
> On Thu, Oct 08, 2015 at 10:20:17AM -0500, Ben Shelton wrote:
> > For some SR-IOV devices, the number of available virtual functions increases
> > after enabling ARI.  Currently, SRIOV_NUM_VF is read and saved off before the
> > ARI control bit is enabled in SRIOV_CTRL.  This causes an issue when VFs are
> > enabled.
> > 
> > At device init, SRIOV_INITIAL_VF and SRIOV_NUM_VF are specified to contain the
> > number of available VFs for the device.  sriov_enable() does a sanity check
> > that SRIOV_INITIAL_VF is not greater than iov->total_VFs, the saved-off value
> > of SRIOV_NUM_VF.  Since the value of both SRIOV_INITIAL_VF and SRIOV_NUM_VF has
> > increased after enabling the ARI bit, the check fails, and the VFs cannot be
> > enabled.
> > 
> > To fix the issue, write SRIOV_CTRL first, and then read SRIOV_NUM_VF.
> > 
> > Signed-off-by: Ben Shelton <benjamin.h.shelton@intel.com>
> 
> I applied this as follows to pci/virtualization for v4.4, thanks, Ben!

I dropped this one for now, pending the resolution of my questions in
http://lkml.kernel.org/r/20151016180701.GB21346@localhost

> commit 3aa71da412fedaee133b4b6e4be4b801c59d6c91
> Author: Ben Shelton <benjamin.h.shelton@intel.com>
> Date:   Thu Oct 15 12:35:17 2015 -0500
> 
>     PCI: Enable SR-IOV ARI Capable Hierarchy before reading TotalVFs
>     
>     For some SR-IOV devices, the number of available virtual functions, i.e.,
>     TotalVFs, increases after setting the ARI Capable Hierarchy bit in the
>     SR-IOV Control register.  This violates the SR-IOV spec, r1.1, sec 3.3.6,
>     which says TotalVFs is HwInit, but we don't need TotalVFs before setting
>     the ARI Capable bit anyway.
>     
>     Set the ARI Capable Hierarchy bit (if ARI is enabled in the upstream
>     bridge) before reading TotalVFs.
>     
>     [bhelgaas: changelog]
>     Signed-off-by: Ben Shelton <benjamin.h.shelton@intel.com>
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> index 0202ab0..f8bfc1d 100644
> --- a/drivers/pci/iov.c
> +++ b/drivers/pci/iov.c
> @@ -399,10 +399,6 @@ static int sriov_init(struct pci_dev *dev, int pos)
>  		ssleep(1);
>  	}
>  
> -	pci_read_config_word(dev, pos + PCI_SRIOV_TOTAL_VF, &total);
> -	if (!total)
> -		return 0;
> -
>  	ctrl = 0;
>  	list_for_each_entry(pdev, &dev->bus->devices, bus_list)
>  		if (pdev->is_physfn)
> @@ -415,6 +411,10 @@ static int sriov_init(struct pci_dev *dev, int pos)
>  found:
>  	pci_write_config_word(dev, pos + PCI_SRIOV_CTRL, ctrl);
>  
> +	pci_read_config_word(dev, pos + PCI_SRIOV_TOTAL_VF, &total);
> +	if (!total)
> +		return 0;
> +
>  	pci_read_config_dword(dev, pos + PCI_SRIOV_SUP_PGSIZE, &pgsz);
>  	i = PAGE_SHIFT > 12 ? PAGE_SHIFT - 12 : 0;
>  	pgsz &= ~((1 << i) - 1);
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

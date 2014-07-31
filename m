Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:46107 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751490AbaGaPXW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 31 Jul 2014 11:23:22 -0400
Message-ID: <53DA5EF4.1030500@intel.com>
Date: Thu, 31 Jul 2014 08:21:24 -0700
From: Alexander Duyck <alexander.h.duyck@intel.com>
MIME-Version: 1.0
To: Edward Cree <ecree@solarflare.com>, linux-pci@vger.kernel.org
CC: Don Dutile <ddutile@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI: handle pci_sriov_set_totalvfs(dev, 0)
References: <53D9288B.5030302@solarflare.com> <53D93407.8040308@redhat.com> <53D93848.7070203@solarflare.com> <53D9602A.4010406@intel.com> <53DA3180.5040302@solarflare.com> <alpine.LFD.2.03.1407311500570.16821@solarflare.com>
In-Reply-To: <alpine.LFD.2.03.1407311500570.16821@solarflare.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 07/31/2014 07:24 AM, Edward Cree wrote:
> Make a driver_max_VFs of 0 mean 0, instead of total_VFs as previously.
> Initialise driver_max_VFs to total_VFs instead of 0.
> 
> Signed-off-by: Edward Cree <ecree@solarflare.com>
> ---
> Only existing callers are ixgbe and igb, and neither passes 0, so this
> doesn't break existing users.
> ---
>  drivers/pci/iov.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> index cb6f247..fb51467 100644
> --- a/drivers/pci/iov.c
> +++ b/drivers/pci/iov.c
> @@ -381,7 +381,7 @@ found:
>         iov->pos = pos;
>         iov->nres = nres;
>         iov->ctrl = ctrl;
> -       iov->total_VFs = total;
> +       iov->driver_max_VFs = iov->total_VFs = total;
>         iov->offset = offset;
>         iov->stride = stride;
>         iov->pgsz = pgsz;
> @@ -686,9 +686,6 @@ int pci_sriov_get_totalvfs(struct pci_dev *dev)
>         if (!dev->is_physfn)
>                 return 0;
> 
> -       if (dev->sriov->driver_max_VFs)
> -               return dev->sriov->driver_max_VFs;
> -
> -       return dev->sriov->total_VFs;
> +       return dev->sriov->driver_max_VFs;
>  }
>  EXPORT_SYMBOL_GPL(pci_sriov_get_totalvfs);


This change is mostly harmless so I am not concerned with any effects on
igb or ixgbe.  In the grand scheme of things it should also drop a few
lines of code which is always good.

However if you are wanting to use this as a way to disable SR-IOV for a
device I wouldn't recommend it.  Based on what you have described I
would suggest dropping the fix in drivers/pci/quirks that would clear
dev->is_physfn if you are in the PF-IOV mode.  That way the SR-IOV
functionality should be fully disabled.  In addition this solution would
also resolve the fact that the driver wouldn't actually have to be
loaded for it to work so if someone were to load a driver that didn't
contain the fix they would be blocked from enabling SR-IOV as well.

Thanks,

Alex


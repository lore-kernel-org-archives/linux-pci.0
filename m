Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:41984 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751308Ab3GSVqs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 19 Jul 2013 17:46:48 -0400
Message-ID: <51E9B3C7.1010409@intel.com>
Date: Fri, 19 Jul 2013 14:46:47 -0700
From: Alexander Duyck <alexander.h.duyck@intel.com>
MIME-Version: 1.0
To: Yinghai Lu <yinghai@kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Jiang Liu <liuj97@gmail.com>,
	Donald Dutile <ddutile@redhat.com>,
	Greg Rose <gregory.v.rose@intel.com>
Subject: Re: [PATCH] PCI: Stop sriov before remove PF
References: <1374261258-23036-1-git-send-email-yinghai@kernel.org> <1374261258-23036-3-git-send-email-yinghai@kernel.org>
In-Reply-To: <1374261258-23036-3-git-send-email-yinghai@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 07/19/2013 12:14 PM, Yinghai Lu wrote:
> After commit dc087f2f6a2925e81831f3016b9cbb6e470e7423
> (PCI: Simplify IOV implementation and fix reference count races)
> VF need to be removed via virtfn_remove to make sure ref to PF
> is put back.
> 
> Some driver (like ixgbe) does not call pci_disable_sriov() if
> sriov is enabled via /sys/.../sriov_numvfs setting.
> ixgbe does allow driver for PF get detached, but still have VFs
> around.
> 
> But how about PF get removed via /sys or pciehp?
> 
> During hot-remove, VF will still hold one ref to PF and it
> prevent PF to be removed.
> That make the next hot-add fails, as old PF dev struct is still around.
> 
> We need to add pci_disable_sriov() calling during pci dev removing.
> 
> Need this one for v3.11
> 
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> Cc: Jiang Liu <liuj97@gmail.com>
> Cc: Alexander Duyck <alexander.h.duyck@intel.com>
> Cc: Donald Dutile <ddutile@redhat.com>
> Cc: Greg Rose <gregory.v.rose@intel.com>
> 
> ---
>  drivers/pci/remove.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> Index: linux-2.6/drivers/pci/remove.c
> ===================================================================
> --- linux-2.6.orig/drivers/pci/remove.c
> +++ linux-2.6/drivers/pci/remove.c
> @@ -34,6 +34,9 @@ static void pci_stop_dev(struct pci_dev
>  
>  static void pci_destroy_dev(struct pci_dev *dev)
>  {
> +	/* remove VF, if PF driver skip that */
> +	pci_disable_sriov(dev);
> +
>  	down_write(&pci_bus_sem);
>  	list_del(&dev->bus_list);
>  	up_write(&pci_bus_sem);
> 

How are you able to hot-remove the PF if the VFs are still holding
references to it?

The issue I see with this patch is that if the PF has any VFs direct
assigned, hot plug removing the PF will cause the guests containing
those VFs to panic.

Thanks,

Alex



Thanks,

Alex


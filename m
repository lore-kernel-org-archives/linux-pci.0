Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp08.in.ibm.com ([122.248.162.8]:46076 "EHLO
	e28smtp08.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751450AbaGIDap (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 8 Jul 2014 23:30:45 -0400
Received: from /spool/local
	by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <yan@linux.vnet.ibm.com>;
	Wed, 9 Jul 2014 09:00:43 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
	by d28dlp01.in.ibm.com (Postfix) with ESMTP id F0002E0057
	for <linux-pci@vger.kernel.org>; Wed,  9 Jul 2014 09:02:06 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
	by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id s693Uv0X61735094
	for <linux-pci@vger.kernel.org>; Wed, 9 Jul 2014 09:00:58 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
	by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s693Ud6G030338
	for <linux-pci@vger.kernel.org>; Wed, 9 Jul 2014 09:00:39 +0530
Date: Wed, 9 Jul 2014 11:30:34 +0800
From: Guo Chao <yan@linux.vnet.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] PCI: don't UNSET valid resources when reassign fails
Message-ID: <20140709033034.GA3389@yanx>
References: <1403179096-12113-1-git-send-email-yan@linux.vnet.ibm.com>
 <20140705162708.GA6247@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140705162708.GA6247@google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Jul 05, 2014 at 10:27:08AM -0600, Bjorn Helgaas wrote:
> On Thu, Jun 19, 2014 at 07:58:16PM +0800, Guo Chao wrote:
> > Commit bd064f0a sets IORESOURCE_UNSET flag if resources can not be
> > assgined. Part of these changes breaks resource assignment.
> > 
> > If resource is too big, PCI core assgins basic part first and
> > extends (reassigns) it to include optional part (notably SR-IOV resources).
> > In this case, IORESOURCE_UNSET should not be set if resource is properly
> > assigned before reassigning. Otherwise, these resources are never updated
> > to hardware and we will see errors like this:
> > 
> > 	pci 0003:00:00.0: can't enable device: BAR 15 [mem size 0x0c000000 64bit pref] not assigned
> > 	pci 0003:00:00.0: Error enabling bridge (-22), continuing
> > 
> > Signed-off-by: Guo Chao <yan@linux.vnet.ibm.com>
> 
> I propose the following simpler patch.  Can you verify that it works for
> you?

Hi Bjorn:

	Sure it works.

	(Sorry for this late response. The machine is out of reach for
	past few days.)

Thanks,
Guo Chao
> 
> 
> commit 57ece376a3b9e013277032f473197052f1144142
> Author: Guo Chao <yan@linux.vnet.ibm.com>
> Date:   Thu Jul 3 18:30:29 2014 -0600
> 
>     PCI: Keep original resource if we fail to expand it
>     
>     If we have space assigned to a resource, we try to expand the resource
>     (e.g., to accommodate SR-IOV resources), and the expansion attempt fails,
>     we should keep the original assignment.
>     
>     After bd064f0a231a ("PCI: Mark resources as IORESOURCE_UNSET if we can't
>     assign them"), we left the resource marked IORESOURCE_UNSET when the
>     expansion failed, even if it had originally been set.  That caused errors
>     like this:
>     
>       pci 0003:00:00.0: can't enable device: BAR 15 [mem size 0x0c000000 64bit pref] not assigned
>       pci 0003:00:00.0: Error enabling bridge (-22), continuing
>     
>     Fix this by restoring the original flags when reassignment fails.
>     
>     [bhelgaas: reworked to simplify, changelog]
>     Fixes: bd064f0a231a ("PCI: Mark resources as IORESOURCE_UNSET if we can't assign them")
>     Signed-off-by: Guo Chao <yan@linux.vnet.ibm.com>
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>     CC: stable@vger.kernel.org	# v3.15+
> 
> diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
> index caed1ce6facd..9faebcfeec4d 100644
> --- a/drivers/pci/setup-res.c
> +++ b/drivers/pci/setup-res.c
> @@ -320,9 +320,11 @@ int pci_reassign_resource(struct pci_dev *dev, int resno, resource_size_t addsiz
>  			resource_size_t min_align)
>  {
>  	struct resource *res = dev->resource + resno;
> +	unsigned long flags;
>  	resource_size_t new_size;
>  	int ret;
> 
> +	flags = res->flags;
>  	res->flags |= IORESOURCE_UNSET;
>  	if (!res->parent) {
>  		dev_info(&dev->dev, "BAR %d: can't reassign an unassigned resource %pR\n",
> @@ -339,7 +341,12 @@ int pci_reassign_resource(struct pci_dev *dev, int resno, resource_size_t addsiz
>  		dev_info(&dev->dev, "BAR %d: reassigned %pR\n", resno, res);
>  		if (resno < PCI_BRIDGE_RESOURCES)
>  			pci_update_resource(dev, resno);
> +	} else {
> +		res->flags = flags;
> +		dev_info(&dev->dev, "BAR %d: %pR (failed to expand by %#llx)\n",
> +			 resno, res, addsize);
>  	}
> +
>  	return ret;
>  }
> 
> 


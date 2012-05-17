Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:47901 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932224Ab2EQVfG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 17 May 2012 17:35:06 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glp-linux-pci@m.gmane.org>)
	id 1SV8Lf-0007pP-NB
	for linux-pci@vger.kernel.org; Thu, 17 May 2012 23:35:04 +0200
Received: from ztxe01cs301.austin.hp.com ([15.219.153.73])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pci@vger.kernel.org>; Thu, 17 May 2012 23:35:03 +0200
Received: from betty.dall by ztxe01cs301.austin.hp.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pci@vger.kernel.org>; Thu, 17 May 2012 23:35:03 +0200
To: linux-pci@vger.kernel.org
From: Betty Dall <betty.dall@hp.com>
Subject: Re: [PATCH] pci, Add =?utf-8?b?QUVSX3Bhbmlj?= sysfs file
Date: Thu, 17 May 2012 21:32:16 +0000 (UTC)
Message-ID: <loom.20120517T232328-930@post.gmane.org>
References: <1337274270-18785-1-git-send-email-prarit@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Prarit Bhargava <prarit <at> redhat.com> writes:

>  /**
> diff --git a/drivers/pci/pcie/aer/aerdrv.c b/drivers/pci/pcie/aer/aerdrv.c
> index 58ad791..dd6b352 100644
> --- a/drivers/pci/pcie/aer/aerdrv.c
> +++ b/drivers/pci/pcie/aer/aerdrv.c
> @@ -346,6 +346,9 @@ static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
>  	u32 reg32;
>  	int pos;
> 
> +	if (dev->rp_AER_panic)
> +		panic("%s: AER detected on Root Port", pci_name(dev));
> +
>  	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR);
> 


I really like this idea. I just wonder if the panic can happen in do_recovery in 
aerdrv_core.c before the broadcast_error_message() is done that invokes all of 
the error_detected callbacks. It would be best to panic as soon as possible to 
increase error containment. 

If we don't move it to before the broadcast_error_message(), I was also looking 
at if it would be appropriate to put the check for this in the 
default_downstream_reset_link() in aerdrv_core.c too. What do you think?

-Betty Dall


Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pg0-f41.google.com ([74.125.83.41]:33311 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752630AbcLFQVw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Dec 2016 11:21:52 -0500
Received: by mail-pg0-f41.google.com with SMTP id 3so150920288pgd.0
        for <linux-pci@vger.kernel.org>; Tue, 06 Dec 2016 08:21:52 -0800 (PST)
Date: Tue, 6 Dec 2016 08:21:42 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Long Li <longli@microsoft.com>
Cc: KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] pci-hyperv: use kmalloc to allocate hypercall params
 buffer
Message-ID: <20161206082142.6795f1c3@xeon-e3>
In-Reply-To: <BN3PR03MB2227BB61FB49F42EBA2323EBCE820@BN3PR03MB2227.namprd03.prod.outlook.com>
References: <1478642678-31659-1-git-send-email-longli@exchange.microsoft.com>
        <20161205085240.23f686fc@xeon-e3>
        <BN3PR03MB2227BB61FB49F42EBA2323EBCE820@BN3PR03MB2227.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 6 Dec 2016 00:37:08 +0000
Long Li <longli@microsoft.com> wrote:

> > -----Original Message-----
> > From: Stephen Hemminger [mailto:stephen@networkplumber.org]
> > Sent: Monday, December 5, 2016 8:53 AM
> > To: Long Li <longli@microsoft.com>
> > Cc: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> > <haiyangz@microsoft.com>; Bjorn Helgaas <bhelgaas@google.com>;
> > devel@linuxdriverproject.org; linux-kernel@vger.kernel.org; linux-
> > pci@vger.kernel.org
> > Subject: Re: [PATCH] pci-hyperv: use kmalloc to allocate hypercall params
> > buffer
> > 
> > On Tue,  8 Nov 2016 14:04:38 -0800
> > Long Li <longli@exchange.microsoft.com> wrote:
> >   
> > > +	spin_lock_irqsave(&hbus->retarget_msi_interrupt_lock, flags);
> > > +
> > > +	params = &hbus->retarget_msi_interrupt_params;
> > > +	memset(params, 0, sizeof(*params));
> > > +	params->partition_id = HV_PARTITION_ID_SELF;
> > > +	params->source = 1; /* MSI(-X) */
> > > +	params->address = msi_desc->msg.address_lo;
> > > +	params->data = msi_desc->msg.data;
> > > +	params->device_id = (hbus->hdev->dev_instance.b[5] << 24) |
> > >  			   (hbus->hdev->dev_instance.b[4] << 16) |
> > >  			   (hbus->hdev->dev_instance.b[7] << 8) |
> > >  			   (hbus->hdev->dev_instance.b[6] & 0xf8) |
> > >  			   PCI_FUNC(pdev->devfn);
> > > -	params.vector = cfg->vector;
> > > +	params->vector = cfg->vector;
> > >
> > >  	for_each_cpu_and(cpu, dest, cpu_online_mask)
> > > -		params.vp_mask |= (1ULL <<  
> > vmbus_cpu_number_to_vp_number(cpu));  
> > > +		params->vp_mask |= (1ULL <<  
> > vmbus_cpu_number_to_vp_number(cpu));  
> > > +
> > > +	hv_do_hypercall(HVCALL_RETARGET_INTERRUPT, params, NULL);
> > >
> > > -	hv_do_hypercall(HVCALL_RETARGET_INTERRUPT, &params, NULL);
> > > +	spin_unlock_irqrestore(&hbus->retarget_msi_interrupt_lock, flags);  
> > 
> > It looks like the additional locking here is being overly paranoid.
> > The caller is already holding the irq descriptor lock. Look at fixup_irqs.  
> 
> You are right. On my test machine, there are two possible places calling hv_irq_unmask(): request _irq() and handle_edge_irq(). They both have desc->lock held when calling .irq_unmask on the chip. A review of the IRQ code shows that desc->lock is always held while calling chip->irq_unmask().
> 
> Since the lock doesn't do any harm and it is not on performance code path, we can remove the lock in the upcoming patches.

Why add it then remove it, your patch hasn't been accepted. Please revise it and remove it.
Don't add additional unnecessary code.


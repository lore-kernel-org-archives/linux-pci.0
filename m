Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:17622 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752199AbbHCJxh (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 3 Aug 2015 05:53:37 -0400
Date: Mon, 3 Aug 2015 12:52:50 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Paul Bolle <pebolle@tiscali.nl>
Cc: jakeo@microsoft.com, olaf@aepfle.de, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org, bhelgaas@google.com,
	linux-pci@vger.kernel.org, apw@canonical.com,
	devel@linuxdriverproject.org, tglx@linutronix.de
Subject: Re: [PATCH 4/4] drivers:pci:hv: New paravirtual PCI front-end for
 Hyper-V VMs
Message-ID: <20150803093534.GV5180@mwanda>
References: <1438476889-19220-1-git-send-email-jakeo@microsoft.com>
 <1438476889-19220-5-git-send-email-jakeo@microsoft.com>
 <1438593492.3726.13.camel@tiscali.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1438593492.3726.13.camel@tiscali.nl>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 03, 2015 at 11:18:12AM +0200, Paul Bolle wrote:
> On zo, 2015-08-02 at 00:54 +0000, jakeo@microsoft.com wrote:
> > --- /dev/null
> > +++ b/drivers/pci/host/hv_pcifront.c
> 
> > +static void exit_hv_pci_drv(void)
> > +{
> > +	vmbus_driver_unregister(&hv_pci_drv);
> > +}
> > +
> > +static int __init init_hv_pci_drv(void)
> > +{
> > +	int ret;
> > +
> > +	/* Register this driver with VMBus. */
> > +	ret = vmbus_driver_register(&hv_pci_drv);
> > +
> > +	if (ret < 0)
> > +		exit_hv_pci_drv();
> > +
> > +	return ret;
> > +}
> 
> Wouldn't just
>     static int __init init_hv_pci_drv(void)
>     {
>     	return vmbus_driver_register(&hv_pci_drv);
>     }
> 
> suffice here?

You're right, of course.  The error handling is buggy.

regards,
dan carpenter


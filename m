Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Mon, 21 Aug 2017 12:44:47 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH v11 1/4] PCI: Don't ignore valid response before CRS
 timeout
Message-ID: <20170821174447.GA28977@bhelgaas-glaptop.roam.corp.google.com>
References: <20170818212310.15145.21732.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20170818213203.15145.36487.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <f7127748-24cd-37bd-544a-8cba6bf5906d@codeaurora.org>
MIME-Version: 1.0
In-Reply-To: <f7127748-24cd-37bd-544a-8cba6bf5906d@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-pci@vger.kernel.org, Timur Tabi <timur@codeaurora.org>,
 linux-kernel@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>,
 linux-arm-msm@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 21, 2017 at 10:02:55AM -0400, Sinan Kaya wrote:
> On 8/18/2017 5:32 PM, Bjorn Helgaas wrote:
> > While waiting for a device to become ready (i.e., to return a non-CRS
> > completion to a read of its Vendor ID), if we got a valid response to the
> > very last read before timing out, we printed a warning and gave up on the
> > device even though it was actually ready.
> > 
> > For a typical 60s timeout, we wait about 65s (it's not exact because of the
> > exponential backoff), but we treated devices that became ready between 33s
> > and 65s as though they failed.
> > 
> > Move the Device ID read later so we check whether the device is ready
> > immediately, before checking for a timeout.
> > 
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > ---
> >  drivers/pci/probe.c |    7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > index c31310db0404..08ea844ac4ba 100644
> > --- a/drivers/pci/probe.c
> > +++ b/drivers/pci/probe.c
> > @@ -1849,15 +1849,16 @@ bool pci_bus_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *l,
> >  
> >  		msleep(delay);
> >  		delay *= 2;
> > -		if (pci_bus_read_config_dword(bus, devfn, PCI_VENDOR_ID, l))
> > -			return false;
> > -		/* Card hasn't responded in 60 seconds?  Must be stuck. */
> > +
> 
> There is still a problem here. We'll wait some time above and return without checking if
> we actually found the card or not.
> 
> >  		if (delay > crs_timeout) {
> >  			printk(KERN_WARNING "pci %04x:%02x:%02x.%d: not responding\n",
> >  			       pci_domain_nr(bus), bus->number, PCI_SLOT(devfn),
> >  			       PCI_FUNC(devfn));
> >  			return false;
> >  		}
> > +
> > +		if (pci_bus_read_config_dword(bus, devfn, PCI_VENDOR_ID, l))
> > +			return false;
> >  	}
> >  
> >  	return true;
> > 
> > 
> 
> Here is another shot at it. Sorry, I don't have a diff syntax. I made up the function
> by copy paste.

Yep, this is much better, thanks!

> 	while ((*l & 0xffff) == 0x0001) {
> 		if (!crs_timeout)
> 			return false;
>  
> 		/* Card hasn't responded in 60 seconds?  Must be stuck. */
> 		if (delay > crs_timeout) {
> 			printk(KERN_WARNING "pci %04x:%02x:%02x.%d: not responding\n",
> 			       pci_domain_nr(bus), bus->number, PCI_SLOT(devfn),
> 			       PCI_FUNC(devfn));
> 			return false;
> 		} 
> 		msleep(delay);
> 		delay *= 2;
> 		if (pci_bus_read_config_dword(bus, devfn, PCI_VENDOR_ID, l))
> 			return false; 
> 	}
> 
> -- 
> Sinan Kaya
> Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
> Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

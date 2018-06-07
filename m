Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 7 Jun 2018 16:34:48 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: poza@codeaurora.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dongdong Liu <liudongdong3@huawei.com>,
        Keith Busch <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH NEXT 6/6] PCI/PORTDRV: Remove ERR_FATAL handling from
 pcie_portdrv_slot_reset()
Message-ID: <20180607213448.GB37077@bhelgaas-glaptop.roam.corp.google.com>
References: <1528351234-26914-1-git-send-email-poza@codeaurora.org>
 <1528351234-26914-6-git-send-email-poza@codeaurora.org>
 <94661add3e71e3694aa22c2a9cabf503@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <94661add3e71e3694aa22c2a9cabf503@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jun 07, 2018 at 07:18:03PM +0530, poza@codeaurora.org wrote:
> On 2018-06-07 11:30, Oza Pawandeep wrote:
> > We are handling ERR_FATAL by resetting the Link in software,skipping the
> > driver pci_error_handlers callbacks, removing the devices from the PCI
> > subsystem, and re-enumerating, as a result of that, no more calling
> > pcie_portdrv_slot_reset in ERR_FATAL case.
> > 
> > Signed-off-by: Oza Pawandeep <poza@codeaurora.org>
> > 
> > diff --git a/drivers/pci/pcie/portdrv_pci.c
> > b/drivers/pci/pcie/portdrv_pci.c
> > index 973f1b8..92f5d330 100644
> > --- a/drivers/pci/pcie/portdrv_pci.c
> > +++ b/drivers/pci/pcie/portdrv_pci.c
> > @@ -42,17 +42,6 @@ __setup("pcie_ports=", pcie_port_setup);
> > 
> >  /* global data */
> > 
> > -static int pcie_portdrv_restore_config(struct pci_dev *dev)
> > -{
> > -	int retval;
> > -
> > -	retval = pci_enable_device(dev);
> > -	if (retval)
> > -		return retval;
> > -	pci_set_master(dev);
> > -	return 0;
> > -}
> > -
> >  #ifdef CONFIG_PM
> >  static int pcie_port_runtime_suspend(struct device *dev)
> >  {
> > @@ -162,14 +151,6 @@ static pci_ers_result_t
> > pcie_portdrv_mmio_enabled(struct pci_dev *dev)
> > 
> >  static pci_ers_result_t pcie_portdrv_slot_reset(struct pci_dev *dev)
> >  {
> > -	/* If fatal, restore cfg space for possible link reset at upstream */
> > -	if (dev->error_state == pci_channel_io_frozen) {
> > -		dev->state_saved = true;
> > -		pci_restore_state(dev);
> > -		pcie_portdrv_restore_config(dev);
> > -		pci_enable_pcie_error_reporting(dev);
> > -	}
> > -
> >  	return PCI_ERS_RESULT_RECOVERED;
> >  }
> 
> 
> Hi Bjorn,
> 
> the above patch removes ERR_FATAL handling from pcie_portdrv_slot_reset()
> because now we are handling ERR_FATAL differently than before.
> 
> I tried to dig into pcie_portdrv_slot_reset() handling for ERR_FATAL case
> where it
> restores the config space, enable device, set master and enable error
> reporting....
> and as far as I understand this is being done for upstream link (bridges
> etc..)
> 
> why was it done at the first point (I checked the commit description, but
> could not really get it)
> and do we need to handle the same thing in ERR_FATAL now ?

You mean 4bf3392e0bf5 ("PCI-Express AER implemetation: pcie_portdrv
error handler"), which added pcie_portdrv_slot_reset()?  I agree, that
commit log has no useful information.  I don't know any of the history
behind it.

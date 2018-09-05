Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:38980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727688AbeIFAmf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 5 Sep 2018 20:42:35 -0400
Date: Wed, 5 Sep 2018 15:10:47 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: poza@codeaurora.org
Cc: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com, rgummal@xilinx.com,
        linux-pci-owner@vger.kernel.org
Subject: Re: [PATCH v2] PCI/AER: Enable SERR# forwarding in non ACPI flow
Message-ID: <20180905201047.GQ107892@bhelgaas-glaptop.roam.corp.google.com>
References: <1533826657-24552-1-git-send-email-bharat.kumar.gogada@xilinx.com>
 <2f53b7dd9c1464f40b10217eb64d511e@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2f53b7dd9c1464f40b10217eb64d511e@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 09, 2018 at 08:41:27PM +0530, poza@codeaurora.org wrote:
> On 2018-08-09 20:27, Bharat Kumar Gogada wrote:
> > As per Figure 6-3 in PCIe r4.0, sec 6.2.6, ERR_ messages
> > will be forwarded from the secondary interface to the primary interface,
> > if the SERR# Enable bit in the Bridge Control register is set.
> > Currently PCI_BRIDGE_CTL_SERR is being enabled only in
> > ACPI flow.
> > This patch enables PCI_BRIDGE_CTL_SERR for Type-1 PCI device.
> > 
> > Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> > ---
> >  drivers/pci/pcie/aer.c |   23 +++++++++++++++++++++++
> >  1 files changed, 23 insertions(+), 0 deletions(-)
> > 
> > diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> > index a2e8838..4fb0d24 100644
> > --- a/drivers/pci/pcie/aer.c
> > +++ b/drivers/pci/pcie/aer.c
> > @@ -343,6 +343,20 @@ int pci_enable_pcie_error_reporting(struct pci_dev
> > *dev)
> >  	if (!dev->aer_cap)
> >  		return -EIO;
> > 
> > +	if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
> > +		u16 control;
> > +
> > +		/*
> > +		 * A Type-1 PCI bridge will not forward ERR_ messages coming
> > +		 * from an endpoint if SERR# forwarding is not enabled.
> > +		 */
> > +		pci_read_config_word(dev, PCI_BRIDGE_CONTROL, &control);
> > +		if (!(control & PCI_BRIDGE_CTL_SERR)) {
> > +			control |= PCI_BRIDGE_CTL_SERR;
> > +			pci_write_config_word(dev, PCI_BRIDGE_CONTROL, control);
> > +		}
> > +	}
> > +
> >  	return pcie_capability_set_word(dev, PCI_EXP_DEVCTL,
> > PCI_EXP_AER_FLAGS);
> >  }
> >  EXPORT_SYMBOL_GPL(pci_enable_pcie_error_reporting);
> > @@ -352,6 +366,15 @@ int pci_disable_pcie_error_reporting(struct pci_dev
> > *dev)
> >  	if (pcie_aer_get_firmware_first(dev))
> >  		return -EIO;
> > 
> > +	if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
> > +		u16 control;
> > +
> > +		/* Clear SERR Forwarding */
> > +		pci_read_config_word(dev, PCI_BRIDGE_CONTROL, &control);
> > +		control &= ~PCI_BRIDGE_CTL_SERR;
> > +		pci_write_config_word(dev, PCI_BRIDGE_CONTROL, control);
> > +	}
> > +
> >  	return pcie_capability_clear_word(dev, PCI_EXP_DEVCTL,
> >  					  PCI_EXP_AER_FLAGS);
> >  }
> 
> 
> Hi Bjorn,
> 
> I made some comments on patchv1., same I am putting it across here.
> 
> what about hot-plug case ?
> should not aer_init() call pci_enable_pcie_error_reporting() for all
> the downstream pci_dev ?
> and remove all the calls from drivers..
> aer_init will be called for each device (pci_dev) while pciehp does
> re-enumeration.
> so probable we might want to call pci_enable_pcie_error_reporting()
> but that dictates the design where AER framework is taking decision to
> enable error reporting on behalf of drivers as well.
> but thats fine I think, if drivers do not want to participate then they have
> to call  pci_disable_pcie_error_reporting explicitly.
> does this make sense ?

I just replied to the original patch; sorry, I forgot to add you to
the cc list.  Bharat, when people respond to your v<N> patch, can you
please add them (and anybody else *they* added) to the cc list when
you post your v<N+1> patch?

If we set PCI_BRIDGE_CTL_SERR in the pci_configure_device() path,
would that address your comments?

There's still a separate question of where and how we should configure
the error bits in PCI_EXP_DEVCTL (currently done in
pci_enable_pcie_error_reporting()).

Bjorn

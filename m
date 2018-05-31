Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:41368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753772AbeEaEmR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 31 May 2018 00:42:17 -0400
Date: Wed, 30 May 2018 23:42:16 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Rajat Jain <rajatja@google.com>
Cc: linux-pci <linux-pci@vger.kernel.org>,
        Oza Pawandeep <poza@codeaurora.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/2] PCI/AER: Decode Error Source Requester ID
Message-ID: <20180531044216.GR39853@bhelgaas-glaptop.roam.corp.google.com>
References: <152770259826.80701.7360032106128917833.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <152770285586.80701.6545710900591672975.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <CACK8Z6Gs6Wt=qQ9PJJifZT7ZazK1yGtwNZRSTtvwek8iT8oW6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CACK8Z6Gs6Wt=qQ9PJJifZT7ZazK1yGtwNZRSTtvwek8iT8oW6w@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 30, 2018 at 11:41:23AM -0700, Rajat Jain wrote:
> On Wed, May 30, 2018 at 10:54 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> 
> > From: Bjorn Helgaas <bhelgaas@google.com>
> 
> > Decode the Requester ID from the AER Error Source Register into domain/
> > bus/device/function format to match other logging.  In cases where the ID
> > matches the device used for pci_err(), drop the extra ID completely so we
> > don't print it twice.
> 
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > ---
> >   drivers/pci/pcie/aer/aerdrv_errprint.c |   18 +++++++++++-------
> >   1 file changed, 11 insertions(+), 7 deletions(-)
> 
> > diff --git a/drivers/pci/pcie/aer/aerdrv_errprint.c
> b/drivers/pci/pcie/aer/aerdrv_errprint.c
> > index 21ca5e1b0ded..d7fde8368d81 100644
> > --- a/drivers/pci/pcie/aer/aerdrv_errprint.c
> > +++ b/drivers/pci/pcie/aer/aerdrv_errprint.c
> > @@ -163,17 +163,17 @@ void aer_print_error(struct pci_dev *dev, struct
> aer_err_info *info)
> >          int id = ((dev->bus->number << 8) | dev->devfn);

> >          if (!info->status) {
> > -               pci_err(dev, "PCIe Bus Error: severity=%s,
> type=Unaccessible, id=%04x(Unregistered Agent ID)\n",
> > -                       aer_error_severity_string[info->severity], id);
> > +               pci_err(dev, "PCIe Bus Error: severity=%s,
> type=Inaccessible, (Unregistered Agent ID)\n",
> > +                       aer_error_severity_string[info->severity]);
> 
> Does this code path indicate that a requester id was decoded to a device
> that is not registered with the kernel? If so, shouldn't we log the bad
> requester ID for better debugging, specifically since there is not going to
> be any subsequent print about this ID (since we return from this function
> in this case)?

Previously we printed "id", which was constructed above from "dev":

  id = ((dev->bus->number << 8) | dev->devfn);

so even if we print "id=%04x", it contains exactly the same
information as the bus/device/function printed using "dev".

So no, I don't think "Unregistered Agent ID" means a device not registered
with the kernel.  At any rate, we do have a pci_dev for it.

I *think* "info->status == 0" means PCI_ERR_COR_STATUS (or
PCI_ERR_UNCOR_STATUS) was zero, i.e., we didn't find any error status
bits set for this device.  I don't think "Unregistered Agent ID" is a
very good description of this situation.

Bjorn

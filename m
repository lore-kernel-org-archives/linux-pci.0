Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:58848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932450AbeEaA2d (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 30 May 2018 20:28:33 -0400
Date: Wed, 30 May 2018 19:28:32 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Rajat Jain <rajatja@google.com>
Cc: linux-pci <linux-pci@vger.kernel.org>,
        Oza Pawandeep <poza@codeaurora.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 2/2] PCI/AER: Stop printing vendor/device ID
Message-ID: <20180531002832.GP39853@bhelgaas-glaptop.roam.corp.google.com>
References: <152770259826.80701.7360032106128917833.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <152770286159.80701.8079550179741454699.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <CACK8Z6HhvLYkEtbROXymfn3pwz=rc8Dm_AstOe5R4tpb5aiJGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CACK8Z6HhvLYkEtbROXymfn3pwz=rc8Dm_AstOe5R4tpb5aiJGg@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 30, 2018 at 11:18:35AM -0700, Rajat Jain wrote:
> On Wed, May 30, 2018 at 10:54 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> 
> > From: Bjorn Helgaas <bhelgaas@google.com>
> 
> > The Vendor and Device ID of the root port that raised an AER interrupt is
> > irrelevant and already available via normal enumeration dmesg logging or
> > lspci.
> 
> Er, what is getting printed is not the vendor/device id of the root port
> but that of the AER source device (the one that root port got an ERR_*
> message from). In case of fatal AERs, the end point device may become
> inaccessible so lspci will not be available, and enumeration logs (from
> boot) may have gotten rolled over. So I think it is still better to print
> this information here.

Thanks for looking this over!

You're right, "dev" here is not necessarily the Root Port, so this
changelog is bogus.  "dev" came from e_info->dev[] from
aer_process_err_devices().

I think to be more precise, aer_irq() reads the Root Port's
PCI_ERR_ROOT_ERR_SRC register, which gives us the Requester ID from
the ERR_* message.  Then find_source_device() walks the tree starting
with the Root Port, looking for:

  - a device that matches the Requester ID, or
  - a device that doesn't match the Requester ID (e.g., because a VMD
    port clears the source ID) but has AER enabled and has logged an
    error of the same type (ERR_COR vs ERR_FATAL/NONFATAL) we're
    currently decoding

So there might be multiple "dev" pointers in e_info->dev[] because
several devices could have logged errors.

I'm not convinced the vendor/device ID is that useful because there
might be several devices with the same ID, so it doesn't really tell
you which one.  The Requester ID (bus/device/function) is the
important thing.

The current code is not ideal because the find_source_device() path
depends on the pci_dev still being present and even accessible (so we
can read DEVCTL, ERR_COR_STATUS, etc), which might not be the case.

If find_source_device() fails, i.e., it can't find a matching pci_dev
and prints the "can't find device of ID%04x" message, we're in real
trouble because we don't call aer_process_err_devices(), which means
we don't clear PCI_ERR_COR_STATUS.

Anyway, I'll abandon this change for now since it's not a clear
improvement.

> > Remove the Vendor and Device ID from AER logging.
> 
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > ---
> >   drivers/pci/pcie/aer/aerdrv_errprint.c |    5 ++---
> >   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> > diff --git a/drivers/pci/pcie/aer/aerdrv_errprint.c
> b/drivers/pci/pcie/aer/aerdrv_errprint.c
> > index d7fde8368d81..16116844531c 100644
> > --- a/drivers/pci/pcie/aer/aerdrv_errprint.c
> > +++ b/drivers/pci/pcie/aer/aerdrv_errprint.c
> > @@ -175,9 +175,8 @@ void aer_print_error(struct pci_dev *dev, struct
> aer_err_info *info)
> >                  aer_error_severity_string[info->severity],
> >                  aer_error_layer[layer], aer_agent_string[agent]);
> 
> > -       pci_err(dev, "  device [%04x:%04x] error status/mask=%08x/%08x\n",
> > -               dev->vendor, dev->device,
> > -               info->status, info->mask);
> > +       pci_err(dev, "  error status/mask=%08x/%08x\n", info->status,
> > +               info->mask);
> 
> >          __aer_print_error(dev, info);

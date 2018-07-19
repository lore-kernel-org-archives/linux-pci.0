Return-Path: <SRS0=2gfv=KD=codeaurora.org=poza@kernel.org>
Return-Path: <SRS0=2gfv=KD=codeaurora.org=poza@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Thu, 19 Jul 2018 21:26:45 +0530
From: poza@codeaurora.org
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner
 <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kate
 Stewart <kstewart@linuxfoundation.org>, Dongdong Liu
 <liudongdong3@huawei.com>, Keith Busch <keith.busch@intel.com>, Wei Zhang
 <wzhang@fb.com>, Sinan Kaya <okaya@kernel.org>, Timur Tabi
 <timur@codeaurora.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/7] Fix issues and cleanup for ERR_FATAL and
 ERR_NONFATAL
In-Reply-To: <153194245964.191586.14782253252654776509.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <153194245964.191586.14782253252654776509.stgit@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <272934d875d2f3a1546567f8c26e5946@codeaurora.org>
List-ID: <linux-pci.vger.kernel.org>

On 2018-07-19 01:14, Bjorn Helgaas wrote:
> This is a v3 of Oza's patches [1].  It's available at [2] if you prefer
> git.
> 
> v3 changes:
>   - Add pci_aer_clear_fatal_status() to clear ERR_FATAL bits, only 
> called
>     from pcie_do_fatal_recovery().  Moved to first in series to avoid a
>     window where ERR_FATAL recovery only clears ERR_NONFATAL bits.  
> Visible
>     only inside the PCI core.
>   - Instead of having pci_cleanup_aer_uncorrect_error_status() do 
> different
>     things based on dev->error_state, use this only for ERR_NONFATAL 
> bits.
>     I didn't change the name because it's used by many drivers.
>   - Rename pci_cleanup_aer_error_device_status() to
>     pci_aer_clear_device_status(), make it void, and make it visible 
> only
>     inside the PCI core.
>   - Remove pcie_portdrv_err_handler.slot_reset altogether instead of 
> making
>     it a stub function.  Possibly pcie_portdrv_err_handler could be 
> removed
>     completely?
> 
> [1]
> https://lkml.kernel.org/r/1529661494-20936-1-git-send-email-poza@codeaurora.org
> [2]
> https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/?h=pci/06-22-oza-aer
> 
> ---
> 
> Bjorn Helgaas (1):
>       PCI/AER: Clear only ERR_FATAL status bits during fatal recovery
> 
> Oza Pawandeep (6):
>       PCI/AER: Clear only ERR_NONFATAL bits during non-fatal recovery
>       PCI/AER: Factor out ERR_NONFATAL status bit clearing
>       PCI/AER: Remove ERR_FATAL code from ERR_NONFATAL path
>       PCI/AER: Clear device status bits during ERR_FATAL and 
> ERR_NONFATAL
>       PCI/AER: Clear device status bits during ERR_COR handling
>       PCI/portdrv: Remove pcie_portdrv_err_handler.slot_reset
> 
> 
>  drivers/pci/pci.h              |    5 ++++
>  drivers/pci/pcie/aer.c         |   47 
> +++++++++++++++++++++++++++-------------
>  drivers/pci/pcie/err.c         |   15 +++++--------
>  drivers/pci/pcie/portdrv_pci.c |   25 ---------------------
>  4 files changed, 43 insertions(+), 49 deletions(-)


Hi Bjorn,

I am planning on some things to do after this series.


your text
"
1) I don't think the driver slot_reset callbacks should be responsible
for clearing these AER status bits.  Can we clear them somewhere in
the pcie_do_nonfatal_recovery() path and remove these calls from the
drivers?
"

Oza: We can do following
broadcast_error_message()
       if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
                 should do
           pci_walk_bus(dev->subordinate, 
pci_cleanup_aer_uncorrect_error_status, NULL);

and update all the drivers and remove the call 
pci_cleanup_aer_uncorrect_error_status()


2) In principle, we should only read PCI_ERR_UNCOR_STATUS *once* per
device when handling an error.  We currently read it three times:

   aer_isr
     aer_isr_one_error
       find_source_device
         find_device_iter
           is_error_source
             read PCI_ERR_UNCOR_STATUS              # 1
Oza: this is the first legitimate read
       aer_process_err_devices
         get_device_error_info(e_info->dev[i])
           read PCI_ERR_UNCOR_STATUS                # 2
Oza: I see this read used to check if link is healthy so the purpose of 
this read looks different to me.
         handle_error_source
           pcie_do_nonfatal_recovery
             ...
               report_slot_reset
                 driver->err_handler->slot_reset
                   pci_cleanup_aer_uncorrect_error_status
                     read PCI_ERR_UNCOR_STATUS      # 3
Oza: pci_cleanup_aer_uncorrect_error_status() is generic and able to 
clear status.
for e.g. in point 4 as I suggested if we have to do
pci_walk_bus(dev->subordinate, pci_cleanup_aer_uncorrect_error_status, 
NULL); then we have to read them.


3) we need to get rid of pci_channel_io_frozen permanently.

Regards,
Oza.

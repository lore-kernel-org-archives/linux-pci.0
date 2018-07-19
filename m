Return-Path: <SRS0=2gfv=KD=codeaurora.org=poza@kernel.org>
Return-Path: <SRS0=2gfv=KD=codeaurora.org=poza@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Thu, 19 Jul 2018 09:23:47 +0530
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
Message-ID: <35f60c57a8e8fe9503d63a62fd4776bf@codeaurora.org>
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

looks good to me.
Thanks for the corrections.
some x86 compilation errors, you want me to to fix it and push v4 ?

Regards,
Oza.

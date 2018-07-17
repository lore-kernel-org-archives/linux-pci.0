Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:39156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729720AbeGQThb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 17 Jul 2018 15:37:31 -0400
Date: Tue, 17 Jul 2018 14:03:29 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Oza Pawandeep <poza@codeaurora.org>
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
Subject: Re: [PATCH v2 1/6] PCI/AER: Take severity mask into account while
 clearing error bits
Message-ID: <20180717190329.GA128988@bhelgaas-glaptop.roam.corp.google.com>
References: <1529661494-20936-1-git-send-email-poza@codeaurora.org>
 <1529661494-20936-2-git-send-email-poza@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1529661494-20936-2-git-send-email-poza@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Oza,

Thanks for doing this!

On Fri, Jun 22, 2018 at 05:58:09AM -0400, Oza Pawandeep wrote:
> pci_cleanup_aer_uncorrect_error_status() is called by different slot_reset
> callbacks in case of ERR_NONFATAL.

IIRC, the current strategy is:

  ERR_COR: log only
  ERR_NONFATAL: call driver callbacks (pci_error_handlers)
  ERR_FATAL: remove device and re-enumerate

So these slot_reset callbacks are only used for ERR_NONFATAL, which
are all uncorrectable errors, of course.

This patch makes it so that when the slot_reset callbacks call
pci_cleanup_aer_uncorrect_error_status(), we only clear the
bits set by ERR_NONFATAL events (this is determined by
PCI_ERR_UNCOR_SEVER).

That makes good sense to me.  All these status bits are RW1CS, so they
will be preserved across a reset but will be cleared when we
re-enumerate, in this path:

  pci_init_capabilities
    pci_aer_init
      pci_cleanup_aer_error_status_regs
      # clear all PCI_ERR_UNCOR_STATUS and PCI_ERR_COR_STATUS bits

> AER uncorrectable error status should take severity into account in order
> to clear the bits, so that ERR_NONFATAL path does not clear the bit which
> are marked with severity fatal.

Two comments:

1) Can you split this into two patches, one that changes
pci_cleanup_aer_uncorrect_error_status() so it looks like the error
clearing code in aer_error_resume(), and a second that factors out the
duplicate code?

2) Maybe use "sev" or "sever" instead of "mask" for the local
variable, since there is also a separate PCI_ERR_UNCOR_MASK register,
which is not involved here.

3) The "pci_cleanup_aer_uncorrect_error_status()" name no longer
really describes what this does.  Something like
"pci_aer_clear_nonfatal_status()" would be more descriptive.  But I
see you have a subsequent patch (which I haven't looked at yet) that
is related to this.

4) I don't think the driver slot_reset callbacks should be responsible
for clearing these AER status bits.  Can we clear them somewhere in
the pcie_do_nonfatal_recovery() path and remove these calls from the
drivers?

5) In principle, we should only read PCI_ERR_UNCOR_STATUS *once* per
device when handling an error.  We currently read it three times:

  aer_isr
    aer_isr_one_error
      find_source_device
        find_device_iter
          is_error_source
            read PCI_ERR_UNCOR_STATUS              # 1
      aer_process_err_devices
        get_device_error_info(e_info->dev[i])
          read PCI_ERR_UNCOR_STATUS                # 2
        handle_error_source
          pcie_do_nonfatal_recovery
            ...
              report_slot_reset
                driver->err_handler->slot_reset
                  pci_cleanup_aer_uncorrect_error_status
                    read PCI_ERR_UNCOR_STATUS      # 3

OK, that was more than two comments :)

> Signed-off-by: Oza Pawandeep <poza@codeaurora.org>
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index a2e8838..d6cb1f0 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -360,13 +360,16 @@ EXPORT_SYMBOL_GPL(pci_disable_pcie_error_reporting);
>  int pci_cleanup_aer_uncorrect_error_status(struct pci_dev *dev)
>  {
>  	int pos;
> -	u32 status;
> +	u32 status, mask;
>  
>  	pos = dev->aer_cap;
>  	if (!pos)
>  		return -EIO;
>  
> +	/* Clean AER Root Error Status */

s/Clean/Clear/ (I see you copied this from aer_error_resume(), and maybe
the second patch could remove or update that comment, too)

>  	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_STATUS, &status);
> +	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_SEVER, &mask);
> +	status &= ~mask; /* Clear corresponding nonfatal bits */
>  	if (status)
>  		pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_STATUS, status);
>  
> @@ -1336,8 +1339,6 @@ static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
>   */
>  static void aer_error_resume(struct pci_dev *dev)
>  {
> -	int pos;
> -	u32 status, mask;
>  	u16 reg16;
>  
>  	/* Clean up Root device status */
> @@ -1345,11 +1346,7 @@ static void aer_error_resume(struct pci_dev *dev)
>  	pcie_capability_write_word(dev, PCI_EXP_DEVSTA, reg16);
>  
>  	/* Clean AER Root Error Status */
> -	pos = dev->aer_cap;
> -	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_STATUS, &status);
> -	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_SEVER, &mask);
> -	status &= ~mask; /* Clear corresponding nonfatal bits */
> -	pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_STATUS, status);
> +	pci_cleanup_aer_uncorrect_error_status(dev);
>  }
>  
>  static struct pcie_port_service_driver aerdriver = {
> -- 
> 2.7.4
> 

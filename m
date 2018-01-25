Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:43554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751191AbeAYTzO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 25 Jan 2018 14:55:14 -0500
Date: Thu, 25 Jan 2018 13:55:12 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Keith Busch <keith.busch@intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Maik Broemme <mbroemme@libmpq.org>,
        Pawandeep Oza <poza@codeaurora.org>,
        Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCHv2 4/6] PCI/DPC: Print AER status in DPC event handling
Message-ID: <20180125195512.GL5317@bhelgaas-glaptop.roam.corp.google.com>
References: <20180117052206.7703-1-keith.busch@intel.com>
 <20180117052206.7703-5-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180117052206.7703-5-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jan 16, 2018 at 10:22:04PM -0700, Keith Busch wrote:
> A DPC enabled device suppresses ERR_(NON)FATAL messages, preventing the
> AER handler from reporting error details. If the DPC trigger reason says
> the downstream port detected the error, this patch has the DPC driver
> collect the AER uncorrectable status for logging, then clears the status.
> 
> Signed-off-by: Keith Busch <keith.busch@intel.com>
> ---
>  drivers/pci/pcie/pcie-dpc.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/pci/pcie/pcie-dpc.c b/drivers/pci/pcie/pcie-dpc.c
> index d1fbd83cd240..85350b00f251 100644
> --- a/drivers/pci/pcie/pcie-dpc.c
> +++ b/drivers/pci/pcie/pcie-dpc.c
> @@ -44,6 +44,7 @@ struct dpc_dev {
>  	int			cap_pos;
>  	bool			rp;
>  	u32			rp_pio_status;
> +	struct aer_err_info	info;
>  };
>  
>  static const char * const rp_pio_error_string[] = {
> @@ -112,6 +113,12 @@ static void interrupt_event_handler(struct work_struct *work)
>  	struct pci_bus *parent = pdev->subordinate;
>  	u16 ctl;
>  
> +	if (dpc->info.severity == AER_NONFATAL) {
> +		if (aer_get_device_error_info(pdev, &dpc->info)) {
> +			aer_print_error(pdev, &dpc->info);
> +			pci_cleanup_aer_uncorrect_error_status(pdev);
> +		}
> +	}
>  	pci_lock_rescan_remove();
>  	list_for_each_entry_safe_reverse(dev, temp, &parent->devices,
>  					 bus_list) {
> @@ -298,6 +305,11 @@ static irqreturn_t dpc_irq(int irq, void *context)
>  
>  	schedule_work(&dpc->work);
>  
> +	if (reason == 0)
> +		dpc->info.severity = AER_NONFATAL;
> +	else
> +		dpc->info.severity = AER_CORRECTABLE;

This looks wrong because we call schedule_work() before we set
dpc->info.severity.  I think that's racy because
interrupt_event_handler() might read dpc->info.severity before
dpc_irq() sets it.

That raises the question of how we pass information from dpc_irq() to
interrupt_event_handler().  I think interrupt_event_handler() is a
work item because it removes devices and might need to sleep.  That
makes sense.

But we pass dpc->info and dpc->rp_pio_status from dpc_irq() to
interrupt_event_handler() via the single struct dpc_dev.  That doesn't
make sense in general because dpc_irq() may be invoked several times
for each invocation of interrupt_event_handler().  I think the general
purpose solution for passing information from interrupt context to
process context would be a queue.

It looks like we side-step that issue by disabling interrupts in
dpc_irq() and re-enabling them in interrupt_event_handler().  That
probably does work, but it's strange and requires extra config
accesses.  The fact that we clear PCI_EXP_DPC_STATUS_INTERRUPT at the
end of interrupt_event_handler() should be enough -- sec 6.2.10.1 says
we should only get a new MSI when the logical AND of things including
PCI_EXP_DPC_STATUS_INTERRUPT transitions from FALSE to TRUE.

I think all the log registers (Error Source ID and RP PIO Logs) are
latched when DPC Trigger Status is set, so I think all the dmesg
logging and dpc_process_rp_pio_error() stuff *could* be done in
interrupt_event_handler().  Then it would be together with the
PCI_EXP_DPC_STATUS write that clears DPC Trigger Status (and clears
the latched log registers) and we wouldn't have the question about
what belongs on dpc_irq() and what belongs in
interrupt_event_handler().

After we clear PCI_EXP_DPC_STATUS_TRIGGER, we're supposed to "honor
timing requirements ... with respect to the first Configuration Read
following a Conventional Reset" (PCIe r4.0, sec 7.9.15.4).  Where does
that happen?

>  	return IRQ_HANDLED;
>  }
>  
> -- 
> 2.13.6
> 

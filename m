Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45642 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753871AbcJYTI4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 25 Oct 2016 15:08:56 -0400
Message-ID: <580FADC6.1020407@redhat.com>
Date: Tue, 25 Oct 2016 15:08:54 -0400
From: Prarit Bhargava <prarit@redhat.com>
MIME-Version: 1.0
To: Keith Busch <keith.busch@intel.com>
CC: linux-pci@vger.kernel.org,
        Alex Williamson <alex.williamson@redhat.com>,
        David Arcari <darcari@redhat.com>,
        Myron Stowe <mstowe@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [RFE PATCH] pci: Do not enable intx on MSI-capable devices on
 shutdown
References: <1477052083-13815-1-git-send-email-prarit@redhat.com> <20161025180858.GA22422@localhost.localdomain>
In-Reply-To: <20161025180858.GA22422@localhost.localdomain>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 10/25/2016 02:08 PM, Keith Busch wrote:
> On Fri, Oct 21, 2016 at 08:14:43AM -0400, Prarit Bhargava wrote:
>> We have seen this at Red Hat on various drivers: nouveau, ahci, and pcieport
>> (so far).  Google search for "unhandled irq 16" yields many results reporting
>> similar behavior during shutdown indicating that this problem is widespread.
>> I can cause this to happen on a "stable" system by adding a 3 second delay in
>> pci_device_shutdown() which causes the number of spurious interrupts to exceed
>> the 100000 limit and display the warning above.  Also note that by adding the
>> 3 second delay, NVIDIA devices with device ID 0x0FF* hit this problem 100% of
>> the time.
>>
>> darcari noticed that removing the pci_intx_for_msi() call resulted in a
>> stable system.  After further discussions with Myron and Alex, Alex came up
>> idea of keeping the intx disabled during shutdown implemented below.
>>
>> ----8<----
>>
>> The following unhandled IRQ warning is seen during shutdown:
>>
>> irq 16: nobody cared (try booting with the "irqpoll" option)
>> CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.8.2-1.el7_UNSUPPORTED.x86_64 #1
>> Hardware name: Hewlett-Packard HP Z820 Workstation/158B, BIOS J63 v03.90 06/01/2016
>>  0000000000000000 ffff88041f803e70 ffffffff81333bd5 ffff88041cb78200
>>  ffff88041cb7829c ffff88041f803e98 ffffffff810d9465 ffff88041cb78200
>>  0000000000000000 0000000000000028 ffff88041f803ed0 ffffffff810d97bf
>> Call Trace:
>>  <IRQ>  [<ffffffff81333bd5>] dump_stack+0x63/0x8e
>>  [<ffffffff810d9465>] __report_bad_irq+0x35/0xd0
>>  [<ffffffff810d97bf>] note_interrupt+0x20f/0x260
>>  [<ffffffff810d6b35>] handle_irq_event_percpu+0x45/0x60
>>  [<ffffffff810d6b7c>] handle_irq_event+0x2c/0x50
>>  [<ffffffff810da31a>] handle_fasteoi_irq+0x8a/0x150
>>  [<ffffffff8102edfb>] handle_irq+0xab/0x130
>>  [<ffffffff81082391>] ? _local_bh_enable+0x21/0x50
>>  [<ffffffff817064ad>] do_IRQ+0x4d/0xd0
>>  [<ffffffff81704502>] common_interrupt+0x82/0x82
>>  <EOI>  [<ffffffff815d0181>] ? cpuidle_enter_state+0xc1/0x280
>>  [<ffffffff815d0174>] ? cpuidle_enter_state+0xb4/0x280
>>  [<ffffffff815d0377>] cpuidle_enter+0x17/0x20
>>  [<ffffffff810bf660>] cpu_startup_entry+0x220/0x3a0
>>  [<ffffffff816f6da7>] rest_init+0x77/0x80
>>  [<ffffffff81d8e147>] start_kernel+0x495/0x4a2
>>  [<ffffffff81d8daa0>] ? set_init_arg+0x55/0x55
>>  [<ffffffff81d8d120>] ? early_idt_handler_array+0x120/0x120
>>  [<ffffffff81d8d5d6>] x86_64_start_reservations+0x2a/0x2c
>>  [<ffffffff81d8d715>] x86_64_start_kernel+0x13d/0x14c
>>
>> This occurs because the pci_msi_shutdown() and pci_msix_shutdown() functions
>> enable the legacy intx interrupt even though the device and driver were not
>> configured for legacy intx.
>>
>> This patch blocks the enabling of intx during system shutdown or reboot.
> 
> 
> I am feeling a bit cautious to tie this behavior to the system_state. Is
> there better criteria to know we shouldn't enable INTx after disabling
> MSI/MSI-x? It sounds like we would never want to enable INTx if a driver
> still has IRQ actions tied to the MSI/MSI-x. Does this alternate proposal
> look okay?
> 
> ---
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index bfdd074..90a4e84 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -357,19 +357,30 @@ void pci_write_msi_msg(unsigned int irq, struct msi_msg *msg)
>  }
>  EXPORT_SYMBOL_GPL(pci_write_msi_msg);
>  
> +static bool msi_has_action(struct pci_dev *dev)
> +{
> +	struct msi_desc *entry;
> +	int i;
> +
> +	for_each_pci_msi_entry(entry, dev) {
> +		if (entry->irq) {
> +			for (i = 0; i < entry->nvec_used; i++)
> +				if (irq_has_action(entry->irq + i))
> +					return true;
> +		}
> +	}
> +	return false;
> +}
> +
>  static void free_msi_irqs(struct pci_dev *dev)
>  {
>  	struct list_head *msi_list = dev_to_msi_list(&dev->dev);
>  	struct msi_desc *entry, *tmp;
>  	struct attribute **msi_attrs;
>  	struct device_attribute *dev_attr;
> -	int i, count = 0;
> -
> -	for_each_pci_msi_entry(entry, dev)
> -		if (entry->irq)
> -			for (i = 0; i < entry->nvec_used; i++)
> -				BUG_ON(irq_has_action(entry->irq + i));
> +	int count = 0;
>  
> +	BUG_ON(msi_has_action(dev));
>  	pci_msi_teardown_msi_irqs(dev);
>  
>  	list_for_each_entry_safe(entry, tmp, msi_list, list) {
> @@ -910,7 +921,8 @@ void pci_msi_shutdown(struct pci_dev *dev)
>  	desc = first_pci_msi_entry(dev);
>  
>  	pci_msi_set_enable(dev, 0);
> -	pci_intx_for_msi(dev, 1);
> +	if (!msi_has_action(dev))
> +		pci_intx_for_msi(dev, 1);


When pci_disable_msi() is currently called the result is that device is
switched back to intx and then the MSI IRQs are free'd.  This patch would
modify that behavior, and intx would not be reenabled when pci_disable_msix()
was called during runtime.  With the system_state patch we're only affecting
shutdown, which is seen as less risky than doing

https://patchwork.kernel.org/patch/5990701/

I still can't get around the idea that we're modifying device behaviour without
verifying the driver supports the new behaviour.  I think that is the wrong
thing to do and think we should reconsider the patch in the above link.  I'd
much rather live with the risk of the patch in the link than dealing with kvm,
runtime module unloads, etc.

P.

>  	dev->msi_enabled = 0;
>  
>  	/* Return the device with MSI unmasked as initial states */
> @@ -1024,7 +1036,8 @@ void pci_msix_shutdown(struct pci_dev *dev)
>  	}
>  
>  	pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_ENABLE, 0);
> -	pci_intx_for_msi(dev, 1);
> +	if (!msi_has_action(dev))
> +		pci_intx_for_msi(dev, 1);
>  	dev->msix_enabled = 0;
>  	pcibios_alloc_irq(dev);
>  }
> --
> 
> 


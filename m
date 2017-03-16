Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:49730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752051AbdCPRZI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 16 Mar 2017 13:25:08 -0400
Date: Thu, 16 Mar 2017 12:24:32 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Rui Wang <rui.y.wang@intel.com>
Cc: tglx@linutronix.de, rjw@rjwysocki.net, tony.luck@intel.com,
        bhelgaas@google.com, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, fengguang.wu@intel.com, kbuild-all@01.org
Subject: Re: [PATCH v2 1/2] x86/PCI: Implement pcibios_release_device to
 release IRQ from IOAPIC
Message-ID: <20170316172432.GB2021@bhelgaas-glaptop.roam.corp.google.com>
References: <201702280904.A2EXAFMQ%fengguang.wu@intel.com>
 <1488288869-31290-1-git-send-email-rui.y.wang@intel.com>
 <1488288869-31290-2-git-send-email-rui.y.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1488288869-31290-2-git-send-email-rui.y.wang@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Rui,

On Tue, Feb 28, 2017 at 09:34:28PM +0800, Rui Wang wrote:
> The revert of 991de2e59090 ("PCI, x86: Implement pcibios_alloc_irq()
> and pcibios_free_irq()") causes a problem for IOAPIC hotplug. The
> problem is that IRQs are allocated and freed in pci_enable_device()
> and pci_disable_device(). But there are some drivers which don't call
> pci_disable_device(), and they have good reasons not calling it, so

Can you elaborate a little on what these drivers are and what the
reasons for not calling pci_disable_device() are?  Without a pointer
to details, this is just a teaser :)

Maybe this has to do with the "there are too many odd BIOS and bridge
setups" comment in pci_device_remove()?  If so, I think it's a bit of
a stretch to say they have good reasons to not call it, because nobody
knows what those reasons are.

> if they're using IOAPIC their IRQs won't have a chance to be released
> from the IOAPIC. When this happens IOAPIC hot-removal fails with a
> kernel stack dump and an error message like this:
> 
> [149335.697989] pin16 on IOAPIC2 is still in use.

Are there any bug reports for this that we should reference?  Pointing
to a bugzilla with more details would help avoid situations like the
vague "odd BIOS and bridge setups" comment above.

> It turns out that we can fix it in a different way without moving IRQ
> allocation into pcibios_alloc_irq(), thus avoiding the regression of
> 991de2e59090. We can keep the allocation and freeing of IRQs as is
> within pci_enable_device()/pci_disable_device(), without breaking any
> previous assumption of the rest of the system, keeping compatibility
> with both the legacy and the modern drivers. We can accomplish this by
> implementing the existing __weak hook of pcibios_release_device() thus
> when a pci device is about to be deleted we get notified in the hook
> and take the chance to release its IRQ, if any, from the IOAPIC.

I'm not a huge fan of using the release method because it makes the
code flow more obscure -- the release method is called semi-magically
when a reference count goes to zero, and it's primarily a mechanism
for dropping references and deallocating storage.

That's not to say we *can't* do it in pcibios_release_device(); it's
just that I'd prefer a more direct approach if we can find one.

If I understand correctly, after 991de2e59090, we did the IRQ setup
and teardown in the driver attach (pci_device_probe()) and remove
(pci_device_remove()) path.  The problem with that approach was that
we set up the IRQ for the device but not for any upstream bridges, so
some drivers didn't get the interrupts they expected.

After we reverted 991de2e59090 (with 6c777e8799a9), we now do IRQ
setup and teardown in the pci_enable_device() and pci_disable_device()
paths.  The pci_enable_device() path enables all upstream bridges and
sets up their IRQs.  The problem with this approach is that some
drivers don't call pci_disable_device() to teardown the IRQ, and a
subsequent hotplug removal of the IOAPIC fails because an interrupt is
still in use.

I think it makes sense to set up the IRQ in pci_enable_device() rather
than in pci_device_probe().  Doing it at probe-time is a little
aggressive because some drivers may not need the IRQ at all.

Could we do a hybrid, i.e., do the setup in pci_enable_device() and
the teardown in pci_device_remove()?  I think it makes sense that if a
driver has set up the IRQ, we should make sure it's torn down when we
unbind the driver from the device (or possibly early, if the driver
calls pci_disable_device()).

> Besides implementing pcibios_release_device(), the hot-removal of
> IOAPIC needs to be broken into two parts: the PCI part and the ACPI
> part. The PCI part releases PCI resources before the PCI bus is gone,
> and the ACPI part is moved to a stage later than the hot-removal of
> the PCI root bus, so we have the chance to hook every PCI device's
> pcibios_release_device(), before we remove the IOAPIC.
> 
> This patch implements pcibios_release_device() on x86 to release any
> IRQ not released by the driver, so that the IOAPIC can then be safely
> hot-removed.
> 
> v2: Fixed a typo (pcibios_release_device)
> 
> Signed-off-by: Rui Wang <rui.y.wang@intel.com>
> ---
>  arch/x86/pci/common.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
> index 0cb52ae..190e718 100644
> --- a/arch/x86/pci/common.c
> +++ b/arch/x86/pci/common.c
> @@ -735,6 +735,15 @@ void pcibios_disable_device (struct pci_dev *dev)
>  		pcibios_disable_irq(dev);
>  }
>  
> +#ifdef CONFIG_ACPI_HOTPLUG_IOAPIC
> +void pcibios_release_device(struct pci_dev *dev)
> +{
> +	if (atomic_dec_return(&dev->enable_cnt) >= 0)
> +		pcibios_disable_device(dev);
> +
> +}
> +#endif
> +
>  int pci_ext_cfg_avail(void)
>  {
>  	if (raw_pci_ext_ops)
> -- 
> 1.8.3.1
> 

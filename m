Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f194.google.com ([209.85.223.194]:36474 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751116AbdFAXWa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Jun 2017 19:22:30 -0400
MIME-Version: 1.0
In-Reply-To: <1495702147-31427-1-git-send-email-yu.c.chen@intel.com>
References: <1495702147-31427-1-git-send-email-yu.c.chen@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 2 Jun 2017 01:22:28 +0200
Message-ID: <CAJZ5v0hNXJ0+bQdM5v0i0YeMkE7mBWJn5et_okt_qrMytS4ymQ@mail.gmail.com>
Subject: Re: [PATCH] PCI / PM: Restore the status of PCI devices across hibernation
To: Chen Yu <yu.c.chen@intel.com>, Bjorn Helgaas <bhelgaas@google.com>
Cc: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <len.brown@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Rui Zhang <rui.zhang@intel.com>,
        Ying Huang <ying.huang@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 25, 2017 at 10:49 AM, Chen Yu <yu.c.chen@intel.com> wrote:
> Currently we saw a lot of "No irq handler" errors during hibernation,
> which caused the system hang finally:
>
> [  710.141581] ata4.00: qc timeout (cmd 0xec)
> [  710.147135] ata4.00: failed to IDENTIFY (I/O error, err_mask=0x4)
> [  710.154593] ata4.00: revalidation failed (errno=-5)
> [  710.468124] ata4: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> [  710.477746] do_IRQ: 31.151 No irq handler for vector
>
> According to above logs, there is an interrupt triggered and it is
> dispatched to CPU31 with a vector number 151, but there is no handler
> for it, thus this irq will not get acked and caused irq flood which kill
> the system. To be more specific, the 31.151 is an interrupt from the ahci
> host controller.
>
> After some investigation, the reason why this issue is triggered is
> because the thaw_noirq() function does not restore the MSI/MSIX settings
> across hibernation.
>
> The scenario is illustrated below:
>
> 1. Before the hibernation starts, the irq 34 is the handler for the ahci device,
>    which is binded on cpu31.
> 2. Hibernation starts, the ahci device is put into low power state.
> 3. All the nonboot CPUs are put offline, so the irq 34 has to be migrated to
>    the last alive one - CPU0.
> 4. After the snapshot has been created, all the nonboot CPUs are brought up again,
>    the CPU affinity for IRQ 34 remains to be 0.
> 5. ahci device are put into D0.
> 6. The snapshot is written to the disk.
>
> The issue is triggered in step 6, in theory the ahci interrupt should be
> delivered to CPU0, however the actually result is that this interrupt is
> delivered to the original CPU31 instead, which cause the "No irq handler" issue.
>
> Ying Huang has has provided a clue that, in step 3 it is possible that the writing
> to the register might not take effect as the PCI devices have been put suspended.
> Actually it is true:
> In step 3, the irq 34 affinity is supposed to be modified from 31 to 0,
> but actually it did not. In __pci_write_msi_msg(), if the device is already
> in low power state, the low level msi message entry will not be updated
> but cached. So in theory during the device restore process, the cached msi
> modification information should be written back to the hardware, and this
> is what pci_restore_msi_state() do during normal suspend-resume.
> But this is not the case for hibernation, pci_restore_msi_state() is not
> invoked currently, to be more specific, pci_restore_state() is not invoked
> in pci_pm_thaw_noirq(), although pci_save_state() has saved the necessary
> pci cached information in pci_pm_freeze_noirq().
>
> This patch tries to restore the pci status for the device during hibernation,
> otherwise the status might be lost across hibernation(for example, the MSI/MSIX
> message settings), which might cause problems during hibernation.
>
> Suggested-by: Ying Huang <ying.huang@intel.com>
> Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Rui Zhang <rui.zhang@intel.com>
> Cc: Ying Huang <ying.huang@intel.com>
> Cc: linux-pci@vger.kernel.org
> Cc: linux-pm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>

Thanks for the detailed description of what's going on!

The fix is correct IMO, so

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Bjorn, if you want me to take this one, please let me know.

> ---
>  drivers/pci/pci-driver.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index 192e7b6..b399fa3 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -964,6 +964,7 @@ static int pci_pm_thaw_noirq(struct device *dev)
>                 return pci_legacy_resume_early(dev);
>
>         pci_update_current_state(pci_dev, PCI_D0);
> +       pci_restore_state(pci_dev);
>
>         if (drv && drv->pm && drv->pm->thaw_noirq)
>                 error = drv->pm->thaw_noirq(dev);
> --
> 2.7.4
>

Thanks,
Rafael

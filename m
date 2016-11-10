Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yw0-f171.google.com ([209.85.161.171]:32926 "EHLO
        mail-yw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965571AbcKJTrW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Nov 2016 14:47:22 -0500
Received: by mail-yw0-f171.google.com with SMTP id r204so257443834ywb.0
        for <linux-pci@vger.kernel.org>; Thu, 10 Nov 2016 11:47:21 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20161110185520.19461.9789.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20161110185520.19461.9789.stgit@bhelgaas-glaptop.roam.corp.google.com>
From: Rajat Jain <rajatja@google.com>
Date: Thu, 10 Nov 2016 11:46:40 -0800
Message-ID: <CACK8Z6HkOxi94pmf9hjmpUyGf8H2xO6WnM4BuS1D4qy0uzcbCw@mail.gmail.com>
Subject: Re: [PATCH] PCI: pciehp: Check for PCIe capabilities change after resume
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>,
        Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Nov 10, 2016 at 10:55 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> Len Brown reported that resume on a Dell XPS11 laptop takes longer than it
> should.  The delay is caused by pciehp scanning for a device below a Root
> Port that has nothing connected to it.
>
> At boot-time, the 00:1c.0 Root Port's PCI Express Capabilities Register
> (PCIe spec r3.0, sec 7.8.2) advertises a slot (PCI_EXP_FLAGS_SLOT is set),
> so pciehp claims the port.
>
> At resume-time, PCI_EXP_FLAGS_SLOT is clear, so the Root Port no longer
> advertises a slot.  But pciehp doesn't notice that change, and it reads
> Slot Status to see if anything changed.  Slot Status says a device is
> present (Ports not connected to slots are required to report "Card Present"
> per sec 7.8.11), so pciehp tries to bring up the link and scan for the
> device, which accounts for the delay.
>
> Per sec 7.8.2, the PCIe Capabilities Register is all read-only, so I
> think the fact that it changes between boot- and resume-time is a
> firmware defect.
>
> Work around this by re-reading the Capabilites at resume-time and updating
> the cached copy in pci_dev->pcie_flags_reg.  Then stop using pciehp on the
> port if it no longer advertises a slot.
>
> Reported-and-tested-by: Len Brown <lenb@kernel.org>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=99751
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

I wish we could handle such firmware bugs using quirks
(pci_fixup_resume_early), but it looks difficult for this one :-(

Reviewed-by: Rajat Jain <rajatja@google.com>

> ---
>  drivers/pci/hotplug/pciehp_core.c |   10 ++++++++++
>  drivers/pci/pci-driver.c          |   13 +++++++++++++
>  2 files changed, 23 insertions(+)
>
> diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
> index 7d32fa33..f5461cb 100644
> --- a/drivers/pci/hotplug/pciehp_core.c
> +++ b/drivers/pci/hotplug/pciehp_core.c
> @@ -278,6 +278,9 @@ static void pciehp_remove(struct pcie_device *dev)
>  {
>         struct controller *ctrl = get_service_data(dev);
>
> +       if (!ctrl)
> +               return;
> +
>         cleanup_slot(ctrl);
>         pciehp_release_ctrl(ctrl);
>  }
> @@ -296,6 +299,13 @@ static int pciehp_resume(struct pcie_device *dev)
>
>         ctrl = get_service_data(dev);
>
> +       if (!(pcie_caps_reg(dev->port) & PCI_EXP_FLAGS_SLOT)) {
> +               dev_info(&dev->port->dev, "No longer supports hotplug\n");

May be add a comment here, that this is only to work around a firmware bug?

> +               pciehp_remove(dev);
> +               set_service_data(dev, NULL);
> +               return 0;
> +       }
> +
>         /* reinitialize the chipset's event detection logic */
>         pcie_enable_notification(ctrl);
>
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index 1ccce1c..fe8e964 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -505,7 +505,20 @@ static int pci_restore_standard_config(struct pci_dev *pci_dev)
>
>  static void pci_pm_default_resume_early(struct pci_dev *pci_dev)
>  {
> +       u16 flags;
> +
>         pci_power_up(pci_dev);
> +
> +       if (pci_dev->pcie_cap) {

may consider using accessor functions here (pci_is_pcie() /
pcie_caps_reg() etc).

> +               pci_read_config_word(pci_dev, pci_dev->pcie_cap + PCI_EXP_FLAGS,
> +                                    &flags);
> +               if (pci_dev->pcie_flags_reg != flags) {
> +                       dev_info(&pci_dev->dev, "PCIe Capabilities was %#06x, is %#06x after resume (possible firmware defect)\n",
> +                                pci_dev->pcie_flags_reg, flags);
> +                       pci_dev->pcie_flags_reg = flags;
> +               }
> +       }
> +
>         pci_restore_state(pci_dev);
>         pci_fixup_device(pci_fixup_resume_early, pci_dev);
>  }
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

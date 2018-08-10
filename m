Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:46576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727173AbeHJXon (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 10 Aug 2018 19:44:43 -0400
Date: Fri, 10 Aug 2018 16:13:08 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Patrick Talbert <ptalbert@redhat.com>
Cc: linux-pci@vger.kernel.org, Myron Stowe <mstowe@redhat.com>,
        Frederick Lawler <fred@fredlawl.com>
Subject: Re: Should pcie_aspm_init_link_state() run when FADT ASPM disable
 bit is set?
Message-ID: <20180810211308.GK113140@bhelgaas-glaptop.roam.corp.google.com>
References: <CAPRrrxWVYJpRqKLmDQLnCUQdkcxhHzmD+S8pxnvi_+-2VUcbPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAPRrrxWVYJpRqKLmDQLnCUQdkcxhHzmD+S8pxnvi_+-2VUcbPA@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Fred]

On Thu, Aug 09, 2018 at 09:25:20AM +0200, Patrick Talbert wrote:
> Hello,
> 
> I think there may be a logic issue with ASPM but I am not so familiar
> with this area so maybe I misunderstand.
> 
> acpi_pci_init() checks ACPI FADT method for the ACPI_FADT_NO_ASPM flag
> and will disable ASPM support if it is set. It calls pcie_no_aspm() to
> do this. pcie_no_aspm() sets the global aspm_disabled = 1 to indicate
> this state:
> 
> 365 static int __init acpi_pci_init(void)
> 366 {
> 367         int ret;
> 368
> 369         if (acpi_gbl_FADT.boot_flags & ACPI_FADT_NO_MSI) {
> 370                 pr_info("ACPI FADT declares the system doesn't
> support MSI, so disable it\n");
> 371                 pci_no_msi();
> 372         }
> 373
> 374         if (acpi_gbl_FADT.boot_flags & ACPI_FADT_NO_ASPM) {
> 375                 pr_info("ACPI FADT declares the system doesn't
> support PCIe ASPM, so disable it\n");
> 376                 pcie_no_aspm();
> 377         }
> 378
> 379         ret = register_acpi_bus_type(&acpi_pci_bus);
> 380         if (ret)
> 381                 return 0;
> 382
> 383         pci_set_platform_pm(&acpi_pci_platform_pm);
> 384         acpi_pci_slot_init();
> 385         acpiphp_init();
> 386
> 387         return 0;
> 388 }
> 389 arch_initcall(acpi_pci_init);
> 
> 973 void pcie_no_aspm(void)
> 974 {
> 975         /*
> 976          * Disabling ASPM is intended to prevent the kernel from modifying
> 977          * existing hardware state, not to clear existing state.
> To that end:
> 978          * (a) set policy to POLICY_DEFAULT in order to avoid changing state
> 979          * (b) prevent userspace from changing policy
> 980          */
> 981         if (!aspm_force) {
> 982                 aspm_policy = POLICY_DEFAULT;
> 983                 aspm_disabled = 1;
> 984         }
> 985 }
> 
> But then later on, during individual initialization of PCI devices,
> pci_scan_slot() will call pcie_aspm_init_link_state().
> pcie_aspm_init_link_state() does its work unless global
> aspm_support_enabled is false.
> 
> But, shouldn't pcie_aspm_init_link_state() also check aspm_disabled ?
> Something like:
> 
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 8b56dad..5491dbf 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -574,7 +574,7 @@ void pcie_aspm_init_link_state(struct pci_dev *pdev)
>         struct pcie_link_state *link;
>         int blacklist = !!pcie_aspm_sanity_check(pdev);
> 
> -       if (!aspm_support_enabled)
> +       if (!aspm_support_enabled || aspm_disabled)
>                 return;
> 
>         if (pdev->link_state)
> 
> 
> In "387d375 PCI: Don't clear ASPM bits when the FADT declares it's
> unsupported" the message says:
> 
>     Communications with a hardware vendor confirm that the expected behaviour
>     on systems that set the FADT ASPM disable bit but which still grant full
>     PCIe control is for the OS to leave any BIOS configuration intact and
>     refuse to touch the ASPM bits.  This mimics the behaviour of Windows.
> 
> 
> I apologize, but I do not immediately understand the distinction
> between the meaning of aspm_support_enabled and aspm_disabled so I am
> likely missing some key point.

Don't apologize, this code confuses everybody who looks at it, which
is a clear signal that it needs some love :)

> But anyway, this query comes about because a host which reports the
> ACPI_FADT_NO_ASPM bit set hangs on boot unless pcie_aspm=off is set.

That's a terrible situation and very difficult to debug.  How did you
figure out that this was related to ASPM?  Can you tell anything about
where the hang is?

Is there any chance you could collect a complete dmesg log and output
of "sudo lspci -vvv" from that system (obviously you'd have to boot
with "pcie_aspm=off" or your patch, so we could attach it to a
bugzilla.kernel.org report that could be mentioned in the patch?

I assume this system works with Windows.  I agree that based on the
387d37577fdd changelog, we probably shouldn't be doing anything in
pcie_aspm_init_link_state().

Bjorn

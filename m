Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:59732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754724AbdA0QL1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 27 Jan 2017 11:11:27 -0500
Date: Fri, 27 Jan 2017 10:09:46 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Matthew Garrett <mjg59@coreos.com>
Cc: "Koehrer Mathias (ETAS/ESW5)" <mathias.koehrer@etas.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Julia Cartwright <julia@ni.com>,
        Sebastian Andrzej Siewior <sebastian.siewior@linutronix.de>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: Re: [PATCH] Force to clear ASPM bits if CONFIG_PCIEASPM_PERFORMANCE
 is set
Message-ID: <20170127160946.GA17251@bhelgaas-glaptop.roam.corp.google.com>
References: <95e1fc6e84cf42e094d4a8478c37b18e@FE-MBX1012.de.bosch.com>
 <20161208222025.GB6693@bhelgaas-glaptop.roam.corp.google.com>
 <70624f4bf1514e48ae29e84998a81a80@FE-MBX1012.de.bosch.com>
 <20170112205458.GC8312@bhelgaas-glaptop.roam.corp.google.com>
 <CAPeXnHvbGMC-MuQbVTV+CCjqEbbp6WC4PaWmijEVWv=Nnbm8Zg@mail.gmail.com>
 <20170112231726.GH8312@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170112231726.GH8312@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jan 12, 2017 at 05:17:26PM -0600, Bjorn Helgaas wrote:
> On Thu, Jan 12, 2017 at 01:48:15PM -0800, Matthew Garrett wrote:
> > On Thu, Jan 12, 2017 at 12:54 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > 
> > > Thanks for that.  In addition to yours, we have the following report,
> > > which was also bisected to 387d37577fdd:
> > >
> > >   https://bugzilla.kernel.org/show_bug.cgi?id=102311 ASPM: ASMEDA asm1062 not working
> > >
> > > The changelog for 387d37577fdd doesn't mention any actual bugs that it
> > > fixes.  Should we consider reverting it?  Can you shed any light on
> > > this, Matthew?
> > 
> > Without this commit we disable ASPM on devices that expect to have it
> > enabled and increase idle power consumption by approximately 200% on
> > some laptops. Windows drivers may explicitly change the ASPM state on
> > devices or PCIe bridges, and if so we should be mimicing that
> > behaviour as well.
> 
> Thanks, I should have asked for that information in the 387d37577fdd
> changelog, but it's good to have it now.
> 
> On a system with ACPI_FADT_NO_ASPM set (as in both
> https://bugzilla.kernel.org/show_bug.cgi?id=189951 and
> https://bugzilla.kernel.org/show_bug.cgi?id=102311):
> 
>   - We set aspm_disabled = 1 (since 5fde244d39b8).
> 
>   - Before 387d37577fdd, we called pcie_clear_aspm(), which disabled
>     all ASPM link states, even if aspm_disabled == 1.
> 
>   - After 387d37577fdd, we leave ASPM link states as BIOS configured
>     them.  This explains why the NIC performance issue is related to
>     this commit.

I've been relying on the 387d37577fdd changelog, which says:

  Communications with a hardware vendor confirm that the expected
  behaviour on systems that set the FADT ASPM disable bit but which
  still grant full PCIe control is for the OS to leave any BIOS
  configuration intact and refuse to touch the ASPM bits.

But I don't think the code actually matches this.  After 387d37577fdd,
if ACPI_FADT_NO_ASPM is set, we don't call pcie_clear_aspm().  We do
call pcie_no_aspm(), which sets aspm_disabled = 1.

Setting aspm_disabled affects pcie_aspm_powersave_config_link() and
pcie_aspm_pm_state_change(), which are used in the runtime
pci_enable_device() and pci_power_up(), and pci_set_power_state()
paths.

But it does not affect the pcie_aspm_init_link_state() path, where we
may update ASPM common clock, L0s, and L1 control bits:

  pcie_aspm_init_link_state
    pcie_aspm_cap_init
      pcie_aspm_configure_common_clock
        # write PCI_EXP_LNKCTL_CCC, PCI_EXP_LNKCTL_RL
    pcie_clkpm_cap_init
    if (aspm_policy != POLICY_POWERSAVE)
      pcie_config_aspm_path
        while (link)
          pcie_config_aspm_link
            pcie_config_aspm_dev
              # write PCI_EXP_LNKCTL_ASPM_L0S, PCI_EXP_LNKCTL_ASPM_L1
          link = link->parent
      pcie_set_clkpm
        # write PCI_EXP_LNKCTL_CLKREQ_EN

So even if ACPI_FADT_NO_ASPM is set, I think we *do* touch the ASPM
bits.

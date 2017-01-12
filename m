Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:53512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750730AbdALXRa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 12 Jan 2017 18:17:30 -0500
Date: Thu, 12 Jan 2017 17:17:26 -0600
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
Message-ID: <20170112231726.GH8312@bhelgaas-glaptop.roam.corp.google.com>
References: <95e1fc6e84cf42e094d4a8478c37b18e@FE-MBX1012.de.bosch.com>
 <20161208222025.GB6693@bhelgaas-glaptop.roam.corp.google.com>
 <70624f4bf1514e48ae29e84998a81a80@FE-MBX1012.de.bosch.com>
 <20170112205458.GC8312@bhelgaas-glaptop.roam.corp.google.com>
 <CAPeXnHvbGMC-MuQbVTV+CCjqEbbp6WC4PaWmijEVWv=Nnbm8Zg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAPeXnHvbGMC-MuQbVTV+CCjqEbbp6WC4PaWmijEVWv=Nnbm8Zg@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Emmanuel because of https://bugzilla.kernel.org/show_bug.cgi?id=57331]

On Thu, Jan 12, 2017 at 01:48:15PM -0800, Matthew Garrett wrote:
> On Thu, Jan 12, 2017 at 12:54 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> 
> > Thanks for that.  In addition to yours, we have the following report,
> > which was also bisected to 387d37577fdd:
> >
> >   https://bugzilla.kernel.org/show_bug.cgi?id=102311 ASPM: ASMEDA asm1062 not working
> >
> > The changelog for 387d37577fdd doesn't mention any actual bugs that it
> > fixes.  Should we consider reverting it?  Can you shed any light on
> > this, Matthew?
> 
> Without this commit we disable ASPM on devices that expect to have it
> enabled and increase idle power consumption by approximately 200% on
> some laptops. Windows drivers may explicitly change the ASPM state on
> devices or PCIe bridges, and if so we should be mimicing that
> behaviour as well.

Thanks, I should have asked for that information in the 387d37577fdd
changelog, but it's good to have it now.

On a system with ACPI_FADT_NO_ASPM set (as in both
https://bugzilla.kernel.org/show_bug.cgi?id=189951 and
https://bugzilla.kernel.org/show_bug.cgi?id=102311):

  - We set aspm_disabled = 1 (since 5fde244d39b8).

  - Before 387d37577fdd, we called pcie_clear_aspm(), which disabled
    all ASPM link states, even if aspm_disabled == 1.

  - After 387d37577fdd, we leave ASPM link states as BIOS configured
    them.  This explains why the NIC performance issue is related to
    this commit.

A driver can explicitly change the ASPM state with
pci_disable_link_state().  But that doesn't do anything when
ACPI_FADT_NO_ASPM (and thus aspm_disabled) is set.

Are you suggesting that we should remove the aspm_disabled check and
make pci_disable_link_state() work regardless of ACPI_FADT_NO_ASPM?
It's only called by drivers that presumably know about their device
issues, and one would think it would be relatively safe to *disable*
ASPM states (or at least safer than *enabling* them).

Bjorn

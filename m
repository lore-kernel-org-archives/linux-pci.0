Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:55836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750778AbdALUzC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 12 Jan 2017 15:55:02 -0500
Date: Thu, 12 Jan 2017 14:54:58 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Koehrer Mathias (ETAS/ESW5)" <mathias.koehrer@etas.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Matthew Garrett <mjg59@coreos.com>,
        Julia Cartwright <julia@ni.com>,
        Sebastian Andrzej Siewior <sebastian.siewior@linutronix.de>
Subject: Re: [PATCH] Force to clear ASPM bits if CONFIG_PCIEASPM_PERFORMANCE
 is set
Message-ID: <20170112205458.GC8312@bhelgaas-glaptop.roam.corp.google.com>
References: <95e1fc6e84cf42e094d4a8478c37b18e@FE-MBX1012.de.bosch.com>
 <20161208222025.GB6693@bhelgaas-glaptop.roam.corp.google.com>
 <70624f4bf1514e48ae29e84998a81a80@FE-MBX1012.de.bosch.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <70624f4bf1514e48ae29e84998a81a80@FE-MBX1012.de.bosch.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Dec 09, 2016 at 09:57:03AM +0000, Koehrer Mathias (ETAS/ESW5) wrote:
> Hi Bjorn,
> 
> thanks for the response.
> 
> > > On systems that have PCIe ASPM support in the BIOS enabled the commit
> > > 387d37577fdd05e9472c20885464c2a53b3c945f may lead to the situation
> > > that accesses to registers of enabled PCIe devices are extremely slow.
> > > This happens if the ACPI FADT declares incorrectly that the system
> > > doesn't support PCIe ASPM even if this is enabled in the BIOS.
> > > In this case the function pcie_no_aspm() will be called.
> > > However this sets the aspm_policy to POLICY_DEFAULT even if
> > > CONFIG_PCIEASPM_PERFORMANCE has been configured.
> > > As result, the ASPM on a PCIe may still be set even if this is not
> > > expected.
> > >
> > > This happens e.g. on a HP workstation 800 G1 together with an Intel
> > > dual port Ethernet server adapter i350 plugged in.
> > > Whenever ASPM is enabled in the BIOS the access to the LAN registers
> > > are really slow (read access: slower than 20us).
> > > In this setup the LnkCap of the two LAN controllers and of the
> > > integrated PCIe switch is set to "ASPM L1 Enabled"
> > > even if the controller is configured to be up and running.
> > > There has been a lengthy discussion on this performance issue due to
> > > this issue on the linux-rt-users list:
> > > http://marc.info/?l=linux-rt-users&m=147454824515022&w=2
> > >
> > > This patch solves this issue by forcing to disable ASPM if
> > > CONFIG_PCIEASPM_PERFORMANCE has been set.
> > 
> > The 387d37577fdd changelog says that when ACPI_FADT_NO_ASPM is set, the
> > expected behavior is for the OS to not touch the ASPM configuration, and that this is
> > what Windows does.
> > 
> > If I understand correctly, your proposal in this patch is to change this so that if
> > ACPI_FADT_NO_ASPM is set and CONFIG_PCIEASPM_PERFORMANCE=y,
> > we go ahead and disable ASPM.
> > 
> > Only the firmware author can tell whether it's really a bug that this system sets
> > ACPI_FADT_NO_ASPM.  It could be that there's some platform issue that is
> > avoided by leaving the BIOS ASPM configuration untouched.
> > 
> > If it really *is* a firmware bug, and ACPI_FADT_NO_ASPM is not supposed to be
> > set on this platform, CONFIG_PCIEASPM_PERFORMANCE doesn't feel like the
> > right mechanism for working around it.  It should be safe to enable that for all
> > systems, and for other systems that set ACPI_FADT_NO_ASPM correctly, we
> > should not touch ASPM configuration.
> > 
> > Can you open a bugzilla at http://bugzilla.kernel.org and attach the complete dmesg
> > log and "lspci -vv" output?  This is a subtle area where we've had many break/fix
> > cycles, and it's important to be able to go back and look at details of problems that
> > motivated previous changes.
> > 
> I have create a new bug report (id=189951).
> https://bugzilla.kernel.org/show_bug.cgi?id=189951 

Thanks for that.  In addition to yours, we have the following report,
which was also bisected to 387d37577fdd:

  https://bugzilla.kernel.org/show_bug.cgi?id=102311 ASPM: ASMEDA asm1062 not working

The changelog for 387d37577fdd doesn't mention any actual bugs that it
fixes.  Should we consider reverting it?  Can you shed any light on
this, Matthew?

The 387d37577fdd *does* say that it mimics the behavior of Windows.
Is there any chance you could test that, Mathias?

E.g., your report is that the NIC performs well in Linux when the BIOS
PCIe energy saving feature is disabled, but poorly when the BIOS
feature is enabled.  Is it the same under Windows?

I would sort of expect that the NIC performs well under Windows with
energy saving enabled, because I would think HP would have tested that
and noticed any problem, but of course I have no evidence either way.

Bjorn

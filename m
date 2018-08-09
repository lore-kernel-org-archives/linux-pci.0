Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:45072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726310AbeHIUzO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 9 Aug 2018 16:55:14 -0400
Date: Thu, 9 Aug 2018 13:29:05 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alex_Gagniuc@Dellteam.com
Cc: mr.nuke.me@gmail.com, bhelgaas@google.com, keith.busch@intel.com,
        Austin.Bolen@dell.com, Shyam.Iyer@dell.com, fred@fredlawl.com,
        poza@codeaurora.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/AER: Do not clear AER bits if we don't own AER
Message-ID: <20180809182905.GA113140@bhelgaas-glaptop.roam.corp.google.com>
References: <20180717153135.25925-1-mr.nuke.me@gmail.com>
 <20180809141551.GH49411@bhelgaas-glaptop.roam.corp.google.com>
 <2cae6a5ac8324be18b8dcf3d7dfcc288@ausx13mps321.AMER.DELL.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2cae6a5ac8324be18b8dcf3d7dfcc288@ausx13mps321.AMER.DELL.COM>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 09, 2018 at 04:46:32PM +0000, Alex_Gagniuc@Dellteam.com wrote:
> On 08/09/2018 09:16 AM, Bjorn Helgaas wrote:
> > On Tue, Jul 17, 2018 at 10:31:23AM -0500, Alexandru Gagniuc wrote:
> >> When we don't own AER, we shouldn't touch the AER error bits. This
> >> happens unconditionally on device probe(). Clearing AER bits
> >> willy-nilly might cause firmware to miss errors. Instead
> >> these bits should get cleared by FFS, or via ACPI _HPX method.
> >>
> >> This race is mostly of theoretical significance, as it is not easy to
> >> reasonably demonstrate it in testing.
> >>
> >> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
> >> ---
> >>   drivers/pci/pcie/aer.c | 3 +++
> >>   1 file changed, 3 insertions(+)
> >>
> >> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> >> index a2e88386af28..18037a2a8231 100644
> >> --- a/drivers/pci/pcie/aer.c
> >> +++ b/drivers/pci/pcie/aer.c
> >> @@ -383,6 +383,9 @@ int pci_cleanup_aer_error_status_regs(struct pci_dev *dev)
> >>   	if (!pci_is_pcie(dev))
> >>   		return -ENODEV;
> >>   
> >> +	if (pcie_aer_get_firmware_first(dev))
> >> +		return -EIO;
> > 
> > I like this patch.
> > 
> > Do we need the same thing in the following places that also clear AER
> > status bits or write AER control bits?
> 
> In theory, every exported function would guard for this. I think the 
> idea a long long time ago was that the check happens during 
> initialization, and the others are not hit.
> 
> >    enable_ecrc_checking()
> >    disable_ecrc_checking()
> 
> I don't immediately see how this would affect FFS, but the bits are part 
> of the AER capability structure. According to the FFS model, those would 
> be owned by FW, and we'd have to avoid touching them.

Per ACPI v6.2, sec 18.3.2.4, the HEST may contain entries for Root
Ports that contain the FIRMWARE_FIRST flag as well as values the OS is
supposed to write to several AER capability registers.  It looks like
we currently ignore everything except the FIRMWARE_FIRST and GLOBAL
flags (ACPI_HEST_FIRMWARE_FIRST and ACPI_HEST_GLOBAL in Linux).

That seems like a pretty major screwup and more than I want to fix
right now.

> >    pci_cleanup_aer_uncorrect_error_status()
> 
> This probably should be guarded. It's only called from a few specific 
> drivers, so the impact is not as high as being called from the core.
> 
> >    pci_aer_clear_fatal_status()
> 
> This is only called when doing fatal_recovery, right?

True.  It takes a lot of analysis to convince oneself that this is not
used in the firmware-first path, so I think we should add a guard
there.

> For practical considerations this is not an issue today. The ACPI error 
> handling code currently crashes when it encounters any fatal error, so 
> we wouldn't hit this in the FFS case.

I wasn't aware the firmware-first path was *that* broken.  Are there
problem reports for this?  Is this a regression?

> The PCIe standards contact I usually talk to about these PCIe subtleties 
> is currently on vacation. The number one issue was a FFS corner case 
> with OS clearing bits on probe. The other functions you mention are a 
> corner case of a corner case. The big fish is 
> pci_cleanup_aer_error_status_regs() on probe(), and it would be nice to 
> have that resolved.
> 
> I'll sync up with Austin when he gets back to see about the other 
> functions though I suspect we'll end up fixing them as well.

I'd like to fix all the obvious cases at once (excluding the ECRC
stuff).  What do you think about the following patch?


commit 15ed68dcc26864c849a12a36db4d4771bad7991f
Author: Alexandru Gagniuc <mr.nuke.me@gmail.com>
Date:   Tue Jul 17 10:31:23 2018 -0500

    PCI/AER: Don't clear AER bits if error handling is Firmware-First
    
    If the platform requests Firmware-First error handling, firmware is
    responsible for reading and clearing AER status bits.  If OSPM also clears
    them, we may miss errors.  See ACPI v6.2, sec 18.3.2.5 and 18.4.
    
    This race is mostly of theoretical significance, as it is not easy to
    reasonably demonstrate it in testing.
    
    Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
    [bhelgaas: add similar guards to pci_cleanup_aer_uncorrect_error_status()
    and pci_aer_clear_fatal_status()]
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index c6cc855bfa22..4e823ae051a7 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -397,6 +397,9 @@ int pci_cleanup_aer_uncorrect_error_status(struct pci_dev *dev)
 	if (!pos)
 		return -EIO;
 
+	if (pcie_aer_get_firmware_first(dev))
+		return -EIO;
+
 	/* Clear status bits for ERR_NONFATAL errors only */
 	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_STATUS, &status);
 	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_SEVER, &sev);
@@ -417,6 +420,9 @@ void pci_aer_clear_fatal_status(struct pci_dev *dev)
 	if (!pos)
 		return;
 
+	if (pcie_aer_get_firmware_first(dev))
+		return;
+
 	/* Clear status bits for ERR_FATAL errors only */
 	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_STATUS, &status);
 	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_SEVER, &sev);
@@ -438,6 +444,9 @@ int pci_cleanup_aer_error_status_regs(struct pci_dev *dev)
 	if (!pos)
 		return -EIO;
 
+	if (pcie_aer_get_firmware_first(dev))
+		return -EIO;
+
 	port_type = pci_pcie_type(dev);
 	if (port_type == PCI_EXP_TYPE_ROOT_PORT) {
 		pci_read_config_dword(dev, pos + PCI_ERR_ROOT_STATUS, &status);

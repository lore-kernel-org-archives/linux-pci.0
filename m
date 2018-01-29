Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:44228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932391AbeA2U1w (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 29 Jan 2018 15:27:52 -0500
Date: Mon, 29 Jan 2018 14:27:50 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Frederick Lawler <fred@fredlawl.com>
Cc: linux-pci@vger.kernel.org, Keith Busch <keith.busch@intel.com>,
        Oza Pawandeep <poza@codeaurora.org>,
        Taku Izumi <izumi.taku@jp.fujitsu.com>,
        Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH 1/1] PCI: Replace pci_find_ext_capability() calls with
 pci_dev aer_cap
Message-ID: <20180129202750.GC232763@bhelgaas-glaptop.roam.corp.google.com>
References: <1517191338-22415-1-git-send-email-fred@fredlawl.com>
 <1517191338-22415-2-git-send-email-fred@fredlawl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1517191338-22415-2-git-send-email-fred@fredlawl.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Keith, Oza, Taku, Sinan]

On Sun, Jan 28, 2018 at 08:02:18PM -0600, Frederick Lawler wrote:
> Replace pci_find_ext_capability(..., PCI_EXT_CAP_ID_ERR) calls with
> pci_dev aer_cap.
> 
> Signed-off-by: Frederick Lawler <fred@fredlawl.com>
> ---
>  drivers/pci/pcie/aer/aer_inject.c |  4 +-
>  drivers/pci/pcie/aer/ecrc.c       |  4 +-
>  drivers/pci/pcie/portdrv_core.c   | 15 ++++++--
>  drivers/pci/probe.c               | 80 +++++++++++++++++++++------------------
>  4 files changed, 58 insertions(+), 45 deletions(-)

> @@ -1749,42 +1746,51 @@ static void program_hpp_type2(struct pci_dev *dev, struct hpp_type2 *hpp)
>  			~hpp->pci_exp_lnkctl_and, hpp->pci_exp_lnkctl_or);
>  	}
>  
> -	/* Find Advanced Error Reporting Enhanced Capability */
> -	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR);
> -	if (!pos)
> -		return;
> +#ifdef CONFIG_PCIEAER
> +	if (dev->aer_cap) {
> +		u16 pos = dev->aer_cap;
> +		u32 reg32;

I know we talked about this, but thinking about this some more, I
don't think this is the right solution.  This code is in this path:

  pci_device_add
    pci_configure_device
      pci_get_hp_params          # runs ACPI _HPP method
      program_hpp_type2
        if (dev->aer_cap)        # <-- use dev->aer_cap
          ...
    pci_init_capabilities
      pci_aer_init
        dev->aer_cap = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR)

So we have an ordering problem: we're testing dev->aer_cap before we
set it.  I think we should just drop this hunk and leave
program_hpp_type2() unchanged.

Even without the ordering issue, I think this code should not be
conditional upon CONFIG_PCIEAER.  Here's my rationale:

The _HPP method (ACPI r6.0, sec 6.2.8) is a way for the platform
(i.e., the BIOS) to tell the OS how it wants devices configured.  It
stands for "Hot Plug Parameters" but the spec says it should be used
for hot-added devices and "devices not configured by the BIOS at
system boot".  Since the spec doesn't tell us how to identify "devices
not configured by the BIOS", we apply this to all devices.

There's also some platform/OS coordination via the _OSC method (ACPI
r6.0, sec 6.2.11).  Basically the OS uses _OSC to request permission
from the platform to handle error reporting via the AER capability.

The Linux AER reporting functionality is enabled by CONFIG_PCIEAER.
The question now is what we should do with _HPP AER information when
(a) CONFIG_PCIEAER=y but the platform (via _OSC) doesn't give us
permission to handle error reporting, or (b) CONFIG_PCIEAER=n.

In case (a), I think there's a fairly good argument that we should
still use _HPP to program the AER registers.  The platform probably
declined to give the OS permission to handle error reporting because
it wants to handle error reporting itself.  The platform's AER
handling probably wants the AER registers of hot-added devices
programmed a certain way.  The BIOS is not involved in native PCIe
hotplug, so the only way to get a new device configured is via _HPP.

In case (b), I think the same argument applies.  The platform's error
handling (if any) should not depend on whether CONFIG_PCIEAER is
enabled in the OS.

This is in fact how the existing program_hpp_type2() works: we look
for the AER capability and program it, regardless of CONFIG_PCIEAER
and _OSC.  I think we should preserve that behavior.

I think there's an unrelated problem nearby in the enumeration path:

  pci_device_add
    pci_configure_device
    pci_init_capabilities
      pci_aer_init
        pci_cleanup_aer_error_status_regs     # only if CONFIG_PCIEAER=y
          read PCI_ERR_UNCOR_STATUS
          write PCI_ERR_UNCOR_STATUS          # clear errors

The pci_cleanup_aer_error_status_regs() code was added by b07461a8e45b
("PCI/AER: Clear error status registers during enumeration and
restore").  When we probe for devices below a Root Port or a Switch
Port, AER will log Unsupported Request errors if the device does not
exist (see the implementation note in PCIe r4.0, sec 2.3.2).

pci_cleanup_aer_error_status_regs() does clear those errors, but only
if CONFIG_PCIEAER=y.  If CONFIG_PCIEAER is not set, both
pci_aer_init() and pci_cleanup_aer_error_status_regs() are stub
functions that do nothing.

That means that when CONFIG_PCIEAER is not set, enumeration leaves UR
errors logged in the switch ports.  That doesn't seem like the right
thing, because it's confusing to see those in subsequent "lspci -vv"
output.  And it may confuse any error handling done by the platform.

I think we should do this for starters:

  - Move pci_dev.aer_cap outside the #ifdef CONFIG_PCIEAER.
  - Move pci_aer_init() to a file where it is always compiled and
    remove the stub function.
  - Move pci_cleanup_aer_error_status_regs() to a file where it is
    always compiled and remove the stub function.

Even this is probably isn't quite right for platforms that do their
own error handling.  It seems like it would be better to keep the
platform from being notified about these errors by masking the UR
errors during enumeration, then clearing and unmasking them
afterwards.  That would also improve the code by directly associating
the solution (masking/clearing) with the problem (UR during
enumeration).

> -	/* Initialize Uncorrectable Error Mask Register */
> -	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_MASK, &reg32);
> -	reg32 = (reg32 & hpp->unc_err_mask_and) | hpp->unc_err_mask_or;
> -	pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_MASK, reg32);

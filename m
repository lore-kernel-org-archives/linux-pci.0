Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:33988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932303AbcLHWUb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 8 Dec 2016 17:20:31 -0500
Date: Thu, 8 Dec 2016 16:20:25 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Koehrer Mathias (ETAS/ESW5)" <mathias.koehrer@etas.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Matthew Garrett <mjg59@coreos.com>,
        Julia Cartwright <julia@ni.com>,
        Sebastian Andrzej Siewior <sebastian.siewior@linutronix.de>
Subject: Re: [PATCH] Force to clear ASPM bits if CONFIG_PCIEASPM_PERFORMANCE
 is set
Message-ID: <20161208222025.GB6693@bhelgaas-glaptop.roam.corp.google.com>
References: <95e1fc6e84cf42e094d4a8478c37b18e@FE-MBX1012.de.bosch.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <95e1fc6e84cf42e094d4a8478c37b18e@FE-MBX1012.de.bosch.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Nov 02, 2016 at 09:26:55AM +0000, Koehrer Mathias (ETAS/ESW5) wrote:
> On systems that have PCIe ASPM support in the BIOS enabled
> the commit 387d37577fdd05e9472c20885464c2a53b3c945f may lead
> to the situation that accesses to registers of enabled
> PCIe devices are extremely slow.
> This happens if the ACPI FADT declares incorrectly that the
> system doesn't support PCIe ASPM even if this is enabled in
> the BIOS.
> In this case the function pcie_no_aspm() will be called.
> However this sets the aspm_policy to POLICY_DEFAULT even
> if CONFIG_PCIEASPM_PERFORMANCE has been configured.
> As result, the ASPM on a PCIe may still be set even if 
> this is not expected.
> 
> This happens e.g. on a HP workstation 800 G1 together with
> an Intel dual port Ethernet server adapter i350 plugged in.
> Whenever ASPM is enabled in the BIOS the access to the 
> LAN registers are really slow (read access: slower than 20us).
> In this setup the LnkCap of the two LAN controllers and
> of the integrated PCIe switch is set to "ASPM L1 Enabled" 
> even if the controller is configured to be up and running.
> There has been a lengthy discussion on this performance issue
> due to this issue on the linux-rt-users list:
> http://marc.info/?l=linux-rt-users&m=147454824515022&w=2
>
> This patch solves this issue by forcing to disable ASPM
> if CONFIG_PCIEASPM_PERFORMANCE has been set.

The 387d37577fdd changelog says that when ACPI_FADT_NO_ASPM is
set, the expected behavior is for the OS to not touch the ASPM
configuration, and that this is what Windows does.

If I understand correctly, your proposal in this patch is to change
this so that if ACPI_FADT_NO_ASPM is set and
CONFIG_PCIEASPM_PERFORMANCE=y, we go ahead and disable ASPM.

Only the firmware author can tell whether it's really a bug that this
system sets ACPI_FADT_NO_ASPM.  It could be that there's some platform
issue that is avoided by leaving the BIOS ASPM configuration
untouched.

If it really *is* a firmware bug, and ACPI_FADT_NO_ASPM is not
supposed to be set on this platform, CONFIG_PCIEASPM_PERFORMANCE
doesn't feel like the right mechanism for working around it.  It
should be safe to enable that for all systems, and for other systems
that set ACPI_FADT_NO_ASPM correctly, we should not touch ASPM
configuration.

Can you open a bugzilla at http://bugzilla.kernel.org and attach the
complete dmesg log and "lspci -vv" output?  This is a subtle area
where we've had many break/fix cycles, and it's important to be able
to go back and look at details of problems that motivated previous
changes.

BTW, the conventional commit reference format is

  387d37577fdd ("PCI: Don't clear ASPM bits when the FADT declares
  it's unsupported")

> Signed-off-by: Mathias Koehrer <mathias.koehrer@etas.com>
> 
> ---
>  drivers/pci/pcie/aspm.c |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> Index: linux-4.8/drivers/pci/pcie/aspm.c
> ===================================================================
> --- linux-4.8.orig/drivers/pci/pcie/aspm.c
> +++ linux-4.8/drivers/pci/pcie/aspm.c
> @@ -79,10 +79,13 @@ static LIST_HEAD(link_list);
>  
>  #ifdef CONFIG_PCIEASPM_PERFORMANCE
>  static int aspm_policy = POLICY_PERFORMANCE;
> +static int aspm_default_config_policy = POLICY_PERFORMANCE;
>  #elif defined CONFIG_PCIEASPM_POWERSAVE
>  static int aspm_policy = POLICY_POWERSAVE;
> +static int aspm_default_config_policy = POLICY_POWERSAFE;
>  #else
>  static int aspm_policy;
> +static int aspm_default_config_policy;
>  #endif
>  
>  static const char *policy_str[] = {
> @@ -946,7 +949,7 @@ void pcie_no_aspm(void)
>  	 * (b) prevent userspace from changing policy
>  	 */
>  	if (!aspm_force) {
> -		aspm_policy = POLICY_DEFAULT;
> +		aspm_policy = aspm_default_config_policy;

You would need to update the comment just above this to reflect the
new code.

>  		aspm_disabled = 1;
>  	}
>  }

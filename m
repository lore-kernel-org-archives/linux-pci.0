Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:53383 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933253Ab2KEWe6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 5 Nov 2012 17:34:58 -0500
Received: by mail-wg0-f44.google.com with SMTP id dr13so4278421wgb.1
        for <linux-pci@vger.kernel.org>; Mon, 05 Nov 2012 14:34:57 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20121105223306.7246.36325.stgit@bhelgaas.mtv.corp.google.com>
References: <20121105223306.7246.36325.stgit@bhelgaas.mtv.corp.google.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 5 Nov 2012 15:34:36 -0700
Message-ID: <CAErSpo6vmCbStwmE0TpNrXwZhPmPO=NmaCw_NWScRiFyZxqpwA@mail.gmail.com>
Subject: Re: [PATCH] x86/PCI: Ignore _SEG on HP xw9300
To: linux-pci@vger.kernel.org
Cc: "Sean M. Pappalardo" <pegasus@renegadetech.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Nov 5, 2012 at 3:33 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> The xw9300 BIOS supplies _SEG methods that are incorrect, which results
> in some LSI SCSI devices not being discovered.  This adds a quirk to
> ignore _SEG on this machine and default to zero.
>
> The xw9300 has three host bridges:
>
>     ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-3f])
>     ACPI: PCI Root Bridge [PCI1] (domain 0001 [bus 40-7f])
>     ACPI: PCI Root Bridge [PCI2] (domain 0002 [bus 80-ff])
>
> When the BIOS "ACPI Bus Segmentation" option is enabled (as it is by
> default), the _SEG methods of the PCI1 and PCI2 bridges return 1 and 2,
> respectively.  However, the BIOS implementation appears to be incomplete,
> and we can't enumerate devices in those domains.
>
> But if we assume PCI1 and PCI2 really lead to buses in domain 0,
> everything works fine.  Windows XP and Vista also seem to ignore
> these _SEG methods.
>
> Reference: http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=543308
> Reference: https://bugzilla.kernel.org/show_bug.cgi?id=15362
> Reported-and-Tested-by: Sean M. Pappalardo <pegasus@renegadetech.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Sorry, I forgot to post this here.  Speak up if you see any issues.

I applied this to my pci/misc branch as v3.8 material.

> ---
>  arch/x86/pci/acpi.c |   25 +++++++++++++++++++++++--
>  1 files changed, 23 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
> index 192397c..49e5195 100644
> --- a/arch/x86/pci/acpi.c
> +++ b/arch/x86/pci/acpi.c
> @@ -22,6 +22,7 @@ struct pci_root_info {
>  };
>
>  static bool pci_use_crs = true;
> +static bool pci_ignore_seg = false;
>
>  static int __init set_use_crs(const struct dmi_system_id *id)
>  {
> @@ -35,7 +36,14 @@ static int __init set_nouse_crs(const struct dmi_system_id *id)
>         return 0;
>  }
>
> -static const struct dmi_system_id pci_use_crs_table[] __initconst = {
> +static int __init set_ignore_seg(const struct dmi_system_id *id)
> +{
> +       printk(KERN_INFO "PCI: %s detected: ignoring ACPI _SEG\n", id->ident);
> +       pci_ignore_seg = true;
> +       return 0;
> +}
> +
> +static const struct dmi_system_id pci_crs_quirks[] __initconst = {
>         /* http://bugzilla.kernel.org/show_bug.cgi?id=14183 */
>         {
>                 .callback = set_use_crs,
> @@ -98,6 +106,16 @@ static const struct dmi_system_id pci_use_crs_table[] __initconst = {
>                         DMI_MATCH(DMI_BIOS_VERSION, "6JET85WW (1.43 )"),
>                 },
>         },
> +
> +       /* https://bugzilla.kernel.org/show_bug.cgi?id=15362 */
> +       {
> +               .callback = set_ignore_seg,
> +               .ident = "HP xw9300",
> +               .matches = {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
> +                       DMI_MATCH(DMI_PRODUCT_NAME, "HP xw9300 Workstation"),
> +               },
> +       },
>         {}
>  };
>
> @@ -108,7 +126,7 @@ void __init pci_acpi_crs_quirks(void)
>         if (dmi_get_date(DMI_BIOS_DATE, &year, NULL, NULL) && year < 2008)
>                 pci_use_crs = false;
>
> -       dmi_check_system(pci_use_crs_table);
> +       dmi_check_system(pci_crs_quirks);
>
>         /*
>          * If the user specifies "pci=use_crs" or "pci=nocrs" explicitly, that
> @@ -455,6 +473,9 @@ struct pci_bus * __devinit pci_acpi_scan_root(struct acpi_pci_root *root)
>         int pxm;
>  #endif
>
> +       if (pci_ignore_seg)
> +               domain = 0;
> +
>         if (domain && !pci_domains_supported) {
>                 printk(KERN_WARNING "pci_bus %04x:%02x: "
>                        "ignored (multiple domains not supported)\n",
>

Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:35551 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752181Ab2GCQRR (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 3 Jul 2012 12:17:17 -0400
Received: by lbbgm6 with SMTP id gm6so9715586lbb.19
        for <linux-pci@vger.kernel.org>; Tue, 03 Jul 2012 09:17:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1341305709-8943-1-git-send-email-acelan.kao@canonical.com>
References: <1341305709-8943-1-git-send-email-acelan.kao@canonical.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 3 Jul 2012 10:16:54 -0600
Message-ID: <CAErSpo61zd1Lv9s3CaTNTnmYemkhM=a8Lw_2bm4V=1GipJgzSw@mail.gmail.com>
Subject: Re: [PATCH] PCI: Quirk for ASUS S3 issue
To: AceLan Kao <acelan.kao@canonical.com>
Cc: linux-pci@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
	"Rafael J. Wysocki" <rjw@sisk.pl>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jul 3, 2012 at 2:55 AM, AceLan Kao <acelan.kao@canonical.com> wrote:
> Some of ASUS machines have problem to enter S3.

This should include a specific description of the problem the user
sees.  From the code comment, it something like "Attempt to suspend
some ASUS systems causes hang.  Power cycle required to recover."
might be appropriate.

The quirk you added is not specific to ASUS, though, so it must be
something that's safe on every system using the AMD and ATI devices
you specified.  I don't know whether that's the case.

> The root cause of this issue is result from the the BIOS will try to
> disable USBs which was already disabled by driver.
> BIOS will to check the EHCI command register, if it's not zero, then
> BIOS will think the USB is not disabled yet, so it will try to disable
> USB again.
> To resolve this, we should clear the EHCI command register before
> entering S3. And this does no harm to the system, since it'll switch
> off the power after enter S3, so the value in memory is not important
> at all.

System RAM is preserved in the S3 state (ACPI spec sec 7.3.4.4), so I
don't know how to interpret this statement.

Please include a bugzilla or problem report URL if you have one.

I'm not a USB or suspend/resume expert, so please get folks like Alan
Stern and Rafael Wysocki to take a look at this (cc'd).

Please read the comment at the top of pci_ids.h; I don't think you
need to change that file.

> Signed-off-by: AceLan Kao <acelan.kao@canonical.com>
> ---
>  drivers/pci/quirks.c    |   15 +++++++++++++++
>  include/linux/pci_ids.h |    2 ++
>  2 files changed, 17 insertions(+)
>
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 194b243a..684cd1f 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -2955,6 +2955,21 @@ static void __devinit asus_ehci_no_d3(struct pci_dev *dev)
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1c26, asus_ehci_no_d3);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1c2d, asus_ehci_no_d3);
>
> +/*
> + * ASUS BIOS will check EHCI command register to see if USB if disabled
> + * or not. BIOS will try to disable USB if the command register is not
> + * cleared. But, actually, USB is disabled by the driver while entering S3,
> + * so it'll hang in BIOS when it try to disable USB.
> + * Since it's going to enter S3, so it does no harm to clear the command
> + * register.
> + */
> +static void asus_clear_pci_command(struct pci_dev *dev)
> +{
> +       pci_write_config_word(dev, PCI_COMMAND, 0);
> +}
> +DECLARE_PCI_FIXUP_SUSPEND(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_HUDSON_EHCI, asus_clear_memory_bit);
> +DECLARE_PCI_FIXUP_SUSPEND(PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_EHCI, asus_clear_memory_bit);
> +
>  static void pci_do_fixups(struct pci_dev *dev, struct pci_fixup *f,
>                           struct pci_fixup *end)
>  {
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index ab741b0..e79c469 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -216,6 +216,7 @@
>  #define PCI_DEVICE_ID_ATI_68800                0x4158
>  #define PCI_DEVICE_ID_ATI_215CT222     0x4354
>  #define PCI_DEVICE_ID_ATI_210888CX     0x4358
> +#define PCI_DEVICE_ID_ATI_EHCI         0x4396
>  #define PCI_DEVICE_ID_ATI_215ET222     0x4554
>  /* Mach64 / Rage */
>  #define PCI_DEVICE_ID_ATI_215GB                0x4742
> @@ -553,6 +554,7 @@
>  #define PCI_DEVICE_ID_AMD_8131_BRIDGE  0x7450
>  #define PCI_DEVICE_ID_AMD_8131_APIC    0x7451
>  #define PCI_DEVICE_ID_AMD_8132_BRIDGE  0x7458
> +#define PCI_DEVICE_ID_AMD_HUDSON_EHCI  0x7808
>  #define PCI_DEVICE_ID_AMD_HUDSON2_SMBUS        0x780b
>  #define PCI_DEVICE_ID_AMD_CS5535_IDE    0x208F
>  #define PCI_DEVICE_ID_AMD_CS5536_ISA    0x2090
> --
> 1.7.9.5
>

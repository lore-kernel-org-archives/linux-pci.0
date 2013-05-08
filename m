Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f182.google.com ([209.85.214.182]:58256 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751925Ab3EHWwR (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 8 May 2013 18:52:17 -0400
Received: by mail-ob0-f182.google.com with SMTP id eh20so2314289obb.13
        for <linux-pci@vger.kernel.org>; Wed, 08 May 2013 15:52:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1367863413-30087-1-git-send-email-jon.mason@intel.com>
References: <1367863413-30087-1-git-send-email-jon.mason@intel.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 8 May 2013 15:51:56 -0700
Message-ID: <CAErSpo5aWc-jFbYZnEwiiihQ7nXj16tL8++oqjeypXO6GQzbEw@mail.gmail.com>
Subject: Re: [PATCH] PCI: Workaround for NTB BAR size issue
To: Jon Mason <jon.mason@intel.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, May 6, 2013 at 11:03 AM, Jon Mason <jon.mason@intel.com> wrote:
> Certain NTB devices have a hardware errata where, regardless of
> pre-configured value, reading the BAR size returns 4096.  To work around
> this issue, add a PCI quirk to read the appropriate values from an
> alternative register in PCI config space and move the resource endpoints
> to the appropriate location.

Is there a documentation pointer we could add to the changelog?

I applied this to my pci/misc branch.  As soon as v3.10-rc1 is out,
I'll rebase to that and incorporate it into -next.

> Signed-off-by: Jon Mason <jon.mason@intel.com>
> ---
>  drivers/pci/quirks.c |   24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 7d68aee..a57a93b 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -2865,6 +2865,30 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x65f9, quirk_intel_mc_errata);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x65fa, quirk_intel_mc_errata);
>
>
> +/* Ivytown NTB BAR sizes are misreported by the hardware due to an errata.  To
> + * work around this, query the size it should be configured to by the device and
> + * modify the resource end to correspond to this new size.
> + */
> +static void quirk_intel_ntb(struct pci_dev *dev)
> +{
> +       int rc;
> +       u8 val;
> +
> +       rc = pci_read_config_byte(dev, 0x00D0, &val);
> +       if (rc)
> +               return;
> +
> +       dev->resource[2].end = dev->resource[2].start + ((u64) 1 << val) - 1;
> +
> +       rc = pci_read_config_byte(dev, 0x00D1, &val);
> +       if (rc)
> +               return;
> +
> +       dev->resource[4].end = dev->resource[4].start + ((u64) 1 << val) - 1;
> +}
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x0e08, quirk_intel_ntb);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x0e0d, quirk_intel_ntb);
> +
>  static ktime_t fixup_debug_start(struct pci_dev *dev,
>                                  void (*fn)(struct pci_dev *dev))
>  {
> --
> 1.7.9.5
>

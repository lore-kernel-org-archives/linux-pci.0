Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qg0-f44.google.com ([209.85.192.44]:57505 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750922AbbBBO4B (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 2 Feb 2015 09:56:01 -0500
Received: by mail-qg0-f44.google.com with SMTP id l89so47738474qgf.3
        for <linux-pci@vger.kernel.org>; Mon, 02 Feb 2015 06:56:00 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1561014.NTLJeH8lPH@dabox>
References: <1561014.NTLJeH8lPH@dabox>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 2 Feb 2015 08:55:33 -0600
Message-ID: <CAErSpo68--PsYC8+E6c27mRtEKtNsNRNLUDdqTqfiExCiPhauw@mail.gmail.com>
Subject: Re: [PATCH] 3.19-rc7: add quirk for 1c28:0122 (rev 14) SATA controller
To: Tim Sander <tim@krieglstein.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Alex]

On Mon, Feb 2, 2015 at 5:29 AM, Tim Sander <tim@krieglstein.org> wrote:
>
> The long name for this device is
> Lite-On IT Corp. / Plextor M6e PCI Express SSD [Marvell 88SS9183] (rev 14)
>
> Background: the error description on bugzilla
> https://bugzilla.kernel.org/show_bug.cgi?id=42679
> inspired me to check if my brand new m4 pci ssd could work with a quirk.
> Its device representation is not visible before this patch.
> After this patch it appears as a normal device. Formatting
> and mounting worked so far.
>
> Signed-off-by: Tim Sander <tim@krieglstein.org>

Hi Tim,

Thanks a lot for the patch.  Can you open a new report at
http://bugzilla.kernel.org and attach the complete dmesg and "lspci
-vv" output without this patch, and also a dmesg log *with* this
patch?  I like to keep a little documentation around in case we
restructure this code in the future.

Also, since the vendor and device IDs are used only once, we probably
won't add them to pci_ids.h (see the comment at the top of the file).
Just use the bare constants in the quirk.

Bjorn

> ---
>  drivers/pci/quirks.c    | 4 ++++
>  include/linux/pci_ids.h | 3 +++
>  2 files changed, 7 insertions(+)
>
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index e52356a..fad7383 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3540,6 +3540,10 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_TTI, 0x0642,
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_JMICRON,
>                          PCI_DEVICE_ID_JMICRON_JMB388_ESD,
>                          quirk_dma_func1_alias);
> +/* https://bugzilla.kernel.org/show_bug.cgi?id=42679 */
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LITE_ON,
> +                        PCI_DEVICE_ID_PLEXTOR_M6E,
> +                        quirk_dma_func1_alias);
>
>  /*
>   * A few PCIe-to-PCI bridges fail to expose a PCIe capability, resulting in
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index e63c02a..1607b20 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -2487,6 +2487,9 @@
>
>  #define PCI_VENDOR_ID_ASMEDIA          0x1b21
>
> +#define PCI_VENDOR_ID_LITE_ON          0x1c28
> +#define PCI_DEVICE_ID_PLEXTOR_M6E      0x0122
> +
>  #define PCI_VENDOR_ID_CIRCUITCO                0x1cc8
>  #define PCI_SUBSYSTEM_ID_CIRCUITCO_MINNOWBOARD 0x0001
>
> --
> 1.9.1
>
>

Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qc0-f182.google.com ([209.85.216.182]:40894 "EHLO
	mail-qc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750868AbaJBCQ6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 1 Oct 2014 22:16:58 -0400
Received: by mail-qc0-f182.google.com with SMTP id i17so1524464qcy.13
        for <linux-pci@vger.kernel.org>; Wed, 01 Oct 2014 19:16:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1412210092.10667.3.camel@pasglop>
References: <1412210092.10667.3.camel@pasglop>
Date: Wed, 1 Oct 2014 22:16:57 -0400
Message-ID: <CADnq5_Pizkne_pHJiT1eUgsrK0SY0F_KvWazvNkg02qS49Shig@mail.gmail.com>
Subject: Re: [PATCH 4/4] ALSA: hda - Limit 40bit DMA for AMD HDMI controllers
From: Alex Deucher <alexdeucher@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Dave Airlie <airlied@linux.ie>,
	Brian King <brking@linux.vnet.ibm.com>,
	Takashi Iwai <tiwai@suse.de>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Yijing Wang <wangyijing@huawei.com>,
	Anton Blanchard <anton@au1.ibm.com>, linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Oct 1, 2014 at 8:34 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
>
> AMD/ATI HDMI controller chip models, we already have a filter to lower
> to 32bit DMA, but the rest are supposed to be working with 64bit
> although the hardware doesn't really work with 63bit but only with 40
> or 48bit DMA.  In this patch, we take 40bit DMA for safety for the
> AMD/ATI controllers as the graphics drivers does.
>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> CC: <stable@vger.kernel.org>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>
> Tested, works fine. This patch is actually independent of the rest
> of the series
>
>  sound/pci/hda/hda_intel.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
> index f91ba7f..48d0f30 100644
> --- a/sound/pci/hda/hda_intel.c
> +++ b/sound/pci/hda/hda_intel.c
> @@ -1483,6 +1483,7 @@ static int azx_first_init(struct azx *chip)
>         struct snd_card *card = chip->card;
>         int err;
>         unsigned short gcap;
> +       unsigned int dma_bits = 64;
>
>  #if BITS_PER_LONG != 64
>         /* Fix up base address on ULI M5461 */
> @@ -1524,9 +1525,14 @@ static int azx_first_init(struct azx *chip)
>         gcap = azx_readw(chip, GCAP);
>         dev_dbg(card->dev, "chipset global capabilities = 0x%x\n", gcap);
>
> +       /* AMD devices support 40 or 48bit DMA, take the safe one */
> +       if (chip->pci->vendor == PCI_VENDOR_ID_AMD)
> +               dma_bits = 40;
> +
>         /* disable SB600 64bit support for safety */
>         if (chip->pci->vendor == PCI_VENDOR_ID_ATI) {
>                 struct pci_dev *p_smbus;
> +               dma_bits = 40;
>                 p_smbus = pci_get_device(PCI_VENDOR_ID_ATI,
>                                          PCI_DEVICE_ID_ATI_SBX00_SMBUS,
>                                          NULL);
> @@ -1556,9 +1562,11 @@ static int azx_first_init(struct azx *chip)
>         }
>
>         /* allow 64bit DMA address if supported by H/W */
> -       if ((gcap & AZX_GCAP_64OK) && !pci_set_dma_mask(pci, DMA_BIT_MASK(64)))
> -               pci_set_consistent_dma_mask(pci, DMA_BIT_MASK(64));
> -       else {
> +       if (!(gcap & AZX_GCAP_64OK))
> +               dma_bits = 32;
> +       if (!pci_set_dma_mask(pci, DMA_BIT_MASK(dma_bits))) {
> +               pci_set_consistent_dma_mask(pci, DMA_BIT_MASK(dma_bits));
> +       } else {
>                 pci_set_dma_mask(pci, DMA_BIT_MASK(32));
>                 pci_set_consistent_dma_mask(pci, DMA_BIT_MASK(32));
>         }
>
>
>
>

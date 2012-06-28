Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:44659 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755483Ab2F1JpW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 28 Jun 2012 05:45:22 -0400
Received: by gglu4 with SMTP id u4so1658343ggl.19
        for <linux-pci@vger.kernel.org>; Thu, 28 Jun 2012 02:45:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1340782554-9865-1-git-send-email-airlied@gmail.com>
References: <1340782554-9865-1-git-send-email-airlied@gmail.com>
Date: Thu, 28 Jun 2012 10:45:21 +0100
Message-ID: <CAPM=9tys7x5CmK-nrETA93B-9xS1uschZSgrb14-a9k9s_DNMA@mail.gmail.com>
Subject: Re: [PATCH 1/3] pci_regs: define LNKSTA2 pcie cap + bits.
From: Dave Airlie <airlied@gmail.com>
To: dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jun 27, 2012 at 8:35 AM, Dave Airlie <airlied@gmail.com> wrote:
> From: Dave Airlie <airlied@redhat.com>
>
> We need these for detecting the max link speed for drm drivers.

Hi Bjorn,

Can you ack this patch so I can carry it in the drm-next tree? we need
these regs for getting the PCIE v2/v3 supported link speeds.

Thanks,
Dave.

>
> Signed-off-by: Dave Airlie <airlied@redhat.com>
> ---
>  include/linux/pci_regs.h |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
>
> diff --git a/include/linux/pci_regs.h b/include/linux/pci_regs.h
> index 4b608f5..7f04132 100644
> --- a/include/linux/pci_regs.h
> +++ b/include/linux/pci_regs.h
> @@ -521,6 +521,11 @@
>  #define  PCI_EXP_OBFF_MSGA_EN  0x2000  /* OBFF enable with Message type A */
>  #define  PCI_EXP_OBFF_MSGB_EN  0x4000  /* OBFF enable with Message type B */
>  #define  PCI_EXP_OBFF_WAKE_EN  0x6000  /* OBFF using WAKE# signaling */
> +#define PCI_EXP_LNKCAP2                44      /* Link Capability 2 */
> +#define  PCI_EXP_LNKCAP2_SLS_2_5GB 0x01        /* Current Link Speed 2.5GT/s */
> +#define  PCI_EXP_LNKCAP2_SLS_5_0GB 0x02        /* Current Link Speed 5.0GT/s */
> +#define  PCI_EXP_LNKCAP2_SLS_8_0GB 0x04        /* Current Link Speed 8.0GT/s */
> +#define  PCI_EXP_LNKCAP2_CROSSLINK 0x100 /* Crosslink supported */
>  #define PCI_EXP_LNKCTL2                48      /* Link Control 2 */
>  #define PCI_EXP_SLTCTL2                56      /* Slot Control 2 */
>
> --
> 1.7.7.6
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> http://lists.freedesktop.org/mailman/listinfo/dri-devel

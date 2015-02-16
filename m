Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1424030062-8668-1-git-send-email-xerofoify@gmail.com>
References: <1424030062-8668-1-git-send-email-xerofoify@gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 16 Feb 2015 15:39:35 -0600
Message-ID: <CAErSpo4Zt_QhcG6DkiTY_bRWDuiSBfesJPamGQODKjFT4xjnLA@mail.gmail.com>
Subject: Re: [PATCH RESEND] x86:pci: Change sta2x11_dma_ops stucture to use
 switolb_dma_supported as it's dma_supported function in sta2x11-fixup.c
To: Nicholas Krause <xerofoify@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"x86@kernel.org" <x86@kernel.org>, --cclinux-pci@vger.kernel.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Feb 15, 2015 at 1:54 PM, Nicholas Krause <xerofoify@gmail.com> wrote:
> This changes the structure sta2x11_dma_ops stucture to use switolb_dma_supported
> as it's function for dma_supported hardware verus setting this value to NULL as
> this should be set correctly for when dma_supported function needs to be called
> for this hardware. Otherwise this will cause a bug that will crash a operation
> needing to access this function if an intended hardware operation needs to call
> it but the kernel has the function pointer for this structure set to NULL
> incorrectly.
>
> Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
> ---
>  arch/x86/pci/sta2x11-fixup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/pci/sta2x11-fixup.c b/arch/x86/pci/sta2x11-fixup.c
> index 5ceda85..d773a73 100644
> --- a/arch/x86/pci/sta2x11-fixup.c
> +++ b/arch/x86/pci/sta2x11-fixup.c
> @@ -191,7 +191,7 @@ static struct dma_map_ops sta2x11_dma_ops = {
>         .sync_sg_for_cpu = swiotlb_sync_sg_for_cpu,
>         .sync_sg_for_device = swiotlb_sync_sg_for_device,
>         .mapping_error = swiotlb_dma_mapping_error,
> -       .dma_supported = NULL, /* FIXME: we should use this instead! */
> +       .dma_supported = switolb_dma_supported,

I don't think this compiles.

>  };
>
>  /* At setup time, we use our own ops if the device is a ConneXt one */
> --
> 2.1.0
>

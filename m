Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH] efi/fb: Convert PCI bus address to resource if translated
 by the bridge
To: Sinan Kaya <okaya@codeaurora.org>, linux-pci@vger.kernel.org,
        timur@codeaurora.org, ard.biesheuvel@linaro.org
Cc: "open list:EFIFB FRAMEBUFFER DRIVER" <linux-fbdev@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-arm-msm@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        "open list:FRAMEBUFFER LAYER" <dri-devel@lists.freedesktop.org>,
        Peter Jones <pjones@redhat.com>,
        linux-arm-kernel@lists.infradead.org
References: <1526563343-28721-1-git-send-email-okaya@codeaurora.org>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <36cf3f12-bfe8-1c38-4d2c-b785fc64a3f6@arm.com>
Date: Fri, 18 May 2018 11:42:33 +0100
MIME-Version: 1.0
In-Reply-To: <1526563343-28721-1-git-send-email-okaya@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 17/05/18 14:22, Sinan Kaya wrote:
> A host bridge is allowed to remap BAR addresses using _TRA attribute in
> _CRS windows.
> 
> pci_bus 0000:00: root bus resource [mem 0x80100100000-0x8011fffffff window] (bus address [0x00100000-0x1fffffff])
> pci 0000:02:00.0: reg 0x10: [mem 0x8011e000000-0x8011effffff]
> 
> When a VGA device is behind such a host bridge and the resource is
> translated efifb driver is trying to do ioremap against bus address
> rather than the resource address and is failing to probe.
> 
> efifb driver is having difficulty locating the base address from BAR
> address when
> 
> efifb: probing for efifb
> efifb: cannot reserve video memory at 0x1e000000
> efifb: framebuffer at 0x1e000000, using 1920k, total 1875k
> efifb: mode is 800x600x32, linelength=3200, pages=1
> efifb: scrolling: redraw
> efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
> 
> Use the host bridge offset information to convert bus address to
> resource address in the fixup.
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> ---
>   drivers/video/fbdev/efifb.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
> index 46a4484..ea68d5c 100644
> --- a/drivers/video/fbdev/efifb.c
> +++ b/drivers/video/fbdev/efifb.c
> @@ -428,6 +428,8 @@ static void efifb_fixup_resources(struct pci_dev *dev)
>   {
>   	u64 base = screen_info.lfb_base;
>   	u64 size = screen_info.lfb_size;

FWIW, now that I've actually gone and looked, it appears you could 
simplify the whole function quite a bit by getting rid of these and just 
using the new local resource directly, especially since the only actual 
use of size is an open-coded resource_contains().

> +	struct pci_bus_region region;
> +	struct resource res;
>   	int i;
>   
>   	if (efifb_pci_dev || screen_info.orig_video_isVGA != VIDEO_TYPE_EFI)
> @@ -439,6 +441,14 @@ static void efifb_fixup_resources(struct pci_dev *dev)
>   	if (!base)
>   		return;
>   
> +	region.start = base;
> +	region.end = base + size - 1;
> +	res.start = 0;
> +	res.flags = IORESOURCE_MEM;
> +	pcibios_bus_to_resource(dev->bus, &res, &region);
> +	if (res.start)
> +		base = res.start;
> +
>   	for (i = 0; i <= PCI_STD_RESOURCE_END; i++) {
>   		struct resource *res = &dev->resource[i];

The inadvertent name shadowing here is a bit yuck, though, and I think 
sparse will whinge about it, so it's probably worth renaming one or the 
other.

Robin.

Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: "Jingoo Han" <jingoohan1@gmail.com>
To: "'Sinan Kaya'" <okaya@codeaurora.org>, <linux-pci@vger.kernel.org>,
 <timur@codeaurora.org>
References: <1511801886-6753-1-git-send-email-okaya@codeaurora.org>
 <1511801886-6753-25-git-send-email-okaya@codeaurora.org>
In-Reply-To: <1511801886-6753-25-git-send-email-okaya@codeaurora.org>
Subject: Re: [PATCH V3 24/29] backlight: deprecate pci_get_bus_and_slot()
Date: Mon, 27 Nov 2017 14:46:39 -0500
Message-ID: <000001d367b8$726bd7f0$574387d0$@gmail.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: 'Daniel Thompson' <daniel.thompson@linaro.org>,
 'Bartlomiej Zolnierkiewicz' <b.zolnierkie@samsung.com>,
 linux-arm-msm@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 "'open list:FRAMEBUFFER LAYER'" <linux-fbdev@vger.kernel.org>,
 'open list' <linux-kernel@vger.kernel.org>, 'Lee Jones' <lee.jones@linaro.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Monday, November 27, 2017 11:58 AM, Sinan Kaya wrote:
> 
> pci_get_bus_and_slot() is restrictive such that it assumes domain=0 as
> where a PCI device is present. This restricts the device drivers to be
> reused for other domain numbers.

I think that this will be useful. I introduced multi domains into
ARM-based PCIe driver. (e.g. domain 0, and domain 1) So, APIs to choose
domain will be used later.

> 
> Getting ready to remove pci_get_bus_and_slot() function in favor of
> pci_get_domain_bus_and_slot().
> 
> Hard-coding the domain as 0.
> 
> Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>

Acked-by: Jingoo Han <jingoohan1@gmail.com>

Best regards,
Jingoo Han

> ---
>  drivers/video/backlight/apple_bl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/video/backlight/apple_bl.c
> b/drivers/video/backlight/apple_bl.c
> index d843296..6a34ab9 100644
> --- a/drivers/video/backlight/apple_bl.c
> +++ b/drivers/video/backlight/apple_bl.c
> @@ -143,7 +143,7 @@ static int apple_bl_add(struct acpi_device *dev)
>  	struct pci_dev *host;
>  	int intensity;
> 
> -	host = pci_get_bus_and_slot(0, 0);
> +	host = pci_get_domain_bus_and_slot(0, 0, 0);
> 
>  	if (!host) {
>  		pr_err("unable to find PCI host\n");
> --
> 1.9.1



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

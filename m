Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Wed, 22 Nov 2017 08:53:45 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH 29/30] i7300_idle: deprecate pci_get_bus_and_slot()
Message-ID: <20171122075345.GC26583@kroah.com>
References: <1511328675-21981-1-git-send-email-okaya@codeaurora.org>
 <1511328675-21981-30-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
In-Reply-To: <1511328675-21981-30-git-send-email-okaya@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Kate Stewart <kstewart@linuxfoundation.org>, linux-pci@vger.kernel.org,
 timur@codeaurora.org, open list <linux-kernel@vger.kernel.org>,
 Philippe Ombredanne <pombredanne@nexb.com>, linux-arm-msm@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Nov 22, 2017 at 12:31:14AM -0500, Sinan Kaya wrote:
> pci_get_bus_and_slot() is restrictive such that it assumes domain=0 as
> where a PCI device is present. This restricts the device drivers to be
> reused for other domain numbers.
> 
> Use pci_get_domain_bus_and_slot() with a domain number of 0 where we can't
> extract the domain number. Other places, use the actual domain number from
> the device.
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> ---
>  include/linux/i7300_idle.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/i7300_idle.h b/include/linux/i7300_idle.h
> index 4dbe651..58cd9c6 100644
> --- a/include/linux/i7300_idle.h
> +++ b/include/linux/i7300_idle.h
> @@ -48,7 +48,7 @@ static inline int i7300_idle_platform_probe(struct pci_dev **fbd_dev,
>  	int i;
>  	struct pci_dev *memdev, *dmadev;
>  
> -	memdev = pci_get_bus_and_slot(MEMCTL_BUS, MEMCTL_DEVFN);
> +	memdev = pci_get_domain_bus_and_slot(0, MEMCTL_BUS, MEMCTL_DEVFN);

You have a pci_dev, why can't you use it here to get the domain?

>  	if (!memdev)
>  		return -ENODEV;
>  
> @@ -61,7 +61,7 @@ static inline int i7300_idle_platform_probe(struct pci_dev **fbd_dev,
>  	if (pci_tbl[i].vendor == 0)
>  		return -ENODEV;
>  
> -	dmadev = pci_get_bus_and_slot(IOAT_BUS, IOAT_DEVFN);
> +	dmadev = pci_get_domain_bus_and_slot(0, IOAT_BUS, IOAT_DEVFN);

Same here.

thanks,

greg k-h

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

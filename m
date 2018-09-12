Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Wed, 12 Sep 2018 12:17:07 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lubomir Rintel <lkundrak@v3.sk>
Subject: Re: [PATCH 2/5] PCI: provide pci_match_id() with CONFIG_PCI=n
Message-ID: <20180912171707.GI118330@bhelgaas-glaptop.roam.corp.google.com>
References: <20180910115935.163121-1-lkundrak@v3.sk>
 <20180910115935.163121-3-lkundrak@v3.sk>
MIME-Version: 1.0
In-Reply-To: <20180910115935.163121-3-lkundrak@v3.sk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Eric Miao <eric.y.miao@gmail.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 Haojian Zhuang <haojian.zhuang@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Daniel Mack <daniel@zonque.org>, Robert Jarzmik <robert.jarzmik@free.fr>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Please capitalize the subject as:

  PCI: Provide pci_match_id() with CONFIG_PCI=n

On Mon, Sep 10, 2018 at 01:59:32PM +0200, Lubomir Rintel wrote:
> This spares drivers from #ifdef-ing on CONFIG_PCI if the driver can be
> optionally built on machines without PCI bus.
> 
> Consistent with acpi_driver_match_device() and similar.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Thanks!

> ---
>  include/linux/pci.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index e72ca8dd6241..d2f14eb23ea4 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1702,6 +1702,10 @@ static inline int pci_irqd_intx_xlate(struct irq_domain *d,
>  				      unsigned long *out_hwirq,
>  				      unsigned int *out_type)
>  { return -EINVAL; }
> +
> +static inline const struct pci_device_id *pci_match_id(const struct pci_device_id *ids,
> +							 struct pci_dev *dev)
> +{ return NULL; }
>  #endif /* CONFIG_PCI */
>  
>  /* Include architecture-dependent settings and functions */
> -- 
> 2.17.1
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

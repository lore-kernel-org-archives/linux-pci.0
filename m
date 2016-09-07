Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH 2/2] PCI: add CRS support to error handling path
To: linux-pci@vger.kernel.org, timur@codeaurora.org, cov@codeaurora.org,
 alex.williamson@redhat.com, vikrams@codeaurora.org
References: <1472770801-30671-1-git-send-email-okaya@codeaurora.org>
 <1472770801-30671-2-git-send-email-okaya@codeaurora.org>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <1ffb90c9-f531-adcb-2067-9f675cc5ffea@codeaurora.org>
Date: Wed, 7 Sep 2016 14:56:12 -0400
MIME-Version: 1.0
In-Reply-To: <1472770801-30671-2-git-send-email-okaya@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On 9/1/2016 7:00 PM, Sinan Kaya wrote:
> The PCIE spec allows an endpoint device to extend the initialization time
> beyond 1 second by issuing Configuration Request Retry Status (CRS) for a
> vendor ID read request.
> 
> This basically means "I'm busy now, please call me back later".
> 
> There are two moving parts to CRS support from the SW perspective. One part
> is to determine if CRS is supported or not. The second part is to set the
> CRS visibility register.
> 
> As part of the probe, the Linux kernel sets the above two conditions in
> pci_enable_crs function. The kernel is also honoring the returned CRS in
> pci_bus_read_dev_vendor_id function if supported. The function will poll up
> to specified amount of time while endpoint is returning CRS response.
> 
> The PCIe spec also allows CRS to be issued during cold, warm, hot and FLR
> resets.
> 
> The hot reset is initiated by starting a secondary bus reset. This patch is
> adding vendor ID read immediately after a bus reset so that the
> initialization procedure can be extended by the amount of time endpoint
> requires.
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> ---
>  drivers/pci/pci.c | 39 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index b209378..ebd0fc6 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3829,6 +3829,44 @@ static int pci_pm_reset(struct pci_dev *dev, int probe)
>  	return 0;
>  }
>  
> +/*
> + * Mostly copy paste from pci_walk_bus with the exceptions of hard coded
> + * work and removed locks.
> + */
> +static void pci_bus_probe_crs(struct pci_bus *top)
> +{
> +	struct pci_dev *dev;
> +	struct pci_bus *bus;
> +	struct list_head *next;
> +	int retval;
> +	u32 l;
> +
> +	bus = top;
> +	next = top->devices.next;
> +	for (;;) {
> +		if (next == &bus->devices) {
> +			/* end of this bus, go up or finish */
> +			if (bus == top)
> +				break;
> +			next = bus->self->bus_list.next;
> +			bus = bus->self->bus;
> +			continue;
> +		}
> +		dev = list_entry(next, struct pci_dev, bus_list);
> +		if (dev->subordinate) {
> +			/* this is a pci-pci bridge, do its devices next */
> +			next = dev->subordinate->devices.next;
> +			bus = dev->subordinate;
> +		} else
> +			next = dev->bus_list.next;
> +
> +		retval = pci_bus_read_dev_vendor_id(dev->bus, dev->devfn, &l,
> +						    60 * 1000);
> +		if (retval)
> +			break;
> +	}
> +}
> +
>  void pci_reset_secondary_bus(struct pci_dev *dev)
>  {
>  	u16 ctrl;
> @@ -4361,6 +4399,7 @@ void pci_reset_bridge_secondary_bus(struct pci_dev *dev)
>  	pci_bus_save_and_disable(dev->bus);
>  	pcibios_reset_secondary_bus(dev);
>  	pci_bus_restore(dev->bus);
> +	pci_bus_probe_crs(dev->subordinate);
>  }
>  EXPORT_SYMBOL_GPL(pci_reset_bridge_secondary_bus);
>  
> 

Any feedback on the direction?

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

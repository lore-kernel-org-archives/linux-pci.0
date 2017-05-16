Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH 1/2] PCI: Allow PCI_DEV_FLAGS_NO_BUS_RESET to be used on
 bus device.
To: David Daney <david.daney@cavium.com>, Bjorn Helgaas
 <bhelgaas@google.com>, linux-pci@vger.kernel.org
References: <20170516001736.4001-1-david.daney@cavium.com>
 <20170516001736.4001-2-david.daney@cavium.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <5bda1ecc-55ac-199c-5a7b-c8cf154382a2@redhat.com>
Date: Tue, 16 May 2017 22:14:31 +0200
MIME-Version: 1.0
In-Reply-To: <20170516001736.4001-2-david.daney@cavium.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Jon Masters <jcm@redhat.com>, Robert Richter <robert.richter@cavium.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

On 16/05/2017 02:17, David Daney wrote:
> When checking to see if a PCI bus can safely be reset, we check to see
> if any of the children have their PCI_DEV_FLAGS_NO_BUS_RESET flag set.
> As these devices are know not to behave well after a bus reset.
nit: s/know/known
> 
> Some PCIe root port bridges also do not behave well after a bus reset,
> sometimes causing the devices behind the bridge to become unusable.
> 
> Add a check for the PCI_DEV_FLAGS_NO_BUS_RESET flag being set in the
> bridge device to allow these bridges to be flagged, and prevent their
> buses from being reset.
> 
> A follow on patch will add a quirk for this type of bridge.
> 
> Signed-off-by: David Daney <david.daney@cavium.com>

Thanks

Eric
> ---
>  drivers/pci/pci.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index b01bd5b..b64e4d1 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4318,6 +4318,10 @@ static bool pci_bus_resetable(struct pci_bus *bus)
>  {
>  	struct pci_dev *dev;
>  
> +
> +	if (bus->self && (bus->self->dev_flags & PCI_DEV_FLAGS_NO_BUS_RESET))
> +		return false;
> +
>  	list_for_each_entry(dev, &bus->devices, bus_list) {
>  		if (dev->dev_flags & PCI_DEV_FLAGS_NO_BUS_RESET ||
>  		    (dev->subordinate && !pci_bus_resetable(dev->subordinate)))
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

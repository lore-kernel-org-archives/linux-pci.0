Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Fri, 6 Oct 2017 06:37:00 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Oza Pawandeep <oza.oza@broadcom.com>
Subject: Re: [PATCH v6 3/3] PCI: iproc: Implement PCI hotplug support
Message-ID: <20171006113700.GA25517@bhelgaas-glaptop.roam.corp.google.com>
References: <1504155029-24729-1-git-send-email-oza.oza@broadcom.com>
 <1504155029-24729-4-git-send-email-oza.oza@broadcom.com>
MIME-Version: 1.0
In-Reply-To: <1504155029-24729-4-git-send-email-oza.oza@broadcom.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Scott Branden <sbranden@broadcom.com>, Oza Pawandeep <oza.pawandeep@gmail.com>,
 Jon Mason <jonmason@broadcom.com>, Ray Jui <rjui@broadcom.com>,
 linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, Andy Gospodarek <gospo@broadcom.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 31, 2017 at 10:20:29AM +0530, Oza Pawandeep wrote:
> This patch implements PCI hotplug support for iproc family chipsets.
> 
> iproc based SOC (e.g. Stingray) does not have hotplug controller
> integrated.
> Hence, standard PCI hotplug framework hooks can-not be used.
> e.g. controlled power up/down of slot.
> 
> The mechanism, for e.g. Stingray has adopted for PCI hotplug is as follows:
> PCI present lines are input to GPIOs depending on the type of
> connector (x2, x4, x8).
> 
> GPIO array needs to be present if hotplug is supported.
> HW implementation is SOC/Board specific, and also it depends on how
> add-in card is designed
> (e.g. how many present pins are implemented).
> 
> If x8 card is connected, then it might be possible that all the
> 3 present pins could go low, or at least one pin goes low.
> If x4 card is connected, then it might be possible that 2 present
> pins go low, or at least one pin goes low.
> 
> The implementation essentially takes care of following:
> > Initializing hotplug irq thread.
> > Detecting the endpoint device based on link state.
> > Handling PERST and detecting the plugged devices.
> > Ordered Hot plug-out, where User is expected
>   to write 1 to /sys/bus/pci/devices/<pci_dev>/remove
> > Handling spurious interrupt
> > Handling multiple interrupts and makes sure that card is
>   enumerated only once.

I haven't forgotten this, but I am dragging my feet a little bit.
There is a standard way for hardware to support PCIe hotplug, and it's
hard enough to get the software for that right.  I really, really
don't want to see a bunch of one-off implementations that sort of look
like standard hotplug but not really.

I have a few trivial comments below but haven't really reviewed the
whole thing.

> Signed-off-by: Oza Pawandeep <oza.oza@broadcom.com>
> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
> 
> diff --git a/drivers/pci/host/pcie-iproc-platform.c b/drivers/pci/host/pcie-iproc-platform.c
> index a5073a9..6287a43 100644
> --- a/drivers/pci/host/pcie-iproc-platform.c
> +++ b/drivers/pci/host/pcie-iproc-platform.c
> @@ -92,6 +92,9 @@ static int iproc_pcie_pltfm_probe(struct platform_device *pdev)
>  		pcie->need_ob_cfg = true;
>  	}
>  
> +	if (of_property_read_bool(np, "slot-pluggable"))
> +		pcie->enable_hotplug = true;
> +
>  	/* PHY use is optional */
>  	pcie->phy = devm_phy_get(dev, "pcie-phy");
>  	if (IS_ERR(pcie->phy)) {
> diff --git a/drivers/pci/host/pcie-iproc.c b/drivers/pci/host/pcie-iproc.c
> index 8bd5e54..2b4d830 100644
> --- a/drivers/pci/host/pcie-iproc.c
> +++ b/drivers/pci/host/pcie-iproc.c
> @@ -28,6 +28,7 @@
>  #include <linux/of_irq.h>
>  #include <linux/of_platform.h>
>  #include <linux/phy/phy.h>
> +#include <linux/gpio.h>
>  
>  #include "pcie-iproc.h"
>  
> @@ -65,6 +66,17 @@
>  #define PCIE_DL_ACTIVE_SHIFT         2
>  #define PCIE_DL_ACTIVE               BIT(PCIE_DL_ACTIVE_SHIFT)
>  
> +#define CFG_RC_LTSSM                 0x1cf8
> +#define CFG_RC_PHY_CTL               0x1804
> +#define CFG_RC_LTSSM_TIMEOUT         1000
> +#define CFG_RC_LTSSM_STATE_MASK      0xff
> +#define CFG_RC_LTSSM_STATE_L1        0x1
> +
> +#define CFG_RC_CLR_LTSSM_HIST_SHIFT  29
> +#define CFG_RC_CLR_LTSSM_HIST_MASK   BIT(CFG_RC_CLR_LTSSM_HIST_SHIFT)
> +#define CFG_RC_CLR_RECOV_HIST_SHIFT  31
> +#define CFG_RC_CLR_RECOV_HIST_MASK   BIT(CFG_RC_CLR_RECOV_HIST_SHIFT)
> +
>  #define APB_ERR_EN_SHIFT             0
>  #define APB_ERR_EN                   BIT(APB_ERR_EN_SHIFT)
>  
> @@ -1354,13 +1366,107 @@ static int iproc_pcie_rev_init(struct iproc_pcie *pcie)
>  	return 0;
>  }
>  
> +static bool iproc_pci_hp_check_ltssm(struct iproc_pcie *pcie)

*_check_*() is a terrible name for a function because it doesn't give
any hint about what a "true" return value means.

This looks sort of like dw_pcie_wait_for_link() and
advk_pcie_wait_for_link().  Please use a name more like them and
structure the code more like them.

> +{
> +	struct pci_bus *bus = pcie->root_bus;
> +	u32 val, timeout = CFG_RC_LTSSM_TIMEOUT;
> +
> +	/* Clear LTSSM history. */
> +	pci_bus_read_config_dword(pcie->root_bus, 0,
> +				  CFG_RC_PHY_CTL, &val);
> +	pci_bus_write_config_dword(bus, 0, CFG_RC_PHY_CTL,
> +				   val | CFG_RC_CLR_RECOV_HIST_MASK |
> +				   CFG_RC_CLR_LTSSM_HIST_MASK);
> +	/* write back the origional value. */

s/origional/original/

> +	pci_bus_write_config_dword(bus, 0, CFG_RC_PHY_CTL, val);
> +
> +	do {
> +		pci_bus_read_config_dword(pcie->root_bus, 0,
> +					  CFG_RC_LTSSM, &val);
> +		/* check link state to see if link moved to L1 state. */
> +		if ((val & CFG_RC_LTSSM_STATE_MASK) ==
> +		     CFG_RC_LTSSM_STATE_L1)
> +			return true;
> +		timeout--;
> +		usleep_range(500, 1000);
> +	} while (timeout);
> +
> +	return false;
> +}
> +
> +static irqreturn_t iproc_pci_hotplug_thread(int irq, void *data)
> +{
> +	struct iproc_pcie *pcie = data;

  struct device *dev = pcie->dev;

Then you don't have to repeat "pcie->dev" below.

> +	struct pci_bus *bus = pcie->root_bus, *child;
> +	bool link_status;
> +
> +	iproc_pcie_perst_ctrl(pcie, true);
> +	iproc_pcie_perst_ctrl(pcie, false);
> +
> +	link_status = iproc_pci_hp_check_ltssm(pcie);
> +
> +	if (link_status &&
> +	    !iproc_pcie_check_link(pcie) &&

iproc_pcie_check_link() already exists, but is still a poor name.

Please add some preliminary patches to rename and restructure it along
the lines of the other *_link_up() functions, e.g.,
advk_pcie_link_up(), nwl_pcie_link_up(), spear13xx_pcie_link_up(),
etc.

iproc_pcie_check_link() does a bunch of other stuff that should be
moved to other functions.  Some of it looks similar to the
*_establish_link() functions in other drivers.

> +	    !pcie->ep_is_present) {
> +		pci_rescan_bus(bus);
> +		list_for_each_entry(child, &bus->children, node)
> +			pcie_bus_configure_settings(child);
> +		pcie->ep_is_present = true;
> +		dev_info(pcie->dev,
> +			 "PCI Hotplug: <device detected and enumerated>\n");
> +	} else if (link_status && pcie->ep_is_present)
> +		/*
> +		 * ep_is_present makes sure, enumuration done only once.

s/enumuration/enumeration/

> +		 * So it can handle spurious intrrupts, and also if we

s/intrrupts/interrupts/

> +		 * get multiple interrupts for all the implemented pins,
> +		 * we handle it only once.
> +		 */
> +		dev_info(pcie->dev,
> +			 "PCI Hotplug: <device already present>\n");
> +	else {
> +		iproc_pcie_perst_ctrl(pcie, true);
> +		pcie->ep_is_present = false;
> +		dev_info(pcie->dev,
> +			 "PCI Hotplug: <device removed>\n");
> +	}
> +	return IRQ_HANDLED;
> +}
> +
> +static int iproc_pci_hp_gpio_irq_get(struct iproc_pcie *pcie)
> +{
> +	struct gpio_descs *hp_gpiod;
> +	struct device *dev = pcie->dev;
> +	int i;
> +
> +	hp_gpiod = devm_gpiod_get_array(dev, "prsnt", GPIOD_IN);
> +	if (PTR_ERR(hp_gpiod) == -EPROBE_DEFER)
> +		return -EPROBE_DEFER;
> +
> +	if (!IS_ERR(hp_gpiod) && (hp_gpiod->ndescs > 0)) {
> +		for (i = 0; i < hp_gpiod->ndescs; ++i) {
> +			gpiod_direction_input(hp_gpiod->desc[i]);
> +			if (request_threaded_irq(gpiod_to_irq
> +						 (hp_gpiod->desc[i]),
> +						 NULL, iproc_pci_hotplug_thread,
> +						 IRQF_TRIGGER_FALLING,
> +						 "PCI-hotplug", pcie))
> +				dev_err(dev,
> +					"PCI hotplug prsnt: request irq failed\n");
> +			}
> +	}
> +	pcie->ep_is_present = false;
> +
> +	return 0;
> +}
> +
>  int iproc_pcie_setup(struct iproc_pcie *pcie, struct list_head *res)
>  {
>  	struct device *dev;
>  	int ret;
>  	void *sysdata;
> -	struct pci_bus *child;
> +	struct pci_bus *bus, *child;
>  	struct pci_host_bridge *host = pci_host_bridge_from_priv(pcie);
> +	bool link_not_active;
>  
>  	dev = pcie->dev;
>  
> @@ -1386,6 +1492,12 @@ int iproc_pcie_setup(struct iproc_pcie *pcie, struct list_head *res)
>  		goto err_exit_phy;
>  	}
>  
> +	if (pcie->enable_hotplug) {
> +		ret = iproc_pci_hp_gpio_irq_get(pcie);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
>  	iproc_pcie_perst_ctrl(pcie, true);
>  	iproc_pcie_perst_ctrl(pcie, false);
>  
> @@ -1408,8 +1520,16 @@ int iproc_pcie_setup(struct iproc_pcie *pcie, struct list_head *res)
>  	sysdata = pcie;
>  #endif
>  
> -	ret = iproc_pcie_check_link(pcie);
> -	if (ret) {
> +	link_not_active = iproc_pcie_check_link(pcie);
> +	if (link_not_active && pcie->enable_hotplug) {
> +		/*
> +		 * When link is not active and PCI hotplug
> +		 * is supported, do not turn off phy, let probe
> +		 * go ahead.
> +		 */
> +		dev_err(dev, "no PCIe EP device detected\n");
> +		iproc_pcie_perst_ctrl(pcie, true);
> +	} else if (link_not_active) {
>  		dev_err(dev, "no PCIe EP device detected\n");
>  		goto err_power_off_phy;
>  	}
> @@ -1420,24 +1540,34 @@ int iproc_pcie_setup(struct iproc_pcie *pcie, struct list_head *res)
>  		if (iproc_pcie_msi_enable(pcie))
>  			dev_info(dev, "not using iProc MSI\n");
>  
> -	list_splice_init(res, &host->windows);
> -	host->busnr = 0;
> -	host->dev.parent = dev;
> -	host->ops = &iproc_pcie_ops;
> -	host->sysdata = sysdata;
> -	host->map_irq = pcie->map_irq;
> -	host->swizzle_irq = pci_common_swizzle;
> +	if (!link_not_active) {

Double negation.  If you pick a better name, e.g., "link_active", this
will read much better.  But I don't understand why you want to check
whether the link is active here anyway.  pci_scan_root_bus_bridge()
should work fine even if there's no device present below the bridge.
Won't the root port be there always, even if there's no downstream
device?

> +		list_splice_init(res, &host->windows);
> +		host->busnr = 0;
> +		host->dev.parent = dev;
> +		host->ops = &iproc_pcie_ops;
> +		host->sysdata = sysdata;
> +		host->map_irq = pcie->map_irq;
> +		host->swizzle_irq = pci_common_swizzle;
> +
> +		ret = pci_scan_root_bus_bridge(host);
> +		if (ret < 0) {
> +			dev_err(dev, "failed to scan host: %d\n", ret);
> +			goto err_power_off_phy;
> +		}
>  
> -	ret = pci_scan_root_bus_bridge(host);
> -	if (ret < 0) {
> -		dev_err(dev, "failed to scan host: %d\n", ret);
> -		goto err_power_off_phy;
> +		pci_assign_unassigned_bus_resources(host->bus);
> +		pcie->root_bus = host->bus;
> +	} else {
> +		bus = pci_create_root_bus(dev, 0,
> +					  &iproc_pcie_ops, sysdata, res);
> +		if (!bus) {
> +			dev_err(dev, "unable to create PCI root bus\n");
> +			ret = -ENOMEM;
> +			goto err_power_off_phy;
> +		}
> +		pcie->root_bus = bus;
>  	}
>  
> -	pci_assign_unassigned_bus_resources(host->bus);
> -
> -	pcie->root_bus = host->bus;
> -
>  	list_for_each_entry(child, &host->bus->children, node)
>  		pcie_bus_configure_settings(child);
>  
> diff --git a/drivers/pci/host/pcie-iproc.h b/drivers/pci/host/pcie-iproc.h
> index a6b55ce..e5d0cd4 100644
> --- a/drivers/pci/host/pcie-iproc.h
> +++ b/drivers/pci/host/pcie-iproc.h
> @@ -77,6 +77,10 @@ struct iproc_pcie_ib {
>   * @ib: inbound mapping related parameters
>   * @ib_map: outbound mapping region related parameters
>   *
> + * @enable_hotplug: indicates PCI hotplug feature is enabled
> + * @ep_is_present: when PCIe hotplug is enabled, this flag is used to
> + * indicate whether or not the endpoint device is present
> + *
>   * @need_msi_steer: indicates additional configuration of the iProc PCIe
>   * controller is required to steer MSI writes to external interrupt controller
>   * @msi: MSI data
> @@ -104,6 +108,9 @@ struct iproc_pcie {
>  	struct iproc_pcie_ib ib;
>  	const struct iproc_pcie_ib_map *ib_map;
>  
> +	bool enable_hotplug;
> +	bool ep_is_present;

Are you suggesting that only an endpoint can be hotplugged?  You can't
hotplug a switch?

>  	bool need_msi_steer;
>  	struct iproc_msi *msi;
>  };
> -- 
> 1.9.1
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

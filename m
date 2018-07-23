Return-Path: <linux-nvme-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-nvme-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Mon, 23 Jul 2018 17:45:33 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH 2/2] PCI: NVMe device specific reset quirk
Message-ID: <20180723224533.GX128988@bhelgaas-glaptop.roam.corp.google.com>
References: <20180723221533.4371.90064.stgit@gimli.home>
 <20180723222431.4371.25962.stgit@gimli.home>
MIME-Version: 1.0
In-Reply-To: <20180723222431.4371.25962.stgit@gimli.home>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 23, 2018 at 04:24:31PM -0600, Alex Williamson wrote:
> Take advantage of NVMe devices using a standard interface to quiesce
> the controller prior to reset, including device specific delays before
> and after that reset.  This resolves several NVMe device assignment
> scenarios with two different vendors.  The Intel DC P3700 controller
> has been shown to only work as a VM boot device on the initial VM
> startup, failing after reset or reboot, and also fails to initialize
> after hot-plug into a VM.  Adding a delay after FLR resolves these
> cases.  The Samsung SM961/PM961 (960 EVO) sometimes fails to return
> from FLR with the PCI config space reading back as -1.  A reproducible
> instance of this behavior is resolved by clearing the enable bit in
> the configuration register and waiting for the ready status to clear
> (disabling the NVMe controller) prior to FLR.
> 
> As all NVMe devices make use of this standard interface and the NVMe
> specification also requires PCIe FLR support, we can apply this quirk
> to all devices with matching class code.

Do you have any pointers to problem reports or bugzilla entries that
we could include here?

> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> ---
>  drivers/pci/quirks.c |  112 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 112 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index e72c8742aafa..83853562f220 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -28,6 +28,7 @@
>  #include <linux/platform_data/x86/apple.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/switchtec.h>
> +#include <linux/nvme.h>
>  #include <asm/dma.h>	/* isa_dma_bridge_buggy */
>  #include "pci.h"
>  
> @@ -3669,6 +3670,116 @@ static int reset_chelsio_generic_dev(struct pci_dev *dev, int probe)
>  #define PCI_DEVICE_ID_INTEL_IVB_M_VGA      0x0156
>  #define PCI_DEVICE_ID_INTEL_IVB_M2_VGA     0x0166
>  
> +/* NVMe controller needs delay before testing ready status */
> +#define NVME_QUIRK_CHK_RDY_DELAY	(1 << 0)
> +/* NVMe controller needs post-FLR delay */
> +#define NVME_QUIRK_POST_FLR_DELAY	(1 << 1)
> +
> +static const struct pci_device_id nvme_reset_tbl[] = {
> +	{ PCI_DEVICE(0x1bb1, 0x0100),   /* Seagate Nytro Flash Storage */
> +		.driver_data = NVME_QUIRK_CHK_RDY_DELAY, },
> +	{ PCI_DEVICE(0x1c58, 0x0003),   /* HGST adapter */
> +		.driver_data = NVME_QUIRK_CHK_RDY_DELAY, },
> +	{ PCI_DEVICE(0x1c58, 0x0023),   /* WDC SN200 adapter */
> +		.driver_data = NVME_QUIRK_CHK_RDY_DELAY, },
> +	{ PCI_DEVICE(0x1c5f, 0x0540),   /* Memblaze Pblaze4 adapter */
> +		.driver_data = NVME_QUIRK_CHK_RDY_DELAY, },
> +	{ PCI_DEVICE(0x144d, 0xa821),   /* Samsung PM1725 */

We do have PCI_VENDOR_ID_SAMSUNG if you want to use it here.  I
don't see Seagate, HGST, etc.

> +		.driver_data = NVME_QUIRK_CHK_RDY_DELAY, },
> +	{ PCI_DEVICE(0x144d, 0xa822),   /* Samsung PM1725a */
> +		.driver_data = NVME_QUIRK_CHK_RDY_DELAY, },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x0953),   /* Intel DC P3700 */
> +		.driver_data = NVME_QUIRK_POST_FLR_DELAY, },
> +	{ PCI_DEVICE_CLASS(PCI_CLASS_STORAGE_EXPRESS, 0xffffff) },
> +	{ 0 }
> +};
> +
> +/*
> + * The NVMe specification requires that controllers support PCIe FLR, but
> + * but some Samsung SM961/PM961 controllers fail to recover after FLR (-1
> + * config space) unless the device is quiesced prior to FLR.  Do this for
> + * all NVMe devices by disabling the controller before reset.  Some Intel
> + * controllers also require an additional post-FLR delay or else attempts
> + * to re-enable will timeout, do that here as well with heuristically
> + * determined delay value.  Also maintain the delay between disabling and
> + * checking ready status as used by the native NVMe driver.
> + */
> +static int reset_nvme(struct pci_dev *dev, int probe)
> +{
> +	const struct pci_device_id *id;
> +	void __iomem *bar;
> +	u16 cmd;
> +	u32 cfg;
> +
> +	id = pci_match_id(nvme_reset_tbl, dev);
> +	if (!id || !pcie_has_flr(dev) || !pci_resource_start(dev, 0))
> +		return -ENOTTY;
> +
> +	if (probe)
> +		return 0;
> +
> +	bar = pci_iomap(dev, 0, NVME_REG_CC + sizeof(cfg));
> +	if (!bar)
> +		return -ENOTTY;
> +
> +	pci_read_config_word(dev, PCI_COMMAND, &cmd);
> +	pci_write_config_word(dev, PCI_COMMAND, cmd | PCI_COMMAND_MEMORY);
> +
> +	cfg = readl(bar + NVME_REG_CC);

Apparently this is part of some NVMe spec and all controllers support
this?  Is there a public reference you could cite for the details?

> +
> +	/* Disable controller if enabled */
> +	if (cfg & NVME_CC_ENABLE) {
> +		u64 cap = readq(bar + NVME_REG_CAP);
> +		unsigned long timeout;
> +
> +		/*
> +		 * Per nvme_disable_ctrl() skip shutdown notification as it
> +		 * could complete commands to the admin queue.  We only intend
> +		 * to quiesce the device before reset.
> +		 */
> +		cfg &= ~(NVME_CC_SHN_MASK | NVME_CC_ENABLE);
> +
> +		writel(cfg, bar + NVME_REG_CC);
> +
> +		/* A heuristic value, matches NVME_QUIRK_DELAY_AMOUNT */
> +		if (id->driver_data & NVME_QUIRK_CHK_RDY_DELAY)
> +			msleep(2300);
> +
> +		/* Cap register provides max timeout in 500ms increments */
> +		timeout = ((NVME_CAP_TIMEOUT(cap) + 1) * HZ / 2) + jiffies;
> +
> +		for (;;) {
> +			u32 status = readl(bar + NVME_REG_CSTS);
> +
> +			/* Ready status becomes zero on disable complete */
> +			if (!(status & NVME_CSTS_RDY))
> +				break;
> +
> +			msleep(100);
> +
> +			if (time_after(jiffies, timeout)) {
> +				pci_warn(dev, "Timeout waiting for NVMe ready status to clear after disable\n");
> +				break;
> +			}
> +		}
> +	}
> +
> +	pci_iounmap(dev, bar);
> +
> +	/*
> +	 * We could use the optional NVM Subsystem Reset here, hardware
> +	 * supporting this is simply unavailable at the time of this code
> +	 * to validate in comparison to PCIe FLR.  NVMe spec dictates that
> +	 * NVMe devices shall implement PCIe FLR.
> +	 */
> +	pcie_flr(dev);
> +
> +	if (id->driver_data & NVME_QUIRK_POST_FLR_DELAY)
> +		msleep(250); /* Heuristic based on Intel DC P3700 */
> +
> +	return 0;
> +}
> +
>  static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
>  	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82599_SFP_VF,
>  		 reset_intel_82599_sfp_virtfn },
> @@ -3678,6 +3789,7 @@ static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
>  		reset_ivb_igd },
>  	{ PCI_VENDOR_ID_CHELSIO, PCI_ANY_ID,
>  		reset_chelsio_generic_dev },
> +	{ PCI_ANY_ID, PCI_ANY_ID, reset_nvme },
>  	{ 0 }
>  };
>  
> 
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

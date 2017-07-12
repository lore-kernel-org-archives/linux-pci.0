Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Wed, 12 Jul 2017 15:04:30 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Daniel Axtens <dja@axtens.net>
Subject: Re: [PATCH v4] PCI: Support hibmc VGA cards behind a misbehaving
 HiSilicon bridge
Message-ID: <20170712200430.GI14614@bhelgaas-glaptop.roam.corp.google.com>
References: <20170712050811.3620-1-dja@axtens.net>
MIME-Version: 1.0
In-Reply-To: <20170712050811.3620-1-dja@axtens.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-pci@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
 Xinliang Liu <z.liuxinliang@hisilicon.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Rongrong Zou <zourongrong@gmail.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Catalin, Will, linux-arm-kernel]

On Wed, Jul 12, 2017 at 03:08:11PM +1000, Daniel Axtens wrote:
> The HiSilicon D05 board has some PCI bridges (PCI ID 19e5:1610) that
> are not spec-compliant: the VGA Enable bit is hardwired to 0 and
> writes do not change it.
> 
> The HiSilicon engineers report that the bridge does not forward the
> 0xa0000-0xbffff mem range and the 0x3b0-0x3bb and 0x3c0-0x3df I/O
> ranges.
> 
> Because the VGA Enable bit is hardwired to 0, the VGA arbiter refuses
> to mark any card behind it as the boot device. This breaks Xorg
> auto-detection.
> 
> However, the hibmc VGA card (PCI ID 19e5:1711) has been tested and is
> known to work when behind these bridges. (It does not require the
> legacy resources to operate.)
> 
> Provide a quirk so that this combination of bridge and card is eligible
> to be the default VGA card. This fixes Xorg auto-detection on the D05.
> 
> Cc: Xinliang Liu <z.liuxinliang@hisilicon.com>
> Cc: Rongrong Zou <zourongrong@gmail.com>
> Signed-off-by: Daniel Axtens <dja@axtens.net>
> ---
> 
> v3: fix commit message
> v4: fix comment (forgot to git add/git commit, sorry for the noise)
> 
> ---
>  drivers/pci/quirks.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 16e6cd86ad71..b42324cba29e 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -25,6 +25,7 @@
>  #include <linux/sched.h>
>  #include <linux/ktime.h>
>  #include <linux/mm.h>
> +#include <linux/vgaarb.h>
>  #include <asm/dma.h>	/* isa_dma_bridge_buggy */
>  #include "pci.h"
>  
> @@ -4664,3 +4665,52 @@ static void quirk_intel_no_flr(struct pci_dev *dev)
>  }
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1502, quirk_intel_no_flr);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1503, quirk_intel_no_flr);
> +
> +/*
> + * The HiSilicon D05 board has some PCI bridges (PCI ID 19e5:1610)
> + * that are not spec-compliant: the VGA Enable bit is hardwired to 0
> + * and writes do not change it. The bridge does not forward legacy
> + * memory or I/O resources.
> + *
> + * Because the VGA Enable bit is hardwired to 0, the VGA arbiter
> + * refuses to mark any card behind it as the boot device. However, the
> + * hibmc VGA card (PCI ID 19e5:1711) has been tested and is known to
> + * work when behind these bridges.
> + *
> + * If we have this bridge, this card, and no default card already,
> + * mark the card as default.
> + */
> +static void hibmc_fixup_vgaarb(struct pci_dev *pdev)
> +{
> +	struct pci_dev *bridge;
> +	struct pci_bus *bus;
> +	u16 config;
> +
> +	bus = pdev->bus;
> +	bridge = bus->self;
> +	if (!bridge)
> +		return;
> +
> +	if (!pci_is_bridge(bridge))
> +		return;
> +
> +	if (bridge->vendor != PCI_VENDOR_ID_HUAWEI ||
> +	    bridge->device != 0x1610)
> +		return;
> +
> +	pci_read_config_word(bridge, PCI_BRIDGE_CONTROL,
> +			     &config);
> +	if (config & PCI_BRIDGE_CTL_VGA) {
> +		/*
> +		 * Weirdly, this bridge *is* spec compliant, so bail
> +		 * and let vgaarb do its job
> +		 */
> +		return;
> +	}
> +
> +	if (vga_default_device())
> +		return;
> +
> +	vga_set_default_device(pdev);
> +}
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI, 0x1711, hibmc_fixup_vgaarb);

Is this quirk useful on any arch other than arm64?  Per
drivers/pci/dwc/Kconfig, CONFIG_PCI_HISI depends on CONFIG_ARM64.

Would it make sense to put this quirk in arch/arm64/kernel/pci.c?

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

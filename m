Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.135]:58490 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750915AbcALW2X (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 12 Jan 2016 17:28:23 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Cc: bhelgaas@google.com, michals@xilinx.com, lorenzo.pieralisi@arm.com,
	paul.burton@imgtec.com, yinghai@kernel.org, wangyijing@huawei.com,
	robh@kernel.org, russell.joyce@york.ac.uk, sorenb@xilinx.com,
	jiang.liu@linux.intel.com, pawel.moll@arm.com,
	mark.rutland@arm.com, ijc+devicetree@hellion.org.uk,
	galak@codeaurora.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Bharat Kumar Gogada <bharatku@xilinx.com>,
	Ravi Kiran Gummaluri <rgummal@xilinx.com>
Subject: Re: [PATCH V2 3/5] PCI: xilinx: Modifying AXI PCIe Host Bridge driver to  work on both  Zynq and Microblaze
Date: Tue, 12 Jan 2016 23:27:25 +0100
Message-ID: <4734542.KZZp0TeeeM@wuerfel>
In-Reply-To: <1452620173-4905-4-git-send-email-bharatku@xilinx.com>
References: <1452620173-4905-1-git-send-email-bharatku@xilinx.com> <1452620173-4905-4-git-send-email-bharatku@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday 12 January 2016 23:06:11 Bharat Kumar Gogada wrote:
> Modifying Xilinx AXI PCIe Host Bridge Soft IP driver to work on both
> Zynq and Microblaze Architectures.
> With these modifications drivers/pci/host/pcie-xilinx.c, will
> work on both Zynq and Microblaze Architectures.
> 
> Signed-off-by: Bharat Kumar Gogada <bharatku@xilinx.com>
> Signed-off-by: Ravi Kiran Gummaluri <rgummal@xilinx.com>

I think this patch should be split into three, as you are doing three
unrelated things here.

> ---
> Changes:
> Changed Total number of MSI IRQ count logic according to both architectures.
> Updated MSI assigning functions accordingly to new count.
> Modified irq_domain_add_linear with new MSI IRQ count.
> Added #ifdef to pci_fixup_irqs which is ARM specific API.
> ---
>  drivers/pci/host/pcie-xilinx.c | 22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/host/pcie-xilinx.c b/drivers/pci/host/pcie-xilinx.c
> index 3e3757f..1981948 100644
> --- a/drivers/pci/host/pcie-xilinx.c
> +++ b/drivers/pci/host/pcie-xilinx.c
> @@ -92,7 +92,12 @@
>  #define ECAM_DEV_NUM_SHIFT		12
>  
>  /* Number of MSI IRQs */
> -#define XILINX_NUM_MSI_IRQS		128
> +#define XILINX_NUM_MSI_IRQS	128
> +#ifdef CONFIG_ARM
> +#define TOT_NR_IRQS		XILINX_NUM_MSI_IRQS
> +#else
> +#define TOT_NR_IRQS		(NR_IRQS + XILINX_NUM_MSI_IRQS)
> +#endif

Something looks wrong here in the microblaze variant. What does NR_IRQS
have to do with it?

> @@ -238,15 +243,20 @@ static void xilinx_pcie_destroy_msi(unsigned int irq)
>   */
>  static int xilinx_pcie_assign_msi(struct xilinx_pcie_port *port)
>  {
> +	int irq;
>  	int pos;
>  
>  	pos = find_first_zero_bit(msi_irq_in_use, XILINX_NUM_MSI_IRQS);
> -	if (pos < XILINX_NUM_MSI_IRQS)
> +	irq = pos;
> +#ifdef CONFIG_MICROBLAZE
> +	irq = XILINX_NUM_MSI_IRQS + pos;
> +#endif


	if (IS_ENABLED(CONFIG_MICROBLAZE))
		irq = XILINX_NUM_MSI_IRQS + pos;

> @@ -705,7 +715,9 @@ static int xilinx_pcie_probe(struct platform_device *pdev)
>  #endif
>  	pci_scan_child_bus(bus);
>  	pci_assign_unassigned_bus_resources(bus);
> +#ifdef CONFIG_ARM
>  	pci_fixup_irqs(pci_common_swizzle, of_irq_parse_and_map_pci);
> +#endif
>  	pci_bus_add_devices(bus);
>  	platform_set_drvdata(pdev, port);

Here it looks like microblaze gets it right. I'm not sure why we still
need the pci_fixup_irqs() on ARM, but my feeling is that this should be
fixed in common code.

	Arnd

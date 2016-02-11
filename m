Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-sn1nam02on0051.outbound.protection.outlook.com ([104.47.36.51]:19783
	"EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750757AbcBKGUr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 11 Feb 2016 01:20:47 -0500
From: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To: Paul Burton <paul.burton@imgtec.com>,
	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
CC: Michal Simek <michals@xilinx.com>,
	Ravikiran Gummaluri <rgummal@xilinx.com>,
	Soren Brinkmann <sorenb@xilinx.com>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	Grygorii Strashko <grygorii.strashko@ti.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Russell Joyce <russell.joyce@york.ac.uk>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Thomas Gleixner" <tglx@linutronix.de>,
	Jingoo Han <jingoohan1@gmail.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v3 4/6] PCI: xilinx: Clear interrupt FIFO during probe
Date: Thu, 11 Feb 2016 06:20:42 +0000
Message-ID: <8520D5D51A55D047800579B09414719825881B1B@XAP-PVEXMBX01.xlnx.xilinx.com>
References: <1454602213-967-1-git-send-email-paul.burton@imgtec.com>
 <1454602213-967-5-git-send-email-paul.burton@imgtec.com>
In-Reply-To: <1454602213-967-5-git-send-email-paul.burton@imgtec.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

 > xilinx_pcie_init_port clears the pending interrupts in the interrupt decode
> register, but does not clear the interrupt FIFO. This would lead to spurious
> interrupts if any were present in the FIFO at probe time.
> Clear the interrupt FIFO prior to the interrupt decode register in order to
> start with a clean slate as expected.
> 
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> Fixes: 8961def56845 ("PCI: xilinx: Add Xilinx AXI PCIe Host Bridge IP driver")
> 
> ---
> 
> Changes in v3:
> - Split out from Boston patchset.
> 
> Changes in v2:
> - Add Fixes tag.
> 
>  drivers/pci/host/pcie-xilinx.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/pci/host/pcie-xilinx.c b/drivers/pci/host/pcie-xilinx.c index
> 1eb74a2..6c5a503 100644
> --- a/drivers/pci/host/pcie-xilinx.c
> +++ b/drivers/pci/host/pcie-xilinx.c
> @@ -568,6 +568,8 @@ static int xilinx_pcie_init_irq_domain(struct
> xilinx_pcie_port *port)
>   */
>  static void xilinx_pcie_init_port(struct xilinx_pcie_port *port)  {
> +	u32 val;
> +
>  	if (xilinx_pcie_link_is_up(port))
>  		dev_info(port->dev, "PCIe Link is UP\n");
>  	else
> @@ -577,6 +579,17 @@ static void xilinx_pcie_init_port(struct
> xilinx_pcie_port *port)
>  	pcie_write(port, ~XILINX_PCIE_IDR_ALL_MASK,
>  		   XILINX_PCIE_REG_IMR);
> 
> +	/* Clear interrupt FIFO */
> +	while (1) {
> +		val = pcie_read(port, XILINX_PCIE_REG_RPIFR1);
> +
> +		if (!(val & XILINX_PCIE_RPIFR1_INTR_VALID))
> +			break;
> +
> +		pcie_write(port, XILINX_PCIE_RPIFR1_ALL_MASK,
> +			   XILINX_PCIE_REG_RPIFR1);
> +	}
> +
Hi Paul,

This case will create problem with error case, suppose if we have continuous correctable errors on link this will always be while loop.

Bharat

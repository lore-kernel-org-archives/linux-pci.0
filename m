Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-by2nam01on0040.outbound.protection.outlook.com ([104.47.34.40]:26986
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751262AbdFEFrV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 5 Jun 2017 01:47:21 -0400
From: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To: Paul Burton <paul.burton@imgtec.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Ravikiran Gummaluri <rgummal@xilinx.com>
Subject: RE: [PATCH v4 1/4] PCI: xilinx: Fix INTX irq dispatch
Date: Mon, 5 Jun 2017 05:47:13 +0000
Message-ID: <8520D5D51A55D047800579B0941471982646ABC2@XAP-PVEXMBX02.xlnx.xilinx.com>
References: <20170602185420.22281-1-paul.burton@imgtec.com>
 <20170602185420.22281-2-paul.burton@imgtec.com>
In-Reply-To: <20170602185420.22281-2-paul.burton@imgtec.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> The IRQ domain for INTX interrupts has 4 entries, numbered 0 to 3. This m=
atches
> what the hardware reports from the interrupt FIFO exactly, but
> xilinx_pcie_intr_handler was adding 1 to that value to convert to the ran=
ge 1 to
> 4. Stop adding 1, such that all of INTA through to INTD fall within the r=
ange of
> the IRQ domain.
>=20
Paul, this change is not required.
hwirq for legacy domain is being assigned by kernel PCIe subsystem based on=
 PCI_INTERRUPT_PIN, which as per
protocol starts from 1 and not zero, due to this 1 is being added.

Regards,
Bharat

> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> Fixes: 8961def56845 ("PCI: xilinx: Add Xilinx AXI PCIe Host Bridge IP dri=
ver")
> Cc: Bharat Kumar Gogada <bharatku@xilinx.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Michal Simek <michal.simek@xilinx.com>
> Cc: Ravikiran Gummaluri <rgummal@xilinx.com>
> Cc: linux-pci@vger.kernel.org
>=20
> ---
>=20
> Changes in v4: None
>=20
> Changes in v3:
> - Split out from Boston patchset.
>=20
> Changes in v2:
> - Add Fixes tag.
>=20
>  drivers/pci/host/pcie-xilinx.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/pci/host/pcie-xilinx.c b/drivers/pci/host/pcie-xilin=
x.c index
> 2fe2df51f9f8..6be2e5ee44f1 100644
> --- a/drivers/pci/host/pcie-xilinx.c
> +++ b/drivers/pci/host/pcie-xilinx.c
> @@ -440,8 +440,8 @@ static irqreturn_t xilinx_pcie_intr_handler(int irq, =
void
> *data)
>  				   XILINX_PCIE_REG_RPIFR1);
>=20
>  			/* Handle INTx Interrupt */
> -			val =3D ((val & XILINX_PCIE_RPIFR1_INTR_MASK) >>
> -				XILINX_PCIE_RPIFR1_INTR_SHIFT) + 1;
> +			val =3D (val & XILINX_PCIE_RPIFR1_INTR_MASK) >>
> +				XILINX_PCIE_RPIFR1_INTR_SHIFT;
>  			generic_handle_irq(irq_find_mapping(port-
> >leg_domain,
>  							    val));
>  		}
> --
> 2.13.0

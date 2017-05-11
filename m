Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Richard Zhu <hongxing.zhu@nxp.com>
To: Lucas Stach <l.stach@pengutronix.de>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>
Subject: RE: [PATCH] PCI: imx6: fix downstream bus scanning
Date: Thu, 11 May 2017 02:00:43 +0000
Message-ID: <AM5PR0402MB28506F261345166D313D50F88CED0@AM5PR0402MB2850.eurprd04.prod.outlook.com>
References: <20170510175752.6519-1-l.stach@pengutronix.de>
In-Reply-To: <20170510175752.6519-1-l.stach@pengutronix.de>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
 "tharvey@gateworks.com" <tharvey@gateworks.com>,
 "patchwork-lst@pengutronix.de" <patchwork-lst@pengutronix.de>,
 Peter Senna Tschudin <peter.senna@collabora.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "festevam@gmail.com" <festevam@gmail.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>


> -----Original Message-----
> From: Lucas Stach [mailto:l.stach@pengutronix.de]
> Sent: Thursday, May 11, 2017 1:58 AM
> To: linux-pci@vger.kernel.org
> Cc: Peter Senna Tschudin <peter.senna@collabora.com>; Richard Zhu
> <hongxing.zhu@nxp.com>; festevam@gmail.com; bhelgaas@google.com;
> tharvey@gateworks.com; lorenzo.pieralisi@arm.com; linux-arm-
> kernel@lists.infradead.org; kernel@pengutronix.de; patchwork-
> lst@pengutronix.de
> Subject: [PATCH] PCI: imx6: fix downstream bus scanning
> 
> The change in Linux 4.12 to make PCI configuartion requests non-posted
> means that we are now getting a synchronous abort when the CFG space
> read to probe for downstream devices times out.
> 
> Synchronous aborts need to be handled differently from the async aborts we
> were getting before, in particular the PC needs to be advanced when
> resolving the abort. This is mostly a copy of what other PCI drivers do on ARM
> to handle those aborts.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>

Thanks lot for your great help at first.
Only one little spell comment, "configuartion" in the commit message should be "configuration",
 the others are okay.
Acked-by: Richard Zhu <hongxing.zhu@nxp.com>

> ---
> This is a fix that needs to go in for 4.12, but I would hope to get some
> thorough testing before.
> ---
>  drivers/pci/dwc/pci-imx6.c | 33 ++++++++++++++++++++++++++++++---
>  1 file changed, 30 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/dwc/pci-imx6.c b/drivers/pci/dwc/pci-imx6.c index
> a98cba55c7f0..19a289b8cc94 100644
> --- a/drivers/pci/dwc/pci-imx6.c
> +++ b/drivers/pci/dwc/pci-imx6.c
> @@ -252,7 +252,34 @@ static void imx6_pcie_reset_phy(struct imx6_pcie
> *imx6_pcie)  static int imx6q_pcie_abort_handler(unsigned long addr,
>  		unsigned int fsr, struct pt_regs *regs)  {
> -	return 0;
> +	unsigned long pc = instruction_pointer(regs);
> +	unsigned long instr = *(unsigned long *)pc;
> +	int reg = (instr >> 12) & 15;
> +
> +	/*
> +	 * If the instruction being executed was a read,
> +	 * make it look like it read all-ones.
> +	 */
> +	if ((instr & 0x0c100000) == 0x04100000) {
> +		unsigned long val;
> +
> +		if (instr & 0x00400000)
> +			val = 255;
> +		else
> +			val = -1;
> +
> +		regs->uregs[reg] = val;
> +		regs->ARM_pc += 4;
> +		return 0;
> +	}
> +
> +	if ((instr & 0x0e100090) == 0x00100090) {
> +		regs->uregs[reg] = -1;
> +		regs->ARM_pc += 4;
> +		return 0;
> +	}
> +
> +	return 1;
>  }
> 
>  static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie) @@ -
> 819,8 +846,8 @@ static int __init imx6_pcie_init(void)
>  	 * we can install the handler here without risking it
>  	 * accessing some uninitialized driver state.
>  	 */
> -	hook_fault_code(16 + 6, imx6q_pcie_abort_handler, SIGBUS, 0,
> -			"imprecise external abort");
> +	hook_fault_code(8, imx6q_pcie_abort_handler, SIGBUS, 0,
> +			"external abort on non-linefetch");
> 
>  	return platform_driver_register(&imx6_pcie_driver);
>  }
> --
> 2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

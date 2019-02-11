Return-Path: <SRS0=XN0A=QS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C698DC169C4
	for <linux-pci@archiver.kernel.org>; Mon, 11 Feb 2019 16:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E2F52229F
	for <linux-pci@archiver.kernel.org>; Mon, 11 Feb 2019 16:58:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbfBKQ6A (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 11 Feb 2019 11:58:00 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:56319 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbfBKQ6A (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Feb 2019 11:58:00 -0500
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1gtEu1-0001Y3-N8; Mon, 11 Feb 2019 17:57:53 +0100
Message-ID: <1549904273.2546.16.camel@pengutronix.de>
Subject: Re: [PATCH v2 2/2] pci: imx6: support kernels built in Thumb-2 mode
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Stefan Agner <stefan@agner.ch>, hongxing.zhu@nxp.com
Cc:     robin.murphy@arm.com, tpiepho@impinj.com, linux@armlinux.org.uk,
        leonard.crestez@nxp.com, andrew.smirnov@gmail.com,
        festevam@gmail.com, lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 11 Feb 2019 17:57:53 +0100
In-Reply-To: <20181204132733.14422-2-stefan@agner.ch>
References: <20181204132733.14422-1-stefan@agner.ch>
         <20181204132733.14422-2-stefan@agner.ch>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am Dienstag, den 04.12.2018, 14:27 +0100 schrieb Stefan Agner:
> Add a fault handler which handles immediate reads in Thumb-2
> mode. Install the appropriate handler depending on which mode
> the kernel has been built. This avoids an "Unhandled fault:
> external abort on non-linefetch (0x1008) at 0xf0a80000"
> during boot on a device with a PCIe switch connected.
> 
> Link: https://lore.kernel.org/linux-pci/20181126161645.8177-1-stefan@agner.ch/
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Acked-by: Lucas Stach <l.stach@pengutronix.de>

> ---
> Changes since v1:
> - Added Thumb-2 32-bit instruction support (tested by inserting .w
>   instructions in arch/arm/include/asm/io.h)
> - Avoid dereferencing if fault happened in user mode
> 
>  drivers/pci/controller/dwc/pci-imx6.c | 59 ++++++++++++++++++++++++++-
>  1 file changed, 58 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 54a29e441303..a9bbbf176c4a 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -29,6 +29,7 @@
>  #include <linux/reset.h>
>  #include <linux/pm_domain.h>
>  #include <linux/pm_runtime.h>
> +#include <asm/opcodes.h>
>  
>  #include "pcie-designware.h"
>  
> @@ -305,6 +306,59 @@ static int imx6q_pcie_abort_handler(unsigned long addr,
>  	return 1;
>  }
>  
> +static int imx6q_pcie_abort_handler_thumb2(unsigned long addr,
> +		unsigned int fsr, struct pt_regs *regs)
> +{
> +	unsigned long pc = instruction_pointer(regs);
> +	unsigned long instr;
> +
> +	if (user_mode(regs))
> +		return 1;
> +
> +	instr = __mem_to_opcode_thumb32(*(unsigned long *)pc);
> +
> +	if (__opcode_is_thumb32(instr)) {
> +		/* Load word/byte and halfword immediate offset */
> +		if ((instr & 0xff100000UL) == 0xf8100000UL) {
> +			int reg = (instr >> 12) & 0xf;
> +			unsigned long val;
> +
> +			if ((instr & 0x00700000UL) == 0x00100000UL)
> +				val = 0xff;
> +			else if ((instr & 0x00700000UL) == 0x00300000UL)
> +				val = 0xffff;
> +			else
> +				val = 0xffffffffUL;
> +
> +			regs->uregs[reg] = val;
> +			regs->ARM_pc += 4;
> +			return 0;
> +		}
> +	} else {
> +		instr = __mem_to_opcode_thumb16(*(unsigned long *)pc);
> +
> +		/* Load word/byte and halfword immediate offset */
> +		if (((instr & 0xe800) == 0x6800) ||
> +		    ((instr & 0xf800) == 0x8800)) {
> +			int reg = instr & 0x7;
> +			unsigned long val;
> +
> +			if (instr & 0x1000)
> +				val = 0xff;
> +			else if (instr & 0x8000)
> +				val = 0xffff;
> +			else
> +				val = 0xffffffffUL;
> +
> +			regs->uregs[reg] = val;
> +			regs->ARM_pc += 2;
> +			return 0;
> +		}
> +	}
> +
> +	return 1;
> +}
> +
>  static int imx6_pcie_attach_pd(struct device *dev)
>  {
>  	struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);
> @@ -1075,6 +1129,8 @@ static struct platform_driver imx6_pcie_driver = {
>  
>  static int __init imx6_pcie_init(void)
>  {
> +	bool thumb2 = IS_ENABLED(CONFIG_THUMB2_KERNEL);
> +
>  	/*
>  	 * Since probe() can be deferred we need to make sure that
>  	 * hook_fault_code is not called after __init memory is freed
> @@ -1082,7 +1138,8 @@ static int __init imx6_pcie_init(void)
>  	 * we can install the handler here without risking it
>  	 * accessing some uninitialized driver state.
>  	 */
> -	hook_fault_code(8, imx6q_pcie_abort_handler, SIGBUS, 0,
> +	hook_fault_code(8, thumb2 ? imx6q_pcie_abort_handler_thumb2 :
> +			imx6q_pcie_abort_handler, SIGBUS, 0,
>  			"external abort on non-linefetch");
>  
>  	return platform_driver_register(&imx6_pcie_driver);

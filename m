Return-Path: <SRS0=2mbU=OH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 136A8C43441
	for <linux-pci@archiver.kernel.org>; Wed, 28 Nov 2018 16:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8AA02081C
	for <linux-pci@archiver.kernel.org>; Wed, 28 Nov 2018 16:16:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8AA02081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728928AbeK2DSp (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 28 Nov 2018 22:18:45 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:44772 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727979AbeK2DSp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Nov 2018 22:18:45 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 442ED3644;
        Wed, 28 Nov 2018 08:16:34 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 51EEB3F5AF;
        Wed, 28 Nov 2018 08:16:32 -0800 (PST)
Subject: Re: [PATCH] pci: imx6: support kernels built in Thumb-2 mode
To:     Stefan Agner <stefan@agner.ch>, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de
Cc:     lorenzo.pieralisi@arm.com, andrew.smirnov@gmail.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com, leonard.crestez@nxp.com, festevam@gmail.com,
        linux-arm-kernel@lists.infradead.org, tpiepho@impinj.com
References: <20181128132554.28139-1-stefan@agner.ch>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <ff476784-b79e-18bf-5870-4365c8377deb@arm.com>
Date:   Wed, 28 Nov 2018 16:16:30 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181128132554.28139-1-stefan@agner.ch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Stefan,

On 28/11/2018 13:25, Stefan Agner wrote:
> Add a fault handler which handles reads in Thumb-2 mode. Install
> the appropriate handler depending on which mode the kernel has
> been built. This avoids an "Unhandled fault: external abort on
> non-linefetch (0x1008) at 0xf0a80000" during boot on a device
> with a PCIe switch connected.
> 
> Link: https://lore.kernel.org/linux-pci/20181126161645.8177-1-stefan@agner.ch/
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
> FWIW, I found this manual helpful to write the code below:
> http://hermes.wings.cs.wisc.edu/files/Thumb-2SupplementReferenceManual.pdf#page=43&zoom=100,0,66

This one's rather less ancient and even more authoritative ;)

https://static.docs.arm.com/ddi0406/cd/DDI0406C_d_armv7ar_arm.pdf

(ARMv7 had a few new encodings over and above ARMv6T2, although in 
fairness I don't think any should be relevant to this specific case)

> --
> Stefan
> 
>   drivers/pci/controller/dwc/pci-imx6.c | 37 ++++++++++++++++++++++++++-
>   1 file changed, 36 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 69f86234f7c0..683deb74d69f 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -29,6 +29,7 @@
>   #include <linux/reset.h>
>   #include <linux/pm_domain.h>
>   #include <linux/pm_runtime.h>
> +#include <asm/opcodes.h>
>   
>   #include "pcie-designware.h"
>   
> @@ -299,6 +300,37 @@ static int imx6q_pcie_abort_handler(unsigned long addr,
>   	return 1;
>   }
>   
> +static int imx6q_pcie_abort_handler_thumb2(unsigned long addr,
> +		unsigned int fsr, struct pt_regs *regs)
> +{
> +	unsigned long pc = instruction_pointer(regs);
> +	unsigned long instr = *(unsigned long *)pc;
> +	unsigned long thumb2_instr = __mem_to_opcode_thumb16(instr);
> +	int reg = thumb2_instr & 7;
> +
> +	if (!__opcode_is_thumb16(instr & 0x0000ffffUL))
> +		return 1;

There are plenty of 32-bit Thumb encodings of various LDR/STR variants, 
and I doubt we can guarantee that the offset, target register, and/or 
addressing mode for a config space access will *always* suit the 
(relatively limited) 16-bit ones.

> +
> +	/* Load word/byte and halfword immediate offset */
> +	if (((thumb2_instr & 0xe800) == 0x6800) ||
> +	    ((thumb2_instr & 0xf800) == 0x8800)) {
> +		unsigned long val;
> +
> +		if (thumb2_instr & 0x1000)
> +			val = 0xff;
> +		else if (thumb2_instr & 0x8000)
> +			val = 0xffff;
> +		else
> +			val = 0xffffffffUL;
> +
> +		regs->uregs[reg] = val;
> +		regs->ARM_pc += 2;
> +		return 0;
> +	}

What about stores? The existing implementation handles them, so either 
that's dead code which could perhaps be cleaned up, or they need to be 
handled here too.

> +
> +	return 1;
> +}
> +
>   static int imx6_pcie_attach_pd(struct device *dev)
>   {
>   	struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);
> @@ -1069,6 +1101,8 @@ static struct platform_driver imx6_pcie_driver = {
>   
>   static int __init imx6_pcie_init(void)
>   {
> +	bool thumb2 = IS_ENABLED(CONFIG_THUMB2_KERNEL);

Can these aborts definitely *only* be triggered by kernel accesses, and 
never, say, via an mmap() of anything exposed to userspace?

Robin.

> +
>   	/*
>   	 * Since probe() can be deferred we need to make sure that
>   	 * hook_fault_code is not called after __init memory is freed
> @@ -1076,7 +1110,8 @@ static int __init imx6_pcie_init(void)
>   	 * we can install the handler here without risking it
>   	 * accessing some uninitialized driver state.
>   	 */
> -	hook_fault_code(8, imx6q_pcie_abort_handler, SIGBUS, 0,
> +	hook_fault_code(8, thumb2 ? imx6q_pcie_abort_handler_thumb2 :
> +			imx6q_pcie_abort_handler, SIGBUS, 0,
>   			"external abort on non-linefetch");
>   
>   	return platform_driver_register(&imx6_pcie_driver);
> 

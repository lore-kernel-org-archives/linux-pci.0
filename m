Return-Path: <SRS0=2mbU=OH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72BF9C43441
	for <linux-pci@archiver.kernel.org>; Wed, 28 Nov 2018 18:02:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3290C20665
	for <linux-pci@archiver.kernel.org>; Wed, 28 Nov 2018 18:02:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="fV6AsF6m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3290C20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725779AbeK2FEd (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 29 Nov 2018 00:04:33 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:52708 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725760AbeK2FEd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Nov 2018 00:04:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=umgPfq7NjN8HCsrLBhRW/yyv6LLIAk6oEAnV+t2vfvg=; b=fV6AsF6m4wtEc2nvmEDKmlazQ
        HpIwOe+bJII/YtTegdgJ8lyPuv+L/EXXrEsWjg8T4QKlaEA93G9BPUMoBKKCcVh8YFIu5dlAWCxfl
        0rLUEw32w5KXrPotGGgHRPJfQJt6UkEg7V+kSTi8DVecf9zdhz8A7sYAe78wGVJF0LxGQ=;
Received: from n2100.armlinux.org.uk ([fd8f:7570:feb6:1:214:fdff:fe10:4f86]:51424)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gS49p-0006Db-C4; Wed, 28 Nov 2018 18:01:53 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1gS49l-0005uu-5y; Wed, 28 Nov 2018 18:01:49 +0000
Date:   Wed, 28 Nov 2018 18:01:47 +0000
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Stefan Agner <stefan@agner.ch>
Cc:     hongxing.zhu@nxp.com, l.stach@pengutronix.de,
        lorenzo.pieralisi@arm.com, andrew.smirnov@gmail.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com, leonard.crestez@nxp.com, festevam@gmail.com,
        linux-arm-kernel@lists.infradead.org, tpiepho@impinj.com
Subject: Re: [PATCH] pci: imx6: support kernels built in Thumb-2 mode
Message-ID: <20181128180147.GL30658@n2100.armlinux.org.uk>
References: <20181128132554.28139-1-stefan@agner.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181128132554.28139-1-stefan@agner.ch>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 28, 2018 at 02:25:54PM +0100, Stefan Agner wrote:
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
> 
> --
> Stefan
> 
>  drivers/pci/controller/dwc/pci-imx6.c | 37 ++++++++++++++++++++++++++-
>  1 file changed, 36 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 69f86234f7c0..683deb74d69f 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -29,6 +29,7 @@
>  #include <linux/reset.h>
>  #include <linux/pm_domain.h>
>  #include <linux/pm_runtime.h>
> +#include <asm/opcodes.h>
>  
>  #include "pcie-designware.h"
>  
> @@ -299,6 +300,37 @@ static int imx6q_pcie_abort_handler(unsigned long addr,
>  	return 1;
>  }
>  
> +static int imx6q_pcie_abort_handler_thumb2(unsigned long addr,
> +		unsigned int fsr, struct pt_regs *regs)
> +{
> +	unsigned long pc = instruction_pointer(regs);
> +	unsigned long instr = *(unsigned long *)pc;

So what happens if userspace mmap()s the PCIe space (eg, via
/dev/mem), and then accesses it, triggering this fault?  You'll
be attempting to read from userspace here, which will oops the
kernel.  The kernel is not allowed to access userspace by
simply dereferencing a pointer.

> +	unsigned long thumb2_instr = __mem_to_opcode_thumb16(instr);
> +	int reg = thumb2_instr & 7;
> +
> +	if (!__opcode_is_thumb16(instr & 0x0000ffffUL))
> +		return 1;
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
> +
> +	return 1;
> +}
> +
>  static int imx6_pcie_attach_pd(struct device *dev)
>  {
>  	struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);
> @@ -1069,6 +1101,8 @@ static struct platform_driver imx6_pcie_driver = {
>  
>  static int __init imx6_pcie_init(void)
>  {
> +	bool thumb2 = IS_ENABLED(CONFIG_THUMB2_KERNEL);
> +
>  	/*
>  	 * Since probe() can be deferred we need to make sure that
>  	 * hook_fault_code is not called after __init memory is freed
> @@ -1076,7 +1110,8 @@ static int __init imx6_pcie_init(void)
>  	 * we can install the handler here without risking it
>  	 * accessing some uninitialized driver state.
>  	 */
> -	hook_fault_code(8, imx6q_pcie_abort_handler, SIGBUS, 0,
> +	hook_fault_code(8, thumb2 ? imx6q_pcie_abort_handler_thumb2 :
> +			imx6q_pcie_abort_handler, SIGBUS, 0,
>  			"external abort on non-linefetch");
>  
>  	return platform_driver_register(&imx6_pcie_driver);
> -- 
> 2.19.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

Return-Path: <SRS0=vzDi=QP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D541C282CC
	for <linux-pci@archiver.kernel.org>; Fri,  8 Feb 2019 12:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 474A4217D8
	for <linux-pci@archiver.kernel.org>; Fri,  8 Feb 2019 12:13:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbfBHMNr (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 8 Feb 2019 07:13:47 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:49932 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726230AbfBHMNr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 8 Feb 2019 07:13:47 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0B1C21596;
        Fri,  8 Feb 2019 04:13:47 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C831D3F719;
        Fri,  8 Feb 2019 04:13:44 -0800 (PST)
Date:   Fri, 8 Feb 2019 12:13:41 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Stefan Agner <stefan@agner.ch>
Cc:     hongxing.zhu@nxp.com, l.stach@pengutronix.de, robin.murphy@arm.com,
        tpiepho@impinj.com, linux@armlinux.org.uk, leonard.crestez@nxp.com,
        andrew.smirnov@gmail.com, festevam@gmail.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] pci: imx6: avoid dereferencing program counter
 from user mode
Message-ID: <20190208121341.GD13009@e107981-ln.cambridge.arm.com>
References: <20181204132733.14422-1-stefan@agner.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181204132733.14422-1-stefan@agner.ch>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 04, 2018 at 02:27:32PM +0100, Stefan Agner wrote:
> The custom fault handler is currently only meant to handle kernel
> mode bus faults. Exit in case the abort happened in user mode.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)

If this series is still aimed at mainline I need Lucas' ACK to
merge it.

Lorenzo

> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 69f86234f7c0..54a29e441303 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -270,8 +270,14 @@ static int imx6q_pcie_abort_handler(unsigned long addr,
>  		unsigned int fsr, struct pt_regs *regs)
>  {
>  	unsigned long pc = instruction_pointer(regs);
> -	unsigned long instr = *(unsigned long *)pc;
> -	int reg = (instr >> 12) & 15;
> +	unsigned long instr;
> +	int reg;
> +
> +	if (user_mode(regs))
> +		return 1;
> +
> +	instr = *(unsigned long *)pc;
> +	reg = (instr >> 12) & 15;
>  
>  	/*
>  	 * If the instruction being executed was a read,
> -- 
> 2.19.1
> 

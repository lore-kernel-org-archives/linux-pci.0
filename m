Return-Path: <SRS0=XN0A=QS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50397C169C4
	for <linux-pci@archiver.kernel.org>; Mon, 11 Feb 2019 16:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1653721B69
	for <linux-pci@archiver.kernel.org>; Mon, 11 Feb 2019 16:56:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727707AbfBKQ4Q (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 11 Feb 2019 11:56:16 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:34825 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbfBKQ4Q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Feb 2019 11:56:16 -0500
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1gtEsI-0001OV-SV; Mon, 11 Feb 2019 17:56:06 +0100
Message-ID: <1549904165.2546.14.camel@pengutronix.de>
Subject: Re: [PATCH v2 1/2] pci: imx6: avoid dereferencing program counter
 from user mode
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Stefan Agner <stefan@agner.ch>, hongxing.zhu@nxp.com
Cc:     robin.murphy@arm.com, tpiepho@impinj.com, linux@armlinux.org.uk,
        leonard.crestez@nxp.com, andrew.smirnov@gmail.com,
        festevam@gmail.com, lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 11 Feb 2019 17:56:05 +0100
In-Reply-To: <20181204132733.14422-1-stefan@agner.ch>
References: <20181204132733.14422-1-stefan@agner.ch>
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
> The custom fault handler is currently only meant to handle kernel
> mode bus faults. Exit in case the abort happened in user mode.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 69f86234f7c0..54a29e441303 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -270,8 +270,14 @@ static int imx6q_pcie_abort_handler(unsigned long addr,
>  		unsigned int fsr, struct pt_regs *regs)
>  {
>  	unsigned long pc = instruction_pointer(regs);
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
>  	/*
>  	 * If the instruction being executed was a read,

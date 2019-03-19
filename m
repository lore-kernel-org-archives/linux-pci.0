Return-Path: <SRS0=xwy5=RW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CAB8C43381
	for <linux-pci@archiver.kernel.org>; Tue, 19 Mar 2019 19:25:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 380832083D
	for <linux-pci@archiver.kernel.org>; Tue, 19 Mar 2019 19:25:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbfCSTZx (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 19 Mar 2019 15:25:53 -0400
Received: from bmailout1.hostsharing.net ([83.223.95.100]:39347 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727066AbfCSTZx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Mar 2019 15:25:53 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 08F2030000CDA;
        Tue, 19 Mar 2019 20:25:51 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id CE4B3250510; Tue, 19 Mar 2019 20:25:50 +0100 (CET)
Date:   Tue, 19 Mar 2019 20:25:50 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Alexandru Gagniuc <mr.nuke.me@gmail.com>
Cc:     bhelgaas@google.com, austin_bolen@dell.com,
        alex_gagniuc@dellteam.com, keith.busch@intel.com,
        Shyam_Iyer@Dell.com, okaya@kernel.org,
        torvalds@linux-foundation.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/LINK: bw_notification: Do not leave interrupt
 handler NULL
Message-ID: <20190319192550.5lxfm3h2jnaip3on@wunner.de>
References: <CAHk-=wgM-5WfPW9LNHGfc1RxjVbDvHZqNfxyLVRSPP0R4jetDg@mail.gmail.com>
 <20190319011214.7847-1-mr.nuke.me@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190319011214.7847-1-mr.nuke.me@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 18, 2019 at 08:12:04PM -0500, Alexandru Gagniuc wrote:
> A threaded IRQ with a NULL handler does not work with level-triggered
> interrupts. request_threaded_irq() will return an error:
> 
>   genirq: Threaded irq requested with handler=NULL and !ONESHOT for irq 16
>   pcie_bw_notification: probe of 0000:00:1b.0:pcie010 failed with error -22
> 
> For level interrupts we need to silence the interrupt before exiting
> the IRQ handler, so just clear the PCI_EXP_LNKSTA_LBMS bit there.
> 
> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>

I've tested this on my Ivy Bridge MacBook Pro which uses INTx on root and
downstream ports and I'm not seeing probe errors, so:

Tested-by: Lukas Wunner <lukas@wunner.de>


> @@ -67,8 +77,8 @@ static irqreturn_t pcie_bw_notification_handler(int irq, void *context)
>  		__pcie_print_link_status(dev, false);
>  	up_read(&pci_bus_sem);
>  
> +	pcie_capability_read_word(port, PCI_EXP_LNKSTA, &link_status);
>  	pcie_update_link_speed(port->subordinate, link_status);
> -	pcie_capability_write_word(port, PCI_EXP_LNKSTA, events);
>  	return IRQ_HANDLED;
>  }

I'd suggest leaving the call to pcie_update_link_speed() in
pcie_bw_notification_irq() to avoid the duplicate read of the
Link Status register.

With that addressed,
Reviewed-by: Lukas Wunner <lukas@wunner.de>

Thanks,

Lukas

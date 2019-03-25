Return-Path: <SRS0=Cb4Y=R4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C53C43381
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 22:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1197A2082F
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 22:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553552706;
	bh=f+bXjXNI8BpHf9wMt6NcJ8eY+crxFfT1ppviPjRKvN8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tE0OZVi1jhdsNO3T1SRPsPKFDFWcUqC6nYpn3Jn08xjtO8GQ555pb9g88QJ5vcbI7
	 BHmaIm749Wp+xUnV0ChMkBUa7HTTzIwZVoCQtZpVqWcTBvr9Rgyki77fzckA8t6EAs
	 z3IhC6uL25dL12YDdwmJq/Fp8Ir7SZah6/rXMkAo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729127AbfCYWZF (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 25 Mar 2019 18:25:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:56468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728912AbfCYWZF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 25 Mar 2019 18:25:05 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 909D220828;
        Mon, 25 Mar 2019 22:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553552703;
        bh=f+bXjXNI8BpHf9wMt6NcJ8eY+crxFfT1ppviPjRKvN8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SVW+AcXTMWDwOWb1G3GGjIs50Fdyn97/RMHwmA7/UqyUSbYqURyoBeNvkCcInThfc
         JaclYyE3tw7FffoWm26sIhO0jHHsYfRtteaF2W/BOsz2ikVrmQNP11/PfkJFiCeL4P
         n2R7/fUlh+w1ycTr0CSdTpomEs9q5wCMHrBgyjrs=
Date:   Mon, 25 Mar 2019 17:25:02 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Alexandru Gagniuc <mr.nuke.me@gmail.com>
Cc:     austin_bolen@dell.com, alex_gagniuc@dellteam.com,
        keith.busch@intel.com, Shyam_Iyer@Dell.com, lukas@wunner.de,
        okaya@kernel.org, torvalds@linux-foundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI/LINK: bw_notification: Do not leave interrupt
 handler NULL
Message-ID: <20190325222502.GC24180@google.com>
References: <20190320193504.GC251185@google.com>
 <20190323003700.7294-1-mr.nuke.me@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190323003700.7294-1-mr.nuke.me@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 22, 2019 at 07:36:51PM -0500, Alexandru Gagniuc wrote:
> A threaded IRQ with a NULL handler does not work with level-triggered
> interrupts. request_threaded_irq() will return an error:
> 
>   genirq: Threaded irq requested with handler=NULL and !ONESHOT for irq 16
>   pcie_bw_notification: probe of 0000:00:1b.0:pcie010 failed with error -22
> 
> For level interrupts we need to silence the interrupt before exiting
> the IRQ handler, so just clear the PCI_EXP_LNKSTA_LBMS bit there.
> 
> Fixes: e8303bb7a75c ("PCI/LINK: Report degraded links via link bandwidth notification")
> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>

Applied with the following subject line to for-linus for v5.1, thanks!

  PCI/LINK: Supply IRQ handler so level-triggered IRQs are acked

> ---
> Changes since v1:
>  - move pcie_update_link_speed() to irq to prevent duplicate read of link_status
>  - Add Fixes: to commit message
>  
>  drivers/pci/pcie/bw_notification.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/pcie/bw_notification.c b/drivers/pci/pcie/bw_notification.c
> index d2eae3b7cc0f..c48746f1cf3c 100644
> --- a/drivers/pci/pcie/bw_notification.c
> +++ b/drivers/pci/pcie/bw_notification.c
> @@ -44,11 +44,10 @@ static void pcie_disable_link_bandwidth_notification(struct pci_dev *dev)
>  	pcie_capability_write_word(dev, PCI_EXP_LNKCTL, lnk_ctl);
>  }
>  
> -static irqreturn_t pcie_bw_notification_handler(int irq, void *context)
> +static irqreturn_t pcie_bw_notification_irq(int irq, void *context)
>  {
>  	struct pcie_device *srv = context;
>  	struct pci_dev *port = srv->port;
> -	struct pci_dev *dev;
>  	u16 link_status, events;
>  	int ret;
>  
> @@ -58,6 +57,17 @@ static irqreturn_t pcie_bw_notification_handler(int irq, void *context)
>  	if (ret != PCIBIOS_SUCCESSFUL || !events)
>  		return IRQ_NONE;
>  
> +	pcie_capability_write_word(port, PCI_EXP_LNKSTA, events);
> +	pcie_update_link_speed(port->subordinate, link_status);
> +	return IRQ_WAKE_THREAD;
> +}
> +
> +static irqreturn_t pcie_bw_notification_handler(int irq, void *context)
> +{
> +	struct pcie_device *srv = context;
> +	struct pci_dev *port = srv->port;
> +	struct pci_dev *dev;
> +
>  	/*
>  	 * Print status from downstream devices, not this root port or
>  	 * downstream switch port.
> @@ -67,8 +77,6 @@ static irqreturn_t pcie_bw_notification_handler(int irq, void *context)
>  		__pcie_print_link_status(dev, false);
>  	up_read(&pci_bus_sem);
>  
> -	pcie_update_link_speed(port->subordinate, link_status);
> -	pcie_capability_write_word(port, PCI_EXP_LNKSTA, events);
>  	return IRQ_HANDLED;
>  }
>  
> @@ -80,7 +88,8 @@ static int pcie_bandwidth_notification_probe(struct pcie_device *srv)
>  	if (!pcie_link_bandwidth_notification_supported(srv->port))
>  		return -ENODEV;
>  
> -	ret = request_threaded_irq(srv->irq, NULL, pcie_bw_notification_handler,
> +	ret = request_threaded_irq(srv->irq, pcie_bw_notification_irq,
> +				   pcie_bw_notification_handler,
>  				   IRQF_SHARED, "PCIe BW notif", srv);
>  	if (ret)
>  		return ret;
> -- 
> 2.19.2
> 

Return-Path: <SRS0=Ivhv=RX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D543C10F05
	for <linux-pci@archiver.kernel.org>; Wed, 20 Mar 2019 13:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFF3C2184E
	for <linux-pci@archiver.kernel.org>; Wed, 20 Mar 2019 13:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553089596;
	bh=80pi8CDhxhnAicATU26JM+WFWXonPnHkyJuvgaQVVOs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZYVZuPkrYf+aEbXhZSoK2zf98aN5D8H9s0Zuf6lQEdsBM1xaBmOupOe92Twyj27YT
	 JNkwgjTgFtnD1w4X0o4TcU9nD+kgAxVXR8RPyp1fP1gKZyHmyXchMMi/VNpg5IoAtf
	 o2+ay5HAh14oXiRZ3ydP1yNf1o6K4NDiHDboYG3k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbfCTNqf (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 20 Mar 2019 09:46:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:33464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726065AbfCTNqf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 20 Mar 2019 09:46:35 -0400
Received: from localhost (173-28-64-202.client.mchsi.com [173.28.64.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27DA32184D;
        Wed, 20 Mar 2019 13:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553089594;
        bh=80pi8CDhxhnAicATU26JM+WFWXonPnHkyJuvgaQVVOs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xd0wdsesv8JcbO6/LYsIh4yBobMUD8nwdXd+/btzwnKHuxCNazvISQESKYZTqgtwk
         yR4pDL7hsov8+n8ahzxrr+j1xY7qSL3iMx98/8bszqaslloN7LBGvzDY2JUUBZUjbY
         AcdXj3DtdCNbeMQfPjhLeq/QYZIkQH8+Hx49/n+c=
Date:   Wed, 20 Mar 2019 08:46:32 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Alexandru Gagniuc <mr.nuke.me@gmail.com>
Cc:     austin_bolen@dell.com, alex_gagniuc@dellteam.com,
        keith.busch@intel.com, Shyam_Iyer@Dell.com, lukas@wunner.de,
        okaya@kernel.org, torvalds@linux-foundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/LINK: bw_notification: Do not leave interrupt
 handler NULL
Message-ID: <20190320134632.GA251185@google.com>
References: <CAHk-=wgM-5WfPW9LNHGfc1RxjVbDvHZqNfxyLVRSPP0R4jetDg@mail.gmail.com>
 <20190319011214.7847-1-mr.nuke.me@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190319011214.7847-1-mr.nuke.me@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Alexandru,

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

What's your thought regarding Lukas' comment?  If you do repost this,
please add a Fixes: tag to help connect this with the initial commit.

If not, I can add the tag myself.

> ---
> 
> OOPS! I'm sorry for the noise. Here's the fix.
> 
> I was able to test this on edge-triggered interrupts. None of my
> machines have PCIe ports that use level-triggered interrupts. This
> might not be too straightforward to test without a hardware yanker,
> but if there's a way to force a specific interrupt to be level
> triggered, I could do the testing on my end.
> 
>  drivers/pci/pcie/bw_notification.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/pcie/bw_notification.c b/drivers/pci/pcie/bw_notification.c
> index d2eae3b7cc0f..001d6253ad48 100644
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
> +	return IRQ_WAKE_THREAD;
> +}
> +
> +static irqreturn_t pcie_bw_notification_handler(int irq, void *context)
> +{
> +	struct pcie_device *srv = context;
> +	struct pci_dev *port = srv->port;
> +	struct pci_dev *dev;
> +	u16 link_status;
> +
>  	/*
>  	 * Print status from downstream devices, not this root port or
>  	 * downstream switch port.
> @@ -67,8 +77,8 @@ static irqreturn_t pcie_bw_notification_handler(int irq, void *context)
>  		__pcie_print_link_status(dev, false);
>  	up_read(&pci_bus_sem);
>  
> +	pcie_capability_read_word(port, PCI_EXP_LNKSTA, &link_status);
>  	pcie_update_link_speed(port->subordinate, link_status);
> -	pcie_capability_write_word(port, PCI_EXP_LNKSTA, events);
>  	return IRQ_HANDLED;
>  }
>  
> @@ -80,7 +90,8 @@ static int pcie_bandwidth_notification_probe(struct pcie_device *srv)
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

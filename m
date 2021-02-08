Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9CB3C433E0
	for <linux-pci@archiver.kernel.org>; Mon,  8 Feb 2021 12:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A748664E60
	for <linux-pci@archiver.kernel.org>; Mon,  8 Feb 2021 12:02:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233548AbhBHMBx (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 8 Feb 2021 07:01:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:40778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231841AbhBHL7v (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 8 Feb 2021 06:59:51 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EED3A64E8A;
        Mon,  8 Feb 2021 11:59:09 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1l95C7-00ClqQ-Lx; Mon, 08 Feb 2021 11:59:07 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 08 Feb 2021 11:59:07 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Luo Jiaxing <luojiaxing@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linuxarm@openeuler.org
Subject: Re: [PATCH v1 1/2] irqchip/gic-v3-its: don't set bitmap for LPI which
 user didn't allocate
In-Reply-To: <1612781926-56206-2-git-send-email-luojiaxing@huawei.com>
References: <1612781926-56206-1-git-send-email-luojiaxing@huawei.com>
 <1612781926-56206-2-git-send-email-luojiaxing@huawei.com>
User-Agent: Roundcube Webmail/1.4.10
Message-ID: <508c6c07a2c599ae1fc8b726fda69b44@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: luojiaxing@huawei.com, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linuxarm@openeuler.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2021-02-08 10:58, Luo Jiaxing wrote:
> The driver sets the LPI bitmap of device based on 
> get_count_order(nvecs).
> This means that when the number of LPI interrupts does not meet the 
> power
> of two, redundant bits are set in the LPI bitmap. However, when free
> interrupt, these redundant bits is not cleared. As a result, device 
> will
> fails to allocate the same numbers of interrupts next time.
> 
> Therefore, clear the redundant bits set in LPI bitmap.
> 
> Fixes: 4615fbc3788d ("genirq/irqdomain: Don't try to free an interrupt
> that has no mapping")
> 
> Signed-off-by: Luo Jiaxing <luojiaxing@huawei.com>
> ---
>  drivers/irqchip/irq-gic-v3-its.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c 
> b/drivers/irqchip/irq-gic-v3-its.c
> index ed46e60..027f7ef 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -3435,6 +3435,10 @@ static int its_alloc_device_irq(struct
> its_device *dev, int nvecs, irq_hw_number
> 
>  	*hwirq = dev->event_map.lpi_base + idx;
> 
> +	bitmap_clear(dev->event_map.lpi_map,
> +		     idx + nvecs,
> +		     roundup_pow_of_two(nvecs) - nvecs);
> +
>  	return 0;
>  }

What makes you think that the remaining LPIs are free to be released?
Even if the end-point has request a non-po2 number of MSIs, it could
very well rely on the the rest of it to be available (specially in the
case of PCI Multi-MSI).

Have a look at the thread pointed out by John for a potential fix.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...

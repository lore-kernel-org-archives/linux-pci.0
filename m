Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ADAEC2D0A3
	for <linux-pci@archiver.kernel.org>; Thu, 12 Nov 2020 13:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F098920936
	for <linux-pci@archiver.kernel.org>; Thu, 12 Nov 2020 13:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MeoVpkDz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XsCo8U08"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbgKLNup (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 12 Nov 2020 08:50:45 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44728 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728196AbgKLNup (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Nov 2020 08:50:45 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605189043;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FExFbMkw7YXGcGUqIJagY/5g6Z8xr25fzIJwMw/oA+8=;
        b=MeoVpkDz1oVajjmu0mVooQrH2IXUoUNSno/pUj5tQHdXTvLGERYdTJZrwcX2tSKBfexHbe
        sWXuKqJ99lFSlWOdkJxPdcTfRoZsada82WL5lYzpkgKq4K1B7WUvfIHm8DOvM21lQ+ixMS
        H63EWFAY2o6zTIxNEjXueBYBgundGlXdfMs2iumWaXdWoc3gEI7P5MpK2c1Uv6BCHPpHVC
        OeQ5Gh6/y7JaH0PdVmgdVW0GVaujoZLI5ZwO1HJGYI1nJwPly4PtwJiyn8XeAq1U70CBYI
        A5Ud2V44ZKF1AcXtO8awnUD0HujZAyfR3z4FRNguQEoBsimZcImscZ8oGrJazw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605189043;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FExFbMkw7YXGcGUqIJagY/5g6Z8xr25fzIJwMw/oA+8=;
        b=XsCo8U08uItnjSKD1IJmacqK42qPF59gfAAfMv9/OFwqCn6QPt/dvhQNEMWuw2SrmkayFD
        p5ei960Oll/e/TCA==
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Martin Kaiser <martin@kaiser.cx>
Cc:     Ley Foon Tan <ley.foon.tan@intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        rfi@lists.rocketboards.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Toan Le <toan@os.amperecomputing.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH] PCI: altera-msi: Remove irq handler and data in one go
In-Reply-To: <87sg9en79m.fsf@nanos.tec.linutronix.de>
References: <20201111221639.GA973514@bjorn-Precision-5520> <87sg9en79m.fsf@nanos.tec.linutronix.de>
Date:   Thu, 12 Nov 2020 14:50:42 +0100
Message-ID: <87pn4in0p9.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 12 2020 at 12:28, Thomas Gleixner wrote:
> On Wed, Nov 11 2020 at 16:16, Bjorn Helgaas wrote:
>> On Wed, Nov 11, 2020 at 10:43:55PM +0100, Martin Kaiser wrote:
>> Thomas, it looks like irq_domain_set_info() and msi_domain_ops_init()
>> set the handler itself before setting the handler data:
>>
>>   irq_domain_set_info
>>     irq_set_chip_and_handler_name(virq, chip, handler, ...)
>>     irq_set_handler_data(virq, handler_data)
>>
>>   msi_domain_ops_init
>>     __irq_set_handler(virq, info->handler, ...)
>>     if (info->handler_data)
>>       irq_set_handler_data(virq, info->handler_data)
>>
>> That looks at least superficially similar to the race you fixed with
>> 2cf5a03cb29d ("PCI/keystone: Fix race in installing chained IRQ
>> handler").
>>
>> Should irq_domain_set_info() and msi_domain_ops_init() swap the order,
>> too?
>
> In theory yes. Practically it should not matter because that happens
> during the allocation way before the interrupt can actually fire.  I'll
> have a deeper look nevertheless.

So I had a closer look and the reason why it only matters for the
chained handler case is that

   __irq_set_handler(..., is_chained = true, ...)

starts up the interrupt immediately. So the order for this _must_ be:

    set_handler_data() -> set_handler()

For regular interrupts it's really the mapping and allocation code which
does this long before the interrupt is started up. So the ordering does
not matter because the handler can't be reached before the full
setup is finished and the interrupt is actually started up.

Thanks,

        tglx

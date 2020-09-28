Return-Path: <SRS0=RmUR=DF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B45D7C2D0A8
	for <linux-pci@archiver.kernel.org>; Mon, 28 Sep 2020 11:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C5E72100A
	for <linux-pci@archiver.kernel.org>; Mon, 28 Sep 2020 11:32:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LXXbqOT1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IaLC29w1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbgI1Lca (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 28 Sep 2020 07:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbgI1Lc0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Sep 2020 07:32:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F609C061755;
        Mon, 28 Sep 2020 04:32:26 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601292744;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3tT8GIht0pqlC3XdLLIRoOvHpL/MYONBAnnoKe8BbB0=;
        b=LXXbqOT1YgvA5tzHKFXBQLL4ReUjnBD4aB1eMxPsbYDGZyiqWgV23Bq2BlyRx1buzRXgec
        5qytwhPVx8rnGYHTykl6SEN1PD3SRnY2V+tXlvyooWzKU2nFBsXChQC+t7pK2MsIuOVtQJ
        gmT+YmotRF1Iq/KpYsKi0FattscIZeJE9HZiIJQ0ARwUv7boyROQbFdbi07BVSncIwyIp4
        /LLjBZnYFklz1IWRfe9j2QD9tlchu8XOnMSyfkPpM5d8v4P3pQlS93JwNji4DbM5uIgDbl
        +oWQHpCZB8tNjFHYiEBt3TmEb8WIFNtY4C7cBiWBAfMe59FnJco+5zfoOc06gw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601292744;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3tT8GIht0pqlC3XdLLIRoOvHpL/MYONBAnnoKe8BbB0=;
        b=IaLC29w1ViYuMkvTqlia7KFa1b4c3Q5+ZZn5gpwdVyZX3qgwsW78qU1NTwGUWw/jss8anD
        MN5ZdzhxhAwaY6BQ==
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jon Derrick <jonathan.derrick@intel.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Andrzej Jakowski <andrzej.jakowski@linux.intel.com>,
        Sushma Kalakota <sushmax.kalakota@intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH 5/6] x86/apic/msi: Use Real PCI DMA device when configuring IRTE
In-Reply-To: <20200907143207.GC9474@e121166-lin.cambridge.arm.com>
References: <20200728194945.14126-1-jonathan.derrick@intel.com> <20200728194945.14126-6-jonathan.derrick@intel.com> <20200907143207.GC9474@e121166-lin.cambridge.arm.com>
Date:   Mon, 28 Sep 2020 13:32:24 +0200
Message-ID: <877dsekugn.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 07 2020 at 15:32, Lorenzo Pieralisi wrote:

> On Tue, Jul 28, 2020 at 01:49:44PM -0600, Jon Derrick wrote:
>> VMD retransmits child device MSI/X with the VMD endpoint's requester-id.
>> In order to support direct interrupt remapping of VMD child devices,
>> ensure that the IRTE is programmed with the VMD endpoint's requester-id
>> using pci_real_dma_dev().
>> 
>> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
>> Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
>> ---
>>  arch/x86/kernel/apic/msi.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> I'd need an x86 maintainer ACK on this patch.

That conflicts with the big PCI/MSI overhaul which is pending in

  git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/irq

native_setup_msi_irqs() does not exist anymore.

patch 3 has conflicts as well.

Thanks,

        tglx

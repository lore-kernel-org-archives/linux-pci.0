Return-Path: <SRS0=obOR=L7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32C4AECE563
	for <linux-pci@archiver.kernel.org>; Mon, 17 Sep 2018 15:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAC9A214C5
	for <linux-pci@archiver.kernel.org>; Mon, 17 Sep 2018 15:19:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAC9A214C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbeIQUrK (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 17 Sep 2018 16:47:10 -0400
Received: from foss.arm.com ([217.140.101.70]:60866 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727063AbeIQUrK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 17 Sep 2018 16:47:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 33F75ED1;
        Mon, 17 Sep 2018 08:19:20 -0700 (PDT)
Received: from localhost (unknown [10.37.6.15])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BD5133F5BD;
        Mon, 17 Sep 2018 08:19:19 -0700 (PDT)
Date:   Mon, 17 Sep 2018 16:19:17 +0100
From:   Andrew Murray <andrew.murray@arm.com>
To:     John Garry <john.garry@huawei.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Will Deacon <will.deacon@arm.com>,
        dann.frazier@canonical.com, bhelgaas@google.com,
        andy.shevchenko@gmail.com, Linuxarm <linuxarm@huawei.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, suzuki.poulose@arm.com,
        jean-philippe.brucker@arm.com
Subject: Re: [PATCH] asm-generic: io: Fix ioport_map() for
 !CONFIG_GENERIC_IOMAP && CONFIG_INDIRECT_PIO
Message-ID: <20180917151917.GB5390@e119886-lin.cambridge.arm.com>
References: <1536842907-51732-1-git-send-email-andrew.murray@arm.com>
 <464e07ab-797e-971a-0839-5fd55e3e2ad3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <464e07ab-797e-971a-0839-5fd55e3e2ad3@huawei.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org
Message-ID: <20180917151917.q4cuxaJqI8VQWCxtu2IQaT4g67sANRGzAQwWKWkcJL4@z>

On Mon, Sep 17, 2018 at 03:42:32PM +0100, John Garry wrote:
> - dead e-mail addresses (Zhichang, Gabriele)
> 
> On 13/09/2018 13:48, Andrew Murray wrote:
> 
> Hi Andrew,
> 
> > The !CONFIG_GENERIC_IOMAP version of ioport_map uses MMIO_UPPER_LIMIT to
> > prevent users from making I/O accesses outside the expected I/O range -
> > however it erroneously treats MMIO_UPPER_LIMIT as a mask which is
> > contradictory to its other users.
> > 
> > The introduction of CONFIG_INDIRECT_PIO, which subtracts an arbitrary
> > amount from IO_SPACE_LIMIT to form MMIO_UPPER_LIMIT, results in ioport_map
> > mangling the given port rather than capping it.
> > 
> > We address this by aligning more closely with the CONFIG_GENERIC_IOMAP
> > implementation of ioport_map by using the comparison operator and
> > returning NULL where the port exceeds MMIO_UPPER_LIMIT. Though note that
> > we preserve the existing behavior of masking with IO_SPACE_LIMIT such that
> > we don't break existing buggy drivers that somehow rely on this masking.
> 
> I wouldn't say any drivers rely on this - for the only device driver which
> uses the "Indirect" IO space region above MMIO_UPPER_LIMIT (HiSilicon LPC),
> no child device driver for that host uses ioport_map() [those being ipmi si
> and 8250 generic+of drivers].

I was really referring to the existing !CONFIG_GENERIC_IOMAP && 
!CONFIG_INDIRECT_PIO use cases where there may be drivers (however unlikely)
that provide ioport_map an incorrect address which, due to the masking, gets
converted into a valid address. Returning NULL for these would result in new
run-time errors therefore it seemed safer to change this to support the new
"indirect IO" whilst not breaking existing bad drivers.

A more correct implementation would always return NULL if
port > IO_SPACE_LIMIT - it would fully align it with the CONFIG_GENERIC_IOMAP
implementation - in my view these two implementations should behave the same
with respect to error handling - at the moment they don't.


> 
> Regardless of that, it seems better to return NULL when the port is
> out-of-range, rather than masking it.
> 
> Cheers
> 
> > 
> > Fixes: 5745392e0c2b ("PCI: Apply the new generic I/O management on PCI IO hosts")
> > Reported-by: Will Deacon <will.deacon@arm.com>
> > Signed-off-by: Andrew Murray <andrew.murray@arm.com>
> 
> Reviewed-by: John Garry <john.garry@huawei.com>

Thanks for the review.

Andrew Murray

> 
> > ---
> >  include/asm-generic/io.h | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
> > index 66d1d45..d356f80 100644
> > --- a/include/asm-generic/io.h
> > +++ b/include/asm-generic/io.h
> > @@ -1026,7 +1026,8 @@ static inline void __iomem *ioremap_wt(phys_addr_t offset, size_t size)
> >  #define ioport_map ioport_map
> >  static inline void __iomem *ioport_map(unsigned long port, unsigned int nr)
> >  {
> > -	return PCI_IOBASE + (port & MMIO_UPPER_LIMIT);
> > +	port &= IO_SPACE_LIMIT;
> > +	return (port > MMIO_UPPER_LIMIT) ? NULL : PCI_IOBASE + port;
> >  }
> >  #endif
> > 
> > 
> 
> 

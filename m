Return-Path: <SRS0=PPlZ=SV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D29B6C282E0
	for <linux-pci@archiver.kernel.org>; Fri, 19 Apr 2019 21:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ED9D217F9
	for <linux-pci@archiver.kernel.org>; Fri, 19 Apr 2019 21:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555709151;
	bh=tb1ffguJ12QkClCqK6MBuQJBa3JqOL22k+/DYt44WpA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DCG06C1+R81BbkNBwXZXIcFYGzI4EDo1KAqI0Lxb07z9MAO2dWNPjydYi1gXqyPnL
	 IKVeR5ZPPrUh1GxMfHH2d+tB33c/SwsGsUm2cczWOGGb3Z/KBJsVdv3I5yoZCxIsDk
	 PYNYua0wAwMQWDQ3/PfZt7jeGLXKjDuQlU+a2QlI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbfDSVZv (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 19 Apr 2019 17:25:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:52868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726000AbfDSVZu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 19 Apr 2019 17:25:50 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED7B1208C0;
        Fri, 19 Apr 2019 21:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555709150;
        bh=tb1ffguJ12QkClCqK6MBuQJBa3JqOL22k+/DYt44WpA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lUM2U+ElyJBuNxlaAMZo6XdjagsnMH0rzpHVLIN4ONY5lhjeqqw10F7KyZ96dggD9
         Q9SHCJnBs1IRHC5hrIj8OPk24ZI4AVTxB0A0staITou6FrK+HmPvY3y6OTkvlgX3lz
         4Z76GY0AXJm7nKzMtAm97J0V2U5ttiIcyKO7OmHc=
Date:   Fri, 19 Apr 2019 16:25:48 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     Alexandru Gagniuc <mr.nuke.me@gmail.com>, austin_bolen@dell.com,
        alex_gagniuc@dellteam.com, keith.busch@intel.com,
        Shyam_Iyer@Dell.com, lukas@wunner.de, okaya@kernel.org,
        torvalds@linux-foundation.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI/LINK: bw_notification: Do not leave interrupt
 handler NULL
Message-ID: <20190419212548.GA253261@google.com>
References: <20190320193504.GC251185@google.com>
 <20190323003700.7294-1-mr.nuke.me@gmail.com>
 <20190325222502.GC24180@google.com>
 <20190419150827.5040897e@x1.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190419150827.5040897e@x1.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 19, 2019 at 03:08:27PM -0600, Alex Williamson wrote:
> On Mon, 25 Mar 2019 17:25:02 -0500, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Fri, Mar 22, 2019 at 07:36:51PM -0500, Alexandru Gagniuc wrote:
> > > A threaded IRQ with a NULL handler does not work with level-triggered
> > > interrupts. request_threaded_irq() will return an error:
> > > 
> > >   genirq: Threaded irq requested with handler=NULL and !ONESHOT for irq 16
> > >   pcie_bw_notification: probe of 0000:00:1b.0:pcie010 failed with error -22
> > > 
> > > For level interrupts we need to silence the interrupt before exiting
> > > the IRQ handler, so just clear the PCI_EXP_LNKSTA_LBMS bit there.
> > > 
> > > Fixes: e8303bb7a75c ("PCI/LINK: Report degraded links via link bandwidth notification")
> > > Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> > > Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>  
> > 
> > Applied with the following subject line to for-linus for v5.1, thanks!
> > 
> >   PCI/LINK: Supply IRQ handler so level-triggered IRQs are acked
> 
> That made it a little tricky to track down this thread.

Yeah, sorry about that.  I've been wondering if I should add
lore.kernel.org URLs when I apply patches.  Maybe this is one good
reason to do that.

Bjorn

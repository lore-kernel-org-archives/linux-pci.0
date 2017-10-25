Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp1.it.da.ut.ee ([193.40.5.66]:43019 "EHLO smtp1.it.da.ut.ee"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932124AbdJYSBM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 25 Oct 2017 14:01:12 -0400
Date: Wed, 25 Oct 2017 21:01:07 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
cc: linux-alpha@vger.kernel.org,
        Linux Kernel list <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org
Subject: Re: alpha boot hang - 4.14-rc* regression
In-Reply-To: <20171025151413.GA6499@red-moon>
Message-ID: <alpine.LRH.2.21.1710252100080.16994@math.ut.ee>
References: <alpine.LRH.2.21.1710251043170.7098@math.ut.ee> <alpine.LRH.2.21.1710251109150.7098@math.ut.ee> <alpine.LRH.2.21.1710251129520.7098@math.ut.ee> <20171025092159.GA14222@red-moon> <alpine.LRH.2.21.1710251511090.10071@math.ut.ee> <20171025133730.GA5487@red-moon>
 <alpine.LRH.2.21.1710251748170.10071@math.ut.ee> <20171025151413.GA6499@red-moon>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> It is probably because I patched the wrong map_irq() function,
> I am trying to detect which one you are _actually_ using, if
> the patch below fails I will patch them all (which is what I
> have to do anyway).
> 
> Please give this a go - this _has_ to make a difference, it is not
> correct to leave map_irq() pointers as __init memory, IRQ routing
> for modules can't work.

This works for mainline git too.

If you have another round that fixes all subarches, I will try it on a 
PC164 too.

-- 
Meelis Roos (mroos@linux.ee)

Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([184.105.139.130]:54416 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752487AbeDHVVx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 8 Apr 2018 17:21:53 -0400
Date: Sun, 08 Apr 2018 17:21:52 -0400 (EDT)
Message-Id: <20180408.172152.113123578529151252.davem@davemloft.net>
To: mroos@linux.ee
Cc: yinghai@kernel.org, linux-pci@vger.kernel.org,
        sparclinux@vger.kernel.org
Subject: Re: sparc64 PCI BAR allocation is still problematic
From: David Miller <davem@davemloft.net>
In-Reply-To: <alpine.LRH.2.21.1804081219340.17185@math.ut.ee>
References: <alpine.LRH.2.21.1804081219340.17185@math.ut.ee>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Meelis Roos <mroos@linux.ee>
Date: Sun, 8 Apr 2018 21:44:57 +0300 (EEST)

> This is a followup on the thread https://lkml.org/lkml/2015/10/7/135 and 
> corresponding https://bugzilla.kernel.org/show_bug.cgi?id=117191 entry.
> 
> I saw some sparc64 PCI allocation changes in yesterdays git and compiled 
> 4.16.0-10242-gf605ba9 on most of my sparc64 machines to test if the PCI 
> BAR allocation problems introduced in 4.3 were fixed on some of them. 
> Alas, no change at all - of the test machines, none showed any changes 
> in the error messages in "dmesg | grep BAR".
> 
> There was one test machine, T1000 with no addon cards, that did not 
> encounter any problem, before or after the recent patch. All the other 
> test machines tried still have the BAR allocation problems.
> 
> The errors seem to cluster into 3 categories:
> 
> 1. many devices fail BAR allocations
> 2. one of the Davicom Ethernet devices fails BAR allocation
> 3. Uli ISA bridge fails BAR allocation.
> 
> Full current dmesg and lspci info is also available if there is any 
> interest. I did not include it all here, which machines are interesting?

PCI folks, please look into this.

A regression like this should not linger since 4.3, thank you.

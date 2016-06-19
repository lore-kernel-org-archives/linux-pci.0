Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp1.it.da.ut.ee ([193.40.5.66]:37841 "EHLO smtp1.it.da.ut.ee"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751695AbcFSLmq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sun, 19 Jun 2016 07:42:46 -0400
Date: Sun, 19 Jun 2016 14:42:55 +0300 (EEST)
From: mroos@linux.ee
To: David Miller <davem@davemloft.net>
cc: matorola@gmail.com, sparclinux@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 4.6-rc*: Kernel unaligned access at
 pci_bus_read_config_dword+0x64/0x80
In-Reply-To: <20160618.234908.1671877676732375612.davem@davemloft.net>
Message-ID: <alpine.LRH.2.20.1606191442230.5426@math.ut.ee>
References: <CADxRZqw4jG3kPz6wG5Yx5DoZV0h+Xak5j682c7stq0fNOiopZQ@mail.gmail.com> <CADxRZqw6Q-jLCnZzzq=akP5vqd3Y8RCF34pWQGNSuL2VscrbJg@mail.gmail.com> <20160618.210421.1400395696678491125.davem@davemloft.net>
 <20160618.234908.1671877676732375612.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> >> bisected to git commit 63e3027
> > 
> > That's a merge commit that adds 100 different commits, and this happened
> > way back in March.
> > 
> > Please find the exact dword access in:
> > 
> > 	drivers/pci/pcie/portdrv_{core,pci,bus}.c
> > 
> > that triggers this unaligned access so we can debug this further.
> 
> Meanwhile I figured it out, this should fix the bug:

Yes it does for me too - thank you!

-- 
Meelis Roos (mroos@linux.ee)

Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp07.au.ibm.com ([202.81.31.140]:37405 "EHLO
	e23smtp07.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751523AbaANLUA (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 14 Jan 2014 06:20:00 -0500
Received: from /spool/local
	by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <yan@linux.vnet.ibm.com>;
	Tue, 14 Jan 2014 21:19:58 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
	by d23dlp02.au.ibm.com (Postfix) with ESMTP id B0B262BB0053
	for <linux-pci@vger.kernel.org>; Tue, 14 Jan 2014 22:19:54 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id s0EB11vu63373348
	for <linux-pci@vger.kernel.org>; Tue, 14 Jan 2014 22:01:01 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s0EBJrJ4000818
	for <linux-pci@vger.kernel.org>; Tue, 14 Jan 2014 22:19:54 +1100
Date: Tue, 14 Jan 2014 19:19:47 +0800
From: Guo Chao <yan@linux.vnet.ibm.com>
To: Jack Morgenstein <jackm@dev.mellanox.co.il>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, linux-pci@vger.kernel.org,
	yinghai@kernel.org, bhelgaas@google.com, amirv@mellanox.com,
	ogerlitz@mellanox.com, eugenia@mellanox.com,
	Gavin Shan <shangw@linux.vnet.ibm.com>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>
Subject: Re: mlx4_core probe error after applying Yinghai's patch
Message-ID: <20140114111947.GA9083@yanx>
References: <20140114062215.GA19345@richard>
 <20140114105031.71882944@jpm-OptiPlex-GX620>
 <20140114091525.GB27684@richard>
 <20140114122532.0e2b6a64@jpm-OptiPlex-GX620>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140114122532.0e2b6a64@jpm-OptiPlex-GX620>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jan 14, 2014 at 12:25:32PM +0200, Jack Morgenstein wrote:
> I suspect one of the following scenarios:
> 
> 1. BAR 0 contains a "PPF Selection" (i.e., ownership) semaphore:  The first PF probe which
> reads the semaphore "acquires" it (i.e., the first read grabs the semaphore (the read returns zero).
> Subsequent reads return non-zero.  When the PF driver is unloaded, it calls "mlx4_free_ownership()",

The read returns 0x1000000. Does it look like a typical value from a
second read?

> which writes a zero into the semaphore dword, so that the next read will return zero.
> 
> In this scenario, initialization of the "PPF selection" semaphore to zero has been compromised somehow, so that
> even the first read attempt returns a non-zero value.  In this scenario, note that the ioremap DID succeed, or
> we would see the "Failed to obtain ownership bit" message in the error log.  Maybe pre-fetching has something
> to do with this? (i.e., maybe if the BAR is not prefetched, the initial value of the semaphore is compromised).
> 

BAR 0 itself is a 64-bit non-prefetchable BAR and not effected by the
patch. It's ROM BAR moved from prefetchable window to non-prefetchable
window. Another change can be seen is the relative position of BAR0 and
ROM BAR.

Thanks,
Guo Chao

> 2. For some reason the same PF is being probed twice by the
> kernel.  In this case the second probe attempt fails because the PF has
> already been probed once.
> 
> This is the reason that I want to see the entire log -- to see if
> indeed the device is being "double-probed"
> 
> -Jack
> 


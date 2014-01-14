Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ee0-f41.google.com ([74.125.83.41]:63502 "EHLO
	mail-ee0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751329AbaANLVH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 14 Jan 2014 06:21:07 -0500
Received: by mail-ee0-f41.google.com with SMTP id e49so144921eek.14
        for <linux-pci@vger.kernel.org>; Tue, 14 Jan 2014 03:21:06 -0800 (PST)
Date: Tue, 14 Jan 2014 13:21:00 +0200
From: Jack Morgenstein <jackm@dev.mellanox.co.il>
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, linux-pci@vger.kernel.org,
	yinghai@kernel.org, bhelgaas@google.com, amirv@mellanox.com,
	ogerlitz@mellanox.com, eugenia@mellanox.com,
	Guo Chao <yan@linux.vnet.ibm.com>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>
Subject: Re: mlx4_core probe error after applying Yinghai's patch
Message-ID: <20140114132100.1bc5d621@jpm-OptiPlex-GX620>
In-Reply-To: <52d51b4c.c413ec0a.290f.03c3SMTPIN_ADDED_BROKEN@mx.google.com>
References: <20140114062215.GA19345@richard>
	<20140114105031.71882944@jpm-OptiPlex-GX620>
	<20140114091525.GB27684@richard>
	<20140114122532.0e2b6a64@jpm-OptiPlex-GX620>
	<52d51b4c.c413ec0a.290f.03c3SMTPIN_ADDED_BROKEN@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 14 Jan 2014 19:10:55 +0800
Gavin Shan <shangw@linux.vnet.ibm.com> wrote:

> The problem happened only when BAR#0 and BAR#6 were allocated
> from same non-profetchable P2P window. So we guessed the problem
> had relationship with ROM BAR#6 and we read multiple bytes from
> BAR#0+0x8069c:
> 
> BAR#0+0x8069c: 0x00001000
> BAR#0+0x806a0: 0x0
> BAR#0+0x806a4: 0x0
> BAR#0+0x806a8: 0x0
> BAR#0+0x806ac: 0x0
> 
> My question is 0x0 is expected value from (BAR#0 + 0x806a*) ? :-)

Yes, the first time the value is read from dword 0x8069c, it should be
zero.

-Jack

Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:60191 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750721AbcEQThr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 17 May 2016 15:37:47 -0400
Date: Tue, 17 May 2016 14:37:42 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>
Subject: Re: next-20160517 - lockdep splat in pcie code
Message-ID: <20160517193742.GA10755@localhost>
References: <4249.1463510162@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4249.1463510162@turing-police.cc.vt.edu>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Lukas, Mika]

On Tue, May 17, 2016 at 02:36:02PM -0400, Valdis Kletnieks wrote:
> Seen during boot on next-20160517. This apparently sneaked into the tree
> sometime after -0502 (probably after -0512 but I can't prove it at the moment)
> 
> [    1.806765] INFO: trying to register non-static key.
> [    1.806772] the code is fine but needs lockdep annotation.
> [    1.806777] turning off the locking correctness validator.
> [    1.806786] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 4.6.0-next-20160517-00001-gede618fce89c-dirty #276
> [    1.806794] Hardware name: Dell Inc. Latitude E6530/07Y85M, BIOS A17 08/19/2015
> [    1.806802]  0000000000000086 000000009200d6c8 ffff88022ca23a90 ffffffffa83f99f3
> [    1.806815]  0000000000000000 ffff880223727d40 ffff88022ca23b00 ffffffffa80c1de1
> [    1.806826]  0000000000000246 0000000000000000 ffffffffffffffff ffff88022ca23ad8
> [    1.806834] Call Trace:
> [    1.806845]  [<ffffffffa83f99f3>] dump_stack+0x68/0x95
> [    1.806855]  [<ffffffffa80c1de1>] register_lock_class+0x541/0x550
> [    1.806861]  [<ffffffffa8404b6c>] ? widen_string+0x3c/0xf0
> [    1.806870]  [<ffffffffa80c4108>] __lock_acquire+0x88/0x1260
> [    1.806876]  [<ffffffffa840751a>] ? vsnprintf+0x36a/0x520
> [    1.806886]  [<ffffffffa81bdfc1>] ? kfree_const+0x21/0x30
> [    1.806893]  [<ffffffffa80c56d1>] lock_acquire+0xb1/0x200
> [    1.806904]  [<ffffffffa852874e>] ? pm_runtime_no_callbacks+0x1e/0x40
> [    1.806915]  [<ffffffffa8a07831>] _raw_spin_lock_irq+0x41/0x50
> [    1.806923]  [<ffffffffa852874e>] ? pm_runtime_no_callbacks+0x1e/0x40
> [    1.806932]  [<ffffffffa852874e>] pm_runtime_no_callbacks+0x1e/0x40
> [    1.806942]  [<ffffffffa844fe36>] pcie_port_device_register+0x226/0x560
> [    1.806950]  [<ffffffffa8450542>] pcie_portdrv_probe+0x32/0xa0

Probably introduced by this:

http://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/commit/?id=0195d2813547

I dropped the pci/pm branch for now.

Return-Path: <SRS0=sAiH=YR=rjwysocki.net=rjw@kernel.org>
Return-Path: <SRS0=sAiH=YR=rjwysocki.net=rjw@kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Lukas Wunner <lukas@wunner.de>
Cc: Peter Wu <peter@lekensteyn.nl>, Mika Westerberg <mika.westerberg@linux.intel.com>, Kilian Singer <kilian.singer@quantumtechnology.info>, Bjorn Helgaas <helgaas@kernel.org>, linux-pci <linux-pci@vger.kernel.org>, Dave Airlie <airlied@redhat.com>
Subject: Re: PCI: Revert "PCI: Add runtime PM support for PCIe ports"
Date: Tue, 03 Jan 2017 22:26:31 +0100
Message-ID: <10121988.WkxEvaFWEW@aspire.rjw.lan>
In-Reply-To: <20170103161123.GA20915@wunner.de>
References: <20161228161816.GA19653@bhelgaas-glaptop.roam.corp.google.com> <20170103151547.GB9763@al> <20170103161123.GA20915@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-pci.vger.kernel.org>

On Tuesday, January 03, 2017 05:11:23 PM Lukas Wunner wrote:
> [cc += Dave Airlie:
> 
> Dave, we're about to lose support for newer Optimus laptops which use
> _PR3 to cut power to the discrete GPU because Bjorn Helgaas has queued
> a commit on his for-linus branch to remove runtime PM for PCIe ports.
> This fixes a regression on Kilian Singer's laptop on which locking the
> screen breaks USB and PS/2 input devices:

It doesn't fix the broken system suspend/resume on his system, though.

Thanks,
Rafael

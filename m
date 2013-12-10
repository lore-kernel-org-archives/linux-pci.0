Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:51309 "EHLO quartz.orcorp.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750721Ab3LJBbi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 9 Dec 2013 20:31:38 -0500
Date: Mon, 9 Dec 2013 18:31:36 -0700
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 2/2] PCI: Stop clearing bridge Secondary Status when
 setting up I/O aperture
Message-ID: <20131210013136.GO5429@obsidianresearch.com>
References: <20131206001333.27659.59935.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20131206001954.27659.78163.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20131209193332.GB20199@obsidianresearch.com>
 <CAErSpo4Q-sjiCUs3UbQWdPhOTdxfJP1ay1MugxTPT1E2=TkpJw@mail.gmail.com>
 <20131209212744.GK5429@obsidianresearch.com>
 <CAErSpo6ZNM0SW+q7tSi+1hT6yAfb7Ckz85LjM4QUDgbH3wLAaw@mail.gmail.com>
 <20131210001008.GM5429@obsidianresearch.com>
 <CAErSpo63eRPzXeQ94XTR3T7PDoQUjTmqfwJKn2EKSNPi3Jyc0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAErSpo63eRPzXeQ94XTR3T7PDoQUjTmqfwJKn2EKSNPi3Jyc0Q@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Dec 09, 2013 at 05:18:30PM -0700, Bjorn Helgaas wrote:

> > Basically, your fix to pci_setup_bridge_io is fine - but your
> > observation led me to realize that the HW drivers implementing RMW for
> > 8 and 16 bit ops under their struct pci_ops.read function have exactly
> > the same flaw you are fixing here - they will silently wipe out write
> > 1 to clear bits.
> 
> Ah, OK.  I thought you were saying that we couldn't change
> pci_setup_bridge_io() to use 16-bit accesses because of this problem.

No, not really - just that this bug you discovered is broader than just
that one place :)

> Sure, if somebody can come up with a reasonable way to share this sort
> of code, that sounds like a good thing.  Maybe extending struct
> pci_ops is the way to do this, but I hope not, because it seems like

Well, sharing the code is no problem, it is exactly the same for every
32 bit only host driver.

But supporting RW1C bits in capability lists seems fairly hard once
the context at the call site is lost.

Which makes me wonder if supporting sub-dword writes to dwords with
RW1C bits makes sense at all :(

That was why my initial reaction was to not do sub dword writes if you
know it will conflict with a RW1C bit.

Jason

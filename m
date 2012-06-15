Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from h9.dl5rb.org.uk ([81.2.74.9]:49482 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752042Ab2FORgQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 15 Jun 2012 13:36:16 -0400
Date: Fri, 15 Jun 2012 17:38:23 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Myron Stowe <myron.stowe@gmail.com>,
	Sebastian Andrzej Siewior <sebastian@breakpoint.cc>,
	linux-pci@vger.kernel.org, linux-kbuild@vger.kernel.org,
	Michal Marek <mmarek@suse.cz>
Subject: Re: [PATCH 7/9] mips: move PCI fixup hooks from __init to __devinit
Message-ID: <20120615163823.GA14302@linux-mips.org>
References: <1338749305-22558-1-git-send-email-sebastian@breakpoint.cc>
 <1338749305-22558-8-git-send-email-sebastian@breakpoint.cc>
 <CAL-B5D1GEMd9TPMqbYBqDuzs5U2jo7ByRg73Z=dPsPcgTSyJJA@mail.gmail.com>
 <CAErSpo77vyUaGTzVNwFGzTHsOapYNFRy_KOvNnXo=jdU2kYLbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAErSpo77vyUaGTzVNwFGzTHsOapYNFRy_KOvNnXo=jdU2kYLbA@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jun 15, 2012 at 10:33:15AM -0600, Bjorn Helgaas wrote:

> > Doesn't the above line also need changed to __devinitdata if the
> > function itself is being
> > changed from __init to __devinit?
> 
> I think so.  And pci_irq[] and piixirqmap[] also need to be moved,
> since they're referenced by __devinit code.  I fixed these, audited
> all the other patches, and updated the "next" branch.

I'm going to patch that up.

Thanks folks,

  Ralf

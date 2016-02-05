Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from one.firstfloor.org ([193.170.194.197]:36002 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751035AbcBEDgU (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 4 Feb 2016 22:36:20 -0500
Date: Fri, 5 Feb 2016 04:36:17 +0100
From: Andi Kleen <andi@firstfloor.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>, Andi Kleen <andi@firstfloor.org>,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH] x86, pci: Add quirk for unsizeable Broadwell EP bar
Message-ID: <20160205033616.GF3696@two.firstfloor.org>
References: <1452896279-22034-1-git-send-email-andi@firstfloor.org>
 <20160204174155.GB19957@localhost>
 <20160204185442.GA4875@tassilo.jf.intel.com>
 <20160205015734.GA29929@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160205015734.GA29929@localhost>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> > But would actually anything use it?
> 
> You mean, would anything actually use the lspci output?  I don't know,
> but why would we want it to print garbage?

In he kernel. I don't think lspci is that interesting.
> 
> And the kernel certainly uses the struct resource.  Setting
> IORESOURCE_PCI_FIXED is not a way of saying "please ignore this
> resource."

There is already another quirk that uses the same technique to handle
a bad bar. I also didn't notice any bad side effects. Again what would it be
used for?

I looked into the new device ops you asked for, but it is fairly
complicated as the ops are not per device but per bus, and there
can be many copies of this device, and the pci_dev is not passed,
so it needs complicated pattern matching on the devfn.

Doing it like the existing quirk is much simpler, and seems to work
just fine.

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only.

Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:39246 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933796AbcBDSyn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 4 Feb 2016 13:54:43 -0500
Date: Thu, 4 Feb 2016 10:54:42 -0800
From: Andi Kleen <ak@linux.intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Andi Kleen <andi@firstfloor.org>, bhelgaas@google.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	x86@kernel.org
Subject: Re: [PATCH] x86, pci: Add quirk for unsizeable Broadwell EP bar
Message-ID: <20160204185442.GA4875@tassilo.jf.intel.com>
References: <1452896279-22034-1-git-send-email-andi@firstfloor.org>
 <20160204174155.GB19957@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160204174155.GB19957@localhost>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> It sounds like these devices have some device-specific register where
> BAR 0 is supposed to be?  Setting IORESOURCE_PCI_FIXED doesn't seem
> like the right solution to me.  Even if we set that, the core still

There is no actually functional register on these locations that has any side
effects.

> believes this resource corresponds to some address space consumed by
> the device.  I think we will still try to size the BAR and decode its
> type.  I think it will still show up via lspci.  That's all
> meaningless.

But would actually anything use it?

> How do you deal with this on Windows?
> 
> I think you need to replace the config accessor with a special one
> that knows that this register is not a BAR, and they can return zero.
> Or maybe the accessor should hide these devices completely, i.e.,
> return 0xffffffff for the vendor/device ID.  Or maybe you even have a
> switch the BIOS can use to hide them from the OS.

In some cases we need the devices.

-Andi

Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:44500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752914AbdF0UzY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Jun 2017 16:55:24 -0400
Date: Tue, 27 Jun 2017 15:55:21 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Andi Kleen <ak@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Peter Anvin <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        linux-pci@vger.kernel.org
Subject: Re: [patch 0/7] x86/pci: Switch to lockless ECAM configuration mode
Message-ID: <20170627205521.GA764@bhelgaas-glaptop.roam.corp.google.com>
References: <20170316215002.726697858@linutronix.de>
 <20170613002536.GA21242@tassilo.jf.intel.com>
 <alpine.DEB.2.20.1706220026450.2152@nanos>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.20.1706220026450.2152@nanos>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc linux-pci]

On Thu, Jun 22, 2017 at 12:28:09AM +0200, Thomas Gleixner wrote:
> Andi,
> 
> On Mon, 12 Jun 2017, Andi Kleen wrote:
> > On Thu, Mar 16, 2017 at 10:50:02PM +0100, Thomas Gleixner wrote:
> > > Andi reported that the Intel Uncore performance monitoring suffers from the
> > > global pci_lock which protects the generic PCI config space accessors.
> > > 
> > > This lock can be removed on X86 because all architecture specific config
> > > space accessors are either serialized by a seperate lock or can be
> > > converted to have their own locking. The mmconfig based access (ECAM) does
> > > not require serialization at the config read/write level because the access
> > > is a simple byte/word/dword read from or write to the memory mapped
> > > configuration space. In that case the lock does not provide any more
> > > protection than the hardware provides already.
> > > 
> > > The series converts the CE4100 PCI low level accessors to use the x86
> > > specific pci_config_lock and implements the switch over to lockless ECAM
> > > configureation space accesors when the system is capable.
> > 
> > What's the status of this patch series? The lock contention
> > problem is still there.
> 
> Just rechecked. It still applies and boots (patch 6/7) dropped.
> 
> If Bjorn has no objections I can route it through tip tomorrow.

Sorry for the delay.  I use patchwork as my to-do list, and it only
looks at linux-pci.  This series wasn't posted there, so I didn't see
it until now.

I have a couple trivial comments but I think it looks great overall.
Here's my ack if you want to apply it via tip:

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Bjorn

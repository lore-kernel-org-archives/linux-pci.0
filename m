Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:37702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753016AbcK2ElB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 28 Nov 2016 23:41:01 -0500
Date: Mon, 28 Nov 2016 22:40:56 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] x86/platform/intel-mid: Constify mid_pci_platform_pm
Message-ID: <20161129044056.GA22896@bhelgaas-glaptop.roam.corp.google.com>
References: <c2b767a782f9a0e1780e5c201d245d1be5b7d78a.1476011255.git.lukas@wunner.de>
 <20161128192530.GO16033@bhelgaas-glaptop.roam.corp.google.com>
 <20161128223859.GA4571@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161128223859.GA4571@wunner.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Nov 28, 2016 at 11:38:59PM +0100, Lukas Wunner wrote:
> On Mon, Nov 28, 2016 at 01:25:30PM -0600, Bjorn Helgaas wrote:
> > On Sun, Oct 09, 2016 at 01:12:55PM +0200, Lukas Wunner wrote:
> > > -.data          56
> > > +.data           0
> > > -.rodata        32
> > > +.rodata        88
> > > 
> > > Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > Signed-off-by: Lukas Wunner <lukas@wunner.de>
> > 
> > Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > It'd be nice if this had a changelog.  I'm happy if this goes via the
> > x86 tree.
> 
> Thanks, I'll resend with your ack.
> 
> As for the changelog, to be honest I can't think of much more to write
> there.  One important motivation of constifying structs that are never
> modified, and particularly structs containing function pointers like
> this one, is to prevent their modification and subsequent usage by an
> attacker.  However constification patches are submitted all the
> time by Julia Lawall and others, and I've never seen this rationale
> spelled out in a commit message, so the assumption seems to be that
> it's common knowledge.  I could probably add something like
> 
> 	Size of pci-mid.o ELF sections:
> 
> to clarify what the numbers in the changelog refer to.

Part of this is an artifact of my workflow.  I read and review patches
in mutt, and then all I see is the body of the changelog, not the
subject line.  So in this case, all I see is:

  -.data          56
  +.data           0
  -.rodata        32
  +.rodata        88

which isn't much.  I mean, I can guess that you're reducing the size of
things.  But apparently even that isn't the reason you're doing this.
Something as simple as "make mid_pci_platform_pm const because it
never needs to be modified" might be enough.

Bjorn

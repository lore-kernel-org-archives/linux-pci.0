Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:40232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759300AbcIWTM3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 23 Sep 2016 15:12:29 -0400
Date: Fri, 23 Sep 2016 14:12:23 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Keith Busch <keith.busch@intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv3 2/2] x86/vmd: Add PCI domain specific LED option
Message-ID: <20160923191223.GA16019@localhost>
References: <1473779140-4016-1-git-send-email-keith.busch@intel.com>
 <1473779140-4016-2-git-send-email-keith.busch@intel.com>
 <20160923143441.GF1514@localhost>
 <20160923165702.GA20686@keith>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160923165702.GA20686@keith>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Sep 23, 2016 at 12:57:02PM -0400, Keith Busch wrote:
> On Fri, Sep 23, 2016 at 09:34:41AM -0500, Bjorn Helgaas wrote:
> > I made the necessary changes to match the renaming I did in the first
> > patch, and I also used plain old "#ifdef" instead of "#if IS_ENABLED"
> > since the rest of the file uses the former style.  If there's a reason
> > to switch, we should change the whole file in a separate patch so we
> > can explain the rationale.
> 
> The check was "IS_ENABLED" because VMD can be a loadable module, which
> fails the ifdef check. I see Fengguang 0'dayed it using the module
> configuration option. I can send you a fix based on your pci/hotplug
> branch, or revert and apply the original patch if you prefer.

I didn't realize VMD could be a loadable module, and I didn't realize
that would make a difference for the config symbol.

BTW, the "Volume Management Device Driver" config item appears by
itself in the top-level menuconfig menu.  That seems a little ...
presumptuous; is it what you intended?

It took me a while, but I did eventually figure out why #ifdef doesn't
work -- we generate a different include/generated/autoconf.h symbol
for modules:

                 built-in                 loadable module
                 ---------------------    ---------------------------
  .config        CONFIG_VMD=y             CONFIG_VMD=m
  autoconf.h     #define CONFIG_VMD 1     #define CONFIG_VMD_MODULE 1

Anyway, I fixed it by using IS_ENABLED() again.

I might propose a comment update to help anybody else who stumbles
over this.  It was kind of annoying to puzzle this out.

> BTW, you had asked me not to split a series when incremental fixes
> touched a single patch. I didn't resend the whole series here, and while
> you got the right patches, I apologize for making it more difficult to find.

No problem, I was just paying more attention this time :)
Except for IS_ENABLED(), anyway.

Bjorn

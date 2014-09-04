Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:61585 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753582AbaIDWSs (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 4 Sep 2014 18:18:48 -0400
Received: by mail-pa0-f46.google.com with SMTP id eu11so20793737pac.5
        for <linux-pci@vger.kernel.org>; Thu, 04 Sep 2014 15:18:47 -0700 (PDT)
Date: Thu, 4 Sep 2014 16:18:43 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Matthew Minter <matthew_minter@xyratex.com>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 01/22] Added some infrastructure to allow assigning PCI
 device IRQs at device enable time and removed pci_fixup_irqs as the other
 change obsolites it.
Message-ID: <20140904221843.GH17125@google.com>
References: <1407255083-9356-1-git-send-email-matthew_minter@xyratex.com>
 <1407255083-9356-2-git-send-email-matthew_minter@xyratex.com>
 <20140807034338.GA13444@richard>
 <CAFJTrDuzdoOPoQ_rpNsYU+OeE380sY37aQaMSudhu_MVKo352g@mail.gmail.com>
 <20140808012017.GA11712@richard>
 <CAFJTrDs0oELF3FNaf6axQvPkLv1skK1f3j_Hgre2VX9XDFBOag@mail.gmail.com>
 <20140904220044.GG17125@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140904220044.GG17125@google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Sep 04, 2014 at 04:00:44PM -0600, Bjorn Helgaas wrote:
> On Mon, Aug 11, 2014 at 11:16:50AM +0100, Matthew Minter wrote:
> > It seems that by coincidence, my testing boxes did not have any
> > devices which needed the PCI_INTERRUPT_PIN fixed up. Therefore I had
> > not noticed the fact the fixed value was not used in the enable path.
> > 
> > I would assume that someone with a different setup would have had a
> > problem there however so thank you for pointing out this bug. I have
> > integrated your fix into version 2 of the patch set.
> 
> I'm dropping this series and I'll watch for v2.

BTW, when you do repost this, the individual patches need changelogs, and
the summary (subject lines) can be a little shorter and more specific,
e.g., no need to mention "untested", but "accomodate new irq init code"
doesn't really convey much information to someone who is looking only at
the arch/m68k commits.

Bjorn

Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:44724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753206AbeB0Owd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Feb 2018 09:52:33 -0500
Date: Tue, 27 Feb 2018 08:52:31 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Rolf Evers-Fischer <embedded24@evers-fischer.de>, kishon@ti.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, andy.shevchenko@gmail.com
Subject: Re: [PATCH v3 0/2] pci: endpoint: Fix double free in pci_epf_create()
Message-ID: <20180227145231.GC112033@bhelgaas-glaptop.roam.corp.google.com>
References: <20180227100231.22561-1-embedded24@evers-fischer.de>
 <20180227102030.GB26238@e107981-ln.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180227102030.GB26238@e107981-ln.cambridge.arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Feb 27, 2018 at 10:20:30AM +0000, Lorenzo Pieralisi wrote:
> On Tue, Feb 27, 2018 at 11:02:28AM +0100, Rolf Evers-Fischer wrote:
> > This is version 3 of a patchset to avoid double free in function
> > 'pci_epf_create()'.
> > 
> > When I accidentally created a new endpoint device with an empty name,
> > the kernel warned about "attempted to be registered with empty name!"
> > and crashed afterwards.
> > 
> > It turned out that the crash was not caused by the 'device_add()'
> > function itself, but by a double kfree of 'epf->name' and 'epf'.
> > 
> > The first patch just simplifies the code, while the second patch
> > fixes the problem.
> > 
> > Changes in v3:
> > - Matched to other pending pci endpoint commits (thanks, Bjorn!)
> > - Added "Fixes" tag in patch 2 (thanks, Andy!)
> > 
> > Changes in v2:
> > - Based on feedback from Lorenzo, Andy and Kishon (thanks!)
> > - Change IDs removed
> > - First patch completely reworked in order to eliminate the
> >   need for the second 'kstrdup' allocation and the 'kfree' of
> >   the first allocation.
> >   It was tested with name="pci_epf_test.0" and name="pci_epb":
> >   The 'epf->name' was "pci_epf_test" or "pci_epb" (=unchanged).
> > 
> > Rolf Evers-Fischer (2):
> >   pci: endpoint: Simplify name allocation for epf device
> >   pci: endpoint: Fix kernel panic after put_device()
>     ^^^
> 
> s/pci/PCI
> 
> Bjorn pointed that out too, I can do it when merging the patches myself
> just a hint in case you have to respin it again, no problem.

I wonder if Rolf posted the wrong version accidentally, since he
mentioned making these match, but I don't see anything different in
this posting.  Oh, never mind, I see the response about rebasing.
I should have been more clear about what I was looking for.

Also s/epf/EPF/, since "epf" isn't a real word.

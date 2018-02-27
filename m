Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.135]:43921 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752309AbeB0MMJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Feb 2018 07:12:09 -0500
Date: Tue, 27 Feb 2018 13:11:57 +0100 (CET)
From: Rolf Evers-Fischer <embedded24@evers-fischer.de>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
cc: Rolf Evers-Fischer <embedded24@evers-fischer.de>, kishon@ti.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, andy.shevchenko@gmail.com
Subject: Re: [PATCH v3 0/2] pci: endpoint: Fix double free in
 pci_epf_create()
In-Reply-To: <20180227102030.GB26238@e107981-ln.cambridge.arm.com>
Message-ID: <alpine.LNX.2.20.1802271257030.23086@5HSWXM1.fritz.box>
References: <20180227100231.22561-1-embedded24@evers-fischer.de> <20180227102030.GB26238@e107981-ln.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello Lorenzo,

On Tue, 27 Feb 2018, Lorenzo Pieralisi wrote:

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
> 

thank you for pointing this out. I haven't recognized this detail. I 
thought that Bjorn wanted me to rebase my patch series upon the latest 
unmerged PCI endpoint patches - and I was surprised that there was no 
change.

Thank you for your kind offer to fix it when merging the patches.

Best regards,
 Rolf

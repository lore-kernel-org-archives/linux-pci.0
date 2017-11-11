Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:58744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752039AbdKKUrn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 11 Nov 2017 15:47:43 -0500
Date: Sat, 11 Nov 2017 14:47:40 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add Lorenzo Pieralisi for PCI host bridge
 drivers
Message-ID: <20171111204739.GC19895@bhelgaas-glaptop.roam.corp.google.com>
References: <20171108201510.18601.30578.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20171108202602.GA19676@bhelgaas-glaptop.roam.corp.google.com>
 <4805cf13-3e33-31fb-ab25-1adb4ed13b9c@ti.com>
 <20171109150528.GA7629@bhelgaas-glaptop.roam.corp.google.com>
 <c990c9af-7d7c-27f9-30e5-2ebda49b8b3b@rock-chips.com>
 <20171110104035.GA842@red-moon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171110104035.GA842@red-moon>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Nov 10, 2017 at 10:40:35AM +0000, Lorenzo Pieralisi wrote:
> On Fri, Nov 10, 2017 at 08:46:29AM +0800, Shawn Lin wrote:
> > On 2017/11/9 23:05, Bjorn Helgaas wrote:

> > >diff --git a/MAINTAINERS b/MAINTAINERS
> > >index db412a627d96..6ce341e86fec 100644
> > >--- a/MAINTAINERS
> > >+++ b/MAINTAINERS
> > >@@ -10378,6 +10378,7 @@ F:	drivers/pci/dwc/*keystone*
> > >  PCI ENDPOINT SUBSYSTEM
> > >  M:	Kishon Vijay Abraham I <kishon@ti.com>
> > >+M:	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > >  L:	linux-pci@vger.kernel.org
> > >  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kishon/pci-endpoint.git
> > >  S:	Supported
> > >@@ -10429,6 +10430,15 @@ F:	include/linux/pci*
> > >  F:	arch/x86/pci/
> > >  F:	arch/x86/kernel/quirks.c
> > >+PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS
> > >+M:	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > >+L:	linux-pci@vger.kernel.org
> > >+Q:	http://patchwork.ozlabs.org/project/linux-pci/list/
> > >+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git/
> > 
> > So, does that mean the patch(es) for host drivers shoube be based on
> > this tree instead of yours? If yes, which tree should be preferred if
> > a patchset wanna touch both of pci core and host drivers?
> 
> I think you should always use Bjorn's tree as a reference and we
> will sort out the dependencies.

Yep, that's what I think, too.  My advice is to always use the
"master" branch of my tree as the base.  I use a lot of topic
branches, and they are almost always based on my "master".

There will be exceptions where that doesn't work because your patch
depends on something already in my tree or something in another tree.
But those are actually fairly rare, so just point that out in your
cover letter and we'll sort it out on a case-by-case basis.

Bjorn

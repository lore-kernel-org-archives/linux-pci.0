Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:57477 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753372AbaJNXZV (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 14 Oct 2014 19:25:21 -0400
Received: by mail-ie0-f174.google.com with SMTP id tr6so112742ieb.33
        for <linux-pci@vger.kernel.org>; Tue, 14 Oct 2014 16:25:20 -0700 (PDT)
Date: Tue, 14 Oct 2014 17:25:18 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Liviu Dudau <Liviu.Dudau@arm.com>
Cc: "matt@masarand.com" <matt@masarand.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 01/18] Added way to register deferred PCI IRQ assignment
 handlers
Message-ID: <20141014232518.GA15225@google.com>
References: <1412222866-21068-1-git-send-email-matt@masarand.com>
 <1412222866-21068-2-git-send-email-matt@masarand.com>
 <20141002103315.GM841@e106497-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20141002103315.GM841@e106497-lin.cambridge.arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Oct 02, 2014 at 11:33:15AM +0100, Liviu Dudau wrote:
> On Thu, Oct 02, 2014 at 05:07:29AM +0100, matt@masarand.com wrote:
> > From: Matthew Minter <matt@masarand.com>
> > 
> 
> Hi Matthew,
> 
> Some comments below:

Hi Liviu,

Thank you very much for reviewing this!  Sorry that I didn't notice your
comments until later (mutt email-reading snafu on my end), so I duplicated
some of your thoughts.  This was just out of my ignorance, not because I'm
taking issue with your comments.

> > -static struct pci_host_bridge *find_pci_host_bridge(struct pci_bus *bus)
> > +struct pci_host_bridge *find_pci_host_bridge(struct pci_bus *bus)
> 
> When I did the same thing in one of the versions of my generic host bridge series,
> Bjorn has mentioned that he would like the name to be changed to pci_xxxxx to
> make clear that the function is now public.

This particular one is not a big deal to me because it's in
drivers/pci/pci.h, which is really only for use inside the PCI core.  It's
when we expose things in include/linux/pci.h, and especially when we export
things for use by modules, that I think we should be careful to use a
consistent namespace.

Bjorn

Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:46526 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751366AbcCIQ4Y (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 9 Mar 2016 11:56:24 -0500
Date: Wed, 9 Mar 2016 10:56:21 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Michael Auchter <michael.auchter@ni.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pci: add pci_clear_master() stub for !CONFIG_PCI
Message-ID: <20160309165621.GB14873@localhost>
References: <1457476481-13654-1-git-send-email-michael.auchter@ni.com>
 <20160308231017.GA11153@localhost>
 <20160309003955.GA1589@tilquin.amer.corp.natinst.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160309003955.GA1589@tilquin.amer.corp.natinst.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Mar 08, 2016 at 06:39:56PM -0600, Michael Auchter wrote:
> On Tue, Mar 08, 2016 at 05:10:17PM -0600, Bjorn Helgaas wrote:
> > Hi Michael,
> > 
> > On Tue, Mar 08, 2016 at 04:34:41PM -0600, Michael Auchter wrote:
> > > Add a stub for pci_clear_master() for when CONFIG_PCI is not set,
> > > similar to what's done for pci_set_master().
> > 
> > Does this fix a problem?  If so, what is it?  Some driver that doesn't
> > build when CONFIG_PCI is not set?
> 
> I ran into a build failure caused by this not being defined while
> compile testing an out-of-tree driver with various configs. It seemed to
> me that the lack of a stub may have just been an oversight from when
> pci_clear_master() was added.
> 
> It looks like all in-tree users of pci_clear_master() correctly declare
> a dependency on PCI via Kconfig, so this doesn't really fix a problem,
> just makes pci_clear_master more symmetric with pci_set_master.

We define a lot of empty stubs when CONFIG_PCI is not set.  I'm not
sure all of them make sense, so I'm a little hesitant to add more.

If I had time, I think it would be really interesting to turn off
CONFIG_PCI, remove some of the existing stubs, and see what breaks.
Then we could look at the actual code and figure out whether the best
solution is to keep the stubs or to add CONFIG_PCI dependencies, add
CONFIG_PCI #ifdefs, etc.

Bjorn

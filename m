Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:48000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932108AbeBSUg7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 19 Feb 2018 15:36:59 -0500
Date: Mon, 19 Feb 2018 14:36:57 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
        George Cherian <gcherian@caviumnetworks.com>,
        George Cherian <george.cherian@cavium.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com, Jayachandran.Nair@cavium.com,
        Robert.Richter@cavium.com,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH] PCI: Add quirk for Cavium Thunder-X2 PCIe erratum #173
Message-ID: <20180219203657.GA48133@bhelgaas-glaptop.roam.corp.google.com>
References: <1517554846-16703-1-git-send-email-george.cherian@cavium.com>
 <2323301.ORZpb3hFRe@aspire.rjw.lan>
 <20180216203434.GC11014@bhelgaas-glaptop.roam.corp.google.com>
 <2858019.9TUCWsDpTB@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2858019.9TUCWsDpTB@aspire.rjw.lan>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Feb 19, 2018 at 12:21:56PM +0100, Rafael J. Wysocki wrote:
> On Friday, February 16, 2018 9:34:34 PM CET Bjorn Helgaas wrote:
> > On Fri, Feb 16, 2018 at 01:40:37PM +0100, Rafael J. Wysocki wrote:
> > > On Friday, February 16, 2018 12:39:00 AM CET Bjorn Helgaas wrote:
<snip>

> > > > My questions are basically "What does the PCI core need to do
> > > > to make sure a device is in D0 before it operates on it?  And
> > > > where do we need to do that?"
> > > > 
> > > > > Unused ports are autosuspended after 100ms as per
> > > > > pcie_portdrv_probe().
> > > > 
> > > > So I guess this is only done for PCIe bridges, not for
> > > > conventional PCI bridges.  Is this because autosuspend depends
> > > > on a PCIe-only feature?
> > > 
> > > Yes, that's PCIe-only.
> > 
> > What PCIe feature does this depend on?
> 
> It doesn't depend on any PCIe feature in particular, but we don't
> need to do it for PCI-to-PCI bridges in general.
> 
> > I see the PCIe test in pci_bridge_d3_possible(), added by
> > 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend"), but
> > unfortunately that commit doesn't say *why* we only do this for
> > PCIe, or only for BIOS dates of 2015 or newer.
> 
> The reason why we need this is related to deep low-power states on
> new SoCs that only can be entered if PCIe root ports are in D3 (that
> is, if the root ports are not in D3, the whole SoC cannot enter some
> of its deep low-power states and that may exted to package C-states
> for processors).
> 
> That also is the reason why we do it for PCIe only.
> 
> The reason for the cut-off date is because we know it for a fact
> that PCIe port PM doesn't work on some older platforms due to
> hardware issues and, again, it only really needs to be done on
> recent SoCs.
> 
> I believe that all of the above was mentioned during discussions on
> the patches that ended up as commit 9d26d3a8f1b0 and so on.

OK.  I should have made sure more of this was captured in the code
comments.  The code doesn't match the spec and unless you happen to
remember all that history, you'd have no idea why, which makes
maintenance a bit of a hassle.  I'll propose a patch to add some
comments.

Bjorn

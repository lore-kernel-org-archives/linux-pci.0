Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:41448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933237AbcK3SBw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 30 Nov 2016 13:01:52 -0500
Date: Wed, 30 Nov 2016 12:01:43 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: David Daney <ddaney@caviumnetworks.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        David Daney <david.daney@cavium.com>
Subject: Re: Ping: [PATCH] PCI/ASPM: Don't retrain link if ASPM not possible.
Message-ID: <20161130180143.GC13411@bhelgaas-glaptop.roam.corp.google.com>
References: <1479421501-31029-1-git-send-email-ddaney.cavm@gmail.com>
 <583F082F.1010701@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <583F082F.1010701@caviumnetworks.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi David,

On Wed, Nov 30, 2016 at 09:11:11AM -0800, David Daney wrote:
> On 11/17/2016 02:25 PM, David Daney wrote:
> >From: David Daney <david.daney@cavium.com>
> >
> >Some (defective) PCIe devices are not able to reliably do link
> >retraining.
> >
> >Check to see if ASPM is possible between link partners before
> >configuring common clocking, and doing the resulting link retraining.
> >If ASPM is not possible, there is no reason to risk losing access to a
> >device due to an unnecessary link retraining.
> >
> 
> Hi Bjorn,
> 
> It has been a couple of weeks since I originally sent this, and I
> wanted to know if you have had a chance to look at it.  If possible,
> it would be nice to consider for the approaching merge window.

Yes, definitely.  I haven't had a chance yet, but I hope to.  Right
now my top priority is getting the arm64 ECAM quirks in for v4.10.
Once that's settled I'll come back and pick up some of these fixes.

Bjorn

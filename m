Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:48408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751933AbdBIQGo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 9 Feb 2017 11:06:44 -0500
Date: Thu, 9 Feb 2017 09:09:50 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bart Van Assche <bart.vanassche@sandisk.com>,
        Christoph Hellwig <hch@lst.de>,
        Yinghai Lu <yinghai@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Keith Busch <keith.busch@intel.com>
Subject: Re: [GIT PULL] PCI fixes for v4.10
Message-ID: <20170209150950.GA11905@bhelgaas-glaptop.roam.corp.google.com>
References: <20170208192054.GA31395@bhelgaas-glaptop.roam.corp.google.com>
 <20170208192256.GB31395@bhelgaas-glaptop.roam.corp.google.com>
 <20170209040648.GA1304@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170209040648.GA1304@wunner.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Ashok, Keith]

On Thu, Feb 09, 2017 at 05:06:48AM +0100, Lukas Wunner wrote:
> On Wed, Feb 08, 2017 at 01:22:56PM -0600, Bjorn Helgaas wrote:
> > Bjorn Helgaas (1):
> >       Revert "PCI: pciehp: Add runtime PM support for PCIe hotplug ports"
> 
> What's the rationale for reverting this?
> 
> You've received patches to fix the issue on both affected machines,
> so a revert seems unnecessary:
> 
> https://patchwork.kernel.org/patch/9557113/
> https://patchwork.kernel.org/patch/9562007/

I don't think we've gotten to the root cause of the problem yet,
and I don't want to throw in fixes at the last minute without a better
understanding of it.

PCIe hotplug hardware is not very complicated, it hasn't changed in
many years, and at least for the Intel hardware in question, is
generally pretty well-tested with Windows.  So I want to be careful
about asserting that this new piece of hardware is broken.

I think pciehp is unnecessarily complicated, and we do have known
synchronization issues with it, e.g., [1] [2].  It seems possible that
if we poked a little deeper, we would find that the hardware is
actually working correctly and the real problem is in pciehp.

That's why I've been trying to have a conversation about how we
interpret the spec and how we could remove PM and pciehp from the
picture and experiment directly with setpci.

[1] https://lkml.kernel.org/r/1481317564-18045-1-git-send-email-ashok.raj@intel.com
[2] https://bugzilla.kernel.org/show_bug.cgi?id=117561

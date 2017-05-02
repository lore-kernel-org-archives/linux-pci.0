Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:56824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751362AbdEBStB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 2 May 2017 14:49:01 -0400
Date: Tue, 2 May 2017 13:48:47 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Sinan Kaya <okaya@codeaurora.org>,
        "Raj, Ashok" <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>
Subject: Re: [GIT PULL] PCI fixes for v4.10
Message-ID: <20170502184847.GA28577@bhelgaas-glaptop.roam.corp.google.com>
References: <20170208192054.GA31395@bhelgaas-glaptop.roam.corp.google.com>
 <20170208192256.GB31395@bhelgaas-glaptop.roam.corp.google.com>
 <20170209040648.GA1304@wunner.de>
 <20170209150950.GA11905@bhelgaas-glaptop.roam.corp.google.com>
 <20170209182328.GB77900@otc-nc-03>
 <20170209184613.GA78375@otc-nc-03>
 <20170502015405.GA13918@wunner.de>
 <65f46b49-950a-270f-8bc4-c3fb7513866e@codeaurora.org>
 <20170502104929.GA14029@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170502104929.GA14029@wunner.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 02, 2017 at 12:49:29PM +0200, Lukas Wunner wrote:
> On Mon, May 01, 2017 at 10:41:20PM -0400, Sinan Kaya wrote:
> > On 5/1/2017 9:54 PM, Lukas Wunner wrote:
> > > (b) ASPM L1 enabled on boot, but disabled after powering off and back on
> > >     => I believe Sinan is working on this (+cc).
> > 
> > The decision was made not to touch ASPM registers following hotplug insertion
> > unless pcie_aspm.policy=powersave is specified.
> > 
> > The discussion is here: https://lkml.org/lkml/2017/4/17/255
> > 
> > This was done to maintain existing behavior and not break things.
> 
> Thanks for the reference, I hadn't followed the discussion in April
> very closely, but I think the outcome of the discussion is unfortunate.
> 
> As can be seen in Ashok's tests, merely turning slot power off and back
> on is sufficient to end up with a setting that draws more power.  That
> may be equally surprising for users as the issues would be that we seek
> to avoid with a "safety-first" ASPM policy.  In any case it seems
> undesirable.
> 
> I hope this is not the end if it and would like to encourage you to
> keep working on this.  Perhaps it is too simple to just define a
> default policy, and what is really needed is a policy that adjusts
> itself dynamically to specific devices or workloads, or that can be
> influenced by device drivers.

It's not the end of the discussion.  If you have an alternate
proposal, we'd love to hear it, especially if you implement it.

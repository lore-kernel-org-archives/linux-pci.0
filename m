Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qt0-f174.google.com ([209.85.216.174]:33760 "EHLO
        mail-qt0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388088AbeGWXSD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 23 Jul 2018 19:18:03 -0400
Received: by mail-qt0-f174.google.com with SMTP id c15-v6so2288438qtp.0
        for <linux-pci@vger.kernel.org>; Mon, 23 Jul 2018 15:14:45 -0700 (PDT)
Date: Mon, 23 Jul 2018 15:14:39 -0700
From: Jakub Kicinski <jakub.kicinski@netronome.com>
To: Tal Gilboa <talgi@mellanox.com>
Cc: Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "keith.busch@intel.com" <keith.busch@intel.com>,
        "alex_gagniuc@dellteam.com" <alex_gagniuc@dellteam.com>,
        "austin_bolen@dell.com" <austin_bolen@dell.com>,
        "shyam_iyer@dell.com" <shyam_iyer@dell.com>,
        "jeffrey.t.kirsher@intel.com" <jeffrey.t.kirsher@intel.com>,
        "ariel.elior@cavium.com" <ariel.elior@cavium.com>,
        "michael.chan@broadcom.com" <michael.chan@broadcom.com>,
        "ganeshgr@chelsio.com" <ganeshgr@chelsio.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "alexander.deucher@amd.com" <alexander.deucher@amd.com>,
        "mike.marciniszyn@intel.com" <mike.marciniszyn@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5] PCI: Check for PCIe downtraining conditions
Message-ID: <20180723151439.50524a2a@cakuba.netronome.com>
In-Reply-To: <b9a6b3b8-56cf-8bb5-2568-071ccd8a4f28@mellanox.com>
References: <20180718215359.GG128988@bhelgaas-glaptop.roam.corp.google.com>
        <20180723200339.23943-1-mr.nuke.me@gmail.com>
        <20180723140143.1a46902f@cakuba.netronome.com>
        <b9a6b3b8-56cf-8bb5-2568-071ccd8a4f28@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 24 Jul 2018 00:52:22 +0300, Tal Gilboa wrote:
> On 7/24/2018 12:01 AM, Jakub Kicinski wrote:
> > On Mon, 23 Jul 2018 15:03:38 -0500, Alexandru Gagniuc wrote:  
> >> PCIe downtraining happens when both the device and PCIe port are
> >> capable of a larger bus width or higher speed than negotiated.
> >> Downtraining might be indicative of other problems in the system, and
> >> identifying this from userspace is neither intuitive, nor
> >> straightforward.
> >>
> >> The easiest way to detect this is with pcie_print_link_status(),
> >> since the bottleneck is usually the link that is downtrained. It's not
> >> a perfect solution, but it works extremely well in most cases.
> >>
> >> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
> >> ---
> >>
> >> For the sake of review, I've created a __pcie_print_link_status() which
> >> takes a 'verbose' argument. If we agree want to go this route, and update
> >> the users of pcie_print_link_status(), I can split this up in two patches.
> >> I prefer just printing this information in the core functions, and letting
> >> drivers not have to worry about this. Though there seems to be strong for
> >> not going that route, so here it goes:  
> > 
> > FWIW the networking drivers print PCIe BW because sometimes the network
> > bandwidth is simply over-provisioned on multi port cards, e.g. 80Gbps
> > card on a x8 link.
> > 
> > Sorry to bike shed, but currently the networking cards print the info
> > during probe.  Would it make sense to move your message closer to probe
> > time?  Rather than when device is added.  If driver structure is
> > available, we could also consider adding a boolean to struct pci_driver
> > to indicate if driver wants the verbose message?  This way we avoid
> > duplicated prints.
> > 
> > I have no objection to current patch, it LGTM.  Just a thought.  
> 
> I don't see the reason for having two functions. What's the problem with 
> adding the verbose argument to the original function?

IMHO it's reasonable to keep the default parameter to what 90% of users
want by a means on a wrapper.  The non-verbose output is provided by
the core already for all devices.

What do you think of my proposal above Tal?  That would make the extra
wrapper unnecessary since the verbose parameter would be part of the
driver structure, and it would avoid the duplicated output.

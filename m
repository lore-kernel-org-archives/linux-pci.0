Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:33390 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752237AbbHTVVQ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 20 Aug 2015 17:21:16 -0400
Received: by padfo6 with SMTP id fo6so30540340pad.0
        for <linux-pci@vger.kernel.org>; Thu, 20 Aug 2015 14:21:16 -0700 (PDT)
Date: Thu, 20 Aug 2015 16:21:09 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: David Miller <davem@davemloft.net>
Cc: wangyijing@huawei.com, linux-pci@vger.kernel.org, mroos@linux.ee,
	sparclinux@vger.kernel.org, eric.snowberg@oracle.com,
	benh@kernel.crashing.org
Subject: Re: [PATCH] PCI/ASPM: Fix a NULL pointer crash on sparc64
Message-ID: <20150820212109.GB14810@google.com>
References: <CAErSpo5SApFYWOs8Q2ZH2vpnEW6jY0XWAgeiyhMk4aCNtON46w@mail.gmail.com>
 <20150820.114042.1327127338658980319.davem@davemloft.net>
 <20150820202135.GA14810@google.com>
 <20150820.135832.47467691959908917.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150820.135832.47467691959908917.davem@davemloft.net>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 20, 2015 at 01:58:32PM -0700, David Miller wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> Date: Thu, 20 Aug 2015 15:21:35 -0500
> 
> > On Thu, Aug 20, 2015 at 11:40:42AM -0700, David Miller wrote:
> >> From: Bjorn Helgaas <bhelgaas@google.com>
> >> Date: Thu, 20 Aug 2015 11:23:43 -0700
> >> 
> >> > On Thu, Aug 20, 2015 at 10:47 AM, David Miller <davem@davemloft.net> wrote:
> >> >> From: Bjorn Helgaas <bhelgaas@google.com>
> >> >> Date: Thu, 20 Aug 2015 00:48:00 -0500
> >> >>
> >> >>> [+cc Dave, Eric, Ben, sparclinux]
> >> >>
> >> >> I think the comment is terrible.
> >> > 
> >> > I'll update the comment if you suggest some text.  Do you object
> >> > mainly to the mention of the specific systems?
> >> 
> >> "PCI root complex can not be assumed to be instantiated in the PCI bus
> >>  hierarchy."
> > 
> > AIUI, the root complex itself (as distinct from root ports) doesn't
> > normally appear in the PCI hierarchy, so I reworded it as follows.  I hope
> > this helps address your objection, but if not, I can try again.
> 
> This is fine, but it was the comment we were talking about adjusting not
> the commit message :-)

Oh, sorry!  I totally misread that.  Here's another try.

commit 27ff9f3e0ab34a75a3420bffd3eb5316de2e4d92
Author: Yijing Wang <wangyijing@huawei.com>
Date:   Mon Aug 17 18:47:58 2015 +0800

    PCI: Tolerate hierarchies with no Root Port
    
    We should not assume any particular hardware topology.  Commit d0751b98dfa3
    ("PCI: Add dev->has_secondary_link to track downstream PCIe links") relied
    on the assumption that every PCIe hierarchy is rooted at a Root Port.  But
    we can't rely on any assumption about what hardware we will find; we just
    have to deal with the world as it is.
    
    On some platforms, PCIe devices (endpoints, switch upstream ports, etc.)
    appear directly on the root bus, and there is no Root Port in the PCI bus
    hierarchy.  For example, Meelis observed these top-level devices on a
    Sparc V245:
    
      0000:02:00.0 PCI bridge to [bus 03-0d]    Switch Upstream Port
      0001:02:00.0 PCI bridge to [bus 03]       PCIe to PCI/PCI-X Bridge
    
    These devices *look* like they have links going upstream, but there really
    are no upstream devices.
    
    In set_pcie_port_type(), we used the parent device to figure out which side
    of a switch port has a link, so if the parent device did not exist, we
    dereferenced a NULL parent pointer.
    
    Check whether the parent device exists before dereferencing it.
    
    Meelis observed this oops on Sparc V245 and T2000.  Ben Herrenschmidt says
    this is also possible on IBM PowerVM guests on PowerPC.
    
    [bhelgaas: changelog, comment]
    Link: http://lkml.kernel.org/r/alpine.LRH.2.20.1508122118210.18637@math.ut.ee
    Reported-by: Meelis Roos <mroos@linux.ee>
    Tested-by: Meelis Roos <mroos@linux.ee>
    Signed-off-by: Yijing Wang <wangyijing@huawei.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index cefd636..b978bbf 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -997,7 +997,12 @@ void set_pcie_port_type(struct pci_dev *pdev)
 	else if (type == PCI_EXP_TYPE_UPSTREAM ||
 		 type == PCI_EXP_TYPE_DOWNSTREAM) {
 		parent = pci_upstream_bridge(pdev);
-		if (!parent->has_secondary_link)
+
+		/*
+		 * Usually there's a parent device (Root Port or Switch
+		 * Downstream Port), but we can't assume one exists.
+		 */
+		if (parent && !parent->has_secondary_link)
 			pdev->has_secondary_link = 1;
 	}
 }

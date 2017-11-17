Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lf0-f49.google.com ([209.85.215.49]:45167 "EHLO
        mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932731AbdKQM72 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Nov 2017 07:59:28 -0500
Date: Fri, 17 Nov 2017 13:59:24 +0100
From: Johan Hovold <johan@kernel.org>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Johan Hovold <johan@kernel.org>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable <stable@vger.kernel.org>
Subject: Re: [PATCH] PCI: keystone: fix interrupt-controller-node lookup
Message-ID: <20171117125924.GA3339@localhost>
References: <20171112122850.30804-1-johan@kernel.org>
 <20171117111910.GA21148@red-moon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171117111910.GA21148@red-moon>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Nov 17, 2017 at 11:19:10AM +0000, Lorenzo Pieralisi wrote:
> Hi Johan,
> 
> On Sun, Nov 12, 2017 at 01:28:50PM +0100, Johan Hovold wrote:
> > Fix child-node lookup during initialisation, which ended up searching
> > the whole device tree depth-first starting at the parent rather than
> > just matching on its children.
> > 
> > To make things worse, the parent pci node was prematurely freed, while
> > the child interrupt-controller node was leaked.
> 
> I think you should explain that of_find_node_by_name() drops a reference
> to the from pointer, it is not clear from the log.

Sure, I'll amend the log.

> More importantly: are you saying that all of_find_node_by_name() usages
> with a (from* != NULL) are broken unless they bump up the from node (if
> != NULL) ref count ?
> 
> Is there a reason why of_find_node_by_name() behaviour can't be changed ?

The problem here is that this driver is using the wrong helper; 
of_find_node_by_name() is used for tree-wide searches, and for which its
semantics makes sense. Here we only want to match on child nodes, and
then of_get_child_by_name() is what you need to use.

We had some 10-20 drivers that were using the wrong helper and which I've
now fixed up. I'm gonna see about amending the kernel docs to minimise
the risk of these bugs from reoccurring further.

> > Fixes: 0c4ffcfe1fbc ("PCI: keystone: Add TI Keystone PCIe driver")
> > Cc: stable <stable@vger.kernel.org>     # 3.18
> 
> Do we really want to send this to stable kernels straight away ?
> 
> There is not any specific bug report - it should be safe but I
> wanted to ask.

The unbalanced put can lead to some nasty use-after-free issues (e.g.
after a couple of probe deferrals). But feel to free to drop the stable
tags if you deem this to be safe for this particular driver (most of the
other fixes have gone in with a stable tag).

> > Cc: Murali Karicheri <m-karicheri2@ti.com>
> > ---
> >  drivers/pci/dwc/pci-keystone.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> With an update log:
> 
> Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

Thanks for the ack. I'll respin a v2 with an updated commit message.

Johan

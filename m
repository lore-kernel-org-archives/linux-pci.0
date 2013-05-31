Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp09.au.ibm.com ([202.81.31.142]:48220 "EHLO
	e23smtp09.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751451Ab3EaBwi (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 30 May 2013 21:52:38 -0400
Received: from /spool/local
	by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Fri, 31 May 2013 22:49:38 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
	by d23dlp01.au.ibm.com (Postfix) with ESMTP id A54CD2CE8052
	for <linux-pci@vger.kernel.org>; Fri, 31 May 2013 11:52:30 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id r4V1c2P627721852
	for <linux-pci@vger.kernel.org>; Fri, 31 May 2013 11:38:02 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id r4V1qTWN013886
	for <linux-pci@vger.kernel.org>; Fri, 31 May 2013 11:52:29 +1000
Date: Fri, 31 May 2013 09:52:27 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org, Ram Pai <linuxram@us.ibm.com>
Cc: bhelgaas@google.com
Subject: One question about the pci_assign_unassign_resources()
Message-ID: <20130531015226.GA5900@weiyang.vnet.ibm.com>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

All experts,

Sorry for disturbing all of you. I met a confusion in the 
pci_assign_unassign_resources(). 

Below is the code snippet in pci_assign_unassign_resources():

	/* restore size and flags */
	list_for_each_entry(fail_res, &fail_head, list) {
		struct resource *res = fail_res->res;

		res->start = fail_res->start;
		res->end = fail_res->end;
		res->flags = fail_res->flags;
		if (fail_res->dev->subordinate)
			res->flags = 0;      <---- here
	}

This happens when there is some fail resources and try to restore them, and
prepare for the next round assignment.
My confusion is at the last line. When this resource is from a bridge, set the
flags to 0.

When a resource comes from a bridge, it has two possibilities:
1. the BAR of itself, dev->resource[0-1]
2. the io window for children, 
   dev->resource[PCI_BRIDGE_RESOURCES, PCI_BRIDGE_RESOURCES+PCI_BRIDGE_RESOURCE_NUM]

For case 1, this will disable the bridge's BAR.
    So in next round, the resource form this bridge will not be assigned.
For case 2, this will disable the io window for its children.
    In this case, sounds the children of this bridge can't get resource from
    this window.

Let's take a look at the effect in another aspect. There two phase in the
function pci_assign_unassign_resources(), 1. sizing 2. assigning.

1. In the sizing stage:
   For an individual resource, when its flags is 0, the bridge window will not
   count in its contribution.

   For a bridge resource, if its flags is set to 0, its children can't find a
   proper parent resource. For example, if the bridge's IOMEM window's flags
   is set to 0, sounds all the children's IOMEM resource wouldn't count in.

2. In the assigning stage:
   For an individual resource, ok, the pci core won't try to request resource
   for it. Then this means the resource will not be enabled.

   For a bridge resource, if its flags is set to 0, its children can't find
   available resource from it.

If my understanding is correct, let's take a look at one scenario.

                            +---------+
                            |P2P      |
                            +----+----+
                                 |
                                 |
        -----+-------------------+------------------------+-----
             |                   |                        |
        +----+-------+     +-----+-----+           +------+-----+
        |DEV0        |     |DEV1       |           |DEV2        |
        +------------+     +-----------+           +------------+

There are three devices under one P2P bridge. All of them want IOMEM resource. 
But in the first round, DEV0 and DEV1 get enough resource but DEV2 failed to
get its IOMEM resource. 

>From the code point of view, then it will try to disable the IOMEM window on
the P2P bridge? Then in the next round non of them will be given IOMEM
resource?

Or I missed something? 

Thanks for your comments in advance.

-- 
Richard Yang
Help you, Help me


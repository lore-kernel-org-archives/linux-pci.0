Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44741 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750884AbbKHX2k (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sun, 8 Nov 2015 18:28:40 -0500
Message-ID: <563FDAA6.1010305@redhat.com>
Date: Sun, 08 Nov 2015 18:28:38 -0500
From: Prarit Bhargava <prarit@redhat.com>
MIME-Version: 1.0
To: Mathias Krause <minipli@googlemail.com>,
	Bjorn Helgaas <bhelgaas@google.com>
CC: linux-pci@vger.kernel.org, Sasha Levin <sasha.levin@oracle.com>
Subject: Re: [PATCH] PCI: Prevent out of bounds access in numa_node override
 - part 2
References: <1447003444-27108-1-git-send-email-minipli@googlemail.com>
In-Reply-To: <1447003444-27108-1-git-send-email-minipli@googlemail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 11/08/2015 12:24 PM, Mathias Krause wrote:
> Commit 1266963170f5 ("PCI: Prevent out of bounds access in numa_node
> override") missed that the user provided node could also be negative.
> Handle this case as well to really avoid out-of-bounds accesses to
> the node_states[] array.

No, this is incorrect.  More often than not, numa_node is -1 for NUMA_NO_NODE
which is often interpreted in the kernel as "any numa node".

[root@intel-brickland-04 pci0000:ff]# find ./ -name *numa_node* | xargs egrep ^
| egrep "\-1" | wc -l
92

Can you point to the code that does node_states[pci_dev->numa_node] without
doing a bounds check?  IMO that's the code that is broken.

FWIW: I think the idea of your patch is still correct.  Checking for -1 to
MAX_NUMNODES is not a bad idea.

P.

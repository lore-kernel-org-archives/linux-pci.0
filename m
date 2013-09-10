Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:34825 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750758Ab3IJKZW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 10 Sep 2013 06:25:22 -0400
Message-ID: <1378808696.4121.9.camel@pasglop>
Subject: Re: [PATCH 1/3] PCI: use pci_is_root_bus() to check whether it is a
 root bus
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Alex Chiang <achiang@canonical.com>
Date: Tue, 10 Sep 2013 20:24:56 +1000
In-Reply-To: <20130910074611.GA11724@weiyang.vnet.ibm.com>
References: <1378431958-7874-1-git-send-email-weiyang@linux.vnet.ibm.com>
	 <20130906230941.GC12956@google.com>
	 <20130909070017.GB3726@weiyang.vnet.ibm.com>
	 <CAErSpo5BTV_b1NpeifuAPwHvfsrAERpdmwgnUFMS6gQ3Asik-Q@mail.gmail.com>
	 <20130910074611.GA11724@weiyang.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 2013-09-10 at 15:46 +0800, Wei Yang wrote:
> On some platforms, like powernv, each pci-dev has a dev-tree node to represent
> it. The dev-tree node is set by pci_set_of_node() during pci_scan_device().
> 
> In pci_set_of_node(), it searchs for the node with the same devfn in its
> parent. Here comes the question, who should be the VF's parent. Would be a
> conflict for the devfn between PF and VF?

I think it makes no sense to create OFW nodes for VFs under powernv anyway ...

(which is another reason why we need urgently to disconnect the EEH data
from the device node ...)

Cheers,
Ben.



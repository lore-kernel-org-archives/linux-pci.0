Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1on0136.outbound.protection.outlook.com ([157.56.110.136]:63296
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S933950AbaKLBhY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 11 Nov 2014 20:37:24 -0500
From: Jake Oshins <jakeo@microsoft.com>
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Sorting out terminology
Date: Wed, 12 Nov 2014 01:04:38 +0000
Message-ID: <863202fec7e0428682edf682c27beb2b@DM2PR03MB592.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

First, let me introduce myself.  I'm Jake Oshins, and I've been working on Hyper-V and other things at Microsoft for a while.  I'm currently trying to create a front-end driver for Linux running on top of Hyper-V that will enable PCI pass-through, to enable SR-IOV networking, and perhaps some other things over time.  This is similar in form to the "Xen front" PCI implementation, but the specifics are different.

Second, let me say that I'd appreciate any response to my query, and I'm perfectly happy to search the archives associated with this list, or others.  But it's clear to me that I don't yet have the terminology that would allow me to narrow my searches.  So if you all could point me in the right direction, if only by telling me "search for posts that contain these words, and probably these people," I would be grateful.

With that out of the way, I'm currently struggling with two topics.  First, I can see how to create a root PCI bus, and I can see how to do that in response to events coming in through paravirtual channels.  What's not clear to me is whether there is a way to tear down a root PCI bus after it has been created.  The most natural implementation for me would be to create a root PCI bus whenever a PCI device is offered to the guest VM, tearing down that root bus when the device is removed from the VM.  Would I be better off creating one "fake" root PCI bus that lives forever and placing functions beneath that?  (This seems more complicated to me, unless there's no way to tear down a root.)

Also on the topic of adding root buses, I can see that when creating a root bus, I should supply a resource list.  My question is two-part.  First, can I set this up so that the root PCI buses themselves don't contain any resources at all, with the children's allocations coming from the (ACPI-based) parent?  Or do I have to partition the address space so that each root bus contains its own regions?  Second, assuming that I have to partition the address space, allocating discretely to each root PCI bus, is there some protocol for changing the size of the allocation on the fly, and if so, where should I look to find that?  This is analogous to the physical world, where a root port's bridge windows might need to be changed to accommodate a device with a really large requirement.

Thanks,
Jake Oshins



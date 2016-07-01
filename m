Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.134]:53286 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752316AbcGAOWb (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 1 Jul 2016 10:22:31 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Liviu Dudau <liviu.dudau@arm.com>
Cc: Thierry Reding <thierry.reding@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Tomasz Nowicki <tn@semihalf.com>, linux-pci@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH v2 1/2] PCI: Add new method for registering PCI hosts
Date: Fri, 01 Jul 2016 16:24:50 +0200
Message-ID: <6212651.41bebQZ9BM@wuerfel>
In-Reply-To: <20160701141447.GB8609@e106497-lin.cambridge.arm.com>
References: <20160630151931.29216-1-thierry.reding@gmail.com> <5307392.exoejlJp9x@wuerfel> <20160701141447.GB8609@e106497-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday, July 1, 2016 3:14:47 PM CEST Liviu Dudau wrote:
> 
> I'm confused. Why are we butchering the old pci_alloc_host_bridge() function
> to then go back and add re-add it in a different form?

Good point, we could just keep the existing implementation and make it
an exported function without the bus argument.

> The old pci_alloc_host_bridge() was doing mostly what the above
> function does minus the bridge->private line. And the &bridge[1] construct
> could very well be pointing to the next struct pci_host_bridge aligned address,
> which means parts of priv area are ignored.

I don't know what you mean with that. Would you rather write this as?

	bridge->private = bridge + 1;

or leave it out and add a helper function

void *pci_host_bridge_private(struct pci_host_bridge *bridge)
{
	return &bridge[1];
}

or do you mean we should have extra alignment in there so the
private pointer has a minimum alignment higher than the
alignment of struct pci_host_bridge?

I'm absolutely fine with any of those suggestions, whichever
makes the nicest API.

	Arnd

Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.75]:60281 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751964AbcGAPXL (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 1 Jul 2016 11:23:11 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Liviu Dudau <liviu.dudau@arm.com>
Cc: Thierry Reding <thierry.reding@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Tomasz Nowicki <tn@semihalf.com>, linux-pci@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH v2 1/2] PCI: Add new method for registering PCI hosts
Date: Fri, 01 Jul 2016 17:17:11 +0200
Message-ID: <14945085.QO6LcyFgTY@wuerfel>
In-Reply-To: <20160701145244.GD8609@e106497-lin.cambridge.arm.com>
References: <20160630151931.29216-1-thierry.reding@gmail.com> <6212651.41bebQZ9BM@wuerfel> <20160701145244.GD8609@e106497-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday, July 1, 2016 3:52:44 PM CEST Liviu Dudau wrote:
> 
> > 
> > or do you mean we should have extra alignment in there so the
> > private pointer has a minimum alignment higher than the
> > alignment of struct pci_host_bridge?
> 
> but this ^. bridge pointer arithmetic means +1 is not necessarily +sizeof(struct pci_host_bridge)
> bytes. AFAIK that can be rounded to the nearest natural alignment for pointers on that
> architecture.

No, that's not how it works.

> > I'm absolutely fine with any of those suggestions, whichever
> > makes the nicest API.
> 
> Does anyone need to subclass the pci_host_bridge structure? And is appending data right
> after the structure useful?

I was basically following the way alloc_etherdev() and a lot of other
subsystems handle it.

	Arnd

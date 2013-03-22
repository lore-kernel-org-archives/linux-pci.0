Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fw-tnat.cambridge.arm.com ([217.140.96.21]:59298 "EHLO
	cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753658Ab3CVKCQ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 22 Mar 2013 06:02:16 -0400
Date: Fri, 22 Mar 2013 10:00:37 +0000
From: Andrew Murray <andrew.murray@arm.com>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Russell King <linux@arm.linux.org.uk>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"devicetree-discuss@lists.ozlabs.org"
	<devicetree-discuss@lists.ozlabs.org>,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Jason Cooper <jason@lakedaemon.net>,
	Arnd Bergmann <arnd@arndb.de>,
	Maen Suleiman <maen@marvell.com>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Olof Johansson <olof@lixom.net>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Mitch Bradley <wmb@firmworks.com>,
	Liviu Dudau <Liviu.Dudau@arm.com>
Subject: Re: [PATCH v5 01/17] of/pci: Provide support for parsing PCI DT
 ranges property
Message-ID: <20130322100037.GA1401@arm.com>
References: <1363887025-19931-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1363887025-19931-2-git-send-email-thomas.petazzoni@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1363887025-19931-2-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Mar 21, 2013 at 05:30:09PM +0000, Thomas Petazzoni wrote:
> From: Andrew Murray <Andrew.Murray@arm.com>
> 
> This patch factors out common implementations patterns to reduce overall kernel
> code and provide a means for host bridge drivers to directly obtain struct
> resources from the DT's ranges property without relying on architecture specific
> DT handling. This will make it easier to write archiecture independent host bridge
> drivers and mitigate against further duplication of DT parsing code.
> 
> This patch can be used in the following way:
> 
>         struct of_pci_range_iter iter;
>         for_each_of_pci_range(&iter, np) {
> 
>                 //directly access properties of the address range, e.g.:
>                 //iter.pci_space, iter.pci_addr, iter.cpu_addr, iter.size or
>                 //iter.flags
> 
>                 //alternatively obtain a struct resource, e.g.:
>                 //struct resource res;
>                 //range_iter_fill_resource(iter, np, res);
>         }
> 
> Additionally the implementation takes care of adjacent ranges and merges them
> into a single range (as was the case with powerpc and microblaze).
> 
> The modifications to microblaze, mips and powerpc have not been tested.
> 
> Signed-off-by: Andrew Murray <Andrew.Murray@arm.com>
> Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
> 
> Compared to the v2 sent by Andrew Murray, Thomas Petazzoni did:
> 
>  * Add a memset() on the struct of_pci_range_iter when starting the
>    for loop in for_each_pci_range(). Otherwise, with an uninitialized
>    of_pci_range_iter, of_pci_process_ranges() may crash.
> 
>  * Add parenthesis around 'res', 'np' and 'iter' in the
>    for_each_of_pci_range macro definitions. Otherwise, passing
>    something like &foobar as 'res' didn't work.
> 
>  * Rebased on top of 3.9-rc2, which required fixing a few conflicts in
>    the Microblaze code.
> 
The changes here against my v2 look good to me.

Acked-by: Andrew Murray <andrew.murray@arm.com>

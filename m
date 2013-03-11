Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from rs140.luxsci.com ([74.205.78.114]:54737 "EHLO rs140.luxsci.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750948Ab3CKTuM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 11 Mar 2013 15:50:12 -0400
Message-ID: <513E3536.2060104@firmworks.com>
Date: Mon, 11 Mar 2013 09:49:10 -1000
From: Mitch Bradley <wmb@firmworks.com>
MIME-Version: 1.0
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
CC: Thierry Reding <thierry.reding@avionic-design.de>,
	Lior Amsalem <alior@marvell.com>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>, linux-pci@vger.kernel.org,
	devicetree-discuss@lists.ozlabs.org,
	Eran Ben-Avi <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Maen Suleiman <maen@marvell.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 24/32] pci: PCIe driver for Marvell Armada 370/XP systems
References: <20130308191227.GA6551@avionic-0098.mockup.avionic-design.de> <513A3F4F.2090501@firmworks.com> <20130308200245.GC29435@obsidianresearch.com> <513A7845.6040304@firmworks.com> <20130309013152.GA3883@obsidianresearch.com> <513C117D.6080800@firmworks.com> <20130310065539.GA14704@obsidianresearch.com> <513D6F9C.9000100@firmworks.com> <20130311074615.GA6365@avionic-0098.mockup.avionic-design.de> <513E1CBA.4040007@firmworks.com> <20130311182339.GB10992@obsidianresearch.com>
In-Reply-To: <20130311182339.GB10992@obsidianresearch.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 3/11/2013 8:23 AM, Jason Gunthorpe wrote:
>> (b) The discovery/enumeration code needs to access config space via
>> pci_ops.  The root complex driver implements pci_ops based on a trivial
>> parsing of ranges (omitting irrelevant details):
>>
>> pci_op_read(devfn, pos) {
>>    loop_over_ranges_entries {
>>       if (to_devfn(ranges_entry.child) == devfn) {
>>          return mmio_read(ranges_entry.parent + pos);
>                             ^^^^^^^^^^^^^^^^^^^
> 
> This has to be converted through all enclosing node's ranges prior to
> being used as a CPU address - the OF core has all the code to do this,
> but a new entry point would be needed for this specific application...

Agreed.  But I was considering that detail to be outside the scope of
this discussion because the same thing must happen for any physical
address at this level of the tree.

> 
> Cheers,
> Jason
> 

Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:58283 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752004AbcCPTc2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 16 Mar 2016 15:32:28 -0400
Date: Wed, 16 Mar 2016 14:32:24 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Murali Karicheri <m-karicheri2@ti.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: PCI IO resource question.
Message-ID: <20160316193224.GB2703@localhost>
References: <56E987B8.1090904@ti.com>
 <20160316180936.GA7605@red-moon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160316180936.GA7605@red-moon>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Mar 16, 2016 at 06:09:36PM +0000, Lorenzo Pieralisi wrote:
> On Wed, Mar 16, 2016 at 12:20:08PM -0400, Murali Karicheri wrote:

> > [    0.420648] PCI host bridge /soc/pcie@21020000 ranges:
> > [    0.420659]   No bus range found for /soc/pcie@21020000, using [bus 00-ff]
> > [    0.420679]    IO 0x23260000..0x400023263fff -> 0x00000000
> > [    0.420685] Requested IO range too big, new size set to 64K
> > [    0.420702]   MEM 0x60000000..0x6fffffff -> 0x60000000
> > [    0.420713] keystone-pcie 21021000.pcie: error -22: failed to map resource [io  0x0000-0x400000003fff]
> 
> This unearthed an issue that we've got to fix. If the IO space remap
> fails (pci_remap_iospace()) we must remove the IO resource from the host
> bridge resources list, code below shows that we end up assigning IO space
> even if the remapping of the host bridge CPU physical address corresponding
> to IO space fails, which is wrong.
> 
> Do you want me to fix the host bridges concerned in one go ?

Yes, that looks like a real problem we should fix.

Bjorn

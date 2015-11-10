Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lhrrgout.huawei.com ([194.213.3.17]:63082 "EHLO
	lhrrgout.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751199AbbKJGUP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 10 Nov 2015 01:20:15 -0500
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: Arnd Bergmann <arnd@arndb.de>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
CC: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Will Deacon <will.deacon@arm.com>,
	"Wangzhou (B)" <wangzhou1@hisilicon.com>
Subject: RE: [PATCH] drivers: pci: remove unused pci_sys_data structures
Date: Tue, 10 Nov 2015 06:19:17 +0000
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E162A5EC2@lhreml503-mbs>
References: <1447095459-21777-1-git-send-email-lorenzo.pieralisi@arm.com>
 <7247058.o5kTvZ3CSC@wuerfel>
In-Reply-To: <7247058.o5kTvZ3CSC@wuerfel>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Arnd

[...]
> 
> Nice!
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> On the downside, I just saw how b3a72384fe29 ("ARM/PCI: Replace
> pci_sys_data->align_resource with global function pointer") manages
> to get rid of the last user of this, and how this is not the way
> we had planned for it to be done.
> 
> It doesn't matter that much, because there is only a single
> user of hw->align_resource, but this is now unportable code and
> cannot easily be separated from hw_pci. It also breaks if we ever
> get a machine with two different host controllers on ARM that
> don't use the same pointer here.
> 
> I really would have hoped we could put that function pointer
> into 'struct pci_host_bridge' instead, and eventually killed
> off the architecture specific pcibios_align_resource function
> as well.

say we move that in pci_host_bridge struct,

Are you suggesting to modify pcibios_init_hw to assign the 
align_resource function pointer at the end after
pci_scan_root_bus_msi() has created the host bridge structure;
then we can retrieve it in pcibios_align_resource using
pci_find_host_bridge(dev->bus)....?

> 
> Any idea why it was done with a global function pointer for
> ARM rather than a proper solution?

Well just because I didn't think about the solution above...

If you think the above one can work I can send out another
patch to fix this...

Many Thanks

Gab


> 
> 	Arnd

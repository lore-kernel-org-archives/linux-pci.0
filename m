Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:50078 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751793AbbKITLT (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 9 Nov 2015 14:11:19 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Will Deacon <will.deacon@arm.com>,
	Gabriele Paoloni <gabriele.paoloni@huawei.com>,
	Zhou Wang <wangzhou1@hisilicon.com>
Subject: Re: [PATCH] drivers: pci: remove unused pci_sys_data structures
Date: Mon, 09 Nov 2015 20:07:53 +0100
Message-ID: <7247058.o5kTvZ3CSC@wuerfel>
In-Reply-To: <1447095459-21777-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1447095459-21777-1-git-send-email-lorenzo.pieralisi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Monday 09 November 2015 18:57:39 Lorenzo Pieralisi wrote:
> Commit b3a72384fe29 ("ARM/PCI: Replace pci_sys_data->align_resource
> with global function pointer") removed the struct pci_sys_data
> dependency from the ARM pcibios functions that are part of the
> common ARM PCI arch back-end (eg pcibios_align_resource()), so that
> struct pci_sys_data has now become data that is only used internally
> by the ARM bios32 layer (ie pci_common_init_dev()) and by host
> controllers drivers callbacks (eg pci_sys_data.setup) that rely on the
> ARM bios32 API to probe.
> 
> PCI host controller drivers that do not rely on ARM bios32 calls to
> probe do not need to have the pci_bus.sysdata pointer field pointing
> at a struct pci_sys_data anymore, therefore it can be removed from the
> respective drivers data structures.
> 
> This patch removes the pci_sys_data structures from the host
> controller drivers that do not rely on ARM bios32 interface to
> scan the PCI bus, completing the pci_sys_data clean-up and removing
> the related dependency on arch/arm specific data.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Rob Herring <robh@kernel.org>
> 

Nice!

Acked-by: Arnd Bergmann <arnd@arndb.de>

On the downside, I just saw how b3a72384fe29 ("ARM/PCI: Replace
pci_sys_data->align_resource with global function pointer") manages
to get rid of the last user of this, and how this is not the way
we had planned for it to be done.

It doesn't matter that much, because there is only a single
user of hw->align_resource, but this is now unportable code and
cannot easily be separated from hw_pci. It also breaks if we ever
get a machine with two different host controllers on ARM that
don't use the same pointer here.

I really would have hoped we could put that function pointer
into 'struct pci_host_bridge' instead, and eventually killed
off the architecture specific pcibios_align_resource function
as well.

Any idea why it was done with a global function pointer for
ARM rather than a proper solution?

	Arnd

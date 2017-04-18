Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.133]:33853 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756456AbdDRJph (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Apr 2017 05:45:37 -0400
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Question about max bus number for PCIe root bridge
Message-ID: <aee3cf45-382b-0e18-72fe-b4078aabc409@rock-chips.com>
Date: Tue, 18 Apr 2017 17:45:27 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

Sorry to bother you. :)

pcie-rockchip uses of_pci_get_host_bridge_resources to assign the
maximum number of buses for the root bridge. Currently we set it to
be 0xff. Now we have a PCIe switch connected to the root port. However,
when enumerating the topology, I see it panic down to:

[    0.502875] PCI host bridge /pcie@f8000000 ranges:
[    0.502905]   MEM 0xfa000000..0xfa5fffff -> 0xfa000000
[    0.502921]    IO 0xfa600000..0xfa6fffff -> 0xfa600000
[    0.503168] rockchip-pcie f8000000.pcie: PCI host bridge to bus 0000:00
[    0.503189] pci_bus 0000:00: root bus resource [bus 00-10]
[    0.503204] pci_bus 0000:00: root bus resource [mem 
0xfa000000-0xfa5fffff]
[    0.503221] pci_bus 0000:00: root bus resource [io  0x0000-0xfffff] 
(bus address [0xfa600000-0xfa6fffff])
[    0.503598] pci 0000:00:00.0: bridge configuration invalid ([bus 
00-00]), reconfiguring
[    0.504104] pci 0000:01:00.0: bridge configuration invalid ([bus 
00-00]), reconfiguring
[    0.515549] pci 0000:02:00.0: bridge configuration invalid ([bus 
02-ff]), reconfiguring

.....

[    0.695096] pci 0000:1f:00.0: bridge configuration invalid ([bus 
1f-ff]), reconfiguring
[    0.695242] bus->number = 0x20, PCI_SLOT(devfn) = 0x0 
PCI_FUNC(devfn) = 0x0, where = 0x0
[    0.695255] busdev = 0x2000000
[    0.695270] Unable to handle kernel paging request at virtual address 
ffffff8012000000
[    0.858703] pgd = ffffff8009319000
[    0.859004] [ffffff8012000000] *pgd=00000000f7ffe003, 
*pud=00000000f7ffe003, *pmd=0000000000000000
[    0.859803] Internal error: Oops: 96000006 [#1] PREEMPT SMP
[    0.860292] Modules linked in:

We only have the axi address range from 0xf8000000 to 0xfa000000
defined in the DT. So the max bus resource is 0x2000000. The PCI
core was trying to scan the bus whose bus number is 0x20. So the bus
resource calculated by PCIE_ECAM_ADDR is larger than what we have. Now
I change the max bus number to 0x10 by modifying the third argument of
of_pci_get_host_bridge_resources . But I still see the PCI core are
trying to scan the bus whose bus numbers are larger than the
limitation, namely 0x10.

So my question is:

what is the meaning of "maximum number of buses for this bridge", the
comment before of_pci_get_host_bridge_resources. In my case, isn't it
applied to the bridge connected to the root port?

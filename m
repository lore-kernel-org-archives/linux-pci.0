Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail1.windriver.com ([147.11.146.13]:51071 "EHLO
	mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754244Ab3EYLhC (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 25 May 2013 07:37:02 -0400
From: Kevin Hao <haokexin@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>
Subject: [PATCH v2 0/3] fix the pci device malfunction if a wrong bus address is assigned by firmware
Date: Sat, 25 May 2013 19:36:24 +0800
Message-ID: <1369481787-21500-1-git-send-email-haokexin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

v2:
 * Use the method suggested by Bjorn to check if we have a wrong bus address
   set in the PCI BAR register.
 * Split the "move the pcibios_bus_to_resource() call out of the if/else wrap"
   change into a new patch.
 * A minor new patch is introduced to add 0x prefix for the PCI BAR register
   position.

v1:
On a fsl p2020rdb-pc board, the onboard pci device is assigned the bus address
0xa0000000 by firmware. But the kernel allocate the cpu address 0xa0000000 ~ 0xbfffffff
to this PCIe controller and use 0xe0000000 ~ 0xdfffffff as its bus address.
In this case the kernel would think that the bus address in this pci device
is correct and leave it unchanged. Then causes this device not work.

Even though this looks like a mismatch of the address space between firmware
and kernel. I think we should detect this kind of error and fix it automatically
if we don't want just to probe only (PCI_PROBE_ONLY is not set).

---
Kevin Hao (3):
  PCI: add 0x prefix when printing the BAR registers position in    
    __pci_read_base
  PCI: converge the unnecessary sprinkling of pcibios_bus_to_resource in
        __pci_read_base
  PCI: unset the resource if a wrong bus address is assigned by firmware

 drivers/pci/probe.c | 34 ++++++++++++++++++++++++++++------
 1 file changed, 28 insertions(+), 6 deletions(-)

-- 
1.8.1.4


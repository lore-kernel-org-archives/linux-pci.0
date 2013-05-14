Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail1.windriver.com ([147.11.146.13]:57343 "EHLO
	mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751846Ab3ENNH7 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 14 May 2013 09:07:59 -0400
From: Kevin Hao <haokexin@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>
Subject: [PATCH 0/2] fix the pci device malfunction if a wrong bus address is assigned by firmware
Date: Tue, 14 May 2013 21:07:54 +0800
Message-ID: <1368536876-27307-1-git-send-email-haokexin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On a fsl p2020rdb-pc board, the onboard pci device is assigned the bus address
0xa0000000 by firmware. But the kernel allocate the cpu address 0xa0000000 ~ 0xbfffffff
to this PCIe controller and use 0xe0000000 ~ 0xdfffffff as its bus address.
In this case the kernel would think that the bus address in this pci device
is correct and leave it unchanged. Then causes this device not work.

Even though this looks like a mismatch of the address space between firmware
and kernel. I think we should detect this kind of error and fix it automatically
if we don't want just to probe only (PCI_PROBE_ONLY is not set).

Kevin Hao (2):
  PCI: make pcibios_bus_to_resource return either success or failure
  PCI: unset the resource if we can't get the correct CPU address

 drivers/pci/host-bridge.c | 5 ++++-
 drivers/pci/probe.c       | 9 ++++++---
 include/linux/pci.h       | 2 +-
 3 files changed, 11 insertions(+), 5 deletions(-)

-- 
1.8.1.4


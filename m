Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from g9t1613g.houston.hpe.com ([15.241.32.99]:5587 "EHLO
        g9t1613g.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751198AbcHWX30 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Aug 2016 19:29:26 -0400
Received: from g4t3428.houston.hpe.com (g4t3428.houston.hpe.com [15.241.140.76])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by g9t1613g.houston.hpe.com (Postfix) with ESMTPS id D9E7661151
        for <linux-pci@vger.kernel.org>; Tue, 23 Aug 2016 23:29:25 +0000 (UTC)
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g4t3428.houston.hpe.com (Postfix) with ESMTP id 03E2F5B
        for <linux-pci@vger.kernel.org>; Tue, 23 Aug 2016 23:28:45 +0000 (UTC)
Received: from div_linux.localnet (unknown [16.93.61.14])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id E63314C
        for <linux-pci@vger.kernel.org>; Tue, 23 Aug 2016 23:28:44 +0000 (UTC)
From: divakar <divakar.chitturi@hpe.com>
To: linux-pci@vger.kernel.org
Subject: pci_enable_device error
Date: Tue, 23 Aug 2016 16:24:37 -0700
Message-ID: <2771432.urgYcWSoQk@div_linux>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi

I am trying to enable the pci device in the driver by calling the 
function, pci_enable_device and i get the below error. 

fpga_pci_uio_driver 0000:4e:00.0: can't enable device: BAR 0 [mem 
0x00000000-0x000fffff 64bit pref] not claimed
fpga_pci_uio_driver 0000:4e:00.0: Failed to enable fpga_pci_uio device 
rc=-22
fpga_pci_uio_driver: probe of 0000:4e:00.0 failed with error -22

I am guessing its coming from pci_enable_resource function in 
pci_setup.c. ( trying to setup debug env to trace exact location)
if (!r->parent) {
                         dev_err(&dev->dev, "can't enable device: BAR %d 
%pR not claimed\n",
                                 i, r);
                         return -EINVAL;
           	}

I am not sure why this condition is false. I am running kernel 3.19 and 
this is a pcie endpoint device sitting on one of the port of the pcie 
switch. Below is the dmesg output for the pcie switch port. 

[   13.586987] pci 0000:4b:04.0: PCI bridge to [bus 4e]
[   13.591069] pci 0000:4b:04.0:   bridge window [mem 0xc7c00000-0xc7ffffff 
64bit pref]

lspci output for my device
lspci -v -s 4e:00.0
4e:00.0 Non-VGA unclassified device:  Company Device 0180 
(rev 01)
        Flags: fast devsel
        Memory at <unassigned> (64-bit, prefetchable) [size=1M]
        Capabilities: [50] MSI: Enable- Count=1/32 Maskable- 64bit+
        Capabilities: [78] Power Management version 3
        Capabilities: [80] Express Endpoint, MSI 00
        Capabilities: [100] Multi-Function Virtual Channel <?>

The other device on different port of the switch work fine. That device 
driver also calls pci_enable_device(dev).

I found a thread http://www.spinics.net/lists/linux-pci/msg49725.html 
discussing something similar. Should i apply any patch to solve it? or 
am i missing something?

Thanks


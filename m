Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:51967 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754286Ab3DGTZP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sun, 7 Apr 2013 15:25:15 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glp-linux-pci@m.gmane.org>)
	id 1UOvD7-00008J-IS
	for linux-pci@vger.kernel.org; Sun, 07 Apr 2013 21:25:05 +0200
Received: from 113.90.71.99 ([113.90.71.99])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pci@vger.kernel.org>; Sun, 07 Apr 2013 21:25:05 +0200
Received: from zhef2000 by 113.90.71.99 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pci@vger.kernel.org>; Sun, 07 Apr 2013 21:25:05 +0200
To: linux-pci@vger.kernel.org
From: zhengfei <zhef2000@gmail.com>
Subject: [Question] Failed to access the BAR MMIO space of PCI device
Date: Sun, 7 Apr 2013 19:19:53 +0000 (UTC)
Message-ID: <loom.20130407T204756-980@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

I'm writing a driver for a SR-IOV device on the PCI bus. My architecture is 
a 64-bit X86 of intel Sandy bridge.

In my device driver, I want to configure the device to transfer data to/from 
X86.I get the the device BAR MMIO base address with the command "lspci -s 
04:00.03 -xxx" in the guest os(kvm).
But after I ioremap() that MMIO base address,I failed to access the BAR MMIO 
space in the guest os(kvm).

Is there a function which show mapping between the real PCI address stored in 
the BAR and the emulated address stored in the BAR?

Thanks.

zhengfei


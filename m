Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:32987 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751541AbbI3Lye (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 30 Sep 2015 07:54:34 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glp-linux-pci@m.gmane.org>)
	id 1ZhFxu-0005Ov-RP
	for linux-pci@vger.kernel.org; Wed, 30 Sep 2015 13:54:31 +0200
Received: from nsg-static-030.145.72.182.airtel.in ([nsg-static-030.145.72.182.airtel.in])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2015 13:54:30 +0200
Received: from bharatku by nsg-static-030.145.72.182.airtel.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2015 13:54:30 +0200
To: linux-pci@vger.kernel.org
From: bharat kumar gogada <bharatku@xilinx.com>
Subject: Need information on Microblaze PCIe
Date: Wed, 30 Sep 2015 11:54:17 +0000 (UTC)
Message-ID: <loom.20150930T134944-26@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We are trying to write a generic PCIE root port driver which works both on
zynq (ARM 32 architecture) and Microblaze architecture, since both use same
PCIE Hardware IP. So we started exploring microblaze pci architecture. Zynq
driver is already present at drivers/pci/host/pcie-xilinx.c

Microblaze pci mainly relies on arch/microblaze/pci/pci-common.c this file.
In this file "static int __init pcibios_init(void)" is the main function
which does most of the work, before that we need to allocate struct
pci_controller and fill in the required device node and resource details.

Problem is if we use platform_driver for registration, the "pcibios_init" of
microblaze will get invoked before this driver probe is called since it is
exported as " subsys_initcall(pcibios_init) " and by that time it doesn't
have information of struct pci_controller. (We are using some #ifdef
according to archticture) 

So, in order to avoid above problem and remove dependency on "pcibios_init",
we tried directly invoking the following functions, without registering to
hw_pci in probe:
of_pci_get_host_bridge_resources, pci_create_root_bus, pci_scan_child_bus,
pci_assign_unassigned_bus_resources, pci_bus_add_devices.

But then also its not successful since pci subsystem itself is invoking some
methods from this file(pci-common.c), and some methods take information from
struct pci_controller. 

So I need some inputs what are other possible ways I could try to make
generic driver.



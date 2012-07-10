Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gw1.transmode.se ([195.58.98.146]:57527 "EHLO gw1.transmode.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754794Ab2GJRiB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 10 Jul 2012 13:38:01 -0400
Received: from mail1.transmode.se (mail1.transmode.se [192.168.201.18])
	by gw1.transmode.se (Postfix) with ESMTP id 2474C2588E6
	for <linux-pci@vger.kernel.org>; Tue, 10 Jul 2012 19:29:47 +0200 (CEST)
Subject: PICe hotplug problems
To: linux-pci@vger.kernel.org
Message-ID: <OF15EE971A.73D0AED3-ONC1257A37.005D93BD-C1257A37.00601BF9@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Tue, 10 Jul 2012 19:29:46 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


I got an PCIe device that is woken up by user space, clocks needs to configured in various ways before the
device enables its PCIe interface.

The device is connected to a built in root bridge on a P2010(mpc85xx) CPU.
To enable HP in Linux we need to apply some minor hacks.

First, The contoller has MSI but there is no pci_find_capability(dev, PCI_CAP_ID_MSI) so
portdrv_core.c:init_service_irqs() fails this test(dev->pin is false too):
 	if (!pci_enable_msi(dev) || dev->pin)

Is the code correct? Should our root bridge have PCI_CAP_ID_MSI?

Second problem, the root bride does not have PCI_EXP_FLAGS_SLOT so
portdrv_core.c:get_port_device_capability() fails this test:
  if ((cap_mask & PCIE_PORT_SERVICE_HP) && (reg16 & PCI_EXP_FLAGS_SLOT)) {
		pci_read_config_dword(dev, pos + PCI_EXP_SLTCAP, &reg32);
		if (reg32 & PCI_EXP_SLTCAP_HPC) {
			services |= PCIE_PORT_SERVICE_HP;

which cause PCIE_PORT_SERVICE_HP to be unset in services.

Is PCI_EXP_FLAGS_SLOT really required for hot plug?

Perhaps there another way?

 Jocke


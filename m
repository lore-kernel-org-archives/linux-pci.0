Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from o1.f.az.sendgrid.net ([208.117.55.132]:35083 "EHLO
	o1.f.az.sendgrid.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751731AbbIKAJl (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 10 Sep 2015 20:09:41 -0400
From: jakeo@microsoft.com
To: gregkh@linuxfoundation.org, kys@microsoft.com,
	linux-kernel@vger.kernel.org, devel@linuxdriverproject.org,
	olaf@aepfle.de, apw@canonical.com, vkuznets@redhat.com,
	linux-pci@vger.kernel.org, bhelgaas@google.com, tglx@linutronix.de
Cc: Jake Oshins <jakeo@microsoft.com>
Subject: [PATCH v2 00/12] New paravirtual PCI front-end for Hyper-V VMs
Date: Fri, 11 Sep 2015 00:00:59 +0000
Message-Id: <1441929670-10058-1-git-send-email-jakeo@microsoft.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Jake Oshins <jakeo@microsoft.com>

The patch series updates the one sent about a month ago in three ways.  It
integrated with other IRQ domain work done in linux-next in that time, it
distributes interrupts to multiple virtual processors in the guest VM, and it
incorporates feedback from Thomas Gleixner and others.

These patches change the IRQ domain code so that an IRQ domain can match on both
bus type and on the PCI domain.  The IRQ domain match code is modified so that
IRQ domains can have a "rank," allowing for a default one which matches every
x86 PC and more specific ones that replace the default.

The next step is to make it possible to implement an IRQ domain in a module,
by exporting a few functions.  This seems to make sense here, rather than
linking it into the kernel, because pulling it into the kernel would involve
pulling a lot of other Hyper-V-related code into the kernel, since the IRQ
domain implementation has to send messages to and receive messages from the
hypervisor, and those facilities are currently built as modules.

After that, a couple of new Hyper-V-related facilities are exported from 
hv_vmbus.ko, so that the PCI front end can correlate Linux CPUs with virtual
processor IDs and to make hypercalls.

The last patch is a new front-end driver that exposes new root PCI buses that
(virtually) contain devices being passed through into the VM.

Jake Oshins (12):
  kernel:irq:  Change signature of irq_domain_ops match() method, adding
    *bus_data
  kernel:irq: Change signature of irq_find_matching_host()
  kernel:irq: Allow for ranked matches on IRQ domains
  drivers:pci: Add IRQ domain lookup by PCI domain
  drivers:hv: Export a function that maps Linux CPU num onto Hyper-V
    proc num
  drivers:hv: Export do_hypercall()
  drivers:x86:pci: Make it possible to implement a PCI MSI IRQ Domain in
    a module.
  drivers:pci:msi: Store PCI domain (segment) as part of IRQ domain
  kernel:irq: Implement msi match function
  kernel:irq: Return a higher ranked match when the IRQ domain matches a
    specific PCI domain
  drivers:hv: Define the channel type for Hyper-V PCI Express
    pass-through
  drivers:pci:hv: New paravirtual PCI front-end for Hyper-V VMs

 MAINTAINERS                                      |    1 +
 arch/powerpc/platforms/512x/mpc5121_ads_cpld.c   |    2 +-
 arch/powerpc/platforms/cell/interrupt.c          |    2 +-
 arch/powerpc/platforms/embedded6xx/flipper-pic.c |    3 +-
 arch/powerpc/platforms/powermac/pic.c            |    3 +-
 arch/powerpc/platforms/powernv/opal-irqchip.c    |    2 +-
 arch/powerpc/platforms/ps3/interrupt.c           |    2 +-
 arch/powerpc/sysdev/ehv_pic.c                    |    3 +-
 arch/powerpc/sysdev/i8259.c                      |    2 +-
 arch/powerpc/sysdev/ipic.c                       |    2 +-
 arch/powerpc/sysdev/mpic.c                       |    2 +-
 arch/powerpc/sysdev/qe_lib/qe_ic.c               |    2 +-
 arch/powerpc/sysdev/xics/xics-common.c           |    2 +-
 arch/x86/include/asm/msi.h                       |    4 +
 arch/x86/kernel/apic/msi.c                       |    5 +-
 arch/x86/kernel/apic/vector.c                    |    2 +
 drivers/hv/hv.c                                  |    3 +-
 drivers/hv/vmbus_drv.c                           |   17 +
 drivers/irqchip/irq-gic-v3-its-pci-msi.c         |    2 +-
 drivers/irqchip/irq-gic-v3-its-platform-msi.c    |    2 +-
 drivers/of/irq.c                                 |    2 +-
 drivers/pci/Kconfig                              |    7 +
 drivers/pci/host/Makefile                        |    1 +
 drivers/pci/host/hv_pcifront.c                   | 2244 ++++++++++++++++++++++
 drivers/pci/msi.c                                |    2 +
 drivers/pci/of.c                                 |    2 +-
 drivers/pci/probe.c                              |   11 +
 include/linux/hyperv.h                           |   14 +
 include/linux/irqdomain.h                        |    9 +-
 include/linux/msi.h                              |    4 +
 kernel/irq/chip.c                                |    1 +
 kernel/irq/irqdomain.c                           |   48 +-
 kernel/irq/msi.c                                 |   24 +
 33 files changed, 2394 insertions(+), 38 deletions(-)
 create mode 100644 drivers/pci/host/hv_pcifront.c

-- 
1.9.1


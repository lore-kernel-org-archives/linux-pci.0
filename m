Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-Id: <20171017075456.694047687@linutronix.de>
Date: Tue, 17 Oct 2017 09:54:56 +0200
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Dexuan Cui <decui@microsoft.com>, x86@kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        linux-pci@vger.kernel.org, devel@linuxdriverproject.org,
        Josh Poulson <jopoulso@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Simon Xiao <sixiao@microsoft.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Mihai Costache <v-micos@microsoft.com>,
        Jork Loeser <Jork.Loeser@microsoft.com>
Subject: [patch 0/3] x86/PCI/MSI: Make sure that irq reservation mode works
 everywhere
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dexuan reported that the recent rework of the vector allocation mode in x86
broke HyperV PCI passtrough because the rework missed to add the
MSI_FLAG_MUST_REACTIVATE flag to the HyperV/PCI interrupt domain info.

The simple solution would be to set the flag in the HyperV/PCI driver but
it's better to make this generic and let the PCI/MSI core code set the flag
when reservation mode is enabled. That ensures that future users of this
wont trip over the same problem.

Thanks,

	tglx

---
 arch/x86/Kconfig           |    2 +-
 arch/x86/kernel/apic/msi.c |    5 ++---
 drivers/pci/msi.c          |    2 ++
 kernel/irq/Kconfig         |    3 +++
 4 files changed, 8 insertions(+), 4 deletions(-)

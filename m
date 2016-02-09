Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: [PATCH] PCI: Revert "Implement pcibios_alloc_irq() and
 pcibios_free_irq()"
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: =?utf-8?b?0J7Qu9C10LM=?= =?utf-8?b?0JzQvtGA0L7Qtw==?=
	<oleg.moroz@mcc.vniiem.ru>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	linux-kernel@vger.kernel.org, Sunjin Yang <fan4326@gmail.com>,
	linux-acpi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Yinghai Lu <yinghai@kernel.org>,
	Jiang Liu <jiang.liu@linux.intel.com>
Date: Tue, 09 Feb 2016 11:58:00 -0600
Message-ID: <20160209175155.23549.35323.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We have two reports of drivers broken in v4.3 by Jiang's change,
991de2e59090 ("PCI, x86: Implement pcibios_alloc_irq() and
pcibios_free_irq()").

It would be best to fix the problem instead of reverting 991de2e59090, but
I don't have time to do that myself, and we haven't heard from Jiang, so
the only choice I have is to revert the commit.

Note that reverting will likely break IOAPIC hotplug.

I haven't put my signed-off on it yet because it didn't revert cleanly, and
I'm not sure that I did it correctly.

Олег and Sunjin, can you please test this and see whether it fixes your
drivers?  This patch is based on v4.5-rc1.

---

Bjorn Helgaas (1):
      Revert 991de2e59090 ("PCI, x86: Implement pcibios_alloc_irq() and pcibios_free_irq()")


 arch/x86/include/asm/pci_x86.h |    2 ++
 arch/x86/pci/common.c          |   27 +++++++++++----------------
 arch/x86/pci/intel_mid_pci.c   |    7 ++-----
 arch/x86/pci/irq.c             |   15 ++++++++++++++-
 drivers/acpi/pci_irq.c         |    8 ++++++++
 5 files changed, 37 insertions(+), 22 deletions(-)

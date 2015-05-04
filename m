Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Jiang Liu <jiang.liu@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Yinghai Lu <yinghai@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dimitri Sivanich <sivanich@sgi.com>
Cc: Jiang Liu <jiang.liu@linux.intel.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	David Cohen <david.a.cohen@linux.intel.com>,
	Sander Eikelenboom <linux@eikelenboom.it>,
	David Vrabel <david.vrabel@citrix.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tony Luck <tony.luck@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	x86@kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [Patch 0/2] Optimize CPU vector allocation for NUMA systems
Date: Mon,  4 May 2015 10:47:39 +0800
Message-Id: <1430707662-28598-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi all,
	This is a small patch set based on tip/x86/apic.
This first patch is a bugfix for tip/x86/apic. And the second patch
is an enhancement to optimize CPU vector allocation on NUMA systems.
It introduces a mechanism to allocate CPU vectors from device local
NUMA node and a kernel parameter to enable/disable the optimization.

Thanks!
Gerry

Jiang Liu (2):
  irq_remapping/vt-d: Fix regression caused by commit b106ee63abcc
  x86, irq: Support CPU vector allocation policies

 Documentation/kernel-parameters.txt |    5 +++
 arch/x86/kernel/apic/vector.c       |   83 +++++++++++++++++++++++++++++++----
 drivers/iommu/intel_irq_remapping.c |   16 ++++---
 3 files changed, 90 insertions(+), 14 deletions(-)

-- 
1.7.10.4


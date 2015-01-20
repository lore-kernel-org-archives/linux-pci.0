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
	Dimitri Sivanich <sivanich@sgi.com>, x86@kernel.org,
	Jiang Liu <jiang.liu@linux.intel.com>,
	Yijing Wang <wangyijing@huawei.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	David Cohen <david.a.cohen@linux.intel.com>,
	Sander Eikelenboom <linux@eikelenboom.it>,
	David Vrabel <david.vrabel@citrix.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tony Luck <tony.luck@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [Patch Part2 v4 08/33] x86/irq: Clean up unused forward declarations in x86_init.h
Date: Tue, 20 Jan 2015 13:51:28 +0800
Message-Id: <1421733113-15704-9-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1421733113-15704-1-git-send-email-jiang.liu@linux.intel.com>
References: <1421733113-15704-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Clean up unused forward declarations in x86_init.h.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Yinghai Lu <yinghai@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Yijing Wang <wangyijing@huawei.com>
Link: http://lkml.kernel.org/r/1416901802-24211-18-git-send-email-jiang.liu@linux.intel.com
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/include/asm/x86_init.h |    6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
index 4ada3d3a0e86..09d4dab9302f 100644
--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -171,7 +171,6 @@ struct x86_platform_ops {
 };
 
 struct pci_dev;
-struct msi_msg;
 
 struct x86_msi_ops {
 	int (*setup_msi_irqs)(struct pci_dev *dev, int nvec, int type);
@@ -180,11 +179,6 @@ struct x86_msi_ops {
 	void (*restore_msi_irqs)(struct pci_dev *dev);
 };
 
-struct IO_APIC_route_entry;
-struct io_apic_irq_attr;
-struct irq_data;
-struct cpumask;
-
 struct x86_io_apic_ops {
 	void		(*init)   (void);
 	unsigned int	(*read)   (unsigned int apic, unsigned int reg);
-- 
1.7.10.4


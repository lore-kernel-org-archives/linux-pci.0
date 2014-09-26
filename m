Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Jiang Liu <jiang.liu@linux.intel.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Yinghai Lu <yinghai@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Grant Likely <grant.likely@linaro.org>
Cc: Jiang Liu <jiang.liu@linux.intel.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tony Luck <tony.luck@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	x86@kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [RFC v1 12/28] x86: Clean up unused forward declarations in x86_init.h
Date: Fri, 26 Sep 2014 22:57:42 +0800
Message-Id: <1411743478-31435-13-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1411743478-31435-1-git-send-email-jiang.liu@linux.intel.com>
References: <1411743478-31435-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 arch/x86/include/asm/x86_init.h |    6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
index fa6b1b5128ee..3755cd2bbb94 100644
--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -171,7 +171,6 @@ struct x86_platform_ops {
 };
 
 struct pci_dev;
-struct msi_msg;
 struct msi_desc;
 
 struct x86_msi_ops {
@@ -183,11 +182,6 @@ struct x86_msi_ops {
 	u32 (*msix_mask_irq)(struct msi_desc *desc, u32 flag);
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


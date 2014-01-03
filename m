Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Yinghai Lu <yinghai@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
	"H. Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Subject: [PATCH v5 23/33] x86, ioapic: Find usable ioapic id for 64bit.
Date: Thu,  2 Jan 2014 16:05:55 -0800
Message-Id: <1388707565-16535-24-git-send-email-yinghai@kernel.org>
In-Reply-To: <1388707565-16535-1-git-send-email-yinghai@kernel.org>
References: <1388707565-16535-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Checking the id in register, if that is duplicated, will pick one and
update id register.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
---
 arch/x86/kernel/apic/io_apic.c | 38 +++++++++++++++++++++++++++++++++-----
 1 file changed, 33 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index af6cbcd..248a21d 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -3660,19 +3660,22 @@ static int io_apic_get_unique_id(int ioapic, int apic_id)
 	return apic_id;
 }
 
-static u8 io_apic_unique_id(u8 id)
+static u8 io_apic_unique_id(int idx, u8 id)
 {
 	if ((boot_cpu_data.x86_vendor == X86_VENDOR_INTEL) &&
 	    !APIC_XAPIC(apic_version[boot_cpu_physical_apicid]))
-		return io_apic_get_unique_id(nr_ioapics, id);
+		return io_apic_get_unique_id(idx, id);
 	else
 		return id;
 }
 #else
-static u8 io_apic_unique_id(u8 id)
+static u8 io_apic_unique_id(int idx, u8 id)
 {
 	int i;
+	u8 new_id;
+	unsigned long flags;
 	DECLARE_BITMAP(used, 256);
+	union IO_APIC_reg_00 reg_00;
 
 	bitmap_zero(used, 256);
 	for_each_ioapic(i)
@@ -3680,7 +3683,32 @@ static u8 io_apic_unique_id(u8 id)
 
 	if (!test_bit(id, used))
 		return id;
-	return find_first_zero_bit(used, 256);
+
+	/* check register at first */
+	raw_spin_lock_irqsave(&ioapic_lock, flags);
+	reg_00.raw = io_apic_read(idx, 0);
+	raw_spin_unlock_irqrestore(&ioapic_lock, flags);
+	new_id = reg_00.bits.ID;
+	if (!test_bit(new_id, used)) {
+		apic_printk(APIC_VERBOSE, KERN_INFO
+			"IOAPIC[%d]: Using reg apic_id %d instead of %d\n",
+			 idx, new_id, id);
+		return new_id;
+	}
+
+	new_id = find_first_zero_bit(used, 256);
+	reg_00.bits.ID = new_id;
+	raw_spin_lock_irqsave(&ioapic_lock, flags);
+	io_apic_write(idx, 0, reg_00.raw);
+	reg_00.raw = io_apic_read(idx, 0);
+	raw_spin_unlock_irqrestore(&ioapic_lock, flags);
+
+	/* Sanity check */
+	if (reg_00.bits.ID != new_id)
+		pr_warn("IOAPIC[%d]: Unable to change apic_id to %d!\n",
+			idx, new_id);
+
+	return new_id;
 }
 #endif
 
@@ -3955,7 +3983,7 @@ int __mp_register_ioapic(int id, u32 address, u32 gsi_base, bool hotadd)
 	if (bad_ioapic_register(idx))
 		goto clear_out;
 
-	ioapics[idx].mp_config.apicid = io_apic_unique_id(id);
+	ioapics[idx].mp_config.apicid = io_apic_unique_id(idx, id);
 	ioapics[idx].mp_config.apicver = io_apic_get_version(idx);
 
 	/*
-- 
1.8.4


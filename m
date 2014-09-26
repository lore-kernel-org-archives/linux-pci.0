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
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
	Daniel J Blueman <daniel@numascale.com>
Subject: [RFC v1 28/28] x86, irq: Add kernel parameter vector_alloc to set CPU vector allocation policy
Date: Fri, 26 Sep 2014 22:57:58 +0800
Message-Id: <1411743478-31435-29-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1411743478-31435-1-git-send-email-jiang.liu@linux.intel.com>
References: <1411743478-31435-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Parameter vector_alloc should be set to an integer with:
bit 0:	enable allocating CPU vector from CPUs on device local node.
	That's to allocate from cpumask_of_node(irq_data->node).
bit 1: enable the default policy, which is to allocate from
       apic->target_cpus().

When allocating vectors, it tries all enabled policies from lower bit
position to higher bit position.

This option could be use to optimize interrupt distribution on large
system such as NumaChip etc.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
Cc: Daniel J Blueman <daniel@numascale.com>
---
 Documentation/kernel-parameters.txt |    6 ++++++
 arch/x86/kernel/apic/vector.c       |   11 +++++++++++
 2 files changed, 17 insertions(+)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 10d51c2f10d7..895ba404eb0d 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -3586,6 +3586,12 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 	vector=		[IA-64,SMP]
 			vector=percpu: enable percpu vector domain
 
+	vector_alloc=	[x86,SMP]
+			vector_alloc=policy: policy is a bitmap, bit 0
+			for allocating CPU vector from CPUs on device local
+			node; bit 1 for the default policy to allocating from
+			apic->target_cpus(). All higher bits are reserved.
+
 	video=		[FB] Frame buffer configuration
 			See Documentation/fb/modedb.txt.
 
diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index 4a16e0a5ae0f..d1f616374ec0 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -65,6 +65,17 @@ void set_vector_alloc_policy(unsigned int policy)
 		x86_vector_alloc_policy = policy | X86_VECTOR_POL_CALLER;
 }
 
+static int __init apic_parse_vector_policy(char *str)
+{
+	int policy;
+
+	if (get_option(&str, &policy) == 1)
+		set_vector_alloc_policy(policy);
+
+	return 1;
+}
+__setup("vector_alloc=", apic_parse_vector_policy);
+
 static struct irq_cfg *alloc_irq_cfg(int node)
 {
 	struct irq_cfg *cfg;
-- 
1.7.10.4


Return-Path: <SRS0=/aB5=46=linuxonhyperv.com=jloeser@kernel.org>
Return-Path: <SRS0=/aB5=46=linuxonhyperv.com=jloeser@kernel.org>
From: Jork Loeser <jloeser@linuxonhyperv.com>
To: jloeser@microsoft.com,
	helgaas@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devel@linuxdriverproject.org,
	olaf@aepfle.de,
	apw@canonical.com,
	vkuznets@redhat.com,
	jasowang@redhat.com,
	leann.ogasawara@canonical.com,
	marcelo.cerri@canonical.com,
	sthemmin@microsoft.com
Subject: [PATCH-v2 3/5] PCI-HyperV vPCI: Temporary own CPU-number-to-vCPU-number infra
Date: Wed, 24 May 2017 13:41:26 -0700
Message-Id: <1495658488-13199-4-git-send-email-jloeser@linuxonhyperv.com>
In-Reply-To: <1495658488-13199-1-git-send-email-jloeser@linuxonhyperv.com>
References: <1495658488-13199-1-git-send-email-jloeser@linuxonhyperv.com>
Reply-To: Jork Loeser <jloeser@microsoft.com>
List-ID: <linux-pci.vger.kernel.org>

From: Jork Loeser <jloeser@microsoft.com>

To ease parallel effort to centralize CPU-number-to-vCPU-number
conversion, temporarily stand up own version, file-local
hv_tmp_cpu_nr_to_vp_nr(). Once the changes have merged, this
work-around can be removed, and the calls replaced with
hv_cpu_number_to_vp_number().

Signed-off-by: Jork Loeser <jloeser@microsoft.com>
---
 drivers/pci/host/pci-hyperv.c | 52 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 50 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.c
index 6e4b026..ee70b1f 100644
--- a/drivers/pci/host/pci-hyperv.c
+++ b/drivers/pci/host/pci-hyperv.c
@@ -479,6 +479,52 @@ static void put_pcichild(struct hv_pci_dev *hv_pcidev,
 static void get_hvpcibus(struct hv_pcibus_device *hv_pcibus);
 static void put_hvpcibus(struct hv_pcibus_device *hv_pcibus);
 
+
+/*
+ * Temporary CPU to vCPU mapping to address transitioning
+ * vmbus_cpu_number_to_vp_number() being migrated to
+ * hv_cpu_number_to_vp_number() in a separate patch. Once that patch
+ * has been picked up in the main line, remove this code here and use
+ * the offical code.
+ */
+static struct hv_tmpcpumap
+{
+	bool initialized;
+	u32 vp_index[NR_CPUS];
+} hv_tmpcpumap;
+
+static void hv_tmpcpumap_init_cpu(void *_unused)
+{
+	int cpu = smp_processor_id();
+	u64 vp_index;
+
+	hv_get_vp_index(vp_index);
+
+	hv_tmpcpumap.vp_index[cpu] = vp_index;
+}
+
+static void hv_tmpcpumap_init(void)
+{
+	if (hv_tmpcpumap.initialized)
+		return;
+
+	memset(hv_tmpcpumap.vp_index, -1, sizeof(hv_tmpcpumap.vp_index));
+	on_each_cpu(hv_tmpcpumap_init_cpu, NULL, true);
+	hv_tmpcpumap.initialized = true;
+}
+
+/**
+ * hv_tmp_cpu_nr_to_vp_nr() - Convert Linux CPU nr to Hyper-V vCPU nr
+ *
+ * Remove once vmbus_cpu_number_to_vp_number() has been converted to
+ * hv_cpu_number_to_vp_number() and replace callers appropriately.
+ */
+static u32 hv_tmp_cpu_nr_to_vp_nr(int cpu)
+{
+	return hv_tmpcpumap.vp_index[cpu];
+}
+
+
 /**
  * devfn_to_wslot() - Convert from Linux PCI slot to Windows
  * @devfn:	The Linux representation of PCI slot
@@ -813,7 +859,7 @@ static void hv_irq_unmask(struct irq_data *data)
 	params->vector = cfg->vector;
 
 	for_each_cpu_and(cpu, dest, cpu_online_mask)
-		params->vp_mask |= (1ULL << vmbus_cpu_number_to_vp_number(cpu));
+		params->vp_mask |= (1ULL << hv_tmp_cpu_nr_to_vp_nr(cpu));
 
 	hv_do_hypercall(HVCALL_RETARGET_INTERRUPT, params, NULL);
 
@@ -908,7 +954,7 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 	} else {
 		for_each_cpu_and(cpu, affinity, cpu_online_mask) {
 			int_pkt->int_desc.cpu_mask |=
-				(1ULL << vmbus_cpu_number_to_vp_number(cpu));
+				(1ULL << hv_tmp_cpu_nr_to_vp_nr(cpu));
 		}
 	}
 
@@ -2218,6 +2264,8 @@ static int hv_pci_probe(struct hv_device *hdev,
 		return -ENOMEM;
 	hbus->state = hv_pcibus_init;
 
+	hv_tmpcpumap_init();
+
 	/*
 	 * The PCI bus "domain" is what is called "segment" in ACPI and
 	 * other specs.  Pull it from the instance ID, to get something
-- 
2.7.4

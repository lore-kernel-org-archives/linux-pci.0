Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012030.outbound.protection.outlook.com [40.107.209.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D2E3E315E;
	Thu,  1 Oct 2026 15:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790870200; cv=fail; b=efi7tvsGzHBpceehcptccDHql9WB/mk9zvxrqwsRtxTh88xmqKa1XnV4lXjgAXt5/8AI6t51ozBpna2qyLK2rA2Imiaygpi1D99dv3QB6UV8kMgdo2byI60qJKnfBMVsaVUFu1VWtVYCofY+TRG1vIQsYLH8cjqFLIBaH5GmtvA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790870200; c=relaxed/simple;
	bh=HhXilCzetUyq+hWDlBCklK2+97hJycZYleRd3UXyR5g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c1VBL2icjd4vhtUBOhV2/flChqMPEsa80mKGflKO9oJkpYJthMqz9rQWAMU2Fb7/o9pR25iLEqdgK2/poXaSQW+fns0SPDg6M2wHZzjkVfrn8iR6tcmD+FXvBpHQ0NRgYk5RmMJfBDT6m1qBq5M89mOwecANioMDOuc8YB9/ygw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=H3i3jRY8; arc=fail smtp.client-ip=40.107.209.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="H3i3jRY8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qLTaP3khvwvzYILGU2/TGCbglaaw3V/NbGvEk5A7u4KpQcNIMReYWqbSUfGt2DO86SJTmYz7en+SzQ64lqYvIOj18Ob8H8SGzIqumSsvZms/4y4Mh1pAeeqfj+DPYYsXkCxkx0JQhwwEn1OLtRZ8p0z94DvyYV5+PIv85hExJN9GnsppB7SmlsDxpJ55oAAKsoA5bVpJIwJG0kB+/nZ4yzHXL5Rb6ktb1wLIfJVJgft1f4KBaGY6M/35EhxZzfHDcvWigpbvwZXSGm0JpbsP1nJqXcAunviSYAvrw4nJsm1hDG+8kvuXClFguAMYCjwL1byHsGxivw0FkYEgAmUzWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3aM/EMoo5Oh9Zw7hN1naWL76lwsg8klLTu/lhKY/5LA=;
 b=aSsBZnMf++0eGmvGVcB+tmK44ggTHzTpHL2ksAdNDYo6Bx4JnkwTR7YevAvafPRW5mAUrZMqw6odp3SobrPVIL0th16pO7H3VSGyjQTqGqrRoKRLEvu4XxNtZgztI1E+viMZ+CEAwd1e4CMqRAvSP0EjIfnd/ye288hx/PNJZxFbAflVmP8A9LTb9K/RWsH/Ci6H12hDcD1yqDwv9eaPARassg/bdyeB7NROLIO4sp0GLs/oDdAl8M0e7Iv39sfhiXXztWpAd/Id/nJWmmXmvH3wE69e9zZP+JYKzdr5wuHZMY86OMAF1Gbq7TnrK8CYJv5IFMdRx+Ey0PBnT/pZ6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3aM/EMoo5Oh9Zw7hN1naWL76lwsg8klLTu/lhKY/5LA=;
 b=H3i3jRY8OhbjwMdrOBOzcr4z4rEktgRGT/otItikgFPjlGY9YFwmFuHky9l/M9hdUXQy8MdC8OvAdnlsrvKqVPjHGJh2GWs+R92TwW+7iquQYEABBEh6Ccz05MkIwTCp34cOmnsoD/L7KA81YXJcvFAPffCg1rSwCt4MQVxQHyk=
Received: from SJ0PR03CA0197.namprd03.prod.outlook.com (2603:10b6:a03:2ef::22)
 by BL1PR12MB5994.namprd12.prod.outlook.com (2603:10b6:208:39a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Thu, 1 Oct
 2026 15:56:31 +0000
Received: from SJ5PEPF000001E8.namprd05.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::39) by SJ0PR03CA0197.outlook.office365.com
 (2603:10b6:a03:2ef::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.16 via Frontend Transport; Thu, 1
 Oct 2026 15:56:31 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001E8.mail.protection.outlook.com (10.167.242.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Thu, 1 Oct 2026 15:56:31 +0000
Received: from weiserver.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 1 Oct
 2026 10:56:29 -0500
From: Wei Huang <wei.huang2@amd.com>
To: <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <skhan@linuxfoundation.org>,
	<corbet@lwn.net>, <rdunlap@infradead.org>, <fengchengwen@huawei.com>,
	<wei.huang2@amd.com>
Subject: [PATCH RFC 3/3] Expose the CPU/Steering Tag mapping via debugfs
Date: Thu, 1 Oct 2026 10:55:51 -0500
Message-ID: <20261001155551.4182899-4-wei.huang2@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261001155551.4182899-1-wei.huang2@amd.com>
References: <20261001155551.4182899-1-wei.huang2@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E8:EE_|BL1PR12MB5994:EE_
X-MS-Office365-Filtering-Correlation-Id: bc8cca1e-d656-4eff-ac63-08df1fd48fdf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|1800799024|23010399003|82310400026|11063799006|56012099006|22082099003|18002099003|10067099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	iNOmsK9wmhP23mZYzmfpBh+pepWWfLfceQfvVCFausPVlFYTOeXHT8RzCGXpk5XWAfpJvge4ptbWt8UGjOXN7taDw7Eel0UluMvW3yKchYqdEKeijljFVYWevyweBdD0favG37bDlk6dNE539gJYATzk/c9UEG23zxYgaV9aqlBrM9sCHLXMQSbkjpcxlZJCkngEgrzVxDRbp7yGeMwcOx2D/y2NabdM+M+19FJz4rIBL/lRnlEWp1pQcOLHxIkKUSoDRhWwW6BE9eWiZrJpDnBnuDIA4A5EtyvaubHQZb2znolDSCs4eLCx4axzV3i1kmOv8ikh9WGWJgI9RM9wcO8GbwaucrjwODGUSpF0fRx+w/Y2h1Hso7WC+8SHDjFNWlEwnd9ZiJXXKo00EkMDrh9MOFPR9S5Gymf0pcl8LPQKBeD8rWi1elKeOyElHV5VT1uvG1WPWU9hh0S2XecLyUrrOuyNf3wzjMD25PtPfBjK/+0Bs8q+RQjzP0uKYZ2l2qA+ozYrf3vRmn4eaXgvjQ/g0Yi4USlgE/ESEfZ0knabb6IZRof725IcPx4k/QGGu9eo0pCnXPZcZOnJVf7yxWMZVIC2aUnkRQ/bbJ0oL0MES/Q9Kds7E7FehCA519o02AxXyX/nza+rkFDfPvZBHnpb2qo41VArj5mwxyvjDMx9KdZUun4pbJ0jXynjOveF9JjsBNp5lgLXkB9CteY73g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(1800799024)(23010399003)(82310400026)(11063799006)(56012099006)(22082099003)(18002099003)(10067099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	q/IEwfWwnTVVLeX4f2L6S+bojBZgrBcCMONLRorwgMRSQBCJn44DLmEL6cdrcMXAACtw9YDpZG2Jm/sz26JIp3fXHi4g5e/3jKXp4rf8jJn/MFDc6aEEXEviqfayyNo+uOZLYMmew8G1oJE12Jx06crZiL2jZ2XcIs5kO61uXdZViRmDxZQ4LeBNv7ES8vQ9Cj6D4bkHS5mzcagf8z+GZAZs6tebDLu2JLTQB36IKFj5HSh2V/o9DB/g2nGMhB4XH4NBsEz+Y5rQlzKSreHFpDyqwDgQoMkG5J3WS3UeAEHUuglIJWbKLBpCqPMjDRpra4JdCeou/Y1EJT5Qu21XuU62ahcDVE7MBL1E2V1RUg0SOvw9OuBjF1UrP9TzfvMfcLCdUKpyOcTk+spC6fR7CHjaF7v0k4Zg9HiVXplJ0vwDr0Y2SlvYVIQBoPpHkrTJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 15:56:31.5965
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc8cca1e-d656-4eff-ac63-08df1fd48fdf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5994

Steering Tags (ST) are opaque, platform specific values obtained from the
ACPI ST _DSM, and are only visible to the driver that asks for them. That
makes it hard to validate whether firmware reports a sane mapping at all.

Expose the mapping read-only in the debugfs directory of each Root Port
that has ST _DSM support:

  # cat /sys/kernel/debug/pci/0000:00:01.1/tph_cpu_st
  cpu  vm_st  vm_xst vm_ph_ignore pm_st  pm_xst pm_ph_ignore
  0    0x03   0x0103 0            -      -      0
  1    0x03   0x0103 0            -      -      0

Each line holds the raw ST info the _DSM returns for one online CPU;
invalid tags and failed queries are reported as "-".

The interface is per Root Port because the _DSM is evaluated on the ACPI
device of the host bridge above it. A system with multiple host bridges may
return different tags for the same CPU, and the value that matters to a
driver is the one for the Root Port its device sits below. Root Ports below
the same host bridge report identical contents.

The file is created during enumeration and removed with the device's
debugfs directory in pci_destroy_dev(), which returns only once no read is
running, so the pci_dev the file refers to stays valid.

Signed-off-by: Wei Huang <wei.huang2@amd.com>
---
 Documentation/PCI/tph.rst |  32 +++++++++
 drivers/pci/tph.c         | 136 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 168 insertions(+)

diff --git a/Documentation/PCI/tph.rst b/Documentation/PCI/tph.rst
index b6cf22b9bd90..19239546af3b 100644
--- a/Documentation/PCI/tph.rst
+++ b/Documentation/PCI/tph.rst
@@ -125,6 +125,38 @@ been changed. Here is a sample code for IRQ affinity notifier:
              return;
     }
 
+Inspect the firmware ST mapping
+-------------------------------
+
+When firmware provides the ST _DSM, the CPU to ST mapping it returns is
+exposed read-only under debugfs, in the directory of each Root Port::
+
+  /sys/kernel/debug/pci/<domain:bus:device.function>/tph_cpu_st
+
+Each file holds one line per online CPU::
+
+  # cat /sys/kernel/debug/pci/0000:00:01.1/tph_cpu_st
+  cpu  vm_st  vm_xst vm_ph_ignore pm_st  pm_xst pm_ph_ignore
+  0    0x03   0x0103 0            -      -      0
+  1    0x03   0x0103 0            -      -      0
+
+``vm_*`` and ``pm_*`` refer to volatile and persistent memory, ``*_st`` and
+``*_xst`` are the 8-bit and 16-bit (extended) Steering Tags, and
+``*_ph_ignore`` reports whether the Processing Hint is ignored by the
+platform. Steering Tags that firmware marks as invalid, and CPUs whose
+query fails, are shown as ``-``.
+
+The _DSM is evaluated on the ACPI device of the host bridge above the Root
+Port, so all Root Ports below the same host bridge report the same mapping.
+The file is per Root Port because that is the granularity drivers see: the
+mapping that applies to a device is the one in the directory of the Root
+Port the device sits below.
+
+Tags are queried on read rather than cached, so the output always matches
+what pcie_tph_get_cpu_st() would return at that moment.  The list of CPUs
+is a snapshot; CPUs that come or go while the file is being read may be
+missing from the output.
+
 Disable TPH system-wide
 -----------------------
 
diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
index d2c6d3dda202..bd682185ffbb 100644
--- a/drivers/pci/tph.c
+++ b/drivers/pci/tph.c
@@ -6,11 +6,14 @@
  *     Eric Van Tassell <Eric.VanTassell@amd.com>
  *     Wei Huang <wei.huang2@amd.com>
  */
+#include <linux/cpu.h>
+#include <linux/debugfs.h>
 #include <linux/pci.h>
 #include <linux/pci-acpi.h>
 #include <linux/msi.h>
 #include <linux/bitfield.h>
 #include <linux/pci-tph.h>
+#include <linux/seq_file.h>
 
 #include "pci.h"
 
@@ -171,6 +174,133 @@ static int tph_get_cpu_st_info(struct pci_dev *pdev, unsigned int cpu,
 }
 #endif
 
+#if defined(CONFIG_ACPI) && defined(CONFIG_DEBUG_FS)
+/* Longest Steering Tag string is "0xffff" */
+#define TPH_ST_STR_SIZE		7
+
+static bool tph_dsm_supported(struct pci_dev *pdev)
+{
+	acpi_handle handle = tph_dsm_handle(pdev);
+
+	if (!handle)
+		return false;
+
+	return acpi_check_dsm(handle, &pci_acpi_dsm_guid, TPH_ST_DSM_REV,
+			      BIT(TPH_ST_DSM_FUNC_INDEX));
+}
+
+static const char *tph_st_str(char *buf, bool valid, u16 st, int digits)
+{
+	if (!valid)
+		return "-";
+
+	snprintf(buf, TPH_ST_STR_SIZE, "0x%0*x", digits, st);
+
+	return buf;
+}
+
+/*
+ * Position 0 is the header, position N > 0 is the first online CPU with an
+ * id >= N - 1.  Encoding the CPU id in the position, instead of an index
+ * into the online mask, keeps the remaining output stable if a CPU goes
+ * offline between two read() calls.
+ *
+ * The iterator itself is the CPU id biased by 2, because 0 is the end of
+ * the sequence and 1 is SEQ_START_TOKEN.
+ */
+static void *tph_cpu_st_pos(loff_t *pos)
+{
+	unsigned int cpu;
+
+	if (!*pos)
+		return SEQ_START_TOKEN;
+
+	if (*pos > nr_cpu_ids)
+		return NULL;
+
+	cpu = cpumask_next((int)*pos - 2, cpu_online_mask);
+	if (cpu >= nr_cpu_ids)
+		return NULL;
+
+	*pos = cpu + 1;
+
+	return (void *)(unsigned long)(cpu + 2);
+}
+
+static void *tph_cpu_st_start(struct seq_file *s, loff_t *pos)
+{
+	return tph_cpu_st_pos(pos);
+}
+
+static void *tph_cpu_st_next(struct seq_file *s, void *v, loff_t *pos)
+{
+	++*pos;
+
+	return tph_cpu_st_pos(pos);
+}
+
+static void tph_cpu_st_stop(struct seq_file *s, void *v)
+{
+}
+
+static int tph_cpu_st_show(struct seq_file *s, void *v)
+{
+	char vm_st[TPH_ST_STR_SIZE], vm_xst[TPH_ST_STR_SIZE];
+	char pm_st[TPH_ST_STR_SIZE], pm_xst[TPH_ST_STR_SIZE];
+	struct pci_dev *pdev = s->private;
+	union st_info info;
+	unsigned int cpu;
+
+	if (v == SEQ_START_TOKEN) {
+		seq_printf(s, "%-4s %-6s %-6s %-12s %-6s %-6s %s\n",
+			   "cpu", "vm_st", "vm_xst", "vm_ph_ignore",
+			   "pm_st", "pm_xst", "pm_ph_ignore");
+		return 0;
+	}
+
+	cpu = (unsigned long)v - 2;
+
+	if (tph_get_cpu_st_info(pdev, cpu, &info)) {
+		seq_printf(s, "%-4u %-6s %-6s %-12s %-6s %-6s %s\n", cpu,
+			   "-", "-", "-", "-", "-", "-");
+		return 0;
+	}
+
+	seq_printf(s, "%-4u %-6s %-6s %-12u %-6s %-6s %u\n", cpu,
+		   tph_st_str(vm_st, info.vm_st_valid, info.vm_st, 2),
+		   tph_st_str(vm_xst, info.vm_xst_valid, info.vm_xst, 4),
+		   (unsigned int)info.vm_ph_ignore,
+		   tph_st_str(pm_st, info.pm_st_valid, info.pm_st, 2),
+		   tph_st_str(pm_xst, info.pm_xst_valid, info.pm_xst, 4),
+		   (unsigned int)info.pm_ph_ignore);
+
+	return 0;
+}
+
+static const struct seq_operations tph_cpu_st_sops = {
+	.start	= tph_cpu_st_start,
+	.next	= tph_cpu_st_next,
+	.stop	= tph_cpu_st_stop,
+	.show	= tph_cpu_st_show,
+};
+DEFINE_SEQ_ATTRIBUTE(tph_cpu_st);
+
+static void tph_debugfs_add_cpu_st(struct pci_dev *pdev)
+{
+	if (!pci_is_pcie(pdev) ||
+	    pci_pcie_type(pdev) != PCI_EXP_TYPE_ROOT_PORT)
+		return;
+
+	if (!tph_dsm_supported(pdev))
+		return;
+
+	debugfs_create_file("tph_cpu_st", 0444, pci_dev_debugfs_dir(pdev),
+			    pdev, &tph_cpu_st_fops);
+}
+#else
+static void tph_debugfs_add_cpu_st(struct pci_dev *pdev) { }
+#endif /* CONFIG_ACPI && CONFIG_DEBUG_FS */
+
 /* Update the TPH Requester Enable field of TPH Control Register */
 static void set_ctrl_reg_req_en(struct pci_dev *pdev, u8 req_type)
 {
@@ -536,6 +666,12 @@ void pci_tph_init(struct pci_dev *pdev)
 	int num_entries;
 	u32 save_size;
 
+	/*
+	 * A Root Port has no ST table of its own, but it is where the
+	 * firmware ST mapping of its host bridge is exposed.
+	 */
+	tph_debugfs_add_cpu_st(pdev);
+
 	pdev->tph_cap = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_TPH);
 	if (!pdev->tph_cap)
 		return;
-- 
2.55.0


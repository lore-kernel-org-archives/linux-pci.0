Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010067.outbound.protection.outlook.com [52.101.56.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B164FE2CE;
	Fri, 18 Sep 2026 14:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789743431; cv=fail; b=KGI2U3xVZ/LFVpL1b2Y3BsXaH1zjNAfcr9JrNVYrHZ9XXbUaxX1CfP0HGo3CCenv/ZJJfktc5PkKACnBo6kRy0LiVAl+EoMXNIfwQ5yuseR2l0KvPaklzD6k8XEHWU2YrGr7IkzBSKvjkj9o+XAAWV0X29PCefPSKJPtAF6HmA0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789743431; c=relaxed/simple;
	bh=kSHot8/hvEMPsIl9d05qUKCsqxi09TLkdVjmNgXqXIo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jwaXyjgUDiog3dugzhHSSotDm8lQvyiO4vkqVQp2KdRD+vat3Tj7igb1f/Wxqvw5RyMmFrfFeYqIKu/3tow6dD3AtTYBuyJlRrYvSuecGI6YpO1dprAB6oIXXwRzLWa2qb4jcWFyw5PCW21n8GrPoZI5d74uCO4kpoFT+yCo5gU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=crPeWY/U; arc=fail smtp.client-ip=52.101.56.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="crPeWY/U"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cJjVQQVoQpCquqlAX3fdQUfugwaeQBFcKJEEWyjM2I8n/h4TZhtN5IGdqqMnU5tg5tMrrgk2iUtNMb7enpIHYKvvS3LX5G4h8v6+FmAAS5t8DTOKO7Tx8twYKb2e2lxdFel9Fnr4ETEWLrxkWU/lCH6oJxIPBwME+ZD8Y8ur0xOwMnruKmQcENTyE1A1+fPUAikL6oGoOj/JUysY7/xtsiB3+6+V0FUrDrzvY0JouvJmopJ/him4kAjL0CsqDwjba39mQXB/r5XeVWdaP34dbJemRPOzTyD2o4fnrNbWO/PcSu3ErUKa1I4VRbCc6IHjOF+ulq09KXgkQAKtU47m9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b0aAb9AOdB8UvJlawE2kKNMMUALij+YUstcRWH0liE4=;
 b=gUk4JDCQvk81+oACpqJtnJuYQ36lAl46aWvP408gwQ7iidcf7LRdZkvg5IY/jRJAQkG5bKeYKiwcpIzw+3VJF/fq9k8CUoqcEwOUklfClq6K+mVrthWm34th9naXQZCpclnd1cnihR6IriDHOKPzl7XUAs+RvwKRlWw8+LoO5g60poskMt5n3WpK+P5Wp0ylgW85esYffOkNdIbLlD4K4EF1L3NPamCDFqC2yLHs4CjLF2Elj35hcPUE4a3B3KMkW+G/dkHZWrYZPJlfyFcmDmeSzJjeVZnOalMupIdnUtJsFuTgFWrr5ZFyiGpYrZJaa/mOPOBwVQy9vOLo8vvyug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b0aAb9AOdB8UvJlawE2kKNMMUALij+YUstcRWH0liE4=;
 b=crPeWY/UgrmgFZNK7qERkc2ivClbXAu5wH+ksB5LapDC9mHh7hL3j+wMOS1fxfqxLxnyy1qnuo9EeVzwBWJXP7zV9vm3mvYmj7uevhobs2xG22K8RXM+GkO0cfcMz9fsnChh6/qgOazImvWsiTlER4MTFPZi8yRsOGr0kIPTwsE=
Received: from CH2PR15CA0009.namprd15.prod.outlook.com (2603:10b6:610:51::19)
 by DM3PR12MB9391.namprd12.prod.outlook.com (2603:10b6:0:3d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 14:56:55 +0000
Received: from CH2PEPF00000145.namprd02.prod.outlook.com
 (2603:10b6:610:51:cafe::10) by CH2PR15CA0009.outlook.office365.com
 (2603:10b6:610:51::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Fri,
 18 Sep 2026 14:56:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000145.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Fri, 18 Sep 2026 14:56:55 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 18 Sep
 2026 09:56:53 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <linux-pci@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-edac@vger.kernel.org>, <bhelgaas@google.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>
Subject: [PATCH v2 10/10] PCI/FLIT: Expose the error counter controls through sysfs
Date: Fri, 18 Sep 2026 09:56:18 -0500
Message-ID: <20260918145619.3016889-11-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260918145619.3016889-1-yazen.ghannam@amd.com>
References: <20260918145619.3016889-1-yazen.ghannam@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000145:EE_|DM3PR12MB9391:EE_
X-MS-Office365-Filtering-Correlation-Id: b433535c-73a9-4471-98ec-08df159514d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|376014|82310400026|1800799024|10067099003|6133799003|18002099003|22082099003|56012099006|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info:
	UCpsDsrTfPu4GP8CrqhMV8GyPB3utGDFNwdBqgQpmkhNhqSs2E+0DLIJ9JB63WuAlFPzmM/P+ll0A015494L6XrInwLGW9Vp/MdWiFAWbHFD6QQYGZuC0Lsct4PQS3WMSBZGZCopB4w56X76tD24rml4kHC2RSdUyv2rdn8vUw/UFH8oNqiqCXZRuVh4g63gP3ftOaPhP0/weqzYTPnK4IwOZQ3JmzMmxP/qnVE8coMGkl4NxLYD+SR76uy3cPrXg7IngcAr/6IzfSUGJTOH42YVIkoaSlsgwyqHASuE0UVON48ToX8pggRK+u2Hnm0capMIN9lEoDo9LRIabdFMwIVwg4MNx4vFQgVwH0Jl+Ibvy8kZiyvIGg49LXHiNWKWqfv+larg/3iX8GRE/OLl8goTvZw8XStNQE50+i9FauIi75tg51SvivQkaSquhTJCVFLM8hQCInD4Ozut437DOwu8eMaQAdhM94LMRrfm1hm52kUDBrJO8fcCKR97JirYkzVliflWdQRr5Sd9qNWJoWFBv5Y8JU3p1Xa8ghzLMnMB+54iSlXvcQwdRyk/OhHOHG9rJ98UZbgG7E3pMcdEOPenacw/1MbhHvIOaiiFxCFP9zwcOxUyArOhPj4XSI6iCO5oGtJSZQbZXTiXSic3xpDwe03RpFfAcRxuFRn/mLUdh9ND/vYiwOgMs4fHKaGYa3LO73Kmv5+PTQoBIY0WvQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(376014)(82310400026)(1800799024)(10067099003)(6133799003)(18002099003)(22082099003)(56012099006)(5023799004)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	1Wx7GHSp61LVqrxOKqbWz6hvytwTo5Auca9sVTjPnnzePasmpEiSyERjzewKPAEAItEp8kwGaLRjBNvhNxlXDt/zask2LnOnw/0ps5lXQrsSubeVmNxVARdXypLUnV8TT1RhyXAcqCzUaU2UYqqJX4RSZeEQNbyzQQRt6zjCIB23QwKffA90LF3ebUTGRpLMgJhFBbeGIRxn9vtrQ9Cxlagg3s+DZXg4bI1e1wef26iKg3kNlw7cNSHebVdW/+RMkoQ/ZFrTwsQWcWB5JPjZgpplUMvWb/aaxeSPjWmxSHbQa2Q7Cnie1mUjXyPNkHxzA5jcmtxmCjPz5r3rAaYmUYLl2Dohwx9KcT/mFzbA2vmu3epwUduCLj9wo71CsXV1Xt07oswcmy+1EJUa5/96j/15J7UV3yX3u46BX7U5qBLDp+RuG2ayouodohIcRJI+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 14:56:55.3002
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b433535c-73a9-4471-98ec-08df159514d2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000145.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9391

The Flit Error Counter only generates an event when the Flit Error
Counter exceeds Trigger Event on Error Count, and the counter drains on
its own at a rate set by the link width and encoding. The driver picks a
default for that field when the platform leaves it at zero, but the
right threshold depends on the link and on how noisy an error rate is
worth reporting. Which events the counter counts at all is likewise a
policy choice, not something the driver can pick for every user.

Expose both fields of the Flit Error Counter Control register through
the per-device "flit" sysfs group, gated on CAP_SYS_ADMIN like the
ratelimit attributes beside them.

Track the trigger in struct flit_info rather than rereading it from the
register on every enable. Sampling the register only works while nothing
but the platform writes it. Once the value can come from sysfs, a zero
means "the user asked for no events" rather than "the platform left it
alone", and rederiving the default would put it back on the next resume.

Apply each write to the extended capability save buffer as well.
pcie_portdrv_slot_reset() restores that buffer after running the
.slot_reset callbacks, so it is the last writer on the recovery path and
would otherwise put the probe-time settings back.

These attributes are the first user-context config accesses in this
driver, so hold a runtime PM reference across them.

Assisted-by: LLM
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 .../ABI/testing/sysfs-bus-pci-devices-flit    |  35 ++++
 drivers/pci/pcie/flit.c                       | 156 +++++++++++++++++-
 include/uapi/linux/pci_regs.h                 |   1 +
 3 files changed, 186 insertions(+), 6 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-pci-devices-flit b/Documentation/ABI/testing/sysfs-bus-pci-devices-flit
index 43d7c7aacf81..01f22ac9ebf6 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci-devices-flit
+++ b/Documentation/ABI/testing/sysfs-bus-pci-devices-flit
@@ -33,3 +33,38 @@ Description:	Ratelimit burst for flit error logs. Writing a value changes
 		Writing 0, or any negative value, suppresses all logs
 		unless the interval attribute is also 0. Default is
 		DEFAULT_RATELIMIT_BURST (10).
+
+What:		/sys/bus/pci/devices/<dev>/flit/trigger_count
+Date:		September 2026
+KernelVersion:	7.4.0
+Contact:	linux-pci@vger.kernel.org
+Description:	Trigger Event on Error Count field of the Flit Error Counter
+		Control register. An event is generated when the Flit Error
+		Counter exceeds this value. Accepts 0 to 255. Reading gets
+		the current field value.
+
+		The counter is eight bits and decrements on its own at a
+		rate set by the link width and encoding, so a high value
+		reports only a link whose error rate greatly exceeds that
+		drain rate. Writing 0 disables event generation, and 255
+		can never be exceeded, so neither value generates an event.
+
+		A value set by the platform is left alone. Default is 254
+		where the platform left the field at zero.
+
+What:		/sys/bus/pci/devices/<dev>/flit/events_to_count
+Date:		September 2026
+KernelVersion:	7.4.0
+Contact:	linux-pci@vger.kernel.org
+Description:	Events to Count field of the Flit Error Counter Control
+		register, selecting which events the Flit Error Counter
+		counts. Reading gets the current field value::
+
+		    0  FEC-correctable Flit, Invalid Flit, or Framing Error
+		    1  FEC-correctable Flit
+		    2  Invalid Flit
+		    3  the events selected by 0, plus a 1b/1b TS Ordered Set
+		       with only one valid half, and an invalid Ordered Set
+
+		The driver never writes this field on its own, so it
+		defaults to the value set by the platform.
diff --git a/drivers/pci/pcie/flit.c b/drivers/pci/pcie/flit.c
index 252bbb54e617..33ec1b9c385c 100644
--- a/drivers/pci/pcie/flit.c
+++ b/drivers/pci/pcie/flit.c
@@ -13,6 +13,7 @@
 #define dev_fmt pr_fmt
 
 #include <linux/bitfield.h>
+#include <linux/capability.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/pci.h>
@@ -79,11 +80,14 @@ static bool flit_is_native(struct pci_dev *pdev)
 struct flit_info {
 	spinlock_t lock;	/* serializes Counter Control read-modify-write */
 	struct ratelimit_state ratelimit;
+	u16 trigger;		/* Trigger Event on Error Count to program */
 	bool cntr_enabled;	/* Counter Enable as the driver intends it */
 };
 
 void pci_flit_init(struct pci_dev *pdev)
 {
+	u16 ctrl, trigger;
+
 	if (!flit_is_port(pdev) || !flit_is_native(pdev))
 		return;
 
@@ -103,6 +107,17 @@ void pci_flit_init(struct pci_dev *pdev)
 			     DEFAULT_RATELIMIT_INTERVAL,
 			     DEFAULT_RATELIMIT_BURST);
 
+	/*
+	 * Sample the trigger before anything here writes the register. A zero
+	 * field means the platform left it alone, so fall back to the default.
+	 * From here on flit_info->trigger is what gets programmed, so a zero
+	 * written through sysfs stays zero.
+	 */
+	pci_read_config_word(pdev, pdev->flit_cap + PCI_FLIT_ERR_CNTR_CTRL,
+			     &ctrl);
+	trigger = FIELD_GET(PCI_FLIT_ERR_CNTR_CTRL_TRIGGER, ctrl);
+	pdev->flit_info->trigger = trigger ? trigger : FLIT_DEFAULT_TRIGGER;
+
 	pci_add_ext_cap_save_buffer(pdev, PCI_EXT_CAP_ID_FLIT, sizeof(u16));
 
 	pci_dbg(pdev, "Flit Logging Extended Capability present.\n");
@@ -164,16 +179,24 @@ void pci_restore_flit_state(struct pci_dev *pdev)
  * Count at zero, and per PCIe r6.4, sec 7.7.8.4, table 7-95, a zero trigger
  * never generates an event.
  */
-static void flit_cntr_ctrl_update(struct pci_dev *pdev, u16 clear, u16 set)
+static void __flit_cntr_ctrl_update(struct pci_dev *pdev, u16 clear, u16 set)
 {
-	unsigned long flags;
 	u16 ctrl;
 
-	spin_lock_irqsave(&pdev->flit_info->lock, flags);
+	lockdep_assert_held(&pdev->flit_info->lock);
+
 	pci_read_config_word(pdev, pdev->flit_cap + PCI_FLIT_ERR_CNTR_CTRL, &ctrl);
 	ctrl &= ~clear;
 	ctrl |= set;
 	pci_write_config_word(pdev, pdev->flit_cap + PCI_FLIT_ERR_CNTR_CTRL, ctrl);
+}
+
+static void flit_cntr_ctrl_update(struct pci_dev *pdev, u16 clear, u16 set)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&pdev->flit_info->lock, flags);
+	__flit_cntr_ctrl_update(pdev, clear, set);
 	spin_unlock_irqrestore(&pdev->flit_info->lock, flags);
 }
 
@@ -186,9 +209,130 @@ static void flit_cntr_ctrl_update(struct pci_dev *pdev, u16 clear, u16 set)
 PCI_RATELIMIT_INTERVAL_ATTR(ratelimit_interval_ms, flit_info->ratelimit);
 PCI_RATELIMIT_BURST_ATTR(ratelimit_burst, flit_info->ratelimit);
 
+/*
+ * Program a durable setting into the register and the save buffer.
+ * pcie_portdrv_slot_reset() restores that buffer after running .slot_reset, so
+ * it is the last writer on the recovery path and would otherwise put the
+ * probe-time word back.
+ *
+ * Both writes happen under the lock, so the register and the buffer cannot
+ * disagree if trigger_count and events_to_count are written at once. The
+ * buffer gets the same clear and set rather than a fresh sample, which would
+ * pick up the Counter Enable that flit_isr() leaves clear for flit_ist().
+ */
+static void flit_cntr_ctrl_set(struct pci_dev *pdev, u16 clear, u16 set)
+{
+	struct pci_cap_saved_state *save_state;
+	unsigned long flags;
+	u16 *cap;
+
+	save_state = pci_find_saved_ext_cap(pdev, PCI_EXT_CAP_ID_FLIT);
+	cap = save_state ? (u16 *)&save_state->cap.data[0] : NULL;
+
+	pci_config_pm_runtime_get(pdev);
+
+	spin_lock_irqsave(&pdev->flit_info->lock, flags);
+	__flit_cntr_ctrl_update(pdev, clear, set);
+	if (cap) {
+		*cap &= ~clear;
+		*cap |= set;
+	}
+	spin_unlock_irqrestore(&pdev->flit_info->lock, flags);
+
+	pci_config_pm_runtime_put(pdev);
+}
+
+/* A port in D3cold answers config reads with all ones. */
+static u16 flit_cntr_ctrl_read(struct pci_dev *pdev)
+{
+	u16 ctrl;
+
+	pci_config_pm_runtime_get(pdev);
+	pci_read_config_word(pdev, pdev->flit_cap + PCI_FLIT_ERR_CNTR_CTRL,
+			     &ctrl);
+	pci_config_pm_runtime_put(pdev);
+
+	return ctrl;
+}
+
+static ssize_t trigger_count_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	u16 ctrl, trigger;
+
+	ctrl = flit_cntr_ctrl_read(pdev);
+	trigger = FIELD_GET(PCI_FLIT_ERR_CNTR_CTRL_TRIGGER, ctrl);
+
+	return sysfs_emit(buf, "%u\n", trigger);
+}
+
+static ssize_t trigger_count_store(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf, size_t count)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	u16 val;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	if (kstrtou16(buf, 0, &val) < 0)
+		return -EINVAL;
+
+	if (val > FIELD_MAX(PCI_FLIT_ERR_CNTR_CTRL_TRIGGER))
+		return -EINVAL;
+
+	pdev->flit_info->trigger = val;
+	flit_cntr_ctrl_set(pdev, PCI_FLIT_ERR_CNTR_CTRL_TRIGGER,
+			   FIELD_PREP(PCI_FLIT_ERR_CNTR_CTRL_TRIGGER, val));
+
+	return count;
+}
+
+static DEVICE_ATTR_RW(trigger_count);
+
+static ssize_t events_to_count_show(struct device *dev,
+				    struct device_attribute *attr, char *buf)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	u16 ctrl, events;
+
+	ctrl = flit_cntr_ctrl_read(pdev);
+	events = FIELD_GET(PCI_FLIT_ERR_CNTR_CTRL_EVENTS, ctrl);
+
+	return sysfs_emit(buf, "%u\n", events);
+}
+
+static ssize_t events_to_count_store(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf, size_t count)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	u16 val;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	if (kstrtou16(buf, 0, &val) < 0)
+		return -EINVAL;
+
+	if (val > FIELD_MAX(PCI_FLIT_ERR_CNTR_CTRL_EVENTS))
+		return -EINVAL;
+
+	flit_cntr_ctrl_set(pdev, PCI_FLIT_ERR_CNTR_CTRL_EVENTS,
+			   FIELD_PREP(PCI_FLIT_ERR_CNTR_CTRL_EVENTS, val));
+
+	return count;
+}
+
+static DEVICE_ATTR_RW(events_to_count);
+
 static struct attribute *flit_attrs[] = {
 	&dev_attr_ratelimit_interval_ms.attr,
 	&dev_attr_ratelimit_burst.attr,
+	&dev_attr_trigger_count.attr,
+	&dev_attr_events_to_count.attr,
 	NULL
 };
 
@@ -223,9 +367,9 @@ static void flit_cntr_enable(struct pci_dev *pdev)
 	spin_lock_irqsave(&pdev->flit_info->lock, flags);
 	pci_read_config_word(pdev, flit + PCI_FLIT_ERR_CNTR_CTRL, &reg);
 
-	/* Set default trigger count if not set by platform, since zero never fires */
-	if (!(reg & PCI_FLIT_ERR_CNTR_CTRL_TRIGGER))
-		reg |= FIELD_PREP(PCI_FLIT_ERR_CNTR_CTRL_TRIGGER, FLIT_DEFAULT_TRIGGER);
+	reg &= ~PCI_FLIT_ERR_CNTR_CTRL_TRIGGER;
+	reg |= FIELD_PREP(PCI_FLIT_ERR_CNTR_CTRL_TRIGGER,
+			  pdev->flit_info->trigger);
 
 	reg |= PCI_FLIT_ERR_CNTR_CTRL_EN | PCI_FLIT_ERR_CNTR_CTRL_INTR_EN;
 	pci_write_config_word(pdev, flit + PCI_FLIT_ERR_CNTR_CTRL, reg);
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 73482024359b..bf55b2e42ce3 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -1200,6 +1200,7 @@
 #define PCI_FLIT_ERR_CNTR_CTRL		0x0c		/* Flit Error Counter Control Register */
 #define  PCI_FLIT_ERR_CNTR_CTRL_EN	0x0001		/* Flit Error Counter Enable */
 #define  PCI_FLIT_ERR_CNTR_CTRL_INTR_EN	0x0002		/* Flit Error Counter Interrupt Enable */
+#define  PCI_FLIT_ERR_CNTR_CTRL_EVENTS	0x000c		/* Events to count */
 #define  PCI_FLIT_ERR_CNTR_CTRL_TRIGGER	0x0ff0		/* Trigger Event on Error Count */
 #define PCI_FLIT_ERR_CNTR_STA		0x0e		/* Flit Error Counter Status Register */
 #define  PCI_FLIT_ERR_CNTR_STA_INTR_GEN	0x0008		/* Interrupt Generated based on Trigger */
-- 
2.43.0


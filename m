Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012038.outbound.protection.outlook.com [52.101.48.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E78399890;
	Fri, 16 Oct 2026 16:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792167625; cv=fail; b=nYN/1HKUUOjgxv2HJ3sT4Uw7aUKXzjG0WhNDerXKyixGYjQp+6CNtrADUNOE8dv6nTYp/uQKA226hcY5VY1tLK+zbfPE3SJt1SdGxtOUQ45s0NI7vbE19oALnvykVOA0gXmy6nfLyIqUFVW+al/oj5a2eVoocQA5JWLOSNrupk8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792167625; c=relaxed/simple;
	bh=ZZxxEwukw1H/TNoO5JxWZ4OJvIJXABCrmL+que5JhHU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=opurD5ddjUVb4QInE0nAUA5IyMS51tYK8r3b7fabr1Y7ngkgqplsaMSmhHQN2stWAckqDrzOcMZWwSlXfbpz+9MK51/X2kXgingfCmKJ/RNRhEDk9HZ4q5wka7yjCSPqfK10tsofLkbPupWRFrRzEaqINkVjO3Y1fv6df6F300c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=S1lkIcor; arc=fail smtp.client-ip=52.101.48.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="S1lkIcor"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QGx0vE+cYhOYEGPP84KXjvakT8+CIFvaxTbMlC/R4TeLh2Nvfao1LyXm57ynJkyONs1uitaq8lfV+Aft+nPzP1c5IRLosqd/6SQHLvk3/imDsTL6wgHtMad2lcH3CtVg4It32zP16kjFYqjaNFl2JzBAYmnVPAtAYPmIYMrV+z36iWOvFjIWtLGDcaqGato8A4lNKbx6bG70wEjqPZLp6S5arbEOBB2XzrIEPWUZSnzOMmFvk6mZuzH40n0TuJ803qaEO5NVyX+b5/U/Qn60bDmGoVZiI+bc3AIGupi94HtOsymqVeQlZ87YOSaSyfT6S6fm5NG2kH4gvePlxAx7QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jAiVWZOjp332j0IMM7eQtQj7cueC30jM+IV0r3N7Sac=;
 b=l/UiV8OMtHWrOyUreNVXpw7Tb89ecFmaTEoLrgvI989Jizb+K1Esb2hImUNQslCJbsjX1QvF7bO5EL6i3Afv2/0VQkkzTh4ZW0WNDLv4OiZMJuCb9rEYdUFWGyrfKoxcIBIXHRUYe20PnYBePpO7TNMeRcx7cwCXK/yF6/jqu7RJc3HsSqXLBNu84oVbxTk+5Q+QFhahYFrkvZY3OeblIi2kYRemA1WKmjpLgBZll6oiT5/Bj3GeJEEq1vLsEDPS2iIEWFGh6HW4itJlxkBmBTKfwrlFWKkV5JKFiisOZ7vBVdvbyGQvQOHFXQU3kBI7P/y5z7kg+IOzMZLfNgSrqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jAiVWZOjp332j0IMM7eQtQj7cueC30jM+IV0r3N7Sac=;
 b=S1lkIcorQXdtAtJbUt4kK1F4HVhrxqPVXUmosAs/Bbwyal34yx7l/f2+7+ORd6utEZb5v0HrBGF2hYwb7BPIFMI7YR19zSA8jHh++xaOt4X3JKsEW7kFzaqXu9UUKAXojpC/yugT9QuvsZ5mqVewGS15T5h9hWYq+R7d6RFAqGx9yTs7g7FyKwmP9hHHclL7O1Ct1k1WwguSqNp1kUyDYP3K/tw7MhUFu9bOG1wBFLFwuoBmUx2LRC3RL6cz7FDx6ZOSoMSJLkKFHKHRfnwISEEIjw1u/bvMwLyHmlWN9Fbl6nTBvqcGum6719yzk0E3SQk2IRh/uP7wPs2SmoIU3w==
Received: from DM6PR01CA0006.prod.exchangelabs.com (2603:10b6:5:296::11) by
 DSVPR12MB066941.namprd12.prod.outlook.com (2603:10b6:8:4fe::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.17; Fri, 16 Oct 2026 16:20:17 +0000
Received: from CH01EPF000BE94B.namprd02.prod.outlook.com
 (2603:10b6:5:296:cafe::2f) by DM6PR01CA0006.outlook.office365.com
 (2603:10b6:5:296::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.17 via Frontend Transport; Fri,
 16 Oct 2026 16:20:17 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH01EPF000BE94B.mail.protection.outlook.com (10.167.244.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 16 Oct 2026 16:20:16 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 16 Oct
 2026 09:19:49 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 16 Oct 2026 09:19:40 -0700
From: <mhonap@nvidia.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>, <ankita@nvidia.com>,
	<jic23@kernel.org>, <dave.jiang@intel.com>, <alejandro.lucero-palau@amd.com>,
	<smadhavan@nvidia.com>, <corbet@lwn.net>, <skhan@linuxfoundation.org>,
	<dave@stgolabs.net>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <iweiny@kernel.org>, <ming.li@zohomail.com>,
	<yishaih@nvidia.com>, <skolothumtho@nvidia.com>, <kevin.tian@intel.com>,
	<bhelgaas@google.com>, <dmatlack@google.com>, <kees@kernel.org>,
	<gustavoars@kernel.org>
CC: <cjia@nvidia.com>, <kjaju@nvidia.com>, <vsethi@nvidia.com>,
	<zhiw@nvidia.com>, <mhonap@nvidia.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-hardening@vger.kernel.org>
Subject: [PATCH v6 05/31] PCI: Refuse bus and slot reset below a CXL port with SBR masked
Date: Fri, 16 Oct 2026 21:48:12 +0530
Message-ID: <20261016161839.2765592-6-mhonap@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261016161839.2765592-1-mhonap@nvidia.com>
References: <20261016161839.2765592-1-mhonap@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH01EPF000BE94B:EE_|DSVPR12MB066941:EE_
X-MS-Office365-Filtering-Correlation-Id: 0951db2d-ec6c-4706-e388-08df2ba15d9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|1800799024|376014|7416014|82310400026|921020|56012099006|11063799006|261009223027099003|18002099003|10067099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	+qS/DZfektzJdYVY0vPD/wb+FisIOFHY+0ng/jW27BmgFXZLCX/z5HAy1lka49kAHjUQPHFvs6TA84GhbM4+1/y3EQEJTK+rf++bi4WoYNyV3yh/3FPAEsyyUN1ld80Cmc1Bvmsc//bfctnClqHoOsbZwYtmYTRTk5YPP4U/GsJwUbSjyJeapZVgGlUclMQPEuVL7Tej42stct4Bm3dlJrGvbgkFdQk6bhZ1daa3wQQHVE549YwCzOIJEDnrLQ7lkCJegiLqgLrPIJ2HBzkNFT9aPgY/Ql0FXlTbHg7+e1JLHcazD3b07N7eUYGE1NwYxD8wZc6a/1iuCnXw18EPtj0/lrihunGSLkaMvlLIOPgPxCKSvTvUfnp9dtdsl7aPgML/1W1ypX356J1P/Zf+T/UUlstInqeeNOK5l4232lPF5zEoViSQEKBWYTp/g/kC9DJW/D5gsuD789yffGNmfLIgvuIhf3b5H9vENAn0EMLMS90+ygkeQQeAOqOv6h4Sbm3bCtwtcrjxu1WTJm5P6h9FZM2tgS+8z6uxmPLxjf0xxHO+1rffvdScW0Dv/yq/gywRuPiyBmKq2Bk4+JoPG/ETClib94n+qRpOKgubrvo7SEurFMvJ2c8VIQW7QpGfuNkTKSQWy4xLAPBNkvC+/7aKNyQ2iKAyND41JJ0AAyytGL10la2+hc+EyxkRRkNCv04DOCDdWkUGjGdoAWUBB7lIiK5XskhJHzBsSbZKaILyxDwh8r+U1EJBk/59Uj45
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(1800799024)(376014)(7416014)(82310400026)(921020)(56012099006)(11063799006)(261009223027099003)(18002099003)(10067099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	KwSLFKf1B0j2LN8UARwooHw9fCOIcZr1wgIZg218QZ7O8Tp+lkliumkZUcDL817PLVOfJj2PcTUrx6Qfu56iB/ALJVB4VVyGT6GE/0j5nuKWljgOWwVoL/FZGnih7J9ht+qpohRamei92awywgOFvsOpBFqhOnnMiMddPbek4ekmVNru10Y1+vKp9KNN1ZB2/2swEvcE2gM1Zq8zYMaAuc6v4LeKm3XsUUQUsjgFncWokbHS0uCiY0qJ95eGk+0/z8OtTDNl99fRcsfXBjwkdEqxnJfRP5vYc5vTbOXF/l7I5nlPjgug5XXlJB9YhUNm8v63bESpj2fFbvUIM32+GNolwc7oZPk1HdbYxQz2EJ6DCq5Vylii2yB7f5koF6BqDVkflzlrHpfhIdL3UuLPvgO7YjmSSFakh2MKsLsQQNUMKLlKd9P24HvjUq003B5H
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 16:20:16.8749
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0951db2d-ec6c-4706-e388-08df2ba15d9d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH01EPF000BE94B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB066941

From: Manish Honap <mhonap@nvidia.com>

A CXL port ignores the Secondary Bus Reset bit in Bridge Control unless
Unmask SBR is set in its CXL Port DVSEC (CXL r4.0 sec 8.1.5.2).
pci_reset_bus_function() already returns -ENOTTY in that case.
pci_reset_bus(), pci_probe_reset_bus() and the slot variants do not, so
they report success for a reset that reached no device below the port.

vfio-pci uses these for VFIO_DEVICE_GET_PCI_HOT_RESET_INFO and
VFIO_DEVICE_PCI_HOT_RESET. A user is then told a hot reset happened while
a CXL device below a masked port kept its state.

Return -ENOTTY from pci_probe_reset_slot() and pci_probe_reset_bus()
when the bridge above the bus is a CXL port with SBR masked.
pci_reset_bus() and pci_try_reset_bridge() probe before they reset, so
they refuse too.

Users see this in three places:
- the vfio hot reset ioctls fail (vfio reports -ENODEV when neither probe
  succeeds),
- the reset_subordinate sysfs attribute returns -ENOTTY,
- vfio-pci groups a device in a hotplug slot below such a port by bus
  instead of by slot.

Every other pci_reset_bus() caller, including the vfio bus reset at
close, is refused the same way. With one device per CXL port both
groupings have the same members.

Leave pci_bus_error_reset() as it is. AER and host bridge error recovery
call it without saving or restoring state and only map its result to
recovered or disconnect. Failing it below a masked port would turn
recovery of every CXL device there, memory expanders included, into a
disconnect; that is a CXL error handling decision, not part of this fix.

Assisted-by: LLM
Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 drivers/pci/pci.c | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index cecf8e681e69..87fe9de81acf 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4984,6 +4984,20 @@ static bool cxl_sbr_masked(struct pci_dev *dev)
 	return true;
 }
 
+/*
+ * A secondary bus reset below a CXL port with SBR masked does not reach the
+ * devices on the bus, so a bus or slot reset there would report success for
+ * a reset that did not happen. The probes and the save/restore resets that
+ * pci_reset_bus() and reset_subordinate use refuse it; error recovery
+ * (pci_bus_error_reset()) keeps its existing behavior.
+ */
+static bool pci_bus_cxl_sbr_masked(struct pci_bus *bus)
+{
+	struct pci_dev *bridge = bus->self;
+
+	return bridge && pcie_is_cxl(bridge) && cxl_sbr_masked(bridge);
+}
+
 static int pci_reset_bus_function(struct pci_dev *dev, bool probe)
 {
 	struct pci_dev *bridge = pci_upstream_bridge(dev);
@@ -5615,6 +5629,9 @@ static int pci_slot_reset(struct pci_slot *slot, bool probe)
  */
 int pci_probe_reset_slot(struct pci_slot *slot)
 {
+	if (slot && pci_bus_cxl_sbr_masked(slot->bus))
+		return -ENOTTY;
+
 	return pci_slot_reset(slot, PCI_RESET_PROBE);
 }
 EXPORT_SYMBOL_GPL(pci_probe_reset_slot);
@@ -5638,7 +5655,7 @@ static int pci_try_reset_slot(struct pci_slot *slot)
 {
 	int rc;
 
-	rc = pci_slot_reset(slot, PCI_RESET_PROBE);
+	rc = pci_probe_reset_slot(slot);
 	if (rc)
 		return rc;
 
@@ -5685,7 +5702,7 @@ static int pci_try_reset_bus(struct pci_bus *bus)
 {
 	int rc;
 
-	rc = pci_bus_reset(bus, PCI_RESET_PROBE);
+	rc = pci_probe_reset_bus(bus);
 	if (rc)
 		return rc;
 
@@ -5726,8 +5743,13 @@ static int pci_reset_bridge(struct pci_dev *bridge, bool restore)
 	if (list_empty(&bus->slots))
 		goto bus_reset;
 
+	/*
+	 * Probe without the CXL SBR mask check: error recovery keeps its
+	 * reset path below a masked CXL port, and pci_try_reset_slot() and
+	 * pci_try_reset_bus() refuse the restore path there.
+	 */
 	list_for_each_entry(slot, &bus->slots, list)
-		if (pci_probe_reset_slot(slot))
+		if (pci_slot_reset(slot, PCI_RESET_PROBE))
 			goto bus_reset;
 
 	list_for_each_entry(slot, &bus->slots, list) {
@@ -5773,6 +5795,9 @@ int pci_try_reset_bridge(struct pci_dev *bridge)
  */
 int pci_probe_reset_bus(struct pci_bus *bus)
 {
+	if (pci_bus_cxl_sbr_masked(bus))
+		return -ENOTTY;
+
 	return pci_bus_reset(bus, PCI_RESET_PROBE);
 }
 EXPORT_SYMBOL_GPL(pci_probe_reset_bus);
-- 
2.53.0


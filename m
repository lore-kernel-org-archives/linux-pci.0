Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011062.outbound.protection.outlook.com [40.107.208.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE93476CF6;
	Tue,  1 Sep 2026 09:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788255320; cv=fail; b=Tu23jzuoEq0xSCc9+yQ3vQdrH0BtDj48F/CFObFuMhHiIhsc14wATfkTuzXDOQXV6Hr+nD1hpJwNoqtmb9ZFYGvjUmwvknOJfKpDks8JXjh/RrxNorudQV7njNvvhy1A8JuAQG7WssNgCQtQrrN5n6xDDP2zSvGqm9keX2UnNBA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788255320; c=relaxed/simple;
	bh=Z0dl3DDxuON5u1Too572rkZuF5bkl8wwRDPwM9siBgM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l4OtihAdtmqTrBYa2fI3GlfPFouiN4CrTdCd/vvrYuPbuef3DuwEfYAvD53cLYJfgcOcWw2ywP4cqZEjCDhOPnvit+9Rihwn+1LglbAMH6VOyZcFynJx8ynO93zX33PQYSbIsytNs4g5uJtL0IV4emTYDjlK8/ICMUATMlgddh4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=p8zbi891; arc=fail smtp.client-ip=40.107.208.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="p8zbi891"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pPv+i5BZUHMxcFhyScnWavwRojZpIkDXac+nlBqooL7dL++H0wBq3mziqSMlySa9ppy+JaDXz/FRogQjvLMmP+VcRDyofjGpmFXYfskMYW8LRHWtKJ8bgJ1p6qpSKLrivo8+HmZN2qFplWz74/109m4Q9dNIKNg9srp+NTRzwoa5Re+8uV32nBdrhHKZLxWUjkNZsBsVTdOdhfVRzNUtTRWNbZOe2MHBS4C+jfLlAyRHHpv/6a5DVF7kncFIg8HwYdc9UMVyQj8MKC5LrvetmNdAGgytY+g9LGtgff7+LrQ30gGSC2L8/ZpochTWqUWfKfuXrXUvGFTgusF6BayF4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pEdwHkz6dN3IQa4vjkGr/lYpvq9DNJ3kkpniFi0X5B8=;
 b=hLhqVTWY18pIbXaFYisvrhKRLY4jODz+lw8uhkXw7lKQSJ4LwoeYj2Ua9nNK3P0a+zwba470T2ITGZ4EPCUyuLsitcYP6Zkdr58qrDee8lnO4HFrpYKxzvHIWkEZgEp7tlIjfQFj0S+EQj+uKfRWISCqXGcH//O554i0B4qku7oIM/hxjn6MLBfnLhMREulnWdsU2sEPfu2ULeGvnjkqAZeCSYrMJ0uHfEyIjdr8KkGotqRnOzI+XpLDVgjt24ThjotvO6AiSxO6YktkjOBWhONi3cQiUjPx2hj22CLMJkg0jv6z3Q8q0zlYcJY384f79uwuNq28Wtp1fQJxnyB5QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pEdwHkz6dN3IQa4vjkGr/lYpvq9DNJ3kkpniFi0X5B8=;
 b=p8zbi891pS9i/PxWhiyumHnL0kAIpkxXNuguy0CUtrmPAlLFVizDl1toMxuDYpBib4DOzs2Kr0fF6xtNU25/U5Moy3aDl2JkvEO2ppaijHykGdlSAvOcJaz+UANrPYw7nTiqLJv5FhzUU/YiLjKLLCSaETVgYfispPG47nqDT57mtqZ4u/urUVrqsGoDZt2Z+I05Wfi1y1mgaRmUJT08IrAUpJGCqEs9NIVE0FlN3wNTQtHwO02ATLrK+7IMPu/gWXDsq/Z4QoSur20k4EOGbmMAALDUQb0X/00thICTangtjTHn0KEO3bzoBQICjDWp+Dvr36WV5bZuMohH0OSHYw==
Received: from BN0PR04CA0187.namprd04.prod.outlook.com (2603:10b6:408:e9::12)
 by DM4PR12MB7598.namprd12.prod.outlook.com (2603:10b6:8:10a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 09:33:50 +0000
Received: from BL02EPF00021F6E.namprd02.prod.outlook.com
 (2603:10b6:408:e9:cafe::90) by BN0PR04CA0187.outlook.office365.com
 (2603:10b6:408:e9::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Tue, 1
 Sep 2026 09:33:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF00021F6E.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 09:33:50 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 02:33:32 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 02:33:29 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <alex@shazbot.org>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kbusch@meta.com>, <michal.winiarski@intel.com>,
	<satyanarayana.k.v.p@intel.com>, <sonangp@nvidia.com>, <nathanc@nvidia.com>,
	<mochs@nvidia.com>
Subject: [RFC PATCH 05/19] vfio/pci: Serialize config access with recovery
Date: Tue, 1 Sep 2026 10:32:03 +0100
Message-ID: <20260901093217.8539-6-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901093217.8539-1-skolothumtho@nvidia.com>
References: <20260901093217.8539-1-skolothumtho@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6E:EE_|DM4PR12MB7598:EE_
X-MS-Office365-Filtering-Correlation-Id: fa934fc9-6f14-484b-5929-08df080c2188
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|23010399003|376014|22082099003|18002099003|56012099006|5023799004|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	BfndhIeUOauJk3FgMLoW0IW1G/EzvE2fPvW8UeKTivsslCGkp/BCtFlQsiinPuZr1/cJHWyIf25lkCZLHYXW21pgvl6K7cQsiCC598n8P4qiz0whfkkESBI4sHy7TxQ3yc6/1KNrW3YMwhpufv/rXa7NuN5+0h3TByS/wok8zz10Ul3xlvHuJrtshDod2Wbwms4IrgHsRsUyiE+Iu4/dQp0gjNU2Srko1lnzlV40zYy6IMWtrPLzLoh552Tz27IWB5f5+plmmdXrMGnc5rolRC1X4a3s1mXyfVkO5NF+cTdAAu0UF9cJkBU2WwgjivqT4rQtiF8SKY8eQVq2i8YDXO9iBDrDG985iC2EZvJl4MibblfwFUVoJOtm1xtfZnx+Hb5OEj/TRf2YjR1BPaPnNsWqnjBO4mnIH3ixODBs5sMR0sF8WDmkT5HBO2OuLd/gYUdP1PW3fpEB90OkQBIpMPGhNNT75zp8FzBYGFhBSSBmbVdkwUEKHXDshE7jRn0h6LHCPQXLG9S6n/ufq4yZPxDVXsw1ohadAxgnZrKvL8yM04ThwTxn1Ptg7um72Wp4oyRi+cXiH+4JA+yIqH98FRxgXCitz0IGTkQ/B4QgLpHdlNW8jpa23DH2rpo8b3ng53MJafL1kJ+cmZ9MXTkW/7SYywAX2qur6JdYAzhyGzOoNrFEAncYlKhn/rrxrtwbm7eWzL+mkDIaIqtoGGvKNA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(23010399003)(376014)(22082099003)(18002099003)(56012099006)(5023799004)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	P9TfxyqI1Iza1JL+vMlHOFfzMW4tTVcYNGDXAo5GvXHgAZehfS1T7iBOWMwC08ZVThTSotoZf1Gs4Ddbedj0FS3CG5J3q9KWafLjQ6yV4wJ7olHiW9dzdQT8V1XbGBRkBg6h4nu/7DwJsIwml2njo7mnc09VyAE/K7hZ2BjuK8Jd+T9kYeoEVGOxqTtZuGdbccsFXDOqKBsrLCL7mY55onU914niBIOJlqt51uqoEKNMXdNFw/pKCdmFkQnvkh7E8nrJd1ewC5vK0qmTImawgIG1kN8pG/J6po+smfNgDKZnCSv8p3P84FKTp+3cP/GO9YZJAOiBnHQtNag1Opw08vCF0B2NNRCWJvo/TbJFQds0rDTtFSQey3EAWUgPNC2d9o306VBDADxa83WMQfyT7I1LSGMcvWtt1N6w/XJcsaISRffBgkqC0ePA+xo9GV6B
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 09:33:50.3290
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa934fc9-6f14-484b-5929-08df080c2188
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7598

Hold recovery_lock for reading across each config space operation, so
recovery can shut out new ones and wait for whatever is already running.
The user copies stay outside the lock, since a copy can fault.

Take the lock in the dispatcher rather than around the individual
hardware accessors. That means once recovery blocks access every config
read fails with -EIO, even a read served entirely from vconfig which
never touches the device. Userspace which wants to know what is going on
reads the device feature instead. That one stays available during an
event.

The PCIe and AF capability writes no longer reset the device themselves,
and the power management write no longer moves it to D0 itself. They
record what was asked for and the dispatcher does it after dropping
recovery_lock. Both take pci_bus_sem, which AER already holds when it
calls into the driver, so doing either inside the lock would be the wrong
order. A reset method reaches it directly, and a D0 transition reaches it
through pci_set_full_power_state() calling
pcie_aspm_pm_state_change(). The lower power states take neither, so
those still run in the writefn. The writefn declaration says so.

Both stay best effort, as the guest requested FLR always was. The result
is not reported back through the config write. With recovery enabled they
are dropped while a recovery or reset is already in flight, since that
leaves the device in D0 and reset anyway. The reset helper tests the
recovery state for itself. The power up does not, so the dispatcher
tests it before that one.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 drivers/vfio/pci/vfio_pci_config.c | 147 ++++++++++++++++++++---------
 1 file changed, 102 insertions(+), 45 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
index 9914f3ac69ae..3365100acf21 100644
--- a/drivers/vfio/pci/vfio_pci_config.c
+++ b/drivers/vfio/pci/vfio_pci_config.c
@@ -99,6 +99,12 @@ static const u16 pci_ext_cap_length[PCI_EXT_CAP_ID_MAX + 1] = {
 	[PCI_EXT_CAP_ID_DVSEC]	=	0xFF,
 };
 
+/* What a config write asked for which has to wait for the access guard. */
+struct vfio_pci_config_deferred {
+	bool	flr;		/* a function-level reset */
+	bool	power_up;	/* a transition to D0 */
+};
+
 /*
  * Read/Write Permission Bits - one bit for each bit in capability
  * Any field can be read if it exists, but what is read depends on
@@ -111,8 +117,17 @@ struct perm_bits {
 	u8	*write;		/* writeable bits */
 	int	(*readfn)(struct vfio_pci_core_device *vdev, int pos, int count,
 			  struct perm_bits *perm, int offset, __le32 *val);
+	/*
+	 * @deferred records work the write asked for which a writefn must not
+	 * do itself. Both a reset method and a transition to D0 acquire
+	 * pci_bus_sem, which AER already holds when it enters the driver, so
+	 * doing either here would invert the lock order against recovery_lock.
+	 * The dispatcher does them after dropping recovery_lock. Callers zero
+	 * it, and a writefn only sets a field on a success return.
+	 */
 	int	(*writefn)(struct vfio_pci_core_device *vdev, int pos, int count,
-			   struct perm_bits *perm, int offset, __le32 val);
+			   struct perm_bits *perm, int offset, __le32 val,
+			   struct vfio_pci_config_deferred *deferred);
 };
 
 #define	NO_VIRT		0
@@ -200,7 +215,8 @@ static int vfio_default_config_read(struct vfio_pci_core_device *vdev, int pos,
 
 static int vfio_default_config_write(struct vfio_pci_core_device *vdev, int pos,
 				     int count, struct perm_bits *perm,
-				     int offset, __le32 val)
+				     int offset, __le32 val,
+				     struct vfio_pci_config_deferred *deferred)
 {
 	__le32 virt = 0, write = 0;
 
@@ -272,7 +288,8 @@ static int vfio_direct_config_read(struct vfio_pci_core_device *vdev, int pos,
 /* Raw access skips any kind of virtualization */
 static int vfio_raw_config_write(struct vfio_pci_core_device *vdev, int pos,
 				 int count, struct perm_bits *perm,
-				 int offset, __le32 val)
+				 int offset, __le32 val,
+				 struct vfio_pci_config_deferred *deferred)
 {
 	int ret;
 
@@ -299,7 +316,8 @@ static int vfio_raw_config_read(struct vfio_pci_core_device *vdev, int pos,
 /* Virt access uses only virtualization */
 static int vfio_virt_config_write(struct vfio_pci_core_device *vdev, int pos,
 				  int count, struct perm_bits *perm,
-				  int offset, __le32 val)
+				  int offset, __le32 val,
+				  struct vfio_pci_config_deferred *deferred)
 {
 	memcpy(vdev->vconfig + pos, &val, count);
 	return count;
@@ -563,7 +581,8 @@ static bool vfio_need_bar_restore(struct vfio_pci_core_device *vdev)
 
 static int vfio_basic_config_write(struct vfio_pci_core_device *vdev, int pos,
 				   int count, struct perm_bits *perm,
-				   int offset, __le32 val)
+				   int offset, __le32 val,
+				   struct vfio_pci_config_deferred *deferred)
 {
 	struct pci_dev *pdev = vdev->pdev;
 	__le16 *virt_cmd;
@@ -613,7 +632,8 @@ static int vfio_basic_config_write(struct vfio_pci_core_device *vdev, int pos,
 			vfio_bar_restore(vdev);
 	}
 
-	count = vfio_default_config_write(vdev, pos, count, perm, offset, val);
+	count = vfio_default_config_write(vdev, pos, count, perm, offset, val,
+					  deferred);
 	if (count < 0) {
 		if (offset == PCI_COMMAND)
 			up_write(&vdev->memory_lock);
@@ -727,9 +747,11 @@ static void vfio_lock_and_set_power_state(struct vfio_pci_core_device *vdev,
 
 static int vfio_pm_config_write(struct vfio_pci_core_device *vdev, int pos,
 				int count, struct perm_bits *perm,
-				int offset, __le32 val)
+				int offset, __le32 val,
+				struct vfio_pci_config_deferred *deferred)
 {
-	count = vfio_default_config_write(vdev, pos, count, perm, offset, val);
+	count = vfio_default_config_write(vdev, pos, count, perm, offset, val,
+					  deferred);
 	if (count < 0)
 		return count;
 
@@ -738,8 +760,15 @@ static int vfio_pm_config_write(struct vfio_pci_core_device *vdev, int pos,
 
 		switch (le32_to_cpu(val) & PCI_PM_CTRL_STATE_MASK) {
 		case 0:
-			state = PCI_D0;
-			break;
+			/*
+			 * Going to D0 reaches pci_set_full_power_state(),
+			 * which takes pci_bus_sem through
+			 * pcie_aspm_pm_state_change(). Leave it to the
+			 * dispatcher. The lower states do not, so they run
+			 * here.
+			 */
+			deferred->power_up = true;
+			return count;
 		case 1:
 			state = PCI_D1;
 			break;
@@ -799,7 +828,8 @@ static int __init init_pci_cap_pm_perm(struct perm_bits *perm)
 
 static int vfio_vpd_config_write(struct vfio_pci_core_device *vdev, int pos,
 				 int count, struct perm_bits *perm,
-				 int offset, __le32 val)
+				 int offset, __le32 val,
+				 struct vfio_pci_config_deferred *deferred)
 {
 	struct pci_dev *pdev = vdev->pdev;
 	__le16 *paddr = (__le16 *)(vdev->vconfig + pos - offset + PCI_VPD_ADDR);
@@ -812,7 +842,8 @@ static int vfio_vpd_config_write(struct vfio_pci_core_device *vdev, int pos,
 	 * of PCI_VPD_ADDR, then the PCI_VPD_ADDR_F bit is written and we
 	 * have work to do.
 	 */
-	count = vfio_default_config_write(vdev, pos, count, perm, offset, val);
+	count = vfio_default_config_write(vdev, pos, count, perm, offset, val,
+					  deferred);
 	if (count < 0 || offset > PCI_VPD_ADDR + 1 ||
 	    offset + count <= PCI_VPD_ADDR + 1)
 		return count;
@@ -881,21 +912,24 @@ static int __init init_pci_cap_pcix_perm(struct perm_bits *perm)
 
 static int vfio_exp_config_write(struct vfio_pci_core_device *vdev, int pos,
 				 int count, struct perm_bits *perm,
-				 int offset, __le32 val)
+				 int offset, __le32 val,
+				 struct vfio_pci_config_deferred *deferred)
 {
 	__le16 *ctrl = (__le16 *)(vdev->vconfig + pos -
 				  offset + PCI_EXP_DEVCTL);
 	int readrq = le16_to_cpu(*ctrl) & PCI_EXP_DEVCTL_READRQ;
 
-	count = vfio_default_config_write(vdev, pos, count, perm, offset, val);
+	count = vfio_default_config_write(vdev, pos, count, perm, offset, val,
+					  deferred);
 	if (count < 0)
 		return count;
 
 	/*
 	 * The FLR bit is virtualized, if set and the device supports PCIe
-	 * FLR, issue a reset_function.  Regardless, clear the bit, the spec
-	 * requires it to be always read as zero.  NB, reset_function might
-	 * not use a PCIe FLR, we don't have that level of granularity.
+	 * FLR, request a function reset once recovery_lock has been
+	 * released. Regardless, clear the bit, the spec requires it to be
+	 * always read as zero. NB, reset_function might not use a PCIe FLR,
+	 * we don't have that level of granularity.
 	 */
 	if (*ctrl & cpu_to_le16(PCI_EXP_DEVCTL_BCR_FLR)) {
 		u32 cap;
@@ -907,14 +941,8 @@ static int vfio_exp_config_write(struct vfio_pci_core_device *vdev, int pos,
 						 pos - offset + PCI_EXP_DEVCAP,
 						 &cap);
 
-		if (!ret && (cap & PCI_EXP_DEVCAP_FLR)) {
-			vfio_pci_zap_and_down_write_memory_lock(vdev);
-			vfio_pci_dma_buf_move(vdev, true);
-			pci_try_reset_function(vdev->pdev);
-			if (__vfio_pci_memory_enabled(vdev))
-				vfio_pci_dma_buf_move(vdev, false);
-			up_write(&vdev->memory_lock);
-		}
+		if (!ret && (cap & PCI_EXP_DEVCAP_FLR))
+			deferred->flr = true;
 	}
 
 	/*
@@ -968,19 +996,22 @@ static int __init init_pci_cap_exp_perm(struct perm_bits *perm)
 
 static int vfio_af_config_write(struct vfio_pci_core_device *vdev, int pos,
 				int count, struct perm_bits *perm,
-				int offset, __le32 val)
+				int offset, __le32 val,
+				struct vfio_pci_config_deferred *deferred)
 {
 	u8 *ctrl = vdev->vconfig + pos - offset + PCI_AF_CTRL;
 
-	count = vfio_default_config_write(vdev, pos, count, perm, offset, val);
+	count = vfio_default_config_write(vdev, pos, count, perm, offset, val,
+					  deferred);
 	if (count < 0)
 		return count;
 
 	/*
 	 * The FLR bit is virtualized, if set and the device supports AF
-	 * FLR, issue a reset_function.  Regardless, clear the bit, the spec
-	 * requires it to be always read as zero.  NB, reset_function might
-	 * not use an AF FLR, we don't have that level of granularity.
+	 * FLR, request a function reset once recovery_lock has been
+	 * released. Regardless, clear the bit, the spec requires it to be
+	 * always read as zero. NB, reset_function might not use an AF FLR,
+	 * we don't have that level of granularity.
 	 */
 	if (*ctrl & PCI_AF_CTRL_FLR) {
 		u8 cap;
@@ -992,14 +1023,8 @@ static int vfio_af_config_write(struct vfio_pci_core_device *vdev, int pos,
 						pos - offset + PCI_AF_CAP,
 						&cap);
 
-		if (!ret && (cap & PCI_AF_CAP_FLR) && (cap & PCI_AF_CAP_TP)) {
-			vfio_pci_zap_and_down_write_memory_lock(vdev);
-			vfio_pci_dma_buf_move(vdev, true);
-			pci_try_reset_function(vdev->pdev);
-			if (__vfio_pci_memory_enabled(vdev))
-				vfio_pci_dma_buf_move(vdev, false);
-			up_write(&vdev->memory_lock);
-		}
+		if (!ret && (cap & PCI_AF_CAP_FLR) && (cap & PCI_AF_CAP_TP))
+			deferred->flr = true;
 	}
 
 	return count;
@@ -1168,9 +1193,11 @@ static int vfio_msi_config_read(struct vfio_pci_core_device *vdev, int pos,
 
 static int vfio_msi_config_write(struct vfio_pci_core_device *vdev, int pos,
 				 int count, struct perm_bits *perm,
-				 int offset, __le32 val)
+				 int offset, __le32 val,
+				 struct vfio_pci_config_deferred *deferred)
 {
-	count = vfio_default_config_write(vdev, pos, count, perm, offset, val);
+	count = vfio_default_config_write(vdev, pos, count, perm, offset, val,
+					  deferred);
 	if (count < 0)
 		return count;
 
@@ -1889,6 +1916,8 @@ ssize_t vfio_pci_config_rw_single(struct vfio_pci_core_device *vdev,
 	struct perm_bits *perm;
 	__le32 val = 0;
 	int cap_start = 0, offset;
+	int access_ret;
+	struct vfio_pci_config_deferred deferred = {};
 	u8 cap_id;
 	ssize_t ret;
 
@@ -1957,14 +1986,42 @@ ssize_t vfio_pci_config_rw_single(struct vfio_pci_core_device *vdev,
 		if (copy_from_user(&val, buf, count))
 			return -EFAULT;
 
-		ret = perm->writefn(vdev, *ppos, count, perm, offset, val);
+		access_ret = vfio_pci_core_access_begin(vdev);
+		if (access_ret)
+			return access_ret;
+		ret = perm->writefn(vdev, *ppos, count, perm, offset, val,
+				    &deferred);
+		vfio_pci_core_access_end(vdev);
+		if (ret < 0)
+			return ret;
+		/*
+		 * Both of these take pci_bus_sem, so run them with the access
+		 * guard dropped. The reset re-checks the recovery state for
+		 * itself. The power up does not, so check it here.
+		 *
+		 * Both are best effort, as the guest-requested FLR has always
+		 * been. The result is not reported back through the config
+		 * write. Without recovery enabled the only failure is -EAGAIN
+		 * from device lock contention, exactly as before. With it they
+		 * are dropped while a recovery or reset transaction is in
+		 * flight, which leaves the device in D0 and reset anyway.
+		 */
+		if (deferred.power_up &&
+		    !(vdev->pci_recovery_supported &&
+		      READ_ONCE(vdev->pci_recovery_access_blocked)))
+			vfio_lock_and_set_power_state(vdev, PCI_D0);
+		if (deferred.flr)
+			vfio_pci_try_reset_function(vdev, false);
 	} else {
-		if (perm->readfn) {
+		access_ret = vfio_pci_core_access_begin(vdev);
+		if (access_ret)
+			return access_ret;
+		if (perm->readfn)
 			ret = perm->readfn(vdev, *ppos, count,
 					   perm, offset, &val);
-			if (ret < 0)
-				return ret;
-		}
+		vfio_pci_core_access_end(vdev);
+		if (ret < 0)
+			return ret;
 
 		if (copy_to_user(buf, &val, count))
 			return -EFAULT;
-- 
2.43.0


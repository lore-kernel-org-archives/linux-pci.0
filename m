Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.5
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794493202;
	b=sFyGM9BkBJqdjDY9qQDR5uVKNiS6WqsNGsnHa/0FOUxBbjkC3aMmhy5WuPSvIWMmT9F4
	 JpNL45GFOW8OHhbrSYawUoVVmgdRAWxcbarstydZp7YEdU4hh90+bQzZnsdGCMZ8sHUmX
	 iPafZmD2Ay9D3T0yH1GyOTWQiTAi/1myJAVNXVxTwloYcaLHG2+oC9GoznGs3prEKM2yM
	 b24lGtOK5nmXmyA37MLKZ+aiwP0d84az1qhroIxk5oGoiHa1Py6Vdy7ctEIa1MiOPCnS+
	 kCjibrdiquktCPoaqJGgeVApTlQ6looStmaQUGIEphpuyKrMukws4QQObEmk6AWi4pA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794493202;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-Originating-IP:X-ClientProxiedBy:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=1jpWj757V1cqF/9LdSIZysloX1wc9NdThlouoj2pIxM=;
	b=4P49sLy0PKPXDXUf4PlQ/kQ4WdueLJlChGpNWLBeqJN0ih81emnaOOkj/4X2cPv9AF+c
	 tyQlqOdiDN48IXaq2UJnZkAiQ1QGPHSVC7jrnuocl7WrRSgMkGvcvkb6v7meAZ3zyzlyk
	 FvtNluhhAgqoVV6iOqa9pyYemHPMtcNNNb72xnQHUntbLWa+0X5DR3qvXBzqjdN6k+1v2
	 0QRT2P4vj/Zu3pRNyjnqsXlI6tsLzHI8zc/3PbOH0Lid4uQ5GqXM35yS2oM94RgNg7mgb
	 iSvvLko7PiA9jfclCt/PRqETcaspf5ffOWPnJrvhDuADYpwaNmOlQNePmHaYTgcD01w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=C1iFuxoU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.5
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012005.outbound.protection.outlook.com [52.101.48.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D2A6072A3E;
	Thu, 12 Nov 2026 14:20:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7D2A6072A3E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=C1iFuxoU
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NO/uyqUon6cGbo8HoOtL0u3zWsZ5q1tCc2lDRqXXEF4Pudkp+5aXHuyntGE3GQ2bNGaLelmTyh+2ohetuBEy6XXZkkhj8PtZKd6LBz0diPeUMa119maK85OPEWaTCBQtSz+h/SDR8tcU3QXAQJPUzmgGzpTfcgQPVxvfCSuEw3Fx4vcAMNe0AWCBYHkv3Z5lUDl3wWEMvq0/TVQ9epWLAjlTKoc5EExUbhlID2xBNpjwcDtbAWEhJnoW+AyShiG9Zqd/m1jAnRbguQu7Y4TVQcO9taufbx5szCgmgxEnvGiUh0aDgGk/l6gzzQx5hK+HVrvOs8vCFKBFJID/SOrpMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1jpWj757V1cqF/9LdSIZysloX1wc9NdThlouoj2pIxM=;
 b=Z4fFK3IkV/cbF3lSYzDJs65gqBOsOwZAtjZLVg93LIp+NIa3Aoy+saq5gV0jwyYh2exOpdWx91GK4XSLrMgRl3bfTDAbDFmQNRaG00AYtcDbV/y1FHKhlpp0mduVrZbBlaQG05xOYDziiUcR7f1KRk/5opICwoXwQ4PiaPd2RssbyrI9cE63wskn+B91xuFvs5J9M23SFaSqqMnMwiN+7HIqMNcUgcNsEInwf1RgbjBVsvv4PxkiThytujzWX/OsryxtML4a4C1uXIiG8zfHEBBAJYCh3kTMSI7n5Zz+QcdEQgKuw6tSevjZPBwvF8nA7WLpm+/XWO26Dyc2BSQ70A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1jpWj757V1cqF/9LdSIZysloX1wc9NdThlouoj2pIxM=;
 b=C1iFuxoUR9kXPnnh0x6azGwI5FowqP+oxheQ4mIszJqEtZuxdbd+uE18DnKXLQ27gnmEIg93Jj+u/QLNEgD39egY8mbbEiQpSHXFs9h392A57dd54jTNKMgZeSkzUf4sDEw+cKR8p6JOL8O0nFwM2PBrpikKxRq7ydPVIP3L89uQWbUv2iFvRJkj+9HIxx9XRPq78qJUySNFYStYqCpQAZHxLlRBlOHRf1sq5cL8ByTtmMcKSdBggx8+pe353Dabn2BSnApH5FJLTGVowFsCnp2jz180U3qONUPbegYZ2mDTGwsSt5CLy2T2Jg+U0V8YgHju1jO3XEShpacFR1w2dw==
Received: from PH7PR17CA0003.namprd17.prod.outlook.com (2603:10b6:510:324::23)
 by MN0PR12MB6032.namprd12.prod.outlook.com (2603:10b6:208:3cc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Thu, 12 Nov
 2026 14:19:22 +0000
Received: from MWH0EPF000A6734.namprd04.prod.outlook.com
 (2603:10b6:510:324:cafe::6e) by PH7PR17CA0003.outlook.office365.com
 (2603:10b6:510:324::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.10 via Frontend Transport; Thu,
 12 Nov 2026 14:19:22 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000A6734.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 12 Nov 2026 14:19:21 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 12 Nov
 2026 06:18:59 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 12 Nov
 2026 06:18:56 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <alex@shazbot.org>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kbusch@meta.com>, <michal.winiarski@intel.com>,
	<satyanarayana.k.v.p@intel.com>, <sonangp@nvidia.com>, <ankita@nvidia.com>,
	<nathanc@nvidia.com>, <mochs@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [RFC PATCH v3 20/20] vfio/pci: Enable recovery for supported native PCIe endpoints
Date: Thu, 12 Nov 2026 14:16:32 +0000
Message-ID: <20261112141632.918954-21-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261112141632.918954-1-skolothumtho@nvidia.com>
References: <20261112141632.918954-1-skolothumtho@nvidia.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6734:EE_|MN0PR12MB6032:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bcc0ad4-3399-41de-e5ed-08df40c7f280
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|82310400026|376014|1800799024|56012099006|11063799006|22082099003|18002099003|6133799003|261021121427099003|261009223027099003|10067099003|261026140227099003|261028144727099003|261022113327099003|261022105027099003|261026121527099003|261021123027099003|3023799007|261102123227099003|261022075727099003;
X-Microsoft-Antispam-Message-Info:
	iZutvC3gmU7V5kotvSL0hy+FUmm60ai5VrragYJ/qsabZ5aPh/xQA22MUJxiSjw29DlmPrrrlcLQ0A43SJE/uOspa886k8qcgTrGRmH+Z19vMi4g9RtAyPYsp+UzbSNAAcVvD3OBRNIbCFxMDERQH18evyVMEQQmmioo4MQjMrfpzmbQuq8T0TgmV5FXUwd2dhoXL/SI+Tnk7L3gGiDKTpIxgvypR5wTySJX8ZbB78qRE0SFFTH2jlCnF4LZyAa6xWta630uU9kGHHhFuMUzvz7fPQclAO+LS0CwFhZ6Mc1LJksmIrZoLzmRZRz16q4E4/6UjCgDPRM7knoGwjjDDoqM3etneFbRXaK1Rsyml+bUO80eOdhkFyMZlvuQFFsqFJ73tJBTJGB69SM/kydM0i2r+/lMofZIZQ8wlj5CrnXzkxzfva1JhdVGk653rjQTUt4pBfciDNLbFBlgF7zSnfftSn4hmQrFAhAq7smEB8s7uLQq8dllsd2nYnj3n+nnT8qjW6Ch+sFyygcq76E1RhhgjN5csbMlslCXvskDvmVXx1XNG0maQliiheXTaUv6q8GuX7YkXs78tkB01aJ1MjJGNRcJTmtLk8K+xuXh/ep1mFtINo6/Qks9+dsCUrbXumZX8AeeBiM3i8gVvNhvbQELNfAi3sicgorfazkn/UtEZEVqsOyFerWR9PVI4b5dFvzNycBV8/e9B2dTcH9Yxg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(82310400026)(376014)(1800799024)(56012099006)(11063799006)(22082099003)(18002099003)(6133799003)(261021121427099003)(261009223027099003)(10067099003)(261026140227099003)(261028144727099003)(261022113327099003)(261022105027099003)(261026121527099003)(261021123027099003)(3023799007)(261102123227099003)(261022075727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	34TnfID4O7jQN8fVk2jLuUbL0TMW4v9nEMudCvlvGtfO2qxloBZ3o03ANeKhIvSi/hpPLXrO+Kg7oUvWqPjNCfJUw2BId8FZJqghxINnekAM0G2fgNaEPll4mjsUGXTYhbMY4o7WnuP5DGdIsm2TE3gxli3HqRiv0ydJQgXIgdL9fEmpdc0OkW0JL3Nn686ARFk5xP6YzmEJTgrB9eIuF85U/RVFSlZv0HUidAtFmp7ZnxL4eusxwxnp6xb176GvJ2zRMsnOZEpke/o60b8NwqxAOWbFHPv+lpwpFOmVfKLPubBYo6LTHIYdJoqFS+kIfRIW4Esgh2AdJlugg+wCFywJ07Tw0iCxBdJ3Ki/7MLwcbM1BwfvDqt9dlksKZ/X1dlmHFua4ha7TlQoh0YG/fVseZuguFzM4bdwaxki2KhewfLSvsgf6s88oZnk5kHf1
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 14:19:21.9691
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bcc0ad4-3399-41de-e5ed-08df40c7f280
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6734.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6032

Enable recovery for generic vfio-pci endpoints on the subordinate bus of
a PCIe Root Port or Downstream Port.

The recovery power helpers require pci_bus_sem held for reading. Native
PCI recovery provides this through its bus walk. Check the endpoint's
bus as well as its upstream port, since synthetic VF buses are outside
that walk. Exclude direct RCiEP and root-bus endpoints.

Exclude EEH-enabled builds and Xen PV because their callbacks do not
provide the required locking. Exclude s390 and CXL memory devices
because their recovery paths can omit completion callbacks. Variant
drivers remain unsupported until their hardware accesses are protected.

Exclude functions with VPD redirected to function zero. The lookup takes
pci_bus_sem inside SRCU and can deadlock with recovery when a bus writer
is queued.

Also exclude Intel Ethernet function zero devices with VPD. Redirected
accesses from sibling functions bypass the target's access checks.
Exclude potential targets even before siblings are probed so support
does not depend on probe order.

These restrictions affect only the new recovery feature. Ordinary
assignment and existing error notifications remain available.

Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 include/uapi/linux/vfio.h   |  6 +++-
 drivers/vfio/pci/vfio_pci.c | 61 +++++++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index 86a3952ee302..f855d064c4b0 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -1558,7 +1558,11 @@ struct vfio_device_feature_zpci_err {
 /*
  * Report host PCI error recovery state for this device.
  *
- * Userspace must probe the feature on each device before enabling it.
+ * Support is limited to PCIe endpoints on a Root Port or Downstream Port
+ * subordinate bus, using native PCI error recovery. Direct RCiEP, EEH, Xen
+ * PV, s390 and CXL memory recovery are not supported. Functions with
+ * VPD redirected to function zero, and Intel Ethernet function zero
+ * devices with VPD are excluded. Userspace must probe each device.
  *
  * VFIO_DEVICE_FEATURE_SET with a valid eventfd enables recovery for this
  * open and requests notifications when each event starts and ends. SET
diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index a5ba4bb11638..fe9b8b8decca 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -126,10 +126,70 @@ static int vfio_pci_open_device(struct vfio_device *core_vdev)
 	return 0;
 }
 
+static bool vfio_pci_supports_recovery(struct pci_dev *pdev)
+{
+	struct pci_dev *bridge = pci_upstream_bridge(pdev);
+
+	/*
+	 * Looking up function zero for VPD takes pci_bus_sem inside access_srcu.
+	 * Recovery holds the bus read lock while waiting for these SRCU readers.
+	 * A queued bus writer can leave both paths waiting for each other.
+	 */
+	if (pdev->dev_flags & PCI_DEV_FLAGS_VPD_REF_F0)
+		return false;
+
+	/*
+	 * quirk_f0_vpd_link() can redirect sibling VPD accesses to these devices
+	 * without checking whether recovery has blocked function zero. Exclude
+	 * them even if no redirecting sibling is present at probe.
+	 */
+	if (!PCI_FUNC(pdev->devfn) && pdev->vpd.cap &&
+	    pdev->vendor == PCI_VENDOR_ID_INTEL &&
+	    (pdev->class >> 8) == PCI_CLASS_NETWORK_ETHERNET)
+		return false;
+
+	/*
+	 * EEH and Xen PV can call recovery without the required bus locking.
+	 * s390 recovery can omit completion callbacks.
+	 */
+	if (IS_ENABLED(CONFIG_S390) || IS_ENABLED(CONFIG_EEH) ||
+	    xen_pv_domain())
+		return false;
+
+	/*
+	 * Recovery power helpers require pci_bus_sem held for reading.
+	 * The native recovery walk holds it on a port's subordinate bus.
+	 * Direct RCiEP recovery does not use that walk.
+	 */
+	if (!pci_is_pcie(pdev))
+		return false;
+
+	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_ENDPOINT &&
+	    pci_pcie_type(pdev) != PCI_EXP_TYPE_LEG_END)
+		return false;
+
+	if (!bridge || !pci_is_pcie(bridge))
+		return false;
+
+	if (pci_pcie_type(bridge) != PCI_EXP_TYPE_ROOT_PORT &&
+	    pci_pcie_type(bridge) != PCI_EXP_TYPE_DOWNSTREAM)
+		return false;
+
+	if (pdev->bus != bridge->subordinate)
+		return false;
+
+	/* CXL RCH recovery can omit completion callbacks. */
+	if ((pdev->class >> 8) == PCI_CLASS_MEMORY_CXL)
+		return false;
+
+	return true;
+}
+
 static int vfio_pci_init_dev(struct vfio_device *core_vdev)
 {
 	struct vfio_pci_core_device *vdev =
 		container_of(core_vdev, struct vfio_pci_core_device, vdev);
+	struct pci_dev *pdev = to_pci_dev(core_vdev->dev);
 
 	/*
 	 * These behaviors originated in vfio-pci and moved into
@@ -140,6 +200,7 @@ static int vfio_pci_init_dev(struct vfio_device *core_vdev)
 	 */
 	vdev->nointxmask = nointxmask;
 	vdev->disable_idle_d3 = disable_idle_d3;
+	vdev->pci_recovery_supported = vfio_pci_supports_recovery(pdev);
 #ifdef CONFIG_VFIO_PCI_VGA
 	vdev->disable_vga = disable_vga;
 #endif
-- 
2.43.0


Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010030.outbound.protection.outlook.com [52.101.61.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388A139E6F1;
	Fri, 16 Oct 2026 16:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792167691; cv=fail; b=Eo6QymAbiy77idwFH6kuHqoCqIQJI/vhgmi+HrRM6qWH9VGLul0yYW5JsD78okgBYP0ryICQDyg1mwbwtbNSez6Gqxc+uuQIdnFIpOTxDmk1VUn+4anI3C2Xz8WBPIYgV/FBtIHZUmbMxpHm0W9TNy2VjNhr5hcrAfkKKxrx59U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792167691; c=relaxed/simple;
	bh=DIzkkkYRx/tWrdyE+TgY8xestSQHusEgNZZQVm97yRQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q4iheqzTQ7SykiP9cmDEpALpeWC9bIy2ND1VG1FoCk8/+/3ii/3ufCfhN8sm+H3rE2JW9w1wIBfa/pG290ZESvJ5J8gfj+JqV5onfkUdnJ2Hr6JiJ3zHla91oFeq8P1gqzaq/iqN8fYRmtTZV9O6I9gD4Fx9GsqgvLwtwLe5huI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IVxhHYST; arc=fail smtp.client-ip=52.101.61.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IVxhHYST"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YG7E3WrY0VHkpKgg67WA+1+HKKj8MvBElvUWPEg52aRioIYEnEfX3263ktp6KuBeB1t91so0ykP1d7HLckBn/E3qPxIoX5qAHtP4fqDMvVECO4/ediOqyrvgTeLijpM3QILOPi7qCZkYrptYzhdLKCbNiGOm++yMiV54X1V90aDZLE5n8Les53Q7QsGEmRix2fE5WjJkwaYfRrGsfvvQGkNgqXE34+iY8z3v2J8B/EyiZfoEd4ZUkvvExoK6TLcNR1XzuN9OgEkpa3XBx2uyI8XmVyh1Aho3IXfQzpbr92VDWb969qijuBAxMkhlFtsZRvzGD+N+mmsfAb6Nma5zpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7D9AwU5rqJRescNHKFvU9xQlfSZ2Gc7oPCBC/6nJi/w=;
 b=HVqIZ7ueDc57j17PQ/ivl8+qD6+075sjLy1X27jEDPF6ZZe6j73iIv0rURRVVrySogF7F2jBRoYhF12GNJfbBSSSFZ+5OI8G3TyvmesHC/QO2GUw3FY42NE2hu8KrLpCNVns1nl0z+pmx6q1qKurl0QYMzcbnJGuaiuoZNRHHdzfRVqTFLVv4AC1+syVHCKlljy/yoUbqBJq00L8ZCrauOHKYrX0CKvWDdQybvgeznYIBEAVWmuzQriRZevzseqAyFFbaDXr8f9MclMs1Qo7WAAaOUjXfVCdS7d15GsmuxvfFnFqAPdmCGv/6zELBcbRfR+adY2TdGMysXhNxtqTpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7D9AwU5rqJRescNHKFvU9xQlfSZ2Gc7oPCBC/6nJi/w=;
 b=IVxhHYSTKNWeg8QCPG7tXH6U8kdS6MRr+5XZudKEqaYGlE9RfssFOh7A/U8d/cuWLO+gcM/mf+MnkYDQwSzEGSAsL3DntIqp2q9JJ8st7f4+cVp3JDub+HVG1d8rp5C4mdUfLmjlhk5q6K723yBOzbD7EzE7SYUEXzlLBF3iXQKts3fiD4G1dvCs4FDadlVzWxM8L0ho/TVSqFaI4FA8ZcL4PNGC6pS+tRNsv07yMO66onyddc4I07284oSW/uni0aN6q5KRS6AWC5Wtrh0rTZGlRU0XBnVyl+fYBMOaPKzzTVfItnYRu9R6uDglv/8o5sMPHsfHyM6QFO8OBrwwlQ==
Received: from MN2PR03CA0019.namprd03.prod.outlook.com (2603:10b6:208:23a::24)
 by CH3PR12MB7690.namprd12.prod.outlook.com (2603:10b6:610:14e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.28; Fri, 16 Oct
 2026 16:21:09 +0000
Received: from BN7PEPF000000A4.namprd05.prod.outlook.com
 (2603:10b6:208:23a:cafe::16) by MN2PR03CA0019.outlook.office365.com
 (2603:10b6:208:23a::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Fri, 16
 Oct 2026 16:21:08 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN7PEPF000000A4.mail.protection.outlook.com (10.167.245.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 16 Oct 2026 16:21:08 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 16 Oct
 2026 09:20:42 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 16 Oct 2026 09:20:33 -0700
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
Subject: [PATCH v6 11/31] vfio/pci: Virtualize the CXL DVSEC in vfio_pci_config.c
Date: Fri, 16 Oct 2026 21:48:18 +0530
Message-ID: <20261016161839.2765592-12-mhonap@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN7PEPF000000A4:EE_|CH3PR12MB7690:EE_
X-MS-Office365-Filtering-Correlation-Id: 51aa26cd-8afc-4f3b-4e7f-08df2ba17c73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|7416014|36860700016|23010399003|10067099003|18002099003|22082099003|5023799004|11063799006|261009223027099003|921020|56012099006;
X-Microsoft-Antispam-Message-Info:
	gWDCV58FIHG7Uqu30AiMeKdc44TJ2haCy4qv5t+PizZuO35TDpn3TgH5qYu6UYZx6m/IsF3QTIRbmMuucxYwUQqB/qyJVoGj6uiaDVp9SN3Adn/TwvWkturYVA2VhU0Wgev60vQnFYuyMNmmdnF8E2XCX7I7+TotG99DBedcHDgoUvf3PAlB1TPvB5jwMSlpUP3FlXunvbAoIhXHOGR0fL/4fYKyNmfepE72FkrWInl975Vw+bTGTYtxV9F6Kwodpn2HzihQ8AObj4gh5psw3aQquYdqH77CALRkfs9drDuEPkfSTi20He8lQVuesCu0d4jjMUmfIRQ+Bt4Rlc0EKoEmDUi1zGY8xoyiudWqWWG1gRHPRwqNT1gdon1VICmJUt2rnyQXzVTJALbYk4fTHNaRfzuoDOy6U03nf+iwySxIljwera3CWWllgznL3LKw8j5TMAVu9tCNcZqutzOGpe3c4upj7dos2MUlLHvbp+Lbq41dE9UPH997gadOLMKBJ8nk6/a+3YzGNf6Jn+XCjvzj3A7xxPZTqjkM/NqubvigJ0Fgue897/93G47CVCZgyHQ/cklUEPBB3vX3eVlQbEpIA9o1YaMvTnv7T+EwV9/QCLuilAbw04Of3vc0WXMf5yUZF7HrXgbA1GzsQBfG7uomst40FjR1YkYCwrltbWKnfmrOEhN+fnewsYCVET8pBfFi2T8u6z7fCU+xE7AtW4XpBCEOc0K3SYXvFczcuZW9OC8uK6+f+gvGaMcy122e
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(7416014)(36860700016)(23010399003)(10067099003)(18002099003)(22082099003)(5023799004)(11063799006)(261009223027099003)(921020)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	R5evRP/CI+zlGPoNzx5lVCS/3+KSq3iHJHJD7qWRYaTA3T5qrublZcnX60QR8VERprivjBgXV2smrBrM1Ra/vK2lRSOn9M/ey67qWeXOFUid69XyYAu3YVXi7Ux4wnDMmBGnv0P8QymD32XQNIkFYh4kqSI5WLo5yozDEbSkxlx+nWtf+gUIKM05P/W4CDTE9RkSVWJq8ZtmSAvNFcZm0QthXY3gEGXxuto8mHJYMn6KiwJ7DUQXlY4c2+E9wlSl6VMafrF2Capp1yMfKDgqxc3g+jAnMbO8TeFyFI/jos/EiRmx54WGPLWyS3i6MRygqG0DmcVb3QIyzsS9G0+dhP6WZxSo7fGC9l8anmyhFU0t2uYnhtVaIgIIj7WiGuRkUTDi29A8XHH/KgjR2b/NsZpRNygfD3V066ZaAQhaT9PpR97Eoaq9m8wiTtVuSFc3
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 16:21:08.5672
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51aa26cd-8afc-4f3b-4e7f-08df2ba17c73
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN7PEPF000000A4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7690

From: Manish Honap <mhonap@nvidia.com>

A CXL Type-2 device is reprogrammable through its CXL DVSEC: a guest could
set Config Lock, toggle CXL.cache and CXL.mem enable, or rewrite the HDM
range registers that govern host memory decode. Virtualize the DVSEC so
the guest sees a shadow it cannot use to reprogram the hardware.

Build a per-device cxl_perm permission map, modeled on msi_perm. When
the device is bound through the CXL provider (e.g. vfio-cxl), the whole
CXL DVSEC is served from the vconfig shadow; only Control and Control2
are guest programmable, while Capability, Status, Lock and the Range
registers keep their firmware snapshot. A vendor DVSEC on the same
device is unaffected: the map is selected by the CXL DVSEC's range,
since every DVSEC has the same ID in the config map and two DVSECs can
be adjacent.

A Type-2 function bound without the provider (the provider is absent,
its init failed, or the extensions are disabled) gets a guard map
instead. The DVSEC reads from hardware, Control and Control2 stay
writable and the RW1C status bits stay clearable, but writes to Lock and
the Range registers are dropped, since they outlive the user. Initiate
CXL Reset uses the same doorbell; a cache write-back goes to the device.

Control2 carries the CXL reset and cache write-back-invalidate initiate
bits as self-clearing doorbells. With the provider, vfio never forwards
them to hardware, so a custom writefn synthesizes their completion in
the shadow: the initiate bit self-clears and the matching Status2 bit
(Cache Invalid or Reset Done) is set, so a guest that writes back its
cache (CXL r4.0 sec 9.6) and then runs CXL Reset (sec 9.7.2) progresses
instead of timing out. Cache Invalid is reported only while Disable
Caching is set, as the spec requires. The host performs the real cache
write-back and reset at the vfio reset points. Until a later patch in
this series runs the real reset from the doorbell, Initiate CXL Reset
completes in the shadow only.

Assisted-by: LLM
Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 drivers/vfio/pci/vfio_pci_config.c | 206 ++++++++++++++++++++++++++++-
 include/linux/vfio_pci_core.h      |   3 +
 2 files changed, 205 insertions(+), 4 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
index 9914f3ac69ae..1fc463540211 100644
--- a/drivers/vfio/pci/vfio_pci_config.c
+++ b/drivers/vfio/pci/vfio_pci_config.c
@@ -1747,6 +1747,194 @@ static const struct pci_device_id known_bogus_vf_intx_pin[] = {
  * for each area requiring emulated bits, but the array of pointers
  * would be comparable in size (at least for standard config space).
  */
+static int vfio_cxl_dvsec_write(struct vfio_pci_core_device *vdev, int pos,
+				int count, struct perm_bits *perm,
+				int offset, __le32 val)
+{
+	u16 start = vdev->cxl_dvsec;
+	__le16 *pctrl2, *pstatus2;
+	u16 ctrl2, status2;
+
+	count = vfio_default_config_write(vdev, pos, count, perm, offset, val);
+	if (count < 0)
+		return count;
+
+	/* Only Control2 carries the self-clearing doorbells. */
+	if (offset > PCI_DVSEC_CXL_CTRL2 ||
+	    offset + count <= PCI_DVSEC_CXL_CTRL2)
+		return count;
+
+	pctrl2 = (__le16 *)&vdev->vconfig[start + PCI_DVSEC_CXL_CTRL2];
+	pstatus2 = (__le16 *)&vdev->vconfig[start + PCI_DVSEC_CXL_STATUS2];
+	ctrl2 = le16_to_cpu(*pctrl2);
+	status2 = le16_to_cpu(*pstatus2);
+
+	/*
+	 * INIT_CACHE_WBI and INIT_CXL_RST are self-clearing doorbells. With a
+	 * provider neither reaches hardware: synthesize their completion in the
+	 * shadow so the guest poll finishes, clearing the initiate bit and
+	 * setting the matching Status2 completion. Cache Invalid is set only
+	 * while caching is disabled and reads 0 otherwise (CXL r4.0 sec 8.1.3.5,
+	 * Table 8-9). Under the guard map INIT_CACHE_WBI and Cache Invalid go to
+	 * the device; only INIT_CXL_RST and its completion are virtualized.
+	 */
+	if (ctrl2 & PCI_DVSEC_CXL_INIT_CACHE_WBI) {
+		ctrl2 &= ~PCI_DVSEC_CXL_INIT_CACHE_WBI;
+		if (ctrl2 & PCI_DVSEC_CXL_DISABLE_CACHING)
+			status2 |= PCI_DVSEC_CXL_CACHE_INV;
+	}
+	if (!(ctrl2 & PCI_DVSEC_CXL_DISABLE_CACHING))
+		status2 &= ~PCI_DVSEC_CXL_CACHE_INV;
+	if (ctrl2 & PCI_DVSEC_CXL_INIT_CXL_RST) {
+		ctrl2 &= ~PCI_DVSEC_CXL_INIT_CXL_RST;
+		status2 &= ~PCI_DVSEC_CXL_RST_ERR;
+		status2 |= PCI_DVSEC_CXL_RST_DONE;
+	}
+
+	*pctrl2 = cpu_to_le16(ctrl2);
+	*pstatus2 = cpu_to_le16(status2);
+
+	return count;
+}
+
+static int init_cxl_dvsec_perm(struct perm_bits *perm, int len)
+{
+	if (alloc_perm_bits(perm, len))
+		return -ENOMEM;
+
+	perm->writefn = vfio_cxl_dvsec_write;
+
+	/* Serve the whole CXL DVSEC from the shadow. */
+	for (int i = 0; i < len; i++)
+		p_setb(perm, i, (u8)ALL_VIRT, NO_WRITE);
+
+	/*
+	 * Control and Control2 are guest programmable; Capability, Status,
+	 * Lock and the Range registers keep their firmware snapshot, so the
+	 * guest cannot set Config Lock or rewrite the capability and ranges.
+	 */
+	p_setw(perm, PCI_DVSEC_CXL_CTRL, (u16)ALL_VIRT, (u16)ALL_WRITE);
+	p_setw(perm, PCI_DVSEC_CXL_CTRL2, (u16)ALL_VIRT, (u16)ALL_WRITE);
+
+	return 0;
+}
+
+/*
+ * Without a CXL provider the device is bound without the CXL extensions, so
+ * the DVSEC is read from hardware, Control and Control2 stay writable, and
+ * the RW1C status bits in Status and Status2 (for example Viral_Status) can
+ * still be cleared. Drop the writes whose effect outlives the user: Config
+ * Lock and the Range registers. Initiate CXL Reset goes through the same
+ * doorbell as with a provider, so the reset runs at a vfio reset point under
+ * memory_lock.
+ */
+static int init_cxl_dvsec_guard_perm(struct perm_bits *perm, int len)
+{
+	if (alloc_perm_bits(perm, len))
+		return -ENOMEM;
+
+	perm->writefn = vfio_cxl_dvsec_write;
+
+	/* Extended capability header: ID and next pointer from vconfig. */
+	p_setd(perm, 0, ALL_VIRT, NO_WRITE);
+
+	p_setw(perm, PCI_DVSEC_CXL_CTRL, NO_VIRT, (u16)ALL_WRITE);
+	p_setw(perm, PCI_DVSEC_CXL_CTRL2, PCI_DVSEC_CXL_INIT_CXL_RST,
+	       (u16)ALL_WRITE);
+	/* Status (offset 0Eh, between Control and Control2): RW1C to the device. */
+	p_setw(perm, PCI_DVSEC_CXL_CTRL + 2, NO_VIRT, (u16)ALL_WRITE);
+	p_setw(perm, PCI_DVSEC_CXL_STATUS2,
+	       PCI_DVSEC_CXL_RST_DONE | PCI_DVSEC_CXL_RST_ERR,
+	       (u16)~(PCI_DVSEC_CXL_RST_DONE | PCI_DVSEC_CXL_RST_ERR));
+
+	return 0;
+}
+
+/* Virtualize the CXL DVSEC so a guest cannot reprogram the device through it. */
+static int vfio_cxl_dvsec_init(struct vfio_pci_core_device *vdev)
+{
+	struct pci_dev *pdev = vdev->pdev;
+	u32 dword;
+	u16 dvsec, cap;
+	int len, ret;
+
+	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
+					  PCI_DVSEC_CXL_DEVICE);
+	if (!dvsec)
+		return 0;
+
+	ret = pci_read_config_dword(pdev, dvsec + PCI_DVSEC_HEADER1, &dword);
+	if (ret)
+		return pcibios_err_to_errno(ret);
+	len = PCI_DVSEC_HEADER1_LEN(dword);
+
+	/*
+	 * The virtualization writes fixed DVSEC offsets up to Status2 (the reset
+	 * doorbell stamps it). A device that reports a shorter DVSEC is not a
+	 * usable Type-2 function; leave its DVSEC unvirtualized rather than
+	 * index the device-length-sized perm allocation past its end.
+	 */
+	if (len < PCI_DVSEC_CXL_STATUS2 + 2)
+		return 0;
+
+	/*
+	 * Without a provider, guard only a CXL Type-2 function, with the same
+	 * test vfio-pci-core uses to load the provider.
+	 */
+	if (!vdev->cxl_ops) {
+		if (!pcie_is_cxl(pdev))
+			return 0;
+		ret = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CAP, &cap);
+		if (ret)
+			return pcibios_err_to_errno(ret);
+		if (!(cap & PCI_DVSEC_CXL_CACHE_CAPABLE) ||
+		    !(cap & PCI_DVSEC_CXL_MEM_CAPABLE))
+			return 0;
+	}
+
+	vdev->cxl_perm = kmalloc_obj(*vdev->cxl_perm, GFP_KERNEL_ACCOUNT);
+	if (!vdev->cxl_perm)
+		return -ENOMEM;
+
+	if (vdev->cxl_ops)
+		ret = init_cxl_dvsec_perm(vdev->cxl_perm, len);
+	else
+		ret = init_cxl_dvsec_guard_perm(vdev->cxl_perm, len);
+	if (ret) {
+		kfree(vdev->cxl_perm);
+		vdev->cxl_perm = NULL;
+		return ret;
+	}
+
+	vdev->cxl_dvsec = dvsec;
+	vdev->cxl_dvsec_len = len;
+
+	return 0;
+}
+
+static void vfio_cxl_dvsec_exit(struct vfio_pci_core_device *vdev)
+{
+	if (!vdev->cxl_perm)
+		return;
+
+	free_perm_bits(vdev->cxl_perm);
+	kfree(vdev->cxl_perm);
+	vdev->cxl_perm = NULL;
+	vdev->cxl_dvsec = 0;
+	vdev->cxl_dvsec_len = 0;
+}
+
+/*
+ * Every DVSEC carries the same ID in pci_config_map, so vfio_find_cap_start()
+ * can walk from one DVSEC into an adjacent one. Match the CXL DVSEC by range.
+ */
+static bool vfio_cxl_dvsec_contains(struct vfio_pci_core_device *vdev,
+				    loff_t pos)
+{
+	return vdev->cxl_perm && pos >= vdev->cxl_dvsec &&
+	       pos < vdev->cxl_dvsec + vdev->cxl_dvsec_len;
+}
+
 int vfio_config_init(struct vfio_pci_core_device *vdev)
 {
 	struct pci_dev *pdev = vdev->pdev;
@@ -1842,6 +2030,10 @@ int vfio_config_init(struct vfio_pci_core_device *vdev)
 	if (ret)
 		goto out;
 
+	ret = vfio_cxl_dvsec_init(vdev);
+	if (ret)
+		goto out;
+
 	return 0;
 
 out:
@@ -1863,6 +2055,7 @@ void vfio_config_free(struct vfio_pci_core_device *vdev)
 		kfree(vdev->msi_perm);
 		vdev->msi_perm = NULL;
 	}
+	vfio_cxl_dvsec_exit(vdev);
 }
 
 /*
@@ -1926,12 +2119,17 @@ ssize_t vfio_pci_config_rw_single(struct vfio_pci_core_device *vdev,
 			 * of the extended capability list.  Use default, ro
 			 * access, which will virtualize the id and next values.
 			 */
-			if (cap_id > PCI_EXT_CAP_ID_MAX)
+			cap_start = vfio_find_cap_start(vdev, *ppos);
+
+			if (cap_id > PCI_EXT_CAP_ID_MAX) {
 				perm = &direct_ro_perms;
-			else
+			} else if (cap_id == PCI_EXT_CAP_ID_DVSEC &&
+				   vfio_cxl_dvsec_contains(vdev, *ppos)) {
+				perm = vdev->cxl_perm;
+				cap_start = vdev->cxl_dvsec;
+			} else {
 				perm = &ecap_perms[cap_id];
-
-			cap_start = vfio_find_cap_start(vdev, *ppos);
+			}
 		} else {
 			WARN_ON(cap_id > PCI_CAP_ID_MAX);
 
diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index 70acb03d466e..fd1ad0baf470 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -120,6 +120,9 @@ struct vfio_pci_core_device {
 	u8			*pci_config_map;
 	u8			*vconfig;
 	struct perm_bits	*msi_perm;
+	struct perm_bits	*cxl_perm;
+	u16			cxl_dvsec;
+	u16			cxl_dvsec_len;
 	spinlock_t		irqlock;
 	struct mutex		igate;
 	struct xarray		ctx;
-- 
2.53.0


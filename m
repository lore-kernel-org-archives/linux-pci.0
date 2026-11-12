Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.6
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794493101;
	b=My/lxapQMFvKOUy1w4q74TXBX/0N1CblvmfgoFWxQ2mokplDs1UWci1ZuvtikWl0CKqW
	 mWHCzQSmkwyXlKkdROKuDCGim0glS+3dGca9uyeiHDteeH9OteItMU75OPehEgAGV3n75
	 NXnw4YeFKex5x71L6Ns6m70V3/CgQsO4GUKZIGoMZhm/y3qCWUu5/+Kbp1n3k4Cb7B/nJ
	 zfcOS6dWaMnzW2SIqXT6QvM2pAigk4bcgFfjbBzl3k9KYXVmjSgeGnjC5ZwUDen/UKi5n
	 0AQZ4R9OpAPmZgZzxlQlKS9jJTs/Jes31cfu9b0bXY9OOiq0XN/KuoR86E8thyjkLrA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794493101;
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
	bh=Fif6b6k+pO1ib8P0v6h0tkDJkhqN4MxhiGIWFHB6Xv8=;
	b=Y/jA5zM5N34zzOGl/Iwu5BbmqkBsVA6Zz9bkYcM70z4l2meFjaO4glXhT1KB4c8Xe4Lj
	 2MDk3QmISM916O2c52YN+G/x/t91ZCCh42KBzE9XAlA43KTyt5QnMxaAObi3oz/HWTVJz
	 HzilnJ/y3GDigZlmrz+w1ogGqItYM2YIyUmltl5Mp42Hu0CrMR1yTarK4OxggxXhUVYW5
	 2zlFcsKJ2eMXspmxawJnGOsi41daLdmcDKvgNmGwF99PWUEKO5o+4QcxAh5A0erPp6avy
	 27Q6P4MO426edHSp5KjC2QGkC/JziNTbHJnxs4RPRLcfg1b2eUTC/vCD2Uy0+/NOIpQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=JUWNaGQp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.6
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010006.outbound.protection.outlook.com [52.101.201.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3B8606A8B5;
	Thu, 12 Nov 2026 14:18:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE3B8606A8B5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=JUWNaGQp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XfoFANahge7w+UDPGxA1OOBDX6eqDxRPmhzNlJ73xR47mOCPNaWDE7eZfhpZ3HnPcYpt2pCPGMsV8Bey3hXEjXV5eaQb1KRpkNWTzYxvhJ4zZpNBDL4aENFOvTe//MS4kCY0of2nrgs46gh7SJv+X2KL5Srv3KHV1HkjSsg+KDzdWZqN3dUbEY8b33+rHr9VPi3eEEbeKCwWnPflCIk8ykIajWkQ2wonSJWZ8i8B9xO1Jfmof1hvFd2YPk3FpIiJz6h8OIALD0YG+j9rCeVRfqf+HMJ3dmaVCcvoUNmE4VCvrx9ZYi9/SRMI1U4EB3a4uPooDlk3aoxyLKahqCPtSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fif6b6k+pO1ib8P0v6h0tkDJkhqN4MxhiGIWFHB6Xv8=;
 b=SB0r7kfb7pC3yx64N7gL74Btmjxp2FyXoWceOWxQRBXICdAGoEHSw356cOpmL9apHFHqH5L3+DQQi4PCMcL22f/sI792Snzvy3GCRv6fyMEk+7hh6mG8bCtaL1UW/ZcRHK4uaK4fOeuQh3ontL7DbPMR3MoTG4c7YiYZjXNIxBlySluWOjlc2f1Q2AjLGnqMFT+3NRcrVyOJcFCOLcdYYkAyFMOAeMwsXnQ3SBiOi/iE2xLTzz63ix7KrJyEdlXDh7ePJ9YgknrUScdDyZ5jFqaQlv+KMn9TG5a3SnxRXrbvtJAHy0abGdTbtJhqa0HoTxf/Q3Sh+cLAoDWqXmL6CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fif6b6k+pO1ib8P0v6h0tkDJkhqN4MxhiGIWFHB6Xv8=;
 b=JUWNaGQpoCeppdVK0Qjxx5FoV9jkzIXWXbG4+BzFqxpqJvG9cfTEO8bw9YT5e+lmBfl6UTFfe7P9+nxKXIu55yKF3mm9FypaptLg/nnhCkkv7iq15B4Gai8nYT2i8DVIUoCGHJhO6WVHtFX0v03Iz3TmvursYLMcQXV1VwCZ9dab2tfXfPKQccXg0ty6LmM0Yoa8HjWCZGCTcWWYA+2xxfKqkCJYmSxcerdvKRoG+iYIscUvW9DLTm1quJw8nIf1QU+2VXHpaJOr2c6BG6CVWgWNhea/mO5x2AmCNnaU8936LNOJ7Zsb8BNzszq2rjyU/fxysCgRwtkJ1LZ5E/PPDQ==
Received: from DS7PR03CA0330.namprd03.prod.outlook.com (2603:10b6:8:2b::22) by
 SN7PR12MB7856.namprd12.prod.outlook.com (2603:10b6:806:340::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 12 Nov
 2026 14:18:16 +0000
Received: from MN1PEPF000793FC.namprd05.prod.outlook.com
 (2603:10b6:8:2b:cafe::64) by DS7PR03CA0330.outlook.office365.com
 (2603:10b6:8:2b::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Thu, 12
 Nov 2026 14:18:15 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MN1PEPF000793FC.mail.protection.outlook.com (10.167.249.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 12 Nov 2026 14:18:15 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 12 Nov
 2026 06:17:53 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 12 Nov
 2026 06:17:50 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <alex@shazbot.org>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kbusch@meta.com>, <michal.winiarski@intel.com>,
	<satyanarayana.k.v.p@intel.com>, <sonangp@nvidia.com>, <ankita@nvidia.com>,
	<nathanc@nvidia.com>, <mochs@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [RFC PATCH v3 03/20] vfio/pci: Avoid waiting for the bus lock when preparing D0
Date: Thu, 12 Nov 2026 14:16:15 +0000
Message-ID: <20261112141632.918954-4-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF000793FC:EE_|SN7PR12MB7856:EE_
X-MS-Office365-Filtering-Correlation-Id: b85814d6-3574-4ea0-beb3-08df40c7cafb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700016|1800799024|23010399003|22082099003|18002099003|10067099003|261021121427099003|261102123227099003|11063799006|261021123027099003|261026121527099003|261022105027099003|261028144727099003|261009223027099003|261026140227099003|56012099006|261022075727099003;
X-Microsoft-Antispam-Message-Info:
	cV5XSMtTT50jm3U34Q2M7gENNGoggXcQxsCyzlWt0FjwntF7fNbBzOQZ+qVtxdoS0j/uLAKqegsQOXXdItS7MQvuSq8zeAEKhllDsfMmdgzi3+qRA+I83al42Q34Q04NfLom1u8UtAjf96HtrbSDsNbDtXj730+TFlCdB72522Ije8fDiQYDnbezkqnLogv+XP/2yDz/qhtp6/shD9t+LbCINkPGwZfpKBTTwqVWZ8nyaIi+ozFhbZbf9oJaZ+84fVj5zAc890t3EN280FiGZYXvuc435wDYIH6BBAAjnr/zCZaVpXr9OlCoUnpxo0eaI7cp8JKp2wTdRbmOtGVu0H83Dn9L4IetarhAq7L6qS+EqPy6EGeK25qa4Nu9Ck5cDzmb4Ff7jz1to499GDMaEfRvAleyMCkq8L6S4sv1R65o5I+CmF08Y3xP1zYHaVgG+VoE34S9MSjiBWKftxU8y69NGvpfKRItXZeczjDp7drj3LiR9MrSNxJO2PHETPddqZqpeeGXqR6rfoJWXwyo3Bz45OMMQKwZGhPr7Txt8o+bo7uxL37yBLlrD8YeBtMhDWUQhYLhS/Ewkt79Wte3LyvouBZfgXF6XHK9kUmaZJlxDXXk3Tr/xl26roT1sG9gufpUcC5pFdPYoeeeo0Wdz364EyJTGpAYY8bWn+y9ePZTzYxiTOZ/ZPFk2ONE20WZTIYJ8/lZrWzAFBkXiSmlew==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(23010399003)(22082099003)(18002099003)(10067099003)(261021121427099003)(261102123227099003)(11063799006)(261021123027099003)(261026121527099003)(261022105027099003)(261028144727099003)(261009223027099003)(261026140227099003)(56012099006)(261022075727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	v2AwmiZreU5J7xD+lahUOyTYBpYJy0iDRZ5lu4sFQNMlZ217u+Pn4sR3Ak7/CzeEpFFr5CEqbJ0E1TTdROgbnTayUX6SxWcBUtf6nBizhOiz9mZ2qQlmxzsBhVHPzVOvwJpC8BK+rSv1inwJXJWB9aGwA2a0RxDgcjufDr82vAoiIcXtuZ+iBorCSN7FTnPcKEu97+MtrS0LO+/voUX57ivxPKa4kj0CmHu3R3ONIwVP/I1e+dscXYT6Lf05bdUhWd6XXvEpVBC+cwLgdvawu+1c2jlWZtQrAKYjUPV9icDJVY8E4KUxIVe3hMgCANvFYUN9zqdGs823DXU56fOEVJGObQfEPEm4yaJhrMw/jlDY82dFT0oiMV255QR1oB7erfOQVwhmMpzGmm/+aJxhkCag/TIpCUGWCDLGiDAu6kbrNpg+tFc4GcsZEKw8w2aF
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 14:18:15.6251
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b85814d6-3574-4ea0-beb3-08df40c7cafb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF000793FC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7856

A D0 transition can wait behind a pci_bus_sem writer while holding locks
needed by PCI error recovery. Recovery holds the bus read lock, leaving
all three tasks waiting for each other.

Use pci_try_set_power_state() for D0 preparation during function reset,
hot reset, runtime suspend and SR-IOV enable. Preserve VFIO's saved PM
state handling and unwind reset and SR-IOV requests if D0 preparation
fails.

Runtime suspend returns -EAGAIN on bus-lock contention. Keep its existing
handling of other D0 errors to avoid leaving runtime PM in an error state.

Apply this even when recovery is disabled, since global IRQ cleanup can
wait for another device's D0 transition. Low-power transitions keep the
existing helper. Subsequent patch handles config-space power requests.

Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 drivers/vfio/pci/vfio_pci_priv.h |  2 ++
 drivers/vfio/pci/vfio_pci_core.c | 49 +++++++++++++++++++++++++++-----
 2 files changed, 44 insertions(+), 7 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
index 97b69e4bc8be..2a15a8956205 100644
--- a/drivers/vfio/pci/vfio_pci_priv.h
+++ b/drivers/vfio/pci/vfio_pci_priv.h
@@ -67,6 +67,8 @@ void vfio_config_free(struct vfio_pci_core_device *vdev);
 
 int vfio_pci_set_power_state(struct vfio_pci_core_device *vdev,
 			     pci_power_t state);
+int vfio_pci_try_set_power_state(struct vfio_pci_core_device *vdev,
+				 pci_power_t state);
 
 void vfio_pci_zap_and_down_write_memory_lock(struct vfio_pci_core_device *vdev);
 u16 vfio_pci_memory_lock_and_enable(struct vfio_pci_core_device *vdev);
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index b7d81233b99b..6529eab7865b 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -378,7 +378,10 @@ long vfio_pci_core_access(struct vfio_pci_core_device *vdev,
  * by PM capability emulation and separately from pci_dev internal saved state
  * to avoid it being overwritten and consumed around other resets.
  */
-int vfio_pci_set_power_state(struct vfio_pci_core_device *vdev, pci_power_t state)
+static int __vfio_pci_set_power_state(struct vfio_pci_core_device *vdev,
+				      pci_power_t state,
+				      int (*set_power_state)(struct pci_dev *,
+							     pci_power_t))
 {
 	struct pci_dev *pdev = vdev->pdev;
 	bool needs_restore = false, needs_save = false;
@@ -401,7 +404,7 @@ int vfio_pci_set_power_state(struct vfio_pci_core_device *vdev, pci_power_t stat
 			needs_restore = true;
 	}
 
-	ret = pci_set_power_state(pdev, state);
+	ret = set_power_state(pdev, state);
 
 	if (!ret) {
 		/* D3 might be unsupported via quirk, skip unless in D3 */
@@ -429,6 +432,20 @@ int vfio_pci_set_power_state(struct vfio_pci_core_device *vdev, pci_power_t stat
 	return ret;
 }
 
+int vfio_pci_set_power_state(struct vfio_pci_core_device *vdev, pci_power_t state)
+{
+	return __vfio_pci_set_power_state(vdev, state, pci_set_power_state);
+}
+
+/* Avoid waiting for pci_bus_sem under locks needed by PCI recovery. */
+int vfio_pci_try_set_power_state(struct vfio_pci_core_device *vdev,
+				 pci_power_t state)
+{
+	return __vfio_pci_set_power_state(vdev, state,
+					state == PCI_D0 ? pci_try_set_power_state :
+					pci_set_power_state);
+}
+
 static int vfio_pci_runtime_pm_entry(struct vfio_pci_core_device *vdev,
 				     struct eventfd_ctx *efdctx)
 {
@@ -550,6 +567,8 @@ static int vfio_pci_core_pm_exit(struct vfio_pci_core_device *vdev, u32 flags,
 #ifdef CONFIG_PM
 int vfio_pci_core_runtime_suspend(struct vfio_pci_core_device *vdev)
 {
+	int ret;
+
 	down_write(&vdev->memory_lock);
 	/*
 	 * The user can move the device into D3hot state before invoking
@@ -559,8 +578,11 @@ int vfio_pci_core_runtime_suspend(struct vfio_pci_core_device *vdev)
 	 * NoSoftRst-, it will help in restoring the original state
 	 * (saved locally in 'vdev->pm_save').
 	 */
-	vfio_pci_set_power_state(vdev, PCI_D0);
+	ret = vfio_pci_try_set_power_state(vdev, PCI_D0);
 	up_write(&vdev->memory_lock);
+	/* Preserve the existing handling of other D0 transition errors. */
+	if (ret == -EAGAIN)
+		return ret;
 
 	/*
 	 * If INTx is enabled, then mask INTx before going into the runtime
@@ -1401,7 +1423,11 @@ static int vfio_pci_ioctl_reset(struct vfio_pci_core_device *vdev,
 	 * reset without restoring the original state (saved locally in
 	 * 'vdev->pm_save').
 	 */
-	vfio_pci_set_power_state(vdev, PCI_D0);
+	ret = vfio_pci_try_set_power_state(vdev, PCI_D0);
+	if (ret) {
+		up_write(&vdev->memory_lock);
+		return ret;
+	}
 
 	vfio_pci_dma_buf_move(vdev, true);
 	ret = pci_try_reset_function(vdev->pdev);
@@ -2453,7 +2479,12 @@ int vfio_pci_core_sriov_configure(struct vfio_pci_core_device *vdev,
 			goto out_del;
 
 		down_write(&vdev->memory_lock);
-		vfio_pci_set_power_state(vdev, PCI_D0);
+		ret = vfio_pci_try_set_power_state(vdev, PCI_D0);
+		if (ret) {
+			up_write(&vdev->memory_lock);
+			pm_runtime_put(&pdev->dev);
+			goto out_del;
+		}
 		vdev->sriov_active = true;
 		up_write(&vdev->memory_lock);
 		ret = pci_enable_sriov(pdev, nr_virtfn);
@@ -2656,11 +2687,15 @@ static int vfio_pci_dev_set_hot_reset(struct vfio_device_set *dev_set,
 	 * cause the PCI config space reset without restoring the original
 	 * state (saved locally in 'vdev->pm_save').
 	 */
-	list_for_each_entry(vdev, &dev_set->device_list, vdev.dev_set_list)
-		vfio_pci_set_power_state(vdev, PCI_D0);
+	list_for_each_entry(vdev, &dev_set->device_list, vdev.dev_set_list) {
+		ret = vfio_pci_try_set_power_state(vdev, PCI_D0);
+		if (ret)
+			goto out_unlock_memory;
+	}
 
 	ret = pci_reset_bus(pdev);
 
+out_unlock_memory:
 	vdev = list_last_entry(&dev_set->device_list,
 			       struct vfio_pci_core_device, vdev.dev_set_list);
 
-- 
2.43.0


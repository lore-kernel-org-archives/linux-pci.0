Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.16
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794493110;
	b=JehGW8YOUb9Gz8rwsL3CRaaFgvtw5g2Io+B1ZNMGYZK6DPuJN4S5zby1aN28RQuLEm0e
	 RnmtU2jeP2Rklv++ys/sYoqNpEuKJwoE7DWFesEcqWNLrB4h5RULz0yDTFcmrnr0bvl/5
	 gXnVgJinLOKtufXiQpTPkv1/q2dqmjllcsxhZIHDRZmZJJShyXUWQ8It93CfD++pXekVb
	 UP0ZR6JU1SJ9n+zrbtDRYONLAyQuJCQmj41Epwo/VaEt4rrSy7g7y4KNSDKg5NB/OYFxq
	 82FkaTHcU1gFiv90l5gXz88/mS2AWt/UO1kufRLuJVUknt4tN12pM1wVR+KD/p1kk8g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794493110;
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
	bh=yjyuWDNKax4eU+MqYb75M6jLf3w2MBF/1V7hFP2W8bI=;
	b=DmEUXTiMyVU4TpCugMOS4a7n4vgIrg83zOsYnWX0XbDhWUKx7Fmks0k2gXhPGVuNVxJT
	 J2N0ha3c06UMy4Kmy9x55fCxT7ztgNMBLVVUl0WxM5+nsmb16VlUgBttifd2jDD6q5ZQO
	 23tWbtxzL1BSWs/n7T+dS5zlnIhQjw2ZzKjuMxHKAAnodivU4F+Lsf0dJZ+m6si0zB1S7
	 8YdHAi04nrlcr9rRSuijdBeynTK/0dElKfxVgDgBfmGAVPJVD93cKveVtcMG/oFsqsHmM
	 GByoSiun+HP1VjeNe3pNhAwB8JCU8hpKgaVIN4BLZqLqMXRE6B7AWmC0CmDyWf+JHkw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=R1cgKCiD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.16
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011016.outbound.protection.outlook.com [52.101.52.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19DB606C4C7;
	Thu, 12 Nov 2026 14:18:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B19DB606C4C7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=R1cgKCiD
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DCiC9vFtvRyAZXzr+ICDkxNZgQG6RjQYnbH1eRgewkVARpdQDbaQPW775bmzsEXfgnhDso1XUY0N7OL6eCSRO3wUgaqGmI0WDJqBLx9V/yPhDBmTkxYn1VGoixFYNuwC8RiXGEUA8IqnLh/z+Aaa3Cqy14LhxJb9Dm2CAhKlH/jsc/lfCtPjEAphbx9dXW5NYAPyx1YjByy7cNyOL6pISFoZ4hakZrZc5brZ/hLKULyzAG11JPnp7KWMOLbhbSDXj7OznCmd97inSyXWqeeQlgHGxwyrTML9I6RmxnSI9BRr8flUxVILw1WSaJ+KzF52J1V23g9KkHlTFOW6KCrISw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yjyuWDNKax4eU+MqYb75M6jLf3w2MBF/1V7hFP2W8bI=;
 b=VlOMTQqBc7gXwqA9sh931Ux58PTvRfO4+7aIZSlBQeG1+/iDxlbyOgLSMH1V9MU0VSUvvpGY/MQwFtKOmgkAl5gcLQE6v356/7bGNUzDOYULrrIp1YbzDnaXJsNiU1oqMob/ZPb9+us3vMhsNSbnUkZCAl1QgrLvQ8vH+5ZetrsufXBIWStuQvM3tGiKESkptPZ1BhCadMpV8jf/X2tkUZMn0uioJO526SstCvOHDsErVJK+lcBFWMZymz+cdkROgHy8/RSAV7u3fwAC95KkDIhojN+43Aijs1WHXU/0WC+bJuz3dAo1Aj45uydiTrIl4Nl0Q/vknsXVUiApqz4EgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yjyuWDNKax4eU+MqYb75M6jLf3w2MBF/1V7hFP2W8bI=;
 b=R1cgKCiDlHRnayQNw//JOiLTKF2nY3TvxovNGbMsp03cUHSyKXJZNv91zaKWFIojnekmj/Eosf0fPUg1NJDHWVhkm2se/2UIeoEHtHciL4KFWOfg/sHau8vKMOtN98vl0duuQdW704eC81mAm/wqsP0sK7Z61OI+MDhvIMhj+GbR6QbjahgDQxdzrdMUm0IZRNvl4dy056qhWyBIsjvkyiYfVJyftC0UYjpaNDi0TZVKsk7WEaLDL+wow96P0OOCFHv80chIsqHSaZHvmmAKCv3MTmxR0U3U15X9ENRLVKLqxzyqcIDkBpXfpNcqJnb8cYh27+ITiP0mPWQgSldsqQ==
Received: from PH0PR07CA0004.namprd07.prod.outlook.com (2603:10b6:510:5::9) by
 MW4PR12MB7431.namprd12.prod.outlook.com (2603:10b6:303:225::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Thu, 12 Nov
 2026 14:18:19 +0000
Received: from MWH0EPF000A6735.namprd04.prod.outlook.com
 (2603:10b6:510:5:cafe::98) by PH0PR07CA0004.outlook.office365.com
 (2603:10b6:510:5::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Thu, 12
 Nov 2026 14:18:18 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000A6735.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 12 Nov 2026 14:18:18 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 12 Nov
 2026 06:17:57 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 12 Nov
 2026 06:17:54 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <alex@shazbot.org>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kbusch@meta.com>, <michal.winiarski@intel.com>,
	<satyanarayana.k.v.p@intel.com>, <sonangp@nvidia.com>, <ankita@nvidia.com>,
	<nathanc@nvidia.com>, <mochs@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [RFC PATCH v3 04/20] vfio/pci: Use access ops for config-space accesses
Date: Thu, 12 Nov 2026 14:16:16 +0000
Message-ID: <20261112141632.918954-5-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6735:EE_|MW4PR12MB7431:EE_
X-MS-Office365-Filtering-Correlation-Id: 597553ff-20b6-46d3-f339-08df40c7ccc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|23010399003|1800799024|56012099006|261028144727099003|5023799004|261022113327099003|261021121427099003|261021130227099003|261021135927099003|261022115727099003|261026140227099003|261026121527099003|261009223027099003|261022075727099003|261021133027099003|261021123027099003|261102123227099003|11063799006|261022105027099003|261026130827099003|261026135527099003|18002099003|6133799003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	tuMdYYwiHeDIdPPdvw0fWnigWlT6MhMaIuQyUdS3x3E5bQSlcyhCmmgSPFQMLy+/MoPh5zLA6nSKsgWrvhFDFtHLAtbeftYn7JBgZDKz3/MMEcu/b2uU+/Ig3nZgqrhwxHn2cnr+w0ykCmuJeHJjugkXST27UfTleRkEb8lxDQ6605vIogBh4vtBBk8c7ymVzRPfx70byQkmdBTb4uyW8ulWSKA5Q0OW4Hu9SoMJ/C6fvXQ/8Dpt6E3Sv1fiUXtSVbgUTdqae+y4FkgzgJwSZ1GBpzU0pgw5fPRdeC4oJvuEhh1BVPvXE4g1fwt7UY4NeNHTGF0SGX5hcm5M7zjR234MSBn05SioSCVbFVoAQGIOt/Eydb+z5INBx8XIeP6G3ZrlpG8R56md8Rnv13g/Vev1r3WdSjQZlafCKegdY0Z72qN8C2Khb1OQfjk+oLeg79wE2C2cr0yyZ2hR4yzsUih3cU9HTrAG88cghutdnXwbdI1QPwlkwM/gM1CgwgrzKW27AUv985SYoetQoWgTvDjWWFItD2ufxzoKYlY/Vfvjm7QcuAyHs0gn6N0XRfx+TXKX0w3oIyKmvPIkq5S/EVPjivmG/qVu3xzi/Spc04txUOrYbaYMuLO2yK5p63JaCPkR1++600cgMOSGOPvtdNzcDvS8hs/UBZ8G3Ss+xfyFQ+vaBam5RiCYzayQLpzaJQ7qNJjneyftQz+M0pBF5g==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(23010399003)(1800799024)(56012099006)(261028144727099003)(5023799004)(261022113327099003)(261021121427099003)(261021130227099003)(261021135927099003)(261022115727099003)(261026140227099003)(261026121527099003)(261009223027099003)(261022075727099003)(261021133027099003)(261021123027099003)(261102123227099003)(11063799006)(261022105027099003)(261026130827099003)(261026135527099003)(18002099003)(6133799003)(22082099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	pZFBwevmZXj+yipLOojVPjMPShOBimPOvFo6IkGaqDHq/6nTW8jZ17QtPKbX/Whc8oUZgsnwEiYMs63PMTp4PdOCpiRWnF4nObNUmEox39HfyDaOHAfOOd2NiLNAUIc3P7LNc3Lmc8Ub/qUWmy3/2ztsOJK9VFRVzOMWZo4+CtnXuzKO9x5ziPwt3rAFqJHSq1V1PTcmMfCpyAXPufwhD3gzqDYQoZSRr9lNlRGG9TnpaZzi6loieVUqR4oKwBGAVUPW5EZeIhmSBXPCDRgQN67DsZTW/NevOPFSpR6osrHpQ7V7AyFk5cqhrAbYm4fOF2tgRwpjka4B2x044Jwti1CbOCcNV/NuvLLXHbV75WvN8fOhss7il2jaVQe8wSEhxROhk+Q4CGLokvjavNBVOtug4Cq60ywPlEcEvbqEOR97blDc2pIctiOdtCVzXCkF
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 14:18:18.6879
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 597553ff-20b6-46d3-f339-08df40c7ccc2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6735.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7431

Config-space handlers can touch hardware during recovery. Run them
through vfio_pci_core_access() and keep userspace copies outside SRCU
so page faults cannot delay recovery.

Defer D0 requests until the config handler has left SRCU. Select the
power-state operation under memory_lock and use the bus try-lock helper
for D0. Return transition errors to userspace.

Blocked power operations reject requests. Open and close continue to
use the internal power helper.

Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 drivers/vfio/pci/vfio_pci_priv.h   |   5 ++
 drivers/vfio/pci/vfio_pci_config.c | 122 +++++++++++++++++++++++------
 drivers/vfio/pci/vfio_pci_core.c   |   8 ++
 3 files changed, 109 insertions(+), 26 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
index 2a15a8956205..0ea7c710dc38 100644
--- a/drivers/vfio/pci/vfio_pci_priv.h
+++ b/drivers/vfio/pci/vfio_pci_priv.h
@@ -41,6 +41,9 @@ ssize_t vfio_pci_config_rw_single(struct vfio_pci_core_device *vdev,
 				  char __user *buf, size_t count, loff_t *ppos,
 				  bool iswrite);
 
+int vfio_lock_and_set_power_state(struct vfio_pci_core_device *vdev,
+				  pci_power_t state);
+
 ssize_t vfio_pci_bar_rw(struct vfio_pci_core_device *vdev, char __user *buf,
 			size_t count, loff_t *ppos, bool iswrite);
 
@@ -85,6 +88,8 @@ struct vfio_pci_access_ops {
 	/* Select and call within SRCU. The callback receives kernel buffers. */
 	long (*execute)(struct vfio_pci_core_device *vdev,
 			vfio_pci_access_fn fn, void *data);
+	/* Caller holds memory_lock. */
+	int (*set_power_state)(struct vfio_pci_core_device *vdev, pci_power_t state);
 };
 
 const struct vfio_pci_access_ops *
diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
index 9914f3ac69ae..1e54e2e8b2ef 100644
--- a/drivers/vfio/pci/vfio_pci_config.c
+++ b/drivers/vfio/pci/vfio_pci_config.c
@@ -111,8 +111,13 @@ struct perm_bits {
 	u8	*write;		/* writeable bits */
 	int	(*readfn)(struct vfio_pci_core_device *vdev, int pos, int count,
 			  struct perm_bits *perm, int offset, __le32 *val);
+	/*
+	 * Set power_up for D0 requests. The caller performs the transition
+	 * after leaving SRCU.
+	 */
 	int	(*writefn)(struct vfio_pci_core_device *vdev, int pos, int count,
-			   struct perm_bits *perm, int offset, __le32 val);
+			   struct perm_bits *perm, int offset, __le32 val,
+			   bool *power_up);
 };
 
 #define	NO_VIRT		0
@@ -200,7 +205,8 @@ static int vfio_default_config_read(struct vfio_pci_core_device *vdev, int pos,
 
 static int vfio_default_config_write(struct vfio_pci_core_device *vdev, int pos,
 				     int count, struct perm_bits *perm,
-				     int offset, __le32 val)
+				     int offset, __le32 val,
+				     bool *power_up)
 {
 	__le32 virt = 0, write = 0;
 
@@ -272,7 +278,8 @@ static int vfio_direct_config_read(struct vfio_pci_core_device *vdev, int pos,
 /* Raw access skips any kind of virtualization */
 static int vfio_raw_config_write(struct vfio_pci_core_device *vdev, int pos,
 				 int count, struct perm_bits *perm,
-				 int offset, __le32 val)
+				 int offset, __le32 val,
+				 bool *power_up)
 {
 	int ret;
 
@@ -299,7 +306,8 @@ static int vfio_raw_config_read(struct vfio_pci_core_device *vdev, int pos,
 /* Virt access uses only virtualization */
 static int vfio_virt_config_write(struct vfio_pci_core_device *vdev, int pos,
 				  int count, struct perm_bits *perm,
-				  int offset, __le32 val)
+				  int offset, __le32 val,
+				  bool *power_up)
 {
 	memcpy(vdev->vconfig + pos, &val, count);
 	return count;
@@ -563,7 +571,8 @@ static bool vfio_need_bar_restore(struct vfio_pci_core_device *vdev)
 
 static int vfio_basic_config_write(struct vfio_pci_core_device *vdev, int pos,
 				   int count, struct perm_bits *perm,
-				   int offset, __le32 val)
+				   int offset, __le32 val,
+				   bool *power_up)
 {
 	struct pci_dev *pdev = vdev->pdev;
 	__le16 *virt_cmd;
@@ -613,7 +622,8 @@ static int vfio_basic_config_write(struct vfio_pci_core_device *vdev, int pos,
 			vfio_bar_restore(vdev);
 	}
 
-	count = vfio_default_config_write(vdev, pos, count, perm, offset, val);
+	count = vfio_default_config_write(vdev, pos, count, perm, offset, val,
+					  power_up);
 	if (count < 0) {
 		if (offset == PCI_COMMAND)
 			up_write(&vdev->memory_lock);
@@ -707,11 +717,13 @@ static int __init init_pci_cap_basic_perm(struct perm_bits *perm)
 
 /*
  * It takes all the required locks to protect the access of power related
- * variables and then invokes vfio_pci_set_power_state().
+ * variables and then invokes the selected power-state operation.
  */
-static void vfio_lock_and_set_power_state(struct vfio_pci_core_device *vdev,
-					  pci_power_t state)
+int vfio_lock_and_set_power_state(struct vfio_pci_core_device *vdev,
+				  pci_power_t state)
 {
+	int ret;
+
 	if (state >= PCI_D3hot) {
 		vfio_pci_zap_and_down_write_memory_lock(vdev);
 		vfio_pci_dma_buf_move(vdev, true);
@@ -719,27 +731,36 @@ static void vfio_lock_and_set_power_state(struct vfio_pci_core_device *vdev,
 		down_write(&vdev->memory_lock);
 	}
 
-	vfio_pci_set_power_state(vdev, state);
+	ret = vfio_pci_access_ops(vdev)->set_power_state(vdev, state);
 	if (__vfio_pci_memory_enabled(vdev))
 		vfio_pci_dma_buf_move(vdev, false);
 	up_write(&vdev->memory_lock);
+
+	return ret;
 }
 
 static int vfio_pm_config_write(struct vfio_pci_core_device *vdev, int pos,
 				int count, struct perm_bits *perm,
-				int offset, __le32 val)
+				int offset, __le32 val,
+				bool *power_up)
 {
-	count = vfio_default_config_write(vdev, pos, count, perm, offset, val);
+	count = vfio_default_config_write(vdev, pos, count, perm, offset, val,
+					  power_up);
 	if (count < 0)
 		return count;
 
 	if (offset == PCI_PM_CTRL) {
 		pci_power_t state;
+		int ret;
 
 		switch (le32_to_cpu(val) & PCI_PM_CTRL_STATE_MASK) {
 		case 0:
-			state = PCI_D0;
-			break;
+			/*
+			 * Request D0 after leaving access_srcu. Otherwise, the ASPM update can
+			 * wait for the bus lock while AER waits for this SRCU reader.
+			 */
+			*power_up = true;
+			return count;
 		case 1:
 			state = PCI_D1;
 			break;
@@ -751,7 +772,9 @@ static int vfio_pm_config_write(struct vfio_pci_core_device *vdev, int pos,
 			break;
 		}
 
-		vfio_lock_and_set_power_state(vdev, state);
+		ret = vfio_lock_and_set_power_state(vdev, state);
+		if (ret)
+			return ret;
 	}
 
 	return count;
@@ -799,7 +822,8 @@ static int __init init_pci_cap_pm_perm(struct perm_bits *perm)
 
 static int vfio_vpd_config_write(struct vfio_pci_core_device *vdev, int pos,
 				 int count, struct perm_bits *perm,
-				 int offset, __le32 val)
+				 int offset, __le32 val,
+				 bool *power_up)
 {
 	struct pci_dev *pdev = vdev->pdev;
 	__le16 *paddr = (__le16 *)(vdev->vconfig + pos - offset + PCI_VPD_ADDR);
@@ -812,7 +836,8 @@ static int vfio_vpd_config_write(struct vfio_pci_core_device *vdev, int pos,
 	 * of PCI_VPD_ADDR, then the PCI_VPD_ADDR_F bit is written and we
 	 * have work to do.
 	 */
-	count = vfio_default_config_write(vdev, pos, count, perm, offset, val);
+	count = vfio_default_config_write(vdev, pos, count, perm, offset, val,
+					  power_up);
 	if (count < 0 || offset > PCI_VPD_ADDR + 1 ||
 	    offset + count <= PCI_VPD_ADDR + 1)
 		return count;
@@ -881,13 +906,15 @@ static int __init init_pci_cap_pcix_perm(struct perm_bits *perm)
 
 static int vfio_exp_config_write(struct vfio_pci_core_device *vdev, int pos,
 				 int count, struct perm_bits *perm,
-				 int offset, __le32 val)
+				 int offset, __le32 val,
+				 bool *power_up)
 {
 	__le16 *ctrl = (__le16 *)(vdev->vconfig + pos -
 				  offset + PCI_EXP_DEVCTL);
 	int readrq = le16_to_cpu(*ctrl) & PCI_EXP_DEVCTL_READRQ;
 
-	count = vfio_default_config_write(vdev, pos, count, perm, offset, val);
+	count = vfio_default_config_write(vdev, pos, count, perm, offset, val,
+					  power_up);
 	if (count < 0)
 		return count;
 
@@ -968,11 +995,13 @@ static int __init init_pci_cap_exp_perm(struct perm_bits *perm)
 
 static int vfio_af_config_write(struct vfio_pci_core_device *vdev, int pos,
 				int count, struct perm_bits *perm,
-				int offset, __le32 val)
+				int offset, __le32 val,
+				bool *power_up)
 {
 	u8 *ctrl = vdev->vconfig + pos - offset + PCI_AF_CTRL;
 
-	count = vfio_default_config_write(vdev, pos, count, perm, offset, val);
+	count = vfio_default_config_write(vdev, pos, count, perm, offset, val,
+					  power_up);
 	if (count < 0)
 		return count;
 
@@ -1168,9 +1197,11 @@ static int vfio_msi_config_read(struct vfio_pci_core_device *vdev, int pos,
 
 static int vfio_msi_config_write(struct vfio_pci_core_device *vdev, int pos,
 				 int count, struct perm_bits *perm,
-				 int offset, __le32 val)
+				 int offset, __le32 val,
+				 bool *power_up)
 {
-	count = vfio_default_config_write(vdev, pos, count, perm, offset, val);
+	count = vfio_default_config_write(vdev, pos, count, perm, offset, val,
+					  power_up);
 	if (count < 0)
 		return count;
 
@@ -1881,6 +1912,28 @@ static size_t vfio_pci_cap_remaining_dword(struct vfio_pci_core_device *vdev,
 	return i;
 }
 
+struct vfio_pci_config_access {
+	struct perm_bits *perm;
+	loff_t pos;
+	int count;
+	int offset;
+	__le32 val;
+	bool power_up;
+	bool iswrite;
+};
+
+static long vfio_pci_access_config(struct vfio_pci_core_device *vdev, void *data)
+{
+	struct vfio_pci_config_access *access = data;
+	struct perm_bits *perm = access->perm;
+
+	if (access->iswrite)
+		return perm->writefn(vdev, access->pos, access->count, perm,
+				     access->offset, access->val, &access->power_up);
+	return perm->readfn(vdev, access->pos, access->count, perm,
+			    access->offset, &access->val);
+}
+
 ssize_t vfio_pci_config_rw_single(struct vfio_pci_core_device *vdev,
 				  char __user *buf, size_t count, loff_t *ppos,
 				  bool iswrite)
@@ -1889,6 +1942,7 @@ ssize_t vfio_pci_config_rw_single(struct vfio_pci_core_device *vdev,
 	struct perm_bits *perm;
 	__le32 val = 0;
 	int cap_start = 0, offset;
+	struct vfio_pci_config_access access = {};
 	u8 cap_id;
 	ssize_t ret;
 
@@ -1949,6 +2003,12 @@ ssize_t vfio_pci_config_rw_single(struct vfio_pci_core_device *vdev,
 	WARN_ON(cap_start > *ppos);
 
 	offset = *ppos - cap_start;
+	access.perm = perm;
+	access.pos = *ppos;
+	access.count = count;
+	access.offset = offset;
+	access.iswrite = iswrite;
+
 
 	if (iswrite) {
 		if (!perm->writefn)
@@ -1957,11 +2017,21 @@ ssize_t vfio_pci_config_rw_single(struct vfio_pci_core_device *vdev,
 		if (copy_from_user(&val, buf, count))
 			return -EFAULT;
 
-		ret = perm->writefn(vdev, *ppos, count, perm, offset, val);
+		access.val = val;
+		ret = vfio_pci_core_access(vdev, vfio_pci_access_config, &access);
+		if (ret < 0)
+			return ret;
+		if (access.power_up) {
+			int err = vfio_lock_and_set_power_state(vdev, PCI_D0);
+
+			if (err)
+				return err;
+		}
 	} else {
 		if (perm->readfn) {
-			ret = perm->readfn(vdev, *ppos, count,
-					   perm, offset, &val);
+			access.val = val;
+			ret = vfio_pci_core_access(vdev, vfio_pci_access_config, &access);
+			val = access.val;
 			if (ret < 0)
 				return ret;
 		}
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 6529eab7865b..21c0dda37dd1 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -324,12 +324,20 @@ static long vfio_pci_access_blocked(struct vfio_pci_core_device *vdev,
 	return -EIO;
 }
 
+static int vfio_pci_power_blocked(struct vfio_pci_core_device *vdev,
+				  pci_power_t state)
+{
+	return -EIO;
+}
+
 static const struct vfio_pci_access_ops vfio_pci_live_ops = {
 	.execute = vfio_pci_access_live,
+	.set_power_state = vfio_pci_try_set_power_state,
 };
 
 static const struct vfio_pci_access_ops vfio_pci_blocked_ops = {
 	.execute = vfio_pci_access_blocked,
+	.set_power_state = vfio_pci_power_blocked,
 };
 
 /*
-- 
2.43.0


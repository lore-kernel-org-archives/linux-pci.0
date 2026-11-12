Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794493116;
	b=impFoxAv1/S0zZhMbT1F0+6/pgd5UVj1WGEFhJh+oDTlXDWD/7E3Xln15Fjp5RvjvRs/
	 MXbslhMR3z68zRjzqKLyuh6EUwVBsiujmNpjuWJzr2wAYVkZrI3BKI7tEC8XUwaONRSV7
	 3P7OScka1vUhXeUvKHXiD+3CvTnF7IMm4pXBs6Zvnn9J0HckVNkllCHfzgBrR45r5bXzd
	 8TXBI21qswF/X4sUQoWZ4DO3nlhRZsHn9sGechh1lrqj4Ui0U2h/pBpau98KyGGbxweQ1
	 8AAq1/bW5/QMRji9eOZjAHg+tGI2zCOnY4gFoWK66f4gEXddxjxF2jYxphCNgt0dpTg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794493116;
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
	bh=sf14HcvcX6V0hVRD/1PreGOBW0rqSC9GM5TcftPA6RA=;
	b=hNwuMnS4gOjIY+R0GrSXEuieBf/EIFI7fcVftcokxVMze1ZmlAH3abqFsmwY1BGjk7F7
	 tPpr0FyNu0qediF1bzHahHrGUqzlmVLvOrV4uCHFi8kf/4oVKwB+XPmagGQiRN7oEOOwA
	 TwTKk2X5Ay57c9sHHuochTrzCezuqU3zlgeBEVjNVQ6OiIfP4SGXkglwk4/btqvhVd6PY
	 fSNKOXjI9Hr+HpfefhBNmK7dBvdqEzb6Bvtpxt4PM24KVtbvq8+HSQ3qQVGRpCf0J0Ncu
	 YGuZ4mFOfw7VZiZ0LTBENKm4hxTofJTn/YCe2ul5TobYIpBO8FV4V/29eeSebTi2CFA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=aoxo4LUh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.48
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010048.outbound.protection.outlook.com [52.101.46.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662CF606C4F3;
	Thu, 12 Nov 2026 14:18:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 662CF606C4F3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=aoxo4LUh
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d7OZB8aEuThEp7Oiie9LRfsnEEiWTsElHgsPlFzpOBaktZAOGd+6hvnrbnQyFudTxFBoCZGOc4BJo0GQa22LuRhUoBztmEBcIhcu65Se1KN7TI4f4ZnTiLqDZOZgrEOkA6/Fsr1wErktCbps0bFS2Gm38GrQssI7ScK1PyoSYTeKKsTrUNYFSFfk6VWxhzMCO5WKQI/6kz9aQ3YRJv51IBCmAR+n2AEDAMnrpxj9xGaRYeuRlAVKE2zHajJxNkzStU8ejyGCuuTU/P1v7qvaMwHmWZjLvKsEadBVzT1Ufd+A2HhsLV5lnd0hKg0zcCySE9aGQXD7H98GzWUH0c1H+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sf14HcvcX6V0hVRD/1PreGOBW0rqSC9GM5TcftPA6RA=;
 b=Gbae2MVaA+Zf9IDnvAUwwrsNb8qNA2abyNc4qb7nfp/B6hS1Q+FB+bpdX2ozBBpZrlhZILOWoonG/qgZoFAa1zkrP0pBVO1um77tw24MPeQFpprQfPMAkZXsyIOsgZY6eaOH/JepG2akSL1J7YHURZR7mECX/sudTvToolTIa4YET9mb4HN1SJqnF4zH73SIInkxjzjzVHhRknH9jkrJ4bJ4XoaSrC4E2KOQJp3olB3q/P8Z1+30ihtrXQDRDpFu6sNwqjuQ3PxmN1c/oH9hB3pkNG+IVjmtpvVaG2pGByxlAId8mj8R8fQNUpazfdRPREC2CElgpqTTxrizIebpDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sf14HcvcX6V0hVRD/1PreGOBW0rqSC9GM5TcftPA6RA=;
 b=aoxo4LUhLXDMeZih7/k81Kze7lPjgKy2Yi2D4b8njknMyn45CLV7S7pSjUGTkOoMoHtfHcRor8tS95/mK0az5opAF+R3KcrElkIyTNIx/VUQM7lgEk0FRo77AfTPH95Dp+J+SLXt7XM0W0YChmzL2qPEKAxFSWRdRgJn8Rdkopl3R+YZcfll4QTPUoZZ9H+ccVIEcpjZaJNxUZSn07/fDMWkWx/EboKah+lUZjn9js4EjRB3Yvb6uayaq9jWp4h8MezhO6NW+GXWuymEDkzfPo5Tk4Ovg1W2gXV50whryv6D7BncTESr0VdPnK4omYboduSAnEvQZMByY0GXhAT+eQ==
Received: from PH0PR07CA0003.namprd07.prod.outlook.com (2603:10b6:510:5::8) by
 DS2PR12MB9685.namprd12.prod.outlook.com (2603:10b6:8:27a::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.10; Thu, 12 Nov 2026 14:18:28 +0000
Received: from MWH0EPF000A6735.namprd04.prod.outlook.com
 (2603:10b6:510:5:cafe::7e) by PH0PR07CA0003.outlook.office365.com
 (2603:10b6:510:5::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Thu, 12
 Nov 2026 14:18:27 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000A6735.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 12 Nov 2026 14:18:27 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 12 Nov
 2026 06:18:04 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 12 Nov
 2026 06:18:01 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <alex@shazbot.org>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kbusch@meta.com>, <michal.winiarski@intel.com>,
	<satyanarayana.k.v.p@intel.com>, <sonangp@nvidia.com>, <ankita@nvidia.com>,
	<nathanc@nvidia.com>, <mochs@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [RFC PATCH v3 06/20] vfio/pci: Use access ops for BAR and ROM accesses
Date: Thu, 12 Nov 2026 14:16:18 +0000
Message-ID: <20261112141632.918954-7-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6735:EE_|DS2PR12MB9685:EE_
X-MS-Office365-Filtering-Correlation-Id: 929d40d8-d635-413e-63b1-08df40c7d219
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|376014|1800799024|82310400026|10067099003|11063799006|56012099006|261021123027099003|261021121427099003|261022105027099003|261022075727099003|261009223027099003|261102130727099003|261102123227099003|261028144727099003|261026121527099003|261026140227099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	DdqlaqPqgSmlgerzjU5d7Pj/Y9HoYzgYAZi8NmXadI5v/BOuRf0FLK/k9/bnZT9Xlun3cs/xGx4xRXFzxgDHcpkKMwgjRKL4iWyd08JSs9EdKmUhpJQi3HheJIvw2J2xY1tD+K9Y6XI7Ett2Dvwz/PR86Cw7wxqlSF1P7YMD2i30/Kufu2aeIHz0Ki0Re1YjG+8q4y/Zr6FS1CntiiY5N00PxubwKTgMsksApd6bgAqUEQL7RL3RbesdPBNoVK3vpJ5E+pLD/VgBm6/O9pGmqrmT85gdI9oZgQBryZ8NucfAud3EvN3lrkzl6SnJ7paORs/8CGDDzJmUxfZy+ViXhLffGohWeY7qUwf4AKVI/NeVUu4hhT7NahXDlCmq/ih6LB883bieMhbEGRAB56IktpAaq1UUhu2okDScE8LYegfELYC1QFSUND7mBAjXhUy8QfKlG6gtVXgXee3NxM2LeizkS8UuuwizOc8tbat4+dIWl15rZCJQydWYeiuPJr1HpMMvB221mpjlnbvtB3qrzZRJ0EvvzHt/AyBteKcUoV5ciH0c+ccRa6RcltAJQ4+/33z70kvL4o4aUtbcHXqyQJ96I8lECCSBT9BY+lpbdsusvIarjMMB99R6QxSpoUILDySCsJMtFeaC+O5jBJ+KzfFgnIIbwJimVkrkQgBi7ZG3EprsaTZ04cqJolpKfB03je+UFJ2xk/QQdYC2INmonw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(376014)(1800799024)(82310400026)(10067099003)(11063799006)(56012099006)(261021123027099003)(261021121427099003)(261022105027099003)(261022075727099003)(261009223027099003)(261102130727099003)(261102123227099003)(261028144727099003)(261026121527099003)(261026140227099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ebjVU7RZmy+xIaQcVUChy402Z7c8kBQkKKcs6sewWpTizcrAC2A4HCM+vp5ML/WrW2f1tcbhgST9gdtAmfRMmHMWEmUWyG601DAIYujzL2uST3qxf8Zp2tJcCMrrVDI8bNdhdC2O2xljtDMkLO/ktJIn3uMEzM8F538rp0eQuunr13+QBTBTS7o7h+aNGdbvqOIvCwIKv0xKtIxdpuKO57JSRZyl0M/NeVcRf/grmsbjZNugPP3KaLQ+kdr4tHKh2B0WJ7Sa/q7RMGqmFxsD86rn7P9AzHZHRGAvjxWtaEA7IcJVI848hzGodIjtp0AdeWkA4fU4VZT3Dbjha3azav3hOtoArqJGPdcPOKOeVsr8En+FMXwn+VLi03i+qD48n6zXEIxwW+HZID75l4QFjDz2dJ2ACFNQREc0z0P02FjzgxPKPiE33StLGnxkF5gZ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 14:18:27.6464
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 929d40d8-d635-413e-63b1-08df40c7d219
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6735.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9685

Recovery needs to wait for hardware reads and writes to finish before
changing device state. Use access ops for individual MMIO and PIO
reads and writes, covering BAR, VGA, port-I/O and ioeventfd accesses.
Keep copies to and from userspace outside SRCU.

For ROM reads, keep mapping, reading into the buffer and unmapping within
one SRCU read-side section. Copy the buffered data to userspace afterward.

Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 drivers/vfio/pci/vfio_pci_rdwr.c | 156 ++++++++++++++++++++-----------
 1 file changed, 102 insertions(+), 54 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_rdwr.c b/drivers/vfio/pci/vfio_pci_rdwr.c
index 10cd091031fe..8494e93c18fb 100644
--- a/drivers/vfio/pci/vfio_pci_rdwr.c
+++ b/drivers/vfio/pci/vfio_pci_rdwr.c
@@ -40,57 +40,81 @@
 #define vfio_ioread8	ioread8
 #define vfio_iowrite8	iowrite8
 
-#define VFIO_IOWRITE(size) \
-int vfio_pci_core_iowrite##size(struct vfio_pci_core_device *vdev,	\
-			bool test_mem, u##size val, void __iomem *io)	\
-{									\
-	if (test_mem) {							\
-		down_read(&vdev->memory_lock);				\
-		if (!__vfio_pci_memory_enabled(vdev)) {			\
-			up_read(&vdev->memory_lock);			\
-			return -EIO;					\
-		}							\
-	}								\
-									\
-	vfio_iowrite##size(val, io);					\
-									\
-	if (test_mem)							\
-		up_read(&vdev->memory_lock);				\
-									\
-	return 0;							\
-}									\
-EXPORT_SYMBOL_GPL(vfio_pci_core_iowrite##size);
-
-VFIO_IOWRITE(8)
-VFIO_IOWRITE(16)
-VFIO_IOWRITE(32)
-VFIO_IOWRITE(64)
-
-#define VFIO_IOREAD(size) \
-int vfio_pci_core_ioread##size(struct vfio_pci_core_device *vdev,	\
-			bool test_mem, u##size *val, void __iomem *io)	\
-{									\
-	if (test_mem) {							\
-		down_read(&vdev->memory_lock);				\
-		if (!__vfio_pci_memory_enabled(vdev)) {			\
-			up_read(&vdev->memory_lock);			\
-			return -EIO;					\
-		}							\
-	}								\
-									\
-	*val = vfio_ioread##size(io);					\
-									\
-	if (test_mem)							\
-		up_read(&vdev->memory_lock);				\
-									\
-	return 0;							\
-}									\
-EXPORT_SYMBOL_GPL(vfio_pci_core_ioread##size);
-
-VFIO_IOREAD(8)
-VFIO_IOREAD(16)
-VFIO_IOREAD(32)
-VFIO_IOREAD(64)
+struct vfio_pci_io_access {
+	bool test_mem;
+	void __iomem *io;
+	void *val;
+};
+
+#define VFIO_IOWRITE(size, type)						\
+static long vfio_pci_access_iowrite##size(struct vfio_pci_core_device *vdev,	\
+					       void *data)			\
+{										\
+	struct vfio_pci_io_access *access = data;				\
+	type *val = access->val;						\
+										\
+	if (access->test_mem) {							\
+		down_read(&vdev->memory_lock);					\
+		if (!__vfio_pci_memory_enabled(vdev)) {				\
+			up_read(&vdev->memory_lock);				\
+			return -EIO;						\
+		}								\
+	}									\
+										\
+	vfio_iowrite##size(*val, access->io);					\
+	if (access->test_mem)							\
+		up_read(&vdev->memory_lock);					\
+	return 0;								\
+}										\
+										\
+int vfio_pci_core_iowrite##size(struct vfio_pci_core_device *vdev,		\
+			 bool test_mem, type val, void __iomem *io)		\
+{										\
+	struct vfio_pci_io_access access = { test_mem, io, &val };		\
+										\
+	return vfio_pci_core_access(vdev, vfio_pci_access_iowrite##size, &access);	\
+}										\
+EXPORT_SYMBOL_GPL(vfio_pci_core_iowrite##size)
+
+VFIO_IOWRITE(8, u8);
+VFIO_IOWRITE(16, u16);
+VFIO_IOWRITE(32, u32);
+VFIO_IOWRITE(64, u64);
+
+#define VFIO_IOREAD(size, type)							\
+static long vfio_pci_access_ioread##size(struct vfio_pci_core_device *vdev,	\
+					       void *data)			\
+{										\
+	struct vfio_pci_io_access *access = data;				\
+	type *val = access->val;						\
+										\
+	if (access->test_mem) {							\
+		down_read(&vdev->memory_lock);					\
+		if (!__vfio_pci_memory_enabled(vdev)) {				\
+			up_read(&vdev->memory_lock);				\
+			return -EIO;						\
+		}								\
+	}									\
+										\
+	*val = vfio_ioread##size(access->io);					\
+	if (access->test_mem)							\
+		up_read(&vdev->memory_lock);					\
+	return 0;								\
+}										\
+										\
+int vfio_pci_core_ioread##size(struct vfio_pci_core_device *vdev,		\
+			 bool test_mem, type *val, void __iomem *io)		\
+{										\
+	struct vfio_pci_io_access access = { test_mem, io, val };		\
+										\
+	return vfio_pci_core_access(vdev, vfio_pci_access_ioread##size, &access);	\
+}										\
+EXPORT_SYMBOL_GPL(vfio_pci_core_ioread##size)
+
+VFIO_IOREAD(8, u8);
+VFIO_IOREAD(16, u16);
+VFIO_IOREAD(32, u32);
+VFIO_IOREAD(64, u64);
 
 #define VFIO_IORDWR(size)						\
 static int vfio_pci_iordwr##size(struct vfio_pci_core_device *vdev,\
@@ -200,12 +224,20 @@ ssize_t vfio_pci_core_do_io_rw(struct vfio_pci_core_device *vdev, bool test_mem,
 }
 EXPORT_SYMBOL_GPL(vfio_pci_core_do_io_rw);
 
-static ssize_t vfio_pci_rom_read(struct vfio_pci_core_device *vdev,
-				 char __user *buf, size_t count, loff_t pos)
+struct vfio_pci_rom_access {
+	size_t count;
+	loff_t pos;
+	void *data;
+	size_t length;
+};
+
+static long vfio_pci_access_rom(struct vfio_pci_core_device *vdev, void *arg)
 {
+	struct vfio_pci_rom_access *access = arg;
 	struct pci_dev *pdev = vdev->pdev;
 	bool rom_bar = pci_resource_start(pdev, PCI_ROM_RESOURCE);
-	size_t size, length = 0, done = 0;
+	size_t count = access->count, size, length = 0, done = 0;
+	loff_t pos = access->pos;
 	void *data = NULL;
 	void __iomem *io;
 	ssize_t ret;
@@ -272,6 +304,22 @@ static ssize_t vfio_pci_rom_read(struct vfio_pci_core_device *vdev,
 		iounmap(io);
 out_unlock:
 	up_write(&vdev->memory_lock);
+	access->data = data;
+	access->length = length;
+	return ret;
+}
+
+static ssize_t vfio_pci_rom_read(struct vfio_pci_core_device *vdev,
+				 char __user *buf, size_t count, loff_t pos)
+{
+	struct vfio_pci_rom_access access = { .count = count, .pos = pos };
+	size_t length, done;
+	void *data;
+	ssize_t ret;
+
+	ret = vfio_pci_core_access(vdev, vfio_pci_access_rom, &access);
+	data = access.data;
+	length = access.length;
 	if (ret < 0)
 		goto out_free;
 
-- 
2.43.0


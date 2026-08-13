Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013070.outbound.protection.outlook.com [40.107.201.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4D6443ABA;
	Thu, 13 Aug 2026 09:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786614061; cv=fail; b=Zy6oQhcEqUcYnRGQxeDJojMld2kOPAtq1SqjbBmjQoCsM156gxYJAEkaepI6X9bzWkYmrmwGnnUOvKDUv0T93ZWqwO15b2MvfOCk4lRVanJhkzLAk70PbnQpvk1RfBTmTrDIV3uqSU1w/VAKGOINrY2z1iumyDnD1JdqgpwSMX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786614061; c=relaxed/simple;
	bh=MvehUse7PN/SsmihSLf1esV6X71ue54uGJvYuL8b1H0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TzLAK1tWoSKlpdNJEaNLiJbIsuMyDBci5Ass4G8KKNMebpZFm5qt9GXSL4rlqchnbqdgwaADNz1aSl3Ju6TwOV/wQ891Vq9s2168t1WNcTv+8hRsflE5pqh3hZE/QUUGweqwv6QRedtiiYn446NFk56jlKKz5AnaZWBgJL8GG90=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=USIuo6vZ; arc=fail smtp.client-ip=40.107.201.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="USIuo6vZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b+03dgiVawBv+5r9ameEmkB88bDD3D7mjJRE6ehVc0AWiI/T8IVhTuL3wwq3C/1BCSQzSknaMQq4rTNrJ2+93hlK4ESe3YQX3lVZ5tgKlhz//yypRyGbBVWJuZJp1kxyRTIcgQgo68YMG07d4Ca8vZDeD40u5jzseYGZ2jL3u6ZyzvDgtZMinZvMsm676zGAQZIyjgbscGNtJc655Ww5CKkmDh7k2nZTQLB5Dkhaneida0Fe+pCAhWXFxyH6WWu4SqvvpFo2pSkzJPgnoMfwRCWWNdgyIL+vHP22AHoes9Gog56Fi6Co5mfq7r7HYkCPbNSjDyOZ5JRfG6o+Q4qFKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9H/dFY2QssKu4ZEPc/hQety0VjCJCb1arfiS7jcFWms=;
 b=Q0u58gEuA8B6ZgFSx5MyqOfK3K/W3HTrILXRT5nPHGmZAt4dDmMvdu4CalRax1RwE76WDOsXrb7Wl4We7JrrvkcHC/C7fmgVyfI5j4I0Iagn9YrsxhYohcJ8u9QEvtR1Ld2Sp1PYvEk/JIrnYF19zjz9+ve9d7y5+pp9t6Y0t2OFSu8hjVHrJOO5tmpRmXRv3iLHtnCXyIAvN0q6TD9FhjfLiL4Xvmm97oXpSou/cyvy29PPwLMDAIOpLLK8CM6mU/rwjF9gQ2pbamVhxv9XMUG1dpp7RfW1BBtWyogfIHL2jUJc5+g9Mh/QrTIljBKET8ocELZ7zpUklGkdJDsl0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9H/dFY2QssKu4ZEPc/hQety0VjCJCb1arfiS7jcFWms=;
 b=USIuo6vZ6sdUCW6vsps2Ep7jBvfGwoDhJ/+SDGQFlGWVelUv02GweKHRSxWpsQPhciQdY0Ugw+TNdfCiAfAvTlreBH/DNXMZtLFzw4avuh/w0K1Ebk6RFkmitgsXIZY1nN7Ke9GGNz/c1mt35NNkIQ1hS7HSlphdTpJfisKLs9d/Iw7JtrB6p6VCUhOaSln4Wl2LuXBF/r1KlpcMSPw61zbF7pwNVV1ptGutmjP6oscN1gTCBt9YGezyd1StTzxqY5Ld/OJu2tq0iURaUrlT12GtAQfbwoH/VhlfWTy2byFkvgXd8P8RRV8W6aAmSKRCWEEGMw91Q8SCAmUSXmiDZw==
Received: from SJ0PR05CA0053.namprd05.prod.outlook.com (2603:10b6:a03:33f::28)
 by PH8PR12MB6988.namprd12.prod.outlook.com (2603:10b6:510:1bf::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Thu, 13 Aug
 2026 09:40:41 +0000
Received: from MWH0EPF000C618B.namprd02.prod.outlook.com
 (2603:10b6:a03:33f:cafe::4) by SJ0PR05CA0053.outlook.office365.com
 (2603:10b6:a03:33f::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.13 via Frontend Transport; Thu,
 13 Aug 2026 09:40:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000C618B.mail.protection.outlook.com (10.167.249.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Thu, 13 Aug 2026 09:40:41 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 13 Aug
 2026 02:40:22 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 13 Aug 2026 02:40:13 -0700
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
Subject: [PATCH v4 20/27] vfio/cxl: Emulate the HDM decoder commit handshake
Date: Thu, 13 Aug 2026 15:06:24 +0530
Message-ID: <20260813093631.2288172-21-mhonap@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260813093631.2288172-1-mhonap@nvidia.com>
References: <20260813093631.2288172-1-mhonap@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000C618B:EE_|PH8PR12MB6988:EE_
X-MS-Office365-Filtering-Correlation-Id: 60bc2338-2c3d-4ad1-ce0f-08def91ef075
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|7416014|376014|23010399003|22082099003|18002099003|56012099006|11063799006|3023799007|10067099003|921020|6133799003;
X-Microsoft-Antispam-Message-Info:
	bHCyiugWEDND89qy+9XkNAH1siY9m5iuMPEMpkxYTWAOIUzKvW6C3PVSNMlAuvLMdhxXvEW1BEsqU4kKZuQmUGS7Fg5lJFqeu1gF/gJyH36JNYWQx3rlTcIV1aL4rpB/78LiUzyz6eEnSbp9kfDo7iuGxWavUxHGtQmzzIPDubjqfe69e4vUU+N3ZJ+FhsJqI44Tg+xPVW4q+DCQJjElg+U8n9lZdS+6J/w7pedF71B+GL32IuK933+N7DqN0LNt9ro41NtKoD3uEKtZAlg6t6vTETun6+xWdU42CxrybttVtjUAv2KaXmVAYdIzz+zvIal5/0swAAxzJHDiLLBrqACtZJQDo4LCe20TVqr+diowRK+HxCk8AQZC6/f7vEYaMtj3Gk04dn1S8nHsPExJ+0ljrxAuEOhMK1uh12Qbn+KJhNv7m9SK3faZRZiXM83QR9SE/mDdrcnlfA0aKQpde+my5dT3XtTiKR5Pih9QihWyniejyBK654tcDV0iHjoTOOxSfrKBdIP3IeYtvhklLbnnkCWGXNNYyXuLvoO/YwW2H9qUbtT2+FtokgXrfFGOo4xNMGN5nOGLNHG9OP0E83Y5dpRg+oqZGaVAo99v/eg01R3SQxR2lg5eh//YEMZFOxZIY+l0UC7zTTCmNwIMDof0CSf0ENwFuWjXi/QyxRRGP2wITboeyik0ZABS67GbxeN6AylHCkxrN54TX7JzAIzBpcQt1xQ7rUl8BTl+W37+KWjTH/5GIhRhLXWcEnUq
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(7416014)(376014)(23010399003)(22082099003)(18002099003)(56012099006)(11063799006)(3023799007)(10067099003)(921020)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	XhItESmiU5gLwPHKaVl2IoaXPfTExQMQO4I2lKijENGO3HkWGl85D3hL2zrvDGbA1ruZh6BGXJCu++JOm8E7wvQkno+UKSYyJk1w9dByQNhIqMHePoG8W1lFrmZXn35MJBLhghPEEFQVJHCoQPvYyTjp2Wr9CPslsd77SU+5q0UrWkWtIvuNJ6gD1bje3NNAo7+weeR6NnIXJbizoktDt2HlngQ0oXTDbK4MkxWiq/bHBWfy9hy68YfViNrUOs4gMrGPyusxR/oCoj1Ja7nPz4mHglAFZJyW/sRkXbWbl9rQj2uAtIfLWUkf0vxpld9odxFq4Og90Mz30YEKLFXVtqUbjJKLL4OmuwSFKmYeCT6ZJTn9ZuCX12zZEgOwqmcNTNeWgOM8VemJseUjLIjHy0qVaJ57ANcsob4NOhK1eQXM/dumvGzd86tsghqGbcKO
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 09:40:41.0331
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60bc2338-2c3d-4ad1-ce0f-08def91ef075
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C618B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6988

From: Manish Honap <mhonap@nvidia.com>

Let the guest drive its virtual decoder now that the register window is
trapped. Writes stay in the per-open shadow so the guest never touches
the physical decoder; the host has already resolved the HPA.

The control register carries the commit handshake, so reflect a commit
request straight to committed and drop the error bit. A decoder that
committed with lock set stays frozen until the device is reset, when the
shadow is sampled afresh.

Apply per-field write semantics to the rest of the block rather than
storing every write verbatim: gate base and size on the committed state,
so they change only across a decommit, and drop writes to the read-only
capability register.

Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 drivers/vfio/pci/cxl/vfio_cxl_core.c | 156 ++++++++++++++++++++++++---
 1 file changed, 142 insertions(+), 14 deletions(-)

diff --git a/drivers/vfio/pci/cxl/vfio_cxl_core.c b/drivers/vfio/pci/cxl/vfio_cxl_core.c
index f91f6eb8b8fb..ec938813bd91 100644
--- a/drivers/vfio/pci/cxl/vfio_cxl_core.c
+++ b/drivers/vfio/pci/cxl/vfio_cxl_core.c
@@ -15,6 +15,7 @@
 #include <linux/uaccess.h>
 #include <linux/vfio_pci_core.h>
 #include <cxl/cxl.h>
+#include <cxl/cxl_regs.h>
 #include <cxl/pci.h>
 
 /**
@@ -222,33 +223,159 @@ static int vfio_cxl_register_pfn_space(struct vfio_pci_core_device *vdev)
 	return register_pfn_address_space(&cxl->dpa_pfn_space);
 }
 
+/*
+ * Only an endpoint decoder's control register carries the commit handshake.
+ * A single non-interleaved decoder is assumed; switch topologies would widen
+ * which offsets qualify.
+ */
+static bool vfio_cxl_ctrl_offset(loff_t pos)
+{
+	unsigned int stride = CXL_HDM_DECODER0_CTRL_OFFSET(1) -
+			      CXL_HDM_DECODER0_CTRL_OFFSET(0);
+	loff_t off = pos - CXL_HDM_DECODER0_CTRL_OFFSET(0);
+
+	return pos >= CXL_HDM_DECODER0_CTRL_OFFSET(0) && off % stride == 0;
+}
+
+static void vfio_cxl_ctrl_write(struct vfio_cxl_state *cxl, u32 idx, u32 val)
+{
+	u32 old = le32_to_cpu(cxl->hdm_shadow[idx]);
+	u32 wmask = CXL_HDM_DECODER0_CTRL_IG_MASK |
+		    CXL_HDM_DECODER0_CTRL_IW_MASK |
+		    CXL_HDM_DECODER0_CTRL_LOCK |
+		    CXL_HDM_DECODER0_CTRL_COMMIT |
+		    CXL_HDM_DECODER0_CTRL_HOSTONLY;
+
+	/* A committed decoder that asked to lock stays put until reset. */
+	if ((old & CXL_HDM_DECODER0_CTRL_COMMITTED) &&
+	    (old & CXL_HDM_DECODER0_CTRL_LOCK))
+		return;
+
+	/*
+	 * Take only the guest-writable fields and preserve the reserved bits and
+	 * the emulation-owned status bits (COMMITTED/COMMIT_ERROR) from the
+	 * shadow, so the VMM never reads back guest-authored reserved state.
+	 */
+	val = (old & ~wmask) | (val & wmask);
+
+	/*
+	 * The host resolved the HPA before the guest ever saw the device, so a
+	 * commit request always lands and clearing it tears the guest view down.
+	 */
+	if (val & CXL_HDM_DECODER0_CTRL_COMMIT)
+		val = (val | CXL_HDM_DECODER0_CTRL_COMMITTED) &
+		      ~CXL_HDM_DECODER0_CTRL_COMMIT_ERROR;
+	else
+		val &= ~CXL_HDM_DECODER0_CTRL_COMMITTED;
+
+	cxl->hdm_shadow[idx] = cpu_to_le32(val);
+}
+
+/*
+ * Base, size, and the Target List / Skip registers are all RWL: they lock on
+ * commit, so every one of them is filtered through the committed guard.
+ */
+static bool vfio_cxl_base_size_offset(loff_t pos)
+{
+	return pos == CXL_HDM_DECODER0_BASE_LOW_OFFSET(0) ||
+	       pos == CXL_HDM_DECODER0_BASE_HIGH_OFFSET(0) ||
+	       pos == CXL_HDM_DECODER0_SIZE_LOW_OFFSET(0) ||
+	       pos == CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(0) ||
+	       pos == CXL_HDM_DECODER0_SKIP_LOW(0) ||
+	       pos == CXL_HDM_DECODER0_SKIP_HIGH(0);
+}
+
+/*
+ * Reserved dwords in the single-decoder HDM block: 0x08 and 0x0c between the
+ * global control register and decoder 0, and 0x2c after decoder 0's registers.
+ * Keep them read-only so the VMM never reads back guest-authored reserved state.
+ */
+static bool vfio_cxl_reserved_offset(loff_t pos)
+{
+	return pos == 0x08 || pos == 0x0c || pos == 0x2c;
+}
+
+/*
+ * BASE_LOW and SIZE_LOW expose only the 256MB-aligned upper nibble [31:28];
+ * bits [27:0] are RsvdP. Preserve the reserved low bits so the VMM never reads
+ * back an unaligned base or size.
+ */
+#define CXL_HDM_DECODER_LOW_ADDR_MASK 0xf0000000U
+
+static void vfio_cxl_base_size_write(struct vfio_cxl_state *cxl, u32 idx,
+				     __le32 val)
+{
+	u32 ctrl = le32_to_cpu(cxl->hdm_shadow[CXL_HDM_DECODER0_CTRL_OFFSET(0) /
+					       sizeof(u32)]);
+	loff_t off = (loff_t)idx * sizeof(u32);
+	u32 new = le32_to_cpu(val);
+
+	/* A committed decoder holds its position fields until it decommits. */
+	if (ctrl & CXL_HDM_DECODER0_CTRL_COMMITTED)
+		return;
+
+	if (off == CXL_HDM_DECODER0_BASE_LOW_OFFSET(0) ||
+	    off == CXL_HDM_DECODER0_SIZE_LOW_OFFSET(0)) {
+		u32 old = le32_to_cpu(cxl->hdm_shadow[idx]);
+
+		new = (old & ~CXL_HDM_DECODER_LOW_ADDR_MASK) |
+		      (new & CXL_HDM_DECODER_LOW_ADDR_MASK);
+	}
+
+	cxl->hdm_shadow[idx] = cpu_to_le32(new);
+}
+
 static ssize_t vfio_cxl_comp_rw(struct vfio_pci_core_device *vdev,
 				char __user *buf, size_t count, loff_t *ppos,
 				bool iswrite)
 {
 	struct vfio_cxl_state *cxl = vdev->cxl;
 	loff_t pos = *ppos & VFIO_PCI_OFFSET_MASK;
+	size_t o;
 
-	/*
-	 * The guest programs a GPA into this decoder and the host resolves the
-	 * HPA, so the guest never drives the physical decoder. Reads come from
-	 * the open-time snapshot; write emulation lands in a later change.
-	 */
-	if (iswrite)
+	if (pos >= cxl->hdm_len)
 		return -EINVAL;
 
-	if (pos >= cxl->hdm_len)
+	/* The decoder registers only take aligned dword accesses. */
+	if (pos % sizeof(u32) || count % sizeof(u32))
 		return -EINVAL;
 
 	count = min_t(size_t, count, cxl->hdm_len - pos);
+
+	if (!iswrite) {
+		/*
+		 * The shadow mirrors the physical decoder, so BASE_LOW/HIGH
+		 * carry the host HPA. That is visible only to the trusted VMM
+		 * holding the fd; the VMM virtualizes the base so the guest sees
+		 * its own GPA and never the host address.
+		 */
+		if (copy_to_user(buf, (u8 *)cxl->hdm_shadow + pos, count))
+			return -EFAULT;
+		*ppos += count;
+		return count;
+	}
+
 	/*
-	 * The shadow mirrors the physical decoder, so BASE_LOW/HIGH carry the
-	 * host HPA. That is visible only to the trusted VMM holding the fd; the
-	 * VMM virtualizes the base so the guest sees its own GPA and never the
-	 * host address.
+	 * The guest programs a GPA into this decoder while the host resolves
+	 * the HPA, so writes stay in the shadow. Each register follows its own
+	 * class: control runs the commit handshake, base and size are locked
+	 * once committed, and the capability header is fixed.
 	 */
-	if (copy_to_user(buf, (u8 *)cxl->hdm_shadow + pos, count))
-		return -EFAULT;
+	for (o = 0; o < count; o += sizeof(u32)) {
+		u32 idx = (pos + o) / sizeof(u32);
+		__le32 val;
+
+		if (copy_from_user(&val, buf + o, sizeof(val)))
+			return -EFAULT;
+
+		if (vfio_cxl_ctrl_offset(pos + o))
+			vfio_cxl_ctrl_write(cxl, idx, le32_to_cpu(val));
+		else if (vfio_cxl_base_size_offset(pos + o))
+			vfio_cxl_base_size_write(cxl, idx, val);
+		else if (pos + o >= sizeof(u32) &&
+			 !vfio_cxl_reserved_offset(pos + o))
+			cxl->hdm_shadow[idx] = val;
+	}
 
 	*ppos += count;
 	return count;
@@ -454,7 +581,8 @@ static int vfio_cxl_open_device(struct vfio_pci_core_device *vdev)
 	ret = vfio_pci_core_register_dev_region(vdev, VFIO_REGION_TYPE_CXL,
 						VFIO_REGION_SUBTYPE_CXL_COMP_REGS,
 						&vfio_cxl_comp_regops, cxl->hdm_len,
-						VFIO_REGION_INFO_FLAG_READ, cxl);
+						VFIO_REGION_INFO_FLAG_READ |
+						VFIO_REGION_INFO_FLAG_WRITE, cxl);
 	if (ret)
 		goto err_unregister_hdm;
 
-- 
2.25.1


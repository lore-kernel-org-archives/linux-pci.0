Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010003.outbound.protection.outlook.com [52.101.46.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102F73DF01C;
	Tue, 29 Sep 2026 17:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790703254; cv=fail; b=nVAHpS4uhlkkMaSuu6qApvYYUUUUF6sxMinLCLvn8DhxhJVvCIcy2Y4lUFN8hEXwCn3NN0DaUO6GgxLhjp79vY8gZQ1F+RyaXDmSe/vQql50yUtL5U7mkPOesgtpGWzCmxJjqFZcEczFcx3T5ARbzXbvHRjVf2Qm4d9V3dWBtHY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790703254; c=relaxed/simple;
	bh=KAiIqVsSR+A5DTglElMcul7LUS5kEHvw8ukIvc9vIyE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cjJtgHlNNX8nkbDDvfkVh9+RQ5ln/RFUCuDL30PgsdB5xg6f9b3cdeGO2cHXYTxYCIJwVRycOef18u3qA6yuagNL3Hge5vvlNMBfn59FXEWC2kmj8MhqJStoPCszaK6g6bRYDug3UxsmbQakEqxQjLbUbzRNMW5LPNczHmDTbj0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RCDwg4b8; arc=fail smtp.client-ip=52.101.46.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RCDwg4b8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=agjJWKE387cxzVjkbvq5694eakkKeu3P5B7vIzj+1tdF188s3Zu0ZgmbMDh5ypI2hM5pDwNLVWOKQtjQvh4EPV7ZhZ30AdFLe4ZeYqHZmoqmYSct4urJhvZVRHeOQzqomqxKMfEJGncjw8LkN1UCt0dGha1vL7LSIMAj8lt2I2OnGdfB57/jgHwQOgNNsQFGAAj2EUpcJF2dP1bw0uK7shGADDhQ+NhhLmA0CJEda7H5Bkkolq4HHzQdKic3AXicTU5fcLpEBVdWCvamocmWBXLYUnSz3Oe9edvMuiawMULTWiex4telTaPIoSQWzuVNwGLWZoqdn39KbGOVuNHmrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A9n+7M0nXV9U3YltSpLb8ROaOra0cXgEU7gXaP2uRBk=;
 b=HYCBMQUFlzNKsPdHrssMX0hvO76qEgUdMcxN5XSyTTrTqctcYREpksj9TptRY14OWQWfnPPCcEf62cArkVlv07i0HwBirEHoyRGlPT0lx7bO4duCA+a+khkt2P8SBNOF6TinFampHBitDYBOLsIMIKFA0I0gotPW4WF8D++dS/Qw/7Mi4+58f8LfzCt5PueyLv1M4RibYBu4rG41aF/I53YsgKFEaTNSuM5vkBmnG3unQE/s+liKXdmTAPtjbIZ++8m4ythVG5wkucP3DApDWCxseIUZOaJ86qQjK2GvuybeQgYtcY5lSofWnNJ6kl0wuL/R6xfUp1P/LN2Mit++Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A9n+7M0nXV9U3YltSpLb8ROaOra0cXgEU7gXaP2uRBk=;
 b=RCDwg4b8DCmUabB/iy2OquD57ZCh/xY2GucXsFXvIA8wUlduap4F8RkGdj8D7wQ0DPH1CUz2W+E/9sVYSqPL4abZNiEIQrWRNG64ZXhPLCBHh0cMr0+79JHzP3T/kAbVPi7eixnC+PBMsF2X6JzfFCkBkiMCSpIR/69uoew+869pR80DCRIYzDG21qt3/72EX6SjIVbPfmHrh40Td3SoKsCzyTZtAym6Amcyykfq5ivT03nMFm9+xW32/DckBpe1ldi/jZqLg1r8Se+3fb8ynuEdwY3haYX8pfPhTHXAz6xIzeZ/q1TKo2oxjyNmTWsi7VpSCekzEpSS987IFLfYjw==
Received: from SJ0PR13CA0128.namprd13.prod.outlook.com (2603:10b6:a03:2c6::13)
 by SA5PPF9D25F0C6D.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8d9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.19; Tue, 29 Sep
 2026 17:34:08 +0000
Received: from BY1PEPF000264B1.namprd02.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::87) by SJ0PR13CA0128.outlook.office365.com
 (2603:10b6:a03:2c6::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.14 via Frontend Transport; Tue,
 29 Sep 2026 17:34:07 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BY1PEPF000264B1.mail.protection.outlook.com (10.167.242.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Tue, 29 Sep 2026 17:34:07 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 29 Sep
 2026 10:33:35 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 29 Sep
 2026 10:33:32 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <alex@shazbot.org>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kbusch@meta.com>, <michal.winiarski@intel.com>,
	<satyanarayana.k.v.p@intel.com>, <sonangp@nvidia.com>, <ankita@nvidia.com>,
	<nathanc@nvidia.com>, <mochs@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [RFC PATCH v2 03/16] vfio/pci: Buffer ROM reads before copying to userspace
Date: Tue, 29 Sep 2026 18:32:52 +0100
Message-ID: <20260929173305.204856-4-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929173305.204856-1-skolothumtho@nvidia.com>
References: <20260929173305.204856-1-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF000264B1:EE_|SA5PPF9D25F0C6D:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b88e950-b5ac-4cea-e867-08df1e4fdd83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|376014|82310400026|23010399003|56012099006|11063799006|10067099003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	cr3ZCSP7FQAJO174IGVnrbpVS6lxRFb1fFuZy5M88Hb+2IT1b+yNVfslCWNaDeVyZkycYYdUYyqQYGdXi6wR0LvHVKHyTyiGxsPzX3VaKc8Tx5EN/6F9MxkklxcxWpadAp8x6rqufGF94B/aBhuYl08EC8en0S8cyNZL6YCFw+YabOLupqVtko53hyINP0/HLkXBQDaEevO6PJCSbM9MmapmTsy8+y4pZ6pN89VdMf2BmmgCrFrQlOnYU03HICi+cgD9YWTIz+kIRijEiOg3OzTu+LxfgONU1lKeZiC+GSK4qXy4GNoWUI+oPa6QDEGXxdU/hP+945UGZNJ3G9Sn7WDONYXuFSG0ahbNTXz+q61uoDDCSifxrcC4TokKnI31iWxErIwDsTNPfAGwapf48P2TWQtA1O9kH8Y2TzzeGNiptRdVjZV6d2LI+1DhSgclJcWpNhY1fdNSUsIKivHZGELps+SRpRPir4ViTMHxzmQS7S92jq7u6pa0QBPXOZicNNWHsOZrWMrSZJJWZdxcGeVnvksLLCO87ex6yZ4vYnkZrkny+Sm5I/4B5CS2y6pb3nAaDwJNvvcTruSFjPXUl422DKfgptjcJXduERO46V6t8zmVPcH0T2qGBncJ6AZBCQmcpdMUVU6yYywVZuQBUfvM0y1I1Kql17zzqXU31W6GG1gcbcOvjqtSrb2O3GHfCd10VFNArW6XGBuirIQinA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(23010399003)(56012099006)(11063799006)(10067099003)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4Q+CW+rqic09vxxAw6LF8qn1QdhDs7v55QpCblt6Phcmt9YgUYHcvMJroWVcjdqwxUw2bxe9JtO/gMUdW1pcNyOKX5UCTXjMhnmgs+KRWgv8s9NORGFifEb3iN2OXUZo++APN6jInkXNZkZZYyYhsOexcUt9hjv7HZtZgg00ojwk59zJUgyGgHzCr1FBT6iq+5kdvL0tXc5UgyLPklPuNvNyyvmCm9W026qRA/eobm/lPDuCw9+2s/xD4y2egz8Efg9JYW6B8FwtXLeCUlTdsJW0MZ8Iel+LkXco9Ub0kBtYCE0vZ1ajfRePwek5GwuyuywRFvErXLTqAKsKUQUMdPS1KHePoWbdZlQqn6LCcfShvA/3lz5/JnGODv3V4yeW+FzLUeur2Kdwx1AevaedraugBSGqnYK8leZulx3jM0lQ/EnFTsbvWKaKK3JXiLUt
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 17:34:07.6290
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b88e950-b5ac-4cea-e867-08df1e4fdd83
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF000264B1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF9D25F0C6D

Move ROM reads into a separate helper because vfio_pci_core_do_io_rw()
copies directly to userspace. Buffer the requested ROM data and unmap
the ROM before copying it to userspace.

The next patch adds recovery gating around ROM mapping, reading and
unmapping. Buffering keeps userspace faults outside that gate, so they
cannot stall recovery or leave ROM reads to resume after recovery has
disabled decoding.

Preserve aligned byte, word and dword reads and 0xff padding. The
temporary allocation can fail with -ENOMEM.

Assisted-by: LLM
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 drivers/vfio/pci/vfio_pci_rdwr.c | 147 ++++++++++++++++++++++---------
 1 file changed, 104 insertions(+), 43 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_rdwr.c b/drivers/vfio/pci/vfio_pci_rdwr.c
index 7f14dd46de17..b4f2c9d967dd 100644
--- a/drivers/vfio/pci/vfio_pci_rdwr.c
+++ b/drivers/vfio/pci/vfio_pci_rdwr.c
@@ -10,8 +10,10 @@
  * Author: Tom Lyon, pugs@cisco.com
  */
 
+#include <linux/align.h>
 #include <linux/fs.h>
 #include <linux/pci.h>
+#include <linux/slab.h>
 #include <linux/uaccess.h>
 #include <linux/io.h>
 #include <linux/vfio.h>
@@ -198,6 +200,96 @@ ssize_t vfio_pci_core_do_io_rw(struct vfio_pci_core_device *vdev, bool test_mem,
 }
 EXPORT_SYMBOL_GPL(vfio_pci_core_do_io_rw);
 
+static ssize_t vfio_pci_rom_read(struct vfio_pci_core_device *vdev,
+				 char __user *buf, size_t count, loff_t pos)
+{
+	struct pci_dev *pdev = vdev->pdev;
+	bool rom_bar = pci_resource_start(pdev, PCI_ROM_RESOURCE);
+	size_t size, length = 0, done = 0;
+	void *data = NULL;
+	void __iomem *io;
+	ssize_t ret;
+
+	/* Serialize ROM decoding with power-state and other ROM accesses. */
+	down_write(&vdev->memory_lock);
+	if (rom_bar) {
+		io = pci_map_rom(pdev, &size);
+	} else {
+		io = ioremap(pdev->rom, pdev->romlen);
+		size = pdev->romlen;
+	}
+	if (!io) {
+		ret = -ENOMEM;
+		goto out_unlock;
+	}
+
+	/* Buffer only ROM data, not unused space in a large ROM BAR. */
+	if (pos < size)
+		length = min(count, size - (size_t)pos);
+	if (length) {
+		if ((pci_resource_flags(pdev, PCI_ROM_RESOURCE) & IORESOURCE_MEM) &&
+		    !__vfio_pci_memory_enabled(vdev)) {
+			ret = -EIO;
+			goto out_unmap;
+		}
+		data = kvmalloc(length, GFP_KERNEL_ACCOUNT);
+		if (!data) {
+			ret = -ENOMEM;
+			goto out_unmap;
+		}
+	}
+
+	/*
+	 * Certain devices (e.g. Intel X710) don't support qword
+	 * access to the ROM bar. Otherwise PCI AER errors might be
+	 * triggered.
+	 *
+	 * Disable qword access to the ROM bar universally, which
+	 * worked reliably for years before qword access is enabled.
+	 */
+	while (done < length) {
+		if (length - done >= 4 && IS_ALIGNED(pos + done, 4)) {
+			u32 val = vfio_ioread32(io + pos + done);
+
+			memcpy(data + done, &val, sizeof(val));
+			done += sizeof(val);
+		} else if (length - done >= 2 && IS_ALIGNED(pos + done, 2)) {
+			u16 val = vfio_ioread16(io + pos + done);
+
+			memcpy(data + done, &val, sizeof(val));
+			done += sizeof(val);
+		} else {
+			((u8 *)data)[done] = vfio_ioread8(io + pos + done);
+			done++;
+		}
+	}
+	ret = count;
+
+out_unmap:
+	if (rom_bar)
+		pci_unmap_rom(pdev, io);
+	else
+		iounmap(io);
+out_unlock:
+	up_write(&vdev->memory_lock);
+	if (ret < 0)
+		goto out_free;
+
+	if (length && copy_to_user(buf, data, length)) {
+		ret = -EFAULT;
+		goto out_free;
+	}
+	for (done = length; done < count; done++) {
+		if (put_user((u8)0xff, buf + done)) {
+			ret = -EFAULT;
+			break;
+		}
+	}
+out_free:
+	kvfree(data);
+	return ret;
+}
+
 ssize_t vfio_pci_bar_rw(struct vfio_pci_core_device *vdev, char __user *buf,
 			size_t count, loff_t *ppos, bool iswrite)
 {
@@ -209,7 +301,6 @@ ssize_t vfio_pci_bar_rw(struct vfio_pci_core_device *vdev, char __user *buf,
 	void __iomem *io;
 	struct resource *res = &vdev->pdev->resource[bar];
 	ssize_t done;
-	enum vfio_pci_io_width max_width = VFIO_PCI_IO_WIDTH_8;
 
 	if (pci_resource_start(pdev, bar))
 		end = pci_resource_len(pdev, bar);
@@ -224,57 +315,27 @@ ssize_t vfio_pci_bar_rw(struct vfio_pci_core_device *vdev, char __user *buf,
 	count = min(count, (size_t)(end - pos));
 
 	if (bar == PCI_ROM_RESOURCE) {
-		/*
-		 * The ROM can fill less space than the BAR, so we start the
-		 * excluded range at the end of the actual ROM.  This makes
-		 * filling large ROM BARs much faster.
-		 */
-		if (pci_resource_start(pdev, bar)) {
-			io = pci_map_rom(pdev, &x_start);
-		} else {
-			io = ioremap(pdev->rom, pdev->romlen);
-			x_start = pdev->romlen;
-		}
-		if (!io)
-			return -ENOMEM;
-		x_end = end;
-
-		/*
-		 * Certain devices (e.g. Intel X710) don't support qword
-		 * access to the ROM bar. Otherwise PCI AER errors might be
-		 * triggered.
-		 *
-		 * Disable qword access to the ROM bar universally, which
-		 * worked reliably for years before qword access is enabled.
-		 */
-		max_width = VFIO_PCI_IO_WIDTH_4;
+		if (iswrite)
+			return -EINVAL;
+		done = vfio_pci_rom_read(vdev, buf, count, pos);
 	} else {
 		io = vfio_pci_core_get_iomap(vdev, bar);
-		if (IS_ERR(io)) {
-			done = PTR_ERR(io);
-			goto out;
+		if (IS_ERR(io))
+			return PTR_ERR(io);
+
+		if (bar == vdev->msix_bar) {
+			x_start = vdev->msix_offset;
+			x_end = vdev->msix_offset + vdev->msix_size;
 		}
-	}
 
-	if (bar == vdev->msix_bar) {
-		x_start = vdev->msix_offset;
-		x_end = vdev->msix_offset + vdev->msix_size;
+		done = vfio_pci_core_do_io_rw(vdev, res->flags & IORESOURCE_MEM,
+					      io, buf, pos, count, x_start, x_end,
+					      iswrite, VFIO_PCI_IO_WIDTH_8);
 	}
 
-	done = vfio_pci_core_do_io_rw(vdev, res->flags & IORESOURCE_MEM, io, buf, pos,
-				      count, x_start, x_end, iswrite, max_width);
-
 	if (done >= 0)
 		*ppos += done;
 
-	if (bar == PCI_ROM_RESOURCE) {
-		if (pci_resource_start(pdev, bar))
-			pci_unmap_rom(pdev, io);
-		else
-			iounmap(io);
-	}
-
-out:
 	return done;
 }
 
-- 
2.43.0


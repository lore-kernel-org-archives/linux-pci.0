Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.200.62
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794493107;
	b=AOxsZQ77Ea4rzEnyxSuYysoXivn5x8ZIJLiXUaKgI9UlppeNtS6f/cPFxJYqE6hIJ8ru
	 DHeWcSBZnguMXeNaPWuVRwayFNZ2C065ix6xXgBID/H9UHdCt56/pqNc/iwZOlIELLonU
	 lkCDqrE3QXy65BJgstofu6iY2v9EA5Y+djKGDgy6+i5scsscxP435XrIa6gMFsq/GWbUq
	 1amb0Ab+lE8n+VfrtCc6Mn0jfhIu2jWczTTM9wKKeRmc48dqbf7KCqEwJCOlYz8DGk3vZ
	 aFQX1o5VcQzxmMhoJv33Nt3g7xA7c0zAxRhoRCFA0RZwXKM4ucRJ/1Z0rqymwelIdKg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794493107;
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
	bh=5dh+3rD+k5lnSGL9Z0VvVxiZpFB/HkyFLA4PeTBW6SU=;
	b=RurqfSWtLlW+dAuFHLwb/L0CFa7q83/CAqO13uYS+iT/LuhGMmOdt0U0hZip1bucMMqP
	 8AdceELXX4CtiM9XXeOpykTQVV/BAcqEwy3dXIxoIJ1yq0NUF2505pXtOXR+vueZrAkhN
	 GHmmiV8aNXS6U3lS+KWUErN6OAVB5Boy8AmxsSkar5u49QnUZVImmkcRuf0J9Z9RdfCLl
	 RN2EGy/WlHGjPpoEkjFXGtjhgLx3wwwpNGzzKs3zuJlPqWluEO2pxQqbq2zAsQnynOvzA
	 0meS6qTD1VF2uUUOg77If+cb3vkiOHJdWfTodj5scndZOWWneGmsJIkWZlDjgYJq2eQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=E2cS02op;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.200.62
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012062.outbound.protection.outlook.com [40.107.200.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B72606A8BC;
	Thu, 12 Nov 2026 14:18:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16B72606A8BC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=E2cS02op
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QLPdNzwRw2w76WsNGy7v+g9VV6FkUgaidKLq0s9zY5Xvm92mgiDL7O27TB1CUunz3WaVaMdOQ56TUFuBVsyBkt85NTpFlpaYE/tRneKsyc0QM12vgqZX+9JHAwaPKjD+MMQF/gZtNi2grO2GtbcTxFd0+tXshue7c+KqweLBzGF/hAhBCXzZwRS6NBN2JYK+BGgJ7WXMwg/2Fz/63WaCTfNSLwOsrtRX9Aj47Fn3/xnPz1n58d71t8JgM1xIXe4fuCCH3TgIeI55u0zyVxylKZAwl+XFrisWBk99uAs/0yYE9Le1D+NcmcIWXSxbjlK5qocQE8OQuSTn74pgu13eOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5dh+3rD+k5lnSGL9Z0VvVxiZpFB/HkyFLA4PeTBW6SU=;
 b=Wu/59MyQVdQJs9cLPUIxlADnn52P+plvBfhTEo1WheEb3qfEL0+wuGM8vfXlsl7J2XgIpMW3d35U+RiuPs6S3Bp+a+yxCYxNu03EgctySqXPnl0X9AzKZ6XctlLMIicc6JPFn81iOPabKgoAsTxQ1QD/AE/M0aHtZuNWN1ko56TfIGXVL/rmknQsSrCR+bJ9zw8zNy4v3+RxTq3tn8g+xAKF8sErQTUtXdKm/oH8fWPrMiAlvb1qtG1GMlXeTangt5MEd9IiJ0OX4xNMb1qBmSl8TIQrzPk1kbHFFxnRorQ3dxIHJ7/D2XYz27fj9sOFsIcAi6g89Rk4m9xvc2CFpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5dh+3rD+k5lnSGL9Z0VvVxiZpFB/HkyFLA4PeTBW6SU=;
 b=E2cS02opKQMGfrYchLHhypX0YKhiM4wWikmW0CynTizBS+efugA8AlcH18gntgTV68FK+wGsZHpc4hHUkFv/+kbCtNLoBUc9N8dL+kjP+FaGENuADEgy1UNkL3JTTJ9fAR7J9k5OhzUiDdx6Km/lre7UkbTBjHbJGnzSCH1sbkV28+HXWlruWfDWwE/RZFGN6lw75sfN/lmSum1ZCJSz0RZktgZJ9MIVm88OPji6wGWx2DvqCQoVXV07aq8VuqhUgdMZyOoUaZexlms90Q///6qCqDYUed7GJ/ss6brw9mnGMTZ/1iLcnEmPTR/52jOvYLAPP4SeNBGVlknQp6UhlQ==
Received: from PH0PR07CA0021.namprd07.prod.outlook.com (2603:10b6:510:5::26)
 by CH3PR12MB8188.namprd12.prod.outlook.com (2603:10b6:610:120::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Thu, 12 Nov
 2026 14:18:21 +0000
Received: from MWH0EPF000A6735.namprd04.prod.outlook.com
 (2603:10b6:510:5:cafe::80) by PH0PR07CA0021.outlook.office365.com
 (2603:10b6:510:5::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Thu, 12
 Nov 2026 14:18:20 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000A6735.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 12 Nov 2026 14:18:20 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 12 Nov
 2026 06:18:01 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 12 Nov
 2026 06:17:58 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <alex@shazbot.org>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kbusch@meta.com>, <michal.winiarski@intel.com>,
	<satyanarayana.k.v.p@intel.com>, <sonangp@nvidia.com>, <ankita@nvidia.com>,
	<nathanc@nvidia.com>, <mochs@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [RFC PATCH v3 05/20] vfio/pci: Buffer ROM reads before copying to userspace
Date: Thu, 12 Nov 2026 14:16:17 +0000
Message-ID: <20261112141632.918954-6-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6735:EE_|CH3PR12MB8188:EE_
X-MS-Office365-Filtering-Correlation-Id: f812ceef-cf58-43ad-45d2-08df40c7cdf1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|23010399003|18002099003|22082099003|6133799003|261009223027099003|11063799006|56012099006|261028144727099003|261102130727099003|261026121527099003|261102123227099003|261021133027099003|261021135927099003|261026130827099003|261026140227099003|261021121427099003|261022115727099003|261022075727099003|261022113327099003|261022105027099003|261021123027099003|261026135527099003|261021130227099003|10067099003|260925021311599003|260925021911599003|260925022911599003;
X-Microsoft-Antispam-Message-Info:
	NCKS2GxflBfIVt4cU+FxNRnwKXawQryLaiP2qcILP3CxUETrNoOaWht42Ba6z8y7CP8RTyqH0kXtcu2BQUDe8Faaxl4WWJq8cWCJZlF8fzD332BBA2jotZCxxIeumSyrtvjY+Z7U/5c+0SDHOvL0xNYbJLtEvuYJlJTPOSaPMup/tYRe+k7t1Wp4/7LzKnYGlSQP2Memfh1HNzNd5lJ6+aKGZys1XgsPh4n+z6aiE6X6gXemNv/fX3gh0r52zb5s7Ts2EBJbvf9w7yWH//iua1Dri0Plljo2Gs6ru7QMX4vpJpPNnHLlDl69EW9Pdyk0aLwp2Vq9wE5hw0Fh8c+QckTqXs+ofGZcPQt8ZMgtOCnfLfLVFNxMB4+iQ36J8hNjQjV9IjJTNG3Cg4Pc9Ia0lXfmm1/zabWAjaK7KarSGkdGtoaDMtRlCoER+lOjRiN/D9f8U/Qb6emrjSl590fscb0tpDTAFSz4Q7gZAY4ruKo6zsahSTO2/WA/qfVh9tqML4E4KNLCR4EDHAGRGIFWpRGdJukZCtkkSUDCTJDe4Usmn2sujWt3kXULaCmSr3TsHirEeMfxFN6RCmrt3pyzcdPuROOuqANkPPNzdwgEd3b+uzGkwgeqjCptVJRo/HXkW8N5ZAzZQPn+WwftGd6iobUh0WmcMPKMfo971IELpTZZaWFGzHtYngdpFHXfJ2k/kGLtOE7NsnmbZ1ipbN8Ppg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(23010399003)(18002099003)(22082099003)(6133799003)(261009223027099003)(11063799006)(56012099006)(261028144727099003)(261102130727099003)(261026121527099003)(261102123227099003)(261021133027099003)(261021135927099003)(261026130827099003)(261026140227099003)(261021121427099003)(261022115727099003)(261022075727099003)(261022113327099003)(261022105027099003)(261021123027099003)(261026135527099003)(261021130227099003)(10067099003)(260925021311599003)(260925021911599003)(260925022911599003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	6eOEOYbdsaqOM0KWVE1GPTYojizBUigP+NQD5EZJoDzGp6R8cmHrF/oDvMvX3pjWwP/f1Hq8+ULUig8bN5iz7WQgAC0c1EMd6ryUPw8cCYrTy5MxicC9KT4we5Mcu4L6qmTfqNzhQAwnm2fvBUeOGK8wwo/iwrOz3EN73AGiNYT/nqlGNFyLMF8WFTsjNEAbcqTXImfhafI4FqvNKLhy+xx9LHfszS8yDl6SQXVraXrzi+9k5hrTnGkyF3cYA5A5S3VzialCTu9+FdmxtumVwWkfIfpX0PbFLsQsd7iwqS7vYCVKLBDFI3YIglp/0FSFProDP3o3XjHS/3ZOi6GxUmZTTxTaZbwpgJ0Qk7yU8m60OvssGEXQ2J3nwq68/8hfAcj3j2PFvU70lCkau7OLM72jSdfbte78tDhlsLECeD6QMymcVGkW5GAd67BJkdGw
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 14:18:20.6740
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f812ceef-cf58-43ad-45d2-08df40c7cdf1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6735.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8188

ROM reads copy directly to userspace while ROM decoding is enabled.
Putting the whole operation inside SRCU would let a userspace page
fault delay recovery.

Read the requested ROM data into a kernel buffer, then unmap the ROM
before copying to userspace. Hold memory_lock across mapping and reading
to serialize ROM decoding with power changes and other ROM accesses.

Preserve byte, word and dword reads and 0xff padding beyond the ROM.
Subsequent patch adds SRCU protection around the hardware access.

Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 drivers/vfio/pci/vfio_pci_rdwr.c | 147 ++++++++++++++++++++++---------
 1 file changed, 104 insertions(+), 43 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_rdwr.c b/drivers/vfio/pci/vfio_pci_rdwr.c
index df8848087681..10cd091031fe 100644
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
+	/* Protect ROM decoding against concurrent power changes and ROM accesses. */
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


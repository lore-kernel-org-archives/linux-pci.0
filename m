Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013019.outbound.protection.outlook.com [40.93.201.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B293E379EF5;
	Fri, 16 Oct 2026 16:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792167774; cv=fail; b=rdaHh9jTfkBfnU42HwOBLtnazvBsYCiQPLFNsdLp9ymyhGT7iT8qPo/YHp2Tj5XGBrUzDrAfzTplIYL3Blq9hCBQkBYf7D9M4fAfKUg51S4HUyHEOxdZ2ZyhGCPLu4czcHGPJRQEysgDQAhFIzeI7HO0T5l6tDqAK8dkoLFUlc4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792167774; c=relaxed/simple;
	bh=9qhZPePQm7UNV5t2oguYLL0Ju/Rjvy7CfGnORIyoyEE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FZ8jpgo8tFelGj/RYmZj4+5TGAJ+/u5x7Yby9AziuJwHgSBBFeitSKfDmV91l3/s726V6zFfgUVocHh9TRoFCuqHHZuVGQJ2fdwMNCwnrcRLxj4lyKVjR2SbZ6ukGKmbJboh1H7+M97otGj15uo/hsx8WrvHxDCJzuY5aFMz4jk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZfCwGLVn; arc=fail smtp.client-ip=40.93.201.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZfCwGLVn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sol2qJo/iFEtncJQR0gl1orwbu3Ep4IU69ramtem3kndodp/vgh18ndbj+uBu1EClo083cnCcN1ROWvoGxUg1LOiScV/L38nyCzCqfz8gTvnPcY967ddjx7LhwfzsJ0IRlIpP1gmhXDQRSID61VuMVNx4OWtWWDZU3dAA5i94E/ORzjayHtezfRxqQckrKk32mZhjdGh/xL5JnZ2bxEIIz/ubhrGzuXDrg6UPZZ5/wttUgR7JuXEirroL1g2vbf5EJ37ZTlVdppJ1+6VAc2SOSe6lMn/iD4OE6S7V66vRdFzDej97xtomC4AM7Igr9Y2a6C14OXGEjP/e3OwCyEYKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XGLm+kvhDlJrN9UQLEt/TUOiKqUQlYe+H9VVXldPIxA=;
 b=QhBPBTlN5FM8J8bPWVgwPnfKuGwuKCml7wdZzW20okZ5sNIrQPfkojvCuE4ZBS0WAvl/zVFMMv9MdA3u4y12EH1OLkUiCc/6sRofq4zWha/jSsq6L8wpiXOIxTnnzMOpTnYd1ZvEQjOE/+qz9x7jVFvkgYUIG91OOzTFAoznPS7ABHlkvaIv/FrBC3AWcyXMqHRxuF7UlfneN8DDulPtJWxHOe6YRgnzzKWCmr+x1L+TzVUzuFf2aFruh6pUMBp9T2YBZhgxK+7nhn3hBcPGjHxNPc7NEO+UJbkgPDap0sioUx8zMh5zFJDUQQS3ImSA8QjoBYuIzvg9jrhsCBdYiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XGLm+kvhDlJrN9UQLEt/TUOiKqUQlYe+H9VVXldPIxA=;
 b=ZfCwGLVnnpr7uA8lMqBVPgOCo4Mj7zX1z4p+wAQcrkyYVXnhq+Yqd1A7wnUAacyLvoC9PY5as4Ah6ue73LGpxEUoFiCI6+af8keXDYiF8UXTMcEEJwiaB5IVWH7jQJX9hzdnmT6SNH76sju+MGuKC2x/wy61hatNIpeQKyeZ1GPjs2oHbc4n0HMxYeYwDlIYQ2BiTjWqYq0lU0H+BRyxPiB4VDtdEjO64AIRonXi+zyOTRT/E5rvA4/2hSPAU5HEw0gP5NKEkMP5ZU5a6SHz4rXewW/S7umhCmpHaKuVMzMIai7BFmGS/+SFlwtwea9eVrMEOqDVGSBBCyih9vyKig==
Received: from MN2PR03CA0015.namprd03.prod.outlook.com (2603:10b6:208:23a::20)
 by SA1PR12MB7344.namprd12.prod.outlook.com (2603:10b6:806:2b7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Fri, 16 Oct
 2026 16:22:38 +0000
Received: from BN7PEPF000000A4.namprd05.prod.outlook.com
 (2603:10b6:208:23a:cafe::8c) by MN2PR03CA0015.outlook.office365.com
 (2603:10b6:208:23a::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Fri, 16
 Oct 2026 16:22:38 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN7PEPF000000A4.mail.protection.outlook.com (10.167.245.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 16 Oct 2026 16:22:38 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 16 Oct
 2026 09:22:11 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 16 Oct 2026 09:22:02 -0700
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
Subject: [PATCH v6 21/31] vfio/cxl: Expose the HDM memory region to the guest
Date: Fri, 16 Oct 2026 21:48:28 +0530
Message-ID: <20261016161839.2765592-22-mhonap@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN7PEPF000000A4:EE_|SA1PR12MB7344:EE_
X-MS-Office365-Filtering-Correlation-Id: d4bd4e05-b908-4f4b-3c27-08df2ba1b1ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|1800799024|376014|36860700016|23010399003|22082099003|10067099003|18002099003|11063799006|921020|5023799004|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	6iP3UQd+rBPwgfXrjAux5vr4DpOG2ehkN1Iqu71zSCgRSmOcfVB5reZrkUCDvhmHKv1+bw8YFQDlwp2wMojehshXl4pxmUubuBvltiC+GkEGv9TweZKFJBVoUu8eBd+Txa4/MdMABQayh8mInhgrPwxIF8i0kJfRCEVG3zkvFCPaqBpNbv6fZrF8Vfk0PaAza2U0j3paOKgU9xV0x4Dkc6rUBrsHpQ+r6KTZXJRh8F6Mdx0XwWE3nOqJWKahgrullh8QzcICQaUhsOntbdEDCWMYacrot8MO1NE142paMk6Va+83teTm4cOURJEFJs+fnTNDQ20NBGDu3tXK/9RSp3+BmpG8x1ZcUGzbve/5elXhPsfMvzQpYls2vSl/H/2u8HTJQxn+apbZShnpWqxu2pmNyHWnaj9inGHQBojW5+2zu8kTkOh6lKDGuQnsJcIamzG92dFjYdpEJ1epgKy5asGb8jAebn74qmfJTx/C9GQnMZp8J/QrJI5DtyerIjoesTNFDDp9PHsMghKMyN5/5x5+RXUQKFRUs3NCz4Oh1AG1Bj+6zkvxpHg3jG+PL3HEke6UqIx3sh04T7Bp9yODQCUEZ/bG2mrDMozAGRvkzdtxtKXwikjzDKkmTMAFeTT2YsgGpQ84x6+h+Y/Wm5waAq8iwxThi+ghTz7oVoP+5rb/UtnkIEQak0Q2xIjGQAcCkszVjc3GzmJQrkr+0mou80f7BksIk7qD3fnmvSfXpJnDyZG5jFCSW3Yhv9E3KzZz
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(1800799024)(376014)(36860700016)(23010399003)(22082099003)(10067099003)(18002099003)(11063799006)(921020)(5023799004)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	DOviPoyO0lStnfj0C6+coo/t5iZ/dIpvKbPxXogG/EovmUKgwh6CS4d1MFI0U9SFlyE5c6g9wI2pO2mL8ciR/qVWtAlrZlP/0kRh5xDmoEh6/lSlZ8Adm3EmrLx6R5KnvjAzwXegM837iTM4YaL9y6XDxN7P92/no3benb9cHwTGnDbJrDfttv24KGz1BHQohLZTCA3tclqIIsDJ3J70UVffMpJFipopGayvzGO1x0EdUlV+VcAt73omxE+crWPHuJH+nnnKoDBejFl2vKpMFQyeBy1SEpcXaML0gj30i/6WeGAwaOjd6ux45dD9lIN3REVwew7hW9MtRLZ+Xu2QiA39xJdRunUQDmVKDIrmhiIfL5DkV6yzIi4+pnJTIny15tC/3334vgnUTpdFuSw9R9JwKHUg/O8QXRxgoTRwmIJjGsHGrvm0FW0oxebJwreq
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 16:22:38.2862
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4bd4e05-b908-4f4b-3c27-08df2ba1b1ec
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN7PEPF000000A4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7344

From: Manish Honap <mhonap@nvidia.com>

A CXL Type-2 guest maps the device HDM memory to use its coherent
CXL.mem. The HDM memory is a host physical range with no struct page,
so the guest and KVM need a write-back mapping of it.

Register the range as a region under VFIO_REGION_TYPE_PCI_VENDOR_TYPE
with the CXL vendor id rather than a bespoke region type, per open
because vfio-pci-core tears down all dynamic regions on close and on a
failed open. This patch serves read and write on the region fd; mmap
follows.

Own the resolved host physical range exclusively (IORESOURCE_EXCLUSIVE)
so nothing, /dev/mem included, can map a conflicting cacheable alias
that would fault the host once the range is mapped write-back. Release
it in the provider .release op rather than through a devm action on the
PCI device, which could run after vfio-cxl has unloaded. vfio-cxl now
holds the range, so its reset op runs CXL Reset with
pci_cxl_reset_owned().

Host access to the range is safe only while the committed decoder is in
place. Track that in hdm_valid, set at bind once the decoder is verified
committed. Low power loses the decoder, so close the gate in power_down
and restore the decoder with cxl_restore_state_after_pci_reset() in
power_up, reopening the gate on success.

Device memory can stay unavailable for seconds after the decoder is back:
the device clears Memory_Active in DVSEC CXL Range 1 Size Low until the
memory is usable (CXL r4.0 sec 8.1.3.8.2).

At bind, wait up to the Memory_Active_Timeout the device reports for
Memory_Active, since a reset just before the bind also clears it. A device
whose memory then reads active brings it up by itself, and power_up waits
for Memory_Active, up to the same timeout, before it reopens the gate.

A device whose memory stays inactive relies on its driver and is not
waited for.

CXL.mem decode follows the committed decoder and Mem_Enable, not Memory
Space Enable (CXL r4.0 sec 8.2.4.20.2, 8.2.4.20.7 and 8.1.3.2), so the gate
does not check the Command register. Read and write copy through a
page-sized kernel buffer, so memory_lock is never held across a user copy.

Assisted-by: LLM
Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 drivers/vfio/pci/cxl/vfio_cxl_core.c | 285 ++++++++++++++++++++++++++-
 include/uapi/linux/vfio.h            |   4 +
 2 files changed, 279 insertions(+), 10 deletions(-)

diff --git a/drivers/vfio/pci/cxl/vfio_cxl_core.c b/drivers/vfio/pci/cxl/vfio_cxl_core.c
index 052be27bc46f..e6e633902ecd 100644
--- a/drivers/vfio/pci/cxl/vfio_cxl_core.c
+++ b/drivers/vfio/pci/cxl/vfio_cxl_core.c
@@ -5,11 +5,15 @@
  * Copyright (c) 2026 NVIDIA Corporation & Affiliates
  */
 
+#include <linux/bitfield.h>
 #include <linux/cleanup.h>
+#include <linux/delay.h>
+#include <linux/io.h>
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/range.h>
 #include <linux/slab.h>
+#include <linux/uaccess.h>
 #include <linux/vfio_pci_core.h>
 #include <cxl/cxl.h>
 #include <cxl/hdm.h>
@@ -20,13 +24,114 @@
  * @cxlds: CXL device state; kept first for devm_cxl_dev_state_create()
  * @cxlmd: memory device joined to the CXL topology at bind
  * @hpa_range: host physical range of the HDM region
+ * @hpa_res: exclusive reservation of @hpa_range, held for the bind
  * @hdm: copy of the HDM state cached at PCI enumeration, taken at bind
+ * @hdm_valid: true when host CPU access to the HDM range is safe; under memory_lock
+ * @await_mem_active: the device reported its memory active at bind, so wait
+ *	for Memory_Active before host access reopens after a reset or low power
  */
 struct vfio_cxl_state {
 	struct cxl_dev_state cxlds;
 	struct cxl_memdev *cxlmd;
 	struct range hpa_range;
+	struct resource *hpa_res;
 	struct cxl_hdm_info *hdm;
+	bool hdm_valid;
+	bool await_mem_active;
+};
+
+/*
+ * Copy one chunk between the bounce buffer and the HDM range under
+ * memory_lock. The user copy stays outside the lock: a user buffer that is
+ * itself an mmap of this device faults through a handler that takes
+ * memory_lock for read, and a writer queued in between would deadlock the
+ * two readers.
+ */
+static int vfio_cxl_mem_copy(struct vfio_pci_core_device *vdev, void *bounce,
+			     u64 pos, size_t len, bool iswrite)
+{
+	struct vfio_cxl_state *cxl = vdev->cxl;
+	void *mem;
+
+	guard(rwsem_read)(&vdev->memory_lock);
+
+	/*
+	 * Only touch the HDM range with the decoder in a known-good state, or
+	 * a host CPU access aborts as a fatal SError. CXL.mem decode follows
+	 * the committed decoder and Mem_Enable, not Memory Space Enable (CXL
+	 * r4.0 sec 8.2.4.20.2, 8.1.3.2).
+	 */
+	if (!cxl->hdm_valid || !cxl->cxlds.media_ready)
+		return -EIO;
+
+	mem = memremap(cxl->hpa_range.start + pos, len, MEMREMAP_WB);
+	if (!mem)
+		return -ENOMEM;
+	if (iswrite)
+		memcpy(mem, bounce, len);
+	else
+		memcpy(bounce, mem, len);
+	memunmap(mem);
+
+	return 0;
+}
+
+static ssize_t vfio_cxl_mem_rw(struct vfio_pci_core_device *vdev,
+			       char __user *buf, size_t count, loff_t *ppos,
+			       bool iswrite)
+{
+	struct vfio_cxl_state *cxl = vdev->cxl;
+	u64 pos = *ppos & VFIO_PCI_OFFSET_MASK;
+	ssize_t done = 0;
+	void *bounce;
+	int ret = 0;
+
+	if (pos >= range_len(&cxl->hpa_range))
+		return -EINVAL;
+	count = min_t(u64, count, range_len(&cxl->hpa_range) - pos);
+
+	bounce = kmalloc(min_t(size_t, count, PAGE_SIZE), GFP_KERNEL);
+	if (!bounce)
+		return -ENOMEM;
+
+	while (count) {
+		size_t len = min_t(size_t, count, PAGE_SIZE);
+
+		if (iswrite && copy_from_user(bounce, buf + done, len)) {
+			ret = -EFAULT;
+			break;
+		}
+		ret = vfio_cxl_mem_copy(vdev, bounce, pos + done, len, iswrite);
+		if (ret)
+			break;
+		if (!iswrite && copy_to_user(buf + done, bounce, len)) {
+			ret = -EFAULT;
+			break;
+		}
+		done += len;
+		count -= len;
+	}
+	kfree(bounce);
+
+	if (!done)
+		return ret;
+
+	*ppos += done;
+	return done;
+}
+
+/*
+ * The CXL regions carry no per-region state (region->data is the shared,
+ * devm-managed vfio_cxl_state), so releasing a region is a no-op.
+ */
+static void vfio_cxl_region_release(struct vfio_pci_core_device *vdev,
+				    struct vfio_pci_region *region)
+{
+}
+
+static const struct vfio_pci_regops vfio_cxl_mem_regops = {
+	.rw = vfio_cxl_mem_rw,
+	.release = vfio_cxl_region_release,
 };
 
 /*
@@ -94,12 +199,75 @@ vfio_cxl_create_memdev(struct pci_dev *pdev, const struct cxl_hdm_info *hdm,
 	return cxl;
 }
 
+/* CXL r4.0 sec 8.1.3.8.2: Range 1 Size Low Memory_Active_Timeout encodings */
+static const unsigned int vfio_cxl_mem_active_timeout_s[] = { 1, 4, 16, 64, 256 };
+
+/*
+ * Poll Memory_Active in DVSEC CXL Range 1 Size Low (CXL r4.0 sec 8.1.3.8.2)
+ * for up to the Memory_Active_Timeout the device reports, which is stored in
+ * @timeout. Return 0 once it is set, -ETIMEDOUT, or -ENODEV if config space
+ * does not respond.
+ */
+static int vfio_cxl_poll_mem_active(struct pci_dev *pdev, u16 dvsec,
+				    unsigned int *timeout)
+{
+	int pos = dvsec + PCI_DVSEC_CXL_RANGE_SIZE_LOW(0);
+	unsigned long deadline;
+	u32 size_lo;
+
+	if (pci_read_config_dword(pdev, pos, &size_lo) ||
+	    PCI_POSSIBLE_ERROR(size_lo))
+		return -ENODEV;
+
+	*timeout = FIELD_GET(PCI_DVSEC_CXL_MEM_ACTIVE_TIMEOUT, size_lo);
+	*timeout = vfio_cxl_mem_active_timeout_s[min_t(unsigned int, *timeout,
+				ARRAY_SIZE(vfio_cxl_mem_active_timeout_s) - 1)];
+	deadline = jiffies + secs_to_jiffies(*timeout);
+
+	while (!(size_lo & PCI_DVSEC_CXL_MEM_ACTIVE)) {
+		if (time_after(jiffies, deadline))
+			return -ETIMEDOUT;
+		msleep(20);
+		if (pci_read_config_dword(pdev, pos, &size_lo) ||
+		    PCI_POSSIBLE_ERROR(size_lo))
+			return -ENODEV;
+	}
+
+	return 0;
+}
+
+/*
+ * A reset or a return from low power leaves device memory unavailable until
+ * the device sets Memory_Active. That can take seconds after the reset
+ * completes and the decoder is restored, and a host access to the HDM range
+ * before then can abort. Wait for it on a device that brings its memory up
+ * by itself; a device that relies on its driver for that was found at bind
+ * and is not waited for.
+ */
+static int vfio_cxl_await_mem_active(struct vfio_pci_core_device *vdev)
+{
+	struct vfio_cxl_state *cxl = vdev->cxl;
+	unsigned int timeout = 0;
+	int ret;
+
+	if (!cxl->await_mem_active)
+		return 0;
+
+	ret = vfio_cxl_poll_mem_active(vdev->pdev, cxl->hdm->dvsec, &timeout);
+	if (ret == -ETIMEDOUT)
+		pci_err(vdev->pdev, "vfio-cxl: device memory not active after %us\n",
+			timeout);
+	return ret;
+}
+
 static int vfio_cxl_init_device(struct vfio_pci_core_device *vdev)
 {
 	struct pci_dev *pdev = vdev->pdev;
 	struct cxl_hdm_info *hdm __free(kfree) = NULL;
 	struct vfio_cxl_state *cxl;
+	unsigned int timeout = 0;
 	u64 hdm_size;
+	int ret;
 
 	/*
 	 * pdev->hdm is cached at PCI enumeration, before any driver binds, so a
@@ -150,9 +318,44 @@ static int vfio_cxl_init_device(struct vfio_pci_core_device *vdev)
 		devres_release_group(&pdev->dev, NULL);
 		return PTR_ERR(cxl);
 	}
+
+	/*
+	 * Claim the range IORESOURCE_EXCLUSIVE so no conflicting cacheable
+	 * alias can fault the host once it is mapped write-back. Release it
+	 * explicitly in vfio_cxl_release_device() rather than through a devm
+	 * action on pdev->dev: the provider module ref is dropped as soon as
+	 * that .release op returns, so a pdev-devres callback could run after
+	 * vfio-cxl has unloaded and jump into freed module text.
+	 */
+	cxl->hpa_res = request_mem_region_exclusive(cxl->hpa_range.start,
+						    range_len(&cxl->hpa_range),
+						    "vfio-cxl-hdm");
+	if (!cxl->hpa_res) {
+		devres_release_group(&pdev->dev, NULL);
+		return -EBUSY;
+	}
 	devres_close_group(&pdev->dev, NULL);
 
 	cxl->hdm = no_free_ptr(hdm);
+	/*
+	 * Wait for Memory_Active after a reset only on a device that brings its
+	 * memory up by itself; see vfio_cxl_await_mem_active(). Memory_Active
+	 * also reads clear for seconds after a reset, for example one the host
+	 * ran just before this bind, so give the device its Memory_Active_Timeout
+	 * before deciding. A device that relies on its driver times out here
+	 * once.
+	 */
+	ret = vfio_cxl_poll_mem_active(pdev, cxl->hdm->dvsec, &timeout);
+	cxl->await_mem_active = !ret;
+	if (ret == -ETIMEDOUT)
+		pci_info(pdev, "vfio-cxl: device memory not active after %us, left to its driver\n",
+			 timeout);
+	/*
+	 * The decoder decodes a non-empty range, so it is committed, and host
+	 * access to the HDM range is safe. Reset, bus reset and low power
+	 * close this gate until the decoder is restored.
+	 */
+	cxl->hdm_valid = true;
 	vdev->cxl = cxl;
 
 	return 0;
@@ -160,13 +363,40 @@ static int vfio_cxl_init_device(struct vfio_pci_core_device *vdev)
 
 static void vfio_cxl_release_device(struct vfio_pci_core_device *vdev)
 {
-	kfree(vdev->cxl->hdm);
+	struct vfio_cxl_state *cxl = vdev->cxl;
+
+	/*
+	 * Drop the exclusive HDM range claim before vfio_pci_core_cxl_release()
+	 * drops the provider module ref; see vfio_cxl_init_device().
+	 */
+	release_mem_region(cxl->hpa_range.start, range_len(&cxl->hpa_range));
+	kfree(cxl->hdm);
 	vdev->cxl = NULL;
 }
 
+static int vfio_cxl_add_region(struct vfio_pci_core_device *vdev, u32 subtype,
+			       const struct vfio_pci_regops *ops, size_t size,
+			       u32 flags)
+{
+	u32 type = VFIO_REGION_TYPE_PCI_VENDOR_TYPE | PCI_VENDOR_ID_CXL;
+
+	return vfio_pci_core_register_dev_region(vdev, type, subtype, ops,
+						 size, flags, vdev->cxl);
+}
+
 static int vfio_cxl_open_device(struct vfio_pci_core_device *vdev)
 {
-	return 0;
+	struct vfio_cxl_state *cxl = vdev->cxl;
+
+	/*
+	 * vfio-pci-core frees all dynamic regions on close and on a failed
+	 * open, so register them here per open rather than at bind.
+	 */
+	return vfio_cxl_add_region(vdev, VFIO_REGION_SUBTYPE_CXL_MEM,
+				   &vfio_cxl_mem_regops,
+				   range_len(&cxl->hpa_range),
+				   VFIO_REGION_INFO_FLAG_READ |
+				   VFIO_REGION_INFO_FLAG_WRITE);
 }
 
 static void vfio_cxl_close_device(struct vfio_pci_core_device *vdev)
@@ -183,21 +413,54 @@ static int vfio_cxl_reset_done(struct vfio_pci_core_device *vdev)
 }
 
 /*
- * Until vfio-cxl serves the device memory, reset through the PCI core's
- * reset methods, which run CXL Reset ahead of FLR. Restore the PCI state
- * here rather than through pci_reset_function_locked(): its reset_prepare
- * and reset_done callbacks take memory_lock, which the caller already holds.
- * The caller has saved the state, or on close loaded the open-time copy.
+ * vfio-cxl holds the HDM range, so the PCI core's cxl_reset method would
+ * fail to request it. Run the same CXL Reset with that claim.
  */
 static int vfio_cxl_reset(struct vfio_pci_core_device *vdev)
 {
+	/*
+	 * The reset restores PCI state from the saved copy. The caller provides
+	 * it: the try-reset helper saves the current state, and the close path
+	 * keeps the open-time state that vfio_pci_core_disable() loaded.
+	 */
+	return pci_cxl_reset_owned(vdev->pdev, vdev->cxl->hpa_res);
+}
+
+/* Low power loses the committed decoder: close host access until restored. */
+static void vfio_cxl_power_down(struct vfio_pci_core_device *vdev)
+{
+	lockdep_assert_held_write(&vdev->memory_lock);
+
+	vdev->cxl->hdm_valid = false;
+}
+
+static void vfio_cxl_power_up(struct vfio_pci_core_device *vdev)
+{
+	struct vfio_cxl_state *cxl = vdev->cxl;
 	struct pci_dev *pdev = vdev->pdev;
 	int ret;
 
-	ret = __pci_reset_function_locked(pdev);
-	pci_restore_state(pdev);
+	lockdep_assert_held_write(&vdev->memory_lock);
 
-	return ret;
+	/*
+	 * Restore the decoder that low power lost. The restore needs the device
+	 * lock; if it is contended, keep host access closed until a reset
+	 * restores the decoder. The restore refreshes the decoders in cxl->hdm
+	 * from the cache; global and DVSEC control stay as taken at bind, when
+	 * pci_cxl_reset_capable() required HDM decode and Mem_Enable on.
+	 */
+	if (!pci_dev_trylock(pdev))
+		return;
+
+	ret = pci_save_state(pdev);
+	if (!ret)
+		ret = cxl_restore_state_after_pci_reset(pdev, cxl->hdm);
+	pci_dev_unlock(pdev);
+
+	if (ret)
+		pci_warn(pdev, "vfio-cxl: HDM decoder restore failed: %d\n", ret);
+	else if (!vfio_cxl_await_mem_active(vdev))
+		cxl->hdm_valid = true;
 }
 
 static const struct vfio_cxl_ops vfio_cxl_ops = {
@@ -208,6 +471,8 @@ static const struct vfio_cxl_ops vfio_cxl_ops = {
 	.reset_prepare	= vfio_cxl_reset_prepare,
 	.reset_done	= vfio_cxl_reset_done,
 	.reset		= vfio_cxl_reset,
+	.power_down	= vfio_cxl_power_down,
+	.power_up	= vfio_cxl_power_up,
 	.owner		= THIS_MODULE,
 };
 
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index e41437fa17ad..883b51521e6a 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -370,6 +370,10 @@ struct vfio_region_info_cap_type {
  */
 #define VFIO_REGION_SUBTYPE_IBM_NVLINK2_ATSD	(1)
 
+/* CXL Type-2 device (0x1e98) sub-types for VFIO_REGION_TYPE_PCI_VENDOR_TYPE */
+/* CXL.mem HDM region of a Type-2 device, read and write */
+#define VFIO_REGION_SUBTYPE_CXL_MEM		(1)
+
 /* sub-types for VFIO_REGION_TYPE_GFX */
 #define VFIO_REGION_SUBTYPE_GFX_EDID            (1)
 
-- 
2.53.0


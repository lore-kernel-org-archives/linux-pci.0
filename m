Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.69
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795120140;
	b=olY/FdxKlKGcL1d4X6GqhGMOSlx8BVBERWIcyM5Ewh/CGNrCRQTnz/+MvKbnuWL5eYfu
	 428IF9vxBdaBN9VUjGsXBgcYo3cYeV8dpYSOhKHGwLdrdwwOECH1zr3u68DpdKlEpBmwW
	 GrmNoxwx7v4a3W2edW3IwbE5yjwDgu8z0Fnx/RfTLtaC2mg2WaLnFHpD7W5DqtuOQPQre
	 Ne8VdvBZakK57BG0K4Nw7V92jd25+NyrUGKErKKcqDrK9qgIg6uyWlGBF6J/xvoxL/1+I
	 gFMMBvjfeSUbqk9ger1dG7/gmAg+mGOrKlc724DJKQHHBlFlsPkiuTPLipXwbBW1agQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795120140;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=HuLxAoy3AJ/vjAhQ76vUAXBYQCMdMow3lb1IKuLXrok=;
	b=mVqWOX1BgR1a+y1wvBmppysZNJBcnpWtKNDT5tTpJ14FGakBmQssVss4KV2RSDkUMtVK
	 2jzRdJK+GH67UT95lYyyxpjUeLYHTDFJUdPgt3SV9hgErah5riRgqzgze3/0tc1m0t3BS
	 aouaMipp4k5BkbXhZlCIZRpSgxPe4uprv64Isz61a7xUKzshd0nzelI/G9jsI3k49hdqI
	 qYpE11oj/6x1ehsdzr94Fhwt/LwD+ol2s9nSixaQVE2XLiWkYyua0PQMA88zz+XSyxI9l
	 JRf2XkKKAVCBGU6qzaV8YjRQnw5N1EeYG8WPUmiHmdKdwMx/h8CdJw0beKNM7zoSHXg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=DK5oRoSt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.69
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011069.outbound.protection.outlook.com [52.101.52.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A6E606A32A;
	Thu, 19 Nov 2026 20:28:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85A6E606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=DK5oRoSt
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pUAZoZ9TRLccUcyxZYpkcznetLGC7dMX0jSURMn5Nvf1hJVOFksHnhcs0OxMC7xKSTqwP8j5sClDWWJCvbUcDmWSptydHs6YnQ+bDX82eZM0PWlGwnMPYYBvGO4A+B2HVI5M2kUAr8wkYjuUVs1dbWAcYt4J9fS0AyvgSAkfwjGn1FKExYtCBpsoTlNA2LixyzMzZMvd9nO61IQmbCzjdIBiTS6oF4YNKPGLySoI5YJE2JpKTA32yH6zojWoOAMVX4GETXYaizrftf6ngQXAzjwjmJh/ulaS1M5XNczTf4Om1Z6v0nQFPVzZNcAfy6Iwp38kgrFNH7F42TYJxKbFFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HuLxAoy3AJ/vjAhQ76vUAXBYQCMdMow3lb1IKuLXrok=;
 b=T+0aHIOpGGNYepDFoCNCX45KngHwGiS0cR15ndIPpLJ+xkyxwtKFnuJ6UK/xXT6sZE1XSz4N52K5AM+4TpWGhXkFO2KYBhOPZQTCJBLgnlE76LxPG1nGCEWOo7oKbOcrn09CXECbaEXqX5AIVnNnpPsKt2F/sBPf38eH/6bw7P+r2nb7PB5uL0cHYYLiTbDKvLiTV/a5AS1yFBuFjXSWTgKOgrkh+PL6R0+DxNpQg+wm5DD73jOKd++y7TX4askOnuhLx6ZOEW+76RdERDjAn3hWxUfXHrffaxrBjUmZ2CsbJVZUB1jYAJ2XTRjFg9Py6A8IZo/jKsXWCvJZvZ4Hrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HuLxAoy3AJ/vjAhQ76vUAXBYQCMdMow3lb1IKuLXrok=;
 b=DK5oRoSt4XOnWeS1+vD0b/CQQ9Fu09WMqx5p9jZZU2UypHudLHtK1eL1c9H4QRyHyELKcNaIRcErp1/8yVrO/aiQOWG6+yNXKTrx5piBzfZbN7znjPk2Hk5/mOkyfTJwcrvgi284p7xPbV9x5r/SYylFZ0xHm6L13fYcCW5+tjM=
Received: from CY5PR22CA0038.namprd22.prod.outlook.com (2603:10b6:930:1d::6)
 by IA1PR12MB8189.namprd12.prod.outlook.com (2603:10b6:208:3f0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 20:28:48 +0000
Received: from CY5PEPF00000E85.namprd05.prod.outlook.com
 (2603:10b6:930:1d:cafe::3e) by CY5PR22CA0038.outlook.office365.com
 (2603:10b6:930:1d::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.10 via Frontend Transport; Thu,
 19 Nov 2026 20:28:48 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY5PEPF00000E85.mail.protection.outlook.com (10.167.247.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 20:28:48 +0000
Received: from weiserver.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 14:28:47 -0600
From: Wei Huang <wei.huang2@amd.com>
To: <dmaengine@vger.kernel.org>
CC: <vkoul@kernel.org>, <Frank.Li@kernel.org>, <shuah@kernel.org>,
	<nathan.lynch@amd.com>, <wei.huang2@amd.com>, <mario.limonciello@amd.com>,
	<Stephen.Bates@amd.com>, <tycho@kernel.org>, <suravee.suthikulpanit@amd.com>,
	<rientjes@google.com>, <John.Kariuki@amd.com>, <jic23@kernel.org>,
	<weixugc@google.com>, <bhelgaas@google.com>, <Shyam.Iyer@dell.com>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: [PATCH v1 25/44] dmaengine: sdxi: add PF and VF device naming
Date: Thu, 19 Nov 2026 14:23:01 -0600
Message-ID: <20261119202321.1734355-26-wei.huang2@amd.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261119202321.1734355-1-wei.huang2@amd.com>
References: <20261119202321.1734355-1-wei.huang2@amd.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PEPF00000E85:EE_|IA1PR12MB8189:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bee13f1-f377-47a6-0da1-08df467bb774
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|7416014|376014|1800799024|23010399003|6133799003|22082099003|18002099003|261009223027099003|11063799006|56012099006|261102123227099003|261026121527099003|261021121427099003|261022113327099003|10067099003|261021123027099003|261022075727099003;
X-Microsoft-Antispam-Message-Info:
	+g9+l1aoRf7Bemq2b+tCmVgLcTpGN0YDjPPXqDqD8r8gTC6fDinSHuHWRnlinLsL765X4c01qrpsY+0theFGK6tDZA/rHUaICsP8ynheaYlXzcxWUcx1bEoxG0NtYMt0ta9FJ43q5SrGVSfQeWsl0DAIJNcr/t0pdqAIPbSa23j9fr17BJkgzHz+30fv1KA3TcQhqAq/ernuoc/Eov25icbFkasXPzKocwv2FS4T7w607D2pg+jIpFfSk5Ni2i6Bb9XYCfCLyakttBsSJFp6LNNSkuNq+IwKQ7++Q3dsZxYuBMAlJXf8QKwjrNTM1tonT1oWLzHvlddlvHT0UJjoqUuDTKzu/bGmDayrueUwpVMMtpjirPCnfFdp9e4pmDhaOHNSvBN3AY9wDST9gcQMl9LT1f02ZB+hn7rCtAukngqT+l0cz7t1IR6peKUI+YAbgBZaEsw4BRdSHRYTf+EIiLIueTR1e9KoMlc3x+jiZpsNshtLINR3NUe983/uu12GntL5SjF7U1VUbhGFkrUN6I6y9udwMu+ikF7p9cwZm/io5hAKx+/NmJ+5cqzyQqZd98JHEliweEAN1ZO8i1DnOFYu7ZKt/vcKW7dnQbNtOszt1l6kFd7SUjZaGBGEceUhVc6DpZR/Fyw5MLBvCRJTW8qpYAmMAb1lH5z9uG/zHzQk2T68pot7U3TO2HEcoC0IhH5vlGYpbEvOw0swx29JZQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(7416014)(376014)(1800799024)(23010399003)(6133799003)(22082099003)(18002099003)(261009223027099003)(11063799006)(56012099006)(261102123227099003)(261026121527099003)(261021121427099003)(261022113327099003)(10067099003)(261021123027099003)(261022075727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	dSs4P1emAd0SzyozfUWmzntBF4awJhLM9AO3FAb7MkZmFq20ItIqBNRziLrre0SlDvXGL7RNmS23D1ubI+RQSaJ8eTJjqHDD9mdV1rCDEBT6eeqcz1setdPk3/GdQzEkeqj1dmhEobKfXcTbK64ULazijHKwYOSqfjWcrIefa+MUq68fJoLS78hZ+CKfRXZNQBt9vaVXgzwGUjeVhhnpdfzIMYZr6e6oTZsVoaoplIU2KDYh9C6bB12b73zT8TYfpMccXI94v+wJkw4i+cWLS2aQPAoOP7/LFVh46CxZTaze2wKPJ/jTk0t62e3/FaQPuY2fjM/FgCzn2jYiKHuTVBTW2q4iF08qI9Y2J77cpznVYql41jSR8oHRIcUQLVDKD/SZ/j+EPoseoEz6zs6OTdn+omrItR/nebFqtyVZoMD10I6rHw1OGi6qqMZHTvbS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 20:28:48.1791
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bee13f1-f377-47a6-0da1-08df467bb774
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY5PEPF00000E85.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8189

Let the PCI transport format character device names after the core
allocates a minor. Physical functions use sdxiN, while SR-IOV virtual
functions inherit the PF minor and use sdxiNvM as device names. Also
defer VF probe until the PF is registered.

Signed-off-by: Wei Huang <wei.huang2@amd.com>
---
 drivers/dma/sdxi/device.c |  1 +
 drivers/dma/sdxi/ioctl.c  | 19 +++++++++++--------
 drivers/dma/sdxi/pci.c    | 29 ++++++++++++++++++++++++++++-
 drivers/dma/sdxi/sdxi.h   | 15 +++++++++++++++
 4 files changed, 55 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/sdxi/device.c b/drivers/dma/sdxi/device.c
index c6b690c39b05..cb7056916c3d 100644
--- a/drivers/dma/sdxi/device.c
+++ b/drivers/dma/sdxi/device.c
@@ -388,6 +388,7 @@ static int sdxi_fn_activate(struct sdxi_dev *sdxi)
 	/* Read capabilities and features. */
 	cap0 = sdxi_read64(sdxi, SDXI_MMIO_CAP0);
 	sdxi->sfunc = FIELD_GET(SDXI_MMIO_CAP0_SFUNC, cap0);
+	sdxi->is_vf = FIELD_GET(SDXI_MMIO_CAP0_VF, cap0);
 	sdxi->db_stride = SZ_4K;
 	sdxi->db_stride *= 1U << FIELD_GET(SDXI_MMIO_CAP0_DB_STRIDE, cap0);
 	if (sdxi->db_stride > sdxi->db_size)
diff --git a/drivers/dma/sdxi/ioctl.c b/drivers/dma/sdxi/ioctl.c
index dbd6a916392d..98bba3a91ca7 100644
--- a/drivers/dma/sdxi/ioctl.c
+++ b/drivers/dma/sdxi/ioctl.c
@@ -8,7 +8,6 @@
 #include <linux/cdev.h>
 #include <linux/bitfield.h>
 #include <linux/capability.h>
-#include <linux/cleanup.h>
 #include <linux/compat.h>
 #include <linux/anon_inodes.h>
 #include <linux/device.h>
@@ -17,6 +16,7 @@
 #include <linux/fs.h>
 #include <linux/idr.h>
 #include <linux/limits.h>
+#include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/minmax.h>
 #include <linux/module.h>
@@ -1067,7 +1067,6 @@ static int sdxi_mmap_live(struct file *file, struct vm_area_struct *vma)
 {
 	struct sdxi_file *sf = file->private_data;
 	struct sdxi_cxt *cxt;
-	struct sdxi_dev *sdxi;
 	u64 allowed_mask;
 	u64 token;
 	u64 type;
@@ -1081,11 +1080,6 @@ static int sdxi_mmap_live(struct file *file, struct vm_area_struct *vma)
 	if (ret)
 		return ret;
 
-	sdxi = sf->process->sdxi;
-	guard(rwsem_read)(&sdxi->state_lock);
-	if (!sdxi->online)
-		return -ENODEV;
-
 	cxt = sf->cxt;
 	if (!cxt || !cxt->id)
 		return -EINVAL;
@@ -1282,6 +1276,7 @@ void sdxi_chardev_exit(void)
 
 int sdxi_chardev_register(struct sdxi_dev *sdxi)
 {
+	char name[32];
 	dev_t devt;
 	int minor;
 	int ret;
@@ -1292,13 +1287,21 @@ int sdxi_chardev_register(struct sdxi_dev *sdxi)
 		return minor;
 
 	sdxi->minor = minor;
+	if (sdxi->bus_ops->chardev_name) {
+		ret = sdxi->bus_ops->chardev_name(sdxi, name, sizeof(name));
+		if (ret < 0)
+			goto free_minor;
+	} else {
+		scnprintf(name, sizeof(name), "sdxi%d", minor);
+	}
+
 	devt = MKDEV(MAJOR(sdxi_devt), minor);
 	sdxi->chardev.devt = devt;
 	sdxi->chardev.class = sdxi_class;
 	sdxi->chardev.parent = sdxi->dev;
 	sdxi->chardev.groups = sdxi_dev_groups;
 	dev_set_drvdata(&sdxi->chardev, sdxi);
-	ret = dev_set_name(&sdxi->chardev, "sdxi%d", minor);
+	ret = dev_set_name(&sdxi->chardev, "%s", name);
 	if (ret)
 		goto free_minor;
 
diff --git a/drivers/dma/sdxi/pci.c b/drivers/dma/sdxi/pci.c
index 52bdaeda08ff..abef318cfd7c 100644
--- a/drivers/dma/sdxi/pci.c
+++ b/drivers/dma/sdxi/pci.c
@@ -11,6 +11,7 @@
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/iomap.h>
+#include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/overflow.h>
@@ -26,6 +27,8 @@ enum sdxi_mmio_bars {
 	SDXI_PCI_BAR_DOORBELL = 2,
 };
 
+static struct pci_driver sdxi_driver;
+
 static struct pci_dev *sdxi_to_pci_dev(const struct sdxi_dev *sdxi)
 {
 	return to_pci_dev(sdxi->dev);
@@ -167,6 +170,29 @@ static int sdxi_pci_mmap_doorbell(struct sdxi_dev *sdxi,
 				  sdxi->db_stride, vma->vm_page_prot);
 }
 
+static int sdxi_pci_chardev_name(struct sdxi_dev *sdxi, char *name,
+				 size_t size)
+{
+	struct pci_dev *pdev = sdxi_to_pci_dev(sdxi);
+	struct sdxi_dev *pf_sdxi;
+	int vf_id;
+
+	if (!pdev->is_virtfn)
+		return scnprintf(name, size, "sdxi%d", sdxi->minor);
+	if (!sdxi->is_vf)
+		return -EINVAL;
+
+	pf_sdxi = pci_iov_get_pf_drvdata(pdev, &sdxi_driver);
+	if (IS_ERR_OR_NULL(pf_sdxi) || pf_sdxi->minor < 0)
+		return -EPROBE_DEFER;
+
+	vf_id = pci_iov_vf_id(pdev);
+	if (vf_id < 0)
+		return vf_id;
+
+	return scnprintf(name, size, "sdxi%dv%d", pf_sdxi->minor, vf_id);
+}
+
 static const struct sdxi_bus_ops sdxi_pci_ops = {
 	.owner = THIS_MODULE,
 	.init = sdxi_pci_init,
@@ -174,6 +200,7 @@ static const struct sdxi_bus_ops sdxi_pci_ops = {
 	.get_irq = sdxi_pci_get_irq,
 	.force_quiesce = sdxi_pci_force_quiesce,
 	.mmap_doorbell = sdxi_pci_mmap_doorbell,
+	.chardev_name = sdxi_pci_chardev_name,
 };
 
 static int sdxi_pci_probe(struct pci_dev *pdev,
@@ -184,8 +211,8 @@ static int sdxi_pci_probe(struct pci_dev *pdev,
 
 static void sdxi_pci_remove(struct pci_dev *pdev)
 {
-	sdxi_unregister(&pdev->dev);
 	pci_disable_sriov(pdev);
+	sdxi_unregister(&pdev->dev);
 }
 
 static const struct pci_device_id sdxi_id_table[] = {
diff --git a/drivers/dma/sdxi/sdxi.h b/drivers/dma/sdxi/sdxi.h
index 062ba4be90ad..93b4eb80358c 100644
--- a/drivers/dma/sdxi/sdxi.h
+++ b/drivers/dma/sdxi/sdxi.h
@@ -81,6 +81,10 @@ struct sdxi_bus_ops {
 	 */
 	int (*mmap_doorbell)(struct sdxi_dev *sdxi, struct sdxi_cxt *cxt,
 			     struct vm_area_struct *vma);
+	/**
+	 * @chardev_name: Format a bus-specific character device name.
+	 */
+	int (*chardev_name)(struct sdxi_dev *sdxi, char *name, size_t size);
 };
 
 struct sdxi_dev {
@@ -137,6 +141,7 @@ struct sdxi_dev {
 	struct cdev cdev;
 	struct device chardev;
 	int minor;
+	bool is_vf;
 	bool atomic_ops_enabled;
 	bool online;
 	struct rw_semaphore state_lock;	/* online state and user operations */
@@ -144,6 +149,16 @@ struct sdxi_dev {
 	const struct sdxi_bus_ops *bus_ops;
 };
 
+static inline struct device *sdxi_to_dev(const struct sdxi_dev *sdxi)
+{
+	return sdxi->dev;
+}
+
+static inline bool sdxi_fn_reports_vf(const struct sdxi_dev *sdxi)
+{
+	return sdxi->is_vf;
+}
+
 static inline bool sdxi_dev_compatible(const struct sdxi_dev *sdxi,
 				       struct sdxi_version version)
 {
-- 
2.56.1


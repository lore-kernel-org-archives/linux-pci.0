Received: from out28-99.mail.aliyun.com (out28-99.mail.aliyun.com [115.124.28.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AE5394493;
	Tue,  7 Apr 2026 08:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775550561; cv=none; b=S97/9Vp1YmQK+1Rxcvm9iC70YYOBVBMEwdUl6p0GOrvC1Aw4l880d6VYljWwEZ+jElHQHB+AEQr4v09aplbYvpABtff28QCVpctbj0DUDyRBm4T34be/W4twZJy9qVSdFrvMNXRUJQOQqNqOfYEcQJzG16oe47iCV0m55Hlo+7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775550561; c=relaxed/simple;
	bh=tKOmSJCKRzDDvI3cVgRc3Qh9AjlKtYmswmCIrXnn5Ck=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Taa5RBiyLpd8caDoOfH3hYD2eCd2BCgF9aXtnzUDx/QcRKuH+1jyns9mUrggY0h6HQfzYcfiEdYxvBOsVc/8mVTNQ307JRegASPMxB6XsG2dKaK/zw10oBWdklFYRPvUC/2iUCPeJL64usSQNMrGI+cIIyf0jVke3bsfNSJ2vJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=115.124.28.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.1027766|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0125103-0.000100357-0.987389;FP=12517315119771303843|2|1|1|0|-1|-1|-1;HT=maildocker-contentspam033040074035;MF=fuhao@open-hieco.net;NM=1;PH=DS;RN=7;RT=7;SR=0;TI=SMTPD_---.h6alull_1775550222;
Received: from higon..(mailfrom:fuhao@open-hieco.net fp:SMTPD_---.h6alull_1775550222 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 07 Apr 2026 16:23:47 +0800
From: Fu Hao <fuhao@open-hieco.net>
To: bhelgaas@google.com,
	perex@perex.cz,
	tiwai@suse.com
Cc: linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Fu Hao <fuhao@open-hieco.net>
Subject: [PATCH v2 6/8] ALSA: hda: Add support for Hygon family 18h model 5h HD-Audio
Date: Tue,  7 Apr 2026 16:24:56 +0800
Message-Id: <d68343d2e840bc2b0d466eb175ec2bc2f952771e.1775548724.git.fuhao@open-hieco.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1775548724.git.fuhao@open-hieco.net>
References: <cover.1775548724.git.fuhao@open-hieco.net>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the new PCI ID 0x1d94 0x14a9 for Hygon family 18h model 5h
HDA controller.

Signed-off-by: Fu Hao <fuhao@open-hieco.net>
---
 include/linux/pci_ids.h       | 1 +
 sound/hda/controllers/intel.c | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 406abf629..19d968017 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2613,6 +2613,7 @@
 #define PCI_VENDOR_ID_ROCKCHIP		0x1d87
 
 #define PCI_VENDOR_ID_HYGON		0x1d94
+#define PCI_DEVICE_ID_HYGON_18H_M05H_HDA	0x14a9
 
 #define PCI_VENDOR_ID_META		0x1d9b
 
diff --git a/sound/hda/controllers/intel.c b/sound/hda/controllers/intel.c
index 3f434994c..eb5d48d90 100644
--- a/sound/hda/controllers/intel.c
+++ b/sound/hda/controllers/intel.c
@@ -241,6 +241,7 @@ enum {
 	AZX_DRIVER_ZHAOXIN,
 	AZX_DRIVER_ZHAOXINHDMI,
 	AZX_DRIVER_LOONGSON,
+	AZX_DRIVER_HYGON,
 	AZX_DRIVER_GENERIC,
 	AZX_NUM_DRIVERS, /* keep this as last entry */
 };
@@ -357,6 +358,7 @@ static const char * const driver_short_names[] = {
 	[AZX_DRIVER_ZHAOXIN] = "HDA Zhaoxin",
 	[AZX_DRIVER_ZHAOXINHDMI] = "HDA Zhaoxin HDMI",
 	[AZX_DRIVER_LOONGSON] = "HDA Loongson",
+	[AZX_DRIVER_HYGON] = "HDA Hygon",
 	[AZX_DRIVER_GENERIC] = "HD-Audio Generic",
 };
 
@@ -2818,6 +2820,9 @@ static const struct pci_device_id azx_ids[] = {
 	  .driver_data = AZX_DRIVER_LOONGSON | AZX_DCAPS_NO_TCSEL },
 	{ PCI_VDEVICE(LOONGSON, PCI_DEVICE_ID_LOONGSON_HDMI),
 	  .driver_data = AZX_DRIVER_LOONGSON | AZX_DCAPS_NO_TCSEL },
+	/* Hygon HDAudio */
+	{ PCI_VDEVICE(HYGON, PCI_DEVICE_ID_HYGON_18H_M05H_HDA),
+	  .driver_data = AZX_DRIVER_HYGON | AZX_DCAPS_POSFIX_LPIB | AZX_DCAPS_NO_MSI },
 	{ 0, }
 };
 MODULE_DEVICE_TABLE(pci, azx_ids);
-- 
2.34.1


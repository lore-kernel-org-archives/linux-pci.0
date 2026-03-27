Received: from out198-41.us.a.mail.aliyun.com (out198-41.us.a.mail.aliyun.com [47.90.198.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3885A3D1701;
	Fri, 27 Mar 2026 08:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774599074; cv=none; b=nGXyXS5OgNLJLcaPK6OzuEo3AKOkMci+oyW9Pk+ZLI8tvTuDrmB2AykIval4DIjFUbM2pbLtj2sof65H6Sm/Xu1lXZAcbPjtBe29Sozk7qGt94GgYJG0cqukoD7zrBpNiwPZGKoLiS//ao/FjfHJ3lSK+iYhemlWAdSvr0gC/WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774599074; c=relaxed/simple;
	bh=tKOmSJCKRzDDvI3cVgRc3Qh9AjlKtYmswmCIrXnn5Ck=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Tb4oal/5nOnjKb41bbCKJteGLGVzOcizgOVO7bA7CdmXkQ20L6Ut3sVsbYQ75E2j6OUN3xBNsXHnLie3GT9TtLshaABojBV9aN2DRf0Hu45+33ptJtTQdIfo5+ymDoVRNFT9M9zMdYCm+jLgzPUDt1IiKx3pVTwDAIlb3DiD94U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=47.90.198.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.1010416|-1;CH=blue;DM=|OVERLOAD|false|;DS=CONTINUE|ham_system_inform|0.0125103-0.000100357-0.987389;FP=12517315085411565475|4|1|1|0|-1|-1|-1;HT=maildocker-contentspam033040074035;MF=fuhao@open-hieco.net;NM=1;PH=DS;RN=7;RT=7;SR=0;TI=SMTPD_---.h.BcTHF_1774599043;
Received: from higon..(mailfrom:fuhao@open-hieco.net fp:SMTPD_---.h.BcTHF_1774599043 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 27 Mar 2026 16:10:50 +0800
From: Fu Hao <fuhao@open-hieco.net>
To: bhelgaas@google.com,
	perex@perex.cz,
	tiwai@suse.com
Cc: linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Fu Hao <fuhao@open-hieco.net>
Subject: [PATCH 6/8] ALSA: hda: Add support for Hygon family 18h model 5h HD-Audio
Date: Fri, 27 Mar 2026 16:10:37 +0800
Message-Id: <341858ca30667a240853a0beccd4009a6348926c.1774595153.git.fuhao@open-hieco.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1774595153.git.fuhao@open-hieco.net>
References: <cover.1774595153.git.fuhao@open-hieco.net>
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


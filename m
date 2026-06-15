Received: from out28-110.mail.aliyun.com (out28-110.mail.aliyun.com [115.124.28.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D98305697;
	Mon, 15 Jun 2026 12:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781526220; cv=none; b=W51rwOVljnP1chN80qlA806AlnvSjoGglrOgSQNBoc7qnrDrSpir+t0NystqFWH8hryovkLPDBEyLCaZ+JvGMM3JEYf4WEdTsHe11/XEbK72V1VeH9AEXmvLY16K+b0uEVLnBOJKknyzr9icpj9Ufx3y9Pj3sjeUOeIlWpUzU1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781526220; c=relaxed/simple;
	bh=jUq58n10ffPch5UdxMI1y36booNx5zGgha10cnvtPVQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QQyMCYji2CiJ43WvCOZr3DKnxx4Gs+wy5gmRdG9kZUnB8HeJwmw5J2PrEYLiTqlq5351x1YMhbt82U2yLA2VX00hmKjJ3Jsm1fdRbHWvJp9oZYxEOMkTckPBin48CMDttmCf+SCkhJJZVWNzYec7db6ALnuS4qWfCqHqOxmuAnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=115.124.28.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.0926656|-1;CH=blue;DM=|OVERLOAD|false|;DS=CONTINUE|ham_system_inform|0.055518-0.000137974-0.944344;FP=13814633304614768555|1|1|1|0|-1|-1|-1;HT=maildocker-contentspam033032062159;MF=fuhao@open-hieco.net;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---.hyoj2y3_1781526206;
Received: from higon..(mailfrom:fuhao@open-hieco.net fp:SMTPD_---.hyoj2y3_1781526206 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 15 Jun 2026 20:23:32 +0800
From: Fu Hao <fuhao@open-hieco.net>
To: bhelgaas@google.com,
	perex@perex.cz,
	tiwai@suse.com
Cc: linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-pci@vger.kernel.org,
	tingyin.duan@gmail.com,
	Fu Hao <fuhao@open-hieco.net>
Subject: [PATCH v3 6/7] ALSA: hda: Add support for Hygon family 18h model 5h HD-Audio
Date: Mon, 15 Jun 2026 20:22:40 +0800
Message-Id: <8b38f2941375553e4246167736c6acb5a541e833.1781523812.git.fuhao@open-hieco.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1781523812.git.fuhao@open-hieco.net>
References: <cover.1781523812.git.fuhao@open-hieco.net>
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
 sound/hda/controllers/intel.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/hda/controllers/intel.c b/sound/hda/controllers/intel.c
index 3f434994c..0c3f72170 100644
--- a/sound/hda/controllers/intel.c
+++ b/sound/hda/controllers/intel.c
@@ -100,6 +100,8 @@ enum {
 #define ATIHDMI_NUM_CAPTURE	0
 #define ATIHDMI_NUM_PLAYBACK	8
 
+/* Hygon HD Audio controller */
+#define PCI_DEVICE_ID_HYGON_18H_M05H_HDA	0x14a9
 
 static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;
 static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;
@@ -241,6 +243,7 @@ enum {
 	AZX_DRIVER_ZHAOXIN,
 	AZX_DRIVER_ZHAOXINHDMI,
 	AZX_DRIVER_LOONGSON,
+	AZX_DRIVER_HYGON,
 	AZX_DRIVER_GENERIC,
 	AZX_NUM_DRIVERS, /* keep this as last entry */
 };
@@ -357,6 +360,7 @@ static const char * const driver_short_names[] = {
 	[AZX_DRIVER_ZHAOXIN] = "HDA Zhaoxin",
 	[AZX_DRIVER_ZHAOXINHDMI] = "HDA Zhaoxin HDMI",
 	[AZX_DRIVER_LOONGSON] = "HDA Loongson",
+	[AZX_DRIVER_HYGON] = "HDA Hygon",
 	[AZX_DRIVER_GENERIC] = "HD-Audio Generic",
 };
 
@@ -2818,6 +2822,9 @@ static const struct pci_device_id azx_ids[] = {
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


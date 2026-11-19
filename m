Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795071288;
	b=FJLiov3kYXqEicUrDSkgFb1m/SRTsIU1x22sbBTwNDDhMzx89gGLOxh7DWEo4pDfI+7d
	 CQcozlU3tTl0LibhWZbA8Qy38AQIO2MK+DpBtRMIj8pvpIubMfxHjgKtiLqJj/T/Tv5Cp
	 sjjjLA0nb+LiC39qp7TZHmVUiZlX9tXRwMbL8qE1H8jwI9Xxi0F98oCooowdMatlD87t5
	 CBoZdc5T7nQBlJYmLQZr3H3pGkUlLLvYzfiQ+syFYAdoUj03yNJEfzbQ9eV3f8cTRRflk
	 7elYlZqhzk131cMRyXi03yVjk6flZ+j2knHit8h/z4vAqmylDmi6F0Hn15YbuTo2/5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795071288;
	h=DMARC-Filter:X-Alimail-AntiSpam:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=CEJsvPTKSLNYwIXzkfkIZqTbfDClCu/W83Hk+T24cAI=;
	b=wSKI62Kv5sBgU3VQToqlwLajZxcuKCbXpnqk2lD3DeM0oZrPCty8M2pWqN8EkQfbVTyb
	 Rt93d47kBHTDYPJF/pmp9TCmUT6RxB1XwH51a5LCiC9vmQfHLYZFDsYuEx0f6TjwcJqOb
	 r7yhEaK6FTv4bvk0AQbBoIOPfPJZejLFRBaJSFXwl5H/tmIowyk7szN+/GDxP6XHpeRJn
	 uFBxMGrPFtwZ1CrKnF53DKGi80clrhV5v2/jkt15lh5Sc49tKm/tO4txO3qAI7An5w7B+
	 4OcqBW6JbfTl4cfjzli4MEKSV0XDS9XXUh6CIuxLjSLWAMMUqoCHCeaI5Rdd7iMEAig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kaihong.com;
	spf=pass smtp.mailfrom=kaihong.com;
	arc=none smtp.remote-ip=115.124.28.146
Received: from out28-146.mail.aliyun.com (out28-146.mail.aliyun.com [115.124.28.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757CB606A324;
	Thu, 19 Nov 2026 06:54:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 757CB606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kaihong.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaihong.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.0671308|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.0124628-0.0039436-0.983594;FP=8826200122172392435|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037033194;MF=wangxiaolei01@kaihong.com;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.k5dp14S_1795071274;
Received: from nj-vm-261.pxvirt.local(mailfrom:wangxiaolei01@kaihong.com fp:SMTPD_---.k5dp14S_1795071274 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 19 Nov 2026 14:54:34 +0800
From: Xiaolei Wang <wangxiaolei01@kaihong.com>
To: bhelgaas@google.com,
	jic23@kernel.org,
	aik@amd.com,
	djbw@kernel.org,
	wangxiaolei01@kaihong.com,
	linus.walleij@linaro.org,
	bartosz.golaszewski@oss.qualcomm.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] PCI/IDE: Destroy host bridge IDAs on release
Date: Thu, 19 Nov 2026 06:54:29 +0000
Message-Id: <20261119065429.1824738-1-wangxiaolei01@kaihong.com>
X-Mailer: git-send-email 2.34.1
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

pci_ide_init_host_bridge() initializes two IDAs embedded in the host
bridge and reserves stream ID 255 in ide_stream_ids_ida, which allocates
an 128-byte IDA chunk.  pci_release_host_bridge_dev(), however, only frees
the resource lists and kfree()s the bridge, leaving both IDAs undestroyed.
The chunk becomes unreferenced once the bridge is gone.

This is observed at boot with CONFIG_DEBUG_KMEMLEAK:

  unreferenced object 0xffff000100d4df00 (size 128):
  comm "kworker/u16:3", pid 52, jiffies 4294892598
  backtrace (crc 6f8346e1):
    kmemleak_alloc+0x34/0x40
    __kmalloc_cache_noprof+0x3c0/0x56c
    ida_alloc_range+0x42c/0x554
    pci_ide_init_host_bridge+0x130/0x170
    pci_alloc_host_bridge+0x16c/0x1e0
    devm_pci_alloc_host_bridge+0x1c/0xb4

The 128 bytes is IDA_CHUNK_SIZE, and the trailing 0x80 in the object hex
dump is bit 63 of bitmap[3], i.e. the reserved stream ID 255.

The leak only exists in builds with CONFIG_PCI_IDE (selected by
CONFIG_PCI_TSM), so it is invisible on kernels without TEE-IO support.
Every host bridge that is freed leaks one chunk: a probe that fails or
defers, and a driver unbind, all go through the same release callback.

Add pci_ide_destroy_host_bridge() to destroy both IDAs and call it from
pci_release_host_bridge_dev() just before kfree(), symmetric with
pci_ide_destroy() which handles struct pci_dev.

Fixes: 079115370d00 ("PCI/IDE: Initialize an ID for all IDE streams")
Signed-off-by: Xiaolei Wang <wangxiaolei01@kaihong.com>
---
 drivers/pci/ide.c   | 6 ++++++
 drivers/pci/pci.h   | 2 ++
 drivers/pci/probe.c | 1 +
 3 files changed, 9 insertions(+)

diff --git a/drivers/pci/ide.c b/drivers/pci/ide.c
index beb67b8fb5c5..c0b64778d1ca 100644
--- a/drivers/pci/ide.c
+++ b/drivers/pci/ide.c
@@ -736,6 +736,12 @@ void pci_ide_init_host_bridge(struct pci_host_bridge *hb)
 	reserve_stream_id(hb, PCI_IDE_RESERVED_STREAM_ID);
 }
 
+void pci_ide_destroy_host_bridge(struct pci_host_bridge *hb)
+{
+	ida_destroy(&hb->ide_stream_ida);
+	ida_destroy(&hb->ide_stream_ids_ida);
+}
+
 static ssize_t available_secure_streams_show(struct device *dev,
 					     struct device_attribute *attr,
 					     char *buf)
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 77efa4c5c960..36af4585a5f7 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -755,11 +755,13 @@ static inline void pci_doe_sysfs_teardown(struct pci_dev *pdev) { }
 #ifdef CONFIG_PCI_IDE
 void pci_ide_init(struct pci_dev *dev);
 void pci_ide_init_host_bridge(struct pci_host_bridge *hb);
+void pci_ide_destroy_host_bridge(struct pci_host_bridge *hb);
 void pci_ide_destroy(struct pci_dev *dev);
 extern const struct attribute_group pci_ide_attr_group;
 #else
 static inline void pci_ide_init(struct pci_dev *dev) { }
 static inline void pci_ide_init_host_bridge(struct pci_host_bridge *hb) { }
+static inline void pci_ide_destroy_host_bridge(struct pci_host_bridge *hb) { }
 static inline void pci_ide_destroy(struct pci_dev *dev) { }
 #endif
 
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 9a178e0e5f7f..e22ceb5f42e7 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -641,6 +641,7 @@ static void pci_release_host_bridge_dev(struct device *dev)
 	if (bridge->domain_nr != PCI_DOMAIN_NR_NOT_SET)
 		pci_bus_release_emul_domain_nr(bridge->domain_nr);
 
+	pci_ide_destroy_host_bridge(bridge);
 	kfree(bridge);
 }
 
-- 
2.34.1


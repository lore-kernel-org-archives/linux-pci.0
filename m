Received: from out28-4.mail.aliyun.com (out28-4.mail.aliyun.com [115.124.28.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E30455606;
	Tue,  1 Sep 2026 07:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788247060; cv=none; b=dvhpU3Y/G1VNOW2Ms1OfTNlhNSJ5YSawqDSZasUM3+ahGgGkoZIheJtPn4bB4HJI97YfREa6SrDE/rdO1cVoFzZcfwFKk7yj0heY2w3PFYuS01R+g586OyPZoefmhfflnx+P5ZxqFMRIwqgszKZYD2CtefcxlqPk92V36dLyje8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788247060; c=relaxed/simple;
	bh=bzYTH4+M3T/zklhRcUkacMj2cPGw/98t9zQ04BhEHBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pmu0+ttkn7dND/VCOWjFcF1nxauNe7y05UJf2QDDHhQx/2HXLQR6cWFrWHiJSMDq+1cH3C6UBOGd6wR6n59RjWZVLO5gzNf37UZXjKtolWfRkLTlpbshqQDbfRFbVS/4pxiysBllhfnHalR4ApQNk2T1pI0eEpo/sOwr7TgxIuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=115.124.28.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.1416918|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0639844-0.000926813-0.935089;FP=18001774820116282811|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037031241;MF=wanglin@open-hieco.net;NM=1;PH=DS;RN=11;RT=11;SR=0;TI=SMTPD_---.j2BhS3u_1788247047;
Received: from localhost.localdomain(mailfrom:wanglin@open-hieco.net fp:SMTPD_---.j2BhS3u_1788247047 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 01 Sep 2026 15:17:27 +0800
From: Lin Wang <wanglin@open-hieco.net>
To: Borislav Petkov <bp@alien8.de>,
	yazen.ghannam@amd.com,
	mario.limonciello@amd.com
Cc: tglx@linutronix.de,
	mingo@redhat.com,
	dave.hansen@linux.intel.com,
	"H. Peter Anvin" <hpa@zytor.com>,
	bhelgaas@google.com,
	x86@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/5] pci_ids: Add Hygon Family 0x18 DF F3/F4 device IDs
Date: Tue,  1 Sep 2026 15:16:56 +0800
Message-ID: <20260901071700.3255382-2-wanglin@open-hieco.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901071700.3255382-1-wanglin@open-hieco.net>
References: <20260901071700.3255382-1-wanglin@open-hieco.net>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hygon Family 0x18 node discovery identifies Data Fabric misc (F3) and
link (F4) functions by PCI ID rather than a fixed PCI slot.

Models 0x04 use 0x1463/0x1464, with 0x1493/0x1494 on the mixed-silicon
variant. Models 0x05 through 0x08 use 0x14b3/0x14b4.

Some IDs have the same numeric values as AMD DF devices. PCI identity
also includes the vendor, so Hygon-prefixed names keep the two vendors'
definitions independent.

Signed-off-by: Lin Wang <wanglin@open-hieco.net>
---
 include/linux/pci_ids.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 63774ae2bf71..d9f3e01033f9 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2615,6 +2615,12 @@
 #define PCI_VENDOR_ID_ROCKCHIP		0x1d87
 
 #define PCI_VENDOR_ID_HYGON		0x1d94
+#define PCI_DEVICE_ID_HYGON_18H_M04H_DF_F3	0x1463
+#define PCI_DEVICE_ID_HYGON_18H_M04H_DF_F4	0x1464
+#define PCI_DEVICE_ID_HYGON_18H_M04H_DF_F3B	0x1493
+#define PCI_DEVICE_ID_HYGON_18H_M04H_DF_F4B	0x1494
+#define PCI_DEVICE_ID_HYGON_18H_M05H_DF_F3	0x14b3
+#define PCI_DEVICE_ID_HYGON_18H_M05H_DF_F4	0x14b4
 
 #define PCI_VENDOR_ID_META		0x1d9b
 
-- 
2.43.0


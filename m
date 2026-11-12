Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794450283;
	b=g3RVwZyi9CM3jpSkr4rzfw1My/K33G+msXpYIsUu/S29PuNiNOxRAexiqVs8iPPxGZlI
	 u1Z4KfomX41xgjb3T9X3fIFNuC/FE5jEMnDU7PqalS0qNAQ7Dw3a4rSV09YCMnGXs9McI
	 nuUfelvtJTaVnwkRc2fPnC3UFFPbQty8jqXRujkVi2JU+6u5Sd/alZYwXujeuyvnPKrld
	 FD4Mbh/wbxxi+l2Xc7cdYPn54tY8qZ1KO3tOxPTJfgWX/niW0t7IxOWL4L98Q+P5qIF/G
	 kBgJde6tSTW/LEGNOBF4HFGAHQBETAHP4SO51LPevQaEz5HuhbayjnwJdaX0WC9IgYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794450283;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=Ets5AMQcRfl5b/NAbc3/Lx4RxTaTcnOjaKk4QHCRuPI=;
	b=tM0RTUS7hIwDjAEOB0Cl4TIqXO+J55pCSvZXsAvorlMsriDoyrn6D/km3npXGruiHeA7
	 2mNQiSq+cFxv8owIF7Ir8HaRNXID4xqGEd5ZAzml2EyIxVUjOnkcbg94vXKr1gpcIHLQS
	 FM/oYAX8l1WltWcRF8Vy9QWrUIrzJDFSP++HHGL7DJV1I3ryE0ZRU+aaT1y+1yisWJAVO
	 P4vsYFShAkq0VQFVXYxYeTM7vCYD4m+C4Wj3DaCDta+UNkFVvQtX4o/AqVzuF3JPmX8xx
	 WV8hQLqo/fbKwbhYom6AVUSAqjqQs+Nx5EdCxLfmtDHQWsmXl5v9eedv9wCxZJxbbkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=OaU9Qdfs;
	arc=none smtp.remote-ip=117.135.210.5
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9978606A338;
	Thu, 12 Nov 2026 02:24:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9978606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=OaU9Qdfs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Et
	s5AMQcRfl5b/NAbc3/Lx4RxTaTcnOjaKk4QHCRuPI=; b=OaU9Qdfsp3cLHhF6tE
	Ga3FEDcQ/n5KuYJPzjDL6lyir56nL81oTXA7MXsyM7CATZ0fIiOHouj80C7iWX2r
	5oP5K/iA1f4bu8qmKqba1IDf8VRECSMMgGa+LiJDxktpSzDe8u7P7FPf2vUiOTM5
	qIgwlOqDlkU6kImJHLRBgbyHg=
Received: from Precision-7960.. (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wDXj+5GI_VqPgXEGg--.53291S4;
	Thu, 12 Nov 2026 10:24:11 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com,
	mani@kernel.org,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	thierry.reding@kernel.org,
	ryder.lee@mediatek.com,
	jonathanh@nvidia.com
Cc: robh@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-tegra@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v3 2/5] PCI: Convert remaining core pcie_link_speed[] users
Date: Thu, 12 Nov 2026 10:24:02 +0800
Message-ID: <20261112022405.1230200-3-18255117159@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261112022405.1230200-1-18255117159@163.com>
References: <20261112022405.1230200-1-18255117159@163.com>
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
X-CM-TRANSID:_____wDXj+5GI_VqPgXEGg--.53291S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7KF47ZFW8Xw1xuF47ury8Xwb_yoW8urW8pa
	y3Cr4Fyr18Jry3Wrs5Z3WDWFyYq3ZIvrWjkrWkWas3XF17ArZxXFyay3yftryFvrZrCry3
	AF1ayrW5Aa17JF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zZg4U5UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC7Avylmr1I0skKwAA37

Convert the remaining direct pcie_link_speed[] accesses in pci-sysfs.c,
the __pcie_update_link_speed() inline helper, and pci_set_bus_speed() in
probe.c to pcie_get_link_speed().  This includes the max_bus_speed
lookup that was missed in v1.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/pci-sysfs.c | 2 +-
 drivers/pci/pci.h       | 2 +-
 drivers/pci/probe.c     | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 6669e9ad5bd3..30db3349a44c 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -234,7 +234,7 @@ static ssize_t current_link_speed_show(struct device *dev,
 	if (err)
 		return -EINVAL;
 
-	speed = pcie_link_speed[linkstat & PCI_EXP_LNKSTA_CLS];
+	speed = pcie_get_link_speed(FIELD_GET(PCI_EXP_LNKSTA_CLS, linkstat));
 
 	return sysfs_emit(buf, "%s\n", pci_speed_string(speed));
 }
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 77efa4c5c960..5441741bc330 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -692,7 +692,7 @@ static inline void __pcie_update_link_speed(struct pci_bus *bus,
 					    enum pcie_link_change_reason reason,
 					    u16 linksta, u16 linksta2)
 {
-	bus->cur_bus_speed = pcie_link_speed[linksta & PCI_EXP_LNKSTA_CLS];
+	bus->cur_bus_speed = pcie_get_link_speed(FIELD_GET(PCI_EXP_LNKSTA_CLS, linksta));
 	bus->flit_mode = (linksta2 & PCI_EXP_LNKSTA2_FLIT) ? 1 : 0;
 
 	trace_pcie_link_event(bus,
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 9a178e0e5f7f..d0283a8158f2 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -924,7 +924,7 @@ static void pci_set_bus_speed(struct pci_bus *bus)
 		u32 linkcap;
 
 		pcie_capability_read_dword(bridge, PCI_EXP_LNKCAP, &linkcap);
-		bus->max_bus_speed = pcie_link_speed[linkcap & PCI_EXP_LNKCAP_SLS];
+		bus->max_bus_speed = pcie_get_link_speed(FIELD_GET(PCI_EXP_LNKCAP_SLS, linkcap));
 
 		pcie_update_link_speed(bus, PCIE_ADD_BUS);
 	}
-- 
2.43.0


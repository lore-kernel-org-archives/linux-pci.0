Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794450282;
	b=hCh/k8WGz1LlduNAoLCIl+C38FsCw/LXP6rMiflQoBzM0FjMqsVK7Y/l/XS5xfENjV7o
	 vm3SExL29VYEmNlO6X+cBpIZEu499/Ga2+QNSA1MFOeV6IUYXZJkal2OXZ7Ck0nxbsNeW
	 LAOtsCfp+09q9DdSGD01xLZNGOf6ZBat21J34hlhxtmuZ6eii03yfQmlAEVyehLYIW2td
	 WC3+lGzGMcHk5C5FpCfu1ywZYsfMc5dopJ/SXLig2QWdqLOddiHm7fRxiNF/nX9nI4l9t
	 o4jGDML2xxDSQDr0TG7uhcgVmDLJ82BVSrZ6sN7UTm5RSG6G2NpIR8N9fIrs5UHhKIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794450282;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=AnX2im8pmpMs7qiMXvCcS0Ur29/euoW9hpHTsNFISCM=;
	b=PUenjLLDwI8MmGPsLB4zAUTMqU0y7rApy1KKSw+qgtV//IY5KB6p6tQwUoHhqR5SdEVR
	 j6LLHRKyRy6tifoL4blbkok8qfjryIWCFtTt7ONlu8imeuEplCXXT2Ab2sMqHEg0DorMV
	 eONq1SUwn8wpr1GUbZgP2VzD6X36I8azpMK6j7fLBHroGdse0lEuTjuxlgEPGvYpbH1Y4
	 RVqS679hcYa9Rr0MVsvMBEX+wXCuadj2e7TpKRb8rtImA/E7TQB/TSVEQxjbrXpmWr689
	 YtmeaTh04oy4vShALull3RaYViydF7ckfMZLBdf9lWNAuPoi1c/Y+IBgEzoulOx+i5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=mJHS8qEp;
	arc=none smtp.remote-ip=220.197.31.4
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E26606A323;
	Thu, 12 Nov 2026 02:24:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94E26606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=mJHS8qEp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=An
	X2im8pmpMs7qiMXvCcS0Ur29/euoW9hpHTsNFISCM=; b=mJHS8qEpQDIZJovxAi
	Hs9jqYVqIHFCHkvYOc6LU5oqRg9T7jWioIIkOBGLE4EfSFdqmuFy6H1H4cjIJqRt
	eL5tQq/fFw6FeMOsg4DZ1V4AWjfao3FaD9LRj9U9ZXzi3DE2GgYl9VaMhuXL7VNi
	iS/2n7JZ4zEuG/Fq+kpXEnq2E=
Received: from Precision-7960.. (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wDXj+5GI_VqPgXEGg--.53291S3;
	Thu, 12 Nov 2026 10:24:10 +0800 (CST)
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
Subject: [PATCH v3 1/5] PCI: Use pcie_get_link_speed() in pci.c
Date: Thu, 12 Nov 2026 10:24:01 +0800
Message-ID: <20261112022405.1230200-2-18255117159@163.com>
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
X-CM-TRANSID:_____wDXj+5GI_VqPgXEGg--.53291S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7uFyDWF1rAryDXryftFWxtFb_yoW8tFWfpa
	y7C3WFyry8J34fWFs5Xa15ur15J3ZxZrWxJrWSka4kWr17trZxXFyFq3y3tr1SyrWDAry5
	A3ZIyrs8uFs7tF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRv385UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC6wrylmr1I0ofjwAA3j

Replace the to_pcie_link_speed() wrapper with pcie_get_link_speed() in
pcie_link_bandwidth_mbps() and pcie_bandwidth_available(), and remove
the now-unused wrapper.  pcie_get_link_speed() performs the same lookup
with bounds checking and is already exported.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/pci.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 7c6f2aba8144..594ee7aa4cad 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6025,11 +6025,6 @@ int pcie_set_mps(struct pci_dev *dev, int mps)
 }
 EXPORT_SYMBOL(pcie_set_mps);
 
-static enum pci_bus_speed to_pcie_link_speed(u16 lnksta)
-{
-	return pcie_link_speed[FIELD_GET(PCI_EXP_LNKSTA_CLS, lnksta)];
-}
-
 /**
  * pcie_link_bandwidth_mbps - get the current bandwidth of a single PCIe link
  * @pdev: PCI device to query
@@ -6041,14 +6036,15 @@ static enum pci_bus_speed to_pcie_link_speed(u16 lnksta)
  */
 int pcie_link_bandwidth_mbps(struct pci_dev *pdev)
 {
-	u16 lnksta;
+	u16 lnksta, lnksta_cls;
 	int speed, err;
 
 	err = pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnksta);
 	if (err)
 		return pcibios_err_to_errno(err);
 
-	speed = pcie_dev_speed_mbps(to_pcie_link_speed(lnksta));
+	lnksta_cls = FIELD_GET(PCI_EXP_LNKSTA_CLS, lnksta);
+	speed = pcie_dev_speed_mbps(pcie_get_link_speed(lnksta_cls));
 	if (speed < 0)
 		return speed;
 
@@ -6074,7 +6070,7 @@ u32 pcie_bandwidth_available(struct pci_dev *dev, struct pci_dev **limiting_dev,
 			     enum pci_bus_speed *speed,
 			     enum pcie_link_width *width)
 {
-	u16 lnksta;
+	u16 lnksta, lnksta_cls;
 	enum pci_bus_speed next_speed;
 	enum pcie_link_width next_width;
 	u32 bw, next_bw;
@@ -6089,7 +6085,8 @@ u32 pcie_bandwidth_available(struct pci_dev *dev, struct pci_dev **limiting_dev,
 	while (dev) {
 		pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
 
-		next_speed = to_pcie_link_speed(lnksta);
+		lnksta_cls = FIELD_GET(PCI_EXP_LNKSTA_CLS, lnksta);
+		next_speed = pcie_get_link_speed(lnksta_cls);
 		next_width = FIELD_GET(PCI_EXP_LNKSTA_NLW, lnksta);
 
 		next_bw = next_width * PCIE_SPEED2MBS_ENC(next_speed);
-- 
2.43.0


Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D2942FB0B2;
	Tue,  1 Sep 2026 08:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.0.225.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788251832; cv=none; b=e15uNFooNXJFS0iv97f4fkV2/nJLFERlrYhFLl+rQvUrwJUL5Fsm8XEZ1clXAi6VZh+nWmxIJgWnjRq/xWzy/DbzH0NEib4525zFDXoKmojM7La/qpSJCAr1Jd9p4t0YjNOTkemjRmAU4tUpywucn+l9XnDL1YdGQGnipC2NdXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788251832; c=relaxed/simple;
	bh=IaEiVJ4fJJFOA0/uc+w68u3gaArNiFflNr1Rhun/a3c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q+osQnixaJRLM8ZcAR6D/5TmkQXenjlygqDcSGS2ApPf0phAjXNUxOuyHDIrodcREHZnOk0eQ8rqPFddTJ5E5DuXQJ6EgD76GEP3oZ0qipjoBlCP/uimYQDFbGaDcZNgwhJvtvhwCVbmqkcMZ84rTHRxTrBCoxf6gn7wnr1xm08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=210.0.225.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
Received: from zhaoxin.com (unknown [127.0.0.1])
	by mx1.zhaoxin.com (MTA) with ESMTP id 4hYzk16hTSzbKVjH;
	Tue,  1 Sep 2026 16:36:57 +0800 (CST)
Received: from zhaoxin.com (unknown [10.28.208.166])
	by mx1.zhaoxin.com (MTA) with ESMTP id 4hYzk01BX6zbKVjF;
	Tue,  1 Sep 2026 16:36:56 +0800 (CST)
Received: from hx007ea1.lan (hx007ea1.lan [10.32.68.48])
	by zhaoxin.com (8.30) with ESMTPd487c254fdf928d2c5926c3eff5a50d9
	Tue, 01 Sep 2026 16:36:56 +0800
X-Eyou-Smtpauth: LeoLiu-oc@zhaoxin.com
X-Eyou-EnvelopeSender: leoliu-oc@zhaoxin.com
X-Eyou-From: LeoLiu-oc <leoliu-oc@zhaoxin.com>
From: "=?UTF-8?B?TGVvTGl1LW9j?=" <leoliu-oc@zhaoxin.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eros Zhang <eroszhang@zhaoxin.com>,
	Cobe Chen <cobechen@zhaoxin.com>,
	"Tony W . Wang" <tonywwang@zhaoxin.com>,
	LeoLiu-oc <leoliu-oc@zhaoxin.com>
Subject: [PATCH] PCI/P2PDMA: Add Zhaoxin host bridges to whitelist
Date: Tue,  1 Sep 2026 16:36:53 +0800
Message-ID: <20260901083653.48890-1-leoliu-oc@zhaoxin.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Eyou-Sender: <leoliu-oc@zhaoxin.com>

Zhaoxin host bridges support peer-to-peer DMA. Add their device IDs
(0x1003, 0x1005-0x1008) to the whitelist so that p2pdma works on these
platforms.

The entries cover the KX-6000, KH-40000, KX-6000G, KX-7000 and KH-50000
families.

The KX-6000/KH-40000/KX-6000G/KX-7000 entries are marked
REQ_SAME_HOST_BRIDGE because P2P requests crossing different host bridges
are not supported on these parts. The KH-50000 entry is whitelisted
without this restriction.

Signed-off-by: LeoLiu-oc <leoliu-oc@zhaoxin.com>
---
 drivers/pci/p2pdma.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 9334eb314663..9fbbf1692f0e 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -569,6 +569,12 @@ static const struct pci_p2pdma_whitelist_entry {
 	{PCI_VENDOR_ID_NVIDIA, 0x2f96, 0},
 	{PCI_VENDOR_ID_NVIDIA, 0x2f97, 0},
 	{PCI_VENDOR_ID_NVIDIA, 0x2f98, 0},
+	/* Zhaoxin KX-6000/KH-40000/KX-6000G/KX-7000/KH-50000 */
+	{PCI_VENDOR_ID_ZHAOXIN, 0x1003, REQ_SAME_HOST_BRIDGE},
+	{PCI_VENDOR_ID_ZHAOXIN, 0x1005, REQ_SAME_HOST_BRIDGE},
+	{PCI_VENDOR_ID_ZHAOXIN, 0x1006, REQ_SAME_HOST_BRIDGE},
+	{PCI_VENDOR_ID_ZHAOXIN, 0x1007, REQ_SAME_HOST_BRIDGE},
+	{PCI_VENDOR_ID_ZHAOXIN, 0x1008, 0},
 	{}
 };
 
-- 
2.43.0



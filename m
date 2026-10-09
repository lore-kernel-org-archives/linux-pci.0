Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4C04D9F8B;
	Fri,  9 Oct 2026 12:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791550187; cv=none; b=Rp2dzsBmy3Bm8PKrmoe+9HR0ZVi+nDG7bAWGjsy1VbG6vbds5yPPtvXZKanmng5Hlws4MpWAxr9TBKnC0g5i9ZvgNuEqRQ2o61l/tpheP5ZTPSfF81Up7FvtPsV4xNzMo5o9sNyv2E04FIopJOHddnFV6KKCTu4W+iVGp807Hm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791550187; c=relaxed/simple;
	bh=PWy/lZojVFBYeSlUhV+/KbO4a+k0JcLdRi6ih5gucQ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=REdUduK2SdWMcf6qDcKPYDWqZEvSD5lB438PQ9uX91mPmsJhiCPVYM5qBUYz/qkXKXnWrlLtd2XHXKDJSV7AnrFePH7CY83RX+NT/BP9gQMzxEYuQJse8UYpvbNGvC+BZnr9GLL67OQjr21Z7J05fkP3/C5tCR1B99cC2QxankI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D88BB1A02FA;
	Fri,  9 Oct 2026 14:40:42 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id CC2601A0002;
	Fri,  9 Oct 2026 14:40:42 +0200 (CEST)
Received: from lsv15141.swis.ro-buh01.nxp.com (lsv15141.swis.ro-buh01.nxp.com [10.162.246.138])
	by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 7FD772037D;
	Fri,  9 Oct 2026 14:40:41 +0200 (CEST)
From: Claudiu Manoil <claudiu.manoil@nxp.com>
To: netdev@vger.kernel.org
Cc: s32@nxp.com,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v1 5/5] PCI: Create OF node for NXP ENETC pseudo-MAC functions
Date: Fri,  9 Oct 2026 15:40:34 +0300
Message-Id: <2706e800774bb7e72992a8cc9d17ce7be039f046.1791548316.git.claudiu.manoil@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1791548316.git.claudiu.manoil@nxp.com>
References: <cover.1791548316.git.claudiu.manoil@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP

NXP ENETCv4 pseudo-MAC (PPM) ports can be probed as pure PCI endpoints,
without any "ethernet" node in the static device tree. The ENETC4 driver
describes their fixed link by applying a device-tree overlay onto the PCI
function's own OF node, which requires that node to exist.

Request the PCI core to synthesize a per-function OF node for these
devices by registering of_pci_make_dev_node() as a final fixup, following
the existing precedent for the Xilinx, Red Hat and EFAR devices. The
helper is a no-op when the function already has a static OF node, so this
has no effect on platforms that describe ENETC via static DT. It only
takes effect when CONFIG_PCI_DYNAMIC_OF_NODES is enabled.

Both ENETC4 PCI device IDs are covered (0xe101 and 0xe110), since either
can be instantiated as a pseudo-MAC port on S32N79.

Signed-off-by: Claudiu Manoil <claudiu.manoil@nxp.com>
---
 drivers/pci/quirks.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index de9bbccda21f..86f0a182224b 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -6391,6 +6391,8 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_XILINX, 0x5020, of_pci_make_dev_node);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_XILINX, 0x5021, of_pci_make_dev_node);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_REDHAT, 0x0005, of_pci_make_dev_node);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_EFAR, 0x9660, of_pci_make_dev_node);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_PHILIPS, 0xe101, of_pci_make_dev_node);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_PHILIPS, 0xe110, of_pci_make_dev_node);
 
 /*
  * Devices known to require a longer delay before first config space access
-- 
2.34.1


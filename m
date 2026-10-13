Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D4D522695;
	Tue, 13 Oct 2026 17:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791911579; cv=none; b=CMoKO3AzGcKNm+ezuzgO6YhjwvhTgwQw2HBY2a3CwIQWDtclA1eCq3lvVTDPzZLRxvcu1MxM47RCQB8BWOMPaQg2f7XNzuLXKw0nIOGKFYEJR/3hCaWU4sbkaEvFUCHgEjNy8QKw3jVZE6bp8r8SLKWbT+3RllVFZ7at8q7Wyfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791911579; c=relaxed/simple;
	bh=U85hryVUU/XhTLjF5q37oLZoPkAZBp+2bYhxh1LVKrA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rvbkU59oQHhhSLcSJ1JzhxrCm1OPK1OJRtyWupVmM0AfzZwLWg7czW7KJmBSTdiJKMNY3zGFXC4IVZvpreLRbFhF/YdCa/k5O5WpSnGL7Sw425WQ/9QvO4U0iGVhrGmgjlsi+h4ksk7Nfd8JxfcKnIbx/q6CgQcYePV77QaZ6D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 36972200220;
	Tue, 13 Oct 2026 19:12:56 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 2A6802000E4;
	Tue, 13 Oct 2026 19:12:56 +0200 (CEST)
Received: from lsv15141.swis.ro-buh01.nxp.com (lsv15141.swis.ro-buh01.nxp.com [10.162.246.138])
	by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 6A14D202DA;
	Tue, 13 Oct 2026 19:12:55 +0200 (CEST)
From: Claudiu Manoil <claudiu.manoil@nxp.com>
To: netdev@vger.kernel.org
Cc: s32@nxp.com,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org
Subject: [PATCH net-next v2 5/5] PCI: Create OF node for NXP ENETC pseudo-MAC functions
Date: Tue, 13 Oct 2026 20:12:49 +0300
Message-Id: <2a24aaa96c6a0204e3ff293f2a1d22b58cf2171f.1791908694.git.claudiu.manoil@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1791908694.git.claudiu.manoil@nxp.com>
References: <cover.1791908694.git.claudiu.manoil@nxp.com>
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
describes their fixed link by attaching a fixed-link node to the PCI
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
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
v2:
 - none (reworded the overlay reference to match patch 1's fixed-link
   approach; no functional change)

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


Received: from pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.245.243.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600E7399011;
	Fri, 11 Sep 2026 12:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.245.243.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789129698; cv=none; b=f3MigWoHw5/qgIXFSJxBEqkwoN1Byym4EW3+sWj8QxuWADW6wGLDG3KH0fcflN8soZ+0J/iYmCMnCLrQrdkv76yWYORw35BUDHUBc9lLvGQW8BF0z/YAqD7qmdaPYph3w1oy/FnLNKrwp7QwtiTX5tYaqual9A/swgPUailIZZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789129698; c=relaxed/simple;
	bh=vB1R5io1mWpCtA2MMP4ZynnoMjna9AplOnQoqTrLewA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OkAgp+Gk9jFHULdTCmM67A8NuhSo+OwtDDWYF8NEIYr3K7zKIo4E7+RsagxvMzK7JDRSv+taP5OM9TUYysLmTIuZzSnAmC5oMJu26yy7U+yAEvrFx2p5Vj6YyIquQKMGQIqKOX6ctjgC4zHbAWqBX84EXQMmOGf4UfmNIZFfapA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=DROsCDPb; arc=none smtp.client-ip=44.245.243.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="DROsCDPb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1789129697; x=1820665697;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Rdyf/8Ttgw33V+vNGIFbMELJ7FZ26Y0HGkd+2ks6jXI=;
  b=DROsCDPbb6zRgPvpG1IbQdRNz9ca4GDGqyZ5rBRSoielI/LX5XVrA9Kt
   Fgy1Q7qGcKYD9fO/XxdOrZ9rjiCF7k7Nnf9MhuuatK+lD+52h2vBdid5S
   xJe03O+A4iEc8dXhjyc0IXfDw7Xxx5y3Moo9KYbgZaO8hQYCvXNr08LCN
   TPZa95BkiGkddRp4KCZdc94T2F501MGnefKxDOr3kXV5AHM4Uq98Hy+rA
   AFBuIowuN/TXPZYyKg6afPDVYpeTfqDRKNCORP1SggONHyo9jNk0PUksj
   FNUkng5T4KzRUw7+O2ddyabq6wn/tMLW9C20Pxbg4Qvd/Qsf6g180yDJi
   w==;
X-CSE-ConnectionGUID: qGcm9O6eS2WTX6u9iGMBPg==
X-CSE-MsgGUID: JxZKmnZMSe6zlBWCIJeRvw==
X-IronPort-AV: E=Sophos;i="6.27,97,1787011200"; 
   d="scan'208";a="27923845"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 12:28:14 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.48:6057]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.4.34:2525] with esmtp (Farcaster)
 id b9a7c6f5-244d-4b45-b807-db7ef58f2f97; Fri, 11 Sep 2026 12:28:14 +0000 (UTC)
X-Farcaster-Flow-ID: b9a7c6f5-244d-4b45-b807-db7ef58f2f97
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Fri, 11 Sep 2026 12:28:14 +0000
Received: from dev-dsk-sakacpav-1a-480d1124.eu-west-1.amazon.com
 (172.19.96.155) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.46; Fri, 11 Sep 2026
 12:28:11 +0000
From: Pavol Sakac <sakacpav@amazon.de>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>, David Matlack
	<dmatlack@google.com>, =?UTF-8?q?Ilpo=20J=C3=A4rvinen?=
	<ilpo.jarvinen@linux.intel.com>, =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?=
	<kwilczynski@kernel.org>, Kees Cook <kees@kernel.org>, Madhavan Srinivasan
	<maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin
	<npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>, Niklas Schnelle <schnelle@linux.ibm.com>,
	Benjamin Block <bblock@linux.ibm.com>, Lukas Wunner <lukas@wunner.de>, "Ionut
 Nechita" <ionut.nechita@windriver.com>, <nh-open-source@amazon.com>
Subject: [RFC PATCH 1/8] PCI/IOV: Split virtfn bus handling out of pci_iov_add_virtfn()
Date: Fri, 11 Sep 2026 14:28:04 +0200
Message-ID: <20260911122804.80063-1-sakacpav@amazon.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260911-vfopt-s1-v1-0-693271dc0226@amazon.de>
References: <20260911-vfopt-s1-v1-0-693271dc0226@amazon.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D032UWA004.ant.amazon.com (10.13.139.56) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

pci_iov_add_virtfn() creates the virtfn bus, scans and registers the VF,
and removes the bus again on failure. A later commit creates all virtfn
buses up front, so separate the bus-lifetime concern from the VF-add
concern: move the VF add into a new __pci_iov_add_virtfn() taking the bus
as an argument, and keep bus creation and on-failure bus removal in the
public wrapper.

No functional change intended.

Assisted-by: LLM
Signed-off-by: Pavol Sakac <sakacpav@amazon.de>
---
 drivers/pci/iov.c | 35 ++++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 9d408fb8ac25..1826d32a2364 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -343,25 +343,17 @@ static struct pci_dev *pci_iov_scan_device(struct pci_dev *dev, int id,
 	return virtfn;
 }
 
-int pci_iov_add_virtfn(struct pci_dev *dev, int id)
+static int __pci_iov_add_virtfn(struct pci_dev *dev, struct pci_bus *bus,
+				int id)
 {
-	struct pci_bus *bus;
 	struct pci_dev *virtfn;
 	struct resource *res;
 	int rc, i;
 	u64 size;
 
-	bus = virtfn_add_bus(dev->bus, pci_iov_virtfn_bus(dev, id));
-	if (!bus) {
-		rc = -ENOMEM;
-		goto failed;
-	}
-
 	virtfn = pci_iov_scan_device(dev, id, bus);
-	if (IS_ERR(virtfn)) {
-		rc = PTR_ERR(virtfn);
-		goto failed0;
-	}
+	if (IS_ERR(virtfn))
+		return PTR_ERR(virtfn);
 
 	virtfn->dev.parent = dev->dev.parent;
 	virtfn->multifunction = 0;
@@ -393,9 +385,22 @@ int pci_iov_add_virtfn(struct pci_dev *dev, int id)
 failed1:
 	pci_stop_and_remove_bus_device(virtfn);
 	pci_dev_put(dev);
-failed0:
-	virtfn_remove_bus(dev->bus, bus);
-failed:
+
+	return rc;
+}
+
+int pci_iov_add_virtfn(struct pci_dev *dev, int id)
+{
+	struct pci_bus *bus;
+	int rc;
+
+	bus = virtfn_add_bus(dev->bus, pci_iov_virtfn_bus(dev, id));
+	if (!bus)
+		return -ENOMEM;
+
+	rc = __pci_iov_add_virtfn(dev, bus, id);
+	if (rc)
+		virtfn_remove_bus(dev->bus, bus);
 
 	return rc;
 }
-- 
2.47.3


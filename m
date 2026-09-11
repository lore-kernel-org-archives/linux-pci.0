Received: from pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.83.148.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDD64718FA;
	Fri, 11 Sep 2026 12:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.83.148.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789129753; cv=none; b=G65IbW39pH40fwqKKx8dwVPuhUMnuGceAslhdnDgDPxnJdL5uctHmi2Kq7ohbBSTsKzcQgt6+s4tS5CfFsRdDT3HIu0CcWICUsLTFcuXmlCXiYdhCjXcQr8nW8e4Wdo3GtHQLWMkCId3A82fKCKLmczScJ08TZ3GfzCwwwklXbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789129753; c=relaxed/simple;
	bh=piyOoOK1B1tp5A8gBr1tP1kJIJ7R+ZagJMPXY7S3P28=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i2ag9zrtP94BDscs/Iv6OJ3nfEUTkNOiYrZKm03A7YUogvFycdPsEcvQel2tuGvE9qIsDCHC1VSi28uUvH/d5LD6OLu1s2WH1B4tAXwGoPPBrCPpbjXJFD03FwGRmjVNFXqHxhDFC8FBiN4cfEw/Rw9ERG4bK1x7AD5P6Xh+OcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=s1ZiMLSb; arc=none smtp.client-ip=35.83.148.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="s1ZiMLSb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1789129751; x=1820665751;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=f0dNMrQX9nlSUWSHEteekI596QsuKLoL7NzPMKWWv2s=;
  b=s1ZiMLSbMycrQ0/EwEk/6E+WVrzP3s5/Gm31LXsApDh3fzC6DY9GRkUR
   fJjNevMCsE63js/128qU9WVVADCOs+tZuqaZDZs7WCnBrxTDHO/GoAx5h
   1kObmYZL4UZwtUWYoVJzm8fy37ZA21Eqnf0rMRoMYgQynxFZzfPypuGx9
   z5igVv1Z/CAj17jdgd1hPsiAYZmtBTn4MHZUhnDb0O2/a80aW6uThGqYj
   m73wG2GZPHricHnpQBAhz3/ft7N8rUAiBUke2Luk9QQejBEAK/gPrnxdp
   vvoTTeVrns8PLXfY9yl0s+hHjB+a2M83RqSA4q7u2YNfJONsDdpaecrO5
   A==;
X-CSE-ConnectionGUID: wIn58uYPQ96TRm2APJ38+g==
X-CSE-MsgGUID: rUD9oqXSTHOsAxr+5f17IQ==
X-IronPort-AV: E=Sophos;i="6.27,97,1787011200"; 
   d="scan'208";a="28215968"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 12:29:09 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.178:12471]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.37.160:2525] with esmtp (Farcaster)
 id 2742a140-836f-44a1-bad7-d2f5f8a45c98; Fri, 11 Sep 2026 12:29:08 +0000 (UTC)
X-Farcaster-Flow-ID: 2742a140-836f-44a1-bad7-d2f5f8a45c98
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Fri, 11 Sep 2026 12:29:08 +0000
Received: from dev-dsk-sakacpav-1a-480d1124.eu-west-1.amazon.com
 (172.19.96.155) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.46; Fri, 11 Sep 2026
 12:29:05 +0000
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
Subject: [RFC PATCH 2/8] PCI/IOV: Create virtfn buses up front in sriov_add_vfs()
Date: Fri, 11 Sep 2026 14:29:04 +0200
Message-ID: <20260911122904.85386-1-sakacpav@amazon.de>
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
X-ClientProxiedBy: EX19D035UWA004.ant.amazon.com (10.13.139.109) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

virtfn_add_bus() is find-then-create and therefore assumes external
serialization. Create every virtfn bus before adding any VF, taking the
bus-create path out of the per-VF loop so a later commit can run the
per-VF adds concurrently against a stable bus set. Bus numbers are
already fixed before the loop, since pci_iov_set_numvfs() has latched
offset and stride.

The cleanup pass must remove only buses this enable created, because
virtfn_remove_bus() checks that a bus is empty rather than who created
it, so virtfn_add_bus() now reports whether it created the bus and
sriov_add_vfs() records that per VF id in a bitmap. Return early for
num_vfs == 0: kvcalloc(0, ...) returns ZERO_SIZE_PTR and a later commit
dereferences buses[0] unconditionally.

Several ids can share one bus number; only the creating id's bit is set.

Assisted-by: LLM
Signed-off-by: Pavol Sakac <sakacpav@amazon.de>
---
 drivers/pci/iov.c | 60 +++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 56 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 1826d32a2364..dda9303516f5 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/bitmap.h>
 #include <linux/bits.h>
 #include <linux/log2.h>
 #include <linux/pci.h>
@@ -124,10 +125,14 @@ static int compute_max_vf_buses(struct pci_dev *dev)
 	return rc;
 }
 
-static struct pci_bus *virtfn_add_bus(struct pci_bus *bus, int busnr)
+static struct pci_bus *virtfn_add_bus(struct pci_bus *bus, int busnr,
+				      bool *created)
 {
 	struct pci_bus *child;
 
+	if (created)
+		*created = false;
+
 	if (bus->number == busnr)
 		return bus;
 
@@ -140,6 +145,8 @@ static struct pci_bus *virtfn_add_bus(struct pci_bus *bus, int busnr)
 		return NULL;
 
 	pci_bus_insert_busn_res(child, busnr, busnr);
+	if (created)
+		*created = true;
 
 	return child;
 }
@@ -394,7 +401,7 @@ int pci_iov_add_virtfn(struct pci_dev *dev, int id)
 	struct pci_bus *bus;
 	int rc;
 
-	bus = virtfn_add_bus(dev->bus, pci_iov_virtfn_bus(dev, id));
+	bus = virtfn_add_bus(dev->bus, pci_iov_virtfn_bus(dev, id), NULL);
 	if (!bus)
 		return -ENOMEM;
 
@@ -632,22 +639,67 @@ int __weak pcibios_sriov_disable(struct pci_dev *pdev)
 
 static int sriov_add_vfs(struct pci_dev *dev, u16 num_vfs)
 {
+	unsigned long *created_buses;
+	struct pci_bus **buses;
+	struct pci_bus *bus;
 	unsigned int i;
 	int rc;
 
-	if (dev->no_vf_scan)
+	if (!num_vfs || dev->no_vf_scan)
 		return 0;
 
+	buses = kvcalloc(num_vfs, sizeof(*buses), GFP_KERNEL);
+	if (!buses)
+		return -ENOMEM;
+
+	created_buses = bitmap_zalloc(num_vfs, GFP_KERNEL);
+	if (!created_buses) {
+		kvfree(buses);
+		return -ENOMEM;
+	}
+
 	for (i = 0; i < num_vfs; i++) {
-		rc = pci_iov_add_virtfn(dev, i);
+		bool created;
+
+		buses[i] = virtfn_add_bus(dev->bus, pci_iov_virtfn_bus(dev, i),
+					  &created);
+		if (!buses[i]) {
+			rc = -ENOMEM;
+			goto remove_buses;
+		}
+		if (created)
+			__set_bit(i, created_buses);
+	}
+
+	for (i = 0; i < num_vfs; i++) {
+		rc = __pci_iov_add_virtfn(dev, buses[i], i);
 		if (rc)
 			goto failed;
 	}
+
+	bitmap_free(created_buses);
+	kvfree(buses);
 	return 0;
 failed:
 	while (i--)
 		pci_iov_remove_virtfn(dev, i);
 
+remove_buses:
+	/*
+	 * Remove only buses this enable created: several ids can share one
+	 * bus and only the creating id is recorded; virtfn_remove_bus()
+	 * checks emptiness, not ownership.  Re-look each up by number --
+	 * the VF unwind above may already have freed it.
+	 */
+	for_each_set_bit(i, created_buses, num_vfs) {
+		bus = pci_find_bus(pci_domain_nr(dev->bus),
+				   pci_iov_virtfn_bus(dev, i));
+		if (bus)
+			virtfn_remove_bus(dev->bus, bus);
+	}
+
+	bitmap_free(created_buses);
+	kvfree(buses);
 	return rc;
 }
 
-- 
2.47.3


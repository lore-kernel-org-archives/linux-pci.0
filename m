Received: from pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.162.73.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A5936C9C0;
	Fri, 11 Sep 2026 12:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.162.73.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789129972; cv=none; b=VxvEXf4VtTHCQazgzd6JeTIflNGqa1C3sS5htXCSsBTwux3rB8nkPC/qGlG1vUJC2bnml1iXL3xi6sVXIFGf96jibIgx+7+BQguZ8V+MXrOvl2Hql54ZiOzgbrBYGONFpX7oRtZt3HhElELOmL+yKch3oHPxSjigpnaXMoXnjxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789129972; c=relaxed/simple;
	bh=gkfBq/d2KCZiWb76KJJvG3RW2xOb5uDlYHUE3mhl5ls=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rCs00cjrMBHNXo/gPZtLcxUd32AL/BA2YJUN0bN2glvFWzN70nygB16uGKMbjSkVIZlVqWaD/u75FPFp1SdQalSDdz86QBnJoCUX5a11DROmrQKBgfA9RvbMwJ924jUxQ2WzPx/5xx1JX+G4xEwpJcivUvaNla3x7UPkqeP7kcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=bBgnqd3c; arc=none smtp.client-ip=35.162.73.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="bBgnqd3c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1789129969; x=1820665969;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ltbq+GWhG/1KvJm+1fqt+ZO5n9zoPu7qeY/Gw0JRs8Q=;
  b=bBgnqd3cumFs7HIhM56qIVj40CWOnPbQOqa8LYsx3iZIzw9mRfreTsv+
   pyiw5bojI7B8w459QEWcXznkjOnXsatbHN4G4A34yex3Mc9gGAxjLU6tC
   M295HLrisbG5wPZLzW2QYEav/IYExFUv9sDt131oUI50SZrE/HAR1ZrGa
   XAVD4t7geZkcN0+a6aGH6qPBMYKKaCxVF3yieJErX7/5wEDbUD2H/jrAc
   JFYRSqnRPKrFJ3yIG2HYP01wRAY/Imh2JgDCmlSKd2vfcZc8mNpCNiX6S
   +nhCS4KjUF1MOebplxtuOjby/nzw2rDkziLbI4/NyA7f1aoOofH1jSOGs
   A==;
X-CSE-ConnectionGUID: 2DIrQMtuQdu/rLuQKS2jXQ==
X-CSE-MsgGUID: MvMsu7H/QwOI0AyHD2ETgg==
X-IronPort-AV: E=Sophos;i="6.27,97,1787011200"; 
   d="scan'208";a="28221489"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 12:32:46 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.105:23580]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.22.113:2525] with esmtp (Farcaster)
 id beb290be-5da5-4822-b0d6-73219791d65a; Fri, 11 Sep 2026 12:32:45 +0000 (UTC)
X-Farcaster-Flow-ID: beb290be-5da5-4822-b0d6-73219791d65a
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Fri, 11 Sep 2026 12:32:45 +0000
Received: from dev-dsk-sakacpav-1a-480d1124.eu-west-1.amazon.com
 (172.19.96.155) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.46; Fri, 11 Sep 2026
 12:32:42 +0000
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
Subject: [RFC PATCH 6/8] PCI/IOV: Let sriov_add_vfs() own the failure unwind
Date: Fri, 11 Sep 2026 14:32:41 +0200
Message-ID: <20260911123241.3312-1-sakacpav@amazon.de>
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
X-ClientProxiedBy: EX19D039UWB002.ant.amazon.com (10.13.138.79) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

__pci_iov_add_virtfn() unwinds its own sysfs-link failure with
pci_stop_and_remove_bus_device(), which lockdep-asserts
pci_rescan_remove_lock. The next commit runs __pci_iov_add_virtfn() from
async workers that must never take or require that lock, so the unwind
has to move to the enabling task.

Leave __pci_iov_add_virtfn() reporting only and let each caller unwind
through pci_iov_remove_virtfn(), whose lookup-based design is correct at
every failure stage. sriov_add_vfs() unwinds ids 0..i inclusive on
failure of VF i, since VF i may be registered but not yet linked. The
wrapper unwinds fully before returning, because its EEH caller discards
the return code: the VF is removed through pci_iov_remove_virtfn(),
which also frees the bus it empties, and a bus this call created with
no VF registered on it is removed explicitly.

Assisted-by: LLM
Signed-off-by: Pavol Sakac <sakacpav@amazon.de>
---
 drivers/pci/iov.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index dda9303516f5..a32b2c295922 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -383,35 +383,42 @@ static int __pci_iov_add_virtfn(struct pci_dev *dev, struct pci_bus *bus,
 	pci_device_add(virtfn, virtfn->bus);
 	rc = pci_iov_sysfs_link(dev, virtfn, id);
 	if (rc)
-		goto failed1;
+		return rc;
 
 	pci_bus_add_device(virtfn);
 
 	return 0;
-
-failed1:
-	pci_stop_and_remove_bus_device(virtfn);
-	pci_dev_put(dev);
-
-	return rc;
 }
 
 int pci_iov_add_virtfn(struct pci_dev *dev, int id)
 {
 	struct pci_bus *bus;
+	bool created;
 	int rc;
 
-	bus = virtfn_add_bus(dev->bus, pci_iov_virtfn_bus(dev, id), NULL);
+	bus = virtfn_add_bus(dev->bus, pci_iov_virtfn_bus(dev, id), &created);
 	if (!bus)
 		return -ENOMEM;
 
 	rc = __pci_iov_add_virtfn(dev, bus, id);
-	if (rc)
-		virtfn_remove_bus(dev->bus, bus);
+	if (rc) {
+		pci_iov_remove_virtfn(dev, id);
+		/*
+		 * Same ownership and stale-pointer rules as the
+		 * sriov_add_vfs() bus unwind.
+		 */
+		if (created) {
+			bus = pci_find_bus(pci_domain_nr(dev->bus),
+					   pci_iov_virtfn_bus(dev, id));
+			if (bus)
+				virtfn_remove_bus(dev->bus, bus);
+		}
+	}
 
 	return rc;
 }
 
+/* Unwind primitive for partial adds: a missing VF must stay a silent no-op. */
 void pci_iov_remove_virtfn(struct pci_dev *dev, int id)
 {
 	char buf[VIRTFN_ID_LEN];
@@ -681,8 +688,10 @@ static int sriov_add_vfs(struct pci_dev *dev, u16 num_vfs)
 	kvfree(buses);
 	return 0;
 failed:
-	while (i--)
+	/* VF i may be partially added: unwind ids 0..i inclusive. */
+	do {
 		pci_iov_remove_virtfn(dev, i);
+	} while (i--);
 
 remove_buses:
 	/*
-- 
2.47.3


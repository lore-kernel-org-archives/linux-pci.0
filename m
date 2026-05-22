Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2133E9C26;
	Fri, 22 May 2026 11:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779450121; cv=none; b=j0ZRoN3sz82nfuSzF7+MX1gMrYKgxL+ejTHFKQiPv4K4tACmEfBAzrfRaMTwmFXgj78fJuy8BXKuwqBlbpW278vAZc5pS7ooRur+YD/zY2HYz1rbtJtTUUQJQezfTGFNc/SjqNNr9vZJL7aka9CtlykLmKNkdEveMccRAOsbtCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779450121; c=relaxed/simple;
	bh=j+tqSrbqxTMcje4dpkGMAy+RC/p7uGOoNZNdoC1jmbk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dGHOmZq96B+sBQj+ERiVHUpS2qkUBSAxpb79UWKaoTFpNB7aBZPcLaSonXpqZzOr7yeR6zxsZg8pAa0DrOEzcr6r9CoYLaXnQPWDojDv31hCq9PVK+JpqDCNZxkyJf0pILYfpj/eOGdGhc2lXGtr+8ldp6nZnNLYyuX9sMqelms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=O2ZRY8aE; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="O2ZRY8aE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=jr
	JlQhhvcM9ny9uWA43zdm3Z7J4LJGqTaSQepn0MtGg=; b=O2ZRY8aE49GZn/A3yn
	GPBAl0UQTaeuNUv8n3GEACtO6Q34gaHoGWlE1tJw62Hum6Khc9SaqUBsM3EL+vVn
	IbHBjXnXGUaOX7tLWnCxoVsNcjADKaN6tljTGWEWomixcgum7Rw9CUUjQMMf+zox
	gz1rZL/GZTY3wOxf9k9mtkg/Y=
Received: from Precision-7960.. (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wAHXsn1QBBq5h1YDA--.22257S2;
	Fri, 22 May 2026 19:41:42 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH] PCI/VPD: Add Realtek 8126 to VPD blacklist
Date: Fri, 22 May 2026 19:41:34 +0800
Message-ID: <20260522114135.2104890-1-18255117159@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAHXsn1QBBq5h1YDA--.22257S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uF17CF47Ar48GryUtrW5Jrb_yoW8JFy5pr
	Z8Wa18CFWFgr18XF4qgw1qkas8Za4vqFy0krySgwnFgan5CF1UZ3y3tF90qr15trZxXryU
	Xwn8A3y8Ga1DWr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zZjgJUUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC7Bbrj2oQQPZZSwAA3A

The Realtek 8126 Ethernet controller advertises VPD capability but
returns invalid data when VPD is read, leading to kernel messages
like:

  r8169 ... invalid VPD tag 0x00 (size 0) at offset 0; assume
  missing optional EEPROM

and pcilib reporting "sysfs_read_vpd: read failed: No such device".

Add the device to the VPD blacklist to suppress these errors.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/vpd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
index 153394a652d3..fbc34cd842ac 100644
--- a/drivers/pci/vpd.c
+++ b/drivers/pci/vpd.c
@@ -590,6 +590,7 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LSI_LOGIC, 0x002f, quirk_blacklist_vpd);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LSI_LOGIC, 0x005d, quirk_blacklist_vpd);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LSI_LOGIC, 0x005f, quirk_blacklist_vpd);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATTANSIC, PCI_ANY_ID, quirk_blacklist_vpd);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_REALTEK, 0x8126, quirk_blacklist_vpd);
 /*
  * The Amazon Annapurna Labs 0x0031 device id is reused for other non Root Port
  * device types, so the quirk is registered for the PCI_CLASS_BRIDGE_PCI class.
-- 
2.43.0


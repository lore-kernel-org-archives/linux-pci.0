Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6614457AC
	for <linux-pci@vger.kernel.org>; Mon, 12 Oct 2026 22:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791842650; cv=none; b=u28zU7VLdu8VS8B23Kwy3zN1liMsCmB5hPk819SOOtuGJN7gmq0IEDmQ6q7z9UNVZOsHfQqSxTeG37R2ntHDPQlSwDpErZpya51uLaDUJS9iD6lAMI8J3GpT6bNbDNbz0hVvtnPYbHe7Ru5x+9lI4Nfjny6XZA4zNfSN9zliymI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791842650; c=relaxed/simple;
	bh=zopFotP6InvE5vXahu435IY1xh5Ld3G38vL+69ufaEs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=pfHf2kaz6uBpHKwRpzpctoukEj54lU03JMhk/r0Qgoa+5jdOzAvbN31LKVheOrrEc9F/cwqwZ+4MJZ9S9iaOsyZxOE2lrEf5yr65j30/b6bY9D1AvJe1ZxZGc5l+62DfYo0a++0puU/xyKpD4U1qG6IdWYY54VaAjnzccWou+Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rathodpriyank.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OS2+oos/; arc=none smtp.client-ip=74.125.82.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rathodpriyank.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OS2+oos/"
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-3548cdfd2fbso3695743eec.1
        for <linux-pci@vger.kernel.org>; Mon, 12 Oct 2026 15:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791842648; x=1792447448; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z6Z8J9t9pgCMILSQ/korquurQDoz6vSJPj6ZETdqQUQ=;
        b=OS2+oos/R2ZQ8xaSSqTPspiTxMbngrZfnj3P08BMUuJ1sh5PcdCx2hZmnyX8Y/tKmT
         Sj4IaiTIJcCc+5HLgKjOGIzSTrmQfcbSkWn+OfThJB5QVV5UJsAkazqgyJRVQ8X7PRn2
         LSOnyvwfseSry92lvbsn11ObF7m9C023cxDp4Dt2LkFPGOboINXX/i5PLt1BKGtKlNZX
         XnMwd2Iblsl3ZiJLunrTuKLZdAYcF9o2mjANgNEcQu1esSF2cfeuHyb6ifeKlYz8quLK
         tuY4+bHwCa5YXyrijHqzQz50lHWNRFUIVnun7cKoVpvEClH+9hbUx57dsOLpt2vuZBhx
         skfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791842648; x=1792447448;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z6Z8J9t9pgCMILSQ/korquurQDoz6vSJPj6ZETdqQUQ=;
        b=YcqCJDyC5FGjG5Qmtotk0/zy5vS4huh48MZDw5f0vZMs1sVnc6ilOxyJM6XzdIjHWN
         TGuNSxWXhd7AlYyYvX4IKCOS6FIVbBTCHm4ZZPr5Mbcczt2QsO3BnzYIpzH+AoyGbO9l
         WbUiT7bpImwzdyzpDYyKecf/zRK7/rhahm3vBNoJvJofKqMiNHX6ULU2mFpHL7lrN+pL
         gm+XMdgMGDB7xbwpGrCQ1HuPnChnZH89WbuqgK799KGtjKU/Cz+ExQFxf+9GskgqqPWk
         prY4UVRzZeL4YzxNAnu6vuqtdVGUnG5Zo6+h328xUcpRE3/w/VlxLdKVndzp0pxD63gw
         xY4Q==
X-Forwarded-Encrypted: i=1; AKwUvBxOz0Rxv/BpuhHLr6tcw13WBlrizXhnVxYl1uZOVeCqh7RhpVfyt/28RHTU6KdfFt4lSWVXCNjRcKE=@vger.kernel.org
X-Gm-Message-State: AFq9FYK8p+9lkts28XiRW74eqsILmJdRKqupUDfZSC+OU+3z5nClll2/
	sXeoXWwjOi/MIPmhlmqDRMRK15YFL4TY4Rnx9KBBpoENMVbe7EIV/+6aX3ZdsU1lIbIIKxJv1ZD
	DUG9OZrfnilOZC3uJhy5g+Lu5QQwEZ7yABQ==
X-Received: from dyaz26-n1.prod.google.com ([2002:a05:693c:639a:10b0:341:7ee9:6f78])
 (user=rathodpriyank job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7300:8245:b0:35a:7464:6159 with SMTP id 5a478bee46e88-35a74646242mr5566349eec.34.1791842647411;
 Mon, 12 Oct 2026 15:04:07 -0700 (PDT)
Date: Mon, 12 Oct 2026 15:03:54 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAElZzWoC/x2MWwqAIBAArxL73UJa9LpK9FG22oKYaEYQ3T3pc
 wZmHogUmCKMxQOBLo58uAyiLEDtizOEvGUGWclWVEKiV0y4H6e3yaBL1gbS2OtmkWoQa00d5NR nyfe/neb3/QBk3J84ZgAAAA==
X-Change-Id: 20261012-pcie-hotplug-nullref-8f4a2c91b3e7
X-Mailer: b4 0.14.3
Message-ID: <20261012-pcie-hotplug-nullref-v1-1-6e21c2e89ea4@google.com>
Subject: [PATCH] PCI: pciehp: Fix NULL pointer dereference in pciehp_configure_device()
From: Priyank Rathod <rathodpriyank@google.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Lukas Wunner <lukas@wunner.de>, Niklas Schnelle <schnelle@linux.ibm.com>, 
	Ricky Wu <ricky_wu@realtek.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Priyank Rathod <rathodpriyank@google.com>
Content-Type: text/plain; charset="utf-8"

pciehp_configure_device() calls pci_get_dsn() on the result of
pci_get_slot(parent, PCI_DEVFN(0, 0)) without checking for NULL, unlike
the sibling call sites in pcie_init() and pciehp_device_replaced() added
by the same commit.  When hypervisor_isolated_pci_functions() is true
(e.g., Jailhouse or LoongArch) and a non-zero function is hot-added
without Function 0, pci_scan_slot() returns > 0 while pci_get_slot() for
00.0 returns NULL, causing pci_get_dsn() to dereference a NULL pointer
in pci_find_next_ext_capability().

Guard the pci_get_dsn() call against NULL and reset ctrl->dsn to 0 when
Function 0 is absent so ctrl->dsn does not retain a stale value from a
previously removed device.

Fixes: 9d573d19547b ("PCI: pciehp: Detect device replacement during system sleep")
Cc: stable@vger.kernel.org # v6.11+
Signed-off-by: Priyank Rathod <rathodpriyank@google.com>
---
Verification notes:
- Commit 9d573d19547b added 3 pci_get_slot(..., PCI_DEVFN(0, 0)) +
  pci_get_dsn() sites in pciehp: pcie_init() and
  pciehp_device_replaced() both guard against NULL, while
  pciehp_configure_device() omitted the check (the only unchecked
  pci_get_slot() call out of 21 across drivers/pci/).
- On bare metal (!hypervisor_isolated_pci_functions()), missing fn 0
  breaks out of pci_scan_slot() immediately with num == 0 (-ENODEV).
  When hypervisor_isolated_pci_functions() is true, pci_scan_slot()
  scans fn 1..7 and returns num > 0 even when 00.0 is absent, so
  pci_get_slot(parent, PCI_DEVFN(0, 0)) at line 75 returns NULL.
- Using "ctrl->dsn = dev ? pci_get_dsn(dev) : 0;" also avoids keeping a
  stale ctrl->dsn from a prior hotplug cycle since
  pciehp_unconfigure_device() does not clear ctrl->dsn.
---
 drivers/pci/hotplug/pciehp_pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/hotplug/pciehp_pci.c b/drivers/pci/hotplug/pciehp_pci.c
index 65e50bee1a8c..5f9e8044ea5b 100644
--- a/drivers/pci/hotplug/pciehp_pci.c
+++ b/drivers/pci/hotplug/pciehp_pci.c
@@ -73,7 +73,7 @@ int pciehp_configure_device(struct controller *ctrl)
 	down_read_nested(&ctrl->reset_lock, ctrl->depth);
 
 	dev = pci_get_slot(parent, PCI_DEVFN(0, 0));
-	ctrl->dsn = pci_get_dsn(dev);
+	ctrl->dsn = dev ? pci_get_dsn(dev) : 0;
 	pci_dev_put(dev);
 
  out:

---
base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
change-id: 20261012-pcie-hotplug-nullref-8f4a2c91b3e7

Best regards,
-- 
Priyank Rathod <rathodpriyank@google.com>


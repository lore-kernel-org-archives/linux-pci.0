Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6D03A6B6A
	for <linux-pci@vger.kernel.org>; Mon, 30 Mar 2026 21:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774907161; cv=none; b=l35cmioVhIzwuw0Gt7oKtl2xSPcWOwcgXwEKTH+/JgwhfIy5iH9vj1emHWx9dajC3z6UmYQL+dna0fqn2HbDPEOTYS6oFSgzwsrwlL/EiK6Gqx3SA50V03dotmVH4ECsmPXj1PRReL6Cpw4DXUHI8tezz0aYjdDcRQsh2HuypDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774907161; c=relaxed/simple;
	bh=na3CNjZAxR1UFCvbZH9HyTPvuYJakaPivkdm8gPra6c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mv8vo/1v0ag+A4zEIDN6/txC7Au5En6vcKRsYOQnrA007o2UAoCxERnj3leJGS/Fj2VACkrRd8x1GK8u5D6E3RGI8B5i4vdvapGBojawffwZJbmp4jMvt4v1U7g4IjsGGL2yyWIhX2QJHgbxvAAFZjZGTPG2auk4g7Rd0tWP7Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=peVHHkjk; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="peVHHkjk"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-486fb439299so46148175e9.0
        for <linux-pci@vger.kernel.org>; Mon, 30 Mar 2026 14:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774907158; x=1775511958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=k94Qbhxpduj8Aq/R0uxlYLOlSwyCHChCKKV0ReNwEMM=;
        b=peVHHkjkWgmSVIPPN+PTThkcz/9igpNr21YClND65PHTU3BXWb9zPMm1sbkrTrNv3q
         JeLxWFtRNtSTzhkKdEF5kb3cuicNRk0uEq2Dl70lyfwZxcNpQDyJVHFN1h5QWzhDczxs
         bBQJA+tGPjn/nOxqpodi/y0xOtX1b8gb9KkDXZcOhisd+DdL3sW/Sf5iq5LKDFsgcf1J
         5q9u8HmyK7/R+19iygE3SfJGd0AHZivSlrx5YtwbTbceXq0TC5pGwDx5k5npcE7KcqOL
         vh3KzjVFRaybJj0i0emkwyTC3O65Ua6u2QRyzlZ0cCd6j48eEgjkpwJqApg1SvEE6HWO
         RKdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774907158; x=1775511958;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k94Qbhxpduj8Aq/R0uxlYLOlSwyCHChCKKV0ReNwEMM=;
        b=KOQK8kfccmYbl7lhUkb+KxB2OQGw+QiLzny407MIj9ZJlloev6wNHHb3ZSnlCkMprH
         l10eX+DZXxf3rHSD1ozK34WtzjfdyY6HTZlJWSKuXkyFjN601y3/s7JyD3JTW6kUsyb4
         qjz89N4OelT3xMH8EISaB8joRkk9+aWBVvvI5bGDEHyentWl2YAky/j3FlfRb5WaQY8v
         EVrOAOtXg+ZMJPQNHAXOP+Ngfi3vXxUj4JyHSRYp5P73q/62HVUhsU6AC9QeMB8z4tRS
         LFyHF7dWGtx0ved8GuQOCOYpQJr1ChTeH2Yu450DZSI9uVyi8lzZA+/CnZIYSZUdGcUl
         5z7A==
X-Forwarded-Encrypted: i=1; AJvYcCVwwXIfELf2RjG4rm9Bj5N1JuF1L7cvoo8nDyws8lym2yqM8Tcfgao+ZWzrldk2fiRG47vjwVDfroo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz75faXc0uPSlfKtw9+vxFUX0U+BiQGpyByRJ6EsGdzCJmYZerl
	9hPy/VdOu6F0nrHqd9LadGh2cz7r65p0cKMHXLkRWvgDr4yw6a+fvl2nK2s5wavzNjJcTw==
X-Gm-Gg: ATEYQzwNI2qyf+ZTCGynpmt00+X8iIUuhUvvglSw3EhSRTME9O+onJ0wVBoLfoSd+fe
	B8ljaucnwu0NBirj5jdbv5xipPimV/hZpvIxEcvpMkLNtYnQ+iB94Z4DPzrFh8utenCuJeownVQ
	ndAYRjEmBn0hiPdFCt/mnD43r49hZY1AO+Wk4rIag2mK/Z0Pr5etHroow5S0iCLmjstpMylwQ/y
	jsInJBSvuTj/f5xcbJKXSgkVEnxTQwYFbhAwB++xIfxg1qUGit0gsWtAI+KOLb3xqn+/1UU//uc
	jpd15TZ1FMS6vN3ZfxhwpHHO995qXLdId1AubuusUmj7ecMv2ED5xekCeNKWVsD9tpzOKMn4vin
	86T/FyHS07YvQeSGl9jj7ln8cpcyAxpV+vp7Z1NsP4L5y5/Da+TU6Qw2QQhG3WVPlz/LhkZ9FL9
	t59VVJTrAPxSChYRkGfokg/hPBFqI36cCXJgGIq3vAZ64CRvjm9FmWROk=
X-Received: by 2002:a05:600c:8b70:b0:487:467:42a2 with SMTP id 5b1f17b1804b1-48727f7b571mr239745795e9.18.1774907157688;
        Mon, 30 Mar 2026 14:45:57 -0700 (PDT)
Received: from nixos-office (195-23-151-163.net.novis.pt. [195.23.151.163])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48722d2366dsm305888025e9.10.2026.03.30.14.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 14:45:57 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
From: Julian Braha <julianbraha@gmail.com>
To: bhelgaas@google.com,
	robh@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Julian Braha <julianbraha@gmail.com>
Subject: [PATCH] pci: dead code cleanup in Kconfig
Date: Mon, 30 Mar 2026 22:45:49 +0100
Message-ID: <20260330214549.16157-1-julianbraha@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is already an 'if PCI' condition wrapping several config options
e.g. PCI_DOMAINS and VGA_ARB, making the 'depends on PCI' statement for
each of these a duplicate dependency (dead code).

I propose leaving the outer 'if PCI...endif' and removing the individual
'depends on PCI' statement from each option.

This dead code was found by kconfirm, a static analysis tool for Kconfig.

Signed-off-by: Julian Braha <julianbraha@gmail.com>
---
 drivers/pci/Kconfig | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index e3f848ffb52a..33c88432b728 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -31,7 +31,6 @@ if PCI
 
 config PCI_DOMAINS
 	bool
-	depends on PCI
 
 config PCI_DOMAINS_GENERIC
 	bool
@@ -255,7 +254,7 @@ config PCI_DYNAMIC_OF_NODES
 choice
 	prompt "PCI Express hierarchy optimization setting"
 	default PCIE_BUS_DEFAULT
-	depends on PCI && EXPERT
+	depends on EXPERT
 	help
 	  MPS (Max Payload Size) and MRRS (Max Read Request Size) are PCIe
 	  device parameters that affect performance and the ability to
@@ -272,20 +271,17 @@ choice
 
 config PCIE_BUS_TUNE_OFF
 	bool "Tune Off"
-	depends on PCI
 	help
 	  Use the BIOS defaults; don't touch MPS at all.  This is the same
 	  as booting with 'pci=pcie_bus_tune_off'.
 
 config PCIE_BUS_DEFAULT
 	bool "Default"
-	depends on PCI
 	help
 	  Default choice; ensure that the MPS matches upstream bridge.
 
 config PCIE_BUS_SAFE
 	bool "Safe"
-	depends on PCI
 	help
 	  Use largest MPS that boot-time devices support.  If you have a
 	  closed system with no possibility of adding new devices, this
@@ -294,7 +290,6 @@ config PCIE_BUS_SAFE
 
 config PCIE_BUS_PERFORMANCE
 	bool "Performance"
-	depends on PCI
 	help
 	  Use MPS and MRRS for best performance.  Ensure that a given
 	  device's MPS is no larger than its parent MPS, which allows us to
@@ -303,7 +298,6 @@ config PCIE_BUS_PERFORMANCE
 
 config PCIE_BUS_PEER2PEER
 	bool "Peer2peer"
-	depends on PCI
 	help
 	  Set MPS = 128 for all devices.  MPS configuration effected by the
 	  other options could cause the MPS on one root port to be
@@ -317,7 +311,7 @@ endchoice
 config VGA_ARB
 	bool "VGA Arbitration" if EXPERT
 	default y
-	depends on (PCI && !S390)
+	depends on !S390
 	select SCREEN_INFO if X86
 	help
 	  Some "legacy" VGA devices implemented on PCI typically have the same
@@ -340,4 +334,4 @@ source "drivers/pci/endpoint/Kconfig"
 source "drivers/pci/switch/Kconfig"
 source "drivers/pci/pwrctrl/Kconfig"
 
-endif
+endif # PCI
-- 
2.51.2


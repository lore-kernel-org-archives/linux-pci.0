Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793726892;
	b=ozK48T9GTsAvBmAQ48SU8Lo8IcqY0e7R8rliKmjQ4sDX5IhY3lvvK3ozn54zdpH4x/sE
	 J8bR5Q33vwGXGHxwPiHpJoiUV+hZIyHasGGhBq3U4N+OyRL2OYtgqRXFLbblUD7mz6pWr
	 LN8gAJZDHXkLOlWjf3s1dn5T40KG+EugSEIZZrofuu+kNilXFF7blZ6bekDB83xsrOzuI
	 b210RO0zxwrRzTqxIZBVZFkVSa2b4/uthFA54gk1TcaENyU1W6ylIXwJMcHrABjKb5vCM
	 7VTSh6nUv2hxFrBleHTYPS/fNlwvHl6UnE4atMc7N0GvM33X7RhVsAHq19n3N3DwHsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793726892;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=wyBAYDHyobxIW1sfQpfwkHHCUqn/oTPu5P/6lW0BfEA=;
	b=dad7rB6+yL0wKsq/Y5wHH2zfjZ5YqAyr8wAYq2EVkDjjG8Uw55GTod7uUt/Fm9UP409Y
	 UnA9jX7GK+57062Trfhj5SUHw3TBwlvxFAW3r8PHnf0aIaofztfpzxfhakZvErwbfjaoB
	 YnoWTKMo/P8UY2mqUtmZK3tWUOknkesGRmODaPi1li8eC9KRZarRFEMvOV+3k1tLyalzL
	 UzHfkyCtEassX90k7gDYNxCaReyJusH832mHbKlxNEr1vuutP+qPf2BN7X6fM0Z8fAxSq
	 QjSs5BoMlcSj68zLVkWkhFQlpFKMdoHadAG+h0Voqs3ocwLjuWyDprzynh0M649rgUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b="VE/2h/a3";
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614B5606A31B;
	Tue,  3 Nov 2026 17:28:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 614B5606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=VE/2h/a3
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 866261595;
	Tue,  3 Nov 2026 09:28:07 -0800 (PST)
Received: from e145574.cambridge.arm.com (e145574.arm.com [10.0.154.220])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7FE753F673;
	Tue,  3 Nov 2026 09:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793726890; bh=3lSa1YQ8IlpyBv/Ial1NOF3NIq5c9EjpL7iSEbZuVFw=;
	h=From:To:Cc:Subject:Date:From;
	b=VE/2h/a38n9qVnmzkHFZXYmCcraU1+bN5GRYGXoUMz+W0E7x3EZmy3nvg2BdWug+k
	 bGiCCdptsGUCS98EgrvVEOgZOtUJkmnZLbLaUsMROCiIjr1YSXrY6v3kOpl4xIPQOr
	 G1ftQT1KVDzOlYdvvQzLZ5wEM5+bXBog2CXWVvXo=
From: John Garry <john.garry@arm.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org,
	hkallweit1@gmail.com,
	nic_swsd@realtek.com,
	netdev@vger.kernel.org,
	john.garry@linux.dev,
	John Garry <john.garry@arm.com>
Subject: [RFC PATCH] PCI: Avoid bus reset for Realtek RTL8126
Date: Tue,  3 Nov 2026 17:27:58 +0000
Message-ID: <20261103172758.1816004-1-john.garry@arm.com>
X-Mailer: git-send-email 2.43.0
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

From testing on a Orion O6 board, a bus level reset for a RTL8126 may not
recover:
root@radxa-kernel:/sys/devices/pci0000:00/0000:00:00.0/0000:01:00.0# more reset_method
bus
root@radxa-kernel:/sys/devices/pci0000:00/0000:00:00.0/0000:01:00.0# echo 1 > reset
 r8169 0000:01:00.0: resetting
 r8169 0000:01:00.0: not ready 1023ms after bus reset; waiting
 r8169 0000:01:00.0: not ready 2047ms after bus reset; waiting
 r8169 0000:01:00.0: not ready 4095ms after bus reset; waiting
 r8169 0000:01:00.0: not ready 8191ms after bus reset; waiting
 r8169 0000:01:00.0: not ready 16383ms after bus reset; waiting
 r8169 0000:01:00.0: not ready 32767ms after bus reset; waiting
 SError Interrupt on CPU6, code 0x00000000be000011 -- SError

Add a quirk to avoid this reset method.

Signed-off-by: John Garry <john.garry@arm.com>
---
I'm sending as an RFC as I am not sure that this is an issue with the
development board and not the controller.

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 7f1f47ea2ee4..69eef714838a 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3850,6 +3850,9 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ASMEDIA, 0x1164, quirk_no_bus_reset);
 /* Intel DG1 0x4905 may not recover from bus reset */
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x4905, quirk_no_bus_reset);
 
+/* Realtek RTL8126 may not recover from a bus reset */
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_REALTEK, 0x8126, quirk_no_bus_reset);
+
 static void quirk_no_pm_reset(struct pci_dev *dev)
 {
 	/*
-- 
2.47.3


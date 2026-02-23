Received: from mail-m19731117.qiye.163.com (mail-m19731117.qiye.163.com [220.197.31.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733C0309DDB;
	Mon, 23 Feb 2026 16:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771862406; cv=none; b=oP4k2KQ39uDKDyQWsQa2dBocFvEKHwu1ZieedXIdfaM2G3V5qr695im4Rn3gllLXNeDmxBoluaPk1m7ZVCMwy1b43741yofOnXRwnJwzvkD5xMm8zs+00KZ2Bof5RvfBYzBpIkOrdFUSYxn0h0b1lPMfdyXXmPk3AAXn8bxvvbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771862406; c=relaxed/simple;
	bh=IAG6pPC1shdqUXDlyvyRmagucInGFoCh9om2o+iC4HM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=lBzEqMUm5hXy/4uy1Y9VSpVXE6xT9O5k98gW1D8m9fhB2M02eiQcOFhBwcRsRr3lLn8BoeFJX4SMcLqJY2qd6TDpmiCX6YoEiPpTVbtMux4ZWuFlD5bYdZy15bLcBThua1+pXO/YMVfOEO63G1pmEVvmtJcRnNbHK7FlOLNznLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=Ln69DIhs; arc=none smtp.client-ip=220.197.31.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="Ln69DIhs"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 34b4045c3;
	Mon, 23 Feb 2026 23:54:52 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Andreas Noever <andreas.noever@gmail.com>,
	Mika Westerberg <westeri@kernel.org>,
	Yehezkel Bernat <YehezkelShB@gmail.com>
Cc: linux-usb@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Stanner <phasta@kernel.org>,
	linux-pci@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 22/37] thunderbolt: Replace pci_alloc_irq_vectors() with pcim_alloc_irq_vectors()
Date: Mon, 23 Feb 2026 23:54:37 +0800
Message-Id: <1771862077-89131-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1771860581-82092-1-git-send-email-shawn.lin@rock-chips.com>
References: <1771860581-82092-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9c8b35eab209cckunmb0f62fc3987d5e
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGhhDTVYYGENDGkMZTUpOS09WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=Ln69DIhs6dRgR2f6iJ47YsDpOVB2Pyjg92vgoX3awFe2dCrcxMux2DTBzSWvxybFt6oSS9CQ6xaaFVF0PktekthRRDxtX58/F1BpDaWn23Ke0BOJVZ8A9KhRT+XSKH2WIWiZygjCAgWG0CbUs3eKsFXkwrtwmI7muYyJalpNXCU=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=YZ3ee/IqKV3uQKaFacT6Hjz1cYMlwt09lzT1XkFyxmI=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

pcim_enable_device() no longer automatically manages IRQ vectors via devres.
Drivers must now manually call pci_free_irq_vectors() for cleanup. Alternatively,
pcim_alloc_irq_vectors() should be used.

To: Andreas Noever <andreas.noever@gmail.com>
To: Mika Westerberg <westeri@kernel.org>
To: Yehezkel Bernat <YehezkelShB@gmail.com>
Cc: linux-usb@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Philipp Stanner <phasta@kernel.org>
Cc: linux-pci@vger.kernel.org
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/thunderbolt/nhi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/thunderbolt/nhi.c b/drivers/thunderbolt/nhi.c
index 6d0c9d3..06c9a76 100644
--- a/drivers/thunderbolt/nhi.c
+++ b/drivers/thunderbolt/nhi.c
@@ -1281,10 +1281,10 @@ static int nhi_init_msi(struct tb_nhi *nhi)
 	 * one MSI-X. If for some reason that does not work out, we
 	 * fallback to a single MSI.
 	 */
-	nvec = pci_alloc_irq_vectors(pdev, MSIX_MIN_VECS, MSIX_MAX_VECS,
-				     PCI_IRQ_MSIX);
+	nvec = pcim_alloc_irq_vectors(pdev, MSIX_MIN_VECS, MSIX_MAX_VECS,
+				      PCI_IRQ_MSIX);
 	if (nvec < 0) {
-		nvec = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_MSI);
+		nvec = pcim_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_MSI);
 		if (nvec < 0)
 			return nvec;
 
-- 
2.7.4


Received: from psionic.psi5.com (psionic.psi5.com [185.187.169.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07468328B44
	for <linux-pci@vger.kernel.org>; Wed, 18 Feb 2026 13:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.187.169.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771422429; cv=none; b=cF8UR2/yXFlZnVQVpnmsE1xSUZ2Cxf+0id27Rqqk/LunQXyCUvE4SmM7DEW1PTgqwngoulxf44/IfQu7fyIRFTScbA6/YpywO2q/u0STrLkUKIyeEga8SRjcfozX4rs3VC9+Fz2KvGi54uTb4ojfQxi1o8bSOpEKUZdjU4EGB8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771422429; c=relaxed/simple;
	bh=YqtN64zjt6WcjFBZVypSO7UTvisvmqOTiwfZumwNiIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hAUyihXP369NcYJmGoSXxBcd0C27dkiM6rKtHiieNJyiM7Vm0bBRF4YyZv+mKUQ3IH85lNB2vJZdLz72M0srbMWSlwrY0JXZhh8dU+YWaA0xfWu/gekX/nsNPOxz30Bdlo/DgjqpD/TxhiY17mB6HmLKzJ0QzvCOMDeB67EldA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de; spf=pass smtp.mailfrom=hogyros.de; arc=none smtp.client-ip=185.187.169.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hogyros.de
Received: from localhost.localdomain (unknown [IPv6:2400:2410:b120:f200:2e09:4dff:fe00:2e9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by psionic.psi5.com (Postfix) with ESMTPSA id 0E3C83F204;
	Wed, 18 Feb 2026 14:47:04 +0100 (CET)
From: Simon Richter <Simon.Richter@hogyros.de>
To: linux-pci@vger.kernel.org
Cc: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	Simon Richter <Simon.Richter@hogyros.de>
Subject: [PATCH v2 5/5] pci: mark return value of pci_set_vga_state as __must_check
Date: Wed, 18 Feb 2026 22:46:33 +0900
Message-ID: <20260218134633.461181-6-Simon.Richter@hogyros.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260218134633.461181-1-Simon.Richter@hogyros.de>
References: <20260217170419.236739-1-Simon.Richter@hogyros.de>
 <20260218134633.461181-1-Simon.Richter@hogyros.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This function can return an error, which should be checked.

The only caller so far is __vga_tryget in vgaarb, which did not check.

Signed-off-by: Simon Richter <Simon.Richter@hogyros.de>
---
 include/linux/pci.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 1c270f1d5123..aa1451d402d1 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1720,8 +1720,8 @@ resource_size_t pcibios_window_alignment(struct pci_bus *bus,
 #define PCI_VGA_STATE_CHANGE_BRIDGE (1 << 0)
 #define PCI_VGA_STATE_CHANGE_DECODES (1 << 1)
 
-int pci_set_vga_state(struct pci_dev *pdev, bool decode,
-		      unsigned int command_bits, u32 flags);
+int __must_check pci_set_vga_state(struct pci_dev *pdev, bool decode,
+				   unsigned int command_bits, u32 flags);
 
 /*
  * Virtual interrupts allow for more interrupts to be allocated
-- 
2.47.3


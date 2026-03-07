Received: from psionic.psi5.com (psionic.psi5.com [185.187.169.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03576301016
	for <linux-pci@vger.kernel.org>; Sat,  7 Mar 2026 17:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.187.169.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772904967; cv=none; b=TdZBVjkFlw63Ea3nRUzlbetWOcav+q/osLebr1WPqedHQu7hYE4pKRxFYEMk6OgzoQXGb2UZRux0U5xDma3kLFwJH0Z9qTqP+eEVPxM9D80Vk4hVKBqXJX16fqFBCzOBGiEZ8PizOW2vqViYGzCK14BMs88w7+nnLluSO3/qko8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772904967; c=relaxed/simple;
	bh=D3w8jgvVUVHl5mYN6DFvxMLadrmiuC0XoYHGw5/l9as=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XaxqEnzsbUOxLPnYO4Py1NeVL26IIL5CMQQN9hXrbkweog5MIWFj7FVcw29uYCNRQIxaEur59CsGo3vYjxG1uO0TvmOdCw/bG1tAtdwITie2WC7D2XDOve9o96DH/G9FhvwtNcVThrlWEVexes5F7XL3dJmGKTf0wI+q+YJwWGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de; spf=pass smtp.mailfrom=hogyros.de; arc=none smtp.client-ip=185.187.169.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hogyros.de
Received: from localhost.localdomain (unknown [IPv6:2400:2410:b120:f200:2e09:4dff:fe00:2e9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by psionic.psi5.com (Postfix) with ESMTPSA id 2968F3F9B3;
	Sat,  7 Mar 2026 18:36:02 +0100 (CET)
From: Simon Richter <Simon.Richter@hogyros.de>
To: linux-pci@vger.kernel.org
Cc: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	Simon Richter <Simon.Richter@hogyros.de>
Subject: [PATCH v3 5/5] pci: mark pci_set_vga_state() as __must_check
Date: Sun,  8 Mar 2026 02:35:38 +0900
Message-ID: <20260307173538.763188-6-Simon.Richter@hogyros.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260307173538.763188-1-Simon.Richter@hogyros.de>
References: <20260307173538.763188-1-Simon.Richter@hogyros.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This function can return an error, usually on non-x86 or virtualized
environments.

The only caller so far is __vga_tryget() in vgaarb.

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


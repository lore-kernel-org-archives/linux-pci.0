Received: from psionic.psi5.com (psionic.psi5.com [185.187.169.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45427283FE2
	for <linux-pci@vger.kernel.org>; Tue, 17 Feb 2026 17:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.187.169.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771347896; cv=none; b=BOoHeHA7oGUlIYkHHwpwpzKr1F8BAvBrZNVe10LXIKh9UmZkOcFaPMAr2DOnjn5XfuDNN5HCSv+COzl00atJc/FtX/zWi4GVTEakARpD6QJQ8CXIR9sUNxaGj1MXptV674Y50eJqon/sH9lQ9B/1iAYLcWBzrNOvxIa//IKjwLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771347896; c=relaxed/simple;
	bh=8nbDxdvAQJU8348QsKZkR5J2oULE2YJAZS9e6FfC6+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bBqB25qvgtf1GLmDcpPOeBOyDuff/6ufNtoKMXcsl3nFc73WytISb9I5kFrktqFUMts8FcofO7Km9dDonmFWgm96cuwlQPkqmtKXPZWT9sN7Gy/3pDNcowvZ66X7VRLXZMU5sGMdBCkoLiXQzUVqKLpB+gY5tIsRy4dsLuCYWk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de; spf=pass smtp.mailfrom=hogyros.de; arc=none smtp.client-ip=185.187.169.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hogyros.de
Received: from localhost.localdomain (unknown [IPv6:2400:2410:b120:f200:2e09:4dff:fe00:2e9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by psionic.psi5.com (Postfix) with ESMTPSA id B3CBD48ADA;
	Tue, 17 Feb 2026 18:04:49 +0100 (CET)
From: Simon Richter <Simon.Richter@hogyros.de>
To: linux-pci@vger.kernel.org
Cc: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	Simon Richter <Simon.Richter@hogyros.de>
Subject: [PATCH 5/5] pci: mark return value of pci_set_vga_state as __must_check
Date: Wed, 18 Feb 2026 02:04:19 +0900
Message-ID: <20260217170419.236739-6-Simon.Richter@hogyros.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260217170419.236739-1-Simon.Richter@hogyros.de>
References: <20260217170419.236739-1-Simon.Richter@hogyros.de>
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
 include/linux/pci.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 1c270f1d5123..08d7c1ae33b5 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1720,7 +1720,7 @@ resource_size_t pcibios_window_alignment(struct pci_bus *bus,
 #define PCI_VGA_STATE_CHANGE_BRIDGE (1 << 0)
 #define PCI_VGA_STATE_CHANGE_DECODES (1 << 1)
 
-int pci_set_vga_state(struct pci_dev *pdev, bool decode,
+int __must_check pci_set_vga_state(struct pci_dev *pdev, bool decode,
 		      unsigned int command_bits, u32 flags);
 
 /*
-- 
2.47.3


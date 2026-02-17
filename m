Received: from psionic.psi5.com (psionic.psi5.com [185.187.169.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8D636EA9A
	for <linux-pci@vger.kernel.org>; Tue, 17 Feb 2026 17:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.187.169.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771348435; cv=none; b=RkVKitMkACLp9dyTudk3NcHZZcoEkjOrY3iFY0/XFzSaavEmo8ERUkihMaUm+i7GjrxPDMFohJutTDi9uTR8yQMPKTR29o7dehTcxE2nYDvg3LF7l/VHeVw9hKnAY7ZCF8lN2OWyGk0Eea6IzDKpzFwK7dtrUfnqR/CnSKrY964=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771348435; c=relaxed/simple;
	bh=38JmW/h+/76TrY6zhOVtMMo787EL8xmv9oNbACan8Tw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VXvhL+aCMjndjm3HYQ02i0oHkl7FNqmsI2SoAlMrIzPxOA64d9laGZFaRp2o1fdi9fZb5FBwKaqn6qn2DrCCmrU6Vd5NALvB77S8C8CB+tajrm67khloG94J3rBAZ7wMSso7n7FoB7oAWwme/K+EGPQZoIrQocSK8D5/FJzGdfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de; spf=pass smtp.mailfrom=hogyros.de; arc=none smtp.client-ip=185.187.169.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hogyros.de
Received: from localhost.localdomain (unknown [IPv6:2400:2410:b120:f200:2e09:4dff:fe00:2e9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by psionic.psi5.com (Postfix) with ESMTPSA id D101848A3B;
	Tue, 17 Feb 2026 18:04:47 +0100 (CET)
From: Simon Richter <Simon.Richter@hogyros.de>
To: linux-pci@vger.kernel.org
Cc: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	Simon Richter <Simon.Richter@hogyros.de>
Subject: [PATCH 4/5] pci: check if VGA decoding was really activated
Date: Wed, 18 Feb 2026 02:04:18 +0900
Message-ID: <20260217170419.236739-5-Simon.Richter@hogyros.de>
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

PCI bridges are allowed to refuse activating VGA decoding, by simply ignoring
attempts to set the bit that enables it, so after setting the bit, read it
back to verify.

One example of such a bridge is the root bridge in IBM PowerNV.

Signed-off-by: Simon Richter <Simon.Richter@hogyros.de>
---
 drivers/pci/pci.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index f3244630bfd0..0984a0aefb88 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6198,6 +6198,12 @@ int pci_set_vga_state(struct pci_dev *dev, bool decode,
 				cmd &= ~PCI_BRIDGE_CTL_VGA;
 			pci_write_config_word(bridge, PCI_BRIDGE_CONTROL,
 					      cmd);
+			if (decode) {
+				pci_read_config_word(bridge, PCI_BRIDGE_CONTROL,
+						     &cmd);
+				if(!(cmd & PCI_BRIDGE_CTL_VGA))
+					return -EIO;
+			}
 		}
 		bus = bus->parent;
 	}
-- 
2.47.3


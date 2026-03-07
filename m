Received: from psionic.psi5.com (psionic.psi5.com [185.187.169.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA14733506C
	for <linux-pci@vger.kernel.org>; Sat,  7 Mar 2026 17:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.187.169.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772904967; cv=none; b=TUy9rYi4jEz8QaC+/eAVx/JMmdL91Sln3h2FMhIOwpZTFsCCyS9uDC8qI7NZYlLhnfuxwUKlJFtkBTov7aKVUkdhLUub7EaYg0Q/F5VfzqwkyJPZsmXqGdUL7TYnfZcFyluMRc3WiyfKYE5PXjZBIlqnZ4ej7ecotvvlj5JID3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772904967; c=relaxed/simple;
	bh=T+pVTBLoj4VxMDly9Eypt3ftLGzdCKdcxbynJkcG8j8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I9hLyFshp3AG1gOc3mYxSXPDEwN0R+vF4sH4Q0Y8znOwk30y8V9Ji+n3PBIEIpjHGz1UVJw/u/wIY0MiaqbgwWjEqL1Bb14ztd4yilHfLYcGeDwr8tsY7mY5DRgjQAL2VoMN6uqM9YVTbnlovQwa7BdDhJKUawi4/BPEShAVxRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de; spf=pass smtp.mailfrom=hogyros.de; arc=none smtp.client-ip=185.187.169.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hogyros.de
Received: from localhost.localdomain (unknown [IPv6:2400:2410:b120:f200:2e09:4dff:fe00:2e9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by psionic.psi5.com (Postfix) with ESMTPSA id 46B2B3F549;
	Sat,  7 Mar 2026 18:36:01 +0100 (CET)
From: Simon Richter <Simon.Richter@hogyros.de>
To: linux-pci@vger.kernel.org
Cc: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	Simon Richter <Simon.Richter@hogyros.de>
Subject: [PATCH v3 4/5] pci: check if VGA decoding was really activated
Date: Sun,  8 Mar 2026 02:35:37 +0900
Message-ID: <20260307173538.763188-5-Simon.Richter@hogyros.de>
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

PCI bridges are allowed to refuse activating VGA decoding, by simply
ignoring attempts to set the bit that enables it, so after setting the bit,
read it back to verify.

One example of such a bridge is the root bridge in IBM PowerNV, but this is
also useful for GPU passthrough into virtual machines, where it is
difficult to set up routing for legacy IO through IOMMU.

Signed-off-by: Simon Richter <Simon.Richter@hogyros.de>
---
 drivers/pci/pci.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 8479c2e1f74f..e60b948f8576 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6197,6 +6197,12 @@ int pci_set_vga_state(struct pci_dev *dev, bool decode,
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


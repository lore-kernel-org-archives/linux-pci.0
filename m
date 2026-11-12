Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794453604;
	b=i+VYipfiBOsiVX25tU8JK4WYCW3uleLBkvQIpMyzUblczPZEw5CEvwjqOfJplneCaCuG
	 2HtQg0A9zlm+gOjRobOcWG0nz9tfh9bg7JWLACqxaqHSwxhdK5m0jLwmOEzZLadW/1FeA
	 CS2UgfrWuNLvLih9VP/dTK4W7BN9e9RhGZfRORUz53rcRALiA0KKF1AbxwOWNe4TkbRU8
	 6v+8KTGjfSVjgTeAAwteG+MsAaJ8xb5WHoTrChq794UJT8zeADgf7waxK5QJb/JIVwh/r
	 UDFczdK9M+fw1l4qF8kbfK4ONc5MoZqNWCdh5vhtsb0+LZKw6+XnRs2yDJZMMr00tYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794453604;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=hmpzgPslhxYA71ELCoCW5J7VR4kuagJg7YlC5PEGMN8=;
	b=nsOIx1AMDW6vKIiH/RgG4a3WPCf0vOAAgfLKNv5rwHZmaXbBAzwUw2NovDVmcdae08c+
	 17eWt7FUfGyQE/myz2YNdVd9U0eGjW4q9HPVq016lcdy6jpX75FUnI+VohiedaLUZ4R3n
	 YxF/cKW2WqNKlcwCNp3HkO5Ki6w7cguksXP4HHsxkWcNF/NXZ0t0db3zEJ4n59B7wQTVu
	 3+wZfJdx01bT723vwh3gjxfBb7ZsvKGtftktl1Xvb7FPMpV44L1Xq8DmlodhuJ4D15Cxy
	 UvdWcer/OxOucxsHJnMOn0hhb5EiuQN6KMOm67pAZLwCERD7dj2IfK5S6v8MzQ8DFZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=g4pe8Niu;
	arc=none smtp.remote-ip=117.135.210.3
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F10606A321;
	Thu, 12 Nov 2026 03:20:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6F10606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=g4pe8Niu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=hm
	pzgPslhxYA71ELCoCW5J7VR4kuagJg7YlC5PEGMN8=; b=g4pe8NiukN4etvMb8W
	f6lwOQWICimXSmmjmtzLlWyES1PIJI0uYfYidxX2DYgDG+AgwHBzPXX20SvPQOap
	BqKpvxM0qi1KdQJ6RxlthF8BQrD7urLglXcqyMyfkwHCOemlO6pxQGH314FKVFQL
	WZuv3/GCObCdXDxpnUoNZYMt8=
Received: from Precision-7960.. (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wDXD8o6MPVqh72fHQ--.23678S3;
	Thu, 12 Nov 2026 11:19:25 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: mahesh@linux.ibm.com,
	bhelgaas@google.com
Cc: oohall@gmail.com,
	mani@kernel.org,
	lukas@wunner.de,
	linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v5 1/2] PCI: Introduce pci_clear/set_config_dword()
Date: Thu, 12 Nov 2026 11:19:20 +0800
Message-ID: <20261112031921.1255661-2-18255117159@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261112031921.1255661-1-18255117159@163.com>
References: <20261112031921.1255661-1-18255117159@163.com>
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
X-CM-TRANSID:_____wDXD8o6MPVqh72fHQ--.23678S3
X-Coremail-Antispam: 1Uf129KBjvJXoWrKw4rWrWxKrWxAFykCry7Awb_yoW8Jr15pF
	Z8CFyfGFWxGFnI9a4DXay8Cw4UWrWkWFW0grW3K3s0qa12ya4vvF909r17Jw13GrWvvr45
	A393KFZY9F4qya7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pR0tC7UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC6x0z1mr1MD0jJAAA3G

Add helper functions to clear or set bits in PCI config space.
These helpers reduce code duplication and improve readability for config
space modifications by encapsulating common read-modify-write patterns.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 include/linux/pci.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index aa3765a20a96..be277d745d5d 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1420,6 +1420,18 @@ static inline int pcie_capability_clear_dword(struct pci_dev *dev, int pos,
 	return pcie_capability_clear_and_set_dword(dev, pos, clear, 0);
 }
 
+static inline void pci_clear_config_dword(const struct pci_dev *dev, int pos,
+					  u32 clear)
+{
+	pci_clear_and_set_config_dword(dev, pos, clear, 0);
+}
+
+static inline void pci_set_config_dword(const struct pci_dev *dev, int pos,
+					u32 set)
+{
+	pci_clear_and_set_config_dword(dev, pos, 0, set);
+}
+
 /* User-space driven config access */
 int pci_user_read_config_byte(struct pci_dev *dev, int where, u8 *val);
 int pci_user_read_config_word(struct pci_dev *dev, int where, u16 *val);
-- 
2.43.0


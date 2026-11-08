Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794130882;
	b=UGloTdDmG2R/Da/AEwOBgldr8coYlpY3F7+6o9VcXcTIi84l3cZss8ui/1mp0iTkgPxt
	 kZye3kNe65Zi24NqoSn/SExRZmF6LG0Y88QZ6NtTcA2Tmd/mGsx0YnzzeDJhGRk9KosDp
	 hMWJ92CuMMp3iZQHSKdweNM7qaxD3stSBmPTD+EKfP8ZBTdQmxg7yNpNGrSEIrNIlnKPC
	 FMccNxFjvRVSPpNgFrMhI3Jw/gs8jHBzFDT3aJVl0PsC5BmsnFD0IXx75hOY3BtoW2Xdg
	 Td7XziiWukm7FJZwckr8QmftP93K69Iw5lVQCy2ZSGaLlXUL46yjxA67rGzQKzy8MZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794130882;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=nqXfJixZkwzDhIMorPPJ0dQ7Iu297y2SeiumQpEkZaA=;
	b=x7NA2gxT6419Ijwmt3c0TBx+5DujXtDQYjpipdxWm8/LlasOsRNeYj/qbO0OtYyLxpqj
	 Tyc60ssgC3tH4ocaA6DbfA9V4nM4jBYXg6Gk40GHSXqt5RPnDFvbCqqIieveOrYo9Yc+w
	 j6h3LH/OG6goe39vvipMp4TZm6wxpVsIcd8MrSIoZB52tVqI12P0mYajfUKgSu/4aXL0d
	 KHMlHIts580pUlGiGYc8C39+cHCrXwjtW0polpFBBzuiGwSDDv8zdkPRVGE2D7T+P5ZKa
	 EmpcbSJV+y8XOWesCINktX7pPezbbk/ZrF42p6msfSY+ur+SDKL3VwRo89rjsPo0dlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=cBh9bpcG;
	arc=none smtp.remote-ip=117.135.210.3
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1156E606A330;
	Sun,  8 Nov 2026 09:41:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1156E606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=cBh9bpcG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=nq
	XfJixZkwzDhIMorPPJ0dQ7Iu297y2SeiumQpEkZaA=; b=cBh9bpcGv0ec6LeAZy
	/wpRbvnAKKF9VHqBenBT4g0HgWXi2a8lSIXp2QWM7/PiwjfUd8mIYLNcsC/dj7hk
	7P7Trmoyge8faLqopeAMyQ3N3vt0KjBos9tAbTooX7+/PwgRM5UPqQ+zzQBf637w
	RFOV+mubefa7Q0yes8a5JhQ9o=
Received: from Precision-7960.. (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wCXz8OTQ_BquUg4GA--.62891S3;
	Sun, 08 Nov 2026 17:40:39 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com,
	mani@kernel.org,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	thierry.reding@kernel.org,
	ryder.lee@mediatek.com,
	jonathanh@nvidia.com
Cc: robh@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-tegra@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v2 1/5] PCI: Use pcie_get_link_speed() in pci.c
Date: Sun,  8 Nov 2026 17:40:30 +0800
Message-ID: <20261108094034.679945-2-18255117159@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261108094034.679945-1-18255117159@163.com>
References: <20261108094034.679945-1-18255117159@163.com>
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
X-CM-TRANSID:_____wCXz8OTQ_BquUg4GA--.62891S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7uFyDWF1rAryDXryftFWxtFb_yoW8Ar47pa
	y7C3W8Ar18Jr1fWF4rJan8Wr15X3Z3ZayxtrySgay8Wr17CrZxJFyFq3y3tr1SkrWDAry5
	G3ZIyrs8ua1xtF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRv385UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC7BfMcGrwQ5f4cwAA3C

Replace the to_pcie_link_speed() wrapper with pcie_get_link_speed() in
pcie_link_bandwidth_mbps() and pcie_bandwidth_available(), and remove
the now-unused wrapper.  pcie_get_link_speed() performs the same lookup
with bounds checking and is already exported.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/pci.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 7c6f2aba8144..92ede1768caf 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6025,11 +6025,6 @@ int pcie_set_mps(struct pci_dev *dev, int mps)
 }
 EXPORT_SYMBOL(pcie_set_mps);
 
-static enum pci_bus_speed to_pcie_link_speed(u16 lnksta)
-{
-	return pcie_link_speed[FIELD_GET(PCI_EXP_LNKSTA_CLS, lnksta)];
-}
-
 /**
  * pcie_link_bandwidth_mbps - get the current bandwidth of a single PCIe link
  * @pdev: PCI device to query
@@ -6048,7 +6043,7 @@ int pcie_link_bandwidth_mbps(struct pci_dev *pdev)
 	if (err)
 		return pcibios_err_to_errno(err);
 
-	speed = pcie_dev_speed_mbps(to_pcie_link_speed(lnksta));
+	speed = pcie_dev_speed_mbps(pcie_get_link_speed(FIELD_GET(PCI_EXP_LNKSTA_CLS, lnksta)));
 	if (speed < 0)
 		return speed;
 
@@ -6089,7 +6084,7 @@ u32 pcie_bandwidth_available(struct pci_dev *dev, struct pci_dev **limiting_dev,
 	while (dev) {
 		pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
 
-		next_speed = to_pcie_link_speed(lnksta);
+		next_speed = pcie_get_link_speed(FIELD_GET(PCI_EXP_LNKSTA_CLS, lnksta));
 		next_width = FIELD_GET(PCI_EXP_LNKSTA_NLW, lnksta);
 
 		next_bw = next_width * PCIE_SPEED2MBS_ENC(next_speed);
-- 
2.43.0


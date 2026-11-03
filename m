Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=204.191.154.188
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793728589;
	b=1VW3YrycsZhhx1oM/lCUUhapocPfgMErq7rT8+zWhHjS/OIB0VBAZ9PYgBvfj3psOULx
	 DyEsRJEUmlJDjYHNGiX3vRmV4qMZmgcjYp75an4y5Y8RqUw2ZZKJaBrUelbGVk3ZIOvio
	 JiTMAt0T7998/6CZrVM+SEUXzrB9F/bPHudkyp/94E96MTBHJo31QgSAl7KsbWRwFddf+
	 7RJgsZJvoZlmRXDfkO3R75wRzNnqSOdhGE6hDgpZYOYrlOMfTPX1O+r0SMItOuumbucHV
	 bLRZAhmHEhNg6YV/K1T+MVmPVF3OQo0/Y6KdCy+ucARn7ydBFc03FbQGrJINcYFEDKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793728589;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-SA-Exim-Connect-IP:X-SA-Exim-Rcpt-To:
	 X-SA-Exim-Mail-From:X-Spam-Checker-Version:X-Spam-Level:X-Spam-Status:
	 Subject:X-SA-Exim-Version:X-SA-Exim-Scanned;
	bh=Yf/qqkqFofhsr3Delloe8pHxnYHvcYzxk2CliuVMD5g=;
	b=3x2EraIf0Zl3ZbshwKlBaQoNGjS2jz/1ktLnJ3d00abiZN0drT8J8Lw+zGN1ljyysYv4
	 bF+91X0VDHZnr/QOTyWGzmgFR4xjG98P5CleP0QSzWcgeBwyzJh9f2Ff/+y6CxBO+Z9qj
	 hCu3bS/OAIhwLGdZ+h++BPpjFc+FdGhz8m48dP4LNQrJ7vmb8Mk+2P0aI9tyNhI7d3J4N
	 QJ5MkMtZR1ux5YQVKhxA46DP56uQYAj8SBH/PPtlipRZNFojOdqaVJuKzUV/MBkoL9t5T
	 uNIq73DaTFqz2+k+gtOJIO0s88tLOl00Nfh/owlh0U6DQ0tfFKfApV1RvSUP/7r4PyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=deltatee.com;
	spf=pass smtp.mailfrom=deltatee.com;
	dkim=pass header.d=deltatee.com header.i=@deltatee.com header.a=rsa-sha256 header.s=20200525 header.b=mq+qMFuI;
	arc=none smtp.remote-ip=204.191.154.188
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47807606A334;
	Tue,  3 Nov 2026 17:56:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47807606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=deltatee.com header.i=@deltatee.com header.a=rsa-sha256 header.s=20200525 header.b=mq+qMFuI
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Cc:To:From:content-disposition;
	bh=Yf/qqkqFofhsr3Delloe8pHxnYHvcYzxk2CliuVMD5g=; b=mq+qMFuInX4NhMf3EZzVSeeMAW
	YneP2u/6I9ryiZ3eWOCVIH7zZ/qt1jDiNgVlm9WsdLJ94zfLpPt8Fp72+Fb16ZrihWf8hLp/exKMl
	/8ZIMQiyaXkKm92qn2EVnRa2GIKZnuQ7jGhAW0+d1vHdQEiUOTxMtDBuh/xs0EB0JhD1fAFKiDB9B
	/q2zqbn3Yoz9M+NqQeiTMpZisenLqpqlmGMU+l3dInsLuWoHWtqJEHRREGvMBrKYgJ0Y3VYxv6yLy
	Srw5WeKcXravUNEFLZMutdpu2y78F9rEYSDuS8ChxmrED1J8jcwa/JacotV0sh3PRsFBq0F059HoX
	FJSRbe+w==;
Received: from donard.priv.deltatee.com ([172.16.1.31])
	by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1xOIkF-000000093O4-0jSj;
	Tue, 03 Nov 2026 11:56:28 -0600
Received: from logang by donard.priv.deltatee.com with local (Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1xOIjx-000000021CX-2PEK;
	Tue, 03 Nov 2026 11:56:09 -0600
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	dmaengine@vger.kernel.org,
	Vinod Koul <vkoul@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Frank Li <Frank.li@nxp.com>,
	Kelvin Cao <kelvin.cao@microchip.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Sashiko <sashiko-bot@kernel.org>
Date: Tue,  3 Nov 2026 11:52:08 -0600
Message-ID: <20261103175208.481170-3-logang@deltatee.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261103175208.481170-1-logang@deltatee.com>
References: <20261103175208.481170-1-logang@deltatee.com>
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
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, dmaengine@vger.kernel.org, bhelgaas@google.com, Frank.li@nxp.com, kelvin.cao@microchip.com, logang@deltatee.com, vkoul@kernel.org, sashiko-bot@kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: [PATCH 2/2] PCI: switchtec: Add Gen6 switches to NTB DMA alias quirk
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)

Add the Gen6 PFXs, PSXs, PFX and PSX switch device IDs (48XG6, 64XG6,
144XG6 and 160XG6) to the quirk_switchtec_ntb_dma_alias PCI fixup
table, matching the switchtec driver's PCI ID table. Without them, DMA
transactions from these switches' NTB function are not given the
correct requester ID alias, which can misdirect them under an IOMMU.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/patchset/20261103170033.471034-1-logang@deltatee.com?part=2
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/pci/quirks.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 7f1f47ea2ee4..3d92b99a4923 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -6250,6 +6250,22 @@ SWITCHTEC_QUIRK(0x5568);  /* PAXA 68XG5 */
 SWITCHTEC_QUIRK(0x5552);  /* PAXA 52XG5 */
 SWITCHTEC_QUIRK(0x5536);  /* PAXA 36XG5 */
 SWITCHTEC_QUIRK(0x5528);  /* PAXA 28XG5 */
+SWITCHTEC_QUIRK(0x6060);  /* PFXs 160XG6 */
+SWITCHTEC_QUIRK(0x6044);  /* PFXs 144XG6 */
+SWITCHTEC_QUIRK(0x6064);  /* PFXs 64XG6 */
+SWITCHTEC_QUIRK(0x6048);  /* PFXs 48XG6 */
+SWITCHTEC_QUIRK(0x6160);  /* PSXs 160XG6 */
+SWITCHTEC_QUIRK(0x6144);  /* PSXs 144XG6 */
+SWITCHTEC_QUIRK(0x6164);  /* PSXs 64XG6 */
+SWITCHTEC_QUIRK(0x6148);  /* PSXs 48XG6 */
+SWITCHTEC_QUIRK(0x6260);  /* PFX 160XG6 */
+SWITCHTEC_QUIRK(0x6244);  /* PFX 144XG6 */
+SWITCHTEC_QUIRK(0x6264);  /* PFX 64XG6 */
+SWITCHTEC_QUIRK(0x6248);  /* PFX 48XG6 */
+SWITCHTEC_QUIRK(0x6360);  /* PSX 160XG6 */
+SWITCHTEC_QUIRK(0x6344);  /* PSX 144XG6 */
+SWITCHTEC_QUIRK(0x6364);  /* PSX 64XG6 */
+SWITCHTEC_QUIRK(0x6348);  /* PSX 48XG6 */
 
 #define SWITCHTEC_PCI100X_QUIRK(vid) \
 	DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_EFAR, vid, \
-- 
2.47.3


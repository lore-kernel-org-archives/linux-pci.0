Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=204.191.154.188
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793725293;
	b=XQgCcyBo+i4bXcZo9Mqz012yuLr+W/sRbmRFB4arUQ++/CkeGQco4rw/C8YkqYj8fHp/
	 t3evt8zla+nOgTRcF85IDkM7dtkP2qkIrDS/M1fYww+OzCUV7rLw4/UyHEu9ji2QzFUT6
	 0q0XIDm/IZR2qnzvUW86Ocz4YlI/crmAbnmh7TJrxGnYh0Rrr/lRZZbT2HcLP06NgqAXv
	 a3ge49HLseO4KkflDtWCWhat5v6oE09v/lmBvxFduemHhVy3J9srjvXK4psRofqd8moTo
	 UiTWBzPJqXT4l4ADvED7COe7c19EfsZYTeIAIUxlkzsdMDxAxNZZvjJXPugnhxRx84Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793725293;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-SA-Exim-Connect-IP:X-SA-Exim-Rcpt-To:
	 X-SA-Exim-Mail-From:X-Spam-Checker-Version:X-Spam-Level:X-Spam-Status:
	 Subject:X-SA-Exim-Version:X-SA-Exim-Scanned;
	bh=jZ8Fk8CbRGvjUDo8rrv4N7qLq5wGiuB416ONtNyImdM=;
	b=UMrDmU+wi7nwXlY8nAiGdZDsgAO8llmPDOcoGuOTepk2cc8D13Ab+JcdmUpczJTwEPp9
	 TqB1vBMAJatYtHHWGh/FsIU5yqVeQVOmS08BiqanOnQvDlpdzNGE1zdwsTGsXb46NGEMy
	 cc2c2SiOdaedhKKm878sb9+m+pHeOAa3S2/cCNeAefUpJWDrneNHfL+RK1yZ/YRX+fc9M
	 Wc/IbVG6zQqdtRtLQUNz/2gKgmXoznVK1zv7p1gwXrARXiDz5OFHggTTx3v+bufnF5Nj/
	 UUlWLbd/C6wnspoEX5QNDqieTcy2mcfdCqX2iHxFczm0WBwtrFETxSIkb99DVWe520w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=deltatee.com;
	spf=pass smtp.mailfrom=deltatee.com;
	dkim=pass header.d=deltatee.com header.i=@deltatee.com header.a=rsa-sha256 header.s=20200525 header.b=AiNSEKiL;
	arc=none smtp.remote-ip=204.191.154.188
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D21606D803;
	Tue,  3 Nov 2026 17:01:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41D21606D803
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=deltatee.com header.i=@deltatee.com header.a=rsa-sha256 header.s=20200525 header.b=AiNSEKiL
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Cc:To:From:content-disposition;
	bh=jZ8Fk8CbRGvjUDo8rrv4N7qLq5wGiuB416ONtNyImdM=; b=AiNSEKiL1uRgqaaCZNOZs7ajHC
	q1WYaCZBWfwc8ka/uNn4VJdMhKR22c4Z9wthPak6YN4KuNWD5+nBwuW5dbS2DxnNFQNSkN1/1TOV6
	vmHXWhXj2BN6QcfNLifcTSpTApPkiH1sMKolEwTkP7gOsmZElNSByS1iESx6gzdy8LsWn2o/gk0mS
	Gh/EBm8iYmKAlx6syXAtoP+69Z3mt3JzW04aYiwbq5gT3/5qGjzXN2pbnB8Glt8XyU5rvpHe/8Ul3
	6pVyjDqwKc81Yu4mNzkU6DocioZSI4WTiouD3Umw4X3AbMiB4CifRjCtMXqLmeJaJDtzn62v+16qZ
	waZ9PFeA==;
Received: from donard.priv.deltatee.com ([172.16.1.31])
	by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1xOHt5-000000092Tv-1NN2;
	Tue, 03 Nov 2026 11:01:32 -0600
Received: from logang by donard.priv.deltatee.com with local (Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1xOHsC-00000001yXe-3KGM;
	Tue, 03 Nov 2026 11:00:36 -0600
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	dmaengine@vger.kernel.org,
	Vinod Koul <vkoul@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Frank Li <Frank.li@nxp.com>,
	Kelvin Cao <kelvin.cao@microchip.com>,
	Logan Gunthorpe <logang@deltatee.com>
Date: Tue,  3 Nov 2026 11:00:33 -0600
Message-ID: <20261103170033.471034-3-logang@deltatee.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261103170033.471034-1-logang@deltatee.com>
References: <20261103170033.471034-1-logang@deltatee.com>
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
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, dmaengine@vger.kernel.org, vkoul@kernel.org, bhelgaas@google.com, Frank.li@nxp.com, kelvin.cao@microchip.com, logang@deltatee.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: [PATCH 2/2] PCI: switchtec: Add Gen6 secure switches to NTB DMA alias quirk
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)

Add the Gen6 PFXs and PSXs secure switch device IDs (48XG6 and 64XG6)
to the quirk_switchtec_ntb_dma_alias PCI fixup table. Without them,
DMA transactions from these switches' NTB function are not given the
correct requester ID alias, which can misdirect them under an IOMMU.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/pci/quirks.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 7f1f47ea2ee4..691eff466d9c 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -6250,6 +6250,10 @@ SWITCHTEC_QUIRK(0x5568);  /* PAXA 68XG5 */
 SWITCHTEC_QUIRK(0x5552);  /* PAXA 52XG5 */
 SWITCHTEC_QUIRK(0x5536);  /* PAXA 36XG5 */
 SWITCHTEC_QUIRK(0x5528);  /* PAXA 28XG5 */
+SWITCHTEC_QUIRK(0x6064);  /* PFXs 64XG6 */
+SWITCHTEC_QUIRK(0x6048);  /* PFXs 48XG6 */
+SWITCHTEC_QUIRK(0x6164);  /* PSXs 64XG6 */
+SWITCHTEC_QUIRK(0x6148);  /* PSXs 48XG6 */
 
 #define SWITCHTEC_PCI100X_QUIRK(vid) \
 	DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_EFAR, vid, \
-- 
2.47.3


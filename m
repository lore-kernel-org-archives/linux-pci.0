Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4022EB5B8;
	Tue, 14 Jul 2026 21:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784064023; cv=none; b=Cvh/yQ0gk6nVO/JHOQg4D8rrBq0IYoKPOZYmt0ZX1M2iqwdBESvVoAWolLUOlOgdo0eFke7qdXhtrG2tI4xsBlvMm06CcFq7P8sOrG3VPXJWGNIEp+Ms7sGsRidu9Gr/wDV5eonqFH4msrgiSdaXg88cV9LScMy6BVFgLTiIZks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784064023; c=relaxed/simple;
	bh=kNS6zKA1ZHEOs+HPsSz0FF+VoL2iShCxzmgKSvSke9A=;
	h=From:To:Cc:Date:Message-ID:In-Reply-To:References:MIME-Version:
	 Subject; b=ixFPnMsvkkpKMqmQHco27EuSrnSl5zLhcGilc3GSTHbp3FYYh2y9tnRF3g7JubLBECUthsSRzTCCR79lEAO8GMPe540OUO5fSdS+DjePcrB3ZE3+Dm+/mNINlnqceHGKy6NXYOs6GxabbEbq4b+peD17dvP8qHUvChWvPZGfrXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=tPOku6m9; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="tPOku6m9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Cc:To:From:content-disposition;
	bh=toZEwMfCDeyvIyQAWQUFhvL7a4ZEaRICIBYlWYODutU=; b=tPOku6m9k6oK9wKQ4f2YvISvkj
	XOzxCxJmcsjAr5lGCStHdG9wRj36hPVgphTCNmDInxkNic2sjRNZYc6yFh3j0LYzZ23G25G6TjXc1
	/K7MzNrnIJcGc0ZavEVlkX0YjkVTgdoM6bDThn5C3WK9o5IVChL354yJUz8IDN+voW1WdBsxPj9ja
	kJfxUGvQay/bquOLj9uzfTXuhUiLkXe7DK/hD4bKlFnqf3xueiGJo3x8iTBRBL/LCkIG4H7gciPtV
	HiqFIFlTO2r8q34HIAPwjUzqJzSDUca2OROQtD7JI51sefp0z79pQ9HgqL58jK7uSOnxv21gONU6Z
	8RfCENQQ==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
	by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1wjkY3-00000006f2Q-14ho;
	Tue, 14 Jul 2026 15:20:15 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.98.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1wjkY1-00000000xzo-3erv;
	Tue, 14 Jul 2026 15:20:13 -0600
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	dmaengine@vger.kernel.org,
	Vinod Koul <vkoul@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Frank Li <Frank.li@nxp.com>,
	Kelvin Cao <kelvin.cao@microchip.com>,
	Logan Gunthorpe <logang@deltatee.com>
Date: Tue, 14 Jul 2026 15:20:08 -0600
Message-ID: <20260714212010.230606-2-logang@deltatee.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260714212010.230606-1-logang@deltatee.com>
References: <20260714212010.230606-1-logang@deltatee.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, dmaengine@vger.kernel.org, vkoul@kernel.org, bhelgaas@google.com, Frank.li@nxp.com, kelvin.cao@microchip.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Level: 
Subject: [PATCH v1 1/3] dmaengine: switchtec-dma: Add PCI1008 device ID
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)

Add the PCI1008 device ID for switchtec-dma.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/dma/switchtec_dma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/switchtec_dma.c b/drivers/dma/switchtec_dma.c
index 3ef928640615..02083e3f6ebe 100644
--- a/drivers/dma/switchtec_dma.c
+++ b/drivers/dma/switchtec_dma.c
@@ -1424,6 +1424,7 @@ static const struct pci_device_id switchtec_dma_pci_tbl[] = {
 	SW_ID(PCI_VENDOR_ID_EFAR,      0x1004), /* PCI1004 16XG4 */
 	SW_ID(PCI_VENDOR_ID_EFAR,      0x1005), /* PCI1005 16XG4 */
 	SW_ID(PCI_VENDOR_ID_EFAR,      0x1006), /* PCI1006 16XG4 */
+	SW_ID(PCI_VENDOR_ID_EFAR,      0x1008), /* PCI1008 16XG4 */
 	{0}
 };
 MODULE_DEVICE_TABLE(pci, switchtec_dma_pci_tbl);
-- 
2.47.3


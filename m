Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D338433E62;
	Mon, 27 Jul 2026 18:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785176134; cv=none; b=r3idQf0dEJwUqo1ZSwHYU7Zl+jCf2zShZV68f2NcCA/17WplSwaRV5z7PM6ebUb11nfFnbiAUuSGpHEXiGF4eaiX4p9AxZxQt4j6kBf1AFY1y4bWHhQEWWx3Qg20P/ozvw2et90t7jaPis8fGVaocgXUWbQg9o0GOrIZIItWrPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785176134; c=relaxed/simple;
	bh=OXiPslDd2o9nSTRGWT1ePajAd8DDFmGsNGGdCZU8e9M=;
	h=From:To:Cc:Date:Message-ID:In-Reply-To:References:MIME-Version:
	 Subject; b=o6GLEFMJHtXpvHX+Li6wE+nRe6G1CLjO2tfpOSD319zHyMSvAdXStRUjTgLAP2ajQGCtCkS3jNIEKFXmierWA/9cs4IXAaZ/BApITUh6jUrvgXu7U4Qrx/tWGBXzmcsKMIYrt0DMTLCoOCMegz9N+nsBgg1xQhjag7bdv+QrXnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=mjuaNKhF; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="mjuaNKhF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Cc:To:From:content-disposition;
	bh=SeOtga1zPuUE5+/HFLKP8aGr+Bai6ulg3V4WQ65UbGo=; b=mjuaNKhFiliFXQzYLwiolxl6Nv
	jCejsE+Ly01ZDzLoVGoSoxbC0J6yMnXgRTL2EZn3PFHzVvQphaRDDopuSNZeUZLK4NH1E/LvicU6P
	FEs4gqJBru5PmYfl40A3p3jFb0KrHs3E/vquDjq2SL2WLgX2xnqzgZUrIWXJzTK36zXL4MxLXUkh3
	z0H1+dRUU9bd6aRGAKN+GnEgUVFnP2DhvhN82ekohJHxHoKZ4ILytf6hRmRSCmhg68O+e4ObAtziz
	J+B06XY7Vak/qCcNxlKUNngSmCf0yKsNdrieHH8B1+80T6IroVmbTisdC83fgaiTI/XtVflvpGIxJ
	DgJjtaZw==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
	by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1woPrP-000000004xD-2pGU;
	Mon, 27 Jul 2026 12:15:32 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.98.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1woPrN-000000002Wl-1DDx;
	Mon, 27 Jul 2026 12:15:29 -0600
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	dmaengine@vger.kernel.org,
	Vinod Koul <vkoul@kernel.org>
Cc: Frank Li <Frank.li@nxp.com>,
	Kelvin Cao <kelvin.cao@microchip.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Dave Jiang <dave.jiang@intel.com>,
	George Ge <george.ge@microchip.com>,
	Jaeyoung Chung <jjy600901@snu.ac.kr>,
	Logan Gunthorpe <logang@deltatee.com>,
	Sashiko <sashiko-bot@kernel.org>
Date: Mon, 27 Jul 2026 12:15:18 -0600
Message-ID: <20260727181526.9672-4-logang@deltatee.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260727181526.9672-1-logang@deltatee.com>
References: <20260727181526.9672-1-logang@deltatee.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, dmaengine@vger.kernel.org, Frank.li@nxp.com, linux@weissschuh.net, dave.jiang@intel.com, kelvin.cao@microchip.com, george.ge@microchip.com, jjy600901@snu.ac.kr, logang@deltatee.com, vkoul@kernel.org, sashiko-bot@kernel.org
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Level: 
Subject: [PATCH v3 03/11] dmaengine: switchtec-dma: halt channel on alloc_chan_resources error
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)

The error-unwind path called disable_channel() before freeing the
descriptor rings, but that only clears the enable bit with an
unflushed write -- it doesn't halt the channel or clear its DMA base
address registers. If unhalt_channel() timed out, the channel's actual
state is unknown at that point, so nothing guarantees the hardware
isn't still touching the rings when they're freed.

Call switchtec_dma_chan_stop() first, matching what
switchtec_dma_free_chan_resources() already does before freeing
descriptors on the normal teardown path: it synchronously halts the
channel and zeroes the DMA base registers.

Fixes: 30eba9df76ad ("dmaengine: switchtec-dma: Implement hardware initialization and cleanup")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://lore.kernel.org/dmaengine/20260717223647.F0A051F000E9@smtp.kernel.org
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/dma/switchtec_dma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/switchtec_dma.c b/drivers/dma/switchtec_dma.c
index f77da31aeb65..107769cca772 100644
--- a/drivers/dma/switchtec_dma.c
+++ b/drivers/dma/switchtec_dma.c
@@ -1040,6 +1040,7 @@ static int switchtec_dma_alloc_chan_resources(struct dma_chan *chan)
 	swdma_chan->comp_ring_active = false;
 	spin_unlock_bh(&swdma_chan->complete_lock);
 err_disable_channel:
+	switchtec_dma_chan_stop(swdma_chan);
 	disable_channel(swdma_chan);
 err_free_desc:
 	switchtec_dma_free_desc(swdma_chan);
-- 
2.47.3


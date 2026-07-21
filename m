Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACA046A5EE;
	Tue, 21 Jul 2026 16:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784650205; cv=none; b=jZat+aXaykE9qpEMspqJfyBAxB4Rv35wXKBiW7H4ANWxfkSqpw32f4CS6fdjwytAQkzGGo8ABRINeQMLPxDM/FQS9ykB7vQ25YB0qrdhV/DrwWLXVd93hHh/iedZ8dKe16XKx6NaP6T9J480OMmwm5HnoedF8BQJRTOXouQGo+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784650205; c=relaxed/simple;
	bh=OXiPslDd2o9nSTRGWT1ePajAd8DDFmGsNGGdCZU8e9M=;
	h=From:To:Cc:Date:Message-ID:In-Reply-To:References:MIME-Version:
	 Subject; b=AneKgjJe+QPJiuHhO/nUndbH13XVZ2NpD9DNJMzhKsos9b4F8PvSiScyXrmm7vfpnPQDX4hmzn090NdGc/TbCARQOVJFeInn/L/u+Jw5Oc5OOCx2VJw/XZJMUKaFFiEmRFOKS94pqeSvBK8hfBZnPbtjZd1sXLCvKK9QgKxETJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=q/A3u276; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="q/A3u276"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Cc:To:From:content-disposition;
	bh=SeOtga1zPuUE5+/HFLKP8aGr+Bai6ulg3V4WQ65UbGo=; b=q/A3u276HaU1DMGldNayGZuFc7
	I7WC7X/LeLldKaV87OJkNXn7jN2bwAyhI8o3iHiumqGCPKU1DnMASpD/594hrHk9PC2g6f3EUMLb0
	l9FlzC04Tfv1afvr4Ed+BKsCFgXP8Eww1VxdNAV1Dbjae/Il/xtB+o9IsFM3lUT6O8kkfpdAAaUHz
	rnkM+gM/+dreBLLBhPw/NvDeBBYpikONDjtXSfHWL0rWWrqcU9FEsvvOk3g07R8ILvDd+CZ//ircC
	sFpFNGO+Xqf9A97DlaYqHDTp4kt+asTiiz7TVbeLzodr5I9viNnGJ03gnpOs+Yzi2cOc4aveIL8hu
	woqMw4vw==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
	by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1wmD2Y-0000000BodM-1gKO;
	Tue, 21 Jul 2026 10:09:55 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.98.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1wmD2U-00000000GBS-09zh;
	Tue, 21 Jul 2026 10:09:50 -0600
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
Date: Tue, 21 Jul 2026 09:57:30 -0600
Message-ID: <20260721155739.62120-4-logang@deltatee.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260721155739.62120-1-logang@deltatee.com>
References: <20260721155739.62120-1-logang@deltatee.com>
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
Subject: [PATCH v2 03/11] dmaengine: switchtec-dma: halt channel on alloc_chan_resources error
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


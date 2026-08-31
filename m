Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397BB38AC97;
	Mon, 31 Aug 2026 19:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788203671; cv=none; b=bnm3jmTZ/5qIIQ85UPb8rS5eUhFriVQ4NzhFZg1DqT4gBCx3ditq2o7Gg57fb3BJ2VArz7rZEVxbDdlrgbBT2Tv8JphcEqnUywCTFzut0AoK4qX+dGwdjwEOpNHfeWuk6sve+J8fWa6DYyWP94ID0quoaK8woNC0kpdVwj3Ijrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788203671; c=relaxed/simple;
	bh=Yt16DRCIW4S29RsFvOF6gZmQNYzovey0eIt9ACqbLGY=;
	h=From:To:Cc:Date:Message-ID:In-Reply-To:References:MIME-Version:
	 Subject; b=jwdlps3FEInJrT8GHbnDTDTHVRG9QuVV8ZRVVXM/w7Beemo5L9XZ+Jxpl4wfcQfFSSpwJTjpV4rU5/+k9QB678X92crywFp6T+ZZlCUMMkQd7mhI4QFJwd9HmLutYA8Xx5f+Z2GgD8k8tBEzT7WuFKdYtb5Qpw8sXJHmKZjeU58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=e3+MeVna; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="e3+MeVna"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Cc:To:From:content-disposition;
	bh=BOX/jaXh913y/cVufoW4N9AtktT2hTl23FLqu47NVNU=; b=e3+MeVnaeXHZNzaSaOHV7WmrZt
	nBGoNfJTKGWanFqnW6pR/jIwPGjrwuFLMvdiobvCtPh30FqCdFFyR/Lqd9dOoQ+BGNJ841O8Vr1DD
	s90HZL6MGjGvego52ILhWwYB2tfJp5mZ1sBNSPo3fU1UKsgZtt4xGAzGHTgjnIODKQxfM6Wu6Kx4P
	upd3gkqWQb/5ZDxzAVHz0X6QPgLiu9o6MdxKAC/I988EMAXsBv4q1Z9Oi67KphPmvbxUw9LNBjPE5
	nhLEK+yXorxI9/EPQLNXv9lBggvpymiVkicyoRs1RL72sF1QawSlVYgF541uqBsfkDKjjQkVc5Rzf
	yuyQQBDA==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
	by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1x17SX-000000007CR-3xh8;
	Mon, 31 Aug 2026 13:14:22 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.98.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1x17SH-00000000s1b-3gSn;
	Mon, 31 Aug 2026 13:14:05 -0600
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
Date: Mon, 31 Aug 2026 13:13:54 -0600
Message-ID: <20260831191403.207631-5-logang@deltatee.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260831191403.207631-1-logang@deltatee.com>
References: <20260831191403.207631-1-logang@deltatee.com>
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
Subject: [PATCH v5 04/12] dmaengine: switchtec-dma: halt channel on alloc_chan_resources error
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
channel and zeroes the DMA base registers. If the halt itself can't be
confirmed, skip freeing the descriptor rings (leaking them instead).

All this is hardening that is pretty unlikely to be hit in the real
world. However, it is correct and the best thing to do against buggy
hardware that doesn't tear down correctly and could still write to
memory. In this unlikely situation it is better to leak the memory
than have hardware randomly trash memory that has already been used
for something else.

Fixes: 30eba9df76ad ("dmaengine: switchtec-dma: Implement hardware initialization and cleanup")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://lore.kernel.org/dmaengine/20260717223647.F0A051F000E9@smtp.kernel.org
Link: https://lore.kernel.org/dmaengine/20260727185101.D221C1F000E9@smtp.kernel.org
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/dma/switchtec_dma.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/dma/switchtec_dma.c b/drivers/dma/switchtec_dma.c
index e2bb65237d2c..2d5ba194c99a 100644
--- a/drivers/dma/switchtec_dma.c
+++ b/drivers/dma/switchtec_dma.c
@@ -1047,6 +1047,10 @@ static int switchtec_dma_alloc_chan_resources(struct dma_chan *chan)
 	swdma_chan->comp_ring_active = false;
 	spin_unlock_bh(&swdma_chan->complete_lock);
 err_disable_channel:
+	if (switchtec_dma_chan_stop(swdma_chan)) {
+		disable_channel(swdma_chan);
+		return rc;
+	}
 	disable_channel(swdma_chan);
 err_free_desc:
 	switchtec_dma_free_desc(swdma_chan);
-- 
2.47.3


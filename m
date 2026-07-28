Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21AAA3A6B9D;
	Tue, 28 Jul 2026 17:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785259245; cv=none; b=OzE8E5Ma5+YunXiiawPTHK7GUbGwNZ/2oKp59bKItDkIdZC3TNn//UHdtddK94MAmbalGUQ+bviT5WFJvOIWFLrW/grV/ZPJqCHJtLlc91WV+DXygVUM+NuV4olFQe37LceLdcCDsiFiOM2yZXShs61a9DAjpeqFpI+PvbO5Oww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785259245; c=relaxed/simple;
	bh=EpJKXuUKfCjQ+Uyb7wEZC1J+kCTCkHeAGk+BwiqrR/k=;
	h=From:To:Cc:Date:Message-ID:In-Reply-To:References:MIME-Version:
	 Subject; b=R+0qm4fB+5EgUaPpv3FmZL9uvwv9AdD3VAtaC8kSX5wgQ9Y39a+I/zEnzoyG8PTgCME/ZIZCnjKK/+CAbrt2PeliocN4EyoHld7hSj22I4UMKWm2ngRoydBPp4vodvTQNyFDbqHwqFYQMFDWb2PpisCCaMrV89b9b1gT2xdu2MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=ofdj+wr9; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="ofdj+wr9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Cc:To:From:content-disposition;
	bh=Zp9n5x1QferfNLKG1kakgRsj/VQ19UMQKEuonnjsNmk=; b=ofdj+wr9FPvwOPqppi37PVNj8X
	o0cBGz9cmR4W2U95geJnIhf9Ihdyg7Fp51ui/msbdKUKsFavWvTAS2X4dggqUcJ18gv33eCk3M/rx
	RI0MNue6MD8rka+36VhPKXhN59e+3s55N/bBofR15cCRPVaoLZpMRMiQh4WEwtJFUv2ugmrEo6Y7b
	NsGc4PSQt9kbSoVtTHQ5OwVR03FSV9syIGqRETYKH/hB+4bubX7uN2R9cpT2V7Mnj5ktItknv3Oqn
	3ZKo+Gy9ZnzMIucxo8O/5aWNbGU/U11V4c8u2KtUUCDU8EsQTqiRvjCBlDVZR7mQg0XMQWDHZJsoD
	YhT5g0PA==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
	by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1wolTu-00000000oZj-34Au;
	Tue, 28 Jul 2026 11:20:43 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.98.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1wolOp-00000000TDG-2v0z;
	Tue, 28 Jul 2026 11:15:27 -0600
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
Date: Tue, 28 Jul 2026 11:15:15 -0600
Message-ID: <20260728171523.112244-5-logang@deltatee.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728171523.112244-1-logang@deltatee.com>
References: <20260728171523.112244-1-logang@deltatee.com>
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
Subject: [PATCH v4 04/12] dmaengine: switchtec-dma: halt channel on alloc_chan_resources error
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

Fixes: 30eba9df76ad ("dmaengine: switchtec-dma: Implement hardware initialization and cleanup")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://lore.kernel.org/dmaengine/20260717223647.F0A051F000E9@smtp.kernel.org
Link: https://lore.kernel.org/dmaengine/20260727185101.D221C1F000E9@smtp.kernel.org
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/dma/switchtec_dma.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/dma/switchtec_dma.c b/drivers/dma/switchtec_dma.c
index cbbc9ad08247..25b988e9b4af 100644
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


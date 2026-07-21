Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513393E49E5;
	Tue, 21 Jul 2026 16:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784650474; cv=none; b=G0XcQoKNgPytmk61oInmHI77A44ZjudymwdgJ7eYLewI3dQehQEwjn9oAl81dbWljIbbnY4dlQkgOqFM67KlKJq5R/RVLFjnC0J5oOI67dV6PA5jw4uKsmY+Cf1ktcBv1L18D5K5mlYME+hRzuojlNBBY0n0dlwn+W6Yg8/1yTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784650474; c=relaxed/simple;
	bh=xQHe7eXkeemYxcNswwPDyGnqFqZb4aGiJ+TWGXQJ8N0=;
	h=From:To:Cc:Date:Message-ID:In-Reply-To:References:MIME-Version:
	 Subject; b=KCsY9cNkhy1TfAJSUoNVzx4u0nGLWGeF/ggpkGf8tn6EC9pLVLjbauzh0Gmh9Pi9fP9sLVx0Abasn4Uc5HrjuSK5rixb6Z6H6vtnnut+BCSqoABCzXr9y16FWOOqXsSrADHrZZzPyVtdUxiHzqIOjDfrj5s7GP+9yGmgUW6zUZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=HEgdJMfD; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="HEgdJMfD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Cc:To:From:content-disposition;
	bh=ZCcDH99LMfELnB0BvCDYj0sMVwL9rjCspO5GmoWat6s=; b=HEgdJMfD38iKEbtemtdJWmPkiw
	/yj+TtO/O50xxZtlCvYsRmMcqhrOjn99uZV4SL2vxlCfyH8Sov3Ph7Zvv4W1kz+xPLVLIjV8LExwK
	4D192TObmaetu9cFrT36KRS1YkF0Rh41Z1B2woxXP+p5Hc4F6lnEAPZASHLCUGAlL2XKepkF8vRAV
	fVTyBIHmN8SekvtErfOwlvROtbWbjFhSWsUVGJ18zkDxL04+o7Mcl6QX1JRWZLFPptD4oyadHEdJQ
	+vldr45qgopglUf8lw9Y1SqnQGbAgLunf3G8WBODBnzsz1OJNgsmbQxkwRwfUA++fcuqDgci2qF6r
	gwJbF1Bg==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
	by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1wmD71-0000000Bogv-0LVD;
	Tue, 21 Jul 2026 10:14:31 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.98.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1wmD2U-00000000GBe-1vCF;
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
Date: Tue, 21 Jul 2026 09:57:33 -0600
Message-ID: <20260721155739.62120-7-logang@deltatee.com>
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
Subject: [PATCH v2 06/11] dmaengine: switchtec-dma: unlink channels before freeing on registration failure
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)

When switchtec_dma_create() fails after channels have been added to
dma_dev->channels (either from switchtec_dma_chans_enumerate()'s own
error path, or from dma_async_device_register() failing), the channels
are released and freed but never removed from dma_dev->channels.

The channel status IRQ is already live at this point, and its handler
walks dma_dev->channels, so it can dereference a freed channel.

Add switchtec_dma_chans_unlist() and call it before releasing and
freeing channels in both error paths.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://lore.kernel.org/dmaengine/20260717223431.625EE1F000E9@smtp.kernel.org
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/dma/switchtec_dma.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/dma/switchtec_dma.c b/drivers/dma/switchtec_dma.c
index c752a1b05871..2a1ae27bd1a6 100644
--- a/drivers/dma/switchtec_dma.c
+++ b/drivers/dma/switchtec_dma.c
@@ -1184,6 +1184,14 @@ static void switchtec_dma_chans_free(struct switchtec_dma_dev *swdma_dev)
 	kfree(swdma_dev->swdma_chans);
 }
 
+static void switchtec_dma_chans_unlist(struct switchtec_dma_dev *swdma_dev)
+{
+	int i;
+
+	for (i = 0; i < swdma_dev->chan_cnt; i++)
+		list_del(&swdma_dev->swdma_chans[i]->dma_chan.device_node);
+}
+
 static int switchtec_dma_chans_enumerate(struct switchtec_dma_dev *swdma_dev,
 					 struct pci_dev *pdev, int chan_cnt)
 {
@@ -1217,6 +1225,7 @@ static int switchtec_dma_chans_enumerate(struct switchtec_dma_dev *swdma_dev,
 	return chan_cnt;
 
 err_exit:
+	switchtec_dma_chans_unlist(swdma_dev);
 	switchtec_dma_chans_release(pdev, swdma_dev);
 	switchtec_dma_chans_free(swdma_dev);
 
@@ -1318,6 +1327,7 @@ static int switchtec_dma_create(struct pci_dev *pdev)
 	return 0;
 
 err_chans_release_exit:
+	switchtec_dma_chans_unlist(swdma_dev);
 	switchtec_dma_chans_release(pdev, swdma_dev);
 	switchtec_dma_chans_free(swdma_dev);
 
-- 
2.47.3


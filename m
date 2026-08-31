Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD522C026C;
	Mon, 31 Aug 2026 19:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788203668; cv=none; b=iNgVdGJwDEmgVJqac5fwdS1vkLowCnNFZ/hOP+zQ9lw3m6Y8uw5cK9MluarwDEbKOyfIUYoPqPCcB92Uy6PT6z9vO80gi1FAN2ZDFsgEirrtkoFtAsnhG4khgfBe7wJ8BT0hV/BWt0nhdWqYFplfR0fJO0NzSvPCreLNZF3iurI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788203668; c=relaxed/simple;
	bh=79mYpblsmiFWw8Bbx73RKfKeWgDVSiOSpcI2GZ4zFVc=;
	h=From:To:Cc:Date:Message-ID:In-Reply-To:References:MIME-Version:
	 Subject; b=Fw+UwhKBUur0xZNj0C3dEt4ZES6ZAWixrQmhAdf48VFWNUUr3s5uNu8YZIiIphMFccR/9D3ugFRtyva37Kahy+yxR5kqUT26Ip7j/4YxSEedM2m/lTvTnW4QyF0mS5ZXfS1JprmABdL4/dG+MmZKdw1qBRpDZuirP+8hoQE4+ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=TG4tak9S; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="TG4tak9S"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Cc:To:From:content-disposition;
	bh=Aaf6JxG1s0jf/AwW6M43JQGZZntdld7FYYVpfPheOg0=; b=TG4tak9SUxWempf10qjNAOP0kc
	5p38jXv8sDYj/GMr0CeJOPxsEcQu3rZHxV0kvzySDGNvMTRkMvMttetTRRKRsbLaEVHFnVr42i0u4
	B9N4td1DZX4pezlnTdz6/PSBMhjoZYyVBOh7IpP7iRu29wWe4xCXScGtWMSb7HqsO3tIWFty6I6Bc
	OdQBXKF11Df/d4BVUpRJWvFnXe6d+GNi+4D5z2bM3vBkzbs5Ex6ke7gtE0kaUUCGwyuNrFV8l06a6
	eewusZEQLN7RK9oBIIGwmlEy6l3OGRbvdtzIHvq93W+RsL8ecXan020k6yYijxusDg9MBl37znWCb
	QQrIgPXg==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
	by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1x17Sb-000000007DZ-0vVO;
	Mon, 31 Aug 2026 13:14:25 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.98.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1x17SI-00000000s1j-2AK7;
	Mon, 31 Aug 2026 13:14:06 -0600
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
	Sashiko <sashiko-bot@kernel.org>,
	Frank Li <Frank.Li@nxp.com>
Date: Mon, 31 Aug 2026 13:13:58 -0600
Message-ID: <20260831191403.207631-9-logang@deltatee.com>
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
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, dmaengine@vger.kernel.org, linux@weissschuh.net, dave.jiang@intel.com, kelvin.cao@microchip.com, george.ge@microchip.com, jjy600901@snu.ac.kr, logang@deltatee.com, vkoul@kernel.org, sashiko-bot@kernel.org, Frank.li@nxp.com, Frank.Li@nxp.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Level: 
Subject: [PATCH v5 08/12] dmaengine: switchtec-dma: disable channels before freeing on registration failure
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)

When switchtec_dma_create() fails after channels have been added to
dma_dev->channels (either from switchtec_dma_chans_enumerate()'s own
error path, or from dma_async_device_register() failing), the channel
status IRQ is still live while the channels are released and freed,
so it can fire mid-teardown against channels that are only partially
torn down.

Add switchtec_dma_chans_disable(), which frees the channel status IRQ
before releasing and freeing channels in both error paths.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://lore.kernel.org/dmaengine/20260717223431.625EE1F000E9@smtp.kernel.org
Link: https://lore.kernel.org/dmaengine/20260721162822.05CDD1F000E9@smtp.kernel.org
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/dma/switchtec_dma.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/dma/switchtec_dma.c b/drivers/dma/switchtec_dma.c
index 3068d9de4e6d..c2803af6589d 100644
--- a/drivers/dma/switchtec_dma.c
+++ b/drivers/dma/switchtec_dma.c
@@ -1198,6 +1198,15 @@ static void switchtec_dma_chans_free(struct switchtec_dma_dev *swdma_dev)
 	kfree(swdma_dev->swdma_chans);
 }
 
+static void switchtec_dma_chans_disable(struct pci_dev *pdev,
+					struct switchtec_dma_dev *swdma_dev)
+{
+	if (swdma_dev->chan_status_irq >= 0) {
+		pci_free_irq(pdev, swdma_dev->chan_status_irq, swdma_dev);
+		swdma_dev->chan_status_irq = -1;
+	}
+}
+
 static int switchtec_dma_chans_enumerate(struct switchtec_dma_dev *swdma_dev,
 					 struct pci_dev *pdev, int chan_cnt)
 {
@@ -1231,6 +1240,7 @@ static int switchtec_dma_chans_enumerate(struct switchtec_dma_dev *swdma_dev,
 	return chan_cnt;
 
 err_exit:
+	switchtec_dma_chans_disable(pdev, swdma_dev);
 	switchtec_dma_chans_release(pdev, swdma_dev);
 	switchtec_dma_chans_free(swdma_dev);
 
@@ -1334,6 +1344,7 @@ static int switchtec_dma_create(struct pci_dev *pdev)
 	return 0;
 
 err_chans_release_exit:
+	switchtec_dma_chans_disable(pdev, swdma_dev);
 	switchtec_dma_chans_release(pdev, swdma_dev);
 	switchtec_dma_chans_free(swdma_dev);
 
-- 
2.47.3


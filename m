Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E65C38DC5B;
	Mon, 31 Aug 2026 19:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788203672; cv=none; b=dI5hPklBKfMCx5Uew+w53PPjrAn0EDp7Dq0oZKvB5oq8sLpBLyAElp80Z+vIslMIE+Jo9GWFWUhLxrOf3Fd4mvXVzm/JpdVxKj54O5xeDCKfG/LNID8o6Bsbmmoq44arF0UQflfk9E8F45W3a5OJW2OYt+35MYa4ad0WUxSYf+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788203672; c=relaxed/simple;
	bh=qCIjXzG6t/QDzZhChzNlq+uRjKyoa/pdmJLAcLkoEQs=;
	h=From:To:Cc:Date:Message-ID:In-Reply-To:References:MIME-Version:
	 Subject; b=aiJtjtyek/4apvBRvn4r2Kts9DBrZjmHkaXE9Qg3i4vlRO2q94r8X+etpBm3Xwm1EXxfE3Wipl80U3mD+ili5DeZ4y9oaam4qlqbDiTtW2rXvQaCG97hR1//2k5u79VPlS1SmTlaJrudECpzfyTUyv2r50I7ODHKrH6XK1jb4ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=QUDJ+uSf; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="QUDJ+uSf"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Cc:To:From:content-disposition;
	bh=dVJl+hvz80sa41TKXboM7zBTDRX4tzSFBxTrH4qw2Jw=; b=QUDJ+uSfw38/XmZMtRLp8CMrUD
	iJ8N4Fi+sHxFCk/Hh3k3tCCAj5jHdzEa8pjEgkYw8UtvzJ3vej+M7HEdF6dI/m5JfskBG0dOHXaOj
	F+CraxmmO6vPzcSPjPv2YN+v7KLW6cNnKh6yyhzKe8p4MX5RQjf1K8WEopW/z35g8RhbdmLA5UsBE
	KgDSnTxmpMzTzdsF8cFLnPryg++C4Y3uJAeStnbVjPeojmzVDCM1Ir+7ErDYBa932fLPhxEm46HnX
	Y5HTWpji1++6l57envou3urTr8pzrjbnFS4tjRcNDo6EAM3cyU+5FKKMQMC1eaO6t4ppZTxP53MfZ
	tk7jYeWQ==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
	by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1x17SZ-000000007D1-2rpX;
	Mon, 31 Aug 2026 13:14:24 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.98.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1x17SI-00000000s1f-0p4e;
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
	Frank Li <Frank.Li@nxp.com>
Date: Mon, 31 Aug 2026 13:13:56 -0600
Message-ID: <20260831191403.207631-7-logang@deltatee.com>
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
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, dmaengine@vger.kernel.org, vkoul@kernel.org, linux@weissschuh.net, dave.jiang@intel.com, kelvin.cao@microchip.com, george.ge@microchip.com, jjy600901@snu.ac.kr, logang@deltatee.com, Frank.li@nxp.com, Frank.Li@nxp.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Level: 
Subject: [PATCH v5 06/12] dmaengine: switchtec-dma: make switchtec_dma_chans_release() void
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)

switchtec_dma_chans_release() always returned 0, and no caller
checked it.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/dma/switchtec_dma.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/switchtec_dma.c b/drivers/dma/switchtec_dma.c
index f71c64c137e8..c30530ba78ca 100644
--- a/drivers/dma/switchtec_dma.c
+++ b/drivers/dma/switchtec_dma.c
@@ -1177,15 +1177,13 @@ static int switchtec_dma_chan_free(struct pci_dev *pdev,
 	return 0;
 }
 
-static int switchtec_dma_chans_release(struct pci_dev *pdev,
-				       struct switchtec_dma_dev *swdma_dev)
+static void switchtec_dma_chans_release(struct pci_dev *pdev,
+					struct switchtec_dma_dev *swdma_dev)
 {
 	int i;
 
 	for (i = 0; i < swdma_dev->chan_cnt; i++)
 		switchtec_dma_chan_free(pdev, swdma_dev->swdma_chans[i]);
-
-	return 0;
 }
 
 static void switchtec_dma_chans_free(struct switchtec_dma_dev *swdma_dev)
-- 
2.47.3


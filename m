Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91CA433BA6;
	Mon, 27 Jul 2026 17:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785174536; cv=none; b=MHPFzi8NJeF8ecZUrft5TQfsX//pFVQxyU6u1UQTay7sVUVAZatqE1IrBrZr8fhx/XgCor0eC0ZN8TjGl3mHNJWQ+hFQrncT/bhS1eTQ5CoM3t1kA6Z9VFPDFxPGgWd1+REaCXEkCI+YaDGw1bQPZi4mVJt/MTUEZq5ZX87wU+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785174536; c=relaxed/simple;
	bh=ySCkLPAqWtCtAcLrqOk1iov38CT+e9IFCxP70BJsYlQ=;
	h=From:To:Cc:Date:Message-ID:MIME-Version:Subject; b=JDCYbjKT8iP4KWXQ7RMB2HOI9dXSh4LVeOWH+NrsY+efBNFzF3RdUe/77lX0RJCAjmAVI9Ii6eFPSGeZUx/nMp3BSVzUqC1o9sJWm2EJddrazfJ2yXuTLK1cNo2rZog+GNAtQpFxhcW2G7RrS6Kn/7R7hO/lbwD1hTkosByZUj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=V62dikSD; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="V62dikSD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:MIME-Version:Message-ID:Date:Cc:To:From
	:references:content-disposition:in-reply-to;
	bh=szO9rt+4Cv3PdULQrwBdtGswhYYhjEgATm/lgB0dTYw=; b=V62dikSDenZ3A+a2/ukFO/OhJJ
	ysNOnQ7Wc1vPON+zBogsf6tK9AM5oZ7owYVncPKqWTI2DkGZDMkgiQ8WLLooUyKSOpxTl43Yaf7ts
	ymtFvP3Qi1uCVYgwY3pYkhoJx7W/GyEF3KVqwRgEtMtSsoFCOSHIMz58/sD3PgM75Ae5IO50dSiLP
	bjJG8DDhaJsVO/1861EOQcYTWfcjwk4A9RSEtlcW+VuFS1PQ7BjmOPzi2FrRgk9nFMGtGWzJFJz9h
	A/bkBsIpapZn5k87RKTAFiHcKei1HJkRlZoWoCfRxEHM6y1NRVtSOOooZzx2+z4GLOcPjbwXpnJvm
	Pwt4WFDw==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
	by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1woPRU-000000004Nx-04M7;
	Mon, 27 Jul 2026 11:48:44 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.98.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1woPRP-000000001jb-2GXI;
	Mon, 27 Jul 2026 11:48:39 -0600
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
	Logan Gunthorpe <logang@deltatee.com>
Date: Mon, 27 Jul 2026 11:48:30 -0600
Message-ID: <20260727174837.6645-1-logang@deltatee.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, dmaengine@vger.kernel.org, vkoul@kernel.org, Frank.li@nxp.com, linux@weissschuh.net, dave.jiang@intel.com, kelvin.cao@microchip.com, george.ge@microchip.com, jjy600901@snu.ac.kr, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Level: 
Subject: [PATCH v1 0/6] dmaengine: miscellaneous fixes for ioat, switchtec_dma and plx_dma
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)

When reviewing the recent switchtec patchset, the Sashiko bot noticed
a handful of pre-existing problems in the ioat and switchtec drivers.
Additionally, I've included:

 * A fix for a plx-dma issue that was reported on the list[1] a few
   weeks ago.
 * A potential issue I noticed while reviewing the code where pointers
   need to be set to NULL.

These fixes are all valid and independent of the work I was doing so
I've sent them as their own submission. I'm still working on the rest
of the feedback Sashiko gave me on that submission.

Thanks,

Logan

[1] https://lore.kernel.org/all/20260610112121.676561-1-jjy600901@snu.ac.kr/T/#u

Logan Gunthorpe (6):
  dmaengine: switchtec-dma: fix double-free in switchtec_dma_free_desc()
  dmaengine: switchtec-dma: fix resource leak in alloc_chan_resources
  dmaengine: switchtec-dma: fix channel leak on registration failure
  dmaengine: ioat: disable relaxed ordering before registering the
    device
  dmaengine: ioat: use sysfs_emit() in per-channel sysfs show()
  dmaengine: plx_dma: fix NULL pointer deref in plx_dma_isr()

 drivers/dma/ioat/init.c     | 18 +++++++++---------
 drivers/dma/ioat/sysfs.c    | 22 +++++++++++-----------
 drivers/dma/plx_dma.c       | 10 +++++-----
 drivers/dma/switchtec_dma.c | 36 ++++++++++++++++++++++++++++++------
 4 files changed, 55 insertions(+), 31 deletions(-)


base-commit: a13c140cc289c0b7b3770bce5b3ad42ab35074aa
-- 
2.47.3


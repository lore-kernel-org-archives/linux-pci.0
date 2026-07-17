Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA4D3DB32A;
	Fri, 17 Jul 2026 22:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784326220; cv=none; b=hxJDeEC2vBoBCVWcD4/QWehwyffUTsSErS79wePb5J5lfps7dvGHmu3pDavwoW5i+LkXPjFYdmTVIkAUqq5SKfiq2w/cIEaaDbWp9/Va2fpvVB3MZeIYJhKbvVvLQJr9NRuBDWeZCqf73Ga8tY2laUcVZIQLTE8DkYYhlijuAOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784326220; c=relaxed/simple;
	bh=ySCkLPAqWtCtAcLrqOk1iov38CT+e9IFCxP70BJsYlQ=;
	h=From:To:Cc:Date:Message-ID:MIME-Version:Subject; b=sjRgDPKAuY4ZvRmDV5nhJeNTipIoPYOriTjCAxAh4bdxxcqNYDnmaqpktGl2TdbBkUUo4BizM0DxIVBuBmwGoM0YgHjBJ50ukSI3edBUYkL06LSmRmcQ4ozyJid5djzCEtCTVP1+WrZzUgKK7cRanZ5zv9owuR5oOiGqbAgBGSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=ZUuWmIpo; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="ZUuWmIpo"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:MIME-Version:Message-ID:Date:Cc:To:From
	:references:content-disposition:in-reply-to;
	bh=szO9rt+4Cv3PdULQrwBdtGswhYYhjEgATm/lgB0dTYw=; b=ZUuWmIpo94f6dKKDoUhciuRxQ/
	rkdKAXVPuROmF0gPoC2LjAuQJZoHDEuwC7QLbeKKsal/RAP6qkJJMaCY8GPujL1B3Ac8yhtJ1Ydzh
	IF5SpDYYHCdftjdhcrTHsKH7bEOSZQA1pasGRKCMPVZCGAh9PmLM3T/D9bUKx/+WW6Ue4vmH+BebZ
	n+f8VSEB1tMEZEtyOv4f6AvRVz6x6yFqKuYe1/O4IAYmyBZ6Ss52kW30BJr046gGn5Nd04Tmqbsm0
	1trEdhsqmnvWNWeSnfB1F9NabyCyPdLU+jyuVeUVIVmNmoadF9XqH6wB/J0JwZsqiYAnqRGPrQkYg
	JiPMwP5Q==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
	by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1wkqkz-00000008wEl-3fmP;
	Fri, 17 Jul 2026 16:10:11 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.98.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1wkqku-00000001W1o-2D9q;
	Fri, 17 Jul 2026 16:10:04 -0600
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
Date: Fri, 17 Jul 2026 16:09:55 -0600
Message-ID: <20260717221001.361421-1-logang@deltatee.com>
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


Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6080646C4AE;
	Tue, 21 Jul 2026 16:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784650204; cv=none; b=AvhhgXthUgJUEGfyULehOC8zolGxTvTfmWAgGXZMDiFcSx1TH1SiCiujb23kb9oqVgKmXPgwCT0mPbc+SqHmXf4GaoIbUlmBmysomnufW4CJW4l9Sppw5PZy+vTeL49IGAgUAhRCZcSYfDMLXH0JNP58Or6YRIvO64u0Opa0W7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784650204; c=relaxed/simple;
	bh=tfBqgRwo5lSxjdc+tWvb4JILEyOEQw+AekmxGo4B3W0=;
	h=From:To:Cc:Date:Message-ID:MIME-Version:Subject; b=XPbL5CQKyICORmboGTMkE4EuesZ/1Fxlo3dqbe+N1S2StSDZQ76wzY71hBpr7oEeIxetxKoHcgJmTiG8f4M8lDc9VmRv86kZjOHDCfLhe/wKX3LgDHidEHhLsXPn0NTJIzxS5N7wH7bbtjclPbmWyTxsGDvfvjxu20itKbE+vBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=VkQoe+6z; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="VkQoe+6z"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:MIME-Version:Message-ID:Date:Cc:To:From
	:references:content-disposition:in-reply-to;
	bh=v08H3BIshCvUiuEYOPd8JivvigUoNVfXU/KEqUKJ4rQ=; b=VkQoe+6z79uhhQfYh9mCcTrmdA
	En6LP8JHMx9P2K4iHugxxB3Rh+aT0DKK0e0A3ScCB/e3QoFkv9BIUaxJTVCvtoGIZynGLWmRGS8Jh
	Tc06GAG02eBWo5Sp8wuHq2vD85fhTJc+aTicvfHVssqO53uA81aKvJMoLxjIWDi37azOFuf0MDIJb
	FGTQFGU4O1wKwpye1g7R/uYtplM7+Macx4sfEm9sc6AUVGQuwftcTHxJjxrVeBC9ewQSCcUvX3V4N
	uEH1c2uKtNo9JqnM7um/iOLt7XhSu1mSjYBlWThgOBOl9h6cccuclu+tHggZeCkfccBhk7WaAC6Ck
	tOFZSS2A==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
	by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1wmD2Y-0000000BodJ-1fNC;
	Tue, 21 Jul 2026 10:09:55 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.98.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1wmD2T-00000000GBH-2FMF;
	Tue, 21 Jul 2026 10:09:49 -0600
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
Date: Tue, 21 Jul 2026 09:57:27 -0600
Message-ID: <20260721155739.62120-1-logang@deltatee.com>
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
Subject: [PATCH v2 00/11] dmaengine: miscellaneous fixes for ioat, switchtec_dma and plx_dma
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)

When reviewing the recent switchtec patchset[1], the Sashiko bot noticed
a handful of pre-existing problems in the ioat and switchtec drivers.
I attempted to fix those plus an unrelated issue reported in plxdma but
when I submitted those patches, Sashiko found even more issues[2]. (It is
relentless!).

I've fixed the issues reported with v1 of this series and the ones for the
switchtec driver. But the pre-existing issues in ioat, plxdma and the
dmaengine itself I've punted until I can find some time to dig into them.

Hopefully, this is good enough for Sashiko this time and we can get
it reviewed by real humans.

The series is based off of v7.2-rc4.

Thanks,

Logan

[1] https://lore.kernel.org/all/20260707162045.23910-1-logang@deltatee.com
[2] https://sashiko.dev/#/patchset/20260717221001.361421-1-logang@deltatee.com

Changes since v1:

 * Added a fix for switchtec_dma_alloc_chan_resources()'s error path
   calling disable_channel() instead of properly halting the channel
   before freeing the descriptor rings. (Per Sashiko)
 * Added a fix for switchtec-dma channel structs being freed without
   being removed from dma_dev->channels on a registration failure,
   while the channel status IRQ is still live. (Per Sashiko)
 * Added a fix for switchtec_dma_remove() using swdma_dev after it may
   already have been freed by dma_async_device_unregister(). (Per
   Sashiko)
 * Added a fix for chan_status_irq being freed with the wrong API, and
   a valid vector index of 0 being incorrectly treated as unset.
   (Per Sashiko)
 * Made switchtec_dma_chans_release() void, since nothing checked its
   return value. (Noticed while reviewing the code for these changes).

Logan Gunthorpe (11):
  dmaengine: switchtec-dma: fix double-free in switchtec_dma_free_desc()
  dmaengine: switchtec-dma: fix resource leak in alloc_chan_resources
  dmaengine: switchtec-dma: halt channel on alloc_chan_resources error
  dmaengine: switchtec-dma: fix channel leak on registration failure
  dmaengine: switchtec-dma: make switchtec_dma_chans_release() void
  dmaengine: switchtec-dma: unlink channels before freeing on
    registration failure
  dmaengine: switchtec-dma: fix use-after-free of swdma_dev in remove()
  dmaengine: switchtec-dma: fix chan_status_irq cleanup on create()
    error
  dmaengine: ioat: disable relaxed ordering before registering the
    device
  dmaengine: ioat: use sysfs_emit() in per-channel sysfs show()
  dmaengine: plx_dma: fix NULL pointer deref in plx_dma_isr()

 drivers/dma/ioat/init.c     | 18 ++++-----
 drivers/dma/ioat/sysfs.c    | 22 +++++------
 drivers/dma/plx_dma.c       | 10 ++---
 drivers/dma/switchtec_dma.c | 78 +++++++++++++++++++++++++++----------
 4 files changed, 82 insertions(+), 46 deletions(-)


base-commit: 1590cf0329716306e948a8fc29f1d3ee87d3989f
--
2.47.3

Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39942BE639;
	Mon, 31 Aug 2026 19:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788203667; cv=none; b=T+LRuJ8KIynL5FshlNClgMKlNbd60QesYUGR/nY1PJ/HMJN42jujauw7QpyKidk0rdmncgFpziuxTjVPi8uxWhSlT3fRhJPpPeMQIId8lP0pOxrBk4FN9ZR5OxuKKfqCuL6BTd0bwKFeRwpHhYnSnvbGzaPkcoWII7cR2CxYcMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788203667; c=relaxed/simple;
	bh=HC94LW7Mw0CNj4s1GfvGmeMNjjo/1pCpAxQLLKyEUGk=;
	h=From:To:Cc:Date:Message-ID:MIME-Version:Subject; b=b4RfdG8COJx0jNbuYU7bKPEVp/eU0y4S/uv/RIctbzA2dnlj3S/Xi00iaF0kz0GF/S2Qq4cieTy7DkRVH8nkce9kacU/xlkKqMohnEPRK5Sa+KR3AbvZOuPECsbvbF0ggedWbtEsXB32jcndHGwP5yY5qUmgI0DtznphQ6obufA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=XK5kcQBm; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="XK5kcQBm"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:MIME-Version:Message-ID:Date:Cc:To:From
	:references:content-disposition:in-reply-to;
	bh=l2IUnbDb9sdLbiqKCxC1J9ILA8d+mipnpCNTmBoLTX8=; b=XK5kcQBme4qli89vOz33QSqMhz
	AkubjDXfJWmZoYZznAG35kw6iB0HGcRSFZue5LOkhnbCo7QeOuBMb63uvYtyF3oJXR4Qy1jo0ApSm
	/195At4XEVKNkB6fhuMwsA3/+ViBW3y9LrK4WzXDll/s0BzG30O7yCsL54Iw1ImfTjjZluEKLKu7C
	xlvxDcj7Hnc3Wxf6ZtXcwfpYIj5dE9+RelQ8KS1qw8yn0wHxC2tDuck3qCr6cAPPYqZzrFb9flkcn
	08q8PW1D0GKzWWFLtFNJljvhRcAADTfjfc+EXNsJsShlk/pBBS9i1kjIO3reXl5Z5jc1Sinbz6AJq
	wTo2JE7A==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
	by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1x17SU-000000007Bg-0E8W;
	Mon, 31 Aug 2026 13:14:18 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.98.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1x17SH-00000000s1T-1EwG;
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
	Logan Gunthorpe <logang@deltatee.com>
Date: Mon, 31 Aug 2026 13:13:50 -0600
Message-ID: <20260831191403.207631-1-logang@deltatee.com>
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
Subject: [PATCH v5 00/12] dmaengine: miscellaneous fixes for ioat, switchtec_dma and plx_dma
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)

This is the latest series of fixes that has been rebased onto v7.3-rc1.

There is an unresolved disagreement between me and Frank who does not
think patches 3 and 4 are worth taking. I think they fix unlikely but
theoretically possible issues with hardware failing to tear down
correctly. I think these patches are correct, the best we can do and worth
doing. And I especially want to have them merged if only to not have
Sashiko bringing up the same issues every time we send a patch set.

Please note: I'm going to be on vacation starting Friday the 4th until
the 15th so if there is any feedback in that window I'll respond when
I get back.

Thanks,

Logan

Changes since v4:
 * Rebased onto v7.3-rc1.
 * Added paragraph to patches 3 and 4 to make clear that they are
   leaking memory in favour of preventing theoretically buggy hardware
   from trashing re-used memory. I think this is the best thing to do.

Changes since v3:
 * Add a patch (3) making switchtec_dma_chan_stop() clear the DMA base
   registers even when halt_channel() times out, and return the halt
   result. switchtec_dma_free_chan_resources() (patch 3) and the
   alloc_chan_resources() error path (patch 4) now skip freeing the
   descriptor rings when the halt wasn't confirmed. This will leak some
   memory on tear down but that avoids broken hardware from scribbling
   on memory that may have been freed and reallocated. (Per Sashiko)
 * Remove each channel's list entry in switchtec_dma_chans_free()
   (patch 5), immediately before the memory is freed, instead of in
   switchtec_dma_chans_disable() (patch 8), which now only frees the
   channel status IRQ. (Per Sashiko)
 * Collected Reviewed-by tags from Frank and applied one of his
   commit message suggestions.

Changes since v2:

 * Fixed a race when unlisting the channels in the error path.
   The interrupt needed to be disabled before hand. (Per Sashiko)
 * Picked up Acked-by from Dave Jiang on the two ioat patches.

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

Logan Gunthorpe (12):
  dmaengine: switchtec-dma: fix double-free in switchtec_dma_free_desc()
  dmaengine: switchtec-dma: fix resource leak in alloc_chan_resources
  dmaengine: switchtec-dma: always clear DMA base registers on
    chan_stop()
  dmaengine: switchtec-dma: halt channel on alloc_chan_resources error
  dmaengine: switchtec-dma: fix channel leak on registration failure
  dmaengine: switchtec-dma: make switchtec_dma_chans_release() void
  dmaengine: switchtec-dma: fix chan_status_irq cleanup on create()
    error
  dmaengine: switchtec-dma: disable channels before freeing on
    registration failure
  dmaengine: switchtec-dma: fix use-after-free of swdma_dev in remove()
  dmaengine: ioat: disable relaxed ordering before registering the
    device
  dmaengine: ioat: use sysfs_emit() in per-channel sysfs show()
  dmaengine: plx_dma: fix NULL pointer deref in plx_dma_isr()

 drivers/dma/ioat/init.c     |  18 +++---
 drivers/dma/ioat/sysfs.c    |  22 ++++----
 drivers/dma/plx_dma.c       |  10 ++--
 drivers/dma/switchtec_dma.c | 107 ++++++++++++++++++++++++++----------
 4 files changed, 104 insertions(+), 53 deletions(-)


base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
-- 
2.47.3


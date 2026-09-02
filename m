Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD04D33F5A8;
	Wed,  2 Sep 2026 06:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788330157; cv=none; b=NDgD8EH/AeQoeYVxVwAY/uEGboYrB6dqFt5dGsVF7Ooc/278qJkG28ztbQ4h0i8o3f73eudj6lKPYryFWruCgYxLUs6l9FVpwnd+acnDNagyUARrqd5zJ88lxAaot3HO6QcBtKMfav3EO5s2v+ked/7cYFF3pfHpuWJPQdf6EXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788330157; c=relaxed/simple;
	bh=s3E4svhSaFMCHxliB+uZvkdxtpUrahDalPnU0+iiXTk=;
	h=From:To:Cc:Date:Message-ID:MIME-Version:Subject; b=YFJTrI9BJMvyCIde+1HauRmBc7NC9UW0IBDrRtgOkjqh07R1ClTsSIVgLfdvqFIJOwVnVemDQLatiEDZ3G6I5xYmQZIpH3i7QNfhYnLzHP9nRA163CDHvn+0CsR8jlNKA19Ukf9ARowlwuA0ZrQ4yoeXYqTfsNrxGrUZD0y72Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=eo8QEagI; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="eo8QEagI"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:MIME-Version:Message-ID:Date:Cc:To:From
	:references:content-disposition:in-reply-to;
	bh=suOI9cCCK5FZsq5KNu4J2BKlthDMDSPrEUK7qKt28RM=; b=eo8QEagINtu3bY43F0+Jv3RWlj
	eN6ChmUXIo5kb1kOHQRoYDMYlEyhODIFGccbuhKVPStYMYPe6Uu/+0nA0hLd+PMXdroBjy12uIFbh
	QZQGCyig+y7dQk52kOWfJRzD4O35hAYfC5qmrbMqi+eTkP7H2QjO+Bsz4qDX+lsEckc+8JGmzeHj0
	fkfzsAgp0r/h68GPdUplJcn2vMG7YA+6CXbIxBuPjyHTvj9OSG1KUDEsgswo48XhH5w9fasqmZxc9
	GvZYgGtCNSVWmzGtVFfws4jtW+ikLlDbaODLGN8fsVownbLNxyqZ2TjhpDKqYvomwavtooTAgafy7
	VQ+4k4gg==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
	by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1x1eMe-00000000LqM-24Xm;
	Wed, 02 Sep 2026 00:22:29 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.98.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1x1eMA-0000000085J-1Zzc;
	Wed, 02 Sep 2026 00:21:58 -0600
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
Date: Wed,  2 Sep 2026 00:21:42 -0600
Message-ID: <20260902062153.31048-1-logang@deltatee.com>
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
Subject: [PATCH v6 00/10] dmaengine: miscellaneous fixes for ioat, switchtec_dma and plx_dma
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)

This is the latest series of fixes that has been rebased onto v7.3-rc1.

After getting more Sashiko feedback on the two problematic patches I
have to eat crow and appologize. Frank was correct about them and I
was a bit too stubborn. Sorry about that. I have dropped those two
patches in this series so hopefully it can go in quickly.

Please note: I'm going to be on vacation starting Friday the 4th until
the 15th so if there is any feedback in that window I'll respond when
I get back.

Thanks,

Logan

Changes since v5:
 * Dropped the two patches that skipped freeing the descriptor rings
   when the channel could not be confirmed halted ("always clear DMA
   base registers on chan_stop()" and "halt channel on
   alloc_chan_resources error"), per Frank's recommendation. All
   remaining patches are unchanged.

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

Logan Gunthorpe (10):
  dmaengine: switchtec-dma: fix double-free in switchtec_dma_free_desc()
  dmaengine: switchtec-dma: fix resource leak in alloc_chan_resources
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

 drivers/dma/ioat/init.c     | 18 ++++-----
 drivers/dma/ioat/sysfs.c    | 22 +++++-----
 drivers/dma/plx_dma.c       | 10 ++---
 drivers/dma/switchtec_dma.c | 80 +++++++++++++++++++++++++++----------
 4 files changed, 84 insertions(+), 46 deletions(-)


base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
--
2.47.3

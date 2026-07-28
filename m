Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABC33A48CE;
	Tue, 28 Jul 2026 17:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785258941; cv=none; b=c71uCGsR16Ch5hSsUFZv9uSAhhgdwYirKaq+vV/kGt18eadFznGhMimcMdNKLKZR3a6GxyS1oEVSmVEG/PE5R6619d0z88iuxrztj2Tx0TYCSEfi9aH0SHUqCJ7Husmc0KKY/AxoJ+6sJ2L6wf2CVZbYiJZ4NQf+hDXscYVXp1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785258941; c=relaxed/simple;
	bh=8aiS/hh8zw68dMmf4AM7hEQGgUk0fkR18ERVgPnSQCg=;
	h=From:To:Cc:Date:Message-ID:MIME-Version:Subject; b=nRQiOEMLnnnGhsd+VRRJEn+aISFQwdykTzqa6A6Yni1RpUrkzJk/c5rs71aumuEFSMF7GPbtz3VBZkYfzGC8ruNpsMY+SLWZa2SpQhctGLNacUnO1CT+TtV9Pt705Xs7vUl2oiIN8n6cBYoAN439wHQTiSL4j5WEzIDpgLy/Nvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=Dj+SKUsz; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="Dj+SKUsz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:MIME-Version:Message-ID:Date:Cc:To:From
	:references:content-disposition:in-reply-to;
	bh=BMT3hCW+Ej9++fHLpP3zjMmPQtCIwO9OpQVQr6mXWKY=; b=Dj+SKUsz7jIiYe7IYCXoK0aiy9
	OVTWBbGHx30PWylP5jJC7W9+DW9GnKNb6mon1VtDwqjEVbiiFv06YaY//xq+nrHnmet7GxGr+zVLf
	YzFx1HQqn40ARp2JaONbUEOANV0ujq9HCUOm7W2K/JWF1Gv1Vut0sWhd2ObAsUq5X42sy+fuer42V
	gGSzPLcJM+1Ngw/QgHTQBqY8hFFd74RQQDEKKMEziqnu2RD4hKpfSe2fNF2zKxkzCnoGH/Vh/LpUr
	99rSCsFgijH1HfhuBWGckMqAUuCJwucKeikQOkPj/AZHh3SOoU69PhW5mG2EwkvLm1PBJz5+V35HB
	RTcYGBQQ==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
	by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1wolOr-00000000oXU-0Oeo;
	Tue, 28 Jul 2026 11:15:32 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.98.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1wolOp-00000000TCz-057U;
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
	Logan Gunthorpe <logang@deltatee.com>
Date: Tue, 28 Jul 2026 11:15:11 -0600
Message-ID: <20260728171523.112244-1-logang@deltatee.com>
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
Subject: [PATCH v4 00/12] dmaengine: miscellaneous fixes for ioat, switchtec_dma and plx_dma
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)

When reviewing the recent switchtec patchset[1], the Sashiko bot noticed
a handful of pre-existing problems in the ioat and switchtec drivers.
I attempted to fix those plus an unrelated issue reported in plxdma but
when I submitted those patches, Sashiko found even more issues[2][3][4]
(it is relentless!).

I've fixed the issues reported with v1, v2 and v3 of this series and
many of the ones for the switchtec driver. But the pre-existing issues
in ioat, plxdma and the dmaengine itself I've punted until I can find
some time to dig into them.

The series is based off of v7.2-rc5.

Thanks,

Logan

[1] https://lore.kernel.org/all/20260707162045.23910-1-logang@deltatee.com
[2] https://sashiko.dev/#/patchset/20260717221001.361421-1-logang@deltatee.com
[3] https://sashiko.dev/#/patchset/20260721155739.62120-1-logang@deltatee.com
[4] https://sashiko.dev/#/patchset/20260727181526.9672-1-logang@deltatee.com

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


base-commit: f5098b6bae761e346ebcd9da7f95622c04733cff
-- 
2.47.3


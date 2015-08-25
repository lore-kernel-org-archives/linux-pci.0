Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:36150 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751400AbbHYPxr (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 25 Aug 2015 11:53:47 -0400
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: mingo@kernel.org
Cc: bp@suse.de, bhelgaas@google.com, tomi.valkeinen@ti.com,
	airlied@linux.ie, linux-fbdev@vger.kernel.org, luto@amacapital.net,
	vinod.koul@intel.com, dan.j.williams@intel.com, toshi.kani@hp.com,
	benh@kernel.crashing.org, mst@redhat.com,
	akpm@linux-foundation.org, daniel.vetter@ffwll.ch,
	konrad.wilk@oracle.com, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	xen-devel@lists.xensource.com,
	"Luis R. Rodriguez" <mcgrof@suse.com>
Subject: [PATCH v5 10/11] dma: rename dma_*_writecombine() to dma_*_wc()
Date: Tue, 25 Aug 2015 08:53:37 -0700
Message-Id: <1440518017-17945-1-git-send-email-mcgrof@do-not-panic.com>
In-Reply-To: <1440443613-13696-11-git-send-email-mcgrof@do-not-panic.com>
References: <1440443613-13696-11-git-send-email-mcgrof@do-not-panic.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@suse.com>

Rename dma_*_writecombine() to dma_*_wc(), so that the naming
is coherent across the various write-combining APIs.

The following Coccinelle SmPL patch was used for this simple
transformation:

@ rename_dma_alloc_writecombine @
expression dev, size, dma_addr, gfp;
@@

-dma_alloc_writecombine(dev, size, dma_addr, gfp)
+dma_alloc_wc(dev, size, dma_addr, gfp)

@ rename_dma_free_writecombine @
expression dev, size, cpu_addr, dma_addr;
@@

-dma_free_writecombine(dev, size, cpu_addr, dma_addr)
+dma_free_wc(dev, size, cpu_addr, dma_addr)

@ rename_dma_mmap_writecombine @
expression dev, vma, cpu_addr, dma_addr, size;
@@

-dma_mmap_writecombine(dev, vma, cpu_addr, dma_addr, size)
+dma_mmap_wc(dev, vma, cpu_addr, dma_addr, size)

Generated-by: Coccinelle SmPL
Suggested-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Luis R. Rodriguez <mcgrof@suse.com>
---
 arch/arm/mach-lpc32xx/phy3250.c           | 13 ++++++-------
 arch/arm/mach-netx/fb.c                   | 14 ++++++--------
 arch/arm/mach-nspire/clcd.c               | 13 ++++++-------
 arch/avr32/include/asm/dma-mapping.h      | 20 ++++++++++----------
 arch/avr32/mm/dma-coherent.c              | 12 ++++++------
 arch/metag/include/asm/dma-mapping.h      |  4 ++--
 arch/metag/kernel/dma.c                   |  6 +++---
 drivers/dma/iop-adma.c                    |  8 ++++----
 drivers/dma/mv_xor.c                      |  4 ++--
 drivers/dma/qcom_bam_dma.c                | 14 +++++++-------
 drivers/gpu/drm/drm_gem_cma_helper.c      | 13 ++++++-------
 drivers/gpu/drm/omapdrm/omap_dmm_tiler.c  | 13 ++++++-------
 drivers/gpu/drm/omapdrm/omap_gem.c        |  8 ++++----
 drivers/gpu/drm/sti/sti_cursor.c          | 20 ++++++++------------
 drivers/gpu/drm/sti/sti_gdp.c             |  3 +--
 drivers/gpu/drm/sti/sti_hqvdp.c           |  6 +++---
 drivers/gpu/drm/tegra/gem.c               | 11 +++++------
 drivers/gpu/host1x/cdma.c                 |  8 ++++----
 drivers/gpu/host1x/job.c                  | 10 ++++------
 drivers/media/platform/coda/coda-bit.c    | 10 +++++-----
 drivers/video/fbdev/acornfb.c             |  4 ++--
 drivers/video/fbdev/amba-clcd-versatile.c | 14 ++++++--------
 drivers/video/fbdev/amba-clcd.c           |  4 ++--
 drivers/video/fbdev/atmel_lcdfb.c         |  9 +++++----
 drivers/video/fbdev/ep93xx-fb.c           |  8 +++-----
 drivers/video/fbdev/gbefb.c               |  8 ++++----
 drivers/video/fbdev/imxfb.c               | 12 ++++++------
 drivers/video/fbdev/mx3fb.c               |  9 ++++-----
 drivers/video/fbdev/nuc900fb.c            |  8 ++++----
 drivers/video/fbdev/omap/lcdc.c           | 16 ++++++++--------
 drivers/video/fbdev/pxa168fb.c            |  8 ++++----
 drivers/video/fbdev/pxafb.c               |  4 ++--
 drivers/video/fbdev/s3c-fb.c              |  7 +++----
 drivers/video/fbdev/s3c2410fb.c           |  8 ++++----
 drivers/video/fbdev/sa1100fb.c            |  8 ++++----
 include/linux/dma-mapping.h               | 16 ++++++++--------
 sound/arm/pxa2xx-pcm-lib.c                | 20 ++++++++------------
 sound/soc/fsl/imx-pcm-fiq.c               | 10 ++++------
 sound/soc/nuc900/nuc900-pcm.c             |  6 ++----
 sound/soc/omap/omap-pcm.c                 | 12 ++++--------
 40 files changed, 185 insertions(+), 216 deletions(-)

diff --git a/arch/arm/mach-lpc32xx/phy3250.c b/arch/arm/mach-lpc32xx/phy3250.c
index 7858d5b6f6ce..43ff56c2a7a9 100644
--- a/arch/arm/mach-lpc32xx/phy3250.c
+++ b/arch/arm/mach-lpc32xx/phy3250.c
@@ -86,8 +86,8 @@ static int lpc32xx_clcd_setup(struct clcd_fb *fb)
 {
 	dma_addr_t dma;
 
-	fb->fb.screen_base = dma_alloc_writecombine(&fb->dev->dev,
-		PANEL_SIZE, &dma, GFP_KERNEL);
+	fb->fb.screen_base = dma_alloc_wc(&fb->dev->dev, PANEL_SIZE, &dma,
+					  GFP_KERNEL);
 	if (!fb->fb.screen_base) {
 		printk(KERN_ERR "CLCD: unable to map framebuffer\n");
 		return -ENOMEM;
@@ -116,15 +116,14 @@ static int lpc32xx_clcd_setup(struct clcd_fb *fb)
 
 static int lpc32xx_clcd_mmap(struct clcd_fb *fb, struct vm_area_struct *vma)
 {
-	return dma_mmap_writecombine(&fb->dev->dev, vma,
-		fb->fb.screen_base, fb->fb.fix.smem_start,
-		fb->fb.fix.smem_len);
+	return dma_mmap_wc(&fb->dev->dev, vma, fb->fb.screen_base,
+			   fb->fb.fix.smem_start, fb->fb.fix.smem_len);
 }
 
 static void lpc32xx_clcd_remove(struct clcd_fb *fb)
 {
-	dma_free_writecombine(&fb->dev->dev, fb->fb.fix.smem_len,
-		fb->fb.screen_base, fb->fb.fix.smem_start);
+	dma_free_wc(&fb->dev->dev, fb->fb.fix.smem_len, fb->fb.screen_base,
+		    fb->fb.fix.smem_start);
 }
 
 /*
diff --git a/arch/arm/mach-netx/fb.c b/arch/arm/mach-netx/fb.c
index d122ee6ab991..8814ee5e98fd 100644
--- a/arch/arm/mach-netx/fb.c
+++ b/arch/arm/mach-netx/fb.c
@@ -42,8 +42,8 @@ int netx_clcd_setup(struct clcd_fb *fb)
 
 	fb->panel = netx_panel;
 
-	fb->fb.screen_base = dma_alloc_writecombine(&fb->dev->dev, 1024*1024,
-						    &dma, GFP_KERNEL);
+	fb->fb.screen_base = dma_alloc_wc(&fb->dev->dev, 1024 * 1024, &dma,
+					  GFP_KERNEL);
 	if (!fb->fb.screen_base) {
 		printk(KERN_ERR "CLCD: unable to map framebuffer\n");
 		return -ENOMEM;
@@ -57,16 +57,14 @@ int netx_clcd_setup(struct clcd_fb *fb)
 
 int netx_clcd_mmap(struct clcd_fb *fb, struct vm_area_struct *vma)
 {
-	return dma_mmap_writecombine(&fb->dev->dev, vma,
-				     fb->fb.screen_base,
-				     fb->fb.fix.smem_start,
-				     fb->fb.fix.smem_len);
+	return dma_mmap_wc(&fb->dev->dev, vma, fb->fb.screen_base,
+			   fb->fb.fix.smem_start, fb->fb.fix.smem_len);
 }
 
 void netx_clcd_remove(struct clcd_fb *fb)
 {
-	dma_free_writecombine(&fb->dev->dev, fb->fb.fix.smem_len,
-			      fb->fb.screen_base, fb->fb.fix.smem_start);
+	dma_free_wc(&fb->dev->dev, fb->fb.fix.smem_len, fb->fb.screen_base,
+		    fb->fb.fix.smem_start);
 }
 
 static AMBA_AHB_DEVICE(fb, "fb", 0, 0x00104000, { NETX_IRQ_LCD }, NULL);
diff --git a/arch/arm/mach-nspire/clcd.c b/arch/arm/mach-nspire/clcd.c
index abea12617b17..ea0e5b2ca1cd 100644
--- a/arch/arm/mach-nspire/clcd.c
+++ b/arch/arm/mach-nspire/clcd.c
@@ -90,8 +90,8 @@ int nspire_clcd_setup(struct clcd_fb *fb)
 	panel_size = ((panel->mode.xres * panel->mode.yres) * panel->bpp) / 8;
 	panel_size = ALIGN(panel_size, PAGE_SIZE);
 
-	fb->fb.screen_base = dma_alloc_writecombine(&fb->dev->dev,
-		panel_size, &dma, GFP_KERNEL);
+	fb->fb.screen_base = dma_alloc_wc(&fb->dev->dev, panel_size, &dma,
+					  GFP_KERNEL);
 
 	if (!fb->fb.screen_base) {
 		pr_err("CLCD: unable to map framebuffer\n");
@@ -107,13 +107,12 @@ int nspire_clcd_setup(struct clcd_fb *fb)
 
 int nspire_clcd_mmap(struct clcd_fb *fb, struct vm_area_struct *vma)
 {
-	return dma_mmap_writecombine(&fb->dev->dev, vma,
-		fb->fb.screen_base, fb->fb.fix.smem_start,
-		fb->fb.fix.smem_len);
+	return dma_mmap_wc(&fb->dev->dev, vma, fb->fb.screen_base,
+			   fb->fb.fix.smem_start, fb->fb.fix.smem_len);
 }
 
 void nspire_clcd_remove(struct clcd_fb *fb)
 {
-	dma_free_writecombine(&fb->dev->dev, fb->fb.fix.smem_len,
-		fb->fb.screen_base, fb->fb.fix.smem_start);
+	dma_free_wc(&fb->dev->dev, fb->fb.fix.smem_len, fb->fb.screen_base,
+		    fb->fb.fix.smem_start);
 }
diff --git a/arch/avr32/include/asm/dma-mapping.h b/arch/avr32/include/asm/dma-mapping.h
index ae7ac9205d20..b43b11d1c7c0 100644
--- a/arch/avr32/include/asm/dma-mapping.h
+++ b/arch/avr32/include/asm/dma-mapping.h
@@ -71,7 +71,7 @@ extern void dma_free_coherent(struct device *dev, size_t size,
 			      void *cpu_addr, dma_addr_t handle);
 
 /**
- * dma_alloc_writecombine - allocate write-combining memory for DMA
+ * dma_alloc_wc - allocate write-combining memory for DMA
  * @dev: valid struct device pointer, or NULL for ISA and EISA-like devices
  * @size: required memory size
  * @handle: bus-specific DMA address
@@ -81,24 +81,24 @@ extern void dma_free_coherent(struct device *dev, size_t size,
  * return the CPU-viewed address, and sets @handle to be the
  * device-viewed address.
  */
-extern void *dma_alloc_writecombine(struct device *dev, size_t size,
-				    dma_addr_t *handle, gfp_t gfp);
+extern void *dma_alloc_wc(struct device *dev, size_t size,
+			  dma_addr_t *handle, gfp_t gfp);
 
 /**
- * dma_free_coherent - free memory allocated by dma_alloc_writecombine
+ * dma_free_coherent - free memory allocated by dma_alloc_wc
  * @dev: valid struct device pointer, or NULL for ISA and EISA-like devices
- * @size: size of memory originally requested in dma_alloc_writecombine
- * @cpu_addr: CPU-view address returned from dma_alloc_writecombine
- * @handle: device-view address returned from dma_alloc_writecombine
+ * @size: size of memory originally requested in dma_alloc_wc
+ * @cpu_addr: CPU-view address returned from dma_alloc_wc
+ * @handle: device-view address returned from dma_alloc_wc
  *
  * Free (and unmap) a DMA buffer previously allocated by
- * dma_alloc_writecombine().
+ * dma_alloc_wc().
  *
  * References to memory and mappings associated with cpu_addr/handle
  * during and after this call executing are illegal.
  */
-extern void dma_free_writecombine(struct device *dev, size_t size,
-				  void *cpu_addr, dma_addr_t handle);
+extern void dma_free_wc(struct device *dev, size_t size,
+			void *cpu_addr, dma_addr_t handle);
 
 /**
  * dma_map_single - map a single buffer for streaming DMA
diff --git a/arch/avr32/mm/dma-coherent.c b/arch/avr32/mm/dma-coherent.c
index 50cdb5b10f0f..5d029d202a2a 100644
--- a/arch/avr32/mm/dma-coherent.c
+++ b/arch/avr32/mm/dma-coherent.c
@@ -121,8 +121,8 @@ void dma_free_coherent(struct device *dev, size_t size,
 }
 EXPORT_SYMBOL(dma_free_coherent);
 
-void *dma_alloc_writecombine(struct device *dev, size_t size,
-			     dma_addr_t *handle, gfp_t gfp)
+void *dma_alloc_wc(struct device *dev, size_t size,
+		   dma_addr_t *handle, gfp_t gfp)
 {
 	struct page *page;
 	dma_addr_t phys;
@@ -137,10 +137,10 @@ void *dma_alloc_writecombine(struct device *dev, size_t size,
 	/* Now, map the page into P3 with write-combining turned on */
 	return __ioremap(phys, size, _PAGE_BUFFER);
 }
-EXPORT_SYMBOL(dma_alloc_writecombine);
+EXPORT_SYMBOL(dma_alloc_wc);
 
-void dma_free_writecombine(struct device *dev, size_t size,
-			   void *cpu_addr, dma_addr_t handle)
+void dma_free_wc(struct device *dev, size_t size,
+		 void *cpu_addr, dma_addr_t handle)
 {
 	struct page *page;
 
@@ -149,4 +149,4 @@ void dma_free_writecombine(struct device *dev, size_t size,
 	page = phys_to_page(handle);
 	__dma_free(dev, size, page, handle);
 }
-EXPORT_SYMBOL(dma_free_writecombine);
+EXPORT_SYMBOL(dma_free_wc);
diff --git a/arch/metag/include/asm/dma-mapping.h b/arch/metag/include/asm/dma-mapping.h
index eb5cdec94be0..d727deae083a 100644
--- a/arch/metag/include/asm/dma-mapping.h
+++ b/arch/metag/include/asm/dma-mapping.h
@@ -23,8 +23,8 @@ void dma_sync_for_cpu(void *vaddr, size_t size, int dma_direction);
 int dma_mmap_coherent(struct device *dev, struct vm_area_struct *vma,
 		      void *cpu_addr, dma_addr_t dma_addr, size_t size);
 
-int dma_mmap_writecombine(struct device *dev, struct vm_area_struct *vma,
-			  void *cpu_addr, dma_addr_t dma_addr, size_t size);
+int dma_mmap_wc(struct device *dev, struct vm_area_struct *vma,
+		void *cpu_addr, dma_addr_t dma_addr, size_t size);
 
 static inline dma_addr_t
 dma_map_single(struct device *dev, void *ptr, size_t size,
diff --git a/arch/metag/kernel/dma.c b/arch/metag/kernel/dma.c
index c700d625067a..89138b4f717a 100644
--- a/arch/metag/kernel/dma.c
+++ b/arch/metag/kernel/dma.c
@@ -372,13 +372,13 @@ int dma_mmap_coherent(struct device *dev, struct vm_area_struct *vma,
 }
 EXPORT_SYMBOL(dma_mmap_coherent);
 
-int dma_mmap_writecombine(struct device *dev, struct vm_area_struct *vma,
-			  void *cpu_addr, dma_addr_t dma_addr, size_t size)
+int dma_mmap_wc(struct device *dev, struct vm_area_struct *vma,
+		void *cpu_addr, dma_addr_t dma_addr, size_t size)
 {
 	vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
 	return dma_mmap(dev, vma, cpu_addr, dma_addr, size);
 }
-EXPORT_SYMBOL(dma_mmap_writecombine);
+EXPORT_SYMBOL(dma_mmap_wc);
 
 
 
diff --git a/drivers/dma/iop-adma.c b/drivers/dma/iop-adma.c
index e4f43125e0fb..f039cfadf17b 100644
--- a/drivers/dma/iop-adma.c
+++ b/drivers/dma/iop-adma.c
@@ -1300,10 +1300,10 @@ static int iop_adma_probe(struct platform_device *pdev)
 	 * note: writecombine gives slightly better performance, but
 	 * requires that we explicitly flush the writes
 	 */
-	adev->dma_desc_pool_virt = dma_alloc_writecombine(&pdev->dev,
-							  plat_data->pool_size,
-							  &adev->dma_desc_pool,
-							  GFP_KERNEL);
+	adev->dma_desc_pool_virt = dma_alloc_wc(&pdev->dev,
+						plat_data->pool_size,
+						&adev->dma_desc_pool,
+						GFP_KERNEL);
 	if (!adev->dma_desc_pool_virt) {
 		ret = -ENOMEM;
 		goto err_free_adev;
diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
index f1325f62563e..872a385a66fe 100644
--- a/drivers/dma/mv_xor.c
+++ b/drivers/dma/mv_xor.c
@@ -1000,8 +1000,8 @@ mv_xor_channel_add(struct mv_xor_device *xordev,
 	 * requires that we explicitly flush the writes
 	 */
 	mv_chan->dma_desc_pool_virt =
-	  dma_alloc_writecombine(&pdev->dev, MV_XOR_POOL_SIZE,
-				 &mv_chan->dma_desc_pool, GFP_KERNEL);
+	  dma_alloc_wc(&pdev->dev, MV_XOR_POOL_SIZE, &mv_chan->dma_desc_pool,
+		       GFP_KERNEL);
 	if (!mv_chan->dma_desc_pool_virt)
 		return ERR_PTR(-ENOMEM);
 
diff --git a/drivers/dma/qcom_bam_dma.c b/drivers/dma/qcom_bam_dma.c
index 5a250cdc8376..d34aef7a101b 100644
--- a/drivers/dma/qcom_bam_dma.c
+++ b/drivers/dma/qcom_bam_dma.c
@@ -502,8 +502,8 @@ static int bam_alloc_chan(struct dma_chan *chan)
 		return 0;
 
 	/* allocate FIFO descriptor space, but only if necessary */
-	bchan->fifo_virt = dma_alloc_writecombine(bdev->dev, BAM_DESC_FIFO_SIZE,
-				&bchan->fifo_phys, GFP_KERNEL);
+	bchan->fifo_virt = dma_alloc_wc(bdev->dev, BAM_DESC_FIFO_SIZE,
+					&bchan->fifo_phys, GFP_KERNEL);
 
 	if (!bchan->fifo_virt) {
 		dev_err(bdev->dev, "Failed to allocate desc fifo\n");
@@ -538,8 +538,8 @@ static void bam_free_chan(struct dma_chan *chan)
 	bam_reset_channel(bchan);
 	spin_unlock_irqrestore(&bchan->vc.lock, flags);
 
-	dma_free_writecombine(bdev->dev, BAM_DESC_FIFO_SIZE, bchan->fifo_virt,
-				bchan->fifo_phys);
+	dma_free_wc(bdev->dev, BAM_DESC_FIFO_SIZE, bchan->fifo_virt,
+		    bchan->fifo_phys);
 	bchan->fifo_virt = NULL;
 
 	/* mask irq for pipe/channel */
@@ -1231,9 +1231,9 @@ static int bam_dma_remove(struct platform_device *pdev)
 		bam_dma_terminate_all(&bdev->channels[i].vc.chan);
 		tasklet_kill(&bdev->channels[i].vc.task);
 
-		dma_free_writecombine(bdev->dev, BAM_DESC_FIFO_SIZE,
-			bdev->channels[i].fifo_virt,
-			bdev->channels[i].fifo_phys);
+		dma_free_wc(bdev->dev, BAM_DESC_FIFO_SIZE,
+			    bdev->channels[i].fifo_virt,
+			    bdev->channels[i].fifo_phys);
 	}
 
 	tasklet_kill(&bdev->task);
diff --git a/drivers/gpu/drm/drm_gem_cma_helper.c b/drivers/gpu/drm/drm_gem_cma_helper.c
index bd75f303da63..138142fcaf75 100644
--- a/drivers/gpu/drm/drm_gem_cma_helper.c
+++ b/drivers/gpu/drm/drm_gem_cma_helper.c
@@ -107,8 +107,8 @@ struct drm_gem_cma_object *drm_gem_cma_create(struct drm_device *drm,
 	if (IS_ERR(cma_obj))
 		return cma_obj;
 
-	cma_obj->vaddr = dma_alloc_writecombine(drm->dev, size,
-			&cma_obj->paddr, GFP_KERNEL | __GFP_NOWARN);
+	cma_obj->vaddr = dma_alloc_wc(drm->dev, size, &cma_obj->paddr,
+				      GFP_KERNEL | __GFP_NOWARN);
 	if (!cma_obj->vaddr) {
 		dev_err(drm->dev, "failed to allocate buffer with size %zu\n",
 			size);
@@ -190,8 +190,8 @@ void drm_gem_cma_free_object(struct drm_gem_object *gem_obj)
 	cma_obj = to_drm_gem_cma_obj(gem_obj);
 
 	if (cma_obj->vaddr) {
-		dma_free_writecombine(gem_obj->dev->dev, cma_obj->base.size,
-				      cma_obj->vaddr, cma_obj->paddr);
+		dma_free_wc(gem_obj->dev->dev, cma_obj->base.size,
+			    cma_obj->vaddr, cma_obj->paddr);
 	} else if (gem_obj->import_attach) {
 		drm_prime_gem_destroy(gem_obj, cma_obj->sgt);
 	}
@@ -327,9 +327,8 @@ static int drm_gem_cma_mmap_obj(struct drm_gem_cma_object *cma_obj,
 	vma->vm_flags &= ~VM_PFNMAP;
 	vma->vm_pgoff = 0;
 
-	ret = dma_mmap_writecombine(cma_obj->base.dev->dev, vma,
-				    cma_obj->vaddr, cma_obj->paddr,
-				    vma->vm_end - vma->vm_start);
+	ret = dma_mmap_wc(cma_obj->base.dev->dev, vma, cma_obj->vaddr,
+			  cma_obj->paddr, vma->vm_end - vma->vm_start);
 	if (ret)
 		drm_gem_vm_close(vma);
 
diff --git a/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c b/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c
index 7841970de48d..43f0697ce752 100644
--- a/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c
+++ b/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c
@@ -570,10 +570,9 @@ static int omap_dmm_remove(struct platform_device *dev)
 
 		kfree(omap_dmm->engines);
 		if (omap_dmm->refill_va)
-			dma_free_writecombine(omap_dmm->dev,
-				REFILL_BUFFER_SIZE * omap_dmm->num_engines,
-				omap_dmm->refill_va,
-				omap_dmm->refill_pa);
+			dma_free_wc(omap_dmm->dev,
+				    REFILL_BUFFER_SIZE * omap_dmm->num_engines,
+				    omap_dmm->refill_va, omap_dmm->refill_pa);
 		if (omap_dmm->dummy_page)
 			__free_page(omap_dmm->dummy_page);
 
@@ -698,9 +697,9 @@ static int omap_dmm_probe(struct platform_device *dev)
 	omap_dmm->dummy_pa = page_to_phys(omap_dmm->dummy_page);
 
 	/* alloc refill memory */
-	omap_dmm->refill_va = dma_alloc_writecombine(&dev->dev,
-				REFILL_BUFFER_SIZE * omap_dmm->num_engines,
-				&omap_dmm->refill_pa, GFP_KERNEL);
+	omap_dmm->refill_va = dma_alloc_wc(&dev->dev,
+					   REFILL_BUFFER_SIZE * omap_dmm->num_engines,
+					   &omap_dmm->refill_pa, GFP_KERNEL);
 	if (!omap_dmm->refill_va) {
 		dev_err(&dev->dev, "could not allocate refill memory\n");
 		goto fail;
diff --git a/drivers/gpu/drm/omapdrm/omap_gem.c b/drivers/gpu/drm/omapdrm/omap_gem.c
index 7ed08fdc4c42..be3635b93527 100644
--- a/drivers/gpu/drm/omapdrm/omap_gem.c
+++ b/drivers/gpu/drm/omapdrm/omap_gem.c
@@ -1295,8 +1295,8 @@ void omap_gem_free_object(struct drm_gem_object *obj)
 			omap_gem_detach_pages(obj);
 
 		if (!is_shmem(obj)) {
-			dma_free_writecombine(dev->dev, obj->size,
-					omap_obj->vaddr, omap_obj->paddr);
+			dma_free_wc(dev->dev, obj->size, omap_obj->vaddr,
+				    omap_obj->paddr);
 		} else if (omap_obj->vaddr) {
 			vunmap(omap_obj->vaddr);
 		}
@@ -1384,8 +1384,8 @@ struct drm_gem_object *omap_gem_new(struct drm_device *dev,
 		/* attempt to allocate contiguous memory if we don't
 		 * have DMM for remappign discontiguous buffers
 		 */
-		omap_obj->vaddr =  dma_alloc_writecombine(dev->dev, size,
-				&omap_obj->paddr, GFP_KERNEL);
+		omap_obj->vaddr =  dma_alloc_wc(dev->dev, size,
+						&omap_obj->paddr, GFP_KERNEL);
 		if (!omap_obj->vaddr) {
 			kfree(omap_obj);
 
diff --git a/drivers/gpu/drm/sti/sti_cursor.c b/drivers/gpu/drm/sti/sti_cursor.c
index 010eaee60bf7..75bdbf140fb0 100644
--- a/drivers/gpu/drm/sti/sti_cursor.c
+++ b/drivers/gpu/drm/sti/sti_cursor.c
@@ -124,17 +124,15 @@ static int sti_cursor_prepare_layer(struct sti_layer *layer, bool first_prepare)
 		cursor->height = layer->src_h;
 
 		if (cursor->pixmap.base)
-			dma_free_writecombine(layer->dev,
-					      cursor->pixmap.size,
-					      cursor->pixmap.base,
-					      cursor->pixmap.paddr);
+			dma_free_wc(layer->dev, cursor->pixmap.size,
+				    cursor->pixmap.base, cursor->pixmap.paddr);
 
 		cursor->pixmap.size = cursor->width * cursor->height;
 
-		cursor->pixmap.base = dma_alloc_writecombine(layer->dev,
-							cursor->pixmap.size,
-							&cursor->pixmap.paddr,
-							GFP_KERNEL | GFP_DMA);
+		cursor->pixmap.base = dma_alloc_wc(layer->dev,
+						   cursor->pixmap.size,
+						   &cursor->pixmap.paddr,
+						   GFP_KERNEL | GFP_DMA);
 		if (!cursor->pixmap.base) {
 			DRM_ERROR("Failed to allocate memory for pixmap\n");
 			return -ENOMEM;
@@ -225,10 +223,8 @@ struct sti_layer *sti_cursor_create(struct device *dev)
 	}
 
 	/* Allocate clut buffer */
-	cursor->clut = dma_alloc_writecombine(dev,
-			0x100 * sizeof(unsigned short),
-			&cursor->clut_paddr,
-			GFP_KERNEL | GFP_DMA);
+	cursor->clut = dma_alloc_wc(dev, 0x100 * sizeof(unsigned short),
+				    &cursor->clut_paddr, GFP_KERNEL | GFP_DMA);
 
 	if (!cursor->clut) {
 		DRM_ERROR("Failed to allocate memory for cursor clut\n");
diff --git a/drivers/gpu/drm/sti/sti_gdp.c b/drivers/gpu/drm/sti/sti_gdp.c
index 087906fd8846..9bf293ee3bc3 100644
--- a/drivers/gpu/drm/sti/sti_gdp.c
+++ b/drivers/gpu/drm/sti/sti_gdp.c
@@ -490,8 +490,7 @@ static void sti_gdp_init(struct sti_layer *layer)
 	/* Allocate all the nodes within a single memory page */
 	size = sizeof(struct sti_gdp_node) *
 	    GDP_NODE_PER_FIELD * GDP_NODE_NB_BANK;
-	base = dma_alloc_writecombine(layer->dev,
-			size, &dma_addr, GFP_KERNEL | GFP_DMA);
+	base = dma_alloc_wc(layer->dev, size, &dma_addr, GFP_KERNEL | GFP_DMA);
 
 	if (!base) {
 		DRM_ERROR("Failed to allocate memory for GDP node\n");
diff --git a/drivers/gpu/drm/sti/sti_hqvdp.c b/drivers/gpu/drm/sti/sti_hqvdp.c
index b0eb62de1b2e..025f48795b9c 100644
--- a/drivers/gpu/drm/sti/sti_hqvdp.c
+++ b/drivers/gpu/drm/sti/sti_hqvdp.c
@@ -788,9 +788,9 @@ static void sti_hqvd_init(struct sti_layer *layer)
 
 	/* Allocate memory for the VDP commands */
 	size = NB_VDP_CMD * sizeof(struct sti_hqvdp_cmd);
-	hqvdp->hqvdp_cmd = dma_alloc_writecombine(hqvdp->dev, size,
-					 &hqvdp->hqvdp_cmd_paddr,
-					 GFP_KERNEL | GFP_DMA);
+	hqvdp->hqvdp_cmd = dma_alloc_wc(hqvdp->dev, size,
+					&hqvdp->hqvdp_cmd_paddr,
+					GFP_KERNEL | GFP_DMA);
 	if (!hqvdp->hqvdp_cmd) {
 		DRM_ERROR("Failed to allocate memory for VDP cmd\n");
 		return;
diff --git a/drivers/gpu/drm/tegra/gem.c b/drivers/gpu/drm/tegra/gem.c
index 01e16e146bfe..82777d424f23 100644
--- a/drivers/gpu/drm/tegra/gem.c
+++ b/drivers/gpu/drm/tegra/gem.c
@@ -181,8 +181,7 @@ static void tegra_bo_free(struct drm_device *drm, struct tegra_bo *bo)
 		sg_free_table(bo->sgt);
 		kfree(bo->sgt);
 	} else if (bo->vaddr) {
-		dma_free_writecombine(drm->dev, bo->gem.size, bo->vaddr,
-				      bo->paddr);
+		dma_free_wc(drm->dev, bo->gem.size, bo->vaddr, bo->paddr);
 	}
 }
 
@@ -239,8 +238,8 @@ static int tegra_bo_alloc(struct drm_device *drm, struct tegra_bo *bo)
 	} else {
 		size_t size = bo->gem.size;
 
-		bo->vaddr = dma_alloc_writecombine(drm->dev, size, &bo->paddr,
-						   GFP_KERNEL | __GFP_NOWARN);
+		bo->vaddr = dma_alloc_wc(drm->dev, size, &bo->paddr,
+					 GFP_KERNEL | __GFP_NOWARN);
 		if (!bo->vaddr) {
 			dev_err(drm->dev,
 				"failed to allocate buffer of size %zu\n",
@@ -483,8 +482,8 @@ int tegra_drm_mmap(struct file *file, struct vm_area_struct *vma)
 		vma->vm_flags &= ~VM_PFNMAP;
 		vma->vm_pgoff = 0;
 
-		ret = dma_mmap_writecombine(gem->dev->dev, vma, bo->vaddr,
-					    bo->paddr, gem->size);
+		ret = dma_mmap_wc(gem->dev->dev, vma, bo->vaddr, bo->paddr,
+				  gem->size);
 		if (ret) {
 			drm_gem_vm_close(vma);
 			return ret;
diff --git a/drivers/gpu/host1x/cdma.c b/drivers/gpu/host1x/cdma.c
index 5a8c8d55317a..a18db4d5347c 100644
--- a/drivers/gpu/host1x/cdma.c
+++ b/drivers/gpu/host1x/cdma.c
@@ -52,8 +52,8 @@ static void host1x_pushbuffer_destroy(struct push_buffer *pb)
 	struct host1x *host1x = cdma_to_host1x(cdma);
 
 	if (pb->phys != 0)
-		dma_free_writecombine(host1x->dev, pb->size_bytes + 4,
-				      pb->mapped, pb->phys);
+		dma_free_wc(host1x->dev, pb->size_bytes + 4, pb->mapped,
+			    pb->phys);
 
 	pb->mapped = NULL;
 	pb->phys = 0;
@@ -76,8 +76,8 @@ static int host1x_pushbuffer_init(struct push_buffer *pb)
 	pb->pos = 0;
 
 	/* allocate and map pushbuffer memory */
-	pb->mapped = dma_alloc_writecombine(host1x->dev, pb->size_bytes + 4,
-					    &pb->phys, GFP_KERNEL);
+	pb->mapped = dma_alloc_wc(host1x->dev, pb->size_bytes + 4, &pb->phys,
+				  GFP_KERNEL);
 	if (!pb->mapped)
 		goto fail;
 
diff --git a/drivers/gpu/host1x/job.c b/drivers/gpu/host1x/job.c
index 63bd63f3c7df..defa7995f213 100644
--- a/drivers/gpu/host1x/job.c
+++ b/drivers/gpu/host1x/job.c
@@ -467,9 +467,8 @@ static inline int copy_gathers(struct host1x_job *job, struct device *dev)
 		size += g->words * sizeof(u32);
 	}
 
-	job->gather_copy_mapped = dma_alloc_writecombine(dev, size,
-							 &job->gather_copy,
-							 GFP_KERNEL);
+	job->gather_copy_mapped = dma_alloc_wc(dev, size, &job->gather_copy,
+					       GFP_KERNEL);
 	if (!job->gather_copy_mapped) {
 		job->gather_copy_mapped = NULL;
 		return -ENOMEM;
@@ -578,9 +577,8 @@ void host1x_job_unpin(struct host1x_job *job)
 	job->num_unpins = 0;
 
 	if (job->gather_copy_size)
-		dma_free_writecombine(job->channel->dev, job->gather_copy_size,
-				      job->gather_copy_mapped,
-				      job->gather_copy);
+		dma_free_wc(job->channel->dev, job->gather_copy_size,
+		            job->gather_copy_mapped, job->gather_copy);
 }
 EXPORT_SYMBOL(host1x_job_unpin);
 
diff --git a/drivers/media/platform/coda/coda-bit.c b/drivers/media/platform/coda/coda-bit.c
index 109797bb8fbb..d1e1658a4f35 100644
--- a/drivers/media/platform/coda/coda-bit.c
+++ b/drivers/media/platform/coda/coda-bit.c
@@ -1373,9 +1373,9 @@ static int coda_alloc_bitstream_buffer(struct coda_ctx *ctx,
 		return 0;
 
 	ctx->bitstream.size = roundup_pow_of_two(q_data->sizeimage * 2);
-	ctx->bitstream.vaddr = dma_alloc_writecombine(
-			&ctx->dev->plat_dev->dev, ctx->bitstream.size,
-			&ctx->bitstream.paddr, GFP_KERNEL);
+	ctx->bitstream.vaddr = dma_alloc_wc(&ctx->dev->plat_dev->dev,
+					    ctx->bitstream.size,
+					    &ctx->bitstream.paddr, GFP_KERNEL);
 	if (!ctx->bitstream.vaddr) {
 		v4l2_err(&ctx->dev->v4l2_dev,
 			 "failed to allocate bitstream ringbuffer");
@@ -1392,8 +1392,8 @@ static void coda_free_bitstream_buffer(struct coda_ctx *ctx)
 	if (ctx->bitstream.vaddr == NULL)
 		return;
 
-	dma_free_writecombine(&ctx->dev->plat_dev->dev, ctx->bitstream.size,
-			      ctx->bitstream.vaddr, ctx->bitstream.paddr);
+	dma_free_wc(&ctx->dev->plat_dev->dev, ctx->bitstream.size,
+		    ctx->bitstream.vaddr, ctx->bitstream.paddr);
 	ctx->bitstream.vaddr = NULL;
 	kfifo_init(&ctx->bitstream_fifo, NULL, 0);
 }
diff --git a/drivers/video/fbdev/acornfb.c b/drivers/video/fbdev/acornfb.c
index a305caea58ee..fb75b7e5a19a 100644
--- a/drivers/video/fbdev/acornfb.c
+++ b/drivers/video/fbdev/acornfb.c
@@ -1040,8 +1040,8 @@ static int acornfb_probe(struct platform_device *dev)
 		 * for the framebuffer if we are not using
 		 * VRAM.
 		 */
-		base = dma_alloc_writecombine(current_par.dev, size, &handle,
-					      GFP_KERNEL);
+		base = dma_alloc_wc(current_par.dev, size, &handle,
+				    GFP_KERNEL);
 		if (base == NULL) {
 			printk(KERN_ERR "acornfb: unable to allocate screen "
 			       "memory\n");
diff --git a/drivers/video/fbdev/amba-clcd-versatile.c b/drivers/video/fbdev/amba-clcd-versatile.c
index 7a8afcd4573e..a8a22daa3f9d 100644
--- a/drivers/video/fbdev/amba-clcd-versatile.c
+++ b/drivers/video/fbdev/amba-clcd-versatile.c
@@ -154,8 +154,8 @@ int versatile_clcd_setup_dma(struct clcd_fb *fb, unsigned long framesize)
 {
 	dma_addr_t dma;
 
-	fb->fb.screen_base = dma_alloc_writecombine(&fb->dev->dev, framesize,
-						    &dma, GFP_KERNEL);
+	fb->fb.screen_base = dma_alloc_wc(&fb->dev->dev, framesize, &dma,
+					  GFP_KERNEL);
 	if (!fb->fb.screen_base) {
 		pr_err("CLCD: unable to map framebuffer\n");
 		return -ENOMEM;
@@ -169,14 +169,12 @@ int versatile_clcd_setup_dma(struct clcd_fb *fb, unsigned long framesize)
 
 int versatile_clcd_mmap_dma(struct clcd_fb *fb, struct vm_area_struct *vma)
 {
-	return dma_mmap_writecombine(&fb->dev->dev, vma,
-				     fb->fb.screen_base,
-				     fb->fb.fix.smem_start,
-				     fb->fb.fix.smem_len);
+	return dma_mmap_wc(&fb->dev->dev, vma, fb->fb.screen_base,
+			   fb->fb.fix.smem_start, fb->fb.fix.smem_len);
 }
 
 void versatile_clcd_remove_dma(struct clcd_fb *fb)
 {
-	dma_free_writecombine(&fb->dev->dev, fb->fb.fix.smem_len,
-			      fb->fb.screen_base, fb->fb.fix.smem_start);
+	dma_free_wc(&fb->dev->dev, fb->fb.fix.smem_len, fb->fb.screen_base,
+		    fb->fb.fix.smem_start);
 }
diff --git a/drivers/video/fbdev/amba-clcd.c b/drivers/video/fbdev/amba-clcd.c
index 9362424c2340..fe274b5851c7 100644
--- a/drivers/video/fbdev/amba-clcd.c
+++ b/drivers/video/fbdev/amba-clcd.c
@@ -774,8 +774,8 @@ static int clcdfb_of_dma_setup(struct clcd_fb *fb)
 
 static int clcdfb_of_dma_mmap(struct clcd_fb *fb, struct vm_area_struct *vma)
 {
-	return dma_mmap_writecombine(&fb->dev->dev, vma, fb->fb.screen_base,
-			fb->fb.fix.smem_start, fb->fb.fix.smem_len);
+	return dma_mmap_wc(&fb->dev->dev, vma, fb->fb.screen_base,
+			   fb->fb.fix.smem_start, fb->fb.fix.smem_len);
 }
 
 static void clcdfb_of_dma_remove(struct clcd_fb *fb)
diff --git a/drivers/video/fbdev/atmel_lcdfb.c b/drivers/video/fbdev/atmel_lcdfb.c
index abadc490fa1f..689fb9d99988 100644
--- a/drivers/video/fbdev/atmel_lcdfb.c
+++ b/drivers/video/fbdev/atmel_lcdfb.c
@@ -415,8 +415,8 @@ static inline void atmel_lcdfb_free_video_memory(struct atmel_lcdfb_info *sinfo)
 {
 	struct fb_info *info = sinfo->info;
 
-	dma_free_writecombine(info->device, info->fix.smem_len,
-				info->screen_base, info->fix.smem_start);
+	dma_free_wc(info->device, info->fix.smem_len, info->screen_base,
+		    info->fix.smem_start);
 }
 
 /**
@@ -436,8 +436,9 @@ static int atmel_lcdfb_alloc_video_memory(struct atmel_lcdfb_info *sinfo)
 		    * ((var->bits_per_pixel + 7) / 8));
 	info->fix.smem_len = max(smem_len, sinfo->smem_len);
 
-	info->screen_base = dma_alloc_writecombine(info->device, info->fix.smem_len,
-					(dma_addr_t *)&info->fix.smem_start, GFP_KERNEL);
+	info->screen_base = dma_alloc_wc(info->device, info->fix.smem_len,
+					 (dma_addr_t *)&info->fix.smem_start,
+					 GFP_KERNEL);
 
 	if (!info->screen_base) {
 		return -ENOMEM;
diff --git a/drivers/video/fbdev/ep93xx-fb.c b/drivers/video/fbdev/ep93xx-fb.c
index 7ec251cc9c03..e876b83e4600 100644
--- a/drivers/video/fbdev/ep93xx-fb.c
+++ b/drivers/video/fbdev/ep93xx-fb.c
@@ -316,9 +316,8 @@ static int ep93xxfb_mmap(struct fb_info *info, struct vm_area_struct *vma)
 	unsigned int offset = vma->vm_pgoff << PAGE_SHIFT;
 
 	if (offset < info->fix.smem_len) {
-		return dma_mmap_writecombine(info->dev, vma, info->screen_base,
-					     info->fix.smem_start,
-					     info->fix.smem_len);
+		return dma_mmap_wc(info->dev, vma, info->screen_base,
+				   info->fix.smem_start, info->fix.smem_len);
 	}
 
 	return -EINVAL;
@@ -449,8 +448,7 @@ static int ep93xxfb_alloc_videomem(struct fb_info *info)
 	unsigned int fb_size;
 
 	fb_size = ep93xxfb_calc_fbsize(fbi->mach_info);
-	virt_addr = dma_alloc_writecombine(info->dev, fb_size,
-					   &phys_addr, GFP_KERNEL);
+	virt_addr = dma_alloc_wc(info->dev, fb_size, &phys_addr, GFP_KERNEL);
 	if (!virt_addr)
 		return -ENOMEM;
 
diff --git a/drivers/video/fbdev/gbefb.c b/drivers/video/fbdev/gbefb.c
index b63d55f481fa..1a242b1338e9 100644
--- a/drivers/video/fbdev/gbefb.c
+++ b/drivers/video/fbdev/gbefb.c
@@ -1185,8 +1185,8 @@ static int gbefb_probe(struct platform_device *p_dev)
 	} else {
 		/* try to allocate memory with the classical allocator
 		 * this has high chance to fail on low memory machines */
-		gbe_mem = dma_alloc_writecombine(NULL, gbe_mem_size,
-						 &gbe_dma_addr, GFP_KERNEL);
+		gbe_mem = dma_alloc_wc(NULL, gbe_mem_size, &gbe_dma_addr,
+				       GFP_KERNEL);
 		if (!gbe_mem) {
 			printk(KERN_ERR "gbefb: couldn't allocate framebuffer memory\n");
 			ret = -ENOMEM;
@@ -1238,7 +1238,7 @@ static int gbefb_probe(struct platform_device *p_dev)
 out_gbe_unmap:
 	arch_phys_wc_del(par->wc_cookie);
 	if (gbe_dma_addr)
-		dma_free_writecombine(NULL, gbe_mem_size, gbe_mem, gbe_mem_phys);
+		dma_free_wc(NULL, gbe_mem_size, gbe_mem, gbe_mem_phys);
 out_tiles_free:
 	dma_free_coherent(NULL, GBE_TLB_SIZE * sizeof(uint16_t),
 			  (void *)gbe_tiles.cpu, gbe_tiles.dma);
@@ -1259,7 +1259,7 @@ static int gbefb_remove(struct platform_device* p_dev)
 	gbe_turn_off();
 	arch_phys_wc_del(par->wc_cookie);
 	if (gbe_dma_addr)
-		dma_free_writecombine(NULL, gbe_mem_size, gbe_mem, gbe_mem_phys);
+		dma_free_wc(NULL, gbe_mem_size, gbe_mem, gbe_mem_phys);
 	dma_free_coherent(NULL, GBE_TLB_SIZE * sizeof(uint16_t),
 			  (void *)gbe_tiles.cpu, gbe_tiles.dma);
 	release_mem_region(GBE_BASE, sizeof(struct sgi_gbe));
diff --git a/drivers/video/fbdev/imxfb.c b/drivers/video/fbdev/imxfb.c
index cee88603efc9..465b3387c549 100644
--- a/drivers/video/fbdev/imxfb.c
+++ b/drivers/video/fbdev/imxfb.c
@@ -922,8 +922,8 @@ static int imxfb_probe(struct platform_device *pdev)
 	}
 
 	fbi->map_size = PAGE_ALIGN(info->fix.smem_len);
-	info->screen_base = dma_alloc_writecombine(&pdev->dev, fbi->map_size,
-						   &fbi->map_dma, GFP_KERNEL);
+	info->screen_base = dma_alloc_wc(&pdev->dev, fbi->map_size,
+					 &fbi->map_dma, GFP_KERNEL);
 
 	if (!info->screen_base) {
 		dev_err(&pdev->dev, "Failed to allocate video RAM: %d\n", ret);
@@ -990,8 +990,8 @@ failed_cmap:
 	if (pdata && pdata->exit)
 		pdata->exit(fbi->pdev);
 failed_platform_init:
-	dma_free_writecombine(&pdev->dev, fbi->map_size, info->screen_base,
-			      fbi->map_dma);
+	dma_free_wc(&pdev->dev, fbi->map_size, info->screen_base,
+		    fbi->map_dma);
 failed_map:
 	iounmap(fbi->regs);
 failed_ioremap:
@@ -1026,8 +1026,8 @@ static int imxfb_remove(struct platform_device *pdev)
 	kfree(info->pseudo_palette);
 	framebuffer_release(info);
 
-	dma_free_writecombine(&pdev->dev, fbi->map_size, info->screen_base,
-			      fbi->map_dma);
+	dma_free_wc(&pdev->dev, fbi->map_size, info->screen_base,
+		    fbi->map_dma);
 
 	iounmap(fbi->regs);
 	release_mem_region(res->start, resource_size(res));
diff --git a/drivers/video/fbdev/mx3fb.c b/drivers/video/fbdev/mx3fb.c
index 7947634ee6b0..f91b1db262b0 100644
--- a/drivers/video/fbdev/mx3fb.c
+++ b/drivers/video/fbdev/mx3fb.c
@@ -1336,9 +1336,8 @@ static int mx3fb_map_video_memory(struct fb_info *fbi, unsigned int mem_len,
 	int retval = 0;
 	dma_addr_t addr;
 
-	fbi->screen_base = dma_alloc_writecombine(fbi->device,
-						  mem_len,
-						  &addr, GFP_DMA | GFP_KERNEL);
+	fbi->screen_base = dma_alloc_wc(fbi->device, mem_len, &addr,
+					GFP_DMA | GFP_KERNEL);
 
 	if (!fbi->screen_base) {
 		dev_err(fbi->device, "Cannot allocate %u bytes framebuffer memory\n",
@@ -1378,8 +1377,8 @@ err0:
  */
 static int mx3fb_unmap_video_memory(struct fb_info *fbi)
 {
-	dma_free_writecombine(fbi->device, fbi->fix.smem_len,
-			      fbi->screen_base, fbi->fix.smem_start);
+	dma_free_wc(fbi->device, fbi->fix.smem_len, fbi->screen_base,
+		    fbi->fix.smem_start);
 
 	fbi->screen_base = NULL;
 	mutex_lock(&fbi->mm_lock);
diff --git a/drivers/video/fbdev/nuc900fb.c b/drivers/video/fbdev/nuc900fb.c
index 389fa2cbb713..6680edae4696 100644
--- a/drivers/video/fbdev/nuc900fb.c
+++ b/drivers/video/fbdev/nuc900fb.c
@@ -396,8 +396,8 @@ static int nuc900fb_map_video_memory(struct fb_info *info)
 	dev_dbg(fbi->dev, "nuc900fb_map_video_memory(fbi=%p) map_size %lu\n",
 		fbi, map_size);
 
-	info->screen_base = dma_alloc_writecombine(fbi->dev, map_size,
-							&map_dma, GFP_KERNEL);
+	info->screen_base = dma_alloc_wc(fbi->dev, map_size, &map_dma,
+					 GFP_KERNEL);
 
 	if (!info->screen_base)
 		return -ENOMEM;
@@ -411,8 +411,8 @@ static int nuc900fb_map_video_memory(struct fb_info *info)
 static inline void nuc900fb_unmap_video_memory(struct fb_info *info)
 {
 	struct nuc900fb_info *fbi = info->par;
-	dma_free_writecombine(fbi->dev, PAGE_ALIGN(info->fix.smem_len),
-			      info->screen_base, info->fix.smem_start);
+	dma_free_wc(fbi->dev, PAGE_ALIGN(info->fix.smem_len),
+		    info->screen_base, info->fix.smem_start);
 }
 
 static irqreturn_t nuc900fb_irqhandler(int irq, void *dev_id)
diff --git a/drivers/video/fbdev/omap/lcdc.c b/drivers/video/fbdev/omap/lcdc.c
index 6efa2591eaa8..e3d9b9ea5498 100644
--- a/drivers/video/fbdev/omap/lcdc.c
+++ b/drivers/video/fbdev/omap/lcdc.c
@@ -612,8 +612,8 @@ static void lcdc_dma_handler(u16 status, void *data)
 
 static int alloc_palette_ram(void)
 {
-	lcdc.palette_virt = dma_alloc_writecombine(lcdc.fbdev->dev,
-		MAX_PALETTE_SIZE, &lcdc.palette_phys, GFP_KERNEL);
+	lcdc.palette_virt = dma_alloc_wc(lcdc.fbdev->dev, MAX_PALETTE_SIZE,
+					 &lcdc.palette_phys, GFP_KERNEL);
 	if (lcdc.palette_virt == NULL) {
 		dev_err(lcdc.fbdev->dev, "failed to alloc palette memory\n");
 		return -ENOMEM;
@@ -625,8 +625,8 @@ static int alloc_palette_ram(void)
 
 static void free_palette_ram(void)
 {
-	dma_free_writecombine(lcdc.fbdev->dev, MAX_PALETTE_SIZE,
-			lcdc.palette_virt, lcdc.palette_phys);
+	dma_free_wc(lcdc.fbdev->dev, MAX_PALETTE_SIZE, lcdc.palette_virt,
+		    lcdc.palette_phys);
 }
 
 static int alloc_fbmem(struct omapfb_mem_region *region)
@@ -642,8 +642,8 @@ static int alloc_fbmem(struct omapfb_mem_region *region)
 	if (region->size > frame_size)
 		frame_size = region->size;
 	lcdc.vram_size = frame_size;
-	lcdc.vram_virt = dma_alloc_writecombine(lcdc.fbdev->dev,
-			lcdc.vram_size, &lcdc.vram_phys, GFP_KERNEL);
+	lcdc.vram_virt = dma_alloc_wc(lcdc.fbdev->dev, lcdc.vram_size,
+				      &lcdc.vram_phys, GFP_KERNEL);
 	if (lcdc.vram_virt == NULL) {
 		dev_err(lcdc.fbdev->dev, "unable to allocate FB DMA memory\n");
 		return -ENOMEM;
@@ -660,8 +660,8 @@ static int alloc_fbmem(struct omapfb_mem_region *region)
 
 static void free_fbmem(void)
 {
-	dma_free_writecombine(lcdc.fbdev->dev, lcdc.vram_size,
-			      lcdc.vram_virt, lcdc.vram_phys);
+	dma_free_wc(lcdc.fbdev->dev, lcdc.vram_size, lcdc.vram_virt,
+		    lcdc.vram_phys);
 }
 
 static int setup_fbmem(struct omapfb_mem_desc *req_md)
diff --git a/drivers/video/fbdev/pxa168fb.c b/drivers/video/fbdev/pxa168fb.c
index e209b039f553..04bd7237da6f 100644
--- a/drivers/video/fbdev/pxa168fb.c
+++ b/drivers/video/fbdev/pxa168fb.c
@@ -683,8 +683,8 @@ static int pxa168fb_probe(struct platform_device *pdev)
 	 */
 	info->fix.smem_len = PAGE_ALIGN(DEFAULT_FB_SIZE);
 
-	info->screen_base = dma_alloc_writecombine(fbi->dev, info->fix.smem_len,
-						&fbi->fb_start_dma, GFP_KERNEL);
+	info->screen_base = dma_alloc_wc(fbi->dev, info->fix.smem_len,
+					 &fbi->fb_start_dma, GFP_KERNEL);
 	if (info->screen_base == NULL) {
 		ret = -ENOMEM;
 		goto failed_free_info;
@@ -809,8 +809,8 @@ static int pxa168fb_remove(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 
-	dma_free_writecombine(fbi->dev, PAGE_ALIGN(info->fix.smem_len),
-				info->screen_base, info->fix.smem_start);
+	dma_free_wc(fbi->dev, PAGE_ALIGN(info->fix.smem_len),
+		    info->screen_base, info->fix.smem_start);
 
 	clk_disable(fbi->clk);
 	clk_put(fbi->clk);
diff --git a/drivers/video/fbdev/pxafb.c b/drivers/video/fbdev/pxafb.c
index 7245611ec963..6a5b9801396a 100644
--- a/drivers/video/fbdev/pxafb.c
+++ b/drivers/video/fbdev/pxafb.c
@@ -2286,8 +2286,8 @@ static int pxafb_remove(struct platform_device *dev)
 
 	free_pages_exact(fbi->video_mem, fbi->video_mem_size);
 
-	dma_free_writecombine(&dev->dev, fbi->dma_buff_size,
-			fbi->dma_buff, fbi->dma_buff_phys);
+	dma_free_wc(&dev->dev, fbi->dma_buff_size, fbi->dma_buff,
+		    fbi->dma_buff_phys);
 
 	iounmap(fbi->mmio_base);
 
diff --git a/drivers/video/fbdev/s3c-fb.c b/drivers/video/fbdev/s3c-fb.c
index 7e3a05fc47aa..b7e3571c396f 100644
--- a/drivers/video/fbdev/s3c-fb.c
+++ b/drivers/video/fbdev/s3c-fb.c
@@ -1105,8 +1105,7 @@ static int s3c_fb_alloc_memory(struct s3c_fb *sfb, struct s3c_fb_win *win)
 
 	dev_dbg(sfb->dev, "want %u bytes for window\n", size);
 
-	fbi->screen_base = dma_alloc_writecombine(sfb->dev, size,
-						  &map_dma, GFP_KERNEL);
+	fbi->screen_base = dma_alloc_wc(sfb->dev, size, &map_dma, GFP_KERNEL);
 	if (!fbi->screen_base)
 		return -ENOMEM;
 
@@ -1131,8 +1130,8 @@ static void s3c_fb_free_memory(struct s3c_fb *sfb, struct s3c_fb_win *win)
 	struct fb_info *fbi = win->fbinfo;
 
 	if (fbi->screen_base)
-		dma_free_writecombine(sfb->dev, PAGE_ALIGN(fbi->fix.smem_len),
-			      fbi->screen_base, fbi->fix.smem_start);
+		dma_free_wc(sfb->dev, PAGE_ALIGN(fbi->fix.smem_len),
+		            fbi->screen_base, fbi->fix.smem_start);
 }
 
 /**
diff --git a/drivers/video/fbdev/s3c2410fb.c b/drivers/video/fbdev/s3c2410fb.c
index d6704add1601..0dd86be36afb 100644
--- a/drivers/video/fbdev/s3c2410fb.c
+++ b/drivers/video/fbdev/s3c2410fb.c
@@ -645,8 +645,8 @@ static int s3c2410fb_map_video_memory(struct fb_info *info)
 
 	dprintk("map_video_memory(fbi=%p) map_size %u\n", fbi, map_size);
 
-	info->screen_base = dma_alloc_writecombine(fbi->dev, map_size,
-						   &map_dma, GFP_KERNEL);
+	info->screen_base = dma_alloc_wc(fbi->dev, map_size, &map_dma,
+					 GFP_KERNEL);
 
 	if (info->screen_base) {
 		/* prevent initial garbage on screen */
@@ -667,8 +667,8 @@ static inline void s3c2410fb_unmap_video_memory(struct fb_info *info)
 {
 	struct s3c2410fb_info *fbi = info->par;
 
-	dma_free_writecombine(fbi->dev, PAGE_ALIGN(info->fix.smem_len),
-			      info->screen_base, info->fix.smem_start);
+	dma_free_wc(fbi->dev, PAGE_ALIGN(info->fix.smem_len),
+		    info->screen_base, info->fix.smem_start);
 }
 
 static inline void modify_gpio(void __iomem *reg,
diff --git a/drivers/video/fbdev/sa1100fb.c b/drivers/video/fbdev/sa1100fb.c
index 89dd7e02197f..66467eb190b2 100644
--- a/drivers/video/fbdev/sa1100fb.c
+++ b/drivers/video/fbdev/sa1100fb.c
@@ -567,8 +567,8 @@ static int sa1100fb_mmap(struct fb_info *info,
 
 	if (off < info->fix.smem_len) {
 		vma->vm_pgoff += 1; /* skip over the palette */
-		return dma_mmap_writecombine(fbi->dev, vma, fbi->map_cpu,
-					     fbi->map_dma, fbi->map_size);
+		return dma_mmap_wc(fbi->dev, vma, fbi->map_cpu, fbi->map_dma,
+				   fbi->map_size);
 	}
 
 	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
@@ -1100,8 +1100,8 @@ static int sa1100fb_map_video_memory(struct sa1100fb_info *fbi)
 	 * of the framebuffer.
 	 */
 	fbi->map_size = PAGE_ALIGN(fbi->fb.fix.smem_len + PAGE_SIZE);
-	fbi->map_cpu = dma_alloc_writecombine(fbi->dev, fbi->map_size,
-					      &fbi->map_dma, GFP_KERNEL);
+	fbi->map_cpu = dma_alloc_wc(fbi->dev, fbi->map_size, &fbi->map_dma,
+				    GFP_KERNEL);
 
 	if (fbi->map_cpu) {
 		fbi->fb.screen_base = fbi->map_cpu + PAGE_SIZE;
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index ac07ff090919..1f54e9bd6b34 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -271,26 +271,26 @@ struct dma_attrs;
 	dma_unmap_sg(dev, sgl, nents, dir)
 
 #else
-static inline void *dma_alloc_writecombine(struct device *dev, size_t size,
-					   dma_addr_t *dma_addr, gfp_t gfp)
+static inline void *dma_alloc_wc(struct device *dev, size_t size,
+				 dma_addr_t *dma_addr, gfp_t gfp)
 {
 	DEFINE_DMA_ATTRS(attrs);
 	dma_set_attr(DMA_ATTR_WRITE_COMBINE, &attrs);
 	return dma_alloc_attrs(dev, size, dma_addr, gfp, &attrs);
 }
 
-static inline void dma_free_writecombine(struct device *dev, size_t size,
-					 void *cpu_addr, dma_addr_t dma_addr)
+static inline void dma_free_wc(struct device *dev, size_t size,
+			       void *cpu_addr, dma_addr_t dma_addr)
 {
 	DEFINE_DMA_ATTRS(attrs);
 	dma_set_attr(DMA_ATTR_WRITE_COMBINE, &attrs);
 	return dma_free_attrs(dev, size, cpu_addr, dma_addr, &attrs);
 }
 
-static inline int dma_mmap_writecombine(struct device *dev,
-					struct vm_area_struct *vma,
-					void *cpu_addr, dma_addr_t dma_addr,
-					size_t size)
+static inline int dma_mmap_wc(struct device *dev,
+			      struct vm_area_struct *vma,
+			      void *cpu_addr, dma_addr_t dma_addr,
+			      size_t size)
 {
 	DEFINE_DMA_ATTRS(attrs);
 	dma_set_attr(DMA_ATTR_WRITE_COMBINE, &attrs);
diff --git a/sound/arm/pxa2xx-pcm-lib.c b/sound/arm/pxa2xx-pcm-lib.c
index 01f8fdc42b1b..5596f7cc8e73 100644
--- a/sound/arm/pxa2xx-pcm-lib.c
+++ b/sound/arm/pxa2xx-pcm-lib.c
@@ -238,8 +238,8 @@ int __pxa2xx_pcm_open(struct snd_pcm_substream *substream)
 	if (!rtd)
 		goto out;
 	rtd->dma_desc_array =
-		dma_alloc_writecombine(substream->pcm->card->dev, PAGE_SIZE,
-				       &rtd->dma_desc_array_phys, GFP_KERNEL);
+		dma_alloc_wc(substream->pcm->card->dev, PAGE_SIZE,
+			     &rtd->dma_desc_array_phys, GFP_KERNEL);
 	if (!rtd->dma_desc_array)
 		goto err1;
 
@@ -259,8 +259,8 @@ int __pxa2xx_pcm_close(struct snd_pcm_substream *substream)
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct pxa2xx_runtime_data *rtd = runtime->private_data;
 
-	dma_free_writecombine(substream->pcm->card->dev, PAGE_SIZE,
-			      rtd->dma_desc_array, rtd->dma_desc_array_phys);
+	dma_free_wc(substream->pcm->card->dev, PAGE_SIZE,
+		    rtd->dma_desc_array, rtd->dma_desc_array_phys);
 	kfree(rtd);
 	return 0;
 }
@@ -270,10 +270,8 @@ int pxa2xx_pcm_mmap(struct snd_pcm_substream *substream,
 	struct vm_area_struct *vma)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
-	return dma_mmap_writecombine(substream->pcm->card->dev, vma,
-				     runtime->dma_area,
-				     runtime->dma_addr,
-				     runtime->dma_bytes);
+	return dma_mmap_wc(substream->pcm->card->dev, vma, runtime->dma_area,
+			   runtime->dma_addr, runtime->dma_bytes);
 }
 EXPORT_SYMBOL(pxa2xx_pcm_mmap);
 
@@ -285,8 +283,7 @@ int pxa2xx_pcm_preallocate_dma_buffer(struct snd_pcm *pcm, int stream)
 	buf->dev.type = SNDRV_DMA_TYPE_DEV;
 	buf->dev.dev = pcm->card->dev;
 	buf->private_data = NULL;
-	buf->area = dma_alloc_writecombine(pcm->card->dev, size,
-					   &buf->addr, GFP_KERNEL);
+	buf->area = dma_alloc_wc(pcm->card->dev, size, &buf->addr, GFP_KERNEL);
 	if (!buf->area)
 		return -ENOMEM;
 	buf->bytes = size;
@@ -307,8 +304,7 @@ void pxa2xx_pcm_free_dma_buffers(struct snd_pcm *pcm)
 		buf = &substream->dma_buffer;
 		if (!buf->area)
 			continue;
-		dma_free_writecombine(pcm->card->dev, buf->bytes,
-				      buf->area, buf->addr);
+		dma_free_wc(pcm->card->dev, buf->bytes, buf->area, buf->addr);
 		buf->area = NULL;
 	}
 }
diff --git a/sound/soc/fsl/imx-pcm-fiq.c b/sound/soc/fsl/imx-pcm-fiq.c
index 7abf6a079574..ccdc4380d86a 100644
--- a/sound/soc/fsl/imx-pcm-fiq.c
+++ b/sound/soc/fsl/imx-pcm-fiq.c
@@ -217,8 +217,8 @@ static int snd_imx_pcm_mmap(struct snd_pcm_substream *substream,
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	int ret;
 
-	ret = dma_mmap_writecombine(substream->pcm->card->dev, vma,
-		runtime->dma_area, runtime->dma_addr, runtime->dma_bytes);
+	ret = dma_mmap_wc(substream->pcm->card->dev, vma, runtime->dma_area,
+			  runtime->dma_addr, runtime->dma_bytes);
 
 	pr_debug("%s: ret: %d %p 0x%08x 0x%08x\n", __func__, ret,
 			runtime->dma_area,
@@ -247,8 +247,7 @@ static int imx_pcm_preallocate_dma_buffer(struct snd_pcm *pcm, int stream)
 	buf->dev.type = SNDRV_DMA_TYPE_DEV;
 	buf->dev.dev = pcm->card->dev;
 	buf->private_data = NULL;
-	buf->area = dma_alloc_writecombine(pcm->card->dev, size,
-					   &buf->addr, GFP_KERNEL);
+	buf->area = dma_alloc_wc(pcm->card->dev, size, &buf->addr, GFP_KERNEL);
 	if (!buf->area)
 		return -ENOMEM;
 	buf->bytes = size;
@@ -330,8 +329,7 @@ static void imx_pcm_free(struct snd_pcm *pcm)
 		if (!buf->area)
 			continue;
 
-		dma_free_writecombine(pcm->card->dev, buf->bytes,
-				      buf->area, buf->addr);
+		dma_free_wc(pcm->card->dev, buf->bytes, buf->area, buf->addr);
 		buf->area = NULL;
 	}
 }
diff --git a/sound/soc/nuc900/nuc900-pcm.c b/sound/soc/nuc900/nuc900-pcm.c
index 5ae5ca15b6d6..cd8175afa900 100644
--- a/sound/soc/nuc900/nuc900-pcm.c
+++ b/sound/soc/nuc900/nuc900-pcm.c
@@ -267,10 +267,8 @@ static int nuc900_dma_mmap(struct snd_pcm_substream *substream,
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 
-	return dma_mmap_writecombine(substream->pcm->card->dev, vma,
-					runtime->dma_area,
-					runtime->dma_addr,
-					runtime->dma_bytes);
+	return dma_mmap_wc(substream->pcm->card->dev, vma, runtime->dma_area,
+			   runtime->dma_addr, runtime->dma_bytes);
 }
 
 static struct snd_pcm_ops nuc900_dma_ops = {
diff --git a/sound/soc/omap/omap-pcm.c b/sound/soc/omap/omap-pcm.c
index 6bb623a2a4df..99381a27295b 100644
--- a/sound/soc/omap/omap-pcm.c
+++ b/sound/soc/omap/omap-pcm.c
@@ -156,10 +156,8 @@ static int omap_pcm_mmap(struct snd_pcm_substream *substream,
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 
-	return dma_mmap_writecombine(substream->pcm->card->dev, vma,
-				     runtime->dma_area,
-				     runtime->dma_addr,
-				     runtime->dma_bytes);
+	return dma_mmap_wc(substream->pcm->card->dev, vma, runtime->dma_area,
+			   runtime->dma_addr, runtime->dma_bytes);
 }
 
 static struct snd_pcm_ops omap_pcm_ops = {
@@ -183,8 +181,7 @@ static int omap_pcm_preallocate_dma_buffer(struct snd_pcm *pcm,
 	buf->dev.type = SNDRV_DMA_TYPE_DEV;
 	buf->dev.dev = pcm->card->dev;
 	buf->private_data = NULL;
-	buf->area = dma_alloc_writecombine(pcm->card->dev, size,
-					   &buf->addr, GFP_KERNEL);
+	buf->area = dma_alloc_wc(pcm->card->dev, size, &buf->addr, GFP_KERNEL);
 	if (!buf->area)
 		return -ENOMEM;
 
@@ -207,8 +204,7 @@ static void omap_pcm_free_dma_buffers(struct snd_pcm *pcm)
 		if (!buf->area)
 			continue;
 
-		dma_free_writecombine(pcm->card->dev, buf->bytes,
-				      buf->area, buf->addr);
+		dma_free_wc(pcm->card->dev, buf->bytes, buf->area, buf->addr);
 		buf->area = NULL;
 	}
 }
-- 
2.4.3


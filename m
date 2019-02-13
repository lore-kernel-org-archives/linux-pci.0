Return-Path: <SRS0=kgfr=QU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1B74C282C2
	for <linux-pci@archiver.kernel.org>; Wed, 13 Feb 2019 17:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2487222B1
	for <linux-pci@archiver.kernel.org>; Wed, 13 Feb 2019 17:55:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404687AbfBMRzO (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 13 Feb 2019 12:55:14 -0500
Received: from ale.deltatee.com ([207.54.116.67]:54766 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404675AbfBMRzM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 13 Feb 2019 12:55:12 -0500
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1gtykN-0001zF-5L; Wed, 13 Feb 2019 10:55:09 -0700
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1gtykL-0001yO-QC; Wed, 13 Feb 2019 10:54:57 -0700
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com,
        linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kselftest@vger.kernel.org, Jon Mason <jdmason@kudzu.us>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Allen Hubbe <allenbh@gmail.com>, Dave Jiang <dave.jiang@intel.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Eric Pilmore <epilmore@gigaio.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Wed, 13 Feb 2019 10:54:51 -0700
Message-Id: <20190213175454.7506-10-logang@deltatee.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20190213175454.7506-1-logang@deltatee.com>
References: <20190213175454.7506-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-ntb@googlegroups.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-kselftest@vger.kernel.org, jdmason@kudzu.us, bhelgaas@google.com, joro@8bytes.org, dave.jiang@intel.com, allenbh@gmail.com, fancer.lancer@gmail.com, epilmore@gigaio.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v2 09/12] NTB: Introduce MSI library
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The NTB MSI library allows passing MSI interrupts across a memory
window. This offers similar functionality to doorbells or messages
except will often have much better latency and the client can
potentially use significantly more remote interrupts than typical hardware
provides for doorbells. (Which can be important in high-multiport
setups.)

The library utilizes one memory window per peer and uses the highest
index memory windows. Before any ntb_msi function may be used, the user
must call ntb_msi_init(). It may then setup and tear down the memory
windows when the link state changes using ntb_msi_setup_mws() and
ntb_msi_clear_mws().

The peer which receives the interrupt must call ntb_msim_request_irq()
to assign the interrupt handler (this function is functionally
similar to devm_request_irq()) and the returned descriptor must be
transferred to the peer which can use it to trigger the interrupt.
The triggering peer, once having received the descriptor, can
trigger the interrupt by calling ntb_msi_peer_trigger().

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Cc: Jon Mason <jdmason@kudzu.us>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Allen Hubbe <allenbh@gmail.com>
---
 drivers/ntb/Kconfig  |  11 ++
 drivers/ntb/Makefile |   3 +-
 drivers/ntb/msi.c    | 415 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/ntb.h  |  73 ++++++++
 4 files changed, 501 insertions(+), 1 deletion(-)
 create mode 100644 drivers/ntb/msi.c

diff --git a/drivers/ntb/Kconfig b/drivers/ntb/Kconfig
index 95944e52fa36..5760764052be 100644
--- a/drivers/ntb/Kconfig
+++ b/drivers/ntb/Kconfig
@@ -12,6 +12,17 @@ menuconfig NTB
 
 if NTB
 
+config NTB_MSI
+	bool "MSI Interrupt Support"
+	depends on PCI_MSI
+	help
+	 Support using MSI interrupt forwarding instead of (or in addition to)
+	 hardware doorbells. MSI interrupts typically offer lower latency
+	 than doorbells and more MSI interrupts can be made available to
+	 clients. However this requires an extra memory window and support
+	 in the hardware driver for creating the MSI interrupts.
+
+	 If unsure, say N.
 source "drivers/ntb/hw/Kconfig"
 
 source "drivers/ntb/test/Kconfig"
diff --git a/drivers/ntb/Makefile b/drivers/ntb/Makefile
index 537226f8e78d..cc27ad2ef150 100644
--- a/drivers/ntb/Makefile
+++ b/drivers/ntb/Makefile
@@ -1,4 +1,5 @@
 obj-$(CONFIG_NTB) += ntb.o hw/ test/
 obj-$(CONFIG_NTB_TRANSPORT) += ntb_transport.o
 
-ntb-y := core.o
+ntb-y			:= core.o
+ntb-$(CONFIG_NTB_MSI)	+= msi.o
diff --git a/drivers/ntb/msi.c b/drivers/ntb/msi.c
new file mode 100644
index 000000000000..5d4bd7a63924
--- /dev/null
+++ b/drivers/ntb/msi.c
@@ -0,0 +1,415 @@
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+
+#include <linux/irq.h>
+#include <linux/module.h>
+#include <linux/ntb.h>
+#include <linux/msi.h>
+#include <linux/pci.h>
+
+MODULE_LICENSE("Dual BSD/GPL");
+MODULE_VERSION("0.1");
+MODULE_AUTHOR("Logan Gunthorpe <logang@deltatee.com>");
+MODULE_DESCRIPTION("NTB MSI Interrupt Library");
+
+struct ntb_msi {
+	u64 base_addr;
+	u64 end_addr;
+
+	void (*desc_changed)(void *ctx);
+
+	u32 *peer_mws[];
+};
+
+/**
+ * ntb_msi_init() - Initialize the MSI context
+ * @ntb:	NTB device context
+ *
+ * This function must be called before any other ntb_msi function.
+ * It initializes the context for MSI operations and maps
+ * the peer memory windows.
+ *
+ * This function reserves the last N outbound memory windows (where N
+ * is the number of peers).
+ *
+ * Return: Zero on success, otherwise a negative error number.
+ */
+int ntb_msi_init(struct ntb_dev *ntb,
+		 void (*desc_changed)(void *ctx))
+{
+	phys_addr_t mw_phys_addr;
+	resource_size_t mw_size;
+	size_t struct_size;
+	int peer_widx;
+	int peers;
+	int ret;
+	int i;
+
+	peers = ntb_peer_port_count(ntb);
+	if (peers <= 0)
+		return -EINVAL;
+
+	struct_size = sizeof(*ntb->msi) + sizeof(*ntb->msi->peer_mws) * peers;
+
+	ntb->msi = devm_kzalloc(&ntb->dev, struct_size, GFP_KERNEL);
+	if (!ntb->msi)
+		return -ENOMEM;
+
+	ntb->msi->desc_changed = desc_changed;
+
+	for (i = 0; i < peers; i++) {
+		peer_widx = ntb_peer_mw_count(ntb) - 1 - i;
+
+		ret = ntb_peer_mw_get_addr(ntb, peer_widx, &mw_phys_addr,
+					   &mw_size);
+		if (ret)
+			goto unroll;
+
+		ntb->msi->peer_mws[i] = devm_ioremap(&ntb->dev, mw_phys_addr,
+						     mw_size);
+		if (!ntb->msi->peer_mws[i]) {
+			ret = -EFAULT;
+			goto unroll;
+		}
+	}
+
+	return 0;
+
+unroll:
+	for (i = 0; i < peers; i++)
+		if (ntb->msi->peer_mws[i])
+			devm_iounmap(&ntb->dev, ntb->msi->peer_mws[i]);
+
+	devm_kfree(&ntb->dev, ntb->msi);
+	ntb->msi = NULL;
+	return ret;
+}
+EXPORT_SYMBOL(ntb_msi_init);
+
+/**
+ * ntb_msi_setup_mws() - Initialize the MSI inbound memory windows
+ * @ntb:	NTB device context
+ *
+ * This function sets up the required inbound memory windows. It should be
+ * called from a work function after a link up event.
+ *
+ * Over the entire network, this function will reserves the last N
+ * inbound memory windows for each peer (where N is the number of peers).
+ *
+ * ntb_msi_init() must be called before this function.
+ *
+ * Return: Zero on success, otherwise a negative error number.
+ */
+int ntb_msi_setup_mws(struct ntb_dev *ntb)
+{
+	struct msi_desc *desc;
+	u64 addr;
+	int peer, peer_widx;
+	resource_size_t addr_align, size_align, size_max;
+	resource_size_t mw_size = SZ_32K;
+	resource_size_t mw_min_size = mw_size;
+	int i;
+	int ret;
+
+	if (!ntb->msi)
+		return -EINVAL;
+
+	desc = first_msi_entry(&ntb->pdev->dev);
+	addr = desc->msg.address_lo + ((uint64_t)desc->msg.address_hi << 32);
+
+	for (peer = 0; peer < ntb_peer_port_count(ntb); peer++) {
+		peer_widx = ntb_peer_highest_mw_idx(ntb, peer);
+		if (peer_widx < 0)
+			return peer_widx;
+
+		ret = ntb_mw_get_align(ntb, peer, peer_widx, &addr_align,
+				       NULL, NULL);
+		if (ret)
+			return ret;
+
+		addr &= ~(addr_align - 1);
+	}
+
+	for (peer = 0; peer < ntb_peer_port_count(ntb); peer++) {
+		peer_widx = ntb_peer_highest_mw_idx(ntb, peer);
+		if (peer_widx < 0) {
+			ret = peer_widx;
+			goto error_out;
+		}
+
+		ret = ntb_mw_get_align(ntb, peer, peer_widx, NULL,
+				       &size_align, &size_max);
+		if (ret)
+			goto error_out;
+
+		mw_size = round_up(mw_size, size_align);
+		mw_size = max(mw_size, size_max);
+		if (mw_size < mw_min_size)
+			mw_min_size = mw_size;
+
+		ret = ntb_mw_set_trans(ntb, peer, peer_widx,
+				       addr, mw_size);
+		if (ret)
+			goto error_out;
+	}
+
+	ntb->msi->base_addr = addr;
+	ntb->msi->end_addr = addr + mw_min_size;
+
+	return 0;
+
+error_out:
+	for (i = 0; i < peer; i++) {
+		peer_widx = ntb_peer_highest_mw_idx(ntb, peer);
+		if (peer_widx < 0)
+			continue;
+
+		ntb_mw_clear_trans(ntb, i, peer_widx);
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL(ntb_msi_setup_mws);
+
+/**
+ * ntb_msi_clear_mws() - Clear all inbound memory windows
+ * @ntb:	NTB device context
+ *
+ * This function tears down the resources used by ntb_msi_setup_mws().
+ */
+void ntb_msi_clear_mws(struct ntb_dev *ntb)
+{
+	int peer;
+	int peer_widx;
+
+	for (peer = 0; peer < ntb_peer_port_count(ntb); peer++) {
+		peer_widx = ntb_peer_highest_mw_idx(ntb, peer);
+		if (peer_widx < 0)
+			continue;
+
+		ntb_mw_clear_trans(ntb, peer, peer_widx);
+	}
+}
+EXPORT_SYMBOL(ntb_msi_clear_mws);
+
+struct ntb_msi_devres {
+	struct ntb_dev *ntb;
+	struct msi_desc *entry;
+	struct ntb_msi_desc *msi_desc;
+};
+
+static int ntb_msi_set_desc(struct ntb_dev *ntb, struct msi_desc *entry,
+			    struct ntb_msi_desc *msi_desc)
+{
+	u64 addr;
+
+	addr = entry->msg.address_lo +
+		((uint64_t)entry->msg.address_hi << 32);
+
+	if (addr < ntb->msi->base_addr || addr >= ntb->msi->end_addr) {
+		dev_warn_once(&ntb->dev,
+			      "IRQ %d: MSI Address not within the memory window (%llx, [%llx %llx])\n",
+			      entry->irq, addr, ntb->msi->base_addr,
+			      ntb->msi->end_addr);
+		return -EFAULT;
+	}
+
+	msi_desc->addr_offset = addr - ntb->msi->base_addr;
+	msi_desc->data = entry->msg.data;
+
+	return 0;
+}
+
+static void ntb_msi_write_msg(struct msi_desc *entry, void *data)
+{
+	struct ntb_msi_devres *dr = data;
+
+	WARN_ON(ntb_msi_set_desc(dr->ntb, entry, dr->msi_desc));
+
+	if (dr->ntb->msi->desc_changed)
+		dr->ntb->msi->desc_changed(dr->ntb->ctx);
+}
+
+static void ntbm_msi_callback_release(struct device *dev, void *res)
+{
+	struct ntb_msi_devres *dr = res;
+
+	dr->entry->write_msi_msg = NULL;
+	dr->entry->write_msi_msg_data = NULL;
+}
+
+static int ntbm_msi_setup_callback(struct ntb_dev *ntb, struct msi_desc *entry,
+				   struct ntb_msi_desc *msi_desc)
+{
+	struct ntb_msi_devres *dr;
+
+	dr = devres_alloc(ntbm_msi_callback_release,
+			  sizeof(struct ntb_msi_devres), GFP_KERNEL);
+	if (!dr)
+		return -ENOMEM;
+
+	dr->ntb = ntb;
+	dr->entry = entry;
+	dr->msi_desc = msi_desc;
+
+	devres_add(&ntb->dev, dr);
+
+	dr->entry->write_msi_msg = ntb_msi_write_msg;
+	dr->entry->write_msi_msg_data = dr;
+
+	return 0;
+}
+
+/**
+ * ntbm_msi_request_threaded_irq() - allocate an MSI interrupt
+ * @ntb:	NTB device context
+ * @handler:	Function to be called when the IRQ occurs
+ * @thread_fn:  Function to be called in a threaded interrupt context. NULL
+ *              for clients which handle everything in @handler
+ * @devname:    An ascii name for the claiming device, dev_name(dev) if NULL
+ * @dev_id:     A cookie passed back to the handler function
+ *
+ * This function assigns an interrupt handler to an unused
+ * MSI interrupt and returns the descriptor used to trigger
+ * it. The descriptor can then be sent to a peer to trigger
+ * the interrupt.
+ *
+ * The interrupt resource is managed with devres so it will
+ * be automatically freed when the NTB device is torn down.
+ *
+ * If an IRQ allocated with this function needs to be freed
+ * separately, ntbm_free_irq() must be used.
+ *
+ * Return: IRQ number assigned on success, otherwise a negative error number.
+ */
+int ntbm_msi_request_threaded_irq(struct ntb_dev *ntb, irq_handler_t handler,
+				  irq_handler_t thread_fn,
+				  const char *name, void *dev_id,
+				  struct ntb_msi_desc *msi_desc)
+{
+	struct msi_desc *entry;
+	struct irq_desc *desc;
+	int ret;
+
+	if (!ntb->msi)
+		return -EINVAL;
+
+	for_each_pci_msi_entry(entry, ntb->pdev) {
+		desc = irq_to_desc(entry->irq);
+		if (desc->action)
+			continue;
+
+		ret = devm_request_threaded_irq(&ntb->dev, entry->irq, handler,
+						thread_fn, 0, name, dev_id);
+		if (ret)
+			continue;
+
+		if (ntb_msi_set_desc(ntb, entry, msi_desc)) {
+			devm_free_irq(&ntb->dev, entry->irq, dev_id);
+			continue;
+		}
+
+		ret = ntbm_msi_setup_callback(ntb, entry, msi_desc);
+		if (ret) {
+			devm_free_irq(&ntb->dev, entry->irq, dev_id);
+			return ret;
+		}
+
+
+		return entry->irq;
+	}
+
+	return -ENODEV;
+}
+EXPORT_SYMBOL(ntbm_msi_request_threaded_irq);
+
+static int ntbm_msi_callback_match(struct device *dev, void *res, void *data)
+{
+	struct ntb_dev *ntb = dev_ntb(dev);
+	struct ntb_msi_devres *dr = res;
+
+	return dr->ntb == ntb && dr->entry == data;
+}
+
+/**
+ * ntbm_msi_free_irq() - free an interrupt
+ * @ntb:	NTB device context
+ * @irq:	Interrupt line to free
+ * @dev_id:	Device identity to free
+ *
+ * This function should be used to manually free IRQs allocated with
+ * ntbm_request_[threaded_]irq().
+ */
+void ntbm_msi_free_irq(struct ntb_dev *ntb, unsigned int irq, void *dev_id)
+{
+	struct msi_desc *entry = irq_get_msi_desc(irq);
+
+	entry->write_msi_msg = NULL;
+	entry->write_msi_msg_data = NULL;
+
+	WARN_ON(devres_destroy(&ntb->dev, ntbm_msi_callback_release,
+			       ntbm_msi_callback_match, entry));
+
+	devm_free_irq(&ntb->dev, irq, dev_id);
+}
+EXPORT_SYMBOL(ntbm_msi_free_irq);
+
+/**
+ * ntb_msi_peer_trigger() - Trigger an interrupt handler on a peer
+ * @ntb:	NTB device context
+ * @peer:	Peer index
+ * @desc:	MSI descriptor data which triggers the interrupt
+ *
+ * This function triggers an interrupt on a peer. It requires
+ * the descriptor structure to have been passed from that peer
+ * by some other means.
+ *
+ * Return: Zero on success, otherwise a negative error number.
+ */
+int ntb_msi_peer_trigger(struct ntb_dev *ntb, int peer,
+			 struct ntb_msi_desc *desc)
+{
+	int idx;
+
+	if (!ntb->msi)
+		return -EINVAL;
+
+	idx = desc->addr_offset / sizeof(*ntb->msi->peer_mws[peer]);
+
+	ntb->msi->peer_mws[peer][idx] = desc->data;
+
+	return 0;
+}
+EXPORT_SYMBOL(ntb_msi_peer_trigger);
+
+/**
+ * ntb_msi_peer_addr() - Get the DMA address to trigger a peer's MSI interrupt
+ * @ntb:	NTB device context
+ * @peer:	Peer index
+ * @desc:	MSI descriptor data which triggers the interrupt
+ * @msi_addr:   Physical address to trigger the interrupt
+ *
+ * This function allows using DMA engines to trigger an interrupt
+ * (for example, trigger an interrupt to process the data after
+ * sending it). To trigger the interrupt, write @desc.data to the address
+ * returned in @msi_addr
+ *
+ * Return: Zero on success, otherwise a negative error number.
+ */
+int ntb_msi_peer_addr(struct ntb_dev *ntb, int peer,
+		      struct ntb_msi_desc *desc,
+		      phys_addr_t *msi_addr)
+{
+	int peer_widx = ntb_peer_mw_count(ntb) - 1 - peer;
+	phys_addr_t mw_phys_addr;
+	int ret;
+
+	ret = ntb_peer_mw_get_addr(ntb, peer_widx, &mw_phys_addr, NULL);
+	if (ret)
+		return ret;
+
+	if (msi_addr)
+		*msi_addr = mw_phys_addr + desc->addr_offset;
+
+	return 0;
+}
+EXPORT_SYMBOL(ntb_msi_peer_addr);
diff --git a/include/linux/ntb.h b/include/linux/ntb.h
index f5c69d853489..b9c61ee3c734 100644
--- a/include/linux/ntb.h
+++ b/include/linux/ntb.h
@@ -58,9 +58,11 @@
 
 #include <linux/completion.h>
 #include <linux/device.h>
+#include <linux/interrupt.h>
 
 struct ntb_client;
 struct ntb_dev;
+struct ntb_msi;
 struct pci_dev;
 
 /**
@@ -425,6 +427,10 @@ struct ntb_dev {
 	spinlock_t			ctx_lock;
 	/* block unregister until device is fully released */
 	struct completion		released;
+
+	#ifdef CONFIG_NTB_MSI
+	struct ntb_msi *msi;
+	#endif
 };
 #define dev_ntb(__dev) container_of((__dev), struct ntb_dev, dev)
 
@@ -1572,4 +1578,71 @@ static inline int ntb_peer_highest_mw_idx(struct ntb_dev *ntb, int pidx)
 	return ntb_mw_count(ntb, pidx) - ret - 1;
 }
 
+struct ntb_msi_desc {
+	u32 addr_offset;
+	u32 data;
+};
+
+#ifdef CONFIG_NTB_MSI
+
+int ntb_msi_init(struct ntb_dev *ntb, void (*desc_changed)(void *ctx));
+int ntb_msi_setup_mws(struct ntb_dev *ntb);
+void ntb_msi_clear_mws(struct ntb_dev *ntb);
+int ntbm_msi_request_threaded_irq(struct ntb_dev *ntb, irq_handler_t handler,
+				  irq_handler_t thread_fn,
+				  const char *name, void *dev_id,
+				  struct ntb_msi_desc *msi_desc);
+void ntbm_msi_free_irq(struct ntb_dev *ntb, unsigned int irq, void *dev_id);
+int ntb_msi_peer_trigger(struct ntb_dev *ntb, int peer,
+			 struct ntb_msi_desc *desc);
+int ntb_msi_peer_addr(struct ntb_dev *ntb, int peer,
+		      struct ntb_msi_desc *desc,
+		      phys_addr_t *msi_addr);
+
+#else /* not CONFIG_NTB_MSI */
+
+static inline int ntb_msi_init(struct ntb_dev *ntb,
+			       void (*desc_changed)(void *ctx))
+{
+	return -EOPNOTSUPP;
+}
+static inline int ntb_msi_setup_mws(struct ntb_dev *ntb)
+{
+	return -EOPNOTSUPP;
+}
+static inline void ntb_msi_clear_mws(struct ntb_dev *ntb) {}
+static inline int ntbm_msi_request_threaded_irq(struct ntb_dev *ntb,
+						irq_handler_t handler,
+						irq_handler_t thread_fn,
+						const char *name, void *dev_id,
+						struct ntb_msi_desc *msi_desc)
+{
+	return -EOPNOTSUPP;
+}
+static inline void ntbm_msi_free_irq(struct ntb_dev *ntb, unsigned int irq,
+				     void *dev_id) {}
+static inline int ntb_msi_peer_trigger(struct ntb_dev *ntb, int peer,
+				       struct ntb_msi_desc *desc)
+{
+	return -EOPNOTSUPP;
+}
+static inline int ntb_msi_peer_addr(struct ntb_dev *ntb, int peer,
+				    struct ntb_msi_desc *desc,
+				    phys_addr_t *msi_addr)
+{
+	return -EOPNOTSUPP;
+
+}
+
+#endif /* CONFIG_NTB_MSI */
+
+static inline int ntbm_msi_request_irq(struct ntb_dev *ntb,
+				       irq_handler_t handler,
+				       const char *name, void *dev_id,
+				       struct ntb_msi_desc *msi_desc)
+{
+	return ntbm_msi_request_threaded_irq(ntb, handler, NULL, name,
+					     dev_id, msi_desc);
+}
+
 #endif
-- 
2.19.0


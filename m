Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:36059 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751439AbdGRQEY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 18 Jul 2017 12:04:24 -0400
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-ntb@googlegroups.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <Allen.Hubbe@emc.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Stephen Bates <sbates@raithlin.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date: Tue, 18 Jul 2017 10:03:59 -0600
Message-Id: <20170718160409.6493-7-logang@deltatee.com>
In-Reply-To: <20170718160409.6493-1-logang@deltatee.com>
References: <20170718160409.6493-1-logang@deltatee.com>
Subject: [PATCH v2 06/16] ntb: add check and comment for link up to mw_count() and mw_get_align()
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Adds a comment and a check to ntb_mw_get_align() so that it always fails
if the function is called before the link is up.

Also adds a comment to ntb_mw_count() to note that it may return 0 if
it is called before the link is up.

This is to prevent accidental mis-use in clients that are testing
on hardware that this doesn't matter for.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 include/linux/ntb.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/linux/ntb.h b/include/linux/ntb.h
index 609e232c00da..47f2966cfd7f 100644
--- a/include/linux/ntb.h
+++ b/include/linux/ntb.h
@@ -730,7 +730,8 @@ static inline int ntb_link_disable(struct ntb_dev *ntb)
  * Hardware and topology may support a different number of memory windows.
  * Moreover different peer devices can support different number of memory
  * windows. Simply speaking this method returns the number of possible inbound
- * memory windows to share with specified peer device.
+ * memory windows to share with specified peer device. Note: this may return
+ * zero if the link is not up yet.
  *
  * Return: the number of memory windows.
  */
@@ -751,7 +752,7 @@ static inline int ntb_mw_count(struct ntb_dev *ntb, int pidx)
  * Get the alignments of an inbound memory window with specified index.
  * NULL may be given for any output parameter if the value is not needed.
  * The alignment and size parameters may be used for allocation of proper
- * shared memory.
+ * shared memory. Note: this must only be called when the link is up.
  *
  * Return: Zero on success, otherwise a negative error number.
  */
@@ -760,6 +761,9 @@ static inline int ntb_mw_get_align(struct ntb_dev *ntb, int pidx, int widx,
 				   resource_size_t *size_align,
 				   resource_size_t *size_max)
 {
+	if (!(ntb_link_is_up(ntb, NULL, NULL) & (1 << pidx)))
+		return -ENOTCONN;
+
 	return ntb->ops->mw_get_align(ntb, pidx, widx, addr_align, size_align,
 				      size_max);
 }
--
2.11.0

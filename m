Return-Path: <SRS0=YnKd=PK=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E504FC43387
	for <linux-pci@archiver.kernel.org>; Wed,  2 Jan 2019 22:48:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCB5120856
	for <linux-pci@archiver.kernel.org>; Wed,  2 Jan 2019 22:48:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbfABWsX (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 2 Jan 2019 17:48:23 -0500
Received: from mga14.intel.com ([192.55.52.115]:62830 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726875AbfABWsX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 2 Jan 2019 17:48:23 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Jan 2019 14:48:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,432,1539673200"; 
   d="scan'208";a="122791907"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga002.jf.intel.com with ESMTP; 02 Jan 2019 14:48:22 -0800
Date:   Wed, 2 Jan 2019 15:46:39 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH V2 1/3] PCI/MSI: preference to returning -ENOSPC from
 pci_alloc_irq_vectors_affinity
Message-ID: <20190102224637.GA9795@localhost.localdomain>
References: <20181229032650.27256-1-ming.lei@redhat.com>
 <20181229032650.27256-2-ming.lei@redhat.com>
 <20181231220059.GI159477@google.com>
 <20190101052458.GA17588@ming.t460p>
 <20190102210202.GC126384@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190102210202.GC126384@google.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 02, 2019 at 03:02:02PM -0600, Bjorn Helgaas wrote:
> Keith said:
> > The min/max vecs doesn't work correctly when using the irq_affinity
> > nr_sets because rebalancing the set counts is driver specific. To
> > get around that, drivers using nr_sets have to set min and max to
> > the same value and handle the "reduce and try again".
> 
> Sorry I saw that, but didn't follow it at first.  After a little
> archaeology, I see that 6da4b3ab9a6e ("genirq/affinity: Add support
> for allocating interrupt sets") added nr_sets and some validation
> tests (if affd.nr_sets, min_vecs == max_vecs) for using it in the API.
> 
> That's sort of a wart on the API, but I don't know if we should live
> with it or try to clean it up somehow.

Yeah, that interface is a bit awkward. I was thinking it would be nice to
thread a driver callback to PCI for the driver to redistribute the sets
as needed and let the PCI handle the retries as before. I am testing
with the following, and seems to work, but I'm getting some unexpected
warnings from blk-mq when I have nvme use it. Still investigating that,
but just throwing this out for early feedback.

---
diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 7a1c8a09efa5..e33abb167c19 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -1035,13 +1035,6 @@ static int __pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec,
 	if (maxvec < minvec)
 		return -ERANGE;
 
-	/*
-	 * If the caller is passing in sets, we can't support a range of
-	 * vectors. The caller needs to handle that.
-	 */
-	if (affd && affd->nr_sets && minvec != maxvec)
-		return -EINVAL;
-
 	if (WARN_ON_ONCE(dev->msi_enabled))
 		return -EINVAL;
 
@@ -1093,13 +1086,6 @@ static int __pci_enable_msix_range(struct pci_dev *dev,
 	if (maxvec < minvec)
 		return -ERANGE;
 
-	/*
-	 * If the caller is passing in sets, we can't support a range of
-	 * supported vectors. The caller needs to handle that.
-	 */
-	if (affd && affd->nr_sets && minvec != maxvec)
-		return -EINVAL;
-
 	if (WARN_ON_ONCE(dev->msix_enabled))
 		return -EINVAL;
 
@@ -1110,6 +1096,9 @@ static int __pci_enable_msix_range(struct pci_dev *dev,
 				return -ENOSPC;
 		}
 
+		if (nvec != maxvec && affd && affd->recalc_sets)
+			affd->recalc_sets(affd, nvec);
+
 		rc = __pci_enable_msix(dev, entries, nvec, affd);
 		if (rc == 0)
 			return nvec;
diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index c672f34235e7..326c9bd05f62 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -249,12 +249,16 @@ struct irq_affinity_notify {
  *			the MSI(-X) vector space
  * @nr_sets:		Length of passed in *sets array
  * @sets:		Number of affinitized sets
+ * @recalc_sets:	Recalculate sets when requested allocation failed
+ * @priv:		Driver private data
  */
 struct irq_affinity {
 	int	pre_vectors;
 	int	post_vectors;
 	int	nr_sets;
 	int	*sets;
+	void	(*recalc_sets)(struct irq_affinity *, unsigned int);
+	void	*priv;
 };
 
 /**
--

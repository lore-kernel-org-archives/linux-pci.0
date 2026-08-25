Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC9631A556;
	Tue, 25 Aug 2026 02:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787624817; cv=none; b=sxuEMkeVzY6a+63WrXiedAaKsNJfj0ASUEq5Hpqr6voKQnzQ/up4aEYiWI7dxIA2rziq8iG5Pm4sEo6wperlnSs+sGANpHYNEQw1cZYYTB10PYDmP0aMHFxlKUEccSyFfJhj6cl/fdZNNWS5+2rjuxLJWYRv5hzhE/Gl/b95CJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787624817; c=relaxed/simple;
	bh=luXAFR5A0hd2IqVdgYztssDIQ6BwQc+LTt+HmX9tnxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=syUE6yDK+tDGU8bi1XH9lWSvsJKh3dY97MC0qAnie7Zl3KGUv5U1zBt/d9JTC9H2RGzo6dK7yVTIJK1sx+Bkcu3pM7C6xbqSqFcPNsKJrpMX5GLFT/bUuDT+nuRC61fFuCcl2bqtaHyiHbd5wQhn3W9CP2QaPo4axCvJyjMxK8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g3AA8koT; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g3AA8koT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787624816; x=1819160816;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=luXAFR5A0hd2IqVdgYztssDIQ6BwQc+LTt+HmX9tnxo=;
  b=g3AA8koTzLZ37hVEXRvfmM7LkEWNGhSFdfsWOdeOzq5GPpDripEG5RKO
   gFmRBYKco5vhH2Bauu0JapsIz9XWckD9cGIrT9X3QaZEs5j9MLTAukstq
   6BaUoL1f7sVEsxomzhvPQRdCofLo677qUk1ezOkOjPatN56utOaOm9/pI
   MPicvtg3CUwemysKBK3YvroJdb20VaDvavIjS3Quj53ySs89JymBAyfkP
   MS6u+RQV+97kCzYWy6hCuS0MMVwpLGfxo3LCgqEl5UPW5Bi2qGc7MSRwE
   AofLrXpopHPoUKeSKdlL4EuPV1ESRPTA3HoUMUFnw1B/M4i2VKuTULmaZ
   w==;
X-CSE-ConnectionGUID: RKjhkrFRTe6BVU5jrhpo+w==
X-CSE-MsgGUID: 8oG2NCYQSY+rEu7kdkmj/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="98760974"
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="98760974"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 19:26:55 -0700
X-CSE-ConnectionGUID: MB+GDsTWTrS4G9U7JS2ynw==
X-CSE-MsgGUID: OFbwcOqSRaGkEg9HTVIQ7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="265390053"
Received: from fdefranc-mobl3.igk.intel.com ([172.28.182.157])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 19:26:48 -0700
From: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
To: linux-cxl@vger.kernel.org
Cc: David Hildenbrand <david@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	driver-core@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Subject: [PATCH v2 02/13] cxl/hdm: Add function to restore one HDM decoder
Date: Tue, 25 Aug 2026 04:26:17 +0200
Message-ID: <20260825022628.3651434-3-fabio.m.de.francesco@linux.intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260825022628.3651434-1-fabio.m.de.francesco@linux.intel.com>
References: <20260825022628.3651434-1-fabio.m.de.francesco@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add cxl_decoder_recommit() to restore one HDM decoder that the driver
holds as committed but hardware no longer reports Committed, rewriting the
cached settings and committing it again.

Restoring the decoders below a reset Port means reprogramming each one
along the path to every affected endpoint. cxl_decoder_recommit() does that
for a single decoder, so it will be reused later for the full path.

Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
---
 drivers/cxl/core/core.h |  1 +
 drivers/cxl/core/hdm.c  | 71 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 72 insertions(+)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 4dc324f019ab..6d536fe7b446 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -215,6 +215,7 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
 			struct cxl_endpoint_dvsec_info *info);
 void cxl_enable_hdm(struct cxl_hdm *cxlhdm, u32 global_ctrl);
 int cxl_set_mem_enable(struct cxl_dev_state *cxlds, u16 val);
+int cxl_decoder_recommit(struct cxl_decoder *cxld, u32 ctrl);
 int cxl_port_get_possible_dports(struct cxl_port *port);
 
 #ifdef CONFIG_CXL_FEATURES
diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 0c80b76a5f9b..d55d764895f8 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -849,6 +849,77 @@ static int cxl_decoder_commit(struct cxl_decoder *cxld)
 	return 0;
 }
 
+/**
+ * cxl_decoder_recommit - reprogram @cxld's HDM decoder registers and commit
+ * @cxld: decoder to reprogram from its cached settings
+ * @ctrl: CXL HDM Decoder n Control value to restore under the cached settings
+ *
+ * A reset of an upstream link clears the HDM decoder registers of every
+ * component below it, dropping Committed while the driver still holds the
+ * settings that were in effect. Restore those settings and commit.
+ *
+ * setup_hw_decoder() rewrites only Interleave Granularity, Interleave Ways and
+ * Target Range Type, so the rest of the control register would come from a read
+ * of the reset defaults. Per CXL r4.0 sec 8.2.4.20.7 Table 8-123 that register
+ * also holds BI, UIO, Upstream Interleave Granularity, Upstream Interleave Ways
+ * and Lock On Commit, none of which the driver models, and sec 8.2.4.20.12 makes
+ * device operation undefined if a device that requires BI is committed without
+ * it. Write @ctrl first so those fields are in place, with Commit masked off
+ * until setup_hw_decoder() has written the range.
+ *
+ * A decoder that hardware still reports Committed kept its programming across
+ * the reset and needs no work. A decoder with no ->commit is driven through the
+ * DVSEC ranges or is a passthrough decoder, and has no registers to program.
+ *
+ * Section 8.2.4.20.13 requires the traffic targeting @cxld to be quiesced while
+ * it is reprogrammed, which the caller owns. @cxld decodes nothing until the
+ * commit completes.
+ *
+ * Return: 0 on success or if @cxld needs no reprogramming, negative errno if the
+ * commit times out or if the hardware reports a commit error.
+ */
+int cxl_decoder_recommit(struct cxl_decoder *cxld, u32 ctrl)
+{
+	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
+	struct cxl_hdm *cxlhdm = dev_get_drvdata(&port->dev);
+	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
+	u32 hw_ctrl;
+	int rc;
+
+	if ((cxld->flags & CXL_DECODER_F_ENABLE) == 0)
+		return 0;
+
+	if (!cxld->commit)
+		return 0;
+
+	hw_ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(cxld->id));
+	if (FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMITTED, hw_ctrl)) {
+		dev_dbg(&cxld->dev, "%s: still committed, no reprogram needed\n",
+			__func__);
+		return 0;
+	}
+
+	writel(ctrl & ~(CXL_HDM_DECODER0_CTRL_COMMIT |
+			CXL_HDM_DECODER0_CTRL_COMMITTED |
+			CXL_HDM_DECODER0_CTRL_COMMIT_ERROR),
+	       hdm + CXL_HDM_DECODER0_CTRL_OFFSET(cxld->id));
+
+	scoped_guard(rwsem_read, &cxl_rwsem.dpa)
+		setup_hw_decoder(cxld, hdm);
+
+	rc = cxld_await_commit(hdm, cxld->id);
+	if (rc) {
+		dev_warn(&cxld->dev, "%s: failed to commit decoder: %d\n",
+			 __func__, rc);
+		return rc;
+	}
+
+	dev_dbg(&cxld->dev, "%s: reprogrammed HPA %#llx-%#llx\n",
+		__func__, cxld->hpa_range.start, cxld->hpa_range.end);
+
+	return 0;
+}
+
 static int commit_reap(struct device *dev, void *data)
 {
 	struct cxl_port *port = to_cxl_port(dev->parent);
-- 
2.55.0


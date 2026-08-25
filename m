Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC54D31A572;
	Tue, 25 Aug 2026 02:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787624861; cv=none; b=T+atAqT2FavhwO4Oe69VqKEgKB2cCR/++pfdA2ytgNHBL4TeVjFfzvDvxyc8oo4iiDZ5bYxfr/FL/g5B0oYDMPioxndBxypCl4vpYEfXPqYLSmDxAMDwEeRgDUR+00Kk7tsBIkZpupy1KTGJ+BSlo3YqWmkn1DDY5225KCTQ1LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787624861; c=relaxed/simple;
	bh=Q3mRxBLSI2WW9TzR6U+x8ypVb6e1keaDDN/taWRABaw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jtiI5uSAsZccng2QR9hJt+CjdXfKIGy60eF9s4Xi2Ef3+xWRosBGMdEBQQd9gwhQQWzwj2Y69PgbHDAIgCOrBwdFioHwLARxAQ6Zs9Sn557PPv25IPACcwXql/qtY0qagDUWouQ/ZFb5t3ub+mOQbXEF4xBR+3dm4kegMHXNv/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T9i0N5sJ; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T9i0N5sJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787624860; x=1819160860;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Q3mRxBLSI2WW9TzR6U+x8ypVb6e1keaDDN/taWRABaw=;
  b=T9i0N5sJfZ94E5z+pO8tQWIAY3/VeWR8j9anfRBc302Yro2/ytzsPxAS
   AIAwGBbCCPihmJYPNTn6doBV0lJIUqfPcWHJFV0amCk1rwGfgG1rLKy3O
   nqUz7hTFIdFpBZMsAQ2ChC77zGCcvZWZdzKiooOMjzyOZMjlpmFKg3IIW
   4bz72ojOcZJYw7ChaSzPMFH8mBlZHh98Wj1CTjRP9knFVBQlPo+makqa0
   Sylp0OyiAJ67dkIQE1MiJom9dXW50SGQprTZJi0cs97mfiR5jKPMPVDKt
   SbVpvt85wtvoXTg8GYDoo6YdQGuZcl+AIspRqWpfXz/LH44+Bn9HT/gi5
   A==;
X-CSE-ConnectionGUID: ha0V2AJaTWy9IRHpg3I08A==
X-CSE-MsgGUID: oH4H1d8bTn+TS/lK8OqCfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="98761132"
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="98761132"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 19:27:39 -0700
X-CSE-ConnectionGUID: XnmQbxFWQXSTf4T6etYNMw==
X-CSE-MsgGUID: 3BIjarGVQuW5Vhplv4Uj1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="265390104"
Received: from fdefranc-mobl3.igk.intel.com ([172.28.182.157])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 19:27:32 -0700
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
Subject: [PATCH v2 08/13] cxl/core: Collect the regions routed through a DPort
Date: Tue, 25 Aug 2026 04:26:23 +0200
Message-ID: <20260825022628.3651434-9-fabio.m.de.francesco@linux.intel.com>
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

Disabling the CXL regions ahead of a Secondary Bus Reset needs the set of
regions with a member endpoint below the Port being reset.

Add cxl_sbr_collect_regions() to walk the CXL port that owns the Downstream
Port and return every region with an endpoint below it, and
cxl_sbr_put_regions() to release the set.

Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
---
 drivers/cxl/core/core.h      |  2 ++
 drivers/cxl/core/dport_sbr.c | 66 ++++++++++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index ac55f9e8160e..077a2af9cf0c 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -60,6 +60,8 @@ int cxl_region_invalidate_memregion(struct cxl_region *cxlr);
 int cxl_region_disable(struct cxl_region *cxlr);
 void cxl_region_enable(struct cxl_region *cxlr);
 struct pci_dev;
+int cxl_sbr_collect_regions(struct pci_dev *dport_pci, struct xarray *regions);
+void cxl_sbr_put_regions(struct xarray *regions);
 void cxl_sbr_recommit_decoders(struct pci_dev *dport_pci,
 			       struct xarray *hdm_state);
 
diff --git a/drivers/cxl/core/dport_sbr.c b/drivers/cxl/core/dport_sbr.c
index 0f398ab0d3a4..233499bc1fad 100644
--- a/drivers/cxl/core/dport_sbr.c
+++ b/drivers/cxl/core/dport_sbr.c
@@ -85,6 +85,72 @@ void cxl_region_enable(struct cxl_region *cxlr)
 		__func__, p->res, p->interleave_ways, p->interleave_granularity);
 }
 
+/*
+ * Collect the regions with a member endpoint routed through @dport_pci, the
+ * CXL Downstream Port about to be reset. cxl_rwsem.region keeps the topology
+ * stable for the duration of the walk only. Each collected region is pinned
+ * with get_device() so the object survives after the lock is dropped, since
+ * cxl_region_disable()/cxl_region_enable() run with the rwsem released (they
+ * unbind and rebind the region driver). Hence snapshot the set first.
+ */
+int cxl_sbr_collect_regions(struct pci_dev *dport_pci,
+			    struct xarray *regions)
+{
+	struct cxl_region_ref *cxl_rr;
+	struct cxl_dport *dport;
+	unsigned long index;
+	int count = 0;
+	int rc;
+
+	struct cxl_port *port __free(put_cxl_port) =
+		find_cxl_port(&dport_pci->dev, &dport);
+	if (!port) {
+		pci_dbg(dport_pci, "no CXL port found for reset dport\n");
+		return 0;
+	}
+
+	guard(rwsem_read)(&cxl_rwsem.region);
+	xa_for_each(&port->regions, index, cxl_rr) {
+		struct cxl_region *cxlr = cxl_rr->region;
+		struct cxl_ep *ep;
+		unsigned long ep_index;
+
+		/* Skip unless a region endpoint sits below the reset dport. */
+		xa_for_each(&cxl_rr->endpoints, ep_index, ep)
+			if (ep->dport == dport)
+				break;
+		if (!ep) {
+			dev_dbg(&cxlr->dev, "%s: no endpoint below %s, region excluded\n",
+				__func__, dev_name(dport->dport_dev));
+			continue;
+		}
+
+		get_device(&cxlr->dev);
+		rc = xa_insert(regions, (unsigned long)cxlr, cxlr, GFP_KERNEL);
+		if (rc) {
+			put_device(&cxlr->dev);
+			return rc;
+		}
+		dev_dbg(&cxlr->dev, "%s: endpoint below %s, region collected\n",
+			__func__, dev_name(dport->dport_dev));
+		count++;
+	}
+
+	dev_dbg(&port->dev, "%d region(s) routed through %s\n", count,
+		dev_name(dport->dport_dev));
+	return 0;
+}
+
+void cxl_sbr_put_regions(struct xarray *regions)
+{
+	struct cxl_region *cxlr;
+	unsigned long index;
+
+	xa_for_each(regions, index, cxlr)
+		put_device(&cxlr->dev);
+	xa_destroy(regions);
+}
+
 /*
  * The reset cleared the HDM Decoder registers of every CXL component below
  * @dport_pci, so restore them from the settings the driver holds and from
-- 
2.55.0


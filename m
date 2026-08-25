Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB79130EF97;
	Tue, 25 Aug 2026 02:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787624811; cv=none; b=f71fxfA0PozL7nS63641iYZwp4fHyyLZyZ9DhlHunJAV4sZJbWswYj/DLPYPCVGK3ykPyHZ679Ps4O/EMpdpzLy9Bv302AysdkSRBIhd7vGbgHFRmgJgPghum8MXMDJ0EkrXGj3J3lIgT45VHDiDCw4gRS42mV8C/7QFWbfWV88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787624811; c=relaxed/simple;
	bh=tsn1ZiUbzdaF4vYy7trPOo26c92bIqiH3qklxnc8dFw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nEXcSyrtmX43qXxUwJuJ7JiWMqlzygavVFESW77BV6xQEFhxi/j0pUZhnYpUeQORsbAP1KOksj4XJ7FMb/MCkFTA6cDI6Dl0d5vJM9neTw/PMUrjkvk/4JqpZJhs6qkULDMjUw5dEEMhYN6/R8W+AHZN+PjifAUoCHL132rQiX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lqext/n6; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lqext/n6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787624808; x=1819160808;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tsn1ZiUbzdaF4vYy7trPOo26c92bIqiH3qklxnc8dFw=;
  b=Lqext/n6PerszdaIWyRyznOgBQ5wbVUkQ3WW7QldmbMP5DEGOPsPt0Do
   D0VEcIusxjAbsVzf/dTeKpr8S1VQ84eMPSlfhWhivJut6mm6XzhYEH/du
   Q1e9wyZUN4S8vgvYWwF/OcabzKlvnbW8k0L/rsaf9gBBvAC8FL/ABBm68
   S7qsvyvyugDbo8hGFKPa7XeFX8fHy1O4Rt8GnsDSTYxwas7MoHBK9jd0p
   9hkv6LqeuXFM81beK7hRUP8FAHXjtFZt9PavEw37wdk1KSQTGYNw8HCDF
   WJjvmjWiWTirNqz5dRtZ5mUOfEYq9nT7l+EoNyeLF7Sr2qQ9jfe/q0/DA
   Q==;
X-CSE-ConnectionGUID: lsOwPV3mR9GVcZj3BIVRug==
X-CSE-MsgGUID: zMGzINvwSjajHoODWJyKEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="98760936"
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="98760936"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 19:26:48 -0700
X-CSE-ConnectionGUID: lF9tHVnlTmmDi5NsgwZhEQ==
X-CSE-MsgGUID: NWBh33+kSD+0V6l964YYkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="265390038"
Received: from fdefranc-mobl3.igk.intel.com ([172.28.182.157])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 19:26:42 -0700
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
Subject: [PATCH v2 01/13] cxl/pci: Make the HDM and Mem_Enable writes callable from CXL
Date: Tue, 25 Aug 2026 04:26:16 +0200
Message-ID: <20260825022628.3651434-2-fabio.m.de.francesco@linux.intel.com>
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

Split the Global Control write out of devm_cxl_enable_hdm() as
cxl_enable_hdm() and drop the static from cxl_set_mem_enable(), so both
are reachable from the rest of cxl_core. Declare them in core.h.

Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
---
 drivers/cxl/core/core.h |  2 ++
 drivers/cxl/core/pci.c  | 19 ++++++++++++++-----
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 07555ae63859..4dc324f019ab 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -213,6 +213,8 @@ int cxl_gpf_port_setup(struct cxl_dport *dport);
 struct cxl_hdm;
 int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
 			struct cxl_endpoint_dvsec_info *info);
+void cxl_enable_hdm(struct cxl_hdm *cxlhdm, u32 global_ctrl);
+int cxl_set_mem_enable(struct cxl_dev_state *cxlds, u16 val);
 int cxl_port_get_possible_dports(struct cxl_port *port);
 
 #ifdef CONFIG_CXL_FEATURES
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index e4338fd7e01b..a7a2b84293e9 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -179,7 +179,7 @@ int cxl_await_media_ready(struct cxl_dev_state *cxlds)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_await_media_ready, "CXL");
 
-static int cxl_set_mem_enable(struct cxl_dev_state *cxlds, u16 val)
+int cxl_set_mem_enable(struct cxl_dev_state *cxlds, u16 val)
 {
 	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
 	int d = cxlds->cxl_dvsec;
@@ -247,14 +247,23 @@ static void disable_hdm(void *_cxlhdm)
 	       hdm + CXL_HDM_DECODER_CTRL_OFFSET);
 }
 
-static int devm_cxl_enable_hdm(struct device *host, struct cxl_hdm *cxlhdm)
+/*
+ * @global_ctrl is the CXL HDM Decoder Global Control value to enable decode in.
+ * A caller restoring decode after a reset passes the value it saved, so the
+ * fields the driver does not model are not left at their reset defaults.
+ */
+void cxl_enable_hdm(struct cxl_hdm *cxlhdm, u32 global_ctrl)
 {
 	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
-	u32 global_ctrl;
 
-	global_ctrl = readl(hdm + CXL_HDM_DECODER_CTRL_OFFSET);
 	writel(global_ctrl | CXL_HDM_DECODER_ENABLE,
 	       hdm + CXL_HDM_DECODER_CTRL_OFFSET);
+}
+
+static int devm_cxl_enable_hdm(struct device *host, struct cxl_hdm *cxlhdm,
+			       u32 global_ctrl)
+{
+	cxl_enable_hdm(cxlhdm, global_ctrl);
 
 	return devm_add_action_or_reset(host, disable_hdm, cxlhdm);
 }
@@ -398,7 +407,7 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
 	 * enable and use the HDM Decoder Capability registers.
 	 */
 	if (!info->mem_enabled) {
-		rc = devm_cxl_enable_hdm(&port->dev, cxlhdm);
+		rc = devm_cxl_enable_hdm(&port->dev, cxlhdm, global_ctrl);
 		if (rc)
 			return rc;
 
-- 
2.55.0


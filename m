Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4A7326927;
	Tue, 25 Aug 2026 02:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787624900; cv=none; b=P1eadKpmn8MBdNjg9lMcFYdd/eGAiz7AZvtXYugtYynhkGcckVT4zTVAng/V6gZu8/Nk3g1eHsSGX2hwRXudebADSpvyLXPP33LVYysRLQvE5GcJO9OdjBf6kBs/qfuIMTh/CMXoSyBwKVfSIrE/S1mDlQGbKIZeGi4DWFNRVKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787624900; c=relaxed/simple;
	bh=p35ooKxDDEqYJs00+ywe+gwGYag0qhbr8UgYGTT8yA4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MEHGlnS7L6ztiiIvMU0TBbVVKz1RFJyoS/st+ToNSvwJ0FnGOSF+K3FPtV7xSeQRZ3jp7bZGDvP1wjZ0uG+BI6DvBLBli+KpzWf93RM15Keodokes3aLTz6OTf3DCbQBI/+/diUD8aNnMun6etuoR1ZVAC04otRLRNUPPVnL+os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EcsPSqjd; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EcsPSqjd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787624897; x=1819160897;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=p35ooKxDDEqYJs00+ywe+gwGYag0qhbr8UgYGTT8yA4=;
  b=EcsPSqjdcQzMIwzL8QuxbfHx6N9Ii29yYHQlqe1aQ19Ls0pDnqSIm2Yo
   ptVwERD7ScE0GRAxoeAJ1cYSqCv5Rz1w2a3qXOUdnxLqrN6aSdJisFn48
   fog6XSIZbjTrB2s4ojmdjZtmb4jPF4fUSNWNvDwnSs9eJN17JpWX7yeJj
   p19dJsfi85IPHOjqZlsgwko5J13G793JR+28OCRqh6Kb5Nd9P5i5UyRBm
   FRjXsDeCpB65FzDgWo/y0HxzpbE8v84TI4cwWfcjmH1XfRoEUBnqTMfnz
   6EkWAfnTlhQVHxXErLfHZOujR/U8ynKlwCMi1OSzVTMhVxcq2ZHfLPV/w
   g==;
X-CSE-ConnectionGUID: 2p3p+RW7Teyj+i/hyXyQ7g==
X-CSE-MsgGUID: y2nflL3OTFSuvMGzIw7DTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="98761235"
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="98761235"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 19:28:16 -0700
X-CSE-ConnectionGUID: KQlGpQmQRWef0MiKW/Zq2g==
X-CSE-MsgGUID: n6NeHPHmT6KWhioKt0tOhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="265390156"
Received: from fdefranc-mobl3.igk.intel.com ([172.28.182.157])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 19:28:09 -0700
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
Subject: [PATCH v2 13/13] PCI/CXL: Refuse an SBR of a CXL DPort unless authorized
Date: Tue, 25 Aug 2026 04:26:28 +0200
Message-ID: <20260825022628.3651434-14-fabio.m.de.francesco@linux.intel.com>
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

CXL r4.0 sec 8.1.5.2 Table 8-32 describes a bit that makes the SBR bit
in Bridge Control take effect at all, so a Port left at the firmware
default is one the reset must not silently unmask.

Add cxl_sbr_allowed() to answer if SBR is allowed: check if a Port whose
Unmask SBR is already set needs no consent, as it happens with cxl_bus
reset.

Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
---
 drivers/pci/pci.c | 26 ++++++++++++++++++++++++++
 drivers/pci/pci.h |  1 +
 2 files changed, 27 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index eedd516f8484..08873ea3957b 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4881,6 +4881,11 @@ static int cxl_sbr_prepare(struct pci_dev *bridge, u16 dvsec,
 {
 	int rc;
 
+	if (action == CXL_SBR_OFFLINE_AND_UNBIND && !cxl_sbr_allowed(bridge)) {
+		pci_info(bridge, "SBR masked, write 1 to cxl_unmask_sbr to allow a bus reset\n");
+		return -ENOTTY;
+	}
+
 	/*
 	 * CXL_SBR_UNBIND: the link is already down, so offlining the regions'
 	 * memory would take the reads that page migration performs as a machine
@@ -5138,6 +5143,27 @@ static bool cxl_sbr_masked(struct pci_dev *dev)
 	return true;
 }
 
+/*
+ * cxl_sbr_allowed - whether an SBR of a CXL Downstream Port may go ahead
+ * @dev: Downstream Port to test
+ *
+ * Per CXL r4.0 sec 8.1.5.2 Table 8-32 the SBR bit in a CXL Port's Bridge
+ * Control register has no effect while the Port's Unmask SBR bit is clear, and
+ * sec 9.12.3 says System Firmware may leave it clear "to prevent CXL-unaware
+ * PCIe software from resetting the device and the link". A Port that already
+ * has it set needs no further permission; otherwise unmasking it takes the
+ * administrator's consent, given by writing 1 to the Port's cxl_unmask_sbr.
+ *
+ * Return: true if the reset paths may unmask and generate an SBR of @dev.
+ */
+bool cxl_sbr_allowed(struct pci_dev *dev)
+{
+	if (!cxl_port_dvsec(dev))
+		return false;
+
+	return dev->cxl_unmask_sbr || !cxl_sbr_masked(dev);
+}
+
 static int pci_reset_bus_function(struct pci_dev *dev, bool probe)
 {
 	struct pci_dev *bridge = pci_upstream_bridge(dev);
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index b6d873b077ed..bea05acc58f0 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -248,6 +248,7 @@ int __pci_bridge_secondary_bus_reset(struct pci_dev *dev,
 				     enum cxl_sbr_region_action action);
 bool is_cxl_dport(struct pci_dev *dev);
 u16 cxl_port_dvsec(struct pci_dev *dev);
+bool cxl_sbr_allowed(struct pci_dev *dev);
 int pci_bus_error_reset(struct pci_dev *dev);
 int pci_try_reset_bridge(struct pci_dev *bridge);
 
-- 
2.55.0


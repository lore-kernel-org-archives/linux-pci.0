Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446BD24E4A1;
	Tue, 25 Aug 2026 02:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787624891; cv=none; b=fJF0SIZmV9+FSdf9QL90ENe00v9NPF4EoHBt9D1J0gLDOoM15ODn+pIog9gNliNTmEil5AKKU8A0y7Q+33nBVrVFQOP/Hc6zaoCGwH1Hz2JcRF1X2OfndgSkERnDmNU3wmvtBLRDMiYVppY8zITCNDo/QhqhGrxvxtaMC9yeNP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787624891; c=relaxed/simple;
	bh=FUdOrKAllFyNGlbt+7H02DeS9Es+Uvq5pCkFtZCzCVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eBr+Se/wsb+0dWfn0mbP6fO3PW9CGWperzfD+FnHDirzpIx0pyLhzUhl84YwlkzydJJD6czEgBH5XTSdAg/HjUsgdPNirWMki97w9XMnhhyNm/H6QaM+H7/hYk9DOYDDYC8PGzxs25kaHJDJc2O+4EjX+Y36p415EGqsr7tQp6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GwB7NaZZ; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GwB7NaZZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787624890; x=1819160890;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FUdOrKAllFyNGlbt+7H02DeS9Es+Uvq5pCkFtZCzCVY=;
  b=GwB7NaZZRylVPK8y08q6A7VpGV3ap13v/f/Y+rQkeUcIkhE3gSos6KNg
   pbNEwympOlH/i5cOUBv3YWD7eRSH7QcafZmzoItX2dEcAqm15oQgMUAIw
   PiVRSYpi/1tWO74xmKiFvp6E0WWAgGGV76vKpZ6TODWDxyejaeCqYxqss
   gKW6guIkCsehvN0ztif0nb5S4IXrYV7FeWt5Y9zpj8QHp9kE/M1/AdR52
   j4oq4dwJ+OXVN6rWiky215Eg8atNmpxHnlMGLFaZfRb8mA/t6K1z75oKk
   LGsNGvvfZNl2Xx3Iw3hDE94Bj5YwRj8O6nY3EnnR3dg/6sz0ufKt+qpR1
   Q==;
X-CSE-ConnectionGUID: ybHkVAyDRv2xEDKdareJmg==
X-CSE-MsgGUID: fBO8zBxwSMu82VLa0VwnHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="98761221"
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="98761221"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 19:28:09 -0700
X-CSE-ConnectionGUID: FDcQU3FlQ1CYUmjpJn2HKA==
X-CSE-MsgGUID: jZ8XDkaASU+FbuakNuw/nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="265390142"
Received: from fdefranc-mobl3.igk.intel.com ([172.28.182.157])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 19:28:01 -0700
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
Subject: [PATCH v2 12/13] PCI/CXL: Add a sysfs entry to unmask SBR
Date: Tue, 25 Aug 2026 04:26:27 +0200
Message-ID: <20260825022628.3651434-13-fabio.m.de.francesco@linux.intel.com>
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

A Secondary Bus Reset of a CXL Downstream Port only reaches the component
below it when the Port's Unmask SBR bit is set. CXL r4.0 sec 8.1.5.2
Table 8-32: "When cleared to 0 (default), the SBR bit in this Port's
Bridge Control register has no effect." A kernel that unmasks it on its own initiative overrules
that for every path reaching pci_bridge_secondary_bus_reset() SBR.

Add a cxl_unmask_sbr attribute beside reset_subordinate in the Port's
sysfs directory to allow kernel triggered SBR of CXL DPorts.

Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
---
 Documentation/ABI/testing/sysfs-bus-pci | 16 +++++++++++++
 drivers/pci/pci-sysfs.c                 | 31 +++++++++++++++++++++++++
 include/linux/pci.h                     |  1 +
 3 files changed, 48 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
index b767db2c52cb..7b0314da6f4d 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci
+++ b/Documentation/ABI/testing/sysfs-bus-pci
@@ -174,6 +174,22 @@ Description:
 		similiar to writing 1 to their individual "reset" file, so use
 		with caution.
 
+What:		/sys/bus/pci/devices/.../cxl_unmask_sbr
+Date:		August 2026
+Contact:	linux-pci@vger.kernel.org
+Description:
+		This is visible only for a CXL Downstream Port, that is a Root
+		Port or a Downstream Switch Port that publishes the CXL
+		Extensions DVSEC for Ports.  Such a Port ignores the Secondary
+		Bus Reset bit in its Bridge Control register unless its
+		"Unmask SBR" bit is set, and system firmware leaves that bit
+		clear by default.
+
+		Writing 1 allows the kernel to set "Unmask SBR" while it
+		resets the Port's secondary bus, so that the reset reaches the
+		component below the Port.  While this reads 0, a bus reset of
+		the Port fails instead.
+
 What:		/sys/bus/pci/devices/.../vpd
 Date:		February 2008
 Contact:	Ben Hutchings <bwh@kernel.org>
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 5ec0b245a69b..ba1cae6ab4fa 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -573,6 +573,33 @@ static ssize_t reset_subordinate_store(struct device *dev,
 }
 static DEVICE_ATTR_WO(reset_subordinate);
 
+static ssize_t cxl_unmask_sbr_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+	return sysfs_emit(buf, "%u\n", pdev->cxl_unmask_sbr);
+}
+
+static ssize_t cxl_unmask_sbr_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t count)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	unsigned long val;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	if (kstrtoul(buf, 0, &val) < 0)
+		return -EINVAL;
+
+	pdev->cxl_unmask_sbr = !!val;
+
+	return count;
+}
+static DEVICE_ATTR_RW(cxl_unmask_sbr);
+
 #if defined(CONFIG_PM) && defined(CONFIG_ACPI)
 static ssize_t d3cold_allowed_store(struct device *dev,
 				    struct device_attribute *attr,
@@ -650,6 +677,7 @@ static struct attribute *pci_bridge_attrs[] = {
 	&dev_attr_subordinate_bus_number.attr,
 	&dev_attr_secondary_bus_number.attr,
 	&dev_attr_reset_subordinate.attr,
+	&dev_attr_cxl_unmask_sbr.attr,
 	NULL,
 };
 
@@ -1824,6 +1852,9 @@ static umode_t pci_bridge_attrs_are_visible(struct kobject *kobj,
 	struct device *dev = kobj_to_dev(kobj);
 	struct pci_dev *pdev = to_pci_dev(dev);
 
+	if (a == &dev_attr_cxl_unmask_sbr.attr && !is_cxl_dport(pdev))
+		return 0;
+
 	if (pci_is_bridge(pdev))
 		return a->mode;
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 0d9832ce6f3d..bc0f652eff80 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -485,6 +485,7 @@ struct pci_dev {
 	unsigned int	shpc_managed:1;		/* SHPC owned by shpchp */
 	unsigned int	is_thunderbolt:1;	/* Thunderbolt controller */
 	unsigned int	is_cxl:1;               /* Compute Express Link (CXL) */
+	unsigned int	cxl_unmask_sbr:1;	/* SBR unmask allowed by user */
 	/*
 	 * Devices marked being untrusted are the ones that can potentially
 	 * execute DMA attacks and similar. They are typically connected
-- 
2.55.0


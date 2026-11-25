Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795648348;
	b=MbE9ycAt6bKXlb2Lyl+g4i7ZHBFqcJ6C7CvYvOsseaHRkAXniAuzzaSSpesf9SfFtZPF
	 8faZS7GY6LhCSvPj+2AHiZ/0cXnbp6bdvdTkdxWigRwFHAV/ksAilJDNf0+33LOlvaYKD
	 UeXqzLfg3g+ZaUV2c6gSx9bQowQOeBnVsotBVyjzhnnS7Tynx2p9/TT1yScEMTQHT39fP
	 V2Mx5UbykSnzU1Gf9xoMyS72TdvecBvYGLJnoVBeKb0jo0k5PLN/88HNkCVR+qbOmRBWg
	 dEy+HuBADFucQit0RZhjw79RLGfUz6WVzD2EVZr12qxRaNulRa59gpt1IIMyYbsp2wQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795648348;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=TvNRGQoF3JadlPQCXtsV1pMZb/nFcK2KKafsn3Xvae0=;
	b=JsmuXzACgxFjVqcsxOVX3T9jlnSAW0tBTjpFRsQLhGAicbqKdLC8pGeGXDiV+W/6kzQx
	 UBRMYO1WHDUVcJowMvGNXvVjbTCHCsEyxIuQP2IEA14F6FmDyVRLxRb0VdVbU0XVM7+rB
	 k3PQAzYTXMkv9jMt24ebR03HjUkwXDyVOZxRcY8jKfReIgp4B4dTV4CXtxdKW3N4HILoj
	 2RVuTw++E6HCrtRLFYsCnXwGbILvHENKZOv0shxaX+fEl6n9iPGEziPcuvIeaffHJ3omf
	 yWIve0qOoldFVmX0WUR1kqyF213wtpaQkRzKEx5Qp2GBMdxd6NYVUfGnZkDOMOaF+VQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GCdJy43f;
	arc=none smtp.remote-ip=192.198.163.17
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14198606A32D;
	Wed, 25 Nov 2026 23:12:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14198606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GCdJy43f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795648348; x=1827184348;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=325mDw4K1RIuaXMeY6wREwMN24y+XtK21203HnEfHA0=;
  b=GCdJy43fJM6rkLYLHzqmFwdXZJfHOcGEl6CcU7tjyUXVjtrOF2A9Dhkj
   Jnz2ou4tQ1bSiAaH9sSzGjMST+bFEQlEeybwNoyNcR9xr9VC8sAlMMMHi
   7UJEuied9AXlt2D5NetF155gNEEpbL5mh2tRd6Udetp55qCPBarjbehce
   IxIYgNsWYhVRM9Ab4QR3/SgBY2wyX8DIf13NiFqgJE8acSgk4uVALbIQM
   XuI7fdsz3M/hAW1GFYK8gq05IWOprAG1FmbTCLG+WK9KDUyHClAevkA+N
   /I3G4i3wAkV1Te4ideadGvbbKeQVDY9dw7aq+cNc768Btv3ojqRmYBUlH
   w==;
X-CSE-ConnectionGUID: AFZyrWVJTIixpAGoew/QWQ==
X-CSE-MsgGUID: VUyhiPKDReSTOd+61XdXGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11977"; a="4538302"
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="4538302"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 15:12:28 -0800
X-CSE-ConnectionGUID: sXQpjzJURhG77P2RlMZE6A==
X-CSE-MsgGUID: h8D1Bl86Ri+OPOo8hlegDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="12033098"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.96])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 15:12:25 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	David Matlack <dmatlack@google.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v3 17/17] PCI: Remove pci_bus_assign_resources()
Date: Thu, 26 Nov 2026 01:09:16 +0200
Message-ID: <20261125230925.2441-18-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261125230925.2441-1-ilpo.jarvinen@linux.intel.com>
References: <20261125230925.2441-1-ilpo.jarvinen@linux.intel.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The pci_bus_assign_resources() interface is problematic because it makes
bridge window sizing disjoint from the assignment phase.

pci_bus_assign_resources() is now unused so remove it.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/setup-bus.c | 8 --------
 include/linux/pci.h     | 1 -
 2 files changed, 9 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index e9fa8e1093d2..f308bc625cde 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1562,14 +1562,6 @@ static void __pci_bus_assign_resources(const struct pci_bus *bus,
 		pci_dev_res_free_list(add_list);
 }
 
-void pci_bus_assign_resources(const struct pci_bus *bus)
-{
-	guard(mutex)(pci_res_setup_lock(bus));
-	guard(rwsem_read)(&pci_bus_sem);
-	__pci_bus_assign_resources(bus, NULL, NULL);
-}
-EXPORT_SYMBOL(pci_bus_assign_resources);
-
 static void pci_claim_device_resources(struct pci_dev *dev)
 {
 	int i;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index f535ab12b04e..948198ad74fe 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1578,7 +1578,6 @@ ssize_t pci_write_vpd_any(struct pci_dev *dev, loff_t pos, size_t count, const v
 
 /* Helper functions for low-level code (drivers/pci/setup-[bus,res].c) */
 resource_size_t pcibios_retrieve_fw_addr(struct pci_dev *dev, int idx);
-void pci_bus_assign_resources(const struct pci_bus *bus);
 void pci_bus_claim_resources(struct pci_bus *bus);
 void pci_bus_size_bridges(struct pci_bus *bus);
 void pci_bus_size_and_assign_resources(struct pci_bus *bus);
-- 
2.47.3


Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B613A7F7E;
	Wed, 29 Apr 2026 12:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777465683; cv=none; b=iVTygNFXlYwTvLweEjn89OMlb8sGNeFf2oRD1+xosqX/3G09+L35s6j80RV2j29+wVYQ5zaZ1FuumF/MauVr7dVKBRf8OAl82x0zaWqR7CDfbBPg0gQVoXmOlypF+75+/tEmXz7HBcjT0KWZ1EnkJuFhkVAfTPy/rhgRFbVKoOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777465683; c=relaxed/simple;
	bh=fw+Loat2qyLgqvGvG/Jk0dbdhzaYJWuE1SAW/SPTWpo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dmi1bYyzl3sCalE43efjjugCcb7+JxLb9RaZzTgvv1Yp8CgWVTHNpvGpO9l35hOBrUi78yzBp+ztOfsyKMbcdP3966Rpn7CEUmxAJotfo7hS55OcALvhJMzkmDgezL3+PgTSQaKmgWkqkwLvMr/fAaN9JozbpTllm2WFFhF02gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K/lPdyrP; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K/lPdyrP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777465682; x=1809001682;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fw+Loat2qyLgqvGvG/Jk0dbdhzaYJWuE1SAW/SPTWpo=;
  b=K/lPdyrPvfv/drtvGpqkFPX+8TRzIDINuRFqLaWMeACU+BIa+Qi5CSxP
   fl20hTs+x2+4m5x+C4imRpGvgCVMthQAfBySApvI8fV14/WHgRbWVANPA
   Cw1vmstD6N3CZHfaj5AW9RxwBZmpZKn51GeliG9x0M1MHsslfabsPyH1H
   wyiqOikHOj6IoObaycImhxKWvpWnu6pwhauRLIpFjzX038ouYilhqUAxn
   FqMt783lRSR77+xqIXrqTDuhMtF841tt7jo1cnUKWNLcTVnK5N+0bwTkA
   i+aBvkGxxD0YNmbC6HKDOfNHTN7VlwoVeBuhiHEIm+5l0wpiHMPpd9M4k
   Q==;
X-CSE-ConnectionGUID: ubrm0mXkQM+/x7sm4fiKyw==
X-CSE-MsgGUID: AWi0bEjkSnuI6K7tHB5ibA==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="78101853"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="78101853"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 05:28:02 -0700
X-CSE-ConnectionGUID: A2voe4hURxKRu6GvpKDDDg==
X-CSE-MsgGUID: zK9kVFhfSe2LF3GcQiLeoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="257573702"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.212])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 05:27:58 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Jin <shawn.jin@asteralabs.com>,
	linuxppc-dev@lists.ozlabs.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 08/11] PCI: Convert pci_resource_alignment() input parameters to const
Date: Wed, 29 Apr 2026 15:26:14 +0300
Message-Id: <20260429122617.7324-9-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260429122617.7324-1-ilpo.jarvinen@linux.intel.com>
References: <20260429122617.7324-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

pci_resource_alignment() calculates resource alignment and should not
alter its input structs. Make its input parameters const.

It requires making also pci_cardbus_resource_alignment() input const.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/pci.h           | 8 ++++----
 drivers/pci/setup-cardbus.c | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 710803be3a79..e0fcc33dfef6 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -419,7 +419,7 @@ static inline bool pci_is_cardbus_bridge(struct pci_dev *dev)
 	return dev->hdr_type == PCI_HEADER_TYPE_CARDBUS;
 }
 #ifdef CONFIG_CARDBUS
-unsigned long pci_cardbus_resource_alignment(struct resource *res);
+unsigned long pci_cardbus_resource_alignment(const struct resource *res);
 int pci_bus_size_cardbus_bridge(struct pci_bus *bus,
 				struct list_head *realloc_head);
 int pci_cardbus_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
@@ -428,7 +428,7 @@ int pci_cardbus_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 int pci_setup_cardbus(char *str);
 
 #else
-static inline unsigned long pci_cardbus_resource_alignment(struct resource *res)
+static inline unsigned long pci_cardbus_resource_alignment(const struct resource *res)
 {
 	return 0;
 }
@@ -1044,8 +1044,8 @@ static inline void pci_suspend_ptm(struct pci_dev *dev) { }
 static inline void pci_resume_ptm(struct pci_dev *dev) { }
 #endif
 
-static inline resource_size_t pci_resource_alignment(struct pci_dev *dev,
-						     struct resource *res)
+static inline resource_size_t pci_resource_alignment(const struct pci_dev *dev,
+						     const struct resource *res)
 {
 	int resno = pci_resource_num(dev, res);
 
diff --git a/drivers/pci/setup-cardbus.c b/drivers/pci/setup-cardbus.c
index 1ebd13a1f730..0cba404080ad 100644
--- a/drivers/pci/setup-cardbus.c
+++ b/drivers/pci/setup-cardbus.c
@@ -22,7 +22,7 @@
 static unsigned long pci_cardbus_io_size = DEFAULT_CARDBUS_IO_SIZE;
 static unsigned long pci_cardbus_mem_size = DEFAULT_CARDBUS_MEM_SIZE;
 
-unsigned long pci_cardbus_resource_alignment(struct resource *res)
+unsigned long pci_cardbus_resource_alignment(const struct resource *res)
 {
 	if (res->flags & IORESOURCE_IO)
 		return pci_cardbus_io_size;
-- 
2.39.5


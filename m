Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793972653;
	b=qKHaKR9jlygJcewD92ThIcXuvaDKddOlNpz4BI7YrPBrrHOzYiNsPZTFbw7ZIRWGyTlN
	 ZQ1fgtQP0984Qg3QP0tAcMFe1/204T71zxGpJCdwA/qj8wZ7nI4r/da1Yy6EG+l/CNeZm
	 H3ytPoqv+FoQsLQ78VDzEso8QvnaSiOM7s3fmlvzAr1SfthJnD7xYQhBTOcug7S0fI+88
	 51EhLaaCu7bczHtQ7gBvi00bwAbLIeKpTUUlr+fqEP1DjpVpXl3xpHYZZbfzdEc/RCnNg
	 p9P14vMyTRUL3HqEPT3wSZM/up0Rr6A97GbhPo4fNo5oTHj2GGVwgZ9P8QDxFV8AkFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793972653;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=hrnBMF5HG/70kueceexSSj6tkrkIDjj6mHUicHbUSBw=;
	b=qOXXp83sZBojMmaanAk7WAElpaDJEscCVd8ziMa1kcgteJs4Tj2OiZWxc64xm1mLsiQi
	 eB9qGpYJMj8zP0+aRKQOVUiJZ6iD5tN5W7cbf3TpJABA9po6Qkc4efYWJpJGej+vOzyo+
	 gGNoAsi66UwVf66vtmjETxlIq4O7yXcUvyU1WPwy442S3bdwpHQgg9Nm16VV+EMnvm/cy
	 OC2vi5FHpztFf7nsEP6xHeJjtD6Ey3Rqh2nDqOm7Ei8TWyIJGhvvJno0OQEyH+NNKCMns
	 Tjy+x7JQPpc3DS3BCOz7VPAlyJPyqN9nZzeElISBTABPH6XYiYbA6QgfmNx2Ux0nqdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TT7TCsA1;
	arc=none smtp.remote-ip=198.175.65.17
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F547606A32D;
	Fri,  6 Nov 2026 13:44:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F547606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TT7TCsA1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793972653; x=1825508653;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1bQMHmLWPMUWCLfRWJYabQJKNfn+DLHWn2JMm+IlsDM=;
  b=TT7TCsA1YQvUno+sT40NvW+r/Fukz0dOLGfENgSZczgKJFAqoh6Rg33X
   A8x3eFj86dNx1Gsv4qn8kUS24DfrxnlCg422jbda78StDCUBgP/Ar/E13
   y5EXSIixUG9b+YHkLKtrX1k3I/RKBQXowNF3i3R6NgNspPjeS9fQxhQKB
   t6zccdKSEB72gNbq9mSP5Nmixq3/IAMI//QDkbcY8x487EZxx3Jb0IPsD
   7dEdfNnije67o8lvBIYu/Frn3iQtiuXcKxJBA7KJxZCU8gulBvu5P+PAo
   jwFSCCoZCyJX+oZIOcACb6lPnuj7Im53Ly0s8l7xVAuRH90/4QuHdUCpb
   w==;
X-CSE-ConnectionGUID: lF9IEn/+RdyGlKxVrvdiVQ==
X-CSE-MsgGUID: 6vu6xIT2SB+Ir8PWSYAskQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2812214"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2812214"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 05:44:12 -0800
X-CSE-ConnectionGUID: kc4R8L/eR/+XBsE5xa9QbA==
X-CSE-MsgGUID: Vpwxhw0RQyy478WaS4Iqyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7609856"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.104])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 05:44:08 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Maciej Grochowski <Maciej.Grochowski@sony.com>,
	Geramy Loveless <gloveless@jqluv.com>,
	Eric Auger <eauger@redhat.com>,
	Alexey Fomenko <alexey.fomenko@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Mesih Kilinc <Mesih.Kilinc@sony.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Helge Deller <deller@gmx.de>,
	linux-parisc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v5 02/14] parisc/PCI: Clean up resource debug print & use dynamic debug
Date: Fri,  6 Nov 2026 15:43:23 +0200
Message-ID: <20261106134341.39493-3-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261106134341.39493-1-ilpo.jarvinen@linux.intel.com>
References: <20261106134341.39493-1-ilpo.jarvinen@linux.intel.com>
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

Remove ad hoc DBG_RES() and use pci_dbg() instead.

Remove printing parent resource as the passed resource is a temporary
one not within the resource tree so accessing ->parent does not make
sense.

Reformat the message to the typical format used by PCI core. Print the
resource using %pR.

Correct format specifiers and remove nonsensical res->flags int cast.

Dynamic debug prints can be enabled by providing dyndbg command line
parameter or through /sys/kernel/debug/dynamic_debug/control so this is
a more versatile way to debug things than the previous compile time
decision which could only be enabled by changing the source code.

Acked-by: Helge Deller <deller@gmx.de>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 arch/parisc/kernel/pci.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/arch/parisc/kernel/pci.c b/arch/parisc/kernel/pci.c
index b8007c7400d4..96950fe9c2b7 100644
--- a/arch/parisc/kernel/pci.c
+++ b/arch/parisc/kernel/pci.c
@@ -19,7 +19,6 @@
 #include <asm/io.h>
 #include <asm/superio.h>
 
-#define DEBUG_RESOURCES 0
 #define DEBUG_CONFIG 0
 
 #if DEBUG_CONFIG
@@ -28,13 +27,6 @@
 # define DBGC(x...)
 #endif
 
-
-#if DEBUG_RESOURCES
-#define DBG_RES(x...)	printk(KERN_DEBUG x)
-#else
-#define DBG_RES(x...)
-#endif
-
 struct pci_port_ops *pci_port __ro_after_init;
 struct pci_bios_ops *pci_bios __ro_after_init;
 
@@ -204,10 +196,9 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
 	struct pci_dev *dev = data;
 	resource_size_t align, start = res->start;
 
-	DBG_RES("pcibios_align_resource(%s, (%p) [%lx,%lx]/%x, 0x%lx, 0x%lx)\n",
-		pci_name(((struct pci_dev *) data)),
-		res->parent, res->start, res->end,
-		(int) res->flags, size, alignment);
+	pci_dbg(dev, "%pR: pcibios_align_resource(%lx, 0x%llx, 0x%llx)\n",
+		res, res->flags, (unsigned long long)size,
+		(unsigned long long)alignment);
 
 	/* If it's not IO, then it's gotta be MEM */
 	align = (res->flags & IORESOURCE_IO) ? PCIBIOS_MIN_IO : PCIBIOS_MIN_MEM;
-- 
2.47.3


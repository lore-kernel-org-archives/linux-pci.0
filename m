Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB68370AE5;
	Fri,  2 Oct 2026 11:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790940847; cv=none; b=hvhTjG/2KS6rzg8I9HMJy5oCuaw2kYH2XnXAwLDchwY+IpHtUcRqZ30mT3XsmGUYwO8+fsjbidL+yqay8Vzp2GSx8Wz99BiUqsO7ZwpKC5zLtbD0MF6fziIoAT9CaA/zezrvf178b4QVZ3HV3fCDEphDwdWIZlUDMExfz3fw0Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790940847; c=relaxed/simple;
	bh=i+X3Q3G6InOXfVFNbn9HUfLE+qNO7ZkTOMJKo2+f8cQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VGDMdmGPOn3I0bLd+32ACitwGda4knsOOkJFTUWS8j/1EizbI++DjJniTY7YLXXilZaay15jDlb9ArpzEPcKbyTdU/xzrxqfw/KkK06986R4aU4fkRGoNxYpqvOozeF3bDeGuF6DeWSxWEdQ0zP0cK3BsgmHuH1+A54dp+965gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WU965tmv; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WU965tmv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790940846; x=1822476846;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=i+X3Q3G6InOXfVFNbn9HUfLE+qNO7ZkTOMJKo2+f8cQ=;
  b=WU965tmvlJksMLvRZqChOYPp/a1AUfaUikZyq6TJ0+fSOcB+KV98vXad
   VvJKFH5zDiFD3sZq8+87lIZr0JWRoJZMIQRn9XlRTqoL76rM8oii+mscn
   MeP/GXWUyS/NTdunk6fvIy3NOI4JMrHmRhH4Dpfwg9nF0RIgerC45i7Dr
   T3CHMDenffbssJFDr6TTl8ZEJEvjk/7jyZl1DgjbHCkagR4z49s9t1vMY
   wnsKv/iegBfi7RLF0ObtqoMMeZ0nx6JBYjsBXuCxmJ/+cE5F4pzuW7k0/
   k5uDFqVOun8ImPxXCQrPS5iS0T3//Hd3mgEaTceaCCo8L/CKeQCVuEsjf
   Q==;
X-CSE-ConnectionGUID: 8ZDRLVqqTsmAhc9WNS+Efw==
X-CSE-MsgGUID: oSKRl9WrQ4WUATn5dcs6Qg==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="90659753"
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="90659753"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 04:34:01 -0700
X-CSE-ConnectionGUID: H4OkxXLsRo+m4Xm3risE8A==
X-CSE-MsgGUID: 1fpjQhQvQMmaZTzfmOmKFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="279969495"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.243])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 04:33:54 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Maciej Grochowski <Maciej.Grochowski@sony.com>,
	Nikolas Joshua Britton <nbritton@exabit.io>,
	Geramy Loveless <gloveless@jqluv.com>,
	Eric Auger <eauger@redhat.com>,
	Alexey Fomenko <alexey.fomenko@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Helge Deller <deller@gmx.de>,
	linux-parisc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Bradley Morgan <brads@mainlining.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 2/7] PCI/parisc: Clean up resource debug print & use dynamic debug
Date: Fri,  2 Oct 2026 14:33:10 +0300
Message-ID: <20261002113319.6652-3-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261002113319.6652-1-ilpo.jarvinen@linux.intel.com>
References: <20261002113319.6652-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Remove adhoc RES_DBG() and use pci_dbg() instead.

Reformat the message to the typical format used by PCI core. Print the
resources using %pR.

Correct format specifiers and remove non-sensical res->flags int cast.

Dynamic debug prints can be enabled by providing dyndbg command line
parameter or through /sys/kernel/debug/dynamic_debug/control so this
is more versatile way to debug things than the previous compile time
decision which could only be enable by changing the source code.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 arch/parisc/kernel/pci.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/arch/parisc/kernel/pci.c b/arch/parisc/kernel/pci.c
index b8007c7400d4..518f532ccddc 100644
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
+	pci_dbg(dev, "%pR: pcibios_align_resource(%lx, 0x%llx, 0x%llx), parent %pR\n",
+		res, res->flags, (unsigned long long)size,
+		(unsigned long long)alignment, res->parent);
 
 	/* If it's not IO, then it's gotta be MEM */
 	align = (res->flags & IORESOURCE_IO) ? PCIBIOS_MIN_IO : PCIBIOS_MIN_MEM;
-- 
2.47.3


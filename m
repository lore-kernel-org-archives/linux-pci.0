Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A763282F2A;
	Tue, 13 Oct 2026 13:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791897027; cv=none; b=hs8kdwVkuZheK75n8XuQC9Zwxz3L3svs1rlmp0ckPDHKtfnmK02mL5inpAeaV13kza7ie75yA63saiW+/vaojgRHIkVXc/W/BKJQG1FGJDAjZz+Te9vtH2RfouF+tY3FDxdn3Aqt/xaBGBxfHOu8uluqoyyV0OPhN7shnxd+4zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791897027; c=relaxed/simple;
	bh=5yC1RcwgQFaBFsIHDf9/87mF9NkyXNXpJl5nk0kEYtU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jQ/WoZ6UlCkvCuzYD5ddTOcBOiIXDctY6RtpvWuKaVv4rU2THicuUYUKQliWhlRyAHgFmVdViLnQM/uUcBngesykmtfq9xy/KaFkXxRWxO6106aTncuIVFVTZdADg3OoMp4xZ+KzOXxUb5vPdyxGKhHo28S+mjMaTuARRbeS8HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UyiWK9X+; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UyiWK9X+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791897027; x=1823433027;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5yC1RcwgQFaBFsIHDf9/87mF9NkyXNXpJl5nk0kEYtU=;
  b=UyiWK9X+5Z+QSBAhSvQn+bWye5nijpcWXd02XNUQ+PBSPlNYWvBax1vT
   L17VXMqLQuoWrTf/9huC2zMcH6iDCO+VNGskkm0CbZ5032s0ulTfhk/sx
   RRhq+P0hs7uF5Ad9VmbCYWJwp1Xz8XioNdfxoF09nBichCDbi41Hg0Vf9
   vDiyoxUI9A6p836pqnxclt8S2+qDaD0VGovy7wXhMmYPfgKY2sWUZKfE8
   jU+/3W/kMkjPPIRl2cJwy4dAogp/egp3RczhDkUfZB/vfUnRZX3WWCcP7
   +WXZK0addUujAWQJl64AUp8q09DqrLIri3FYJVbgCV8y6yllCoFMzVrUk
   A==;
X-CSE-ConnectionGUID: xKWZX82CRfCZlrdUKLa/zg==
X-CSE-MsgGUID: PDfkcFuaQoKDH3fARNVkKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="614357"
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="614357"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 06:10:19 -0700
X-CSE-ConnectionGUID: nGzmQCQVQwujyrFtzmXujQ==
X-CSE-MsgGUID: FoyBQsNxRrO28JjfvQWLBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="1247564"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.106])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 06:10:13 -0700
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
Subject: [PATCH v3 2/8] PCI/parisc: Clean up resource debug print & use dynamic debug
Date: Tue, 13 Oct 2026 16:09:36 +0300
Message-ID: <20261013130948.6231-3-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261013130948.6231-1-ilpo.jarvinen@linux.intel.com>
References: <20261013130948.6231-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Remove adhoc RES_DBG() and use pci_dbg() instead.

Remove printing parent resource as the passed is a temporary resource
not within the resource tree so accessing ->parent does not make sense.

Reformat the message to the typical format used by PCI core. Print the
resource using %pR.

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


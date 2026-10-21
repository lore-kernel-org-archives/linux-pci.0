Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792587034;
	b=p2DFWg1zibF3DOuBDpPshXtk7v8cuc5UrQO8Gafe3CJGA4w6sEmi4/bn4OM9Y9VFGm/p
	 ZBuSgrlVOsfrqqOZQW/+tzELIg9iEiPr9vavpdYv+RxiorqECgQaNhxLx/U+R4Vr2GC9V
	 75gg4IqTykMIcmCnQUx89/Mu1d2jgjMsQQoRw6VrjrpXni33tm7l7awlaRbah3hGB8wFO
	 8F34LXTxwUj7Nitonbx2QmXQzVnLepadA6ea4oZrad7/6BT/7QWWcDkTy4fBkKPQ3rqeL
	 VsG0ZNYVvMXPwDJFftC84hILoi794/Op1cp3nzqh3mTzEnOgFUN+TnihYbSrF+6clOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792587034;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=Sc2Svz3D+0p9HcIDYpnSkuLEf0CRAGQ3fc5I0e83+JQ=;
	b=ESqj3zHtShf0jHsbas3Gmuxe6KRD/ED1fFWCp2pqXX0NesW9NFcKklfsXLQbvD2ItKUC
	 l2WcitA9EYXOdb3W24nJJ2Ic1CLwe6ph1BPA8wshk3qThpUETzOOvKpGa75Ksq3wN8ule
	 YbD1sHnTMS5pVBSkd2r2a2eRn4O86PFJVmKASk8n5BBIawXrl8gfQvGmpwaC/gSQKfvjv
	 MxlsbJLXO08m+jAe0866HurXXilYVkUIbx4j5omFR2nt6okt00Y33NBetZzhAw2qz/JjH
	 CP+JdGlRK5k22hgKP7aR6pEx32sxXaJRTF2vbUzOs+1VJu4N0a0PmXGppknwhGX0B5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=IOR0QiRJ;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AB1606A31A;
	Wed, 21 Oct 2026 12:50:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5AB1606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=IOR0QiRJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792587034; x=1824123034;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5yC1RcwgQFaBFsIHDf9/87mF9NkyXNXpJl5nk0kEYtU=;
  b=IOR0QiRJoA5E+PFC6I6QVc8Vevi4U3liuWzBkuCsLRQF9DZhMPr3SA+J
   4or7Rp3qGgXWnxq/gn5BMXlBa3l9fQ+hgsWEWXr6elPZNl5aaCX0ENpI6
   4Kau2+bQ3V8xsHnxVn8X/8iVCvi4s1lAo2iRT4c5sYgY+rVzn75ybdll1
   eDIO/Vmu+N4skvAHfk6Z+ugIAEF2Q8LGakwYO16CqsdDydGOdfvmHROPQ
   Ta9XZQrbwb/L97dip6QOblhi8iNjgr1bM4zmQInhljWn6BjMq+wslTVKB
   UVFB2d9R1Pa6+YV00hR65nVE9wKJcg8pqtn26Rwe0KNi82xYb9DRtNeVK
   A==;
X-CSE-ConnectionGUID: Wl19bHZ9SaOwDsTuZrBexg==
X-CSE-MsgGUID: mtwBfmfNRQKwO1rMteMnZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1408641"
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="1408641"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 05:50:33 -0700
X-CSE-ConnectionGUID: 6Nu6hnDaSNWjRbMrdFz+ew==
X-CSE-MsgGUID: 79HSLS3pSeKOJ12iJNvCSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="3426740"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.75])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 05:50:28 -0700
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
Subject: [PATCH v4 2/7] PCI/parisc: Clean up resource debug print & use dynamic debug
Date: Wed, 21 Oct 2026 15:49:47 +0300
Message-ID: <20261021124956.4250-3-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261021124956.4250-1-ilpo.jarvinen@linux.intel.com>
References: <20261021124956.4250-1-ilpo.jarvinen@linux.intel.com>
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


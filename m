Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793972724;
	b=bfrSihhx6XNWwfl1f0eHwT/ZKI5AZbMmtJ/DfDCn3eMAC2odIKL9NpucqS14nWdLcGNm
	 l3m2UBLsgHDOE5HqyTIGenSNUwJSGfsFkjlIkOdkshFyWYdN+3Xp3qZ6HezLd1PTwHxf5
	 QaS+vQdIAr3AEDnLSigJiL3pkbRnjqdFENfYtRZO6KylHhF1/NkO7k2Rht8eYc0UlGG7d
	 kHgTjDLuIUjYz2c+R5wsLSiEPJDSKEfOWwd12/yv1WvWpo2bb6VfDToKgZerFymzFqxH1
	 AFUu5oFHqDe8bs99UbfJQ4iOVhp2jCMywaiQiWd9qyK8lbeqeLMFwPNMYaQaehKbb1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793972724;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=rx7gGWe+qVjnuJYaCuf3PNKK+ddgMsbwCNHflbLARwg=;
	b=gvher7n2lihMWZImEVdOEnH1XdJDWiTtML7FsPU3qw+gXqWUywP0SfyjzPghwiBCUCYh
	 xxdU1GU82o2AORvbFinSMMtcSsdf/BiKnd6SYtAQNjEM+8A2jM6NGr+9Gt8BgrI6pU9RK
	 M6qIj9X5IgGP7Wh3g+IPnkpGKdoD/G3Z+Oium+5FYSaWdM1uES9DArGboaW52DwmHjCe3
	 Fr4jnbJAJWsv90G0WNZgiiu0FB8S52F7kD1R6Wpbrt1D2PLBfbJwJWzOzyJkVYCBubOSw
	 g6kmhuyPM9cNotohPN4ZqUelSl7mOqu9eiNFuwvtmu6QHfrRVeZdtLVd/sBxuNoLRjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Et9fL52Y;
	arc=none smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D522606A333;
	Fri,  6 Nov 2026 13:45:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D522606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Et9fL52Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793972723; x=1825508723;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=T4yGvXzWmKxa4531S1rrSDgyYW3DGI1nzB/fVYkEmEs=;
  b=Et9fL52Y0qNFm43atOHmpqnkysvJjlR1imntmkfbmHuUZKnzRm0NfqC6
   O87vhL6kYC0iCyFQ47FypBFP25XAzr7t0OEcpaVhvpNFMu2anmHdGaJ2c
   PlymsfapV006otXYS/cV4wgzu6pTTDH48mPnxAuf2hIBMIO6omGvWxyBG
   KsHRy0fydf3aLhEXncLShyXGlgN/vHqMFeyKeO59E2Ds7IVPUyUerwEry
   JFm7B6009qIP6y73O3mfGrVax0kaimSYqPnHZRAbe7FSmEYBUmsyw/rOC
   PUdlla89QOoGfJAsbqbZRm/UQK6GWnl8lm3XzNLTlhPPy1Kip6YHjHQB8
   Q==;
X-CSE-ConnectionGUID: vOh0j7LsRE6mWUzhLBZ0fw==
X-CSE-MsgGUID: cE8Anu/hTZm3lGTdMUTLpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2662035"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2662035"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 05:45:22 -0800
X-CSE-ConnectionGUID: BsGBMQ4JR6GY88O+RbhffA==
X-CSE-MsgGUID: SaRM3n8vRAqJ564RAPZjFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="9028391"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.104])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 05:45:07 -0800
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
	Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>,
	Magnus Lindholm <linmag7@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Helge Deller <deller@gmx.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Chris Zankel <chris@zankel.net>,
	Max Filippov <jcmvbkbc@gmail.com>,
	David Airlie <airlied@redhat.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Simona Vetter <simona@ffwll.ch>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-sh@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org
Cc: Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH v5 08/14] PCI: Honor alignment overrides
Date: Fri,  6 Nov 2026 15:43:29 +0200
Message-ID: <20261106134341.39493-9-ilpo.jarvinen@linux.intel.com>
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

pci=resource_alignment argument can override the default alignment for
the resource. The remainder code introduced in the commit 9036bd0efcb6
("PCI: Align head space better") can move remainder space (non-aligning
part of the size) before the aligning left edge which results in
violating the requested alignment.

Introduce struct pci_resreq_data to hold device and user-given alignment
to be able to honor it in pci_align_resource(). When user-given alignment
is found, any remainder movement is skipped.

PowerNV will not be able to use the current remainder logic after this
change because on it pcibios_default_alignment() always results in
setting min_align but this code is in a transient state and the problem
will be fixed by an upcoming change that rewrites the resource
placement algorithm with a more generic approach.

Fixes: 9036bd0efcb6 ("PCI: Align head space better")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://lore.kernel.org/linux-pci/20260923133202.07DF61F000FF@smtp.kernel.org/
Acked-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---

Jani Nikula <jani.nikula@intel.com> did ack this with a condition that
there is a proper review done by somebody else so I've not yet included
his tag.

 arch/alpha/kernel/pci.c          |  3 ++-
 arch/arm/kernel/bios32.c         |  5 +++--
 arch/m68k/kernel/pcibios.c       |  4 ++--
 arch/mips/pci/pci-generic.c      |  5 +++--
 arch/mips/pci/pci-legacy.c       |  5 +++--
 arch/parisc/kernel/pci.c         |  5 +++--
 arch/powerpc/kernel/pci-common.c |  5 +++--
 arch/sh/drivers/pci/pci.c        |  5 +++--
 arch/x86/pci/i386.c              |  5 +++--
 arch/xtensa/kernel/pci.c         |  5 +++--
 drivers/char/agp/intel-gtt.c     |  5 ++++-
 drivers/gpu/drm/i915/i915_gmch.c |  5 +++--
 drivers/pci/pci.c                |  4 ++--
 drivers/pci/pci.h                |  2 ++
 drivers/pci/setup-res.c          | 33 ++++++++++++++++++++++++++------
 include/linux/pci.h              | 15 +++++++++++++--
 16 files changed, 79 insertions(+), 32 deletions(-)

diff --git a/arch/alpha/kernel/pci.c b/arch/alpha/kernel/pci.c
index 11df411b1d18..c5d725a9781f 100644
--- a/arch/alpha/kernel/pci.c
+++ b/arch/alpha/kernel/pci.c
@@ -128,7 +128,8 @@ pcibios_align_resource(void *data, const struct resource *res,
 		       const struct resource *empty_res,
 		       resource_size_t size, resource_size_t align)
 {
-	struct pci_dev *dev = data;
+	struct pci_resreq_data *rr = data;
+	struct pci_dev *dev = rr->dev;
 	struct pci_controller *hose = dev->sysdata;
 	unsigned long alignto;
 	resource_size_t start = res->start;
diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index ac0e890510da..3e61826f07fb 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -564,7 +564,8 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
 				       resource_size_t size,
 				       resource_size_t align)
 {
-	struct pci_dev *dev = data;
+	struct pci_resreq_data *rr = data;
+	struct pci_dev *dev = rr->dev;
 	resource_size_t start = res->start;
 	struct pci_host_bridge *host_bridge;
 
@@ -578,7 +579,7 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
 				start, size, align);
 
 	if (res->flags & IORESOURCE_MEM)
-		return pci_align_resource(dev, res, empty_res, size, align);
+		return pci_align_resource(rr, res, empty_res, size, align);
 
 	return start;
 }
diff --git a/arch/m68k/kernel/pcibios.c b/arch/m68k/kernel/pcibios.c
index 7a9e60df79c5..3024408412bc 100644
--- a/arch/m68k/kernel/pcibios.c
+++ b/arch/m68k/kernel/pcibios.c
@@ -31,14 +31,14 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
 				       resource_size_t size,
 				       resource_size_t align)
 {
-	struct pci_dev *dev = data;
+	struct pci_resreq_data *rr = data;
 	resource_size_t start = res->start;
 
 	if ((res->flags & IORESOURCE_IO) && (start & 0x300))
 		start = (start + 0x3ff) & ~0x3ff;
 
 	if (res->flags & IORESOURCE_MEM)
-		return pci_align_resource(dev, res, empty_res, size, align);
+		return pci_align_resource(rr, res, empty_res, size, align);
 
 	return start;
 }
diff --git a/arch/mips/pci/pci-generic.c b/arch/mips/pci/pci-generic.c
index c2e23d0c1d77..7f3ecb91b85b 100644
--- a/arch/mips/pci/pci-generic.c
+++ b/arch/mips/pci/pci-generic.c
@@ -25,7 +25,8 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
 				       const struct resource *empty_res,
 				       resource_size_t size, resource_size_t align)
 {
-	struct pci_dev *dev = data;
+	struct pci_resreq_data *rr = data;
+	struct pci_dev *dev = rr->dev;
 	resource_size_t start = res->start;
 	struct pci_host_bridge *host_bridge;
 
@@ -39,7 +40,7 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
 				start, size, align);
 
 	if (res->flags & IORESOURCE_MEM)
-		return pci_align_resource(dev, res, empty_res, size, align);
+		return pci_align_resource(rr, res, empty_res, size, align);
 
 	return start;
 }
diff --git a/arch/mips/pci/pci-legacy.c b/arch/mips/pci/pci-legacy.c
index dae6dafdd6e0..82d4b01db64e 100644
--- a/arch/mips/pci/pci-legacy.c
+++ b/arch/mips/pci/pci-legacy.c
@@ -55,7 +55,8 @@ pcibios_align_resource(void *data, const struct resource *res,
 		       const struct resource *empty_res,
 		       resource_size_t size, resource_size_t align)
 {
-	struct pci_dev *dev = data;
+	struct pci_resreq_data *rr = data;
+	struct pci_dev *dev = rr->dev;
 	struct pci_controller *hose = dev->sysdata;
 	resource_size_t start = res->start;
 
@@ -70,7 +71,7 @@ pcibios_align_resource(void *data, const struct resource *res,
 		if (start & 0x300)
 			start = (start + 0x3ff) & ~0x3ff;
 	} else if (res->flags & IORESOURCE_MEM) {
-		start = pci_align_resource(dev, res, empty_res, size, align);
+		start = pci_align_resource(rr, res, empty_res, size, align);
 
 		/* Make sure we start at our min on all hoses */
 		if (start < PCIBIOS_MIN_MEM + hose->mem_resource->start)
diff --git a/arch/parisc/kernel/pci.c b/arch/parisc/kernel/pci.c
index 96950fe9c2b7..36a3a439f609 100644
--- a/arch/parisc/kernel/pci.c
+++ b/arch/parisc/kernel/pci.c
@@ -193,7 +193,8 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
 				       resource_size_t size,
 				       resource_size_t alignment)
 {
-	struct pci_dev *dev = data;
+	struct pci_resreq_data *rr = data;
+	struct pci_dev *dev = rr->dev;
 	resource_size_t align, start = res->start;
 
 	pci_dbg(dev, "%pR: pcibios_align_resource(%lx, 0x%llx, 0x%llx)\n",
@@ -205,7 +206,7 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
 	if (align > alignment)
 		start = ALIGN(start, align);
 	else
-		start = pci_align_resource(dev, res, empty_res, size, alignment);
+		start = pci_align_resource(rr, res, empty_res, size, alignment);
 
 	return start;
 }
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 4fc52c21fe5d..23594759cfe2 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -1131,7 +1131,8 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
 				       resource_size_t size,
 				       resource_size_t align)
 {
-	struct pci_dev *dev = data;
+	struct pci_resreq_data *rr = data;
+	struct pci_dev *dev = rr->dev;
 	resource_size_t start = res->start;
 
 	if (res->flags & IORESOURCE_IO) {
@@ -1140,7 +1141,7 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
 		if (start & 0x300)
 			start = (start + 0x3ff) & ~0x3ff;
 	} else if (res->flags & IORESOURCE_MEM) {
-		start = pci_align_resource(dev, res, empty_res, size, align);
+		start = pci_align_resource(rr, res, empty_res, size, align);
 	}
 
 	return start;
diff --git a/arch/sh/drivers/pci/pci.c b/arch/sh/drivers/pci/pci.c
index 878a27a1acfb..279f2770ff4b 100644
--- a/arch/sh/drivers/pci/pci.c
+++ b/arch/sh/drivers/pci/pci.c
@@ -172,7 +172,8 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
 				       resource_size_t size,
 				       resource_size_t align)
 {
-	struct pci_dev *dev = data;
+	struct pci_resreq_data *rr = data;
+	struct pci_dev *dev = rr->dev;
 	struct pci_channel *hose = dev->sysdata;
 	resource_size_t start = res->start;
 
@@ -186,7 +187,7 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
 		if (start & 0x300)
 			start = (start + 0x3ff) & ~0x3ff;
 	} else if (res->flags & IORESOURCE_MEM) {
-		start = pci_align_resource(dev, res, empty_res, size, align);
+		start = pci_align_resource(rr, res, empty_res, size, align);
 	}
 
 	return start;
diff --git a/arch/x86/pci/i386.c b/arch/x86/pci/i386.c
index e2de26b82940..4178ae4380c2 100644
--- a/arch/x86/pci/i386.c
+++ b/arch/x86/pci/i386.c
@@ -156,7 +156,8 @@ pcibios_align_resource(void *data, const struct resource *res,
 		       const struct resource *empty_res,
 		       resource_size_t size, resource_size_t align)
 {
-	struct pci_dev *dev = data;
+	struct pci_resreq_data *rr = data;
+	struct pci_dev *dev = rr->dev;
 	resource_size_t start = res->start;
 
 	if (res->flags & IORESOURCE_IO) {
@@ -165,7 +166,7 @@ pcibios_align_resource(void *data, const struct resource *res,
 		if (start & 0x300)
 			start = (start + 0x3ff) & ~0x3ff;
 	} else if (res->flags & IORESOURCE_MEM) {
-		start = pci_align_resource(dev, res, empty_res, size, align);
+		start = pci_align_resource(rr, res, empty_res, size, align);
 
 		/* The low 1MB range is reserved for ISA cards */
 		if (start < BIOS_END)
diff --git a/arch/xtensa/kernel/pci.c b/arch/xtensa/kernel/pci.c
index 305031551136..4e8ad4a3c9fe 100644
--- a/arch/xtensa/kernel/pci.c
+++ b/arch/xtensa/kernel/pci.c
@@ -42,7 +42,8 @@ pcibios_align_resource(void *data, const struct resource *res,
 		       const struct resource *empty_res,
 		       resource_size_t size, resource_size_t align)
 {
-	struct pci_dev *dev = data;
+	struct pci_resreq_data *rr = data;
+	struct pci_dev *dev = rr->dev;
 	resource_size_t start = res->start;
 
 	if (res->flags & IORESOURCE_IO) {
@@ -55,7 +56,7 @@ pcibios_align_resource(void *data, const struct resource *res,
 		if (start & 0x300)
 			start = (start + 0x3ff) & ~0x3ff;
 	} else if (res->flags & IORESOURCE_MEM) {
-		start = pci_align_resource(dev, res, empty_res, size, align);
+		start = pci_align_resource(rr, res, empty_res, size, align);
 	}
 
 	return start;
diff --git a/drivers/char/agp/intel-gtt.c b/drivers/char/agp/intel-gtt.c
index bcc26785175d..06990fad8e48 100644
--- a/drivers/char/agp/intel-gtt.c
+++ b/drivers/char/agp/intel-gtt.c
@@ -1038,10 +1038,13 @@ static struct agp_memory *intel_fake_agp_alloc_by_type(size_t pg_count,
 
 static int intel_alloc_chipset_flush_resource(void)
 {
+	struct pci_resreq_data rr;
 	int ret;
+
+	pci_init_resreq_data(&rr, intel_private.bridge_dev);
 	ret = pci_bus_alloc_resource(intel_private.bridge_dev->bus, &intel_private.ifp_resource, PAGE_SIZE,
 				     PAGE_SIZE, PCIBIOS_MIN_MEM, 0,
-				     pcibios_align_resource, intel_private.bridge_dev);
+				     pcibios_align_resource, &rr);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/i915/i915_gmch.c b/drivers/gpu/drm/i915/i915_gmch.c
index b0ef6ef577a3..f11ed5509095 100644
--- a/drivers/gpu/drm/i915/i915_gmch.c
+++ b/drivers/gpu/drm/i915/i915_gmch.c
@@ -38,6 +38,7 @@ static int mchbar_reg(struct drm_i915_private *i915)
 static int
 intel_alloc_mchbar_resource(struct drm_i915_private *i915)
 {
+	struct pci_resreq_data rr;
 	u32 temp_lo, temp_hi = 0;
 	u64 mchbar_addr;
 	int ret;
@@ -55,12 +56,12 @@ intel_alloc_mchbar_resource(struct drm_i915_private *i915)
 	/* Get some space for it */
 	i915->gmch.mch_res.name = "i915 MCHBAR";
 	i915->gmch.mch_res.flags = IORESOURCE_MEM;
+	pci_init_resreq_data(&rr, i915->gmch.pdev);
 	ret = pci_bus_alloc_resource(i915->gmch.pdev->bus,
 				     &i915->gmch.mch_res,
 				     MCHBAR_SIZE, MCHBAR_SIZE,
 				     PCIBIOS_MIN_MEM,
-				     0, pcibios_align_resource,
-				     i915->gmch.pdev);
+				     0, pcibios_align_resource, &rr);
 	if (ret) {
 		drm_dbg(&i915->drm, "failed bus alloc: %d\n", ret);
 		i915->gmch.mch_res.start = 0;
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 7c6f2aba8144..8c40f86d75ee 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6507,8 +6507,8 @@ static DEFINE_SPINLOCK(resource_alignment_lock);
  * RETURNS: Resource alignment if it is specified.
  *          Zero if it is not specified.
  */
-static resource_size_t pci_specified_resource_alignment(struct pci_dev *dev,
-							bool *resize)
+resource_size_t pci_specified_resource_alignment(struct pci_dev *dev,
+						 bool *resize)
 {
 	int align_order, count;
 	resource_size_t align = pcibios_default_alignment();
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 77efa4c5c960..e6e2afcceb33 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -515,6 +515,8 @@ void devm_pci_alloc_host_bridge_release(void *data);
 struct device *pci_get_host_bridge_device(struct pci_dev *dev);
 void pci_put_host_bridge_device(struct device *dev);
 
+resource_size_t pci_specified_resource_alignment(struct pci_dev *dev,
+						 bool *resize);
 void pci_resize_resource_set_size(struct pci_dev *dev, int resno, int size);
 int pci_do_resource_release_and_resize(struct pci_dev *dev, int resno, int size,
 				       int exclude_bars);
diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index 376f09630a4a..9c55b9f9462c 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -248,6 +248,20 @@ static int pci_revert_fw_address(struct resource *res, struct pci_dev *dev,
 	return 0;
 }
 
+/*
+ * TODO: Improve PCI resource assignment interface so that callers outside PCI
+ * core do not need to know about this detail.
+ */
+void pci_init_resreq_data(struct pci_resreq_data *rr, struct pci_dev *dev)
+{
+	bool dummy;
+
+	memset(rr, 0, sizeof(*rr));
+	rr->dev = dev;
+	rr->min_align = pci_specified_resource_alignment(dev, &dummy);
+}
+EXPORT_SYMBOL_GPL(pci_init_resreq_data);
+
 resource_size_t pci_resource_alignment(const struct pci_dev *dev,
 				       const struct resource *res)
 {
@@ -265,17 +279,21 @@ resource_size_t pci_resource_alignment(const struct pci_dev *dev,
  * before res->start if there's enough free space there. This enables
  * tighter packing for resources.
  */
-resource_size_t pci_align_resource(struct pci_dev *dev,
+resource_size_t pci_align_resource(struct pci_resreq_data *rr,
 				   const struct resource *res,
 				   const struct resource *empty_res,
 				   resource_size_t size,
 				   resource_size_t align)
 {
+	struct pci_dev *dev = rr->dev;
 	resource_size_t remainder, start_addr;
 
 	if (!(res->flags & IORESOURCE_MEM))
 		return res->start;
 
+	if (rr->min_align)
+		return res->start;
+
 	if (IS_ALIGNED(size, align))
 		return res->start;
 
@@ -306,18 +324,21 @@ resource_size_t __weak pcibios_align_resource(void *data,
 					      resource_size_t size,
 					      resource_size_t align)
 {
-	struct pci_dev *dev = data;
+	struct pci_resreq_data *rr = data;
 
-	return pci_align_resource(dev, res, empty_res, size, align);
+	return pci_align_resource(rr, res, empty_res, size, align);
 }
 
 static int __pci_assign_resource(struct pci_bus *bus, struct pci_dev *dev,
 		int resno, resource_size_t size, resource_size_t align)
 {
 	struct resource *res = pci_resource_n(dev, resno);
+	struct pci_resreq_data rr;
 	resource_size_t min;
 	int ret;
 
+	pci_init_resreq_data(&rr, dev);
+
 	min = (res->flags & IORESOURCE_IO) ? PCIBIOS_MIN_IO : PCIBIOS_MIN_MEM;
 
 	/*
@@ -329,7 +350,7 @@ static int __pci_assign_resource(struct pci_bus *bus, struct pci_dev *dev,
 	 */
 	ret = pci_bus_alloc_resource(bus, res, size, align, min,
 				     IORESOURCE_PREFETCH | IORESOURCE_MEM_64,
-				     pcibios_align_resource, dev);
+				     pcibios_align_resource, &rr);
 	if (ret == 0)
 		return 0;
 
@@ -341,7 +362,7 @@ static int __pci_assign_resource(struct pci_bus *bus, struct pci_dev *dev,
 	     (IORESOURCE_PREFETCH | IORESOURCE_MEM_64)) {
 		ret = pci_bus_alloc_resource(bus, res, size, align, min,
 					     IORESOURCE_PREFETCH,
-					     pcibios_align_resource, dev);
+					     pcibios_align_resource, &rr);
 		if (ret == 0)
 			return 0;
 	}
@@ -354,7 +375,7 @@ static int __pci_assign_resource(struct pci_bus *bus, struct pci_dev *dev,
 	 */
 	if (res->flags & (IORESOURCE_PREFETCH | IORESOURCE_MEM_64))
 		ret = pci_bus_alloc_resource(bus, res, size, align, min, 0,
-					     pcibios_align_resource, dev);
+					     pcibios_align_resource, &rr);
 
 	return ret;
 }
diff --git a/include/linux/pci.h b/include/linux/pci.h
index aa3765a20a96..c945f5753e7c 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1221,12 +1221,23 @@ int __must_check pcibios_enable_device(struct pci_dev *, int mask);
 /* Architecture-specific versions may override this (weak) */
 char *pcibios_setup(char *str);
 
-/* Used only when drivers/pci/setup.c is used */
+/**
+ * struct pci_resreq_data - Data passed to pcibios_align_resource()
+ * @dev: PCI device
+ * @min_align: Minimum alignment bound (from pci=resource_alignment or arch)
+ */
+struct pci_resreq_data {
+	struct pci_dev *dev;
+	resource_size_t min_align;
+};
+
+void pci_init_resreq_data(struct pci_resreq_data *rr, struct pci_dev *dev);
+
 resource_size_t pcibios_align_resource(void *data, const struct resource *res,
 				       const struct resource *empty_res,
 				       resource_size_t size,
 				       resource_size_t align);
-resource_size_t pci_align_resource(struct pci_dev *dev,
+resource_size_t pci_align_resource(struct pci_resreq_data *rr,
 				   const struct resource *res,
 				   const struct resource *empty_res,
 				   resource_size_t size,
-- 
2.47.3


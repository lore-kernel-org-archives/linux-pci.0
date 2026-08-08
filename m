Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C852838886B;
	Sat,  8 Aug 2026 17:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786209810; cv=none; b=btR/RWOpfzzklg/6TJS7+qzqifdKuKfHwiYhDtjTOQkWt/KsGeqbRVGNOwGT7I8BNrdSyseRt0JeNBZAz5sEMoUoNh/DhXJrzC3Q7paagG+3OANdNXmf+gJHdfMf/dwsh3IlfiEKeEJOMzQ8VIwHFSjYMx1q3chcLDU5URKOoVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786209810; c=relaxed/simple;
	bh=9OpaR2ckBZXsvul8369uSCurJD7EwbXqiDo9rO/qpqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RbBfGeivJYm1uJ75FgGGuDHcBP2FemyITvVFvykPDt3RFlGEPg1gbZedxuyZozblcuyaYqZ6l6Y6DONg/9xss4r1aEqiiqvThz1ju1QBU2Jq3EbuHiXks/lZeZBwEbmZV//1sKjMsmd277OeO4RjqhoW1IieirOFBhJ2pxw4lIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jcKYkOh3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jcKYkOh3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 617AA1F000E9;
	Sat,  8 Aug 2026 17:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786209807;
	bh=PQ6ooHZ0Khu8tEZ6nW9lPnqMSnhrOYZdbSDHSYNbj98=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jcKYkOh3/D37o7ep2Fo7xjJJEwFhpPwGCDWoTqflnyVgY1qu2f4mu47PBl9UG8QEV
	 LGrqEfuqnysv7UEbqHFGdOX5eLyc0PvbEvnmCyiNVJmgDAYgBduhMUmHulwpW7n8Kb
	 r609JcfQraNCO6kqyRoBiS+aAu2qn9JuDWucEv+gLUMb2kvjVnMJLLGBUUvq3YpYAR
	 QOcjq5Ewjs6MC4PwB2ZFiBUK4A5tnOGwWC3N2N6Fc4DNsgqg2e/IR6/NIoQ+XYlWqa
	 qpxhavOiabarSb0jJeKrR2cXBNPfa04yrp7jyEzKovjvZ5JyOuvncE99dgmFzTqkMR
	 erXXZE0Jk4tzw==
From: Bjorn Helgaas <helgaas@kernel.org>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v1 2/2] PCI: Include human-readable sizes in resource assignment messages
Date: Sat,  8 Aug 2026 12:23:08 -0500
Message-ID: <20260808172308.282591-3-bhelgaas@google.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260808172308.282591-1-bhelgaas@google.com>
References: <20260808172308.282591-1-bhelgaas@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Include human-readable sizes, e.g., "16.0 MiB", in addition to the hex
"0x1000000" size, in resource-related messages.  Also consistently include
the "0x" prefix.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/setup-bus.c | 46 +++++++++++++++++++++++++++++------------
 drivers/pci/setup-res.c | 11 ++++++----
 2 files changed, 40 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index c0a949f2c995..4f62ba6f4d7f 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -28,6 +28,7 @@
 #include <linux/limits.h>
 #include <linux/sizes.h>
 #include <linux/slab.h>
+#include <linux/string_helpers.h>
 #include <linux/acpi.h>
 #include "pci.h"
 
@@ -427,6 +428,7 @@ static void reassign_resources_sorted(struct list_head *realloc_head,
 	struct resource *res;
 	const char *res_name;
 	resource_size_t add_size, align;
+	char size_buf[32];
 	int idx;
 
 	list_for_each_entry_safe(add_res, tmp, realloc_head, list) {
@@ -460,10 +462,14 @@ static void reassign_resources_sorted(struct list_head *realloc_head,
 		} else if (add_size > 0 || !IS_ALIGNED(res->start, align)) {
 			res->flags |= add_res->flags &
 				 (IORESOURCE_STARTALIGN|IORESOURCE_SIZEALIGN);
-			if (pci_reassign_resource(dev, idx, add_size, align))
-				pci_info(dev, "%s %pR: failed to add optional %llx\n",
+			if (pci_reassign_resource(dev, idx, add_size, align)) {
+				string_get_size(add_size, 1, STRING_UNITS_2,
+                                        size_buf, sizeof(size_buf));
+				pci_info(dev, "%s %pR: failed to add optional %#llx (%s)\n",
 					 res_name, res,
-					 (unsigned long long) add_size);
+					 (unsigned long long) add_size,
+					 size_buf);
+			}
 		}
 out:
 		list_del(&add_res->list);
@@ -1076,6 +1082,7 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t add_size,
 	resource_size_t size = 0, size0 = 0, size1 = 0;
 	resource_size_t children_add_size = 0;
 	resource_size_t min_align, align;
+	char size_buf[32];
 
 	if (!b_res)
 		return;
@@ -1138,11 +1145,14 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t add_size,
 	b_res->flags |= IORESOURCE_STARTALIGN;
 	if (bus->self && size1 > size0 && realloc_head) {
 		b_res->flags &= ~IORESOURCE_DISABLED;
+		add_size = size1 - size0;
 		pci_dev_res_add_to_list(realloc_head, bus->self, b_res,
-					size1 - size0, min_align);
-		pci_info(bus->self, "bridge window %pR to %pR add_size %llx\n",
+					add_size, min_align);
+		string_get_size(add_size, 1, STRING_UNITS_2,
+                                size_buf, sizeof(size_buf));
+		pci_info(bus->self, "bridge window %pR to %pR add_size %#llx (%s)\n",
 			 b_res, &bus->busn_res,
-			 (unsigned long long) size1 - size0);
+			 (unsigned long long) add_size, size_buf);
 	}
 }
 
@@ -1284,6 +1294,7 @@ static void pbus_size_mem(struct pci_bus *bus, struct resource *b_res,
 	resource_size_t aligns[28] = {}; /* Alignments from 1MB to 128TB */
 	int order, max_order;
 	resource_size_t children_add_size = 0;
+	char size_buf[32], align_buf[32];
 	resource_size_t add_align = 0;
 
 	if (!b_res)
@@ -1378,10 +1389,14 @@ static void pbus_size_mem(struct pci_bus *bus, struct resource *b_res,
 		add_size = size1 > size0 ? size1 - size0 : 0;
 		pci_dev_res_add_to_list(realloc_head, bus->self, b_res,
 					add_size, add_align);
-		pci_info(bus->self, "bridge window %pR to %pR add_size %llx add_align %llx\n",
+		string_get_size(add_size, 1, STRING_UNITS_2, size_buf,
+				sizeof(size_buf));
+		string_get_size(add_align, 1, STRING_UNITS_2, align_buf,
+				sizeof(align_buf));
+		pci_info(bus->self, "bridge window %pR to %pR add_size %#llx (%s) add_align %#llx (%s)\n",
 			   b_res, &bus->busn_res,
-			   (unsigned long long) add_size,
-			   (unsigned long long) add_align);
+			   (unsigned long long) add_size, size_buf,
+			   (unsigned long long) add_align, align_buf);
 	}
 }
 
@@ -1857,6 +1872,7 @@ static void adjust_bridge_window(struct pci_dev *bridge, struct resource *res,
 {
 	resource_size_t add_size, size = resource_size(res);
 	struct pci_dev_resource *dev_res;
+	char size_buf[32];
 
 	if (resource_assigned(res))
 		return;
@@ -1866,8 +1882,10 @@ static void adjust_bridge_window(struct pci_dev *bridge, struct resource *res,
 
 	if (new_size > size) {
 		add_size = new_size - size;
-		pci_dbg(bridge, "bridge window %pR extended by %pa\n", res,
-			&add_size);
+		string_get_size(add_size, 1, STRING_UNITS_2,
+				size_buf, sizeof(size_buf));
+		pci_dbg(bridge, "bridge window %pR extended by %pa (%s)\n", res,
+			&add_size, size_buf);
 	} else if (new_size < size) {
 		int idx = pci_resource_num(bridge, res);
 
@@ -1900,8 +1918,10 @@ static void adjust_bridge_window(struct pci_dev *bridge, struct resource *res,
 		add_size = size - new_size;
 		if (add_size < dev_res->add_size) {
 			dev_res->add_size -= add_size;
-			pci_dbg(bridge, "bridge window %pR optional size shrunken by %pa\n",
-				res, &add_size);
+			string_get_size(add_size, 1, STRING_UNITS_2,
+					size_buf, sizeof(size_buf));
+			pci_dbg(bridge, "bridge window %pR optional size shrunken by %pa (%s)\n",
+				res, &add_size, size_buf);
 		} else {
 			pci_dbg(bridge, "bridge window %pR optional size removed\n",
 				res);
diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index 376f09630a4a..707c405000b8 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -20,6 +20,7 @@
 #include <linux/ioport.h>
 #include <linux/cache.h>
 #include <linux/slab.h>
+#include <linux/string_helpers.h>
 #include "pci.h"
 
 static void pci_std_update_resource(struct pci_dev *dev, int resno)
@@ -431,6 +432,7 @@ int pci_reassign_resource(struct pci_dev *dev, int resno,
 	const char *res_name = pci_resource_name(dev, resno);
 	unsigned long flags;
 	resource_size_t new_size;
+	char size_buf[32];
 	int ret;
 
 	if (res->flags & IORESOURCE_PCI_FIXED)
@@ -444,19 +446,20 @@ int pci_reassign_resource(struct pci_dev *dev, int resno,
 		return -EINVAL;
 	}
 
+	string_get_size(addsize, 1, STRING_UNITS_2, size_buf, sizeof(size_buf));
 	new_size = resource_size(res) + addsize;
 	ret = _pci_assign_resource(dev, resno, new_size, min_align);
 	if (ret) {
 		res->flags = flags;
-		pci_info(dev, "%s %pR: failed to expand by %#llx\n",
-			 res_name, res, (unsigned long long) addsize);
+		pci_info(dev, "%s %pR: failed to expand by %#llx (%s)\n",
+			 res_name, res, (unsigned long long) addsize, size_buf);
 		return ret;
 	}
 
 	res->flags &= ~IORESOURCE_UNSET;
 	res->flags &= ~IORESOURCE_STARTALIGN;
-	pci_info(dev, "%s %pR: reassigned; expanded by %#llx\n",
-		 res_name, res, (unsigned long long) addsize);
+	pci_info(dev, "%s %pR: reassigned; expanded by %#llx (%s)\n",
+		 res_name, res, (unsigned long long) addsize, size_buf);
 	if (resno < PCI_BRIDGE_RESOURCES)
 		pci_update_resource(dev, resno);
 
-- 
2.53.0


Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE79E344DAB
	for <linux-pci@vger.kernel.org>; Tue, 28 Apr 2026 22:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777416943; cv=none; b=SCfrhSmcp6Dqq0D230XHZZJvGbBCIgp36eYgxOp9b39dmp9FK8OflObIWFk8ycQJpDeq1SbW/CB1AZxdWcdUZzFXwvbosjSd3pfhm1RFD25dLwxVrqIenXW4cQNiIBnv105/GaIRS4tdGgkYxmwL/vTEB0fXVQY+liWMlfht4NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777416943; c=relaxed/simple;
	bh=w92j1+KGo6D2kBLTSJDqU4ABcn9vG3xGdTKg2rNKn1s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ps5uqJSZxTJ3wcase9g607Yhzt4+9rdza+EzTpKieSHFpiDw47FhjKe8tMnQwGzovpA9O642EFSMyjC5IP6fwwIZ6B6haitzkhbiZILZHCIU+Mt3hXMpJOL6KooKQwDccWd67WAEQDYDSwCSVq533L2a+H9YrcyPGM8yoaudJG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jqluv.com; spf=none smtp.mailfrom=jqluv.com; dkim=pass (2048-bit key) header.d=jqluv-com.20251104.gappssmtp.com header.i=@jqluv-com.20251104.gappssmtp.com header.b=oNF26PNT; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jqluv.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jqluv.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jqluv-com.20251104.gappssmtp.com header.i=@jqluv-com.20251104.gappssmtp.com header.b="oNF26PNT"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2a871daa98fso78233595ad.1
        for <linux-pci@vger.kernel.org>; Tue, 28 Apr 2026 15:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jqluv-com.20251104.gappssmtp.com; s=20251104; t=1777416941; x=1778021741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SXh1sIdWXyFAkS1VJdBRbGA0VRROpFm5fAuvzlWqXxk=;
        b=oNF26PNTJ3480BvVU+dlzEHLF6/6disZ9nACXdtQsMMCua2YpwkN0NLWPcsvyns5uj
         5FrPrAU3xktZBtAaGH3/eMAKrPNinzwkSSvxHJmz9OP4uUsF1ZSCOpxLCm32bFMbkWKj
         GWOR6E4gaoCZRc3V8KjaHFJQybrdw7+EtmL9JGfmCo2s8D+56iPeQoWaceSbCK0EeVdl
         +PBo14Lxh84ZANg+6FCJMoeh8XzAtcoHHjWhaSceTUfxvteGyK2Wzf/Z/vIjeaggz8Oj
         glhMs6UTmf9tLP5vzGMoEaUYJFvRaBO1JYgSnXGdTpXN06EaCrqxjfdp9zVhm4ah2P8a
         13TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777416941; x=1778021741;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SXh1sIdWXyFAkS1VJdBRbGA0VRROpFm5fAuvzlWqXxk=;
        b=Vqk9W72zf8MmsJQIw+Xck+8AHOvp3eR2JQ4vqYm1oyzOaI4cnBa48604o9Z6m2LDKQ
         l6IoV7qfEutzsSeAXq6pErGPW1flxUOIUeM5jTaL0q99qSvci5T9Enp7AqzXHJzJY2gU
         H8S7JAwG2Dr3j5KyQJAkeFrnAsup37DiYHPOh1qvXar95KKSPZoZFFNcTtJEi9os3MlJ
         cH2XeQ5jvNR3Y3FWaryutelKLykStoyfF6furTaI8oUx1brwSx8C1264KIMGUVHmkLh7
         u+B4+UOCTvfUWx/iKVBYVH/PXL0pAlm7wUqU3ZEU89AEZDSXxdm8vO41dd4joeuqCOcX
         J9Nw==
X-Forwarded-Encrypted: i=1; AFNElJ9vYBJZJBvO85TzkkmYvsPJYBbrwJnEem9Q/LtmdX2eZ1AmXa/jlURHVikWW0KyMG2tTM5BbpYcPU0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy99JaWgQzSVRQk9qUUMHsDdDM9XWzSKNHAXVQ20E5nDqL8reUV
	GPQlAZ+F3CTM9gaQFfVGwMDjuys+LpMWrHK6GVKzVY8axujzMGVps4ez4mPYQkC4VMc=
X-Gm-Gg: AeBDievbgLQKhr2d/4/XPROEl+sfMp9N4B08hkgA+1OiF4zFvE6lfg3/ffvlLdbZcHA
	6gkICcGUhRTJKMEobvC9GHGb4R4BPrW6bYfQyd3cS5icvuRMBKdtHXGQD5IReTfSeApAFoMSLaa
	eAJeHbduYWftJPQLliSfjIInxiopORd6cvlmoMKScCUnBi9C/+vBL5Tub3UrpgU4QAwn+ud80x0
	bdliXAtKbABj9ektbq6ULle5+oRsU3LRXVEMX67ClL3jKDDVnz/+fcRfRLhCWW7ubealXQYYn/b
	neYVfdgJRB+CNkAguFsQ/HKTqWUEp9YXl0LHJfvsp36HVivlyhIYzjXI8pOPtQyFWBSaXucSroQ
	zlph3FVS2dcel806KxvV7ol+5acGDU5Q1qr/Utqz+03B3U/5x97lvYJc+a7elFDa2OgCTack1SO
	9xMFJGM8i8B1qnj0bsMw8oR9kXYFYchKXU9Jnp6K8oX0iUrHU=
X-Received: by 2002:a17:903:2411:b0:2b0:67a7:5c4b with SMTP id d9443c01a7336-2b97c47b4c3mr50187205ad.28.1777416941276;
        Tue, 28 Apr 2026 15:55:41 -0700 (PDT)
Received: from geramyl-MS-S1-MAX.. ([2601:201:8080:e5c0:4857:38db:7c94:21e1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b98898ff65sm2518875ad.78.2026.04.28.15.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 15:55:40 -0700 (PDT)
From: Geramy Loveless <gloveless@jqluv.com>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Cristian Cocos <cristi@ieee.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	linux-pci@vger.kernel.org,
	Geramy Loveless <gloveless@jqluv.com>
Subject: [PATCH v3 RESEND] PCI: release empty sibling bridge windows during window resize
Date: Tue, 28 Apr 2026 15:55:32 -0700
Message-ID: <20260428225532.3108047-1-gloveless@jqluv.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

pbus_reassign_bridge_resources() refuses to release bridge windows that
have child resources. On multi-port PCIe switches (e.g. Thunderbolt
docks), empty sibling downstream ports hold small reservations that
prevent the parent window from being freed and re-sized for rebar.

Walk descendants of the target window depth-first, saving and freeing
each empty bridge window so the parent can then be released and grown.

Without this change, attempts to grow a window deep below a switch
fabric leave nested empty windows pinning the ancestor:

  pcieport 0000:65:00.0: bridge window [mem 0x8880000000-0x98800fffff
    64bit pref]: not released, active children present
  pcieport 0000:00:03.2: bridge window [mem 0x8880000000-0x98800fffff
    64bit pref]: not released, active children present

With the bottom-up walk and upstream ancestry check, the chain unwinds
and the rebar succeeds:

  pcieport 0000:96:00.0: bridge window [...]: releasing
  pcieport 0000:95:00.0: bridge window [...]: releasing
  pcieport 0000:94:00.0: bridge window [...]: releasing
  pcieport 0000:65:00.0: bridge window [...]: releasing
  amdgpu 0000:97:00.0: BAR 0 [mem 0x9000000000-0x97ffffffff 64bit pref]:
    assigned

Suggested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Geramy Loveless <gloveless@jqluv.com>
---
RESEND: my earlier v3 (Message-ID 20260428225146.3104063-1-gloveless@jqluv.com)
was sent with stale code — the diff was byte-identical to v2 because the
v3 edits weren't staged before commit --amend. This resend contains the
actual v3 content described below. Apologies for the noise.

v3:
 - Restructure helper: outer loop only recurses; inner iterates bus
   resources via pci_bus_for_each_resource(). The release path is now
   unified, so the caller-side block in pbus_reassign_bridge_resources()
   is gone.
 - Walk the resource tree upstream when checking ancestry of @b_win,
   so descendants in nested topologies are also released (Ilpo).
 - Drop pci_resource_is_bridge_win() filter; bus resources are
   inherently bridge windows.
 - Rename pci_bus_release_empty_bridge_resources() to
   pbus_release_empty_bridge_resources().
 - Drop misleading "Uses PCI bus/device iterators..." paragraph from
   commit message.
 - Kerneldoc tweaks per Ilpo's review.

v2:
 - Use PCI bus/device iterators instead of walking raw resource tree.
 - Save released resources to rollback list.
 - Filter via pci_resource_is_bridge_win() (now removed in v3).
 - Call release before the !res->child check.
 - Check bridge->subordinate before recursion.
---
 drivers/pci/setup-bus.c | 78 ++++++++++++++++++++++++++++++++---------
 1 file changed, 61 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 4cf120ebe5a..b47dc1a2925 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -2292,6 +2292,63 @@ void pci_assign_unassigned_bridge_resources(struct pci_dev *bridge)
 }
 EXPORT_SYMBOL_GPL(pci_assign_unassigned_bridge_resources);
 
+/*
+ * pbus_release_empty_bridge_resources - Bottom-up release of bridge windows
+ * in empty subtrees.
+ * @bus: PCI bus whose child bridges to process
+ * @b_win: Ancestor bridge window; only resources that are (grand)parented
+ *	   by @b_win are released
+ * @saved: List to store released resources into for rollback
+ *
+ * Recurses depth-first into subordinate buses, then releases bridge windows
+ * that are (grand)parented by @b_win on the way back up. Each resource is
+ * stored into @saved before release so the entire operation can be rolled
+ * back.
+ */
+static void pbus_release_empty_bridge_resources(struct pci_bus *bus,
+						struct resource *b_win,
+						struct list_head *saved)
+{
+	struct pci_dev *dev;
+	struct resource *r;
+	unsigned int i;
+
+	list_for_each_entry(dev, &bus->devices, bus_list) {
+		if (dev->subordinate)
+			pbus_release_empty_bridge_resources(dev->subordinate,
+							    b_win, saved);
+	}
+
+	pci_bus_for_each_resource(bus, r, i) {
+		struct resource *p;
+		unsigned int idx;
+
+		if (!r || !resource_assigned(r))
+			continue;
+
+		/* Walk upstream to confirm r descends from (or equals) b_win */
+		for (p = r; p && p != b_win; p = p->parent)
+			;
+		if (!p)
+			continue;
+
+		idx = pci_resource_num(bus->self, r);
+
+		if (r->child) {
+			const char *res_name = pci_resource_name(bus->self, idx);
+
+			pci_info(bus->self, "%s %pR: not released, active children present\n",
+				 res_name, r);
+			continue;
+		}
+
+		if (pci_dev_res_add_to_list(saved, bus->self, r, 0, 0))
+			continue;
+
+		pci_release_resource(bus->self, idx);
+	}
+}
+
 /*
  * Walk to the root bus, find the bridge window relevant for @res and
  * release it when possible. If the bridge window contains assigned
@@ -2305,7 +2362,6 @@ static int pbus_reassign_bridge_resources(struct pci_bus *bus, struct resource *
 	struct pci_dev *bridge = NULL;
 	LIST_HEAD(added);
 	LIST_HEAD(failed);
-	unsigned int i;
 	int ret = 0;
 
 	while (!pci_is_root_bus(bus)) {
@@ -2314,22 +2370,10 @@ static int pbus_reassign_bridge_resources(struct pci_bus *bus, struct resource *
 		if (!res)
 			break;
 
-		i = pci_resource_num(bridge, res);
-
-		/* Ignore BARs which are still in use */
-		if (!res->child) {
-			ret = pci_dev_res_add_to_list(saved, bridge, res, 0, 0);
-			if (ret)
-				return ret;
-
-			pci_release_resource(bridge, i);
-		} else {
-			const char *res_name = pci_resource_name(bridge, i);
-
-			pci_warn(bridge,
-				 "%s %pR: was not released (still contains assigned resources)\n",
-				 res_name, res);
-		}
+		/* Release this bridge window and any empty descendants bottom-up */
+		if (bridge->subordinate)
+			pbus_release_empty_bridge_resources(bridge->subordinate,
+							    res, saved);
 
 		bus = bus->parent;
 	}
-- 
2.43.0


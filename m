Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E60B2772D
	for <linux-pci@vger.kernel.org>; Tue, 28 Apr 2026 22:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777416720; cv=none; b=ebbXPVpMCoY2Z95CWIaEq/3w0s7QRHTp68K4zfgh2dq++3vifZltIVZAvsbT//TmQZL0roBvgTq7BuxoR5Lgf3JV1TjKH3gPmSKbLT4M+BpziAWd31+3jw42zqchWyzn06qoSMP5S7iw9otXGOD9VbSqAv44LmxT8obOoDDljIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777416720; c=relaxed/simple;
	bh=EhAHeYRUZ1QV6wnUYX6Peu5JGPfj3YPRFCobZ1NqpLs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QHsfE0HCItIbD/Op/dkpCC0aoTuvUuf/KxNrfXDUSohCjAmqkSnSZiVMn/asyoHtpzLf8f7mpmsqwWEjdovi2TdZUp3LB93hipe4E9i1PxShq7SmKuDSLTNjVTvaJKcGE7Sei15LnGg2Mch3tD9fl9PBnJxdTIipYfkZBRNfSmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jqluv.com; spf=none smtp.mailfrom=jqluv.com; dkim=pass (2048-bit key) header.d=jqluv-com.20251104.gappssmtp.com header.i=@jqluv-com.20251104.gappssmtp.com header.b=ILj43TSE; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jqluv.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jqluv.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jqluv-com.20251104.gappssmtp.com header.i=@jqluv-com.20251104.gappssmtp.com header.b="ILj43TSE"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-35fb16e56efso7819796a91.2
        for <linux-pci@vger.kernel.org>; Tue, 28 Apr 2026 15:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jqluv-com.20251104.gappssmtp.com; s=20251104; t=1777416715; x=1778021515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GLJP6H6AkL9gb44VkGT2QFdVl/FUb87//pKbmPEt1ZM=;
        b=ILj43TSErOw8AcanOv+RXRFMhRLB7Wr3JoukLytc2yFB+4cQeriVqhDGqInAcRiLNL
         jPR3hGSjB6fiuuSVB2OyfvGEPq0dDw+GogZmTofQoRNAcU8kR/Ev4w7yF+84jb3UNWCZ
         UuFpMQ2SpDFl2LUk+hroYlCiVegcJX/vqA5uwdOyBdNP/MMPZmXJcRr5CeK9vhu52TGV
         FAzZjpm6fdoX77zxU8N8i1xL+GsNkBAZ6LkJ4aTklxCXidPTg4MNftBIvm6AxCkF8gE9
         faYGgw6JeO+qh+Fbwbk02q2TcIKIt0d69BV8zvPcQoJ1Ca7scmO56K7xEh+rICE0VGvk
         b/VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777416715; x=1778021515;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GLJP6H6AkL9gb44VkGT2QFdVl/FUb87//pKbmPEt1ZM=;
        b=hdkAP32ksQkx83m5BekwuoXOKWkg1CjM9CrRIWG6/IB7rRUGJsFhWhuZX8EmcbROPr
         M7MsKFgWjUCu34Acsf65tztCchdNqM9rjxjpHh93NfYLJt/qYWKib4erC4Eft8hXbZax
         Q3hdzq0KfRH463w8PY23B7m1sUMUWP4iOHzXjwLI3SOyJPCom1rhaHEx2vETQHtl9/tl
         fsXDVbdj+5zpbwGYqAcfO6XyXPYH6RSxpQ1BSQJ4leZHjF3fSDdFcI46Wbw72ofe+QWY
         VR84x5XdkfhSBoDja+M9lW2u6WN/VEua36XvjF7Yy4CVkCRpRS+TQ6D/+DdTYlNG2ErR
         tciA==
X-Forwarded-Encrypted: i=1; AFNElJ+b0TF4s6Hu9CNu8iijuY2xS/mqY65gb92pvUb+1Gvwi2DhGw8RrgfpiiVqfNVpVotbIztjbBXyQyU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZpK0j3Z2DCTJqUieq6DCprtFx9bgkaCiKLuxhuaUL31rsVEEh
	fGhVBvjEgnyiYSKIULHYyexXnOqKnU1q/UNy7QsU7+zcYfS5uhZ0XcbSVTX/NIirWV8=
X-Gm-Gg: AeBDieu3KVXzopLQ5/cpcOOnSo18p8MUVsA6JM/Bv+et7TQKY/Wvj9yFYM1BLGQkpvX
	nCtOEQdFluBr0FQl3KBPLh30NJBloxmYWYn5N5ockGL53Tc7wUWNjAG0qfNYE9hsrW69BsY0CnV
	FtVDeJi2iF9hDfBZZWV+ixt/gg91KNJh7MNhNWh4Ww8e1meuGRKil6n3pTNsT4c3wMQ5xBzuHJA
	E558H4CqMHoBzqQX2GoLPENVPcVBeEilccFF9/2DSMxzH+47m3Rrb3W0s2Ul6aHRgf6562XG1cm
	nMnqbUhuZCqNhEp2P9V1VosXF8lS10siz5tGDsSA3zd5nznZ5utGS5M9p/VPrnBLkrv5W/J/hAA
	TGyAZV/zYd0P4T4mzYowyNf9BLIcpIRpx9qOsJfyl9MWTouUsHyprSYT1yej/nbbXT9CN5G4Utq
	/ry2uwMTx1xc8ziJ2SrXIDIlw6DXPunRH2GoLIOcWPPqjfZ+s=
X-Received: by 2002:a17:90b:1c09:b0:35d:9efd:7956 with SMTP id 98e67ed59e1d1-364a0b40d40mr1241214a91.11.1777416714744;
        Tue, 28 Apr 2026 15:51:54 -0700 (PDT)
Received: from geramyl-MS-S1-MAX.. ([2601:201:8080:e5c0:4857:38db:7c94:21e1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364a25c11b9sm176000a91.0.2026.04.28.15.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 15:51:54 -0700 (PDT)
From: Geramy Loveless <gloveless@jqluv.com>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Cristian Cocos <cristi@ieee.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	linux-pci@vger.kernel.org,
	Geramy Loveless <gloveless@jqluv.com>
Subject: [PATCH v3] PCI: release empty sibling bridge windows during window resize
Date: Tue, 28 Apr 2026 15:51:46 -0700
Message-ID: <20260428225146.3104063-1-gloveless@jqluv.com>
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
 drivers/pci/setup-bus.c | 63 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 61 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 4cf120ebe5a..0c1fb654c9c 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -2292,6 +2292,60 @@ void pci_assign_unassigned_bridge_resources(struct pci_dev *bridge)
 }
 EXPORT_SYMBOL_GPL(pci_assign_unassigned_bridge_resources);
 
+/*
+ * pci_bus_release_empty_bridge_resources - Bottom-up release of bridge
+ * window resources in empty subtrees.
+ * @bus: PCI bus whose child bridges to process
+ * @b_win: Ancestor bridge window; only children of this resource are released
+ * @saved: List to save released resources for rollback
+ *
+ * Recurses depth-first into subordinate buses, then releases bridge windows
+ * on the way back up.  Each resource is individually saved before release so
+ * the entire operation can be rolled back.
+ */
+static void pci_bus_release_empty_bridge_resources(struct pci_bus *bus,
+						   struct resource *b_win,
+						   struct list_head *saved)
+{
+	struct pci_dev *dev;
+
+	list_for_each_entry(dev, &bus->devices, bus_list) {
+		struct resource *r;
+		unsigned int i;
+
+		if (!dev->subordinate)
+			continue;
+
+		/* Recurse first — release deepest resources before parents */
+		pci_bus_release_empty_bridge_resources(dev->subordinate,
+						      b_win, saved);
+
+		pci_dev_for_each_resource(dev, r, i) {
+			if (!pci_resource_is_bridge_win(i))
+				continue;
+
+			if (!resource_assigned(r))
+				continue;
+
+			if (r->parent != b_win)
+				continue;
+
+			if (r->child) {
+				const char *res_name = pci_resource_name(dev, i);
+
+				pci_info(dev, "%s %pR: not released, children still present\n",
+					 res_name, r);
+				continue;
+			}
+
+			if (pci_dev_res_add_to_list(saved, dev, r, 0, 0))
+				continue;
+
+			pci_release_resource(dev, i);
+		}
+	}
+}
+
 /*
  * Walk to the root bus, find the bridge window relevant for @res and
  * release it when possible. If the bridge window contains assigned
@@ -2316,7 +2370,12 @@ static int pbus_reassign_bridge_resources(struct pci_bus *bus, struct resource *
 
 		i = pci_resource_num(bridge, res);
 
-		/* Ignore BARs which are still in use */
+		/* Release empty sibling bridge windows bottom-up */
+		if (bridge->subordinate)
+			pci_bus_release_empty_bridge_resources(
+				bridge->subordinate, res, saved);
+
+		/* Ignore bridge windows which are still in use */
 		if (!res->child) {
 			ret = pci_dev_res_add_to_list(saved, bridge, res, 0, 0);
 			if (ret)
@@ -2327,7 +2386,7 @@ static int pbus_reassign_bridge_resources(struct pci_bus *bus, struct resource *
 			const char *res_name = pci_resource_name(bridge, i);
 
 			pci_warn(bridge,
-				 "%s %pR: was not released (still contains assigned resources)\n",
+				 "%s %pR: not released, active children present\n",
 				 res_name, res);
 		}
 
-- 
2.43.0


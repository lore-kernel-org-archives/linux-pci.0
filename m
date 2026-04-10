Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0903C20010A
	for <linux-pci@vger.kernel.org>; Fri, 10 Apr 2026 05:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775799056; cv=none; b=PcBvNhhfN2z5fk6BZw/C/uCuBCVVRhUWejNqpIYKe7zqq7x0EXoHVMtEMsVDzPzXUN0F/g66PBwvLjRm6E1QsydXTPwWfeS74uAI116c5owuegWu0pJ3D3x/1bvtPC5ROhq4+o0L4QBCgJGh6BuTOzVVazeYz0cldwNiJuaCl8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775799056; c=relaxed/simple;
	bh=XkuetcQHM3A7I1YGHrZfr42BJ3/QhNVvyt7EGlGJdmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h8so2aIbuhMVndUwLNbiNJ+LKcSwCykmta0il8AAUR2HnoWOhTbW7A4Z3ehz4DM8HylJessP4uUcIricl/A7MTzOlXGwBCWnLhnAwL+cqaD5PkQ/mQ+BUvPzUBZe7LkLzeszk670r41xk+p6iAB+8Vial9SsNsPUINHeRRfqFVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jqluv.com; spf=none smtp.mailfrom=jqluv.com; dkim=pass (2048-bit key) header.d=jqluv-com.20251104.gappssmtp.com header.i=@jqluv-com.20251104.gappssmtp.com header.b=w32qjMo3; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jqluv.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jqluv.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jqluv-com.20251104.gappssmtp.com header.i=@jqluv-com.20251104.gappssmtp.com header.b="w32qjMo3"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-128e4d0cc48so8967658c88.1
        for <linux-pci@vger.kernel.org>; Thu, 09 Apr 2026 22:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jqluv-com.20251104.gappssmtp.com; s=20251104; t=1775799054; x=1776403854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=INYeksj8U+IbdS6ka7WkcvOr+zbRscbIhjwqU/8dvac=;
        b=w32qjMo3HbcgwPKmjllo1z8M9OMff9C+2APrG/NgHTp7SmwR1b7hxjyNpQoLbTLS1f
         cIBEOjyV7CfcE5DgfgV52o0wnAqBT0Pgj55+sjUklky1AtSle8olJkDuGuhl5KYoq2wL
         eXDPfC8liALW0qehTafQhia3c8I/rYLajQQwe+BnJdXNWR7tFDbB/2vgN3KjVp7uc8oi
         9PCT18ZtmmGxMvHLtVbV4VfNYmGEe+3y3csXbsFuCaQig2D4a5xjmdRrp+CWGJYcib/6
         Qb0WTucJnL+iSiU9sN4rwqlfLrxj0cp49pbKiuPoUqjBDLKxFjJEi7qzyL2RT1SjEaOL
         /2mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775799054; x=1776403854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=INYeksj8U+IbdS6ka7WkcvOr+zbRscbIhjwqU/8dvac=;
        b=WXQb6AoO4IDoPtzxHpeRx+7OybJoso5ErimddD0H1pHBlUbwyNzRVnhn4le1SFdesn
         AYCnAcGpmO4DYV8T6KZrh2c36/MhWj9+4FiDJGzcBcU4w7CoWI2S6jwizyo9Y2p8VpKH
         cKC5qV4R5jRFoeOR1I4d5PUCxmh9tHfg4jUE8JKYSFShficKbs/C6LZszrP1kxPwYab8
         i9q9P2wPPfDsT3jxwY0iRnpTPdjrEP3nnkJ1AO4dS47CEGrZimE3rKBKB0lAalgE6srP
         Do/6NQlhzl1vFjzgVOCdAeNdQ0jTaBfbmS9kBM/afVgyq9VWZwiBfSkmzulz4GKC3e+d
         ympg==
X-Forwarded-Encrypted: i=1; AJvYcCXNoYbHF/9yKm6QksnFD+owGviuqPkNLW+neMk1+R1tjZwD7+DchwnyZbkflK7JBApMl0UjvcJ3U2k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnH5llP84/fjXne9Tkoqim6X+BhYcpDpBmQ9HmUxR/eipOO4ep
	oBeYJ2BwgTCQrD1VwhkME6jvv4O67VB5T9Fs+KEJOnnOKBxuN7KDQ3pUSJiY7q6rta8=
X-Gm-Gg: AeBDievlPXTtq8KHceTo/2kSTUU6b9PXBysFWMud0TB//MY3SvnsUBv0w7AYHghQeGQ
	H2GxEcIwUMTvG7+zb/Ck6YvuPUPsvx1uwuDCuvbdugWObw3CLSfrs9OjFxLMBaJBtZ5o3z3adNm
	BFDFFLov3fW2ZzBetdOI9OHQPtugxlhU0MwoCf9VLuencbjx9JLthA6CUk5TsXmOYJeDel4l7AC
	oUoST9FulXVmR8DTTLsfUEknyuK6pPOzoyUHBspEOajFMCyRmYu0NW1W6MHlxny2pAyDrcs+4EQ
	65KS8yV/dccOQS3U6h4YS1j1K07e+iz6GEDqIJXSRMBvFm1wqT/Y2G1kV6fJlm12GbKkzqafzbX
	qBvl88ZA5pg4+rHVG/tAAc4RW3reC1MWkUXefVsng7pGGqZNVMoRcYh/3Vjn49q/SGa+nwRn5bD
	znIWSoA2fRwPYO+Ycp5eUFHVan7DFhNOhLyCxU
X-Received: by 2002:a05:7300:ed0f:b0:2c5:50fe:c78f with SMTP id 5a478bee46e88-2d587c85e31mr1047023eec.12.1775799053874;
        Thu, 09 Apr 2026 22:30:53 -0700 (PDT)
Received: from geramyl-MS-S1-MAX.. ([2601:201:8080:e5c0:4e7a:601e:5f03:c2a7])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d561bde68bsm2796529eec.17.2026.04.09.22.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 22:30:53 -0700 (PDT)
From: Geramy Loveless <gloveless@jqluv.com>
To: ilpo.jarvinen@linux.intel.com
Cc: Geramy Loveless <gloveless@jqluv.com>,
	linux-pci@vger.kernel.org,
	cristi@ieee.org
Subject: [PATCH v2] PCI: release empty sibling bridge windows during rebar expansion
Date: Thu,  9 Apr 2026 22:26:02 -0700
Message-ID: <20260410052918.5556-2-gloveless@jqluv.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <29a5ee31baf8be7d07617beea016c3f6d03934bf.camel@ieee.org>
References: <29a5ee31baf8be7d07617beea016c3f6d03934bf.camel@ieee.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When pbus_reassign_bridge_resources() walks up the bridge hierarchy
to expand a window (e.g. for resizable BAR), it refuses to release
any bridge window that has children.  This prevents BAR resize on
devices behind multi-port PCIe switches (such as Thunderbolt docks)
where empty sibling downstream ports hold small reservations that
block the parent bridge window from being freed and re-sized.

Add pci_bus_subtree_empty() to check whether a bus subtree contains
any assigned device BARs, and pci_bus_release_empty_bridges() to
release bridge window resources of empty sibling bridges, saving
them to the rollback list so failures can be properly unwound.

In pbus_reassign_bridge_resources(), call pci_bus_release_empty_bridges()
before checking res->child, so empty sibling windows are cleared first
and the parent window can then be released and grown.

Uses PCI bus/device iterators rather than walking the raw resource
tree, which avoids issues with stale sibling pointers after resource
release.

Suggested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Geramy Loveless <gloveless@jqluv.com>
---
 drivers/pci/setup-bus.c | 99 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 97 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 4cf120ebe5a..7a182cd7e4d 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -2292,6 +2292,94 @@ void pci_assign_unassigned_bridge_resources(struct pci_dev *bridge)
 }
 EXPORT_SYMBOL_GPL(pci_assign_unassigned_bridge_resources);
 
+/*
+ * pci_bus_subtree_empty - Check whether a bus subtree has any assigned
+ * non-bridge device resources.
+ * @bus: PCI bus to check
+ *
+ * Returns true if no device on @bus or its descendant buses has any
+ * assigned BARs (bridge window resources are not considered).
+ */
+static bool pci_bus_subtree_empty(struct pci_bus *bus)
+{
+	struct pci_dev *dev;
+
+	list_for_each_entry(dev, &bus->devices, bus_list) {
+		struct resource *r;
+		unsigned int i;
+
+		pci_dev_for_each_resource(dev, r, i) {
+			if (i >= PCI_BRIDGE_RESOURCES)
+				break;
+			if (resource_assigned(r))
+				return false;
+		}
+
+		if (dev->subordinate &&
+		    !pci_bus_subtree_empty(dev->subordinate))
+			return false;
+	}
+
+	return true;
+}
+
+/*
+ * pci_bus_release_empty_bridges - Release bridge window resources of
+ * empty sibling bridges so the parent window can be freed and re-sized.
+ * @bus: PCI bus whose child bridges to scan
+ * @b_win: Parent bridge window resource; only children of this window
+ *         are released
+ * @saved: List to save released resources for rollback
+ *
+ * For each PCI-to-PCI bridge on @bus whose subtree is empty (no assigned
+ * device BARs), releases bridge window resources that are children of
+ * @b_win, saving them for rollback via @saved.
+ *
+ * Returns 0 on success, negative errno on failure.
+ */
+static int pci_bus_release_empty_bridges(struct pci_bus *bus,
+					 struct resource *b_win,
+					 struct list_head *saved)
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
+		if ((dev->class >> 8) != PCI_CLASS_BRIDGE_PCI)
+			continue;
+
+		if (!pci_bus_subtree_empty(dev->subordinate))
+			continue;
+
+		pci_dev_for_each_resource(dev, r, i) {
+			int ret;
+
+			if (!pci_resource_is_bridge_win(i))
+				continue;
+
+			if (!resource_assigned(r))
+				continue;
+
+			if (r->parent != b_win)
+				continue;
+
+			ret = pci_dev_res_add_to_list(saved, dev, r, 0, 0);
+			if (ret)
+				return ret;
+
+			release_child_resources(r);
+			pci_release_resource(dev, i);
+		}
+	}
+
+	return 0;
+}
+
 /*
  * Walk to the root bus, find the bridge window relevant for @res and
  * release it when possible. If the bridge window contains assigned
@@ -2316,7 +2404,14 @@ static int pbus_reassign_bridge_resources(struct pci_bus *bus, struct resource *
 
 		i = pci_resource_num(bridge, res);
 
-		/* Ignore BARs which are still in use */
+		/* Release empty sibling bridge windows first */
+		if (bridge->subordinate) {
+			ret = pci_bus_release_empty_bridges(
+					bridge->subordinate, res, saved);
+			if (ret)
+				return ret;
+		}
+
 		if (!res->child) {
 			ret = pci_dev_res_add_to_list(saved, bridge, res, 0, 0);
 			if (ret)
@@ -2327,7 +2422,7 @@ static int pbus_reassign_bridge_resources(struct pci_bus *bus, struct resource *
 			const char *res_name = pci_resource_name(bridge, i);
 
 			pci_warn(bridge,
-				 "%s %pR: was not released (still contains assigned resources)\n",
+				 "%s %pR: not released, active children present\n",
 				 res_name, res);
 		}
 
-- 
2.43.0


Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF07330D23
	for <linux-pci@vger.kernel.org>; Fri, 10 Apr 2026 19:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775848242; cv=none; b=ZKOUyxEi2bnTVVYkvHSQK7uQM+JWay949W22jpySOm37gh5Zzciq7+wSPuQfaBotYkc2Gco36Qxp83Z6l7TMCcT8BgVD2wO0v3V5YFeuoyTJ4Iv9jhOypSpsXbX6X7jpwwqkU7nmQUc5x+QdQx7zc8UZxkcNNatQi82Kn02iyIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775848242; c=relaxed/simple;
	bh=mpqUq4lt5PRhqmRG2nWWVvjeSAyu6CGhlJwAEPGRf7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ah1p+Up5oxBLFNoL9qMfVPGmAs0Q/F7QPPvwmsdWs6UXUyXV78TCMuHBlMo6ef5G8DUY0e3RHGaHHcDSpR78+kY7BdWvzB14eZtaN3TSh/drCLmkSIVDqKxoYV5G8Ar0YfkPXWg4jCVoup9vdOZ/5HLUNJLMlCHERG8I9ZXe6vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jqluv.com; spf=none smtp.mailfrom=jqluv.com; dkim=pass (2048-bit key) header.d=jqluv-com.20251104.gappssmtp.com header.i=@jqluv-com.20251104.gappssmtp.com header.b=kw3+oN6X; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jqluv.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jqluv.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jqluv-com.20251104.gappssmtp.com header.i=@jqluv-com.20251104.gappssmtp.com header.b="kw3+oN6X"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2b4520f6b32so2605127eec.0
        for <linux-pci@vger.kernel.org>; Fri, 10 Apr 2026 12:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jqluv-com.20251104.gappssmtp.com; s=20251104; t=1775848239; x=1776453039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4gIcSBFISy1np7le9AlixVLh62OAhzwxZ2OczFxQ9KE=;
        b=kw3+oN6Xv2Y/Xtar48e04dscV2n8QB1DOjD89sDv7/DNl9xGVKx1Db/kln1emT7AwI
         RzcNusw0wtthr9V35VgFBg1DppQYkSyXEjFW+uutIDFPu+YjMKCYrHGcst0QWRdETCVR
         d6XKviUjFgfKV6eg9lgz8xz5ut6YOPKKFVvI/Z38CO61FEX1M/8yEQ/8U922kacjRtMI
         UKEZ8xbf1Vkuq/zGjuXbyKt8hj8Frp7yTQ/Mn2q7LROX8c6IewjT/2NWql4hfrfe8RmN
         8pWA2ALcoyKwZ137Gp1wfvBQ7t+bg6q903UjZmoUwLtetYYTQnmtWdywfnem0jWvs3Zo
         Lfag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775848239; x=1776453039;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4gIcSBFISy1np7le9AlixVLh62OAhzwxZ2OczFxQ9KE=;
        b=YrY1HoVaHy9bFwLYTHpvdFQYQEZ65xc/VSWmiOLVoFaVb3jVV79Rc0MOuYEKLE+cxP
         JboXGo8t2r4jBxF046AJtWFEpI8irBVHdCckDiM2b24QT9VOfz64sH/+jf/2VTu2rhzX
         pDzPs3ynHF3nWBE5qM2NarwE9fcteKT7Y1kcfInP1Dvq3MbaB3qQIYn2jr112mCqz03/
         sibSbMsilcX2hcdjZgoAc7moMa5JBYiijZ/lkUxRAe/fbBnyXn1yi5iQx6/ylKmzjFAJ
         P6zpeMRvUYQ77yeUgU06xZWYzylJIpW5rK2nnIvVu7ZOI6Ran1el1a5/9Mr0KExtTZhG
         iTrw==
X-Gm-Message-State: AOJu0Yyj1M9fQgIQQsQN48ZtGTGPYz+e3B7NuNeRKoFtV3SgO99blzZ/
	ZWF+sXA+lw9yAj15X4Hn8iQxzoFXcbv8ft/8bmH6AUBerRMyd3Nbpj/BpkZH2IXSrTx6sfjNEFN
	TfsKF8wCboA==
X-Gm-Gg: AeBDieu+tIQPNFf+tQHRy9+PYi8PM65H/Y3YLND4kOHDe5V+lAo22SfjAmmlEyrHuGe
	Es0nzWYkR8UAU6+71BtGrdfbzY2SoKivU1vAYKN+Jqrv7K83S7PgojJbqblulIgbhh5LAjIp+MZ
	fRUa/JNleF9Km+6uVjECd/FVHU0Tdb+r1gfD210Arg5ki/bczOg+3mbEgRU5wnyGg8WxgIDtZ1c
	SDOpPB1TN3ZLNcfUo88T2Kb3pdpggXoh0X4n4PdyMlS2bRAd/mEwkJcVbYYVUce3AotmJ1VnQw4
	x7CA2UQQ/4OAvX6vj0aqmXxwXn9yMxI4AudbImqZA7ZzbcoY4vZgJG8/C7X7FhPCIuvt2QsskjX
	fFH2fV9s7uqq5pyQ+wqeeC+ls5e35AS9v6xyQcorEFN0JAWoRiDNyxidyBbojABXjxao1mFXA6o
	4mb+Ur58TahXsotRz2bBr/S13MegKINabxcMPrHFIZ+SetmvVz/qmfndXDkIDqk5Nn95a+PBuKB
	S3tbJWN7s3St8UfxaQV
X-Received: by 2002:a05:693c:310a:b0:2ca:2f21:64da with SMTP id 5a478bee46e88-2d5841c5483mr2615126eec.0.1775848239372;
        Fri, 10 Apr 2026 12:10:39 -0700 (PDT)
Received: from geramyl-MS-S1-MAX.crconsultinggroup.net (c-24-7-159-43.hsd1.ca.comcast.net. [24.7.159.43])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d561bde70csm6853067eec.15.2026.04.10.12.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 12:10:39 -0700 (PDT)
From: Geramy Loveless <gloveless@jqluv.com>
To: linux-pci@vger.kernel.org
Cc: Cristian Cocos <cristi@ieee.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Geramy Loveless <gloveless@jqluv.com>
Subject: [PATCH] PCI: release empty sibling bridge resources during window resize
Date: Fri, 10 Apr 2026 12:10:37 -0700
Message-ID: <20260410191037.782121-1-gloveless@jqluv.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <ec0d287c884cbdd5131e1b09147b9b3cd56faf1d.camel@ieee.org>
References: <ec0d287c884cbdd5131e1b09147b9b3cd56faf1d.camel@ieee.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

pbus_reassign_bridge_resources() refuses to release bridge windows that
have child resources.  On multi-port PCIe switches (e.g. Thunderbolt
docks), empty sibling downstream ports hold small reservations that
prevent the parent window from being freed and re-sized for rebar.

Add a bottom-up recursive release that saves and frees each empty bridge
window individually, so the parent window can then be released and grown.

Suggested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Geramy Loveless <gloveless@jqluv.com>
---
 drivers/pci/setup-bus.c | 63 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 61 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 4cf120ebe5ad..0c1fb654c9cc 100644
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
2.51.0


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794258543;
	b=EYHwL6emjLLerre/ko2g6COSr9hko5L4J8FcOupav4wYyCy9czze6qY3EdVs19rD/zbx
	 /zEu3BxDPlwHYy6ZocyhAL2F9A5XTjFQHYJ7/84662UaTIqqCfeM2/TR/lvu3hN3VFUo0
	 nrZx/Vn1K36QNF5Mc96N9vMFH4HR1coWXS5pcuiLDekRYxAzm3vESbpK5EQnIqzsYYR5y
	 4xdq1v6iEYdgV4F185SV69gfl1da953m6+zVtU8KLjxo7oJyqt8PR+I37OENuybbAkBPg
	 ybM3EgelUGLCyh2+5HB0QIobT43HUX9Kcoreo4rKNHk5aAa2lkh5SU+1AwZv8BtgbGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794258543;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=9BfpnICID5Wust8DZJw3hUVC5bZ8A/dEUIdqKRmre9A=;
	b=ROCz8Cb2HMvDa3rOYzijXGh/fY/H4XJsMFQICkXzp1zcM6wZt8wKE0bc9cf9cofpmBFm
	 vZ6NT6vb24J8yVUwFbsaPoAyfEHUR7x7xIv5aoCSJyqv6Z38zh2zJVLIWqTNZDY/ziUrj
	 RiKYqHwCD9SSmhYIVOiRtGkgv52KXG+93EfJ7JbKRoD/o5lTYUuqjIYMBsvHfocAtFKt7
	 /+pF5EWkijoTnGNZhvuUjDsSRSdkeM8glKZ3VZ/nJBq8kzKVgiJtHmp7mY9lvG32Y9h3E
	 5mDmMw0O9qxS562swRTLKV8DhnGg+o1ThaDADStLP5y7P8KuTNs7b1NLpIi3feXsERw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="APH2l7G/";
	arc=none smtp.remote-ip=198.175.65.18
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99E5606A33E;
	Mon,  9 Nov 2026 21:09:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A99E5606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=APH2l7G/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794258542; x=1825794542;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xTnxusP93BI/HWNwISTM71UBSSlGflENSkIVcOCR+XA=;
  b=APH2l7G/12L6O1osS+VLs7nG4YQNKyvXqPe6KKBiepprPcqIlttja1fO
   tdthT6R86/D/c7ziMorOK+Wv+jqChwjIZYGSjEDOyqY8DhEtCCd8m+F+D
   tMqa/Qyu/jVQ1FbRmsCW3mMcxlq6rG6YW2lOEhptwOW60+M/OFcxXCnzy
   pUIjoLDKwxo6j2gdJko1oeAB4S9f2iUm8ZNe6A49JP+85OX5o5E0cKQyD
   fdmsIYGX0EZ0riODKZIDh/53fGXwyyXg+tJgvZDdfLsew2prnlBUPlylx
   /b62SHiJ5qx0JwdOc4zfeXlCGPQxvRBuQo3Su2vsW5rhGfBQFjG1GYQ9d
   w==;
X-CSE-ConnectionGUID: J8VpnSzXRFeNrToVTE0JZg==
X-CSE-MsgGUID: Itbtd8mKSiKOpz+HBj75qw==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="3004838"
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="3004838"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 13:09:02 -0800
X-CSE-ConnectionGUID: nC7L6KFKRQa8CLBponX8ww==
X-CSE-MsgGUID: eWX3yG9uTyC+Au4Gu4i09Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="9747053"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.139])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 13:08:59 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 11/11] PCI: Move CardBus resource names to setup-cardbus.c
Date: Mon,  9 Nov 2026 23:07:11 +0200
Message-ID: <20261109210714.3862-12-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261109210714.3862-1-ilpo.jarvinen@linux.intel.com>
References: <20261109210714.3862-1-ilpo.jarvinen@linux.intel.com>
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

pci_resource_name() contains a table of resource names specific to
CardBus bridges. Move the CardBus-specific part into
pci_cardbus_resource_name() in setup-cardbus.c to make the core code
cleaner.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/pci.c           | 26 ++------------------------
 drivers/pci/pci.h           |  5 +++++
 drivers/pci/setup-cardbus.c | 30 ++++++++++++++++++++++++++++++
 3 files changed, 37 insertions(+), 24 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 46da873c9aac..e6c5a2d28abf 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -832,31 +832,9 @@ const char *pci_resource_name(struct pci_dev *dev, unsigned int i)
 		"bridge window",	/* "mem" included in %pR */
 		"bridge window",	/* "mem pref" included in %pR */
 	};
-	static const char * const cardbus_name[] = {
-		"BAR 1",
-		"unknown",
-		"unknown",
-		"unknown",
-		"unknown",
-		"unknown",
-		"unknown",
-#ifdef CONFIG_PCI_IOV
-		"unknown",
-		"unknown",
-		"unknown",
-		"unknown",
-		"unknown",
-		"unknown",
-#endif
-		"CardBus bridge window 0",	/* I/O */
-		"CardBus bridge window 1",	/* I/O */
-		"CardBus bridge window 0",	/* mem */
-		"CardBus bridge window 1",	/* mem */
-	};
 
-	if (dev->hdr_type == PCI_HEADER_TYPE_CARDBUS &&
-	    i < ARRAY_SIZE(cardbus_name))
-		return cardbus_name[i];
+	if (pci_is_cardbus_bridge(dev))
+		return pci_cardbus_resource_name(i);
 
 	if (i < ARRAY_SIZE(bar_name))
 		return bar_name[i];
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 057c8a2c7ee7..eefa5a2937c1 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -426,6 +426,7 @@ static inline bool pci_is_cardbus_bridge(const struct pci_dev *dev)
 #ifdef CONFIG_CARDBUS
 unsigned long pci_cardbus_resource_alignment(const struct resource *res);
 int pci_setup_cardbus_device(struct pci_dev *dev);
+const char *pci_cardbus_resource_name(unsigned int resno);
 int pci_bus_size_cardbus_bridge(struct pci_bus *bus,
 				struct list_head *realloc_head);
 int pci_cardbus_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
@@ -442,6 +443,10 @@ static inline int pci_setup_cardbus_device(struct pci_dev *dev)
 {
 	return -EOPNOTSUPP;
 }
+static inline const char *pci_cardbus_resource_name(unsigned int resno)
+{
+	return "unsupported";
+}
 static inline int pci_bus_size_cardbus_bridge(struct pci_bus *bus,
 					      struct list_head *realloc_head)
 {
diff --git a/drivers/pci/setup-cardbus.c b/drivers/pci/setup-cardbus.c
index 33aca7b28354..9acbf299c3a3 100644
--- a/drivers/pci/setup-cardbus.c
+++ b/drivers/pci/setup-cardbus.c
@@ -44,6 +44,36 @@ int pci_setup_cardbus_device(struct pci_dev *dev)
 	return 0;
 }
 
+const char *pci_cardbus_resource_name(unsigned int resno)
+{
+	static const char * const cardbus_name[] = {
+		"BAR 1",
+		"unknown",
+		"unknown",
+		"unknown",
+		"unknown",
+		"unknown",
+		"unknown",
+#ifdef CONFIG_PCI_IOV
+		"unknown",
+		"unknown",
+		"unknown",
+		"unknown",
+		"unknown",
+		"unknown",
+#endif
+		"CardBus bridge window 0",	/* I/O */
+		"CardBus bridge window 1",	/* I/O */
+		"CardBus bridge window 0",	/* mem */
+		"CardBus bridge window 1",	/* mem */
+	};
+
+	if (resno < ARRAY_SIZE(cardbus_name))
+		return cardbus_name[resno];
+
+	return "unknown";
+}
+
 int pci_bus_size_cardbus_bridge(struct pci_bus *bus,
 				struct list_head *realloc_head)
 {
-- 
2.47.3


Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1482399023;
	Wed, 29 Apr 2026 12:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777465634; cv=none; b=lX8vgMGx8CgXgUsDc58cfhARLdAKQV2nfQ/GmvO41MP4Sfbq6jggwfcpel4J+/5lziZTi+IGN3vk405nP0SU+pfouqfuYk4rhgKlIyvHjwUyLc0ZvR0Zc8kdl94qQpYPXYf1XmWQlZ5FnP1jaPAaIkrtPsxQBS++ME3BMamInK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777465634; c=relaxed/simple;
	bh=iICkACAhlqRNjUyJ4saFH4NtsQfflsE2R1I8yMUAK3s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qq6007Q0pnX7SLftuvUe/tMZcxlxp1oIq+nfur1s5lnpWAFXEjsouiWfaJukaOGL8UGF1CuhSqiHi+ijp1o5C0si+Bjz/kFk6/nH4bnVdLr6BfU8MNbWIyE6eh3bd6hZ8CXxGEUtwfFBMhxZZqbSkVJgftrA09mDf8Rb+6/OWec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KW73d9RM; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KW73d9RM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777465633; x=1809001633;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iICkACAhlqRNjUyJ4saFH4NtsQfflsE2R1I8yMUAK3s=;
  b=KW73d9RME0ysgg7zQD2kTfu5Ud1fqJifI8F63pztIUF7rYhb9477xYT4
   +mobIACQ2sMTEc/QX2WZ+rTm7Y52oV+75Qq2gQVDd/DQXX0qEUBsrXp/I
   LL/y7Mhr90oghpECBVuzCMjHrNVYFCYAutmoiAJyXRMI1N0kynUGr+Ud3
   rc+otkD1iDCK72CFO/vbfhEKcuVX3t1av1IO6NqWLVnvloPVbeIyd1mWD
   qVTOotB1j6iqqGuoV/RGHI8A2nVC1wYdsUcCg7/RKEK5Q34Da9B7AvXon
   WAcwEeMl3pkkXw7IXG5RtP02iLK5E41reldo4PO51Kw3Oi7bGHI33uKdB
   A==;
X-CSE-ConnectionGUID: La2GhVC4R2CxXyvnSpJSZw==
X-CSE-MsgGUID: vCXAag7FQe207a+ZGIWTxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="78101785"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="78101785"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 05:27:13 -0700
X-CSE-ConnectionGUID: 5Wxn3kxaSMiU9A0qp47Zcg==
X-CSE-MsgGUID: SE6lrUwIRuKuzbGOxcD7Qg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="234512137"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.212])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 05:27:09 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Jin <shawn.jin@asteralabs.com>,
	linuxppc-dev@lists.ozlabs.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 04/11] PCI: Remove const removal cast
Date: Wed, 29 Apr 2026 15:26:10 +0300
Message-Id: <20260429122617.7324-5-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260429122617.7324-1-ilpo.jarvinen@linux.intel.com>
References: <20260429122617.7324-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

__pci_bridge_assign_resources() inputs const pci_dev *bridge, but then
immediately casts const away to pass the bridge to
pdev_assign_resources_sorted().

As pdev_assign_resources_sorted() performs assignment of resources, it
is not possible to make its input parameter to const. Neither of the
__pci_bridge_assign_resources() callers requires the bridge parameter
to be const.

Thus, simply remove the out of place cast and convert the input
parameter to non-const.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/setup-bus.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 1e0e28efe8b8..c0a949f2c995 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1622,14 +1622,13 @@ void pci_bus_claim_resources(struct pci_bus *b)
 }
 EXPORT_SYMBOL(pci_bus_claim_resources);
 
-static void __pci_bridge_assign_resources(const struct pci_dev *bridge,
+static void __pci_bridge_assign_resources(struct pci_dev *bridge,
 					  struct list_head *add_list,
 					  struct list_head *fail_head)
 {
 	struct pci_bus *b;
 
-	pdev_assign_resources_sorted((struct pci_dev *)bridge,
-				     add_list, fail_head);
+	pdev_assign_resources_sorted(bridge, add_list, fail_head);
 
 	b = bridge->subordinate;
 	if (!b)
-- 
2.39.5


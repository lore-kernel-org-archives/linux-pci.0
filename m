Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795182529;
	b=b96mZhJx4jIf6pKf0LRJQF37EGQltlTJM2xcgW5HagH7oXTb7BRPnROtSXjGeUeHlht9
	 93YcNaZXtvePYpJoscsMmFzUFXDHskDu+ekCFhS7+PynHRZ3hucqhXGRiaKd825FKpw4n
	 CftjJwh7s8kveWt++1MZ1ny29jnJsTgCYtTii8E8o+Fun2+xlAmYW6nGMes19SlEGWSKz
	 TQqvcYXN5xmU3/C9EgiKMRBi9LCaCw8lvSsdx8egKsNkPt0Px4KT6C/HX9UUsS7oYgybe
	 MbN1MACFAW9EAFloocmqqY/iv8Mn37bL3B5yXEK9+c7ggMh/jSgaR0mt/LUPT74NCEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795182529;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=QbiOF/SnGEzDloFgjwC99kcUajkfAI7eyrkEc8Ef1pw=;
	b=bWyTWETNHWUi15IZdnmRjhJcJEO47+6gHqLmqfOwNYzlh94kI17IFoFVnwEw+ZAA/BMi
	 yw2qjjAZGNrWtFEF5Fnu8OOn4/V8oKX8mQJz8gOiLQP0BgP60KdpS0L1eoqpYdWU6CC6M
	 4rVkNWEgEgHLIHMDkGKYgI5Z+RjhjyLFe1Q+YAz6m4X4RZBiQVIocXLTFr8liWUYx9eRj
	 IvlY7/hbTHLew+Nt6EZrJJSRIP9E5necNp/0ARInJ5fK62wHNF1EwWWCLWYBviqWiUYJ0
	 7oziksth7WOU/OfUWG3aY3U5bCsdXxBL8cwWb9j7ztq1X58GxmpmkK+XKcCWbwqJ1wA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fQtstdos;
	arc=none smtp.remote-ip=192.198.163.19
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AEB606A320;
	Fri, 20 Nov 2026 13:48:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78AEB606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fQtstdos
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795182529; x=1826718529;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=r0eypkmBMY8k62e6x1SBZyNPYSg+APLbaunnfdmIDww=;
  b=fQtstdosrCIbTlehtVxze1HxhPMiyA4sUgSQGZH9NG2zcEcqEj6o2bUo
   ICfcN4tYsIoBsrd8ZBxsBxLZNHYG5bSOSCuXI0Bm3aUswFkxZZXddxU0z
   4NasSiN/FiFz44TIE+CMRn+AMM/HdRd+VH7OtnwpIBPKSJMntYrBqvAwu
   8+/7O54O4fWZBB2H2dDMXOSQBn9Y5rEkBWOl47yqTZOk2Rq6GTE3vDv1M
   Eo0DrpM2Vw1kAWgZVwzWE8xMoucfgwcPggHY6O3RfNi2gDm/ZYC3wimNZ
   TixmBhOOo9ph+hUytL6ef7tR021s9uNQNWHsW32vZjMwm7Y2sGF6ycEQy
   Q==;
X-CSE-ConnectionGUID: 3ZAool5ySN+fy6kHL+adCw==
X-CSE-MsgGUID: tJDvvwsJQEabg4Wha5x8Aw==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="4160580"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="4160580"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 05:48:48 -0800
X-CSE-ConnectionGUID: GM/SnYfITDKAsGggy/IqIQ==
X-CSE-MsgGUID: yZAu4CQvRlKKhJxn8trvsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="10605184"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.16])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 05:48:45 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	"Rafael J. Wysocki (Intel)" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 08/16] PCI: Make internal sizing and assignment functions static
Date: Fri, 20 Nov 2026 15:47:03 +0200
Message-ID: <20261120134716.3027-9-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261120134716.3027-1-ilpo.jarvinen@linux.intel.com>
References: <20261120134716.3027-1-ilpo.jarvinen@linux.intel.com>
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

__pci_bus_size_bridges() and __pci_bus_assign_resources() are no longer
called outside of setup-bus.c. Make them static and remove their
declarations from pci.h.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/pci.h       | 5 -----
 drivers/pci/setup-bus.c | 9 +++++----
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index ce29d9ca0194..1dd1becd0312 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -537,11 +537,6 @@ void pci_configure_ari(struct pci_dev *dev);
 int pci_dev_res_add_to_list(struct list_head *head, struct pci_dev *dev,
 			    struct resource *res, resource_size_t add_size,
 			    resource_size_t min_align);
-void __pci_bus_size_bridges(struct pci_bus *bus,
-			struct list_head *realloc_head);
-void __pci_bus_assign_resources(const struct pci_bus *bus,
-				struct list_head *add_list,
-				struct list_head *fail_head);
 void pci_assign_unassigned_slot_resources(struct pci_bus *bus, u16 slot);
 bool pci_bus_clip_resource(struct pci_dev *dev, int idx);
 void pci_walk_bus_locked(struct pci_bus *top,
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index f501fa63caab..c7459662b3d5 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1411,7 +1411,8 @@ static void pbus_size_mem(struct pci_bus *bus, struct resource *b_res,
 	}
 }
 
-void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
+static void __pci_bus_size_bridges(struct pci_bus *bus,
+				   struct list_head *realloc_head)
 {
 	struct pci_dev *dev;
 	resource_size_t additional_io_size = 0, additional_mmio_size = 0,
@@ -1567,9 +1568,9 @@ static void __pci_bus_assign_resources_one(const struct pci_bus *bus,
 	}
 }
 
-void __pci_bus_assign_resources(const struct pci_bus *bus,
-				struct list_head *add_list,
-				struct list_head *fail_head)
+static void __pci_bus_assign_resources(const struct pci_bus *bus,
+				       struct list_head *add_list,
+				       struct list_head *fail_head)
 {
 	__pci_bus_assign_resources_one(bus, add_list, fail_head);
 
-- 
2.47.3


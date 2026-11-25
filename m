Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795648275;
	b=Can6P5kfcFTjQlj6zMpjGU384S3jD0vYLKyxSMph9SUga4LuZcX6Uf2jnADSUmAilpIP
	 xPW2ctLyw7F1REgtTK8K0w52Dfq6OezyrPcfJYQpF9t3NnjdonbeeXXl9jZHNY3ZbyuKO
	 mxn/CkWCgeVnKhnhNu2iMwClIRfeqHZ0bzt3XBA2XsZt0ToAyriKucN0OEyIWnvdNQ4xZ
	 RcAGJR9sKlTcHYjAe2/b6/D2/GUY+yHTYGLSa5oHoQSQ+AeDSye0NoUUDqA1eAOmQHBzv
	 +jsKw0UMYGsNbK54mjxunJoo4zeyARdo0yyscnlSV90JV8jXXlOlJbqr/6O6Ux0iuBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795648275;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=H07ylKuWMCbePM+h1X+Ih7j6pxQnrsXInSTndW9gIws=;
	b=w425oNJmdbS4k9pYrmkAImzHtHbto6p2IonSyFIq9KGu+yhElX3MbT+RIadmOeEmnvTG
	 snH1wjFuy80iUGRlTAMCPMifPz+VHLpfEKHkon44k3/vOAeZdCJee6XZiLgcttflxtCGM
	 8CZLaQ1F2IfrTMSi2uePH8/vlW9YY0LkeqwUgRHFMKcSWJ2/68b6bhQ6Aoav9IOF8IJ6Y
	 WT6wWEmOcQRF4JI3ZePtdYH1fElvtbUihxalFtYUBGVy9AhQHVn4ZQEl4hALh7IDnFvlA
	 HDTLs9u8FkI+I8pBoZgX1BJ0OZL4+K7xvPWD7LCJNXzzyMfgZnF/UhtJvSjq2BWUwaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YtEBgzRw;
	arc=none smtp.remote-ip=192.198.163.8
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87FA1606A31E;
	Wed, 25 Nov 2026 23:11:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87FA1606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YtEBgzRw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795648275; x=1827184275;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gA2gd5L60e3pLO7xXaK3z/OFDMx2M30MSQqtPxRRo5Q=;
  b=YtEBgzRwg48ELPwFjF/DtVmuH6K1W5GgsAXHXFFMdDq+BURanIqfnJFE
   BPK/i5ruJLHluQXovInu6u7hAZjgWAYst/3HqVsdqBpdft55lhLuJt+2f
   5whk0cvyOogq92wt953IgREwXOUddDwM1v3r3yNmnAwYvemYl6exJku4j
   0B4ELb+nm/U2PRdagIWvCAx21mb615ZcN7lomDrsOeGIQH2fWNXjqgZ30
   yAit4GfHoV8QSlJBdheAQH3tOravRQlyPOZJwUS/HXvh3hItUeqesuhKD
   1HgOVXxlUZE/26mneVUoL9cnaahz3zHsmTMMt3r71AUSI0U+S7u7RK1FS
   g==;
X-CSE-ConnectionGUID: Lf2+haIsToS5L/Vk0u1bow==
X-CSE-MsgGUID: IPxjMxtiSui8/bVzokvKlA==
X-IronPort-AV: E=McAfee;i="6800,10657,11977"; a="4428691"
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="4428691"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 15:11:10 -0800
X-CSE-ConnectionGUID: DJQjNPXjRp+fpIGqX1rjfA==
X-CSE-MsgGUID: Avf87DOHSGCuDDNrc5qLiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="12323285"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.96])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 15:11:07 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	David Matlack <dmatlack@google.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v3 09/17] PCI: Make internal sizing and assignment functions static
Date: Thu, 26 Nov 2026 01:09:08 +0200
Message-ID: <20261125230925.2441-10-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261125230925.2441-1-ilpo.jarvinen@linux.intel.com>
References: <20261125230925.2441-1-ilpo.jarvinen@linux.intel.com>
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
index b2173e1d9db0..e9fa8e1093d2 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1393,7 +1393,8 @@ static void pbus_size_mem(struct pci_bus *bus, struct resource *b_res,
 	}
 }
 
-void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
+static void __pci_bus_size_bridges(struct pci_bus *bus,
+				   struct list_head *realloc_head)
 {
 	struct pci_dev *dev;
 	resource_size_t additional_io_size = 0, additional_mmio_size = 0,
@@ -1549,9 +1550,9 @@ static void __pci_bus_assign_resources_one(const struct pci_bus *bus,
 	}
 }
 
-void __pci_bus_assign_resources(const struct pci_bus *bus,
-				struct list_head *add_list,
-				struct list_head *fail_head)
+static void __pci_bus_assign_resources(const struct pci_bus *bus,
+				       struct list_head *add_list,
+				       struct list_head *fail_head)
 {
 	lockdep_assert_held(pci_res_setup_lock(bus));
 
-- 
2.47.3


Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B9043F8C3;
	Mon, 20 Jul 2026 16:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784564675; cv=none; b=YoeYyh1jHiGvvxIZkWwW/1W0buT1wEMb4gZ/MPwbQQnq+D8SJpnEAFzgN8grZZ0F0XeP+qgcchcpLvnLQ0ZfSUsDkSRkr+OfzWq55n1XnW5LmWEP7+Y9QuAMtkXAD0VvMzrefX5NMmV+O8fTDbm+8LNualTqmSMVXgygr2AuL8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784564675; c=relaxed/simple;
	bh=G6sc3RDJgZGN7rJGrMGGB9BtIYtPdxlnGpAqfFLOx9s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LTJrwz6qdFViU5umtfhTNGoaVDBHTRohPcox5G8E87x5wXAytQEaD9X7py/ggfk4dejXApUE1DpQkaNfRBubyYS6avcRZi4chfKV9PLVsT1NjOkWPnEoWV8Lp8UtTkHYIr7186bL+Orz5XQpn8pKjuuZxrglFmojjv6/faSNRAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QM8YFpwu; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QM8YFpwu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784564671; x=1816100671;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=G6sc3RDJgZGN7rJGrMGGB9BtIYtPdxlnGpAqfFLOx9s=;
  b=QM8YFpwuFGLBWJUWxhDR1HejhPT7tWyrbGXaye3DWCFsMl9j+p7Nnui1
   Qn6dDXV4ECNPfIRwZJ4sBViCe5x20WNWLgCU8aQJ2J57SwpgisKtfOhju
   /c+g2+i97F9Rpl68okdbAvbN0iwnl/ogo7BOE0Bm5Q4V/yTHcI91WzD7q
   nFCtmApWqUvLmS1SywjL9FWSugzJyb5tDHwtxPosHMb+0nXNjMubDfXv6
   RbfTHycj9WYViI0dFhuZW06NHoF2KCyAMJUNkc2v8HRCx+ft/ByOF2wG4
   Og4izFyEEY+k+9Xq1b1NLFTDMNEZaMROSm7meX3HKJZ6T3YPris0UJxzs
   Q==;
X-CSE-ConnectionGUID: Ra41K/cuQrun1WFQkwcKfA==
X-CSE-MsgGUID: P8L4i/nxTMKs4BNpL7lTKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="85189797"
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="85189797"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 09:24:25 -0700
X-CSE-ConnectionGUID: txsL/dfJS9uRyB4PJzCi0g==
X-CSE-MsgGUID: 4ayk+hYXR3+fmEmKFD1unw==
X-ExtLoop1: 1
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.144])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 09:24:23 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Eric Auger <eauger@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 1/1] PCI: Do not add hotplug reservation multiple times
Date: Mon, 20 Jul 2026 19:24:15 +0300
Message-ID: <20260720162416.5771-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In nested topologies, hotplug reservations gets added multiple times
into the bridge window higher up in the hierarchy. Adding reservation
for intermediate level bridges does not seem very useful because the
hotplug is going to add device at a leaf.

Accounting the hoptlug reservation multiple times results in larger
than expected bridge window size that may lead to assignment failures
as show in this log:

pci_bus 0000:0a: root bus resource [mem 0x10a00000-0x10c00fff window]
pci 0000:0a:00.0: BAR 0 [mem 0x10c00000-0x10c00fff]
pci 0000:0a:00.0:   bridge window [mem 0x10a00000-0x10bfffff]
pci 0000:0b:00.0:   bridge window [mem 0x10a00000-0x10bfffff]
pci 0000:0c:02.0:   bridge window [mem 0x10a00000-0x10bfffff]
pci 0000:0c:02.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 0d] add_size 200000 add_align 100000
pci 0000:0c:02.0: bridge window [mem 0x00100000-0x000fffff] to [bus 0d] add_size 200000 add_align 100000
pci 0000:0b:00.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 0c-0d] add_size 200000 add_align 100000
pci 0000:0b:00.0: bridge window [mem 0x00100000-0x000fffff] to [bus 0c-0d] add_size 200000 add_align 100000
pci 0000:0a:00.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 0b-0d] add_size 400000 add_align 100000
pci 0000:0a:00.0: bridge window [mem 0x00100000-0x000fffff] to [bus 0b-0d] add_size 400000 add_align 100000
pci 0000:0a:00.0: bridge window [mem size 0x00400000]: can't assign; no space
pci 0000:0a:00.0: bridge window [mem size 0x00400000]: failed to assign
pci 0000:0a:00.0: bridge window [mem size 0x00400000 64bit pref]: can't assign; no space
pci 0000:0a:00.0: bridge window [mem size 0x00400000 64bit pref]: failed to assign

The problem stems from calculate_memsize() that calculates size first
and then adds childen size:
	size = max(0, 2M) + 2M

Alter the logic to first account for the children size before applying
the hotplug reservation to not add hotplug reservation multiple times
on different levels of a nested topology. As a result, the size
calculation becomes:
	size = max(0 + 2M, 2M)

Reported-by: Eric Auger <eauger@redhat.com>
Link: https://lore.kernel.org/linux-pci/f23946f2-06ac-4607-8f2c-3ffbc52b627a@redhat.com/
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/setup-bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index c0a949f2c995..e8c94aa1d3c1 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1021,7 +1021,7 @@ static resource_size_t calculate_memsize(resource_size_t size,
 					 resource_size_t children_add_size,
 					 resource_size_t align)
 {
-	size = max(size, min_size) + children_add_size;
+	size = max(size + children_add_size, min_size);
 	return ALIGN(size, align);
 }
 

base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
-- 
2.47.3


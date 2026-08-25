Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB5F31E83D;
	Tue, 25 Aug 2026 02:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787624847; cv=none; b=aUuFn3QIQ9Z6dwRsDyV9kNihrhowRBchS1GB6M49kYhbcT2YAsH8Js2Eg6986eIL4mf97FZJ41kk6tjrJFmyHHjHowB1CqMctNVFUhyv4/TIjBnBNo0kDYQAb4fLs5opVrPvF+xc0awxDjjB7E8fPAcaK4Yzeu3hdlVjtrGSYPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787624847; c=relaxed/simple;
	bh=mlXvc2rRoY2YlNiSOc7Za57w/VMQm4ZP5P9P9htgZBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WXInb4LFOxeVU7ivcO0E0Cn6vn1CrrcLJu5zUvGfeGGelaha9VAZjg5msBy9JcxKaZQWbM7rIq31SzvyN6GwpOXf994SMQPOCPG0S9uE0bJi+il9EiLpvMY1ggH8Ke2JtUoKH47Ioo78sfh7oZmEaMfcJysZZrvJKodTTScshG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l98Y5shB; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l98Y5shB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787624845; x=1819160845;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mlXvc2rRoY2YlNiSOc7Za57w/VMQm4ZP5P9P9htgZBo=;
  b=l98Y5shBGGVXYa4ZqJICVe6ALizPiauM1O0B2jc4UzlT3t81oIC3CxSO
   5PS6jp4SRloaIHVdI0xEQNyyPXj2YJXPMJU8H1WLZ6AHe+OkrkUhNKijG
   cxLiZ4GyuHf0422WeU5GDPKp/h9LbvuYzv106y3C668EeSJLWsVh/h7be
   EGuyqXTs/8JzOXt8xPDDcoOB7TEOL/pSmNdr3RlbquaH48IO0aoV79Sud
   J9hB8ymMYosb5FQuA1buKgZf3Okkwq12dXtzmHTsjDwjKLrOb5BNdRpvZ
   fq25hYQ2EoeJ92v5BkEvQYUbtXioYwBhp3hCsS8jxUCOo4YuRn06NTygi
   A==;
X-CSE-ConnectionGUID: TjYRv86zS4yrJUJ626TRnw==
X-CSE-MsgGUID: jX2fyqvSRJy8wKA1g757GA==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="98761094"
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="98761094"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 19:27:25 -0700
X-CSE-ConnectionGUID: dBw0ZWZbTCKZ3Pil1roFLw==
X-CSE-MsgGUID: kbHXBOSMRlutXt3xqVFERg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="265390092"
Received: from fdefranc-mobl3.igk.intel.com ([172.28.182.157])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 19:27:18 -0700
From: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
To: linux-cxl@vger.kernel.org
Cc: David Hildenbrand <david@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	driver-core@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Subject: [PATCH v2 06/13] drivers/base/memory: Add cxl_offline_memory() to offline a physical range
Date: Tue, 25 Aug 2026 04:26:21 +0200
Message-ID: <20260825022628.3651434-7-fabio.m.de.francesco@linux.intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260825022628.3651434-1-fabio.m.de.francesco@linux.intel.com>
References: <20260825022628.3651434-1-fabio.m.de.francesco@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A CXL region whose capacity is online as System RAM must be taken
offline before a Secondary Bus Reset of the CXL Downstream Port it is
reached through.

Add cxl_offline_memory() to offline the memory blocks spanning a
physical range, exported in the CXL_MHP namespace since the CXL core is
its only caller.

Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
---
 drivers/base/memory.c  | 36 ++++++++++++++++++++++++++++++++++++
 include/linux/memory.h |  5 +++++
 2 files changed, 41 insertions(+)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index bcfe2d9f4adb..ce89b251d34a 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -1018,6 +1018,42 @@ int walk_memory_blocks(unsigned long start, unsigned long size,
 	return ret;
 }
 
+static int cxl_offline_memory_block(struct memory_block *mem, void *arg)
+{
+	int rc = device_offline(&mem->dev);
+
+	/* device_offline() returns a positive value when already offline. */
+	if (rc > 0)
+		return 0;
+
+	return rc;
+}
+
+/**
+ * cxl_offline_memory - offline the memory blocks spanning a physical range
+ * @start: start of the range, memory-block aligned
+ * @size: size of the range, a multiple of the memory block size
+ *
+ * Offline every memory block in [start, start + size). The blocks are offlined
+ * but not removed, so the range can be brought back online afterward. The
+ * caller owns the range and this performs no validation on it.
+ *
+ * Return: 0 on success, negative errno if a block cannot be offlined.
+ *
+ * Context: process context. Sleeps and takes the memory hotplug lock.
+ */
+int cxl_offline_memory(u64 start, u64 size)
+{
+	int rc;
+
+	lock_device_hotplug();
+	rc = walk_memory_blocks(start, size, NULL, cxl_offline_memory_block);
+	unlock_device_hotplug();
+
+	return rc;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_offline_memory, "CXL_MHP");
+
 struct for_each_memory_block_cb_data {
 	walk_memory_blocks_func_t func;
 	void *arg;
diff --git a/include/linux/memory.h b/include/linux/memory.h
index 463dc02f6cff..5dc0b96fb004 100644
--- a/include/linux/memory.h
+++ b/include/linux/memory.h
@@ -149,6 +149,10 @@ static inline unsigned long memory_block_advised_max_size(void)
 {
 	return 0;
 }
+static inline int cxl_offline_memory(u64 start, u64 size)
+{
+	return 0;
+}
 #else /* CONFIG_MEMORY_HOTPLUG */
 extern int register_memory_notifier(struct notifier_block *nb);
 extern void unregister_memory_notifier(struct notifier_block *nb);
@@ -167,6 +171,7 @@ typedef int (*walk_memory_blocks_func_t)(struct memory_block *, void *);
 extern int walk_memory_blocks(unsigned long start, unsigned long size,
 			      void *arg, walk_memory_blocks_func_t func);
 extern int for_each_memory_block(void *arg, walk_memory_blocks_func_t func);
+int cxl_offline_memory(u64 start, u64 size);
 
 extern int memory_group_register_static(int nid, unsigned long max_pages);
 extern int memory_group_register_dynamic(int nid, unsigned long unit_pages);
-- 
2.55.0


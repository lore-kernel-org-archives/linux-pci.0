Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794914232;
	b=nSKepeIoi6iLejRxMNF+o1Onevr+jpuh6YCQPjfL+5lCrnwZfxg4/nE732sAq9dxlEub
	 xmpbHpVmfAGq0cqN4hUBZDP1yCQQTJdFNazmJbIf9yku906hTPk7mp8sI2rKCM4ExFTch
	 yKMH7YXAtJux/1QVQW98UtQWnxxZ23XaAEURski1pg2jslDjSW46bdTDeTJDNgh4Y46u4
	 hGvI0gACB5MAnMgDe7VTO/U2sbd1SZxdGHNS9dQwhaqcXzVBuHKe7vncYnOp5zZBq+BID
	 dC1smhovqNFyqKU2UBFFXHSnE+VolZjm77utXUzxyK4Fy5XVBOmEYXWe3OF3SWGms9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794914232;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=iAO+js2/rUZAhAG04GodjeRZKIKZw8+fGRUeFO86tRw=;
	b=gqnm66ylyk2kubCN0D/Vv+ZQBBhqeXZ3qFiEXeeByt3tcYkqrQsYzpQPjG/4303JAqSD
	 7zSoMeV/8xiGhGTbmHm9VROHtr4nBYDez+WqAagF00TuXFrddVi5godROfZh/AA09XL+g
	 kr1/qzcZDGL10D/dJ/YUhJYi7r8/TJLPAk0hDTSUSZEmco9Xg+v6X5CDxzBbPp3YzK4Yr
	 Ieinb8+N8DgOnZ8HJt+Dk3g1GHByQ3uwmWtPJrb+OTdDQ9qkNt5OWhEy6KmUaC96oJJaP
	 xPagYsPhT7KI9uziaWNzn8mobPVCuP2uTt+/e+VpQ2QSy1jTwhSAR5opV9dkDaelOlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=EXD17zNC;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2E2606A338;
	Tue, 17 Nov 2026 11:17:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC2E2606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=EXD17zNC
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2106B1682;
	Tue, 17 Nov 2026 03:17:08 -0800 (PST)
Received: from e135073.nice.Arm.com (e135073.arm.com [10.34.111.135])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 804A43F763;
	Tue, 17 Nov 2026 03:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794914231; bh=/UCYlm749kr59OAqytxINHkKyAyyQPMuXp7LJQhQcMs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EXD17zNCa5OFTiFXqJKBo1sn21GcuAZ4JVPX2BNGoTpq0DC8Hcxs/yCtiHxP3B7Vf
	 Jy/EPOyYGIQ+XugDtSL7BDu7K5XZRWl+57tKEU6R/UiP1TOU0nukXV/u9lzFmcGBit
	 nLUCKxV/Hce7kI/cjB4MbGGpitcqz5UEjuUuKj1I=
From: Pierre Gondois <pierre.gondois@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Ashok Raj <ashok.raj@oss.qualcomm.com>,
	James Morse <james.morse@arm.com>,
	Mark Brown <broonie@kernel.org>,
	Pierre Gondois <pierre.gondois@arm.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	Hanjun Guo <guohanjun@huawei.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	"Oliver O'Halloran" <oohall@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	Avadhut Naik <avadhut.naik@amd.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Kai-Heng Feng <kaihengf@nvidia.com>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Breno Leitao <leitao@debian.org>,
	Terry Bowman <terry.bowman@amd.com>,
	Dan Williams <djbw@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-edac@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [PATCH v1 05/19] PCI/AER: Embed aer_capability_regs copy in struct aer_recover_entry
Date: Tue, 17 Nov 2026 12:10:15 +0100
Message-ID: <20261117111444.4185512-6-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261117111444.4185512-1-pierre.gondois@arm.com>
References: <20261117111444.4185512-1-pierre.gondois@arm.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit e2abc47a5a1a ("ACPI: APEI: Fix AER info corruption when error
status data has multiple sections") passed to aer_recover_queue() a
newly allocated copy of pcie_err->aer_info instead of providing a
pointer to the ghes struct. This prevented corruptions of the ghes
record (in case the ghes record was re-used for a new error before
the previous error was logged).

To prepare for using a common logging/reporting structure for
ghes/MCE and merging extlog_print_pcie() / ghes_handle_aer() into
a common helper, remove the dependency of ghes_handle_aer() over
gen_pool_alloc().

To achieve the above, replace (struct aer_recover_entry).regs by a
plain struct instead of a pointer, allowing to remove the memory
allocation.

No functional change intended.

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 drivers/pci/pcie/aer.c | 29 ++++++++++-------------------
 1 file changed, 10 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 8708ca3257bb8..57406494ec1f7 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1352,7 +1352,7 @@ struct aer_recover_entry {
 	u8	devfn;
 	u16	domain;
 	int	severity;
-	struct aer_capability_regs *regs;
+	struct aer_capability_regs regs;
 };
 
 static DEFINE_KFIFO(aer_recover_ring, struct aer_recover_entry,
@@ -1374,24 +1374,14 @@ static void aer_recover_work_func(struct work_struct *work)
 					   PCI_SLOT(entry.devfn),
 					   PCI_FUNC(entry.devfn));
 		else
-			pci_print_aer(pdev, entry.severity, entry.regs);
+			pci_print_aer(pdev, entry.severity, &entry.regs);
 
-		regs = entry.regs;
+		regs = &entry.regs;
 		if (entry.severity == AER_CORRECTABLE)
 			err = regs->cor_status & ~regs->cor_mask;
 		else
 			err = regs->uncor_status & ~regs->uncor_mask;
 
-		/*
-		 * Memory for aer_capability_regs(entry.regs) is being
-		 * allocated from the ghes_estatus_pool to protect it from
-		 * overwriting when multiple sections are present in the
-		 * error status. Thus free the same after processing the
-		 * data.
-		 */
-		ghes_estatus_pool_region_free((unsigned long)entry.regs,
-					    sizeof(struct aer_capability_regs));
-
 		if (!pdev)
 			continue;
 
@@ -1429,9 +1419,9 @@ static DECLARE_WORK(aer_recover_work, aer_recover_work_func);
  *
  * Takes ownership of @aer_regs, which must have been allocated from
  * ghes_estatus_pool with a size of sizeof(struct aer_capability_regs).
- * The buffer is freed with ghes_estatus_pool_region_free() by the work
- * item that processes the record, or immediately if the queue is full.
- * The caller must not access or free @aer_regs after this call.
+ * Copies the registers into the queue entry and frees the supplied buffer
+ * before returning, including when the queue is full. The caller must not
+ * access or free @aer_regs after this call.
  */
 void aer_recover_queue(int domain, unsigned int bus, unsigned int devfn,
 		       int severity, struct aer_capability_regs *aer_regs)
@@ -1441,17 +1431,18 @@ void aer_recover_queue(int domain, unsigned int bus, unsigned int devfn,
 		.devfn		= devfn,
 		.domain		= domain,
 		.severity	= severity,
-		.regs		= aer_regs,
+		.regs		= *aer_regs,
 	};
 
+	ghes_estatus_pool_region_free((unsigned long)aer_regs,
+				      sizeof(struct aer_capability_regs));
+
 	if (kfifo_in_spinlocked(&aer_recover_ring, &entry, 1,
 				 &aer_recover_ring_lock)) {
 		schedule_work(&aer_recover_work);
 	} else {
 		pr_err("buffer overflow in recovery for %04x:%02x:%02x.%x\n",
 		       domain, bus, PCI_SLOT(devfn), PCI_FUNC(devfn));
-		ghes_estatus_pool_region_free((unsigned long)aer_regs,
-					      sizeof(struct aer_capability_regs));
 	}
 }
 EXPORT_SYMBOL_GPL(aer_recover_queue);
-- 
2.43.0


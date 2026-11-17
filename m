Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794914407;
	b=TRHmEaBk78opxE7e5dXcd/BOxJ45kzZZ0YovaZ2YqREdtoOZ/AEqtdxbHvbw3QFdFkRE
	 YLnoMwMbF30dw0DK9DXrt0ThUguePsHme40lWhDrKo0dlmOV2L7e0hzffBpixds8BzrO+
	 u/NgsQU7fdakvjywBr4XWAdeEOmPCLO13Gh1jviriIfaF39rkEnmi4gqtMSoI/YmWD8mo
	 UfmSiq/tc5v4tGdIRlJmScEjvOvrSwn2LY1hP8T0YB2Z7prJXsQThc3mzvH6aPw9wh3ia
	 40IaaAvPZcVAPikaiktsPvwHlRly6vG/0mVSPsQyDt6Fd/23v+HYyMMBI8Fp661w7eA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794914407;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=lerhcVcRfU2lk4PsrpleRqAwjsseFlibrr+AoAnaIA8=;
	b=Ch4iVHvRUSy631yIDPMD11HJOMky6wcEW4583zrRNJ0dauwvjboBm40lBn5VaQU1m0qa
	 ph0R2bR0wBGh6EQx9AV3Vpo2PyRrUosTt88ipG+W794vGMfyTh7Jc9A6jdN0FrIdkDyFU
	 TtPGhyyjQFGItc4F80nanJy7FO2Y5DlxHo8HtiyJpZU7a9IeIA9v1OAja8s8cbRDKC9yh
	 USGEktLZFH0iQTcENjaT6pBEgXnYdJF/acq02qlcKOhkJYahBe63zijYSYH4+BNNOUdbv
	 MOdRba3GDH5vVmAIHOFstTWuN47eMSFCd8SFed8HRzR/wpgxp7Tv5LaVb1pFpHscqSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Za+XRYw1;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA186606A338;
	Tue, 17 Nov 2026 11:20:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA186606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Za+XRYw1
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0FB971C0A;
	Tue, 17 Nov 2026 03:20:03 -0800 (PST)
Received: from e135073.nice.Arm.com (e135073.arm.com [10.34.111.135])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9F24F3F763;
	Tue, 17 Nov 2026 03:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794914406; bh=YDgzasSlipXKe/56e4CM9c8AHByhT73/Jmer5AUWPh0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Za+XRYw1cGqmZ/sAMGiGXzSiQ6xN4qBcFk9Rqylzhmn/qXSsl6sVKQ7ydwzAhTxcT
	 F2CbwSyWbFfGkIeCAw96i3tF9OTKTcCPzhxNGKEX2PMJzaLfR2lcWMNfVxkgs5DQlV
	 qSFgMy6wd7Hh+QIizurUzIyO3/+T4tK6oKEwGeyg=
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
	Radu Rendec <radu@rendec.net>,
	Avadhut Naik <avadhut.naik@amd.com>,
	Jonathan Cameron <jic23@kernel.org>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Kai-Heng Feng <kaihengf@nvidia.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Breno Leitao <leitao@debian.org>,
	Terry Bowman <terry.bowman@amd.com>,
	Dan Williams <djbw@kernel.org>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	linux-acpi@vger.kernel.org,
	linux-edac@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [PATCH v1 14/19] ACPI: APEI: Return status from cxl_cper_post_event()
Date: Tue, 17 Nov 2026 12:10:24 +0100
Message-ID: <20261117111444.4185512-15-pierre.gondois@arm.com>
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

Callers cannot tell whether cxl_cper_post_event() queued a CPER event or
discarded it. Return 0 if success and 1 if aborted. Existing callers
continue to ignore the result for now.

A worker that is already scheduled still processes the queued event, so
its schedule_work() return value does not indicate a delivery failure.

This prepares for a following patch moving PCI/CXL handling to
extlog.c.

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 drivers/acpi/apei/apei-internal.h |  4 ++--
 drivers/acpi/apei/ghes.c          | 15 ++++++++-------
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/apei/apei-internal.h b/drivers/acpi/apei/apei-internal.h
index f7f0ab8e5ed7f..5063c743b4cf0 100644
--- a/drivers/acpi/apei/apei-internal.h
+++ b/drivers/acpi/apei/apei-internal.h
@@ -11,8 +11,8 @@
 #include <cxl/event.h>
 
 int ghes_severity(int severity);
-void cxl_cper_post_event(enum cxl_event_type event_type,
-			 struct cxl_cper_event_rec *rec, u32 len);
+int cxl_cper_post_event(enum cxl_event_type event_type,
+			struct cxl_cper_event_rec *rec, u32 len);
 u32 acpi_extlog_mem_err_min_len(u64 validation_bits);
 void acpi_extlog_report(const struct acpi_hest_generic_status *estatus);
 
diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index b51b621208ed1..623ac2a7f7a75 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -823,42 +823,43 @@ DEFINE_KFIFO(cxl_cper_fifo, struct cxl_cper_work_data, CXL_CPER_FIFO_DEPTH);
 static DEFINE_RAW_SPINLOCK(cxl_cper_work_lock);
 struct work_struct *cxl_cper_work;
 
-void cxl_cper_post_event(enum cxl_event_type event_type,
-			 struct cxl_cper_event_rec *rec, u32 len)
+int cxl_cper_post_event(enum cxl_event_type event_type,
+			struct cxl_cper_event_rec *rec, u32 len)
 {
 	struct cxl_cper_work_data wd;
 
 	if (len < sizeof(*rec)) {
 		pr_err(FW_WARN "CXL CPER section too small (%u)\n", len);
-		return;
+		return 1;
 	}
 
 	if (rec->hdr.length <= sizeof(rec->hdr) ||
 	    rec->hdr.length > sizeof(*rec)) {
 		pr_err(FW_WARN "CXL CPER Invalid section length (%u)\n",
 		       rec->hdr.length);
-		return;
+		return 1;
 	}
 
 	if (!(rec->hdr.validation_bits & CPER_CXL_COMP_EVENT_LOG_VALID)) {
 		pr_err(FW_WARN "CXL CPER invalid event\n");
-		return;
+		return 1;
 	}
 
 	guard(raw_spinlock_irqsave)(&cxl_cper_work_lock);
 
 	if (!cxl_cper_work)
-		return;
+		return 1;
 
 	wd.event_type = event_type;
 	memcpy(&wd.rec, rec, sizeof(wd.rec));
 
 	if (!kfifo_put(&cxl_cper_fifo, wd)) {
 		pr_err_ratelimited("CXL CPER kfifo overflow\n");
-		return;
+		return 1;
 	}
 
 	schedule_work(cxl_cper_work);
+	return 0;
 }
 
 int cxl_cper_register_work(struct work_struct *work)
-- 
2.43.0


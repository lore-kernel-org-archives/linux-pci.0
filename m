Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794914425;
	b=r1i4x+7Xg0ZEPaFgZkj5KL2PSHdeyZQ7lt9YSPA07s22naqgZQzh9NB80D5Lw+2e4H8G
	 dIMeyIE8caBNl7FQLeyhK70Bf/mVmzcV9sJ4rJVwNssJopZ39rAsC+0IF1iB+ak2tQov+
	 3AqeKlGPVuSpAoLtP0la8Gm4tyrNsq9LUC2JLMMXtC/brVoGWbvhBt0I4fAq0/mcr7qVQ
	 mwk2gnbgoTMj309QDZ+qzzoeh/R8qlLokg9rvgOvEYM3yer7a4dASGeVKQoWaS3Ghf1Ik
	 5EgHS1EViTaFZQP1mvnxhxibdfbH3P1VZbQeWMz6v2+bZepXj+ZWX5dONhZViSvYqtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794914425;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=BckNrK/yBbpMJc7+ljdha3/xl+zHdn2KaJ8oIO6r40k=;
	b=UtvxuoKDFKrk5BEE6WxNiwSbaYGsGjWn+0RMGO/v9cHaGt9WhSrB7Ry6BJ/59KKBaZi7
	 d4VN65prbfz7B9dnxfryiRk5q+2KpR3YO1Y4tFBZdGAmlQcjoemA+iOxsHSXKMwidNq8m
	 zfrU1qvOV6YK/zUm/pQJUZX7/ubZa8qyGpYlS/9U8eRtz37WCiLGNsxjcnAtWQGCCv7vy
	 szJZjWjbvIx9XQ9Qid3U+vt1wW2YHup0hD62YC/c6X8rZuIPt5gcD10OQvGZQs7Z3WAX1
	 IFyaGjGQRL+9TU2Dutuu08tjhFz54hq3Olwq2geDnpt1M8xLHq+CuJoO7IyWtWICx3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=rtKjuUYk;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12107606A323;
	Tue, 17 Nov 2026 11:20:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12107606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=rtKjuUYk
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 61C351C14;
	Tue, 17 Nov 2026 03:20:21 -0800 (PST)
Received: from e135073.nice.Arm.com (e135073.arm.com [10.34.111.135])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 359643F763;
	Tue, 17 Nov 2026 03:20:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794914424; bh=/YV6HNEH/aCY1HDiH0DATihf/+IdxF8ClXwHWSKsQNA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rtKjuUYkkowGneLHRGSDd+L4Ip2tTIvv7xnLo1AXBLuArBj61GyuO33cKw0rjyo3M
	 W8PsWMAwfkHnO0xIJ6u6inqNG0FaL7pcv90sJaYRTz4tK/Oxd5ajzeshihMfgGuOy4
	 R2I1GiclCp1SfRUqjhigZM+wBG5uNdokrFhCLbpc=
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
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Radu Rendec <radu@rendec.net>,
	Avadhut Naik <avadhut.naik@amd.com>,
	Jonathan Cameron <jic23@kernel.org>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Kai-Heng Feng <kaihengf@nvidia.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Breno Leitao <leitao@debian.org>,
	Dan Williams <djbw@kernel.org>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>,
	linux-acpi@vger.kernel.org,
	linux-edac@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [PATCH v1 15/19] ACPI: APEI: Extend common CPER reporting for GHES section types
Date: Tue, 17 Nov 2026 12:10:25 +0100
Message-ID: <20261117111444.4185512-16-pierre.gondois@arm.com>
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

Add ARM processor tracing and CXL media delivery to acpi_extlog_report()
to prepare for GHES reuse. Trace CXL records as nonstandard events when
validation or queueing fails, preserving their payload and FRU metadata.

Reuse acpi_extlog_mem_err_min_len() to accept legacy 73-byte memory
sections while rejecting records with missing fields marked valid.

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 drivers/acpi/apei/extlog.c | 35 +++++++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/apei/extlog.c b/drivers/acpi/apei/extlog.c
index 8d9b91a764902..8cae5bdacf1c6 100644
--- a/drivers/acpi/apei/extlog.c
+++ b/drivers/acpi/apei/extlog.c
@@ -153,6 +153,8 @@ void acpi_extlog_report(const struct acpi_hest_generic_status *estatus)
 	/* log event via trace */
 	err_seq = atomic_inc_return(&seqno);
 	apei_estatus_for_each_section(estatus, gdata) {
+		int fallback_log = 0;
+
 		if (gdata->validation_bits & CPER_SEC_VALID_FRU_ID)
 			fru_id = (guid_t *)gdata->fru_id;
 		else
@@ -165,8 +167,13 @@ void acpi_extlog_report(const struct acpi_hest_generic_status *estatus)
 		if (guid_equal(sec_type, &CPER_SEC_PLATFORM_MEM)) {
 			struct cper_sec_mem_err *mem = acpi_hest_get_payload(gdata);
 
-			if (gdata->error_data_length >= sizeof(*mem))
-				acpi_extlog_mem_error(gdata, err_seq);
+			if (gdata->error_data_length <
+			    sizeof(struct cper_sec_mem_err_old))
+				continue;
+			if (gdata->error_data_length <
+			    acpi_extlog_mem_err_min_len(mem->validation_bits))
+				continue;
+			acpi_extlog_mem_error(gdata, err_seq);
 		} else if (guid_equal(sec_type, &CPER_SEC_PLATFORM_MEM2)) {
 			struct cper_sec_mem_err2 *mem = acpi_hest_get_payload(gdata);
 
@@ -181,7 +188,31 @@ void acpi_extlog_report(const struct acpi_hest_generic_status *estatus)
 					       gdata->error_data_length);
 		} else if (guid_equal(sec_type, &CPER_SEC_PCIE)) {
 			extlog_print_pcie(gdata);
+		} else if (guid_equal(sec_type, &CPER_SEC_PROC_ARM)) {
+			struct cper_sec_proc_arm *err = acpi_hest_get_payload(gdata);
+
+			if (gdata->error_data_length >= sizeof(*err))
+				log_arm_hw_error(err, ghes_severity(gdata->error_severity));
+		} else if (guid_equal(sec_type, &CPER_SEC_CXL_GEN_MEDIA_GUID)) {
+			struct cxl_cper_event_rec *rec = acpi_hest_get_payload(gdata);
+
+			fallback_log = cxl_cper_post_event(CXL_CPER_EVENT_GEN_MEDIA, rec,
+							   gdata->error_data_length);
+		} else if (guid_equal(sec_type, &CPER_SEC_CXL_DRAM_GUID)) {
+			struct cxl_cper_event_rec *rec = acpi_hest_get_payload(gdata);
+
+			fallback_log = cxl_cper_post_event(CXL_CPER_EVENT_DRAM, rec,
+							   gdata->error_data_length);
+		} else if (guid_equal(sec_type, &CPER_SEC_CXL_MEM_MODULE_GUID)) {
+			struct cxl_cper_event_rec *rec = acpi_hest_get_payload(gdata);
+
+			fallback_log = cxl_cper_post_event(CXL_CPER_EVENT_MEM_MODULE, rec,
+							   gdata->error_data_length);
 		} else {
+			fallback_log = 1;
+		}
+
+		if (fallback_log) {
 			void *err = acpi_hest_get_payload(gdata);
 
 			log_non_standard_event(sec_type, fru_id, fru_text,
-- 
2.43.0


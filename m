Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794914330;
	b=eckgHKXMhskj5t6aexanSEPIdWeGmmCU2qi5H6PLs/WMFZrXy6r1sHt3fZAYZ3cGgU3m
	 pLL5mnbIoV+VBajoedmrsQOfryV3dU3ayyn6gu162/peWAizgGpxt/IgKp6aM3ki/9jYJ
	 1GYdeBwECu4gZS3wvGpWzjJk6SJLkglmkKTvzYKCtQ1t0uSbDGoLr0uYAuO8fcMZEyRzj
	 QgUZjDqQH+wQmZSRjZ8c8YuENGPOWfd6Rl9c/y5nyN3yshHu5zhIj8O6tuwrbpyEzbkLj
	 eq407XqHP/Qqcx+azwSHvTnnB/YluiOv7mXAyW6S6WH+6vrPkhnOeEOgzDZyB/VsXRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794914330;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ae1+zxnmYBA6LucaV0oeD7zsBTx99sDPE5ClpSm1UfI=;
	b=Bo2nvszwbi5dgErUJDl57gNwHhWUycUkof/JnVnVn7DrEQSMVEC66d6pp7UEQu4BhAPk
	 KzFtBGNzSQ5g7mMp8TryO9N8AZoWnKmQ7JWeKQeWh9vardlBezZRGQWGgQoV2USp9bfVI
	 u/ilJySHM5xqbEHhLBWxQgFXyPhqkkKWZkPpXSfKVvSllJPb9brFoe9VcnyqVT6v7ZwYo
	 RgucVBEqBam0SKlfa/hp95e6ICMzlK2IwHcXXWrBAo8QoLbi+7kXqrRsVM95+OWMPaYad
	 FOdInZoEMGyC5v5g9NqhviPa1+UizX/ZJdyX19+640FAKDByyJv54QNQlv8T1OEmlwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=JMmqUw3q;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97DC606A323;
	Tue, 17 Nov 2026 11:18:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C97DC606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=JMmqUw3q
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3A3151BF7;
	Tue, 17 Nov 2026 03:18:46 -0800 (PST)
Received: from e135073.nice.Arm.com (e135073.arm.com [10.34.111.135])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 278713F763;
	Tue, 17 Nov 2026 03:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794914329; bh=gGwUF9uzvgflmhqCUjHXKFSBYmW8th+wZveFeobE1dU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JMmqUw3qcRzMiqHL+zkl2lg3vrPOi4FA+IQufjra561byq3Wejw8Md9lp1ra9Ji3v
	 CU+CG8XBFqHVJ+nygGzVEjUtVpRUfenzODtZmt0GJtA7714YbKi3bafCR7zWJNGIT3
	 THE8bGYiGcWMZ5yTfvyzZL+NEkFtc6S2vNGAB9fc=
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
	Dave Jiang <dave.jiang@intel.com>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Breno Leitao <leitao@debian.org>,
	Terry Bowman <terry.bowman@amd.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Dan Williams <djbw@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-edac@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [PATCH v1 10/19] ACPI: extlog: Simplify fatal record printing
Date: Tue, 17 Nov 2026 12:10:20 +0100
Message-ID: <20261117111444.4185512-11-pierre.gondois@arm.com>
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

Only fatal CPER records reach print_extlog_rcd().
Merge the two helpers, remove the unused prefix argument
and return value, and keep a single rate limiter.

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 drivers/acpi/acpi_extlog.c | 39 ++++++++------------------------------
 1 file changed, 8 insertions(+), 31 deletions(-)

diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
index 16a16b12d8ccf..1782a19eb474b 100644
--- a/drivers/acpi/acpi_extlog.c
+++ b/drivers/acpi/acpi_extlog.c
@@ -95,46 +95,23 @@ static struct acpi_hest_generic_status *extlog_elog_entry_check(int cpu, int ban
 	return estatus;
 }
 
-static void __print_extlog_rcd(const char *pfx,
-			       struct acpi_hest_generic_status *estatus, int cpu)
+static void print_extlog_rcd(struct acpi_hest_generic_status *estatus, int cpu)
 {
+	/* Not more than 2 messages every 5 seconds */
+	static DEFINE_RATELIMIT_STATE(ratelimit, 5 * HZ, 2);
 	static atomic_t seqno;
 	unsigned int curr_seqno;
 	char pfx_seq[64];
 
-	if (!pfx) {
-		if (estatus->error_severity <= CPER_SEV_CORRECTED)
-			pfx = KERN_INFO;
-		else
-			pfx = KERN_ERR;
-	}
+	if (!__ratelimit(&ratelimit))
+		return;
+
 	curr_seqno = atomic_inc_return(&seqno);
-	snprintf(pfx_seq, sizeof(pfx_seq), "%s{%u}", pfx, curr_seqno);
+	snprintf(pfx_seq, sizeof(pfx_seq), KERN_ERR "{%u}", curr_seqno);
 	printk("%s""Hardware error detected on CPU%d\n", pfx_seq, cpu);
 	cper_estatus_print(pfx_seq, estatus);
 }
 
-static int print_extlog_rcd(const char *pfx,
-			    struct acpi_hest_generic_status *estatus, int cpu)
-{
-	/* Not more than 2 messages every 5 seconds */
-	static DEFINE_RATELIMIT_STATE(ratelimit_corrected, 5*HZ, 2);
-	static DEFINE_RATELIMIT_STATE(ratelimit_uncorrected, 5*HZ, 2);
-	struct ratelimit_state *ratelimit;
-
-	if (estatus->error_severity == CPER_SEV_CORRECTED ||
-	    (estatus->error_severity == CPER_SEV_INFORMATIONAL))
-		ratelimit = &ratelimit_corrected;
-	else
-		ratelimit = &ratelimit_uncorrected;
-	if (__ratelimit(ratelimit)) {
-		__print_extlog_rcd(pfx, estatus, cpu);
-		return 0;
-	}
-
-	return 1;
-}
-
 static void extlog_print_pcie(struct acpi_hest_generic_data *gdata)
 {
 #ifdef CONFIG_ACPI_APEI_PCIEAER
@@ -210,7 +187,7 @@ static int extlog_print(struct notifier_block *nb, unsigned long val,
 
 	/* Print fatal records regardless of RAS consumer registration. */
 	if (tmp->error_severity == CPER_SEV_FATAL)
-		print_extlog_rcd(NULL, tmp, cpu);
+		print_extlog_rcd(tmp, cpu);
 
 	/* log event via trace */
 	err_seq++;
-- 
2.43.0


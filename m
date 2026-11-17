Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794914212;
	b=ntbMFmrT+TxZnQwGcO7yNKfR7or7RXgOHOh9BMr3eGNaSeEAS4YHCds7cS5m1txzKqEi
	 rFG/k062kXmp+j+gg7zBRjVolaG76jhiF14bevksGXuBm9Sv7sTs9f2sHj0/yYL9dYyxR
	 hEtuxcCNHoWoVaMjIawKCekIvnAMrZz/n3e0/vQrtujjDdX3xlkoAGHpGNYbC+UAD7QBT
	 CY2qyeBGbl65WBMY9qgfcyZqSDDVnFAxoL/D+rkyYeYsqm5Epn6ygclkq3t3gggDQnwf8
	 CJHw2AqMOWBWWfQjePNumewaXruCyIkX9tSG+di4Zk+oz8Pfh3GPX/jJpHlOIqW6lKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794914212;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=1gFolVlbnQDXq7AXqEZR4zbd1HbosfkpV82uoaeqRJ0=;
	b=TTKr3ofItx7fA9BXVeqiE4RUsvEw/cFN+Av29e0fwfAgonYSP+j1u0YsG4mp7qN5C2yc
	 LmjDzh/+lxEu8Eb86aHmAV2NNeKx+W9UGlVP+o6Llg+73q1HsXUycxlrp08zWRh0eIAOx
	 CSCiz8UyraRISHwRHU1/1TUHclbtcpiHFP57PJ3wtyAHpuIumSODWrkH/6ZdyVXGjByzR
	 XwG6MBCnQ5GizN94eMryPGl90CV7N9Z2O2/YdRcmz/VgoQjZfvvRIo06g47RBErIlDwT4
	 ZxT1DmcKhLsJ/2Q/LVRfjzKcrnQ6gFFpt96tqAjG+cvGxrgaF22f7szJ/5hBBIERS2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=DDZWJqL3;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAAEC606A31C;
	Tue, 17 Nov 2026 11:16:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CAAEC606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=DDZWJqL3
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 667031A32;
	Tue, 17 Nov 2026 03:16:48 -0800 (PST)
Received: from e135073.nice.Arm.com (e135073.arm.com [10.34.111.135])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DD5AD3F763;
	Tue, 17 Nov 2026 03:16:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794914211; bh=yG1nBF1b9ClCQ09cnEWfpTO17qf4/sPT/Xz+KvI9LS8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DDZWJqL3hpEb6fgA+Erdl+GlfKCrNmcK3poDr93VEXJbe92PdvfQewqRI75jNcKns
	 2Zdb/0ufZrIf6sSQtpr8OvK3n9H0eyxrYw6BhS9yZUFqTPrT5XhktNX8UlqHArvYXp
	 NBZgwM8MrOzGZuSA0iYLXFdRcJGYkZqFq+wl3uNM=
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
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Kai-Heng Feng <kaihengf@nvidia.com>,
	Breno Leitao <leitao@debian.org>,
	Dan Williams <djbw@kernel.org>,
	Terry Bowman <terry.bowman@amd.com>,
	linux-acpi@vger.kernel.org,
	linux-edac@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [PATCH v1 04/19] ACPI: APEI: Use empty FRU values if valid bit is absent
Date: Tue, 17 Nov 2026 12:10:14 +0100
Message-ID: <20261117111444.4185512-5-pierre.gondois@arm.com>
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

When a status block contains multiple sections, a section without valid
FRU fields inherits pointers from the preceding section.

Use empty fru_id and fru_text values whenever the matching VALID
bit is not set instead of reusing the value of the previous loop.

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 drivers/acpi/apei/ghes.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 703f3b7f700a6..444d8e82353a7 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -979,8 +979,8 @@ static void ghes_do_proc(struct ghes *ghes,
 	int sev, sec_sev;
 	struct acpi_hest_generic_data *gdata;
 	guid_t *sec_type;
-	const guid_t *fru_id = &guid_null;
-	char *fru_text = "";
+	const guid_t *fru_id;
+	const char *fru_text;
 	bool queued = false;
 	bool sync = is_hest_sync_notify(ghes);
 
@@ -990,9 +990,13 @@ static void ghes_do_proc(struct ghes *ghes,
 		sec_sev = ghes_severity(gdata->error_severity);
 		if (gdata->validation_bits & CPER_SEC_VALID_FRU_ID)
 			fru_id = (guid_t *)gdata->fru_id;
+		else
+			fru_id = &guid_null;
 
 		if (gdata->validation_bits & CPER_SEC_VALID_FRU_TEXT)
 			fru_text = gdata->fru_text;
+		else
+			fru_text = "";
 
 		ghes_log_hwerr(sev, sec_type);
 		if (guid_equal(sec_type, &CPER_SEC_PLATFORM_MEM)) {
-- 
2.43.0


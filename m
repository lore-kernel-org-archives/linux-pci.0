Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794914272;
	b=eyiNdX9e8ZQHlU59pVk0uUkClQiAJFaDeq3k8+cRq7XRa9KOAKLBD9ofrtdcZaXuFeyl
	 rS9P/fFue8yDjIPpMBnVXGjUWuV0S/wl3d3Q6ThtChgMWgtFm8LD2JltuswNzB2OjAcfh
	 HGQe3TDAhe6dft4JIVhHOT6poV9xuXHvMioZSv2vXq7qVBsoxSw6xXtS7YdD9sNv9DaEW
	 XzRBfJnSPhyJFLjGL0sBcHNOt7xAyjgBtn8uWXX4i/q54SbARSQ48RORKNonR0mm+fjuF
	 P36wWQgtwwPjbWhw7Oz+4RemGw9WaVgfFZ+agXiPUktsXv3k77fPlRMy9vyER3amafQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794914272;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=/mF8YDn9SzKZ/tBRzo19EbnjnKr9dUA+FJJmwsFwbow=;
	b=dxtfPiw34WNbUWkuL8KogzIWoyehpOJAhLyhZOYfWwpc2cXyXcbzMIqYtrd+hmO4Pxl+
	 YY1MZ+FlRFyjvyagz2svW7u/9dkReX+HxJCjJGkNPw7IANIXrpBIvK/srlBbXs4tpcErp
	 ZeMJUiHLPAjU6tngxbtFP4paAHLkTBmPdvI4jdX3EuFhknAJGfZgcOHTAJHmGDOhnUS3Z
	 ZqgtJRm+9tBJmEDb+qPESaCijAI6RdMxOVp/YpacfWuSkoCyi6DBb9zpAkiSAszNQUg3q
	 8aDomnFWDivADnI3Jm4y7elUZouvAClh2elsQBDGV/g/xJtYHKpczX5daljNFuI5ldQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b="iSG/Q5CD";
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FBF9606A331;
	Tue, 17 Nov 2026 11:17:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7FBF9606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=iSG/Q5CD
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 118611682;
	Tue, 17 Nov 2026 03:17:48 -0800 (PST)
Received: from e135073.nice.Arm.com (e135073.arm.com [10.34.111.135])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E2D403F763;
	Tue, 17 Nov 2026 03:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794914271; bh=BFRCbt9be3YwNyQfUo0JQonDsf0DD286+/Lqxp/rjUw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iSG/Q5CDnoaPwkNewXjRdk8C42BPFwFsjjHkjTZdKmdBPkh49YcL9Rpc6ImhFzCOs
	 PVQzfUn2l7bHxJfGi7fPi9mHIVgRxOjVkiv8W8fn+cyAziaRBXqvdJflajehLWhlYx
	 FVRpcF+TH85V7yMyqj1QZxc5PcaYVDtUVSgaZ+EY=
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
Subject: [PATCH v1 07/19] ACPI: extlog: Provide HEST generic data to extlog_print_pcie()
Date: Tue, 17 Nov 2026 12:10:17 +0100
Message-ID: <20261117111444.4185512-8-pierre.gondois@arm.com>
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

Pass struct acpi_hest_generic_data to extlog_print_pcie() and derive
the payload, severity and length from it instead of passing them
individually. This reduces the number of arguments and makes the
section flags available for subsequent changes.

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 drivers/acpi/acpi_extlog.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
index 5565177be328f..125f7931b98bc 100644
--- a/drivers/acpi/acpi_extlog.c
+++ b/drivers/acpi/acpi_extlog.c
@@ -133,10 +133,10 @@ static int print_extlog_rcd(const char *pfx,
 	return 1;
 }
 
-static void extlog_print_pcie(struct cper_sec_pcie *pcie_err,
-			      int severity, u32 len)
+static void extlog_print_pcie(struct acpi_hest_generic_data *gdata)
 {
 #ifdef CONFIG_ACPI_APEI_PCIEAER
+	struct cper_sec_pcie *pcie_err = acpi_hest_get_payload(gdata);
 	struct aer_capability_regs aer_regs = {};
 	struct pci_dev *pdev;
 	unsigned int devfn;
@@ -144,9 +144,10 @@ static void extlog_print_pcie(struct cper_sec_pcie *pcie_err,
 	int aer_severity;
 	int domain;
 
-	if (len < sizeof(*pcie_err)) {
+	if (gdata->error_data_length < sizeof(*pcie_err)) {
 		pr_warn_ratelimited(FW_WARN
-				    "PCIe error section too small (%u)\n", len);
+				    "PCIe error section too small (%u)\n",
+				    gdata->error_data_length);
 		return;
 	}
 
@@ -154,7 +155,7 @@ static void extlog_print_pcie(struct cper_sec_pcie *pcie_err,
 	      pcie_err->validation_bits & CPER_PCIE_VALID_AER_INFO))
 		return;
 
-	aer_severity = cper_severity_to_aer(severity);
+	aer_severity = cper_severity_to_aer(gdata->error_severity);
 
 	aer_cap_regs_unpack(&aer_regs, pcie_err->aer_info, sizeof(pcie_err->aer_info));
 
@@ -245,10 +246,7 @@ static int extlog_print(struct notifier_block *nb, unsigned long val,
 					       gdata->error_severity,
 					       gdata->error_data_length);
 		} else if (guid_equal(sec_type, &CPER_SEC_PCIE)) {
-			struct cper_sec_pcie *pcie_err = acpi_hest_get_payload(gdata);
-
-			extlog_print_pcie(pcie_err, gdata->error_severity,
-					  gdata->error_data_length);
+			extlog_print_pcie(gdata);
 		} else {
 			void *err = acpi_hest_get_payload(gdata);
 
-- 
2.43.0


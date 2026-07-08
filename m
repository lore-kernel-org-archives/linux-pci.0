Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D10240BCA5;
	Wed,  8 Jul 2026 13:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783519182; cv=none; b=POTWZzym6SRYiOlH9VE918QXjsBLhoUScp9BxIQguofPYMhJZrTfOudc7wH+URWFo2exT1XMBzU8awYUt0xLWvIlt3WEW1GY+2kZvatE7UuLermcb80WoiYckGsOuIPtIxkRidqE/jlqWwjK+H4J9+ap4rtB4istwOCDhJKiIfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783519182; c=relaxed/simple;
	bh=6D1ATnmtPMLSPbhlAQPEO8Y+WCryx65f/IRUC4gRpU0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HEhSXQDMXOOwZksI9uSndbQYknl43sS6E7XZ8AuIBtVISf/47Oi20doNFYiD8OaJFZN5WY6KpBmfKsfDoAjkrEWpXM5e0ZDWv7AMI3x7j2cx/CZOu6FXsfRqMAkBtPnFJJGpKd4GiMvzxfjiJ9khf1pEVCkuhnqIEMlZYZRjYcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=jJt5/MoD; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="jJt5/MoD"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AAF841F37;
	Wed,  8 Jul 2026 06:59:34 -0700 (PDT)
Received: from e134710.arm.com (e134710.arm.com [10.33.10.82])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D90983F66F;
	Wed,  8 Jul 2026 06:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783519179; bh=6D1ATnmtPMLSPbhlAQPEO8Y+WCryx65f/IRUC4gRpU0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jJt5/MoD6SSY46+GYnOn9EKcI27ZHHRBnw9eRQFAP0p4QKpt3iOgfEFGkz5oPY48o
	 p/Z7MzcNT1OmGzeNuRfCM4QkZksuqlfbhMeOp68MJ9+SuDuXW+0sMUhw/bORSIEw+p
	 XCH5LhJTfMchsKdxgefwqeFxyT2YLUmZuEA9W1wU=
From: Ahmed Tiba <ahmed.tiba@arm.com>
Date: Wed, 08 Jul 2026 14:59:02 +0100
Subject: [PATCH v7 03/10] ACPI: APEI: GHES: move GHESv2 ack and alloc
 helpers
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-topics-ahmtib01-ras_ffh_arm_internal_review-v7-3-8b3a85216cef@arm.com>
References: <20260708-topics-ahmtib01-ras_ffh_arm_internal_review-v7-0-8b3a85216cef@arm.com>
In-Reply-To: <20260708-topics-ahmtib01-ras_ffh_arm_internal_review-v7-0-8b3a85216cef@arm.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, 
 Hanjun Guo <guohanjun@huawei.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Shuai Xue <xueshuai@linux.alibaba.com>, Len Brown <lenb@kernel.org>, 
 Saket Dumbre <saket.dumbre@intel.com>, Davidlohr Bueso <dave@stgolabs.net>, 
 Jonathan Cameron <jic23@kernel.org>, Dave Jiang <dave.jiang@intel.com>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>, 
 Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>, 
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
 Oliver O'Halloran <oohall@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
 Ahmed Tiba <ahmed.tiba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
 acpica-devel@lists.linux.dev, linux-cxl@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-edac@vger.kernel.org, 
 linux-doc@vger.kernel.org, Dmitry.Lamerov@arm.com
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783519157; l=4777;
 i=ahmed.tiba@arm.com; s=20260219; h=from:subject:message-id;
 bh=6D1ATnmtPMLSPbhlAQPEO8Y+WCryx65f/IRUC4gRpU0=;
 b=A1iciDqzSYu3pKCsCoSpzuEYVQi8okiNnwxZ7puXbFo/Fq5dXFoUJrFcxA8skk8RLMtwR2UOs
 5B48ze28kjrBPBadeUgjUYqskVZp3OILqLcRDN6VHXxSzTjTy1TF+d2
X-Developer-Key: i=ahmed.tiba@arm.com; a=ed25519;
 pk=xVOtd+Qklh/4tuM3tB+BEZD4jj5a6W59C3KCNX6v7OE=

Move the GHESv2 acknowledgment and error-source allocation helpers from
ghes.c into ghes_cper.c. This is a mechanical refactor that keeps the
logic unchanged while making the helpers reusable.

Reviewed-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Ahmed Tiba <ahmed.tiba@arm.com>
---
 drivers/acpi/apei/ghes.c      | 65 -------------------------------------------
 drivers/acpi/apei/ghes_cper.c | 65 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+), 65 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index f74fd5de34cc..bda535224422 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -163,71 +163,6 @@ void ghes_estatus_pool_region_free(unsigned long addr, u32 size)
 }
 EXPORT_SYMBOL_GPL(ghes_estatus_pool_region_free);
 
-static int map_gen_v2(struct ghes *ghes)
-{
-	return apei_map_generic_address(&ghes->generic_v2->read_ack_register);
-}
-
-static void unmap_gen_v2(struct ghes *ghes)
-{
-	apei_unmap_generic_address(&ghes->generic_v2->read_ack_register);
-}
-
-struct ghes *ghes_new(struct acpi_hest_generic *generic)
-{
-	struct ghes *ghes;
-	unsigned int error_block_length;
-	int rc;
-
-	ghes = kzalloc_obj(*ghes);
-	if (!ghes)
-		return ERR_PTR(-ENOMEM);
-
-	ghes->generic = generic;
-	if (is_hest_type_generic_v2(ghes)) {
-		rc = map_gen_v2(ghes);
-		if (rc)
-			goto err_free;
-	}
-
-	rc = apei_map_generic_address(&generic->error_status_address);
-	if (rc)
-		goto err_unmap_read_ack_addr;
-	error_block_length = generic->error_block_length;
-	if (error_block_length > GHES_ESTATUS_MAX_SIZE) {
-		pr_warn(FW_WARN GHES_PFX
-			"Error status block length is too long: %u for "
-			"generic hardware error source: %d.\n",
-			error_block_length, generic->header.source_id);
-		error_block_length = GHES_ESTATUS_MAX_SIZE;
-	}
-	ghes->estatus = kmalloc(error_block_length, GFP_KERNEL);
-	ghes->estatus_length = error_block_length;
-	if (!ghes->estatus) {
-		rc = -ENOMEM;
-		goto err_unmap_status_addr;
-	}
-
-	return ghes;
-
-err_unmap_status_addr:
-	apei_unmap_generic_address(&generic->error_status_address);
-err_unmap_read_ack_addr:
-	if (is_hest_type_generic_v2(ghes))
-		unmap_gen_v2(ghes);
-err_free:
-	kfree(ghes);
-	return ERR_PTR(rc);
-}
-
-void ghes_fini(struct ghes *ghes)
-{
-	kfree(ghes->estatus);
-	apei_unmap_generic_address(&ghes->generic->error_status_address);
-	if (is_hest_type_generic_v2(ghes))
-		unmap_gen_v2(ghes);
-}
-
 static inline int ghes_severity(int severity)
 {
 	switch (severity) {
diff --git a/drivers/acpi/apei/ghes_cper.c b/drivers/acpi/apei/ghes_cper.c
index 0c3f52b2d7f1..9c668725e08a 100644
--- a/drivers/acpi/apei/ghes_cper.c
+++ b/drivers/acpi/apei/ghes_cper.c
@@ -63,6 +63,71 @@ static void ghes_ack_error(struct acpi_hest_generic_v2 *gv2)
 	apei_write(val, &gv2->read_ack_register);
 }
 
+static int map_gen_v2(struct ghes *ghes)
+{
+	return apei_map_generic_address(&ghes->generic_v2->read_ack_register);
+}
+
+static void unmap_gen_v2(struct ghes *ghes)
+{
+	apei_unmap_generic_address(&ghes->generic_v2->read_ack_register);
+}
+
+struct ghes *ghes_new(struct acpi_hest_generic *generic)
+{
+	struct ghes *ghes;
+	unsigned int error_block_length;
+	int rc;
+
+	ghes = kzalloc_obj(*ghes);
+	if (!ghes)
+		return ERR_PTR(-ENOMEM);
+
+	ghes->generic = generic;
+	if (is_hest_type_generic_v2(ghes)) {
+		rc = map_gen_v2(ghes);
+		if (rc)
+			goto err_free;
+	}
+
+	rc = apei_map_generic_address(&generic->error_status_address);
+	if (rc)
+		goto err_unmap_read_ack_addr;
+	error_block_length = generic->error_block_length;
+	if (error_block_length > GHES_ESTATUS_MAX_SIZE) {
+		pr_warn(FW_WARN GHES_PFX
+			"Error status block length is too long: %u for "
+			"generic hardware error source: %d.\n",
+			error_block_length, generic->header.source_id);
+		error_block_length = GHES_ESTATUS_MAX_SIZE;
+	}
+	ghes->estatus = kmalloc(error_block_length, GFP_KERNEL);
+	ghes->estatus_length = error_block_length;
+	if (!ghes->estatus) {
+		rc = -ENOMEM;
+		goto err_unmap_status_addr;
+	}
+
+	return ghes;
+
+err_unmap_status_addr:
+	apei_unmap_generic_address(&generic->error_status_address);
+err_unmap_read_ack_addr:
+	if (is_hest_type_generic_v2(ghes))
+		unmap_gen_v2(ghes);
+err_free:
+	kfree(ghes);
+	return ERR_PTR(rc);
+}
+
+void ghes_fini(struct ghes *ghes)
+{
+	kfree(ghes->estatus);
+	apei_unmap_generic_address(&ghes->generic->error_status_address);
+	if (is_hest_type_generic_v2(ghes))
+		unmap_gen_v2(ghes);
+}
+
 static void ghes_copy_tofrom_phys(void *buffer, u64 paddr, u32 len,
 				  int from_phys,
 				  enum fixed_addresses fixmap_idx)

-- 
2.43.0


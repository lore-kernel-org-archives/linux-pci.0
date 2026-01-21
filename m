Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815A336657B;
	Wed, 21 Jan 2026 08:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768985472; cv=none; b=WbXSzl9fHUff0AHmsPjAAFJW8LctO8KOISnIy/6JDWpRRs7V/5oTM+Hv84+OPbcQTb1WfK+ixOCApcpxAcYKhcSpSjM0/qDBzYbUc7ZQCU5i1XwjV6AbzzPWjF5TZ8J1pLfnhhK0m87MBO4xC/wwz+1nN6kT09Tbgf+TT0s5JNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768985472; c=relaxed/simple;
	bh=0p7FqrGTHaYbu4QmCQP4AVNn9vlQWfjeboAHFDbfH9I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qxre0aD/yNogW8grdWGun+KYbcR6tWOYqiez6TLVtyIAY1U4ooLumdf22alNWYyTvB86lf3FdUnjkVQPduKgGy9zcVckcARrQ6U6PCaS098UxUFrbJX/KYyivHFQeU+2Nrb8wbq4sx2AYgSwbAcEuKFDvW1JOgdaZuGlN58OWZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cp1E3dao; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cp1E3dao"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768985471; x=1800521471;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0p7FqrGTHaYbu4QmCQP4AVNn9vlQWfjeboAHFDbfH9I=;
  b=cp1E3dao7b/SrWZQzTlRCtnK9XiJuJHte3YkoRwj3ITXZfeJV9MtQtzv
   kfkrSuGH7FWMnC6UBDnJexq5WM3dH+p/u6EM1YlVO6NcRpgoNIgzJrNDt
   WsOuh+F0fYpXXQLVQcxfxfCR3/ZJgeIAvRQ+Qy89jUm+Nwq4dOthfA3B6
   GOEEBJ8lQrzDkEfC6b/cPeB6SrR8gWZ+zNNhTevq404FIewtXDy5aS8hT
   F/sHPHrB6C0ZC/Kyq/DjXWWVW/6LM5cKMNKnhMw6zUH3ZR1CwtbM0QWPU
   mlP5o6Cllo3dZI54nvNoP7LXCrVuTB+4Vel9tjCVXgMstkC4U9wmfIu2m
   A==;
X-CSE-ConnectionGUID: iS/kbFdOQO6iLMHoDnj8+Q==
X-CSE-MsgGUID: EZ6UgdGoSOqSxmqaPXW/Bg==
X-IronPort-AV: E=McAfee;i="6800,10657,11677"; a="80927323"
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="80927323"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 00:51:10 -0800
X-CSE-ConnectionGUID: XYlX7UYzRNq8Lx9XYIiDnA==
X-CSE-MsgGUID: D1H+aY1mRB6jTBnGcFCTrQ==
X-ExtLoop1: 1
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa003.fm.intel.com with ESMTP; 21 Jan 2026 00:51:08 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 4296898; Wed, 21 Jan 2026 09:51:07 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Subject: [PATCH v2 1/1] ACPI: PCI: simplify code with acpi_get_local_u64_address()
Date: Wed, 21 Jan 2026 09:50:49 +0100
Message-ID: <20260121085105.2282380-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now we have a helper so there's no need to open-code.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

v2: fixed a typo (LKP)

 drivers/acpi/pci_slot.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/pci_slot.c b/drivers/acpi/pci_slot.c
index 741bcc9d6d6a..15234b65ea22 100644
--- a/drivers/acpi/pci_slot.c
+++ b/drivers/acpi/pci_slot.c
@@ -42,8 +42,9 @@ static int
 check_slot(acpi_handle handle, unsigned long long *sun)
 {
 	int device = -1;
-	unsigned long long adr, sta;
+	unsigned long long sta;
 	acpi_status status;
+	u64 adr;
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 
 	acpi_get_name(handle, ACPI_FULL_PATHNAME, &buffer);
@@ -56,10 +57,9 @@ check_slot(acpi_handle handle, unsigned long long *sun)
 			goto out;
 	}
 
-	status = acpi_evaluate_integer(handle, "_ADR", NULL, &adr);
-	if (ACPI_FAILURE(status)) {
-		pr_debug("_ADR returned %d on %s\n",
-			 status, (char *)buffer.pointer);
+	if (acpi_get_local_u64_address(handle, &adr)) {
+		pr_debug("_ADR returned with failure on %s\n",
+			 (char *)buffer.pointer);
 		goto out;
 	}
 
-- 
2.50.1


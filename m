Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3373438B7;
	Wed, 19 Aug 2026 10:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787136108; cv=none; b=BY5jfA6KS0SiqW768BNWV8vLJk41CG7+VE/VSuQ0D011y/vPwvvnXftuVMc/LF75Ql7oL+BMj/8Cfkx2tZU8j802Zu1wJS1X/FzdGOIUbnvnQotSzowtSfrWWhFvVQpciltB8Nq//GiCmV7mXB7iXuw3noiYyaWgXZ/8R+yrrLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787136108; c=relaxed/simple;
	bh=4ewg8hXVH+aghl5QTTOg3O7jxHUneVO/tYiJ+r+e3os=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KGhejZZutMLFaJrGwFv9/ME8K1hVyMZ+Q5C1hr/nNquib9onTN/KtlNSEdARnY9RprVNIbCWSEgAox2XvJC6YZAnw8Rl6K4ZWRRTwu2yNwjVBobEsOG+IbvpW+zEKGpS6iMTPh5C2G4QJnM8wKzAq1YqvZ0k3RbIAUhm19bQP7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F7BAGVi3; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F7BAGVi3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787136103; x=1818672103;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4ewg8hXVH+aghl5QTTOg3O7jxHUneVO/tYiJ+r+e3os=;
  b=F7BAGVi34nXI7O0QtQ9Kf4czeTWneNB3RO3L3N9JZm1yVA8rrldZmq7V
   m+jA2YDjfx617boZkmz8bVvHdEDTOrUUhuzf063fatiZPw5cTJxeiyjGy
   lDYi/ZyU/rHtGYBhXlwUQAXb8I5NYcSW+KRrwFnuaN29QfoTHodi6UqYf
   BxHJTdLt1w8qi2OIdg5CqVlL2yvP3T/VwFvH9jESvFL9ieoY9t70p611X
   JfkxdI9hnIE2E9Kr27HKE6WqZ4eGq6U+vcIREaXtXU5VLuOVfUuijhkWr
   6dfgP5Myn+sODBAgjz/pDsYuBMm2pO8XDwLUl3FHMTIJPXDQKKL1vc7//
   w==;
X-CSE-ConnectionGUID: PbWtDxquSti8EGtOOK371A==
X-CSE-MsgGUID: PohtcVqoQjCm6+cbhKk4Tw==
X-IronPort-AV: E=McAfee;i="6800,10657,11879"; a="105177068"
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="105177068"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 03:41:40 -0700
X-CSE-ConnectionGUID: +Mfp3vB0SKSKPgw7BZ5Mxg==
X-CSE-MsgGUID: 8OzeUJIrQRm4EKLu7Nc4rQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="263760895"
Received: from ubuntu.igk.intel.com ([10.102.114.174])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 03:41:37 -0700
From: Szymon Durawa <szymon.durawa@linux.intel.com>
To: linux-pci@vger.kernel.org
Cc: Szymon Durawa <szymon.durawa@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dan Williams <djbw@kernel.org>,
	Lukas Wunner <lukas@wunner.de>,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] PCI: vmd: Add VMD Device ID Support for Intel Nova Lake (NVL) and Dunlow (DNL)
Date: Wed, 19 Aug 2026 13:05:22 +0000
Message-ID: <20260819130523.398493-1-szymon.durawa@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add VMD Device ID Support for Intel NVL/DNL processors.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Dan Williams <djbw@kernel.org>
Cc: Lukas Wunner <lukas@wunner.de>
Cc: Nirmal Patel <nirmal.patel@linux.intel.com>
Cc: Jonathan Derrick <jonathan.derrick@linux.dev>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: "Krzysztof Wilczyński" <kwilczynski@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>
Cc: Rob Herring <robh@kernel.org>
Cc: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Suggested-by: Nirmal Patel <nirmal.patel@linux.intel.com>
Signed-off-by: Szymon Durawa <szymon.durawa@linux.intel.com>
---
v1 -> v2:
 - Fixed duplicate text in subject line.
 - Included missing VMD maintainers in CC.

v2 -> v3:
 - Added patch description

 drivers/pci/controller/vmd.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index d4ae250d4bc6..f9d145932155 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -1132,6 +1132,10 @@ static const struct pci_device_id vmd_ids[] = {
                 .driver_data = VMD_FEATS_CLIENT,},
 	{PCI_VDEVICE(INTEL, 0xb07f),
                 .driver_data = VMD_FEATS_CLIENT,},
+	{PCI_VDEVICE(INTEL, 0xd70b),
+		.driver_data = VMD_FEATS_CLIENT,},
+	{PCI_VDEVICE(INTEL, 0xd73b),
+		.driver_data = VMD_FEATS_CLIENT,},
 	{0,}
 };
 MODULE_DEVICE_TABLE(pci, vmd_ids);
-- 
2.43.0


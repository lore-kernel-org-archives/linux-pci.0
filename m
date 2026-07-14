Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B0C3FBED8;
	Tue, 14 Jul 2026 18:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784055573; cv=none; b=WEsGD4fI0sIyUErmMDXZkwTGzWIwwXQmsGlh3rYWmKyu6pqS58wQWrNKqyPcwWa9dE8wYLIgJw5pQ6oCsPwc2AXJ51LrBoYO9e5fqig3kSvSpkZfq9uO+17Kgk5/Cg4xvCPjjejozu71xFJ2x9glrltXGJo0A4pQDc1za3ZjIbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784055573; c=relaxed/simple;
	bh=KZMl1lzhgIz5jdnsnl0i8rjhyHUMPpb1SvaP14ZQYEA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bjoccQkrWL9JEVuB7F6OfgEkLyilsUxvW6XGuFrlWyv8ARtg2tYgLsQySXBgNxQUfhLhqS9pCDvXSlbpRNoYfEQFo638sh4GMtJYCto2td03cwiF6qOdONT57KcbEg1bxhNrJ/REBsUIa23XjJy6UeVFy8SKsZI3mtt8UW7IZ3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E06SQRHM; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E06SQRHM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784055572; x=1815591572;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KZMl1lzhgIz5jdnsnl0i8rjhyHUMPpb1SvaP14ZQYEA=;
  b=E06SQRHM0qtxtartfxnFQqWRG3eGwksfRUD3L/+JlSwVAkiJGNx7fZXK
   3ut++kFoK0bObjSs+T/wnmx6JPJVc2AE3XMEKs5A0WTfEa0/i5RO1N/8b
   la5AuMMbzZ+qxbENnaHaSBd56lyObPDJnRnJajsqNJuxvkELR+UeAkW7A
   WrXDVH9VWOjuj83Jbnkc9F2wLf5CvzSu16SM+DtMi8zJURT3JSiKjASVe
   3tQGfwyUjs5hgDCCyboqTna04vYnYXmk7j6hXarTY2up7+8clszW8jG0n
   r9NOgnLii3FB46gVpupdq8RL+PYYBl4CUmi3ZiDrA2w8VN1tVLyag5IWs
   g==;
X-CSE-ConnectionGUID: HjyjiXTvTJOFMTjktQDycA==
X-CSE-MsgGUID: WwWZMz3ZQlizEGSvlN7DwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="88364950"
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="88364950"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 11:59:29 -0700
X-CSE-ConnectionGUID: qfEpvWg+QFajPfhzgsUznQ==
X-CSE-MsgGUID: OHkihgUlQ4a3/s0xf/j4qQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="256597166"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa009.jf.intel.com with ESMTP; 14 Jul 2026 11:59:25 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id F314F95; Tue, 14 Jul 2026 20:59:23 +0200 (CEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	"Mario Limonciello (AMD)" <superm1@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-pci@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	ibm-acpi-devel@lists.sourceforge.net
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Mika Westerberg <westeri@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	"Derek J. Clark" <derekjohn.clark@gmail.com>,
	Hans de Goede <hansg@kernel.org>
Subject: [PATCH v2 0/6] ACPI: Introduce and use acpi_dev_is_video_device() helper
Date: Tue, 14 Jul 2026 20:53:39 +0200
Message-ID: <20260714185915.865396-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are a few users that open code functionality of matching
a given device against ACPI video device IDs. The current approach
duplicates ID table along with the matching code. Consolidate it
under the acpi_dev_is_video_device() helper's hood.

Supposed to go via ACPI tree, please ack.

Changelog v2:
- rebased on top of the latest code base
- renamed helper and changed its prototype (Rafael, Mika)
- added tag (Wolfram)
- added patch to change scan.c as well

v1: 20220630212819.42958-1-andriy.shevchenko@linux.intel.com

Andy Shevchenko (6):
  ACPI: utils: Introduce acpi_dev_is_video_device() helper
  ACPI: scan: Convert to use acpi_dev_is_video_device() helper
  ACPI: video: Convert to use acpi_dev_is_video_device() helper
  i2c: acpi: Convert to use acpi_dev_is_video_device() helper
  PCI/VGA: Convert to use acpi_dev_is_video_device() helper
  platform/x86: thinkpad_acpi: Convert to use acpi_dev_is_video_device()
    helper

 drivers/acpi/scan.c                         |  4 +++-
 drivers/acpi/utils.c                        | 17 +++++++++++++++++
 drivers/acpi/video_detect.c                 |  7 +------
 drivers/i2c/i2c-core-acpi.c                 | 15 +++++----------
 drivers/pci/vgaarb.c                        |  4 +---
 drivers/platform/x86/lenovo/thinkpad_acpi.c |  2 +-
 include/linux/acpi.h                        |  1 +
 7 files changed, 29 insertions(+), 21 deletions(-)

-- 
2.50.1


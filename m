Received: from shmail.montage-tech.com (shmail.montage-tech.com [180.167.85.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8CB3D9523;
	Sun, 16 Aug 2026 09:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.167.85.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786871148; cv=none; b=ct5El7m9r9Hjoz4rHyrEZZWNutf0CDi+dCz5JjCvI7up6RXzqo3nbKcBOL2N6PDBeoVBxIsKJnRIZpDWIirNYdgYCJTpmHz2QuwgOHl+0RrJal3DUUhD0qtUln2AWUps0zE14yJ11C1DDvZ6WR5hl6XGRmQ7atWQVhwkku+Qmig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786871148; c=relaxed/simple;
	bh=k+8uJQH0GxW/DuaSrhw1hLf2i8g58SvUY0iXunXI0v8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=T6IIt3od1PVt1BYSlqeOpYSXwdp7vd0PYkWoaHb0l6WUpH/TvvLucd8GOCbGXL/BFqe1FRaaOTWawV5RbtONxEiFexmiYeEznao+6xrFeG4mw3xz571+QLss7c3auWWyv5N0t5oEYAjevwN8HPmFZL8exnFwTZaHWXoMjAn3XkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=montage-tech.com; spf=pass smtp.mailfrom=montage-tech.com; dkim=pass (1024-bit key) header.d=montage-tech.com header.i=@montage-tech.com header.b=EkaQ9vK0; arc=none smtp.client-ip=180.167.85.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=montage-tech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=montage-tech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=montage-tech.com header.i=@montage-tech.com header.b="EkaQ9vK0"
Received: from exchmail.montage-tech.com ([10.8.192.33])
	by shmail.montage-tech.com  with ESMTPS id 67G8ntER003751-67G8ntET003751
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 16 Aug 2026 16:49:55 +0800
Received: from mongtage-NF5468M6.montage-tech.com (10.8.98.235) by
 shexch1.montage-tech.com (10.8.192.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Sun, 16 Aug 2026 16:49:52 +0800
From: <peng.guo@montage-tech.com>
To: <linux-cxl@vger.kernel.org>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bhelgaas@google.com>, <dave@stgolabs.net>, <jic23@kernel.org>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>, <djbw@kernel.org>,
	<johnny.li@montage-tech.com>, <jingzhong.yang@montage-tech.com>,
	<engguopeng@buaa.edu.cn>, pguo <peng.guo@montage-tech.com>
Subject: [PATCH 0/2] PCI/CXL: Distinguish CXL capabilities in MCAP 
Date: Sun, 16 Aug 2026 16:49:55 +0800
Message-ID: <20260816084957.3316727-1-peng.guo@montage-tech.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: shexch2.montage-tech.com (10.8.192.34) To
 shexch1.montage-tech.com (10.8.192.33)
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWUhZXkguLT4lWFw8JVpdWFhYXlhaSFpdSBgNBg9GDx0HKAUHBhwJDw1FHA0LAEYLBwVIWUhaXUgEAQYdEEULEAQoHg8NGkYDDRoGDQRGBxoPSFhIWkhZWUhZWEZQRllRWkZbW0hQSFhIWEheSFhIWEhYSFpeSAkEARsHBkYbCwAHDgENBAwoAQYcDQRGCwcFSFhIWVFICgANBA8JCRsoDwcHDwQNRgsHBUhYSFlfSAwJHg0oGxwPBwQJChtGBg0cSFhIWV1IDAIKHygDDRoGDQRGBxoPSFhIWlpIDQYPDx0HGA0GDygKHQkJRg0MHUYLBkhYSFpdSAQBBh0QRQsQBCgeDw0aRgMNGgYNBEYHGg9IWA==
X-FEAS-Client-IP: 10.8.192.33
X-FE-Policy-ID: 6:5:2:montage-tech.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=montage-tech.com; s=shmail; c=relaxed/relaxed;
 h=from:to:cc:subject:date:message-id:mime-version:content-type;
 bh=nWAv3kWqdjyahQIBn7Jkq9fFj2epfNXS2U5WATNzCi4=;
 b=EkaQ9vK0cQkUPKzmLgl2TQdp9qn+kcHI7WQgDgWspkdt4i3+8nKlgEJycNWWtJ6Sd383HRYa0ovI
	kyDM32rTW1xMPa3rqeGMuuePcl/ZpCi4BShTs9b2Co25MUE0eKvx8TMBwRsMdkSZn0uk04ADiEPn
	dQPP51v/S5lkgu9Se/4=

From: pguo <peng.guo@montage-tech.com>

When MMPT is enabled, a device may expose PCI-SIG-defined MMPT
capabilities alongside CXL-defined capabilities in the same MMIO
Capabilities Register Block (MCAP).

MCAP capability IDs are scoped by Vendor ID, but the CXL capability
parser currently matches entries using only their capability IDs. This
can cause MMPT entries to be interpreted as CXL register blocks.

Add the generic PCI MCAP register definitions, then update the CXL
parser to process only capabilities carrying the CXL Vendor ID.

Patch 1 adds the PCI MCAP array and capability header definitions.
Patch 2 filters non-CXL capabilities before interpreting their IDs.

The fix has been tested on a CXL device with MMPT enabled and prevents
both the Mailbox and Status capability misidentification.

pguo (2):
  PCI: Add MMIO Capabilities Register Block definitions
  cxl/core: Skip non-CXL capabilities in MCAP

 drivers/cxl/core/regs.c       |  8 +++++++-
 include/uapi/linux/pci_regs.h | 21 +++++++++++++++++++++
 2 files changed, 28 insertions(+), 1 deletion(-)

-- 
2.43.0


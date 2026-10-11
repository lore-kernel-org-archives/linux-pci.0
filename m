Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BEDE314A86;
	Sun, 11 Oct 2026 19:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791745333; cv=none; b=Gu5Nv8aZzAO8t2WYcr5SbNPGotihp8Zq+Y3yhmxkaOgbNZ7kCVkeukdF545jMNEFm0wAk/qTduIRGqtPc1GqsxAsppNERwskA25T+pfo+A2hfCCD8VxC+JlpJBtUn/mL8xaTcFpuPy8GgFalCzhwy/z+fjQ6ECdsm5YaqQYEP4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791745333; c=relaxed/simple;
	bh=/NRa3jRaLDzXOFPE0Q49wjHP4v+Yx/7QVtSWB2dcwm4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h3zt947FxtgD2QVeU1bTMO6HpA2LM4mIo4mPIahVOd+4FrZRtU7lLRhbMQSEjdywSbKgL3iTmNZCqvqWnbCA+mPAs4obpEyFOWunGdgvQiOcP7gVmujeTqNn96IDlnvF/OqIly0PFUcXCYZ8B4X7kbr3L49n3152mNgNuphj7Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=ugn5lnBh; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ugn5lnBh"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4j2qhw1TRNzKnrY;
	Sun, 11 Oct 2026 21:02:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1791745328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LPIEuH6Bl68tNADhFv18DLX4RORU0Rsbr26PHPEreq8=;
	b=ugn5lnBhl3pKKKVW9fQcceIKXc+0oeenoNNID26pmqa9V1tTLPOHptD3Jx5nDFR7EbnfqS
	zoF/MJT8MzkShcnFhGoNoRzxe+GVSg3zdbjEgmNaWktgihFusUFLEptuNg2ucEUvrIKAw8
	QlcJrOiB2CM/OV3YIiP3yQiCSSuS/JBEXe19Sk8p9VFIJErW6wpXQkOIO7eusflfJnmB0u
	QLrnVQWvZW+c90VyKom+YdYy21WmWNQJhai1zHb7lSoyKRpu27/BZ7nzmfBud8P+Tk1lmq
	17mkX5MCVISP4JOXuRjDZedCGBnlIUUPyAxYiDilzg30wNhnzM6VcwzcW2Lnzg==
From: Alexander Gruhlke <gruhlke@mailbox.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Lukas Wunner <lukas@wunner.de>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Alex Williamson <alex@shazbot.org>,
	Hui Wang <hui.wang@canonical.com>,
	Linux-Fan <info@masysma.net>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev,
	Alexander Gruhlke <gruhlke@mailbox.org>
Subject: [PATCH v3 0/2] PCI: Wait after FLR for devices that don't honor Immediate Readiness
Date: Sun, 11 Oct 2026 21:01:43 +0200
Message-ID: <20261011190145.23621-1-gruhlke@mailbox.org>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: nb8xsimksdrisir8kzrbpxbo1h9ay7ix
X-MBO-RS-ID: ae2bfa45e6c9f7933b6

Since v7.2, VFIO passthrough of a Samsung 990 PRO NVMe [144d:a80c] fails
on the second VM start, and the device is inaccessible until reboot.  The
drive advertises Immediate Readiness but returns ~0 for up to 7 ms after
FLR, so since 10baa9b4df40 ("PCI: Drop unnecessary retries when restoring
BARs") the config restore after FLR is lost.

Patch 1 ignores Immediate Readiness on that drive.  Firmware 8B2QJXD7
fixes it, but the Revision ID and Subsystem ID don't change, so the
quirk can't tell firmware versions apart.  A 990 EVO Plus [144d:a80d]
reports the same errors [1], but it isn't confirmed to advertise
Immediate Readiness, so it's not included.

Patch 2 is independent and keeps pci_dev_wait() from treating ~0 as
ready with RRS Software Visibility, which also affects the Intel
[8086:0a54] in the open d591f6804e7e regression.  Hui, Linux-Fan: testing
patch 2 on that drive would be appreciated.

Tested on v7.2.9 (Ryzen 9 7950X, X670E): with patch 1 and drive firmware
1B2QJXD7, three VM starts in a row work, and every FLR reports "ready
0ms after FLR".  With firmware 8B2QJXD7, plain v7.2.9 works.

Patch 2 is only tested for regressions, as the drive no longer shows the
problem: below a Root Port with RRS SV, three VM starts work and every
FLR reports "ready 0ms after FLR".  The VF path is untested with the
patch, but on another machine, an X550 VF below a Root Port with RRS SV
reads ~0 from the Vendor ID and valid data from the Command register
100 ms after FLR.  v1's variant, which read the Command register, was
tested against the old firmware, and the drive's Vendor ID read ~0
while it wasn't ready.  Applies to pci/next.

Changes since v2:
- Patch 1: add Lukas's Reviewed-by
- Patch 2: read the Command register on VFs whose Vendor ID reads ~0
  instead of treating them as ready (Lukas, sashiko)

v2: https://lore.kernel.org/r/20261011163249.18479-1-gruhlke@mailbox.org
v1: https://lore.kernel.org/r/20261010160529.27974-1-gruhlke@mailbox.org

[1] https://bbs.archlinux.org/viewtopic.php?id=314833

Alexander Gruhlke (2):
  PCI: Ignore Immediate Readiness on Samsung 990 PRO NVMe
  PCI: Don't treat ~0 as ready in pci_dev_wait() with RRS SV

 drivers/pci/pci.c    | 14 ++++++++++----
 drivers/pci/quirks.c | 11 +++++++++++
 2 files changed, 21 insertions(+), 4 deletions(-)

-- 
2.56.0


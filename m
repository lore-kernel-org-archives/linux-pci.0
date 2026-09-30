Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC2936A008;
	Wed, 30 Sep 2026 14:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790779637; cv=none; b=WRgF/RNl92RySzUFEQ9VZSnqnum4AurbbM+I5vzE9ewy8Nl5hDQfv1yRY3XqnbL3UheQbdf/9qSbjKfkiCNGG61h01TaavyNTlqjAFOvhvDcMzBXoZzHxA57+xy6F7al9S+Wc/n6P7bYI//+q9k4yEz28LoxXcBYiSl/aTqiKCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790779637; c=relaxed/simple;
	bh=MjLAvluwZu1HnhSeQichfKhZlgdsiOLmabI8YQudeqk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZjlvtKlsyiYqwUcB064fWqG5ao1QbbZcEtqxm0WKUxXWzBQgrvxmvQImaZM2qJzwgg+QtJB1F3BbKihL5V3D0vGsRnb/xsz/lc5wzbEK9fQ6r2X/aizioS7JYNOb0fra3SWlKz/IrSCuRkbeCcBzp3OjocKKkeKIlLGaZYjV5Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=yj55EMNJ; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="yj55EMNJ"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4hvyYS1yYWzMlYQ;
	Wed, 30 Sep 2026 16:46:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1790779612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rUP2mGMFFm7MNCs7/+3MtwxVH0jiwI8x4kC7Ebnwwf4=;
	b=yj55EMNJfvWN7jV0uQN+4L84Uab15FGdGZCVqDGF/zFdZOokrHWO1TEZqU5kF2Iru9NvqA
	cMnmrglBuWdbTTXMuwCAGt7SueCc7lgEfDWTRUaJ3BPqTH+M0iNqMttqRXGg1uOryYkMJC
	w4mSvqCbEMXXEmnzJ0L+86Ma0e0uSsBKGyakuf6Xs7xQaY0AgI+nMfL4HNYbbt3/xsvIB0
	qfWx0LsbrGza1ZtaQ4Ytk+xXedpel8A1uHSsbyOzpYgsrhs7r+z7MHuV1rCNfNzXMnqvzp
	YyRXbv1DjWEL2eJ+ytpPc2zaqMipnBjMEZJYFk3HAThxN/FxbHe8fh1orO8XYw==
From: Stefan Roese <stefan.roese@mailbox.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: [PATCH 0/2] PCI: Fix Renesas uPD720201 hang after the RCB Link Control write
Date: Wed, 30 Sep 2026 16:46:48 +0200
Message-ID: <20260930144650.3701516-1-stefan.roese@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: wj8pgy9mpmi8oc797uc8838h9kynmnpm
X-MBO-RS-ID: 004d908591491059e44

Since commit 1a6845aaa6de ("PCI: Initialize RCB from
pci_configure_device()"), which went into v6.18.14 as dbe723b480e4, a
Renesas uPD720201 xHCI (1912:0014) behind the CPM Root Port of an AMD
Versal SoC hangs the system on every boot. The first access to the xHCI
BAR after the firmware download runs into PCIe completion timeouts.

The chip comes out of reset with LnkCtl 0x0003 (ASPM L0s and L1
enabled), although the Root Port supports no ASPM. pcie_aspm_cap_init()
returns early for such a link and never clears these bits. This went
unnoticed so far because the chip clears ASPM Control itself during the
firmware download by xhci-pci-renesas. Once the host has written Link
Control, even with the unchanged value, the chip no longer does so, and
ASPM stays enabled on a link that cannot support it.
pci_configure_rcb() does exactly such a write: it read-modify-writes
Link Control of every endpoint at enumeration, even when RCB does not
change.

What was checked on the board:

- Bisecting v6.18.10..v6.18.40 ends at dbe723b480e4.
- v6.18.40 with that commit reverted: good.
- v6.18.10, which does not have it, booted with xhci_pci_renesas
  blacklisted, then a single "setpci CAP_EXP+0x10.w=0003" (the
  unchanged value) before loading the driver: bad. Without the setpci:
  good.

Patch 1 writes RCB only when it changes. On this board RCB is 0 on both
ends, so Link Control is no longer written, and this alone fixes the
hang. It is the minimal fix and marked for stable.

Patch 2 closes the underlying gap: on a link without common ASPM
support, clear ASPM Control where a device has it set. This does not
depend on patch 1 and also covers any other Link Control write that
might come before the driver.

Testing: both patches were tested on v6.18.40 (AMD linux-xlnx) on the
Versal board: USB comes up without completion timeouts in 3 of 3 cold
boots, and lspci shows "ASPM Disabled" for the xHCI. On pci/next the
only change is that patch 2 uses the existing "fn" iterator. The series
builds without warnings (W=1, arm64 and x86_64 defconfig), but I could
not boot test it on pci/next, as this board does not run a mainline
kernel.

Similar reports with this chip and ASPM, possibly related:
- Qualcomm RB3Gen2 needs pcie_aspm=off: https://lkml.iu.edu/2603.3/02364.html
- RPi CM5 "HC died": https://github.com/raspberrypi/linux/issues/6849

#regzbot introduced: 1a6845aaa6de

Stefan Roese (2):
  PCI: Write RCB only when it changes
  PCI/ASPM: Clear ASPM Control on links without common ASPM support

 drivers/pci/pcie/aspm.c | 22 ++++++++++++++++++++--
 drivers/pci/probe.c     | 17 ++++++++++++-----
 2 files changed, 32 insertions(+), 7 deletions(-)

-- 
2.56.0


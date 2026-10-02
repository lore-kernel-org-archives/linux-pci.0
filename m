Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A5F4756CC;
	Fri,  2 Oct 2026 09:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790932238; cv=none; b=IChrWzN5VDi11u7wubzlEH/s73xxCQ0PcZPU0/mxTMhLEGUa2rHLIe47hBVJKEB98KmaHbYJuA+890CJW4uln7gGBIhCQBmbXYFhUaxiJNcmfNNjxNMdgu+MhWSO94SH38Ai3/7QUwjafIgAR5gmlA33q7VO2A7OyhgYSn7cwao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790932238; c=relaxed/simple;
	bh=Ss3OtJ41YuV/fYlt6QMIuYu586Z4Y6pfdw3bFXKekak=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TqyCyVxSvOdg1oh/mOMDbNcX66lWxlC3SHTlmvotI3A4srNsQSWTbRGRy5eDmnUYxJshDFSmqGJUao1HxcNIuQGiVXOIVEVdVsX2o86jyS0RLsy08R8bdL6EQfjInwji8I0+piN89SKkPTeuU/iKrQqpJxvy3pj0KRi9FGHdiZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=vpB+KSm+; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="vpB+KSm+"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4hx30S3dbhzKpB7;
	Fri, 02 Oct 2026 11:10:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1790932232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ofDPnmsXpg1HZKhM/NUNmS6XkfUYzjXA+lGoPUNRgjc=;
	b=vpB+KSm+Wt9VtVb0rKWerbrnFiUpTwlEkJtCGZNWXiUIwYWmOb6bpNdDirCz/nph1fX7NL
	yM6sODf44yP5austJIv4FWhcBkEXnbbAjiV22yEoHay84kiSC3PqqAa4D9QVSXBLm7Ik46
	2WFOOG+95qdgkruouZi8zoPl3bEQQvxDRycH9xOC2y8SKg+RVmV5Yw8qGqC/b3vI76Zt2b
	OZIgJyAy1NTdf+qxfjSXvay+pyY7wJsya5tMwHZpcxv8VRgu7dAUJf0Hsht7jJAMb5I12v
	2zgMDV9NPLGGDk66eFx7VSfeuq+cnkqDDOeOVWqfMuMd6TQyECyi44IK+h24hA==
From: Stefan Roese <stefan.roese@mailbox.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: [PATCH v2 0/2] PCI: Fix Renesas uPD720201 hang after the RCB Link Control write
Date: Fri,  2 Oct 2026 11:10:27 +0200
Message-ID: <20261002091029.2225203-1-stefan.roese@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 8cqn6kf6rkeb81t13syory5nqcpissys
X-MBO-RS-ID: 7465dbc95e46725be9e

Since commit 1a6845aaa6de ("PCI: Initialize RCB from
pci_configure_device()"), which went into v6.18.14 as dbe723b480e4, a
Renesas uPD720201 xHCI (1912:0014) behind the CPM Root Port of an AMD
Versal SoC hangs the system on every boot. The first access to the xHCI
BAR after the firmware download runs into PCIe completion timeouts.

The chip comes out of reset with LnkCtl 0x0003 (ASPM L0s and L1
enabled), although the Root Port supports no ASPM. pcie_aspm_cap_init()
returns early for such a link and never clears these bits, which leaves
the link in a state that PCIe r7.0, sec 5.4.1.4, calls undefined. This
went unnoticed so far because the chip clears ASPM Control itself during
the firmware download by xhci-pci-renesas. Once the host has written
Link Control, even with the unchanged value, the chip no longer does
so. pci_configure_rcb() does exactly such a write for every endpoint.

Patch 1 fixes the ASPM state: on a link without common ASPM support,
clear ASPM Control where a device has it set, and update the saved
state.

Patch 2 is Bjorn's set-only RCB change. It also avoids the Link Control
write on this board, which matters with pcie_aspm=off or
CONFIG_PCIEASPM=n, where patch 1 never runs.

Testing on the Versal board, v6.18.40 (AMD linux-xlnx) with the patches
backported, 3 cold boots each:

- patch 1 alone: good, "clearing ASPM Control" for the xHCI
- patches 1 and 2: good
- patch 2 alone, pcie_aspm=off: good, the chip clears ASPM Control
  itself again
- patch 1 alone, pcie_aspm=off: bad, completion timeouts

On pci/next the series builds without warnings (W=1, arm64 and x86_64
defconfig). I could not boot test it on pci/next, as this board does
not run a mainline kernel.

Changes in v2:
- Make the aspm.c change patch 1 and the actual fix (Bjorn)
- Update the saved state after clearing ASPM Control (sashiko)
- Reword the clearing message to "link has no common ASPM support"
- Cite PCIe r7.0, sec 5.4.1.4, in patch 1 (Bjorn)
- Replace "write RCB only when it changes" with set-only RCB, now
  with Fixes: and stable because of the pcie_aspm=off and
  CONFIG_PCIEASPM=n cases (Bjorn)

Similar reports with this chip and ASPM, possibly related:
- Qualcomm RB3Gen2 needs pcie_aspm=off: https://lkml.iu.edu/2603.3/02364.html
- RPi CM5 "HC died": https://github.com/raspberrypi/linux/issues/6849

v1: https://lore.kernel.org/r/20260930144650.3701516-1-stefan.roese@mailbox.org

#regzbot introduced: 1a6845aaa6de

Stefan Roese (2):
  PCI/ASPM: Clear ASPM Control on links without common ASPM support
  PCI: Set RCB only when the Root Port has it set

 drivers/pci/pcie/aspm.c | 23 +++++++++++++++++++++--
 drivers/pci/probe.c     |  7 +++----
 2 files changed, 24 insertions(+), 6 deletions(-)

-- 
2.56.0


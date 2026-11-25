Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795588295;
	b=RwWP1HD7iYLfjW2zyqV2Cm7h87wgS5vmUz9KCkjzEMJIqUsXOVma3fjwetOmhUYkqJd8
	 H8CrNd1PHKQVjCDyHvaiknhV1y1swwso831wtSz/Ts+5KZP4U/qRnTrkYfyfnatrg7grG
	 Um2r2Mg504uzW2fAEGzU16hkpMACZbLioYLnjcMe//VXAChJLiQNjMPRKcfPlpeVO9h2h
	 hwUyQJir9m5v+BXyC2jlpO5+YhYdd6mnLHrz42rawCIUXnYJ3k2yThd4kMSr42XJESf/e
	 opDQqScLrOhoWVByU70rJQpMW+LMwaAvbnuRUlRhl8taTFNg5XUQXeJXCMp7iYg6Vsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795588295;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-B4-Tracking:X-Change-Id:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=9E8HWuLfY3Nf/OQ9d6R8gO1UtYxqp2kDEADX+rOyoUE=;
	b=BKYSdERvq3bv/P/H4azzL0Tp3bMrjX6VFLTliQyH1PtDtmizNoXjcJbNL4blGWAWlDo3
	 1oqMLQtcCO0a1Rya4BoWWPRidCp5VRU6wSehIpX/egU/DhLvL/A3g8mAyllnlzc32ERhS
	 1riiCYPactFPcuwCpiu7H9P8HYPyYIz84oE5V/UBrsFFthorypTbAouh3a5Qyw2yp9Fx5
	 pIiyFzB62zI44PaiZtNnTzkD5mutZOE/f6HvhuNUE+9zuWgmlIUvQ+sCijZEwskLn06rn
	 P8k1shdgbNeJMUOLVIxoztNKkruYMbUi58ISTbH46YWz4mUHpwJhnw+zUSQsMna4mMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--rathodpriyank.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=cep0HBaz;
	arc=none smtp.remote-ip=209.85.215.200
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D711D606A326
	for <linux-pci@vger.kernel.org>; Wed, 25 Nov 2026 06:31:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D711D606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rathodpriyank.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=cep0HBaz
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cde00369ef5so3346034a12.3
        for <linux-pci@vger.kernel.org>; Tue, 24 Nov 2026 22:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795588294; x=1796193094; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9E8HWuLfY3Nf/OQ9d6R8gO1UtYxqp2kDEADX+rOyoUE=;
        b=cep0HBazVXzsf9PkAdljOv6G5MXFloV8WG81m90sSHMoYIcmRvOmjhm6oTMSkwpaun
         pzHHaOTBFmdCmfJ+13KNqBO1FuQGVJum0GJqPzQl4QRFXgyQ8Hvo03jD0JgRHMDwk03B
         DLYjQsoal4MKgLI3qsnjfCpZ7EBOaoM5ulBq44yBjz53rAkvTYBkVh4iKyNR0GfFRYgS
         JZDvTwMCAPLeiZLLJGteHxxOc/KhBQrWGw3Ltw+QesLR53YU3Nou+jIfq5gwF/63+eZR
         n79TEBDEkA8a/fP7k5LHPVjaZYz2yTEIZG3g6403wH3len5MNyLrRwm/4CDJncRMJ+h1
         ePiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795588294; x=1796193094;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9E8HWuLfY3Nf/OQ9d6R8gO1UtYxqp2kDEADX+rOyoUE=;
        b=V7FHzHjUTaKJeO/xIdWfcukT784vYinxsVTrP0K1WdnxP8sOLQFKgmhypLbegHTBii
         NJUFEOpmvGKdlqyhuuKWShRAl4vIyqvJgdpTipsmgIWE4R0IylLTbeh8KHnFspvO9YJy
         zrp7PKHWkC8ZyjwrwCSHBQTYvB+j8H4BKWG97OI2HsYSXqu77fkmeFmjn0rJ4i5OXnXB
         BVlV/o18I54dSxs4/Z+xyMmmWjM7D5htw/O4cV0JRi8n6cimtp/KBfaRbjrq8csVWE6k
         YWkAYnnTRzg3R478zwC3riZ7X0l7NVaHXCx9SKkq2ra/v0no1Dl+LFKkc9y10UxrsbUO
         uYIQ==
X-Forwarded-Encrypted: i=1; AL+hErEFFDxRcz4UgV9mSPtmUMkCfwcm9rScdsC8g8wAwioDh0f6raRoxJUaT9NeX+K1xo3I1x9SiaeHmDg=@vger.kernel.org
X-Gm-Message-State: APuU4Z+7ShUwGHgPrZORYN+X0VvrZwq355jwB/EURdTyLmoXm/2oFJSg
	Apyir4sfSzqoAJ7F7G2A97GdGVqALrJqmfNnZft8yhgDsSltB9CP5B3BFQMOVuRzZnKVRjGL5uq
	YhWb5fKe1oQGbcxz0t1g+IB69CeUk/XXeww==
X-Received: from plrd18.prod.google.com ([2002:a17:902:aa92:b0:2eb:50b1:b505])
 (user=rathodpriyank job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:ecc4:b0:2f0:3c38:9133 with SMTP id d9443c01a7336-2f0c5f91aa0mr41199225ad.43.1795588293874;
 Tue, 24 Nov 2026 22:31:33 -0800 (PST)
Date: Wed, 25 Nov 2026 06:31:32 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAMSABmsC/43QSWrEMBAF0Ks0WkdBpdJgZZV7hCw0lN0iHcvYj
 UlofPfIvciATfDyF9T78G9sojHTxJ5ONzbSnKdc+hqahxOLZ993xHOqmUkhjWgQ+BAz8Uvu3zj
 1aSi5v07c2YZAiKSTMKx+DiO1+eOuvrzWfM7TtYyf95IZ1uv/3gwcOMoo29Q4JEfPXSndhR5je
 WcrOMsfxAm1j0guOJg2BhTgkdQGwQMIVkQF5x2EpALqDaK+kbqA2UdURXzS6JqoalncIPoAois SgSxK1FaZsEHMAcSsm2iVLBhtE8oNYn8hIPcRWxE0PngXHbQg/iDLsnwBnEtit1UCAAA=
X-Change-Id: 20260831-pcie-link-endpoints-978e100d5d06
X-Mailer: b4 0.14.3
Message-ID: <20261125-pcie-link-endpoints-v8-0-19d49c17c05f@google.com>
Subject: [PATCH v8 0/3] PCI: Add Lane Margining at the Receiver debugfs interface
From: Priyank Rathod <rathodpriyank@google.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	"=?utf-8?q?Ilpo_J=C3=A4rvinen?=" <ilpo.jarvinen@linux.intel.com>, Lukas Wunner <lukas@wunner.de>, 
	Manivannan Sadhasivam <mani@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Shuah Khan <shuah@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, linux-pci@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Priyank Rathod <rathodpriyank@google.com>
Content-Type: text/plain; charset="utf-8"

Lane Margining at the Receiver lets software move the sampling point of
a receiver in time or in voltage while the link stays up, and read back
the errors the receiver sees, to find out how much margin a link running
at 16.0 GT/s or faster has.  pcilmr in pciutils does this today by
writing the capability registers directly from user space.

This series adds a debugfs interface for it.  The kernel sets the link
up for margining and puts it back afterwards:

  - ASPM is temporarily inhibited for the session with an internal
    reference-counted helper in the ASPM driver, Hardware Autonomous
    Width/Speed Disable are set on both ends, and both ends are kept
    runtime resumed.  All of this is undone when the session ends or
    either end of the link is removed.
  - Before each margining command, the link is checked against the
    state the session started in.
  - User space selects the receiver and the steps; the kernel does not
    run sweeps or interpret results.

Patch 1 adds the internal pcie_aspm_inhibit() helper in
drivers/pci/pcie/aspm.c, patch 2 adds the LMR debugfs interface and its
documentation, and patch 3 adds a kselftest.

The only PCI core changes outside drivers/pci/pcie/ are the init/exit
hooks in probe.c and remove.c and internal declarations in
drivers/pci/pci.h; drivers/pci/pci.c, drivers/pci/pci-driver.c, and
include/linux/pci.h are not changed.

Signed-off-by: Priyank Rathod <rathodpriyank@google.com>
---
Note on the v4, v5, and v6 reposts on Oct 6:
Apologies for posting v4, v5, and v6 within a four-hour window.  The
root cause was reacting immediately to each incremental automated
sashiko-bot report on the mailing list instead of running the full
review pass locally first and batching feedback into a single revision:

  1. v4 (16:09 UTC) reworked the series into two patches, dropping
     pcie_get_link_endpoints() and pci_aspm_inhibit() per Ilpo's review.
  2. v5 (17:35 UTC) was sent after sashiko-bot flagged
     'up=$([ "$rx" = 6 ] && echo "$dev" || echo "$partner")' in
     pcie_lmr.sh, mistaking the PCIe Upstream Port (receiver 6, the
     child device below the Downstream Port where aspm.c attaches the
     sysfs 'link/' directory via pcie_aspm_get_link()) for the
     Downstream Port.  Although the logic in v4 was right, v5 renamed
     'up' to 'child' and added a comment so human reviewers would not
     hit the same ambiguity.
  3. v6 (20:59 UTC) was sent after sashiko-bot flagged on v5 that
     pci_lmr_reboot_notify() used mutex_trylock(&port->lock) under
     pci_lmr_mutex and could skip resetting a port if a debugfs command
     was in flight during reboot/kexec.  v6 replaced that with a kref on
     struct pci_lmr_port and pci_lmr_end_sessions() so reboot/kexec
     waits for p->lock outside pci_lmr_mutex.

Changes in v8:
- Rebase onto v7.4-rc1.
- Replace pci_force_enable_link_state() and the bitmask return value of
  pcie_aspm_enabled() (both deferred before v7.4-rc1) with an internal
  reference-counted pcie_aspm_inhibit() helper in drivers/pci/pcie/aspm.c.
- Hold port->lock continuously across claiming and activating a session
  in pci_lmr_start(), recheck pci_lmr_rebooting under pci_lmr_mutex,
  wait on starting sessions in pci_lmr_find_session(), and drop runtime
  PM and partner references outside the device locks in pci_lmr_stop().
- Preserve unread too_many_errors status in PCI_LMR_LANE_STS when
  pci_lmr_sync_lane() resets software offsets for a lane.
- Link to v7: https://lore.kernel.org/r/20261012-pcie-link-endpoints-v7-0-36aba9c91f10@google.com

Changes in v7:
- Match PCI_LMR_LANE_RX | PCI_LMR_LANE_TYPE | PCI_LMR_LANE_PAYLOAD in
  pci_lmr_no_cmd() instead of U16_MAX, and format the error count in
  status_show() with %u and an explicit unsigned int cast.
- In pcie_lmr.sh, check all unreachable receiver numbers for the port
  type and, on a Downstream Port, discover any retimers on the link
  (receivers 2..5 via LNKSTA2), test caps and a timing step 1 -> 0
  round-trip on each present retimer receiver, and verify that absent
  retimer receivers are rejected with -EINVAL.
- Link to v6: https://lore.kernel.org/r/20261006-pcie-link-endpoints-v6-0-154d71657d32@google.com

Changes in v6:
- Add a kref on struct pci_lmr_port and use pci_lmr_end_sessions() in
  pci_lmr_reboot_notify() so reboot/kexec waits for in-flight commands
  outside pci_lmr_mutex (preserving the port->lock -> pci_lmr_mutex lock
  order) instead of skipping ports on mutex_trylock() failure.
- Link to v5: https://lore.kernel.org/r/20261006-pcie-link-endpoints-v5-0-c1e73235746b@google.com

Changes in v5:
- Clarify in pcie_lmr.sh why the sysfs 'link/' check targets receiver 6
  (and rename 'up' to 'child'): in PCIe terminology the Upstream Port
  (receiver 6) is the child device below the Downstream Port, and in
  drivers/pci/pcie/aspm.c aspm_ctrl_attrs_are_visible() looks up the
  link via pcie_aspm_get_link(pdev) -> pci_upstream_bridge(pdev)->link_state,
  so '/sys/bus/pci/devices/<dev>/link/' is attached to the child device
  below the Downstream Port, not to the Downstream Port itself.
- Link to v4: https://lore.kernel.org/r/20261006-pcie-link-endpoints-v4-0-ad5398c4260c@google.com

Changes in v4:
- Drop the exported pcie_get_link_endpoints(); the partner lookup is
  private to margin.c (Ilpo).
- Drop pci_aspm_inhibit() and all aspm.c changes.  Use
  pcie_aspm_enabled(), pci_disable_link_state() and
  pci_force_enable_link_state(), call neither when no ASPM state is
  enabled, and restore Clock PM when CLKREQ# was enabled.  ASPM Control
  is checked on both ends before each command.  The remaining
  differences after a session are documented.
- Remove the MSampleMultipleReceivers capability bit.
- One receiver per session, selected with a port-level 'receiver'
  file.  A session starts with receiver 1 on a Downstream Port and 6
  below it, as pcilmr does; receiver 0 is not used for margining.
- Add a per-lane 'status' file with the step response and error count,
  and a per-port 'port' file with the Margining Port bits.  Stop writing
  Margining Port Status.
- Locking: take both device locks with pci_dev_trylock() only while a
  session starts or stops, require both ends to be added, and make no
  runtime PM calls under the LMR locks.
- End sessions from pci_lmr_exit() for either end of the link.
- Commands fail with -EIO after a system suspend.
- Move debugfs to pcie_lmr_<device> at the debugfs root.
- Keep per-device state in margin.c instead of struct pci_dev.
- Split the selftest into its own patch, rename it pcie_lmr, use KTAP,
  and only start a session on the port named by PCIE_LMR_DEV.
- Refer to registers by name instead of specification section numbers.
- Link to v3: https://lore.kernel.org/r/20260904-pcie-link-endpoints-v3-0-4b9a91bd4b35@google.com

Changes in v3:
- Link to v2: https://lore.kernel.org/r/20260904-pcie-link-endpoints-v2-0-16fcb301a3e4@google.com

Changes in v2:
- Link to v1: https://lore.kernel.org/r/20260831-pcie-link-endpoints-v1-1-32c2fd893e9e@google.com

---
Priyank Rathod (3):
      PCI/ASPM: Add internal pcie_aspm_inhibit() helper
      PCI/LMR: Add Lane Margining at the Receiver debugfs interface
      selftests/pcie_lmr: Add tests for the Lane Margining debugfs interface

 Documentation/PCI/index.rst                  |    1 +
 Documentation/PCI/pcie-lmr.rst               |  155 +++
 MAINTAINERS                                  |    8 +
 drivers/pci/pci.h                            |   14 +
 drivers/pci/pcie/Kconfig                     |   11 +
 drivers/pci/pcie/Makefile                    |    1 +
 drivers/pci/pcie/aspm.c                      |   70 ++
 drivers/pci/pcie/margin.c                    | 1596 ++++++++++++++++++++++++++
 drivers/pci/probe.c                          |    1 +
 drivers/pci/remove.c                         |    1 +
 include/uapi/linux/pci_regs.h                |   18 +
 tools/testing/selftests/Makefile             |    1 +
 tools/testing/selftests/pcie_lmr/Makefile    |    3 +
 tools/testing/selftests/pcie_lmr/pcie_lmr.sh |  387 +++++++
 14 files changed, 2267 insertions(+)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20260831-pcie-link-endpoints-978e100d5d06

Best regards,
-- 
Priyank Rathod <rathodpriyank@google.com>


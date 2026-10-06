Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115F24A2A50
	for <linux-pci@vger.kernel.org>; Tue,  6 Oct 2026 17:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791308062; cv=none; b=UYfApsSDB9tuxtfcXWiGscUDOFqnuqTjEqPwXPTeXFrP/mwo6sR8e2mC4d69tgl18jaXnG0fyqR/IWGQhMEjp+sKuwiWeK2y2si3+5XX3dFGZRTFxEguJZZlWVNO2CUEgrN+LVu0sS0u0u6v3f2LzfiVcNitbvv4DZD5Tl/JuP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791308062; c=relaxed/simple;
	bh=6fokGtlocNvOTSB0Dhtrnq9A4Ao/nK05Q/BkT2zJ2E4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=i5x7Ijc9TmW/0ib/mbm54bKs6j5inClHzQF6KL4aGfVpBWLhxuwA+YUsaEQqUH0eozRgtZ6bui2597QTnw59NQXNkWMEFL1/f77i6hFhrdnvirCbnNHtV9jao3YK+a/mrnkdg/PJTeiQi6isd8rMxwhf5k+QMNyY6ogWgf2H0+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rathodpriyank.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TGzwgmnH; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rathodpriyank.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TGzwgmnH"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3a0be20102fso3039804a91.0
        for <linux-pci@vger.kernel.org>; Tue, 06 Oct 2026 10:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791308058; x=1791912858; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KjRlU2sZPuqprObDce5lyxEs4dRztB7t0cNy/bHqEEM=;
        b=TGzwgmnHvbRuLcjiWB692Ngmqo/gJFfANCSSs8gwcz5/5W7urkYpmnOBw5ypJBH9Tt
         rgjFM22zhmH/jd02QCHxtKRA7hwxB9BdoCJO7Ggy7Fidvx6w5oradhKim+0q6wGN5xDe
         dXlOueNV3QqeBnZh6aEGO7TQyK2kJc9QqzdHU6oTej+FG7KgCQHvUF3VZnx+JThqdK12
         xisA6grVhMuGLRULv6yZ0sqhJ6gmhFmm2nI5BqiqwT9+xqWS1RlkOirurfap1IBxTljb
         AjZIFXA27QcfWg8/xaEyMx0x5TiwD+WOxdd0LTkR1rIcW5isAEgR7T3owOV/wPr2dC+K
         2Prg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791308058; x=1791912858;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KjRlU2sZPuqprObDce5lyxEs4dRztB7t0cNy/bHqEEM=;
        b=P0+Eh3u/FVfyu6MBPEqQ8+H2IvIRpnIbQmviwhtiU2vQf7QsMEXkKeBhSujvoTrwmI
         c1dozlpX13MyXX4vjQfM1fSYal17WYldsTkWVRatsMXhbGXAJqyePFE9WwZeftVOjX/k
         sqmW6qw/TKBOLg0rtx8nzREdDpL7IUsquA/sMm6dJcmmdepFXDcaj0Pc0EympGz+rZnp
         /V0AoUNxdFEFTQ54peRRaLlU0TCmTuN4+MrjjuNjUPEOMTHk/l+Xf2yvypAc9G4ogjXk
         JQzyFMnhE35r7aQNXvXr+F5g1c7QqoV5BSFT4arTI1lWYyH1QSP5HLApRwRpaOY/zD/c
         PEPA==
X-Forwarded-Encrypted: i=1; AKwUvBwXfsHDW3nm3AXe/DzFJ9AsBLTwirqDPuW+7thuBGSQj0uILurgwQafy3MqBMN+ThvwIEeMugK+swc=@vger.kernel.org
X-Gm-Message-State: AFq9FYJZptFZ//66bnmXa/J9Pn4uRX/N8TQefY/IG/VXwq83SRrh5ouT
	zmXMTKwbRruzuFzvJ4tbFc0DIa5EqKKEJXjbAiWyrQslEJg4F4CirdIOii4dmFW9/9TApWx6I44
	Yk9TQZ408lTP5tchQgYmitg49ktBZMr0riQ==
X-Received: from pggj21.prod.google.com ([2002:a63:cf15:0:b0:cc7:e6e5:e624])
 (user=rathodpriyank job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:1117:b0:3a0:97ba:cc05 with SMTP id 98e67ed59e1d1-3a799bd3f13mr6179238a91.22.1791308057981;
 Tue, 06 Oct 2026 10:34:17 -0700 (PDT)
Date: Tue, 06 Oct 2026 17:34:16 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIABgxxWoC/43QQQrCMBAF0KtI1o4kmbQ2rryHuGiTaR3UpDRSF
 OndjS4UUcTl/zDvw1xFooEpidXsKgYaOXEMORTzmXC7OnQE7HMWWupSVqigd0xw4LAHCr6PHE4
 J7LIiJaUvvCxFvuwHavn8UDfbnHecTnG4PEZGdW9/e6MCBaidbn1lkSytuxi7Ay1cPIo7OOoXY
 qX5jmiQoMrWNShVjWQ+EPwDwYyYxtZWNd40WHwg5onkD5TfEZOR2hdoK2fymHtDpmm6AQ9InIa GAQAA
X-Change-Id: 20260831-pcie-link-endpoints-978e100d5d06
X-Mailer: b4 0.14.3
Message-ID: <20261006-pcie-link-endpoints-v5-0-c1e73235746b@google.com>
Subject: [PATCH v5 0/2] PCI: Add Lane Margining at the Receiver debugfs interface
From: Priyank Rathod <rathodpriyank@google.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "=?utf-8?q?Ilpo_J=C3=A4rvinen?=" <ilpo.jarvinen@linux.intel.com>, Lukas Wunner <lukas@wunner.de>, 
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

  - ASPM is turned off for the session with the existing ASPM API,
    Hardware Autonomous Width/Speed Disable are set on both ends, and
    both ends are kept runtime resumed.  All of this is undone when
    the session ends or either end of the link is removed.
  - Before each margining command, the link is checked against the
    state the session started in.
  - User space selects the receiver and the steps; the kernel does not
    run sweeps or interpret results.

Patch 1 adds the interface and its documentation, patch 2 a kselftest.

The only PCI core changes are the init/exit hooks in probe.c and
remove.c and their prototypes in drivers/pci/pci.h.  aspm.c, pci.c and
include/linux/pci.h are not changed.

Signed-off-by: Priyank Rathod <rathodpriyank@google.com>
---
Changes in v5:
- Clarify in pcie_lmr.sh that the sysfs 'link/' directory is on the
  child device (PCIe Upstream Port, receiver 6) via
  pcie_aspm_get_link(), and rename 'up' to 'child'.
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
  and a 'port' file with the Margining Port bits.  Stop writing
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
Priyank Rathod (2):
      PCI/LMR: Add Lane Margining at the Receiver debugfs interface
      selftests/pcie_lmr: Add tests for the Lane Margining debugfs interface

 Documentation/PCI/index.rst                  |    1 +
 Documentation/PCI/pcie-lmr.rst               |  162 +++
 MAINTAINERS                                  |    8 +
 drivers/pci/pci.h                            |    8 +
 drivers/pci/pcie/Kconfig                     |   11 +
 drivers/pci/pcie/Makefile                    |    1 +
 drivers/pci/pcie/margin.c                    | 1590 ++++++++++++++++++++++++++
 drivers/pci/probe.c                          |    1 +
 drivers/pci/remove.c                         |    1 +
 include/uapi/linux/pci_regs.h                |   18 +
 tools/testing/selftests/Makefile             |    1 +
 tools/testing/selftests/pcie_lmr/Makefile    |    3 +
 tools/testing/selftests/pcie_lmr/pcie_lmr.sh |  311 +++++
 13 files changed, 2116 insertions(+)
---
base-commit: 1ee0e2a03ac539c90fd9b8a644ae983a2216b58c
change-id: 20260831-pcie-link-endpoints-978e100d5d06

Best regards,
-- 
Priyank Rathod <rathodpriyank@google.com>


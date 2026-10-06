Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0AA49C4A3
	for <linux-pci@vger.kernel.org>; Tue,  6 Oct 2026 16:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791303112; cv=none; b=atIdxWATjxyKkLjM1p57aTdbryBdI0cNk3Pq7/gj1iY3P2hyXgYJI7jMY5AGv6iRpSY8EKNRJg4N69OguKEt0oz8pwyhUAeDXgWUDujjOk7mBlvFmZDhtC2nIygF1Tvy4jYl2HkhwCgf3lXNyaSibwGaOeOpce6paVPv9kqSgcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791303112; c=relaxed/simple;
	bh=gx2iDOZ2r4lzRV7BDEcamG2oHP9rEjFLyQFQcTeg7P8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=oeLmNWol3yOozSdaxfv5Sv7t9BHbimrRvTU/DeYK1A7F0/KeVzFmbZDtZG0NQzjollxk9Wo2+CMVmW4Kgk0mFsMwynzS+pQ0wXMJWYMG8bxJK+zcnWPC3jtkCsDPbA9PCPjtE91zHKDg5W8bl4hwriFPKfrUUvadx722SSboyrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rathodpriyank.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jrY2aUKf; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rathodpriyank.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jrY2aUKf"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2e594a90232so31133865ad.2
        for <linux-pci@vger.kernel.org>; Tue, 06 Oct 2026 09:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791303110; x=1791907910; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mjMt+KUzuNcKjCA07JDkaeow92GRj5gNqogfhdzmarM=;
        b=jrY2aUKfOBt22ThXCVtHNVc6eWyPHaUHDBCgF/F+7tqHhjMmJ/Ol4+/C0UOtpiLTsE
         u+6NNLSBsKTtk+5MBTXsJqH22s0m5rDlq4mnWb675KiTW+jPFdE5PgTR8b4UHRgxIAeE
         s3eeo482usVhs5pJkzw3lOOfYgGussqx6xlNHGOA+ZSp3YiwjVZ9mFhWAnJubZBBV74N
         2yGOD1wFcht58FUaPInp+cdGGixI+MPt2nBaSYANHU6Hk5yoRU5O8ql+jWlfUeyCrF7e
         B8gNLV0hFMYScpkVNbv5m0I1YzU3l7B53Xrh37FcYVJ0HOffdIH7TNXUdFsC04fUzwbm
         34rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791303110; x=1791907910;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mjMt+KUzuNcKjCA07JDkaeow92GRj5gNqogfhdzmarM=;
        b=B8CBNVuXhIz3W4omFKhigjpTuka9XvnqjHyL51PibgSX4E59My+ENRaQRUPWsLMCvF
         HUBK3CQ07d4gH4N2WKHzq3WhVAwXO8Y6PFSFp2I82Yj6f77LLyTuXPFLn4RfL758NYJ/
         oYtMrSSRMk0eoUfTBN9KkEpKRNAipiWNr4fKeXtZudyD7UrRCCf/gVkssbpcxSQrlMeQ
         pDxYpEgs9wAMcg0ITvpjyIuMSSbP5BxaYbqLcVyqCaehb5Dc1alcQpdym1Poii+d61qh
         OT+wQkH85o0FTYKsVQAZSQgLX+ea6AXh0MNOmWgcv8jrzfDKiJg/HMx25jlfxK7oRfQD
         1gcw==
X-Forwarded-Encrypted: i=1; AKwUvBwQLkuUuCaGrdrirA5+gPLNGBBk2biVjojVv3JBUdoLyfK9dWhMNUYLqOnxoo4NHvSx1+dJIvTeV9M=@vger.kernel.org
X-Gm-Message-State: AFq9FYKtqCWekazxt05ctoVfxvtX/inSETKGg4dyIX1ZBhBK+6Ub5GDI
	OqCRVwbpUF7u+e65eo7CROktnhlN5qY/1BqrH6puMmltW8ew2rZq1cjsuh9qD+tucgr40rua4Hx
	TV9TBGK20AUxZvvT3pVc8kZwiV+ylBwgwzw==
X-Received: from plblm13.prod.google.com ([2002:a17:903:298d:b0:2e5:b835:73bd])
 (user=rathodpriyank job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:d584:b0:2e2:d8f7:9f54 with SMTP id d9443c01a7336-2e5dcd8f1b0mr14137025ad.19.1791303109716;
 Tue, 06 Oct 2026 09:11:49 -0700 (PDT)
Date: Tue, 06 Oct 2026 16:11:48 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAMQdxWoC/43NTQ6CMBCG4auQrh3TP5C68h7GBbQDTMSWUEM0h
 rtb2BijMS7fL5lnHiziSBjZPnuwESeKFHwKvcmY7SrfIpBLzSSXBS+VgMESQk/+DOjdEMhfI5h
 diYJzlztesHQ5jNjQbVWPp9QdxWsY7+uTSSzrb28SIEBJKxtXGoUGD20IbY9bGy5sASf5QgzX3 xEJHETR2FpxUSnUH4j6A1EJ0bWpjKidrlX+hszz/AQx96+AQQEAAA==
X-Change-Id: 20260831-pcie-link-endpoints-978e100d5d06
X-Mailer: b4 0.14.3
Message-ID: <20261006-pcie-link-endpoints-v4-0-ad5398c4260c@google.com>
Subject: [PATCH v4 0/2] PCI: Add Lane Margining at the Receiver debugfs interface
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
 tools/testing/selftests/pcie_lmr/pcie_lmr.sh |  304 +++++
 13 files changed, 2109 insertions(+)
---
base-commit: 1ee0e2a03ac539c90fd9b8a644ae983a2216b58c
change-id: 20260831-pcie-link-endpoints-978e100d5d06

Best regards,
-- 
Priyank Rathod <rathodpriyank@google.com>


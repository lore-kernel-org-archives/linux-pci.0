Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA314BFE73
	for <linux-pci@vger.kernel.org>; Mon, 12 Oct 2026 17:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791826636; cv=none; b=BPMwXStSeF8AJ964lwIIOwBe3gs1QWoiJ3D8ich6svMkXxqcJbSnqy7OIjziyJtYJJrGlZ7u+T9Y+5DOLAPI/gCQGJSHI7uE50OF/i0zwNKCXABa4uc1N+NdZkaITCCO9U7etZeY8H9qjM6MqM0OQkePkoJph/2fVfBQ4Osh/hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791826636; c=relaxed/simple;
	bh=amIZJmBUUXhxDcR5QOQmEoD744URbvQuc8n+Jm98AYE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=PeYtiEt5bEnRi16LapJobIiEYmSJQm5eVULVghb5vHIv8txxeRli2/qhcnCcMVzhy0ipOHzwi847aSqTW8salMJmtYrGh1mz/2mkJuzAXiLAE4Y01X+7/EdtsrMsdt8JKnGDXbeNc0YuySaRBlsGFzL+jVWwtd8ia3vgNVVYrb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rathodpriyank.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rokl3HEO; arc=none smtp.client-ip=74.125.82.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rathodpriyank.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rokl3HEO"
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-147be78cd56so8778795c88.1
        for <linux-pci@vger.kernel.org>; Mon, 12 Oct 2026 10:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791826633; x=1792431433; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OtXuplYhHKC1prNv7+Ztcv/iUX/n6tMeDLdrOYA/GqQ=;
        b=rokl3HEOavbOJda9GmUMwWJ7jyvKG9jvZZUuQbcrfJUamc7IRaZH5sojYGOgh0+Qrm
         zdganloQhdU/PbwBDYakgW9dVrYfEYng0kzMdNe1RYEopjJ3rJPqx5BK6Rc5TfrOf1nd
         PxUmkW6lZOuJjKDNf/OmQbOnZSrpSpECtL4yFIK4TETvXkeejzO181po1P3CbE3SS0K2
         8z/cn/wma82nDaIVls+YmbFqowPPK5FsQ/7SlOztHygE8XZpNtHCqgj0FCopJdIONYt/
         ch9IdOJ4F+kZlDsfOQmcwu1n0wWltva5g9g5voCkQXKfbDdZdP/H9ARRkmaU4tXRams2
         mESg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791826633; x=1792431433;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OtXuplYhHKC1prNv7+Ztcv/iUX/n6tMeDLdrOYA/GqQ=;
        b=JJPIX42NqzUaiS6P2dr9S3dT/ef8UxIdX/serHxc6JfT5V8WnFusoDcMkhfSvPeTtm
         HqNIKC1DYlsrjQ9Ryqk/RPJOtM8s60fRoVokUzbl2Xk+n0k1jcuAph7LhAvr7+/FOjMe
         ImgwXED2TCTHHRKunSIgI8e6GlP4Exg2Qb0GKDDGrYvaZscmCaYD4PNxqbepAg4fc+Ku
         9Ij2Sa4e8by7y2CVXdoGuRWHS1ezyO/QPOje88W35nQAjtqGdj6j5tRMD7X9FTul4uAX
         +vHkb50nzPrz+4RiirG7X35KTBiqhc+9rXYJ5RCRKoEpFkFWZg6E8eXS3v3rR+9zTJiu
         ZWZw==
X-Forwarded-Encrypted: i=1; AKwUvBxZo9ZUMAyS0P3oQLGVkNX9I/XBHH7pxwlyvPTtJjnH+KAWGFehPYUWL8tx4Eo9141azmGPnSBVzjg=@vger.kernel.org
X-Gm-Message-State: AFq9FYKmmc9aza6RqEhAoUYrN8AejQvSgUzvLDfg3BDpOKagI1WieIBb
	sMpXt5fJfq3tFTZWNwnxr4qmzXW6TjMaLUfMO34zUxizxzA/xWuP6Iq1yer4grDRGvSkl6cCo5m
	4hO8NPU1KYL9SvQGfl+ZrOl78ULN6fcTGNw==
X-Received: from dly17-n2.prod.google.com ([2002:a05:701b:2051:20b0:15d:8925:57c3])
 (user=rathodpriyank job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:701a:c901:b0:143:26cf:8617 with SMTP id a92af1059eb24-16a6337f340mr14948670c88.25.1791826632397;
 Mon, 12 Oct 2026 10:37:12 -0700 (PDT)
Date: Mon, 12 Oct 2026 10:36:34 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAKIazWoC/43QTWrDMBAF4KsEraui0ejHyqr3KFnY0tgRTSVjB
 ZMSfPfKWbQUh+LlG5jvwbuzQlOkwo6HO5tojiXmVIN9OTB/btNAPIaamRTSiAaBjz4Sv8T0wSm
 FMcd0LdzZhkCIoIMwrH6OE/Xx9lDfTzWfY7nm6etRMsN6/d+bgQNH6WUfGofk6G3IebjQq8+fb
 AVn+Ys4oZ4jkgsOpvcdCmiR1AbBHQhWRHWuddAF1aHeIOoHqQuY54iqSBs0usarWuY3iN6B6Ip 4IIsStVWm2yBmB2LWTbQKFoy2AeUfZFmWbxUt2xIQAgAA
X-Change-Id: 20260831-pcie-link-endpoints-978e100d5d06
X-Mailer: b4 0.14.3
Message-ID: <20261012-pcie-link-endpoints-v7-0-36aba9c91f10@google.com>
Subject: [PATCH v7 0/2] PCI: Add Lane Margining at the Receiver debugfs interface
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
Note on the v4, v5, and v6 reposts on Oct 6:
Apologies for posting v4, v5, and v6 within a four-hour window.  The
root cause was that I was inside an automated AI review-and-fix loop and
reacted immediately to each incremental sashiko-bot report on the
mailing list instead of running the full local Sashiko review pass first
and batching all updates into a single revision:

  1. v4 (16:09 UTC) reworked the series into two patches, dropping
     pcie_get_link_endpoints() and pci_aspm_inhibit() per Ilpo's review.
  2. v5 (17:35 UTC) was sent after the sashiko-bot AI review flagged
     'up=$([ "$rx" = 6 ] && echo "$dev" || echo "$partner")' in
     pcie_lmr.sh as a bug, claiming that the sysfs 'link/' ASPM
     attributes live on the Downstream Port (Root Port / Switch
     Downstream Port) and that 'up' resolved to the Endpoint instead.
     That AI review finding was a false positive:
       - In PCIe specification terminology, the Upstream Port is
         receiver 6 (the port on the child device facing upstream
         toward the Root Complex, i.e. the Endpoint or Switch Upstream
         Port), while receiver 1 is the Downstream Port.
       - In drivers/pci/pcie/aspm.c, aspm_ctrl_attrs_are_visible()
         calls pcie_aspm_get_link(pdev), which looks up
         pci_upstream_bridge(pdev)->link_state.  For a Downstream Port,
         pci_upstream_bridge() is NULL (on a Root Port) or points to
         the parent switch's Upstream Port, so the sysfs 'link/'
         directory for the link is registered on the child device below
         the Downstream Port (receiver 6), exactly as v4 had written.
     Even though the v4 logic was right, I renamed 'up' to 'child' and
     added an explicit comment in v5 explaining both the PCIe port
     terminology and pcie_aspm_get_link() so that the Sashiko review
     would pass cleanly and human reviewers would not hit the same
     ambiguity.
  3. v6 (20:59 UTC) was sent after sashiko-bot flagged on v5 that
     pci_lmr_reboot_notify() used mutex_trylock(&port->lock) under
     pci_lmr_mutex and could skip resetting a port if a debugfs command
     was in flight during reboot/kexec.  Even though user space is
     normally frozen before reboot notifiers run, I fixed it properly
     by adding a kref on struct pci_lmr_port and pci_lmr_end_sessions()
     so reboot/kexec waits for p->lock outside pci_lmr_mutex and passes
     Sashiko with zero issues.

Changes in v7:
- Replace the 3-state enum pci_lmr_state with bool active, hold
  port->lock across pci_lmr_activate() while re-checking
  pci_dev_is_added() on both ends under pci_lmr_mutex when marking a
  session active, unify pci_lmr_stop() with pci_lmr_end_sessions(), and
  hold pci_dev_get() references on port->dev and port->dport until
  pci_lmr_port_free().
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
Priyank Rathod (2):
      PCI/LMR: Add Lane Margining at the Receiver debugfs interface
      selftests/pcie_lmr: Add tests for the Lane Margining debugfs interface

 Documentation/PCI/index.rst                  |    1 +
 Documentation/PCI/pcie-lmr.rst               |  162 +++
 MAINTAINERS                                  |    8 +
 drivers/pci/pci.h                            |    8 +
 drivers/pci/pcie/Kconfig                     |   11 +
 drivers/pci/pcie/Makefile                    |    1 +
 drivers/pci/pcie/margin.c                    | 1551 ++++++++++++++++++++++++++
 drivers/pci/probe.c                          |    1 +
 drivers/pci/remove.c                         |    1 +
 include/uapi/linux/pci_regs.h                |   18 +
 tools/testing/selftests/Makefile             |    1 +
 tools/testing/selftests/pcie_lmr/Makefile    |    3 +
 tools/testing/selftests/pcie_lmr/pcie_lmr.sh |  387 +++++++
 13 files changed, 2153 insertions(+)
---
base-commit: 591d89f23a7cbc668579521513c7f53b0968754c
change-id: 20260831-pcie-link-endpoints-978e100d5d06

Best regards,
-- 
Priyank Rathod <rathodpriyank@google.com>


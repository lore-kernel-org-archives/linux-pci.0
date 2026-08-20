Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD33D3B71AA
	for <linux-pci@vger.kernel.org>; Thu, 20 Aug 2026 21:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787261927; cv=none; b=ldNfF73kB2p7zfBdAHl1Z/qvK3bGQEsUkrrvH91T6nDeJK6GIo/1u74zNI2nIhiX4nOIG8e4uqYn9x4EmsxLOSBbELyfmE0roEFAn8zewpASPx3pw2dbGTNRanVySsW/AMTRUqAJff0MD7xR8tSnY8w7Z59IczeulIVy/MquUVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787261927; c=relaxed/simple;
	bh=82nLTxTAEjtMuo80UXhb+ZJbUMis5GOhILfK4UMm7LY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=bjGfMcwTbfO8nDtGwI0XX3z5nb1PMMHKny4hR84oG76wUqVvpvLrV28OAl56baOr1BbY7Ya2XOpCl0pXn0wCU5cOxlf8Xx5hU3VLSp7tUW1gdczHAGraR71wTzkUJ8ygznNIzykfuYZJa6++72cHb50tdOu+6ZeF+WpeGmL7ZSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rathodpriyank.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KDytz8Og; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rathodpriyank.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KDytz8Og"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2d52734fc41so7436825ad.1
        for <linux-pci@vger.kernel.org>; Thu, 20 Aug 2026 14:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787261923; x=1787866723; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=UA+Y13vyPkgKjVmw0h9G+mUIqkQO2nULYOknRIguhp4=;
        b=KDytz8OgFdVlm1ojuhJUOvQSGr/7L77inFI0FM0YMoe5qO6y2jWpl7eEBsCAVaN7Vj
         iolcnRzzpRbDG4NNGTBhm/H9+h0VzP75Hc15Om0eeXSWYJrI8WNcmDGyNnnIKtUG+WHb
         /99Kt3nnlIZMoyeQt92hEGzpK2omsyOimbqUDP6/NZFCDJ71ssG78EgYl7UfNTO4hMbS
         g6TXj9FUkRWmUc4Bw7wIK34HNP15iyJv3UV70umqWkVVahKK+K9iMVPIz7SRjcSRus0v
         kX9MpOgm8MHKyYGcgx1kvYs51mK854kXOK9Os6SMaL3Yu4b0VlnkMtMkGk7qwooAukRI
         fRAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787261923; x=1787866723;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UA+Y13vyPkgKjVmw0h9G+mUIqkQO2nULYOknRIguhp4=;
        b=GdSR61JPJMTLY13lFumuZPEnqa5mggPH4Y+mMAZySMIMuUf1okYG9pOCgN4jtzGjL0
         Lt4GHODPqoIZMopPgTlEvlqKhdIyiBpzKStUT3ktcp8MnRv3TmFUi/NqrhicPRmaCZuN
         qyBSL/XqWnYnGmwC/XGGNz+xCZsoS8HdoGkKoyNAKk1MznQ4jzIlxOulSVIr24n240yw
         bWPRaAqlZUjNc+frouTKwjIUihyd0T/MW80S6N7Hjyqw5ETELAZGPTbVR9bKYziDQNdP
         pCYcg2PyJnpG63TFncU/7n+T+IaQ/XY7bC9puP5+4mPdAdeTdoRrU3Ao2aKykMXPeVkA
         S4Aw==
X-Forwarded-Encrypted: i=1; AHgh+RqQmoAI7OBjSLms61CcYr0ncAWxDzZZpfnRL5MJKJ0RTpCJkVUpxs8pBDrth4IDT5sOobjYH7MoTew=@vger.kernel.org
X-Gm-Message-State: AFuF++m1QGZDDXqrd1cxdfzxzUbpLi+46lMGEvj+V54foaR4agx357hl
	0S4++IlUlVs+qOZX1AQRiMH3PTyAOsTTRZT3IhfGH1XnIJGdv6NFCSuC3gn/u7JybFWhVwQhQL3
	rGOQalvLJkoraX3V6gt9VgNztpB1BOMVFUA==
X-Received: from plog18.prod.google.com ([2002:a17:902:8692:b0:2cf:2c6d:ddb8])
 (user=rathodpriyank job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:2408:b0:2d5:ccb7:12c3 with SMTP id d9443c01a7336-2d64ada2445mr35001445ad.2.1787261922702;
 Thu, 20 Aug 2026 14:38:42 -0700 (PDT)
Date: Thu, 20 Aug 2026 21:38:35 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIANpzh2oC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyTHUUlJIzE
 vPSU3UzU4B8JSMDIzMDC0ML3YLkzFTdnNwSXWMDE5MUUwuzxMTUZCWg8oKi1LTMCrBR0bG1tQA qWUXKWgAAAA==
X-Change-Id: 20260818-pcie-lmt-3044d586aaec
X-Mailer: b4 0.14.3
Message-ID: <20260820-pcie-lmt-v5-1-943b3b0e18bf@google.com>
Subject: [PATCH v5] PCI/pcie: Add PCIe Lane Margining at Receiver (LMR) support
From: Priyank Rathod <rathodpriyank@google.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Priyank Rathod <rathodpriyank@google.com>, 
	Shuah Khan <shuah@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-hardening@vger.kernel.org, 
	"=?utf-8?q?Ilpo_J=C3=A4rvinen?=" <ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Per PCIe Base Specification r6.0, sec 8.4.4 ("Lane Margining at
Receiver"), PCIe devices operating at 16.0 GT/s (Gen 4) or higher data
rates support the Lane Margining at Receiver Extended Capability
(ID 0x27), and it is mandatory for receivers operating at 64.0 GT/s
(Gen 6) or higher data rates. Lane Margining allows software to
evaluate high-speed link margins by measuring timing and voltage steps
for each individual physical lane and receiver.

Add driver and debugfs support for PCIe Lane Margining at Receiver:

  - Add Lane Margining at Receiver Extended Capability register
    definitions (PCI_EXT_CAP_ID_LMR, PCI_LMR_PORT_CAP, PCI_LMR_PORT_STS,
    PCI_LMR_LANE_CTRL, PCI_LMR_LANE_STS) to <uapi/linux/pci_regs.h>.
  - Add Kconfig option CONFIG_PCIE_LMR (under drivers/pci/pcie/Kconfig)
    dependent on DEBUG_FS.
  - Implement drivers/pci/pcie/margin.c to probe the capability on Gen4+
    links and expose per-device debugfs entries under:
      /sys/kernel/debug/pci/pcie_lmr_<pci_dev_name>/
    providing control over margining enablement, receiver selection, and
    execution of timing/voltage margin step commands. Distinguish
    between missing mandatory LMR capability on Gen6+ vs optional on
    Gen4/Gen5.
  - Hook pci_lmr_init() into pci_init_capabilities() during device probe
    in drivers/pci/probe.c and pci_lmr_exit() into drivers/pci/remove.c.
  - Add kselftest script under tools/testing/selftests/pcie_lmt/pcie_lmt.sh
    to test debugfs capability reads, enablement, and stepping.
  - Add MAINTAINERS entry for PCIe Lane Margining at Receiver (LMR).

Signed-off-by: Priyank Rathod <rathodpriyank@google.com>
---
Per PCIe Base Specification r6.0, section 8.4.4 ("Lane Margining at Receive=
r"),
PCIe devices operating at 16.0 GT/s (Gen 4) or higher data rates support th=
e
Lane Margining at Receiver Extended Capability (ID 0x27), and it is mandato=
ry
for receivers operating at 64.0 GT/s (Gen 6) or higher data rates.

Lane Margining allows system software to evaluate high-speed link signal
integrity and margins by measuring timing and voltage steps for each physic=
al
lane and receiver independently.

This series introduces kernel driver support, debugfs controls, and a
kselftest automation script for PCIe Lane Margining at Receiver (LMR/LMT).

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
1. How to Enable & Configure
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
Enable the Kconfig option under PCI support:
  CONFIG_PCIE_LMR=3Dy (or =3Dm)
  (Depends on CONFIG_PCI and CONFIG_DEBUG_FS)

Upon boot or device hotplug on Gen4+ links (>=3D 16.0 GT/s), the driver pro=
bes
Extended Capability ID 0x27 and exposes per-device debugfs interfaces:
  /sys/kernel/debug/pci/pcie_lmr_<domain>:<bus>:<dev>.<func>/

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
2. How to Use the Debugfs Interface (Manual Margining)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
Inspect device-wide margining capabilities and port status:
  # Inspect root device LMR capabilities & status
  cat /sys/kernel/debug/pci/pcie_lmr_0000:01:00.0/capabilities
  cat /sys/kernel/debug/pci/pcie_lmr_0000:01:00.0/port_status

Enable active Lane Margining on the device:
  # Enable Lane Margining state machine
  echo 1 > /sys/kernel/debug/pci/pcie_lmr_0000:01:00.0/enable

Inspect and step individual lanes (e.g. lane0):
  # Select target receiver (0 =3D local receiver, 1..6 =3D retimers/link pa=
rtners)
  echo 0 > /sys/kernel/debug/pci/pcie_lmr_0000:01:00.0/lane0/receiver

  # Check available timing and voltage steps for this receiver
  cat /sys/kernel/debug/pci/pcie_lmr_0000:01:00.0/lane0/caps
  cat /sys/kernel/debug/pci/pcie_lmr_0000:01:00.0/lane0/num_timing_steps
  cat /sys/kernel/debug/pci/pcie_lmr_0000:01:00.0/lane0/num_voltage_steps

  # Step timing margin or voltage margin offset
  echo 2 > /sys/kernel/debug/pci/pcie_lmr_0000:01:00.0/lane0/margin_timing
  echo 1 > /sys/kernel/debug/pci/pcie_lmr_0000:01:00.0/lane0/margin_voltage

  # Reset margin offset back to nominal (0)
  echo 0 > /sys/kernel/debug/pci/pcie_lmr_0000:01:00.0/lane0/margin_timing
  echo 0 > /sys/kernel/debug/pci/pcie_lmr_0000:01:00.0/lane0/margin_voltage

Disable Lane Margining when finished:
  echo 0 > /sys/kernel/debug/pci/pcie_lmr_0000:01:00.0/enable

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
3. How to Run Automated Kselftests Using the Test Script
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
An automated kselftest script is included to test capability reads, receive=
r
selection, and margining commands across all enumerated LMR devices:

  # Run directly as root
  sudo ./tools/testing/selftests/pcie_lmt/pcie_lmt.sh

Or run via the kselftest Makefile harness:
  make -C tools/testing/selftests TARGETS=3Dpcie_lmt run_tests

Sample script output on an LMR-capable device:
  pcie_lmt: testing PCIe LMR debugfs entries
  pcie_lmt: probing device pcie_lmr_0000:01:00.0
    pcie_lmr_0000:01:00.0: capabilities read OK
    pcie_lmr_0000:01:00.0: port_status read OK
    pcie_lmr_0000:01:00.0: margining enabled OK
    pcie_lmr_0000:01:00.0: testing lane0
    pcie_lmr_0000:01:00.0: testing lane1
    pcie_lmr_0000:01:00.0: margining disabled OK
  pcie_lmt [PASS]

To: Bjorn Helgaas <bhelgaas@google.com>
To: Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
Cc: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

Changes in v5:
  - Sorted #include directives alphabetically and added missing includes fo=
r bits.h, bitfield.h, cleanup.h, overflow.h, and slab.h (Ilpo J=C3=A4rvinen=
).
  - Converted bitmasks to GENMASK() and BIT() macros and used FIELD_PREP() =
and FIELD_GET() instead of manual bit shifts (Ilpo J=C3=A4rvinen).
  - Added pci_lmr_sts_payload() helper to cleanly extract the status payloa=
d byte before applying step and capability masks (Ilpo J=C3=A4rvinen).
  - Replaced manual mutex locking sequences with guard(mutex)(&mdev->lock) =
across show and write callbacks to simplify control flow (Ilpo J=C3=A4rvine=
n).
  - Documented mutex lock protection scope in kerneldoc for struct pci_marg=
in_dev (Ilpo J=C3=A4rvinen).
  - Used standard PCI_POSSIBLE_ERROR(), str_yes_no(), and scnprintf() helpe=
rs throughout the driver (Ilpo J=C3=A4rvinen).
  - Clarified receiver range (0..6 per PCIe r6.0 sec 8.4.4; 7 reserved) in =
comments and validation checks (Ilpo J=C3=A4rvinen).
  - Deduplicated timing and voltage show/write handlers using margin_lane_s=
teps_show() and margin_lane_step_write() (Ilpo J=C3=A4rvinen).
  - Placed speed check immediately following pcie_get_speed_cap() and handl=
ed PCI_SPEED_UNKNOWN (Ilpo J=C3=A4rvinen).
  - Converted lanes in struct pci_margin_dev to a flexible array member wit=
h __counted_by(num_lanes) allocated via struct_size() (Ilpo J=C3=A4rvinen).

Changes in v4:
  - Added Sample Multiple Receivers (Bit 5) concurrency verification in mar=
gin_lane_timing_write() and margin_lane_voltage_write() per PCIe r6.0 sec 8=
.4.4, returning -EBUSY if another lane on the same receiver is already marg=
ined when simultaneous lane margining is not supported.
  - Added active operating link speed verification (PCI_EXP_LNKSTA_CLS >=3D=
 16.0 GT/s) in margin_enable_write() before enabling LMR, as LMR commands a=
re physically undefined on links operating at Gen1/Gen2/Gen3 speeds.
  - Added fast-path hardware NAK detection in pci_lmr_run_cmd() to return -=
EOPNOTSUPP immediately if a receiver echoes MTYPE =3D=3D NO_CMD (0x7) after=
 command issuance rather than waiting 150ms for a timeout.
  - Added pci_reset_lmr() hooked into __pci_reset_function_locked() to sync=
hronize software state and demargin on FLR or Secondary Bus Reset.
  - Comprehensive NULL pointer checks and array/lane/receiver bounds checks=
 added across all internal helpers and debugfs write handlers.
  - Added MAINTAINERS entry for PCIe Lane Margining at Receiver (LMR).

Changes in v2:
  - Fixed NO_CMD (0x7) clearing in pci_lmr_run_cmd() before issuing new com=
mands per PCIe r6.0 sec 8.4.4.
  - Protected plane->rx updates with mdev->lock in margin_lane_receiver_wri=
te().
  - Corrected Margining Port Capabilities bit definition to PCI_LMR_PORT_CA=
P_USES_SW_READY (0x0001) in <uapi/linux/pci_regs.h>.
  - Updated kselftest script (pcie_lmt.sh) to locate LMR debugfs entries.
  - Validated integer bounds against LMR_MAX_TIMING_STEP / LMR_MAX_VOLTAGE_=
STEP before narrowing u8 cast.
  - Moved mdev->enabled checks inside mutex_lock(&mdev->lock) to eliminate =
TOCTOU races.
  - Checked return values of all pci_read_config_word() calls, propagating =
-EIO on failure.
  - Eliminated dead store of cap in margin_enable_write().
  - Explicitly checked speed =3D=3D PCIE_SPEED_64_0GT in pci_lmr_init() to =
avoid misidentifying PCI_SPEED_UNKNOWN (0xFF) as Gen6.
---
 MAINTAINERS                                  |   7 +
 drivers/pci/pci-driver.c                     |   1 +
 drivers/pci/pci.c                            |   4 +-
 drivers/pci/pci.h                            |  12 +
 drivers/pci/pcie/Kconfig                     |  12 +
 drivers/pci/pcie/Makefile                    |   1 +
 drivers/pci/pcie/margin.c                    | 970 +++++++++++++++++++++++=
++++
 drivers/pci/probe.c                          |   1 +
 drivers/pci/remove.c                         |   1 +
 include/linux/pci.h                          |   6 +
 include/uapi/linux/pci_regs.h                |  18 +
 tools/testing/selftests/Makefile             |   1 +
 tools/testing/selftests/pcie_lmt/Makefile    |   3 +
 tools/testing/selftests/pcie_lmt/pcie_lmt.sh | 105 +++
 14 files changed, 1141 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b7094a616afd..2935b624ac67 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21059,6 +21059,13 @@ F:	Documentation/devicetree/bindings/pci/qcom,sa82=
55p-pcie-ep.yaml
 F:	drivers/pci/controller/dwc/pcie-qcom-common.c
 F:	drivers/pci/controller/dwc/pcie-qcom-ep.c
=20
+PCIE LANE MARGINING AT RECEIVER (LMR)
+M:	Priyank Rathod <rathodpriyank@google.com>
+L:	linux-pci@vger.kernel.org
+S:	Maintained
+F:	drivers/pci/pcie/margin.c
+F:	tools/testing/selftests/pcie_lmt/
+
 PCMCIA SUBSYSTEM
 M:	Dominik Brodowski <linux@dominikbrodowski.net>
 S:	Odd Fixes
diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index f36778e62ac1..17544a7023fc 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -821,6 +821,7 @@ static int pci_pm_suspend(struct device *dev)
 	 * since Coffee Lake, to enter a lower-power PM state.
 	 */
 	pci_suspend_ptm(pci_dev);
+	pci_suspend_lmr(pci_dev);
=20
 	if (pci_has_legacy_pm_support(pci_dev))
 		return pci_legacy_suspend(dev, PMSG_SUSPEND);
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 77b17b13ee61..dc9724cb7b4d 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5145,8 +5145,10 @@ int __pci_reset_function_locked(struct pci_dev *dev)
 		method =3D &pci_reset_fn_methods[m];
 		pci_dbg(dev, "reset via %s\n", method->name);
 		rc =3D method->reset_fn(dev, PCI_RESET_DO_RESET);
-		if (!rc)
+		if (!rc) {
+			pci_reset_lmr(dev);
 			return 0;
+		}
=20
 		pci_dbg(dev, "%s failed with %d\n", method->name, rc);
 		if (rc !=3D -ENOTTY)
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 4469e1a77f3c..6322a81f9e50 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -1023,6 +1023,18 @@ static inline void pci_no_tph(void) { }
 static inline void pci_tph_init(struct pci_dev *dev) { }
 #endif
=20
+#ifdef CONFIG_PCIE_LMR
+void pci_lmr_init(struct pci_dev *dev);
+void pci_lmr_exit(struct pci_dev *dev);
+void pci_suspend_lmr(struct pci_dev *dev);
+void pci_reset_lmr(struct pci_dev *dev);
+#else
+static inline void pci_lmr_init(struct pci_dev *dev) { }
+static inline void pci_lmr_exit(struct pci_dev *dev) { }
+static inline void pci_suspend_lmr(struct pci_dev *dev) { }
+static inline void pci_reset_lmr(struct pci_dev *dev) { }
+#endif
+
 #ifdef CONFIG_PCIE_PTM
 void pci_ptm_init(struct pci_dev *dev);
 void pci_save_ptm_state(struct pci_dev *dev);
diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
index 207c2deae35f..3b021ca2fe84 100644
--- a/drivers/pci/pcie/Kconfig
+++ b/drivers/pci/pcie/Kconfig
@@ -137,6 +137,18 @@ config PCIE_PTM
 	  This is only useful if you have devices that support PTM, but it
 	  is safe to enable even if you don't.
=20
+config PCIE_LMR
+	bool "PCI Express Lane Margining at Receiver Support"
+	depends on DEBUG_FS
+	help
+	  This enables the PCI Express Lane Margining at Receiver support.
+	  Lane Margining allows software to determine the voltage and
+	  timing margin of each lane on a PCIe link (16.0 GT/s and above).
+	  The margining data is exposed via debugfs.
+
+	  This is only useful if you have devices that support lane
+	  margining, but it is safe to enable even if you don't.
+
 config PCIE_EDR
 	bool "PCI Express Error Disconnect Recover support"
 	depends on PCIE_DPC && ACPI
diff --git a/drivers/pci/pcie/Makefile b/drivers/pci/pcie/Makefile
index b0b43a18c304..aac45ae0402e 100644
--- a/drivers/pci/pcie/Makefile
+++ b/drivers/pci/pcie/Makefile
@@ -13,4 +13,5 @@ obj-$(CONFIG_PCIEAER_INJECT)	+=3D aer_inject.o
 obj-$(CONFIG_PCIE_PME)		+=3D pme.o
 obj-$(CONFIG_PCIE_DPC)		+=3D dpc.o
 obj-$(CONFIG_PCIE_PTM)		+=3D ptm.o
+obj-$(CONFIG_PCIE_LMR)		+=3D margin.o
 obj-$(CONFIG_PCIE_EDR)		+=3D edr.o
diff --git a/drivers/pci/pcie/margin.c b/drivers/pci/pcie/margin.c
new file mode 100644
index 000000000000..59649ed7dc4f
--- /dev/null
+++ b/drivers/pci/pcie/margin.c
@@ -0,0 +1,970 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PCI Express Lane Margining at Receiver
+ *
+ * Copyright (C) 2026 Google LLC
+ * Author: Priyank Rathod <rathodpriyank@google.com>
+ *
+ * Lane Margining at Receiver (PCIe Base Specification r6.0, sec 8.4.4)
+ * allows system software to determine the voltage and timing margins of
+ * each physical lane on a PCIe link. The Extended Capability (ID 0x27)
+ * is available for receivers operating at 16.0 GT/s (Gen4) or higher data
+ * rates, and is mandatory for receivers operating at 64.0 GT/s (Gen6) or
+ * higher data rates.
+ *
+ * This driver implements:
+ *   - Probing Extended Capability ID 0x27 and Margining Port Capabilities=
.
+ *   - Managing ASPM L0s/L1 link states during active margining with resto=
ration.
+ *   - PCIe r6.0 NO_CMD (0x7) clearing handshake per receiver and lane.
+ *   - Caching receiver capabilities & step counts to avoid DEMARGIN side-=
effects.
+ *   - Handling Symmetric vs Independent Left/Right & Up/Down margin steps=
.
+ *   - Runtime PM protection (D0 enforcement) during active margining.
+ *   - Exposing per-device debugfs interfaces under /sys/kernel/debug/pci/=
.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/cleanup.h>
+#include <linux/debugfs.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/jiffies.h>
+#include <linux/kstrtox.h>
+#include <linux/minmax.h>
+#include <linux/mutex.h>
+#include <linux/overflow.h>
+#include <linux/pci.h>
+#include <linux/pm_runtime.h>
+#include <linux/seq_file.h>
+#include <linux/slab.h>
+#include <linux/sprintf.h>
+#include <linux/string_choices.h>
+#include <linux/types.h>
+
+#include "../pci.h"
+
+/* Margin type encodings per PCIe Base Spec r6.0 sec 8.4.4 */
+#define LMR_TYPE_DEMARGIN               0x0
+#define LMR_TYPE_REPORT_CAPS            0x1
+#define LMR_TYPE_REPORT_VOLTAGE_STEPS   0x2
+#define LMR_TYPE_REPORT_TIMING_STEPS    0x3
+#define LMR_TYPE_TIMING                 0x4
+#define LMR_TYPE_VOLTAGE                0x5
+#define LMR_TYPE_NO_CMD                 0x7
+
+/* LMR command timing parameters */
+#define LMR_CMD_TIMEOUT_MS              150
+#define LMR_CMD_SLEEP_MIN_US            100
+#define LMR_CMD_SLEEP_MAX_US            250
+#define LMR_ENABLE_TIMEOUT_MS           150
+#define LMR_ENABLE_SLEEP_MIN_US         1000
+#define LMR_ENABLE_SLEEP_MAX_US         2000
+
+/*
+ * LMR limits:
+ * Valid receiver numbers are 0 (local receiver) to 6 (up to 3 retimers)
+ * per PCIe Base Specification r6.0 sec 8.4.4. Receiver number 7 is reserv=
ed.
+ */
+#define LMR_MAX_LANES                   32
+#define LMR_MAX_RX_NUM                  6
+#define LMR_MAX_TIMING_STEP             63
+#define LMR_MAX_VOLTAGE_STEP            127
+
+/* LMR PCIe generation numbers and helper */
+#define LMR_GEN6                        6
+#define LMR_GEN5                        5
+#define LMR_GEN4                        4
+
+#define LMR_SPEED_TO_GEN(speed) \
+	((speed) >=3D PCIE_SPEED_64_0GT ? LMR_GEN6 : \
+	 (speed) >=3D PCIE_SPEED_32_0GT ? LMR_GEN5 : \
+	 LMR_GEN4)
+
+/* LMR lane register stride */
+#define LMR_LANE_REG_STRIDE             4
+
+/* LMR receivers and directions */
+#define LMR_RX_LOCAL                    0
+#define LMR_STEP_DIR_INCREASE           1
+#define LMR_STEP_DIR_DECREASE           0
+
+/* LMR payload field masks per PCIe Base Spec r6.0 sec 8.4.4 */
+#define LMR_STEPS_MASK			GENMASK(6, 0)
+#define LMR_TIMING_STEP_MASK		GENMASK(5, 0)
+#define LMR_TIMING_DIR_MASK		BIT(6)
+#define LMR_VOLTAGE_STEP_MASK		GENMASK(6, 0)
+#define LMR_VOLTAGE_DIR_MASK		BIT(7)
+
+/* LMR capabilities report bit fields */
+#define LMR_CAP_MARGIN_HV		BIT(0)
+#define LMR_CAP_MARGIN_EV_IV		BIT(1)
+#define LMR_CAP_IND_LEFT_RIGHT_TIMING	BIT(2)
+#define LMR_CAP_IND_UP_DOWN_VOLTAGE	BIT(3)
+#define LMR_CAP_ERROR_SAMPLER		BIT(4)
+#define LMR_CAP_SAMPLE_MULTIPLE_RX	BIT(5)
+
+/**
+ * struct pci_margin_rx_info - Cached Lane Margining receiver capabilities
+ * @caps_cached: True if receiver capabilities and step limits are cached
+ * @caps: Margining capabilities byte reported by receiver
+ * @num_timing_steps: Maximum timing margin steps supported by receiver
+ * @num_voltage_steps: Maximum voltage margin steps supported by receiver
+ */
+struct pci_margin_rx_info {
+	bool caps_cached;
+	u8 caps;
+	u8 num_timing_steps;
+	u8 num_voltage_steps;
+};
+
+/**
+ * struct pci_margin_lane - Per-lane margining state
+ * @mdev: Parent LMR margin device
+ * @lane: Physical lane index (0..num_lanes - 1)
+ * @rx: Selected target receiver number (0 =3D local, 1..6 =3D retimers)
+ * @timing_val: Current applied timing margin step offset (+/-)
+ * @voltage_val: Current applied voltage margin step offset (+/-)
+ * @rx_info: Cached receiver capabilities per receiver number
+ */
+struct pci_margin_lane {
+	struct pci_margin_dev *mdev;
+	int lane;
+	u8 rx;
+	int timing_val;
+	int voltage_val;
+	struct pci_margin_rx_info rx_info[LMR_MAX_RX_NUM + 1];
+};
+
+/**
+ * struct pci_margin_dev - PCIe Lane Margining device instance
+ * @dev: Underlying PCI device
+ * @cap: Extended capability offset (PCI_EXT_CAP_ID_LMR)
+ * @debugfs: Root debugfs dentry for this device
+ * @lock: Mutex protecting LMR hardware access, active margining enablemen=
t,
+ *        target receiver selection, lane margining steps, and ASPM state
+ * @enabled: True if Lane Margining is currently enabled
+ * @aspm_saved: True if original ASPM configuration has been saved
+ * @saved_aspm: Saved ASPM control register bits for the device
+ * @saved_parent_aspm: Saved ASPM control register bits for parent bridge
+ * @num_lanes: Number of lanes on the link
+ * @lanes: Flexible array of per-lane state structures
+ */
+struct pci_margin_dev {
+	struct pci_dev *dev;
+	u16 cap;
+	struct dentry *debugfs;
+	struct mutex lock;
+	bool enabled;
+	bool aspm_saved;
+	u16 saved_aspm;
+	u16 saved_parent_aspm;
+	int num_lanes;
+	struct pci_margin_lane lanes[] __counted_by(num_lanes);
+};
+
+#if IS_ENABLED(CONFIG_DEBUG_FS)
+static DEFINE_MUTEX(pci_debugfs_root_lock);
+static struct dentry *pci_debugfs_root_dir;
+
+static struct dentry *get_pci_debugfs_root(void)
+{
+	mutex_lock(&pci_debugfs_root_lock);
+	if (!pci_debugfs_root_dir)
+		pci_debugfs_root_dir =3D debugfs_lookup("pci", NULL);
+	if (!pci_debugfs_root_dir)
+		pci_debugfs_root_dir =3D debugfs_create_dir("pci", NULL);
+	mutex_unlock(&pci_debugfs_root_lock);
+	return pci_debugfs_root_dir;
+}
+#endif
+
+/*
+ * pci_lmr_disable_aspm() - Temporarily disable ASPM L0s/L1 during active
+ * margining per PCIe Base Spec r6.0 sec 8.4.4, saving original ASPMC bits=
.
+ */
+static void pci_lmr_disable_aspm(struct pci_margin_dev *mdev)
+{
+	struct pci_dev *dev =3D mdev->dev;
+	struct pci_dev *parent =3D pci_upstream_bridge(dev);
+	u16 ctl;
+
+	if (mdev->aspm_saved)
+		return;
+
+	if (!pcie_capability_read_word(dev, PCI_EXP_LNKCTL, &ctl)) {
+		mdev->saved_aspm =3D ctl & PCI_EXP_LNKCTL_ASPMC;
+		pcie_capability_clear_word(dev, PCI_EXP_LNKCTL, PCI_EXP_LNKCTL_ASPMC);
+	}
+
+	if (parent && pci_is_pcie(parent)) {
+		if (!pcie_capability_read_word(parent, PCI_EXP_LNKCTL, &ctl)) {
+			mdev->saved_parent_aspm =3D ctl & PCI_EXP_LNKCTL_ASPMC;
+			pcie_capability_clear_word(parent, PCI_EXP_LNKCTL, PCI_EXP_LNKCTL_ASPMC=
);
+		}
+	}
+	mdev->aspm_saved =3D true;
+}
+
+/*
+ * pci_lmr_restore_aspm() - Restore original ASPM L0s/L1 state when margin=
ing
+ * is disabled or torn down.
+ */
+static void pci_lmr_restore_aspm(struct pci_margin_dev *mdev)
+{
+	struct pci_dev *dev =3D mdev->dev;
+	struct pci_dev *parent =3D pci_upstream_bridge(dev);
+
+	if (!mdev->aspm_saved)
+		return;
+
+	pcie_capability_clear_and_set_word(dev, PCI_EXP_LNKCTL,
+					   PCI_EXP_LNKCTL_ASPMC,
+					   mdev->saved_aspm);
+	if (parent && pci_is_pcie(parent))
+		pcie_capability_clear_and_set_word(parent, PCI_EXP_LNKCTL,
+						   PCI_EXP_LNKCTL_ASPMC,
+						   mdev->saved_parent_aspm);
+	mdev->aspm_saved =3D false;
+}
+
+static inline u8 pci_lmr_sts_payload(u16 sts)
+{
+	return FIELD_GET(PCI_LMR_LANE_STS_PAYLOAD, sts);
+}
+
+/*
+ * pci_lmr_run_cmd() - Issue LMR command to Lane Control and wait for Stat=
us.
+ * Must be called with mdev->lock held.
+ */
+static int pci_lmr_run_cmd(struct pci_dev *dev, int lane, u8 rx, u8 type,
+			   u8 usage, u8 payload, u16 *status_val)
+{
+	u16 lmr, ctrl_offset, sts_offset;
+	u16 ctrl, sts;
+	unsigned long timeout;
+
+	if (!dev || !dev->lmr || lane < 0 || lane >=3D dev->lmr->num_lanes ||
+	    rx > LMR_MAX_RX_NUM)
+		return -EINVAL;
+
+	lmr =3D dev->lmr_cap;
+	ctrl_offset =3D lmr + PCI_LMR_LANE_CTRL + LMR_LANE_REG_STRIDE * lane;
+	sts_offset =3D lmr + PCI_LMR_LANE_STS + LMR_LANE_REG_STRIDE * lane;
+
+	/*
+	 * Per PCIe Base Spec r6.0 sec 8.4.4, software must issue NO_CMD (0x7)
+	 * targeting the specific receiver (rx) to clear MTYPE in Lane Status
+	 * before issuing a subsequent command.
+	 */
+	if (type !=3D LMR_TYPE_NO_CMD) {
+		ctrl =3D FIELD_PREP(PCI_LMR_LANE_CTRL_RX_NUM, rx) |
+		       FIELD_PREP(PCI_LMR_LANE_CTRL_MTYPE, LMR_TYPE_NO_CMD) |
+		       FIELD_PREP(PCI_LMR_LANE_CTRL_USAGE, 0) |
+		       FIELD_PREP(PCI_LMR_LANE_CTRL_PAYLOAD, 0);
+
+		pci_write_config_word(dev, ctrl_offset, ctrl);
+
+		timeout =3D jiffies + msecs_to_jiffies(LMR_CMD_TIMEOUT_MS);
+		while (1) {
+			if (pci_read_config_word(dev, sts_offset, &sts))
+				return -EIO;
+			if (PCI_POSSIBLE_ERROR(sts))
+				return -ENODEV;
+			if (FIELD_GET(PCI_LMR_LANE_STS_MTYPE, sts) =3D=3D LMR_TYPE_NO_CMD &&
+			    FIELD_GET(PCI_LMR_LANE_STS_RX_NUM, sts) =3D=3D rx)
+				break;
+			if (time_after(jiffies, timeout))
+				return -ETIMEDOUT;
+			usleep_range(LMR_CMD_SLEEP_MIN_US, LMR_CMD_SLEEP_MAX_US);
+		}
+	}
+
+	ctrl =3D FIELD_PREP(PCI_LMR_LANE_CTRL_RX_NUM, rx) |
+	       FIELD_PREP(PCI_LMR_LANE_CTRL_MTYPE, type) |
+	       FIELD_PREP(PCI_LMR_LANE_CTRL_USAGE, usage) |
+	       FIELD_PREP(PCI_LMR_LANE_CTRL_PAYLOAD, payload);
+
+	pci_write_config_word(dev, ctrl_offset, ctrl);
+
+	timeout =3D jiffies + msecs_to_jiffies(LMR_CMD_TIMEOUT_MS);
+	while (1) {
+		if (pci_read_config_word(dev, sts_offset, &sts))
+			return -EIO;
+		if (PCI_POSSIBLE_ERROR(sts))
+			return -ENODEV;
+
+		if (FIELD_GET(PCI_LMR_LANE_STS_MTYPE, sts) =3D=3D type &&
+		    FIELD_GET(PCI_LMR_LANE_STS_RX_NUM, sts) =3D=3D rx) {
+			if (status_val)
+				*status_val =3D sts;
+			return 0;
+		}
+
+		/*
+		 * Per PCIe Base Spec r6.0 sec 8.4.4, if receiver echoes NO_CMD (0x7)
+		 * after a command was sent, it indicates command rejection/NAK.
+		 */
+		if (FIELD_GET(PCI_LMR_LANE_STS_MTYPE, sts) =3D=3D LMR_TYPE_NO_CMD &&
+		    FIELD_GET(PCI_LMR_LANE_STS_RX_NUM, sts) =3D=3D rx)
+			return -EOPNOTSUPP;
+
+		if (time_after(jiffies, timeout))
+			break;
+
+		usleep_range(LMR_CMD_SLEEP_MIN_US, LMR_CMD_SLEEP_MAX_US);
+	}
+
+	return -ETIMEDOUT;
+}
+
+static int pci_lmr_demargin_lane(struct pci_margin_lane *plane)
+{
+	u16 sts;
+	int ret;
+
+	if (!plane || !plane->mdev)
+		return -EINVAL;
+
+	if (plane->timing_val =3D=3D 0 && plane->voltage_val =3D=3D 0)
+		return 0;
+
+	ret =3D pci_lmr_run_cmd(plane->mdev->dev, plane->lane, plane->rx,
+			      LMR_TYPE_DEMARGIN, 0, 0, &sts);
+	if (!ret) {
+		plane->timing_val =3D 0;
+		plane->voltage_val =3D 0;
+	}
+	return ret;
+}
+
+static int pci_lmr_cache_rx_info(struct pci_margin_lane *plane, u8 rx)
+{
+	struct pci_margin_rx_info *info;
+	u16 sts;
+	int ret;
+
+	if (!plane || rx > LMR_MAX_RX_NUM)
+		return -EINVAL;
+
+	info =3D &plane->rx_info[rx];
+
+	if (info->caps_cached)
+		return 0;
+
+	/* Issuing REPORT_CAPS aborts any active margin per PCIe spec */
+	ret =3D pci_lmr_demargin_lane(plane);
+	if (ret)
+		return ret;
+
+	ret =3D pci_lmr_run_cmd(plane->mdev->dev, plane->lane, rx,
+			      LMR_TYPE_REPORT_CAPS, 0, 0, &sts);
+	if (ret)
+		return ret;
+	info->caps =3D pci_lmr_sts_payload(sts);
+
+	ret =3D pci_lmr_run_cmd(plane->mdev->dev, plane->lane, rx,
+			      LMR_TYPE_REPORT_TIMING_STEPS, 0, 0, &sts);
+	if (ret)
+		return ret;
+	info->num_timing_steps =3D FIELD_GET(LMR_STEPS_MASK, pci_lmr_sts_payload(=
sts));
+
+	ret =3D pci_lmr_run_cmd(plane->mdev->dev, plane->lane, rx,
+			      LMR_TYPE_REPORT_VOLTAGE_STEPS, 0, 0, &sts);
+	if (ret)
+		return ret;
+	info->num_voltage_steps =3D FIELD_GET(LMR_STEPS_MASK, pci_lmr_sts_payload=
(sts));
+
+	info->caps_cached =3D true;
+	return 0;
+}
+
+#if IS_ENABLED(CONFIG_DEBUG_FS)
+
+static int margin_caps_show(struct seq_file *s, void *v)
+{
+	struct pci_margin_dev *mdev =3D s->private;
+	struct pci_dev *dev =3D mdev->dev;
+	u16 cap;
+
+	if (pci_read_config_word(dev, mdev->cap + PCI_LMR_PORT_CAP, &cap))
+		return -EIO;
+	seq_printf(s, "Port Capabilities: %#06x\n", cap);
+	seq_printf(s, "  Uses SW Ready: %s\n",
+		   str_yes_no(cap & PCI_LMR_PORT_CAP_USES_SW_READY));
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(margin_caps);
+
+static int margin_port_status_show(struct seq_file *s, void *v)
+{
+	struct pci_margin_dev *mdev =3D s->private;
+	struct pci_dev *dev =3D mdev->dev;
+	u16 sts;
+
+	if (pci_read_config_word(dev, mdev->cap + PCI_LMR_PORT_STS, &sts))
+		return -EIO;
+	seq_printf(s, "Port Status: %#06x\n", sts);
+	seq_printf(s, "  Margining Ready: %s\n",
+		   str_yes_no(sts & PCI_LMR_PORT_STS_MARGIN_READY));
+	seq_printf(s, "  SW Ready: %s\n",
+		   str_yes_no(sts & PCI_LMR_PORT_STS_SW_READY));
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(margin_port_status);
+
+static int margin_enable_show(struct seq_file *s, void *v)
+{
+	struct pci_margin_dev *mdev =3D s->private;
+
+	guard(mutex)(&mdev->lock);
+	seq_printf(s, "%d\n", mdev->enabled);
+	return 0;
+}
+
+static void __pci_suspend_lmr_locked(struct pci_dev *dev)
+{
+	struct pci_margin_dev *mdev =3D dev->lmr;
+	int i;
+	u16 sts;
+
+	if (!mdev || !mdev->enabled)
+		return;
+
+	for (i =3D 0; i < mdev->num_lanes; i++)
+		pci_lmr_demargin_lane(&mdev->lanes[i]);
+
+	if (pci_read_config_word(dev, mdev->cap + PCI_LMR_PORT_STS, &sts) =3D=3D =
0) {
+		sts &=3D ~PCI_LMR_PORT_STS_SW_READY;
+		pci_write_config_word(dev, mdev->cap + PCI_LMR_PORT_STS, sts);
+	}
+	pci_lmr_restore_aspm(mdev);
+	pm_runtime_put(&dev->dev);
+	mdev->enabled =3D false;
+}
+
+static ssize_t margin_enable_write(struct file *file, const char __user *u=
ser_buf,
+			       size_t count, loff_t *ppos)
+{
+	struct seq_file *s =3D file->private_data;
+	struct pci_margin_dev *mdev =3D s->private;
+	struct pci_dev *dev =3D mdev->dev;
+	unsigned long timeout;
+	u16 sts, cap, lnksta;
+	bool enable;
+	int ret, i;
+
+	ret =3D kstrtobool_from_user(user_buf, count, &enable);
+	if (ret)
+		return ret;
+
+	guard(mutex)(&mdev->lock);
+
+	if (mdev->enabled =3D=3D enable)
+		return count;
+
+	if (!enable) {
+		__pci_suspend_lmr_locked(dev);
+		return count;
+	}
+
+	/* PCIe r6.0 sec 8.4.4: LMR is physically undefined below 16.0 GT/s (Gen4=
) */
+	pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
+	if ((lnksta & PCI_EXP_LNKSTA_CLS) < PCI_EXP_LNKSTA_CLS_16_0GB)
+		return -EOPNOTSUPP;
+
+	if (pci_read_config_word(dev, mdev->cap + PCI_LMR_PORT_CAP, &cap))
+		return -EIO;
+
+	/* Prevent D3hot runtime PM transition during active margining */
+	ret =3D pm_runtime_resume_and_get(&dev->dev);
+	if (ret < 0)
+		return ret;
+
+	/* Disable ASPM L0s/L1 during margining with restoration path */
+	pci_lmr_disable_aspm(mdev);
+
+	/* Ensure link is settled in L0 mode per PCIe r6.0 sec 8.4.4 */
+	usleep_range(2000, 3000);
+
+	if (cap & PCI_LMR_PORT_CAP_USES_SW_READY) {
+		if (pci_read_config_word(dev, mdev->cap + PCI_LMR_PORT_STS, &sts)) {
+			ret =3D -EIO;
+			goto err_enable;
+		}
+		sts |=3D PCI_LMR_PORT_STS_SW_READY;
+		pci_write_config_word(dev, mdev->cap + PCI_LMR_PORT_STS, sts);
+	}
+
+	timeout =3D jiffies + msecs_to_jiffies(LMR_ENABLE_TIMEOUT_MS);
+	while (1) {
+		if (pci_read_config_word(dev, mdev->cap + PCI_LMR_PORT_STS, &sts)) {
+			ret =3D -EIO;
+			goto err_enable;
+		}
+		if (PCI_POSSIBLE_ERROR(sts)) {
+			ret =3D -ENODEV;
+			goto err_enable;
+		}
+		if (sts & PCI_LMR_PORT_STS_MARGIN_READY)
+			break;
+		if (time_after(jiffies, timeout)) {
+			ret =3D -ETIMEDOUT;
+			goto err_enable;
+		}
+		usleep_range(LMR_ENABLE_SLEEP_MIN_US, LMR_ENABLE_SLEEP_MAX_US);
+	}
+
+	/* Cache capabilities for configured receiver on all lanes */
+	for (i =3D 0; i < mdev->num_lanes; i++) {
+		ret =3D pci_lmr_cache_rx_info(&mdev->lanes[i],
+					    mdev->lanes[i].rx);
+		if (ret)
+			goto err_enable;
+	}
+	mdev->enabled =3D true;
+	return count;
+
+err_enable:
+	if (cap & PCI_LMR_PORT_CAP_USES_SW_READY) {
+		if (pci_read_config_word(dev, mdev->cap + PCI_LMR_PORT_STS, &sts) =3D=3D=
 0) {
+			sts &=3D ~PCI_LMR_PORT_STS_SW_READY;
+			pci_write_config_word(dev, mdev->cap + PCI_LMR_PORT_STS, sts);
+		}
+	}
+	pci_lmr_restore_aspm(mdev);
+	pm_runtime_put(&dev->dev);
+	return ret;
+}
+
+static int margin_enable_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, margin_enable_show, inode->i_private);
+}
+
+static const struct file_operations margin_enable_fops =3D {
+	.open =3D margin_enable_open,
+	.read =3D seq_read,
+	.write =3D margin_enable_write,
+	.llseek =3D seq_lseek,
+	.release =3D single_release,
+};
+
+static int margin_lane_receiver_show(struct seq_file *s, void *v)
+{
+	struct pci_margin_lane *plane =3D s->private;
+
+	guard(mutex)(&plane->mdev->lock);
+	seq_printf(s, "%d\n", plane->rx);
+	return 0;
+}
+
+static ssize_t margin_lane_receiver_write(struct file *file, const char __=
user *user_buf,
+				      size_t count, loff_t *ppos)
+{
+	struct seq_file *s =3D file->private_data;
+	struct pci_margin_lane *plane =3D s->private;
+	struct pci_margin_dev *mdev =3D plane->mdev;
+	int ret;
+	u8 rx;
+
+	ret =3D kstrtou8_from_user(user_buf, count, 0, &rx);
+	if (ret)
+		return ret;
+
+	/* Valid receiver numbers are 0..6 per PCIe r6.0 sec 8.4.4; 7 is reserved=
 */
+	if (rx > LMR_MAX_RX_NUM)
+		return -EINVAL;
+
+	guard(mutex)(&mdev->lock);
+	if (plane->rx =3D=3D rx)
+		return count;
+
+	if (mdev->enabled) {
+		/* Demargin previous receiver per single-receiver spec rule */
+		ret =3D pci_lmr_demargin_lane(plane);
+		if (ret)
+			return ret;
+		ret =3D pci_lmr_cache_rx_info(plane, rx);
+		if (ret)
+			return ret;
+	}
+
+	plane->rx =3D rx;
+	return count;
+}
+
+static int margin_lane_receiver_open(struct inode *inode, struct file *fil=
e)
+{
+	return single_open(file, margin_lane_receiver_show, inode->i_private);
+}
+
+static const struct file_operations margin_lane_receiver_fops =3D {
+	.open =3D margin_lane_receiver_open,
+	.read =3D seq_read,
+	.write =3D margin_lane_receiver_write,
+	.llseek =3D seq_lseek,
+	.release =3D single_release,
+};
+
+static int margin_lane_caps_show(struct seq_file *s, void *v)
+{
+	struct pci_margin_lane *plane =3D s->private;
+	struct pci_margin_dev *mdev =3D plane->mdev;
+	struct pci_margin_rx_info *info;
+	int ret;
+	u8 val;
+
+	guard(mutex)(&mdev->lock);
+	if (!mdev->enabled)
+		return -EACCES;
+
+	ret =3D pci_lmr_cache_rx_info(plane, plane->rx);
+	if (ret)
+		return ret;
+
+	info =3D &plane->rx_info[plane->rx];
+	val =3D info->caps;
+	seq_printf(s, "Lane %d Rx %d Capabilities: %#02x\n", plane->lane, plane->=
rx, val);
+	seq_printf(s, "  Margining H/V: %s\n", (val & LMR_CAP_MARGIN_HV) ? "both"=
 : "either");
+	seq_printf(s, "  Margining eV/iV: %s\n",
+		   (val & LMR_CAP_MARGIN_EV_IV) ? "both (close & open)" : "one (close on=
ly)");
+	seq_printf(s, "  Left/Right: %s\n", (val & LMR_CAP_IND_LEFT_RIGHT_TIMING)=
 ? "both" : "one");
+	seq_printf(s, "  Up/Down: %s\n", (val & LMR_CAP_IND_UP_DOWN_VOLTAGE) ? "b=
oth" : "one");
+	seq_printf(s, "  Error Sampler: %s\n",
+		   (val & LMR_CAP_ERROR_SAMPLER) ? "yes" : "no (main sampler)");
+	seq_printf(s, "  Sample Multiple Receivers: %s\n",
+		   str_yes_no(val & LMR_CAP_SAMPLE_MULTIPLE_RX));
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(margin_lane_caps);
+
+static int margin_lane_steps_show(struct seq_file *s, bool is_voltage)
+{
+	struct pci_margin_lane *plane =3D s->private;
+	struct pci_margin_dev *mdev =3D plane->mdev;
+	struct pci_margin_rx_info *info;
+	int ret;
+
+	guard(mutex)(&mdev->lock);
+	if (!mdev->enabled)
+		return -EACCES;
+
+	ret =3D pci_lmr_cache_rx_info(plane, plane->rx);
+	if (ret)
+		return ret;
+
+	info =3D &plane->rx_info[plane->rx];
+	seq_printf(s, "%d\n", is_voltage ? info->num_voltage_steps : info->num_ti=
ming_steps);
+	return 0;
+}
+
+static int margin_lane_timing_steps_show(struct seq_file *s, void *v)
+{
+	return margin_lane_steps_show(s, false);
+}
+DEFINE_SHOW_ATTRIBUTE(margin_lane_timing_steps);
+
+static int margin_lane_voltage_steps_show(struct seq_file *s, void *v)
+{
+	return margin_lane_steps_show(s, true);
+}
+DEFINE_SHOW_ATTRIBUTE(margin_lane_voltage_steps);
+
+static bool pci_lmr_check_sample_multiple_rx(struct pci_margin_dev *mdev,
+					     struct pci_margin_lane *plane)
+{
+	struct pci_margin_rx_info *info =3D &plane->rx_info[plane->rx];
+	int i;
+
+	if (info->caps & LMR_CAP_SAMPLE_MULTIPLE_RX)
+		return true;
+
+	for (i =3D 0; i < mdev->num_lanes; i++) {
+		struct pci_margin_lane *other =3D &mdev->lanes[i];
+
+		if (i =3D=3D plane->lane)
+			continue;
+		if (other->rx =3D=3D plane->rx &&
+		    (other->timing_val !=3D 0 || other->voltage_val !=3D 0))
+			return false;
+	}
+	return true;
+}
+
+static ssize_t margin_lane_step_write(struct file *file, const char __user=
 *user_buf,
+				      size_t count, bool is_voltage)
+{
+	struct seq_file *s =3D file->private_data;
+	struct pci_margin_lane *plane =3D s->private;
+	struct pci_margin_dev *mdev =3D plane->mdev;
+	struct pci_margin_rx_info *info;
+	u8 step, dir, payload;
+	int max_step, val, ret;
+	u16 sts;
+	u8 caps;
+
+	ret =3D kstrtoint_from_user(user_buf, count, 0, &val);
+	if (ret)
+		return ret;
+
+	max_step =3D is_voltage ? LMR_MAX_VOLTAGE_STEP : LMR_MAX_TIMING_STEP;
+	if (val > max_step || val < -max_step)
+		return -EINVAL;
+
+	guard(mutex)(&mdev->lock);
+	if (!mdev->enabled)
+		return -EACCES;
+
+	if (val =3D=3D 0)
+		return pci_lmr_demargin_lane(plane) ?: count;
+
+	ret =3D pci_lmr_cache_rx_info(plane, plane->rx);
+	if (ret)
+		return ret;
+
+	if (!pci_lmr_check_sample_multiple_rx(mdev, plane))
+		return -EBUSY;
+
+	info =3D &plane->rx_info[plane->rx];
+	caps =3D info->caps;
+
+	if (val < 0) {
+		step =3D -val;
+		if (is_voltage) {
+			/* Symmetric voltage margining requires dir=3D1 per spec */
+			if (!(caps & LMR_CAP_IND_UP_DOWN_VOLTAGE))
+				return -EINVAL;
+			dir =3D 0;
+		} else {
+			/* Symmetric timing margining requires dir=3D1 per spec */
+			if (!(caps & LMR_CAP_IND_LEFT_RIGHT_TIMING))
+				return -EINVAL;
+			dir =3D LMR_STEP_DIR_DECREASE;
+		}
+	} else {
+		step =3D val;
+		dir =3D is_voltage ? 1 : LMR_STEP_DIR_INCREASE;
+	}
+
+	max_step =3D is_voltage ? info->num_voltage_steps : info->num_timing_step=
s;
+	if (step > max_step)
+		return -EINVAL;
+
+	if (is_voltage) {
+		payload =3D FIELD_PREP(LMR_VOLTAGE_DIR_MASK, dir) |
+			  FIELD_PREP(LMR_VOLTAGE_STEP_MASK, step);
+		ret =3D pci_lmr_run_cmd(mdev->dev, plane->lane, plane->rx,
+				      LMR_TYPE_VOLTAGE, 0, payload, &sts);
+		if (ret)
+			return ret;
+		step =3D FIELD_GET(LMR_VOLTAGE_STEP_MASK, pci_lmr_sts_payload(sts));
+		plane->voltage_val =3D (dir =3D=3D 0) ? -step : step;
+	} else {
+		payload =3D FIELD_PREP(LMR_TIMING_DIR_MASK, dir) |
+			  FIELD_PREP(LMR_TIMING_STEP_MASK, step);
+		ret =3D pci_lmr_run_cmd(mdev->dev, plane->lane, plane->rx,
+				      LMR_TYPE_TIMING, 0, payload, &sts);
+		if (ret)
+			return ret;
+		step =3D FIELD_GET(LMR_TIMING_STEP_MASK, pci_lmr_sts_payload(sts));
+		plane->timing_val =3D (dir =3D=3D LMR_STEP_DIR_DECREASE) ? -step : step;
+	}
+
+	return count;
+}
+
+static ssize_t margin_lane_timing_write(struct file *file, const char __us=
er *user_buf,
+					size_t count, loff_t *ppos)
+{
+	return margin_lane_step_write(file, user_buf, count, false);
+}
+
+static int margin_lane_step_show(struct seq_file *s, bool is_voltage)
+{
+	struct pci_margin_lane *plane =3D s->private;
+
+	guard(mutex)(&plane->mdev->lock);
+	seq_printf(s, "%d\n", is_voltage ? plane->voltage_val : plane->timing_val=
);
+	return 0;
+}
+
+static int margin_lane_timing_show(struct seq_file *s, void *v)
+{
+	return margin_lane_step_show(s, false);
+}
+
+static int margin_lane_timing_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, margin_lane_timing_show, inode->i_private);
+}
+
+static const struct file_operations margin_lane_timing_fops =3D {
+	.open =3D margin_lane_timing_open,
+	.read =3D seq_read,
+	.write =3D margin_lane_timing_write,
+	.llseek =3D seq_lseek,
+	.release =3D single_release,
+};
+
+static ssize_t margin_lane_voltage_write(struct file *file, const char __u=
ser *user_buf,
+					 size_t count, loff_t *ppos)
+{
+	return margin_lane_step_write(file, user_buf, count, true);
+}
+
+static int margin_lane_voltage_show(struct seq_file *s, void *v)
+{
+	return margin_lane_step_show(s, true);
+}
+
+static int margin_lane_voltage_open(struct inode *inode, struct file *file=
)
+{
+	return single_open(file, margin_lane_voltage_show, inode->i_private);
+}
+
+static const struct file_operations margin_lane_voltage_fops =3D {
+	.open =3D margin_lane_voltage_open,
+	.read =3D seq_read,
+	.write =3D margin_lane_voltage_write,
+	.llseek =3D seq_lseek,
+	.release =3D single_release,
+};
+
+static void pci_margin_debugfs_init(struct pci_margin_dev *mdev)
+{
+	struct pci_dev *dev =3D mdev->dev;
+	struct dentry *parent;
+	char dirname[64];
+	int i;
+
+	parent =3D get_pci_debugfs_root();
+	scnprintf(dirname, sizeof(dirname), "pcie_lmr_%s", dev_name(&dev->dev));
+	mdev->debugfs =3D debugfs_create_dir(dirname, parent);
+	if (IS_ERR_OR_NULL(mdev->debugfs))
+		return;
+
+	debugfs_create_file("capabilities", 0444, mdev->debugfs, mdev, &margin_ca=
ps_fops);
+	debugfs_create_file("port_status", 0444, mdev->debugfs, mdev, &margin_por=
t_status_fops);
+	debugfs_create_file("enable", 0644, mdev->debugfs, mdev, &margin_enable_f=
ops);
+
+	for (i =3D 0; i < mdev->num_lanes; i++) {
+		struct pci_margin_lane *plane =3D &mdev->lanes[i];
+		struct dentry *lane_dir;
+		char lane_name[16];
+
+		scnprintf(lane_name, sizeof(lane_name), "lane%d", i);
+		lane_dir =3D debugfs_create_dir(lane_name, mdev->debugfs);
+		if (IS_ERR_OR_NULL(lane_dir))
+			continue;
+
+		debugfs_create_file("receiver", 0644, lane_dir, plane, &margin_lane_rece=
iver_fops);
+		debugfs_create_file("caps", 0444, lane_dir, plane, &margin_lane_caps_fop=
s);
+		debugfs_create_file("num_timing_steps", 0444, lane_dir, plane,
+				    &margin_lane_timing_steps_fops);
+		debugfs_create_file("num_voltage_steps", 0444, lane_dir, plane,
+				    &margin_lane_voltage_steps_fops);
+		debugfs_create_file("margin_timing", 0644, lane_dir, plane,
+				    &margin_lane_timing_fops);
+		debugfs_create_file("margin_voltage", 0644, lane_dir, plane,
+				    &margin_lane_voltage_fops);
+	}
+}
+
+static void pci_margin_debugfs_remove(struct pci_margin_dev *mdev)
+{
+	debugfs_remove_recursive(mdev->debugfs);
+}
+
+#else
+static inline void pci_margin_debugfs_init(struct pci_margin_dev *mdev) { =
}
+static inline void pci_margin_debugfs_remove(struct pci_margin_dev *mdev) =
{ }
+#endif
+
+void pci_lmr_init(struct pci_dev *dev)
+{
+	struct pci_margin_dev *mdev;
+	enum pci_bus_speed speed;
+	u16 lmr, lnksta;
+	int num_lanes, i;
+
+	if (!dev || !pci_is_pcie(dev))
+		return;
+
+	speed =3D pcie_get_speed_cap(dev);
+	if (speed < PCIE_SPEED_16_0GT || speed =3D=3D PCI_SPEED_UNKNOWN)
+		return;
+
+	lmr =3D pci_find_ext_capability(dev, PCI_EXT_CAP_ID_LMR);
+	if (!lmr) {
+		if (speed >=3D PCIE_SPEED_64_0GT)
+			pci_warn(dev,
+				 "Missing Lane Margining at Receiver Capability (mandatory for Gen6+)\=
n");
+		else
+			pci_dbg(dev,
+				"Optional Lane Margining at Receiver Capability not found\n");
+		return;
+	}
+
+	pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
+	num_lanes =3D FIELD_GET(PCI_EXP_LNKSTA_NLW, lnksta);
+	if (num_lanes =3D=3D 0 || num_lanes > LMR_MAX_LANES) {
+		pci_warn(dev, "Invalid link width %d for LMR\n", num_lanes);
+		return;
+	}
+
+	dev->lmr_cap =3D lmr;
+
+	mdev =3D kzalloc(struct_size(mdev, lanes, num_lanes), GFP_KERNEL);
+	if (!mdev)
+		return;
+
+	mdev->num_lanes =3D num_lanes;
+	mdev->dev =3D dev;
+	mdev->cap =3D lmr;
+	mutex_init(&mdev->lock);
+
+	for (i =3D 0; i < num_lanes; i++) {
+		mdev->lanes[i].mdev =3D mdev;
+		mdev->lanes[i].lane =3D i;
+		mdev->lanes[i].rx =3D LMR_RX_LOCAL;
+	}
+
+	pci_margin_debugfs_init(mdev);
+
+	dev->lmr =3D mdev;
+
+	pci_info(dev, "Lane Margining at Receiver (Gen%u) Capability detected\n",
+		 LMR_SPEED_TO_GEN(speed));
+}
+
+void pci_lmr_exit(struct pci_dev *dev)
+{
+	struct pci_margin_dev *mdev =3D dev->lmr;
+
+	if (!dev || !mdev)
+		return;
+
+	pci_suspend_lmr(dev);
+
+	pci_margin_debugfs_remove(mdev);
+	mutex_destroy(&mdev->lock);
+	kfree(mdev);
+	dev->lmr =3D NULL;
+}
+
+void pci_suspend_lmr(struct pci_dev *dev)
+{
+	struct pci_margin_dev *mdev =3D dev->lmr;
+
+	if (!dev || !mdev)
+		return;
+
+	guard(mutex)(&mdev->lock);
+	__pci_suspend_lmr_locked(dev);
+}
+
+void pci_reset_lmr(struct pci_dev *dev)
+{
+	pci_suspend_lmr(dev);
+}
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index dd0abbc63e18..352b95568ebf 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2666,6 +2666,7 @@ static void pci_init_capabilities(struct pci_dev *dev=
)
 	pci_pasid_init(dev);		/* Process Address Space ID */
 	pci_acs_init(dev);		/* Access Control Services */
 	pci_ptm_init(dev);		/* Precision Time Measurement */
+	pci_lmr_init(dev);		/* Lane Margining at Receiver */
 	pci_aer_init(dev);		/* Advanced Error Reporting */
 	pci_dpc_init(dev);		/* Downstream Port Containment */
 	pci_rcec_init(dev);		/* Root Complex Event Collector */
diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index d8bffa21498a..6fba29040e44 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -36,6 +36,7 @@ static void pci_destroy_dev(struct pci_dev *dev)
=20
 	pci_doe_sysfs_teardown(dev);
 	pci_npem_remove(dev);
+	pci_lmr_exit(dev);
=20
 	/*
 	 * While device is in D0 drop the device from TSM link operations
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 64b308b6e61c..ef1275f4c5b6 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -349,6 +349,8 @@ struct rcec_ea;
  *			number resources to allow for hierarchy expansion.
  * @is_pciehp:		PCIe Hot-Plug Capable bridge.
  */
+struct pci_margin_dev;
+
 struct pci_dev {
 	struct list_head bus_list;	/* Node in per-bus list */
 	struct pci_bus	*bus;		/* Bus this device is on */
@@ -528,6 +530,10 @@ struct pci_dev {
 	atomic_t	ptm_enable_cnt;
 	u8		ptm_granularity;
 #endif
+#ifdef CONFIG_PCIE_LMR
+	u16			lmr_cap;	/* Lane Margining Capability */
+	struct pci_margin_dev	*lmr;
+#endif
 #ifdef CONFIG_PCI_MSI
 	void __iomem	*msix_base;
 	raw_spinlock_t	msi_lock;
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index facaa324bd86..90cbe310e62f 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -757,6 +757,7 @@
 #define PCI_EXT_CAP_ID_VF_REBAR 0x24	/* VF Resizable BAR */
 #define PCI_EXT_CAP_ID_DLF	0x25	/* Data Link Feature */
 #define PCI_EXT_CAP_ID_PL_16GT	0x26	/* Physical Layer 16.0 GT/s */
+#define PCI_EXT_CAP_ID_LMR	0x27	/* Lane Margining at Receiver */
 #define PCI_EXT_CAP_ID_NPEM	0x29	/* Native PCIe Enclosure Management */
 #define PCI_EXT_CAP_ID_PL_32GT  0x2A    /* Physical Layer 32.0 GT/s */
 #define PCI_EXT_CAP_ID_DOE	0x2E	/* Data Object Exchange */
@@ -1181,6 +1182,23 @@
 #define  PCI_PL_16GT_LE_CTRL_USP_TX_PRESET_MASK		0x000000F0
 #define  PCI_PL_16GT_LE_CTRL_USP_TX_PRESET_SHIFT	4
=20
+/* Lane Margining at Receiver */
+#define PCI_LMR_PORT_CAP		0x04	/* Margining Port Capabilities */
+#define  PCI_LMR_PORT_CAP_USES_SW_READY	0x0001	/* Margining Uses Software =
Ready */
+#define PCI_LMR_PORT_STS		0x06	/* Margining Port Status */
+#define  PCI_LMR_PORT_STS_MARGIN_READY	0x0001	/* Margining Ready */
+#define  PCI_LMR_PORT_STS_SW_READY	0x0002	/* Margining SW Ready */
+#define PCI_LMR_LANE_CTRL		0x08	/* Margining Lane Control */
+#define  PCI_LMR_LANE_CTRL_RX_NUM	0x0007	/* Receiver Number */
+#define  PCI_LMR_LANE_CTRL_MTYPE	0x0038	/* Margining Type */
+#define  PCI_LMR_LANE_CTRL_USAGE	0x0040	/* Margining Usage Model */
+#define  PCI_LMR_LANE_CTRL_PAYLOAD	0xFF00	/* Margining Payload */
+#define PCI_LMR_LANE_STS		0x0A	/* Margining Lane Status */
+#define  PCI_LMR_LANE_STS_RX_NUM	0x0007	/* Receiver Number */
+#define  PCI_LMR_LANE_STS_MTYPE		0x0038	/* Margining Type */
+#define  PCI_LMR_LANE_STS_USAGE		0x0040	/* Margining Usage Model */
+#define  PCI_LMR_LANE_STS_PAYLOAD	0xFF00	/* Margining Payload */
+
 /* Physical Layer 32.0 GT/s */
 #define PCI_PL_32GT_LE_CTRL	0x20	/* Lane Equalization Control Register */
=20
diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Mak=
efile
index 8a4b6ddc68df..6990d999388a 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -91,6 +91,7 @@ TARGETS +=3D net/tcp_ao
 TARGETS +=3D nolibc
 TARGETS +=3D pci_endpoint
 TARGETS +=3D pcie_bwctrl
+TARGETS +=3D pcie_lmt
 TARGETS +=3D perf_events
 TARGETS +=3D pidfd
 TARGETS +=3D pid_namespace
diff --git a/tools/testing/selftests/pcie_lmt/Makefile b/tools/testing/self=
tests/pcie_lmt/Makefile
new file mode 100644
index 000000000000..36ac85937d78
--- /dev/null
+++ b/tools/testing/selftests/pcie_lmt/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+TEST_PROGS =3D pcie_lmt.sh
+include ../lib.mk
diff --git a/tools/testing/selftests/pcie_lmt/pcie_lmt.sh b/tools/testing/s=
elftests/pcie_lmt/pcie_lmt.sh
new file mode 100755
index 000000000000..22c00c2b8956
--- /dev/null
+++ b/tools/testing/selftests/pcie_lmt/pcie_lmt.sh
@@ -0,0 +1,105 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (C) 2026 Google LLC
+# Author: Priyank Rathod <rathodpriyank@google.com>
+#
+# Kselftest for PCIe Lane Margining at Receiver (LMR / LMT)
+# Tests the debugfs interface exposed by drivers/pci/pcie/margin.c
+# (/sys/kernel/debug/pci/pcie_lmr_<pci_dev_name>/)
+
+set -e
+
+TESTNAME=3D"pcie_lmt"
+
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=3D4
+retval=3D0
+skipmsg=3D"skip all tests:"
+
+if [ $UID !=3D 0 ]; then
+	echo "$skipmsg must be run as root" >&2
+	exit $ksft_skip
+fi
+
+DEBUGFS=3D$(mount -t debugfs | head -1 | awk '{ print $3 }')
+if [ -z "$DEBUGFS" ]; then
+	if [ -d "/sys/kernel/debug" ]; then
+		DEBUGFS=3D"/sys/kernel/debug"
+	else
+		echo "$skipmsg debugfs is not mounted" >&2
+		exit $ksft_skip
+	fi
+fi
+
+if [ ! -d "$DEBUGFS/pci" ]; then
+	# Allow searching debugfs root or pci directory
+	:
+fi
+
+LMR_DEVS=3D$(ls -d $DEBUGFS/pci/pcie_lmr_* $DEBUGFS/pcie_lmr_* 2>/dev/null=
 || true)
+if [ -z "$LMR_DEVS" ]; then
+	echo "$skipmsg no PCIe LMR devices found in $DEBUGFS/" >&2
+	exit $ksft_skip
+fi
+
+cleanup_dev()
+{
+	local dev=3D"$1"
+	echo 0 > "$dev/enable" 2>/dev/null || true
+}
+
+echo "$TESTNAME: testing PCIe LMR debugfs entries"
+
+for dev in $LMR_DEVS; do
+	dev_name=3D$(basename "$dev")
+	echo "$TESTNAME: probing device $dev_name"
+
+	if [ ! -r "$dev/capabilities" ] || [ ! -r "$dev/port_status" ] ||
+	   [ ! -r "$dev/enable" ] || [ ! -w "$dev/enable" ]; then
+		echo "$TESTNAME: $dev_name missing mandatory root attributes"
+		retval=3D1
+		continue
+	fi
+
+	caps=3D$(cat "$dev/capabilities")
+	status=3D$(cat "$dev/port_status")
+	echo "  $dev_name: capabilities read OK"
+	echo "  $dev_name: port_status read OK"
+
+	trap 'cleanup_dev "$dev"' EXIT
+
+	if ! echo 1 > "$dev/enable" 2>/dev/null; then
+		echo "  $dev_name: margining not ready by hardware (skipping active lane=
s)"
+		continue
+	fi
+
+	echo "  $dev_name: margining enabled OK"
+
+	for lane_dir in $(ls -d "$dev"/lane* 2>/dev/null || true); do
+		lane=3D$(basename "$lane_dir")
+		echo "  $dev_name: testing $lane"
+
+		# Test setting receiver (Rx 0 is always local receiver)
+		echo 0 > "$lane_dir/receiver"
+		cat "$lane_dir/caps" > /dev/null
+		cat "$lane_dir/num_timing_steps" > /dev/null
+		cat "$lane_dir/num_voltage_steps" > /dev/null
+
+		# Test resetting timing and voltage margin
+		echo 0 > "$lane_dir/margin_timing"
+		echo 0 > "$lane_dir/margin_voltage"
+	done
+
+	echo 0 > "$dev/enable"
+	trap - EXIT
+	echo "  $dev_name: margining disabled OK"
+done
+
+if [ $retval -eq 0 ]; then
+	echo "$TESTNAME [PASS]"
+else
+	echo "$TESTNAME [FAIL]"
+fi
+
+exit $retval

---
base-commit: 0f23d56f17fdfc7db69d51f64c8b91bbab947aa9
change-id: 20260818-pcie-lmt-3044d586aaec

Best regards,
--=20
Priyank Rathod <rathodpriyank@google.com>


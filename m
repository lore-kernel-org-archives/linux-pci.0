Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966E68834
	for <linux-pci@vger.kernel.org>; Fri, 28 Aug 2026 01:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787878882; cv=none; b=jKByp3K2Z0jC2Nwo+GRJe99bEkb1LGz8W25mcFy95jFrKGShJDhLd59aN09PhmAZ8Ffra/Z35ekXoFHnW8r/AwiK6w9cg9/Roo1pt+VNOuWPZM+k8/W0ejTXe0BDgb4dz2oIUM8gku/rhZnq9pnwhV2wXGGGMBoChwccou0cPaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787878882; c=relaxed/simple;
	bh=dRpbNwu1zAcymRKjV6UC1bg2XtezVQ3tyHqi0yypy04=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Xw73daXOjDftdvayCiCanErov80iCBqet82N5mMhOhj3S8InvfXDXwVaRax/HvaujsibiBvTnMhoQxKxQ+Rw/aSWV/RodHk9A3ZCKZIYnccXCGTJBVkDunLySEQjOUXUg4aKp/H8OnjoXuWiSCw/tT+uD7+TgCcDaNPSg0sxxws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rathodpriyank.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d7XlnSi0; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rathodpriyank.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d7XlnSi0"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc1c62f0d60so831752a12.1
        for <linux-pci@vger.kernel.org>; Thu, 27 Aug 2026 18:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787878878; x=1788483678; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=sBsdwRNMwmdzr9+H1ckJYRibqTJBUmLUIV2+QU73rDE=;
        b=d7XlnSi0xaZSaGzx83DqdB804JjARTCSEkTtD2Edhp4Si6O+glvCi9C8WPJDiNpkEw
         6Eb2pLD3Sk1BxXN1wjA5Vdy87NtIp8GD+CPC+ZORdhFkZxvbcchUoO8NzuLi1/v2DMta
         HIz/RRtbQCHptgMpODF4dCSRGOt5ROL79bxC+TP8lDndFQCBYALhnGTYVmJoHGs4UnBo
         0Odkoi15GX6pniDjBngb/iqYRLPyVL2BHalUqzdQypnlllfZMaZBR96GItyPGYKm5aey
         rCd1qGgjFgmotBqscoha0e7raMk6UHfLyTJHZSShJoFfXmu3eMXE0UhaZBt2roZ8IZFG
         k3lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787878878; x=1788483678;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sBsdwRNMwmdzr9+H1ckJYRibqTJBUmLUIV2+QU73rDE=;
        b=r4oWtIYgm49AP8ROHn9uEWSt4ncL6u78eSuUVxkFuhmBQB0Nl8jSAkvS5Bpvio/Qtv
         iuBMT+UtKzgovjCUT0fMIqsc45X8tCBpq5HbIgYyftk9bN7hRTo4vf92q6W9USpip0my
         Y48CiPj/pFagmLk2Bw5fQZX9IH2aRQmKJCH5D6QqjTqG0ZYXmBJomELkvwS9hXEcc1cY
         mRUk2blbkHBbseGuNlEDnHLago9QBzxtHrue1i6Gd4sCLJMog3zbXHQPYCPR1L9dY1bl
         +QefLeFyV1jis8bmiArbL165FASXOI/ew/huF0xOVW+CzgQCCJ7rgcoaBpvKk9s8Qajy
         oIaQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqwkw5xobF6Y6ZYk3AgkecdUmr5Uc3KlK5lSKdp+S/uN5pfb0rQzxvsACMUovJSkZ5QE0OkEa9Y7q0=@vger.kernel.org
X-Gm-Message-State: AFuF++l1nUoIoox4oSbUH4FOBxLLQfBIQdHghz2OJa7r6+3ZJTPn8U8P
	UcoiMskGvdlhtUlAmvEr0ZoskBN12h6LaN08V+DqgT9jcExswD1wtZBuJP0+ODeKexLCWsxmeKz
	qQBIXrrfePqmdrs/8D2MBfb7MEML98/AqSA==
X-Received: from pgbfm25.prod.google.com ([2002:a05:6a02:4999:b0:c88:e5cb:265])
 (user=rathodpriyank job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:729d:b0:3d1:deec:9265 with SMTP id adf61e73a8af0-3d26752f2d7mr4619179637.6.1787878877218;
 Thu, 27 Aug 2026 18:01:17 -0700 (PDT)
Date: Fri, 28 Aug 2026 01:01:03 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAM/dkGoC/1WMTQ6DIBgFr2JYlwb5K+2q92i6APxUEhUDhrQx3
 L1omtQu5+XNrChCcBDRrVpRgOSi81OBy6lCttdTB9g1hRElVBJVKzxbB3gYF8wI541QUmuwqNz
 nAK177anHs3Dv4uLDey8nsa3fCCW/SBK4xlfODDMEamXae+d9N8DZ+hFtlSSPJj+YsphGG26BM tZq8WfmnD/zbYKb2wAAAA==
X-Change-Id: 20260818-pcie-lmt-3044d586aaec
X-Mailer: b4 0.14.3
Message-ID: <20260828-pcie-lmt-v7-1-6012e9e0940a@google.com>
Subject: [PATCH v7] PCI/pcie: Add PCIe Lane Margining at Receiver (LMR) support
From: Priyank Rathod <rathodpriyank@google.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Priyank Rathod <rathodpriyank@google.com>, 
	Shuah Khan <shuah@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-doc@vger.kernel.org, 
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
Changes in v7:
  - Implemented dedicated ASPM Inhibit API (pci_lmr_aspm_inhibit) strictly =
enforcing PCIe Base Specification Revision 7.0 sec 7.5.3.7 sequencing (Down=
stream Component first on disable, Upstream Component first on restore) wit=
h 2-3ms L0 settling.
  - Added pci_lmr_ensure_aspm_inhibited() before executing physical margin =
steps to protect against out-of-band ASPM re-enabling.
  - Eliminated pci_bus_sem lock inversion by resolving link partners once b=
efore acquiring device locks and referencing them via pci_lmr_get_ports().
  - Switched pci_reset_lmr() to asynchronous pm_runtime_put() for remote pa=
rtner to prevent stranding it in D0 without blocking local device reset.
  - Aligned all specification citations, table numbers (Table 4-77 / Table =
4-73), and register bitfields to PCIe Base Spec r7.0 and r6.0.
  - Wrapped comments to stay within 100-column checkpatch limit and added @=
partner kerneldoc description.
  - Link to v6: https://lore.kernel.org/r/20260824-pcie-lmt-v6-1-bab4ce233f=
a5@google.com

Changes in v6:
  - Added kernel documentation under Documentation/PCI/pcie-lmr.rst and ind=
exed in Documentation/PCI/index.rst (Ilpo J=C3=A4rvinen).
  - Updated MAINTAINERS with Documentation/PCI/pcie-lmr.rst (Ilpo J=C3=A4rv=
inen).
  - Aligned capability bit naming and comments with PCIe Base Specification=
 r6.0 sec 8.4.4 Table "Report Margining Capabilities Payload" (Ilpo J=C3=A4=
rvinen).
  - Clarified Sample Multiple Receivers concurrency verification and rules =
across physical lanes in kerneldoc and documentation (Ilpo J=C3=A4rvinen).
  - Refactored pci_lmr_run_cmd() to pass struct pci_margin_dev *mdev direct=
ly, eliminating redundant NULL checks and using mdev->num_lanes (Ilpo J=C3=
=A4rvinen).
  - Converted PCI config read/write return checking across all helpers to p=
cibios_err_to_errno() (Ilpo J=C3=A4rvinen).
  - Reversed return logic in pci_lmr_demargin_lane() to return early on err=
or (Ilpo J=C3=A4rvinen).
  - Refactored margin_lane_step_write() to eliminate bool is_voltage parame=
ter, using command type (LMR_TYPE_TIMING / LMR_TYPE_VOLTAGE) and switch/cas=
e with consolidated bounds checks (Ilpo J=C3=A4rvinen).
  - Renamed __pci_suspend_lmr_locked() to pci_lmr_disable_locked() to avoid=
 PM terminology confusion and added lockdep_assert_held(&mdev->lock) (Ilpo =
J=C3=A4rvinen).
  - Replaced -EACCES with -EBUSY across debugfs show/write callbacks when m=
argining is inactive (Ilpo J=C3=A4rvinen).
  - Clarified comment for active operating link speed check (Gen4+ capabili=
ty vs dynamically operating speed) in margin_enable_write() (Ilpo J=C3=A4rv=
inen).
  - Added WARN_ON_ONCE(!dev) check in pci_lmr_init() (Ilpo J=C3=A4rvinen).
  - Demoted capability detection log message from pci_info to pci_dbg to pr=
event boot log noise (Ilpo J=C3=A4rvinen).
  - Fixed timing step mask extraction in pci_lmr_cache_rx_info() to use 6-b=
it LMR_TIMING_STEP_MASK (sashiko-bot).
  - Resumed runtime PM via pm_runtime_resume_and_get() before performing co=
nfig space reads in margin_enable_write() (sashiko-bot).
  - Switched to pm_runtime_put_sync() during margining teardown (sashiko-bo=
t).
  - Link to v5: https://lore.kernel.org/r/20260820-pcie-lmt-v5-1-943b3b0e18=
bf@google.com

PCI/pcie: Add PCIe Lane Margining at Receiver (LMR) support

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
 Documentation/PCI/index.rst                  |    1 +
 Documentation/PCI/pcie-lmr.rst               |  174 +++
 MAINTAINERS                                  |    8 +
 drivers/pci/pci-driver.c                     |    2 +
 drivers/pci/pci.c                            |    1 +
 drivers/pci/pci.h                            |   17 +
 drivers/pci/pcie/Kconfig                     |   12 +
 drivers/pci/pcie/Makefile                    |    1 +
 drivers/pci/pcie/margin.c                    | 1618 ++++++++++++++++++++++=
++++
 drivers/pci/probe.c                          |    1 +
 drivers/pci/remove.c                         |    2 +-
 include/linux/pci.h                          |    6 +
 include/uapi/linux/pci_regs.h                |   18 +
 tools/testing/selftests/Makefile             |    1 +
 tools/testing/selftests/pcie_lmt/Makefile    |    3 +
 tools/testing/selftests/pcie_lmt/pcie_lmt.sh |  105 ++
 16 files changed, 1969 insertions(+), 1 deletion(-)

diff --git a/Documentation/PCI/index.rst b/Documentation/PCI/index.rst
index 5d720d2a415e..9170c98cbf3f 100644
--- a/Documentation/PCI/index.rst
+++ b/Documentation/PCI/index.rst
@@ -20,3 +20,4 @@ PCI Bus Subsystem
    controller/index
    boot-interrupts
    tph
+   pcie-lmr
diff --git a/Documentation/PCI/pcie-lmr.rst b/Documentation/PCI/pcie-lmr.rs=
t
new file mode 100644
index 000000000000..ffcd4fcf72cc
--- /dev/null
+++ b/Documentation/PCI/pcie-lmr.rst
@@ -0,0 +1,174 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
+PCI Express Lane Margining at Receiver (LMR) Subsystem
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
+
+:Author: Priyank Rathod <rathodpriyank@google.com>
+:Copyright: 2026 Google LLC
+
+Overview
+=3D=3D=3D=3D=3D=3D=3D=3D
+
+Lane Margining at Receiver (LMR), specified in the PCI Express Base
+Specification (Revision 7.0 sec 7.7.11 & sec 8.4.4; r6.0 sec 7.7.10 & sec =
8.4.4),
+allows system software to evaluate high-speed link physical signal integri=
ty and
+eye margins. LMR measures available timing (jitter/phase) and voltage marg=
in
+offsets for each physical lane and receiver independently while the link i=
s
+operating in active L0 state.
+
+Lane Margining Extended Capability (ID 0x27) is optional for links operati=
ng at
+16.0 GT/s (PCIe Gen 4) and 32.0 GT/s (Gen 5), and is mandatory for receive=
rs
+operating at 64.0 GT/s (Gen 6) and higher.
+
+Target Receivers
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Each physical lane can margin up to 7 distinct receivers per PCIe link:
+
+* **Receiver 0 (Local Receiver)**: The receiver in the immediate link part=
ner.
+* **Receivers 1 to 6 (Retimers)**: Retimer pseudo-ports along the physical=
 link
+  (up to 3 retimers, each with upstream and downstream pseudo-ports).
+* **Receiver 7**: Reserved per PCIe Base Specification.
+
+Kernel Configuration
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Enable the kernel configuration option under PCI support:
+
+.. code-block:: none
+
+   CONFIG_PCIE_LMR=3Dy (or =3Dm)
+
+Dependencies:
+* ``CONFIG_PCI``
+* ``CONFIG_DEBUG_FS``
+
+Debugfs Interface Guide
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+When an LMR-capable device is enumerated on a Gen4+ link, the kernel expos=
es
+per-device control and status files under debugfs:
+
+.. code-block:: none
+
+   /sys/kernel/debug/pci/pcie_lmr_<domain>:<bus>:<dev>.<func>/
+
+Device-Level Attributes
+-----------------------
+
+* ``capabilities`` (read-only):
+  Displays the 16-bit Margining Port Capabilities register and whether the
+  device uses the Software Ready handshake bit.
+
+* ``port_status`` (read-only):
+  Displays the Margining Port Status register, indicating Margining Ready =
and
+  SW Ready states.
+
+* ``enable`` (read-write):
+  Enables (``1``) or disables (``0``) Lane Margining on the device.
+  Enabling margining locks the link into D0, prevents runtime PM suspend,
+  disables ASPM L0s/L1, disables hardware autonomous link width/speed chan=
ges,
+  and verifies that the link is operating at >=3D 16.0 GT/s.
+  Disabling margining restores ASPM, hardware autonomous width/speed setti=
ngs,
+  and runtime PM, and returns all lanes to nominal (normal) operating sett=
ings.
+
+Lane-Level Attributes
+---------------------
+
+For each physical lane (``lane0``, ``lane1``, ...):
+
+* ``receiver`` (read-write):
+  Gets or sets the active target receiver number (``0`` for local receiver=
,
+  ``1..6`` for retimers). Switching receivers automatically clears previou=
s
+  offsets back to normal settings per PCIe single-receiver margining requi=
rements.
+
+* ``caps`` (read-only):
+  Reports the target receiver's margining capabilities (PCIe Base Specific=
ation
+  Revision 7.0 Table 4-77 and Table 8-13; r6.0 Table 4-73 & Table 8-11):
+  - Voltage Margining support (supported vs unsupported)
+  - Independent Left/Right Timing Margining support (independent vs symmet=
ric)
+  - Independent Up/Down Voltage Margining support (independent vs symmetri=
c)
+  - Error Sampler vs Main Sampler (independent error sampler vs intrusive =
main sampler)
+  - Sample Reporting Method (sampling rate vs sample count)
+
+* ``num_timing_steps`` (read-only):
+  Maximum timing margin steps supported by the receiver (0..63).
+
+* ``num_voltage_steps`` (read-only):
+  Maximum voltage margin steps supported by the receiver (0..127).
+
+* ``margin_timing`` (read-write):
+  Applies timing margin step offset (+/-). Writing ``0`` clears timing mar=
gin
+  back to nominal.
+
+* ``margin_voltage`` (read-write):
+  Applies voltage margin step offset (+/-). Writing ``0`` clears voltage m=
argin
+  back to nominal.
+
+Manual Margining Example
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+1. Inspect device capabilities and status:
+
+.. code-block:: sh
+
+   cat /sys/kernel/debug/pci/pcie_lmr_0000:01:00.0/capabilities
+   cat /sys/kernel/debug/pci/pcie_lmr_0000:01:00.0/port_status
+
+2. Enable Lane Margining mode:
+
+.. code-block:: sh
+
+   echo 1 > /sys/kernel/debug/pci/pcie_lmr_0000:01:00.0/enable
+
+3. Configure target receiver and inspect step limits on lane 0:
+
+.. code-block:: sh
+
+   echo 0 > /sys/kernel/debug/pci/pcie_lmr_0000:01:00.0/lane0/receiver
+   cat /sys/kernel/debug/pci/pcie_lmr_0000:01:00.0/lane0/caps
+   cat /sys/kernel/debug/pci/pcie_lmr_0000:01:00.0/lane0/num_timing_steps
+   cat /sys/kernel/debug/pci/pcie_lmr_0000:01:00.0/lane0/num_voltage_steps
+
+4. Apply timing and voltage margin steps:
+
+.. code-block:: sh
+
+   # Step timing margin +2 steps
+   echo 2 > /sys/kernel/debug/pci/pcie_lmr_0000:01:00.0/lane0/margin_timin=
g
+
+   # Step voltage margin +1 step
+   echo 1 > /sys/kernel/debug/pci/pcie_lmr_0000:01:00.0/lane0/margin_volta=
ge
+
+5. Reset margins back to nominal:
+
+.. code-block:: sh
+
+   echo 0 > /sys/kernel/debug/pci/pcie_lmr_0000:01:00.0/lane0/margin_timin=
g
+   echo 0 > /sys/kernel/debug/pci/pcie_lmr_0000:01:00.0/lane0/margin_volta=
ge
+
+6. Disable Lane Margining when complete:
+
+.. code-block:: sh
+
+   echo 0 > /sys/kernel/debug/pci/pcie_lmr_0000:01:00.0/enable
+
+Automated Testing via Kselftest
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
+
+The kernel includes an automated kselftest script under
+``tools/testing/selftests/pcie_lmt/pcie_lmt.sh`` to probe, validate, and e=
xercise
+debugfs controls across all enumerated LMR devices.
+
+Run directly as root:
+
+.. code-block:: sh
+
+   sudo ./tools/testing/selftests/pcie_lmt/pcie_lmt.sh
+
+Or run via the kselftest test harness:
+
+.. code-block:: sh
+
+   make -C tools/testing/selftests TARGETS=3Dpcie_lmt run_tests
diff --git a/MAINTAINERS b/MAINTAINERS
index b7094a616afd..b5deaae11bfe 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21059,6 +21059,14 @@ F:	Documentation/devicetree/bindings/pci/qcom,sa82=
55p-pcie-ep.yaml
 F:	drivers/pci/controller/dwc/pcie-qcom-common.c
 F:	drivers/pci/controller/dwc/pcie-qcom-ep.c
=20
+PCIE LANE MARGINING AT RECEIVER (LMR)
+M:	Priyank Rathod <rathodpriyank@google.com>
+L:	linux-pci@vger.kernel.org
+S:	Maintained
+F:	Documentation/PCI/pcie-lmr.rst
+F:	drivers/pci/pcie/margin.c
+F:	tools/testing/selftests/pcie_lmt/
+
 PCMCIA SUBSYSTEM
 M:	Dominik Brodowski <linux@dominikbrodowski.net>
 S:	Odd Fixes
diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index f36778e62ac1..ded3925aab1d 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -743,6 +743,8 @@ static int pci_pm_prepare(struct device *dev)
=20
 	dev_pm_set_strict_midlayer(dev, true);
=20
+	pci_suspend_lmr(pci_dev);
+
 	if (pm && pm->prepare) {
 		int error =3D pm->prepare(dev);
 		if (error < 0)
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 77b17b13ee61..e6d8cd0094f1 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5058,6 +5058,7 @@ static void pci_dev_save_and_disable(struct pci_dev *=
dev)
 	 */
 	pci_set_power_state(dev, PCI_D0);
=20
+	pci_reset_lmr(dev);
 	pci_save_state(dev);
 	/*
 	 * Disable the device by clearing the Command register, except for
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 4469e1a77f3c..ea66fb65a848 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -796,6 +796,11 @@ static inline bool pci_dev_test_and_set_removed(struct=
 pci_dev *dev)
 	return test_and_set_bit(PCI_DEV_REMOVED, &dev->priv_flags);
 }
=20
+static inline bool pci_dev_is_removed(struct pci_dev *dev)
+{
+	return test_bit(PCI_DEV_REMOVED, &dev->priv_flags);
+}
+
 static inline void pci_dev_allow_binding(struct pci_dev *dev)
 {
 	set_bit(PCI_DEV_ALLOW_BINDING, &dev->priv_flags);
@@ -1023,6 +1028,18 @@ static inline void pci_no_tph(void) { }
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
index 000000000000..a428726c500d
--- /dev/null
+++ b/drivers/pci/pcie/margin.c
@@ -0,0 +1,1618 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PCI Express Lane Margining at Receiver
+ *
+ * Copyright (C) 2026 Google LLC
+ * Author: Priyank Rathod <rathodpriyank@google.com>
+ *
+ * Lane Margining at Receiver (PCIe Base Specification Revision 7.0, sec 7=
.7.11 &
+ * sec 8.4.4; r6.0 sec 7.7.10 & sec 8.4.4) allows system software to deter=
mine
+ * the voltage and timing margins of each physical lane on a PCIe link. Th=
e
+ * Extended Capability (ID 0x27) is available for receivers operating at 1=
6.0 GT/s
+ * (Gen4) or higher data rates, and is mandatory for receivers operating a=
t 64.0 GT/s
+ * (Gen6) or higher data rates.
+ *
+ * This driver implements:
+ *   - Probing Extended Capability ID 0x27 and Margining Port Capabilities=
.
+ *   - Managing ASPM L0s/L1 link states during active margining with resto=
ration.
+ *   - PCIe Base Specification NO_CMD (0x7) clearing handshake per receive=
r and lane.
+ *   - Caching receiver capabilities & step counts to avoid side-effects
+ *     when setting to normal settings.
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
+/*
+ * Margining Type (MTYPE) field encodings (bits 5:3) in Margining Lane Con=
trol
+ * and Margining Lane Status registers per PCIe Base Specification Revisio=
n 7.0:
+ * - Section 7.7.11 "Lane Margining at the Receiver Extended Capability (I=
D 0x27)"
+ *   (Margining Lane Control Register & Margining Lane Status Register)
+ *   [r6.0 Section 7.7.10]
+ * - Section 4.2.18.2 "Margin Command and Response Flow"
+ *   (Table 4-77 "Margin Commands and Corresponding Responses")
+ *   [r6.0 Table 4-73]
+ *
+ * Encodings:
+ *   001b (0x1) - Report Margin Control Capabilities
+ *   010b (0x2) - Set Margining Parameters (Go to Normal Settings, Clear E=
rror Log)
+ *   011b (0x3) - Step Margin Timing
+ *   100b (0x4) - Step Margin Voltage
+ *   111b (0x7) - No Command
+ *   (000b, 101b-110b are Reserved)
+ */
+#define LMR_TYPE_REPORT_CAPS 0x1 /* Report Margin Control Capabilities */
+#define LMR_TYPE_SET_PARAMS 0x2 /* Set Margining Parameters */
+#define LMR_TYPE_TIMING 0x3 /* Step Margin Timing */
+#define LMR_TYPE_VOLTAGE 0x4 /* Step Margin Voltage */
+#define LMR_TYPE_NO_CMD 0x7 /* No Command */
+
+/* Command Payloads per PCIe Base Specification Revision 7.0 Table 4-77 (r=
6.0 Table 4-73) */
+#define LMR_PAYLOAD_REPORT_CAPS 0x88 /* Report Margin Control Capabilities=
 */
+#define LMR_PAYLOAD_REPORT_VOLT_STEPS 0x89 /* Report Margining Voltage Ste=
ps */
+#define LMR_PAYLOAD_REPORT_TIM_STEPS 0x8A /* Report Margining Timing Steps=
 */
+#define LMR_PAYLOAD_GO_TO_NORMAL 0x0F /* Go to Normal Settings */
+#define LMR_PAYLOAD_CLEAR_ERROR_LOG 0x55 /* Clear Error Log */
+#define LMR_PAYLOAD_NO_CMD 0x9C /* No Command */
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
+ * LMR parameter limits per PCIe Base Specification Revision 7.0:
+ * - Max lanes (32): sec 7.7.11 & Table 8-13 (MMaxLanes max 31)
+ * - Receiver numbers 0..6: Table 4-76 (assignment) & Table 4-77 (valid fo=
r commands)
+ * - Max timing step (63): sec 4.2.18.1.2, Table 4-77 (8Ah), & Table 8-13
+ * - Max voltage step (127): sec 4.2.18.1.2, Table 4-77 (89h), & Table 8-1=
3
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
+/*
+ * Margining Payload field masks for Step Margin Timing and Step Margin Vo=
ltage
+ * per PCIe Base Specification Revision 7.0 sec 4.2.18.1.2
+ * ("Margin Payload for Step Margin Commands"):
+ *
+ * Step Margin Timing Payload:
+ *   Bit 7:    Reserved (must be 0b)
+ *   Bit 6:    Direction (0 =3D Left/Decrease, 1 =3D Right/Increase)
+ *   Bits 5:0: Margin Step (0..63)
+ *
+ * Step Margin Voltage Payload:
+ *   Bit 7:    Direction (0 =3D Down/Decrease, 1 =3D Up/Increase)
+ *   Bits 6:0: Margin Step (0..127)
+ */
+#define LMR_TIMING_STEP_MASK		GENMASK(5, 0)
+#define LMR_TIMING_DIR_MASK		BIT(6)
+#define LMR_VOLTAGE_STEP_MASK		GENMASK(6, 0)
+#define LMR_VOLTAGE_DIR_MASK		BIT(7)
+
+/*
+ * Margin Payload step direction field encodings per PCIe Base Specificati=
on
+ * Revision 7.0 sec 4.2.18.1.2 ("Margin Payload for Step Margin Commands")=
:
+ *
+ * For timing:
+ *   Bit 6: 0b =3D Right of normal setting (also 0b Reserved for symmetric=
)
+ *          1b =3D Left of normal setting (when MIndLeftRightTiming is Set=
)
+ * For voltage:
+ *   Bit 7: 0b =3D Up from normal setting (also 0b Reserved for symmetric)
+ *          1b =3D Down from normal setting (when MIndUpDownVoltage is Set=
)
+ */
+#define LMR_STEP_DIR_RIGHT_OR_UP	0
+#define LMR_STEP_DIR_LEFT_OR_DOWN	1
+
+/*
+ * Report Margin Control Capabilities (Command 88h) response payload bit f=
ields
+ * per PCIe Base Specification Revision 7.0 Table 4-77 & Table 8-13 (r6.0 =
Table 4-73 & Table 8-11):
+ *   Bit 0:   MVoltageSupported (1 =3D Voltage margining supported; 0 =3D =
Not supported)
+ *   Bit 1:   MIndUpDownVoltage (1 =3D Independent Up/Down voltage support=
ed; 0 =3D Symmetric)
+ *   Bit 2:   MIndLeftRightTiming (1 =3D Independent Left/Right timing sup=
ported; 0 =3D Symmetric)
+ *   Bit 3:   MSampleReportingMethod (1 =3D Sampling rate supported; 0 =3D=
 Sample count supported)
+ *   Bit 4:   MIndErrorSampler (1 =3D Independent error sampler; 0 =3D Mai=
n data sampler)
+ *   Bits 7:5: Reserved
+ */
+#define LMR_CAP_VOLTAGE_SUPPORTED BIT(0)
+#define LMR_CAP_IND_UP_DOWN_VOLTAGE BIT(1)
+#define LMR_CAP_IND_LEFT_RIGHT_TIMING	BIT(2)
+#define LMR_CAP_SAMPLE_REPORT_METHOD BIT(3)
+#define LMR_CAP_IND_ERROR_SAMPLER BIT(4)
+
+/*
+ * Step Margin Execution Status (Bits 7:6 of response payload per PCIe Bas=
e
+ * Specification Revision 7.0 sec 4.2.18.1.1 "Step Margin Execution Status=
"):
+ * 00b: Too many errors - Receiver autonomously went back to default setti=
ngs
+ * 01b: Set up for margin in progress
+ * 10b: Margining in progress
+ * 11b: NAK - Unsupported Lane Margining command was issued
+ */
+#define LMR_STS_EXEC_MASK GENMASK(7, 6)
+#define LMR_STS_EXEC_TOO_MANY_ERR 0x0
+#define LMR_STS_EXEC_SETUP_IN_PROGRESS 0x1
+#define LMR_STS_EXEC_IN_PROGRESS 0x2
+#define LMR_STS_EXEC_NAK 0x3
+#define LMR_STS_ERR_CNT_MASK GENMASK(5, 0)
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
+ * @partner: Connected link partner device across the PCIe link
+ * @cap: Extended capability offset (PCI_EXT_CAP_ID_LMR)
+ * @debugfs: Root debugfs dentry for this device
+ * @lock: Mutex protecting LMR hardware access, active margining enablemen=
t,
+ *        target receiver selection, lane margining steps, and ASPM state
+ * @enabled: True if Lane Margining is currently enabled
+ * @aspm_saved: True if original ASPM configuration has been saved
+ * @saved_dsp_aspm: Saved ASPM control register bits for Downstream Port
+ * @saved_usp_aspm: Saved ASPM control register bits for Upstream Port
+ * @autonomous_saved: True if original autonomous width/speed configuratio=
n has been saved
+ * @saved_dsp_lnkctl: Saved Link Control register bits for Downstream Port
+ * @saved_dsp_lnkctl2: Saved Link Control 2 register bits for Downstream P=
ort
+ * @saved_usp_lnkctl: Saved Link Control register bits for Upstream Port
+ * @saved_usp_lnkctl2: Saved Link Control 2 register bits for Upstream Por=
t
+ * @num_lanes: Number of lanes on the link
+ * @lanes: Flexible array of per-lane state structures
+ */
+struct pci_margin_dev {
+	struct pci_dev *dev;
+	struct pci_dev *partner;
+	u16 cap;
+	struct dentry *debugfs;
+	struct mutex lock;
+	bool enabled;
+	bool aspm_saved;
+	u16 saved_dsp_aspm;
+	u16 saved_usp_aspm;
+	bool autonomous_saved;
+	u16 saved_dsp_lnkctl;
+	u16 saved_dsp_lnkctl2;
+	u16 saved_usp_lnkctl;
+	u16 saved_usp_lnkctl2;
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
+ * pci_lmr_get_link_partners() - Identify Downstream and Upstream Port lin=
k partners.
+ *
+ * For Root Ports and Switch Downstream Ports, @dev is the Downstream Port=
, and the
+ * connected device on the secondary bus is the Upstream Port.
+ * For Endpoints and Switch Upstream Ports, @dev is the Upstream Port, and=
 the
+ * upstream bridge is the Downstream Port.
+ */
+static void pci_lmr_get_link_partners(struct pci_dev *dev,
+				      struct pci_dev **downstream_port,
+				      struct pci_dev **upstream_port)
+{
+	if (pci_pcie_type(dev) =3D=3D PCI_EXP_TYPE_ROOT_PORT ||
+	    pci_pcie_type(dev) =3D=3D PCI_EXP_TYPE_DOWNSTREAM) {
+		*downstream_port =3D dev;
+		down_read(&pci_bus_sem);
+		*upstream_port =3D dev->subordinate ?
+			pci_dev_get(list_first_entry_or_null(&dev->subordinate->devices,
+							     struct pci_dev, bus_list)) : NULL;
+		up_read(&pci_bus_sem);
+	} else {
+		*downstream_port =3D pci_upstream_bridge(dev);
+		*upstream_port =3D dev;
+	}
+}
+
+static void pci_lmr_put_link_partners(struct pci_dev *dev,
+				      struct pci_dev *downstream_port,
+				      struct pci_dev *upstream_port)
+{
+	if (pci_pcie_type(dev) =3D=3D PCI_EXP_TYPE_ROOT_PORT ||
+	    pci_pcie_type(dev) =3D=3D PCI_EXP_TYPE_DOWNSTREAM) {
+		if (upstream_port)
+			pci_dev_put(upstream_port);
+	}
+}
+
+/*
+ * pci_lmr_get_ports() - Identify Downstream and Upstream Port link partne=
rs
+ * using the already tracked mdev->dev and mdev->partner devices.
+ *
+ * For Root Ports and Switch Downstream Ports, @dev is the Downstream Port=
 and
+ * @partner is the Upstream Port. For Endpoints and Switch Upstream Ports,
+ * @partner is the Downstream Port and @dev is the Upstream Port.
+ *
+ * Context: Called with mdev->lock held and partner already established.
+ * Does NOT acquire pci_bus_sem, preventing lock inversion deadlocks with
+ * device_lock.
+ */
+static void pci_lmr_get_ports(struct pci_margin_dev *mdev,
+			      struct pci_dev **downstream_port,
+			      struct pci_dev **upstream_port)
+{
+	struct pci_dev *dev =3D mdev->dev;
+	struct pci_dev *partner =3D mdev->partner;
+
+	if (pci_pcie_type(dev) =3D=3D PCI_EXP_TYPE_ROOT_PORT ||
+	    pci_pcie_type(dev) =3D=3D PCI_EXP_TYPE_DOWNSTREAM) {
+		*downstream_port =3D dev;
+		*upstream_port =3D partner;
+	} else {
+		*downstream_port =3D partner;
+		*upstream_port =3D dev;
+	}
+}
+
+/*
+ * pci_lmr_aspm_inhibit() - Inhibit or restore ASPM L0s/L1 during active m=
argining.
+ * PCIe Base Specification Revision 7.0 sec 7.5.3.7 ("Link Control Registe=
r"):
+ * - To disable/inhibit ASPM, software on Downstream Component (Endpoint /=
 Upstream Port)
+ *   must disable ASPM prior to disabling ASPM on Upstream Component (Root=
 Port / Downstream Port).
+ * - To enable/restore ASPM, software on Upstream Component (Root Port / D=
ownstream Port)
+ *   must enable ASPM prior to enabling ASPM on Downstream Component (Endp=
oint / Upstream Port).
+ */
+static void pci_lmr_aspm_inhibit(struct pci_margin_dev *mdev, bool inhibit=
)
+{
+	struct pci_dev *downstream_port, *upstream_port;
+	struct pci_dev *partner =3D mdev->partner;
+	u16 ctl;
+
+	pci_lmr_get_ports(mdev, &downstream_port, &upstream_port);
+
+	if (inhibit) {
+		if (mdev->aspm_saved)
+			return;
+
+		/*
+		 * If link partner already saved ASPM state, inherit it to
+		 * prevent overwriting with 0.
+		 */
+		if (partner && partner->lmr && partner->lmr->aspm_saved) {
+			mdev->saved_dsp_aspm =3D partner->lmr->saved_dsp_aspm;
+			mdev->saved_usp_aspm =3D partner->lmr->saved_usp_aspm;
+			mdev->aspm_saved =3D true;
+			return;
+		}
+
+		/*
+		 * 1. Downstream Component (upstream_port) must be disabled
+		 * FIRST per sec 7.5.3.7.
+		 */
+		if (upstream_port && pci_is_pcie(upstream_port) &&
+		    upstream_port->current_state =3D=3D PCI_D0) {
+			if (!pcie_capability_read_word(upstream_port, PCI_EXP_LNKCTL, &ctl)) {
+				mdev->saved_usp_aspm =3D ctl & PCI_EXP_LNKCTL_ASPMC;
+				pcie_capability_clear_word(upstream_port, PCI_EXP_LNKCTL,
+							   PCI_EXP_LNKCTL_ASPMC);
+			}
+		}
+
+		/*
+		 * 2. Upstream Component (downstream_port) must be disabled
+		 * SECOND per sec 7.5.3.7.
+		 */
+		if (downstream_port && pci_is_pcie(downstream_port) &&
+		    downstream_port->current_state =3D=3D PCI_D0) {
+			if (!pcie_capability_read_word(downstream_port, PCI_EXP_LNKCTL, &ctl)) =
{
+				mdev->saved_dsp_aspm =3D ctl & PCI_EXP_LNKCTL_ASPMC;
+				pcie_capability_clear_word(downstream_port, PCI_EXP_LNKCTL,
+							   PCI_EXP_LNKCTL_ASPMC);
+			}
+		}
+
+		mdev->aspm_saved =3D true;
+
+		/*
+		 * Ensure link is settled in L0 mode per PCIe Base
+		 * Specification Revision 7.0 sec 8.4.4.
+		 */
+		usleep_range(2000, 3000);
+	} else {
+		if (!mdev->aspm_saved)
+			return;
+
+		/*
+		 * 1. Upstream Component (downstream_port) MUST be restored
+		 * FIRST per sec 7.5.3.7.
+		 */
+		if (downstream_port && pci_is_pcie(downstream_port) &&
+		    downstream_port->current_state =3D=3D PCI_D0) {
+			pcie_capability_clear_and_set_word(
+				downstream_port, PCI_EXP_LNKCTL, PCI_EXP_LNKCTL_ASPMC,
+				mdev->saved_dsp_aspm);
+		}
+
+		/*
+		 * 2. Downstream Component (upstream_port) MUST be restored
+		 * SECOND per sec 7.5.3.7.
+		 */
+		if (upstream_port && pci_is_pcie(upstream_port) &&
+		    upstream_port->current_state =3D=3D PCI_D0) {
+			pcie_capability_clear_and_set_word(
+				upstream_port, PCI_EXP_LNKCTL, PCI_EXP_LNKCTL_ASPMC,
+				mdev->saved_usp_aspm);
+		}
+
+		mdev->aspm_saved =3D false;
+	}
+}
+
+/*
+ * pci_lmr_ensure_aspm_inhibited() - Verify and re-enforce ASPM inhibit st=
ate.
+ *
+ * Checks both Downstream Port and Upstream Port to guarantee that out-of-=
band
+ * OS events (e.g. background power transitions or sysfs modifications) ha=
ve
+ * not unexpectedly re-enabled ASPM on either component. If ASPM was re-en=
abled,
+ * re-inhibits it in the spec-mandated order and waits for the link to set=
tle
+ * in L0 before physical lane margin steps are executed.
+ */
+static void pci_lmr_ensure_aspm_inhibited(struct pci_margin_dev *mdev)
+{
+	struct pci_dev *downstream_port, *upstream_port;
+	u16 dsp_ctl =3D 0, usp_ctl =3D 0;
+	bool re_inhibit =3D false;
+
+	pci_lmr_get_ports(mdev, &downstream_port, &upstream_port);
+
+	if (upstream_port && pci_is_pcie(upstream_port)) {
+		if (!pcie_capability_read_word(upstream_port, PCI_EXP_LNKCTL, &usp_ctl) =
&&
+		    (usp_ctl & PCI_EXP_LNKCTL_ASPMC))
+			re_inhibit =3D true;
+	}
+
+	if (downstream_port && pci_is_pcie(downstream_port)) {
+		if (!pcie_capability_read_word(downstream_port, PCI_EXP_LNKCTL, &dsp_ctl=
) &&
+		    (dsp_ctl & PCI_EXP_LNKCTL_ASPMC))
+			re_inhibit =3D true;
+	}
+
+	if (re_inhibit) {
+		pci_info_ratelimited(mdev->dev,
+				     "ASPM re-enabled unexpectedly; re-enforcing ASPM inhibit for LMR\=
n");
+		/* Disable Downstream Component first, Upstream Component second per sec=
 7.5.3.7 */
+		if (upstream_port && pci_is_pcie(upstream_port))
+			pcie_capability_clear_word(upstream_port, PCI_EXP_LNKCTL,
+						   PCI_EXP_LNKCTL_ASPMC);
+		if (downstream_port && pci_is_pcie(downstream_port))
+			pcie_capability_clear_word(downstream_port, PCI_EXP_LNKCTL,
+						   PCI_EXP_LNKCTL_ASPMC);
+		/* Ensure link returns to and settles in L0 mode before proceeding */
+		usleep_range(2000, 3000);
+	}
+}
+
+/*
+ * Helpers to manage Autonomous Width/Speed transitions per PCIe Base Spec=
ification Revision 7.0:
+ * - Section 7.5.3.7 "Link Control Register" (Hardware Autonomous Width Di=
sable, bit 9)
+ * - Section 7.5.3.17 "Link Control 2 Register" (Hardware Autonomous Speed=
 Disable, bit 5)
+ * - Section 4.2.18.4 "Receiver Margin Testing Requirements"
+ * - Section 8.4.4 "Lane Margining at the Receiver - Electrical Requiremen=
ts"
+ *
+ * Both Downstream Port and Upstream Port must save and set Hardware Auton=
omous
+ * Width Disable and Hardware Autonomous Speed Disable bits during margini=
ng to
+ * guarantee that the link remains in a stable active L0 state.
+ */
+static void pci_lmr_disable_autonomous(struct pci_margin_dev *mdev)
+{
+	struct pci_dev *downstream_port, *upstream_port;
+	struct pci_dev *partner =3D mdev->partner;
+	u16 lnkctl, lnkctl2;
+
+	if (mdev->autonomous_saved)
+		return;
+
+	/* If link partner already saved autonomous settings, inherit them */
+	if (partner && partner->lmr && partner->lmr->autonomous_saved) {
+		mdev->saved_dsp_lnkctl =3D partner->lmr->saved_dsp_lnkctl;
+		mdev->saved_dsp_lnkctl2 =3D partner->lmr->saved_dsp_lnkctl2;
+		mdev->saved_usp_lnkctl =3D partner->lmr->saved_usp_lnkctl;
+		mdev->saved_usp_lnkctl2 =3D partner->lmr->saved_usp_lnkctl2;
+		mdev->autonomous_saved =3D true;
+		return;
+	}
+
+	pci_lmr_get_ports(mdev, &downstream_port, &upstream_port);
+
+	/* 1. Downstream Component (upstream_port): Save and Disable FIRST */
+	if (upstream_port && pci_is_pcie(upstream_port) &&
+	    upstream_port->current_state =3D=3D PCI_D0) {
+		if (!pcie_capability_read_word(upstream_port, PCI_EXP_LNKCTL, &lnkctl)) =
{
+			mdev->saved_usp_lnkctl =3D lnkctl;
+			pcie_capability_set_word(upstream_port, PCI_EXP_LNKCTL,
+						 PCI_EXP_LNKCTL_HAWD);
+		}
+
+		if (!pcie_capability_read_word(upstream_port, PCI_EXP_LNKCTL2, &lnkctl2)=
) {
+			mdev->saved_usp_lnkctl2 =3D lnkctl2;
+			pcie_capability_set_word(upstream_port, PCI_EXP_LNKCTL2,
+						 PCI_EXP_LNKCTL2_HASD);
+		}
+	}
+
+	/* 2. Upstream Component (downstream_port): Save and Disable SECOND */
+	if (downstream_port && pci_is_pcie(downstream_port) &&
+	    downstream_port->current_state =3D=3D PCI_D0) {
+		if (!pcie_capability_read_word(downstream_port, PCI_EXP_LNKCTL, &lnkctl)=
) {
+			mdev->saved_dsp_lnkctl =3D lnkctl;
+			pcie_capability_set_word(downstream_port, PCI_EXP_LNKCTL,
+						 PCI_EXP_LNKCTL_HAWD);
+		}
+
+		if (!pcie_capability_read_word(downstream_port, PCI_EXP_LNKCTL2, &lnkctl=
2)) {
+			mdev->saved_dsp_lnkctl2 =3D lnkctl2;
+			pcie_capability_set_word(downstream_port, PCI_EXP_LNKCTL2,
+						 PCI_EXP_LNKCTL2_HASD);
+		}
+	}
+
+	mdev->autonomous_saved =3D true;
+}
+
+static void pci_lmr_restore_autonomous(struct pci_margin_dev *mdev)
+{
+	struct pci_dev *downstream_port, *upstream_port;
+
+	if (!mdev->autonomous_saved)
+		return;
+
+	pci_lmr_get_ports(mdev, &downstream_port, &upstream_port);
+
+	/* 1. Upstream Component (downstream_port) restored FIRST */
+	if (downstream_port && pci_is_pcie(downstream_port) &&
+	    downstream_port->current_state =3D=3D PCI_D0) {
+		pcie_capability_clear_and_set_word(
+			downstream_port, PCI_EXP_LNKCTL, PCI_EXP_LNKCTL_HAWD,
+			mdev->saved_dsp_lnkctl & PCI_EXP_LNKCTL_HAWD);
+		pcie_capability_clear_and_set_word(
+			downstream_port, PCI_EXP_LNKCTL2, PCI_EXP_LNKCTL2_HASD,
+			mdev->saved_dsp_lnkctl2 & PCI_EXP_LNKCTL2_HASD);
+	}
+
+	/* 2. Downstream Component (upstream_port) restored SECOND */
+	if (upstream_port && pci_is_pcie(upstream_port) &&
+	    upstream_port->current_state =3D=3D PCI_D0) {
+		pcie_capability_clear_and_set_word(
+			upstream_port, PCI_EXP_LNKCTL, PCI_EXP_LNKCTL_HAWD,
+			mdev->saved_usp_lnkctl & PCI_EXP_LNKCTL_HAWD);
+		pcie_capability_clear_and_set_word(
+			upstream_port, PCI_EXP_LNKCTL2, PCI_EXP_LNKCTL2_HASD,
+			mdev->saved_usp_lnkctl2 & PCI_EXP_LNKCTL2_HASD);
+	}
+
+	mdev->autonomous_saved =3D false;
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
+static int pci_lmr_run_cmd(struct pci_margin_dev *mdev, int lane, u8 rx, u=
8 type,
+			   u8 usage, u8 payload, u16 *status_val)
+{
+	struct pci_dev *dev;
+	u16 lmr, ctrl_offset, sts_offset;
+	u16 ctrl, sts;
+	unsigned long timeout;
+	int ret;
+
+	if (!mdev || lane < 0 || lane >=3D mdev->num_lanes || rx > LMR_MAX_RX_NUM=
)
+		return -EINVAL;
+
+	dev =3D mdev->dev;
+	lmr =3D mdev->cap;
+	ctrl_offset =3D lmr + PCI_LMR_LANE_CTRL + LMR_LANE_REG_STRIDE * lane;
+	sts_offset =3D lmr + PCI_LMR_LANE_STS + LMR_LANE_REG_STRIDE * lane;
+
+	/*
+	 * Per PCIe Base Specification Revision 7.0 sec 4.2.18.2 & Table 4-77
+	 * (r6.0 Table 4-73), software must issue NO_CMD (0x7) with payload
+	 * 0x9C targeting the specific receiver (rx) to clear MTYPE in Lane
+	 * Status before issuing a subsequent command.
+	 */
+	if (type !=3D LMR_TYPE_NO_CMD) {
+		ctrl =3D FIELD_PREP(PCI_LMR_LANE_CTRL_RX_NUM, rx) |
+		       FIELD_PREP(PCI_LMR_LANE_CTRL_MTYPE, LMR_TYPE_NO_CMD) |
+		       FIELD_PREP(PCI_LMR_LANE_CTRL_USAGE, 0) |
+		       FIELD_PREP(PCI_LMR_LANE_CTRL_PAYLOAD,
+				  LMR_PAYLOAD_NO_CMD);
+
+		ret =3D pci_write_config_word(dev, ctrl_offset, ctrl);
+		if (ret !=3D PCIBIOS_SUCCESSFUL)
+			return pcibios_err_to_errno(ret);
+
+		timeout =3D jiffies + msecs_to_jiffies(LMR_CMD_TIMEOUT_MS);
+		while (1) {
+			ret =3D pci_read_config_word(dev, sts_offset, &sts);
+			if (ret !=3D PCIBIOS_SUCCESSFUL)
+				return pcibios_err_to_errno(ret);
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
+	ret =3D pci_write_config_word(dev, ctrl_offset, ctrl);
+	if (ret !=3D PCIBIOS_SUCCESSFUL)
+		return pcibios_err_to_errno(ret);
+
+	timeout =3D jiffies + msecs_to_jiffies(LMR_CMD_TIMEOUT_MS);
+	while (1) {
+		ret =3D pci_read_config_word(dev, sts_offset, &sts);
+		if (ret !=3D PCIBIOS_SUCCESSFUL)
+			return pcibios_err_to_errno(ret);
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
+		if (time_after(jiffies, timeout)) {
+			/*
+			 * Per PCIe Base Specification Revision 7.0 sec 4.2.18.2
+			 * & Table 4-77 (r6.0 Table 4-73), if receiver echoes
+			 * NO_CMD (0x7) after command issuance, it indicates NAK.
+			 */
+			if (FIELD_GET(PCI_LMR_LANE_STS_MTYPE, sts) =3D=3D LMR_TYPE_NO_CMD &&
+			    FIELD_GET(PCI_LMR_LANE_STS_RX_NUM, sts) =3D=3D rx)
+				return -EOPNOTSUPP;
+			break;
+		}
+
+		usleep_range(LMR_CMD_SLEEP_MIN_US, LMR_CMD_SLEEP_MAX_US);
+	}
+
+	return -ETIMEDOUT;
+}
+
+/*
+ * pci_lmr_clear_to_normal_lane() - Clear lane margin back to normal setti=
ngs
+ * per PCIe Base Specification Revision 7.0 sec 4.2.18.2 & Table 4-77 (r6.=
0 Table 4-73).
+ * Issues Set Margining Parameters (MTYPE 010b) with "Go to Normal Setting=
s" (Payload 0x0F).
+ */
+static int pci_lmr_clear_to_normal_lane(struct pci_margin_lane *plane)
+{
+	u16 sts;
+	int ret;
+
+	if (!plane || !plane->mdev)
+		return -EINVAL;
+
+	ret =3D pci_lmr_run_cmd(plane->mdev, plane->lane, plane->rx,
+			      LMR_TYPE_SET_PARAMS, 0, LMR_PAYLOAD_GO_TO_NORMAL,
+			      &sts);
+	if (ret)
+		return ret;
+
+	plane->timing_val =3D 0;
+	plane->voltage_val =3D 0;
+	return 0;
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
+	/* Issuing REPORT_CAPS aborts active margin; clear to normal settings */
+	ret =3D pci_lmr_clear_to_normal_lane(plane);
+	if (ret)
+		return ret;
+
+	/* Report Capabilities: MTYPE 001b, Payload 0x88 */
+	ret =3D pci_lmr_run_cmd(plane->mdev, plane->lane, rx,
+			      LMR_TYPE_REPORT_CAPS, 0, LMR_PAYLOAD_REPORT_CAPS,
+			      &sts);
+	if (ret)
+		return ret;
+	info->caps =3D pci_lmr_sts_payload(sts);
+
+	/* Report Timing Steps: MTYPE 001b, Payload 0x8A */
+	ret =3D pci_lmr_run_cmd(plane->mdev, plane->lane, rx,
+			      LMR_TYPE_REPORT_CAPS, 0,
+			      LMR_PAYLOAD_REPORT_TIM_STEPS, &sts);
+	if (ret)
+		return ret;
+	info->num_timing_steps =3D FIELD_GET(LMR_TIMING_STEP_MASK, pci_lmr_sts_pa=
yload(sts));
+
+	/* Report Voltage Steps: MTYPE 001b, Payload 0x89 */
+	ret =3D pci_lmr_run_cmd(plane->mdev, plane->lane, rx,
+			      LMR_TYPE_REPORT_CAPS, 0,
+			      LMR_PAYLOAD_REPORT_VOLT_STEPS, &sts);
+	if (ret)
+		return ret;
+	info->num_voltage_steps =3D FIELD_GET(LMR_VOLTAGE_STEP_MASK, pci_lmr_sts_=
payload(sts));
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
+	int ret;
+
+	/* Wake the hardware and hold the PM reference before accessing registers=
 */
+	ret =3D pm_runtime_resume_and_get(&dev->dev);
+	if (ret < 0)
+		return ret;
+
+	ret =3D pci_read_config_word(dev, mdev->cap + PCI_LMR_PORT_CAP, &cap);
+	pm_runtime_put_sync(&dev->dev);
+
+	if (ret !=3D PCIBIOS_SUCCESSFUL)
+		return pcibios_err_to_errno(ret);
+
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
+	int ret;
+
+	/* Wake the hardware and hold the PM reference before accessing registers=
 */
+	ret =3D pm_runtime_resume_and_get(&dev->dev);
+	if (ret < 0)
+		return ret;
+
+	ret =3D pci_read_config_word(dev, mdev->cap + PCI_LMR_PORT_STS, &sts);
+	pm_runtime_put_sync(&dev->dev);
+
+	if (ret !=3D PCIBIOS_SUCCESSFUL)
+		return pcibios_err_to_errno(ret);
+
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
+static void pci_lmr_disable_locked(struct pci_margin_dev *mdev)
+{
+	struct pci_dev *dev;
+	int i, ret;
+	u16 sts;
+
+	if (!mdev)
+		return;
+
+	lockdep_assert_held(&mdev->lock);
+
+	if (!mdev->enabled)
+		return;
+
+	dev =3D mdev->dev;
+
+	for (i =3D 0; i < mdev->num_lanes; i++)
+		pci_lmr_clear_to_normal_lane(&mdev->lanes[i]);
+
+	ret =3D pci_read_config_word(dev, mdev->cap + PCI_LMR_PORT_STS, &sts);
+	if (ret =3D=3D PCIBIOS_SUCCESSFUL) {
+		sts &=3D ~PCI_LMR_PORT_STS_SW_READY;
+		pci_write_config_word(dev, mdev->cap + PCI_LMR_PORT_STS, sts);
+	}
+	pci_lmr_aspm_inhibit(mdev, false);
+	pci_lmr_restore_autonomous(mdev);
+
+	if (mdev->partner) {
+		pm_runtime_put_sync(&mdev->partner->dev);
+		pci_dev_put(mdev->partner);
+		mdev->partner =3D NULL;
+	}
+
+	pm_runtime_put_sync(&dev->dev);
+	mdev->enabled =3D false;
+}
+
+static int pci_lmr_enable_locked(struct pci_margin_dev *mdev,
+				 struct pci_dev *downstream_port,
+				 struct pci_dev *upstream_port)
+{
+	struct pci_dev *dev =3D mdev->dev;
+	struct pci_dev *partner =3D NULL;
+	unsigned long timeout;
+	u16 sts, cap, lnksta;
+	int ret, i;
+
+	lockdep_assert_held(&mdev->lock);
+
+	/* Ensure device is powered (D0) before reading configuration registers *=
/
+	ret =3D pm_runtime_resume_and_get(&dev->dev);
+	if (ret < 0)
+		return ret;
+
+	partner =3D (dev =3D=3D downstream_port) ? upstream_port : downstream_por=
t;
+
+	/* Prevent concurrent LMR on both ends of the same link */
+	if (partner && partner->lmr && partner->lmr->enabled) {
+		ret =3D -EBUSY;
+		goto err_rpm;
+	}
+
+	if (partner) {
+		ret =3D pm_runtime_resume_and_get(&partner->dev);
+		if (ret < 0)
+			goto err_rpm;
+		mdev->partner =3D pci_dev_get(partner);
+	}
+
+	/*
+	 * PCIe Base Specification Revision 7.0 sec 8.4.4: LMR is physically
+	 * undefined below 16.0 GT/s. Even if a device supports Gen4+, if the
+	 * link is currently trained and operating at Gen1..Gen3 speeds
+	 * (< 16.0 GT/s) in Link Status Register (sec 7.5.3.8, Current Link
+	 * Speed), reject margining.
+	 */
+	pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
+	if ((lnksta & PCI_EXP_LNKSTA_CLS) < PCI_EXP_LNKSTA_CLS_16_0GB) {
+		ret =3D -EOPNOTSUPP;
+		goto err_partner_rpm;
+	}
+
+	ret =3D pci_read_config_word(dev, mdev->cap + PCI_LMR_PORT_CAP, &cap);
+	if (ret !=3D PCIBIOS_SUCCESSFUL) {
+		ret =3D pcibios_err_to_errno(ret);
+		goto err_partner_rpm;
+	}
+
+	/* Disable Autonomous Width and Speed transitions */
+	pci_lmr_disable_autonomous(mdev);
+
+	/* Inhibit ASPM L0s/L1 during margining with restoration path */
+	pci_lmr_aspm_inhibit(mdev, true);
+
+	if (cap & PCI_LMR_PORT_CAP_USES_SW_READY) {
+		ret =3D pci_read_config_word(dev, mdev->cap + PCI_LMR_PORT_STS, &sts);
+		if (ret !=3D PCIBIOS_SUCCESSFUL) {
+			ret =3D pcibios_err_to_errno(ret);
+			goto err_aspm;
+		}
+		sts |=3D PCI_LMR_PORT_STS_SW_READY;
+		pci_write_config_word(dev, mdev->cap + PCI_LMR_PORT_STS, sts);
+	}
+
+	timeout =3D jiffies + msecs_to_jiffies(LMR_ENABLE_TIMEOUT_MS);
+	while (1) {
+		ret =3D pci_read_config_word(dev, mdev->cap + PCI_LMR_PORT_STS, &sts);
+		if (ret !=3D PCIBIOS_SUCCESSFUL) {
+			ret =3D pcibios_err_to_errno(ret);
+			goto err_sw_ready;
+		}
+		if (PCI_POSSIBLE_ERROR(sts)) {
+			ret =3D -ENODEV;
+			goto err_sw_ready;
+		}
+		if (sts & PCI_LMR_PORT_STS_MARGIN_READY)
+			break;
+		if (time_after(jiffies, timeout)) {
+			ret =3D -ETIMEDOUT;
+			goto err_sw_ready;
+		}
+		usleep_range(LMR_ENABLE_SLEEP_MIN_US, LMR_ENABLE_SLEEP_MAX_US);
+	}
+
+	/* Cache capabilities for configured receiver on all lanes */
+	for (i =3D 0; i < mdev->num_lanes; i++) {
+		ret =3D pci_lmr_cache_rx_info(&mdev->lanes[i], mdev->lanes[i].rx);
+		if (ret)
+			goto err_sw_ready;
+	}
+	mdev->enabled =3D true;
+	return 0;
+
+err_sw_ready:
+	if (cap & PCI_LMR_PORT_CAP_USES_SW_READY) {
+		u16 clean_sts;
+		int clean_ret;
+
+		clean_ret =3D pci_read_config_word(
+			dev, mdev->cap + PCI_LMR_PORT_STS, &clean_sts);
+		if (clean_ret =3D=3D PCIBIOS_SUCCESSFUL) {
+			clean_sts &=3D ~PCI_LMR_PORT_STS_SW_READY;
+			pci_write_config_word(dev, mdev->cap + PCI_LMR_PORT_STS,
+					      clean_sts);
+		}
+	}
+err_aspm:
+	pci_lmr_aspm_inhibit(mdev, false);
+	pci_lmr_restore_autonomous(mdev);
+err_partner_rpm:
+	if (mdev->partner) {
+		pm_runtime_put_sync(&mdev->partner->dev);
+		pci_dev_put(mdev->partner);
+		mdev->partner =3D NULL;
+	}
+err_rpm:
+	pm_runtime_put_sync(&dev->dev);
+	return ret;
+}
+
+static ssize_t margin_enable_write(struct file *file,
+				   const char __user *user_buf, size_t count,
+				   loff_t *ppos)
+{
+	struct seq_file *s =3D file->private_data;
+	struct pci_margin_dev *mdev =3D s->private;
+	struct pci_dev *dev =3D mdev->dev;
+	struct pci_dev *downstream_port, *upstream_port;
+	bool enable;
+	int ret;
+
+	ret =3D kstrtobool_from_user(user_buf, count, &enable);
+	if (ret)
+		return ret;
+
+	pci_lmr_get_link_partners(dev, &downstream_port, &upstream_port);
+
+	/* Strict hierarchical lock order: Downstream Port (parent) before Upstre=
am Port (child) */
+	if (downstream_port)
+		pci_dev_lock(downstream_port);
+	if (upstream_port && upstream_port !=3D downstream_port)
+		pci_dev_lock(upstream_port);
+
+	mutex_lock(&mdev->lock);
+
+	if (mdev->enabled =3D=3D enable) {
+		ret =3D count;
+	} else if (!enable) {
+		pci_lmr_disable_locked(mdev);
+		ret =3D count;
+	} else {
+		ret =3D pci_lmr_enable_locked(mdev, downstream_port, upstream_port);
+		if (!ret)
+			ret =3D count;
+	}
+
+	mutex_unlock(&mdev->lock);
+
+	if (upstream_port && upstream_port !=3D downstream_port)
+		pci_dev_unlock(upstream_port);
+	if (downstream_port)
+		pci_dev_unlock(downstream_port);
+
+	pci_lmr_put_link_partners(dev, downstream_port, upstream_port);
+
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
+					  size_t count, loff_t *ppos)
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
+	/*
+	 * Valid receiver numbers are 0..6 per PCIe Base Specification
+	 * Revision 7.0 sec 4.2.18.1 & Table 4-76 (r6.0 Table 4-72);
+	 * 7 is reserved.
+	 */
+	if (rx > LMR_MAX_RX_NUM)
+		return -EINVAL;
+
+	guard(mutex)(&mdev->lock);
+	if (plane->rx =3D=3D rx)
+		return count;
+
+	if (mdev->enabled) {
+		/* Clear previous receiver to normal settings per single-receiver rule *=
/
+		ret =3D pci_lmr_clear_to_normal_lane(plane);
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
+		return -EBUSY;
+
+	ret =3D pci_lmr_cache_rx_info(plane, plane->rx);
+	if (ret)
+		return ret;
+
+	info =3D &plane->rx_info[plane->rx];
+	val =3D info->caps;
+	seq_printf(s, "Lane %d Rx %d Capabilities: %#02x\n", plane->lane, plane->=
rx, val);
+	seq_printf(s, "  Voltage Supported: %s\n",
+		   str_yes_no(val & LMR_CAP_VOLTAGE_SUPPORTED));
+	seq_printf(s, "  Left/Right: %s\n",
+		   (val & LMR_CAP_IND_LEFT_RIGHT_TIMING) ? "independent" : "symmetric");
+	seq_printf(s, "  Up/Down: %s\n",
+		   (val & LMR_CAP_IND_UP_DOWN_VOLTAGE) ? "independent" : "symmetric");
+	seq_printf(s, "  Error Sampler: %s\n",
+		   (val & LMR_CAP_IND_ERROR_SAMPLER) ? "independent" :
+						       "main sampler");
+	seq_printf(s, "  Sample Reporting: %s\n",
+		   (val & LMR_CAP_SAMPLE_REPORT_METHOD) ? "rate" : "count");
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(margin_lane_caps);
+
+static int margin_lane_steps_show(struct seq_file *s, u8 type)
+{
+	struct pci_margin_lane *plane =3D s->private;
+	struct pci_margin_dev *mdev =3D plane->mdev;
+	struct pci_margin_rx_info *info;
+	int ret;
+
+	guard(mutex)(&mdev->lock);
+	if (!mdev->enabled)
+		return -EBUSY;
+
+	ret =3D pci_lmr_cache_rx_info(plane, plane->rx);
+	if (ret)
+		return ret;
+
+	info =3D &plane->rx_info[plane->rx];
+	seq_printf(s, "%d\n", (type =3D=3D LMR_TYPE_VOLTAGE) ?
+		   info->num_voltage_steps : info->num_timing_steps);
+	return 0;
+}
+
+static int margin_lane_timing_steps_show(struct seq_file *s, void *v)
+{
+	return margin_lane_steps_show(s, LMR_TYPE_TIMING);
+}
+DEFINE_SHOW_ATTRIBUTE(margin_lane_timing_steps);
+
+static int margin_lane_voltage_steps_show(struct seq_file *s, void *v)
+{
+	return margin_lane_steps_show(s, LMR_TYPE_VOLTAGE);
+}
+DEFINE_SHOW_ATTRIBUTE(margin_lane_voltage_steps);
+
+/*
+ * pci_lmr_check_sample_multiple_rx() - Check multi-receiver concurrency.
+ * Per PCIe Base Specification Revision 7.0 sec 4.2.18.2 & sec 8.4.4:
+ * "For Receivers where MIndErrorSampler is 0b, at most one such Receiver =
is
+ * permitted to be margined at a time. However, margining may be performed=
 on
+ * multiple Lanes simultaneously, as long as it is within the maximum numb=
er of
+ * Lanes the device supports."
+ *
+ * If the target receiver uses an independent error sampler (MIndErrorSamp=
ler =3D=3D 1b),
+ * margining will not produce errors in the live data stream, and multiple=
 receivers
+ * may be margined concurrently. If MIndErrorSampler is 0b (main data samp=
ler),
+ * software must ensure that no other receiver on any lane is currently ma=
rgined.
+ */
+static bool pci_lmr_check_sample_multiple_rx(struct pci_margin_dev *mdev,
+					     struct pci_margin_lane *plane)
+{
+	struct pci_margin_rx_info *info =3D &plane->rx_info[plane->rx];
+	int i;
+
+	/* If receiver has an independent error sampler, concurrent margining is =
permitted */
+	if (info->caps & LMR_CAP_IND_ERROR_SAMPLER)
+		return true;
+
+	for (i =3D 0; i < mdev->num_lanes; i++) {
+		struct pci_margin_lane *other =3D &mdev->lanes[i];
+		struct pci_margin_rx_info *other_info;
+
+		if (i =3D=3D plane->lane)
+			continue;
+
+		other_info =3D &other->rx_info[other->rx];
+		/*
+		 * For receivers using the main data sampler, reject only if another lan=
e
+		 * is actively margining a DIFFERENT receiver that ALSO uses the main da=
ta sampler.
+		 */
+		if (other->rx !=3D plane->rx &&
+		    !(other_info->caps & LMR_CAP_IND_ERROR_SAMPLER) &&
+		    (other->timing_val !=3D 0 || other->voltage_val !=3D 0))
+			return false;
+	}
+	return true;
+}
+
+static ssize_t margin_lane_step_write(struct file *file, const char __user=
 *user_buf,
+				      size_t count, u8 type)
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
+	guard(mutex)(&mdev->lock);
+	if (!mdev->enabled)
+		return -EBUSY;
+
+	/*
+	 * Ensure ASPM remains inhibited on both link partners before issuing
+	 * margin steps. PCIe Base Specification Revision 7.0 sec 8.4.4 requires
+	 * the link to stay in L0.
+	 */
+	pci_lmr_ensure_aspm_inhibited(mdev);
+
+	if (val =3D=3D 0) {
+		/* Step this specific axis to 0 without resetting the orthogonal axis */
+		if (type =3D=3D LMR_TYPE_TIMING) {
+			if (plane->voltage_val =3D=3D 0) {
+				ret =3D pci_lmr_clear_to_normal_lane(plane);
+			} else {
+				ret =3D pci_lmr_run_cmd(mdev, plane->lane, plane->rx,
+						      LMR_TYPE_TIMING, 0, 0, &sts);
+				if (!ret)
+					plane->timing_val =3D 0;
+			}
+		} else {
+			if (plane->timing_val =3D=3D 0) {
+				ret =3D pci_lmr_clear_to_normal_lane(plane);
+			} else {
+				ret =3D pci_lmr_run_cmd(mdev, plane->lane, plane->rx,
+						      LMR_TYPE_VOLTAGE, 0, 0, &sts);
+				if (!ret)
+					plane->voltage_val =3D 0;
+			}
+		}
+		return ret ? ret : count;
+	}
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
+	switch (type) {
+	case LMR_TYPE_TIMING:
+		if (val < -LMR_MAX_TIMING_STEP || val > LMR_MAX_TIMING_STEP)
+			return -EINVAL;
+		if (val < 0) {
+			if (!(caps & LMR_CAP_IND_LEFT_RIGHT_TIMING))
+				return -EINVAL;
+			step =3D -val;
+			dir =3D LMR_STEP_DIR_LEFT_OR_DOWN; /* 1b: Left */
+		} else {
+			step =3D val;
+			dir =3D LMR_STEP_DIR_RIGHT_OR_UP; /* 0b: Right or Symmetric (Reserved 0=
b) */
+		}
+		max_step =3D info->num_timing_steps;
+		if (step > max_step)
+			return -EINVAL;
+
+		payload =3D FIELD_PREP(LMR_TIMING_DIR_MASK, dir) |
+			  FIELD_PREP(LMR_TIMING_STEP_MASK, step);
+		ret =3D pci_lmr_run_cmd(mdev, plane->lane, plane->rx,
+				      LMR_TYPE_TIMING, 0, payload, &sts);
+		if (ret)
+			return ret;
+		if (FIELD_GET(LMR_STS_EXEC_MASK, pci_lmr_sts_payload(sts)) =3D=3D
+		    LMR_STS_EXEC_NAK)
+			return -EOPNOTSUPP;
+		if (FIELD_GET(LMR_STS_EXEC_MASK, pci_lmr_sts_payload(sts)) =3D=3D
+		    LMR_STS_EXEC_TOO_MANY_ERR) {
+			plane->timing_val =3D 0;
+			plane->voltage_val =3D 0;
+			return -EIO;
+		}
+		plane->timing_val =3D val;
+		break;
+
+	case LMR_TYPE_VOLTAGE:
+		if (!(caps & LMR_CAP_VOLTAGE_SUPPORTED))
+			return -EOPNOTSUPP;
+		if (val < -LMR_MAX_VOLTAGE_STEP || val > LMR_MAX_VOLTAGE_STEP)
+			return -EINVAL;
+		if (val < 0) {
+			if (!(caps & LMR_CAP_IND_UP_DOWN_VOLTAGE))
+				return -EINVAL;
+			step =3D -val;
+			dir =3D LMR_STEP_DIR_LEFT_OR_DOWN; /* 1b: Down */
+		} else {
+			step =3D val;
+			dir =3D LMR_STEP_DIR_RIGHT_OR_UP; /* 0b: Up or Symmetric (Reserved 0b) =
*/
+		}
+		max_step =3D info->num_voltage_steps;
+		if (step > max_step)
+			return -EINVAL;
+
+		payload =3D FIELD_PREP(LMR_VOLTAGE_DIR_MASK, dir) |
+			  FIELD_PREP(LMR_VOLTAGE_STEP_MASK, step);
+		ret =3D pci_lmr_run_cmd(mdev, plane->lane, plane->rx,
+				      LMR_TYPE_VOLTAGE, 0, payload, &sts);
+		if (ret)
+			return ret;
+		if (FIELD_GET(LMR_STS_EXEC_MASK, pci_lmr_sts_payload(sts)) =3D=3D
+		    LMR_STS_EXEC_NAK)
+			return -EOPNOTSUPP;
+		if (FIELD_GET(LMR_STS_EXEC_MASK, pci_lmr_sts_payload(sts)) =3D=3D
+		    LMR_STS_EXEC_TOO_MANY_ERR) {
+			plane->timing_val =3D 0;
+			plane->voltage_val =3D 0;
+			return -EIO;
+		}
+		plane->voltage_val =3D val;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	return count;
+}
+
+static ssize_t margin_lane_timing_write(struct file *file, const char __us=
er *user_buf,
+					size_t count, loff_t *ppos)
+{
+	return margin_lane_step_write(file, user_buf, count, LMR_TYPE_TIMING);
+}
+
+static int margin_lane_step_show(struct seq_file *s, u8 type)
+{
+	struct pci_margin_lane *plane =3D s->private;
+
+	guard(mutex)(&plane->mdev->lock);
+	seq_printf(s, "%d\n", (type =3D=3D LMR_TYPE_VOLTAGE) ?
+		   plane->voltage_val : plane->timing_val);
+	return 0;
+}
+
+static int margin_lane_timing_show(struct seq_file *s, void *v)
+{
+	return margin_lane_step_show(s, LMR_TYPE_TIMING);
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
+	return margin_lane_step_write(file, user_buf, count, LMR_TYPE_VOLTAGE);
+}
+
+static int margin_lane_voltage_show(struct seq_file *s, void *v)
+{
+	return margin_lane_step_show(s, LMR_TYPE_VOLTAGE);
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
+	u32 lnkcap;
+	u16 lmr;
+	int num_lanes, ret, i;
+
+	if (WARN_ON_ONCE(!dev) || !pci_is_pcie(dev))
+		return;
+
+	/*
+	 * Per PCIe Base Specification Revision 7.0 sec 7.7.11:
+	 * For devices associated with an Upstream Port (Endpoints),
+	 * the Lane Margining Extended Capability must be implemented in
+	 * Function 0 (and only Function 0).
+	 */
+	if (pci_is_pcie(dev) && pci_pcie_type(dev) =3D=3D PCI_EXP_TYPE_ENDPOINT &=
&
+	    PCI_FUNC(dev->devfn) !=3D 0)
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
+	/*
+	 * Maximum Link Width (MLW) per PCIe Base Specification Revision 7.0 sec =
7.5.3.6
+	 * ("Link Capabilities Register", bits 9:4).
+	 */
+	ret =3D pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &lnkcap);
+	if (ret !=3D PCIBIOS_SUCCESSFUL)
+		return;
+	num_lanes =3D FIELD_GET(PCI_EXP_LNKCAP_MLW, lnkcap);
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
+	pci_dbg(dev, "Lane Margining at Receiver (Gen%u) Capability detected\n",
+		LMR_SPEED_TO_GEN(speed));
+}
+
+void pci_lmr_exit(struct pci_dev *dev)
+{
+	struct pci_margin_dev *mdev;
+
+	if (!dev || !dev->lmr)
+		return;
+
+	mdev =3D dev->lmr;
+
+	/* 1. Tear down user-facing debugfs files FIRST to prevent concurrent acc=
ess */
+	pci_margin_debugfs_remove(mdev);
+
+	/* 2. Disarm dev->lmr under device_lock to serialize with pci_reset_lmr *=
/
+	pci_dev_lock(dev);
+	mdev =3D dev->lmr;
+	if (!mdev) {
+		pci_dev_unlock(dev);
+		return;
+	}
+	scoped_guard(mutex, &mdev->lock) {
+		dev->lmr =3D NULL;
+		pci_lmr_disable_locked(mdev);
+	}
+	pci_dev_unlock(dev);
+
+	/* 3. Safe to destroy structures */
+	mutex_destroy(&mdev->lock);
+	kfree(mdev);
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
+	pci_lmr_disable_locked(mdev);
+}
+
+void pci_reset_lmr(struct pci_dev *dev)
+{
+	struct pci_margin_dev *mdev;
+	u16 sts;
+	int ret, i;
+
+	if (!dev || pci_dev_is_removed(dev))
+		return;
+
+	device_lock_assert(&dev->dev);
+
+	mdev =3D dev->lmr;
+	if (!mdev)
+		return;
+
+	guard(mutex)
+		(&mdev->lock);
+	if (mdev->enabled) {
+		for (i =3D 0; i < mdev->num_lanes; i++) {
+			/*
+			 * FLR does not reset Physical Layer registers like LMR.
+			 * Return physical samplers to nominal in hardware to prevent
+			 * persistent receiver eye skew.
+			 */
+			pci_lmr_clear_to_normal_lane(&mdev->lanes[i]);
+			mdev->lanes[i].timing_val =3D 0;
+			mdev->lanes[i].voltage_val =3D 0;
+		}
+
+		/* Clear SW_READY in hardware to reset margining state machine */
+		ret =3D pci_read_config_word(dev, mdev->cap + PCI_LMR_PORT_STS, &sts);
+		if (ret =3D=3D PCIBIOS_SUCCESSFUL) {
+			sts &=3D ~PCI_LMR_PORT_STS_SW_READY;
+			pci_write_config_word(dev, mdev->cap + PCI_LMR_PORT_STS, sts);
+		}
+
+		/* Restore original hardware ASPM before saved states can seal the leak =
*/
+		pci_lmr_aspm_inhibit(mdev, false);
+		pci_lmr_restore_autonomous(mdev);
+
+		if (mdev->partner) {
+			/*
+			 * Drop remote partner's PM reference and schedule idle check
+			 * asynchronously so the partner does not remain stranded in
+			 * RPM_ACTIVE (D0) indefinitely.
+			 */
+			pm_runtime_put(&mdev->partner->dev);
+			pci_dev_put(mdev->partner);
+			mdev->partner =3D NULL;
+		}
+
+		/*
+		 * Decrement runtime PM usage counter without triggering synchronous
+		 * suspend, ensuring the device remains in D0 during pci_save_state()
+		 * and the subsequent reset sequence.
+		 */
+		pm_runtime_put_noidle(&dev->dev);
+		mdev->enabled =3D false;
+	}
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
index d8bffa21498a..11f8d129d8ea 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -36,7 +36,7 @@ static void pci_destroy_dev(struct pci_dev *dev)
=20
 	pci_doe_sysfs_teardown(dev);
 	pci_npem_remove(dev);
-
+	pci_lmr_exit(dev);
 	/*
 	 * While device is in D0 drop the device from TSM link operations
 	 * including unbind and disconnect (IDE + SPDM teardown).
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


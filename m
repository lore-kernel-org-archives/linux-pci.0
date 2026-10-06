Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B450D4A2631
	for <linux-pci@vger.kernel.org>; Tue,  6 Oct 2026 17:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791308065; cv=none; b=e3TTECMCc5EvhckXjPjGkTuKGHpziiv7WSL8FcMYSZxh5VG326id17ZeQ7v2cXV+C+4sbcqSD5UXSc4tHsr1DShM/C4XhYZQBUWRPYitA28JmuuYYWlPyz5q+QtEDLZekMd2p+0nyKX8l/zpDgdsy3QjQpK473oMHEdrXo2a4nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791308065; c=relaxed/simple;
	bh=E6p5hDyEcb/evbuCuTEvlW3QsWVwyKCNi8xTI4lnTSU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mYS1pg+IZufG636hQfXK76EwMvGnNUoLmAJg80O5pnEXqfiQJZBc5mSigRARTXzpNLr5a4PT/mgZBzcbqD7JUHtuahT9hI0DQ7g0Liq4EEkq0ESBub1zmeJZPJLznpiu/dGzxGrxHWVYpWgrRdkizNhhbdD5gqXzSNGOZkx73cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rathodpriyank.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pFr798go; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rathodpriyank.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pFr798go"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-887c99013edso2315597b3a.3
        for <linux-pci@vger.kernel.org>; Tue, 06 Oct 2026 10:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791308060; x=1791912860; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HG62I2p2CxfGwfX3N9jmMwCvcJysG4daa43AA6XWvac=;
        b=pFr798goYvYLHfsCLDQlXOAWfljULCtnZxQFLr7bpoUflPgU1Qn/Uoc997JS3JEw5v
         oPsl3lx0ogykchxLHMEh2ECkdE1AB8mBWr1rVcxl6UFn+1RkaR/meFJZAalYlT3ttJLG
         yzCVsvBqW1DoMyx/cgrgzToqTVzjPvB/A5phpBfVcKa0aGDlNL0gVYxa+jLtQ0ulRsZr
         /3O90ctUWOBdqxAEYRfKr3hDTn1pTNP2BKMOH29cN8qHr02cQxJ+f6xWfxPPgAz0IyAU
         O7GIvB5w/E3DDbJJITC3SSa5o2EoPLgTT2JhNM5+iEKhPvfGfhFMZxM7ANLGdpYQv+RY
         Y2mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791308060; x=1791912860;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HG62I2p2CxfGwfX3N9jmMwCvcJysG4daa43AA6XWvac=;
        b=rIPKbHKRT5VzGwP5yTn1sIFSBxyeRwcmU+qxU5+UKfD49FKTITkzt0wfZIMWZVQJxV
         TMFQfLum4mfsUuDozzu7KqXSKeJkRSXL0XvOEHOtaXWEQtM7q5eP11KTOhLM66uCdXU7
         NMP0yGS+b6ThNVyQfHyQDUXPfA2jagBKHqfbWpeslOqu++lCzBgpTlNSmFmkHCxhiLfb
         FPBIyf2dvXeaIvFAi0OZsqSxMsyZQuAdBBibUH5vtaDad+2fXACdzTo4fPFYaooWYQxj
         sR3hucZtzNKhJWfuo6dEHB/HV60if3rQ5zRZhfvxbbPQg5A+TqwlBERlBBUEwbPcMoCf
         CTTQ==
X-Forwarded-Encrypted: i=1; AKwUvBzWEMmKJU0BGrZ2HG4SI3EZui20MaPoMRibedpeZswBOdoo+hjqKaaCbpj+RBPdnh/pEFJnYOD8MFI=@vger.kernel.org
X-Gm-Message-State: AFq9FYLwFyVAbcSKcvVGcq37xw12ROAHdomUU/ABE0KzJbJeAxFO6VPM
	eLuNy9BRsfF9x2ALFhHlM6n7ZvHg1AmXTbwETyqIgmZifGo9k57CQ7znztzJsuWBfIHq4z4pCjm
	ie9Kq2860KO8Hd8t57yPq/g5/ZQta13BIZw==
X-Received: from plq5.prod.google.com ([2002:a17:903:2f85:b0:2e4:8c0e:97db])
 (user=rathodpriyank job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:3c45:b0:2df:a64a:756d with SMTP id d9443c01a7336-2e6004bdc37mr1260285ad.33.1791308059766;
 Tue, 06 Oct 2026 10:34:19 -0700 (PDT)
Date: Tue, 06 Oct 2026 17:34:18 +0000
In-Reply-To: <20261006-pcie-link-endpoints-v5-0-c1e73235746b@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261006-pcie-link-endpoints-v5-0-c1e73235746b@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20261006-pcie-link-endpoints-v5-2-c1e73235746b@google.com>
Subject: [PATCH v5 2/2] selftests/pcie_lmr: Add tests for the Lane Margining
 debugfs interface
From: Priyank Rathod <rathodpriyank@google.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "=?utf-8?q?Ilpo_J=C3=A4rvinen?=" <ilpo.jarvinen@linux.intel.com>, Lukas Wunner <lukas@wunner.de>, 
	Manivannan Sadhasivam <mani@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Shuah Khan <shuah@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, linux-pci@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Priyank Rathod <rathodpriyank@google.com>
Content-Type: text/plain; charset="utf-8"

Add a KTAP test for the Lane Margining at the Receiver debugfs
interface.

By default it only runs checks that do not start a margining session,
on every pcie_lmr_* directory: the files exist, malformed input is
rejected, and commands fail with ENOTCONN without a session.

If PCIE_LMR_DEV names a port, it also starts a session on that link,
checks the receiver and step bounds the receiver reports, and checks
that Link Control and Link Control 2 of both ends are the same after
the session as before it.

Signed-off-by: Priyank Rathod <rathodpriyank@google.com>
---
 MAINTAINERS                                  |   1 +
 tools/testing/selftests/Makefile             |   1 +
 tools/testing/selftests/pcie_lmr/Makefile    |   3 +
 tools/testing/selftests/pcie_lmr/pcie_lmr.sh | 311 +++++++++++++++++++++++++++
 4 files changed, 316 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index cc0fdf2ff7e9..fc8c362c5d22 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21298,6 +21298,7 @@ L:	linux-pci@vger.kernel.org
 S:	Maintained
 F:	Documentation/PCI/pcie-lmr.rst
 F:	drivers/pci/pcie/margin.c
+F:	tools/testing/selftests/pcie_lmr/
 
 PCMCIA SUBSYSTEM
 M:	Dominik Brodowski <linux@dominikbrodowski.net>
diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 2d960626750e..c92465d3d0b5 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -93,6 +93,7 @@ TARGETS += net/tcp_ao
 TARGETS += nolibc
 TARGETS += pci_endpoint
 TARGETS += pcie_bwctrl
+TARGETS += pcie_lmr
 TARGETS += perf_events
 TARGETS += pidfd
 TARGETS += pid_namespace
diff --git a/tools/testing/selftests/pcie_lmr/Makefile b/tools/testing/selftests/pcie_lmr/Makefile
new file mode 100644
index 000000000000..101c90e7ee9e
--- /dev/null
+++ b/tools/testing/selftests/pcie_lmr/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+TEST_PROGS = pcie_lmr.sh
+include ../lib.mk
diff --git a/tools/testing/selftests/pcie_lmr/pcie_lmr.sh b/tools/testing/selftests/pcie_lmr/pcie_lmr.sh
new file mode 100755
index 000000000000..9e5d16d098fd
--- /dev/null
+++ b/tools/testing/selftests/pcie_lmr/pcie_lmr.sh
@@ -0,0 +1,311 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Tests for the PCIe Lane Margining at the Receiver debugfs interface
+# (Documentation/PCI/pcie-lmr.rst).
+#
+# By default only checks that do not start a margining session are run,
+# on every port that has a pcie_lmr_* directory.  To also run a session
+# on one link, name a port with the capability:
+#
+#   PCIE_LMR_DEV=0000:00:01.1 ./pcie_lmr.sh
+#
+# The link runs with ASPM off for the duration of that test; do not
+# point it at a link that is in use for something important.
+
+DIR="$(dirname "$(readlink -f "$0")")"
+source "$DIR"/../kselftest/ktap_helpers.sh
+
+DEBUGFS=/sys/kernel/debug
+export LC_ALL=C
+
+# Like ktap_test_result, but passes arguments that contain spaces intact
+check()
+{
+	local desc="$1"
+
+	shift
+	if "$@"; then
+		ktap_test_pass "$desc"
+	else
+		ktap_test_fail "$desc"
+	fi
+}
+
+# write_expect <file> <value> <expected>
+# <expected> is "ok" or the strerror() text of the expected error.
+write_expect()
+{
+	local file="$1" val="$2" want="$3" err
+
+	err=$( { printf '%s' "$val" > "$file"; } 2>&1 )
+	if [ $? -eq 0 ]; then
+		[ "$want" = "ok" ]
+		return
+	fi
+	[ "$want" != "ok" ] && [[ "$err" == *"$want"* ]]
+}
+
+# read_expect <file> <expected>, like write_expect
+read_expect()
+{
+	local file="$1" want="$2" err
+
+	err=$( { cat "$file" > /dev/null; } 2>&1 )
+	if [ $? -eq 0 ]; then
+		[ "$want" = "ok" ]
+		return
+	fi
+	[ "$want" != "ok" ] && [[ "$err" == *"$want"* ]]
+}
+
+# caps_get <port dir> <key>
+caps_get()
+{
+	sed -n "s/^$2: //p" "$1/lane0/caps"
+}
+
+check_layout()
+{
+	local d="$1" f
+
+	for f in enable receiver port lane0/caps lane0/margin_timing \
+		 lane0/margin_voltage lane0/status; do
+		[ -e "$d/$f" ] || return 1
+	done
+}
+
+check_port_file()
+{
+	local out
+
+	out=$(cat "$1/port") || return 1
+	[[ "$out" == *"uses_driver_software: "[01]* ]] &&
+	[[ "$out" == *"margining_ready: "[01]* ]] &&
+	[[ "$out" == *"software_ready: "[01]* ]]
+}
+
+PASSIVE_TESTS=9
+
+# Checks that never start a session
+passive_tests()
+{
+	local d="$1" n i
+
+	n=$(basename "$d")
+
+	check "$n: files present" check_layout "$d"
+	check "$n: port file readable" check_port_file "$d"
+
+	if [ "$(cat "$d/enable" 2>/dev/null)" != "0" ]; then
+		for i in $(seq 3 $PASSIVE_TESTS); do
+			ktap_test_skip "$n: session active, test $i skipped"
+		done
+		return
+	fi
+
+	check "$n: enable rejects '2'" \
+		write_expect "$d/enable" 2 "Invalid argument"
+	check "$n: enable rejects 'x'" \
+		write_expect "$d/enable" x "Invalid argument"
+	check "$n: enable=0 without a session is accepted" \
+		write_expect "$d/enable" 0 ok
+	check "$n: margin_timing rejects 'abc'" \
+		write_expect "$d/lane0/margin_timing" abc "Invalid argument"
+	check "$n: margin_timing needs a session" \
+		write_expect "$d/lane0/margin_timing" 1 \
+		"Transport endpoint is not connected"
+	check "$n: caps needs a session" \
+		read_expect "$d/lane0/caps" "Transport endpoint is not connected"
+	check "$n: receiver needs a session" \
+		write_expect "$d/receiver" 1 "Transport endpoint is not connected"
+}
+
+ACTIVE_TESTS=14
+
+# Print the device at the other end of the link of PCI device $1.
+# Receiver 6 is the child device (PCIe Upstream Port) below the Downstream
+# Port; receiver 1 is the Downstream Port (parent bridge).
+partner_of()
+{
+	local sys=/sys/bus/pci/devices/$1 rx c
+
+	rx=$(cat "$DEBUGFS/pcie_lmr_$1/receiver" 2> /dev/null)
+	if [ "$rx" = 6 ]; then
+		basename "$(dirname "$(readlink -f "$sys")")"
+		return
+	fi
+	for c in "$sys"/[0-9a-fA-F]*:??:??.0; do
+		[ -e "$c/config" ] && { basename "$c"; return; }
+	done
+}
+
+# Link Control and Link Control 2 of PCI device $1, or nothing
+link_regs()
+{
+	[ -n "$1" ] && command -v setpci > /dev/null || return
+	setpci -s "$1" CAP_EXP+10.w CAP_EXP+30.w 2> /dev/null | paste -sd ' '
+}
+
+check_bad_rx()
+{
+	write_expect "$1/receiver" 0 "Invalid argument" &&
+	write_expect "$1/receiver" 7 "Invalid argument"
+}
+
+check_step_roundtrip()
+{
+	write_expect "$1/lane0/margin_timing" 1 ok &&
+	[[ "$(cat "$1/lane0/status")" == timing* ]] &&
+	write_expect "$1/lane0/margin_timing" 0 ok &&
+	test "$(cat "$1/lane0/margin_timing")" = 0 &&
+	test "$(cat "$1/lane0/status")" = idle
+}
+
+check_end_session()
+{
+	write_expect "$1/enable" 0 ok &&
+	test "$(cat "$1/enable")" = 0
+}
+
+stop_session()
+{
+	[ -n "$ACTIVE_DIR" ] && echo 0 > "$ACTIVE_DIR/enable" 2> /dev/null
+}
+
+skip_rest()
+{
+	while [ "$KTAP_TESTNO" -le "$KSFT_NUM_TESTS" ]; do
+		ktap_test_skip "$1"
+	done
+}
+
+active_tests()
+{
+	local dev="$1" d="$DEBUGFS/pcie_lmr_$1" partner before after
+	local rx steps child
+
+	partner=$(partner_of "$dev")
+	if [ -z "$partner" ]; then
+		ktap_test_fail "$dev: start a session"
+		skip_rest "$dev: no link partner"
+		return
+	fi
+	before="$(link_regs "$dev") $(link_regs "$partner")"
+
+	ACTIVE_DIR="$d"
+	trap stop_session EXIT INT TERM
+
+	if ! write_expect "$d/enable" 1 ok; then
+		ktap_test_fail "$dev: start a session"
+		skip_rest "$dev: no session"
+		return
+	fi
+	ktap_test_pass "$dev: start a session"
+
+	check "$dev: enable=1 again is accepted" \
+		write_expect "$d/enable" 1 ok
+	check "$dev: enable reads 1" \
+		test "$(cat "$d/enable")" = 1
+
+	if [ -n "$partner" ] && [ -d "$DEBUGFS/pcie_lmr_$partner" ]; then
+		check "$dev: partner port rejects a second session" \
+			write_expect "$DEBUGFS/pcie_lmr_$partner/enable" 1 \
+			"Device or resource busy"
+	else
+		ktap_test_skip "$dev: partner has no pcie_lmr directory"
+	fi
+
+	rx=$(cat "$d/receiver")
+	check "$dev: default receiver is 1 or 6" \
+		test "$rx" = 1 -o "$rx" = 6
+	check "$dev: receiver 0 and 7 are rejected" \
+		check_bad_rx "$d"
+	check "$dev: receiver 256 is rejected" \
+		write_expect "$d/receiver" 256 "Numerical result out of range"
+
+	steps=$(caps_get "$d" timing_steps)
+	check "$dev: caps reports timing_steps" \
+		test -n "$steps"
+	check "$dev: timing step above timing_steps is rejected" \
+		write_expect "$d/lane0/margin_timing" $((steps + 1)) \
+		"Numerical result out of range"
+
+	if [ "${steps:-0}" -ge 1 ]; then
+		check "$dev: timing step 1 then 0" \
+			check_step_roundtrip "$d"
+	else
+		ktap_test_skip "$dev: receiver reports no timing steps"
+	fi
+
+	if [ "$(caps_get "$d" independent_left_right_timing)" = 0 ]; then
+		check "$dev: negative timing step is rejected" \
+			write_expect "$d/lane0/margin_timing" -1 "Invalid argument"
+	else
+		ktap_test_skip "$dev: receiver supports left/right timing"
+	fi
+
+	if [ "$(caps_get "$d" voltage_supported)" = 0 ]; then
+		check "$dev: voltage step is rejected" \
+			write_expect "$d/lane0/margin_voltage" 1 \
+			"Operation not supported"
+	else
+		ktap_test_skip "$dev: receiver supports voltage margining"
+	fi
+
+	if check_end_session "$d"; then
+		ktap_test_pass "$dev: end the session"
+		ACTIVE_DIR=
+	else
+		ktap_test_fail "$dev: end the session"
+	fi
+
+	# In drivers/pci/pcie/aspm.c, aspm_ctrl_attrs_are_visible() uses
+	# pcie_aspm_get_link(pdev) -> pci_upstream_bridge(pdev)->link_state,
+	# so the sysfs 'link/' directory is attached to the child device
+	# below the Downstream Port (the PCIe Upstream Port, receiver 6),
+	# not to the Downstream Port itself.
+	child=$([ "$rx" = 6 ] && echo "$dev" || echo "$partner")
+	after="$(link_regs "$dev") $(link_regs "$partner")"
+	if [ -z "${before// }" ]; then
+		ktap_test_skip "$dev: setpci not found"
+	elif [ -n "$child" ] && [ ! -d "/sys/bus/pci/devices/$child/link" ]; then
+		ktap_test_skip "$dev: no OS ASPM control on link"
+	else
+		check "$dev: LNKCTL and LNKCTL2 restored on both ends" \
+			test "$before" = "$after"
+	fi
+}
+
+ktap_print_header
+
+if [ "$(id -u)" -ne 0 ]; then
+	ktap_skip_all "must be run as root"
+	exit "$KSFT_SKIP"
+fi
+
+mountpoint -q "$DEBUGFS" || mount -t debugfs none "$DEBUGFS" 2> /dev/null
+
+ports=("$DEBUGFS"/pcie_lmr_*)
+if [ ! -d "${ports[0]}" ]; then
+	ktap_skip_all "no pcie_lmr_* directories in debugfs"
+	exit "$KSFT_SKIP"
+fi
+
+if [ -n "$PCIE_LMR_DEV" ] && [ ! -d "$DEBUGFS/pcie_lmr_$PCIE_LMR_DEV" ]; then
+	ktap_exit_fail_msg "no pcie_lmr directory for $PCIE_LMR_DEV"
+fi
+
+plan=$(( ${#ports[@]} * PASSIVE_TESTS ))
+[ -n "$PCIE_LMR_DEV" ] && plan=$((plan + ACTIVE_TESTS))
+ktap_set_plan "$plan"
+
+for d in "${ports[@]}"; do
+	passive_tests "$d"
+done
+
+if [ -n "$PCIE_LMR_DEV" ]; then
+	active_tests "$PCIE_LMR_DEV"
+fi
+
+ktap_finished

-- 
2.56.0.rc1.315.gc6ed9934b7-goog


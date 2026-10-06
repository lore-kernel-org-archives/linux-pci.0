Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5713469836
	for <linux-pci@vger.kernel.org>; Tue,  6 Oct 2026 20:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791320356; cv=none; b=ENqubBfKBqjHtSR9yUBHbLIgnVMF+Leur3i+qC5FwG1YByY+6kX4yen41DzbmzaJ2AM5rsZYe9XCZ8NOtQciOck/vEsW/tdbyoiq9nMhe8mezNJ797LQHpc1BYVJ1JxUNAACtZeLtQFzDggo22YkL4prKIXl0cMgVxGI/g8FW1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791320356; c=relaxed/simple;
	bh=E6p5hDyEcb/evbuCuTEvlW3QsWVwyKCNi8xTI4lnTSU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZqMPKak/a2dSa9wumE75GWLzAm+/xPrmhGWYPi0OvYCqpokpRO9INqFuC5P5XEEPUefKPM9J/TQ+KFawiKUTWundxCtHDgI27xHar2xeFtHy4YyM1h971YtzTrl78W1BmEUNgS0+ZZkDAsx9VhRkrXu4ib99alSB5ta5/OAdImc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rathodpriyank.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LPR0YrsF; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rathodpriyank.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LPR0YrsF"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2dc7337e2a7so33751385ad.0
        for <linux-pci@vger.kernel.org>; Tue, 06 Oct 2026 13:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791320353; x=1791925153; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HG62I2p2CxfGwfX3N9jmMwCvcJysG4daa43AA6XWvac=;
        b=LPR0YrsFR/nP/+7dgPH99xPv/iufbuserwwItbHBgS7i+DJ5Q4lby/7Mog8B9Hhwlo
         ZmbCQmNTxons9r/biN1gvzYSDOE/td6n2CqpCjDi+inQbVid035TD8gujvim7cU4P9JR
         i+Fh3pTTCXdZsWFSNLNtTlY1w6Ac117UcRjbrjR/WByX8Mt2v08+gJb0xAEZ+TEs1M6t
         lOI4HjkjKjAZ9LLJ9YGClE3NLHivtceYaWTBgGaqLDMxDhSZyOHReOuM3c+C/11ZqHrm
         RopCOL+9AfvEJb3aKGD33J2ehDkgWXJiH6qs4NhREpd2dMx6pHNW25AL8nTBR6/GM+6N
         qEaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791320353; x=1791925153;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HG62I2p2CxfGwfX3N9jmMwCvcJysG4daa43AA6XWvac=;
        b=P/94UZqh4FmhwOM5MqLQUv6n0JJTzh7Dl9vuQV+tSjOPDwuI05SCCcTCn1qpZKufZ9
         yZM2ybxofJM6RGdO9IQSTLX4kbmuX56mf07rdB3NM3Y9o3c+9QTPJrL20azMWlxhlT9B
         94k/+y/rQmBus7ctCBs2o0BOBtzTDrT3O26PB95VfhHJySPQXeh5HnVdo9oAyPKUG6aJ
         qoWvSxeThprOlO5HEgzKD+9vq9UJkJ/eETcxak1rKig/JcjnQ0LlboPGc1HbPubEWTu0
         dLGV/egbZWdtY0xym9CrF8J5dBo+5TT0Jm3u64O/+ED1m1xJOPo9sa/HeqAlWVb3XxIW
         A/Sw==
X-Forwarded-Encrypted: i=1; AKwUvByUaGiw7++ygbbXE6bO4SbFpHSuarvJPUfk/A5yKM1+OE4IUPptYYWMATlZaLKxhvgXio6O4jKrFHg=@vger.kernel.org
X-Gm-Message-State: AFq9FYKmOF49LcXSD4sAka0YXN+fQQG7vDb9hNVTT4Ojx1MAarbnobxc
	2HP+hl/WIyG/1h1nC0FTKBWA8vp80iZyioxMwSek+eUHyzHhLmhRKgrbN9ItUY4xfPgFEe4DwQk
	2y9t5FYSR+iXxxI5+CdY5CsUJSfVZAM0CNg==
X-Received: from plhd13.prod.google.com ([2002:a17:903:230d:b0:2df:8053:e258])
 (user=rathodpriyank job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:4b4b:b0:2df:81d0:7c40 with SMTP id d9443c01a7336-2e60059e5b2mr4788275ad.55.1791320352994;
 Tue, 06 Oct 2026 13:59:12 -0700 (PDT)
Date: Tue, 06 Oct 2026 20:59:11 +0000
In-Reply-To: <20261006-pcie-link-endpoints-v6-0-154d71657d32@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261006-pcie-link-endpoints-v6-0-154d71657d32@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20261006-pcie-link-endpoints-v6-2-154d71657d32@google.com>
Subject: [PATCH v6 2/2] selftests/pcie_lmr: Add tests for the Lane Margining
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


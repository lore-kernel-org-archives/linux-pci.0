Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FC82459C6
	for <linux-pci@vger.kernel.org>; Tue,  3 Mar 2026 00:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772496070; cv=none; b=Yfkg5aNB8fjREwdCiRxwQWfLr4cf6UpQB9S+zyM2KPN70cq7sbrwr6W9GjkJl9XTaVakyDJ/Ftev/5geXKXFBRLNm5K/bFw7qFJv44bORJUImGkQt8QkwZDRP2/o6clg+ciSLur1Wiu3TfQlmo7I9LFbr8VRyOna0BSf6FMpoGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772496070; c=relaxed/simple;
	bh=15Nqiey4EMB27HQmv8Rid8AOvuVthTHLMnQEzkNrWNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cEB4BbRey+JGU0JZgAcD+SkLYBuV6h3QtSxpfSHtWdnczmnBIFHtlq72FLLpEHD0OQ/f2jwRxA2nmNbCmjbnvz/g+gSzwSe2lMnjUNDMvQu6CmLyE/z4kp46qMqGoDiZQE8JOID3sExWTrD/v7/YMTqvNwxQ/XO1cfCPEpqgVFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gUqEXAxZ; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gUqEXAxZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772496069; x=1804032069;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=15Nqiey4EMB27HQmv8Rid8AOvuVthTHLMnQEzkNrWNU=;
  b=gUqEXAxZ3rb9oXGaFBXZhkwR5E4jEm7U+QjA2aW5ybiTb0gKjJGXNtk8
   Zt+V7qczDa0MV8cDB/aO1438b+fHSLp4YAIpbwCL2pBOZRCFV9/tOLeBi
   wGbYYsuSkf2Mm/jY0tTzldf06g9ZG4rAqoZfQuFb3TzhgQYfzM0RR+SU4
   VC5KYBfC6uDBfN9TcHIpIRqF5E0uj8X+mRTP6dWAp3ATwL9HAAuFlXGcX
   rlcD6uVV7jgSBk+TpfKeetOvIkh0HnWY0ajKjs/qe+0gaMUfy39y7hnwb
   OYF2BHCXSyYXtUuohE9mUzpuB0JdDdx4DmHuMbUj5gvL7GA3ly/w21LT0
   w==;
X-CSE-ConnectionGUID: ZWiHA63oSJyqSO2IlwhzLg==
X-CSE-MsgGUID: zfcpqZKxRzuXzA+VIbdOHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11717"; a="73483043"
X-IronPort-AV: E=Sophos;i="6.21,321,1763452800"; 
   d="scan'208";a="73483043"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 16:01:01 -0800
X-CSE-ConnectionGUID: 89pK29fAQtim8RZO75OTyw==
X-CSE-MsgGUID: LK3JYhneSL2PxRRYaAP2Aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,321,1763452800"; 
   d="scan'208";a="214967132"
Received: from dwillia2-desk.jf.intel.com ([10.88.27.145])
  by fmviesa006.fm.intel.com with ESMTP; 02 Mar 2026 16:01:00 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	aik@amd.com,
	aneesh.kumar@kernel.org,
	yilun.xu@linux.intel.com,
	bhelgaas@google.com,
	alistair23@gmail.com,
	lukas@wunner.de,
	jgg@nvidia.com
Subject: [PATCH v2 17/19] tools/testing/devsec: Add a script to exercise samples/devsec/
Date: Mon,  2 Mar 2026 16:02:05 -0800
Message-ID: <20260303000207.1836586-18-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260303000207.1836586-1-dan.j.williams@intel.com>
References: <20260303000207.1836586-1-dan.j.williams@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Run the samples/devsec/ infrastructure through the PCIe TDISP connect,
bind, lock, and accept flows. Include tests for module "autoprobe" policy.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 tools/testing/devsec/devsec.sh | 234 +++++++++++++++++++++++++++++++++
 MAINTAINERS                    |   1 +
 2 files changed, 235 insertions(+)
 create mode 100755 tools/testing/devsec/devsec.sh

diff --git a/tools/testing/devsec/devsec.sh b/tools/testing/devsec/devsec.sh
new file mode 100755
index 000000000000..ce4a986b74dd
--- /dev/null
+++ b/tools/testing/devsec/devsec.sh
@@ -0,0 +1,234 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2025-2026 Intel Corporation
+
+# Checkout PCI/TSM sysfs and driver-core mechanics with the
+# devsec_link_tsm and devsec_tsm sample modules from samples/devsec/.
+
+set -ex
+
+trap 'err $LINENO' ERR
+err() {
+        echo $(basename $0): failed at line $1
+        [ -n "$2" ] && "$2"
+        exit 1
+}
+
+ORDER=""
+
+setup_modules() {
+	if [[ $ORDER == "bus" ]]; then
+		modprobe devsec_bus
+		modprobe devsec_link_tsm
+		modprobe devsec_tsm
+	else
+		modprobe devsec_tsm
+		modprobe devsec_link_tsm
+		modprobe devsec_bus
+	fi
+}
+
+teardown_modules() {
+	if [[ $ORDER == "bus" ]]; then
+		modprobe -r devsec_tsm
+		modprobe -r devsec_link_tsm
+		modprobe -r devsec_bus
+	else
+		modprobe -r devsec_bus
+		modprobe -r devsec_link_tsm
+		modprobe -r devsec_tsm
+	fi
+}
+
+PCI_DEVS=(
+"/sys/bus/pci/devices/10000:01:00.0"
+"/sys/bus/pci/devices/10001:03:00.0"
+)
+FN_DEVS=(
+"/sys/bus/pci/devices/10000:01:00.1"
+"/sys/bus/pci/devices/10001:03:00.1"
+)
+tsm_devsec=""
+tsm_link=""
+devsec_pci="/sys/bus/pci/drivers/devsec_pci"
+
+tdisp_test() {
+	pci_dev=${PCI_DEVS[$1]}
+	fn_dev=${FN_DEVS[$1]}
+	host_bridge=$(dirname $(dirname $(readlink -f $pci_dev)))
+
+	# with the device disconnected from the devsec TSM validate that
+	# the devsec_pci driver loads and honors the autoprobe policy
+	echo "devsec_pci" > $pci_dev/driver_override
+	modprobe devsec_pci "autoprobe=0"
+
+	[[ -e $pci_dev/driver ]] && err "$LINENO"
+	echo $(basename $pci_dev) > $devsec_pci/bind
+	echo $(basename $pci_dev) > $devsec_pci/unbind
+
+	# grab the device's resource from /proc/iomem
+	resource=$(cat /proc/iomem | grep -m1 $(basename $pci_dev) | awk -F ' :' '{print $1}' | tr -d ' ')
+	[[ -n $resource ]] || err "$LINENO"
+
+	# lock and accept the device, validate that the resource is now
+	# marked encrypted
+	echo $(basename $tsm_devsec) > $pci_dev/tsm/lock
+	echo 1 > $pci_dev/tsm/accept
+
+	cat /proc/iomem | grep "$resource" | grep -q -m1 "PCI MMIO Encrypted" || err "$LINENO"
+
+	# validate that the driver now fails with -EINVAL when trying to
+	# bind
+	expect="echo: write error: Invalid argument"
+	echo $(basename $pci_dev) 2>&1 > $devsec_pci/bind | grep -q "$expect" || err "$LINENO"
+
+	# unlock and validate that the encrypted mmio is removed
+	echo $(basename $tsm_devsec) > $pci_dev/tsm/unlock
+	cat /proc/iomem | grep "$resource" | grep -q "PCI MMIO Encrypted" && err "$LINENO"
+
+	modprobe -r devsec_pci
+}
+
+validate_disconnected() {
+	pci_dev=${PCI_DEVS[$1]}
+	fn_dev=${FN_DEVS[$1]}
+	host_bridge=$(dirname $(dirname $(readlink -f $pci_dev)))
+
+	# validate that the dsm is not yet detected and that the sub-function
+	# is aware of any TSM capabilities
+	dsm=$(cat $pci_dev/tsm/dsm) || err "$LINENO from $2"
+	bound=$(cat $pci_dev/tsm/bound) || err "$LINENO from $2"
+	[[ -z $dsm ]] || err "$LINENO from $2"
+	[[ -z $bound ]] || err "$LINENO from $2"
+	[[ ! -e $fn_dev/tsm/dsm ]] || err "$LINENO from $2"
+	[[ ! -e $fn_dev/tsm/bound ]] || err "$LINENO from $2"
+	[[ ! -e $fn_dev/tsm/connect ]] || err "$LINENO from $2"
+	[[ ! -e $fn_dev/tsm/disconnect ]] || err "$LINENO from $2"
+}
+
+# check that all devices can be connected simultaneously
+ide_multi_test() {
+	for pci_dev in ${PCI_DEVS[@]}; do
+		echo $(basename $tsm_link) > $pci_dev/tsm/connect
+	done
+
+	#check stream links show up and point back to the pci_dev
+	for pci_dev in ${PCI_DEVS[@]}; do
+		host_bridge=$(dirname $(dirname $(readlink -f $pci_dev)))
+		hb=$(basename $host_bridge)
+		[[ -e $host_bridge/stream0.0.0 ]] || err "$LINENO"
+		[[ -e $tsm_link/$hb/stream0.0.0 ]] || err "$LINENO"
+		[[ $(readlink -f "$tsm_link/$hb/stream0.0.0") == $(readlink -f $pci_dev) ]] || err "$LINENO"
+	done
+
+	for pci_dev in ${PCI_DEVS[@]}; do
+		echo $(basename $tsm_link) > $pci_dev/tsm/disconnect
+	done
+}
+
+ide_test() {
+	pci_dev=${PCI_DEVS[$1]}
+	fn_dev=${FN_DEVS[$1]}
+	host_bridge=$(dirname $(dirname $(readlink -f $pci_dev)))
+
+	# validate that all of the secure streams are idle by default
+	hb=$(basename $host_bridge)
+	nr=$(cat $host_bridge/available_secure_streams)
+	[[ $nr == 4 ]] || err "$LINENO"
+
+	validate_disconnected $1 $LINENO
+
+	# connect a stream and validate that the stream link shows up at
+	# the host bridge and the TSM
+	echo $(basename $tsm_link) > $pci_dev/tsm/connect
+	nr=$(cat $host_bridge/available_secure_streams)
+	[[ $nr == 3 ]] || err "$LINENO"
+
+	[[ $(cat $pci_dev/tsm/connect) == $(basename $tsm_link) ]] || err "$LINENO"
+	[[ -e $host_bridge/stream0.0.0 ]] || err "$LINENO"
+	[[ -e $tsm_link/$hb/stream0.0.0 ]] || err "$LINENO"
+
+	# with the DSM connected (PF0), validate both it and its
+	# sub-function (PF1) populate tsm/dsm with the PF0 device.
+	dsm=$(cat $pci_dev/tsm/dsm)
+	[[ $dsm == $(basename $pci_dev) ]] || err "$LINENO"
+	dsm=$(cat $fn_dev/tsm/dsm)
+	[[ $dsm == $(basename $pci_dev) ]] || err "$LINENO"
+
+	# bind both functions and validate that they display bound to
+	# the TSM device
+	echo $(basename $pci_dev) > $tsm_link/device/tsm_bind
+	bound=$(cat $pci_dev/tsm/bound)
+	[[ $bound == $(basename $tsm_link) ]] || err "$LINENO"
+	echo $(basename $fn_dev) > $tsm_link/device/tsm_bind
+	bound=$(cat $fn_dev/tsm/bound)
+	[[ $bound == $(basename $tsm_link) ]] || err "$LINENO"
+
+	# test manual unbind
+	echo $(basename $pci_dev) > $tsm_link/device/tsm_unbind
+	bound=$(cat $pci_dev/tsm/bound)
+	[[ -z $bound ]] || err "$LINENO"
+	echo $(basename $fn_dev) > $tsm_link/device/tsm_unbind
+	bound=$(cat $fn_dev/tsm/bound)
+	[[ -z $bound ]] || err "$LINENO"
+
+	# rebind to test automatic unbind at disconnect
+	echo $(basename $pci_dev) > $tsm_link/device/tsm_bind
+	echo $(basename $fn_dev) > $tsm_link/device/tsm_bind
+
+	# check that the links disappear at disconnect and the stream
+	# pool is refilled
+	echo $(basename $tsm_link) > $pci_dev/tsm/disconnect
+	nr=$(cat $host_bridge/available_secure_streams)
+	[[ $nr == 4 ]] || err "$LINENO"
+
+	validate_disconnected $1 $LINENO
+
+	[[ $(cat $pci_dev/tsm/connect) == "" ]] || err "$LINENO"
+	[[ ! -e $host_bridge/stream0.0.0 ]] || err "$LINENO"
+	[[ ! -e $tsm_link/$hb/stream0.0.0 ]] || err "$LINENO"
+}
+
+reconnect() {
+	pci_dev=${PCI_DEVS[$1]}
+	fn_dev=${FN_DEVS[$1]}
+	host_bridge=$(dirname $(dirname $(readlink -f $pci_dev)))
+
+	# reconnect to prepare for surprise removal of the TSM or device
+	echo $(basename $tsm_link) > $pci_dev/tsm/connect
+	[[ $(cat $pci_dev/tsm/connect) == $(basename $tsm_link) ]] || err "$LINENO"
+	[[ -e $host_bridge/stream0.0.0 ]] || err "$LINENO"
+	[[ -e $tsm_link/$hb/stream0.0.0 ]] || err "$LINENO"
+}
+
+devsec_test() {
+	setup_modules
+
+	# find the tsm devices by personality
+	for tsm in /sys/class/tsm/tsm*; do
+		mode=$(cat $tsm/pci_mode)
+		[[ $mode == "devsec" ]] && tsm_devsec=$tsm
+		[[ $mode == "link" ]] && tsm_link=$tsm
+	done
+	[[ -n $tsm_devsec ]] || err "$LINENO"
+	[[ -n $tsm_link ]] || err "$LINENO"
+
+	# check that devsec bus loads correctly and the TSM is detected
+	for i in ${!PCI_DEVS[@]}; do
+		pci_dev=${PCI_DEVS[$i]}
+		[[ -e $pci_dev ]] || err "$LINENO"
+		[[ -e $pci_dev/tsm ]] || err "$LINENO"
+	done
+
+	ide_multi_test
+	ide_test 0
+	tdisp_test 0
+
+	reconnect 0
+	teardown_modules
+}
+
+ORDER="bus"
+devsec_test
+ORDER="tsm"
+devsec_test
diff --git a/MAINTAINERS b/MAINTAINERS
index 889546f66f2f..a62b32481094 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -26541,6 +26541,7 @@ F:	include/linux/*tsm*.h
 F:	include/uapi/linux/pci-tsm-netlink.h
 F:	samples/devsec/
 F:	samples/tsm-mr/
+F:	tools/testing/devsec/
 
 TRUSTED SERVICES TEE DRIVER
 M:	Balint Dobszay <balint.dobszay@arm.com>
-- 
2.52.0


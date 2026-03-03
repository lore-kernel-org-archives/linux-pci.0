Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA6635CBD6
	for <linux-pci@vger.kernel.org>; Tue,  3 Mar 2026 00:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772496071; cv=none; b=NO2WrSfETR12r62WSKmTv1jiMTZUYEt8G22cuqIo6t8vNSTZxRuXZa6qTHDTQaRs655nIN55oh0CCmFKrtlquvRv0B/ELxGkIMaXoXFEW77a0RAUw7UBfIlaL+w/+TJD0DO4v3a+rkoQUHiYDJ+0tttrcxw99wjmda5nBYTeUcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772496071; c=relaxed/simple;
	bh=/xbSz0XB0SFhE9gB5JbwJ7oy06YwjFLtdehMTj/80AY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pZmqKHK23QRZ7nPo4cBCa49FeArWnm2hIACKnR5Fdpy7F8qXOXvx1/KiFgbV/2DdbhCxO3M4umwDdReR3f0d/9hKVdNq0M8ro2XJwMf4zWRpJ0R7BeQv4MnRo58XvoOnKAK76drE3QVsyVD8Zfqfk1m5GCMOfL+7vWT8jX/4cbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fom8gh1W; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fom8gh1W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772496071; x=1804032071;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/xbSz0XB0SFhE9gB5JbwJ7oy06YwjFLtdehMTj/80AY=;
  b=Fom8gh1WZcYPG1xiS40OO4u9LLsRfs4M3U9/A9dcCaU3VszUCorGSUou
   UQv0AFftZN/b6889Yzjf4VZXWvwaOjpdfQzJVeKjixQ9noaMkwE43/8yo
   OPYdfi4QsIMD4WHO7U1u+i1EVK5+e51ZAIp038taZG0b7tOGV8nTPLtX+
   CtlV9gibaHW9rCBOTm4F4TdyejagsNpzi646QInwh26ST2RF6OXtGj5tb
   u7iPSmoO4A9jAZh47z0fRAsaJluXt5T7MI64bJuolXTKKwSNnWIfwrPHl
   EwSFzSB8yBcfwzCr71B/56spRboLtU1HW8DyAHRy4enVPVK9IkkhenwQN
   w==;
X-CSE-ConnectionGUID: B77INb3XThSk08axCOsmEw==
X-CSE-MsgGUID: umqmSVUdQmmKXv6qgkEweQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11717"; a="73483067"
X-IronPort-AV: E=Sophos;i="6.21,321,1763452800"; 
   d="scan'208";a="73483067"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 16:01:01 -0800
X-CSE-ConnectionGUID: OIEckF6bTICfYk7DbX2nXg==
X-CSE-MsgGUID: wduQTRhORVi5JlTcBOQFZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,321,1763452800"; 
   d="scan'208";a="214967139"
Received: from dwillia2-desk.jf.intel.com ([10.88.27.145])
  by fmviesa006.fm.intel.com with ESMTP; 02 Mar 2026 16:01:01 -0800
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
Subject: [PATCH v2 19/19] tools/testing/devsec: Add basic evidence retrieval validation
Date: Mon,  2 Mar 2026 16:02:07 -0800
Message-ID: <20260303000207.1836586-20-dan.j.williams@intel.com>
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

Checkout basic operation of the pci-tsm-netlink ABI. The main complexity is
reassembly of single evidence payloads that span multiple messages.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 tools/testing/devsec/devsec.sh | 46 ++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/tools/testing/devsec/devsec.sh b/tools/testing/devsec/devsec.sh
index ce4a986b74dd..6a9313e7104f 100755
--- a/tools/testing/devsec/devsec.sh
+++ b/tools/testing/devsec/devsec.sh
@@ -126,6 +126,46 @@ ide_multi_test() {
 	done
 }
 
+check_evidence() {
+	pci_dev=$1
+
+	set +x
+
+	python3 tools/net/ynl/pyynl/cli.py --family pci-tsm --dump evidence-read \
+	--json "{\"type-mask\": 2047, \"dev-name\": \"$(basename $pci_dev)\", \"flags\": 0}" \
+	--output-json > json
+
+	# Coalesce multi-message payloads where the protocol is a tuple
+	# of (type, val) followed by one more (val) only messages.
+	objects=()
+	for obj in $(jq -c '.[]' json); do
+		if [[ $(echo $obj | jq -r 'has("type")') == "true" ]]; then
+			t=$(echo $obj | jq -r '.type')
+			val_len=$(echo $obj | jq -r '.val | length')
+			objects[$t]=$val_len
+		else
+			val_len=$(echo $obj | jq -r '.val | length')
+			objects[$t]=$((objects[$t] + val_len))
+		fi
+	done
+
+	# Check that all 11 objects (PCI_TSM_EVIDENCE_TYPE_MAX) were
+	# returned and only objects 0 and 9
+	# (PCI_TSM_EVIDENCE_TYPE_CERT0,
+	# PCI_TSM_EVIDENCE_TYPE_MEASUREMENTS) have a length of 8192 and
+	# the rest are empty.
+	[[ ${#objects[@]} -eq 11 ]] || err "$LINENO"
+	for i in ${!objects[@]}; do
+		if [[ $i == 0 || $i == 9 ]]; then
+			[[ ${objects[$i]} == 8192 ]] || err "$LINENO"
+		else
+			[[ ${objects[$i]} == 0 ]] || err "$LINENO"
+		fi
+	done
+
+	set -x
+}
+
 ide_test() {
 	pci_dev=${PCI_DEVS[$1]}
 	fn_dev=${FN_DEVS[$1]}
@@ -155,6 +195,8 @@ ide_test() {
 	dsm=$(cat $fn_dev/tsm/dsm)
 	[[ $dsm == $(basename $pci_dev) ]] || err "$LINENO"
 
+	check_evidence $pci_dev
+
 	# bind both functions and validate that they display bound to
 	# the TSM device
 	echo $(basename $pci_dev) > $tsm_link/device/tsm_bind
@@ -213,6 +255,10 @@ devsec_test() {
 	[[ -n $tsm_devsec ]] || err "$LINENO"
 	[[ -n $tsm_link ]] || err "$LINENO"
 
+	# initialize evidence payloads
+	dd if=/dev/zero of=/sys/bus/faux/devices/devsec_link_tsm/certs bs=4K count=1
+	dd if=/dev/zero of=/sys/bus/faux/devices/devsec_link_tsm/transcript bs=4K count=1
+
 	# check that devsec bus loads correctly and the TSM is detected
 	for i in ${!PCI_DEVS[@]}; do
 		pci_dev=${PCI_DEVS[$i]}
-- 
2.52.0


Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87331249EB;
	Thu,  3 Sep 2026 07:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788421973; cv=none; b=IOWs/07kkJvqDl2yJCJAhqmX97SHlDRdACNeYWeijV955gbf2oiWjIs5MEW8+BAPtpkTE38xFbTmlH6b6nps+46ZsoGLBBOs1VTDazLDgB9/CYuTCedRAfIqj0Mx8kezNWlr0swf7HNqKBHqlsH2ksmRZdKV/zBa0qyVMc5pDno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788421973; c=relaxed/simple;
	bh=BQP2zBWnYCCsoTeDrnoFy2n7VeQl+onPIrEEDiTZRZ8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UtpnOrBUl1rklMSPD0fBbDuFrUt65X6K8+M+BP8vulWdw+IRQviZblSG3mbzuZuAs9EOrqCB15xs3sydwARXsy2C5xL60EVsCFoSwpzBV71y/9Cgyd4oiHEuLPpT15Lnk6gflvrKFKT0x+s6ZfqjRlBraacw8AECRFqMbQrTNwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=HKc/iROH; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="HKc/iROH"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=RbPpVruGZHVlSY4PNTNDLhM5I+XecthtbwhAx301AmY=;
	b=HKc/iROH0y5/f6LQosv4tNU/fJ+jsKBO1EQARta2VM3PI8fCj/pBkO89zhh8wdW4xMY2W8UI+
	hhNpnJNW3pLIu4lWQdyXWTF5gwM853CAXY3/juJ1duHyrnzbZYhsSXIbLDbfZvX1yBJb/+gOZan
	rji1hNX64W0nmbK1B+EJpUY=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4hbBPf00czzcbNp;
	Thu,  3 Sep 2026 15:41:57 +0800 (CST)
Received: from whupemo200004.china.huawei.com (unknown [7.152.184.18])
	by mail.maildlp.com (Postfix) with ESMTPS id 5E1BD202E6;
	Thu,  3 Sep 2026 15:52:45 +0800 (CST)
Received: from huawei.com (10.50.163.32) by whupemo200004.china.huawei.com
 (7.152.184.18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 3 Sep
 2026 15:52:42 +0800
From: Sizhe Liu <liusizhe5@huawei.com>
To: <rostedt@goodmis.org>, <mhiramat@kernel.org>,
	<mathieu.desnoyers@efficios.com>, <corbet@lwn.net>,
	<skhan@linuxfoundation.org>, <bhelgaas@google.com>, <yangyccccc@gmail.com>,
	<jic23@kernel.org>, <john.g.garry@oracle.com>, <will@kernel.org>,
	<james.clark@linaro.org>, <mike.leach@arm.com>, <leo.yan@linux.dev>,
	<peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <wangyushan12@huawei.com>,
	<wuzongyu1@huawei.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-doc@vger.kernel.org>, <linuxarm@huawei.com>,
	<prime.zeng@hisilicon.com>, <liusizhe5@huawei.com>
Subject: [PATCH v3 0/8] Enhance TLP packet decoder with field-level parsing and versioning
Date: Thu, 3 Sep 2026 15:52:33 +0800
Message-ID: <20260903075241.1445338-1-liusizhe5@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 whupemo200004.china.huawei.com (7.152.184.18)

The original hisi-ptt-decoder only prints raw hex values with generic field
names for DW2/DW3, without classifying TLP types or decoding
DW2/DW3 fields according to the hardware-defined packet format.

This series enhances the HiSilicon PTT (PCIe Trace and Tuning) packet
decoder in perf tool to provide detailed field-level parsing of TLP headers
based on message type, and adds a versioning mechanism for backward
compatibility both in hisi_ptt driver and perf tool.

---
Changes in v3:
- Add explicit inclusion of <stdbool.h> (Sashiko).
- Make patch 07/08 apply cleanly to mainline (Yushan).
- Pick up the reviewed-by tag (Yushan).
- Link to v2: https://lore.kernel.org/linux-pci/20260827140442.2031128-1-liusizhe5@huawei.com/

Changes in v2:
- Split patch 01/10 and patch 02/10 from series v1 into independent patch
  series for backporting (Bjorn).
- Use bitwise operations instead of C bitfields for cross-platform cases
  (Sashiko).
- Add `pattern` parameter in hisi_ptt driver for layout compatibility.
- Link to v1: https://lore.kernel.org/linux-pci/20260604075005.2219785-1-liusizhe5@huawei.com/

---
Sizhe Liu (8):
  perf hisi-ptt: Abstract trace data buf and offset
  perf hisi-ptt: Complete the field names for 4DW and 8DW packets
  perf hisi-ptt: Extract the raw data printing part
  perf hisi-ptt: Merge 4DW and 8DW HEAD0 printing
  perf hisi-ptt: Add parsing of supported message types
  perf hisi-ptt: Add field-level parsing for header DW2/DW3
  hwtracing: hisi_ptt: Add pattern PMU config for trace format selection
  perf hisi-ptt: Pass pattern version to decoder for compatibility

 Documentation/trace/hisi-ptt.rst              |  25 +-
 drivers/hwtracing/ptt/hisi_ptt.c              |  25 +-
 drivers/hwtracing/ptt/hisi_ptt.h              |   4 +
 tools/perf/arch/arm64/util/hisi-ptt.c         |  18 ++
 .../hisi-ptt-decoder/hisi-ptt-pkt-decoder.c   | 291 ++++++++++++++----
 .../hisi-ptt-decoder/hisi-ptt-pkt-decoder.h   |  69 ++++-
 tools/perf/util/hisi-ptt.c                    |  51 +--
 tools/perf/util/hisi-ptt.h                    |   9 +-
 8 files changed, 405 insertions(+), 87 deletions(-)

-- 
2.33.0

